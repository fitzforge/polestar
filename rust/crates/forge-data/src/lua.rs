//! Lua 5.1 for the data build (port of tools/lib/lua.js `luaToJson`): the same sandboxed loader runs
//! `prelude`, loads `files` (data from outside the repository: pfQuest, QuestieDB) and returns `expr`'s
//! value, converted the way lua.js's JSON encoder and `JSON.parse` would: tables with keys exactly
//! 1..n become arrays, anything else an object (number keys printed as `%.0f` / `%.17g`, boolean keys
//! as `true`/`false`, other keys dropped), an empty table `{}`; NaN, infinities, functions and
//! userdata null. Strings are read as UTF-8 with invalid bytes replaced (as node reads the JSON).
//! The interpreter is PUC Lua 5.1 built in (mlua, vendored), so string-keyed tables enumerate in the
//! same order as under the `lua5.1` the JS tools run.

use std::path::Path;

use forge_guide::js::{Arr, Obj, V};
use mlua::{Lua, Value};

const SANDBOX: &str = include_str!("sandbox.lua");

/// Runs `prelude`, loads `files` sandboxed, and returns `expr` (a chunk body that returns a value).
pub fn lua_to_value(files: &[&Path], prelude: &str, expr: &str) -> Result<V, String> {
	let lua = Lua::new();
	let list = lua.create_table().map_err(|e| e.to_string())?;
	for (i, f) in files.iter().enumerate() {
		list.set(i + 1, f.to_string_lossy().to_string()).map_err(|e| e.to_string())?;
	}
	lua.globals().set("__polestar_files", list).map_err(|e| e.to_string())?;
	let script = format!(
		"{SANDBOX}\n{prelude}\nfor i = 1, #__polestar_files do\n  local ok, err = __polestar_loaddata(__polestar_files[i])\n  if not ok then error(err, 0) end\nend\n__polestar_result = (function() {expr} end)()\n"
	);
	lua.load(&script).set_name("=polestar-data").exec().map_err(|e| format!("Lua failed: {e}"))?;
	let v: Value = lua.globals().get("__polestar_result").map_err(|e| e.to_string())?;
	Ok(convert(&v))
}

fn num_value(n: f64) -> V {
	if n.is_finite() {
		V::Num(n)
	} else {
		V::Null
	}
}

/// lua.js `num(k)` for a key: integers `%.0f`, others `%.17g`.
fn num_key(n: f64) -> Option<String> {
	if !n.is_finite() {
		return Some("null".into());
	}
	if n == n.floor() && n.abs() < 9007199254740992.0 {
		return Some(if n == 0.0 { "0".into() } else { format!("{n:.0}") });
	}
	Some(g17(n))
}

/// C `%.17g`.
fn g17(n: f64) -> String {
	let e = format!("{n:.16e}");
	let (mant, exp) = e.split_once('e').unwrap();
	let exp: i32 = exp.parse().unwrap();
	if !(-4..17).contains(&exp) {
		let m = mant.trim_end_matches('0').trim_end_matches('.');
		format!("{m}e{}{:02}", if exp < 0 { '-' } else { '+' }, exp.abs())
	} else {
		let s = format!("{n:.*}", (16 - exp).max(0) as usize);
		if s.contains('.') {
			s.trim_end_matches('0').trim_end_matches('.').to_string()
		} else {
			s
		}
	}
}

fn lossy(b: &[u8]) -> String {
	String::from_utf8_lossy(b).into_owned()
}

fn convert(v: &Value) -> V {
	match v {
		Value::Nil => V::Null,
		Value::Boolean(b) => V::Bool(*b),
		Value::Integer(i) => V::Num(*i as f64),
		Value::Number(n) => num_value(*n),
		Value::String(s) => V::Str(lossy(&s.as_bytes()).into()),
		Value::Table(t) => {
			// Convert each pair as it comes: holding mlua values would exhaust its reference slots.
			enum Key {
				N(f64),
				S(String),
				B(bool),
				Skip,
			}
			let mut entries: Vec<(Key, V)> = Vec::new();
			let (mut n, mut ints) = (0f64, true);
			for pair in t.clone().pairs::<Value, Value>() {
				let Ok((k, val)) = pair else { continue };
				let key = match &k {
					Value::Integer(i) => Key::N(*i as f64),
					Value::Number(x) => Key::N(*x),
					Value::String(s) => Key::S(lossy(&s.as_bytes())),
					Value::Boolean(b) => Key::B(*b),
					_ => Key::Skip,
				};
				drop(k);
				match key {
					Key::N(x) if x >= 1.0 && x == x.floor() => n = n.max(x),
					_ => ints = false,
				}
				entries.push((key, convert(&val)));
			}
			let count = entries.len();
			if count > 0 && ints && n == count as f64 {
				let mut items = vec![V::Null; count];
				for (k, val) in entries {
					if let Key::N(x) = k {
						items[x as usize - 1] = val;
					}
				}
				return V::Arr(Arr::from_vec(items));
			}
			let o = Obj::new();
			for (k, val) in entries {
				let key = match k {
					Key::S(s) => Some(s),
					Key::N(x) => num_key(x),
					Key::B(b) => Some(b.to_string()),
					Key::Skip => None,
				};
				if let Some(key) = key {
					o.set(&key, val);
				}
			}
			V::Obj(o)
		}
		_ => V::Null,
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn arrays_objects_and_keys() {
		let v = lua_to_value(&[], "", "return { list = {1, 2.5, 'x'}, empty = {}, [3] = true, [1.5] = 0/0, sparse = { [2] = 1 } }").unwrap();
		let o = v.as_obj().unwrap();
		assert_eq!(forge_guide::js::stringify(&o.get("list"), None), "[1,2.5,\"x\"]");
		assert_eq!(forge_guide::js::stringify(&o.get("empty"), None), "{}");
		assert_eq!(forge_guide::js::stringify(&o.get("sparse"), None), "{\"2\":1}");
		assert!(o.get("3").truthy());
		assert!(matches!(o.get("1.5"), V::Null));
		assert_eq!(g17(0.1), "0.10000000000000001");
		assert_eq!(g17(1e-7), "9.9999999999999995e-08");
	}

	#[test]
	fn sandbox_blocks_os() {
		let dir = std::env::temp_dir().join(format!("polestar-data-lua-{}", std::process::id()));
		std::fs::create_dir_all(&dir).unwrap();
		let f = dir.join("evil.lua");
		std::fs::write(&f, "X = os").unwrap();
		let v = lua_to_value(&[&f], "", "return X == nil").unwrap();
		assert!(v.truthy());
		std::fs::remove_dir_all(&dir).ok();
	}
}
