'use strict';
// Gathering areas in the profession window, on the maps and on the arrow (Polestar 0.4.4; docs/GUIDE_FORMAT.md
// "Gathering areas"; Core/KindCraft.lua KC.Areas, UI/GuideFrameKindCraft.lua, Nav/Layers.lua, Nav/Arrow.lua). A way
// that gathers in areas ('Mine it', 'Gather it', 'Kill and skin it') lists up to three, best first and marked, each
// with about how many nodes are up, the level it is safe from, how far it is and Guide me (the player's pick, kept by
// the Engine); with none safe yet, from which level one is; with the pick mined out, which to try next. The active
// area is shaded on zone maps only, its node spots dotted on zone maps and the minimap; inside it the arrow says
// what to do there. The Engine's area calls (Engine.AreaChoices, PickArea, AreaShape, AreaRoam) stand in here as the
// core hands them over; tests/engine-area-*.test.js test the Engine's side.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const POLY = 'poly = "40,78;46,76;48,84;42,86"';
// The step's candidates, indexed as the stub view's `i`: an open ground's sentences ("Try near X, Zone, next") take
// their name parts from them (KC.AreaParts); the rows show the Engine's names.
const NAMES = ['area = "Bael\'dun Digsite", near = true', 'area = "The Golden Plains"', 'area = "Red Cloud Mesa"', 'area = "Thunder Bluff"', 'area = "Ravaged Caravan"'];
const cands = (extra) => NAMES.map((n) => `{ map = 1412, x = 44, y = 80, ${n}, lvl = { min = 1, max = 1 }, lap = 300, ${extra}, count = 12, ${POLY} }`).join(', ');
const MINING = `{ id = "test/mining", pack = "test", title = "Mining 1-300", minLevel = 1, maxLevel = 60, category = "Professions",
	sections = { { skill = "Mining", skillLine = 186, from = 1, to = 75 } },
	steps = {
		{ title = "Copper (1-50)", section = 1, goals = {
			{ t = "skill", skill = "Mining", skillLine = 186, level = 50, candidates = { ${cands('gain = 6, items = "2770,2835"')} } } } },
		{ title = "Get Copper Ore", section = 1, goals = {
			{ t = "collect", item = 2770, itemName = "Copper Ore", count = 40, gather = { rank = 1, skill = "Mining", skillLine = 186 }, candidates = { ${cands('yield = 9')} } },
			{ t = "auction", item = 2770, itemName = "Copper Ore", count = 40 } } },
	} }`;

// A crafting guide, where buying its material is a real way: Blacksmithing's Rough Stone, mined or bought.
const SMITHING = `{ id = "test/smithing", pack = "test", title = "Blacksmithing 1-300", minLevel = 1, maxLevel = 60, category = "Professions",
	sections = { { skill = "Blacksmithing", skillLine = 164, from = 1, to = 75 } },
	steps = {
		{ title = "Get Rough Stone", section = 1, goals = {
			{ t = "collect", item = 2835, itemName = "Rough Stone", count = 40, gather = { rank = 1, skill = "Mining", skillLine = 186 }, candidates = { ${cands('yield = 9')} } },
			{ t = "auction", item = 2835, itemName = "Rough Stone", count = 40 } } },
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
		{ i = 1, name = "Near Bael'dun Digsite, Mulgore", zone = "Mulgore", map = 1412, count = 9, safeFrom = 8, minutes = 4.2 },
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
Polestar.RegisterGuide(${SMITHING})
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
				on = (r.psDot and r.psDot:IsShown()) or (tostring(r.Icon:GetTexture() or ""):find("icon%-goto$") ~= nil),
				icon = tostring(r.Icon:GetTexture() or ""):match("([^\\\\/]+)$") or false, button = r.psButton and r.psButton:IsShown() and r.psButton.Label:GetText() or false,
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
	assert.deepEqual([r[1].text, r[1].x, r[1].button], ['Mine it', 16, false], 'the areas carry the Guide me buttons');
	assert.deepEqual(r.slice(2).map((a) => [a.text, a.sub, a.on, a.button, a.x, a.area]), [
		['Red Cloud Mesa  Best', '~12 veins  ·  you\'re here', true, 'Guide me', 32, 3],
		['Near Bael\'dun Digsite, Mulgore', '~9 veins  ·  safe from 8  ·  4 min away', false, 'Guide me', 32, 1],
		['The Golden Plains', '~7 veins  ·  safe from 6  ·  6 min away', false, 'Guide me', 32, 2],
	]);
});

test('the arrow\'s area ranked past three stays listed in third place', () => {
	const out = run('', `AREAS.list[1].current = nil; AREAS.list[5].current = true
at(1)
emit(rows("areas"))`);
	assert.deepEqual(out.slice(2).map((a) => [a.text, a.on]), [['Red Cloud Mesa  Best', false], ['Near Bael\'dun Digsite, Mulgore', false], ['Thunder Bluff', true]]);
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

test('mined out: "Try <Area> next" first, saying the pick is mined out; its Guide me picks the next; open ground reads "Try near X, Zone, next"', () => {
	const near = run('AREAS.out = { name = "Red Cloud Mesa", from = 3, next = "Near Bael\'dun Digsite, Mulgore", i = 1 }', `at(1)
emit(rows("areas"))`);
	assert.deepEqual([near[2].text, near[2].sub], ['Try near Bael\'dun Digsite, Mulgore, next', 'Red Cloud Mesa is mined out for now']);
	const out = run('AREAS.out = { name = "Red Cloud Mesa", from = 3, next = "The Golden Plains", i = 2 }', `at(1)
local r = rows("areas")
GF.RegionFrame("areas").List[3].psButton:Click()
emit({ r = r, picks = picks })`);
	assert.deepEqual([out.r[2].text, out.r[2].sub, out.r[2].on, out.r[2].button], ['Try The Golden Plains next', 'Red Cloud Mesa is mined out for now', false, 'Guide me']);
	assert.equal(out.r.length, 6);
	assert.deepEqual(out.picks, [[1, 1, 2]]);
});

test('herbs and beasts: Gather it with ~N herbs; Kill and skin it with ~N beasts and their levels; the out line per profession', () => {
	const out = run('w.addMap(1411, { name = "Durotar", c = 1, left = -1962.5, right = -7250, top = 1808.333, bottom = -1716.667 })', `local cs = E.GetGuide().steps[1].goals[1].candidates
cs[1].area, cs[1].map, cs[1].near = "Valley of Trials", 1411, nil
cs[2].area, cs[2].map, cs[2].near = "Razor Hill", 1411, true
AREAS = { verb = "herb", list = { { i = 1, name = "Valley of Trials", count = 14, safeFrom = 1, minutes = 2, best = true, current = true } },
	out = { name = "Near Razor Hill, Durotar", from = 2, next = "Valley of Trials", i = 1 } }
at(1)
local herbs = rows("areas")
AREAS = { verb = "skin", list = { { i = 1, name = "The Golden Plains", count = 22, levels = { min = 1, max = 6 }, safeFrom = 3, minutes = 1, best = true, current = true },
	{ i = 2, name = "Red Cloud Mesa", count = 18, levels = { min = 2, max = 2 }, safeFrom = 1, minutes = 0.4 } },
	out = { name = "Bloodhoof Village", from = 3, next = "The Golden Plains", i = 1 } }
cs[1].area, cs[1].map, cs[1].near = "The Golden Plains", 1412, nil
cs[2].area, cs[2].map, cs[2].near = "Red Cloud Mesa", 1412, nil
cs[3].area, cs[3].map, cs[3].near = "Bloodhoof Village", 1412, true
Polestar.Fire("AREA_CHANGED"); stub.advance(0.5); GF.Layout(); stub.advance(0.5)
emit({ herbs = herbs, skins = rows("areas") })`);
	assert.equal(out.herbs[1].text, 'Gather it');
	assert.deepEqual([out.herbs[2].text, out.herbs[2].sub], ['Try Valley of Trials next', 'Near Razor Hill, Durotar, is picked clean for now']);
	assert.deepEqual([out.herbs[3].text, out.herbs[3].sub], ['Valley of Trials', '~14 herbs  ·  2 min away'], 'one area: no Best mark');
	assert.equal(out.skins[1].text, 'Kill and skin it');
	assert.equal(out.skins[2].sub, 'Near Bloodhoof Village, Mulgore, is hunted out for now');
	assert.deepEqual(out.skins.slice(3).map((a) => [a.text, a.sub]), [
		['The Golden Plains  Best', '~22 beasts (level 1-6)  ·  safe from 3  ·  1 min away'],
		['Red Cloud Mesa', '~18 beasts (level 2)  ·  under a minute away'],
	]);
});

test('a gathering guide\'s get step: only Mine it and its areas, no Auction House way even with one in the data; Mine it carries no Guide me', () => {
	const out = run('', `at(2)
local r = rows("get")
Polestar.Materials.SetWay("test/mining", 2770, "buy"); stub.advance(0.5); Polestar.Fire("AREA_CHANGED"); stub.advance(0.2); GF.Layout(); stub.advance(0.5)
emit({ r = r, picked = rows("get") })`);
	const g = out.r;
	assert.match(g[0].text, /^Get 40 Copper Ore/);
	assert.equal(g[0].sub, false, 'one way: no "Pick one way:"');
	assert.deepEqual([g[1].text, g[1].button, g[1].x], ['Mine it', false, 16], 'its areas carry the buttons');
	assert.deepEqual(g.slice(2).map((a) => [a.text, a.x, a.button]), [['Red Cloud Mesa  Best', 32, 'Guide me'], ['Near Bael\'dun Digsite, Mulgore', 32, 'Guide me'], ['The Golden Plains', 32, 'Guide me']]);
	assert.ok(!g.some((a) => /Auction House/.test(a.text)), 'no Auction House way');
	assert.deepEqual(out.picked.map((a) => a.text), g.map((a) => a.text), 'a saved Auction House pick changes nothing');
});

test('a crafting guide\'s get step (Rough Stone for Blacksmithing): mine or buy; mining taken lists the areas, the way without a button; buying taken, Mine it names the best area and keeps Guide me', () => {
	const out = run('E.SetGuide("test/smithing"); stub.advance(0.5)', `E.SetGuide("test/smithing"); stub.advance(0.5)
at(1)
local mine = rows("get")
Polestar.Materials.SetWay("test/smithing", 2835, "buy"); stub.advance(0.5); Polestar.Fire("AREA_CHANGED"); stub.advance(0.2); GF.Layout(); stub.advance(0.5)
emit({ mine = mine, buy = rows("get") })`);
	const m = out.mine;
	assert.match(m[0].text, /^Get 40 Rough Stone/);
	assert.equal(m[0].sub, 'Pick one way:');
	assert.deepEqual([m[1].text, m[1].on, m[1].button, m[1].icon], ['Mine it', true, false, 'ring'], 'an option: the radio mark, no button over its areas');
	assert.deepEqual(m.slice(2, 5).map((a) => a.text), ['Red Cloud Mesa  Best', 'Near Bael\'dun Digsite, Mulgore', 'The Golden Plains']);
	assert.equal(m[5].text, 'Buy it at the Auction House');
	assert.equal(out.buy.length, 3, 'the item, the two ways');
	assert.deepEqual([out.buy[1].text, out.buy[1].on, out.buy[1].sub, out.buy[1].button], ['Mine it', false, 'Red Cloud Mesa  ·  you\'re here', 'Guide me']);
});

test('each gathering row wears its icon: the profession\'s for the skill goal and the way (Mining\'s pickaxe, Herbalism\'s herb, the Skinning Knife), the location pin for the areas and the next to try', () => {
	const out = run(`C.SpellIcon = function(id) return "spell" .. id end
C.ItemIcon = function(id) return "item" .. id end`, `AREAS.out = { name = "Red Cloud Mesa", from = 3, next = "The Golden Plains", i = 2 }
at(1)
local mine = rows("areas")
AREAS.verb = "herb"; Polestar.Fire("AREA_CHANGED"); stub.advance(0.2); GF.Layout(); stub.advance(0.3)
local herb = rows("areas")
AREAS.verb = "skin"; Polestar.Fire("AREA_CHANGED"); stub.advance(0.2); GF.Layout(); stub.advance(0.3)
local skin = rows("areas")
local KC = Polestar.KindCraft
emit({ mine = mine, herb = herb, skin = skin, fish = KC.GatherIcon("fish") })`);
	const icons = (r) => r.map((a) => a.icon);
	assert.deepEqual(icons(out.mine), ['spell2575', 'spell2575', 'icon-goto-open', 'icon-goto', 'icon-goto-open', 'icon-goto-open'],
		'Raise Mining, Mine it, Try next, the arrow\'s area (filled), the others');
	assert.deepEqual(icons(out.herb).slice(0, 2), ['spell2366', 'spell2366']);
	assert.deepEqual(icons(out.skin).slice(0, 2), ['item7005', 'item7005']);
	assert.equal(out.fish, 'item6256', 'the Fishing Pole');
});

test('every way and area row has its tooltip: the way, the item, its line whole and what a click does; an area its nodes, safe level and how far', () => {
	const out = run('E.SetGuide("test/smithing"); stub.advance(0.5)', `E.SetGuide("test/smithing"); stub.advance(0.5)
local function tip(r)
	GameTooltip:Hide(); GameTooltip.lines = {}
	r:GetScript("OnEnter")(r)
	local t = GameTooltip:IsShown() and table.concat(GameTooltip.lines or {}, " / ") or false
	r:GetScript("OnLeave")(r)
	return t and plain(t) or false
end
local function rowsOf(id)
	local out = {}
	for _, r in ipairs(GF.RegionFrame(id).List) do if r:IsShown() then out[#out + 1] = r end end
	return out
end
at(1)
local get = rowsOf("get")
local smith = { mine = tip(get[2]), area = tip(get[3]), ah = tip(get[6]) }
E.SetGuide("test/mining"); stub.advance(0.5)
at(1)
local areas = rowsOf("areas")
emit({ smith = smith, way = tip(areas[2]), near = tip(areas[4]) })`);
	assert.match(out.smith.mine, /^Mine it/);
	assert.match(out.smith.mine, /Rough Stone/);
	assert.match(out.smith.area, /^Red Cloud Mesa \/ /);
	assert.match(out.smith.area, /~12 veins  ·  you're here/);
	assert.match(out.smith.ah, /^Buy it at the Auction House/);
	assert.match(out.smith.ah, /40 more/);
	assert.match(out.way, /^Mine it/);
	assert.match(out.near, /^Near Bael'dun Digsite, Mulgore/);
	assert.match(out.near, /safe from 8  ·  4 min away/);
	assert.match(out.near, /Click to point the arrow here/);
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
AREAS.list[2].name = "Near the Venture Co. Mine and Bael'dun Digsite, Mulgore"
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
	near = two({ name = "Near Razor Hill, Durotar", near = true, place = "Razor Hill", zone = "Durotar", verb = "mine", items = { 2770, 2835 } }),
	nearHerb = two({ name = "Near Razor Hill, Durotar", near = true, place = "Razor Hill", zone = "Durotar", verb = "herb" }),
	nearSkin = two({ name = "Near Bloodhoof Village, Mulgore", near = true, place = "Bloodhoof Village", zone = "Mulgore", verb = "skin", levels = { min = 1, max = 3 } }),
})`);
	assert.deepEqual(out.near, ['Roam near Razor Hill, Durotar, for Copper Ore and Rough Stone', 'Find Minerals shows them on your minimap']);
	assert.deepEqual(out.nearHerb, ['Roam near Razor Hill, Durotar, for herbs', 'Find Herbs shows them on your minimap']);
	assert.deepEqual(out.nearSkin, ['Roam near Bloodhoof Village, Mulgore, for beasts (level 1-3)', 'Loot, then skin them']);
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
E.AreaRoam = function() return { name = "The Golden Plains", verb = "mine", items = { 2770 } } end
Polestar.Fire("AREA_CHANGED"); stub.advance(0.3)
local second = p.distance:GetText()
roam = false
A:Refresh(); stub.advance(0.3)
emit({ first = first, second = second, plain = p.distance:GetText(), mode = A.GetMode() })`);
	assert.deepEqual(out.first, { mode: 'roam', dist: 'Roam Red Cloud Mesa for Copper Ore', eta: 'Find Minerals shows them on your minimap', w: true });
	assert.equal(out.second, 'Roam The Golden Plains for Copper Ore');
	assert.deepEqual([out.mode, out.plain], ['arrived', 'Arrived'], 'outside the roam state: Arrived again');
});

// Through the real Engine (no stand-ins): Guide me on an area row is the player's pick, the arrow leads there, and
// the pick is kept per character and guide step across a guide switch and a reload (the saved variables of the
// first session restored into a second).
const box = (x1, y1, x2, y2) => `${x1},${y1};${x2},${y1};${x2},${y2};${x1},${y2}`;
const realArea = (name, lvl, [x1, y1, x2, y2], extra = '') =>
	`{ map = 1412, x = ${(x1 + x2) / 2}, y = ${(y1 + y2) / 2}, faction = "H", lvl = { min = ${lvl}, max = ${lvl} }, lap = 300, yield = 10, count = 12, area = "${name}", poly = "${box(x1, y1, x2, y2)}"${extra} }`;
const REAL = [realArea('Red Cloud Mesa', 1, [40, 78, 50, 90], ', starter = true, items = "2770"'), realArea('Skywatcher Plateau', 1, [20, 30, 28, 40]),
	realArea('Bael\'dun Digsite', 3, [28, 44, 36, 52], ', near = true, items = "2770"')];
const realRun = (saved, body) => runAddon({
	stubs: ['stub_world.lua'],
	before: `
local w = stub.world
w.addMap(1412, { name = "Mulgore", c = 1, left = 0, right = -5000, top = 0, bottom = -5000 })
w.race, w.raceName, w.faction = "Tauren", "Tauren", "Horde"
w.level = 8
w.moveTo(1412, 45, 84)`,
	addons: ['Polestar'],
	saved: saved ? { Polestar: saved } : undefined,
	script: `Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("nav.travel", false)
Polestar.Nav.danger.ZoneAt = function() return 1412 end
Polestar.Maps.GetZoneLevels = function(id) if id == 1412 then return 1, 10, 1 end end
Polestar.RegisterGuide({ id = "test/areas", pack = "test", title = "Mining", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Mine 140 Copper Ore", goals = { { t = "collect", item = 2770, itemName = "Copper Ore", count = 140, gather = { rank = 1, skill = "Mining", skillLine = 186 }, candidates = { ${REAL.join(', ')} } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/other", pack = "test", title = "Other", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Bolts", goals = { { t = "craft", spell = 2964, spellName = "Bolt of Woolen Cloth", item = 2997, itemName = "Bolt of Woolen Cloth", skillLine = 197, count = 1 } } } } })
E = Polestar.Engine
N = Polestar.Nav
local itemName = Polestar.Compat.GetItemName
Polestar.Compat.GetItemName = function(id) if id == 2770 then return "Copper Ore" end return itemName(id) end
stub.login()
Polestar.Set("ui.shown", true)
E.SetGuide("test/areas")
stub.advance(0.6)
GF = Polestar.UI.GuideFrame
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) or s end
function areaRows()
	Polestar.Fire("AREA_CHANGED"); stub.advance(0.2); GF.Layout(); stub.advance(0.3)
	local out = {}
	for _, r in ipairs(GF.RegionFrame("get").List) do
		if r:IsShown() and r.psArea then out[#out + 1] = { name = plain(r.Text:GetText()):gsub("  Best$", ""), on = tostring(r.Icon:GetTexture() or ""):find("icon%-goto$") ~= nil, row = r } end
	end
	return out
end
function dump(v, ind)
	if type(v) == "string" then return string.format("%q", v) end
	if type(v) ~= "table" then return tostring(v) end
	local parts = {}
	for k, x in pairs(v) do
		if type(x) ~= "function" then parts[#parts + 1] = "[" .. (type(k) == "string" and string.format("%q", k) or tostring(k)) .. "] = " .. dump(x) end
	end
	return "{ " .. table.concat(parts, ", ") .. " }"
end
${body}`,
}).emitted[0];

test('the real Engine: Guide me picks the area and leads the arrow there; the pick holds across a guide switch and a reload', () => {
	const first = realRun(null, `
-- Inside the arrow's area (open ground near Bael'dun Digsite): the roam line names it mid-sentence.
stub.world.moveTo(1412, 32, 48); stub.advance(1.5); N.arrow:Refresh(); stub.advance(0.3)
local roamText = N.arrow.skinParts.distance:GetText()
stub.world.moveTo(1412, 45, 84); stub.advance(1.5)
local rows = areaRows()
local before = {}
for i, r in ipairs(rows) do before[i] = r.name .. (r.on and "*" or "") end
local sky
for _, r in ipairs(rows) do if r.name == "Skywatcher Plateau" then sky = r.row end end
sky.psButton:Click(); stub.advance(0.6)
local v = E.AreaChoices(1, 1)
local cur
for _, a in ipairs(v.list) do if a.current then cur = a.name end end
local t = N.GetTarget()
local after = {}
for i, r in ipairs(areaRows()) do after[i] = r.name .. (r.on and "*" or "") end
E.SetGuide("test/other"); stub.advance(0.6); E.SetGuide("test/areas"); stub.advance(0.6)
local back = {}
for i, r in ipairs(areaRows()) do back[i] = r.name .. (r.on and "*" or "") end
emit({ roam = roamText or false, before = table.concat(before, "|"), current = cur or false, target = t and t.stepIndex == 1 and t.goalIndex == 1 or false,
	after = table.concat(after, "|"), back = table.concat(back, "|"), saved = "PolestarCharDB = " .. dump(PolestarCharDB) })`);
	assert.equal(first.before, 'Near Bael\'dun Digsite, Mulgore*|Skywatcher Plateau', 'the best first with the filled pin; Red Cloud Mesa\'s starter area outgrown at level 8');
	assert.equal(first.current, 'Skywatcher Plateau', 'Guide me is the Engine\'s pick');
	assert.equal(first.roam, 'Roam near Bael\'dun Digsite, Mulgore, for Copper Ore', 'the roam line through the real Engine and Nav');
	assert.equal(first.target, true, 'the arrow leads to the step\'s area goal');
	assert.match(first.after, /Skywatcher Plateau\*/);
	assert.match(first.back, /Skywatcher Plateau\*/, 'kept across a guide switch');
	const second = realRun(first.saved, `
E.SetGuide("test/areas"); stub.advance(0.6)
local back = {}
for i, r in ipairs(areaRows()) do back[i] = r.name .. (r.on and "*" or "") end
emit({ back = table.concat(back, "|") })`);
	assert.match(second.back, /Skywatcher Plateau\*/, 'kept across a reload');
});
