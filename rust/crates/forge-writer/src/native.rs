//! File-system entry of the guides stage (native): `run_paths` reads the route, world, walk store,
//! guides and data from their paths, runs `run`, and writes the guide tree to `out`.

use crate::input::{Data, Route, World};
use crate::RunOpts;
use crate::RunOutput;
use forge_core::frames::MapFrames;
use forge_world::atlas::{GridSubzones, SubzoneOf};
use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

/// Where the guides stage reads from and writes to.
#[derive(Clone, Debug)]
pub struct PathInputs {
	pub route: PathBuf,
	pub world: PathBuf,
	/// The walk store (default: walks-<faction>.bin beside the world file).
	pub walks: Option<PathBuf>,
	/// The guides folder (v1's).
	pub guides: PathBuf,
	/// The checkout whose data/forever, data/sources, data/local (nav4, mechanics) are read.
	pub root: PathBuf,
	/// The game data (default <root>/data/forever).
	pub data_dir: Option<PathBuf>,
	/// The written guide tree (replaced).
	pub out: PathBuf,
	/// The checkout whose data/places.json and data/guide-fixes.json the fix pass applies (default: root).
	pub checkout: Option<PathBuf>,
}

/// The places file of a checkout.
pub const PLACES: &str = "data/places.json";
/// The guide fixes file of a checkout.
pub const GUIDE_FIXES: &str = "data/guide-fixes.json";

/// A record file of the checkout: None when it is absent, an error when it does not parse.
pub fn read_records(file: &Path) -> Result<Option<serde_json::Value>, String> {
	match std::fs::read(file) {
		Ok(b) => serde_json::from_slice(&b).map(Some).map_err(|e| format!("{}: {e}", file.display())),
		Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(None),
		Err(e) => Err(format!("{}: {e}", file.display())),
	}
}

pub fn read_json<T: serde::de::DeserializeOwned>(f: &Path) -> Result<T, String> {
	let b = std::fs::read(f).map_err(|e| format!("{}: {e}", f.display()))?;
	serde_json::from_slice(&b).map_err(|e| format!("{}: {e}", f.display()))
}

pub fn read_guides(dir: &Path, rel: &str, out: &mut BTreeMap<String, String>) -> std::io::Result<()> {
	let mut entries: Vec<_> = std::fs::read_dir(dir.join(rel))?.filter_map(Result::ok).collect();
	entries.sort_by_key(|e| e.file_name());
	for e in entries {
		let name = e.file_name().to_string_lossy().into_owned();
		let r = if rel.is_empty() { name.clone() } else { format!("{rel}/{name}") };
		if e.file_type()?.is_dir() {
			read_guides(dir, &r, out)?;
		} else if name.ends_with(".guide") {
			out.insert(r, std::fs::read_to_string(e.path())?);
		}
	}
	Ok(())
}

pub fn copy_tree(from: &Path, to: &Path) -> std::io::Result<()> {
	std::fs::create_dir_all(to)?;
	for e in std::fs::read_dir(from)? {
		let e = e?;
		let t = to.join(e.file_name());
		if e.file_type()?.is_dir() {
			copy_tree(&e.path(), &t)?;
		} else {
			std::fs::copy(e.path(), t)?;
		}
	}
	Ok(())
}

pub fn run_paths(pin: &PathInputs, opts: &RunOpts) -> Result<RunOutput, String> {
	let root = pin.root.clone();
	let guides_dir = pin.guides.clone();
	let out = pin.out.clone();
	let data_dir = pin.data_dir.clone().unwrap_or_else(|| root.join("data/forever"));
	let mut log: Vec<String> = Vec::new();
	let route: Route = read_json(&pin.route)?;
	let world: World = read_json(&pin.world)?;
	let data = Data {
		quests: read_json(&data_dir.join("quests.json"))?,
		npcs: read_json(&data_dir.join("npcs.json"))?,
		objects: read_json(&data_dir.join("objects.json"))?,
		items: read_json(&data_dir.join("items.json"))?,
		zones: read_json(&data_dir.join("zones.json"))?,
	};
	let frames = MapFrames::from_json(&std::fs::read(data_dir.join("map-frames.json")).map_err(|e| e.to_string())?).map_err(|e| format!("map-frames.json: {e}"))?;
	let grid = std::env::var("POLESTAR_GRID").map_or_else(|_| root.join("data/local/nav4"), PathBuf::from);
	let areas = GridSubzones::open(&grid, &root.join("data/sources"));
	let floors = forge_nav::grid::Grid::open(&grid, 256).ok().map(NavFloors);
	if floors.is_none() {
		log.push(format!("apply-route: no walking grid at {} (no where-notes)", grid.display()));
	}
	let heights = std::fs::read_to_string(root.join("data/sources/forever-tdb/extract.json")).ok().and_then(|t| forge_guide::js::parse_json(&t).ok()).map(|v| v.get("spawns")).filter(|v| v.truthy());
	let mut guides = BTreeMap::new();
	read_guides(&guides_dir, "", &mut guides).map_err(|e| format!("{}: {e}", guides_dir.display()))?;

	// The walk store (walking yards round mountains): given, else walks-<faction>.bin beside the world.
	let walks_file = pin.walks.clone().unwrap_or_else(|| {
		let name = pin.world.file_name().and_then(|n| n.to_str()).unwrap_or("").replace("world-", "walks-").replace(".json", ".bin");
		pin.world.with_file_name(name)
	});
	let walks = Snapped::load(&walks_file, &world, &pin.world);
	if walks.is_none() {
		log.push(format!("apply-route: no walk store at {} for this world (straight lines only)", walks_file.display()));
	}
	let gdata = forge_guide::data::load_data(&data_dir)?;
	let local = root.join("data/local/mechanics");
	let read_opt =
		|f: &str| -> Option<serde_json::Value> { std::fs::read(local.join(f)).ok().and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok()).and_then(|v| v.get("quests").cloned()) };
	let mechanics = read_opt("quest-mechanics.json");
	let steps = read_opt("quest-steps.json");
	let notes = read_opt("quest-notes.json");
	let spells = spell_names(&root.join("data/sources"));
	let checkout = pin.checkout.clone().unwrap_or_else(|| root.clone());
	// (The route fixes' pairs the hub tour keeps: the checkout's, unless a program loaded others.)
	if forge_sim::fixes::path().is_none() {
		forge_sim::fixes::load_for(&[&checkout])?;
	}
	let places = read_records(&checkout.join(PLACES))?;
	let guide_fixes = read_records(&checkout.join(GUIDE_FIXES))?;
	// One shared route per faction (shared.rs): the faction's routes beside this one, when the route
	// has a shared tail; its own run on the faction's shared order, the shared guides from the
	// canonical start's.
	let faction = if opts.engine && opts.route_legs { faction_routes(&pin.route, &route) } else { Vec::new() };
	let race_file = |f: &str| {
		let rel = f.trim_start_matches("guides/");
		guides.get(rel).is_some_and(|t| !crate::shared::is_shared(t))
	};
	let starts: Vec<crate::shared::Start> = faction.iter().map(|(n, r)| crate::shared::Start { name: n.clone(), route: r }).collect();
	let fac = route.faction.as_deref().and_then(forge_core::Faction::parse);
	let takes = |q: u32, race: &str| {
		let Some(mask) = data.quests.get(&q).and_then(|d| d.races).filter(|m| *m > 0.0 && m.fract() == 0.0).map(|m| m as u64) else { return true };
		let Some(f) = fac else { return true };
		let bit = if race.eq_ignore_ascii_case("skyborne") {
			Some(f.skyborne_bit())
		} else {
			forge_core::RACES.iter().find(|r| r.file.eq_ignore_ascii_case(race) || r.key.eq_ignore_ascii_case(race)).map(|r| r.bit(f))
		};
		bit.is_none_or(|b| b == 0 || mask & b != 0)
	};
	let yd = |a: &crate::input::Order, b: &crate::input::Order| match (a.pt.and_then(|p| world.points.get(p as usize)), b.pt.and_then(|p| world.points.get(p as usize))) {
		(Some(p), Some(q)) if p.c == q.c => (p.wx - q.wx).hypot(p.wy - q.wy),
		_ => f64::INFINITY,
	};
	let facts = crate::shared::Facts { race_file: &race_file, takes: &takes, yd: &yd };
	let merged = if starts.len() > 1 { crate::shared::faction_tail(&starts, &facts) } else { None };
	// (A start's own run writes its own guides: the shared order's quests it does, so no line of
	// another start's quest lands in its guides; the canonical start's run is the shared guides' and
	// takes all of it.)
	let own_name = pin.route.file_stem().and_then(|s| s.to_str()).unwrap_or("").to_string();
	let own_route = merged.as_ref().map(|m| {
		if crate::shared::canonical(&route).as_deref() == Some(own_name.as_str()) {
			return crate::shared::with_tail(&route, &m.tail);
		}
		let mine: Vec<crate::input::Order> = m.tail.iter().filter(|o| o.q.is_none_or(|q| m.by_quest.get(&q).is_some_and(|s| s.contains(&own_name)))).cloned().collect();
		let mut r = crate::shared::with_tail(&route, &mine);
		// (Its quests left off the shared route are not taken.)
		if let Some(out) = m.left_out.get(&own_name) {
			r.order.retain(|o| o.q.is_none_or(|q| !out.contains(&q)));
		}
		r
	});
	let rinp = crate::RunInputs {
		route: own_route.as_ref().unwrap_or(&route),
		guides: &guides,
		world: &world,
		data: &data,
		gdata: &gdata,
		frames: &frames,
		area_at: Some(&areas as &dyn SubzoneOf),
		walks: walks.as_ref().map(|w| &w.table as &dyn forge_sim::walks::Walks),
		walk_yards: walks.as_ref().map(|w| w as &dyn crate::engine::WalkYards),
		mechanics: mechanics.as_ref(),
		steps: steps.as_ref(),
		spells: spells.as_ref(),
		floors: floors.as_ref().map(|f| f as &dyn crate::tips::Floors),
		heights: heights.as_ref(),
		notes: notes.as_ref(),
		records: crate::fixes::Records { places: places.as_ref(), guide_fixes: guide_fixes.as_ref() },
	};
	let mut ro = crate::run(&rinp, opts)?;
	if let Some(crate::shared::SharedOrder { tail, by_quest, left_out }) = &merged {
		let canon_name = crate::shared::canonical(&route).unwrap_or_default();
		let canon_tree = if own_name == canon_name {
			ro.tree.clone()
		} else {
			let canon =
				faction.iter().find(|(n, _)| *n == canon_name).map(|(_, r)| crate::shared::with_tail(r, tail)).ok_or_else(|| format!("apply-route: no route of the canonical start {canon_name}"))?;
			crate::run(&crate::RunInputs { route: &canon, ..rinp }, opts)?.tree
		};
		let join_at = route.shared.as_ref().and_then(|s| s.get("joinAt")).and_then(|v| v.as_str()).unwrap_or("");
		let join = guides.iter().find(|(r, t)| r.rsplit('/').next() == Some(&format!("{join_at}.guide")) && crate::shared::is_shared(t)).map(|(r, _)| r.trim_end_matches(".guide").to_string());
		if let Some(join) = join {
			// Every start's first guide, for every race's own ways on the shared guides.
			let firsts: Vec<(String, String)> = faction
				.iter()
				.filter_map(|(n, r)| r.order.iter().find_map(|o| o.from.as_deref().and_then(|f| f.rsplit_once(':')).map(|f| f.0.trim_start_matches("guides/").to_string())).map(|f| (n.clone(), f)))
				.collect();
			let fname = route.faction.clone().unwrap_or_default();
			let wy = walks.as_ref().map(|w| w as &dyn crate::engine::WalkYards);
			let mut tlog: Vec<String> = Vec::new();
			let mut finish = |s: &mut BTreeMap<String, String>| tlog = crate::shared::audience_travel(s, &guides, &firsts, &fname, &gdata, wy);
			let all: Vec<String> = faction.iter().map(|(n, _)| crate::shared::race_of(n)).collect();
			let races_for = |q: u32| -> Option<Vec<String>> {
				let open: Vec<String> = all.iter().filter(|r| takes(q, r)).cloned().collect();
				(open.len() < all.len()).then_some(open)
			};
			// (The guides the start's own run has route lines in.)
			let route_files: rustc_hash::FxHashSet<String> = own_route.as_ref().unwrap_or(&route).order.iter().filter_map(|o| o.from.as_deref().and_then(|f| f.rsplit_once(':')).map(|f| f.0.trim_start_matches("guides/").to_string())).collect();
			// (The shared guides its own part plays before the join: Night Elves' Darkshore.)
			let own_route_ref = own_route.as_ref().unwrap_or(&route);
			let jstep = crate::shared::join_step(own_route_ref).unwrap_or(0).min(own_route_ref.order.len());
			let mut own_shared: Vec<String> = Vec::new();
			for o in &own_route_ref.order[..jstep] {
				let Some(rel) = o.from.as_deref().and_then(|f| f.rsplit_once(':')).map(|f| f.0.trim_start_matches("guides/").to_string()) else { continue };
				if guides.get(&rel).is_some_and(|t| crate::shared::is_shared(t)) && !own_shared.contains(&rel) {
					own_shared.push(rel);
				}
			}
			crate::shared::adopt(&mut ro.tree, &canon_tree, &guides, by_quest, faction.len(), &join, &races_for, &route_files, &own_shared, &mut finish);
			ro.log.extend(tlog);
			ro.log.push(format!("shared route: the faction's shared guides from {canon_name}'s run ({} starts, {} events in the shared order)", faction.len(), tail.len()));
			for (s, qs) in left_out {
				let mut qs: Vec<&u32> = qs.iter().collect();
				qs.sort();
				ro.log.push(format!("shared route: {s} carries quests whose shared-route events need a detour, left out: {qs:?}"));
			}
		}
	}
	let tree = &ro.tree;
	let _ = std::fs::remove_dir_all(&out);
	copy_tree(&guides_dir, &out).map_err(|e| format!("{}: {e}", out.display()))?;
	// (A start's own guide the shared route left with no line goes: the guide before it hands over.)
	for rel in guides.keys().filter(|r| !tree.contains_key(*r)) {
		let _ = std::fs::remove_file(out.join(rel));
	}
	for (rel, text) in tree {
		if guides.get(rel) == Some(text) {
			continue;
		}
		let f = out.join(rel);
		if let Some(d) = f.parent() {
			std::fs::create_dir_all(d).map_err(|e| e.to_string())?;
		}
		std::fs::write(&f, text).map_err(|e| format!("{}: {e}", f.display()))?;
	}
	println!("apply-route: {}", ro.summary.replacen("rewritten;", &format!("rewritten in {};", out.display()), 1));
	let mut ro = ro;
	log.extend(std::mem::take(&mut ro.log));
	ro.log = log;
	Ok(ro)
}

/// The routes of `route`'s faction beside it (`<dir>/<Start>.json`) that share its canonical start,
/// this one included, by start name (sorted).
fn faction_routes(path: &Path, route: &Route) -> Vec<(String, Route)> {
	let (Some(dir), Some(canon)) = (path.parent(), crate::shared::canonical(route)) else { return Vec::new() };
	let Ok(rd) = std::fs::read_dir(dir) else { return Vec::new() };
	let mut out: Vec<(String, Route)> = Vec::new();
	for e in rd.flatten() {
		let p = e.path();
		let Some(stem) = p.file_stem().and_then(|s| s.to_str()) else { continue };
		if p.extension().and_then(|x| x.to_str()) != Some("json") || stem.contains('.') {
			continue;
		}
		let Ok(r) = read_json::<Route>(&p) else { continue };
		if r.faction == route.faction && crate::shared::canonical(&r).as_deref() == Some(canon.as_str()) && crate::shared::join_step(&r).is_some() {
			out.push((stem.to_string(), r));
		}
	}
	out.sort_by(|a, b| a.0.cmp(&b.0));
	out
}

/// The walking grid's columns as R9 reads them (tips.rs).
struct NavFloors(forge_nav::grid::Grid);

impl crate::tips::Floors for NavFloors {
	fn column(&self, c: i64, wx: f64, wy: f64) -> Vec<crate::tips::Surface> {
		use forge_nav::grid::{cell_of, flag, TILE_CELLS};
		let (col, row, i, j) = cell_of(wx, wy);
		let Some(t) = u32::try_from(c).ok().and_then(|c| self.0.tile(c, col, row)) else { return Vec::new() };
		let k = j as usize * TILE_CELLS + i as usize;
		let mut out: Vec<crate::tips::Surface> = (t.first[k] as usize..t.first[k + 1] as usize)
			.map(|e| {
				let f = t.flags[e];
				crate::tips::Surface { z: f64::from(t.z[e]), indoor: f & flag::INDOOR != 0, terrain: f & flag::TERRAIN != 0, swim: f & flag::SWIM != 0, blocked: f & flag::BLOCKED != 0 }
			})
			.collect();
		out.sort_by(|a, b| a.z.total_cmp(&b.z));
		out
	}
}

/// The walk store's routed yards between world points, positions snapped to the world's points.
struct Snapped {
	table: forge_sim::walks::WalkTable,
	grid: rustc_hash::FxHashMap<(i64, i64, i64), Vec<(u32, f64, f64)>>,
}

const SNAP_YD: f64 = 40.0;

impl Snapped {
	/// `world_file`: the world's file (the walks are checked against its walk inputs).
	fn load(file: &Path, world: &World, world_file: &Path) -> Option<Snapped> {
		let table = forge_sim::walks::WalkTable::load(file, world.points.len()).ok()?;
		// By the world's walk inputs; a world file forge-world cannot read (a writer fixture) by its data hash.
		let (ok, why) = match std::fs::read(world_file).ok().and_then(|b| forge_world::World::from_json(&b).ok()) {
			Some(full) => {
				let ok = table.built_on(&full);
				(ok, if ok { String::new() } else { table.built_on_text(&full) })
			}
			None => (
				world.data_hash.as_deref().is_none_or(|h| table.data_hash.is_empty() || h == table.data_hash),
				format!("dataHash {} vs this world's {}", table.data_hash, world.data_hash.as_deref().unwrap_or("-")),
			),
		};
		if !ok {
			eprintln!("engine: {} was built on another world ({why})", file.display());
			return None;
		}
		let mut grid: rustc_hash::FxHashMap<(i64, i64, i64), Vec<(u32, f64, f64)>> = rustc_hash::FxHashMap::default();
		for (i, p) in world.points.iter().enumerate() {
			grid.entry((p.c, (p.wx / SNAP_YD).floor() as i64, (p.wy / SNAP_YD).floor() as i64)).or_default().push((i as u32, p.wx, p.wy));
		}
		Some(Snapped { table, grid })
	}

	fn snap(&self, w: forge_judge::honest::Wpt) -> Option<u32> {
		let (gx, gy) = ((w.wx / SNAP_YD).floor() as i64, (w.wy / SNAP_YD).floor() as i64);
		let mut best = None;
		let mut bd = SNAP_YD;
		for dx in -1..=1 {
			for dy in -1..=1 {
				for &(i, x, y) in self.grid.get(&(w.c as i64, gx + dx, gy + dy)).map_or(&[][..], |v| &v[..]) {
					let d = (x - w.wx).hypot(y - w.wy);
					if d <= bd {
						bd = d;
						best = Some(i);
					}
				}
			}
		}
		best
	}
}

impl crate::engine::WalkYards for Snapped {
	fn yards(&self, a: forge_judge::honest::Wpt, b: forge_judge::honest::Wpt) -> Option<f64> {
		use forge_sim::walks::Walks;
		let (pa, pb) = (self.snap(a)?, self.snap(b)?);
		if pa == pb {
			return Some(0.0);
		}
		self.table.yards(pa, pb)
	}
}

/// The newest Forever client's SpellName table: name -> id, names one spell only.
fn spell_names(sources: &Path) -> Option<rustc_hash::FxHashMap<String, u32>> {
	let wago = sources.join("wago");
	let mut builds: Vec<String> =
		std::fs::read_dir(&wago).ok()?.filter_map(|e| e.ok()?.file_name().into_string().ok()).filter(|b| b.starts_with("1.6") && wago.join(b).join("SpellName.csv").exists()).collect();
	builds.sort_by_key(|b| b.split('.').map(|p| p.parse::<u64>().unwrap_or(0)).collect::<Vec<_>>());
	let text = std::fs::read_to_string(wago.join(builds.last()?).join("SpellName.csv")).ok()?;
	let rows = forge_world::csv::parse_csv(&text).ok()?;
	let mut by: rustc_hash::FxHashMap<String, Vec<u32>> = rustc_hash::FxHashMap::default();
	for r in rows {
		if let (Some(id), Some(n)) = (r.get("ID").and_then(|s| s.parse().ok()), r.get("Name_lang")) {
			by.entry(n.clone()).or_default().push(id);
		}
	}
	Some(by.into_iter().filter(|(_, v)| v.len() == 1).map(|(k, v)| (k, v[0])).collect())
}
