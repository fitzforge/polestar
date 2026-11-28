'use strict';
// A profession guide's rows wear the game's own art and hover as what they stand for (UI/GuideFrame.lua GF.GoalIcon,
// goalTooltip; UI/GuideFrameKindCraft.lua; Core/KindCraft.lua): a learn-the-profession row its profession's icon, a
// cast its spell's, a use or equip its item's, a station (anvil, forge) the game's station art, a skill-only step its
// skill row with the profession's icon; the cast row the spell's tooltip and no row a raw id; a smelt reads "Smelt
// Copper Bar"; the skill line wears the profession's icon; "Next step:" names the next step; the shopping list's met
// rows step back and its count turns success; a step whose goals are all left out keeps its title; a profession
// guide's tab, list row and Lookup subtitle carry no level range and the profession's own icon.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const MINING = `{ id = "test/mining", pack = "test", title = "Mining 1-300", minLevel = 1, maxLevel = 60, category = "Professions",
	zone = 947, zoneName = "Azeroth",
	sections = { { skill = "Mining", skillLine = 186, from = 1, to = 65 } },
	steps = {
		{ title = "Learn Mining", section = 1, goals = { { t = "train", skill = "Mining", skillLine = 186, rank = 1, rankMax = 75, npc = 3357, npcName = "Makaru", map = 1429, x = 50, y = 50 } } },
		{ title = "Turn on Find Minerals · Professions tab (K by default)", section = 1, goals = { { t = "cast", spell = 2580, spellName = "Find Minerals" } } },
		{ title = "Use the recipe", section = 1, goals = { { t = "use", item = 6057, itemName = "Recipe: Nature Protection Potion" }, { t = "equip", item = 6256, itemName = "Fishing Pole" } } },
		{ title = "Go to a forge", section = 1, goals = { { t = "goto", text = "Forge", map = 1429, x = 40, y = 40 } } },
		{ title = "Go to an anvil", section = 1, goals = { { t = "goto", text = "Anvil", map = 1429, x = 41, y = 41 } } },
		{ title = "Go to Uldaman", section = 1, goals = { { t = "goto", text = "Uldaman", map = 1429, x = 42, y = 42 } } },
		{ title = "Mine Chunk of Amber and Copper until 65", section = 1, note = "Only if the smelting left you short of 65.", goals = { { t = "skill", skill = "Mining", skillLine = 186, level = 65 } } },
		{ title = "Smelt 10 Copper Bars · Professions tab (K by default)", section = 1, goals = { { t = "craft", spell = 2657, spellName = "Smelt Copper", item = 2840, itemName = "Copper Bar", skillLine = 186, count = 10,
			reagents = { { item = 2770, itemName = "Copper Ore", count = 1 } } } } },
		{ title = "Hand in A Blue Light Bargain", section = 1, goals = { { t = "turnin", quest = 7651, title = "A Blue Light Bargain", direct = true, minLevel = 50, npc = 14, npcName = "Someone", map = 1429, x = 30, y = 30 } } },
		{ title = "Buy a Mining Pick", section = 1, goals = { { t = "buy", item = 2901, itemName = "Mining Pick", count = 1, npc = 1250, npcName = "Rachel", map = 1429, x = 45, y = 45 } } },
		{ title = "Craft 5 Bolts of Woolen Cloth", section = 1, goals = { { t = "craft", spell = 2964, spellName = "Bolt of Woolen Cloth", item = 2997, itemName = "Bolt of Woolen Cloth", skillLine = 197, count = 5,
			reagents = { { item = 2592, itemName = "Wool Cloth", count = 3 } } } } },
	} }`;

const LEVELING = `{ id = "test/level", pack = "test", title = "Elwynn Forest", minLevel = 1, maxLevel = 10, zone = 1429, zoneName = "Elwynn Forest",
	steps = { { title = "Cast it", goals = { { t = "cast", spell = 2580, spellName = "Find Minerals" } } } } }`;

const run = (body) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(24)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide(${MINING})
Polestar.RegisterGuide(${LEVELING})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local C = Polestar.Compat
C.GetSkillRank = function(line) if line == 186 or line == "Mining" then return 20, 75 end return nil end
C.GetSkillLineName = function(line) return line == 186 and "Mining" or nil end
C.SpellIcon = function(id) return "spell" .. tostring(id) end
C.ItemIcon = function(id) return "item" .. tostring(id) end
GameTooltip.SetSpellByID = function(self, id) self.lines = { "spell tooltip " .. id } end
local E, GF, UI, Theme = Polestar.Engine, Polestar.UI.GuideFrame, Polestar.UI, Polestar.Theme
E.SetGuide("test/mining")
stub.advance(1)
local function at(n) E.Goto(n); stub.advance(0.5); GF.Render(); GF.Layout(); stub.advance(0.5) end
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\\194\\160", " ")) or s end
-- The card's goal rows and the regions' rows shown: { t, text, icon }.
local function rows()
	local out = {}
	for _, f in ipairs(GF.CardItems()) do
		if f:IsShown() and f.Text and f.psGoal then out[#out + 1] = { t = f.psGoal.t, text = plain(f.Text:GetText()), icon = tostring(f.Icon:GetTexture()) } end
	end
	local s = GF.RegionFrame("stretch")
	if s and s:IsShown() and s.Row:IsShown() then out[#out + 1] = { t = s.Row.psGoal.t, text = plain(s.Row.Text:GetText()), icon = tostring(s.Row.Icon:GetTexture()), region = "stretch" } end
	return out
end
local function hover(f)
	GameTooltip:Hide(); GameTooltip.lines = {}
	f:GetScript("OnEnter")(f)
	return table.concat(GameTooltip.lines or {}, " / ")
end
local function rowOf(t)
	for _, f in ipairs(GF.CardItems()) do if f:IsShown() and f.psGoal and f.psGoal.t == t then return f end end
end
local function same(fs, token)
	local r, g, b = fs:GetTextColor()
	local tr, tg, tb = Theme.Color(token)
	return math.abs(r - tr) < 0.01 and math.abs(g - tg) < 0.01 and math.abs(b - tb) < 0.01
end
${body}` }).emitted;

test('every row kind of a profession guide wears the game\'s own art; a named place keeps the pin', () => {
	const [out] = run(`
local icons = {}
-- Mining not learned yet: its learn step is open.
local rank = C.GetSkillRank
C.GetSkillRank = function() return nil end
at(1)
for _, r in ipairs(rows()) do icons[#icons + 1] = "1 " .. r.t .. " " .. r.icon end
C.GetSkillRank = rank
for _, n in ipairs({ 2, 3, 4, 5, 6, 8 }) do
	at(n)
	for _, r in ipairs(rows()) do icons[#icons + 1] = n .. " " .. r.t .. " " .. r.icon end
end
local meter = GF.RegionFrame("meter").Glyph:GetTexture()
E.SetGuide("test/level"); stub.advance(1); at(1)
local level = rows()[1] and rows()[1].icon
emit({ icons = icons, meter = tostring(meter), level = level })`);
	const has = (s) => assert.ok(out.icons.includes(s), `${s} in ${out.icons.join(' | ')}`);
	has('1 train spell2575'); // Learn Mining: Mining's own icon
	has('2 cast spell2580'); // Find Minerals' icon
	has('3 use item6057'); // the recipe scroll
	has('3 equip item6256'); // the Fishing Pole
	has('4 goto spell2656'); // a forge: Smelting's flame
	has('5 goto Interface\\Minimap\\Tracking\\Repair'); // an anvil: the minimap's anvil
	assert.ok(out.icons.some((s) => /^6 goto .*icon-goto$/.test(s)), 'Uldaman keeps the pin');
	has('8 craft item2840'); // the bar it smelts
	assert.equal(out.meter, 'spell2575', 'the skill line wears Mining\'s icon, not the bar chart');
	assert.match(out.level, /icon-use$/, 'a leveling guide\'s cast keeps its glyph');
});

test('a skill-only step shows its skill row with the profession\'s icon, no separate title', () => {
	const [out] = run(`
at(7)
emit({ rows = rows(), person = GF.parts.person:IsShown() })`);
	const row = out.rows.find((r) => r.region === 'stretch');
	assert.ok(row, `a row in the stretch region: ${JSON.stringify(out.rows)}`);
	assert.match(row.text, /^Raise Mining to 65/);
	assert.equal(row.icon, 'spell2575');
	assert.equal(out.person, false, 'no title over it, as an area step');
	assert.equal(out.rows.length, 1, 'the row once');
});

test('a smelt reads "Smelt Copper Bar", another craft names the item it makes', () => {
	const [out] = run(`
at(8); local smelt = rows()[1].text
at(11); local bolt = rows()[1].text
emit({ smelt = smelt, bolt = bolt })`);
	assert.match(out.smelt, /^Smelt Copper Bar/);
	assert.doesNotMatch(out.smelt, /Smelt Copper(?! Bar)/);
	assert.match(out.bolt, /^Craft Bolt of Woolen Cloth/);
});

test('tooltips: a cast hovers as its spell, a craft as its item; no row shows a raw id', () => {
	const [out] = run(`
at(2); local cast = hover(rowOf("cast"))
at(8); local craft = hover(rowOf("craft"))
emit({ cast = cast, craft = craft })`);
	assert.match(out.cast, /^spell tooltip 2580/);
	assert.doesNotMatch(out.cast, /#2580/);
	assert.doesNotMatch(out.craft, /#2657/, out.craft);
});

test('"Next step:" names the next step itself in a profession guide', () => {
	const [out] = run(`
at(1)
emit(plain(GF.parts.after.Text:GetText()))`);
	assert.equal(out, 'Next step: Turn on Find Minerals');
});

test('a step whose goals are all left out for the character keeps its title', () => {
	const [out] = run(`
at(9)
emit({ person = GF.parts.person:IsShown(), name = plain(GF.parts.person.Name:GetText()) })`);
	assert.equal(out.person, true);
	assert.match(out.name, /Hand in A Blue Light Bargain/);
});

test('the shopping list: a met row steps back, the count turns success once all are met, a row hovers as its item', () => {
	const [out] = run(`
w.items[2901] = 1
GF.KindHas = function() return true end
at(10)
local f = GF.RegionFrame("shopping")
stub.RunScript(f.Head, "OnClick"); stub.advance(0.2); GF.Layout()
local row = f.Rows[1]
emit({ shown = f:IsShown(), right = f.Head.Right:GetText(), success = same(f.Head.Right, "success"), name = row.Name:GetText(),
	muted = same(row.Name, "textMuted"), tip = hover(row) })`);
	assert.equal(out.shown, true);
	assert.equal(out.right, '1 / 1');
	assert.equal(out.success, true);
	assert.equal(out.name, 'Mining Pick', 'no item colour over the muted name');
	assert.equal(out.muted, true);
	assert.match(out.tip, /1 \/ 1/);
});

test('a profession guide\'s tab and list carry no level range and wear the profession\'s icon; Lookup says Professions', () => {
	const [out] = run(`
local b = {}
GF.TabFacts(b, { guideId = "test/mining" })
local l = {}
GF.TabFacts(l, { guideId = "test/level" })
local sub
for _, r in ipairs(Polestar.Search.Query("Mining", {}) or {}) do if r.kind == "guide" and r.id == "test/mining" then sub = r.subtitle end end
emit({ range = b.psRange or false, art = b.psArt or false, levelRange = l.psRange or false, levelArt = l.psArt or false,
	listArt = UI.GuideArt(Polestar.Guides.Get("test/mining")) or false, sub = sub or false })`);
	assert.equal(out.range, false);
	assert.equal(out.art, 'spell2575');
	assert.equal(out.levelRange, '(1–10)');
	assert.equal(out.levelArt, false);
	assert.equal(out.listArt, 'spell2575');
	assert.equal(out.sub, 'Professions · 1-60');
});
