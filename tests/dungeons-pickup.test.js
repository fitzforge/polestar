'use strict';
// Dungeon pick-up breadcrumb filtering (addon/Polestar/Dungeons/Pickup.lua, dropDetours):
// #2795 (Ashwarden, 38labadmin): a cross-continent breadcrumb without a prerequisite of its
// own is judged from where the player stands, never from other stops on the route.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

// Synthetic Scarlet Monastery Alliance pick-up world:
//   Maps:
//     1443 Desolace (Kalimdor, c=1) — Nijel's Point: Brother Anton (1182)
//     1453 Stormwind (Eastern Kingdoms, c=0) — Brother Crowley (12336)
//     1455 Ironforge (Eastern Kingdoms, c=0) — Raleigh the Devout (5492), optional EK stop
//     1420 Tirisfal Glades (Eastern Kingdoms, c=0) — Scarlet Monastery entrance
//     1424 Hillsbrad Foothills (Eastern Kingdoms, c=0) — same-continent detour test
//   Quests:
//     6141 Brother Anton: breadcrumb from Brother Crowley (SW) -> Brother Anton (Nijel's Point)
//     261  Down the Scarlet Path: dungeon quest from Brother Anton (Nijel's Point)
//     1050 Mythology of the Titans: EK dungeon quest from Raleigh (Ironforge) so EK is on the route
function runPickup(opts) {
	const { map, x, y, extraQuests = '', extraPageQuests = '' } = opts;
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		login: true,
		script: `
local w = stub.world
w.level, w.race, w.raceName, w.faction = 35, "Human", "Human", "Alliance"
w.class, w.className = "PALADIN", "PALADIN"
w.moveTo(${map}, ${x}, ${y})

local CONT = { [1443] = 1, [1453] = 0, [1455] = 0, [1420] = 0, [1424] = 0 }
Polestar.Compat.MapToWorld = function(m, px, py)
	if not CONT[m] then return nil end
	return CONT[m], (px or 0) * 10, (py or 0) * 10
end

local Z = { [1443] = "des", [1453] = "sw", [1455] = "if", [1420] = "tg", [1424] = "hb" }
local COST = {
	["sw-if"] = 240,
	["sw-tg"] = 600,
	["if-tg"] = 480,
	["sw-des"] = 900,
	["if-des"] = 960,
	["tg-des"] = 1200,
	["sw-hb"] = 500,
	["if-hb"] = 420,
	["tg-hb"] = 350,
	["hb-des"] = 1100,
}
Polestar.TravelCost = function(a, b)
	local za, zb = Z[a.map], Z[b.map]
	if not (za and zb) then return nil end
	if za == zb then return 10 + math.abs(a.x - b.x) + math.abs(a.y - b.y) end
	return COST[za .. "-" .. zb] or COST[zb .. "-" .. za]
end

local NPCS = {
	[1182] = { id = 1182, name = "Brother Anton", faction = "A", spawns = { { map = 1443, x = 66.5, y = 7.9 } } },
	[12336] = { id = 12336, name = "Brother Crowley", faction = "A", spawns = { { map = 1453, x = 42.6, y = 24.1 } } },
	[5492] = { id = 5492, name = "Raleigh the Devout", faction = "A", spawns = { { map = 1455, x = 74.6, y = 11.7 } } },
	[99001] = { id = 99001, name = "Hillsbrad Courier", faction = "A", spawns = { { map = 1424, x = 50.0, y = 50.0 } } },
	[99002] = { id = 99002, name = "Southshore Captain", faction = "A", spawns = { { map = 1424, x = 51.0, y = 50.0 } } },
}

local QUESTS = {
	[6141] = {
		id = 6141, title = "Brother Anton", level = 34, minLevel = 30, faction = "A",
		start = { npc = { 12336 }, object = {}, item = {} },
		["end"] = { npc = { 1182 }, object = {} },
		objectives = {}, pre = {}, preAny = {},
	},
	[261] = {
		id = 261, title = "Down the Scarlet Path", level = 34, minLevel = 30, faction = "A",
		start = { npc = { 1182 }, object = {}, item = {} },
		["end"] = { npc = { 1182 }, object = {} },
		objectives = { { type = "kill", id = 4280, count = 30, text = "Scarlet Undead" } },
		pre = {}, preAny = {},
	},
	[1050] = {
		id = 1050, title = "Mythology of the Titans", level = 35, minLevel = 30, faction = "A",
		start = { npc = { 5492 }, object = {}, item = {} },
		["end"] = { npc = { 5492 }, object = {} },
		objectives = { { type = "kill", id = 4281, count = 1, text = "Mythology" } },
		pre = {}, preAny = {},
	},
}
${extraQuests}

local PAGE = {
	key = "scarlet-monastery",
	name = "Scarlet Monastery",
	map = 189,
	minLevel = 30,
	maxLevel = 42,
	entrance = { map = 1420, x = 85.3, y = 32.2 },
	quests = {
		{ id = 6141, title = "Brother Anton", faction = "Alliance", level = 34, minLevel = 30, chain = {} },
		{ id = 261, title = "Down the Scarlet Path", faction = "Alliance", level = 34, minLevel = 30, chain = {} },
		{ id = 1050, title = "Mythology of the Titans", faction = "Alliance", level = 35, minLevel = 30, chain = {} },
		${extraPageQuests}
	},
}

local C = Polestar.Codex
C.Ready = function() return true end
C.Quest = function(id) return QUESTS[id] end
C.Npc = function(id) return NPCS[id] end
C.Object = function() return nil end
C.Item = function() return nil end

local BY_ID = {}
for _, q in ipairs(PAGE.quests) do BY_ID[q.id] = q end
local D = Polestar.Dungeons
D.Get = function(key) return key == PAGE.key and PAGE or nil end
D.Quests = function(key) return key == PAGE.key and PAGE.quests or {} end
D.Quest = function(key, id) return key == PAGE.key and BY_ID[id] or nil end

local plan = D.PickupPlan(PAGE.key)
local take, crumbs, accepts = {}, {}, {}
for _, t in ipairs(plan.take) do take[#take + 1] = t.quest.id end
table.sort(take)
for _, b in ipairs(plan.breadcrumbs or {}) do
	crumbs[tostring(b.id)] = {
		far = b.far,
		sea = b.sea,
		taken = b.taken,
		detour = b.detour and math.floor(b.detour + 0.5) or false,
	}
end
local guide = D.PickupGuide(PAGE.key)
for _, s in ipairs(guide and guide.steps or {}) do
	for _, g in ipairs(s.goals) do
		if g.t == "accept" then accepts[#accepts + 1] = g.quest end
	end
end
table.sort(accepts)
emit({ take = take, crumbs = crumbs, accepts = accepts })
`,
	}).emitted;
	return out;
}

test("#2795: at Nijel's Point (Kalimdor), cross-sea Brother Anton (6141) is dropped despite EK stops", () => {
	const out = runPickup({ map: 1443, x: 66, y: 8 });
	assert.equal(out.crumbs['6141'].sea, true);
	assert.equal(out.crumbs['6141'].far, true);
	assert.equal(out.crumbs['6141'].taken, false);
	assert.ok(out.take.includes(261), 'Down the Scarlet Path is taken directly');
	assert.ok(out.accepts.includes(261), 'Down the Scarlet Path is accepted');
	assert.ok(!out.accepts.includes(6141), 'Brother Anton is not accepted');
});

test('#2795: in Stormwind beside Brother Crowley, cross-sea Brother Anton (6141) is kept', () => {
	const out = runPickup({ map: 1453, x: 43, y: 24 });
	assert.equal(out.crumbs['6141'].sea, true);
	assert.equal(out.crumbs['6141'].far, false);
	assert.ok(out.crumbs['6141'].detour <= 150, `expected detour <= 150, got ${out.crumbs['6141'].detour}`);
	assert.equal(out.crumbs['6141'].taken, true);
	assert.ok(out.accepts.includes(6141), 'Brother Anton is accepted on the way to 261');
	assert.ok(out.accepts.includes(261), 'Down the Scarlet Path is accepted');
});

test('#2795: in Ironforge, cross-sea Brother Anton (6141) is dropped (same continent, detour > 150)', () => {
	const out = runPickup({ map: 1455, x: 75, y: 12 });
	assert.equal(out.crumbs['6141'].sea, true);
	assert.equal(out.crumbs['6141'].far, false);
	assert.ok(out.crumbs['6141'].detour > 150, `expected detour > 150, got ${out.crumbs['6141'].detour}`);
	assert.equal(out.crumbs['6141'].taken, false);
	assert.ok(!out.accepts.includes(6141), 'Brother Anton is not accepted from Ironforge');
});

test('same-continent breadcrumb (sea=false) riding along with another route stop is still kept', () => {
	// 99010 (Hillsbrad Courier -> Raleigh in Ironforge) has sea=false; 99011 is a required
	// prerequisite in Hillsbrad (beside the courier) for 99012, putting Hillsbrad on the route.
	const out = runPickup({
		map: 1453,
		x: 43,
		y: 24,
		extraQuests: `
QUESTS[99010] = {
	id = 99010, title = "Note from Hillsbrad", level = 34, minLevel = 30, faction = "A",
	start = { npc = { 99001 }, object = {}, item = {} },
	["end"] = { npc = { 5492 }, object = {} },
	objectives = {}, pre = {}, preAny = {},
}
QUESTS[99011] = {
	id = 99011, title = "Southshore Orders", level = 34, minLevel = 30, faction = "A",
	start = { npc = { 99002 }, object = {}, item = {} },
	["end"] = { npc = { 5492 }, object = {} },
	objectives = {}, pre = {}, preAny = {},
}
QUESTS[99012] = {
	id = 99012, title = "Ironforge Assignment", level = 35, minLevel = 30, faction = "A",
	start = { npc = { 5492 }, object = {}, item = {} },
	["end"] = { npc = { 5492 }, object = {} },
	objectives = { { type = "kill", id = 4282, count = 1, text = "Target" } },
	pre = { 99011 }, preAny = {},
}
`,
		extraPageQuests: `
{ id = 99010, title = "Note from Hillsbrad", faction = "Alliance", level = 34, minLevel = 30, chain = {} },
{ id = 99012, title = "Ironforge Assignment", faction = "Alliance", level = 35, minLevel = 30, chain = { 99011 } },
`,
	});
	assert.equal(out.crumbs['99010'].sea, false);
	assert.equal(out.crumbs['99010'].far, false);
	assert.equal(out.crumbs['99010'].taken, true);
	assert.ok(out.accepts.includes(99010), 'same-continent breadcrumb rides along with Hillsbrad stop');
});

test('breadcrumb with its own prerequisite (afterOwn) is still judged from that prerequisite', () => {
	// 99021 (Stormwind -> Raleigh in Ironforge) opens only after 99020 is turned in at Hillsbrad.
	// Even though the player starts right beside Brother Crowley in Stormwind, afterOwn measures
	// 99021 from Hillsbrad/Tirisfal (detour > 300) and drops it.
	const out = runPickup({
		map: 1453,
		x: 43,
		y: 24,
		extraQuests: `
QUESTS[99020] = {
	id = 99020, title = "Report to Southshore", level = 34, minLevel = 30, faction = "A",
	start = { npc = { 5492 }, object = {}, item = {} },
	["end"] = { npc = { 99002 }, object = {} },
	objectives = {}, pre = {}, preAny = {},
}
QUESTS[99021] = {
	id = 99021, title = "Follow-Up Breadcrumb", level = 34, minLevel = 30, faction = "A",
	start = { npc = { 12336 }, object = {}, item = {} },
	["end"] = { npc = { 5492 }, object = {} },
	objectives = {}, pre = { 99020 }, preAny = {},
}
`,
		extraPageQuests: `
{ id = 99021, title = "Follow-Up Breadcrumb", faction = "Alliance", level = 34, minLevel = 30, chain = { 99020 } },
`,
	});
	assert.equal(out.crumbs['99021'].sea, false);
	assert.ok(out.crumbs['99021'].detour > 300, `expected detour > 300 from prerequisite turn-in, got ${out.crumbs['99021'].detour}`);
	assert.equal(out.crumbs['99021'].taken, false);
	assert.ok(!out.accepts.includes(99021), 'afterOwn breadcrumb is dropped despite player starting beside its giver');
});
