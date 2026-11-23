//! `forge data newquests`: the committed NewQuestIds.lua is what data/forever and the pinned client quest tables
//! give, and it marks Forever's quests and never Classic's.

#[test]
#[ignore = "needs the data/forever the committed NewQuestIds.lua was built from (FORGE_DATA or <checkout>/data/forever) and the pinned QuestV2 tables cached (FORGE_SOURCES or <checkout>/data/sources)"]
fn new_quest_ids_lua_is_up_to_date_and_marks_forever_quests_only() {
	let repo = super::fixture_build::repo();
	let env = |k: &str, d: &str| std::env::var_os(k).map(std::path::PathBuf::from).unwrap_or_else(|| repo.join(d));
	let (data, sources) = (env("FORGE_DATA", "data/forever"), env("FORGE_SOURCES", "data/sources"));
	let (ids, lua) = forge_data::newquests::build(&data, &sources, true, &|_| {}).unwrap();
	assert_eq!(std::fs::read_to_string(repo.join("addon/Polestar/Quests/NewQuestIds.lua")).unwrap(), lua, "run: forge data newquests");
	// Forever's: Wetlands' Crimson Crate Delivery, Riverglades' and Shen'dralas' (the client lists them before the data
	// build holds them).
	for id in [98240, 93786, 93787, 92841, 92846] {
		assert!(ids.contains(&id), "{id} is Forever's");
	}
	// Classic's, the Classic Era's later quests pfQuest lacks (Love is in the Air, a seasonal library book), a Classic
	// id Forever reused in a new zone.
	for id in [783, 7, 5722, 65593, 78124] {
		assert!(!ids.contains(&id), "{id} is Classic's");
	}
}
