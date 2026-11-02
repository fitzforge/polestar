//! Port of tools/lib/dsl/parse.js.
//! Parser for .guide files (docs/GUIDE_FORMAT.md). Produces a syntax tree with
//! line numbers; filling from reference data happens in resolve.rs.
//!
//! parse_guide(text, file, diag) -> guide | Null
//!   guide = { file, id, line, header: { ... }, lines: { <headerKey>: line, pros: [line], cons: [line], rewards: [line], nextOf: { <id>: line } }, steps: [step] }
//!   (header.next: the `next` guide ids in order; header.nextWhen: { <id>: predicate with its line } for `next <id> when ...`)
//!   step  = { line, title, only, tip, image?, when?: [predicate], label?, along?, skipto?, goals: [goal] }
//!   (image: { path, ext, w, h, line }, images.rs parse_image_path; w/h null unless written)
//!   (when: when.rs predicates, each with its line; only on a step that has one;
//!   label: the step's name; along: true, or the label `along until` names; labelLine/alongLine: their lines;
//!   skipto: [{ to, when: predicate, line }], the step's `skipto <label> when <predicate>` lines in order)
//!   goal  = { line, verb, zone, note, ...positional/modifier fields }
//! `zone` on a goal is the zone spec in effect ({ name } | { map }, with line),
//! shared by every goal under the same header/step `zone` line.
//! Each goal also carries a hidden `spans` (UTF-16 offsets into its line,
//! [start, end)) for editors:
//!   { verb: [s, e], positional: [s, e] | null, coords: [s, e] | null,
//!     mods: [{ mod, start, end, text? }], note: [s, e] | null, comment: [s, e] | null }
//! `coords`: the goto/explore positional coordinates or the whole `@x,y`
//! modifier; `mods` names each modifier as MODS does (`text` on `only`: its
//! condition list as written); `note` runs from the ` -- ` dashes.

use crate::arr;
use crate::conditions::{faction, parse_conditions};
use crate::diag::Diagnostics;
use crate::images::{parse_image_path, parse_image_size};
use crate::js::{str_to_num, Obj, V};
use crate::lexer::{js_trim, js_trim_end, lex_units, Lex, Tok, RE_WS};
use crate::money::read_money;
use crate::obj;
use crate::re;
use crate::when::{is_label, parse_when};
use crate::xp::level_point;

/// ID_RE: slash-separated segments of a-z 0-9 _ -, none empty (an empty one would make a hidden `.lua` file).
pub fn is_id(s: &str) -> bool {
	!s.is_empty() && s.split('/').all(|seg| !seg.is_empty() && seg.bytes().all(|b| b.is_ascii_lowercase() || b.is_ascii_digit() || b == b'_' || b == b'-'))
}

fn is_int(s: &str) -> bool {
	!s.is_empty() && s.bytes().all(|b| b.is_ascii_digit())
}

/// NUM_RE: /^-?\d+(?:\.\d+)?$/
fn is_num(s: &str) -> bool {
	let s = s.strip_prefix('-').unwrap_or(s);
	match s.split_once('.') {
		Some((a, b)) => is_int(a) && is_int(b),
		None => is_int(s),
	}
}

pub const HEADER_KEYS: [&str; 20] =
	["guide", "title", "levels", "zone", "faction", "race", "class", "next", "category", "folder", "keywords", "collects", "reward", "why", "author", "version", "coords", "pitch", "pro", "con"];
/// Lines inside a step that are not goals.
/// `loop`: the step's `goto` points are the spawn areas of its kill, collect
/// and interact goals (resolve.rs, applyLoop).
/// `skipto <label> when <predicate>`: when the route reaches the step and the
/// predicate holds, it jumps to the labelled step (resolve.rs, checkLabels).
pub const STEP_KEYS: [&str; 9] = ["zone", "only", "tip", "image", "when", "label", "along", "skipto", "loop"];

// COMMON = text optional only group; COORDS = at map r frame (`frame` = the `era` / `live` modifiers).
/// The modifiers each verb takes, in the JS object's order (VERBS is the verbs in this order).
pub const MODS: [(&str, &[&str]); 32] = [
	("accept", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc", "object", "item", "lvl"]),
	// `reward`/`choose`/`xp`/`money`: what the turn-in pays, shown on the goal.
	// `direct`: handed in straight from the NPC's window, with no accept.
	("turnin", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc", "object", "reward", "choose", "xp", "money", "direct"]),
	("complete", &["text", "optional", "only", "group", "at", "map", "r", "frame"]),
	("abandon", &["text", "optional", "only"]),
	("destroy", &["text", "optional", "only"]),
	("kill", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc", "quest", "count"]),
	("collect", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc", "quest", "count", "nearest"]),
	("goto", &["text", "optional", "only", "group", "map", "r", "frame"]),
	("talk", &["text", "optional", "only", "group", "at", "map", "r", "frame", "gossip"]),
	("interact", &["text", "optional", "only", "group", "at", "map", "r", "frame", "quest"]),
	("use", &["text", "optional", "only", "group", "at", "map", "r", "frame", "quest"]),
	("sethome", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc"]),
	("hearth", &["text", "optional", "only", "group"]),
	// `die "<Graveyard>" @x,y`: die and take the Spirit Healer's resurrection there (a deathskip).
	("die", &["text", "optional", "only", "group", "at", "map", "r", "frame"]),
	("getfp", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc"]),
	("fly", &["text", "optional", "only", "group"]),
	// `enter "<Place>"`: be in that zone or area (the zone or subzone text); coordinates only point the arrow.
	("enter", &["text", "optional", "only", "group", "at", "map", "r", "frame"]),
	("train", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc", "gossip"]),
	("buy", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc", "count", "nearest"]),
	("vendor", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc", "gossip"]),
	("level", &["text", "optional", "only", "group"]),
	// `money <amount>`: hold that much; `task "<text>"`: done when the player ticks it.
	("money", &["text", "optional", "only"]),
	("task", &["optional", "only", "at", "map", "r", "frame"]),
	("note", &["optional", "only", "at", "map", "r", "frame"]),
	("skill", &["text", "optional", "only", "group", "at", "map", "r", "frame"]),
	("learn", &["text", "optional", "only", "group", "at", "map", "r", "frame", "npc", "item", "nearest"]),
	// `cast <spellId> ["Name"]`: the player casts that spell while the goal is open.
	("cast", &["text", "optional", "only", "group", "at", "map", "r", "frame"]),
	("craft", &["text", "optional", "only", "group", "at", "map", "r", "frame", "count", "until"]),
	("rep", &["text", "optional", "only", "group", "at", "map", "r", "frame"]),
	("explore", &["text", "optional", "only", "group", "map", "r", "frame"]),
	("achieve", &["text", "optional", "only", "group", "at", "map", "r", "frame", "criteria"]),
	// `wait <seconds> ["text"]`: done that long after the goals before it in the step are.
	("wait", &["text", "optional", "only"]),
];
/// Object.keys(MODS).
pub const VERBS: [&str; 32] = [
	"accept", "turnin", "complete", "abandon", "destroy", "kill", "collect", "goto", "talk", "interact", "use", "sethome", "hearth", "die", "getfp", "fly", "enter", "train", "buy", "vendor", "level",
	"money", "task", "note", "skill", "learn", "cast", "craft", "rep", "explore", "achieve", "wait",
];

/// `MODS[verb]` (own properties only).
pub fn mods(verb: &str) -> Option<&'static [&'static str]> {
	MODS.iter().find(|(v, _)| *v == verb).map(|(_, m)| *m)
}

fn mod_label(m: &str) -> &str {
	match m {
		"at" => "@x,y",
		"count" => "xN",
		"text" => "\"text\"",
		"until" => "until <N>",
		"criteria" => "criteria <n>",
		"frame" => "era`/`live",
		"xp" => "xp <N>",
		"money" => "money <amount>",
		"group" => "group [N]",
		_ => m,
	}
}
pub const MOD_WORDS: [&str; 21] =
	["map", "npc", "object", "item", "quest", "r", "lvl", "optional", "only", "until", "criteria", "era", "live", "nearest", "reward", "choose", "xp", "money", "group", "direct", "gossip"];
// A party or raid: 2 to 40 players.
const GROUP_MIN: f64 = 2.0;
const GROUP_MAX: f64 = 40.0;

/// Item qualities as the client numbers them (Enum.ItemQuality).
pub const QUALITIES: [&str; 8] = ["poor", "common", "uncommon", "rare", "epic", "legendary", "artifact", "heirloom"];
/// Profession ranks in trainer order (rank 1..4).
pub const RANKS: [&str; 4] = ["apprentice", "journeyman", "expert", "artisan"];
/// Reputation standings as the client numbers them (1 Hated .. 8 Exalted).
pub const STANDINGS: [(&str, f64); 8] = [("hated", 1.0), ("hostile", 2.0), ("unfriendly", 3.0), ("neutral", 4.0), ("friendly", 5.0), ("honored", 6.0), ("revered", 7.0), ("exalted", 8.0)];

struct Cx<'a> {
	file: &'a str,
	diag: &'a mut Diagnostics,
}

impl Cx<'_> {
	fn err(&mut self, ln: f64, msg: impl Into<String>, hint: Option<&str>) {
		self.diag.error(self.file, ln, msg, hint.map(str::to_string));
	}
	fn warn(&mut self, ln: f64, msg: impl Into<String>) {
		self.diag.warn(self.file, ln, msg, None);
	}
}

/// `line.slice(a, b)` over UTF-16 units.
fn sl(u: &[u16], a: usize, b: usize) -> String {
	let b = b.min(u.len());
	if a >= b {
		String::new()
	} else {
		String::from_utf16_lossy(&u[a..b])
	}
}

fn num_arr(a: usize, b: usize) -> V {
	arr![a as f64, b as f64]
}

fn quoted_at(toks: &[Tok], k: usize) -> bool {
	toks.get(k).is_some_and(|t| t.quoted)
}

fn tok_text(t: Option<&Tok>) -> &str {
	t.map(|t| t.text.as_str()).unwrap_or("")
}

/// `reward`/`choose` list from tokens[i]: `<itemId> ["Item name"] [quality]`
/// entries, one after another. -> (items [{ item, itemName?, quality? }], next) | error
fn read_reward_list(tokens: &[Tok], i: usize, word: &str) -> Result<(Vec<V>, usize), String> {
	let mut items: Vec<V> = Vec::new();
	let mut k = i;
	while k < tokens.len() && !tokens[k].quoted && is_int(&tokens[k].text) {
		let item = str_to_num(&tokens[k].text);
		let it = obj! { "item" => item };
		if item <= 0.0 {
			return Err(format!("malformed item id \"{}\" in `{word}`", tokens[k].text));
		}
		k += 1;
		if let Some(t) = tokens.get(k).filter(|t| t.quoted) {
			if t.text.is_empty() {
				return Err(format!("empty item name in `{word}`"));
			}
			it.set("itemName", t.text.as_str());
			k += 1;
		}
		if let Some(t) = tokens.get(k).filter(|t| !t.quoted) {
			let low = t.text.to_lowercase();
			if let Some(q) = QUALITIES.iter().position(|x| *x == low) {
				it.set("quality", q as f64);
				k += 1;
			}
		}
		if items.iter().any(|o| o.get("item").num() == item) {
			return Err(format!("`{word}` lists item {} twice", crate::js::num_str(item)));
		}
		items.push(V::Obj(it));
	}
	if items.is_empty() {
		return Err(format!("`{word}` needs item ids: {word} <itemId> [\"Item name\"] [quality] ..."));
	}
	Ok((items, k))
}

/// Tokens that start the modifier part of a goal line.
fn is_modifier_token(tok: Option<&Tok>) -> bool {
	let Some(tok) = tok.filter(|t| !t.quoted) else { return true };
	let w = tok.text.to_lowercase();
	MOD_WORDS.contains(&w.as_str()) || w.starts_with('@') || w.strip_prefix('x').is_some_and(is_int)
}

/// A standing token -> Some(Ok(value)) | Some(Err(error)) | None (not a standing at all).
fn read_standing(tok: Option<&Tok>) -> Option<Result<f64, String>> {
	let tok = tok.filter(|t| !t.quoted)?;
	let word = tok.text.to_lowercase();
	if let Some((_, v)) = STANDINGS.iter().find(|(k, _)| *k == word) {
		return Some(Ok(*v));
	}
	if !is_int(&tok.text) {
		return None;
	}
	let n = str_to_num(&tok.text);
	Some(if (1.0..=8.0).contains(&n) { Ok(n) } else { Err(format!("standing {} is out of range (1-8, or Hated..Exalted)", tok.text)) })
}

/// Unquoted words up to (not including) the first token `stop` accepts.
fn words_until(toks: &[Tok], mut i: usize, stop: impl Fn(&Tok) -> bool) -> (String, usize) {
	let mut words = Vec::new();
	while i < toks.len() && !toks[i].quoted && !stop(&toks[i]) {
		words.push(toks[i].text.as_str());
		i += 1;
	}
	(words.join(" "), i)
}

fn unquote_rest(line: &[u16], lex: &Lex, from: usize) -> String {
	let toks = lex.tokens.get(from..).unwrap_or(&[]);
	if toks.is_empty() {
		return String::new();
	}
	if toks.len() == 1 && toks[0].quoted {
		return toks[0].text.clone();
	}
	js_trim(&sl(line, toks[0].start, lex.end)).to_string()
}

/// `image <path> [<w>x<h>]`: the step's picture, at most one per step.
fn parse_image(step: &V, toks: &[Tok], ln: f64, cx: &mut Cx) {
	let usage = Some("image media/<name>.tga [<width>x<height>]");
	let image = step.get("image");
	if image.truthy() {
		return cx.err(ln, format!("duplicate `image` in step (first on line {}): a step shows one picture", image.get("line").to_js_string()), None);
	}
	let args = &toks[1..];
	if args.is_empty() {
		return cx.err(ln, "`image` needs the picture's path in the pack folder", usage);
	}
	if args.len() > 2 {
		return cx.err(ln, format!("unexpected \"{}\" after the picture's size", args[2].text), usage);
	}
	let p = match parse_image_path(&args[0].text) {
		Ok(p) => p,
		Err(e) => return cx.err(ln, e.error, Some(&e.hint)),
	};
	let mut size = None;
	if let Some(a) = args.get(1) {
		size = if a.quoted { None } else { parse_image_size(&a.text) };
		if size.is_none() {
			return cx.err(ln, format!("malformed picture size \"{}\"", a.text), Some("write it as <width>x<height> in pixels, such as 512x256"));
		}
	}
	step.set(
		"image",
		obj! {
			"path" => p.path.as_str(),
			"ext" => p.ext.as_deref().map(V::str).unwrap_or(V::Null),
			"w" => size.map(|s| V::Num(s.0)).unwrap_or(V::Null),
			"h" => size.map(|s| V::Num(s.1)).unwrap_or(V::Null),
			"line" => ln,
		},
	);
}

/// COORD_RE: /^(-?\d+(?:\.\d+)?),(-?\d+(?:\.\d+)?)$/
fn coord_match(text: &str) -> Option<(f64, f64)> {
	let (a, b) = text.split_once(',')?;
	if is_num(a) && is_num(b) {
		Some((str_to_num(a), str_to_num(b)))
	} else {
		None
	}
}

/// Read "x,y" starting at tokens[i] whose text (after an optional "@") is
/// `first`. Accepts "x,y", "x, y", "x ,y" and "x , y". -> (x, y, next) | error.
fn read_coords(tokens: &[Tok], i: usize, first: &str) -> Result<(f64, f64, usize), String> {
	let mut text = first.to_string();
	let mut k = i + 1;
	if text.is_empty() {
		if k >= tokens.len() || tokens[k].quoted {
			return Err("expected coordinates x,y".into());
		}
		text = tokens[k].text.clone();
		k += 1;
	}
	if coord_match(&text).is_none() {
		if text.strip_suffix(',').is_some_and(is_num) && k < tokens.len() && !tokens[k].quoted {
			text += &tokens[k].text;
			k += 1;
		} else if is_num(&text) && k < tokens.len() && !tokens[k].quoted && tokens[k].text.starts_with(',') {
			text += &tokens[k].text;
			k += 1;
			if text.ends_with(',') && k < tokens.len() && !tokens[k].quoted {
				text += &tokens[k].text;
				k += 1;
			}
		}
	}
	match coord_match(&text) {
		Some((x, y)) => Ok((x, y, k)),
		None => Err(format!("malformed coordinates \"{text}\" (expected x,y)")),
	}
}

fn indented(line: &[u16]) -> bool {
	line.first().is_some_and(|&c| c == b' ' as u16 || c == b'\t' as u16)
}

/// `(o.k ||= []).push(v)` for an array property.
fn push_to(o: &V, k: &str, v: impl Into<V>) {
	let a = o.get(k);
	if a.truthy() {
		a.push(v);
	} else {
		o.set(k, arr![v.into()]);
	}
}

/// `(o.k ||= {})`.
fn obj_at(o: &V, k: &str) -> V {
	let x = o.get(k);
	if x.truthy() {
		x
	} else {
		let n = V::obj();
		o.set(k, n.clone());
		n
	}
}

fn with_line(v: &V, ln: f64) -> V {
	let o = v.as_obj().map(Obj::spread).unwrap_or_default();
	o.set("line", ln);
	V::Obj(o)
}

/// `s.replace(/\s*,\s*/g, ',')`.
fn tighten_commas(s: &str) -> String {
	re!(r"{RE_WS}*,{RE_WS}*").replace_all(s, ",").into_owned()
}

/// The guide's syntax tree, or Null when it has no `guide` line.
pub fn parse_guide(text: &str, file: &str, diag: &mut Diagnostics) -> V {
	let text = text.strip_prefix('\u{FEFF}').unwrap_or(text);
	let lines: Vec<&str> = text.split('\n').map(|l| l.strip_suffix('\r').unwrap_or(l)).collect();
	let guide = V::Obj(obj! { "file" => file, "id" => V::Null, "line" => 0.0, "header" => V::obj(), "lines" => V::obj(), "steps" => V::arr() });
	let mut zone = V::Null; // zone spec in effect
	let mut step = V::Null;
	let mut saw_content = false;
	let mut cx = Cx { file, diag };

	for (idx, line_s) in lines.iter().enumerate() {
		let ln = (idx + 1) as f64;
		let line: Vec<u16> = line_s.encode_utf16().collect();
		let lex = lex_units(&line);
		if let Some(e) = &lex.error {
			cx.err(ln, e.clone(), None);
			continue;
		}
		let toks = &lex.tokens;
		// An empty name, title, label or note would make the engine reject the whole guide.
		if toks.iter().any(|t| t.quoted && js_trim(&t.text).is_empty()) {
			cx.err(ln, "empty quoted string (names, titles, labels and notes need text)", None);
			// A `step ""` line still opens its step so the lines under it stay attached.
			let opens_step = !indented(&line) && !toks[0].quoted && toks[0].text.to_lowercase() == "step";
			if !opens_step {
				continue;
			}
		}
		if toks.is_empty() {
			if lex.note.is_some() {
				cx.err(ln, "a ` -- ` note must follow a goal on the same line", None);
			}
			continue;
		}
		let ind = indented(&line);
		let kw: Option<String> = if toks[0].quoted { None } else { Some(toks[0].text.to_lowercase()) };
		let kw_s = kw.as_deref().unwrap_or("");

		if !saw_content {
			saw_content = true;
			// Report once; the rest of the file still parses so later errors show too.
			if ind || kw_s != "guide" || kw.is_none() {
				cx.err(ln, "a guide must start with `guide <id>` in column 0", None);
			}
		}

		if !ind {
			// Report, then keep the line's content so one mistake yields one error.
			if lex.note.is_some() {
				cx.err(ln, "notes (` -- `) are only allowed on goal lines", None);
			}
			if kw.is_some() && kw_s == "step" {
				let title = unquote_rest(&line, &lex, 1);
				step = V::Obj(obj! { "line" => ln, "title" => if title.is_empty() { V::Null } else { V::str(&title) }, "only" => V::Null, "tip" => V::Null, "goals" => V::arr() });
				guide.get("steps").push(step.clone());
				continue;
			}
			if step.truthy() {
				cx.err(ln, format!("unexpected `{}` in column 0 after the first step (indent step lines; header keys belong before the first step)", toks[0].text), None);
				continue;
			}
			if kw.is_none() || !HEADER_KEYS.contains(&kw_s) {
				cx.err(ln, format!("unknown header key \"{}\"", toks[0].text), Some(&format!("header keys: {}", HEADER_KEYS.join(", "))));
				continue;
			}
			let repeatable = matches!(kw_s, "pro" | "con" | "reward" | "next");
			let lines_o = guide.get("lines");
			if lines_o.get(kw_s).truthy() && !repeatable {
				cx.err(ln, format!("duplicate header key `{kw_s}` (first on line {})", lines_o.get(kw_s).to_js_string()), None);
				continue;
			}
			if !lines_o.get(kw_s).truthy() {
				lines_o.set(kw_s, ln);
			}
			parse_header(&guide, kw_s, &line, &lex, ln, &mut cx);
			if kw_s == "zone" && guide.get("header").get("zone").truthy() {
				zone = guide.get("header").get("zone");
			}
			continue;
		}

		// Indented line.
		if !step.truthy() {
			cx.err(ln, "indented line before the first `step`", None);
			continue;
		}
		if kw.is_some() && STEP_KEYS.contains(&kw_s) {
			if lex.note.is_some() {
				cx.err(ln, "notes (` -- `) are only allowed on goal lines", None);
			}
			let rest_from = |k: usize| toks.get(k).map(|t| t.start).unwrap_or(lex.end);
			match kw_s {
				"zone" => {
					if let Some(spec) = parse_zone_spec(&line, &lex, ln, &mut cx) {
						// the step's last `zone` line (resolve.rs: who is in which zone)
						step.set("zone", spec.clone());
						zone = spec;
					}
				}
				"only" => {
					if step.get("only").truthy() {
						cx.err(ln, "duplicate `only` in step", None);
						continue;
					}
					let rest = js_trim(&sl(&line, rest_from(1), lex.end)).to_string();
					if rest.is_empty() {
						cx.err(ln, "`only` needs a condition list", None);
						continue;
					}
					let c = parse_conditions(&tighten_commas(&rest), "any");
					for e in &c.errors {
						cx.err(ln, e.clone(), None);
					}
					for w in &c.warnings {
						cx.warn(ln, w.clone());
					}
					if c.errors.is_empty() {
						step.set("only", c.value);
					}
				}
				"when" => match parse_when(&sl(&line, rest_from(1), lex.end)) {
					Err(e) => cx.err(ln, e.error, e.hint.as_deref()),
					Ok(v) => push_to(&step, "when", with_line(&v, ln)),
				},
				"label" => {
					if step.get("label").truthy() {
						cx.err(ln, "duplicate `label` in step", None);
						continue;
					}
					if toks.len() != 2 || toks[1].quoted {
						cx.err(ln, "`label` needs a name: label <name>", None);
						continue;
					}
					if !is_label(&toks[1].text) {
						cx.err(ln, format!("malformed label \"{}\" (letters, digits, - and _)", toks[1].text), None);
						continue;
					}
					step.set("label", toks[1].text.as_str());
					step.set("labelLine", ln);
				}
				"along" => {
					if !step.get("along").is_undef() {
						cx.err(ln, "duplicate `along` in step", None);
						continue;
					}
					if toks.len() == 1 {
						step.set("along", true);
					} else if toks.len() == 3 && !toks[1].quoted && toks[1].text.to_lowercase() == "until" && !toks[2].quoted && is_label(&toks[2].text) {
						step.set("along", toks[2].text.as_str());
					} else {
						cx.err(ln, "`along` takes nothing or `until <label>`", None);
						continue;
					}
					step.set("alongLine", ln);
				}
				"skipto" => {
					let usage = "`skipto` needs a label and a predicate: skipto <label> when <predicate>";
					if toks.len() < 4 || toks[1].quoted || toks[2].quoted || toks[2].text.to_lowercase() != "when" {
						cx.err(ln, usage, None);
						continue;
					}
					if !is_label(&toks[1].text) {
						cx.err(ln, format!("malformed label \"{}\" (letters, digits, - and _)", toks[1].text), None);
						continue;
					}
					match parse_when(&sl(&line, toks[3].start, lex.end)) {
						Err(e) => cx.err(ln, format!("`skipto`: {}", e.error), e.hint.as_deref()),
						Ok(v) if v.get("k").as_str() == Some("group") => {
							cx.err(ln, "`skipto` cannot wait for an answer: `group` asks the player at a step", Some("put `when group <quest>` on the steps of that quest instead"))
						}
						Ok(v) => push_to(&step, "skipto", obj! { "to" => toks[1].text.as_str(), "when" => with_line(&v, ln), "line" => ln }),
					}
				}
				"image" => parse_image(&step, toks, ln, &mut cx),
				"loop" => {
					if toks.len() > 1 {
						cx.err(ln, "`loop` takes nothing", None);
					} else if step.get("loop").truthy() {
						cx.err(ln, "duplicate `loop` in step", None);
					} else {
						step.set("loop", ln);
					}
				}
				_ => {
					let tip = unquote_rest(&line, &lex, 1);
					if tip.is_empty() {
						cx.err(ln, "`tip` needs text", None);
						continue;
					}
					let old = step.get("tip");
					step.set("tip", if old.truthy() { format!("{}\n{tip}", old.to_js_string()) } else { tip });
				}
			}
			continue;
		}
		if kw.is_none() || mods(kw_s).is_none() {
			let msg = if toks[0].quoted { "expected a verb, found a string".to_string() } else { format!("unknown verb \"{}\"", toks[0].text) };
			cx.err(ln, msg, Some(&format!("verbs: {}", VERBS.join(", "))));
			continue;
		}
		if let Some(goal) = parse_goal(kw_s, &line, &lex, ln, &mut cx) {
			goal.set("zone", zone.clone());
			step.get("goals").push(goal);
		}
	}

	let lines_o = guide.get("lines");
	if !lines_o.get("guide").truthy() {
		if !saw_content {
			cx.err(1.0, "empty guide file (expected `guide <id>`)", None);
		}
		return V::Null;
	}
	let gline = guide.get("line").num();
	for key in ["title", "levels", "zone"] {
		if !lines_o.get(key).truthy() {
			cx.err(gline, format!("missing required header `{key}`"), None);
		}
	}
	let steps = guide.get("steps").items();
	if steps.is_empty() {
		cx.err(gline, "guide has no steps", None);
	}
	for s in &steps {
		if s.get("goals").items().is_empty() {
			cx.err(s.get("line").num(), "step has no goals", None);
		}
	}
	guide
}

fn parse_zone_spec(line: &[u16], lex: &Lex, ln: f64, cx: &mut Cx) -> Option<V> {
	let toks = &lex.tokens;
	if toks.len() < 2 {
		cx.err(ln, "`zone` needs a zone name or `map <uiMapID>`", None);
		return None;
	}
	if !toks[1].quoted && toks[1].text.to_lowercase() == "map" {
		if toks.len() != 3 || toks[2].quoted || !is_int(&toks[2].text) || str_to_num(&toks[2].text) <= 0.0 {
			cx.err(ln, "malformed `zone map <uiMapID>`", None);
			return None;
		}
		return Some(V::Obj(obj! { "map" => str_to_num(&toks[2].text), "line" => ln }));
	}
	Some(V::Obj(obj! { "name" => unquote_rest(line, lex, 1), "line" => ln }))
}

fn parse_header(guide: &V, kw: &str, line: &[u16], lex: &Lex, ln: f64, cx: &mut Cx) {
	let toks = &lex.tokens;
	let h = guide.get("header");
	let rest = unquote_rest(line, lex, 1);
	if kw != "zone" && rest.is_empty() {
		cx.err(ln, format!("`{kw}` needs a value"), None);
		return;
	}
	match kw {
		"guide" => {
			guide.set("line", ln);
			if toks.len() != 2 || toks[1].quoted || !is_id(&toks[1].text) {
				cx.err(ln, format!("malformed guide id \"{rest}\" (allowed: a-z 0-9 _ - in segments separated by single /)"), None);
				guide.set("id", if rest.is_empty() { V::Null } else { V::str(&rest) });
				return;
			}
			guide.set("id", toks[1].text.as_str());
		}
		"title" | "category" | "author" | "pitch" | "why" | "folder" => h.set(kw, rest.as_str()),
		"keywords" => {
			// `keywords a, b, c`: extra search words for the guide menu.
			let words: Vec<&str> = rest.split(',').map(js_trim).collect();
			if words.iter().any(|w| w.is_empty()) {
				cx.err(ln, "`keywords` has an empty entry (expected a comma list of words)", None);
				return;
			}
			let lower: Vec<String> = words.iter().map(|w| w.to_lowercase()).collect();
			let mut seen: Vec<&str> = Vec::new();
			for (w, l) in words.iter().zip(&lower) {
				if seen.contains(&l.as_str()) {
					cx.warn(ln, format!("`keywords` lists \"{w}\" twice"));
				}
				seen.push(l);
			}
			let kept: Vec<V> = words.iter().enumerate().filter(|(i, _)| lower.iter().position(|o| *o == lower[*i]) == Some(*i)).map(|(_, w)| V::str(w)).collect();
			h.set("keywords", kept);
		}
		"collects" => {
			// `collects 2414, 5655`: the items this guide obtains (Lookup opens it for them).
			let ids: Vec<&str> = rest.split(',').map(js_trim).collect();
			if let Some(bad) = ids.iter().find(|id| !is_int(id) || str_to_num(id) <= 0.0) {
				cx.err(ln, format!("malformed item id \"{bad}\" in `collects` (expected a comma list of item ids)"), None);
				return;
			}
			let nums: Vec<f64> = ids.iter().map(|s| str_to_num(s)).collect();
			let mut uniq: Vec<f64> = Vec::new();
			for n in &nums {
				if !uniq.contains(n) {
					uniq.push(*n);
				}
			}
			if uniq.len() != nums.len() {
				cx.err(ln, "`collects` names the same item twice", None);
				return;
			}
			h.set("collects", nums.into_iter().map(V::Num).collect::<Vec<V>>());
		}
		"reward" => {
			// What the guide's goal gives, for the guide menu: `reward item <id>
			// ["Name"] [quality] ...` (several items on one line: a choice of
			// one), `reward spell <id> ["Name"]` or `reward text <words>`.
			let kind = if toks[1].quoted { String::new() } else { toks[1].text.to_lowercase() };
			let entries: Vec<V> = match kind.as_str() {
				"item" => {
					let (items, next) = match read_reward_list(toks, 2, "reward item") {
						Ok(r) => r,
						Err(e) => return cx.err(ln, e, None),
					};
					if next < toks.len() {
						return cx.err(ln, format!("unexpected \"{}\" in `reward item` (expected <itemId> [\"Item name\"] [quality] ...)", toks[next].text), None);
					}
					let choice = items.len() > 1;
					items
						.into_iter()
						.map(|it| {
							if choice {
								let o = it.as_obj().unwrap().spread();
								o.set("choice", true);
								V::Obj(o)
							} else {
								it
							}
						})
						.collect()
				}
				"spell" => {
					let id = toks.get(2);
					let bad = match id {
						None => true,
						Some(id) => id.quoted || !is_int(&id.text) || str_to_num(&id.text) <= 0.0 || toks.len() > 4 || toks.get(3).is_some_and(|t| !t.quoted),
					};
					if bad {
						return cx.err(ln, "malformed `reward spell` (expected reward spell <spellId> [\"Spell name\"])", None);
					}
					let name = toks.get(3).map(|t| V::str(&t.text)).unwrap_or(V::Undef);
					vec![V::Obj(obj! { "spell" => str_to_num(&id.unwrap().text), "spellName" => name })]
				}
				"text" => {
					let text = unquote_rest(line, lex, 2);
					if text.is_empty() {
						return cx.err(ln, "`reward text` needs words", None);
					}
					vec![V::Obj(obj! { "text" => text })]
				}
				_ => return cx.err(ln, format!("unknown reward kind \"{}\" (expected `reward item`, `reward spell` or `reward text`)", toks[1].text), None),
			};
			if !h.get("reward").truthy() {
				h.set("reward", V::arr());
			}
			let list = h.get("reward");
			for e in &entries {
				list.push(with_line(e, ln));
			}
			push_to(&guide.get("lines"), "rewards", ln);
		}
		"pro" | "con" => {
			let key = if kw == "pro" { "pros" } else { "cons" };
			push_to(&h, key, rest.as_str());
			push_to(&guide.get("lines"), key, ln);
		}
		"levels" => {
			let m = re!(r"^([0-9]+){RE_WS}*-{RE_WS}*([0-9]+)$").captures(&rest);
			let ok = m.as_ref().filter(|m| {
				let a = str_to_num(&m[1]);
				!(a < 1.0 || a > str_to_num(&m[2]))
			});
			let Some(m) = ok else {
				cx.err(ln, format!("malformed levels \"{rest}\" (expected <min>-<max>, min ≤ max)"), None);
				return;
			};
			h.set("levels", obj! { "min" => str_to_num(&m[1]), "max" => str_to_num(&m[2]) });
		}
		"zone" => {
			if let Some(spec) = parse_zone_spec(line, lex, ln, cx) {
				h.set("zone", spec);
			}
		}
		"faction" => {
			let Some(f) = faction(&rest.to_lowercase()) else {
				cx.err(ln, format!("faction must be Alliance or Horde, not \"{rest}\""), None);
				return;
			};
			h.set("faction", f);
		}
		"race" | "class" => {
			let c = parse_conditions(&tighten_commas(&rest), kw);
			for e in &c.errors {
				cx.err(ln, e.clone(), None);
			}
			for w in &c.warnings {
				cx.warn(ln, w.clone());
			}
			if c.errors.is_empty() {
				if kw == "race" {
					h.set("races", c.value.get("races"));
				} else {
					h.set("classes", c.value.get("classes"));
				}
			}
		}
		"next" => {
			// `next <id>[, <id>...]`: the guides to continue with, in order, the
			// first being the author's default; more than one is a choice of
			// route. `next <id> when <predicate>` (when.rs) offers that one guide
			// only while the predicate holds at the hand-off. The line repeats,
			// each adding its guides; a guide is named once.
			let w = toks.iter().enumerate().position(|(k, t)| k >= 2 && !t.quoted && t.text.to_lowercase() == "when");
			let id_toks = &toks[1..w.unwrap_or(toks.len())];
			let id_text = match w {
				None => rest.clone(),
				Some(_) => sl(line, id_toks[0].start, id_toks[id_toks.len() - 1].end),
			};
			let ids: Vec<&str> = re!(r"(?:{RE_WS}|,)+").split(&id_text).filter(|s| !s.is_empty()).collect();
			let bad: Option<String> = if id_toks.iter().any(|t| t.quoted) { Some(id_text.clone()) } else { ids.iter().find(|id| !is_id(id)).map(|s| s.to_string()) };
			if bad.is_some() || ids.is_empty() {
				cx.err(ln, format!("malformed guide id \"{}\" in `next`", bad.as_deref().unwrap_or(&id_text)), None);
				return;
			}
			let mut when = V::Null;
			if let Some(w) = w {
				if ids.len() != 1 {
					cx.err(ln, "`next ... when` names one guide: `next <id> when <predicate>`, one line per guide", None);
					return;
				}
				let src = toks.get(w + 1).map(|t| sl(line, t.start, lex.end)).unwrap_or_default();
				match parse_when(&src) {
					Err(e) => {
						cx.err(ln, e.error, e.hint.as_deref());
						return;
					}
					Ok(p) => when = with_line(&p, ln),
				}
			}
			let mut all: Vec<String> = h.get("next").items().iter().map(|x| x.to_js_string()).collect();
			all.extend(ids.iter().map(|s| s.to_string()));
			let mut uniq: Vec<&str> = Vec::new();
			for a in &all {
				if !uniq.contains(&a.as_str()) {
					uniq.push(a);
				}
			}
			if uniq.len() != all.len() {
				cx.err(ln, "`next` names the same guide twice", None);
				return;
			}
			h.set("next", all.iter().map(|s| V::str(s)).collect::<Vec<V>>());
			let next_of = obj_at(&guide.get("lines"), "nextOf");
			for id in &ids {
				next_of.set(id, ln);
			}
			if when.truthy() {
				obj_at(&h, "nextWhen").set(ids[0], when);
			}
		}
		"version" => {
			if !is_int(&rest) {
				cx.err(ln, format!("version must be an integer, not \"{rest}\""), None);
				return;
			}
			h.set("version", str_to_num(&rest));
		}
		"coords" => {
			let c = rest.to_lowercase();
			if c != "era" && c != "live" {
				cx.err(ln, format!("coords must be era or live, not \"{rest}\""), None);
				return;
			}
			h.set("coords", c);
		}
		_ => {}
	}
}

fn parse_id(tok: Option<&Tok>, what: &str, ln: f64, cx: &mut Cx) -> Option<f64> {
	match tok {
		Some(t) if !t.quoted && is_int(&t.text) && str_to_num(&t.text) > 0.0 => Some(str_to_num(&t.text)),
		_ => {
			cx.err(ln, format!("malformed {what} id \"{}\"", tok_text(tok)), None);
			None
		}
	}
}

/// Positional arguments per verb. Returns the index of the first modifier
/// token, or None after reporting an error.
fn parse_positional(verb: &str, goal: &V, toks: &[Tok], line: &[u16], lex: &Lex, ln: f64, cx: &mut Cx, spans: &V) -> Option<usize> {
	let mut i = 1;
	let t = toks.get(i);
	macro_rules! fail {
		($msg:expr) => {{
			cx.err(ln, $msg, None);
			return None;
		}};
	}
	match verb {
		"accept" | "turnin" | "complete" | "abandon" => {
			if t.is_none() {
				fail!(format!("`{verb}` needs a quest id"));
			}
			goal.set("quest", parse_id(t, "quest", ln, cx)?);
			i += 1;
			if quoted_at(toks, i) {
				goal.set("title", toks[i].text.as_str());
				i += 1;
			}
			Some(i)
		}
		"kill" => {
			let Some(tt) = t else { fail!("`kill` needs an npc id or \"Target name\"") };
			if tt.quoted {
				goal.set("target", tt.text.as_str());
				return Some(i + 1);
			}
			goal.set("npc", parse_id(t, "npc", ln, cx)?);
			i += 1;
			if quoted_at(toks, i) {
				goal.set("target", toks[i].text.as_str());
				i += 1;
			}
			Some(i)
		}
		"collect" | "use" | "destroy" | "buy" => {
			if t.is_none() {
				fail!(format!("`{verb}` needs an item id"));
			}
			goal.set("item", parse_id(t, "item", ln, cx)?);
			i += 1;
			if quoted_at(toks, i) {
				goal.set("itemName", toks[i].text.as_str());
				i += 1;
			}
			Some(i)
		}
		"talk" => {
			if t.is_none() {
				fail!("`talk` needs an npc id");
			}
			goal.set("npc", parse_id(t, "npc", ln, cx)?);
			i += 1;
			if quoted_at(toks, i) {
				goal.set("npcName", toks[i].text.as_str());
				i += 1;
			}
			Some(i)
		}
		"interact" => {
			if t.is_none() {
				fail!("`interact` needs an object id");
			}
			goal.set("object", parse_id(t, "object", ln, cx)?);
			i += 1;
			if quoted_at(toks, i) {
				goal.set("objName", toks[i].text.as_str());
				i += 1;
			}
			Some(i)
		}
		"train" | "vendor" => {
			let unq = t.filter(|t| !t.quoted);
			if unq.is_some_and(|t| is_int(&t.text)) {
				goal.set("npc", parse_id(t, "npc", ln, cx)?);
				i += 1;
				if quoted_at(toks, i) {
					goal.set("npcName", toks[i].text.as_str());
					i += 1;
				}
				return Some(i);
			}
			if verb == "vendor" {
				if unq.is_some_and(|t| t.text.to_lowercase() == "nearest") {
					goal.set("nearest", true);
					return Some(i + 1);
				}
				return Some(i);
			}
			if unq.is_some_and(|t| t.text.to_lowercase() == "class") {
				goal.set("classTrain", true);
				return Some(i + 1);
			}
			// `train <Profession> [Rank]`: words up to the first modifier.
			let mut words: Vec<&str> = Vec::new();
			while i < toks.len() && !is_modifier_token(toks.get(i)) {
				words.push(&toks[i].text);
				i += 1;
			}
			if !words.is_empty() {
				let last = words[words.len() - 1].to_lowercase();
				if words.len() > 1 {
					if let Some(r) = RANKS.iter().position(|x| *x == last) {
						goal.set("rank", (r + 1) as f64);
						words.pop();
					}
				}
				goal.set("profession", words.join(" "));
			}
			Some(i)
		}
		"goto" | "explore" => {
			let Some(tt) = t.filter(|t| !t.quoted) else { fail!(format!("`{verb}` needs coordinates x,y")) };
			let (x, y, next) = match read_coords(toks, i, &tt.text) {
				Ok(c) => c,
				Err(e) => fail!(e),
			};
			goal.set("x", x);
			goal.set("y", y);
			goal.set("explicitCoords", true);
			i = next;
			spans.set("coords", num_arr(toks[1].start, toks[i - 1].end));
			if quoted_at(toks, i) {
				goal.set("text", toks[i].text.as_str());
				i += 1;
			}
			Some(i)
		}
		"sethome" | "hearth" | "die" | "getfp" | "fly" | "enter" => {
			let Some(tt) = t else { fail!(format!("`{verb}` needs a \"Location\"{}", if verb == "sethome" { " or `nearest`" } else { "" })) };
			if verb == "sethome" && !tt.quoted && tt.text.to_lowercase() == "nearest" {
				goal.set("nearest", true);
				return Some(i + 1);
			}
			goal.set("location", tt.text.as_str());
			if tt.text.is_empty() {
				fail!(format!("`{verb}` needs a non-empty location"));
			}
			Some(i + 1)
		}
		"level" => {
			// `level 12`, `level 12.5` (halfway through 12) or `level 12+2500`
			// (2500 XP into 12): level, frac and the XP as written (levelXp).
			let p = t.filter(|t| !t.quoted).map(|t| level_point(&t.text));
			let p = match p {
				Some(Err(e)) => fail!(e),
				Some(Ok(p)) if p.level >= 1.0 => p,
				_ => fail!(format!("malformed level \"{}\"", tok_text(t))),
			};
			goal.set("level", p.level);
			if let Some(f) = p.frac {
				goal.set("frac", f);
			}
			if let Some(x) = p.xp {
				goal.set("levelXp", x);
			}
			Some(i + 1)
		}
		"wait" => {
			// Whole seconds, at most an hour.
			match t.filter(|t| !t.quoted && is_int(&t.text)).map(|t| str_to_num(&t.text)) {
				Some(v) if v > 0.0 && v <= 3600.0 => {
					goal.set("seconds", v);
					Some(i + 1)
				}
				_ => {
					cx.err(ln, format!("malformed seconds \"{}\" (1 to 3600)", tok_text(t)), Some("`wait` needs seconds: wait <seconds> [\"what for\"]"));
					None
				}
			}
		}
		"money" => {
			let v = t.filter(|t| !t.quoted).and_then(|t| read_money(&t.text));
			match v {
				Some(v) if v > 0.0 => {
					goal.set("money", v);
					Some(i + 1)
				}
				_ => {
					cx.err(ln, format!("malformed amount \"{}\" (expected copper or 1g50s / 7s / 25c)", tok_text(t)), Some("`money` needs an amount: money <amount>"));
					None
				}
			}
		}
		"task" | "note" => {
			let Some(tt) = t else { fail!(if verb == "task" { "`task` needs text: task \"<what to do>\"" } else { "`note` needs text" }) };
			if tt.quoted {
				goal.set("text", tt.text.as_str());
				return Some(i + 1);
			}
			goal.set("text", js_trim(&sl(line, tt.start, lex.end)));
			Some(toks.len())
		}
		"skill" => {
			let usage = "`skill` needs a profession and a rank: skill <Profession> <N>";
			let Some(tt) = t else { fail!(usage) };
			if tt.quoted {
				goal.set("skill", tt.text.as_str());
				goal.set("skillQuoted", true);
				i += 1;
			} else {
				let (text, next) = words_until(toks, i, |tk| is_int(&tk.text));
				goal.set("skill", text);
				i = next;
			}
			let skill = goal.get("skill").truthy();
			let n = toks.get(i);
			match n {
				Some(n) if skill && !n.quoted && is_int(&n.text) && str_to_num(&n.text) >= 1.0 => {
					goal.set("level", str_to_num(&n.text));
					Some(i + 1)
				}
				_ => {
					let rank_like = skill && n.is_some_and(|n| !n.quoted && n.text.as_bytes().first().is_some_and(u8::is_ascii_digit));
					fail!(if rank_like { format!("malformed skill rank \"{}\"", n.unwrap().text) } else { usage.to_string() })
				}
			}
		}
		"learn" | "craft" | "cast" => {
			if t.is_none() {
				fail!(format!("`{verb}` needs a spell id"));
			}
			goal.set("spell", parse_id(t, "spell", ln, cx)?);
			i += 1;
			if quoted_at(toks, i) {
				goal.set("spellName", toks[i].text.as_str());
				i += 1;
			}
			Some(i)
		}
		"rep" => {
			let usage = "`rep` needs a faction and a standing: rep <Faction> <Standing> or rep <factionId> <Standing>";
			let Some(tt) = t else { fail!(usage) };
			if !tt.quoted && is_int(&tt.text) {
				goal.set("factionId", parse_id(t, "faction", ln, cx)?);
				i += 1;
				if quoted_at(toks, i) {
					goal.set("factionName", toks[i].text.as_str());
					i += 1;
				}
			} else if tt.quoted {
				goal.set("factionName", tt.text.as_str());
				goal.set("factionQuoted", true);
				i += 1;
			} else {
				let (text, next) = words_until(toks, i, |tk| read_standing(Some(tk)).is_some());
				goal.set("factionName", text);
				i = next;
			}
			if goal.get("factionId").is_undef() && !goal.get("factionName").truthy() {
				fail!(usage);
			}
			match read_standing(toks.get(i)) {
				None => fail!(match toks.get(i) {
					Some(tk) => format!("unknown standing \"{}\" (Hated, Hostile, Unfriendly, Neutral, Friendly, Honored, Revered, Exalted, or 1-8)", tk.text),
					None => usage.to_string(),
				}),
				Some(Err(e)) => fail!(e),
				Some(Ok(v)) => {
					goal.set("standing", v);
					Some(i + 1)
				}
			}
		}
		"achieve" => {
			if t.is_none() {
				fail!("`achieve` needs an achievement id");
			}
			goal.set("achievement", parse_id(t, "achievement", ln, cx)?);
			i += 1;
			if quoted_at(toks, i) {
				goal.set("achievementName", toks[i].text.as_str());
				i += 1;
			}
			Some(i)
		}
		_ => Some(i),
	}
}

fn parse_goal(verb: &str, line: &[u16], lex: &Lex, ln: f64, cx: &mut Cx) -> Option<V> {
	let toks = &lex.tokens;
	let goal = V::Obj(obj! { "line" => ln, "verb" => verb });
	let content_end = js_trim_end(&String::from_utf16_lossy(line)).encode_utf16().count();
	let tail = if lex.end < content_end { num_arr(lex.end, content_end) } else { V::Null };
	let spans = V::Obj(obj! {
		"verb" => num_arr(toks[0].start, toks[0].end),
		"positional" => V::Null,
		"coords" => V::Null,
		"mods" => V::arr(),
		"note" => if lex.note.is_some() { tail.clone() } else { V::Null },
		"comment" => if lex.note.is_none() { tail } else { V::Null },
	});
	if let Some(note) = &lex.note {
		if note.is_empty() {
			cx.err(ln, "empty ` -- ` note", None);
			return None;
		}
		goal.set("note", note.as_str());
	}
	let mut i = parse_positional(verb, &goal, toks, line, lex, ln, cx, &spans)?;
	if i > 1 {
		spans.set("positional", num_arr(toks[1].start, toks[i - 1].end));
	}
	// The modifier being read (named by `use`) and its first token.
	let mut cur: Option<&'static str> = None;
	let mut cur_start = i;
	let flush = |cur: &mut Option<&'static str>, cur_start: usize, i: usize| {
		let Some(m) = cur.take() else { return };
		let start = toks[cur_start].start;
		let end = toks[i - 1].end;
		let span = obj! { "mod" => m, "start" => start as f64, "end" => end as f64 };
		if m == "only" {
			span.set("text", sl(line, toks[cur_start + 1].start, end));
		}
		if m == "at" {
			spans.set("coords", num_arr(start, end));
		}
		spans.get("mods").push(span);
	};
	let allowed = mods(verb).unwrap();
	let mut seen: Vec<&'static str> = Vec::new();
	// `use(mod)`: false after reporting.
	let mut use_mod = |m: &'static str, cur: &mut Option<&'static str>, cx: &mut Cx| -> bool {
		if !allowed.contains(&m) {
			cx.err(ln, format!("`{}` does not apply to `{verb}`", mod_label(m)), None);
			return false;
		}
		if seen.contains(&m) {
			cx.err(ln, format!("duplicate `{}`", mod_label(m)), None);
			return false;
		}
		seen.push(m);
		*cur = Some(m);
		true
	};
	let int_arg = |k: usize, what: &str, cx: &mut Cx| -> Option<f64> {
		match toks.get(k) {
			Some(t) if !t.quoted && is_int(&t.text) && str_to_num(&t.text) > 0.0 => Some(str_to_num(&t.text)),
			tok => {
				cx.err(ln, format!("malformed {what} \"{}\"", tok_text(tok)), None);
				None
			}
		}
	};
	macro_rules! use_ {
		($m:expr) => {
			if !use_mod($m, &mut cur, cx) {
				return None;
			}
		};
	}
	macro_rules! fail {
		($msg:expr) => {{
			cx.err(ln, $msg, None);
			return None;
		}};
	}
	while i < toks.len() {
		flush(&mut cur, cur_start, i);
		cur_start = i;
		let tok = &toks[i];
		if tok.quoted {
			use_!("text");
			if !goal.get("text").is_undef() {
				fail!("duplicate `\"text\"`");
			}
			goal.set("text", tok.text.as_str());
			i += 1;
			continue;
		}
		let word = tok.text.to_lowercase();
		if word.starts_with('@') {
			use_!("at");
			let (x, y, next) = match read_coords(toks, i, &tok.text[1..]) {
				Ok(c) => c,
				Err(e) => fail!(e),
			};
			goal.set("x", x);
			goal.set("y", y);
			goal.set("explicitCoords", true);
			i = next;
			continue;
		}
		if let Some(cm) = word.strip_prefix('x').filter(|d| is_int(d)) {
			use_!("count");
			if str_to_num(cm) <= 0.0 {
				fail!(format!("malformed count \"{}\"", tok.text));
			}
			goal.set("count", str_to_num(cm));
			i += 1;
			continue;
		}
		match word.as_str() {
			"map" => {
				use_!("map");
				let v = int_arg(i + 1, "map id", cx)?;
				goal.set("coordMap", v);
				i += 2;
				continue;
			}
			"npc" | "object" | "item" => {
				let w: &'static str = match word.as_str() {
					"npc" => "npc",
					"object" => "object",
					_ => "item",
				};
				use_!(w);
				if !goal.get(w).is_undef() {
					fail!(format!("`{w}` already given positionally"));
				}
				let v = int_arg(i + 1, &format!("{w} id"), cx)?;
				goal.set(w, v);
				goal.set(&format!("{w}Explicit"), true);
				i += 2;
				continue;
			}
			"quest" => {
				use_!("quest");
				let q = toks.get(i + 1);
				// /^(\d+)(?:\.(\d+))?$/
				let m = q.filter(|q| !q.quoted).and_then(|q| match q.text.split_once('.') {
					Some((a, b)) if is_int(a) && is_int(b) => Some((str_to_num(a), Some(str_to_num(b)))),
					None if is_int(&q.text) => Some((str_to_num(&q.text), None)),
					_ => None,
				});
				let Some((id, oi)) = m.filter(|(a, b)| !(*a <= 0.0 || b.is_some_and(|b| b <= 0.0))) else {
					fail!(format!("malformed quest link \"{}\" (expected <id> or <id>.<objective>)", tok_text(q)));
				};
				goal.set("quest", id);
				if let Some(oi) = oi {
					goal.set("oi", oi);
				}
				i += 2;
				continue;
			}
			"r" => {
				use_!("r");
				let tk = toks.get(i + 1);
				match tk {
					Some(t) if !t.quoted && is_num(&t.text) && str_to_num(&t.text) > 0.0 => {
						// The pack writes `r` with 2 decimals; one that rounds to 0 is refused by the addon ("bad radius").
						// The JS parser (dsl/parse.js) lacks this check.
						if crate::js::to_fixed(str_to_num(&t.text), 2).parse::<f64>().is_ok_and(|v| v > 0.0) {
							goal.set("r", str_to_num(&t.text))
						} else {
							fail!(format!("radius \"{}\" rounds to 0 in the pack (2 decimals): use at least 0.005", tok_text(tk)))
						}
					}
					_ => fail!(format!("malformed radius \"{}\" (yards > 0)", tok_text(tk))),
				}
				i += 2;
				continue;
			}
			"lvl" => {
				use_!("lvl");
				let v = int_arg(i + 1, "level", cx)?;
				goal.set("minLevel", v);
				i += 2;
				continue;
			}
			"reward" | "choose" => {
				let w: &'static str = if word == "reward" { "reward" } else { "choose" };
				use_!(w);
				let (items, next) = match read_reward_list(toks, i + 1, w) {
					Ok(r) => r,
					Err(e) => fail!(e),
				};
				goal.set(if w == "reward" { "rewardItems" } else { "rewardChoices" }, items);
				i = next;
				continue;
			}
			"xp" => {
				use_!("xp");
				let v = int_arg(i + 1, "xp amount", cx)?;
				goal.set("rewardXp", v);
				i += 2;
				continue;
			}
			"money" => {
				use_!("money");
				let tk = toks.get(i + 1);
				let v = tk.filter(|t| !t.quoted).and_then(|t| read_money(&t.text));
				match v {
					Some(v) if v != 0.0 && !v.is_nan() => goal.set("rewardMoney", v),
					_ => fail!(format!("malformed money \"{}\" (copper, or e.g. 1g50s, 7s)", tok_text(tk))),
				}
				i += 2;
				continue;
			}
			"until" | "criteria" => {
				let w: &'static str = if word == "until" { "until" } else { "criteria" };
				use_!(w);
				let v = int_arg(i + 1, if w == "until" { "skill rank" } else { "criterion index" }, cx)?;
				goal.set(if w == "until" { "untilSkill" } else { "criteria" }, v);
				i += 2;
				continue;
			}
			"era" | "live" => {
				use_!("frame");
				goal.set("frame", word.as_str());
				i += 1;
				continue;
			}
			"nearest" => {
				use_!("nearest");
				goal.set("nearest", true);
				i += 1;
				continue;
			}
			"optional" => {
				use_!("optional");
				goal.set("optional", true);
				i += 1;
				continue;
			}
			"direct" => {
				use_!("direct");
				goal.set("direct", true);
				i += 1;
				continue;
			}
			"gossip" => {
				use_!("gossip");
				let v = int_arg(i + 1, "gossip option id", cx)?;
				goal.set("gossip", v);
				i += 2;
				continue;
			}
			"group" => {
				use_!("group");
				// The size is optional: a next token that starts like a number is one.
				let tk = toks.get(i + 1);
				match tk.filter(|t| !t.quoted && t.text.as_bytes().first().is_some_and(|b| matches!(b, b'-' | b'+' | b'.' | b'0'..=b'9'))) {
					Some(tk) => {
						let n = if is_int(&tk.text) { str_to_num(&tk.text) } else { f64::NAN };
						if !(GROUP_MIN..=GROUP_MAX).contains(&n) {
							fail!(format!("malformed group size \"{}\" ({} to {} players)", tk.text, GROUP_MIN, GROUP_MAX));
						}
						goal.set("group", obj! { "size" => n });
						i += 2;
					}
					None => {
						goal.set("group", V::obj());
						i += 1;
					}
				}
				continue;
			}
			"only" => {
				use_!("only");
				let mut list = String::new();
				let mut k = i + 1;
				// Take one token, plus more while the list is visibly continued by commas.
				while k < toks.len() && !toks[k].quoted {
					list += &toks[k].text;
					k += 1;
					if !(list.ends_with(',') || toks.get(k).is_some_and(|t| !t.quoted && t.text.starts_with(','))) {
						break;
					}
				}
				if list.is_empty() {
					fail!("`only` needs a condition list");
				}
				let c = parse_conditions(&list, "any");
				for e in &c.errors {
					cx.err(ln, e.clone(), None);
				}
				for w in &c.warnings {
					cx.warn(ln, w.clone());
				}
				if !c.errors.is_empty() {
					return None;
				}
				goal.set("only", c.value);
				i = k;
				continue;
			}
			_ => {}
		}
		cx.err(ln, if MOD_WORDS.contains(&word.as_str()) { format!("`{word}` does not apply to `{verb}`") } else { format!("unknown modifier \"{}\"", tok.text) }, None);
		return None;
	}
	flush(&mut cur, cur_start, i);
	if !goal.get("count").is_undef() && !goal.get("untilSkill").is_undef() {
		fail!("use either `xN` or `until <N>`, not both");
	}
	if goal.get("nearest").truthy() && !goal.get("npc").is_undef() {
		fail!("`nearest` picks the NPC at runtime; drop `npc`, or drop `nearest` to keep that NPC");
	}
	if goal.get("classTrain").truthy() && !goal.get("npc").is_undef() {
		fail!("`train class` picks the trainer at runtime; drop `npc`");
	}
	goal.set_hidden("spans", spans);
	Some(goal)
}
