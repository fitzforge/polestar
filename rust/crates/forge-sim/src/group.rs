//! Elite and group quests the routes take (Fitz, 2026-10-29: where their XP beats grinding the same
//! minutes, while no solo player is stranded).
//!
//! A family is an elite quest (the root: the quest the player's group answer is about, the
//! guide's `when group <root>`) and the quests that need it (the character's group set,
//! forge_world::Rules::is_group). Its size is the group it wants, from Forever's creature data:
//! the root's elite kill work (how many elites, how far over the quest's level, their rank), or
//! a `group` record in data/route-fixes.json (`deliberate.group`: `{q, size, why}`) that says
//! better. Size 1 is an elite most classes solo at about its level + 2; 2 and up a group of that
//! many; a boss (rank 3) or a record's size of REFUSE_SIZE is never taken.
//!
//! The planner takes a family's quests like any other, at the elite kill time (eliteTime) and a
//! price for the group risk: GROUP_RISK (param `groupRisk`) seconds per player beyond the first
//! (size - 1), counted when the root is handed in (eval.rs `group_units`). The route then writes,
//! after each hand-in of the family, the level the route has there: in the group player's replay
//! a grind that does nothing, for a player who skips the family the grind that gives its XP back
//! (route::solo_fallback), so the level plan holds either way.

use forge_world::world::{WQuest, Work};
use forge_world::{GameData, Rules, World};
use rustc_hash::FxHashMap;

/// A family this size or bigger (a boss, a raid's worth) is never taken.
pub const REFUSE_SIZE: u8 = 5;
/// Quest types (quests.json `web.type`, the server's QuestInfoID) of a dungeon's and a raid's
/// quests: never taken.
pub const DUNGEON_TYPE: f64 = 81.0;
pub const RAID_TYPE: f64 = 62.0;
/// Elite kills of a family past which it is a camp of elites, not one named elite.
pub const ONE_ELITE: f64 = 1.5;
pub const FEW_ELITES: f64 = 5.0;
/// Levels an elite may be over its quest's level before the family is never taken.
pub const FAR_OVER: f64 = 5.0;

/// One elite the family kills (summed over its tasks).
#[derive(Clone, Debug, PartialEq)]
pub struct Mob {
	pub npc: u32,
	pub name: String,
	pub level: f64,
	/// npcs.json `rank`: 1 elite, 2 rare elite, 3 boss.
	pub rank: u8,
	pub count: f64,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Family {
	/// The root quest's id.
	pub root: u32,
	pub title: String,
	/// The group it wants: 1 soloable elite, 2+ a group of that many.
	pub size: u8,
	/// The highest elite's level (the quest's own when no elite work is placed).
	pub level: f64,
	pub mobs: Vec<Mob>,
	/// Why this size, in plain words (the record's why, or the data's facts).
	pub why: String,
	/// The planner may take it (size under REFUSE_SIZE).
	pub take: bool,
}

/// The character's group families, by quest id.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Groups {
	/// Every group quest (and record root) -> its family's root.
	pub root_of: FxHashMap<u32, u32>,
	pub fams: FxHashMap<u32, Family>,
}

impl Groups {
	pub fn family(&self, q: u32) -> Option<&Family> {
		self.root_of.get(&q).and_then(|r| self.fams.get(r))
	}

	/// The planner may take quest q as part of its family.
	pub fn takes(&self, q: u32) -> bool {
		self.family(q).is_some_and(|f| f.take)
	}

	/// The group risk of handing in q: size - 1 for a taken family's root, else 0.
	pub fn units(&self, q: u32) -> f64 {
		self.fams.get(&q).filter(|f| f.take).map_or(0.0, |f| f64::from(f.size.saturating_sub(1)))
	}
}

/// The size a family's elites want, and why. `mobs` empty: the quest is elite but its elite work is
/// not placed (a start-item dropper, an item's only source): a group of 2.
pub fn size_of(mobs: &[Mob], quest_level: f64) -> (u8, String) {
	if mobs.is_empty() {
		return (2, "elite work the data does not place (an item's dropper): a group of 2 advised".into());
	}
	let kills: f64 = mobs.iter().map(|m| m.count).sum();
	let top = mobs.iter().map(|m| m.level).fold(f64::MIN, f64::max);
	let rank = mobs.iter().map(|m| m.rank).max().unwrap_or(1);
	let over = top - quest_level;
	let named = mobs
		.iter()
		.map(|m| {
			format!(
				"{} (level {}{})",
				m.name,
				m.level,
				match m.rank {
					3 => " boss",
					2 => " rare elite",
					_ => " elite",
				}
			)
		})
		.collect::<Vec<_>>()
		.join(", ");
	if rank >= 3 {
		return (REFUSE_SIZE, format!("{named}: a boss"));
	}
	// (Teremus the Devourer, a level 60 rare elite dragon, for To Serve Kum'isha at 55: not a group
	// quest a leveling route counts on.)
	if over >= FAR_OVER {
		return (REFUSE_SIZE, format!("{named}: {over} levels over the quest's level {quest_level}"));
	}
	let mut size: u8 = if kills <= ONE_ELITE {
		if over <= 0.0 {
			1
		} else if over <= 2.0 {
			2
		} else {
			3
		}
	} else if kills <= FEW_ELITES {
		if over <= 0.0 {
			2
		} else {
			3
		}
	} else if over <= 0.0 {
		3
	} else {
		4
	};
	if rank == 2 {
		size = (size + 1).min(REFUSE_SIZE);
	}
	let what = if kills <= ONE_ELITE { "one elite".to_string() } else { format!("{} elite kills", kills.round()) };
	let lvl = if over > 0.0 { format!(", {over} over the quest's level {quest_level}") } else { format!(", at or under the quest's level {quest_level}") };
	(size, format!("{named}: {what}{lvl}"))
}

/// The `group` records of the route fixes (`deliberate.group`): quest -> (size, why).
pub fn records() -> FxHashMap<u32, (u8, String)> {
	let fixes = crate::fixes::get();
	fixes["deliberate"]["group"]
		.as_array()
		.into_iter()
		.flatten()
		.filter_map(|r| {
			let q = u32::try_from(r["q"].as_u64()?).ok()?;
			let size = u8::try_from(r["size"].as_u64()?).ok()?;
			Some((q, (size, r["why"].as_str().unwrap_or("").to_string())))
		})
		.collect()
}

/// The elites a world quest kills (its kill work on elite npcs), summed per npc.
pub fn mobs_of(world_quest: &WQuest, data: &GameData) -> Vec<Mob> {
	let mut out: Vec<Mob> = Vec::new();
	for t in &world_quest.tasks {
		for w in &t.work {
			let Work::Kill { level, count, elite: true, npc, .. } = *w else { continue };
			if let Some(m) = out.iter_mut().find(|m| m.npc == npc) {
				m.count += count;
				m.level = m.level.max(level);
				continue;
			}
			let e = data.npcs.get(&npc);
			let rank = e.and_then(|e| e.rank).filter(|r| (1.0..=3.0).contains(r)).map_or(1, |r| r as u8);
			out.push(Mob { npc, name: e.and_then(|e| e.name.clone()).unwrap_or_else(|| format!("npc {npc}")), level, rank, count });
		}
	}
	out
}

/// The character's group families: every quest of its group set, and every `group` record's
/// quest in its set.
pub fn families(world: &World, rules: &Rules, data: &GameData) -> Groups {
	let recs = records();
	let mut g = Groups::default();
	let wq = |id: u32| rules.open.get(&id).map(|&i| &world.quests[i]);
	// Roots: elite quests and the records' quests.
	for (&id, &i) in &rules.open {
		let q = &world.quests[i];
		let rec = recs.get(&id);
		if !(rules.is_group(id) && q.elite) && rec.is_none() {
			continue;
		}
		let mobs = mobs_of(q, data);
		// (A dungeon's or raid's quest whose giver stands outside is still one by the server's type:
		// Deviate Hides' stalkers are in the Wailing Caverns. Never taken, whatever a record says.)
		let instance = data.quests.get(&id).and_then(|d| d.web.as_ref()).and_then(|w| w.kind).filter(|k| *k == DUNGEON_TYPE || *k == RAID_TYPE);
		let (size, why) = match (instance, rec) {
			(Some(k), _) => (REFUSE_SIZE, format!("the server files it a {} quest", if k == RAID_TYPE { "raid" } else { "dungeon" })),
			(None, Some((s, w))) => (*s, w.clone()),
			(None, None) => size_of(&mobs, q.level),
		};
		let level = mobs.iter().map(|m| m.level).fold(q.level, f64::max);
		g.root_of.insert(id, id);
		g.fams.insert(id, Family { root: id, title: q.title.clone(), size, level, mobs, why, take: size < REFUSE_SIZE });
	}
	// The quests that need one: the family of the first group quest they need (prerequisite, all
	// prerequisites, the log parent, an after-quest), to a fixed point.
	let mut changed = true;
	while changed {
		changed = false;
		for &id in rules.open.keys() {
			if g.root_of.contains_key(&id) || !rules.is_group(id) {
				continue;
			}
			let Some(q) = wq(id) else { continue };
			let needs = q.pre.iter().chain(&q.pre_all).chain(q.in_log.iter()).filter_map(|&p| u32::try_from(p).ok()).chain(q.after.iter().flatten().copied());
			if let Some(r) = needs.filter_map(|p| g.root_of.get(&p).copied()).next() {
				g.root_of.insert(id, r);
				changed = true;
			}
		}
	}
	g
}

/// One solo fallback: after order step `after` (a hand-in of the family of `root`), a player who
/// skipped the family grinds to `level` + `xp` into it: where the group player is there.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Fallback {
	pub root: u32,
	pub after: usize,
	pub level: u32,
	pub xp: i32,
}

/// The family root (quest id) of order step s, when its quest is in a family the route takes.
fn root_of_step(run: &crate::Run, s: &crate::Step) -> Option<u32> {
	if !matches!(s.kind, crate::run::K_ACCEPT | crate::run::K_TASK | crate::run::K_TURNIN) || !run.group(s.q as usize) {
		return None;
	}
	run.groups.as_ref()?.root_of.get(&run.q_id[s.q as usize]).copied()
}

/// The solo fallbacks of an order: after each hand-in of a taken family, the level the replay has
/// there; of hand-ins with only group work between them (any family's), the last.
pub fn fallbacks(ev: &mut crate::Evaluator, o: &crate::order::Order) -> Vec<Fallback> {
	let run = ev.run;
	let roots: Vec<Option<u32>> = o.steps.iter().map(|s| root_of_step(run, s)).collect();
	let mut out: Vec<Fallback> = Vec::new();
	ev.reset();
	for i in 0..o.len() {
		ev.step_in(&o.steps, i);
		let Some(root) = roots[i].filter(|_| o.steps[i].kind == crate::run::K_TURNIN) else { continue };
		let f = Fallback { root, after: i, level: ev.s.level as u32, xp: ev.s.xp.floor() as i32 };
		// The previous fallback with only group work since: this one covers it (one grind).
		if let Some(last) = out.last() {
			if last.root == root && roots[last.after + 1..i].iter().all(Option::is_some) {
				out.pop();
			}
		}
		out.push(f);
	}
	out
}

/// The order a player who skips every taken family plays: the families' steps out, a grind to the
/// fallback's level where each fallback is.
pub fn solo_order(run: &crate::Run, o: &crate::order::Order, fb: &[Fallback]) -> crate::order::Order {
	let mut out = crate::order::Order { steps: Vec::new(), origin: Vec::new() };
	for (i, s) in o.steps.iter().enumerate() {
		if root_of_step(run, s).is_none() {
			out.steps.push(*s);
			out.origin.push(o.origin.get(i).copied().unwrap_or(crate::order::INSERTED));
		}
		for f in fb.iter().filter(|f| f.after == i) {
			out.steps.push(crate::Step::grind(f.level, f.xp));
			out.origin.push(crate::order::INSERTED);
		}
	}
	out
}

/// The route file's group facts for order `o` (route::finish): `list`, the families the order
/// takes; `soloFallback`, where a solo player grinds their XP back (`after`: the order index,
/// `target`: the level, `min`: the minutes ground there); `solo`, the hours of the solo player's
/// replay (route::summary). Null when the order takes no family.
pub fn report(ev: &mut crate::Evaluator, o: &crate::order::Order) -> serde_json::Value {
	use serde_json::json;
	let run = ev.run;
	let Some(g) = run.groups.clone() else { return serde_json::Value::Null };
	let mut taken: Vec<(u32, Vec<u32>)> = Vec::new();
	for s in &o.steps {
		let Some(root) = root_of_step(run, s) else { continue };
		let id = run.q_id[s.q as usize];
		match taken.iter_mut().find(|t| t.0 == root) {
			Some(t) if !t.1.contains(&id) => t.1.push(id),
			Some(_) => {}
			None => taken.push((root, vec![id])),
		}
	}
	if taken.is_empty() {
		return serde_json::Value::Null;
	}
	let list: Vec<serde_json::Value> = taken
		.iter()
		.filter_map(|(root, qs)| {
			let f = g.fams.get(root)?;
			let mobs: Vec<serde_json::Value> = f.mobs.iter().map(|m| json!({ "npc": m.npc, "name": m.name, "level": m.level, "rank": m.rank, "count": (m.count * 10.0).round() / 10.0 })).collect();
			Some(json!({ "q": root, "title": f.title, "size": f.size, "level": f.level, "mobs": mobs, "quests": qs, "why": f.why }))
		})
		.collect();
	let fb = fallbacks(ev, o);
	let solo = solo_order(run, o, &fb);
	// The minutes each fallback grinds in the solo replay.
	let mut mins = vec![0.0f64; fb.len()];
	ev.reset();
	let mut k = 0;
	for i in 0..solo.len() {
		let g0 = ev.s.grind_sec;
		ev.step_in(&solo.steps, i);
		if solo.steps[i].kind == crate::run::K_GRIND && solo.origin[i] == crate::order::INSERTED && k < fb.len() {
			mins[k] = (ev.s.grind_sec - g0) / 60.0;
			k += 1;
		}
	}
	let lx = |l: u32, xp: i32| ((f64::from(l) + f64::from(xp.max(0)) / crate::xp::LEVEL_XP[(l as usize).min(59)].max(1.0)) * 100.0).round() / 100.0;
	let fallback: Vec<serde_json::Value> = fb.iter().zip(&mins).map(|(f, m)| json!({ "root": f.root, "after": f.after, "target": lx(f.level, f.xp), "min": (m * 10.0).round() / 10.0 })).collect();
	let hours = crate::route::summary(ev, &solo);
	json!({ "list": list, "soloFallback": fallback, "solo": hours })
}
