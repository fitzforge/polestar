//! R6-R10 (GuideWriterPlan.md:21), played with the honest world (non-legacy only):
//!
//! - R6 gating from the data: an accept, turn-in or `complete` the persona plays for a quest whose race or
//!   class mask excludes it (no `only` gated the line: fail); an accept under an `only` naming races or
//!   classes for a quest the data opens to every race of the side, or every class (warn).
//! - R7 counts and levels in the text equal the data: a goal's `xN` against its objective's count (more:
//!   fail; fewer: warn, a split collect); numbers in the step's tips and goal texts (`xN`, `Nx`, `N of`, `N
//!   <objective name>`) against the step's objectives (fail); `level N` in a step that accepts quests
//!   against their levels (warn).
//! - R8 one `level` gate per grind: a `level` goal after another with no quest work between (fail).
//! - R9 the quest log holds at most [`LOG_MAX`]: one finding per chain at the peak (fail).
//! - R10 every accept is turned in or abandoned later on the chain (fail at the accept).

use super::play::{fits, push, Here};
use super::world::{has, id_of, World};
use super::{Severity, LOG_MAX};
use forge_core::{class_by_file, js_to_string, Faction, ALL_CLASSES};
use forge_guide::js::V;

/// A line a finding can be reported at.
#[derive(Clone, Debug)]
pub struct At {
	pub guide: String,
	pub file: String,
	pub line: u32,
	pub step: usize,
	pub title: String,
	pub reporting: bool,
}

#[derive(Default)]
pub struct State {
	/// The goal being played.
	cur: Option<At>,
	/// R8: the last `level` goal with no quest work since (its line and level).
	grind: Option<(At, String)>,
	/// R9: the peak log size, where it was reached, and where the log first went above LOG_MAX.
	peak: usize,
	peak_at: Option<At>,
	first_over: Option<At>,
}

const QUEST_WORK: [&str; 7] = ["accept", "turnin", "complete", "kill", "collect", "use", "interact"];

fn persona_label(w: &World) -> String {
	let race = match w.persona.race.as_str() {
		"Scourge" => "Undead".to_string(),
		"NightElf" => "Night Elf".to_string(),
		r => r.to_string(),
	};
	format!("{race} {}", forge_core::class_label(&w.persona.cls))
}

/// The step's and the goal's `only` lists of one kind.
fn gated(s: &V, x: &V, kind: &str) -> Vec<String> {
	let mut out: Vec<String> = s.get("only").get(kind).items().iter().map(V::to_js_string).collect();
	out.extend(x.get("only").get(kind).items().iter().map(V::to_js_string));
	out.retain(|v| !v.starts_with('!'));
	out
}

/// Before goal `x` (the persona plays it): R6, R8, and the current line for R9.
pub fn before_goal(w: &mut World, s: &V, x: &V, h: &Here, gi: usize) {
	let at = h.at(gi);
	w.rules.cur = Some(at.clone());
	let t = x.get("t").to_js_string();
	// R8: one gate per grind.
	if t == "level" {
		let lvl = x.get("level").to_js_string();
		if let Some((prev, plvl)) = &w.rules.grind {
			let reason = format!("level {lvl} follows the level {plvl} gate at {}:{} with no quest work between: one grind, one gate", prev.guide, prev.line);
			push(w, &at, "R8", Severity::Fail, reason, format!("drop the level {plvl} gate, or put the quest work between them"), None);
		}
		w.rules.grind = Some((at.clone(), lvl));
	} else if QUEST_WORK.contains(&t.as_str()) && has(&x.get("quest")) {
		w.rules.grind = None;
	}
	// R6: gating from the data.
	if !matches!(t.as_str(), "accept" | "turnin" | "complete") || !has(&x.get("quest")) {
		return;
	}
	let qv = x.get("quest");
	let q = w.ctx.quest(id_of(&qv));
	if !q.truthy() {
		return;
	}
	let name = w.ctx.title_of(&qv);
	let faction = Faction::parse(&w.persona.faction);
	let races = q.get("races").as_num().filter(|r| *r != 0.0).map(|r| r as u64);
	let classes = q.get("classes").as_num().filter(|c| *c != 0.0).map(|c| c as u32);
	let rbit = faction.map_or(0, |f| forge_world::rules::race_bit(&w.persona.race, f));
	let cbit = class_by_file(&w.persona.cls).map_or(0, |c| c.bit);
	let race_out = matches!(races, Some(r) if rbit != 0 && r & rbit == 0);
	let class_out = matches!(classes, Some(c) if cbit != 0 && c & ALL_CLASSES != ALL_CLASSES && c & cbit == 0);
	if race_out || class_out {
		let what = if race_out { "race" } else { "class" };
		let reason = format!("{t} {name}: the data closes it to {} (its {what} mask), and no `only` gates the line", persona_label(w));
		let repair = format!("gate the line with `only` the {}s the data opens it to, or drop it", if race_out { "race" } else { "classe" });
		push(w, &at, "R6", Severity::Fail, reason, repair, None);
		return;
	}
	if t != "accept" || !fits(&s.get("only"), &w.persona) {
		return;
	}
	let g_classes = gated(s, x, "classes");
	let g_races = gated(s, x, "races");
	let side_races = faction.map_or(0, Faction::era_races);
	let classes_open = classes.is_none_or(|c| c & ALL_CLASSES == ALL_CLASSES);
	let races_open = races.is_none_or(|r| side_races != 0 && r & side_races == side_races);
	let mut kinds = Vec::new();
	if !g_classes.is_empty() && classes_open {
		kinds.push(format!("only {}", g_classes.join(",")));
	}
	if !g_races.is_empty() && races_open {
		kinds.push(format!("only {}", g_races.join(",")));
	}
	if !kinds.is_empty() {
		let reason = format!("accept {name}: gated `{}` but the data opens it to everyone", kinds.join("` and `"));
		push(w, &at, "R6", Severity::Warn, reason, "drop the `only`, or say in a tip why only they take it".into(), None);
	}
}

/// After a played step: R7 on its goals and text.
pub fn after_step(w: &mut World, s: &V, goals: &[V], h: &Here) {
	// Objective counts of the step's goals: (count, names it goes by).
	let mut objectives: Vec<(f64, Vec<String>)> = Vec::new();
	let mut levels: Vec<f64> = Vec::new();
	let mut accepts = false;
	let mut level_goal = false;
	for (gi, x) in goals.iter().enumerate() {
		if !fits(&x.get("only"), &w.persona) {
			continue;
		}
		let t = x.get("t").to_js_string();
		if t == "level" {
			level_goal = true;
		}
		let q = w.ctx.quest(id_of(&x.get("quest")));
		if !q.truthy() {
			continue;
		}
		if t == "accept" {
			accepts = true;
			for k in ["minLevel", "level"] {
				if let Some(l) = q.get(k).as_num() {
					levels.push(l);
				}
			}
		}
		let oi = x.get("oi");
		if matches!(t.as_str(), "kill" | "collect" | "interact" | "use") && oi.num() >= 1.0 {
			let o = q.get("objectives").at(oi.num() as usize - 1);
			// An objective without a count in the data has nothing to compare.
			let Some(need) = o.get("count").as_num().filter(|c| *c > 0.0) else { continue };
			let oid = o.get("id");
			let ty = o.get("type").to_js_string();
			let mut names = Vec::new();
			if o.get("text").truthy() {
				names.push(o.get("text").to_js_string().to_lowercase());
			}
			match ty.as_str() {
				"item" => names.push(w.ctx.item_name(&oid).to_lowercase()),
				"kill" => names.push(w.ctx.npc_name(&oid).to_lowercase()),
				_ => {}
			}
			objectives.push((need, names));
			// The goal's own count, when it counts the objective's thing (a kill for a drop counts mobs).
			let same = (ty == "kill" && t == "kill" && oid.strict_eq(&x.get("npc"))) || (ty == "item" && t == "collect" && oid.strict_eq(&x.get("item")));
			let count = x.get("count");
			if same && count.truthy() && count.num() != need {
				let c = count.num();
				let (sev, why) = if c > need { (Severity::Fail, "more than") } else { (Severity::Warn, "fewer than") };
				let reason = format!("{t} x{} for {}: {why} the {} the data asks for", js_to_string(c), w.ctx.title_of(&x.get("quest")), js_to_string(need));
				push(w, &h.at(gi), "R7", sev, reason, format!("write x{}", js_to_string(need)), None);
			}
		}
	}
	let mut texts: Vec<String> = Vec::new();
	if s.get("note").truthy() {
		texts.push(s.get("note").to_js_string());
	}
	for x in goals {
		if fits(&x.get("only"), &w.persona) && x.get("text").truthy() {
			texts.push(x.get("text").to_js_string());
		}
	}
	for text in &texts {
		for claim in claims(text) {
			match claim {
				Claim::Count(n, name) => {
					if objectives.is_empty() {
						continue;
					}
					let ok = match &name {
						Some(nm) => {
							let named: Vec<f64> = objectives.iter().filter(|(_, names)| names.iter().any(|x| name_matches(nm, x))).map(|(c, _)| *c).collect();
							// Words naming no objective of the step are no count of one.
							named.is_empty() || named.contains(&n)
						}
						None => objectives.iter().any(|(c, _)| *c == n),
					};
					if !ok {
						let want = objectives.iter().map(|(c, _)| js_to_string(*c)).collect::<Vec<_>>().join(", ");
						let reason = format!("the text says {}{} but the step's objectives count {want}", js_to_string(n), name.map(|n| format!(" {n}")).unwrap_or_default());
						push(w, &h.at(0), "R7", Severity::Fail, reason, "write the data's count".into(), None);
					}
				}
				Claim::Level(n) => {
					if !accepts || level_goal || levels.contains(&n) {
						continue;
					}
					let want = levels.iter().map(|l| js_to_string(*l)).collect::<Vec<_>>().join(", ");
					let reason = format!("the text says level {} but the step's quests are level {want}", js_to_string(n));
					push(w, &h.at(0), "R7", Severity::Warn, reason, "write the quest's level from the data".into(), None);
				}
			}
		}
	}
}

/// After an accept grew the log: R9's peak.
pub fn log_grew(w: &mut World) {
	let n = w.log.len();
	if n <= LOG_MAX {
		return;
	}
	if w.rules.first_over.is_none() {
		w.rules.first_over = w.rules.cur.clone();
	}
	if n > w.rules.peak {
		w.rules.peak = n;
		w.rules.peak_at = w.rules.cur.clone();
	}
}

/// At the chain's end: R9 and R10.
pub fn chain_end(w: &mut World) {
	if let Some(at) = w.rules.peak_at.clone() {
		let first = w.rules.first_over.clone().unwrap_or_else(|| at.clone());
		let reason = format!("the quest log holds {} quests here (at most {LOG_MAX})", w.rules.peak);
		let repair = format!("above {LOG_MAX} from {}:{}: turn in or abandon quests before taking more, or take these later", first.guide, first.line);
		push(w, &at, "R9", Severity::Fail, reason, repair, None);
	}
	let open: Vec<(i64, At)> = w.log.iter().filter_map(|(q, e)| e.at.clone().map(|a| (*q, a))).collect();
	for (q, at) in open {
		let name = w.ctx.title_of(&V::Num(q as f64));
		push(w, &at, "R10", Severity::Fail, format!("accept {name}: never turned in or abandoned later on the chain"), format!("add `turnin {q}`, or `abandon {q}` where the route leaves it"), None);
	}
}

#[derive(Debug, PartialEq)]
pub enum Claim {
	/// A count: `xN` / `Nx` (no name), `N of <name>` or `<verb> N <name>` (the next words, lower case).
	Count(f64, Option<String>),
	/// A quest's level: `requires|needs|available at|opens at|from level N`, `level N quest`.
	Level(f64),
}

/// Whether the words after a number (`said`, up to three) name an objective (`name`): they start with the
/// name (plurals allowed), or their first word is the name's last (`5 scales` for "Singed Scale").
fn name_matches(said: &str, name: &str) -> bool {
	let stem = |s: &str| s.trim_end_matches("es").trim_end_matches('s').to_string();
	let name_stem = stem(name);
	if name_stem.is_empty() {
		return false;
	}
	let first = said.split(' ').next().unwrap_or("");
	said.starts_with(&name_stem) || name.rsplit(' ').next().is_some_and(|last| !first.is_empty() && stem(last) == stem(first))
}

/// Verbs that ask for a count of an objective (`Kill 8 Burrow Rats`).
const COUNT_VERBS: [&str; 14] = ["kill", "slay", "collect", "gather", "loot", "bring", "get", "obtain", "find", "destroy", "burn", "use", "recover", "retrieve"];
/// Words before `level N` that make it a quest's level.
const LEVEL_CUES: [&str; 10] = ["requires", "require", "required", "needs", "need", "available", "opens", "unlocks", "minimum", "min"];

/// Count and level claims in a text. Numbers in coordinates and decimals (`65,68`, `45.5`) are none.
pub fn claims(text: &str) -> Vec<Claim> {
	let lower = text.to_lowercase();
	let mut words: Vec<String> = Vec::new();
	for raw in lower.split_whitespace() {
		let b = raw.as_bytes();
		let joined = (1..b.len().saturating_sub(1)).any(|i| (b[i] == b',' || b[i] == b'.') && b[i - 1].is_ascii_digit() && b[i + 1].is_ascii_digit());
		if joined {
			words.push("#".into());
			continue;
		}
		for part in raw.split(|c: char| !(c.is_alphanumeric() || c == '\'' || c == '-')).filter(|w| !w.is_empty()) {
			words.push(part.to_string());
		}
	}
	let num = |w: &str| -> Option<f64> { (!w.is_empty() && w.len() <= 4 && w.bytes().all(|b| b.is_ascii_digit())).then(|| w.parse().unwrap()) };
	let tail = |from: usize| -> String { words[from.min(words.len())..].iter().take(3).cloned().collect::<Vec<_>>().join(" ") };
	let mut out = Vec::new();
	for i in 0..words.len() {
		let wd = words[i].as_str();
		if wd == "level" || wd == "lvl" {
			let Some(n) = words.get(i + 1).and_then(|w| num(w)) else { continue };
			let before = &words[i.saturating_sub(3)..i];
			let quest_after = words.get(i + 2).is_some_and(|w| w == "quest" || w == "quests");
			if quest_after || before.iter().any(|w| LEVEL_CUES.contains(&w.as_str())) {
				out.push(Claim::Level(n));
			}
			continue;
		}
		if let Some(n) = wd.strip_prefix('x').and_then(num).or_else(|| wd.strip_suffix('x').and_then(num)) {
			out.push(Claim::Count(n, None));
			continue;
		}
		let Some(n) = num(wd) else { continue };
		let next = words.get(i + 1).map(String::as_str).unwrap_or("");
		if next == "of" {
			let mut j = i + 2;
			while words.get(j).is_some_and(|w| matches!(w.as_str(), "the" | "your" | "their" | "these" | "those")) {
				j += 1;
			}
			if j < words.len() {
				out.push(Claim::Count(n, Some(tail(j))));
			}
		} else if i > 0 && COUNT_VERBS.contains(&words[i - 1].as_str()) && next.chars().next().is_some_and(char::is_alphabetic) {
			out.push(Claim::Count(n, Some(tail(i + 1))));
		}
	}
	out
}
