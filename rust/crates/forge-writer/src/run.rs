//! The guides stage of `forge build`: `run(inputs) -> outputs`. The route written into v1's guides
//! (apply.rs), the travel check or repair (travel.rs), the engine rules (engine.rs). No file system:
//! the CLI (src/bin/forge_writer.rs) reads the inputs and writes `<out>/guides/`.

use crate::apply::{apply_route, Inputs};
use crate::engine::{self, WalkYards};
use crate::input::{Data, OrderT, Route, World};
use crate::re;
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
	/// A guide's opening accepts that need a quest only an earlier guide hands in (post::fresh_openers):
	/// listed in the log (default), moved to a later visit to their giver, or not checked.
	pub fresh_openers: crate::post::FreshOpeners,
}

impl Default for RunOpts {
	fn default() -> Self {
		RunOpts { engine: true, level: true, route_legs: true, repair: true, rules: engine::Opts::default(), fresh_openers: crate::post::FreshOpeners::default() }
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
		solo_fallback: opts.engine && opts.rules.groups,
		walks: if opts.engine { inp.walks } else { None },
		borders: if opts.engine { inp.walk_yards.and_then(|w| w.borders()) } else { None },
		fresh_openers: opts.fresh_openers,
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
	// (A bare `complete` of plain kills, items, objects and talks becomes their objective goals, before
	// the engine: its rules read them as the player gets them.)
	let mut objective_lines = 0;
	for rel in &written {
		let side = if rel.starts_with("forever/alliance/") {
			Some('A')
		} else if rel.starts_with("forever/horde/") {
			Some('H')
		} else {
			None
		};
		if let Some(t) = tree.get(rel) {
			let (t2, n) = crate::objectives::objective_goals(t, side, inp.gdata, inp.mechanics);
			if n > 0 {
				objective_lines += n;
				tree.insert(rel.clone(), t2);
			}
		}
	}
	if objective_lines > 0 {
		log.push(format!("objective goals: {objective_lines} complete lines"));
	}
	let mut eng = None;
	let mut check = None;
	if opts.engine {
		let accept_lvl: FxHashMap<u32, f64> = inp.route.order.iter().filter(|o| o.t == OrderT::Accept).filter_map(|o| Some((o.q?, o.lvl?))).collect();
		let no_along = crate::fixes::no_along(&inp.records, inp.route.faction.as_deref());
		// Each quest of the route's group families -> its root (the order's `group`, the family's list).
		let mut group_of: FxHashMap<u32, u32> = inp.route.order.iter().filter_map(|o| Some((o.q?, o.group?))).collect();
		for g in &inp.route.groups {
			let Some(root) = g.q else { continue };
			for &q in g.quests.iter().chain([&root]) {
				group_of.entry(q).or_insert(root);
			}
		}
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
			groups: &inp.route.groups,
			group_of: &group_of,
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
		// (A way in for quest holders only goes into their step, before the travel check.)
		for rel in &written {
			if let Some(t) = tree.get(rel) {
				let t2 = crate::post::onquest_way_in(t.split('\n').map(str::to_string).collect()).join("\n");
				if t2 != *t {
					tree.insert(rel.clone(), t2);
				}
			}
		}
		let (n, all, list) = travel::r1_check(&tree, inp.guides, &r.travel, inp.gdata);
		log.extend(list.iter().map(|(f, l, why)| format!("travel check: {f}:{l} {why}")));
		log.push(format!("travel check: {n} R1 failures v1 does not have on the route's chain ({all} in all)"));
		check = Some((n, all));
	}
	// (A class's detour hands in what it walks past, ready.)
	{
		let mut chain: Vec<(String, Vec<String>)> = written.iter().filter_map(|f| tree.get(f).map(|t| (f.clone(), t.split('\n').map(str::to_string).collect()))).collect();
		let n = crate::post::detour_hand_ins(&mut chain, inp.world);
		if n > 0 {
			log.push(format!("detour hand-ins: {n}"));
			for (f, ls) in chain {
				tree.insert(f, ls.join("\n"));
			}
		}
	}
	// (A follow-up from the NPC just handed its prerequisite is taken there, after the detours.)
	{
		let order = &inp.route.order;
		let mut lvl_after: FxHashMap<u32, f64> = FxHashMap::default();
		for (i, o) in order.iter().enumerate() {
			if let (OrderT::Turnin, Some(q)) = (o.t, o.q) {
				if let Some(l) = order[i + 1..].iter().find_map(|n| n.lvl) {
					lvl_after.entry(q).or_insert(l);
				}
			}
		}
		let pairs = crate::hub::fix_pairs(inp.route.faction.as_deref());
		for rel in &written {
			if let Some(t) = tree.get(rel) {
				let t2 = crate::post::follow_ups_at_their_giver(t.split('\n').map(str::to_string).collect(), inp.data, inp.world, &|q| lvl_after.get(&q).copied(), &pairs).join("\n");
				if t2 != *t {
					tree.insert(rel.clone(), t2);
				}
			}
		}
	}
	// (Weapon skills where the route is in a capital anyway, #655: before the class lists are cut to
	// the guide's races.)
	if let (true, Some(fac)) = (opts.engine && opts.route_legs, inp.route.faction.as_deref()) {
		let mut lvl: FxHashMap<(&'static str, u32), f64> = FxHashMap::default();
		for o in &inp.route.order {
			let k: &'static str = match o.t {
				OrderT::Accept => "accept",
				OrderT::Turnin => "turnin",
				_ => continue,
			};
			if let (Some(q), Some(l)) = (o.q, o.lvl) {
				lvl.entry((k, q)).or_insert(l);
			}
		}
		let zone_of_map = |m: u32| inp.world.zones.get(&m).filter(|z| !z.is_empty()).cloned();
		let playable = |race: &str| -> Vec<String> {
			let file = forge_core::RACES.iter().find(|r| r.key.eq_ignore_ascii_case(race) || r.file.eq_ignore_ascii_case(race) || (race == "Undead" && r.file == "Scourge")).map_or(race, |r| r.file);
			forge_judge::honest::playable_classes(inp.gdata, file, fac).iter().map(|c| forge_core::class_label(c)).collect()
		};
		let start = crate::shared::race_of(inp.route.start.as_deref().unwrap_or(""));
		let join_at = inp.route.shared.as_ref().and_then(|s| s.get("joinAt")).and_then(|v| v.as_str());
		// (Where a goal line's NPC stands, in world yards: its quest's giver or ender, its `train` or
		// `npc` id, by the data's spawns.)
		let proj = forge_core::frames::Projector::new(inp.frames);
		let spots = |npc: u32| -> Vec<(i64, f64, f64)> {
			let Some(e) = inp.data.npcs.get(&npc) else { return Vec::new() };
			let mut out = Vec::new();
			for (&map, sp) in &e.spawns {
				let f = if sp.f.as_deref() == Some("l") { forge_core::frames::Frame::Live } else { forge_core::frames::Frame::Era };
				for q in &sp.pts {
					let c = |i: usize| q.get(i).map_or(f64::NAN, |v| v.unwrap_or(0.0));
					let w = proj.point(map, c(0), c(1), Some(f));
					if w.wx.is_finite() {
						out.push((w.c, w.wx, w.wy));
					}
				}
			}
			out
		};
		let npc_yd = |code: &str, to: u32| -> Option<f64> {
			let npcs: Vec<u32> = if let Some(m) = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code) {
				let q = inp.data.quests.get(&m[2].parse::<u32>().ok()?)?;
				let ends = if &m[1] == "accept" { q.start.as_ref() } else { q.end.as_ref() };
				ends.map_or_else(Vec::new, |e| e.npc.clone())
			} else {
				let m = re!(r"^\s+train\s+(\d+)\b|\bnpc\s+(\d+)\b").captures(code)?;
				vec![m.get(1).or(m.get(2))?.as_str().parse().ok()?]
			};
			let there = spots(to);
			npcs.iter().flat_map(|&n| spots(n)).flat_map(|a| there.iter().filter(move |b| b.0 == a.0).map(move |b| forge_core::jsnum::js_hypot(a.1 - b.1, a.2 - b.2))).reduce(f64::min)
		};
		let env = crate::weapons::Env { faction: fac, start_race: &start, join_at, lvl: &lvl, zone_of_map: &zone_of_map, playable: &playable, npc_yd: &npc_yd };
		let mut chain: Vec<(String, Vec<String>)> = written.iter().filter_map(|f| tree.get(f).map(|t| (f.clone(), t.split('\n').map(str::to_string).collect()))).collect();
		let added = crate::weapons::weapon_steps(&mut chain, &env);
		if !added.is_empty() {
			log.extend(added);
			for (f, ls) in chain {
				tree.insert(f, ls.join("\n"));
			}
		}
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
	// (No `hearth` goal in a written guide: the arrow gives the hearth advice, 0.3.3. Last, so every
	// pass before, the travel repair and check included, still sees the route's hearth legs.)
	for rel in &written {
		if let Some(t) = tree.get(rel) {
			let t2 = crate::post::no_hearths(t);
			if t2 != *t {
				tree.insert(rel.clone(), t2);
			}
		}
	}
	// (The seed's notes above each written guide's first step go, once every pass has run.)
	for rel in &written {
		if let Some(t) = tree.get(rel) {
			let t2 = re!(r"\n{3,}").replace_all(&crate::apply::without_seed_notes(t), "\n\n").into_owned();
			if t2 != *t {
				tree.insert(rel.clone(), t2);
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
