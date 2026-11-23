//! Level curve and kill XP (port of tools/lib/game/xp.js LEVEL_XP, zeroDiff, greyLevel, mobXp).

/// XP to finish each level (index = level, 0 unused), MAX_LEVEL 60.
pub const LEVEL_XP: [f64; 60] = [
	0.0, 400.0, 900.0, 1400.0, 2100.0, 2800.0, 3600.0, 4500.0, 5400.0, 6500.0, 7600.0, 8800.0, 10100.0, 11400.0, 12900.0, 14400.0, 16000.0, 17700.0, 19400.0, 21300.0, 23200.0, 25200.0, 27300.0,
	29400.0, 31700.0, 34000.0, 36400.0, 38900.0, 41400.0, 44300.0, 47400.0, 50800.0, 54500.0, 58600.0, 62800.0, 67100.0, 71600.0, 76100.0, 80800.0, 85700.0, 90700.0, 95800.0, 101000.0, 106300.0,
	111800.0, 117500.0, 123200.0, 129100.0, 135100.0, 141200.0, 147500.0, 153900.0, 160400.0, 167100.0, 173900.0, 180800.0, 187900.0, 195000.0, 202300.0, 209800.0,
];

pub const MAX_LEVEL: usize = 60;

/// XP to finish level `l` (60 and above: none needed, treated as finished).
#[inline]
pub fn level_xp(l: usize) -> f64 {
	if l < 60 {
		LEVEL_XP[l]
	} else {
		f64::NAN
	}
}

pub fn zero_diff(l: i64) -> f64 {
	match l {
		_ if l <= 7 => 5.0,
		_ if l <= 9 => 6.0,
		_ if l <= 11 => 7.0,
		_ if l <= 15 => 8.0,
		_ if l <= 19 => 9.0,
		_ if l <= 29 => 11.0,
		_ if l <= 39 => 12.0,
		_ if l <= 44 => 13.0,
		_ if l <= 49 => 14.0,
		_ if l <= 54 => 15.0,
		_ if l <= 59 => 16.0,
		_ => 17.0,
	}
}

pub fn grey_level(l: i64) -> i64 {
	if l <= 5 {
		0
	} else if l <= 39 {
		l - l.div_euclid(10) - 5
	} else if l <= 59 {
		l - l.div_euclid(5) - 1
	} else {
		l - 9
	}
}

/// mobXp(playerLevel, mobLevel, elite, { forever }).
pub fn mob_xp(player: i64, mob: i64, elite: bool, forever: bool) -> f64 {
	let base = (player * 5 + 45) as f64;
	let v = if mob >= player {
		base * (1.0 + 0.05 * ((mob - player).min(4) as f64))
	} else if mob <= grey_level(player) {
		0.0
	} else {
		let b = if forever { (mob * 5 + 45) as f64 } else { base };
		(b * (1.0 - (player - mob) as f64 / zero_diff(player))).max(0.0)
	};
	forge_core::js_round(v) * if elite { 2.0 } else { 1.0 }
}

/// The quest XP share by levels over the quest (evaluate.js SHARE): Forever's, from players'
/// recordings (the test below): 1 at <= 5, 0.8 at 6, 0.6 at 7, then 0.5 from 8 on, a floor
/// (Classic's 0.4, 0.2 and 0.1 further over are not what Forever pays).
pub const SHARE: [f64; 64] = {
	let mut s = [0.5; 64];
	let mut d = 0;
	while d < 64 {
		s[d] = match d {
			0..=5 => 1.0,
			6 => 0.8,
			7 => 0.6,
			_ => 0.5,
		};
		d += 1;
	}
	s
};

#[cfg(test)]
mod tests {
	use super::SHARE;

	/// Quest XP paid above the quest's level in players' recordings (every recorded turn-in with a
	/// quest level, 55,838 of them, 2026-11-13): what the hand-in paid against what the same quest
	/// paid people at 5 or fewer levels over, by the player's level minus the quest's.
	///
	/// | levels over | turn-ins | people | paid / full: median (p10-p90) |
	/// |---|---|---|---|
	/// | +5 | 2,457 | 322 | 1.00 (1.00-1.03) |
	/// | +6 | 1,522 | 271 | 0.80 (0.78-0.83) |
	/// | +7 | 854 | 233 | 0.60 (0.59-0.62) |
	/// | +8 | 478 | 169 | 0.50 (0.48-0.52) |
	/// | +9 | 244 | 119 | 0.50 (0.48-0.52) |
	/// | +10 | 139 | 72 | 0.50 (0.47-0.52) |
	/// | +11 to +15 | 234 | 94 | 0.50 (0.47-0.52) |
	/// | +16 and over | 100 | 32 | 0.50 (0.47-0.52) |
	///
	/// Every bucket has more than 3 people. From 8 over the payout stays at half however far over:
	/// a level 14 quest worth 490 paid 250 at 8 over and still 250 at 15 over.
	#[test]
	fn the_quest_xp_share_is_what_players_recordings_show_forever_pays() {
		let want = |d: usize| match d {
			0..=5 => 1.0,
			6 => 0.8,
			7 => 0.6,
			_ => 0.5,
		};
		for (d, s) in SHARE.iter().enumerate() {
			assert_eq!(*s, want(d), "{d} levels over");
		}
	}
}
