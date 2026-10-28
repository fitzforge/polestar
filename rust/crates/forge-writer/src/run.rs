//! The guides stage of `forge build`: `run(inputs) -> outputs`. The route written into v1's guides
//! (apply.rs), the travel check or repair (travel.rs), the engine rules (engine.rs). No file system:
//! the CLI (src/bin/forge_writer.rs) reads the inputs and writes `<out>/guides/`.

use crate::apply::{apply_route, Inputs};
use crate::engine::{self, WalkYards};
use crate::input::{Data, OrderT, Route, World};
use crate::travel;
use forge_core::frames::MapFrames;
use forge_world::atlas::SubzoneOf;
use rustc_hash::FxHashMap;
use std::collections::BTreeMap;

pub struct RunInputs<'a> {
	pub route: &'a Route,
	/// The guides folder's files by relative path.
	pub guides: &'a BTreeMap<String, String>,
	pub world: &'a World,
	pub data: &'a Data,
	/// The compiler's reference data (the travel check, the engine rules).
	pub gdata: &'a forge_guide::data::Data,
	pub frames: &'a MapFrames,
	pub area_at: Option<&'a dyn SubzoneOf>,
	/// The walk store by world point ids.
	pub walks: Option<&'a dyn forge_sim::walks::Walks>,
	/// The walk store by world position (snapped to the world's points).
	pub walk_yards: Option<&'a dyn WalkYards>,
	pub mechanics: Option<&'a serde_json::Value>,
	pub steps: Option<&'a serde_json::Value>,
	pub spells: Option<&'a FxHashMap<String, u32>>,
	/// The walking grid's floors (R9 where-notes), when the grid is there.
	pub floors: Option<&'a dyn crate::tips::Floors>,
	/// Spawn heights beyond spawnz.json: the Forever server data's spawns ({ npc, object } -> id ->
	/// [[map, x, y, z, ...]]), when there.
	pub heights: Option<&'a forge_guide::js::V>,
	/// data/local/mechanics/quest-notes.json (`quests`), for R10's warnings.
	pub notes: Option<&'a serde_json::Value>,
	/// The checkout's places and guide fixes, applied to the written guides last (fixes.rs).
	pub records: crate::fixes::Records<'a>,
}

#[derive(Clone, Debug)]
pub struct RunOpts {
	/// The engine's features and the route's own legs (off: the JS writer's output).
	pub engine: bool,
	pub level: bool,
	pub route_legs: bool,
	/// The JS writer's honest-R1 travel repair after writing (special cases): only without the
	/// route's own legs, which write the travel themselves.
	pub repair: bool,
	pub rules: engine::Opts,
}

impl Default for RunOpts {
	fn default() -> Self {
		RunOpts { engine: true, level: true, route_legs: true, repair: true, rules: engine::Opts::default() }
	}
}

pub struct RunOutput {
	/// Every guide of the folder, the chain's rewritten.
	pub tree: BTreeMap<String, String>,
	/// The files that differ from the input guides.
	pub changed: Vec<String>,
	pub log: Vec<String>,
	/// R1 failures on the route's chain v1 does not have, and all of them.
	pub travel_check: Option<(usize, usize)>,
	pub engine: Option<engine::Report>,
	/// Every place and guide fix, and what the fix pass did with it.
	pub fixes: Vec<crate::fixes::FixRow>,
	pub summary: String,
}

pub fn run(inp: &RunInputs, opts: &RunOpts) -> Result<RunOutput, String> {
	let mut log = Vec::new();
	if let (Some(r), Some(w)) = (&inp.route.data_hash, &inp.world.data_hash) {
		if r != w {
			return Err(format!("the route was cut on another world (dataHash {r}) than the one given ({w}): its points are that world's"));
		}
	}
	let ai = Inputs {
		route: inp.route,
		guides: inp.guides,
		world: inp.world,
		data: inp.data,
		frames: inp.frames,
		area_at: inp.area_at,
		level_fraction: opts.engine && opts.level,
		route_travel: opts.engine && opts.route_legs,
		walks: if opts.engine { inp.walks } else { None },
	};
	let r = apply_route(&ai)?;
	log.extend(r.log.iter().cloned());
	let mut tree = inp.guides.clone();
	for (rel, text) in &r.files {
		tree.insert(rel.clone(), text.clone());
	}
	// (With the route's own legs too: a written line the player cannot travel to as written, R1 — a
	// flight from where no flight master is, a zone or continent change with no travel line — gets the
	// repair's way, on the lines v1 does not have the failure on.)
	if opts.repair {
		let rep = travel::repair_travel(&mut tree, inp.guides, &r.travel, inp.gdata, inp.walk_yards);
		log.extend(rep.log);
		log.extend(rep.left.iter().map(|(f, l, why)| format!("apply-route: travel left: {f}:{l} {why}")));
	}
	// The fix records, on the guides the route was written into (after the travel repair, before the
	// engine: its rules read the steps as the player will get them).
	let written: Vec<String> = r.files.iter().map(|(f, _)| f.clone()).collect();
	let quests: std::collections::HashSet<u32> = inp.route.order.iter().filter_map(|o| o.q).collect();
	let fixes = crate::fixes::apply(&mut tree, &written, &quests, inp.route.faction.as_deref(), inp.records, Some(inp.data));
	for f in fixes.iter().filter(|f| f.state != "applied" && f.state != "redundant" && f.state != "not for this start") {
		log.push(format!("fixes: {} {}: {} ({})", f.file, f.id, f.state, f.detail));
	}
	let mut eng = None;
	let mut check = None;
	if opts.engine {
		let accept_lvl: FxHashMap<u32, f64> = inp.route.order.iter().filter(|o| o.t == OrderT::Accept).filter_map(|o| Some((o.q?, o.lvl?))).collect();
		let no_along = crate::fixes::no_along(&inp.records, inp.route.faction.as_deref());
		let einp = engine::Inputs {
			data: inp.gdata,
			mechanics: inp.mechanics,
			steps: inp.steps,
			spells: inp.spells,
			walks: inp.walk_yards,
			accept_lvl: &accept_lvl,
			no_along: &no_along,
			floors: inp.floors,
			area_at: inp.area_at,
			heights: inp.heights,
			notes: inp.notes,
		};
		let er = engine::engine_pass(&mut tree, &r.travel, &einp, &opts.rules);
		log.extend(er.log.iter().cloned());
		log.push(format!(
			"engine: {} (walking yards: {} passes confirmed, {} refuted, {} by the straight line)",
			er.counts.iter().map(|(k, v)| format!("{k} {v}")).collect::<Vec<_>>().join(", "),
			er.walk_confirmed,
			er.walk_refuted,
			er.walk_unknown
		));
		eng = Some(er);
		let (n, all, list) = travel::r1_check(&tree, inp.guides, &r.travel, inp.gdata);
		log.extend(list.iter().map(|(f, l, why)| format!("travel check: {f}:{l} {why}")));
		log.push(format!("travel check: {n} R1 failures v1 does not have on the route's chain ({all} in all)"));
		check = Some((n, all));
	}
	// (Class lists name only the classes a start guide's races play, W3.)
	if let Some(fac) = inp.route.faction.as_deref() {
		let playable = |race: &str| -> Vec<String> {
			let file = forge_core::RACES.iter().find(|r| r.key.eq_ignore_ascii_case(race) || r.file.eq_ignore_ascii_case(race) || (race == "Undead" && r.file == "Scourge")).map_or(race, |r| r.file);
			forge_judge::honest::playable_classes(inp.gdata, file, fac).iter().map(|c| forge_core::class_label(c)).collect()
		};
		for rel in &written {
			if let Some(t) = tree.get(rel).and_then(|t| crate::post::playable_only(t, &playable)) {
				tree.insert(rel.clone(), t);
			}
		}
	}
	let changed: Vec<String> = tree.iter().filter(|(k, v)| inp.guides.get(*k) != Some(*v)).map(|(k, _)| k.clone()).collect();
	let unwritable =
		if r.unwritable.is_empty() { String::new() } else { format!(" ({} not written: no source for their items)", r.unwritable.iter().map(u32::to_string).collect::<Vec<_>>().join(", ")) };
	let summary = format!(
		"{} guides rewritten; {} quests added{unwritable}, {} dropped, {} goals moved between guides, {} route lines not placed",
		r.files.len(),
		r.added.len(),
		r.dropped.len(),
		r.moved,
		r.unplaced
	);
	Ok(RunOutput { tree, changed, log, travel_check: check, engine: eng, fixes, summary })
}
