//! A headless copy of addon/Polestar/Core/Engine.lua's step selection and done rules, played the way
//! tools/lib/playtest.js plays a guide on tests/lua/stub_world.lua (SIMULATE).
//!
//! - Steps: `only` (class/race/faction, `!x` excludes), `when` (every WHEN_KEYS predicate, stored once
//!   passed), `skipto` jumps, `along` steps passed over, placement of a guide just opened, latches of
//!   passed and in-step goals.
//! - Goals: the done rule per verb (goalDone), optional and note goals never block, unavailable marks
//!   (closed, prerequisite not coming, the giver's refusal, level/prerequisite gates at placement),
//!   never-had quests (`na`), profession gates, NPC interactions latched during their step.
//! - `next`: the guide hands over when it ends (one option, the remembered one, else the recommended one).
//!
//! The player ([`Replay`]) completes, each loop, the first open goal that is not optional (accept, kill,
//! loot, walk there, talk, train, bind, level up...) against a stub world as lenient as the JS one: any
//! quest can be taken, objectives finish when acted on, items come from nowhere. A goal that stays open
//! after the act is ticked when manual; else the play is stuck there (stopped, or the step skipped).
//! Time runs as wow_stub.lua's clock (0.6 s per act, evaluations at most every 0.1 s, the arrival poll
//! every 0.5 s), so goals complete in the same order as in the Lua play.
//!
//! ```ignore
//! let guides: Vec<engine::Guide> = compiled.iter().map(engine::Guide::read).collect();
//! let world = engine::WorldData::from_data(&data);
//! let events = engine::Replay::new(&guides, &world, engine::Character::new("Horde", "Orc", "WARRIOR", 1))
//!     .play("forever/horde/orc-troll/01-durotar", engine::OnStuck::Skip)?;
//! ```

mod core;
mod model;
mod play;
mod script;
mod world;

#[cfg(feature = "native")]
pub(crate) use self::core::{trivial, Sim};
pub use self::core::{Groups, Status};
pub use model::{Along, Goal, Guide, Only, Pred, Step, T};
#[cfg(feature = "native")]
pub(crate) use script::{Hooks, StepView};

use forge_core::MapFrames;
use forge_guide::js::V;
use rustc_hash::FxHashMap;
use serde::Serialize;

/// The character played: faction ("Horde"), race file ("Orc", "Scourge"), class file ("WARRIOR") and the
/// level it starts at.
#[derive(Clone, Debug)]
pub struct Character {
	pub faction: String,
	pub race: String,
	pub class: String,
	pub level: u32,
}

impl Character {
	pub fn new(faction: &str, race: &str, class: &str, level: u32) -> Character {
		Character { faction: faction.into(), race: race.into(), class: class.into(), level }
	}
}

/// What a stuck play does: stop there (SIMULATE's own end) or skip the step and play on.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum OnStuck {
	Stop,
	Skip,
}

/// One event of a replay, in order.
#[derive(Clone, Debug, PartialEq, Serialize)]
#[serde(tag = "k", rename_all = "lowercase")]
pub enum Event {
	/// The guide the login opened.
	Login { guide: String },
	/// The player is in this guide from now on (the start, then each hand-over).
	Guide { guide: String },
	/// A goal the player completed: guide, step and goal (1-based), verb, its quest (else item, NPC or
	/// spell); `ticked` when it stayed open and the player ticked it by hand.
	Goal { guide: String, step: usize, goal: usize, verb: String, id: Option<u32>, ticked: bool },
	/// The play stuck: a goal still open after the act (its status then), or a step with no open goal
	/// that did not advance (`why`).
	Stuck { guide: String, step: usize, goal: Option<usize>, verb: Option<String>, status: Option<String>, why: Option<String> },
	/// Accept and turn-in goals without a location (step, goal), once per guide.
	Missing { guide: String, goals: Vec<(usize, usize)> },
}

/// What the stub world needs from the reference data: the map frames and the class trainers.
#[derive(Clone, Debug, Default)]
pub struct WorldData {
	pub frames: MapFrames,
	/// Class trainers' NPC ids -> class files (data/forever/trainers.json; Engine.IsClassTrainer).
	pub class_trainers: FxHashMap<u32, Vec<String>>,
	/// Inns (data/forever/travel.json `inns`; Nav/Travel.lua's): where a bind location is.
	pub inns: Vec<Inn>,
}

/// An inn: its innkeeper, names, continent and world position.
#[derive(Clone, Debug)]
pub struct Inn {
	pub npc: u32,
	pub names: Vec<String>,
	pub c: i64,
	pub wx: f64,
	pub wy: f64,
}

fn bounds(v: &V) -> FxHashMap<String, forge_core::Bounds> {
	let mut out = FxHashMap::default();
	if let Some(o) = v.as_obj() {
		for (k, b) in o.entries() {
			let c = b.get("c").as_num().unwrap_or(0.0) as i64;
			out.insert(k.to_string(), forge_core::Bounds { c, left: b.get("left").as_num(), right: b.get("right").as_num(), top: b.get("top").as_num(), bottom: b.get("bottom").as_num() });
		}
	}
	out
}

impl WorldData {
	/// From the compiler's reference data (map-frames.json, trainers.json).
	pub fn from_data(data: &forge_guide::data::Data) -> WorldData {
		let frames = MapFrames { era: bounds(&data.map_frames.get("era")), forever: bounds(&data.map_frames.get("forever")) };
		let mut class_trainers = FxHashMap::default();
		if let Some(o) = data.trainers_raw.as_obj() {
			for (k, t) in o.entries() {
				let Ok(id) = k.parse::<u32>() else { continue };
				let classes: Vec<String> = t.get("classes").as_arr().map(|a| a.to_vec().iter().filter_map(|c| c.as_str().map(str::to_string)).collect()).unwrap_or_default();
				if !classes.is_empty() {
					class_trainers.insert(id, classes);
				}
			}
		}
		let inns = data
			.travel
			.get("inns")
			.as_arr()
			.map(|a| {
				a.to_vec()
					.iter()
					.filter_map(|t| {
						Some(Inn {
							npc: t.get("npc").as_num()? as u32,
							names: t.get("names").as_arr().map(|n| n.to_vec().iter().filter_map(|x| x.as_str().map(str::to_string)).collect()).unwrap_or_default(),
							c: t.get("c").as_num().unwrap_or(0.0) as i64,
							wx: t.get("wx").as_num()?,
							wy: t.get("wy").as_num()?,
						})
					})
					.collect()
			})
			.unwrap_or_default();
		WorldData { frames, class_trainers, inns }
	}
}

/// A replay of guides by a simulated player on the stub world.
pub struct Replay<'a> {
	guides: &'a [Guide],
	world: &'a WorldData,
	character: Character,
	groups: Groups,
}

impl<'a> Replay<'a> {
	pub fn new(guides: &'a [Guide], world: &'a WorldData, character: Character) -> Replay<'a> {
		Replay { guides, world, character, groups: Groups::Skip }
	}

	/// The answer at every group quest (`behavior.groupQuests`); the solo route skips them (default).
	pub fn groups(mut self, groups: Groups) -> Replay<'a> {
		self.groups = groups;
		self
	}

	/// Play from guide `start` through `next` until the chain ends (or the play sticks, with `Stop`).
	pub fn play(&self, start: &str, on_stuck: OnStuck) -> Result<Vec<Event>, String> {
		let gi = self.guides.iter().position(|g| g.id == start).ok_or_else(|| format!("no guide {start}"))?;
		let g = &self.guides[gi];
		let c = &self.character;
		let mut w = world::World::new(&self.world.frames, &c.race, &c.class, &c.faction, c.level as f64);
		// playOptions: a leveling guide starts at its first located goal, any other at the race's home.
		let leveling = g.category.as_deref().is_none_or(|c| c == "Leveling");
		let first = g.steps.iter().flat_map(|s| &s.goals).find_map(|x| Some((x.map?, x.x?, x.y?)));
		let at = if leveling { first } else { play::home(&c.race).or(first) };
		if let Some((map, x, y)) = at {
			w.map = Some(map);
			w.x = x;
			w.y = y;
		}
		let mut sim = core::Sim::new(self.guides, w, self.world, self.groups);
		Ok(sim.play(gi, on_stuck))
	}
}

/// The level a guide's playtest starts at (playtest.js: `g.minLevel || 1`).
pub fn start_level(g: &Guide) -> u32 {
	g.min_level.filter(|&l| l > 0.0).map_or(1, |l| l as u32)
}
