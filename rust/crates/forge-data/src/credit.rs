//! Objectives on the game's placeholder targets (#2614). The quest data names some objectives by the invisible
//! creature the server credits: a "[DNT] Kill Credit" (No Soldier Left Behind's scouts), a bare "Credit" (Eyes of
//! the Sentinels' four owl perches), the battlegrounds' "PvP Tower Credit Marker" and Alterac Valley's "Trigger
//! Ichman". Nobody kills or talks to one: the player frees, uses, assaults or reaches something, and the quest log
//! reads the objective's own words ("Farholde Scouts rescued", "Tower Captured"). So a kill or talk objective on
//! such an NPC becomes an event (its words, no NPC), placed where that NPC stands when it stands at one spot. A
//! placeholder's own text gives way to the name it carries ("[DNT] Kill Credit: Twilight Thrall"); one that
//! carries none needs a correction with the quest log's words, and [`scan`] fails the build until it has one.
//!
//! Applied after the talk rule, to every quest (a correction that sets a kill of a placeholder is no truer).

use forge_guide::js::{Obj, V};
use forge_guide::placeholder::{banned, carried, unused_quest};

/// The one spawn of an NPC record (`spawns = { map: { f, pts } }`): its map, frame, x, y. None for none or several.
fn one_spawn(npc: &V) -> Option<(f64, V, f64, f64)> {
	let mut found = None;
	for (map, s) in npc.get("spawns").entries() {
		for p in s.get("pts").items() {
			if found.is_some() {
				return None;
			}
			found = Some((map.parse::<f64>().ok()?, s.get("f"), p.num_at(0), p.num_at(1)));
		}
	}
	found
}

/// Retypes every kill or talk objective of `quests` whose NPC (`npcs`) has a placeholder name as an event (see
/// the module). -> the quests changed.
pub fn retype(quests: &Obj, npcs: &Obj) -> Vec<String> {
	let mut changed = Vec::new();
	for (id, q) in quests.entries() {
		let mut any = false;
		for o in q.get("objectives").items() {
			if !matches!(o.get("type").as_str(), Some("kill" | "talk")) || o.get("id").is_nullish() {
				continue;
			}
			let npc = npcs.get(&o.get("id").to_js_string());
			let Some(name) = npc.get("name").as_str().map(str::to_string) else { continue };
			if !banned(&name) {
				continue;
			}
			o.set("type", "event");
			o.set("id", V::Null);
			let text = o.get("text").as_str().map(str::to_string);
			match text {
				Some(t) if !banned(&t) => {}
				Some(t) => {
					if let Some(c) = carried(&t).or_else(|| carried(&name)) {
						o.set("text", c);
					}
				}
				None => {
					if let Some(c) = carried(&name) {
						o.set("text", c);
					}
				}
			}
			if o.get("map").is_nullish() {
				if let Some((map, f, x, y)) = one_spawn(&npc) {
					o.set("map", map);
					if !f.is_nullish() {
						o.set("f", f);
					}
					o.set("x", x);
					o.set("y", y);
				}
			}
			any = true;
		}
		if any {
			changed.push(id.to_string());
		}
	}
	changed
}

/// Every placeholder name a player could still read in the built data (#2614), one line each: the titles of
/// the quests in the game (unused and test quests, which Lookup leaves out, aside), their objectives' words,
/// and the names of the NPCs, objects and items those objectives, their givers and enders and the item that
/// starts them point at. A text [`forge_guide::placeholder::ALLOWED`] lists passes.
pub fn scan(quests: &Obj, npcs: &Obj, objects: &Obj, items: &Obj) -> Vec<String> {
	let mut out = Vec::new();
	let name = |kind: &str, id: &V| -> Option<String> {
		let table = match kind {
			"npc" => npcs,
			"object" => objects,
			_ => items,
		};
		table.get(&id.to_js_string()).get("name").as_str().map(str::to_string)
	};
	let mut ids: Vec<(f64, String, V)> = quests.entries().into_iter().map(|(id, q)| (id.parse::<f64>().unwrap_or(f64::MAX), id.to_string(), q)).collect();
	ids.sort_by(|a, b| a.0.total_cmp(&b.0));
	for (_, id, q) in ids {
		let title = q.get("title").as_str().unwrap_or("").to_string();
		if unused_quest(&title) {
			continue;
		}
		let mut hit = |what: String, text: &str| {
			if banned(text) {
				out.push(format!("quest {id} ({title}): {what} \"{text}\""));
			}
		};
		hit("title".into(), &title);
		for (i, o) in q.get("objectives").items().iter().enumerate() {
			if let Some(t) = o.get("text").as_str() {
				hit(format!("objective {} text", i + 1), t);
			}
			let kind = match o.get("type").as_str() {
				Some("kill" | "talk") => "npc",
				Some("object") => "object",
				Some("item") => "item",
				_ => continue,
			};
			if let Some(n) = name(kind, &o.get("id")) {
				hit(format!("objective {} {kind} {}", i + 1, o.get("id").to_js_string()), &n);
			}
		}
		for side in ["start", "end"] {
			for kind in ["npc", "object", "item"] {
				for e in q.get(side).get(kind).items() {
					if let Some(n) = name(kind, &e) {
						hit(format!("{side} {kind} {}", e.to_js_string()), &n);
					}
				}
			}
		}
		if !q.get("sourceItem").is_nullish() {
			if let Some(n) = name("item", &q.get("sourceItem")) {
				hit(format!("source item {}", q.get("sourceItem").to_js_string()), &n);
			}
		}
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::{parse_json, stringify};

	fn obj(s: &str) -> Obj {
		parse_json(s).unwrap().as_obj().unwrap().clone()
	}

	const NPCS: &str = r#"{
		"272737":{"name":"[DNT] Kill Credit","spawns":{"2548":{"f":"l","pts":[[27.6,40.5]]}}},
		"271293":{"name":"[DNT] Kill Credit: Twilight Thrall","spawns":{}},
		"13756":{"name":"PvP Graveyard Credit Marker","spawns":{"1459":{"f":"e","pts":[[42.4,15.6],[49.2,14.8]]}}},
		"14029":{"name":"Trigger Ichman","spawns":{"1459":{"f":"e","pts":[[48,84]]}}},
		"9563":{"name":"Ragged John"}
	}"#;

	#[test]
	fn a_credit_objective_becomes_an_event_in_the_quest_logs_words() {
		// Alterac Valley: the objective's own words stay; one spawn places it, several do not.
		let q = obj(r#"{
			"7301":{"title":"Fallen Sky Lords","objectives":[{"type":"kill","id":14029,"count":1,"text":"Ichman's Location Discovered"}]},
			"7081":{"title":"Alterac Valley Graveyards","objectives":[{"type":"kill","id":13756,"count":1,"text":"Graveyard Assaulted"}]},
			"4224":{"title":"The True Masters","objectives":[{"type":"talk","id":9563,"count":1,"text":"Ragged John"}]}
		}"#);
		let changed = retype(&q, &obj(NPCS));
		assert_eq!(changed, vec!["7081", "7301"]);
		let out = stringify(&V::Obj(q), None);
		assert!(out.contains(r#"{"type":"event","id":null,"count":1,"text":"Ichman's Location Discovered","map":1459,"f":"e","x":48,"y":84}"#), "{out}");
		assert!(out.contains(r#"{"type":"event","id":null,"count":1,"text":"Graveyard Assaulted"}"#), "{out}");
		assert!(out.contains(r#"{"type":"talk","id":9563,"count":1,"text":"Ragged John"}"#), "{out}");
	}

	#[test]
	fn a_placeholder_text_gives_way_to_the_name_it_carries() {
		let q = obj(r#"{
			"94907":{"title":"A Small Favor","objectives":[{"type":"kill","id":271293,"count":1,"text":"[DNT] Kill Credit: Twilight Thrall"}]},
			"94888":{"title":"No Soldier Left Behind","objectives":[{"type":"kill","id":272737,"count":5,"text":"[DNT] Kill Credit"}]}
		}"#);
		retype(&q, &obj(NPCS));
		assert_eq!(q.get("94907").get("objectives").at(0).get("text").as_str(), Some("Twilight Thrall"));
		// Nothing carried: the text stays for the check to find.
		assert_eq!(q.get("94888").get("objectives").at(0).get("text").as_str(), Some("[DNT] Kill Credit"));
		let found = scan(&q, &obj(NPCS), &Obj::new(), &Obj::new());
		assert_eq!(found, vec![r#"quest 94888 (No Soldier Left Behind): objective 1 text "[DNT] Kill Credit""#]);
	}

	#[test]
	fn the_check_reads_what_players_see_and_skips_unused_quests() {
		// The 0.4.0.1 data, before the rule: the objective's text and its NPC's name.
		let q = obj(r#"{
			"98067":{"title":"Eyes of the Sentinels","objectives":[{"type":"kill","id":270418,"count":1,"text":"Credit"}]},
			"241":{"title":"<TEST> HEY MISTER WILSON!","objectives":[]},
			"9411":{"title":"<UNUSED>Infused Bandages","objectives":[{"type":"item","id":23567,"count":1}]},
			"5":{"title":"A Made-up Quest","objectives":[{"type":"item","id":12567,"count":1}],"start":{"object":[148501]}}
		}"#);
		let npcs = obj(r#"{"270418":{"name":"Credit"}}"#);
		let objects = obj(r#"{"148501":{"name":"Corrupted Moonwell Spell Focus (DND)"}}"#);
		let items = obj(r#"{"23567":{"name":"[PH] Silithus PvP Dust [DEP]"},"12567":{"name":"Filled Flasket"}}"#);
		assert_eq!(
			scan(&q, &npcs, &objects, &items),
			vec![
				r#"quest 5 (A Made-up Quest): start object 148501 "Corrupted Moonwell Spell Focus (DND)""#.to_string(),
				r#"quest 98067 (Eyes of the Sentinels): objective 1 text "Credit""#.to_string(),
				r#"quest 98067 (Eyes of the Sentinels): objective 1 npc 270418 "Credit""#.to_string(),
			]
		);
	}
}
