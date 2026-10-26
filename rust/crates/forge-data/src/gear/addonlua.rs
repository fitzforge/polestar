//! tools/lib/consume/lua.js: the shared reader for other addons' Lua data (`readAddonLua`,
//! `pairsToObject`, `addonVersion`) over [`crate::lua::lua_to_value`].

use std::path::{Path, PathBuf};

use forge_guide::js::{cmp_utf16, Obj, V};

const HELPERS: &str = r#"
local function POLESTAR_cmp(a, b)
  local ta, tb = type(a), type(b)
  if ta ~= tb then return ta < tb end
  if ta == "number" or ta == "string" then return a < b end
  return tostring(a) < tostring(b)
end
function POLESTAR_pairs(t)
  local out = {}
  if type(t) ~= "table" then return out end
  local keys = {}
  for k in pairs(t) do keys[#keys + 1] = k end
  table.sort(keys, POLESTAR_cmp)
  for i, k in ipairs(keys) do out[i] = { k, t[k] } end
  return out
end
local __stubmt = {}
POLESTAR_STUB = setmetatable({}, __stubmt)
__stubmt.__index = function() return POLESTAR_STUB end
__stubmt.__call = function() return POLESTAR_STUB end
__stubmt.__concat = function(a, b)
  local function s(v) if v == POLESTAR_STUB then return "" end return tostring(v) end
  return s(a) .. s(b)
end
__stubmt.__tostring = function() return "" end
POLESTAR_G = setmetatable({}, {
  __index = function(_, k) return rawget(_G, k) end,
  __newindex = function(_, k, v) rawset(_G, k, v) end,
})
POLESTAR_NS = {}
"#;

/// Version line of an addon's TOC (the first TOC by name holding one).
pub fn addon_version(dir: &Path) -> Option<String> {
	let mut files: Vec<String> = std::fs::read_dir(dir).ok()?.flatten().map(|e| e.file_name().to_string_lossy().into_owned()).filter(|f| f.ends_with(".toc")).collect();
	files.sort_by(|a, b| cmp_utf16(a, b));
	let re = regex::Regex::new(r"(?m)^##\s*Version:\s*(.+)$").unwrap();
	for f in files {
		let Ok(bytes) = std::fs::read(dir.join(&f)) else { continue };
		let text = String::from_utf8_lossy(&bytes);
		if let Some(m) = re.captures(&text) {
			return Some(forge_guide::lexer::js_trim(&m[1]).to_string());
		}
	}
	None
}

/// The Version line of one named TOC (`addonVersion(dir, toc)`).
pub fn addon_version_in(dir: &Path, toc: &str) -> Option<String> {
	let bytes = std::fs::read(dir.join(toc)).ok()?;
	let text = String::from_utf8_lossy(&bytes);
	let re = regex::Regex::new(r"(?m)^##\s*Version:\s*(.+)$").unwrap();
	re.captures(&text).map(|m| forge_guide::lexer::js_trim(&m[1]).to_string())
}

/// lua.js `luaQuote`.
pub fn lua_quote(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n").replace('\r', "\\r"))
}

struct TempDir(PathBuf);
impl Drop for TempDir {
	fn drop(&mut self) {
		std::fs::remove_dir_all(&self.0).ok();
	}
}

fn temp_dir() -> Result<TempDir, String> {
	use std::sync::atomic::{AtomicUsize, Ordering};
	static N: AtomicUsize = AtomicUsize::new(0);
	let nanos = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map(|d| d.as_nanos()).unwrap_or(0);
	let dir = std::env::temp_dir().join(format!("polestar-consume-{}-{nanos}-{}", std::process::id(), N.fetch_add(1, Ordering::Relaxed)));
	std::fs::create_dir_all(&dir).map_err(|e| format!("{}: {e}", dir.display()))?;
	Ok(TempDir(dir))
}

/// -> the value of `expr`. Files load in order, sandboxed, each called with `...` = addonName and
/// the shared namespace POLESTAR_NS; `getfenv(0)`/`getfenv()` read as POLESTAR_G.
pub fn read_addon_lua(files: &[PathBuf], addon_name: &str, prelude: &str, expr: &str) -> Result<V, String> {
	read_addon_lua_with(files, addon_name, prelude, expr, &|src, _| src)
}

/// [`read_addon_lua`] with `rewrite(source, file)` applied to each file's bytes after the getfenv
/// rewrite (lua.js's `rewrite` option).
pub fn read_addon_lua_with(files: &[PathBuf], addon_name: &str, prelude: &str, expr: &str, rewrite: &dyn Fn(Vec<u8>, &Path) -> Vec<u8>) -> Result<V, String> {
	let tmp = temp_dir()?;
	let getfenv = regex::bytes::Regex::new(r"\bgetfenv\s*\(\s*0?\s*\)").unwrap();
	let mut loads = Vec::with_capacity(files.len());
	for (i, file) in files.iter().enumerate() {
		let src = std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?;
		if src.first() == Some(&27) {
			return Err(format!("{}: precompiled Lua is not accepted", file.display()));
		}
		let src = src.strip_prefix(b"\xEF\xBB\xBF").unwrap_or(&src);
		let src = rewrite(getfenv.replace_all(src, &b"POLESTAR_G"[..]).into_owned(), file);
		let name = file.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default();
		let copy = tmp.0.join(format!("{i:04}-{name}"));
		std::fs::write(&copy, &src).map_err(|e| format!("{}: {e}", copy.display()))?;
		loads.push(format!(
			"do\n  local ok, err = __polestar_loaddata({}, {}, POLESTAR_NS)\n  if not ok then error({} .. \": \" .. tostring(err), 0) end\nend",
			lua_quote(&copy.to_string_lossy()),
			lua_quote(addon_name),
			lua_quote(&file.to_string_lossy())
		));
	}
	crate::lua::lua_to_value(&[], &format!("{HELPERS}\n{prelude}\n{}", loads.join("\n")), expr)
}

/// [[k, v], ...] (from POLESTAR_pairs) -> { k: v }.
pub fn pairs_to_object(list: &V) -> Obj {
	let out = Obj::new();
	for p in list.items() {
		out.set(&p.at(0).to_js_string(), p.at(1));
	}
	out
}
