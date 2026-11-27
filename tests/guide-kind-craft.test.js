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
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\\194\\160", " ")) or s end
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
	assert.equal(wool.text, 'Mix buys this: farming takes about 4 h at your level. Cloth from your route still counts.', 'past two hours the verdict says whole hours (3 h 39 min stays in the Farm column)');
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
	assert.equal(kw.text, 'Your pick: farm. About 4 h for 226.');
	const sf = run('C_PlayerInfo = C_PlayerInfo or {}; C_PlayerInfo.IsSelfFoundActive = function() return true end', MODELS);
	const sw = sf.rows.find((r) => r.item === 2592);
	assert.deepEqual([sw.way, sw.verdict, sw.buy], ['gather', 'selfFound', false]);
	assert.equal(sw.text, 'About 4 h for 226 at your level.', 'Self-Found: the time farming all of it takes');
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
	assert.match(out.verdict, /^Mix buys this: farming takes about 4 h/);
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

const REP_SIDE = REP.replace(
	'{ t = "rep", faction = 69, factionName = "Darnassus", standing = 6 } } },',
	`{ t = "rep", faction = 69, factionName = "Darnassus", standing = 6 },
			{ t = "accept", quest = 7800, title = "Friend of the Crown", npc = 14725, npcName = "Raedon Duskstriker" },
			{ t = "turnin", quest = 7800, title = "Friend of the Crown", npc = 14725, npcName = "Raedon Duskstriker",
				rewards = { rep = { { faction = 69, value = 500 } } } } } },`,
);
const repRun = (setup, body) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(24)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide(${REP_SIDE})
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
	assert.equal(out.check, true, 'a turn-in ready reads with the same check as "You can make 2 now"');
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

test('Self-Found: the row offers Farm alone, the Buy column is dimmed with no count; a made count is "10 made", never cut', () => {
	const out = run('C_PlayerInfo = C_PlayerInfo or {}; C_PlayerInfo.IsSelfFoundActive = function() return true end', `
GF.Layout(); stub.advance(1)
local sup = GF.RegionFrame("supplies")
local row = sup.Rows[1]
emit({ toggle = row.Seg[1]:IsShown(), way = row.Way:IsShown() and row.Way:GetText() or false, flip = row.psPadFlipLabel(row) or false,
	src = plain(row.Src:GetText()), tip = row.psMade, buyTitle = sup.Buy.Title:GetText(), buyBig = sup.Buy.Big:GetText(),
	verdict = plain(sup.Verdict:GetText()), lines = sup.Verdict:GetNumLines() })`);
	assert.equal(out.toggle, false);
	assert.equal(out.way, 'Farm');
	assert.equal(out.flip, false);
	assert.equal(out.src.replace(/ +/g, ' '), 'bags 58 · bank 10 · 10 made');
	assert.equal(out.tip, '10 Bolt of Woolen Cloth already made');
	assert.equal(out.buyTitle, 'Buy');
	assert.equal(out.buyBig, 'Not for Self-Found characters');
	assert.match(out.verdict, /^About 4 h for 226 at your level\.$/);
	assert.ok(out.lines <= 2, 'the advice is two lines at most');
});

test('the Farm column reads the zone first, then the level; Blizzard marks the chosen segment', () => {
	const out = run('w.addMap(1433, { name = "Redridge Mountains", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); Polestar.Set("ui.skin", "blizzard")', `
local real = E.KindModel
E.KindModel = function(id, v, k)
	local m = real(id, v, k)
	if id == "supplies" and m then
		m.rows[1].split.farm = { count = 226, minutes = 38, npc = "Blackrock Grunt", map = 1433, lvl = { min = 19, max = 23 }, step = 1, index = 1 }
	end
	return m
end
GF.Render(); GF.Layout(); stub.advance(1)
local sup = GF.RegionFrame("supplies")
local Fm = sup.Farm
local marks = {}
for k, b in ipairs(sup.Rows[1].Seg) do marks[k] = { b.psMarked or false, b.psUnder and b.psUnder:IsShown() or false } end
emit({ zone = plain(Fm.Small2:GetText()), level = plain(Fm.psLevel:GetText()), marks = marks })`);
	assert.equal(out.zone, 'Redridge Mountains');
	assert.match(out.level, /^( {2}· {2})?lvl 19–23$/, 'after the zone on its line, or alone on the line under it where both do not fit');
	assert.deepEqual(out.marks, [[true, true], [false, false]]);
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

test('the trade skill window open: its own colour for the recipe wins ("Grey now: move on")', () => {
	const out = run(`GetSpellInfo = function(id) if id == 2402 then return "Woolen Cape" end end
C_Spell = nil
GetNumTradeSkills = function() return 2 end
GetTradeSkillInfo = function(i) if i == 2 then return "Woolen Cape", "trivial" end return "Bolt of Woolen Cloth", "easy" end`, `
local m = E.KindModel("stretch", view, "profession")
GF.Layout(); stub.advance(1)
emit({ colour = m.colour, line = plain(GF.RegionFrame("stretch").MoveOn:GetText()) })`);
	assert.deepEqual(out, { colour: 'grey', line: 'Grey now: move on' });
});

test('Open Tailoring: the click is a secure spell button outside the guide window, over the card\'s button', () => {
	const out = run('', `
GF.Layout(); stub.advance(1)
local slot = GF.RegionFrame("stretch").psOpen
slot:GetScript("OnUpdate")(slot, 1)
local b = _G.PolestarOpenProfession
local under = false
local p = b and b:GetParent()
while p do if p == GF.frame then under = true end p = p:GetParent() end
emit({ shown = slot:IsShown(), text = slot.Label:GetText(), secure = b ~= nil, under = under, spell = b and b:GetAttribute("spell") or false })`);
	assert.deepEqual(out, { shown: true, text: 'Open Tailoring', secure: true, under: false, spell: 'Tailoring' });
});

// A paired guide (`skills Skinning, Leatherworking`, compiled as `skillLines = { 393, 165 }`): the window shows both
// skills, and the step's flow line stands on the stretch card instead of in the tip. The tip is the generator's
// own: the why line with its "from your skinning" clause, the flow line, then the arrow's sentence.
const WHY = '34 Light Leather for Leatherworking 20-51: 53 Light Armor Kits; from your skinning on the way: 12 of 34 Light Leather.';
const FLOW = 'Skin 34 Light Leather (Skinning 50 to 72), then craft 45 Light Armor Kits (Leatherworking 20 to 51).';
const ARROW = 'The arrow takes the Skinning loop that gets you them soonest from where you are and walks it until your bags hold them. Or buy them at the Auction House.';
const PAIR = `{ id = "test/pair", pack = "test", title = "Skinning + Leatherworking 1-300", minLevel = 5, maxLevel = 60, category = "Professions",
	kind = "profession", skillLines = { 393, 165 },
	sections = { { skill = "Leatherworking", skillLine = 165, from = 20, to = 75 } },
	steps = {
		{ title = "Skin Light Leather (Skinning 50-72)", section = 1, note = "${WHY} ${FLOW} ${ARROW}", goals = {
			{ t = "collect", item = 2318, itemName = "Light Leather", count = 34, gather = { skill = "Skinning", skillLine = 393, rank = 50 } },
			{ t = "auction", item = 2318, itemName = "Light Leather", count = 34 } } },
		{ title = "Light Armor Kit to 51", section = 1, note = "Light Armor Kit is orange at 20 (yellow 30, green 45, grey 60): about 45 crafts to 51.", goals = {
			{ t = "craft", spell = 2152, spellName = "Light Armor Kit", item = 2304, itemName = "Light Armor Kit", skillLine = 165, untilSkill = 51,
				yellow = 30, grey = 60, reagents = { { item = 2318, itemName = "Light Leather", count = 1 } } } } },
		{ title = "Skinning 72-75", section = 1, goals = { { t = "skill", skill = "Skinning", skillLine = 393, level = 75 } } },
		{ title = "Journeyman Skinning", section = 1, goals = { { t = "train", skill = "Skinning", skillLine = 393, rank = 2, rankMax = 150 } } },
		{ title = "Journeyman Leatherworking", section = 1, goals = { { t = "level", level = 10 }, { t = "train", skill = "Leatherworking", skillLine = 165, rank = 2, rankMax = 150 } } },
	} }`;

const pairScript = (setup, body, guide = PAIR) => `
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
C.GetSkillRank = function(line) if line == 393 or line == "Skinning" then return 55, 75 end if line == 165 or line == "Leatherworking" then return 32, 75 end return nil end
C.GetSkillLineName = function(line) return line == 393 and "Skinning" or line == 165 and "Leatherworking" or nil end
w.items[2318] = 20
local E = Polestar.Engine
${setup}
E.SetGuide("test/pair")
stub.advance(1)
local GF = Polestar.UI.GuideFrame
local view = E.GetStepView(E.GetStepIndex())
local function plain(s) return s and (s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\\194\\160", " "):gsub("  +", " ")) or s end
${body}`;
const runPair = (setup, body, extra = {}) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: pairScript(setup, body, extra.guide), ...extra.opts }).emitted[0];

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
	// The gathering skill moves on at its next `skill` goal; the crafting one at its craft's `until`.
	assert.deepEqual(pair.next, [75, 51]);
	assert.equal(pair.kind, 'profession');
});

const PAIR_MODELS = `
local meter = E.KindModel("meter", view, "profession")
local stretch = E.KindModel("stretch", view, "profession")
local sup = E.KindModel("supplies", view, "profession")
local trainer = E.KindModel("trainer", view, "profession")
local function brief(m) return { name = m.name, value = m.value, max = m.max, seg = m.seg, ticks = m.ticks, line = m.line[1] and m.line[1].to or false } end
emit({ pair = meter.pair and { brief(meter.pair[1]), brief(meter.pair[2]) } or false, covers = #meter.covers,
	flow = stretch and stretch.flow or false, note = stretch and stretch.note or false, from = sup and sup.from or false,
	moveOn = stretch and stretch.moveOn, spell = stretch and stretch.spell, trainer = trainer and { title = trainer.title, due = trainer.due, level = trainer.level } or false })`;

test('a paired guide: two meters (gathering to where its stretch ends, crafting to its move-on), the flow line, the clause', () => {
	const out = runPair('', PAIR_MODELS);
	assert.equal(out.pair.length, 2);
	const [skin, leather] = out.pair;
	assert.deepEqual([skin.name, skin.value, skin.max], ['Skinning', 55, 75]);
	// Skinning's stretch ends where the tip's "(Skinning 50 to 72)" says; no recipe in its line.
	assert.deepEqual(skin.ticks, [{ at: 72, what: 'gathered' }]);
	assert.equal(skin.line, false);
	assert.ok(Math.abs(skin.seg[0] - 55 / 75) < 1e-9 && Math.abs(skin.seg[1] - 72 / 75) < 1e-9);
	assert.deepEqual([leather.name, leather.value, leather.max], ['Leatherworking', 32, 75]);
	assert.deepEqual(leather.ticks, [{ at: 51, what: 'moveOn' }, { at: 50, what: 'train' }]);
	assert.equal(leather.line, 51);
	assert.equal(out.covers, 0);
	assert.equal(out.flow, 'Skin 34 Light Leather (Skinning 50 to 72), then craft 45 Light Armor Kits (Leatherworking 20 to 51)');
	assert.equal(out.note, `34 Light Leather for Leatherworking 20-51: 53 Light Armor Kits. ${ARROW}`, 'the tip keeps the rest, without the flow line or the clause');
	assert.equal(out.from, 'from your skinning on the way: 12 of 34 Light Leather');
	assert.equal(out.moveOn, 51);
	assert.equal(out.spell, 'Leatherworking', 'Open Leatherworking, not Open Skinning');
	// The trainer line: the next rank of either skill, in guide order, named by its skill.
	assert.deepEqual(out.trainer, { title: 'Journeyman Skinning', due: true, level: 50 });
});

test('a paired guide, off its gathering step: no flow line, the tip as written; Skinning moves on at its next skill goal', () => {
	const out = runPair('E.Goto(2)', PAIR_MODELS.replace('E.KindModel("meter", view', 'E.KindModel("meter", E.GetStepView(2)').replace('E.KindModel("stretch", view', 'E.KindModel("stretch", E.GetStepView(2)').replace('E.KindModel("supplies", view', 'E.KindModel("supplies", E.GetStepView(2)'));
	assert.equal(out.flow, false);
	assert.equal(out.note, false);
	assert.equal(out.from, false);
	// Nothing in the tip to say it: Skinning's next `skill` goal (75, its cap: no tick over the bar's end).
	assert.equal(Object.keys(out.pair[0].ticks).length, 0);
	assert.ok(Math.abs(out.pair[0].seg[1] - 1) < 1e-9);
});

const PAIR_WINDOW = `
GF.Render(); GF.Layout(); stub.advance(1)
local m = GF.RegionFrame("meter")
local st = GF.RegionFrame("stretch")
local sup = GF.RegionFrame("supplies")
local rows = {}
for i, r in ipairs(m.PairRows) do
	rows[i] = { shown = r:IsShown(), name = r.Name:GetText(), value = r.Value:GetText(), max = r.Max:GetText(), bar = r.Bar:IsShown(), h = r:GetHeight(),
		fill = r.Bar.Fill:GetWidth(), seg = r.Bar.Seg:IsShown(), ticks = #r.Bar.Ticks }
end
emit({ meterShown = m:IsShown(), meterH = m:GetHeight(), rows = rows, single = m.Name:IsShown(), line = plain(m.PairLine:GetText()), lineShown = m.PairLine:IsShown(),
	flow = st.Flow:IsShown() and plain(st.Flow:GetText()) or false, from = sup.From:IsShown() and plain(sup.From:GetText()) or false,
	tip = plain(GF.parts.card.Tip.Text:GetText()), xp = GF.xp.psHas and plain(GF.xp.Text:GetText()) or false })`;

test('a paired guide, in the window: two compact meters stacked, the flow line under the recipe\'s name, the tip without it', () => {
	const out = runPair('', PAIR_WINDOW);
	assert.equal(out.meterShown, true);
	assert.equal(out.single, false, 'the single meter\'s widgets stay quiet');
	assert.deepEqual(out.rows.map((r) => [r.shown, r.name, r.value, r.max, r.bar, r.seg]), [
		[true, 'Skinning', '55', '/ 75', true, true],
		[true, 'Leatherworking', '32', '/ 75', true, true],
	]);
	assert.ok(out.rows[0].ticks >= 1 && out.rows[1].ticks >= 1, 'a tick at each move-on');
	assert.equal(out.lineShown, false, 'the one line is the compact window\'s');
	assert.equal(out.meterH, 4 + 24 * 2 + 6);
	assert.equal(out.flow, 'Skin 34 Light Leather (Skinning 50 to 72), then craft 45 Light Armor Kits (Leatherworking 20 to 51)');
	assert.equal(out.from, 'From your skinning on the way: 12 of 34 Light Leather');
	assert.equal(out.tip, `34 Light Leather for Leatherworking 20-51: 53 Light Armor Kits. ${ARROW}`);
	assert.ok(!out.xp || !String(out.xp).includes('Skinning'), 'the meters say the skills, not the XP row');
});

test('a paired guide, compact: one line, "Skinning 55 · Leatherworking 32"', () => {
	const out = runPair('Polestar.Set("ui.compact", true)', PAIR_WINDOW);
	assert.equal(out.lineShown, true);
	assert.equal(out.line, 'Skinning 55 · Leatherworking 32');
	assert.deepEqual(out.rows.map((r) => r.shown), [false, false]);
	assert.equal(out.meterH, 24);
	assert.equal(out.flow, false, 'the compact card is one line');
});

test('a paired guide in Atlas: both skills in the XP slot, none stacked in the window; compact too', () => {
	for (const compact of [false, true]) {
		const out = runAddon({
			stubs: ['stub_world.lua'],
			addons: ['Polestar', { name: 'Polestar_Skins', files: ['Layouts/Atlas/Atlas.lua'] }],
			script: pairScript(`Polestar.Set("ui.layout", "atlas")${compact ? '; Polestar.Set("ui.compact", true)' : ''}`, `
GF.Render(); GF.Layout(); stub.advance(1); GF.Layout()
local m = GF.RegionFrame("meter")
emit({ meter = m:IsShown(), xpHas = GF.xp.psHas, xpShown = GF.xp:IsShown(), text = plain(GF.xp.Text:GetText()) })`),
		}).emitted[0];
		assert.equal(out.meter, false, `compact ${compact}: the meter leaves the window`);
		assert.equal(out.xpHas, true);
		assert.equal(out.xpShown, true);
		assert.match(out.text, /Skinning 55 \/ 75 · Leatherworking 32 \/ 75/);
		assert.match(out.text, /next stretch to 51/);
	}
});

test('a single-skill guide is unchanged: one meter, no pair, no flow, its tip whole, the skill in no XP row', () => {
	const out = run('', `
GF.Render(); GF.Layout(); stub.advance(1)
local m = E.KindModel("meter", view, "profession")
local f = GF.RegionFrame("meter")
local st = E.KindModel("stretch", view, "profession")
emit({ pair = m.pair or false, flow = st.flow or false, note = st.note or false, shown = f:IsShown(), single = f.Name:IsShown(), rows = f.PairRows[1]:IsShown(),
	xp = GF.xp.psHas and GF.xp.Text:GetText() or false })`);
	assert.deepEqual([out.pair, out.flow, out.note], [false, false, false]);
	assert.deepEqual([out.shown, out.single, out.rows], [true, true, false]);
	assert.ok(!out.xp || !String(out.xp).includes('Tailoring'));
});

test('the flow line is found by its numbers, in any language: another stop, full-width brackets, no clause', () => {
	const out = runPair('', `
local KC = Polestar.KindCraft
local de = KC.TipParts("34 Light Leather für Lederverarbeitung 20-51: 53 Leichte Rüstungssätze. Erbeute 34 Leichtes Leder (Kürschnerei 50 bis 72), dann stelle 45 Leichte Rüstungssätze her (Lederverarbeitung 20 bis 51). Der Pfeil führt dich.", 20, 51)
local zh = KC.TipParts("34 块轻皮；用你的剥皮顺带：12 / 34 块轻皮。剥 34 块轻皮（剥皮 50 到 72），然后制作 45 个轻型护甲片（制皮 20 到 51）。箭头带你去。", 20, 51)
local none = KC.TipParts("Light Armor Kit is orange at 20 (yellow 30, green 45, grey 60): about 45 crafts to 51.", 20, 51)
local first = KC.TipParts("Your bags hold it already, then craft 24 Nimble Leather Gloves (Leatherworking 102 to 125). The arrow takes you.", 102, 125)
emit({ de = de and { flow = de.flow, gather = de.gather, from = de.from or false, rest = de.rest } or false,
	zh = zh and { flow = zh.flow, gather = zh.gather, from = zh.from, rest = zh.rest } or false, none = none or false,
	first = first and { flow = first.flow, gather = first.gather or false, rest = first.rest } or false })`);
	assert.deepEqual(out.de, {
		flow: 'Erbeute 34 Leichtes Leder (Kürschnerei 50 bis 72), dann stelle 45 Leichte Rüstungssätze her (Lederverarbeitung 20 bis 51)',
		gather: [50, 72], from: false, rest: '34 Light Leather für Lederverarbeitung 20-51: 53 Leichte Rüstungssätze. Der Pfeil führt dich.',
	});
	assert.deepEqual(out.zh.gather, [50, 72]);
	assert.equal(out.zh.flow, '剥 34 块轻皮（剥皮 50 到 72），然后制作 45 个轻型护甲片（制皮 20 到 51）'.replace(/（/g, '(').replace(/）/g, ')'));
	assert.equal(out.zh.from, '用你的剥皮顺带：12 / 34 块轻皮');
	assert.equal(out.none, false, 'a craft step\'s own numbers in a tip are not a flow line');
	assert.deepEqual(out.first, { flow: 'Your bags hold it already, then craft 24 Nimble Leather Gloves (Leatherworking 102 to 125)', gather: false, rest: 'The arrow takes you.' });
});
