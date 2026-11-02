//! Weapon skills while the route is in a capital (#655): where a guide already stops in Stormwind,
//! Ironforge, Darnassus, Orgrimmar, Thunder Bluff or Undercity at level 10 or later, a short step
//! suggests the weapon skill the class levels with, from that city's weapon master. Never a trip of
//! its own: only a visit the class already makes (a training stop or any other), after the last step
//! it plays there, before it leaves (before that step, when it ends on the way out: the tram).
//!
//! The step holds on the weapon master's `train` (a skill learned there), and applies only while
//! the character can pay for it and has not learned the skill (`when money>=…`,
//! `when !skill "…" 1`): the races that start with a skill (Orc Warriors' Two-Handed Axes) and a
//! character who learned it at an earlier visit never see it. Each class is offered each skill once
//! in a start's own guides and once in the faction's shared guides (written for every start alike).

use crate::apply::{ALL_RACES, CLASSES};
use crate::guide::{is_goal, races_of};
use crate::jsre::{head, is_step, split_comment, starts_nonspace, trim};
use crate::re;
use rustc_hash::{FxHashMap, FxHashSet};

/// A weapon skill a master teaches: its name (the skill line's, as `when skill` reads it), its
/// price in copper and the level it can be learned from.
#[derive(Debug, PartialEq)]
pub struct Skill {
	pub name: &'static str,
	pub copper: u32,
	pub level: f64,
}

// Forever's trainer data (data/local/forever-tdb/world.sqlite, trainer_spell of the masters'
// trainers): every weapon skill 10 silver from level 1, Polearms 1 gold from level 20.
pub const TWO_HANDED_AXES: Skill = Skill { name: "Two-Handed Axes", copper: 1000, level: 1.0 };
pub const TWO_HANDED_MACES: Skill = Skill { name: "Two-Handed Maces", copper: 1000, level: 1.0 };
pub const TWO_HANDED_SWORDS: Skill = Skill { name: "Two-Handed Swords", copper: 1000, level: 1.0 };
pub const POLEARMS: Skill = Skill { name: "Polearms", copper: 10000, level: 20.0 };
pub const STAVES: Skill = Skill { name: "Staves", copper: 1000, level: 1.0 };
pub const SWORDS: Skill = Skill { name: "Swords", copper: 1000, level: 1.0 };

/// A weapon master: npc id, name, the capital's map (its zone in the world) and side, the city's
/// district it stands in (the client's area table names none of them under the city; Ansekhwa's tent
/// on Thunder Bluff's central mesa has no name), and the skills of [`PLANS`] it teaches (Forever's
/// trainer_spell; Sayoc teaches no Staves there, nor Ansekhwa Guns).
pub struct Master {
	pub npc: u32,
	pub name: &'static str,
	pub map: u32,
	pub side: &'static str,
	pub area: Option<&'static str>,
	pub teaches: &'static [&'static Skill],
}

pub const MASTERS: [Master; 7] = [
	Master { npc: 11867, name: "Woo Ping", map: 1453, side: "Alliance", area: Some("Trade District"), teaches: &[&TWO_HANDED_SWORDS, &POLEARMS, &STAVES, &SWORDS] },
	Master { npc: 11865, name: "Buliwyf Stonehand", map: 1455, side: "Alliance", area: Some("Military Ward"), teaches: &[&TWO_HANDED_AXES, &TWO_HANDED_MACES] },
	Master { npc: 11866, name: "Ilyenia Moonfire", map: 1457, side: "Alliance", area: Some("Warrior's Terrace"), teaches: &[&STAVES] },
	Master { npc: 11868, name: "Sayoc", map: 1454, side: "Horde", area: Some("Valley of Honor"), teaches: &[&TWO_HANDED_AXES] },
	Master { npc: 2704, name: "Hanashi", map: 1454, side: "Horde", area: Some("Valley of Honor"), teaches: &[&TWO_HANDED_AXES, &STAVES] },
	Master { npc: 11869, name: "Ansekhwa", map: 1456, side: "Horde", area: None, teaches: &[&TWO_HANDED_MACES, &STAVES] },
	Master { npc: 11870, name: "Archibald", map: 1458, side: "Horde", area: Some("War Quarter"), teaches: &[&TWO_HANDED_SWORDS, &POLEARMS, &SWORDS] },
];

/// Per class, the weapon skills it levels with, in the order offered, and why (the tip's last
/// clause). Warriors and Paladins level with two-handers (Paladins start with Two-Handed Maces);
/// Hunters with a two-handed stat weapon; Rogues with a sword in the main hand beside their
/// daggers; Priests and Warlocks with a staff. Mages and Druids start with Staves, and a Shaman's
/// two-handers are a talent, so their weapon masters have nothing to add.
pub const PLANS: [(&str, &[&Skill], &str); 6] = [
	("Warrior", &[&TWO_HANDED_AXES, &TWO_HANDED_MACES, &TWO_HANDED_SWORDS, &POLEARMS], "two-handers level a Warrior fastest"),
	("Paladin", &[&TWO_HANDED_SWORDS, &TWO_HANDED_AXES], "two-handers level a Paladin fastest"),
	("Hunter", &[&STAVES, &POLEARMS], "a Hunter's melee weapon is mostly its stats, and two-handers carry the most"),
	("Rogue", &[&SWORDS], "a sword in the main hand levels a Rogue steadily"),
	("Priest", &[&STAVES], "a staff carries more spell stats than a one-hander while you level"),
	("Warlock", &[&STAVES], "a staff carries more spell stats than a one-hander while you level"),
];

/// No weapon step before this level: early silver goes to the class's own spells.
pub const FROM_LEVEL: f64 = 10.0;

/// A step this near the weapon master (its NPC's yards) is beside him.
const NEAR_MASTER_YD: f64 = 60.0;

/// What the pass reads beyond the guides.
pub struct Env<'a> {
	/// The route's side: "Alliance" or "Horde".
	pub faction: &'a str,
	/// The start's race, for a shared guide its own part plays before the join (Night Elves' Darkshore).
	pub start_race: &'a str,
	/// The stem of the faction's join guide (`02-westfall`): it and the shared guides after it are the
	/// faction's shared guides.
	pub join_at: Option<&'a str>,
	/// The character's level at an accept or a hand-in of the route: (`accept`|`turnin`, quest).
	pub lvl: &'a FxHashMap<(&'static str, u32), f64>,
	/// A map's zone name ("Stormwind City").
	pub zone_of_map: &'a dyn Fn(u32) -> Option<String>,
	/// The classes a race plays on the route's side (labels).
	pub playable: &'a dyn Fn(&str) -> Vec<String>,
	/// Yards from where a goal line's NPC stands (an accept's giver, a hand-in's ender, a `train` or
	/// `npc` id) to an NPC, when both are known.
	pub npc_yd: &'a dyn Fn(&str, u32) -> Option<f64>,
}

/// A step of a guide and what the pass reads of it.
struct St {
	/// Where a weapon step after it goes: the line after the step (the next step or section line),
	/// or the step's own line when its last goal is a `goto` on the way out (the Deeprun Tram).
	at: usize,
	zone: Option<String>,
	/// The step's own `only` races and classes (empty: everyone).
	races: Vec<String>,
	classes: Vec<String>,
	/// No `when`, `along`, `skipto`, negated `only`, flight or hearth: a step the class is surely at.
	plain: bool,
	/// Per goal that is not travel: the classes and races its own `only` names.
	goals: Vec<(Vec<String>, Vec<String>)>,
	/// The level reached by the step's end.
	lvl: f64,
	/// Its goal lines' code.
	codes: Vec<String>,
}

fn only_parts(list: &str) -> Option<(Vec<String>, Vec<String>)> {
	let mut races = Vec::new();
	let mut classes = Vec::new();
	for x in list.split(',').map(trim).filter(|x| !x.is_empty()) {
		if x.starts_with('!') {
			return None;
		}
		if CLASSES.contains(&x) {
			classes.push(x.to_string());
		} else if ALL_RACES.contains(&x) {
			races.push(x.to_string());
		}
	}
	Some((races, classes))
}

fn line_only(code: &str) -> Option<&str> {
	re!(r"\sonly\s+(\S+)\s*$").captures(code).map(|m| m.get(1).unwrap().as_str())
}

fn price(copper: u32) -> (String, String) {
	if copper.is_multiple_of(10000) {
		let g = copper / 10000;
		(format!("{g}g"), format!("{g} gold"))
	} else if copper.is_multiple_of(100) {
		let s = copper / 100;
		(format!("{s}s"), format!("{s} silver"))
	} else {
		(format!("{copper}c"), format!("{copper} copper"))
	}
}

/// The guide's steps, the zone each is read in and the level the route reaches by its end (`lvl`:
/// the level read so far and a jump waiting for a second line to confirm it).
fn steps_of(lines: &[String], env: &Env, lvl: &mut (f64, Option<f64>)) -> Vec<St> {
	/// A quest line this far above the level read so far is the route's elsewhere, unless the next
	/// one is that far above too (a new guide's start).
	const MAX_STEP_LVL: f64 = 5.0;
	let mut out: Vec<St> = Vec::new();
	let mut zone: Option<String> = None;
	let mut i = 0;
	while i < lines.len() {
		if !is_step(&lines[i]) {
			i += 1;
			continue;
		}
		let mut j = i + 1;
		while j < lines.len() && !is_step(&lines[j]) && !starts_nonspace(&lines[j]) {
			j += 1;
		}
		let mut st = St { at: j, zone: None, races: Vec::new(), classes: Vec::new(), plain: true, goals: Vec::new(), lvl: 0.0, codes: Vec::new() };
		let mut moves = false;
		for l in &lines[i + 1..j] {
			let code = split_comment(l).0;
			match head(code) {
				Some("zone") => zone = Some(trim(&code.trim_start()[4..]).to_string()),
				Some("only") => match only_parts(trim(&code.trim_start()[4..])) {
					Some((r, c)) => (st.races, st.classes) = (r, c),
					None => st.plain = false,
				},
				Some("when" | "along" | "skipto") => st.plain = false,
				Some("fly" | "hearth") => moves = true,
				_ => {}
			}
			// (The level: the route's at the quests everyone does here and the `level` lines everyone
			// reaches; not a class's or race's line, nor a lone jump the route makes elsewhere: the
			// Dwarf Paladins' Honor Students hand-in of 414, which the route makes at 38.)
			let everyone = st.classes.is_empty() && st.races.is_empty() && line_only(code).is_none();
			if let Some(m) = re!(r"^\s+(accept|turnin)\s+(\d+)\b").captures(code).filter(|_| everyone) {
				let k: &'static str = if &m[1] == "accept" { "accept" } else { "turnin" };
				if let Some(&v) = m[2].parse::<u32>().ok().and_then(|q| env.lvl.get(&(k, q))) {
					if lvl.0 == 0.0 || v <= lvl.0 + MAX_STEP_LVL {
						lvl.0 = lvl.0.max(v);
						lvl.1 = None;
					} else if let Some(p) = lvl.1.filter(|p| (p - v).abs() <= MAX_STEP_LVL) {
						lvl.0 = p.min(v);
						lvl.1 = None;
					} else {
						lvl.1 = Some(v);
					}
				}
			}
			if let Some(m) = re!(r"^\s+level\s+(\d+(?:\.\d+)?)\b").captures(code).filter(|_| everyone) {
				lvl.0 = lvl.0.max(m[1].parse::<f64>().unwrap_or(0.0));
			}
			if is_goal(l) {
				st.codes.push(code.to_string());
			}
			if is_goal(l) && !matches!(head(l), Some("goto" | "note" | "level" | "fly" | "hearth")) {
				let parts = match line_only(code) {
					Some(o) => only_parts(o),
					None => Some((Vec::new(), Vec::new())),
				};
				let Some((r, c)) = parts else { continue };
				st.goals.push((c, r));
			}
		}
		if lines[i + 1..j].iter().rev().find(|l| is_goal(l)).is_some_and(|l| head(l) == Some("goto")) {
			st.at = i;
		}
		st.zone = zone.clone();
		st.plain &= !moves;
		st.lvl = lvl.0;
		out.push(st);
		i = j;
	}
	out
}

/// Whether the step is one `class` plays there: its own `only` lets the class in, and a goal of it
/// that is no travel is the class's (a goal for some races only counts when they are the step's).
fn plays(st: &St, class: &str) -> bool {
	if !st.plain || (!st.classes.is_empty() && !st.classes.iter().any(|c| c == class)) {
		return false;
	}
	st.goals.iter().any(|(c, r)| (c.is_empty() || c.iter().any(|x| x == class)) && (r.is_empty() || (!st.races.is_empty() && st.races.iter().all(|x| r.contains(x)))))
}

/// The weapon steps for the chain's guides (`(file, lines)` in the order played), each right after
/// the last step its class plays at a capital visit (before it, when it ends on its way out). -> what
/// was added, for the log.
pub fn weapon_steps(files: &mut [(String, Vec<String>)], env: &Env) -> Vec<String> {
	let mut log = Vec::new();
	let faction_races: Vec<String> = match env.faction {
		"Horde" => crate::apply::FACTION_RACES_HORDE.iter().map(|s| s.to_string()).collect(),
		"Alliance" => crate::apply::FACTION_RACES_ALLIANCE.iter().map(|s| s.to_string()).collect(),
		_ => return log,
	};
	let masters: Vec<(&Master, String)> = MASTERS.iter().filter(|m| m.side == env.faction).filter_map(|m| (env.zone_of_map)(m.map).map(|z| (m, z))).collect();
	let stem = |f: &str| f.rsplit('/').next().unwrap_or(f).trim_end_matches(".guide").to_string();
	let header_races = |lines: &[String]| races_of(&lines.iter().take_while(|l| !is_step(l)).cloned().collect::<Vec<_>>());
	let join = env.join_at.and_then(|j| files.iter().position(|(f, ls)| stem(f) == j && header_races(ls).is_empty()));
	// (Per part, own or shared, the races each class has been offered each skill for.)
	let mut covered: FxHashMap<(bool, &str, &str), FxHashSet<String>> = FxHashMap::default();
	let mut lvl: (f64, Option<f64>) = (0.0, None);
	for (fi, (file, lines)) in files.iter_mut().enumerate() {
		let own_races = header_races(lines);
		let shared = own_races.is_empty() && join.is_some_and(|j| fi >= j);
		// (Who reads the guide: its races; a shared guide's own part, the start's race, named on the
		// step as the guide does not.)
		let named = !own_races.is_empty() || shared;
		let file_races: Vec<String> = if !own_races.is_empty() {
			own_races
		} else if shared {
			faction_races.clone()
		} else {
			vec![env.start_race.to_string()]
		};
		let sts = steps_of(lines, env, &mut lvl);
		let mut adds: Vec<(usize, Vec<String>)> = Vec::new();
		for (class, skills, why) in PLANS.iter() {
			// (The class's visits: its steps in a capital, other classes' steps between left out: the
			// Shamans' tram to Ironforge in the middle of a Stormwind visit.)
			let mine: Vec<&St> = sts.iter().filter(|s| s.classes.is_empty() || s.classes.iter().any(|c| c == class)).collect();
			let can: Vec<String> = file_races.iter().filter(|r| (env.playable)(r).iter().any(|c| c == class)).cloned().collect();
			let mut k = 0;
			while k < mine.len() {
				let zone = mine[k].zone.clone();
				let mut e = k + 1;
				while e < mine.len() && mine[e].zone == zone {
					e += 1;
				}
				let visit = &mine[k..e];
				k = e;
				let here: Vec<&Master> = masters.iter().filter(|(_, z)| Some(z) == zone.as_ref()).map(|(m, _)| *m).collect();
				if here.is_empty() {
					continue;
				}
				// (The class's last step there, before it leaves: its training first would send it back
				// across the city to a place it had passed, the Human Paladins' Cathedral training between
				// their Tome of Divinity and the Trade District flight master, c15.)
				let Some(at) = visit.iter().rev().find(|s| plays(s, class)) else { continue };
				for skill in skills.iter() {
					let mut block: Vec<String> = Vec::new();
					// (A skill from a level is offered at a visit the route reaches about then, its
					// `when level` the rest.)
					let from = if skill.level > 1.0 { skill.level - 0.5 } else { FROM_LEVEL };
					if at.lvl < from {
						continue;
					}
					let Some(m) = here.iter().find(|m| m.teaches.contains(skill)) else { continue };
					// (After the class's last step there beside the master, else its last: not back across
					// the city to him after a step elsewhere, Ansekhwa on Thunder Bluff's central rise after
					// Elder Rise, c17 Tauren dup-trip. Beside him by where the step ends, its last line with
					// a known place: the Human Paladins' Tome of Divinity passes Stephanie Turner by Woo Ping
					// but ends in the Cathedral, c18 Human Paladin dup-trip.)
					let put = visit.iter().rev().find(|s| plays(s, class) && s.codes.iter().rev().find_map(|c| (env.npc_yd)(c, m.npc)).is_some_and(|d| d <= NEAR_MASTER_YD)).unwrap_or(at);
					let done = covered.entry((shared, class, skill.name)).or_default();
					let aud: Vec<String> = can.iter().filter(|r| (at.races.is_empty() || at.races.contains(r)) && !done.contains(*r)).cloned().collect();
					if aud.is_empty() {
						continue;
					}
					done.extend(aud.iter().cloned());
					let only = if aud.len() == can.len() && at.races.is_empty() && named { class.to_string() } else { format!("{class},{}", aud.join(",")) };
					let (when_price, words) = price(skill.copper);
					let area = m.area.map(|a| format!("{a}, ")).unwrap_or_default();
					block.push(format!("step {}", m.name));
					block.push(format!("  only {only}"));
					block.push(format!("  zone {}", zone.as_deref().unwrap_or("")));
					if skill.level > 1.0 {
						block.push(format!("  when level>={}", skill.level));
					}
					block.push(format!("  when money>={when_price}"));
					block.push(format!("  when !skill \"{}\" 1", skill.name));
					block.push(format!("  tip While you're here: learn {} from {} ({area}{words}); {why}.", skill.name, m.name));
					block.push(format!("{:<38}-- {}", format!("  train {}", m.npc), m.name));
					block.push(String::new());
					log.push(format!("weapon step: {file} at line {}: {} {} from {} ({words}) at level {:.1}", put.at + 1, only, skill.name, m.name, at.lvl));
					match adds.iter_mut().find(|a| a.0 == put.at) {
						Some(a) => a.1.extend(block),
						None => adds.push((put.at, block)),
					}
				}
			}
		}
		adds.sort_by_key(|a| std::cmp::Reverse(a.0));
		for (at, mut block) in adds {
			if at > 0 && !lines[at - 1].trim().is_empty() {
				block.insert(0, String::new());
			}
			lines.splice(at..at, block);
		}
	}
	log
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn a_class_line_or_a_lone_jump_the_route_makes_elsewhere_does_not_raise_the_level() {
		// c15 Dwarf, Dun Morogh: the Paladins' Honor Students hand-in of 414, which the route makes at
		// 38, read the Stormwind visit at 12 as 38 and offered Polearms there. A second line that far
		// up confirms a jump (a new guide's start).
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 1), 12.0), (("turnin", 414), 38.6), (("turnin", 2), 30.0), (("turnin", 3), 31.0)].into_iter().collect();
		let env = Env { faction: "Alliance", start_race: "Dwarf", join_at: None, lvl: &lvl, zone_of_map: &|_| None, playable: &|_| Vec::new(), npc_yd: &|_, _| None };
		let mut at = (0.0, None);
		let sts = steps_of(&v(&["step A", "  turnin 1", "step Honor Students", "  only Paladin", "  turnin 414", "step B", "  turnin 414", "step C", "  accept 9"]), &env, &mut at);
		assert_eq!(sts.iter().map(|s| s.lvl).collect::<Vec<_>>(), vec![12.0, 12.0, 12.0, 12.0]);
		let sts = steps_of(&v(&["step D", "  turnin 2", "step E", "  turnin 3"]), &env, &mut at);
		assert_eq!(sts.iter().map(|s| s.lvl).collect::<Vec<_>>(), vec![12.0, 30.0]);
	}

	fn v(xs: &[&str]) -> Vec<String> {
		xs.iter().map(|x| x.to_string()).collect()
	}

	fn zone_of(map: u32) -> Option<String> {
		Some(
			match map {
				1453 => "Stormwind City",
				1455 => "Ironforge",
				1457 => "Darnassus",
				1454 => "Orgrimmar",
				1456 => "Thunder Bluff",
				1458 => "Undercity",
				_ => return None,
			}
			.to_string(),
		)
	}

	fn playable(race: &str) -> Vec<String> {
		let cs: &[&str] = match race {
			"Human" => &["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Mage", "Warlock"],
			"Dwarf" => &["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Shaman"],
			"Gnome" => &["Warrior", "Rogue", "Priest", "Mage", "Warlock"],
			"NightElf" => &["Warrior", "Hunter", "Rogue", "Priest", "Druid"],
			"Skyborne" => &["Warrior", "Hunter", "Rogue", "Mage", "Druid"],
			_ => &[],
		};
		cs.iter().map(|c| c.to_string()).collect()
	}

	fn run(files: &mut [(String, Vec<String>)], lvl: &FxHashMap<(&'static str, u32), f64>) -> Vec<String> {
		let env = Env { faction: "Alliance", start_race: "Human", join_at: Some("02-westfall"), lvl, zone_of_map: &zone_of, playable: &playable, npc_yd: &|_, _| None };
		weapon_steps(files, &env)
	}

	#[test]
	fn the_weapon_step_follows_the_last_step_beside_its_master() {
		// c17 Tauren, Thunder Bluff: Eyahn on the central rise beside Ansekhwa, then Elder Rise; the
		// Warriors' Ansekhwa step went after Elder Rise, back across the bridges (dup-trip). It goes
		// after Eyahn's step.
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 744), 12.0)].into_iter().collect();
		let mut files = vec![(
			"forever/horde/tauren/01-mulgore.guide".to_string(),
			v(&[
				"guide forever/horde/tauren/01-mulgore",
				"race Tauren",
				"",
				"step Eyahn Eagletalon",
				"  zone Thunder Bluff",
				"  turnin 744",
				"",
				"step Elder Rise",
				"  zone Thunder Bluff",
				"  accept 886",
				"",
				"step Mulgore",
				"  zone Mulgore",
				"  accept 1",
			]),
		)];
		let near = |code: &str, npc: u32| -> Option<f64> { (npc == 11869).then(|| if code.contains("744") { 30.0 } else { 400.0 }) };
		let env = Env { faction: "Horde", start_race: "Tauren", join_at: None, lvl: &lvl, zone_of_map: &zone_of, playable: &|_| vec!["Warrior".to_string()], npc_yd: &near };
		weapon_steps(&mut files, &env);
		let text = files[0].1.join("\n");
		let master = text.find("step Ansekhwa").unwrap();
		assert!(master > text.find("turnin 744").unwrap() && master < text.find("step Elder Rise").unwrap(), "{text}");
	}

	#[test]
	fn a_step_beside_the_master_is_judged_by_where_it_ends() {
		// c18 Human Paladin, Westfall's Stormwind: the Tome of Divinity hands in to Stephanie Turner by
		// Woo Ping, then ends in the Cathedral; the Paladins' Woo Ping step went after it, back across
		// the city to the Trade District (dup-trip). It goes at the end of the visit.
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 64), 15.0)].into_iter().collect();
		let mut lines = westfall(" only Warrior,Paladin,Hunter,Rogue,Priest,Mage,Warlock,Druid");
		lines.splice(
			7..7,
			v(&[
				"step The Tome of Divinity",
				"  only Human,Paladin",
				"  zone Stormwind City",
				"  turnin 1643 only Human",
				"  accept 1780 only Human",
				"  turnin 1780 only Human",
				"  accept 1786 only Human",
				"",
			]),
		);
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), lines)];
		let near = |code: &str, npc: u32| -> Option<f64> {
			(npc == 11867).then_some(()).and_then(|_| {
				if code.contains("1643") || code.contains("accept 1780") {
					Some(20.0)
				} else if code.contains("1786") || code.contains("turnin 1780") {
					Some(600.0)
				} else {
					None
				}
			})
		};
		let env = Env { faction: "Alliance", start_race: "Human", join_at: Some("02-westfall"), lvl: &lvl, zone_of_map: &zone_of, playable: &playable, npc_yd: &near };
		weapon_steps(&mut files, &env);
		let text = files[0].1.join("\n");
		let paladin = text.find("  only Paladin\n").unwrap();
		assert!(paladin > text.find("  getfp").unwrap() && paladin < text.find("step Back to Westfall").unwrap(), "{text}");
	}

	fn westfall(train_only: &str) -> Vec<String> {
		v(&[
			"guide forever/alliance/02-westfall",
			"faction Alliance",
			"",
			"step Sentinel Hill",
			"  zone Westfall",
			"  turnin 64",
			"",
			"step Stormwind",
			"  zone Stormwind City",
			"  tip Trainers stand in Old Town.",
			&format!("  train class{train_only} -- Level 12, 14 and 16 spells"),
			"",
			"step Stormwind City",
			"  zone Stormwind City",
			"  getfp \"Stormwind\"",
			"",
			"step Back to Westfall",
			"  zone Westfall",
			"  turnin 65",
		])
	}

	#[test]
	fn a_capital_visit_at_level_10_or_later_gets_the_class_weapon_steps_after_its_last_step_there() {
		// The shared Westfall's Stormwind (Human at 15): the training, then the flight master. Every
		// class with a skill Woo Ping teaches gets one step after the flight master, the last step of
		// the visit, gated on the price and the skill not learned.
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 64), 15.0)].into_iter().collect();
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), westfall(" only Warrior,Paladin,Hunter,Rogue,Priest,Mage,Warlock,Druid"))];
		let log = run(&mut files, &lvl);
		let text = files[0].1.join("\n");
		let first = text.find("step Woo Ping").unwrap();
		assert!(first > text.find("  getfp").unwrap() && first < text.find("step Back to Westfall").unwrap(), "{text}");
		assert!(text.contains(
			"step Woo Ping\n  only Warrior\n  zone Stormwind City\n  when money>=10s\n  when !skill \"Two-Handed Swords\" 1\n  tip While you're here: learn Two-Handed Swords from Woo Ping (Trade District, 10 silver); two-handers level a Warrior fastest.\n  train 11867                         -- Woo Ping\n"
		), "{text}");
		for (only, skill) in [("Paladin", "Two-Handed Swords"), ("Hunter", "Staves"), ("Rogue", "Swords"), ("Priest", "Staves"), ("Warlock", "Staves")] {
			assert!(text.contains(&format!("  only {only}\n  zone Stormwind City\n  when money>=10s\n  when !skill \"{skill}\" 1\n")), "{only}: {text}");
		}
		// (Polearms wait for 20; the Axes and Maces are Ironforge's.)
		assert!(!text.contains("Polearms") && !text.contains("Two-Handed Axes"), "{text}");
		assert_eq!(log.len(), 6, "{log:?}");
	}

	#[test]
	fn a_last_step_that_ends_on_the_way_out_gets_the_weapon_step_before_it() {
		// c15 Dwarf, Dun Morogh: Ironforge's "The Deeprun Tram" trains, then walks to the tram. The
		// weapon master comes before it, not after the walk to the tram and back.
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 64), 12.0)].into_iter().collect();
		let mut lines = westfall(" only Warrior");
		for l in lines.iter_mut() {
			if l == "  zone Stormwind City" {
				*l = "  zone Ironforge".into();
			}
		}
		lines[14] = "  getfp \"Ironforge\" only Druid".into();
		lines.insert(11, "  goto 78.0,51.4 \"Deeprun Tram\"".into());
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), lines)];
		run(&mut files, &lvl);
		let text = files[0].1.join("\n");
		let master = text.find("step Buliwyf Stonehand").unwrap();
		assert!(master < text.find("step Stormwind\n").unwrap() && master > text.find("  turnin 64").unwrap(), "{text}");
	}

	#[test]
	fn another_classes_detour_does_not_split_a_classes_visit() {
		// c15 Human, Westfall's Stormwind: the Paladins' Tome of Divinity, the Shamans' tram to
		// Ironforge and back, then everyone's training and the flight master. The Paladins' step goes
		// after those, for every Paladin, not after the Human Paladins' class quest.
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 64), 15.0)].into_iter().collect();
		let mut lines = westfall(" only Warrior,Paladin,Hunter,Rogue,Priest,Mage,Warlock,Druid");
		lines.splice(
			7..7,
			v(&[
				"step The Tome of Divinity",
				"  only Human,Paladin",
				"  zone Stormwind City",
				"  accept 1641 only Human",
				"",
				"step Shaman training",
				"  only Shaman",
				"  zone Ironforge",
				"  train class",
				"",
			]),
		);
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), lines)];
		run(&mut files, &lvl);
		let text = files[0].1.join("\n");
		let paladin = text.find("  only Paladin\n").unwrap();
		assert!(paladin > text.find("  train class only").unwrap(), "{text}");
		assert_eq!(text.matches("only Paladin").count(), 1, "{text}");
	}

	#[test]
	fn no_weapon_step_below_level_10_away_from_a_capital_or_for_a_class_not_at_the_visit() {
		let low: FxHashMap<(&'static str, u32), f64> = [(("turnin", 64), 8.0)].into_iter().collect();
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), westfall(""))];
		assert!(run(&mut files, &low).is_empty());
		// (Only the Druids train there: no other class's step, and Druids have no weapon to add.)
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 64), 15.0)].into_iter().collect();
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), westfall(""))];
		files[0].1[10] = "  train class only Druid".into();
		files[0].1[14] = "  getfp \"Stormwind\" only Druid".into();
		assert!(run(&mut files, &lvl).is_empty(), "{:?}", files[0].1);
		// (Not a capital: nothing.)
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), westfall(""))];
		for l in files[0].1.iter_mut() {
			if l == "  zone Stormwind City" {
				*l = "  zone Elwynn Forest".into();
			}
		}
		assert!(run(&mut files, &lvl).is_empty());
	}

	#[test]
	fn each_skill_is_offered_once_per_part_and_polearms_from_20_with_its_level_and_gold_gate() {
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 64), 17.0), (("turnin", 165), 21.0)].into_iter().collect();
		let mut later = westfall(" only Warrior");
		later[0] = "guide forever/alliance/03-darkshore".into();
		later[5] = "  turnin 165".into();
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), westfall(" only Warrior")), ("forever/alliance/03-darkshore.guide".to_string(), later)];
		run(&mut files, &lvl);
		let a = files[0].1.join("\n");
		let b = files[1].1.join("\n");
		// (Every class plays the getfp step there; the Warriors' skills are the point here.)
		assert_eq!(a.matches("  only Warrior\n").count(), 1, "{a}");
		assert!(a.contains("\"Two-Handed Swords\""));
		// (The second visit: Polearms only, at 21, behind its level and its gold.)
		assert_eq!(b.matches("  only Warrior\n").count(), 1, "{b}");
		assert!(b.contains("  only Warrior\n  zone Stormwind City\n  when level>=20\n  when money>=1g\n  when !skill \"Polearms\" 1\n  tip While you're here: learn Polearms from Woo Ping (Trade District, 1 gold);"), "{b}");
	}

	#[test]
	fn a_visit_some_races_make_offers_the_skill_to_them_and_a_later_visit_to_the_rest() {
		// Ironforge at 12 for the Dwarves' own step, then at 28 for everyone: the Dwarf Warriors are
		// offered Two-Handed Axes at the first, the other races' Warriors at the second.
		let lvl: FxHashMap<(&'static str, u32), f64> = [(("turnin", 64), 12.0), (("turnin", 165), 28.0)].into_iter().collect();
		let mut first = westfall(" only Warrior");
		for l in first.iter_mut() {
			if l == "  zone Stormwind City" {
				*l = "  zone Ironforge".into();
			}
		}
		first.insert(9, "  only Dwarf".into());
		first[15] = "  getfp \"Stormwind\" only Dwarf,Warrior".into();
		let mut second = first.clone();
		second.remove(9);
		second[14] = "  getfp \"Stormwind\"".into();
		second[0] = "guide forever/alliance/06-ashenvale".into();
		second[5] = "  turnin 165".into();
		let mut files = vec![("forever/alliance/02-westfall.guide".to_string(), first), ("forever/alliance/06-ashenvale.guide".to_string(), second)];
		run(&mut files, &lvl);
		let a = files[0].1.join("\n");
		let b = files[1].1.join("\n");
		assert!(a.contains("step Buliwyf Stonehand\n  only Warrior,Dwarf\n  zone Ironforge\n  when money>=10s\n  when !skill \"Two-Handed Axes\" 1\n"), "{a}");
		assert!(b.contains("step Buliwyf Stonehand\n  only Warrior,Human,Gnome,NightElf,Skyborne\n  zone Ironforge\n  when money>=10s\n  when !skill \"Two-Handed Axes\" 1\n"), "{b}");
		// (Paladins play the second visit's getfp step only: Two-Handed Axes for every Paladin there.)
		assert!(b.contains("  only Paladin\n  zone Ironforge\n  when money>=10s\n  when !skill \"Two-Handed Axes\" 1\n"), "{b}");
		assert!(!a.contains("only Paladin"), "{a}");
	}
}
