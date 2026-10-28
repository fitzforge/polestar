//! The build's data stage reads the Forever client tables at the grid's build, never whatever client
//! is installed (October 2026: the beta client was uninstalled, the data stage asked the client for
//! it, and the zones and map frames quietly fell back to Classic Era's: 99 zones instead of 60,
//! Zephras Isle gone).

use forge::{forever_tables, grid_build, ForeverTables};
use forge_data::tables::{self, Source};
use std::path::{Path, PathBuf};

fn temp(name: &str) -> PathBuf {
	let d = std::env::temp_dir().join(format!("forge-data-forever-{name}-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

fn put(dir: &Path, files: &[(&str, &str)]) {
	std::fs::create_dir_all(dir).unwrap();
	for (n, t) in files {
		std::fs::write(dir.join(n), t).unwrap();
	}
}

const MAPS: [(&str, &str); 3] = [
	("UiMap.csv", "ID,Name_lang,ParentUiMapID\n2665,Zephras Isle,1414\n"),
	("UiMapAssignment.csv", "ID,UiMapID\n1,2665\n"),
	("AreaTable.csv", "ID,AreaName_lang\n1,Zephras Isle\n"),
];

fn save(sources: &Path, build: &str, product: &str) {
	let dir = tables::saved_root(sources).join(build);
	put(&dir, &MAPS);
	put(&dir, &[(tables::SAVED_RECORD, &format!("{{\"product\": \"{product}\", \"build\": \"{build}\"}}"))]);
}

#[test]
fn the_saved_tables_of_the_grids_build_are_read() {
	let sources = temp("saved");
	save(&sources, "1.60.1.70532", "wow_classic_beta");
	save(&sources, "1.60.1.70630", "wowf");
	let (src, b) = forever_tables(ForeverTables::Saved, &sources, "1.60.1.70532", None, false, &|_| {}).unwrap();
	assert!(matches!(src, Source::Saved) && b == "1.60.1.70532", "{b}");
	let said = std::cell::RefCell::new(Vec::new());
	let f = tables::load(&sources, &tables::FOREVER_SIM, Some(&b), &src, &|m| said.borrow_mut().push(m.to_string())).unwrap();
	assert_eq!((f.product.as_str(), f.build.as_str(), f.saved, f.from_client), ("wow_classic_beta", "1.60.1.70532", true, true));
	assert_eq!(f.get("UiMap").unwrap()[0]["Name_lang"], "Zephras Isle");
	assert!(said.borrow().iter().any(|m| m.contains("wow_classic_beta 1.60.1.70532") && m.contains("client-tables")), "{said:?}");
	let _ = std::fs::remove_dir_all(&sources);
}

#[test]
fn another_build_than_the_grids_stops_the_build_unless_allowed() {
	let sources = temp("mismatch");
	save(&sources, "1.60.1.70630", "wowf");
	let e = forever_tables(ForeverTables::Saved, &sources, "1.60.1.70532", None, false, &|_| {}).unwrap_err();
	assert!(e.contains("grid's build 1.60.1.70532") && e.contains("saved: 1.60.1.70630") && e.contains("--forever-tables client") && e.contains("--allow-build-mismatch"), "{e}");
	let (_, b) = forever_tables(ForeverTables::Saved, &sources, "1.60.1.70532", None, true, &|_| {}).unwrap();
	assert_eq!(b, "1.60.1.70630");
	// The wago.tools cache: the grid's build only, unless allowed.
	put(&sources.join("wago/1.60.1.70450"), &MAPS);
	let e = forever_tables(ForeverTables::Wago, &sources, "1.60.1.70532", None, false, &|_| {}).unwrap_err();
	assert!(e.contains("wago/1.60.1.70532") && e.contains("--allow-build-mismatch to read 1.60.1.70450"), "{e}");
	let (src, b) = forever_tables(ForeverTables::Wago, &sources, "1.60.1.70532", None, true, &|_| {}).unwrap();
	assert!(matches!(src, Source::Wago) && b == "1.60.1.70450");
	// A saved copy whose record names another build is refused.
	put(&tables::saved_root(&sources).join("1.60.1.70532"), &MAPS);
	put(&tables::saved_root(&sources).join("1.60.1.70532"), &[(tables::SAVED_RECORD, "{\"product\": \"wowf\", \"build\": \"1.60.1.70630\"}")]);
	let e = tables::load(&sources, &tables::FOREVER_SIM, Some("1.60.1.70532"), &Source::Saved, &|_| {}).err().unwrap();
	assert!(e.contains("names build"), "{e}");
	let _ = std::fs::remove_dir_all(&sources);
}

#[test]
fn a_client_refresh_needs_a_forever_client_at_the_grids_build() {
	let sources = temp("client");
	std::fs::create_dir_all(sources.join("wowdbdefs/definitions")).unwrap();
	let e = forever_tables(ForeverTables::Client, &sources, "1.60.1.70532", None, false, &|_| {}).unwrap_err();
	assert!(e.contains("no World of Warcraft folder"), "{e}");
	let wow = temp("client-wow");
	std::fs::write(
		wow.join(".build.info"),
		"Branch!STRING:0|Active!DEC:1|Build Key!HEX:16|CDN Key!HEX:16|Install Key!HEX:16|IM Size!DEC:4|CDN Path!STRING:0|CDN Hosts!STRING:0|CDN Servers!STRING:0|Tags!STRING:0|Armadillo!STRING:0|Last Activated!STRING:0|Version!STRING:0|KeyRing!HEX:16|Product!STRING:0\n\
		 eu|1|644ffedb0d59bb0da2af9011b36f44db|0a08751bdd80706c48e4d099557fa853|||tpr/wow||||||1.60.1.70630||wowf\n",
	)
	.unwrap();
	let e = forever_tables(ForeverTables::Client, &sources, "1.60.1.70532", Some(&wow), false, &|_| {}).unwrap_err();
	assert!(e.contains("has wowf 1.60.1.70630, not the grid's build 1.60.1.70532") && e.contains("--allow-build-mismatch"), "{e}");
	let _ = std::fs::remove_dir_all(&sources);
	let _ = std::fs::remove_dir_all(&wow);
}

#[test]
fn the_grids_build_is_its_index() {
	let grid = temp("grid");
	std::fs::write(grid.join("index.json"), r#"{"schema":1,"version":4,"product":"wow_classic_beta","build":"1.60.1.70532"}"#).unwrap();
	assert_eq!(grid_build(&grid).unwrap(), ("wow_classic_beta".to_string(), "1.60.1.70532".to_string()));
	assert!(grid_build(&grid.join("none")).is_err());
	let _ = std::fs::remove_dir_all(&grid);
}
