'use strict';
// Quest titles and item names in the client's language (Core/Names.lua and
// the Engine's views): the client's name first, the compiled English only
// while the client has none yet, then the client's once it loads.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
`;

// 783 is offered by an NPC; 5 asks for Gold Dust (773) and a Linen Cloth
// (2589) to use; 7 needs 783 first.
const GUIDE = `
Polestar.RegisterGuide({
	id = "test/names", pack = "test", title = "Names", faction = "Alliance", minLevel = 1, maxLevel = 10, zone = 1429,
	steps = {
		{ goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", pre = { 783 }, preTitles = { [783] = "A Threat Within" } },
		} },
		{ goals = {
			{ t = "collect", item = 773, itemName = "Gold Dust", count = 2, quest = 5, title = "Gold Dust Exchange", oi = 1, map = 1429, x = 40, y = 40 },
			{ t = "use", item = 2589, itemName = "Linen Cloth", quest = 5, title = "Gold Dust Exchange" },
		} },
		{ goals = { { t = "level", level = 10 } } },
	},
})
`;

const SETUP = `
LOG = {}
for _, m in ipairs({ "STEP_CHANGED", "STEP_UPDATED", "WAYPOINT_CHANGED" }) do
	Polestar.On(m, function() LOG[#LOG + 1] = m end)
end
function flush() stub.advance(0.5) end
function takeLog() local l = LOG; LOG = {}; return l end
function texts(i)
	local out = {}
	for g, gv in ipairs(E.GetStepView(i).goals) do out[g] = gv.text .. (gv.detail and (" | " .. gv.detail) or "") end
	return out
end
function label() local wp = E.GetWaypoint(); return wp and wp.label end
E = Polestar.Engine
`;

function run({ before = '', script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + before,
		addons: [CORE],
		script: `${TEST_PACK}\n${TEST_SOURCE}\n${GUIDE}\n${SETUP}\nstub.login()\n${script}`,
	}).emitted;
}

const FRENCH = `
w.titles[783] = "Une menace intérieure"; w.titles[7] = "Nettoyage du camp kobold"; w.titles[5] = "L'échange de poudre d'or"
w.itemNames[773] = "Poudre d'or"; w.itemNames[2589] = "Étoffe de lin"
`;

test('a French client: quest titles, item names and prerequisites read in its language, nothing is asked for', () => {
	const [out] = run({
		before: FRENCH,
		script: `
			local w = stub.world
			flush()
			local r = { step1 = texts(1), label = label() }
			w.gossip(197, { available = {} }); w.close(); flush()
			r.unavailable = E.GetStepView(1).goals[2].unavailableText
			w.complete({ 783, 7 }); w.accept(5, { 2 }); flush()
			r.step2 = texts(2); r.label2 = label(); r.loads = table.concat(w.loads, ",")
			emit(r)
		`,
	});
	assert.deepEqual(out.step1, ['Accept Une menace intérieure | from Deputy Willem', 'Accept Nettoyage du camp kobold | from Marshal McBride']);
	assert.equal(out.unavailable, 'Requires Une menace intérieure first');
	assert.equal(out.label, 'Accept Une menace intérieure');
	assert.deepEqual(out.step2, ["Collect Poudre d'or | for L'échange de poudre d'or", "Use Étoffe de lin | for L'échange de poudre d'or"]);
	assert.equal(out.label2, "Collect Poudre d'or");
	assert.equal(out.loads, '');
});

test('nothing cached: the English shows and each name is asked for once; the client\'s replaces it after the load event', () => {
	const [out] = run({
		script: `
			local w = stub.world
			flush()
			local r = { before = texts(1), label = label() }
			texts(1); texts(1)
			r.loads = { unpack(w.loads) }
			takeLog()
			w.titles[783] = "Une menace intérieure"; w.titles[7] = "Nettoyage du camp kobold"
			stub.fire("QUEST_DATA_LOAD_RESULT", 783, true)
			stub.fire("QUEST_DATA_LOAD_RESULT", 7, true)
			flush()
			r.after, r.labelAfter, r.log = texts(1), label(), takeLog()
			-- Done before this session (no events): an evaluation moves on.
			w.complete({ 783, 7 }); E.RequestUpdate(); flush()
			r.moved, r.items = takeLog()[1], texts(2)
			w.itemNames[773] = "Poudre d'or"; w.itemNames[2589] = "Étoffe de lin"; w.titles[5] = "L'échange de poudre d'or"
			stub.fire("ITEM_DATA_LOAD_RESULT", 773, true)
			stub.fire("ITEM_DATA_LOAD_RESULT", 2589, true)
			flush()
			r.itemsAfter, r.itemLog, r.allLoads = texts(2), takeLog(), w.loads
			emit(r)
		`,
	});
	assert.deepEqual(out.before, ['Accept A Threat Within | from Deputy Willem', 'Accept Kobold Camp Cleanup | from Marshal McBride']);
	assert.equal(out.label, 'Accept A Threat Within');
	assert.deepEqual(out.loads, ['quest:783', 'quest:7']);
	assert.deepEqual(out.after, ['Accept Une menace intérieure | from Deputy Willem', 'Accept Nettoyage du camp kobold | from Marshal McBride']);
	assert.equal(out.labelAfter, 'Accept Une menace intérieure');
	// Two arrivals, one redraw.
	assert.deepEqual(out.log, ['STEP_UPDATED', 'WAYPOINT_CHANGED']);
	assert.equal(out.moved, 'STEP_CHANGED');
	assert.deepEqual(out.items, ['Collect Gold Dust | for Gold Dust Exchange', 'Use Linen Cloth | for Gold Dust Exchange']);
	assert.deepEqual(out.itemsAfter, ["Collect Poudre d'or | for L'échange de poudre d'or", "Use Étoffe de lin | for L'échange de poudre d'or"]);
	// Quest 5 is not taken: no arrow on this step, the window redraws.
	assert.deepEqual(out.itemLog, ['STEP_UPDATED']);
	assert.deepEqual(out.allLoads, ['quest:783', 'quest:7', 'item:773', 'quest:5', 'item:2589']);
});

test('a load nobody here asked for, or one that failed, redraws nothing and is not asked again', () => {
	const [out] = run({
		script: `
			local w = stub.world
			flush(); texts(1); takeLog()
			stub.fire("QUEST_DATA_LOAD_RESULT", 9999, true)
			stub.fire("ITEM_DATA_LOAD_RESULT", 773, true)
			stub.fire("QUEST_DATA_LOAD_RESULT", 783, false)
			flush()
			local r = { log = #takeLog() }
			texts(1)
			r.loads, r.text = w.loads, texts(1)[1]
			emit(r)
		`,
	});
	assert.equal(out.log, 0);
	assert.deepEqual(out.loads, ['quest:783', 'quest:7']);
	assert.equal(out.text, 'Accept A Threat Within | from Deputy Willem');
});
