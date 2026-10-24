//! A v1 guide as the writer reads it: header lines, steps, and each step's lines typed by
//! their head word (a goal, a modifier every piece of a split step repeats, one only the
//! first piece keeps, or another line). Lines keep their text: the writer moves v1's lines,
//! it does not re-render them.

use crate::jsre::{head, indented, is_step, trim};
use crate::re;

/// What a step line is, by its head word.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kind {
	/// accept, turnin, kill, goto, … (GOAL).
	Goal,
	/// only, when, zone, loop: on every piece of a split step.
	Every,
	/// tip, label, along, image: on the first piece.
	First,
	Other,
}

pub const GOAL_WORDS: [&str; 27] = [
	"accept", "turnin", "complete", "kill", "collect", "goto", "talk", "interact", "use", "sethome", "hearth", "getfp", "fly", "train", "buy", "vendor", "level", "note", "skill", "learn", "craft",
	"rep", "explore", "achieve", "die", "enter", "equip",
];

/// `GOAL.test(text)`.
pub fn is_goal(text: &str) -> bool {
	head(text).is_some_and(|h| GOAL_WORDS.contains(&h))
}

pub fn kind_of(text: &str) -> Kind {
	match head(text) {
		Some(h) if GOAL_WORDS.contains(&h) => Kind::Goal,
		Some("only" | "when" | "zone" | "loop") => Kind::Every,
		Some("tip" | "label" | "along" | "image") => Kind::First,
		_ => Kind::Other,
	}
}

/// A step line: 1-based line `n` of guide `file` (its index in the chain), the zone it is read in.
#[derive(Clone, Debug, PartialEq)]
pub struct Line {
	pub n: u32,
	pub text: String,
	pub kind: Kind,
	pub file: usize,
	pub zone: Option<String>,
}

impl Line {
	pub fn key(&self) -> Key {
		(self.file, self.n)
	}
}

/// A v1 line: (chain file, 1-based line).
pub type Key = (usize, u32);

#[derive(Clone, Debug)]
pub struct Step {
	pub file: usize,
	/// Comments and blank lines above the step.
	pub pre: Vec<String>,
	/// The `step` line.
	pub title: String,
	pub lines: Vec<Line>,
	pub zone_in: Option<String>,
	pub zone: Option<String>,
	/// Lines after the guide's last step.
	pub post: Option<Vec<String>>,
	/// Index in the chain's steps.
	pub k: usize,
	/// The step's goal lines the route names.
	pub named: Vec<Line>,
	pub drop_all: bool,
	pub trail: Option<Vec<Line>>,
	pub way: bool,
}

impl Step {
	pub fn line(&self, n: u32) -> Option<&Line> {
		self.lines.iter().find(|l| l.n == n)
	}
}

#[derive(Clone, Debug)]
pub struct Guide {
	pub file: usize,
	pub header: Vec<String>,
	pub steps: Vec<Step>,
	pub header_zone: String,
}

/// `(header.find(/^zone\s/) || '').replace(/^zone\s+/, '').trim()`.
fn header_value(header: &[String], word: &str) -> String {
	let r = match word {
		"zone" => re!(r"^zone\s"),
		"race" => re!(r"^race\s"),
		_ => unreachable!(),
	};
	let strip = match word {
		"zone" => re!(r"^zone\s+"),
		_ => re!(r"^race\s+"),
	};
	header.iter().find(|l| r.is_match(l)).map_or(String::new(), |l| trim(&strip.replace(l, "")).to_string())
}

/// The guide's `race` header list (empty: every race of the faction).
pub fn races_of(header: &[String]) -> Vec<String> {
	header_value(header, "race").split(',').map(|r| trim(r).to_string()).filter(|r| !r.is_empty()).collect()
}

/// parseGuide: header lines, steps { pre, title, lines }.
pub fn parse_guide(file: usize, text: &str) -> Guide {
	let lines: Vec<&str> = text.split('\n').collect();
	let first = lines.iter().position(|l| is_step(l)).unwrap_or(lines.len());
	// Comments right above the first step belong to it.
	let mut h = first;
	while h > 0 && (lines[h - 1].starts_with('#') || trim(lines[h - 1]).is_empty()) {
		h -= 1;
	}
	let header: Vec<String> = lines[..h].iter().map(|s| s.to_string()).collect();
	let header_zone = header_value(&header, "zone");
	let mut zone = Some(header_zone.clone()).filter(|z| !z.is_empty());
	let mut steps: Vec<Step> = Vec::new();
	let mut pre: Vec<String> = lines[h..first].iter().map(|s| s.to_string()).collect();
	let zone_line = re!(r"^\s+zone\s");
	let zone_strip = re!(r"^\s+zone\s+");
	let mut i = first;
	while i < lines.len() {
		let mut step = Step {
			file,
			pre: std::mem::take(&mut pre),
			title: lines[i].to_string(),
			lines: Vec::new(),
			zone_in: zone.clone(),
			zone: None,
			post: None,
			k: 0,
			named: Vec::new(),
			drop_all: false,
			trail: None,
			way: false,
		};
		// A step runs to the next step or unindented line. A blank line or a column-0 comment inside
		// it (a goal group after a gap, a commented-out line) is the step's when an indented line
		// follows, as the compiler reads it. The comment stays with the step's lines, indented, so the
		// passes over the written text (along steps, post) read it inside the step too.
		let mut j = i + 1;
		while j < lines.len() {
			let gap = trim(lines[j]).is_empty();
			if gap || lines[j].starts_with('#') {
				let mut k = j;
				while k < lines.len() && (trim(lines[k]).is_empty() || lines[k].starts_with('#')) {
					k += 1;
				}
				if !(k < lines.len() && indented(lines[k])) {
					break;
				}
				if gap {
					j += 1;
					continue;
				}
			} else if !indented(lines[j]) {
				break;
			}
			let indented_comment;
			let text = if lines[j].starts_with('#') {
				indented_comment = format!("  {}", lines[j]);
				indented_comment.as_str()
			} else {
				lines[j]
			};
			if zone_line.is_match(text) {
				zone = Some(trim(&zone_strip.replace(text, "")).to_string());
			}
			step.lines.push(Line { n: (j + 1) as u32, text: text.to_string(), kind: kind_of(text), file, zone: zone.clone() });
			j += 1;
		}
		step.zone = zone.clone();
		let mut after = Vec::new();
		while j < lines.len() && !is_step(lines[j]) {
			after.push(lines[j].to_string());
			j += 1;
		}
		i = j;
		if j >= lines.len() && !after.is_empty() {
			step.post = Some(after);
		} else {
			pre = after;
		}
		steps.push(step);
	}
	Guide { file, header, steps, header_zone }
}

/// The guide's first `next` without a `when` (the guide the addon plays after it).
pub fn next_of(text: &str) -> Option<String> {
	let l = text.split('\n').find(|l| re!(r"^next\s+\S").is_match(l) && !re!(r"\bwhen\b").is_match(l))?;
	Some(trim(re!(r"^next\s+").replace(l, "").split(',').next().unwrap_or("")).to_string())
}
