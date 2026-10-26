//! CSV the way wago.tools exports a table (`/db2/<Table>/csv`), so the JS tools and parity
//! checks read either: a header row, `\n` line ends, PHP `fputcsv` quoting (a field is quoted
//! when it holds `,` `"` `\` a space, tab, CR or LF; `"` doubles unless right after `\`),
//! floats rounded half-up to 11 decimals and then printed as PHP prints a double at precision
//! 14 (`1.356337E-5`, `491.15170288086`, `9.9999998430675E+16`); see [`wago_float`].

use std::io::Write;

use crate::db2::{Table, Value};

/// PHP's `(string)$float` at precision 14 (zend_gcvt with mode 2): 14 significant digits,
/// trailing zeros dropped, `E+N`/`E-N` exponent when the exponent is below -4 or 14 and up.
pub fn php_float(v: f64) -> String {
	if v == 0.0 {
		return if v.is_sign_negative() { "-0".into() } else { "0".into() };
	}
	if v.is_nan() {
		return "NAN".into();
	}
	if v.is_infinite() {
		return if v < 0.0 { "-INF".into() } else { "INF".into() };
	}
	// d.ddddddddddddde±x, correctly rounded to 14 significant digits.
	let s = format!("{:.13e}", v.abs());
	let (mant, exp) = s.split_once('e').unwrap();
	let exp: i32 = exp.parse().unwrap();
	let digits: String = mant.replace('.', "");
	let digits = digits.trim_end_matches('0');
	let digits = if digits.is_empty() { "0" } else { digits };
	let decpt = exp + 1; // position of the decimal point after the first digit
	let mut out = String::new();
	if v < 0.0 {
		out.push('-');
	}
	if !(-3..=14).contains(&decpt) {
		out.push_str(&digits[..1]);
		out.push('.');
		out.push_str(if digits.len() > 1 { &digits[1..] } else { "0" });
		out.push('E');
		out.push(if exp < 0 { '-' } else { '+' });
		out.push_str(&exp.abs().to_string());
	} else if decpt <= 0 {
		out.push_str("0.");
		for _ in 0..-decpt {
			out.push('0');
		}
		out.push_str(digits);
	} else {
		let d = decpt as usize;
		if digits.len() <= d {
			out.push_str(digits);
			for _ in digits.len()..d {
				out.push('0');
			}
		} else {
			out.push_str(&digits[..d]);
			out.push('.');
			out.push_str(&digits[d..]);
		}
	}
	out
}

/// A float column's value as wago.tools writes it: the f32 rounded half away from zero to 11
/// decimals (exactly, from its binary value), then [`php_float`] of the nearest double. Derived
/// from the data: it reproduces all 51,900 float cells of build 1.60.1.70450's tables.
pub fn wago_float(v: f32) -> String {
	let mut out = Vec::new();
	put_wago_float(&mut out, v);
	String::from_utf8(out).unwrap()
}

/// [`wago_float`] appended to `out`; values from 1e-4 to 1e3 (most of them) without allocating.
pub fn put_wago_float(out: &mut Vec<u8>, v: f32) {
	let slow = |out: &mut Vec<u8>, d: f64| out.extend_from_slice(php_float(d).as_bytes());
	if !v.is_finite() || v == 0.0 {
		return slow(out, v as f64);
	}
	let bits = v.to_bits();
	let (exp, frac) = (((bits >> 23) & 0xff) as i32, (bits & 0x7f_ffff) as u128);
	let (m, e) = if exp == 0 { (frac, -149) } else { (frac | 0x80_0000, exp - 150) };
	if e >= 0 {
		return slow(out, v as f64); // an integer: nothing to round
	}
	// q = |v| * 10^11, rounded half up.
	let k = (-e) as u32;
	let n = m * 10u128.pow(11);
	let q = if k >= 100 {
		0
	} else {
		let (q, rem) = (n >> k, n & ((1u128 << k) - 1));
		q + (rem >= 1u128 << (k - 1)) as u128
	};
	if !(10_000_000..100_000_000_000_000).contains(&q) {
		// Below 1e-4 (exponent form) or 15+ significant digits (PHP re-rounds the double).
		let d: f64 = format!("{}{q}e-11", if v < 0.0 { "-" } else { "" }).parse().unwrap();
		return slow(out, d);
	}
	// At most 14 digits: PHP prints the decimal itself, trailing zeros dropped.
	if v < 0.0 {
		out.push(b'-');
	}
	let (int, mut fr) = ((q / 100_000_000_000) as u64, (q % 100_000_000_000) as u64);
	let mut digits = 11;
	while digits > 0 && fr % 10 == 0 {
		fr /= 10;
		digits -= 1;
	}
	let mut buf = [0u8; 20];
	let mut put_num = |out: &mut Vec<u8>, mut x: u64, width: usize| {
		let mut i = buf.len();
		loop {
			i -= 1;
			buf[i] = b'0' + (x % 10) as u8;
			x /= 10;
			if x == 0 && buf.len() - i >= width {
				break;
			}
		}
		out.extend_from_slice(&buf[i..]);
	};
	put_num(out, int, 1);
	if digits > 0 {
		out.push(b'.');
		put_num(out, fr, digits);
	}
}

/// One field as PHP's fputcsv writes it (delimiter `,`, enclosure `"`, escape `\`).
pub fn put_field(out: &mut Vec<u8>, f: &[u8]) {
	if !f.iter().any(|c| matches!(c, b',' | b'"' | b'\\' | b'\n' | b'\r' | b'\t' | b' ')) {
		out.extend_from_slice(f);
		return;
	}
	out.push(b'"');
	let mut escaped = false;
	for &c in f {
		if c == b'\\' {
			escaped = true;
		} else if !escaped && c == b'"' {
			out.push(b'"');
		} else {
			escaped = false;
		}
		out.push(c);
	}
	out.push(b'"');
}

/// The CSV text of a table's value.
pub fn put_value(out: &mut Vec<u8>, t: &Table, v: &Value) {
	match v {
		Value::Int(x) => write!(out, "{x}").unwrap(),
		Value::UInt(x) => write!(out, "{x}").unwrap(),
		Value::Float(f) => put_wago_float(out, *f),
		Value::Str(..) => put_field(out, t.str(v).unwrap_or_default()),
	}
}

/// The whole table as wago.tools CSV.
pub fn write_table(t: &Table) -> Vec<u8> {
	let mut out = Vec::with_capacity(t.values.len() * 6);
	for (i, c) in t.columns.iter().enumerate() {
		if i > 0 {
			out.push(b',');
		}
		// wago.tools writes the column `Index` as `_Index` (the only renamed column in its CSVs;
		// `Order`, `Left`, `Default` and the like keep their names).
		put_field(&mut out, if c.name == "Index" { b"_Index" } else { c.name.as_bytes() });
	}
	out.push(b'\n');
	for r in 0..t.rows() {
		for (i, v) in t.row(r).iter().enumerate() {
			if i > 0 {
				out.push(b',');
			}
			put_value(&mut out, t, v);
		}
		out.push(b'\n');
	}
	out
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn floats_like_php() {
		assert_eq!(php_float(1e15), "1.0E+15");
		assert_eq!(php_float(100000000000000.0), "1.0E+14");
		assert_eq!(php_float(10000000000000.0), "10000000000000");
		assert_eq!(php_float(0.0001), "0.0001");
		assert_eq!(php_float(1e-5), "1.0E-5");
		assert_eq!(php_float(0.5), "0.5");
		assert_eq!(php_float(-0.0), "-0");
	}

	#[test]
	fn floats_like_wago() {
		// Cells of wago.tools 1.60.1.70450 CSVs.
		assert_eq!(wago_float(-8841.958), "-8841.9580078125");
		assert_eq!(wago_float(491.1517), "491.15170288086");
		assert_eq!(wago_float(1.356337e-5), "1.356337E-5");
		assert_eq!(wago_float(-7.798937e-5), "-7.798937E-5");
		assert_eq!(wago_float(0.8), "0.80000001192");
		assert_eq!(wago_float(-0.01), "-0.00999999978");
		assert_eq!(wago_float(760.920_17), "760.92016601563"); // an exact tie, rounded up
		assert_eq!(wago_float(99999998430674944.0), "9.9999998430675E+16");
		assert_eq!(wago_float(1.0), "1");
		assert_eq!(wago_float(0.0), "0");
		assert_eq!(wago_float(0.0001), "0.0001");
		assert_eq!(wago_float(0.00012), "0.00012");
		assert_eq!(wago_float(-12.5), "-12.5");
		assert_eq!(wago_float(999.9), "999.90002441406");
		assert_eq!(wago_float(1000.1), "1000.0999755859");
	}

	#[test]
	fn quoting_like_fputcsv() {
		let q = |s: &str| {
			let mut o = Vec::new();
			put_field(&mut o, s.as_bytes());
			String::from_utf8(o).unwrap()
		};
		assert_eq!(q("DunMorogh"), "DunMorogh");
		assert_eq!(q("Dun Morogh"), "\"Dun Morogh\"");
		assert_eq!(q("a\"b"), "\"a\"\"b\"");
		assert_eq!(q("a\\\"b"), "\"a\\\"b\"");
		assert_eq!(q(""), "");
	}
}
