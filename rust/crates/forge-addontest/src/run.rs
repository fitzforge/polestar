//! [`run_addon`]: addon Lua on the client stub, in a fresh Lua 5.1 state per call.

use serde_json::Value;
use std::cell::RefCell;
use std::path::{Path, PathBuf};
use std::rc::Rc;
use std::sync::LazyLock;

/// The repository root (the checkout this crate is in).
pub fn root() -> &'static Path {
	static ROOT: LazyLock<PathBuf> = LazyLock::new(|| Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().expect("repository root"));
	&ROOT
}

/// addon/: the addons tests load by name.
pub fn addons_dir() -> PathBuf {
	root().join("addon")
}

/// tests/lua: the client stub and the other stubs.
pub fn stubs_dir() -> PathBuf {
	root().join("tests/lua")
}

/// An addon to load, as the client loads it.
#[derive(Clone, Debug)]
pub enum Addon {
	/// addon/<name> by its TOC.
	Name(String),
	/// A subset of addon/<name>: paths relative to its folder, or absolute; `.xml` manifests expanded.
	Files(String, Vec<String>),
	/// The addon folder `dir` (anywhere, e.g. a pack built into a temp folder) by its TOC, loaded as `name`.
	Dir(String, PathBuf),
}

impl Addon {
	pub fn name(name: &str) -> Addon {
		Addon::Name(name.into())
	}
	pub fn files(name: &str, files: &[&str]) -> Addon {
		Addon::Files(name.into(), files.iter().map(|f| f.to_string()).collect())
	}
	pub fn dir(name: &str, dir: impl Into<PathBuf>) -> Addon {
		Addon::Dir(name.into(), dir.into())
	}
	fn addon_name(&self) -> &str {
		match self {
			Addon::Name(n) | Addon::Files(n, _) | Addon::Dir(n, _) => n,
		}
	}
}

impl From<&str> for Addon {
	fn from(name: &str) -> Addon {
		Addon::name(name)
	}
}

/// One run: tests/lua/wow_stub.lua, then `stubs` (more files of tests/lua), `before` (Lua), each addon of
/// `addons` (its files in load order, each chunk called with (addonName, ns); then its `saved` Lua, then
/// ADDON_LOADED), PLAYER_LOGIN / PLAYER_ENTERING_WORLD when `login`, then `script`. All of it is one chunk,
/// so a `local` of `before` is seen by `script`.
#[derive(Clone, Debug, Default)]
pub struct RunAddon {
	pub stubs: Vec<&'static str>,
	pub before: String,
	pub addons: Vec<Addon>,
	/// (addon name, Lua restoring its saved variables), run before its ADDON_LOADED.
	pub saved: Vec<(String, String)>,
	pub login: bool,
	pub script: String,
}

fn norm(p: &str) -> String {
	p.replace('\\', "/")
}

fn shown(p: &Path) -> String {
	p.strip_prefix(root()).unwrap_or(p).display().to_string()
}

/// `dir` joined with a manifest path (either separator), `.` and `..` resolved as Node's path.join does.
pub fn join(dir: &Path, rel: &str) -> PathBuf {
	let mut out = PathBuf::new();
	for c in dir.join(norm(rel)).components() {
		match c {
			std::path::Component::CurDir => {}
			std::path::Component::ParentDir => {
				out.pop();
			}
			c => out.push(c),
		}
	}
	out
}

/// Files an XML manifest loads, in order. Only `<Script file>` and `<Include file>` are used by Polestar's
/// manifests.
pub fn xml_files(xml: &Path) -> Result<Vec<PathBuf>, String> {
	static COMMENT: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r"(?s)<!--.*?-->").unwrap());
	static TAG: LazyLock<regex::Regex> = LazyLock::new(|| regex::Regex::new(r#"<(Script|Include)\s+file\s*=\s*"([^"]+)"\s*/?>"#).unwrap());
	let (comment, tag) = (&*COMMENT, &*TAG);
	let dir = xml.parent().unwrap_or(Path::new("."));
	let raw = std::fs::read_to_string(xml).map_err(|e| format!("{}: {e}", shown(xml)))?;
	let text = comment.replace_all(&raw, "");
	let mut out = Vec::new();
	for m in tag.captures_iter(&text) {
		let target = join(dir, &m[2]);
		if !target.exists() {
			return Err(format!("{} references missing {}", shown(xml), &m[2]));
		}
		if &m[1] == "Include" || target.to_string_lossy().to_lowercase().ends_with(".xml") {
			out.extend(xml_files(&target)?);
		} else {
			out.push(target);
		}
	}
	Ok(out)
}

fn expand(addon_dir: &Path, entries: &[String]) -> Result<Vec<PathBuf>, String> {
	let mut out = Vec::new();
	for rel in entries {
		let target = if Path::new(rel).is_absolute() { PathBuf::from(rel) } else { join(addon_dir, rel) };
		if !target.exists() {
			return Err(format!("{}: missing {rel}", shown(addon_dir)));
		}
		if target.to_string_lossy().to_lowercase().ends_with(".xml") {
			out.extend(xml_files(&target)?);
		} else {
			out.push(target);
		}
	}
	Ok(out)
}

/// The TOC's file list (lines that are not blank, comments or `##` metadata).
pub fn toc_entries(addon_dir: &Path) -> Result<Vec<String>, String> {
	let name = addon_dir.file_name().map(|n| n.to_string_lossy().into_owned()).unwrap_or_default();
	let toc = addon_dir.join(format!("{name}.toc"));
	let text = std::fs::read_to_string(&toc).map_err(|_| format!("no TOC at {}", shown(&toc)))?;
	Ok(text.lines().map(str::trim).filter(|l| !l.is_empty() && !l.starts_with('#')).map(String::from).collect())
}

/// The files an addon folder's TOC loads, in order (the folder may be anywhere).
pub fn dir_files(dir: &Path) -> Result<Vec<PathBuf>, String> {
	expand(dir, &toc_entries(dir)?)
}

/// The files addon/<name>'s TOC loads, in order.
pub fn toc_files(name: &str) -> Result<Vec<PathBuf>, String> {
	dir_files(&addons_dir().join(name))
}

/// A Lua string literal.
pub fn lua_string(s: &str) -> String {
	format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n"))
}

fn path_str(p: &Path) -> String {
	lua_string(&p.to_string_lossy())
}

/// The program [`run_addon`] runs (one chunk).
pub fn build_program(opts: &RunAddon) -> Result<String, String> {
	let stubs = stubs_dir();
	let mut lines = vec![format!("package.path = {} .. package.path", lua_string(&format!("{}/?.lua;", stubs.display()))), format!("dofile({})", path_str(&stubs.join("wow_stub.lua")))];
	for s in &opts.stubs {
		lines.push(format!("dofile({})", path_str(&stubs.join(s))));
	}
	if !opts.before.is_empty() {
		lines.push(opts.before.clone());
	}
	lines.push(
		"local function __load(name, files, saved)
  local ns = {}
  for _, f in ipairs(files) do
    local chunk, err = loadfile(f)
    if not chunk then error(err, 0) end
    stub.addonSources[\"@\" .. f] = name
    chunk(name, ns)
  end
  if saved then saved() end
  stub.addonLoaded(name)
  return ns
end"
		.into(),
	);
	for entry in &opts.addons {
		let name = entry.addon_name();
		let files = match entry {
			Addon::Name(n) => toc_files(n)?,
			Addon::Files(n, files) => expand(&addons_dir().join(n), files)?,
			Addon::Dir(_, dir) => dir_files(dir)?,
		};
		let saved = opts.saved.iter().find(|(n, _)| n == name).map_or_else(|| "nil".to_string(), |(_, lua)| format!("function() {lua} end"));
		let list: Vec<String> = files.iter().map(|f| path_str(f)).collect();
		lines.push(format!("__load({}, {{ {} }}, {saved})", lua_string(name), list.join(", ")));
	}
	if opts.login {
		lines.push("stub.login()".into());
	}
	if !opts.script.is_empty() {
		lines.push(opts.script.clone());
	}
	Ok(lines.join("\n"))
}

/// What a run wrote: the emitted values, and its whole output (io.write and print).
#[derive(Clone, Debug)]
pub struct Output {
	pub emitted: Vec<Value>,
	pub stdout: String,
}

/// The values a program emitted (its `@@JSON ` lines), in order.
pub fn parse_emitted(stdout: &str) -> Result<Vec<Value>, String> {
	stdout.split('\n').filter_map(|l| l.strip_prefix("@@JSON ")).map(|j| serde_json::from_str(j).map_err(|e| format!("emitted JSON {j}: {e}"))).collect()
}

/// Runs the program; a Lua error (with its file:line and traceback) and the output so far are the Err.
pub fn run_addon_output(opts: &RunAddon) -> Result<Output, String> {
	let program = build_program(opts)?;
	let fail = |e: mlua::Error| format!("Lua failed:\n{e}");
	// SAFETY: the standard libraries as the standalone interpreter loads them (the stub reads debug.getinfo);
	// the code is the repository's own.
	let lua = unsafe { mlua::Lua::unsafe_new_with(mlua::StdLib::ALL, mlua::LuaOptions::default()) };
	let out = Rc::new(RefCell::new(Vec::<u8>::new()));
	let write = {
		let out = out.clone();
		lua.create_function(move |lua, args: mlua::Variadic<mlua::Value>| {
			let mut o = out.borrow_mut();
			for v in args {
				match lua.coerce_string(v)? {
					Some(s) => o.extend_from_slice(&s.as_bytes()),
					None => return Err(mlua::Error::runtime("bad argument to 'write' (string expected)")),
				}
			}
			Ok(())
		})
		.map_err(fail)?
	};
	let print = {
		let out = out.clone();
		lua.create_function(move |lua, args: mlua::Variadic<mlua::Value>| {
			let tostring: mlua::Function = lua.globals().get("tostring")?;
			let mut o = out.borrow_mut();
			for (i, v) in args.into_iter().enumerate() {
				if i > 0 {
					o.push(b'\t');
				}
				let s: mlua::String = tostring.call(v)?;
				o.extend_from_slice(&s.as_bytes());
			}
			o.push(b'\n');
			Ok(())
		})
		.map_err(fail)?
	};
	let io: mlua::Table = lua.globals().get("io").map_err(fail)?;
	io.raw_set("write", write).map_err(fail)?;
	lua.globals().raw_set("print", print).map_err(fail)?;
	// os.clock is the process's CPU time in C; tests run many Lua states at once in one process, so it is this
	// thread's CPU time here, as it was the run's own process under the standalone interpreter.
	let os: mlua::Table = lua.globals().get("os").map_err(fail)?;
	os.raw_set("clock", lua.create_function(|_, ()| Ok(thread_cpu_seconds())).map_err(fail)?).map_err(fail)?;
	let result = lua.load(&program).set_name("=test program").exec();
	let stdout = String::from_utf8_lossy(&out.borrow()).into_owned();
	if let Err(e) = result {
		return Err(format!("{}\n{stdout}", fail(e)));
	}
	Ok(Output { emitted: parse_emitted(&stdout)?, stdout })
}

/// The values the run emitted, in order; Err on a Lua error.
pub fn run_addon(opts: &RunAddon) -> Result<Vec<Value>, String> {
	run_addon_output(opts).map(|o| o.emitted)
}

/// [`run_addon`] for tests: a Lua error panics with its message.
pub fn emitted(opts: &RunAddon) -> Vec<Value> {
	run_addon(opts).unwrap_or_else(|e| panic!("{e}"))
}

/// A JSON value as a Lua literal (the tests' `luaValue`): null is nil, arrays are lists, objects tables
/// with `[key]` keys (digit keys as numbers).
pub fn lua_value(v: &Value) -> String {
	match v {
		Value::Null => "nil".into(),
		Value::Bool(b) => b.to_string(),
		Value::Number(n) => n.to_string(),
		Value::String(s) => serde_json::to_string(s).unwrap(),
		Value::Array(a) => format!("{{ {} }}", a.iter().map(lua_value).collect::<Vec<_>>().join(", ")),
		Value::Object(o) => format!(
			"{{ {} }}",
			o.iter()
				.map(|(k, x)| {
					let key = if !k.is_empty() && k.bytes().all(|b| b.is_ascii_digit()) { k.clone() } else { serde_json::to_string(k).unwrap() };
					format!("[{key}] = {}", lua_value(x))
				})
				.collect::<Vec<_>>()
				.join(", ")
		),
	}
}

/// CPU seconds this thread has used.
#[cfg(unix)]
fn thread_cpu_seconds() -> f64 {
	let mut ts = libc::timespec { tv_sec: 0, tv_nsec: 0 };
	// SAFETY: clock_gettime writes the timespec it is given.
	unsafe { libc::clock_gettime(libc::CLOCK_THREAD_CPUTIME_ID, &mut ts) };
	ts.tv_sec as f64 + ts.tv_nsec as f64 / 1e9
}

/// Elsewhere: wall seconds since the first call on this thread.
#[cfg(not(unix))]
fn thread_cpu_seconds() -> f64 {
	thread_local!(static START: std::time::Instant = std::time::Instant::now());
	START.with(|s| s.elapsed().as_secs_f64())
}
