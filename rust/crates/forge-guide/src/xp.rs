//! Port of tools/lib/game/xp.js (the parts the guide toolchain uses: the level
//! tables, levelPoint/levelReached/gain, quest and kill XP; loadQuestXp and
//! parseQuestXp fetch and cache the client table for the data build and the
//! simulator and are not part of this crate).
//!
//! - XP to level: the 1.12 table.
//! - Quest XP: reduced by how far the player is above the quest: 100% up to
//!   quest level + 5, then 80/60/40/20/10%. `base_quest_xp` estimates a typical reward.
//! - Kill XP: 45 + 5 × player level against an equal-level mob, +5% per level
//!   the mob is above (at most +4 levels counted), scaled down by the
//!   zero-difference value below, nothing for grey mobs; elites ×2.

use crate::js::{math_round, num_str, str_to_num, V};

/// XP to go from level L to L+1 (index L).
pub const LEVEL_XP: [f64; 60] = [
	0.0, 400.0, 900.0, 1400.0, 2100.0, 2800.0, 3600.0, 4500.0, 5400.0, 6500.0, 7600.0, 8800.0, 10100.0, 11400.0, 12900.0, 14400.0, 16000.0, 17700.0, 19400.0, 21300.0, 23200.0, 25200.0, 27300.0,
	29400.0, 31700.0, 34000.0, 36400.0, 38900.0, 41400.0, 44300.0, 47400.0, 50800.0, 54500.0, 58600.0, 62800.0, 67100.0, 71600.0, 76100.0, 80800.0, 85700.0, 90700.0, 95800.0, 101000.0, 106300.0,
	111800.0, 117500.0, 123200.0, 129100.0, 135100.0, 141200.0, 147500.0, 153900.0, 160400.0, 167100.0, 173900.0, 180800.0, 187900.0, 195000.0, 202300.0, 209800.0,
];
pub const MAX_LEVEL: usize = 60;

/// Cumulative XP at the start of `level` (index 0..=60).
pub const CUM_XP: [f64; 61] = {
	let mut c = [0.0; 61];
	let mut l = 2;
	while l <= MAX_LEVEL {
		c[l] = c[l - 1] + LEVEL_XP[l - 1];
		l += 1;
	}
	c
};

fn level_xp(level: f64) -> f64 {
	if (0.0..60.0).contains(&level) && level.fract() == 0.0 {
		LEVEL_XP[level as usize]
	} else {
		f64::NAN
	}
}

/// Player progress: level, and xp into the current level.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Progress {
	pub level: f64,
	pub xp: f64,
}

/// Adds XP; returns the levels gained.
pub fn gain(state: &mut Progress, amount: f64) -> u32 {
	state.xp += amount;
	let mut ups = 0;
	while state.level < MAX_LEVEL as f64 && state.xp >= level_xp(state.level) {
		state.xp -= level_xp(state.level);
		state.level += 1.0;
		ups += 1;
	}
	if state.level >= MAX_LEVEL as f64 {
		state.xp = 0.0;
	}
	ups
}

/// A point inside a level: `{ level, frac?, xp? }`.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct LevelPoint {
	pub level: f64,
	pub frac: Option<f64>,
	pub xp: Option<f64>,
}

fn all_digits(s: &str) -> bool {
	!s.is_empty() && s.bytes().all(|b| b.is_ascii_digit())
}

/// A point inside a level, as a `level` goal or a `when level` predicate
/// writes it: "12" is the start of level 12, "12.5" halfway through it,
/// "12+2500" 2500 XP into it. `frac` is the share of the level done, rounded
/// to whole percent and strictly between 0 and 1. The level of "12" is not
/// range-checked: callers do that.
pub fn level_point(s: &str) -> Result<LevelPoint, String> {
	if all_digits(s) {
		return Ok(LevelPoint { level: str_to_num(s), frac: None, xp: None });
	}
	// /^(\d+)(?:\.(\d+)|\+(\d+))$/
	let malformed = || format!("malformed level \"{s}\" (expected N, N.fraction or N+XP)");
	let cut = match s.find(['.', '+']) {
		Some(i) => i,
		None => return Err(malformed()),
	};
	let (a, sep, b) = (&s[..cut], &s[cut..cut + 1], &s[cut + 1..]);
	if !all_digits(a) || !all_digits(b) {
		return Err(malformed());
	}
	let (m2, m3) = if sep == "." { (Some(b), None) } else { (None, Some(b)) };
	let level = str_to_num(a);
	if level < 1.0 || level >= MAX_LEVEL as f64 {
		return Err(format!("level {s}: a point inside a level needs a level from 1 to {}", MAX_LEVEL - 1));
	}
	let need = level_xp(level);
	let xp = m3.map(str_to_num);
	if let Some(x) = xp {
		if x >= need {
			return Err(format!("level {s}: more XP than level {} needs ({})", num_str(level), num_str(need)));
		}
	}
	let exact = match xp {
		Some(x) => x / need,
		None => str_to_num(&format!("0.{}", m2.unwrap())),
	};
	if exact == 0.0 {
		return Ok(LevelPoint { level, frac: None, xp: None });
	}
	let frac = math_round(exact * 100.0) / 100.0;
	if frac <= 0.0 {
		return Err(format!("level {s} is less than 1% into level {}: write {}", num_str(level), num_str(level)));
	}
	if frac >= 1.0 {
		return Err(format!("level {s} rounds to the end of level {}: write {}", num_str(level), num_str(level + 1.0)));
	}
	Ok(LevelPoint { level, frac: Some(frac), xp })
}

/// Whether progress has reached a `level` goal: past its level, or at it with
/// `frac` of the level's XP (frac 0 = none).
pub fn level_reached(state: &Progress, level: f64, frac: f64) -> bool {
	if state.level != level || frac == 0.0 || frac.is_nan() || level >= MAX_LEVEL as f64 {
		return state.level >= level;
	}
	state.xp / level_xp(level) >= frac
}

// Full reward of a typical quest by quest level, linear between anchors.
const QUEST_XP_ANCHORS: [(f64, f64); 13] = [
	(1.0, 100.0),
	(5.0, 400.0),
	(10.0, 800.0),
	(15.0, 1200.0),
	(20.0, 1700.0),
	(25.0, 2200.0),
	(30.0, 2700.0),
	(35.0, 3250.0),
	(40.0, 3800.0),
	(45.0, 4400.0),
	(50.0, 5100.0),
	(55.0, 5800.0),
	(60.0, 6600.0),
];

/// `qlvl || 1`, clamped to 1..60, interpolated.
pub fn base_quest_xp(qlvl: f64) -> f64 {
	let q = if qlvl == 0.0 || qlvl.is_nan() { 1.0 } else { qlvl };
	let l = 1f64.max((MAX_LEVEL as f64).min(q));
	for i in 1..QUEST_XP_ANCHORS.len() {
		let (l1, x1) = QUEST_XP_ANCHORS[i];
		let (l0, x0) = QUEST_XP_ANCHORS[i - 1];
		if l <= l1 {
			return math_round(x0 + ((x1 - x0) * (l - l0)) / (l1 - l0));
		}
	}
	QUEST_XP_ANCHORS[QUEST_XP_ANCHORS.len() - 1].1
}

/// Share of a quest's reward by player level − quest level.
pub fn quest_xp_share(player_level: f64, quest_level: f64) -> f64 {
	let d = player_level - quest_level;
	if d <= 5.0 {
		return 1.0;
	}
	if d >= 10.0 {
		return 0.1;
	}
	match d {
		6.0 => 0.8,
		7.0 => 0.6,
		8.0 => 0.4,
		9.0 => 0.2,
		_ => f64::NAN,
	}
}

pub fn quest_xp_at(full: f64, player_level: f64, quest_level: f64) -> f64 {
	full * quest_xp_share(player_level, quest_level)
}

/// A quest's reward at a player level, rounded: `xp` from data, else the estimate.
pub fn quest_xp(quest: &V, player_level: f64) -> f64 {
	let mut q = quest.get("level");
	if !q.truthy() {
		q = quest.get("minLevel");
	}
	let qlvl = if q.truthy() { q.num() } else { player_level };
	let full = match quest.get("xp") {
		V::Num(x) if x > 0.0 => x,
		_ => base_quest_xp(qlvl),
	};
	math_round(full * quest_xp_share(player_level, qlvl))
}

pub fn zero_diff(l: f64) -> f64 {
	if l <= 7.0 {
		5.0
	} else if l <= 9.0 {
		6.0
	} else if l <= 11.0 {
		7.0
	} else if l <= 15.0 {
		8.0
	} else if l <= 19.0 {
		9.0
	} else if l <= 29.0 {
		11.0
	} else if l <= 39.0 {
		12.0
	} else if l <= 44.0 {
		13.0
	} else if l <= 49.0 {
		14.0
	} else if l <= 54.0 {
		15.0
	} else if l <= 59.0 {
		16.0
	} else {
		17.0
	}
}

/// Highest mob level that is grey (gives nothing) to a player of level l.
pub fn grey_level(l: f64) -> f64 {
	if l <= 5.0 {
		0.0
	} else if l <= 39.0 {
		l - (l / 10.0).floor() - 5.0
	} else if l <= 59.0 {
		l - (l / 5.0).floor() - 1.0
	} else {
		l - 9.0
	}
}

/// Forever (#30): a mob below the player starts from the mob's own level, then
/// takes the same level-difference factor. Mobs at or above the player: Classic.
pub fn mob_xp(player_level: f64, mob_level: f64, elite: bool, forever: bool) -> f64 {
	let base = player_level * 5.0 + 45.0;
	let v = if mob_level >= player_level {
		base * (1.0 + 0.05 * (mob_level - player_level).min(4.0))
	} else if mob_level <= grey_level(player_level) {
		0.0
	} else {
		0f64.max((if forever { mob_level * 5.0 + 45.0 } else { base }) * (1.0 - (player_level - mob_level) / zero_diff(player_level)))
	};
	math_round(v) * if elite { 2.0 } else { 1.0 }
}
