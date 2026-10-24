//! forge build: the client's data and the guides to judged guides for every start, stage by
//! stage (ForgePlan.md "forge build contract"):
//!
//! ```text
//!   grid   -> <out>/grid/ (tiles, graph, index.json, lifts.json)  forge-navbuild from the client
//!   data   -> <out>/data/forever/                                 (import until forge-data builds it)
//!   world  -> <out>/world/world-<faction>.json                    forge-nav stage::world (grid floors)
//!   walks  -> <out>/walks/walks-<faction>.bin                     forge-nav (stage::walks), or imported
//!   routes -> <out>/routes/<start>.json, .skips.json, .edits.json forge-sim (v1 chains by forge-judge)
//!   guides -> <out>/guides/<start>/                               forge-writer (run_paths)
//!   legs   -> <out>/guides/<start>/legs.json, legs-qa.txt         forge::bake (hybrid backend)
//!   report -> <out>/report.md, report.json                        forge judge report
//! ```
//!
//! Each stage's cache key is BLAKE3 of its stage version, its input bytes and the keys of the
//! stages it reads, stored in `<out>/.forge/<stage>.key`; an unchanged key with its outputs in
//! place skips the stage. Large external trees (the walking grid, data/sources) are keyed by a
//! manifest of their files' paths, sizes and modification times instead of their bytes.
//!
//! Every stage reads a repository-shaped staging root, `<out>/.forge/root` (data/forever: the
//! data stage's output; data/sources, data/local, tools, addon: the checkout's; guides: the input
//! guides), and a sim dir, `<out>/.forge/sim` (world-*.json, walks-*.bin, params.json).
//!
//! Without local sources (no data/sources in the root) the build reads the public data pack
//! (`forge data fetch`, pack.rs) as its root; the grid then comes from `--grid`. A walk store the
//! output lacks is seeded from the pack when the grid's content hash is the one it was built on.

pub mod bake;
pub mod calibrate;
pub mod fetch;
pub mod generated;
pub mod ledger;
pub mod pack;

use forge_core::Faction;
use serde_json::{json, Value};
use std::path::{Path, PathBuf};
use std::time::Instant;

/// The client product the grid is built from (the one wago.tools lists Forever under).
pub const GRID_PRODUCT: &str = "wow_classic_beta";
/// Bump a stage's version when its code changes what it writes.
pub const DATA_VERSION: &str = "data-2";
pub const GRID_VERSION: &str = "grid-1";
pub const PREPARE_VERSION: &str = "prepare-2";
pub const WORLD_VERSION: &str = "world-1";
pub const WALKS_VERSION: &str = "walks-1";
pub const ROUTES_VERSION: &str = "routes-8";
pub const GUIDES_VERSION: &str = "guides-2";
pub const REPORT_VERSION: &str = "report-2";
pub const LEGS_VERSION: &str = "legs-1";
/// The decode cache of Leffe's maps (MB): bounded memory per our measurements.
pub const LEFFE_CACHE_MB: usize = 2048;

/// The ten leveling starts: (file stem, race, faction).
pub const ALL_STARTS: [(&str, &str, Faction); 10] = [
	("Orc", "Orc", Faction::Horde),
	("Troll", "Troll", Faction::Horde),
	("Tauren", "Tauren", Faction::Horde),
	("Undead", "Undead", Faction::Horde),
	("Skyborne-horde", "Skyborne", Faction::Horde),
	("Human", "Human", Faction::Alliance),
	("Dwarf", "Dwarf", Faction::Alliance),
	("Gnome", "Gnome", Faction::Alliance),
	("NightElf", "NightElf", Faction::Alliance),
	("Skyborne-alliance", "Skyborne", Faction::Alliance),
];

#[derive(Clone, Debug)]
pub struct Start {
	pub name: String,
	pub race: String,
	pub faction: Faction,
}

/// `all`, or a comma list of stems (`Orc,Human,Skyborne-horde`; a bare `Skyborne` is both).
pub fn parse_starts(s: &str) -> Result<Vec<Start>, String> {
	let all = || ALL_STARTS.iter().map(|&(n, r, f)| Start { name: n.into(), race: r.into(), faction: f }).collect::<Vec<_>>();
	if s.eq_ignore_ascii_case("all") {
		return Ok(all());
	}
	let mut out = Vec::new();
	for w in s.split(',').map(str::trim).filter(|w| !w.is_empty()) {
		let m: Vec<Start> = all().into_iter().filter(|x| x.name.eq_ignore_ascii_case(w) || (w.eq_ignore_ascii_case("skyborne") && x.race == "Skyborne")).collect();
		if m.is_empty() {
			return Err(format!("unknown start {w} (one of {})", ALL_STARTS.iter().map(|x| x.0).collect::<Vec<_>>().join(", ")));
		}
		for x in m {
			if !out.iter().any(|y: &Start| y.name == x.name) {
				out.push(x);
			}
		}
	}
	// ALL_STARTS order: a faction's first start is its shared route's canonical one (Orc, Human).
	out.sort_by_key(|x| ALL_STARTS.iter().position(|a| a.0 == x.name));
	Ok(out)
}

/// The walking backend for the walks stage.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Nav {
	/// Our walking grid only.
	Grid,
	/// Leffe's navigation maps only.
	Leffe,
	/// Leffe's maps, our grid where his have no way or a detour (forge-nav hybrid).
	Hybrid,
}

#[derive(Clone, Debug)]
pub struct BuildOpts {
	/// The Polestar checkout whose fixes the build applies (forever-db/corrections,
	/// data/route-fixes.json); the report names its commit.
	pub checkout: PathBuf,
	/// Fail when a fix no longer applies (the fixes ledger's blocking rows): release builds.
	pub strict: bool,
	/// The installed client (the data stage, once the Rust data build lands).
	pub wow: Option<PathBuf>,
	/// A built data/forever to import instead of building it.
	pub data: Option<PathBuf>,
	/// The checkout the data build reads (forever-db/corrections, data/sources,
	/// data/recordings); default `root`.
	pub data_root: Option<PathBuf>,
	pub guides: PathBuf,
	pub out: PathBuf,
	pub starts: Vec<Start>,
	/// The walks backend; None: Hybrid when Leffe's navigation maps are found, else Grid.
	pub nav: Option<Nav>,
	/// Leffe's navigation maps (the folder with Nav/); default $POLESTAR_LEFFE_NAV, else the data
	/// pack's leffe-nav.
	pub leffe: Option<PathBuf>,
	/// The repository checkout: data/sources, data/local (kb, nav4 grid), data/rules.json,
	/// data/corrections.json, addon (the nav pack's maps), data/sim/params.json.
	pub root: PathBuf,
	/// Prebuilt walks-<faction>.bin to import (keyed by their bytes) instead of building them.
	pub walks_from: Option<PathBuf>,
	/// Build the walking grid from an incomplete install (files missing) instead of refusing.
	pub allow_incomplete: bool,
	/// The walking grid (default $POLESTAR_GRID, else <root>/data/local/nav4).
	pub grid: Option<PathBuf>,
	/// The public data pack (default: fetch::default_pack_dir()): the root when the checkout has
	/// no data/sources, and the walk stores' seed.
	pub pack: Option<PathBuf>,
	pub threads: usize,
	/// Stop after this stage (`walks`: the walk stores for a data pack), None: every stage.
	pub until: Option<String>,
}

/// A file every Polestar checkout has; [`find_checkout`] looks for it.
pub const CHECKOUT_MARK: &str = "forever-db/corrections/quests.json";

/// The nearest folder at or above `from` that is a Polestar checkout.
pub fn find_checkout(from: &Path) -> Option<PathBuf> {
	from.ancestors().find(|d| d.join(CHECKOUT_MARK).is_file()).map(Path::to_path_buf)
}

/// What a stage did.
#[derive(Clone, Debug)]
pub struct StageRun {
	pub stage: &'static str,
	pub key: String,
	pub skipped: bool,
	pub seconds: f64,
	pub outputs: Vec<PathBuf>,
}

/// One input of a cache key.
pub enum Part<'a> {
	Text(&'a str),
	/// A file's bytes (missing: its absence).
	File(&'a Path),
	/// Every file under a directory, by relative path and bytes.
	Dir(&'a Path),
	/// Every file under a directory, by relative path, size and modification time.
	Manifest(&'a Path),
}

fn files_under(dir: &Path) -> Vec<PathBuf> {
	let mut out = Vec::new();
	let mut stack = vec![dir.to_path_buf()];
	while let Some(d) = stack.pop() {
		let Ok(rd) = std::fs::read_dir(&d) else { continue };
		for e in rd.flatten() {
			let p = e.path();
			let name = e.file_name();
			if name.to_string_lossy().starts_with('.') {
				continue;
			}
			match std::fs::metadata(&p) {
				Ok(m) if m.is_dir() => stack.push(p),
				Ok(_) => out.push(p),
				Err(_) => {}
			}
		}
	}
	out.sort();
	out
}

/// BLAKE3 of a stage's name, version and parts (hex).
pub fn key(stage: &str, version: &str, parts: &[Part]) -> String {
	let mut h = blake3::Hasher::new();
	h.update(stage.as_bytes());
	h.update(b"\0");
	h.update(version.as_bytes());
	for p in parts {
		match p {
			Part::Text(t) => {
				h.update(b"\0t");
				h.update(t.as_bytes());
			}
			Part::File(f) => {
				h.update(b"\0f");
				match std::fs::read(f) {
					Ok(b) => {
						h.update(&(b.len() as u64).to_le_bytes());
						h.update(&b);
					}
					Err(_) => {
						h.update(b"missing");
					}
				}
			}
			Part::Dir(d) | Part::Manifest(d) => {
				let bytes = matches!(p, Part::Dir(_));
				h.update(if bytes { b"\0d" } else { b"\0m" });
				for f in files_under(d) {
					let rel = f.strip_prefix(d).unwrap_or(&f).to_string_lossy().replace('\\', "/");
					h.update(rel.as_bytes());
					h.update(b"\0");
					if bytes {
						let b = std::fs::read(&f).unwrap_or_default();
						h.update(&(b.len() as u64).to_le_bytes());
						h.update(&b);
					} else if let Ok(m) = std::fs::metadata(&f) {
						h.update(&m.len().to_le_bytes());
						let t = m.modified().ok().and_then(|t| t.duration_since(std::time::UNIX_EPOCH).ok()).map_or(0, |d| d.as_nanos());
						h.update(&t.to_le_bytes());
					}
				}
			}
		}
	}
	h.finalize().to_hex().to_string()
}

/// The stage cache: `<out>/.forge/<stage>.key` (the key) and `.outputs` (the files it wrote).
struct Cache {
	dir: PathBuf,
}

impl Cache {
	fn fresh(&self, stage: &str, key: &str) -> Option<Vec<PathBuf>> {
		let k = std::fs::read_to_string(self.dir.join(format!("{stage}.key"))).ok()?;
		if k.trim() != key {
			return None;
		}
		let outs: Vec<PathBuf> = std::fs::read_to_string(self.dir.join(format!("{stage}.outputs"))).ok()?.lines().map(PathBuf::from).collect();
		outs.iter().all(|p| p.exists()).then_some(outs)
	}
	fn store(&self, stage: &str, key: &str, outputs: &[PathBuf]) -> Result<(), String> {
		std::fs::create_dir_all(&self.dir).map_err(|e| e.to_string())?;
		let list: Vec<String> = outputs.iter().map(|p| p.to_string_lossy().into_owned()).collect();
		std::fs::write(self.dir.join(format!("{stage}.outputs")), list.join("\n")).map_err(|e| e.to_string())?;
		std::fs::write(self.dir.join(format!("{stage}.key")), key).map_err(|e| e.to_string())
	}
	fn forget(&self, stage: &str) {
		let _ = std::fs::remove_file(self.dir.join(format!("{stage}.key")));
	}
}

fn symlink(target: &Path, link: &Path) -> Result<(), String> {
	if let Ok(cur) = std::fs::read_link(link) {
		if cur == target {
			return Ok(());
		}
		std::fs::remove_file(link).map_err(|e| format!("{}: {e}", link.display()))?;
	}
	if let Some(p) = link.parent() {
		std::fs::create_dir_all(p).map_err(|e| e.to_string())?;
	}
	#[cfg(unix)]
	{
		std::os::unix::fs::symlink(target, link).map_err(|e| format!("{} -> {}: {e}", link.display(), target.display()))
	}
	#[cfg(not(unix))]
	{
		Err("forge build needs symbolic links (unix)".into())
	}
}

fn copy_tree(from: &Path, to: &Path) -> Result<Vec<PathBuf>, String> {
	let mut out = Vec::new();
	for f in files_under(from) {
		let rel = f.strip_prefix(from).unwrap();
		let dest = to.join(rel);
		if let Some(p) = dest.parent() {
			std::fs::create_dir_all(p).map_err(|e| e.to_string())?;
		}
		std::fs::copy(&f, &dest).map_err(|e| format!("{} -> {}: {e}", f.display(), dest.display()))?;
		out.push(dest);
	}
	Ok(out)
}

/// The paths a build reads and writes.
pub struct Layout {
	pub out: PathBuf,
	pub data: PathBuf,
	pub world: PathBuf,
	pub walks: PathBuf,
	pub routes: PathBuf,
	pub guides: PathBuf,
	pub stage_root: PathBuf,
	pub sim: PathBuf,
	pub grid: PathBuf,
}

impl Layout {
	pub fn new(o: &BuildOpts) -> Layout {
		let out = o.out.clone();
		let grid = grid_dir(o.grid.as_deref(), &o.root);
		Layout {
			data: out.join("data/forever"),
			world: out.join("world"),
			walks: out.join("walks"),
			routes: out.join("routes"),
			guides: out.join("guides"),
			stage_root: out.join(".forge/root"),
			sim: out.join(".forge/sim"),
			grid,
			out,
		}
	}

	/// The staging root and sim dir (symbolic links; recreated every run).
	fn stage(&self, o: &BuildOpts) -> Result<(), String> {
		let r = &self.stage_root;
		symlink(&self.data, &r.join("data/forever"))?;
		for sub in ["data/sources", "data/rules.json", "data/corrections.json", "addon"] {
			symlink(&o.root.join(sub), &r.join(sub))?;
		}
		// data/local: the checkout's entries, with nav4 the grid in use (and its nav-layers).
		let local = r.join("data/local");
		if std::fs::symlink_metadata(&local).is_ok_and(|m| m.file_type().is_symlink()) {
			std::fs::remove_file(&local).map_err(|e| format!("{}: {e}", local.display()))?;
		}
		std::fs::create_dir_all(&local).map_err(|e| format!("{}: {e}", local.display()))?;
		if let Ok(rd) = std::fs::read_dir(o.root.join("data/local")) {
			for e in rd.flatten() {
				let name = e.file_name();
				if name != "nav4" && name != "nav-layers" {
					symlink(&e.path(), &local.join(&name))?;
				}
			}
		}
		symlink(&self.grid, &local.join("nav4"))?;
		let layers = self.grid.parent().map(|p| p.join("nav-layers")).filter(|p| p.is_dir()).unwrap_or_else(|| o.root.join("data/local/nav-layers"));
		symlink(&layers, &local.join("nav-layers"))?;
		symlink(&o.guides, &r.join("guides"))?;
		for f in [Faction::Horde, Faction::Alliance] {
			symlink(&self.world.join(format!("world-{}.json", f.lower())), &self.sim.join(format!("world-{}.json", f.lower())))?;
			symlink(&self.walks.join(format!("walks-{}.bin", f.lower())), &self.sim.join(format!("walks-{}.bin", f.lower())))?;
		}
		symlink(&o.root.join("data/sim/params.json"), &self.sim.join("params.json"))?;
		Ok(())
	}
}

fn factions(o: &BuildOpts) -> Vec<Faction> {
	let mut v: Vec<Faction> = Vec::new();
	for s in &o.starts {
		if !v.contains(&s.faction) {
			v.push(s.faction);
		}
	}
	v
}

/// Run one stage: skip it when its key and outputs are in place, else `f` (its outputs), then
/// record the key.
fn stage(cache: &Cache, name: &'static str, key: String, log: &mut dyn FnMut(&str), f: impl FnOnce(&mut dyn FnMut(&str)) -> Result<Vec<PathBuf>, String>) -> Result<StageRun, String> {
	let t0 = Instant::now();
	if let Some(outputs) = cache.fresh(name, &key) {
		log(&format!("{name}: unchanged ({}), skipped", &key[..12]));
		return Ok(StageRun { stage: name, key, skipped: true, seconds: 0.0, outputs });
	}
	cache.forget(name);
	log(&format!("{name}: building ({})", &key[..12]));
	let outputs = f(log)?;
	cache.store(name, &key, &outputs)?;
	let seconds = t0.elapsed().as_secs_f64();
	log(&format!("{name}: done in {seconds:.1} s, {} files", outputs.len()));
	Ok(StageRun { stage: name, key, skipped: false, seconds, outputs })
}

/// v1's goal stream of a start (judge walk.js's chain goals over the input guides), as the
/// `{"goals": [...]}` document the routes stage reads.
pub fn v1_goals(guides: &Path, data_dir: &Path, faction: Faction, race: &str) -> Result<Value, String> {
	use forge_judge::walk::{chain_goals, resolve_chain, Chain, Ctx};
	let data = forge_guide::data::load_data(data_dir)?;
	let compiled = forge_guide::project::compile_project(guides, &forge_guide::js::V::Undef, &data, forge_guide::diag::Diagnostics::new(), false, None).guides;
	let frames = forge_core::frames::MapFrames::from_json(&std::fs::read(data_dir.join("map-frames.json")).map_err(|e| format!("map-frames.json: {e}"))?).map_err(|e| e.to_string())?;
	let proj = forge_core::Projector::new(&frames);
	let ctx = Ctx::new(faction.name(), race, None)?;
	let chain = resolve_chain(&compiled, Chain::Routes, &ctx)?;
	// Goal files relative to the guides folder's parent ("guides/forever/..."), as v1chain.js.
	let base = guides.parent().unwrap_or(guides).to_path_buf();
	let file_of = |g: &forge_guide::js::V| {
		let f = PathBuf::from(g.hidden("_ast").get("file").to_js_string());
		let f = if f.is_absolute() { f } else { std::env::current_dir().unwrap_or_default().join(f) };
		f.strip_prefix(&base).map(|p| p.to_string_lossy().into_owned()).unwrap_or_else(|_| f.to_string_lossy().into_owned())
	};
	let (goals, _) = chain_goals(&compiled, &file_of, &chain, &ctx, &proj, true)?;
	let goals: Vec<Value> = goals
        .iter()
        .map(|g| json!({ "i": g.i, "guide": g.guide, "file": g.file, "line": g.line, "t": g.t, "q": g.q, "oi": g.oi, "level": g.level, "npc": g.npc, "map": g.map, "w": g.w.map(|w| json!({ "c": w.c, "wx": w.wx, "wy": w.wy })), "title": g.title }))
        .collect();
	Ok(json!({ "faction": faction.name(), "race": race, "goals": goals }))
}

/// Leffe's navigation maps: `explicit` (--leffe), else `$POLESTAR_LEFFE_NAV`, else the data pack's
/// `leffe-nav`; the first of them that holds his `Nav.xml` (at its top or under `Nav/`).
pub fn find_leffe(explicit: Option<&Path>, pack_dir: Option<&Path>) -> Option<PathBuf> {
	explicit
		.map(Path::to_path_buf)
		.or_else(|| std::env::var_os("POLESTAR_LEFFE_NAV").map(PathBuf::from))
		.or_else(|| pack_dir.map(|d| d.join("leffe-nav")))
		.filter(|p| p.join("Nav/Nav.xml").is_file() || p.join("Nav.xml").is_file())
}

/// The continents a grid is built for: `continents`, else every `c` in `<data>/map-frames.json`.
pub fn grid_continents(data: &Path, continents: Option<&[u32]>) -> Vec<u32> {
	if let Some(c) = continents {
		return c.to_vec();
	}
	let doc: Value = std::fs::read(data.join("map-frames.json")).ok().and_then(|b| serde_json::from_slice(&b).ok()).unwrap_or_default();
	let mut out: Vec<u32> = doc.as_object().into_iter().flat_map(|o| o.values()).filter_map(Value::as_object).flat_map(|m| m.values()).filter_map(|f| f["c"].as_u64()).map(|c| c as u32).collect();
	out.sort_unstable();
	out.dedup();
	out
}

/// The game's own process when it is running (`Wow.exe`, `WowClassic.exe`, ...; under Wine too):
/// it writes the archives while it plays, so reads of the client can fail or change under a build.
pub fn game_running() -> Option<String> {
	let is_game = |name: &str| {
		let n = name.rsplit(['/', '\\']).next().unwrap_or(name).to_ascii_lowercase();
		n.starts_with("wow") && n.ends_with(".exe")
	};
	#[cfg(target_os = "linux")]
	{
		for e in std::fs::read_dir("/proc").ok()?.flatten() {
			if !e.file_name().to_string_lossy().bytes().all(|b| b.is_ascii_digit()) {
				continue;
			}
			let cmd = std::fs::read(e.path().join("cmdline")).unwrap_or_default();
			let first = cmd.split(|&b| b == 0).next().map(|b| String::from_utf8_lossy(b).into_owned()).unwrap_or_default();
			let comm = std::fs::read_to_string(e.path().join("comm")).unwrap_or_default();
			for n in [first.trim(), comm.trim()] {
				if is_game(n) {
					return Some(n.rsplit(['/', '\\']).next().unwrap_or(n).to_string());
				}
			}
		}
		None
	}
	#[cfg(windows)]
	{
		let out = std::process::Command::new("tasklist").args(["/FO", "CSV", "/NH"]).output().ok()?;
		String::from_utf8_lossy(&out.stdout).lines().filter_map(|l| l.split(',').next()).map(|n| n.trim_matches('"').to_string()).find(|n| is_game(n))
	}
	#[cfg(not(any(target_os = "linux", windows)))]
	{
		let out = std::process::Command::new("ps").args(["-axo", "comm="]).output().ok()?;
		String::from_utf8_lossy(&out.stdout).lines().map(str::trim).find(|n| is_game(n)).map(|n| n.rsplit('/').next().unwrap_or(n).to_string())
	}
}

/// The warning `forge nav grid`, the grid stage and `forge doctor` give while the game runs.
pub fn game_running_warning() -> Option<String> {
	game_running()
		.map(|p| format!("the game is running ({p}): it writes the client's archives while it plays, so reading them can fail or change mid-build (a grid built now can differ); close the game first"))
}

/// Refuses to build a walking grid from an install that lacks files the continents use (stale
/// archive slots or files never downloaded: the grid would be silently wrong there), unless
/// `allow` (--allow-incomplete), which logs them instead.
pub fn check_install_for_grid(wow: &Path, product: &str, defs: &Path, continents: &[u32], allow: bool, log: &mut dyn FnMut(&str)) -> Result<(), String> {
	let client = forge_gamedata::Client::open(wow, product, defs)?;
	let r = forge_gamedata::completeness::check(&client, Some(continents))?;
	if r.complete() {
		return Ok(());
	}
	let lines = r.lines().join("\n  ");
	if allow {
		log(&format!("grid: the installed client is incomplete (--allow-incomplete: building anyway; the grid is wrong where files are missing):\n  {lines}"));
		return Ok(());
	}
	Err(format!(
		"the installed client is incomplete, so a walking grid built from it would be wrong where files are missing:\n  {lines}\n{}\n(--allow-incomplete builds anyway)",
		forge_gamedata::completeness::FIX
	))
}

/// The walking grid `forge build` uses: `explicit` (--grid), else `$POLESTAR_GRID`, else
/// `<root>/data/local/nav4`.
pub fn grid_dir(explicit: Option<&Path>, root: &Path) -> PathBuf {
	explicit.map(Path::to_path_buf).or_else(|| std::env::var_os("POLESTAR_GRID").map(PathBuf::from)).unwrap_or_else(|| root.join("data/local/nav4"))
}

/// `forge build`: every stage in order. Returns what each stage did.
pub fn build(o: &BuildOpts, log: &mut dyn FnMut(&str)) -> Result<Vec<StageRun>, String> {
	let pack_dir = o.pack.clone().or_else(fetch::default_pack_dir);
	let pack_manifest: Option<Value> = pack_dir.as_ref().and_then(|d| std::fs::read(d.join(pack::MANIFEST)).ok()).and_then(|b| serde_json::from_slice(&b).ok());
	let resolved;
	let o = if o.root.join("data/sources").is_dir() {
		o
	} else {
		let dir = pack_dir.clone().ok_or("no data/sources in the root and no data pack folder: pass --root or --pack")?;
		if pack_manifest.is_none() {
			return Err(format!("no data/sources in {} and no data pack at {}: run `forge data fetch` (or pass --root <checkout>)", o.root.display(), dir.display()));
		}
		let grid = o.grid.clone().or_else(|| std::env::var_os("POLESTAR_GRID").map(PathBuf::from));
		let client = o.wow.clone().or_else(forge_gamedata::find_install).is_some_and(|w| forge_gamedata::casc::read_build_info(&w).is_ok_and(|b| b.iter().any(|i| i.product == GRID_PRODUCT)));
		if !client && !grid.as_ref().is_some_and(|g| g.join("index.json").is_file()) {
			return Err(format!(
				"the data pack has no navigation grid (it is built from your own client) and no client with {GRID_PRODUCT} was found: pass --wow <client> or --grid <dir> (or POLESTAR_GRID)"
			));
		}
		log(&format!("no local sources in {}: using the data pack {}", o.root.display(), dir.display()));
		resolved = BuildOpts { root: dir.clone(), data_root: o.data_root.clone().or(Some(dir)), grid, ..o.clone() };
		&resolved
	};
	// With a seed in the checkout, the build reads guides/ with each generated guide replaced by its
	// seed: never its own earlier output.
	let given_guides = o.guides.clone();
	let seeded;
	let o = match generated::input_guides(&o.checkout, &o.guides, &o.out.join(".forge/input-guides"))? {
		(_, None) => o,
		(dir, Some(n)) => {
			log(&format!("guides: {} with its {n} generated guides read from the seed ({})", o.guides.display(), generated::SEED_DIR));
			seeded = BuildOpts { guides: dir, ..o.clone() };
			&seeded
		}
	};
	let mut l = Layout::new(o);
	let leffe = find_leffe(o.leffe.as_deref(), pack_dir.as_deref());
	let nav = match (&o.nav, &leffe) {
		(Some(Nav::Grid), _) | (None, None) => Nav::Grid,
		(Some(n), Some(_)) => n.clone(),
		(None, Some(_)) => Nav::Hybrid,
		(Some(n), None) => return Err(format!("--nav {n:?}: Leffe's navigation maps not found (pass --leffe <dir> or set POLESTAR_LEFFE_NAV)")),
	};
	log(&format!("walks backend: {nav:?}{}", leffe.as_ref().filter(|_| nav != Nav::Grid).map_or(String::new(), |p| format!(" (Leffe's navigation maps {})", p.display()))));
	std::fs::create_dir_all(&l.out).map_err(|e| format!("{}: {e}", l.out.display()))?;
	let cache = Cache { dir: l.out.join(".forge") };
	// grid: forge-navbuild from the installed client into <out>/grid, unless a grid was given
	// (--grid, POLESTAR_GRID). Keyed by the client's build (.build.info), the map frames, zones
	// and objects it reads (the data root's data/forever) and GRID_VERSION; an unchanged key with
	// the grid in place skips it. Without a client (or its product) the checkout's
	// data/local/nav4 is used.
	let mut grid_run = None;
	let given_grid = o.grid.is_some() || std::env::var_os("POLESTAR_GRID").is_some();
	let data_root0 = o.data_root.clone().unwrap_or_else(|| o.root.clone());
	let client = o.wow.clone().or_else(forge_gamedata::find_install).filter(|w| forge_gamedata::casc::read_build_info(w).is_ok_and(|b| b.iter().any(|i| i.product == GRID_PRODUCT)));
	match (&client, given_grid) {
		(_, true) => log(&format!("grid: given, {}", l.grid.display())),
		(None, false) => log(&format!("grid: no installed client with {GRID_PRODUCT}: using {}", l.grid.display())),
		(Some(wow), false) => {
			let grid_out = l.out.join("grid");
			let frames = data_root0.join("data/forever");
			let k_grid = key(
				"grid",
				GRID_VERSION,
				&[
					Part::Text(GRID_PRODUCT),
					Part::Text(&wow.display().to_string()),
					Part::File(&wow.join(".build.info")),
					Part::File(&frames.join("map-frames.json")),
					Part::File(&frames.join("zones.json")),
					Part::File(&frames.join("objects.json")),
				],
			);
			let threads = o.threads.clamp(1, 6);
			grid_run = Some(stage(&cache, "grid", k_grid, log, |log| {
				if let Some(w) = game_running_warning() {
					log(&format!("grid: warning: {w}"));
				}
				check_install_for_grid(wow, GRID_PRODUCT, &data_root0.join("data/sources/wowdbdefs"), &grid_continents(&frames, None), o.allow_incomplete, log)?;
				let opts = forge_navbuild::build::Opts {
					out: grid_out.clone(),
					client: forge_navbuild::build::Client::Install { wow: wow.clone(), defs: data_root0.join("data/sources/wowdbdefs") },
					product: GRID_PRODUCT.into(),
					data: frames.clone(),
					continents: None,
					force: false,
					jobs: threads,
				};
				let say = |m: &str| eprintln!("forge:   grid: {m}");
				let r = forge_navbuild::build::run(&opts, &say)?;
				for w in &r.warnings {
					log(&format!("  grid: warning: {w}"));
				}
				log(&format!("  grid: {GRID_PRODUCT} {} built, content hash {}", r.build, pack::grid_hash(&grid_out)?));
				Ok(files_under(&grid_out))
			})?);
			l.grid = grid_out;
		}
	}
	l.stage(o)?;
	let fs = factions(o);
	let mut runs = Vec::new();
	runs.extend(grid_run);

	// data: forge-data from the client (or the cached wago tables), or an imported data/forever.
	let data_root = o.data_root.clone().unwrap_or_else(|| o.root.clone());
	let k_data = match &o.data {
		Some(d) => key("data", DATA_VERSION, &[Part::Text("import"), Part::Dir(d)]),
		None => {
			let wow = o.wow.clone().or_else(forge_gamedata::find_install);
			let wow_text = wow.as_ref().map_or("wago".to_string(), |w| w.display().to_string());
			let build_info = wow.as_ref().map(|w| w.join(".build.info")).unwrap_or_default();
			let questie_text = forge_data::questie::detect_questie().map_or("no questie".to_string(), |q| q.display().to_string());
			let corrections = forge_data::corrections::locate(&o.checkout);
			key(
				"data",
				DATA_VERSION,
				&[
					Part::Text("build"),
					Part::Text(&wow_text),
					Part::Text(&questie_text),
					Part::File(&build_info),
					if corrections.is_dir() { Part::Dir(&corrections) } else { Part::File(&corrections) },
					Part::File(&data_root.join("data/crossings.json")),
					Part::Manifest(&data_root.join("data/sources")),
					Part::Manifest(&data_root.join("data/recordings")),
					Part::Manifest(&data_root.join("data/forever")),
					Part::Manifest(&l.grid),
					Part::Dir(&o.guides),
				],
			)
		}
	};
	let corrections_ledger = cache.dir.join("corrections.json");
	runs.push(stage(&cache, "data", k_data.clone(), log, |log| match &o.data {
		Some(d) => {
			let _ = std::fs::remove_file(&corrections_ledger);
			copy_tree(d, &l.data)
		}
		None => {
			let mut opts = forge_data::Options::new(&data_root);
			opts.corrections = forge_data::corrections::locate(&o.checkout);
			opts.questie = forge_data::questie::detect_questie();
			match &opts.questie {
				Some(q) => log(&format!("  data: QuestieDB from your client: {}", q.display())),
				None => log("  data: QuestieDB not found (no installed Forever client with it): building without it, so fewer quest facts"),
			}
			let defs = opts.sources.join("wowdbdefs");
			let wow = o.wow.clone().or_else(forge_gamedata::find_install);
			opts.forever_source = match wow {
				Some(w) if defs.join("definitions").is_dir() => forge_data::tables::Source::Client { wow: w, product: "wow_classic_beta".into(), defs },
				_ => forge_data::tables::Source::Wago,
			};
			log(&format!(
				"  data: Forever tables from {}",
				match &opts.forever_source {
					forge_data::tables::Source::Client { wow, .. } => format!("the client {}", wow.display()),
					_ => "the cached wago tables".to_string(),
				}
			));
			let say = |m: &str| eprintln!("forge:   data: {m}");
			let out = forge_data::run(&opts, &say)?;
			let _ = std::fs::remove_dir_all(&l.data);
			forge_data::write(&l.data, &out)?;
			let rows: Vec<Value> = out.corrections.iter().map(|e| json!({ "section": e.section, "id": e.id, "state": e.state, "detail": e.detail })).collect();
			std::fs::write(&corrections_ledger, serde_json::to_string(&rows).map_err(|e| e.to_string())?).map_err(|e| format!("{}: {e}", corrections_ledger.display()))?;
			log(&format!("  data: {}", out.summary));
			// travel.json, trainers.json, professions.json: forge-data's builders over the
			// data just written (only the data files; the addon's Lua is not touched).
			let mut topts = forge_data::travel::Options::new(&data_root);
			topts.data_dir = l.data.clone();
			topts.grid_dir = Some(l.grid.clone());
			let travel = forge_data::travel::build(&topts)?;
			std::fs::write(l.data.join("travel.json"), &travel.travel_json).map_err(|e| format!("travel.json: {e}"))?;
			let (trainers, _, _) = forge_data::trainers::run(&l.data, Some(&o.guides), &data_root.join("data/recordings"))?;
			std::fs::write(l.data.join("trainers.json"), trainers).map_err(|e| format!("trainers.json: {e}"))?;
			let popts = forge_data::professions::Options { data: l.data.clone(), sources: data_root.join("data/sources"), build: None };
			forge_data::professions::write(&l.data, &forge_data::professions::build(&popts)?)?;
			log("  data: travel.json, trainers.json, professions.json built");
			// The files forge does not build (dungeons.json, gear/, codex/): carried from the data
			// root's data/forever when it has them, and named.
			let carry = data_root.join("data/forever");
			let mut carried = Vec::new();
			for e in std::fs::read_dir(&carry).into_iter().flatten().flatten() {
				let name = e.file_name();
				let dest = l.data.join(&name);
				if dest.exists() {
					continue;
				}
				let src = e.path();
				if src.is_dir() {
					copy_tree(&src, &dest)?;
				} else {
					std::fs::copy(&src, &dest).map_err(|e| format!("{}: {e}", src.display()))?;
				}
				carried.push(name.to_string_lossy().into_owned());
			}
			if !carried.is_empty() {
				carried.sort();
				log(&format!("  data: not built by forge, carried from {}: {}", carry.display(), carried.join(", ")));
			}
			Ok(files_under(&l.data))
		}
	})?);

	// prepare: the road masks, walk graphs (one per faction) and zone mixes the walks stage routes on,
	// built where missing into the grid's walk/ (forge-nav prepare; `forge nav prepare`). Keyed by the
	// grid's graphs and tiles, the roads and hubs layers and the zones (AreaTable, zones.json).
	let layers = l.grid.parent().map(|p| p.join("nav-layers")).filter(|p| p.is_dir()).unwrap_or_else(|| o.root.join("data/local/nav-layers"));
	let area_build = forge_world::data::forever_build(&forge_world::data::DirSource::repo(&l.stage_root)).ok_or("no cached Forever AreaTable in data/sources/wago")?;
	let area_table = l.stage_root.join(format!("data/sources/wago/{area_build}/AreaTable.csv"));
	let zones_json = l.data.join("zones.json");
	let k_prepare = key(
		"prepare",
		PREPARE_VERSION,
		&[
			Part::File(&l.grid.join("index.json")),
			Part::File(&l.grid.join("lifts.json")),
			Part::Manifest(&l.grid.join("graph")),
			Part::Manifest(&l.grid.join("tiles")),
			Part::Manifest(&layers.join("roads")),
			Part::File(&layers.join("hubs.json")),
			Part::File(&area_table),
			Part::File(&zones_json),
		],
	);
	runs.push(stage(&cache, "prepare", k_prepare, log, |log| {
		let say = |m: &str| eprintln!("forge:   prepare: {m}");
		let built = forge_nav::prepare::prepare(&forge_nav::prepare::PrepareIn {
			grid: &l.grid,
			roads: &layers.join("roads"),
			hubs: &layers.join("hubs.json"),
			area_table: &area_table,
			zones: &zones_json,
			continents: None,
			threads: o.threads.max(1),
			log: &say,
		})?;
		let n = built.iter().filter(|b| b.built).count();
		log(&format!("  prepare: {n} built ({:.0} s), {} kept", built.iter().map(|b| b.seconds).sum::<f64>(), built.len() - n));
		Ok(built.into_iter().map(|b| b.file).collect())
	})?);

	// world: forge-world with the grid's floors.
	let rules = o.root.join("data/rules.json");
	let sources = o.root.join("data/sources");
	let fs_text = fs.iter().map(|f| f.lower()).collect::<Vec<_>>().join(",");
	let k_world = key("world", WORLD_VERSION, &[Part::Text(&k_data), Part::Text(&fs_text), Part::File(&rules), Part::Manifest(&sources), Part::Manifest(&l.grid)]);
	runs.push(stage(&cache, "world", k_world.clone(), log, |log| {
		std::fs::create_dir_all(&l.world).map_err(|e| e.to_string())?;
		let mut out = Vec::new();
		for &f in &fs {
			let (w, text) = forge_nav::stage::world(&l.stage_root, &l.grid, f).map_err(|e| format!("world {}: {e}", f.name()))?;
			let p = l.world.join(format!("world-{}.json", f.lower()));
			std::fs::write(&p, text).map_err(|e| format!("{}: {e}", p.display()))?;
			log(&format!("  world {}: {} points, {} quests, dataHash {}", f.name(), w.points.len(), w.quests.len(), w.data_hash.as_deref().unwrap_or("-")));
			out.push(p);
		}
		Ok(out)
	})?);

	// walks: imported, or built by forge walks on the grid (store kept beside them).
	let walk_parts_owned: Vec<PathBuf> = match &o.walks_from {
		Some(d) => fs.iter().map(|f| d.join(format!("walks-{}.bin", f.lower()))).collect(),
		None => Vec::new(),
	};
	let mut parts: Vec<Part> = vec![Part::Text(&k_world)];
	let nav_text = if o.walks_from.is_some() { "import".to_string() } else { format!("{nav:?}") };
	parts.push(Part::Text(&nav_text));
	if let (false, Some(p)) = (nav == Nav::Grid, &leffe) {
		parts.push(Part::Manifest(p));
	}
	for p in &walk_parts_owned {
		parts.push(Part::File(p));
	}
	if o.walks_from.is_none() {
		parts.push(Part::Manifest(&l.grid));
	}
	let k_walks = key("walks", WALKS_VERSION, &parts);
	runs.push(stage(&cache, "walks", k_walks.clone(), log, |log| {
		std::fs::create_dir_all(&l.walks).map_err(|e| e.to_string())?;
		let mut out = Vec::new();
		for &f in &fs {
			let dest = l.walks.join(format!("walks-{}.bin", f.lower()));
			match &o.walks_from {
				Some(d) => {
					std::fs::copy(d.join(format!("walks-{}.bin", f.lower())), &dest).map_err(|e| format!("walks {}: {e}", f.name()))?;
				}
				None => {
					let world_json = std::fs::read(l.world.join(format!("world-{}.json", f.lower()))).map_err(|e| e.to_string())?;
					let pack: Value = serde_json::from_slice(&std::fs::read(o.root.join("addon/Polestar_Nav/PACK.json")).map_err(|e| format!("PACK.json: {e}"))?).map_err(|e| e.to_string())?;
					let maps: Vec<i64> = pack["maps"].as_array().map(|a| a.iter().filter_map(Value::as_i64).collect()).unwrap_or_else(|| vec![0, 1]);
					let build = forge_world::data::forever_build(&forge_world::data::DirSource::repo(&l.stage_root)).ok_or("no cached Forever AreaTable in data/sources/wago")?;
					let area_table = l.stage_root.join(format!("data/sources/wago/{build}/AreaTable.csv"));
					let store = l.walks.join(format!("store-{}.psbn", f.lower()));
					let fp_file = l.walks.join(format!("store-{}.navfp", f.lower()));
					let leffe_store = l.walks.join(format!("store-leffe-{}.psbn", f.lower()));
					if let (Some(dir), Some(m)) = (&pack_dir, &pack_manifest) {
						if !store.exists() {
							seed_store(dir, m, &l.grid, &format!("store-{}.psbn", f.lower()), &store, Some(&fp_file), log)?;
						}
						if nav != Nav::Grid && !leffe_store.exists() {
							// Leffe's stores also need his maps to be the ones they were built on.
							let same_maps = leffe.as_deref().map(pack::leffe_hash).transpose()?.is_some_and(|h| m["walks"]["leffe"].as_str() == Some(h.as_str()));
							if same_maps {
								seed_store(dir, m, &l.grid, &format!("store-leffe-{}.psbn", f.lower()), &leffe_store, None, log)?;
							} else {
								log("  walks: the data pack's Leffe walk stores were built on other Leffe maps: routing them again");
							}
						}
					}
					let backend = match (&nav, &leffe) {
						(Nav::Leffe, Some(p)) => forge_nav::stage::Nav::Leffe { pack: p.clone(), cache_mb: LEFFE_CACHE_MB },
						(Nav::Hybrid, Some(p)) => forge_nav::stage::Nav::Hybrid { pack: p.clone(), cache_mb: LEFFE_CACHE_MB, leffe_store: leffe_store.clone() },
						_ => forge_nav::stage::Nav::Grid,
					};
					let store = if nav == Nav::Leffe { leffe_store.clone() } else { store };
					let nav_fp =
						std::env::var("POLESTAR_NAV_FP").ok().or_else(|| std::fs::read_to_string(&fp_file).ok().map(|s| s.trim().to_string())).unwrap_or_else(|| format!("forge-{WALKS_VERSION}"));
					let say = |m: &str| eprintln!("forge:   walks {}: {m}", f.name());
					let w = forge_nav::stage::walks(&forge_nav::stage::WalksIn {
						world_json: &world_json,
						grid: &l.grid,
						maps: &maps,
						area_table: &area_table,
						zones: &l.data.join("zones.json"),
						store: &store,
						nav_fp: &nav_fp,
						bands: &[0, 10, 20, 30, 40, 50],
						threads: o.threads,
						nav: backend,
						log: &say,
					})?;
					std::fs::write(&dest, &w.bin).map_err(|e| format!("{}: {e}", dest.display()))?;
					log(&format!("  walks {}: {}", f.name(), w.stats));
				}
			}
			out.push(dest);
		}
		Ok(out)
	})?);

	if o.until.as_deref() == Some("walks") {
		log("stopping after walks (--until walks)");
		return Ok(runs);
	}

	// routes: v1's chain per start (compiled from the input guides) improved by forge-sim; a
	// faction with more than one start gets its shared route (forge_sim::stage::shared_faction:
	// each start's own cut to its join, one tail for all, written per start).
	let kb = forge_sim::stage::kb_path(&o.root);
	let params = o.root.join("data/sim/params.json");
	let starts_text = o.starts.iter().map(|s| s.name.clone()).collect::<Vec<_>>().join(",");
	let fixes = forge_sim::fixes::find(&[&o.checkout]).ok_or_else(|| format!("no {} in the checkout {}", forge_sim::fixes::FILE, o.checkout.display()))?;
	forge_sim::fixes::load(&fixes)?;
	log(&format!("route fixes: {}", fixes.display()));
	let sim_text = env!("CARGO_PKG_VERSION");
	let k_routes = key(
		"routes",
		ROUTES_VERSION,
		&[
			Part::Text(&k_data),
			Part::Text(&k_world),
			Part::Text(&k_walks),
			Part::Text(&starts_text),
			Part::Text(sim_text),
			Part::File(&fixes),
			Part::Dir(&o.guides),
			Part::File(&kb),
			Part::File(&params),
			Part::Manifest(&sources),
		],
	);
	runs.push(stage(&cache, "routes", k_routes.clone(), log, |log| {
		let mut starts = Vec::new();
		for s in &o.starts {
			let goals = v1_goals(&o.guides, &l.data, s.faction, &s.race)?;
			log(&format!("  the guides' order for {}: {} goals", s.name, goals["goals"].as_array().map_or(0, Vec::len)));
			starts.push(forge_sim::stage::StartIn { race: s.race.clone(), faction: s.faction, name: s.name.clone(), goals, seed_name: format!("v1 chain of {}", o.guides.display()) });
		}
		let r = forge_sim::stage::run(&forge_sim::stage::RoutesIn { root: &l.stage_root, world_dir: &l.sim, starts, out: &l.routes })?;
		for row in &r.rows {
			let shared = &row["shared"];
			log(&format!(
				"  route {}: the guides {:.2} h -> {:.2} h (to 30: {:.2} -> {:.2}){}, {} edits, {} skipped ({} missing info)",
				row["start"].as_str().unwrap_or(""),
				row["v1"]["hours60"].as_f64().unwrap_or(0.0),
				row["improved"]["hours60"].as_f64().unwrap_or(0.0),
				row["v1"]["hours30"].as_f64().unwrap_or(0.0),
				row["improved"]["hours30"].as_f64().unwrap_or(0.0),
				if shared.is_null() {
					String::new()
				} else {
					format!(", shared with {} from step {} (own cut {:.2} h)", shared["canonical"].as_str().unwrap_or(""), shared["joinStep"], shared["own"]["hours60"].as_f64().unwrap_or(0.0))
				},
				row["edits"],
				row["skips"],
				row["missingInfo"]
			));
		}
		let table = std::path::Path::new(&l.routes).join("starts.json");
		std::fs::write(&table, serde_json::to_string_pretty(&r.rows).map_err(|e| e.to_string())?).map_err(|e| format!("{}: {e}", table.display()))?;
		let mut files = r.files;
		files.push(table);
		Ok(files)
	})?);

	// guides: forge writer apply-route per start.
	let (places_file, guide_fixes_file) = (o.checkout.join(forge_writer::native::PLACES), o.checkout.join(forge_writer::native::GUIDE_FIXES));
	let k_guides = key("guides", GUIDES_VERSION, &[Part::Text(&k_routes), Part::Dir(&o.guides), Part::Text(&k_data), Part::File(&places_file), Part::File(&guide_fixes_file)]);
	runs.push(stage(&cache, "guides", k_guides.clone(), log, |log| {
		let mut out = Vec::new();
		for s in &o.starts {
			let dest = l.guides.join(&s.name);
			let r = forge_writer::native::run_paths(
				&forge_writer::native::PathInputs {
					route: l.routes.join(format!("{}.json", s.name)),
					world: l.sim.join(format!("world-{}.json", s.faction.lower())),
					walks: Some(l.sim.join(format!("walks-{}.bin", s.faction.lower()))),
					guides: o.guides.clone(),
					root: l.stage_root.clone(),
					data_dir: Some(l.data.clone()),
					out: dest.clone(),
					checkout: Some(o.checkout.clone()),
				},
				&forge_writer::RunOpts::default(),
			)
			.map_err(|e| format!("guides {}: {e}", s.name))?;
			log(&format!("  guides {}: {} files changed", s.name, r.changed.len()));
			// The fix pass's rows for this start: the ledger reads them.
			let rows = l.guides.join(format!("{}.fixes.json", s.name));
			std::fs::write(&rows, serde_json::to_string_pretty(&r.fixes).map_err(|e| e.to_string())?).map_err(|e| format!("{}: {e}", rows.display()))?;
			out.push(dest);
			out.push(rows);
		}
		Ok(out)
	})?);

	// legs: the walk into every step of the written guides, baked on the hybrid backend (Leffe's
	// maps first, the grid where his have no way or a detour), one legs.json per start's tree.
	let chokepoints = o.root.join("addon/Polestar_Nav/Nav/Chokepoints.lua");
	let mut legs_parts = vec![Part::Text(&k_guides), Part::Text(&k_data), Part::Manifest(&l.grid), Part::File(&chokepoints)];
	let leffe_for_legs = leffe.as_deref().filter(|_| nav != Nav::Grid);
	if let Some(p) = leffe_for_legs {
		legs_parts.push(Part::Manifest(p));
	}
	let k_legs = key("legs", LEGS_VERSION, &legs_parts);
	runs.push(stage(&cache, "legs", k_legs, log, |log| {
		let trees: Vec<PathBuf> = o.starts.iter().map(|s| l.guides.join(&s.name)).collect();
		let say = |m: &str| eprintln!("forge:   {m}");
		let r = bake::bake_trees(&bake::BakeIn {
			trees: &trees,
			data: &l.data,
			grid: &l.grid,
			leffe: leffe_for_legs,
			area_table: &area_table,
			zones: &zones_json,
			chokepoints: &chokepoints,
			threads: o.threads,
			log: &say,
		})?;
		log(&format!("  legs: {}", r.stats));
		Ok(r.files)
	})?);

	// report: forge judge report over every start.
	let k_report = key("report", REPORT_VERSION, &[Part::Text(&k_guides), Part::Text(&k_routes)]);
	runs.push(stage(&cache, "report", k_report, log, |_| {
		use forge_judge::report;
		let starts = o
			.starts
			.iter()
			.map(|s| report::StartInput { route: l.routes.join(format!("{}.json", s.name)), stream: Some(l.routes.join(format!("{}.judge-improved.json", s.name))), guides: l.guides.join(&s.name) })
			.collect();
		let r = report::run(&report::Inputs { starts, v1: o.guides.clone(), root: l.stage_root.clone(), data_dir: l.data.clone(), sim_dir: l.sim.clone(), along_walked: false, checks: true })?;
		let md = l.out.join("report.md");
		let js = l.out.join("report.json");
		std::fs::write(&md, format!("{}\n{}\n", report::markdown(&r).trim_end(), data_sources_note(&l.data))).map_err(|e| e.to_string())?;
		std::fs::write(&js, serde_json::to_string_pretty(&r).map_err(|e| e.to_string())?).map_err(|e| e.to_string())?;
		Ok(vec![md, js])
	})?);

	// The fixes ledger: every run (cheap), so it names the inputs of this run.
	let ledger = ledger::run(&ledger::Inputs {
		checkout: &o.checkout,
		guides: &given_guides,
		root: &o.root,
		data_root: o.data_root.as_deref(),
		route_fixes: &fixes,
		data_dir: &l.data,
		routes_dir: &l.routes,
		written: &l.guides,
		corrections: o.data.is_none().then_some(corrections_ledger.as_path()),
		starts: o.starts.iter().map(|s| s.name.clone()).collect(),
		report_json: &l.out.join("report.json"),
	});
	ledger::write(&ledger, &l.out)?;
	for w in &ledger.warnings {
		log(&format!("fixes: warning: {w}"));
	}
	let blocking = ledger.blocking();
	log(&format!("fixes: {} ({} no longer apply); fixes.md", ledger.counts().iter().map(|(k, v)| format!("{v} {k}")).collect::<Vec<_>>().join(", "), blocking.len()));
	if o.strict && !blocking.is_empty() {
		for (f, r) in blocking.iter().take(20) {
			log(&format!("  {f} {}: {} {}", r.at, r.state, r.detail));
		}
		return Err(format!("--strict: {} fix(es) no longer apply (fixes.md lists them)", blocking.len()));
	}
	Ok(runs)
}

/// Seed `<out>/walks/store-<faction>.psbn` from the data pack when the grid in use has the
/// content hash the pack's stores were built on (else the walks are routed again), with the walk
/// model fingerprint they were built with.
fn seed_store(dir: &Path, m: &Value, grid: &Path, name: &str, store: &Path, fp_file: Option<&Path>, log: &mut dyn FnMut(&str)) -> Result<(), String> {
	let src = dir.join("walks").join(name);
	let Some(want) = m["walks"]["grid"].as_str() else { return Ok(()) };
	if !src.is_file() {
		return Ok(());
	}
	let have = pack::grid_hash(grid)?;
	if have != want {
		log(&format!("  walks: the data pack's {name} was built on another grid ({} vs yours {}): routing the walks again", &want[..12], &have[..12]));
		return Ok(());
	}
	std::fs::copy(&src, store).map_err(|e| format!("{} -> {}: {e}", src.display(), store.display()))?;
	if let (Some(fp), Some(file)) = (m["walks"]["navFp"].as_str(), fp_file) {
		std::fs::write(file, fp).map_err(|e| e.to_string())?;
	}
	log(&format!("  walks: {name} seeded from the data pack (grid {})", &want[..12]));
	Ok(())
}

/// The report's line on the data the build ran on: data/forever meta.json's sources, and whether
/// QuestieDB was found (a build without it has fewer quest facts).
pub fn data_sources_note(data: &Path) -> String {
	let meta: Value = std::fs::read(data.join("meta.json")).ok().and_then(|b| serde_json::from_slice(&b).ok()).unwrap_or_default();
	let names: Vec<String> = meta["sources"].as_array().into_iter().flatten().filter_map(|s| s["name"].as_str().map(String::from)).collect();
	let questie = names.iter().any(|n| n.to_lowercase().contains("questie"));
	format!(
		"Data sources: {}. {}",
		if names.is_empty() { "not recorded".to_string() } else { names.join(", ") },
		if questie { "QuestieDB: found in the client and used." } else { "QuestieDB: not found (no installed Forever client with it); the data was built without it, so it has fewer quest facts." }
	)
}
