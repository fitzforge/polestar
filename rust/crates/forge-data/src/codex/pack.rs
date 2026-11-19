//! tools/lib/codex/pack.js `emitPack`: the Codex -> the load-on-demand addon Polestar_Codex
//! (record strings in long Lua string literals, decoded by addon/Polestar/Lookup/Codex.lua).

use std::collections::BTreeSet;
use std::fmt::Write as _;

use forge_guide::js::{num_str, str_to_num, V};
use forge_guide::races::CLASSES;

use super::util::{kstr, math_round};

pub const SCHEMA: f64 = 1.0;
pub const ADDON: &str = "Polestar_Codex";
const CHUNK: usize = 4000;
const ITEM_KINDS: [&str; 5] = ["item", "mount", "pet", "recipe", "tabard"];
const SEARCH_KINDS: [&str; 11] = ["mount", "pet", "item", "recipe", "tabard", "quest", "npc", "rare", "instance", "zone", "treasure"];
const FILTER_VERSION: u8 = 1;
const FILTER_BYTES: usize = 5;
const SLOT_CODES: u16 = 36; // unknown + InventoryType 0..34
const MAX_CATEGORIES: usize = (4096 / SLOT_CODES as usize) - 1; // id 0 is unknown
const UNKNOWN_SUBCLASS: u8 = 255;

fn from_letter(f: &str) -> Result<char, String> {
	Ok(match f {
		"atlasloot" => 'a',
		"client" => 'c',
		"dungeons" => 'd',
		"journal" => 'j',
		"guides" => 'g',
		"curated" => 'u',
		"recordings" => 'l',
		"pfquest" => 'p',
		"questie" => 'q',
		"rarescanner" => 'r',
		"web" => 'w',
		"forever" => 'e',
		_ => return Err(format!("codex pack: unknown source provenance \"{f}\" (add it to FROM in pack.js and Codex.lua)")),
	})
}

fn source_def(ty: &str) -> Option<(char, &'static [&'static str])> {
	Some(match ty {
		"vendor" => ('v', &["npc", "cost", "limited"]),
		"drop" => ('d', &["npc", "chance", "instance"]),
		"object" => ('o', &["object", "chance"]),
		"quest" => ('q', &["quest", "choice"]),
		"gift" => ('g', &["npc", "spell"]),
		"craft" => ('c', &["spell", "skillLine", "skill"]),
		"rep" => ('r', &["faction", "standing", "npc"]),
		"pvp" => ('p', &["rank", "npc"]),
		"container" => ('n', &["item", "chance"]),
		"world" => ('w', &["minLevel", "maxLevel"]),
		_ => return None,
	})
}

/// pack.js `luaStr`.
fn lua_str(s: &str) -> String {
	let mut out = String::with_capacity(s.len() + 2);
	out.push('"');
	for c in s.chars() {
		match c {
			'\\' => out.push_str("\\\\"),
			'"' => out.push_str("\\\""),
			'\n' => out.push_str("\\n"),
			'\r' => out.push_str("\\r"),
			'\0' => out.push_str("\\0"),
			c => out.push(c),
		}
	}
	out.push('"');
	out
}

fn esc(v: &V) -> String {
	if v.is_nullish() {
		return String::new();
	}
	let s = v.to_js_string();
	let mut out = String::with_capacity(s.len());
	for c in s.chars() {
		match c {
			'%' | ';' | ',' | '~' | '\t' | '\n' | '\r' => out.push_str(&format!("%{:02X}", c as u32)),
			c => out.push(c),
		}
	}
	out
}

fn lua_blob(s: &str) -> String {
	let mut out = String::with_capacity(s.len() + 16);
	out.push('"');
	for c in s.chars() {
		match c {
			'\\' => out.push_str("\\\\"),
			'"' => out.push_str("\\\""),
			'\n' => out.push_str("\\n"),
			'\r' => out.push_str("\\r"),
			'\t' => out.push_str("\\t"),
			'\0' | '\x01' | '\x02' => out.push_str(&format!("\\{:03}", c as u32)),
			c => out.push(c),
		}
	}
	out.push('"');
	out
}

/// Lua short-string literal for arbitrary bytes, independent of source encoding.
fn lua_bytes(bytes: &[u8]) -> String {
	let mut out = String::with_capacity(bytes.len() * 4 + 2);
	out.push('"');
	for &b in bytes {
		match b {
			b'\\' => out.push_str("\\\\"),
			b'"' => out.push_str("\\\""),
			b' '..=b'~' => out.push(char::from(b)),
			_ => write!(out, "\\{b:03}").unwrap(),
		}
	}
	out.push('"');
	out
}

fn filter_number(item: &V, field: &str, max: u16) -> Result<Option<u16>, String> {
	let value = item.get(field);
	if value.is_nullish() {
		return Ok(None);
	}
	value
		.as_num()
		.filter(|&n| (0.0..=f64::from(max)).contains(&n) && n.fract() == 0.0)
		.map(|n| Some(n as u16))
		.ok_or_else(|| format!("codex item filter: item {} has {field} = {value:?}, expected an integer in 0..={max}", item.get("id").to_js_string()))
}

fn item_category(item: &V) -> Result<Option<(u8, u8)>, String> {
	let Some(class) = filter_number(item, "itemClass", u8::MAX.into())? else { return Ok(None) };
	let subclass = filter_number(item, "itemSubclass", (UNKNOWN_SUBCLASS - 1).into())?;
	Ok(Some((class as u8, subclass.map_or(UNKNOWN_SUBCLASS, |n| n as u8))))
}

fn filter_source(item: &V, field: &str) -> u16 {
	match item.get(field).as_str() {
		Some("client") => 1,
		Some("forever") => 2,
		Some("era") => 3,
		_ => 0,
	}
}

/// Five bytes per Index row, little-endian within each group:
/// - 24 bits: 7 required level, 7 item level (127 = unknown), 10 class mask (512 = unknown).
///   Class bits 0..8 follow CLASSES: Warrior, Paladin, Hunter, Rogue, Priest, Shaman, Mage,
///   Warlock, Druid. The decoder expands them back to the client's sparse mask.
/// - 16 bits: 12 for categoryId * 36 + slotCode (0 = unknown, 1..35 = InventoryType + 1),
///   then 2 levelsSource and 2 typeSource. The mixed radix fits slot and category in one
///   fewer bit, so one Lua string.byte call reads the row and no sixth byte is needed.
fn encode_filter(item: &V, categories: &[(u8, u8)]) -> Result<[u8; FILTER_BYTES], String> {
	let req = filter_number(item, "reqLevel", 126)?.unwrap_or(127);
	let ilvl = filter_number(item, "itemLevel", 126)?.unwrap_or(127);
	let mask = filter_number(item, "allowClass", u16::MAX)?.map_or(512, |mask| CLASSES.iter().enumerate().filter(|(_, class)| mask & class.bit as u16 != 0).map(|(i, _)| 1 << i).sum::<u16>());
	let slot = filter_number(item, "slot", 34)?.map_or(0, |n| n + 1);
	let category = item_category(item)?.map_or(0, |pair| (categories.binary_search(&pair).expect("category collected from Index rows") + 1) as u16);
	let levels = u32::from(req) | (u32::from(ilvl) << 7) | (u32::from(mask) << 14);
	let type_and_sources = (category * SLOT_CODES + slot) | (filter_source(item, "levelsSource") << 12) | (filter_source(item, "typeSource") << 14);
	let [a, b, c, _] = levels.to_le_bytes();
	let [d, e] = type_and_sources.to_le_bytes();
	Ok([a, b, c, d, e])
}

fn one_line(v: &V) -> String {
	let s = if v.is_nullish() { String::new() } else { v.to_js_string() };
	s.replace(['\t', '\n', '\r'], " ")
}

/// pack.js `foldName(name)` (Core/Search.lua's fold, byte for byte).
pub fn fold_name(name: &V) -> String {
	let s = if name.is_nullish() { String::new() } else { name.to_js_string() };
	let mut b: Vec<u8> = s.into_bytes();
	for c in b.iter_mut() {
		c.make_ascii_lowercase();
	}
	if b.iter().any(|&c| c >= 0x80) {
		let mut out = Vec::with_capacity(b.len());
		let mut i = 0;
		while i < b.len() {
			let c = b[i];
			if matches!(c, 0xc3 | 0xc5 | 0xd0 | 0xd1) && i + 1 < b.len() && (0x80..=0xbf).contains(&b[i + 1]) {
				if let Some(r) = fold2(c, b[i + 1]) {
					out.extend_from_slice(r.as_slice());
					i += 2;
					continue;
				}
				out.push(c);
				out.push(b[i + 1]);
				i += 2;
				continue;
			}
			out.push(c);
			i += 1;
		}
		// drop ’ (e2 80 99)
		let mut o2 = Vec::with_capacity(out.len());
		let mut i = 0;
		while i < out.len() {
			if i + 2 < out.len() && out[i] == 0xe2 && out[i + 1] == 0x80 && out[i + 2] == 0x99 {
				i += 3;
				continue;
			}
			o2.push(out[i]);
			i += 1;
		}
		b = o2;
	}
	b.retain(|&c| c != b'\'');
	for c in b.iter_mut() {
		let p = *c;
		if p <= 0x1f || p == 0x7f || (b'!'..=b'/').contains(&p) || (b':'..=b'@').contains(&p) || (b'['..=b'`').contains(&p) || (b'{'..=b'~').contains(&p) {
			*c = b' ';
		}
	}
	// runs of [ \t\n\v\f\r] -> one space
	let mut out: Vec<u8> = Vec::with_capacity(b.len() + 1);
	let mut prev_space = false;
	for c in b {
		let sp = matches!(c, b' ' | b'\t' | b'\n' | 0x0b | 0x0c | b'\r');
		if sp {
			if !prev_space {
				out.push(b' ');
			}
			prev_space = true;
		} else {
			out.push(c);
			prev_space = false;
		}
	}
	if out.first() != Some(&b' ') {
		out.insert(0, b' ');
	}
	if out.last() == Some(&b' ') {
		out.pop();
	}
	let rest = if out.is_empty() { &out[..] } else { &out[1..] };
	String::from_utf8_lossy(rest).into_owned()
}

fn fold2(a: u8, b: u8) -> Option<Vec<u8>> {
	match a {
		0xc3 => {
			let t: &str = match b {
				0x80..=0x85 => "a",
				0x86 => "ae",
				0x87 => "c",
				0x88..=0x8b => "e",
				0x8c..=0x8f => "i",
				0x90 => "d",
				0x91 => "n",
				0x92..=0x96 => "o",
				0x98 => "o",
				0x99..=0x9c => "u",
				0x9d => "y",
				0x9e => "th",
				0x9f => "ss",
				0xa0..=0xa5 => "a",
				0xa6 => "ae",
				0xa7 => "c",
				0xa8..=0xab => "e",
				0xac..=0xaf => "i",
				0xb0 => "d",
				0xb1 => "n",
				0xb2..=0xb6 => "o",
				0xb8 => "o",
				0xb9..=0xbc => "u",
				0xbd => "y",
				0xbe => "th",
				0xbf => "y",
				_ => return None,
			};
			Some(t.as_bytes().to_vec())
		}
		0xc5 if b == 0x92 || b == 0x93 => Some(b"oe".to_vec()),
		0xd0 if (0x90..=0x9f).contains(&b) => Some(vec![0xd0, b + 0x20]),
		0xd0 if (0xa0..=0xaf).contains(&b) => Some(vec![0xd1, b - 0x20]),
		0xd0 if b == 0x81 => Some(vec![0xd0, 0xb5]),
		0xd1 if b == 0x91 => Some(vec![0xd0, 0xb5]),
		_ => None,
	}
}

fn num(v: &V) -> Result<String, String> {
	match v {
		V::Undef | V::Null => Ok(String::new()),
		V::Str(s) if s.is_empty() => Ok(String::new()),
		_ => {
			let n = v.num();
			if !n.is_finite() {
				return Err(format!("codex pack: not a number: {}", v.to_js_string()));
			}
			Ok(num_str(n))
		}
	}
}

fn list(v: &V) -> Result<String, String> {
	Ok(v.items().iter().map(num).collect::<Result<Vec<_>, _>>()?.join(","))
}

fn coord(v: &V) -> String {
	num_str(math_round(v.num() * 10.0))
}

fn from_letters(from: &V) -> Result<String, String> {
	let mut out = String::new();
	for f in from.items() {
		let c = from_letter(&f.to_js_string())?;
		if !out.contains(c) {
			out.push(c);
		}
	}
	Ok(out)
}

fn encode_source(src: &V) -> Result<String, String> {
	let ty = src.get("type").to_js_string();
	let (letter, fields) = source_def(&ty).ok_or_else(|| format!("codex pack: unknown source type \"{ty}\""))?;
	let mut parts = Vec::new();
	for f in fields {
		parts.push(match *f {
			"limited" | "choice" => {
				if src.get(f).truthy() {
					"1".into()
				} else {
					String::new()
				}
			}
			"instance" => esc(&src.get(f)),
			_ => num(&src.get(f))?,
		});
	}
	parts.push(from_letters(&src.get("from"))?);
	let requires = src.get("requiresQuests");
	let has_requires = matches!(ty.as_str(), "drop" | "object") && requires.is_arr() && !requires.is_empty();
	if has_requires {
		parts.push(esc(&V::str(&list(&requires)?)));
	}
	// An object's instance (#2883) after the requires tail (empty when there is none), so readers that
	// know only the requires tail ignore it.
	if ty == "object" && src.get("instance").truthy() {
		if !has_requires {
			parts.push(String::new());
		}
		parts.push(esc(&src.get("instance")));
	}
	Ok(format!("{letter}{}", parts.join(",")))
}

fn status_letter(rec: &V) -> &'static str {
	match rec.get("status").as_str() {
		Some("retired") => "r",
		Some("nosource") => "n",
		_ => "",
	}
}

fn encode_item(rec: &V) -> Result<String, String> {
	// Keep the legacy Lua header empty for items with no level requirement.
	let req_level = match rec.get("reqLevel") {
		V::Num(0.0) => String::new(),
		level => num(&level)?,
	};
	let mut parts = vec![
		num(&rec.get("quality"))? + status_letter(rec),
		req_level,
		num(&rec.get("spell"))?,
		num(&rec.get("repFaction"))?,
		num(&rec.get("repStanding"))?,
		num(&rec.get("reqSkill"))?,
		num(&rec.get("reqSkillRank"))?,
	];
	for s in rec.get("sources").items() {
		parts.push(encode_source(&s)?);
	}
	Ok(parts.join(";"))
}

/// A record's spawns as "map,f,x,y,x,y" groups (one per map and frame, in first-seen order), then its heights
/// field: `z` and one height per point in the groups' order ("" for a point without one), only when some point
/// has one (#1024; Lookup/Codex.lua decodeSpawns).
fn encode_spawns(spawns: &V) -> Result<Vec<String>, String> {
	let mut groups: Vec<(String, Vec<String>, Vec<String>)> = Vec::new();
	let mut any_z = false;
	for s in spawns.items() {
		let f = s.get("f");
		let fs = if f.truthy() { f.to_js_string() } else { String::new() };
		let k = format!("{}|{}", s.get("map").to_js_string(), fs);
		let i = match groups.iter().position(|(x, _, _)| *x == k) {
			Some(i) => i,
			None => {
				groups.push((k, vec![num(&s.get("map"))?, fs.clone()], Vec::new()));
				groups.len() - 1
			}
		};
		groups[i].1.push(coord(&s.get("x")));
		groups[i].1.push(coord(&s.get("y")));
		let z = num(&s.get("z"))?;
		any_z |= !z.is_empty();
		groups[i].2.push(z);
	}
	let heights = any_z.then(|| format!("z{}", groups.iter().flat_map(|(_, _, z)| z.iter().map(String::as_str)).collect::<Vec<_>>().join(",")));
	Ok(groups.into_iter().map(|(_, g, _)| g.join(",")).chain(heights).collect())
}

fn encode_npc(rec: &V) -> Result<String, String> {
	let flags = format!("{}{}{}", if rec.get("rare").truthy() { "r" } else { "" }, if rec.get("elite").truthy() { "e" } else { "" }, if rec.get("boss").truthy() { "b" } else { "" });
	let fac = rec.get("faction");
	let mut parts = vec![
		num(&rec.get("level"))?,
		num(&rec.get("levelMax"))?,
		if fac.truthy() { fac.to_js_string() } else { String::new() },
		flags,
		esc(&rec.get("instance")),
		rec.get("roles").items().iter().map(esc).collect::<Vec<_>>().join(","),
		list(&rec.get("loot"))?,
	];
	parts.extend(encode_spawns(&rec.get("spawns"))?);
	if rec.get("subName").truthy() {
		parts.push(format!("t{}", esc(&rec.get("subName"))));
	}
	Ok(parts.join(";"))
}

fn encode_object(rec: &V) -> Result<String, String> {
	let mut parts = vec![if rec.get("treasure").truthy() { "1".to_string() } else { String::new() }, list(&rec.get("loot"))?];
	parts.extend(encode_spawns(&rec.get("spawns"))?);
	if rec.get("mailbox").truthy() {
		let f = rec.get("faction");
		parts.push(format!("m{}", if f.truthy() { f.to_js_string() } else { String::new() }));
	}
	// The instance it lies in (Upper Blackrock Spire's Rookery Eggs): i<key>, last. A spawn group starts with a map
	// number, so a reader before it reads no point from it.
	if rec.get("instance").truthy() {
		parts.push(format!("i{}", esc(&rec.get("instance"))));
	}
	Ok(parts.join(";"))
}

fn encode_quest(rec: &V) -> Result<String, String> {
	let start = rec.get("start");
	let end = rec.get("end");
	let fac = rec.get("faction");
	let mut parts = vec![
		num(&rec.get("level"))?,
		num(&rec.get("minLevel"))?,
		if fac.truthy() { fac.to_js_string() } else { String::new() },
		num(&rec.get("races"))?,
		num(&rec.get("classes"))?,
		num(&rec.get("zone"))?,
		list(&start.get("npc"))?,
		list(&start.get("object"))?,
		list(&start.get("item"))?,
		list(&end.get("npc"))?,
		list(&end.get("object"))?,
		list(&rec.get("pre"))?,
		list(&rec.get("rewards"))?,
		list(&rec.get("choices"))?,
		list(&rec.get("preAny"))?,
	];
	for o in rec.get("objectives").items() {
		let ty = o.get("type");
		let t = match ty.as_str() {
			Some("kill") => 'k',
			Some("item") => 'i',
			Some("object") => 'o',
			Some("event") => 'e',
			// A talk-to objective (Hidden Enemies: Neeru Fireblade). `t` alone is the tame flag below.
			Some("talk") => 's',
			_ => return Err(format!("codex pack: quest {}: unknown objective type \"{}\"", kstr(&rec.get("id")), ty.to_js_string())),
		};
		parts.push(format!("{t}{},{},{}", num(&o.get("id"))?, num(&o.get("count"))?, esc(&o.get("text"))));
		if !(o.get("map").is_nullish() || o.get("x").is_nullish() || o.get("y").is_nullish()) {
			let f = o.get("f");
			parts.push(format!("p{},{},{},{}", num(&o.get("map"))?, coord(&o.get("x")), coord(&o.get("y")), if f.truthy() { f.to_js_string() } else { String::new() }));
		}
		if o.get("tame").truthy() {
			parts.push("t".into());
		}
		// The item the kill objective before it is really a use of (merge.rs `use_item_on`, #2468):
		// a<item>. An older reader skips it (no objective kind is a).
		let use_item = o.get("useItem");
		if use_item.truthy() {
			parts.push(format!("a{}", num(&use_item)?));
		}
		// The item that calls the kill objective's target up (merge.rs `summon_item_for`, #2326): m<item>.
		// An older reader skips it (no objective kind is m).
		let summon = o.get("summonItem");
		if summon.truthy() {
			parts.push(format!("m{}", num(&summon)?));
		}
		// The creatures that item is used on (#2578: Yeh'kinya's Bramble on a dead Vale Screecher): g<npc>,<npc>...
		// An older reader skips it (no objective kind is g).
		let on = o.get("summonOn");
		if summon.truthy() && !on.items().is_empty() {
			parts.push(format!("g{}", list(&on)?));
		}
		// The hostile elites at an object's work, per side (elites.rs): w<side><rank>,<lvl>.
		let el = o.get("elites");
		for side in ["A", "H"] {
			let e = el.get(side);
			if e.truthy() {
				let lvl = e.get("lvl");
				parts.push(format!("w{side}{},{}", num(&e.get("rank"))?, if lvl.is_nullish() { String::new() } else { num(&lvl)? }));
			}
		}
	}
	if rec.get("repFaction").truthy() && rec.get("repStanding").truthy() {
		parts.push(format!("r{},{}", num(&rec.get("repFaction"))?, num(&rec.get("repStanding"))?));
	}
	if rec.get("xp").num() > 0.0 {
		parts.push(format!("x{}", num(&rec.get("xp"))?));
	}
	// The quests whose taking closes it for good (#1996: a breadcrumb's target, an exclusive quest): c<id>,<id>...
	// An older reader skips `c` (no objective kind is c).
	if !rec.get("closedBy").items().is_empty() {
		parts.push(format!("c{}", list(&rec.get("closedBy"))?));
	}
	// The profession it needs (#1913): l<skill line>,<rank>, the rank empty when the data names none. Not `s`, the
	// talk objective: an older reader skips `l` (no objective kind is l).
	if rec.get("skill").num() > 0.0 {
		parts.push(format!("l{},{}", num(&rec.get("skill"))?, num(&rec.get("skillLevel"))?));
	}
	// A child quest's parent, which must be in the log for its giver to offer it (Valik 535 under Infiltration 533):
	// u<quest>. An older reader skips it (no objective kind is u).
	if rec.get("parent").num() > 0.0 {
		parts.push(format!("u{}", num(&rec.get("parent"))?));
	}
	// How it is done beyond its objectives, our public words (merge.rs `public_how`, #2714): h<text>. An older
	// reader skips it (no objective kind is h).
	if rec.get("how").truthy() {
		parts.push(format!("h{}", esc(&rec.get("how"))));
	}
	// Handed in at one talk, never in the log (#2686: Bloodpetal Sprouts): `d`. An older reader skips it (no objective
	// kind is d).
	if rec.get("direct").truthy() {
		parts.push("d".into());
	}
	Ok(parts.join(";"))
}

fn boss_ref(b: &V) -> Result<String, String> {
	let id = if b.get("npc").truthy() {
		num(&b.get("npc"))?
	} else if b.get("object").truthy() {
		format!("o{}", num(&b.get("object"))?)
	} else {
		String::new()
	};
	let role = b.get("role");
	let r = match role.as_str() {
		_ if !role.truthy() => "",
		Some("rare") => "r",
		Some("event") => "e",
		Some("optional") => "x",
		_ => return Err(format!("codex pack: boss {}: unknown role \"{}\"", b.get("name").to_js_string(), role.to_js_string())),
	};
	Ok(format!("{id}{r}"))
}

fn encode_instance(rec: &V) -> Result<String, String> {
	let e = rec.get("entrance");
	let ent = if e.truthy() {
		let f = e.get("f");
		let mut p = vec![num(&e.get("map"))?, coord(&e.get("x")), coord(&e.get("y")), if f.truthy() { f.to_js_string() } else { String::new() }];
		let a = e.get("A");
		if e.get("approx").truthy() || a.truthy() {
			p.push(if e.get("approx").truthy() { "a".into() } else { String::new() });
		}
		if a.truthy() {
			p.extend([num(&a.get("map"))?, coord(&a.get("x")), coord(&a.get("y"))]);
		}
		p.join(",")
	} else {
		String::new()
	};
	let mut parts = vec![esc(&rec.get("kind")), if rec.get("forever").truthy() { "1".into() } else { String::new() }, num(&rec.get("areaId"))?, num(&rec.get("map"))?, ent, list(&rec.get("levels"))?];
	for b in rec.get("bosses").items() {
		let mut p = vec![esc(&b.get("name")), boss_ref(&b)?];
		for i in b.get("items").items() {
			p.push(num(&i)?);
		}
		parts.push(p.join(","));
	}
	Ok(parts.join(";"))
}

fn encode_spell(rec: &V) -> Result<String, String> {
	Ok([esc(&rec.get("kind")), num(&rec.get("item"))?, esc(&rec.get("class"))].join(";"))
}

/// pack.js `luaValue(v, indent)`.
fn lua_value(v: &V, indent: &str) -> String {
	match v {
		V::Undef | V::Null => "nil".into(),
		V::Bool(b) => if *b { "true" } else { "false" }.into(),
		V::Num(n) => {
			if n.is_finite() {
				num_str(*n)
			} else {
				"nil".into()
			}
		}
		V::Str(s) => lua_str(s),
		V::Arr(a) => {
			let items = a.to_vec();
			if items.is_empty() {
				return "{}".into();
			}
			let inner = format!("{indent}\t");
			let body: Vec<String> = items.iter().map(|x| format!("{inner}{},", lua_value(x, &inner))).collect();
			format!("{{\n{}\n{indent}}}", body.join("\n"))
		}
		V::Obj(o) => {
			let mut keys: Vec<String> = o.entries().into_iter().filter(|(_, x)| !x.is_nullish()).map(|(k, _)| k.to_string()).collect();
			keys.sort_by(|a, b| forge_guide::js::cmp_utf16(a, b));
			if keys.is_empty() {
				return "{}".into();
			}
			let inner = format!("{indent}\t");
			let key = |k: &str| {
				let mut c = k.chars();
				if c.next().is_some_and(|f| f.is_ascii_alphabetic() || f == '_') && c.all(|x| x.is_ascii_alphanumeric() || x == '_') {
					k.to_string()
				} else {
					format!("[{}]", lua_str(k))
				}
			};
			let body: Vec<String> = keys.iter().map(|k| format!("{inner}{} = {},", key(k), lua_value(&o.get(k), &inner))).collect();
			format!("{{\n{}\n{indent}}}", body.join("\n"))
		}
	}
}

/// pack.js `sortedIds(obj)`.
fn sorted_ids(v: &V) -> Vec<String> {
	let mut keys: Vec<String> = v.keys().iter().map(|k| k.to_string()).collect();
	keys.sort_by(|a, b| {
		let (na, nb) = (str_to_num(a), str_to_num(b));
		if na.is_finite() && nb.is_finite() {
			super::util::by_num(na, nb)
		} else {
			forge_guide::js::cmp_utf16(a, b)
		}
	});
	keys
}

fn header() -> Vec<String> {
	vec![
		forge_guide::emit::header("lua", "forge data codex", "the sources listed in Meta.lua"),
		"-- Facts (ids, names, levels, coordinates, rates, relations), merged. Decoded by".into(),
		"-- Polestar/Lookup/Codex.lua.".into(),
		String::new(),
		"local C = Polestar and Polestar.Codex".into(),
		"if not (C and C.Register) then return end".into(),
		String::new(),
	]
}

/// [id, name, record|None, flags]
type Entry = (String, V, Option<String>, String);

fn emit_group(group: &str, entries: &[Entry], prefix: &str, out: &mut Vec<(String, String)>, order: &mut Vec<String>) {
	for (part, slice) in entries.chunks(CHUNK).enumerate() {
		let file = format!("{prefix}{}.lua", part + 1);
		let names: String = slice.iter().map(|(id, name, _, flags)| format!("\n{id}\t{flags}\t{}", one_line(name))).collect();
		let with_records = slice.iter().any(|(_, _, r, _)| r.is_some());
		let records = with_records.then(|| slice.iter().map(|(id, _, r, _)| r.as_ref().map(|r| format!("\n{id}\t{r}")).unwrap_or_default()).collect::<String>());
		let numeric = slice.iter().all(|(id, ..)| !id.is_empty() && id.bytes().all(|b| b.is_ascii_digit()));
		let mut args = vec![lua_str(group), lua_blob(&names), records.map(|r| lua_blob(&r)).unwrap_or_else(|| "nil".into())];
		if numeric {
			args.push(slice[0].0.clone());
			args.push(slice[slice.len() - 1].0.clone());
		}
		let mut lines = header();
		lines.push(format!("C.Register({})", args.join(", ")));
		lines.push(String::new());
		out.push((file.clone(), lines.join("\n")));
		order.push(file);
	}
}

/// The Codex parts emitPack reads.
pub struct PackCodex<'a> {
	pub items: &'a V,
	pub npcs: &'a V,
	pub objects: &'a V,
	pub quests: &'a V,
	pub instances: &'a V,
	pub zones: &'a V,
	pub factions: &'a V,
	pub spells: &'a V,
	pub meta: &'a V,
	pub frames: &'a V,
}

/// `emitPack(codex, { version, build, extraFiles })` -> [(file, text)] (TOC order, then the TOC and
/// LICENSE-DATA.txt).
pub fn emit_pack(codex: &PackCodex, version: &str, build: &V, extra_files: &[(String, String)]) -> Result<Vec<(String, String)>, String> {
	let mut out: Vec<(String, String)> = Vec::new();
	let mut order: Vec<String> = Vec::new();
	let items = codex.items;
	let npcs = codex.npcs;
	let objects = codex.objects;
	let item_ids = sorted_ids(items);

	let mut skills: Vec<(String, V)> = Vec::new();
	for id in &item_ids {
		for s in items.get(id).get("sources").items() {
			if s.get("type").as_str() == Some("craft") && !s.get("skillLine").is_nullish() && s.get("profession").truthy() {
				let k = kstr(&s.get("skillLine"));
				match skills.iter_mut().find(|(x, _)| *x == k) {
					Some(e) => e.1 = s.get("profession"),
					None => skills.push((k, s.get("profession"))),
				}
			}
		}
	}

	let meta = codex.meta.as_obj().map(|o| o.spread()).unwrap_or_default();
	let schema = meta.get("schema");
	meta.set("schema", if schema.truthy() { schema } else { V::Num(SCHEMA) });
	if build.truthy() && !meta.get("build").truthy() {
		meta.set("build", build.clone());
	}
	let mut meta_lines = header();
	let frame_ids = sorted_ids(codex.frames);
	if !frame_ids.is_empty() {
		meta_lines.push("-- Era bounds of every map the Codex places points on (f = \"e\").".into());
		meta_lines.push("if Polestar.RegisterMapFrames then".into());
		meta_lines.push("\tPolestar.RegisterMapFrames({ era = {".into());
		for id in &frame_ids {
			let f = codex.frames.get(id);
			meta_lines.push(format!(
				"\t\t[{id}] = {{ c = {}, left = {}, right = {}, top = {}, bottom = {} }},",
				num(&f.get("c"))?,
				num(&f.get("left"))?,
				num(&f.get("right"))?,
				num(&f.get("top"))?,
				num(&f.get("bottom"))?
			));
		}
		meta_lines.push("\t} })".into());
		meta_lines.push("end".into());
		meta_lines.push(String::new());
	}
	meta_lines.push(format!("C.Register(\"meta\", {})", lua_value(&V::Obj(meta.clone()), "")));
	meta_lines.push(String::new());
	out.push(("Meta.lua".into(), meta_lines.join("\n")));
	order.push("Meta.lua".into());
	// sortedIds(skills): skills keys in JS order then sorted.
	let mut skill_keys: Vec<String> = skills.iter().map(|(k, _)| k.clone()).collect();
	let skill_obj = forge_guide::js::Obj::new();
	for (k, v) in &skills {
		skill_obj.set(k, v.clone());
	}
	skill_keys.clear();
	let skill_v = V::Obj(skill_obj);
	skill_keys.extend(sorted_ids(&skill_v));
	let skill_entries: Vec<Entry> = skill_keys.iter().map(|id| (id.clone(), skill_v.get(id), None, String::new())).collect();
	if !skill_entries.is_empty() {
		emit_group("skill", &skill_entries, "Skills", &mut out, &mut order);
	}

	let mut index: Vec<(&str, Vec<(String, V, V, String)>)> = Vec::new();
	for kind in ITEM_KINDS {
		let ids: Vec<&String> = item_ids
			.iter()
			.filter(|id| {
				let k = items.get(id).get("kind");
				(if k.truthy() { k.to_js_string() } else { "item".into() }) == kind
			})
			.collect();
		// Lookup never offers an item with one of the game's placeholder names ("Ahn'Qiraj Wand [PH]", #2614).
		index.push((
			kind,
			ids.iter()
				.filter(|id| !items.get(id).get("name").as_str().is_some_and(forge_guide::placeholder::banned))
				.map(|id| {
					let it = items.get(id);
					((*id).clone(), it.get("name"), it.get("quality"), status_letter(&it).to_string())
				})
				.collect(),
		));
		let mut entries: Vec<Entry> = Vec::new();
		for id in &ids {
			let it = items.get(id);
			entries.push(((*id).clone(), it.get("name"), Some(encode_item(&it)?), num(&it.get("quality"))? + status_letter(&it)));
		}
		let prefix = if kind == "item" { "Items".to_string() } else { format!("{}{}s", kind[..1].to_uppercase(), &kind[1..]) };
		emit_group(kind, &entries, &prefix, &mut out, &mut order);
	}
	let npc_ids = sorted_ids(npcs);
	for (group, prefix, rare) in [("npc", "Npcs", false), ("rare", "Rares", true)] {
		let ids: Vec<&String> = npc_ids.iter().filter(|id| npcs.get(id).get("rare").truthy() == rare).collect();
		// Lookup never offers an NPC with one of the game's placeholder names ("PvP Tower Credit Marker", #2614).
		let searchable = ids.iter().filter(|id| !npcs.get(id).get("name").as_str().is_some_and(forge_guide::placeholder::banned));
		index.push((group, searchable.map(|id| ((*id).clone(), npcs.get(id).get("name"), V::Undef, String::new())).collect()));
		let mut entries: Vec<Entry> = Vec::new();
		for id in &ids {
			let n = npcs.get(id);
			entries.push(((*id).clone(), n.get("name"), Some(encode_npc(&n)?), String::new()));
		}
		emit_group(group, &entries, prefix, &mut out, &mut order);
	}
	let mut roles: Vec<(String, Vec<String>)> = Vec::new();
	for id in &npc_ids {
		for r in npcs.get(id).get("roles").items() {
			let r = r.to_js_string();
			match roles.iter_mut().find(|(x, _)| *x == r) {
				Some(e) => e.1.push(id.clone()),
				None => roles.push((r, vec![id.clone()])),
			}
		}
	}
	// Object.keys(roles).sort(): JS order then the default sort (a total order on strings).
	roles.sort_by(|a, b| forge_guide::js::cmp_utf16(&a.0, &b.0));
	let role_entries: Vec<Entry> = roles.iter().map(|(r, ids)| (r.clone(), V::str(&ids.join(",")), None, String::new())).collect();
	if !role_entries.is_empty() {
		emit_group("role", &role_entries, "Roles", &mut out, &mut order);
	}
	let obj_ids = sorted_ids(objects);
	let obj_entries = |treasure: bool| -> Result<Vec<Entry>, String> {
		let mut v = Vec::new();
		for id in &obj_ids {
			let o = objects.get(id);
			if o.get("treasure").truthy() == treasure {
				v.push((id.clone(), o.get("name"), Some(encode_object(&o)?), String::new()));
			}
		}
		Ok(v)
	};
	emit_group("object", &obj_entries(false)?, "Objects", &mut out, &mut order);
	let treasures = obj_entries(true)?;
	index.push(("treasure", treasures.iter().map(|(id, name, ..)| (id.clone(), name.clone(), V::Undef, String::new())).collect()));
	emit_group("treasure", &treasures, "Treasures", &mut out, &mut order);
	type Enc = fn(&V) -> Result<String, String>;
	let simple: [(&str, &V, &str, Option<Enc>, &str); 5] = [
		("quest", codex.quests, "title", Some(encode_quest), "Quests"),
		("instance", codex.instances, "name", Some(encode_instance), "Instances"),
		("zone", codex.zones, "name", None, "Zones"),
		("faction", codex.factions, "name", Some(|r: &V| Ok(esc(&r.get("side")))), "Factions"),
		("spell", codex.spells, "name", Some(encode_spell), "Spells"),
	];
	for (group, obj, name_field, enc, prefix) in simple {
		let mut entries: Vec<Entry> = Vec::new();
		for id in sorted_ids(obj) {
			let r = obj.get(&id);
			let rec = match enc {
				Some(f) => Some(f(&r)?),
				None => None,
			};
			entries.push((id, r.get(name_field), rec, String::new()));
		}
		if SEARCH_KINDS.contains(&group) {
			// Lookup never offers a quest the game keeps unused or for tests ("<UNUSED>", "<TEST> HEY MISTER WILSON!",
			// "REUSE", #2614), nor anything else with a placeholder name.
			let hidden = |name: &V| name.as_str().is_some_and(|n| forge_guide::placeholder::banned(n) || (group == "quest" && forge_guide::placeholder::unused_quest(n)));
			index.push((group, entries.iter().filter(|(_, name, ..)| !hidden(name)).map(|(id, name, ..)| (id.clone(), name.clone(), V::Undef, String::new())).collect()));
		}
		emit_group(group, &entries, prefix, &mut out, &mut order);
	}
	// Index.lua
	let mut lines = header();
	lines.push("if not C.RegisterIndex then return end".into());
	lines.push(String::new());
	let categories = index
		.iter()
		.filter(|(kind, _)| ITEM_KINDS.contains(kind))
		.flat_map(|(_, entries)| entries.iter())
		.filter_map(|(id, ..)| item_category(&items.get(id)).transpose())
		.collect::<Result<BTreeSet<_>, _>>()?;
	if categories.len() > MAX_CATEGORIES {
		return Err(format!("codex item filter: {} categories exceed the version {FILTER_VERSION} limit of {MAX_CATEGORIES}", categories.len()));
	}
	let categories: Vec<_> = categories.into_iter().collect();
	let mut filter_lines = Vec::new();
	for kind in SEARCH_KINDS {
		let entries = index.iter().rev().find(|(k, _)| *k == kind).map(|(_, e)| e.as_slice()).unwrap_or(&[]);
		let item_backed = ITEM_KINDS.contains(&kind);
		let mut blob = String::new();
		let mut filters = Vec::with_capacity(if item_backed { entries.len() * FILTER_BYTES } else { 0 });
		for (id, name, quality, status) in entries {
			blob.push('\x02');
			blob.push_str(&fold_name(name));
			blob.push('\x01');
			blob.push_str(&format!("{id},{},{status},{}\n", num(quality)?, one_line(name).len()));
			if item_backed {
				filters.extend(encode_filter(&items.get(id), &categories)?);
			}
		}
		lines.push(format!("C.RegisterIndex({}, {})", lua_str(kind), lua_blob(&blob)));
		if item_backed {
			filter_lines.push(format!("\t\t{kind} = {{ {}, {} }},", entries.len(), lua_bytes(&filters)));
		}
	}
	let directory: Vec<_> = categories.into_iter().flat_map(|(class, subclass)| [class, subclass]).collect();
	lines.push(String::new());
	lines.push("if C.RegisterFilters then".into());
	lines.push(format!("\tC.RegisterFilters({FILTER_VERSION}, {}, {{", lua_bytes(&directory)));
	lines.extend(filter_lines);
	lines.push("\t})".into());
	lines.push("end".into());
	lines.push(String::new());
	out.push(("Index.lua".into(), lines.join("\n")));
	order.push("Index.lua".into());

	for (name, text) in extra_files {
		let ok = !name.is_empty() && name.ends_with(".lua") && name[..name.len() - 4].bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_') && name.len() > 4;
		if !ok || out.iter().any(|(f, _)| f == name) {
			return Err(format!("codex pack: bad or duplicate extra file \"{name}\""));
		}
		out.push((name.clone(), text.clone()));
		order.push(name.clone());
	}
	out.push((format!("{ADDON}.toc"), emit_toc(version, &order)));
	out.push(("LICENSE-DATA.txt".into(), license_text(&V::Obj(meta))));
	Ok(out)
}

fn emit_toc(version: &str, files: &[String]) -> String {
	let mut lines: Vec<String> = vec![
		"## Interface: 16001".into(),
		"## Title: Polestar Codex".into(),
		"## Notes: Part of Polestar: items, mounts, pets, NPCs, quests and where to get them, dungeons and rares, for Lookup, Dungeons and Rares. Loaded on demand.".into(),
	];
	lines.extend(forge_guide::toc::toc_lines(ADDON));
	lines.push("## Author: Polestar".into());
	lines.push(format!("## Version: {version}"));
	lines.push("## Category: Polestar".into());
	lines.push("## Group: Polestar".into());
	lines.push("## LoadOnDemand: 1".into());
	lines.push("## Dependencies: Polestar".into());
	lines.push(String::new());
	lines.extend(files.iter().cloned());
	lines.push(String::new());
	lines.join("\n")
}

fn license_text(meta: &V) -> String {
	let mut out: Vec<String> = [
		"Polestar Codex: third-party notices",
		"===================================",
		"",
		"The data in this folder was generated for Polestar by `codex build` from the",
		"sources below: item, NPC, object, quest, zone and instance facts (ids, names,",
		"levels, coordinates, drop chances, requirements). No text, images or code",
		"were copied from them; the Dungeons journal is written in our own words.",
		"",
	]
	.iter()
	.map(|s| s.to_string())
	.collect();
	if meta.get("localExtras").truthy() {
		out.push("LOCAL BUILD (--local-extras): holds facts from inputs that may not be".into());
		out.push("redistributed. Do not share this folder.".into());
		out.push(String::new());
	}
	for s in meta.get("sources").items() {
		let n = s.get("name");
		let title = if n.truthy() { n.to_js_string() } else { "source".into() };
		let len = title.encode_utf16().count();
		out.push(title);
		out.push("-".repeat(len));
		if s.get("version").truthy() {
			out.push(format!("Version: {}", s.get("version").to_js_string()));
		}
		if s.get("licence").truthy() {
			out.push(format!("Licence: {}", s.get("licence").to_js_string()));
		}
		out.push(String::new());
	}
	format!("{}\n", out.join("\n").trim_end_matches(|c: char| forge_guide::emit::is_js_space(c)))
}

/// `packOrder(files)`: TOC order of the pack's Lua files.
pub fn pack_order(files: &[(String, String)]) -> Vec<String> {
	let toc = files.iter().find(|(f, _)| *f == format!("{ADDON}.toc")).map(|(_, t)| t.as_str()).unwrap_or("");
	toc.split('\n').map(|l| l.trim()).filter(|l| !l.is_empty() && !l.starts_with('#')).map(String::from).collect()
}

#[cfg(test)]
mod tests {
	use super::*;
	use forge_guide::js::parse_json;
	use mlua::{Function, Lua, Table};

	fn filter_lua() -> (Lua, Table) {
		let lua = Lua::new();
		let ns = lua.create_table().unwrap();
		lua.load(include_str!(concat!(env!("CARGO_MANIFEST_DIR"), "/../../../addon/Polestar/Lookup/Codex.lua"))).call::<()>(("Polestar", ns.clone())).unwrap();
		lua.globals().set("Polestar", ns.clone()).unwrap();
		let codex = ns.get("Codex").unwrap();
		(lua, codex)
	}

	type FilterFields = (Option<u16>, Option<u16>, Option<u16>, Option<u16>, Option<u16>, Option<u16>, Option<u16>);

	#[test]
	fn filter_row_round_trips_zero_unknown_and_each_source() {
		let (lua, codex) = filter_lua();
		let decode: Function = codex.get("DecodeFilter").unwrap();
		let row = |item| {
			let bytes = encode_filter(&item, &[(2, 7)]).unwrap();
			// Exercise the byte-safe Lua source emitter, including NUL and high bytes.
			let blob: mlua::String = lua.load(format!("return {}", lua_bytes(&bytes))).eval().unwrap();
			assert_eq!(blob.as_bytes().as_ref(), bytes);
			decode.call::<FilterFields>((blob, 1)).unwrap()
		};
		assert_eq!(row(V::obj()), (None, None, None, None, None, None, None));
		let zeroes = parse_json(r#"{"reqLevel":0,"itemLevel":0,"allowClass":0,"slot":0}"#).unwrap();
		assert_eq!(row(zeroes), (Some(0), Some(0), Some(0), Some(0), None, None, None));
		for (code, source) in [(1, "client"), (2, "forever"), (3, "era")] {
			let item = parse_json(r#"{"reqLevel":126,"itemLevel":100,"allowClass":1503,"slot":34,"itemClass":2,"itemSubclass":7}"#).unwrap();
			item.set("levelsSource", source);
			item.set("typeSource", source);
			assert_eq!(row(item), (Some(126), Some(100), Some(1503), Some(34), Some(1), Some(code), Some(code)));
		}
		for class in &CLASSES {
			let item = V::obj();
			item.set("allowClass", class.bit);
			assert_eq!(row(item).2, Some(class.bit as u16), "{}", class.file);
		}
		let bytes: Vec<u8> = (0..=255).collect();
		let blob: mlua::String = lua.load(format!("return {}", lua_bytes(&bytes))).eval().unwrap();
		assert_eq!(blob.as_bytes().as_ref(), bytes);
	}

	#[test]
	fn filter_directory_and_columns_follow_searchable_index_rows() {
		let items = parse_json(
			r#"{
				"10":{"name":"Axe","itemClass":2,"itemSubclass":0,"reqLevel":10},
				"2":{"name":"Robe","itemClass":4,"itemSubclass":1,"reqLevel":2},
				"4":{"name":"Ahn'Qiraj Wand [PH]","itemClass":1,"itemSubclass":0,"reqLevel":4},
				"6":{"name":"Sword","itemClass":2,"itemSubclass":7,"reqLevel":6},
				"12":{"name":"Retired Sword","status":"retired","itemClass":2,"itemSubclass":7,"reqLevel":12},
				"13":{"name":"Recipe","kind":"recipe","itemClass":9,"itemSubclass":0,"reqLevel":13},
				"14":{"name":"Mount","kind":"mount","itemClass":15,"itemSubclass":0,"reqLevel":14},
				"15":{"name":"Pet","kind":"pet","itemClass":15,"itemSubclass":2,"reqLevel":15},
				"16":{"name":"Tabard","kind":"tabard","itemClass":4,"itemSubclass":0,"reqLevel":16}
			}"#,
		)
		.unwrap();
		let empty = V::obj();
		let pack = PackCodex { items: &items, npcs: &empty, objects: &empty, quests: &empty, instances: &empty, zones: &empty, factions: &empty, spells: &empty, meta: &empty, frames: &empty };
		let files = emit_pack(&pack, "1", &V::Null, &[]).unwrap();
		let (lua, codex) = filter_lua();
		let index_lua = &files.iter().find(|(name, _)| name == "Index.lua").unwrap().1;
		lua.load(index_lua).exec().unwrap();

		let category: Function = codex.get("FilterCategory").unwrap();
		for (i, pair) in [(2, 0), (2, 7), (4, 0), (4, 1), (9, 0), (15, 0), (15, 2)].into_iter().enumerate() {
			assert_eq!(category.call::<(u8, u8)>(i + 1).unwrap(), pair);
		}
		assert_eq!(category.call::<Option<u8>>(8).unwrap(), None);
		let index: Function = codex.get("Index").unwrap();
		let column: Function = codex.get("FilterColumn").unwrap();
		let decode: Function = codex.get("DecodeFilter").unwrap();
		for (kind, expected) in [("item", &[(2, 4), (6, 2), (10, 1), (12, 2)][..]), ("mount", &[(14, 6)]), ("pet", &[(15, 7)]), ("recipe", &[(13, 5)]), ("tabard", &[(16, 3)])] {
			let text: String = index.call(kind).unwrap();
			let (bytes, count): (mlua::String, usize) = column.call(kind).unwrap();
			assert_eq!(count, expected.len(), "{kind}");
			assert_eq!(bytes.as_bytes().len(), FILTER_BYTES * count, "{kind}");
			let rows: Vec<_> = text.lines().collect();
			assert_eq!(rows.len(), count);
			for (i, (line, &(id, cat))) in rows.iter().zip(expected).enumerate() {
				let id_text = line.split_once('\x01').unwrap().1.split(',').next().unwrap();
				assert_eq!(id_text.parse::<u16>().unwrap(), id, "{kind} row {}", i + 1);
				let facts = decode.call::<FilterFields>((bytes.clone(), i + 1)).unwrap();
				assert_eq!((facts.0, facts.4), (Some(id), Some(cat)), "{kind} row {}", i + 1);
			}
		}
	}

	#[test]
	fn folds_names() {
		assert_eq!(fold_name(&V::str("Thunderfury, Blessed Blade")), "thunderfury blessed blade");
		assert_eq!(fold_name(&V::str("Ragnaros' Heart")), "ragnaros heart");
		assert_eq!(fold_name(&V::str("Caf\u{e9}")), "cafe");
		assert_eq!(esc(&V::str("a;b,c%")), "a%3Bb%2Cc%25");
	}

	#[test]
	fn a_zero_item_requirement_leaves_the_legacy_header_empty() {
		let item = forge_guide::js::parse_json(r#"{"quality":1}"#).unwrap();
		assert_eq!(encode_item(&item).unwrap(), "1;;;;;;");
		item.set("reqLevel", 0.0);
		assert_eq!(encode_item(&item).unwrap(), "1;;;;;;");
		item.set("reqLevel", 60.0);
		assert_eq!(encode_item(&item).unwrap(), "1;60;;;;;");
	}

	#[test]
	fn drop_requirements_follow_provenance_without_changing_old_fields() {
		let source = forge_guide::js::parse_json(r#"{"type":"drop","npc":4802,"chance":33,"from":["pfquest"]}"#).unwrap();
		assert_eq!(encode_source(&source).unwrap(), "d4802,33,,p");
		source.set("requiresQuests", forge_guide::js::parse_json("[6563,6564]").unwrap());
		assert_eq!(encode_source(&source).unwrap(), "d4802,33,,p,6563%2C6564");
		source.set("requiresQuests", V::arr());
		assert_eq!(encode_source(&source).unwrap(), "d4802,33,,p");
	}

	#[test]
	fn an_entrance_carries_its_approximate_flag_and_the_alliance_way_in_after_it() {
		let line = |entrance: &str| {
			let rec = forge_guide::js::parse_json(&format!(r#"{{ "kind": "dungeon", "forever": true, "areaId": 279, "map": 2959, "entrance": {entrance}, "levels": null, "bosses": [] }}"#)).unwrap();
			encode_instance(&rec).unwrap().split(';').nth(4).unwrap().to_string()
		};
		assert_eq!(line(r#"{ "map": 1436, "x": 30, "y": 50, "f": null, "approx": true }"#), "1436,300,500,,a");
		assert_eq!(line(r#"{ "map": 1436, "x": 30, "y": 50, "f": null }"#), "1436,300,500,");
		// The City of Dalaran (#706): the Horde's tunnel, then the Alliance's pipe in Cantrips & Crows.
		assert_eq!(line(r#"{ "map": 1416, "x": 8.5, "y": 59.2, "f": null, "A": { "map": 1416, "x": 14.7, "y": 63 } }"#), "1416,85,592,,,1416,147,630");
	}

	#[test]
	fn a_quest_record_ends_with_the_profession_it_needs_1913() {
		let line = |extra: &str| {
			let rec = forge_guide::js::parse_json(&format!(
				r#"{{ "id": 2501, "level": 41, "minLevel": 36, "faction": null, "races": null, "classes": null, "zone": 3, "start": {{ "npc": [2786], "object": [], "item": [] }}, "end": {{ "npc": [2786], "object": [] }}, "pre": [17], "rewards": [], "choices": [], "preAny": [], "objectives": [], "xp": 4950{extra} }}"#
			))
			.unwrap();
			encode_quest(&rec).unwrap()
		};
		assert!(line(r#", "skill": 171, "skillLevel": 210"#).ends_with(";x4950;l171,210"), "Badlands Reagent Run II: Alchemy 210");
		assert!(line(r#", "skill": 171, "skillLevel": null"#).ends_with(";x4950;l171,"), "no rank in the data");
		assert!(line("").ends_with(";x4950"), "no profession: no field");
	}

	#[test]
	fn a_quest_record_carries_the_quests_that_close_it_1996() {
		let line = |extra: &str| {
			let rec = forge_guide::js::parse_json(&format!(
				r#"{{ "id": 463, "level": 21, "minLevel": 20, "faction": "A", "races": null, "classes": null, "zone": 11, "start": {{ "npc": [1239], "object": [], "item": [] }}, "end": {{ "npc": [1244], "object": [] }}, "pre": [], "rewards": [], "choices": [], "preAny": [], "objectives": [], "xp": 830{extra} }}"#
			))
			.unwrap();
			encode_quest(&rec).unwrap()
		};
		assert!(line(r#", "closedBy": [276]"#).ends_with(";x830;c276"), "The Greenwarden: closed by Tramping Paws");
		assert!(line(r#", "closedBy": [282, 287]"#).ends_with(";x830;c282,287"));
		assert!(line("").ends_with(";x830"), "nothing closes it: no field");
	}

	#[test]
	fn a_quest_record_says_it_is_handed_in_at_one_talk_2686() {
		let line = |extra: &str| {
			let rec = forge_guide::js::parse_json(&format!(
				r#"{{ "id": 4144, "level": 53, "minLevel": 47, "faction": "A", "races": null, "classes": null, "zone": 1449, "start": {{ "npc": [9119], "object": [], "item": [] }}, "end": {{ "npc": [9119], "object": [] }}, "pre": [4143], "rewards": [], "choices": [], "preAny": [4143], "objectives": [{{ "type": "item", "id": 11315, "count": 3, "text": "Bloodpetal Sprout" }}], "xp": 5300{extra} }}"#
			))
			.unwrap();
			encode_quest(&rec).unwrap()
		};
		assert!(line(r#", "direct": true"#).ends_with(";x5300;d"), "Bloodpetal Sprouts: handed in at one talk");
		assert!(line("").ends_with(";x5300"), "taken into the log: no field");
	}
}
