'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const before = String.raw`
local q = stub.qol
q.xp, q.rested = 500, 200
q.ids = { 11, 12, 13, 14 }
q.ready = { [11] = true, [13] = true, [14] = true }
q.rewards = { [11] = 250, [12] = 800, [13] = 0, [14] = 100 }
for _, id in ipairs(q.ids) do q.log[id] = true end
function C_QuestLog.GetNumQuestLogEntries() return #q.ids end
function C_QuestLog.GetInfo(i) return { questID = q.ids[i], title = "Quest " .. q.ids[i] } end
function C_QuestLog.ReadyForTurnIn(id) return q.ready[id] == true end
function C_QuestLog.GetTitleForQuestID(id) return "Quest " .. id end
q.rewardReads = 0
function GetQuestLogRewardXP(id) q.rewardReads = q.rewardReads + 1; return q.rewards[id] end
function GetAppropriateTooltip() return GameTooltip end
`;

function run(script) {
	return runAddon({
		stubs: ['stub_qol.lua'],
		before,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] }],
		login: true,
		script: String.raw`
local q, P = stub.qol, Polestar.QoL.QuestXP
local bar = q.xpBar()
bar.ExhaustionTick = CreateFrame("Button", nil, bar)
bar.StatusBar:SetValue(0.5)
local function native()
	GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	GameTooltip:SetText("Experience: 500 / 1000")
	GameTooltip:AddLine("Rested XP: 200")
	GameTooltip:Show()
end
bar:SetScript("OnEnter", native)
bar.ExhaustionTick:SetScript("OnEnter", native)
P.Refresh()
local f = P.frame
f:SetSize(565, 11) -- stub does not derive width from SetAllPoints
P.Refresh()
` + script,
	}).emitted;
}

test('projects only ready positive quest rewards and appends once after the native tooltip', () => {
	const [state, barTip, tickTip] = run(String.raw`
local f = P.frame
local _, _, _, left, bottom = f.Tint:GetPoint(1)
q.engine.levelTarget = 11
q.step({ { t = "level", level = 11 } })
local mark = Polestar.QoL.XPMark.frame
emit({ total = P.total, count = P.count, left = left, bottom = bottom, width = f.Tint:GetWidth(),
	fillHeight = f.Tint:GetHeight(), mask = f.Tint.mask:GetAtlas(),
	alpha = f:GetAlpha(), nativeValue = bar.StatusBar:GetValue(), nativeRested = q.rested,
	shown = f:IsShown(), level = f.LevelLabel:IsShown(), belowGuide = f:GetFrameLevel() < bar.OverlayFrame:GetFrameLevel(),
	guide = mark and mark.Label:GetText() })
stub.RunScript(bar, "OnEnter")
emit(GameTooltip.lines)
stub.RunScript(bar.ExhaustionTick, "OnEnter")
emit(GameTooltip.lines)
`);
	assert.deepEqual(state, { total: 350, count: 2, left: 282.5, bottom: 1.5, width: 196.75, fillHeight: 7,
		mask: 'UI-HUD-ExperienceBar-Fill-Experience', alpha: 0.8,
		nativeValue: 0.5, nativeRested: 200, shown: true, level: false, belowGuide: true, guide: 'Guide: 11' });
	assert.deepEqual(barTip, tickTip);
	assert.equal(barTip[0], 'Experience: 500 / 1000');
	assert.equal(barTip[1], 'Rested XP: 200');
	assert.equal(barTip.filter((line) => line.includes('Pending Quest XP')).length, 1);
	assert.ok(barTip.some((line) => line.includes('850 / 1000 (85.0%)')));
});

test('clamps level-up projection and removes handed-in or abandoned rewards immediately', () => {
	const [overflow, tip, turned, abandoned, off, maxed] = run(String.raw`
local reads = q.rewardReads
q.xp = 900
stub.fire("PLAYER_XP_UPDATE", "player"); stub.runTimers()
local f = P.frame
local _, _, _, left = f.Tint:GetPoint(1)
emit({ total = P.total, right = left + f.Tint:GetWidth(), level = f.LevelLabel:IsShown(), rescanned = q.rewardReads ~= reads })
stub.RunScript(bar, "OnEnter")
emit(GameTooltip.lines)
stub.fire("QUEST_TURNED_IN", 11, 250, 0); stub.runTimers()
emit({ total = P.total, count = P.count })
stub.fire("QUEST_REMOVED", 14); stub.runTimers()
emit({ total = P.total, shown = f:IsShown() })
Polestar.Set("qol.questXPOverlay", false); stub.runTimers()
emit({ shown = f:IsShown(), watches = Polestar.QoL.Watching("QUEST_LOG_UPDATE") })
Polestar.Set("qol.questXPOverlay", true); stub.runTimers()
q.level, q.rested = q.maxLevel, nil
stub.fire("PLAYER_LEVEL_UP", q.level); stub.runTimers()
emit({ total = P.total, shown = f:IsShown(), rested = q.rested or 0 })
`);
	assert.deepEqual(overflow, { total: 350, right: 562, level: true, rescanned: false });
	assert.ok(tip.some((line) => line.includes('at least +1 level')));
	assert.ok(!tip.some((line) => line.includes('XP after turn-ins')));
	assert.deepEqual(turned, { total: 100, count: 1 });
	assert.deepEqual(abandoned, { total: 0, shown: false });
	assert.deepEqual(off, { shown: false, watches: false });
	assert.deepEqual(maxed, { total: 0, shown: false, rested: 0 });
});

test('one toggle controls the overlay and the quest lines in the native tooltip', () => {
	const [none, disabled, enabled] = run(String.raw`
q.ready = {}
stub.fire("QUEST_LOG_UPDATE"); stub.runTimers()
stub.RunScript(bar, "OnEnter")
emit({ total = P.total, shown = P.frame:IsShown(), lines = GameTooltip.lines })
Polestar.Set("qol.questXPOverlay", false); stub.runTimers()
q.ready[11] = true
stub.fire("QUEST_LOG_UPDATE"); stub.runTimers()
P.frame:SetSize(450, 11); stub.RunScript(P.frame, "OnSizeChanged")
stub.RunScript(bar, "OnEnter")
emit({ shown = P.frame:IsShown(), lines = GameTooltip.lines })
Polestar.Set("qol.questXPOverlay", true); stub.runTimers()
stub.RunScript(bar, "OnEnter")
emit({ total = P.total, shown = P.frame:IsShown(), lines = GameTooltip.lines })
`);
	assert.deepEqual(none, { total: 0, shown: false, lines: ['Experience: 500 / 1000', 'Rested XP: 200'] });
	assert.deepEqual(disabled, { shown: false, lines: ['Experience: 500 / 1000', 'Rested XP: 200'] });
	assert.equal(enabled.total, 250);
	assert.equal(enabled.shown, true);
	assert.ok(enabled.lines.some((line) => line.includes('Pending Quest XP')));
});

test('the blue rested marker follows the native marker above the quest fill', () => {
	const [active, hidden, restored, disabled] = run(String.raw`
local tick = bar.ExhaustionTick
tick:SetFrameLevel(6)
P.Refresh()
local marker = f.Rested
local pip = marker:GetRegions()
local _, relativeTo = marker:GetPoint(1)
local r, _, b = pip:GetVertexColor()
emit({ shown = marker:IsVisible(), followsTick = relativeTo == tick, blue = b > r,
	above = marker:GetFrameStrata() == f:GetFrameStrata() and marker:GetFrameLevel() > math.max(f:GetFrameLevel(), tick:GetFrameLevel()),
	mouse = marker:IsMouseEnabled() })
tick:Hide(); stub.runTimers()
emit(not marker:IsVisible())
tick:Show(); stub.runTimers()
emit(marker:IsVisible())
Polestar.Set("qol.questXPOverlay", false); stub.runTimers()
emit({ marker = marker:IsVisible(), native = tick:IsShown() })
`);
	assert.deepEqual(active, { shown: true, followsTick: true, blue: true, above: true, mouse: false });
	assert.equal(hidden, true);
	assert.equal(restored, true);
	assert.deepEqual(disabled, { marker: false, native: true });
});

test('missing reward data contributes nothing until it becomes available', () => {
	const [missing, loaded] = run(String.raw`
local reward = GetQuestLogRewardXP
GetQuestLogRewardXP = nil
stub.fire("QUEST_LOG_UPDATE"); stub.runTimers()
emit({ total = P.total, shown = P.frame:IsShown() })
GetQuestLogRewardXP = reward
stub.fire("QUEST_DATA_LOAD_RESULT", 11, true); stub.runTimers()
emit({ total = P.total, shown = P.frame:IsShown() })
`);
	assert.deepEqual(missing, { total: 0, shown: false });
	assert.deepEqual(loaded, { total: 350, shown: true });
});

test('shows quest XP on hover when the native tooltip is absent and hides it on leave', () => {
	const [barTip, barHidden, tickTip, tickHidden, otherTip] = run(String.raw`
bar:SetScript("OnEnter", nil)
bar.ExhaustionTick:SetScript("OnEnter", nil)
GameTooltip:Hide()
stub.RunScript(bar, "OnEnter")
emit({ shown = GameTooltip:IsShown(), lines = GameTooltip.lines, owner = GameTooltip:GetOwner() == bar })
stub.RunScript(bar, "OnLeave")
emit(not GameTooltip:IsShown())
stub.RunScript(bar.ExhaustionTick, "OnEnter")
emit({ shown = GameTooltip:IsShown(), lines = GameTooltip.lines, owner = GameTooltip:GetOwner() == bar.ExhaustionTick })
stub.RunScript(bar.ExhaustionTick, "OnLeave")
emit(not GameTooltip:IsShown())
GameTooltip:SetOwner(CreateFrame("Frame"), "ANCHOR_TOP")
GameTooltip:SetText("Another tooltip")
GameTooltip:Show()
stub.RunScript(bar, "OnEnter")
emit(GameTooltip.lines)
`);
	assert.deepEqual(barTip, tickTip);
	assert.equal(barTip.shown, true);
	assert.equal(barTip.owner, true);
	assert.ok(barTip.lines.includes('Current XP | 500 / 1000 (50.0%)'));
	assert.ok(barTip.lines.some((line) => line.includes('Pending Quest XP')));
	assert.equal(barHidden, true);
	assert.equal(tickHidden, true);
	assert.deepEqual(otherTip, ['Another tooltip']);
});

test('updates while the interface is hidden and follows the native bar to another container', () => {
	const [hidden, moved] = run(String.raw`
UIParent:Hide()
q.ready = {}
stub.fire("QUEST_LOG_UPDATE"); stub.runTimers()
UIParent:Show()
emit({ total = P.total, shown = P.frame:IsShown() })
q.ready[11] = true
stub.fire("QUEST_LOG_UPDATE"); stub.runTimers()
local nextBar = StatusTrackingBarManager.barContainers[2].bars[StatusTrackingBarInfo.BarsEnum.Experience]
bar:Hide()
nextBar:Show(); stub.runTimers()
emit({ total = P.total, moved = P.frame:GetParent() == nextBar, shown = P.frame:IsShown() })
`);
	assert.deepEqual(hidden, { total: 0, shown: false });
	assert.deepEqual(moved, { total: 250, moved: true, shown: true });
});

test('registers only one quest XP toggle in Trackers / Experience', () => {
	const [settings] = run(String.raw`
local found = {}
for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
	for _, control in ipairs(spec.controls) do
		if control.key and control.key:find("^qol.questXP") then
			found[control.key] = { tab = spec.tab, section = spec.section, kind = control.kind, help = type(control.help) == "string" and control.help ~= "",
				default = Polestar.GetDefault(control.key) }
		end
	end
end
emit(found)
`);
	assert.deepEqual(settings, {
		'qol.questXPOverlay': { tab: 'Trackers', section: 'Experience', kind: 'toggle', help: true, default: true },
	});
});

test('a repeatable quest can be turned in and accepted again while quest XP is off', () => {
	const [ready] = run(String.raw`
stub.fire("QUEST_TURNED_IN", 11, 250, 0); stub.runTimers()
Polestar.Set("qol.questXPOverlay", false)
stub.runTimers()
q.log[11] = nil
q.log[11], q.ready[11] = true, true
Polestar.Set("qol.questXPOverlay", true); stub.runTimers()
emit({ total = P.total, count = P.count, shown = P.frame:IsShown() })
`);
	assert.deepEqual(ready, { total: 350, count: 2, shown: true });
});
