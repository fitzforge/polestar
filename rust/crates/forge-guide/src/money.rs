//! Port of tools/lib/dsl/money.js.
//! Amounts of money as guides write them: `1g50s`, `7s`, `25c` or plain
//! copper (`350`). Read by a turn-in's `money` modifier, the `money` goal and
//! the `when money` predicate (parse.rs, when.rs).

use crate::js::str_to_num;

fn digits(s: &str) -> usize {
	s.bytes().take_while(|b| b.is_ascii_digit()).count()
}

/// `money 1g50s` / `money 7s` / `money 350` (copper) -> copper | None.
pub fn read_money(text: &str) -> Option<f64> {
	if !text.is_empty() && text.bytes().all(|b| b.is_ascii_digit()) {
		return Some(str_to_num(text));
	}
	// /^(?:(\d+)g)?(?:(\d+)s)?(?:(\d+)c)?$/i
	let mut rest = text;
	let mut parts = [None::<&str>; 3];
	for (k, unit) in b"gsc".iter().copied().enumerate() {
		let n = digits(rest);
		if n > 0 && rest.as_bytes().get(n).is_some_and(|b| b.to_ascii_lowercase() == unit) {
			parts[k] = Some(&rest[..n]);
			rest = &rest[n + 1..];
		}
	}
	if !rest.is_empty() || parts.iter().all(|p| p.is_none()) {
		return None;
	}
	let n = |p: Option<&str>| p.map(str_to_num).unwrap_or(0.0);
	Some(n(parts[0]) * 10000.0 + n(parts[1]) * 100.0 + n(parts[2]))
}
