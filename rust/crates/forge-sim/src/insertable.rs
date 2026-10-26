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
		let inst: FxHashMap<u32, &'static str> = data.quest_areas.as_ref().map(|a| a.areas.clone()).unwrap_or_default();
		let verdict = (0..run.n_quests())
			.map(|qi| {
				let id = run.q_id[qi];
				let wq = &world.quests[rules.open[&id]];
				let Some(d) = data.quests.get(&id) else { return Err("not in quests.json".into()) };
				if let Some(n) = never.iter().find(|n| n["q"].as_u64() == Some(u64::from(id))) {
					return Err(format!("never offered ({})", n["why"].as_str().unwrap_or("")));
				}
				if let Some(why) = doubtful.get(&id) {
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
