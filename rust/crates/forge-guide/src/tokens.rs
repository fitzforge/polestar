//! Port of tools/lib/dsl/tokens.js.
//!
//! Name tokens (docs/GUIDE_FORMAT.md, "Names in texts"; docs/TRANSLATING.md, "Guide texts"): the game's names
//! inside a guide's prose, written as {kind:id}, so the addon shows each in the client's language. See the JS
//! module for the full rules; this port follows it line for line.
//!
//! Differences in representation: JS `Map`s/`Set`s of the module are Rust maps; a tokenised guide's hidden
//! `_plurals` is a V object (tokenised text -> [{ kind, id, name, english }]) instead of a JS Map. `TOKEN_RE` is
//! a matcher ([`token_at`], [`replace_tokens`]). Texts are scanned as UTF-16 code units like JS strings.
//! The JS per-data caches (WeakMaps) are rebuilt per [`tokenise_guides`] call, except the client's spell
//! names, cached in `data.memo` under `tokens.spellNames` (a host without a file system may fill that slot with
//! [[name, id], ...] itself).

use std::rc::Rc;
use std::sync::LazyLock;

use rustc_hash::{FxHashMap, FxHashSet};

use crate::data::Data;
use crate::js::{cmp_utf16, is_integer, num_str, str_to_num, Arr, Obj, V};
use crate::{arr, obj};

pub const KINDS: [&str; 9] = ["npc", "object", "item", "quest", "zone", "area", "spell", "faction", "skill"];
/// The guide fields a player reads as prose.
pub const GUIDE_FIELDS: [&str; 3] = ["title", "why", "pitch"];
pub const GUIDE_LISTS: [&str; 2] = ["pros", "cons"];
pub const STEP_FIELDS: [&str; 2] = ["title", "note"];
pub const GOAL_FIELDS: [&str; 2] = ["note", "text"];

fn goal_fields(goal: &V) -> &'static [&'static str] {
	static WITH_TARGET: [&str; 3] = ["note", "text", "target"];
	if goal.get("t").as_str() == Some("kill") && goal.get("npc").is_undef() && str_(&goal.get("target")).is_some() {
		&WITH_TARGET
	} else {
		&GOAL_FIELDS
	}
}

const STEP: f64 = 0.0;
const GUIDE: f64 = 1.0;
const ZONE_AREA: f64 = 2.0;
const WORLD_ZONE: f64 = 3.0;
const WORLD_AREA: f64 = 4.0;
const WORLD_DATA: f64 = 5.0;
const WORLD_SPELL: f64 = 6.0;
const SOURCES: [&str; 7] = ["step", "guide", "zoneArea", "worldZone", "worldArea", "worldData", "worldSpell"];
const MIN_NAME: usize = 3;
const MIN_FIRST: usize = 4;
const RANKS: [&str; 4] = ["Apprentice", "Journeyman", "Expert", "Artisan"];
const MEMO_SPELLS: &str = "tokens.spellNames";

// ---------------------------------------------------------------- JS character classes

fn class_re(src: &str) -> regex::Regex {
	regex::Regex::new(src).unwrap()
}
static RE_L: LazyLock<regex::Regex> = LazyLock::new(|| class_re(r"^\p{L}$"));
static RE_N: LazyLock<regex::Regex> = LazyLock::new(|| class_re(r"^\p{N}$"));
static RE_LU: LazyLock<regex::Regex> = LazyLock::new(|| class_re(r"^\p{Lu}$"));
static RE_LL: LazyLock<regex::Regex> = LazyLock::new(|| class_re(r"^\p{Ll}$"));
fn matches_class(c: char, re: &regex::Regex) -> bool {
	let mut buf = [0u8; 4];
	re.is_match(c.encode_utf8(&mut buf))
}
/// `\p{L}`
fn is_l(c: char) -> bool {
	if c.is_ascii() {
		c.is_ascii_alphabetic()
	} else {
		matches_class(c, &RE_L)
	}
}
/// `\p{N}`
fn is_n(c: char) -> bool {
	if c.is_ascii() {
		c.is_ascii_digit()
	} else {
		matches_class(c, &RE_N)
	}
}
/// `\p{Lu}`
fn is_lu(c: char) -> bool {
	if c.is_ascii() {
		c.is_ascii_uppercase()
	} else {
		matches_class(c, &RE_LU)
	}
}
/// `\p{Ll}`
fn is_ll(c: char) -> bool {
	if c.is_ascii() {
		c.is_ascii_lowercase()
	} else {
		matches_class(c, &RE_LL)
	}
}
fn is_ln(c: char) -> bool {
	is_l(c) || is_n(c)
}
/// `[\p{L}\p{N}'’-]`
fn is_name_ch(c: char) -> bool {
	is_ln(c) || c == '\'' || c == '’' || c == '-'
}
/// `[\p{L}'’-]`
fn is_word_part(c: char) -> bool {
	is_l(c) || c == '\'' || c == '’' || c == '-'
}
/// JS `\s` (WhiteSpace and LineTerminator).
fn js_ws(c: char) -> bool {
	matches!(c, '\t' | '\n' | '\u{B}' | '\u{C}' | '\r' | ' ' | '\u{A0}' | '\u{1680}' | '\u{2000}'..='\u{200A}' | '\u{2028}' | '\u{2029}' | '\u{202F}' | '\u{205F}' | '\u{3000}' | '\u{FEFF}')
}
fn js_trim(s: &str) -> &str {
	s.trim_matches(js_ws)
}
/// JS `\b` word character without the `i` flag: `[A-Za-z0-9_]`.
fn ascii_word(c: char) -> bool {
	c.is_ascii_alphanumeric() || c == '_'
}
fn sp_tab(c: char) -> bool {
	c == ' ' || c == '\t'
}
/// `s.trim().split(/\s+/)`.
fn split_ws(s: &str) -> Vec<String> {
	let t = js_trim(s);
	if t.is_empty() {
		return vec![String::new()];
	}
	t.split(js_ws).filter(|w| !w.is_empty()).map(str::to_string).collect()
}

fn u16s(s: &str) -> Vec<u16> {
	s.encode_utf16().collect()
}
/// Code points of UTF-16 units, as a `u`-flag regex reads them (a lone surrogate as U+FFFD, in no class here).
fn chars16(t: &[u16]) -> Vec<char> {
	char::decode_utf16(t.iter().copied()).map(|r| r.unwrap_or('\u{FFFD}')).collect()
}
/// `isWordChar(text[i])`: one UTF-16 unit (a lone surrogate never matches).
fn unit_word(u: Option<u16>) -> bool {
	match u {
		Some(u) => char::from_u32(u as u32).is_some_and(is_ln),
		None => false,
	}
}

/// `str(v)`: a string that is not blank, or None.
fn str_(v: &V) -> Option<&str> {
	match v.as_str() {
		Some(s) if !js_trim(s).is_empty() => Some(s),
		_ => None,
	}
}
fn is_int(v: &V) -> bool {
	v.as_num().is_some_and(is_integer)
}
/// `Number.isInteger(x)` value as an f64, else None.
fn int_of(v: &V) -> Option<f64> {
	v.as_num().filter(|n| is_integer(*n))
}

// ---------------------------------------------------------------- tokens

/// `TOKEN_RE` at byte `i` of `s`: (kind, digits, byte length).
pub fn token_at(s: &str, i: usize) -> Option<(&'static str, &str, usize)> {
	let b = s.as_bytes();
	if b.get(i) != Some(&b'{') {
		return None;
	}
	let rest = &s[i + 1..];
	let kind = KINDS.iter().find(|k| rest.starts_with(*k) && rest.as_bytes().get(k.len()) == Some(&b':'))?;
	let ds = i + 1 + kind.len() + 1;
	let mut de = ds;
	while de < b.len() && b[de].is_ascii_digit() {
		de += 1;
	}
	if de == ds || b.get(de) != Some(&b'}') {
		return None;
	}
	Some((kind, &s[ds..de], de + 1 - i))
}

/// `text.replace(TOKEN_RE, f)` with `f(kind, digits) -> replacement`.
pub fn replace_tokens(text: &str, f: &mut dyn FnMut(&str, &str) -> String) -> String {
	let mut out = String::new();
	let mut at = 0;
	let mut i = 0;
	while let Some(p) = text[i..].find('{') {
		let j = i + p;
		if let Some((kind, digits, len)) = token_at(text, j) {
			out.push_str(&text[at..j]);
			out.push_str(&f(kind, digits));
			at = j + len;
			i = at;
		} else {
			i = j + 1;
		}
	}
	out.push_str(&text[at..]);
	out
}

/// A text with its tokens filled by `names` (a guide's `names` object, or nullish), as an English client reads it.
pub fn fill_tokens(text: &str, names: &V) -> String {
	replace_tokens(text, &mut |kind, digits| {
		let whole = format!("{{{kind}:{digits}}}");
		if !names.truthy() {
			return whole;
		}
		let en = names.get(&format!("{kind}:{digits}"));
		if en.truthy() {
			en.to_js_string()
		} else {
			whole
		}
	})
}

fn fill_tokens_map(text: &str, names: &FxHashMap<String, String>) -> String {
	replace_tokens(text, &mut |kind, digits| match names.get(&format!("{kind}:{digits}")) {
		Some(en) if !en.is_empty() => en.clone(),
		_ => format!("{{{kind}:{digits}}}"),
	})
}

/// The tokens of a text, in order: ["npc:234", ...].
pub fn tokens_of(text: &str) -> Vec<String> {
	let mut out = Vec::new();
	replace_tokens(text, &mut |kind, digits| {
		out.push(format!("{kind}:{digits}"));
		String::new()
	});
	out
}

/// Whether a text is nothing but tokens, digits, spaces and punctuation: it needs no translation.
pub fn only_tokens(text: &str) -> bool {
	!replace_tokens(text, &mut |_, _| String::new()).chars().any(is_l)
}

// ---------------------------------------------------------------- data names

/// The English name data gives `kind` `id`, or None.
pub fn data_name(data: &Data, kind: &str, id: &V) -> Option<String> {
	let rec = match kind {
		"npc" => data.npc(id),
		"object" => data.object(id),
		"item" => data.item(id),
		"quest" => {
			let q = data.quest(id);
			return if q.truthy() { str_(&q.get("title")).map(str::to_string) } else { None };
		}
		"zone" => data.zone(id),
		"area" => {
			if data.areas.truthy() {
				area_by_id(data, id)
			} else {
				V::Null
			}
		}
		"faction" => data.faction(id),
		"skill" => data.profession(id),
		"spell" => {
			let n = id.as_num()?;
			return spell_names(data).into_iter().find(|(_, sid)| *sid == n).map(|(name, _)| name).filter(|s| !s.is_empty());
		}
		_ => V::Null,
	};
	if rec.truthy() {
		str_(&rec.get("name")).map(str::to_string)
	} else {
		None
	}
}

/// `data.areas.byId.get(id)` (Undef when absent or `id` is no number).
fn area_by_id(data: &Data, id: &V) -> V {
	match id.as_num() {
		Some(n) => data.areas.get("byId").get(&num_str(n)),
		None => V::Undef,
	}
}

struct Named {
	kind: &'static str,
	id: f64,
	name: String,
	own: bool,
}

fn static_kind(k: &str) -> Option<&'static str> {
	KINDS.iter().copied().find(|x| *x == k)
}

/// Every { kind, id, name } a goal names, its own (the NPC, object, target or item it shows) flagged `own`.
fn goal_names(goal: &V, data: &Data) -> Vec<Named> {
	let mut out = Vec::new();
	let mut add = |kind: &'static str, id: &V, name: &V, own: bool| {
		if let (Some(id), Some(name)) = (int_of(id), str_(name)) {
			out.push(Named { kind, id, name: name.to_string(), own });
		}
	};
	add("quest", &goal.get("quest"), &goal.get("title"), false);
	add("npc", &goal.get("npc"), &goal.get("npcName"), true);
	if goal.get("t").as_str() == Some("kill") {
		add("npc", &goal.get("npc"), &goal.get("target"), true);
	}
	add("object", &goal.get("object"), &goal.get("objName"), true);
	add("item", &goal.get("item"), &goal.get("itemName"), true);
	add("spell", &goal.get("spell"), &goal.get("spellName"), false);
	add("faction", &goal.get("faction"), &goal.get("factionName"), false);
	add("skill", &goal.get("skillLine"), &goal.get("skill"), false);
	add("skill", &goal.get("profLine"), &goal.get("profName"), false);
	let from_kind = goal.get("fromKind");
	if let Some(fk @ ("npc" | "object")) = from_kind.as_str() {
		let fk = static_kind(fk).unwrap();
		add(fk, &goal.get("fromId"), &goal.get("from"), false);
		add(fk, &goal.get("fromAlsoId"), &goal.get("fromAlso"), false);
	}
	for c in or_empty(&goal.get("candidates")) {
		add("npc", &c.get("npc"), &c.get("npcName"), true);
	}
	for r in or_empty(&goal.get("reagents")) {
		add("item", &r.get("item"), &r.get("itemName"), false);
	}
	let rewards = goal.get("rewards");
	for list in [if rewards.truthy() { rewards.get("items") } else { rewards.clone() }, if rewards.truthy() { rewards.get("choices") } else { rewards.clone() }] {
		for r in or_empty(&list) {
			add("item", &r.get("item"), &r.get("itemName"), false);
		}
	}
	let pre = goal.get("preTitles");
	if pre.truthy() {
		for (id, title) in pre.entries() {
			add("quest", &V::Num(str_to_num(&id)), &title, false);
		}
	}
	let area = goal.get("area");
	if is_int(&area) {
		let name: V = data_name(data, "area", &area).map(V::from).unwrap_or(V::Null);
		add("area", &area, &name, false);
	}
	let quest = goal.get("quest");
	if is_int(&quest) {
		for o in data.quest_objectives(&quest) {
			let kind = match o.get("kind").as_str() {
				Some("kill") => Some("npc"),
				Some("item") => Some("item"),
				Some("object") => Some("object"),
				_ => None,
			};
			let oid = o.get("id");
			if let Some(kind) = kind {
				if is_int(&oid) {
					let name: V = data_name(data, kind, &oid).map(V::from).unwrap_or(V::Null);
					add(kind, &oid, &name, false);
				}
			}
		}
	}
	out
}

/// `x || []` for a list.
fn or_empty(v: &V) -> Vec<V> {
	if v.truthy() {
		v.items()
	} else {
		Vec::new()
	}
}

/// Whether area `id` lies in the area `zone` (its ParentAreaID chain).
fn within(data: &Data, id: &V, zone: f64) -> bool {
	let mut a = area_by_id(data, id);
	let mut hops = 0;
	while a.truthy() && hops < 8 {
		if a.get("id").as_num() == Some(zone) {
			return true;
		}
		let p = a.get("parent");
		a = if p.truthy() { area_by_id(data, &p) } else { V::Null };
		hops += 1;
	}
	false
}

/// Lower-case words of every prose text of the pack.
fn common_words(guides: &[V]) -> FxHashSet<String> {
	let mut words = FxHashSet::default();
	for g in guides {
		for_each_text(g, true, &mut |s, _, _, _, _| {
			for w in s.split(|c: char| !is_word_part(c)) {
				if !w.is_empty() && w == w.to_lowercase() && w != w.to_uppercase() {
					words.insert(w.to_string());
				}
			}
		});
	}
	words
}

/// Where a prose text sits in its holder: a field of an object, or an index of a list.
#[derive(Clone, Debug)]
pub enum TextKey {
	Field(&'static str),
	Index(usize),
}

fn set_at(holder: &V, key: &TextKey, v: V) {
	match key {
		TextKey::Field(f) => holder.set(f, v),
		TextKey::Index(i) => holder.set(&i.to_string(), v),
	}
}

/// Calls f(text, holder, key, level, stepIndex) for every prose text of a guide, in reading order (level:
/// "guide", "step" or "goal"; for a list, holder is the list and key the index). `steps`: the JS option.
pub fn for_each_text(guide: &V, steps: bool, f: &mut dyn FnMut(&str, &V, &TextKey, &str, Option<usize>)) {
	for k in GUIDE_FIELDS {
		let v = guide.get(k);
		if let Some(s) = str_(&v) {
			f(s, guide, &TextKey::Field(k), "guide", None);
		}
	}
	for k in GUIDE_LISTS {
		let list = guide.get(k);
		if list.is_arr() {
			for (i, s) in list.items().iter().enumerate() {
				if let Some(t) = str_(s) {
					f(t, &list, &TextKey::Index(i), "guide", None);
				}
			}
		}
	}
	for r in or_empty(&guide.get("reward")) {
		if r.truthy() {
			let t = r.get("text");
			if let Some(s) = str_(&t) {
				f(s, &r, &TextKey::Field("text"), "guide", None);
			}
		}
	}
	if !steps {
		return;
	}
	for (si, step) in or_empty(&guide.get("steps")).iter().enumerate() {
		for k in STEP_FIELDS {
			let v = step.get(k);
			if let Some(s) = str_(&v) {
				f(s, step, &TextKey::Field(k), "step", Some(si));
			}
		}
		for goal in or_empty(&step.get("goals")) {
			for k in goal_fields(&goal) {
				let v = goal.get(k);
				if let Some(s) = str_(&v) {
					f(s, &goal, &TextKey::Field(k), "goal", Some(si));
				}
			}
		}
	}
}

/// `capitalBefore(before)`.
fn capital_before(before: &[char]) -> bool {
	// /(^|[^\p{L}\p{N}'’-])\p{Lu}[\p{L}\p{N}'’-]*[ \t]+of[ \t]+$/u
	let mut e = before.len();
	let s1 = e;
	while e > 0 && sp_tab(before[e - 1]) {
		e -= 1;
	}
	if e < s1 && e >= 2 && before[e - 2] == 'o' && before[e - 1] == 'f' {
		let mut w = e - 2;
		let s2 = w;
		while w > 0 && sp_tab(before[w - 1]) {
			w -= 1;
		}
		if w < s2 {
			let mut st = w;
			while st > 0 && is_name_ch(before[st - 1]) {
				st -= 1;
			}
			if st < w && is_lu(before[st]) {
				return true;
			}
		}
	}
	// /(^|[\s\S]*?[^\p{L}\p{N}'’-])(\p{Lu}[\p{L}\p{N}'’-]*)[ \t]+$/u
	let mut e = before.len();
	while e > 0 && sp_tab(before[e - 1]) {
		e -= 1;
	}
	if e == before.len() {
		return false;
	}
	let mut st = e;
	while st > 0 && is_name_ch(before[st - 1]) {
		st -= 1;
	}
	if st == e || !is_lu(before[st]) {
		return false;
	}
	let word: String = before[st..e].iter().collect();
	if word == "The" || RANKS.contains(&word.as_str()) || word.ends_with("'s") || word.ends_with("’s") {
		return false;
	}
	!opens_sentence(&before[..st])
}

/// Whether a word after `before` opens its sentence: /(^|[.!?:;\n(])\s*$/u.
fn opens_sentence(before: &[char]) -> bool {
	let mut e = before.len();
	while e > 0 && js_ws(before[e - 1]) {
		if before[e - 1] == '\n' {
			return true;
		}
		e -= 1;
	}
	e == 0 || matches!(before[e - 1], '.' | '!' | '?' | ':' | ';' | '\n' | '(')
}

/// A name of an index.
#[derive(Debug)]
pub struct Entry {
	pub name: String,
	name16: Vec<u16>,
	pub english: String,
	pub kind: &'static str,
	pub id: f64,
	pub prio: f64,
	pub alias: bool,
	pub next: Option<String>,
}

/// Names by their first three characters, each name once (its best source kept), the longest first.
pub struct NameIndex {
	common: Rc<FxHashSet<String>>,
	by_start: FxHashMap<Vec<u16>, Vec<Rc<Entry>>>,
	seen: FxHashMap<String, Rc<Entry>>,
}

/// `/^The (.+)$/` and `/^(.+) City$/` (`.`: no line terminator).
fn no_lt(s: &str) -> bool {
	!s.chars().any(|c| matches!(c, '\n' | '\r' | '\u{2028}' | '\u{2029}'))
}

impl NameIndex {
	fn new(common: Rc<FxHashSet<String>>) -> NameIndex {
		NameIndex { common, by_start: FxHashMap::default(), seen: FxHashMap::default() }
	}

	fn add(&mut self, kind: &'static str, id: &V, name: Option<&str>, prio: f64) {
		let Some(name) = name.filter(|n| !js_trim(n).is_empty()).map(js_trim) else { return };
		let Some(id) = int_of(id).filter(|i| *i > 0.0) else { return };
		self.put(name, name, kind, id, prio, false, None);
		if !matches!(kind, "area" | "zone" | "npc" | "object") {
			return;
		}
		let place = kind == "zone" || kind == "area";
		if let Some(rest) = name.strip_prefix("The ") {
			if !rest.is_empty() && no_lt(rest) && (place || rest.contains(' ')) {
				self.put(rest, name, kind, id, prio + 0.5, true, None);
			}
		}
		if place {
			if let Some(head) = name.strip_suffix(" City") {
				if !head.is_empty() && no_lt(head) {
					self.put(head, name, kind, id, prio + 0.5, true, None);
				}
			}
		}
	}

	fn add_firsts(&mut self, npcs: &[(f64, String)], prio: f64, ctx: &Ctx) {
		let mut by_word: Vec<(String, Vec<(f64, Vec<String>)>)> = Vec::new();
		for (id, name) in npcs {
			let words = split_ws(name);
			if words.len() < 2 || words[0].encode_utf16().count() < MIN_FIRST {
				continue;
			}
			let pos = match by_word.iter().position(|(w, _)| *w == words[0]) {
				Some(p) => p,
				None => {
					by_word.push((words[0].clone(), Vec::new()));
					by_word.len() - 1
				}
			};
			let ids = &mut by_word[pos].1;
			match ids.iter_mut().find(|(i, _)| i == id) {
				Some(slot) => slot.1 = words,
				None => ids.push((*id, words)),
			}
		}
		for (word, ids) in by_word {
			if ids.len() != 1 || ctx.first_words.get(&word) != Some(&1) || ctx.other_names.contains(&word.to_lowercase()) {
				continue;
			}
			let (id, words) = &ids[0];
			let last = words[words.len() - 1].to_lowercase();
			if self.common.contains(&last) || self.common.contains(&format!("{last}s")) {
				continue;
			}
			self.put(&word, &words.join(" "), "npc", *id, prio + 0.5, true, Some(words[1].to_lowercase()));
		}
	}

	fn put(&mut self, m: &str, english: &str, kind: &'static str, id: f64, prio: f64, alias: bool, next: Option<String>) {
		let m16 = u16s(m);
		if m16.len() < MIN_NAME || !m.chars().next().is_some_and(|c| is_lu(c) || is_n(c)) {
			return;
		}
		if kind != "skill" && !m.contains(' ') && self.common.contains(&m.to_lowercase()) {
			return;
		}
		let had = self.seen.get(m).cloned();
		if let Some(h) = &had {
			if h.prio < prio || (h.prio == prio && h.id <= id) {
				return;
			}
		}
		let start = m16[..MIN_NAME].to_vec();
		let entry = Rc::new(Entry { name: m.to_string(), name16: m16, english: english.to_string(), kind, id, prio, alias, next });
		let list = self.by_start.entry(start).or_default();
		match had {
			Some(h) => {
				let p = list.iter().position(|e| Rc::ptr_eq(e, &h)).unwrap();
				list[p] = entry.clone();
			}
			None => list.push(entry.clone()),
		}
		self.seen.insert(m.to_string(), entry);
	}

	/// The JS sorts lazily before a lookup; every index here is complete before its first lookup.
	fn finish(&mut self) {
		for list in self.by_start.values_mut() {
			list.sort_by_key(|b| std::cmp::Reverse(b.name16.len()));
		}
	}

	/// The longest name starting at text[i] as a whole word, or None; with `plural`, the longest whose English
	/// plural (name + "s") stands there.
	fn at(&self, text: &[u16], i: usize, plural: bool) -> Option<Rc<Entry>> {
		let key = &text[i..(i + MIN_NAME).min(text.len())];
		let list = self.by_start.get(key)?;
		for e in list {
			if !text[i..].starts_with(&e.name16) {
				continue;
			}
			let end = i + e.name16.len();
			let rest = chars16(&text[end..]);
			if capital_after(&rest) || capital_before(&chars16(&text[..i])) {
				continue;
			}
			if let Some(next) = &e.next {
				let mut p = 0;
				while p < rest.len() && sp_tab(rest[p]) {
					p += 1;
				}
				if p > 0 && p < rest.len() && is_ll(rest[p]) {
					let mut q = p + 1;
					while q < rest.len() && is_word_part(rest[q]) {
						q += 1;
					}
					let w: String = rest[p..q].iter().collect();
					if w.starts_with(next.as_str()) {
						continue;
					}
				}
			}
			if e.kind == "spell" {
				if rest.len() >= 2 && (rest[0] == '\'' || rest[0] == '’') && rest[1] == 's' && !rest.get(2).is_some_and(|c| ascii_word(*c)) {
					continue;
				}
				if !e.name.contains(' ') && e.prio >= WORLD_SPELL && (spell_object_after(&rest) || (opens_sentence(&chars16(&text[..i])) && lower_after(&rest))) {
					continue;
				}
			}
			let ok = if plural { text.get(end) == Some(&(b's' as u16)) && !unit_word(text.get(end + 1).copied()) } else { !unit_word(text.get(end).copied()) };
			if ok {
				return Some(e.clone());
			}
		}
		None
	}
}

/// /^[ \t]+(of[ \t]+)?\p{Lu}/u
fn capital_after(rest: &[char]) -> bool {
	let mut p = 0;
	while p < rest.len() && sp_tab(rest[p]) {
		p += 1;
	}
	if p == 0 || p >= rest.len() {
		return false;
	}
	if is_lu(rest[p]) {
		return true;
	}
	if rest[p] == 'o' && rest.get(p + 1) == Some(&'f') {
		let mut q = p + 2;
		let s = q;
		while q < rest.len() && sp_tab(rest[q]) {
			q += 1;
		}
		return q > s && q < rest.len() && is_lu(rest[q]);
	}
	false
}

/// /^[ \t]+(the|a|an|your|its|their|it|them|him|her)\b/u
fn spell_object_after(rest: &[char]) -> bool {
	let mut p = 0;
	while p < rest.len() && sp_tab(rest[p]) {
		p += 1;
	}
	if p == 0 {
		return false;
	}
	["the", "a", "an", "your", "its", "their", "it", "them", "him", "her"].iter().any(|w| {
		let n = w.chars().count();
		p + n <= rest.len() && rest[p..p + n].iter().copied().eq(w.chars()) && !rest.get(p + n).is_some_and(|c| ascii_word(*c))
	})
}

/// /^[ \t]+\p{Ll}/u
fn lower_after(rest: &[char]) -> bool {
	let mut p = 0;
	while p < rest.len() && sp_tab(rest[p]) {
		p += 1;
	}
	p > 0 && p < rest.len() && is_ll(rest[p])
}

/// One index of a lookup: a name index, or one consulted only right after "cast" or "your".
#[derive(Clone, Copy)]
pub enum Ix<'a> {
	Plain(&'a NameIndex),
	Cast(&'a NameIndex),
}

impl Ix<'_> {
	fn at(&self, text: &[u16], i: usize, plural: bool) -> Option<Rc<Entry>> {
		match self {
			Ix::Plain(x) => x.at(text, i, plural),
			Ix::Cast(x) => {
				if cast_before(&chars16(&text[i.saturating_sub(6)..i])) {
					x.at(text, i, plural)
				} else {
					None
				}
			}
		}
	}
}

/// /\b(cast|your)[ \t]+$/iu (the `iu` flags: ſ folds to s and counts as a word character, as K does).
fn cast_before(s: &[char]) -> bool {
	let word = |c: char| ascii_word(c) || c == '\u{17F}' || c == '\u{212A}';
	let fold = |c: char| if c == '\u{17F}' { 's' } else { c.to_ascii_lowercase() };
	let mut e = s.len();
	while e > 0 && sp_tab(s[e - 1]) {
		e -= 1;
	}
	if e == s.len() || e < 4 {
		return false;
	}
	let w = &s[e - 4..e];
	let hit = ["cast", "your"].iter().any(|t| w.iter().map(|c| fold(*c)).eq(t.chars()));
	hit && (e == 4 || !word(s[e - 5]))
}

/// The longest name at text[i] over indexes ordered best first; a tie goes to the earlier index.
fn longest_at(indexes: &[Ix], text: &[u16], i: usize, plural: bool) -> Option<Rc<Entry>> {
	let mut best: Option<Rc<Entry>> = None;
	for idx in indexes {
		if let Some(e) = idx.at(text, i, plural) {
			if best.as_ref().is_none_or(|b| e.name16.len() > b.name16.len()) {
				best = Some(e);
			}
		}
	}
	best
}

/// Per-data tables of one tokenise_guides run (the JS WeakMap caches).
struct Ctx {
	first_words: FxHashMap<String, usize>,
	other_names: FxHashSet<String>,
	zone_areas: FxHashMap<i64, Vec<V>>,
}

/// The JS `worldIndex`: (idx, abilities).
fn world_index(data: &Data, common: &Rc<FxHashSet<String>>) -> (NameIndex, NameIndex) {
	let mut idx = NameIndex::new(common.clone());
	let mut zone_count: FxHashMap<String, usize> = FxHashMap::default();
	let zones = if data.zones.truthy() { data.zones.values() } else { Vec::new() };
	for z in &zones {
		if z.truthy() {
			if let Some(n) = str_(&z.get("name")) {
				*zone_count.entry(n.to_string()).or_default() += 1;
			}
		}
	}
	for z in &zones {
		if z.truthy() {
			if let Some(n) = str_(&z.get("name")) {
				if js_num(&z.get("type")) >= 2.0 && zone_count.get(n) == Some(&1) {
					idx.add("zone", &z.get("id"), Some(n), WORLD_ZONE);
				}
			}
		}
	}
	if data.areas.truthy() {
		for list in data.areas.get("byName").values() {
			let list = list.items();
			let open: Vec<V> = if list.len() == 1 { list } else { list.into_iter().filter(|a| matches!(a.get("c"), V::Num(c) if c == 0.0 || c == 1.0)).collect() };
			if open.len() == 1 {
				let name = open[0].get("name");
				if !zone_count.contains_key(&name.to_js_string()) || !name.is_str() {
					idx.add("area", &open[0].get("id"), name.as_str(), WORLD_AREA);
				}
			}
		}
	}
	let mut prof_ids: Vec<&i64> = data.professions.keys().collect();
	prof_ids.sort();
	for pid in prof_ids {
		let p = &data.professions[pid];
		idx.add("skill", &p.get("id"), p.get("name").as_str(), WORLD_ZONE);
		for r in or_empty(&p.get("recipes")) {
			let gs = if r.truthy() { or_empty(&r.get("reagents")) } else { Vec::new() };
			for g in gs {
				let item = g.get("item");
				let name = data_name(data, "item", &item);
				idx.add("item", &item, name.as_deref(), WORLD_DATA);
			}
		}
	}
	for (kind, table) in [("npc", &data.npcs), ("object", &data.objects), ("item", &data.items)] {
		if !table.truthy() {
			continue;
		}
		for rec in table.values() {
			if rec.truthy() {
				if let Some(n) = str_(&rec.get("name")) {
					if js_trim(n).chars().any(|c| c == ' ' || c == '\'' || c == '’') {
						idx.add(kind, &V::Num(rec.get("id").num()), Some(n), WORLD_DATA);
					}
				}
			}
		}
	}
	let mut abilities = NameIndex::new(common.clone());
	for (name, id) in spell_names(data) {
		let target = if name.contains(' ') || name.chars().any(|c| c == '\'' || c == '’' || c == ':') { &mut idx } else { &mut abilities };
		target.add("spell", &V::Num(id), Some(&name), WORLD_SPELL);
	}
	idx.finish();
	abilities.finish();
	(idx, abilities)
}

/// The number a JS relational comparison reads (`z.type >= 2`).
fn js_num(v: &V) -> f64 {
	match v {
		V::Num(n) => *n,
		V::Str(s) => str_to_num(s),
		V::Bool(b) => *b as i32 as f64,
		V::Null => 0.0,
		_ => f64::NAN,
	}
}

/// Spell names the client gives by id: [(name, id)], each name once (its lowest id), cached in `data.memo`.
fn spell_names(data: &Data) -> Vec<(String, f64)> {
	let cached = data.memo.borrow().get(MEMO_SPELLS).cloned();
	let v = match cached {
		Some(v) => v,
		None => {
			let v: V = read_spell_names(data).into_iter().map(|(n, id)| arr![V::from(n), V::Num(id)]).collect::<Vec<V>>().into();
			data.memo.borrow_mut().insert(MEMO_SPELLS, v.clone());
			v
		}
	};
	v.items().iter().map(|p| (p.at(0).to_js_string(), p.at(1).num())).collect()
}

/// `readSpellNames(data)`: from the Forever SpellName table of the data's own client build.
#[cfg(feature = "native")]
pub fn read_spell_names(data: &Data) -> Vec<(String, f64)> {
	use std::fs;
	let Some(dir) = data.dir.as_ref().and_then(|_| pinned_build_dir(data, &["SpellName.csv", "SkillLineAbility.csv"])) else { return Vec::new() };
	let csv = |file: &std::path::Path| -> Vec<V> {
		let text = fs::read_to_string(file).unwrap_or_else(|e| panic!("{}: {e}", file.display()));
		crate::areas::parse_csv(&text).unwrap_or_else(|e| panic!("{e}"))
	};
	let abilities: FxHashSet<i64> = csv(&dir.join("SkillLineAbility.csv")).iter().map(|r| r.get("Spell").num()).filter(|n| is_integer(*n)).map(|n| n as i64).collect();
	let mut taken: FxHashSet<String> = FxHashSet::default();
	for t in [&data.npcs, &data.objects, &data.items, &data.zones] {
		if !t.truthy() {
			continue;
		}
		for x in t.values() {
			if x.truthy() {
				if let Some(n) = str_(&x.get("name")) {
					taken.insert(js_trim(n).to_lowercase());
				}
			}
		}
	}
	if data.quests.truthy() {
		for q in data.quests.values() {
			if q.truthy() {
				if let Some(t) = str_(&q.get("title")) {
					taken.insert(js_trim(t).to_lowercase());
				}
			}
		}
	}
	for f in data.factions.values() {
		if f.truthy() {
			if let Some(n) = str_(&f.get("name")) {
				taken.insert(js_trim(n).to_lowercase());
			}
		}
	}
	let factions = dir.join("Faction.csv");
	if factions.exists() {
		for r in csv(&factions) {
			if let Some(n) = str_(&r.get("Name_lang")) {
				taken.insert(js_trim(n).to_lowercase());
			}
		}
	}
	if data.areas.truthy() {
		for key in data.areas.get("byName").keys() {
			taken.insert(key.to_string());
		}
	}
	let mut best: Vec<(String, f64)> = Vec::new();
	let mut pos: FxHashMap<String, usize> = FxHashMap::default();
	for r in csv(&dir.join("SpellName.csv")) {
		let id = r.get("ID").num();
		let nl = r.get("Name_lang");
		let raw = if nl.truthy() { nl.to_js_string() } else { String::new() };
		let name = js_trim(&raw).to_string();
		if !is_integer(id) || name.is_empty() || junk_spell(&name) {
			continue;
		}
		if ["Apprentice ", "Journeyman ", "Expert ", "Artisan ", "Master "].iter().any(|p| name.starts_with(p)) || name.ends_with(" Reputation") || taken.contains(&name.to_lowercase()) {
			continue;
		}
		if !name.chars().any(|c| c == ' ' || c == '\'' || c == '’' || c == ':') && !abilities.contains(&(id as i64)) {
			continue;
		}
		match pos.get(&name) {
			Some(&p) => {
				if id < best[p].1 {
					best[p].1 = id;
				}
			}
			None => {
				pos.insert(name.clone(), best.len());
				best.push((name, id));
			}
		}
	}
	best
}

#[cfg(not(feature = "native"))]
pub fn read_spell_names(_data: &Data) -> Vec<(String, f64)> {
	Vec::new()
}

/// /[()[\]<>_]|\b(OLD|DND|TEST|Test|QA|zz)\b|^\d/
#[cfg(feature = "native")]
fn junk_spell(name: &str) -> bool {
	if name.chars().any(|c| matches!(c, '(' | ')' | '[' | ']' | '<' | '>' | '_')) || name.chars().next().is_some_and(|c| c.is_ascii_digit()) {
		return true;
	}
	let cs: Vec<char> = name.chars().collect();
	for w in ["OLD", "DND", "TEST", "Test", "QA", "zz"] {
		let n = w.len();
		for s in 0..cs.len() {
			if s + n <= cs.len() && cs[s..s + n].iter().copied().eq(w.chars()) && (s == 0 || !ascii_word(cs[s - 1])) && !cs.get(s + n).is_some_and(|c| ascii_word(*c)) {
				return true;
			}
		}
	}
	false
}

/// The Forever client build folder the data was built from, when it holds every file of `files`.
#[cfg(feature = "native")]
fn pinned_build_dir(data: &Data, files: &[&str]) -> Option<std::path::PathBuf> {
	let sources = if data.meta.truthy() { data.meta.get("sources") } else { V::Undef };
	let src = or_empty(&sources).into_iter().find(|x| x.truthy() && x.get("name").to_js_string().starts_with("World of Warcraft: Forever client tables"))?;
	let rev = src.get("revision");
	let rev = if rev.truthy() { rev.to_js_string() } else { String::new() };
	static RE: LazyLock<regex::Regex> = LazyLock::new(|| class_re(r"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"));
	let m = RE.find(&rev)?;
	let dir = path_join(data.dir.as_deref()?, &["..", "sources", "wago", m.as_str()]);
	files.iter().all(|f| dir.join(f).exists()).then_some(dir)
}

/// node's `path.join` (lexical normalisation).
#[cfg(feature = "native")]
fn path_join(base: &str, parts: &[&str]) -> std::path::PathBuf {
	let joined = std::iter::once(base).chain(parts.iter().copied()).filter(|p| !p.is_empty()).collect::<Vec<_>>().join("/");
	let abs = joined.starts_with('/');
	let mut out: Vec<&str> = Vec::new();
	for c in joined.split('/') {
		match c {
			"" | "." => {}
			".." => {
				if out.last().is_some_and(|l| *l != "..") {
					out.pop();
				} else if !abs {
					out.push("..");
				}
			}
			c => out.push(c),
		}
	}
	let s = out.join("/");
	std::path::PathBuf::from(if abs {
		format!("/{s}")
	} else if s.is_empty() {
		".".to_string()
	} else {
		s
	})
}

/// The id a spell's name is written with in texts ({spell:id}), or None when texts keep that name as words.
pub fn spell_id_of(data: &Data, name: &str) -> Option<f64> {
	let n = js_trim(name);
	spell_names(data).into_iter().find(|(s, _)| s == n).map(|(_, id)| id).filter(|id| *id != 0.0)
}

fn first_words(data: &Data) -> FxHashMap<String, usize> {
	let mut names: FxHashMap<String, FxHashSet<String>> = FxHashMap::default();
	if data.npcs.truthy() {
		for rec in data.npcs.values() {
			let words = if rec.truthy() { str_(&rec.get("name")).map(split_ws).unwrap_or_default() } else { Vec::new() };
			if words.is_empty() {
				continue;
			}
			names.entry(words[0].clone()).or_default().insert(words.join(" "));
		}
	}
	names.into_iter().map(|(w, s)| (w, s.len())).collect()
}

fn other_names(data: &Data) -> FxHashSet<String> {
	let mut set = FxHashSet::default();
	for t in [&data.objects, &data.items, &data.zones] {
		if !t.truthy() {
			continue;
		}
		for x in t.values() {
			if x.truthy() {
				if let Some(n) = str_(&x.get("name")) {
					set.insert(js_trim(n).to_lowercase());
				}
			}
		}
	}
	if data.quests.truthy() {
		for q in data.quests.values() {
			if q.truthy() {
				if let Some(t) = str_(&q.get("title")) {
					set.insert(js_trim(t).to_lowercase());
				}
			}
		}
	}
	for f in data.factions.values() {
		if f.truthy() {
			if let Some(n) = str_(&f.get("name")) {
				set.insert(js_trim(n).to_lowercase());
			}
		}
	}
	if data.areas.truthy() {
		for key in data.areas.get("byName").keys() {
			set.insert(key.to_string());
		}
	}
	for (name, _) in spell_names(data) {
		set.insert(name.to_lowercase());
	}
	set
}

/// The { id, name } of each NPC goals name.
fn npcs_of(goals: &[V], data: &Data) -> Vec<(f64, String)> {
	let mut out = Vec::new();
	for goal in goals {
		for n in goal_names(goal, data) {
			if n.kind == "npc" {
				out.push((n.id, n.name));
			}
		}
	}
	out
}

/// The AreaTable areas inside the zone whose area is `zone_area`.
fn areas_in(data: &Data, ctx: &mut Ctx, zone_area: f64) -> Vec<V> {
	ctx.zone_areas
		.entry(zone_area as i64)
		.or_insert_with(|| {
			let mut list = Vec::new();
			for a in data.areas.get("byId").values() {
				let id = a.get("id");
				if id.as_num() != Some(zone_area) && within(data, &id, zone_area) {
					list.push(a);
				}
			}
			list
		})
		.clone()
}

fn guide_index(guide: &V, data: &Data, common: &Rc<FxHashSet<String>>, ctx: &mut Ctx) -> NameIndex {
	let mut idx = NameIndex::new(common.clone());
	let mut zones: Vec<f64> = Vec::new();
	let add_zone = |zones: &mut Vec<f64>, z: f64| {
		if !zones.contains(&z) {
			zones.push(z);
		}
	};
	if let Some(z) = int_of(&guide.get("zone")) {
		add_zone(&mut zones, z);
	}
	for r in or_empty(&guide.get("reward")) {
		if !r.truthy() {
			continue;
		}
		if is_int(&r.get("item")) {
			idx.add("item", &r.get("item"), r.get("itemName").as_str(), GUIDE);
		}
		if is_int(&r.get("spell")) {
			idx.add("spell", &r.get("spell"), r.get("spellName").as_str(), GUIDE);
		}
	}
	let steps = or_empty(&guide.get("steps"));
	let mut all_goals = Vec::new();
	for step in &steps {
		for goal in or_empty(&step.get("goals")) {
			for n in goal_names(&goal, data) {
				idx.add(n.kind, &V::Num(n.id), Some(&n.name), GUIDE);
			}
			if let Some(m) = int_of(&goal.get("map")) {
				add_zone(&mut zones, m);
			}
			all_goals.push(goal);
		}
	}
	idx.add_firsts(&npcs_of(&all_goals, data), GUIDE, ctx);
	for id in &zones {
		let name = data_name(data, "zone", &V::Num(*id));
		idx.add("zone", &V::Num(*id), name.as_deref(), GUIDE);
	}
	if data.areas.truthy() {
		for id in &zones {
			let z = data.zone(&V::Num(*id));
			if z.truthy() {
				if let Some(za) = int_of(&z.get("areaId")) {
					for a in areas_in(data, ctx, za) {
						idx.add("area", &a.get("id"), a.get("name").as_str(), ZONE_AREA);
					}
				}
			}
		}
	}
	idx.finish();
	idx
}

fn step_index(step: &V, data: &Data, common: &Rc<FxHashSet<String>>, ctx: &Ctx) -> NameIndex {
	let mut idx = NameIndex::new(common.clone());
	let goals = or_empty(&step.get("goals"));
	for goal in &goals {
		for n in goal_names(goal, data) {
			idx.add(n.kind, &V::Num(n.id), Some(&n.name), STEP);
		}
	}
	idx.add_firsts(&npcs_of(&goals, data), STEP, ctx);
	idx.finish();
	idx
}

/// A name `tokenise_text` used: an author's token (`author`, `name` None) or a replaced name.
#[derive(Clone, Debug)]
pub struct Used {
	pub kind: &'static str,
	pub id: f64,
	pub name: Option<String>,
	pub author: bool,
	pub prio: usize,
	/// The token's English for a name matched without its "The"/"City" or by its first name.
	pub alias: Option<String>,
}

#[derive(Clone, Debug)]
pub struct Plural {
	pub kind: &'static str,
	pub id: f64,
	pub name: String,
	pub english: String,
}

pub struct Tokenised {
	pub text: String,
	pub used: Vec<Used>,
	pub plurals: Vec<Plural>,
}

enum Part {
	Plain(Vec<u16>),
	Tok { token: String, name: Option<String>, used: Used },
}

/// text -> { text, used, plurals }: the names `indexes` know replaced by tokens, where `accept(entry)` allows;
/// tokens already in the text are kept (and listed, `author`); `plurals`: names that stand there in their
/// English plural.
pub fn tokenise_text(text: &str, indexes: &[Ix], accept: &mut dyn FnMut(&Entry) -> bool) -> Tokenised {
	let t = u16s(text);
	let mut parts: Vec<Part> = Vec::new();
	let mut plurals = Vec::new();
	let mut i = 0;
	let mut plain: Vec<u16> = Vec::new();
	let flush = |parts: &mut Vec<Part>, plain: &mut Vec<u16>| {
		if !plain.is_empty() {
			parts.push(Part::Plain(std::mem::take(plain)));
		}
	};
	while i < t.len() {
		let ch = t[i];
		if ch == b'{' as u16 {
			if let Some((kind, digits, len)) = token_at16(&t, i) {
				flush(&mut parts, &mut plain);
				parts.push(Part::Tok { token: format!("{{{kind}:{digits}}}"), name: None, used: Used { kind, id: str_to_num(&digits), name: None, author: true, prio: 0, alias: None } });
				i += len;
				continue;
			}
		}
		if !unit_word(if i == 0 { None } else { Some(t[i - 1]) }) {
			let e = longest_at(indexes, &t, i, false);
			if let Some(e) = &e {
				if accept(e) {
					flush(&mut parts, &mut plain);
					parts.push(Part::Tok {
						token: format!("{{{}:{}}}", e.kind, num_str(e.id)),
						name: Some(e.name.clone()),
						used: Used { kind: e.kind, id: e.id, name: Some(e.name.clone()), author: false, prio: e.prio.floor() as usize, alias: if e.alias { Some(e.english.clone()) } else { None } },
					});
					i += e.name16.len();
					continue;
				}
			}
			let pl = if e.is_none() { longest_at(indexes, &t, i, true) } else { None };
			if let Some(pl) = pl {
				plurals.push(Plural { kind: pl.kind, id: pl.id, name: pl.name.clone(), english: pl.english.clone() });
				let n = pl.name16.len() + 1;
				plain.extend_from_slice(&t[i..(i + n).min(t.len())]);
				i += n;
				continue;
			}
		}
		plain.push(ch);
		i += 1;
	}
	flush(&mut parts, &mut plain);
	// Two names a space apart are one name the data lacks: both stay words.
	let mut k = 0;
	while k + 2 < parts.len() {
		let names = match (&parts[k], &parts[k + 1], &parts[k + 2]) {
			(Part::Tok { name: Some(a), .. }, Part::Plain(sp), Part::Tok { name: Some(b), .. }) if sp.as_slice() == [b' ' as u16] => Some((a.clone(), b.clone())),
			_ => None,
		};
		if let Some((a, b)) = names {
			parts[k] = Part::Plain(u16s(&a));
			parts[k + 2] = Part::Plain(u16s(&b));
		}
		k += 1;
	}
	let mut out: Vec<u16> = Vec::new();
	let mut used = Vec::new();
	for p in parts {
		match p {
			Part::Plain(s) => out.extend(s),
			Part::Tok { token, used: u, .. } => {
				out.extend(token.encode_utf16());
				used.push(u);
			}
		}
	}
	Tokenised { text: String::from_utf16_lossy(&out), used, plurals }
}

/// `TOKEN_RE` at UTF-16 unit `i`: (kind, digits, unit length).
fn token_at16(t: &[u16], i: usize) -> Option<(&'static str, String, usize)> {
	let end = t[i..].iter().position(|u| *u == b'}' as u16).map(|p| i + p + 1)?;
	let s = String::from_utf16(&t[i..end]).ok()?;
	let (kind, digits, len) = token_at(&s, 0)?;
	(len == s.len()).then(|| (kind, digits.to_string(), end - i))
}

/// Whether a goal's note only names the goal itself.
fn self_note(goal: &V, data: &Data) -> bool {
	let note = goal.get("note");
	let Some(note) = str_(&note).map(js_trim) else { return false };
	goal_names(goal, data).iter().any(|n| n.own && js_trim(&n.name) == note) || str_(&goal.get("from")).is_some_and(|f| f == note)
}

fn key_of(kind: &str, id: f64) -> String {
	format!("{kind}:{}", num_str(id))
}

/// guides (compiled, English) -> { guides, stats, problems, aliases }: copies whose prose carries tokens, `names`
/// and `written`, with self-naming notes dropped, each with `_plurals` (hidden). The originals are left as
/// they are. problems: [{ guide (the original V), line, message }].
pub fn tokenise_guides(guides: &[V], data: &Data) -> V {
	let common = Rc::new(common_words(guides));
	let (world, abilities) = world_index(data, &common);
	let mut ctx = Ctx { first_words: first_words(data), other_names: other_names(data), zone_areas: FxHashMap::default() };
	let replaced = Obj::new();
	for k in KINDS {
		replaced.set(k, 0);
	}
	let by_source = Obj::new();
	for k in SOURCES {
		by_source.set(k, 0);
	}
	let mut dropped = 0usize;
	let bump = |o: &Obj, k: &str| o.set(k, o.get(k).num() + 1.0);
	let problems = Arr::new();
	let aliases = Arr::new();
	let mut out = Vec::new();
	for guide in guides {
		let base = guide_index(guide, data, &common, &mut ctx);
		let cat = guide.get("category");
		let ab = if matches!(cat.as_str(), Some("Class" | "Professions")) { Ix::Plain(&abilities) } else { Ix::Cast(&abilities) };
		let worlds = [Ix::Plain(&world), ab];
		let copy = guide.as_obj().unwrap().spread();
		let steps_copy: Vec<V> = guide
			.get("steps")
			.items()
			.iter()
			.map(|s| {
				let sc = s.as_obj().unwrap().spread();
				let goals: Vec<V> = s.get("goals").items().iter().map(|g| V::Obj(g.as_obj().unwrap().spread())).collect();
				sc.set("goals", goals);
				V::Obj(sc)
			})
			.collect();
		copy.set("steps", steps_copy);
		for k in GUIDE_LISTS {
			let l = copy.get(k);
			if l.is_arr() {
				copy.set(k, l.items());
			}
		}
		let rw = copy.get("reward");
		if rw.is_arr() {
			copy.set(
				"reward",
				rw.items()
					.iter()
					.map(|r| match r.as_obj() {
						Some(o) => V::Obj(o.spread()),
						None => V::Obj(Obj::new()),
					})
					.collect::<Vec<V>>(),
			);
		}
		let copy = V::Obj(copy);
		let mut names: FxHashMap<String, String> = FxHashMap::default();
		let plurals = Obj::new();
		let mut seen: FxHashMap<String, String> = FxHashMap::default();
		let mut written: FxHashMap<String, String> = FxHashMap::default();
		let gid = guide.get("id");
		let mut replace = |text: &str, holder: &V, key: &TextKey, indexes: &[Ix], ln: f64, names: &mut FxHashMap<String, String>| {
			let mut r = tokenise_text(text, indexes, &mut |e: &Entry| {
				let k = key_of(e.kind, e.id);
				names.entry(k).or_insert_with(|| if e.next.is_some() { e.english.clone() } else { e.name.clone() });
				true
			});
			for u in &r.used {
				let k = key_of(u.kind, u.id);
				if u.author && !names.contains_key(&k) {
					if let Some(n) = data_name(data, u.kind, &V::Num(u.id)) {
						names.insert(k, n);
					}
				}
			}
			if seen.get(&r.text).is_some_and(|s| *s != fill_tokens_map(text, names)) {
				r = tokenise_text(text, indexes, &mut |e: &Entry| {
					if e.next.is_some() {
						return false;
					}
					let k = key_of(e.kind, e.id);
					*names.entry(k).or_insert_with(|| e.name.clone()) == e.name
				});
			}
			for u in &r.used {
				let k = key_of(u.kind, u.id);
				let name = match u.name.clone().filter(|n| !n.is_empty()).or_else(|| data_name(data, u.kind, &V::Num(u.id))) {
					Some(n) => n,
					None => {
						problems.push(obj! { "guide" => guide.clone(), "line" => V::Num(ln), "message" => format!("{{{k}}}: the data has no {} {}", u.kind, num_str(u.id)) });
						continue;
					}
				};
				if !u.author {
					bump(&replaced, u.kind);
					bump(&by_source, SOURCES[u.prio]);
					if let Some(al) = &u.alias {
						aliases.push(obj! { "guide" => gid.clone(), "line" => V::Num(ln), "words" => name.clone(), "token" => k.clone(), "english" => al.clone(), "text" => text });
					}
				}
				names.entry(k).or_insert(name);
			}
			set_at(holder, key, V::from(r.text.as_str()));
			let english = fill_tokens_map(text, names);
			seen.insert(r.text.clone(), english.clone());
			if fill_tokens_map(&r.text, names) != english {
				written.insert(r.text.clone(), english);
			}
			if !r.plurals.is_empty() {
				let list = plurals.get(&r.text);
				let list = if list.is_arr() { list.items() } else { Vec::new() };
				let mut list = list;
				for p in &r.plurals {
					list.push(obj! { "kind" => p.kind, "id" => V::Num(p.id), "name" => p.name.clone(), "english" => p.english.clone() }.into());
				}
				plurals.set(&r.text, list);
			}
			for pl in &r.plurals {
				let k = key_of(pl.kind, pl.id);
				if !names.contains_key(&k) && !pl.english.is_empty() {
					names.insert(k, pl.english.clone());
				}
			}
		};
		let ast = guide.hidden("_ast");
		let guide_line = {
			let l = if ast.truthy() { ast.get("line") } else { ast.clone() };
			if l.truthy() {
				l.num()
			} else {
				0.0
			}
		};
		let line_or = |v: V, d: f64| if v.truthy() { v.num() } else { d };
		{
			let gi: Vec<Ix> = std::iter::once(Ix::Plain(&base)).chain(worlds).collect();
			let mut texts: Vec<(String, V, TextKey)> = Vec::new();
			// forEachText reads each field when it reaches it; replace writes only the field it was given.
			for_each_text(&copy, false, &mut |text, holder, key, _, _| texts.push((text.to_string(), holder.clone(), key.clone())));
			for (text, holder, key) in texts {
				replace(&text, &holder, &key, &gi, guide_line, &mut names);
			}
		}
		let orig_steps = guide.get("steps").items();
		for (si, step) in copy.get("steps").items().iter().enumerate() {
			let orig = &orig_steps[si];
			let sidx = step_index(orig, data, &common, &ctx);
			let indexes: Vec<Ix> = [Ix::Plain(&sidx), Ix::Plain(&base)].into_iter().chain(worlds).collect();
			let step_line = line_or(orig.hidden("_line"), guide_line);
			for f in STEP_FIELDS {
				let v = step.get(f);
				if let Some(s) = str_(&v) {
					replace(s, step, &TextKey::Field(f), &indexes, step_line, &mut names);
				}
			}
			let orig_goals = orig.get("goals").items();
			for (gi, goal) in step.get("goals").items().iter().enumerate() {
				let og = &orig_goals[gi];
				if self_note(og, data) {
					goal.as_obj().unwrap().delete("note");
					dropped += 1;
				}
				let ln = line_or(og.hidden("_line"), step_line);
				for f in goal_fields(goal) {
					let v = goal.get(f);
					if let Some(s) = str_(&v) {
						replace(s, goal, &TextKey::Field(f), &indexes, ln, &mut names);
					}
				}
			}
		}
		if !names.is_empty() {
			let mut keys: Vec<&String> = names.keys().collect();
			keys.sort_by(|a, b| cmp_utf16(a, b));
			let o = Obj::new();
			for k in keys {
				o.set(k, names[k].as_str());
			}
			copy.set("names", o);
		}
		if !written.is_empty() {
			let mut keys: Vec<&String> = written.keys().collect();
			keys.sort_by(|a, b| cmp_utf16(a, b));
			let o = Obj::new();
			for k in keys {
				o.set(k, written[k].as_str());
			}
			copy.set("written", o);
		}
		copy.set_hidden("_ast", ast);
		copy.set_hidden("_plurals", plurals);
		out.push(copy);
	}
	let stats = obj! { "replaced" => replaced, "bySource" => by_source, "dropped" => dropped };
	obj! { "guides" => out, "stats" => stats, "problems" => problems, "aliases" => aliases }.into()
}
