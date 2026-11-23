//! Which Forever product a game folder's `.build.info` gives: the live client `wowf` first, the
//! old beta `wow_classic_beta` only without it, none when neither is installed.

use std::path::PathBuf;

const HEAD: &str = "Branch!STRING:0|Active!DEC:1|Build Key!HEX:16|CDN Key!HEX:16|Install Key!HEX:16|IM Size!DEC:4|CDN Path!STRING:0|CDN Hosts!STRING:0|CDN Servers!STRING:0|Tags!STRING:0|Armadillo!STRING:0|Last Activated!STRING:0|Version!STRING:0|KeyRing!HEX:16|Product!STRING:0";

fn folder(name: &str, products: &[(&str, &str)]) -> PathBuf {
	let dir = std::env::temp_dir().join(format!("forge-forever-test-{}-{name}", std::process::id()));
	std::fs::create_dir_all(&dir).unwrap();
	let mut text = format!("{HEAD}\n");
	for (product, version) in products {
		text.push_str(&format!("eu|1|644ffedb0d59bb0da2af9011b36f44db|0a08751bdd80706c48e4d099557fa853|||tpr/wow||||||{version}||{product}\n"));
	}
	std::fs::write(dir.join(".build.info"), text).unwrap();
	dir
}

fn product(dir: &std::path::Path) -> Option<(String, String)> {
	forge_gamedata::casc::forever_build(dir).unwrap().map(|b| (b.product, b.version))
}

#[test]
fn only_the_live_client_wowf_is_picked() {
	let d = folder("live", &[("wow", "12.1.5.1"), ("wow_classic_era", "1.15.8.1"), ("wowf", "1.60.1.70938")]);
	assert_eq!(product(&d), Some(("wowf".into(), "1.60.1.70938".into())));
	assert_eq!(forge_gamedata::casc::forever_product(&d).unwrap(), "wowf");
	std::fs::remove_dir_all(&d).unwrap();
}

#[test]
fn only_the_beta_falls_back_to_wow_classic_beta() {
	let d = folder("beta", &[("wow", "12.1.5.1"), ("wow_classic_beta", "1.60.1.70532")]);
	assert_eq!(product(&d), Some(("wow_classic_beta".into(), "1.60.1.70532".into())));
	assert_eq!(forge_gamedata::casc::forever_product(&d).unwrap(), "wow_classic_beta");
	std::fs::remove_dir_all(&d).unwrap();
}

#[test]
fn with_both_installed_wowf_wins_whatever_the_order() {
	let d = folder("both", &[("wow_classic_beta", "1.60.1.70532"), ("wowf", "1.60.1.70938")]);
	assert_eq!(product(&d), Some(("wowf".into(), "1.60.1.70938".into())));
	std::fs::remove_dir_all(&d).unwrap();
}

#[test]
fn with_neither_there_is_none_and_the_error_lists_what_is_there() {
	let d = folder("neither", &[("wow", "12.1.5.1"), ("wow_anniversary", "2.5.5.1"), ("wow_classic", "5.5.1.1")]);
	assert_eq!(product(&d), None);
	let e = forge_gamedata::casc::forever_product(&d).unwrap_err();
	assert!(e.contains("no WoW: Forever client (wowf or wow_classic_beta)") && e.contains("wow 12.1.5.1") && e.contains("wow_classic 5.5.1.1"), "{e}");
	std::fs::remove_dir_all(&d).unwrap();
}
