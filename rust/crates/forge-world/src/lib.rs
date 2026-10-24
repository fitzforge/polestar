//! Game data, prerequisites, solo filter, availability, camps, areas, the quest atlas, the world builder.
//!
//! Library API (no CLI): `World::from_json(bytes)` reads a world file as built (the one the
//! walks are keyed by); `World::load(dir, faction)` builds one faction's world from a
//! repository checkout; `GameData::from_source` + `build_world` do the same from any byte
//! source (wasm); `Rules` is the one availability rule; `Atlas::build(&world, &data)` the
//! per-zone quest atlas.

pub mod areas;
pub mod atlas;
pub mod build;
pub mod camps;
pub mod csv;
pub mod data;
pub mod floors;
pub mod from_json;
pub mod inputs;
pub mod json;
pub mod prereqs;
pub mod rules;
pub mod solo;
pub mod tour;
pub mod world;
pub mod zonelevels;

pub use atlas::Atlas;
pub use build::{build_world, BuildOptions, BUILDER_VERSION};
pub use data::{GameData, Source};
pub use floors::{FloorCache, Floors, NoFloors};
pub use prereqs::{blocking_prereqs, Blocking, ClosedBy};
pub use rules::Rules;
pub use world::World;

#[cfg(feature = "native")]
impl World {
	/// Builds `faction`'s world from a repository checkout at `root` (data/forever,
	/// data/sources, data/rules.json), heights from `floors` (the JS builder's
	/// floors cache, or NoFloors), with the input digests (`dataHash`, `inputs`) and the
	/// QuestXP table as getWorld records them.
	pub fn load_with(root: &std::path::Path, faction: forge_core::Faction, floors: &dyn Floors) -> Result<(World, GameData), data::Error> {
		let src = data::DirSource::repo(root);
		let d = GameData::from_source(&src)?;
		let (mut w, misses) = build_world(&d, &BuildOptions::new(faction), floors)?;
		// A floors cache built for other points would give those points no height (and other
		// point ids): fail rather than build a different world.
		if misses > 0 {
			return Err(format!("the floors source lacks {misses} places this world needs (a floors.json from a partial build?)").into());
		}
		let inputs = inputs::world_inputs(root)?;
		w.data_hash = Some(inputs::inputs_hash(&inputs));
		w.inputs = inputs;
		w.quest_xp = d.quest_xp.as_ref().map(|rows| serde_json::to_value(rows).unwrap_or_default()).unwrap_or(serde_json::Value::Null);
		Ok((w, d))
	}

	/// `World::load(dir, faction)`: as `load_with`, heights from `<dir>/data/sim/floors.json`
	/// when present (the JS world builder's cache of the walking grid's floors).
	pub fn load(root: &std::path::Path, faction: forge_core::Faction) -> Result<World, data::Error> {
		let file = root.join("data/sim/floors.json");
		let (w, _) = match std::fs::read(&file) {
			Ok(b) => World::load_with(root, faction, &FloorCache::from_json(&b)?)?,
			Err(_) => World::load_with(root, faction, &NoFloors)?,
		};
		Ok(w)
	}
}
