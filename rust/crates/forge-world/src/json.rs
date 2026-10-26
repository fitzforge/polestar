//! JavaScript value semantics over serde_json: `JSON.stringify` byte for byte (array-index keys
//! first in ascending order, then string keys in insertion order; numbers as `String(n)`;
//! non-finite numbers `null`) and `Number(x)` / truthiness for loosely typed inputs.
use serde_json::Map;

/// `Object.entries(o)` order: array-index keys ascending, then the others in insertion order.
pub fn entries(v: Option<&Value>) -> Vec<(&String, &Value)> {
	let Some(Value::Object(m)) = v else { return Vec::new() };
	entries_of(m)
}

pub fn entries_of(m: &Map<String, Value>) -> Vec<(&String, &Value)> {
	let mut idx: Vec<(u32, &String, &Value)> = Vec::new();
	let mut rest = Vec::new();
	for (k, x) in m {
		match array_index(k) {
			Some(n) => idx.push((n, k, x)),
			None => rest.push((k, x)),
		}
	}
	idx.sort_by_key(|e| e.0);
	idx.into_iter().map(|e| (e.1, e.2)).chain(rest).collect()
}

/// `String(v)` for a key-like JSON value (numbers as JS prints them).
pub fn js_str(v: Option<&Value>) -> String {
	match v {
		None => "undefined".into(),
		Some(Value::Null) => "null".into(),
		Some(Value::String(s)) => s.clone(),
		Some(Value::Number(n)) => js_to_string(n.as_f64().unwrap_or(f64::NAN)),
		Some(Value::Bool(b)) => b.to_string(),
		Some(x) => stringify(x),
	}
}

use forge_core::js_to_string;
use serde_json::Value;

/// `JSON.stringify(v)`.
pub fn stringify(v: &Value) -> String {
	let mut out = String::with_capacity(1 << 16);
	write_value(&mut out, v);
	out
}

/// A canonical array index ("0", "17", not "017"), below 2^32 - 1: JS orders these keys first.
fn array_index(k: &str) -> Option<u32> {
	if k.is_empty() || k.len() > 10 || (k.len() > 1 && k.starts_with('0')) || !k.bytes().all(|b| b.is_ascii_digit()) {
		return None;
	}
	let n: u64 = k.parse().ok()?;
	(n < u32::MAX as u64).then_some(n as u32)
}

fn write_value(out: &mut String, v: &Value) {
	match v {
		Value::Null => out.push_str("null"),
		Value::Bool(b) => out.push_str(if *b { "true" } else { "false" }),
		Value::Number(n) => {
			if let Some(u) = n.as_u64() {
				out.push_str(&u.to_string());
			} else if let Some(i) = n.as_i64() {
				out.push_str(&i.to_string());
			} else {
				let f = n.as_f64().unwrap_or(f64::NAN);
				if f.is_finite() {
					out.push_str(&js_to_string(f));
				} else {
					out.push_str("null");
				}
			}
		}
		Value::String(s) => write_str(out, s),
		Value::Array(a) => {
			out.push('[');
			for (i, x) in a.iter().enumerate() {
				if i > 0 {
					out.push(',');
				}
				write_value(out, x);
			}
			out.push(']');
		}
		Value::Object(m) => {
			out.push('{');
			let mut idx: Vec<(u32, &String, &Value)> = Vec::new();
			let mut rest: Vec<(&String, &Value)> = Vec::new();
			for (k, x) in m {
				match array_index(k) {
					Some(n) => idx.push((n, k, x)),
					None => rest.push((k, x)),
				}
			}
			idx.sort_by_key(|e| e.0);
			let mut first = true;
			for (k, x) in idx.iter().map(|e| (e.1, e.2)).chain(rest) {
				if !first {
					out.push(',');
				}
				first = false;
				write_str(out, k);
				out.push(':');
				write_value(out, x);
			}
			out.push('}');
		}
	}
}

// JSON.stringify's QuoteJSONString: \b \t \n \f \r \" \\ escaped, other controls \u00XX,
// lone surrogates can't occur in a Rust string.
fn write_str(out: &mut String, s: &str) {
	out.push('"');
	for ch in s.chars() {
		match ch {
			'"' => out.push_str("\\\""),
			'\\' => out.push_str("\\\\"),
			'\u{8}' => out.push_str("\\b"),
			'\t' => out.push_str("\\t"),
			'\n' => out.push_str("\\n"),
			'\u{c}' => out.push_str("\\f"),
			'\r' => out.push_str("\\r"),
			c if (c as u32) < 0x20 => out.push_str(&format!("\\u{:04x}", c as u32)),
			c => out.push(c),
		}
	}
	out.push('"');
}

/// `Number(v)` for a JSON value (`undefined` is `None` in the caller: NaN).
pub fn num(v: Option<&Value>) -> f64 {
	match v {
		None => f64::NAN,
		Some(Value::Null) => 0.0,
		Some(Value::Bool(b)) => f64::from(u8::from(*b)),
		Some(Value::Number(n)) => n.as_f64().unwrap_or(f64::NAN),
		Some(Value::String(s)) => {
			let t = s.trim();
			if t.is_empty() {
				0.0
			} else {
				t.parse().unwrap_or(f64::NAN)
			}
		}
		Some(Value::Array(a)) => match a.len() {
			0 => 0.0,
			1 => num(Some(&a[0])),
			_ => f64::NAN,
		},
		Some(Value::Object(_)) => f64::NAN,
	}
}

/// JS truthiness of a JSON value (`undefined` is `None`: false).
pub fn truthy(v: Option<&Value>) -> bool {
	match v {
		None | Some(Value::Null) => false,
		Some(Value::Bool(b)) => *b,
		Some(Value::Number(n)) => n.as_f64().is_some_and(|f| f != 0.0 && !f.is_nan()),
		Some(Value::String(s)) => !s.is_empty(),
		Some(_) => true,
	}
}

/// A finite JSON number (`Number.isFinite(v)`: no coercion).
pub fn finite(v: Option<&Value>) -> Option<f64> {
	v.and_then(Value::as_f64).filter(|f| f.is_finite())
}

/// `v != null` (neither null nor undefined).
pub fn present(v: Option<&Value>) -> bool {
	!matches!(v, None | Some(Value::Null))
}

/// A JSON number from an f64 (integers stay integers so equality with parsed JS output holds).
pub fn jnum(f: f64) -> Value {
	if f.fract() == 0.0 && f.abs() < 9.0e15 {
		if f == 0.0 {
			return Value::from(0);
		}
		return Value::from(f as i64);
	}
	serde_json::Number::from_f64(f).map(Value::Number).unwrap_or(Value::Null)
}

/// An optional number, `null` when absent.
pub fn jopt(f: Option<f64>) -> Value {
	f.map(jnum).unwrap_or(Value::Null)
}

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::json;

	#[test]
	fn key_order_like_js() {
		let v: Value = serde_json::from_str(r#"{"b":1,"10":2,"a":3,"2":4,"01":5}"#).unwrap();
		assert_eq!(stringify(&v), r#"{"2":4,"10":2,"b":1,"a":3,"01":5}"#);
		assert_eq!(stringify(&json!([1.5, -0.0, 1e21, "a\"\n"])), r#"[1.5,0,1e+21,"a\"\n"]"#);
		assert_eq!(stringify(&jnum(5.0)), "5");
	}
}
