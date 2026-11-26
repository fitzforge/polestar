'use strict';
// Guide kinds (Core/Guides.lua, GuideKinds; docs/GUIDE_FORMAT.md, "Guide kind"): a profession guide's window
// in the shipped Tailoring 1-300 guide, for a level 27 Orc with Tailoring 87 of 150 in Ashenvale on the 75-150
// Get Wool Cloth step: the skill line where the XP line was, no pace, no quest hand-in rows; its ⋯ menu leads
// with the materials and the nearest Tailoring trainer, without Free mode or the quest log clean-up. Render with
// --checkout <worktree> for another branch (before: the branch without kinds).

const TAILORING = 197; // SkillLine: Tailoring

const OPEN = `local w, E = stub.world, Polestar.Engine
w.learnSkill(${TAILORING}, "Tailoring", 87, 150)
w.addItem(2592, 8)
stub.fire("SKILL_LINES_CHANGED")
E.SetGuide("forever/professions/tailoring")
stub.advance(2)
local at
for i = 1, E.GetStepCount() do
	local v = E.GetStepView(i)
	if v and v.title == "Get Wool Cloth" then at = i end
end
if at then E.Goto(at) end
stub.advance(2)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

const MENU = `local GF = Polestar.UI.GuideFrame
GF.OpenMenu(GF.menuButton)
stub.advance(0.3)`;

module.exports = {
	title: 'Guide kinds: a profession guide shows its skill, not XP, and its own menu (guide-kinds)',
	character: { race: 'Orc', cls: 'WARRIOR', faction: 'Horde', level: 27, money: 500000 },
	place: { map: 1440, x: 50.0, y: 60.0, zone: 'Ashenvale', subzone: '' },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	capture: ['PolestarGuideFrame'],
	shots: {
		getit: { title: 'Tailoring 87/150, Get Wool Cloth (75-150): the why line, the farm line, the skill line at the foot', lua: OPEN },
		menu: { title: 'The ⋯ menu of a profession guide: materials and the nearest Tailoring trainer first', capture: ['PolestarGuideFrame', 'PolestarMenu'], lua: `${OPEN}\n${MENU}` },
	},
};
