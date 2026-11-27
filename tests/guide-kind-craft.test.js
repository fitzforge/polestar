'use strict';
// The profession and reputation kinds' regions (Core/KindCraft.lua, UI/GuideFrameKindCraft.lua; docs/ARCHITECTURE.md,
// "Guide kind regions"): a profession guide reads as steps drawn as the leveling view's goal rows. The slim skill
// line; a get step's "Get 265 Wool Cloth" with a row per way (farm it, the Auction House, a vendor), picked like an
// option; a craft step's "Craft Woolen Cape until 115" with the client's skill-up arrow, the crafts to go and Open
// Tailoring; a train step's own rows; the folded shopping list. A reputation guide shows its standing, the turn-in
// and More reputation.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const PROFESSION = `{ id = "test/craft", pack = "test", title = "Tailoring 1-300", minLevel = 5, maxLevel = 60, category = "Professions",
	sections = { { skill = "Tailoring", skillLine = 197, from = 75, to = 150 } },
	steps = {
		{ title = "Get Wool Cloth", section = 1, note = "Wool Cloth drops from humanoids of level 15-30. The arrow takes you to the best farm for your level.", goals = {
			{ t = "collect", item = 2592, itemName = "Wool Cloth", count = 288, gather = { min = 15, max = 30 } },
			{ t = "auction", item = 2592, itemName = "Wool Cloth", count = 288 } } },
		{ title = "Coarse Thread", section = 1, goals = { { t = "buy", item = 2320, itemName = "Coarse Thread", count = 72, npc = 1250, npcName = "Rachel" } } },
		{ title = "Bolts", section = 1, goals = { { t = "craft", spell = 2964, spellName = "Bolt of Woolen Cloth", item = 2997, itemName = "Bolt of Woolen Cloth", skillLine = 197, count = 30,
			reagents = { { item = 2592, itemName = "Wool Cloth", count = 3 } } } } },
		{ title = "Woolen Cape to 115", section = 1, goals = { { t = "craft", spell = 2402, spellName = "Woolen Cape", item = 2580, itemName = "Woolen Cape", skillLine = 197,
			untilSkill = 115, yellow = 100, grey = 125,
			reagents = { { item = 2997, itemName = "Bolt of Woolen Cloth", count = 3 }, { item = 2320, itemName = "Coarse Thread", count = 2 } } } } },
		{ title = "Expert Tailoring", section = 1, goals = { { t = "level", level = 20 }, { t = "train", skill = "Tailoring", skillLine = 197, rank = 3, rankMax = 225 } } },
		{ title = "Get Strange Dust", section = 1, goals = {
			{ t = "collect", item = 10940, itemName = "Strange Dust", count = 25, gather = { skill = "Enchanting", skillLine = 333, rank = 1, min = 1, max = 20 } },
			{ t = "auction", item = 10940, itemName = "Strange Dust", count = 25 } } },
	} }`;

const script = (setup, body, guide = PROFESSION, id = 'test/craft') => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(24)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide(${guide})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local C = Polestar.Compat
C.GetSkillRank = function(line) if line == 197 or line == "Tailoring" then return 87, 150 end return nil end
C.GetSkillLineName = function(line) return line == 197 and "Tailoring" or nil end
w.items[2592] = 58; w.bank[2592] = 10; w.items[2997] = 10; w.items[2320] = 12
local E = Polestar.Engine
-- The farm spot's numbers (Own.farmView over the guide's spawns): 200 minutes for what the step still needs, at
-- Blackrock Grunts in Elwynn Forest.
E.KindAccess.farm = function(goal) if goal.item == 2592 then return { minutes = 200, kills = 1652 } end end
E.KindAccess.chosen = function(goal) if goal.item == 2592 and goal.t == "collect" then return { npc = 436, npcName = "Blackrock Grunt", map = 1429 } end end
${setup}
E.SetGuide(${JSON.stringify(id)})
stub.advance(1)
local GF = Polestar.UI.GuideFrame
local function at(n) E.Goto(n); stub.advance(0.5) end
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\\194\\160", " ")) or s end
${body}`;

const run = (setup, body, guide, id) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(setup, body, guide, id) }).emitted[0];

// The get region's rows as the window shows them: the item's, then its ways.
const GET_ROWS = `
local function getRows()
	local f, out = GF.RegionFrame("get"), {}
	for _, r in ipairs(f and f.List or {}) do
		if r:IsShown() then
			out[#out + 1] = { text = plain(r.Text:GetText()), sub = r.Sub:IsShown() and plain(r.Sub:GetText()) or false, way = r.psWay and r.psWay.way or false,
				on = r.psDot and r.psDot:IsShown() or false, button = r.psButton and r.psButton:IsShown() and r.psButton.Label:GetText() or false }
		end
	end
	return out
end`;

test('the models: the slim skill, no trainer line, a get step\'s ways, the section\'s shopping list', () => {
	const out = run('', `
local view = E.GetStepView(E.GetStepIndex())
local meter, get, shop = E.KindModel("meter", view, "profession"), E.KindModel("get", view, "profession"), E.KindModel("shopping", view, "profession")
local it = get.items[1]
local ways = {}
for _, w in ipairs(it.ways) do ways[#ways + 1] = { way = w.way, current = w.current, verb = w.verb or false, npc = w.npc or false, minutes = w.minutes or false, rate = w.rate or false, toGet = w.toGet or false } end
local rows = {}
for _, r in ipairs(shop.rows) do rows[#rows + 1] = { item = r.item, need = r.need, have = r.have, way = r.way } end
emit({ meter = { value = meter.value, max = meter.max, learned = meter.learned, ticks = meter.ticks or false, line = meter.line or false },
	trainer = E.KindModel("trainer", view, "profession") or false, stretch = E.KindModel("stretch", view, "profession") or false,
	item = { need = it.need, have = it.have, done = it.done }, ways = ways, covers = get.covers, rows = rows, buy = shop.buy })`);
	assert.deepEqual(out.meter, { value: 87, max: 150, learned: true, ticks: false, line: false });
	assert.equal(out.trainer, false, 'training is a step of its own');
	assert.equal(out.stretch, false, 'the craft row belongs to the craft step');
	// 265 of the step's 288 once the crafts made to 87 are counted; 58 in the bags.
	assert.deepEqual(out.item, { need: 265, have: 58, done: false });
	// Mix buys a farm longer than 45 minutes: the Auction House is the way taken.
	assert.deepEqual(out.ways, [
		{ way: 'gather', current: false, verb: 'farm', npc: 'Blackrock Grunt', minutes: 200, rate: 62, toGet: false },
		{ way: 'buy', current: true, verb: false, npc: false, minutes: false, rate: false, toGet: 197 },
	]);
	assert.deepEqual(out.covers, [1, 2]);
	assert.deepEqual(out.rows.map((r) => [r.item, r.need, r.way]), [[2592, 265, 'buy'], [2320, 48, 'vendor'], [10940, 25, 'buy']]);
	assert.deepEqual(out.buy.map((b) => [b.item, b.count]), [[2592, 197], [10940, 25]]);
});

test('a get step in the window: the item\'s row with its count once, a row per way picked like an option', () => {
	const out = run('', `${GET_ROWS}
GF.Layout(); stub.advance(1)
local function shown(id) local f = GF.RegionFrame(id); return f and f:IsShown() or false end
emit({ regions = { meter = shown("meter"), stretch = shown("stretch"), get = shown("get"), shopping = shown("shopping") },
	person = GF.parts.person:IsShown(), rows = getRows(), meter = { name = GF.RegionFrame("meter").Name:GetText(), value = GF.RegionFrame("meter").Value:GetText(),
	max = GF.RegionFrame("meter").Max:GetText(), h = GF.RegionFrame("meter"):GetHeight() } })`);
	assert.deepEqual(out.regions, { meter: true, stretch: false, get: true, shopping: true });
	assert.equal(out.person, false, 'the get rows stand for every goal of the step');
	assert.deepEqual(out.meter, { name: 'Tailoring', value: '87', max: '/ 150', h: 26 }, 'one slim line');
	assert.equal(out.rows.length, 3);
	assert.match(out.rows[0].text, /^Get 265 Wool Cloth +58\/265$/);
	assert.equal(out.rows[0].sub, 'Pick one way:');
	assert.deepEqual(out.rows[1], { text: 'Farm it', sub: 'Blackrock Grunt  ·  Elwynn Forest  ·  about 62 an hour', way: 'gather', on: false, button: 'Guide me' });
	assert.deepEqual(out.rows[2], { text: 'Buy it at the Auction House', sub: '197 more', way: 'buy', on: true, button: 'Buy list' });
});

test('a way row\'s click picks it: the item takes that way and the arrow follows its goal', () => {
	const out = run('', `${GET_ROWS}
GF.Layout(); stub.advance(1)
local farm = GF.RegionFrame("get").List[2]
farm:Click()
stub.advance(0.5); GF.Layout(); stub.advance(0.5)
local _, _, pick = Polestar.Materials.Mode("test/craft", 2592)
local view = E.GetStepView(E.GetStepIndex())
emit({ pick = pick or false, rows = getRows(), applies = view.goals[1].status ~= "na", auction = view.goals[2].status, pad = farm.psPadLabel })`);
	assert.equal(out.pick, 'gather');
	assert.equal(out.applies, true, 'the farm goal applies now');
	assert.equal(out.auction, 'na');
	assert.deepEqual([out.rows[1].on, out.rows[2].on], [true, false]);
	assert.equal(out.pad, 'Guide me');
});

test('a short farm says the minutes for the rest; a disenchant way says the green items\' levels', () => {
	const short = run('E.KindAccess.farm = function(goal) if goal.item == 2592 then return { minutes = 30, kills = 200 } end end', `${GET_ROWS}
GF.Layout(); stub.advance(1)
emit({ rows = getRows() })`);
	assert.equal(short.rows[1].sub, 'Blackrock Grunt  ·  Elwynn Forest  ·  about 30 min for the rest');
	assert.equal(short.rows[1].on, true, 'Mix farms a short farm');
	const dust = run('', `${GET_ROWS}
at(6); GF.Layout(); stub.advance(1)
emit({ rows = getRows() })`);
	assert.match(dust.rows[0].text, /^Get 25 Strange Dust/);
	assert.deepEqual([dust.rows[1].text, dust.rows[1].sub, dust.rows[1].button], ['Disenchant green armour', 'Requires Level 1-20', false]);
	assert.equal(dust.rows[2].text, 'Buy it at the Auction House');
});

test('Self-Found: no Auction House way; a vendor step reads "Buy it from Rachel" with Guide me', () => {
	const sf = run('C_PlayerInfo = C_PlayerInfo or {}; C_PlayerInfo.IsSelfFoundActive = function() return true end', `${GET_ROWS}
GF.Layout(); stub.advance(1)
emit({ rows = getRows() })`);
	assert.equal(sf.rows.length, 2, 'the item and its one way');
	assert.equal(sf.rows[0].sub, false, 'one way: nothing to pick');
	assert.equal(sf.rows[1].way, 'gather');
	const vendor = run('', `${GET_ROWS}
at(2); GF.Layout(); stub.advance(1)
emit({ rows = getRows(), person = GF.parts.person:IsShown() })`);
	assert.match(vendor.rows[0].text, /^Get 48 Coarse Thread +12\/48$/, 'the thread the crafts made to 87 used is left out');
	assert.equal(vendor.rows[1].text, 'Buy it from Rachel');
	assert.equal(vendor.rows[1].way, 'vendor');
	assert.equal(vendor.person, false);
});

test('a craft step: one row, the recipe\'s icon, "Craft Woolen Cape until 115", the crafts to go and Open Tailoring', () => {
	const out = run('', `
at(4); GF.Layout(); stub.advance(1)
local f = GF.RegionFrame("stretch")
local r = f.Row
emit({ shown = f:IsShown(), text = plain(r.Text:GetText()), sub = plain(r.Sub:GetText()), open = r.psOpen:IsShown() and r.psOpen.Label:GetText() or false,
	person = GF.parts.person:IsShown(), get = GF.RegionFrame("get") and GF.RegionFrame("get"):IsShown() or false })`);
	assert.equal(out.shown, true);
	assert.match(out.text, /^Craft Woolen Cape until 115/);
	assert.equal(out.sub, 'about 36 to go');
	assert.equal(out.open, 'Open Tailoring');
	assert.equal(out.person, false, 'the craft row stands for the step');
	assert.equal(out.get, false);
});

test('crafts made are the recipe\'s casts counted, after what the skill still takes ("about 36 to go · 2 made")', () => {
	const out = run('', `
stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", 2402)
stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-2", 2402)
stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-3", 2964)
stub.advance(0.5)
at(4); GF.Layout(); stub.advance(1)
local m = E.KindModel("stretch", E.GetStepView(4), "profession")
emit({ made = m.made, left = m.left, sub = plain(GF.RegionFrame("stretch").Row.Sub:GetText()) })`);
	assert.equal(out.made, 2, 'Woolen Cape cast twice; the bolt is another recipe');
	assert.equal(out.left, 36);
	assert.match(out.sub, /^about 36 to go +· +2 made$/);
});

const ATLAS_ART = `C_Texture = { GetAtlasInfo = function(name)
	if name == "Professions-Icon-Skill-High" or name == "Professions-Icon-Skill-Medium" or name == "Professions-Icon-Skill-Low" then
		return { width = 13, height = 15, file = 4417031 } end end }`;
const CRAFT_TEXT = `
at(4); GF.Layout(); stub.advance(1)
emit({ text = GF.RegionFrame("stretch").Row.Text:GetText() })`;

test('the recipe\'s colour is the client\'s own skill-up arrow after its name; our chevron where the client has none; none for grey', () => {
	const art = run(ATLAS_ART, CRAFT_TEXT);
	assert.match(art.text, /\|A:Professions-Icon-Skill-High:15:13\|a/, 'orange at 87, below yellow (100)');
	const own = run('', CRAFT_TEXT);
	assert.match(own.text, /\|T[^|]*chevron-up[^|]*\|t/);
	const yellow = run(`${ATLAS_ART}; C.GetSkillRank = function(line) if line == 197 or line == "Tailoring" then return 105, 150 end return nil end`, CRAFT_TEXT);
	assert.match(yellow.text, /Professions-Icon-Skill-Medium/);
	const grey = run(`${ATLAS_ART}
GetSpellInfo = function(id) if id == 2402 then return "Woolen Cape" end end
C_Spell = nil
GetNumTradeSkills = function() return 1 end
GetTradeSkillInfo = function(i) return "Woolen Cape", "trivial" end`, CRAFT_TEXT);
	assert.doesNotMatch(grey.text, /\|A:|\|T/, 'the trade skill window says grey: no arrow');
});

test('Open Tailoring: the click is a secure spell button outside the guide window, over the row\'s button', () => {
	const out = run('', `
at(4); GF.Layout(); stub.advance(1)
local slot = GF.RegionFrame("stretch").Row.psOpen
slot:GetScript("OnUpdate")(slot, 1)
local b = _G.PolestarOpenProfession
local under = false
local p = b and b:GetParent()
while p do if p == GF.frame then under = true end p = p:GetParent() end
emit({ shown = slot:IsShown(), text = slot.Label:GetText(), secure = b ~= nil, under = under, spell = b and b:GetAttribute("spell") or false })`);
	assert.deepEqual(out, { shown: true, text: 'Open Tailoring', secure: true, under: false, spell: 'Tailoring' });
});

test('a skill not learned yet: "Not learned yet" on the skill line; the craft row says to learn it first, no Open button', () => {
	const out = run('C.GetSkillRank = function() return nil end', `
GF.Layout(); stub.advance(1)
local meter = GF.RegionFrame("meter")
local line = { name = meter.Name:GetText(), value = meter.Value:GetText(), max = meter.Max:GetText(), bar = meter.Bar:IsShown() }
at(4); GF.Layout(); stub.advance(1)
local r = GF.RegionFrame("stretch").Row
emit({ line = line, sub = plain(r.Sub:GetText()), open = r.psOpen:IsShown(), text = plain(r.Text:GetText()) })`);
	assert.deepEqual(out.line, { name: 'Tailoring', value: '', max: 'Not learned yet', bar: false });
	assert.equal(out.sub, 'Learn Tailoring first');
	assert.equal(out.open, false);
	assert.doesNotMatch(out.text, /\|A:|\|T/, 'no colour before it is learned');
});

test('a train step is the step\'s own rows (the trainer, the arrow on them); its tip is one line, the rest in its tooltip', () => {
	const out = run('', `
at(5); GF.Layout(); stub.advance(1)
local person, tip = GF.parts.person, GF.parts.tip
local trainLine = GF.RegionFrame("trainer") ~= nil
at(1); GF.Layout(); stub.advance(1)
tip = GF.parts.tip
local open = GF.TipOpen()
tip:Click()
stub.advance(0.2)
tip:GetScript("OnEnter")(tip)
emit({ person = person:IsShown() or false, trainLine = trainLine, tipShown = tip:IsShown(), toggle = tip.Toggle:IsShown(), wraps = tip.psOpen,
	stillShut = GF.TipOpen() == open, tooltip = GameTooltip:IsShown() and GameTooltip:GetOwner() == tip and GameTooltip.lines and GameTooltip.lines[1] or false })`);
	assert.equal(out.trainLine, false, 'no trainer line: training is a step');
	assert.equal(out.tipShown, true);
	assert.equal(out.toggle, false, 'no expander');
	assert.equal(out.wraps, false, 'one line');
	assert.equal(out.stillShut, true, 'a click does not open it');
	assert.match(String(out.tooltip), /^Wool Cloth drops from humanoids of level 15-30\. The arrow/);
});

test('a train step shows its own header and rows in the step\'s place', () => {
	const out = run('', `
at(5); GF.Layout(); stub.advance(1)
local texts = {}
for _, f in ipairs(GF.CardItems()) do if f:IsShown() and f.Text and f.psGoal then texts[#texts + 1] = plain(f.Text:GetText()) end end
emit({ person = GF.parts.person:IsShown(), texts = texts })`);
	assert.equal(out.person, true);
	assert.ok(out.texts.some((t) => /^Learn Expert Tailoring/.test(t)), out.texts.join(' | '));
});

test('the shopping list: one folded row; opened, the section\'s materials and Buy the whole list', () => {
	const out = run('', `
GF.Layout(); stub.advance(1)
local f = GF.RegionFrame("shopping")
local folded = { right = f.Head.Right:GetText(), rows = f.psN, buy = f.Buy:IsShown() }
f.Head:Click()
stub.advance(0.5); GF.Render(); GF.Layout(); stub.advance(0.5)
local rows = {}
for i = 1, f.psN do rows[i] = { name = plain(f.Rows[i].Name:GetText()), count = f.Rows[i].Count:GetText() } end
local tile = f.Rows[1].Tile
tile:GetScript("OnEnter")(tile)
local itemOn = GameTooltip:IsShown() and GameTooltip:GetOwner() == tile
tile:GetScript("OnLeave")(tile)
emit({ folded = folded, head = f.Head.Text:GetText(), rows = rows, buy = f.Buy:IsShown() and f.Buy.Label:GetText() or false,
	itemOn = itemOn, itemAfter = GameTooltip:IsShown() and GameTooltip:GetOwner() == tile })`);
	assert.deepEqual(out.folded, { right: '0 / 3', rows: 0, buy: false });
	assert.equal(out.head, 'Shopping list');
	assert.deepEqual(out.rows.map((r) => r.count), ['68 / 265', '12 / 48', '0 / 25']);
	assert.equal(out.buy, 'Buy the whole list');
	assert.deepEqual([out.itemOn, out.itemAfter], [true, false], 'the game\'s item tooltip goes as the cursor leaves');
});

test('compact: the skill line and the item\'s row, no ways and no shopping list', () => {
	const out = run('Polestar.Set("ui.compact", true)', `${GET_ROWS}
GF.Layout(); stub.advance(1)
emit({ meter = GF.RegionFrame("meter"):IsShown(), rows = getRows(), shopping = GF.RegionFrame("shopping") and GF.RegionFrame("shopping"):IsShown() or false })`);
	assert.equal(out.meter, true);
	assert.equal(out.rows.length, 1);
	assert.equal(out.shopping, false);
});

test('Atlas keeps a profession step\'s rows in the window', () => {
	const out = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', { name: 'Polestar_Skins', files: ['Layouts/Atlas/Atlas.lua'] }],
		script: script('Polestar.Set("ui.layout", "atlas")', `
GF.Layout(); stub.advance(1); GF.Layout()
emit({ get = GF.RegionFrame("get"):GetParent() == GF.parts.card, meter = GF.RegionFrame("meter"):GetParent() == GF.parts.card,
	shopping = GF.RegionFrame("shopping"):GetParent() == GF.parts.card })`),
	}).emitted[0];
	assert.deepEqual(out, { get: true, meter: true, shopping: true });
});

// A paired guide (`skills Skinning, Leatherworking`, compiled as `skillLines = { 393, 165 }`): the window shows both
// skills on two slim lines; a step reads as for one skill, a craft row of its own skill.
const PAIR = `{ id = "test/pair", pack = "test", title = "Skinning + Leatherworking 1-300", minLevel = 5, maxLevel = 60, category = "Professions",
	kind = "profession", skillLines = { 393, 165 },
	sections = { { skill = "Leatherworking", skillLine = 165, from = 20, to = 75 } },
	steps = {
		{ title = "Skin Light Leather (Skinning 50-72)", section = 1, goals = {
			{ t = "collect", item = 2318, itemName = "Light Leather", count = 34, gather = { skill = "Skinning", skillLine = 393, rank = 50 } },
			{ t = "auction", item = 2318, itemName = "Light Leather", count = 34 } } },
		{ title = "Light Armor Kit to 51", section = 1, goals = {
			{ t = "craft", spell = 2152, spellName = "Light Armor Kit", item = 2304, itemName = "Light Armor Kit", skillLine = 165, untilSkill = 51,
				yellow = 30, grey = 60, reagents = { { item = 2318, itemName = "Light Leather", count = 1 } } } } },
		{ title = "Skinning 72-75", section = 1, goals = { { t = "skill", skill = "Skinning", skillLine = 393, level = 75 } } },
		{ title = "Journeyman Skinning", section = 1, goals = { { t = "train", skill = "Skinning", skillLine = 393, rank = 2, rankMax = 150 } } },
		{ title = "Journeyman Leatherworking", section = 1, goals = { { t = "level", level = 10 }, { t = "train", skill = "Leatherworking", skillLine = 165, rank = 2, rankMax = 150 } } },
	} }`;

const pairScript = (setup, body) => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(24)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide(${PAIR})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local C = Polestar.Compat
C.GetSkillRank = function(line) if line == 393 or line == "Skinning" then return 55, 75 end if line == 165 or line == "Leatherworking" then return 32, 75 end return nil end
C.GetSkillLineName = function(line) return line == 393 and "Skinning" or line == 165 and "Leatherworking" or nil end
w.items[2318] = 20
local E = Polestar.Engine
${setup}
E.SetGuide("test/pair")
stub.advance(1)
local GF = Polestar.UI.GuideFrame
local function at(n) E.Goto(n); stub.advance(0.5) end
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\\194\\160", " "):gsub("  +", " ")) or s end
${body}`;
const runPair = (setup, body, addons = ['Polestar']) => runAddon({ stubs: ['stub_world.lua'], addons, script: pairScript(setup, body) }).emitted[0];
const RANKS = (a, b) => `C.GetSkillRank = function(line) if line == 393 or line == "Skinning" then return ${a} end if line == 165 or line == "Leatherworking" then return ${b} end return nil end`;

test('a paired guide: GuideKinds.SkillLine and Engine.SkillBar give both skills, gathering first; a single guide one', () => {
	const out = run('', `
local K = Polestar.GuideKinds
local single = { K.SkillLine(Polestar.Guides.Get("test/craft")) }
local a, b = E.SkillBar()
emit({ single = single, singleBar2 = select(2, E.SkillBar()) or false, singleLine = a.line })`);
	assert.deepEqual(out.single, [197]);
	assert.equal(out.singleBar2, false);
	assert.equal(out.singleLine, 197);
	const pair = runPair('', `
local K = Polestar.GuideKinds
local lines = { K.SkillLine(Polestar.Guides.Get("test/pair")) }
local a, b = E.SkillBar()
emit({ lines = lines, bars = { a.line, b.line }, ranks = { a.rank, b.rank }, next = { a.next or false, b.next or false }, kind = E.GuideKind() })`);
	assert.deepEqual(pair.lines, [393, 165]);
	assert.deepEqual(pair.bars, [393, 165]);
	assert.deepEqual(pair.ranks, [55, 32]);
	assert.deepEqual(pair.next, [75, 51]);
	assert.equal(pair.kind, 'profession');
});

test('a paired guide: two skill lines; the get step\'s gathering way is Skinning\'s; the craft row is Leatherworking\'s', () => {
	const out = runPair('', `
local view = E.GetStepView(1)
local meter, get = E.KindModel("meter", view, "profession"), E.KindModel("get", view, "profession")
local craft = E.KindModel("stretch", E.GetStepView(2), "profession")
local function brief(m) return { name = m.name, value = m.value, max = m.max, learned = m.learned } end
emit({ pair = { brief(meter.pair[1]), brief(meter.pair[2]) }, verb = get.items[1].ways[1].verb, ways = #get.items[1].ways,
	spell = craft.spell, moveOn = craft.moveOn, left = craft.left })`);
	assert.deepEqual(out.pair, [{ name: 'Skinning', value: 55, max: 75, learned: true }, { name: 'Leatherworking', value: 32, max: 75, learned: true }]);
	assert.equal(out.verb, 'skin');
	assert.equal(out.ways, 2);
	assert.equal(out.spell, 'Leatherworking', 'Open Leatherworking, not Open Skinning');
	assert.equal(out.moveOn, 51);
	assert.ok(out.left > 0, 'what is left counts from Leatherworking 32, not Skinning 55');
});

const PAIR_WINDOW = `
GF.Render(); GF.Layout(); stub.advance(1)
local m = GF.RegionFrame("meter")
local rows = {}
for i, r in ipairs(m.PairRows) do
	rows[i] = { shown = r:IsShown(), name = r.Name:GetText(), value = r.Value:GetText(), max = r.Max:GetText(), bar = r.Bar:IsShown(), w = r.Name:GetWidth() }
end
emit({ meterShown = m:IsShown(), meterH = m:GetHeight(), rows = rows, single = m.Name:IsShown(), line = plain(m.PairLine:GetText()), lineShown = m.PairLine:IsShown(),
	xp = GF.xp.psHas and plain(GF.xp.Text:GetText()) or false })`;

test('a paired guide, in the window: two slim lines stacked, the bars in one column; the XP row leaves them out', () => {
	const out = runPair('', PAIR_WINDOW);
	assert.equal(out.meterShown, true);
	assert.equal(out.single, false, 'the single meter\'s widgets stay quiet');
	assert.deepEqual(out.rows.map((r) => [r.shown, r.name, r.value, r.max, r.bar]), [
		[true, 'Skinning', '55', '/ 75', true],
		[true, 'Leatherworking', '32', '/ 75', true],
	]);
	assert.equal(out.rows[0].w, out.rows[1].w, 'one name column: the bars line up');
	assert.equal(out.lineShown, false, 'the one line is the compact window\'s');
	assert.equal(out.meterH, 26 * 2);
	assert.ok(!out.xp || !String(out.xp).includes('Skinning'), 'the lines say the skills, not the XP row');
});

test('a paired guide, compact: one line, "Skinning 55 · Leatherworking 32"', () => {
	const out = runPair('Polestar.Set("ui.compact", true)', PAIR_WINDOW);
	assert.equal(out.lineShown, true);
	assert.equal(out.line, 'Skinning 55 · Leatherworking 32');
	assert.deepEqual(out.rows.map((r) => r.shown), [false, false]);
	assert.equal(out.meterH, 26);
});

test('a paired guide, a skill not learned yet: "Not learned yet" at its right, no bar; the craft row says to learn it first', () => {
	const one = runPair(RANKS('55, 75', 'nil'), PAIR_WINDOW);
	assert.deepEqual(one.rows.map((r) => [r.name, r.max, r.bar]), [['Skinning', '/ 75', true], ['Leatherworking', 'Not learned yet', false]]);
	const none = runPair(RANKS('nil', 'nil'), `
at(2); GF.Render(); GF.Layout(); stub.advance(1)
local r = GF.RegionFrame("stretch").Row
emit({ sub = plain(r.Sub:GetText()), open = r.psOpen:IsShown(), line = plain(GF.RegionFrame("meter").PairLine:GetText()) })`);
	assert.equal(none.sub, 'Learn Leatherworking first');
	assert.equal(none.open, false);
	assert.equal(none.line, 'Skinning Not learned yet · Leatherworking Not learned yet');
});

test('a paired guide in Atlas: both skills in the XP slot, none stacked in the window; compact too', () => {
	for (const compact of [false, true]) {
		const out = runPair(`Polestar.Set("ui.layout", "atlas")${compact ? '; Polestar.Set("ui.compact", true)' : ''}`, `
GF.Render(); GF.Layout(); stub.advance(1); GF.Layout()
local m = GF.RegionFrame("meter")
emit({ meter = m:IsShown(), xpHas = GF.xp.psHas, xpShown = GF.xp:IsShown(), text = plain(GF.xp.Text:GetText()) })`, ['Polestar', { name: 'Polestar_Skins', files: ['Layouts/Atlas/Atlas.lua'] }]);
		assert.equal(out.meter, false, `compact ${compact}: the meter leaves the window`);
		assert.equal(out.xpHas, true);
		assert.equal(out.xpShown, true);
		assert.match(out.text, /Skinning 55 \/ 75 · Leatherworking 32 \/ 75/);
		assert.match(out.text, /next stretch to 51/);
	}
});

test('a single-skill guide keeps one line: no pair, the skill in no XP row', () => {
	const out = run('', `
GF.Render(); GF.Layout(); stub.advance(1)
local m = E.KindModel("meter", E.GetStepView(1), "profession")
local f = GF.RegionFrame("meter")
emit({ pair = m.pair or false, shown = f:IsShown(), single = f.Name:IsShown(), rows = f.PairRows[1]:IsShown(), xp = GF.xp.psHas and GF.xp.Text:GetText() or false })`);
	assert.deepEqual([out.pair, out.shown, out.single, out.rows], [false, true, true, false]);
	assert.ok(!out.xp || !String(out.xp).includes('Tailoring'));
});

const REP = `{ id = "test/rep", pack = "test", title = "Darnassus Reputation", minLevel = 12, maxLevel = 60, category = "Reputation",
	steps = {
		{ title = "Cloth for Darnassus", goals = {
			{ t = "collect", item = 2592, itemName = "Wool Cloth", count = 60 },
			{ t = "accept", quest = 7792, title = "A Donation of Wool", npc = 14725, npcName = "Raedon Duskstriker" },
			{ t = "turnin", quest = 7792, title = "A Donation of Wool", npc = 14725, npcName = "Raedon Duskstriker" },
			{ t = "rep", faction = 69, factionName = "Darnassus", standing = 6 } } },
		{ title = "Shadowglen", goals = { { t = "accept", quest = 456, title = "The Balance of Nature", npc = 2079, npcName = "Conservator Ilthalaine" },
			{ t = "turnin", quest = 456, title = "The Balance of Nature", npc = 2079, npcName = "Conservator Ilthalaine" } } },
	} }`;

test('reputation: the standing meter, the turn-in card with what the bags hand in, More reputation', () => {
	const out = runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(24)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide(${REP})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
w.setRep(69, "Darnassus", 5, 5150, 3000, 9000)
w.items[2592] = 130
local E = Polestar.Engine
E.SetGuide("test/rep")
stub.advance(1)
local view = E.GetStepView(E.GetStepIndex())
local m = E.KindModel("meter", view, "reputation")
local t = E.KindModel("turnin", view, "reputation")
local more = E.KindModel("more", view, "reputation")
emit({ kind = E.GuideKind(), meter = { name = m.name, value = m.value, max = m.max, toNext = m.line.toNext, turnins = m.line.turnins or false },
	turnin = { title = t.title, ready = t.ready, rep = t.rep or false, items = #t.items }, supplies = E.KindModel("supplies", view, "reputation") or false,
	more = more and more[1].title or false })` }).emitted[0];
	assert.equal(out.kind, 'reputation');
	assert.deepEqual(out.meter, { name: 'Darnassus', value: 2150, max: 6000, toNext: 3850, turnins: false }, 'no reputation value known: no "about N turn-ins"');
	assert.deepEqual(out.turnin, { title: 'A Donation of Wool', ready: 2, rep: false, items: 1 });
	assert.equal(out.supplies, false, 'the turn-in card says the items');
	assert.equal(out.more, 'The Balance of Nature');
});

const REP_SIDE = REP.replace(
	'{ t = "rep", faction = 69, factionName = "Darnassus", standing = 6 } } },',
	`{ t = "rep", faction = 69, factionName = "Darnassus", standing = 6 },
			{ t = "accept", quest = 7800, title = "Friend of the Crown", npc = 14725, npcName = "Raedon Duskstriker" },
			{ t = "turnin", quest = 7800, title = "Friend of the Crown", npc = 14725, npcName = "Raedon Duskstriker",
				rewards = { rep = { { faction = 69, value = 500 } } } } } },`,
);
const repRun = (setup, body, guide = REP_SIDE) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(24)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide(${guide})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
w.setRep(69, "Darnassus", 5, 5150, 3000, 9000)
w.items[2592] = 130
${setup}
local E = Polestar.Engine
E.SetGuide("test/rep")
stub.advance(1)
local GF = Polestar.UI.GuideFrame
local view = E.GetStepView(E.GetStepIndex())
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\\194\\160", " ")) or s end
${body}` }).emitted[0];

test('reputation: More reputation takes in the step\'s own quests that pay the faction; the step has no header or rows left', () => {
	const out = repRun('', `
local more = E.KindModel("more", view, "reputation")
GF.Layout(); stub.advance(1)
local meter, turnin, mf = GF.RegionFrame("meter"), GF.RegionFrame("turnin"), GF.RegionFrame("more")
emit({ first = more[1].title, rep = more[1].rep, current = more[1].current or false, covers = more.covers, next = more[2] and more[2].title or false,
	person = GF.parts.person:IsShown(), rowsShown = mf.psN, right = plain(mf.Rows[1].Right:GetText()),
	value = meter.Value:GetText(), max = meter.Max:GetText(), line = plain(meter.Line:GetText()), check = turnin.Check:IsShown() })`);
	assert.equal(out.first, 'Friend of the Crown');
	assert.equal(out.rep, 500);
	assert.equal(out.current, true);
	assert.equal(out.covers.length, 2, 'its accept and its turn-in leave the card');
	assert.equal(out.next, 'The Balance of Nature');
	assert.equal(out.person, false, 'every goal of the step stands in a region: no header over them');
	assert.match(out.right, /^\+500 once/);
	assert.equal(out.value, '2,150');
	assert.equal(out.max, '/ 6,000');
	assert.equal(out.line, '3,850 to Honored', 'thousands as the client writes them');
	assert.equal(out.check, true, 'a turn-in ready reads with its check');
});

test('reputation: a goal no region stands for reads as the step\'s own row, under the turn-in and over More reputation', () => {
	const talk = REP_SIDE.replace('{ t = "rep", faction = 69,', '{ t = "talk", npc = 14725, npcName = "Raedon Duskstriker" },\n\t\t\t{ t = "rep", faction = 69,');
	const out = repRun('', `
GF.Render(); GF.Layout(); stub.advance(1)
local turnin, more, goals = GF.RegionFrame("turnin"), GF.RegionFrame("more"), GF.parts.goals
local _, turninRel = turnin:GetPoint(1)
local _, moreRel = more:GetPoint(1)
local texts = {}
for _, f in ipairs(GF.CardItems()) do if f:IsShown() and f.Text and f.psGoal then texts[#texts + 1] = plain(f.Text:GetText()) end end
emit({ person = GF.parts.person:IsShown(), turninOnCard = turninRel == GF.parts.card, moreUnderStep = moreRel == goals or moreRel == GF.parts.tip,
	texts = texts })`, talk);
	assert.equal(out.person, true, 'a goal is left: the step\'s header shows');
	assert.equal(out.turninOnCard, true);
	assert.equal(out.moreUnderStep, true, 'More reputation comes after the step\'s rows');
	assert.deepEqual(out.texts, ['Talk to Raedon Duskstriker']);
});

test('reputation, compact: the standing word, how many are ready or short, and no leftover goal rows', () => {
	const out = repRun('Polestar.Set("ui.compact", true)', `
GF.Layout(); stub.advance(1)
local meter, turnin = GF.RegionFrame("meter"), GF.RegionFrame("turnin")
emit({ name = meter.Name:GetText(), right = turnin.LineRight:GetText(), person = GF.parts.person:IsShown(),
	more = GF.RegionFrame("more") and GF.RegionFrame("more"):IsShown() or false })`);
	assert.equal(out.name, 'Friendly', 'the standing, not the faction\'s name');
	assert.equal(out.right, '2 ready');
	assert.equal(out.person, false);
	assert.equal(out.more, false, 'the list itself waits for the standard window');
	const short = repRun('Polestar.Set("ui.compact", true); w.items[2592] = 20', `
GF.Layout(); stub.advance(1)
emit({ right = GF.RegionFrame("turnin").LineRight:GetText() })`);
	assert.equal(short.right, '40 more');
});

// Icons and tooltips of what the guide's recipes are: the item's where a recipe makes one, else the recipe's own
// spell (an enchant, a smelt, a transmute makes no item); the verb's glyph only where the client gives nothing.
const ENCHANTING = `{ id = "test/enchant", pack = "test", title = "Enchanting 1-300", minLevel = 5, maxLevel = 60, category = "Professions",
	sections = { { skill = "Enchanting", skillLine = 333, from = 1, to = 75 } },
	steps = {
		{ title = "Enchanting recipes at 25", section = 1, goals = { { t = "learn", spell = 7420, spellName = "Enchant Chest - Inferior Stamina", skillLine = 333, npc = 3606, npcName = "Alanna Raveneye" } } },
		{ title = "Vendor goods", section = 1, goals = { { t = "buy", item = 247786, itemName = "Mote of Magic", count = 32, npc = 1250, npcName = "Jessara Cordell" } } },
		{ title = "Runed Copper Rod", section = 1, goals = { { t = "craft", spell = 7421, spellName = "Runed Copper Rod", item = 6218, itemName = "Runed Copper Rod", count = 1, skillLine = 333,
			reagents = { { item = 6217, itemName = "Copper Rod", count = 1 }, { item = 247786, itemName = "Mote of Magic", count = 1 } } } } },
		{ title = "Enchant Bracer - Inferior Stamina to 25", section = 1, goals = { { t = "craft", spell = 7418, spellName = "Enchant Bracer - Inferior Stamina", skillLine = 333,
			untilSkill = 25, yellow = 20, grey = 25, reagents = { { item = 247786, itemName = "Mote of Magic", count = 1 } } } } },
	} }`;
// The client as the tests need it: icons of the spells and items, and a game tooltip that remembers what it was set
// to (an enchant: link it knows, the spell it was asked for).
const ICONS = `
C_Spell = C_Spell or {}
local SPELL_ICON = { [7418] = 135913, [7420] = 135914, [2402] = 999, Tailoring = 136249 }
C_Spell.GetSpellTexture = function(id) return SPELL_ICON[id] end
w.itemInfo[2580] = { name = "Woolen Cape", icon = 133001 }
w.itemInfo[6218] = { name = "Runed Copper Rod", icon = 133002 }
w.itemInfo[247786] = { name = "Mote of Magic", icon = 133003 }
local KNOWN = { [7418] = true, [7420] = true }
function GameTooltip.SetOwner(self, owner, anchor) self.owner, self.anchor, self.lines, self.link, self.spellID = owner, anchor, {}, nil, nil end
function GameTooltip.SetHyperlink(self, link)
	local id = tonumber(link:match("^enchant:(%d+)$") or "")
	if id and not KNOWN[id] then return end
	self.link = link
end
function GameTooltip.SetSpellByID(self, id) self.spellID = id end
function GameTooltip.NumLines(self) return self.link and 1 or 0 end`;
const ENCHANTER = `
C.GetSkillRank = function(line) if line == 333 or line == "Enchanting" then return 12, 75 end return nil end
C.GetSkillLineName = function(line) return line == 333 and "Enchanting" or nil end`;
const ROW_OF = `
local function rowOf(t) for _, r in ipairs(GF.rows) do if r:IsShown() and r.psGoal and r.psGoal.t == t then return r end end end
local function hover(r) r:GetScript("OnEnter")(r)
	return { link = GameTooltip.link or false, spell = GameTooltip.spellID or false, owner = GameTooltip:GetOwner() == r, shown = GameTooltip:IsShown() } end`;
const enchant = (body, setup = '') => run(`${ICONS}\n${ENCHANTER}\n${setup}`, `${ROW_OF}\n${body}`, ENCHANTING, 'test/enchant');

test('an enchant craft row wears its spell\'s icon and hovers as the recipe (the enchant: link): no item to show', () => {
	const out = enchant(`
at(4); GF.Layout(); stub.advance(1)
local r = GF.RegionFrame("stretch").Row
emit({ text = plain(r.Text:GetText()), icon = r.Icon:GetTexture(), coord = r.Icon.texCoord, tip = hover(r) })`);
	assert.match(out.text, /^Craft Enchant Bracer - Inferior Stamina until 25/);
	assert.equal(out.icon, 135913, 'the spell\'s texture, not the anvil');
	assert.deepEqual(out.coord, [0.08, 0.92, 0.08, 0.92]);
	assert.deepEqual(out.tip, { link: 'enchant:7418', spell: false, owner: true, shown: true });
});

test('a recipe the client has no enchant: link for hovers as its spell\'s own tooltip', () => {
	const out = enchant(`
at(4); GF.Layout(); stub.advance(1)
local r = GF.RegionFrame("stretch").Row
emit({ tip = hover(r) })`, 'KNOWN[7418] = nil');
	assert.deepEqual(out.tip, { link: false, spell: 7418, owner: true, shown: true });
});

test('an item craft row wears its item\'s icon and the item tooltip, never the spell\'s', () => {
	const out = run(ICONS, `${ROW_OF}
at(4); GF.Layout(); stub.advance(1)
local r = GF.RegionFrame("stretch").Row
emit({ icon = r.Icon:GetTexture(), tip = hover(r) })`);
	assert.equal(out.icon, 133001, 'the cape\'s icon, the spell\'s 999 is not used');
	assert.deepEqual(out.tip, { link: 'item:2580', spell: false, owner: true, shown: true });
});

test('a craft x1 of an item (the tool first) is an ordinary row: the item\'s icon and tooltip', () => {
	const out = enchant(`
at(3); GF.Layout(); stub.advance(1)
local r = rowOf("craft")
emit({ icon = r.Icon:GetTexture(), tip = hover(r) })`);
	assert.equal(out.icon, 133002);
	assert.deepEqual(out.tip, { link: 'item:6218', spell: false, owner: true, shown: true });
});

test('a learn step wears the spell\'s icon and hovers as its recipe', () => {
	const out = enchant(`
at(1); GF.Layout(); stub.advance(1)
local r = rowOf("learn")
emit({ text = plain(r.Text:GetText()), icon = r.Icon:GetTexture(), tip = hover(r) })`);
	assert.match(out.text, /Enchant Chest - Inferior Stamina/);
	assert.equal(out.icon, 135914);
	assert.deepEqual(out.tip, { link: 'enchant:7420', spell: false, owner: true, shown: true });
});

test('a material\'s row (Get N Mote of Magic) wears the item\'s icon and the item tooltip', () => {
	const out = enchant(`
at(2); GF.Layout(); stub.advance(1)
local r = GF.RegionFrame("get").List[1]
emit({ text = plain(r.Text:GetText()), icon = r.Icon:GetTexture(), tip = hover(r) })`);
	assert.match(out.text, /^Get \d+ Mote of Magic/);
	assert.equal(out.icon, 133003);
	assert.deepEqual(out.tip, { link: 'item:247786', spell: false, owner: true, shown: true });
});

test('where the client gives no icon at all, the verb\'s glyph stays (the last resort)', () => {
	const out = enchant(`
SPELL_ICON[7418] = nil
at(4); GF.Layout(); stub.advance(1)
local r = GF.RegionFrame("stretch").Row
emit({ live = r.Icon:GetTexture(), glyph = Polestar.Theme.VerbIcon("craft"), coord = r.Icon.texCoord })`);
	assert.equal(out.live, out.glyph);
	assert.deepEqual(out.coord, [0, 1, 0, 1]);
});

test('a leveling guide keeps its glyphs: learn and collect goals get no recipe art outside a profession guide', () => {
	const out = run(ICONS, `
local goal = { t = "learn", spell = 7420, spellName = "Frostbolt", skillLine = 8 }
E.GuideKind = function() return "leveling" end
emit({ learn = GF.GoalIcon(goal) or false, spell = GF.RecipeSpell(goal) or false, collect = GF.GoalIcon({ t = "collect", item = 2592 }) or false })`);
	assert.deepEqual(out, { learn: false, spell: false, collect: false });
});

test('Open <Profession> without its words (compact) wears the profession\'s own icon and says what it opens on hover; the anvil only where the client has none', () => {
	const body = `${ROW_OF}
at(4); GF.Layout(); stub.advance(1)
local slot = GF.RegionFrame("stretch").Row.psOpen
slot:GetScript("OnUpdate")(slot, 1)
local b = _G.PolestarOpenProfession
b:GetScript("OnEnter")(b)
emit({ words = slot.Label:IsShown(), icon = slot.Icon:GetTexture(), tip = GameTooltip:IsShown() and GameTooltip:GetOwner() == b and GameTooltip.lines[1] or false,
	glyph = Polestar.Theme.VerbIcon("craft") })`;
	const out = run(`${ICONS}\nPolestar.Set("ui.compact", true)`, body);
	assert.equal(out.words, false);
	assert.equal(out.icon, 136249);
	assert.equal(out.tip, 'Open Tailoring');
	const none = run(`${ICONS}\nSPELL_ICON.Tailoring = nil; Polestar.Set("ui.compact", true)`, body);
	assert.equal(none.icon, none.glyph, 'the anvil is the last resort');
});
