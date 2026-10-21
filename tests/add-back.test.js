'use strict';
// Add back (Quests/AddBack.lua + the guide window's "+" button): the group
// quests answered "Skip it", the dungeons in the character's levels that are
// off and the Class guides put off, each to put back on the route.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Quests/AddBack.lua'] };

const PRELUDE = `
local C, AB = Polestar.Compat, Polestar.AddBack
local level, done = 20, {}
C.GetPlayerInfo = function() return { name = "T", level = level, race = "Scourge", class = "ROGUE", faction = "Horde" } end
C.IsQuestCompleted = function(q) return done[q] == true end
local answers, chosen, calls = { [7] = "skip", [8] = "do", [9] = "skip" }, { [36] = true }, {}
Polestar.Engine = {
	GroupQuests = function() return { { quest = 7, title = "Kobold Camp Cleanup" }, { quest = 8, title = "Ogre Thieves" }, { quest = 9, title = "Gnoll Hunt" } } end,
	GroupAnswer = function(q) return answers[q] end,
	AnswerGroup = function(q, a) answers[q] = a; calls[#calls + 1] = "answer " .. q .. " " .. a end,
	DungeonChosen = function(map) return chosen[map] == true end,
	ChooseDungeon = function(map, on) chosen[map] = on; calls[#calls + 1] = "dungeon " .. map end,
	OpenTab = function(id) calls[#calls + 1] = "tab " .. id end,
}
Polestar.Dungeons = {
	IsEnabled = function() return true end,
	List = function() return {
		{ key = "ragefire-chasm", name = "Ragefire Chasm", kind = "dungeon", map = 389, minLevel = 13, maxLevel = 18 },
		{ key = "shadowfang-keep", name = "Shadowfang Keep", kind = "dungeon", map = 33, minLevel = 18, maxLevel = 30 },
		{ key = "deadmines", name = "The Deadmines", kind = "dungeon", map = 36, minLevel = 18, maxLevel = 26 },
		{ key = "molten-core", name = "Molten Core", kind = "raid", map = 409, minLevel = 18, maxLevel = 60 },
	} end,
	PickUp = function(key) calls[#calls + 1] = "pickup " .. key end,
}
Polestar.QoL = { ClassQuests = { Passed = function() return { { id = "class/rogue-poisons", title = "Poisons" } } end } }
local function list()
	local out = {}
	for _, it in ipairs(AB.Items()) do out[#out + 1] = it.kind .. ":" .. it.title end
	return out
end
`;

function run(script) {
	return runAddon({ addons: [FILES], login: true, script: PRELUDE + script }).emitted;
}

test('add back lists the group quests skipped, the dungeons in range that are off, then the Class guides put off', () => {
	const [items, later] = run(`
		emit(list())
		done[9] = true
		level = 27
		emit(list())`);
	assert.deepEqual(items, ['group:Kobold Camp Cleanup', 'group:Gnoll Hunt', 'dungeon:Shadowfang Keep', 'class:Poisons'],
		'Ogre Thieves is on; Ragefire is outlevelled; Deadmines is on; a raid is never listed');
	assert.deepEqual(later, ['group:Kobold Camp Cleanup', 'dungeon:Shadowfang Keep', 'class:Poisons'], 'a quest turned in is gone');
});

test('adding one back answers the quest "do", turns the dungeon on and opens its pick-up guide, or opens the Class guide', () => {
	const [out] = run(`
		for _, it in ipairs(AB.Items()) do AB.Add(it) end
		emit({ calls = calls, left = list() })`);
	assert.deepEqual(out.calls, ['answer 7 do', 'answer 9 do', 'dungeon 33', 'pickup shadowfang-keep', 'tab class/rogue-poisons']);
	assert.deepEqual(out.left, ['class:Poisons'], 'the Class guide stays until it is started');
});

test('the + button shows with a guide loaded, lists what can come back, and is off with its setting', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame
local added
Polestar.AddBack = {
	Items = function() return { { kind = "group", id = 7, title = "Kobold Camp Cleanup" }, { kind = "dungeon", id = "deadmines", map = 36, title = "The Deadmines", minLevel = 18, maxLevel = 26 } } end,
	Add = function(it) added = it.id end,
}
local before = GF.addBackButton:IsShown()
uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
local shown = GF.addBackButton:IsShown()
GF.addBackButton:Click()
local rows = {}
for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then rows[#rows + 1] = r.Text:GetText() end end
for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Kobold Camp Cleanup" then r:Click() end end
Polestar.Set("ui.addBackButton", false)
emit({ before = before, shown = shown, rows = rows, added = added, off = GF.addBackButton:IsShown() })`,
	}).emitted;
	assert.equal(out.before, false, 'no guide, no button');
	assert.equal(out.shown, true);
	assert.deepEqual(out.rows, ['Group quests', 'Kobold Camp Cleanup', 'Dungeons', 'The Deadmines (levels 18 to 26)']);
	assert.equal(out.added, 7);
	assert.equal(out.off, false);
});
