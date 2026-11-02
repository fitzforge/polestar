//! The build's data stage never loses QuestieDB or a big share of the quests silently (October 2026:
//! the beta client was uninstalled, QuestieDB was not found, and the data was built without it: 975
//! quests fewer, a smaller world and a full re-walk, with only a log line to say so).

use std::path::{Path, PathBuf};

#[test]
fn questie_not_found_stops_the_build_unless_no_questie() {
	let searched = vec![PathBuf::from("/wow/_forever_/Interface/AddOns")];
	let e = forge::data_questie(false, None, &searched).unwrap_err();
	assert!(e.contains("QuestieDB not found") && e.contains("/wow/_forever_/Interface/AddOns") && e.contains("--no-questie"), "{e}");
	assert_eq!(forge::data_questie(true, None, &searched), Ok(None));
	let q = PathBuf::from("/wow/_forever_/Interface/AddOns/QuestieDB");
	assert_eq!(forge::data_questie(false, Some(q.clone()), &searched), Ok(Some(q)));
}

#[test]
fn a_quest_count_drop_past_five_percent_stops_the_build_unless_accepted() {
	let quests = |n: usize| -> String { format!("{{{}}}", (1..=n).map(|i| format!("\"{i}\": {{\"title\": \"Q{i}\", \"source\": [\"questie-forever\"]}}")).collect::<Vec<_>>().join(",")) };
	let (old, new) = (quests(100), quests(83));
	let file = Path::new("out/data/forever/quests.json");
	let mut said: Vec<String> = Vec::new();
	let e = forge::data_guard(Some((file, &old)), &new, false, &mut |m| said.push(m.to_string())).unwrap_err();
	assert!(e.contains("from 100 to 83") && e.contains("questie-forever 17 (84 Q84, 85 Q85, 86 Q86)") && e.contains("--accept-fewer-quests"), "{e}");
	assert!(forge::data_guard(Some((file, &old)), &new, true, &mut |m| said.push(m.to_string())).is_ok());
	assert!(said.iter().any(|m| m.contains("taken: --accept-fewer-quests")), "{said:?}");
	assert!(forge::data_guard(Some((file, &old)), &quests(96), false, &mut |_| {}).is_ok(), "4% is within the limit");
	assert!(forge::data_guard(None, &new, false, &mut |_| {}).is_ok(), "no reference: nothing to compare");
}
