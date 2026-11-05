//! The addon's Lua tests: addon/ runs on the WoW client stub (tests/lua/wow_stub.lua and the other stubs)
//! in-process, on PUC Lua 5.1 (mlua, vendored), a fresh Lua state per run; no `lua` binary is needed.
//! The tests are this crate's `tests/<name>.rs`, one per former `tests/<name>.test.js`.
//!
//! # Running addon code: [`run_addon`]
//!
//! ```no_run
//! use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
//! let out = emitted(&RunAddon {
//! 	stubs: vec!["stub_world.lua"],                    // more files of tests/lua, after wow_stub.lua
//! 	before: "stub.world.setLevel(3)".into(),          // Lua run after the stubs, before any addon file
//! 	addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
//! 	saved: vec![("Polestar".into(), "PolestarDB = { schema = 1 }".into())], // before its ADDON_LOADED
//! 	login: true,                                      // PLAYER_LOGIN / PLAYER_ENTERING_WORLD after loading
//! 	script: format!("{TEST_PACK}\n{TEST_SOURCE}\nemit(Polestar.Engine.GetStepIndex())"),
//! });
//! assert_eq!(out[0], 1);
//! ```
//!
//! Addons load the way the client loads them: every file of the TOC, XML manifests expanded in order, each
//! chunk called with (addonName, ns) and listed in `stub.addonSources` (the stub's map guard tells addon code
//! by it). [`Addon::name`] loads addon/<name> by its TOC, [`Addon::files`] a subset of it (paths relative to
//! the addon folder or absolute; `.xml` expanded), [`Addon::dir`] an addon folder anywhere (a built pack) by
//! its TOC. `emit(value)` in Lua writes one JSON line; [`run_addon`] returns those values in order as
//! `serde_json::Value`, the same JSON the old harness parsed (integers as integers, other numbers `%.14g`,
//! object keys sorted, a nil field absent). A Lua error is `Err` with its file:line and traceback;
//! [`emitted`] panics with it. `print` and `io.write` go to [`Output::stdout`] ([`run_addon_output`]).
//!
//! # Porting a tests/<name>.test.js
//!
//! 1. Create `tests/<name>.rs` here; keep the file's header comment as `//!` docs. Each JS `test('words',
//!    ...)` becomes one `#[test] fn words()` named after the test's words in snake_case (letters and digits,
//!    everything else `_`, collapsed; a name starting with a digit gets `t_`).
//! 2. Lua stays Lua: copy WORLD/GUIDE/script strings into `const` raw strings (`r#"..."#`) and the template
//!    literals into `format!` (double any `{`/`}` of the Lua in a `format!` string, or concatenate with
//!    `concat!`/`+` instead). `${TEST_PACK}` / `${TEST_SOURCE}` are [`TEST_PACK`] / [`TEST_SOURCE`].
//!    `luaValue(x)` is [`lua_value`]`(&json!(x))`.
//! 3. `runAddon({...}).emitted` is [`emitted`]`(&RunAddon { ..Default::default() })`; `{ name, files }` is
//!    [`Addon::files`], `{ name, dir }` [`Addon::dir`], a string [`Addon::name`] (or `"Polestar".into()`).
//!    `assert.throws(() => runAddon(..), /re/)` is `let e = run_addon(..).unwrap_err(); assert!(is_match(&e, "re"))`.
//! 4. Assertions: `assert.equal(a, b)` → `assert_eq!(a, b)` (a `Value` compares with `i32`, `f64`, `bool`,
//!    `&str` directly: `assert_eq!(v["step"], 2)`); `assert.deepEqual(a, {...})` → `assert_eq!(a, json!({...}))`
//!    (write integral numbers without `.0`); `assert.equal(x, undefined)` → `assert!(x.is_null())`;
//!    `assert.ok(x)` → `assert!(`[`truthy`]`(&x))`; `assert.match(s, /re/)` → `assert!(`[`is_match`]`(s, r"re"))`
//!    with the same pattern (JS and Rust regex syntax agree on what these tests use; `/re/s` → `(?s)`).
//!    Keep each assertion's message as the macro's message.
//! 5. Guide text: [`dsl::guide_text`], [`dsl::line_of`], [`dsl::compile`] / [`dsl::compile_with`]
//!    (`compile(text, data, { pack })`), [`dsl::plain`] (`plain(r.guides[0])`), [`dsl::write_our_test_pack`] /
//!    [`dsl::write_test_pack`] (`writeTestPack`; keep the returned [`dsl::TestPack`] alive while Lua reads
//!    it). Temp folders: [`tmp::TempDir`]. Codex packs: [`codex::write_codex_pack`]. A fake translation:
//!    [`fake_locale`]; names packs (helpers/names.js): [`names::names_pack`]; tests on data/forever: `needs!("quests.json")`. `luac -p`/`-l`: [`luac`].
//!    playtest's SIMULATE: [`playtest::SIMULATE`]. JS tool calls go to their Rust ports (forge_guide,
//!    forge_data) by the same names in snake_case.
//! 6. Run `heavy.sh cargo test -j 3 --release -p forge-addontest --test <name>`; when it passes, delete the
//!    JS file. A JS helper the file needs that is not here yet (navscene.js, spfnav.js,
//!    playtest's buildSimPack, the CLI) is ported into this crate as a module first, beside [`dsl`].

pub mod codex;
pub mod dsl;
pub mod locale;
pub mod luac;
pub mod names;
pub mod navmap;
pub mod playtest;
pub mod questdb;
pub mod run;
pub mod tmp;

pub use locale::fake_locale;
pub use run::{build_program, emitted, lua_string, lua_value, run_addon, run_addon_output, Addon, Output, RunAddon};

/// The Lua line registering the pack the tests put their guides in: pack `test`, guide ids under `test/`
/// (docs/PACK_FORMAT.md, "Rules Polestar enforces").
pub const TEST_PACK: &str = r#"Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })"#;

/// The Lua line making the test pack the suggestion source (behavior.suggestFrom): only ours and the chosen
/// pack are ever suggested, so a test whose character is to be given a test guide (Suggest, a guide loaded
/// at login) runs it too.
pub const TEST_SOURCE: &str = r#"Polestar.Set("behavior.suggestFrom", "test")"#;

/// JS truthiness of an emitted value (`assert.ok`): null, false, 0 and "" are false.
pub fn truthy(v: &serde_json::Value) -> bool {
	match v {
		serde_json::Value::Null => false,
		serde_json::Value::Bool(b) => *b,
		serde_json::Value::Number(n) => n.as_f64().is_some_and(|f| f != 0.0),
		serde_json::Value::String(s) => !s.is_empty(),
		_ => true,
	}
}

/// Whether `pattern` (a regex) matches somewhere in `text` (`assert.match`).
pub fn is_match(text: &str, pattern: &str) -> bool {
	regex::Regex::new(pattern).unwrap_or_else(|e| panic!("bad pattern {pattern}: {e}")).is_match(text)
}

/// A string value's text, "" for anything else (`${v || ''}`).
pub fn text(v: &serde_json::Value) -> &str {
	v.as_str().unwrap_or("")
}
