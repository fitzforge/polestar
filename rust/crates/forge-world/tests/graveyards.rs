//! The graveyard table (World::graveyards, forge-sim's deathskips) and the game's rule for where a
//! death sends a character (World::graveyard_for), on the golden slice (Durotar, the Barrens,
//! Orgrimmar, Elwynn Forest, Stormwind) with its cut of CMaNGOS's graveyards.

use forge_core::Faction;
use forge_world::world::Point;
use forge_world::{NoFloors, World};
use std::path::PathBuf;

fn slice(f: Faction) -> World {
	let root = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../tests/golden/world/root");
	World::load_with(&root, f, &NoFloors).expect("slice world").0
}

fn names(w: &World) -> Vec<&str> {
	w.graveyards.iter().map(|g| g.name.as_str()).collect()
}

fn named<'a>(w: &'a World, name: &str) -> &'a forge_world::world::Graveyard {
	w.graveyards.iter().find(|g| g.name == name).unwrap_or_else(|| panic!("no {name} in {:?}", names(w)))
}

fn gy<'a>(w: &'a World, p: &Point) -> Option<&'a str> {
	w.graveyard_for(p).map(|i| w.graveyards[i].name.as_str())
}

#[test]
fn each_faction_gets_the_graveyards_its_zones_link_and_a_spirit_healer_stands_at() {
	let (h, a) = (slice(Faction::Horde), slice(Faction::Alliance));
	// Durotar's: Razor Hill for everyone, the other three the Horde's only.
	for n in ["Razor Hill", "Sen'jin Village", "Valley of Trials", "Northern Durotar", "The Crossroads"] {
		named(&h, n);
	}
	for n in ["Sen'jin Village", "Valley of Trials", "Northern Durotar", "The Crossroads"] {
		assert!(!names(&a).contains(&n), "{n} is the Horde's: {:?}", names(&a));
	}
	named(&a, "Razor Hill");
	named(&a, "Northshire");
	assert!(!names(&h).contains(&"Northshire"), "Northshire is the Alliance's");
	// Stormwind's graveyard has no Spirit Healer of its own (its ghosts walk out to Elwynn's).
	assert!(!names(&a).contains(&"Stormwind"), "{:?}", names(&a));
	for w in [&h, &a] {
		for g in &w.graveyards {
			let p = &w.points[g.pt as usize];
			assert!(p.c == g.loc.0 && (p.wx - g.loc.1).hypot(p.wy - g.loc.2) <= 100.0, "{}: its Spirit Healer stands by it", g.name);
			assert!(!g.maps.is_empty());
		}
	}
	// Durotar (1411) sends deaths to Razor Hill for both factions.
	assert!(named(&h, "Razor Hill").maps.contains(&1411) && named(&a, "Razor Hill").maps.contains(&1411));
}

#[test]
fn a_death_goes_to_the_nearest_graveyard_its_zone_links_for_the_faction() {
	let (h, a) = (slice(Faction::Horde), slice(Faction::Alliance));
	let at = |w: &World, name: &str| -> Point { w.points[named(w, name).pt as usize] };
	let valley = at(&h, "Valley of Trials");
	assert_eq!(gy(&h, &valley), Some("Valley of Trials"));
	assert_eq!(gy(&a, &valley), Some("Razor Hill"));
	assert_eq!(gy(&h, &at(&h, "Sen'jin Village")), Some("Sen'jin Village"));
	// Nearest, not the first linked: just short of Razor Hill toward Sen'jin, still Razor Hill.
	let (r, s) = (at(&h, "Razor Hill"), at(&h, "Sen'jin Village"));
	let mut p = r;
	p.wx += (s.wx - r.wx) * 0.4;
	p.wy += (s.wy - r.wy) * 0.4;
	assert_eq!(gy(&h, &p), Some("Razor Hill"));
	p.wx = r.wx + (s.wx - r.wx) * 0.6;
	p.wy = r.wy + (s.wy - r.wy) * 0.6;
	assert_eq!(gy(&h, &p), Some("Sen'jin Village"));
	// Another continent, or a zone no graveyard links: none.
	let mut far = valley;
	far.c = 0;
	assert_eq!(gy(&h, &far), None);
	let mut nowhere = valley;
	nowhere.map = 9999;
	assert_eq!(gy(&h, &nowhere), None);
}

#[test]
fn the_world_file_keeps_its_graveyards() {
	let h = slice(Faction::Horde);
	let back = World::from_json(h.to_json().as_bytes()).unwrap();
	assert_eq!(back.graveyards, h.graveyards);
	assert!(h.to_json().contains("\"graveyards\":[{\"id\":"));
}
