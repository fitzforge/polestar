//! JavaScript-compatible numbers: `Math.round`, `Math.hypot` (V8's algorithm, bit for bit),
//! `Number.prototype.toFixed` (exact value, ties away from zero) and `String(number)`
//! (shortest round trip, `-0` is `0`). Ports reproduce the JS output only if they compute
//! and print numbers the way V8 does.

/// `Math.round`: nearest integer, ties toward +∞; `-0` for negatives that round to zero.
pub fn js_round(x: f64) -> f64 {
	if !x.is_finite() {
		return x;
	}
	let f = x.floor();
	// x - floor(x) is exact for every finite double.
	let r = if x - f >= 0.5 { f + 1.0 } else { f };
	if r == 0.0 && x < 0.0 {
		-0.0
	} else {
		r
	}
}

/// `Math.round(v * 100) / 100`.
pub fn round2(v: f64) -> f64 {
	js_round(v * 100.0) / 100.0
}

/// `Math.round(v * 10) / 10`.
pub fn round1(v: f64) -> f64 {
	js_round(v * 10.0) / 10.0
}

/// `Math.hypot(a, b)` as V8 computes it: absolute values scaled by the largest, Kahan-summed
/// squares, `sqrt(sum) * max`. Differs from libm's `hypot` in the last bit on some inputs.
pub fn js_hypot(a: f64, b: f64) -> f64 {
	js_hypot_n(&[a, b])
}

/// `Math.hypot(...values)` (V8).
pub fn js_hypot_n(values: &[f64]) -> f64 {
	let mut max = 0.0f64;
	let mut nan = false;
	for &v in values {
		if v.is_nan() {
			nan = true;
		} else if v.abs() > max {
			max = v.abs();
		}
	}
	if max == f64::INFINITY {
		return f64::INFINITY;
	}
	if nan {
		return f64::NAN;
	}
	if max == 0.0 {
		return 0.0;
	}
	let mut sum = 0.0f64;
	let mut comp = 0.0f64;
	for &v in values {
		let n = v.abs() / max;
		let summand = n * n - comp;
		let pre = sum + summand;
		comp = (pre - sum) - summand;
		sum = pre;
	}
	sum.sqrt() * max
}

/// `String(x)` / `JSON.stringify(x)` for a finite number: the shortest digits that round-trip,
/// laid out by ECMAScript Number::toString (plain up to 21 integer digits, `e` notation below
/// 1e-6 and from 1e21). `-0` prints `0`. NaN and infinities print as JS does.
pub fn js_to_string(x: f64) -> String {
	if x.is_nan() {
		return "NaN".into();
	}
	if x.is_infinite() {
		return if x > 0.0 { "Infinity".into() } else { "-Infinity".into() };
	}
	if x == 0.0 {
		return "0".into();
	}
	let mut out = String::new();
	if x < 0.0 {
		out.push('-');
	}
	// Rust's `{:e}` prints the shortest round-trip digits: "d.ddde±x".
	let sci = format!("{:e}", x.abs());
	let (mant, exp) = sci.split_once('e').expect("{:e} has an exponent");
	let mut digits: String = mant.chars().filter(|c| *c != '.').collect();
	let mut n = exp.parse::<i32>().expect("exponent") + 1;
	// Two shortest candidates equally near the exact value (it has k+1 digits ending in 5):
	// ECMAScript takes the even one.
	let k0 = digits.len();
	let wider = format!("{:.*e}", k0, x.abs());
	let (wm, _) = wider.split_once('e').expect("{:e} has an exponent");
	if wm.ends_with('5') {
		let exact = format!("{:.*e}", 800, x.abs());
		let (em, _) = exact.split_once('e').expect("{:e} has an exponent");
		if em.starts_with(wm) && em[wm.len()..].bytes().all(|b| b == b'0') {
			let wd: String = wm.chars().filter(|c| *c != '.').collect();
			let lo = &wd[..k0];
			let hi = increment_decimal(lo);
			let carried = hi.len() > lo.len();
			let hi_even = (hi.as_bytes()[hi.len() - 1] - b'0').is_multiple_of(2);
			let pick = if hi_even { hi.as_str() } else { lo };
			if hi_even && carried {
				n += 1;
			}
			digits = pick.trim_end_matches('0').to_string();
			if digits.is_empty() {
				digits = "0".into();
			}
		}
	}
	let k = digits.len() as i32;
	if k <= n && n <= 21 {
		out.push_str(&digits);
		for _ in 0..(n - k) {
			out.push('0');
		}
	} else if 0 < n && n <= 21 {
		out.push_str(&digits[..n as usize]);
		out.push('.');
		out.push_str(&digits[n as usize..]);
	} else if -6 < n && n <= 0 {
		out.push_str("0.");
		for _ in 0..(-n) {
			out.push('0');
		}
		out.push_str(&digits);
	} else {
		out.push_str(&digits[..1]);
		if k > 1 {
			out.push('.');
			out.push_str(&digits[1..]);
		}
		out.push('e');
		out.push(if n > 0 { '+' } else { '-' });
		out.push_str(&(n - 1).abs().to_string());
	}
	out
}

/// `x.toFixed(digits)`: the exact value of the double rounded to `digits` decimals, an exact
/// tie going away from zero (JS picks the larger n on |x|); `String(x)` from 1e21 up. A
/// negative that rounds to zero keeps its sign ("-0.00") as JS does; `-0` itself prints "0.00".
pub fn js_to_fixed(x: f64, digits: usize) -> String {
	if x.is_nan() {
		return "NaN".into();
	}
	if x.abs() >= 1e21 {
		return js_to_string(x);
	}
	let neg = x < 0.0;
	let a = x.abs();
	// Rust rounds the exact value half to even: it differs from JS only on exact ties.
	let one_more = format!("{:.*}", digits + 1, a);
	let body = if one_more.ends_with('5') && is_exact(a, &one_more) {
		let trunc = &one_more[..one_more.len() - 1];
		let trunc = trunc.strip_suffix('.').unwrap_or(trunc);
		increment_decimal(trunc)
	} else {
		format!("{:.*}", digits, a)
	};
	if neg {
		format!("-{body}")
	} else {
		body
	}
}

// Is `printed` (a fixed rendering of `a`) its exact value? The exact expansion of a double has
// at most 1074 fractional digits.
fn is_exact(a: f64, printed: &str) -> bool {
	let full = format!("{:.1074}", a);
	let shown = printed.len();
	full.starts_with(printed) && full[shown..].bytes().all(|b| b == b'0')
}

// "12.39" -> "12.40", "9.99" -> "10.00", "9" -> "10".
fn increment_decimal(s: &str) -> String {
	let mut bytes = s.as_bytes().to_vec();
	let mut i = bytes.len();
	loop {
		if i == 0 {
			bytes.insert(0, b'1');
			break;
		}
		i -= 1;
		match bytes[i] {
			b'.' => continue,
			b'9' => bytes[i] = b'0',
			d => {
				bytes[i] = d + 1;
				break;
			}
		}
	}
	String::from_utf8(bytes).expect("ascii")
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn to_string_layouts() {
		assert_eq!(js_to_string(-0.0), "0");
		assert_eq!(js_to_string(1.0), "1");
		assert_eq!(js_to_string(0.1 + 0.2), "0.30000000000000004");
		assert_eq!(js_to_string(1e21), "1e+21");
		assert_eq!(js_to_string(123456789012345680000.0), "123456789012345680000");
		assert_eq!(js_to_string(1e-7), "1e-7");
		assert_eq!(js_to_string(0.000001), "0.000001");
		assert_eq!(js_to_string(-1.5e-10), "-1.5e-10");
		assert_eq!(js_to_string(4294967373.0), "4294967373");
	}

	#[test]
	fn to_fixed_ties_up() {
		assert_eq!(js_to_fixed(0.125, 2), "0.13");
		assert_eq!(js_to_fixed(0.5, 0), "1");
		assert_eq!(js_to_fixed(2.5, 0), "3");
		assert_eq!(js_to_fixed(-2.5, 0), "-3");
		assert_eq!(js_to_fixed(1.005, 2), "1.00");
		assert_eq!(js_to_fixed(9.995, 2), "9.99");
		assert_eq!(js_to_fixed(9.375, 2), "9.38");
		assert_eq!(js_to_fixed(99.5, 0), "100");
		assert_eq!(js_to_fixed(-0.0, 2), "0.00");
		assert_eq!(js_to_fixed(-0.001, 2), "-0.00");
		assert_eq!(js_to_fixed(1.45, 1), "1.4");
	}

	#[test]
	fn round_like_math_round() {
		assert_eq!(js_round(2.5), 3.0);
		assert_eq!(js_round(-2.5), -2.0);
		assert_eq!(js_round(0.49999999999999994), 0.0);
		assert!(js_round(-0.2).is_sign_negative());
	}

	#[test]
	fn hypot_edges() {
		assert_eq!(js_hypot(3.0, 4.0), 5.0);
		assert_eq!(js_hypot(0.0, 0.0), 0.0);
	}
}
