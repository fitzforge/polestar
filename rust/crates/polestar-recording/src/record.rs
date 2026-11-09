//! Chunks and records (docs/RECORDING.md "Chunks", "Field encoding", "Record kinds"): decoding and
//! strict per-kind validation. A chunk with any malformed record of a known kind is rejected
//! whole; records of unknown kinds are skipped and counted (forward compatible).

use std::fmt;

use crate::sv::valid_char_id;

/// Longest text field, in bytes.
pub const MAX_TEXT: usize = 4000;
/// Longest quest title or objective, in characters.
pub const MAX_TITLE: usize = 255;
/// Longest zone name, in characters.
pub const MAX_PLACE: usize = 100;
/// Largest position coordinate (hundredths of a percent).
pub const MAX_COORD: u64 = 10000;
/// uiMapIDs are below this.
pub const MAX_MAP_ID: u64 = 100_000;

/// One field's type.
#[derive(Clone, Copy, Debug)]
enum F {
	/// Whole number >= 0, required.
	U,
	/// Whole number >= 0 or empty.
	OU,
	/// Whole number (may be negative) or empty.
	OI,
	/// Decimal number or empty.
	Num,
	/// Base-36 character id, required.
	Id,
	/// A token without spaces, or empty.
	Word,
	/// Free text (at most MAX_TEXT bytes, no control characters), may be empty.
	Text,
	/// A name the data build may ship (a quest title, a zone name): text of at most that many
	/// characters without `|` (the game's escape character), may be empty.
	Name(usize),
	/// One of the listed tokens (`""` listed = may be empty).
	Tok(&'static [&'static str]),
	/// Characters each from the set, any order, may be empty.
	Flags(&'static str),
	/// 1 to 16 uppercase hexadecimal digits, required (a GUID's spawn part).
	Hex,
	/// A game constant's name (`ERR_QUEST_NEED_PREREQS`): 1 to 64 of `A-Z`, `0-9`, `_`, required.
	Const,
	/// Three fields: map x y (all empty, or uiMapID > 0 and coordinates 0..=10000).
	P,
	/// `;`-separated items of `:`-separated parts; empty = no items.
	L(&'static [Part]),
}

/// A list item part's type. A trailing `T` part may be left out.
#[derive(Clone, Copy, Debug)]
enum Part {
	U,
	I,
	OU,
	W,
	T,
	/// [`F::Name`] as a list part (an objective); like `T`, may be left out when trailing.
	Name(usize),
	Tok(&'static [&'static str]),
}

const NK: F = F::Tok(&["c", "o", "i", "p", ""]);
const BOOL: F = F::Tok(&["1", "0"]);
const CLS: F = F::Tok(&["n", "e", "r", "R", "b", ""]);
const IDS: F = F::L(&[Part::U]);
const ITEMS: F = F::L(&[Part::U, Part::U]);

macro_rules! kinds {
	($($v:ident $name:literal [$($field:literal : $ty:expr),* $(,)?]),* $(,)?) => {
		/// Every record kind this library knows.
		#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash, PartialOrd, Ord)]
		pub enum Kind { $($v),* }

		impl Kind {
			pub const ALL: &'static [Kind] = &[$(Kind::$v),*];

			/// The wire name (`accept`, `pos`, ...).
			pub fn as_str(self) -> &'static str {
				match self { $(Kind::$v => $name),* }
			}

			pub fn parse(s: &str) -> Option<Kind> {
				match s { $($name => Some(Kind::$v),)* _ => None }
			}

			fn spec(self) -> &'static [(&'static str, F)] {
				match self { $(Kind::$v => &[$(($field, $ty)),*]),* }
			}
		}
	};
}

kinds! {
	Chunk "chunk" ["seq": F::U, "serverEpoch": F::U, "charId": F::Id],
	Session "session" [
		"charId": F::Id, "race": F::Word, "class": F::Word, "faction": F::Word, "sex": F::OU, "level": F::OU,
		"locale": F::Word, "build": F::OU, "interface": F::OU, "region": F::OU, "ruleset": F::Flags("hrp"),
		"recorderVersion": F::Word, "polestarVersion": F::Word, "packs": F::L(&[Part::T, Part::T]),
	],
	Map "map" ["id": F::U, "type": F::OU, "parent": F::OU, "continent": F::OU, "top": F::Num, "left": F::Num, "bottom": F::Num, "right": F::Num],
	Level "level" ["level": F::U, "P": F::P, "playedSeconds": F::OU],
	Xp "xp" ["xp": F::U, "xpMax": F::U, "rested": F::OU],
	Dropped "dropped" ["count": F::U],
	Group "group" ["size": F::U, "raid": BOOL],
	Mark "mark" ["P": F::P, "text": F::Text],
	Pos "pos" ["P": F::P, "flags": F::OU, "speed": F::OU],
	Zone "zone" ["P": F::P, "zoneText": F::Name(MAX_PLACE), "subzoneText": F::Name(MAX_PLACE)],
	Ride "ride" ["on": BOOL, "P": F::P],
	Taxi "taxi" ["fromNode": F::OU, "toNode": F::OU],
	Land "land" ["node": F::OU, "seconds": F::OU, "P": F::P],
	Death "death" ["P": F::P, "killerNpc": F::OU, "killerLevel": F::OI],
	Revive "revive" ["P": F::P, "how": F::Tok(&["s", "c", "r", ""])],
	Combat "combat" ["on": BOOL, "P": F::P],
	Afk "afk" ["on": BOOL],
	Rest "rest" ["kind": F::Tok(&["f", "d", "b"]), "seconds": F::OU],
	Offer "offer" ["npcKind": NK, "npcId": F::OU, "P": F::P, "available": IDS, "active": IDS, "log": IDS, "done": IDS, "notOffered": IDS],
	Detail "detail" ["q": F::U, "npcKind": NK, "npcId": F::OU, "P": F::P, "startItem": F::OU],
	Text "text" ["q": F::U, "title": F::Name(MAX_TITLE), "objectiveText": F::Text, "detailText": F::Text],
	Accept "accept" [
		"q": F::U, "npcKind": NK, "npcId": F::OU, "P": F::P, "level": F::OU, "rewardXp": F::OU, "rewardMoney": F::OU,
		"items": ITEMS, "choices": ITEMS,
	],
	Objectives "objectives" ["q": F::U, "list": F::L(&[Part::W, Part::OU, Part::Name(MAX_TITLE)])],
	Progress "progress" ["q": F::U, "index": F::U, "cur": F::U, "max": F::U, "P": F::P],
	Complete "complete" ["q": F::U],
	// `money` is negative for a quest that costs money to hand in (the game's signed reward-or-cost).
	Turnin "turnin" ["q": F::U, "npcKind": NK, "npcId": F::OU, "P": F::P, "level": F::OU, "xp": F::OU, "money": F::OI, "chosenItem": F::OU],
	Abandon "abandon" ["q": F::U],
	Fail "fail" ["q": F::U, "P": F::P],
	Gossip "gossip" ["npcKind": NK, "npcId": F::OU, "P": F::P, "optionId": F::OU, "optionText": F::Text],
	Refuse "refuse" ["P": F::P, "targetKind": NK, "targetId": F::OU, "error": F::Const],
	Cast "cast" ["spellId": F::OU, "itemId": F::OU, "P": F::P, "targetKind": NK, "targetId": F::OU],
	Escort "escort" ["q": F::U, "on": BOOL, "P": F::P],
	Kill "kill" [
		"npcId": F::U, "level": F::OI, "cls": CLS, "P": F::P, "xp": F::OU, "rested": F::OU, "tapped": F::Tok(&["1", "0", ""]), "q": ITEMS,
	],
	Spawn "spawn" ["npcId": F::U, "spawnUid": F::Hex, "P": F::P],
	Loot "loot" ["srcKind": NK, "srcId": F::OU, "P": F::P, "gather": F::Tok(&["h", "m", "s", "f", ""]), "items": ITEMS, "wanted": ITEMS],
	Gather "gather" ["objectId": F::U, "P": F::P, "how": F::Tok(&["h", "m", "f", "l"]), "skillLineId": F::OU, "rank": F::OU],
	Unit "unit" ["npcId": F::U, "level": F::OI, "cls": CLS, "react": F::Tok(&["h", "n", "f", ""]), "P": F::P, "src": F::Tok(&["p", "t", "m", ""])],
	Rare "rare" ["npcId": F::U, "level": F::OI, "cls": CLS, "P": F::P, "src": F::Word],
	Treasure "treasure" ["objectId": F::OU, "P": F::P],
	Enter "enter" ["instanceId": F::U, "instanceType": F::Word, "difficulty": F::OU, "P": F::P],
	Encounter "encounter" ["encounterId": F::U, "ok": BOOL, "difficulty": F::OU, "size": F::OU],
	Trainer "trainer" ["npcId": F::OU, "P": F::P, "services": F::L(&[Part::U, Part::U, Part::U, Part::Tok(&["a", "u", "k"]), Part::T])],
	Vendor "vendor" ["npcId": F::OU, "P": F::P, "items": F::L(&[Part::U, Part::U, Part::U, Part::I])],
	Flightmaster "flightmaster" ["npcId": F::OU, "P": F::P, "node": F::OU, "known": IDS],
	Bind "bind" ["npcId": F::OU, "P": F::P],
	Rep "rep" ["factionId": F::U, "standing": F::OU, "value": F::OI, "delta": F::OI],
	Skill "skill" ["skillLineId": F::U, "rank": F::U, "max": F::U],
	Explore "explore" ["areaId": F::U, "xp": F::OU, "P": F::P],
	Learn "learn" ["spellId": F::U],
	Craft "craft" ["recipeSpellId": F::U, "itemId": F::OU, "count": F::OU],
	Achieve "achieve" ["id": F::U],
	Step "step" ["guide": F::Text, "step": F::OU, "reason": F::Tok(&["next", "skip", "back", "auto", "pick", "done"]), "P": F::P],
}

impl Kind {
	/// Field names after `dt`, with `P` written out as `map`, `x`, `y`: the indices of
	/// [`Record::fields`].
	pub fn field_names(self) -> Vec<&'static str> {
		let mut out = Vec::new();
		for (name, ty) in self.spec() {
			if matches!(ty, F::P) {
				out.extend(["map", "x", "y"]);
			} else {
				out.push(name);
			}
		}
		out
	}

	fn width(self) -> usize {
		self.spec().iter().map(|(_, ty)| if matches!(ty, F::P) { 3 } else { 1 }).sum()
	}

	/// Where the kind's free text sits: (index in [`Record::fields`], None = the whole field,
	/// Some(p) = part p of every list item).
	pub(crate) fn text_slots(self) -> Vec<(usize, Option<usize>)> {
		let mut out = Vec::new();
		let mut i = 0;
		for (_, ty) in self.spec() {
			match ty {
				F::P => i += 2,
				F::Text | F::Name(_) => out.push((i, None)),
				F::L(parts) => {
					if let Some(p) = parts.iter().position(|p| matches!(p, Part::T | Part::Name(_))) {
						out.push((i, Some(p)));
					}
				}
				_ => {}
			}
			i += 1;
		}
		out
	}
}

impl fmt::Display for Kind {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		f.write_str(self.as_str())
	}
}

/// A position: uiMapID and coordinates in hundredths of a percent.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Pos {
	pub map: u32,
	pub x: u32,
	pub y: u32,
}

impl Pos {
	/// Coordinates in percent (0..=100).
	pub fn percent(self) -> (f64, f64) {
		(self.x as f64 / 100.0, self.y as f64 / 100.0)
	}
}

#[derive(Clone, Debug, PartialEq)]
pub struct Record {
	pub kind: Kind,
	/// Epoch seconds (the chunk's server epoch + dt).
	pub t: f64,
	/// The fields after `dt` (see [`Kind::field_names`]); a record written without its trailing
	/// optional fields gets them as empty strings.
	pub fields: Vec<String>,
}

impl Record {
	fn index(&self, name: &str) -> Option<usize> {
		let mut i = 0;
		for (n, ty) in self.kind.spec() {
			if matches!(ty, F::P) {
				match name {
					"map" => return Some(i),
					"x" => return Some(i + 1),
					"y" => return Some(i + 2),
					_ => i += 3,
				}
			} else {
				if *n == name {
					return Some(i);
				}
				i += 1;
			}
		}
		None
	}

	/// A field by name (see [`Kind::field_names`]); "" when empty or not a field of this kind.
	pub fn get(&self, name: &str) -> &str {
		self.index(name).and_then(|i| self.fields.get(i)).map(String::as_str).unwrap_or("")
	}

	/// A numeric field; None when empty.
	pub fn int(&self, name: &str) -> Option<i64> {
		self.get(name).parse().ok()
	}

	pub fn num(&self, name: &str) -> Option<f64> {
		self.get(name).parse().ok()
	}

	/// The record's position, when it has one and the client gave it.
	pub fn pos(&self) -> Option<Pos> {
		let i = self.index("map")?;
		let map = self.fields.get(i)?.parse().ok()?;
		let x = self.fields.get(i + 1)?.parse().ok()?;
		let y = self.fields.get(i + 2)?.parse().ok()?;
		Some(Pos { map, x, y })
	}

	/// A list field's items, each split into its parts.
	pub fn list(&self, name: &str) -> Vec<Vec<&str>> {
		let f = self.get(name);
		if f.is_empty() {
			return Vec::new();
		}
		f.split(';').map(|item| item.split(':').collect()).collect()
	}

	/// A list field's first parts as numbers (quest ids, item ids, node ids).
	pub fn ids(&self, name: &str) -> Vec<u64> {
		self.list(name).iter().filter_map(|p| p.first().and_then(|s| s.parse().ok())).collect()
	}
}

#[derive(Clone, Debug, PartialEq)]
pub struct Chunk {
	pub seq: u64,
	/// Server epoch seconds at the chunk's start.
	pub epoch: i64,
	pub char_id: String,
	/// Every known record after the `chunk` record, in order.
	pub records: Vec<Record>,
	/// Records of kinds this library does not know (skipped).
	pub skipped_unknown: u32,
}

impl Chunk {
	/// The chunk's first `session` record (its second record when the addon wrote it).
	pub fn session(&self) -> Option<&Record> {
		self.records.iter().find(|r| r.kind == Kind::Session)
	}
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct DecodeError {
	/// 1-based record number in the chunk (0: the chunk as a whole).
	pub record: usize,
	/// The record's kind, when known.
	pub kind: Option<&'static str>,
	pub message: String,
}

impl fmt::Display for DecodeError {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		match (self.record, self.kind) {
			(0, _) => f.write_str(&self.message),
			(n, Some(k)) => write!(f, "record {n} ({k}): {}", self.message),
			(n, None) => write!(f, "record {n}: {}", self.message),
		}
	}
}

impl std::error::Error for DecodeError {}

fn is_uint(s: &str) -> bool {
	!s.is_empty() && s.len() <= 19 && s.bytes().all(|b| b.is_ascii_digit())
}

fn is_int(s: &str) -> bool {
	is_uint(s.strip_prefix('-').unwrap_or(s))
}

fn is_decimal(s: &str) -> bool {
	let s = s.strip_prefix('-').unwrap_or(s);
	match s.split_once('.') {
		Some((a, b)) => is_uint(a) && is_uint(b),
		None => is_uint(s),
	}
}

fn is_word(s: &str) -> bool {
	s.len() <= 64 && !s.chars().any(|c| c.is_whitespace() || c.is_control())
}

fn check_text(s: &str) -> Result<(), String> {
	if s.len() > MAX_TEXT {
		return Err(format!("text longer than {MAX_TEXT} bytes"));
	}
	if s.chars().any(char::is_control) {
		return Err("text with a control character".into());
	}
	Ok(())
}

fn check_name(s: &str, max: usize) -> Result<(), String> {
	check_text(s)?;
	if s.contains('|') {
		return Err("name with `|`".into());
	}
	if s.chars().count() > max {
		return Err(format!("name longer than {max} characters"));
	}
	Ok(())
}

/// Whether a name (quest title, objective, zone) is one the data build may ship as it is.
fn shippable(s: &str, max: usize) -> bool {
	!s.contains('|') && s.chars().count() <= max
}

/// A name with the game's grammar escape taken out: `|4singular:plural;` removed (where the
/// Recorder made `:` and `;` spaces, it runs to the end of the name), no-break spaces made spaces,
/// the objective count the escape followed (`0/8`) dropped and the ends trimmed, as the Recorder
/// itself does since 0.3.6 (`Quests.lua`). The frFR client writes kill objectives as `%1$s :
/// %2$d/%3$d |4personnage tué:personnages tués;`, which Recorder 0.3.5 sent as
/// `Rôdeur  0/8 |4personnage tué personnages tués ` (`Rôdeur`). None when the name has no `|4`.
fn strip_grammar_escape(s: &str) -> Option<String> {
	if !s.contains("|4") {
		return None;
	}
	let mut out = String::with_capacity(s.len());
	let mut rest = s;
	while let Some(at) = rest.find("|4") {
		out.push_str(&rest[..at]);
		let after = &rest[at + 2..];
		let end = after.find(['|', ';']).unwrap_or(after.len());
		rest = after[end..].strip_prefix(';').unwrap_or(&after[end..]);
	}
	out.push_str(rest);
	let out = out.replace('\u{a0}', " ");
	let mut name = out.trim_end();
	// The count before the escape: digits, `/`, digits, after a space or a colon.
	if let Some((head, max)) = name.rsplit_once('/') {
		let cur = head.trim_end().trim_end_matches(|c: char| c.is_ascii_digit());
		if !max.trim().is_empty() && max.trim().bytes().all(|b| b.is_ascii_digit()) && cur.len() < head.trim_end().len() && (cur.is_empty() || cur.ends_with([' ', ':'])) {
			name = cur.trim_end().trim_end_matches(':').trim_end();
		}
	}
	Some(name.trim_start().to_string())
}

/// Empties the names ([`F::Name`] fields, [`Part::Name`] list parts) the data build could not ship:
/// one still carrying a `|` once the grammar escape is taken out ([`strip_grammar_escape`]), or an
/// overlong one. The record and its chunk are kept; only that name is lost. A name with a control
/// character is left as it is, for [`check_name`] to reject.
fn clear_unshippable_names(v: &mut String, ty: F) {
	let fix = |n: &str, max: usize| -> Option<String> {
		if shippable(n, max) || check_text(n).is_err() {
			return None;
		}
		Some(strip_grammar_escape(n).filter(|s| shippable(s, max)).unwrap_or_default())
	};
	match ty {
		F::Name(max) => {
			if let Some(n) = fix(v, max) {
				*v = n;
			}
		}
		F::L(parts) => {
			let Some((p, max)) = parts.iter().enumerate().find_map(|(i, part)| if let Part::Name(max) = part { Some((i, *max)) } else { None }) else { return };
			if !v.split(';').any(|item| item.split(':').nth(p).is_some_and(|n| fix(n, max).is_some())) {
				return;
			}
			let items: Vec<String> = v
				.split(';')
				.map(|item| item.split(':').enumerate().map(|(i, part)| if i == p { fix(part, max).unwrap_or_else(|| part.to_string()) } else { part.to_string() }).collect::<Vec<_>>().join(":"))
				.collect();
			*v = items.join(";");
		}
		_ => {}
	}
}

fn check_part(p: &str, ty: Part) -> Result<(), String> {
	let ok = match ty {
		Part::U => is_uint(p),
		Part::I => is_int(p),
		Part::OU => p.is_empty() || is_uint(p),
		Part::W => !p.is_empty() && is_word(p),
		Part::T => return check_text(p),
		Part::Name(max) => return check_name(p, max),
		Part::Tok(list) => list.contains(&p),
	};
	if ok {
		Ok(())
	} else {
		Err(format!("bad list part '{p}'"))
	}
}

fn check_list(s: &str, parts: &[Part]) -> Result<(), String> {
	if s.is_empty() {
		return Ok(());
	}
	check_text(s)?;
	let max = parts.len();
	let min = if matches!(parts.last(), Some(Part::T | Part::Name(_))) { max - 1 } else { max };
	for item in s.split(';') {
		let ps: Vec<&str> = item.split(':').collect();
		if ps.len() < min || ps.len() > max {
			return Err(format!("list item '{item}' has {} parts, expected {}", ps.len(), if min == max { max.to_string() } else { format!("{min} or {max}") }));
		}
		for (p, ty) in ps.iter().zip(parts) {
			check_part(p, *ty)?;
		}
	}
	Ok(())
}

fn optional(ty: F) -> bool {
	match ty {
		F::U | F::Id | F::Hex | F::Const => false,
		F::Tok(list) => list.contains(&""),
		_ => true,
	}
}

fn check_field(v: &str, ty: F) -> Result<(), String> {
	let ok = match ty {
		F::U => is_uint(v),
		F::OU => v.is_empty() || is_uint(v),
		F::OI => v.is_empty() || is_int(v),
		F::Num => v.is_empty() || is_decimal(v),
		F::Id => valid_char_id(v),
		F::Word => is_word(v),
		F::Text => return check_text(v),
		F::Name(max) => return check_name(v, max),
		F::Tok(list) => list.contains(&v),
		F::Flags(set) => v.chars().all(|c| set.contains(c)) && v.len() <= set.len(),
		F::Hex => (1..=16).contains(&v.len()) && v.bytes().all(|b| b.is_ascii_digit() || (b'A'..=b'F').contains(&b)),
		F::Const => (1..=64).contains(&v.len()) && v.bytes().all(|b| b.is_ascii_uppercase() || b.is_ascii_digit() || b == b'_'),
		F::L(parts) => return check_list(v, parts),
		F::P => unreachable!(),
	};
	if ok {
		Ok(())
	} else if v.is_empty() {
		Err("missing".into())
	} else {
		Err(format!("bad value '{v}'"))
	}
}

fn check_pos(map: &str, x: &str, y: &str) -> Result<(), String> {
	if map.is_empty() && x.is_empty() && y.is_empty() {
		return Ok(());
	}
	let coord = |s: &str| is_uint(s) && s.parse::<u64>().is_ok_and(|n| n <= MAX_COORD);
	if !(is_uint(map) && map.parse::<u64>().is_ok_and(|m| m > 0 && m < MAX_MAP_ID)) {
		return Err(format!("bad map '{map}'"));
	}
	if !coord(x) || !coord(y) {
		return Err(format!("bad position '{x} {y}' (0..={MAX_COORD})"));
	}
	Ok(())
}

/// Validates one record's fields (after `dt`) against its kind; pads missing trailing optional
/// fields with empty strings and empties the names the data build could not ship
/// ([`clear_unshippable_names`]).
fn validate(kind: Kind, fields: &mut Vec<String>) -> Result<(), String> {
	let width = kind.width();
	if fields.len() > width {
		return Err(format!("{} fields, expected {width}", fields.len()));
	}
	let given = fields.len();
	fields.resize(width, String::new());
	let mut i = 0;
	for (name, ty) in kind.spec() {
		if matches!(ty, F::P) {
			check_pos(&fields[i], &fields[i + 1], &fields[i + 2]).map_err(|e| format!("position: {e}"))?;
			i += 3;
			continue;
		}
		if i >= given && !optional(*ty) {
			return Err(format!("field {name}: missing"));
		}
		clear_unshippable_names(&mut fields[i], *ty);
		check_field(&fields[i], *ty).map_err(|e| format!("field {name}: {e}"))?;
		i += 1;
	}
	if kind == Kind::Map && !fields[0].parse::<u64>().is_ok_and(|m| m < MAX_MAP_ID) {
		return Err(format!("field id: uiMapID {} not below {MAX_MAP_ID}", fields[0]));
	}
	Ok(())
}

/// Decodes and validates a chunk (one Lua string: records separated by `\n`, fields by `\t`).
pub fn decode_chunk(text: &str) -> Result<Chunk, DecodeError> {
	let whole = |message: &str| DecodeError { record: 0, kind: None, message: message.to_string() };
	let mut lines = text.split('\n').enumerate().filter(|(_, l)| !l.is_empty());
	let Some((_, first)) = lines.next() else { return Err(whole("empty chunk")) };
	let mut head: Vec<String> = first.split('\t').map(str::to_string).collect();
	if head[0] != "chunk" {
		return Err(whole("the first record is not `chunk`"));
	}
	let err1 = |message: String| DecodeError { record: 1, kind: Some("chunk"), message };
	if head.get(1).map(String::as_str) != Some("0") {
		return Err(err1("dt must be 0".into()));
	}
	let mut fields = head.split_off(2);
	validate(Kind::Chunk, &mut fields).map_err(err1)?;
	let seq: u64 = fields[0].parse().map_err(|_| err1("bad seq".into()))?;
	let epoch: i64 = fields[1].parse().map_err(|_| err1("bad serverEpoch".into()))?;
	if seq == 0 {
		return Err(err1("seq must be at least 1".into()));
	}
	let mut chunk = Chunk { seq, epoch, char_id: fields[2].clone(), records: Vec::new(), skipped_unknown: 0 };
	for (n, line) in lines {
		let mut parts = line.split('\t');
		let name = parts.next().unwrap_or("");
		let Some(kind) = Kind::parse(name) else {
			chunk.skipped_unknown += 1;
			continue;
		};
		let err = |message: String| DecodeError { record: n + 1, kind: Some(kind.as_str()), message };
		if kind == Kind::Chunk {
			return Err(err("a second `chunk` record".into()));
		}
		let dt = parts.next().unwrap_or("");
		if !is_uint(dt) {
			return Err(err(format!("bad dt '{dt}'")));
		}
		let dt: u64 = dt.parse().map_err(|_| err("bad dt".into()))?;
		let mut fields: Vec<String> = parts.map(str::to_string).collect();
		validate(kind, &mut fields).map_err(err)?;
		chunk.records.push(Record { kind, t: epoch as f64 + dt as f64 / 10.0, fields });
	}
	Ok(chunk)
}

#[cfg(test)]
mod tests {
	use super::*;

	const HEAD: &str = "chunk\t0\t38\t1700000000\tabcdefghij\n";

	fn chunk(body: &str) -> Result<Chunk, DecodeError> {
		decode_chunk(&format!("{HEAD}{body}"))
	}

	#[test]
	fn decodes_a_good_chunk() {
		let c = chunk(concat!(
			"session\t0\tabcdefghij\tScourge\tWARRIOR\tHorde\t2\t12\tenUS\t62345\t11507\t3\th\t2.0.0\t1.4.0\tguides:1.4.0;guide:horde/1-12\n",
			"pos\t15\t1420\t4512\t6633\t1\t70\n",
			"accept\t20\t364\tc\t1568\t1420\t3100\t6600\t5\t250\t\t2224:1\t\n",
			"objectives\t20\t364\tmonster:8:Mindless Zombie slain;item:4:Scarlet Insignia\n",
			"kill\t31\t1501\t2\tn\t1420\t3200\t6500\t40\t20\t0\t364:1\n",
			"loot\t32\tc\t1501\t1420\t3200\t6500\t\t2589:2;2589:1\t364:2\n",
			"trainer\t40\t2119\t\t\t\t6673:10:4:a;0:100:6:u:Battle Shout\n",
			"zone\t50\t\t\t\tDeathknell\t\n",
			"futurekind\t60\twhatever\tfields\n",
			"step\t61\thorde/1-12\t4\tnext\t1420\t3300\t6400\n",
			"group\t62\t3\t0\n",
			"spawn\t63\t1501\t000043F59F\t1420\t3200\t6500\n",
			"loot\t64\to\t1617\t1420\t3200\t6500\th\t765:2\t\n",
			"gather\t64\t1617\t1420\t3200\t6500\th\t182\t57\n",
			"fail\t65\t364\t1420\t3200\t6500\n",
			"refuse\t66\t1420\t3200\t6500\tc\t1568\tERR_QUEST_NEED_PREREQS",
		))
		.unwrap();
		assert_eq!((c.seq, c.epoch, c.char_id.as_str(), c.skipped_unknown), (38, 1700000000, "abcdefghij", 1));
		assert_eq!(c.records.len(), 15);
		assert_eq!(c.session().unwrap().get("locale"), "enUS");
		let pos = &c.records[1];
		assert_eq!(pos.t, 1700000001.5);
		assert_eq!(pos.pos(), Some(Pos { map: 1420, x: 4512, y: 6633 }));
		let accept = &c.records[2];
		assert_eq!((accept.int("q"), accept.get("npcKind"), accept.int("rewardMoney")), (Some(364), "c", None));
		assert_eq!(accept.list("items"), vec![vec!["2224", "1"]]);
		assert_eq!(c.records[4].ids("q"), vec![364]);
		assert_eq!(c.records[6].list("services")[1], vec!["0", "100", "6", "u", "Battle Shout"]);
		assert_eq!(c.records[7].pos(), None);
		assert_eq!(c.records[8].kind, Kind::Step);
		let k = |i: usize| c.records[i].kind;
		assert_eq!([k(9), k(10), k(11), k(12), k(13), k(14)], [Kind::Group, Kind::Spawn, Kind::Loot, Kind::Gather, Kind::Fail, Kind::Refuse]);
		assert_eq!((c.records[9].int("size"), c.records[9].get("raid")), (Some(3), "0"));
		assert_eq!(c.records[10].get("spawnUid"), "000043F59F");
		assert_eq!((c.records[12].int("objectId"), c.records[12].get("how"), c.records[12].int("skillLineId"), c.records[12].int("rank")), (Some(1617), "h", Some(182), Some(57)));
		assert_eq!(c.records[13].pos(), Some(Pos { map: 1420, x: 3200, y: 6500 }));
		assert_eq!((c.records[14].get("targetKind"), c.records[14].int("targetId"), c.records[14].get("error")), ("c", Some(1568), "ERR_QUEST_NEED_PREREQS"));
	}

	#[test]
	fn map_ids_below_a_hundred_thousand() {
		assert!(chunk("pos\t0\t99999\t1\t1").is_ok());
		assert!(chunk("pos\t0\t100000\t1\t1").is_err());
		assert!(chunk("map\t0\t99999\t3").is_ok());
		assert!(chunk("map\t0\t100000\t3").is_err());
	}

	#[test]
	fn pads_missing_trailing_optional_fields() {
		let c = chunk("death\t5\t1420\t100\t200").unwrap();
		assert_eq!(c.records[0].fields, vec!["1420", "100", "200", "", ""]);
		assert!(chunk("progress\t5\t364\t1\t3").is_err());
	}

	#[test]
	fn a_turnin_that_costs_money_records_a_negative_money() {
		// QUEST_TURNED_IN's moneyReward is negative for a quest the player pays to hand in: Grime-
		// Encrusted Ring (2945) costs 3 silver at the Sparklematic 5200 (object 142487) inside
		// Gnomeregan, so no position. A 0.3.5 player's chunks holding such a turn-in were rejected
		// whole for "field money: bad value '-300'".
		let c = chunk("turnin\t412\t2945\to\t142487\t\t\t\t31\t2700\t-300\t\n").unwrap();
		let r = &c.records[0];
		assert_eq!((r.int("q"), r.get("npcKind"), r.int("npcId"), r.int("xp"), r.int("money"), r.pos()), (Some(2945), "o", Some(142487), Some(2700), Some(-300), None));
		assert!(chunk("turnin\t0\t2945\to\t142487\t\t\t\t31\t2700\t-\t").is_err(), "a sign alone is no number");
		assert!(chunk("turnin\t0\t2945\to\t142487\t\t\t\t31\t-5\t0\t").is_err(), "XP is never negative");
	}

	#[test]
	fn rejects_each_malformed_kind() {
		// One malformed example per kind: the whole chunk is rejected.
		let bad = [
			"session\t0\tABC\tScourge\tWARRIOR\tHorde\t2\t12\tenUS",
			"map\t0\tx\t3",
			"level\t0\t\t1420\t1\t1",
			"xp\t0\t10",
			"dropped\t0\t-1",
			"group\t0\t3\t2",
			"mark\t0\t1420\t100",
			"pos\t0\t1420\t10001\t5",
			"zone\t0\t0\t5\t5\tA\tB",
			"ride\t0\t2",
			"taxi\t0\ta\tb",
			"land\t0\t1\t2.5",
			"death\t0\t\t\t\t5\tboss",
			"revive\t0\t\t\t\tx",
			"combat\t0\t",
			"afk\t0\tyes",
			"rest\t0\tz\t3",
			"offer\t0\tc\t1\t\t\t\t1;x",
			"detail\t0\t\tc",
			"text\t0\tq",
			"accept\t0\t364\tc\t1568\t\t\t\t5\t250\t\t2224",
			"objectives\t0\t364\tmonster",
			"progress\t0\t364\t1\tx\t8",
			"complete\t0\t",
			"turnin\t0\t364\tz",
			"abandon\t0\tq",
			"fail\t0\t",
			"gossip\t0\tq",
			"refuse\t0\t\t\t\tc\t1\tERR quest",
			"cast\t0\t1.5",
			"escort\t0\t364\t2",
			"kill\t0\t\t2",
			"spawn\t0\t1501\t43f59f",
			"loot\t0\tc\t1\t\t\t\tx",
			"gather\t0\t1617\t\t\t\ts\t182\t57",
			"unit\t0\t1\t2\tn\tz",
			"rare\t0\t1\t2\tz",
			"treasure\t0\tx",
			"enter\t0\t\tparty",
			"encounter\t0\t1\t5",
			"trainer\t0\t1\t\t\t\t6673:10:4:z",
			"vendor\t0\t1\t\t\t\t1:2:3",
			"flightmaster\t0\t1\t\t\t\t2\ta",
			"bind\t0\tx",
			"rep\t0\tx",
			"skill\t0\t1\t2",
			"explore\t0\t",
			"learn\t0\tx",
			"craft\t0\t",
			"achieve\t0\t1.5",
			"step\t0\tg\t1\tjump",
		];
		let mut kinds: Vec<&str> = Vec::new();
		for b in bad {
			let e = chunk(b).expect_err(b);
			assert_eq!(e.record, 2, "{b}: {e}");
			kinds.push(e.kind.unwrap());
		}
		for k in Kind::ALL {
			assert!(*k == Kind::Chunk || kinds.contains(&k.as_str()), "no malformed example for {k}");
		}
		let long = "x".repeat(MAX_TEXT + 1);
		assert!(chunk(&format!("mark\t0\t\t\t\t{long}")).is_err());
		assert!(chunk("pos\tx\t1420\t1\t1").is_err());
		assert!(chunk("pos\t1\t1420\t1\t1\t0\t0\textra").is_err());
	}

	#[test]
	fn names_the_data_build_could_not_ship_are_emptied_and_the_chunk_kept() {
		// Titles, objectives and zone names: no `|`, 255 (100 for zones) characters at most. One
		// that breaks this loses the name; the record and its chunk are kept.
		let title = "\u{e9}".repeat(MAX_TITLE);
		assert_eq!(chunk(&format!("text\t0\t364\t{title}")).unwrap().records[0].get("title"), title);
		for (line, field) in [
			(format!("text\t0\t364\t{title}x\tKill them."), "title"),
			("text\t0\t364\tThe |cffff0000Damned|r\tKill them.".into(), "title"),
			(format!("zone\t0\t1420\t5\t5\t{}", "x".repeat(MAX_PLACE + 1)), "zoneText"),
			("zone\t0\t1420\t5\t5\tDeathknell|r".into(), "zoneText"),
		] {
			let c = chunk(&line).unwrap_or_else(|e| panic!("{line}: {e}"));
			assert_eq!(c.records[0].get(field), "", "{line}");
		}
		assert_eq!(chunk("text\t0\t364\tThe |cffff0000Damned|r\tKill them.").unwrap().records[0].get("objectiveText"), "Kill them.");
		// What Polestar Recorder 0.3.5 writes for frFR kill objectives: the client's "%1$s :
		// %2$d/%3$d |4personnage tué:personnages tués;" with `:` and `;` made spaces. Every frFR
		// chunk holding one was rejected whole before #1369, and its name emptied after: the escape
		// and the count are taken out instead, as the Recorder does since 0.3.6.
		for (sent, name) in [
			("R\u{f4}deur\u{a0}  0/8 |4personnage tu\u{e9} personnages tu\u{e9}s ", "R\u{f4}deur"),
			("Jeune loup\u{a0}  3/10 |4personnage tu\u{e9} personnages tu\u{e9}s ", "Jeune loup"),
			("Jeune Broche-tripes\u{a0}  12/12 |4personnage tu\u{e9} personnages tu\u{e9}s ", "Jeune Broche-tripes"),
			("Fourrageur murloc\u{a0}  0/1 |4personnage tu\u{e9} personnages tu\u{e9}s", "Fourrageur murloc"),
		] {
			let c = chunk(&format!("objectives\t20\t52\tmonster:8:{sent};item:1:Patte de r\u{f4}deur\u{a0}")).unwrap();
			assert_eq!(c.records[0].list("list"), vec![vec!["monster", "8", name], vec!["item", "1", "Patte de r\u{f4}deur\u{a0}"]], "{sent}");
		}
		// The escape as the client writes it (a title or zone field keeps `:` and `;`), with the
		// text after it kept; a name still carrying another escape loses it whole.
		let title = |t: &str| chunk(&format!("text\t0\t52\t{t}")).unwrap().records[0].get("title").to_string();
		assert_eq!(title("Rôdeur\u{a0}: 0/8 |4personnage tué:personnages tués;"), "Rôdeur");
		assert_eq!(title("Les |4loup:loups; de la frontière"), "Les  de la frontière");
		assert_eq!(title("Rôdeur |4personnage tué:personnages tués;|r"), "");
		// Names without the escape are kept as they are (no-break spaces too).
		assert_eq!(title("Rats capturés\u{a0}"), "Rats capturés\u{a0}");
		assert_eq!(chunk(&format!("objectives\t0\t364\tmonster:10:{}", "x".repeat(MAX_TITLE + 1))).unwrap().records[0].get("list"), "monster:10:");
		// Control characters still make the record malformed, names or not.
		for bad in ["text\t0\t364\tThe\u{1}Damned", "objectives\t0\t364\tmonster:10:Scourge\u{1}|H slain", "mark\t0\t\t\t\tnote\u{7}"] {
			assert!(chunk(bad).is_err(), "{bad}");
		}
		// Free text keeps `|`: it ships nowhere.
		assert_eq!(chunk("mark\t0\t\t\t\ta | b").unwrap().records[0].get("text"), "a | b");
	}

	#[test]
	fn rejects_bad_chunk_headers() {
		assert!(decode_chunk("").is_err());
		assert!(decode_chunk("pos\t0\t1\t1\t1").is_err());
		assert!(decode_chunk("chunk\t5\t38\t1700000000\tabcdefghij").is_err());
		assert!(decode_chunk("chunk\t0\t38\t1700000000\tNAME").is_err());
		assert!(decode_chunk("chunk\t0\t0\t1700000000\tabcdefghij").is_err());
		assert!(chunk("chunk\t0\t39\t1700000000\tabcdefghij").is_err());
	}
}
