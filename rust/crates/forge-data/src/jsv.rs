//! JS semantics the data build leans on, over forge-guide's JS value model: `Number(x)`, ToInt32,
//! Lua-table access over the array/object forms lua.js returns (questie.js luaGet/luaPairs/luaList),
//! client-table rows (CSV-like: column -> string).

use forge_guide::js::{is_index_key, num_str, Arr, Obj, V};
use rustc_hash::FxHashMap;

pub use forge_core::jsnum::{js_hypot as hypot, js_round as math_round};

/// One client-table row, values as wago.tools CSV writes them.
pub type Row = FxHashMap<String, String>;
pub type Rows = Vec<Row>;

/// `Number(row.col)` (undefined -> NaN).
pub fn col_num(r: &Row, c: &str) -> f64 {
	r.get(c).map(|s| forge_guide::js::str_to_num(s)).unwrap_or(f64::NAN)
}

/// `row.col || ''`.
pub fn col_str<'a>(r: &'a Row, c: &str) -> &'a str {
	r.get(c).map(String::as_str).unwrap_or("")
}

/// ECMAScript ToInt32 (for `|`, `&`).
pub fn to_int32(x: f64) -> i32 {
	if !x.is_finite() {
		return 0;
	}
	let t = x.trunc();
	let m = t.rem_euclid(4294967296.0);
	(m as u64 as u32) as i32
}

pub fn round2(v: f64) -> f64 {
	math_round(v * 100.0) / 100.0
}

pub fn is_int(x: f64) -> bool {
	x.is_finite() && x.fract() == 0.0
}

/// `String(n)` for a number used as an object key.
pub fn key(n: f64) -> String {
	num_str(n)
}

pub fn num(n: f64) -> V {
	V::Num(n)
}

/// `n || null` style: Some -> number, None -> null.
pub fn opt(n: Option<f64>) -> V {
	n.map(V::Num).unwrap_or(V::Null)
}

pub fn arr(v: Vec<V>) -> V {
	V::Arr(Arr::from_vec(v))
}

pub fn nums(v: &[f64]) -> V {
	arr(v.iter().map(|&x| V::Num(x)).collect())
}

pub fn strs(v: &[&str]) -> V {
	arr(v.iter().map(|&x| V::str(x)).collect())
}

fn nil(v: &V) -> bool {
	v.is_nullish()
}

/// luaGet(t, k) with a number key.
pub fn lua_get_i(t: &V, k: i64) -> V {
	match t {
		V::Arr(a) => {
			if k >= 1 {
				let v = a.get((k - 1) as usize);
				if nil(&v) {
					V::Undef
				} else {
					v
				}
			} else {
				V::Undef
			}
		}
		V::Obj(o) => {
			let v = o.get(&k.to_string());
			if nil(&v) {
				V::Undef
			} else {
				v
			}
		}
		_ => V::Undef,
	}
}

/// luaGet(t, k) with a string key.
pub fn lua_get(t: &V, k: &str) -> V {
	match t {
		V::Arr(_) => match k.parse::<f64>() {
			Ok(n) if is_int(n) && n >= 1.0 && num_str(n) == k => lua_get_i(t, n as i64),
			_ => V::Undef,
		},
		V::Obj(o) => {
			let v = o.get(k);
			if nil(&v) {
				V::Undef
			} else {
				v
			}
		}
		_ => V::Undef,
	}
}

/// A luaPairs key: integer keys as numbers, the rest as strings.
#[derive(Clone, Debug)]
pub enum LKey {
	I(f64),
	S(String),
}

impl LKey {
	pub fn num(&self) -> f64 {
		match self {
			LKey::I(n) => *n,
			LKey::S(s) => forge_guide::js::str_to_num(s),
		}
	}
}

fn int_key(k: &str) -> bool {
	let b = k.strip_prefix('-').unwrap_or(k);
	!b.is_empty() && b.bytes().all(|c| c.is_ascii_digit())
}

/// luaPairs(t): integer keys (ascending) first, then the rest in order.
pub fn lua_pairs(t: &V) -> Vec<(LKey, V)> {
	match t {
		V::Arr(a) => a.to_vec().into_iter().enumerate().filter(|(_, v)| !nil(v)).map(|(i, v)| (LKey::I((i + 1) as f64), v)).collect(),
		V::Obj(o) => {
			let mut ints = Vec::new();
			let mut strs = Vec::new();
			for (k, v) in o.entries() {
				if nil(&v) {
					continue;
				}
				if int_key(&k) {
					ints.push((forge_guide::js::str_to_num(&k), v));
				} else {
					strs.push((LKey::S(k.to_string()), v));
				}
			}
			ints.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());
			ints.into_iter().map(|(n, v)| (LKey::I(n), v)).chain(strs).collect()
		}
		_ => Vec::new(),
	}
}

/// luaList(t): t[1], t[2], ... up to the first nil.
pub fn lua_list(t: &V) -> Vec<V> {
	let mut out = Vec::new();
	let mut i = 1;
	loop {
		let v = lua_get_i(t, i);
		if v.is_undef() {
			return out;
		}
		out.push(v);
		i += 1;
	}
}

/// `Object.keys(o).map(Number)` of an id-keyed table, ascending (index keys) then the rest.
pub fn id_keys(o: &Obj) -> Vec<f64> {
	o.keys().iter().map(|k| forge_guide::js::str_to_num(k)).collect()
}

pub fn is_index(k: &str) -> bool {
	is_index_key(k)
}

/// `{ ...a }` then field order kept, for records.
pub fn set_num(o: &Obj, k: &str, n: f64) {
	o.set(k, V::Num(n));
}

/// `arr.includes(x)` for numbers.
pub fn includes_num(a: &V, x: f64) -> bool {
	a.items().iter().any(|v| matches!(v, V::Num(n) if *n == x))
}

/// The numbers of a JS array of numbers.
pub fn num_list(a: &V) -> Vec<f64> {
	a.items().iter().map(V::num).collect()
}

/// Lexical `path.relative(from, to)` for absolute paths with `/` separators in the output.
pub fn relative(from: &std::path::Path, to: &std::path::Path) -> String {
	let a: Vec<_> = from.components().collect();
	let b: Vec<_> = to.components().collect();
	let n = a.iter().zip(&b).take_while(|(x, y)| x == y).count();
	let mut parts: Vec<String> = std::iter::repeat_n("..".to_string(), a.len() - n).collect();
	parts.extend(b[n..].iter().map(|c| c.as_os_str().to_string_lossy().to_string()));
	parts.join("/")
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn int32_and_relative() {
		assert_eq!(to_int32(4294967304.0), 8);
		assert_eq!(to_int32(-1.0), -1);
		assert_eq!(to_int32(2147483648.0), -2147483648);
		assert_eq!(relative("/a/b".as_ref(), "/a/b/c/d.json".as_ref()), "c/d.json");
		assert_eq!(relative("/a/b".as_ref(), "/a/x".as_ref()), "../x");
	}
}
