//! The engine as v1's tests/guides-reported.test.js scripts it in the addon Lua: engineRun's login
//! without a tab and `E.SetGuide`, `E.GetStepView`, `E.GetWaypoint`, `E.GetStepIndex`, `E.Goto`,
//! SIMULATE run once on the open guide, and the scripts' wraps of the stub world's helpers ([`Hooks`]).

use super::core::{Sim, Status};
// The scripted engine below is the seed tests' (native only); the Hooks trait is the engine's own.
#[cfg(feature = "native")]
use super::core::Groups;
#[cfg(feature = "native")]
use super::model::T;
#[cfg(feature = "native")]
use super::play::home;
#[cfg(feature = "native")]
use super::world::{Objective, Skill, World};
#[cfg(feature = "native")]
use super::{Character, Event, Guide, WorldData};

/// A test script's wraps (`w.accept = function(q, ...) ... end`, `E.GetStepView = ...`): each gets the
/// engine and stub world, and calls the helper it wraps (`sim.raw_*`) or not. While a wrap runs, the
/// helpers it calls are the stub world's own.
pub(crate) trait Hooks {
	fn accept(&mut self, sim: &mut Sim<'_>, q: u32, objectives: Vec<f64>) {
		sim.raw_accept(q, objectives);
	}
	/// `i`: the objective, 0-based.
	fn progress(&mut self, sim: &mut Sim<'_>, q: u32, i: usize, n: f64) {
		sim.raw_progress(q, i, n);
	}
	fn turn_in(&mut self, sim: &mut Sim<'_>, q: u32) {
		sim.raw_turn_in(q);
	}
	fn add_item(&mut self, sim: &mut Sim<'_>, id: u32, n: f64) {
		sim.raw_add_item(id, n);
	}
	/// After each E.GetStepView(s) SIMULATE makes, with the statuses it read.
	fn view(&mut self, _sim: &mut Sim<'_>, _s: usize, _statuses: &[Status]) {}
}

#[cfg(feature = "native")]
/// One goal of GetStepView: what the tests read of it.
#[derive(Clone, Debug)]
pub struct GoalView {
	pub t: String,
	pub quest: Option<u32>,
	pub item: Option<u32>,
	pub status: Status,
	pub optional: bool,
	/// goalText for a goal with the author's text (not a goto or explore, whose text is a place);
	/// "" otherwise (describe() is not ported).
	pub text: String,
}

#[cfg(feature = "native")]
/// GetStepView(i): the step's title, goals and groups (each group's goal numbers, in order).
#[derive(Clone, Debug)]
pub struct StepView {
	pub title: Option<String>,
	pub goals: Vec<GoalView>,
	pub groups: Vec<Vec<usize>>,
}

#[cfg(feature = "native")]
/// GetWaypoint: the arrow's goal (step, goal) and its place.
#[derive(Clone, Debug)]
pub struct Waypoint {
	pub step: usize,
	pub goal: usize,
	pub map: Option<u32>,
	pub x: Option<f64>,
	pub y: Option<f64>,
}

#[cfg(feature = "native")]
impl<'a> Sim<'a> {
	/// engineRun's world: the character on stub_world's defaults (no position), behavior settings at
	/// their defaults but autoSelectGuide (group quests "ask").
	pub(crate) fn scripted(guides: &'a [Guide], wd: &'a WorldData, c: &Character) -> Sim<'a> {
		let w = World::new(&wd.frames, &c.race, &c.class, &c.faction, c.level as f64);
		Sim::new(guides, w, wd, Groups::Ask)
	}

	/// playGuide's world: the character at the guide's start level and place (a leveling guide's first
	/// located goal, any other the race's home), autoNextGuide off, group quests skipped.
	pub(crate) fn for_play(guides: &'a [Guide], wd: &'a WorldData, gi: usize, race: &str, faction: &str, class: &str) -> Sim<'a> {
		let g = &guides[gi];
		let mut w = World::new(&wd.frames, race, class, faction, super::start_level(g) as f64);
		let leveling = g.category.as_deref().is_none_or(|c| c == "Leveling");
		let first = g.steps.iter().flat_map(|s| &s.goals).find_map(|x| Some((x.map?, x.x?, x.y?)));
		if let Some((map, x, y)) = if leveling { first } else { home(race).or(first) } {
			w.map = Some(map);
			w.x = x;
			w.y = y;
		}
		let mut sim = Sim::new(guides, w, wd, Groups::Skip);
		sim.auto_next = false;
		sim
	}

	/// stub_world `w.onQuest(q, { { required, fulfilled }, ... })`: in the log already (no events).
	pub(crate) fn set_on_quest(&mut self, q: u32, objectives: &[(f64, f64)]) {
		let objs = objectives.iter().map(|&(required, fulfilled)| Objective { required, fulfilled, finished: fulfilled >= required }).collect();
		self.w.log.insert(q, objs);
	}

	/// `w.skills[line] = { rank, maxRank }`: a skill known already (no events).
	pub(crate) fn set_skill(&mut self, line: u32, rank: f64, max_rank: f64) {
		self.w.skills.insert(line.to_string(), Skill { rank, max_rank });
	}

	/// engineRun's `stub.login(); stub.advance(0.5); E.SetGuide(id)`: no tab at login (autoSelectGuide
	/// off), then the guide opened in a tab of its own.
	pub(crate) fn login_and_open(&mut self, gi: usize) {
		self.refresh_player(); // PLAYER_LOGIN
		self.request_update(); // PLAYER_ENTERING_WORLD
		self.run_due();
		self.advance(0.5);
		self.reset_loaded(gi, false);
		self.evaluate();
	}

	/// E.GetStepView(s).
	pub(crate) fn step_view(&mut self, s: usize) -> StepView {
		let v = self.view(s);
		let (groups, _) = self.step_groups(s);
		let gd = self.gd();
		let step = gd.step(s);
		let goals = v
			.iter()
			.zip(&step.goals)
			.map(|(v, g)| GoalView {
				t: g.verb.clone(),
				quest: g.quest,
				item: g.item,
				status: v.status,
				optional: g.optional,
				text: match (&g.text, g.t) {
					(Some(t), tt) if tt != T::Goto && tt != T::Explore => t.clone(),
					_ => String::new(),
				},
			})
			.collect();
		StepView { title: step.title.clone(), goals, groups: groups.into_iter().map(|g| g.goals).collect() }
	}

	/// E.GetWaypoint().
	pub(crate) fn get_waypoint(&mut self) -> Option<Waypoint> {
		let (gi, s, g) = self.waypoint?;
		if Some(gi) != self.guide {
			return None;
		}
		let pos = self.pos_of(s, g);
		Some(Waypoint { step: s, goal: g, map: pos.map(|p| p.0), x: pos.map(|p| p.1), y: pos.map(|p| p.2) })
	}

	/// SIMULATE once on the open guide -> (done: no current step or the guide left, the stuck event).
	pub(crate) fn simulate(&mut self) -> (bool, Option<Event>) {
		let g = self.guide;
		let mut out = Vec::new();
		let stuck = self.simulate_once(&mut out);
		(self.current.is_none() || self.guide != g, stuck)
	}
}
