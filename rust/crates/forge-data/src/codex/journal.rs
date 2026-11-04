//! tools/lib/codex/journal.js: the Dungeons journal (a page per Codex dungeon and raid) and its
//! pack file Dungeons1.lua. dungeons.json is read only by a --local-extras build.

use std::sync::LazyLock;

use forge_guide::js::{num_str, str_to_num, Obj, V};
use regex::Regex;
use rustc_hash::{FxHashMap, FxHashSet};

use super::client::InstanceMap;
use super::instances::zone_point;
use super::util::{jnorm, jnorm_s, kstr, oentries};

pub const SCHEMA: f64 = 3.0;
const CHAIN_MAX: usize = 20;
const STRAY: f64 = 5.0;

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

fn has_v(list: &[V], x: &V) -> bool {
	list.iter().any(|v| v.strict_eq(x))
}

/// `chainOf(quests, fq, id, side)`.
fn chain_of(cq: &V, fq: &V, id: f64, my_side: &V) -> Vec<V> {
	let mut chain: Vec<V> = Vec::new();
	let mut seen: Vec<V> = vec![V::Num(id)];
	fn visit(qid: &V, cq: &V, fq: &V, my_side: &V, chain: &mut Vec<V>, seen: &mut Vec<V>) {
		let c = cq.get(&kstr(qid));
		let f = fq.get(&kstr(qid));
		let mut list: Vec<V> = Vec::new();
		list.extend(c.get("pre").items());
		list.extend(f.get("pre").items());
		list.extend(f.get("preAll").items());
		list.extend(c.get("preAny").items());
		list.extend(f.get("preAny").items());
		list.extend(f.get("breadcrumbs").items());
		for pre in list {
			if has_v(seen, &pre) || chain.len() >= CHAIN_MAX {
				continue;
			}
			seen.push(pre.clone());
			let p = cq.get(&kstr(&pre));
			let p = if p.truthy() { p } else { fq.get(&kstr(&pre)) };
			if !p.truthy() {
				continue;
			}
			let pside = side(&p.get("faction"));
			if my_side.truthy() && pside.truthy() && !pside.strict_eq(my_side) {
				continue;
			}
			visit(&pre, cq, fq, my_side, chain, seen);
			if chain.len() < CHAIN_MAX {
				chain.push(pre);
			}
		}
	}
	visit(&V::Num(id), cq, fq, my_side, &mut chain, &mut seen);
	chain
}

struct Names<'a> {
	npcs: &'a V,
	items: &'a V,
	objects: &'a V,
}

impl Names<'_> {
	fn of(t: &V, id: &V) -> V {
		let r = t.get(&kstr(id));
		if r.truthy() {
			or_null(r.get("name"))
		} else {
			V::Null
		}
	}
	fn npc(&self, id: &V) -> V {
		Self::of(self.npcs, id)
	}
	fn item(&self, id: &V) -> V {
		Self::of(self.items, id)
	}
	fn object(&self, id: &V) -> V {
		Self::of(self.objects, id)
	}
}

fn objectives_of(objectives: &V, names: &Names) -> V {
	let mut out = Vec::new();
	for o in objectives.items() {
		let ty = o.get("type");
		let k = ty.as_str().unwrap_or("event");
		let id = if k == "event" { V::Null } else { nn(o.get("id")) };
		let mut name = match k {
			"kill" => names.npc(&id),
			"item" => names.item(&id),
			"object" => names.object(&id),
			_ => V::Null,
		};
		if !name.truthy() {
			name = or_null(o.get("text"));
		}
		if !name.truthy() {
			continue;
		}
		let part = Obj::new();
		part.set("k", k);
		if id.truthy() {
			part.set("id", id);
		}
		let count = o.get("count").num();
		if count > 1.0 && k != "object" {
			part.set("n", count);
		}
		part.set("name", name);
		out.push(V::Obj(part));
	}
	if out.is_empty() {
		V::Null
	} else {
		V::from(out)
	}
}

fn place_of(kind: &str, id: &V, codex: &Codex) -> V {
	if !id.truthy() {
		return V::Null;
	}
	let rec = if kind == "object" { codex.objects.get(&kstr(id)) } else { codex.npcs.get(&kstr(id)) };
	if !rec.truthy() {
		return V::Null;
	}
	let s = rec.get("spawns").at(0);
	let o = Obj::new();
	o.set("kind", kind);
	o.set("id", id.clone());
	o.set("name", or_null(rec.get("name")));
	o.set("map", if s.truthy() { s.get("map") } else { V::Null });
	o.set("x", if s.truthy() { s.get("x") } else { V::Null });
	o.set("y", if s.truthy() { s.get("y") } else { V::Null });
	o.set("f", if s.truthy() && s.get("f").as_str() == Some("e") { V::str("e") } else { V::Null });
	o.set("inside", false);
	V::Obj(o)
}

fn rep_of(fq: &V, factions: &V) -> V {
	let r = if fq.truthy() && fq.get("web").truthy() { fq.get("web").get("rep") } else { V::Undef };
	if !r.is_arr() {
		return V::arr();
	}
	V::from(
		r.items()
			.iter()
			.map(|p| {
				let faction = p.at(0);
				let f = factions.get(&kstr(&faction));
				let o = Obj::new();
				o.set("faction", faction);
				o.set("name", if f.truthy() { or_null(f.get("name")) } else { V::Null });
				o.set("value", nn(p.at(1)));
				V::Obj(o)
			})
			.collect::<Vec<V>>(),
	)
}

/// dungeons.json place -> ours.
fn dj_place(p: &V) -> V {
	if !p.truthy() {
		return V::Null;
	}
	let o = Obj::new();
	let kind = p.get("kind");
	o.set("kind", if kind.truthy() { kind } else { V::str("npc") });
	o.set("id", nn(p.get("id")));
	o.set("name", or_null(p.get("name")));
	o.set("map", nn(p.get("map")));
	for k in ["x", "y"] {
		let v = p.get(k);
		o.set(k, if v.is_nullish() { V::Null } else { V::Num(super::util::round1(v.num())) });
	}
	o.set("f", if p.get("f").as_str() == Some("e") { V::str("e") } else { V::Null });
	o.set("inside", p.get("inDungeon").truthy());
	V::Obj(o)
}

/// `given`: a dungeons.json reward row ({ item, name, quality }) whose name and quality come first.
fn reward_item(id: &V, choice: bool, codex: &Codex, given: &V, count: &V) -> V {
	let it = codex.items.get(&kstr(id));
	let o = Obj::new();
	o.set("id", id.clone());
	let gname = given.get("name");
	o.set(
		"name",
		if gname.truthy() {
			gname
		} else if it.truthy() {
			or_null(it.get("name"))
		} else {
			V::Null
		},
	);
	let gq = given.get("quality");
	o.set(
		"quality",
		if !gq.is_nullish() {
			gq
		} else if it.truthy() {
			nn(it.get("quality"))
		} else {
			V::Null
		},
	);
	o.set("choice", choice);
	if count.num() > 1.0 {
		o.set("count", count.clone());
	}
	V::Obj(o)
}

/// The merged Codex the journal reads.
pub struct Codex {
	pub instances: V,
	pub quests: V,
	pub npcs: V,
	pub items: V,
	pub objects: V,
	pub factions: V,
	pub zones: V,
}

pub struct JournalInputs<'a> {
	pub maps: &'a [InstanceMap],
	/// map-frames.json forever frames.
	pub frames: &'a V,
	pub fv_quests: &'a V,
	pub fv_objects: &'a V,
	pub fv_zones: &'a V,
	/// dungeons.json (a --local-extras build; null otherwise).
	pub fv_dungeons: &'a V,
	pub journal_quests: &'a [V],
	pub attunement_table: &'a V,
}

fn match_map<'a>(inst: &V, maps: &'a [InstanceMap]) -> Option<&'a InstanceMap> {
	let n = jnorm(&inst.get("name"));
	let k = jnorm(&inst.get("key"));
	let mut m = maps.iter().find(|x| {
		let xn = jnorm_s(&x.name);
		xn == n || xn == k
	});
	if m.is_none() && inst.get("areaId").truthy() {
		let a = inst.get("areaId").num();
		m = maps.iter().find(|x| x.area == Some(a));
	}
	if m.is_none() {
		m = maps.iter().find(|x| {
			let xn = jnorm_s(&x.name);
			xn.len() > 6 && n.starts_with(&xn)
		});
	}
	m
}

/// An ordered set of strings (JS Set).
fn add_s(v: &mut Vec<String>, s: &str) {
	if !v.iter().any(|x| x == s) {
		v.push(s.to_string());
	}
}

fn live(fq: &V, id: &V) -> bool {
	fq.get(&kstr(id)).get("source").items().iter().any(|s| {
		let s = s.to_js_string();
		s.starts_with("questie") || s.starts_with("recorder")
	})
}

/// `buildJournal(inputs, codex)` -> ({ meta, dungeons }, warnings).
pub fn build_journal(inp: &JournalInputs, codex: &Codex) -> (V, Vec<String>) {
	let mut warnings: Vec<String> = Vec::new();
	let dungeons = build_pages(inp, codex, &mut warnings);
	let cv = {
		let o = Obj::new();
		o.set("instances", codex.instances.clone());
		o.set("quests", codex.quests.clone());
		o.set("npcs", codex.npcs.clone());
		o.set("items", codex.items.clone());
		o.set("objects", codex.objects.clone());
		o.set("factions", codex.factions.clone());
		V::Obj(o)
	};
	let (by_key, att_warnings) = super::attune::attunements_of(&cv, inp.attunement_table);
	let mut attunements = 0;
	for (k, list) in by_key {
		let d = dungeons.get(&k);
		if !d.truthy() {
			continue;
		}
		attunements += list.len();
		d.set("attunement", V::from(list));
	}
	let mut quests = 0;
	let mut entrances = 0;
	for p in dungeons.values() {
		quests += p.get("quests").len();
		if p.get("entrance").truthy() {
			entrances += 1;
		}
	}
	let counts = Obj::new();
	counts.set("dungeons", dungeons.len());
	counts.set("quests", quests);
	counts.set("entrances", entrances);
	counts.set("attunements", attunements);
	let meta = Obj::new();
	meta.set("schema", SCHEMA);
	meta.set("counts", V::Obj(counts));
	let out = Obj::new();
	out.set("meta", V::Obj(meta));
	out.set("dungeons", V::Obj(dungeons));
	warnings.extend(att_warnings);
	(V::Obj(out), warnings)
}

fn build_pages(inp: &JournalInputs, codex: &Codex, warnings: &mut Vec<String>) -> Obj {
	let maps = inp.maps;
	let instances = &codex.instances;
	let cq = &codex.quests;
	let fq = inp.fv_quests;
	let names = Names { npcs: &codex.npcs, items: &codex.items, objects: &codex.objects };
	let inst_entries = oentries(instances);

	let mut map_of: FxHashMap<String, Option<&InstanceMap>> = FxHashMap::default();
	let mut area_keys: FxHashMap<i64, Vec<String>> = FxHashMap::default();
	let mut map_keys: FxHashMap<i64, Vec<String>> = FxHashMap::default();
	for (k, inst) in &inst_entries {
		let m = match_map(inst, maps);
		map_of.insert(k.to_string(), m);
		let mut areas: Vec<f64> = m.map(|m| m.areas.clone()).unwrap_or_default();
		if inst.get("areaId").truthy() {
			let a = inst.get("areaId").num();
			if !areas.contains(&a) {
				areas.push(a);
			}
		}
		for a in areas {
			add_s(area_keys.entry(a as i64).or_default(), k);
		}
		if let Some(m) = m {
			add_s(map_keys.entry(m.id as i64).or_default(), k);
		}
	}
	let stray = |s: &V| {
		let from = s.get("from").items();
		!from.is_empty() && from.iter().all(|f| f.as_str() == Some("web")) && s.get("chance").is_num() && s.get("chance").num() < STRAY
	};
	let mut npc_instance: FxHashMap<String, V> = FxHashMap::default();
	for (id, n) in oentries(&codex.npcs) {
		if n.get("instance").truthy() {
			npc_instance.insert(id.to_string(), n.get("instance"));
		}
	}
	let mut item_instances: FxHashMap<String, Vec<String>> = FxHashMap::default();
	let mut item_links: FxHashMap<String, Vec<String>> = FxHashMap::default();
	let mut item_object_instances: FxHashMap<String, Vec<String>> = FxHashMap::default();
	let mut outside: FxHashSet<String> = FxHashSet::default();
	let mut drop_npcs: FxHashMap<String, Vec<V>> = FxHashMap::default();
	for (id, it) in oentries(&codex.items) {
		let mut out = 0;
		for s in it.get("sources").items() {
			match s.get("type").as_str() {
				Some("drop") => {
					let dn = drop_npcs.entry(id.to_string()).or_default();
					if !has_v(dn, &s.get("npc")) {
						dn.push(s.get("npc"));
					}
					let inst = s.get("instance");
					let key = if inst.truthy() { inst } else { npc_instance.get(&kstr(&s.get("npc"))).cloned().unwrap_or(V::Undef) };
					if key.truthy() {
						let k = key.to_js_string();
						add_s(item_instances.entry(id.to_string()).or_default(), &k);
						if !stray(&s) {
							add_s(item_links.entry(id.to_string()).or_default(), &k);
						}
					} else {
						out += 1;
					}
				}
				Some("object") => {
					let maps = inp.fv_objects.get(&kstr(&s.get("object"))).get("instances").items();
					if maps.is_empty() {
						out += 1;
					}
					if maps.len() != 1 {
						continue;
					}
					for k in map_keys.get(&(maps[0].num() as i64)).cloned().unwrap_or_default() {
						add_s(item_object_instances.entry(id.to_string()).or_default(), &k);
					}
				}
				Some("vendor" | "craft") => out += 1,
				_ => {}
			}
		}
		if out > 0 {
			outside.insert(id.to_string());
		}
	}
	let start_item_keys = |q: &V| -> Vec<String> {
		let mut keys = Vec::new();
		for it in q.get("start").get("item").items() {
			let k = kstr(&it);
			for x in item_instances.get(&k).into_iter().flatten().chain(item_object_instances.get(&k).into_iter().flatten()) {
				add_s(&mut keys, x);
			}
		}
		keys
	};
	let linked = |q: &V| -> Vec<String> {
		let mut keys = start_item_keys(q);
		for o in q.get("objectives").items() {
			let oid = kstr(&o.get("id"));
			if o.get("type").as_str() == Some("kill") {
				if let Some(k) = npc_instance.get(&oid) {
					add_s(&mut keys, &k.to_js_string());
				}
			}
			if o.get("type").as_str() == Some("item") && !outside.contains(&oid) {
				for k in item_links.get(&oid).into_iter().flatten() {
					add_s(&mut keys, k);
				}
			}
		}
		keys
	};
	let count_in = |id: &V, list: &str, it: &V| -> V {
		let w = fq.get(&kstr(id)).get("web");
		let l = if w.truthy() { w.get(list) } else { V::Undef };
		l.items().into_iter().find(|p| p.at(0).strict_eq(it)).map(|p| p.at(1)).unwrap_or(V::Undef)
	};
	let codex_quest = |id: &V| -> V {
		let ids = kstr(id);
		let q = cq.get(&ids);
		let f = fq.get(&ids);
		let f = if f.truthy() { f } else { V::obj() };
		if !q.truthy() && !f.get("title").truthy() {
			return V::Null;
		}
		let src = if q.truthy() { q } else { f.clone() };
		let s = src.get("start");
		let e = src.get("end");
		let pick = |p: &V| {
			let n = place_of("npc", &p.get("npc").at(0), codex);
			if n.truthy() {
				n
			} else {
				place_of("object", &p.get("object").at(0), codex)
			}
		};
		let start = pick(&s);
		let si0 = s.get("item").at(0);
		let start_item = if si0.truthy() {
			let o = Obj::new();
			o.set("id", si0.clone());
			o.set("name", names.item(&si0));
			V::Obj(o)
		} else {
			V::Null
		};
		let wh = f.get("web");
		let faction = side(&src.get("faction"));
		let o = Obj::new();
		o.set("id", str_to_num(&ids));
		o.set("title", or_null(src.get("title")));
		o.set("level", nn(src.get("level")));
		o.set("minLevel", nn(src.get("minLevel")));
		o.set("faction", faction.clone());
		o.set("classes", V::Null);
		o.set("inside", false);
		o.set("shareable", V::Null);
		o.set("objectives", objectives_of(&src.get("objectives"), &names));
		o.set(
			"start",
			if start.truthy() {
				start
			} else if start_item.truthy() {
				let p = Obj::new();
				p.set("kind", "item");
				p.set("id", start_item.get("id"));
				p.set("name", start_item.get("name"));
				for k in ["map", "x", "y", "f"] {
					p.set(k, V::Null);
				}
				p.set("inside", false);
				V::Obj(p)
			} else {
				V::Null
			},
		);
		o.set("finish", pick(&e));
		o.set("startItem", start_item);
		o.set("chain", V::from(chain_of(cq, fq, str_to_num(&ids), &faction)));
		let by = forge_guide::prereqs::closed_by_of(&V::str(&ids), fq);
		if !by.is_empty() {
			o.set("closedBy", super::util::nums(&by));
		}
		let mut ritems: Vec<V> = Vec::new();
		for i in src.get("rewards").items() {
			ritems.push(reward_item(&i, false, codex, &V::Undef, &count_in(id, "items", &i)));
		}
		for i in src.get("choices").items() {
			ritems.push(reward_item(&i, true, codex, &V::Undef, &count_in(id, "choices", &i)));
		}
		let rewards = Obj::new();
		rewards.set("items", V::from(ritems));
		rewards.set("xp", nn(f.get("xp")));
		let money = f.get("rewards").get("money");
		rewards.set(
			"money",
			if !f.get("rewards").truthy() || money.is_nullish() {
				if wh.get("money").truthy() {
					wh.get("money")
				} else {
					V::Null
				}
			} else {
				money
			},
		);
		rewards.set("rep", rep_of(&f, &codex.factions));
		o.set("rewards", V::Obj(rewards));
		o.set("bosses", V::arr());
		V::Obj(o)
	};

	// A quest from dungeons.json, filled from the Codex where it is silent.
	let dj_quest = |q: &V, base: bool| -> V {
		let qid = q.get("id");
		let c = codex_quest(&qid);
		let cg = |k: &str| if c.truthy() { c.get(k) } else { V::Undef };
		let first_nn = |a: V, b: V| if !a.is_nullish() { a } else { nn(b) };
		let rewards = q.get("rewards");
		let o = Obj::new();
		o.set("id", qid.clone());
		let ct = cg("title");
		o.set("title", if ct.truthy() { ct } else { or_null(q.get("title")) });
		o.set("level", first_nn(cg("level"), q.get("level")));
		o.set("minLevel", first_nn(cg("minLevel"), q.get("minLevel")));
		let sd = side(&q.get("faction"));
		o.set("faction", if sd.truthy() { sd } else { or_null(cg("faction")) });
		let classes = q.get("classes");
		o.set("classes", if classes.truthy() && !classes.is_empty() { classes } else { V::Null });
		o.set("inside", q.get("start").truthy() && q.get("start").get("inDungeon").truthy());
		let sh = q.get("shareable");
		o.set("shareable", if matches!(sh, V::Bool(_)) { sh } else { V::Null });
		o.set("objectives", if c.truthy() { c.get("objectives") } else { V::Null });
		let st = dj_place(&q.get("start"));
		o.set(
			"start",
			if st.truthy() {
				st
			} else if c.truthy() {
				c.get("start")
			} else {
				V::Null
			},
		);
		let fi = dj_place(&q.get("end"));
		o.set(
			"finish",
			if fi.truthy() {
				fi
			} else if c.truthy() {
				c.get("finish")
			} else {
				V::Null
			},
		);
		let si = q.get("startItem");
		o.set(
			"startItem",
			if si.truthy() {
				let s = Obj::new();
				s.set("id", si.get("item"));
				let n = si.get("name");
				s.set("name", if n.truthy() { n } else { names.item(&si.get("item")) });
				V::Obj(s)
			} else if c.truthy() {
				c.get("startItem")
			} else {
				V::Null
			},
		);
		o.set("chain", V::from(q.get("chain").items().into_iter().filter(|x| !x.strict_eq(&qid)).collect::<Vec<V>>()));
		let by = forge_guide::prereqs::closed_by_of(&V::str(&kstr(&qid)), fq);
		if !by.is_empty() {
			o.set("closedBy", super::util::nums(&by));
		}
		let mut ritems: Vec<V> = Vec::new();
		for i in rewards.get("items").items() {
			ritems.push(reward_item(&i.get("item"), false, codex, &i, &count_in(&qid, "items", &i.get("item"))));
		}
		for i in rewards.get("choices").items() {
			ritems.push(reward_item(&i.get("item"), true, codex, &i, &count_in(&qid, "choices", &i.get("item"))));
		}
		let cr = cg("rewards");
		let r = Obj::new();
		r.set("items", V::from(ritems));
		r.set("xp", first_nn(q.get("xp"), if c.truthy() { cr.get("xp") } else { V::Undef }));
		r.set("money", first_nn(q.get("money"), if c.truthy() { cr.get("money") } else { V::Undef }));
		r.set("rep", if c.truthy() { cr.get("rep") } else { V::arr() });
		o.set("rewards", V::Obj(r.clone()));
		let bosses = if base { q.get("bosses").items() } else { Vec::new() };
		let bosses = V::from(bosses);
		o.set("bosses", bosses.clone());
		if r.get("items").items().is_empty() && c.truthy() {
			r.set("items", cr.get("items"));
		}
		let sb = q.get("startBoss");
		if base && sb.truthy() && !has_v(&bosses.items(), &sb) {
			bosses.push(sb);
		}
		V::Obj(o)
	};

	// key -> ordered (quest id -> record)
	let mut on_page: Vec<(String, Vec<(f64, V)>)> = inst_entries.iter().map(|(k, _)| (k.to_string(), Vec::new())).collect();
	let page_ix: FxHashMap<String, usize> = on_page.iter().enumerate().map(|(i, (k, _))| (k.clone(), i)).collect();
	let has_q = |list: &Vec<(f64, V)>, id: f64| list.iter().any(|(x, _)| *x == id);

	// 1. dungeons.json.
	let mut dj_by_key: Vec<(String, V)> = Vec::new();
	for d in inp.fv_dungeons.get("dungeons").items() {
		let k = d.get("key").to_js_string();
		match dj_by_key.iter_mut().find(|x| x.0 == k) {
			Some(x) => x.1 = d,
			None => dj_by_key.push((k, d)),
		}
	}
	let mut dj_by_name: Vec<(String, V)> = Vec::new();
	for (_, d) in &dj_by_key {
		let n = jnorm(&d.get("name"));
		match dj_by_name.iter_mut().find(|x| x.0 == n) {
			Some(x) => x.1 = d.clone(),
			None => dj_by_name.push((n, d.clone())),
		}
	}
	let mut dj_of: FxHashMap<String, V> = FxHashMap::default();
	for (pi, (k, inst)) in inst_entries.iter().enumerate() {
		let n = jnorm(&inst.get("name"));
		let d = dj_by_key.iter().find(|x| *x.0 == **k).or_else(|| dj_by_name.iter().find(|x| x.0 == n)).map(|x| x.1.clone());
		let Some(d) = d else { continue };
		for q in d.get("quests").items() {
			if q.get("hidden").truthy() {
				continue;
			}
			let id = q.get("id").num();
			let rec = dj_quest(&q, true);
			match on_page[pi].1.iter_mut().find(|(x, _)| *x == id) {
				Some(e) => e.1 = rec,
				None => on_page[pi].1.push((id, rec)),
			}
		}
		dj_of.insert(k.to_string(), d);
	}

	// 2. by area, link, start item.
	let mut sids: Vec<String> = Vec::new();
	let mut seen_sid: FxHashSet<String> = FxHashSet::default();
	for k in cq.keys().into_iter().chain(fq.keys()) {
		if seen_sid.insert(k.to_string()) {
			sids.push(k.to_string());
		}
	}
	for sid in &sids {
		let id = str_to_num(sid);
		let ids = num_str(id);
		let q = cq.get(&ids);
		let q = if q.truthy() { q } else { fq.get(&ids) };
		if !q.truthy() {
			continue;
		}
		let f = fq.get(&ids);
		let mut by_area: Vec<String> = Vec::new();
		let wz = if live(fq, &V::Num(id)) && f.get("web").truthy() { f.get("web").get("zone") } else { V::Null };
		for area in [f.get("area"), wz] {
			if area.truthy() {
				if let Some(ks) = area_keys.get(&(area.num() as i64)).filter(|_| area.num().fract() == 0.0) {
					for k in ks {
						add_s(&mut by_area, k);
					}
				}
			}
		}
		let by_link = linked(&q);
		let mut keys = by_area;
		if keys.len() > 1 {
			let narrowed: Vec<String> = keys.iter().filter(|k| by_link.contains(k)).cloned().collect();
			if !narrowed.is_empty() {
				keys = narrowed;
			}
		}
		let event = f.get("event").truthy();
		let by_start = if event { Vec::new() } else { start_item_keys(&q) };
		if !keys.is_empty() && by_start.len() <= 2 {
			for k in by_start {
				if !keys.contains(&k) {
					keys.push(k);
				}
			}
		}
		if keys.is_empty() && !event {
			keys = if by_link.len() <= 2 { by_link } else { Vec::new() };
		}
		for k in keys {
			let Some(&pi) = page_ix.get(&k) else { continue };
			if has_q(&on_page[pi].1, id) {
				continue;
			}
			let rec = codex_quest(&V::Num(id));
			if rec.truthy() {
				on_page[pi].1.push((id, rec));
			}
		}
	}
	// 3b. the cited table's quests.
	for r in inp.journal_quests {
		let Some(&pi) = page_ix.get(&r.get("instance").to_js_string()) else { continue };
		let rec = codex_quest(&r.get("quest"));
		let qid = r.get("quest").num();
		if !rec.truthy() {
			warnings.push(format!("journal-quests.json: quest {} is not in the Codex", kstr(&r.get("quest"))));
		} else if !has_q(&on_page[pi].1, qid) {
			on_page[pi].1.push((qid, rec));
		}
	}
	// 4. same-title follow-ups.
	let same_title = |a: &V, b: &V| a.truthy() && b.truthy() && jnorm(a) == jnorm(b);
	let mut followers: FxHashMap<String, Vec<f64>> = FxHashMap::default();
	for (sid, f) in oentries(fq) {
		let c = cq.get(&sid);
		let mut pres: Vec<V> = Vec::new();
		for p in c.get("pre").items().into_iter().chain(f.get("pre").items()).chain(f.get("preAll").items()).chain(c.get("preAny").items()).chain(f.get("preAny").items()) {
			if !has_v(&pres, &p) {
				pres.push(p);
			}
		}
		for p in pres {
			followers.entry(kstr(&p)).or_default().push(str_to_num(&sid));
		}
	}
	for pi in 0..on_page.len() {
		for _round in 0..3 {
			let mut added = 0;
			let snapshot: Vec<V> = on_page[pi].1.iter().map(|(_, r)| r.clone()).collect();
			for p in snapshot {
				let pid = kstr(&p.get("id"));
				let pq = cq.get(&pid);
				let pq = if pq.truthy() { pq } else { fq.get(&pid) };
				let pe = pq.get("end");
				for &id in followers.get(&pid).map(Vec::as_slice).unwrap_or(&[]) {
					if has_q(&on_page[pi].1, id) || !live(fq, &V::Num(id)) {
						continue;
					}
					let ids = num_str(id);
					let q = cq.get(&ids);
					let q = if q.truthy() { q } else { fq.get(&ids) };
					if !q.truthy() || !same_title(&q.get("title"), &p.get("title")) || !q.get("objectives").items().is_empty() {
						continue;
					}
					let qside = side(&q.get("faction"));
					if qside.truthy() && p.get("faction").truthy() && !qside.strict_eq(&p.get("faction")) {
						continue;
					}
					let qs = q.get("start");
					let pen = pe.get("npc").items();
					let peo = pe.get("object").items();
					let at = qs.get("npc").items().iter().any(|n| has_v(&pen, n)) || qs.get("object").items().iter().any(|o| has_v(&peo, o));
					if !at {
						continue;
					}
					let rec = codex_quest(&V::Num(id));
					if rec.truthy() {
						on_page[pi].1.push((id, rec));
						added += 1;
					}
				}
			}
			if added == 0 {
				break;
			}
		}
	}

	let pages = Obj::new();
	let mut keys: Vec<String> = inst_entries.iter().map(|(k, _)| k.to_string()).collect();
	keys.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
	for k in keys {
		let inst = instances.get(&k);
		let m = map_of.get(&k).copied().flatten();
		let ie = inst.get("entrance");
		let mut entrance = if ie.truthy() {
			let o = Obj::new();
			o.set("map", ie.get("map"));
			o.set("x", ie.get("x"));
			o.set("y", ie.get("y"));
			o.set("f", or_null(ie.get("f")));
			if ie.get("A").truthy() {
				o.set("A", ie.get("A"));
			}
			V::Obj(o)
		} else {
			V::Null
		};
		if !entrance.truthy() {
			if let Some(m) = m {
				if let Some(c) = &m.corpse {
					let prefer: Vec<f64> = inp.fv_zones.values().into_iter().filter(|z| z.get("areaId").truthy() && m.zones.contains(&z.get("areaId").num())).map(|z| z.get("id").num()).collect();
					entrance = match zone_point(inp.frames, c.c, c.x, c.y, &prefer) {
						Some((map, x, y)) => {
							let o = Obj::new();
							o.set("map", map);
							o.set("x", x);
							o.set("y", y);
							o.set("f", V::Null);
							V::Obj(o)
						}
						None => V::Null,
					};
				}
			}
		}
		let pi = page_ix[&k];
		let d = dj_of.get(&k);
		let mut quests: Vec<V> = on_page[pi].1.iter().map(|(_, r)| r.clone()).collect();
		quests.sort_by(|a, b| {
			let lv = |q: &V| if q.get("level").truthy() { q.get("level").num() } else { 0.0 };
			let d = lv(a) - lv(b);
			super::util::ord(if d != 0.0 { d } else { a.get("id").num() - b.get("id").num() })
		});
		let chain = Obj::new();
		for q in &quests {
			for cid in q.get("chain").items() {
				if has_q(&on_page[pi].1, cid.num()) || chain.get(&kstr(&cid)).truthy() {
					continue;
				}
				let dq = d.map(|d| d.get("chainQuests").get(&kstr(&cid))).unwrap_or(V::Undef);
				let rec = if dq.truthy() { dj_quest(&dq, false) } else { codex_quest(&cid) };
				if rec.truthy() {
					rec.set("chain", V::arr());
					chain.set(&kstr(&cid), rec);
				}
			}
		}
		// DungeonJournal's bosses take the encounter of the Codex boss of the same name.
		let mut encounter_of: Vec<(String, V)> = Vec::new();
		for b in inst.get("bosses").items() {
			if b.get("encounter").truthy() && b.get("name").truthy() {
				let n = jnorm(&b.get("name"));
				match encounter_of.iter_mut().find(|x| x.0 == n) {
					Some(x) => x.1 = b.get("encounter"),
					None => encounter_of.push((n, b.get("encounter"))),
				}
			}
		}
		let boss_list: Vec<V> = match d {
			Some(d) => d
				.get("bosses")
				.items()
				.into_iter()
				.map(|b| {
					let o = Obj::new();
					o.set("name", b.get("name"));
					o.set("npc", nn(b.get("npc")));
					o.set("level", nn(b.get("level")));
					let n = jnorm(&b.get("name"));
					o.set("encounter", encounter_of.iter().find(|x| x.0 == n).map(|x| x.1.clone()).unwrap_or(V::Null));
					V::Obj(o)
				})
				.collect(),
			None => inst
				.get("bosses")
				.items()
				.into_iter()
				.filter(|b| b.get("name").truthy() && b.get("name").as_str() != Some("Trash"))
				.map(|b| {
					let npc = nn(b.get("npc"));
					let n = codex.npcs.get(&kstr(&npc));
					let o = Obj::new();
					o.set("name", b.get("name"));
					o.set("npc", npc);
					o.set("object", nn(b.get("object")));
					o.set("role", nn(b.get("role")));
					o.set("encounter", nn(b.get("encounter")));
					let items = b.get("items");
					o.set("items", if items.truthy() { items } else { V::arr() });
					o.set("level", if n.truthy() { or_null(n.get("level")) } else { V::Null });
					V::Obj(o)
				})
				.collect(),
		};
		let bosses: Vec<V> = boss_list
			.into_iter()
			.enumerate()
			.map(|(i, b)| {
				let npc = nn(b.get("npc"));
				let object = nn(b.get("object"));
				let items = b.get("items").items();
				let level = b.get("level");
				let mut tied: Vec<V> = Vec::new();
				let add = |tied: &mut Vec<V>, id: &V, how: &str, item: Option<&V>| {
					if tied.iter().any(|t| t.get("id").strict_eq(id) && t.get("how").as_str() == Some(how) && t.get("item").strict_eq(&item.cloned().unwrap_or(V::Undef))) {
						return;
					}
					let t = Obj::new();
					t.set("id", id.clone());
					t.set("how", how);
					if let Some(item) = item.filter(|i| i.truthy()) {
						t.set("item", item.clone());
						t.set("itemName", names.item(item));
					}
					tied.push(V::Obj(t));
				};
				for q in &quests {
					let qid = q.get("id");
					let src = cq.get(&kstr(&qid));
					let src = if src.truthy() { src } else { fq.get(&kstr(&qid)) };
					for o in src.get("objectives").items() {
						let ty = o.get("type");
						let oid = o.get("id");
						if ty.as_str() == Some("kill") && npc.truthy() && oid.strict_eq(&npc) {
							add(&mut tied, &qid, "kill", None);
						}
						if ty.as_str() == Some("item") && npc.truthy() && drop_npcs.get(&kstr(&oid)).is_some_and(|d| has_v(d, &npc)) {
							add(&mut tied, &qid, "item", Some(&oid));
						}
						if ty.as_str() == Some("item") && object.truthy() && has_v(&items, &oid) {
							add(&mut tied, &qid, "item", Some(&oid));
						}
					}
					let si = q.get("startItem");
					if si.truthy() && npc.truthy() && drop_npcs.get(&kstr(&si.get("id"))).is_some_and(|d| has_v(d, &npc)) {
						add(&mut tied, &qid, "starts", Some(&si.get("id")));
					}
					if si.truthy() && object.truthy() && has_v(&items, &si.get("id")) {
						add(&mut tied, &qid, "starts", Some(&si.get("id")));
					}
					if has_v(&q.get("bosses").items(), &b.get("name")) && !tied.iter().any(|t| t.get("id").strict_eq(&qid)) {
						add(&mut tied, &qid, "involved", None);
					}
				}
				let page = Obj::new();
				page.set("order", (i + 1) as f64);
				page.set("name", b.get("name"));
				page.set("npc", npc.clone());
				page.set("level", level);
				page.set("quests", V::from(tied));
				if object.truthy() {
					page.set("object", object.clone());
				}
				let role = b.get("role");
				if role.truthy() {
					page.set("role", role);
				}
				let enc = b.get("encounter");
				if enc.truthy() {
					page.set("encounter", enc);
				}
				V::Obj(page)
			})
			.collect();
		let lv = inst.get("levels");
		let zone = if entrance.truthy() { entrance.get("map") } else { V::Null };
		let zname = if zone.truthy() {
			let z = codex.zones.get(&kstr(&zone));
			let z = if z.truthy() { z } else { inp.fv_zones.get(&kstr(&zone)) };
			if z.truthy() {
				z.get("name")
			} else {
				V::Null
			}
		} else {
			V::Null
		};
		let first_nn = |list: &[V]| list.iter().find(|v| !v.is_nullish()).cloned().unwrap_or(V::Null);
		let page = Obj::new();
		page.set("key", k.as_str());
		let iname = inst.get("name");
		page.set("name", if iname.truthy() { iname } else { V::str(&k) });
		let imap = inst.get("map");
		page.set("map", if !imap.is_nullish() { imap } else { m.map(|m| V::Num(m.id)).unwrap_or(V::Null) });
		page.set("kind", if inst.get("kind").as_str() == Some("raid") || m.is_some_and(|m| m.raid) { "raid" } else { "dungeon" });
		page.set("forever", inst.get("forever").truthy());
		page.set("minLevel", if lv.truthy() { first_nn(&[lv.at(1), lv.at(0)]) } else { V::Null });
		page.set("maxLevel", if lv.truthy() { first_nn(&[lv.at(2), lv.at(1), lv.at(0)]) } else { V::Null });
		page.set("players", m.and_then(|m| m.players).map(V::Num).unwrap_or(V::Null));
		page.set("zone", zone);
		page.set("zoneName", zname);
		page.set("entrance", entrance);
		page.set("quests", V::from(quests));
		page.set("chain", V::Obj(chain));
		page.set("bosses", V::from(bosses));
		pages.set(&k, V::Obj(page));
	}
	pages
}

/// `loadJournalQuests()`: journal-quests.json rows (a malformed row throws); a row's `source` is a
/// URL or a web quest database citation (`super::is_web_citation`).
pub fn load_journal_quests(text: &str) -> Result<Vec<V>, String> {
	let rows = forge_guide::js::parse_json(text)?.get("quests").items();
	static URL: LazyLock<Regex> = LazyLock::new(|| Regex::new(r"^https?://").unwrap());
	for r in &rows {
		let q = r.get("quest");
		let src = r.get("source");
		let cited = if let Some(s) = src.as_str() { URL.is_match(s) } else { super::is_web_citation(&src) };
		if !(q.is_num() && forge_guide::js::is_integer(q.num())) || !r.get("instance").is_str() || !cited {
			return Err(format!("journal-quests.json: bad row {}", forge_guide::js::stringify(r, None)));
		}
	}
	Ok(rows)
}

// ---------------------------------------------------------------------------
// Pack file
// ---------------------------------------------------------------------------

fn lua_str(s: &str) -> String {
	let mut out = String::with_capacity(s.len() + 2);
	out.push('"');
	for c in s.chars() {
		match c {
			'\\' => out.push_str("\\\\"),
			'"' => out.push_str("\\\""),
			'\n' => out.push_str("\\n"),
			'\r' => out.push_str("\\r"),
			c => out.push(c),
		}
	}
	out.push('"');
	out
}

fn is_ident(k: &str) -> bool {
	let mut c = k.chars();
	c.next().is_some_and(|f| f.is_ascii_alphabetic() || f == '_') && c.all(|x| x.is_ascii_alphanumeric() || x == '_')
}

fn lua_key(k: &str) -> String {
	if is_ident(k) {
		k.to_string()
	} else if !k.is_empty() && k.bytes().all(|b| b.is_ascii_digit()) {
		format!("[{k}]")
	} else {
		format!("[{}]", lua_str(k))
	}
}

fn lua(v: &V, out: &mut String) {
	match v {
		V::Undef | V::Null => out.push_str("nil"),
		V::Bool(b) => out.push_str(if *b { "true" } else { "false" }),
		V::Num(n) => out.push_str(&num_str(*n)),
		V::Str(s) => out.push_str(&lua_str(s)),
		V::Arr(a) => {
			out.push('{');
			for (i, x) in a.to_vec().iter().enumerate() {
				if i > 0 {
					out.push(',');
				}
				lua(x, out);
			}
			out.push('}');
		}
		V::Obj(o) => {
			out.push('{');
			let mut firstp = true;
			for (k, x) in o.entries() {
				if x.is_nullish() {
					continue;
				}
				if !firstp {
					out.push(',');
				}
				firstp = false;
				out.push_str(&lua_key(&k));
				out.push('=');
				lua(&x, out);
			}
			out.push('}');
		}
	}
}

fn lua_s(v: &V) -> String {
	let mut s = String::new();
	lua(v, &mut s);
	s
}

fn summary_of(p: &V) -> V {
	let quests = p.get("quests").items();
	let count = |sd: &str| quests.iter().filter(|q| !q.get("faction").truthy() || q.get("faction").as_str() == Some(sd)).count();
	let o = Obj::new();
	o.set("name", p.get("name"));
	o.set("map", p.get("map"));
	o.set("kind", p.get("kind"));
	o.set("forever", if p.get("forever").truthy() { p.get("forever") } else { V::Null });
	o.set("minLevel", p.get("minLevel"));
	o.set("maxLevel", p.get("maxLevel"));
	o.set("players", p.get("players"));
	o.set("zone", p.get("zone"));
	o.set("zoneName", p.get("zoneName"));
	o.set("entrance", p.get("entrance"));
	let q = Obj::new();
	q.set("A", count("A"));
	q.set("H", count("H"));
	o.set("quests", V::Obj(q));
	o.set("bosses", p.get("bosses").len());
	let att = p.get("attunement");
	o.set(
		"attune",
		if att.truthy() && !att.is_empty() {
			let list = att.items();
			let a = Obj::new();
			a.set("A", list.iter().filter(|x| x.get("faction").as_str() != Some("H")).count());
			a.set("H", list.iter().filter(|x| x.get("faction").as_str() != Some("A")).count());
			V::Obj(a)
		} else {
			V::Null
		},
	);
	V::Obj(o)
}

/// `emitJournal(journal)` -> Dungeons1.lua.
pub fn emit_journal(journal: &V) -> String {
	let mut lines: Vec<String> = vec![
		forge_guide::emit::header("lua", "forge data codex", "the sources listed in Meta.lua (tools/lib/codex/journal.js)"),
		"-- Dungeon facts (ids, names, levels, coordinates, amounts). Read by".into(),
		"-- Polestar/Dungeons/Dungeons.lua; each page compiles when opened.".into(),
		String::new(),
		"local D = Polestar and Polestar.Dungeons".into(),
		"if not (D and D.Register) then return end".into(),
		String::new(),
	];
	lines.push(format!("D.Register(\"meta\", {})", lua_s(&journal.get("meta"))));
	lines.push(String::new());
	let dungeons = journal.get("dungeons");
	let mut keys: Vec<String> = dungeons.keys().iter().map(|k| k.to_string()).collect();
	keys.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
	lines.push("D.Register(\"dungeon\", {".into());
	for k in &keys {
		lines.push(format!("{}={},", lua_key(k), lua_s(&summary_of(&dungeons.get(k)))));
	}
	lines.push("}, {".into());
	for k in &keys {
		let p = dungeons.get(k);
		let page = Obj::new();
		for f in ["entrance", "quests", "chain", "bosses", "attunement"] {
			page.set(f, p.get(f));
		}
		lines.push(format!("{}={},", lua_key(k), lua_str(&format!("return {}", lua_s(&V::Obj(page))))));
	}
	lines.push("})".into());
	lines.push(String::new());
	lines.join("\n")
}
