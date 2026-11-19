'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');
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

test('Sky Jewels loads only when first opened with /skyjewels', { skip }, () => {
	const toc = fs.readFileSync(path.join(ADDONS, 'Polestar_SkyJewels', 'Polestar_SkyJewels.toc'), 'utf8');
	assert.match(toc, /^## LoadOnDemand:[ \t]*1[ \t]*\r?$/m);
	runAddon({
		...login,
		script: `
assert(not C_AddOns.IsAddOnLoaded("Polestar_SkyJewels") and not Polestar.SkyJewels, "Sky Jewels was loaded at login")
assert(not PolestarSkyJewels, "Sky Jewels created a window at login")
assert(SLASH_POLESTAR_SKYJEWELS1 == "/skyjewels", "The core slash command is missing")
SlashCmdList.POLESTAR_SKYJEWELS("")
assert(C_AddOns.IsAddOnLoaded("Polestar_SkyJewels"), "The slash command did not load Sky Jewels")
assert(Polestar.SkyJewels.IsOpen(), "The slash command did not open Sky Jewels")`,
	});
});

test('Sky Jewels keeps progress when entering combat on the ground', { skip }, () => {
	runAddon({
		...login,
		script: `
stub.inCombat = true
stub.fire("PLAYER_REGEN_DISABLED")
Polestar.RunCommand("jewels")
assert(not C_AddOns.IsAddOnLoaded("Polestar_SkyJewels"), "Sky Jewels loaded in combat")

stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
Polestar.RunCommand("jewels")
assert(Polestar.SkyJewels.IsOpen(), "Sky Jewels did not open out of combat")
local saved = Polestar.CharState().skyJewels
local moves, tiles = saved.moves, table.concat(saved.tiles, ",")

stub.inCombat = true
stub.fire("PLAYER_REGEN_DISABLED")
assert(not Polestar.SkyJewels.IsOpen(), "Sky Jewels stayed open in ground combat")
Polestar.RunCommand("jewels")
assert(not Polestar.SkyJewels.IsOpen(), "Sky Jewels reopened in combat")

stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
Polestar.RunCommand("jewels")
assert(Polestar.SkyJewels.IsOpen(), "Sky Jewels did not reopen after combat")
local resumed = Polestar.CharState().skyJewels
assert(resumed.moves == moves and table.concat(resumed.tiles, ",") == tiles, "Entering combat discarded the current board")`,
	});
});

test('Sky Jewels restarts the saved level when its board is rejected', { skip }, () => {
	runAddon({
		...login,
		saved: { Polestar: 'PolestarCharDB = { skyJewels = { version = 1, level = 27, tiles = {} } }' },
		script: `
Polestar.RunCommand("jewels")
assert(Polestar.SkyJewels.IsOpen(), "Sky Jewels could not open with a rejected save")
local saved = Polestar.CharState().skyJewels
assert(saved.level == 27, "A rejected board should restart level 27")
assert(#saved.tiles == 49 and saved.moves > 0 and saved.score == 0, "The saved board was not rebuilt")`,
	});
});

test('Sky Jewels closes on landing with no ETA and the Flight Timer disabled', { skip }, () => {
	runAddon({
		...login,
		script: `
Polestar.Set("maps.flightTimer", false)
stub.world.onTaxi = true
stub.fire("PLAYER_CONTROL_LOST")
stub.advance(0.6)
Polestar.RunCommand("jewels")
stub.advance(0.6)
assert(Polestar.SkyJewels.IsOpen(), "Sky Jewels did not stay open on a flight without an ETA")
assert(not PolestarFlightTimer:IsShown(), "Opening Sky Jewels enabled the Flight Timer")

stub.world.onTaxi = false
stub.fire("PLAYER_CONTROL_GAINED")
stub.advance(0.6)
assert(not Polestar.SkyJewels.IsOpen(), "Sky Jewels stayed open after landing")`,
	});
});

test('the solver can win and replay every generated Sky Jewels level', { skip }, () => {
	const { stderr } = runAddon({
		script: 'arg = { [0] = "tools/sky-jewels.lua", "--verify" }; dofile(arg[0])',
	});
	assert.equal((stderr.match(/^Level \d+: .* solved in /gm) || []).length, 52);
});
