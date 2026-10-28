//! Which quests the search may add to v1's order: ones a solo player following the guide can
//! count on. The checklist (Factoruide's route-log skip reasons): solo (no elite work or a
//! quest needing one), not in a dungeon, raid or battleground, no holiday/event, no profession,
//! not repeatable, not reputation-gated, a recorded reward (an estimate gives token and reward
//! quests XP they don't give), objective items with a known source and no trade-goods turn-ins
//! (cloth donations), and, when an item starts it, an item that is
//! sold or drops at MIN_START_CHANCE or better (a rare beacon like OOX's is not something to
//! count on: v1 scores those as optional, docs/SIMULATION.md §5).

use crate::run::Run;
use forge_world::{GameData, Rules, World};
use rustc_hash::FxHashMap;

/// Percent: a quest-starting item dropping less often than this is a rare drop.
pub const MIN_START_CHANCE: f64 = 25.0;
/// Creature ranks of rare mobs (npcs.json `rank`: 4 rare, 2 rare elite): their drops do not count
/// toward a quest-starting item's chance.
pub const RARE_RANK: f64 = 4.0;
pub const RARE_ELITE_RANK: f64 = 2.0;
/// A non-quest item asked for this many times is a trade-goods turn-in (cloth donations).
pub const TRADE_GOOD_COUNT: f64 = 10.0;

/// Per run quest: Ok(why it may be added) or Err(why not).
pub struct Insertable {
	pub verdict: Vec<Result<String, String>>,
}

impl Insertable {
	pub fn ok(&self, q: u32) -> bool {
		self.verdict.get(q as usize).is_some_and(|v| v.is_ok())
	}
	pub fn why(&self, q: u32) -> String {
		match self.verdict.get(q as usize) {
			Some(Ok(s)) | Some(Err(s)) => s.clone(),
			None => String::new(),
		}
	}

	/// `doubtful`: quests whose facts the knowledge base is not sure of (KbDoubts), refused.
	pub fn new(world: &World, run: &Run, rules: &Rules, data: &GameData, q_full: &[f64], doubtful: &FxHashMap<u32, String>) -> Insertable {
		let fixes = crate::fixes::get();
		let doc = &fixes["deliberate"];
		let never = doc["never"].as_array().cloned().unwrap_or_default();
		let optional = doc["optional"].as_array().cloned().unwrap_or_default();
		let inst: FxHashMap<u32, &'static str> = data.quest_areas.as_ref().map(|a| a.areas.clone()).unwrap_or_default();
		let verdict = (0..run.n_quests())
			.map(|qi| {
				let id = run.q_id[qi];
				let wq = &world.quests[rules.open[&id]];
				let Some(d) = data.quests.get(&id) else { return Err("not in quests.json".into()) };
				if let Some(n) = never.iter().find(|n| n["q"].as_u64() == Some(u64::from(id))) {
					return Err(format!("never offered ({})", n["why"].as_str().unwrap_or("")));
				}
				// v1 marks it optional (a rare start the route does not count on): never added (The
				// Collector, c7 hybrid).
				if let Some(n) = optional.iter().find(|n| n["q"].as_u64() == Some(u64::from(id))) {
					return Err(format!("started by a rare drop (optional in v1: {})", n["why"].as_str().unwrap_or("")));
				}
				// (A delivery's one doubted objective is the letter the giver hands over: the quest's
				// source item, so nothing is in doubt. Letter to Jin'Zil, Apothecary Zamah.)
				if let Some(why) = doubtful.get(&id).filter(|why| !delivery_doubt(why, d)) {
					return Err(format!("uncertain in the KB: {why}"));
				}
				if !rules.solo_ok(id) {
					return Err("group work (elite, or needs an elite quest)".into());
				}
				if let Some(k) = d.area.filter(|a| a.fract() == 0.0 && *a >= 0.0).and_then(|a| inst.get(&(a as u32))) {
					return Err(match *k {
						"pvp" => "PvP (battleground) quest".to_string(),
						k => format!("{k} quest"),
					});
				}
				if d.event.is_some() {
					return Err(format!("holiday/event quest (event {})", d.event.unwrap_or(0.0)));
				}
				if d.skill.is_some() {
					return Err(format!("profession quest (skill {})", d.skill.unwrap_or(0.0)));
				}
				if d.repeatable == Some(true) {
					return Err("repeatable".into());
				}
				if !(q_full[qi] > 0.0) {
					return Err("no reward".into());
				}
				// The reward must be recorded: an estimate from the QuestXP table gives XP to
				// token and reward quests that give none (Legacy Reward, ticket turn-ins).
				if !d.xp.is_some_and(|x| x > 0.0) {
					return Err("no recorded XP".into());
				}
				if d.reputation.is_some() {
					return Err("reputation-gated".into());
				}
				for o in d.objectives.iter().flatten().filter(|o| o.kind == "item") {
					let Some(item) = o.id.and_then(|i| data.items.get(&(i as u32))) else { continue };
					let count = o.count.unwrap_or(1.0);
					let sold = item.vendors.as_ref().is_some_and(|v| !v.is_empty());
					let drops = item.drops.as_ref().is_some_and(|x| !x.npc.is_empty() || !x.object.is_empty());
					if !sold && !drops && !d.required_items.iter().any(|r| r.as_f64() == o.id) && d.source_item != o.id {
						return Err(format!("objective item {} has no known source", item.id));
					}
					if item.quest_item != Some(true) && count >= TRADE_GOOD_COUNT {
						return Err(format!("a trade-goods turn-in ({count} of item {})", item.id));
					}
				}
				let items: Vec<i64> = d.start.item.iter().copied().chain(d.source_item.filter(|_| wq.kind == "startItem").map(|x| x as i64)).collect();
				let given = if !d.start.npc.is_empty() {
					format!("given by {}", wq.g_name.clone().unwrap_or_else(|| format!("npc {}", d.start.npc[0])))
				} else if !d.start.object.is_empty() {
					format!("given by object {}", d.start.object[0])
				} else {
					String::new()
				};
				if !items.is_empty() && d.start.npc.is_empty() && d.start.object.is_empty() {
					let mut best = (0.0f64, String::new());
					for &it in &items {
						let Some(item) = u32::try_from(it).ok().and_then(|i| data.items.get(&i)) else { continue };
						if item.vendors.as_ref().is_some_and(|v| !v.is_empty()) {
							best = (100.0, format!("item {it} is sold"));
							break;
						}
						for (kind, map) in [("npc", item.drops.as_ref().map(|x| &x.npc)), ("object", item.drops.as_ref().map(|x| &x.object))] {
							for (src, ch) in map.into_iter().flatten() {
								// (A rare mob's drop is as rare as the mob: Gruff Swiftbite's 86 % of the
								// Gold Pickup Schedule, rank 4, a 90-minute respawn.)
								if kind == "npc" && data.npcs.get(src).and_then(|n| n.rank).is_some_and(|r| r == RARE_RANK || r == RARE_ELITE_RANK) {
									continue;
								}
								let c = ch.unwrap_or(0.0);
								if c > best.0 {
									best = (c, format!("item {it} drops {c} % from {kind} {src}"));
								}
							}
						}
					}
					if best.0 < MIN_START_CHANCE {
						return Err(format!("started by a rare drop (best {:.1} %)", best.0));
					}
					return Ok(format!("solo, level {}, started by {}", run.q_level[qi], best.1));
				}
				Ok(format!("solo, level {}, {given}", run.q_level[qi]))
			})
			.collect();
		Insertable { verdict }
	}
}

/// A KB objectives doubt that is no doubt about the quest's work: what the KB lists is the data's
/// objectives (a count the KB gives as `?` matches any; an object is `o:<id>`), once the quest's
/// own source item (the letter the giver hands over, which one source lists as an objective:
/// Letter to Jin'Zil; Target: Writhing Haunt; Tremors of the Earth) and `none` are left out, and an
/// escort or event the sources cannot give an id for (`x:?:1`, `e:?:?`: The Defias Brotherhood's
/// traitor, OOX, B5) stands for the data's event; and either that was the disagreement, or no
/// source disagrees (`1 of 1 sources agree`: medium only for want of a second source; Shards of
/// the Felvine, Sathrah's Sacrifice, the Bulwark keys B3, B4).
fn delivery_doubt(why: &str, d: &forge_world::data::Quest) -> bool {
	let Some(rest) = why.strip_prefix("objectives ") else { return false };
	let Some((value, tail)) = rest.split_once(" (") else { return false };
	// "medium confidence, 1 of 1 sources agree)"
	let agree = tail.split(", ").nth(1).map(|s| s.split_whitespace().collect::<Vec<_>>());
	let all_agree = agree.is_some_and(|w| w.len() >= 3 && w[1] == "of" && w[0] == w[2]);
	let provided = d.source_item.filter(|s| *s > 0.0 && s.fract() == 0.0).map(|s| format!("i:{}:1", s as u64));
	let event = |e: &str| e.starts_with("x:") || e.starts_with("e:");
	// (kind:id, count; None: any)
	let entry = |e: &str| -> (String, Option<u64>) {
		if event(e) {
			return ("event".into(), None);
		}
		match e.rsplit_once(':') {
			Some((k, c)) => (k.to_string(), c.parse().ok()),
			None => (e.to_string(), None),
		}
	};
	let mut left: Vec<(String, Option<u64>)> = value.split(';').filter(|e| Some(*e) != provided.as_deref() && *e != "none").map(entry).collect();
	let count = |c: Option<f64>| c.filter(|c| *c > 0.0).map(|c| c as u64);
	let mut have: Vec<(String, Option<u64>)> = d
		.objectives
		.iter()
		.flatten()
		.filter_map(|o| match o.kind.as_str() {
			"item" => Some((format!("i:{}", o.id? as u64), Some(count(o.count).unwrap_or(1)))),
			"kill" => Some((format!("c:{}", o.id? as u64), count(o.count))),
			"object" => Some((format!("o:{}", o.id? as u64), count(o.count))),
			"event" => Some(("event".into(), None)),
			_ => None,
		})
		.collect();
	let changed = left.len() < value.split(';').count() || left.iter().any(|e| e.0 == "event");
	// (No source listing the event at all: the data's events stand for it.)
	if left.is_empty() && !have.is_empty() && have.iter().all(|h| h.0 == "event") {
		return true;
	}
	left.sort_unstable();
	have.sort_unstable();
	let same = left.len() == have.len() && left.iter().zip(&have).all(|(a, b)| a.0 == b.0 && (a.1.is_none() || b.1.is_none() || a.1 == b.1));
	same && (changed || all_agree)
}

/// Quests the knowledge base is unsure of: objectives of low or medium confidence, or a
/// "verify in game" flag (data/local/kb/forever-kb.sqlite `facts`, `verify_in_game`). An added
/// quest must be certain; v1's own quests are kept whatever the KB says.
#[cfg(feature = "native")]
pub fn kb_doubts(kb: &std::path::Path) -> Result<FxHashMap<u32, String>, String> {
	let c = rusqlite::Connection::open_with_flags(kb, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(|e| format!("{}: {e}", kb.display()))?;
	let mut out: FxHashMap<u32, String> = FxHashMap::default();
	let mut st = c.prepare("select id, value, confidence, agree, total from facts where kind = 'quest' and field = 'objectives' and confidence in ('low', 'medium')").map_err(|e| e.to_string())?;
	let rows = st.query_map([], |r| Ok((r.get::<_, i64>(0)?, r.get::<_, String>(1)?, r.get::<_, String>(2)?, r.get::<_, i64>(3)?, r.get::<_, i64>(4)?))).map_err(|e| e.to_string())?;
	for (id, v, conf, a, t) in rows.flatten() {
		out.insert(id as u32, format!("objectives {v} ({conf} confidence, {a} of {t} sources agree)"));
	}
	let mut st = c.prepare("select id, conflicts from verify_in_game where kind = 'quest'").map_err(|e| e.to_string())?;
	let rows = st.query_map([], |r| Ok((r.get::<_, i64>(0)?, r.get::<_, String>(1)?))).map_err(|e| e.to_string())?;
	for (id, conflicts) in rows.flatten() {
		out.entry(id as u32).or_insert_with(|| format!("flagged verify in game ({})", conflicts.chars().take(120).collect::<String>()));
	}
	Ok(out)
}

/// What the knowledge base is missing or unsure of about a quest, and where a fix goes.
#[derive(Clone, Debug, serde::Serialize)]
pub struct Missing {
	pub what: String,
	/// The data file a fix goes into.
	pub fix: String,
	/// The deciding source, by public name (game data, server data, mechanics facts, player report).
	pub source: String,
}

/// A knowledge-base source by its public name.
pub fn public_source(s: &str) -> &'static str {
	let s = s.to_lowercase();
	if s.starts_with("server") || s.starts_with("tdb") || s.starts_with("foreverdb") || s.starts_with("forevervo") {
		"server data"
	} else if s.starts_with("player") {
		"player report"
	} else if s.starts_with("correction") {
		"data corrections"
	} else {
		"game data"
	}
}

/// Per quest id, what the knowledge base is missing or unsure of: quest facts at low or medium
/// confidence, sources that disagree (verify in game), and mechanics that drive the route at
/// less than high confidence. Read fresh every run: a fix to the data shows up in the next cut.
#[cfg(feature = "native")]
pub fn kb_missing(kb: &std::path::Path) -> Result<FxHashMap<u32, Vec<Missing>>, String> {
	let c = rusqlite::Connection::open_with_flags(kb, rusqlite::OpenFlags::SQLITE_OPEN_READ_ONLY).map_err(|e| format!("{}: {e}", kb.display()))?;
	let mut out: FxHashMap<u32, Vec<Missing>> = FxHashMap::default();
	let corr = |id: i64, f: &str| format!("data corrections (forever-db/corrections/quests.json: {id}.set.{f})");
	let mut st = c.prepare("select id, field, source, confidence, agree, total from facts where kind = 'quest' and confidence in ('low', 'medium')").map_err(|e| e.to_string())?;
	let rows =
		st.query_map([], |r| Ok((r.get::<_, i64>(0)?, r.get::<_, String>(1)?, r.get::<_, String>(2)?, r.get::<_, String>(3)?, r.get::<_, i64>(4)?, r.get::<_, i64>(5)?))).map_err(|e| e.to_string())?;
	for (id, field, src, conf, a, t) in rows.flatten() {
		let what = match field.as_str() {
			"objectives" => format!("objectives (targets, counts or items) uncertain: {a} of {t} sources agree, {conf} confidence"),
			"start" => format!("quest giver uncertain: {a} of {t} sources agree"),
			"end" => format!("turn-in NPC uncertain: {a} of {t} sources agree"),
			"races" | "classes" | "side" => format!("who can take it ({field}) uncertain: sources disagree ({a} of {t} agree)"),
			f => format!("{f} uncertain: {a} of {t} sources agree, {conf} confidence"),
		};
		out.entry(id as u32).or_default().push(Missing { what, fix: corr(id, &field), source: public_source(&src).into() });
	}
	let mut st = c.prepare("select id, conflicts from verify_in_game where kind = 'quest'").map_err(|e| e.to_string())?;
	let rows = st.query_map([], |r| Ok((r.get::<_, i64>(0)?, r.get::<_, String>(1)?))).map_err(|e| e.to_string())?;
	for (id, conflicts) in rows.flatten() {
		let fields: Vec<String> =
			serde_json::from_str::<serde_json::Value>(&conflicts).ok().and_then(|v| v.as_array().map(|a| a.iter().filter_map(|x| x["field"].as_str().map(String::from)).collect())).unwrap_or_default();
		out.entry(id as u32).or_default().push(Missing {
			what: format!("sources disagree on {}: to verify in game", if fields.is_empty() { "the quest".to_string() } else { fields.join(", ") }),
			fix: corr(id, fields.first().map_or("objectives", |s| s.as_str())),
			source: "game data".into(),
		});
	}
	let mut st = c.prepare("select quest, kind, confidence, sources from mechanics where drives = 1 and confidence != 'high'").map_err(|e| e.to_string())?;
	let rows = st.query_map([], |r| Ok((r.get::<_, i64>(0)?, r.get::<_, String>(1)?, r.get::<_, String>(2)?, r.get::<_, String>(3)?))).map_err(|e| e.to_string())?;
	for (id, kind, conf, srcs) in rows.flatten() {
		let first = serde_json::from_str::<Vec<String>>(&srcs).ok().and_then(|v| v.into_iter().next()).unwrap_or_default();
		out.entry(id as u32).or_default().push(Missing {
			what: format!("how the quest works ({kind}) is known only at {conf} confidence"),
			fix: "mechanics facts (the knowledge base's mechanics table, data/local/kb/merge-mechanics.js)".into(),
			source: if first.is_empty() { "mechanics facts".into() } else { public_source(&first).into() },
		});
	}
	Ok(out)
}

#[cfg(all(test, feature = "native"))]
mod tests {
	use super::delivery_doubt;

	fn quest(v: serde_json::Value) -> forge_world::data::Quest {
		serde_json::from_value(v).unwrap()
	}

	#[test]
	fn a_kb_doubt_no_source_disputes_is_no_doubt_when_it_lists_the_data_s_objectives() {
		// B4, B3, B5 (canon3 skips as missing-info): one source, and it lists what the data has.
		let felvine = quest(serde_json::json!({ "id": 5526, "sourceItem": 18539, "objectives": [{ "type": "item", "id": 18540, "count": 1 }] }));
		assert!(delivery_doubt("objectives i:18540:1 (medium confidence, 1 of 1 sources agree)", &felvine));
		let sathrah = quest(serde_json::json!({ "id": 2520, "objectives": [{ "type": "object", "id": 138498 }] }));
		assert!(delivery_doubt("objectives o:138498:? (medium confidence, 1 of 1 sources agree)", &sathrah));
		let plagues = quest(serde_json::json!({ "id": 6185, "objectives": [
			{ "type": "item", "id": 16003, "count": 1 }, { "type": "item", "id": 16001, "count": 1 }, { "type": "item", "id": 16002, "count": 1 },
			{ "type": "kill", "id": 11878 }, { "type": "event", "id": 2726 }] }));
		assert!(delivery_doubt("objectives i:16003:1;i:16001:1;i:16002:1;c:11878:?;e:2726:? (medium confidence, 1 of 1 sources agree)", &plagues));
		// Disputed by other sources, or not the data's objectives: still a doubt.
		assert!(!delivery_doubt("objectives i:18540:1 (medium confidence, 1 of 3 sources agree)", &felvine));
		assert!(!delivery_doubt("objectives i:18540:2 (medium confidence, 1 of 1 sources agree)", &felvine));
		assert!(!delivery_doubt("objectives i:18540:1;c:99:5 (medium confidence, 1 of 1 sources agree)", &felvine));
	}
}
