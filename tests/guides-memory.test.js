'use strict';
// What the compiled guide pack costs in memory: addon/Polestar_Guides/Guides.lua
// loaded under the test interpreter with a host that only keeps what
// RegisterGuide hands over, weighed with collectgarbage("count") after a full
// collect. The pack is in the repository, so this needs no reference data and
// no game.
//
// The budget guards the resident cost against a structural regression (a goal
// key added to every goal, a table kept per step where one per guide would do).
// It is not a figure to compare across machines: Lua 5.1 and LuaJIT account for
// tables differently (the same pack weighs about 23.5 MiB under Lua 5.1 and
// about 16.4 MiB under LuaJIT), so the budget leaves room for the larger of the
// two plus the guides still to come. Issue #60.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const { findLua } = require('../tools/lib/lua');
const { ROOT } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');

const PACK = path.join(ROOT, 'addon', 'Polestar_Guides', 'Guides.lua');
const skip = !fs.existsSync(PACK) && 'addon/Polestar_Guides/Guides.lua not compiled (node tools/polestar.js compile)';

// Resident KiB of the pack, and its guides, steps and goals, per faction.
// `drop`: a faction whose guides are released before the second weighing, for
// the share a character of the other side would carry.
function weigh(drop) {
	const prog = `
local kept = {}
Polestar = { RegisterGuide = function(def) kept[def.id] = def end }

collectgarbage("collect"); collectgarbage("collect")
local base = collectgarbage("count")
assert(loadfile(${JSON.stringify(PACK)}))("Polestar_Guides", {})
collectgarbage("collect"); collectgarbage("collect")
local all = collectgarbage("count") - base

local function tally()
	local guides, steps, goals = 0, 0, 0
	for _, def in pairs(kept) do
		guides = guides + 1
		for _, step in ipairs(def.steps or {}) do
			steps = steps + 1
			goals = goals + #(step.goals or {})
		end
	end
	return guides, steps, goals
end
local guides, steps, goals = tally()

-- Guides per faction, the factionless ones counted on their own.
local sides = {}
for _, def in pairs(kept) do
	local side = def.faction or "none"
	sides[side] = (sides[side] or 0) + 1
end

for id, def in pairs(kept) do
	if (def.faction or "none") == ${JSON.stringify(drop)} then kept[id] = nil end
end
collectgarbage("collect"); collectgarbage("collect")
local ownSide = collectgarbage("count") - base
local keptGuides = tally()

print(string.format("%d %d %d %d %d %d %.1f %.1f %d",
	guides, steps, goals, sides.none or 0, sides.Alliance or 0, sides.Horde or 0, all, ownSide, keptGuides))
`;
	const file = path.join(tmpdir(), 'weigh.lua');
	fs.writeFileSync(file, prog);
	const r = spawnSync(findLua(), [file], { encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	const [guides, steps, goals, none, alliance, horde, all, ownSide, keptGuides] = r.stdout.trim().split(' ').map(Number);
	return { guides, steps, goals, none, alliance, horde, all, ownSide, keptGuides };
}

// Headroom over Lua 5.1's reading of the pack as it stands, for the guides
// still to come. Lower it when a change brings the resident cost down.
const BUDGET_KIB = 28 * 1024;

test('the compiled guide pack loads within its memory budget', { skip }, () => {
	const m = weigh('Horde');
	assert.ok(m.guides > 200, `only ${m.guides} guides registered`);
	assert.ok(m.goals > 10000, `only ${m.goals} goals`);
	assert.ok(m.all <= BUDGET_KIB, `resident ${(m.all / 1024).toFixed(1)} MiB over the ${BUDGET_KIB / 1024} MiB budget`);
	console.log(`guides pack: ${m.guides} guides, ${m.steps} steps, ${m.goals} goals, resident ${(m.all / 1024).toFixed(1)} MiB under ${path.basename(findLua())}`);
});

// Issue #60: a character carries its own faction's guides and the factionless
// ones; the other side's are dead weight until the player browses them. This
// measures what that share is worth, so a change that builds one side only can
// be held to it.
test('the pack splits by faction, so one side plus the factionless guides is the smaller part', { skip }, () => {
	const horde = weigh('Horde');
	const alliance = weigh('Alliance');
	assert.ok(horde.none > 0 && horde.alliance > 0 && horde.horde > 0, 'every side should have guides');
	assert.equal(horde.none + horde.alliance + horde.horde, horde.guides);
	for (const [side, m] of [['Alliance', horde], ['Horde', alliance]]) {
		assert.ok(m.ownSide < m.all, `${side}: dropping the other side freed nothing`);
		// Two thirds is loose on purpose: it is the composition of the pack that
		// is being pinned, not a machine's byte count.
		assert.ok(m.ownSide <= m.all * 0.7, `${side}: own side is ${(m.ownSide / m.all * 100).toFixed(0)} % of the pack, over 70 %`);
		console.log(`guides pack, ${side} character: ${m.keptGuides} of ${m.guides} guides, resident ${(m.ownSide / 1024).toFixed(1)} of ${(m.all / 1024).toFixed(1)} MiB`);
	}
	console.log(`guides pack by faction: ${horde.none} factionless, ${horde.alliance} Alliance, ${horde.horde} Horde`);
});
