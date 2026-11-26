'use strict';
// The profession and reputation kinds' regions (Core/KindCraft.lua, UI/GuideFrameKindCraft.lua; docs/ARCHITECTURE.md,
// "Guide kind regions"): a profession guide at Tailoring 87 shows its skill meter, the trainer's next rank, the
// stretch it levels now (its colour, crafts made, what the bags make now) and the materials to the move-on, counted
// from bags, bank and the bolts already made; Mix buys a material whose farm is longer than Materials.LONG, a price
// is never made up, Self-Found farms everything. A reputation guide shows its standing, the turn-in and its items.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const PROFESSION = `{ id = "test/craft", pack = "test", title = "Tailoring 1-300", minLevel = 5, maxLevel = 60, category = "Professions",
	sections = { { skill = "Tailoring", skillLine = 197, from = 75, to = 150 } },
	steps = {
		{ title = "Get Wool Cloth", section = 1, goals = {
			{ t = "collect", item = 2592, itemName = "Wool Cloth", count = 288, gather = { min = 15, max = 30 } },
			{ t = "auction", item = 2592, itemName = "Wool Cloth", count = 288 } } },
		{ title = "Coarse Thread", section = 1, goals = { { t = "buy", item = 2320, itemName = "Coarse Thread", count = 72 } } },
		{ title = "Bolts", section = 1, goals = { { t = "craft", spell = 2964, spellName = "Bolt of Woolen Cloth", item = 2997, itemName = "Bolt of Woolen Cloth", skillLine = 197, count = 30,
			reagents = { { item = 2592, itemName = "Wool Cloth", count = 3 } } } } },
		{ title = "Woolen Cape to 115", section = 1, goals = { { t = "craft", spell = 2402, spellName = "Woolen Cape", item = 2580, itemName = "Woolen Cape", skillLine = 197,
			untilSkill = 115, yellow = 100, grey = 125,
			reagents = { { item = 2997, itemName = "Bolt of Woolen Cloth", count = 3 }, { item = 2320, itemName = "Coarse Thread", count = 2 } } } } },
		{ title = "Expert Tailoring", section = 1, goals = { { t = "level", level = 20 }, { t = "train", skill = "Tailoring", skillLine = 197, rank = 3, rankMax = 225 } } },
	} }`;

const script = (setup, body) => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(24)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide(${PROFESSION})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local C = Polestar.Compat
C.GetSkillRank = function(line) if line == 197 or line == "Tailoring" then return 87, 150 end return nil end
C.GetSkillLineName = function(line) return line == 197 and "Tailoring" or nil end
w.items[2592] = 58; w.bank[2592] = 10; w.items[2997] = 10; w.items[2320] = 12
local E = Polestar.Engine
-- The farm spot's numbers (Own.farmView over the guide's spawns): 200 minutes for what the step still needs.
E.KindAccess.farm = function(goal) if goal.item == 2592 then return { minutes = 200, kills = 1652 } end end
${setup}
E.SetGuide("test/craft")
stub.advance(1)
local GF = Polestar.UI.GuideFrame
local view = E.GetStepView(E.GetStepIndex())
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) or s end
${body}`;

const run = (setup, body) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(setup, body) }).emitted[0];

const MODELS = `
local m = {}
for _, id in ipairs({ "meter", "trainer", "stretch", "supplies", "buyList" }) do m[id] = E.KindModel(id, view, "profession") or false end
local rows = {}
for _, r in ipairs(m.supplies and m.supplies.rows or {}) do
	rows[#rows + 1] = { item = r.item, have = r.have, need = r.need, way = r.way, choosable = r.choosable, reason = r.reason, made = r.parts.made,
		verdict = r.split and r.split.verdict or false, long = r.split and r.split.long or false,
		copper = r.split and r.split.buy and r.split.buy.copper or false, buy = r.split and r.split.buy and true or false,
		minutes = r.split and r.split.farm and r.split.farm.minutes or false, text = r.split and GF.KindVerdict(r) and plain(GF.KindVerdict(r)) or false }
end
emit({ meter = m.meter and { value = m.meter.value, max = m.meter.max, ticks = m.meter.ticks, line = m.meter.line[1] and m.meter.line[1].to } or false,
	trainer = m.trainer and { title = m.trainer.title, level = m.trainer.level, due = m.trainer.due, toGo = m.trainer.toGo } or false,
	stretch = m.stretch and { colour = m.stretch.colour, green = m.stretch.green, expected = m.stretch.expected, made = m.stretch.made, canMake = m.stretch.canMake, moveOn = m.stretch.moveOn } or false,
	rows = rows, buyList = m.buyList and { count = m.buyList.count, copper = m.buyList.copper or false } or false })`;

test('profession at 87: meter, trainer, stretch colour and counts; materials with bolts counted as cloth', () => {
	const out = run('', MODELS);
	assert.deepEqual(out.meter, { value: 87, max: 150, ticks: [{ at: 115, what: 'moveOn' }, { at: 125, what: 'train' }], line: 115 });
	assert.deepEqual(out.trainer, { title: 'Expert', level: 125, due: false, toGo: 38 });
	// Orange below yellow (100), green from (100 + 125) / 2; about 47 crafts from 75, 12 of them made by 87.
	assert.deepEqual(out.stretch, { colour: 'orange', green: 112, expected: 47, made: 12, canMake: 3, moveOn: 115 });
	const wool = out.rows.find((r) => r.item === 2592);
	// 36 capes still to make: 108 bolts, 324 Wool Cloth; held: 58 bags + 10 bank + 10 bolts (30 cloth).
	assert.equal(wool.need, 324);
	assert.equal(wool.have, 98);
	assert.equal(wool.made, 30);
	const thread = out.rows.find((r) => r.item === 2320);
	assert.deepEqual([thread.need, thread.have, thread.way, thread.choosable], [72, 12, 'vendor', false]);
});

test('Mix buys a material whose farm takes over 45 minutes; no price is "No price yet", never a guess', () => {
	const out = run('', MODELS);
	const wool = out.rows.find((r) => r.item === 2592);
	assert.deepEqual([wool.way, wool.reason, wool.verdict, wool.long, wool.copper], ['buy', 'long', 'buy', true, false]);
	// 200 min for the 206 the step still lacks (264 of its 288 once the crafts made to 87 are counted, less the 58 in
	// the bags); the stretch lacks 226: 219 min.
	assert.equal(wool.minutes, 219);
	assert.equal(wool.text, 'Mix buys this: farming takes about 3 h 39 min at your level. Cloth from your route still counts.');
	assert.deepEqual(out.buyList, { count: 226, copper: false });
});

test('a short farm stays a farm; a searched price shows; the player\'s pick wins; Self-Found farms all', () => {
	const short = run('E.KindAccess.farm = function(goal) if goal.item == 2592 then return { minutes = 30, kills = 200 } end end', MODELS);
	const wool = short.rows.find((r) => r.item === 2592);
	assert.deepEqual([wool.way, wool.reason, wool.verdict], ['gather', 'mix', 'farm']);
	assert.equal(wool.text, 'Mix farms this: about 33 min here.');
	const priced = run('Polestar.Materials.NoteSearch(2592, { { price = 45, quantity = 1000 } })', MODELS);
	const pw = priced.rows.find((r) => r.item === 2592);
	assert.equal(pw.copper, 45 * 226);
	assert.deepEqual(priced.buyList, { count: 226, copper: 45 * 226 });
	const picked = run('Polestar.Materials.SetWay("test/craft", 2592, "gather")', MODELS);
	const kw = picked.rows.find((r) => r.item === 2592);
	assert.deepEqual([kw.way, kw.verdict], ['gather', 'pick']);
	assert.equal(kw.text, 'Your pick: farm. About 3 h 39 min for 226.');
	const sf = run('C_PlayerInfo = C_PlayerInfo or {}; C_PlayerInfo.IsSelfFoundActive = function() return true end', MODELS);
	const sw = sf.rows.find((r) => r.item === 2592);
	assert.deepEqual([sw.way, sw.verdict, sw.buy], ['gather', 'selfFound', false]);
	assert.equal(sw.text, 'Self-Found: you farm all of it.');
});

const WINDOW = `
GF.Layout(); stub.advance(1)
local function shown(id) local f = GF.RegionFrame(id); return f and f:IsShown() or false end
local sup = GF.RegionFrame("supplies")
local meter = GF.RegionFrame("meter")
local st = GF.RegionFrame("stretch")
emit({ regions = { meter = shown("meter"), trainer = shown("trainer"), stretch = shown("stretch"), supplies = shown("supplies"), buyList = shown("buyList") },
	person = GF.parts.person:IsShown(), name = meter and meter.Name:GetText(), value = meter and meter.Value:GetText(),
	line = meter and plain(meter.Line:GetText()), make = st and plain(st.Make:GetText()), count = st and plain(st.Count:GetText()),
	verdict = sup and sup.Well:IsShown() and plain(sup.Verdict:GetText()) or false, head = sup and sup.Head:GetText(),
	xp = GF.xp.psHas and GF.xp.Text:GetText() or false })`;

test('the window: the regions in place of the step header, the split open on the first choosable material', () => {
	const out = run('', WINDOW);
	assert.deepEqual(out.regions, { meter: true, trainer: true, stretch: true, supplies: true, buyList: true });
	assert.equal(out.person, false, 'the regions stand for every goal of the step');
	assert.equal(out.name, 'Tailoring');
	assert.equal(out.value, '87');
	assert.equal(out.line, 'Woolen Cape to 115');
	assert.equal(out.make, 'You can make 3 now');
	assert.equal(out.count, '12 of about 47 made');
	assert.equal(out.head, 'Materials to 115');
	assert.match(out.verdict, /^Mix buys this: farming takes about 3 h 39 min/);
	assert.ok(!out.xp || !String(out.xp).includes('Tailoring'), 'the skill sits in the meter, not the XP row');
});

test('compact: one line each, no split', () => {
	const out = run('Polestar.Set("ui.compact", true)', WINDOW);
	assert.equal(out.regions.meter, true);
	assert.equal(out.regions.buyList, false);
	assert.equal(out.verdict, false);
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
local s = E.KindModel("supplies", view, "reputation")
local more = E.KindModel("more", view, "reputation")
emit({ kind = E.GuideKind(), meter = { name = m.name, value = m.value, max = m.max, toNext = m.line.toNext, turnins = m.line.turnins or false },
	turnin = { title = t.title, ready = t.ready, rep = t.rep or false, items = #t.items },
	rows = #s.rows, need = s.rows[1].need, more = more and more[1].title or false })` }).emitted[0];
	assert.equal(out.kind, 'reputation');
	assert.deepEqual(out.meter, { name: 'Darnassus', value: 2150, max: 6000, toNext: 3850, turnins: false }, 'no reputation value known: no "about N turn-ins"');
	assert.deepEqual(out.turnin, { title: 'A Donation of Wool', ready: 2, rep: false, items: 1 });
	assert.equal(out.rows, 1);
	assert.equal(out.need, 60);
	assert.equal(out.more, 'The Balance of Nature');
});

test('gamepad: X on a material row flips its way (Buy to Farm), A opens its split', () => {
	const out = run('', `
GF.Layout(); stub.advance(1)
local sup = GF.RegionFrame("supplies")
local row = sup.Rows[1]
local before = { flip = row.psPadFlipLabel(row), action = row.psPadLabel(row) }
row.psPadFlip(row)
stub.advance(1)
local _, _, pick = Polestar.Materials.Mode("test/craft", 2592)
emit({ before = before, pick = pick or false })`);
	assert.deepEqual(out.before, { flip: 'Farm instead', action: 'Show Buy and Farm' });
	assert.equal(out.pick, 'gather', 'the flip is the player\'s pick, remembered');
});

test('Atlas sets the materials and the buy list on a card above the window', () => {
	const out = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar', { name: 'Polestar_Skins', files: ['Layouts/Atlas/Atlas.lua'] }],
		script: script('Polestar.Set("ui.layout", "atlas")', `
GF.Layout(); stub.advance(1); GF.Layout()
local sup, list, meter = GF.RegionFrame("supplies"), GF.RegionFrame("buyList"), GF.RegionFrame("meter")
emit({ supplies = sup:GetParent() ~= GF.parts.card, buyList = list:GetParent() == sup, meter = meter:GetParent() == GF.parts.card,
	head = sup.Head:GetText() })`),
	}).emitted[0];
	assert.deepEqual(out, { supplies: true, buyList: true, meter: true, head: 'MATERIALS TO 115' });
});
