'use strict';
// The way a material takes (addon/Polestar/Core/Materials.lua, Materials.Way): a paired guide gathers what its
// gathering skill gathers until the player answers for the guide, whatever Options' default for new guides
// (docs/forge/professions.md, "The Materials way"); the player's own pick or Buy all still buy it, and a
// material the guide's gathering skill does not gather (cloth from mobs) keeps Options' default.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// A guide with a fish its Fishing gathers and cloth from mobs, both also bought at the Auction House.
const GUIDE = `
local function guide(id, skillLines)
	return { id = id, skillLines = skillLines, steps = {
		{ goals = { { t = "collect", item = 6308, count = 40, gather = { rank = 1, skill = "Fishing", skillLine = 356 } }, { t = "auction", item = 6308, count = 40 } } },
		{ goals = { { t = "collect", item = 4306, count = 20, gather = { min = 20, max = 40 } }, { t = "auction", item = 4306, count = 20 } } },
	} }
end
local player = { level = 30 }
stub.world.learnSkill(356, "Fishing", 120, 150)
local M = Polestar.Materials
local function ways(g)
	local fish, why = M.Way(g, 6308, player)
	local cloth, clothWhy = M.Way(g, 4306, player)
	return { fish = fish, why = why, cloth = cloth, clothWhy = clothWhy }
end
local paired = guide("test/fishing-cooking", { 356, 185 })
local single = guide("test/cooking", { 185 })
`;

function run(script) {
	return runAddon({ stubs: ['stub_world.lua'], addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }], login: true, script: `${GUIDE}\n${script}` }).emitted;
}

test('a paired guide gathers what its gathering skill gathers while Options say Buy; a single guide buys', () => {
	const [out] = run(`
Polestar.Set("professions.materials", "buy")
emit({ paired = ways(paired), single = ways(single) })`);
	assert.deepEqual(out.paired, { fish: 'gather', why: 'mix', cloth: 'buy', clothWhy: 'mode' });
	assert.deepEqual(out.single, { fish: 'buy', why: 'mode', cloth: 'buy', clothWhy: 'mode' });
});

test('in a paired guide the player\'s pick and Buy all still buy the fish; without Fishing it is bought', () => {
	const [out] = run(`
Polestar.Set("professions.materials", "ask")
local before = ways(paired)
M.SetWay(paired.id, 6308, "buy")
local picked = ways(paired)
M.SetMode(paired.id, "buy")
local all = ways(paired)
stub.world.skills[356] = nil
local other = guide("test/fishing-cooking-2", { 356, 185 })
emit({ before = before.fish, picked = picked.fish, pickedWhy = picked.why, all = all.fish, noSkill = ways(other).fish, noSkillWhy = ways(other).why })`);
	assert.deepEqual(out, { before: 'gather', picked: 'buy', pickedWhy: 'picked', all: 'buy', noSkill: 'buy', noSkillWhy: 'skill' });
});
