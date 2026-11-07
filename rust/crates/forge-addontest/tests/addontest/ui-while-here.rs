//! "While you're here" in the guide window (addon/Polestar/UI/GuideFrame.lua, fillHere), the toast while the window
//! is hidden (UI/WhileHere.lua), the maps (Nav/Layers.lua), and its options (UI/Options.lua), end to end: the real
//! addon in the stub world with a guide registered in Lua. The engine side is in engine-while-here.rs.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.level = 5
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 47.6, 45.1)
w.onQuest(33, { 8 }, "Wolves Across the Border")
w.onQuest(7, { { required = 10, fulfilled = 8 } }, "Kobold Camp Cleanup")
w.onQuest(60, { { text = "Large Candle: 1/3", type = "item", required = 3, fulfilled = 1 } }, "Candles")
"#;

// 1 (live) kill 8 wolves far away · 2 kill 10 vermin (8 done) at 47.6,35.1 · 3 collect 3 candles (1 done) in two
// spawn areas around 52,35.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/here", pack = "test", title = "Here", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "Vermin", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Candles", goals = { { t = "collect", item = 772, itemName = "Large Candle", count = 3, quest = 60, oi = 1, map = 1429, x = 52.0, y = 35.1,
			spots = { { x = 52.0, y = 35.1, r = 15, n = 3 }, { x = 53.0, y = 36.0, r = 10, n = 2 } } } } },
	},
})
"#;

const HELPERS: &str = r#"
local w = stub.world
local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
local H = GF.parts.here
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
local function top(f) local _, _, _, _, y = f:GetPoint(1); return y end
local function line()
	return { shown = H:IsShown(), text = plain(H.Text:GetText()), dist = H.Dist:GetText(),
		top = H:IsShown() and top(H) or false, after = GF.parts.after:IsShown() and top(GF.parts.after) or false }
end
local function toast()
	local t = PolestarWhileHereToast
	return t and t:IsShown() and plain(t.Text:GetText()) or false
end
"#;

fn run(before_login: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/here" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, before_login, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, HELPERS, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn the_line_slides_in_between_the_goals_and_then_a_click_points_the_arrow_a_right_click_dismisses_it() {
	let out = run(
		"",
		r#"
		emit(line())
		w.moveTo(1429, 47.6, 37.6); stub.advance(0.55)
		local sliding = { Polestar.Anim.IsRunning(H.Body, "alpha"), Polestar.Anim.IsRunning(H.Body, "offsetX") }
		stub.advance(0.5)
		emit({ line = line(), sliding = sliding, alpha = H.Body:GetAlpha(), toast = toast() })
		H:GetScript("OnClick")(H, "LeftButton"); stub.advance(0.2)
		local t = Polestar.Nav.GetTarget()
		emit(t and { t.stepIndex, t.goalIndex } or false)
		H:GetScript("OnClick")(H, "RightButton"); stub.advance(0.05)
		local leaving = { H:IsShown(), Polestar.Anim.IsRunning(H.Body, "alpha") }
		stub.advance(0.4)
		t = Polestar.Nav.GetTarget()
		emit({ leaving = leaving, shown = H:IsShown(), engine = E.GetWhileHere() == nil, target = t and { t.stepIndex, t.goalIndex } or false })
	"#,
	);
	assert_eq!(out[0]["shown"], false, "nothing close by");
	let shown = &out[1];
	assert_eq!(shown["line"]["shown"], true);
	assert_eq!(shown["line"]["text"], "While you're here: Kill Kobold Vermin, 2 more  (step 2)");
	assert_eq!(shown["line"]["dist"], "50 yd");
	assert!(shown["line"]["after"].is_number(), "\"Then:\" shows: {shown}");
	assert!(shown["line"]["top"].as_f64().unwrap() > shown["line"]["after"].as_f64().unwrap(), "the line sits above \"Then:\": {shown}");
	assert_eq!(shown["sliding"], json!([true, true]), "it slides in as it fades in");
	assert_eq!(shown["alpha"], 1);
	assert_eq!(shown["toast"], false, "the window shows it: no toast");
	assert_eq!(out[2], json!([2, 1]), "a click leads the arrow to the vermin");
	let gone = &out[3];
	assert_eq!(gone["leaving"], json!([true, true]), "it fades out before the window closes the gap");
	assert_eq!(gone["shown"], false);
	assert_eq!(gone["engine"], true);
	assert_eq!(gone["target"], json!([1, 1]), "the arrow is back on the step's wolves");
}

#[test]
fn reduced_motion_the_line_fades_in_without_sliding() {
	let out = run(
		r#"Polestar.Set("ui.reduceMotion", true)"#,
		r#"
		w.moveTo(1429, 47.6, 37.6); stub.advance(0.55)
		emit({ H:IsShown(), Polestar.Anim.IsRunning(H.Body, "offsetX"), Polestar.Anim.IsRunning(H.Body, "alpha") })
	"#,
	);
	assert_eq!(out, vec![json!([true, false, true])]);
}

#[test]
fn with_the_window_hidden_or_compact_one_small_toast_says_it_once() {
	let out = run(
		r#"Polestar.Set("ui.compact", true)"#,
		r#"
		w.moveTo(1429, 47.6, 37.6); stub.advance(1.1)
		emit({ line = H:IsShown(), toast = toast() })
		stub.advance(9)
		emit(toast())                                       -- it closes itself
		local t = PolestarWhileHereToast
		w.moveTo(1429, 47.6, 45.1); stub.advance(1.1)        -- the line goes
		w.moveTo(1429, 47.6, 37.6); stub.advance(1.1)        -- and comes again: a new toast
		local again = toast()
		t:GetScript("OnClick")(t, "RightButton"); stub.advance(0.5)
		emit({ again = again, after = toast(), engine = E.GetWhileHere() == nil })
	"#,
	);
	assert_eq!(out[0], json!({ "line": false, "toast": "Kill Kobold Vermin, 2 more  \u{b7}  50 yd" }));
	assert_eq!(out[1], json!(false));
	assert_eq!(out[2], json!({ "again": "Kill Kobold Vermin, 2 more  \u{b7}  50 yd", "after": false, "engine": true }));
	let hidden = run(r#"Polestar.Set("ui.shown", false)"#, r#"w.moveTo(1429, 47.6, 37.6); stub.advance(1.1); emit(toast())"#);
	assert_eq!(hidden, vec![json!("Kill Kobold Vermin, 2 more  \u{b7}  50 yd")]);
}

#[test]
fn the_maps_show_its_spawn_area_like_an_along_goal_in_the_arrow_s_colour_once_clicked() {
	let out = run(
		"",
		r#"
		w.moveTo(1429, 52.0, 38.0); stub.advance(1.1)
		local v = E.GetWhileHere()
		local P = Polestar.Pins
		local function n(name) local l = P.GetLayer(name); return l and #l or 0 end
		emit({ here = v and v.step or false, text = v and v.hereText or false, others = n("nav.goalAreas"), own = n("nav.areas") })
		H:GetScript("OnClick")(H, "LeftButton"); stub.advance(0.3)
		emit({ others = n("nav.goalAreas"), own = n("nav.areas") })
	"#,
	);
	assert_eq!(out[0]["here"], 3);
	assert_eq!(out[0]["text"], "Collect Large Candle, 2 more");
	assert!(out[0]["others"].as_i64().unwrap() > 0, "its spawn area on the world map: {}", out[0]);
	assert!(out[1]["own"].as_i64().unwrap() > 0, "clicked, it is the arrow's: {}", out[1]);
}

#[test]
fn the_options_sit_in_the_window_tab_on_by_default_the_radius_from_40_to_120_yards() {
	let out = run(
		"",
		r#"
		local UI, O = Polestar.UI, Polestar.UI.Options
		UI.ShowOptions("guide")
		local c = O.Controls("guide", "Window")
		local on, radius, turnins = c["behavior.whileHere"], c["behavior.whileHereRadius"], c["behavior.whileHereTurnins"]
		local before = { on ~= nil, radius ~= nil, turnins ~= nil, Polestar.Get("behavior.whileHere"), Polestar.Get("behavior.whileHereRadius"), Polestar.Get("behavior.whileHereTurnins") }
		stub.RunScript(radius.Slider, "OnValueChanged", 118, true)
		local wide = Polestar.Get("behavior.whileHereRadius")
		on:Click()
		emit({ before = before, wide = wide, off = Polestar.Get("behavior.whileHere"), radiusEnabled = radius:IsEnabled(), turninsEnabled = turnins:IsEnabled() })
	"#,
	);
	assert_eq!(out[0]["before"], json!([true, true, true, true, 60, true]));
	assert_eq!(out[0]["wide"], 120, "the slider steps by 5 yards");
	assert_eq!(out[0]["off"], false);
	assert_eq!(out[0]["radiusEnabled"], false, "its children grey out with it off");
	assert_eq!(out[0]["turninsEnabled"], false);
}
