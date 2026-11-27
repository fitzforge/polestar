//! Free mode (#3701, addon/Polestar/Lookup/Free.lua): the character's own quest log as a guide in a tab of its own,
//! the quests in the order of the pick rule (balanced, the default; nearest first; or most XP a minute first), a
//! pinned quest first, a quest left out not listed, a zone hint when the log has nothing near, and the way back to the
//! guide the player came from. Balanced's order and its why line (Polestar_FreeMode/Order.lua): a stop shared by
//! several quests, a quest started and a hand-in stop for several quests come first, and the first holds while the
//! player walks.
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
//!   7006 Rat Problem           kill 5 Field Rats, 80 yd west; Hale (1,200 XP)
//!   7007 Gnoll Bounty          kill 3 Ridge Gnolls; Hale (900 XP)
//!   7008 Snare Check, 7009 Tusk Tally   a Hill Boar each; Ranger Ilse (900 and 1,000 XP)
//! (7006-7009 start from a letter, so no zone hint counts them),
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
	[7006] = { { text = "Field Rat slain: 0/5", required = 5 } },
	[7007] = { { text = "Ridge Gnoll slain: 0/3", required = 3 } },
	[7008] = { { text = "Hill Boar slain: 0/1", required = 1 } },
	[7009] = { { text = "Hill Boar slain: 0/1", required = 1 } },
}
local TITLE = { [7001] = "Gnoll Trouble", [7002] = "Boar Hunt", [7003] = "Lurkers in the Marsh", [7004] = "Ogre Menace", [7005] = "Gnoll Ears",
	[7006] = "Rat Problem", [7007] = "Gnoll Bounty", [7008] = "Snare Check", [7009] = "Tusk Tally" }
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
Polestar.Set("free.pick", "near")
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
	// Boar Hunt: 2,400 XP over about 57 s of walking and 239 s of work (4 tusks at 56 s, the item's time at levels
	// 20-29), ahead of Gnoll Trouble's 1,200 over 209 s.
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
Polestar.Set("free.pick", "near")
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
	// Nearest first: Gnoll Trouble's gnolls 100 yd east, Boar Hunt's boars 400 yd west. 160 yd west the boars are
	// 20 yd nearer than the gnolls: too little to move the arrow off them. Standing by the boars, they come first.
	let out = run(r#"
Polestar.Set("free.pick", "near")
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

// try4: started from the hand-in route's tab, the way back read "Return to Hand in your finished quests". The way
// back is the last guide of a pack the player had in front; a tab Polestar builds (the hand-in route, a dungeon's
// pick-up run, a Lookup guide) is never one. With only those open there is no guide to go back to: the menu's Turn
// off Free mode says so in its tooltip.
#[test]
fn the_way_back_is_the_last_guide_of_a_pack_never_the_hand_in_route() {
	let out = run(r#"
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
assert(Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Go west", goals = { { t = "goto", map = 9001, x = 10, y = 90, text = "West camp" } } },
} }))
E.SetGuide("test/route")
take(7001, 7002)
w.progress(7001, 1, 5)
w.progress(7002, 1, 4)
stub.advance(1)
assert(Polestar.Handins.Start())
stub.advance(1)
local handin = E.GetGuide().id
assert(F.Start())
stub.advance(1)
local first = { from = handin, back = F.ReturnTitle(), saved = Polestar.CharState().free.from }
F.Stop()
stub.advance(1)
first.after = E.GetGuide().id
-- The pack's guide closed: only the hand-in route is left, so no way back is named.
for i, t in ipairs(E.GetTabs()) do if t.guideId == "test/route" then E.CloseTab(i, true) end end
stub.advance(1)
assert(F.Start())
stub.advance(1)
local menu, tips = {}, {}
for _, it in ipairs(F.MenuItems()) do menu[#menu + 1] = it.text; tips[#tips + 1] = it.tip or "" end
emit({ first = first, back = F.ReturnTitle() or false, menu = menu, tips = tips })
"#);
	let o = &out[0];
	assert_eq!(text(&o["first"]["from"]), "lookup/carried/log", "started from the hand-in route's tab");
	assert_eq!(text(&o["first"]["back"]), "Route", "the way back names the leveling guide, not the hand-in route");
	assert_eq!(text(&o["first"]["saved"]), "test/route");
	assert_eq!(text(&o["first"]["after"]), "test/route", "Stop hands the arrow back to it");
	assert_eq!(o["back"], false);
	assert_eq!(strs(&o["menu"])[1], "Turn off Free mode", "the action, never a guide's name");
	assert_eq!(strs(&o["tips"])[1], "Leaves you with no guide open: pick one under Guides.", "no guide to go back to");
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
fn the_guide_window_says_free_mode_once_puts_why_on_the_step_and_keeps_the_way_back_and_the_order_in_its_menu() {
	// The whole addon: the empty window's link; on start one line saying Free mode is on (no links), gone once
	// closed until the next start; why the first quest is first as one line under the step's header; the menu's
	// Turn on / Turn off (the guide it goes back to in its tooltip) and the three orders; a quest line's
	// right-click rows (pin, leave out; no Skip, which skips the quest in every guide).
	let out = run_with(
		r#"
stub.advance(2)
local GF = Polestar.UI.GuideFrame
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
GF.Refill()
local kind, n = GF.BannerNotice()
local text = GF.parts.banner.Text:GetText()
local links = GF.parts.banner.Jump:IsShown() or GF.parts.banner.Later:IsShown()
local view = E.GetStepView(E.GetStepIndex())
local why = { chosen = view.chosen, shown = GF.parts.person.Why:IsShown() and GF.parts.person.Why:GetText() or false }
local menuOn, checked, rowsOn, tipOff = {}, {}, {}, nil
for _, it in ipairs(F.MenuItems()) do
	menuOn[#menuOn + 1] = it.text
	if it.checked then checked[#checked + 1] = it.text end
	if it.text == "Turn off Free mode" then tipOff = it.tip end
end
for _, it in ipairs(F.RowItems(7001) or {}) do rowsOn[#rowsOn + 1] = it.text end
-- Closed: gone while Free mode stays on (a later plan, Start pressed again); back with the next start.
GF.DismissBanner()
take(7002)
assert(F.Start())
stub.advance(1)
GF.Refill()
local closed = GF.BannerNotice() or false
F.Stop()
stub.advance(1)
local after = E.GetGuide().id
assert(F.Start())
stub.advance(1)
emit({ menuOff = menuOff, rowsOff = rowsOff, banner = kind, n = n, text = text, links = links, why = why, menuOn = menuOn, checked = checked,
	tipOff = tipOff, rowsOn = rowsOn, closed = closed, after = after, again = GF.BannerNotice() or false })
"#,
		&Opts { files: None, ..Default::default() },
	);
	let o = &out[0];
	assert_eq!(strs(&o["menuOff"]), ["Turn on Free mode"], "the action it takes");
	assert!(o["rowsOff"].is_null());
	assert_eq!(text(&o["banner"]), "free");
	assert_eq!(text(&o["text"]), "You're in Free mode: your own quests, planned for you.");
	assert_eq!(o["links"], false, "no Return or order links on it");
	assert_eq!(text(&o["why"]["chosen"]), "Why first: nearest \u{b7} most XP for the trip");
	assert_eq!(o["why"]["shown"], o["why"]["chosen"], "one dim line under the step's header");
	assert_eq!(strs(&o["menuOn"]), ["Free mode page", "Turn off Free mode", "Order: balanced", "Order: nearest first", "Order: most XP a minute first"]);
	assert_eq!(text(&o["tipOff"]), "Takes you back to Route", "the guide it goes back to, in its tooltip");
	assert_eq!(strs(&o["checked"]), ["Order: balanced"]);
	assert_eq!(strs(&o["rowsOn"]), ["Pin to the top", "Leave out of Free mode"]);
	assert_ne!(o["closed"], "free", "closed: gone while Free mode stays on");
	assert_eq!(text(&o["after"]), "test/route");
	assert_eq!(text(&o["again"]), "free", "the next start says it once more");
}

// The empty guide window in Free mode (nothing in the log to lead to): Turn off Free mode, which goes back to the guide
// the player came from (named on the line above it, never on the button), and Choose a guide.
#[test]
fn the_empty_free_mode_window_turns_it_off_back_to_the_guide_it_names_on_its_line() {
	let out = run_with(
		r#"
stub.advance(2)
local GF = Polestar.UI.GuideFrame
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
assert(Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Go west", goals = { { t = "goto", map = 9001, x = 10, y = 90, text = "West camp" } } },
} }))
E.SetGuide("test/route")
-- No zone hint either: the log holds nothing to lead to.
Polestar.Set("free.hints", false)
stub.advance(1)
assert(F.Start())
stub.advance(1)
GF.Refill()
local e = GF.parts.empty
local got = { shown = e:IsShown(), title = e.Title:GetText(), text = e.Text:GetText(), primary = e.Primary.Label:GetText(),
	secondary = e.Secondary:IsShown() and e.Secondary.Label:GetText() or false }
e.Primary.psAction()
stub.advance(1)
got.after, got.on = E.GetGuide().id, F.IsOn()
emit(got)
"#,
		&Opts { files: None, ..Default::default() },
	);
	let o = &out[0];
	assert_eq!(o["shown"], true);
	assert_eq!(text(&o["title"]), "No quests to lead to");
	let line = text(&o["text"]);
	assert!(line.starts_with("Pick up quests and Free mode leads you to them.\nTakes you back to "), "{line}");
	assert!(line.contains("Route"), "the guide turning it off goes back to: {line}");
	assert_eq!(text(&o["primary"]), "Turn off Free mode", "the action, never Back to <guide>");
	assert_eq!(text(&o["secondary"]), "Choose a guide");
	assert_eq!(text(&o["after"]), "test/route", "Turn off hands the arrow back");
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
local near = Polestar.Get("free.pick")
SlashCmdList.POLESTAR("free balanced")
SlashCmdList.POLESTAR("free off")
stub.advance(1)
emit({ xp = xp, on = on, first = first, near = near, pick = Polestar.Get("free.pick"), off = F.IsOn() })
"#);
	assert_eq!(text(&out[0]["xp"]), "xp");
	assert!(truthy(&out[0]["on"]));
	assert_eq!(text(&out[0]["first"]), "Boar Hunt");
	assert_eq!(text(&out[0]["near"]), "near");
	assert_eq!(text(&out[0]["pick"]), "balanced");
	assert!(!truthy(&out[0]["off"]));
}

#[test]
fn the_settings_button_opens_the_main_page_beside_the_order_and_details() {
	// Settings > Questing > Quests > Free mode (Polestar_Options/Quests/Options.lua): Open, which shows the Free mode
	// section's Main page (Free mode is turned on and off there, not by a second switch here), then the order, zone
	// hints and XP and drop rates.
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
local open
for _, x in ipairs(O.AllControls()) do
	if x.kind == "button" and x.label == "Free mode" then open = x end
end
open.onClick()
stub.advance(1)
local choices = {}
for _, ch in ipairs(c.choices) do choices[#choices + 1] = ch.value end
emit({ page = c.page.key, tab = c.tab, hints = rows["free.hints"] ~= nil, details = rows["free.details"] ~= nil, button = open.button,
	section = Polestar.UI.Picker.Section(), shown = PolestarPicker:IsShown(), freePage = F.Page and F.Page.Current() or false, on = F.IsOn(),
	choices = choices, default = Polestar.GetDefault("free.pick") })
"#,
		&Opts { files: None, ..Default::default() },
	);
	let o = &out[0];
	assert_eq!(text(&o["page"]), "questing");
	assert_eq!(text(&o["tab"]), "Quests");
	assert!(truthy(&o["hints"]) && truthy(&o["details"]));
	assert_eq!(strs(&o["choices"]), ["balanced", "near", "xp"]);
	assert_eq!(text(&o["default"]), "balanced");
	assert_eq!(text(&o["button"]), "Open");
	assert!(truthy(&o["shown"]), "the main window opens");
	assert_eq!(text(&o["section"]), "FreeMode");
	assert_eq!(text(&o["freePage"]), "main", "on the Main page");
	assert!(!truthy(&o["on"]), "opening it turns nothing on");
}

// Balanced (Polestar_FreeMode/Order.lua), from 45,50: the Field Rats 20 yd west, the Ridge Gnolls 200 yd east.
// Gnoll Trouble alone loses to the nearer Rat Problem; with Gnoll Ears and Gnoll Bounty on the same gnolls, the
// gnolls are one stop for three quests and come first. Nearest takes the rats either way.
#[test]
fn balanced_takes_a_stop_several_quests_share_before_a_nearer_lone_one() {
	let script = |quests: &str, rule: &str| {
		run(&format!(
			r#"
w.moveTo(9001, 45, 50)
Polestar.Set("free.pick", "{rule}")
take({quests})
assert(F.Start())
stub.advance(1)
emit({{ first = titles()[1], why = F.Why() }})
"#
		))
	};
	let alone = script("7006, 7001", "balanced");
	let shared = script("7006, 7001, 7005, 7007", "balanced");
	let near = script("7006, 7001, 7005, 7007", "near");
	assert_eq!(text(&alone[0]["first"]), "Rat Problem");
	assert_eq!(text(&shared[0]["first"]), "Gnoll Trouble");
	assert_eq!(text(&shared[0]["why"]), "Why Gnoll Trouble first: 3 of your quests here \u{b7} most XP for the trip");
	assert_eq!(text(&near[0]["first"]), "Rat Problem");
}

// Rat Problem 20 yd west, Gnoll Trouble 200 yd east: with three of its five gnolls down, Gnoll Trouble (less left
// to do, the mobs found) comes first under Balanced; Nearest keeps the rats.
#[test]
fn balanced_takes_a_quest_already_started_first() {
	let script = |rule: &str, kills: u32| {
		run(&format!(
			r#"
w.moveTo(9001, 45, 50)
Polestar.Set("free.pick", "{rule}")
take(7006, 7001)
w.progress(7001, 1, {kills})
stub.advance(1)
assert(F.Start())
stub.advance(1)
emit({{ first = titles()[1], why = F.Why() }})
"#
		))
	};
	assert_eq!(text(&script("balanced", 0)[0]["first"]), "Rat Problem");
	let started = script("balanced", 3);
	assert_eq!(text(&started[0]["first"]), "Gnoll Trouble");
	assert_eq!(text(&started[0]["why"]), "Why Gnoll Trouble first: started \u{b7} most XP for the trip");
	assert_eq!(text(&script("near", 3)[0]["first"]), "Rat Problem");
}

// Finished quests only, from 56.5,68.3: Marshal Hale (Gnoll Ears, 1,100 XP) about 50 s away, Ranger Ilse about 75 s.
// Ilse taking two of them (Snare Check and Tusk Tally, 1,900 XP) is the better stop; taking one, Hale is.
// Nearest goes to Hale.
#[test]
fn balanced_takes_the_npc_that_takes_several_finished_quests_first() {
	let script = |rule: &str, quests: &str| {
		run(&format!(
			r#"
w.moveTo(9001, 56.5, 68.3)
Polestar.Set("free.pick", "{rule}")
take({quests})
w.progress(7005, 1, 6)
for _, q in ipairs({{ {quests} }}) do if q ~= 7005 then w.progress(q, 1, 1) end end
stub.advance(1)
assert(F.Start())
stub.advance(1)
emit({{ first = titles()[1], why = F.Why() }})
"#
		))
	};
	let two = script("balanced", "7005, 7008, 7009");
	assert_eq!(text(&two[0]["first"]), "Snare Check");
	assert_eq!(text(&two[0]["why"]), "Why Snare Check first: 2 hand-ins at one stop \u{b7} most XP for the trip");
	assert_eq!(text(&script("balanced", "7005, 7009")[0]["first"]), "Gnoll Ears");
	assert_eq!(text(&script("near", "7005, 7008, 7009")[0]["first"]), "Gnoll Ears");
}

// Balanced holds its first quest while the player walks: Rat Problem (80 yd west) first from the camp; 30 yd east
// Gnoll Trouble scores a little better, too little to move the arrow (the card says why); standing by the gnolls,
// they come first.
#[test]
fn balanced_holds_the_first_quest_while_the_player_walks() {
	let out = run(r#"
take(7006, 7001)
assert(F.Start())
stub.advance(1)
local first = titles()[1]
w.moveTo(9001, 51.5, 50)
F.Plan(true)
stub.advance(1)
local small, why = titles()[1], F.Why()
w.moveTo(9001, 55, 50)
F.Plan(true)
stub.advance(1)
emit({ first = first, small = small, why = why, there = titles()[1] })
"#);
	assert_eq!(text(&out[0]["first"]), "Rat Problem");
	assert_eq!(text(&out[0]["small"]), "Rat Problem");
	assert_eq!(text(&out[0]["why"]), "Why Rat Problem first: kept while you walk");
	assert_eq!(text(&out[0]["there"]), "Gnoll Trouble");
}
