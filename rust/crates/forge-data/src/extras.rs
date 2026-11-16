//! The cached web facts and server facts the build folds in, offline only:
//! - the web zone lists (zone quest lists and change notes; port of the JS zone-list loader);
//! - quest XP from the Forever web databases (tools/lib/data/webxp.js, cache only);
//! - CMaNGOS classic-db spawn heights and objective counts (tools/lib/travel/cmangos.js): the
//!   cached extracts, rebuilt from the cached dump when missing.
//! - ItemSparse durations (corrections: corrections.rs).
//! - Summoned vendors (SpellEffect): camp bots a player places sell nothing a guide can send to.

use std::path::{Path, PathBuf};

use forge_guide::js::{parse_json, Obj, V};
use indexmap::IndexMap;
use rustc_hash::FxHashSet;

use crate::jsv::{arr, col_num, Row};

pub fn read_json(file: &Path) -> Result<Option<V>, String> {
	if !file.exists() {
		return Ok(None);
	}
	let t = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	parse_json(&t).map(Some).map_err(|e| format!("{}: {e}", file.display()))
}

fn tag(q: &V, source: &str) {
	let s = q.get("source");
	if !s.items().iter().any(|x| x.as_str() == Some(source)) {
		s.push(source);
	}
}

// ---------------------------------------------------------------- the web zone lists

pub struct ZoneQuests {
	pub rows: IndexMap<String, V>,
	pub file: PathBuf,
	pub fetched_at: V,
	pub warnings: Vec<String>,
}

/// The web quest-list cache (<sources>/web).
pub fn cache_dir(sources: &Path) -> PathBuf {
	sources.join("web")
}

pub fn load_zone_quests(sources: &Path) -> Result<ZoneQuests, String> {
	let file = cache_dir(sources).join("zones.json");
	let cache = read_json(&file)?;
	let mut rows = IndexMap::new();
	if let Some(c) = &cache {
		for (zone, list) in c.get("zones").entries() {
			for r in list.items() {
				let r = if r.get("zone").is_undef() {
					let o = r.as_obj().unwrap().spread();
					o.set("zone", forge_guide::js::str_to_num(&zone));
					V::Obj(o)
				} else {
					r
				};
				rows.insert(r.get("id").to_js_string(), r);
			}
		}
	}
	Ok(ZoneQuests { fetched_at: cache.as_ref().map(|c| c.get("fetchedAt")).unwrap_or(V::Null), warnings: if cache.is_some() { vec![] } else { vec!["no cached web zone lists".into()] }, rows, file })
}

fn parse_notes(lines: &[V]) -> Vec<(&'static str, Option<f64>, Option<f64>)> {
	let mut out = Vec::new();
	let numv = |s: &str| if s == "none" { Some(None) } else { s.replace(',', "").parse::<f64>().ok().map(Some) };
	let digits = |s: &str, comma: bool| !s.is_empty() && s.bytes().all(|b| b.is_ascii_digit() || (comma && b == b','));
	for l in lines {
		let Some(line) = l.as_str() else { continue };
		for (field, head, mid, comma) in [("xp", "Experience ", " instead of ", true), ("minLevel", "Requires level ", " instead of ", false), ("level", "Level ", " instead of ", false)] {
			let Some(rest) = line.strip_prefix(head) else { continue };
			let Some((a, b)) = rest.split_once(mid) else { continue };
			if !digits(a, comma) || !(b == "none" || digits(b, comma)) {
				continue;
			}
			out.push((field, numv(a).flatten(), numv(b).flatten()));
			break;
		}
	}
	out
}

pub struct Changed {
	pub xp: usize,
	pub level: usize,
	pub min_level: usize,
	pub title: usize,
}

pub fn apply_change_notes(quests: &Obj, rows: &IndexMap<String, V>) -> Changed {
	let mut c = Changed { xp: 0, level: 0, min_level: 0, title: 0 };
	for (id, r) in rows {
		let q = quests.get(id);
		if q.is_undef() || r.get("status").as_str() != Some("updated") {
			continue;
		}
		let lines = r.get("lines").items();
		for (field, value, was) in parse_notes(&lines) {
			let cur = q.get(field);
			let cur_n = cur.as_num();
			let eq_was = match was {
				Some(w) => cur_n == Some(w),
				None => matches!(cur, V::Null),
			};
			let stale = if field == "xp" { !cur_n.is_some_and(f64::is_finite) || eq_was } else { eq_was };
			let Some(value) = value else { continue };
			if !stale || cur_n == Some(value) || !(value > 0.0) {
				continue;
			}
			q.set(field, value);
			tag(&q, &format!("web:{field}"));
			match field {
				"xp" => c.xp += 1,
				"level" => c.level += 1,
				_ => c.min_level += 1,
			}
		}
		for l in &lines {
			let Some(old) = l.as_str().and_then(|s| s.strip_prefix("Renamed from ")) else { continue };
			let Some(name) = r.get("name").as_rc_str().filter(|s| !s.is_empty()) else { continue };
			let title = q.get("title");
			if old.is_empty() || old.contains(['\n', '\r', '\u{2028}', '\u{2029}']) || title.as_str() != Some(old) || title.as_str() == Some(&name) {
				continue;
			}
			q.set("title", name);
			tag(&q, "web:title");
			c.title += 1;
		}
	}
	c
}

pub fn changed_v(c: &Changed) -> V {
	let o = Obj::new();
	o.set("xp", c.xp);
	o.set("level", c.level);
	o.set("minLevel", c.min_level);
	o.set("title", c.title);
	V::Obj(o)
}

pub fn fill_web_zone_xp(quests: &Obj, rows: &IndexMap<String, V>) -> usize {
	let mut n = 0;
	for (id, r) in rows {
		let q = quests.get(id);
		if q.is_undef() || q.get("xp").as_num().is_some_and(f64::is_finite) || !(r.get("xp").num() > 0.0) {
			continue;
		}
		q.set("xp", r.get("xp"));
		tag(&q, "web:xp");
		n += 1;
	}
	n
}

pub fn apply_web_zone_facts(quests: &Obj, rows: &IndexMap<String, V>) -> usize {
	let mut n = 0;
	for (id, r) in rows {
		let q = quests.get(id);
		if q.is_undef() || r.get("type").is_undef() {
			continue;
		}
		let choices = r.get("choices").items();
		let items = r.get("items").items();
		let choice_ids: Vec<V> = choices.iter().map(|p| p.at(0)).collect();
		let in_choices = |p: &V| choice_ids.iter().any(|c| c.strict_eq(&p.at(0)));
		let no_longer = r.get("lines").items().iter().any(|l| l.as_str().is_some_and(|s| s.starts_with("Rewards: no longer Choice of ")));
		let both: Vec<V> = items.iter().filter(|p| in_choices(p)).map(|p| p.at(0)).collect();
		let ch = if no_longer { choices.iter().filter(|p| !both.iter().any(|b| b.strict_eq(&p.at(0)))).cloned().collect() } else { choices.clone() };
		let it = if no_longer { items.clone() } else { items.iter().filter(|p| !in_choices(p)).cloned().collect() };
		let o = Obj::new();
		let z = r.get("zone");
		o.set("zone", if z.is_nullish() { V::Null } else { z });
		o.set("type", r.get("type"));
		o.set("side", r.get("side"));
		o.set("choices", arr(ch));
		o.set("items", arr(it));
		o.set("money", r.get("money"));
		o.set("rep", arr(r.get("rep").items().into_iter().filter(|p| p.num_at(1).abs() > 1.0).collect()));
		q.set("web", o);
		n += 1;
	}
	n
}

// ---------------------------------------------------------------- web XP (cache only)

pub struct WebXp {
	pub xp: IndexMap<i64, (V, &'static str)>,
	pub file: PathBuf,
}

/// The cached XP of `ids` (`--offline`: nothing is looked up).
pub fn load_web_xp(sources: &Path, ids: &[f64]) -> Result<WebXp, String> {
	let file = sources.join("webxp").join("quest-xp.json");
	let cache = read_json(&file)?.unwrap_or_else(V::obj);
	let mut xp = IndexMap::new();
	for &id in ids {
		let e = cache.get(&forge_guide::js::num_str(id));
		if !e.truthy() {
			continue;
		}
		if e.get("wft").truthy() {
			xp.insert(id as i64, (e.get("wft"), "webcache:xp"));
		} else if e.get("fc").truthy() {
			xp.insert(id as i64, (e.get("fc"), if e.get("fcChain").truthy() { "webdb:xp-chain" } else { "webdb:xp" }));
		}
	}
	Ok(WebXp { xp, file })
}

// ---------------------------------------------------------------- durations

/// ItemSparse DurationInInventory (seconds) -> `duration` on the items held. -> how many.
pub fn item_durations(rows: &[Row], items: &Obj) -> usize {
	let mut n = 0;
	for r in rows {
		let seconds = crate::jsv::col_num(r, "DurationInInventory");
		let id = crate::jsv::col_num(r, "ID");
		let it = items.get(&forge_guide::js::num_str(id));
		if it.is_undef() || !(seconds > 0.0) {
			continue;
		}
		it.set("duration", seconds);
		n += 1;
	}
	n
}

// ---------------------------------------------------------------- summoned vendors

/// SpellEffect's SUMMON effect (28): EffectMiscValue_0 is the creature it summons.
const SUMMON: f64 = 28.0;
/// Service roles a summoned NPC loses: what `buy … nearest` and repair stops look for.
const SUMMONED_ROLES: [&str; 2] = ["vendor", "repair"];

/// The creatures a client spell summons (SpellEffect rows with Effect 28).
pub fn summoned_creatures(effects: &[Row]) -> FxHashSet<i64> {
	effects.iter().filter(|r| col_num(r, "Effect") == SUMMON).map(|r| col_num(r, "EffectMiscValue_0")).filter(|c| *c > 0.0 && c.fract() == 0.0).map(|c| c as i64).collect()
}

/// Vendors a player summons (Forever's camp Reagent Bot and Repair Bot, an engineer's Field Repair
/// Bot 74A): their sniffed spawns are someone's camp that has since gone, so a guide must never send a
/// player there to buy or repair. They lose the vendor and repair roles and leave every item's vendor
/// list. -> the NPC ids changed, ascending.
pub fn drop_summoned_vendors(summoned: &FxHashSet<i64>, npcs: &Obj, items: &Obj) -> Vec<i64> {
	let mut changed = Vec::new();
	for (id, n) in npcs.entries() {
		let Ok(nid) = id.parse::<i64>() else { continue };
		if !summoned.contains(&nid) {
			continue;
		}
		let roles = n.get("roles").items();
		if !roles.iter().any(|r| r.as_str().is_some_and(|r| SUMMONED_ROLES.contains(&r))) {
			continue;
		}
		let keep: Vec<V> = roles.into_iter().filter(|r| !r.as_str().is_some_and(|r| SUMMONED_ROLES.contains(&r))).collect();
		if keep.is_empty() {
			n.as_obj().map(|o| o.delete("roles"));
		} else {
			n.set("roles", arr(keep));
		}
		changed.push(nid);
	}
	changed.sort_unstable();
	if changed.is_empty() {
		return changed;
	}
	for it in items.values() {
		let vendors = it.get("vendors").items();
		if vendors.iter().any(|v| changed.contains(&(v.num() as i64))) {
			it.set("vendors", arr(vendors.into_iter().filter(|v| !changed.contains(&(v.num() as i64))).collect()));
		}
	}
	changed
}

// ---------------------------------------------------------------- place-name NPCs

/// NPC records that are only a place's or a faction's name: no spawn, no service role, no quest starts, ends or
/// needs them, no item drops from them or is sold by them, and the name is exactly a zone's or a faction's.
/// QuestieDB 1.0.14 adds "Orgrimmar" (176552) and "Stormwind" (176553), which no world database, client cache or
/// recording has: they name nothing a player can find, and a guide step titled after the city reads as titled
/// after them. They leave the data. -> the NPC ids dropped, ascending.
pub fn drop_place_name_npcs(npcs: &Obj, quests: &Obj, items: &Obj, zones: &Obj, factions: &Obj) -> Vec<i64> {
	let names: FxHashSet<String> = zones
		.values()
		.into_iter()
		.chain(factions.values())
		.filter_map(|v| {
			let n = v.get("name");
			n.as_str().map(str::to_string)
		})
		.collect();
	let mut used: FxHashSet<i64> = FxHashSet::default();
	for q in quests.values() {
		let mut refs = q.get("start").get("npc").items();
		refs.extend(q.get("end").get("npc").items());
		refs.extend(q.get("objectives").items().into_iter().filter(|o| matches!(o.get("type").as_str(), Some("kill" | "talk"))).map(|o| o.get("id")));
		used.extend(refs.iter().filter_map(V::as_num).map(|n| n as i64));
	}
	for it in items.values() {
		used.extend(it.get("vendors").items().iter().filter_map(V::as_num).map(|n| n as i64));
		used.extend(it.get("drops").get("npc").keys().iter().filter_map(|k| k.parse::<i64>().ok()));
	}
	let mut gone: Vec<i64> = npcs
		.entries()
		.into_iter()
		.filter_map(|(id, n)| {
			let nid = id.parse::<i64>().ok()?;
			let name = n.get("name");
			let place = name.as_str().is_some_and(|s| names.contains(s));
			let spawns = n.get("spawns");
			let found = spawns.truthy() && !spawns.keys().is_empty();
			(place && !found && n.get("roles").items().is_empty() && !used.contains(&nid)).then_some(nid)
		})
		.collect();
	gone.sort_unstable();
	for id in &gone {
		npcs.delete(&id.to_string());
	}
	gone
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::stringify;

	fn row(effect: &str, misc: &str) -> Row {
		[("Effect", effect), ("EffectMiscValue_0", misc)].iter().map(|(k, v)| (k.to_string(), v.to_string())).collect()
	}

	#[test]
	fn summoned_camp_bots_sell_nothing() {
		// Spell 1307266 summons the Reagent Bot (242498); effect 24 (create item) names no creature.
		let summoned = summoned_creatures(&[row("28", "242498"), row("24", "5956"), row("28", "0")]);
		assert_eq!(summoned.into_iter().collect::<Vec<_>>(), vec![242498]);
		let npcs = parse_json(r#"{"242498":{"id":242498,"name":"Reagent Bot","roles":["vendor"],"spawns":{"1429":{"pts":[[42.2,66]]}}},"66":{"id":66,"name":"Tharynn Bouden","roles":["repair","vendor"]},"14337":{"id":14337,"name":"Field Repair Bot 74A","roles":["repair","vendor","questgiver"]}}"#).unwrap();
		let items = parse_json(r#"{"2880":{"id":2880,"name":"Weak Flux","vendors":[66,242498]},"2901":{"id":2901,"name":"Mining Pick","vendors":[66]}}"#).unwrap();
		let summoned: FxHashSet<i64> = [242498, 14337].into_iter().collect();
		let changed = drop_summoned_vendors(&summoned, npcs.as_obj().unwrap(), items.as_obj().unwrap());
		assert_eq!(changed, vec![14337, 242498]);
		assert!(!npcs.get("242498").has("roles"));
		assert_eq!(stringify(&npcs.get("14337").get("roles"), None), r#"["questgiver"]"#);
		assert_eq!(stringify(&npcs.get("66").get("roles"), None), r#"["repair","vendor"]"#);
		assert_eq!(stringify(&items.get("2880").get("vendors"), None), "[66]");
		assert_eq!(stringify(&items.get("2901").get("vendors"), None), "[66]");
	}

	#[test]
	fn npcs_that_are_only_a_city_or_faction_name_leave_the_data() {
		// QuestieDB 1.0.14's 176552 "Orgrimmar" and 176553 "Stormwind" (a faction's name, not the zone's, "Stormwind
		// City"): no spawn, no role, nothing refers to them. Kept: the same names with a spawn, a role, a quest or an
		// item that refers to them, and an unspawned NPC with an ordinary name.
		let npcs = parse_json(
			r#"{"176552":{"id":176552,"name":"Orgrimmar","spawns":{}},"176553":{"id":176553,"name":"Stormwind"},
			"13936":{"id":13936,"name":"Ravenholdt","spawns":{"1416":{"pts":[[86,79]]}}},"900001":{"id":900001,"name":"Orgrimmar","roles":["vendor"]},
			"900002":{"id":900002,"name":"Stormwind"},"900003":{"id":900003,"name":"Orgrimmar"},"900004":{"id":900004,"name":"Stormwind"},
			"900005":{"id":900005,"name":"Orgrimmar"},"900006":{"id":900006,"name":"Grull Hawkwind"}}"#,
		)
		.unwrap();
		let quests = parse_json(r#"{"1":{"id":1,"start":{"npc":[900002]},"end":{"npc":[]},"objectives":[{"type":"kill","id":900003,"count":1}]}}"#).unwrap();
		let items = parse_json(r#"{"2":{"id":2,"vendors":[900004],"drops":{"npc":{"900005":12.5}}}}"#).unwrap();
		let zones = parse_json(r#"{"1454":{"id":1454,"name":"Orgrimmar"},"1453":{"id":1453,"name":"Stormwind City"},"1416":{"id":1416,"name":"Alterac Mountains"}}"#).unwrap();
		let factions = parse_json(r#"{"72":{"id":72,"name":"Stormwind"},"76":{"id":76,"name":"Orgrimmar"},"349":{"id":349,"name":"Ravenholdt"}}"#).unwrap();
		let gone = drop_place_name_npcs(npcs.as_obj().unwrap(), quests.as_obj().unwrap(), items.as_obj().unwrap(), zones.as_obj().unwrap(), factions.as_obj().unwrap());
		assert_eq!(gone, vec![176552, 176553]);
		let mut kept: Vec<String> = npcs.keys().iter().map(|k| k.to_string()).collect();
		kept.sort();
		assert_eq!(kept, ["13936", "900001", "900002", "900003", "900004", "900005", "900006"]);
	}
}
