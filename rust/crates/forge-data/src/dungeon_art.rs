//! `forge data maps art` (addon/Polestar/Dungeons/ArtFiles.lua): each dungeon's and raid's own
//! loading screen, the picture the client shows on the way in, as the file id of its texture.
//!
//! Map.LoadingScreenID names a row of LoadingScreens, whose columns hold the files:
//!   MainImageFileDataID     Forever's own screens: 2992x1684 (16:9), the painting in rows 266-1418
//!   NarrowScreenFileDataID  Classic's: a 4:3 screen stored in a square texture (logo band above the
//!                           painting, parchment below)
//!   WideScreenFileDataID, WideScreenFileDataID169   0 on every instance screen of the build
//! An instance map (Map.InstanceType 1 dungeon, 2 raid) wears its own screen, or the screen of the
//! continent it lies on (Kalimdor's and Eastern Kingdoms', or none): those it shares with an
//! open-world map are left out, and so are the client's test and unused maps. A map whose screen
//! has only a wide file in the two Wide columns is left out too (their frame is unknown) with a
//! warning.

use std::collections::BTreeMap;

use rustc_hash::{FxHashMap, FxHashSet};

use crate::jsv::{col_num, col_str, Row, Rows};

/// The Forever client build the screens are read from.
pub const BUILD: &str = "1.60.1.70532";
pub const TABLES: [&str; 2] = ["Map", "LoadingScreens"];

/// Forever's own dungeons whose Map and LoadingScreens rows the client keeps encrypted (TACT keys we
/// do not hold): (map id, MainImageFileDataID, name). Their screens were found by name among the
/// loading screens' files and checked by eye (2992x1684 each). Dropped for a map the tables hold.
const PINNED: [(i64, i64, &str); 5] =
	[(2970, 7963741, "The Drowned City"), (2974, 7963784, "Blackmaw Hold"), (2994, 7963734, "Alcaz Prison"), (3001, 7963783, "The Shaper's Terrace"), (3039, 7963780, "Krol'dok Stronghold")];

pub struct Screen {
	pub map: i64,
	pub file: i64,
	pub name: String,
}

#[derive(Default)]
pub struct Art {
	/// MainImageFileDataID screens, by map id.
	pub wide: Vec<Screen>,
	/// NarrowScreenFileDataID screens, by map id.
	pub narrow: Vec<Screen>,
	/// Instance maps on a continent's screen or none: (map id, name).
	pub generic: Vec<(i64, String)>,
	pub warnings: Vec<String>,
}

fn int(r: &Row, c: &str) -> i64 {
	let n = col_num(r, c);
	if n.is_finite() {
		n as i64
	} else {
		0
	}
}

/// A client test map or one the client marks unused.
fn is_scrap(r: &Row) -> bool {
	col_str(r, "MapName_lang").starts_with("<unused>") || col_str(r, "Directory").to_ascii_lowercase().starts_with("test")
}

pub fn build(map: &[Row], screens: &[Row]) -> Art {
	let by_id: FxHashMap<i64, &Row> = screens.iter().map(|r| (int(r, "ID"), r)).collect();
	// The screens of the open world (InstanceType 0), 0 (none) with them.
	let world: FxHashSet<i64> = map.iter().filter(|r| int(r, "InstanceType") == 0).map(|r| int(r, "LoadingScreenID")).chain([0]).collect();
	let mut art = Art::default();
	let mut wide: BTreeMap<i64, Screen> = BTreeMap::new();
	let mut narrow: BTreeMap<i64, Screen> = BTreeMap::new();
	let mut generic: BTreeMap<i64, String> = BTreeMap::new();
	for r in map {
		let kind = int(r, "InstanceType");
		let (id, name) = (int(r, "ID"), col_str(r, "MapName_lang").replace('\n', " "));
		if !(kind == 1 || kind == 2) || is_scrap(r) {
			continue;
		}
		let ls = int(r, "LoadingScreenID");
		if world.contains(&ls) {
			generic.insert(id, name);
			continue;
		}
		let Some(s) = by_id.get(&ls) else {
			art.warnings.push(format!("map {id} ({name}): no LoadingScreens row {ls}; left out"));
			continue;
		};
		let (main, small) = (int(s, "MainImageFileDataID"), int(s, "NarrowScreenFileDataID"));
		if main != 0 {
			wide.insert(id, Screen { map: id, file: main, name });
		} else if small != 0 {
			narrow.insert(id, Screen { map: id, file: small, name });
		} else {
			art.warnings.push(format!("map {id} ({name}): screen {ls} has only WideScreen files; left out"));
		}
	}
	let rows: FxHashSet<i64> = map.iter().map(|r| int(r, "ID")).collect();
	for (id, file, name) in PINNED {
		if rows.contains(&id) {
			art.warnings.push(format!("map {id} ({name}) is in the Map table now: drop it from PINNED"));
		} else {
			wide.insert(id, Screen { map: id, file, name: name.to_string() });
		}
	}
	art.wide = wide.into_values().collect();
	art.narrow = narrow.into_values().collect();
	art.generic = generic.into_iter().collect();
	art
}

pub fn emit(a: &Art, build: &str) -> String {
	let mut l = vec![
		forge_guide::emit::header("lua", "forge data maps art", "the client's Map and LoadingScreens tables"),
		"-- Each dungeon's and raid's own loading screen, the picture the client shows on the way in,".into(),
		format!("-- by instance Map id (Map.LoadingScreenID -> LoadingScreens; build {build} via wago.tools;"),
		"-- rust/crates/forge-data/src/dungeon_art.rs). File IDs only: the textures are the player's own".into(),
		"-- client files. An instance on a continent's own screen is left out: it has none of its own.".into(),
		"--   wide    Forever's screens: 16:9 files with the painting between black bars".into(),
		"--   narrow  Classic's screens: a 4:3 picture stored in a square texture, framed by the logo and parchment".into(),
		String::new(),
		"local ADDON, ns = ...".into(),
		"local Dungeons = ns.Dungeons".into(),
		String::new(),
		"Dungeons.ArtFiles = {".into(),
	];
	for (kind, list) in [("wide", &a.wide), ("narrow", &a.narrow)] {
		l.push(format!("\t{kind} = {{"));
		for s in list {
			l.push(format!("\t\t[{}] = {}, -- {}", s.map, s.file, s.name));
		}
		l.push("\t},".into());
	}
	l.push("}".into());
	l.push(String::new());
	l.join("\n")
}

/// The Map and LoadingScreens tables of `build` (fetched when missing unless `offline`).
pub fn tables(sources: &std::path::Path, build: &str, offline: bool, log: &dyn Fn(&str)) -> Result<(Rows, Rows), String> {
	let (_, mut t, _) = crate::sources::client_tables(sources, &crate::tables::FOREVER, Some(build), &TABLES, offline, log)?;
	let screens = t.pop().map(|x| x.1).unwrap_or_default();
	let map = t.pop().map(|x| x.1).unwrap_or_default();
	Ok((map, screens))
}

#[cfg(test)]
mod tests {
	use super::*;

	fn rows(header: &str, lines: &[&str]) -> Rows {
		crate::tables::parse_csv(&format!("{header}\n{}\n", lines.join("\n"))).unwrap()
	}

	#[test]
	fn instance_maps_wear_their_own_screen_and_the_continents_are_left_out() {
		let map = rows(
			"ID,Directory,MapName_lang,InstanceType,LoadingScreenID",
			&[
				"0,Azeroth,Eastern Kingdoms,0,4",
				"1,Kalimdor,Kalimdor,0,3",
				"36,DeadminesInstance,Deadmines,1,142",
				"409,MoltenCore,Molten Core,2,192",
				"2959,2959,City of Dalaran,1,647",
				"2720,2720,The Searing Basin,1,4",
				"2902,2902,The Scarab Dais,1,0",
				"13,test,Test Dungeon,1,142",
				"44,MonasteryInstances,<unused> Monastery,1,142",
				"2999,2999,Ruins of Lordaeron,1,650",
				"3050,3050,Wide Only,1,651",
				"3100,3100,Missing Row,1,999",
			],
		);
		let screens = rows(
			"ID,NarrowScreenFileDataID,WideScreenFileDataID,WideScreen169FileDataID,LoadingScreenSkinID,MainImageFileDataID",
			&["142,131833,0,0,0,0", "192,131851,0,0,0,0", "647,0,0,0,11,7963775", "650,0,0,0,11,7963782", "651,0,5,6,0,0"],
		);
		let a = build(&map, &screens);
		let list = |v: &[Screen]| v.iter().map(|s| (s.map, s.file)).collect::<Vec<_>>();
		assert_eq!(list(&a.narrow), vec![(36, 131833), (409, 131851)]);
		assert_eq!(list(&a.wide).iter().map(|s| s.0).collect::<Vec<_>>(), vec![2959, 2970, 2974, 2994, 2999, 3001, 3039], "Forever's own screens are the wide ones, the five pinned maps among them");
		assert_eq!(list(&a.wide)[0], (2959, 7963775));
		assert_eq!(a.generic, vec![(2720, "The Searing Basin".to_string()), (2902, "The Scarab Dais".to_string())]);
		assert_eq!(a.warnings, vec!["map 3050 (Wide Only): screen 651 has only WideScreen files; left out", "map 3100 (Missing Row): no LoadingScreens row 999; left out"]);
	}

	#[test]
	fn a_pinned_map_the_table_holds_is_not_pinned_again() {
		let map = rows("ID,Directory,MapName_lang,InstanceType,LoadingScreenID", &["2974,2974,Blackmaw Hold,1,700"]);
		let screens = rows("ID,NarrowScreenFileDataID,WideScreenFileDataID,WideScreen169FileDataID,LoadingScreenSkinID,MainImageFileDataID", &["700,0,0,0,0,1234"]);
		let a = build(&map, &screens);
		assert_eq!(a.wide.iter().find(|s| s.map == 2974).map(|s| s.file), Some(1234));
		assert_eq!(a.warnings, vec!["map 2974 (Blackmaw Hold) is in the Map table now: drop it from PINNED"]);
	}

	#[test]
	fn the_lua_lists_each_kind_by_map_id() {
		let a = Art { wide: vec![Screen { map: 2959, file: 7963775, name: "City of Dalaran".into() }], narrow: vec![Screen { map: 36, file: 131833, name: "Deadmines".into() }], ..Default::default() };
		let lua = emit(&a, "1.60.1.70532");
		assert!(lua.starts_with("-- Generated by `forge data maps art`"), "{lua}");
		assert!(lua.contains("Dungeons.ArtFiles = {\n\twide = {\n\t\t[2959] = 7963775, -- City of Dalaran\n\t},\n\tnarrow = {\n\t\t[36] = 131833, -- Deadmines\n\t},\n}\n"), "{lua}");
	}
}
