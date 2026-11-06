//! The level fit (level_fit.rs, #977) on a round's real routes: what it moves and leaves out per start.
//! Ignored: needs `POLESTAR_V1` (a checkout with data/forever) and `LEVEL_FIT_ROUND` (a round's `out`
//! folder with routes/ and world/). Prints one line per decision; `LEVEL_FIT_OUT` writes them as JSON.

use forge_core::frames::MapFrames;
use forge_writer::input::{Data, Route, World};
use forge_writer::native::read_json;
use std::path::PathBuf;

const STARTS: [(&str, &str); 10] = [
	("Human", "alliance"),
	("Dwarf", "alliance"),
	("Gnome", "alliance"),
	("NightElf", "alliance"),
	("Skyborne-alliance", "alliance"),
	("Orc", "horde"),
	("Troll", "horde"),
	("Tauren", "horde"),
	("Undead", "horde"),
	("Skyborne-horde", "horde"),
];

#[test]
#[ignore = "needs POLESTAR_V1 and LEVEL_FIT_ROUND"]
fn level_fit_on_a_rounds_routes() {
	let (Ok(v1), Ok(round)) = (std::env::var("POLESTAR_V1"), std::env::var("LEVEL_FIT_ROUND")) else {
		eprintln!("POLESTAR_V1 or LEVEL_FIT_ROUND unset: skipped");
		return;
	};
	let root = PathBuf::from(v1);
	let round = PathBuf::from(round);
	let dir = root.join("data/forever");
	let data = Data {
		quests: read_json(&dir.join("quests.json")).unwrap(),
		npcs: read_json(&dir.join("npcs.json")).unwrap(),
		objects: read_json(&dir.join("objects.json")).unwrap(),
		items: read_json(&dir.join("items.json")).unwrap(),
		zones: read_json(&dir.join("zones.json")).unwrap(),
	};
	let frames = MapFrames::from_json(&std::fs::read(dir.join("map-frames.json")).unwrap()).unwrap();
	let checkout = std::env::var("LEVEL_FIT_CHECKOUT").map_or_else(|_| PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../.."), PathBuf::from);
	if forge_sim::fixes::path().is_none() {
		forge_sim::fixes::load_for(&[&checkout]).unwrap();
	}
	let mut all = serde_json::Map::new();
	let mut redridge = Vec::new();
	for (start, fac) in STARTS {
		let route: Route = read_json(&round.join(format!("routes/{start}.json"))).unwrap();
		let world: World = read_json(&round.join(format!("world/world-{fac}.json"))).unwrap();
		let mut ex = forge_writer::level_fit::Exempt::default();
		ex.quests.extend(route.groups.iter().filter_map(|g| g.q).chain(route.groups.iter().flat_map(|g| g.quests.iter().copied())));
		ex.quests.extend(forge_writer::hub::fix_optional(route.faction.as_deref()));
		ex.quests.extend(forge_writer::hub::fix_kept(route.faction.as_deref()));
		let fit = forge_writer::level_fit::fit(route.order.clone(), &world, &data, &frames, &ex);
		for l in &fit.log {
			println!("{start}: {l}");
		}
		if start == "Human" {
			redridge = fit.left_out.clone();
		}
		all.insert(start.into(), serde_json::json!({ "log": fit.log, "leftOut": fit.left_out }));
	}
	if let Ok(out) = std::env::var("LEVEL_FIT_OUT") {
		std::fs::write(out, serde_json::to_string_pretty(&all).unwrap()).unwrap();
	}
	// Fyurie's Redridge (#977): Fangore and the Galardell pendants are out of the Alliance route.
	assert!(redridge.contains(&180) && redridge.contains(&91), "{redridge:?}");
}
