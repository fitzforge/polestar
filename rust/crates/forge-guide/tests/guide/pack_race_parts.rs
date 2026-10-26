//! Writing a pack's race parts (project.rs write_pack_dir): a race part the build no longer has is removed;
//! another folder of that name is refused. Their contents and loading are forge-addontest's
//! tests/pack-race-parts.rs.

use crate::common;
use common::*;
use forge_guide::project::{build_pack, write_pack_dir, BuildOpts, FileContent};

fn guide(id: &str, head: &str) -> String {
	format!("guide {id}\ntitle Elwynn Forest\nfaction Alliance\n{head}\nlevels 1-10\nzone Elwynn Forest\n\nstep Marshal McBride\n  accept 7\n  turnin 7\n")
}

/// A pack with a plain guide, a Human Warrior chain, a Human and Dwarf Mage chain (unless !mage); retired:
/// one old id.
fn pack_dir(name: &str, mage: bool) -> std::path::PathBuf {
	let dir = scratch(&format!("parts-{name}"));
	let mut files = vec![
		("pack.json", r#"{"id":"parts","title":"Parts Pack","author":"Ann","version":"1.0.0","license":"CC0-1.0","folder":"PolestarPack_Parts"}"#.to_string()),
		("guides/plain.guide", guide("parts/plain", "")),
		("guides/human-warrior.guide", guide("parts/human-warrior/01", "race Human\nclass Warrior")),
		("guides/warrior-2.guide", guide("parts/human-warrior/02", "race Human\nclass Warrior").replace("levels 1-10", "levels 10-12")),
		("retired.json", r#"["parts/old-elwynn"]"#.to_string()),
	];
	if mage {
		files.push(("guides/mage.guide", guide("parts/human-dwarf-mage/01", "race Human,Dwarf\nclass Mage")));
	}
	let refs: Vec<(&str, &str)> = files.iter().map(|(a, b)| (*a, b.as_str())).collect();
	write_tree(&dir, &refs);
	dir
}

fn build(dir: &std::path::Path) -> Vec<(String, FileContent)> {
	let (manifest, extra) = forge_guide::manifest::read_manifest(dir, false);
	let data = fixture_data();
	let b = build_pack(&repo(), dir, &manifest.unwrap(), extra, &data, forge_guide::diag::Diagnostics::new(), BuildOpts { include_drafts: false, context: None, force: false }).unwrap();
	assert!(b.project.diag.errors().is_empty(), "{:?}", b.project.diag.sorted());
	b.files.unwrap()
}

#[test]
fn a_race_part_the_build_no_longer_has_is_removed_another_folder_of_that_name_is_refused() {
	let addons = scratch("parts-addons");
	let out = addons.join("PolestarPack_Parts");
	write_pack_dir(&out, &build(&pack_dir("all", true))).unwrap();
	assert!(addons.join("PolestarPack_Parts_Dwarf/Guides.lua").exists());
	write_pack_dir(&out, &build(&pack_dir("nomage", false))).unwrap();
	assert!(!addons.join("PolestarPack_Parts_Dwarf").exists(), "no Dwarf guide left: the Dwarf part goes");
	assert!(addons.join("PolestarPack_Parts_Human/Guides.lua").exists());
	std::fs::create_dir(addons.join("PolestarPack_Parts_Dwarf")).unwrap();
	std::fs::write(addons.join("PolestarPack_Parts_Dwarf/mine.lua"), "-- someone else").unwrap();
	assert_match(&write_pack_dir(&out, &build(&pack_dir("again", true))).unwrap_err(), "not a generated race part");
}
