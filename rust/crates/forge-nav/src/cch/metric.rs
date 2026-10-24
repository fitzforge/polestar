//! A metric on a CCH: per input edge a cost (seconds × RUN, f64, +inf closed) and optionally
//! yards, customized into every CCH arc's upward (tail → head) and downward (head → tail) cost,
//! with the middle node of the lower triangle that gave it (path unpacking) and its yards.
//! Customization runs level by level up the elimination tree (nodes of one level write only their
//! own up-arcs and read only arcs of lower levels), in parallel. A partial customization
//! recomputes only the elimination-tree ancestors of the changed edges' arcs.

use crate::cch::structure::{Structure, A, INVALID};
use rayon::prelude::*;
use std::cell::RefCell;

pub struct Metric {
	pub fwd: Vec<f64>,
	pub bwd: Vec<f64>,
	pub mf: Vec<u32>,
	pub mb: Vec<u32>,
	/// Yards per arc and direction (f32: yards are reported, never compared); empty without.
	pub yf: Vec<f32>,
	pub yb: Vec<f32>,
	/// The input edges' costs and yards (kept for partial customization).
	pub w: Vec<f64>,
	pub yd: Vec<f32>,
}

struct Raw {
	fwd: *mut f64,
	bwd: *mut f64,
	mf: *mut u32,
	mb: *mut u32,
	yf: *mut f32,
	yb: *mut f32,
}
unsafe impl Send for Raw {}
unsafe impl Sync for Raw {}

thread_local! {
	static CACHE: RefCell<Vec<u32>> = const { RefCell::new(Vec::new()) };
}

/// Sets x's up-arcs from their input edges (the cheapest parallel edge each way).
unsafe fn init_node(s: &Structure, x: usize, m: &Metric, r: &Raw) {
	let ufo = s.a(A::UpFirstOut);
	let (fin, bin) = (s.a(A::FwdIn), s.a(A::BwdIn));
	let (ffe, efe) = (s.a(A::FirstExtraFwd), s.a(A::ExtraFwd));
	let (fbe, ebe) = (s.a(A::FirstExtraBwd), s.a(A::ExtraBwd));
	let has_yd = !m.yd.is_empty();
	for a in ufo[x] as usize..ufo[x + 1] as usize {
		for dir in 0..2 {
			let (first, extra_first, extra) = if dir == 0 { (fin[a], ffe, efe) } else { (bin[a], fbe, ebe) };
			let mut best = f64::INFINITY;
			let mut by = 0.0f32;
			let mut take = |e: u32| {
				if e == INVALID {
					return;
				}
				let w = m.w[e as usize];
				if w < best {
					best = w;
					by = if has_yd { m.yd[e as usize] } else { 0.0 };
				}
			};
			take(first);
			for k in extra_first[a] as usize..extra_first[a + 1] as usize {
				take(extra[k]);
			}
			if dir == 0 {
				*r.fwd.add(a) = best;
				*r.mf.add(a) = INVALID;
				if has_yd {
					*r.yf.add(a) = by;
				}
			} else {
				*r.bwd.add(a) = best;
				*r.mb.add(a) = INVALID;
				if has_yd {
					*r.yb.add(a) = by;
				}
			}
		}
	}
}

/// Relaxes every lower triangle under x's up-arcs (the `cch` crate's relax_node, in f64, keeping
/// the middle node and yards).
unsafe fn relax_node(s: &Structure, x: usize, cache: &mut [u32], r: &Raw, has_yd: bool) {
	let ufo = s.a(A::UpFirstOut);
	let uh = s.a(A::UpHead);
	let dfo = s.a(A::DownFirstOut);
	let dh = s.a(A::DownHead);
	let d2u = s.a(A::DownToUp);
	for a in ufo[x]..ufo[x + 1] {
		cache[uh[a as usize] as usize] = a;
	}
	for xy in dfo[x] as usize..dfo[x + 1] as usize {
		let bottom = d2u[xy] as usize;
		let y = dh[xy];
		let yb0 = ufo[y as usize] as usize;
		let mut cur = ufo[y as usize + 1] as usize;
		let bb = *r.bwd.add(bottom);
		let fb = *r.fwd.add(bottom);
		while cur > yb0 {
			cur -= 1;
			let z = uh[cur] as usize;
			if z <= x {
				break;
			}
			let top = cache[z] as usize;
			let cf = bb + *r.fwd.add(cur);
			if cf < *r.fwd.add(top) {
				*r.fwd.add(top) = cf;
				*r.mf.add(top) = y;
				if has_yd {
					*r.yf.add(top) = *r.yb.add(bottom) + *r.yf.add(cur);
				}
			}
			let cb = fb + *r.bwd.add(cur);
			if cb < *r.bwd.add(top) {
				*r.bwd.add(top) = cb;
				*r.mb.add(top) = y;
				if has_yd {
					*r.yb.add(top) = *r.yf.add(bottom) + *r.yb.add(cur);
				}
			}
		}
	}
}

/// One worker's share of a big node's triangles: the best per up-arc of x over a range of its
/// down-arcs (cost, middle, yards; each direction).
struct Part {
	f: Vec<f64>,
	b: Vec<f64>,
	mf: Vec<u32>,
	mb: Vec<u32>,
	yf: Vec<f32>,
	yb: Vec<f32>,
}

/// relax_node over down-arcs [lo, hi) of x into a Part indexed by x's up-arc - first up-arc.
unsafe fn relax_part(s: &Structure, x: usize, lo: usize, hi: usize, r: &Raw, has_yd: bool) -> Part {
	let ufo = s.a(A::UpFirstOut);
	let uh = s.a(A::UpHead);
	let dh = s.a(A::DownHead);
	let d2u = s.a(A::DownToUp);
	let a0 = ufo[x] as usize;
	let deg = ufo[x + 1] as usize - a0;
	let mut p = Part {
		f: vec![f64::INFINITY; deg],
		b: vec![f64::INFINITY; deg],
		mf: vec![INVALID; deg],
		mb: vec![INVALID; deg],
		yf: vec![0.0; if has_yd { deg } else { 0 }],
		yb: vec![0.0; if has_yd { deg } else { 0 }],
	};
	CACHE.with(|c| {
		let mut cache = c.borrow_mut();
		if cache.len() < s.node_count {
			cache.resize(s.node_count, 0);
		}
		for a in a0..a0 + deg {
			cache[uh[a] as usize] = (a - a0) as u32;
		}
		for xy in lo..hi {
			let bottom = d2u[xy] as usize;
			let y = dh[xy];
			let yb0 = ufo[y as usize] as usize;
			let mut cur = ufo[y as usize + 1] as usize;
			let bb = *r.bwd.add(bottom);
			let fb = *r.fwd.add(bottom);
			while cur > yb0 {
				cur -= 1;
				let z = uh[cur] as usize;
				if z <= x {
					break;
				}
				let i = cache[z] as usize;
				let cf = bb + *r.fwd.add(cur);
				if cf < p.f[i] {
					p.f[i] = cf;
					p.mf[i] = y;
					if has_yd {
						p.yf[i] = *r.yb.add(bottom) + *r.yf.add(cur);
					}
				}
				let cb = fb + *r.bwd.add(cur);
				if cb < p.b[i] {
					p.b[i] = cb;
					p.mb[i] = y;
					if has_yd {
						p.yb[i] = *r.yf.add(bottom) + *r.yb.add(cur);
					}
				}
			}
		}
	});
	p
}

/// relax_node for a node with many down-arcs: its down-arcs split over the pool's threads, the
/// parts merged in order (the first strict minimum wins, as in relax_node).
unsafe fn relax_node_par(s: &Structure, x: usize, r: &Raw, has_yd: bool) {
	let ufo = s.a(A::UpFirstOut);
	let dfo = s.a(A::DownFirstOut);
	let a0 = ufo[x] as usize;
	let (lo, hi) = (dfo[x] as usize, dfo[x + 1] as usize);
	let chunk = ((hi - lo) / (4 * rayon::current_num_threads()).max(1)).max(16);
	let ranges: Vec<(usize, usize)> = (lo..hi).step_by(chunk).map(|b| (b, (b + chunk).min(hi))).collect();
	let parts: Vec<Part> = ranges.par_iter().map(|&(b, e)| relax_part(s, x, b, e, r, has_yd)).collect();
	for p in &parts {
		for i in 0..p.f.len() {
			let a = a0 + i;
			if p.f[i] < *r.fwd.add(a) {
				*r.fwd.add(a) = p.f[i];
				*r.mf.add(a) = p.mf[i];
				if has_yd {
					*r.yf.add(a) = p.yf[i];
				}
			}
			if p.b[i] < *r.bwd.add(a) {
				*r.bwd.add(a) = p.b[i];
				*r.mb.add(a) = p.mb[i];
				if has_yd {
					*r.yb.add(a) = p.yb[i];
				}
			}
		}
	}
}

/// Recomputes x's up-arcs: from their input edges, then every lower triangle.
unsafe fn node(s: &Structure, x: usize, m: &Metric, r: &Raw, has_yd: bool, parallel: bool) {
	init_node(s, x, m, r);
	let dfo = s.a(A::DownFirstOut);
	if parallel && (dfo[x + 1] - dfo[x]) as usize >= BIG {
		relax_node_par(s, x, r, has_yd);
	} else {
		with_cache(s.node_count, |cache| relax_node(s, x, cache, r, has_yd));
	}
}

/// Down-arcs from which a node's triangles are split over threads.
const BIG: usize = 256;

fn with_cache<F: FnOnce(&mut [u32])>(n: usize, f: F) {
	CACHE.with(|c| {
		let mut c = c.borrow_mut();
		if c.len() < n {
			c.resize(n, 0);
		}
		f(&mut c[..]);
	});
}

impl Metric {
	fn raw(&mut self) -> Raw {
		Raw { fwd: self.fwd.as_mut_ptr(), bwd: self.bwd.as_mut_ptr(), mf: self.mf.as_mut_ptr(), mb: self.mb.as_mut_ptr(), yf: self.yf.as_mut_ptr(), yb: self.yb.as_mut_ptr() }
	}

	/// Customizes `s` with input costs `w` (and yards `yd`, or empty).
	pub fn customize(s: &Structure, w: Vec<f64>, yd: Vec<f32>) -> Metric {
		assert_eq!(w.len(), s.input_arcs, "weights must have one entry per graph edge");
		assert!(yd.is_empty() || yd.len() == s.input_arcs, "yards must be empty or one per graph edge");
		let m = s.arc_count;
		let has_yd = !yd.is_empty();
		let mut out = Metric {
			fwd: vec![f64::INFINITY; m],
			bwd: vec![f64::INFINITY; m],
			mf: vec![INVALID; m],
			mb: vec![INVALID; m],
			yf: if has_yd { vec![0.0; m] } else { Vec::new() },
			yb: if has_yd { vec![0.0; m] } else { Vec::new() },
			w,
			yd,
		};
		let raw = out.raw();
		let ln = s.a(A::LevelNodes);
		let lf = s.a(A::LevelFirst);
		let me = &out;
		for l in 0..lf.len() - 1 {
			let nodes = &ln[lf[l] as usize..lf[l + 1] as usize];
			if nodes.len() >= 64 {
				nodes.par_iter().with_min_len(16).for_each(|&x| unsafe { node(s, x as usize, me, &raw, has_yd, false) });
			} else {
				nodes.iter().for_each(|&x| unsafe { node(s, x as usize, me, &raw, has_yd, true) });
			}
		}
		out
	}

	/// Partial customization: input edges `edges` now cost `w` (yards `yd`, or empty to keep
	/// theirs). Returns the number of nodes whose arcs were recomputed.
	pub fn update(&mut self, s: &Structure, edges: &[u32], w: &[f64], yd: &[f32]) -> usize {
		let i2c = s.a(A::InputToCch);
		let tail = s.a(A::UpTail);
		let parent = s.a(A::ElimParent);
		let mut mark = vec![false; s.node_count];
		let mut todo = Vec::new();
		for (i, &e) in edges.iter().enumerate() {
			self.w[e as usize] = w[i];
			if !yd.is_empty() && !self.yd.is_empty() {
				self.yd[e as usize] = yd[i];
			}
			let a = i2c[e as usize];
			if a == INVALID {
				continue;
			}
			let mut x = tail[a as usize];
			while x != INVALID && !mark[x as usize] {
				mark[x as usize] = true;
				todo.push(x);
				x = parent[x as usize];
			}
		}
		todo.sort_unstable();
		let has_yd = !self.yd.is_empty();
		let raw = self.raw();
		let me = &*self;
		for &x in &todo {
			unsafe { node(s, x as usize, me, &raw, has_yd, true) };
		}
		todo.len()
	}

	pub fn bytes(&self) -> usize {
		8 * (self.fwd.len() + self.bwd.len() + self.w.len()) + 4 * (self.mf.len() + self.mb.len() + self.yf.len() + self.yb.len() + self.yd.len())
	}
}
