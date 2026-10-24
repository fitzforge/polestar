//! The cached web facts and server facts the build folds in, offline only:
//! - the web zone lists (zone quest lists and change notes; port of the JS zone-list loader);
//! - quest XP from the Forever web databases (tools/lib/data/webxp.js, cache only);
//! - CMaNGOS classic-db spawn heights and objective counts (tools/lib/travel/cmangos.js): the
//!   cached extracts, rebuilt from the cached dump when missing.
//! - ItemSparse durations (corrections: corrections.rs).

use std::path::{Path, PathBuf};

use forge_guide::js::{parse_json, Obj, V};
use indexmap::IndexMap;

use crate::jsv::{arr, Row};

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
