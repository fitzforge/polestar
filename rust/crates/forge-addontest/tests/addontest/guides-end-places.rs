//! The 0.3.5 report "You've reached the end of this guide" at step 2 of 45 of Hillsbrad Foothills & Arathi
//! Highlands (30-32), on the real guides (compiled from guides/ with data/forever; skipped with a note without it)
//! and the full addon: a level 30 Orc Warrior opens it at Freewind Post, where the guide starts, and walks into the
//! Undercity (a hearth, the zeppelin, a trainer). The guide's last step flies back to the Undercity, and its own
//! stop there earlier did not count as work in that place, so 0.3.5 and 0.3.6's first candidate told the end with
//! 31 steps open and kept it (CharState().guideEnds): the guide window's banner on every step from then on. Where
//! the player stands is no end ahead of the live step (Engine, Own.byPresence): no GUIDE_END, no banner.

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack};
use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use forge_guide::project::find_guide_files;
use serde_json::json;

const SCRIPT: &str = r#"
${loads}
stub.login()
stub.fire("QUEST_LOG_UPDATE")
local E, w = Polestar.Engine, stub.world
local ID = "forever/horde/30-40/01-hillsbrad-foothills"
local ENDS = {}
Polestar.On("GUIDE_END", function(id, i) ENDS[#ENDS + 1] = { id = id, undone = i.undone, live = i.live or false } end)
w.setZone("Thousand Needles", "Freewind Post")
E.SetGuide(ID)
stub.advance(3)
local start = E.GetLiveStep()
w.moveTo(1458, 60, 50)
w.setZone("Undercity", "Undercity")
stub.advance(3)
local offer = Polestar.UI.GuideFrame.EndOffer(E, E.GetGuide())
emit({ ends = ENDS, ended = E.GuideEnded(ID), banner = offer and offer.label or false, moved = E.GetLiveStep() ~= start })
"#;

#[test]
fn hillsbrad_30_32_the_undercity_near_the_start_is_no_end_and_no_banner() {
	let data_dir = root().join("data/forever");
	if !data_dir.exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let dir = root().join("guides");
	let files: Vec<String> = find_guide_files(&dir, false).into_iter().filter(|f| f.starts_with("forever/horde/30-40/0")).collect();
	let texts: Vec<(String, String)> = files.iter().map(|f| (format!("guides/{f}"), std::fs::read_to_string(dir.join(f)).unwrap())).collect();
	let sources: Vec<(&str, &str)> = texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let compiled = compile_with(&sources, &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let mut maps = String::new();
	for (id, f) in data.map_frames.get("forever").as_obj().map(|o| o.entries()).unwrap_or_default() {
		let id = id.to_string();
		let name = data.zones.get(&id).get("name").to_js_string();
		maps.push_str(&format!(
			"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})\n",
			serde_json::to_string(if name == "undefined" { "" } else { &name }).unwrap(),
			f.get("c").to_js_string(),
			f.get("left").to_js_string(),
			f.get("right").to_js_string(),
			f.get("top").to_js_string(),
			f.get("bottom").to_js_string()
		));
	}
	let before = format!(
		"local w = stub.world\n{maps}w.race, w.raceName = \"Orc\", \"Orc\"\nw.class, w.className = \"WARRIOR\", \"WARRIOR\"\nw.faction = \"Horde\"\nw.level = 30\nw.moveTo(1441, 45.0, 49.1)\n"
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script: SCRIPT.replace("${loads}", &loads), ..Default::default() });
	assert_eq!(out[0], json!({ "ends": {}, "ended": false, "banner": false, "moved": false }));
}
