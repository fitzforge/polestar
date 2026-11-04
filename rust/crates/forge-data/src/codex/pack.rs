//! tools/lib/codex/pack.js `emitPack`: the Codex -> the load-on-demand addon Polestar_Codex
//! (record strings in long Lua string literals, decoded by addon/Polestar/Lookup/Codex.lua).

use forge_guide::js::{num_str, str_to_num, V};

use super::util::{kstr, math_round};

pub const SCHEMA: f64 = 1.0;
pub const ADDON: &str = "Polestar_Codex";
const CHUNK: usize = 4000;
const ITEM_KINDS: [&str; 5] = ["item", "mount", "pet", "recipe", "tabard"];
const SEARCH_KINDS: [&str; 11] = ["mount", "pet", "item", "recipe", "tabard", "quest", "npc", "rare", "instance", "zone", "treasure"];

fn from_letter(f: &str) -> Result<char, String> {
	Ok(match f {
		"atlasloot" => 'a',
		"client" => 'c',
		"dungeons" => 'd',
		"flbis" => 'f',
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
	let mut parts = vec![
		num(&rec.get("quality"))? + status_letter(rec),
		num(&rec.get("reqLevel"))?,
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

fn encode_spawns(spawns: &V) -> Result<Vec<String>, String> {
	let mut groups: Vec<(String, Vec<String>)> = Vec::new();
	for s in spawns.items() {
		let f = s.get("f");
		let fs = if f.truthy() { f.to_js_string() } else { String::new() };
		let k = format!("{}|{}", s.get("map").to_js_string(), fs);
		let i = match groups.iter().position(|(x, _)| *x == k) {
			Some(i) => i,
			None => {
				groups.push((k, vec![num(&s.get("map"))?, fs.clone()]));
				groups.len() - 1
			}
		};
		groups[i].1.push(coord(&s.get("x")));
		groups[i].1.push(coord(&s.get("y")));
	}
	Ok(groups.into_iter().map(|(_, g)| g.join(",")).collect())
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
	}
	if rec.get("repFaction").truthy() && rec.get("repStanding").truthy() {
		parts.push(format!("r{},{}", num(&rec.get("repFaction"))?, num(&rec.get("repStanding"))?));
	}
	if rec.get("xp").num() > 0.0 {
		parts.push(format!("x{}", num(&rec.get("xp"))?));
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
		index.push((
			kind,
			ids.iter()
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
		index.push((group, ids.iter().map(|id| ((*id).clone(), npcs.get(id).get("name"), V::Undef, String::new())).collect()));
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
			index.push((group, entries.iter().map(|(id, name, ..)| (id.clone(), name.clone(), V::Undef, String::new())).collect()));
		}
		emit_group(group, &entries, prefix, &mut out, &mut order);
	}
	// Index.lua
	let mut lines = header();
	lines.push("if not C.RegisterIndex then return end".into());
	lines.push(String::new());
	for kind in SEARCH_KINDS {
		let entries = index.iter().rev().find(|(k, _)| *k == kind).map(|(_, e)| e.as_slice()).unwrap_or(&[]);
		let mut blob = String::new();
		for (id, name, quality, status) in entries {
			blob.push('\x02');
			blob.push_str(&fold_name(name));
			blob.push('\x01');
			blob.push_str(&format!("{id},{},{status},{}\n", num(quality)?, one_line(name).len()));
		}
		lines.push(format!("C.RegisterIndex({}, {})", lua_str(kind), lua_blob(&blob)));
	}
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

	#[test]
	fn folds_names() {
		assert_eq!(fold_name(&V::str("Thunderfury, Blessed Blade")), "thunderfury blessed blade");
		assert_eq!(fold_name(&V::str("Ragnaros' Heart")), "ragnaros heart");
		assert_eq!(fold_name(&V::str("Caf\u{e9}")), "cafe");
		assert_eq!(esc(&V::str("a;b,c%")), "a%3Bb%2Cc%25");
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
}
