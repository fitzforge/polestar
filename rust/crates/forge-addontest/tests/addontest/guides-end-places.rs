//! The 0.3.5 report "You've reached the end of this guide" at step 2 of 45 of Hillsbrad Foothills & Arathi
//! Highlands (30-32), on the real guides (compiled from guides/ with data/forever; skipped with a note without it)
//! and the full addon: a level 30 Orc Warrior opens it at Freewind Post, where the guide starts, and walks into the
//! Undercity (a hearth, the zeppelin, a trainer). The guide's last step flies back to the Undercity, and its own
//! stop there earlier did not count as work in that place, so 0.3.5 and 0.3.6's first candidate told the end with
//! 31 steps open and kept it (CharState().guideEnds): the guide window's banner on every step from then on. Where
//! the player stands is no end ahead of the live step (Engine, Own.byPresence): no GUIDE_END, no banner.
//!
//! And Shen'dralas, whose last step for everyone is a group quest (Mana Mania, `when group`) that Historian
//! Biraxas's hand-in opens: played in order, the guide asks at that step and ends either way once answered.

use forge_addontest::dsl::{compile_with, our_manifest, write_test_pack, TestPack};
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

// The guides under `prefix` compiled with data/forever and loaded as Polestar_Guides (the pack: its files live as
// long as it does), and the map frames of `eras` for the stub world; None without the reference data.
fn compiled(prefix: &str, eras: &[&str]) -> Option<(TestPack, String, String)> {
	let data_dir = root().join("data/forever");
	if !data_dir.exists() {
		eprintln!("skipped: no reference data at data/forever");
		return None;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let dir = root().join("guides");
	let files: Vec<String> = find_guide_files(&dir, false).into_iter().filter(|f| f.starts_with(prefix)).collect();
	let texts: Vec<(String, String)> = files.iter().map(|f| (format!("guides/{f}"), std::fs::read_to_string(dir.join(f)).unwrap())).collect();
	let sources: Vec<(&str, &str)> = texts.iter().map(|(f, t)| (f.as_str(), t.as_str())).collect();
	let compiled = compile_with(&sources, &data, None);
	let pack = write_test_pack(&compiled.guides, &data, &our_manifest());
	let lines: Vec<String> = pack.scripts.iter().map(|f| format!("assert(loadfile({}))(\"Polestar_Guides\", ns)", serde_json::to_string(f).unwrap())).collect();
	let loads = format!("do local ns = {{}}\n{}\nend", lines.join("\n"));
	let mut maps = String::new();
	for era in eras {
		for (id, f) in data.map_frames.get(era).as_obj().map(|o| o.entries()).unwrap_or_default() {
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
	}
	Some((pack, loads, maps))
}

#[test]
fn hillsbrad_30_32_the_undercity_near_the_start_is_no_end_and_no_banner() {
	let Some((_pack, loads, maps)) = compiled("forever/horde/30-40/0", &["forever"]) else { return };
	let before = format!(
		"local w = stub.world\n{maps}w.race, w.raceName = \"Orc\", \"Orc\"\nw.class, w.className = \"WARRIOR\", \"WARRIOR\"\nw.faction = \"Horde\"\nw.level = 30\nw.moveTo(1441, 45.0, 49.1)\n"
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script: SCRIPT.replace("${loads}", &loads), ..Default::default() });
	assert_eq!(out[0], json!({ "ends": {}, "ended": false, "banner": false, "moved": false }));
}

const SHENDRALAS: &str = r#"
${loads}
stub.login()
stub.fire("QUEST_LOG_UPDATE")
Polestar.Set("behavior.autoAccept", false)
Polestar.Set("behavior.autoTurnin", false)
Polestar.Set("ui.shown", true)
local E, w = Polestar.Engine, stub.world
local B = Polestar.UI.GuideFrame.parts.banner
local ID = "forever/40-50/shendralas"
local ENDS = {}
Polestar.On("GUIDE_END", function(id, i) ENDS[#ENDS + 1] = { id = id, undone = i.undone } end)
E.SetGuide(ID)
stub.advance(3)
local g = E.GetGuide()
-- At Historian Biraxas (the steps before done and passed), A Heart of Crystal done in the log.
local at
for i, step in ipairs(g.steps) do if step.title == "Historian Biraxas" then at = i end end
local sk = {}
for i = 1, at - 1 do sk[i] = true end
Polestar.CharState().skipped[ID] = sk
stub.fire("QUEST_LOG_UPDATE"); stub.advance(2)
local r = { at = E.GetLiveStep() == at }
w.turnIn(99257); stub.advance(3)
local live = E.GetLiveStep()
r.asks = { live and g.steps[live].title or false, E.GroupQuestion() or false, B:IsShown() and B.psKind or false, #ENDS }
if @DO@ then
	B.Later:Click(); stub.advance(2)
	w.accept(99258, { 0 }); stub.advance(1); w.finish(99258); stub.advance(1); w.turnIn(99258); stub.advance(3)
else
	B.Jump:Click(); stub.advance(3)
end
-- The Horde's last step: the flight from Shadowprey Village to Orgrimmar.
if w.faction == "Horde" and not ENDS[1] then
	w.moveTo(1443, 21.56, 74.04); w.setZone("Desolace", "Shadowprey Village"); stub.advance(2)
	w.setZone("Orgrimmar", "Orgrimmar"); stub.advance(3)
end
r.ends = ENDS
r.ended = E.GuideEnded(ID)
emit(r)
"#;

// The steps before Biraxas done (their quests handed in), A Heart of Crystal done: the hand-in opens Mana Mania,
// whose banner asks (Skip it, the default, or Do it with a group). Skipped, the guide ends (the Alliance's closing
// note is no step to wait on; the Horde's flight to Orgrimmar first); done with a group, it ends after its hand-in.
#[test]
fn shendralas_played_in_order_asks_at_mana_mania_and_ends_either_way_once_answered() {
	let Some((_pack, loads, maps)) = compiled("forever/40-50/shendralas", &["forever", "era"]) else { return };
	let done = "93644, 92914, 96010, 96018, 93016, 93394, 93341, 93362, 93594";
	for (race, faction, level, group) in [("Human", "Alliance", 45, false), ("Human", "Alliance", 45, true), ("Orc", "Horde", 47, false)] {
		let before = format!(
			"local w = stub.world\n{maps}w.race, w.raceName = {race:?}, {race:?}\nw.class, w.className = \"WARRIOR\", \"WARRIOR\"\nw.faction = {faction:?}\nw.level = {level}\nw.complete({{ {done} }})\nw.accept(99257, {{}}); w.finish(99257)\n"
		);
		let script = SHENDRALAS.replace("${loads}", &loads).replace("@DO@", if group { "true" } else { "false" });
		let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() });
		let who = format!("{faction}, group {group}");
		assert_eq!(out[0]["at"], true, "{who}: {}", out[0]);
		assert_eq!(out[0]["asks"], json!(["Mana Mania", 99258, "group", 0]), "{who}: the hand-in opens Mana Mania, which asks: {}", out[0]);
		assert_eq!(out[0]["ends"], json!([{ "id": "forever/40-50/shendralas", "undone": 0 }]), "{who}: {}", out[0]);
		assert_eq!(out[0]["ended"], true, "{who}");
	}
}

const AHEAD: &str = r#"
${loads}
stub.login()
stub.fire("QUEST_LOG_UPDATE")
Polestar.Set("behavior.autoAccept", false)
Polestar.Set("behavior.autoTurnin", false)
local E, w = Polestar.Engine, stub.world
local ID = "forever/40-50/shendralas"
local ENDS, LEFT = {}, {}
Polestar.On("GUIDE_END", function(id, i) ENDS[#ENDS + 1] = { id = id, undone = i.undone } end)
Polestar.On("GUIDE_STEPS_LEFT", function(id, i) LEFT[#LEFT + 1] = i.left end)
E.SetGuide(ID)
stub.advance(3)
local g = E.GetGuide()
local mithera, biraxas
for i, step in ipairs(g.steps) do
	if step.title == "Mithera" then mithera = i end
	if step.title == "Historian Biraxas" then biraxas = i end
end
-- At Mithera (the steps before passed), her quest ready to hand in, A Heart of Crystal ready too.
local sk = {}
for i = 1, mithera - 1 do sk[i] = true end
Polestar.CharState().skipped[ID] = sk
stub.fire("QUEST_LOG_UPDATE"); stub.advance(2)
local r = { at = E.GetLiveStep() == mithera }
-- Biraxas's quest handed in ahead of the live step: Mana Mania opens after the guide's end.
w.turnIn(99257); stub.advance(3)
r.ahead = { E.GetLiveStep() == mithera, #ENDS }
-- Mithera's hand-in: the route comes to Mana Mania, which asks; skipped from Options, the end moves back to Biraxas.
w.turnIn(93362); stub.advance(3)
local live = E.GetLiveStep()
r.asks = { live and g.steps[live].title or false, E.GroupQuestion() or false }
E.AnswerGroup(99258, "skip"); stub.advance(3)
r.ends, r.left, r.ended = ENDS, LEFT, E.GuideEnded(ID)
emit(r)
"#;

// #3330: Biraxas's hand-in done ahead of the live step, the Mana Mania question answered from Options once the route
// gets there. The answer moves the guide's end back to Biraxas, which was seen open as the last step before Mana Mania
// opened: the end comes, once nothing required is left (#3517).
#[test]
fn shendralas_biraxas_handed_in_ahead_then_mana_mania_skipped_from_options_ends_the_guide() {
	let Some((_pack, loads, maps)) = compiled("forever/40-50/shendralas", &["forever", "era"]) else { return };
	let done = "93644, 92914, 96010, 96018, 93016, 93394, 93341, 93594";
	let before = format!(
		"local w = stub.world\n{maps}w.race, w.raceName = \"Human\", \"Human\"\nw.class, w.className = \"WARRIOR\", \"WARRIOR\"\nw.faction = \"Alliance\"\nw.level = 45\nw.complete({{ {done} }})\nw.accept(93362, {{}}); w.finish(93362)\nw.accept(99257, {{}}); w.finish(99257)\n"
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script: AHEAD.replace("${loads}", &loads), ..Default::default() });
	assert_eq!(out[0]["at"], true, "{}", out[0]);
	assert_eq!(out[0]["ahead"], json!([true, 0]), "handed in ahead: no end while Mithera's step is open: {}", out[0]);
	assert_eq!(out[0]["asks"], json!(["Mana Mania", 99258]), "{}", out[0]);
	assert_eq!(out[0]["ends"], json!([{ "id": "forever/40-50/shendralas", "undone": 0 }]), "{}", out[0]);
	assert_eq!(out[0]["ended"], true);
}
