'use strict';
// Sky Jewels by RikyZ90, one of the flight games in Polestar_Arcade (games/skyjewels; Maps/Arcade.lua
// opens it): loaded with the folder on the first Play, the board kept through fights, a rejected save
// rebuilt, put away on landing, and the generated levels all winnable.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { findLua } = require('../tools/lib/lua');

const skip = (() => {
	try {
		findLua();
		return false;
	} catch {
		return 'no Lua 5.1';
	}
})();
const login = { addons: ['Polestar'], stubs: ['stub_world.lua'], login: true };
// Polestar_Arcade in the AddOns list, loadable on demand, as the client gives it.
const ARCADE = 'stub.addons[#stub.addons + 1] = { name = "Polestar_Arcade", reason = "DEMAND_LOADED" }';

test('the guide menu offers the chosen game, Sky Jewels, only while Polestar_Arcade can load', { skip }, () => {
	runAddon({
		...login,
		script: `
Polestar.Set("arcade.game", "skyjewels")
local menu = Polestar.Theme.GuideParts().nav.Menu
local entry
Polestar.Widgets.ShowMenu = function(_, items)
	entry = nil
	for _, item in ipairs(items) do
		if item.icon == "gamepad" then entry = item end
	end
end
local function openMenu()
	Polestar.UI.GuideFrame.OpenMenu(menu)
	return entry
end
assert(not openMenu(), "no Polestar_Arcade: no game in the menu")
local addon = { name = "Polestar_Arcade", reason = "DISABLED" }
stub.addons[#stub.addons + 1] = addon
assert(not openMenu(), "Polestar_Arcade turned off: no game in the menu")
addon.reason = "DEP_DEMAND_LOADED"
assert(openMenu(), "loadable through a dependency that loads on demand: the game is offered")
addon.reason = "DEMAND_LOADED"
local play = assert(openMenu(), "loadable on demand: the game is offered")
assert(play.text == "Play Sky Jewels", "the menu offers the chosen game: " .. tostring(play.text))
assert(not C_AddOns.IsAddOnLoaded("Polestar_Arcade"), "opening the menu loaded the games")
play.onClick()
assert(C_AddOns.IsAddOnLoaded("Polestar_Arcade") and Polestar.Arcade.IsOpen("skyjewels"), "the menu entry did not open Sky Jewels")
assert(openMenu(), "the loaded folder keeps its menu entry")`,
	});
});

test('Sky Jewels loads with Polestar_Arcade only when first opened with /polestar jewels', { skip }, () => {
	runAddon({
		...login,
		script: `
${ARCADE}
assert(not C_AddOns.IsAddOnLoaded("Polestar_Arcade"), "Polestar_Arcade was loaded at login")
assert(not PolestarSkyJewels, "Sky Jewels made a window at login")
SlashCmdList.POLESTAR("jewels")
assert(C_AddOns.IsAddOnLoaded("Polestar_Arcade"), "the command did not load Polestar_Arcade")
assert(Polestar.Arcade.IsOpen("skyjewels"), "the command did not open Sky Jewels")
assert(Polestar.Arcade.Active() == "skyjewels", "Sky Jewels is not the game open")`,
	});
});

test('Sky Jewels keeps its board when a fight on the ground puts it away', { skip }, () => {
	runAddon({
		...login,
		script: `
${ARCADE}
local A = Polestar.Arcade
stub.inCombat = true
stub.fire("PLAYER_REGEN_DISABLED")
Polestar.RunCommand("jewels")
assert(not C_AddOns.IsAddOnLoaded("Polestar_Arcade"), "Polestar_Arcade loaded in combat")

stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
Polestar.RunCommand("jewels")
assert(A.IsOpen("skyjewels"), "Sky Jewels did not open out of combat")
local saved = Polestar.CharState().skyJewels
local moves, tiles = saved.moves, table.concat(saved.tiles, ",")

stub.inCombat = true
stub.fire("PLAYER_REGEN_DISABLED")
assert(not A.IsOpen("skyjewels"), "Sky Jewels stayed open in ground combat")
Polestar.RunCommand("jewels")
assert(not A.IsOpen("skyjewels"), "Sky Jewels reopened in combat")

stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
Polestar.RunCommand("jewels")
assert(A.IsOpen("skyjewels"), "Sky Jewels did not reopen after combat")
local resumed = Polestar.CharState().skyJewels
assert(resumed.moves == moves and table.concat(resumed.tiles, ",") == tiles, "the fight discarded the current board")`,
	});
});

test('Sky Jewels restarts the saved level when its board is rejected', { skip }, () => {
	runAddon({
		...login,
		saved: { Polestar: 'PolestarCharDB = { skyJewels = { version = 1, level = 27, tiles = {} } }' },
		script: `
${ARCADE}
Polestar.RunCommand("jewels")
assert(Polestar.Arcade.IsOpen("skyjewels"), "Sky Jewels could not open with a rejected save")
local saved = Polestar.CharState().skyJewels
assert(saved.level == 27, "a rejected board should restart level 27")
assert(#saved.tiles == 49 and saved.moves > 0 and saved.score == 0, "the saved board was not rebuilt")`,
	});
});

test('Sky Jewels opened on a flight without the flight timer is put away on landing', { skip }, () => {
	runAddon({
		...login,
		script: `
${ARCADE}
Polestar.Set("maps.flightTimer", false)
stub.world.onTaxi = true
stub.fire("PLAYER_CONTROL_LOST")
stub.advance(0.6)
Polestar.RunCommand("jewels")
stub.advance(0.6)
assert(Polestar.Arcade.IsOpen("skyjewels"), "Sky Jewels did not stay open on a flight without an ETA")
assert(not PolestarFlightTimer:IsShown(), "opening Sky Jewels showed the flight timer")

stub.world.onTaxi = false
stub.fire("PLAYER_CONTROL_GAINED")
stub.advance(0.6)
assert(not Polestar.Arcade.IsOpen("skyjewels"), "Sky Jewels stayed open after landing")
local said = false
for _, line in ipairs(stub.messages) do
	if line:find("Landed. Sky Jewels is saved and paused: type /polestar jewels to continue.", 1, true) then said = true end
end
assert(said, "the landing did not say how to go on")`,
	});
});

test('the solver can win and replay every generated Sky Jewels level', { skip }, () => {
	const { stderr } = runAddon({
		script: 'arg = { [0] = "tools/sky-jewels.lua", "--verify" }; dofile(arg[0])',
	});
	assert.equal((stderr.match(/^Level \d+: .* solved in /gm) || []).length, 52);
});
