//! What players' games saw, cached under data/sources (offline: never fetched here):
//! - the EG Link output (JIVESCORP/eg-link-output-wowf, CC BY 4.0; port of tools/lib/data/eglink.js),
//! - forever-vo's dialog captures (quinn-dougherty/forever-vo; tools/lib/data/forevervo.js),
//! - the client's QuestXP table (tools/lib/game/xp.js loadQuestXp).

use std::path::Path;

use indexmap::{IndexMap, IndexSet};
use serde_json::Value as J;

pub const EG_NAME: &str = "EG Link output: World of Warcraft: Forever";
pub const EG_URL: &str = "https://github.com/JIVESCORP/eg-link-output-wowf";
pub const EG_COMMIT: &str = "d98f94821b69cccf81b03a542df3755b60055217";
pub const EG_CREDIT: &str = "EG Link output: World of Warcraft: Forever (https://github.com/JIVESCORP/eg-link-output-wowf), data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/); reduced to quest facts for Polestar.";
pub const EG_PRODUCT: &str = "wow_classic_beta";
pub const DATASETS: [&str; 5] = ["quests.enUS", "quest_scan", "turn_ins", "npcs", "loot"];
const MAX_LEVEL: f64 = 60.0;

pub const VO_NAME: &str = "forever-vo captures";
pub const VO_URL: &str = "https://github.com/quinn-dougherty/forever-vo";
pub const VO_COMMIT: &str = "f3b8d4c600394a094bc7729b2bdcbbc1ddbbdb52";
pub const VO_LICENSE: &str = "NOASSERTION";

fn read(file: &Path) -> Result<Option<J>, String> {
	if !file.exists() {
		return Ok(None);
	}
	let b = std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?;
	serde_json::from_slice(&b).map(Some).map_err(|e| format!("{}: {e}", file.display()))
}

fn f(v: &J) -> Option<f64> {
	v.as_f64()
}

fn truthy(v: &J) -> bool {
	match v {
		J::Null => false,
		J::Bool(b) => *b,
		J::Number(n) => n.as_f64().is_some_and(|x| x != 0.0 && !x.is_nan()),
		J::String(s) => !s.is_empty(),
		_ => true,
	}
}

/// The game's rounding of a quest reward (RoundXPValue).
pub fn round_quest_xp(xp: f64) -> f64 {
	if xp <= 100.0 {
		5.0 * ((xp + 2.0) / 5.0).floor()
	} else if xp <= 500.0 {
		10.0 * ((xp + 5.0) / 10.0).floor()
	} else if xp <= 1000.0 {
		25.0 * ((xp + 12.0) / 25.0).floor()
	} else {
		50.0 * ((xp + 25.0) / 50.0).floor()
	}
}

/// QuestXP rows: level -> [difficulty 0..9].
/// The Classic Era build whose QuestXP table the XP reads (game/xp.js QUESTXP_BUILD).
pub const QUESTXP_BUILD: &str = "1.15.9.70003";

pub type QuestXp = Vec<Option<[f64; 10]>>;

pub fn load_quest_xp(sources: &Path) -> Result<QuestXp, String> {
	let file = sources.join("wago").join(QUESTXP_BUILD).join("QuestXP.csv");
	let text = std::fs::read_to_string(&file).map_err(|_| format!("--offline: missing cached {}", file.display()))?;
	quest_xp_of(&crate::tables::parse_csv(&text)?)
}

/// QuestXP rows (ID, Difficulty_0..9) as a table by level.
pub fn quest_xp_of(table: &crate::jsv::Rows) -> Result<QuestXp, String> {
	let mut rows: QuestXp = Vec::new();
	for r in table {
		let lvl = crate::jsv::col_num(r, "ID");
		if !crate::jsv::is_int(lvl) || lvl < 1.0 {
			continue;
		}
		let mut t = [0.0; 10];
		for (i, x) in t.iter_mut().enumerate() {
			let n = crate::jsv::col_num(r, &format!("Difficulty_{i}"));
			*x = if n.is_nan() { 0.0 } else { n };
		}
		let l = lvl as usize;
		if rows.len() <= l {
			rows.resize(l + 1, None);
		}
		rows[l] = Some(t);
	}
	if rows.get(1).is_none_or(Option::is_none) || rows.get(60).is_none_or(Option::is_none) {
		return Err("QuestXP table lacks levels 1-60".into());
	}
	Ok(rows)
}

pub type Ends = Vec<(String, f64)>;

/// [['npc'|'object', id]] sorted, NPCs first.
fn ends(set: &IndexSet<String>) -> Ends {
	let mut v: Ends = set
		.iter()
		.map(|k| {
			let (a, b) = k.split_once(':').unwrap();
			(a.to_string(), forge_guide::js::str_to_num(b))
		})
		.collect();
	v.sort_by(|a, b| {
		if a.0 == b.0 {
			a.1.partial_cmp(&b.1).unwrap()
		} else if a.0 == "npc" {
			std::cmp::Ordering::Less
		} else {
			std::cmp::Ordering::Greater
		}
	});
	v
}

#[derive(Clone, Debug, Default)]
pub struct EgQuest {
	pub build: Option<f64>,
	pub level: Option<f64>,
	pub min_level: Option<f64>,
	pub xp_difficulty: Option<f64>,
	pub xp_multiplier: Option<f64>,
	pub xp: Option<f64>,
	pub xp_observed: Option<f64>,
	pub next: Option<f64>,
	pub start_item: Option<f64>,
	pub races: Option<String>,
	/// (kind, id, amount)
	pub objectives: Vec<(String, Option<f64>, Option<f64>)>,
	pub start: Ends,
	pub end: Ends,
}

pub struct Eg {
	pub commit: String,
	/// quest id -> record, ascending ids.
	pub quests: IndexMap<i64, EgQuest>,
	/// item -> [npc: who -> (percent, drops, windows), object: ...], ascending.
	pub drops: IndexMap<i64, [IndexMap<i64, (f64, f64, f64)>; 2]>,
}

fn build_number(b: &str) -> f64 {
	forge_guide::js::str_to_num(b.rsplit('.').next().unwrap_or(""))
}

fn percent(c: f64) -> f64 {
	crate::jsv::math_round(c * 10000.0) / 100.0
}

/// The cached EG Link output (None when a file is not cached).
pub fn load_eg(sources: &Path, quest_xp: Option<&QuestXp>, log: &dyn Fn(&str)) -> Result<Option<Eg>, String> {
	let dir = sources.join("eg-link").join(&EG_COMMIT[..12]);
	let Some(index) = read(&dir.join("index.json"))? else {
		log(&format!("eg-link: --offline, {} not cached", dir.join("index.json").display()));
		return Ok(None);
	};
	let Some(prod) = index.get("products").and_then(|p| p.get(EG_PRODUCT)).and_then(J::as_object) else { return Ok(None) };
	let mut builds: Vec<String> = prod.iter().filter(|(_, v)| DATASETS.iter().any(|d| v.get(*d).is_some_and(truthy))).map(|(k, _)| k.clone()).collect();
	builds.sort_by(|a, b| build_number(a).partial_cmp(&build_number(b)).unwrap_or(std::cmp::Ordering::Equal));
	let mut data: Vec<IndexMap<&str, J>> = Vec::new();
	for b in &builds {
		let mut m = IndexMap::new();
		for d in DATASETS {
			if !prod[b].get(d).is_some_and(truthy) {
				continue;
			}
			let file = dir.join(EG_PRODUCT).join(b).join(format!("{d}.json"));
			let Some(j) = read(&file)? else {
				log(&format!("eg-link: --offline, {} not cached", file.display()));
				return Ok(None);
			};
			m.insert(d, j);
		}
		data.push(m);
	}
	let newest: Vec<usize> = (0..builds.len()).rev().collect();

	let mut records: IndexMap<String, (f64, J)> = IndexMap::new();
	for &i in &newest {
		let Some(qs) = data[i].get("quests.enUS") else { continue };
		for (id, rec) in qs.get("quests").and_then(J::as_object).into_iter().flatten() {
			records.entry(id.clone()).or_insert((build_number(&builds[i]), rec.clone()));
		}
	}
	let mut scanned: IndexMap<String, bool> = IndexMap::new();
	for &i in &newest {
		let Some(scan) = data[i].get("quest_scan") else { continue };
		for id in scan.get("described").and_then(J::as_object).into_iter().flatten().map(|(k, _)| k) {
			scanned.entry(id.clone()).or_insert(false);
		}
		for id in scan.get("noData").and_then(J::as_array).into_iter().flatten() {
			let k = match id {
				J::String(s) => s.clone(),
				v => forge_guide::js::num_str(v.as_f64().unwrap_or(f64::NAN)),
			};
			scanned.entry(k).or_insert(true);
		}
	}
	let mut start: IndexMap<String, IndexSet<String>> = IndexMap::new();
	let mut end: IndexMap<String, IndexSet<String>> = IndexMap::new();
	for d in &data {
		let Some(npcs) = d.get("npcs") else { continue };
		for (kind, key) in [("npc", "npcs"), ("object", "objects")] {
			for (who, rec) in npcs.get(key).and_then(J::as_object).into_iter().flatten() {
				for id in rec.get("offers").and_then(J::as_object).into_iter().flatten().map(|(k, _)| k) {
					start.entry(id.clone()).or_default().insert(format!("{kind}:{who}"));
				}
				for id in rec.get("takes").and_then(J::as_object).into_iter().flatten().map(|(k, _)| k) {
					end.entry(id.clone()).or_default().insert(format!("{kind}:{who}"));
				}
			}
		}
	}
	// Turn-in XP at levels that pay in full: value -> (count, newest build).
	let mut observed: IndexMap<String, IndexMap<u64, (f64, f64, f64)>> = IndexMap::new();
	for (bi, d) in data.iter().enumerate() {
		let Some(t) = d.get("turn_ins") else { continue };
		let qs = t.get("quests").and_then(J::as_object);
		let mut paying: Vec<f64> = Vec::new();
		for list in qs.into_iter().flatten().map(|(_, v)| v) {
			for o in list.as_array().into_iter().flatten() {
				if o.get("xp").and_then(f).is_some_and(|x| x > 0.0) {
					if let Some(l) = o.get("level").and_then(f) {
						paying.push(l);
					}
				}
			}
		}
		for (id, list) in qs.into_iter().flatten() {
			let level = records.get(id).and_then(|r| r.1.get("level")).and_then(f);
			let Some(level) = level.filter(|l| *l >= 1.0) else { continue };
			for o in list.as_array().into_iter().flatten() {
				let Some(xp) = o.get("xp").filter(|x| x.is_number()).and_then(f) else { continue };
				let ol = o.get("level").and_then(f);
				if o.get("maxLevel").is_some_and(truthy) || o.get("xpDisabled").is_some_and(truthy) || !ol.is_some_and(|l| l >= 1.0) {
					continue;
				}
				let ol = ol.unwrap();
				if ol >= MAX_LEVEL || ol > level + 5.0 {
					continue;
				}
				if xp == 0.0 && !paying.contains(&ol) {
					continue;
				}
				let counts = observed.entry(id.clone()).or_default();
				let srcs = o.get("sources").filter(|s| truthy(s)).and_then(f).unwrap_or(1.0);
				let e = counts.entry(xp.to_bits()).or_insert((xp, 0.0, 0.0));
				e.1 += srcs;
				e.2 = build_number(&builds[bi]);
			}
		}
	}
	let mode = |counts: &IndexMap<u64, (f64, f64, f64)>| -> Option<f64> {
		let mut best: Option<(f64, f64, f64)> = None;
		for &(value, count, build) in counts.values() {
			if best.is_none_or(|b| count > b.1 || (count == b.1 && (build > b.2 || (build == b.2 && value > b.0)))) {
				best = Some((value, count, build));
			}
		}
		best.map(|b| b.0)
	};

	let mut ids: IndexSet<String> = IndexSet::new();
	for k in records.keys().chain(start.keys()).chain(end.keys()).chain(observed.keys()) {
		ids.insert(k.clone());
	}
	for (id, gone) in &scanned {
		if *gone {
			ids.insert(id.clone());
		}
	}
	let mut idv: Vec<String> = ids.into_iter().collect();
	idv.sort_by(|a, b| forge_guide::js::str_to_num(a).partial_cmp(&forge_guide::js::str_to_num(b)).unwrap_or(std::cmp::Ordering::Equal));
	let kinds = |t: &str| match t {
		"monster" => "kill",
		"item" => "item",
		"gameObject" => "object",
		"talkTo" => "talk",
		"criteriaTree" => "criteria",
		_ => "other",
	};
	let mut quests = IndexMap::new();
	let null = J::Null;
	for id in &idv {
		let r = records.get(id);
		let rec = r.map(|r| &r.1).unwrap_or(&null);
		let rewards = rec.get("rewards").unwrap_or(&null);
		let num = |v: Option<&J>| v.filter(|x| x.is_number()).and_then(f);
		let level = num(rec.get("level"));
		let xd = num(rewards.get("xpDifficulty"));
		let xm = num(rewards.get("xpMultiplier"));
		let base = level
			.filter(|l| *l >= 1.0)
			.and_then(|l| quest_xp.and_then(|q| q.get(l as usize).copied().flatten()))
			.and_then(|row| xd.and_then(|d| row.get(d as usize).copied().filter(|_| d.fract() == 0.0 && d >= 0.0)));
		let tf = |k: &str| rec.get(k).filter(|v| truthy(v)).and_then(f);
		let q = EgQuest {
			build: r.map(|r| r.0),
			level,
			min_level: num(rec.get("minLevel")),
			xp_difficulty: xd,
			xp_multiplier: xm,
			xp: base.map(|b| round_quest_xp(b * xm.unwrap_or(1.0))),
			xp_observed: observed.get(id).and_then(mode),
			next: tf("nextQuestId"),
			start_item: tf("startItemId"),
			races: rec.get("raceMask").filter(|v| truthy(v)).and_then(|v| v.as_str()).map(|h| u128::from_str_radix(h, 16).map(|x| x.to_string()).unwrap_or_default()),
			objectives: rec
				.get("objectives")
				.and_then(J::as_array)
				.into_iter()
				.flatten()
				.map(|o| (kinds(o.get("type").and_then(J::as_str).unwrap_or("")).to_string(), num(o.get("objectId")), num(o.get("amount"))))
				.collect(),
			start: ends(start.get(id).unwrap_or(&IndexSet::new())),
			end: ends(end.get(id).unwrap_or(&IndexSet::new())),
		};
		quests.insert(forge_guide::js::str_to_num(id) as i64, q);
	}

	// Items each quest needs.
	let mut needs: IndexMap<String, IndexSet<i64>> = IndexMap::new();
	for (id, (_, rec)) in &records {
		let mut items = IndexSet::new();
		for o in rec.get("objectives").and_then(J::as_array).into_iter().flatten() {
			if o.get("type").and_then(J::as_str) == Some("item") {
				if let Some(x) = o.get("objectId").filter(|v| truthy(v)).and_then(f) {
					items.insert(x as i64);
				}
			}
		}
		for d in rec.get("itemDrops").and_then(J::as_array).into_iter().flatten() {
			if let Some(x) = d.get("itemId").filter(|v| truthy(v)).and_then(f) {
				items.insert(x as i64);
			}
		}
		needs.insert(id.clone(), items);
	}
	struct Tied {
		windows: f64,
		deaths: f64,
		empty: f64,
		unknown: f64,
		items: IndexMap<String, f64>,
	}
	let mut tied: IndexMap<String, IndexMap<String, Tied>> = IndexMap::new();
	let mut chests: IndexMap<String, (f64, IndexMap<String, f64>)> = IndexMap::new();
	let nz = |v: Option<&J>| v.and_then(f).filter(|x| *x != 0.0 && !x.is_nan()).unwrap_or(0.0);
	for d in &data {
		let Some(loot) = d.get("loot") else { continue };
		for (key, src) in loot.get("sources").and_then(J::as_object).into_iter().flatten() {
			let parts: Vec<&str> = key.split('|').collect();
			let (kind, who) = parts[0].split_once(':').unwrap_or((parts[0], ""));
			if kind == "npc" && parts.contains(&"quest") {
				let kills = loot.get("kills").and_then(|k| k.get(key)).and_then(|k| k.get("quests"));
				let by = tied.entry(who.to_string()).or_default();
				for (q, sub) in src.get("quests").and_then(J::as_object).into_iter().flatten() {
					let t = by.entry(q.clone()).or_insert(Tied { windows: 0.0, deaths: 0.0, empty: 0.0, unknown: 0.0, items: IndexMap::new() });
					t.windows += nz(sub.get("windows"));
					let k = kills.and_then(|k| k.get(q));
					t.deaths += nz(k.and_then(|k| k.get("deaths")));
					t.empty += nz(k.and_then(|k| k.get("empty")));
					t.unknown += nz(k.and_then(|k| k.get("unknown")));
					for (item, s) in sub.get("items").and_then(J::as_object).into_iter().flatten() {
						*t.items.entry(item.clone()).or_insert(0.0) += nz(s.get("drops"));
					}
				}
			} else if kind == "object" {
				let quest: Vec<(&String, &J)> = src.get("items").and_then(J::as_object).into_iter().flatten().filter(|(_, s)| s.get("quest").is_some_and(truthy)).collect();
				if quest.is_empty() {
					continue;
				}
				let c = chests.entry(who.to_string()).or_insert((0.0, IndexMap::new()));
				c.0 += nz(src.get("windows"));
				for (item, s) in quest {
					*c.1.entry(item.clone()).or_insert(0.0) += nz(s.get("drops"));
				}
			}
		}
	}
	let mut drops: IndexMap<i64, [IndexMap<i64, (f64, f64, f64)>; 2]> = IndexMap::new();
	for (who, by) in &tied {
		let mut best: IndexMap<String, (&Tied, f64)> = IndexMap::new();
		for (q, t) in by {
			if t.windows == 0.0 {
				continue;
			}
			let need = needs.get(q);
			for (item, &k) in &t.items {
				if need.is_some_and(|n| !n.contains(&(forge_guide::js::str_to_num(item) as i64))) {
					continue;
				}
				if best.get(item).is_none_or(|cur| t.windows > cur.0.windows) {
					best.insert(item.clone(), (t, k));
				}
			}
		}
		for (item, (t, k)) in best {
			let known = t.deaths - t.unknown;
			let share = if known > 0.0 { (known - t.empty) / known } else { 1.0 };
			drops.entry(forge_guide::js::str_to_num(&item) as i64).or_default()[0].insert(forge_guide::js::str_to_num(who) as i64, (percent((share * k) / t.windows), k, t.windows));
		}
	}
	for (who, (windows, items)) in &chests {
		if *windows == 0.0 {
			continue;
		}
		for (item, &k) in items {
			drops.entry(forge_guide::js::str_to_num(item) as i64).or_default()[1].insert(forge_guide::js::str_to_num(who) as i64, (percent(k / windows), k, *windows));
		}
	}
	drops.sort_keys();
	for v in drops.values_mut() {
		v[0].sort_keys();
		v[1].sort_keys();
	}
	Ok(Some(Eg { commit: EG_COMMIT.to_string(), quests, drops }))
}

pub struct Vo {
	pub commit: String,
	pub quests: IndexMap<i64, (Ends, Ends)>,
}

fn trusted(addon: Option<&J>) -> bool {
	let s = match addon.filter(|v| truthy(v)) {
		Some(J::String(s)) => s.clone(),
		Some(J::Number(n)) => forge_guide::js::num_str(n.as_f64().unwrap_or(0.0)),
		_ => "0".to_string(),
	};
	let s = if s.is_empty() { "0".to_string() } else { s };
	let v: Vec<f64> = s.split('.').map(forge_guide::js::str_to_num).collect();
	let since = [0.0, 1.0, 3.0];
	for (i, want) in since.iter().enumerate() {
		let x = v.get(i).copied().map(|x| if x.is_nan() { 0.0 } else { x }).unwrap_or(0.0);
		if x != *want {
			return x > *want;
		}
	}
	true
}

pub fn load_vo(sources: &Path, log: &dyn Fn(&str)) -> Result<Option<Vo>, String> {
	let file = sources.join("forever-vo").join(&VO_COMMIT[..12]).join("capture.json");
	let Some(capture) = read(&file)? else {
		log(&format!("forever-vo: --offline, {} not cached", file.display()));
		return Ok(None);
	};
	let mut sides: IndexMap<i64, [IndexSet<String>; 2]> = IndexMap::new();
	for line in capture.get("quests").and_then(J::as_object).into_iter().flatten().map(|(_, v)| v) {
		let side = match line.get("event").and_then(J::as_str) {
			Some("accept") => 0,
			Some("progress" | "complete") => 1,
			_ => continue,
		};
		let id = match line.get("questID") {
			Some(J::Number(n)) => n.as_f64().unwrap_or(f64::NAN),
			Some(J::String(s)) => forge_guide::js::str_to_num(s),
			Some(J::Null) => 0.0,
			None => f64::NAN,
			Some(J::Bool(b)) => *b as i32 as f64,
			_ => f64::NAN,
		};
		if !crate::jsv::is_int(id) {
			continue;
		}
		let set = &mut sides.entry(id as i64).or_default()[side];
		for who in line.get("speakers").and_then(J::as_object).into_iter().flatten().map(|(k, _)| k) {
			if !who.is_empty() && who.bytes().all(|b| b.is_ascii_digit()) {
				set.insert(format!("npc:{who}"));
			}
		}
		let npc = match line.get("npc").filter(|v| truthy(v)) {
			Some(J::String(s)) => s.clone(),
			Some(J::Number(n)) => forge_guide::js::num_str(n.as_f64().unwrap_or(f64::NAN)),
			Some(J::Bool(b)) => b.to_string(),
			_ => String::new(),
		};
		let digits = |s: &str| !s.is_empty() && s.bytes().all(|b| b.is_ascii_digit());
		if let Some(o) = npc.strip_prefix('-').filter(|o| digits(o)) {
			set.insert(format!("object:{o}"));
		} else if digits(&npc) && !line.get("isObject").is_some_and(truthy) && trusted(line.get("addon")) {
			set.insert(format!("npc:{npc}"));
		}
	}
	sides.sort_keys();
	let quests = sides.into_iter().map(|(id, [s, e])| (id, (ends(&s), ends(&e)))).collect();
	Ok(Some(Vo { commit: VO_COMMIT.to_string(), quests }))
}
