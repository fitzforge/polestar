'use strict';
// Completion by ID on a non-English client (docs/ARCHITECTURE.md, "Guide
// data"; #83). A fake frFR client answers in French: the bind location, the
// zone and subzone texts, the flight map's node names and C_Map.GetAreaInfo.
// The guide keeps its English names, so only the IDs can complete its steps:
// the innkeeper's NPC ID, the area IDs (`area`) and the taxi node ID
// (`node`). The same guide on an English client completes as before. Real
// Core and Nav, with the committed TravelData.lua's inns and flight masters
// (Innkeeper Trelayne 6790 at Darkshire, area 42; node 12 "Darkshire,
// Duskwood"), on the stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const ADDON = { name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml'] };

// What each client calls the places: AreaTable areas (Duskwood 10, Elwynn
// Forest 12, Darkshire 42, Goldshire 87, Stormwind City 1519; Durotar 14, its
// Valley of Trials 363 and the Burning Blade Coven 365, a cave in it), the
// taxi nodes (12 Darkshire, 2 Stormwind) and two subzones without a goal.
const CLIENTS = {
	frFR: {
		areas: { 10: 'Bois de la Pénombre', 12: "Forêt d'Elwynn", 42: 'Sombre-Comté', 87: "Comté-de-l'Or", 1519: 'Hurlevent', 14: 'Durotar', 363: 'Vallée des Épreuves', 365: 'Antre de la Lame ardente' },
		nodes: { 12: 'Sombre-Comté, Bois de la Pénombre', 2: "Hurlevent, Forêt d'Elwynn" },
		grove: 'Bosquet de Clairbois',
		trade: 'Quartier commerçant',
	},
	enUS: {
		areas: { 10: 'Duskwood', 12: 'Elwynn Forest', 42: 'Darkshire', 87: 'Goldshire', 1519: 'Stormwind City', 14: 'Durotar', 363: 'Valley of Trials', 365: 'Burning Blade Coven' },
		nodes: { 12: 'Darkshire, Duskwood', 2: 'Stormwind, Elwynn' },
		grove: 'Brightwood Grove',
		trade: 'Trade District',
	},
};

const luaTable = (o) => `{ ${Object.entries(o).map(([k, v]) => `[${k}] = ${JSON.stringify(v)}`).join(', ')} }`;

// The client: its language, its names, a flight map that lists its nodes by
// ID (C_TaxiMap) as the Forever client does, and the player in Duskwood's
// Brightwood Grove, bound at Goldshire.
function client(locale) {
	const c = CLIENTS[locale];
	return `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
function GetLocale() return "${locale}" end
AREAS = ${luaTable(c.areas)}
NODES = ${luaTable(c.nodes)}
GROVE, TRADE = ${JSON.stringify(c.grove)}, ${JSON.stringify(c.trade)}
function C_Map.GetAreaInfo(id) return AREAS[id] end
local open -- node IDs of the open flight map, the current one first
function GetTaxiMapID() return open and 1415 or nil end
C_TaxiMap = {}
function C_TaxiMap.GetAllTaxiNodes()
	local out = {}
	for i, id in ipairs(open or {}) do out[i] = { nodeID = id, name = NODES[id], state = i == 1 and 0 or 1, slotIndex = i } end
	return out
end
-- The flight map at flight master npc, standing at node ids[1].
function openTaxi(npc, ids)
	open = ids
	local others = {}
	for i = 2, #ids do others[#others + 1] = NODES[ids[i]] end
	w.taxi(npc, NODES[ids[1]], others)
end
function closeTaxi() open = nil; w.close() end
w.zone, w.subzone = AREAS[10], GROVE
w.bindLocation = AREAS[87]
`;
}

// As compile writes it for "Darkshire" (docs/GUIDE_FORMAT.md, "Places by ID").
const DARKSHIRE = `
Polestar.RegisterGuide({ id = "test/darkshire", pack = "test", title = "Darkshire", faction = "Alliance", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "sethome", npc = 6790, npcName = "Innkeeper Trelayne", location = "Darkshire", area = 42 } } },
	{ goals = { { t = "getfp", npc = 2409, npcName = "Felicia Maline", location = "Darkshire", node = 12, area = 42 } } },
	{ goals = { { t = "fly", location = "Stormwind City", area = 1519 } } },
	{ goals = { { t = "hearth", location = "Darkshire", area = 42 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;

function run(locale, { guide = DARKSHIRE, id = 'test/darkshire', before = '', flags = '', script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: client(locale) + before,
		addons: [ADDON],
		saved: { Polestar: `PolestarCharDB = { schema = 1, guide = "${id}", flags = { ${flags} } }` },
		script: `${TEST_PACK}\n${TEST_SOURCE}\n${guide}
E = Polestar.Engine
function flush() stub.advance(0.25) end
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
${script}`,
	}).emitted;
}

// Bind at Innkeeper Trelayne, learn Darkshire's flight path, fly to
// Stormwind, hearth back: the step after each.
const WALK = `
	local w = stub.world
	local texts = {}
	for i = 1, 4 do texts[i] = E.GetStepView(i).goals[1].text end
	local trail = { E.GetStepIndex() }
	w.gossip(6790); w.bind(AREAS[42]); w.close(); flush(); trail[#trail + 1] = E.GetStepIndex()
	openTaxi(2409, { 12, 2 }); closeTaxi(); flush(); trail[#trail + 1] = E.GetStepIndex()
	w.setZone(AREAS[1519], TRADE); flush(); trail[#trail + 1] = E.GetStepIndex()
	w.setZone(AREAS[10], AREAS[42]); flush(); trail[#trail + 1] = E.GetStepIndex()
	local f = PolestarCharDB.flags
	emit({ texts = texts, trail = trail, inn = f.inn, node12 = f.taxi and f.taxi[12] or false })
`;

test('#83: on a French client sethome, getfp, fly and hearth complete by ID and the goals read in French', () => {
	const [out] = run('frFR', { script: WALK });
	assert.deepEqual(out.trail, [1, 2, 3, 4, 5]);
	// The places as the French client names them; the verbs are the shipped
	// French interface's, not this test's business.
	const places = ['Sombre-Comté', 'Sombre-Comté', 'Hurlevent', 'Sombre-Comté'];
	out.texts.forEach((text, i) => assert.ok(text.endsWith(places[i]), `${text} names ${places[i]}`));
	assert.deepEqual(out.inn, { 'sombre-comté': 6790 }, 'Travel learns the innkeeper of the French bind location');
	assert.equal(out.node12, true, 'the flight map listed Darkshire by its node ID');
});

test('the same guide on an English client completes as before, with or without C_Map.GetAreaInfo', () => {
	for (const before of ['', 'C_Map.GetAreaInfo = nil']) {
		const [out] = run('enUS', { before, script: WALK });
		assert.deepEqual(out.trail, [1, 2, 3, 4, 5], before || 'with GetAreaInfo');
		assert.deepEqual(out.texts, ['Set your home to Darkshire', 'Get the flight path at Darkshire', 'Fly to Stormwind City', 'Hearth to Darkshire']);
		assert.deepEqual(out.inn, { darkshire: 6790 });
	}
});

test('#83: bound at Darkshire before the step, a French client passes the sethome, whether or not Polestar saw the bind', () => {
	const script = `
		local inn = Polestar.Nav.BoundInn()
		emit({ step = E.GetStepIndex(), bound = inn and inn.npc or false })`;
	// Polestar saw the bind: Travel learned the innkeeper then (flags.inn).
	const [learned] = run('frFR', { before: 'w.bindLocation = AREAS[42]', flags: 'inn = { ["sombre-comté"] = 6790 }', script });
	assert.deepEqual(learned, { step: 2, bound: 6790 });
	// Bound before Polestar was installed: the inn whose area the client names so.
	const [unseen] = run('frFR', { before: 'w.bindLocation = AREAS[42]', script });
	assert.deepEqual(unseen, { step: 2, bound: 6790 });
	// A bind Travel paired with the wrong innkeeper (bound away from it, as a
	// simulated bind is): the bind location still reads as Darkshire's area.
	const [mislearned] = run('frFR', { before: 'w.bindLocation = AREAS[42]', flags: 'inn = { ["sombre-comté"] = 295 }', script });
	assert.deepEqual(mislearned, { step: 2, bound: 295 });
});

test('bound at another inn, or at a flight master where Darkshire is not yet known, the French client keeps the step', () => {
	const [out] = run('frFR', {
		flags: 'inn = { ["comté-de-l\'or"] = 295 }',
		script: `
			local w = stub.world
			local r = { start = E.GetStepIndex() }
			-- Binding at Innkeeper Farley (Goldshire) is not Darkshire's inn.
			w.gossip(295); w.bind(AREAS[87]); w.close(); flush()
			r.otherInn = E.GetStepIndex()
			w.gossip(6790); w.bind(AREAS[42]); w.close(); flush()
			r.bound = E.GetStepIndex()
			-- Stormwind's flight map, Darkshire not on it: its path is not known.
			openTaxi(352, { 2 }); closeTaxi(); flush()
			r.otherFp = E.GetStepIndex()
			emit(r)`,
	});
	assert.deepEqual(out, { start: 1, otherInn: 1, bound: 2, otherFp: 2 });
});

test('a goal the compiler left without an ID keeps matching by its English name: sethome by its inn, hearth and getfp by name', () => {
	const GUIDE = `
Polestar.RegisterGuide({ id = "test/names", pack = "test", title = "Names", faction = "Alliance", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "sethome", location = "Darkshire" } } },
	{ goals = { { t = "hearth", location = "Darkshire" } } },
	{ goals = { { t = "getfp", location = "Darkshire" } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;
	const script = `
		local w = stub.world
		local trail = { E.GetStepIndex() }
		w.bind(AREAS[42]); flush(); trail[#trail + 1] = E.GetStepIndex()
		w.setZone(AREAS[10], AREAS[42]); flush(); trail[#trail + 1] = E.GetStepIndex()
		openTaxi(2409, { 12 }); closeTaxi(); flush(); trail[#trail + 1] = E.GetStepIndex()
		emit({ trail = trail, text = E.GetStepView(2).goals[1].text })`;
	// The inn the location names is Darkshire's, whose area the French client
	// names "Sombre-Comté"; a hearth or flight path without an ID has only its
	// English name, which the French client never says.
	const [fr] = run('frFR', { guide: GUIDE, id: 'test/names', script });
	assert.deepEqual(fr.trail, [1, 2, 2, 2]);
	assert.match(fr.text, /Darkshire$/, 'a goal without an area keeps its English place name');
	const [en] = run('enUS', { guide: GUIDE, id: 'test/names', script });
	assert.deepEqual(en, { trail: [1, 2, 3, 4], text: 'Hearth to Darkshire' });
});

// A goto labelled with a cave's subzone (compile gives it the area, #105) at
// the cave's mouth, then one labelled with its zone; Durotar's frame as the
// client places it (data/forever/map-frames.json).
const COVEN = `
Polestar.RegisterGuide({ id = "test/coven", pack = "test", title = "Coven", faction = "Alliance", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "goto", text = "{area:365}", area = 365, map = 1411, x = 45, y = 56 } } },
	{ goals = { { t = "goto", text = "{zone:1411}", area = 14, map = 1411, x = 52, y = 44 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;
const DUROTAR = `
w.addMap(1411, { name = "Durotar", c = 1, left = -1962.5, right = -7250, top = 1808.333, bottom = -1716.667 })
w.moveTo(1411, 44, 62)
w.zone, w.subzone = AREAS[14], AREAS[363]
-- The player at x, y in Durotar's subzone sub, indoors or not; the step after
-- the next arrival poll.
function at(x, y, sub, indoors)
	w.moveTo(1411, x, y)
	w.indoors = indoors
	stub.world.setZone(AREAS[14], sub)
	stub.advance(0.6)
	return E.GetStepIndex()
end
`;

test('#177: walking into the cave a goto names arrives there, by area ID on a French client too; a goto naming the zone does not', () => {
	for (const locale of ['frFR', 'enUS']) {
		const [out] = run(locale, {
			guide: COVEN,
			id: 'test/coven',
			before: DUROTAR,
			script: `emit({
				E.GetStepIndex(),
				at(45.13, 55.75, AREAS[363], false), -- 11 yd from the mouth's point, outside
				at(45.13, 55.75, AREAS[365], true),  -- the same 11 yd, inside the Burning Blade Coven
				at(30, 30, AREAS[363], false),
				at(30, 30, AREAS[14], true),         -- a subzone text naming the zone itself
			})`,
		});
		assert.deepEqual(out, [1, 1, 2, 2, 2], locale);
	}
});

test('#177: the cave arrives only on going in: not in its subzone outdoors, not when inside as the goto comes up, not for a second goto into it', () => {
	// Its subzone outdoors, around or above the cave (Fargodeep Mine's hill).
	const [outdoors] = run('frFR', {
		guide: COVEN,
		id: 'test/coven',
		before: DUROTAR,
		script: 'emit({ at(45.5, 57, AREAS[365], false), at(45.5, 57, AREAS[365], true) })',
	});
	assert.deepEqual(outdoors, [1, 2]);
	// Inside the cave when the step comes up: the goto's point still leads.
	const [inside] = run('frFR', {
		guide: COVEN,
		id: 'test/coven',
		before: `${DUROTAR}\nw.moveTo(1411, 44.5, 55); w.subzone, w.indoors = AREAS[365], true`,
		script: 'emit({ at(44.5, 55, AREAS[365], true), at(44, 62, AREAS[363], false), at(44.5, 55, AREAS[365], true) })',
	});
	assert.deepEqual(inside, [1, 1, 2]);
	// A second goto of the step into the same cave is a waypoint further in.
	const TWO = COVEN.replace('x = 45, y = 56 } } }', 'x = 45, y = 56 }, { t = "goto", text = "{area:365}", area = 365, map = 1411, x = 43, y = 53 } } }');
	const [two] = run('frFR', {
		guide: TWO,
		id: 'test/coven',
		before: DUROTAR,
		script: 'emit({ at(45.13, 55.75, AREAS[365], true), at(43.05, 53.05, AREAS[365], true) })',
	});
	assert.deepEqual(two, [1, 2]);
});

test('#177: back at the goto after stepping past it, the player inside the cave still walks to its point: being outside earlier does not count', () => {
	const [out] = run('frFR', {
		guide: COVEN,
		id: 'test/coven',
		before: DUROTAR,
		script: `
			local r = { at(44, 62, AREAS[363], false) } -- outside, the goto open
			E.Next(); flush(); r[#r + 1] = E.GetStepIndex()
			r[#r + 1] = at(45.13, 55.75, AREAS[365], true) -- into the cave on the next step
			E.Prev(); flush(); r[#r + 1] = E.GetStepIndex()
			r[#r + 1] = at(45.13, 55.75, AREAS[365], true) -- still inside: the goto stays
			r[#r + 1] = at(44, 62, AREAS[363], false)
			r[#r + 1] = at(45.13, 55.75, AREAS[365], true) -- out and back in
			emit(r)`,
	});
	assert.deepEqual(out, [1, 2, 2, 1, 1, 1, 2]);
});
