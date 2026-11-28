//! `forge guide lint`'s tip rule: a step's tip that tells the player to do something (use, right-click,
//! read, drink, throw, plant or place an item; click or open an object; wear or equip something; talk to
//! someone; an emote; board a ship) that no goal row of the step does. A tip is the why, never the only
//! place an action lives: an action only a tip names is one a player who reads the goal rows never does
//! (Tanaris Field Sampling: the untested samples, looted and never used, cost a player two hours).
//!
//! A sentence is an instruction when it opens with an imperative (after a lead-in such as `Then`, `Back
//! at the camp,` or `If one drops,`), and each action verb of that opening and of the clauses chained to it
//! (`, then`, `and`, `to`) counts. The action is done by a goal row when the step holds one of the verbs
//! that do it (COVER); a `use` naming an item token (`{item:N}`) needs `use N` itself. A real false positive
//! (a potion between waves, the spellbook to open) is marked on the line right above the tip with
//! `# tip-ok: <why>`. Instructions not fixed yet are listed in guides/tip-actions-pending.json: those are
//! warnings until their step gets its rows.

use crate::diag::Diagnostics;
use crate::js::V;
use crate::project::Source;
use crate::re;

/// One action a tip names that no goal row of its step does.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Finding {
	/// 1-based line of the tip.
	pub line: usize,
	/// The action's kind: use, click, equip, talk, emote or board.
	pub verb: &'static str,
	/// The sentence that says it.
	pub sentence: String,
}

/// The action verbs and the kind of action each names.
const ACTION: [(&str, &str); 22] = [
	("use", "use"),
	("right-click", "use"),
	("drink", "use"),
	("throw", "use"),
	("plant", "use"),
	("place", "use"),
	("combine", "use"),
	("read", "use"),
	("click", "click"),
	("open", "click"),
	("interact", "click"),
	("equip", "equip"),
	("wear", "equip"),
	("talk", "talk"),
	("speak", "talk"),
	("kneel", "emote"),
	("bow", "emote"),
	("salute", "emote"),
	("dance", "emote"),
	("cheer", "emote"),
	("board", "board"),
	("emote", "emote"),
];

/// The goal verbs that do each kind of action.
const COVER: [(&str, &[&str]); 6] = [
	("use", &["use", "cast", "equip", "task", "hearth", "destroy"]),
	("click", &["interact", "use", "task"]),
	("equip", &["equip", "task"]),
	("talk", &["talk", "accept", "turnin", "vendor", "train", "buy", "task", "getfp", "sethome", "learn"]),
	("emote", &["task", "cast"]),
	("board", &["goto", "enter", "task", "fly"]),
];

/// Words a sentence giving an order opens with: the action verbs and the other imperatives a tip chains
/// them to (`kill them and use the jar on their remains`).
const IMPERATIVES: [&str; 96] = [
	"kill",
	"use",
	"right-click",
	"click",
	"open",
	"loot",
	"take",
	"go",
	"ride",
	"head",
	"follow",
	"talk",
	"speak",
	"run",
	"walk",
	"fly",
	"swim",
	"climb",
	"return",
	"stand",
	"stay",
	"keep",
	"wait",
	"pick",
	"gather",
	"collect",
	"bring",
	"give",
	"hand",
	"turn",
	"buy",
	"sell",
	"equip",
	"wear",
	"read",
	"drink",
	"throw",
	"plant",
	"place",
	"combine",
	"kneel",
	"board",
	"jump",
	"cross",
	"enter",
	"leave",
	"look",
	"search",
	"find",
	"grab",
	"target",
	"pull",
	"fight",
	"clear",
	"skip",
	"avoid",
	"circle",
	"hop",
	"step",
	"drop",
	"dive",
	"wade",
	"slay",
	"defeat",
	"mine",
	"skin",
	"fish",
	"train",
	"learn",
	"bind",
	"hearth",
	"sit",
	"eat",
	"mount",
	"dismount",
	"summon",
	"fill",
	"light",
	"lure",
	"call",
	"free",
	"release",
	"escort",
	"interact",
	"bow",
	"salute",
	"dance",
	"cheer",
	"tell",
	"ask",
	"show",
	"put",
	"set",
	"carry",
	"move",
	"save",
];

/// Step lines that are not goal rows.
const STEP_KEYS: [&str; 10] = ["tip", "zone", "only", "when", "label", "along", "background", "skipto", "loop", "image"];

fn action(word: &str) -> Option<&'static str> {
	if word.starts_with('/') {
		return Some("emote");
	}
	let w = word.to_ascii_lowercase();
	ACTION.iter().find(|(v, _)| *v == w).map(|(_, k)| *k)
}

fn covered(kind: &str, verbs: &[String]) -> bool {
	COVER.iter().find(|(k, _)| *k == kind).is_some_and(|(_, by)| verbs.iter().any(|v| by.contains(&v.as_str())))
}

/// A tip's sentences: split after `.`, `!`, `?`, `;` or `:` followed by a space.
fn sentences(tip: &str) -> Vec<&str> {
	let mut out = Vec::new();
	let b = tip.as_bytes();
	let mut start = 0;
	for i in 0..b.len() {
		if matches!(b[i], b'.' | b'!' | b'?' | b';' | b':') && (i + 1 == b.len() || b[i + 1] == b' ') {
			let s = tip[start..=i].trim();
			if !s.is_empty() {
				out.push(s);
			}
			start = i + 1;
		}
	}
	let s = tip[start..].trim();
	if !s.is_empty() {
		out.push(s);
	}
	out
}

/// The kinds of action an order in `sentence` names (empty when it gives none).
pub fn actions(sentence: &str) -> Vec<&'static str> {
	let lead = re!(
		r"(?i)^(?:(?:then|now|first|next|finally|there|here|inside|outside|afterwards|again|also|meanwhile)\b,?\s*|(?:if|when|once|after|before|at|on|in|from|with|by|back|up|down|near|beside|while|as soon as|whenever|should)\b[^,]{{0,80}},\s*)+"
	);
	let s = lead.replace(sentence.trim(), "");
	let Some(first) = re!(r"[A-Za-z][A-Za-z'-]*|/[a-z]+").find(&s) else { return Vec::new() };
	let first = first.as_str();
	if !(first.starts_with('/') || IMPERATIVES.contains(&first.to_ascii_lowercase().as_str())) {
		return Vec::new();
	}
	let mut out: Vec<&'static str> = action(first).into_iter().collect();
	for m in re!(r"(?:,\s*(?:and\s+|then\s+)?|\s+and\s+(?:then\s+)?|\s+then\s+|\bto\s+)([A-Za-z/][A-Za-z'/-]*)").captures_iter(&s) {
		if let Some(k) = action(&m[1]) {
			out.push(k);
		}
	}
	out.sort_unstable();
	out.dedup();
	out
}

/// Every action a tip of `text` (a guide's source) names that no goal row of its step does, unless the
/// line right above the tip says `# tip-ok: <why>`.
pub fn findings(text: &str) -> Vec<Finding> {
	findings_with(text, &|_, _| None)
}

/// [`findings`], where `also(verb, id)` names the kind of goal a row (`accept 1234`) does besides its own
/// verb: an accept of a quest an item starts is that item's use, a turn-in at an object its click.
pub fn findings_with(text: &str, also: &dyn Fn(&str, &str) -> Option<&'static str>) -> Vec<Finding> {
	let lines: Vec<&str> = text.lines().collect();
	let mut out = Vec::new();
	let mut i = 0;
	while i < lines.len() {
		if !is_step(lines[i]) {
			i += 1;
			continue;
		}
		let end = (i + 1..lines.len()).find(|&k| is_step(lines[k]) || (!lines[k].is_empty() && !lines[k].starts_with(char::is_whitespace) && !lines[k].starts_with('#'))).unwrap_or(lines.len());
		let mut verbs: Vec<String> = Vec::new();
		let mut uses: Vec<String> = Vec::new();
		let mut tips: Vec<(usize, &str)> = Vec::new();
		for (k, l) in lines.iter().enumerate().take(end).skip(i + 1) {
			let t = l.trim();
			if t.is_empty() || t.starts_with('#') {
				continue;
			}
			let mut w = t.split_whitespace();
			let head = w.next().unwrap_or("");
			if head == "tip" {
				let ok = (i + 1..k).rev().map(|j| lines[j].trim()).find(|x| !x.is_empty()).is_some_and(|x| x.strip_prefix("# tip-ok:").is_some_and(|why| !why.trim().is_empty()));
				if !ok {
					tips.push((k, t["tip".len()..].trim()));
				}
			} else if !STEP_KEYS.contains(&head) {
				let id = w.next().unwrap_or("");
				if head == "use" {
					uses.push(id.to_string());
				}
				verbs.push(head.to_string());
				verbs.extend(also(head, id).map(str::to_string));
			}
		}
		for (k, tip) in tips {
			for s in sentences(tip) {
				for kind in actions(s) {
					let mut ok = covered(kind, &verbs);
					if kind == "use" {
						ok &= re!(r"\{{item:(\d+)\}}").captures_iter(s).all(|m| uses.iter().any(|u| *u == m[1]));
					}
					if !ok {
						out.push(Finding { line: k + 1, verb: kind, sentence: s.to_string() });
					}
				}
			}
		}
		i = end;
	}
	out
}

fn is_step(l: &str) -> bool {
	l == "step" || l.starts_with("step ")
}

/// Whether guides/tip-actions-pending.json lists this finding: `{ pending: [{ file, verb, text }] }`, `file`
/// the guide's path under guides/ (the source's own path in the pack), `text` the sentence.
fn pending(list: &V, file: &str, f: &Finding) -> bool {
	list.get("pending").items().iter().any(|e| {
		let p = e.get("file").to_js_string();
		!p.is_empty() && p == file && e.get("verb").as_str() == Some(f.verb) && e.get("text").as_str() == Some(f.sentence.as_str())
	})
}

/// The rule over `sources`: an error per finding, a warning for one guides/tip-actions-pending.json lists.
/// `data`: the reference data, for the accepts an item starts and the quests an object gives or takes.
pub fn check(sources: &[Source], data: &crate::data::Data, pending_list: &V, diag: &mut Diagnostics) {
	let also = |verb: &str, id: &str| -> Option<&'static str> {
		let q = id.parse::<u32>().ok()?;
		let quest = data.quest(&V::Num(q as f64));
		let side = match verb {
			"accept" => quest.get("start"),
			"turnin" => quest.get("end"),
			_ => return None,
		};
		if verb == "accept" && !side.get("item").items().is_empty() {
			Some("use")
		} else if !side.get("object").items().is_empty() {
			Some("interact")
		} else {
			None
		}
	};
	for s in sources {
		for f in findings_with(&s.text, &also) {
			let msg = format!("the tip says to {} (\"{}\") but no goal row of the step does it", f.verb, f.sentence);
			let hint = Some(
				"give the action its own row (`use <item>`, `interact <object>`, `equip <item>`, `talk <npc>`, `task \"<what>\"`), with a guide-fixes `rows` record for a generated guide, and keep only the why in the tip; a real false positive takes `# tip-ok: <why>` on the line above"
					.to_string(),
			);
			if pending(pending_list, &s.source, &f) {
				diag.warn(&s.file, f.line as f64, msg, hint);
			} else {
				diag.error(&s.file, f.line as f64, msg, hint);
			}
		}
	}
}

#[cfg(test)]
mod tests {
	use super::{actions, findings, findings_with};

	#[test]
	fn orders_name_their_actions_and_descriptions_name_none() {
		assert_eq!(actions("Use the Toxin Extractor on the Gnawed Corpses."), ["use"]);
		assert_eq!(actions("kill them and use Laris's Empty Ooze Jar on their remains."), ["use"]);
		assert_eq!(actions("If one drops a Deadwood Ritual Totem (about one kill in thirty), right-click it;"), ["use"]);
		assert_eq!(actions("Back at the camp, open the cage:"), ["click"]);
		assert_eq!(actions("Then /cheer at a chicken until it turns friendly"), ["emote"]);
		assert_eq!(actions("Wear the Commission trinket while you fight the Scourge:"), ["equip"]);
		assert!(actions("Darkmist Lurkers move about stealthed and use poison once in combat.").is_empty(), "a mob's ability");
		assert!(actions("Each can drop an untested sample.").is_empty(), "a fact");
		assert!(actions("Right-click the book to start the quest;").contains(&"use"));
	}

	#[test]
	fn a_tip_action_without_a_goal_row_is_found_and_a_row_or_a_reasoned_marker_clears_it() {
		// Tanaris Field Sampling before: the use lived only in the tip.
		let before = "step Tanaris Field Sampling\n  tip Kill the beasts. Each can drop an untested sample: use it, and it either passes or is lost.\n  accept 654\n  collect 9441 quest 654.2\n";
		let f = findings(before);
		assert_eq!(f.len(), 1, "{f:?}");
		assert_eq!((f[0].line, f[0].verb), (2, "use"));
		let after =
			"step Tanaris Field Sampling\n  tip A sample can fail: keep going until you have eight of each.\n  accept 654\n  collect 9439\n  use 9439 quest 654.2\n  collect 9441 quest 654.2\n";
		assert!(findings(after).is_empty());
		// The use row covers it even with the old tip.
		let covered = "step S\n  tip Use the jar on the remains.\n  kill 1\n  use 5 quest 9.1\n";
		assert!(findings(covered).is_empty());
		// An item token needs its own use row.
		let token = "step S\n  tip Use {item:7} on the remains.\n  use 5 quest 9.1\n";
		assert_eq!(findings(token).len(), 1);
		let marked = "step S\n  # tip-ok: health potions between waves, no item of the quest\n  tip Fight in a corner and drink between waves.\n  kill 1\n";
		assert!(findings(marked).is_empty());
		let bare = "step S\n  # tip-ok:\n  tip Fight in a corner and drink between waves.\n  kill 1\n";
		assert_eq!(findings(bare).len(), 1, "a marker gives its reason");
		// Each step answers for its own tip.
		let two = "step A\n  tip Talk to the guard.\n  kill 1\n\nstep B\n  talk 2\n";
		assert_eq!(findings(two).iter().map(|f| f.line).collect::<Vec<_>>(), [2]);
	}

	#[test]
	fn an_accept_an_item_starts_is_that_items_use_and_a_hand_in_at_an_object_its_click() {
		let also = |verb: &str, id: &str| match (verb, id) {
			("accept", "968") => Some("use"),
			("turnin", "944") => Some("interact"),
			_ => None,
		};
		let book = "step S\n  tip If one drops the book, right-click it to start the quest.\n  accept 968 optional\n";
		assert_eq!(findings(book).len(), 1, "without the data the accept is no use");
		assert!(findings_with(book, &also).is_empty());
		let bowl = "step S\n  tip Click the Scrying Bowl to hand it in.\n  turnin 944\n";
		assert!(findings_with(bowl, &also).is_empty());
		let other = "step S\n  tip Click the Scrying Bowl to hand it in.\n  turnin 945\n";
		assert_eq!(findings_with(other, &also).len(), 1);
	}
}
