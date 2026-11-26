//! `forge data maps art`: the committed Dungeons/ArtFiles.lua gives every Classic dungeon and raid its own
//! loading screen, and no instance that wears a continent's screen one.

use std::collections::BTreeMap;

/// The committed table: kind ("wide" | "narrow") -> map id -> file id.
fn committed() -> BTreeMap<String, BTreeMap<i64, i64>> {
	let text = std::fs::read_to_string(super::fixture_build::repo().join("addon/Polestar/Dungeons/ArtFiles.lua")).unwrap();
	let mut out: BTreeMap<String, BTreeMap<i64, i64>> = BTreeMap::new();
	let mut kind = String::new();
	for line in text.lines() {
		if let Some(k) = line.strip_prefix('\t').and_then(|l| l.strip_suffix(" = {")).filter(|k| !k.starts_with('\t')) {
			kind = k.to_string();
			out.entry(kind.clone()).or_default();
		} else if let Some(rest) = line.strip_prefix("\t\t[") {
			let (map, rest) = rest.split_once("] = ").unwrap();
			let (file, _) = rest.split_once(',').unwrap();
			out.get_mut(&kind).unwrap().insert(map.parse().unwrap(), file.parse().unwrap());
		}
	}
	out
}

// The Classic Era's dungeons and raids, by instance Map id.
const CLASSIC: [(i64, &str); 26] = [
	(33, "Shadowfang Keep"),
	(34, "The Stockade"),
	(36, "The Deadmines"),
	(43, "Wailing Caverns"),
	(47, "Razorfen Kraul"),
	(48, "Blackfathom Deeps"),
	(70, "Uldaman"),
	(90, "Gnomeregan"),
	(109, "The Temple of Atal'Hakkar"),
	(129, "Razorfen Downs"),
	(189, "Scarlet Monastery"),
	(209, "Zul'Farrak"),
	(229, "Blackrock Spire"),
	(230, "Blackrock Depths"),
	(249, "Onyxia's Lair"),
	(289, "Scholomance"),
	(309, "Zul'Gurub"),
	(329, "Stratholme"),
	(349, "Maraudon"),
	(389, "Ragefire Chasm"),
	(409, "Molten Core"),
	(429, "Dire Maul"),
	(469, "Blackwing Lair"),
	(509, "Ruins of Ahn'Qiraj"),
	(531, "Temple of Ahn'Qiraj"),
	(533, "Naxxramas"),
];

// Instance maps on a continent's own screen (Kalimdor's, Eastern Kingdoms') or on none: no picture of their own.
const GENERIC: [(i64, &str); 8] = [
	(169, "Emerald Dream"),
	(269, "Caverns of Time"),
	(2720, "The Searing Basin"),
	(2806, "Shadow Hold"),
	(2817, "Starfall Barrow Den"),
	(2853, "Deadwind Pass"),
	(2902, "The Scarab Dais"),
	(3109, "Manor Mistmantle"),
];

// Forever's own dungeons: its 16:9 screens (the last five from encrypted client rows, pinned in dungeon_art.rs).
const FOREVER: [(i64, &str); 9] = [
	(2959, "City of Dalaran"),
	(2970, "The Drowned City"),
	(2974, "Blackmaw Hold"),
	(2994, "Alcaz Prison"),
	(2998, "Excavation Site: Wetlands"),
	(2999, "Ruins of Lordaeron"),
	(3001, "The Shaper's Terrace"),
	(3039, "Krol'dok Stronghold"),
	(3065, "The Hall of Thanes"),
];

#[test]
fn every_classic_dungeon_and_raid_has_a_loading_screen_and_the_continent_ones_have_none() {
	let art = committed();
	let (wide, narrow) = (&art["wide"], &art["narrow"]);
	for (map, name) in CLASSIC {
		assert!(narrow.get(&map).is_some_and(|f| *f > 0), "{name} ({map}): a Classic screen");
		assert!(!wide.contains_key(&map), "{name} ({map}) is no wide screen");
	}
	for (map, name) in FOREVER {
		assert!(wide.get(&map).is_some_and(|f| *f > 0), "{name} ({map}): a Forever screen");
		assert!(!narrow.contains_key(&map), "{name} ({map}) is no narrow screen");
	}
	for (map, name) in GENERIC {
		assert!(!wide.contains_key(&map) && !narrow.contains_key(&map), "{name} ({map}) wears a continent's screen: no picture of its own");
	}
	// The Classic screens are the client's own 131xxx files; Naxxramas' two maps share theirs.
	assert!(CLASSIC.iter().all(|(m, _)| (131_800..131_900).contains(&narrow[m])));
	assert_eq!(narrow[&533], narrow[&2921]);
}

#[test]
#[ignore = "needs the pinned Map and LoadingScreens tables cached (FORGE_SOURCES or <checkout>/data/sources; `forge data sources --only builders` fills it)"]
fn art_files_lua_is_up_to_date() {
	let repo = super::fixture_build::repo();
	let sources = std::env::var_os("FORGE_SOURCES").map(std::path::PathBuf::from).unwrap_or_else(|| repo.join("data/sources"));
	let (map, screens) = forge_data::dungeon_art::tables(&sources, forge_data::dungeon_art::BUILD, true, &|_| {}).unwrap();
	let art = forge_data::dungeon_art::build(&map, &screens);
	assert_eq!(art.warnings, Vec::<String>::new());
	assert_eq!(std::fs::read_to_string(repo.join("addon/Polestar/Dungeons/ArtFiles.lua")).unwrap(), forge_data::dungeon_art::emit(&art, forge_data::dungeon_art::BUILD), "run: forge data maps art");
	assert_eq!(art.generic.iter().map(|g| g.0).collect::<Vec<_>>(), GENERIC.iter().map(|g| g.0).collect::<Vec<_>>());
}
