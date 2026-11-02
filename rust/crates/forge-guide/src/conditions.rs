//! Port of tools/lib/dsl/conditions.js.
//! Character conditions in guides: parsing class, race and faction lists, and
//! matching them against the masks quests.json carries. The races and classes
//! themselves are in races.rs.

use crate::js::V;
use crate::lexer::js_trim;
use crate::obj;
use crate::races::{class, class_by_file, class_label, has_bit, race, race_by_file_ref, race_label, CLASSES, CLASS_FILES, RACES, RACE_FILES, SIDES};
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
	let classes = match class_set(&pos, &neg) {
		Some(set) => arr_of(&set),
		None => V::Null,
	};
	let value = obj! {
		"classes" => classes,
		"races" => if races.is_empty() { V::Null } else { arr_of(&races) },
		"factions" => if factions.is_empty() { V::Null } else { arr_of(&factions) },
	};
	Conditions { value: V::Obj(value), errors, warnings }
}

/// The classes a list's class names and negations stand for, in CLASS_FILES order (None: none
/// named). Classes OR together: a negation contributes every class but itself, so `!Mage,!Druid`
/// is every class.
fn class_set(pos: &[&str], neg: &[&str]) -> Option<Vec<&'static str>> {
	if pos.is_empty() && neg.is_empty() {
		return None;
	}
	Some(CLASS_FILES.iter().copied().filter(|f| pos.contains(f) || neg.iter().any(|n| n != f)).collect())
}

/// A race name (`Undead`, `Scourge`, `NightElf`, any case) as its race file.
fn race_file_of(name: &str) -> Option<&'static str> {
	RACES.iter().find(|r| r.name.eq_ignore_ascii_case(name) || r.file.eq_ignore_ascii_case(name)).map(|r| r.file)
}

/// A class name (`Shaman`, `SHAMAN`) as its class file.
pub fn class_file_of(name: &str) -> Option<&'static str> {
	CLASSES.iter().find(|c| c.name.eq_ignore_ascii_case(name) || c.file.eq_ignore_ascii_case(name)).map(|c| c.file)
}

/// Whether two race names are one race (Undead and Scourge are).
pub fn same_race(a: &str, b: &str) -> bool {
	match (race_file_of(a), race_file_of(b)) {
		(Some(x), Some(y)) => x == y,
		_ => a.eq_ignore_ascii_case(b),
	}
}

/// Who an `only` list lets in, read as the compiler reads it (parse_conditions): races, classes and
/// factions are each a set one of which the character must match (None: anyone), and all three must
/// hold; `!Warlock` stands for every class but the Warlock. The writer reads the lists it writes and
/// the judge the compiled ones through this one reading.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Audience {
	/// Race names as written (compared as race files: Undead is Scourge).
	pub races: Option<Vec<String>>,
	/// Class files, in CLASS_FILES order.
	pub classes: Option<Vec<&'static str>>,
	pub factions: Option<Vec<String>>,
}

impl Audience {
	/// An `only` list as written (`Orc,Troll,!Shaman`). Names the compiler refuses (a negated race)
	/// are left out.
	pub fn parse(list: &str) -> Audience {
		let (mut pos, mut neg, mut races, mut factions) = (Vec::new(), Vec::new(), Vec::<String>::new(), Vec::<String>::new());
		for raw in list.split(',').map(js_trim).filter(|r| name_ok(r)) {
			let (negated, name) = match raw.strip_prefix('!') {
				Some(n) => (true, n),
				None => (false, raw),
			};
			if let Some(c) = class_file_of(name) {
				if negated {
					neg.push(c)
				} else {
					pos.push(c)
				}
			} else if negated {
			} else if let Some(f) = faction(&name.to_lowercase()) {
				if !factions.iter().any(|x| x == f) {
					factions.push(f.to_string());
				}
			} else if !races.iter().any(|x| same_race(x, name)) {
				races.push(name.to_string());
			}
		}
		Audience { races: (!races.is_empty()).then_some(races), classes: class_set(&pos, &neg), factions: (!factions.is_empty()).then_some(factions) }
	}

	/// A compiled `only` (`{ classes, races, factions }`, null or empty: anyone).
	pub fn of_compiled(only: &V) -> Audience {
		if !only.truthy() {
			return Audience::default();
		}
		let group = |k: &str| -> Option<Vec<String>> {
			let v: Vec<String> = only.get(k).items().iter().map(V::to_js_string).collect();
			(!v.is_empty()).then_some(v)
		};
		let classes = group("classes").and_then(|cs| {
			let pos: Vec<&str> = cs.iter().filter_map(|c| class_file_of(c)).collect();
			let neg: Vec<&str> = cs.iter().filter_map(|c| c.strip_prefix('!').and_then(class_file_of)).collect();
			class_set(&pos, &neg)
		});
		let keep = |v: Option<Vec<String>>| v.map(|v| v.into_iter().filter(|x| !x.starts_with('!')).collect::<Vec<_>>()).filter(|v| !v.is_empty());
		Audience { races: keep(group("races")), classes, factions: keep(group("factions")) }
	}

	/// Whether characters of this race can be in it.
	pub fn race_in(&self, race: &str) -> bool {
		self.races.as_ref().is_none_or(|rs| rs.iter().any(|r| same_race(r, race)))
	}

	/// Whether characters of this class can be in it.
	pub fn class_in(&self, class: &str) -> bool {
		self.classes.as_ref().is_none_or(|cs| class_file_of(class).is_some_and(|c| cs.contains(&c)))
	}

	/// Whether it lets every class in.
	pub fn every_class(&self) -> bool {
		self.classes.as_ref().is_none_or(|cs| cs.len() == CLASS_FILES.len())
	}

	/// Whether it lets in a character of this race, class and faction.
	pub fn admits(&self, race: &str, class: &str, faction: &str) -> bool {
		self.race_in(race) && self.class_in(class) && self.factions.as_ref().is_none_or(|fs| fs.iter().any(|f| f.eq_ignore_ascii_case(faction)))
	}

	/// Those both let in (a step's `only` and its line's).
	pub fn and(&self, o: &Audience) -> Audience {
		fn both<T: Clone>(a: &Option<Vec<T>>, b: &Option<Vec<T>>, eq: impl Fn(&T, &T) -> bool) -> Option<Vec<T>> {
			match (a, b) {
				(None, x) | (x, None) => x.clone(),
				(Some(a), Some(b)) => Some(a.iter().filter(|x| b.iter().any(|y| eq(x, y))).cloned().collect()),
			}
		}
		Audience {
			races: both(&self.races, &o.races, |a: &String, b: &String| same_race(a, b)),
			classes: both(&self.classes, &o.classes, |a: &&str, b: &&str| a == b),
			factions: both(&self.factions, &o.factions, |a: &String, b: &String| a.eq_ignore_ascii_case(b)),
		}
	}

	/// The list as guides write it (None: anyone): races as written, factions, then classes, every
	/// class but one as its negation (`Orc,!Shaman`).
	pub fn render(&self) -> Option<String> {
		let mut out: Vec<String> = self.races.clone().unwrap_or_default();
		out.extend(self.factions.clone().unwrap_or_default());
		if let Some(cs) = self.classes.as_ref().filter(|_| !self.every_class()) {
			let left: Vec<&str> = CLASS_FILES.iter().copied().filter(|c| !cs.contains(c)).collect();
			match left.as_slice() {
				[one] => out.push(format!("!{}", class_label(one))),
				_ => out.extend(cs.iter().map(|c| class_label(c))),
			}
		}
		(!out.is_empty()).then(|| out.join(","))
	}
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

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn an_audience_reads_races_classes_and_a_class_negation_together() {
		let a = Audience::parse("Orc,!Shaman");
		assert!(a.admits("Orc", "WARRIOR", "Horde") && a.admits("orc", "Hunter", "Horde"));
		assert!(!a.admits("Orc", "Shaman", "Horde") && !a.admits("Troll", "Warrior", "Horde"));
		let u = Audience::parse("Undead,Mage");
		assert!(u.admits("Scourge", "MAGE", "Horde") && !u.admits("Undead", "Priest", "Horde"));
		// (Negations OR together: two are every class.)
		assert!(Audience::parse("!Mage,!Druid").every_class());
		assert_eq!(a.render().as_deref(), Some("Orc,!Shaman"));
		assert_eq!(Audience::parse("Orc").and(&Audience::parse("Hunter,Rogue")).render().as_deref(), Some("Orc,Hunter,Rogue"));
		// The compiled list reads the same.
		let c = parse_conditions("Orc,!Shaman", "any").value;
		assert_eq!(Audience::of_compiled(&c).classes, a.classes);
	}
}
