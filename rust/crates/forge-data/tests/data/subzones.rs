//! `forge data subzones` (#2244): the walking maps' areas named as the client names the subzone there, in
//! each language: the WMOAreaTable row's own name, else its AreaTable row's, written for the rows not named
//! as in English, from the cached client tables of the build the data is built from (data naming another
//! build stops it), and that build the one data/forever names.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use forge_data::subzones::{self, Options};

use crate::common::scratch;

fn root() -> PathBuf {
	PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn names(pairs: &[(i64, &str)]) -> BTreeMap<i64, String> {
	pairs.iter().map(|(id, n)| (*id, n.to_string())).collect()
}

fn rows(csv: &str) -> forge_data::jsv::Rows {
	forge_data::tables::parse_csv(csv).unwrap()
}

/// A walking maps folder: Nav0.lua and Nav1.lua name areas, Nav2991.lua none, a part file (never read).
fn walking_maps(dir: &Path) -> PathBuf {
	let nav = dir.join("Polestar_Nav/Nav");
	std::fs::create_dir_all(&nav).unwrap();
	std::fs::write(
		nav.join("Nav0.lua"),
		"-- Generated\nPolestarPathData = PolestarPathData or {}\nPolestarPathData[0] = {\n\tformat = 5,\n\tareaNames = {\n\t\t[11] = \"The Apothecarium\",\n\t\t[12] = \"Canals\",\n\t\t[13] = \"Ruins of Lordaeron\",\n\t\t[14] = \"The \\\"Quoted\\\" Hall\",\n\t},\n}\n",
	)
	.unwrap();
	std::fs::write(nav.join("Nav1.lua"), "PolestarPathData = PolestarPathData or {}\nPolestarPathData[1] = { format = 5, areaNames = { [21] = \"Thunder Bluff\" } }\n").unwrap();
	std::fs::write(nav.join("Nav2991.lua"), "PolestarPathData = PolestarPathData or {}\nPolestarPathData[2991] = { format = 2 }\n").unwrap();
	std::fs::write(nav.join("Nav0_1.lua"), "error(\"a part is never read\")\n").unwrap();
	nav
}

/// A data folder whose meta.json names the Forever client build it was built from, as the data build
/// writes it.
fn data_built_from(dir: &Path, build: &str) -> PathBuf {
	let data = dir.join(format!("data-{build}"));
	std::fs::create_dir_all(&data).unwrap();
	let meta = format!(
		r#"{{ "sources": [ {{ "name": "pfQuest", "revision": "104f356" }}, {{ "name": "World of Warcraft: Forever client tables (UiMap, UiMapAssignment, AreaTable)", "url": null, "revision": "wowf {build}" }} ] }}"#
	);
	std::fs::write(data.join("meta.json"), meta).unwrap();
	data
}

#[test]
fn the_data_s_pin_is_the_build_its_client_tables_source_names() {
	let s = scratch("subzones-pin");
	assert_eq!(subzones::data_pin(&data_built_from(&s, "1.60.1.70888")).as_deref(), Some("1.60.1.70888"));
	assert_eq!(subzones::data_pin(&s.join("no-data")), None, "no data: no pin");
}

// The names come from the client build the shipped data is built from: the const holds the build data/forever
// names (the guide compile's pinned-build check reads the same source), so a data build on a new client build
// asks for the subzone names to be rebuilt on it too.
#[test]
fn subzones_build_is_the_pinned_build_data_forever_is_built_from() {
	let data = root().join("data/forever");
	let Some(pin) = subzones::data_pin(&data) else {
		eprintln!("skipped: {} names no client build (no data built here)", data.display());
		return;
	};
	assert_eq!(subzones::BUILD, pin, "forge_data::subzones::BUILD is not the build data/forever is built from: set it to {pin} and run forge data subzones");
}

#[test]
fn the_walking_maps_areas_are_their_metadata_s_area_names_parts_and_maps_without_areas_aside() {
	let s = scratch("subzones-walking");
	let nav = walking_maps(&s);
	assert_eq!(subzones::walking_areas(&nav).unwrap(), names(&[(11, "The Apothecarium"), (12, "Canals"), (13, "Ruins of Lordaeron"), (14, "The \"Quoted\" Hall"), (21, "Thunder Bluff")]));
	let empty = s.join("empty");
	std::fs::create_dir_all(&empty).unwrap();
	assert!(subzones::walking_areas(&empty).unwrap_err().contains("forge nav pack"));
}

#[test]
fn a_row_is_named_by_its_own_name_else_its_area_table_row_s_untrimmed_as_the_client_shows_it() {
	let wmo = rows("AreaName_lang,ID,WMOID,AreaTableID\nEl Apothecarium,11,1,1497\n,12,1,1497\nTomo ,13,2,0\n,14,3,0\n,15,4,999\n");
	let areas = rows("ID,AreaName_lang\n1497,Entrañas\n");
	assert_eq!(subzones::subzone_names(&wmo, &areas), names(&[(11, "El Apothecarium"), (12, "Entrañas"), (13, "Tomo ")]), "no name of its own and no AreaTable name: none");
	let walking = names(&[(11, "The Apothecarium"), (12, "Undercity"), (13, "Tomo "), (16, "Not in the table")]);
	assert_eq!(
		subzones::translated(&walking, &subzones::subzone_names(&wmo, &areas)),
		names(&[(11, "El Apothecarium"), (12, "Entrañas")]),
		"the rows named as in English and those the table lacks are left out"
	);
}

/// The client tables of `build` in the cache: WMOAreaTable and AreaTable in English and the languages.
fn tables(cache: &Path, build: &str, locales: &[(&str, [&str; 5], &str)]) {
	let write = |locale: Option<&str>, wmo: [&str; 5], area: &str| {
		let mut dir = cache.join("wago").join(build);
		if let Some(l) = locale {
			dir = dir.join(l);
		}
		std::fs::create_dir_all(&dir).unwrap();
		let [a, b, c, d, e] = wmo;
		std::fs::write(dir.join("WMOAreaTable.csv"), format!("AreaName_lang,ID,WMOID,AreaTableID\n\"{a}\",11,1,1497\n\"{b}\",12,1,1497\n\"{c}\",13,1,1497\n\"{d}\",14,1,1497\n\"{e}\",21,2,1638\n"))
			.unwrap();
		std::fs::write(dir.join("AreaTable.csv"), format!("ID,AreaName_lang\n1497,Undercity\n1638,\"{area}\"\n")).unwrap();
	};
	write(None, ["The Apothecarium", "Canals", "Ruins of Lordaeron", "The \"\"Quoted\"\" Hall", ""], "Thunder Bluff");
	for (l, wmo, area) in locales {
		write(Some(l), *wmo, area);
	}
}

fn options(s: &Path, nav: PathBuf) -> Options {
	let mut o = Options::new(&root());
	o.offline = true;
	o.build = "1.60.1.9".into();
	o.sources = s.join("cache");
	o.data = data_built_from(s, "1.60.1.9");
	o.nav = nav;
	o.out = s.join("addon");
	o
}

/// A Subzones.lua's "<id>\t<name>" lines, unescaped (luachunks::field's %XX).
fn lines_of(lua: &str) -> Vec<(i64, String)> {
	let mut out = Vec::new();
	for line in lua.lines() {
		if let Some((id, name)) = line.split_once('\t') {
			let mut n = String::new();
			let mut it = name.chars();
			while let Some(c) = it.next() {
				if c == '%' {
					let hex: String = it.by_ref().take(2).collect();
					n.push(char::from_u32(u32::from_str_radix(&hex, 16).unwrap()).unwrap());
				} else {
					n.push(c);
				}
			}
			out.push((id.parse().unwrap(), n));
		}
	}
	out
}

#[test]
fn each_language_folder_gets_its_subzones_lua_and_the_shared_toc_at_the_data_s_build_offline_from_the_cache() {
	let s = scratch("subzones-run");
	let nav = walking_maps(&s);
	tables(
		&s.join("cache"),
		"1.60.1.9",
		&[
			("esMX", ["El Apothecarium", "Canales", "Ruinas de Lordaeron", "La sala \"\"citada\"\", 1", ""], "Cima del Trueno"),
			("deDE", ["Das Apothekarium", "Die Kanäle", "Die Ruinen von Lordaeron", "Die Halle", ""], "Donnerfels"),
			("ruRU", ["Квартал аптекарей", "Каналы", "Руины Лордерона", "Зал", ""], "Громовой Утес"),
			("zhCN", ["炼金房", "运河", "洛丹伦废墟", "大厅", ""], "雷霆崖"),
			("frFR", ["The Apothecarium", "Canals", "Ruins of Lordaeron", "The \"\"Quoted\"\" Hall", ""], "Thunder Bluff"),
		],
	);
	// A stale file of a language now named as in English goes.
	std::fs::create_dir_all(s.join("addon/Polestar_frFR")).unwrap();
	std::fs::write(s.join("addon/Polestar_frFR/Subzones.lua"), "stale").unwrap();
	let mut o = options(&s, nav.clone());
	o.locales = ["esMX", "deDE", "ruRU", "zhCN", "frFR"].map(String::from).to_vec();
	let r = subzones::run(&o, &|_| {}).unwrap();
	assert_eq!(r.build, "1.60.1.9", "the data's build");
	assert_eq!((r.areas, r.english_differs), (5, 0));
	let read = |l: &str| std::fs::read_to_string(s.join(format!("addon/Polestar_{l}/Subzones.lua"))).unwrap();
	let es = read("esMX");
	assert!(es.starts_with("-- Generated by `forge data subzones` from the client's WMOAreaTable and AreaTable (1.60.1.9, wago.tools)"), "{es}");
	assert!(es.contains("N.AddChunk(\"esMX\", kind, lo, hi, text)") && es.contains("R(\"subzone\", 11, 21, [["), "{es}");
	assert_eq!(
		lines_of(&es),
		[(11, "El Apothecarium"), (12, "Canales"), (13, "Ruinas de Lordaeron"), (14, "La sala \"citada\", 1"), (21, "Cima del Trueno")].map(|(i, n)| (i, n.to_string())).to_vec()
	);
	assert_eq!(lines_of(&read("deDE"))[0], (11, "Das Apothekarium".to_string()));
	assert_eq!(lines_of(&read("ruRU"))[0], (11, "Квартал аптекарей".to_string()));
	assert_eq!(lines_of(&read("zhCN"))[4], (21, "雷霆崖".to_string()), "a row without a name of its own: its AreaTable row's");
	assert!(!s.join("addon/Polestar_frFR/Subzones.lua").exists(), "every area named as in English: no file");
	let toc = std::fs::read_to_string(s.join("addon/Polestar_esMX/Polestar_esMX.toc")).unwrap();
	let meta = forge_data::names::meta(&root()).unwrap();
	assert_eq!(toc, forge_guide::toc::language_toc("esMX", &meta.iface, &meta.version), "the language folder's TOC, as the other writers write it");
	assert!(toc.lines().any(|l| l == "Subzones.lua"));
	// Again: the same bytes.
	subzones::run(&o, &|_| {}).unwrap();
	assert_eq!(read("esMX"), es);
	// Data built from another client build: an error naming both, and nothing written.
	o.data = data_built_from(&s, "1.60.1.8");
	std::fs::remove_dir_all(s.join("addon")).unwrap();
	let e = subzones::run(&o, &|_| {}).err().unwrap();
	assert!(e.contains("built from Forever client build 1.60.1.8") && e.contains("would come from 1.60.1.9"), "{e}");
	assert!(!s.join("addon").exists(), "nothing written");
	// No data pin and a build whose tables are not cached, offline: an error naming the missing table.
	o.data = s.join("no-data");
	o.build = "1.60.1.7".into();
	assert!(subzones::run(&o, &|_| {}).err().unwrap().contains("--offline: missing cached"));
}
