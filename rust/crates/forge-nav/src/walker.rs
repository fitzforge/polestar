//! The walking router in Rust (cch.js distanceRows and routeManyRaw over forge-nav's legs):
//! rows of (source, targets) -> seconds, yards and zone cells per pair.
//!
//! Per continent: the abstract graph, the faction's walk graph (edge seconds, forge nav prepare's
//! `.f32`), the zone mix (`.mix`), and where prepareYards made them the edge yards and cells. The
//! coarse search is a multi-seed Dijkstra from the start legs' seeds to the goals' legs, its edge
//! weights priced on the fly: seconds × the danger of the edge's zone mix (router.js edgeCosts,
//! path.js coarseDanger; PerfNextWins §2.4 A). No metric is customized per danger table: the
//! end-zone exemption is in the profile's danger table, applied as the search reads each edge.
//! A pair inside the start's tile takes the tile search's way when no graph way is cheaper; a pair
//! nothing reached is asked as routeMany asks it (pocket settle per pair).
//!
//! The straight-line fast path (`Walker::straight`) is adapted from Factoruide
//! (https://github.com/brouznouf/factoruide, fg-route terrain/mod.rs), MIT, used with its author's permission.

use crate::cch::query::EdgeCells;
use crate::cost::Profile;
use crate::grid::{Graph, Grid};
use crate::legs::{Cells, Legs, MinHeap, Nav, SnapAsk, Snapped, Tree};
use crate::space::{piece_cells, piece_path, AStar, WayCell};
use parking_lot::Mutex;
use rayon::prelude::*;
use rustc_hash::FxHashMap;
use std::path::Path;
use std::sync::Arc;

/// The straight line is the walk when it costs at most this share over the lower bound of every way.
pub const STRAIGHT_SLACK: f64 = 0.002;

/// Rows of one continent from which a danger-free call customizes the CCH (else the Dijkstra).
pub const CCH_ROWS: usize = 1500;

/// Pairs the store's router asks of the walker at once.
pub const ROUTER_CHUNK: usize = 150_000;

/// The store model of a walking profile: the grid's build id, and every parameter its answers
/// depend on (cost model and ground: roads, hubs, faction; move profile; style; smooth; the zones
/// the danger is priced by; the danger table; the walker's answer version).
pub fn walk_model(grid_id: &str, p: &Profile, style: &str, smooth: f64, zones_tag: &str) -> crate::store::Model {
	let danger = p.area.as_ref().map(|a| a.key.as_str()).unwrap_or("-|");
	crate::store::Model {
		grid: grid_id.to_string(),
		params: format!("{}|{}|{}|style={style}|smooth={}|zones={zones_tag}|v={MODEL_VERSION}", p.ground_key, danger, p.name, forge_core::jsnum::js_to_string(smooth)),
	}
}

/// The grid's build id answers are kept under (index.json build and builtAt).
pub fn grid_id(grid: &Grid) -> String {
	format!("{}:{}", grid.index["build"].as_str().unwrap_or(""), grid.built_at)
}

/// router.js SMOOTH: walked yards per cell-path yard.
pub const SMOOTH: f64 = 0.961;

/// The walker's answers' version, part of every store model's parameters: bump when what the Rust
/// router answers for the same ends, grid and cost model changes (never keyed by source text).
pub const MODEL_VERSION: u32 = 1;

/// path.js WALK_GRAPH_VERSION.
pub const WALK_GRAPH_VERSION: u32 = 2;

/// A zone mix (path.js decodeMix): edge x spends frac[y] of its seconds in zone[y], the rest in its
/// start node's zone.
pub struct Mix {
	pub node_zone: Vec<u16>,
	pub off: Vec<u32>,
	pub zone: Vec<u16>,
	pub frac: Vec<f32>,
}

impl Mix {
	pub fn decode(b: &[u8]) -> Mix {
		let u32at = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
		let (e, m, n) = (u32at(0) as usize, u32at(4) as usize, u32at(8) as usize);
		let pad4 = |x: usize| (x + 3) & !3;
		let mut o = 12;
		let node_zone = b[o..o + 2 * n].chunks_exact(2).map(|c| u16::from_le_bytes([c[0], c[1]])).collect();
		o += pad4(2 * n);
		let off = b[o..o + 4 * (e + 1)].chunks_exact(4).map(|c| u32::from_le_bytes(c.try_into().unwrap())).collect();
		o += 4 * (e + 1);
		let zone = b[o..o + 2 * m].chunks_exact(2).map(|c| u16::from_le_bytes([c[0], c[1]])).collect();
		o += pad4(2 * m);
		let frac = b[o..o + 4 * m].chunks_exact(4).map(|c| f32::from_le_bytes(c.try_into().unwrap())).collect();
		Mix { node_zone, off, zone, frac }
	}
}

/// A continent's coarse side for one faction's ground.
pub struct Coarse {
	pub graph: Arc<Graph>,
	pub secs: Vec<f32>,
	pub yards: Option<Vec<f32>>,
	pub cells: Option<EdgeCells>,
	pub mix: Option<Mix>,
	/// Nodes downstream of the largest strongly connected component (open edges): a search whose
	/// seeds all lie there never leaves it, so a goal with no node there is unreachable and the
	/// search need not run on to exhaust the graph for it.
	down: std::sync::OnceLock<Vec<bool>>,
}

impl Coarse {
	/// The largest strongly connected component of the open edges (Kosaraju, iterative) and every
	/// node reachable from it.
	fn down(&self) -> &[bool] {
		self.down.get_or_init(|| {
			let g = &self.graph;
			let n = g.node_entry.len();
			let open = |x: usize| self.secs[x].is_finite();
			// Pass 1: finish order of a forward DFS.
			let mut order = Vec::with_capacity(n);
			let mut seen = vec![false; n];
			let mut stack: Vec<(usize, usize)> = Vec::new();
			for r in 0..n {
				if seen[r] {
					continue;
				}
				seen[r] = true;
				stack.push((r, g.off[r] as usize));
				while let Some(&mut (u, ref mut x)) = stack.last_mut() {
					if *x < g.off[u + 1] as usize {
						let e = *x;
						*x += 1;
						let v = g.to[e] as usize;
						if open(e) && !seen[v] {
							seen[v] = true;
							stack.push((v, g.off[v] as usize));
						}
					} else {
						order.push(u);
						stack.pop();
					}
				}
			}
			// The reverse graph.
			let mut roff = vec![0u32; n + 1];
			for e in 0..g.to.len() {
				if open(e) {
					roff[g.to[e] as usize + 1] += 1;
				}
			}
			for v in 0..n {
				roff[v + 1] += roff[v];
			}
			let mut rto = vec![0u32; roff[n] as usize];
			let mut fill = roff.clone();
			for u in 0..n {
				for e in g.off[u] as usize..g.off[u + 1] as usize {
					if open(e) {
						let v = g.to[e] as usize;
						rto[fill[v] as usize] = u as u32;
						fill[v] += 1;
					}
				}
			}
			// Pass 2: components in reverse finish order on the reverse graph.
			let mut comp = vec![u32::MAX; n];
			let mut sizes: Vec<usize> = Vec::new();
			let mut st: Vec<usize> = Vec::new();
			for &r in order.iter().rev() {
				if comp[r] != u32::MAX {
					continue;
				}
				let id = sizes.len() as u32;
				let mut size = 0;
				comp[r] = id;
				st.push(r);
				while let Some(u) = st.pop() {
					size += 1;
					for &v in &rto[roff[u] as usize..roff[u + 1] as usize] {
						if comp[v as usize] == u32::MAX {
							comp[v as usize] = id;
							st.push(v as usize);
						}
					}
				}
				sizes.push(size);
			}
			let giant = sizes.iter().enumerate().max_by_key(|x| x.1).map(|x| x.0 as u32).unwrap_or(0);
			let mut down = vec![false; n];
			let mut st: Vec<usize> = (0..n).filter(|&u| comp[u] == giant).collect();
			for &u in &st {
				down[u] = true;
			}
			while let Some(u) = st.pop() {
				for e in g.off[u] as usize..g.off[u + 1] as usize {
					let v = g.to[e] as usize;
					if open(e) && !down[v] {
						down[v] = true;
						st.push(v);
					}
				}
			}
			down
		})
	}

	/// The edge's search weight (router.js edgeCosts ÷ run, cch.js metric): seconds × danger.
	#[inline]
	fn weight(&self, x: usize, u: usize, p: &Profile) -> f64 {
		let m = match (&p.area, &self.mix) {
			(Some(a), Some(mix)) => {
				let mut m = 0.0;
				let mut rest = 1.0;
				for y in mix.off[x] as usize..mix.off[x + 1] as usize {
					m += mix.frac[y] as f64 * a.zone_mult(mix.zone[y]);
					rest -= mix.frac[y] as f64;
				}
				m + rest * a.zone_mult(mix.node_zone[u])
			}
			_ => 1.0,
		};
		(self.secs[x] as f64 * m * p.run) / p.run
	}
}

fn sha16(s: &str) -> String {
	forge_core::key::content_key(s.as_bytes())[..16].to_string()
}

/// The walk graph of continent c for profile p (path.js walkGraphFile): <grid>/walk/, named by the
/// graph file's size, the build (index.json builtAt) and the profile's prices.
pub fn walk_graph_file(grid: &Grid, c: u32, p: &Profile) -> std::path::PathBuf {
	let tag = sha16(&format!("{WALK_GRAPH_VERSION}|{}|{}|{}", grid.built_at, grid.graph_file_size(c), p.edge_key(0)));
	grid.dir.join("walk").join(format!("{c}-0-{tag}.f32"))
}

/// The zone mix of continent c (path.js walkMixFile; mixKey: router.js profileOf's, foot).
pub fn mix_file(grid: &Grid, c: u32, p: &Profile, zones_tag: &str) -> std::path::PathBuf {
	let mix_key = format!("{}|{}|{}|foot|{zones_tag}", crate::cost::MODEL, p.ground.roads_tag, p.ground.hubs_tag);
	let tag = sha16(&format!("{WALK_GRAPH_VERSION}|{}|{}|0|{mix_key}", grid.built_at, grid.graph_file_size(c)));
	grid.dir.join("walk").join(format!("{c}-0-{tag}.mix"))
}

/// One answer: seconds (-1 none), yards, zone cells.
#[derive(Clone, Debug, Default)]
pub struct Walk {
	pub seconds: f64,
	pub yards: f64,
	pub cells: Option<Cells>,
}

impl Walk {
	pub const NONE: Walk = Walk { seconds: -1.0, yards: -1.0, cells: None };
}

/// A walk's drawn way (Walker::route_path): its cells in order, the cost it was chosen by
/// (seconds × the profile's multipliers) and whether its goal was moved off a pocket.
#[derive(Clone, Debug)]
pub struct GridWay {
	pub cells: Vec<WayCell>,
	pub seconds: f64,
	pub settled: bool,
}

/// A row: one source, its targets.
pub struct Row {
	pub source: SnapAsk,
	pub targets: Vec<SnapAsk>,
}

/// The multi-seed coarse search's scratch.
#[derive(Default)]
struct Search {
	dist: Vec<f64>,
	yd: Vec<f64>,
	pred: Vec<u32>,
	pred_edge: Vec<u32>,
	seed: Vec<u32>,
	stamp: Vec<u32>,
	done: Vec<u32>,
	gen: u32,
	heap: MinHeap,
}

/// The best way to one target: cost, yards, the start seed it leaves and the goal seed it reaches,
/// and the coarse edges in order.
struct Found {
	cost: f64,
	yards: f64,
	from: usize,
	to: usize,
	edges: Vec<u32>,
	nodes: Vec<u32>,
	/// The graph part's zone cells when the CCH unpacked them (else from `edges`).
	cells: Option<Cells>,
}

#[derive(Default)]
pub struct Scratch {
	tree: Tree,
	fw: Tree,
	search: Search,
	astar: AStar,
}

type LegKey = (u32, u32, u32, u32, String);

/// What `rows` did (cch.js stats).
#[derive(Default, Debug, Clone)]
pub struct Stats {
	pub rows: usize,
	pub pairs: usize,
	pub retried: usize,
	pub legs_ms: f64,
	pub search_ms: f64,
	pub total_ms: f64,
	pub relaxed: u64,
}

pub struct Walker {
	pub grid: Arc<Grid>,
	pub nav: Nav,
	coarse: Mutex<FxHashMap<(u32, String), Option<Arc<Coarse>>>>,
	snaps: Mutex<FxHashMap<(u32, u64, u64, u64, bool, bool), Option<Snapped>>>,
	starts: Mutex<FxHashMap<LegKey, Arc<(Legs, Snapped)>>>,
	goals: Mutex<FxHashMap<LegKey, Arc<Legs>>>,
	raw_goals: Mutex<FxHashMap<LegKey, Arc<Legs>>>,
	pieces: Mutex<FxHashMap<(u32, u32, u32, String), Arc<(f64, Cells)>>>,
	/// Danger-free profiles' metrics on the continent's CCH bundle (customized once each).
	metrics: Mutex<FxHashMap<(u32, String), Arc<(crate::cch::structure::Structure, crate::cch::metric::Metric)>>>,
	/// Each continent's CCH bundle path (prepare.rs bundle_file), if built.
	bundles: Mutex<FxHashMap<u32, Option<std::path::PathBuf>>>,
	/// Ask the CCH for danger-free rows where a bundle exists (else the coarse Dijkstra).
	pub use_cch: bool,
	/// The straight line only where provably within STRAIGHT_SLACK of the best way (true), or
	/// wherever it is plain (false: the owner's first rule, measured against the router).
	pub straight_exact: bool,
	relaxed: std::sync::atomic::AtomicU64,
}

impl Walker {
	pub fn new(grid: Arc<Grid>) -> Walker {
		Walker {
			nav: Nav::new(grid.clone()),
			grid,
			coarse: Mutex::new(FxHashMap::default()),
			snaps: Mutex::new(FxHashMap::default()),
			starts: Mutex::new(FxHashMap::default()),
			goals: Mutex::new(FxHashMap::default()),
			raw_goals: Mutex::new(FxHashMap::default()),
			pieces: Mutex::new(FxHashMap::default()),
			metrics: Mutex::new(FxHashMap::default()),
			bundles: Mutex::new(FxHashMap::default()),
			use_cch: true,
			straight_exact: true,
			relaxed: Default::default(),
		}
	}

	/// The walk graph of continent c for profile p (path.js walkGraphFile).
	pub fn walk_graph_file(&self, c: u32, p: &Profile) -> std::path::PathBuf {
		walk_graph_file(&self.grid, c, p)
	}

	/// path.js walkMixFile (mixKey: router.js profileOf's, foot).
	pub fn mix_file(&self, c: u32, p: &Profile, zones_tag: &str) -> std::path::PathBuf {
		mix_file(&self.grid, c, p, zones_tag)
	}

	/// cch.js yardsFile / cellsFile next to the continent's bundle (prepare.rs bundle_file: the one
	/// keyed on this grid's graph, never another graph's bundle left in cch/).
	fn edge_files(&self, c: u32, p: &Profile) -> Option<(std::path::PathBuf, std::path::PathBuf)> {
		let (y, x) = crate::prepare::edge_files(&self.bundle(c)?, p);
		y.exists().then_some((y, x))
	}

	/// Continent c's coarse side for p's ground (read once). Fails loudly where the walk graph is
	/// not built: walks are never built as a side effect.
	pub fn coarse(&self, c: u32, p: &Profile, zones_tag: &str) -> Result<Option<Arc<Coarse>>, String> {
		let key = (c, format!("{}|{}", p.edge_key(0), zones_tag));
		if let Some(v) = self.coarse.lock().get(&key) {
			return Ok(v.clone());
		}
		let Some(graph) = self.grid.graph(c) else {
			self.coarse.lock().insert(key, None);
			return Ok(None);
		};
		let f = self.walk_graph_file(c, p);
		let b = std::fs::read(&f).map_err(|e| format!("walker: no walk graph {} for continent {c} ({e}; forge nav prepare builds it)", f.display()))?;
		let secs: Vec<f32> = b.chunks_exact(4).map(|x| f32::from_le_bytes(x.try_into().unwrap())).collect();
		if secs.len() != graph.edges() {
			return Err(format!("walker: {} holds {} edges, the graph {}", f.display(), secs.len(), graph.edges()));
		}
		let mix = std::fs::read(self.mix_file(c, p, zones_tag)).ok().map(|b| Mix::decode(&b));
		let (yards, cells) = match self.edge_files(c, p) {
			Some((y, x)) => {
				let stale = |why: String| format!("walker: stale cch yards {} ({why}); forge nav prepare rebuilds them", y.display());
				let yb = std::fs::read(&y).map_err(|e| e.to_string())?;
				if yb.len() / 8 != graph.edges() {
					return Err(stale(format!("{} edges, the graph has {}", yb.len() / 8, graph.edges())));
				}
				let cells = EdgeCells::open(&x).ok();
				if let Some(n) = cells.as_ref().map(EdgeCells::edges).filter(|&n| n != graph.edges()) {
					return Err(stale(format!("cells for {n} edges, the graph has {}", graph.edges())));
				}
				(Some(yb.chunks_exact(8).map(|v| f64::from_le_bytes(v.try_into().unwrap()) as f32).collect()), cells)
			}
			None => (None, None),
		};
		let v = Some(Arc::new(Coarse { graph, secs, yards, cells, mix, down: Default::default() }));
		self.coarse.lock().insert(key, v.clone());
		Ok(v)
	}

	/// The continent's CCH bundle, if built: the one keyed on this grid's graph (prepare.rs
	/// bundle_file). A bundle of another graph in cch/ (another build, another link rule) is never
	/// read. The key hashes the graph file, so it is worked out once per continent.
	fn bundle(&self, c: u32) -> Option<std::path::PathBuf> {
		if let Some(b) = self.bundles.lock().get(&c) {
			return b.clone();
		}
		let b = crate::prepare::bundle_file(&self.grid.dir, c).ok().filter(|b| b.exists());
		self.bundles.lock().insert(c, b.clone());
		b
	}

	/// A danger-free profile's metric on the CCH (router.js edgeCosts ÷ run; the edge yards), once.
	/// A bundle built on another edge set than the walk graph's fails with the reason.
	fn metric(&self, c: u32, co: &Coarse, p: &Profile) -> Result<Option<Arc<(crate::cch::structure::Structure, crate::cch::metric::Metric)>>, String> {
		if p.area.is_some() || co.yards.is_none() {
			return Ok(None);
		}
		let key = (c, p.edge_key(0));
		if let Some(m) = self.metrics.lock().get(&key) {
			return Ok(Some(m.clone()));
		}
		let Some(bundle) = self.bundle(c) else { return Ok(None) };
		if let Some(why) = crate::prepare::cch_stale(&bundle, co.secs.len()) {
			return Err(format!("walker: stale cch {} ({why}); forge nav prepare rebuilds it", bundle.display()));
		}
		let s = crate::cch::structure::Structure::open(&bundle).map_err(|e| e.to_string())?;
		let w: Vec<f64> = co.secs.iter().map(|&x| (x as f64 * 1.0 * p.run) / p.run).collect();
		let m = crate::cch::metric::Metric::customize(&s, w, co.yards.clone().unwrap());
		let v = Arc::new((s, m));
		self.metrics.lock().insert(key, v.clone());
		Ok(Some(v))
	}

	/// router.js snapOf, memoised.
	pub fn snap(&self, q: &SnapAsk) -> Option<Snapped> {
		let k = (q.c, q.wx.to_bits(), q.wy.to_bits(), q.z.map(|z| z.to_bits()).unwrap_or(u64::MAX), q.under, q.stand);
		if let Some(v) = self.snaps.lock().get(&k) {
			return *v;
		}
		let v = self.nav.snap(q);
		self.snaps.lock().insert(k, v);
		v
	}

	fn leg_key(&self, a: &Snapped, p: &Profile) -> LegKey {
		let touched = match (&p.area, self.grid.tile(a.c, a.col as i64, a.row as i64)) {
			(Some(ar), Some(t)) => ar.touches(&t),
			_ => false,
		};
		(a.c, a.col, a.row, a.entry, format!("{}|{}", p.leg_key(), if touched { p.area.as_ref().unwrap().key.as_str() } else { "" }))
	}

	/// A start's legs, settled, kept per place (cch.js startOf).
	fn start_of(&self, g: &Graph, a: &Snapped, p: &Profile, sc: &mut Tree, cells: bool) -> Option<Arc<(Legs, Snapped)>> {
		let key = self.leg_key(a, p);
		if let Some(v) = self.starts.lock().get(&key) {
			if v.0.cells.is_some() || !cells {
				return Some(v.clone());
			}
		}
		let (l, _, e) = self.nav.start_of(g, a, p, sc, cells)?;
		let v = Arc::new((l, e));
		self.starts.lock().insert(key, v.clone());
		Some(v)
	}

	/// A goal's legs, settled, kept per place (cch.js distanceRows goalOf).
	fn goal_of(&self, g: &Graph, b: &Snapped, p: &Profile, sc: &mut Tree, cells: bool) -> Arc<Legs> {
		let key = self.leg_key(b, p);
		if let Some(v) = self.goals.lock().get(&key) {
			if v.cells.is_some() || !cells {
				return v.clone();
			}
		}
		let v = Arc::new(self.nav.goal_of(g, b, p, sc, cells).0);
		self.goals.lock().insert(key, v.clone());
		v
	}

	/// The goal's own legs, unsettled (path.js goalLegs, as routeMany takes them), kept per place.
	fn goal_legs(&self, g: &Graph, b: &Snapped, p: &Profile, sc: &mut Tree, cells: bool) -> Legs {
		let key = self.leg_key(b, p);
		if let Some(v) = self.raw_goals.lock().get(&key) {
			if v.cells.is_some() || !cells {
				return (**v).clone();
			}
		}
		let v = Arc::new(self.nav.goal_legs(g, b, p, sc, cells));
		self.raw_goals.lock().insert(key, v.clone());
		(*v).clone()
	}

	/// path.js nodePoint: abstract node x as a snapped point.
	fn node_point(g: &Graph, x: u32) -> Snapped {
		let t = g.tiles[g.node_tile[x as usize] as usize];
		let k = g.node_k[x as usize] as u32;
		Snapped {
			c: g.c,
			wx: crate::grid::cell_centre(t.col as i64, t.row as i64, (k & 255) as i64, (k >> 8) as i64).0,
			wy: crate::grid::cell_centre(t.col as i64, t.row as i64, (k & 255) as i64, (k >> 8) as i64).1,
			z: g.node_z[x as usize] as f64,
			col: t.col,
			row: t.row,
			i: k & 255,
			j: k >> 8,
			layer: 0,
			entry: g.node_entry[x as usize],
			region: None,
			flags: 0,
		}
	}

	/// path.js piece: the cell path between consecutive abstract nodes u and v (an A* over their
	/// tiles), its yards and zone cells, kept per pair.
	fn piece(&self, g: &Graph, u: u32, v: u32, p: &Profile, sc: &mut AStar, cells: bool) -> Arc<(f64, Cells)> {
		let (a, b) = (Self::node_point(g, u), Self::node_point(g, v));
		let touched = p
			.area
			.as_ref()
			.is_some_and(|ar| self.grid.tile(g.c, a.col as i64, a.row as i64).is_some_and(|t| ar.touches(&t)) || self.grid.tile(g.c, b.col as i64, b.row as i64).is_some_and(|t| ar.touches(&t)));
		let key = (g.c, u, v, format!("{}|{}", p.leg_key(), if touched { p.area.as_ref().unwrap().key.as_str() } else { "" }));
		if let Some(x) = self.pieces.lock().get(&key) {
			return x.clone();
		}
		let pc = if a.same_tile(&b) && a.entry == b.entry {
			(0.0, Cells::default())
		} else {
			match piece_path(&self.grid, &a, &b, p, sc, cells) {
				Some(x) => x,
				None => {
					let y = forge_core::jsnum::js_hypot_n(&[a.wx - b.wx, a.wy - b.wy, a.z - b.z]);
					let mut c = Cells::default();
					if cells {
						c.add(forge_core::cells::cell_key(b.wx, b.wy) as u32, y);
					}
					(y, c)
				}
			}
		};
		let pc = Arc::new(pc);
		self.pieces.lock().insert(key, pc.clone());
		pc
	}

	/// Multi-seed Dijkstra over the coarse graph from `seeds` to each goal's legs; stops when no
	/// goal can still improve. -> per goal the best way (first strict minimum), or None.
	fn search(&self, co: &Coarse, p: &Profile, seeds: &Legs, goals: &[&Legs], sc: &mut Search) -> Vec<Option<Found>> {
		// A customized CCH answers as cch.js's metric.paths does (exact, unreachable at no cost);
		// its ways carry no node path, so not where pieces need one.
		if co.yards.is_some() && p.area.is_none() {
			let m = self.metrics.lock().get(&(co.graph.c, p.edge_key(0))).cloned();
			if let Some(m) = m {
				return self.search_cch(co, &m, seeds, goals);
			}
		}
		let g = &co.graph;
		let n = g.node_entry.len();
		if sc.dist.len() < n {
			*sc = Search {
				dist: vec![0.0; n],
				yd: vec![0.0; n],
				pred: vec![u32::MAX; n],
				pred_edge: vec![u32::MAX; n],
				seed: vec![0; n],
				stamp: vec![0; n],
				done: vec![0; n],
				gen: 0,
				heap: MinHeap::default(),
			};
		}
		sc.gen = sc.gen.wrapping_add(1);
		if sc.gen == u32::MAX {
			sc.stamp.fill(0);
			sc.done.fill(0);
			sc.gen = 1;
		}
		let gen = sc.gen;
		let mut best: Vec<f64> = vec![f64::INFINITY; goals.len()];
		let mut at: Vec<Option<(u32, usize)>> = vec![None; goals.len()]; // (node, goal seed)
																   // goal node -> [(goal, goal seed)]
		let mut by_node: FxHashMap<u32, Vec<(usize, usize)>> = FxHashMap::default();
		for (gi, l) in goals.iter().enumerate() {
			for (k, &x) in l.nodes.iter().enumerate() {
				by_node.entry(x).or_default().push((gi, k));
			}
		}
		if goals.is_empty() || by_node.is_empty() {
			return goals.iter().map(|_| None).collect();
		}
		// Goals no seed can reach (all seeds downstream of the giant component, no goal node there):
		// left out of the stop bound.
		let down = co.down();
		let mut dead = vec![false; goals.len()];
		if seeds.nodes.iter().all(|&x| down[x as usize]) {
			for (gi, l) in goals.iter().enumerate() {
				dead[gi] = !l.nodes.iter().any(|&x| down[x as usize]);
			}
		}
		let bound_of = |best: &[f64]| best.iter().zip(&dead).filter(|x| !*x.1).map(|x| *x.0).fold(f64::NEG_INFINITY, f64::max);
		if dead.iter().all(|&d| d) {
			return goals.iter().map(|_| None).collect();
		}
		sc.heap.clear();
		for (k, &x) in seeds.nodes.iter().enumerate() {
			let x = x as usize;
			if sc.stamp[x] != gen || seeds.sec[k] < sc.dist[x] {
				sc.stamp[x] = gen;
				sc.dist[x] = seeds.sec[k];
				sc.yd[x] = seeds.yd[k];
				sc.pred[x] = u32::MAX;
				sc.pred_edge[x] = u32::MAX;
				sc.seed[x] = k as u32;
				sc.heap.push(seeds.sec[k], x as i32);
			}
		}
		let mut bound = f64::INFINITY;
		let mut relaxed = 0u64;
		let yards = co.yards.as_deref();
		while !sc.heap.is_empty() {
			let u = sc.heap.pop() as usize;
			if sc.done[u] == gen {
				continue;
			}
			let du = sc.dist[u];
			if du >= bound {
				break;
			}
			sc.done[u] = gen;
			if let Some(list) = by_node.get(&(u as u32)) {
				let mut changed = false;
				for &(gi, k) in list {
					let v = du + goals[gi].sec[k];
					if v < best[gi] {
						best[gi] = v;
						at[gi] = Some((u as u32, k));
						changed = true;
					}
				}
				if changed {
					bound = bound_of(&best);
				}
			}
			for x in g.off[u] as usize..g.off[u + 1] as usize {
				let v = g.to[x] as usize;
				let w = co.weight(x, u, p);
				if !w.is_finite() {
					continue;
				}
				relaxed += 1;
				let nd = du + w;
				if sc.stamp[v] != gen || nd < sc.dist[v] {
					sc.stamp[v] = gen;
					sc.dist[v] = nd;
					sc.yd[v] = sc.yd[u] + yards.map(|y| y[x] as f64).unwrap_or(0.0);
					sc.pred[v] = u as u32;
					sc.pred_edge[v] = x as u32;
					sc.seed[v] = sc.seed[u];
					sc.heap.push(nd, v as i32);
				}
			}
		}
		self.relaxed.fetch_add(relaxed, std::sync::atomic::Ordering::Relaxed);
		at.iter()
			.enumerate()
			.map(|(gi, a)| {
				let (node, k) = (*a)?;
				let mut edges = Vec::new();
				let mut nodes = vec![node];
				let mut v = node as usize;
				while sc.pred_edge[v] != u32::MAX {
					edges.push(sc.pred_edge[v]);
					v = sc.pred[v] as usize;
					nodes.push(v as u32);
				}
				edges.reverse();
				nodes.reverse();
				Some(Found { cost: best[gi], yards: sc.yd[node as usize] + goals[gi].yd[k], from: sc.seed[node as usize] as usize, to: k, edges, nodes, cells: None })
			})
			.collect()
	}

	fn search_cch(&self, co: &Coarse, m: &(crate::cch::structure::Structure, crate::cch::metric::Metric), seeds: &Legs, goals: &[&Legs]) -> Vec<Option<Found>> {
		use crate::cch::query::{rows, rows_cells, Seed};
		let src: Vec<Seed> = (0..seeds.nodes.len()).map(|k| Seed { node: seeds.nodes[k], cost: seeds.sec[k], yards: seeds.yd[k] }).collect();
		let mut dst = Vec::new();
		let mut dst_off = vec![0u32];
		for l in goals {
			for k in 0..l.nodes.len() {
				dst.push(Seed { node: l.nodes[k], cost: l.sec[k], yards: l.yd[k] });
			}
			dst_off.push(dst.len() as u32);
		}
		let src_off = [0u32, src.len() as u32];
		let row_dst: Vec<u32> = (0..goals.len() as u32).collect();
		let row_off = [0u32, goals.len() as u32];
		let want_cells = goals.iter().all(|l| l.cells.is_some()) && co.cells.is_some();
		if want_cells {
			let r = rows_cells(&m.0, &m.1, co.cells.as_ref().unwrap(), &src_off, &src, &dst_off, &dst, &row_off, &row_dst);
			(0..goals.len())
				.map(|k| {
					(r.cost[k] >= 0.0).then(|| {
						let mut c = Cells::default();
						for x in r.cells_off[k] as usize..r.cells_off[k + 1] as usize {
							c.add(r.cells_key[x], r.cells_yards[x]);
						}
						Found { cost: r.cost[k], yards: r.yards[k], from: r.from[k] as usize, to: r.to[k] as usize, edges: Vec::new(), nodes: Vec::new(), cells: Some(c) }
					})
				})
				.collect()
		} else {
			let (cost, yards) = rows(&m.0, &m.1, &src_off, &src, &dst_off, &dst, &row_off, &row_dst);
			(0..goals.len()).map(|k| (cost[k] >= 0.0).then(|| Found { cost: cost[k], yards: yards[k], from: 0, to: 0, edges: Vec::new(), nodes: Vec::new(), cells: Some(Cells::default()) })).collect()
		}
	}

	fn edge_cells(co: &Coarse, edges: &[u32], acc: &mut Cells) {
		if let Some(ec) = &co.cells {
			let (off, keys, yds) = (ec.off(), ec.keys(), ec.yards());
			for &x in edges {
				for c in off[x as usize] as usize..off[x as usize + 1] as usize {
					acc.add(keys[c], yds[c] as f64);
				}
			}
		}
	}

	fn reachable(a: &Snapped, b: &Option<Snapped>) -> bool {
		match b {
			Some(b) => b.c == a.c && !(a.region.is_some() && b.region.is_some() && a.region != b.region),
			None => false,
		}
	}

	/// Rows -> per row per target a walk (cch.js distanceRows, fast yards: the edges' own).
	pub fn rows(&self, rows: &[Row], p: &Profile, zones_tag: &str, cells: bool) -> Result<(Vec<Vec<Walk>>, Stats), String> {
		let t_all = std::time::Instant::now();
		let mut stats = Stats { rows: rows.len(), pairs: rows.iter().map(|r| r.targets.len()).sum(), ..Default::default() };
		// Snaps (distinct asks), then each continent's coarse side.
		let snapped: Vec<(Option<Snapped>, Vec<Option<Snapped>>)> = rows.par_iter().map(|r| (self.snap(&r.source), r.targets.iter().map(|t| self.snap(t)).collect())).collect();
		let mut conts: Vec<u32> = snapped.iter().filter_map(|s| s.0.map(|a| a.c)).collect();
		conts.sort_unstable();
		conts.dedup();
		let mut coarse = FxHashMap::default();
		for c in conts {
			if let Some(co) = self.coarse(c, p, zones_tag)? {
				coarse.insert(c, co);
			}
		}
		// Legs: every distinct goal and start, on threads, kept per place.
		let t_legs = std::time::Instant::now();
		let mut ends: Vec<(Snapped, bool)> = Vec::new();
		for (a, ts) in &snapped {
			let Some(a) = a else { continue };
			if coarse.get(&a.c).is_none_or(|co| co.yards.is_none()) {
				continue;
			}
			ends.push((*a, false));
			for b in ts.iter().flatten() {
				if Self::reachable(a, &Some(*b)) {
					ends.push((*b, true));
				}
			}
		}
		ends.sort_by_key(|(e, goal)| (e.c, e.col, e.row, e.entry, *goal));
		ends.dedup_by_key(|(e, goal)| (e.c, e.col, e.row, e.entry, *goal));
		ends.par_iter().for_each_init(Tree::default, |sc, (e, goal)| {
			let co = &coarse[&e.c];
			if *goal {
				self.goal_of(&co.graph, e, p, sc, cells);
			} else {
				self.start_of(&co.graph, e, p, sc, cells);
			}
		});
		stats.legs_ms = t_legs.elapsed().as_secs_f64() * 1e3;
		let t_search = std::time::Instant::now();
		// Danger-free rows on a CCH: one native rows call per continent (cch.js distanceRows).
		let mut cch_out: FxHashMap<usize, Vec<Option<(f64, f64, Option<Cells>)>>> = FxHashMap::default();
		if self.use_cch && p.area.is_none() {
			for (&c, co) in &coarse {
				// A metric costs seconds to customize: worth it for a table's rows, not a route's few.
				let n_rows = snapped.iter().filter(|s| s.0.is_some_and(|a| a.c == c)).count();
				let have = self.metrics.lock().contains_key(&(c, p.edge_key(0)));
				if !have && n_rows < CCH_ROWS {
					continue;
				}
				let Some(m) = self.metric(c, co, p)? else { continue };
				let (s, metric) = (&m.0, &m.1);
				let rows_c: Vec<usize> = (0..snapped.len()).filter(|&i| snapped[i].0.is_some_and(|a| a.c == c)).collect();
				let mut tree = Tree::default();
				let mut src_off = vec![0u32];
				let mut src = Vec::new();
				let mut starts = Vec::new();
				let mut goal_ix: FxHashMap<(u32, u32, u32), u32> = FxHashMap::default();
				let mut goals: Vec<Arc<Legs>> = Vec::new();
				let (mut row_off, mut row_dst, mut row_at) = (vec![0u32], Vec::new(), Vec::new());
				for &i in &rows_c {
					let a = snapped[i].0.unwrap();
					let st = self.start_of(&co.graph, &a, p, &mut tree, cells);
					if let Some(st) = &st {
						for k in 0..st.0.nodes.len() {
							src.push(crate::cch::query::Seed { node: st.0.nodes[k], cost: st.0.sec[k], yards: st.0.yd[k] });
						}
					}
					src_off.push(src.len() as u32);
					starts.push(st);
					for (j, b) in snapped[i].1.iter().enumerate() {
						if !Self::reachable(&a, b) {
							continue;
						}
						let b = b.unwrap();
						let gk = (b.col, b.row, b.entry);
						let ix = *goal_ix.entry(gk).or_insert_with(|| {
							goals.push(self.goal_of(&co.graph, &b, p, &mut tree, cells));
							(goals.len() - 1) as u32
						});
						row_dst.push(ix);
						row_at.push((i, j));
					}
					row_off.push(row_dst.len() as u32);
				}
				let mut dst_off = vec![0u32];
				let mut dst = Vec::new();
				for l in &goals {
					for k in 0..l.nodes.len() {
						dst.push(crate::cch::query::Seed { node: l.nodes[k], cost: l.sec[k], yards: l.yd[k] });
					}
					dst_off.push(dst.len() as u32);
				}
				let mut res: FxHashMap<usize, Vec<Option<(f64, f64, Option<Cells>)>>> = FxHashMap::default();
				let put = |res: &mut FxHashMap<usize, Vec<Option<(f64, f64, Option<Cells>)>>>, i: usize, j: usize, v: (f64, f64, Option<Cells>)| {
					res.entry(i).or_insert_with(|| vec![None; snapped[i].1.len()])[j] = Some(v);
				};
				match (cells, co.cells.as_ref()) {
					(true, Some(ec)) => {
						let r = crate::cch::query::rows_cells(s, metric, ec, &src_off, &src, &dst_off, &dst, &row_off, &row_dst);
						let row_ix: FxHashMap<usize, usize> = rows_c.iter().enumerate().map(|(r, &i)| (i, r)).collect();
						for k in 0..row_dst.len() {
							if r.cost[k] < 0.0 {
								continue;
							}
							let (i, j) = row_at[k];
							let st = starts[row_ix[&i]].as_ref().unwrap();
							let mut acc = Cells::default();
							acc.add_all(&st.0.cells.as_ref().unwrap()[r.from[k] as usize]);
							for x in r.cells_off[k] as usize..r.cells_off[k + 1] as usize {
								acc.add(r.cells_key[x], r.cells_yards[x]);
							}
							acc.add_all(&goals[row_dst[k] as usize].cells.as_ref().unwrap()[r.to[k] as usize]);
							put(&mut res, i, j, (r.cost[k], r.yards[k], Some(acc)));
						}
					}
					_ => {
						let (cost, yards) = crate::cch::query::rows(s, metric, &src_off, &src, &dst_off, &dst, &row_off, &row_dst);
						for k in 0..row_dst.len() {
							if cost[k] >= 0.0 {
								let (i, j) = row_at[k];
								put(&mut res, i, j, (cost[k], yards[k], None));
							}
						}
					}
				}
				for &i in &rows_c {
					cch_out.insert(i, res.remove(&i).unwrap_or_else(|| vec![None; snapped[i].1.len()]));
				}
			}
		}
		let retried = std::sync::atomic::AtomicUsize::new(0);
		let out: Vec<Vec<Walk>> = snapped
			.par_iter()
			.enumerate()
			.map_init(Scratch::default, |scr, (ri, (a, ts))| {
				let mut out = vec![Walk::NONE; ts.len()];
				let Some(a) = a else { return out };
				let Some(co) = coarse.get(&a.c) else { return out };
				let g = &co.graph;
				if co.yards.is_none() {
					// No edge yards (prepareYards): each row as routeMany asks it (cch.js exact).
					let live: Vec<usize> = (0..ts.len()).filter(|&j| ts[j].is_some()).collect();
					let tg: Vec<Snapped> = live.iter().map(|&j| ts[j].unwrap()).collect();
					for (&j, w) in live.iter().zip(self.route_many(co, a, &tg, p, cells, false, scr)) {
						out[j] = w;
					}
					return out;
				}
				let st = self.start_of(g, a, p, &mut scr.tree, cells);
				// Ends in the start's tile: inside it (the graph way wins only when cheaper).
				let mut fw_done = false;
				for (j, b) in ts.iter().enumerate() {
					let Some(b) = b else { continue };
					if !Self::reachable(a, &Some(*b)) || st.is_none() || !b.same_tile(a) {
						continue;
					}
					let t = self.grid.tile(a.c, a.col as i64, a.row as i64).unwrap();
					if !fw_done {
						self.nav.tile_tree(&t, a.entry as usize, a.k(), p, false, &mut scr.fw);
						fw_done = true;
					}
					if scr.fw.reached(b.entry as usize) {
						out[j] = Walk { seconds: scr.fw.dist[b.entry as usize], yards: scr.fw.yd[b.entry as usize], cells: cells.then(|| self.nav.tree_cells(&t, &scr.fw, b.entry as usize, false)) };
					}
				}
				if let Some(cv) = cch_out.get(&ri) {
					for (j, v) in cv.iter().enumerate() {
						let Some((v, y, c)) = v else { continue };
						let o = &mut out[j];
						if !(o.seconds >= 0.0 && o.seconds <= *v) {
							*o = Walk { seconds: *v, yards: *y, cells: c.clone() };
						}
					}
				} else if let Some(st) = &st {
					let live: Vec<usize> = (0..ts.len()).filter(|&j| Self::reachable(a, &ts[j])).collect();
					let goals: Vec<Arc<Legs>> = live.iter().map(|&j| self.goal_of(g, ts[j].as_ref().unwrap(), p, &mut scr.tree, cells)).collect();
					let refs: Vec<&Legs> = goals.iter().map(|x| x.as_ref()).collect();
					let found = self.search(co, p, &st.0, &refs, &mut scr.search);
					for ((&j, f), gl) in live.iter().zip(found).zip(&goals) {
						let Some(f) = f else { continue };
						let o = &mut out[j];
						if o.seconds >= 0.0 && o.seconds <= f.cost {
							continue;
						}
						let mut acc = None;
						if cells {
							let mut c = Cells::default();
							c.add_all(&st.0.cells.as_ref().unwrap()[f.from]);
							match &f.cells {
								Some(fc) => c.add_all(fc),
								None => Self::edge_cells(co, &f.edges, &mut c),
							}
							c.add_all(&gl.cells.as_ref().unwrap()[f.to]);
							acc = Some(c);
						}
						*o = Walk { seconds: f.cost, yards: if co.yards.is_some() { f.yards } else { -1.0 }, cells: acc };
					}
				}
				// Pairs no way reached: as routeMany asks them.
				let miss: Vec<usize> = (0..ts.len()).filter(|&j| out[j].seconds < 0.0 && Self::reachable(a, &ts[j])).collect();
				if !miss.is_empty() {
					retried.fetch_add(miss.len(), std::sync::atomic::Ordering::Relaxed);
					let tg: Vec<Snapped> = miss.iter().map(|&j| ts[j].unwrap()).collect();
					let res = self.route_many(co, a, &tg, p, cells, false, scr);
					for (&j, w) in miss.iter().zip(res) {
						if w.seconds >= 0.0 {
							out[j] = w;
						}
					}
				}
				out
			})
			.collect();
		stats.retried = retried.into_inner();
		stats.search_ms = t_search.elapsed().as_secs_f64() * 1e3;
		stats.total_ms = t_all.elapsed().as_secs_f64() * 1e3;
		stats.relaxed = self.relaxed.swap(0, std::sync::atomic::Ordering::Relaxed);
		Ok((out, stats))
	}

	/// cch.js routeManyRaw (path.js routeMany semantics) over the coarse search: the start's own
	/// legs, its pocket settled when it reaches nothing, each goal's own legs, its pocket settled
	/// per pair. Yards from the edges' own (not path.js pieces).
	fn route_many(&self, co: &Coarse, a: &Snapped, targets: &[Snapped], p: &Profile, cells: bool, settled: bool, scr: &mut Scratch) -> Vec<Walk> {
		let g = &co.graph;
		let tn = targets.len();
		let mut out = vec![Walk::NONE; tn];
		let Some(t) = self.grid.tile(a.c, a.col as i64, a.row as i64) else { return out };
		let Some(s) = self.nav.start_legs(g, a, p, &mut scr.fw, cells) else { return out };
		let live: Vec<usize> = (0..tn).filter(|&j| Self::reachable(a, &Some(targets[j]))).collect();
		let mut direct = vec![f64::INFINITY; tn];
		let mut direct_yd = vec![0.0; tn];
		let mut direct_cells: Vec<Option<Cells>> = vec![None; tn];
		for &j in &live {
			let b = &targets[j];
			if b.same_tile(a) && scr.fw.reached(b.entry as usize) {
				direct[j] = scr.fw.dist[b.entry as usize];
				direct_yd[j] = scr.fw.yd[b.entry as usize];
				if cells {
					direct_cells[j] = Some(self.nav.tree_cells(&t, &scr.fw, b.entry as usize, false));
				}
			}
		}
		let has_nodes = g.tile_of(a.col, a.row).is_some_and(|gt| gt.node_count > 0);
		if g.tile_of(a.col, a.row).is_some() && s.nodes.is_empty() && has_nodes && !settled && live.iter().all(|&j| direct[j] == f64::INFINITY) {
			for e in self.nav.settle_candidates(a, p, false, &mut scr.tree) {
				let res = self.route_many(co, &e, targets, p, cells, true, scr);
				if res.iter().any(|w| w.seconds >= 0.0) {
					return res;
				}
			}
			return out;
		}
		let mut first: Vec<Option<(Found, Legs)>> = (0..tn).map(|_| None).collect();
		if !s.nodes.is_empty() {
			let legs: Vec<Legs> = live.iter().map(|&j| self.goal_legs(g, &targets[j], p, &mut scr.tree, cells)).collect();
			let refs: Vec<&Legs> = legs.iter().collect();
			let found = self.search(co, p, &s, &refs, &mut scr.search);
			for ((&j, f), l) in live.iter().zip(found).zip(legs) {
				if let Some(f) = f {
					first[j] = Some((f, l));
				}
			}
		}
		// Goals nothing reached: the surfaces around each (settleCandidates, nearest first), the first
		// the start's tile search reaches directly or the graph reaches taken. Every candidate's legs
		// go into one search (each goal's best is its own, so this equals one search per candidate).
		let mut cand: Vec<Vec<(Snapped, bool, Option<usize>)>> = vec![Vec::new(); tn];
		let mut cand_legs: Vec<Legs> = Vec::new();
		if g.tile_of(a.col, a.row).is_some() {
			for &j in &live {
				if direct[j] != f64::INFINITY || first[j].is_some() {
					continue;
				}
				for e in self.nav.settle_candidates(&targets[j], p, true, &mut scr.tree) {
					let hit = e.same_tile(a) && scr.fw.reached(e.entry as usize);
					let mut li = None;
					if !hit && !s.nodes.is_empty() {
						let lb = self.goal_legs(g, &e, p, &mut scr.tree, cells);
						if !lb.nodes.is_empty() {
							cand_legs.push(lb);
							li = Some(cand_legs.len() - 1);
						}
					}
					cand[j].push((e, hit, li));
					if hit {
						break;
					}
				}
			}
		}
		let mut cand_found: Vec<Option<Found>> = if cand_legs.is_empty() {
			Vec::new()
		} else {
			let refs: Vec<&Legs> = cand_legs.iter().collect();
			self.search(co, p, &s, &refs, &mut scr.search)
		};
		let mut cand_legs: Vec<Option<Legs>> = cand_legs.into_iter().map(Some).collect();
		for &j in &live {
			let mut best = direct[j];
			let mut res: Option<(Found, Legs)> = None;
			let (mut d_yd, mut d_cells) = (direct_yd[j], direct_cells[j].take());
			if let Some((f, l)) = first[j].take() {
				if f.cost < best {
					best = f.cost;
					res = Some((f, l));
				}
			}
			if best == f64::INFINITY {
				for (e, hit, li) in &cand[j] {
					if *hit {
						best = scr.fw.dist[e.entry as usize];
						d_yd = scr.fw.yd[e.entry as usize];
						if cells {
							d_cells = Some(self.nav.tree_cells(&t, &scr.fw, e.entry as usize, false));
						}
						break;
					}
					if let Some(f) = li.and_then(|i| cand_found[i].take()) {
						best = f.cost;
						res = Some((f, cand_legs[li.unwrap()].take().unwrap()));
						break;
					}
				}
			}
			if best == f64::INFINITY {
				continue;
			}
			out[j] = match res {
				None => Walk { seconds: best, yards: d_yd, cells: if cells { d_cells } else { None } },
				Some((f, l)) if co.yards.is_some() => {
					let mut acc = None;
					if cells {
						let mut c = Cells::default();
						c.add_all(&s.cells.as_ref().unwrap()[f.from]);
						match &f.cells {
							Some(fc) => c.add_all(fc),
							None => Self::edge_cells(co, &f.edges, &mut c),
						}
						c.add_all(&l.cells.as_ref().unwrap()[f.to]);
						acc = Some(c);
					}
					Walk { seconds: best, yards: f.yards, cells: acc }
				}
				Some((f, l)) => {
					// The cell path's yards: the start leg, a piece per abstract edge, the goal leg (path.js routeMany).
					let mut y = s.yd[f.from] + l.yd[f.to];
					let mut acc = Cells::default();
					for w in f.nodes.windows(2) {
						let pc = self.piece(g, w[0], w[1], p, &mut scr.astar, cells);
						y += pc.0;
						if cells {
							acc.add_all(&pc.1);
						}
					}
					if cells {
						acc.add_all(&s.cells.as_ref().unwrap()[f.from]);
						acc.add_all(&l.cells.as_ref().unwrap()[f.to]);
					}
					Walk { seconds: best, yards: y, cells: cells.then_some(acc) }
				}
			};
		}
		out
	}

	/// The drawn way of one walk on the grid (the guide bake's, path.js route without its line
	/// smoothing): the cells from a to b, each with its floor and the class of the step into it,
	/// and the walk's cost (seconds × the profile's multipliers). The coarse search runs as
	/// route_many's (start legs, Dijkstra over the walk graph, goal legs; a goal in a pocket moved
	/// to the first surface near it that is reached); each abstract edge, the start leg and the goal
	/// leg are then drawn by piece_cells. A pair in one tile that the start's tile search reaches
	/// for less than the graph is one piece. -> None: no way (or no grid there).
	pub fn route_path(&self, a: &SnapAsk, b: &SnapAsk, p: &Profile, zones_tag: &str) -> Result<Option<GridWay>, String> {
		let (Some(sa), Some(sb)) = (self.snap(a), self.snap(b)) else { return Ok(None) };
		if !Self::reachable(&sa, &Some(sb)) {
			return Ok(None);
		}
		let Some(co) = self.coarse(sa.c, p, zones_tag)? else { return Ok(None) };
		let g = &co.graph;
		let mut scr = Scratch::default();
		let Some(s) = self.nav.start_legs(g, &sa, p, &mut scr.fw, false) else { return Ok(None) };
		let direct = |scr: &Scratch, e: &Snapped| (e.same_tile(&sa) && scr.fw.reached(e.entry as usize)).then(|| scr.fw.dist[e.entry as usize]);
		let mut goals = vec![sb];
		if g.tile_of(sa.col, sa.row).is_some() {
			goals.extend(self.nav.settle_candidates(&sb, p, true, &mut scr.tree));
		}
		for e in goals {
			let mut best: Option<(f64, Option<Found>)> = direct(&scr, &e).map(|d| (d, None));
			if !s.nodes.is_empty() {
				let l = self.nav.goal_legs(g, &e, p, &mut scr.tree, false);
				if let Some(f) = self.search(&co, p, &s, &[&l], &mut scr.search).into_iter().next().flatten() {
					if best.as_ref().is_none_or(|b| f.cost < b.0) {
						best = Some((f.cost, Some(f)));
					}
				}
			}
			let Some((cost, found)) = best else { continue };
			let mut cells: Vec<WayCell> = Vec::new();
			let mut add = |part: Option<Vec<WayCell>>, from: &Snapped, to: &Snapped| {
				let part = part.unwrap_or_else(|| {
					// No cell way between two points the search joined (a node's own column): a straight step.
					let floor = 0;
					vec![WayCell { x: from.wx, y: from.wy, z: from.z, floor, cls: 0 }, WayCell { x: to.wx, y: to.wy, z: to.z, floor, cls: crate::grid::cls::WALK }]
				});
				let skip = usize::from(!cells.is_empty());
				cells.extend(part.into_iter().skip(skip));
			};
			match found {
				None => add(piece_cells(&self.grid, &sa, &e, p, &mut scr.astar), &sa, &e),
				Some(f) => {
					let mut at = sa;
					for &x in &f.nodes {
						let n = Self::node_point(g, x);
						if !(n.same_tile(&at) && n.entry == at.entry) {
							add(piece_cells(&self.grid, &at, &n, p, &mut scr.astar), &at, &n);
						}
						at = n;
					}
					if !(e.same_tile(&at) && e.entry == at.entry) {
						add(piece_cells(&self.grid, &at, &e, p, &mut scr.astar), &at, &e);
					}
				}
			}
			if cells.len() < 2 {
				cells = vec![WayCell { x: sa.wx, y: sa.wy, z: sa.z, floor: 0, cls: 0 }, WayCell { x: e.wx, y: e.wy, z: e.z, floor: 0, cls: crate::grid::cls::WALK }];
			}
			return Ok(Some(GridWay { cells, seconds: cost, settled: e != sb }));
		}
		Ok(None)
	}

	/// The straight-line fast path (after Factoruide's fg-route terrain/mod.rs: a walk whose straight
	/// segment is plain is that segment). The 8-connected line from a to b (Bresenham: octile
	/// length) followed through the grid's links, every step a plain walk (link class WALK, no swim,
	/// no steep face, the profile's multiplier exactly 1: no road, hub or danger), ending on b's
	/// surface. It is the walk when it is provably within STRAIGHT_SLACK of the best way: no way
	/// costs less than its octile length at the fastest speed (every multiplier but a road's is at
	/// least 1), and no road lies in reach (no tile within the ellipse a road walk would need holds a
	/// road). -> the walk (seconds, yards, cells), or None (ask the router).
	pub fn straight(&self, a: &Snapped, b: &Snapped, p: &Profile, cells: bool) -> Option<Walk> {
		use crate::grid::{flag, DIRS, NO_LINK, TILE_CELLS};
		if a.c != b.c || (a.region.is_some() && b.region.is_some() && a.region != b.region) {
			return None;
		}
		let ts = TILE_CELLS as i64;
		let (x0, y0) = (a.col as i64 * ts + a.i as i64, a.row as i64 * ts + a.j as i64);
		let (x1, y1) = (b.col as i64 * ts + b.i as i64, b.row as i64 * ts + b.j as i64);
		let (adx, ady) = ((x1 - x0).abs(), (y1 - y0).abs());
		let (sx, sy) = ((x1 - x0).signum(), (y1 - y0).signum());
		let (long, short) = (adx.max(ady), adx.min(ady));
		let octile = short as f64 * crate::grid::CELL * std::f64::consts::SQRT_2 + (long - short) as f64 * crate::grid::CELL;
		let max_speed = p.outdoor.max(p.indoor).max(p.swim);
		let mut t = self.grid.tile(a.c, a.col as i64, a.row as i64)?;
		let mut tc_tile = (t.col, t.row);
		let mut tc = p.in_tile(&t);
		let (mut x, mut y, mut e) = (x0, y0, a.entry as usize);
		let mut za = a.z;
		let (mut seconds, mut yards) = (0.0, 0.0);
		let mut acc = Cells::default();
		// Bresenham over the long axis.
		let mut err = 0i64;
		for _ in 0..long {
			let (mut mx, mut my) = (0, 0);
			err += short;
			if adx >= ady {
				mx = sx;
				if 2 * err >= long {
					my = sy;
					err -= long;
				}
			} else {
				my = sy;
				if 2 * err >= long {
					mx = sx;
					err -= long;
				}
			}
			let d = DIRS.iter().position(|q| q.0 as i64 == mx && q.1 as i64 == my)?;
			let lk = t.links[e * 8 + d];
			if lk == NO_LINK || lk >> 5 != crate::grid::cls::WALK {
				return None;
			}
			let fa = t.flags[e];
			let (nx, ny) = (x + mx, y + my);
			let (ncol, nrow) = (nx.div_euclid(ts), ny.div_euclid(ts));
			if (ncol as u32, nrow as u32) != tc_tile {
				t = self.grid.tile(a.c, ncol, nrow)?;
				tc_tile = (t.col, t.row);
				tc = p.in_tile(&t);
			}
			let k2 = ((ny - nrow * ts) * ts + (nx - ncol * ts)) as usize;
			let v = t.first[k2] as usize + (lk & 31) as usize;
			let fb = t.flags[v];
			if (fa | fb) & (flag::SWIM | flag::STEEP) != 0 || tc.at(k2, fb) != 1.0 {
				return None;
			}
			let h = if mx != 0 && my != 0 { crate::grid::CELL * std::f64::consts::SQRT_2 } else { crate::grid::CELL };
			let dz = t.z[v] as f64 - za;
			za = t.z[v] as f64;
			let dist = (h * h + dz * dz).sqrt();
			seconds += p.link_seconds(crate::grid::cls::WALK, fa, fb, dist);
			yards += dist;
			if cells {
				acc.add(forge_core::cells::cell_key(t.wx(k2), t.wy(k2)) as u32, dist);
			}
			x = nx;
			y = ny;
			e = v;
		}
		if (t.col, t.row) != (b.col, b.row) || e != b.entry as usize {
			return None;
		}
		if !self.straight_exact {
			return Some(Walk { seconds, yards, cells: cells.then_some(acc) });
		}
		if seconds > (octile / max_speed) * (1.0 + STRAIGHT_SLACK) {
			return None;
		}
		// No road in reach: a road walk of length l costs at least l × ROAD / speed, so it can beat
		// the line only inside the ellipse of foci a, b and distance sum seconds × speed / ROAD.
		let reach = seconds * max_speed / crate::cost::ROAD;
		let (ax, ay, bx, by) = (a.wx, a.wy, b.wx, b.wy);
		let ext = (reach - forge_core::jsnum::js_hypot(ax - bx, ay - by)).max(0.0) / 2.0;
		let (lo_x, hi_x, lo_y, hi_y) = (ax.min(bx) - ext, ax.max(bx) + ext, ay.min(by) - ext, ay.max(by) + ext);
		let adt = crate::grid::ADT;
		let (c0, c1) = ((32.0 - hi_y / adt).floor() as i64, (32.0 - lo_y / adt).floor() as i64);
		let (r0, r1) = ((32.0 - hi_x / adt).floor() as i64, (32.0 - lo_x / adt).floor() as i64);
		for col in c0..=c1 {
			for row in r0..=r1 {
				let (x1t, y1t) = ((32 - row) as f64 * adt, (32 - col) as f64 * adt);
				let rect = |px: f64, py: f64| forge_core::jsnum::js_hypot((x1t - adt - px).max(0.0).max(px - x1t), (y1t - adt - py).max(0.0).max(py - y1t));
				if rect(ax, ay) + rect(bx, by) > reach {
					continue;
				}
				if p.ground.has_road(a.c, col, row) {
					return None;
				}
			}
		}
		Some(Walk { seconds, yards, cells: cells.then_some(acc) })
	}

	/// router.js zoneAt: the zone of the chunk under (wx, wy), 0 off the grid's tiles.
	pub fn zone_at(&self, zones: &crate::cost::Zones, c: u32, wx: f64, wy: f64) -> u16 {
		let adt = crate::grid::ADT;
		let col = (32.0 - wy / adt).floor() as i64;
		let row = (32.0 - wx / adt).floor() as i64;
		let Some(t) = self.grid.tile(c, col, row) else { return zones.grid_zone(c, wx, wy) };
		let j = (((32 - row) as f64 * adt - wx) / crate::grid::CELL).floor() as i64;
		let i = (((32 - col) as f64 * adt - wy) / crate::grid::CELL).floor() as i64;
		zones.chunks(&t)[(((j >> 4) << 4) + (i >> 4)) as usize]
	}

	/// Places' legs kept (starts, goals).
	pub fn legs_kept(&self) -> (usize, usize) {
		(self.starts.lock().len(), self.goals.lock().len())
	}
}

/// The ground and zones files a walker's profiles read: hubs.json next to the grid's layers.
pub fn hubs_file(grid_dir: &Path) -> std::path::PathBuf {
	grid_dir.parent().unwrap_or(grid_dir).join("nav-layers").join("hubs.json")
}

/// The walk store's router (store.rs Router) over a Walker: each model is a registered profile.
/// A pair is answered by the straight line when it is plain (Walker::straight), else asked of the
/// walker in rows by source; a pair not walked at its ends' own heights is asked again at the
/// surfaces' (walktables.js `again`). Answers as walktables.js stores them: yards and cost rounded
/// to 0.1, walked yards × smooth.
pub struct StoreRouter<'w> {
	pub walker: &'w Walker,
	pub models: FxHashMap<crate::store::Model, (Arc<Profile>, String)>,
	pub smooth: f64,
	pub straight: bool,
	pub cells: bool,
	/// Pairs the straight line answered, pairs the walker answered, the walker's stats.
	pub by_line: usize,
	pub by_router: usize,
	pub stats: Vec<Stats>,
	/// Progress: (pairs routed so far, pairs to route in this call).
	pub log: Option<Box<dyn Fn(usize, usize) + Send + Sync + 'w>>,
}

impl<'w> StoreRouter<'w> {
	pub fn new(walker: &'w Walker, smooth: f64) -> Self {
		StoreRouter { walker, models: FxHashMap::default(), smooth, straight: true, cells: false, by_line: 0, by_router: 0, stats: Vec::new(), log: None }
	}

	fn ask(e: &crate::store::End, full: bool) -> SnapAsk {
		let z = if full { e.zf } else { e.z };
		SnapAsk { c: e.c as u32, wx: e.x, wy: e.y, z: if z.is_nan() { None } else { Some(z) }, radius: 20.0, under: true, stand: true }
	}

	fn answer(&self, w: &Walk, run: f64) -> crate::store::Answer {
		if w.seconds >= 0.0 && w.yards >= 0.0 {
			crate::store::Answer { yd: forge_core::jsnum::round1(w.yards) * self.smooth, cost: forge_core::jsnum::round1(w.seconds * run) }
		} else {
			crate::store::Answer::NONE
		}
	}

	fn run_rows(&mut self, pairs: &[(crate::store::End, crate::store::End)], idx: &[usize], p: &Profile, zones_tag: &str, full: bool) -> Result<Vec<Walk>, String> {
		// Rows by source end, in first-seen order.
		let mut rows: Vec<Row> = Vec::new();
		let mut at: Vec<(usize, usize)> = Vec::with_capacity(idx.len());
		let mut by_src: FxHashMap<[u64; 3], usize> = FxHashMap::default();
		for &i in idx {
			let a = &pairs[i].0;
			let key = [a.c as u64, a.x.to_bits(), a.y.to_bits() ^ if full { a.zf.to_bits() } else { a.z.to_bits() }];
			let r = *by_src.entry(key).or_insert_with(|| {
				rows.push(Row { source: Self::ask(a, full), targets: Vec::new() });
				rows.len() - 1
			});
			at.push((r, rows[r].targets.len()));
			rows[r].targets.push(Self::ask(&pairs[i].1, full));
		}
		let (out, st) = self.walker.rows(&rows, p, zones_tag, self.cells)?;
		self.stats.push(st);
		Ok(at.iter().map(|&(r, j)| out[r][j].clone()).collect())
	}
}

fn zone_cells(c: &Option<Cells>) -> Option<crate::store::ZoneCells> {
	c.as_ref().map(|c| c.0.iter().map(|&(k, y)| (k, forge_core::jsnum::round1(y) as f32)).collect())
}

impl crate::store::Router for StoreRouter<'_> {
	fn walks(&mut self, model: &crate::store::Model, pairs: &[(crate::store::End, crate::store::End)], cells: bool) -> Vec<(crate::store::Answer, Option<crate::store::ZoneCells>)> {
		let Some((p, zones_tag)) = self.models.get(model).cloned() else {
			panic!("walk store: no profile registered for model {} {}", model.grid, model.params);
		};
		self.cells = cells;
		let mut out = vec![(crate::store::Answer::NONE, None); pairs.len()];
		let mut rest = Vec::new();
		for (i, (a, b)) in pairs.iter().enumerate() {
			if self.straight {
				if let (Some(sa), Some(sb)) = (self.walker.snap(&Self::ask(a, false)), self.walker.snap(&Self::ask(b, false))) {
					if let Some(w) = self.walker.straight(&sa, &sb, &p, self.cells) {
						out[i] = (self.answer(&w, p.run), zone_cells(&w.cells));
						self.by_line += 1;
						continue;
					}
				}
			}
			rest.push(i);
		}
		if rest.is_empty() {
			return out;
		}
		let rest: Vec<usize> = rest;
		self.by_router += rest.len();
		// In runs of rows (each run's walks and cells held at once, then dropped).
		let mut got: Vec<Walk> = Vec::with_capacity(rest.len());
		for part in rest.chunks(ROUTER_CHUNK) {
			let g = self.run_rows(pairs, part, &p, &zones_tag, false).unwrap_or_else(|e| panic!("{e}"));
			if let Some(log) = &self.log {
				log(got.len() + part.len(), rest.len());
			}
			got.extend(g);
		}
		let mut again = Vec::new();
		for (&i, w) in rest.iter().zip(&got) {
			out[i] = (self.answer(w, p.run), zone_cells(&w.cells));
			let (a, b) = &pairs[i];
			let differs = |e: &crate::store::End| e.z.to_bits() != e.zf.to_bits() && !(e.z.is_nan() && e.zf.is_nan());
			if out[i].0.yd < 0.0 && (differs(a) || differs(b)) {
				again.push(i);
			}
		}
		if !again.is_empty() {
			let got = self.run_rows(pairs, &again, &p, &zones_tag, true).unwrap_or_else(|e| panic!("{e}"));
			for (&i, w) in again.iter().zip(&got) {
				let x = self.answer(w, p.run);
				if x.yd >= 0.0 {
					out[i] = (x, zone_cells(&w.cells));
				}
			}
		}
		out
	}
}
