'use strict';
// A dungeon's work out in the world before the way in (#4379; Dungeons/Pickup.lua, Dungeons.OutsideWork) and
// the dungeon window round it (Core/KindDungeon.lua, UI/GuideFrameKindDungeon.lua): the step's own goal rows
// between the group and the pick-ups, as the leveling view shows them; each pick-up a goal row with its tick
// box, its prerequisite named under it; "Guide me to the entrance" only once nothing is left before the door.
// The Ruins of Lordaeron for a fresh Horde character at 15: The Wrath of Rath'mael waits on Rear Guard
// Patrol (kill 8 + 8) and its follow-up, The New Plague on the three parts of A Recipe For Death.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const WORLD = `
local w = stub.world
w.level, w.race, w.raceName, w.faction = 15, "Scourge", "Undead", "Horde"
w.class, w.className = "WARRIOR", "WARRIOR"
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.addMap(1458, { name = "Undercity", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.addMap(1421, { name = "Silverpine Forest", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.addMap(1443, { name = "Desolace", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.addMap(1446, { name = "Tanaris", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.moveTo(1420, 65, 61)
-- Seconds: 4 per map unit within a zone; Tirisfal, the Undercity and Silverpine two minutes apart; Kalimdor's
-- zones twenty.
local Z = { [1420] = "tir", [1458] = "uc", [1421] = "sp", [1443] = "des", [1446] = "tan" }
Polestar.TravelCost = function(a, b)
	local za, zb = Z[a.map], Z[b.map]
	if not (za and zb) then return nil end
	if za == zb then return 5 + 4 * (math.abs(a.x - b.x) + math.abs(a.y - b.y)) end
	if (za == "des" or za == "tan") ~= (zb == "des" or zb == "tan") then return 3600 end
	return (za == "des" or za == "tan") and 1200 or 120
end
local INSIDE = "ruins-of-lordaeron"
local function npc(id, name, map, x, y) return { id = id, name = name, faction = map and "H" or nil, spawns = map and { { map = map, x = x, y = y } } or {} } end
local function mob(id, name, map, x, y) return { id = id, name = name, spawns = { { map = map, x = x, y = y } } } end
NPCS = {
	[1495] = npc(1495, "Deathguard Linnea", 1420, 65.4, 60.2),
	[251001] = npc(251001, "Deathguard Kristof", 1420, 65.1, 60.2),
	[1518] = npc(1518, "Apothecary Johaan", 1420, 59.4, 52.4),
	[11835] = npc(11835, "Theodore Griffs", 1458, 46.5, 71.6),
	[250686] = npc(250686, "Tabitha Heartweaver", 1421, 44.5, 42.9),
	[266484] = npc(266484, "Morbin Lightbane", 1458, 57.9, 89.5),
	[1529] = mob(1529, "Bleeding Horror", 1420, 72, 62),
	[1532] = mob(1532, "Wandering Spirit", 1420, 74, 60),
	[90002] = mob(90002, "Riptear", 1420, 70, 66),
	[1553] = mob(1553, "Greater Duskbat", 1420, 52, 58),
	[1508] = mob(1508, "Young Scavenger", 1420, 55, 45),
	[1778] = mob(1778, "Ferocious Grizzled Bear", 1421, 40, 30),
	[250657] = { id = 250657, name = "Rath'mael", instance = INSIDE, spawns = {} },
	[250483] = { id = 250483, name = "Witherfang", instance = INSIDE, spawns = {} },
	[90001] = { id = 90001, name = "Stitched Horror", instance = INSIDE, spawns = {} },
}
local function drop(id, name, from) return { id = id, name = name, sources = { { type = "drop", npc = from, chance = 60 } } } end
ITEMS = {
	[286326] = drop(286326, "Riptear's Heart", 90002),
	[3264] = drop(3264, "Duskbat Wing", 1553),
	[3265] = drop(3265, "Scavenger Paw", 1508),
	[3253] = drop(3253, "Grizzled Bear Heart", 1778),
	[275443] = { id = 275443, name = "Highly Toxic Strain", sources = { { type = "drop", npc = 250483, chance = 100, instance = INSIDE } } },
	[268580] = { id = 268580, name = "Intact Limbs", sources = { { type = "drop", npc = 90001, chance = 50, instance = INSIDE } } },
}
local function quest(id, title, giver, objectives, pre, level)
	return { id = id, title = title, level = level or 22, minLevel = 6, faction = "H",
		start = { npc = { giver }, object = {}, item = {} }, ["end"] = { npc = { giver }, object = {} },
		objectives = objectives, pre = pre or {}, preAny = {} }
end
QUESTS = {
	[356] = quest(356, "Rear Guard Patrol", 1495, { { type = "kill", id = 1529, count = 8, text = "Bleeding Horror" }, { type = "kill", id = 1532, count = 8, text = "Wandering Spirit" } }, {}, 11),
	[99156] = quest(99156, "Rear Guard Patrol", 1495, { { type = "item", id = 286326, count = 1, text = "Riptear's Heart" } }, { 356 }, 13),
	[92422] = quest(92422, "The Wrath of Rath'mael", 251001, { { type = "kill", id = 250657, count = 1, text = "Rath'mael" } }, { 99156 }),
	[447] = quest(447, "A Recipe For Death", 1518, { { type = "item", id = 3264, count = 6, text = "Duskbat Wing" } }, {}, 12),
	[450] = quest(450, "A Recipe For Death", 1518, { { type = "item", id = 3265, count = 6, text = "Scavenger Paw" } }, { 447 }, 13),
	[451] = quest(451, "A Recipe For Death", 1518, { { type = "item", id = 3253, count = 1, text = "Grizzled Bear Heart" } }, { 450 }, 14),
	[95216] = quest(95216, "The New Plague", 11835, { { type = "item", id = 275443, count = 1, text = "Highly Toxic Strain" } }, { 451 }),
	[92401] = quest(92401, "A Frightened Request", 250686, {}),
	[92421] = quest(92421, "Light's Justice", 266484, { { type = "item", id = 268580, count = 25, text = "Intact Limbs" } }),
}
local function pq(id, title, chain) return { id = id, title = title, faction = "Horde", level = 22, minLevel = 15, chain = chain or {} } end
PAGE = {
	key = INSIDE, name = "Ruins of Lordaeron", map = 2999, minLevel = 15, maxLevel = 22, floor = 18, players = 5,
	zone = 1458, zoneName = "Undercity", entrance = { map = 1458, x = 72.8, y = 11.5 },
	quests = { pq(92401, "A Frightened Request"), pq(92421, "Light's Justice"), pq(92422, "The Wrath of Rath'mael", { 356, 99156 }),
		pq(95216, "The New Plague", { 447, 450, 451 }) },
}
local C = Polestar.Codex
C.Ready = function() return true end
C.Load = function() return true end
C.Quest = function(id) return QUESTS[id] end
C.Npc = function(id) return NPCS[id] end
C.Object = function() return nil end
C.Item = function(id) return ITEMS[id] end
local BY_ID = {}
function index() BY_ID = {}; for _, q in ipairs(PAGE.quests) do BY_ID[q.id] = q end end
index()
local D = Polestar.Dungeons
D.Load = function() return true end
D.Get = function(key) return key == PAGE.key and PAGE or nil end
D.List = function() return { PAGE } end
D.ForMap = function(map) return map == PAGE.map and PAGE.key or nil end
D.Find = function(t) return (t == PAGE.name or t == PAGE.key) and PAGE.key or nil end
D.Quests = function(key) return key == PAGE.key and PAGE.quests or {} end
D.Quest = function(key, id) return key == PAGE.key and BY_ID[id] or nil end
D.Bosses = function() return {} end
D.BestAt = function() return 20 end
D.Entrance = function() local e = PAGE.entrance; return e.map, e.x, e.y end
D.Attunements = function() return {} end
D.AttunementState = function(a) return { done = a.done } end
E = Polestar.Engine
GF = Polestar.UI.GuideFrame
VIEW = { guide = { dungeon = INSIDE } }
function pickups()
	local m = E.KindModel("pickups", VIEW, "dungeon")
	local rows = {}
	for _, q in ipairs(m.missing) do
		rows[#rows + 1] = { q.title, q.after and q.after.title or false, q.after and q.after.n or false, q.after and q.after.of or false }
	end
	return { held = m.held, total = m.total, work = m.work, rows = rows }
end
function go() return E.KindModel("entrance", VIEW, "dungeon").go end
`;

const run = (script) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], login: true, script: WORLD + script }).emitted;

const CHAINS_DONE = 'w.complete({ 356, 99156, 447, 450, 451 })\n';

test("Fitz's case, a fresh Horde character at 15: both chains are work before the way in, named on their pick-ups; no way in yet", () => {
	const [m, entrance, work] = run(`
emit(pickups())
emit({ go = go() })
local out = {}
local plan = Polestar.Dungeons.PickupPlan(INSIDE)
for _, w in ipairs(Polestar.Dungeons.OutsideWork(plan)) do
	local g = {}
	for _, x in ipairs(w.goals) do g[#g + 1] = x.t .. ":" .. tostring(x.npc or x.item or x.quest) end
	out[#out + 1] = { w.title, w.chain and w.chain.n or false, w.chain and w.chain.of or false, table.concat(g, " ") }
end
emit(out)
`);
	assert.equal(m.total, 4);
	assert.equal(m.held, 0);
	assert.equal(m.work, 2, 'the two chains are open work');
	const by = Object.fromEntries(m.rows.map((r) => [r[0], r]));
	assert.deepEqual(by["The Wrath of Rath'mael"].slice(1), ['Rear Guard Patrol', 1, 2]);
	assert.deepEqual(by['The New Plague'].slice(1), ['A Recipe For Death', 1, 3]);
	assert.equal(by['Light\'s Justice'][1], false, 'a quest with no prerequisite names none');
	assert.equal(entrance.go, false, 'pick-ups and chains left: no Guide me to the entrance');
	assert.deepEqual(work.map((w) => w[0]).sort(), ['A Recipe For Death', 'Rear Guard Patrol']);
	const rg = work.find((w) => w[0] === 'Rear Guard Patrol');
	assert.equal(rg[3], 'accept:1495 kill:1529 kill:1532 turnin:1495', "the chain quest's whole step");
});

test("Fitz's own state, the chains done: exactly the four pick-ups, no work; the way in comes once they are in the log", () => {
	const [m, before, after] = run(CHAINS_DONE + `
emit(pickups())
emit({ go = go() })
for _, id in ipairs({ 92401, 92421, 92422, 95216 }) do w.accept(id, {}, QUESTS[id].title) end
stub.advance(0.5)
Polestar.KindDungeon.Forget()
emit({ go = go(), m = pickups() })
`);
	assert.equal(m.total, 4);
	assert.equal(m.work, 0);
	assert.deepEqual(m.rows.map((r) => r[0]).sort(), ['A Frightened Request', "Light's Justice", 'The New Plague', "The Wrath of Rath'mael"]);
	assert.ok(m.rows.every((r) => r[1] === false), 'no prerequisite left');
	assert.equal(before.go, false);
	assert.equal(after.go, true, 'all four in the log: the way in is offered');
	assert.equal(after.m.held, 4);
});

test('the pick-up guide: the chain quest is a step of its own shown as the leveling view shows it, between the group and the pick-ups; the button stays hidden', () => {
	const [out] = run(`
Polestar.Set("ui.shown", true)
Polestar.Dungeons.PickUp(INSIDE)
stub.advance(0.5)
GF.Render() GF.Layout()
local def = E.GetGuide()
local titles = {}
for i, s in ipairs(def.steps) do titles[i] = s.title end
local v = E.GetStepView(E.GetStepIndex())
local function rows()
	local out = {}
	for _, r in ipairs(GF.rows) do
		if r:IsShown() and r.psGoal then out[#out + 1] = (r.Text:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
	end
	return out
end
local first = rows()
w.accept(356, { { text = "Bleeding Horror slain: 0/8", type = "monster", required = 8 }, { text = "Wandering Spirit slain: 0/8", type = "monster", required = 8 } }, "Rear Guard Patrol")
stub.advance(0.5)
GF.Render() GF.Layout()
local taken = rows()
local p = GF.RegionFrame("pickups")
local _, rel = p:GetPoint(1)
local entrance = GF.RegionFrame("entrance")
local sub = {}
for i = 1, p.psRows do sub[i] = p.Rows[i].Sub:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "") end
emit({ titles = titles, step = v.title, first = first, rows = taken, pickupsUnder = rel == GF.parts.goals or rel == GF.parts.card.Tip,
	go = entrance.Go:IsShown(), checks = p.Rows[1].Check ~= nil, subs = sub })
`);
	assert.ok(out.titles.includes('Rear Guard Patrol'), out.titles.join(' | '));
	assert.equal(out.step, 'Rear Guard Patrol', 'Linnea stands by: the chain comes first');
	assert.ok(out.first.some((t) => /Accept.*Rear Guard Patrol/.test(t)), out.first.join(' | '));
	assert.ok(out.rows.some((t) => /Bleeding Horror.*0\/8/.test(t)), out.rows.join(' | '));
	assert.ok(out.rows.some((t) => /Wandering Spirit.*0\/8/.test(t)), out.rows.join(' | '));
	assert.equal(out.pickupsUnder, true, "the pick-ups sit under the step's rows");
	assert.equal(out.go, false, 'Guide me to the entrance hides while work is left');
	assert.equal(out.checks, true, 'each pick-up is a goal row with its tick box');
	assert.ok(out.subs.some((s) => /^Deathguard Kristof · (After .* · )?Chain: 1 of 2$/.test(s)), `the title may give way, the chain's count stays: ${out.subs.join(' | ')}`);
});

test('a pick-up ticks when accepted and stays until the step moves on; the count follows', () => {
	const [before, after] = run(CHAINS_DONE + `
-- Morbin gives The New Plague too here: a stop with two accepts.
QUESTS[95216].start.npc = { 266484 }
w.moveTo(1458, 57, 89)
Polestar.Set("ui.shown", true)
Polestar.Dungeons.PickUp(INSIDE)
stub.advance(0.5)
GF.Render() GF.Layout()
local function look()
	local p = GF.RegionFrame("pickups")
	local rows = {}
	for i = 1, p.psRows do
		local r = p.Rows[i]
		rows[#rows + 1] = { r.psGoal.quest, r.psGoal.status == "done", r.Check:GetChecked() and true or false }
	end
	return { right = p.Head.Right:GetText(), rows = rows }
end
emit(look())
local v = E.GetStepView(E.GetStepIndex())
local q
for _, g in ipairs(v.goals) do if g.t == "accept" then q = g.quest end end
w.accept(q, {}, QUESTS[q].title)
stub.advance(0.5)
GF.Render() GF.Layout()
local out = look()
out.q = q
emit(out)
`);
	assert.equal(before.right, '0 / 4');
	assert.ok(before.rows.every((r) => r[1] === false && r[2] === false), 'all unticked');
	assert.equal(after.right, '1 / 4');
	const row = after.rows.find((r) => r[0] === after.q);
	assert.ok(row, 'the accepted quest keeps its row');
	assert.deepEqual(row.slice(1), [true, true], 'ticked');
});

test("a click on a pick-up points the arrow at its giver, or at its chain's giver while it waits on one, as a goal row's click does", () => {
	const [out] = run(`
Polestar.Set("ui.shown", true)
Polestar.Dungeons.PickUp(INSIDE)
stub.advance(0.5)
GF.Render() GF.Layout()
local p = GF.RegionFrame("pickups")
local out = {}
for i = 1, p.psRows do
	local r = p.Rows[i]
	r:GetScript("OnClick")(r, "LeftButton")
	local t = Polestar.Nav.GetTarget()
	out[QUESTS[r.psGoal.quest].title] = t and { t.map, t.x, t.y } or false
end
emit(out)
`);
	assert.deepEqual(out["Light's Justice"], [1458, 57.9, 89.5], "Morbin Lightbane's place");
	assert.deepEqual(out["The Wrath of Rath'mael"], [1420, 65.4, 60.2], 'Deathguard Linnea, Rear Guard Patrol first');
});

test("the page quests' own work out in the world: an item made from parts the world gives (The Pariah's Instructions' gems), a step before the way in; far work optional", () => {
	const [near, far] = run(`
w.moveTo(1443, 40, 70)
PAGE.key, PAGE.name, PAGE.zone = "maraudon", "Maraudon", 1443
PAGE.entrance = { map = 1443, x = 31, y = 60.8 }
NPCS[13717] = npc(13717, "Centaur Pariah", 1443, 46.1, 86.4)
NPCS[13742] = mob(13742, "Kolk", 1443, 29.8, 60.3)
NPCS[13739] = { id = 13739, name = "Maraudos", instance = "maraudon", spawns = {} }
NPCS[5000] = npc(5000, "Far Giver", 1443, 50, 50)
NPCS[5001] = mob(5001, "Dune Smasher", 1446, 50, 50)
ITEMS[17761] = drop(17761, "Gem of the First Khan", 13742)
ITEMS[17764] = { id = 17764, name = "Gem of the Fourth Khan", sources = { { type = "drop", npc = 13739, chance = 100, instance = "maraudon" } } }
ITEMS[17758] = { id = 17758, name = "Amulet of Union", sources = {} }
ITEMS[9000] = drop(9000, "Sand Shard", 5001)
QUESTS[7067] = quest(7067, "The Pariah's Instructions", 13717, { { type = "item", id = 17758, count = 1, text = "Amulet of Union", madeFrom = { 17761, 17764 } } })
QUESTS[7068] = quest(7068, "Shards of the Sands", 5000, { { type = "item", id = 9000, count = 5, text = "Sand Shard" } })
PAGE.quests = { pq(7067, "The Pariah's Instructions"), pq(7068, "Shards of the Sands") }
index()
local plan = Polestar.Dungeons.PickupPlan("maraudon")
local out = {}
for _, w in ipairs(Polestar.Dungeons.OutsideWork(plan)) do
	local g = {}
	for _, x in ipairs(w.goals) do g[#g + 1] = x.t .. ":" .. tostring(x.item or x.npc) .. (x.optional and ":optional" or "") end
	out[w.title] = table.concat(g, " ")
end
emit(out)
local def = Polestar.Dungeons.PickupGuide("maraudon")
local steps = {}
for _, s in ipairs(def.steps) do steps[#steps + 1] = s.title end
emit({ steps = steps })
`);
	assert.equal(near["The Pariah's Instructions"], 'collect:17761', "the gem the world gives; the one inside is the run's");
	assert.equal(near['Shards of the Sands'], 'collect:9000:optional', "Tanaris and back from Maraudon's door is far: optional");
	const steps = far.steps;
	const work = steps.indexOf("The Pariah's Instructions");
	assert.ok(work >= 0, steps.join(' | '));
	assert.equal(steps[steps.length - 1], 'Maraudon', 'the way in last');
});
