//! The release's addons loading together the way the client loads them. Pointed at an unpacked release
//! zip (POLESTAR_ADDON_DIR=<AddOns folder>), this is the release smoke test (docs/RELEASING.md, step 5):
//! every addon of the release in client order, logged in, the guides registered, a guide opened, the data
//! addons loaded, and every TOC carrying the release version.

use forge_addontest::run::{addons_dir, root};
use forge_addontest::{emitted, truthy, Addon, RunAddon};
use std::path::PathBuf;

/// The AddOns folder under test: $POLESTAR_ADDON_DIR, else the checkout's addon/.
fn addons() -> PathBuf {
	std::env::var_os("POLESTAR_ADDON_DIR").map_or_else(addons_dir, PathBuf::from)
}

#[test]
fn the_release_addons_load_together_log_in_and_find_their_guides_and_data() {
	let dir = addons();
	let product = forge_release::addons::release_addons(&dir);
	let recorder = dir.join("Polestar_Recorder/Polestar_Recorder.toc").exists();
	let mut names = product.names.clone();
	if recorder {
		names.push("Polestar_Recorder".into());
	}
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: names.iter().map(|n| Addon::dir(n, dir.join(n))).collect(),
		login: true,
		script: r#"
			stub.advance(0.5)
			local g = Polestar.Engine.GetGuide()
			emit({
				guides = #Polestar.Guides.List(),
				open = g and g.id or false,
				questDB = Polestar.QuestDB.IsLoaded(),
				itemDB = Polestar.ItemDB.IsLoaded(),
				recorder = type(PolestarRecorderDB) == "table",
			})"#
		.into(),
		..Default::default()
	});
	let got = &out[0];
	assert!(got["guides"].as_i64().unwrap_or(0) > 0, "the guide pack registered its guides");
	assert!(truthy(&got["open"]), "a guide opened at login");
	assert_eq!(got["questDB"], product.names.iter().any(|n| n == "Polestar_QuestDB"));
	assert_eq!(got["itemDB"], product.names.iter().any(|n| n == "Polestar_ItemDB"));
	assert_eq!(got["recorder"], recorder);
}

#[test]
fn every_toc_carries_the_release_version() {
	let dir = addons();
	let version = forge_release::version::package_version(root()).unwrap();
	let files = forge_release::version::files(root(), &dir);
	let wrong: Vec<(String, Option<String>)> = files
		.tocs
		.iter()
		.map(|t| (t.display().to_string(), forge_release::version::toc_version(&std::fs::read_to_string(t).unwrap())))
		.filter(|(_, v)| v.as_deref() != Some(version.as_str()))
		.collect();
	assert!(wrong.is_empty(), "{wrong:?}");
}
