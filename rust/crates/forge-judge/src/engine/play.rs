//! The simulated player of tools/lib/playtest.js (SIMULATE, playtest.js:620-809) on the stub world, with
//! wow_stub.lua's clock: each loop completes the first open goal of the current step as a player would
//! (accept, kill, loot, walk there, talk, train, bind, level up...), ticks a manual goal that stays open,
//! stops (or skips the step) where a goal stays open, and follows the engine's hand-over through `next`.

use super::core::{is_manual, Sim, Status, TimerKind};
use super::model::{Guide, T};
use super::world::{FrameKind, Objective, Skill};
use super::{Event, OnStuck};
use rustc_hash::FxHashMap;

/// Where each race starts (playtest.js HOME, Era frame): guides that are not leveling guides begin there.
pub(crate) fn home(race: &str) -> Option<(u32, f64, f64)> {
	Some(match race {
		"Human" => (1429, 48.2, 42.0),
		"Dwarf" | "Gnome" => (1426, 29.9, 71.2),
		"NightElf" => (1438, 58.6, 44.4),
		"Orc" | "Troll" => (1411, 43.3, 68.5),
		"Tauren" => (1412, 44.2, 76.1),
		"Scourge" => (1420, 32.5, 63.2),
		"Skyborne" => (2521, 42.8, 23.4),
		_ => return None,
	})
}

/// A goal as GetStepView shows it, with what the simulated player reads.
pub(crate) struct ViewGoal {
	pub status: Status,
	pub max: Option<f64>,
	pub manual: bool,
	pub npc: Option<u32>,
	pub npc_name: Option<String>,
	pub pos: Option<(u32, f64, f64)>,
}

impl<'a> Sim<'a> {
	// ------------------------------------------------------------------ clock (wow_stub.lua)

	/// stub.runTimers: every timer due now, earliest first.
	pub(crate) fn run_due(&mut self) {
		loop {
			let mut best: Option<usize> = None;
			for (k, t) in self.timers.iter().enumerate() {
				if best.is_none_or(|b| t.at < self.timers[b].at) {
					best = Some(k);
				}
			}
			let Some(b) = best else { return };
			if self.timers[b].at > self.now + 1e-9 {
				return;
			}
			let t = self.timers.remove(b);
			match t.kind {
				TimerKind::Flush => self.flush(),
				TimerKind::Tick(h) => self.tick(h),
			}
		}
	}

	/// stub.advance: time in steps of 0.05 s, timers run as they come due.
	pub(crate) fn advance(&mut self, seconds: f64) {
		let step = 0.05f64;
		let mut remaining = seconds;
		loop {
			let dt = step.min(remaining);
			self.now += dt;
			remaining -= dt;
			self.run_due();
			if remaining <= 1e-9 {
				break;
			}
		}
	}

	// ------------------------------------------------------------------ stub world helpers and their events

	fn log_changed(&mut self) {
		self.on_log_update();
		self.request_update(); // UNIT_QUEST_LOG_CHANGED, QUEST_WATCH_UPDATE
	}

	/// w.accept, through a test script's wrap when there is one.
	pub(crate) fn w_accept(&mut self, q: u32, objectives: Vec<f64>) {
		match self.hooks.take() {
			Some(mut h) => {
				h.accept(self, q, objectives);
				self.hooks = Some(h);
			}
			None => self.raw_accept(q, objectives),
		}
	}

	pub(crate) fn raw_accept(&mut self, q: u32, objectives: Vec<f64>) {
		let objs = objectives.into_iter().map(|r| Objective { required: r, fulfilled: 0.0, finished: 0.0 >= r }).collect();
		self.w.log.insert(q, objs);
		self.on_quest_accepted(q);
		self.log_changed();
	}

	/// w.progress (objective `i`, 0-based), through a test script's wrap when there is one.
	pub(crate) fn w_progress(&mut self, q: u32, i: usize, n: f64) {
		match self.hooks.take() {
			Some(mut h) => {
				h.progress(self, q, i, n);
				self.hooks = Some(h);
			}
			None => self.raw_progress(q, i, n),
		}
	}

	pub(crate) fn raw_progress(&mut self, q: u32, i: usize, n: f64) {
		if let Some(o) = self.w.log.get_mut(&q).and_then(|l| l.get_mut(i)) {
			o.fulfilled = n;
			o.finished = n >= o.required;
		}
		self.log_changed();
	}

	pub(crate) fn w_finish(&mut self, q: u32) {
		if let Some(l) = self.w.log.get_mut(&q) {
			for o in l {
				o.fulfilled = o.required;
				o.finished = true;
			}
		}
		self.log_changed();
	}

	/// w.turnIn, through a test script's wrap when there is one.
	pub(crate) fn w_turn_in(&mut self, q: u32) {
		match self.hooks.take() {
			Some(mut h) => {
				h.turn_in(self, q);
				self.hooks = Some(h);
			}
			None => self.raw_turn_in(q),
		}
	}

	pub(crate) fn raw_turn_in(&mut self, q: u32) {
		self.w.log.remove(&q);
		self.w.completed.insert(q);
		self.on_turned_in(q);
		self.request_update(); // QUEST_REMOVED
		self.log_changed();
	}

	fn w_abandon(&mut self, q: u32) {
		self.w.log.remove(&q);
		self.request_update();
		self.log_changed();
	}

	/// w.addItem, through a test script's wrap when there is one.
	pub(crate) fn w_add_item(&mut self, id: u32, n: f64) {
		match self.hooks.take() {
			Some(mut h) => {
				h.add_item(self, id, n);
				self.hooks = Some(h);
			}
			None => self.raw_add_item(id, n),
		}
	}

	pub(crate) fn raw_add_item(&mut self, id: u32, n: f64) {
		*self.w.items.entry(id).or_insert(0.0) += n;
		self.request_update(); // BAG_UPDATE_DELAYED
	}

	fn w_remove_item(&mut self, id: u32) {
		self.w.items.remove(&id);
		self.request_update();
	}

	fn w_move_to(&mut self, map: Option<u32>, x: f64, y: f64) {
		self.w.map = map;
		self.w.x = x;
		self.w.y = y;
	}

	fn w_set_zone(&mut self, zone: &str) {
		let new_area = zone != self.w.zone;
		self.w.zone = zone.to_string();
		self.w.subzone = zone.to_string();
		if new_area {
			self.on_context(); // ZONE_CHANGED_NEW_AREA
		}
		self.on_context(); // ZONE_CHANGED
	}

	fn w_set_level(&mut self, level: f64) {
		self.w.level = level;
		self.on_level_up(level);
		self.request_update(); // PLAYER_XP_UPDATE
	}

	fn w_set_xp(&mut self, xp: f64) {
		self.w.xp = xp;
		self.request_update();
	}

	fn w_bind(&mut self, location: &str) {
		self.w.bind = location.to_string();
		self.on_bound();
		self.request_update(); // QOL_HEARTH_CHANGED
	}

	fn w_open(&mut self, npc: Option<u32>, frame: FrameKind) {
		self.w.npc_unit = npc;
		self.w.frame = Some(frame);
		match frame {
			FrameKind::Gossip => {
				self.on_npc_frame(super::core::Kind::Talk);
				self.check_offers_gossip(npc);
			}
			FrameKind::Trainer => self.on_npc_frame(super::core::Kind::Train),
			FrameKind::Merchant => self.on_npc_frame(super::core::Kind::Vendor),
		}
	}

	fn w_close(&mut self) {
		let f = self.w.frame.take();
		self.w.npc_unit = None;
		if f.is_some() {
			self.on_frame_closed();
		}
	}

	pub(crate) fn w_skill(&mut self, line: &str, rank: f64, max: Option<f64>) {
		let s = self.w.skills.entry(line.to_string()).or_insert(Skill { rank: 1.0, max_rank: 300.0 });
		s.rank = rank;
		if let Some(m) = max {
			s.max_rank = m;
		}
		self.request_update();
	}

	// ------------------------------------------------------------------ the view the player reads

	/// GetStepView(i): each goal's status and the fields SIMULATE reads (picks and spawn areas as the
	/// window's read leaves them).
	pub(crate) fn view(&mut self, s: usize) -> Vec<ViewGoal> {
		let step_status = self.step_status(s);
		let n = self.gd().step(s).goals.len();
		let mut out = Vec::with_capacity(n);
		for g in 1..=n {
			let (status, d) = match step_status {
				None => (Status::Na, Default::default()),
				Some(cur) => self.goal_status(s, g, cur),
			};
			let max = if d.cur.is_some() { d.max } else { None };
			let (npc, npc_name) = self.npc_of(s, g);
			let pos = self.pos_of(s, g).map(|p| (p.0, p.1, p.2));
			out.push(ViewGoal { status, max, manual: is_manual(self.gd().goal(s, g)), npc, npc_name, pos });
		}
		out
	}

	/// E.GetStepView as SIMULATE calls it: through a test script's wrap when there is one (which sees
	/// the view and may act on the world; the view returned is the one read before).
	fn view_hooked(&mut self, s: usize) -> Vec<ViewGoal> {
		let v = self.view(s);
		if let Some(mut h) = self.hooks.take() {
			let statuses: Vec<Status> = v.iter().map(|g| g.status).collect();
			h.view(self, s, &statuses);
			self.hooks = Some(h);
		}
		v
	}

	/// describe(goal)'s subject for the verbs whose subject SIMULATE acts on.
	fn subject(&self, s: usize, g: usize, v: &ViewGoal) -> Option<String> {
		let goal = self.gd().goal(s, g);
		match goal.t {
			T::Sethome => match &goal.location {
				Some(l) => Some(l.clone()),
				None => Some(v.npc_name.clone().unwrap_or_else(|| "the nearest inn".into())),
			},
			T::Hearth | T::Enter | T::Fly | T::Die => goal.location.clone(),
			T::Level => goal.level.map(|l| format!("{}", l.floor() as i64)),
			_ => None,
		}
	}

	// ------------------------------------------------------------------ SIMULATE's act

	fn act(&mut self, i: usize, g: usize, v: &ViewGoal, objs: &FxHashMap<u32, FxHashMap<u32, f64>>) {
		let goal = self.gd().goal(i, g);
		let q = goal.quest;
		let in_log = |sim: &Sim, q: u32| sim.w.log.contains_key(&q);
		match goal.t {
			T::Accept => {
				let q = q.unwrap_or(0);
				if !in_log(self, q) && !self.w.completed.contains(&q) {
					let o = objs.get(&q);
					let n = o.map_or(0, |o| o.keys().copied().max().unwrap_or(0));
					let list = (1..=n).map(|k| o.and_then(|o| o.get(&k)).copied().unwrap_or(1.0)).collect();
					self.w_accept(q, list);
				}
			}
			T::Turnin => {
				let q = q.unwrap_or(0);
				if in_log(self, q) {
					self.w_finish(q);
				}
				self.w_turn_in(q);
			}
			T::Complete => {
				if let Some(q) = q.filter(|&q| in_log(self, q)) {
					self.w_finish(q);
				}
			}
			T::Abandon => {
				if let Some(q) = q.filter(|&q| in_log(self, q)) {
					self.w_abandon(q);
				}
			}
			T::Destroy => {
				if let Some(item) = goal.item {
					self.w_remove_item(item);
				}
			}
			T::Kill | T::Collect | T::Use | T::Interact if q.is_some() => {
				let q = q.unwrap();
				if in_log(self, q) {
					match goal.oi {
						Some(oi) => match self.w.log[&q].get(oi as usize - 1).map(|o| o.required) {
							Some(req) => self.w_progress(q, oi as usize - 1, req),
							None => self.w_finish(q),
						},
						None => self.w_finish(q),
					}
				}
			}
			T::Collect | T::Buy if goal.item.is_some() => {
				self.w_add_item(goal.item.unwrap(), v.max.unwrap_or(1.0));
			}
			T::Goto => {
				let (map, x, y) = v.pos.map_or((None, 0.0, 0.0), |p| (Some(p.0), p.1, p.2));
				self.w_move_to(map, x, y);
			}
			T::Talk => {
				self.w_open(v.npc, FrameKind::Gossip);
				self.w_close();
			}
			T::Train => {
				if let (Some(line), Some(super::model::Rank::Num(r))) = (goal.skill_line, &goal.rank) {
					let cap = goal.rank_max.or_else(|| [75.0, 150.0, 225.0, 300.0].get(*r as usize - 1).copied()).unwrap_or(0.0);
					let key = line.to_string();
					match self.w.skills.get(&key).cloned() {
						Some(s) => self.w_skill(&key, s.rank, Some(cap.max(s.max_rank))),
						None => self.w_skill(&key, 1.0, Some(cap)),
					}
				}
				self.w_open(Some(v.npc.unwrap_or(1)), FrameKind::Trainer);
				self.w_close();
			}
			T::Vendor => {
				self.w_open(Some(v.npc.unwrap_or(1)), FrameKind::Merchant);
				self.w_close();
			}
			T::Sethome => {
				let loc = self.subject(i, g, v).unwrap_or_else(|| "Inn".into());
				self.w_bind(&loc);
			}
			T::Hearth | T::Fly | T::Enter => {
				let z = self.subject(i, g, v).unwrap_or_default();
				self.w_set_zone(&z);
			}
			T::Die => {
				let (map, x, y) = v.pos.map_or((None, 0.0, 0.0), |p| (Some(p.0), p.1, p.2));
				self.w_move_to(map, x, y);
				// PLAYER_UNGHOST: back alive beside the Spirit Healer.
				self.check_arrival();
				self.request_update();
			}
			T::Level => {
				let want = self.subject(i, g, v).and_then(|s| s.parse::<f64>().ok()).unwrap_or(self.w.level + 1.0);
				self.w_set_level(self.w.level.max(want));
				if let (Some(frac), Some(level)) = (goal.frac, goal.level) {
					if self.w.level == level {
						let want = (frac * self.w.xp_max).ceil();
						if self.w.xp < want {
							self.w_set_xp(want);
						}
					}
				}
			}
			T::Money => {
				let m = goal.money.unwrap_or(0.0);
				if self.w.money < m {
					self.w.money = m;
					self.request_update();
				}
			}
			T::Skill => {
				let line = goal.skill_line.map(|l| l.to_string()).or_else(|| goal.skill.clone()).unwrap_or_default();
				let level = goal.level.unwrap_or(0.0);
				let max = self.w.skills.get(&line).map_or(300.0, |s| s.max_rank);
				self.w_skill(&line, level, Some(level.max(max)));
			}
			T::Cast => {
				if let Some(sp) = goal.spell {
					if self.latch_cast(sp) {
						self.request_update();
					}
				}
			}
			T::Learn => {
				if let Some(sp) = goal.spell {
					self.w.spells.insert(sp);
					self.on_spell_learned();
				}
				self.request_update();
			}
			T::Craft => {
				if let Some(until) = goal.until_skill {
					let line = goal.skill_line.map(|l| l.to_string()).or_else(|| goal.skill.clone()).unwrap_or_default();
					let max = self.w.skills.get(&line).map_or(300.0, |s| s.max_rank);
					self.w_skill(&line, until, Some(until.max(max)));
				} else if let Some(item) = goal.item {
					self.w_add_item(item, goal.count.unwrap_or(1.0));
				}
			}
			T::Rep => {
				if let Some(f) = goal.faction {
					self.w.factions.insert(f, goal.standing.unwrap_or(0.0));
				}
				self.request_update();
			}
			T::Explore => {
				let id = 900000 + i as u32 * 100 + g as u32;
				if let (Some(map), Some(x), Some(y)) = (goal.map, goal.x, goal.y) {
					self.w.areas.push((map, x - 1.0, y - 1.0, x + 1.0, y + 1.0, id));
					self.w_move_to(Some(map), x, y);
				}
				self.w.explored.insert(id);
				self.request_update();
			}
			T::Achieve => {
				if let Some(a) = goal.achievement {
					let e = self.w.achievements.entry(a).or_insert((false, vec![(0.0, 1.0, false)]));
					for (ci, c) in e.1.iter_mut().enumerate() {
						if goal.criteria.is_none_or(|k| k as usize == ci + 1) {
							c.0 = c.1;
							c.2 = true;
						}
					}
					if e.1.iter().all(|c| c.2) {
						e.0 = true;
					}
					self.request_update();
				}
			}
			_ => {}
		}
		self.advance(0.6);
	}

	// ------------------------------------------------------------------ SIMULATE

	/// One SIMULATE run on the open guide `G`: -> the stuck event, if any.
	pub(crate) fn simulate_once(&mut self, out: &mut Vec<Event>) -> Option<Event> {
		let gi = self.guide?;
		let gd: &Guide = &self.gs[gi];
		let mut objs: FxHashMap<u32, FxHashMap<u32, f64>> = FxHashMap::default();
		for st in &gd.steps {
			for goal in &st.goals {
				if let (Some(q), Some(oi)) = (goal.quest, goal.oi) {
					let e = objs.entry(q).or_default().entry(oi).or_insert(1.0);
					*e = e.max(goal.count.unwrap_or(1.0));
				}
			}
		}
		let left = |sim: &Sim| sim.guide != Some(gi);
		let mut guard = 0;
		while guard < 4000 {
			guard += 1;
			let Some(i) = self.current else { break };
			if left(self) {
				break;
			}
			let view = self.view_hooked(i);
			let open = (1..=view.len()).find(|&g| {
				let v = &view[g - 1];
				let goal = self.gd().goal(i, g);
				v.status != Status::Done && v.status != Status::Na && !goal.optional && goal.t != T::Note
			});
			match open {
				None => {
					self.advance(0.6);
					if left(self) {
						break;
					}
					if self.current == Some(i) {
						return Some(Event::Stuck { guide: gd.id.clone(), step: i, goal: None, verb: None, status: None, why: Some("no open goal but the step did not advance".into()) });
					}
				}
				Some(g) => {
					let v = &view[g - 1];
					let goal = self.gd().goal(i, g);
					out.push(Event::Goal { guide: gd.id.clone(), step: i, goal: g, verb: goal.verb.clone(), id: goal.report_id(), ticked: false });
					self.act(i, g, v, &objs);
					if left(self) {
						break;
					}
					let after = self.view_hooked(i);
					let after_status = after[g - 1].status;
					let mut same = self.current == Some(i) && after_status != Status::Done;
					if same && v.manual {
						self.toggle_goal(i, g);
						if let Some(Event::Goal { ticked, .. }) = out.last_mut() {
							*ticked = true;
						}
						self.advance(0.6);
						if left(self) {
							break;
						}
						same = self.current == Some(i) && self.view_hooked(i)[g - 1].status != Status::Done;
					}
					if same {
						return Some(Event::Stuck { guide: gd.id.clone(), step: i, goal: Some(g), verb: Some(goal.verb.clone()), status: Some(after_status.as_str().into()), why: None });
					}
				}
			}
		}
		None
	}

	/// The accept/turn-in goals of the open guide without a location (SIMULATE's `missing`).
	fn missing(&self) -> Vec<(usize, usize)> {
		let mut out = Vec::new();
		for (si, st) in self.gd().steps.iter().enumerate() {
			for (gi, g) in st.goals.iter().enumerate() {
				if ((g.t == T::Accept && g.item.is_none()) || g.t == T::Turnin) && !(g.map.is_some() && g.x.is_some() && g.y.is_some()) {
					out.push((si + 1, gi + 1));
				}
			}
		}
		out
	}

	/// The login (Polestar opens the start guide in a tab and evaluates), the play script's first lines
	/// (quest log readable, settings, SetGuide, 0.6 s), then SIMULATE guide after guide.
	pub(crate) fn play(&mut self, start: usize, on_stuck: OnStuck) -> Vec<Event> {
		let mut out = Vec::new();
		self.login(start);
		out.push(Event::Login { guide: self.gs[start].id.clone() });
		self.advance(0.6);
		let mut last_guide = None;
		let mut missing_seen = rustc_hash::FxHashSet::default();
		for _ in 0..4000 {
			let Some(gi) = self.guide else { break };
			if last_guide != Some(gi) {
				last_guide = Some(gi);
				out.push(Event::Guide { guide: self.gs[gi].id.clone() });
			}
			if missing_seen.insert(gi) {
				let list = self.missing();
				if !list.is_empty() {
					out.push(Event::Missing { guide: self.gs[gi].id.clone(), goals: list });
				}
			}
			match self.simulate_once(&mut out) {
				Some(stuck) => {
					let step = match &stuck {
						Event::Stuck { step, .. } => *step,
						_ => unreachable!(),
					};
					out.push(stuck);
					if on_stuck == OnStuck::Stop || self.guide != Some(gi) || self.current != Some(step) {
						break;
					}
					self.skip();
				}
				None => {
					if self.guide.is_none() || self.guide == Some(gi) {
						break;
					}
				}
			}
		}
		out
	}

	/// playGuide's login and the play script's first lines: Polestar opens the start guide in a tab
	/// and evaluates (OnLogin), then quest log readable, settings, SetGuide of the open guide.
	pub(crate) fn login(&mut self, start: usize) {
		self.open_tab(start);
		self.evaluate();
		self.request_update(); // PLAYER_ENTERING_WORLD
		self.run_due();
		self.on_log_update(); // QUEST_LOG_UPDATE
		self.request_update(); // SETTING_CHANGED behavior.groupQuests
		self.evaluate(); // SetGuide of the open guide: evaluate()
	}
}
