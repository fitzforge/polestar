//! JavaScript number semantics the JS nav build relies on, for byte-identical output.
//!
//! - `hypot`: V8's Math.hypot (max-scaled Kahan sum), not libm's.
//! - `round`: Math.round (floor(x + 0.5) with JS's exact rules), not f64::round.
//! - `max`/`min`: Math.max/Math.min (NaN wins; -0 < +0).
//! - `sin`/`cos`/`tan`/`acos`: V8's fdlibm ports (the `libm` crate is the same fdlibm code).
//! - `f32` rounding: storing into a Float32Array is `x as f32` (round to nearest even), reading
//!   back is `f64::from(x)`.
//! - `num_to_string`: Number.prototype.toString / JSON.stringify of a number.

/// Math.hypot of any number of arguments (V8 builtins/math.tq MathHypot).
pub fn hypot_n(args: &[f64]) -> f64 {
	if args.is_empty() {
		return 0.0;
	}
	let mut max = 0.0f64;
	let mut nan = false;
	for &v in args {
		if v.is_nan() {
			nan = true;
		} else {
			let a = v.abs();
			if a > max {
				max = a;
			}
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
	for &v in args {
		let n = v.abs() / max;
		let summand = n * n - comp;
		let pre = sum + summand;
		comp = (pre - sum) - summand;
		sum = pre;
	}
	sum.sqrt() * max
}

#[inline]
pub fn hypot(a: f64, b: f64) -> f64 {
	hypot_n(&[a, b])
}

#[inline]
pub fn hypot3(a: f64, b: f64, c: f64) -> f64 {
	hypot_n(&[a, b, c])
}

/// Math.round.
#[inline]
pub fn round(x: f64) -> f64 {
	if !x.is_finite() || x == 0.0 {
		return x;
	}
	if x > 0.0 && x < 0.5 {
		return 0.0;
	}
	if x < 0.0 && x >= -0.5 {
		return -0.0;
	}
	let f = x.floor();
	if x - f >= 0.5 {
		f + 1.0
	} else {
		f
	}
}

/// Math.max of two.
#[inline]
pub fn max(a: f64, b: f64) -> f64 {
	if a.is_nan() || b.is_nan() {
		return f64::NAN;
	}
	if a == b {
		// +0 over -0
		return if a.is_sign_negative() { b } else { a };
	}
	if a > b {
		a
	} else {
		b
	}
}

/// Math.min of two.
#[inline]
pub fn min(a: f64, b: f64) -> f64 {
	if a.is_nan() || b.is_nan() {
		return f64::NAN;
	}
	if a == b {
		return if a.is_sign_negative() { a } else { b };
	}
	if a < b {
		a
	} else {
		b
	}
}

#[inline]
pub fn sin(x: f64) -> f64 {
	libm::sin(x)
}
#[inline]
pub fn cos(x: f64) -> f64 {
	libm::cos(x)
}
#[inline]
pub fn tan(x: f64) -> f64 {
	libm::tan(x)
}
#[inline]
pub fn acos(x: f64) -> f64 {
	libm::acos(x)
}

/// Math.fround.
#[inline]
pub fn fround(x: f64) -> f64 {
	f64::from(x as f32)
}

/// A number as JavaScript prints it (Number#toString, JSON.stringify; non-finite as JSON's null
/// is the caller's business).
pub fn num_to_string(x: f64) -> String {
	if x.is_nan() {
		return "NaN".into();
	}
	if x == 0.0 {
		return "0".into();
	}
	if x.is_infinite() {
		return if x > 0.0 { "Infinity".into() } else { "-Infinity".into() };
	}
	// Shortest round-trip digits (Rust's `{:e}` gives them), then JS's layout.
	let s = format!("{:e}", x.abs());
	let (mant, exp) = s.split_once('e').unwrap();
	let exp: i32 = exp.parse().unwrap();
	let mut digits: String = mant.chars().filter(|c| *c != '.').collect();
	// Two shortest candidates equally near x: ECMAScript takes the even one (Rust's may not).
	if digits.as_bytes().last().is_some_and(|d| (d - b'0') % 2 == 1) {
		let ex = format!("{:.1100e}", x.abs());
		let (em, ee) = ex.split_once('e').unwrap();
		if ee.parse::<i32>().unwrap() == exp {
			let ed: String = em.chars().filter(|c| *c != '.').collect();
			let ed = ed.trim_end_matches('0');
			if ed.len() == digits.len() + 1 && ed.ends_with('5') {
				let t = &ed[..digits.len()];
				let alt = if (t.as_bytes()[t.len() - 1] - b'0').is_multiple_of(2) {
					Some(t.to_string())
				} else {
					// t + 1 in the last place (no carry out of the first digit).
					let mut b = t.as_bytes().to_vec();
					let mut i = b.len();
					loop {
						if i == 0 {
							break None;
						}
						i -= 1;
						if b[i] == b'9' {
							b[i] = b'0';
						} else {
							b[i] += 1;
							break Some(String::from_utf8(b).unwrap());
						}
					}
				};
				if let Some(alt) = alt {
					let back: f64 = format!("{}.{}e{}", &alt[..1], &alt[1..], exp).parse().unwrap_or(f64::NAN);
					if back == x.abs() {
						digits = alt;
					}
				}
			}
		}
	}
	let k = digits.len() as i32;
	let n = exp + 1; // decimal point position
	let mut out = String::new();
	if x < 0.0 {
		out.push('-');
	}
	if k <= n && n <= 21 {
		out.push_str(&digits);
		out.extend(std::iter::repeat_n('0', (n - k) as usize));
	} else if 0 < n && n <= 21 {
		out.push_str(&digits[..n as usize]);
		out.push('.');
		out.push_str(&digits[n as usize..]);
	} else if -6 < n && n <= 0 {
		out.push_str("0.");
		out.extend(std::iter::repeat_n('0', (-n) as usize));
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

#[cfg(test)]
mod tests {
	use super::*;
	#[test]
	fn numbers_print_like_js() {
		assert_eq!(num_to_string(1.0), "1");
		assert_eq!(num_to_string(0.1), "0.1");
		assert_eq!(num_to_string(1e21), "1e+21");
		assert_eq!(num_to_string(123456789012345680000.0), "123456789012345680000");
		assert_eq!(num_to_string(1e-7), "1e-7");
		assert_eq!(num_to_string(0.000001), "0.000001");
		assert_eq!(num_to_string(-2.5), "-2.5");
		assert_eq!(round(-2.5), -2.0);
		assert_eq!(num_to_string(f64::from(880.545_96_f32)), "880.5459594726562");
		assert_eq!(round(2.5), 3.0);
	}
}
