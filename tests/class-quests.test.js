'use strict';
// Class quests (addon/Polestar/QoL/ClassQuests.lua + the UI/GuideFrame.lua
// banner): when one of the character's Class guides opens, the guide window
// offers it in a tab, once per guide; "Later" asks again at a higher level.
//
// Section 1: the banner (stub_ui, like riding.test.js).
// Section 2: ClassQuests.lua (stub_qol), with the guides and the engine stubbed.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const UI_FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function runUI(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: UI_FILES }],
		script: `uistub.install()\nstub.login()\nlocal GF = Polestar.UI.GuideFrame\nlocal B = GF.parts.banner\nuistub.openTabs({ { uistub.elwynn, 3 } }, 1)
local opened, resolved = {}, {}
Polestar.Engine.OpenTab = function(id) opened[#opened + 1] = id; return 2 end
Polestar.QoL = { ClassQuests = { Resolve = function(id, later) resolved[#resolved + 1] = { id = id, later = later or false } end } }
${script}`,
	}).emitted;
}

test('CLASS_QUEST_READY shows the offer: the guide, why, Open in a tab and Later', () => {
	const [out] = runUI(`
		Polestar.Fire("CLASS_QUEST_READY", { guideId = "forever/class/shaman/call-of-air-horde", title = "Call of Air", why = "The Air Totem." })
		emit({ shown = B:IsShown(), text = B.Text:GetText(), jump = B.Jump.Label:GetText(), later = B.Later:IsShown() and B.Later.Label:GetText(), close = B.Close:IsShown() })`);
	assert.equal(out.shown, true);
	assert.equal(out.text, 'Class quest ready: Call of Air\nThe Air Totem.');
	assert.equal(out.jump, 'Open in a tab');
	assert.equal(out.later, 'Later');
	assert.equal(out.close, true);
});

test('the banner opens the guide in a tab, or asks again later, or is dismissed for good', () => {
	const [take, later, dismiss] = runUI(`
		local n = { guideId = "g/one", title = "One" }
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Jump:Click()
		emit({ opened = opened, resolved = resolved[1], shown = B:IsShown() })
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Later:Click()
		emit(resolved[2])
		Polestar.Fire("CLASS_QUEST_READY", n)
		B.Close:Click()
		emit(resolved[3])`);
	assert.deepEqual(take, { opened: ['g/one'], resolved: { id: 'g/one', later: false }, shown: false });
	assert.deepEqual(later, { id: 'g/one', later: true });
	assert.deepEqual(dismiss, { id: 'g/one', later: false });
});

// ---------------------------------------------------------------------------
// Section 2: ClassQuests.lua
// ---------------------------------------------------------------------------

const QOL_FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

// Three Class guides: a Shaman one that is open (no gate), a Shaman one that
// waits on level 30, and a Rogue one.
const PRELUDE = `
local q = stub.qol
local C = Polestar.Compat
local CQ = Polestar.QoL.ClassQuests
Polestar.RegisterDefaults("behavior", { offerClassQuests = true })
local inLog, done = {}, {}
C.IsOnQuest = function(id) return inLog[id] == true end
C.IsQuestCompleted = function(id) return done[id] == true end
C.GetPlayerInfo = function() return { name = "T", level = q.level, race = "Orc", class = "SHAMAN", faction = "Horde" } end
local guides = {
	{ id = "c/fire", title = "Call of Fire", category = "Class", classes = { "SHAMAN" }, why = "The Fire Totem.", steps = { { goals = { { t = "accept", quest = 1 } } } } },
	{ id = "c/air", title = "Call of Air", category = "Class", classes = { "SHAMAN" }, steps = { { goals = { { t = "accept", quest = 2 } } } } },
	{ id = "c/poisons", title = "Poisons", category = "Class", classes = { "ROGUE" }, steps = { { goals = { { t = "accept", quest = 3 } } } } },
	{ id = "l/durotar", title = "Durotar", category = "Leveling", steps = { { goals = { { t = "accept", quest = 4 } } } } },
}
local byId = {}
for _, g in ipairs(guides) do byId[g.id] = g end
Polestar.Guides = {
	List = function() return guides end,
	Get = function(id) return byId[id] end,
	GuideMatches = function(g, p) return not g.classes or g.classes[1] == p.class end,
}
local gates = { ["c/air"] = { level = 30 } }
Polestar.Engine = {
	StartGate = function(id) return gates[id] end,
	GetGuideState = function() return "new" end,
}
local offers = {}
Polestar.On("CLASS_QUEST_READY", function(n) offers[#offers + 1] = n end)
local function levelUp(n)
	q.level = n
	stub.fire("PLAYER_LEVEL_UP", n, 0, 0, 0, 0, 0, 0, 0, 0)
	stub.advance(3)
end
`;

function runQoL(script) {
	return runAddon({ stubs: ['stub_qol.lua'], addons: [QOL_FILES], login: true, script: PRELUDE + script }).emitted;
}

test('only the Class guides this character can start now and has not started are ready', () => {
	const [ready, under] = runQoL(`
		q.level = 20
		local ids = {}
		for _, g in ipairs(CQ.Ready()) do ids[#ids + 1] = g.id end
		emit(ids)
		inLog[1] = true
		emit(#CQ.Ready())`);
	assert.deepEqual(ready, ['c/fire'], 'not the gated one, not another class, not a leveling guide');
	assert.equal(under, 0, 'a quest of it in the log: under way');
});

test('a level-up offers one guide at a time; Later asks again at a higher level, a dismiss never', () => {
	const [first, held, later, again, gone] = runQoL(`
		levelUp(20)
		emit({ n = #offers, id = offers[1] and offers[1].guideId, why = offers[1] and offers[1].why })
		levelUp(21)
		emit(#offers)
		CQ.Resolve("c/fire", true)
		emit(#offers)
		levelUp(22)
		emit(#offers)
		CQ.Resolve("c/fire")
		levelUp(23)
		emit(#offers)`);
	assert.deepEqual(first, { n: 1, id: 'c/fire', why: 'The Fire Totem.' });
	assert.equal(held, 1, 'not again while the offer is up');
	assert.equal(later, 1, 'Later: not at this level');
	assert.equal(again, 2, 'again at a higher level');
	assert.equal(gone, 2, 'dismissed for good');
});

test('the gated guide is offered once its gate opens; nothing with the setting off', () => {
	const [opened, off] = runQoL(`
		levelUp(20)
		CQ.Resolve("c/fire")
		gates["c/air"] = nil
		levelUp(30)
		emit(offers[#offers].guideId)
		Polestar.Set("behavior.offerClassQuests", false)
		CQ.Resolve("c/air", true)
		levelUp(31)
		emit(#offers)`);
	assert.equal(opened, 'c/air');
	assert.equal(off, 2);
});
