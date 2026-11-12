'use strict';
// Dynamic Questing 0.3.7 (feat/dynquest-037): a flight path you pass in
// "While you're here" (Engine Own.hereFly: "Learn the flight path at
// Thelsamar"), a travel step's line saying what it is for (#1588: "For
// Prospector Stormpike's quests"), and the Options page's "Flight paths you
// pass". A Dwarf Warrior on the shipped Loch Modan guide (alliance/03),
// played up to the step each shot needs; Ironforge's flight path known
// (taxi node 6), Thelsamar's (node 8) not.

const GUIDE = 'forever/alliance/03-loch-modan';

// Play the guide until the live step is `title` (its `n`th such step), then
// the character's level, known flight paths and place.
const AT = (title, n, place, quest) => `local E, w = Polestar.Engine, stub.world
-- The Discarded Fishing Toolbox (86614, from the loch bed) in the log and done,
-- so Thelsamar's step (hand it in, take 436) is on: the stub world cannot
-- dive for it.
if not w.log[86614] then w.accept(86614, {}, "Discarded Fishing Toolbox") end
w.finish(86614)
stub.advance(1)
local function title() local v = E.GetStepView(E.GetStepIndex()); return v and v.title end
-- Stops where the live step holds an open goal of the quest asked (when given), else at the n-th step titled so.
local function holds(q)
	local v = E.GetStepView(E.GetStepIndex())
	for _, g in ipairs(v and v.goals or {}) do if g.quest == q and g.status ~= "done" then return true end end
	return false
end
local seen, last = 0, nil
for _ = 1, 160 do
	local i = E.GetStepIndex()
	${quest ? `if holds(${quest}) then break end
	-- The step that takes it is next: skip the rest up to it, as a player who did them elsewhere.
	local g = E.GetGuide()
	for s = i + 1, #g.steps do
		local hit = false
		for _, goal in ipairs(g.steps[s].goals) do if goal.quest == ${quest} and goal.t == "accept" then hit = true end end
		if hit then E.SkipUpTo(s); stub.advance(1); break end
	end
	if holds(${quest}) then break end` : `if title() == "${title}" and i ~= last then seen = seen + 1; last = i end
	if seen >= ${n} then break end`}
	local r = play.doGoal()
	if r == "noguide" then break elseif r == "stuck" then E.Next(); stub.advance(0.6) end
end
assert(title() == "${title}", "not at ${title}: " .. tostring(title()))
w.level = 17
local flags = Polestar.CharState().flags
flags.taxi = { [6] = true }
flags.fp = nil
w.moveTo(1432, ${place[0]}, ${place[1]}); play.syncZone()
w.zone, w.subzone = "Loch Modan", "Thelsamar"
stub.advance(2)
${quest ? `-- Steps before it still open: skipped one by one, so it is the live step.
for _ = 1, 40 do
	local live = E.GetLiveStep()
	if not live or holds(${quest}) and E.GetStepIndex() == live then break end
	E.Goto(live)
	if holds(${quest}) then break end
	E.Skip()
	stub.advance(0.5)
end` : ''}
stub.advance(5)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(1)`;

// The While-here row whose text holds `text`: hovered.
const HOVER_ROW = (text) => `local function find(f, d)
	if d > 14 or not f then return nil end
	for _, r in ipairs({ f:GetRegions() }) do
		local t = r.GetText and r:GetText()
		if type(t) == "string" and t:find("${text}", 1, true) and r:IsVisible() then return f end
	end
	for _, c in ipairs({ f:GetChildren() }) do local hit = find(c, d + 1); if hit then return hit end end
end
local row = find(PolestarGuideFrame, 0)
while row and not row:GetScript("OnEnter") do row = row:GetParent() end
assert(row, "no row with ${text}")
studio.hover(row)`;

// Options > Guide > Window, scrolled to the Dynamic Questing section (its
// help is written under each row, no hover needed).
const OPTIONS = `Polestar.UI.ShowOptions("guide")
stub.advance(0.3)
Polestar.UI.Options.Select("guide", "Window")
stub.advance(0.5)
local sf = PolestarOptions.Scroll
local child = sf and sf:GetScrollChild()
local function find(f, d)
	if d > 16 or not f then return nil end
	for _, r in ipairs({ f:GetRegions() }) do
		local t = r.GetText and r:GetText()
		if t == "Dynamic Questing" and r:IsVisible() then return r end
	end
	for _, c in ipairs({ f:GetChildren() }) do local hit = find(c, d + 1); if hit then return hit end end
end
local head = child and find(child, 0)
assert(head, "no Dynamic Questing heading")
local _, hy = play.rectOf(head)
local _, cy = play.rectOf(child)
Polestar.Widgets.ScrollTo(sf, hy - cy - 12)
stub.advance(0.5)`;

module.exports = {
	title: 'Dynamic Questing 0.3.7: flight paths you pass, what a travel step is for, the options',
	character: { race: 'Dwarf', cls: 'WARRIOR', faction: 'Alliance', level: 12, money: 9000 },
	guide: { id: GUIDE },
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: [1440, 690],
	capture: ['PolestarGuideFrame', 'GameTooltip'],
	shots: {
		'flight-row': {
			title: 'At Thelsamar (turn in 86614, take 436), ~20 yd from the flight master: "Learn the flight path at Thelsamar"',
			lua: AT('Thelsamar', 1, [34.6, 50.6], 436),
		},
		'flight-row-hover': {
			title: 'The same, the row hovered',
			lua: `${AT('Thelsamar', 1, [34.6, 50.6], 436)}\n${HOVER_ROW('Learn the flight path')}`,
		},
		'travel-purpose': {
			title: '"Fly to Ironforge": "For Prospector Stormpike\'s quests" under it',
			lua: AT('Fly to Ironforge', 1, [36.0, 46.0]),
		},
		options: {
			title: 'Options > Guide > Window, Dynamic Questing: "How close" with its help, "Flight paths you pass" under the hand-ins slider',
			capture: ['PolestarOptions', 'GameTooltip'],
			lua: OPTIONS,
		},
	},
};
