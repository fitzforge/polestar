//! `forge guide legacy-steps`: addon/Polestar/Core/LegacySteps.lua, for each leveling guide the steps
//! earlier releases had that the current guides no longer have, as the Engine names a step
//! (Own.stepParts: "turnin:783,accept:7"), keyed by the hash a character's save stores for it
//! (CharState().stepKeys, Own.hash). An update that changes a step loses the check-offs, skips and saved
//! view the save holds for it unless the Engine knows that step's goals; with these it carries them to
//! the step of the new guide that has the same goal (Own.remap, #1353). Run at a release whose leveling
//! guides changed, with the guide sources of each earlier release players may update from (docs/RELEASING.md).
//!
//! It also writes ns.LegacyMovedIn, kept resident: per guide, the quests it offers now that an earlier
//! release's route offered in another leveling guide of its faction, not in this one. A character who
//! played that route may have done them before reaching this guide, so the Engine's placement does not take
//! their progress as a sign of where the player is in it (anchorStep). Per guide, `titles`: its title in
//! each earlier release whose title differs from today's, by that release's guides version (each old
//! folder's pack.json): a tab an update moved to another guide is named in chat as the player knew it
//! (#3440).
//!
//! The port of tools/legacy-steps.js (#2603): the same file, byte for byte, but its first line.

use forge_guide::data::Data;
use forge_guide::diag::Diagnostics;
use forge_guide::js::{cmp_utf16, parse_json, V};
use forge_guide::project::{compile_sources, find_guide_files, CompileOpts, Source};
use std::collections::{BTreeMap, BTreeSet, HashMap, HashSet};
use std::path::Path;

const FACTIONS: [&str; 2] = ["Alliance", "Horde"];
/// The goal fields Own.stepParts names a goal by, the first one set.
const ID_KEYS: [&str; 10] = ["quest", "npc", "item", "spell", "object", "faction", "achievement", "level", "location", "map"];

/// What [`build`] wrote: the steps listed, of how many guides, and the quests moved into how many guides.
pub struct Written {
	pub lua: String,
	pub steps: usize,
	pub guides: usize,
	pub moved: usize,
	pub moved_guides: usize,
}

/// A folder's leveling guides: each faction's, and the ones both sides play (Shen'dralas, Mount Hyjal:
/// no `faction`, under a level-band folder; #3465), compiled.
fn leveling(dir: &Path, data: &Data) -> Result<Vec<V>, String> {
	let band = |s: &str| s.split_once('-').is_some_and(|(a, b)| !a.is_empty() && !b.is_empty() && a.bytes().all(|c| c.is_ascii_digit()) && b.bytes().all(|c| c.is_ascii_digit()));
	let mut sources = Vec::new();
	for rel in find_guide_files(dir, false) {
		let Some(rest) = rel.strip_prefix("forever/") else { continue };
		let Some((top, _)) = rest.split_once('/') else { continue };
		if !(top == "horde" || top == "alliance" || band(top)) {
			continue;
		}
		let file = dir.join(&rel);
		let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
		sources.push(Source { source: rel, file: file.to_string_lossy().into_owned(), text });
	}
	let opts = CompileOpts { pack: None, author: None, context: None, pack_dir: None };
	let guides = compile_sources(&sources, data, &mut Diagnostics::new(), &opts).guides;
	Ok(guides
		.into_iter()
		.filter(|g| {
			let (c, f) = (g.get("category"), g.get("faction"));
			(c.is_nullish() || c.as_str() == Some("Leveling")) && (f.is_nullish() || f.as_str().is_some_and(|f| FACTIONS.contains(&f)))
		})
		.collect())
}

/// A goal as Own.goalId names it: its verb and its first id ("turnin:783").
fn goal_id(g: &V) -> String {
	let id = ID_KEYS.iter().map(|k| g.get(k)).find(|v| !v.is_nullish() && !matches!(v, V::Bool(false))).map(|v| v.to_js_string()).unwrap_or_default();
	format!("{}:{id}", g.get("t").to_js_string())
}

/// A step as Own.stepParts names it: its goals' ids.
fn part(step: &V) -> String {
	step.get("goals").items().iter().map(goal_id).collect::<Vec<_>>().join(",")
}

/// Own.hash: djb2 over the bytes, mod 2^32.
fn hash(s: &str) -> u64 {
	s.bytes().fold(5381u64, |h, b| (h * 33 + u64::from(b)) % 4_294_967_296)
}

/// The quest goals guide g has as optional only, and as blocking (by goal id).
fn optionality(g: &V) -> (Vec<String>, HashSet<String>) {
	let mut opt: Vec<String> = Vec::new();
	let mut req = HashSet::new();
	for st in g.get("steps").items() {
		for goal in st.get("goals").items() {
			if goal.get("quest").is_nullish() {
				continue;
			}
			let id = goal_id(&goal);
			if goal.get("optional").truthy() {
				if !opt.contains(&id) {
					opt.push(id);
				}
			} else {
				req.insert(id);
			}
		}
	}
	opt.retain(|x| !req.contains(x));
	(opt, req)
}

/// The quests guide g's accepts take.
fn accepts(g: &V) -> HashSet<i64> {
	let mut out = HashSet::new();
	for st in g.get("steps").items() {
		for goal in st.get("goals").items() {
			if goal.get("t").as_str() == Some("accept") {
				if let Some(q) = goal.get("quest").as_num() {
					out.insert(q as i64);
				}
			}
		}
	}
	out
}

/// A Lua string literal, as the JavaScript wrote it.
fn lua(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\""))
}

/// The file for the guides in `current` against those of each folder of `olds` (in release order),
/// compiled with `data`.
pub fn build(current: &Path, olds: &[&Path], data: &Data) -> Result<Written, String> {
	let mut now: HashMap<String, HashSet<String>> = HashMap::new();
	let mut now_req: HashMap<String, HashSet<String>> = HashMap::new();
	let mut now_title: HashMap<String, String> = HashMap::new();
	// id -> (faction, quests offered), in the current guides' order.
	let mut offers_now: Vec<(String, V, HashSet<i64>)> = Vec::new();
	for g in leveling(current, data)? {
		let id = g.get("id").to_js_string();
		now.insert(id.clone(), g.get("steps").items().iter().map(part).collect());
		now_req.insert(id.clone(), optionality(&g).1);
		now_title.insert(id.clone(), g.get("title").to_js_string());
		offers_now.push((id, g.get("faction"), accepts(&g)));
	}
	let mut legacy: HashMap<String, BTreeMap<u64, String>> = HashMap::new();
	// id -> the quest goals an earlier release had as optional only that block now: a player could have
	// passed them, so an update must not send them back there.
	let mut required: HashMap<String, BTreeSet<String>> = HashMap::new();
	// id -> the quests it offers now that an earlier release offered in another leveling guide of the faction.
	let mut moved_in: HashMap<String, BTreeSet<i64>> = HashMap::new();
	// id -> (release version, the guide's title in it), in release order, for the releases whose title differs.
	let mut titles: HashMap<String, Vec<(String, String)>> = HashMap::new();
	for dir in olds {
		let gs = leveling(dir, data)?;
		let pack = std::fs::read_to_string(dir.join("pack.json")).map_err(|e| format!("{}: {e}", dir.join("pack.json").display()))?;
		let version = parse_json(&pack).map_err(|e| format!("{}: {e}", dir.join("pack.json").display()))?.get("version");
		let offered_then: HashMap<String, HashSet<i64>> = gs.iter().map(|g| (g.get("id").to_js_string(), accepts(g))).collect();
		for g in &gs {
			let id = g.get("id").to_js_string();
			let Some(keep) = now.get(&id) else { continue };
			let m = legacy.entry(id.clone()).or_default();
			for st in g.get("steps").items() {
				let p = part(&st);
				if !p.is_empty() && !keep.contains(&p) {
					m.insert(hash(&p), p);
				}
			}
			let r = required.entry(id.clone()).or_default();
			for x in optionality(g).0 {
				if now_req[&id].contains(&x) {
					r.insert(x);
				}
			}
			let title = g.get("title");
			if version.truthy() && title.truthy() && title.to_js_string() != now_title[&id] {
				let t = titles.entry(id.clone()).or_default();
				let v = version.to_js_string();
				match t.iter_mut().find(|(k, _)| *k == v) {
					Some(e) => e.1 = title.to_js_string(),
					None => t.push((v, title.to_js_string())),
				}
			}
		}
		for (id, faction, quests) in &offers_now {
			let own = offered_then.get(id);
			for g in &gs {
				let f = g.get("faction");
				if g.get("id").to_js_string() == *id || (f.is_undef(), f.as_str()) != (faction.is_undef(), faction.as_str()) {
					continue;
				}
				for q in accepts(g) {
					if quests.contains(&q) && !own.is_some_and(|o| o.contains(&q)) {
						moved_in.entry(id.clone()).or_default().insert(q);
					}
				}
			}
		}
	}
	let sorted = |keys: Vec<&String>| {
		let mut k: Vec<String> = keys.into_iter().cloned().collect::<BTreeSet<_>>().into_iter().collect();
		k.sort_by(|a, b| cmp_utf16(a, b));
		k
	};
	let mut lines: Vec<String> = [
		"-- Generated by `forge guide legacy-steps` from earlier releases' leveling guides. Do not edit.",
		"-- Per guide, the steps those releases had that these guides no longer have: the hash a",
		"-- save stores for a step (CharState().stepKeys) -> its goals as the Engine names them",
		"-- (Own.stepParts). Own.remap carries a changed step's check-offs, skips and saved view",
		"-- to the step that now has the same goal. `required`: quest goals an earlier release had",
		"-- as optional only that block now (Own.noteAdded passes them behind the player). `titles`:",
		"-- the guide's title in each release whose title differs from today's, by the guides' version",
		"-- (the chat line of a tab an update moved, Own.followReworked). A function: its table is built only when an",
		"-- update changed a saved guide (Own.legacy), and the Engine drops it once the saved tabs",
		"-- are mapped, so a session without an update keeps none of it.",
		"local _, ns = ...",
		"ns.LegacyStepsLoad = function() return {",
	]
	.iter()
	.map(|s| s.to_string())
	.collect();
	let mut steps = 0;
	let none = BTreeMap::new();
	for id in sorted(legacy.keys().chain(required.keys()).chain(titles.keys()).collect()) {
		let m = legacy.get(&id).unwrap_or(&none);
		let mut r: Vec<&String> = required.get(&id).map(|r| r.iter().collect()).unwrap_or_default();
		r.sort_by(|a, b| cmp_utf16(a, b));
		let t = titles.get(&id).map(Vec::as_slice).unwrap_or(&[]);
		if m.is_empty() && r.is_empty() && t.is_empty() {
			continue;
		}
		lines.push(format!("\t[{}] = {{", lua(&id)));
		if !r.is_empty() {
			lines.push(format!("\t\trequired = {},", lua(&r.iter().map(|s| s.as_str()).collect::<Vec<_>>().join(","))));
		}
		if !t.is_empty() {
			lines.push(format!("\t\ttitles = {{ {} }},", t.iter().map(|(v, title)| format!("[{}] = {}", lua(v), lua(title))).collect::<Vec<_>>().join(", ")));
		}
		for (h, p) in m {
			lines.push(format!("\t\t[{h}] = {},", lua(p)));
			steps += 1;
		}
		lines.push("\t},".into());
	}
	lines.push("} end".into());
	lines.push(String::new());
	lines.push("-- Per guide, the quests it offers that an earlier release's route offered in another leveling".into());
	lines.push("-- guide of its faction, not in this one: their progress is no sign of the player's place in it".into());
	lines.push("-- (the Engine's anchorStep). Kept resident: placement reads it at every load.".into());
	lines.push("ns.LegacyMovedIn = {".into());
	let mut moved = 0;
	for id in sorted(moved_in.keys().collect()) {
		let qs = &moved_in[&id];
		lines.push(format!("\t[{}] = {},", lua(&id), lua(&qs.iter().map(|q| q.to_string()).collect::<Vec<_>>().join(","))));
		moved += qs.len();
	}
	lines.push("}".into());
	lines.push(String::new());
	Ok(Written { lua: lines.join("\n"), steps, guides: legacy.len(), moved, moved_guides: moved_in.len() })
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn a_step_is_named_by_its_goals_first_ids_and_hashed_as_the_engine_hashes_it() {
		let step = parse_json(r#"{"goals":[{"t":"turnin","quest":783,"npc":197},{"t":"accept","quest":7},{"t":"goto","map":1429,"x":1,"y":2},{"t":"note","level":false}]}"#).unwrap();
		assert_eq!(part(&step), "turnin:783,accept:7,goto:1429,note:");
		// Own.hash: djb2 mod 2^32 over the UTF-8 bytes.
		assert_eq!(hash(""), 5381);
		assert_eq!(hash("a"), 177_670);
		assert_eq!(hash(&"x".repeat(40)), "x".repeat(40).bytes().fold(5381u64, |h, b| (h * 33 + u64::from(b)) % 4_294_967_296));
		assert_eq!(lua("a \"b\" \\c"), r#""a \"b\" \\c""#);
	}
}
