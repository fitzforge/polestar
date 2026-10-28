//! `gossip <id>` on talk, vendor and train goals (the gossip option the live step picks, QoL/Gossip.lua) and
//! the `wait <seconds> ["text"]` goal (a countdown in the step, Core/Engine.lua): parse, errors, emission.

use forge_addontest::dsl::{compile, plain};
use forge_addontest::is_match;
use serde_json::json;

fn guide(body: &[&str]) -> String {
	let mut lines = vec!["guide t/gw", "title Test", "faction Alliance", "levels 1-10", "zone Elwynn Forest", "", "step S"];
	lines.extend_from_slice(body);
	format!("{}\n", lines.join("\n"))
}

#[test]
fn a_talk_goal_carries_its_gossip_option_and_a_wait_goal_its_seconds_and_text() {
	let r = compile(&guide(&[r#"  talk 197 "Marshal McBride" gossip 4021"#, r#"  wait 30 "the boat docks""#]));
	assert_eq!(r.errors, Vec::<String>::new());
	let g = plain(&r.guides[0]);
	let goals = &g["steps"][0]["goals"];
	assert_eq!(goals[0]["gossip"], 4021);
	assert_eq!(json!([goals[1]["t"].clone(), goals[1]["seconds"].clone(), goals[1]["text"].clone()]), json!(["wait", 30, "the boat docks"]));
}

#[test]
fn gossip_only_on_talk_vendor_and_train_and_wait_needs_one_to_3600_seconds() {
	let r = compile(&guide(&["  kill 6 \"Kobold Vermin\" gossip 3", "  wait 0", "  wait soon"]));
	let all = r.errors.join("\n");
	assert!(is_match(&all, "`gossip` does not apply to `kill`"), "{all}");
	assert_eq!(r.errors.iter().filter(|e| e.contains("malformed seconds")).count(), 2, "{all}");
}
