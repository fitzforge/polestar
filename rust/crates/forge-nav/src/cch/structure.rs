//! The metric-independent CCH of one coarse graph: contraction order by inertial flow on the
//! nodes' world positions (`cch::inertial_order`), the chordal supergraph (`cch::Cch::build`,
//! RoutingKit's construction), its elimination-tree levels, written once to a bundle file and
//! memory-mapped by every reader (one copy in the page cache for all workers and processes).

use crate::cch::graph::CoarseGraph;
use std::io::Write;
use std::path::Path;

const MAGIC: &[u8; 8] = b"NAVCCH01";
const ARRAYS: usize = 18;
pub const INVALID: u32 = u32::MAX;

#[derive(Clone, Copy)]
pub enum A {
	Rank = 0,
	Order,
	ElimParent,
	UpFirstOut,
	UpHead,
	UpTail,
	DownFirstOut,
	DownHead,
	DownToUp,
	FwdIn,
	BwdIn,
	FirstExtraFwd,
	ExtraFwd,
	FirstExtraBwd,
	ExtraBwd,
	LevelNodes,
	LevelFirst,
	InputToCch,
}

pub struct Structure {
	map: memmap2::Mmap,
	at: [(usize, usize); ARRAYS],
	pub node_count: usize,
	pub arc_count: usize,
	pub input_arcs: usize,
}

pub struct BuildStats {
	pub order_ms: f64,
	pub build_ms: f64,
	pub nodes: usize,
	pub input_arcs: usize,
	pub arcs: usize,
	pub levels: usize,
}

fn levels(parent: &[u32]) -> (Vec<u32>, Vec<u32>) {
	let n = parent.len();
	let mut h = vec![0u32; n];
	let mut num = 1u32;
	for x in 0..n {
		let p = parent[x];
		if p != INVALID && h[x] + 1 > h[p as usize] {
			h[p as usize] = h[x] + 1;
		}
		num = num.max(h[x] + 1);
	}
	let mut first = vec![0u32; num as usize + 1];
	for &v in &h {
		first[v as usize + 1] += 1;
	}
	for l in 0..num as usize {
		first[l + 1] += first[l];
	}
	let mut cur = first[..num as usize].to_vec();
	let mut nodes = vec![0u32; n];
	for (x, &v) in h.iter().enumerate() {
		nodes[cur[v as usize] as usize] = x as u32;
		cur[v as usize] += 1;
	}
	(nodes, first)
}

/// Builds the CCH of reference graph `gi` of `g` and writes it to `out` (via a temporary file).
pub fn build(g: &CoarseGraph, gi: usize, out: &Path) -> std::io::Result<BuildStats> {
	let rg = &g.graphs[gi];
	let n = g.node_count;
	let mut tail = Vec::with_capacity(rg.to.len());
	for u in 0..n {
		for _ in rg.off[u]..rg.off[u + 1] {
			tail.push(u as u32);
		}
	}
	let lat: Vec<f32> = g.wx.iter().map(|&v| v as f32).collect();
	let lon: Vec<f32> = g.wy.iter().map(|&v| v as f32).collect();
	let t0 = std::time::Instant::now();
	let order = cch::inertial_order(n as u32, &tail, &rg.to, &lat, &lon);
	let order_ms = t0.elapsed().as_secs_f64() * 1e3;
	drop(tail);
	let graph = cch::graph::Graph { first_out: rg.off.clone(), head: rg.to.clone(), weight: vec![0; rg.to.len()] };
	let t1 = std::time::Instant::now();
	let c = cch::Cch::build(&graph, &order);
	let build_ms = t1.elapsed().as_secs_f64() * 1e3;
	drop(graph);
	let (lnodes, lfirst) = levels(&c.elimination_tree_parent);
	let arrays: [&[u32]; ARRAYS] = [
		&c.rank,
		&c.order,
		&c.elimination_tree_parent,
		&c.up_first_out,
		&c.up_head,
		&c.up_tail,
		&c.down_first_out,
		&c.down_head,
		&c.down_to_up,
		&c.forward_input_arc_of_cch,
		&c.backward_input_arc_of_cch,
		&c.first_extra_forward_input_arc_of_cch,
		&c.extra_forward_input_arc_of_cch,
		&c.first_extra_backward_input_arc_of_cch,
		&c.extra_backward_input_arc_of_cch,
		&lnodes,
		&lfirst,
		&c.input_arc_to_cch_arc,
	];
	let tmp = out.with_extension("tmp");
	{
		let mut f = std::io::BufWriter::new(std::fs::File::create(&tmp)?);
		f.write_all(MAGIC)?;
		f.write_all(&(ARRAYS as u64).to_le_bytes())?;
		let mut off = 16 + 16 * ARRAYS;
		let mut table = Vec::new();
		for a in arrays.iter() {
			off = (off + 7) & !7;
			table.push((off, a.len()));
			off += 4 * a.len();
		}
		for &(o, l) in &table {
			f.write_all(&(o as u64).to_le_bytes())?;
			f.write_all(&(l as u64).to_le_bytes())?;
		}
		let mut pos = 16 + 16 * ARRAYS;
		for (a, &(o, _)) in arrays.iter().zip(&table) {
			while pos < o {
				f.write_all(&[0])?;
				pos += 1;
			}
			for v in a.iter() {
				f.write_all(&v.to_le_bytes())?;
			}
			pos += 4 * a.len();
		}
		f.flush()?;
	}
	std::fs::rename(&tmp, out)?;
	Ok(BuildStats { order_ms, build_ms, nodes: n, input_arcs: rg.to.len(), arcs: c.up_head.len(), levels: lfirst.len() - 1 })
}

impl Structure {
	pub fn open(path: &Path) -> std::io::Result<Structure> {
		let f = std::fs::File::open(path)?;
		let map = unsafe { memmap2::Mmap::map(&f)? };
		let bad = |m: &str| std::io::Error::new(std::io::ErrorKind::InvalidData, format!("{}: {m}", path.display()));
		if map.len() < 16 + 16 * ARRAYS || &map[0..8] != MAGIC {
			return Err(bad("not a nav CCH bundle"));
		}
		let mut at = [(0usize, 0usize); ARRAYS];
		for (i, slot) in at.iter_mut().enumerate() {
			let b = 16 + 16 * i;
			let o = u64::from_le_bytes(map[b..b + 8].try_into().unwrap()) as usize;
			let l = u64::from_le_bytes(map[b + 8..b + 16].try_into().unwrap()) as usize;
			if !o.is_multiple_of(4) || o + 4 * l > map.len() {
				return Err(bad("truncated"));
			}
			*slot = (o, l);
		}
		let node_count = at[A::Rank as usize].1;
		let arc_count = at[A::UpHead as usize].1;
		let input_arcs = at[A::InputToCch as usize].1;
		Ok(Structure { map, at, node_count, arc_count, input_arcs })
	}

	#[inline]
	pub fn a(&self, which: A) -> &[u32] {
		let (o, l) = self.at[which as usize];
		// The map is page-aligned and every array starts 8-aligned in it.
		unsafe { std::slice::from_raw_parts(self.map.as_ptr().add(o) as *const u32, l) }
	}

	pub fn bytes(&self) -> usize {
		self.map.len()
	}

	/// The up-arc of (low, high), low < high internally, or INVALID.
	#[inline]
	pub fn find_arc(&self, up_first_out: &[u32], up_head: &[u32], low: u32, high: u32) -> u32 {
		let b = up_first_out[low as usize] as usize;
		let e = up_first_out[low as usize + 1] as usize;
		match up_head[b..e].binary_search(&high) {
			Ok(i) => (b + i) as u32,
			Err(_) => INVALID,
		}
	}
}
