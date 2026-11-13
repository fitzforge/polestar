//! One cluster of the in-game walking maps (maps format 5) read back from the fields `forge nav pack --leffe` writes
//! (grid, height, floor columns, class, area, arc, graph), as Routing/PathGrid.lua decodes them, with Routing/Path.lua's
//! grid search over it: what the router can walk inside the cluster, and its entrances. pack/joins.rs reads clusters
//! through it, edits them (a floor added after its cell's floors, arcs, entrances and their edges) and writes them back.
//!
//! The base cells (grid and height fields) are never edited: their strings are kept as written.

use super::encode::{encode_areas, run_length, COST_MAX, YARDS_MAX};
use super::{b32, enc, js_round, mult, zigzag, B64, PROFILES};
use std::cmp::Ordering;
use std::collections::{BTreeMap, BinaryHeap};

/// PathGrid.lua's directions: +x, -x, +y, -y, +x+y, +x-y, -x+y, -x-y (x north, y west).
pub const DX: [i64; 8] = [1, -1, 0, 0, 1, 1, -1, -1];
pub const DY: [i64; 8] = [0, 0, 1, -1, 1, -1, 1, -1];
pub const OPPOSITE: [usize; 8] = [1, 0, 3, 2, 7, 6, 5, 4];
/// A graph edge record's cluster offset for an edge inside its own cluster ((dx + 1) * 3 + dy + 1).
pub const HERE: u32 = 4;

fn sym(b: u8) -> Result<u32, String> {
	B64.iter().position(|&c| c == b).map(|p| p as u32).ok_or_else(|| format!("ingame: symbol {b} off the alphabet"))
}

/// A fixed-width base64 number at i (PathGrid.lua num).
fn num(s: &[u8], i: usize, w: usize) -> Result<u32, String> {
	let mut v = 0u32;
	for j in 0..w {
		v = v * 64 + sym(*s.get(i + j).ok_or("ingame: field ends early")?)?;
	}
	Ok(v)
}

/// A column number at i (PathGrid.lua b32) -> (value, the position after it).
fn rb32(s: &[u8], mut i: usize) -> Result<(u64, usize), String> {
	let (mut value, mut scale) = (0u64, 1u64);
	loop {
		let v = sym(*s.get(i).ok_or("ingame: column ends early")?)? as u64;
		i += 1;
		if v < 32 {
			return Ok((value + v * scale, i));
		}
		value += (v - 32) * scale;
		scale *= 32;
	}
}

fn unzig(v: u64) -> i64 {
	if v.is_multiple_of(2) {
		(v / 2) as i64
	} else {
		-(v.div_ceil(2) as i64)
	}
}

/// A move of a node besides its base steps and step mask (PathGrid.lua's move list).
#[derive(Clone, Copy, Debug, PartialEq)]
enum Mv {
	/// A step in direction d to layer (0 the base surface, i the ith floor up, -1 the surface nearest the height).
	Step(u8, i32),
	/// A one-way arc to a node, yards * 4.
	Arc(u32, u32),
	/// The same arc backwards at its end, for a search out of a goal.
	Back(u32, u32),
}

/// An entrance's edge (the graph field's format 2 record): cluster offset, the entrance there, the costs for
/// Alliance, Horde and no profile, the yards.
#[derive(Clone, Debug, PartialEq)]
pub struct Edge {
	pub off: u32,
	pub ent: u32,
	pub cost: [u32; 3],
	pub yards: u32,
}

/// An entrance row of the graph field: its cell and layer, its component, its edges.
#[derive(Clone, Debug, PartialEq)]
pub struct Row {
	pub cell: u32,
	pub layer: u32,
	pub comp: u32,
	pub edges: Vec<Edge>,
}

/// The graph field: n(2) | n x [cell(3) layer(1) component(2) degree(1)] | each row's edges in row order, each
/// offset(1) entrance(2) costAlliance(3) costHorde(3) costNone(3) yards(2) (PathGrid.lua edges, edgeValue).
pub fn decode_graph(s: &str) -> Result<Vec<Row>, String> {
	let b = s.as_bytes();
	let n = num(b, 0, 2)? as usize;
	let mut rows = Vec::with_capacity(n);
	let mut degree = Vec::with_capacity(n);
	for r in 0..n {
		let p = 2 + r * 7;
		rows.push(Row { cell: num(b, p, 3)?, layer: num(b, p + 3, 1)?, comp: num(b, p + 4, 2)?, edges: Vec::new() });
		degree.push(num(b, p + 6, 1)? as usize);
	}
	let mut p = 2 + n * 7;
	for (r, row) in rows.iter_mut().enumerate() {
		for _ in 0..degree[r] {
			row.edges.push(Edge { off: num(b, p, 1)?, ent: num(b, p + 1, 2)?, cost: [num(b, p + 3, 3)?, num(b, p + 6, 3)?, num(b, p + 9, 3)?], yards: num(b, p + 12, 2)? });
			p += 14;
		}
	}
	if p != b.len() {
		return Err(format!("ingame: graph field has {} symbols past its edges", b.len() - p));
	}
	Ok(rows)
}

/// The graph field of rows (decode_graph's layout).
pub fn encode_graph(rows: &[Row]) -> Result<String, String> {
	let mut out = enc(rows.len() as f64, 2)?;
	let mut edges = String::new();
	for r in rows {
		out.push_str(&enc(r.cell as f64, 3)?);
		out.push_str(&enc(r.layer as f64, 1)?);
		out.push_str(&enc(r.comp.min(4095) as f64, 2)?);
		out.push_str(&enc(r.edges.len() as f64, 1)?);
		for e in &r.edges {
			edges.push_str(&enc(e.off as f64, 1)?);
			edges.push_str(&enc(e.ent as f64, 2)?);
			for c in e.cost {
				edges.push_str(&enc(c as f64, 3)?);
			}
			edges.push_str(&enc(e.yards as f64, 2)?);
		}
	}
	out.push_str(&edges);
	Ok(out)
}

/// A decoded cluster: T = N + F nodes, the N = c * c base cells then the F floors in cell order.
#[derive(Clone, Debug)]
pub struct Cluster {
	pub c: usize,
	/// The cell size (yd).
	pub cs: f64,
	/// The grid and height fields as written.
	pub grid: String,
	pub height: String,
	/// Per base cell the open moves (PathGrid.lua mv: 1 +x, 2 +y, 4 +x+y, 8 +x-y, over the data flags * 16).
	mv: Vec<u8>,
	/// Per node: value (0 blocked, 1 ground, 2 water; a floor's up to 4), height (yd), class byte, area row.
	pub val: Vec<u8>,
	pub z: Vec<f64>,
	pub cls: Vec<u8>,
	pub area: Vec<u32>,
	/// Per floor (node - N): its local cell, and its steps (the floor field's 2 symbols; the low 8 bits step to the
	/// surface nearest its height on the neighbour in each direction).
	pub at: Vec<u32>,
	pub steps: Vec<u32>,
	/// The floor field's explicit links: (node, direction, layer), as written.
	pub links: Vec<(u32, u8, u8)>,
	/// One-way arcs (from, to) -> yards * 4.
	pub arcs: BTreeMap<(u32, u32), u32>,
	// Derived by `index`: per cell its first floor node and count; per node its step mask and other moves.
	first: Vec<u32>,
	count: Vec<u8>,
	lm: Vec<u8>,
	xs: Vec<Vec<Mv>>,
}

impl Cluster {
	/// Decode a cluster's written fields. c cells a side, cs yd a cell, zstep the base heights' step.
	#[allow(clippy::too_many_arguments)]
	pub fn decode(c: usize, cs: f64, zstep: f64, grid: &str, height: &str, floor: Option<&str>, class: Option<&str>, area: Option<&str>, arc: Option<&str>) -> Result<Cluster, String> {
		let n = c * c;
		// grid: per cell value * 16 + data flags, run-length (a symbol >= 48 repeats the previous (symbol - 47) more times)
		let (mut val, mut m) = (Vec::with_capacity(n), Vec::with_capacity(n));
		let (mut vc, mut mc) = (0u8, 0u8);
		for &ch in grid.as_bytes() {
			let s = sym(ch)?;
			if s < 48 {
				vc = (s / 16) as u8;
				mc = ((s % 16) * 16) as u8;
				val.push(vc);
				m.push(mc);
			} else {
				for _ in 48..=s {
					val.push(vc);
					m.push(mc);
				}
			}
		}
		if val.len() != n {
			return Err(format!("ingame: grid holds {} cells, not {n}", val.len()));
		}
		// Open moves, descending so the diagonals read their forward neighbours' (PathGrid.lua decodeGrid).
		for a in (0..n).rev() {
			let ly = a % c;
			let f = m[a] / 16;
			if val[a] != 0 {
				if a + c < n && val[a + c] != 0 && f.is_multiple_of(2) {
					m[a] += 1;
				}
				if ly < c - 1 && val[a + 1] != 0 && f % 4 < 2 {
					m[a] += 2;
				}
			}
			if a + c < n && val[a] != 0 {
				if ly < c - 1 && val[a + c + 1] != 0 && ((m[a] % 2 == 1 && m[a + c] % 4 >= 2) || (m[a] % 4 >= 2 && m[a + 1] % 2 == 1) || f % 8 >= 4) {
					m[a] += 4;
				}
				if ly > 0 && val[a + c - 1] != 0 && ((m[a] % 2 == 1 && m[a + c - 1] % 4 >= 2) || (val[a - 1] != 0 && m[a - 1] % 64 < 32 && m[a - 1] % 32 < 16) || f >= 8) {
					m[a] += 8;
				}
			}
		}
		// heights (PathGrid.lua decodeHeights)
		let hb = height.as_bytes();
		let mut z = vec![f64::NAN; n];
		let (mut pos, mut rep, mut delta, mut last) = (0usize, 0i64, 0i64, 0i64);
		for i in 0..n {
			if val[i] == 0 {
				continue;
			}
			let pred = if i % c > 0 && val[i - 1] != 0 {
				(z[i - 1] / zstep) as i64
			} else if i >= c && val[i - c] != 0 {
				(z[i - c] / zstep) as i64
			} else {
				last
			};
			let v;
			if rep > 0 {
				rep -= 1;
				v = pred + delta;
			} else {
				let s = sym(*hb.get(pos).ok_or("ingame: height field ends early")?)? as i64;
				if s == 47 {
					v = num(hb, pos + 1, 2)? as i64 - 2048;
					pos += 3;
				} else {
					delta = s - 23;
					pos += 1;
					while pos < hb.len() && sym(hb[pos])? >= 48 {
						rep += sym(hb[pos])? as i64 - 47;
						pos += 1;
					}
					v = pred + delta;
				}
			}
			last = v;
			z[i] = v as f64 * zstep;
		}
		let mut cl = Cluster {
			c,
			cs,
			grid: grid.to_string(),
			height: height.to_string(),
			mv: m,
			val,
			z,
			cls: Vec::new(),
			area: Vec::new(),
			at: Vec::new(),
			steps: Vec::new(),
			links: Vec::new(),
			arcs: BTreeMap::new(),
			first: Vec::new(),
			count: Vec::new(),
			lm: Vec::new(),
			xs: Vec::new(),
		};
		if let Some(f) = floor {
			cl.read_floors(f.as_bytes())?;
		}
		let t = cl.val.len();
		cl.cls = vec![0; t];
		if let Some(s) = class {
			let mut i = 0;
			let mut value = 0u8;
			for &ch in s.as_bytes() {
				let v = sym(ch)?;
				let reps = if v < 48 {
					value = v as u8;
					1
				} else {
					v - 47
				};
				for _ in 0..reps {
					if i < t {
						cl.cls[i] = value;
					}
					i += 1;
				}
			}
		}
		cl.area = vec![0; t];
		if let Some(s) = area {
			let b = s.as_bytes();
			let (mut i, mut p, mut value) = (0usize, 0usize, 0u32);
			while p < b.len() {
				let v = sym(b[p])?;
				let reps = if v < 48 {
					value = num(b, p, 3)?;
					p += 3;
					1
				} else {
					p += 1;
					v - 47
				};
				for _ in 0..reps {
					if i < t {
						cl.area[i] = value;
					}
					i += 1;
				}
			}
		}
		if let Some(s) = arc {
			let b = s.as_bytes();
			let (n, mut p) = rb32(b, 0)?;
			let mut from = Vec::with_capacity(n as usize);
			let mut a = 0u64;
			for _ in 0..n {
				let (g, q) = rb32(b, p)?;
				p = q;
				a += g;
				from.push(a as i64);
			}
			let mut to = Vec::with_capacity(n as usize);
			for &f in &from {
				let (d, q) = rb32(b, p)?;
				p = q;
				to.push(f + unzig(d));
			}
			for i in 0..n as usize {
				let (y, q) = rb32(b, p)?;
				p = q;
				cl.arcs.insert((from[i] as u32, to[i] as u32), y as u32);
			}
		}
		cl.index();
		Ok(cl)
	}

	/// The floor field (maps format 5's columns, PathGrid.lua floorColumns).
	fn read_floors(&mut self, s: &[u8]) -> Result<(), String> {
		let (n, mut pos) = rb32(s, 0)?;
		let mut cells = Vec::with_capacity(n as usize);
		let mut lc = -1i64;
		for _ in 0..n {
			let (g, q) = rb32(s, pos)?;
			pos = q;
			lc += g as i64 + 1;
			cells.push(lc as u32);
		}
		let counts = pos;
		let mut floors = 0usize;
		for i in 0..n as usize {
			floors += sym(s[counts + i])? as usize;
		}
		let values = counts + n as usize;
		pos = values + floors;
		let mut first = 0i64;
		let mut node = 0usize;
		for (i, &lc) in cells.iter().enumerate() {
			let mut below = first;
			for j in 0..sym(s[counts + i])? {
				let (d, q) = rb32(s, pos)?;
				pos = q;
				below += unzig(d);
				if j == 0 {
					first = below;
				}
				self.val.push(sym(s[values + node])? as u8);
				self.z.push(below as f64);
				self.at.push(lc);
				node += 1;
			}
		}
		for f in 0..floors {
			self.steps.push(num(s, pos + 2 * f, 2)?);
		}
		let (m, mut p) = rb32(s, pos + 2 * floors)?;
		let mut u = 0i64;
		let mut nodes = Vec::with_capacity(m as usize);
		for _ in 0..m {
			let (d, q) = rb32(s, p)?;
			p = q;
			u += unzig(d);
			nodes.push(u as u32);
		}
		for (i, &u) in nodes.iter().enumerate() {
			self.links.push((u, sym(s[p + i])? as u8, sym(s[p + m as usize + i])? as u8));
		}
		if p + 2 * m as usize != s.len() {
			return Err(format!("ingame: floor field has {} symbols past its links", s.len() as i64 - (p + 2 * m as usize) as i64));
		}
		Ok(())
	}

	pub fn n(&self) -> usize {
		self.c * self.c
	}

	pub fn t(&self) -> usize {
		self.val.len()
	}

	/// A node's local cell.
	pub fn cell(&self, node: usize) -> usize {
		if node < self.n() {
			node
		} else {
			self.at[node - self.n()] as usize
		}
	}

	/// A floor's layer in its cell (1 the first), 0 for a base cell.
	pub fn layer(&self, node: usize) -> u32 {
		if node < self.n() {
			0
		} else {
			(node - self.first[self.cell(node)] as usize + 1) as u32
		}
	}

	/// Local cell lc's floors: the first's node and the count.
	pub fn floors_of(&self, lc: usize) -> (usize, usize) {
		(self.first[lc] as usize, self.count[lc] as usize)
	}

	/// The per-cell floor runs, step masks and move lists, after decoding or an edit (PathGrid.lua decodeGrid's
	/// second half: a base cell steps back to a floor whose step mask or explicit link lands on it).
	pub fn index(&mut self) {
		let (n, t) = (self.n(), self.t());
		self.first = vec![u32::MAX; n];
		self.count = vec![0; n];
		for f in n..t {
			let lc = self.at[f - n] as usize;
			if self.first[lc] == u32::MAX {
				self.first[lc] = f as u32;
			}
			self.count[lc] = (self.count[lc] + 1).min(63);
		}
		self.lm = vec![0; t];
		for f in n..t {
			self.lm[f] = (self.steps[f - n] % 256) as u8;
		}
		// (gathered first, then put in: the searches below read the cluster as it stands)
		let mut moves: Vec<(usize, Mv)> = Vec::new();
		for &(u, d, layer) in &self.links {
			// (an explicit link's layer is never -1: it joins the step mask only through the floors' own steps)
			moves.push((u as usize, Mv::Step(d, layer as i32)));
		}
		let c = self.c as i64;
		for f in n..t {
			let lc = self.cell(f) as i64;
			let layer = self.layer(f) as i32;
			for d in 0..8 {
				if self.lm[f] >> d & 1 == 0 {
					continue;
				}
				let (tx, ty) = (lc / c + DX[d], lc % c + DY[d]);
				if tx >= 0 && ty >= 0 && tx < c && ty < c {
					if let Some(b) = self.surface((tx * c + ty) as usize, -1, self.z[f]) {
						if b < n {
							moves.push((b, Mv::Step(OPPOSITE[d] as u8, layer)));
						}
					}
				}
			}
		}
		for &(u, d, layer) in &self.links {
			let u = u as usize;
			if u < n {
				continue;
			}
			let lc = self.cell(u) as i64;
			let d = d as usize;
			let (tx, ty) = (lc / c + DX[d], lc % c + DY[d]);
			if tx >= 0 && ty >= 0 && tx < c && ty < c {
				if let Some(b) = self.surface((tx * c + ty) as usize, layer as i32, self.z[u]) {
					if b < n {
						moves.push((b, Mv::Step(OPPOSITE[d] as u8, self.layer(u) as i32)));
					}
				}
			}
		}
		for (&(a, b), &y) in &self.arcs {
			moves.push((a as usize, Mv::Arc(b, y)));
			moves.push((b as usize, Mv::Back(a, y)));
		}
		self.xs = vec![Vec::new(); t];
		for (u, m) in moves {
			self.xs[u].push(m);
		}
	}

	/// The node of local cell lc for a layer (0 the base surface, i the ith floor up, -1 the surface nearest height h;
	/// PathGrid.lua surface).
	pub fn surface(&self, lc: usize, layer: i32, h: f64) -> Option<usize> {
		let (f0, count) = (self.first[lc], self.count[lc] as usize);
		if layer == 0 {
			return (self.val[lc] != 0).then_some(lc);
		}
		if layer > 0 {
			return (f0 != u32::MAX && (layer as usize) <= count).then(|| f0 as usize + layer as usize - 1);
		}
		let mut best: Option<(usize, f64)> = (self.val[lc] != 0).then(|| (lc, (self.z[lc] - h).abs()));
		if f0 != u32::MAX {
			for node in f0 as usize..f0 as usize + count {
				let g = (self.z[node] - h).abs();
				if best.is_none_or(|b| g < b.1) {
					best = Some((node, g));
				}
			}
		}
		best.map(|b| b.0)
	}

	/// Every node a search steps to from u, and the step's length in cells (Path.lua search: the base cell's moves,
	/// the steps of its mask to the neighbour's surface nearest its height, its other moves); back: a search out of a
	/// goal, stepping along arcs backwards.
	pub fn moves(&self, u: usize, back: bool, out: &mut Vec<(usize, f64)>) {
		out.clear();
		let (n, c) = (self.n(), self.c);
		let lc = self.cell(u);
		let (ux, uy) = (lc / c, lc % c);
		let s2 = std::f64::consts::SQRT_2;
		if u < n {
			let mi = self.mv[u] % 16;
			let ml = if uy > 0 { self.mv[u - 1] } else { 0 };
			let (mxm, mx0, mxp) = (if ux > 0 && uy > 0 { self.mv[u - c - 1] } else { 0 }, if ux > 0 { self.mv[u - c] } else { 0 }, if ux > 0 { self.mv[u - c + 1] } else { 0 });
			if mi % 2 == 1 {
				out.push((u + c, 1.0));
			}
			if ux > 0 && mx0 % 2 == 1 {
				out.push((u - c, 1.0));
			}
			if mi % 4 >= 2 {
				out.push((u + 1, 1.0));
			}
			if uy > 0 && ml % 4 >= 2 {
				out.push((u - 1, 1.0));
			}
			if mi % 8 >= 4 {
				out.push((u + c + 1, s2));
			}
			if mi >= 8 {
				out.push((u + c - 1, s2));
			}
			if ux > 0 && uy > 0 && mxm % 8 >= 4 {
				out.push((u - c - 1, s2));
			}
			if ux > 0 && uy < c - 1 && mxp % 16 >= 8 {
				out.push((u - c + 1, s2));
			}
		}
		let zu = self.z[u];
		let step = |d: usize| if d >= 4 { s2 } else { 1.0 };
		for d in 0..8 {
			if self.lm[u] >> d & 1 == 0 {
				continue;
			}
			let (tx, ty) = (ux as i64 + DX[d], uy as i64 + DY[d]);
			if tx >= 0 && ty >= 0 && tx < c as i64 && ty < c as i64 {
				if let Some(v) = self.surface(tx as usize * c + ty as usize, -1, zu) {
					out.push((v, step(d)));
				}
			}
		}
		for &mv in &self.xs[u] {
			match mv {
				Mv::Step(d, layer) => {
					let d = d as usize;
					let (tx, ty) = (ux as i64 + DX[d], uy as i64 + DY[d]);
					if tx >= 0 && ty >= 0 && tx < c as i64 && ty < c as i64 {
						if let Some(v) = self.surface(tx as usize * c + ty as usize, layer, zu) {
							out.push((v, step(d)));
						}
					}
				}
				Mv::Arc(to, y) if !back => out.push((to as usize, y as f64 / (4.0 * self.cs))),
				Mv::Back(from, y) if back => out.push((from as usize, y as f64 / (4.0 * self.cs))),
				_ => {}
			}
		}
	}

	/// A step's cost into node v for profile p (PROFILES' index) at the swim factor: its length (cells) * cs * the
	/// class multiplier, times swim in water (Path.lua search's relax, Balanced).
	pub fn step_cost(&self, v: usize, length: f64, p: usize, swim: f64) -> f64 {
		length * self.cs * mult(self.cls[v], PROFILES[p]) * if self.val[v] == 2 { swim } else { 1.0 }
	}

	/// Dijkstra over the cluster from sources (node, cost, yards) for profile p: every node's cost and yards along
	/// its cost-best path (INFINITY: unreached). back: a search out of a goal.
	pub fn dijkstra(&self, sources: &[(usize, f64, f64)], p: usize, swim: f64, back: bool) -> (Vec<f64>, Vec<f64>) {
		#[derive(PartialEq)]
		struct Open(f64, usize);
		impl Eq for Open {}
		impl PartialOrd for Open {
			fn partial_cmp(&self, o: &Self) -> Option<Ordering> {
				Some(self.cmp(o))
			}
		}
		impl Ord for Open {
			fn cmp(&self, o: &Self) -> Ordering {
				o.0.total_cmp(&self.0).then(o.1.cmp(&self.1))
			}
		}
		let t = self.t();
		let (mut g, mut y) = (vec![f64::INFINITY; t], vec![f64::INFINITY; t]);
		let mut done = vec![false; t];
		let mut heap = BinaryHeap::new();
		for &(s, c, yd) in sources {
			if c < g[s] {
				g[s] = c;
				y[s] = yd;
				heap.push(Open(c, s));
			}
		}
		let mut out = Vec::new();
		while let Some(Open(c, u)) = heap.pop() {
			if done[u] || c > g[u] {
				continue;
			}
			done[u] = true;
			self.moves(u, back, &mut out);
			for &(v, len) in &out {
				let gv = c + self.step_cost(v, len, p, swim);
				if gv < g[v] {
					g[v] = gv;
					y[v] = y[u] + len * self.cs;
					heap.push(Open(gv, v));
				}
			}
		}
		(g, y)
	}

	/// The nodes a search from source reaches for at most `limit` (profile p, forward), with their costs.
	pub fn bounded(&self, source: usize, limit: f64, p: usize, swim: f64) -> rustc_hash::FxHashMap<usize, f64> {
		let mut g: rustc_hash::FxHashMap<usize, f64> = rustc_hash::FxHashMap::default();
		let mut heap: BinaryHeap<(std::cmp::Reverse<u64>, usize)> = BinaryHeap::new();
		g.insert(source, 0.0);
		heap.push((std::cmp::Reverse(0f64.to_bits()), source));
		let mut out = Vec::new();
		let mut done = rustc_hash::FxHashSet::default();
		while let Some((std::cmp::Reverse(bits), u)) = heap.pop() {
			let c = f64::from_bits(bits);
			if !done.insert(u) {
				continue;
			}
			self.moves(u, false, &mut out);
			for &(v, len) in &out {
				let gv = c + self.step_cost(v, len, p, swim);
				if gv <= limit && g.get(&v).is_none_or(|&old| gv < old) {
					g.insert(v, gv);
					heap.push((std::cmp::Reverse(gv.to_bits()), v));
				}
			}
		}
		g
	}

	/// Adds a floor to local cell lc after its floors (so every entrance's layer stays), and returns its node. Every
	/// node after it moves up one: the links and arcs follow.
	pub fn add_floor(&mut self, lc: usize, val: u8, z: f64, cls: u8, area: u32) -> usize {
		let n = self.n();
		let at = self.at.iter().position(|&a| a as usize > lc).map_or(self.t(), |i| n + i);
		let shift = |v: u32| if v as usize >= at { v + 1 } else { v };
		for l in &mut self.links {
			l.0 = shift(l.0);
		}
		self.arcs = std::mem::take(&mut self.arcs).into_iter().map(|((a, b), y)| ((shift(a), shift(b)), y)).collect();
		self.val.insert(at, val);
		self.z.insert(at, z.round());
		self.cls.insert(at, cls);
		self.area.insert(at, area);
		self.at.insert(at - n, lc as u32);
		self.steps.insert(at - n, 0);
		self.index();
		at
	}

	/// Adds the one-way arc a -> b (the shorter, when there is one).
	pub fn add_arc(&mut self, a: usize, b: usize, yards: f64) {
		let y = js_round(yards * 4.0).clamp(1.0, YARDS_MAX) as u32;
		let e = self.arcs.entry((a as u32, b as u32)).or_insert(y);
		if y < *e {
			*e = y;
		}
		self.index();
	}

	/// The floor field (maps format 5's columns; pack/leffe.rs floor_columns' layout), None without floors or links.
	pub fn floor_field(&self) -> Result<Option<String>, String> {
		let n = self.n();
		if self.t() == n && self.links.is_empty() {
			return Ok(None);
		}
		let mut cells: Vec<(usize, Vec<usize>)> = Vec::new();
		for f in n..self.t() {
			let lc = self.cell(f);
			match cells.last_mut() {
				Some((c, v)) if *c == lc => v.push(f),
				_ => cells.push((lc, vec![f])),
			}
		}
		let mut out = String::new();
		b32(cells.len() as u64, &mut out);
		let mut last = -1i64;
		for (lc, _) in &cells {
			b32((*lc as i64 - last - 1) as u64, &mut out);
			last = *lc as i64;
		}
		for (_, fl) in &cells {
			out.push_str(&enc(fl.len() as f64, 1)?);
		}
		for (_, fl) in &cells {
			for &f in fl {
				out.push_str(&enc(self.val[f] as f64, 1)?);
			}
		}
		let mut first = 0i64;
		for (_, fl) in &cells {
			let mut below = first;
			for (i, &f) in fl.iter().enumerate() {
				let z = self.z[f] as i64;
				b32(zigzag(z - below), &mut out);
				if i == 0 {
					first = z;
				}
				below = z;
			}
		}
		for (_, fl) in &cells {
			for &f in fl {
				out.push_str(&enc(self.steps[f - n] as f64, 2)?);
			}
		}
		b32(self.links.len() as u64, &mut out);
		let mut prev = 0i64;
		for &(u, _, _) in &self.links {
			b32(zigzag(u as i64 - prev), &mut out);
			prev = u as i64;
		}
		for &(_, d, _) in &self.links {
			out.push_str(&enc(d as f64, 1)?);
		}
		for &(_, _, layer) in &self.links {
			out.push_str(&enc(layer as f64, 1)?);
		}
		Ok(Some(out))
	}

	/// The class field (run-length, a byte a node).
	pub fn class_field(&self) -> String {
		run_length(&self.cls)
	}

	/// The area field, None when no node has an area.
	pub fn area_field(&self) -> Result<Option<String>, String> {
		if self.area.iter().all(|&a| a == 0) {
			return Ok(None);
		}
		encode_areas(&self.area).map(Some)
	}

	/// The arc field (pack/leffe.rs cluster's columns: n | from gaps | ends (zigzag, against the from) | yards * 4),
	/// None without arcs.
	pub fn arc_field(&self) -> Option<String> {
		if self.arcs.is_empty() {
			return None;
		}
		let mut s = String::new();
		b32(self.arcs.len() as u64, &mut s);
		let mut last = 0u32;
		for &(a, _) in self.arcs.keys() {
			b32((a - last) as u64, &mut s);
			last = a;
		}
		for &(a, b) in self.arcs.keys() {
			b32(zigzag(b as i64 - a as i64), &mut s);
		}
		for &y in self.arcs.values() {
			b32(y as u64, &mut s);
		}
		Some(s)
	}
}

/// A graph edge record's value of a cost or yards (rounded, clamped to its field).
pub fn cost_value(v: f64) -> u32 {
	js_round(v).clamp(0.0, COST_MAX) as u32
}

pub fn yards_value(v: f64) -> u32 {
	js_round(v).clamp(0.0, YARDS_MAX) as u32
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::pack::encode::encode_heights;

	const C: usize = 4;
	const CS: f64 = 4.0;

	fn base() -> Cluster {
		let mut val = vec![1u8; C * C];
		val[9] = 0;
		let grid = run_length(&val.iter().map(|v| v * 16).collect::<Vec<u8>>());
		let height = encode_heights(&val, &(0..C * C).map(|i| i as i32 % 3).collect::<Vec<i32>>(), C).unwrap();
		Cluster::decode(C, CS, 2.0, &grid, &height, None, None, None, None).unwrap()
	}

	/// Floors, links, classes, areas, arcs and entrance rows written and read back give the same cluster.
	#[test]
	fn a_cluster_written_and_read_back_is_the_same() {
		let mut c = base();
		assert_eq!(c.z[5], 4.0, "base heights in 2 yd steps");
		c.add_floor(6, 1, 12.4, 4, 77);
		let f0 = c.add_floor(5, 1, 10.0, 4, 0);
		let f2 = c.add_floor(5, 2, 20.0, 1, 77);
		assert_eq!((f0, f2, c.cell(18), c.z[18]), (16, 17, 6, 12.0), "floors in cell order, a cell's after its others, whole yards");
		assert_eq!((c.layer(f0), c.layer(f2), c.layer(18)), (1, 2, 1));
		c.steps[f0 - 16] = 1; // +x to the surface nearest its height
		c.links.push((f2 as u32, 2, 1));
		c.add_arc(f0, 18, 7.0);
		c.index();
		let (floor, class, area, arc) = (c.floor_field().unwrap(), c.class_field(), c.area_field().unwrap(), c.arc_field());
		let d = Cluster::decode(C, CS, 2.0, &c.grid, &c.height, floor.as_deref(), Some(&class), area.as_deref(), arc.as_deref()).unwrap();
		assert_eq!(
			(d.val, d.z.iter().map(|z| if z.is_nan() { -1.0 } else { *z }).collect::<Vec<f64>>()),
			(c.val.clone(), c.z.iter().map(|z| if z.is_nan() { -1.0 } else { *z }).collect::<Vec<f64>>())
		);
		assert_eq!((d.cls, d.area, d.at, d.steps, d.links, d.arcs), (c.cls.clone(), c.area.clone(), c.at.clone(), c.steps.clone(), c.links.clone(), c.arcs.clone()));
		let rows = vec![Row { cell: 5, layer: 2, comp: 3, edges: vec![Edge { off: HERE, ent: 1, cost: [10, 11, 12], yards: 9 }] }, Row { cell: 0, layer: 0, comp: 4095, edges: Vec::new() }];
		assert_eq!(decode_graph(&encode_graph(&rows).unwrap()).unwrap(), rows);
	}

	/// The search steps as Path.lua's: base moves, a floor's step to the neighbour's surface nearest its height, the
	/// base cell's step back up to that floor, an arc forwards (and only backwards for a search out of a goal).
	#[test]
	fn the_search_takes_the_routers_moves() {
		let mut c = base();
		let f = c.add_floor(5, 1, 3.0, 0, 0);
		c.steps[f - 16] = 1; // +x: cell 9 is blocked, so nothing
		c.steps[f - 16] |= 4; // +y: cell 6 (height 0), nearest its height
		c.index();
		let mut out = Vec::new();
		c.moves(f, false, &mut out);
		assert_eq!(out, vec![(6, 1.0)]);
		c.moves(6, false, &mut out);
		assert!(out.contains(&(f, 1.0)), "the base cell steps back to the floor: {out:?}");
		c.moves(5, false, &mut out);
		assert!(!out.iter().any(|m| m.0 == 9), "no step into a blocked cell: {out:?}");
		c.add_arc(0, 15, 8.0);
		c.moves(0, false, &mut out);
		assert!(out.contains(&(15, 2.0)), "the arc, 8 yd over 4 yd cells: {out:?}");
		c.moves(15, true, &mut out);
		assert!(out.contains(&(0, 2.0)), "backwards at its end for a search out of a goal");
		c.moves(15, false, &mut out);
		assert!(!out.contains(&(0, 2.0)));
		let (g, _) = c.dijkstra(&[(0, 0.0, 0.0)], 2, 3.0, false);
		assert!((g[15] - 8.0).abs() < 1e-9, "the arc's 8 yd: {}", g[15]);
	}
}
