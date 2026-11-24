'use strict';
// The quest room's rows (UI/QuestRoom.lua) and the dungeon mark
// (Dungeons/Mark.lua): a dungeon's quest, or one needed before one, has a
// dungeon button on its row that opens that dungeon's page, and its tooltip
// says which dungeon. Against the real Core, Theme and UI and the fakes of
// tests/lua/stub_ui.lua; the Dungeons module is faked.

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
Polestar.Dungeons = {
	QuestMark = function(q) if q == 2 then return { key = "gnomeregan" } end end,
	MarkTooltip = function(q) if q == 2 then return "Part of the Gnomeregan quests" end end,
	Open = function(key) opened = key; return true end,
}
Polestar.RoutePlan = Polestar.RoutePlan or {}
Polestar.RoutePlan.OffRoute = function() return { { quest = 1, title = "Crawler Mucus" }, { quest = 2, title = "Gnogaine" } } end
Polestar.UI.ShowQuestRoom("offroute", "x")
local plain, dungeon = PolestarQuestRoom.rows[1], PolestarQuestRoom.rows[2]
${script}`,
	}).emitted[0];
}

test('a dungeon quest\'s row has a dungeon button that opens its page; another row has none', () => {
	const out = run(`dungeon.Dungeon:GetScript("OnClick")(dungeon.Dungeon)
emit({ plain = plain.Dungeon:IsShown(), shown = dungeon.Dungeon:IsShown(), abandon = dungeon.Abandon:IsShown(),
	opened = opened or false, tip = dungeon.Dungeon.psTip, narrower = dungeon.Title:GetWidth() < plain.Title:GetWidth() })`);
	assert.equal(out.plain, false, 'no button on a quest that is no dungeon\'s');
	assert.equal(out.shown, true);
	assert.equal(out.abandon, true, 'Abandon stays beside it');
	assert.equal(out.opened, 'gnomeregan', 'a click opens the dungeon\'s page');
	assert.equal(out.tip, 'Part of the Gnomeregan quests');
	assert.ok(out.narrower, 'the row\'s text stops short of the button');
});

test('a dungeon quest\'s row tooltip names the dungeon under its other lines', () => {
	const out = run(`dungeon:GetScript("OnEnter")(dungeon)
emit({ lines = GameTooltip.lines })`);
	assert.equal(out.lines.at(-1), 'Part of the Gnomeregan quests', out.lines.join(' / '));
});
