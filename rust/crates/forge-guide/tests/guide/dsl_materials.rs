//! A profession guide's materials, gathered or bought (docs/GUIDE_FORMAT.md, "Materials"): `auction <item> xN` buys
//! at the Auction House (the arrow: the nearest auctioneer of the player's faction) and `collect … gather` is the
//! item's gather way, with what it takes; Core/Materials.lua picks per item which applies. The JS side is
//! tests/dsl-materials.test.js. Fixture data: tests/fixtures/dsl/data (Auctioneer Fitch in Stormwind, a Horde one
//! in Razor Hill, a neutral one in Booty Bay).

use crate::common;
use common::*;
use forge_guide::format::{format_for, needs, MATERIALS_FORMAT, MONEY_TASK_FORMAT};
use serde_json::{json, Value};

fn head(faction: Option<&str>) -> Vec<String> {
	let mut l: Vec<String> = ["guide t/tailoring", "title Tailoring", "category Professions"].map(String::from).to_vec();
	if let Some(f) = faction {
		l.push(format!("faction {f}"));
	}
	l.extend(["levels 1-60", "zone Elwynn Forest", ""].map(String::from));
	l
}

fn text_for(lines: &[&str], faction: Option<&str>) -> String {
	let mut l = head(faction);
	l.extend(lines.iter().map(|s| s.to_string()));
	format!("{}\n", l.join("\n"))
}

fn text(lines: &[&str]) -> String {
	text_for(lines, Some("Alliance"))
}

#[test]
fn auction_leads_to_the_auctioneers_of_the_factions_the_goal_serves_never_a_neutral_house() {
	let r = compile(&text(&["step Auction House", "  auction 4306 x20"]));
	assert!(r.errors.is_empty() && r.warnings.is_empty(), "{}", r.text);
	let g = r.steps()[0]["goals"][0].clone();
	assert_eq!(json!([g["t"], g["item"], g["itemName"], g["count"]]), json!(["auction", 4306, "Silk Cloth", 20]));
	let names: Vec<Value> = g["candidates"].as_array().unwrap().iter().map(|c| json!([c["npcName"], c["faction"]])).collect();
	assert_eq!(names, vec![json!(["Auctioneer Fitch", "A"])]);
	let both = compile(&text_for(&["step Auction House", "  auction 4306 x20"], None)).steps()[0]["goals"][0].clone();
	let mut f: Vec<&str> = both["candidates"].as_array().unwrap().iter().map(|c| c["faction"].as_str().unwrap()).collect();
	f.sort();
	assert_eq!(f, ["A", "H"]);
	assert!(!both["candidates"].as_array().unwrap().iter().any(|c| c["npcName"] == "Booty Bay Auctioneer"));
}

#[test]
fn auction_needs_a_count_takes_no_place_and_refuses_an_item_that_binds_when_picked_up() {
	let errs = |l: &[&str]| compile(&text(l)).errors.join("\n");
	assert_match(&errs(&["step A", "  auction 4306"]), r"`auction` needs a count: `auction <item> xN`");
	assert_match(&errs(&["step A", "  auction 4306 x5 @40,50"]), r"`@x,y` does not apply to `auction`");
	assert_match(&errs(&["step A", "  auction 4306 x5 nearest"]), r"`nearest` does not apply to `auction`");
	let mut t = tables();
	t.get_mut("professions").unwrap()["186"]["materials"] = json!({ "4306": { "name": "Silk Cloth", "bop": true } });
	let bop = data_from(&t, Value::Null, Value::Null);
	assert_match(&compile_with(&text(&["step A", "  auction 4306 x5"]), &bop).errors.join("\n"), r"item 4306 binds when picked up: the Auction House never has it");
}

#[test]
fn collect_gather_is_the_item_s_gather_way_with_the_profession_and_levels_it_takes() {
	let r = compile(&text(&[
		"step Auction House",
		"  auction 2589 x40",
		"  auction 4306 x20",
		"  auction 1210 x2",
		"step Linen",
		"  collect 2589 x40 anywhere gather levels 5-20",
		"step Silk",
		"  collect 4306 x20 @40,50 gather",
		"step Shadowgem",
		"  collect 1210 x2 @40,50 gather Mining 65",
		"step Both",
		"  collect 2589 x40 anywhere gather \"First Aid\" 1 levels 5-20",
	]));
	assert!(r.errors.is_empty(), "{}", r.text);
	let g = first_goals(&r);
	assert_eq!(g[1]["gather"], json!({ "min": 5, "max": 20 }));
	assert_eq!(g[2]["gather"], json!(true));
	assert_eq!(g[3]["gather"], json!({ "skill": "Mining", "skillLine": 186, "rank": 65 }));
	assert_eq!(g[4]["gather"], json!({ "skill": "First Aid", "skillLine": 129, "rank": 1, "min": 5, "max": 20 }));
	assert_eq!(json!([g[1]["count"], g[2]["x"]]), json!([40, 40]));
	let lua = emit(&r.guides);
	assert!(lua.contains("count = 40, gather = { max = 20, min = 5 }"), "{lua}");
	assert!(lua.contains("gather = { rank = 65, skill = \"Mining\", skillLine = 186 }"), "{lua}");
	assert!(lua.contains("t = \"auction\", item = 1210, itemName = \"Shadowgem\", count = 2"), "{lua}");
	assert_eq!(format_for(&r.guides), MATERIALS_FORMAT);
	assert_eq!(needs(MATERIALS_FORMAT), Some("0.4.0"));
	assert_eq!(format_for(&compile(&text(&["step A", "  money 1s"])).guides), MONEY_TASK_FORMAT);
}

#[test]
fn a_malformed_gather_is_an_error_an_unknown_profession_in_quotes_passes_with_a_warning() {
	let r = |l: &[&str]| {
		let mut all = vec!["step Auction House", "  auction 4306 x20", "step S"];
		all.extend_from_slice(l);
		compile(&text(&all))
	};
	let errs = |l: &[&str]| r(l).errors.join("\n");
	assert_match(&errs(&["  collect 4306 x20 @40,50 gather levels 30-15"]), r#"malformed level range "30-15""#);
	assert_match(&errs(&["  collect 4306 x20 @40,50 gather levels thirty"]), r#"malformed level range "thirty""#);
	assert_match(&errs(&["  collect 4306 x20 @40,50 gather Mining 0"]), r#"malformed skill rank "0" after `gather Mining`"#);
	assert_match(&errs(&["  collect 4306 x20 @40,50 gather Juggling 50"]), r#"unknown profession "Juggling"; quote the name to use it anyway: `gather "Juggling" 50`"#);
	assert_match(&errs(&["  collect 4306 @40,50 gather"]), r"`collect … gather` needs a count");
	assert_match(&errs(&["  collect 4306 x2 quest 7.1 gather"]), r"`collect … gather` is a profession material, a bag count: drop `quest`");
	assert_match(&errs(&["  kill 6 x2 gather"]), r"`gather` does not apply to `kill`");
	assert_match(&errs(&["  collect 4306 x20 gather gather"]), r"duplicate `gather`");
	let quoted = r(&["  collect 4306 x20 @40,50 gather \"Juggling\" 50"]);
	assert!(quoted.errors.is_empty(), "{}", quoted.text);
	assert_eq!(quoted.warned("profession \"Juggling\" is not in data").len(), 1, "{}", quoted.text);
	assert_eq!(quoted.steps()[1]["goals"][0]["gather"], json!({ "skill": "Juggling", "rank": 50 }));
}

#[test]
fn a_gather_needs_an_auction_goal_for_its_item_in_the_same_section() {
	let warns = |l: &[&str]| compile(&text(l)).warned("`gather` with no `auction` goal");
	let sections = [
		"section Mining 1-75",
		"step AH",
		"  auction 4306 x20",
		"step Silk",
		"  collect 4306 x20 @40,50 gather",
		"section Mining 75-150",
		"step AH 2",
		"  auction 2589 x10",
		"step Silk 2",
		"  collect 4306 x30 @40,50 gather",
	];
	let w = warns(&sections);
	assert_eq!(w.len(), 1, "{w:?}");
	let src = text(&sections);
	assert_eq!(
		w[0],
		format!(
			"test.guide:{}: `gather` with no `auction` goal for item 4306 in its section: a player who buys materials has nothing that buys it here",
			line_of(&src, "  collect 4306 x30 @40,50 gather")
		)
	);
	assert!(warns(&["step Silk", "  collect 4306 x20 @40,50 gather", "step AH", "  auction 4306 x20"]).is_empty());
	assert!(warns(&["step Silk", "  collect 4306 x20 @40,50 gather"])[0].contains("in its guide"));
	assert!(warns(&["step AH", "  auction 4306 x20"]).is_empty(), "buying only is fine");
}
