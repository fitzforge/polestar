//! Turning dungeons on, smoothly (#2026): what a player sees when "Dungeons in my route" or one dungeon's answer
//! changes, the guide window's Dungeons on your way, Find a group before a run, the door's choice, what happens to
//! the dungeon quests in the log, and the dungeon card's Add to my route. The window against the real Core + Theme +
//! UI manifests and the contract-faithful fake Engine (tests/lua/stub_ui.lua), as ui.rs; the engine's side
//! (Engine.DungeonsAhead, Engine.DungeonQuestsInLog, the group finder line's step) against the real Core on the stub
//! world, as engine-dungeon-route.rs.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const UI_HELPERS: &str = r#"
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do
		if uistub.calls[i][1] == name then return uistub.calls[i] end
	end
end
local function menuItems()
	GF.menuButton:Click()
	local out = {}
	for _, r in ipairs(PolestarMenu.rows) do
		local t = r:IsShown() and r.Text and r.Text:GetText()
		if t then out[#out + 1] = t end
	end
	Polestar.Widgets.HideMenu()
	return out
end
local function menuPick(text)
	GF.menuButton:Click()
	for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == text then r:Click() return r end end
end
local TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
-- Wailing Caverns in this guide, a level or so ahead, three quests in the Barrens (some off the way: its every-quest
-- route adds 14 minutes); Zul'Farrak much later, in another guide, its quests picked up on the way there.
local WC = { map = 43, name = "Wailing Caverns", level = 20.6, runMap = 1413, pickMap = 1413, pickMaps = { 1413 }, picks = 3, inLog = 0, here = true,
	allQuests = { minutes = 14, xp = 23100 } }
local ZF = { map = 209, name = "Zul'Farrak", level = 46.2, runMap = 1441, pickMap = 1440, pickMaps = { 1440, 1441 }, picks = 2, inLog = 0, here = false }
local B = GF.parts.banner
local function banner() return B:IsShown() and { B.psKind, B.Text:GetText(), B.Jump:IsShown() and B.Jump.Label:GetText() or false, B.Close:IsShown() } or false end
"#;

fn ui(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!(
			"uistub.install()\nstub.login()\nlocal GF, UI, W = Polestar.UI.GuideFrame, Polestar.UI, Polestar.Widgets\nlocal F = PolestarGuideFrame\n{UI_HELPERS}\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

// Fitz: "When people turn dungeons on I want that process to be smooth." Turning "Dungeons in my route" on mid-guide
// says at once what comes next: the next dungeon the route runs, about the level its run comes at and how many of its
// quests the route picks up on the way and where (every quest is woven in, Fitz 2026-11-14), with a link to Dungeons
// on your way; it stays until closed or the route moves on (a step change right after the switch, the route's own
// re-evaluation, keeps it).
#[test]
fn turning_dungeons_on_mid_guide_says_at_once_which_dungeon_comes_next_and_where_its_quests_are_picked_up() {
	let out = ui(r#"
		UnitLevel = function() return 20 end
		uistub.guideDungeons = { [43] = true, [209] = true }
		uistub.dungeonsAhead = { WC, ZF }
		uistub.openTabs(TABS, 1)
		local before = banner()
		Polestar.Set("behavior.dungeons", "run")
		local on = banner()
		Polestar.Fire("STEP_CHANGED", 4)
		local reevaluated = B:IsShown() and B.psKind
		B.Jump:Click()
		local popover = UI.DungeonRoute.Shown()
		UI.DungeonRoute.Hide()
		stub.advance(6)
		Polestar.Fire("STEP_CHANGED", 5)
		emit({ before = before, on = on, reevaluated = reevaluated, popover = popover, movedOn = banner() })"#);
	assert_eq!(out["before"], json!(false));
	assert_eq!(
		out["on"],
		json!([
			"dungeonsChanged",
			"Dungeons on: next is Wailing Caverns, at about level 21.\nIts 3 quests are picked up on your way through The Barrens.",
			"Dungeons on your way",
			true
		])
	);
	assert_eq!(out["reevaluated"], "dungeonsChanged", "the switch's own re-evaluation keeps it");
	assert_eq!(out["popover"], true, "its link opens Dungeons on your way");
	assert_eq!(out["movedOn"], json!(false), "the route moved on: it goes");
}

// Main, 2026-11-14: never silent. A next dungeon far off (a later guide, or levels above) says when and where its run
// comes; Ask me says the guide asks; none left on the route says so.
#[test]
fn dungeons_on_with_the_next_one_far_off_says_when_and_where_it_comes_and_none_left_says_so() {
	let out = ui(r#"
		UnitLevel = function() return 34 end
		uistub.dungeonsAhead = { ZF }
		uistub.openTabs(TABS, 1)
		Polestar.Set("behavior.dungeons", "run")
		local far = banner()
		Polestar.Set("behavior.dungeons", "ask")
		local ask = B.Text:GetText()
		uistub.dungeonsAhead = {}
		Polestar.Set("behavior.dungeons", "run")
		emit({ far = far, ask = ask, none = banner() })"#);
	assert_eq!(
		out["far"],
		json!([
			"dungeonsChanged",
			"Dungeons on: the next one, Zul'Farrak, comes at about level 46 in Thousand Needles.\nIts 2 quests are picked up on your way through Ashenvale and Thousand Needles.",
			"Dungeons on your way",
			true
		])
	);
	assert_eq!(out["ask"], "Dungeons: the guide asks at each one. The next, Zul'Farrak, comes at about level 46 in Thousand Needles.\nIts 2 quests are picked up on your way through Ashenvale and Thousand Needles.");
	assert_eq!(out["none"], json!(["dungeonsChanged", "Dungeons on, but your route has none left.", "Dungeons on your way", true]));
}

// Turning dungeons off says what happens to the dungeon quests already in the log (Engine.DungeonQuestsInLog):
// finished ones are still handed in, the rest wait in Clean up quest log (its link); all finished, no link; none in
// the log, the one line.
#[test]
fn turning_dungeons_off_says_what_happens_to_the_dungeon_quests_already_in_the_log() {
	let out = ui(r#"
		local room = 0
		UI.ShowQuestRoom = function() room = room + 1 end
		uistub.dungeonsAhead = { WC }
		uistub.openTabs(TABS, 1)
		Polestar.Set("behavior.dungeons", "run")
		uistub.dungeonQuestsInLog = { { quest = 959, title = "Trouble at the Docks", ready = true }, { quest = 1491, title = "Smart Drinks", ready = false } }
		Polestar.Set("behavior.dungeons", "skip")
		local mixed = banner()
		B.Jump:Click()
		local afterLink = { room, B:IsShown() and B.psKind or false }
		Polestar.Set("behavior.dungeons", "run")
		uistub.dungeonQuestsInLog = { { quest = 959, title = "Trouble at the Docks", ready = true } }
		Polestar.Set("behavior.dungeons", "skip")
		local finished = banner()
		Polestar.Set("behavior.dungeons", "run")
		uistub.dungeonQuestsInLog = {}
		Polestar.Set("behavior.dungeons", "skip")
		emit({ mixed = mixed, afterLink = afterLink, finished = finished, none = banner() })"#);
	assert_eq!(
		out["mixed"],
		json!([
			"dungeonsChanged",
			"Dungeons off: the guide keeps to the solo route.\nStill in your log: “Trouble at the Docks”, “Smart Drinks”.\nFinished ones are still handed in; Clean up quest log lists the rest.",
			"Clean up quest log",
			true
		])
	);
	assert_eq!(out["afterLink"], json!([1, false]), "the link opens the quest log cleanup and the notice goes");
	assert_eq!(
		out["finished"],
		json!([
			"dungeonsChanged",
			"Dungeons off: the guide keeps to the solo route.\nStill in your log: “Trouble at the Docks”.\nThey're finished, so the guide still hands them in.",
			false,
			true
		])
	);
	assert_eq!(out["none"], json!(["dungeonsChanged", "Dungeons off: the guide keeps to the solo route.", false, true]));
}

// One dungeon switched from outside the window's own questions (the settings' Discovery rows, Dungeons on your way,
// the card) says so for that dungeon; the window's own answers (Run it, Skip it at Ask me's question) say nothing
// more: the player is looking at it.
#[test]
fn one_dungeon_switched_elsewhere_says_so_the_windows_own_answers_say_nothing_more() {
	let out = ui(r#"
		UnitLevel = function() return 20 end
		uistub.dungeonsAhead = { WC }
		uistub.openTabs(TABS, 1)
		local E = Polestar.Engine
		E.ChooseDungeon(43, true)
		local on = B.Text:GetText()
		E.ChooseDungeon(43, false)
		local off = B.Text:GetText()
		GF.DismissBanner()
		local closed = banner()
		uistub.dungeonQuestion = { map = 36, name = "The Deadmines", quests = 2, runIn = 4 }
		GF.Layout()
		B.Jump:Click()
		emit({ on = on, off = off, closed = closed, ownAnswer = banner() })"#);
	assert_eq!(out["on"], "Wailing Caverns is on your route, at about level 21.\nIts 3 quests are picked up on your way through The Barrens.");
	assert_eq!(out["off"], "Wailing Caverns is off your route.");
	assert_eq!(out["closed"], json!(false));
	assert_eq!(out["ownAnswer"], json!(false), "Run it at the question: no notice on top");
}

// Main, 2026-11-14: the door knows the player's group. Solo it asks I'm in a group (the banner goes for this run, the
// step stays) or Skip this one; in a party the run is simply on, Skip this one still there, and the banner closes for
// this run. After Skip this one the kept quests say what happens to them.
#[test]
fn the_door_asks_im_in_a_group_or_skip_this_one_solo_and_in_a_party_the_run_is_simply_on() {
	let solo = ui(r#"
		uistub.dungeonRun = { map = 36, name = "The Deadmines" }
		uistub.openTabs(TABS, 1)
		local asked = banner()
		B.Jump:Click()
		emit({ asked = asked, grouped = banner(), skip = lastCall("SkipDungeon") or false })"#);
	assert_eq!(
		solo["asked"],
		json!([
			"dungeonRun",
			"The Deadmines: a group of five runs it in about an hour.\nNo group? Skip this one: its quests stay in your log, and finished ones are still handed in.",
			"I'm in a group",
			false
		])
	);
	assert_eq!(solo["grouped"], json!(false), "I'm in a group: the banner goes for this run");
	assert_eq!(solo["skip"], json!(false), "and nothing is skipped");
	let party = ui(r#"
		GetNumSubgroupMembers = function() return 1 end
		uistub.dungeonRun = { map = 36, name = "The Deadmines" }
		uistub.openTabs(TABS, 1)
		local shown = { banner(), B.Later:IsShown() and B.Later.Label:GetText() }
		B.Close:Click()
		emit({ shown = shown, closed = banner() })"#);
	assert_eq!(
		party["shown"],
		json!([
			["dungeonRun", "The Deadmines with your group: about an hour inside.\nSkip this one keeps its quests in your log; finished ones are still handed in.", false, true],
			"Skip this one"
		])
	);
	assert_eq!(party["closed"], json!(false), "closed for this run");
	let skipped = ui(r#"
		uistub.dungeonRun = { map = 36, name = "The Deadmines" }
		uistub.dungeonQuestsInLog = { { quest = 167, title = "Oh Brother. . .", ready = false }, { quest = 214, title = "Red Silk Bandanas", ready = true } }
		uistub.openTabs(TABS, 1)
		B.Later:Click()
		emit({ call = lastCall("SkipDungeon"), kept = banner() })"#);
	assert_eq!(skipped["call"], json!(["SkipDungeon", 36]));
	assert_eq!(
		skipped["kept"],
		json!([
			"dungeonKept",
			"Kept in your log: “Oh Brother. . .”, “Red Silk Bandanas”\nFinished ones are still handed in; Clean up quest log lists the rest.",
			"Clean up quest log",
			true
		])
	);
}

// Find a group, a few steps before a chosen dungeon's run: a secure button (PolestarFindGroup, type "click") lies
// over the link and presses the game's own Group Finder button, as the player's click would (opened from addon code
// the window's searches are refused). Let go before a fight's lockdown and laid again after it; in a fight the
// link's own click says the key. Another notice, or no Group Finder button: no secure button and no link.
#[test]
fn find_a_group_lays_a_secure_button_over_its_link_that_presses_the_games_group_finder_button() {
	let out = ui(r#"
		-- Secure frames as the client has them (as stub_qol.lua does): no layout of one in a fight.
		local M = stub.Methods
		for _, name in ipairs({ "SetAttribute", "Show", "Hide", "SetPoint", "ClearAllPoints" }) do
			local original = M[name]
			M[name] = function(self, ...)
				if self.secure and stub.inCombat then error("protected call in combat: " .. tostring(self.name) .. ":" .. name, 2) end
				return original(self, ...)
			end
		end
		local createFrame = CreateFrame
		CreateFrame = function(kind, name, parent, template, ...)
			local f = createFrame(kind, name, parent, template, ...)
			if type(template) == "string" and template:find("Secure") then f.secure = true end
			return f
		end
		LFGMicroButton = CreateFrame("Button", "LFGMicroButton", UIParent)
		uistub.dungeonSoon = { map = 43, name = "Wailing Caverns", steps = 3 }
		uistub.openTabs(TABS, 1)
		local s = PolestarFindGroup
		local armed = { banner(), s and s:IsShown(), s and s:GetAttribute("type"), s and s:GetAttribute("clickbutton") == LFGMicroButton, select(2, s:GetPoint(1)) == B.Jump }
		local ran = {}
		stub.mouseClick(s, ran)
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.inCombat = true
		local fight = s:IsShown()
		stub.messages = {}
		B.Jump:Click()
		local hint = stub.messages[#stub.messages] or false
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
		local after = s:IsShown()
		uistub.dungeonSoon = nil
		uistub.dungeonRun = { map = 43, name = "Wailing Caverns" }
		GF.Layout()
		local otherNotice = s:IsShown()
		emit({ armed = armed, ran = ran, fight = fight, hint = hint, after = after, otherNotice = otherNotice })"#);
	assert_eq!(out["armed"], json!([["dungeonSoon", "Wailing Caverns in 3 steps: start looking for a group.", "Find a group", true], true, "click", true, true]));
	assert_eq!(out["ran"], json!([["click", false]]), "the click presses the Group Finder button");
	assert_eq!(out["fight"], false, "let go before the lockdown");
	assert!(out["hint"].as_str().unwrap_or("").contains("Open the group finder from the game's menu bar."), "{}", out["hint"]);
	assert_eq!(out["after"], true, "laid again after the fight");
	assert_eq!(out["otherNotice"], false, "another notice: let go");
	let none = ui(r#"
		uistub.dungeonSoon = { map = 43, name = "Wailing Caverns", steps = 3 }
		uistub.openTabs(TABS, 1)
		emit({ banner = banner(), secure = PolestarFindGroup ~= nil and PolestarFindGroup:IsShown() })"#);
	assert_eq!(none["banner"], json!(["dungeonSoon", "Wailing Caverns in 3 steps: start looking for a group.", false, true]));
	assert_eq!(none["secure"], json!(false));
}

// The guide window's menu has Dungeons on your way while this character's guides have dungeons: "Dungeons in my
// route" and the next dungeons on the route, each with about its level, where its quests are picked up (the guide
// asks, under Ask me, for one not set) and a switch that answers it (Engine.ChooseDungeon); All dungeons… opens the
// settings' rows for every dungeon.
#[test]
fn the_guide_menu_opens_dungeons_on_your_way_with_the_next_dungeons_and_a_switch_each() {
	let out = ui(r#"
		uistub.openTabs(TABS, 1)
		local without = menuItems()
		uistub.guideDungeons = { [43] = true, [209] = true }
		uistub.dungeonsAhead = { WC, ZF }
		Polestar.Set("behavior.dungeons", "ask")
		GF.DismissBanner()
		local with = menuItems()
		menuPick("Dungeons on your way")
		local DR = UI.DungeonRoute
		local function rows()
			local out = {}
			for i, r in ipairs(DR.Rows()) do
				out[i] = { r.Name:GetText(), r.Sub:GetText(), r.psOn, r.Way:IsShown() and { r.Way.Label:GetText(), r.Way.Note:GetText(), r.Way.psOn } or false }
			end
			return out
		end
		local opened, before = DR.Shown(), rows()
		DR.Rows()[1].Switch:Click()
		local call, after = lastCall("ChooseDungeon"), rows()
		DR.Rows()[1].Way.Switch:Click()
		local wayCall, wayOnly = lastCall("ChooseDungeonWayOnly"), rows()[1]
		DR.Rows()[1].Switch:Click()
		local off = rows()[1]
		local opts
		UI.ShowOptions = function(page) opts = page end
		PolestarDungeonRoute.All:Click()
		emit({ without = without, with = with, opened = opened, before = before, call = call, after = after, wayCall = wayCall, wayOnly = wayOnly, off = off,
			opts = opts or false, closed = DR.Shown() })"#);
	let without: Vec<String> = serde_json::from_value(out["without"].clone()).unwrap();
	let with: Vec<String> = serde_json::from_value(out["with"].clone()).unwrap();
	assert!(!without.iter().any(|t| t == "Dungeons on your way"), "{without:?}");
	let at = with.iter().position(|t| t == "Dungeons on your way").expect("the menu has it");
	assert_eq!(with[at + 1], "Quick settings", "just before Quick settings: {with:?}");
	assert_eq!(out["opened"], true);
	assert_eq!(
		out["before"],
		json!([
			["Wailing Caverns", "About level 21  ·  3 quests in The Barrens  ·  the guide asks", false, ["Only quests on my way", "Saves about 14 min, 23,100 XP less", false]],
			["Zul'Farrak", "About level 46  ·  2 quests in Ashenvale and Thousand Needles  ·  the guide asks", false, false]
		]),
		"every quest by default; the opt-out only where some are off the way"
	);
	assert_eq!(out["call"], json!(["ChooseDungeon", 43, true]));
	assert_eq!(out["after"][0], json!(["Wailing Caverns", "About level 21  ·  3 quests in The Barrens", true, ["Only quests on my way", "Saves about 14 min, 23,100 XP less", false]]));
	assert_eq!(out["wayCall"], json!(["ChooseDungeonWayOnly", 43, true]));
	assert_eq!(out["wayOnly"][3][2], true, "Only quests on my way: on");
	assert_eq!(out["off"], json!(["Wailing Caverns", "About level 21  ·  3 quests in The Barrens", false, false]), "switched off: no opt-out to show");
	assert_eq!(out["opts"], "dungeons");
	assert_eq!(out["closed"], false);
}

// The dungeon card for a dungeon the route can still take (Engine.DungeonsAhead) leads with Add to my route (that
// dungeon's answer, Run it) and its page second; once the route runs it the card says so and leads with its page; a
// dungeon off the route keeps the pick-up guide.
#[test]
fn the_dungeon_card_offers_add_to_my_route_for_a_dungeon_the_route_can_still_take() {
	let out = ui(r#"
		Polestar.Dungeons = {
			Get = function(key) return key == "wailing-caverns" and { key = key, map = 43 } or { key = key, map = 999 } end,
			PickUp = function() return nil, "nothing" end,
		}
		local DT = UI.DungeonToast
		local c = { key = "wailing-caverns", name = "Wailing Caverns", level = 20, take = 4, minLevel = 17, maxLevel = 24, zoneName = "The Barrens" }
		uistub.dungeonsAhead = { WC }
		local m = DT.Model(c)
		local offered = { m.act.label, m.more and m.more.label or false }
		m.act.run(m)
		local call = lastCall("ChooseDungeon")
		local m2 = DT.Model(c)
		local onRoute = { m2.act.label, m2.more and m2.more.label or false, m2.giver }
		local m3 = DT.Model({ key = "the-deadmines", name = "The Deadmines", level = 20, take = 2, minLevel = 17, maxLevel = 26 })
		emit({ offered = offered, call = call, onRoute = onRoute, offRoute = m3.act.label })"#);
	assert_eq!(out["offered"], json!(["Add to my route", "Open in Dungeons"]));
	assert_eq!(out["call"], json!(["ChooseDungeon", 43, true]));
	assert_eq!(
		out["onRoute"],
		json!(["Open in Dungeons", false, "4 quests to pick up  ·  Levels 17–24  ·  The Barrens\nOn your route: the guide picks its quests up on your way."])
	);
	assert_eq!(out["offRoute"], "Pick up the quests");
}

// ---------------------------------------------------------------------------------------------------------------
// The engine's side, on the real Core.

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(10)
w.titles[214] = "Red Silk Bandanas"
w.titles[167] = "Oh Brother. . ."
w.titles[7] = "Kobold Camp Cleanup"
w.titles[15] = "Investigate Echo Ridge"
w.titles[2040] = "Underground Assault"
w.titles[5761] = "Slaying the Beast"
"#;

// test/route: (1) a pick-up, (2, 3) solo steps, (4) the run's own stop with the pick-ups again, (5) the guarded run,
// (6) its hand-in, (7) solo; levels 10 to 16, the run gated at 18 (the dungeon's floor). test/first leads into
// test/later, whose dungeon is the only one: its pick-up and its run, levels 20 to 30. test/every: the Deadmines
// with a quest off the way (3, `all`: its every-quest route, 14 minutes and 23,100 XP by the guide's `dungeonAll`).
// test/city: Ragefire Chasm, Orgrimmar's, for this Alliance character.
const GUIDES: &str = r#"
local DM = { k = "dungeon", name = "The Deadmines", map = 36 }
local WC = { k = "dungeon", name = "Wailing Caverns", map = 43 }
Polestar.RegisterGuide({
	id = "test/route", pack = "test", title = "Route", minLevel = 10, maxLevel = 16,
	steps = {
		{ title = "Scout Riell", when = { DM }, goals = {
			{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1429, x = 48.0, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Echo Ridge", goals = {
			{ t = "accept", quest = 15, title = "Investigate Echo Ridge", npc = 197, npcName = "Marshal McBride", map = 1429, x = 47.5, y = 40.0 },
		} },
		{ title = "Sentinel Hill", when = { DM }, goals = {
			{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1436, x = 56.0, y = 47.0 },
			{ t = "accept", quest = 167, title = "Oh Brother. . .", npc = 6670, npcName = "Scout Riell", map = 1436, x = 56.0, y = 47.0 },
		} },
		{ title = "The Deadmines", when = { DM, { k = "onquest", q = { 214, 167 } }, { k = "level", op = ">=", n = 18 } }, goals = {
			{ t = "enter", location = "The Deadmines", map = 1436, x = 42.0, y = 70.0 },
			{ t = "complete", quest = 214, title = "Red Silk Bandanas" },
		} },
		{ title = "Scout Riell", when = { DM, { k = "complete", q = 214 } }, goals = {
			{ t = "turnin", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1436, x = 56.0, y = 47.0 },
		} },
		{ title = "Goldshire", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
local DM_ALL = { k = "dungeon", name = "The Deadmines", map = 36, all = true }
Polestar.RegisterGuide({
	id = "test/every", pack = "test", title = "Every quest", minLevel = 10, maxLevel = 16, dungeonAll = { [36] = { minutes = 14, xp = 23100 } },
	steps = {
		{ title = "Scout Riell", when = { DM }, goals = {
			{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6670, npcName = "Scout Riell", map = 1436, x = 56.0, y = 47.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Ironforge", when = { DM_ALL }, goals = {
			{ t = "accept", quest = 2040, title = "Underground Assault", npc = 6294, npcName = "Shoni the Shilent", map = 1455, x = 55.5, y = 47.7 },
		} },
		{ title = "The Deadmines", when = { DM, { k = "onquest", q = { 214, 2040 } } }, goals = {
			{ t = "enter", location = "The Deadmines", map = 1436, x = 42.0, y = 70.0 },
		} },
		{ title = "Goldshire", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
local RFC = { k = "dungeon", name = "Ragefire Chasm", map = 389 }
Polestar.RegisterGuide({
	id = "test/city", pack = "test", title = "City", minLevel = 10, maxLevel = 16,
	steps = {
		{ title = "Orgrimmar", when = { RFC }, goals = {
			{ t = "accept", quest = 5761, title = "Slaying the Beast", npc = 3216, npcName = "Neeru Fireblade", map = 1454, x = 49.4, y = 50.6 },
		} },
		{ title = "Ragefire Chasm", when = { RFC, { k = "onquest", q = { 5761 } } }, goals = {
			{ t = "enter", location = "Ragefire Chasm", map = 1454, x = 52.0, y = 49.0 },
		} },
		{ title = "Goldshire", goals = {
			{ t = "goto", map = 1429, x = 42.1, y = 65.9, label = "Goldshire" },
		} },
	},
})
Polestar.RegisterGuide({
	id = "test/first", pack = "test", title = "First", minLevel = 10, maxLevel = 20, next = "test/later",
	steps = {
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
Polestar.RegisterGuide({
	id = "test/later", pack = "test", title = "Later", minLevel = 20, maxLevel = 30,
	steps = {
		{ title = "Echo Ridge", goals = {
			{ t = "accept", quest = 15, title = "Investigate Echo Ridge", npc = 197, npcName = "Marshal McBride", map = 1429, x = 47.5, y = 40.0 },
		} },
		{ title = "Nalpak", when = { WC }, goals = {
			{ t = "accept", quest = 1486, title = "Deviate Hides", npc = 5767, npcName = "Nalpak", map = 1413, x = 47.0, y = 36.0 },
		} },
		{ title = "Wailing Caverns", when = { WC, { k = "onquest", q = { 1486 } } }, goals = {
			{ t = "enter", location = "Wailing Caverns", map = 1413, x = 46.0, y = 36.5 },
		} },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
function at() return E.GetLiveStep() end
function take(q) w.accept(q, { 1 }); flush() end
function st(i) return E.GetStepView(i).status end
function ahead()
	local out = {}
	for i, d in ipairs(E.DungeonsAhead()) do
		out[i] = { map = d.map, name = d.name, level = math.floor(d.level * 10 + 0.5) / 10, runMap = d.runMap, pickMap = d.pickMap or false,
			pickMaps = d.pickMaps, picks = d.picks, inLog = d.inLog, guideId = d.guideId, here = d.here, answer = d.answer == nil and "ask" or d.answer,
			wayOnly = d.wayOnly, allQuests = d.allQuests or false }
	end
	return out
end
"#;

/// The real Core on the stub world, `guide` open, "Dungeons in my route" `route` (behavior.dungeons), `world` (Lua,
/// before login: quests already in the log).
fn engine(guide: &str, route: &str, world: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\n{world}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![(
			"Polestar".into(),
			format!("PolestarCharDB = {{ schema = 1, guide = \"{guide}\" }}\nPolestarDB = {{ schema = 1, settings = {{ behavior = {{ dungeons = \"{route}\" }} }} }}"),
		)],
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

// Engine.DungeonsAhead: each dungeon whose run the route can still take, in route order, with about the level its run
// comes at (its level gate, the dungeon's floor, above where the guide's levels have the character there), where its
// first pick-up and its run are, its answer; a dungeon in a later guide too (`next`). Its quests in the log count
// (the run's `when onquest`); a dungeon whose pick-ups the route passed with none taken is not listed: its run
// would not come.
#[test]
fn dungeons_ahead_lists_each_dungeon_the_route_can_still_take_with_its_level_and_where_it_is() {
	let here = engine("test/route", "skip", "", "emit({ at = at(), ahead = ahead() })");
	assert_eq!(here["at"], 2, "Skip: the solo route");
	assert_eq!(
		here["ahead"],
		json!([{ "map": 36, "name": "The Deadmines", "level": 18, "runMap": 1436, "pickMap": 1436, "pickMaps": [1436], "picks": 2, "inLog": 0, "guideId": "test/route", "here": true,
			"answer": false, "wayOnly": false, "allQuests": false }]),
		"its gate (18) above the guide's 14 at the run; its pick-ups at Sentinel Hill, the first ahead"
	);
	let carried = engine("test/route", "skip", "w.onQuest(214, { 1 })", "emit(ahead())");
	assert_eq!(carried[0]["inLog"], 1);
	assert_eq!(carried[0]["picks"], 1, "Oh Brother. . . still to pick up");
	let passed = engine("test/route", "skip", "", r#"take(7); take(15); Polestar.Set("behavior.dungeons", "run"); flush(); emit({ at = at(), ahead = ahead() })"#);
	assert_eq!(passed["at"], 7, "the pick-ups passed with none taken");
	assert_eq!(passed["ahead"], json!({}), "its run would not come: not listed");
	let later = engine("test/first", "ask", "", "emit(ahead())");
	assert_eq!(
		later,
		json!([{ "map": 43, "name": "Wailing Caverns", "level": 30, "runMap": 1413, "pickMap": 1413, "pickMaps": [1413], "picks": 1, "inLog": 0, "guideId": "test/later", "here": false,
			"answer": "ask", "wayOnly": false, "allQuests": false }]),
		"a later guide's dungeon: at that guide's levels"
	);
}

// Engine.DungeonQuestsInLog: the dungeon quests in the log, finished ones ready (still handed in whatever the
// answer), in quest id order; the group finder line ("Need a group?") shows on the run only, not on the dungeon's
// pick-ups and hand-ins.
#[test]
fn dungeon_quests_in_the_log_say_which_are_finished_and_the_group_finder_line_is_on_the_run_only() {
	let out = engine(
		"test/route",
		"run",
		"w.setLevel(18); w.onQuest(214, { 1 }); w.onQuest(167, { 1 })",
		r#"w.finish(214); flush()
		local function entrance(i) local v = E.GetStepView(i); return v and v.goals[1].entrance or false end
		emit({ log = E.DungeonQuestsInLog(36), all = #E.DungeonQuestsInLog(), entrance = { entrance(4), entrance(5), entrance(6) } })"#,
	);
	assert_eq!(
		out["log"],
		json!([{ "quest": 167, "title": "Oh Brother. . .", "ready": false }, { "quest": 214, "title": "Red Silk Bandanas", "ready": true }])
	);
	assert_eq!(out["all"], 2);
	assert_eq!(out["entrance"], json!([false, true, false]), "the pick-up and the hand-in carry no group finder line");
}

// Fitz, 2026-11-14: a dungeon run takes every one of its quests, the ones off the way too (`when dungeon "<Name>" all`
// steps); "Only quests on my way" (Engine.ChooseDungeonWayOnly, per dungeon) leaves those out, and their steps lose
// their numbers. Dungeons on your way counts them and carries what the opt-out saves (the guide's `dungeonAll`). An
// every-quest step never asks: with Ask me the question comes at the dungeon's own pick-ups or run.
#[test]
fn a_dungeon_run_takes_every_quest_and_only_quests_on_my_way_leaves_the_ones_off_the_way_out() {
	let out = engine(
		"test/every",
		"run",
		"",
		r#"take(214); take(7)
		local function picks() local d = E.DungeonsAhead()[1]; return d and { d.picks, d.pickMaps, d.wayOnly, d.allQuests or false } or false end
		local every = { at = at(), s3 = st(3), ahead = picks(), total = E.StepTotal() }
		E.ChooseDungeonWayOnly(36, true); flush()
		emit({ every = every, wayOnly = { at = at(), s3 = st(3), ahead = picks(), total = E.StepTotal(), saved = E.DungeonWayOnly(36) } })"#,
	);
	assert_eq!(out["every"]["at"], 3, "every quest: the one off the way comes next");
	assert_eq!(out["every"]["ahead"], json!([1, [1455], false, { "minutes": 14, "xp": 23100 }]));
	assert_eq!(out["wayOnly"]["at"], 4, "only quests on my way: on to the run");
	assert_eq!(out["wayOnly"]["s3"], "skipped", "passed: not for this character");
	assert_eq!(out["wayOnly"]["saved"], true);
	assert_eq!(out["wayOnly"]["ahead"], json!([0, {}, true, { "minutes": 14, "xp": 23100 }]), "its quest off the way is no pick-up any more");
	assert_eq!(out["wayOnly"]["total"].as_i64().unwrap() + 1, out["every"]["total"].as_i64().unwrap(), "its step has no number");
	let ask = engine("test/every", "ask", "w.onQuest(214, { 1 })", "take(7); emit({ at = at(), asked = (E.DungeonQuestion() or {}).map or false })");
	assert_eq!(ask, json!({ "at": 4, "asked": 36 }), "the every-quest step passes unasked; the run asks");
}

// Fitz, 2026-11-14: a city dungeon is its faction's only. Dungeons on your way never lists Ragefire Chasm for an
// Alliance character, its steps in the guide or not, whatever the answer.
#[test]
fn dungeons_on_your_way_never_lists_a_city_dungeon_of_the_other_faction() {
	let out = engine("test/city", "run", "", "emit({ ahead = #E.DungeonsAhead(), at = at() })");
	assert_eq!(out, json!({ "ahead": 0, "at": 3 }));
}

// Fitz, 2026-11-14: three styles. Dungeons off (the solo route), or on with "Dungeon quests" (behavior.dungeonQuests):
// every quest of each dungeon the route runs (the default) or only the ones on the way. A dungeon's own choice
// (Dungeons on your way, CharState().dungeonsAll) wins either way.
#[test]
fn dungeon_quests_takes_every_quest_or_only_the_ones_on_the_way_and_a_dungeons_own_choice_wins() {
	let style = |quests: &str, own: &str| {
		engine(
			"test/every",
			"run",
			"",
			&format!(r#"Polestar.Set("behavior.dungeonQuests", "{quests}"); {own} flush(); take(214); take(7); emit({{ at = at(), wayOnly = E.DungeonWayOnly(36) }})"#),
		)
	};
	assert_eq!(style("all", ""), json!({ "at": 3, "wayOnly": false }), "every quest: the one off the way comes next");
	assert_eq!(style("way", ""), json!({ "at": 4, "wayOnly": true }), "only the ones on the way: on to the run");
	assert_eq!(style("way", "E.ChooseDungeonWayOnly(36, false)"), json!({ "at": 3, "wayOnly": false }), "its own choice wins: every quest");
	assert_eq!(style("all", "E.ChooseDungeonWayOnly(36, true)"), json!({ "at": 4, "wayOnly": true }), "its own choice wins: only on the way");
	let off = engine("test/every", "skip", "", r#"take(7); emit({ at = at(), s1 = st(1), s3 = st(3), s4 = st(4) })"#);
	assert_eq!(off, json!({ "at": 5, "s1": "skipped", "s3": "skipped", "s4": "skipped" }), "dungeons off: none of its steps");
}

// Fitz, 2026-11-14: Every dungeon quest warns before it applies, once per account: be ready for more travelling.
// Chosen in the settings (or the popover), the choice waits as Only quests on my way until the player takes it;
// turned on with it already chosen (the default), it asks then. After the first time it applies at once.
#[test]
fn every_dungeon_quest_warns_once_before_it_applies() {
	let out = ui(r#"
		local function q() return Polestar.Get("behavior.dungeonQuests") end
		local function dialog() return W.ModalShown() and PolestarModal.Box.Text:GetText() or false end
		Polestar.Set("behavior.dungeonQuests", "way")
		Polestar.Set("behavior.dungeonQuests", "all")
		local held = { q(), dialog() }
		PolestarModal.Box.Action:Click()
		local taken = { q(), W.ModalShown(), Polestar.DB().dungeonQuestsWarned }
		Polestar.Set("behavior.dungeonQuests", "way")
		Polestar.Set("behavior.dungeonQuests", "all")
		local again = { q(), W.ModalShown() }
		emit({ held = held, taken = taken, again = again })"#);
	assert_eq!(
		out["held"],
		json!(["way", "Be ready for more travelling. Dungeon quests are scattered across the world, so the route takes extra trips to pick them up and hand them in."]),
		"asked first, the choice waiting"
	);
	assert_eq!(out["taken"], json!(["all", false, true]));
	assert_eq!(out["again"], json!(["all", false]), "once per account: no second warning");
	let on = ui(r#"
		Polestar.Set("behavior.dungeons", "run")
		local asked = W.ModalShown()
		PolestarModal.Box.Cancel:Click()
		emit({ asked = asked, quests = Polestar.Get("behavior.dungeonQuests") })"#);
	assert_eq!(on, json!({ "asked": true, "quests": "way" }), "turned on with Every dungeon quest: asked then; Only quests on my way chosen");
}

// With Ask me: answered Run at the dungeon's first pick-up (a plain `when dungeon` step), its every-quest step after it
// applies with Every dungeon quest and is passed with Only quests on my way.
#[test]
fn ask_me_answered_run_then_the_every_quest_step_applies_or_is_passed_by_dungeon_quests() {
	let run = |quests: &str| {
		engine(
			"test/every",
			"ask",
			"",
			&format!(r#"Polestar.Set("behavior.dungeonQuests", "{quests}"); flush(); local asked = at(); E.ChooseDungeon(36, true); flush(); take(214); take(7); emit({{ asked = asked, at = at(), s3 = st(3) }})"#),
		)
	};
	assert_eq!(run("all"), json!({ "asked": 1, "at": 3, "s3": "current" }));
	assert_eq!(run("way"), json!({ "asked": 1, "at": 4, "s3": "skipped" }));
}
