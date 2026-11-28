'use strict';
// Gathering areas in the profession window, on the maps and on the arrow (Polestar 0.4.4; docs/GUIDE_FORMAT.md
// "Gathering areas"; Core/KindCraft.lua KC.Areas, UI/GuideFrameKindCraft.lua, Nav/Layers.lua, Nav/Arrow.lua). A way
// that gathers in areas ('Mine it', 'Pick it', 'Kill and skin it') lists up to three, best first and marked, each
// with about how many nodes are up, the level it is safe from, how far it is and Guide me (the player's pick, kept by
// the Engine); with none safe yet, from which level one is; with the pick mined out, which to try next. The active
// area is shaded on zone maps only, its node spots dotted on zone maps and the minimap; inside it the arrow says
// what to do there. The Engine's area calls (Engine.AreaChoices, PickArea, AreaShape, AreaRoam) stand in here as the
// core hands them over; tests/engine-area-*.test.js test the Engine's side.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const POLY = 'poly = "40,78;46,76;48,84;42,86"';
const MINING = `{ id = "test/mining", pack = "test", title = "Mining 1-300", minLevel = 1, maxLevel = 60, category = "Professions",
	sections = { { skill = "Mining", skillLine = 186, from = 1, to = 75 } },
	steps = {
		{ title = "Copper (1-50)", section = 1, goals = {
			{ t = "skill", skill = "Mining", skillLine = 186, level = 50, candidates = {
				{ map = 1412, x = 44, y = 80, area = "Red Cloud Mesa", lvl = { min = 1, max = 1 }, lap = 300, gain = 6, count = 12, items = "2770,2835", ${POLY} } } } } },
		{ title = "Get Copper Ore", section = 1, goals = {
			{ t = "collect", item = 2770, itemName = "Copper Ore", count = 40, gather = { rank = 1, skill = "Mining", skillLine = 186 }, candidates = {
				{ map = 1412, x = 44, y = 80, area = "Red Cloud Mesa", lvl = { min = 1, max = 1 }, lap = 300, yield = 9, count = 12, ${POLY} } } },
			{ t = "auction", item = 2770, itemName = "Copper Ore", count = 40 } } },
	} }`;

// The Engine's area calls as the core hands them over (CONTRACT §2): AREAS[verb] is AreaChoices' view; PickArea
// moves `current` and notes the call.
const ENGINE = `
local E = Polestar.Engine
E.IsAreaGoal = function(g) local c = g and g.candidates and g.candidates[1]; return c ~= nil and c.poly ~= nil end
picks, aims = {}, {}
local function view(verb)
	return { verb = verb, list = {
		{ i = 3, name = "Red Cloud Mesa", zone = "Mulgore", map = 1412, count = 12, safeFrom = 1, minutes = 0, here = true, best = true, current = true },
		{ i = 1, name = "Mulgore: near Bael'dun Digsite", zone = "Mulgore", map = 1412, count = 9, safeFrom = 8, minutes = 4.2 },
		{ i = 2, name = "The Golden Plains", zone = "Mulgore", map = 1412, count = 7, safeFrom = 6, minutes = 6 },
		{ i = 5, name = "Ravaged Caravan", zone = "Mulgore", map = 1412, count = 6, safeFrom = 7, minutes = 8 },
		{ i = 4, name = "Thunder Bluff", zone = "Mulgore", map = 1412, count = 5, safeFrom = 9, minutes = 9 },
	} }
end
AREAS = view("mine")
E.AreaChoices = function(s, gi) return AREAS end
E.PickArea = function(s, gi, i)
	picks[#picks + 1] = { s, gi, i }
	for _, a in ipairs(AREAS.list) do a.current = a.i == i or nil end
	Polestar.Fire("AREA_CHANGED")
end
local aim = E.AimGoal
E.AimGoal = function(s, gi, ...) aims[#aims + 1] = { s, gi }; return aim(s, gi, ...) end
`;

const script = (setup, body) => `
w = stub.world
w.addMap(1412, { name = "Mulgore", c = 1, left = 2047.917, right = -3089.583, top = -272.917, bottom = -3697.917 })
w.moveTo(1412, 45.5, 83.8)
w.setLevel(9)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide(${MINING})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local C = Polestar.Compat
C.GetSkillRank = function(line) if line == 186 or line == "Mining" then return 23, 75 end return nil end
C.GetSkillLineName = function(line) return line == 186 and "Mining" or nil end
local names = { [2770] = "Copper Ore", [2835] = "Rough Stone", [2318] = "Light Leather", [2447] = "Peacebloom", [765] = "Silverleaf" }
local itemName = C.GetItemName
C.GetItemName = function(id) return names[id] or itemName(id) end
${ENGINE}
${setup}
E.SetGuide("test/mining")
stub.advance(1)
local GF = Polestar.UI.GuideFrame
-- A step looked at; the Engine's areas changed (the core fires AREA_CHANGED): the window paints them again.
local function at(n) E.Goto(n); stub.advance(0.5); Polestar.Fire("AREA_CHANGED"); stub.advance(0.2); GF.Layout(); stub.advance(0.5) end
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\\194\\160", " ")) or s end
local function rows(id)
	local f, out = GF.RegionFrame(id), {}
	for _, r in ipairs(f and f.List or {}) do
		if r:IsShown() then
			out[#out + 1] = { text = plain(r.Text:GetText()), sub = r.Sub:IsShown() and plain(r.Sub:GetText()) or false,
				on = r.psDot and r.psDot:IsShown() or false, button = r.psButton and r.psButton:IsShown() and r.psButton.Label:GetText() or false,
				x = r.psIndent or 0, area = r.psArea or false }
		end
	end
	return out
end
${body}`;

const run = (setup, body, addons = ['Polestar']) => runAddon({ stubs: ['stub_world.lua'], addons, script: script(setup, body) }).emitted[0];

test('a skill step in areas: its goal\'s row, Mine it, then three areas best first and marked, the arrow\'s with the dot', () => {
	const out = run('', `at(1)
emit({ rows = rows("areas"), shown = GF.RegionFrame("areas"):IsShown() })`);
	assert.equal(out.shown, true);
	const r = out.rows;
	assert.equal(r.length, 5, 'the goal, the way and three areas (five eligible)');
	assert.equal(r[0].x, 0);
	assert.deepEqual([r[1].text, r[1].x, r[1].button], ['Mine it', 16, 'Guide me']);
	assert.deepEqual(r.slice(2).map((a) => [a.text, a.sub, a.on, a.button, a.x, a.area]), [
		['Red Cloud Mesa  Best', '~12 veins  ·  you\'re here', true, 'Guide me', 32, 3],
		['Mulgore: near Bael\'dun Digsite', '~9 veins  ·  safe from 8  ·  4 min away', false, 'Guide me', 32, 1],
		['The Golden Plains', '~7 veins  ·  safe from 6  ·  6 min away', false, 'Guide me', 32, 2],
	]);
});

test('the arrow\'s area ranked past three stays listed in third place', () => {
	const out = run('', `AREAS.list[1].current = nil; AREAS.list[5].current = true
at(1)
emit(rows("areas"))`);
	assert.deepEqual(out.slice(2).map((a) => [a.text, a.on]), [['Red Cloud Mesa  Best', false], ['Mulgore: near Bael\'dun Digsite', false], ['Thunder Bluff', true]]);
});

test('Guide me on an area picks it through the Engine and leads the arrow there', () => {
	const out = run('', `at(1)
local f = GF.RegionFrame("areas")
f.List[4].psButton:Click()
stub.advance(0.5); GF.Layout(); stub.advance(0.5)
local after = rows("areas")
f.List[5]:Click()
emit({ picks = picks, aims = aims, after = { after[3].on, after[4].on } })`);
	assert.deepEqual(out.picks, [[1, 1, 1], [1, 1, 2]], 'the button, then a click on the row');
	assert.deepEqual(out.aims[0], [1, 1]);
	assert.deepEqual(out.after, [false, true], 'the picked area wears the dot');
});

test('none safe yet: the way says from which level ("Safe Copper Ore area from level 6"), no areas, no Guide me', () => {
	const out = run('w.setLevel(2); AREAS = { verb = "mine", list = {}, safeFrom = 6 }', `at(1)
emit(rows("areas"))`);
	assert.equal(out.length, 2);
	assert.deepEqual([out[1].text, out[1].sub, out[1].button], ['Mine it', 'Safe Copper Ore area from level 6', false]);
});

test('mined out: "Try <Area> next" first, saying the pick is mined out; its Guide me picks the next', () => {
	const out = run('AREAS.out = { name = "Red Cloud Mesa", next = "The Golden Plains", i = 2 }', `at(1)
local r = rows("areas")
GF.RegionFrame("areas").List[3].psButton:Click()
emit({ r = r, picks = picks })`);
	assert.deepEqual([out.r[2].text, out.r[2].sub, out.r[2].on, out.r[2].button], ['Try The Golden Plains next', 'Red Cloud Mesa is mined out for now', false, 'Guide me']);
	assert.equal(out.r.length, 6);
	assert.deepEqual(out.picks, [[1, 1, 2]]);
});

test('herbs and beasts: Pick it with ~N herbs; Kill and skin it with ~N beasts and their levels; the out line per profession', () => {
	const out = run('', `AREAS = { verb = "herb", list = { { i = 1, name = "Valley of Trials", count = 14, safeFrom = 1, minutes = 2, best = true, current = true } },
	out = { name = "Durotar: near Razor Hill", next = "Valley of Trials", i = 1 } }
at(1)
local herbs = rows("areas")
AREAS = { verb = "skin", list = { { i = 1, name = "The Golden Plains", count = 22, levels = { min = 1, max = 6 }, safeFrom = 3, minutes = 1, best = true, current = true },
	{ i = 2, name = "Red Cloud Mesa", count = 18, levels = { min = 2, max = 2 }, safeFrom = 1, minutes = 0.4 } },
	out = { name = "Bloodhoof Village", next = "The Golden Plains", i = 1 } }
Polestar.Fire("AREA_CHANGED"); stub.advance(0.5); GF.Layout(); stub.advance(0.5)
emit({ herbs = herbs, skins = rows("areas") })`);
	assert.equal(out.herbs[1].text, 'Pick it');
	assert.deepEqual([out.herbs[2].text, out.herbs[2].sub], ['Try Valley of Trials next', 'Durotar: near Razor Hill is picked clean for now']);
	assert.deepEqual([out.herbs[3].text, out.herbs[3].sub], ['Valley of Trials', '~14 herbs  ·  2 min away'], 'one area: no Best mark');
	assert.equal(out.skins[1].text, 'Kill and skin it');
	assert.equal(out.skins[2].sub, 'Bloodhoof Village is hunted out for now');
	assert.deepEqual(out.skins.slice(3).map((a) => [a.text, a.sub]), [
		['The Golden Plains  Best', '~22 beasts (level 1-6)  ·  safe from 3  ·  1 min away'],
		['Red Cloud Mesa', '~18 beasts (level 2)  ·  under a minute away'],
	]);
});

test('a get step: the gathering way taken lists its areas under it; the Auction House taken, the way names the best area', () => {
	const out = run('', `at(2)
local gather = rows("get")
Polestar.Materials.SetWay("test/mining", 2770, "buy"); stub.advance(0.5); GF.Layout(); stub.advance(0.5)
emit({ gather = gather, buy = rows("get") })`);
	const g = out.gather;
	assert.match(g[0].text, /^Get 40 Copper Ore/);
	assert.deepEqual([g[1].text, g[1].on, g[1].sub], ['Mine it', true, false]);
	assert.deepEqual(g.slice(2, 5).map((a) => [a.text, a.x]), [['Red Cloud Mesa  Best', 32], ['Mulgore: near Bael\'dun Digsite', 32], ['The Golden Plains', 32]]);
	assert.equal(g[5].text, 'Buy it at the Auction House');
	assert.equal(out.buy.length, 3, 'the item, the two ways');
	assert.deepEqual([out.buy[1].text, out.buy[1].on, out.buy[1].sub], ['Mine it', false, 'Red Cloud Mesa  ·  you\'re here']);
});

test('compact: the goal\'s row and the arrow\'s area only', () => {
	const out = run('Polestar.Set("ui.compact", true)', `at(1)
emit(rows("areas"))`);
	assert.equal(out.length, 2);
	assert.deepEqual([out[1].text, out[1].on, out[1].button, out[1].x], ['Red Cloud Mesa  Best', true, 'Guide me', 16]);
});

test('Atlas keeps the area rows in the window', () => {
	const out = run('Polestar.Set("ui.layout", "atlas")', `at(1)
emit({ card = GF.RegionFrame("areas"):GetParent() == GF.parts.card, n = #rows("areas") })`,
	['Polestar', { name: 'Polestar_Skins', files: ['Layouts/Atlas/Atlas.lua'] }]);
	assert.deepEqual(out, { card: true, n: 5 });
});

test('no area text is cut: every row\'s text wraps whole, clear of its button, at the narrowest window', () => {
	const out = run('', `Polestar.UI.GuideFrame.frame:SetWidth(Polestar.UI.MIN_WIDTH)
AREAS.list[2].name = "Mulgore: near the Venture Co. Mine and Bael'dun Digsite"
at(1)
local f, bad, n = GF.RegionFrame("areas"), {}, 0
local width, TEXT_X = Polestar.UI.GuideFrame.frame:GetWidth(), GF.metrics and GF.metrics.TEXT_X or 38
for _, r in ipairs(f.List) do
	if r:IsShown() then
		for _, fs in ipairs({ r.Text, r.Sub }) do
			if fs:IsShown() and fs:GetText() and fs:GetText() ~= "" then
				n = n + 1
				if fs:IsTruncated() then bad[#bad + 1] = "cut: " .. plain(fs:GetText()) end
				-- Its width plus the indent, the icon's column and the button's room fits the window.
				if r.psButton and r.psButton:IsShown() and (r.psRightMin or 0) < r.psButton:GetWidth() then bad[#bad + 1] = "no room for the button: " .. plain(fs:GetText()) end
				if (r.psIndent or 0) + TEXT_X + fs:GetWidth() + (r.psRightMin or 0) > width then bad[#bad + 1] = "past the edge: " .. plain(fs:GetText()) end
			end
		end
	end
end
emit({ bad = bad, n = n })`);
	assert.deepEqual(Object.values(out.bad), [], 'Lua\'s empty table reads as {}');
	assert.equal(out.n, 8, 'the goal\'s and the way\'s text, three areas with their lines');
});

// The map (Nav/Layers.lua): the active area's outline on zone maps only, its node dots as a dense layer.
test('the map: the active area shaded on zone maps only (not the minimap), its node spots dotted on zone maps and the minimap', () => {
	const out = run('', `local layers = {}
local set = Polestar.Pins.SetLayer
Polestar.Pins.SetLayer = function(name, pins, opts) layers[name] = { n = #pins, opts = opts, hull = pins[1] and pins[1].hull and #pins[1].hull or 0 }; return set(name, pins, opts) end
E.AreaShape = function(s, gi) return { map = 1412, poly = { { 40, 78 }, { 46, 76 }, { 48, 84 }, { 42, 86 } }, dots = { { 41, 80 }, { 44, 79 }, { 46, 82 } } } end
Polestar.Set("nav.worldPins", true); Polestar.Set("nav.minimapPins", true)
at(1)
E.AimGoal(1, 1); stub.advance(0.5)
Polestar.Nav.layers.Update()
local shape, nodes = layers["nav.areaShape"], layers["nav.areaNodes"]
-- Another step: no area, both go.
E.AreaShape = function() return nil end
Polestar.Fire("AREA_CHANGED"); stub.advance(0.2)
emit({ shape = shape and { n = shape.n, hull = shape.hull, world = shape.opts.world, minimap = shape.opts.minimap, min = shape.opts.minMapType } or false,
	nodes = nodes and { n = nodes.n, world = nodes.opts.world, minimap = nodes.opts.minimap, dense = nodes.opts.dense, min = nodes.opts.minMapType } or false,
	gone = layers["nav.areaShape"].n == 0 and layers["nav.areaNodes"].n == 0 or Polestar.Pins.GetLayer == nil })`);
	assert.deepEqual(out.shape, { n: 1, hull: 8, world: true, minimap: false, min: 3 }, 'a hull of four corners, zone maps and narrower only');
	assert.deepEqual(out.nodes, { n: 3, world: true, minimap: true, dense: true, min: 3 });
});

// The arrow (Nav/Arrow.lua): resting inside the area, the roam line in the needle's place.
test('the roam line per profession: Mining, Herbalism, Skinning', () => {
	const out = run('', `local A = Polestar.Nav.arrow
local function two(r) local a, b = A.RoamLines(r); return { a or false, b or false } end
emit({
	mine = two({ name = "Red Cloud Mesa", verb = "mine", items = { 2770, 2835 } }),
	mine1 = two({ name = "Red Cloud Mesa", verb = "mine", items = { 2770 } }),
	mine0 = two({ name = "Red Cloud Mesa", verb = "mine" }),
	herb = two({ name = "Valley of Trials", verb = "herb", items = { 2447, 765 } }),
	skin = two({ name = "The Golden Plains", verb = "skin", levels = { min = 1, max = 6 } }),
	skin1 = two({ name = "The Golden Plains", verb = "skin", levels = { min = 4, max = 4 } }),
})`);
	assert.deepEqual(out.mine, ['Roam Red Cloud Mesa for Copper Ore and Rough Stone', 'Find Minerals shows them on your minimap']);
	assert.deepEqual(out.mine1, ['Roam Red Cloud Mesa for Copper Ore', 'Find Minerals shows them on your minimap']);
	assert.deepEqual(out.mine0, ['Roam Red Cloud Mesa for ore', 'Find Minerals shows them on your minimap']);
	assert.deepEqual(out.herb, ['Roam Valley of Trials for Peacebloom and Silverleaf', 'Find Herbs shows them on your minimap']);
	assert.deepEqual(out.skin, ['Roam The Golden Plains for beasts (level 1-6)', 'Loot, then skin them']);
	assert.deepEqual(out.skin1, ['Roam The Golden Plains for beasts (level 4)', 'Loot, then skin them']);
});

test('the arrow inside the area: the roam line where "Arrived" would be, wrapped at the label\'s width; written again on AREA_CHANGED', () => {
	const out = run('', `local N = Polestar.Nav
local A = N.arrow
E.AreaRoam = function() return { name = "Red Cloud Mesa", verb = "mine", items = { 2770 } } end
N.SetTarget(1412, 45.5, 83.8, "Red Cloud Mesa")
-- Nav sets target.roam while the player is inside the area's outline (the core's); here the player is.
local roam = true
local sample = N.Sample
N.Sample = function(...)
	local s, d, a, x, y, m = sample(...)
	N.GetTarget().roam = roam or nil
	return "arrived", 0, a, x, y, m
end
A:Refresh(); stub.advance(0.3)
local p = A.skinParts
local first = { mode = A.GetMode(), dist = p.distance:GetText(), eta = p.eta:IsShown() and p.eta:GetText() or false, w = p.distance:GetWidth() > 0 }
E.AreaRoam = function() return { name = "Mulgore: near Bael'dun Digsite", verb = "mine", items = { 2770 } } end
Polestar.Fire("AREA_CHANGED"); stub.advance(0.3)
local second = p.distance:GetText()
roam = false
A:Refresh(); stub.advance(0.3)
emit({ first = first, second = second, plain = p.distance:GetText(), mode = A.GetMode() })`);
	assert.deepEqual(out.first, { mode: 'roam', dist: 'Roam Red Cloud Mesa for Copper Ore', eta: 'Find Minerals shows them on your minimap', w: true });
	assert.equal(out.second, 'Roam Mulgore: near Bael\'dun Digsite for Copper Ore');
	assert.deepEqual([out.mode, out.plain], ['arrived', 'Arrived'], 'outside the roam state: Arrived again');
});
