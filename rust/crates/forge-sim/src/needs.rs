//! Item dependencies: a step that needs an item comes after the step that gets it. An item
//! objective, a quest-starting item or a required item that no NPC or object drops and no vendor
//! sells comes from another quest's reward: that quest is handed in first (and kept).
//!
//! Rewards come from the Efficient Games quest scans (data/sources/eg-link, every client build,
//! `rewards.items`). Where they don't name the item (Thunder Applejack, the Applejack Still's
//! reward), the providing quest is taken by name: a quest of the same zone whose title shares a
//! word with the item's name and that v1's order hands in before the step.

use crate::chain::Goal;
use crate::order::{Need, Order};
use crate::run::{Run, K_ACCEPT, K_TASK, K_TURNIN};
use forge_world::{GameData, Rules, World};
use rustc_hash::FxHashMap;

/// Item id -> quests that reward it.
pub type Rewards = FxHashMap<u32, Vec<u32>>;

#[cfg(feature = "native")]
pub fn load_rewards(root: &std::path::Path) -> Rewards {
	let mut out: Rewards = FxHashMap::default();
	let base = root.join("data/sources/eg-link");
	let Ok(links) = std::fs::read_dir(&base) else { return out };
	let mut files = Vec::new();
	for l in links.flatten() {
		let Ok(builds) = std::fs::read_dir(l.path().join("wow_classic_beta")) else { continue };
		for b in builds.flatten() {
			let f = b.path().join("quests.enUS.json");
			if f.exists() {
				files.push(f);
			}
		}
	}
	files.sort();
	for f in files {
		let Ok(bytes) = std::fs::read(&f) else { continue };
		let Ok(doc) = serde_json::from_slice::<serde_json::Value>(&bytes) else { continue };
		for (k, v) in doc["quests"].as_object().into_iter().flatten() {
			let Ok(q) = k.parse::<u32>() else { continue };
			for it in v["rewards"]["items"].as_array().into_iter().flatten() {
				if let Some(i) = it["itemId"].as_u64() {
					let e = out.entry(i as u32).or_default();
					if !e.contains(&q) {
						e.push(q);
					}
				}
			}
		}
	}
	out
}

fn words(s: &str) -> Vec<String> {
	s.split(|c: char| !c.is_alphanumeric()).filter(|w| w.len() >= 5).map(|w| w.to_lowercase()).collect()
}

/// The needs of a run's quests (see the module doc). `seed` (its origins) and `goals` (v1's goal
/// stream) place providers outside the run.
pub fn item_needs(world: &World, run: &Run, rules: &Rules, data: &GameData, rewards: &Rewards, seed: &Order, goals: &[Goal]) -> Vec<Need> {
	let steps = &seed.steps;
	let pos = |kind: u8, q: u32| steps.iter().position(|s| s.kind == kind && s.q == q);
	let goal_turnin = |id: u32| goals.iter().position(|g| g.t == "turnin" && g.q == Some(id));
	let mut out = Vec::new();
	for qb in 0..run.n_quests() as u32 {
		let id = run.q_id[qb as usize];
		let Some(d) = data.quests.get(&id) else { continue };
		let wq = &world.quests[rules.open[&id]];
		// (item, the step that needs it: kind and task)
		let mut uses: Vec<(u32, u8, i32)> = Vec::new();
		for (oi, o) in d.objectives.iter().enumerate() {
			let Some(o) = o.as_ref().filter(|o| o.kind == "item") else { continue };
			let Some(item) = o.id else { continue };
			let task = wq.objs.iter().find(|x| x.oi == oi as i64).and_then(|x| x.task).map_or(-1, |t| (run.q_task0[qb as usize] + t) as i32);
			uses.push((item as u32, if task >= 0 { K_TASK } else { K_TURNIN }, task));
		}
		for &i in &d.start.item {
			uses.push((i as u32, K_ACCEPT, -1));
		}
		for r in &d.required_items {
			if let Some(i) = r.as_f64().filter(|&i| Some(i) != d.source_item) {
				let first = run.q_task0[qb as usize];
				if first < run.q_task1[qb as usize] {
					uses.push((i as u32, K_TASK, first as i32));
				} else {
					uses.push((i as u32, K_TURNIN, -1));
				}
			}
		}
		for (item, kb, task) in uses {
			let Some(it) = data.items.get(&item) else { continue };
			let sold = it.vendors.as_ref().is_some_and(|v| !v.is_empty());
			let drops = it.drops.as_ref().is_some_and(|x| x.npc.values().chain(x.object.values()).any(|c| c.is_none_or(|c| c > 0.0)));
			if sold || drops {
				if !sold {
					out.extend(lock_need(run, data, steps, item, kb, qb, task));
				}
				continue;
			}
			let at = if task >= 0 { steps.iter().position(|s| s.kind == K_TASK && s.task == task) } else { pos(kb, qb) };
			let Some(at) = at else { continue };
			// Providers (quest ids): the reward scans, else by name in the zone.
			let mut from: Vec<(u32, String)> = rewards.get(&item).into_iter().flatten().filter(|&&a| a != id).map(|&a| (a, format!("item {item} is {a}'s reward (eg scan)"))).collect();
			if from.is_empty() {
				let name = it.name.clone().unwrap_or_default();
				let iw = words(&name);
				for (&a, da) in &data.quests {
					if a == id || da.zone != d.zone || !words(da.title.as_deref().unwrap_or("")).iter().any(|w| iw.contains(w)) {
						continue;
					}
					from.push((a, format!("item {item} ({name}) has no source; by name from {a} ({})", da.title.as_deref().unwrap_or(""))));
				}
			}
			// Where each provider's turn-in is in v1's order: in the run, its turn-in step; else
			// the step v1 does just before its turn-in goal. Only providers v1 hands in first.
			let mut placed: Vec<(usize, u8, u32, i32, String)> = Vec::new();
			for (a, why) in from {
				if let Some(qa) = run.q(a) {
					if let Some(t) = pos(K_TURNIN, qa).filter(|&t| t < at) {
						placed.push((t, K_TURNIN, qa, -1, why));
					}
				} else if let Some(g) = goal_turnin(a) {
					let anchor = (0..at).rev().find(|&k| seed.origin[k] >= 0 && (seed.origin[k] as usize) < g && matches!(steps[k].kind, K_ACCEPT | K_TASK | K_TURNIN));
					if let Some(k) = anchor {
						let s = steps[k];
						let task_a = if s.kind == K_TASK { s.task } else { -1 };
						placed.push((
							k,
							s.kind,
							s.q,
							task_a,
							format!(
								"{why}; {a} is not in the run: after the step v1 does before it ({} of {})",
								match s.kind {
									K_ACCEPT => "accept",
									K_TASK => "task",
									_ => "turnin",
								},
								run.q_id[s.q as usize]
							),
						));
					}
				}
			}
			placed.sort_by_key(|x| x.0);
			if let Some((_, ka, qa, task_a, why)) = placed.into_iter().next() {
				out.push(Need { kb, qb, task, ka, qa, task_a, why });
			}
		}
	}
	out
}

/// An item that only comes out of locked objects (Benedict's Chest, the Aged Envelope that starts
/// The Admiral's Orders, 830): the step that needs it comes after the step that gets the lock's
/// key (Benedict's Key drops from Lieutenant Benedict, Vanquish the Betrayers' kill, 784): the
/// earliest task in the order that kills a mob dropping the key or collects it. Object locks are
/// data (objects.json `lock.item`, from the data corrections).
fn lock_need(run: &Run, data: &GameData, steps: &[crate::Step], item: u32, kb: u8, qb: u32, task: i32) -> Option<Need> {
	let drops = data.items.get(&item)?.drops.as_ref()?;
	if drops.npc.values().any(|c| c.is_none_or(|c| c > 0.0)) {
		return None;
	}
	let mut keys: Vec<(u32, u32)> = Vec::new();
	for (&obj, c) in &drops.object {
		if c.is_some_and(|c| c <= 0.0) {
			continue;
		}
		match data.objects.get(&obj).and_then(|o| o.lock.as_ref()).and_then(|l| l.item) {
			Some(k) => keys.push((obj, k)),
			// An unlocked source: no key needed.
			None => return None,
		}
	}
	let (obj, key) = *keys.first()?;
	let key_item = data.items.get(&key);
	let mobs: Vec<u32> = key_item.and_then(|k| k.drops.as_ref()).map(|d| d.npc.keys().copied().collect()).unwrap_or_default();
	let gets = |t: usize| {
		(run.task_w0[t]..run.task_w1[t]).any(|w| run.w_kind[w as usize] == crate::run::W_KILL && mobs.contains(&run.w_mob[w as usize]))
			|| (run.t_quest[t] >= 0 && data.quests.get(&run.q_id[run.t_quest[t] as usize]).is_some_and(|d| d.objectives.iter().flatten().any(|o| o.kind == "item" && o.id == Some(f64::from(key)))))
	};
	let s = steps.iter().find(|s| s.kind == K_TASK && s.task >= 0 && gets(s.task as usize))?;
	let name = |i: u32| data.items.get(&i).and_then(|x| x.name.clone()).unwrap_or_else(|| format!("item {i}"));
	Some(Need {
		kb,
		qb,
		task,
		ka: K_TASK,
		qa: s.q,
		task_a: s.task,
		why: format!("{} comes out of object {obj}, locked: its key {} ({key}) comes from {}'s work", name(item), name(key), run.q_id[s.q as usize]),
	})
}
