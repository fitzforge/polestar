//! The skip ledger and the edit ledger of a route cut, recomputed from the data every run
//! (never cached as decisions): a fix to the data or to route-fixes.json shows up in the
//! next cut.
//!
//! Skip ledger: one row per quest the start could do but the route does not take (passed by,
//! available but not taken, dropped from v1, left out of the world), with a reason code, the
//! numbers behind it, the deciding source by public name, and for missing-info rows what is
//! missing and which data file a fix goes into.
//!
//! Edit ledger: one row per edit the cut keeps against v1 (moved, folded, inserted, dropped,
//! picked up), with what moved where, the minutes it saved, and the guards it passed.

use crate::chain::Goal;
use crate::insertable::{Insertable, Missing};
use crate::order::{Order, Overrides};
use crate::run::{K_ACCEPT, K_GRIND, K_TASK, K_TURNIN};
use crate::search::passby::Passed;
use crate::Model;
use forge_world::{GameData, Rules, World};
use rustc_hash::FxHashMap;
use serde_json::{json, Value};

/// The guards every kept edit passed (search::Member::replay and the checker).
pub const GUARDS_PASSED: &str = "quest order and deliberate orders (player reports), feasibility (items, escorts, timers), judge returns and passed-by, split work, area visits, training gaps and shifts, feedback guards (grind after hand-ins, hearth cooldown, training on the way, no elite/rare camps), log <= 38, no added late turn-in";

/// What a cut's ledgers are made from.
pub struct LedgerIn<'a> {
	/// The walk store: a quest whose places the route cannot walk to is named so.
	pub walks: Option<&'a dyn crate::walks::Walks>,
	pub world: &'a World,
	/// The start's race (exclusions for other races are left out).
	pub race: &'a str,
	pub rules: &'a Rules,
	pub model: &'a Model,
	pub data: Option<&'a GameData>,
	/// v1's goals (the orders' origins).
	pub goals: &'a [Goal],
	/// v1's order before overrides, and the cut's order.
	pub v1: &'a Order,
	pub best: &'a Order,
	/// The level before each step of `best`.
	pub lv: &'a [f64],
	pub passed: &'a [Passed],
	/// Worthwhile quests the pickup pass tried and refused, with why.
	pub refused: &'a FxHashMap<u32, String>,
	pub ins: Option<&'a Insertable>,
	pub kb: Option<&'a FxHashMap<u32, Vec<Missing>>>,
	pub ovr: &'a Overrides,
	/// edits_json's document (its `list`).
	pub edits: &'a Value,
	/// route-fixes.json `optional` quests (run indices) with why.
	pub optional: &'a [(u32, String)],
	/// Quests the route took and could not hand in before 60, left out (route::drop_unfinished).
	pub unfinished: &'a [u32],
}

fn guide_of(goals: &[Goal], order: &Order, k: usize) -> String {
	(0..=k.min(order.len().saturating_sub(1))).rev().find_map(|j| (order.origin[j] >= 0).then(|| goals.get(order.origin[j] as usize).map(|g| g.guide.clone()))).flatten().unwrap_or_default()
}

/// Where a run quest would fit: the guide of the order's stop nearest its giver.
fn fit(l: &LedgerIn, q: u32) -> (String, Option<usize>) {
	let run = &l.model.run;
	let g = run.q_giver[q as usize];
	let near = (0..l.best.len())
		.filter(|&k| l.best.steps[k].kind != K_GRIND && run.straight(l.best.steps[k].pt, g).is_finite())
		.min_by(|&a, &b| run.straight(l.best.steps[a].pt, g).total_cmp(&run.straight(l.best.steps[b].pt, g)));
	match near {
		Some(k) => (guide_of(l.goals, l.best, k), Some(k)),
		None => (l.world.zones.get(&run.p_map[g as usize]).cloned().unwrap_or_default(), None),
	}
}

/// The first of a quest's places (giver, work, turn-in) the walk store cannot reach from the route's
/// nearest stop on its continent, by name.
fn unwalkable(l: &LedgerIn, q: u32) -> Option<&'static str> {
	let walks = l.walks?;
	let run = &l.model.run;
	let qi = q as usize;
	let mut places: Vec<(&'static str, u32)> = vec![("quest giver", run.q_giver[qi])];
	for t in run.q_task0[qi]..run.q_task1[qi] {
		places.push(("work place", run.task_pt[t as usize]));
	}
	places.push(("turn-in", run.q_ender[qi]));
	places
		.into_iter()
		.find(|&(_, p)| {
			let near = l
				.best
				.steps
				.iter()
				.filter(|s| s.kind != crate::run::K_GRIND && s.pt != p)
				.map(|s| s.pt)
				.filter(|&s| run.straight(s, p).is_finite())
				.min_by(|&a, &b| run.straight(a, p).total_cmp(&run.straight(b, p)));
			near.is_some_and(|s| walks.yards(s, p).is_some_and(|y| y.is_infinite()))
		})
		.map(|(what, _)| what)
}

/// An insertable verdict's reason as (code, missing info).
fn verdict_code(why: &str, kb: Option<&Vec<Missing>>) -> (&'static str, Vec<Missing>) {
	let w = why.to_lowercase();
	let item_fix = |what: String| Missing { what, fix: "data corrections (forever-db/corrections/items.json: drops or vendors)".into(), source: "game data".into() };
	if w.starts_with("uncertain in the kb") || w.contains("not in quests.json") {
		("missing-info", kb.cloned().unwrap_or_else(|| vec![Missing { what: why.to_string(), fix: "data corrections (forever-db/corrections)".into(), source: "game data".into() }]))
	} else if w.contains("no known source") {
		("missing-info", vec![item_fix(why.to_string())])
	} else if w.starts_with("never offered") {
		("player-report", Vec::new())
	} else if w.contains("group work") || w.contains("dungeon") || w.contains("raid") || w.contains("elite") {
		("elite/group", Vec::new())
	} else if w.contains("pvp") || w.contains("event") || w.contains("profession") || w.contains("reputation") {
		("pvp/event/profession/rep", Vec::new())
	} else if w.contains("repeatable") || w.contains("no reward") || w.contains("no recorded xp") || w.contains("trade-goods") {
		("low-value", Vec::new())
	} else if w.contains("drop") || w.contains("start") {
		("rare-drop", Vec::new())
	} else {
		("other", Vec::new())
	}
}

/// A world exclusion code as (reason code, missing info).
fn excluded_code(code: &str, reason: &str) -> Option<(&'static str, Vec<Missing>)> {
	let spawn_fix = "data corrections (forever-db/corrections/npcs.json or objects.json: set spawns)";
	let m = |what: &str, fix: &str| vec![Missing { what: what.to_string(), fix: fix.to_string(), source: "game data".into() }];
	Some(match code {
		"faction" | "unused" => return None,
		"no-giver" => ("missing-info", m("quest giver's place unknown", spawn_fix)),
		"no-ender" => ("missing-info", m("turn-in NPC's place unknown", spawn_fix)),
		"unplaceable" => ("missing-info", m(&format!("objective place unknown ({reason})"), spawn_fix)),
		"unsourced-item" => ("missing-info", m(&format!("item source unknown ({reason})"), "data corrections (forever-db/corrections/items.json: drops or vendors)")),
		"rare-drop" => ("rare-drop", Vec::new()),
		"dungeon" | "outside" | "listed" => ("elite/group", Vec::new()),
		"endgame" => ("level", Vec::new()),
		"repeatable" => ("low-value", Vec::new()),
		_ => ("pvp/event/profession/rep", Vec::new()),
	})
}

/// The passed-by classification's reason as a code.
fn passed_code(v: &Passed) -> &'static str {
	let r = v.reason.as_str();
	if v.worthwhile {
		"judge-refused"
	} else if r.starts_with("chain not open") {
		"chain-not-open"
	} else if r.starts_with("grey") || r.starts_with("too ") || r.contains("level window") {
		"level"
	} else if r.starts_with("low XP") {
		"low-value"
	} else if r.contains("zone") || r.contains("off the route") {
		"zone-left"
	} else if r.contains("override skip") {
		"override"
	} else if r.contains("deliberate") {
		"player-report"
	} else {
		"other"
	}
}

fn issue_of(s: &str) -> String {
	let b = s.as_bytes();
	let mut out = Vec::new();
	let mut i = 0;
	while i < b.len() {
		if b[i] == b'#' {
			let j = (i + 1..b.len()).find(|&j| !b[j].is_ascii_digit()).unwrap_or(b.len());
			if j > i + 1 {
				out.push(s[i..j].to_string());
			}
			i = j;
		} else {
			i += 1;
		}
	}
	out.join(", ")
}

/// A quest whose giver the route stands near (within the passed-by radius) but never passes while
/// it is open: `level` when only out of its accept window (under its minimum level, too high above
/// the character, or grey), else `zone-left` with the levels where it stands there in the window.
/// The code, detail and numbers; None when the route never comes near the giver.
/// (c12: Wharfmaster Dizzywig and Goblin Sponsorship were `zone-left`, "never passes its giver",
/// while the route took other quests from Kravel Koalbeard at 29.9-30.5, 6-7 levels under them.)
fn passed_out_of_window(l: &LedgerIn, q: u32) -> Option<(&'static str, String, Value)> {
	let run = &l.model.run;
	let qi = q as usize;
	let g = run.q_giver[qi];
	let at: Vec<f64> = (0..l.best.len().min(l.lv.len())).filter(|&k| l.best.steps[k].kind != K_GRIND && run.straight(l.best.steps[k].pt, g) <= crate::guards::PB_RADIUS).map(|k| l.lv[k]).collect();
	if at.is_empty() {
		return None;
	}
	let (ql, min) = (f64::from(run.q_level[qi]), f64::from(run.q_min_level[qi]));
	let below = |lv: f64| lv < min || ql > lv.floor() + forge_world::rules::ACCEPT_ABOVE;
	let r1 = |x: f64| (x * 10.0).round() / 10.0;
	let open: Vec<f64> = at.iter().copied().filter(|&lv| !below(lv) && forge_world::rules::level_ok(ql, lv)).collect();
	if !open.is_empty() {
		// At the giver in its window, but never walked past while the quest is open (c13: The
		// Disgraced One at the Fallen Hero, 48.7, right after Fall From Grace, the route then
		// flying on): the chain opens there, or the route leaves by flight or hearth.
		let (lo, hi) = open.iter().fold((f64::INFINITY, f64::NEG_INFINITY), |(a, b), &x| (a.min(x), b.max(x)));
		let detail = format!("the route is at its giver (500 yd) at level {:.1}-{:.1}, in its level window, but never walks past it while the quest is open (the quest opens there, or the route leaves by flight or hearth); inserting it there did not save time", r1(lo), r1(hi));
		return Some(("zone-left", detail, json!({ "atGiverLevel": [r1(lo), r1(hi)] })));
	}
	let (lo, hi) = at.iter().fold((f64::INFINITY, f64::NEG_INFINITY), |(a, b), &x| (a.min(x), b.max(x)));
	let from = min.max(ql - forge_world::rules::ACCEPT_ABOVE);
	let detail = if at.iter().all(|&lv| below(lv)) {
		format!("passed only below its level window: the route is at its giver (500 yd) at level {:.1}-{:.1}, the quest (level {ql}) is taken from {from}", r1(lo), r1(hi))
	} else if at.iter().all(|&lv| !below(lv)) {
		format!("passed only where it is grey: the route is at its giver (500 yd) at level {:.1}-{:.1}, the quest is level {ql}", r1(lo), r1(hi))
	} else {
		format!("passed only out of its level window: the route is at its giver (500 yd) at level {:.1}-{:.1}, the quest (level {ql}) is taken from {from} and grey later", r1(lo), r1(hi))
	};
	Some(("level", detail, json!({ "passedAtLevel": [r1(lo), r1(hi)], "opensAtLevel": from })))
}

/// The skip ledger's rows.
pub fn skips(l: &LedgerIn) -> Vec<Value> {
	let run = &l.model.run;
	let in_best: Vec<bool> = {
		let mut v = vec![false; run.n_quests()];
		for s in &l.best.steps {
			if s.kind == K_ACCEPT {
				v[s.q as usize] = true;
			}
		}
		v
	};
	let in_v1 = |q: u32| l.v1.steps.iter().any(|s| s.kind == K_ACCEPT && s.q == q);
	let passed: FxHashMap<u32, &Passed> = l.passed.iter().map(|v| (v.q, v)).collect();
	let mut rows = Vec::new();
	let title = |id: u32| l.rules.open.get(&id).map(|&i| l.world.quests[i].title.clone()).unwrap_or_default();
	for q in 0..run.n_quests() as u32 {
		if in_best[q as usize] {
			continue;
		}
		let id = run.q_id[q as usize];
		let (guide, _) = fit(l, q);
		let kbm = l.kb.and_then(|k| k.get(&id));
		let mut row = json!({ "q": id, "title": title(id), "level": run.q_level[q as usize], "xp": l.model.tables.q_full[q as usize].round(), "guide": guide });
		let (code, detail, numbers, source, missing): (&str, String, Value, String, Vec<Missing>) = if let Some((why, issue)) = l.ovr.why.get(&id).filter(|_| l.ovr.skip.contains(&q)) {
			("override", why.clone(), json!({ "issue": issue }), "route-fixes.json".into(), Vec::new())
		} else if l.unfinished.contains(&q) {
			("level", "taken too late: its work and hand-in come only after level 60, so it is left out".into(), Value::Null, "route model".into(), Vec::new())
		} else if let Some((_, why)) = l.optional.iter().find(|x| x.0 == q) {
			("rare-drop", format!("optional in v1: {why}"), json!({ "issue": issue_of(why) }), "player report".into(), Vec::new())
		} else if in_v1(q) {
			let drop = l.edits["list"].as_array().into_iter().flatten().find(|e| e["kind"] == "drop" && e["q"].as_u64() == Some(u64::from(id)) && e["kept"] == json!(true));
			match drop {
				Some(e) => ("low-value", format!("dropped from v1: {}", e["text"].as_str().unwrap_or("")), json!({ "savedMin": e["savedMin"] }), "route model".into(), Vec::new()),
				None => match unwalkable(l, q) {
					Some(what) => {
						("not-walkable", format!("in v1's order, but its {what} cannot be walked to from the route (the walk store has no way there)"), Value::Null, "walk store".into(), Vec::new())
					}
					None => ("dropped", "in v1's order, does nothing in the cut's replay (its chain or level is not open where v1 has it)".into(), Value::Null, "route model".into(), Vec::new()),
				},
			}
		} else if let Some(why) = l.ins.filter(|i| !i.ok(q)).map(|i| i.why(q)) {
			let (c, m) = verdict_code(&why, kbm);
			let src = if c == "player-report" { "player report" } else { "game data" };
			(c, why.clone(), json!({ "issue": issue_of(&why) }), src.into(), m)
		} else if let Some(v) = passed.get(&q) {
			let c = passed_code(v);
			let detail = if c == "judge-refused" {
				format!(
					"worthwhile ({:.0} XP/min against the route's {:.0}) but the pickup was refused: {}",
					v.rate.min(99999.0),
					v.local,
					l.refused.get(&id).cloned().unwrap_or_else(|| "a guard or over the 2-minute allowance".into())
				)
			} else {
				v.reason.clone()
			};
			(
				c,
				detail,
				json!({ "passedAtLevel": (v.lvl * 10.0).round() / 10.0, "xp": v.xp.round(), "costMin": (v.cost_sec / 6.0).round() / 10.0, "xpPerMin": v.rate.min(99999.0).round(), "routeXpPerMin": v.local.round() }),
				"route model".into(),
				Vec::new(),
			)
		} else if run.q_pre[q as usize].iter().chain(&run.q_all[q as usize]).any(|&p| !in_best[p as usize]) && !run.q_pre[q as usize].is_empty() {
			("chain-not-open", "a quest before it is not in the route".into(), Value::Null, "game data".into(), Vec::new())
		} else if let Some((code, detail, numbers)) = passed_out_of_window(l, q) {
			(code, detail, numbers, "route model".into(), Vec::new())
		} else {
			("zone-left", "the route never passes its giver (500 yd) at a level that opens it".into(), Value::Null, "route model".into(), Vec::new())
		};
		let timer = run.q_limit.get(q as usize).copied().unwrap_or(0.0);
		row["reason"] = json!(code);
		row["detail"] = json!(detail);
		row["numbers"] = numbers;
		row["source"] = json!(source);
		if timer > 0.0 {
			row["timerMin"] = json!(timer / 60.0);
		}
		if !missing.is_empty() {
			row["missing"] = json!(missing);
		}
		rows.push(row);
	}
	// Quests of the world the character may take but whose chain is closed to it (a quest before
	// it left out of the world, or closed in turn): out of the run, so explained here (B2: Shared
	// Fury after Vengeful Trail, whose item drops only in an instance).
	{
		let f = l.world.faction;
		let rbit = forge_world::rules::race_bit(l.race, f);
		let skyborne = l.race == "Skyborne";
		let excluded: FxHashMap<u32, &str> = l.world.excluded.iter().map(|e| (e.id, e.reason.as_str())).collect();
		for wq in &l.world.quests {
			if l.rules.open.contains_key(&wq.id) || wq.dungeon.is_some() || !forge_world::rules::quest_open(wq, f, rbit, None) || (!skyborne && forge_world::rules::on_isle(l.world, wq)) {
				continue;
			}
			let before: Vec<String> = wq
				.pre
				.iter()
				.chain(&wq.pre_all)
				.chain(wq.in_log.iter())
				.copied()
				.chain(wq.after.iter().flatten().map(|&c| i64::from(c)))
				.filter_map(|p| u32::try_from(p).ok())
				.filter(|p| !l.rules.open.contains_key(p))
				.map(|p| match excluded.get(&p) {
					Some(why) => format!("{p} (left out of the world: {why})"),
					None => format!("{p} (closed to this character)"),
				})
				.collect();
			let detail = if before.is_empty() { "its chain is closed to this character".to_string() } else { format!("a quest before it is not open: {}", before.join(", ")) };
			let guide = l.world.points.get(wq.giver as usize).and_then(|p| l.world.zones.get(&p.map)).cloned().unwrap_or_default();
			rows.push(json!({ "q": wq.id, "title": wq.title, "level": wq.level, "guide": guide, "reason": "chain-not-open", "detail": detail, "numbers": Value::Null, "source": "game data" }));
		}
	}
	// Quests left out of the world for this faction (not race or faction locked, not unused).
	let zone_of = |id: u32| l.data.and_then(|d| d.quests.get(&id)).and_then(|q| q.zone).and_then(|z| l.world.zones.get(&(z as u32)).cloned()).unwrap_or_default();
	let level_of = |id: u32| l.data.and_then(|d| d.quests.get(&id)).and_then(|q| q.level).unwrap_or(0.0);
	for e in &l.world.excluded {
		let id = e.id;
		let rbit = forge_world::rules::race_bit(l.race, l.world.faction);
		let mask = l.data.and_then(|d| d.quests.get(&id)).and_then(|q| q.races).map_or(0, |r| r as u64);
		if mask != 0 && rbit != 0 && mask & rbit == 0 {
			continue;
		}
		let Some((code, mut missing)) = excluded_code(e.code, &e.reason) else { continue };
		if code == "missing-info" {
			if let Some(m) = l.kb.and_then(|k| k.get(&id)) {
				missing.extend(m.iter().cloned());
			}
		}
		let mut row = json!({ "q": id, "title": e.title, "level": level_of(id), "guide": zone_of(id), "reason": code, "detail": format!("left out of the world: {}", e.reason), "numbers": Value::Null, "source": "game data" });
		if !missing.is_empty() {
			row["missing"] = json!(missing);
		}
		rows.push(row);
	}
	rows
}

/// The edit ledger's rows: the kept edits (and pickups), each with the steps it moved, from
/// and to (index in the order before the edit), its reason, minutes saved and guards passed.
pub fn edit_rows(edits: &Value, ovr: &Overrides, run: &crate::run::Run) -> Vec<Value> {
	let _ = (ovr, run);
	edits["list"]
        .as_array()
        .into_iter()
        .flatten()
        .filter(|e| e["kept"] == json!(true))
        .map(|e| {
            let reason = match e["kind"].as_str().unwrap_or("") {
                "fold" | "fold later" => "folds a return into the other visit to the same place",
                "move" => "a cheaper place within the zone stay",
                "stay later" => "a zone entered nearer its quests' level, after the stays that come next: no grind before early work",
                "stay split" => "a later zone stay's quests far under the character there done earlier, on level, as their own visit",
                "gate later" => "a level gate ground just before the accept it gates: the hand-ins before it count first",
                "hub revisit" => "a hub visited again at the level its chains open: their quest XP removes grind",
                "insert" => "a passed-by quest worth its detour",
                "pickup" => "a worthwhile passed-by quest picked up where it is passed (<= 2 min)",
                "drop" => "its trip costs more than its XP",
                "drop grind" => "a grind that guards no gate, the quests around it give the XP",
                "chain insert" => "a quest with the quests it opens, worth their detour together",
                "zone block" => "a zone's open chains as one visit, at their level",
                "drop trip" => "a trip off the continent for quests well under the character",
                "stay on continent" => "on-level quests open on the continent: the trip off it for low quests taken out (<= 15 min)",
                "hub batch" => "a hub return (or a whole visit within a level of the next) folded into the next visit there",
                "hub batch undone" => "a hub batch the written guides' check found walked past, undone",
                "train at the hub" => "a training out of the field work it split, at the hub before or after it",
                "written check" => "done where the written guide's walk passes it ready (the check on the written guides)",
                "bag tie" => "carried in the bags: taken, done and handed in at once (a tie, <= 30 s)",
                "hub sweep" | "on the way" => "done where it is ready: the hub visit or the walk past its NPC",
                "hub loop" => "the hub's stops in the order of the shortest walk",
                "defer hard work" => "early hard work waits for its level: no long grind before it",
                "grind top-up" => "grind left in pieces at the zone stay's camps, at most 15 minutes each, never a silent wait",
                "free move" => "moved by the free search (the route reordered as a whole: its gain is the search's, not this move's)",
                _ => "",
            };
            json!({ "n": e["n"], "kind": e["kind"], "steps": e["steps"], "from": e["from"], "to": e["to"], "q": e["q"], "text": e["text"], "reason": reason, "savedMin": e["savedMin"], "guards": GUARDS_PASSED, "revert": revert_line(e) })
        })
        .collect()
}

/// The one-line route-fixes.json `revert` entry that undoes an edit.
fn revert_line(e: &Value) -> Value {
	match e["kind"].as_str().unwrap_or("") {
		"drop" => json!({ "q": e["q"], "edit": "drop", "reason": "", "issue": "" }),
		"insert" | "pickup" | "chain insert" | "zone block" | "hub revisit" => json!({ "q": e["q"], "edit": "insert", "reason": "", "issue": "" }),
		"drop trip" => json!({ "q": e["q"], "edit": "drop", "reason": "", "issue": "" }),
		_ => e["steps"].as_array().and_then(|s| s.iter().find(|x| !x["q"].is_null())).map_or(Value::Null, |s| json!({ "s": [s["t"], s["q"], s["task"]], "reason": "", "issue": "" })),
	}
}

/// The skip ledger as markdown: counts by reason, then the rows by reason.
pub fn skips_md(start: &str, rows: &[Value]) -> String {
	let mut by: std::collections::BTreeMap<String, Vec<&Value>> = Default::default();
	for r in rows {
		by.entry(r["reason"].as_str().unwrap_or("").to_string()).or_default().push(r);
	}
	let mut out = format!(
		"# {start}: quests the route does not take\n\nRecomputed every cut from the data and route-fixes.json. Reasons: {}.\n",
		by.iter().map(|(k, v)| format!("{k} {}", v.len())).collect::<Vec<_>>().join(", ")
	);
	for (k, v) in &by {
		out.push_str(&format!("\n## {k} ({})\n\n", v.len()));
		for r in v {
			out.push_str(&format!("- {} {} (L{}, {}): {}", r["q"], r["title"].as_str().unwrap_or(""), r["level"], r["guide"].as_str().unwrap_or(""), r["detail"].as_str().unwrap_or("")));
			if let Some(m) = r["missing"].as_array() {
				for x in m {
					out.push_str(&format!("; missing: {} (fix in {})", x["what"].as_str().unwrap_or(""), x["fix"].as_str().unwrap_or("")));
				}
			}
			out.push('\n');
		}
	}
	out
}

/// The edit ledger as markdown.
pub fn edits_md(start: &str, rows: &[Value]) -> String {
	let mut out = format!("# {start}: edits the cut makes to v1\n\nEach passed: {GUARDS_PASSED}. To undo one, add its `revert` line to route-fixes.json.\n\n");
	for r in rows {
		out.push_str(&format!(
			"{}. [{}] {}: {} ({} min saved). revert: {}\n",
			r["n"],
			r["kind"].as_str().unwrap_or(""),
			r["text"].as_str().unwrap_or(""),
			r["reason"].as_str().unwrap_or(""),
			r["savedMin"],
			r["revert"]
		));
	}
	out
}

/// `why`: where a quest is in a cut (its steps, the edits touching it) or its skip row.
pub fn why(q: u32, order: &Value, skips: &Value, edits: &Value) -> String {
	let steps: Vec<String> = order
		.as_array()
		.into_iter()
		.flatten()
		.enumerate()
		.filter(|(_, s)| s["q"].as_u64() == Some(u64::from(q)) && s["t"] != "level")
		.map(|(i, s)| format!("{i}: {} at L{} ({})", s["t"].as_str().unwrap_or(""), s["lvl"], s["from"].as_str().unwrap_or("")))
		.collect();
	let touching: Vec<String> = edits
		.as_array()
		.into_iter()
		.flatten()
		.filter(|e| e["q"].as_u64() == Some(u64::from(q)) || e["steps"].as_array().is_some_and(|s| s.iter().any(|x| x["q"].as_u64() == Some(u64::from(q)))))
		.map(|e| format!("edit {} [{}] {} ({} min saved); revert: {}", e["n"], e["kind"].as_str().unwrap_or(""), e["text"].as_str().unwrap_or(""), e["savedMin"], e["revert"]))
		.collect();
	if !steps.is_empty() {
		let mut s = format!("quest {q} is in the route:\n  {}\n", steps.join("\n  "));
		if touching.is_empty() {
			s.push_str("  where v1 has it (no edit moved it)\n");
		} else {
			s.push_str(&format!("  {}\n", touching.join("\n  ")));
		}
		return s;
	}
	if let Some(r) = skips.as_array().into_iter().flatten().find(|r| r["q"].as_u64() == Some(u64::from(q))) {
		let mut s = format!(
			"quest {q} {} is not in the route: {} ({})\n  {}\n  numbers: {}\n  source: {}\n",
			r["title"].as_str().unwrap_or(""),
			r["reason"].as_str().unwrap_or(""),
			r["guide"].as_str().unwrap_or(""),
			r["detail"].as_str().unwrap_or(""),
			r["numbers"],
			r["source"].as_str().unwrap_or("")
		);
		for m in r["missing"].as_array().into_iter().flatten() {
			s.push_str(&format!("  missing: {} -> fix in {}\n", m["what"].as_str().unwrap_or(""), m["fix"].as_str().unwrap_or("")));
		}
		if !touching.is_empty() {
			s.push_str(&format!("  {}\n", touching.join("\n  ")));
		}
		return s;
	}
	format!("quest {q} is not a quest this start can take (not in its world)\n")
}

/// The kept quest steps in a JSON form for the ledgers: {t, q (id), task (index in the quest)}.
pub fn step_json(run: &crate::run::Run, s: crate::Step) -> Value {
	let t = match s.kind {
		K_ACCEPT => "accept",
		K_TASK => "task",
		K_TURNIN => "turnin",
		K_GRIND => return json!({ "t": "grind", "level": s.q }),
		crate::run::K_RIDE => return json!({ "t": "ride", "npc": s.task }),
		_ => return json!({ "t": "train" }),
	};
	let task = if s.kind == K_TASK { json!(s.task as u32 - run.q_task0[s.q as usize]) } else { Value::Null };
	json!({ "t": t, "q": run.q_id[s.q as usize], "task": task })
}
