//! #574 (HershelW): candidate lists and records repeated inside one guide are emitted once and shared; each
//! goal's pick and ranking stay its own.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use forge_guide::emit::emit_guides;
use forge_guide::js::{parse_json, V};
use serde_json::{json, Value};

/// `emitGuides(guides.map((guide) => ({ guide })))`.
fn emit(guides: &[Value]) -> String {
	let entries: Vec<V> = guides.iter().map(|g| parse_json(&json!({ "guide": g }).to_string()).unwrap()).collect();
	emit_guides(&entries, false)
}

#[test]
fn emitted_repeated_candidates_share_data_but_keep_selection_local_to_each_goal() {
	let first = json!({ "npc": 295, "npcName": "First innkeeper", "map": 1429, "x": 10, "y": 10 });
	let second = json!({ "npc": 296, "npcName": "Second innkeeper", "map": 1429, "x": 90, "y": 90 });
	let candidates = json!([first.clone(), second.clone()]);
	let mut first_moved = first.clone();
	first_moved["x"] = json!(11);
	let mut second_rate = second.clone();
	second_rate["rate"] = json!(0.5);
	let guide = json!({
		"id": "test/shared-candidates", "pack": "test", "title": "Shared candidates", "minLevel": 1, "maxLevel": 60,
		"steps": [
			{ "goals": [{ "t": "sethome", "candidates": candidates.clone() }] },
			{ "goals": [{ "t": "sethome", "candidates": candidates.clone() }] },
			{ "goals": [{ "t": "sethome", "candidates": [first_moved, second.clone()] }] },
			{ "goals": [{ "t": "sethome", "candidates": [second.clone(), second.clone(), second_rate] }] },
		],
	});
	let script = [TEST_PACK, TEST_SOURCE, &emit(&[guide])].join("\n")
		+ r#"
			stub.login(); local E=Polestar.Engine; E.SetGuide("test/shared-candidates")
			local g=Polestar.Guides.Get("test/shared-candidates")
			local a,b,c=g.steps[1].goals[1],g.steps[2].goals[1],g.steps[3].goals[1]
			local result={shared=a.candidates==b.candidates,different=a.candidates~=c.candidates,distinctGoals=a~=b,
				sharedRecord=a.candidates[2]==c.candidates[2],differentRecord=a.candidates[1]~=c.candidates[1]}
			local d=g.steps[4].goals[1].candidates
			result.distinctEntries=d[1]~=d[2]
			result.differentRate=d[1]~=d[3] and d[3].rate==0.5
			result.before={E.GetStepView(1).goals[1].npc,E.GetStepView(2).goals[1].npc}
			E.CycleCandidate(1,1)
			result.after={E.GetStepView(1).goals[1].npc,E.GetStepView(2).goals[1].npc}
			result.sourceOrder={a.candidates[1].npc,a.candidates[2].npc}
			emit(result)"#;
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"local w=stub.world; w.addMap(1429,{name="Elwynn Forest",c=0,left=1000,right=-1000,top=1000,bottom=-1000}); w.moveTo(1429,10,10)"#.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script,
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["shared"], true);
	assert_eq!(out["different"], true);
	assert_eq!(out["distinctGoals"], true);
	assert_eq!(out["sharedRecord"], true, "identical records in different lists share storage");
	assert_eq!(out["differentRecord"], true, "same NPC with different coordinates stays distinct");
	assert_eq!(out["distinctEntries"], true, "ranking keeps duplicate entries in one list distinct");
	assert_eq!(out["differentRate"], true, "same NPC with a different drop rate stays distinct");
	assert_eq!(out["before"], json!([295, 295]));
	assert_eq!(out["after"], json!([296, 295]));
	assert_eq!(out["sourceOrder"], json!([295, 296]));
}

#[test]
fn candidate_sharing_stays_inside_one_guide_and_leaves_spawn_visitation_separate() {
	let candidate = json!({ "npc": 295, "npcName": "Innkeeper", "map": 1429, "x": 10, "y": 10 });
	let make = |id: &str, faction: &str| {
		json!({
			"id": id, "pack": "test", "title": id, "faction": faction, "minLevel": 1, "maxLevel": 60,
			"steps": [
				{ "goals": [
					{ "t": "sethome", "candidates": [candidate.clone()] },
					{ "t": "kill", "target": "Test target", "npc": 295, "npcName": "Test target", "map": 1429, "x": 10, "y": 10, "spots": [{ "x": 10, "y": 10, "r": 20, "n": 2 }] },
				] },
				{ "goals": [
					{ "t": "sethome", "candidates": [candidate.clone()] },
					{ "t": "kill", "target": "Test target", "npc": 295, "npcName": "Test target", "map": 1429, "x": 10, "y": 10, "spots": [{ "x": 10, "y": 10, "r": 20, "n": 2 }] },
				] },
			],
		})
	};
	let script = "\n\t\t\t".to_string()
		+ &[TEST_PACK, TEST_SOURCE, &emit(&[make("test/horde", "Horde"), make("test/alliance", "Alliance")])].join("\n")
		+ r#"
			stub.login()
			local a,b=Polestar.Guides.Get('test/horde'),Polestar.Guides.Get('test/alliance')
			emit({inside=a.steps[1].goals[1].candidates==a.steps[2].goals[1].candidates,
				separate=a.steps[1].goals[1].candidates[1]~=b.steps[1].goals[1].candidates[1],
				visits=a.steps[1].goals[2].spots[1]~=a.steps[2].goals[2].spots[1]})"#;
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::files("Polestar", &["Core/Core.xml"])], script, ..Default::default() }).remove(0);
	assert_eq!(out, json!({ "inside": true, "separate": true, "visits": true }));
}
