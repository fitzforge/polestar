//! Baked guide legs for written guide trees (`forge build`'s legs stage, `forge guide bake`): the
//! walk into each step of every leveling guide, routed on the hybrid backend and packed by
//! forge_nav::bake, written beside the guides as `legs.json` (schema 1: `grid`, the maps the legs
//! were routed on; `legs`, per guide id its leg ends' hash and one string per step) and
//! `legs-qa.txt` (the legs not baked, and why). The compiler puts a guide's legs into the race
//! parts (forge_guide::project::read_legs_text) while its leg ends still hash the same.
//!
//! A leg runs from the last located goal before a step to the step's first located goal, on one
//! continent (forge_guide::bake::step_targets), with each goal's spawn height when it has one.
//! Legs are routed once per faction and ends (a yard), however many trees and guides share them:
//! the starts of one faction share their route after their start zones.

use forge_guide::js::V;
use forge_nav::bake::{Backend, Baked, Baker, End};
use forge_nav::cost::Profile;
use rayon::prelude::*;
use rustc_hash::FxHashMap;
use serde_json::{json, Map, Value};
use std::path::{Path, PathBuf};
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;

pub const LEGS_FILE: &str = "legs.json";
pub const QA_FILE: &str = "legs-qa.txt";

pub struct BakeIn<'a> {
	/// The written guide trees (each a pack folder: pack.json, forever/...).
	pub trees: &'a [PathBuf],
	/// data/forever the trees compile against.
	pub data: &'a Path,
	/// The walking grid (prepared: walk/ graphs and mixes).
	pub grid: &'a Path,
	/// Leffe's navigation maps (a Nav folder, or one holding Nav/); None: the grid alone.
	pub leffe: Option<&'a Path>,
	/// The cached Forever AreaTable.csv and data/forever/zones.json (the grid's zone pricing).
	pub area_table: &'a Path,
	pub zones: &'a Path,
	/// Polestar_Nav's Nav/Chokepoints.lua (the named passages a long way may take).
	pub chokepoints: &'a Path,
	pub threads: usize,
	pub log: &'a (dyn Fn(&str) + Sync),
}

/// What a bake did: per tree its legs.json and legs-qa.txt, and the totals.
pub struct BakeOut {
	pub files: Vec<PathBuf>,
	pub stats: Value,
}

/// The faction a guide is walked as (its `faction` header), or None (no faction: no guide legs).
fn faction_of(g: &V) -> Option<&'static str> {
	match g.get("faction").as_str() {
		Some("Horde") => Some("Horde"),
		Some("Alliance") => Some("Alliance"),
		_ => None,
	}
}

/// A leveling guide (category Leveling or none): the guides a race part's legs are for.
fn leveling(g: &V) -> bool {
	let cat = g.get("category");
	cat.is_nullish() || cat.as_str() == Some("Leveling")
}

type LegKey = (&'static str, u32, i64, i64, i64, i64);

fn end_of(w: &forge_guide::bake::World) -> Option<End> {
	Some(End { c: w.c.as_num()? as u32, wx: w.wx, wy: w.wy, z: w.z })
}

/// The maps' identity a bake's strings are routed on (legs.json `grid`, the guides' `legsGrid`): our grid, Leffe's
/// maps and the lift layer spliced into them (its content hash).
pub fn maps_id(grid: &forge_nav::grid::Grid, leffe: Option<&Path>, lifts: Option<&str>) -> Result<String, String> {
	let mut s = format!("grid {}", forge_nav::walker::grid_id(grid));
	if let Some(p) = leffe {
		let dir = if p.join("Nav.xml").exists() { p.to_path_buf() } else { p.join("Nav") };
		let id = forge_nav::f4walks::F4Backend::pack_id(&dir).map_err(|e| format!("{}: {e}", dir.display()))?;
		s.push_str(&format!(", leffe {}", &id[..id.len().min(12)]));
		if let Some(l) = lifts {
			s.push_str(&format!(" lifts {}", &l[..l.len().min(12)]));
		}
	}
	Ok(s)
}

pub fn bake_trees(i: &BakeIn) -> Result<BakeOut, String> {
	let t0 = std::time::Instant::now();
	let mut ddiag = forge_guide::diag::Diagnostics::new();
	let data = forge_guide::project::load_project_data(i.data, &mut ddiag)?;
	// Every tree's leveling guides and their legs.
	struct Tree {
		dir: PathBuf,
		guides: Vec<(String, String, Vec<(usize, LegKey)>)>, // id, hash, (step, leg)
	}
	let mut trees = Vec::new();
	let mut legs: FxHashMap<LegKey, (End, End)> = FxHashMap::default();
	for dir in i.trees {
		let (manifest, _) = forge_guide::manifest::read_manifest(dir, true);
		let manifest = manifest.ok_or_else(|| format!("{}: no pack.json", dir.display()))?;
		let project = forge_guide::project::compile_project(dir, &manifest, &data, forge_guide::diag::Diagnostics::new(), false, None);
		let mut guides = Vec::new();
		for g in project.guides.iter().filter(|g| leveling(g)) {
			let Some(faction) = faction_of(g) else { continue };
			let mut steps = Vec::new();
			for (s, from, to) in forge_guide::bake::step_targets(g, &data.map_frames) {
				let (Some(a), Some(b)) = (end_of(&from), end_of(&to)) else { continue };
				let key = (faction, a.c, a.wx.round() as i64, a.wy.round() as i64, b.wx.round() as i64, b.wy.round() as i64);
				legs.entry(key).or_insert((a, b));
				steps.push((s, key));
			}
			guides.push((g.get("id").to_js_string(), forge_guide::bake::guide_hash(g, &data.map_frames), steps));
		}
		(i.log)(&format!("  legs: {}: {} leveling guides, {} legs", dir.display(), guides.len(), guides.iter().map(|g| g.2.len()).sum::<usize>()));
		trees.push(Tree { dir: dir.clone(), guides });
	}
	// The maps.
	let grid = Arc::new(forge_nav::grid::Grid::open(i.grid, 640)?);
	let f4 = match i.leffe {
		Some(p) => {
			let dir = if p.join("Nav.xml").exists() { p.to_path_buf() } else { p.join("Nav") };
			Some(forge_nav::f4::F4::open(&dir, crate::LEFFE_CACHE_MB)?)
		}
		None => None,
	};
	let maps = maps_id(&grid, i.leffe, f4.as_ref().and_then(|f| f.lift_layer()))?;
	let pricing: FxHashMap<&'static str, Profile> =
		["Horde", "Alliance"].into_iter().map(|f| forge_nav::stage::pricing(&grid, f, i.area_table, i.zones, Vec::new()).map(|p| (f, p.profile(&[])))).collect::<Result<_, _>>()?;
	let zones_tag = forge_nav::stage::pricing(&grid, "Horde", i.area_table, i.zones, Vec::new())?.zones.tag.clone();
	let walker = forge_nav::walker::Walker::new(grid.clone());
	let chokes = forge_nav::bake::load_chokepoints(&std::fs::read_to_string(i.chokepoints).map_err(|e| format!("{}: {e}", i.chokepoints.display()))?);
	let baker = Baker { walker: &walker, zones_tag, f4: f4.as_ref(), chokes };
	// Route every distinct leg.
	let mut todo: Vec<(LegKey, End, End)> = legs.into_iter().map(|(k, (a, b))| (k, a, b)).collect();
	todo.sort_by(|x, y| x.0.partial_cmp(&y.0).unwrap());
	let n = todo.len();
	(i.log)(&format!("  legs: {n} distinct legs to route on {maps}"));
	let done = AtomicUsize::new(0);
	let pool = rayon::ThreadPoolBuilder::new().num_threads(i.threads.max(1)).build().map_err(|e| e.to_string())?;
	let baked: FxHashMap<LegKey, Baked> = pool.install(|| {
		todo.par_iter()
			.map(|(k, a, b)| {
				let r = baker.bake(a, b, Some(k.0), &pricing[k.0]);
				let d = done.fetch_add(1, Ordering::Relaxed) + 1;
				if d.is_multiple_of(500) {
					(i.log)(&format!("  legs: {d}/{n} routed, {:.0} s", t0.elapsed().as_secs_f64()));
				}
				r.map(|r| (*k, r))
			})
			.collect::<Result<_, String>>()
	})?;
	// Per tree: legs.json and the QA list.
	let mut files = Vec::new();
	let (mut by_leffe, mut by_grid, mut qa_n, mut bytes, mut corners) = (0usize, 0usize, 0usize, 0usize, 0usize);
	for b in baked.values() {
		match b {
			Baked::Leg { string, backend, corners: c, .. } => {
				match backend {
					Backend::Leffe => by_leffe += 1,
					Backend::Grid => by_grid += 1,
				}
				bytes += string.len();
				corners += c;
			}
			Baked::Qa { .. } => qa_n += 1,
		}
	}
	for t in &trees {
		let mut doc = Map::new();
		let mut qa = String::new();
		for (id, hash, steps) in &t.guides {
			let mut st = Map::new();
			for (s, k) in steps {
				match &baked[k] {
					Baked::Leg { string, .. } => {
						st.insert(s.to_string(), json!(string));
					}
					Baked::Qa { reason } => qa.push_str(&format!("{id}\tstep {s}\t{}:{},{}>{},{}\t{reason}\n", k.1, k.2, k.3, k.4, k.5)),
				}
			}
			doc.insert(id.clone(), json!({ "hash": hash, "steps": st }));
		}
		let legs_file = t.dir.join(LEGS_FILE);
		let text = serde_json::to_string_pretty(&json!({ "schema": 1, "grid": maps, "legs": doc })).map_err(|e| e.to_string())?;
		std::fs::write(&legs_file, format!("{text}\n")).map_err(|e| format!("{}: {e}", legs_file.display()))?;
		let qa_file = t.dir.join(QA_FILE);
		std::fs::write(&qa_file, qa).map_err(|e| format!("{}: {e}", qa_file.display()))?;
		files.push(legs_file);
		files.push(qa_file);
	}
	let stats = json!({
		"maps": maps, "distinct": n, "leffe": by_leffe, "grid": by_grid, "qa": qa_n,
		"bytes": bytes, "corners": corners, "seconds": t0.elapsed().as_secs_f64(),
	});
	Ok(BakeOut { files, stats })
}
