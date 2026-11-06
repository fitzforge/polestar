'use strict';
// The class quest heads-up (UI/ClassToast.lua) and the guide window share the
// height cap: the card sits a small gap off the window's edge, counts against
// ui.maxHeight while it shows, and the goals area under the cap scrolls in
// whole rows (UI/GuideFrame.lua). Against the real Core + Theme + UI manifests
// and the fake Engine (tests/lua/stub_ui.lua).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const PRE = `
uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local CT = Polestar.UI.ClassToast
local F = PolestarGuideFrame
GetSpellTexture = function(id) return "Interface\\\\Icons\\\\spell-" .. id end
Polestar.Compat.GetMapName = function(id) return ({ [1411] = "Durotar", [1454] = "Orgrimmar" })[id] end
IsPlayerSpell = function() return false end
GetItemCount = function() return 0 end
Polestar.Compat.IsQuestCompleted = function() return false end
Polestar.Compat.IsOnQuest = function() return false end
local function G(t, f) f.t = t; return f end
local function q(t, id, title, npc, status) return G(t, { verb = t == "accept" and "Accept" or "Turn in", subject = title, subjectKind = "quest", quest = id, npcName = npc, status = status or "pending" }) end
local function add(g) uistub.guides[g.id] = g; table.insert(uistub.order, g.id) end
add({ id = "test/class/warlock", pack = "guides", title = "Warlock demons", category = "Class", classes = { "WARLOCK" }, minLevel = 1, maxLevel = 30,
	zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = {
	{ title = "Ophek", goals = { q("accept", 1506, "Gan'rul's Summons", "Ophek") } },
	{ title = "Creature of the Void", goals = { q("turnin", 1506, "Gan'rul's Summons", "Gan'rul Bloodeye") } },
} })
-- A busy step: goals of mixed heights (one wraps), so a fixed scroll step lands mid-row.
local busy = {}
for i = 1, 14 do
	local subject = i % 4 == 0 and ("Scorpid Worker of the long dry gully past the ridge " .. i) or ("Mottled Boar " .. i)
	busy[#busy + 1] = G("kill", { verb = "Kill", subject = subject, subjectKind = "npc", npc = 3098 + i, progress = { cur = 0, max = 8 }, status = i == 12 and "active" or "pending" })
end
add({ id = "test/durotar", pack = "guides", title = "Durotar", faction = "Horde", category = "Leveling", minLevel = 1, maxLevel = 12,
	zone = 1411, zoneName = "Durotar", author = "Polestar", version = 1, steps = { { title = "Valley of Trials", goals = busy } } })
uistub.player.class, uistub.player.race, uistub.player.faction, uistub.player.level = "WARLOCK", "Orc", "Horde", 10
Polestar.Set("ui.wholeStep", true)
Polestar.Set("ui.maxHeight", 0.4)
uistub.setGuide("test/durotar", 1)
stub.advance(1)
local goals = GF.parts.goals
-- Every item top of the goals area, as a set.
local function tops()
	local out = {}
	for _, f in ipairs(GF.CardItems()) do out[#out + 1] = GF.ItemTop(f) end
	return out
end
local function onTop(y)
	for _, t in ipairs(tops()) do if math.abs(t - y) < 0.5 then return true end end
	return false
end
`;

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: PRE + script,
	}).emitted;
}

test('the class card sits a gap off the window edge and counts against the height cap only while it shows', () => {
	const [before, shown, gone] = run(`
		emit({ h = F:GetHeight(), cap = GF.CapHeight(), over = goals.psOver })
		CT.Show(1506)
		stub.advance(1)
		local point, rel, relPoint, x, y = CT.frame:GetPoint(1)
		emit({ shown = CT.frame:IsShown(), side = CT.side, point = point, relPoint = relPoint, y = y, rel = rel == F,
			card = CT.frame:GetHeight(), h = F:GetHeight(), cap = GF.CapHeight() })
		CT.frame.Later:Click()
		stub.advance(1)
		emit({ shown = CT.frame:IsShown(), h = F:GetHeight() })`);
	assert.equal(before.over, true, 'the busy step is over the cap');
	assert.ok(before.h <= before.cap + 0.5, `the window keeps to the cap: ${JSON.stringify(before)}`);
	assert.equal(shown.shown, true, JSON.stringify(shown));
	assert.equal(shown.rel, true, 'the card is anchored to the window');
	if (shown.side === 'above') {
		assert.deepEqual([shown.point, shown.relPoint], ['BOTTOMLEFT', 'TOPLEFT']);
		assert.ok(shown.y >= 4, `a gap above the window, not an overlap: ${shown.y}`);
	} else {
		assert.deepEqual([shown.point, shown.relPoint], ['TOPLEFT', 'BOTTOMLEFT']);
		assert.ok(shown.y <= -4, `a gap below the window, not an overlap: ${shown.y}`);
	}
	const together = shown.h + Math.abs(shown.y) + shown.card;
	assert.ok(together <= shown.cap + 0.5, `window, gap and card keep to the cap together: ${together} > ${shown.cap}`);
	assert.ok(shown.h < before.h - 0.5, 'the goals give up the room the card takes');
	assert.equal(gone.shown, false);
	assert.ok(Math.abs(gone.h - before.h) < 0.5, `dismissed, the window takes its room back: ${JSON.stringify(gone)}`);
});

test('under the cap the goals scroll in whole rows: every stop and the last one start on a row', () => {
	const [first, stops] = run(`
		local last = goals.psContentH - goals.psViewH
		emit({ over = goals.psOver, scroll = goals:GetVerticalScroll(), onTop = onTop(goals:GetVerticalScroll()), last = last, lastOnTop = onTop(last) })
		local seen = {}
		stub.RunScript(goals, "OnMouseWheel", 1)
		for i = 1, 6 do
			stub.RunScript(goals, "OnMouseWheel", -1)
			local s = goals:GetVerticalScroll()
			seen[#seen + 1] = { s = s, onTop = onTop(s) or math.abs(s - last) < 0.5 }
		end
		for i = 1, 6 do
			stub.RunScript(goals, "OnMouseWheel", 1)
			local s = goals:GetVerticalScroll()
			seen[#seen + 1] = { s = s, onTop = onTop(s) }
		end
		emit(seen)`);
	assert.equal(first.over, true, JSON.stringify(first));
	assert.ok(first.scroll > 0, 'scrolled down to the current goal');
	assert.equal(first.onTop, true, `the current goal's scroll starts on a row: ${JSON.stringify(first)}`);
	assert.equal(first.lastOnTop, true, `the last stop starts on a row: ${JSON.stringify(first)}`);
	for (const s of stops) assert.equal(s.onTop, true, `every wheel stop starts on a row: ${JSON.stringify(stops)}`);
	assert.ok(stops.some((s, i) => i > 0 && s.s !== stops[i - 1].s), 'the wheel moves');
});
