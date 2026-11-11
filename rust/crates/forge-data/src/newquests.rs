//! `forge data newquests`: the quests World of Warcraft: Forever added to the game, for the addon's
//! "New in Forever" mark -> addon/Polestar/Quests/NewQuestIds.lua. Same inputs give byte-identical output.
//!
//! A quest is new in Forever when Classic never had it: neither pfQuest's Classic database (the
//! `pfquest` source of data/forever/quests.json) nor the Classic Era client's quest table (QuestV2,
//! which also lists the Era's later quests: holidays, the seasons' quests) holds its id. The quests
//! are those of data/forever/quests.json and of the Forever client's QuestV2, so a new zone's quests
//! are marked before the data build takes them in. Neither quest table lists every quest
//! (QuestV2 holds the quests with a completion bit), which is why both Classic sources count.
//!
//! The ids ship as one string of fixed-width decimal ids, ascending, read by binary search
//! (addon/Polestar/Quests/NewQuests.lua): a few KB resident where a table set would cost ~40 bytes
//! an id.

use std::collections::BTreeSet;
use std::path::Path;

use crate::jsv::Rows;

pub const COMMAND: &str = "forge data newquests";
/// The Classic Era client build whose quest table is the Classic base.
pub const ERA_BUILD: &str = crate::players::QUESTXP_BUILD;
/// The Forever client build whose quest table lists Forever's quests (pinned: the output only
/// changes when this moves).
pub const FOREVER_BUILD: &str = "1.60.1.70862";
pub const TABLES: [&str; 1] = ["QuestV2"];
/// Digits an id takes in the string (ids under 1,000,000).
pub const WIDTH: usize = 6;
/// Ids a line of the generated file holds.
const PER_LINE: usize = 16;

/// The ids of a QuestV2 table.
pub fn table_ids(rows: &Rows) -> BTreeSet<i64> {
	rows.iter().filter_map(|r| r.get("ID").and_then(|v| v.trim().parse::<i64>().ok())).filter(|id| *id > 0).collect()
}

/// The quests new in Forever: those of `quests` (data/forever/quests.json, with a title) and of the
/// Forever client's quest table, less every id pfQuest's Classic database or the Era client's quest
/// table holds.
pub fn new_quest_ids(quests: &serde_json::Value, era: &BTreeSet<i64>, forever: &BTreeSet<i64>) -> BTreeSet<i64> {
	let mut classic = era.clone();
	let mut all = forever.clone();
	for (k, q) in quests.as_object().into_iter().flatten() {
		let Ok(id) = k.parse::<i64>() else { continue };
		if q.get("source").and_then(|s| s.as_array()).is_some_and(|s| s.iter().any(|t| t.as_str() == Some("pfquest"))) {
			classic.insert(id);
		} else if q.get("title").is_some_and(|t| t.is_string()) {
			all.insert(id);
		}
	}
	all.into_iter().filter(|id| *id > 0 && !classic.contains(id)).collect()
}

/// The Lua file: `N.Register(WIDTH, [[ids]])`, the ids zero-padded to WIDTH digits, PER_LINE a line
/// (the runtime drops the line breaks).
pub fn emit(ids: &BTreeSet<i64>) -> String {
	let mut l = vec![
		forge_guide::emit::header("lua", COMMAND, &format!("data/forever/quests.json and the client quest tables (Classic Era {ERA_BUILD}, Forever {FOREVER_BUILD})")),
		"-- The quests Forever added: in neither pfQuest's Classic database nor the Classic Era client's".into(),
		format!("-- quest table. {} ids, {WIDTH} digits each, ascending (rust/crates/forge-data/src/newquests.rs).", ids.len()),
		String::new(),
		"local ADDON, ns = ...".into(),
		"local N = ns.NewQuests".into(),
		"if not (N and N.Register) then return end".into(),
		String::new(),
		format!("N.Register({WIDTH}, [["),
	];
	let padded: Vec<String> = ids
		.iter()
		.map(|id| {
			assert!(id.to_string().len() <= WIDTH, "quest id {id} is wider than {WIDTH} digits");
			format!("{id:0WIDTH$}")
		})
		.collect();
	for chunk in padded.chunks(PER_LINE) {
		l.push(chunk.concat());
	}
	l.push("]])".into());
	l.join("\n") + "\n"
}

/// The two quest tables, from the source cache (fetched from wago.tools when missing, unless
/// `offline`). -> (Era ids, Forever ids)
pub fn client_ids(sources: &Path, offline: bool, log: &dyn Fn(&str)) -> Result<(BTreeSet<i64>, BTreeSet<i64>), String> {
	let read = |p: &crate::tables::Product, build: &str| -> Result<BTreeSet<i64>, String> {
		let (_, t, _) = crate::sources::client_tables(sources, p, Some(build), &TABLES, offline, log)?;
		t.iter().find(|(n, _)| n == "QuestV2").map(|(_, rows)| table_ids(rows)).ok_or_else(|| format!("no QuestV2 table for {build}"))
	};
	Ok((read(&crate::tables::ERA, ERA_BUILD)?, read(&crate::tables::FOREVER, FOREVER_BUILD)?))
}

/// NewQuestIds.lua from data/forever and the cached quest tables. -> (the ids, the Lua)
pub fn build(data: &Path, sources: &Path, offline: bool, log: &dyn Fn(&str)) -> Result<(BTreeSet<i64>, String), String> {
	let file = data.join("quests.json");
	let text = std::fs::read_to_string(&file).map_err(|_| format!("missing {} (run: forge data build)", file.display()))?;
	let quests: serde_json::Value = serde_json::from_str(&text).map_err(|e| format!("{}: {e}", file.display()))?;
	let (era, forever) = client_ids(sources, offline, log)?;
	let ids = new_quest_ids(&quests, &era, &forever);
	let lua = emit(&ids);
	Ok((ids, lua))
}

#[cfg(test)]
mod tests {
	use super::*;
	use serde_json::json;

	fn set(v: &[i64]) -> BTreeSet<i64> {
		v.iter().copied().collect()
	}

	#[test]
	fn a_quest_is_new_when_neither_classic_source_holds_it() {
		let quests = json!({
			"783": { "title": "A Threat Within", "source": ["pfquest", "questie-forever"] },
			"5722": { "title": "Searching for the Lost Satchel", "source": ["pfquest"] },
			"65593": { "title": "Hearts of the Lovers", "source": ["questie-forever"] },
			"98240": { "title": "Crimson Crate Delivery", "source": ["questie-forever", "webdb:xp"] },
			"99001": { "source": ["questie-forever"] }
		});
		// 65593: an Era holiday quest pfQuest lacks; 93500: a new zone's quest only the Forever client lists;
		// 783 is in the Forever table too.
		let ids = new_quest_ids(&quests, &set(&[783, 65593]), &set(&[783, 93500, 98240]));
		assert_eq!(ids, set(&[93500, 98240]));
	}

	#[test]
	fn the_ids_are_fixed_width_and_ascending() {
		let lua = emit(&set(&[98240, 900, 93500]));
		assert!(lua.starts_with("-- Generated by `forge data newquests`"), "{lua}");
		assert!(lua.contains("N.Register(6, [[\n000900093500098240\n]])\n"), "{lua}");
	}
}
