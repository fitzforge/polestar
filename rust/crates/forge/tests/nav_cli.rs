//! `forge nav pack|check|layers`' arguments and refusals (ported from tests/nav-maps.test.js): the committed
//! walking maps pass `forge nav check`, a grid without the slope per surface is refused with the command that
//! rebuilds it, the roads allowlist is rewritten from both maps or not at all, and unknown arguments are usage
//! errors.

use std::path::{Path, PathBuf};
use std::process::Command;

fn repo() -> PathBuf {
	Path::new(env!("CARGO_MANIFEST_DIR")).join("../../..").canonicalize().unwrap()
}

fn tmp(name: &str) -> PathBuf {
	let d = Path::new(env!("CARGO_TARGET_TMPDIR")).join("nav-cli").join(name);
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	d
}

fn forge(args: &[&str]) -> (i32, String) {
	let o = Command::new(env!("CARGO_BIN_EXE_forge")).args(args).current_dir(repo()).output().unwrap();
	(o.status.code().unwrap_or(-1), format!("{}{}", String::from_utf8_lossy(&o.stdout), String::from_utf8_lossy(&o.stderr)))
}

#[test]
fn nav_check_passes_on_the_committed_walking_maps_and_fails_on_a_changed_one() {
	let nav = repo().join("addon/Polestar_Nav");
	let (code, out) = forge(&["nav", "check", "--out", nav.to_str().unwrap()]);
	assert_eq!(code, 0, "{out}");
	assert!(out.contains("the walking maps match PACK.json"));
	let copy = tmp("check").join("Polestar_Nav");
	std::fs::create_dir_all(copy.join("Nav")).unwrap();
	std::fs::copy(nav.join("PACK.json"), copy.join("PACK.json")).unwrap();
	for e in std::fs::read_dir(nav.join("Nav")).unwrap().flatten() {
		std::fs::copy(e.path(), copy.join("Nav").join(e.file_name())).unwrap();
	}
	std::fs::write(copy.join("Nav/Nav0.lua"), "-- edited\n").unwrap();
	let (code, out) = forge(&["nav", "check", "--out", copy.to_str().unwrap()]);
	assert_eq!(code, 1, "{out}");
	assert!(out.contains("forge nav check: Nav/Nav0.lua differs from PACK.json"), "{out}");
}

#[test]
fn nav_pack_refuses_a_grid_without_the_slope_per_surface_and_says_to_rebuild_it() {
	let root = tmp("grid3");
	let grid = root.join("grid");
	std::fs::create_dir_all(&grid).unwrap();
	std::fs::write(grid.join("index.json"), r#"{"version":3,"continents":{}}"#).unwrap();
	let (code, out) = forge(&["nav", "pack", "--root", root.to_str().unwrap(), "--dir", grid.to_str().unwrap(), "--out", root.join("out").to_str().unwrap()]);
	assert_eq!(code, 1, "{out}");
	assert!(out.contains("grid format 3") && out.contains("slope per surface") && out.contains("forge nav grid"), "{out}");
	assert!(!root.join("out").exists(), "nothing written");
}

#[test]
fn nav_layers_roads_refuses_allowlist_with_c_the_allowlist_is_rewritten_from_both_maps_or_not_at_all() {
	let file = repo().join("data/road-textures.json");
	let before = std::fs::read(&file).unwrap();
	let (code, out) = forge(&["nav", "layers", "roads", "--allowlist", "--c", "0", "--offline"]);
	assert_eq!(code, 2, "{out}");
	assert!(out.contains("--allowlist") && out.contains("--c"), "{out}");
	assert_eq!(std::fs::read(&file).unwrap(), before);
}

#[test]
fn unknown_arguments_and_layers_are_usage_errors() {
	for args in [
		&["nav", "pack", "--bogus", "1"][..],
		&["nav", "check", "--cells", "8"],
		&["nav", "layers", "trees"],
		&["nav", "layers"],
		&["nav", "pack", "--cells", "4"],
		&["nav", "pack", "--date", "today"],
		&["nav", "layers", "roads", "--c", "2"],
	] {
		let (code, out) = forge(args);
		assert_eq!(code, 2, "{args:?}: {out}");
		assert!(out.starts_with("forge nav: "), "{args:?}: {out}");
	}
}
