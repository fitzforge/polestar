//! File-system entry of the guides stage (native): `run_paths` reads the route, world, walk store,
//! guides and data from their paths, runs `run`, writes the guide tree to `out` and fails when the
//! pack check (forge_guide::project::check_tree, the report's) refuses it.

use crate::input::{Data, Route, World};
use crate::RunOpts;
use crate::RunOutput;
use forge_core::frames::MapFrames;
use forge_world::atlas::{GridSubzones, SubzoneOf};
use std::collections::BTreeMap;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex, OnceLock};

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

/// What the starts of one faction's shared route have in common when one caller writes them from
/// the same guides, data, world and walks: the run of a route (the canonical start's, which every
/// start's shared guides come from) and the shared guides as `shared::audience_travel` leaves them
/// (every race's and class's own ways, the same for every start). Kept by the exact inputs (the
/// route as run; the shared texts, first guides and faction), so a cached result is the one the
/// start would compute; the paths and options other than the route and output are checked too, and
/// another set empties the cache. forge build keeps one per faction in the guides stage and per
/// written check, and writes the faction's starts at once: a part another start is making is waited
/// for, not made again (the canonical start claims its run before it makes it, so the others' own
/// runs go on beside it). The walk store is loaded once for them too.
#[derive(Default)]
pub struct SharedCache {
	inputs: Mutex<String>,
	runs: Mutex<rustc_hash::FxHashMap<String, Slot<Result<BTreeMap<String, String>, String>>>>,
	ways: Mutex<rustc_hash::FxHashMap<String, Slot<(BTreeMap<String, String>, Vec<String>)>>>,
	walks: Mutex<rustc_hash::FxHashMap<String, Slot<Option<Arc<Snapped>>>>>,
}

/// A cached part: made once, by the first start that asks for it (the others wait for it).
type Slot<T> = Arc<OnceLock<T>>;

impl SharedCache {
	/// The cache for `pin`'s inputs but its route and output (emptied when they differ).
	fn enter(&self, pin: &PathInputs, opts: &RunOpts) {
		let inputs = format!("{:?} {:?} {:?} {:?} {:?} {:?} {opts:?}", pin.world, pin.walks, pin.guides, pin.root, pin.data_dir, pin.checkout);
		let mut cur = self.inputs.lock().unwrap_or_else(|e| e.into_inner());
		if *cur != inputs {
			*cur = inputs;
			self.runs.lock().unwrap_or_else(|e| e.into_inner()).clear();
			self.ways.lock().unwrap_or_else(|e| e.into_inner()).clear();
			self.walks.lock().unwrap_or_else(|e| e.into_inner()).clear();
		}
	}

	/// The slot of `key` in `map` (a new, empty one when none is there yet).
	fn slot<T>(map: &Mutex<rustc_hash::FxHashMap<String, Slot<T>>>, key: String) -> Slot<T> {
		map.lock().unwrap_or_else(|e| e.into_inner()).entry(key).or_default().clone()
	}
}

/// A content key of a value's debug form (the cache's keys).
fn debug_key(v: &impl std::fmt::Debug) -> String {
	forge_core::content_key(format!("{v:?}").as_bytes())
}

/// One start's guides written from its route (`pin`), the faction's shared parts from `cache` when
/// another start of the faction made them or is making them (SharedCache).
pub fn run_paths(pin: &PathInputs, opts: &RunOpts, cache: &SharedCache) -> Result<RunOutput, String> {
	cache.enter(pin, opts);
	let root = pin.root.clone();
	let guides_dir = pin.guides.clone();
	let out = pin.out.clone();
	let data_dir = pin.data_dir.clone().unwrap_or_else(|| root.join("data/forever"));
	let mut log: Vec<String> = Vec::new();
	let scope = format!("writer {}", pin.route.file_stem().and_then(|s| s.to_str()).unwrap_or(""));
	let mut tm = forge_core::timing::start();
	let route: Route = read_route(&pin.route)?;
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
	let walks = SharedCache::slot(&cache.walks, format!("{walks_file:?}")).get_or_init(|| Snapped::load(&walks_file, &world, &pin.world).map(Arc::new)).clone();
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
	let records = crate::fixes::Records { places: places.as_ref(), guide_fixes: guide_fixes.as_ref() };
	let rinp = crate::RunInputs {
		route: own_route.as_ref().unwrap_or(&route),
		guides: &guides,
		world: &world,
		data: &data,
		gdata: &gdata,
		frames: &frames,
		area_at: Some(&areas as &dyn SubzoneOf),
		walks: walks.as_deref().map(|w| &w.table as &dyn forge_sim::walks::Walks),
		walk_yards: walks.as_deref().map(|w| w as &dyn crate::engine::WalkYards),
		mechanics: mechanics.as_ref(),
		steps: steps.as_ref(),
		spells: spells.as_ref(),
		floors: floors.as_ref().map(|f| f as &dyn crate::tips::Floors),
		heights: heights.as_ref(),
		notes: notes.as_ref(),
		records,
	};
	tm.lap(&scope, "load");
	let canon_name = crate::shared::canonical(&route).unwrap_or_default();
	// (The canonical start's run is the faction's shared guides': claimed before it is made, so
	// another start of the faction waits for it rather than making it again.)
	let mut ro = if merged.is_some() && own_name == canon_name {
		let mut mine = None;
		SharedCache::slot(&cache.runs, debug_key(rinp.route)).get_or_init(|| {
			let r = crate::run(&rinp, opts);
			let tree = r.as_ref().map(|o| o.tree.clone()).map_err(String::clone);
			mine = Some(r);
			tree
		});
		match mine {
			Some(r) => r?,
			None => crate::run(&rinp, opts)?,
		}
	} else {
		crate::run(&rinp, opts)?
	};
	tm.lap(&scope, "run");
	if let Some(crate::shared::SharedOrder { tail, by_quest, left_out }) = &merged {
		let canon_tree = if own_name == canon_name {
			ro.tree.clone()
		} else {
			let canon =
				faction.iter().find(|(n, _)| *n == canon_name).map(|(_, r)| crate::shared::with_tail(r, tail)).ok_or_else(|| format!("apply-route: no route of the canonical start {canon_name}"))?;
			let mut made = false;
			let tree = SharedCache::slot(&cache.runs, debug_key(&canon))
				.get_or_init(|| {
					made = true;
					crate::run(&crate::RunInputs { route: &canon, ..rinp }, opts).map(|r| r.tree)
				})
				.clone()?;
			if made {
				tm.lap(&scope, "run canonical");
			}
			tree
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
			let wy = walks.as_deref().map(|w| w as &dyn crate::engine::WalkYards);
			let mut tlog: Vec<String> = Vec::new();
			let mut finish = |s: &mut BTreeMap<String, String>| {
				let slot = SharedCache::slot(&cache.ways, debug_key(&(&*s, &firsts, &fname)));
				let (t, l) = slot.get_or_init(|| {
					let mut t = s.clone();
					let l = crate::shared::audience_travel(&mut t, &guides, &firsts, &fname, &gdata, wy);
					(t, l)
				});
				(*s, tlog) = (t.clone(), l.clone());
			};
			let all: Vec<String> = faction.iter().map(|(n, _)| crate::shared::race_of(n)).collect();
			let races_for = |q: u32| -> Option<Vec<String>> {
				let open: Vec<String> = all.iter().filter(|r| takes(q, r)).cloned().collect();
				(open.len() < all.len()).then_some(open)
			};
			// (The guides the start's own run has route lines in.)
			let route_files: rustc_hash::FxHashSet<String> =
				own_route.as_ref().unwrap_or(&route).order.iter().filter_map(|o| o.from.as_deref().and_then(|f| f.rsplit_once(':')).map(|f| f.0.trim_start_matches("guides/").to_string())).collect();
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
			let fix_races = |t: &str| crate::fixes::apply_races(t, &records, route.faction.as_deref());
			crate::shared::adopt(&mut ro.tree, &canon_tree, &guides, by_quest, faction.len(), &join, &races_for, &fix_races, &route_files, &own_shared, &mut finish);
			ro.log.extend(tlog);
			ro.log.push(format!("shared route: the faction's shared guides from {canon_name}'s run ({} starts, {} events in the shared order)", faction.len(), tail.len()));
			for (s, qs) in left_out {
				let mut qs: Vec<&u32> = qs.iter().collect();
				qs.sort();
				ro.log.push(format!("shared route: {s} carries quests whose shared-route events need a detour, left out: {qs:?}"));
			}
		}
	}
	tm.lap(&scope, "shared adopt");
	// (The route fixes' optional quests, the rare-drop chains, optional on the guides as written; v1's
	// own guides the route leaves as they are, the other faction's among them, stay v1's.)
	let optional = crate::hub::fix_optional(None);
	let rels: Vec<String> = ro.tree.iter().filter(|(r, t)| guides.get(*r) != Some(*t)).map(|(r, _)| r.clone()).collect();
	for rel in rels {
		let mut one = [ro.tree[&rel].clone()];
		crate::post::optional_by_fixes(&mut one, &optional);
		let [text] = one;
		ro.tree.insert(rel, text);
	}
	// (Riding at 40 on the guides as written, the shared ones adopted: after the travel repair's ways
	// to the riding steps, which it writes only for steps that apply.)
	let written: Vec<String> = ro.tree.iter().filter(|(r, t)| guides.get(*r) != Some(*t)).map(|(r, _)| r.clone()).collect();
	for rel in &written {
		let mut one = [ro.tree[rel].clone()];
		crate::post::riding_at_level(&mut one, &data);
		// (One `only` list on a goal the passes, the shared route's adopt among them, gave two.)
		crate::post::one_only(&mut one);
		let [text] = one;
		// (Last, the race lists the `races` guide fixes set: no pass after them.)
		ro.tree.insert(rel.clone(), crate::fixes::apply_races(&text, &records, route.faction.as_deref()));
	}
	// (The titles: the zones each guide as written quests in, docs/forge/writer.md "Guide titles".)
	crate::titles::guide_titles(&mut ro.tree, &written, &|z| gdata.zone_by_name.contains_key(&z.to_lowercase()));
	// (Travel steps that end in a town of the other faction: warned about, for a `way` guide fix. A walk
	// to the next step's quest giver or ender, where the data's spawns put them, is that goal's.)
	let proj = forge_core::frames::Projector::new(&frames);
	let npc_pts = |code: &str| -> Vec<forge_judge::honest::Wpt> {
		let Some(m) = crate::re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code) else { return Vec::new() };
		let Some(q) = m[2].parse::<u32>().ok().and_then(|q| data.quests.get(&q)) else { return Vec::new() };
		let ends = if &m[1] == "accept" { q.start.as_ref() } else { q.end.as_ref() };
		let mut out = Vec::new();
		for n in ends.map_or(&[][..], |e| e.npc.as_slice()) {
			let Some(e) = data.npcs.get(n) else { continue };
			for (&map, sp) in &e.spawns {
				let f = if sp.f.as_deref() == Some("l") { forge_core::frames::Frame::Live } else { forge_core::frames::Frame::Era };
				for p in &sp.pts {
					let c = |i: usize| p.get(i).map_or(f64::NAN, |v| v.unwrap_or(0.0));
					let w = proj.point(map, c(0), c(1), Some(f));
					if w.wx.is_finite() {
						out.push(forge_judge::honest::Wpt { c: w.c as f64, wx: w.wx, wy: w.wy });
					}
				}
			}
		}
		out
	};
	for w in crate::travel::hostile_town_ways(&ro.tree, &written, &gdata, route.faction.as_deref(), &npc_pts) {
		println!("apply-route: warning: {w}");
		ro.log.push(format!("hostile town: {w}"));
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
	tm.lap(&scope, "write files");
	// The pack check on the tree as written, the report's: no tree it refuses is handed on (forge
	// build's written check fails at its write, not in the report after the guides and legs).
	forge_guide::project::check_tree(&out, &gdata).map_err(|e| format!("apply-route {}: {e}", out.display()))?;
	println!("apply-route: {}", ro.summary.replacen("rewritten;", &format!("rewritten in {};", out.display()), 1));
	tm.done(&scope, "pack check");
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
		let Ok(r) = read_route(&p) else { continue };
		if r.faction == route.faction && crate::shared::canonical(&r).as_deref() == Some(canon.as_str()) && crate::shared::join_step(&r).is_some() {
			out.push((stem.to_string(), r));
		}
	}
	out.sort_by(|a, b| a.0.cmp(&b.0));
	out
}

/// A route file with the planner's left-out quests from its skip ledger beside it
/// (`<Start>.skips.json`): the ones left out for their value or a chain not open (Route::left_out).
fn read_route(path: &Path) -> Result<Route, String> {
	let mut r: Route = read_json(path)?;
	let stem = path.file_stem().and_then(|s| s.to_str()).unwrap_or("");
	if let Some(rows) = std::fs::read(path.with_file_name(format!("{stem}.skips.json"))).ok().and_then(|b| serde_json::from_slice::<Vec<serde_json::Value>>(&b).ok()) {
		r.left_out = rows.iter().filter(|x| matches!(x["reason"].as_str(), Some("low-value" | "chain-not-open"))).filter_map(|x| x["q"].as_u64()).filter_map(|q| u32::try_from(q).ok()).collect();
	}
	Ok(r)
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
	borders: Option<crate::borders::Borders>,
}

const SNAP_YD: f64 = 40.0;

impl Snapped {
	/// `world_file`: the world's file (the walks are checked against its walk inputs).
	fn load(file: &Path, world: &World, world_file: &Path) -> Option<Snapped> {
		let mut table = forge_sim::walks::WalkTable::load(file, world.points.len()).ok()?;
		// By the world's walk inputs; a world file forge-world cannot read (a writer fixture) by its data hash.
		// (Under the world's zone crossings, as the routes priced them.)
		let mut borders = None;
		let (ok, why) = match std::fs::read(world_file).ok().and_then(|b| forge_world::World::from_json(&b).ok()) {
			Some(full) => {
				let ok = table.built_on(&full);
				table = table.with_crossings(&full);
				borders = crate::borders::Borders::of(&full.crossings);
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
		Some(Snapped { table, grid, borders })
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
	fn borders(&self) -> Option<&crate::borders::Borders> {
		self.borders.as_ref()
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

#[cfg(test)]
mod tests {
	use super::*;

	fn pin(world: &str, route: &str) -> PathInputs {
		PathInputs {
			route: PathBuf::from(route),
			world: PathBuf::from(world),
			walks: None,
			guides: PathBuf::from("guides"),
			root: PathBuf::from("."),
			data_dir: None,
			out: PathBuf::from(format!("out/{route}")),
			checkout: None,
		}
	}

	/// The shared parts are kept from start to start of one faction (another route and output, the
	/// same inputs), and dropped when the inputs change (the next faction's world).
	#[test]
	fn shared_cache_keeps_a_factions_parts_and_drops_another_inputs() {
		let opts = RunOpts::default();
		let c = SharedCache::default();
		let made = |c: &SharedCache| (SharedCache::slot(&c.runs, "canon".into()).get().is_some(), SharedCache::slot(&c.ways, "ways".into()).get().is_some());
		c.enter(&pin("world-horde.json", "Orc.json"), &opts);
		SharedCache::slot(&c.runs, "canon".into()).get_or_init(|| Ok(BTreeMap::from([("a.guide".to_string(), "x".to_string())])));
		SharedCache::slot(&c.ways, "ways".into()).get_or_init(|| (BTreeMap::new(), vec!["log".into()]));
		c.enter(&pin("world-horde.json", "Troll.json"), &opts);
		assert_eq!(made(&c), (true, true), "another start of the faction keeps them");
		c.enter(&pin("world-alliance.json", "Human.json"), &opts);
		assert_eq!(made(&c), (false, false), "another faction's inputs drop them");
		assert_eq!(debug_key(&("a", 1)), debug_key(&("a", 1)));
		assert_ne!(debug_key(&("a", 1)), debug_key(&("a", 2)));
	}

	/// Starts written at once share a part: the first to ask makes it, the others wait for it and
	/// get the same, and it is made once.
	#[test]
	fn shared_cache_makes_a_part_once_for_starts_at_once() {
		let c = SharedCache::default();
		let calls = std::sync::atomic::AtomicUsize::new(0);
		let got: Vec<Result<BTreeMap<String, String>, String>> = std::thread::scope(|s| {
			let hs: Vec<_> = (0..4)
				.map(|_| {
					s.spawn(|| {
						SharedCache::slot(&c.runs, "canon".into())
							.get_or_init(|| {
								calls.fetch_add(1, std::sync::atomic::Ordering::SeqCst);
								std::thread::sleep(std::time::Duration::from_millis(50));
								Ok(BTreeMap::from([("a.guide".to_string(), "x".to_string())]))
							})
							.clone()
					})
				})
				.collect();
			hs.into_iter().map(|h| h.join().unwrap()).collect()
		});
		assert_eq!(calls.load(std::sync::atomic::Ordering::SeqCst), 1);
		assert!(got.iter().all(|t| t.as_ref().is_ok_and(|t| t["a.guide"] == "x")));
	}
}
