//! No setting breaks Polestar, whatever else is going on: every control of the settings window through every
//! value it takes (both states of a switch, a slider's ends and middle, every choice, colours; a button pressed, a
//! key bound and cleared), then back at its default, with no Lua error (the client stub's error handler raises
//! whatever a handler throws) and nothing caught by Polestar's own error log: with no guide loaded, in combat (and
//! after it ends), with the guide window off and Polestar hidden, paused, on the gamepad interface, and with the
//! settings window open on each control's own page; in every look (the game looks, Hearth and the skins in the
//! download, each variant), each Look page's controls. Then a seeded random walk of 2,000 changes of any control to
//! any of its values, between guide actions (a step forward or back, a skip, another guide, dungeons and group
//! quests answered, the route's choice, a flight, quests taken, progressed and handed in, combat, the settings
//! window opened) and reloads, each change reading back at once and every setting the same after each reload; and
//! the 40 switches that work together most (the arrow, travel, route lines and pins, the waypoints handed to
//! TomTom, the game and Shortest Path Forever, automation, grey quests, Dynamic Questing, hiding, compact mode,
//! pause, the gamepad), each pair in its four combinations, and each with every answer for the dungeons in the
//! route, a guide action after each.

use crate::settings_roundtrip::{BEFORE, ENV, HELPERS};
use forge_addontest::{emitted, run_addon, text, Addon, RunAddon};
use serde_json::Value;

// The gamepad interface (Options, Gamepad, Enable Gamepad UI): the client answers for its style (gamepad-ui.rs).
const GAMEPAD_UI: &str = "Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }\nC_InputInterfaceStyle = { GetCurrentStyle = function() return 1 end }\n";

// Every control through every value, in CONTEXT: "no guide", "combat", "hidden", "paused", "gamepad" or "window"
// (the settings window open on each control's page: there one other value and the default, its previews and
// rows repainting on each). -> emit({ n = changes, caught = Polestar's own error log })
const SWEEP: &str = r#"
if CONTEXT == "combat" then stub.inCombat = true; stub.fire("PLAYER_REGEN_DISABLED") end
if CONTEXT == "hidden" then Polestar.Set("ui.shown", false); Polestar.SetHidden(true) end
if CONTEXT == "paused" then Polestar.SetPaused(true, "hand") end
if CONTEXT == "window" then UI.ShowOptions("guide") end
stub.advance(0.2)
local M = Polestar.Movers
local pinned = { ["ui.shown"] = CONTEXT == "hidden" }
local n, lastPage, lastTab = 0, nil, nil
for _, c in ipairs(O.AllControls()) do
	if CONTEXT == "window" and c.page and (c.page.key ~= lastPage or c.tab ~= lastTab) then
		lastPage, lastTab = c.page.key, c.tab
		O.Select(lastPage, c.tab or "")
	end
	if not pinned[c.key or ""] then
		if c.kind == "button" then
			c.onClick()
			-- Move frames: back out of it, as the bar's Exit does.
			if M and M.IsUnlocked and M.IsUnlocked() then M.Lock() end
			n = n + 1
		elseif c.kind == "binding" then
			local G = Polestar.Gamepad
			if G and G.Bind then G.Bind(c.action, "F9"); G.Unbind(c.action); n = n + 1 end
		else
			local list = CONTEXT == "window" and { other(c) } or values(c)
			for _, v in ipairs(list) do write(c, v); n = n + 1 end
			write(c, nil)
		end
		stub.advance(0.05)
	end
end
if CONTEXT == "combat" then stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED") end
stub.advance(2)
local caught = {}
for _, e in ipairs(Polestar.Errors()) do caught[#caught + 1] = e.msg .. " (" .. e.count .. "x)" end
emit({ n = n, caught = caught })
"#;

fn sweep(context: &str) {
	let gamepad = context == "gamepad";
	let out = emitted(&RunAddon {
		stubs: if gamepad { vec!["stub_world.lua", "stub_gamepad.lua"] } else { vec!["stub_world.lua"] },
		before: if gamepad { format!("{BEFORE}{GAMEPAD_UI}") } else { BEFORE.into() },
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: format!("CONTEXT = \"{context}\"\nNOGUIDE = CONTEXT == \"no guide\"\n{ENV}\n{HELPERS}\n{SWEEP}"),
		..Default::default()
	})
	.remove(0);
	// The open window changes each control once (one other value), the other contexts every value.
	let least = if context == "window" { 600.0 } else { 700.0 };
	assert!(out["n"].as_f64().unwrap() >= least, "{context}: every control's values: {}", out["n"]);
	assert_eq!(out["caught"], serde_json::json!({}), "{context}: errors Polestar caught");
}

#[test]
fn every_control_through_every_value_with_no_guide_loaded() {
	sweep("no guide");
}

#[test]
fn every_control_through_every_value_in_combat_and_after_it() {
	sweep("combat");
}

#[test]
fn every_control_through_every_value_with_the_guide_window_off_and_polestar_hidden() {
	sweep("hidden");
}

#[test]
fn every_control_through_every_value_while_paused() {
	sweep("paused");
}

#[test]
fn every_control_through_every_value_on_the_gamepad_interface() {
	sweep("gamepad");
}

#[test]
fn every_control_changed_on_its_own_page_of_the_open_settings_window() {
	sweep("window");
}

// Every look (the game looks and Hearth, each skin in the download, each variant): every control of the Look pages to
// another value and back, the guide window, the arrow, an alert and the settings window on the Theme page shown.
#[test]
fn every_look_page_control_in_every_look_and_variant() {
	let mut addons = vec![Addon::name("Polestar")];
	addons.extend(forge_release::addons::SKIN_ADDONS.iter().map(|s| Addon::name(s)));
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: BEFORE.into(),
		addons,
		login: true,
		script: format!(
			r#"{ENV}
{HELPERS}
local T = Polestar.Theme
local looks = {{}}
for _, c in ipairs(T.SkinChoices()) do
	local variants = T.SkinVariants and T.SkinVariants(c.value) or nil
	if variants and #variants > 0 then
		for _, v in ipairs(variants) do looks[#looks + 1] = {{ c.value, v.id }} end
	else
		looks[#looks + 1] = {{ c.value }}
	end
end
local list = {{}}
for _, c in ipairs(settingControls()) do
	if c.page and O.GroupOf(c.page.key) == "look" and c.key ~= "ui.skin" and idOf(c) ~= "Theme:Variant" then list[#list + 1] = c end
end
local n = 0
for _, look in ipairs(looks) do
	if look[2] then Polestar.Set("ui.skinVariants." .. look[1], look[2]) end
	Polestar.Set("ui.skin", look[1])
	UI.ShowOptions("theme")
	if Polestar.Nav and Polestar.Nav.alerts and Polestar.Nav.alerts.ShowSample then Polestar.Nav.alerts.ShowSample() end
	stub.advance(0.5)
	PolestarOptions:Hide()
	for i, c in ipairs(list) do
		write(c, other(c))
		write(c, nil)
		n = n + 2
		if i % 10 == 0 then stub.advance(0.05) end
	end
	stub.advance(0.5)
end
local caught = {{}}
for _, e in ipairs(Polestar.Errors()) do caught[#caught + 1] = e.msg .. " (" .. e.count .. "x)" end
emit({{ looks = #looks, n = n, caught = caught }})"#
		),
		..Default::default()
	})
	.remove(0);
	assert!(out["looks"].as_f64().unwrap() >= 15.0, "the game looks, Hearth and every skin of the download: {}", out["looks"]);
	assert_eq!(out["caught"], serde_json::json!({}), "errors Polestar caught");
}

// ---------------------------------------------------------------------------------------------------------------
// The random walk: a seeded Lehmer generator (the same on every machine, unlike math.random), RNG = its state.
// ---------------------------------------------------------------------------------------------------------------

const WALK: &str = r#"
local function rand(n)
	RNG = RNG * 16807 % 2147483647
	return RNG % n + 1
end
local controls = {}
for _, c in ipairs(O.AllControls()) do controls[#controls + 1] = c end
local E, w, M = Polestar.Engine, stub.world, Polestar.Movers
local recent = {}
local function note(s)
	recent[#recent + 1] = STEP .. " " .. s
	if #recent > 12 then table.remove(recent, 1) end
end
-- The guide actions, by name.
local ACTIONS = {
	{ "next", function() E.Next() end },
	{ "prev", function() E.Prev() end },
	{ "skip", function() E.Skip() end },
	{ "other guide", function() E.SetGuide(E.GetGuide() and E.GetGuide().id == "test/audit" and "test/second" or "test/audit") end },
	{ "dungeon", function() local a = ({ true, false, nil })[rand(3)]; E.ChooseDungeon(36, a) end },
	{ "dungeons", function() Polestar.Set("behavior.dungeons", ({ "run", "skip", "ask" })[rand(3)]) end },
	{ "group quest", function() E.AnswerGroup(176, ({ "do", "skip", nil })[rand(3)]) end },
	{ "route choice", function() Polestar.Set("behavior.routeChoice", ({ "ask", "recommended" })[rand(2)]) end },
	{ "flight", function()
		w.taxi(352, "Stormwind, Elwynn", { "Lakeshire, Redridge" })
		w.close()
		w.onTaxi = true
		stub.fire("PLAYER_CONTROL_LOST")
		stub.advance(2)
		w.onTaxi = false
		stub.fire("PLAYER_CONTROL_GAINED")
	end },
	{ "accept", function() if not w.log[7] then w.accept(7, { 10 }, "Kobold Camp Cleanup") end end },
	{ "progress", function() if w.log[7] then w.progress(7, 1, rand(10)) end end },
	{ "turn in", function() if w.log[7] then w.turnIn(7, 450) end end },
	{ "abandon", function() if w.log[7] then w.abandon(7) end end },
	{ "walk", function() w.moveTo(1429, 40 + rand(15), 35 + rand(15)); stub.advance(0.5) end },
	{ "fight", function() stub.inCombat = true; stub.fire("PLAYER_REGEN_DISABLED"); stub.advance(1); stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED") end },
	{ "settings", function()
		local pages = O.Pages()
		local p = pages[rand(#pages)]
		UI.ShowOptions(p.key)
		if #p.tabs > 0 then O.Select(p.key, p.tabs[rand(#p.tabs)]) end
	end },
	{ "close settings", function() if PolestarOptions then PolestarOptions:Hide() end end },
	{ "hide", function() Polestar.ToggleHidden() end },
}
local function settingStep()
	local c = controls[rand(#controls)]
	if c.kind == "button" then
		note("press " .. idOf(c))
		c.onClick()
		if M and M.IsUnlocked and M.IsUnlocked() then M.Lock() end
	elseif c.kind == "binding" then
		local G = Polestar.Gamepad
		if G and G.Bind then
			note("bind " .. idOf(c))
			if rand(2) == 1 then G.Bind(c.action, "F" .. rand(12)) else G.Unbind(c.action) end
		end
	else
		local list = values(c)
		if #list == 0 or rand(10) == 1 then
			note("reset " .. idOf(c))
			write(c, nil)
		else
			local v = list[rand(#list)]
			note(idOf(c) .. " = " .. show(v))
			write(c, v)
			local back = current(c)
			if not same(back, v) then error(idOf(c) .. ": wrote " .. show(v) .. ", reads " .. show(back)) end
		end
	end
end
-- Steps until the walk's end or a reload (-> true).
local function walk()
	while STEP < LAST do
		STEP = STEP + 1
		local r = rand(1000)
		if r <= 5 then note("reload") return true end
		local ok, err = pcall(function()
			if r <= 775 then settingStep() else
				local a = ACTIONS[rand(#ACTIONS)]
				note(a[1])
				a[2]()
			end
			stub.advance(rand(4) * 0.05)
		end)
		if not ok then error(tostring(err) .. "\nthe last steps:\n" .. table.concat(recent, "\n"), 0) end
	end
	return false
end
local reload = walk()
stub.advance(1)
local caught = {}
for _, e in ipairs(Polestar.Errors()) do caught[#caught + 1] = e.msg .. " (" .. e.count .. "x)" end
-- Every setting as it stands, for the next session to read back.
local keep = {}
for _, c in ipairs(settingControls()) do if not GAME[idOf(c)] then keep[idOf(c)] = { v = current(c) } end end
emit({ step = STEP, rng = RNG, reload = reload, caught = caught, recent = recent,
	saved = "PolestarDB = " .. ser(PolestarDB) .. "\nPolestarCharDB = " .. ser(PolestarCharDB) .. "\nKEEP = " .. ser(keep) })
"#;

// After a reload: every setting reads what it read before it.
const READ_BACK: &str = r#"
local bad = {}
for _, c in ipairs(settingControls()) do
	local k = KEEP[idOf(c)]
	if k and not GAME[idOf(c)] and not same(current(c), k.v) then bad[#bad + 1] = idOf(c) .. ": " .. show(k.v) .. " before the reload, " .. show(current(c)) .. " after" end
end
table.sort(bad)
if #bad > 0 then error("after a reload:\n" .. table.concat(bad, "\n")) end
"#;

#[test]
fn a_seeded_random_walk_of_2000_changes_between_guide_actions_and_reloads() {
	const STEPS: u64 = 2000;
	let (mut step, mut rng, mut saved, mut reloads) = (0u64, 20261114u64, None::<String>, 0);
	while step < STEPS {
		let script = format!("{ENV}\n{HELPERS}\n{}STEP, LAST, RNG = {step}, {STEPS}, {rng}\n{WALK}", if saved.is_some() { READ_BACK } else { "" });
		let out = run_addon(&RunAddon {
			stubs: vec!["stub_world.lua", "stub_encoding.lua", "stub_gamepad.lua"],
			before: BEFORE.into(),
			addons: vec![Addon::name("Polestar")],
			saved: saved.clone().map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
			login: true,
			script,
		})
		.unwrap_or_else(|e| panic!("the walk from step {step} (seed 20261114, {reloads} reloads):\n{e}"))
		.remove(0);
		assert_eq!(out["caught"], serde_json::json!({}), "errors Polestar caught by step {}: last steps {}", out["step"], out["recent"]);
		step = out["step"].as_u64().unwrap();
		rng = out["rng"].as_u64().unwrap();
		if out["reload"] == Value::Bool(true) {
			reloads += 1;
		}
		saved = Some(text(&out["saved"]).to_string());
	}
	assert!(reloads >= 5, "reloads along the walk: {reloads}");
}

// ---------------------------------------------------------------------------------------------------------------
// Pairs: the 40 switches that work together most, and the dungeons' answer.
// ---------------------------------------------------------------------------------------------------------------

const SWITCHES: [&str; 40] = [
	"nav.arrow",
	"nav.hideArrowWithGuide",
	"nav.arrowEta",
	"nav.arrivalSound",
	"nav.travel",
	"nav.teleports",
	"nav.routeLines",
	"nav.navRouting",
	"nav.journeySteps",
	"nav.alerts",
	"nav.worldPins",
	"nav.minimapPins",
	"nav.minimapRoute",
	"nav.upcomingPins",
	"nav.trailDots",
	"nav.blizzardWaypoint",
	"nav.tomtom",
	"nav.useTomTomArrow",
	"nav.arrowToFollower",
	"nav.answerTomTom",
	"nav.followTomTom",
	"nav.spfHandoff",
	"behavior.autoAccept",
	"behavior.autoTurnin",
	"behavior.skipGrey",
	"behavior.closeSkipped",
	"behavior.whileHere",
	"behavior.whileHereTurnins",
	"behavior.autoSelectGuide",
	"behavior.deathskips",
	"ui.shown",
	"ui.compact",
	"ui.wholeStep",
	"maps.minimapButton",
	"ui.launcher",
	"pause.map",
	"pause.automation",
	"gamepad.navigate",
	"qol.flightAutoTake",
	"qol.hideQuestTracker",
];

#[test]
fn the_40_switches_that_work_together_most_each_pair_in_its_four_combinations_and_with_every_dungeon_answer() {
	let keys = SWITCHES.iter().map(|k| format!("{k:?}")).collect::<Vec<_>>().join(", ");
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gamepad.lua"],
		before: BEFORE.into(),
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: format!(
			r#"{ENV}
{HELPERS}
local KEYS = {{ {keys} }}
local E, w = Polestar.Engine, stub.world
for _, k in ipairs(KEYS) do assert(type(Polestar.GetDefault(k)) == "boolean", k .. " is a switch") end
-- A guide action after each combination, in turn.
local ACTIONS = {{
	function() if not w.log[7] then w.accept(7, {{ 10 }}, "Kobold Camp Cleanup") end end,
	function() if w.log[7] then w.progress(7, 1, 5) end end,
	function() E.Next() end,
	function() E.Prev() end,
	function() w.moveTo(1429, 47, 36); stub.advance(0.3); w.moveTo(1429, 48, 42) end,
	function() if w.log[7] then w.finish(7) end end,
	function() if w.log[7] then w.turnIn(7, 450) end end,
	function() stub.inCombat = true; stub.fire("PLAYER_REGEN_DISABLED"); stub.advance(0.2); stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED") end,
	function() w.onTaxi = true; stub.fire("PLAYER_CONTROL_LOST"); stub.advance(0.5); w.onTaxi = false; stub.fire("PLAYER_CONTROL_GAINED") end,
	function() E.SetGuide(E.GetGuide() and E.GetGuide().id == "test/audit" and "test/second" or "test/audit") end,
}}
local turn, combos, bad = 0, 0, {{}}
local function act()
	turn = turn % #ACTIONS + 1
	ACTIONS[turn]()
	stub.advance(0.05)
end
local function check(k, v)
	if Polestar.Get(k) ~= v then bad[#bad + 1] = k .. " reads " .. tostring(Polestar.Get(k)) .. " set to " .. tostring(v) end
end
for i = 1, #KEYS do
	for j = i + 1, #KEYS do
		local a, b = KEYS[i], KEYS[j]
		for _, va in ipairs({{ true, false }}) do
			for _, vb in ipairs({{ true, false }}) do
				Polestar.Set(a, va)
				Polestar.Set(b, vb)
				check(a, va)
				check(b, vb)
				act()
				combos = combos + 1
			end
		end
		Polestar.Set(a, nil)
		Polestar.Set(b, nil)
	end
	-- Each switch with every answer for the dungeons in the route.
	for _, d in ipairs({{ "skip", "ask", "run" }}) do
		for _, v in ipairs({{ true, false }}) do
			Polestar.Set("behavior.dungeons", d)
			Polestar.Set(KEYS[i], v)
			check(KEYS[i], v)
			act()
			combos = combos + 1
		end
	end
	Polestar.Set(KEYS[i], nil)
	Polestar.Set("behavior.dungeons", nil)
end
stub.advance(1)
local caught = {{}}
for _, e in ipairs(Polestar.Errors()) do caught[#caught + 1] = e.msg .. " (" .. e.count .. "x)" end
emit({{ combos = combos, bad = bad, caught = caught }})"#
		),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["combos"], 40 * 39 / 2 * 4 + 40 * 6, "every pair in its four combinations, and with every dungeon answer");
	assert_eq!(out["bad"], serde_json::json!({}), "switches that do not read back");
	assert_eq!(out["caught"], serde_json::json!({}), "errors Polestar caught");
}
