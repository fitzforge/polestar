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
				o.set("kind", "object");
				o.set("item", item.clone());
				o.set("object", place_of("object", &s.get("object"), codex));
				o.set("chance", nn(s.get("chance")));
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
	let goal_in = entry.get("goal").items();
	let goal: Vec<V> = goal_in
		.iter()
		.filter(|id| {
			if quests.get(&kstr(id)).truthy() {
				return true;
			}
			warn.push(format!("{eid}: goal quest {} is not in the Codex", kstr(id)));
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
		}
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
