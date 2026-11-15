//! Port of tools/lib/dsl/when.js.
//! `when` on a step (docs/GUIDE_FORMAT.md, "Conditions checked during play"):
//! the step applies only while each of its predicates holds when the route
//! reaches it. The addon checks them (addon/Polestar/Core/Engine.lua,
//! Own.whenFails) and keeps the outcome once the route has moved past the step.
//!
//! parse_when(rest) -> Ok(value) | Err(WhenError { error, hint })
//!   rest: the line after `when`, as written. One predicate per `when` line
//!   (see the JS source for the list).
//! value = { k, neg?, op?, n?, frac?, q?, item?, spell?, name?, label?, faction?, standing?, points? }; `q` is a list for onquest.

use crate::js::{str_to_num, V};
use crate::lexer::{is_js_space, js_trim, RE_DOT, RE_NWS, RE_WS};
use crate::money::read_money;
use crate::obj;
use crate::re;
use crate::xp::level_point;

pub const KINDS: [&str; 19] =
	["level", "money", "onquest", "complete", "turnedin", "available", "has", "upgrade", "zone", "subzone", "bound", "dungeon", "done", "skill", "cooldown", "group", "knows", "rep", "buff"];
/// The standings, as the `rep` goal and predicate name them (1 Hated .. 8 Exalted).
pub const STANDINGS: [(&str, f64); 8] = [("hated", 1.0), ("hostile", 2.0), ("unfriendly", 3.0), ("neutral", 4.0), ("friendly", 5.0), ("honored", 6.0), ("revered", 7.0), ("exalted", 8.0)];

/// A standing as written, and the points into it (0: none written).
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Standing {
	pub value: f64,
	pub points: f64,
}

/// "Revered", "7", "Revered+12000" -> Some(Ok(standing)) | Some(Err(error)) | None (not a standing at all).
/// Points count from the start of the standing (the reputation bar's own number).
pub fn read_standing_text(text: &str) -> Option<Result<Standing, String>> {
	let m = re!(r"^([A-Za-z]+|[0-9]+)(?:\+([0-9]+))?$").captures(text)?;
	let word = m[1].to_lowercase();
	let value = if let Some((_, v)) = STANDINGS.iter().find(|(k, _)| *k == word) {
		*v
	} else if is_int(&m[1]) {
		let n = str_to_num(&m[1]);
		if !(1.0..=8.0).contains(&n) {
			return Some(Err(format!("standing {} is out of range (1-8, or Hated..Exalted)", &m[1])));
		}
		n
	} else {
		return None;
	};
	let Some(p) = m.get(2) else {
		return Some(Ok(Standing { value, points: 0.0 }));
	};
	let points = str_to_num(p.as_str());
	if points < 1.0 {
		return Some(Err("points inside a standing start at 1: write the standing alone for its start".into()));
	}
	if value == 8.0 && points > 999.0 {
		return Some(Err("Exalted has 999 points at most".into()));
	}
	Some(Ok(Standing { value, points }))
}
const QUEST_ONE: [&str; 4] = ["complete", "turnedin", "available", "group"];
/// The predicates that name a place.
pub const PLACE: [&str; 3] = ["zone", "subzone", "bound"];
const USAGE: &str = "predicates: level<N, level>=N, money>=1s, [!]onquest <quest>, [!]complete <quest>, [!]turnedin <quest>, [!]available <quest>, [!]has <item> [xN], [!]upgrade <item>, [!]zone \"<Name>\", [!]subzone \"<Name>\", [!]bound \"<Location>\", [!]dungeon \"<Name>\", [!]done <label>, [!]skill <Profession> <N>, [!]cooldown item <item>, [!]cooldown spell <spell>, [!]group <quest>, [!]knows <spell>, [!]rep <Faction> <Standing>[+<points>], [!]buff <spell>";

#[derive(Clone, Debug, PartialEq)]
pub struct WhenError {
	pub error: String,
	pub hint: Option<String>,
}

fn fail(error: impl Into<String>) -> Result<V, WhenError> {
	Err(WhenError { error: error.into(), hint: None })
}

fn is_int(s: &str) -> bool {
	!s.is_empty() && s.bytes().all(|b| b.is_ascii_digit())
}

/// A step label, as parse.rs reads `label <name>`.
pub fn is_label(s: &str) -> bool {
	!s.is_empty() && s.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_' || b == b'-')
}

/// `s.replace(/\\(["\\])/g, '$1')`.
pub(crate) fn unescape(s: &str) -> String {
	let mut out = String::with_capacity(s.len());
	let mut it = s.chars().peekable();
	while let Some(c) = it.next() {
		if c == '\\' && matches!(it.peek(), Some('"') | Some('\\')) {
			out.push(it.next().unwrap());
		} else {
			out.push(c);
		}
	}
	out
}

/// A name written quoted or bare: `"Razor Hill"` or `Razor Hill`.
fn name_of(text: &str) -> Option<String> {
	let t = js_trim(text);
	if let Some(q) = re!(r#"^"((?:[^"\\]|\\{RE_DOT})*)"$"#).captures(t) {
		return Some(js_trim(&unescape(&q[1])).to_string());
	}
	if t.contains('"') {
		None
	} else {
		Some(t.to_string())
	}
}

pub fn parse_when(rest: &str) -> Result<V, WhenError> {
	let text = js_trim(rest);
	if text.is_empty() {
		return Err(WhenError { error: "`when` needs a predicate".into(), hint: Some(USAGE.into()) });
	}
	if let Some(lv) = re!(r"^(!?)(?i:level){RE_WS}*(<=|>=|<|>){RE_WS}*([0-9]+(?:\.[0-9]+|\+[0-9]+)?)$").captures(text) {
		if !lv[1].is_empty() {
			return fail("`level` takes no `!`: turn the comparison around (`level>=10` for \"not below 10\")");
		}
		let p = match level_point(&lv[3]) {
			Ok(p) => p,
			Err(e) => return fail(e),
		};
		if p.level < 1.0 || p.level > 60.0 {
			return fail(format!("level {} is out of range (1-60)", crate::js::num_str(p.level)));
		}
		let value = obj! { "k" => "level", "op" => &lv[2], "n" => p.level };
		if let Some(f) = p.frac {
			value.set("frac", f);
		}
		return Ok(V::Obj(value));
	}
	if let Some(mo) = re!(r"^(!?)(?i:money){RE_WS}*(<=|>=|<|>){RE_WS}*({RE_NWS}+)$").captures(text) {
		if !mo[1].is_empty() {
			return fail("`money` takes no `!`: turn the comparison around (`money<1s` for \"not 1s or more\")");
		}
		let Some(n) = read_money(&mo[3]) else {
			return fail(format!("malformed amount \"{}\" (expected copper or 1g50s / 7s / 25c)", &mo[3]));
		};
		return Ok(V::Obj(obj! { "k" => "money", "op" => &mo[2], "n" => n }));
	}
	// /^(!?)([A-Za-z]+)\b\s*(.*)$/
	let m = {
		let (neg, body) = match text.strip_prefix('!') {
			Some(b) => (true, b),
			None => (false, text),
		};
		let letters = body.bytes().take_while(|b| b.is_ascii_alphabetic()).count();
		let boundary = body.as_bytes().get(letters).is_none_or(|b| !(b.is_ascii_alphanumeric() || *b == b'_'));
		let tail = body[letters..].trim_start_matches(is_js_space);
		let dot_ok = !tail.contains(['\n', '\r', '\u{2028}', '\u{2029}']);
		if letters > 0 && boundary && dot_ok {
			Some((neg, &body[..letters], tail))
		} else {
			None
		}
	};
	let kind = m.map(|(_, w, _)| w.to_lowercase());
	let Some((neg, _, tail)) = m.filter(|_| kind.as_deref().is_some_and(|k| KINDS.contains(&k))) else {
		let first = text.split(is_js_space).next().unwrap_or("");
		return Err(WhenError { error: format!("unknown `when` predicate \"{first}\""), hint: Some(USAGE.into()) });
	};
	let kind = kind.unwrap();
	let args = js_trim(tail);
	let value = obj! { "k" => kind.as_str() };
	if neg {
		value.set("neg", true);
	}
	if kind == "level" {
		return fail("malformed `level` predicate (expected level<N, level<=N, level>N or level>=N)");
	}
	if kind == "money" {
		return fail("malformed `money` predicate (expected money<A, money<=A, money>A or money>=A, A as copper or 1g50s / 7s / 25c)");
	}
	if kind == "onquest" {
		let ids: Vec<&str> = re!(r"{RE_WS}*,{RE_WS}*|{RE_WS}+").split(args).filter(|s| !s.is_empty()).collect();
		if ids.is_empty() || !ids.iter().all(|id| is_int(id) && str_to_num(id) > 0.0) {
			return fail("`onquest` needs quest ids: onquest <quest>[,<quest>...]");
		}
		let mut q: Vec<f64> = Vec::new();
		for id in ids {
			let n = str_to_num(id);
			if !q.contains(&n) {
				q.push(n);
			}
		}
		value.set("q", q.into_iter().map(V::Num).collect::<Vec<V>>());
		return Ok(V::Obj(value));
	}
	if QUEST_ONE.contains(&kind.as_str()) {
		if !is_int(args) || str_to_num(args) <= 0.0 {
			return fail(format!("`{kind}` needs one quest id: {kind} <quest>"));
		}
		value.set("q", str_to_num(args));
		return Ok(V::Obj(value));
	}
	if kind == "has" {
		let h = re!(r"^([0-9]+)(?:{RE_WS}+(?i:x)([0-9]+))?$").captures(args);
		let Some(h) = h.filter(|h| str_to_num(&h[1]) > 0.0) else {
			return fail("`has` needs an item id: has <item> [xN]");
		};
		value.set("item", str_to_num(&h[1]));
		let n = h.get(2).map(|x| str_to_num(x.as_str())).unwrap_or(1.0);
		if n < 1.0 {
			return fail("`has` needs a count of 1 or more");
		}
		value.set("n", n);
		return Ok(V::Obj(value));
	}
	if kind == "upgrade" {
		if !is_int(args) || str_to_num(args) <= 0.0 {
			return fail("`upgrade` needs one item id: upgrade <item>");
		}
		value.set("item", str_to_num(args));
		return Ok(V::Obj(value));
	}
	if kind == "done" {
		if !is_label(args) {
			return fail("`done` needs a step label: done <label>");
		}
		value.set("label", args);
		return Ok(V::Obj(value));
	}
	if kind == "skill" {
		let s = re!(r#"^(?:"((?:[^"\\]|\\{RE_DOT})*)"|([^"]+?)){RE_WS}+([0-9]+)$"#).captures(args);
		let name = s.as_ref().map(|s| match s.get(1) {
			Some(q) => js_trim(&unescape(q.as_str())).to_string(),
			None => js_trim(&s[2]).to_string(),
		});
		let (Some(name), Some(s)) = (name.filter(|n| !n.is_empty()), s.as_ref()) else {
			return fail("`skill` needs a profession and a rank of 1 or more: skill <Profession> <N>");
		};
		if str_to_num(&s[3]) < 1.0 {
			return fail("`skill` needs a profession and a rank of 1 or more: skill <Profession> <N>");
		}
		value.set("name", name.as_str());
		value.set("n", str_to_num(&s[3]));
		return Ok(V::Obj(value));
	}
	if kind == "cooldown" {
		let c = re!(r"^((?i:item|spell)){RE_WS}+([0-9]+)$").captures(args);
		let Some(c) = c.filter(|c| str_to_num(&c[2]) > 0.0) else {
			return fail("`cooldown` needs an item or spell id: cooldown item <item> or cooldown spell <spell>");
		};
		value.set(&c[1].to_ascii_lowercase(), str_to_num(&c[2]));
		return Ok(V::Obj(value));
	}
	if kind == "knows" {
		if !is_int(args) || str_to_num(args) <= 0.0 {
			return fail("`knows` needs a spell id: knows <spell>");
		}
		value.set("spell", str_to_num(args));
		return Ok(V::Obj(value));
	}
	if kind == "buff" {
		if !is_int(args) || str_to_num(args) <= 0.0 {
			return fail("`buff` needs a spell id: buff <spell>");
		}
		value.set("spell", str_to_num(args));
		return Ok(V::Obj(value));
	}
	if kind == "rep" {
		let usage = "`rep` needs a faction and a standing: rep <Faction> <Standing>[+<points>] or rep <factionId> <Standing>";
		let r = re!(r#"^(?:"((?:[^"\\]|\\{RE_DOT})*)"|([^"]+?)){RE_WS}+({RE_NWS}+)$"#).captures(args);
		let faction = r.as_ref().map(|r| match r.get(1) {
			Some(q) => js_trim(&unescape(q.as_str())).to_string(),
			None => js_trim(&r[2]).to_string(),
		});
		let s = r.as_ref().and_then(|r| read_standing_text(&r[3]));
		let (Some(faction), Some(s), Some(r)) = (faction.filter(|f| !f.is_empty()), s, r.as_ref()) else {
			return Err(WhenError { error: usage.into(), hint: Some("standings: Hated, Hostile, Unfriendly, Neutral, Friendly, Honored, Revered, Exalted, or 1-8".into()) });
		};
		let s = match s {
			Ok(s) => s,
			Err(e) => return fail(e),
		};
		// Hated and up always holds: nothing stands below it.
		if s.value == 1.0 && s.points == 0.0 {
			return fail("`rep <Faction> Hated` always holds: Hated is the lowest standing");
		}
		if r.get(1).is_none() && is_int(&faction) {
			value.set("faction", str_to_num(&faction));
		} else {
			value.set("name", faction.as_str());
		}
		value.set("standing", s.value);
		if s.points > 0.0 {
			value.set("points", s.points);
		}
		return Ok(V::Obj(value));
	}
	// zone, subzone, bound, dungeon
	let Some(name) = name_of(args).filter(|n| !n.is_empty()) else {
		return fail(format!("`{kind}` needs a name: {kind} \"<{}>\"", if kind == "bound" { "Location" } else { "Name" }));
	};
	value.set("name", name.as_str());
	Ok(V::Obj(value))
}

/// The levels a `level` predicate admits, as (min, max). With `frac` the
/// predicate splits level n, so both sides admit it.
pub fn level_range(p: &V) -> (f64, f64) {
	let op = p.get("op").to_js_string();
	let n = p.get("n").num();
	if p.get("frac").truthy() {
		return if op == "<" || op == "<=" { (1.0, n) } else { (n, 60.0) };
	}
	match op.as_str() {
		"<" => (1.0, n - 1.0),
		"<=" => (1.0, n),
		">" => (n + 1.0, 60.0),
		_ => (n, 60.0),
	}
}
