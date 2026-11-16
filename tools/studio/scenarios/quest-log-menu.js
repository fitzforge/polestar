'use strict';
// Show in quest log, in every skin: a quest's line in the guide window
// right-clicked (Tick it done, Show in quest log, Skip this quest), and a
// While you're here line right-clicked (Show in quest log, Not now), with
// that line's tooltip. A Tauren Hunter at 18 on the shipped Barrens guide,
// played 39 steps, as in the skins scenario. The While-here line is a later
// step's objective of a quest in the log, shown as the Engine lists one
// (the stub world has nothing in reach at that spot).

const skins = require('./skins');

// The client's opener of the quest log at a quest (the stub client has none).
const OPENER = 'QuestMapFrame_OpenToQuestDetails = QuestMapFrame_OpenToQuestDetails or function() end';

// Right-clicks the first shown goal row of the step whose quest is in the log.
const GOAL_MENU = `${OPENER}
local GF = Polestar.UI.GuideFrame
local C = Polestar.Compat
local hit
for _, r in ipairs(GF.rows) do
	if r:IsShown() and r.psGoal and r.psGoal.quest and C.IsOnQuest(r.psGoal.quest) then hit = r break end
end
if not hit then
	for _, r in ipairs(GF.rows) do
		if r:IsShown() and r.psGoal and r.psGoal.quest then hit = r break end
	end
end
assert(hit, "no quest row")
hit:GetScript("OnClick")(hit, "RightButton")
stub.advance(0.3)`;

// A later step's objective of a quest in the log as the one While-here
// line, then its row right-clicked (or hovered, for the tooltip).
const HERE = `${OPENER}
local E, C, GF = Polestar.Engine, Polestar.Compat, Polestar.UI.GuideFrame
local live = E.GetLiveStep()
local line
for s = live + 1, E.GetStepCount() do
	local v = E.GetStepView(s)
	for _, g in ipairs(v and v.goals or {}) do
		if g.quest and (g.t == "kill" or g.t == "collect") and (g.status == "active" or g.status == "pending") and C.IsOnQuest(g.quest) then
			line = {}
			for k, x in pairs(g) do line[k] = x end
			line.step, line.here, line.yards = s, "work", 48
			break
		end
	end
	if line then break end
end
assert(line, "no later objective of a quest in the log")
E.GetWhileHereList = function() return { line } end
E.GetWhileHere = function() return line end
Polestar.Fire("WHILE_HERE_CHANGED")
stub.advance(1)
local row = GF.parts.here.Rows[1]
assert(row and row:IsShown(), "no While-here row")`;

const HERE_MENU = `${HERE}
row:GetScript("OnClick")(row, "RightButton")
stub.advance(0.3)`;

const HERE_TIP = `${HERE}
studio.hover(row)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(skins.SKINS)) {
	const base = skins.pick(id, folder, variant);
	shots[`${name}-goal`] = { title: `${name}: a quest's line right-clicked: Show in quest log in its menu`, capture: ['PolestarGuideFrame', 'PolestarMenu'], lua: `${base}\n${GOAL_MENU}` };
	shots[`${name}-here`] = { title: `${name}: a While you're here line right-clicked: Show in quest log, Not now`, capture: ['PolestarGuideFrame', 'PolestarMenu'], lua: `${base}\n${HERE_MENU}` };
	shots[`${name}-here-tip`] = { title: `${name}: the While you're here line's tooltip`, capture: ['PolestarGuideFrame', 'GameTooltip'], lua: `${base}\n${HERE_TIP}` };
}

module.exports = {
	title: 'Show in quest log: the menus of a quest line and a While you\'re here line, in every skin',
	character: skins.character,
	place: skins.place,
	guide: skins.guide,
	settings: { 'behavior.offerClassQuests': false, 'dungeons.headsUp': false },
	window: skins.window,
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	shots,
};
