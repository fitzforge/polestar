'use strict';
// The dungeon offer (addon/Polestar/Dungeons/Advice.lua + the UI/GuideFrame.lua
// banner): at the level the simulator runs a dungeon at, when it gets a party
// of the player's size to 60 sooner (AdviceData.lua, `sim advice`), the guide
// window offers its pick-up guide, once per dungeon; "Later" asks again at a
// higher level. And `sim advice` itself (tools/lib/sim/advice.js).
//
// Section 1: the banner (stub_ui, like riding.test.js).
// Section 2: Advice.lua (stub_qol), with the Codex's dungeon summaries stubbed.
// Section 3: tools/lib/sim/advice.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { advise, adviceLua } = require('../tools/lib/sim/advice');

const UI_FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function runUI(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: UI_FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\nlocal B = GF.parts.banner\nuistub.openTabs({ { uistub.elwynn, 3 } }, 1)
local resolved = {}
Polestar.Dungeons = { ResolveAdvice = function(n, took, later) resolved[#resolved + 1] = { key = n.key, took = took or false, later = later or false } end }
${script}`,
	}).emitted;
}

test('DUNGEON_ADVICE shows the dungeon, what it saves the party and how sure that is', () => {
	const [party, alone, any] = runUI(`
		Polestar.Fire("DUNGEON_ADVICE", { key = "shadowfang-keep", name = "Shadowfang Keep", size = 3, minutes = 19, pays = 0.7 })
		emit({ text = B.Text:GetText(), jump = B.Jump.Label:GetText(), later = B.Later:IsShown(), close = B.Close:IsShown() })
		B.Close:Click()
		Polestar.Fire("DUNGEON_ADVICE", { key = "city-of-dalaran", name = "City of Dalaran", size = 1, minutes = 7, pays = 0.51 })
		emit(B.Text:GetText())
		B.Close:Click()
		Polestar.Fire("DUNGEON_ADVICE", { key = "deadmines", name = "The Deadmines", size = 3, any = true, minLevel = 18, maxLevel = 26 })
		emit(B.Text:GetText())`);
	assert.equal(party.text, "Dungeon: Shadowfang Keep\nA party of 3 reaches 60 about 19 min sooner with it (in 70% of the simulator's runs).");
	assert.equal(party.jump, 'Pick up its quests');
	assert.equal(party.later, true);
	assert.equal(party.close, true);
	assert.equal(alone, "Dungeon: City of Dalaran\nAlone, you reach 60 about 7 min sooner with it (in 51% of the simulator's runs).");
	assert.equal(any, 'Dungeon: The Deadmines\nLevels 18 to 26. Pick up its quests for a guided route to it, or keep levelling.');
});

test('the banner takes the dungeon, asks again later, or is dismissed for good', () => {
	const [out] = runUI(`
		local n = { key = "shadowfang-keep", name = "Shadowfang Keep", size = 3, minutes = 19, pays = 0.7 }
		Polestar.Fire("DUNGEON_ADVICE", n)
		B.Jump:Click()
		local shown = B:IsShown()
		Polestar.Fire("DUNGEON_ADVICE", n)
		B.Later:Click()
		Polestar.Fire("DUNGEON_ADVICE", n)
		B.Close:Click()
		emit({ shown = shown, resolved = resolved })`);
	assert.equal(out.shown, false);
	assert.deepEqual(out.resolved, [
		{ key: 'shadowfang-keep', took: true, later: false },
		{ key: 'shadowfang-keep', took: false, later: true },
		{ key: 'shadowfang-keep', took: false, later: false },
	]);
});

// ---------------------------------------------------------------------------
// Section 2: Advice.lua
// ---------------------------------------------------------------------------

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'Dungeons/Dungeons.lua', 'Dungeons/Advice.lua'] };

const PRELUDE = `
local q = stub.qol
local C, D = Polestar.Compat, Polestar.Dungeons
local members = 0
function GetNumGroupMembers() return members end
function IsInRaid() return false end
C.GetPlayerInfo = function() return { name = "T", level = q.level, race = "Scourge", class = "ROGUE", faction = "Horde" } end
local summaries = {
	["shadowfang-keep"] = { key = "shadowfang-keep", name = "Shadowfang Keep", map = 33, maxLevel = 30 },
	["ruins-of-lordaeron"] = { key = "ruins-of-lordaeron", name = "Ruins of Lordaeron", maxLevel = 22 },
	["deadmines"] = { key = "deadmines", name = "The Deadmines", map = 36, maxLevel = 26 },
}
D.IsEnabled = function() return true end
D.Get = function(key) return summaries[key] end
local picked, chosen = {}, {}
D.PickUp = function(key) picked[#picked + 1] = key; return "lookup/pickup/" .. key end
Polestar.Engine = { ChooseDungeon = function(map, on) chosen[#chosen + 1] = { map = map, on = on } end }
D.RegisterAdvice({ Horde = {
	[1] = { { "ruins-of-lordaeron", 20.3, 3, 0.56 }, { "shadowfang-keep", 30.7, -52, 0.36 } },
	[3] = { { "ruins-of-lordaeron", 21.4, 13, 0.78 }, { "shadowfang-keep", 24.4, 9, 0.68 }, { "deadmines", 25, -40, 0.1 } },
} })
local offers = {}
Polestar.On("DUNGEON_ADVICE", function(n) offers[#offers + 1] = n end)
local function levelUp(n)
	q.level = n
	stub.fire("PLAYER_LEVEL_UP", n, 0, 0, 0, 0, 0, 0, 0, 0)
	stub.advance(5)
end
`;

function run(script) {
	return runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true, script: PRELUDE + script }).emitted;
}

test('the party\'s size picks the advice; a dungeon that saves too little, too rarely, or is outlevelled is not offered', () => {
	const [alone, low, party, size, between, over] = run(`
		q.level = 21
		emit(D.AdviceDue() or false)
		q.level = 20
		members = 3
		emit(D.AdviceDue() or false)
		q.level = 21
		local n = D.AdviceDue()
		emit({ key = n.key, size = n.size, minutes = n.minutes, pays = n.pays, name = n.name })
		emit(D.PartySize())
		q.level = 23
		emit(D.AdviceDue() or false)
		q.level = 24
		emit(D.AdviceDue().key)`);
	assert.equal(alone, false, 'alone: Ruins saves 3 min, under the 5 min floor');
	assert.equal(low, false, 'under the level it is run at (21.4)');
	assert.deepEqual(party, { key: 'ruins-of-lordaeron', size: 3, minutes: 13, pays: 0.78, name: 'Ruins of Lordaeron' });
	assert.equal(size, 3);
	assert.equal(between, false, 'Ruins (to 22) is outlevelled at 23, Shadowfang is run at 24');
	assert.equal(over, 'shadowfang-keep');
});

test('taking it opens the pick-up guide and turns the dungeon on; Later asks again a level up; dismissed never', () => {
	const [first, took, later, again, gone] = run(`
		members = 3
		levelUp(21)
		emit(#offers)
		D.ResolveAdvice(offers[1], true)
		emit({ picked = picked, chosen = #chosen, next = offers[2] and offers[2].key or false })
		levelUp(25)
		D.ResolveAdvice(offers[#offers], false, true)
		emit(#offers)
		levelUp(26)
		emit(#offers)
		D.ResolveAdvice(offers[#offers], false, false)
		levelUp(27)
		emit(#offers)`);
	assert.equal(first, 1);
	assert.deepEqual(took, { picked: ['ruins-of-lordaeron'], chosen: 0, next: false }, 'Ruins has no map id here: nothing to turn on; Shadowfang waits for 24');
	assert.equal(later, 2, 'Shadowfang at 25, then Later');
	assert.equal(again, 3, 'again at 26');
	assert.equal(gone, 3, 'dismissed for good');
});

test('"Every dungeon in range" also offers, after those that pay, each other dungeon in its levels; it is always asked', () => {
	const [pays, any, open, high] = run(`
		D.List = function() return {
			{ key = "ragefire-chasm", name = "Ragefire Chasm", kind = "dungeon", map = 389, minLevel = 13, maxLevel = 18 },
			{ key = "deadmines", name = "The Deadmines", kind = "dungeon", map = 36, minLevel = 18, maxLevel = 26 },
			{ key = "molten-core", name = "Molten Core", kind = "raid", map = 409, minLevel = 18, maxLevel = 60 },
		} end
		members = 3
		q.level = 21
		emit(D.AdviceDue().key)
		Polestar.Set("dungeons.adviceWhich", "all")
		D.ResolveAdvice(D.AdviceDue(), false, false)
		local n = D.AdviceDue()
		emit({ key = n.key, any = n.any, minLevel = n.minLevel, maxLevel = n.maxLevel })
		Polestar.Set("dungeons.advice", "open")
		levelUp(22)
		emit({ offers = #offers, last = offers[#offers].key, picked = #picked })
		q.level = 27
		D.ResolveAdvice(offers[#offers], false, false)
		emit(picked[#picked] or false)`);
	assert.equal(pays, 'ruins-of-lordaeron', 'what pays comes first');
	assert.deepEqual(any, { key: 'deadmines', any: true, minLevel: 18, maxLevel: 26 }, 'Ragefire (to 18) is outlevelled; a raid is never offered');
	assert.equal(open.last, 'deadmines', 'asked, not opened, with "Open the pick-up guide"');
	assert.equal(open.picked, 0);
	assert.equal(high, 'shadowfang-keep', 'dismissing The Deadmines at 27 lets Shadowfang Keep through, which pays and so opens by itself');
});

test('"Open the pick-up guide" opens it by itself; "Off" offers nothing', () => {
	const [open, off] = run(`
		members = 3
		Polestar.Set("dungeons.advice", "open")
		levelUp(25)
		emit({ offers = #offers, picked = picked, chosen = chosen })
		Polestar.Set("dungeons.advice", "off")
		levelUp(26)
		emit(#offers)`);
	assert.deepEqual(open, { offers: 0, picked: ['shadowfang-keep'], chosen: [{ map: 33, on: true }] }, 'Ruins (to 22) is outlevelled at 25');
	assert.equal(off, 0);
});

// ---------------------------------------------------------------------------
// Section 3: sim advice
// ---------------------------------------------------------------------------

test('sim advice: per faction and party size, over the races, most minutes first', () => {
	const weave = (race, delta, saves, level) => ({
		faction: 'Horde',
		partySize: 3,
		race,
		dungeons: [
			{ name: 'Shadowfang Keep', level, delta },
			{ name: 'Nowhere', level: 20, delta: -60 },
			{ name: 'Gnomeregan', level: null, delta: null },
		],
		uncertainty: [{ name: 'Shadowfang Keep', mean: delta * 3, saves }],
	});
	const keyOf = (n) => ({ 'Shadowfang Keep': 'shadowfang-keep', Gnomeregan: 'gnomeregan' })[n] || null;
	const { advice, unknown } = advise([weave('Orc', -600, 0.7, 24), weave('Tauren', -1200, 0.9, 26)], keyOf);
	assert.deepEqual(advice.Horde[3], [{ key: 'shadowfang-keep', name: 'Shadowfang Keep', level: 25, minutes: 15, pays: 0.8, races: 2 }]);
	assert.deepEqual(unknown, ['Nowhere']);
	const lua = adviceLua(advice, ['a.json']);
	assert.match(lua, /\[3\] = \{\n\t\t\t\{ "shadowfang-keep", 25, 15, 0\.8 \}, -- Shadowfang Keep/);
	assert.match(lua, /^-- Generated by `node tools\/polestar.js sim advice`/);
});
