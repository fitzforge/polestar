//! tools/lib/codex/parity.js `compareCodex` + `summary`: the release Codex against the last
//! `--local-extras` build, kind by kind, as meta.json's `parity` records it. Only the counts the
//! summary keeps are computed (the rows of data/local/codex-parity.json/.md are not written).

use std::collections::BTreeMap;

use forge_guide::js::{str_to_num, Obj, V};
use rustc_hash::{FxHashMap, FxHashSet};

use super::util::{hypot, kstr, math_round, norm, oentries};

const POS_TOLERANCE: f64 = 3.0;
const LEVEL_TOLERANCE: f64 = 2.0;
const CHANCE_TOLERANCE: f64 = 0.25;
const SOURCE_TYPES: [&str; 10] = ["drop", "vendor", "quest", "gift", "craft", "rep", "pvp", "container", "object", "world"];
const FILES: [&str; 7] = ["meta", "items", "npcs", "objects", "quests", "instances", "journal"];

/// `readCodex(dir)`.
pub fn read_codex(dir: &std::path::Path) -> Result<FxHashMap<&'static str, V>, String> {
	let mut out = FxHashMap::default();
	for f in FILES {
		let file = dir.join(format!("{f}.json"));
		let v = if file.exists() { forge_guide::js::parse_json(&std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?)? } else { V::obj() };
		out.insert(f, v);
	}
	Ok(out)
}

/// What checks an internal-only fact (build.js `verifyOf`).
pub struct Verify {
	pub web: V,
	pub client_instances: FxHashSet<String>,
	pub instance_areas: Option<FxHashSet<i64>>,
}

/// A missing row: id and its verdict inputs.
struct Missing {
	id: String,
	verdict: &'static str,
}

#[derive(Default)]
struct Kind {
	total: usize,
	matched: usize,
	missing: Vec<String>,
	verdicts: Vec<Missing>,
	ours_only: Option<usize>,
	confirmed: usize,
	not_in_forever: usize,
	unverified: usize,
	cut: Option<usize>,
	not_boss: Option<usize>,
}

fn near(a: &V, b: &V, tol: f64) -> bool {
	a.truthy() && b.truthy() && a.get("map").num() == b.get("map").num() && hypot(a.get("x").num() - b.get("x").num(), a.get("y").num() - b.get("y").num()) <= tol
}

const ALIASES: [(&str, &str); 8] = [
	("stockade", "stormwind-stockade"),
	("onyxia", "onyxias-lair"),
	("the-temple-of-atalhakkar", "sunken-temple"),
	("the-ruinsof-ahn-qiraj", "ruins-of-ahnqiraj"),
	("the-templeof-ahn-qiraj", "ahnqiraj-temple"),
	("lower-blackrock-spire", "blackrock-spire"),
	("upper-blackrock-spire", "blackrock-spire"),
	("hall-of-thanes", "the-hall-of-thanes"),
];

fn map_instances(ours: &V, theirs: &V) -> Vec<(String, Option<String>)> {
	let mut by_area: FxHashMap<String, String> = FxHashMap::default();
	let mut by_name: Vec<(String, String)> = Vec::new();
	for (k, i) in oentries(ours) {
		if i.get("areaId").truthy() {
			by_area.insert(kstr(&i.get("areaId")), k.to_string());
		}
		let n = norm(&i.get("name"));
		match by_name.iter_mut().find(|(x, _)| *x == n) {
			Some(e) => e.1 = k.to_string(),
			None => by_name.push((n, k.to_string())),
		}
	}
	let mut out = Vec::new();
	for (k, i) in oentries(theirs) {
		let mut o: Option<String> = ALIASES.iter().find(|(a, _)| *a == &*k).map(|(_, b)| b.to_string()).filter(|b| ours.get(b).truthy());
		if o.is_none() && ours.get(&k).truthy() {
			o = Some(k.to_string());
		}
		let n = norm(&i.get("name"));
		if o.is_none() {
			o = by_name.iter().find(|(x, _)| *x == n).map(|(_, v)| v.clone());
		}
		if o.is_none() && i.get("areaId").truthy() {
			o = by_area.get(&kstr(&i.get("areaId"))).cloned();
		}
		if o.is_none() {
			let hit: Vec<&(String, String)> = by_name.iter().filter(|(on, _)| on.len() >= 6 && n.starts_with(on.as_str())).collect();
			if hit.len() == 1 {
				o = Some(hit[0].1.clone());
			}
		}
		out.push((k.to_string(), o));
	}
	out
}

fn boss_key(b: &V) -> String {
	if b.get("npc").truthy() {
		format!("n{}", kstr(&b.get("npc")))
	} else {
		format!("s{}", norm(&b.get("name")))
	}
}

fn verdict_of(kind: &str, id: &str, verify: Option<&Verify>, theirs_instances: &V) -> &'static str {
	let Some(verify) = verify else { return "unverified" };
	let wh = &verify.web;
	let parts: Vec<&str> = id.split('/').collect();
	let a = parts.first().copied().unwrap_or("");
	let b = parts.get(1).copied().unwrap_or("undefined");
	let c = parts.get(2).copied().unwrap_or("undefined");
	let drops_has = |w: &V, item: &str| w.get("drops").items().iter().any(|d| matches!(d.get("item"), V::Num(n) if n == str_to_num(item)));
	match kind {
		"instances" => {
			if verify.client_instances.contains(&norm(&theirs_instances.get(a).get("name"))) {
				"confirmed"
			} else {
				"not in Forever"
			}
		}
		"rares" | "rare positions" | "rare levels" => {
			let w = wh.get("npc").get(a);
			if !w.truthy() {
				return "unverified";
			}
			if kind == "rares" {
				let cl = w.get("classification");
				return if matches!(cl.as_str(), Some("rare" | "rareelite")) { "confirmed" } else { "not in Forever" };
			}
			if !w.get("spawns").keys().is_empty() {
				"confirmed"
			} else {
				"not in Forever"
			}
		}
		"bosses" => {
			let w = wh.get("npc").get(b);
			if !w.truthy() {
				return "unverified";
			}
			if !w.get("drops").items().is_empty() || !w.get("spawns").keys().is_empty() || w.get("classification").truthy() {
				"confirmed"
			} else {
				"not in Forever"
			}
		}
		"boss loot items" | "rare loot" | "drop chances" => {
			let (npc, item) = match kind {
				"boss loot items" => (b, c),
				"rare loot" => (a, b),
				_ => (b, a),
			};
			let w = wh.get("npc").get(npc);
			if !w.truthy() {
				return "unverified";
			}
			if drops_has(&w, item) {
				"confirmed"
			} else {
				"not in Forever"
			}
		}
		"items: rep" => {
			let t = wh.get("item").get(a);
			if !t.truthy() {
				return "unverified";
			}
			if !t.get("rep").items().is_empty() {
				"confirmed"
			} else {
				"unverified"
			}
		}
		"items: pvp" => {
			let t = wh.get("item").get(a);
			if !t.truthy() {
				return "unverified";
			}
			if t.get("pvpRank").truthy() {
				"confirmed"
			} else {
				"not in Forever"
			}
		}
		"treasure loot" => {
			let w = wh.get("object").get(a);
			if !w.truthy() {
				return "unverified";
			}
			if drops_has(&w, b) {
				"confirmed"
			} else {
				"not in Forever"
			}
		}
		_ => "unverified",
	}
}

/// Ours: the merged Codex plus the journal and the evidence (cut, noPvp).
pub struct Ours<'a> {
	pub instances: &'a V,
	pub items: &'a V,
	pub npcs: &'a V,
	pub objects: &'a V,
	pub journal: &'a V,
	pub no_pvp: &'a [f64],
	pub cut_drop: &'a V,
	pub cut_rare: &'a V,
	pub cut_treasure: &'a V,
}

/// `summary(compareCodex(ours, theirs, verify))`.
pub fn compare_summary(ours: &Ours, theirs: &FxHashMap<&'static str, V>, verify: Option<&Verify>) -> V {
	let mut kinds: Vec<(String, Kind)> = Vec::new();
	fn k<'a>(kinds: &'a mut Vec<(String, Kind)>, name: &str) -> &'a mut Kind {
		if let Some(i) = kinds.iter().position(|(n, _)| n == name) {
			return &mut kinds[i].1;
		}
		kinds.push((name.to_string(), Kind::default()));
		&mut kinds.last_mut().unwrap().1
	}
	let oi = ours.instances;
	let ti = theirs.get("instances").cloned().unwrap_or_else(V::obj);
	let instance_map = map_instances(oi, &ti);
	let o_items = ours.items;
	let t_items = theirs.get("items").cloned().unwrap_or_else(V::obj);
	let o_npcs = ours.npcs;
	let no_pvp: FxHashSet<u64> = ours.no_pvp.iter().map(|x| x.to_bits()).collect();
	let t_npcs = theirs.get("npcs").cloned().unwrap_or_else(V::obj);
	let mapped = |key: &str| instance_map.iter().find(|(k, _)| k == key).and_then(|(_, o)| o.clone());

	// ----- instances
	for (key, t) in oentries(&ti) {
		let ok = mapped(&key);
		let o = ok.as_ref().map(|k| oi.get(k)).filter(V::truthy);
		k(&mut kinds, "instances").total += 1;
		let Some(o) = o else {
			k(&mut kinds, "instances").missing.push(key.to_string());
			continue;
		};
		k(&mut kinds, "instances").matched += 1;
		let tl = t.get("levels");
		if tl.truthy() {
			k(&mut kinds, "instance levels").total += 1;
			let ol = o.get("levels");
			let same = ol.truthy() && tl.items().iter().enumerate().all(|(i, v)| v.is_nullish() || (!ol.at(i).is_nullish() && (ol.at(i).num() - v.num()).abs() <= LEVEL_TOLERANCE));
			if same || ol.truthy() {
				k(&mut kinds, "instance levels").matched += 1;
			} else {
				k(&mut kinds, "instance levels").missing.push(key.to_string());
			}
		}
		if t.get("entrance").truthy() {
			k(&mut kinds, "instance entrances").total += 1;
			if near(&o.get("entrance"), &t.get("entrance"), POS_TOLERANCE) {
				k(&mut kinds, "instance entrances").matched += 1;
			} else if !o.get("entrance").truthy() {
				k(&mut kinds, "instance entrances").missing.push(key.to_string());
			}
		}
		let mut ob: FxHashMap<String, V> = FxHashMap::default();
		for b in o.get("bosses").items() {
			ob.insert(boss_key(&b), b.clone());
			ob.insert(format!("s{}", norm(&b.get("name"))), b.clone());
			let chest = if b.get("object").truthy() { ours.objects.get(&kstr(&b.get("object"))) } else { V::Undef };
			if chest.truthy() && chest.get("name").truthy() {
				let ck = format!("s{}", norm(&chest.get("name")));
				ob.entry(ck).or_insert(b.clone());
			}
		}
		for b in t.get("bosses").items() {
			if !b.get("name").truthy() || norm(&b.get("name")) == "trash" {
				continue;
			}
			let bid = format!("{key}/{}", if b.get("npc").truthy() { kstr(&b.get("npc")) } else { norm(&b.get("name")) });
			k(&mut kinds, "bosses").total += 1;
			let mine = ob.get(&boss_key(&b)).or_else(|| ob.get(&format!("s{}", norm(&b.get("name"))))).cloned();
			let Some(mine) = mine else {
				k(&mut kinds, "bosses").missing.push(bid);
				continue;
			};
			k(&mut kinds, "bosses").matched += 1;
			let bitems = b.get("items").items();
			if !bitems.is_empty() {
				k(&mut kinds, "bosses with loot").total += 1;
				if !mine.get("items").items().is_empty() {
					k(&mut kinds, "bosses with loot").matched += 1;
				} else {
					k(&mut kinds, "bosses with loot").missing.push(bid.clone());
				}
				let have = mine.get("items").items();
				for it in bitems {
					k(&mut kinds, "boss loot items").total += 1;
					if have.iter().any(|h| h.strict_eq(&it)) {
						k(&mut kinds, "boss loot items").matched += 1;
					} else {
						k(&mut kinds, "boss loot items").missing.push(format!("{bid}/{}", kstr(&it)));
					}
				}
			}
		}
	}

	// ----- drop chances
	for (id, t) in oentries(&t_items) {
		let o = o_items.get(&id);
		for s in t.get("sources").items() {
			if s.get("type").as_str() != Some("drop") || s.get("chance").is_nullish() {
				continue;
			}
			k(&mut kinds, "drop chances").total += 1;
			let mine = if o.truthy() { o.get("sources").items().into_iter().find(|x| x.get("type").as_str() == Some("drop") && x.get("npc").strict_eq(&s.get("npc"))) } else { None };
			let row = format!("{id}/{}", kstr(&s.get("npc")));
			let Some(mine) = mine.filter(|m| !m.get("chance").is_nullish()) else {
				k(&mut kinds, "drop chances").missing.push(row);
				continue;
			};
			let (mc, sc) = (mine.get("chance").num(), s.get("chance").num());
			let gap = (mc - sc).abs();
			if gap == 0.0 || gap <= 1.0 || gap <= CHANCE_TOLERANCE * mc.max(sc) {
				k(&mut kinds, "drop chances").matched += 1;
				continue;
			}
			let from: Vec<String> = mine.get("from").items().iter().map(V::to_js_string).collect();
			if from.iter().any(|f| f == "recordings") || from.iter().any(|f| f == "questie") || from.first().map(String::as_str) == Some("web") {
				k(&mut kinds, "drop chances").matched += 1;
			}
		}
	}

	// ----- rares and treasures
	let spot = |list: &[V], spawns: &[V]| spawns.iter().any(|s| list.iter().any(|x| near(x, s, 5.0)));
	for (id, t) in oentries(&t_npcs) {
		if !t.get("rare").truthy() {
			continue;
		}
		let o = o_npcs.get(&id);
		k(&mut kinds, "rares").total += 1;
		if !o.truthy() || !o.get("rare").truthy() {
			k(&mut kinds, "rares").missing.push(kstr(&V::Num(str_to_num(&id))));
			continue;
		}
		k(&mut kinds, "rares").matched += 1;
		let ts = t.get("spawns").items();
		let os = o.get("spawns").items();
		if !ts.is_empty() {
			k(&mut kinds, "rare positions").total += 1;
			if spot(&os, &ts) {
				k(&mut kinds, "rare positions").matched += 1;
			} else if os.is_empty() {
				k(&mut kinds, "rare positions").missing.push(id.to_string());
			}
		}
		if t.get("level").truthy() {
			k(&mut kinds, "rare levels").total += 1;
			if o.get("level").truthy() && (o.get("level").num() - t.get("level").num()).abs() <= LEVEL_TOLERANCE {
				k(&mut kinds, "rare levels").matched += 1;
			} else if !o.get("level").truthy() {
				k(&mut kinds, "rare levels").missing.push(id.to_string());
			}
		}
		let ol = o.get("loot").items();
		for it in t.get("loot").items() {
			k(&mut kinds, "rare loot").total += 1;
			if ol.iter().any(|x| x.strict_eq(&it)) {
				k(&mut kinds, "rare loot").matched += 1;
			} else {
				k(&mut kinds, "rare loot").missing.push(format!("{id}/{}", kstr(&it)));
			}
		}
	}
	let t_objects = theirs.get("objects").cloned().unwrap_or_else(V::obj);
	for (id, t) in oentries(&t_objects) {
		if !t.get("treasure").truthy() {
			continue;
		}
		let o = ours.objects.get(&id);
		k(&mut kinds, "treasures").total += 1;
		if !o.truthy() || !o.get("treasure").truthy() {
			k(&mut kinds, "treasures").missing.push(id.to_string());
			continue;
		}
		k(&mut kinds, "treasures").matched += 1;
		let ts = t.get("spawns").items();
		if !ts.is_empty() {
			k(&mut kinds, "treasure positions").total += 1;
			if spot(&o.get("spawns").items(), &ts) {
				k(&mut kinds, "treasure positions").matched += 1;
			} else {
				k(&mut kinds, "treasure positions").missing.push(id.to_string());
			}
		}
		let ol = o.get("loot").items();
		for it in t.get("loot").items() {
			k(&mut kinds, "treasure loot").total += 1;
			if ol.iter().any(|x| x.strict_eq(&it)) {
				k(&mut kinds, "treasure loot").matched += 1;
			} else {
				k(&mut kinds, "treasure loot").missing.push(format!("{id}/{}", kstr(&it)));
			}
		}
	}

	// ----- items
	for (id, t) in oentries(&t_items) {
		let o = o_items.get(&id);
		let mut types: Vec<String> = Vec::new();
		for s in t.get("sources").items() {
			let ty = s.get("type").to_js_string();
			if !types.contains(&ty) {
				types.push(ty);
			}
		}
		let mut mine: Vec<String> = Vec::new();
		if o.truthy() {
			for s in o.get("sources").items() {
				let ty = s.get("type").to_js_string();
				if !mine.contains(&ty) {
					mine.push(ty);
				}
			}
		}
		if !types.is_empty() {
			k(&mut kinds, "items with a source").total += 1;
			if !mine.is_empty() {
				k(&mut kinds, "items with a source").matched += 1;
			} else {
				k(&mut kinds, "items with a source").missing.push(id.to_string());
			}
		}
		let idn = str_to_num(&id);
		for ty in SOURCE_TYPES {
			if !types.iter().any(|t| t == ty) {
				continue;
			}
			let name = format!("items: {ty}");
			k(&mut kinds, &name).total += 1;
			if mine.iter().any(|m| m == ty) || (ty == "pvp" && no_pvp.contains(&idn.to_bits())) {
				k(&mut kinds, &name).matched += 1;
			} else {
				k(&mut kinds, &name).missing.push(id.to_string());
			}
		}
		let tk = t.get("kind");
		if let Some(kind @ ("mount" | "pet" | "tabard")) = tk.as_str() {
			let name = format!("{kind}s");
			k(&mut kinds, &name).total += 1;
			if !o.truthy() {
				k(&mut kinds, &name).missing.push(id.to_string());
			} else if o.get("kind").as_str() == Some(kind) {
				k(&mut kinds, &name).matched += 1;
			}
		}
	}

	// ----- journal quests
	let t_pages = theirs.get("journal").map(|j| j.get("dungeons")).filter(V::truthy).unwrap_or_else(V::obj);
	let o_pages = ours.journal.get("dungeons");
	for (key, page) in oentries(&t_pages) {
		let ok = mapped(&key);
		let mine = ok.as_ref().map(|k| o_pages.get(k)).filter(V::truthy);
		let qs: Vec<V> = mine.as_ref().map(|m| m.get("quests").items()).unwrap_or_default();
		for q in page.get("quests").items() {
			let row = format!("{key}/{}", kstr(&q.get("id")));
			k(&mut kinds, "journal quests").total += 1;
			// Map semantics: the last quest of an id wins.
			let o = qs.iter().rev().find(|x| x.get("id").strict_eq(&q.get("id"))).cloned();
			let Some(o) = o else {
				k(&mut kinds, "journal quests").missing.push(row);
				continue;
			};
			k(&mut kinds, "journal quests").matched += 1;
			for (field, label) in [("start", "quest givers"), ("finish", "quest enders")] {
				let qf = q.get(field);
				if !qf.truthy() || qf.get("x").is_nullish() {
					continue;
				}
				k(&mut kinds, label).total += 1;
				let of = o.get(field);
				if of.truthy() && near(&of, &qf, POS_TOLERANCE) || of.truthy() && !of.get("x").is_nullish() {
					k(&mut kinds, label).matched += 1;
				} else {
					k(&mut kinds, label).missing.push(row.clone());
				}
			}
			let qc = q.get("chain").items();
			if !qc.is_empty() {
				k(&mut kinds, "quest chains").total += 1;
				let a = qc.iter().map(V::to_js_string).collect::<Vec<_>>().join(",");
				let oc = o.get("chain").items();
				let b = oc.iter().map(V::to_js_string).collect::<Vec<_>>().join(",");
				if a == b {
					k(&mut kinds, "quest chains").matched += 1;
				} else if oc.is_empty() {
					k(&mut kinds, "quest chains").missing.push(row.clone());
				}
			}
			let mut ti2: Vec<String> = q.get("rewards").get("items").items().iter().map(|i| i.get("id").to_js_string()).collect();
			if !ti2.is_empty() {
				ti2.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
				k(&mut kinds, "quest rewards").total += 1;
				let mut oi2: Vec<String> = o.get("rewards").get("items").items().iter().map(|i| i.get("id").to_js_string()).collect();
				oi2.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
				if ti2.join(",") == oi2.join(",") {
					k(&mut kinds, "quest rewards").matched += 1;
				} else if oi2.is_empty() {
					k(&mut kinds, "quest rewards").missing.push(row.clone());
				}
			}
			let txp = q.get("rewards").get("xp");
			if txp.truthy() {
				k(&mut kinds, "quest XP").total += 1;
				let ox = o.get("rewards").get("xp");
				if ox.strict_eq(&txp) {
					k(&mut kinds, "quest XP").matched += 1;
				} else if !ox.truthy() {
					k(&mut kinds, "quest XP").missing.push(row.clone());
				}
			}
		}
	}

	// Ours only.
	let mapped_values: Vec<&String> = instance_map.iter().filter_map(|(_, o)| o.as_ref()).collect();
	let ours_only: [(&str, usize); 5] = [
		("instances", oi.keys().iter().filter(|k| !mapped_values.iter().any(|v| **v == ***k)).count()),
		("rares", oentries(o_npcs).iter().filter(|(id, n)| n.get("rare").truthy() && !t_npcs.get(id).get("rare").truthy()).count()),
		("treasures", oentries(ours.objects).iter().filter(|(id, o)| o.get("treasure").truthy() && !t_objects.get(id).get("treasure").truthy()).count()),
		("items with a source", oentries(o_items).iter().filter(|(id, it)| !it.get("sources").items().is_empty() && t_items.get(id).get("sources").items().is_empty()).count()),
		("journal quests", {
			let mut n = 0;
			for (key, p) in oentries(&o_pages) {
				let tkey = instance_map.iter().find(|(_, o)| o.as_deref() == Some(&*key)).map(|(k, _)| k.clone());
				let tq: Vec<V> = tkey.map(|tk| t_pages.get(&tk).get("quests").items().iter().map(|q| q.get("id")).collect()).unwrap_or_default();
				n += p.get("quests").items().iter().filter(|q| !tq.iter().any(|x| x.strict_eq(&q.get("id")))).count();
			}
			n
		}),
	];
	for (name, n) in ours_only {
		if let Some((_, c)) = kinds.iter_mut().find(|(x, _)| x == name) {
			c.ours_only = Some(n);
		}
	}
	let cut_of = |name: &str| -> Option<&V> {
		match name {
			"drop chances" => Some(ours.cut_drop),
			"rare loot" => Some(ours.cut_rare),
			"treasure loot" => Some(ours.cut_treasure),
			_ => None,
		}
	};
	for (name, c) in kinds.iter_mut() {
		for id in std::mem::take(&mut c.missing) {
			let verdict = verdict_of(name, &id, verify, &ti);
			match verdict {
				"confirmed" => c.confirmed += 1,
				"not in Forever" => c.not_in_forever += 1,
				_ => c.unverified += 1,
			}
			if verdict == "confirmed" {
				if let Some(cut) = cut_of(name) {
					let mut p = id.split('/').map(str_to_num);
					let (a, b) = (p.next().unwrap_or(f64::NAN), p.next().unwrap_or(f64::NAN));
					if cut.get(&kstr(&V::Num(a))).items().iter().any(|x| x.num() == b) {
						c.cut = Some(c.cut.unwrap_or(0) + 1);
					}
				}
			}
			c.verdicts.push(Missing { id, verdict });
		}
	}
	// Bosses Forever's sources do not make a boss of this instance.
	let wh_npc = verify.map(|v| v.web.get("npc")).unwrap_or_else(V::obj);
	let areas = verify.and_then(|v| v.instance_areas.as_ref());
	if let Some((_, bosses)) = kinds.iter_mut().find(|(n, _)| n == "bosses") {
		let mut not_boss = 0;
		for r in &bosses.verdicts {
			let npc = str_to_num(r.id.split('/').nth(1).unwrap_or(""));
			let w = wh_npc.get(&kstr(&V::Num(npc)));
			if r.verdict != "confirmed" || !w.truthy() {
				continue;
			}
			let loc = w.get("location").items();
			let mut maps: Vec<String> = w.get("spawns").keys().iter().map(|k| k.to_string()).collect();
			for s in o_npcs.get(&kstr(&V::Num(npc))).get("spawns").items() {
				let m = s.get("map").to_js_string();
				if !maps.contains(&m) {
					maps.push(m);
				}
			}
			let outside = areas.is_some_and(|areas| !loc.iter().any(|a| areas.contains(&(a.num() as i64))) && (!loc.is_empty() || !maps.is_empty()));
			let cls = w.get("classification");
			if outside || (!w.get("boss").truthy() && !matches!(cls.as_str(), Some("boss" | "rare" | "rareelite"))) {
				not_boss += 1;
			}
		}
		if not_boss > 0 {
			bosses.not_boss = Some(not_boss);
		}
	}
	let out = Obj::new();
	let ordered: BTreeMap<usize, &(String, Kind)> = kinds.iter().enumerate().collect();
	for (_, (name, c)) in ordered {
		let o = Obj::new();
		o.set("total", c.total);
		o.set("match", c.matched);
		o.set("share", if c.total > 0 { math_round((c.matched as f64 / c.total as f64) * 1000.0) / 1000.0 } else { 1.0 });
		let io = Obj::new();
		io.set("confirmed", c.confirmed);
		io.set("notInForever", c.not_in_forever);
		io.set("unverified", c.unverified);
		if let Some(n) = c.cut {
			io.set("cut", n);
		}
		if let Some(n) = c.not_boss {
			io.set("notBoss", n);
		}
		o.set("internalOnly", V::Obj(io));
		o.set("oursOnly", c.ours_only.map(|n| V::Num(n as f64)).unwrap_or(V::Null));
		out.set(name, V::Obj(o));
	}
	V::Obj(out)
}
