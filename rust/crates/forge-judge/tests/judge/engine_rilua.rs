//! Engine parity against the real addon run in process by rilua (a Lua 5.1 in Rust) instead of lua5.1:
//! the shipped Orc Warrior chain played from its first guide through `next` to the end, as
//! tests/engine_parity.rs plays it, must complete the same goals in the same order (ticks, stucks each
//! skipped, missing locations) in the Rust replay. The Lua program is engine-chain.js's own (the stub
//! world, the addon by its TOC, the compiled pack, playtest.js's SIMULATE with the recorder), written
//! out once by tests/js/engine-program.js (node) and cached in rust/target/judge-ref/rilua-orc
//! (POLESTAR_REF_REFRESH=1 rebuilds it); only the play runs in rilua. When lua5.1's trace is cached
//! (engine_parity.rs, engine-orc.json) the two interpreters' traces must match byte for byte as well.
//! Default: `slice_orc_warrior_chain`, the clean guide slice's Orc chain (rust/tests/golden/engine/rilua-orc
//! and orc.json, its README). Optional extra: the shipped chain, skipped with a note when
//! $POLESTAR_CHECKOUT (a checkout with the shipped guides and built data/forever) is unset or lacks them,
//! or node is absent. Both are ignored in debug builds
//! (an unoptimised rilua takes minutes): `cargo test --release -p forge-judge --test engine_rilua`.
//!
//! rilua 0.1.27's parser keeps counting a `for` loop's locals after the loop ends, so a chunk with
//! many loops (Engine.lua's main chunk) fails with "function at line 0 has more than 200 local
//! variables", which PUC-Rio does not. Files are loaded with each `for ... end` wrapped in
//! `do ... end` (same lines, same meaning), which closes the scope the way the parser expects.

use crate::common;

use forge_guide::data::load_data;
use forge_guide::diag::Diagnostics;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use forge_judge::engine::{self, Character, Event, OnStuck, Replay, WorldData};
use rilua::compiler::lexer::Lexer;
use rilua::compiler::token::Token;
use rilua::vm::state::LuaState;
use rilua::{Lua, LuaApiMut, LuaResult, RustFn, StdLib, Val};
use serde_json::Value;
use std::path::{Path, PathBuf};
use std::process::Command;
use std::time::Instant;

fn checkout() -> Option<PathBuf> {
	std::env::var_os("POLESTAR_CHECKOUT").map(PathBuf::from)
}

fn data() -> PathBuf {
	checkout().expect("POLESTAR_CHECKOUT").join("data/forever")
}

fn crate_dir() -> PathBuf {
	PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn ref_dir() -> PathBuf {
	crate_dir().join("../../target/judge-ref")
}

/// `src` with every `for ... end` wrapped in `do ... end`, on the same lines.
fn scope_for_loops(src: &[u8], name: &str) -> Vec<u8> {
	let mut line_start = vec![0usize];
	line_start.extend(src.iter().enumerate().filter(|(_, &b)| b == b'\n').map(|(i, _)| i + 1));
	let offset = |line: u32, column: u32| line_start[line as usize - 1] + column as usize - 1;
	// Open blocks: (needs a `do` still, is a `for` starting at this offset).
	let mut open: Vec<(bool, Option<usize>)> = Vec::new();
	let mut inserts: Vec<(usize, &[u8])> = Vec::new();
	let mut lexer = Lexer::new(src, name);
	loop {
		let (token, span) = lexer.next().unwrap_or_else(|e| panic!("{name}: {e}"));
		let at = || offset(span.line, span.column);
		match token {
			Token::Eos => break,
			Token::For => {
				assert!(src[at()..].starts_with(b"for"), "{name}:{}: lexer column off", span.line);
				open.push((true, Some(at())));
			}
			Token::While => open.push((true, None)),
			Token::Do => match open.last_mut() {
				Some(top @ (true, _)) => top.0 = false,
				_ => open.push((false, None)),
			},
			Token::If | Token::Function | Token::Repeat => open.push((false, None)),
			Token::End | Token::Until => {
				let (_, for_at) = open.pop().unwrap_or_else(|| panic!("{name}:{}: unbalanced", span.line));
				if let Some(start) = for_at {
					assert!(matches!(token, Token::End) && src[at()..].starts_with(b"end"), "{name}:{}: lexer column off", span.line);
					inserts.push((start, b"do "));
					inserts.push((at() + 3, b" end"));
				}
			}
			_ => {}
		}
	}
	assert!(open.is_empty(), "{name}: unbalanced blocks");
	inserts.sort_by_key(|&(at, _)| at);
	let mut out = Vec::with_capacity(src.len() + inserts.len() * 4);
	let mut from = 0;
	for (at, text) in inserts {
		out.extend_from_slice(&src[from..at]);
		out.extend_from_slice(text);
		from = at;
	}
	out.extend_from_slice(&src[from..]);
	out
}

/// `__scoped_source(path)` -> the file's text with its loops scoped (scope_for_loops), or nil and the error.
fn scoped_source(state: &mut LuaState) -> LuaResult<u32> {
	let path = String::from_utf8(state.check_string(1)?).unwrap();
	match std::fs::read(&path) {
		Ok(src) => {
			let s = state.gc.intern_string(&scope_for_loops(&src, &path));
			state.push(Val::Str(s));
			Ok(1)
		}
		Err(e) => {
			state.push(Val::Nil);
			let s = state.gc.intern_string(format!("cannot open {path}: {e}").as_bytes());
			state.push(Val::Str(s));
			Ok(2)
		}
	}
}

/// The Lua program for the chain (engine-program.js, cached) -> its folder.
fn program(name: &str, root: &Path, first: &str, race: &str, faction: &str, class: &str) -> PathBuf {
	let dir = ref_dir().join(format!("rilua-{name}"));
	if !dir.join("files.json").exists() || std::env::var_os("POLESTAR_REF_REFRESH").is_some() {
		assert!(Command::new("node").arg("-v").output().is_ok(), "rilua engine parity for {name} needs node on PATH");
		let script = crate_dir().join("tests/js/engine-program.js");
		let st = Command::new("node").arg(&script).args([dir.to_str().unwrap(), root.to_str().unwrap(), first, race, faction, class, data().to_str().unwrap(), "skip"]).status().expect("node runs");
		assert!(st.success(), "engine-program.js failed for {name}");
	}
	dir
}

/// Run the program in rilua -> (the result { trace, level }, load + play ms).
fn run_rilua(dir: &Path) -> (Value, u128) {
	let program = std::fs::read(dir.join("program.lua")).unwrap();
	let t0 = Instant::now();
	let mut lua = Lua::new_with(StdLib::ALL).unwrap();
	let f: RustFn = scoped_source;
	lua.register_function("__scoped_source", f).unwrap();
	lua.exec(
		r#"
		function loadfile(path)
			local src, err = __scoped_source(path)
			if not src then return nil, err end
			return loadstring(src, "@" .. path)
		end
		function dofile(path)
			return assert(loadfile(path))()
		end
		"#,
	)
	.unwrap();
	let program = scope_for_loops(&program, "program.lua");
	if let Err(e) = lua.exec_bytes(&program, "@program.lua") {
		panic!("rilua: {e}");
	}
	let result: String = lua.global("RESULT").unwrap();
	let ms = t0.elapsed().as_millis();
	(serde_json::from_str(&result).unwrap(), ms)
}

fn num(v: &Value, k: &str) -> Option<u64> {
	v.get(k).and_then(Value::as_u64)
}

fn text(v: &Value, k: &str) -> Option<String> {
	v.get(k).and_then(Value::as_str).map(str::to_string)
}

/// The Lua trace as engine events (as engine_parity.rs reads it).
fn events_of(trace: &Value) -> Vec<Event> {
	let mut out = Vec::new();
	for e in trace.as_array().unwrap() {
		out.push(match e["k"].as_str().unwrap() {
			"login" => Event::Login { guide: text(e, "id").unwrap_or_default() },
			"guide" => Event::Guide { guide: text(e, "id").unwrap() },
			"goal" => Event::Goal {
				guide: text(e, "g").unwrap(),
				step: num(e, "s").unwrap() as usize,
				goal: num(e, "i").unwrap() as usize,
				verb: text(e, "t").unwrap(),
				id: num(e, "id").map(|n| n as u32),
				ticked: e.get("m").and_then(Value::as_bool).unwrap_or(false),
			},
			"stuck" => Event::Stuck {
				guide: text(e, "g").unwrap(),
				step: num(e, "s").unwrap() as usize,
				goal: num(e, "i").map(|n| n as usize),
				verb: text(e, "t"),
				status: text(e, "status"),
				why: text(e, "why"),
			},
			"missing" => {
				Event::Missing { guide: text(e, "g").unwrap(), goals: e["list"].as_array().unwrap().iter().map(|p| (p[0].as_u64().unwrap() as usize, p[1].as_u64().unwrap() as usize)).collect() }
			}
			other => panic!("unknown trace entry {other}"),
		});
	}
	out
}

/// Compile the chain's files and replay it -> events, replay ms.
fn replay(root: &Path, data_dir: &Path, files: &[String], first_id: &str, race: &str, faction: &str, class: &str) -> (Vec<Event>, u128) {
	let data = load_data(data_dir).expect("data");
	let sources: Vec<Source> = files
		.iter()
		.map(|rel| {
			let file = format!("guides/{rel}");
			Source { source: file.clone(), file, text: std::fs::read_to_string(root.join(rel)).unwrap() }
		})
		.collect();
	let mut diag = Diagnostics::new();
	let compiled = compile_sources(&sources, &data, &mut diag, &CompileOpts { pack: None, author: None, context: None, pack_dir: None });
	let guides: Vec<engine::Guide> = compiled.guides.iter().map(engine::Guide::read).collect();
	let world = WorldData::from_data(&data);
	let t0 = Instant::now();
	let first = guides.iter().find(|g| g.id == first_id).expect("first guide");
	let character = Character::new(faction, race, class, engine::start_level(first));
	let events = Replay::new(&guides, &world, character).play(first_id, OnStuck::Skip).unwrap();
	(events, t0.elapsed().as_millis())
}

fn check_chain(name: &str, root: &Path, first: &str, race: &str, faction: &str, class: &str) {
	let Some(checkout) = checkout() else {
		eprintln!("note: POLESTAR_CHECKOUT unset: rilua engine parity for {name} skipped");
		return;
	};
	if !root.join(first).exists() || !checkout.join("data/forever").exists() {
		eprintln!("note: {} or POLESTAR_CHECKOUT's data/forever absent: rilua engine parity for {name} skipped", root.join(first).display());
		return;
	}
	let dir = program(name, root, first, race, faction, class);
	let lua51 = std::fs::read_to_string(ref_dir().join(format!("engine-{name}.json"))).ok().map(|t| serde_json::from_str::<Value>(&t).unwrap());
	compare(name, &dir, root, &data(), lua51, (race, faction, class));
}

/// rilua's play of the program in `dir` against the Rust replay and, when given, lua5.1's trace
/// (engine-chain.js's of the same chain).
fn compare(name: &str, dir: &Path, root: &Path, data_dir: &Path, lua51: Option<Value>, (race, faction, class): (&str, &str, &str)) {
	let files: Vec<String> = serde_json::from_str(&std::fs::read_to_string(dir.join("files.json")).unwrap()).unwrap();
	let (lua, lua_ms) = run_rilua(dir);
	let want = events_of(&lua["trace"]);
	let first_id = match &want[1] {
		Event::Guide { guide } => guide.clone(),
		e => panic!("trace starts with {e:?}"),
	};
	let (got, play_ms) = replay(root, data_dir, &files, &first_id, race, faction, class);
	let goals = want.iter().filter(|e| matches!(e, Event::Goal { .. })).count();
	let stucks = want.iter().filter(|e| matches!(e, Event::Stuck { .. })).count();
	eprintln!(
		"rilua engine parity {name}: {} guides, {goals} goals, {stucks} stuck; rilua load + play {lua_ms} ms (lua5.1 play {}), Rust replay {play_ms} ms",
		files.len(),
		lua51.as_ref().map_or("not cached".to_string(), |v| format!("{} ms", v["luaMs"]))
	);
	if let Some(i) = (0..want.len().max(got.len())).find(|&i| want.get(i) != got.get(i)) {
		let lo = i.saturating_sub(4);
		let show = |l: &[Event]| l[lo.min(l.len())..(i + 3).min(l.len())].iter().map(|e| format!("  {e:?}")).collect::<Vec<_>>().join("\n");
		panic!("{name}: replay differs at event {i} of {} (Rust {}):\nrilua:\n{}\nRust:\n{}", want.len(), got.len(), show(&want), show(&got));
	}
	if let Some(v) = lua51 {
		assert_eq!(v["trace"], lua["trace"], "{name}: rilua's trace differs from lua5.1's");
		assert_eq!(v["level"], lua["level"], "{name}: rilua's end level differs from lua5.1's");
	}
}

/// The clean guide slice's Orc Warrior chain: the program engine-program.js wrote (golden/engine/rilua-orc,
/// its paths as @REPO@ and @PACK@), run against this checkout's addon, and lua5.1's trace (golden/engine/orc.json).
#[test]
#[cfg_attr(debug_assertions, ignore = "rilua unoptimised is slow: cargo test --release --test engine_rilua")]
fn slice_orc_warrior_chain() {
	let gold = common::golden().join("engine");
	let dir = Path::new(env!("CARGO_TARGET_TMPDIR")).join("rilua-slice-orc");
	let _ = std::fs::remove_dir_all(&dir);
	let copy = |from: &Path, to: &Path| {
		std::fs::create_dir_all(to).unwrap();
		for e in std::fs::read_dir(from).unwrap() {
			let e = e.unwrap();
			std::fs::copy(e.path(), to.join(e.file_name())).unwrap();
		}
	};
	copy(&gold.join("rilua-orc/pack/Polestar_Guides"), &dir.join("pack/Polestar_Guides"));
	std::fs::copy(gold.join("rilua-orc/files.json"), dir.join("files.json")).unwrap();
	let repo = common::golden().join("../../..").canonicalize().unwrap();
	let program = std::fs::read_to_string(gold.join("rilua-orc/program.lua")).unwrap().replace("@PACK@", &dir.join("pack").to_string_lossy()).replace("@REPO@", &repo.to_string_lossy());
	std::fs::write(dir.join("program.lua"), program).unwrap();
	let lua51: Value = serde_json::from_slice(&std::fs::read(gold.join("orc.json")).unwrap()).unwrap();
	compare("slice-orc", &dir, &common::clean_slice("rilua-orc"), &common::data(), Some(lua51), ("Orc", "Horde", "WARRIOR"));
}

#[test]
#[ignore = "needs POLESTAR_CHECKOUT (guides, data/forever) and node; run with --release (unoptimised rilua takes ~5.5 min)"]
fn orc_warrior_chain() {
	check_chain("orc", &checkout().unwrap_or_default().join("guides"), "forever/horde/orc-troll/01-durotar.guide", "Orc", "Horde", "WARRIOR");
}

/// The loop rewrite keeps lines and only adds `do `/` end` around loops (strings and comments untouched).
#[test]
fn scope_for_loops_wraps_loops() {
	let src = b"local s = \"for x end\" -- for\nfor i = 1, 2 do\n  while f(function() for _ in g do end end) do end\nend\nrepeat for k in h do end until x\n";
	let out = scope_for_loops(src, "t");
	assert_eq!(
		String::from_utf8(out).unwrap(),
		"local s = \"for x end\" -- for\ndo for i = 1, 2 do\n  while f(function() do for _ in g do end end end) do end\nend end\nrepeat do for k in h do end end until x\n"
	);
}
