//! `forge sim calibrate`: data/sim/params.json from the quest data and recordings (port of
//! tools/lib/sim/calibrate.js; same file, same numbers). Two sources, each fitting what it can
//! inform; every other parameter keeps its prior:
//! 1. quest rewards: questEstScale (the worlds' recorded `xp` against the QuestXP-table estimate)
//!    and questXpScale (the dungeon journal's observed Forever rewards against the data's);
//!    robust: median of log ratios, sd = 1.4826·MAD/√n, floored at 0.02 (0.03 when kept);
//! 2. recordings: seconds between kills by level -> killSec1/killSec60 (weighted least squares).

use std::path::{Path, PathBuf};

use forge_guide::js::{stringify, Obj, V};
use serde_json::Value;

/// params.js PRIORS: (name, mean, sd, lo, hi, description), in its order.
pub const PRIORS: &[(&str, f64, f64, f64, f64, &str)] = &[
    ("runSpeed", 7.0, 0.15, 6.5, 7.5, "run speed, yd/s"),
    ("mountLevel", 40.0, 0.0, 40.0, 40.0, "level the mount is bought"),
    ("mountMul", 1.6, 0.0, 1.6, 1.6, "mounted speed multiplier"),
    ("detour0", 1.35, 0.12, 1.05, 2.0, "walking detour factor, Eastern Kingdoms (path / straight line)"),
    ("detour1", 1.3, 0.12, 1.05, 2.0, "walking detour factor, Kalimdor"),
    ("routeMul", 1.0, 0.05, 0.9, 1.3, "routed walk (sim walks) / the walking router's yards: a player strays a little from the drawn line"),
    ("killSec1", 11.0, 3.0, 6.0, 30.0, "seconds per kill incl. downtime at level 1 (equal-level mob)"),
    ("killSec60", 30.0, 6.0, 15.0, 60.0, "seconds per kill incl. downtime at level 60"),
    ("killUp", 0.1, 0.04, 0.0, 0.3, "kill time +share per mob level above the player"),
    ("killDown", 0.05, 0.02, 0.0, 0.12, "kill time -share per mob level below the player (floor 0.5)"),
    ("eliteTime", 3.5, 1.0, 1.5, 8.0, "kill time multiplier for elites"),
    ("groupSize", 3.0, 0.0, 2.0, 5.0, "v2: players in the party an elite quest is done with (Fitz 2026-10-20: elite quests in, grouping advised), an estimate: an elite kill takes eliteTime solo kills split over them"),
    ("groupShare", 0.389, 0.0, 0.389, 0.389, "v2: share of an elite kill's (double) XP each member of that party gets (Classic: a 3-player party's 1.166 bonus / 3)"),
    ("groupWait", 600.0, 300.0, 120.0, 1800.0, "v2: seconds to find a group, once per elite camp worked (a chain at one camp waits once), an estimate"),
    ("classFactor", 1.0, 0.1, 0.6, 1.6, "kill time multiplier of the class"),
    ("spacing", 1.0, 0.25, 0.4, 2.5, "multiplier on the walk between mobs from spawn density"),
    ("talkSec", 6.0, 2.0, 2.0, 15.0, "seconds per accept or turn-in"),
    ("interactSec", 8.0, 3.0, 2.0, 25.0, "seconds per object use"),
    ("escortSec", 240.0, 90.0, 60.0, 600.0, "seconds per event objective that is no escort (a defend event, an exploration); an escort without a known path or end (v1: every escort/event)"),
    ("escortFail", 0.15, 0.08, 0.0, 0.5, "v2: chance an escort fails once (the NPC dies to its ambush, the player strays), an estimate (QuestMechanics: \"fails easily\")"),
    ("escortBusy", 0.1, 0.08, 0.0, 0.5, "v2: chance an escort NPC is away on another player's escort when the character arrives, an estimate (QuestMechanics: \"the NPC is often taken\")"),
    ("escortRespawn", 180.0, 90.0, 30.0, 600.0, "v2: seconds an escort NPC takes to come back after a failed or another player's run, an estimate"),
    ("dropMul", 1.0, 0.2, 0.5, 2.0, "real drop rate / data drop rate"),
    ("extraKill", 0.043, 0.038, 0.0, 0.8, "incidental kills per objective kill (mobs in the way; fixed, fitted 2026-10-12 against level checkpoints)"),
    ("questXpScale", 1.0, 0.1, 0.5, 1.5, "Forever quest XP / data quest XP (all rewards)"),
    ("questEstScale", 1.0, 0.12, 0.5, 1.6, "real reward / QuestXP-table estimate (quests without recorded XP)"),
    ("flightOverhead", 20.0, 8.0, 5.0, 60.0, "seconds per flight: talk, take-off, landing"),
    ("transportWait", 1.0, 0.3, 0.3, 2.0, "multiplier on boat/zeppelin/tram average waits"),
    ("hearthCast", 10.0, 0.0, 10.0, 10.0, "hearthstone cast, seconds"),
    ("hearthCooldown", 3600.0, 0.0, 1800.0, 3600.0, "hearthstone cooldown, seconds"),
    ("deathskipSec", 60.0, 20.0, 30.0, 120.0, "deathskip (die on purpose, release, Spirit Healer), seconds: an estimate, ~30 s pulling mobs to die to plus the healer's ~30 s (v2 travel2.js SPIRIT_HEAL_SEC)"),
    ("deathskipLevel", 60.0, 0.0, 0.0, 60.0, "policy: highest level a route deathskips at (CapAudit #5: any level; above 10 resurrection sickness is priced as slower kills, sicknessSlow; was 10, Forever's last level without sickness)"),
    ("sicknessSlow", 0.5, 0.2, 0.2, 1.0, "v2: share of each second of resurrection sickness spent working that is lost to slower kills (the debuff cuts stats; walking, flights and talks lose nothing), an estimate"),
    ("levelOverhead", 60.0, 40.0, 0.0, 300.0, "seconds per level-up: training, vendoring, repairs"),
    ("grindEff", 0.7, 0.12, 0.35, 1.1, "grinding XP rate / formula rate at the best site (respawns, competition, bag trips)"),
    ("grindWeight", 2.5, 0.0, 2.5, 2.5, "policy, not a measurement: an hour of grinding counts as this many hours when routes are compared, so a route grinds only where no quest is nearly as good (reported times stay real)"),
    ("escortWeight", 2.5, 0.0, 2.5, 2.5, "policy, not a measurement: a second of an escort counts as this many when the accept rule prices it, as grinding's do (grindWeight), so an escort is taken when its XP beats grinding outright or it opens a chain that does: players skip escorts (the wait for the NPC, its pace, a failed run; reported times stay real)"),
    ("zoneChange", 450.0, 0.0, 450.0, 450.0, "policy, not a measurement: seconds a move into another zone counts when routes are compared, so a route takes a hub's quests and does them in one go and switches zones only when it is clearly worth it (reported times stay real)"),
    ("zoneReturn", 0.0, 0.0, 0.0, 0.0, "policy, not a measurement: seconds a move back into a zone the route was in earlier (and left) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("spotReturn", 0.0, 0.0, 0.0, 0.0, "policy, not a measurement: seconds work again at a spot (250 yd cell) worked earlier, after leaving it by more than 600 yd, counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("wastedAccept", 0.0, 0.0, 0.0, 0.0, "policy, not a measurement: seconds each quest accepted and never handed in (abandoned for a full log, or still in the log at 60) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("stepCost", 0.0, 0.0, 0.0, 600.0, "policy: per-area-visit cost (seconds); 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("deadLeg", 0.0, 0.0, 0.0, 0.0, "v2 policy, not a measurement: seconds each dead leg (an arrival where nothing happens; route audit check 6) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("hubSplit", 0.0, 0.0, 0.0, 0.0, "v2 policy, not a measurement: seconds each hub split (a hub's quests accepted on a later trip; route audit check 5) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("missedAccept", 0.0, 0.0, 0.0, 0.0, "v2 policy, not a measurement: seconds each missed accept (a quest the walk passed and the sim would take, not taken then; route audit check 1) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("missedTurnin", 0.0, 0.0, 0.0, 0.0, "v2 policy, not a measurement: seconds each missed turn-in (route audit check 2) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("avoidableReturn", 0.0, 0.0, 0.0, 0.0, "v2 policy, not a measurement: seconds each avoidable return (back in a zone for work its first visit passed; route audit check 4) counts when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("xpLoss", 0.0, 0.0, 0.0, 0.0, "v2 policy, not a measurement: weight on the seconds the XP lost to late turn-ins (the character 6+ levels over the quest) takes at the route's average rate, when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("overrunWeight", 0.0, 0.0, 0.0, 0.0, "v2 policy, not a measurement: the smooth pass's soft time bound (spec §4): a route over (1 + ε) × the fastest route's time counts this × the overrun² (seconds) more; 0 in the time objective, see OBJECTIVES"),
    ("territory", 0.0, 0.0, 0.0, 0.0, "v2 policy, not a measurement: each second walked or worked in the other faction's territory (v2/territory.js: an AreaTable faction zone weighs 1, a contested zone leaning to it 0.4) counts this many times more when routes are compared; 0 in the time objective, see OBJECTIVES (reported times stay real)"),
    ("territoryPvp", 1.0, 0.0, 1.0, 1.0, "v2 policy: multiplier on territory for the realm (1: normal; a PvP realm's heavier weight is a later option)"),
    ("gateGap", 2.0, 0.0, 2.0, 2.0, "levels a character grinds to reach a quest's minimum level; further above, the quest is not available yet"),
    ("dangerGap", 5.0, 0.0, 5.0, 5.0, "most levels a quest may be above the character (red quests are not attempted)"),
    ("deathRisk", 300.0, 150.0, 0.0, 1200.0, "seconds lost per walking crossing of a zone whose mobs are 5+ levels above the character (deaths, corpse runs, detours)"),
    ("dungeonRunLow", 35.0, 10.0, 15.0, 75.0, "minutes per dungeon clear at dungeon level 15 (5-player group)"),
    ("dungeonRunHigh", 60.0, 15.0, 25.0, 120.0, "minutes per dungeon clear at dungeon level 55"),
    ("dungeonFormUp", 15.0, 8.0, 2.0, 45.0, "minutes to form a group and reach the instance portal"),
    ("dungeonTrash", 70.0, 20.0, 25.0, 150.0, "elite trash kills per clear (DungeonJournal has no trash counts)"),
    ("partyShare", 0.28, 0.0, 0.28, 0.28, "share of solo kill XP each of 5 party members gets (Classic: 1.4 / 5)"),
    ("restedShare", 0.0, 0.0, 0.0, 1.0, "share of kill XP doubled by rested XP (optional)"),
    ("trainSec", 60.0, 0.0, 60.0, 60.0, "v2: seconds per class trainer visit (v1 levelOverhead, spec §2.6)"),
    ("vendorSec", 60.0, 0.0, 60.0, 60.0, "v2: seconds per vendor visit, repair and sell (estimate, spec §2.6)"),
    ("ruleSoftPenalty", 600.0, 0.0, 0.0, 3600.0, "v2: seconds penalty for bending an unconfirmed rule (spec §6.2)"),
];

/// One robust fit of ratios.
#[derive(Clone, Copy, Debug)]
pub struct Fit {
	pub n: usize,
	pub mean: f64,
	pub sd: f64,
	pub spread: f64,
}

impl Fit {
	fn v(&self) -> V {
		let o = Obj::new();
		o.set("n", self.n as f64);
		o.set("mean", self.mean);
		o.set("sd", self.sd);
		o.set("spread", self.spread);
		V::Obj(o)
	}
}

fn opt(f: &Option<Fit>) -> V {
	f.as_ref().map_or(V::Null, Fit::v)
}

fn median(a: &[f64]) -> f64 {
	let mut s = a.to_vec();
	s.sort_by(|x, y| x.partial_cmp(y).unwrap());
	let n = s.len();
	if n == 0 {
		f64::NAN
	} else if n % 2 == 1 {
		s[(n - 1) / 2]
	} else {
		(s[n / 2 - 1] + s[n / 2]) / 2.0
	}
}

/// calibrate.js `ratioFit`.
pub fn ratio_fit(ratios: &[f64]) -> Option<Fit> {
	let logs: Vec<f64> = ratios.iter().filter(|r| **r > 0.0 && r.is_finite()).map(|r| r.ln()).collect();
	if logs.len() < 3 {
		return None;
	}
	let med = median(&logs);
	let mad = median(&logs.iter().map(|x| (x - med).abs()).collect::<Vec<_>>());
	let spread = 1.4826 * mad;
	let mean = med.exp();
	Some(Fit { n: logs.len(), mean, sd: 0.02f64.max(mean * spread / (logs.len() as f64).sqrt()), spread })
}

/// `[id] = xp` pairs inside `FOREVER_QUEST_XP_FALLBACK = { ... }` (calibrate.js parseForeverXp),
/// in file order.
pub fn parse_forever_xp(text: &str) -> Vec<(u32, f64)> {
	let Some(start) = text.find("FOREVER_QUEST_XP_FALLBACK") else { return Vec::new() };
	let rest = &text[start + "FOREVER_QUEST_XP_FALLBACK".len()..];
	let rest = rest.trim_start();
	let Some(rest) = rest.strip_prefix('=') else { return Vec::new() };
	let rest = rest.trim_start();
	let Some(body) = rest.strip_prefix('{') else { return Vec::new() };
	let Some(end) = body.find("\n}") else { return Vec::new() };
	let body = &body[..end];
	let mut out: Vec<(u32, f64)> = Vec::new();
	let b = body.as_bytes();
	let mut i = 0;
	while let Some(o) = body[i..].find('[') {
		let s = i + o + 1;
		let mut j = s;
		while j < b.len() && b[j].is_ascii_digit() {
			j += 1;
		}
		i = s;
		if j == s || j >= b.len() || b[j] != b']' {
			continue;
		}
		let mut k = j + 1;
		while k < b.len() && b[k].is_ascii_whitespace() {
			k += 1;
		}
		if k >= b.len() || b[k] != b'=' {
			continue;
		}
		k += 1;
		while k < b.len() && b[k].is_ascii_whitespace() {
			k += 1;
		}
		let d0 = k;
		while k < b.len() && b[k].is_ascii_digit() {
			k += 1;
		}
		if k == d0 {
			continue;
		}
		let id: u32 = body[s..j].parse().unwrap_or(0);
		let xp: f64 = body[d0..k].parse().unwrap_or(0.0);
		// A Map: a later duplicate replaces the value in place.
		match out.iter_mut().find(|(q, _)| *q == id) {
			Some(e) => e.1 = xp,
			None => out.push((id, xp)),
		}
		i = k;
	}
	out
}

struct Quest {
	id: u32,
	level: f64,
	xp: Option<f64>,
	tier: usize,
}

/// calibrate.js `tableEstimate`: `rows[max(1, min(len - 1, level))] || rows[60]`, then the tier's
/// value or 0 (a NaN or fractional level reads rows[60], as the JS index does).
fn table_estimate(rows: &[Value], q: &Quest) -> f64 {
	let idx = if q.level.is_nan() { f64::NAN } else { q.level.min((rows.len() - 1) as f64).max(1.0) };
	let row = if idx.fract() == 0.0 { rows.get(idx as usize).filter(|r| r.is_array()) } else { None }.or_else(|| rows.get(60));
	row.and_then(|r| r.get(q.tier)).and_then(Value::as_f64).filter(|v| *v != 0.0).unwrap_or(0.0)
}

/// calibrate.js `recordingFits`.
pub struct RecFit {
	pub sessions: usize,
	pub levels: usize,
	pub kill: Option<(f64, f64)>,
}

pub fn recording_fits(dir: &Path) -> RecFit {
	let Ok(rd) = std::fs::read_dir(dir) else { return RecFit { sessions: 0, levels: 0, kill: None } };
	// readdirSync's order (the OS's); the fit does not depend on it.
	let mut files: Vec<PathBuf> = rd.flatten().map(|e| e.path()).filter(|p| p.to_string_lossy().ends_with(".json")).collect();
	files.sort();
	let mut by_level: Vec<(f64, Vec<f64>)> = Vec::new();
	let mut sessions = 0;
	for f in files {
		let Some(doc) = std::fs::read(&f).ok().and_then(|b| serde_json::from_slice::<Value>(&b).ok()) else { continue };
		let Some(events) = doc.get("events").and_then(Value::as_array) else { continue };
		sessions += 1;
		let mut lvl: Option<f64> = None;
		let mut last: Option<f64> = None;
		for e in events {
			if let Some(l) = e.get("lvl").and_then(Value::as_f64).filter(|l| *l != 0.0) {
				lvl = Some(l);
			}
			if e.get("e").and_then(Value::as_str) == Some("level") {
				lvl = e.get("lvl").and_then(Value::as_f64);
			}
			if e.get("e").and_then(Value::as_str) == Some("kill") {
				if let Some(l) = lvl.filter(|l| *l != 0.0) {
					let t = e.get("t").and_then(Value::as_f64).unwrap_or(f64::NAN);
					if let Some(lk) = last {
						if t - lk > 2.0 && t - lk <= 180.0 {
							match by_level.iter_mut().find(|(x, _)| *x == l) {
								Some(g) => g.1.push(t - lk),
								None => by_level.push((l, vec![t - lk])),
							}
						}
					}
					last = Some(t);
				}
			}
		}
	}
	let pts: Vec<(f64, f64, f64)> = by_level.iter().filter(|(_, g)| g.len() >= 10).map(|(l, g)| (*l, median(g), g.len() as f64)).collect();
	if pts.len() < 2 {
		return RecFit { sessions, levels: pts.len(), kill: None };
	}
	let (mut sw, mut sx, mut sy, mut sxx, mut sxy) = (0.0, 0.0, 0.0, 0.0, 0.0);
	for &(l, s, n) in &pts {
		let x = l - 1.0;
		sw += n;
		sx += n * x;
		sy += n * s;
		sxx += n * x * x;
		sxy += n * x * s;
	}
	let b = (sw * sxy - sx * sy) / (sw * sxx - sx * sx);
	let a = (sy - b * sx) / sw;
	RecFit { sessions, levels: pts.len(), kill: Some((a, a + 59.0 * b)) }
}

pub struct Calibrated {
	/// params.json's text.
	pub text: String,
	pub est: Option<Fit>,
	pub forever: Option<Fit>,
	pub forever_total: usize,
	pub sessions: usize,
}

/// The calibration from the two worlds (`world-horde.json`, `world-alliance.json` in
/// `world_dir`), the dungeon journal's observed rewards (`fdj`: its folder, None: none) and the
/// recordings folder. `at`: the fit's timestamp (ISO).
pub fn calibrate(world_dir: &Path, fdj: Option<&Path>, recordings: &Path, at: &str) -> Result<Calibrated, String> {
	let mut quests: Vec<Quest> = Vec::new();
	let mut rows: Vec<Value> = Vec::new();
	for f in ["horde", "alliance"] {
		let file = world_dir.join(format!("world-{f}.json"));
		let w: Value = serde_json::from_slice(&std::fs::read(&file).map_err(|e| format!("{}: {e}", file.display()))?).map_err(|e| format!("{}: {e}", file.display()))?;
		if rows.is_empty() {
			rows = w.get("questXp").and_then(Value::as_array).cloned().unwrap_or_default();
		}
		for q in w.get("quests").and_then(Value::as_array).into_iter().flatten() {
			let id = q.get("id").and_then(Value::as_u64).unwrap_or(0) as u32;
			if quests.iter().any(|x| x.id == id) {
				continue;
			}
			quests.push(Quest {
				id,
				level: q.get("level").and_then(Value::as_f64).unwrap_or(f64::NAN),
				xp: q.get("xp").and_then(Value::as_f64),
				tier: q.get("tier").and_then(Value::as_u64).unwrap_or(0) as usize,
			});
		}
	}
	if rows.is_empty() {
		return Err("the worlds have no questXp table".into());
	}
	let by_id: rustc_hash::FxHashMap<u32, usize> = quests.iter().enumerate().map(|(i, q)| (q.id, i)).collect();
	let est_ratios: Vec<f64> = quests.iter().filter(|q| q.xp.is_some_and(|x| x > 0.0)).map(|q| q.xp.unwrap() / table_estimate(&rows, q)).collect();
	let est = ratio_fit(&est_ratios);
	let est_scale = est.map_or(1.0, |f| f.mean);
	let (fx_file, fx) = match fdj {
		Some(d) => {
			let file = d.join("Data").join("QuestRewards.lua");
			let xp = std::fs::read_to_string(&file).map(|t| parse_forever_xp(&t)).unwrap_or_default();
			// The journal's folder name and the file in it, not the maintainer's install path.
			let name = d.file_name().map_or_else(|| "ForeverDungeonJournal".into(), |n| n.to_string_lossy().into_owned());
			(V::from(format!("{name}/Data/QuestRewards.lua")), xp)
		}
		None => (V::Null, Vec::new()),
	};
	let mut fv = Vec::new();
	let mut matched = 0usize;
	for &(id, xp) in &fx {
		let Some(&i) = by_id.get(&id) else { continue };
		let q = &quests[i];
		let base = if q.xp.is_some_and(|x| x > 0.0) { q.xp.unwrap() } else { table_estimate(&rows, q) * est_scale };
		if base > 0.0 {
			fv.push(xp / base);
			matched += 1;
		}
	}
	let forever = ratio_fit(&fv);
	let rec = recording_fits(recordings);

	let calibrated = Obj::new();
	let ms = |mean: f64, sd: f64| {
		let o = Obj::new();
		o.set("mean", mean);
		o.set("sd", sd);
		V::Obj(o)
	};
	if let Some(f) = est {
		calibrated.set("questEstScale", ms(f.mean, f.sd.max(0.03)));
	}
	if let Some(f) = forever {
		calibrated.set("questXpScale", ms(f.mean, f.sd.max(0.03)));
	}
	let prior_sd = |n: &str| PRIORS.iter().find(|p| p.0 == n).map_or(0.0, |p| p.2);
	if let Some((k1, k60)) = rec.kill.filter(|(a, b)| *a > 0.0 && *b > 0.0) {
		calibrated.set("killSec1", ms(k1, prior_sd("killSec1") / 2.0));
		calibrated.set("killSec60", ms(k60, prior_sd("killSec60") / 2.0));
	}
	let fit = Obj::new();
	fit.set("at", at);
	let sources = Obj::new();
	let qx = Obj::new();
	qx.set("questsJsonXp", est.map_or(0.0, |f| f.n as f64));
	let fo = Obj::new();
	fo.set("file", fx_file);
	fo.set("values", fx.len() as f64);
	fo.set("matched", matched as f64);
	qx.set("forever", fo);
	sources.set("questXp", qx);
	fit.set("sources", sources.clone());
	let fq = Obj::new();
	fq.set("est", opt(&est));
	fq.set("forever", opt(&forever));
	fit.set("questXp", fq);
	let rs = Obj::new();
	rs.set("sessions", rec.sessions as f64);
	rs.set("levels", rec.levels as f64);
	sources.set("recordings", rs);

	let priors = Obj::new();
	for &(n, mean, sd, lo, hi, desc) in PRIORS {
		let o = Obj::new();
		o.set("mean", mean);
		o.set("sd", sd);
		o.set("lo", lo);
		o.set("hi", hi);
		o.set("desc", desc);
		priors.set(n, o);
	}
	let doc = Obj::new();
	doc.set("schema", 1.0);
	doc.set("priors", priors);
	doc.set("calibrated", calibrated);
	doc.set("fit", fit);
	Ok(Calibrated { text: format!("{}\n", stringify(&V::Obj(doc), Some("\t"))), est, forever, forever_total: fx.len(), sessions: rec.sessions })
}
