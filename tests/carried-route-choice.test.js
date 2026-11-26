'use strict';
// Route-choice cases adapted from ttik3r's #3766; the all-ready guide and
// Quest room also keep #3947's explanation of quests held for a later guide.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack, sampleCodex } = require('./helpers/codex');

function run(extra = '', quests = [50, 60, 70], open = [80], inspect = '') {
	const pack = writeCodexPack(sampleCodex());
	try {
		return runAddon({
			stubs: ['stub_world.lua'], addons: ['Polestar'], before: pack.stubLua,
			script: `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.setLevel(19)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", category = "Leveling", minLevel = 1, maxLevel = 20, next = "test/b",
	steps = { { goals = { { t = "note", text = "Here" } } }, { goals = { { t = "turnin", quest = 70, title = "Ahead" } } } } })
Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "B", category = "Leveling", minLevel = 1, maxLevel = 30,
	next = "test/c1", nextChoices = { "test/c1", "test/c2" },
	steps = { { goals = { { t = "note", text = "Fork" } } } } })
Polestar.RegisterGuide({ id = "test/c1", pack = "test", title = "C1", category = "Leveling", minLevel = 1, maxLevel = 40,
	steps = { { goals = { { t = "turnin", quest = 50, title = "Branch quest" } } } } })
Polestar.RegisterGuide({ id = "test/c2", pack = "test", title = "C2", category = "Leveling", minLevel = 1, maxLevel = 40,
	steps = { { goals = { { t = "accept", quest = 80, title = "Worked on the other way" } } } } })
-- 50: only C1 hands it in. 60: no option uses it. 70: the active guide.
-- 80: C2 takes it, but no guide hands it in; it still waits for the choice.
for _, q in ipairs({ ${quests.join(', ')} }) do
	w.accept(q, { { type = "monster", text = "Kill", need = 1 } }, "Quest " .. q)
	w.finish(q)
end
for _, q in ipairs({ ${open.join(', ')} }) do
	w.accept(q, { { type = "monster", text = "Kill", need = 1 } }, "Quest " .. q)
end
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local E, P, UI = Polestar.Engine, Polestar.RoutePlan, Polestar.UI
E.OpenTab("test/a", true)
stub.advance(0.6)
${extra}
P.Invalidate()
local function ids(list)
	local out = {}
	for _, c in ipairs(list or {}) do out[#out + 1] = c.quest end
	return out
end
local list, waiting = P.Carried()
local unneeded, un = P.Unneeded(), {}
for _, u in ipairs(unneeded or {}) do un[#un + 1] = u.quest .. ":" .. u.status end
local result = { active = E.GetGuide().id, carried = list and ids(list) or "nil", waiting = waiting,
	unneeded = unneeded and un or "nil", all = ids(P.Carried(true)),
	s50 = P.GetTurnIn(50).status, s60 = P.GetTurnIn(60).status,
	s70 = P.GetTurnIn(70).status, s80 = P.GetTurnIn(80).status }
${inspect}
emit(result)`,
		}).emitted[0];
	} finally { pack.cleanup(); }
}

test('a route choice holds only quests an option uses; all-ready still includes every finished quest', () => {
	const out = run();
	assert.equal(out.active, 'test/a');
	assert.ok(['now', 'future'].includes(out.s70));
	assert.equal(out.s50, 'choice');
	assert.equal(out.s60, 'unplanned');
	assert.equal(out.s80, 'choice', 'the quest an option only takes still waits');
	assert.deepEqual(out.carried, [60]);
	assert.equal(out.waiting, 1);
	assert.deepEqual(out.all, [50, 60, 70]);
	assert.equal(out.unneeded, 'nil', 'a log quest still waits on the choice');
});

test('with no log quest an option uses, the clean-up lists the quests no option uses', () => {
	const out = run('', [60, 70], []);
	assert.equal(out.s60, 'unplanned');
	assert.deepEqual(out.unneeded, ['60:unplanned']);
});

test('choosing a branch keeps its later hand-in; the all-ready list retains that status', () => {
	const c1 = run('Polestar.CharState().routes = { ["test/b"] = "test/c1" }', undefined, undefined,
		'result.kept = { P.KeptFor(50) }; result.allStatus = P.Carried(true)[1].status');
	assert.equal(c1.s50, 'later');
	assert.deepEqual(c1.carried, [60]);
	assert.equal(c1.waiting, 0);
	assert.deepEqual(c1.kept, ['test/c1', 'C1']);
	assert.equal(c1.allStatus, 'later');
	const c2 = run('Polestar.CharState().routes = { ["test/b"] = "test/c2" }');
	assert.equal(c2.s50, 'unplanned');
	assert.deepEqual(c2.carried, [50, 60]);
	assert.equal(c2.waiting, 0);
});

test('the elsewhere view explains when only choice-held quests remain, but the menu opens all of them', () => {
	const out = run('', [50], [], `
UI.ShowQuestRoom("elsewhere")
local F = PolestarQuestRoom
result.hint, result.guideMe = F.Hint:GetText(), F.GuideMe:IsShown()
local items
local show = Polestar.Widgets.ShowMenu
Polestar.Widgets.ShowMenu = function(_, rows) items = rows end
UI.GuideFrame.OpenMenu(CreateFrame("Button", nil, UIParent))
Polestar.Widgets.ShowMenu = show
local action
for _, row in ipairs(items) do if row.icon == "icon-turnin" then action = row end end
assert(action and not action.disabled, "the ready quest is available from the menu")
result.menu = action.text
action.onClick(); stub.advance(0.6)
result.guide, result.quests = E.GetGuide().id, {}
for _, step in ipairs(E.GetGuide().steps) do
	for _, goal in ipairs(step.goals) do if goal.t == "turnin" then result.quests[#result.quests + 1] = goal.quest end end
end`);
	assert.match(out.hint, /route ahead isn't settled/);
	assert.equal(out.guideMe, false);
	assert.equal(out.menu, 'Hand in finished quests (1)');
	assert.equal(out.guide, 'lookup/carried/log');
	assert.deepEqual(out.quests, [50]);
});

test('the all-ready Quest room shows who a quest is kept for and the guide still includes it', () => {
	const out = run('Polestar.CharState().routes = { ["test/b"] = "test/c1" }', undefined, undefined, `
UI.ShowQuestRoom("carried")
local F = PolestarQuestRoom
result.rows = {}
for _, row in ipairs(F.rows) do
	if row:IsShown() then result.rows[#result.rows + 1] = row.psQuest end
	if row.psQuest == 50 then result.keptLine, result.tip = row.Why:GetText(), row.psTip end
end
F.GuideMe:GetScript("OnClick")(F.GuideMe); stub.advance(0.6)
result.guide, result.quests = E.GetGuide().id, {}
for _, step in ipairs(E.GetGuide().steps) do
	for _, goal in ipairs(step.goals) do if goal.t == "turnin" then result.quests[#result.quests + 1] = goal.quest end end
end
table.sort(result.quests)`);
	assert.deepEqual(out.rows, [50, 60, 70]);
	assert.match(out.keptLine, /Kept for C1/);
	assert.ok(out.tip.some(line => line.includes('Where it is turned in is not known')), 'the recipient detail remains available');
	assert.equal(out.guide, 'lookup/carried/log');
	assert.deepEqual(out.quests, [50, 60, 70]);
});

test('all-ready reads cannot acknowledge a change in the number waiting on a route choice', () => {
	const out = run('', undefined, undefined, `
local changed = 0
Polestar.On("CARRIED_CHANGED", function() changed = changed + 1 end)
P.Carried(true); P.CheckCarried(); result.stable = changed
-- No quest-log notification redraws the row before its own change check.
w.log[50] = nil
P.Carried(true); P.CheckCarried(); result.changed = changed`);
	assert.equal(out.waiting, 1);
	assert.equal(out.stable, 0);
	assert.equal(out.changed, 1);
});
