//! The Characters page (addon/Polestar/Alts): the per-character snapshot (what it holds, when it is written,
//! how often), the account list and its orders, Forget, the rested projection, and the hub section.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const CORE: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "Alts/Alts.xml"];
const WITH_UI: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml", "Alts/Alts.xml"];

/// A level 18 Night Elf Mage resting in Darkshore, one guide tab open.
const WORLD: &str = r#"
local w = stub.world
w.class, w.className, w.race, w.raceName = "MAGE", "Mage", "NightElf", "Night Elf"
w.level, w.xp, w.xpMax = 18, 1000, 4000
w.zone, w.subzone = "Darkshore", ""
w.bindLocation = "Auberdine"
w.money = 12 * 10000 + 40 * 100
w.skills[197] = { name = "Tailoring", rank = 112, maxRank = 150 }
w.skills[762] = { name = "Riding", rank = 75, maxRank = 75 }
local rested = 1840
GetXPExhaustion = function() return rested end
IsResting = function() return true end
"#;

const PRELUDE: &str = r#"local Alts = Polestar.Alts
Polestar.Engine.GetTabs = function() return { { guideId = "g1", title = "Darkshore (16-21)", stepIndex = 16, stepCount = 43 } }, 1 end
"#;

fn run_in(script: &str, files: &[&str], ui: bool) -> Vec<Value> {
	let mut stubs = vec!["stub_world.lua"];
	if ui {
		stubs.push("stub_ui.lua");
	}
	emitted(&RunAddon { stubs, before: WORLD.into(), addons: vec![Addon::files("Polestar", files)], login: true, script: [PRELUDE, script].concat(), ..Default::default() })
}

fn run(script: &str) -> Value {
	run_in(script, CORE, false).remove(0)
}

fn run_ui(script: &str) -> Value {
	run_in(script, WITH_UI, true).remove(0)
}

/// The Lua value is nil (absent from the emitted table).
fn nil(v: Option<&Value>) -> bool {
	v.is_none_or(Value::is_null)
}

#[test]
fn login_writes_the_entry_under_name_realm_once_the_tabs_exist() {
	let out = run_in(
		r#"
local first = PolestarDB.alts and PolestarDB.alts.chars["Testchar-Test Realm"]
stub.advance(6)
emit(first ~= nil)
emit(PolestarDB.alts.chars["Testchar-Test Realm"])"#,
		CORE,
		false,
	);
	assert_eq!(out[0], false);
	let o = &out[1];
	assert_eq!(o["name"], "Testchar");
	assert_eq!(o["realm"], "Test Realm");
	assert_eq!(o["class"], "MAGE");
	assert_eq!(o["race"], "NightElf");
	assert_eq!(o["level"], 18);
	assert_eq!(o["xp"], 1000);
	assert_eq!(o["xpMax"], 4000);
	assert_eq!(o["rested"], 1840);
	assert_eq!(o["resting"], true);
	assert_eq!(o["zone"], "Darkshore");
	assert_eq!(o["bind"], "Auberdine");
	assert_eq!(o["money"], 124000);
	assert_eq!(o["profs"], json!({ "197": 112 }), "riding is left out");
	assert_eq!(o["tabs"], json!([{ "id": "g1", "title": "Darkshore (16-21)", "step": 16, "count": 43 }]));
	assert_eq!(o["active"], 1);
	assert!(o["seen"].is_number());
}

#[test]
fn frequent_events_coalesce_into_one_write_after_the_delay_asking_to_leave_writes_at_once() {
	let out = run(r#"
IsResting = function() return false end
stub.advance(6)
local writes = 0
local write = Alts.Write
Alts.Write = function() writes = writes + 1; return write() end
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
stub.world.setLevel(19)
stub.world.setMoney(5)
stub.world.setXP(2000, 4200)
stub.fire("ZONE_CHANGED_NEW_AREA")
local immediate = { writes, c().level }
stub.advance(9)
local early = { writes, c().level }
stub.advance(2)
local late = { writes, c().level, c().money, c().xp }
stub.world.setMoney(9)
stub.fire("PLAYER_CAMPING")
emit({ immediate = immediate, early = early, late = late, logout = { writes, c().money } })"#);
	assert_eq!(out["immediate"], json!([0, 18]));
	assert_eq!(out["early"], json!([0, 18]));
	assert_eq!(out["late"], json!([1, 19, 5, 2000]));
	assert_eq!(out["logout"], json!([2, 9]));
}

#[test]
fn list_the_current_character_first_then_by_last_played_level_or_rested_a_second_character_is_kept() {
	let out = run(r#"
stub.advance(6)
local function as(name, class, level, xp, rested, resting, ago)
	UnitName = function() return name end
	stub.world.level, stub.world.xp, stub.world.xpMax = level, xp, 4000
	GetXPExhaustion = function() return rested end
	IsResting = function() return resting end
	Alts.Write()
	local e = PolestarDB.alts.chars[name .. "-Test Realm"]
	e.class = class
	e.seen = Polestar.Compat.Now() - ago
end
as("Alt1", "WARRIOR", 30, 0, 0, true, 3600)
as("Alt2", "PRIEST", 12, 0, 2000, false, 7200)
as("Alt3", "ROGUE", 25, 0, 100, true, 100)
UnitName = function() return "Testchar" end
stub.world.level, stub.world.xp, stub.world.xpMax = 18, 1000, 4000
GetXPExhaustion = function() return 1840 end
IsResting = function() return true end
Alts.Write()
local function names(sort) local o = {} for i, e in ipairs(Alts.List(sort)) do o[i] = e.name end return o end
emit({ seen = names(), level = names("level"), rested = names("rested") })"#);
	assert_eq!(out["seen"], json!(["Testchar", "Alt3", "Alt1", "Alt2"]));
	assert_eq!(out["level"], json!(["Testchar", "Alt1", "Alt3", "Alt2"]));
	// Alt2 holds 2000 (+ a little, away); Alt3 100 (+ resting); Alt1 resting from 0.
	assert_eq!(out["rested"], json!(["Testchar", "Alt2", "Alt3", "Alt1"]));
}

#[test]
fn forget_removes_another_character_and_refuses_the_current_one() {
	let out = run(r#"
stub.advance(6)
PolestarDB.alts.chars["Old-Test Realm"] = { key = "Old-Test Realm", name = "Old", realm = "Test Realm", level = 5, seen = 1 }
emit({ other = Alts.Forget("Old-Test Realm"), gone = PolestarDB.alts.chars["Old-Test Realm"] == nil,
	mine = Alts.Forget(Alts.Key()), kept = PolestarDB.alts.chars["Testchar-Test Realm"] ~= nil })"#);
	assert_eq!(out, json!({ "other": true, "gone": true, "mine": false, "kept": true }));
}

#[test]
fn project_rested_the_classic_rates_the_cap_and_the_level_cap() {
	let out = run(r#"
local e = { level = 20, xp = 0, xpMax = 4000, rested = 0, seen = 1000, resting = true }
local H = 3600
local function away(t) local c = {} for k, v in pairs(e) do c[k] = v end c.resting = false return Alts.ProjectRested(c, 1000 + t) end
emit({
	rest8 = Alts.ProjectRested(e, 1000 + 8 * H),
	away8 = away(8 * H),
	added = Alts.ProjectRested({ level = 20, xpMax = 4000, rested = 1000, seen = 1000, resting = true }, 1000 + 8 * H),
	capped = Alts.ProjectRested(e, 1000 + 400 * 24 * H),
	maxed = Alts.ProjectRested({ level = 60, xpMax = 4000, rested = 0, seen = 1000, resting = true }, 1000 + 8 * H),
})"#);
	assert_eq!(out["rest8"], 200, "5% of the level in 8 h resting");
	assert_eq!(out["away8"], 50, "a quarter of that away from an inn");
	assert_eq!(out["added"], 1200);
	assert_eq!(out["capped"], 6000, "1.5 levels at most");
	assert!(nil(out.get("maxed")), "nil at the level cap");
}

#[test]
fn the_section_one_button_row_per_character_with_an_on_click_forget_is_disabled_on_the_current_character() {
	let out = run_ui(
		r#"
stub.advance(6)
PolestarDB.alts.chars["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", class = "WARRIOR", race = "Orc",
	level = 30, xp = 100, xpMax = 5000, zone = "Barrens", bind = "Crossroads", seen = Polestar.Compat.Now() - 7200, profs = { [186] = 80 } }
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
local s = V.Shown()
local rows = {}
for i = 1, s.rows do
	local r = V.rows[i]
	rows[i] = { r:GetObjectType(), r:GetScript("OnClick") ~= nil, r.Name:GetText(), r:IsShown() }
end
local mine = { V.forgetButton():IsEnabled() }
local mineLabel = V.forgetButton().Label:GetText()
stub.RunScript(V.rows[2], "OnClick")
local after = { s.selected, V.forgetButton():IsEnabled(), V.forgetButton().Label:GetText() }
emit({ mineLabel = mineLabel, rows = rows, shownRows = s.rows, mine = mine, after = after, subtitle = s.subtitle, section = Polestar.UI.Picker.Section() })"#,
	);
	assert_eq!(out["shownRows"], 2);
	let rows = out["rows"].as_array().unwrap();
	assert_eq!(rows.iter().map(|r| json!([r[0], r[1]])).collect::<Vec<_>>(), vec![json!(["Button", true]); 2]);
	assert_eq!(rows.iter().map(|r| r[2].clone()).collect::<Vec<_>>(), vec![json!("Testchar"), json!("Alt")]);
	assert_eq!(out["mine"], json!([false]));
	assert_eq!(out["after"], json!(["Alt-Test Realm", true, "Forget Alt"]));
	assert_eq!(out["mineLabel"], "Forget", "the playing character reads just Forget");
	assert_eq!(out["section"], "Characters");
	assert!(is_match(text(&out["subtitle"]), r"^2 characters on Test Realm"));
}

#[test]
fn rested_is_live_for_the_current_character_projected_for_another() {
	let out = run(r#"
local now = Polestar.Compat.Now()
local mine = { key = Alts.Key(), level = 18, xpMax = 4000, rested = 1, seen = now - 8 * 3600, resting = true }
local other = { key = "Other-Test Realm", level = 18, xpMax = 4000, rested = 1, seen = now - 8 * 3600, resting = true }
emit({ mine = Alts.Rested(mine, now), other = Alts.Rested(other, now) })"#);
	assert_eq!(out["mine"], 1840, "GetXPExhaustion, not the stored figure");
	assert_eq!(out["other"], 201);
}

#[test]
fn player_camping_writes_at_once() {
	let out = run(r#"
stub.advance(6)
stub.world.setMoney(77)
stub.fire("PLAYER_CAMPING")
emit(PolestarDB.alts.chars["Testchar-Test Realm"].money)"#);
	assert_eq!(out, 77);
}

#[test]
fn set_sort_persists_alts_sort_and_the_order_follows_it() {
	let out = run_ui(
		r#"
stub.advance(6)
local now = Polestar.Compat.Now()
PolestarDB.alts.chars["Hi-Test Realm"] = { key = "Hi-Test Realm", name = "Hi", realm = "Test Realm", class = "ROGUE", race = "Human", level = 50, xp = 0, xpMax = 9000, seen = now - 9000 }
PolestarDB.alts.chars["Lo-Test Realm"] = { key = "Lo-Test Realm", name = "Lo", realm = "Test Realm", class = "ROGUE", race = "Human", level = 5, xp = 0, xpMax = 900, seen = now - 100 }
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
local function order() local o = {} for i, k in ipairs(V.Shown().keys) do o[i] = k:match("^[^-]+") end return o end
local out = { seen = order() }
V.SetSort("level")
out.level = order()
out.saved = PolestarDB.settings.alts and PolestarDB.settings.alts.sort
out.setting = Polestar.Get("alts.sort")
V.SetSort("seen")
out.back = order()
out.cleared = PolestarDB.settings.alts == nil or PolestarDB.settings.alts.sort == nil
emit(out)"#,
	);
	assert_eq!(out["seen"], json!(["Testchar", "Lo", "Hi"]));
	assert_eq!(out["level"], json!(["Testchar", "Hi", "Lo"]));
	assert_eq!(out["saved"], "level");
	assert_eq!(out["setting"], "level");
	assert_eq!(out["back"], json!(["Testchar", "Lo", "Hi"]));
	assert_eq!(out["cleared"], true, "the default is not stored");
}

#[test]
fn the_row_text_slower_away_from_an_inn_fully_rested_max_level_nothing_for_xp_max_0_below_the_cap() {
	let out = run_ui(
		r#"
stub.advance(6)
local now = Polestar.Compat.Now()
local function add(name, e)
	e.key, e.name, e.realm, e.class, e.race, e.seen = name .. "-Test Realm", name, "Test Realm", "ROGUE", "Human", e.seen or now - 3600
	PolestarDB.alts.chars[e.key] = e
end
add("Away", { level = 20, xp = 100, xpMax = 4000, rested = 1000 })
add("Full", { level = 20, xp = 100, xpMax = 4000, rested = 6000, resting = true })
add("Cap", { level = 60, xp = 0, xpMax = 0 })
add("Zero", { level = 20, xp = 0, xpMax = 0 })
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
local by = {}
for i, key in ipairs(V.Shown().keys) do by[key] = { rest = V.Shown().rested[i], pct = V.rows[i].Pct:GetText() } end
emit(by)"#,
	);
	assert!(is_match(text(&out["Away-Test Realm"]["rest"]), r"^\+\d+% .* slower$"));
	assert!(is_match(text(&out["Away-Test Realm"]["pct"]), r"^\d+% to 21$"));
	assert_eq!(out["Full-Test Realm"]["rest"], "Fully rested (1.5 levels)");
	assert_eq!(out["Cap-Test Realm"]["pct"], "Max level");
	assert_eq!(out["Zero-Test Realm"]["pct"], "", "no percentage below the cap without a level size");
	assert_eq!(out["Zero-Test Realm"]["rest"], "");
}

#[test]
fn forget_through_the_page_takes_two_clicks_the_first_arms_it() {
	let out = run_ui(
		r#"
stub.advance(6)
PolestarDB.alts.chars["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", class = "WARRIOR", race = "Orc", level = 30, xp = 1, xpMax = 5000, seen = 5 }
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
stub.RunScript(V.rows[2], "OnClick")
local b = V.forgetButton()
stub.RunScript(b, "OnClick")
local armed = { PolestarDB.alts.chars["Alt-Test Realm"] ~= nil, b.Label:GetText() }
stub.RunScript(b, "OnClick")
emit({ armed = armed, gone = PolestarDB.alts.chars["Alt-Test Realm"] == nil })"#,
	);
	assert_eq!(out["armed"][0], true, "still there after one click");
	assert_eq!(out["armed"][1], "Click again to confirm");
	assert_eq!(out["gone"], true);
}

#[test]
fn alts_enabled_off_nothing_is_written_saved_characters_are_still_listed_and_can_be_forgotten() {
	let out = run_in(
		r#"
stub.advance(6)
PolestarDB.alts.chars["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", class = "WARRIOR", race = "Orc", level = 30, xp = 1, xpMax = 5000, seen = 5 }
local before = PolestarDB.alts.chars["Testchar-Test Realm"].money
Polestar.Set("alts.enabled", false)
stub.world.setMoney(5)
stub.advance(12)
stub.fire("PLAYER_LOGOUT")
local after = PolestarDB.alts.chars["Testchar-Test Realm"].money
Polestar.Fire("SHOW_ALTS")
local V = Polestar.UI.AltsSection
local s = V.Shown()
local o = { before = before, after = after, off = s.off, rows = s.rows, subtitle = s.subtitle }
V.Select("Alt-Test Realm")
o.canForget = V.forgetButton():IsEnabled()
stub.RunScript(V.forgetButton(), "OnClick")
stub.RunScript(V.forgetButton(), "OnClick")
o.gone = PolestarDB.alts.chars["Alt-Test Realm"] == nil
emit(o)
Polestar.Set("alts.enabled", true)
emit(PolestarDB.alts.chars["Testchar-Test Realm"].money)"#,
		WITH_UI,
		true,
	);
	let (o, again) = (&out[0], &out[1]);
	assert_eq!(o["before"], 124000);
	assert_eq!(o["after"], 124000, "unchanged while off");
	assert_eq!(o["off"], true);
	assert_eq!(o["rows"], 2, "what was saved is listed");
	assert!(!is_match(text(&o["subtitle"]), r"\d characters|1 character"), "no count claimed while off");
	assert_eq!(o["canForget"], true);
	assert_eq!(o["gone"], true);
	assert_eq!(*again, 5, "turning it on writes again");
}

#[test]
fn the_playing_character_alone_no_as_of_their_last_logout_the_instance_count_is_in_the_subtitle() {
	let out = run_ui(
		r#"
Polestar.Fire("SHOW_ALTS")
local first = Polestar.UI.AltsSection.Shown().subtitle
Polestar.Set("maps.instances", true)
Polestar.Maps = { GetInstanceStatus = function() return { inHour = 3, perHour = 5 } end }
Polestar.UI.AltsSection.Select(Polestar.Alts.Key())
local on = Polestar.UI.AltsSection.Shown().subtitle
Polestar.Set("maps.instances", false)
Polestar.UI.AltsSection.Select(Polestar.Alts.Key())
emit({ first = first, on = on, off = Polestar.UI.AltsSection.Shown().subtitle })"#,
	);
	assert_eq!(out["first"], "1 character on Test Realm");
	assert!(is_match(text(&out["on"]), r"3/5$"));
	assert_eq!(out["off"], "1 character on Test Realm", "hidden with the instance tracker off");
}

#[test]
fn the_hub_the_sorts_are_tabs_and_the_sidebar_lists_the_characters_a_pick_selecting_its_row() {
	let out = run_ui(
		r#"
stub.advance(6)
PolestarDB.alts.chars["Alt-Test Realm"] = { key = "Alt-Test Realm", name = "Alt", realm = "Test Realm", class = "WARRIOR", race = "Orc", level = 30, xp = 1, xpMax = 5000, seen = 5 }
Polestar.Fire("SHOW_ALTS")
local win = PolestarPicker
local function labels(list) local o = {} for _, b in ipairs(list) do if b:IsShown() then o[#o + 1] = b.psKey end end return o end
local tabs, nav = labels(win.tabButtons), labels(win.navButtons)
local V = Polestar.UI.AltsSection
V.OnNav("Alt-Test Realm")
emit({ tabs = tabs, nav = nav, selected = V.Shown().selected })"#,
	);
	assert_eq!(out["tabs"], json!(["seen", "rested", "level"]));
	assert_eq!(out["nav"], json!(["Testchar-Test Realm", "Alt-Test Realm"]));
	assert_eq!(out["selected"], "Alt-Test Realm");
}

#[test]
fn a_finished_guide_reads_complete_in_the_snapshot() {
	let out = run(r#"
Polestar.Engine.GetTabs = function() return { { guideId = "g1", title = "Done", stepIndex = 43, stepCount = 43, complete = true } }, 1 end
Alts.Write()
emit(PolestarDB.alts.chars["Testchar-Test Realm"].tabs[1].complete)"#);
	assert_eq!(out, true);
}

#[test]
fn one_pending_write_at_most_the_login_timer_and_the_event_timer_never_stack() {
	let out = run(r#"
IsResting = function() return false end
local writes = 0
local write = Alts.Write
Alts.Write = function(...) writes = writes + 1; return write(...) end
stub.world.setMoney(1)
stub.world.setMoney(2)
stub.fire("PLAYER_CAMPING")
local atOnce = writes
stub.world.setMoney(3)
stub.advance(30)
emit({ atOnce = atOnce, total = writes })"#);
	assert_eq!(out, json!({ "atOnce": 1, "total": 2 }), "the retired login timer does nothing; one timer wrote the later change");
}

#[test]
fn theme_class_color_a_class_file_and_nil_for_the_players_class() {
	let out = run(r#"
RAID_CLASS_COLORS = { MAGE = { r = 0.25, g = 0.78, b = 0.92 }, ROGUE = { r = 1, g = 0.96, b = 0.41 } }
local T = Polestar.Theme
emit({ rogue = { T.ClassColor("ROGUE") }, player = { T.ClassColor() }, unknown = { T.ClassColor("NOPE") } })"#);
	assert_eq!(out["rogue"], json!([1, 0.96, 0.41]));
	assert_eq!(out["player"], json!([0.25, 0.78, 0.92]), "the world stub plays a Mage");
	let unknown = &out["unknown"];
	assert!(unknown.is_null() || unknown.as_array().is_some_and(Vec::is_empty) || unknown.as_object().is_some_and(|o| o.is_empty()));
}

#[test]
fn opening_the_page_before_the_login_write_still_lists_the_playing_character() {
	let out = run_ui(
		r#"
local s0 = PolestarDB.alts
Polestar.Fire("SHOW_ALTS")
local s = Polestar.UI.AltsSection.Shown()
emit({ had = s0 ~= nil, rows = s.rows, key = s.keys[1], subtitle = s.subtitle })"#,
	);
	assert_eq!(out["had"], false);
	assert_eq!(out["rows"], 1);
	assert_eq!(out["key"], "Testchar-Test Realm");
	assert!(is_match(text(&out["subtitle"]), r"^1 character on Test Realm"));
}

/// What the client answers while the world goes: plausible and wrong.
const WRONG: &str = r#"
IsResting = function() return false end
GetMoney = function() return 0 end
UnitLevel = function() return 1 end
UnitXP = function() return 0 end
UnitXPMax = function() return 0 end
GetXPExhaustion = function() return nil end
C_Map.GetBestMapForUnit = function() return nil end
GetRealZoneText = function() return "Lion's Pride Inn" end
GetZoneText = function() return "Lion's Pride Inn" end
stub.world.skills = {}
Polestar.Engine.GetTabs = function() return {}, 0 end"#;

#[test]
fn leaving_the_world_and_logout_read_nothing_the_entry_changes_only_in_seen() {
	let out = run(&format!(
		r#"
stub.advance(6)
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
local function snap() local t = {{}} for k, v in pairs(c()) do if k ~= "seen" then t[k] = type(v) == "table" and #v or v end end return t end
local before = snap()
local seen = c().seen
stub.advance(30)
{WRONG}
stub.fire("PLAYER_LEAVING_WORLD")
stub.fire("PLAYER_LOGOUT")
emit({{ before = before, after = snap(), bumped = c().seen > seen }})"#
	));
	assert_eq!(out["after"], out["before"]);
	assert_eq!(out["before"]["money"], 124000);
	assert_eq!(out["before"]["resting"], true);
	assert_eq!(out["before"]["zone"], "Darkshore");
	assert_eq!(out["bumped"], true);
}

#[test]
fn leaving_the_world_and_logout_leave_a_pending_write_alone() {
	let out = run(r#"
IsResting = function() return false end
stub.advance(6)
stub.world.setMoney(321)
stub.fire("PLAYER_LEAVING_WORLD")
stub.fire("PLAYER_LOGOUT")
emit(PolestarDB.alts.chars["Testchar-Test Realm"].money)"#);
	assert_eq!(out, 124000, "the pending write would read the same bad values");
}

#[test]
fn with_no_entry_yet_logout_makes_none() {
	let out = run(r#"
PolestarDB.alts = nil
stub.fire("PLAYER_LOGOUT")
emit(PolestarDB.alts == nil or next(PolestarDB.alts.chars) == nil)"#);
	assert_eq!(out, true);
}

#[test]
fn player_quiting_and_player_camping_each_write_the_in_world_values_at_once_and_retire_the_pending_timer() {
	let out = run(r#"
IsResting = function() return false end
local writes = 0
local write = Alts.Write
Alts.Write = function(...) writes = writes + 1; return write(...) end
stub.advance(6)
writes = 0
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
local got = {}
stub.world.setMoney(33)
stub.fire("PLAYER_QUITING")
got.quiting = { c().money, writes }
stub.world.setMoney(44)
stub.fire("PLAYER_CAMPING")
got.camping = { c().money, writes }
stub.advance(30)
got.after = writes
emit(got)"#);
	assert_eq!(out["quiting"], json!([33, 1]));
	assert_eq!(out["camping"], json!([44, 2]));
	assert_eq!(out["after"], 2, "no timer fires after them");
}

#[test]
fn resting_a_money_and_an_xp_change_write_at_once_no_timer() {
	let out = run(r#"
stub.advance(6)
local writes = 0
local write = Alts.Write
Alts.Write = function(...) writes = writes + 1; return write(...) end
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
stub.world.setMoney(77)
local a = { writes, c().money }
stub.world.setXP(2500, 4000)
local b = { writes, c().xp }
stub.advance(30)
emit({ a = a, b = b, after = writes })"#);
	assert_eq!(out["a"], json!([1, 77]));
	assert_eq!(out["b"], json!([2, 2500]));
	assert_eq!(out["after"], 2, "no timer");
}

#[test]
fn not_resting_they_coalesce() {
	let out = run(r#"
IsResting = function() return false end
stub.advance(6)
local writes = 0
local write = Alts.Write
Alts.Write = function(...) writes = writes + 1; return write(...) end
local c = function() return PolestarDB.alts.chars["Testchar-Test Realm"] end
stub.world.setMoney(77)
stub.world.setXP(2500, 4000)
local early = { writes, c().money }
stub.advance(11)
emit({ early = early, late = { writes, c().money, c().xp } })"#);
	assert_eq!(out["early"], json!([0, 124000]));
	assert_eq!(out["late"], json!([1, 77, 2500]));
}

#[test]
fn player_update_resting_writes_resting_at_once() {
	let out = run(r#"
stub.advance(6)
IsResting = function() return false end
stub.fire("PLAYER_UPDATE_RESTING")
local off = PolestarDB.alts.chars["Testchar-Test Realm"].resting
IsResting = function() return true end
stub.fire("PLAYER_UPDATE_RESTING")
emit({ off = off == nil, on = PolestarDB.alts.chars["Testchar-Test Realm"].resting })"#);
	assert_eq!(out, json!({ "off": true, "on": true }));
}

#[test]
fn indoors_the_zone_is_the_zone_not_the_inns_name() {
	let out = run(r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 0, right = 1, top = 0, bottom = 1 })
w.moveTo(1429, 50, 50)
GetZoneText = function() return "Lion's Pride Inn" end
GetRealZoneText = function() return "Elwynn Forest" end
Alts.Write()
local mapBased = PolestarDB.alts.chars["Testchar-Test Realm"].zone
C_Map.GetBestMapForUnit = function() return nil end
Alts.Write()
emit({ mapBased = mapBased, fallback = PolestarDB.alts.chars["Testchar-Test Realm"].zone })"#);
	assert_eq!(out["mapBased"], "Elwynn Forest");
	assert_eq!(out["fallback"], "Elwynn Forest", "GetRealZoneText before GetZoneText");
}

#[test]
fn a_readable_0_copper_is_stored_as_0() {
	let out = run(r#"
stub.advance(6)
stub.world.money = 0
Alts.Write()
emit(PolestarDB.alts.chars["Testchar-Test Realm"].money)"#);
	assert_eq!(out, 0);
}
