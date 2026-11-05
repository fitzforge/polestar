//! Port of tools/lib/nav/bake.js (guideHash).
//!
//! Only what readLegs (project.rs) needs: a guide's leg ends hashed, so a baked
//! leg set can be told stale (goalWorld, stepTargets, guideHash). Leg baking
//! itself (routing, encoding) is nav's.

use crate::js::{hypot, math_round, num_str, V};

const MIN_LEG_YD: f64 = 15.0;

/// A goal's world position: continent and world x/y in yards.
#[derive(Clone)]
pub struct World {
	pub c: V,
	pub wx: f64,
	pub wy: f64,
	pub z: Option<f64>,
}

/// `obj && obj[map]` with a numeric/string map id.
fn frame_of(set: &V, map: &V) -> V {
	if !set.truthy() {
		return set.clone();
	}
	set.get(&map.to_js_string())
}

/// The world position of a compiled goal (its own place, else its first
/// candidate's, else its first spawn spot's), or None. frames: { era, forever }.
/// `z`: that place's height when the compiler gave it one (a spawn's), else None.
pub fn goal_world(goal: &V, frames: &V) -> Option<World> {
	let mut map = goal.get("map");
	let mut x = goal.get("x");
	let mut y = goal.get("y");
	let mut f = goal.get("f");
	let mut z = goal.get("z");
	let c0 = goal.get("candidates").at(0);
	if (x.is_nullish() || y.is_nullish()) && goal.get("candidates").is_arr() && c0.truthy() {
		map = c0.get("map");
		x = c0.get("x");
		y = c0.get("y");
		f = c0.get("f");
		z = c0.get("z");
	}
	let s0 = goal.get("spots").at(0);
	if (x.is_nullish() || y.is_nullish()) && goal.get("spots").is_arr() && s0.truthy() {
		x = s0.get("x");
		y = s0.get("y");
		z = s0.get("z");
	}
	if map.is_nullish() || x.is_nullish() || y.is_nullish() {
		return None;
	}
	let b = if f.as_str() == Some("e") {
		frame_of(&frames.get("era"), &map)
	} else {
		let fv = frame_of(&frames.get("forever"), &map);
		if fv.truthy() {
			fv
		} else {
			frame_of(&frames.get("era"), &map)
		}
	};
	if !b.truthy() {
		return None;
	}
	let (top, bottom, left, right) = (b.get("top").num(), b.get("bottom").num(), b.get("left").num(), b.get("right").num());
	let z = z.as_num().filter(|v| v.is_finite());
	Some(World { c: b.get("c"), wx: top + ((bottom - top) * y.num()) / 100.0, wy: left + ((right - left) * x.num()) / 100.0, z })
}

/// Step s (1-based, as the addon counts) and its leg in: from the last located
/// goal before the step to its first located goal, on one continent and at
/// least MIN_LEG_YD apart. -> [(s, from, to)].
pub fn step_targets(guide: &V, frames: &V) -> Vec<(usize, World, World)> {
	let mut out = Vec::new();
	let mut last: Option<World> = None;
	for (i, step) in guide.get("steps").items().iter().enumerate() {
		let mut first: Option<World> = None;
		let mut end: Option<World> = None;
		for goal in step.get("goals").items() {
			if goal.get("t").as_str() == Some("note") {
				continue;
			}
			let Some(p) = goal_world(&goal, frames) else { continue };
			if first.is_none() {
				first = Some(p.clone());
			}
			end = Some(p);
		}
		if let (Some(first), Some(l)) = (&first, &last) {
			if l.c.strict_eq(&first.c) && hypot(first.wx - l.wx, first.wy - l.wy) >= MIN_LEG_YD {
				out.push((i + 1, l.clone(), first.clone()));
			}
		}
		if end.is_some() {
			last = end;
		}
	}
	out
}

fn leg_key(from: &World, to: &World) -> String {
	format!("{}:{},{}>{},{}", from.c.to_js_string(), num_str(math_round(from.wx)), num_str(math_round(from.wy)), num_str(math_round(to.wx)), num_str(math_round(to.wy)))
}

/// The guide's leg ends, hashed (staleness): sha1 hex, first 12 digits.
pub fn guide_hash(guide: &V, frames: &V) -> String {
	let mut text = String::new();
	for (s, from, to) in step_targets(guide, frames) {
		text.push_str(&format!("{s}:{};", leg_key(&from, &to)));
	}
	let digest = sha1(text.as_bytes());
	let hex: String = digest.iter().map(|b| format!("{b:02x}")).collect();
	hex[..12].to_string()
}

/// SHA-1 (FIPS 180-4), for guide_hash.
fn sha1(data: &[u8]) -> [u8; 20] {
	let mut h: [u32; 5] = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0];
	let mut msg = data.to_vec();
	let bit_len = (data.len() as u64).wrapping_mul(8);
	msg.push(0x80);
	while msg.len() % 64 != 56 {
		msg.push(0);
	}
	msg.extend_from_slice(&bit_len.to_be_bytes());
	for chunk in msg.chunks(64) {
		let mut w = [0u32; 80];
		for i in 0..16 {
			w[i] = u32::from_be_bytes([chunk[4 * i], chunk[4 * i + 1], chunk[4 * i + 2], chunk[4 * i + 3]]);
		}
		for i in 16..80 {
			w[i] = (w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16]).rotate_left(1);
		}
		let [mut a, mut b, mut c, mut d, mut e] = h;
		for (i, wi) in w.iter().enumerate() {
			let (f, k) = match i {
				0..=19 => ((b & c) | (!b & d), 0x5A827999),
				20..=39 => (b ^ c ^ d, 0x6ED9EBA1),
				40..=59 => ((b & c) | (b & d) | (c & d), 0x8F1BBCDC),
				_ => (b ^ c ^ d, 0xCA62C1D6),
			};
			let t = a.rotate_left(5).wrapping_add(f).wrapping_add(e).wrapping_add(k).wrapping_add(*wi);
			e = d;
			d = c;
			c = b.rotate_left(30);
			b = a;
			a = t;
		}
		for (x, v) in h.iter_mut().zip([a, b, c, d, e]) {
			*x = x.wrapping_add(v);
		}
	}
	let mut out = [0u8; 20];
	for (i, x) in h.iter().enumerate() {
		out[4 * i..4 * i + 4].copy_from_slice(&x.to_be_bytes());
	}
	out
}

#[cfg(test)]
mod tests {
	#[test]
	fn sha1_known() {
		let d = super::sha1(b"abc");
		let hex: String = d.iter().map(|b| format!("{b:02x}")).collect();
		assert_eq!(hex, "a9993e364706816aba3e25717850c26c9cd0d89d");
	}
}
