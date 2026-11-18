//! `forge sim fights` (forge::fights): which kills make a sample, that the fit gives back the
//! terms a made-up set of players was generated from, and that a player is set against themselves.

use forge::fights::{fit, report, session_samples, Sample, RUN_SPEED};
use serde_json::{json, Value};

/// A map 1000 yd square on continent 0: one percent is 10 yd.
fn maps() -> Value {
	json!({ "1": { "c": 0, "left": 1000.0, "right": 0.0, "top": 1000.0, "bottom": 0.0 }, "2": { "c": 1, "left": 1000.0, "right": 0.0, "top": 1000.0, "bottom": 0.0 } })
}

fn kill(t: f64, x: f64, extra: Value) -> Value {
	let mut e = json!({ "e": "kill", "t": t, "npc": 6, "npcLvl": 5, "cls": "normal", "map": 1, "x": x, "y": 50.0 });
	for (k, v) in extra.as_object().unwrap() {
		e[k] = v.clone();
	}
	e
}

fn session(events: Vec<Value>) -> Value {
	json!({ "char": { "class": "MAGE" }, "contributor": "sent-a", "maps": maps(), "events": events })
}

#[test]
fn a_sample_is_the_seconds_between_two_kills_less_the_walk() {
	// 70 yd apart (7 percent of 1000 yd) is 10 s at run speed: 30 s between the kills leaves 20.
	let doc = session(vec![json!({ "e": "level", "t": 0, "lvl": 5 }), kill(100.0, 50.0, json!({})), kill(130.0, 57.0, json!({ "npcLvl": 7 }))]);
	let s = session_samples(&doc);
	assert_eq!(s.len(), 1);
	assert_eq!((s[0].voter.as_str(), s[0].class.as_str(), s[0].level, s[0].gap, s[0].elite), ("sent-a", "MAGE", 5, 2, false));
	assert!((s[0].sec - (30.0 - 70.0 / RUN_SPEED)).abs() < 1e-9, "{}", s[0].sec);
}

#[test]
fn kills_that_are_no_solo_fight_are_left_out() {
	let lvl = json!({ "e": "level", "t": 0, "lvl": 5 });
	let pair = |second: Value| session_samples(&session(vec![lvl.clone(), kill(100.0, 50.0, json!({})), second])).len();
	assert_eq!(pair(kill(130.0, 50.0, json!({}))), 1, "the plain pair counts");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "group": 2 }))), 0, "in a group");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "group": 0 }))), 1, "solo, said so");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "denied": true }))), 0, "another player's tap");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "cls": "rare" }))), 0, "a rare");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "cls": "elite" }))), 1, "an elite counts, as one");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "npcLvl": 12 }))), 0, "7 levels above");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "npcLvl": 0 }))), 0, "no mob level");
	assert_eq!(pair(kill(101.5, 50.0, json!({}))), 0, "1.5 s after the last: one pull");
	assert_eq!(pair(kill(300.0, 50.0, json!({}))), 0, "200 s after the last");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "map": 2 }))), 0, "the other continent");
	assert_eq!(pair(kill(130.0, 50.0, json!({ "map": 9 }))), 0, "a map without a frame");
	assert_eq!(pair(kill(110.0, 57.0, json!({}))), 0, "10 s for a 10 s walk: nothing left");

	// Something between the kills that is no fight or walk.
	for between in [json!({ "e": "death", "t": 110 }), json!({ "e": "afk", "t": 110, "on": true }), json!({ "e": "taxi", "t": 110 }), json!({ "e": "ride", "t": 110, "on": true })] {
		let n = session_samples(&session(vec![lvl.clone(), kill(100.0, 50.0, json!({})), between.clone(), kill(130.0, 50.0, json!({}))])).len();
		assert_eq!(n, 0, "{between}");
	}
	let back = session_samples(&session(vec![lvl.clone(), kill(100.0, 50.0, json!({})), json!({ "e": "afk", "t": 110, "on": false }), kill(130.0, 50.0, json!({}))]));
	assert_eq!(back.len(), 1, "coming back from AFK breaks nothing");

	// No class, no level: nothing to file the kills under.
	let mut no_class = session(vec![lvl.clone(), kill(100.0, 50.0, json!({})), kill(130.0, 50.0, json!({}))]);
	no_class["char"] = json!({});
	assert!(session_samples(&no_class).is_empty());
	assert!(session_samples(&session(vec![kill(100.0, 50.0, json!({})), kill(130.0, 50.0, json!({}))])).is_empty());
}

#[test]
fn a_cohort_is_the_player_before_the_contributor() {
	let mut doc = session(vec![json!({ "e": "level", "t": 0, "lvl": 5 }), kill(100.0, 50.0, json!({})), kill(130.0, 50.0, json!({}))]);
	doc["cohort"] = json!("0123456789abcdef");
	assert_eq!(session_samples(&doc)[0].voter, "cohort:0123456789abcdef");
	doc["cohort"] = json!("not-a-cohort");
	assert_eq!(session_samples(&doc)[0].voter, "sent-a");
}

/// The model the made-up players fight by.
const CLASSES: [(&str, f64); 3] = [("WARRIOR", 1.25), ("MAGE", 0.8), ("ROGUE", 1.0)]; // geometric mean 1
const ELITE: f64 = 3.0;
fn base(level: i64) -> f64 {
	10.0 + 0.3 * (level - 1) as f64
}
fn gap_mul(d: i64) -> f64 {
	if d > 0 {
		1.0 + 0.1 * d as f64
	} else {
		1.0 - 0.05 * (-d) as f64
	}
}

/// Three players of each class, levels 5 to 40, mobs 3 below to 3 above, an elite now and then.
/// `noise(i)` multiplies sample i's seconds.
fn made_up(noise: impl Fn(usize) -> f64) -> Vec<Sample> {
	let mut out = Vec::new();
	let mut i = 0;
	for (class, factor) in CLASSES {
		for player in 0..3 {
			for level in (5..=40).step_by(5) {
				for d in -3i64..=3 {
					for elite in [false, true] {
						// Not every player meets every mob: the fit must not need a full table.
						if elite && !(player + level as usize + d.unsigned_abs() as usize).is_multiple_of(3) {
							continue;
						}
						for _ in 0..5 {
							let sec = base(level) * gap_mul(d) * factor * if elite { ELITE } else { 1.0 } * noise(i);
							out.push(Sample { voter: format!("{class}-{player}"), class: class.to_string(), level, gap: d, elite, sec });
							i += 1;
						}
					}
				}
			}
		}
	}
	out
}

#[test]
fn the_fit_gives_back_the_terms_the_players_were_made_from() {
	let f = fit(9, &made_up(|_| 1.0));
	let near = |got: f64, want: f64| assert!((got - want).abs() < 1e-6, "{got} != {want}");
	assert_eq!((f.sessions, f.voters, f.classes.len()), (9, 9, 3));
	let (k1, k60) = f.kill_sec.unwrap();
	near(k1, 10.0);
	near(k60, 10.0 + 0.3 * 59.0);
	near(f.kill_up.unwrap(), 0.1);
	near(f.kill_down.unwrap(), 0.05);
	near(f.elite_time.unwrap(), ELITE);
	for (class, factor) in CLASSES {
		let c = f.classes.iter().find(|c| c.class == class).unwrap();
		near(c.factor, factor);
		assert_eq!(c.voters, 3);
	}
	near(f.gaps.iter().find(|g| g.gap == 0).unwrap().ratio, 1.0);
	near(f.gaps.iter().find(|g| g.gap == 3).unwrap().ratio, 1.3);
	near(f.levels.iter().find(|l| l.level == 20).unwrap().sec, base(20));
	// Nobody picks their fights here, so every player set against every other reads the same.
	near(f.all_players.kill_up.unwrap(), 0.1);
	near(f.all_players.kill_down.unwrap(), 0.05);
	near(f.all_players.elite_time.unwrap(), ELITE);
	assert_eq!(f.cells_used, f.cells, "every cell is in the level and class fit");
}

#[test]
fn noise_and_one_player_who_farms_do_not_move_it_far() {
	// A fixed scatter of -30 % to +30 % around each sample, the same every run.
	let noise = |i: usize| 0.7 + 0.6 * ((i * 2654435761) % 1000) as f64 / 999.0;
	let mut s = made_up(noise);
	// One Mage who kills green mobs at level 20 all day, three times slower than the model.
	for i in 0..4000 {
		s.push(Sample { voter: "MAGE-0".into(), class: "MAGE".into(), level: 20, gap: -3, elite: false, sec: 3.0 * base(20) * gap_mul(-3) * 0.8 * noise(i) });
	}
	let f = fit(9, &s);
	let within = |got: f64, want: f64, share: f64| assert!((got / want - 1.0).abs() < share, "{got} is not within {share} of {want}");
	let (k1, k60) = f.kill_sec.unwrap();
	within(k1, 10.0, 0.1);
	within(k60, 27.7, 0.1);
	within(f.kill_up.unwrap(), 0.1, 0.25);
	within(f.kill_down.unwrap(), 0.05, 0.4);
	within(f.elite_time.unwrap(), ELITE, 0.1);
	for (class, factor) in CLASSES {
		within(f.classes.iter().find(|c| c.class == class).unwrap().factor, factor, 0.1);
	}
}

#[test]
fn a_strong_player_who_picks_harder_mobs_does_not_flatten_the_terms() {
	// Two Rogues at the same levels. The strong one (0.6 of the model's seconds) fights mobs at
	// and above the character and elites; the weak one (1.4) fights mobs at and below it, never an
	// elite. Set against each other, the mobs above look fast because the strong player fought them.
	let mut s = Vec::new();
	for (voter, own, gaps, elites) in [("strong", 0.6, 0..=3i64, true), ("weak", 1.4, -3..=0i64, false)] {
		for level in (10..=30).step_by(5) {
			for d in gaps.clone() {
				for elite in [false, true] {
					if elite && !elites {
						continue;
					}
					for _ in 0..5 {
						s.push(Sample { voter: voter.into(), class: "ROGUE".into(), level, gap: d, elite, sec: base(level) * gap_mul(d) * own * if elite { ELITE } else { 1.0 } });
					}
				}
			}
		}
	}
	let f = fit(2, &s);
	let near = |got: f64, want: f64| assert!((got - want).abs() < 1e-6, "{got} != {want}");
	near(f.kill_up.unwrap(), 0.1);
	near(f.kill_down.unwrap(), 0.05);
	near(f.elite_time.unwrap(), ELITE);
	near(f.gaps.iter().find(|g| g.gap == 3).unwrap().ratio, 1.3);
	near(f.gaps.iter().find(|g| g.gap == -3).unwrap().ratio, 0.85);
	// The same kills with every player set against every other, reported beside it: the mobs above read fast.
	let all = f.all_players.kill_up.unwrap();
	assert!(all < 0.0, "{all}");
}

#[test]
fn a_mob_level_no_player_fought_beside_another_is_left_out() {
	// One player on even-level mobs and mobs 1 above; another on mobs 3 above only. Nothing sets
	// the second player's kills against a mob level the first fought, so +3 has no ratio.
	let mut s = Vec::new();
	for (voter, d) in [("a", 0i64), ("a", 1), ("b", 3)] {
		for _ in 0..5 {
			s.push(Sample { voter: voter.into(), class: "MAGE".into(), level: 12, gap: d, elite: false, sec: base(12) * gap_mul(d) });
		}
	}
	let f = fit(2, &s);
	assert_eq!(f.gaps.iter().map(|g| g.gap).collect::<Vec<_>>(), vec![0, 1]);
	assert!((f.kill_up.unwrap() - 0.1).abs() < 1e-6);
	assert_eq!(f.groups, 1, "one player and level with two mob levels to compare");
	// The second player's cell leaves the level and class fit with it, and the report counts that.
	assert_eq!((f.cells, f.cells_used), (3, 2));
	assert_eq!((f.classes[0].voters, f.classes[0].samples, f.levels[0].samples), (1, 10, 10));

	// An elite with no normal kill of the same player at the same level has nothing to be set against.
	// With no eliteTime to take out of it, it is in no level or class either.
	let mut e: Vec<Sample> = s.iter().filter(|x| x.voter == "a").cloned().collect();
	for _ in 0..5 {
		e.push(Sample { voter: "c".into(), class: "MAGE".into(), level: 12, gap: 0, elite: true, sec: 99.0 });
	}
	let alone = fit(2, &e);
	assert_eq!((alone.elite_time, alone.elite_cells, alone.cells, alone.cells_used), (None, 0, 3, 2));

	// Once another player's elite gives an eliteTime, the same cell counts for level and class with
	// that taken out, and still not for eliteTime.
	for _ in 0..5 {
		e.push(Sample { voter: "a".into(), class: "MAGE".into(), level: 12, gap: 0, elite: true, sec: base(12) * ELITE });
	}
	let beside = fit(2, &e);
	assert!((beside.elite_time.unwrap() - ELITE).abs() < 1e-6);
	assert_eq!((beside.elite_cells, beside.cells, beside.cells_used, beside.classes[0].voters), (1, 4, 4, 2));
}

#[test]
fn a_term_nothing_was_recorded_for_is_absent() {
	// One class, one level, even-level normal mobs only.
	let s: Vec<Sample> = (0..10).map(|_| Sample { voter: "a".into(), class: "MAGE".into(), level: 12, gap: 0, elite: false, sec: 14.0 }).collect();
	let f = fit(1, &s);
	assert_eq!((f.kill_sec, f.kill_up, f.kill_down, f.elite_time), (None, None, None, None));
	assert_eq!(f.classes.len(), 1);
	assert!((f.classes[0].factor - 1.0).abs() < 1e-9 && (f.levels[0].sec - 14.0).abs() < 1e-9);

	// Under three samples in every cell, or no even-level kills to measure the others against: no fit.
	let thin = fit(1, &s[..2]);
	assert_eq!((thin.samples, thin.cells, thin.classes.len()), (2, 0, 0));
	let above: Vec<Sample> = s.iter().map(|x| Sample { gap: 2, ..x.clone() }).collect();
	assert!(fit(1, &above).classes.is_empty());
	assert_eq!(fit(0, &[]), forge::fights::FightFit::default());
}

#[test]
fn the_report_sets_each_term_beside_its_prior() {
	let f = fit(9, &made_up(|_| 1.0));
	let r = report(&f, "2026-11-17T00:00:00.000Z", forge_sim_class_priors(), forge::calibrate::PRIORS);
	assert_eq!(r["killUp"], json!({ "fitted": 0.1, "prior": 0.1 }));
	assert_eq!(r["eliteTime"], json!({ "fitted": 3.0, "prior": 3.5 }));
	assert_eq!(r["killSec1"], json!({ "fitted": 10.0, "prior": 11.0 }));
	assert_eq!(r["classFactor"]["WARRIOR"]["factor"], 1.25);
	assert_eq!(r["classFactor"]["WARRIOR"]["prior"], 1.15);
	assert_eq!(r["classFactor"]["MAGE"]["voters"], 3);
	assert_eq!((r["sessions"].as_u64(), r["voters"].as_u64()), (Some(9), Some(9)));
	// 9 players at 8 levels, each with all 7 mob levels: 72 groups of 7 normal cells. An elite cell where
	// (player + level + |d|) is a multiple of 3: mob levels 0, -3 and 3 in the 24 groups where
	// player + level is one, and 2 of the other mob levels in the other 48.
	let elite_cells = 24 * 3 + 48 * 2;
	assert_eq!((r["schema"].as_u64(), r["groups"].as_u64(), r["eliteCells"].as_u64()), (Some(2), Some(72), Some(elite_cells)));
	assert_eq!((r["cells"].as_u64(), r["cellsUsed"].as_u64()), (Some(72 * 7 + elite_cells), Some(72 * 7 + elite_cells)));
	assert_eq!(r["allPlayers"], json!({ "killUp": 0.1, "killDown": 0.05, "eliteTime": 3.0 }));
	assert_eq!(r["byGap"][0]["samples"], 72 * 5);
	assert_eq!(r["byGap"].as_array().unwrap().len(), 7);
}

/// params.rs's class priors, as `forge sim fights` passes them.
fn forge_sim_class_priors() -> &'static [(&'static str, f64)] {
	&[("Warrior", 1.15), ("Mage", 0.9), ("Rogue", 1.0)]
}
