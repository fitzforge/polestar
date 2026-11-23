'use strict';
// Tetris by beemerwt, one of the flight games in Polestar_Arcade (games/tetris; Maps/Arcade.lua opens it): loaded
// with the folder on the first /polestar tetris, as the client does, its window in Polestar's language, and put away
// with its run saved by a fight.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const login = { addons: ['Polestar'], stubs: ['stub_world.lua'], login: true };
// Polestar_Arcade in the AddOns list, loadable on demand, as the client gives it.
const ARCADE = 'stub.addons[#stub.addons + 1] = { name = "Polestar_Arcade", reason = "DEMAND_LOADED" }';

test('Tetris loads with Polestar_Arcade on the first /polestar tetris and opens its window', () => {
	const { emitted } = runAddon({
		...login,
		script: `${ARCADE}
local before = PolestarTetrisAPI == nil and not C_AddOns.IsAddOnLoaded("Polestar_Arcade")
Polestar.RunCommand("tetris")
emit({ before = before, loaded = C_AddOns.IsAddOnLoaded("Polestar_Arcade"), active = Polestar.Arcade.Active(),
  shown = PolestarTetrisAPI.IsOpen(), run = PolestarTetris.Run() ~= nil })`,
	});
	assert.deepEqual(emitted, [{ before: true, loaded: true, active: 'tetris', shown: true, run: true }]);
});

test('Tetris window uses translated labels and falls back to English', () => {
	const { emitted } = runAddon({
		...login,
		script: `${ARCADE}
Polestar.L.Next = "Suivant"
Polestar.RunCommand("tetris")
local labels = {}
for _, region in ipairs(PolestarTetrisFrame.regions) do
  if region.kind == "FontString" then labels[region:GetText()] = true end
end
emit({ translated = labels.Suivant == true, fallback = labels.Hold == true,
  englishNext = labels.Next == true })`,
	});
	assert.deepEqual(emitted, [{ translated: true, fallback: true, englishNext: false }]);
});

test('a fight on the ground saves, pauses and closes Tetris, and it opens again after', () => {
	const { emitted } = runAddon({
		...login,
		script: `${ARCADE}
Polestar.RunCommand("tetris")
local open = PolestarTetrisAPI.IsOpen()
stub.inCombat = true
stub.fire("PLAYER_REGEN_DISABLED")
local fight = { open = PolestarTetrisAPI.IsOpen(), paused = PolestarTetris.Run().paused }
local said = 0
for _, line in ipairs(stub.messages) do
  if line:find("Tetris is saved and paused for the fight: type /polestar tetris to continue.", 1, true) then said = said + 1 end
end
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
Polestar.RunCommand("tetris")
emit({ open = open, fight = fight, said = said, again = PolestarTetrisAPI.IsOpen() })`,
	});
	assert.deepEqual(emitted, [{ open: true, fight: { open: false, paused: true }, said: 1, again: true }]);
});
