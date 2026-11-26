//! Free mode (#3701, addon/Polestar/Lookup/Free.lua): the character's own quest log as a guide in a tab of its own,
//! the quests in the order of the pick rule (nearest first, or most XP a minute first), a pinned quest first, a quest
//! left out not listed, a zone hint when the log has nothing near, and the way back to the guide the player came from.
//! The cases grew from AreChen's prototype's (#4104): objective progress moving the arrow on, and handing the arrow
//! back to the guide.
//!
//! The Codex is the synthetic tests/fixtures/codex/free-mode.json: a Human Warrior at level 20 at Marshal Hale's
//! camp (map 9001, 50,50; a map is 2,000 yards across, so a map percent is 20 yards), with
//!   7001 Gnoll Trouble         kill 5 Ridge Gnolls, 100 yd east; Hale takes it back (1,200 XP)
//!   7002 Boar Hunt             4 Boar Tusks (60%) from the Hill Boars, 400 yd west; Ranger Ilse (2,400 XP)
//!   7003 Lurkers in the Marsh  6 Marsh Lurkers, 1,000 yd north-west (900 XP)
//!   7004 Ogre Menace           level 26: 3 Highland Ogres right beside the camp (3,000 XP)
//!   7005 Gnoll Ears            6 Gnoll Ears, 8% from the Ridge Gnolls (1,100 XP)
//! and quests to take: 7110 at Marshal Hale; four in Merrow Fields (map 9002), three of them around Scout Merrow;
//! one there for the Horde, one done, one too high, one behind a prerequisite not done.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::{emitted, text, truthy, Addon, RunAddon};
use serde_json::Value;

thread_local! {
	static PACK: CodexPack = write_codex_pack(&fixture("free-mode.json"), &CodexOpts::default());
}

const CORE: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Lookup/Lookup.xml"];

fn maps() -> String {
	let codex = fixture("free-mode.json");
	let mut frames: Vec<(&String, &Value)> = codex["frames"].as_object().unwrap().iter().collect();
	frames.sort_by_key(|(id, _)| id.parse::<u64>().unwrap_or(u64::MAX));
	frames
		.into_iter()
		.map(|(id, f)| {
			format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})",
				serde_json::to_string(&codex["zones"][id.as_str()]["name"]).unwrap(),
				f["c"],
				f["left"],
				f["right"],
				f["top"],
				f["bottom"]
			)
		})
		.collect::<Vec<_>>()
		.join("\n")
}

// Helpers the scripts share: the quests as the log takes them, the step titles in order, the live step's.
const HELPERS: &str = r#"
local E, F = Polestar.Engine, Polestar.Free
local Q = {
	[7001] = { { text = "Ridge Gnoll slain: 0/5", required = 5 } },
	[7002] = { { text = "Boar Tusk: 0/4", required = 4, type = "item" } },
	[7003] = { { text = "Marsh Lurker slain: 0/6", required = 6 } },
	[7004] = { { text = "Highland Ogre slain: 0/3", required = 3 } },
	[7005] = { { text = "Gnoll Ear: 0/6", required = 6, type = "item" } },
}
local TITLE = { [7001] = "Gnoll Trouble", [7002] = "Boar Hunt", [7003] = "Lurkers in the Marsh", [7004] = "Ogre Menace", [7005] = "Gnoll Ears" }
local function take(...)
	for _, q in ipairs({ ... }) do w.accept(q, Q[q], TITLE[q]) end
	stub.advance(1)
end
local function titles()
	local out = {}
	for i = 1, E.GetStepCount() do out[i] = E.GetStepView(i).title end
	return out
end
local function live()
	local i = E.GetStepIndex()
	return i and E.GetStepView(i).title or nil
end
local function label()
	local wp = E.GetWaypoint()
	return wp and wp.label or nil
end
"#;

struct Opts {
	files: Option<&'static [&'static str]>,
	saved: Option<&'static str>,
	setup: &'static str,
}

impl Default for Opts {
	fn default() -> Opts {
		Opts { files: Some(CORE), saved: None, setup: "" }
	}
}

fn run_with(script: &str, o: &Opts) -> Vec<Value> {
	let pack = PACK.with(|p| p.stub_lua.clone());
	let before = format!(
		"{pack}\nlocal w = stub.world\n{}\nw.level, w.race, w.raceName, w.faction = 20, \"Human\", \"Human\", \"Alliance\"\nw.class, w.className = \"WARRIOR\", \"Warrior\"\nw.moveTo(9001, 50, 50)\n{}",
		maps(),
		o.setup
	);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before,
		addons: vec![match o.files {
			Some(files) => Addon::files("Polestar", files),
			None => Addon::name("Polestar"),
		}],
		saved: o.saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		login: true,
		script: format!("{HELPERS}{script}"),
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, &Opts::default())
}

fn strs(v: &Value) -> Vec<String> {
	v.as_array().unwrap().iter().map(|s| text(s).to_string()).collect()
}

#[test]
fn the_arrow_takes_the_nearest_quest_then_the_next_once_it_is_handed_in() {
	let out = run(r#"
take(7001, 7002, 7003)
assert(F.Start())
stub.advance(1)
emit({ guide = E.GetGuide().id, titles = titles(), live = live(), label = label() })
-- Its kills done: the hand-in at Marshal Hale, two steps from here, before anything else.
w.progress(7001, 1, 5)
stub.advance(1)
emit({ titles = titles(), live = live(), label = label() })
w.turnIn(7001)
stub.advance(1)
emit({ titles = titles(), live = live(), label = label() })
"#);
	assert_eq!(text(&out[0]["guide"]), "lookup/free/log");
	assert_eq!(strs(&out[0]["titles"]), ["Gnoll Trouble", "Boar Hunt", "Lurkers in the Marsh"]);
	assert_eq!(text(&out[0]["live"]), "Gnoll Trouble");
	assert_eq!(text(&out[0]["label"]), "Kill Ridge Gnoll");
	assert_eq!(text(&out[1]["live"]), "Gnoll Trouble");
	assert_eq!(text(&out[1]["label"]), "Turn in \u{201c}Gnoll Trouble\u{201d}");
	assert_eq!(strs(&out[2]["titles"]), ["Boar Hunt", "Lurkers in the Marsh"]);
	assert_eq!(text(&out[2]["live"]), "Boar Hunt");
}

#[test]
fn most_xp_a_minute_puts_the_better_paying_quest_first_and_says_its_rate() {
	let out = run(r#"
take(7001, 7002, 7003)
Polestar.Set("free.pick", "xp")
assert(F.Start())
stub.advance(1)
emit({ titles = titles(), note = E.GetStepView(1).note })
Polestar.Set("free.pick", "near")
stub.advance(1)
emit({ titles = titles() })
"#);
	// Boar Hunt: 2,400 XP over about 57 s of walking and 103 s of work, ahead of Gnoll Trouble's 1,200 over 164 s.
	assert_eq!(strs(&out[0]["titles"])[0], "Boar Hunt");
	assert!(text(&out[0]["note"]).starts_with("About "), "{}", out[0]["note"]);
	assert!(text(&out[0]["note"]).contains("XP a minute"), "{}", out[0]["note"]);
	assert_eq!(strs(&out[1]["titles"])[0], "Gnoll Trouble");
}

#[test]
fn a_quest_well_above_the_player_comes_after_the_rest_however_near() {
	let out = run(r#"
take(7004, 7002)
assert(F.Start())
stub.advance(1)
emit({ titles = titles() })
"#);
	assert_eq!(strs(&out[0]["titles"]), ["Boar Hunt", "Ogre Menace"]);
}

#[test]
fn a_pinned_quest_comes_first_and_a_left_out_one_goes_until_it_leaves_the_log() {
	let out = run(r#"
take(7001, 7002, 7003)
assert(F.Start())
stub.advance(1)
F.Pin(7003, true)
stub.advance(1)
emit({ titles = titles(), live = live(), pinned = F.Pinned() })
F.Pin(7003, false)
F.LeaveOut(7001, true)
stub.advance(1)
emit({ titles = titles(), out = F.LeftOut(), saved = PolestarCharDB.free.out[7001] == true })
-- Abandoned, it takes its "left out" with it; taken again, it is listed.
w.abandon(7001)
stub.advance(1)
take(7001)
stub.advance(1)
emit({ titles = titles(), out = F.LeftOut() })
"#);
	assert_eq!(strs(&out[0]["titles"])[0], "Lurkers in the Marsh");
	assert_eq!(text(&out[0]["live"]), "Lurkers in the Marsh");
	assert_eq!(out[0]["pinned"], 7003);
	assert_eq!(strs(&out[1]["titles"]), ["Boar Hunt", "Lurkers in the Marsh"]);
	assert_eq!(out[1]["out"], serde_json::json!([7001]));
	assert!(truthy(&out[1]["saved"]));
	assert_eq!(strs(&out[2]["titles"])[0], "Gnoll Trouble");
	assert!(out[2]["out"].as_array().is_none_or(|a| a.is_empty()), "{}", out[2]["out"]);
}

#[test]
fn the_first_quest_holds_against_a_small_move_and_gives_way_to_a_clear_one() {
	// Gnoll Trouble's gnolls 100 yd east, Boar Hunt's boars 400 yd west. 160 yd west the boars are 20 yd nearer
	// than the gnolls: too little to move the arrow off them. Standing by the boars, they come first.
	let out = run(r#"
take(7001, 7002)
assert(F.Start())
stub.advance(1)
local first = titles()[1]
w.moveTo(9001, 42, 50)
F.Plan(true)
stub.advance(1)
local small = titles()[1]
w.moveTo(9001, 31, 50)
F.Plan(true)
stub.advance(1)
emit({ first = first, small = small, far = titles()[1] })
"#);
	assert_eq!(text(&out[0]["first"]), "Gnoll Trouble");
	assert_eq!(text(&out[0]["small"]), "Gnoll Trouble");
	assert_eq!(text(&out[0]["far"]), "Boar Hunt");
}

#[test]
fn hand_ins_carry_their_xp_and_a_rare_drop_says_so() {
	let out = run(r#"
take(7005, 7002)
assert(F.Start())
stub.advance(1)
local lines = {}
for i = 1, E.GetStepCount() do
	for _, g in ipairs(E.GetStepView(i).goals) do
		lines[#lines + 1] = { step = E.GetStepView(i).title, t = g.t, note = g.note, xp = g.rewards and g.rewards.xp }
	end
end
emit(lines)
Polestar.Set("free.details", false)
stub.advance(1)
local v = E.GetStepView(1)
emit({ note = v.goals[1].note, xp = v.goals[#v.goals].rewards })
"#);
	let lines = out[0].as_array().unwrap();
	let ear = lines.iter().find(|l| text(&l["step"]) == "Gnoll Ears" && text(&l["t"]) == "collect").unwrap();
	assert_eq!(text(&ear["note"]), "Low drop rate: 8%");
	let tusk = lines.iter().find(|l| text(&l["step"]) == "Boar Hunt" && text(&l["t"]) == "collect").unwrap();
	assert!(tusk["note"].is_null(), "{}", tusk["note"]);
	let hale = lines.iter().find(|l| text(&l["step"]) == "Gnoll Ears" && text(&l["t"]) == "turnin").unwrap();
	assert_eq!(hale["xp"], 1100);
	let ilse = lines.iter().find(|l| text(&l["step"]) == "Boar Hunt" && text(&l["t"]) == "turnin").unwrap();
	assert_eq!(ilse["xp"], 2400);
	assert!(out[1]["note"].is_null());
	assert!(out[1]["xp"].is_null());
}

#[test]
fn an_empty_log_leads_to_the_zone_with_the_most_quests_for_the_level() {
	// Away from Marshal Hale's camp, his five quests (7001-7003, 7005, 7110), nearer, beat Merrow Fields' four.
	let out = run(r#"
w.moveTo(9001, 10, 90)
stub.advance(1)
assert(F.Start())
stub.advance(2)
local v = E.GetStepView(1)
local wp = E.GetWaypoint()
emit({ title = v.title, note = v.note, map = wp and wp.map, x = wp and wp.x, y = wp and wp.y })
"#);
	assert_eq!(text(&out[0]["title"]), "Quests for your level");
	assert_eq!(out[0]["map"], 9001);
	assert_eq!(out[0]["x"], 50);
	assert_eq!(out[0]["y"], 52);
	assert_eq!(text(&out[0]["note"]), "5 quests for your level, all here.");
}

#[test]
fn the_zone_hint_counts_only_quests_this_character_can_take_now() {
	// Hale's quests done: Merrow Fields' Scout Merrow, Farmer Oake and Warden Pell, and Hunter Vann across the
	// fields; not the Horde's, the one done, the one too high nor the one behind its prerequisite.
	let out = run_with(
		r#"
w.moveTo(9001, 10, 90)
stub.advance(1)
assert(F.Start())
stub.advance(2)
local v = E.GetStepView(1)
local wp = E.GetWaypoint()
emit({ title = v.title, note = v.note, map = wp and wp.map, x = wp and wp.x, y = wp and wp.y })
"#,
		&Opts { setup: "w.complete({ 7001, 7002, 7003, 7004, 7005, 7106, 7110 })", ..Default::default() },
	);
	assert_eq!(text(&out[0]["title"]), "Quests for your level");
	assert_eq!(out[0]["map"], 9002);
	assert_eq!(out[0]["x"], 60);
	assert_eq!(out[0]["y"], 40);
	assert_eq!(text(&out[0]["note"]), "4 quests for your level, 3 of them here.");
}

#[test]
fn no_zone_hint_while_the_player_stands_at_givers_with_quests_to_take() {
	let out = run(r#"
assert(F.Start())
stub.advance(2)
emit({ count = E.GetStepCount(), live = E.GetStepIndex(), title = E.GetStepView(1).title })
"#);
	assert_eq!(out[0]["count"], 1);
	assert!(out[0]["live"].is_null());
	assert_eq!(text(&out[0]["title"]), "Free mode");
}

#[test]
fn far_quests_put_the_zone_hint_first_and_near_ones_never_do() {
	let out = run_with(
		r#"
w.moveTo(9001, 95, 95)
stub.advance(1)
take(7003)
assert(F.Start())
stub.advance(2)
emit({ titles = titles() })
"#,
		&Opts { setup: "w.complete({ 7001, 7002, 7004, 7005, 7106, 7110 })", ..Default::default() },
	);
	// Lurkers in the Marsh is about 2,260 yards off (over five minutes): the hint comes first.
	assert_eq!(strs(&out[0]["titles"]), ["Quests for your level", "Lurkers in the Marsh"]);
}

#[test]
fn return_to_guide_hands_the_arrow_back_to_the_tab_it_came_from() {
	let out = run(r#"
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
assert(Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Go west", goals = { { t = "goto", map = 9001, x = 10, y = 90, text = "West camp" } } },
} }))
E.SetGuide("test/route")
take(7001)
local before = label()
assert(F.Start())
stub.advance(1)
local tabs = {}
for i, t in ipairs(E.GetTabs()) do tabs[i] = t.guideId end
emit({ before = before, guide = E.GetGuide().id, tabs = tabs, label = label(), back = F.ReturnTitle(), on = F.IsOn() })
F.Stop()
stub.advance(1)
tabs = {}
for i, t in ipairs(E.GetTabs()) do tabs[i] = t.guideId end
emit({ guide = E.GetGuide().id, tabs = tabs, label = label(), on = F.IsOn() })
"#);
	assert_eq!(text(&out[0]["before"]), "Go to West camp");
	assert_eq!(text(&out[0]["guide"]), "lookup/free/log");
	assert_eq!(strs(&out[0]["tabs"]), ["test/route", "lookup/free/log"]);
	assert_eq!(text(&out[0]["label"]), "Kill Ridge Gnoll");
	assert_eq!(text(&out[0]["back"]), "Route");
	assert_eq!(text(&out[1]["guide"]), "test/route");
	assert_eq!(strs(&out[1]["tabs"]), ["test/route"]);
	assert_eq!(text(&out[1]["label"]), "Go to West camp");
	assert!(!truthy(&out[1]["on"]));
}

#[test]
fn a_saved_free_mode_tab_comes_back_after_a_reload_and_fills_once_the_log_is_read() {
	let out = run_with(
		r#"
stub.advance(1)
local first = { on = F.IsOn(), guide = E.GetGuide() and E.GetGuide().id, count = E.GetStepCount() }
take(7001, 7002)
stub.advance(1)
emit({ first = first, titles = titles(), live = live() })
"#,
		&Opts { saved: Some(r#"PolestarCharDB = { tabs = { "lookup/free/log" }, activeTab = 1, guide = "lookup/free/log" }"#), ..Default::default() },
	);
	assert!(truthy(&out[0]["first"]["on"]));
	assert_eq!(text(&out[0]["first"]["guide"]), "lookup/free/log");
	assert_eq!(strs(&out[0]["titles"]), ["Gnoll Trouble", "Boar Hunt"]);
	assert_eq!(text(&out[0]["live"]), "Gnoll Trouble");
}

#[test]
fn the_guide_window_offers_free_mode_its_way_back_and_the_quest_rows() {
	// The whole addon: the empty window's link, the banner with Return to <guide>, the menu's rows and a quest
	// line's right-click rows (pin, leave out; no Skip, which skips the quest in every guide).
	let out = run_with(
		r#"
stub.advance(2)
local GF = Polestar.UI.GuideFrame
local empty = { state = GF.State and GF.State() }
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
assert(Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Go west", goals = { { t = "goto", map = 9001, x = 10, y = 90, text = "West camp" } } },
} }))
E.SetGuide("test/route")
take(7001)
local menuOff = {}
for _, it in ipairs(F.MenuItems()) do menuOff[#menuOff + 1] = it.text end
local rowsOff = F.RowItems(7001)
assert(F.Start())
stub.advance(1)
local kind, n = GF.BannerNotice()
local menuOn, rowsOn = {}, {}
for _, it in ipairs(F.MenuItems()) do menuOn[#menuOn + 1] = it.text end
for _, it in ipairs(F.RowItems(7001) or {}) do rowsOn[#rowsOn + 1] = it.text end
GF.TakeBanner()
stub.advance(1)
emit({ empty = empty, menuOff = menuOff, rowsOff = rowsOff, banner = kind, back = n and n.back, menuOn = menuOn, rowsOn = rowsOn,
	after = E.GetGuide().id, on = F.IsOn() })
"#,
		&Opts { files: None, ..Default::default() },
	);
	let o = &out[0];
	assert_eq!(strs(&o["menuOff"]), ["Free mode"]);
	assert!(o["rowsOff"].is_null());
	assert_eq!(text(&o["banner"]), "free");
	assert_eq!(text(&o["back"]), "Route");
	assert_eq!(strs(&o["menuOn"]), ["Free mode", "Order: most XP a minute first"]);
	assert_eq!(strs(&o["rowsOn"]), ["Pin to the top", "Leave out of Free mode"]);
	assert_eq!(text(&o["after"]), "test/route");
	assert!(!truthy(&o["on"]));
}

#[test]
fn polestar_free_toggles_it_and_sets_the_order() {
	let out = run(r#"
take(7001, 7002)
SlashCmdList.POLESTAR("free xp")
local xp = Polestar.Get("free.pick")
SlashCmdList.POLESTAR("free")
stub.advance(1)
local on, first = F.IsOn(), titles()[1]
SlashCmdList.POLESTAR("free nearest")
SlashCmdList.POLESTAR("free off")
stub.advance(1)
emit({ xp = xp, on = on, first = first, pick = Polestar.Get("free.pick"), off = F.IsOn() })
"#);
	assert_eq!(text(&out[0]["xp"]), "xp");
	assert!(truthy(&out[0]["on"]));
	assert_eq!(text(&out[0]["first"]), "Boar Hunt");
	assert_eq!(text(&out[0]["pick"]), "near");
	assert!(!truthy(&out[0]["off"]));
}

#[test]
fn the_settings_button_starts_and_stops_it_beside_its_order_and_details() {
	// Settings > Questing > Quests > Free mode (Polestar_Options/Quests/Options.lua): the start is a button (the tab
	// is the character's, no setting holds it; pressed again it goes back), then the order, zone hints and XP and
	// drop rates.
	let out = run_with(
		r#"
take(7001)
Polestar.Fire("SHOW_OPTIONS")
stub.advance(0.3)
local O = Polestar.UI.Options
local c = O.ControlByKey("free.pick")
O.Select(c.page.key, c.tab)
stub.advance(0.2)
local rows = O.Controls(c.page.key, c.tab)
local start
for _, x in ipairs(O.AllControls()) do
	if x.kind == "button" and x.label == "Free mode" then start = x end
end
start.onClick()
stub.advance(1)
local on, guide = F.IsOn(), E.GetGuide().id
start.onClick()
stub.advance(1)
emit({ page = c.page.key, tab = c.tab, hints = rows["free.hints"] ~= nil, details = rows["free.details"] ~= nil, on = on, guide = guide, after = F.IsOn() })
"#,
		&Opts { files: None, ..Default::default() },
	);
	let o = &out[0];
	assert_eq!(text(&o["page"]), "questing");
	assert_eq!(text(&o["tab"]), "Quests");
	assert!(truthy(&o["hints"]) && truthy(&o["details"]));
	assert!(truthy(&o["on"]));
	assert_eq!(text(&o["guide"]), "lookup/free/log");
	assert!(!truthy(&o["after"]));
}
