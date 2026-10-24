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
	let mut guides = BTreeMap::new();
	read_guides(&guides_dir, "", &mut guides).map_err(|e| format!("{}: {e}", guides_dir.display()))?;

	// The walk store (walking yards round mountains): given, else walks-<faction>.bin beside the world.
	let walks_file = pin.walks.clone().unwrap_or_else(|| {
		let name = pin.world.file_name().and_then(|n| n.to_str()).unwrap_or("").replace("world-", "walks-").replace(".json", ".bin");
		pin.world.with_file_name(name)
	});
	let walks = Snapped::load(&walks_file, &world);
	if walks.is_none() {
		log.push(format!("apply-route: no walk store at {} for this world (straight lines only)", walks_file.display()));
	}
	let gdata = forge_guide::data::load_data(&data_dir)?;
	let local = root.join("data/local/mechanics");
	let read_opt =
		|f: &str| -> Option<serde_json::Value> { std::fs::read(local.join(f)).ok().and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok()).and_then(|v| v.get("quests").cloned()) };
	let mechanics = read_opt("quest-mechanics.json");
	let steps = read_opt("quest-steps.json");
	let spells = spell_names(&root.join("data/sources"));
	let checkout = pin.checkout.clone().unwrap_or_else(|| root.clone());
	let places = read_records(&checkout.join(PLACES))?;
	let guide_fixes = read_records(&checkout.join(GUIDE_FIXES))?;
	let rinp = crate::RunInputs {
		route: &route,
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
		records: crate::fixes::Records { places: places.as_ref(), guide_fixes: guide_fixes.as_ref() },
	};
	let ro = crate::run(&rinp, opts)?;
	let tree = &ro.tree;
	let _ = std::fs::remove_dir_all(&out);
	copy_tree(&guides_dir, &out).map_err(|e| format!("{}: {e}", out.display()))?;
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

/// The walk store's routed yards between world points, positions snapped to the world's points.
struct Snapped {
	table: forge_sim::walks::WalkTable,
	grid: rustc_hash::FxHashMap<(i64, i64, i64), Vec<(u32, f64, f64)>>,
}

const SNAP_YD: f64 = 40.0;

impl Snapped {
	fn load(file: &Path, world: &World) -> Option<Snapped> {
		let table = forge_sim::walks::WalkTable::load(file, world.points.len()).ok()?;
		if world.data_hash.as_deref().is_some_and(|h| !table.data_hash.is_empty() && h != table.data_hash) {
			eprintln!("engine: {} was built on other data than the world", file.display());
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
