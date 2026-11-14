//! `forge doctor` names the Forever product it reads: the live client `wowf` (`_forever_`), the old
//! beta `wow_classic_beta` only without it, and the fix when the folder holds neither (November
//! 2026: a game folder with wowf 1.60.1.70938 was reported as having no Forever client).

use std::path::{Path, PathBuf};
use std::process::Command;

const HEAD: &str = "Branch!STRING:0|Active!DEC:1|Build Key!HEX:16|CDN Key!HEX:16|Install Key!HEX:16|IM Size!DEC:4|CDN Path!STRING:0|CDN Hosts!STRING:0|CDN Servers!STRING:0|Tags!STRING:0|Armadillo!STRING:0|Last Activated!STRING:0|Version!STRING:0|KeyRing!HEX:16|Product!STRING:0";

fn home(name: &str, products: &[(&str, &str)]) -> PathBuf {
	let home = std::env::temp_dir().join(format!("forge-doctor-{name}-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&home);
	let wow = home.join("World of Warcraft");
	std::fs::create_dir_all(&wow).unwrap();
	let mut text = format!("{HEAD}\n");
	for (product, version) in products {
		text.push_str(&format!("eu|1|644ffedb0d59bb0da2af9011b36f44db|0a08751bdd80706c48e4d099557fa853|||tpr/wow||||||{version}||{product}\n"));
	}
	std::fs::write(wow.join(".build.info"), text).unwrap();
	home
}

fn doctor(home: &Path) -> String {
	let o = Command::new(env!("CARGO_BIN_EXE_forge"))
		.arg("doctor")
		.current_dir(home)
		.env("HOME", home)
		.env("XDG_CONFIG_HOME", home.join("config"))
		.env("XDG_DATA_HOME", home.join("data"))
		.env("POLESTAR_FORGE_CONFIG", home.join("config.toml"))
		.env("POLESTAR_WOW_DIR", home.join("World of Warcraft"))
		.env_remove("POLESTAR_GRID")
		.env_remove("POLESTAR_LEFFE_NAV")
		.output()
		.unwrap();
	String::from_utf8_lossy(&o.stdout).into_owned()
}

const READS: &str = "<- Forge reads this one";

#[test]
fn the_live_client_wowf_is_the_one_doctor_reads() {
	let h = home("live", &[("wow", "12.1.5.1"), ("wow_classic_era", "1.15.8.1"), ("wow_anniversary", "2.5.5.1"), ("wow_classic", "5.5.1.1"), ("wowf", "1.60.1.70938")]);
	let out = doctor(&h);
	assert!(out.lines().any(|l| l.contains("wowf 1.60.1.70938") && l.contains(READS)), "{out}");
	assert_eq!(out.matches(READS).count(), 1, "{out}");
	assert!(!out.contains("no Forever build"), "{out}");
	let _ = std::fs::remove_dir_all(&h);
}

#[test]
fn the_beta_is_read_only_without_wowf() {
	let h = home("beta", &[("wow_classic_beta", "1.60.1.70532")]);
	let out = doctor(&h);
	assert!(out.lines().any(|l| l.contains("wow_classic_beta 1.60.1.70532") && l.contains(READS)), "{out}");
	let _ = std::fs::remove_dir_all(&h);
	let h = home("both", &[("wow_classic_beta", "1.60.1.70532"), ("wowf", "1.60.1.70938")]);
	let out = doctor(&h);
	assert!(out.lines().any(|l| l.contains("wowf 1.60.1.70938") && l.contains(READS)), "{out}");
	assert!(out.lines().any(|l| l.contains("wow_classic_beta 1.60.1.70532") && !l.contains(READS)), "{out}");
	let _ = std::fs::remove_dir_all(&h);
}

#[test]
fn without_a_forever_client_doctor_says_what_it_looked_for_and_the_fix() {
	let h = home("neither", &[("wow", "12.1.5.1"), ("wow_classic_era", "1.15.8.1")]);
	let out = doctor(&h);
	assert!(out.contains("MISS Forever client") && out.contains("no Forever build in this folder (looked for wowf, then wow_classic_beta)"), "{out}");
	assert!(out.contains("fix: install World of Warcraft: Forever with the launcher (product wowf, folder _forever_)"), "{out}");
	assert!(!out.contains(READS), "{out}");
	let _ = std::fs::remove_dir_all(&h);
}
