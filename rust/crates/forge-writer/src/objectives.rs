//! Objective goals for a bare `complete <quest>`: a quest whose objectives are plain kills, items,
//! objects to click or NPCs to talk to gets one goal per objective (`kill`, `collect`, `interact`,
//! `talk` with `quest Q.O`), so the guide window shows the target's spawn areas, its marker and the
//! objective's progress. A quest done by using an item on an NPC (the Symbol of Life on Henze Faulk)
//! gets `use <item> quest Q.O`. Escorts, events and other objectives the window cannot show keep
//! `complete`.

use crate::jsre::split_comment;
use crate::re;
use forge_guide::data::Data;
use forge_guide::js::V;
use rustc_hash::FxHashSet;
use serde_json::Value;

/// Mechanics (high or medium confidence) that make a quest more than its objectives: the window's
/// goals would not say what to do. An item used on an NPC is a `use` instead (below).
const NOT_PLAIN: [&str; 7] = ["escort", "timed", "event-start", "use-item-at-place", "summon-by-item", "crafted", "multi-step-in-one-objective"];
/// Kinds of mob dropping an item beyond which it drops all over (the Green Hills pages: a hundred).
const WIDE_DROP: usize = 20;

/// The written guide with its eligible `complete` lines replaced, and how many were. `side`: the
/// guide's faction (`A`, `H`; None: either), for the NPCs a kill objective names; `mech`: the quest
/// mechanics (data/local/mechanics/quest-mechanics.json `quests`).
pub fn objective_goals(text: &str, side: Option<char>, data: &Data, mech: Option<&Value>) -> (String, usize) {
	let lines: Vec<&str> = text.split('\n').collect();
	// (Objectives a goal of the guide already tracks: the Shrine of Akir's kills before Hyusaa.)
	let tracked: FxHashSet<(u32, u32)> = lines
		.iter()
		.filter(|l| crate::jsre::head(l) != Some("complete"))
		.filter_map(|l| re!(r"\bquest\s+(\d+)\.(\d+)\b").captures(split_comment(l).0).and_then(|c| Some((c[1].parse().ok()?, c[2].parse().ok()?))))
		.collect();
	let mut out: Vec<String> = Vec::with_capacity(lines.len());
	let mut n = 0;
	for l in &lines {
		let (code, note) = split_comment(l);
		let Some(c) = re!(r#"^(\s+)complete\s+(\d+)(\s+"[^"]*")?(.*)$"#).captures(code) else {
			out.push(l.to_string());
			continue;
		};
		let q: u32 = c[2].parse().unwrap_or(0);
		let goals: Vec<(&str, u32, usize)> = match plan(q, side, data, mech) {
			Some(g) => g.into_iter().filter(|g| !tracked.contains(&(q, g.2 as u32))).collect(),
			None => Vec::new(),
		};
		if goals.is_empty() {
			out.push(l.to_string());
			continue;
		}
		let rest = crate::jsre::trim_end(&c[4]);
		for (k, (verb, id, oi)) in goals.into_iter().enumerate() {
			let g = format!("{}{verb} {id} quest {q}.{oi}{rest}", &c[1]);
			if k > 0 || note.is_empty() {
				out.push(g);
			} else {
				// (The note where it stood, one space after a longer line.)
				let at = code.len() + 1;
				out.push(if g.len() < at { format!("{g:<at$}{}", note.trim_start()) } else { format!("{g} {}", note.trim_start()) });
			}
		}
		n += 1;
	}
	(out.join("\n"), n)
}

/// The quest's objective goals (verb, target, 1-based objective), or None when it keeps `complete`.
fn plan(q: u32, side: Option<char>, data: &Data, mech: Option<&Value>) -> Option<Vec<(&'static str, u32, usize)>> {
	let qv = data.quest(&V::Num(q as f64));
	let objs = qv.get("objectives").items();
	if objs.is_empty() || !qv.get("start").get("item").items().is_empty() || qv.get("escort").truthy() {
		return None;
	}
	let kinds = kinds(mech, q);
	let on_mob = kinds.iter().any(|k| k == "use-item-on-mob");
	let at_place = kinds.iter().any(|k| k == "use-item-at-place");
	// (An item used on the NPC at its place, Narm Faulk's Symbol of Life: the use on the mob says it.)
	if kinds.iter().any(|k| NOT_PLAIN.contains(&k.as_str()) && !(on_mob && k == "use-item-at-place")) {
		return None;
	}
	let mut out = Vec::with_capacity(objs.len());
	for (i, o) in objs.iter().enumerate() {
		let id = o.get("id").as_num().filter(|n| *n > 0.0 && n.fract() == 0.0)? as u32;
		let tv = o.get("type");
		let ty = tv.as_str()?;
		// (Only the mob the item is used on is that use: Krakle's Thermometer at the hot spot is no click.)
		if at_place && ty != "kill" {
			return None;
		}
		let goal = match ty {
			// (An item nothing drops, holds or sells has no place for the window: Morrowgrain. Nor has one
			// half the zone drops now and then: the Green Hills pages, from a hundred kinds of mob.)
			"item" => {
				let it = data.item(&V::Num(id as f64));
				let drops = it.get("drops");
				let droppers = drops.get("npc").keys().len();
				let held = !drops.get("object").keys().is_empty() || !it.get("vendors").items().is_empty();
				(held || (1..=WIDE_DROP).contains(&droppers)).then_some(("collect", id))?
			}
			"object" => ("interact", id),
			"talk" => ("talk", id),
			"kill" => match on_mob.then(|| use_item(mech, q, id)).flatten() {
				Some(item) => ("use", item),
				// (A kill credit from an NPC of the guide's side is no kill: a fight that ends in a
				// surrender, a salute, a story to hear. Nor is an item use the mechanics name no item for.)
				None => {
					let f = data.npc(&V::Num(id as f64)).get("faction");
					let friendly = f.as_str().is_some_and(|f| !f.is_empty() && side.is_none_or(|s| f.contains(s)));
					(!friendly && !on_mob).then_some(("kill", id))?
				}
			},
			_ => return None,
		};
		out.push((goal.0, goal.1, i + 1));
	}
	Some(out)
}

/// The quest's mechanics kinds of high or medium confidence.
fn kinds(mech: Option<&Value>, q: u32) -> Vec<String> {
	let Some(e) = mech.and_then(|m| m.get(q.to_string())) else { return Vec::new() };
	e.get("kinds").and_then(Value::as_array).map_or(Vec::new(), |ks| {
		ks.iter().filter(|k| matches!(k.get("confidence").and_then(Value::as_str), Some("high" | "medium"))).filter_map(|k| k.get("kind").and_then(Value::as_str).map(str::to_string)).collect()
	})
}

/// The item used on NPC `npc` for quest `q`: the use-on-mob params' item for that NPC, else the item of
/// the mechanics' use step on it.
fn use_item(mech: Option<&Value>, q: u32, npc: u32) -> Option<u32> {
	let e = mech?.get(q.to_string())?;
	let id = |v: Option<&Value>| v.and_then(Value::as_u64).map(|x| x as u32);
	let on = |p: &Value| p.get("npcs").and_then(Value::as_array).is_none_or(|a| a.iter().any(|x| id(Some(x)) == Some(npc)));
	let from_params =
		e.get("params").and_then(Value::as_array).and_then(|ps| ps.iter().find(|p| p.get("kind").and_then(Value::as_str) == Some("use-item-on-mob") && on(p)).and_then(|p| id(p.get("item"))));
	from_params.or_else(|| {
		e.get("readSteps")?.as_array()?.iter().find_map(|s| {
			let t = s.get("target")?;
			(s.get("action").and_then(Value::as_str) == Some("use-item") && t.get("type").and_then(Value::as_str) == Some("npc") && id(t.get("id")) == Some(npc))
				.then(|| id(s.get("item")?.get("id")))?
		})
	})
}

#[cfg(test)]
mod tests {
	use super::objective_goals;
	use forge_guide::data::Data;
	use forge_guide::js::V;
	use rustc_hash::FxHashMap;
	use serde_json::json;

	fn data() -> Data {
		let quests = json!({
			"764": { "id": 764, "start": { "npc": [2988], "object": [], "item": [] }, "objectives": [
				{ "type": "kill", "id": 2978, "count": 14 }, { "type": "kill", "id": 2979, "count": 6 } ] },
			"765": { "id": 765, "start": { "npc": [2988], "object": [], "item": [] }, "objectives": [{ "type": "item", "id": 4819, "count": 1 }] },
			"339": { "id": 339, "start": { "npc": [2496], "object": [], "item": [] }, "objectives": [{ "type": "item", "id": 2725, "count": 1 }, { "type": "item", "id": 2728, "count": 1 }] },
			"4285": { "id": 4285, "start": { "npc": [9117], "object": [], "item": [] }, "objectives": [{ "type": "object", "id": 164955, "count": null }] },
			"1786": { "id": 1786, "start": { "npc": [6173], "object": [], "item": [] }, "objectives": [{ "type": "kill", "id": 6172, "count": 1 }] },
			"99411": { "id": 99411, "start": { "npc": [277182], "object": [], "item": [] }, "objectives": [{ "type": "kill", "id": 277154, "count": null }] },
			"1447": { "id": 1447, "start": { "npc": [4961], "object": [], "item": [] }, "objectives": [{ "type": "kill", "id": 4961, "count": null }] },
			"1560": { "id": 1560, "escort": true, "start": { "npc": [5955], "object": [], "item": [] }, "objectives": [{ "type": "kill", "id": 6015, "count": null }] },
			"5929": { "id": 5929, "start": { "npc": [11802], "object": [], "item": [] }, "objectives": [{ "type": "event", "count": 1 }] },
			"4966": { "id": 4966, "start": { "npc": [10638], "object": [], "item": [] }, "objectives": [{ "type": "kill", "id": 10720, "count": null }] },
			"3804": { "id": 3804, "start": { "npc": [11554], "object": [], "item": [] }, "objectives": [{ "type": "item", "id": 11040, "count": 10 }] },
			"8469": { "id": 8469, "start": { "npc": [11556], "object": [], "item": [] }, "objectives": [{ "type": "item", "id": 21383, "count": 5 }] },
			"2": { "id": 2, "start": { "npc": [], "object": [], "item": [16305] }, "objectives": [{ "type": "kill", "id": 2978, "count": 1 }] },
			"974": { "id": 974, "sourceItem": 12472, "start": { "npc": [9272], "object": [], "item": [] }, "objectives": [{ "type": "object", "id": 148503, "count": null }] },
			"4921": { "id": 4921, "start": { "npc": [3432], "object": [], "item": [] }, "objectives": [{ "type": "talk", "id": 10668, "count": 1 }] },
			"92947": { "id": 92947, "start": { "npc": [253844], "object": [], "item": [] }, "objectives": [
				{ "type": "kill", "id": 252762, "count": 7 }, { "type": "kill", "id": 252763, "count": 7 }, { "type": "talk", "id": 253576, "count": 1 } ] }
		});
		let npcs = json!({
			"2978": { "id": 2978, "name": "Venture Co. Worker", "faction": null },
			"2979": { "id": 2979, "name": "Venture Co. Supervisor", "faction": null },
			"6172": { "id": 6172, "name": "Henze Faulk", "faction": "A" },
			"277154": { "id": 277154, "name": "Kyle the Frenzied", "faction": null },
			"4961": { "id": 4961, "name": "Dashel Stonefist", "faction": "A" },
			"6015": { "id": 6015, "name": "Torta", "faction": "AH" },
			"10720": { "id": 10720, "name": "Galak Assassin", "faction": null },
			"10668": { "id": 10668, "name": "Beaten Corpse", "faction": "H" },
			"252762": { "id": 252762, "name": "Al'Aketh Guardian", "faction": null },
			"252763": { "id": 252763, "name": "Al'Aketh Spiritcaller", "faction": null },
			"253576": { "id": 253576, "name": "Hyusaa Quickbreeze", "faction": "AH" }
		});
		// (The pages drop from a hundred kinds of mob, here 30, at about 1% each: one of them 33%.)
		let pages: serde_json::Map<String, serde_json::Value> = (0..30).map(|i| ((587 + i).to_string(), json!(if i == 0 { 33.3 } else { 0.9 }))).collect();
		let items = json!({
			"4819": { "name": "Fizsprocket's Clipboard", "drops": { "npc": { "3051": 100 }, "object": {} }, "vendors": [] },
			"2725": { "name": "Green Hills of Stranglethorn - Page 1", "drops": { "npc": pages, "object": {} }, "vendors": [] },
			"2728": { "name": "Green Hills of Stranglethorn - Page 4", "drops": { "npc": pages, "object": {} }, "vendors": [] },
			"21383": { "name": "Winterfall Spirit Beads", "drops": { "npc": { "7438": 39.1, "10916": 36.4 }, "object": {} }, "vendors": [] },
			"11040": { "name": "Morrowgrain", "drops": { "npc": {}, "object": {} }, "vendors": [] },
			"6866": { "name": "Symbol of Life", "drops": { "npc": {}, "object": {} }, "vendors": [] },
			"287505": { "name": "Tender Strider Meat", "drops": { "npc": { "2956": null }, "object": {} }, "vendors": [] }
		});
		let objects = json!({ "164955": { "id": 164955, "name": "Northern Crystal Pylon" } });
		let mut texts = FxHashMap::default();
		texts.insert("quests".to_string(), quests.to_string());
		texts.insert("npcs".to_string(), npcs.to_string());
		texts.insert("items".to_string(), items.to_string());
		texts.insert("objects".to_string(), objects.to_string());
		Data::from_texts(&texts, V::Null, V::Null, None).unwrap()
	}

	fn mechanics() -> serde_json::Value {
		json!({
			"1786": { "kinds": [{ "kind": "use-item-on-mob", "confidence": "high" }], "params": [{ "kind": "use-item-on-mob", "item": 6866, "npcs": [6172, 6177], "confidence": "high" }] },
			"99411": { "kinds": [{ "kind": "use-item-on-mob", "confidence": "high" }], "params": [], "readSteps": [
				{ "n": 1, "action": "loot", "target": { "type": "item", "id": 287505 }, "item": { "id": 287505 } },
				{ "n": 2, "action": "use-item", "target": { "type": "npc", "id": 277154 }, "item": { "id": 287505 } } ] },
			"4966": { "kinds": [{ "kind": "event-start", "confidence": "high" }] },
			"3804": { "kinds": [{ "kind": "crafted", "confidence": "medium" }] },
			"974": { "kinds": [{ "kind": "use-item-at-place", "confidence": "high" }, { "kind": "use-item-on-mob", "confidence": "high" }] }
		})
	}

	fn run(text: &str, side: char) -> String {
		objective_goals(text, Some(side), &data(), Some(&mechanics())).0
	}

	#[test]
	fn plain_kills_items_and_objects_get_objective_goals() {
		let g = "step The Venture Co. Mine\n  goto 64.9,43.3 \"The Venture Co. Mine\"\n  complete 764\n  complete 765\n";
		assert_eq!(run(g, 'H'), "step The Venture Co. Mine\n  goto 64.9,43.3 \"The Venture Co. Mine\"\n  kill 2978 quest 764.1\n  kill 2979 quest 764.2\n  collect 4819 quest 765.1\n");
		// (The note goes with the first goal; the place and every word after the quest with each.)
		let g = "step Northern Pylon\n  complete 4285 @56.5,12.5 map 1449 era      -- Click the pylon\n";
		assert_eq!(run(g, 'A'), "step Northern Pylon\n  interact 164955 quest 4285.1 @56.5,12.5 map 1449 era -- Click the pylon\n");
		let g = "step Beads for Salfa\n  complete 8469 optional               -- Winterfall furbolgs\n";
		assert_eq!(run(g, 'H'), "step Beads for Salfa\n  collect 21383 quest 8469.1 optional  -- Winterfall furbolgs\n");
	}

	#[test]
	fn an_item_used_on_an_npc_is_a_use_never_a_kill() {
		let g = "step Henze Faulk\n  complete 1786 @72.6,51.41 map 1429 era only Human -- Use the Symbol of Life on Henze Faulk\n  turnin 1786 only Human\n";
		assert_eq!(run(g, 'A'), "step Henze Faulk\n  use 6866 quest 1786.1 @72.6,51.41 map 1429 era only Human -- Use the Symbol of Life on Henze Faulk\n  turnin 1786 only Human\n");
		// (The item from the mechanics' use step when its params name none: Kyle's strider meat.)
		let g = "step Bloodhoof Village\n  complete 99411                      -- Kyle the Frenzied runs around the village\n";
		assert_eq!(run(g, 'H'), "step Bloodhoof Village\n  use 287505 quest 99411.1            -- Kyle the Frenzied runs around the village\n");
	}

	#[test]
	fn talk_objectives_get_talk_and_objectives_tracked_elsewhere_are_not_repeated() {
		let g = "step Bristleback camps\n  complete 4921 @49.3,50.3\n";
		assert_eq!(run(g, 'H'), "step Bristleback camps\n  talk 10668 quest 4921.1 @49.3,50.3\n");
		let g = "step The Shrine of Akir\n  kill 252762 quest 92947.1\n  kill 252763 quest 92947.2\n  complete 92947 @63.77,50.51                 -- Hyusaa Quickbreeze\n";
		assert_eq!(run(g, 'A'), "step The Shrine of Akir\n  kill 252762 quest 92947.1\n  kill 252763 quest 92947.2\n  talk 253576 quest 92947.3 @63.77,50.51      -- Hyusaa Quickbreeze\n");
	}

	#[test]
	fn escorts_events_and_what_the_window_cannot_show_keep_complete() {
		for (g, side) in [
			// an escort (the quest's flag), an event objective, a fight with an NPC friendly to the side
			"step Tooga's escort\n  accept 1560\n  complete 1560\n",
			"step Moonglade\n  complete 5929 @39.1,27.5 -- Speak with the Great Bear Spirit\n",
			"step Dashel Stonefist\n  accept 1447\n  complete 1447\n",
			// a mechanics event (the assassins come for Kanati), an item nothing drops or sells
			"step Whitereach Post\n  complete 4966 @21.25,32.06 map 1441 era -- Kill the Galak Assassin\n",
			"step Bashana Runetotem\n  complete 3804\n",
			// pages every mob of the zone drops now and then
			"step Stranglethorn Vale\n  complete 339 optional               -- Chapter I\n",
			// a quest an item starts
			"step Sharptalon\n  complete 2\n",
			// an object objective done by using an item there (Krakle's Thermometer at the hot spot)
			"step Krakle's Thermometer\n  complete 974\n",
		]
		.iter()
		.map(|g| (*g, 'A'))
		{
			assert_eq!(run(g, side), g);
		}
	}
}
