//! tools/lib/codex/attunements.js `attunementsOf`: per Codex instance, its attunements and keys
//! as steps (from the cited table attunements.json and the Codex's quests, items and NPCs).

use forge_guide::js::{Obj, V};
use rustc_hash::FxHashSet;

use super::util::{kstr, or_m1, ord};

const MAX_STEPS: usize = 60;
const MAX_SOURCES: usize = 3;

fn side(v: &V) -> V {
	match v.as_str() {
		Some("Alliance" | "A") => V::str("A"),
		Some("Horde" | "H") => V::str("H"),
		_ => V::Null,
	}
}

fn nn(v: V) -> V {
	if v.is_nullish() {
		V::Null
	} else {
		v
	}
}

fn or_null(v: V) -> V {
	if v.truthy() {
		v
	} else {
		V::Null
	}
}

fn place_of(kind: &str, id: &V, codex: &V) -> V {
	if !id.truthy() {
		return V::Null;
	}
	let rec = codex.get(if kind == "object" { "objects" } else { "npcs" }).get(&kstr(id));
	let s = if rec.truthy() { rec.get("spawns").at(0) } else { V::Undef };
	let o = Obj::new();
	o.set("kind", kind);
	o.set("id", id.clone());
	o.set("name", if rec.truthy() { or_null(rec.get("name")) } else { V::Null });
	o.set("map", if s.truthy() { s.get("map") } else { V::Null });
	o.set("x", if s.truthy() { s.get("x") } else { V::Null });
	o.set("y", if s.truthy() { s.get("y") } else { V::Null });
	o.set("f", if s.truthy() && s.get("f").as_str() == Some("e") { V::str("e") } else { V::Null });
	V::Obj(o)
}

fn item_ref(id: &V, codex: &V) -> V {
	let it = codex.get("items").get(&kstr(id));
	let o = Obj::new();
	o.set("id", id.clone());
	o.set("name", if it.truthy() { or_null(it.get("name")) } else { V::Null });
	V::Obj(o)
}

fn source_steps(item_id: &V, codex: &V, drops: bool, grants: bool) -> Vec<V> {
	let it = codex.get("items").get(&kstr(item_id));
	let mut out = Vec::new();
	if !it.truthy() {
		return out;
	}
	let item = item_ref(item_id, codex);
	let src = it.get("sources").items();
	if drops {
		let mut found: Vec<V> =
			src.iter().filter(|s| (s.get("type").as_str() == Some("drop") && s.get("npc").truthy()) || (s.get("type").as_str() == Some("object") && s.get("object").truthy())).cloned().collect();
		let idof = |s: &V| {
			let n = s.get("npc");
			if n.truthy() {
				n.num()
			} else {
				s.get("object").num()
			}
		};
		found.sort_by(|a, b| {
			let d = or_m1(&b.get("chance")) - or_m1(&a.get("chance"));
			ord(if d != 0.0 && !d.is_nan() { d } else { idof(a) - idof(b) })
		});
		for s in found.iter().take(MAX_SOURCES) {
			let o = Obj::new();
			if s.get("type").as_str() == Some("drop") {
				o.set("kind", "drop");
				o.set("item", item.clone());
				o.set("npc", place_of("npc", &s.get("npc"), codex));
				o.set("chance", nn(s.get("chance")));
				let inst = s.get("instance");
				let ni = codex.get("npcs").get(&kstr(&s.get("npc")));
				o.set(
					"instance",
					if inst.truthy() {
						inst
					} else if ni.truthy() && ni.get("instance").truthy() {
						ni.get("instance")
					} else {
						V::Null
					},
				);
			} else {
				// A chest's instance too (the Black Tome in Shadowfang Keep, Doan's Strongbox), so the guide sends the player
				// to its entrance.
				o.set("kind", "object");
				o.set("item", item.clone());
				o.set("object", place_of("object", &s.get("object"), codex));
				o.set("chance", nn(s.get("chance")));
				let inst = s.get("instance");
				let oi = codex.get("objects").get(&kstr(&s.get("object")));
				o.set(
					"instance",
					if inst.truthy() {
						inst
					} else if oi.truthy() && oi.get("instance").truthy() {
						oi.get("instance")
					} else {
						V::Null
					},
				);
			}
			out.push(V::Obj(o));
		}
	}
	if grants {
		for s in &src {
			if s.get("type").as_str() == Some("rep") && s.get("faction").truthy() && s.get("standing").truthy() {
				out.push(rep_step(&s.get("faction"), &s.get("standing"), codex));
			}
		}
		for s in &src {
			if s.get("type").as_str() == Some("gift") && s.get("npc").truthy() {
				let o = Obj::new();
				o.set("kind", "gift");
				o.set("item", item.clone());
				o.set("npc", place_of("npc", &s.get("npc"), codex));
				out.push(V::Obj(o));
			}
		}
	}
	out
}

fn rep_step(faction: &V, standing: &V, codex: &V) -> V {
	let f = codex.get("factions").get(&kstr(faction));
	let o = Obj::new();
	o.set("kind", "rep");
	o.set("faction", faction.clone());
	o.set("name", if f.truthy() { or_null(f.get("name")) } else { V::Null });
	o.set("standing", standing.clone());
	V::Obj(o)
}

fn first(v: &V) -> V {
	v.at(0)
}

fn quest_step(q: &V, codex: &V, after: &[V], after_any: &[V]) -> V {
	let s = q.get("start");
	let e = q.get("end");
	let start_item = if first(&s.get("item")).truthy() && s.get("npc").items().is_empty() && s.get("object").items().is_empty() { item_ref(&first(&s.get("item")), codex) } else { V::Null };
	let rf = q.get("repFaction");
	let f = if rf.truthy() { codex.get("factions").get(&kstr(&rf)) } else { V::Undef };
	let rep = if rf.truthy() && q.get("repStanding").truthy() {
		let o = Obj::new();
		o.set("faction", rf.clone());
		o.set("name", if f.truthy() { or_null(f.get("name")) } else { V::Null });
		o.set("standing", q.get("repStanding"));
		V::Obj(o)
	} else {
		V::Null
	};
	let place = |p: &V, codex: &V| {
		let n = place_of("npc", &first(&p.get("npc")), codex);
		if n.truthy() {
			n
		} else {
			place_of("object", &first(&p.get("object")), codex)
		}
	};
	let o = Obj::new();
	o.set("kind", "quest");
	o.set("id", q.get("id"));
	o.set("title", or_null(q.get("title")));
	o.set("level", nn(q.get("level")));
	o.set("minLevel", nn(q.get("minLevel")));
	o.set("faction", side(&q.get("faction")));
	let classes = q.get("classes");
	o.set("classes", if classes.is_arr() && !classes.is_empty() { classes } else { V::Null });
	o.set("start", place(&s, codex));
	o.set("finish", place(&e, codex));
	o.set("startItem", start_item);
	o.set("after", V::from(after.to_vec()));
	o.set("afterAny", V::from(after_any.to_vec()));
	o.set("goal", false);
	o.set("rep", rep);
	V::Obj(o)
}

fn entities_of(steps: &[V], codex: &V) -> FxHashSet<String> {
	let quests = codex.get("quests");
	let items = codex.get("items");
	let mut out = FxHashSet::default();
	let mut add = |kind: &str, id: &V| {
		if id.truthy() {
			out.insert(format!("{kind}:{}", kstr(id)));
		}
	};
	for s in steps {
		if s.get("kind").as_str() == Some("quest") {
			let q = quests.get(&kstr(&s.get("id")));
			for e in [q.get("start"), q.get("end")] {
				for id in e.get("npc").items() {
					add("npc", &id);
				}
				for id in e.get("object").items() {
					add("object", &id);
				}
			}
			for o in q.get("objectives").items() {
				match o.get("type").as_str() {
					Some("kill") => add("npc", &o.get("id")),
					Some("object") => add("object", &o.get("id")),
					Some("item") => {
						for src in items.get(&kstr(&o.get("id"))).get("sources").items() {
							match src.get("type").as_str() {
								Some("drop") => add("npc", &src.get("npc")),
								Some("object") => add("object", &src.get("object")),
								_ => {}
							}
						}
					}
					_ => {}
				}
			}
		} else if s.get("npc").truthy() {
			add("npc", &s.get("npc").get("id"));
		} else if s.get("object").truthy() {
			add("object", &s.get("object").get("id"));
		}
	}
	out
}

fn placed_inside(steps: &[V], codex: &V, inside: &[V]) -> V {
	let met = entities_of(steps, codex);
	let instances = codex.get("instances");
	let out: Vec<V> = inside
		.iter()
		.filter(|e| met.contains(&format!("{}:{}", e.get("kind").to_js_string(), kstr(&e.get("id")))) && instances.get(&kstr(&e.get("instance"))).truthy())
		.map(|e| {
			let o = Obj::new();
			o.set("kind", e.get("kind"));
			o.set("id", e.get("id"));
			o.set("instance", e.get("instance"));
			V::Obj(o)
		})
		.collect();
	if out.is_empty() {
		V::Null
	} else {
		V::from(out)
	}
}

fn has_v(list: &[V], x: &V) -> bool {
	list.iter().any(|v| v.strict_eq(x))
}

fn build_one(entry: &V, codex: &V, warn: &mut Vec<String>, inside: &[V]) -> V {
	let quests = codex.get("quests");
	let links = entry.get("links");
	let my_side = side(&entry.get("faction"));
	let eid = entry.get("id").to_js_string();
	let mut steps: Vec<V> = Vec::new();
	let mut seen: Vec<V> = Vec::new();
	let fits = |id: &V| -> bool {
		let q = quests.get(&kstr(id));
		q.truthy() && (my_side.is_nullish() || side(&q.get("faction")).is_nullish() || side(&q.get("faction")).strict_eq(&my_side))
	};
	fn visit(id: &V, quests: &V, links: &V, codex: &V, eid: &str, steps: &mut Vec<V>, seen: &mut Vec<V>, warn: &mut Vec<String>, fits: &dyn Fn(&V) -> bool) {
		if has_v(seen, id) || steps.len() >= MAX_STEPS {
			return;
		}
		seen.push(id.clone());
		let q = quests.get(&kstr(id));
		if !q.truthy() {
			warn.push(format!("{eid}: quest {} is not in the Codex", kstr(id)));
			return;
		}
		let link = links.get(&kstr(id));
		let mut pre: Vec<V> = Vec::new();
		for p in q.get("pre").items().into_iter().chain(if link.truthy() { link.get("pre").items() } else { Vec::new() }) {
			if !has_v(&pre, &p) {
				pre.push(p);
			}
		}
		pre.retain(|p| !p.strict_eq(id) && quests.get(&kstr(p)).truthy());
		let mut any: Vec<V> = q.get("preAny").items().into_iter().filter(|p| !p.strict_eq(id) && quests.get(&kstr(p)).truthy()).collect();
		if any.len() > 1 {
			let mine: Vec<V> = any.iter().filter(|p| fits(p)).cloned().collect();
			if !mine.is_empty() {
				any = mine;
			}
		}
		for p in &pre {
			visit(p, quests, links, codex, eid, steps, seen, warn, fits);
		}
		for p in &any {
			visit(p, quests, links, codex, eid, steps, seen, warn, fits);
		}
		let step = quest_step(&q, codex, &pre, &any);
		let si = step.get("startItem");
		if si.truthy() {
			steps.extend(source_steps(&si.get("id"), codex, true, false));
		}
		steps.push(step);
	}
	// A raid Forever has not opened yet (`open: false`) may have its quests out of the data (Molten Core's,
	// #3392): it builds no guide, without a warning.
	let closed = matches!(entry.get("open"), V::Bool(false));
	let goal_in = entry.get("goal").items();
	let goal: Vec<V> = goal_in
		.iter()
		.filter(|id| {
			if quests.get(&kstr(id)).truthy() {
				return true;
			}
			if !closed {
				warn.push(format!("{eid}: goal quest {} is not in the Codex", kstr(id)));
			}
			false
		})
		.cloned()
		.collect();
	if !goal_in.is_empty() && goal.is_empty() {
		return V::Null;
	}
	for id in &goal {
		visit(id, &quests, &links, codex, &eid, &mut steps, &mut seen, warn, &fits);
	}
	for s in &steps {
		if s.get("kind").as_str() == Some("quest") && has_v(&goal, &s.get("id")) {
			s.set("goal", true);
			// `onAccept`: the quest hands over the item as it is taken and takes it back if it is dropped
			// (Heart of Disruption's Dalaran Sewer Key): the chain ends at the accept.
			if entry.get("onAccept").truthy() {
				s.set("accept", true);
			}
		}
	}
	// `via`: the item the goal item is made from, by a use the steps can't show (#2338: the Sacred Mallet, used at
	// Jintha'Alor's altar, becomes the Mallet of Zul'Farrak). Its drops and chests come first; the note says how it
	// turns into the goal item. `useAt` names the NPC standing where it is used (Archmage Ataeric by the Ambermill
	// Leyline Focus, where the Black Tome becomes the Tome of Dalaran): a use step there follows the drops.
	let via = entry.get("via");
	let use_at = entry.get("useAt");
	if via.truthy() {
		if !codex.get("items").get(&kstr(&via)).truthy() {
			warn.push(format!("{eid}: via item {} is not in the Codex", kstr(&via)));
		}
		steps.extend(source_steps(&via, codex, true, false));
		if use_at.truthy() {
			let kind = if use_at.get("kind").as_str() == Some("object") { "object" } else { "npc" };
			let at = place_of(kind, &use_at.get("id"), codex);
			if at.truthy() && !at.get("map").is_nullish() {
				let o = Obj::new();
				o.set("kind", "use");
				o.set("from", item_ref(&via, codex));
				o.set("item", item_ref(&entry.get("item"), codex));
				o.set("at", at);
				steps.push(V::Obj(o));
			} else {
				warn.push(format!("{eid}: useAt {} {} has no spawn in the Codex", use_at.get("kind").to_js_string(), kstr(&use_at.get("id"))));
			}
		}
	} else if use_at.truthy() {
		warn.push(format!("{eid}: useAt without via"));
	}
	let item = entry.get("item");
	if item.truthy() {
		if !codex.get("items").get(&kstr(&item)).truthy() {
			warn.push(format!("{eid}: item {} is not in the Codex", kstr(&item)));
		}
		steps.extend(source_steps(&item, codex, goal.is_empty(), true));
	}
	if steps.is_empty() {
		warn.push(format!("{eid}: no steps"));
		return V::Null;
	}
	let it = if item.truthy() { codex.get("items").get(&kstr(&item)) } else { V::Undef };
	let mut level: Option<f64> = if it.truthy() && it.get("reqLevel").truthy() { Some(it.get("reqLevel").num()) } else { None };
	let mut goal_levels: Vec<f64> = Vec::new();
	for s in &steps {
		if s.get("kind").as_str() != Some("quest") || !s.get("minLevel").truthy() {
			continue;
		}
		let ml = s.get("minLevel").num();
		if s.get("goal").truthy() {
			goal_levels.push(ml);
		} else {
			level = Some(level.unwrap_or(0.0).max(ml));
		}
	}
	if !goal_levels.is_empty() {
		let g = if entry.get("any").truthy() { goal_levels.iter().copied().fold(f64::INFINITY, f64::min) } else { goal_levels.iter().copied().fold(f64::NEG_INFINITY, f64::max) };
		let base = level.filter(|l| *l != 0.0).unwrap_or(0.0);
		level = Some(base.max(g));
	}
	let o = Obj::new();
	o.set("id", entry.get("id"));
	o.set("name", entry.get("name"));
	let kind = entry.get("kind");
	o.set("kind", if matches!(kind.as_str(), Some("attunement" | "key" | "item")) { kind } else { V::str("attunement") });
	o.set("need", if entry.get("need").as_str() == Some("one") { "one" } else { "each" });
	o.set("faction", my_side.clone());
	o.set(
		"item",
		if item.truthy() {
			let io = Obj::new();
			io.set("id", item.clone());
			let n = if it.truthy() { it.get("name") } else { V::Undef };
			io.set("name", if n.truthy() { n } else { or_null(entry.get("name")) });
			io.set("quality", if it.truthy() { nn(it.get("quality")) } else { V::Null });
			V::Obj(io)
		} else {
			V::Null
		},
	);
	o.set("note", or_null(entry.get("note")));
	o.set("level", level.map(V::Num).unwrap_or(V::Null));
	o.set("any", entry.get("any").truthy());
	// `open: false`: a raid Forever has not opened yet (Molten Core, Blackwing Lair, Naxxramas at launch, #3695);
	// the Attunements page and the guide say so. Absent while it is open.
	if matches!(entry.get("open"), V::Bool(false)) {
		o.set("open", false);
	}
	o.set("goal", V::from(goal));
	let inside_v = placed_inside(&steps, codex, inside);
	o.set("steps", V::from(steps));
	o.set("inside", inside_v);
	V::Obj(o)
}

/// `attunementsOf(codex, { table })` -> (byKey entries in first-seen order, warnings).
pub fn attunements_of(codex: &V, table: &V) -> (Vec<(String, Vec<V>)>, Vec<String>) {
	let mut warnings = Vec::new();
	let mut by_key: Vec<(String, Vec<V>)> = Vec::new();
	let instances = codex.get("instances");
	let inside = table.get("inside").items();
	for entry in table.get("attunements").items() {
		let k = entry.get("key").to_js_string();
		if !instances.get(&k).truthy() {
			continue;
		}
		let a = build_one(&entry, codex, &mut warnings, &inside);
		if a.truthy() {
			match by_key.iter_mut().find(|(x, _)| *x == k) {
				Some(e) => e.1.push(a),
				None => by_key.push((k, vec![a])),
			}
		}
	}
	(by_key, warnings)
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::parse_json;

	// #2338: the Mallet of Zul'Farrak drops nowhere; it is the Sacred Mallet (Qiaga the Keeper's drop) used at
	// Jintha'Alor's altar. Without `via` the entry had no steps and was left out; with it, the page and its guide
	// lead to Qiaga, and the entry stays done by the goal item.
	#[test]
	fn an_item_made_from_another_lists_that_one_s_drops_via_2338() {
		let codex = parse_json(
			r#"{ "quests": {}, "instances": { "zulfarrak": {} },
				"items": { "9240": { "name": "Mallet of Zul'Farrak", "quality": 2, "sources": [] },
					"9241": { "name": "Sacred Mallet", "quality": 1, "sources": [{ "type": "drop", "npc": 7996, "chance": 100 }] } },
				"npcs": { "7996": { "name": "Qiaga the Keeper", "spawns": [{ "map": 1425, "x": 48.6, "y": 68.2, "f": "e" }] } } }"#,
		)
		.unwrap();
		let table = |via: &str| {
			parse_json(&format!(r#"{{ "attunements": [{{ "key": "zulfarrak", "id": "mallet", "name": "Mallet of Zul'Farrak", "kind": "item", "need": "one", "item": 9240{via}, "note": "n" }}] }}"#))
				.unwrap()
		};

		let (by_key, warnings) = attunements_of(&codex, &table(""));
		assert!(by_key.is_empty(), "no steps without via");
		assert_eq!(warnings, vec!["mallet: no steps".to_string()]);

		let (by_key, warnings) = attunements_of(&codex, &table(r#", "via": 9241"#));
		assert!(warnings.is_empty(), "{warnings:?}");
		let a = &by_key[0].1[0];
		assert_eq!(a.get("item").get("id").num(), 9240.0);
		let steps = a.get("steps").items();
		assert_eq!(steps.len(), 1);
		assert_eq!(steps[0].get("kind").as_str(), Some("drop"));
		assert_eq!(steps[0].get("item").get("id").num(), 9241.0);
		assert_eq!(steps[0].get("npc").get("id").num(), 7996.0);
		assert_eq!(steps[0].get("npc").get("map").num(), 1425.0);
	}

	// The Tome of Dalaran drops nowhere: the Black Tome from Shadowfang Keep, used at the Ambermill Leyline Focus
	// by Archmage Ataeric, becomes it. `useAt` adds that use, at Ataeric's spawn, after the Black Tome's chest.
	#[test]
	fn use_at_adds_a_use_of_the_via_item_where_the_named_npc_stands() {
		let codex = parse_json(
			r#"{ "quests": {}, "instances": { "city-of-dalaran": {} },
				"items": { "275989": { "name": "Tome of Dalaran", "quality": 2, "sources": [] },
					"276561": { "name": "Black Tome", "quality": 1, "sources": [{ "type": "object", "object": 659376, "instance": "shadowfang-keep" }] } },
				"objects": { "659376": { "name": "Black Tome", "spawns": [] } },
				"npcs": { "2120": { "name": "Archmage Ataeric", "spawns": [{ "map": 1421, "x": 63.4, "y": 64.3, "f": "e" }] },
					"9": { "name": "Nowhere", "spawns": [] } } }"#,
		)
		.unwrap();
		let table = |use_at: &str| {
			parse_json(&format!(
				r#"{{ "attunements": [{{ "key": "city-of-dalaran", "id": "tome", "name": "Tome of Dalaran", "kind": "item", "need": "one", "item": 275989, "via": 276561{use_at}, "note": "n" }}] }}"#
			))
			.unwrap()
		};
		let (by_key, warnings) = attunements_of(&codex, &table(r#", "useAt": { "kind": "npc", "id": 2120 }"#));
		assert!(warnings.is_empty(), "{warnings:?}");
		let steps = by_key[0].1[0].get("steps").items();
		assert_eq!(steps.iter().map(|s| s.get("kind").to_js_string()).collect::<Vec<_>>(), vec!["object", "use"]);
		assert_eq!(steps[0].get("instance").as_str(), Some("shadowfang-keep"), "the chest's instance, for its entrance");
		let use_step = &steps[1];
		assert_eq!((use_step.get("from").get("id").num(), use_step.get("item").get("id").num()), (276561.0, 275989.0));
		assert_eq!(use_step.get("at").get("name").as_str(), Some("Archmage Ataeric"));
		assert_eq!((use_step.get("at").get("map").num(), use_step.get("at").get("x").num()), (1421.0, 63.4));

		let (by_key, warnings) = attunements_of(&codex, &table(r#", "useAt": { "kind": "npc", "id": 9 }"#));
		assert_eq!(warnings, vec!["tome: useAt npc 9 has no spawn in the Codex".to_string()]);
		assert_eq!(by_key[0].1[0].get("steps").items().len(), 1, "the chest stays, no use without a place");
	}

	// Heart of Disruption hands over the Dalaran Sewer Key as it is taken and takes it back if it is dropped:
	// with `onAccept` its goal step says `accept`, the steps before it do not.
	#[test]
	fn on_accept_marks_the_goal_steps_as_ending_at_their_accept() {
		let codex = parse_json(
			r#"{ "instances": { "city-of-dalaran": {} },
				"quests": { "1": { "id": 1, "title": "Blood in the Streets", "pre": [], "preAny": [], "start": { "npc": [], "object": [], "item": [] }, "end": { "npc": [], "object": [] } },
					"2": { "id": 2, "title": "Heart of Disruption", "pre": [], "preAny": [1], "start": { "npc": [], "object": [], "item": [] }, "end": { "npc": [], "object": [] } } },
				"items": { "277507": { "name": "Dalaran Sewer Key", "quality": 2, "sources": [] } }, "npcs": {} }"#,
		)
		.unwrap();
		let table = |on: &str| {
			parse_json(&format!(
				r#"{{ "attunements": [{{ "key": "city-of-dalaran", "id": "sewer-key", "name": "Dalaran Sewer Key", "kind": "key", "need": "one", "item": 277507, "goal": [2]{on}, "note": "n" }}] }}"#
			))
			.unwrap()
		};
		let (by_key, warnings) = attunements_of(&codex, &table(r#", "onAccept": true"#));
		assert!(warnings.is_empty(), "{warnings:?}");
		let steps = by_key[0].1[0].get("steps").items();
		assert_eq!(steps.iter().map(|s| (s.get("id").num(), s.get("accept").truthy())).collect::<Vec<_>>(), vec![(1.0, false), (2.0, true)]);
		let (by_key, _) = attunements_of(&codex, &table(""));
		assert!(!by_key[0].1[0].get("steps").items()[1].get("accept").truthy(), "without onAccept the goal is the whole quest");
	}

	// #3695: Molten Core, Blackwing Lair and Naxxramas are not open on Forever yet. `open: false` in the table rides
	// through to the attunement (the Attunements page and the guide say so); an open one carries no `open` at all.
	#[test]
	fn open_false_marks_a_raid_not_open_yet_and_an_open_one_carries_nothing() {
		let codex = parse_json(
			r#"{ "instances": { "molten-core": {} },
				"quests": { "7848": { "id": 7848, "title": "Attunement to the Core", "pre": [], "preAny": [], "start": { "npc": [], "object": [], "item": [] }, "end": { "npc": [], "object": [] } } },
				"items": {}, "npcs": {} }"#,
		)
		.unwrap();
		let table = |open: &str| {
			parse_json(&format!(
				r#"{{ "attunements": [{{ "key": "molten-core", "id": "core", "name": "Attunement to the Core", "kind": "attunement", "need": "each", "goal": [7848]{open}, "note": "n" }}] }}"#
			))
			.unwrap()
		};
		let (by_key, warnings) = attunements_of(&codex, &table(r#", "open": false, "openSource": "s""#));
		assert!(warnings.is_empty(), "{warnings:?}");
		assert!(matches!(by_key[0].1[0].get("open"), V::Bool(false)));
		let (by_key, _) = attunements_of(&codex, &table(""));
		assert!(matches!(by_key[0].1[0].get("open"), V::Undef), "open: no field");
		let (by_key, _) = attunements_of(&codex, &table(r#", "open": true"#));
		assert!(matches!(by_key[0].1[0].get("open"), V::Undef), "open: true is the same as none");
	}

	// #3392: the 0.4.3 data took Molten Core's attunement quests out while the raid is closed. A closed raid whose goal
	// quests the Codex lacks builds no attunement and warns about nothing; an open one still warns.
	#[test]
	fn a_closed_raid_whose_goal_quests_are_out_of_the_data_builds_nothing_without_a_warning() {
		let codex = parse_json(r#"{ "instances": { "molten-core": {} }, "quests": {}, "items": {}, "npcs": {} }"#).unwrap();
		let table = |open: &str| {
			parse_json(&format!(
				r#"{{ "attunements": [{{ "key": "molten-core", "id": "core", "name": "Attunement to the Core", "kind": "attunement", "need": "each", "goal": [7848]{open}, "note": "n" }}] }}"#
			))
			.unwrap()
		};
		let (by_key, warnings) = attunements_of(&codex, &table(r#", "open": false, "openSource": "s""#));
		assert!(warnings.is_empty(), "{warnings:?}");
		assert!(by_key.iter().all(|(_, l)| l.is_empty()), "no attunement built");
		let (_, warnings) = attunements_of(&codex, &table(""));
		assert_eq!(warnings, vec!["core: goal quest 7848 is not in the Codex".to_string()]);
	}
}
