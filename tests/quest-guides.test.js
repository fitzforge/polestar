'use strict';
// Which guides use a quest (addon/Polestar/Quests/QuestGuides.lua,
// qol.questGuides): the guides for this character that pick a quest up,
// work it or hand it in, by their first level; another race's guide left
// out; the lines a tooltip gets. Against the real Core, Theme, Quests and UI.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Quests/Quests.xml', 'UI/UI.xml'];

const GUIDES = `
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({
	id = "test/later", pack = "test", title = "Later Zone", minLevel = 30, maxLevel = 32,
	steps = {
		{ goals = { { t = "kill", target = "Kobold Vermin", npc = 6, quest = 100, oi = 1, count = 5 } } },
		{ goals = { { t = "turnin", quest = 100, title = "Pre-quest" } } },
	},
})
Polestar.RegisterGuide({
	id = "test/early", pack = "test", title = "Early Zone", minLevel = 10, maxLevel = 12,
	steps = {
		{ goals = { { t = "accept", quest = 100, title = "Pre-quest" }, { t = "accept", quest = 200, title = "Other" } } },
	},
})
Polestar.RegisterGuide({
	id = "test/orc", pack = "test", title = "Orc Zone", minLevel = 1, maxLevel = 5, races = { "Orc" },
	steps = { { goals = { { t = "accept", quest = 100, title = "Pre-quest" } } } },
})
`;

function run(script) {
	return runAddon({
		stubs: ['stub_world.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `${GUIDES}
stub.login()
local QG = Polestar.QuestGuides
QG.BuildNow()
${script}`,
	}).emitted[0];
}

test('For: the guides using a quest, by first level, with what each does; another race\'s guide left out', () => {
	const out = run(`local list = QG.For(100)
local rows = {}
for _, e in ipairs(list) do rows[#rows + 1] = { id = e.guide.id, roles = e.roles } end
emit({ rows = rows, none = #QG.For(999), other = #QG.For(200) })`);
	assert.deepEqual(out.rows, [
		{ id: 'test/early', roles: 1 },
		{ id: 'test/later', roles: 2 + 4 },
	]);
	assert.equal(out.none, 0);
	assert.equal(out.other, 1);
});

test('AddLines: a "Polestar guides" heading and a line per guide, its levels and what it does', () => {
	const out = run(`GameTooltip:SetOwner(UIParent, "ANCHOR_RIGHT")
GameTooltip:SetText("Pre-quest")
local added = QG.AddLines(GameTooltip, 100)
emit({ added = added, lines = GameTooltip.lines, none = QG.AddLines(GameTooltip, 999) })`);
	assert.equal(out.added, true);
	assert.equal(out.none, false);
	const text = out.lines.join('\n');
	assert.match(text, /Polestar guides/);
	assert.match(text, /Early Zone \(10.12\) \| picks up/);
	assert.match(text, /Later Zone \(30.32\) \| works, hands in/);
	assert.doesNotMatch(text, /Orc Zone/);
});

test('with the setting off, no lines', () => {
	const out = run(`Polestar.Set("qol.questGuides", false)
GameTooltip:SetOwner(UIParent, "ANCHOR_RIGHT")
emit({ added = QG.AddLines(GameTooltip, 100) })`);
	assert.equal(out.added, false);
});

test('an open guide comes first and is marked; the others follow unmarked', () => {
	const out = run(`local E = Polestar.Engine
E.OpenTab("test/later", true)
local tabs = E.GetTabs()
for i = #tabs, 1, -1 do if tabs[i].guideId == "test/early" then E.CloseTab(i, true) end end
local list = QG.For(100)
GameTooltip:SetOwner(UIParent, "ANCHOR_RIGHT")
GameTooltip:SetText("Pre-quest")
QG.AddLines(GameTooltip, 100)
emit({ first = list[1].guide.id, open = list[1].open, second = list[2].guide.id, lines = GameTooltip.lines })`);
	assert.equal(out.first, 'test/later');
	assert.equal(out.open, true);
	assert.equal(out.second, 'test/early');
	const text = out.lines.join('\n');
	assert.match(text, /\|T[^|]*guides[^|]*\|t Later Zone/);
	assert.doesNotMatch(text, /\|t Early Zone/);
});

test('labels: no levels twice when the title has them; the pack named when two packs share a title; same lines once', () => {
	const out = run(`Polestar.RegisterPack({ addon = "Polestar_Other", id = "other", format = 1, title = "Other Pack", author = "Test", version = "1", license = "MIT" })
Polestar.RegisterGuide({ id = "test/el1", pack = "test", title = "6-11 Elwynn Forest", minLevel = 6, maxLevel = 11,
	steps = { { goals = { { t = "accept", quest = 300, title = "Q" } } } } })
Polestar.RegisterGuide({ id = "test/el2", pack = "test", title = "6-11 Elwynn Forest", minLevel = 6, maxLevel = 11,
	steps = { { goals = { { t = "accept", quest = 300, title = "Q" } } } } })
Polestar.RegisterGuide({ id = "other/el", pack = "other", title = "6-11 Elwynn Forest", minLevel = 6, maxLevel = 11,
	steps = { { goals = { { t = "turnin", quest = 300, title = "Q" } } } } })
Polestar.Set("behavior.suggestFrom", "test")
QG.BuildNow()
local labels = {}
for _, e in ipairs(QG.Shown(QG.For(300))) do labels[#labels + 1] = e.label end
emit({ labels = labels, plain = Polestar.UI.GuideLabel({ title = "Early Zone", minLevel = 10, maxLevel = 12 }) })`);
	assert.deepEqual(out.labels, ['6-11 Elwynn Forest · Test', '6-11 Elwynn Forest · Other Pack']);
	assert.match(out.plain, /^Early Zone \(10.12\)$/);
});
