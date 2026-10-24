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
		} else if let Some((_, why)) = l.optional.iter().find(|x| x.0 == q) {
			("rare-drop", format!("optional in v1: {why}"), json!({ "issue": issue_of(why) }), "player report".into(), Vec::new())
		} else if in_v1(q) {
			let drop = l.edits["list"].as_array().into_iter().flatten().find(|e| e["kind"] == "drop" && e["q"].as_u64() == Some(u64::from(id)) && e["kept"] == json!(true));
			match drop {
				Some(e) => ("low-value", format!("dropped from v1: {}", e["text"].as_str().unwrap_or("")), json!({ "savedMin": e["savedMin"] }), "route model".into(), Vec::new()),
				None => ("dropped", "in v1's order, does nothing in the cut's replay (its chain or level is not open where v1 has it)".into(), Value::Null, "route model".into(), Vec::new()),
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
                "insert" => "a passed-by quest worth its detour",
                "pickup" => "a worthwhile passed-by quest picked up where it is passed (<= 2 min)",
                "drop" => "its trip costs more than its XP",
                "drop grind" => "a grind the route no longer needs",
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
		"insert" | "pickup" => json!({ "q": e["q"], "edit": "insert", "reason": "", "issue": "" }),
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
		_ => return json!({ "t": "train" }),
	};
	let task = if s.kind == K_TASK { json!(s.task as u32 - run.q_task0[s.q as usize]) } else { Value::Null };
	json!({ "t": t, "q": run.q_id[s.q as usize], "task": task })
}
