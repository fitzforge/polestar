'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack } = require('./helpers/codex');
const { buildJournal, emitJournal } = require('../tools/lib/codex/journal');
const fixture = require('./fixtures/codex/dungeons.json');

const ITEM = 90042;
const QUEST = 90044;
const NEXT = 90045;
const UNLOCK = 90046;
const NPC = 90040;

function card({ located = false, followup = false, state = 'blocked', legacy = false, fallback = false, obtainable = false } = {}) {
	const { codex, inputs } = structuredClone(fixture);
	codex.npcs[NPC] = { id: NPC, name: 'Conditional Source', level: 20, levelMax: 21, faction: null,
		rare: false, elite: true, boss: false, instance: null, roles: [], spawns: [{ map: 1413, x: 45, y: 37, f: 'e' }] };
	codex.items[ITEM] = { id: ITEM, name: 'Conditional Note', quality: 1, kind: 'item', spell: null, reqLevel: null,
		sources: [{ type: 'drop', npc: NPC, chance: 33, requiresQuests: [UNLOCK] }] };
	codex.quests[QUEST] = { id: QUEST, title: 'Read the Note', level: 15, minLevel: 10, faction: null, races: null, classes: null,
		start: { npc: [], object: [], item: [ITEM] }, end: { npc: [5767], object: [] },
		objectives: [], pre: [], zone: 1413, rewards: [], choices: [], preAny: [] };
	codex.quests[NEXT] = { ...codex.quests[QUEST], id: NEXT, title: 'After the Note',
		start: { npc: [5767], object: [], item: [] }, pre: fallback ? [] : [QUEST] };
	if (obtainable) codex.quests[UNLOCK] = { ...codex.quests[NEXT], id: UNLOCK, title: 'Enable the Note', pre: [],
		start: { npc: [3448], object: [], item: [] } };
	inputs.forever.quests[QUEST] = { area: 718 };
	inputs.forever.quests[NEXT] = { area: 718 };
	if (located) inputs.forever.dungeons.dungeons.find((d) => d.key === 'wailing-caverns').quests.push({
		id: QUEST, title: 'Read the Note', level: 15, minLevel: 10,
		start: { kind: 'item', id: ITEM, name: 'Conditional Note', map: 1413, x: 44, y: 36, f: 'e' },
		startItem: { item: ITEM, name: 'Conditional Note' }, chain: [], rewards: {},
	});
	const journal = buildJournal(inputs, codex);
	const page = journal.dungeons['wailing-caverns'];
	const target = followup || fallback ? NEXT : QUEST;
	// Keep the tested card visible and retain its prerequisite in the journal.
	page.chain[QUEST] = page.quests.find((q) => q.id === QUEST);
	page.quests = [page.quests.find((q) => q.id === target)];
	assert.ok(page.quests[0]);
	if (legacy) delete codex.quests[NEXT]; // A page-supplied quest without a Codex record.
	const pack = writeCodexPack(codex, { extraFiles: emitJournal(journal) });
	try {
		return runAddon({
			stubs: ['stub_ui.lua'], before: pack.stubLua,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Gear/Gear.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml', 'UI/UI.xml'] }],
			script: `
uistub.install()
stub.login()
uistub.player.level, uistub.player.race, uistub.player.class, uistub.player.faction = 20, 'Tauren', 'DRUID', 'Horde'
Polestar.Compat.IsQuestCompleted = function(id) return ${state === 'completed' ? `id == ${UNLOCK}` : 'false'} end
Polestar.Compat.IsOnQuest = function(id) return ${state === 'held' ? `id == ${UNLOCK}` : 'false'} end
Polestar.Compat.IsQuestReadyForTurnIn = function() return false end
assert(Polestar.Codex.Load())
local pins = {}
Polestar.Nav.SetTarget = function(map, x, y, label) pins[#pins + 1] = { map, x, y, label }; return true end
local D = Polestar.Dungeons
${fallback ? 'D.GiverTarget = nil' : ''}
D.Open('wailing-caverns')
local b
for _, v in ipairs(Polestar.UI.DungeonsSection.blocks) do
  if v:IsShown() and v.psQuest == ${target} then b = v; break end
end
assert(b, 'quest card missing')
b.StartPin:Click()
b.StartLink:Click()
emit({ enabled = b.StartPin:IsEnabled(), linkEnabled = b.StartLink:IsEnabled(),
  point = b.StartPin.psPoint or false, pins = pins, pinCount = #pins })
`,
		}).emitted[0];
	} finally { pack.cleanup(); }
}

for (const followup of [false, true]) for (const located of [false, true]) {
	const shape = `${followup ? 'follow-up' : 'item'} card, ${located ? 'located' : 'unlocated'} item start`;
	test(`blocked drop cannot enable navigation from the ${shape}`, () => {
		const r = card({ located, followup });
		assert.equal(r.enabled, false);
		assert.equal(r.linkEnabled, false);
		assert.equal(r.pinCount, 0);
	});
	for (const state of ['held', 'completed']) test(`${shape} guides to the source when its requirement is ${state}`, () => {
		const r = card({ located, followup, state });
		assert.equal(r.enabled, true);
		assert.equal(r.linkEnabled, true);
		const pageStart = followup && located;
		assert.equal(r.point.id, pageStart ? ITEM : NPC);
		const pin = pageStart ? [1413, 44, 36, 'Conditional Note'] : [1413, 45, 37, 'Conditional Source'];
		assert.deepEqual(r.pins, [pin, pin]);
	});
}

for (const located of [false, true]) test(`page-only follow-up respects a blocked drop with a ${located ? 'located' : 'unlocated'} item start`, () => {
	const r = card({ located, followup: true, legacy: true });
	assert.equal(r.enabled, false);
	assert.equal(r.linkEnabled, false);
	assert.equal(r.pinCount, 0);
});

for (const legacy of [false, true]) test(`${legacy ? 'page-only' : 'Codex'} follow-up obtains the drop requirement before using the located item start`, () => {
	const r = card({ located: true, followup: true, legacy, obtainable: true });
	assert.equal(r.enabled, true);
	assert.equal(r.linkEnabled, true);
	assert.equal(r.point.id, 3448);
	assert.equal(r.pins.length, 2);
	assert.equal(r.pins[0][3], 'Tonga Runetotem');
});

test('ordinary giver fallback still works when the target helper is unavailable', () => {
	const r = card({ fallback: true });
	assert.equal(r.enabled, true);
	assert.equal(r.linkEnabled, true);
	assert.equal(r.point.id, 5767);
	assert.equal(r.pins.length, 2);
});
