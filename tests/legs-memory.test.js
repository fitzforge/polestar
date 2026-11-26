'use strict';
// The baked legs' memory budget (data/local/research/NavArchitecture.md §4.1:
// layer L1, "≤ 1 MB per race part"): what a race's legs (pack format 7, forge
// build's legs stage; since 0.4.3 Legs_<race>.lua in its faction's part,
// #3507) keep resident once Polestar.RegisterLegs has taken them, and the heap
// they grow while loading, under Lua 5.1 as the client counts it
// (collectgarbage("count")), with Polestar and its guides loaded as in game,
// for a character of that race. A figure past its budget fails the test. The
// resident budget is the architecture's 1 MB a race; the peak is the figure
// measured at the release's code freeze plus 3 %, moved only then
// (docs/CI.md, "Memory budgets"). A bake that grows past it between freezes
// needs a leaner leg (forge-nav bake.rs), not a larger budget.
//
// Every race file of our pack's faction parts is measured (none until the
// maintainer compiles guides with their legs.json: the test then says so and
// passes). POLESTAR_ADDON_DIR measures another build's addons
// (tests/helpers/lua.js).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');
const { RACE_FILES, RACE_BY_FILE } = require('../tools/lib/game/races');

// KiB (Lua 5.1, 64-bit). Peak: the worst race file measured on next
// f5bd74406e (2026-11-26, #4143: Night Elf, 943; since 0.4.3 each side's part
// holds only its own races' legs, #3507), plus 3 %.
const BUDGET = { resident: 1024, peak: 972 };

// Each race's legs file in the part of each side it is played on (Skyborne's on both).
const parts = RACE_FILES.flatMap((race) => Object.keys(RACE_BY_FILE[race].sides).map((side) => ({ race, side, file: path.join(ADDONS, `Polestar_Guides_${side}`, `Legs_${race}.lua`) }))).filter((p) => fs.existsSync(p.file));

test('baked legs stay within their budget: each race\'s legs file, resident and while loading', (t) => {
	if (!parts.length) {
		t.diagnostic(`no faction part with a Legs_<race>.lua in ${ADDONS}: nothing to measure`);
		return;
	}
	for (const { race, side, file } of parts) {
		const [got] = runAddon({
			stubs: ['stub_world.lua'],
			before: `stub.world.faction, stub.world.race = ${JSON.stringify(side)}, ${JSON.stringify(race)}`,
			addons: ['Polestar', 'Polestar_Guides'],
			login: true,
			script: `
local function full() collectgarbage("collect") collectgarbage("collect") return collectgarbage("count") end
local base = full()
collectgarbage("stop")
local chunk = assert(loadfile(${JSON.stringify(file)}))
chunk("Polestar_Guides_${side}", {})
chunk = nil
local peak = collectgarbage("count") - base
collectgarbage("restart")
emit({ resident = full() - base, peak = peak })`,
		}).emitted;
		const kib = { resident: Math.round(got.resident), peak: Math.round(got.peak) };
		t.diagnostic(`${race} (${side}): ${JSON.stringify(kib)} KiB (${Math.round(fs.statSync(file).size / 1024)} KiB on disk)`);
		for (const [k, budget] of Object.entries(BUDGET)) assert.ok(kib[k] <= budget, `${race} (${side}) ${k}: ${kib[k]} KiB, budget ${budget} KiB`);
	}
});
