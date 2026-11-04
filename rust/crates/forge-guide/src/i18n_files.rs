//! Port of tools/lib/i18n/files.js (with the parts of tools/lib/i18n/keys.js
//! it uses: tokenize, unescapeLua; and of tools/lib/lua.js: luaToJson).
//!
//! The interface's translation files, addon/Polestar/Locales/<locale>.lua, in
//! the layout their translators write:
//!
//!   -- German (deDE). ...                <- the file's own header comments
//!
//!   local _, ns = ...
//!   if not (GetLocale and GetLocale() == "deDE") then return end
//!   local L = ns.L
//!
//!   -- Core/Commands.lua                  <- a group: the file that first uses its keys
//!   L["Toggle guide window"] = "Guide-Fenster ein-/ausblenden"
//!   -- L["Next step"] = ""               <- not translated yet: shows in English
//!
//! One entry per line. Values are read by the real Lua 5.1 (a file the game
//! cannot load fails here too), with GetLocale answering the file's locale.
//! `i18n sync` edits a file in place and never rewrites a line that holds a
//! translation: it adds the keys the code gained, commented out, at the end of
//! their file's group, and moves the translations of keys the code lost to a
//! block at the end of the file for their translator to reuse. Adapted from
//! Ding! by Yendi (@moust4ki), GPL-3.0:
//! https://github.com/moust4ki/DingGuideWoWForever
//!
//! The text functions are pure; read_locale_files runs Lua 5.1 (native only,
//! built in), as the JS runs lua5.1.

use crate::js::{cmp_utf16, V};
use crate::locales;
use std::collections::HashSet;

pub const RETIRED: &str = "-- No longer in the code (its English changed or it went away): reuse or delete.";
const BODY_START: &str = "local L = ns.L";

/// files.js's luaString (escapes control characters below 32; 127 stays).
pub fn lua_string(s: &str) -> String {
	let mut out = String::with_capacity(s.len() + 2);
	out.push('"');
	for ch in s.chars() {
		match ch {
			'\\' => out.push_str("\\\\"),
			'"' => out.push_str("\\\""),
			'\n' => out.push_str("\\n"),
			'\r' => out.push_str("\\r"),
			'\t' => out.push_str("\\t"),
			_ if (ch as u32) < 32 => out.push_str(&format!("\\{:03}", ch as u32)),
			_ => out.push(ch),
		}
	}
	out.push('"');
	out
}

#[cfg(feature = "native")]
pub fn locale_file(addon_dir: &std::path::Path, locale: &str) -> std::path::PathBuf {
	addon_dir.join("Locales").join(format!("{locale}.lua"))
}

// ------------------------------------------------------------ lua.js (luaToJson)

#[cfg(feature = "native")]
const ENCODER: &str = r##"
local escapes = { ['"'] = '\\"', ['\\'] = '\\\\', ['\b'] = '\\b', ['\f'] = '\\f', ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t' }
local function num(v)
  if v ~= v or v == math.huge or v == -math.huge then return "null" end
  -- "%.0f", not "%d": Lua 5.1 on Windows formats "%d" through a 32-bit long.
  if v == math.floor(v) and math.abs(v) < 2^53 then return v == 0 and "0" or string.format("%.0f", v) end
  return string.format("%.17g", v)
end
local function str(s)
  return '"' .. s:gsub('[%z\1-\31"\\]', function(c) return escapes[c] or string.format("\\u%04x", c:byte()) end) .. '"'
end
local function encode(v, seen, buf)
  local t = type(v)
  if t == "nil" then buf[#buf+1] = "null"
  elseif t == "boolean" then buf[#buf+1] = v and "true" or "false"
  elseif t == "number" then buf[#buf+1] = num(v)
  elseif t == "string" then buf[#buf+1] = str(v)
  elseif t == "table" then
    if seen[v] then error("cycle in Lua data", 0) end
    seen[v] = true
    local n, count, ints = 0, 0, true
    for k in pairs(v) do
      count = count + 1
      if type(k) == "number" and k >= 1 and k == math.floor(k) then
        if k > n then n = k end
      else
        ints = false
      end
    end
    if count > 0 and ints and n == count then
      buf[#buf+1] = "["
      for i = 1, n do
        if i > 1 then buf[#buf+1] = "," end
        encode(v[i], seen, buf)
      end
      buf[#buf+1] = "]"
    else
      buf[#buf+1] = "{"
      local first = true
      for k, val in pairs(v) do
        local key
        if type(k) == "string" then key = k
        elseif type(k) == "number" then key = num(k)
        elseif type(k) == "boolean" then key = tostring(k) end
        if key then
          if not first then buf[#buf+1] = "," end
          first = false
          buf[#buf+1] = str(key)
          buf[#buf+1] = ":"
          encode(val, seen, buf)
        end
      end
      buf[#buf+1] = "}"
    end
    seen[v] = nil
  else
    buf[#buf+1] = "null"
  end
end
function __polestar_json(v)
  local buf = {}
  encode(v, {}, buf)
  return table.concat(buf)
end
"##;

#[cfg(feature = "native")]
const SANDBOX: &str = r##"
-- pcall, xpcall and coroutine too: a chunk catching errors could swallow the
-- time limit's (lua_to_json_within) in a loop and never end.
local __blocked = { os = true, io = true, load = true, loadfile = true, loadstring = true, dofile = true,
  require = true, module = true, package = true, debug = true, getfenv = true, setfenv = true,
  getmetatable = true, setmetatable = true, newproxy = true, collectgarbage = true, _G = true, jit = true, ffi = true, bit = true,
  pcall = true, xpcall = true, coroutine = true }
local function __copy(t) local c = {} for k, v in pairs(t) do c[k] = v end return c end
local __safe = { table = __copy(table), string = __copy(string), math = __copy(math) }
local __env = setmetatable({}, {
  __index = function(_, k)
    if __safe[k] ~= nil then return __safe[k] end
    if __blocked[k] or (type(k) == "string" and k:sub(1, 2) == "__") then return nil end
    return rawget(_G, k)
  end,
  __newindex = function(_, k, v)
    -- Data may add globals, never replace the functions trusted code relies on.
    if __blocked[k] or __safe[k] ~= nil or type(rawget(_G, k)) == "function" or (type(k) == "string" and k:sub(1, 2) == "__") then
      error("sandbox: cannot assign " .. tostring(k), 2)
    end
    rawset(_G, k, v)
  end,
})
local __rawopen, __rawload, __setfenv, __pcall = io.open, loadstring, setfenv, pcall
-- LuaJIT allows one function 65536 constants, fewer than pfQuest's db/units.lua
-- holds in its one table constructor. A file written the way pfQuest writes
-- its database ("<target> = {" on the first line, each entry starting on a
-- line indented two spaces, "}" on the last) loads again with its entries
-- split across functions of their own, which fill the same table.
local function __split(src)
  -- A cut inside a long string ([[...]], [==[...]==]) or after a backslash
  -- line continuation would paste the wrapper into the value: don't split.
  if src:find("%[=*%[") or src:find("\\\r?\n") then return nil end
  local lines = {}
  for line in (src:gsub("\r\n", "\n") .. "\n"):gmatch("([^\n]*)\n") do lines[#lines + 1] = line end
  while #lines > 0 and lines[#lines]:match("^%s*$") do lines[#lines] = nil end
  local target = lines[1] and lines[1]:match("^([%w_%[%]\"]+)%s*=%s*{%s*$")
  if not target or lines[#lines] ~= "}" then return nil end
  local out = { "local __t = {}", target .. " = __t;" }
  local group = 0
  for i = 2, #lines - 1 do
    if group >= 10000 and lines[i]:match("^  [^%s}]") then
      out[#out + 1] = "} for k, v in pairs(g) do t[k] = v end end)(__t);"
      group = 0
    end
    if group == 0 then out[#out + 1] = "(function(t) local g = {" end
    out[#out + 1] = lines[i]
    group = group + 1
  end
  if group > 0 then out[#out + 1] = "} for k, v in pairs(g) do t[k] = v end end)(__t);" end
  return table.concat(out, "\n")
end
function __polestar_loaddata(path, ...)
  local f, err = __rawopen(path, "rb")
  if not f then return false, err end
  local src = f:read("*a")
  f:close()
  if src:byte(1) == 27 then return false, path .. ": precompiled Lua is not accepted" end
  local chunk, perr = __rawload(src, "@" .. path)
  if not chunk and perr:match("more than %d+ constants") then
    local split = __split(src)
    chunk = split and __rawload(split, "@" .. path)
    if not chunk then return false, perr .. " (LuaJIT cannot load this file; set LUA to a Lua 5.1 interpreter)" end
  end
  if not chunk then return false, perr end
  __setfenv(chunk, __env)
  return __pcall(chunk, ...)
end
"##;

/// luaToJson({ expr }) (no files, no prelude): runs `expr` (a chunk body that
/// returns a value) and JSON-decodes it. The interpreter is PUC Lua 5.1 built
/// in (mlua, vendored), as the `lua5.1` the JS ran, so tables enumerate in the
/// same order. A pack's locale files are untrusted, so the run stops with an
/// error past LUA_TIME (the JS killed its `lua5.1` after 120 s) or once Lua
/// holds more than LUA_MEMORY.
#[cfg(feature = "native")]
fn lua_to_json(expr: &str) -> Result<V, String> {
	lua_to_json_within(expr, LUA_TIME, LUA_MEMORY)
}

/// The longest one read of translation files may run, and the most memory it may hold.
#[cfg(feature = "native")]
const LUA_TIME: std::time::Duration = std::time::Duration::from_secs(10);
#[cfg(feature = "native")]
const LUA_MEMORY: usize = 256 << 20;

#[cfg(feature = "native")]
fn lua_to_json_within(expr: &str, time: std::time::Duration, memory: usize) -> Result<V, String> {
	let lua = mlua::Lua::new();
	lua.set_memory_limit(memory).map_err(|e| format!("Lua failed: {e}"))?;
	// Checked every 10,000 instructions, in every coroutine too (a global hook);
	// past the deadline every check raises, so a chunk catching the error in a
	// pcall loop still ends.
	let deadline = std::time::Instant::now() + time;
	let secs = time.as_secs_f64();
	lua.set_global_hook(mlua::HookTriggers::new().every_nth_instruction(10_000), move |_, _| {
		if std::time::Instant::now() > deadline {
			return Err(mlua::Error::runtime(format!("the translation files took longer than {secs} s to run")));
		}
		Ok(mlua::VmState::Continue)
	})
	.map_err(|e| format!("Lua failed: {e}"))?;
	let body = format!("{ENCODER}\n{SANDBOX}\nlocal __value = (function() {expr} end)()\n__polestar_out = __polestar_json(__value)\n");
	lua.load(&body).set_name("=polestar-lua").exec().map_err(|e| format!("Lua failed: {e}"))?;
	let out: mlua::String = lua.globals().get("__polestar_out").map_err(|e| format!("Lua failed: {e}"))?;
	crate::js::parse_json(&String::from_utf8_lossy(&out.as_bytes()))
}

/// One file read by read_locale_files.
pub struct LocaleFile {
	pub file: String,
	pub ok: bool,
	pub error: Option<String>,
	/// "L" | "AddTranslations" | "return".
	pub layout: Option<String>,
	/// { key: value } (a V object, Lua's pairs order as the JSON carries it).
	pub strings: V,
	pub bad: Vec<String>,
	pub twice: Vec<String>,
}

/// Loads translation files in one Lua run, each with GetLocale() answering its
/// locale and ns = { L, locale, AddTranslations }. Reads Polestar's layout
/// (assignments to ns.L), Ding!'s (ns.AddTranslations(locale, t)) and a file
/// that returns a table. entries: (file, locale). -> one LocaleFile per entry, in order.
#[cfg(feature = "native")]
pub fn read_locale_files(entries: &[(String, String)]) -> Result<Vec<LocaleFile>, String> {
	if entries.is_empty() {
		return Ok(Vec::new());
	}
	let list = entries.iter().map(|(file, locale)| format!("{{ path = {}, locale = {} }}", lua_string(file), lua_string(locale))).collect::<Vec<_>>().join(",\n");
	let expr = format!(
		r#"
local list = {{ {list} }}
local current
function GetLocale() return current end
local out = {{}}
for i, e in ipairs(list) do
	current = e.locale
	local assigned, twice, got = {{}}, {{}}, nil
	local L = setmetatable({{}}, {{
		__index = function(_, k) local v = assigned[k]; if v == nil then return k end return v end,
		__newindex = function(_, k, v)
			if assigned[k] ~= nil then twice[#twice + 1] = tostring(k) end
			assigned[k] = v
		end,
	}})
	local ns = {{ L = L, locale = e.locale }}
	function ns.AddTranslations(locale, t) got = t end
	local ok, ret = __polestar_loaddata(e.path, "Polestar", ns)
	local r = {{ ok = ok }}
	if not ok then
		r.error = tostring(ret)
	else
		local t, layout = assigned, "L"
		if type(ret) == "table" then t, layout = ret, "return"
		elseif type(got) == "table" then t, layout = got, "AddTranslations" end
		local strings, bad = {{}}, {{}}
		for k, v in pairs(t) do
			if type(k) == "string" and type(v) == "string" then strings[k] = v
			else bad[#bad + 1] = tostring(k) end
		end
		r.layout, r.strings, r.bad, r.twice = layout, strings, bad, twice
	end
	out[i] = r
end
return out"#
	);
	let res = lua_to_json(&expr)?;
	let arr: Vec<V> = if res.is_arr() {
		res.items()
	} else {
		let mut keys: Vec<f64> = res.keys().iter().map(|k| crate::js::str_to_num(k)).collect();
		keys.sort_by(|a, b| (a - b).partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal));
		keys.iter().map(|k| res.get(&crate::js::num_str(*k))).collect()
	};
	let list_of = |v: &V| -> Vec<String> {
		if v.is_arr() {
			v.items().iter().map(|x| x.to_js_string()).collect()
		} else {
			Vec::new()
		}
	};
	Ok(entries
		.iter()
		.enumerate()
		.map(|(i, (file, _))| {
			let r = arr.get(i).cloned().filter(|r| r.truthy());
			let Some(r) = r else {
				return LocaleFile { file: file.clone(), ok: false, error: Some("not read".into()), layout: None, strings: V::obj(), bad: Vec::new(), twice: Vec::new() };
			};
			let error = r.get("error");
			let layout = r.get("layout");
			let strings = r.get("strings");
			LocaleFile {
				file: file.clone(),
				ok: r.get("ok").truthy(),
				error: error.truthy().then(|| error.to_js_string()),
				layout: layout.truthy().then(|| layout.to_js_string()),
				strings: if strings.truthy() && !strings.is_arr() { strings } else { V::obj() },
				bad: list_of(&r.get("bad")),
				twice: list_of(&r.get("twice")),
			}
		})
		.collect())
}

// ------------------------------------------------------------ keys.js (tokenize)

/// A quoted Lua string's body -> its text: the bytes it stands for (decimal
/// escapes are bytes), read as UTF-8 like the client reads them.
fn unescape_lua(body: &[char], file: &str, line: usize) -> Result<String, String> {
	let mut bytes: Vec<u8> = Vec::new();
	let mut i = 0;
	while i < body.len() {
		let c = body[i];
		if c != '\\' {
			let mut buf = [0u8; 4];
			bytes.extend_from_slice(c.encode_utf8(&mut buf).as_bytes());
			i += 1;
			continue;
		}
		i += 1;
		let n = body.get(i).copied();
		let simple = match n {
			Some('n') => Some(10),
			Some('t') => Some(9),
			Some('r') => Some(13),
			Some('a') => Some(7),
			Some('b') => Some(8),
			Some('f') => Some(12),
			Some('v') => Some(11),
			Some('\\') => Some(92),
			Some('"') => Some(34),
			Some('\'') => Some(39),
			Some('\n') => Some(10),
			_ => None,
		};
		if let Some(b) = simple {
			bytes.push(b);
		} else if let Some(d) = n.filter(|d| d.is_ascii_digit()) {
			let mut digits = String::from(d);
			while digits.len() < 3 && body.get(i + 1).is_some_and(|c| c.is_ascii_digit()) {
				i += 1;
				digits.push(body[i]);
			}
			bytes.push((digits.parse::<u32>().unwrap() & 255) as u8);
		} else {
			let shown = n.map_or("undefined".to_string(), |c| c.to_string());
			return Err(format!("{file}:{line}: invalid escape \\{shown}"));
		}
		i += 1;
	}
	Ok(String::from_utf8_lossy(&bytes).into_owned())
}

/// `^\[(=*)\[` at `at`: the number of `=`.
fn long_open(src: &[char], at: usize) -> Option<usize> {
	if src.get(at) != Some(&'[') {
		return None;
	}
	let mut j = at + 1;
	while j < src.len() && j < at + 64 && src[j] == '=' {
		j += 1;
	}
	(j < at + 64 && src.get(j) == Some(&'[')).then_some(j - at - 1)
}

fn index_of(src: &[char], pat: &[char], from: usize) -> Option<usize> {
	(from..=src.len().saturating_sub(pat.len())).find(|&i| src[i..].starts_with(pat))
}

/// Lua source -> [(type: 'name'|'string'|'number'|'punct', value, line)]; comments dropped.
/// Strings are decoded to their bytes and returned as UTF-8 text; a long string's line is its first.
pub fn tokenize(src: &str, file: &str) -> Result<Vec<(&'static str, String, usize)>, String> {
	let src: Vec<char> = src.chars().collect();
	let mut tokens = Vec::new();
	let mut i = 0;
	let mut line = 1;
	let len = src.len();
	let newlines = |s: &[char]| s.iter().filter(|c| **c == '\n').count();
	while i < len {
		let c = src[i];
		if c == '\n' {
			line += 1;
			i += 1;
			continue;
		}
		if c == ' ' || c == '\t' || c == '\r' {
			i += 1;
			continue;
		}
		if c == '-' && src.get(i + 1) == Some(&'-') {
			// LONG_OPEN on the 64 characters after `--`.
			let eq = if i + 2 < len { long_open(&src[..len.min(i + 2 + 64)], i + 2) } else { None };
			if let Some(eq) = eq {
				let close: Vec<char> = std::iter::once(']').chain(std::iter::repeat_n('=', eq)).chain(std::iter::once(']')).collect();
				let stop = match index_of(&src, &close, i + 2 + eq + 2) {
					Some(end) => end + close.len(),
					None => len,
				};
				line += newlines(&src[i..stop]);
				i = stop;
			} else {
				while i < len && src[i] != '\n' {
					i += 1;
				}
			}
			continue;
		}
		if c == '[' {
			if let Some(eq) = long_open(&src[..len.min(i + 64)], i) {
				let close: Vec<char> = std::iter::once(']').chain(std::iter::repeat_n('=', eq)).chain(std::iter::once(']')).collect();
				let open_len = eq + 2;
				let Some(end) = index_of(&src, &close, i + open_len) else {
					return Err(format!("{file}:{line}: unfinished long string"));
				};
				let mut body = &src[i + open_len..end];
				let start_line = line;
				line += newlines(&src[i..end]);
				if body.first() == Some(&'\n') {
					body = &body[1..];
				}
				tokens.push(("string", body.iter().collect(), start_line));
				i = end + close.len();
				continue;
			}
		}
		if c == '"' || c == '\'' {
			let mut j = i + 1;
			while j < len && src[j] != c {
				if src[j] == '\\' {
					j += 1;
				}
				if src.get(j) == Some(&'\n') && src[j - 1] != '\\' {
					return Err(format!("{file}:{line}: unfinished string"));
				}
				j += 1;
			}
			if j >= len {
				return Err(format!("{file}:{line}: unfinished string"));
			}
			let raw = &src[i + 1..j];
			let value = unescape_lua(raw, file, line)?;
			tokens.push(("string", value, line));
			line += newlines(raw);
			i = j + 1;
			continue;
		}
		if c.is_ascii_alphabetic() || c == '_' {
			let mut j = i + 1;
			while j < len && (src[j].is_ascii_alphanumeric() || src[j] == '_') {
				j += 1;
			}
			tokens.push(("name", src[i..j].iter().collect(), line));
			i = j;
			continue;
		}
		if c.is_ascii_digit() {
			let mut j = i + 1;
			while j < len && (src[j].is_ascii_hexdigit() || matches!(src[j], 'x' | 'X' | '.')) {
				j += 1;
			}
			if j < len && (src[j] == '-' || src[j] == '+') && matches!(src[j - 1], 'e' | 'E' | 'p' | 'P') {
				j += 1;
				while j < len && src[j].is_ascii_digit() {
					j += 1;
				}
			}
			tokens.push(("number", src[i..j].iter().collect(), line));
			i = j;
			continue;
		}
		tokens.push(("punct", c.to_string(), line));
		i += 1;
	}
	Ok(tokens)
}

// ------------------------------------------------------------ the file layout

/// A line's kind: 'entry' (L["key"] = "value"), 'todo' (-- L["key"] = ""),
/// 'retired' (a commented translation, -- L["key"] = "value"), 'comment',
/// 'blank', 'code', and 'new' (a line update_locale_text adds).
#[derive(Clone)]
pub struct Line {
	pub text: String,
	pub kind: &'static str,
	pub key: Option<String>,
	pub value: Option<String>,
}

/// One line of a file -> (kind, key, value).
fn classify(line: &str, file: &str, n: usize) -> Result<(&'static str, Option<(String, String)>), String> {
	let shape = |src: &str| -> Option<(String, String)> {
		let t = tokenize(src, file).ok()?;
		if t.len() == 6 && t[0].1 == "L" && t[1].1 == "[" && t[2].0 == "string" && t[3].1 == "]" && t[4].1 == "=" && t[5].0 == "string" {
			return Some((t[2].1.clone(), t[5].1.clone()));
		}
		None
	};
	if line.trim_matches(crate::emit::is_js_space).is_empty() {
		return Ok(("blank", None));
	}
	if line.starts_with("L[") {
		let Some(e) = shape(line) else {
			return Err(format!("{file}:{n}: not one L[\"English\"] = \"translation\" on its own line"));
		};
		return Ok(("entry", Some(e)));
	}
	if let Some(rest) = line.strip_prefix("-- L[").map(|_| &line[3..]) {
		if let Some(e) = shape(rest) {
			return Ok((if e.1.is_empty() { "todo" } else { "retired" }, Some(e)));
		}
	}
	if line.starts_with("--") {
		return Ok(("comment", None));
	}
	Ok(("code", None))
}

/// The files a group header names: "-- UI/Options.lua", "-- Rares/View.lua,
/// Rares/Options.lua", "-- UI/Packs.lua (a note)". [] for any other comment.
fn header_files(line: &str) -> Vec<String> {
	// .replace(/^--\s*/, '')
	let mut text = line.strip_prefix("--").map_or(line, |r| r.trim_start_matches(crate::emit::is_js_space)).to_string();
	// .replace(/\s*\(.*\)\s*$/, ''): from the first "(" whose line holds a later ")" ending the text (with trailing space).
	if let Some(open) = text.find('(') {
		let trimmed_end = text.trim_end_matches(crate::emit::is_js_space);
		if trimmed_end.ends_with(')') && trimmed_end.len() - 1 > open && !text[open..].contains('\n') {
			let before = text[..open].trim_end_matches(crate::emit::is_js_space).len();
			text.truncate(before);
		}
	}
	let is_file = |f: &str| -> bool {
		let Some(stem) = f.strip_suffix(".lua") else { return false };
		!stem.is_empty() && stem.split('/').all(|p| !p.is_empty() && p.bytes().all(|c| c.is_ascii_alphabetic()))
	};
	split_comma_space(&text).into_iter().filter(|f| is_file(f)).map(String::from).collect()
}

/// `.split(/,\s*/)`.
fn split_comma_space(s: &str) -> Vec<&str> {
	let mut out = Vec::new();
	let mut rest = s;
	while let Some(i) = rest.find(',') {
		out.push(&rest[..i]);
		rest = rest[i + 1..].trim_start_matches(crate::emit::is_js_space);
	}
	out.push(rest);
	out
}

pub struct Group {
	pub header: Option<String>,
	pub files: Vec<String>,
	pub lines: Vec<Line>,
	emptied: bool,
}

pub struct LocaleDoc {
	pub head: Vec<String>,
	pub groups: Vec<Group>,
	pub tail: Vec<String>,
}

/// A file's text -> { head, groups: [{ header, files, lines }], tail }:
/// head up to `local L = ns.L`, then a group at each comment line that is not a
/// commented-out L line, and the retired block from its marker to the end.
/// Windows line endings are read as plain ones (sync writes the file back with
/// "\n").
pub fn parse_locale_text(text: &str, file: &str) -> Result<LocaleDoc, String> {
	let text = text.replace("\r\n", "\n");
	let mut lines: Vec<&str> = text.split('\n').collect();
	if lines.last() == Some(&"") {
		lines.pop();
	}
	let Some(start) = lines.iter().position(|l| *l == BODY_START) else {
		return Err(format!("{file}: no \"{BODY_START}\" line, so not in the interface files' layout (docs/TRANSLATING.md)"));
	};
	let head: Vec<String> = lines[..=start].iter().map(|s| s.to_string()).collect();
	let marker = lines.iter().skip(start + 1).position(|l| *l == RETIRED).map(|p| p + start + 1);
	let end = marker.unwrap_or(lines.len());
	let tail: Vec<String> = marker.map_or(Vec::new(), |m| lines[m..].iter().map(|s| s.to_string()).collect());
	let mut groups = vec![Group { header: None, files: Vec::new(), lines: Vec::new(), emptied: false }];
	for (i, l) in lines.iter().enumerate().take(end).skip(start + 1) {
		let (kind, kv) = classify(l, file, i + 1)?;
		if kind == "comment" {
			groups.push(Group { header: Some(l.to_string()), files: header_files(l), lines: Vec::new(), emptied: false });
			continue;
		}
		if kind == "code" {
			return Err(format!("{file}:{}: code after \"{BODY_START}\" (only L[\"...\"] = \"...\" lines and comments belong there)", i + 1));
		}
		let (key, value) = kv.map_or((None, None), |(k, v)| (Some(k), Some(v)));
		groups.last_mut().unwrap().lines.push(Line { text: l.to_string(), kind, key, value });
	}
	Ok(LocaleDoc { head, groups, tail })
}

fn entry_line(key: &str, value: &str) -> String {
	format!("L[{}] = {}", lua_string(key), lua_string(value))
}

fn todo_line(key: &str) -> String {
	format!("-- L[{}] = \"\"", lua_string(key))
}

pub struct LocaleUpdate {
	pub text: String,
	pub added: Vec<String>,
	pub retired: Vec<String>,
	pub dropped: Vec<String>,
	pub filled: Vec<String>,
	pub kept: Vec<String>,
}

/// `typeof o[k] === 'string' && o[k] !== ''`.
fn filled_str(o: &V, k: &str) -> Option<String> {
	o.get(k).as_str().filter(|s| !s.is_empty()).map(String::from)
}

/// Brings an existing file in step with the code's keys (keys: (key, [file])
/// in code order). Lines holding translations stay byte for byte; `fill`
/// ({ key: value }) turns a key's commented-out line, or its new line, into a
/// translation, never one already translated; `retire` ({ key: value }, keys
/// the code lacks) goes to the retired block as comments.
pub fn update_locale_text(text: &str, file: &str, keys: &[(String, Vec<String>)], fill: &V, retire: &V) -> Result<LocaleUpdate, String> {
	let mut doc = parse_locale_text(text, file)?;
	let key_set: HashSet<&str> = keys.iter().map(|(k, _)| k.as_str()).collect();
	let mut out = LocaleUpdate { text: String::new(), added: Vec::new(), retired: Vec::new(), dropped: Vec::new(), filled: Vec::new(), kept: Vec::new() };
	let mut retired_lines: Vec<String> = Vec::new();
	let mut translated: HashSet<String> = HashSet::new();
	for g in &doc.groups {
		for l in &g.lines {
			if l.kind == "entry" {
				translated.insert(l.key.clone().unwrap());
			}
		}
	}
	let mut present: HashSet<String> = HashSet::new();
	for g in &mut doc.groups {
		let had = g.lines.iter().any(|l| l.kind == "entry" || l.kind == "todo");
		let lines = std::mem::take(&mut g.lines);
		for l in lines {
			if l.kind != "entry" && l.kind != "todo" {
				g.lines.push(l);
				continue;
			}
			let key = l.key.clone().unwrap();
			if !key_set.contains(key.as_str()) {
				if l.kind == "entry" {
					out.retired.push(key);
					retired_lines.push(format!("-- {}", l.text));
				} else {
					out.dropped.push(key);
				}
				continue;
			}
			// A key twice: its translation stays; a second "to do" line goes.
			if l.kind == "todo" && (translated.contains(&key) || present.contains(&key)) {
				continue;
			}
			present.insert(key);
			g.lines.push(l);
		}
		g.emptied = had && !g.lines.iter().any(|l| l.kind != "blank");
		for l in &mut g.lines {
			let key = l.key.clone().unwrap_or_default();
			let f = if l.key.is_some() { filled_str(fill, &key) } else { None };
			if l.kind == "todo" && f.is_some() {
				l.text = entry_line(&key, f.as_deref().unwrap());
				l.kind = "entry";
				out.filled.push(key);
			} else if l.kind == "entry" && f.as_ref().is_some_and(|f| Some(f) != l.value.as_ref()) {
				out.kept.push(key);
			}
		}
	}
	// A group whose every line went goes with its header.
	doc.groups.retain(|g| !g.emptied);
	let insert_at = |g: &mut Group, line: String| {
		let mut at = g.lines.len();
		while at > 0 && g.lines[at - 1].kind == "blank" {
			at -= 1;
		}
		g.lines.insert(at, Line { text: line, kind: "new", key: None, value: None });
	};
	// `created`: Map file -> group, in insertion order.
	let mut created: Vec<Group> = Vec::new();
	for (key, where_) in keys {
		if present.contains(key) {
			continue;
		}
		let f = &where_[0];
		let line = match filled_str(fill, key) {
			Some(v) => entry_line(key, &v),
			None => todo_line(key),
		};
		if line.starts_with("L[") {
			out.filled.push(key.clone());
		}
		out.added.push(key.clone());
		let target = doc.groups.iter().rposition(|g| g.files.contains(f));
		match target {
			Some(t) => insert_at(&mut doc.groups[t], line),
			None => {
				let idx = match created.iter().position(|g| g.files.first() == Some(f)) {
					Some(i) => i,
					None => {
						created.push(Group { header: Some(format!("-- {f}")), files: vec![f.clone()], lines: Vec::new(), emptied: false });
						created.len() - 1
					}
				};
				insert_at(&mut created[idx], line);
			}
		}
	}
	let mut lines: Vec<String> = doc.head.clone();
	let groups: Vec<Group> = doc.groups.into_iter().chain(created).collect();
	let n = groups.len();
	for (i, g) in groups.into_iter().enumerate() {
		if let Some(h) = g.header {
			if lines.last().is_some_and(|l| !l.is_empty()) {
				lines.push(String::new());
			}
			lines.push(h);
		}
		lines.extend(g.lines.into_iter().map(|l| l.text));
		if i == n - 1 {
			while lines.last().is_some_and(|l| l.is_empty()) {
				lines.pop();
			}
		}
	}
	let mut tail = doc.tail.clone();
	let mut retire_entries = retire.entries();
	retire_entries.sort_by(|a, b| cmp_utf16(&a.0, &b.0));
	for (k, v) in retire_entries {
		let v = v.to_js_string();
		let line = format!("-- {}", entry_line(&k, &v));
		if key_set.contains(&*k) || v.is_empty() || tail.contains(&line) || retired_lines.contains(&line) {
			continue;
		}
		out.retired.push(k.to_string());
		retired_lines.push(line);
	}
	if !retired_lines.is_empty() {
		if tail.is_empty() {
			tail.push(RETIRED.into());
		}
		tail.extend(retired_lines);
	}
	if !tail.is_empty() {
		lines.push(String::new());
		lines.extend(tail);
	}
	out.text = format!("{}\n", lines.join("\n"));
	Ok(out)
}

/// A new locale file: its header, then every key grouped under the file that
/// first uses it in load order, translated from `fill` or commented out.
/// `title`: the JS default is "Polestar's interface strings".
pub fn new_locale_text(locale: &str, keys: &[(String, Vec<String>)], fill: &V, retire: &V, title: &str) -> Result<LocaleUpdate, String> {
	let language = locales::locale(locale).map_or(locale, |m| m.language);
	let head = [
		format!("-- {language} ({locale}): {title}."),
		"-- Keys are the English strings exactly as the code writes them; a key".into(),
		"-- missing here, or commented out, shows in English. Grouped by the file that".into(),
		"-- first uses each key. docs/TRANSLATING.md explains the rest.".into(),
		String::new(),
		"local _, ns = ...".into(),
		format!("if not (GetLocale and GetLocale() == {}) then return end", lua_string(locale)),
		BODY_START.into(),
	];
	update_locale_text(&format!("{}\n", head.join("\n")), &format!("Locales/{locale}.lua"), keys, fill, retire)
}

#[cfg(all(test, feature = "native"))]
mod tests {
	use super::*;
	use std::time::{Duration, Instant};

	/// A locale file holding `src` in a fresh temporary folder.
	fn hostile(name: &str, src: &str) -> String {
		let dir = std::env::temp_dir().join(format!("forge-i18n-limits-{}-{name}", std::process::id()));
		std::fs::create_dir_all(&dir).unwrap();
		let file = dir.join("deDE.lua");
		std::fs::write(&file, src).unwrap();
		file.to_string_lossy().into_owned()
	}

	/// Loads `src` as a locale file within `time` and `memory`, on a thread so a hook that never
	/// fires fails the test instead of hanging it. -> (whether the chunk ran clean, its error or the run's).
	fn load(name: &str, src: &str, time: Duration, memory: usize) -> (bool, String) {
		let expr = format!("local ok, err = __polestar_loaddata({}) return {{ ok = ok, err = tostring(err) }}", lua_string(&hostile(name, src)));
		let (tx, rx) = std::sync::mpsc::channel();
		std::thread::spawn(move || {
			let _ = tx.send(lua_to_json_within(&expr, time, memory).map(|v| (v.get("ok").truthy(), v.get("err").to_js_string())));
		});
		match rx.recv_timeout(Duration::from_secs(30)).expect("the Lua run did not stop") {
			Ok(r) => r,
			Err(e) => (false, e),
		}
	}

	#[test]
	fn an_endless_locale_file_stops_at_the_deadline_and_cannot_catch_its_error() {
		let started = Instant::now();
		let (ok, err) = load("loop", "while true do end", Duration::from_millis(500), 64 << 20);
		assert!(!ok);
		assert!(err.contains("took longer than 0.5 s"), "{err}");
		assert!(started.elapsed() < Duration::from_secs(10), "{:?}", started.elapsed());
		// Catching the limit's error to loop on: neither pcall, xpcall nor a coroutine is there.
		for (name, src) in [
			("pcall", "while true do pcall(function() while true do end end) end"),
			("xpcall", "while true do xpcall(function() while true do end end, print) end"),
			("coroutine", "while true do coroutine.resume(coroutine.create(function() while true do end end)) end"),
		] {
			let started = Instant::now();
			let (ok, err) = load(name, src, Duration::from_millis(500), 64 << 20);
			assert!(!ok, "{name}");
			assert!(err.contains(&format!("global '{name}' (a nil value)")), "{name}: {err}");
			assert!(started.elapsed() < Duration::from_secs(10), "{name}: {:?}", started.elapsed());
		}
	}

	#[test]
	fn a_locale_file_filling_memory_stops_at_the_limit() {
		let (ok, err) = load("memory", "local t = {} for i = 1, 1e9 do t[i] = ('x'):rep(1e6) .. i end", Duration::from_secs(10), 64 << 20);
		assert!(!ok);
		assert!(err.contains("memory"), "{err}");
	}

	#[test]
	fn read_locale_files_applies_the_memory_limit() {
		let file = hostile("read", "local t = {} for i = 1, 1e9 do t[i] = ('x'):rep(1e6) .. i end");
		let r = read_locale_files(&[(file, "deDE".into())]).unwrap();
		assert!(!r[0].ok);
		assert!(r[0].error.as_deref().unwrap_or("").contains("memory"), "{:?}", r[0].error);
	}
}
