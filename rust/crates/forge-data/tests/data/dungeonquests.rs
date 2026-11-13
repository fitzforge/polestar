//! `forge data dungeonquests`: the committed QuestKeys.lua is what data/forever/codex/journal.json gives.

#[test]
#[ignore = "needs the data/forever the committed QuestKeys.lua was built from (FORGE_DATA or <checkout>/data/forever, with codex/journal.json)"]
fn quest_keys_lua_is_up_to_date_with_the_journal() {
	let repo = super::fixture_build::repo();
	let data = std::env::var_os("FORGE_DATA").map(std::path::PathBuf::from).unwrap_or_else(|| repo.join("data/forever"));
	let (pages, lua) = forge_data::dungeonquests::build(&data).unwrap();
	assert_eq!(std::fs::read_to_string(repo.join("addon/Polestar/Dungeons/QuestKeys.lua")).unwrap(), lua, "run: forge data dungeonquests");
	// Trouble at the Docks is a page quest of Wailing Caverns (#1830).
	assert!(pages["wailing-caverns"].quests.contains(&959));
}
