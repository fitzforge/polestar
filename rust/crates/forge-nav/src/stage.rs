//! forge build's world and walks stages (ForgePlan.md): library entries the CLI (`forge walks`) and
//! `forge build` call alike.
//!
//!   world(root, grid, faction) -> (World, its JSON): forge-world's builder, heights from the walking grid
//!   walks(&WalksIn) -> WalksOut: a world's walks-<faction>.bin from the walk store (answers kept by content;
//!     the rest routed), the store saved back

use crate::cost::{Ground, ZoneGrid, Zones};
use crate::floors::GridFloors;
use crate::grid::Grid;
use crate::store::WalkStore;
use crate::walkdoc::{build_doc, encode, Backend, GridBackend, Pricing, WalkWorld};
use std::path::{Path, PathBuf};
use std::sync::Arc;
use std::time::Instant;

/// A faction's world from a repository-shaped root (data/forever, data/sources, data/rules.json),
/// heights from the walking grid in `grid` -> (world, world JSON as world.js writes it).
pub fn world(root: &Path, grid: &Path, faction: forge_core::Faction) -> Result<(forge_world::World, String), String> {
	let fl = GridFloors::new(Arc::new(Grid::open(grid, 2048)?));
	let (w, _) = forge_world::World::load_with(root, faction, &fl).map_err(|e| format!("{e:?}"))?;
	let text = w.to_json();
	Ok((w, text))
}

/// Which walking maps answer the walks. forge build's default is `Nav::auto`: the hybrid when Leffe's navigation
/// maps are present, else the hybrid on his saved walks (the data pack's Leffe walk stores) when there are any,
/// else our grid alone. His maps are private and never ship; his saved walks do.
#[derive(Default)]
pub enum Nav {
	#[default]
	/// Our walking grid (data/local/nav4): legs, CCH, coarse search.
	Grid,
	/// Leffe's navigation maps (format 4): his pack's Nav folder, the decode cache's MB.
	Leffe { pack: PathBuf, cache_mb: usize },
	/// Leffe's saved walks alone (the store, no maps): pairs it lacks get no walk; the store is read, never written.
	LeffeSaved,
	/// Leffe's maps, our grid where his have no way or a detour (hybrid.rs); his walks kept in `leffe_store`.
	Hybrid { pack: PathBuf, cache_mb: usize, leffe_store: PathBuf },
	/// The hybrid without his maps: his walks from `leffe_store` (saved), our grid for the pairs it lacks.
	HybridSaved { leffe_store: PathBuf },
}

pub struct WalksIn<'a> {
	/// world-<faction>.json's bytes (the world's points, zones, danger grids).
	pub world_json: &'a [u8],
	/// The walking grid (index.json, tiles, graph, walk/, cch/); its hubs layer at <grid>/../nav-layers/hubs.json.
	pub grid: &'a Path,
	/// The maps walks are asked on (addon PACK.json's maps: 0, 1, 2991).
	pub maps: &'a [i64],
	/// The cached AreaTable.csv (data/sources/wago/<build>/AreaTable.csv) and data/forever/zones.json.
	pub area_table: &'a Path,
	pub zones: &'a Path,
	/// The walk store file (read when present, written back).
	pub store: &'a Path,
	/// The header's `nav` (what JS walksUsable compares: the tools' node fingerprint).
	pub nav_fp: &'a str,
	/// Bands to build (0 and the danger bands: [0, 10, 20, 30, 40, 50]).
	pub bands: &'a [i64],
	pub threads: usize,
	pub nav: Nav,
	pub log: &'a (dyn Fn(&str) + Sync),
	/// Extra pairs (world point ids) to walk beyond the radius rules (WalkWorld::extra).
	pub extra: &'a [(usize, usize)],
	/// The hybrid's two passes (our grid's, Leffe's) one after the other instead of side by side: about half
	/// the peak memory (each pass holds its own walk store, grid or map cache), for a longer wall time. The
	/// walks are the same either way (each pass is deterministic; the merge comes after both).
	pub serial: bool,
}

pub struct WalksOut {
	/// walks-<faction>.bin's bytes.
	pub bin: Vec<u8>,
	/// { faction, dataHash, asked, stored, routed, straight, bands: [...], wallS, storeAnswers }
	pub stats: serde_json::Value,
}

/// The road mask tag of a grid (its walk/roads-0-<tag>.bin; exactly one).
pub fn roads_tag(grid: &Path) -> Result<String, String> {
	let mut tags: Vec<String> = std::fs::read_dir(grid.join("walk"))
		.map_err(|e| format!("{}: {e}", grid.display()))?
		.flatten()
		.filter_map(|e| e.file_name().to_str().and_then(|n| n.strip_prefix("roads-0-").and_then(|t| t.strip_suffix(".bin")).map(String::from)))
		.collect();
	tags.sort();
	tags.dedup();
	if tags.len() != 1 {
		return Err(format!("expected one road mask tag in {}/walk, found {tags:?}", grid.display()));
	}
	Ok(tags.remove(0))
}

/// The grid backend's pricing for a world: ground (roads, hubs, faction), the AreaTable's zones, the
/// world's zone grids.
pub fn pricing(grid: &Grid, faction: &str, area_table: &Path, zones_json: &Path, grids: Vec<ZoneGrid>) -> Result<Pricing, String> {
	let tag = roads_tag(&grid.dir)?;
	let continents: Vec<u32> = grid.index["continents"].as_object().map(|m| m.keys().filter_map(|k| k.parse().ok()).collect()).unwrap_or_default();
	let hubs = std::fs::read(crate::walker::hubs_file(&grid.dir)).ok();
	let ground = Arc::new(Ground::load(&grid.dir, &tag, &continents, hubs.as_deref())?);
	let build = area_table.parent().and_then(|p| p.file_name()).and_then(|n| n.to_str()).ok_or("AreaTable.csv: no build directory")?.to_string();
	let area = std::fs::read_to_string(area_table).map_err(|e| format!("{}: {e}", area_table.display()))?;
	let mut zones = Zones::from_area_table(&area, &build, &std::fs::read(zones_json).map_err(|e| format!("{}: {e}", zones_json.display()))?)?;
	zones.grids = grids;
	let faction = match faction {
		"Horde" => Some("Horde"),
		"Alliance" => Some("Alliance"),
		_ => None,
	};
	Ok(Pricing { grid_id: crate::walker::grid_id(grid), ground, zones: Arc::new(zones), faction, smooth: crate::walker::SMOOTH })
}

pub fn open_store(file: &Path) -> Result<WalkStore, String> {
	match std::fs::read(file) {
		Ok(b) => WalkStore::decode(&b).map_err(|e| format!("{}: {e}", file.display())),
		Err(_) => Ok(WalkStore::new()),
	}
}

/// Writes the store (tmp + rename), streamed: the file is never built in memory -> bytes.
pub fn save_store(store: &WalkStore, file: &Path) -> Result<usize, String> {
	use std::io::Write;
	let tmp: PathBuf = file.with_extension("tmp");
	let f = std::fs::File::create(&tmp).map_err(|e| format!("{}: {e}", tmp.display()))?;
	let mut w = std::io::BufWriter::with_capacity(1 << 20, f);
	store.write_to(&mut w).and_then(|()| w.flush()).map_err(|e| format!("{}: {e}", tmp.display()))?;
	drop(w);
	let n = std::fs::metadata(&tmp).map_err(|e| e.to_string())?.len() as usize;
	std::fs::rename(&tmp, file).map_err(|e| e.to_string())?;
	Ok(n)
}

pub fn walks(i: &WalksIn) -> Result<WalksOut, String> {
	let t0 = Instant::now();
	let pool = pool(i.threads)?;
	// The world once for every pass: its points, places and each band's asks (the same on every backend).
	let (world, walks_key) = pool.install(|| rayon::join(|| WalkWorld::from_json(i.world_json, i.maps), || forge_world::World::from_json(i.world_json).map(|w| w.walks_key())));
	let mut world = world?;
	world.extra = i.extra.to_vec();
	world.walks_key = walks_key?;
	pool.install(|| world.ask_bands(i.bands));
	let leffe_pass = match &i.nav {
		Nav::Hybrid { pack, cache_mb, leffe_store } => Some((Nav::Leffe { pack: pack.clone(), cache_mb: *cache_mb }, leffe_store)),
		Nav::HybridSaved { leffe_store } => Some((Nav::LeffeSaved, leffe_store)),
		_ => None,
	};
	let Some((leffe_nav, leffe_store)) = leffe_pass else { return pass(i, &world, &pool) };
	// Each backend's own pass: its "not walkable" counts are its own, before the merge falls back to the grid.
	let (glog, llog) = (|m: &str| (i.log)(&format!("grid: {m}")), |m: &str| (i.log)(&format!("Leffe's maps: {m}")));
	// Side by side by default, each on threads of its own: while one reads its store, assembles or writes it
	// (one core), the other routes. (One pool for both starves the grid's fine-grained steps, its CCH
	// customization among them, behind Leffe's searches of seconds each.) `serial`: one after the other.
	let (g, l) = both(
		i.serial,
		|| pass(&WalksIn { nav: Nav::Grid, log: &glog, ..*i }, &world, &self::pool(i.threads)?),
		|| pass(&WalksIn { nav: leffe_nav, store: leffe_store, log: &llog, ..*i }, &world, &pool),
	);
	let (g, l) = (g?, l?);
	let (bin, h) = pool.install(|| hybrid_bin(&g.bin, &l.bin, crate::hybrid::SLACK))?;
	for line in crate::hybrid::summary(&h) {
		(i.log)(&line);
	}
	let stats = serde_json::json!({ "nav": i.nav.source(), "grid": g.stats, "leffe": l.stats, "hybrid": h, "bytes": bin.len(), "wallS": t0.elapsed().as_secs_f64() });
	Ok(WalksOut { bin, stats })
}

fn pool(threads: usize) -> Result<rayon::ThreadPool, String> {
	rayon::ThreadPoolBuilder::new().num_threads(threads).build().map_err(|e| e.to_string())
}

/// Runs `a` and `b`: side by side (`a` on a thread of its own), or `a` to the end and then `b` when
/// `serial`. -> (a's result, b's result).
pub fn both<A: Send, B>(serial: bool, a: impl FnOnce() -> A + Send, b: impl FnOnce() -> B) -> (A, B) {
	if serial {
		let ra = a();
		return (ra, b());
	}
	std::thread::scope(|s| {
		let ha = s.spawn(a);
		let rb = b();
		(ha.join().unwrap_or_else(|e| std::panic::resume_unwind(e)), rb)
	})
}

/// One backend's walks of the world (`i.nav` is no hybrid) on `pool`.
fn pass(i: &WalksIn, world: &WalkWorld, pool: &rayon::ThreadPool) -> Result<WalksOut, String> {
	let t_all = Instant::now();
	let mut store = open_store(i.store)?;
	let n0 = store.len();
	let (doc, stats, smooth) = match &i.nav {
		Nav::Grid => {
			let grid = Arc::new(Grid::open(i.grid, 640)?);
			let pr = pricing(&grid, &world.faction, i.area_table, i.zones, world.danger.clone())?;
			let walker = crate::walker::Walker::new(grid);
			let be = GridBackend { walker: &walker, pricing: pr };
			pool.install(|| {
				let ends = be.ends(world);
				let (d, s) = build_doc(world, &ends, &mut store, &be, i.nav_fp, i.log, i.bands);
				(d, s, be.smooth())
			})
		}
		Nav::Hybrid { .. } | Nav::HybridSaved { .. } => unreachable!(),
		Nav::LeffeSaved => {
			let pack = store.leffe_pack().ok_or_else(|| format!("{}: no saved walks on Leffe's maps", i.store.display()))?;
			let faction = match world.faction.as_str() {
				"Horde" => Some("Horde"),
				"Alliance" => Some("Alliance"),
				_ => None,
			};
			let ends: Vec<crate::store::End> = world.points.iter().map(|p| crate::store::End::new(p.c as i32, p.x, p.y, p.z, p.z)).collect();
			let be = crate::f4walks::SavedF4Backend::new(&store, pack, faction, &ends);
			(i.log)(&format!(
				"saved walks (pack {}, lift layer {}), zones kept for {} of {} places; walks it lacks are our grid's",
				&be.pack_id[..12.min(be.pack_id.len())],
				be.lifts,
				be.zones_known(),
				ends.len()
			));
			pool.install(|| {
				let (d, s) = build_doc(world, &ends, &mut store, &be, i.nav_fp, i.log, i.bands);
				(d, s, be.smooth())
			})
		}
		Nav::Leffe { pack, cache_mb } => {
			let nav_dir = if pack.join("Nav.xml").exists() { pack.clone() } else { pack.join("Nav") };
			let faction = match world.faction.as_str() {
				"Horde" => Some("Horde"),
				"Alliance" => Some("Alliance"),
				_ => None,
			};
			let be = crate::f4walks::F4Backend { f4: crate::f4::F4::open(&nav_dir, *cache_mb)?, pack_id: crate::f4walks::F4Backend::pack_id(&nav_dir).map_err(|e| e.to_string())?, faction };
			pool.install(|| {
				let ends = be.ends(world);
				// Each end's zone on his maps, kept so a build without them prices the danger bands alike.
				for e in &ends {
					store.set_zone(e, be.zone_at(e));
				}
				let (d, s) = build_doc(world, &ends, &mut store, &be, i.nav_fp, i.log, i.bands);
				(d, s, be.smooth())
			})
		}
	};
	let bin = pool.install(|| encode(&doc, smooth));
	// Leffe's saved walks are read only: the pairs they lack were not asked of his maps, so keep no answer for
	// them. A store that gained nothing is left as it is: its file holds it.
	let saved = match &i.nav {
		Nav::LeffeSaved => 0,
		_ if store.changed() || !i.store.exists() => save_store(&store, i.store)?,
		_ => std::fs::metadata(i.store).map_or(0, |m| m.len() as usize),
	};
	let (asked, stored, routed, straight) = stats.iter().fold((0, 0, 0, 0), |s, b| (s.0 + b.pairs, s.1 + b.stored, s.2 + b.routed, s.3 + b.straight));
	let stats = serde_json::json!({
		"nav": i.nav.source(),
		"faction": world.faction, "dataHash": world.data_hash, "bytes": bin.len(),
		"asked": asked, "stored": stored, "routed": routed, "straight": straight,
		"bands": stats.iter().map(|b| serde_json::json!({"band": b.band, "pairs": b.pairs, "stored": b.stored, "routed": b.routed, "straight": b.straight, "failed": b.failed, "tables": b.tables, "s": b.ms / 1e3})).collect::<Vec<_>>(),
		"storeAnswers": [n0, store.len()], "storeBytes": saved,
		"wallS": t_all.elapsed().as_secs_f64(),
	});
	Ok(WalksOut { bin, stats })
}

/// The hybrid walks file of two walks files of one world (grid's, Leffe's) -> (bytes, per band who answered).
pub fn hybrid_bin(grid: &[u8], leffe: &[u8], slack: f64) -> Result<(Vec<u8>, serde_json::Value), String> {
	let g = crate::lookup::WalksDoc::read(grid).map_err(|e| e.to_string())?;
	let l = crate::lookup::WalksDoc::read(leffe).map_err(|e| e.to_string())?;
	let smooth = g.smooth();
	let (doc, stats) = crate::hybrid::merge(&g, &l, slack)?;
	Ok((encode(&doc, smooth), stats))
}

impl Nav {
	/// forge build's default: the hybrid (Leffe's navigation maps, our grid as the fallback) when his pack (a Nav
	/// folder, or one holding Nav/) is present; else the hybrid on his saved walks when `<store>-leffe.<ext>`
	/// exists; else the grid. Leffe's walks are kept in `<store>-leffe.<ext>`.
	pub fn auto(pack: Option<&Path>, store: &Path) -> Nav {
		match pack.filter(|p| p.join("Nav.xml").exists() || p.join("Nav").join("Nav.xml").exists()) {
			Some(p) => Nav::Hybrid { pack: p.to_path_buf(), cache_mb: 2048, leffe_store: leffe_store_of(store) },
			None if leffe_store_of(store).is_file() => Nav::HybridSaved { leffe_store: leffe_store_of(store) },
			None => Nav::Grid,
		}
	}

	/// The backend as a report's data sources name it: { backend, pack? }.
	pub fn source(&self) -> serde_json::Value {
		match self {
			Nav::Grid => serde_json::json!({ "backend": "grid" }),
			Nav::Leffe { pack, .. } => serde_json::json!({ "backend": "leffe", "pack": pack }),
			Nav::LeffeSaved => serde_json::json!({ "backend": "leffe", "pack": "saved walks" }),
			Nav::Hybrid { pack, .. } => serde_json::json!({ "backend": "hybrid", "pack": pack, "slack": crate::hybrid::SLACK }),
			Nav::HybridSaved { leffe_store } => serde_json::json!({ "backend": "hybrid", "pack": "saved walks", "leffeStore": leffe_store, "slack": crate::hybrid::SLACK }),
		}
	}
}

/// Where the hybrid keeps Leffe's walks beside the grid's store: `<stem>-leffe.<ext>`.
pub fn leffe_store_of(store: &Path) -> PathBuf {
	let stem = store.file_stem().and_then(|s| s.to_str()).unwrap_or("walkstore");
	let ext = store.extension().and_then(|s| s.to_str()).unwrap_or("bin");
	store.with_file_name(format!("{stem}-leffe.{ext}"))
}
