//! The writer's own tips on the written chain (docs/forge/writer.md, "Text: what the writer writes
//! itself"), as the engine plays it (engine.rs):
//!
//! - R9 where: a goal at an NPC or object (an accept, hand-in, talk, click, kill or collect, a trainer or
//!   vendor) whose spawns stand below ground, upstairs or on a building's top floor, indoors or under
//!   water gets that on its note ("upstairs", "inside Fargodeep Mine"). The walking grid's floors at the
//!   spawn's height say which: classic-db's heights (spawnz.json), else the Forever server's own spawns.
//!   A goal at an NPC who walks around (moves.json, the walk the compiler circles on the map) gets "walks
//!   around <area>" instead. Not in the capitals (every quarter of the Undercity is below ground).
//! - R10 warnings: a quest's notes in the knowledge base (quest-notes.json) that warn of an ambush,
//!   stealthed mobs, adds or an attack when you loot go on the first step that does the quest's work, as
//!   a tip "Careful: ...".

use crate::engine::{step_last, Chain, Edits, Inputs, Report, G};
use crate::jsre::{head, split_comment, trim_end};
use crate::re;
use forge_core::jsnum::js_hypot;
use forge_guide::data::Data;
use forge_guide::heights::HEIGHT_YARDS;
use forge_guide::js::V;
use rustc_hash::FxHashSet;
use serde_json::Value;

/// A surface of the walking grid's column at a point.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Surface {
	pub z: f64,
	pub indoor: bool,
	pub terrain: bool,
	pub swim: bool,
	/// Not walkable (the ground under a building's floor, a roof edge).
	pub blocked: bool,
}

/// The walking grid's floors (native: forge-nav's tiles).
pub trait Floors {
	/// The surfaces of the grid column holding world point (wx, wy) on instance map `c`, lowest first.
	fn column(&self, c: i64, wx: f64, wy: f64) -> Vec<Surface>;
}

/// Where a spawn stands, when the arrow alone does not say it.
#[derive(Clone, Debug, PartialEq)]
pub enum Where {
	/// Indoors with the open ground overhead: a cellar, a basement, a cave.
	Below,
	/// In a cave or mine, by its area's name.
	Cave(String),
	Upstairs,
	TopFloor,
	Inside,
	Underwater,
}

/// Storeys are this many yards apart or more.
const STOREY_YD: f64 = 3.0;
/// The open ground this far over an indoor floor: the floor is below ground.
const BURIED_YD: f64 = 4.0;
/// The water's surface this far over a spawn: it is under water.
const DEPTH_YD: f64 = 4.0;
/// A spawn stands on the highest floor at most this far over its height.
const STAND_YD: f64 = 2.0;
/// The share of a goal's spawns that must stand alike for a note.
const SHARE: f64 = 2.0 / 3.0;
/// Spawns within this many yards outside a goal's spawn spot are its own.
const SPOT_SLACK_YD: f64 = 10.0;
/// An NPC found at a few places all within this many yards of each other walks between them.
const PLACES_YD: f64 = 150.0;
/// A drop chance (percent) from which a mob's spawns count for a collect.
const DROP_MIN: f64 = 10.0;
/// Warnings per quest.
const WARN_MAX: usize = 2;
/// The capitals: every quarter of the Undercity is below ground, every Ironforge hall indoors.
const CAPITALS: [&str; 6] = ["Orgrimmar", "Thunder Bluff", "Undercity", "Stormwind City", "Ironforge", "Darnassus"];

const VERBS: [&str; 12] = ["accept", "turnin", "talk", "interact", "kill", "collect", "train", "buy", "vendor", "sethome", "getfp", "learn"];

/// The words of a cave's or mine's area name.
fn cave_name(area: &str) -> bool {
	re!(r"(?i)\b(cave|caves|cavern|caverns|mine|mines|grotto|den|burrow|burrows|lair|tunnels?|barrows?|hive)\b").is_match(area)
}

/// Where a spawn at height `z` stands in the grid column `col`; None: in the open (or not known).
pub fn where_at(col: &[Surface], z: f64, area: Option<&str>) -> Option<Where> {
	if col.iter().any(|s| s.swim && s.z - z >= DEPTH_YD) {
		return Some(Where::Underwater);
	}
	let floor = col.iter().filter(|s| !s.swim && !s.blocked && s.z <= z + STAND_YD).max_by(|a, b| a.z.total_cmp(&b.z))?;
	if !floor.indoor {
		return None;
	}
	let cave = area.filter(|a| cave_name(a)).map(|a| Where::Cave(a.to_string()));
	// (The ground over it, walkable or under a building's floor: the cellar under Brill's town hall.)
	if col.iter().any(|s| s.terrain && !s.indoor && s.z - floor.z >= BURIED_YD) {
		return Some(cave.unwrap_or(Where::Below));
	}
	// Storeys under it: a building's floors, not the ground it stands on.
	let mut below: Vec<f64> = col.iter().filter(|s| !s.swim && !s.blocked && !s.terrain && floor.z - s.z >= STOREY_YD).map(|s| s.z).collect();
	below.sort_by(f64::total_cmp);
	let storeys = below.iter().fold((0usize, f64::NEG_INFINITY), |(n, last), &z| if z - last >= STOREY_YD { (n + 1, z) } else { (n, last) }).0;
	if storeys == 0 {
		return Some(cave.unwrap_or(Where::Inside));
	}
	let above = col.iter().any(|s| s.indoor && !s.blocked && s.z - floor.z >= STOREY_YD);
	Some(if !above && storeys >= 2 { Where::TopFloor } else { Where::Upstairs })
}

fn phrase(w: &Where) -> String {
	match w {
		Where::Below => "below ground".into(),
		Where::Cave(a) => format!("inside {a}"),
		Where::Upstairs => "upstairs".into(),
		Where::TopFloor => "on the top floor".into(),
		Where::Inside => "inside".into(),
		Where::Underwater => "underwater".into(),
	}
}

/// Words that say it already, in a goal's note.
fn said(w: &Where, note: &str) -> bool {
	let r = match w {
		Where::Below => re!(r"(?i)\b(basement|cellar|crypt|downstairs|below|underground|beneath|down into|down the stairs|under the)\b"),
		Where::Cave(_) => re!(r"(?i)\b(cave|mine|cavern|inside|tunnels?|den)\b"),
		Where::Upstairs | Where::TopFloor => re!(r"(?i)\b(upstairs|top floor|upper|floor|balcony|top of|tower|stairs)\b"),
		Where::Inside => re!(r"(?i)\b(inside|indoors|in the (house|hall|inn|building|tavern|barracks|tower|keep|chapel|church|manor|cellar|basement|town hall))\b"),
		Where::Underwater => re!(r"(?i)\b(underwater|under water|lake bed|bottom of|dive|seabed|sea floor)\b"),
	};
	r.is_match(note)
}

fn capital(s: &str) -> String {
	let mut c = s.chars();
	c.next().map_or(String::new(), |f| f.to_uppercase().collect::<String>() + c.as_str())
}

/// The goal note with `phrase` added: the phrase alone, after the target's name when the note is only
/// that name, else after the note.
pub fn with_phrase(note: &str, name: Option<&str>, phrase: &str) -> String {
	let note = note.trim();
	if note.is_empty() {
		capital(phrase)
	} else if name.is_some_and(|n| n.eq_ignore_ascii_case(note)) {
		format!("{note}, {phrase}")
	} else {
		format!("{note}; {phrase}")
	}
}

/// The note for an NPC who walks around `area` (None: no area of its own): his walk is the circle on
/// the map (`circle`), else the map marks the few places he is found at.
pub fn walk_note(note: &str, name: Option<&str>, area: Option<&str>, circle: bool) -> String {
	let walk = format!("walks around {}: {}", area.unwrap_or("here"), if circle { "look inside the circle on the map" } else { "the map marks where to look" });
	let note = note.trim();
	match name {
		Some(n) if note.is_empty() || n.eq_ignore_ascii_case(note) => format!("{n} {walk}"),
		_ if note.is_empty() => capital(&walk),
		_ => format!("{note}; {walk}"),
	}
}

/// A line with its `--` note set to `note`.
fn with_note(line: &str, note: &str) -> String {
	let (code, rest) = split_comment(line);
	if rest.is_empty() {
		format!("{:<37} -- {note}", trim_end(code))
	} else {
		format!("{code} -- {note}")
	}
}

fn note_of(line: &str) -> &str {
	let (_, rest) = split_comment(line);
	rest.trim_start().strip_prefix("--").map_or("", str::trim)
}

fn name_of(data: &Data, kind: &str, id: u32) -> Option<String> {
	let n = if kind == "npc" { &data.npcs } else { &data.objects }.get(&id.to_string()).get("name");
	n.truthy().then(|| n.to_js_string())
}

/// The heights of an NPC's or object's spawns: (instance map, wx, wy, z), from spawnz.json and `extra`.
fn spawn_heights(data: &Data, extra: Option<&V>, kind: &str, id: u32) -> Vec<(f64, f64, f64, f64)> {
	let mut out: Vec<(f64, f64, f64, f64)> = Vec::new();
	for t in [Some(&data.spawnz), extra].into_iter().flatten() {
		for e in t.get(kind).get(&id.to_string()).items() {
			let p = (e.at(0).num(), e.at(1).num(), e.at(2).num(), e.at(3).num());
			if p.3.is_finite() && !out.iter().any(|q| q.0 == p.0 && js_hypot(q.1 - p.1, q.2 - p.2) < 1.0) {
				out.push(p);
			}
		}
	}
	out
}

/// The spawns a goal stands for, with their heights: its NPC's or object's spawn at its point, or for
/// work over an area the spawns of its target (an item's droppers and holders) inside its spots.
fn goal_spawns(data: &Data, extra: Option<&V>, g: &G) -> Vec<(f64, f64, f64, f64)> {
	let Some(w) = g.w else { return Vec::new() };
	let mut sources: Vec<(&str, u32)> = Vec::new();
	if let Some(n) = g.npc {
		sources.push(("npc", n));
	}
	if let Some(o) = g.object {
		sources.push(("object", o));
	}
	if g.verb == "collect" && sources.is_empty() {
		if let Some(item) = g.item {
			let drops = data.item(&V::Num(item.into())).get("drops");
			for kind in ["npc", "object"] {
				let by = drops.get(kind);
				for k in by.keys() {
					let chance = by.get(&k).num();
					if !(chance.is_finite() && chance > 0.0 && chance < DROP_MIN) {
						if let Ok(id) = k.parse() {
							sources.push((kind, id));
						}
					}
				}
			}
		}
	}
	let field = matches!(g.verb.as_str(), "kill" | "collect" | "interact") && !g.spots.is_empty();
	let mut out = Vec::new();
	for (kind, id) in sources {
		for p in spawn_heights(data, extra, kind, id) {
			if p.0 != w.c {
				continue;
			}
			let near = if field { g.spots.iter().any(|s| s.w.c == p.0 && js_hypot(s.w.wx - p.1, s.w.wy - p.2) <= s.r + SPOT_SLACK_YD) } else { js_hypot(w.wx - p.1, w.wy - p.2) <= HEIGHT_YARDS };
			if near {
				out.push(p);
			}
		}
	}
	out
}

/// Where most of a goal's spawns stand (SHARE of them alike), or None.
fn goal_where(inp: &Inputs, floors: &dyn Floors, g: &G) -> Option<Where> {
	let spawns = goal_spawns(inp.data, inp.heights, g);
	if spawns.is_empty() {
		return None;
	}
	let mut seen: Vec<(Where, usize)> = Vec::new();
	for &(c, wx, wy, z) in &spawns {
		let area = inp.area_at.and_then(|a| a.at(c as i64, wx, wy)).map(|s| s.name);
		let w = where_at(&floors.column(c as i64, wx, wy), z, area.as_deref());
		let Some(w) = w else { continue };
		match seen.iter_mut().find(|s| s.0 == w) {
			Some(s) => s.1 += 1,
			None => seen.push((w, 1)),
		}
	}
	let (w, n) = seen.into_iter().max_by_key(|s| s.1)?;
	(n as f64 >= SHARE * spawns.len() as f64).then_some(w)
}

/// R9: where-notes and walk notes on the chain's goal lines, on a step's first goal at each NPC or object.
pub(crate) fn place_notes(ch: &Chain, texts: &[Vec<String>], edits: &mut [Edits], inp: &Inputs, rep: &mut Report) {
	let data = inp.data;
	let mut done: FxHashSet<(usize, u32)> = FxHashSet::default();
	let mut met: FxHashSet<(usize, usize, &str, u32)> = FxHashSet::default();
	for g in &ch.seq {
		let li = (g.line as usize).wrapping_sub(1);
		let Some(line) = texts[g.gi].get(li) else { continue };
		if !VERBS.contains(&g.verb.as_str()) || ch.steps[g.gi][g.si].along || !done.insert((g.gi, g.line)) || edits[g.gi].removed.contains(&li) || edits[g.gi].replaced.contains_key(&li) {
			continue;
		}
		let zone = data.zones.get(&format!("{}", g.map as i64)).get("name");
		if zone.as_str().is_some_and(|z| CAPITALS.contains(&z)) {
			continue;
		}
		let note = note_of(line);
		let (kind, id) = match (g.npc, g.object, g.item) {
			(Some(n), _, _) => ("npc", Some(n)),
			(_, Some(o), _) => ("object", Some(o)),
			(_, _, Some(i)) => ("item", Some(i)),
			_ => ("npc", None),
		};
		// (Said once per step: the hand-in and the next accept at one NPC share the note.)
		if id.is_some_and(|i| !met.insert((g.gi, g.si, kind, i))) {
			continue;
		}
		let name = id.filter(|_| kind != "item").and_then(|i| name_of(data, kind, i));
		// A walk of his own (moves.json), else a few spawn places close together (the compiler's spots).
		let places = matches!(g.verb.as_str(), "accept" | "turnin" | "talk") && kind == "npc" && g.spots.len() >= 2 && g.spots.iter().all(|a| g.spots.iter().all(|b| js_hypot(a.w.wx - b.w.wx, a.w.wy - b.w.wy) <= PLACES_YD));
		let centre = g.walk.map(|(x, y, _)| (x, y)).or_else(|| places.then(|| (g.spots.iter().map(|s| s.w.wx).sum::<f64>() / g.spots.len() as f64, g.spots.iter().map(|s| s.w.wy).sum::<f64>() / g.spots.len() as f64)));
		if let (Some((cx, cy)), Some(w)) = (centre, g.w) {
			let step_tip: String = step_tips(&texts[g.gi], g.step_line as usize - 1);
			let walking = re!(r"(?i)\b(walks?|wanders?|patrols?|roams?|paces?)\b");
			if walking.is_match(note) || walking.is_match(&step_tip) {
				continue;
			}
			let area = inp.area_at.and_then(|a| a.at(w.c as i64, cx, cy)).filter(|s| s.name != s.zone && !s.name.starts_with("area ")).map(|s| s.name);
			edits[g.gi].replaced.insert(li, with_note(line, &walk_note(note, name.as_deref(), area.as_deref(), g.walk.is_some())));
			rep.add("R9 walks around", 1);
			continue;
		}
		let Some(floors) = inp.floors else { continue };
		let Some(w) = goal_where(inp, floors, g) else { continue };
		// (Indoors is no news at a trainer, vendor, innkeeper or flight master.)
		if said(&w, note) || (w == Where::Inside && !matches!(g.verb.as_str(), "accept" | "turnin" | "talk" | "interact" | "kill" | "collect")) {
			continue;
		}
		edits[g.gi].replaced.insert(li, with_note(line, &with_phrase(note, name.as_deref(), &phrase(&w))));
		rep.add("R9 where", 1);
	}
}

/// The text of the `tip` lines of the step whose header is line `s`.
fn step_tips(lines: &[String], s: usize) -> String {
	let refs: Vec<&str> = lines.iter().map(String::as_str).collect();
	(s + 1..=step_last(&refs, s)).filter(|&l| head(&lines[l]) == Some("tip")).map(|l| lines[l].trim().trim_start_matches("tip").trim()).collect::<Vec<_>>().join(" ")
}

/// A danger note's kind, in the order warnings are picked: an ambush, an attack when you loot or click,
/// stealthed mobs, adds; None for other dangers. (A mob that flees for help at low health is every
/// other camp's: not a warning of its own.)
fn warn_kind(fact: &str) -> Option<usize> {
	// (An ambush, unless the note says there is none; mobs named Ambushers only when they attack or
	// appear: "Bloodfury Ambushers use Shock" is no ambush.)
	let attack = re!(r"(?i)\b(attacks?|appears?|spawns?|jumps?|comes? out|leaves? stealth)\b");
	let none = re!(r"(?i)\bno\b[^.]*\bambush");
	if !none.is_match(fact) && (re!(r"(?i)\bambush(es|ed|ing)?\b").is_match(fact) || (re!(r"(?i)\bambushers?\b").is_match(fact) && attack.is_match(fact))) {
		return Some(0);
	}
	if re!(r"(?i)\b(when|as soon as|once|after|while|if) you (loot|open|click|touch|take|pick|use|grab|disturb|approach)").is_match(fact) && re!(r"(?i)\b(attack|spawn|appear|aggro|come out|comes out|jump)").is_match(fact) {
		return Some(1);
	}
	// (Stealthed mobs, not the player's own stealth: "a stealthed character ... can loot it".)
	if re!(r"(?i)\b(stealth|stealthed|sneak|prowl|invisible)\b").is_match(fact) && !re!(r"(?i)\b(stealthed (character|player|rogue|druid)|your stealth|you (are|stay) stealthed|in stealth,? you|while stealthed)\b").is_match(fact) {
		return Some(2);
	}
	if re!(r"(?i)\b(adds|join (the|a|in the) fight|joins? in|linked|pull (several|more|two|three|extra)|pulls (several|more|extra)|aggro together|calls? (nearby allies|for help))\b").is_match(fact) {
		return Some(3);
	}
	None
}

/// The warnings of one quest's notes entry ({ notes: [{ fact, kind, basis }] }): its danger notes of a
/// warned kind, the follow-up's left out, by kind then server data before players' reports, at most
/// WARN_MAX.
pub fn quest_warnings(entry: &Value) -> Vec<String> {
	let mut picked: Vec<(usize, bool, String)> = Vec::new();
	for n in entry.get("notes").and_then(Value::as_array).into_iter().flatten() {
		if n.get("kind").and_then(Value::as_str) != Some("danger") {
			continue;
		}
		let Some(fact) = n.get("fact").and_then(Value::as_str).map(str::trim) else { continue };
		if re!(r"(?i)follow-up").is_match(fact) {
			continue;
		}
		if let Some(k) = warn_kind(fact) {
			picked.push((k, n.get("basis").and_then(Value::as_str) != Some("game-data"), fact.to_string()));
		}
	}
	picked.sort_by(|a, b| (a.0, a.1).cmp(&(b.0, b.1)));
	picked.into_iter().take(WARN_MAX).map(|p| p.2).collect()
}

/// R10: warnings as a tip on the first step that does each quest's work.
pub(crate) fn warnings(ch: &Chain, texts: &[Vec<String>], edits: &mut [Edits], inp: &Inputs, rep: &mut Report) {
	let Some(notes) = inp.notes else { return };
	let mut done: FxHashSet<u32> = FxHashSet::default();
	for g in &ch.seq {
		let Some(q) = g.quest else { continue };
		if !matches!(g.verb.as_str(), "kill" | "collect" | "interact" | "use" | "complete" | "talk") || ch.steps[g.gi][g.si].along || !done.insert(q) {
			continue;
		}
		let Some(entry) = notes.get(q.to_string()) else { continue };
		let lines = &texts[g.gi];
		let s = g.step_line as usize - 1;
		let tips = step_tips(lines, s).to_lowercase();
		let facts: Vec<String> = quest_warnings(entry).into_iter().filter(|f| !tips.contains(&f.to_lowercase())).collect();
		if facts.is_empty() {
			continue;
		}
		// After the step's opening key lines (zone, only, when, label, tips), before its goals.
		let refs: Vec<&str> = lines.iter().map(String::as_str).collect();
		let end = step_last(&refs, s);
		let at = (s + 1..=end).take_while(|&l| matches!(head(&lines[l]), Some("zone" | "only" | "when" | "label" | "along" | "tip" | "image" | "loop" | "skipto"))).last().unwrap_or(s);
		edits[g.gi].after.entry(at).or_default().push(format!("  tip Careful: {}", facts.join(" ")));
		rep.add("R10 warning", 1);
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	fn s(z: f64, f: &str) -> Surface {
		Surface { z, indoor: f.contains('I'), terrain: f.contains('T'), swim: f.contains('S'), blocked: f.contains('X') }
	}

	#[test]
	fn where_a_spawn_stands_by_the_floors_over_and_under_it() {
		// The cellar under Brill's tavern: an indoor floor with the open ground 7 yd over it.
		let cellar = [s(27.1, "WI"), s(33.3, "WI"), s(34.2, "T")];
		assert_eq!(where_at(&cellar, 27.3, Some("Brill")), Some(Where::Below));
		assert_eq!(where_at(&cellar, 27.3, Some("Fargodeep Mine")), Some(Where::Cave("Fargodeep Mine".into())));
		// A tower: three storeys, the spawn on the second, then on the third with none over it.
		let tower = [s(50.0, "T"), s(50.3, "WI"), s(56.0, "WI"), s(62.0, "WI"), s(70.0, "W")];
		assert_eq!(where_at(&tower, 56.1, None), Some(Where::Upstairs));
		assert_eq!(where_at(&tower, 62.1, None), Some(Where::TopFloor));
		assert_eq!(where_at(&tower, 50.4, None), Some(Where::Inside));
		// Out in the open, and on a lake's bed 6 yd under its surface.
		assert_eq!(where_at(&[s(34.1, "T")], 34.2, None), None);
		assert_eq!(where_at(&[s(32.9, "TS")], 26.5, None), Some(Where::Underwater));
		assert_eq!(where_at(&[s(32.9, "TS")], 31.0, None), None, "wading");
	}

	#[test]
	fn notes_read_after_the_targets_name_or_the_authors_words() {
		assert_eq!(with_phrase("", Some("Captured Zealot"), "below ground"), "Below ground");
		assert_eq!(with_phrase("Captured Zealot", Some("Captured Zealot"), "below ground"), "Captured Zealot, below ground");
		assert_eq!(with_phrase("Ask for his report", Some("Dillinger"), "upstairs"), "Ask for his report; upstairs");
		assert_eq!(walk_note("Deathguard Bartholomew", Some("Deathguard Bartholomew"), Some("Brill"), true), "Deathguard Bartholomew walks around Brill: look inside the circle on the map");
		assert_eq!(walk_note("", Some("Chicken"), None, false), "Chicken walks around here: the map marks where to look");
		assert_eq!(with_note("  accept 86784                        -- Deathguard Bartholomew", "X"), "  accept 86784                        -- X");
		assert_eq!(with_note("  collect 268801 quest 95314.1", "Downstairs"), "  collect 268801 quest 95314.1        -- Downstairs");
		assert!(said(&Where::Below, "The Captured Scarlet Zealot, in the town hall basement"));
	}

	#[test]
	fn warnings_are_a_quests_ambush_loot_stealth_and_adds_notes_not_the_follow_ups() {
		let entry: Value = serde_json::json!({ "notes": [
			{ "kind": "danger", "basis": "community", "fact": "Other bears close by can join the fight." },
			{ "kind": "danger", "basis": "game-data", "fact": "Curse of Blood lasts 10 minutes." },
			{ "kind": "danger", "basis": "game-data", "fact": "Bloodfury Ambushers use Shock on targets within 20 yards." },
			{ "kind": "danger", "basis": "community", "fact": "Mobs that trail behind will attack once he stops; there are no surprise ambushes." },
			{ "kind": "danger", "basis": "game-data", "fact": "A Shaman at 15% health runs off to find help." },
			{ "kind": "danger", "basis": "community", "fact": "A stealthed character beside the chest can loot it without drawing them." },
			{ "kind": "danger", "basis": "community", "fact": "In the follow-up, Dark Ambushers leave stealth." },
			{ "kind": "tip", "basis": "game-data", "fact": "Stealthed panthers belong to the next quest." },
			{ "kind": "danger", "basis": "community", "fact": "Two level 14 Dark Iron Ambushers attack the escort close to the camp." },
			{ "kind": "danger", "basis": "game-data", "fact": "Fen Creepers cast Sneak, so they are stealthed and hard to see." },
		]});
		assert_eq!(
			quest_warnings(&entry),
			["Two level 14 Dark Iron Ambushers attack the escort close to the camp.", "Fen Creepers cast Sneak, so they are stealthed and hard to see."]
		);
	}
}
