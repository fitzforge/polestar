//! `forge nav prepare`: what the walks stage routes on, built where missing into `<grid>/walk/` (port
//! of tools/lib/nav/router.js prepare and buildRoads, path.js repriceTiles, mixTiles and
//! encodeMix; byte-identical files under the same names):
//! - `roads-<c>-<tag>.bin`: the road mask (roadmask.rs over the roads layer): per tile with a road
//!   its col and row (uint16 each) and 8192 bytes, one bit per column (k = j * 256 + i);
//! - `<c>-0-<sha>.f32` per faction (none, Alliance, Horde): the walk graph, every coarse edge's
//!   seconds for that faction's ground (edgecost.js: time, faces, roads, hostile hubs). An edge
//!   inside a tile is priced by a search of the tile from its start node (path.js tileTree with
//!   the faction's ground); an edge across a border or a lift its terms' seconds, times FACE where
//!   either end stands on a STEEP column, times the ground multiplier of the surface it enters. A
//!   faction's graph is the factionless one with only the tiles a hostile hub's disk reaches, and
//!   their neighbours, searched again;
//! - `<c>-0-<sha>.mix`: the zone mix, the shares of each edge's way's seconds per zone on the
//!   factionless walk graph's ways (an edge across a border or a lift ride is one step into its end
//!   node's zone).
//!
//! The tiles are searched on `threads` threads (rayon); every output is in the graph's order, so
//! the files do not depend on the thread count.

use crate::cost::{Ground, Profile, Zones, JUMP_SECONDS};
use crate::grid::{flag, Graph, Grid, Tile, TILE_CELLS};
use crate::legs::{Nav, Tree};
use crate::roadmask::{road_mask, RoadStats};
use crate::walker::{mix_file, walk_graph_file};
use rayon::prelude::*;
use std::path::{Path, PathBuf};
use std::sync::Arc;
use std::time::Instant;

/// Node's roadmask.js, the road mask tag's code part (router.js roadsTag hashes the builder's source).
const ROADMASK_JS: &[u8] = include_bytes!("roadmask.js");
/// graph.js TERM_SCALE.
const TERM_SCALE: [f64; 7] = [4.0, 4.0, 4.0, 1.0, 10.0, 1.0, 10.0];
/// Tiles per parallel batch (bounds the results held at once).
const BATCH: usize = 64;

pub struct PrepareIn<'a> {
	/// The navigation grid (index.json, graph/, tiles/); outputs go to its walk/.
	pub grid: &'a Path,
	/// The roads layer (index.json, <c>/<col>_<row>.bin); none there: no road anywhere.
	pub roads: &'a Path,
	/// The hubs layer (hubs.json); missing: no hubs.
	pub hubs: &'a Path,
	/// The newest cached Forever AreaTable.csv (its folder names the build) and data/forever/zones.json.
	pub area_table: &'a Path,
	pub zones: &'a Path,
	/// None: every continent of the grid's index.
	pub continents: Option<Vec<u32>>,
	pub threads: usize,
	pub log: &'a (dyn Fn(&str) + Sync),
}

/// One file prepare built or kept: what is "roads", "none" / "Alliance" / "Horde" (a walk graph) or "mix".
#[derive(Clone, Debug)]
pub struct Built {
	pub c: u32,
	pub what: &'static str,
	pub file: PathBuf,
	pub built: bool,
	pub seconds: f64,
}

/// router.js roadsTag: sha1 of the roads layer's index.json, the grid's build and roadmask.js
/// [:16]; "none" without a roads layer.
pub fn roads_tag(grid: &Path, roads: &Path) -> String {
	let Ok(idx) = std::fs::read(roads.join("index.json")) else { return "none".into() };
	let built =
		std::fs::read(grid.join("index.json")).ok().and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok()).and_then(|v| v["builtAt"].as_str().map(String::from)).unwrap_or_default();
	let mut h = forge_core::key::ContentHasher::new();
	h.update(&idx).update(format!("\n{built}\n").as_bytes()).update(ROADMASK_JS);
	h.hex()[..16].to_string()
}

pub fn roads_file(grid: &Path, c: u32, tag: &str) -> PathBuf {
	grid.join("walk").join(format!("roads-{c}-{tag}.bin"))
}

fn write_atomic(file: &Path, bytes: &[u8]) -> Result<(), String> {
	if let Some(d) = file.parent() {
		std::fs::create_dir_all(d).map_err(|e| format!("{}: {e}", d.display()))?;
	}
	let tmp = PathBuf::from(format!("{}.tmp", file.display()));
	std::fs::write(&tmp, bytes).map_err(|e| format!("{}: {e}", tmp.display()))?;
	std::fs::rename(&tmp, file).map_err(|e| format!("{}: {e}", file.display()))
}

/// The tiles of continent c in the grid index's order ("col_row").
pub(crate) fn index_tiles(grid: &Grid, c: u32) -> Vec<(u32, u32)> {
	grid.index["continents"][c.to_string()]["tiles"]
		.as_array()
		.into_iter()
		.flatten()
		.filter_map(|v| {
			let (a, b) = v.as_str()?.split_once('_')?;
			Some((a.parse().ok()?, b.parse().ok()?))
		})
		.collect()
}

/// buildRoads: continent c's road mask file when missing -> (built, stats).
pub fn build_roads(grid: &Arc<Grid>, c: u32, roads: &Path, tag: &str, log: &(dyn Fn(&str) + Sync)) -> Result<(Built, Option<RoadStats>), String> {
	let file = roads_file(&grid.dir, c, tag);
	if tag == "none" || file.exists() {
		return Ok((Built { c, what: "roads", file, built: false, seconds: 0.0 }, None));
	}
	let t0 = Instant::now();
	let tiles = index_tiles(grid, c);
	let nav = Nav::new(grid.clone());
	let weights = |col: u32, row: u32| std::fs::read(roads.join(c.to_string()).join(format!("{col}_{row}.bin"))).ok();
	let mask = road_mask(c, &tiles, weights, Some(&nav));
	let n = TILE_CELLS * TILE_CELLS / 8;
	let mut out = Vec::new();
	for ((col, row), m) in &mask.tiles {
		let mut bits = vec![0u8; 4 + n];
		let mut any = false;
		for (k, &v) in m.iter().enumerate() {
			if v != 0 {
				bits[4 + (k >> 3)] |= 1 << (k & 7);
				any = true;
			}
		}
		if !any {
			continue;
		}
		bits[0..2].copy_from_slice(&(*col as u16).to_le_bytes());
		bits[2..4].copy_from_slice(&(*row as u16).to_le_bytes());
		out.extend_from_slice(&bits);
	}
	write_atomic(&file, &out)?;
	let s = mask.stats;
	let seconds = t0.elapsed().as_secs_f64();
	log(&format!(
		"roads {c}: {} strong columns, {} joined by hysteresis, {} pieces, {} ends, {} gaps bridged ({} columns), {} refused (not walkable); {} tiles, {seconds:.0} s",
		s.strong,
		s.weak,
		s.pieces,
		s.ends,
		s.bridges,
		s.bridged_columns,
		s.refused,
		out.len() / (4 + n)
	));
	Ok((Built { c, what: "roads", file, built: true, seconds }, Some(s)))
}

/// path.js edgeSeconds for the plain foot profile (no face or slope prices, no ground): every
/// edge's seconds from its terms (move.js termSeconds), as float32.
fn plain_seconds(terms: &[u16], p: &Profile) -> Vec<f32> {
	terms
		.chunks_exact(7)
		.map(|t| {
			let v = |i: usize| t[i] as f64 / TERM_SCALE[i];
			(v(0) / p.outdoor + v(1) / p.indoor + v(2) / p.swim + v(3) * JUMP_SECONDS + v(4) + v(5) * p.remount + v(6)) as f32
		})
		.collect()
}

/// router.js zs.chunks via profileOf's zoneOf: the zone of column k's chunk, 0 for none.
fn zone_of(zones: &Zones, t: &Tile, k: usize) -> u16 {
	let ch = zones.chunks(t);
	ch.get(((k >> 12) << 4) + ((k & 255) >> 4)).copied().unwrap_or(0)
}

/// path.js mixTiles's per-tree memo: seconds per tile zone of the tree's way to an entry.
#[derive(Default)]
struct MixScratch {
	stamp: Vec<u32>,
	acc: Vec<f64>,
	stack: Vec<usize>,
}

/// One tile's share of a pass: its nodes' edges' seconds (when repriced) and zone mix entries.
struct TileOut {
	ti: usize,
	secs: Option<Vec<f32>>,
	mix: Vec<(u32, u16, f32)>,
	home: Vec<u16>,
}

struct Pass<'a> {
	grid: &'a Grid,
	nav: &'a Nav,
	g: &'a Graph,
	plain: &'a [f32],
	/// Price the edges for this profile (None: the mix only).
	price: Option<&'a Profile>,
	/// The mix with these zones (the factionless profile's ways).
	mix: Option<&'a Zones>,
	/// The profile the tile trees search with (the factionless one for the mix).
	tree: &'a Profile,
}

impl Pass<'_> {
	fn tile(&self, ti: usize, sc: &mut Tree, ms: &mut MixScratch) -> TileOut {
		let g = self.g;
		let info = &g.tiles[ti];
		let c = g.c;
		let t = self.grid.tile(c, info.col as i64, info.row as i64);
		let (n0, n1) = (info.node_base as usize, (info.node_base + info.node_count) as usize);
		let (x0, x1) = (g.off[n0] as usize, g.off[n1] as usize);
		let mut secs = self.price.map(|_| vec![0f32; x1 - x0]);
		let mut mix = Vec::new();
		let mut home = Vec::new();
		// The tile's zones (its chunks'), indexed for the per-entry seconds vectors.
		let mut zones: Vec<u16> = Vec::new();
		if let (Some(zs), Some(t)) = (self.mix, &t) {
			for ch in 0..256usize {
				let z = zone_of(zs, t, ((ch >> 4) * 16 + 8) * TILE_CELLS + (ch & 15) * 16 + 8);
				if !zones.contains(&z) {
					zones.push(z);
				}
			}
		}
		let nz = zones.len();
		let tile_of = |v: usize| -> Option<Arc<Tile>> {
			if g.node_tile[v] as usize == ti {
				t.clone()
			} else {
				let vi = &g.tiles[g.node_tile[v] as usize];
				self.grid.tile(c, vi.col as i64, vi.row as i64)
			}
		};
		for u in n0..n1 {
			let (eu, ku) = (g.node_entry[u] as usize, g.node_k[u] as usize);
			let tree = match &t {
				Some(t) if self.price.is_some() || nz > 1 => {
					self.nav.tile_tree(t, eu, ku, self.tree, false, sc);
					true
				}
				_ => false,
			};
			if let Some(p) = self.price {
				let out = secs.as_mut().unwrap();
				let fu = t.as_ref().map_or(0, |t| t.flags[eu]);
				for x in g.off[u] as usize..g.off[u + 1] as usize {
					let v = g.to[x] as usize;
					let ev = g.node_entry[v] as usize;
					if tree && g.node_tile[v] as usize == ti && sc.reached(ev) {
						out[x - x0] = sc.dist[ev] as f32;
						continue;
					}
					let tv = tile_of(v);
					let fv = tv.as_ref().map_or(0, |t| t.flags[ev]);
					let face = if p.face_mul != 0.0 && (fu | fv) & flag::STEEP != 0 { p.face_mul } else { 1.0 };
					let ground = tv.as_ref().map_or(1.0, |tv| p.ground_mult(tv, g.node_k[v] as usize, fv));
					out[x - x0] = (self.plain[x] as f64 * face * ground) as f32;
				}
			}
			let Some(zs) = self.mix else { continue };
			let h = t.as_ref().map_or(0, |t| zone_of(zs, t, ku));
			home.push(h);
			let memo = tree && nz > 1;
			if memo {
				let tn = t.as_ref().unwrap().n;
				if ms.stamp.len() < tn {
					ms.stamp = vec![0; tn.max(1 << 17)];
				}
				if ms.acc.len() < tn * nz {
					ms.acc = vec![0.0; (tn * nz).max(1 << 19)];
				}
			}
			for x in g.off[u] as usize..g.off[u + 1] as usize {
				let v = g.to[x] as usize;
				let ev = g.node_entry[v] as usize;
				if g.node_tile[v] as usize == ti && (!memo || sc.reached(ev)) {
					if !memo {
						continue; // one zone in the tile: all of it the start node's
					}
					let tt = t.as_ref().unwrap();
					let total = sc.dist[ev];
					// Seconds per tile zone of the tree's way to ev (memoized for this tree).
					let mut y = ev as i64;
					while y != -1 && ms.stamp[y as usize] != sc.gen {
						ms.stack.push(y as usize);
						y = sc.par[y as usize] as i64;
					}
					while let Some(s) = ms.stack.pop() {
						let pr = sc.par[s];
						for z in 0..nz {
							ms.acc[s * nz + z] = if pr == -1 { 0.0 } else { ms.acc[pr as usize * nz + z] };
						}
						if pr != -1 {
							let zi = zones.iter().position(|&z| z == zone_of(zs, tt, sc.k_of[s] as usize)).unwrap();
							ms.acc[s * nz + zi] += sc.dist[s] - sc.dist[pr as usize];
						}
						ms.stamp[s] = sc.gen;
					}
					if total > 0.0 {
						for z in 0..nz {
							let sz = ms.acc[ev * nz + z];
							if zones[z] != h && sz > 0.0 {
								mix.push((x as u32, zones[z], (sz / total) as f32));
							}
						}
					}
					continue;
				}
				let zv = tile_of(v).map_or(0, |tv| zone_of(zs, &tv, g.node_k[v] as usize));
				if zv != h {
					mix.push((x as u32, zv, 1.0));
				}
			}
		}
		TileOut { ti, secs, mix, home }
	}

	/// The pass over the tiles `keep` admits (all without), in batches on the pool -> per tile in order.
	fn run(&self, pool: &rayon::ThreadPool, keep: Option<&[bool]>, mut each: impl FnMut(TileOut)) {
		let todo: Vec<usize> = (0..self.g.tiles.len()).filter(|&ti| keep.is_none_or(|k| k[ti])).collect();
		for batch in todo.chunks(BATCH) {
			let outs: Vec<TileOut> = pool.install(|| batch.par_iter().map_init(|| (Tree::default(), MixScratch::default()), |(sc, ms), &ti| self.tile(ti, sc, ms)).collect());
			for o in outs {
				each(o);
			}
		}
	}
}

/// path.js encodeMix.
fn encode_mix(node_zone: &[u16], edges: usize, entries: &[(u32, u16, f32)]) -> Vec<u8> {
	let pad4 = |n: usize| (n + 3) & !3;
	let (n, m) = (node_zone.len(), entries.len());
	let mut off = vec![0u32; edges + 1];
	for &(x, _, _) in entries {
		off[x as usize + 1] += 1;
	}
	for x in 0..edges {
		off[x + 1] += off[x];
	}
	let mut b = Vec::with_capacity(12 + pad4(2 * n) + 4 * (edges + 1) + pad4(2 * m) + 4 * m);
	b.extend_from_slice(&(edges as u32).to_le_bytes());
	b.extend_from_slice(&(m as u32).to_le_bytes());
	b.extend_from_slice(&(n as u32).to_le_bytes());
	for z in node_zone {
		b.extend_from_slice(&z.to_le_bytes());
	}
	b.resize(12 + pad4(2 * n), 0);
	for o in &off {
		b.extend_from_slice(&o.to_le_bytes());
	}
	for e in entries {
		b.extend_from_slice(&e.1.to_le_bytes());
	}
	b.resize(b.len() + pad4(2 * m) - 2 * m, 0);
	for e in entries {
		b.extend_from_slice(&e.2.to_le_bytes());
	}
	b
}

fn f32_bytes(v: &[f32]) -> Vec<u8> {
	v.iter().flat_map(|x| x.to_le_bytes()).collect()
}

/// router.js prepare: the road masks, walk graphs and zone mixes missing for the continents.
pub fn prepare(i: &PrepareIn) -> Result<Vec<Built>, String> {
	let log = i.log;
	let mut out = Vec::new();
	let tag = roads_tag(i.grid, i.roads);
	let continents: Vec<u32> = match &i.continents {
		Some(c) => c.clone(),
		None => {
			let idx: serde_json::Value = serde_json::from_slice(&std::fs::read(i.grid.join("index.json")).map_err(|e| format!("{}: {e}", i.grid.display()))?).map_err(|e| e.to_string())?;
			let mut v: Vec<u32> = idx["continents"].as_object().map(|m| m.keys().filter_map(|k| k.parse().ok()).collect()).unwrap_or_default();
			v.sort_unstable();
			v
		}
	};
	let pool = rayon::ThreadPoolBuilder::new().num_threads(i.threads.max(1)).build().map_err(|e| e.to_string())?;
	{
		// Road masks first (their tiles' snaps on a grid of their own: its tiles carry no ground yet).
		let grid = Arc::new(Grid::open(i.grid, 64)?);
		for &c in &continents {
			out.push(build_roads(&grid, c, i.roads, &tag, log)?.0);
		}
	}
	let grid = Arc::new(Grid::open(i.grid, 512)?);
	let nav = Nav::new(grid.clone());
	let hubs = std::fs::read(i.hubs).ok();
	let ground = Arc::new(Ground::load(i.grid, &tag, &continents, hubs.as_deref())?);
	let build = i.area_table.parent().and_then(|p| p.file_name()).and_then(|n| n.to_str()).ok_or("AreaTable.csv: no build directory")?.to_string();
	let area = std::fs::read_to_string(i.area_table).map_err(|e| format!("{}: {e}", i.area_table.display()))?;
	let zones = Zones::from_area_table(&area, &build, &std::fs::read(i.zones).map_err(|e| format!("{}: {e}", i.zones.display()))?)?;
	let factions: [Option<&'static str>; 3] = [None, Some("Alliance"), Some("Horde")];
	let profiles: Vec<Profile> = factions.iter().map(|f| Profile::walk(*f, ground.clone(), None)).collect();
	for &c in &continents {
		let Some(g) = grid.graph(c) else { continue };
		let terms = grid.graph_terms(c).ok_or_else(|| format!("graph {c}: no edge terms"))?;
		let plain = plain_seconds(&terms, &profiles[0]);
		drop(terms);
		let mixf = mix_file(&grid, c, &profiles[0], &zones.tag);
		let want_mix = !mixf.exists();
		let files: Vec<PathBuf> = profiles.iter().map(|p| walk_graph_file(&grid, c, p)).collect();
		// The factionless walk graph (and the mix, on the same tile trees when both are missing).
		let base_file = &files[0];
		let base: Vec<f32> = if base_file.exists() {
			out.push(Built { c, what: "none", file: base_file.clone(), built: false, seconds: 0.0 });
			let b = std::fs::read(base_file).map_err(|e| format!("{}: {e}", base_file.display()))?;
			b.chunks_exact(4).map(|x| f32::from_le_bytes(x.try_into().unwrap())).collect()
		} else {
			let t0 = Instant::now();
			let mut secs = vec![0f32; g.edges()];
			let mut entries = Vec::new();
			let mut node_zone = vec![0u16; g.node_entry.len()];
			let pass = Pass { grid: &grid, nav: &nav, g: &g, plain: &plain, price: Some(&profiles[0]), mix: want_mix.then_some(&zones), tree: &profiles[0] };
			let mut done = 0;
			pass.run(&pool, None, |o| {
				let info = &g.tiles[o.ti];
				let x0 = g.off[info.node_base as usize] as usize;
				let s = o.secs.unwrap();
				secs[x0..x0 + s.len()].copy_from_slice(&s);
				node_zone[info.node_base as usize..info.node_base as usize + o.home.len()].copy_from_slice(&o.home);
				entries.extend(o.mix);
				done += 1;
				if done % 200 == 0 {
					log(&format!("  walk graph of continent {c} (no faction): {done}/{} tiles, {:.0} s", g.tiles.len(), t0.elapsed().as_secs_f64()));
				}
			});
			write_atomic(base_file, &f32_bytes(&secs))?;
			let seconds = t0.elapsed().as_secs_f64();
			log(&format!("  walk graph of continent {c} (no faction) built in {seconds:.0} s: {}", base_file.display()));
			out.push(Built { c, what: "none", file: base_file.clone(), built: true, seconds });
			if want_mix {
				entries.sort_by_key(|e| e.0);
				write_atomic(&mixf, &encode_mix(&node_zone, g.edges(), &entries))?;
				log(&format!("  zone mix of continent {c} ({} entries on {} edges): {}", entries.len(), g.edges(), mixf.display()));
				out.push(Built { c, what: "mix", file: mixf.clone(), built: true, seconds: 0.0 });
			}
			secs
		};
		for (fi, faction) in factions.iter().enumerate().skip(1) {
			let file = &files[fi];
			if file.exists() {
				out.push(Built { c, what: faction.unwrap(), file: file.clone(), built: false, seconds: 0.0 });
				continue;
			}
			let t0 = Instant::now();
			let hostile = if *faction == Some("Horde") { 0 } else { 1 };
			let mut only = vec![false; g.tiles.len()];
			for t in &g.tiles {
				if ground.near(hostile, c, t.col, t.row).is_empty() {
					continue;
				}
				for dc in -1i64..=1 {
					for dr in -1i64..=1 {
						let (col, row) = (t.col as i64 + dc, t.row as i64 + dr);
						if col < 0 || row < 0 {
							continue;
						}
						if let Some(&ti) = g.at.get(&(col as u32 * 65536 + row as u32)) {
							only[ti as usize] = true;
						}
					}
				}
			}
			let mut secs = base.clone();
			let pass = Pass { grid: &grid, nav: &nav, g: &g, plain: &plain, price: Some(&profiles[fi]), mix: None, tree: &profiles[fi] };
			pass.run(&pool, Some(&only), |o| {
				let x0 = g.off[g.tiles[o.ti].node_base as usize] as usize;
				let s = o.secs.unwrap();
				secs[x0..x0 + s.len()].copy_from_slice(&s);
			});
			write_atomic(file, &f32_bytes(&secs))?;
			let seconds = t0.elapsed().as_secs_f64();
			log(&format!(
				"  walk graph of continent {c} ({}) built in {seconds:.0} s ({} of {} tiles searched again): {}",
				faction.unwrap(),
				only.iter().filter(|&&x| x).count(),
				g.tiles.len(),
				file.display()
			));
			out.push(Built { c, what: faction.unwrap(), file: file.clone(), built: true, seconds });
		}
		if mixf.exists() {
			if !out.iter().any(|b| b.file == mixf) {
				out.push(Built { c, what: "mix", file: mixf, built: false, seconds: 0.0 });
			}
			continue;
		}
		// The mix alone (the base walk graph was kept).
		let t0 = Instant::now();
		let mut entries = Vec::new();
		let mut node_zone = vec![0u16; g.node_entry.len()];
		let pass = Pass { grid: &grid, nav: &nav, g: &g, plain: &plain, price: None, mix: Some(&zones), tree: &profiles[0] };
		pass.run(&pool, None, |o| {
			let b = g.tiles[o.ti].node_base as usize;
			node_zone[b..b + o.home.len()].copy_from_slice(&o.home);
			entries.extend(o.mix);
		});
		entries.sort_by_key(|e| e.0);
		write_atomic(&mixf, &encode_mix(&node_zone, g.edges(), &entries))?;
		let seconds = t0.elapsed().as_secs_f64();
		log(&format!("  zone mix of continent {c} built in {seconds:.0} s ({} entries on {} edges): {}", entries.len(), g.edges(), mixf.display()));
		out.push(Built { c, what: "mix", file: mixf, built: true, seconds });
	}
	// The CCH bundles and each faction's edge yards and cells (cch.js prepare and prepareYards): what
	// the walk tables' CCH path needs (walker.rs bundle, edge_files); without them walks take the
	// slow per-row path.
	for &c in &continents {
		let Some(g) = grid.graph(c) else { continue };
		let bundle = bundle_file(i.grid, c)?;
		let stale = if bundle.exists() { cch_stale(&bundle, g.edges()) } else { None };
		if bundle.exists() && stale.is_none() {
			out.push(Built { c, what: "cch", file: bundle.clone(), built: false, seconds: 0.0 });
		} else {
			if let Some(why) = stale {
				log(&format!("  cch: stale cch {} ({why}), rebuilding", bundle.display()));
				remove_bundle(&bundle)?;
			}
			let t0 = Instant::now();
			let cg = crate::cch::graph::CoarseGraph::read(&i.grid.join("graph").join(format!("{c}.bin.gz"))).map_err(|e| format!("graph {c}: {e}"))?;
			if let Some(d) = bundle.parent() {
				std::fs::create_dir_all(d).map_err(|e| format!("{}: {e}", d.display()))?;
			}
			let st = crate::cch::structure::build(&cg, 0, &bundle).map_err(|e| format!("{}: {e}", bundle.display()))?;
			let seconds = t0.elapsed().as_secs_f64();
			log(&format!(
				"  cch: continent {c}: {} nodes, {} edges -> {} arcs, {} levels; order {:.1} s, build {:.1} s: {}",
				st.nodes,
				st.input_arcs,
				st.arcs,
				st.levels,
				st.order_ms / 1000.0,
				st.build_ms / 1000.0,
				bundle.display()
			));
			out.push(Built { c, what: "cch", file: bundle.clone(), built: true, seconds });
		}
		for (fi, faction) in factions.iter().enumerate().skip(1) {
			let p = &profiles[fi];
			let (yfile, cfile) = edge_files(&bundle, p);
			if yfile.exists() && cfile.exists() {
				match yards_stale(&yfile, &cfile, g.edges()) {
					None => {
						out.push(Built { c, what: faction.unwrap(), file: yfile, built: false, seconds: 0.0 });
						continue;
					}
					Some(why) => log(&format!("  cch: stale cch yards {} ({why}), rebuilding", yfile.display())),
				}
			}
			let t0 = Instant::now();
			let (yards, cells) = edge_yards(&grid, &nav, &g, p, &pool);
			write_atomic(&yfile, &yards.iter().flat_map(|y| y.to_le_bytes()).collect::<Vec<u8>>())?;
			write_atomic(&cfile, &encode_cells(&cells))?;
			let seconds = t0.elapsed().as_secs_f64();
			log(&format!("  cch: yards of continent {c} ({}) in {seconds:.0} s: {}", faction.unwrap(), yfile.display()));
			out.push(Built { c, what: faction.unwrap(), file: yfile, built: true, seconds });
			out.push(Built { c, what: faction.unwrap(), file: cfile, built: true, seconds: 0.0 });
		}
	}
	Ok(out)
}

/// cch.js CCH_VERSION: bundles are rebuilt when it changes (the structure builder's own rules). The
/// edge set a bundle is built on is graph 0 of graph/<c>.bin.gz, whose bytes are in the key: a graph
/// rebuilt with other edges (another link rule, another build) names another bundle.
const CCH_VERSION: u32 = 1;

/// cch.js bundleFile: <grid>/cch/<c>-0-<sha1("1\n" + graph/<c>.bin.gz)[:16]>.cch. The only bundle
/// a graph may use: other bundles in cch/ belong to other graphs (walker.rs reads this one too).
pub fn bundle_file(grid: &Path, c: u32) -> Result<PathBuf, String> {
	let gz = grid.join("graph").join(format!("{c}.bin.gz"));
	let bytes = std::fs::read(&gz).map_err(|e| format!("{}: {e}", gz.display()))?;
	let mut h = forge_core::key::ContentHasher::new();
	h.update(format!("{CCH_VERSION}\n").as_bytes()).update(&bytes);
	Ok(grid.join("cch").join(format!("{c}-0-{}.cch", &h.hex()[..16])))
}

/// cch.js yardsFile / cellsFile: a profile's edge yards and cells beside its continent's bundle,
/// tagged with the profile's ground key.
pub fn edge_files(bundle: &Path, p: &Profile) -> (PathBuf, PathBuf) {
	let tag = &forge_core::key::content_key(p.ground_key.as_bytes())[..12];
	let name = bundle.file_name().and_then(|n| n.to_str()).unwrap_or_default().to_string();
	(bundle.with_file_name(format!("{name}.{tag}.yards")), bundle.with_file_name(format!("{name}.{tag}.cells")))
}

/// Why a CCH bundle cannot serve a graph of `edges` edges (unreadable, or built on another edge
/// set); None: it can.
pub fn cch_stale(bundle: &Path, edges: usize) -> Option<String> {
	match crate::cch::structure::Structure::open(bundle) {
		Ok(s) if s.input_arcs == edges => None,
		Ok(s) => Some(format!("built on {} edges, the graph has {edges}", s.input_arcs)),
		Err(e) => Some(e.to_string()),
	}
}

/// Why a profile's edge yards and cells do not fit a graph of `edges` edges; None: they do.
pub fn yards_stale(yards: &Path, cells: &Path, edges: usize) -> Option<String> {
	let n = std::fs::metadata(yards).map(|m| m.len() as usize / 8).unwrap_or(0);
	if n != edges {
		return Some(format!("{n} edges, the graph has {edges}"));
	}
	match crate::cch::query::EdgeCells::open(cells) {
		Ok(x) if x.edges() == edges => None,
		Ok(x) => Some(format!("cells for {} edges, the graph has {edges}", x.edges())),
		Err(e) => Some(e.to_string()),
	}
}

/// Removes a stale bundle and every profile's yards and cells beside it (they were built for it).
fn remove_bundle(bundle: &Path) -> Result<(), String> {
	let name = bundle.file_name().and_then(|n| n.to_str()).unwrap_or_default().to_string();
	if let Some(dir) = bundle.parent() {
		for e in std::fs::read_dir(dir).map_err(|e| format!("{}: {e}", dir.display()))?.flatten() {
			let f = e.file_name().to_string_lossy().into_owned();
			if f == name || f.starts_with(&format!("{name}.")) {
				std::fs::remove_file(e.path()).map_err(|e| format!("{f}: {e}"))?;
			}
		}
	}
	Ok(())
}

/// cch.js prepareYards for one faction's profile: per graph edge its yards (an edge inside a tile:
/// its tile search's way, tileTree with the faction's prices; across a border or a lift: the 3D
/// length between its nodes) and its yards per zone cell (the tile search's way, treeCells, else all
/// in the end node's cell), in the graph's edge order.
fn edge_yards(grid: &Grid, nav: &Nav, g: &Graph, p: &Profile, pool: &rayon::ThreadPool) -> (Vec<f64>, Vec<Vec<(u32, f64)>>) {
	let c = g.c;
	let mut yards = vec![0f64; g.edges()];
	let mut cells: Vec<Vec<(u32, f64)>> = vec![Vec::new(); g.edges()];
	let wxy = |x: usize| {
		let t = &g.tiles[g.node_tile[x] as usize];
		let k = g.node_k[x] as usize;
		((32.0 - t.row as f64) * crate::grid::ADT - ((k >> 8) as f64 + 0.5) * crate::grid::CELL, (32.0 - t.col as f64) * crate::grid::ADT - ((k & 255) as f64 + 0.5) * crate::grid::CELL)
	};
	let straight = |u: usize, v: usize| {
		let ((ux, uy), (vx, vy)) = (wxy(u), wxy(v));
		forge_core::jsnum::js_hypot_n(&[ux - vx, uy - vy, g.node_z[u] as f64 - g.node_z[v] as f64])
	};
	let todo: Vec<usize> = (0..g.tiles.len()).collect();
	for batch in todo.chunks(BATCH) {
		let outs: Vec<Vec<(usize, f64, Vec<(u32, f64)>)>> = pool.install(|| {
			batch
				.par_iter()
				.map_init(Tree::default, |sc, &ti| {
					let info = &g.tiles[ti];
					let t = grid.tile(c, info.col as i64, info.row as i64);
					let mut rows = Vec::new();
					for u in info.node_base as usize..(info.node_base + info.node_count) as usize {
						let reached = t.as_ref().map(|t| nav.tile_tree(t, g.node_entry[u] as usize, g.node_k[u] as usize, p, false, sc)).is_some();
						for x in g.off[u] as usize..g.off[u + 1] as usize {
							let v = g.to[x] as usize;
							let ev = g.node_entry[v] as usize;
							match &t {
								Some(t) if reached && g.node_tile[v] as usize == ti && sc.reached(ev) => rows.push((x, sc.yd[ev], nav.tree_cells(t, sc, ev, false).0)),
								_ => {
									let y = straight(u, v);
									let (vx, vy) = wxy(v);
									rows.push((x, y, vec![(forge_core::cells::cell_key(vx, vy) as u32, y)]));
								}
							}
						}
					}
					rows
				})
				.collect()
		});
		for rows in outs {
			for (x, y, cl) in rows {
				yards[x] = y;
				cells[x] = cl;
			}
		}
	}
	(yards, cells)
}

/// The cells file (cch.js): u32 E, u32 off[E + 1], u32 key[M], f32 yards[M].
fn encode_cells(cells: &[Vec<(u32, f64)>]) -> Vec<u8> {
	let m: usize = cells.iter().map(Vec::len).sum();
	let mut b = Vec::with_capacity(4 * (2 + cells.len() + 2 * m));
	b.extend_from_slice(&(cells.len() as u32).to_le_bytes());
	let mut at = 0u32;
	b.extend_from_slice(&at.to_le_bytes());
	for e in cells {
		at += e.len() as u32;
		b.extend_from_slice(&at.to_le_bytes());
	}
	for e in cells {
		for &(k, _) in e {
			b.extend_from_slice(&k.to_le_bytes());
		}
	}
	for e in cells {
		for &(_, y) in e {
			b.extend_from_slice(&(y as f32).to_le_bytes());
		}
	}
	b
}
