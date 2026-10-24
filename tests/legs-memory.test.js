'use strict';
// The baked legs' memory budget (data/local/research/NavArchitecture.md §4.1:
// layer L1, "≤ 1 MB per race part"): what a race part's Legs.lua (pack format
// 7, forge build's legs stage) keeps resident once Polestar.RegisterLegs has
// taken it, and the heap it grows while loading, under Lua 5.1 as the client
// counts it (collectgarbage("count")), with Polestar and its guides loaded as
// in game. A figure past its budget fails the test: lower a budget when the
// legs shrink, never raise one to let a change pass; a bake that outgrows it
// needs a leaner leg (forge-nav bake.rs), not a larger budget.
//
// Every race part of our pack that has a Legs.lua is measured (none until the
// maintainer compiles guides with their legs.json: the test then says so and
// passes). POLESTAR_ADDON_DIR measures another build's addons
// (tests/helpers/lua.js).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');
const { RACE_FILES, RACE_BY_FILE } = require('../tools/lib/game/races');

// KiB (Lua 5.1, 64-bit).
const BUDGET = { resident: 1024, peak: 1536 };

const parts = RACE_FILES.map((race) => ({ race, file: path.join(ADDONS, `Polestar_Guides_${race}`, 'Legs.lua') })).filter((p) => fs.existsSync(p.file));

test('baked legs stay within their budget: each race part\'s Legs.lua, resident and while loading', (t) => {
	if (!parts.length) {
		t.diagnostic(`no race part with a Legs.lua in ${ADDONS}: nothing to measure`);
		return;
	}
	for (const { race, file } of parts) {
		// A character of each side the race is played on (Skyborne's part carries both sides' legs).
		for (const side of Object.keys(RACE_BY_FILE[race].sides)) {
			const [got] = runAddon({
				stubs: ['stub_world.lua'],
				before: `stub.world.faction = ${JSON.stringify(side)}`,
				addons: ['Polestar', 'Polestar_Guides'],
				login: true,
				script: `
local function full() collectgarbage("collect") collectgarbage("collect") return collectgarbage("count") end
local base = full()
collectgarbage("stop")
local chunk = assert(loadfile(${JSON.stringify(file)}))
chunk("Polestar_Guides_${race}", {})
chunk = nil
local peak = collectgarbage("count") - base
collectgarbage("restart")
emit({ resident = full() - base, peak = peak })`,
			}).emitted;
			const kib = { resident: Math.round(got.resident), peak: Math.round(got.peak) };
			t.diagnostic(`${race} (${side}): ${JSON.stringify(kib)} KiB (${Math.round(fs.statSync(file).size / 1024)} KiB on disk)`);
			for (const [k, budget] of Object.entries(BUDGET)) assert.ok(kib[k] <= budget, `${race} (${side}) ${k}: ${kib[k]} KiB, budget ${budget} KiB`);
		}
	}
});
