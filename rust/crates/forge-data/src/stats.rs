//! The data validation gate (port of tools/lib/data/stats.js; docs/ARCHITECTURE.md, Reference data,
//! "Validation"): field statistics of a data/forever build and of our guides compiled on it,
//! compared with the last good build's, so a large unexpected shift stops the build before the
//! world, routes and guides are rebuilt on bad data.
//!
//! The statistics (counts, and shares in 0..1):
//!   <table>.total                       quests, npcs, objects, items, zones
//!   quests.withGiver / withEnder        a start (NPC, object or item) / an end
//!   quests.giverKnown / enderKnown      every start / end NPC and object in npcs/objects.json
//!   quests.objectivesKnown              objectives whose NPC, object or item the data has
//!   quests.giverInZone                  quests with an NPC giver spawning on the quest's zone map
//!   quests.raceLimited / classLimited   a race / class mask that is not "every one"
//!   quests.races.<mask>                 quests per race mask (masks held by 20 or more)
//!   npcs.withSpawns / objects.withSpawns
//!   sources.areas                       AreaTable rows the compiler reads (data/sources)
//!   tokens.<kind>                       name tokens per kind in our guides compiled on the data
//!   compile.errors / compile.warnings
//!   names.matched                       share of the guides' tokens the deDE names addon names
//!   quests.rewardSpell                  quests with a reward spell
//!   quests.xp.count / quests.xp.sum     quests with XP, and their XP added up
//!   kb.xpChanges                        quest XP values the knowledge base changed
//!   corrections.total                   our corrections applied (meta.json counts.corrections)
//!   training.spells                     class training rows (training.json spells)
//!   riding.trainers / riding.vendors    riding trainers and mount vendors (training.json riding)

use std::path::{Path, PathBuf};

use forge_core::jsnum::js_to_fixed;
use forge_guide::js::{num_str, stringify, Obj, V};
use indexmap::IndexMap;

use crate::extras::read_json;

pub const STATS_FILE: &str = "stats.json";
pub const GOOD_FILE: &str = "stats-good.json";
const SCHEMA: f64 = 1.0;
/// A race mask's own field once this many quests hold it.
const MASK_MIN: usize = 20;

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum Limit {
	/// Relative change of a count.
	Rel(f64),
	/// Change of a share (0..1), or of a count that must not move.
	Abs(f64),
}

/// What a shift may be before it stops the build, per field (the first matching prefix; a leading
/// "." matches the end).
pub const LIMITS: [(&str, Limit); 14] = [
	("sources.", Limit::Rel(0.01)),
	("tokens.", Limit::Rel(0.05)),
	("compile.errors", Limit::Abs(0.0)),
	("compile.", Limit::Rel(0.25)),
	("names.", Limit::Abs(0.02)),
	("quests.races.", Limit::Rel(0.1)),
	("corrections.", Limit::Abs(0.0)),
	("riding.", Limit::Abs(0.0)),
	("quests.xp.", Limit::Rel(0.005)),
	("kb.", Limit::Rel(0.05)),
	("quests.rewardSpell", Limit::Rel(0.02)),
	("training.", Limit::Rel(0.02)),
	(".total", Limit::Rel(0.02)),
	("", Limit::Abs(0.02)),
];

pub fn limit_of(field: &str) -> Limit {
	for (p, l) in LIMITS {
		if if p.starts_with('.') { field.ends_with(p) } else { field.starts_with(p) } {
			return l;
		}
	}
	LIMITS[LIMITS.len() - 1].1
}

fn share(n: usize, d: usize) -> f64 {
	if d == 0 {
		0.0
	} else {
		n as f64 / d as f64
	}
}

fn round(x: f64) -> f64 {
	forge_core::jsnum::js_round(x * 1e6) / 1e6
}

/// The statistics: field -> number, in the order they are computed.
pub struct Stats {
	/// meta.json's builtAt: None when meta.json is unreadable (null), Some(Undef) when it has none.
	pub built_at: V,
	pub fields: IndexMap<String, f64>,
}

impl Stats {
	pub fn to_v(&self) -> V {
		let o = Obj::new();
		o.set("schema", SCHEMA);
		if !self.built_at.is_undef() {
			o.set("builtAt", self.built_at.clone());
		}
		let f = Obj::new();
		for (k, v) in &self.fields {
			f.set(k, *v);
		}
		o.set("fields", f);
		V::Obj(o)
	}

	/// The stats.json text (tab-indented, a newline at the end).
	pub fn text(&self) -> String {
		format!("{}\n", stringify(&self.to_v(), Some("\t")))
	}

	pub fn from_v(v: &V) -> Stats {
		let mut fields = IndexMap::new();
		for (k, x) in v.get("fields").entries() {
			fields.insert(k.to_string(), x.num());
		}
		Stats { built_at: v.get("builtAt"), fields }
	}
}

fn table(data: &Path, name: &str) -> Result<V, String> {
	read_json(&data.join(name))?.ok_or_else(|| format!("{}: no such file", data.join(name).display()))
}

fn ids(s: &V, k: &str) -> Vec<V> {
	let v = s.get(k);
	if v.is_arr() {
		v.items()
	} else {
		Vec::new()
	}
}

/// The race masks of "every race", and the class masks of "every class".
fn all_races(v: &V) -> bool {
	match v {
		V::Null => true,
		V::Num(n) => [0.0, 255.0, 511.0, 1791.0, 2047.0, 4294967295.0].contains(n),
		_ => false,
	}
}
fn all_classes(v: &V) -> bool {
	match v {
		V::Null => true,
		V::Num(n) => [0.0, 1535.0, 4294967295.0].contains(n),
		_ => false,
	}
}

/// computeStats: `sources` None reads <data>/../sources; `guides` (our guides) and `names` (the
/// deDE names addon) add the compile fields.
pub fn compute(data: &Path, sources: Option<&Path>, guides: Option<&Path>, names: Option<&Path>) -> Result<Stats, String> {
	let mut f: IndexMap<String, f64> = IndexMap::new();
	let quests = table(data, "quests.json")?;
	let npcs = table(data, "npcs.json")?;
	let objects = table(data, "objects.json")?;
	let items = table(data, "items.json")?;
	let zones = table(data, "zones.json")?;
	let q_all = quests.values();
	f.insert("quests.total".into(), q_all.len() as f64);
	f.insert("npcs.total".into(), npcs.len() as f64);
	f.insert("objects.total".into(), objects.len() as f64);
	f.insert("items.total".into(), items.len() as f64);
	f.insert("zones.total".into(), zones.len() as f64);
	let has = |t: &V, id: &V| t.get(&id.to_js_string()).truthy();
	let (mut giver, mut ender, mut giver_known, mut ender_known, mut objs, mut objs_known, mut in_zone, mut npc_giver, mut race, mut cls) = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	let mut masks: Vec<(f64, usize)> = Vec::new();
	for q in &q_all {
		let (sn, so, si) = (ids(&q.get("start"), "npc"), ids(&q.get("start"), "object"), ids(&q.get("start"), "item"));
		let (en, eo) = (ids(&q.get("end"), "npc"), ids(&q.get("end"), "object"));
		if !sn.is_empty() || !so.is_empty() || !si.is_empty() {
			giver += 1;
			if sn.iter().all(|id| has(&npcs, id)) && so.iter().all(|id| has(&objects, id)) {
				giver_known += 1;
			}
		}
		if !en.is_empty() || !eo.is_empty() {
			ender += 1;
			if en.iter().all(|id| has(&npcs, id)) && eo.iter().all(|id| has(&objects, id)) {
				ender_known += 1;
			}
		}
		for o in q.get("objectives").items() {
			let t = match o.get("type").as_str() {
				Some("kill" | "npc" | "talk") => &npcs,
				Some("object") => &objects,
				Some("item") => &items,
				_ => continue,
			};
			if o.get("id").is_nullish() {
				continue;
			}
			objs += 1;
			if has(t, &o.get("id")) {
				objs_known += 1;
			}
		}
		let zone = q.get("zone");
		if !sn.is_empty() && !zone.is_nullish() {
			npc_giver += 1;
			let z = zone.to_js_string();
			if sn.iter().any(|id| npcs.get(&id.to_js_string()).get("spawns").get(&z).truthy()) {
				in_zone += 1;
			}
		}
		if !all_races(&q.get("races")) {
			race += 1;
		}
		if !all_classes(&q.get("classes")) {
			cls += 1;
		}
		let r = q.get("races");
		let m = if r.is_nullish() { 0.0 } else { r.num() };
		match masks.iter_mut().find(|x| x.0 == m || (x.0.is_nan() && m.is_nan())) {
			Some(x) => x.1 += 1,
			None => masks.push((m, 1)),
		}
	}
	let n = q_all.len();
	f.insert("quests.withGiver".into(), round(share(giver, n)));
	f.insert("quests.withEnder".into(), round(share(ender, n)));
	f.insert("quests.giverKnown".into(), round(share(giver_known, giver)));
	f.insert("quests.enderKnown".into(), round(share(ender_known, ender)));
	f.insert("quests.objectivesKnown".into(), round(share(objs_known, objs)));
	f.insert("quests.giverInZone".into(), round(share(in_zone, npc_giver)));
	f.insert("quests.raceLimited".into(), round(share(race, n)));
	f.insert("quests.classLimited".into(), round(share(cls, n)));
	f.insert("quests.rewardSpell".into(), q_all.iter().filter(|q| !q.get("rewardSpell").is_nullish()).count() as f64);
	let xps: Vec<f64> = q_all
		.iter()
		.map(|q| {
			let x = q.get("xp");
			let n = if x.is_nullish() {
				0.0
			} else if x.is_str() {
				forge_guide::js::str_to_num(&x.to_js_string())
			} else {
				x.num()
			};
			if n.is_nan() {
				0.0
			} else {
				n
			}
		})
		.filter(|x| *x > 0.0)
		.collect();
	f.insert("quests.xp.count".into(), xps.len() as f64);
	f.insert("quests.xp.sum".into(), xps.iter().fold(0.0, |a, b| a + b));
	let meta = read_json(&data.join("meta.json")).ok().flatten();
	let counts = meta.as_ref().map(|m| m.get("counts")).filter(V::truthy).unwrap_or_else(V::obj);
	if !counts.get("corrections").is_nullish() {
		f.insert("corrections.total".into(), counts.get("corrections").num());
	}
	let xp_kb = counts.get("knowledgeBase").get("byClass").get("quests.xp");
	if xp_kb.truthy() {
		f.insert("kb.xpChanges".into(), xp_kb.values().iter().fold(0.0, |a, b| a + b.num()));
	}
	let training = read_json(&data.join("training.json"))?;
	if let Some(t) = training.as_ref().filter(|t| t.truthy()) {
		if t.get("spells").truthy() {
			let n: usize = t.get("spells").values().iter().map(|per| per.values().iter().map(V::len).sum::<usize>()).sum();
			f.insert("training.spells".into(), n as f64);
		}
		let riding = t.get("riding");
		if riding.truthy() {
			f.insert("riding.trainers".into(), riding.get("trainers").len() as f64);
			f.insert("riding.vendors".into(), riding.get("vendors").keys().len() as f64);
		}
	}
	masks.sort_by(|a, b| (a.0 - b.0).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
	for (m, c) in masks {
		if c >= MASK_MIN {
			f.insert(format!("quests.races.{}", num_str(m)), c as f64);
		}
	}
	let with_spawns = |t: &V| {
		let all = t.values();
		round(share(all.iter().filter(|x| x.get("spawns").truthy() && !x.get("spawns").keys().is_empty()).count(), all.len()))
	};
	f.insert("npcs.withSpawns".into(), with_spawns(&npcs));
	f.insert("objects.withSpawns".into(), with_spawns(&objects));
	let src = sources.map(Path::to_path_buf).unwrap_or_else(|| data.join("..").join("sources"));
	let areas = forge_guide::areas::load_areas(&src);
	f.insert("sources.areas".into(), if areas.truthy() { areas.get("byId").keys().len() as f64 } else { 0.0 });
	if let Some(g) = guides.filter(|g| g.exists()) {
		let mut diag = forge_guide::diag::Diagnostics::new();
		let d = forge_guide::project::load_project_data(data, &mut diag)?;
		let c = forge_guide::project::compile_project(g, &V::Undef, &d, diag, false, None);
		for (k, n) in c.tokens.get("replaced").entries() {
			f.insert(format!("tokens.{k}"), n.num());
		}
		f.insert("compile.errors".into(), c.diag.list.iter().filter(|d| d.severity == "error").count() as f64);
		f.insert("compile.warnings".into(), c.diag.list.iter().filter(|d| d.severity != "error").count() as f64);
		if let Some(file) = names.filter(|n| n.exists()) {
			let named = names_of(&std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?);
			let (mut used, mut hit) = (0, 0);
			for g in &c.guides {
				for k in g.hidden("_localised").get("names").keys() {
					used += 1;
					if named.contains(&*k) {
						hit += 1;
					}
				}
			}
			f.insert("names.matched".into(), round(share(hit, used)));
		}
	}
	let built_at = match meta {
		Some(m) => m.get("builtAt"),
		None => V::Null,
	};
	Ok(Stats { built_at, fields: f })
}

/// A names addon's "kind:id" keys (Names.lua: R("quest", 2, 5, [[ then one "<id>\t<name>" line per name).
pub fn names_of(text: &str) -> rustc_hash::FxHashSet<String> {
	let head = regex::Regex::new(r#"^R\("([a-z]+)", "#).unwrap();
	let entry = regex::Regex::new(r"^([0-9]+)\t").unwrap();
	let mut out = rustc_hash::FxHashSet::default();
	let mut kind: Option<String> = None;
	for line in text.split('\n') {
		if let Some(h) = head.captures(line) {
			kind = Some(h[1].to_string());
		}
		if let (Some(k), Some(m)) = (&kind, entry.captures(line)) {
			out.insert(format!("{k}:{}", &m[1]));
		}
	}
	out
}

pub struct Row {
	pub field: String,
	pub was: Option<f64>,
	pub now: Option<f64>,
	pub change: Option<f64>,
	pub limit: Limit,
	pub bad: bool,
	pub why: &'static str,
}

pub struct Comparison {
	pub ok: bool,
	pub rows: Vec<Row>,
}

/// compareStats: every field of either, sorted.
pub fn compare(good: Option<&Stats>, now: &Stats) -> Comparison {
	let empty = IndexMap::new();
	let a = good.map(|g| &g.fields).unwrap_or(&empty);
	let b = &now.fields;
	let mut fields: Vec<&String> = a.keys().chain(b.keys()).collect();
	fields.sort_by(|x, y| forge_guide::js::cmp_utf16(x, y));
	fields.dedup();
	let mut rows = Vec::new();
	for field in fields {
		let (was, is) = (a.get(field).copied(), b.get(field).copied());
		let limit = limit_of(field);
		let (mut bad, mut why, mut change) = (false, "", None);
		match (was, is) {
			(None, _) => why = "new",
			(Some(_), None) => {
				bad = !field.starts_with("quests.races."); // a mask may fall under MASK_MIN
				why = "gone";
			}
			(Some(w), Some(n)) => {
				let rel = if w == 0.0 {
					if n == 0.0 {
						0.0
					} else {
						f64::INFINITY
					}
				} else {
					(n - w) / w.abs()
				};
				let abs = n - w;
				change = Some(match limit {
					Limit::Abs(_) => abs,
					Limit::Rel(_) => rel,
				});
				bad = match limit {
					Limit::Rel(l) => rel.abs() > l,
					Limit::Abs(l) => abs.abs() > l,
				};
			}
		}
		rows.push(Row { field: field.clone(), was, now: is, change, limit, bad, why });
	}
	Comparison { ok: !rows.iter().any(|r| r.bad), rows }
}

fn pad_start(s: &str, n: usize) -> String {
	let len = s.encode_utf16().count();
	if len >= n {
		s.to_string()
	} else {
		format!("{}{s}", " ".repeat(n - len))
	}
}

fn pad_end(s: &str, n: usize) -> String {
	let len = s.encode_utf16().count();
	if len >= n {
		s.to_string()
	} else {
		format!("{s}{}", " ".repeat(n - len))
	}
}

/// formatReport: the shifted fields first; `all` lists every field, else the changed ones.
pub fn format_report(cmp: &Comparison, all: bool) -> String {
	let fmt = |v: Option<f64>| match v {
		None => "-".to_string(),
		Some(x) if forge_guide::js::is_integer(x) => num_str(x),
		Some(x) => js_to_fixed(x, 4),
	};
	let lim = |l: Limit| match l {
		Limit::Rel(r) => format!("±{}%", js_to_fixed(r * 100.0, 0)),
		Limit::Abs(a) => format!("±{}", num_str(a)),
	};
	let chg = |r: &Row| match (r.change, r.limit) {
		(None, _) => r.why.to_string(),
		(Some(c), Limit::Rel(_)) => format!("{}{}%", if c >= 0.0 { "+" } else { "" }, js_to_fixed(c * 100.0, 1)),
		(Some(c), Limit::Abs(_)) => format!("{}{}", if c >= 0.0 { "+" } else { "" }, js_to_fixed(c, 4)),
	};
	let mut rows: Vec<&Row> = cmp.rows.iter().filter(|r| all || r.bad || r.change.is_some_and(|c| c != 0.0)).collect();
	rows.sort_by_key(|r| !r.bad);
	if rows.is_empty() {
		return "  every statistic as in the last good build".into();
	}
	rows.iter()
		.map(|r| {
			format!(
				"{}  {} {} -> {}  {}  (limit {})",
				if r.bad { "SHIFT" } else { "  ok " },
				pad_end(&r.field, 26),
				pad_start(&fmt(r.was), 10),
				pad_start(&fmt(r.now), 10),
				pad_start(&chg(r), 8),
				lim(r.limit)
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

/// <dir>/stats-good.json, when readable.
pub fn read_good(dir: &Path) -> Option<Stats> {
	read_json(&dir.join(GOOD_FILE)).ok().flatten().map(|v| Stats::from_v(&v))
}

/// <dir>/stats.json, and stats-good.json when they are good.
pub fn write_stats(dir: &Path, now: &Stats, good: bool) -> Result<(), String> {
	let text = now.text();
	for f in if good { &[STATS_FILE, GOOD_FILE][..] } else { &[STATS_FILE][..] } {
		let file = dir.join(f);
		let tmp = PathBuf::from(format!("{}.tmp", file.display()));
		std::fs::write(&tmp, &text).map_err(|e| format!("{}: {e}", tmp.display()))?;
		std::fs::rename(&tmp, &file).map_err(|e| format!("{}: {e}", file.display()))?;
	}
	Ok(())
}

#[cfg(unix)]
fn link(target: &Path, at: &Path) -> std::io::Result<()> {
	std::os::unix::fs::symlink(target, at)
}
#[cfg(windows)]
fn link(target: &Path, at: &Path) -> std::io::Result<()> {
	if target.is_dir() {
		std::os::windows::fs::symlink_dir(target, at)
	} else {
		std::os::windows::fs::symlink_file(target, at)
	}
}

/// <out>.staging/: the new files over links to <out>'s other entries (codex/, gear/,
/// trainers.json...), so the compiler reads the build as it would read <out> after it. `dropped`:
/// the files this build removes from <out>. -> the staging folder
pub fn stage(out: &Path, files: &[(String, String)], dropped: &[&str]) -> Result<PathBuf, String> {
	let staging = PathBuf::from(format!("{}.staging", out.display()));
	let _ = std::fs::remove_dir_all(&staging);
	std::fs::create_dir_all(&staging).map_err(|e| format!("{}: {e}", staging.display()))?;
	let written: Vec<&str> = files.iter().map(|(n, _)| n.as_str()).collect();
	if let Ok(rd) = std::fs::read_dir(out) {
		let out_abs = std::path::absolute(out).unwrap_or_else(|_| out.to_path_buf());
		for e in rd.flatten() {
			let name = e.file_name().to_string_lossy().into_owned();
			if written.contains(&name.as_str()) || dropped.contains(&name.as_str()) || name.ends_with(".tmp") || name == STATS_FILE || name == GOOD_FILE {
				continue;
			}
			link(&out_abs.join(&name), &staging.join(&name)).map_err(|e| format!("{}: {e}", staging.join(&name).display()))?;
		}
	}
	for (name, text) in files {
		std::fs::write(staging.join(name), text).map_err(|e| format!("{}: {e}", staging.join(name).display()))?;
	}
	Ok(staging)
}

#[cfg(test)]
mod tests {
	use super::*;

	fn stats(fields: &[(&str, f64)]) -> Stats {
		Stats { built_at: V::str("2026-10-01T00:00:00.000Z"), fields: fields.iter().map(|(k, v)| (k.to_string(), *v)).collect() }
	}

	#[test]
	fn limits_take_the_first_matching_prefix() {
		assert_eq!(limit_of("compile.errors"), Limit::Abs(0.0));
		assert_eq!(limit_of("compile.warnings"), Limit::Rel(0.25));
		assert_eq!(limit_of("quests.total"), Limit::Rel(0.02));
		assert_eq!(limit_of("quests.withGiver"), Limit::Abs(0.02));
		assert_eq!(limit_of("quests.races.77"), Limit::Rel(0.1));
	}

	#[test]
	fn a_shift_past_its_limit_is_bad_and_reported_first() {
		let good = stats(&[("quests.total", 1000.0), ("quests.withGiver", 0.9), ("compile.errors", 0.0), ("quests.races.77", 30.0), ("npcs.total", 50.0)]);
		let now = stats(&[("quests.total", 1010.0), ("quests.withGiver", 0.85), ("compile.errors", 1.0), ("tokens.npc", 5.0), ("npcs.total", 50.0)]);
		let cmp = compare(Some(&good), &now);
		assert!(!cmp.ok);
		let bad: Vec<&str> = cmp.rows.iter().filter(|r| r.bad).map(|r| r.field.as_str()).collect();
		assert_eq!(bad, vec!["compile.errors", "quests.withGiver"], "1% on a count passes, a mask may fall away");
		let report = format_report(&cmp, false);
		let lines: Vec<&str> = report.lines().collect();
		assert_eq!(lines[0], "SHIFT  compile.errors                      0 ->          1   +1.0000  (limit ±0)");
		assert_eq!(lines[1], "SHIFT  quests.withGiver               0.9000 ->     0.8500   -0.0500  (limit ±0.02)");
		assert_eq!(lines[2], "  ok   quests.total                     1000 ->       1010     +1.0%  (limit ±2%)");
		assert_eq!(lines.len(), 3, "unchanged, new and gone-mask rows are listed only with --all");
		assert_eq!(format_report(&cmp, true).lines().count(), 6);
		assert!(compare(Some(&now), &now).ok);
		assert_eq!(format_report(&compare(Some(&now), &now), false), "  every statistic as in the last good build");
		assert!(compare(None, &now).ok, "the first build has nothing to shift from");
	}

	#[test]
	fn computes_the_data_fields_and_round_trips() {
		let d = std::env::temp_dir().join(format!("forge-stats-{}", std::process::id()));
		let data = d.join("forever");
		std::fs::create_dir_all(&data).unwrap();
		let w = |n: &str, t: &str| std::fs::write(data.join(n), t).unwrap();
		w(
			"quests.json",
			r#"{"1":{"id":1,"start":{"npc":[5]},"end":{"npc":[6]},"zone":12,"races":null,"classes":null,"objectives":[{"type":"kill","id":5},{"type":"item","id":9}],"xp":100},"2":{"id":2,"start":{"object":[7]},"end":{"npc":[]},"races":77,"classes":4,"xp":null,"rewardSpell":3}}"#,
		);
		w("npcs.json", r#"{"5":{"spawns":{"12":{}}},"6":{"spawns":{}}}"#);
		w("objects.json", "{}");
		w("items.json", "{}");
		w("zones.json", r#"{"12":{}}"#);
		w("meta.json", r#"{"builtAt":"x","counts":{"corrections":4}}"#);
		let s = compute(&data, None, None, None).unwrap();
		let get = |k: &str| s.fields[k];
		assert_eq!((get("quests.total"), get("quests.withGiver"), get("quests.withEnder"), get("quests.giverKnown")), (2.0, 1.0, 0.5, 0.5));
		assert_eq!((get("quests.objectivesKnown"), get("quests.giverInZone"), get("quests.raceLimited")), (0.5, 1.0, 0.5));
		assert_eq!((get("quests.xp.count"), get("quests.xp.sum"), get("quests.rewardSpell"), get("corrections.total")), (1.0, 100.0, 1.0, 4.0));
		assert_eq!((get("npcs.withSpawns"), get("sources.areas")), (0.5, 0.0));
		write_stats(&data, &s, true).unwrap();
		let back = read_good(&data).unwrap();
		assert!(compare(Some(&back), &s).ok);
		assert_eq!(std::fs::read_to_string(data.join(STATS_FILE)).unwrap(), s.text());
		// Staging links the other entries and leaves the statistics out.
		std::fs::create_dir_all(data.join("codex")).unwrap();
		let st = stage(&data, &[("quests.json".into(), "{}\n".into())], &["spawnz.json"]).unwrap();
		assert!(st.join("codex").exists() && st.join("npcs.json").exists() && !st.join(GOOD_FILE).exists());
		assert_eq!(std::fs::read_to_string(st.join("quests.json")).unwrap(), "{}\n");
		std::fs::remove_dir_all(&d).unwrap();
	}

	#[test]
	fn reward_spells_xp_kb_changes_corrections_training_and_riding_are_fields() {
		let d = std::env::temp_dir().join(format!("forge-stats-fields-{}", std::process::id()));
		std::fs::create_dir_all(&d).unwrap();
		let w = |n: &str, t: &str| std::fs::write(d.join(n), t).unwrap();
		w("quests.json", r#"{"1":{"id":1,"xp":400,"rewardSpell":8616},"2":{"id":2,"xp":600},"3":{"id":3}}"#);
		for f in ["npcs.json", "objects.json", "items.json", "zones.json"] {
			w(f, "{}");
		}
		w("meta.json", r#"{"builtAt":"x","counts":{"corrections":12,"knowledgeBase":{"byClass":{"quests.xp":{"eg":3,"page":2}}}}}"#);
		w(
			"training.json",
			r#"{"schema":1,"spells":{"MAGE":{"4":[[116,100,"Frostbolt",1],[5504,100,"Conjure Water",1]]},"WARRIOR":{"1":[[6673,10,"Battle Shout",1]]}},"riding":{"level":40,"trainers":[{"id":1},{"id":2}],"vendors":{"7":[1,2]}}}"#,
		);
		let s = compute(&d, Some(&d), None, None).unwrap();
		let f = |k: &str| s.fields[k];
		assert_eq!(
			[f("quests.rewardSpell"), f("quests.xp.count"), f("quests.xp.sum"), f("kb.xpChanges"), f("corrections.total"), f("training.spells"), f("riding.trainers"), f("riding.vendors")],
			[1.0, 2.0, 1000.0, 5.0, 12.0, 3.0, 2.0, 1.0]
		);
		let with = |k: &str, v: f64| {
			let mut t = Stats { built_at: V::Undef, fields: s.fields.clone() };
			t.fields.insert(k.into(), v);
			t
		};
		assert!(!compare(Some(&s), &with("corrections.total", 13.0)).ok, "one more correction");
		assert!(!compare(Some(&s), &with("quests.xp.sum", 1010.0)).ok, "XP up 1%");
		assert!(compare(Some(&s), &with("quests.xp.sum", 1004.0)).ok, "XP within 0.5%");
		assert!(!compare(Some(&s), &with("riding.vendors", 0.0)).ok, "a mount vendor gone");
		std::fs::remove_dir_all(&d).unwrap();
	}

	#[test]
	fn names_addon_keys() {
		let n = names_of("R(\"quest\", 2, 2, [[\n\n2\tx\n]])\nR(\"npc\", 5, 5, [[\n\n5\ty\n]])\n");
		assert!(n.contains("quest:2") && n.contains("npc:5") && n.len() == 2);
	}
}
