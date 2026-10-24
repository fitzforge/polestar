//! `nav build` (port of tools/lib/nav/grid/build.js and worker.js): per continent, three passes
//! over its ADT tiles on `jobs` threads, each waiting for the one before (a tile's links need its
//! neighbours' surfaces, its graph part their links):
//!
//!   surfaces  tile_geometry -> rasterise -> surfaces (<tile>.surf.gz), walls (<tile>.walls.gz) and
//!             each surface's WMO-group area (<tile>.area.gz, areas.rs; Rust only)
//!   links     links, falls, components (<tile>.nav.gz; the .surf.gz is removed)
//!   graph     the tile's abstract graph part (<tile>.hpa.gz)
//!
//! then the continent's graph parts and regions are joined (graph/<c>.bin.gz), and index.json and
//! lifts.json are written. Incremental as the JS: a tile whose .nav.gz exists is kept unless
//! `force`; tiles next to a rebuilt one are relinked, and graph parts redone around every relinked
//! tile. Rebuilding a tile is deterministic, so the files do not depend on `jobs`.

use crate::fmath;
use crate::format::{self, flag, Tile, CELL, LIFT_CAR, LIFT_FIT, LIFT_LEVEL, LIFT_MIN, LIFT_OPEN, LIFT_RADIUS, LIFT_REACH, TILE_CELLS};
use crate::geom::{self, Source};
use crate::graph::{self, Lift, LiftEnd};
use parking_lot::Mutex;
use rustc_hash::FxHashSet;
use serde_json::{Map, Value};
use std::path::{Path, PathBuf};
use std::sync::atomic::{AtomicUsize, Ordering};
use std::time::Instant;

pub const SCHEMA: u32 = 1;

/// Where the client's files come from.
pub enum Client {
	/// The installed client (`.build.info` folder) and the WoWDBDefs checkout typing its tables.
	Install { wow: PathBuf, defs: PathBuf },
	/// A JS CASC cache folder (`<sources>/casc/<product>/<build>`, files `<fdid>.blp`) with the
	/// wago-style tables in `tables` (`<Table>.csv`); `build` names it. For tests and parity runs.
	Cache { dir: PathBuf, tables: PathBuf, build: String },
}

pub struct Opts {
	pub out: PathBuf,
	pub client: Client,
	pub product: String,
	/// The game data folder (map-frames.json, zones.json, objects.json).
	pub data: PathBuf,
	/// Only these continents (map ids); None: every continent map-frames.json names.
	pub continents: Option<Vec<u32>>,
	pub force: bool,
	pub jobs: usize,
}

pub struct Output {
	pub build: String,
	pub warnings: Vec<String>,
	/// The index.json text written.
	pub index: String,
}

/// Builds the grid into `opts.out`; `log` gets the progress lines.
pub fn run(opts: &Opts, log: &(dyn Fn(&str) + Sync)) -> Result<Output, String> {
	let (src, tables, build): (Box<dyn Source>, geom::Tables, String) = match &opts.client {
		Client::Install { wow, defs } => {
			let client = forge_gamedata::Client::open(wow, &opts.product, defs)?;
			let tables = geom::Tables::from_csv(|name| {
				let t = client.table(name, "enUS")?;
				String::from_utf8(forge_gamedata::csv::write_table(&t)).map_err(|e| format!("{name}: {e}"))
			})?;
			let build = client.storage.version.clone();
			let src = geom::ClientSource::open(wow, &opts.product)?;
			(Box::new(src), tables, build)
		}
		Client::Cache { dir, tables, build } => {
			let t = geom::Tables::from_csv(|name| std::fs::read_to_string(tables.join(format!("{name}.csv"))).map_err(|e| format!("{name}.csv: {e}")))?;
			(Box::new(geom::CacheDir(dir.clone())), t, build.clone())
		}
	};
	log(&format!("{} {build}", opts.product));
	let read_json = |f: &str| -> Result<Option<Value>, String> {
		let p = opts.data.join(f);
		if !p.is_file() {
			return Ok(None);
		}
		let b = std::fs::read(&p).map_err(|e| format!("{}: {e}", p.display()))?;
		serde_json::from_slice(&b).map(Some).map_err(|e| format!("{}: {e}", p.display()))
	};
	let frames = read_json("map-frames.json")?.ok_or_else(|| format!("{} not found (forge data build)", opts.data.join("map-frames.json").display()))?;
	let zones = read_json("zones.json")?.unwrap_or(Value::Object(Map::new()));
	let geo = Geo::new(&frames, &zones);
	let names = geo.continents();
	let cars = read_json("travel.json")?.map(|t| lift_cars(&t)).unwrap_or_default();
	let lift_points = match read_json("objects.json")? {
		Some(objects) => lift_points(&objects, &geo, &geom::transport_travel(&tables), &cars),
		None => Vec::new(),
	};
	let want: Option<FxHashSet<u32>> = opts.continents.as_ref().map(|v| v.iter().copied().collect());
	let mut warnings = Vec::new();
	if let Some(w) = &opts.continents {
		for c in w {
			if !names.iter().any(|(x, _)| x == c) {
				warnings.push(format!("continent {c}: not in map-frames.json"));
			}
		}
	}
	let mut list = Vec::new();
	for (c, name) in &names {
		if want.as_ref().is_some_and(|w| !w.contains(c)) {
			continue;
		}
		match geom::continent_tiles(src.as_ref(), &tables, *c) {
			Err(e) => warnings.push(format!("continent {c}: {e}")),
			Ok(t) if t.is_empty() => warnings.push(format!("continent {c}: no ADT tiles")),
			Ok(t) => list.push((*c, name.clone(), t)),
		}
	}
	let r = build_grid(opts, src.as_ref(), &tables, &build, &list, &lift_points, log)?;
	warnings.extend(r.1);
	Ok(Output { build, warnings, index: r.0 })
}

fn tkey(col: i32, row: i32) -> String {
	format::tile_key(col, row)
}

/// The continents' build and the index: -> (index.json text, warnings).
fn build_grid(
	opts: &Opts,
	src: &dyn Source,
	tables: &geom::Tables,
	build: &str,
	list: &[(u32, String, Vec<geom::TileRef>)],
	lift_points: &[LiftPoint],
	log: &(dyn Fn(&str) + Sync),
) -> Result<(String, Vec<String>), String> {
	let mut warnings = Vec::new();
	let index_file = opts.out.join("index.json");
	let mut force = opts.force;
	let mut index: Option<Value> = std::fs::read(&index_file).ok().and_then(|b| serde_json::from_slice(&b).ok());
	let same = |v: &Value| v["schema"] == SCHEMA && v["version"] == format::VERSION && v["product"] == opts.product.as_str() && v["build"] == build;
	if let Some(ix) = &index {
		if !same(ix) {
			if !force {
				log("nav: index from another schema, product or build: rebuilding every tile");
			}
			force = true;
			index = None;
		}
	}
	let mut out: Map<String, Value> = index.as_ref().and_then(|ix| ix["continents"].as_object().cloned()).unwrap_or_default();
	let cache = geom::ModelCache::default();
	for (c, name, tiles) in list {
		let pts: Vec<&LiftPoint> = lift_points.iter().filter(|p| p.c == *c).collect();
		let prev = out.get(&c.to_string()).cloned();
		let entry = build_continent(opts, src, tables, &cache, *c, name, tiles, &pts, prev.as_ref(), force, log, &mut warnings)?;
		out.insert(c.to_string(), entry);
	}
	// JS objects list integer keys ascending.
	let mut keys: Vec<String> = out.keys().cloned().collect();
	keys.sort_by_key(|k| k.parse::<u64>().unwrap_or(u64::MAX));
	let mut conts = Map::new();
	for k in &keys {
		conts.insert(k.clone(), out[k].clone());
	}
	let mut doc = Map::new();
	doc.insert("schema".into(), SCHEMA.into());
	doc.insert("version".into(), format::VERSION.into());
	doc.insert("product".into(), opts.product.clone().into());
	doc.insert("build".into(), build.into());
	doc.insert("builtAt".into(), iso_now().into());
	let mut cst = Map::new();
	for (k, v) in format::constants() {
		cst.insert(k.into(), num(v));
	}
	doc.insert("constants".into(), Value::Object(cst));
	doc.insert("continents".into(), Value::Object(conts.clone()));
	let text = format!("{}\n", js_json(&Value::Object(doc), Some("\t")));
	std::fs::create_dir_all(&opts.out).map_err(|e| e.to_string())?;
	write_atomic(&index_file, text.as_bytes())?;
	let mut lifts = Map::new();
	for (k, e) in &conts {
		lifts.insert(k.clone(), e.get("lifts").cloned().unwrap_or(Value::Array(vec![])));
	}
	write_atomic(&opts.out.join("lifts.json"), format!("{}\n", js_json(&Value::Object(lifts), None)).as_bytes())?;
	if let Some(text) = crate::areas::areas_json(tables) {
		write_atomic(&opts.out.join("areas.json"), text.as_bytes())?;
	}
	Ok((text, warnings))
}

fn num(v: f64) -> Value {
	serde_json::Number::from_f64(v).map_or(Value::Null, Value::Number)
}

fn exists(p: &Path) -> bool {
	p.exists()
}

fn write_atomic(file: &Path, data: &[u8]) -> Result<(), String> {
	let tmp = file.with_extension(format!("{}.{}.tmp", std::process::id(), rand_tag()));
	std::fs::write(&tmp, data).map_err(|e| format!("{}: {e}", tmp.display()))?;
	std::fs::rename(&tmp, file).map_err(|e| format!("{}: {e}", file.display()))
}

fn rand_tag() -> usize {
	static N: AtomicUsize = AtomicUsize::new(0);
	N.fetch_add(1, Ordering::Relaxed)
}

fn neighbours(col: i32, row: i32) -> Vec<String> {
	let mut out = Vec::new();
	for dr in -1..=1 {
		for dc in -1..=1 {
			if dc != 0 || dr != 0 {
				out.push(tkey(col + dc, row + dr));
			}
		}
	}
	out
}

/// Runs `f` over `items` on `jobs` threads, logging progress every 10 s; a failed item is tried
/// `retries` more times, then logged as a warning -> results in order (None for a failed item).
fn run_all<T: Sync, R: Send>(
	items: &[T],
	jobs: usize,
	label: &str,
	c: u32,
	key: impl Fn(&T) -> String + Sync,
	retries: usize,
	log: &(dyn Fn(&str) + Sync),
	warnings: &Mutex<Vec<String>>,
	f: impl Fn(&T) -> Result<R, String> + Sync,
) -> Vec<Option<R>> {
	let t0 = Instant::now();
	let next = AtomicUsize::new(0);
	let done = AtomicUsize::new(0);
	let last = Mutex::new(Instant::now());
	let results: Vec<Mutex<Option<R>>> = items.iter().map(|_| Mutex::new(None)).collect();
	std::thread::scope(|s| {
		for _ in 0..jobs.max(1).min(items.len().max(1)) {
			s.spawn(|| loop {
				let i = next.fetch_add(1, Ordering::Relaxed);
				if i >= items.len() {
					break;
				}
				let mut r = f(&items[i]);
				let mut left = retries;
				while r.is_err() && left > 0 {
					left -= 1;
					r = f(&items[i]);
				}
				match r {
					Ok(v) => *results[i].lock() = Some(v),
					Err(e) => warnings.lock().push(format!("{label} {c} {}: {}", key(&items[i]), e.lines().next().unwrap_or(""))),
				}
				let d = done.fetch_add(1, Ordering::Relaxed) + 1;
				let mut l = last.lock();
				if l.elapsed().as_secs_f64() > 10.0 {
					*l = Instant::now();
					log(&format!("  {label}: {d}/{} ({:.0} s)", items.len(), t0.elapsed().as_secs_f64()));
				}
			});
		}
	});
	if !items.is_empty() {
		log(&format!("  {label}: {} tiles in {:.1} s", items.len(), t0.elapsed().as_secs_f64()));
	}
	results.into_iter().map(|m| m.into_inner()).collect()
}

struct Paths {
	dir: PathBuf,
}
impl Paths {
	fn file(&self, col: i32, row: i32, ext: &str) -> PathBuf {
		self.dir.join(format!("{}.{ext}.gz", tkey(col, row)))
	}
	/// The tile's surfaces: the linked file if present, else the surfaces-only one (worker.js readTile).
	fn read_tile(&self, col: i32, row: i32, linked: bool) -> Result<Option<Tile>, String> {
		let exts: &[&str] = if linked { &["nav"] } else { &["nav", "surf"] };
		for ext in exts {
			if let Ok(b) = std::fs::read(self.file(col, row, ext)) {
				return format::decode_tile(&b).map(Some);
			}
		}
		Ok(None)
	}
	fn around(&self, col: i32, row: i32, linked: bool, walls: bool) -> Result<[Option<Tile>; 9], String> {
		let mut out: [Option<Tile>; 9] = Default::default();
		for (x, slot) in out.iter_mut().enumerate() {
			let (dc, dr) = ((x % 3) as i32 - 1, (x / 3) as i32 - 1);
			let mut t = self.read_tile(col + dc, row + dr, linked)?;
			if walls {
				if let Some(t) = &mut t {
					t.walls = match std::fs::read(self.file(col + dc, row + dr, "walls")) {
						Ok(b) => Some(format::decode_walls(&b)?),
						Err(_) => None,
					};
				}
			}
			*slot = t;
		}
		Ok(out)
	}
}
fn build_continent(
	opts: &Opts,
	src: &dyn Source,
	tables: &geom::Tables,
	cache: &geom::ModelCache,
	c: u32,
	name: &str,
	tiles: &[geom::TileRef],
	lift_points: &[&LiftPoint],
	prev: Option<&Value>,
	force: bool,
	log: &(dyn Fn(&str) + Sync),
	warnings: &mut Vec<String>,
) -> Result<Value, String> {
	let p = Paths { dir: opts.out.join("tiles").join(c.to_string()) };
	std::fs::create_dir_all(&p.dir).map_err(|e| format!("{}: {e}", p.dir.display()))?;
	let mut tiles: Vec<geom::TileRef> = tiles.to_vec();
	tiles.sort_by(|a, b| a.row.cmp(&b.row).then(a.col.cmp(&b.col)));
	let by_key: FxHashSet<String> = tiles.iter().map(|t| tkey(t.col, t.row)).collect();
	let t0 = Instant::now();
	log(&format!("{} ({c}): {} tiles", if name.is_empty() { "continent" } else { name }, tiles.len()));
	// tileStats, in the JS object's order.
	let mut stats: Vec<(String, [u64; 3])> = Vec::new();
	if let Some(ts) = prev.and_then(|v| v["tileStats"].as_object()) {
		for (k, v) in ts {
			let a: Vec<u64> = v.as_array().map(|a| a.iter().map(|x| x.as_u64().unwrap_or(0)).collect()).unwrap_or_default();
			stats.push((k.clone(), [a.first().copied().unwrap_or(0), a.get(1).copied().unwrap_or(0), a.get(2).copied().unwrap_or(0)]));
		}
	}
	let warn = Mutex::new(Vec::<String>::new());
	let key = |t: &geom::TileRef| tkey(t.col, t.row);

	let surf: Vec<geom::TileRef> = tiles.iter().filter(|t| force || (!exists(&p.file(t.col, t.row, "nav")) && !exists(&p.file(t.col, t.row, "surf")))).cloned().collect();
	let r1 = run_all(&surf, opts.jobs, "surfaces", c, key, 1, log, &warn, |t| {
		let g = geom::tile_geometry(src, tables, c, t, cache)?;
		let hf = crate::rasterise::rasterise(&g);
		let (tile, _stats) = crate::surfaces::build_surfaces(hf, &g);
		write_atomic(&p.file(t.col, t.row, "area"), &crate::areas::encode_areas(&crate::areas::surface_areas(&g, &tile)))?;
		write_atomic(&p.file(t.col, t.row, "walls"), &format::encode_walls(tile.walls.as_ref().expect("surfaces have walls")))?;
		write_atomic(&p.file(t.col, t.row, "surf"), &format::encode_tile(&tile)?)?;
		let _ = std::fs::remove_file(p.file(t.col, t.row, "nav"));
		let _ = std::fs::remove_file(p.file(t.col, t.row, "hpa"));
		Ok((g.kind.len(), g.stats.missing))
	});
	let mut built: FxHashSet<String> = FxHashSet::default();
	let mut geom_tris = 0usize;
	let mut missing: Vec<u32> = Vec::new();
	for (t, r) in surf.iter().zip(&r1) {
		let Some((tris, miss)) = r else { continue };
		built.insert(tkey(t.col, t.row));
		geom_tris += tris;
		for m in miss {
			if !missing.contains(m) {
				missing.push(*m);
			}
		}
	}
	if !missing.is_empty() {
		let shown: Vec<String> = missing.iter().take(10).map(|m| m.to_string()).collect();
		warnings.push(format!("continent {c}: {} models missing ({}{})", missing.len(), shown.join(", "), if missing.len() > 10 { ", ..." } else { "" }));
	}

	let mut relink: FxHashSet<String> = FxHashSet::default();
	for t in &tiles {
		let k = tkey(t.col, t.row);
		if !exists(&p.file(t.col, t.row, "surf")) && !exists(&p.file(t.col, t.row, "nav")) {
			continue;
		}
		if force || built.contains(&k) || !exists(&p.file(t.col, t.row, "nav")) || neighbours(t.col, t.row).iter().any(|n| built.contains(n)) {
			relink.insert(k);
		}
	}
	let link_tiles: Vec<geom::TileRef> = tiles.iter().filter(|t| relink.contains(&tkey(t.col, t.row))).cloned().collect();
	let r2 = run_all(&link_tiles, opts.jobs, "links", c, key, 0, log, &warn, |t| {
		let ar = p.around(t.col, t.row, false, true)?;
		let refs: [Option<&Tile>; 9] = std::array::from_fn(|x| ar[x].as_ref());
		let mut tile = ar[4].clone().ok_or_else(|| format!("nav {c} {}: no surfaces to link", tkey(t.col, t.row)))?;
		let lo = crate::links::link_tile(&refs);
		tile.links = Some(lo.links);
		tile.fall_from = lo.fall_from;
		tile.fall_to = lo.fall_to;
		tile.walls = None;
		let (comp, n_comp) = crate::regions::local_components(&tile);
		tile.comp = Some(comp);
		tile.n_comp = n_comp;
		write_atomic(&p.file(t.col, t.row, "nav"), &format::encode_tile(&tile)?)?;
		let walkable = tile.flags.iter().filter(|f| *f & flag::BLOCKED == 0).count() as u64;
		Ok([tile.n as u64, walkable, tile.fall_from.len() as u64])
	});
	for (t, r) in link_tiles.iter().zip(&r2) {
		if let Some(s) = r {
			let k = tkey(t.col, t.row);
			match stats.iter_mut().find(|x| x.0 == k) {
				Some(x) => x.1 = *s,
				None => stats.push((k, *s)),
			}
		}
	}
	for t in &tiles {
		if exists(&p.file(t.col, t.row, "nav")) && exists(&p.file(t.col, t.row, "surf")) {
			let _ = std::fs::remove_file(p.file(t.col, t.row, "surf"));
		}
	}

	let lifts = lift_links(&p, lift_points)?;
	let lifts_json = Value::Array(lifts.iter().map(lift_json).collect());
	let lifts_key = js_json(&lifts_json, None);
	let mut lift_tiles: FxHashSet<String> = FxHashSet::default();
	for l in &lifts {
		lift_tiles.insert(tkey(l.a.col, l.a.row));
		lift_tiles.insert(tkey(l.b.col, l.b.row));
	}
	if let Some(pl) = prev.and_then(|v| v["lifts"].as_array()) {
		for l in pl {
			for e in ["a", "b"] {
				lift_tiles.insert(tkey(l[e]["col"].as_i64().unwrap_or(0) as i32, l[e]["row"].as_i64().unwrap_or(0) as i32));
			}
		}
	}
	let lifts_changed = prev.is_none_or(|v| v["liftsKey"].as_str() != Some(lifts_key.as_str()));
	let rides_of = |t: &geom::TileRef| -> Vec<(u32, format::LiftRide)> {
		let mut out = Vec::new();
		for l in &lifts {
			if l.a.col == t.col && l.a.row == t.row {
				out.push((l.a.entry, format::LiftRide { col: l.b.col, row: l.b.row, k: l.b.k, entry: l.b.entry, h: l.b.z - l.a.z }));
			}
			if l.b.col == t.col && l.b.row == t.row {
				out.push((l.b.entry, format::LiftRide { col: l.a.col, row: l.a.row, k: l.a.k, entry: l.a.entry, h: l.a.z - l.b.z }));
			}
		}
		out
	};
	let stale = prev.is_none_or(|v| v["graphVersion"] != format::GRAPH_VERSION);
	let mut regraph: FxHashSet<String> = FxHashSet::default();
	for t in &tiles {
		let k = tkey(t.col, t.row);
		if !exists(&p.file(t.col, t.row, "nav")) {
			continue;
		}
		if force || stale || !exists(&p.file(t.col, t.row, "hpa")) || relink.contains(&k) || neighbours(t.col, t.row).iter().any(|n| relink.contains(n)) || (lifts_changed && lift_tiles.contains(&k)) {
			regraph.insert(k);
		}
	}
	let graph_tiles: Vec<geom::TileRef> = tiles.iter().filter(|t| regraph.contains(&tkey(t.col, t.row))).cloned().collect();
	run_all(&graph_tiles, opts.jobs, "graph", c, key, 0, log, &warn, |t| {
		let mut ar = p.around(t.col, t.row, true, false)?;
		let centre = ar[4].as_mut().ok_or_else(|| format!("nav {c} {}: not linked", tkey(t.col, t.row)))?;
		let rides = rides_of(t);
		let mut lifts: Vec<(u32, Vec<format::LiftRide>)> = Vec::new();
		for (from, r) in &rides {
			match lifts.iter_mut().find(|x| x.0 == *from) {
				Some(x) => x.1.push(r.clone()),
				None => lifts.push((*from, vec![r.clone()])),
			}
		}
		centre.lifts = if rides.is_empty() { None } else { Some(lifts) };
		let refs: [Option<&Tile>; 9] = std::array::from_fn(|x| ar[x].as_ref());
		let froms: Vec<u32> = rides.iter().map(|r| r.0).collect();
		let part = graph::tile_graph(&refs, &froms);
		write_atomic(&p.file(t.col, t.row, "hpa"), &format::gzip(graph::part_json(&part).as_bytes()))?;
		Ok(())
	});
	warnings.extend(warn.into_inner());

	let present: Vec<&geom::TileRef> = tiles.iter().filter(|t| exists(&p.file(t.col, t.row, "nav")) && exists(&p.file(t.col, t.row, "hpa"))).collect();
	let mut parts = Vec::with_capacity(present.len());
	for t in &present {
		let gz = std::fs::read(p.file(t.col, t.row, "hpa")).map_err(|e| e.to_string())?;
		let text = String::from_utf8(format::gunzip(&gz)?).map_err(|e| e.to_string())?;
		parts.push(graph::compact_part(graph::parse_part_json(&text)?));
	}
	let (g, gs) = graph::assemble_graph(c, parts, &lifts);
	if !lifts.is_empty() {
		log(&format!("  lifts: {}", lifts.iter().map(|l| format!("{} {} yd", l.name, fmath::num_to_string(fmath::round(l.h)))).collect::<Vec<_>>().join(", ")));
	}
	if gs.broken > 0 {
		warnings.push(format!("continent {c}: {} border edges without a node on the other side", gs.broken));
	}
	let graph_file = opts.out.join("graph").join(format!("{c}.bin.gz"));
	std::fs::create_dir_all(graph_file.parent().unwrap()).map_err(|e| e.to_string())?;
	write_atomic(&graph_file, &format::encode_graph(&g))?;
	stats.retain(|(k, _)| by_key.contains(k));
	let (mut entries, mut walkable, mut falls) = (0u64, 0u64, 0u64);
	for (_, [e, w, f]) in &stats {
		entries += e;
		walkable += w;
		falls += f;
	}
	// (Date.now() milliseconds, as the JS.)
	let seconds = t0.elapsed().as_millis() as f64 / 1000.0;
	log(&format!("  {} tiles, {walkable} walkable surfaces, {falls} falls, {} nodes, {} regions ({seconds:.1} s)", present.len(), gs.nodes, gs.regions));
	let tris = if geom_tris > 0 { geom_tris as u64 } else { prev.and_then(|v| v["tris"].as_u64()).unwrap_or(0) };
	let mut e = Map::new();
	e.insert("name".into(), if name.is_empty() { Value::Null } else { name.into() });
	e.insert("tiles".into(), Value::Array(present.iter().map(|t| Value::String(tkey(t.col, t.row))).collect()));
	e.insert("entries".into(), entries.into());
	e.insert("surfaces".into(), walkable.into());
	e.insert("falls".into(), falls.into());
	e.insert("nodes".into(), gs.nodes.into());
	e.insert("edges".into(), Value::Array(gs.edges.iter().map(|&x| x.into()).collect()));
	e.insert("regions".into(), gs.regions.into());
	e.insert("components".into(), gs.components.into());
	e.insert("graph".into(), format!("graph/{c}.bin.gz").into());
	e.insert("graphVersion".into(), format::GRAPH_VERSION.into());
	e.insert("lifts".into(), lifts_json);
	e.insert("liftsKey".into(), lifts_key.into());
	e.insert("tris".into(), tris.into());
	e.insert("seconds".into(), num(seconds));
	let mut ts = Map::new();
	for (k, [a, b, f]) in &stats {
		ts.insert(k.clone(), Value::Array(vec![(*a).into(), (*b).into(), (*f).into()]));
	}
	e.insert("tileStats".into(), Value::Object(ts));
	Ok(Value::Object(e))
}

fn lift_json(l: &Lift) -> Value {
	let end = |e: &LiftEnd| {
		let mut m = Map::new();
		m.insert("col".into(), e.col.into());
		m.insert("row".into(), e.row.into());
		m.insert("k".into(), e.k.into());
		m.insert("entry".into(), e.entry.into());
		m.insert("z".into(), num(e.z));
		Value::Object(m)
	};
	let mut m = Map::new();
	m.insert("name".into(), l.name.clone().into());
	m.insert("id".into(), l.id.into());
	m.insert("a".into(), end(&l.a));
	m.insert("b".into(), end(&l.b));
	m.insert("h".into(), num(l.h));
	Value::Object(m)
}

/// A lift's car (build.js liftPoints): where travel.json has it stand, else an object's spawn.
#[derive(Clone, Debug)]
pub struct LiftPoint {
	pub c: u32,
	pub wx: f64,
	pub wy: f64,
	pub name: String,
	pub id: u32,
	pub rise: f64,
	/// The car's floor at its lower and upper stops (travel.json), when known.
	pub floor: Option<(f64, f64)>,
}

/// A lift car of travel.json (build.js liftCars): at its first stop, its floor at the lowest and highest.
#[derive(Clone, Debug)]
pub struct LiftCar {
	pub c: u32,
	pub wx: f64,
	pub wy: f64,
	pub lo: f64,
	pub hi: f64,
}

/// Each car of each lift route of travel.json (transit.routes, kind "lift"; a stop is
/// [from, to, c, wx, wy, z, car]), in the routes' and cars' first-seen order.
fn lift_cars(travel: &Value) -> Vec<LiftCar> {
	let mut out = Vec::new();
	let Some(routes) = travel["transit"]["routes"].as_object() else { return out };
	for (_, r) in js_entries(routes) {
		if r["kind"].as_str() != Some("lift") {
			continue;
		}
		let mut cars: Vec<(String, Vec<&Vec<Value>>)> = Vec::new();
		for s in r["stops"].as_array().into_iter().flatten().filter_map(Value::as_array) {
			let key = s.get(6).map(Value::to_string).unwrap_or_default();
			match cars.iter_mut().find(|(k, _)| *k == key) {
				Some((_, v)) => v.push(s),
				None => cars.push((key, vec![s])),
			}
		}
		for (_, stops) in cars {
			let f = |s: &Vec<Value>, i: usize| s.get(i).and_then(Value::as_f64).unwrap_or(0.0);
			let (lo, hi) = stops.iter().map(|s| f(s, 5)).fold((f64::INFINITY, f64::NEG_INFINITY), |(a, b), z| (fmath::min(a, z), fmath::max(b, z)));
			out.push(LiftCar { c: f(stops[0], 2) as u32, wx: f(stops[0], 3), wy: f(stops[0], 4), lo, hi });
		}
	}
	out
}

/// Lifts of continent c (build.js liftLinks): each point joins two landings: open walkable
/// entries within LIFT_REACH of the car whose heights differ by the car's rise within LIFT_FIT,
/// the pair nearest the car; with the car's floor known, each landing's height off it counts
/// LIFT_LEVEL times its distance; one lift per pair of ends.
fn lift_links(p: &Paths, points: &[&LiftPoint]) -> Result<Vec<Lift>, String> {
	let mut cache: rustc_hash::FxHashMap<(i32, i32), Option<Tile>> = Default::default();
	let mut out: Vec<(String, Lift)> = Vec::new();
	let r = (LIFT_REACH / CELL).ceil() as i32;
	let tc = TILE_CELLS as i32;
	for pt in points {
		let (acol, arow, ai, aj) = format::cell_of(pt.wx, pt.wy);
		struct End {
			col: i32,
			row: i32,
			k: u32,
			entry: u32,
			z: f64,
			d: f64,
		}
		let mut ends: Vec<End> = Vec::new();
		for dj in -r..=r {
			for di in -r..=r {
				let gi = acol * tc + ai + di;
				let gj = arow * tc + aj + dj;
				let col = gi.div_euclid(tc);
				let row = gj.div_euclid(tc);
				let i = gi - col * tc;
				let j = gj - row * tc;
				let (cx, cy) = format::cell_centre(col, row, i, j);
				let d = fmath::hypot(cx - pt.wx, cy - pt.wy);
				if d > LIFT_REACH {
					continue;
				}
				let t = cache.entry((col, row)).or_insert_with(|| std::fs::read(p.file(col, row, "nav")).ok().and_then(|b| format::decode_tile(&b).ok()));
				let Some(t) = t.as_ref().filter(|t| t.links.is_some()) else { continue };
				let k = (j * tc + i) as usize;
				for e in t.first[k] as usize..t.first[k + 1] as usize {
					if t.flags[e] & flag::BLOCKED != 0 || !crate::search::is_open(t, k, e, LIFT_OPEN) {
						continue;
					}
					ends.push(End { col, row, k: k as u32, entry: e as u32, z: f64::from(t.z[e]), d });
				}
			}
		}
		ends.sort_by(|x, y| x.z.partial_cmp(&y.z).unwrap_or(std::cmp::Ordering::Equal));
		let mut best: Option<(usize, usize)> = None;
		let mut score = f64::INFINITY;
		let mut y = 0;
		for x in 0..ends.len() {
			let lo = &ends[x];
			while y < ends.len() && ends[y].z < lo.z + pt.rise - LIFT_FIT {
				y += 1;
			}
			let mut w = y;
			while w < ends.len() && ends[w].z <= lo.z + pt.rise + LIFT_FIT {
				let hi = &ends[w];
				let s = match pt.floor {
					Some((zl, zh)) => lo.d + hi.d + LIFT_LEVEL * ((lo.z - zl).abs() + (hi.z - zh).abs()),
					None => lo.d + hi.d + (hi.z - lo.z - pt.rise).abs(),
				};
				if s < score {
					score = s;
					best = Some((x, w));
				}
				w += 1;
			}
		}
		let Some((a, b)) = best else { continue };
		let end = |e: &End| LiftEnd { col: e.col, row: e.row, k: e.k, entry: e.entry, z: e.z };
		let (lo, hi) = (end(&ends[a]), end(&ends[b]));
		let key = format!("{}_{}_{}:{}_{}_{}", lo.col, lo.row, lo.entry, hi.col, hi.row, hi.entry);
		if !out.iter().any(|(k, _)| *k == key) {
			let h = hi.z - lo.z;
			out.push((key, Lift { name: pt.name.clone(), id: pt.id, a: lo, b: hi, h }));
		}
	}
	Ok(out.into_iter().map(|(_, l)| l).collect())
}

/// JS object key order: integer keys ascending, then the rest in insertion order.
fn js_entries(m: &Map<String, Value>) -> Vec<(&String, &Value)> {
	let is_index = |k: &str| !k.is_empty() && k.bytes().all(|b| b.is_ascii_digit()) && (k == "0" || !k.starts_with('0')) && k.parse::<u64>().is_ok_and(|v| v < u32::MAX as u64);
	let mut ints: Vec<(&String, &Value)> = m.iter().filter(|(k, _)| is_index(k)).collect();
	ints.sort_by_key(|(k, _)| k.parse::<u64>().unwrap());
	ints.extend(m.iter().filter(|(k, _)| !is_index(k)));
	ints
}

/// Lift points (build.js liftPoints): every spawn of an object the client animates as a transport
/// whose car rises at least LIFT_MIN and sways at most LIFT_RADIUS; a car of `cars` stands in for
/// the spawns within LIFT_CAR yd of it (a spawn's map position is a tenth of a percent of its map,
/// and each spawn picked its own landings), with the nearest one's object.
fn lift_points(objects: &Value, geo: &Geo, travel: &[(u32, geom::Travel)], cars: &[LiftCar]) -> Vec<LiftPoint> {
	let list: Vec<&Value> = match objects {
		Value::Array(a) => a.iter().collect(),
		Value::Object(m) => js_entries(m).into_iter().map(|(_, v)| v).collect(),
		_ => Vec::new(),
	};
	let mut spawns = Vec::new();
	for o in list {
		let Some(id) = o["id"].as_u64() else { continue };
		let Some((_, tr)) = travel.iter().find(|(i, _)| u64::from(*i) == id) else { continue };
		if tr.rise < LIFT_MIN || tr.sway > LIFT_RADIUS {
			continue;
		}
		let Some(s) = o["spawns"].as_object() else { continue };
		for (map, s) in js_entries(s) {
			let f = if s["f"].as_str() == Some("e") { 'e' } else { 'l' };
			for pt in s["pts"].as_array().into_iter().flatten() {
				let (Some(x), Some(y)) = (pt[0].as_f64(), pt[1].as_f64()) else { continue };
				let Ok(map) = map.parse::<u32>() else { continue };
				if let Some((c, wx, wy)) = geo.to_world(map, x, y, f) {
					spawns.push(LiftPoint { c, wx, wy, name: o["name"].as_str().unwrap_or("").to_string(), id: id as u32, rise: tr.rise, floor: None });
				}
			}
		}
	}
	let mut taken = vec![false; spawns.len()];
	let mut out = Vec::new();
	for car in cars {
		let d = |p: &LiftPoint| fmath::hypot(p.wx - car.wx, p.wy - car.wy);
		let mut nearest: Option<usize> = None;
		for (i, p) in spawns.iter().enumerate() {
			if p.c != car.c || d(p) > LIFT_CAR {
				continue;
			}
			taken[i] = true;
			if nearest.is_none_or(|n| d(p) < d(&spawns[n])) {
				nearest = Some(i);
			}
		}
		let Some(n) = nearest else { continue };
		let p = &spawns[n];
		out.push(LiftPoint { c: car.c, wx: car.wx, wy: car.wy, name: p.name.clone(), id: p.id, rise: p.rise, floor: Some((car.lo, car.hi)) });
	}
	out.extend(spawns.into_iter().zip(taken).filter(|(_, t)| !t).map(|(p, _)| p));
	out
}

#[derive(Clone, Copy)]
struct Frame {
	c: u32,
	left: f64,
	right: f64,
	top: f64,
	bottom: f64,
}

/// The planner's map frames (planner/geo.js Geo, the parts the build uses).
pub struct Geo {
	era: rustc_hash::FxHashMap<u32, Frame>,
	live: rustc_hash::FxHashMap<u32, Frame>,
	ids: Vec<u32>,
	zone_names: rustc_hash::FxHashMap<u32, (Option<String>, Option<i64>)>,
}

impl Geo {
	pub fn new(frames: &Value, zones: &Value) -> Geo {
		let read = |v: &Value| -> rustc_hash::FxHashMap<u32, Frame> {
			let mut m = rustc_hash::FxHashMap::default();
			for (k, b) in v.as_object().into_iter().flatten() {
				let (Ok(id), Some(c)) = (k.parse::<u32>(), b["c"].as_u64()) else { continue };
				let f = |n: &str| b[n].as_f64().unwrap_or(f64::NAN);
				m.insert(id, Frame { c: c as u32, left: f("left"), right: f("right"), top: f("top"), bottom: f("bottom") });
			}
			m
		};
		let era = read(&frames["era"]);
		let live = read(&frames["forever"]);
		let mut ids: Vec<u32> = era.keys().chain(live.keys()).copied().collect();
		ids.sort_unstable();
		ids.dedup();
		let mut zone_names = rustc_hash::FxHashMap::default();
		for (k, z) in zones.as_object().into_iter().flatten() {
			if let Ok(id) = k.parse::<u32>() {
				let name = match &z["name"] {
					Value::Null => None,
					Value::String(s) if s.is_empty() => None,
					Value::String(s) => Some(s.clone()),
					v => Some(js_json(v, None)),
				};
				zone_names.insert(id, (name, z["type"].as_i64()));
			}
		}
		Geo { era, live, ids, zone_names }
	}

	fn frame(&self, map: u32, f: char) -> Option<Frame> {
		let (a, b) = if f == 'e' { (&self.era, &self.live) } else { (&self.live, &self.era) };
		a.get(&map).or_else(|| b.get(&map)).copied()
	}

	pub fn to_world(&self, map: u32, x: f64, y: f64, f: char) -> Option<(u32, f64, f64)> {
		let b = self.frame(map, f)?;
		Some((b.c, b.top + (b.bottom - b.top) * (y / 100.0), b.left + (b.right - b.left) * (x / 100.0)))
	}

	/// The continents (c, name), c ascending (geo.js continents).
	pub fn continents(&self) -> Vec<(u32, String)> {
		let area = |b: &Frame| ((b.right - b.left) * (b.bottom - b.top)).abs();
		let mut best: Vec<(u32, u32, i32, f64)> = Vec::new(); // c, map, rank, area
		for &id in &self.ids {
			let b = self.frame(id, 'l').unwrap();
			let rank = i32::from(self.zone_names.get(&id).is_some_and(|z| z.1 == Some(2)));
			let a = area(&b);
			match best.iter_mut().find(|x| x.0 == b.c) {
				None => best.push((b.c, id, rank, a)),
				Some(cur) => {
					if rank > cur.2 || (rank == cur.2 && a > cur.3) {
						*cur = (b.c, id, rank, a);
					}
				}
			}
		}
		best.sort_by_key(|x| x.0);
		best.into_iter().map(|(c, map, _, _)| (c, self.zone_names.get(&map).and_then(|z| z.0.clone()).unwrap_or_else(|| format!("Map {c}")))).collect()
	}
}

/// JSON.stringify(v) (indent: JSON.stringify(v, null, indent)).
pub fn js_json(v: &Value, indent: Option<&str>) -> String {
	let mut s = String::new();
	write_json(&mut s, v, indent, 0);
	s
}

fn write_json(s: &mut String, v: &Value, indent: Option<&str>, depth: usize) {
	let nl = |s: &mut String, d: usize| {
		if let Some(ind) = indent {
			s.push('\n');
			for _ in 0..d {
				s.push_str(ind);
			}
		}
	};
	match v {
		Value::Null => s.push_str("null"),
		Value::Bool(b) => s.push_str(if *b { "true" } else { "false" }),
		Value::Number(n) => {
			let f = n.as_f64().unwrap_or(f64::NAN);
			if f.is_finite() {
				s.push_str(&fmath::num_to_string(f));
			} else {
				s.push_str("null");
			}
		}
		Value::String(t) => s.push_str(&serde_json::to_string(t).unwrap()),
		Value::Array(a) => {
			if a.is_empty() {
				s.push_str("[]");
				return;
			}
			s.push('[');
			for (i, x) in a.iter().enumerate() {
				if i > 0 {
					s.push(',');
				}
				nl(s, depth + 1);
				write_json(s, x, indent, depth + 1);
			}
			nl(s, depth);
			s.push(']');
		}
		Value::Object(m) => {
			if m.is_empty() {
				s.push_str("{}");
				return;
			}
			s.push('{');
			for (i, (k, x)) in js_entries(m).into_iter().enumerate() {
				if i > 0 {
					s.push(',');
				}
				nl(s, depth + 1);
				s.push_str(&serde_json::to_string(k).unwrap());
				s.push(':');
				if indent.is_some() {
					s.push(' ');
				}
				write_json(s, x, indent, depth + 1);
			}
			nl(s, depth);
			s.push('}');
		}
	}
}

/// new Date().toISOString().
fn iso_now() -> String {
	let d = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).unwrap_or_default();
	let ms = d.as_millis() as i64;
	let (secs, milli) = (ms.div_euclid(1000), ms.rem_euclid(1000));
	let days = secs.div_euclid(86400);
	let rem = secs.rem_euclid(86400);
	// Civil from days (Howard Hinnant).
	let z = days + 719_468;
	let era = z.div_euclid(146_097);
	let doe = z - era * 146_097;
	let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146_096) / 365;
	let y = yoe + era * 400;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let dd = doy - (153 * mp + 2) / 5 + 1;
	let m = if mp < 10 { mp + 3 } else { mp - 9 };
	let y = if m <= 2 { y + 1 } else { y };
	format!("{y:04}-{m:02}-{dd:02}T{:02}:{:02}:{:02}.{milli:03}Z", rem / 3600, rem % 3600 / 60, rem % 60)
}
