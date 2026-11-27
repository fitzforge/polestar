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
	stretch = m.stretch and { colour = m.stretch.colour, green = m.stretch.green, expected = m.stretch.expected, made = m.stretch.made, left = m.stretch.left, canMake = m.stretch.canMake, moveOn = m.stretch.moveOn } or false,
	rows = rows, buyList = m.buyList and { count = m.buyList.count, copper = m.buyList.copper or false } or false })`;

test('profession at 87: meter, trainer, stretch colour and counts; materials with bolts counted as cloth', () => {
	const out = run('', MODELS);
	assert.deepEqual(out.meter, { value: 87, max: 150, ticks: [{ at: 115, what: 'moveOn' }, { at: 125, what: 'train' }], line: 115 });
	assert.deepEqual(out.trainer, { title: 'Expert', level: 125, due: false, toGo: 38 });
	// Orange below yellow (100), green from (100 + 125) / 2; about 47 crafts from 75, about 36 still to go from 87. None
	// made: the 12 points since 75 may have come from other recipes, so no cast counted means none made.
	assert.deepEqual(out.stretch, { colour: 'orange', green: 112, expected: 47, made: 0, left: 36, canMake: 3, moveOn: 115 });
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
	assert.equal(out.count, 'about 36 to go', 'what the skill still takes; no "made" without a counted cast');
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

test('a tooltip goes the moment the cursor leaves: the game\'s item tooltip on a tile, the tip on the chip, a tip whose owner hides', () => {
	const out = run('', `
GF.Layout(); stub.advance(1)
local st, sup = GF.RegionFrame("stretch"), GF.RegionFrame("supplies")
local function gameOwned(o) return GameTooltip:IsShown() and GameTooltip:GetOwner() == o or false end
local function tipShown() return _G.PolestarTip and _G.PolestarTip:IsShown() or false end
local tile = sup.Rows[1].Tile
tile:GetScript("OnEnter")(tile)
local itemOn = gameOwned(tile)
tile:GetScript("OnLeave")(tile)
local itemAfter = gameOwned(tile)
local chip = st.Chip
chip:GetScript("OnEnter")(chip)
local tipOn = tipShown()
chip:GetScript("OnLeave")(chip)
local tipAfter = tipShown()
chip:GetScript("OnEnter")(chip)
st:Hide()
stub.advance(0.1)
emit({ itemOn = itemOn, itemAfter = itemAfter, tipOn = tipOn, tipAfter = tipAfter, ownerHidden = tipShown() })`);
	assert.deepEqual(out, { itemOn: true, itemAfter: false, tipOn: true, tipAfter: false, ownerHidden: false });
});

test('the split\'s columns centre what they hold: the lines under the title, the button at its own width', () => {
	const out = run('', `
GF.Layout(); stub.advance(1)
local sup = GF.RegionFrame("supplies")
local B, Fm = sup.Buy, sup.Farm
local function pt(r) return (r:GetPoint(1)) end
emit({ well = sup.Well:IsShown(), big = pt(B.Big), small = pt(B.Small1), justify = B.Big:GetJustifyH(), button = pt(B.Button),
	ownWidth = B.Button:GetWidth() < B:GetWidth() - 20, farmBig = pt(Fm.Big), farmButton = Fm.Button:IsShown() and pt(Fm.Button) or false })`);
	assert.deepEqual(out, { well: true, big: 'TOP', small: 'TOP', justify: 'CENTER', button: 'TOP', ownWidth: true, farmBig: 'TOP', farmButton: 'TOP' });
});

test('nothing to make now: the card keeps no rule and no empty row under the count (the client answers nil for an empty text)', () => {
	const out = run('stub.emptyTextNil = true; w.items[2320] = 0', `
GF.Layout(); stub.advance(1)
local st = GF.RegionFrame("stretch")
local _, _, _, _, cy = st.Count:GetPoint(1)
emit({ rule = st.Rule:IsShown(), make = st.Make:IsShown(), open = st.psOpen:IsShown(),
	tight = st.Card:GetHeight() <= -cy + st.Count:GetStringHeight() + 10.5 })`);
	assert.deepEqual(out, { rule: false, make: false, open: false, tight: true });
});

test('crafts made are the recipe\'s casts counted, after what the skill still takes ("about 36 to go · 2 made")', () => {
	const out = run('Polestar.Set("ui.width", 460)', `
stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-1", 2402)
stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-2", 2402)
stub.fire("UNIT_SPELLCAST_SUCCEEDED", "player", "Cast-3", 2964)
stub.advance(0.5)
GF.Layout(); stub.advance(1)
local m = E.KindModel("stretch", view, "profession")
local st = GF.RegionFrame("stretch")
Polestar.Set("ui.compact", true)
GF.Render(); GF.Layout(); stub.advance(1)
emit({ made = m.made, left = m.left, count = plain(st.Count:GetText()), compact = plain(st.LineRight:GetText()) })`);
	assert.equal(out.made, 2, 'Woolen Cape cast twice; the bolt is another recipe');
	assert.equal(out.left, 36);
	assert.match(out.count, /^about 36 to go +· +2 made$/);
	assert.match(out.compact, /^36 to go +· +to 115$/);
});

test('Buy | Farm | Mix: a click moves the chosen tab and repaints the materials', () => {
	const out = run('', `
GF.Layout(); stub.advance(1)
local sup = GF.RegionFrame("supplies")
local function marks() local t = {} for k, b in ipairs(sup.Modes) do t[k] = b.psMarked or false end return t end
local before, shown = marks(), sup.Modes[1]:IsShown()
sup.Modes[1]:Click()
stub.advance(0.5)
local afterBuy = marks()
sup.Modes[2]:Click()
stub.advance(0.5)
emit({ shown = shown, before = before, afterBuy = afterBuy, afterFarm = marks(), way = GF.RegionModel("supplies").way,
	wool = GF.RegionModel("supplies").rows[1].way })`);
	assert.equal(out.shown, true, 'Wool Cloth is still short and can be farmed or bought');
	assert.deepEqual(out.before, [false, false, true], 'Mix by default');
	assert.deepEqual(out.afterBuy, [true, false, false]);
	assert.deepEqual(out.afterFarm, [false, true, false]);
	assert.equal(out.way, 'gather');
	assert.equal(out.wool, 'gather');
});

test('Buy | Farm | Mix shows only while a material still to get has a choice: held, vendor-only or made ones give the same list', () => {
	const out = run('w.items[2592] = 400', `
GF.Layout(); stub.advance(1)
local sup = GF.RegionFrame("supplies")
local m = GF.RegionModel("supplies")
emit({ choosable = m.choosable, tabs = sup.Modes[1]:IsShown() or sup.Modes[2]:IsShown() or sup.Modes[3]:IsShown(), drop = sup.ModeDrop:IsShown() })`);
	assert.deepEqual(out, { choosable: false, tabs: false, drop: false }, 'the wool is held; Coarse Thread is vendor-only');
});

const ATLAS = `C_Texture = { GetAtlasInfo = function(name)
	if name == "Professions-Icon-Skill-High" or name == "Professions-Icon-Skill-Medium" or name == "Professions-Icon-Skill-Low" then
		return { width = 13, height = 15, file = 4417031 } end end }`;
const ICON = `
GF.Layout(); stub.advance(1)
local st = GF.RegionFrame("stretch")
local chip = st.Chip
chip:GetScript("OnEnter")(chip)
local tip = Polestar.Widgets.TipShown()
chip:GetScript("OnLeave")(chip)
local card = { shown = chip:IsShown(), atlas = chip.Icon:GetAtlas() or false, texture = chip.Icon:GetTexture() or false, text = rawget(chip, "Text") and true or false,
	tip = tip and tip.title or false }
Polestar.Set("ui.compact", true)
GF.Render(); GF.Layout(); stub.advance(1)
emit({ card = card, line = st.Line:GetText() })`;

test('the recipe\'s colour is the client\'s own skill-up arrow, its name in the tooltip; our chevron where the client has none', () => {
	const art = run(ATLAS, ICON);
	assert.equal(art.card.shown, true);
	assert.equal(art.card.atlas, 'Professions-Icon-Skill-High', 'orange at 87, below yellow (100)');
	assert.equal(art.card.text, false, 'no word chip');
	assert.equal(art.card.tip, 'Orange');
	assert.match(art.line, /\|A:Professions-Icon-Skill-High:15:13\|a$/, 'compact: the same arrow after the recipe');
	const own = run('', ICON);
	assert.equal(own.card.shown, true);
	assert.match(String(own.card.texture), /chevron-up/);
	assert.match(own.line, /\|T[^|]*chevron-up[^|]*\|t$/);
	const yellow = run(`${ATLAS}; C.GetSkillRank = function(line) if line == 197 or line == "Tailoring" then return 105, 150 end return nil end`, ICON);
	assert.equal(yellow.card.atlas, 'Professions-Icon-Skill-Medium');
});

test('a grey recipe shows no arrow, as the client\'s window shows none', () => {
	const out = run(`${ATLAS}
GetSpellInfo = function(id) if id == 2402 then return "Woolen Cape" end end
C_Spell = nil
GetNumTradeSkills = function() return 1 end
GetTradeSkillInfo = function(i) return "Woolen Cape", "trivial" end`, ICON);
	assert.equal(out.card.shown, false);
	assert.doesNotMatch(out.line, /\|A:|\|T/);
});

test('a skill not learned yet: the profession layout from the first step (the recipe it starts on, "Learn Tailoring first", the materials)', () => {
	const out = run('C.GetSkillRank = function() return nil end', `${WINDOW.replace('emit({', 'local stm = E.KindModel("stretch", view, "profession")\nemit({ learned = stm and stm.learned, colour = stm and stm.colour or false, chip = st and st.Chip:IsShown(), open = st and st.psOpen:IsShown(),')}`);
	assert.deepEqual(out.regions, { meter: true, trainer: true, stretch: true, supplies: true, buyList: true });
	assert.equal(out.person, false, 'no plain goal rows in place of the layout');
	assert.equal(out.name, 'Learn Tailoring');
	assert.equal(out.make, 'Learn Tailoring first');
	assert.match(out.count, /^about \d+ to go$/);
	assert.equal(out.head, 'Materials to 115');
	assert.deepEqual([out.learned, out.colour, out.chip, out.open], [false, false, false, false], 'no colour and no Open Tailoring before it is learned');
});
