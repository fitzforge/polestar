//! The Quest room (UI/QuestRoom.lua) with the log of a player who installs Polestar mid-leveling: thirty quests
//! from all over, none of them on the route, every fifth finished. One row per quest would stand 1,300 tall:
//! the window keeps to the screen instead (1080 high, and a 1366x768 screen at UI scale 1), its rows scrolling
//! inside it, every one reachable, the title, the close button, the switch to the finished quests and Guide me
//! outside the list and in reach; a quest's title or second line cut short reads whole in its tooltip, and the
//! second line keeps inside the window.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const LONG: &str = "Duskwood Mission XVIII: Rescue Elenora Marshwalker";

fn world(height: u32) -> String {
	format!(
		r#"
local w = stub.world
w.addMap(1429, {{ name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }})
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.level = 34
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 42.5, 36.0)
UIParent.height = {height}
for i = 1, 30 do
	w.onQuest(9000 + i, i % 5 == 0 and {{}} or {{ 8 }}, i == 1 and "{LONG}" or i == 5 and "{LONG} (finished)" or ("Quest " .. i))
end
"#
	)
}

// One guide that hands none of them in.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", faction = "Alliance", minLevel = 30, maxLevel = 40, steps = {
	{ title = "Far", goals = { { t = "goto", map = 1429, x = 70, y = 70 } } },
} })
"#;

// Every finished one is taken in by an NPC with a long name in a zone with a long name.
const ENDER: &str = r#"
Polestar.RoutePlan.Ender = function(q)
	return { npc = 7000 + q, name = "Самонаводящийся робот КПХ-9/HL", zone = "Внутренние земли Хинтерленда", map = 1429, x = 50, y = 50 }
end
"#;

fn run(height: u32, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: world(height),
		addons: vec![Addon::name("Polestar")],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			GUIDE,
			ENDER,
			"stub.login()",
			r#"Polestar.Set("behavior.autoAccept", false); Polestar.Set("ui.shown", true)"#,
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"Polestar.Engine.SetGuide("test/a"); stub.advance(0.6); stub.advance(0.6)"#,
			r#"local UI, F = Polestar.UI
-- The window's measures, and its rows: shown, inside the scroll list, each title's and second line's own text
-- and width.
function measure(mode)
	UI.ShowQuestRoom(mode)
	F = PolestarQuestRoom
	local list = rawget(F, "List")
	local rows, inList, widths = 0, 0, true
	for _, r in ipairs(F.rows) do
		if r:IsShown() then
			rows = rows + 1
			if list and r:GetParent() == list.Child then inList = inList + 1 end
			local w = r.Why:GetWidth()
			if not (w > 0 and w <= F:GetWidth() - 48) then widths = false end
		end
	end
	return { height = F:GetHeight(), screen = UIParent:GetHeight(), rows = rows, inList = inList, widths = widths,
		scrolls = list ~= nil and list.psContent ~= nil and list.psContent > list:GetHeight(),
		switch = F.Switch:IsShown() and F.Switch:GetParent() == F, guideMe = F.GuideMe:GetParent() == F }
end"#,
			script,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn make_room_keeps_to_a_1080_screen_with_thirty_quests_scrolling_inside_it() {
	let out = run(1080, "emit(measure())");
	assert!(out["height"].as_f64().unwrap() <= 1080.0 - 48.0, "the window stands taller than the screen: {out}");
	assert_eq!(out["rows"], 30, "{out}");
	assert_eq!(out["inList"], 30, "every row in the scroll list: {out}");
	assert_eq!(out["scrolls"], true, "{out}");
	assert_eq!(out["switch"], true, "the switch to the finished quests sits on the window, under the list: {out}");
}

#[test]
fn make_room_and_the_finished_list_keep_to_a_1366x768_screen_at_ui_scale_1() {
	let out = run(768, r#"emit({ room = measure(), carried = measure("carried") })"#);
	for mode in ["room", "carried"] {
		let m = &out[mode];
		assert!(m["height"].as_f64().unwrap() <= 768.0 - 48.0, "{mode}: the window stands taller than the screen: {out}");
		assert_eq!(m["inList"], m["rows"], "{mode}: {out}");
	}
	assert_eq!(out["carried"]["rows"], 6, "{out}");
	assert_eq!(out["carried"]["guideMe"], true, "{out}");
	assert_eq!(out["carried"]["widths"], true, "the second line keeps inside the window: {out}");
}

#[test]
fn a_title_or_second_line_cut_short_reads_whole_in_its_tooltip() {
	let out = run(
		1080,
		r#"measure("carried")
local r = F.rows[1]
GameTooltip.lines = {}
stub.RunScript(r, "OnEnter")
local tip = GameTooltip.lines
stub.RunScript(r, "OnLeave")
emit({ title = r.Title:GetText(), cut = r.Title:IsTruncated() or r.Why:IsTruncated(), tip = tip, owner = GameTooltip:GetOwner() == r })"#,
	);
	assert_eq!(out["cut"], true, "{out}");
	assert_eq!(out["owner"], true, "{out}");
	assert_eq!(out["tip"][0], format!("{LONG} (finished)"), "{out}");
	assert_eq!(out["tip"][1], "Самонаводящийся робот КПХ-9/HL, Внутренние земли Хинтерленда", "{out}");
	assert_eq!(out["title"], json!(format!("{LONG} (finished)")), "{out}");
}
