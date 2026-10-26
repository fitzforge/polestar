//! Port of tools/lib/dsl/conditions.js.
//! Character conditions in guides: parsing class, race and faction lists, and
//! matching them against the masks quests.json carries. The races and classes
//! themselves are in races.rs.

use crate::js::V;
use crate::lexer::js_trim;
use crate::obj;
use crate::races::{class, class_by_file, class_label, has_bit, race, race_by_file_ref, race_label, CLASS_FILES, RACE_FILES, SIDES};
use rustc_hash::FxHashSet;

/// The factions a race file can be played on (both for an unknown race).
pub fn race_sides(file: &str) -> Vec<String> {
	match race_by_file_ref(file) {
		Some(r) => r.sides.iter().map(|(s, _)| s.to_string()).collect(),
		None => SIDES.iter().map(|s| s.to_string()).collect(),
	}
}

/// FACTIONS: lowercase name -> faction.
pub const FACTIONS: [(&str, &str); 2] = [("alliance", "Alliance"), ("horde", "Horde")];

/// `FACTIONS[name]`.
pub fn faction(name: &str) -> Option<&'static str> {
	FACTIONS.iter().find(|(k, _)| *k == name).map(|(_, v)| *v)
}

fn name_ok(raw: &str) -> bool {
	let b = raw.strip_prefix('!').unwrap_or(raw).as_bytes();
	!b.is_empty() && b[0].is_ascii_alphabetic() && b[1..].iter().all(|c| c.is_ascii_alphanumeric() || *c == b'_')
}

pub struct Conditions {
	/// `{ classes, races, factions }`, each an array or null.
	pub value: V,
	pub errors: Vec<String>,
	pub warnings: Vec<String>,
}

fn arr_of<S: AsRef<str>>(v: &[S]) -> V {
	V::from(v.iter().map(|s| V::str(s.as_ref())).collect::<Vec<V>>())
}

/// Parse a comma list into { classes, races, factions } (arrays or null), with
/// class negations expanded to positive lists. `allow` limits which groups the
/// list may use ("class" | "race" | "any").
pub fn parse_conditions(list: &str, allow: &str) -> Conditions {
	let mut errors = Vec::new();
	let mut warnings = Vec::new();
	let mut pos: Vec<&str> = Vec::new();
	let mut neg: Vec<&str> = Vec::new();
	let mut races: Vec<String> = Vec::new();
	let mut factions: Vec<&str> = Vec::new();
	for raw in list.split(',').map(js_trim) {
		if raw.is_empty() {
			errors.push("empty condition in list".to_string());
			continue;
		}
		if !name_ok(raw) {
			errors.push(format!("malformed condition \"{raw}\""));
			continue;
		}
		let negated = raw.starts_with('!');
		let name = (if negated { &raw[1..] } else { raw }).to_lowercase();
		if let Some(c) = class(&name) {
			if allow == "race" {
				errors.push(format!("\"{raw}\" is a class; use `class`"));
				continue;
			}
			if negated {
				neg.push(c.file);
			} else if !pos.contains(&c.file) {
				pos.push(c.file);
			}
			continue;
		}
		if negated {
			errors.push(format!("only classes can be negated (\"{raw}\")"));
			continue;
		}
		if let Some(f) = faction(&name) {
			if allow != "any" {
				errors.push(format!("\"{raw}\" is a faction; use `faction`"));
				continue;
			}
			if !factions.contains(&f) {
				factions.push(f);
			}
			continue;
		}
		if allow == "class" {
			errors.push(format!("unknown class \"{raw}\""));
			continue;
		}
		if let Some(r) = race(&name) {
			if !races.iter().any(|x| x == r.file) {
				races.push(r.file.to_string());
			}
			continue;
		}
		warnings.push(format!("unknown race \"{raw}\" passed through as a race file name (new Forever race?)"));
		if !races.iter().any(|x| x == raw) {
			races.push(raw.to_string());
		}
	}
	let mut classes = V::Null;
	if !pos.is_empty() || !neg.is_empty() {
		// Classes OR together: a negation contributes every class but itself.
		let mut set: Vec<&str> = pos.clone();
		for n in &neg {
			for f in CLASS_FILES {
				if f != *n && !set.contains(&f) {
					set.push(f);
				}
			}
		}
		classes = arr_of(&CLASS_FILES.iter().filter(|f| set.contains(f)).copied().collect::<Vec<_>>());
	}
	let value = obj! {
		"classes" => classes,
		"races" => if races.is_empty() { V::Null } else { arr_of(&races) },
		"factions" => if factions.is_empty() { V::Null } else { arr_of(&factions) },
	};
	Conditions { value: V::Obj(value), errors, warnings }
}

/// Intersection of optional lists (null = unrestricted). Case-sensitive on
/// canonical names produced by parse_conditions.
pub fn intersect(a: &V, b: &V) -> V {
	if !a.truthy() {
		return if b.truthy() { V::from(b.items()) } else { V::Null };
	}
	if !b.truthy() {
		return V::from(a.items());
	}
	let bi = b.items();
	V::from(a.items().into_iter().filter(|x| bi.iter().any(|y| y.strict_eq(x))).collect::<Vec<V>>())
}

fn strs(v: &V) -> Vec<String> {
	v.items().iter().map(|x| x.to_js_string()).collect()
}

/// Every character the given constraint layers can describe, as
/// `{ races, classes, factions, unknownRace }`. Layers are objects with
/// optional factions, races, classes (falsy layers are skipped).
pub fn applicable(layers: &[V]) -> V {
	let mut factions = V::Null;
	let mut races = V::Null;
	let mut classes = V::Null;
	for l in layers {
		if !l.truthy() {
			continue;
		}
		if l.get("factions").truthy() {
			factions = intersect(&factions, &l.get("factions"));
		}
		if l.get("races").truthy() {
			races = intersect(&races, &l.get("races"));
		}
		if l.get("classes").truthy() {
			classes = intersect(&classes, &l.get("classes"));
		}
	}
	let mut race_list: Vec<String> = if races.truthy() { strs(&races) } else { RACE_FILES.iter().map(|s| s.to_string()).collect() };
	let faction_list: Vec<String> = if factions.truthy() { strs(&factions) } else { SIDES.iter().map(|s| s.to_string()).collect() };
	if factions.truthy() {
		race_list.retain(|r| race_sides(r).iter().any(|s| faction_list.contains(s)));
	}
	let class_list: Vec<String> = if classes.truthy() { strs(&classes) } else { CLASS_FILES.iter().map(|s| s.to_string()).collect() };
	let unknown = race_list.iter().any(|r| race_by_file_ref(r).is_none());
	V::Obj(obj! {
		"races" => arr_of(&race_list),
		"classes" => arr_of(&class_list),
		"factions" => arr_of(&faction_list),
		"unknownRace" => unknown,
	})
}

/// Does a quest admit at least one applicable character (`set` from
/// applicable)? A race counts on every side the set allows it on. A mask only
/// QuestieDB's Forever store can carry the Skyborne bits; one from pfQuest
/// alone is an Era mask and never excludes Skyborne.
/// -> None when fine, else "race" or "class".
pub fn mask_excludes(set: &V, quest: &V) -> Option<&'static str> {
	let race_mask = quest.get("races");
	let class_mask = quest.get("classes");
	let set_factions = strs(&set.get("factions"));
	if !race_mask.is_nullish() && !race_mask.strict_eq(&V::Num(0.0)) && !set.get("unknownRace").truthy() {
		let src = quest.get("source");
		let forever = src.is_arr() && src.items().iter().any(|s| s.to_js_string().starts_with("questie"));
		let mask = race_mask.num();
		let admits = |r: &str| race_by_file_ref(r).unwrap().sides.iter().any(|(side, bit)| set_factions.iter().any(|f| f == side) && (has_bit(mask, *bit) || (*bit >= 4294967296.0 && !forever)));
		let races = strs(&set.get("races"));
		if !races.is_empty() && !races.iter().any(|r| admits(r)) {
			return Some("race");
		}
	}
	if !class_mask.is_nullish() && !class_mask.strict_eq(&V::Num(0.0)) {
		let classes = strs(&set.get("classes"));
		let mask = class_mask.num();
		if !classes.is_empty() && !classes.iter().any(|c| has_bit(mask, class_by_file(c).map(|c| c.bit).unwrap_or(f64::NAN))) {
			return Some("class");
		}
	}
	None
}

/// The characters every layer allows (applicable), as "race|class" keys (in
/// insertion order, each once), each race only with the classes
/// `classes_of(race, side)` lists (an array of class files; an empty list, or
/// no `classes_of`, allows every class).
pub fn character_keys(layers: &[V], classes_of: Option<&dyn Fn(&str, &str) -> V>) -> Vec<String> {
	let set = applicable(layers);
	let factions = strs(&set.get("factions"));
	let classes = strs(&set.get("classes"));
	let mut out = Vec::new();
	let mut seen = FxHashSet::default();
	for race in strs(&set.get("races")) {
		for side in race_sides(&race) {
			if !factions.contains(&side) {
				continue;
			}
			let can = classes_of.map(|f| f(&race, &side));
			let can_list = match &can {
				Some(c) if c.truthy() && !c.items().is_empty() => Some(strs(c)),
				_ => None,
			};
			for cls in &classes {
				if can_list.as_ref().is_none_or(|l| l.contains(cls)) {
					let k = format!("{race}|{cls}");
					if seen.insert(k.clone()) {
						out.push(k);
					}
				}
			}
		}
	}
	out
}

/// Who a layer ({ faction, races, classes }) is for: "Dwarf/Gnome", "Human
/// Paladin", "Alliance Paladin", "Alliance" or "both factions".
pub fn who_label(layer: &V) -> String {
	let races = layer.get("races");
	let classes = layer.get("classes");
	let faction = layer.get("faction");
	let r = if races.truthy() && !races.items().is_empty() {
		Some(races.items().iter().map(|x| race_label(&x.to_js_string())).collect::<Vec<_>>().join("/"))
	} else if faction.truthy() {
		Some(faction.to_js_string())
	} else {
		None
	};
	let c = if classes.truthy() && !classes.items().is_empty() { Some(classes.items().iter().map(|x| class_label(&x.to_js_string())).collect::<Vec<_>>().join("/")) } else { None };
	let s = [r, c].into_iter().flatten().filter(|s| !s.is_empty()).collect::<Vec<_>>().join(" ");
	if s.is_empty() {
		"both factions".to_string()
	} else {
		s
	}
}
