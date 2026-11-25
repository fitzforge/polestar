'use strict';
// #3837 (fekz, 0.4.2.2): Lookup's guide for The Videre Elixir (3909) ended at Gregan Brewspewer with "Collect
// Videre Elixir" and nothing about the Evoroot: the elixir is Gregan's reward for his own quest, also called The
// Videre Elixir (4041). An item objective that only another quest's reward gives (no drop with a known chance, no
// object, vendor or craft) gets that quest's steps first (addon/Polestar/Lookup/Guide.lua, rewardQuestFor).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack } = require('./helpers/codex');
const { luaValue } = require('../tools/lib/playtest');

const TARGET = 9920; // the quest looked up: bring the elixir
const REWARD = 9921; // the giver's own quest, whose reward is the elixir
const ELIXIR = 9922;
const ROOT = 9923; // what the giver's quest asks for

function fixture() {
	const codex = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures/codex/lookup.json'), 'utf8'));
	const quest = (id, title, objectives) => ({
		id, title, level: 18, minLevel: 10, faction: 'A', races: null, classes: null,
		start: { npc: [5008], object: [], item: [] }, end: { npc: [5009], object: [] },
		pre: [], preAny: [], objectives, zone: 9001, rewards: [], choices: [],
	});
	codex.quests[TARGET] = quest(TARGET, 'Bring the Elixir', [{ type: 'item', id: ELIXIR, count: 1, text: 'Elixir' }]);
	codex.quests[REWARD] = quest(REWARD, 'Brew the Elixir', [{ type: 'item', id: ROOT, count: 1, text: 'Root' }]);
	codex.quests[REWARD].rewards = [ELIXIR];
	codex.items[ELIXIR] = { id: ELIXIR, name: 'Elixir', quality: 1, kind: 'item', sources: [
		{ type: 'quest', quest: REWARD, from: ['curated'] },
		{ type: 'drop', npc: 5009, from: ['curated'] }, // a drop record with no chance: the hand-over, not a farm
	] };
	codex.items[ROOT] = { id: ROOT, name: 'Root', quality: 1, kind: 'item', sources: [
		{ type: 'drop', npc: 5005, chance: 40, from: ['curated'] },
	] };
	return codex;
}

function run(codex, setup = '') {
	const pack = writeCodexPack(codex);
	const maps = Object.entries(codex.frames).map(([id, frame]) => `w.addMap(${id}, ${luaValue({ name: codex.zones[id].name, ...frame })})`).join('\n');
	try {
		return runAddon({
			stubs: ['stub_world.lua'],
			before: `${pack.stubLua}\nlocal w = stub.world\n${maps}\nw.level = 20\nw.race, w.raceName, w.faction = "Human", "Human", "Alliance"\nw.class, w.className = "WARRIOR", "Warrior"\nw.moveTo(9001, 50, 50)\n${setup}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml'] }],
			login: true,
			script: `assert(Polestar.Codex.Load())
local def, reason = Polestar.Lookup.BuildGuide("quest", ${TARGET})
local out = {}
for i, s in ipairs(def and def.steps or {}) do
	for _, g in ipairs(s.goals or {}) do out[#out + 1] = { t = g.t, quest = g.quest or false, item = g.item or false, step = i } end
end
emit({ built = def ~= nil, reason = reason or false, goals = out })`,
		}).emitted;
	} finally {
		pack.cleanup();
	}
}

const index = (goals, t, key, id) => goals.findIndex((g) => g.t === t && g[key] === id);

test('#3837: a quest whose item is another quest\'s reward does that quest first', () => {
	const [r] = run(fixture());
	assert.equal(r.built, true, JSON.stringify(r));
	const g = r.goals;
	const root = index(g, 'collect', 'item', ROOT);
	const handIn = index(g, 'turnin', 'quest', REWARD);
	assert.ok(index(g, 'accept', 'quest', REWARD) >= 0 && root >= 0 && handIn > root, `the giver's quest, its root, its hand-in: ${JSON.stringify(g)}`);
	assert.ok(handIn < index(g, 'collect', 'item', ELIXIR), 'before the elixir is asked for');
});

test('#3837: with the item in the bags, no detour through the giver\'s quest', () => {
	const [r] = run(fixture(), `w.addItem(${ELIXIR}, 1)`);
	assert.equal(r.built, true, JSON.stringify(r));
	assert.deepEqual(r.goals.filter((x) => x.quest === REWARD), []);
});

test('#3837: an item a mob drops at a known chance keeps its farm, no reward quest', () => {
	const codex = fixture();
	codex.items[ELIXIR].sources.push({ type: 'drop', npc: 5005, chance: 20, from: ['curated'] });
	const [r] = run(codex);
	assert.equal(r.built, true, JSON.stringify(r));
	assert.deepEqual(r.goals.filter((x) => x.quest === REWARD), []);
});
