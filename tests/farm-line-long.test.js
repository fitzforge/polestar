'use strict';
// The guide window's farm line (UI/UI.lua, UI.FarmLine; Core/Engine.lua, Own.farmView): a farm of an hour or
// less gives its kills, minutes and second choice; a longer one is no plan to send a player on, so it says
// where the rest comes from instead: the levels the material drops at and, when it sells there, the Auction
// House as the other way. Never "1652 kills, 661 min".
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const line = (farm) =>
	runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `stub.login()
emit({ line = Polestar.UI.FarmLine({ t = "collect", farm = ${farm} }) or false })`,
	}).emitted[0].line;

test('a short farm: kills, minutes and the second choice', () => {
	assert.equal(line('{ kills = 40, minutes = 12, second = { npcName = "Windshear Digger" } }'), 'about 40 kills, 12 min  ·  or Windshear Digger');
});

test('over an hour: the levels it drops at and the Auction House, no kills or minutes', () => {
	assert.equal(line('{ kills = 1652, minutes = 661, levels = { 15, 30 }, market = true, second = { npcName = "Windshear Digger" } }'), 'Most of it drops as you level 15–30  ·  or the Auction House');
	assert.equal(line('{ kills = 900, minutes = 300 }'), 'A long farm: most of it drops as you level');
	// A pick above the player still says so first.
	assert.equal(line('{ kills = 900, minutes = 300, above = 1, levels = { 15, 30 } }'), '1 level above you: careful  ·  Most of it drops as you level 15–30');
});
