//! tools/lib/consume/wowsims.js, the read-from-cache path (`readWowsims({ cacheDir })`): stat
//! weights (EP) from the wowsims UI sources at pinned commits. The gear presets are read (a bad
//! one fails the read, as in JS) but not kept: the gear build uses `meta`, `weights` and the
//! rejected count.

use std::path::{Path, PathBuf};

use forge_guide::js::{parse_json, str_to_num, Arr, Obj, V};

use crate::jsv::math_round;

const CLASSIC_HEAD: &str = "7779ebbf79dc7f1341e6ab939b28a3402c9a730a";
const CLASSIC_CUTOVER: &str = "5634c852d47acfcc5b6b62a6472a536df64634dc";
const LICENCE_URL: &str = "https://github.com/wowsims/classic/blob/master/LICENSE";

pub fn licence_rel() -> PathBuf {
	Path::new("classic").join(CLASSIC_HEAD).join("LICENSE")
}

fn repo_name(repo: &str) -> &'static str {
	if repo == "classic" {
		"wowsims/classic"
	} else {
		"wowsims/sod"
	}
}

struct Snap {
	repo: &'static str,
	commit: &'static str,
	date: &'static str,
	level: f64,
	phase: &'static str,
	season: &'static str,
}

const SNAPSHOTS: [Snap; 5] = [
	Snap { repo: "sod", commit: "19c880c1a8a8f87ecf8b96d6d6aaf6fca9bfb06a", date: "2024-01-30", level: 25.0, phase: "sod-p1", season: "sod" },
	Snap { repo: "sod", commit: "6f19e7806cccdc2e215bbf9c4ae7a07c26cd6ee3", date: "2024-03-25", level: 40.0, phase: "sod-p2", season: "sod" },
	Snap { repo: "sod", commit: "9568974bd605da01a973c0173c491d40371eedec", date: "2024-06-28", level: 50.0, phase: "sod-p3", season: "sod" },
	Snap { repo: "sod", commit: "0e3f6eff5fa3ad356664a1c2abbd02903d4cc97e", date: "2026-07-24", level: 60.0, phase: "sod-latest", season: "sod" },
	Snap { repo: "classic", commit: CLASSIC_HEAD, date: "2026-07-24", level: 60.0, phase: "era", season: "era" },
];

type Sim = (&'static str, &'static [&'static str], &'static [(&'static str, &'static str)]);
const SIMS: [Sim; 18] = [
	("warrior", &["warrior"], &[("WARRIOR", "arms"), ("WARRIOR", "fury")]),
	("tank_warrior", &["tank_warrior", "protection_warrior"], &[("WARRIOR", "protection")]),
	("holy_paladin", &["holy_paladin"], &[("PALADIN", "holy")]),
	("protection_paladin", &["protection_paladin"], &[("PALADIN", "protection")]),
	("retribution_paladin", &["retribution_paladin"], &[("PALADIN", "retribution")]),
	("hunter", &["hunter"], &[("HUNTER", "beastmastery"), ("HUNTER", "marksmanship"), ("HUNTER", "survival")]),
	("rogue", &["rogue"], &[("ROGUE", "assassination"), ("ROGUE", "combat"), ("ROGUE", "subtlety")]),
	("healing_priest", &["healing_priest"], &[("PRIEST", "discipline"), ("PRIEST", "holy")]),
	("shadow_priest", &["shadow_priest"], &[("PRIEST", "shadow")]),
	("elemental_shaman", &["elemental_shaman"], &[("SHAMAN", "elemental")]),
	("enhancement_shaman", &["enhancement_shaman"], &[("SHAMAN", "enhancement")]),
	("restoration_shaman", &["restoration_shaman"], &[("SHAMAN", "restoration")]),
	("mage", &["mage"], &[("MAGE", "arcane"), ("MAGE", "fire"), ("MAGE", "frost")]),
	("warlock", &["warlock"], &[("WARLOCK", "affliction"), ("WARLOCK", "demonology"), ("WARLOCK", "destruction")]),
	("balance_druid", &["balance_druid"], &[("DRUID", "balance")]),
	("feral_druid", &["feral_druid"], &[("DRUID", "feral")]),
	("feral_tank_druid", &["feral_tank_druid"], &[("DRUID", "feraltank")]),
	("restoration_druid", &["restoration_druid"], &[("DRUID", "restoration")]),
];
const SKIPPED_SIMS: [(&str, &str); 3] = [("warden_shaman", "SoD-only tank shaman"), ("tank_rogue", "SoD-only tank rogue"), ("tank_warlock", "SoD-only tank warlock")];

fn main_stat(cls: &str, spec: &str) -> &'static str {
	match (cls, spec) {
		("WARRIOR", _) => "str",
		("PALADIN", "holy") => "heal",
		("PALADIN", _) => "str",
		("HUNTER", _) | ("ROGUE", _) => "agi",
		("PRIEST", "shadow") => "sp",
		("PRIEST", _) => "heal",
		("SHAMAN", "elemental") => "sp",
		("SHAMAN", "enhancement") => "str",
		("SHAMAN", _) => "heal",
		("MAGE", _) | ("WARLOCK", _) => "sp",
		("DRUID", "balance") => "sp",
		("DRUID", "restoration") => "heal",
		("DRUID", _) => "agi",
		_ => "",
	}
}

const HEALER_SIMS: [&str; 4] = ["holy_paladin", "healing_priest", "restoration_shaman", "restoration_druid"];

fn stat_map(k: &str) -> Option<&'static str> {
	Some(match k {
		"StatStrength" => "str",
		"StatAgility" => "agi",
		"StatStamina" => "sta",
		"StatIntellect" => "int",
		"StatSpirit" => "spi",
		"StatArmor" => "armor",
		"StatHealth" => "health",
		"StatMana" => "mana",
		"StatAttackPower" => "ap",
		"StatRangedAttackPower" => "rap",
		"StatHealingPower" => "heal",
		"StatArcanePower" => "spArcane",
		"StatFirePower" => "spFire",
		"StatFrostPower" => "spFrost",
		"StatHolyPower" => "spHoly",
		"StatNaturePower" => "spNature",
		"StatShadowPower" => "spShadow",
		"StatMP5" => "mp5",
		"StatMeleeHit" => "hit",
		"StatMeleeCrit" => "crit",
		"StatSpellHit" => "spellHit",
		"StatSpellCrit" => "spellCrit",
		"StatDefense" => "defense",
		"StatDodge" => "dodge",
		"StatParry" => "parry",
		"StatBlock" => "block",
		"StatBlockValue" => "blockValue",
		"PseudoStatMainHandDps" => "dps",
		"PseudoStatRangedDps" => "rdps",
		_ => return None,
	})
}

const SCALE_STATS: [&str; 4] = ["StatMeleeHit", "StatMeleeCrit", "StatSpellHit", "StatSpellCrit"];
const MIN_PERCENT_EP: f64 = 3.0;

fn round(n: f64) -> f64 {
	math_round(n * 10000.0) / 10000.0
}

/// An insertion-ordered map (a JS object with non-index keys).
#[derive(Clone, Default, PartialEq)]
pub struct Ordered(pub Vec<(String, f64)>);
impl Ordered {
	pub fn get(&self, k: &str) -> Option<f64> {
		self.0.iter().find(|e| e.0 == k).map(|e| e.1)
	}
	pub fn set(&mut self, k: &str, v: f64) {
		match self.0.iter_mut().find(|e| e.0 == k) {
			Some(e) => e.1 = v,
			None => self.0.push((k.to_string(), v)),
		}
	}
	/// `o[k] > 0`.
	pub fn pos(&self, k: &str) -> bool {
		self.get(k).is_some_and(|v| v > 0.0)
	}
}

struct Parsed {
	raw: Ordered,
	reference: Option<String>,
}

fn parse_sim_ts(src: &str) -> Option<Parsed> {
	const OPEN: &str = "epWeights: Stats.fromMap(";
	let start = src.find(OPEN)?;
	let b = src.as_bytes();
	let mut depth = 0i64;
	let mut end = start + "epWeights: Stats.fromMap".len();
	while end < b.len() {
		if b[end] == b'(' {
			depth += 1;
		} else if b[end] == b')' {
			depth -= 1;
			if depth == 0 {
				break;
			}
		}
		end += 1;
	}
	let comment = regex::Regex::new(r"//[^\n]*").unwrap();
	let body = comment.replace_all(&src[start..end], "");
	let re = regex::Regex::new(r"\[(?:Stat|PseudoStat)\.(\w+)\]\s*:\s*(-?\d+(?:\.\d+)?|-?\.\d+)\s*[,}\n]").unwrap();
	let mut raw = Ordered::default();
	for m in re.captures_iter(&body) {
		raw.set(&m[1], str_to_num(&m[2]));
	}
	let reference = regex::Regex::new(r"epReferenceStat:\s*Stat\.(\w+)").unwrap().captures(src).map(|m| m[1].to_string());
	Some(Parsed { raw, reference })
}

fn percent_scale(raw: &Ordered, reference: Option<&str>) -> Option<f64> {
	let ref_weight = match reference.and_then(|r| raw.get(r)) {
		Some(w) if w > 1.0 => w,
		_ => 1.0,
	};
	let mut max: Option<f64> = None;
	for s in SCALE_STATS {
		if let Some(v) = raw.get(s).filter(|v| *v > 0.0) {
			max = Some(max.unwrap_or(0.0).max(v / ref_weight));
		}
	}
	max
}

fn reference_key(reference: Option<&str>, healer: bool) -> Option<&'static str> {
	match reference? {
		"StatSpellPower" => Some(if healer { "heal" } else { "sp" }),
		"StatSpellDamage" => Some("sp"),
		r => stat_map(r),
	}
}

fn map_weights(raw: &Ordered, healer: bool) -> (Ordered, Ordered) {
	let mut weights = Ordered::default();
	let mut dropped = Ordered::default();
	for (name, value) in &raw.0 {
		if *value == 0.0 || value.is_nan() {
			continue;
		}
		let key = if name == "StatSpellPower" { Some(if healer { "heal" } else { "sp" }) } else { stat_map(name) };
		let Some(key) = key else {
			dropped.set(name, *value);
			continue;
		};
		weights.set(key, weights.get(key).unwrap_or(0.0) + value);
	}
	(weights, dropped)
}

fn normalize(weights: &Ordered, main: &str, fallback: Option<&str>) -> Option<(Ordered, String)> {
	let to = if weights.pos(main) { main } else { fallback.filter(|f| weights.pos(f))? };
	let div = weights.get(to).unwrap();
	Some((Ordered(weights.0.iter().map(|(k, v)| (k.clone(), round(v / div))).collect()), to.to_string()))
}

/// presets.ts -> [(label, file)] for each makePresetGear over a gear_sets JSON.
fn parse_gear_presets(src: &str) -> Vec<(String, String)> {
	let mut files: Vec<(String, String)> = Vec::new();
	let imp = regex::Regex::new(r#"import\s+(\w+)\s+from\s+['"]\./gear_sets/([\w.\-]+\.gear\.json)['"]"#).unwrap();
	for m in imp.captures_iter(src) {
		match files.iter_mut().find(|f| f.0 == m[1]) {
			Some(f) => f.1 = m[2].to_string(),
			None => files.push((m[1].to_string(), m[2].to_string())),
		}
	}
	let mk = regex::Regex::new(r#"makePresetGear\(\s*['"]([^'"]+)['"]\s*,\s*(\w+)"#).unwrap();
	let mut out = Vec::new();
	for m in mk.captures_iter(src) {
		if let Some(f) = files.iter().find(|f| f.0 == m[2]) {
			out.push((m[1].to_string(), f.1.clone()));
		}
	}
	out
}

struct Source {
	cache: PathBuf,
	fetched: V,
}

impl Source {
	fn get(&self, repo: &str, commit: &str, file: &str) -> Result<Option<String>, String> {
		let mut p = self.cache.join(repo).join(commit);
		for part in file.split('/') {
			p.push(part);
		}
		if !p.exists() {
			return Ok(None);
		}
		let b = std::fs::read(&p).map_err(|e| format!("{}: {e}", p.display()))?;
		Ok(Some(String::from_utf8_lossy(&b).into_owned()))
	}
	fn sim_ts(&self, repo: &str, commit: &str, sim: &Sim) -> Result<Option<(String, Option<Parsed>)>, String> {
		for dir in sim.1 {
			let file = format!("ui/{dir}/sim.ts");
			if let Some(text) = self.get(repo, commit, &file)? {
				return Ok(Some((file, parse_sim_ts(&text))));
			}
		}
		Ok(None)
	}
}

/// One weights entry (the fields the gear build reads).
pub struct Entry {
	pub level: f64,
	pub phase: &'static str,
	pub repo: &'static str,
	pub file: String,
	pub commit: &'static str,
	pub origin: &'static str,
	pub weights: Ordered,
	pub normalized_to: String,
}
impl Entry {
	pub fn rune_influenced(&self) -> bool {
		self.origin != "era"
	}
}

pub struct Wowsims {
	pub meta: Obj,
	/// (class, spec) -> entries, in the order JS pushes them.
	pub weights: Vec<((String, String), Vec<Entry>)>,
	pub rejected: usize,
}

impl Wowsims {
	pub fn entries(&self, cls: &str, spec: &str) -> Option<&[Entry]> {
		self.weights.iter().find(|(k, _)| k.0 == cls && k.1 == spec).map(|(_, e)| e.as_slice())
	}
}

/// readWowsims({ cacheDir }) without fetching. Errors carry the JS message.
pub fn read_wowsims(cache_dir: &Path) -> Result<Wowsims, String> {
	let manifest_file = cache_dir.join("manifest.json");
	if !manifest_file.exists() {
		return Err(format!("wowsims: no cache at {}; run with {{ fetch: true }}", cache_dir.display()));
	}
	let text = std::fs::read(&manifest_file).map_err(|e| e.to_string())?;
	let manifest = parse_json(&String::from_utf8_lossy(&text))?;
	let src = Source { cache: cache_dir.to_path_buf(), fetched: manifest.get("fetched") };

	let mut weights: Vec<((String, String), Vec<Entry>)> = Vec::new();
	let mut rejected = 0usize;
	for snap in &SNAPSHOTS {
		for sim in &SIMS {
			let Some((file, Some(parsed))) = src.sim_ts(snap.repo, snap.commit, sim)? else { continue };
			let healer = HEALER_SIMS.contains(&sim.0);
			let scale = percent_scale(&parsed.raw, parsed.reference.as_deref());
			if scale.is_none_or(|s| s < MIN_PERCENT_EP) {
				rejected += 1;
				continue;
			}
			let mut origin = snap.season;
			if snap.season == "era" {
				let cut = src.sim_ts("classic", CLASSIC_CUTOVER, sim)?;
				let kept = match &cut {
					Some((_, Some(c))) => parsed.raw.0.iter().filter(|(k, _)| stat_map(k).is_some() || k == "StatSpellPower").all(|(k, v)| c.raw.get(k) == Some(*v)),
					_ => false,
				};
				origin = if kept { "sod-carryover" } else { "era" };
			}
			let (mapped, _dropped) = map_weights(&parsed.raw, healer);
			for (cls, spec) in sim.2 {
				let Some((w, to)) = normalize(&mapped, main_stat(cls, spec), reference_key(parsed.reference.as_deref(), healer)) else {
					rejected += 1;
					continue;
				};
				let entry = Entry { level: snap.level, phase: snap.phase, repo: repo_name(snap.repo), file: file.clone(), commit: snap.commit, origin, weights: w, normalized_to: to };
				match weights.iter_mut().find(|(k, _)| k.0 == *cls && k.1 == *spec) {
					Some((_, list)) => list.push(entry),
					None => weights.push(((cls.to_string(), spec.to_string()), vec![entry])),
				}
			}
		}
	}

	// Era gear sets (classic HEAD): read so a malformed set fails as in JS; not kept.
	for sim in &SIMS {
		let dir = sim.1[0];
		let Some(presets) = src.get("classic", CLASSIC_HEAD, &format!("ui/{dir}/presets.ts"))? else { continue };
		for (label, file) in parse_gear_presets(&presets) {
			if label.eq_ignore_ascii_case("blank") {
				continue;
			}
			let Some(json) = src.get("classic", CLASSIC_HEAD, &format!("ui/{dir}/gear_sets/{file}"))? else { continue };
			parse_json(&json)?;
		}
	}

	let licence = src.get("classic", CLASSIC_HEAD, "LICENSE")?;
	let meta = Obj::new();
	meta.set("source", V::str("wowsims"));
	meta.set("url", V::str("https://github.com/wowsims"));
	meta.set("licence", V::str(if licence.is_some_and(|l| l.contains("MIT License")) { "MIT" } else { "MIT (LICENSE not cached)" }));
	meta.set("licenceUrl", V::str(LICENCE_URL));
	let mut version: Vec<V> = SNAPSHOTS.iter().map(|s| V::str(&format!("{}@{} ({}, {})", repo_name(s.repo), s.commit, s.phase, s.date))).collect();
	version.push(V::str(&format!("wowsims/classic@{CLASSIC_CUTOVER} (era cutover baseline)")));
	meta.set("version", V::Arr(Arr::from_vec(version)));
	let commits = Obj::new();
	commits.set("classic", V::str(CLASSIC_HEAD));
	commits.set("classicCutover", V::str(CLASSIC_CUTOVER));
	let sod = Obj::new();
	for s in SNAPSHOTS.iter().filter(|s| s.repo == "sod") {
		sod.set(s.phase, V::str(s.commit));
	}
	commits.set("sod", V::Obj(sod));
	meta.set("commits", V::Obj(commits));
	meta.set("fetched", src.fetched.clone());
	let skipped = SKIPPED_SIMS.iter().map(|(k, v)| format!("{k} ({v})")).collect::<Vec<_>>().join(", ");
	let notes = [
		"Weights: wowsims default EP (ui/<sim>/sim.ts epWeights), mapped to Polestar keys, zero weights dropped, scaled so the spec main stat (normalizedTo) is 1.".to_string(),
		"Hit/crit/dodge/parry/block weights are per 1% (Classic sims count these stats in percent); defense per point.".to_string(),
		"season sod / origin sod-carryover: tuned with SoD runes and set bonuses. origin era: re-derived in the Era fork after 2024-11-21.".to_string(),
		"Sets still holding the WotLK per-rating defaults are listed in rejected, not converted.".to_string(),
		"sameAs: identical raw weights to an earlier band (not retuned for this level).".to_string(),
		format!("Not read (SoD-only roles): {skipped}."),
		"Gear sets: Classic Era level 60 raid-phase presets (phase 0 = pre-raid), item ids by Polestar slot; one-sim classes share sets across specs.".to_string(),
	];
	meta.set("notes", V::Arr(Arr::from_vec(notes.iter().map(|n| V::str(n)).collect())));
	Ok(Wowsims { meta, weights, rejected })
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn sim_ts_and_scale() {
		let p = parse_sim_ts("x epWeights: Stats.fromMap({\n [Stat.StatStrength]: 2.2, // c\n [Stat.StatMeleeHit]: .5,\n [Stat.StatMeleeCrit]: 30 }, { [PseudoStat.PseudoStatMainHandDps]: -1 }),\n epReferenceStat: Stat.StatStrength,").unwrap();
		assert_eq!(p.raw.0, vec![("StatStrength".into(), 2.2), ("StatMeleeHit".into(), 0.5), ("StatMeleeCrit".into(), 30.0), ("PseudoStatMainHandDps".into(), -1.0)]);
		assert_eq!(p.reference.as_deref(), Some("StatStrength"));
		assert_eq!(percent_scale(&p.raw, p.reference.as_deref()), Some(30.0 / 2.2));
		let (w, _) = map_weights(&p.raw, false);
		let (n, to) = normalize(&w, "str", None).unwrap();
		assert_eq!(to, "str");
		assert_eq!(n.get("hit"), Some(0.2273));
	}
}
