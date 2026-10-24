//! build.js `measureMemory`: the pack's memory in Lua 5.1 with the real Codex.lua, before and after
//! decoding every record. Lua's counts depend on the interpreter's whole state (its string table
//! grows in powers of two), so this runs build.js's program as the `lua5.1` standalone interpreter
//! runs it: every standard library, the `arg` table, the program as a file, the pack's files
//! read with `dofile` (written to a scratch folder first).

use std::path::Path;

use mlua::{Lua, LuaOptions, StdLib};

pub struct Memory {
	pub raw_kb: f64,
	pub decoded_kb: f64,
	pub records: f64,
	pub load_ms: f64,
}

/// build.js `luaString`.
fn lua_string(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n"))
}

/// files: the pack's (name, text); order: TOC order of the Lua files.
pub fn measure(codex_lua: &Path, order: &[String], files: &[(String, String)]) -> Result<Memory, String> {
	let pid = std::process::id();
	let dir = std::env::temp_dir().join(format!("polestar-codex-pack-{pid}"));
	let _ = std::fs::remove_dir_all(&dir);
	std::fs::create_dir_all(&dir).map_err(|e| e.to_string())?;
	let res = (|| {
		let mut paths = Vec::new();
		for f in order {
			let text = files.iter().find(|(n, _)| n == f).map(|(_, t)| t.as_str()).ok_or_else(|| format!("measuring pack memory failed: no {f}"))?;
			let p = dir.join(f);
			std::fs::write(&p, text).map_err(|e| e.to_string())?;
			paths.push(lua_string(&p.to_string_lossy()));
		}
		let program = format!(
			r#"
local ns = {{}}
Polestar = ns
function ns.RegisterMapFrames() end
loadfile({codex})("Polestar", ns)
local C = ns.Codex
collectgarbage("collect"); collectgarbage("collect")
local base = collectgarbage("count")
local t0 = os.clock()
for _, f in ipairs({{ {files} }}) do dofile(f) end
local loadMs = (os.clock() - t0) * 1000
collectgarbage("collect"); collectgarbage("collect")
local raw = collectgarbage("count") - base
local keep = {{}}
local get = {{ item = C.Item, mount = C.Item, pet = C.Item, recipe = C.Item, tabard = C.Item, npc = C.Npc, rare = C.Npc,
	object = C.Object, treasure = C.Object, quest = C.Quest, instance = C.Instance, zone = C.Zone, faction = C.Faction, spell = C.Spell }}
for kind, fn in pairs(get) do
	C.Each(kind, function(id) keep[#keep + 1] = fn(id) end)
end
collectgarbage("collect"); collectgarbage("collect")
local decoded = collectgarbage("count") - base
io.write(string.format("%.1f %.1f %d %.1f\n", raw, decoded, #keep, loadMs))
"#,
			codex = lua_string(&codex_lua.to_string_lossy()),
			files = paths.join(", ")
		);
		let script = std::env::temp_dir().join(format!("polestar-codex-mem-{pid}.lua"));
		std::fs::write(&script, &program).map_err(|e| e.to_string())?;
		let out = run(&script, &program);
		let _ = std::fs::remove_file(&script);
		out
	})();
	let _ = std::fs::remove_dir_all(&dir);
	res
}

fn run(script: &Path, program: &str) -> Result<Memory, String> {
	let e = |x: mlua::Error| format!("measuring pack memory failed:\n{x}");
	// SAFETY: the debug library is loaded as the standalone interpreter loads it; the program is ours.
	let lua = unsafe { Lua::unsafe_new_with(StdLib::ALL, LuaOptions::default()) };
	let arg = lua.create_table().map_err(e)?;
	arg.raw_set(-1, "lua5.1").map_err(e)?;
	arg.raw_set(0, script.to_string_lossy().to_string()).map_err(e)?;
	lua.globals().raw_set("arg", arg).map_err(e)?;
	// io.write's output, captured.
	let out = std::rc::Rc::new(std::cell::RefCell::new(String::new()));
	let o2 = out.clone();
	let capture = lua
		.create_function(move |_, s: mlua::String| {
			o2.borrow_mut().push_str(&s.to_str()?);
			Ok(())
		})
		.map_err(e)?;
	let io: mlua::Table = lua.globals().get("io").map_err(e)?;
	io.raw_set("write", capture).map_err(e)?;
	drop(io);
	lua.load(program).set_name(format!("@{}", script.display())).exec().map_err(e)?;
	let s = out.borrow().clone();
	let n: Vec<f64> = s.split_whitespace().map(forge_guide::js::str_to_num).collect();
	if n.len() < 4 {
		return Err(format!("measuring pack memory failed: {s}"));
	}
	Ok(Memory { raw_kb: n[0], decoded_kb: n[1], records: n[2], load_ms: n[3] })
}
