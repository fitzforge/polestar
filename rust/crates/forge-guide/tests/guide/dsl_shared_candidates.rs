//! #574: candidate lists and records repeated inside one guide are emitted once and shared (Guides.lua's
//! `candidateLists` / `candidateRecords` locals of the guide's register function); different lists, and
//! another guide, keep their own. What the addon then does with them (each goal picks and cycles its own
//! NPC) is the addon test tests/dsl-shared-candidates.test.js, run in the addon's Lua.

use crate::common;
use common::*;
use forge_guide::js::{parse_json, V};

fn guide(json: &str) -> V {
	parse_json(json).unwrap()
}

const A: &str = r#"{ "npc": 295, "npcName": "First innkeeper", "map": 1429, "x": 10, "y": 10 }"#;
const B: &str = r#"{ "npc": 296, "npcName": "Second innkeeper", "map": 1429, "x": 90, "y": 90 }"#;

/// The emitted text of one guide's register function.
fn blocks(lua: &str) -> Vec<String> {
	lua.split("local function register()").skip(1).map(String::from).collect()
}

#[test]
fn emitted_repeated_candidates_share_data_but_keep_selection_local_to_each_goal() {
	let a11 = A.replace("\"x\": 10", "\"x\": 11");
	let b_rate = B.replace("\"y\": 90", "\"y\": 90, \"rate\": 0.5");
	let g = guide(&format!(
		r#"{{ "id": "test/shared-candidates", "pack": "test", "title": "Shared candidates", "minLevel": 1, "maxLevel": 60, "steps": [
			{{ "goals": [{{ "t": "sethome", "candidates": [{A}, {B}] }}] }},
			{{ "goals": [{{ "t": "sethome", "candidates": [{A}, {B}] }}] }},
			{{ "goals": [{{ "t": "sethome", "candidates": [{a11}, {B}] }}] }},
			{{ "goals": [{{ "t": "sethome", "candidates": [{B}, {B}, {b_rate}] }}] }}
		] }}"#
	));
	let lua = emit(&[g]);
	let block = &blocks(&lua)[0];
	assert!(block.contains("local candidateLists = {"), "{block}");
	assert!(block.contains("local candidateRecords = {"), "{block}");
	// Steps 1 and 2 name the same shared list; step 3's list (another x) is another one.
	let goals: Vec<&str> = block.lines().filter(|l| l.contains("t = \"sethome\"")).collect();
	assert_eq!(goals.len(), 4, "{block}");
	let list_ref = |l: &str| re(r"candidates = (candidateLists\[\d+\]|\{[^}]*\})").captures(l).map(|c| c[1].to_string());
	assert!(list_ref(goals[0]).is_some_and(|r| r.starts_with("candidateLists[")), "{}", goals[0]);
	assert_eq!(list_ref(goals[0]), list_ref(goals[1]), "identical lists are one shared list");
	assert_ne!(list_ref(goals[0]), list_ref(goals[2]), "a list with another record stays its own");
	// Records: the second innkeeper is one record shared by the lists.
	let records = block.split("local candidateRecords = {").nth(1).unwrap().split("\n}").next().unwrap().split("\n\t\t}").next().unwrap();
	assert_eq!(records.matches("npc = 296").count(), 1, "identical records in different lists share storage: {records}");
	assert!(!records.contains("rate"), "{records}");
	// The same NPC with other coordinates, or another drop rate, stays a record of its own.
	assert_eq!(block.matches("x = 11,").count(), 1, "{block}");
	assert_eq!(block.matches("rate = 0.5").count(), 1, "{block}");
}

#[test]
fn candidate_sharing_stays_inside_one_guide_and_leaves_spawn_visitation_separate() {
	let cand = r#"{ "npc": 295, "npcName": "Innkeeper", "map": 1429, "x": 10, "y": 10 }"#;
	let kill = r#"{ "t": "kill", "target": "Test target", "npc": 295, "npcName": "Test target", "map": 1429, "x": 10, "y": 10, "spots": [{ "x": 10, "y": 10, "r": 20, "n": 2 }] }"#;
	let make = |id: &str, faction: &str| {
		guide(&format!(
			r#"{{ "id": "{id}", "pack": "test", "title": "{id}", "faction": "{faction}", "minLevel": 1, "maxLevel": 60, "steps": [
				{{ "goals": [{{ "t": "sethome", "candidates": [{cand}] }}, {kill}] }},
				{{ "goals": [{{ "t": "sethome", "candidates": [{cand}] }}, {kill}] }}
			] }}"#
		))
	};
	let lua = emit(&[make("test/horde", "Horde"), make("test/alliance", "Alliance")]);
	let b = blocks(&lua);
	assert_eq!(b.len(), 2);
	for block in &b {
		// Inside each guide: the two sethome goals share one list, defined in that guide's own register.
		assert!(block.contains("local candidateLists = {"), "{block}");
		let refs: Vec<String> = block.lines().filter(|l| l.contains("t = \"sethome\"")).map(|l| re(r"candidateLists\[\d+\]").find(l).unwrap().as_str().to_string()).collect();
		assert_eq!(refs.len(), 2);
		assert_eq!(refs[0], refs[1]);
		// Spawn spots are written out on each goal, never shared.
		assert_eq!(block.lines().filter(|l| l.contains("t = \"kill\"") && l.contains("spots = {")).count(), 2, "{block}");
	}
}
