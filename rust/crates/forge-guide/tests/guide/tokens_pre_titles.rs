//! A step's text names its own quest, not a same-named exclusive of it (in the goal's preTitles and closedBy):
//! Forever gives Skyborne shamans their own Call of Air (96136) beside everyone else's (1531), each closing the
//! other, and "their own Call of Air" in the step that takes 96136 is 96136. A same-named prerequisite (the Honored
//! Eye of Zuldazar 8050 after the Friendly one, 8049) keeps the token it had.
//! (tests/guide-texts.test.js, "a step's own quest", is the JS side.)

use crate::common;
use common::*;
use forge_guide::tokens::tokenise_guides;
use serde_json::json;

#[test]
fn a_steps_text_takes_its_own_quests_token_over_a_same_named_exclusive_not_over_a_same_named_prerequisite() {
	let guide = v(&json!({
		"id": "t/main",
		"title": "Test",
		"steps": [
			{
				"title": "Step",
				"note": "At 30 Skyborne shamans get their own Call of Air.",
				"goals": [{ "t": "accept", "quest": 96136, "title": "Call of Air", "preTitles": { "1531": "Call of Air" }, "closedBy": [1531] }],
			},
			{
				"title": "Step",
				"note": "Then The Eye of Zuldazar, Honored.",
				"goals": [{ "t": "accept", "quest": 8050, "title": "The Eye of Zuldazar", "preTitles": { "8049": "The Eye of Zuldazar" } }],
			},
		],
	}));
	let r = tokenise_guides(&[guide], &fixture_data());
	let note = |i: usize| r.get("guides").at(0).get("steps").at(i).get("note").to_js_string();
	assert_eq!(note(0), "At 30 Skyborne shamans get their own {quest:96136}.");
	assert_eq!(note(1), "Then {quest:8049}, Honored.");
}
