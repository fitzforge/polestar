//! Shared types: ids, positions, map frames, race/class masks, content keys, JS-compatible number formatting.

pub mod cells;
pub mod frames;
pub mod jsnum;
pub mod key;
pub mod luachunks;
pub mod races;

pub use cells::{cell_key, cell_xy, ZONE_CELL};
pub use frames::{dist, seg_dist, Bounds, Frame, MapFrames, Projector, RoutePoint, FAR};
pub use jsnum::{js_hypot, js_hypot_n, js_round, js_to_fixed, js_to_string, round1, round2};
pub use key::{content_key, ContentHasher};
pub use races::{class_by_file, class_label, has_bit, race_by_file, race_label, ClassInfo, Faction, RaceInfo, ALL_CLASSES, CLASSES, RACES};

/// A quest id (quests.json key).
pub type QuestId = u32;
/// A creature id (npcs.json key).
pub type NpcId = u32;
/// A gameobject id (objects.json key).
pub type ObjectId = u32;
/// An item id (items.json key).
pub type ItemId = u32;
/// A UiMap id (zones.json / map-frames.json key).
pub type MapId = u32;
/// An AreaTable id.
pub type AreaId = u32;
/// An instance map ("continent"): 0 Eastern Kingdoms, 1 Kalimdor, 2991/2997 Forever islands;
/// negative for the fallback frame of a map without bounds (`-map`).
pub type Continent = i64;
