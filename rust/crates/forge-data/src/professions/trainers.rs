//! Profession trainers and rank sources (port of tools/lib/professions/trainers.js): a curated
//! table of NPC names from general game knowledge of Classic cities and outposts, each checked
//! against npcs.json (it must exist, be unique on its side and have spawns, else it is dropped
//! with a warning). Trainer lists are server data the client tables do not carry.

use forge_guide::js::{Arr, Obj, V};
use rustc_hash::FxHashMap;

/// Classic rank requirements: name, max skill, character level and skill a trainer asks for.
const RANKS: [(&str, f64, f64, f64); 4] = [("Apprentice", 75.0, 5.0, 0.0), ("Journeyman", 150.0, 10.0, 50.0), ("Expert", 225.0, 20.0, 125.0), ("Artisan", 300.0, 35.0, 200.0)];
/// Forever teaches Apprentice gathering skills from level 1.
const GATHERING_APPRENTICE_LEVEL: f64 = 1.0;

type Names = &'static [&'static str];

#[derive(Clone, Copy)]
struct Sides {
	a: Names,
	h: Names,
}

impl Sides {
	fn get(&self, side: usize) -> Names {
		if side == 0 {
			self.a
		} else {
			self.h
		}
	}
}

/// train: Apprentice and Journeyman; expert: city trainers that also teach Expert; artisan;
/// junior: Forever's starting-zone trainers (Apprentice only); book / quest: secondary skills'
/// Expert book (item, vendors) and Artisan quest; main: the trainer a guide sends the player to.
struct Curated {
	id: i64,
	name: &'static str,
	train: Sides,
	expert: Option<Sides>,
	artisan: Option<Sides>,
	junior: Option<Sides>,
	book: Option<(f64, Sides)>,
	quest: Option<Sides>,
	main: [&'static str; 2],
}

const fn s(a: Names, h: Names) -> Sides {
	Sides { a, h }
}

const CURATED: [Curated; 12] = [
	Curated {
		id: 171,
		name: "Alchemy",
		train: s(
			&[
				"Alchemist Mallory",
				"Tel'Athir",
				"Lilyssia Nightbreeze",
				"Tally Berryfizz",
				"Vosur Brakthel",
				"Ghak Healtouch",
				"Cyndra Kindwhisper",
				"Ainethil",
				"Milla Fairancora",
				"Sylvanna Forestmoon",
				"Kylanna",
			],
			&["Miao'zan", "Yelmak", "Whuut", "Bena Winterhoof", "Kray", "Carolai Anise", "Doctor Herbert Halsey", "Doctor Marsh", "Doctor Martin Felben", "Serge Hinott"],
		),
		expert: Some(s(&["Lilyssia Nightbreeze", "Vosur Brakthel", "Ainethil"], &["Yelmak", "Bena Winterhoof", "Doctor Herbert Halsey"])),
		artisan: Some(s(&["Kylanna Windwhisper"], &["Rogvar"])),
		junior: None,
		book: None,
		quest: None,
		main: ["Lilyssia Nightbreeze", "Yelmak"],
	},
	Curated {
		id: 164,
		name: "Blacksmithing",
		train: s(
			&["Smith Argus", "Therum Deepforge", "Ironus Coldsteel", "Bengus Deepforge", "Groum Stonebeard", "Tognus Flintfire"],
			&["Dwukk", "Saru Steelfury", "Thrag Stonehoof", "Karn Stonehoof", "James Van Brunt", "Basil Frye"],
		),
		expert: Some(s(&["Therum Deepforge", "Bengus Deepforge"], &["Saru Steelfury", "Karn Stonehoof", "James Van Brunt"])),
		artisan: Some(s(&["Brikk Keencraft"], &["Brikk Keencraft"])),
		junior: None,
		book: None,
		quest: None,
		main: ["Therum Deepforge", "Saru Steelfury"],
	},
	Curated {
		id: 333,
		name: "Enchanting",
		train: s(
			&["Lucan Cordell", "Betty Quin", "Kitta Firewind", "Gimble Thistlefuzz", "Tilli Thistlefuzz", "Thonys Pillarstone", "Taladan", "Lalina Summermoon", "Alanna Raveneye"],
			&["Godan", "Jhag", "Mot Dawnstrider", "Teg Dawnstrider", "Lavinia Crowe", "Malcomb Wynn", "Vance Undergloom", "Hgarth"],
		),
		expert: Some(s(&["Lucan Cordell", "Gimble Thistlefuzz", "Taladan"], &["Godan", "Teg Dawnstrider", "Lavinia Crowe"])),
		// Annora teaches inside Uldaman; the reference data has no spawn for her, so she is kept by name only.
		artisan: Some(s(&["Annora"], &["Annora"])),
		junior: None,
		book: None,
		quest: None,
		main: ["Lucan Cordell", "Godan"],
	},
	Curated {
		id: 202,
		name: "Engineering",
		train: s(
			&["Lilliam Sparkspindle", "Sprite Jumpsprocket", "Springspindle Fizzlegear", "Jemma Quikswitch", "Trixie Quikswitch", "Bronk Guzzlegear", "Jenna Lemkenilli"],
			&["Nogg", "Roxxik", "Mukdrak", "Graham Van Talen", "Franklin Lloyd"],
		),
		expert: Some(s(&["Lilliam Sparkspindle", "Springspindle Fizzlegear"], &["Nogg", "Graham Van Talen"])),
		artisan: Some(s(&["Buzzek Bracketswing"], &["Buzzek Bracketswing"])),
		junior: None,
		book: None,
		quest: None,
		main: ["Lilliam Sparkspindle", "Nogg"],
	},
	Curated {
		id: 165,
		name: "Leatherworking",
		train: s(
			&["Adele Fielder", "Simon Tanner", "Randal Worth", "Fimble Finespindle", "Telonis", "Darianna", "Faldron", "Trianna"],
			&["Karolek", "Chaw Stronghide", "Una", "Tarn", "Arthur Moore", "Brawn", "Krulmoo Fullmoon"],
		),
		expert: Some(s(&["Simon Tanner", "Fimble Finespindle", "Telonis"], &["Karolek", "Una", "Arthur Moore"])),
		artisan: Some(s(&["Drakk Stonehand"], &["Hahrana Ironhide"])),
		junior: None,
		book: None,
		quest: None,
		main: ["Simon Tanner", "Karolek"],
	},
	Curated {
		id: 197,
		name: "Tailoring",
		train: s(
			&["Eldrin", "Sellandus", "Georgio Bolero", "Lawrence Schneider", "Jormund Stonebrow", "Uthrar Threx", "Me'lynn", "Sinda", "Nadyia Maneweaver"],
			&["Magar", "Snang", "Josephine Lister", "Victor Ward", "Rhiannon Davis", "Bowen Brisboise", "Vhan", "Mahani"],
		),
		expert: Some(s(&["Georgio Bolero", "Jormund Stonebrow", "Me'lynn"], &["Magar", "Josephine Lister"])),
		artisan: Some(s(&["Timothy Worthington"], &["Daryl Stack"])),
		junior: None,
		book: None,
		quest: None,
		main: ["Georgio Bolero", "Magar"],
	},
	// Gathering skills: every `train` trainer teaches all four ranks.
	Curated {
		id: 182,
		name: "Herbalism",
		train: s(
			&["Tannysa", "Shylamiir", "Reyna Stonebranch", "Firodren Mooncaller", "Malorne Bladeleaf", "Alma Jainrose", "Kali Healtouch"],
			&["Jandi", "Komin Winterhoof", "Martha Alliestar", "Faruza", "Aranae Venomblood"],
		),
		expert: None,
		artisan: None,
		junior: Some(s(&["Nancy Songflower", "Emrys Flintbeard", "Eleyna Duskbreeze"], &["Zor'la", "Garan Sunstrider", "Florence Nightshade"])),
		book: None,
		quest: None,
		main: ["Tannysa", "Jandi"],
	},
	Curated {
		id: 186,
		name: "Mining",
		train: s(&["Gelman Stonehand", "Geofram Bouldertoe", "Yarr Hammerstone", "Brock Stoneseeker", "Kurdram Stonehammer"], &["Makaru", "Krunn", "Brek Stonehoof", "Brom Killian", "Johan Focht"]),
		expert: None,
		artisan: None,
		junior: Some(s(&["Kelsey Fargo", "Sally Swiftwrench", "Fanorran Stilloak"], &["Norzsh", "Vartha Rockmane", "Walter Mason"])),
		book: None,
		quest: None,
		main: ["Gelman Stonehand", "Makaru"],
	},
	Curated {
		id: 393,
		name: "Skinning",
		train: s(&["Maris Granger", "Helene Peltskinner", "Balthus Stoneflayer", "Radnaal Maneweaver"], &["Thuwd", "Mooranta", "Rand Rhobart", "Killian Sanatha"]),
		expert: None,
		artisan: None,
		junior: Some(s(&["Riley Peltskinner", "Brighid Stormflayer", "Terunne Bearshaper"], &["Kagil", "Nawka Wildsong", "Margaret Weaver"])),
		book: None,
		quest: None,
		main: ["Maris Granger", "Thuwd"],
	},
	// Secondary skills: trainers teach Apprentice and Journeyman.
	Curated {
		id: 185,
		name: "Cooking",
		train: s(&["Stephen Ryback", "Tomas", "Daryl Riknussun", "Gremlock Pilsnor", "Alegorn", "Zarrin"], &["Zamja", "Aska Mistrunner", "Eunice Burch", "Duhng"]),
		expert: None,
		artisan: None,
		junior: None,
		book: Some((16072.0, s(&["Shandrina"], &["Wulan"]))),
		quest: Some(s(&["Dirge Quikcleave"], &["Dirge Quikcleave"])),
		main: ["Stephen Ryback", "Zamja"],
	},
	Curated {
		id: 129,
		name: "First Aid",
		train: s(&["Shaina Fuller", "Michelle Belle", "Nissa Firestone", "Thamner Pol", "Byancie"], &["Arnok", "Rawrk", "Pand Stonebinder", "Mary Edras", "Nurse Neela"]),
		expert: None,
		artisan: None,
		junior: None,
		book: Some((16084.0, s(&["Deneb Walker"], &["Balai Lok'Wein"]))),
		quest: Some(s(&["Doctor Gustaf VanHowzen"], &["Doctor Gregory Victor"])),
		main: ["Shaina Fuller", "Arnok"],
	},
	Curated {
		id: 356,
		name: "Fishing",
		train: s(&["Arnold Leland", "Lee Brown", "Grimnur Stonebrand", "Paxton Ganter", "Astaia"], &["Lumak", "Kah Mistrunner", "Armand Cromwell", "Clyde Kellen"]),
		expert: None,
		artisan: None,
		junior: None,
		book: Some((16083.0, s(&["Old Man Heming"], &["Old Man Heming"]))),
		quest: Some(s(&["Nat Pagle"], &["Nat Pagle"])),
		main: ["Arnold Leland", "Lumak"],
	},
];

const SIDES: [&str; 2] = ["Alliance", "Horde"];
const SIDE_CODE: [&str; 2] = ["A", "H"];

/// makeFinder: npcs.json name (lower case) -> NPCs, in npcs.json order.
pub struct Finder {
	by_name: FxHashMap<String, Vec<V>>,
}

impl Finder {
	pub fn new(npcs: &Obj) -> Finder {
		let mut by_name: FxHashMap<String, Vec<V>> = FxHashMap::default();
		for n in npcs.values() {
			if !n.truthy() {
				continue;
			}
			let name = n.get("name");
			if !name.truthy() {
				continue;
			}
			by_name.entry(name.to_js_string().to_lowercase()).or_default().push(n);
		}
		Finder { by_name }
	}

	/// The side's own NPC of that name or a neutral one.
	fn find(&self, name: &str, side: usize) -> Result<V, String> {
		let list: Vec<&V> = self
			.by_name
			.get(&name.to_lowercase())
			.map(|l| {
				l.iter()
					.filter(|n| {
						let f = n.get("faction");
						let f = if f.is_nullish() { String::new() } else { f.to_js_string() };
						f.is_empty() || f == "AH" || f.contains(SIDE_CODE[side])
					})
					.collect()
			})
			.unwrap_or_default();
		match list.len() {
			0 => Err("not in npcs.json for this side".into()),
			1 => Ok(list[0].clone()),
			_ => Err(format!(
				"ambiguous ({})",
				list.iter()
					.map(|n| {
						let id = n.get("id");
						if id.is_nullish() {
							String::new()
						} else {
							id.to_js_string()
						}
					})
					.collect::<Vec<_>>()
					.join(", ")
			)),
		}
	}
}

fn has_spawns(npc: &V) -> bool {
	let sp = npc.get("spawns");
	if !sp.truthy() {
		return false;
	}
	sp.values().iter().any(|s| s.truthy() && s.get("pts").as_arr().is_some_and(|a| !a.is_empty()))
}

/// What resolveTrainers returns: rank objects (ready for `spell`), all trainers per side, the
/// main trainer per side found, and warnings for names that failed.
pub struct Resolved {
	pub ranks: Vec<Obj>,
	pub trainers: V,
	pub main: Vec<(&'static str, V)>,
	pub warnings: Vec<String>,
}

fn nums(v: &[f64]) -> V {
	V::Arr(Arr::from_vec(v.iter().map(|&x| V::Num(x)).collect()))
}

fn sides_obj(per: &[Vec<f64>; 2]) -> V {
	let o = Obj::new();
	for (s, ids) in SIDES.iter().zip(per) {
		o.set(s, nums(ids));
	}
	V::Obj(o)
}

/// `[...new Set(lists.flat())].sort((a, b) => a - b)`.
fn merge(lists: &[&[f64]]) -> Vec<f64> {
	let mut out: Vec<f64> = Vec::new();
	for &x in lists.iter().flat_map(|l| l.iter()) {
		if !out.contains(&x) {
			out.push(x);
		}
	}
	out.sort_by(|a, b| a.partial_cmp(b).unwrap_or(std::cmp::Ordering::Equal));
	out
}

fn plain_rank(r: &(&str, f64, f64, f64)) -> Obj {
	let o = Obj::new();
	o.set("name", r.0);
	o.set("max", r.1);
	o.set("minLevel", r.2);
	o.set("minSkill", r.3);
	o
}

/// resolveTrainers(skillLine, npcs, { kind }).
pub fn resolve(skill_line: i64, finder: &Finder, kind: &str) -> Resolved {
	let mut warnings = Vec::new();
	let Some(c) = CURATED.iter().find(|c| c.id == skill_line) else {
		let trainers = sides_obj(&[Vec::new(), Vec::new()]);
		return Resolved { ranks: RANKS.iter().map(plain_rank).collect(), trainers, main: Vec::new(), warnings };
	};
	let ids = |names: Names, side: usize, allow_no_spawn: bool, warnings: &mut Vec<String>| -> Vec<f64> {
		let mut out: Vec<f64> = Vec::new();
		for &name in names {
			let npc = match finder.find(name, side) {
				Ok(n) => n,
				Err(e) => {
					warnings.push(format!("{} {} trainer \"{name}\": {e}", c.name, SIDES[side]));
					continue;
				}
			};
			let id = npc.get("id");
			if !has_spawns(&npc) && !allow_no_spawn {
				warnings.push(format!("{} {} trainer \"{name}\" ({}) has no spawns", c.name, SIDES[side], id.to_js_string()));
				continue;
			}
			let id = id.num();
			if !out.contains(&id) {
				out.push(id);
			}
		}
		out
	};
	let per = |g: Option<Sides>, allow: bool, warnings: &mut Vec<String>| -> Option<[Vec<f64>; 2]> { g.map(|g| [ids(g.a, 0, allow, warnings), ids(g.h, 1, allow, warnings)]) };
	let train = per(Some(c.train), false, &mut warnings).unwrap();
	let expert = per(c.expert, false, &mut warnings);
	let artisan = per(c.artisan, true, &mut warnings);
	let junior = per(c.junior, false, &mut warnings);
	let empty: Vec<f64> = Vec::new();
	let pick = |g: &Option<[Vec<f64>; 2]>, s: usize| -> Vec<f64> { g.as_ref().map(|g| g[s].clone()).unwrap_or_default() };
	let trainers = sides_obj(&std::array::from_fn(|s| merge(&[&train[s], expert.as_ref().map_or(&empty, |e| &e[s]), artisan.as_ref().map_or(&empty, |e| &e[s])])));
	let mut ranks = Vec::with_capacity(RANKS.len());
	for r in &RANKS {
		let rank = plain_rank(r);
		if r.0 == "Apprentice" && kind == "gathering" {
			rank.set("minLevel", GATHERING_APPRENTICE_LEVEL);
		}
		if r.0 == "Apprentice" && junior.is_some() {
			rank.set("trainers", sides_obj(&std::array::from_fn(|s| merge(&[&train[s], &pick(&expert, s), &pick(&junior, s)]))));
		} else if r.0 == "Apprentice" || r.0 == "Journeyman" || kind == "gathering" {
			rank.set("trainers", sides_obj(&std::array::from_fn(|s| merge(&[&train[s], &pick(&expert, s)]))));
		} else if r.0 == "Expert" {
			if let Some(e) = &expert {
				rank.set("trainers", sides_obj(&std::array::from_fn(|s| merge(&[&e[s]]))));
			}
			if let Some((item, vendors)) = c.book {
				let v = [ids(vendors.get(0), 0, false, &mut warnings), ids(vendors.get(1), 1, false, &mut warnings)];
				let book = Obj::new();
				book.set("item", item);
				book.set("vendors", sides_obj(&v));
				rank.set("book", book);
			}
		} else if r.0 == "Artisan" {
			if let Some(a) = &artisan {
				rank.set("trainers", sides_obj(&std::array::from_fn(|s| merge(&[&a[s]]))));
			}
			if let Some(q) = c.quest {
				let v = [ids(q.get(0), 0, false, &mut warnings), ids(q.get(1), 1, false, &mut warnings)];
				let quest = Obj::new();
				quest.set("npcs", sides_obj(&v));
				rank.set("quest", quest);
			}
			// Secondary skills: the Artisan quests ask for 225, the Expert cap.
			if kind == "secondary" {
				rank.set("minSkill", 225.0);
			}
		}
		ranks.push(rank);
	}
	let mut main = Vec::new();
	for (s, side) in SIDES.iter().enumerate() {
		if let Ok(npc) = finder.find(c.main[s], s) {
			main.push((*side, npc.get("id")));
		}
	}
	Resolved { ranks, trainers, main, warnings }
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::{parse_json, stringify};

	#[test]
	fn resolves_and_warns() {
		let npcs = parse_json(r#"{"1":{"id":1,"name":"Arnold Leland","faction":"A","spawns":{"1453":{"pts":[[1,2]]}}},"2":{"id":2,"name":"Lumak","faction":"H","spawns":{}},"3":{"id":3,"name":"Nat Pagle","faction":"AH","spawns":{"1":{"pts":[[1,1]]}}}}"#).unwrap();
		let f = Finder::new(npcs.as_obj().unwrap());
		let r = resolve(356, &f, "secondary");
		assert_eq!(stringify(&r.trainers, None), r#"{"Alliance":[1],"Horde":[]}"#);
		assert_eq!(stringify(&V::Obj(r.ranks[3].clone()), None), r#"{"name":"Artisan","max":300,"minLevel":35,"minSkill":225,"quest":{"npcs":{"Alliance":[3],"Horde":[3]}}}"#);
		assert!(r.warnings.iter().any(|w| w == "Fishing Horde trainer \"Lumak\" (2) has no spawns"));
		assert_eq!(r.main.len(), 2);
	}
}
