//! The game world of tests/lua/stub_world.lua as the engine reads it: the player, the quest log, bags,
//! the bind, zone texts, skills, spells. The helpers that change it (accept, progress, turnIn, ...) live
//! on the replay, which fires the engine's event handlers the way stub_world fires the client events.

use forge_core::MapFrames;
use rustc_hash::{FxHashMap, FxHashSet};

/// One quest-log objective (stub_world normalize).
#[derive(Clone, Debug)]
pub struct Objective {
	pub required: f64,
	pub fulfilled: f64,
	pub finished: bool,
}

/// A map's frame for the stub's C_Map: continent and bounds (era frames over Forever ones).
#[derive(Clone, Copy, Debug)]
pub struct Bounds {
	pub c: i64,
	pub left: f64,
	pub right: f64,
	pub top: f64,
	pub bottom: f64,
}

#[derive(Clone, Debug)]
pub struct Skill {
	pub rank: f64,
	pub max_rank: f64,
}

/// The open NPC window (stub_world `world.frame`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum FrameKind {
	Gossip,
	Trainer,
	Merchant,
}

#[derive(Clone, Debug)]
pub struct World {
	pub level: f64,
	pub xp: f64,
	pub xp_max: f64,
	pub race: String,
	pub class: String,
	pub faction: String,
	pub map: Option<u32>,
	pub x: f64,
	pub y: f64,
	pub bind: String,
	pub money: f64,
	pub zone: String,
	pub subzone: String,
	pub log: FxHashMap<u32, Vec<Objective>>,
	pub completed: FxHashSet<u32>,
	pub items: FxHashMap<u32, f64>,
	/// The `npc` unit (the NPC whose window was opened last; cleared on close).
	pub npc_unit: Option<u32>,
	pub frame: Option<FrameKind>,
	pub skills: FxHashMap<String, Skill>,
	pub spells: FxHashSet<u32>,
	pub factions: FxHashMap<u32, f64>,
	pub explored: FxHashSet<u32>,
	pub areas: Vec<(u32, f64, f64, f64, f64, u32)>,
	pub achievements: FxHashMap<u32, (bool, Vec<(f64, f64, bool)>)>,
	/// The stub's maps (mapsLua: Era frames where a map has one, else Forever).
	pub maps: FxHashMap<u32, Bounds>,
	/// ns.MapFrames.era (the pack's MapFrames.lua): frames for goals written in Era coordinates (`f = "e"`).
	pub era: FxHashMap<u32, Bounds>,
}

fn rect(b: &forge_core::Bounds) -> Option<Bounds> {
	Some(Bounds { c: b.c, left: b.left?, right: b.right?, top: b.top?, bottom: b.bottom? })
}

impl World {
	pub fn new(frames: &MapFrames, race: &str, class: &str, faction: &str, level: f64) -> World {
		let mut era = FxHashMap::default();
		let mut maps = FxHashMap::default();
		for (k, b) in &frames.forever {
			if let (Ok(id), Some(r)) = (k.parse::<u32>(), rect(b)) {
				maps.insert(id, r);
			}
		}
		// `{ ...forever, ...era }`: an Era entry replaces the Forever one, bounds or not.
		for (k, b) in &frames.era {
			let Ok(id) = k.parse::<u32>() else { continue };
			match rect(b) {
				Some(r) => {
					maps.insert(id, r);
					era.insert(id, r);
				}
				None => {
					maps.remove(&id);
				}
			}
		}
		World {
			level,
			xp: 0.0,
			xp_max: 400.0,
			race: race.to_string(),
			class: class.to_string(),
			faction: faction.to_string(),
			map: None,
			x: 0.0,
			y: 0.0,
			bind: "Northshire Abbey".into(),
			money: 0.0,
			zone: "Elwynn Forest".into(),
			subzone: "Northshire Valley".into(),
			log: FxHashMap::default(),
			completed: FxHashSet::default(),
			items: FxHashMap::default(),
			npc_unit: None,
			frame: None,
			skills: FxHashMap::default(),
			spells: FxHashSet::default(),
			factions: FxHashMap::default(),
			explored: FxHashSet::default(),
			areas: Vec::new(),
			achievements: FxHashMap::default(),
			maps,
			era,
		}
	}

	pub fn on_quest(&self, q: u32) -> bool {
		self.log.contains_key(&q)
	}

	/// C_QuestLog.ReadyForTurnIn: in the log with every objective finished (none: ready).
	pub fn ready(&self, q: u32) -> bool {
		self.log.get(&q).is_some_and(|o| o.iter().all(|x| x.finished))
	}

	/// Compat.GetQuestObjectives: nil for a quest out of the log or with no objectives.
	pub fn objectives(&self, q: u32) -> Option<&[Objective]> {
		self.log.get(&q).filter(|o| !o.is_empty()).map(|o| o.as_slice())
	}

	pub fn item_count(&self, item: u32) -> f64 {
		self.items.get(&item).copied().unwrap_or(0.0)
	}

	/// Compat.GetZoneText: zone and subzone, "" read as nil.
	pub fn zone_text(&self) -> (Option<&str>, Option<&str>) {
		let z = (!self.zone.is_empty()).then_some(self.zone.as_str());
		let s = (!self.subzone.is_empty()).then_some(self.subzone.as_str());
		(z, s)
	}

	/// Compat.GetBindLocation ("" as nil).
	pub fn bind_location(&self) -> Option<&str> {
		(!self.bind.is_empty()).then_some(self.bind.as_str())
	}

	/// Compat.GetSkillRank(line or name) -> rank, maxRank.
	pub fn skill_rank(&self, key: &str) -> Option<(f64, f64)> {
		self.skills.get(key).map(|s| (s.rank, s.max_rank))
	}

	/// stub_world worldOf: continent and world x/y of a live map position (0-1).
	fn world_of(&self, map: u32, mx: f64, my: f64) -> Option<(i64, f64, f64)> {
		let b = self.maps.get(&map)?;
		Some((b.c, b.top + (b.bottom - b.top) * my, b.left + (b.right - b.left) * mx))
	}

	/// Compat.MapToWorld(map, x, y, frame): Era frames for `f = "e"`, else the live map (percent).
	pub fn map_to_world(&self, map: u32, x: f64, y: f64, era: bool) -> Option<(i64, f64, f64)> {
		if era {
			let b = self.era.get(&map)?;
			return Some((b.c, b.top + (b.bottom - b.top) * y / 100.0, b.left + (b.right - b.left) * x / 100.0));
		}
		self.world_of(map, x / 100.0, y / 100.0)
	}

	/// Compat.GetPlayerMapPosition: nil at 0,0 or with no map.
	pub fn player_map_position(&self) -> Option<(u32, f64, f64)> {
		let map = self.map?;
		let (x, y) = (self.x / 100.0 * 100.0, self.y / 100.0 * 100.0);
		if x == 0.0 && y == 0.0 {
			return None;
		}
		Some((map, x, y))
	}

	/// Compat.GetPlayerWorldPosition.
	pub fn player_world(&self) -> Option<(i64, f64, f64)> {
		let (map, x, y) = self.player_map_position()?;
		self.map_to_world(map, x, y, false)
	}
}
