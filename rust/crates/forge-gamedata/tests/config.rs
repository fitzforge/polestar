//! The remembered World of Warcraft folder: written, read back (quotes and backslashes kept),
//! other lines kept, forgotten.

#[test]
fn remember_and_forget_wow() {
	let dir = std::env::temp_dir().join(format!("forge-config-test-{}", std::process::id()));
	let wow = dir.join("World of \"Warcraft\"");
	std::fs::create_dir_all(&wow).unwrap();
	std::fs::write(wow.join(".build.info"), "Product!STRING:0|Version!STRING:0\n").unwrap();
	let file = dir.join("cfg").join("config.toml");
	std::fs::create_dir_all(file.parent().unwrap()).unwrap();
	std::fs::write(&file, "# mine\nother = 1\nwow = \"/old\"\n").unwrap();
	std::env::set_var("POLESTAR_FORGE_CONFIG", &file);
	std::env::remove_var("POLESTAR_WOW_DIR");
	let want = wow.canonicalize().unwrap();
	assert_eq!(forge_gamedata::remember_wow(&wow).unwrap(), Some(file.clone()));
	assert_eq!(forge_gamedata::remembered_wow(), Some(want.clone()));
	assert_eq!(forge_gamedata::remember_wow(&wow).unwrap(), None);
	assert_eq!(forge_gamedata::find_install_how(), Some((want, forge_gamedata::Found::Config)));
	let text = std::fs::read_to_string(&file).unwrap();
	assert!(text.starts_with("# mine\nother = 1\nwow = "), "{text}");
	assert!(forge_gamedata::forget_wow().unwrap());
	assert_eq!(forge_gamedata::remembered_wow(), None);
	assert_eq!(std::fs::read_to_string(&file).unwrap(), "# mine\nother = 1\n");
	assert!(forge_gamedata::remember_wow(&dir).is_err());
	std::fs::remove_dir_all(&dir).unwrap();
}
