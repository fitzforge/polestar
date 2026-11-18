'use strict';
// The quest tooltip a quest row shows on hover (addon/Polestar/UI/UI.lua,
// UI.QuestTip): the quest's name over its level, zone and faction (the
// client and the quest database), its objectives while it is in the log and
// the row's own lines. Hovering a row of the quest room's lists
// (UI/QuestRoom.lua) shows it; leaving the row hides it. Against the real
// Core, Theme and UI and the fakes of tests/lua/stub_ui.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()
stub.login()
local C = Polestar.Compat
C.GetQuestLevel = function(q) return q == 1 and 18 or nil end
C.GetAreaName = function(id) return id == 11 and "Wetlands" or nil end
C.GetQuestObjectives = function(q) if q == 1 then return { { text = "Crawler Mucus: 3/8", finished = false } } end end
Polestar.QuestDB = Polestar.QuestDB or {}
local Q = Polestar.QuestDB
Q.IsLoaded = function() return true end
Q.GetQuest = function(id) if id == 1 then return { id = 1, title = "Crawler Mucus", level = 18, minLevel = 15, zone = 11, faction = "Alliance" } end end
${script}`,
	}).emitted[0];
}

test('UI.QuestTip: name, level from its minimum, zone, faction, objectives, then the extra lines', () => {
	const out = run(`local owner = CreateFrame("Frame", nil, UIParent)
Polestar.UI.QuestTip(owner, 1, "ANCHOR_RIGHT", { "A line of the row" })
emit({ lines = GameTooltip.lines, owner = GameTooltip:GetOwner() == owner, anchor = GameTooltip.anchor })`);
	assert.deepEqual(out.lines, [
		'Crawler Mucus',
		'Level | 18 (from 15)',
		'Zone | Wetlands',
		'Faction | Alliance',
		'Crawler Mucus: 3/8',
		'A line of the row',
	]);
	assert.ok(out.owner);
	assert.equal(out.anchor, 'ANCHOR_RIGHT');
});

test('UI.QuestTip: a quest nothing knows shows its id alone', () => {
	const out = run(`Polestar.QuestDB.IsLoaded = function() return false end
local owner = CreateFrame("Frame", nil, UIParent)
Polestar.UI.QuestTip(owner, 999)
emit({ lines = GameTooltip.lines })`);
	assert.deepEqual(out.lines, ['Quest 999']);
});

test('a "Not part of your route" row shows the quest tooltip on hover and hides it on leave', () => {
	const out = run(`Polestar.RoutePlan = Polestar.RoutePlan or {}
Polestar.RoutePlan.OffRoute = function() return { { quest = 1, title = "Crawler Mucus" } } end
Polestar.UI.ShowQuestRoom("offroute", "x")
local r = PolestarQuestRoom.rows[1]
r:GetScript("OnEnter")(r)
local lines, owned = GameTooltip.lines, GameTooltip:GetOwner() == r and GameTooltip:IsShown()
r:GetScript("OnLeave")(r)
emit({ lines = lines, owned = owned, hidden = not GameTooltip:IsShown(), abandon = r.Abandon:IsShown(),
	abandonOwnHover = r.Abandon:GetScript("OnEnter") ~= r:GetScript("OnEnter") })`);
	assert.ok(out.owned, 'the row owns the shown tooltip');
	assert.deepEqual(out.lines, [
		'Crawler Mucus',
		'Level | 18 (from 15)',
		'Zone | Wetlands',
		'Faction | Alliance',
		'Crawler Mucus: 3/8',
		'Not in any guide of your route',
	]);
	assert.ok(out.hidden, 'leaving the row hides it');
	assert.ok(out.abandon, 'the Abandon button stays');
	assert.ok(out.abandonOwnHover, 'the Abandon button keeps its own hover');
});

test('every quest room list shows the quest tooltip on its rows: the finished quests carried', () => {
	const out = run(`Polestar.RoutePlan = Polestar.RoutePlan or {}
Polestar.RoutePlan.Carried = function() return { { quest = 1, title = "Crawler Mucus", xp = 800 } } end
Polestar.RoutePlan.Ender = function() return { name = "Mountaineer Rockgar", zone = "Wetlands", npc = 1 } end
Polestar.UI.ShowQuestRoom("carried")
local r = PolestarQuestRoom.rows[1]
r:GetScript("OnEnter")(r)
emit({ lines = GameTooltip.lines, owned = GameTooltip:GetOwner() == r })`);
	assert.ok(out.owned);
	assert.equal(out.lines[0], 'Crawler Mucus');
	assert.ok(out.lines.includes('Zone | Wetlands'), out.lines.join(' / '));
	assert.equal(out.lines.at(-1), 'Mountaineer Rockgar, Wetlands  ·  800 XP');
});

// What a quest is worth (RoutePlan.Worth), from what the route's sums read: the
// Codex's XP against the level's, a loot's drop chance, grey for the level.
function worth(codex, script) {
	return run(`local C = Polestar.Compat
C.GetPlayerInfo = function() return { level = 20 } end
C.IsQuestReadyForTurnIn = function() return false end
C.IsQuestTrivial = function(qlvl, level) return qlvl <= level - 8 end
local codex = ${codex}
Polestar.Codex = Polestar.Codex or {}
Polestar.Codex.Quest = function(id) return codex.quests[id] end
Polestar.Codex.Item = function(id) return codex.items and codex.items[id] end
Polestar.Codex.Npc = function(id) return codex.npcs and codex.npcs[id] end
Polestar.RoutePlan.Carried = function() return {} end
Polestar.RoutePlan.Unneeded = function() return { { quest = 1, title = "Crawler Mucus", status = "unplanned" } } end
${script}`);
}

const HOVER = `local r = PolestarQuestRoom.rows[1]
r:GetScript("OnEnter")(r)
emit({ why = r.Why:GetText(), lines = GameTooltip.lines })`;

test('a Make room row says its XP is low for the walk; the tooltip keeps why the route leaves it and the XP', () => {
	const out = worth('{ quests = { [1] = { level = 18, xp = 500, objectives = {} } } }', `Polestar.UI.ShowQuestRoom()\n${HOVER}`);
	assert.equal(out.why, 'Low XP for the walk');
	assert.deepEqual(out.lines.slice(-3), ['Not handed in on this route', 'Low XP for the walk', '500 XP']);
});

test('a Make room row says a good-XP quest is worth keeping', () => {
	const out = worth('{ quests = { [1] = { level = 18, xp = 3000, objectives = {} } } }', `Polestar.UI.ShowQuestRoom()\n${HOVER}`);
	assert.equal(out.why, 'Good XP: worth keeping');
});

test('a loot it still needs that drops rarely reads "Rare drop, slow", even with good XP', () => {
	const codex = `{ quests = { [1] = { level = 18, xp = 3000, objectives = { { type = "item", id = 5, count = 8 } } } },
	items = { [5] = { sources = { { type = "drop", npc = 7, chance = 3 } } } }, npcs = { [7] = { level = 18 } } }`;
	const out = worth(codex, `Polestar.UI.ShowQuestRoom()\n${HOVER}`);
	assert.equal(out.why, 'Rare drop, slow');
	const common = worth(codex.replace('chance = 3', 'chance = 60'), `Polestar.UI.ShowQuestRoom()\n${HOVER}`);
	assert.equal(common.why, 'Good XP: worth keeping');
});

test('a "Not part of your route" row says a grey quest is grey for your level; nothing known keeps the route\'s reason', () => {
	const out = worth('{ quests = {} }', `C.GetQuestLevel = function() return 10 end
Polestar.RoutePlan.OffRoute = function() return { { quest = 1, title = "Crawler Mucus" } } end
Polestar.UI.ShowQuestRoom("offroute", "x")\n${HOVER}`);
	assert.equal(out.why, 'Grey for your level');
	assert.deepEqual(out.lines.slice(-2), ['Not in any guide of your route', 'Grey for your level']);
	const none = worth('{ quests = {} }', `Polestar.RoutePlan.OffRoute = function() return { { quest = 1, title = "Crawler Mucus" } } end
Polestar.UI.ShowQuestRoom("offroute", "x")\n${HOVER}`);
	assert.equal(none.why, 'Not in any guide of your route');
	assert.equal(none.lines.at(-1), 'Not in any guide of your route');
});
