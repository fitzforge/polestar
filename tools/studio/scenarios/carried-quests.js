'use strict';
// Quests a later guide hands in (#1683): the guide window's "Keep this: you
// hand it in later in Badlands" under a goal (UI.CarriedLine, a goal's
// `carriedTo`), and the guide-end window's "Carried to later guides" list
// (UI/GuideEnd.lua, Engine.CarriedQuests). A level 35 Human Warrior on the
// shipped Desolace guide (alliance 30-40/02) at "Tyranis and the Seer", the
// Sceptre of Light (quest 5741) in the log. The compiled guides predate the
// writer's `carriedTo`, so the shot puts it on 5741's goals as forge
// emits it (forever/alliance/30-40/06-badlands); the list's quests are set
// by the shot. Needs a checkout with UI.CarriedLine (--checkout <worktree>).

const GUIDE = 'forever/alliance/30-40/02-desolace';
const BADLANDS = 'forever/alliance/30-40/06-badlands';

const STEP = (title, extra = '') => `local E = Polestar.Engine
-- The quest first: taking it can move steps in the engine's route plan.
stub.world.accept(5741, { { "Sceptre of Light", 1 } }, "The Sceptre of Light")
stub.advance(1)
-- The engine's copy of the guide (its steps as the character sees them).
local g = E.GetGuide()
local at
for i, st in ipairs(g.steps) do
	for _, goal in ipairs(st.goals) do
		if goal.quest == 5741 then goal.carriedTo = "${BADLANDS}" end
	end
end
-- The step's place as the engine orders them (its route plan may move steps).
for i = 1, #g.steps do
	local v = E.GetStepView(i)
	if v and v.title == "${title}" then at = i; break end
end
assert(at, "no step ${title}")
${extra}
E.Goto(at)
stub.advance(0.5)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

const QUESTS = [
	[5741, 'The Sceptre of Light', BADLANDS],
	[1455, 'The Third Fleet', 'forever/alliance/30-40/05-arathi-highlands'],
	[1439, 'Search for Tyranis', 'forever/alliance/30-40/04b-stranglethorn-vale'],
	[1462, 'Kodo Roundup', BADLANDS],
	[5381, 'Hand of Iruxos', 'forever/alliance/30-40/05-arathi-highlands'],
	[1484, 'The Corrupter', BADLANDS],
	[6142, 'Clam Bait', 'forever/alliance/30-40/04-stranglethorn-vale'],
	[1437, 'Vahlarriel\'s Search', 'forever/alliance/30-40/06-badlands'],
];
const END = (n) => `local E, G = Polestar.Engine, Polestar.Guides
local list = {}
for i, q in ipairs(${JSON.stringify(QUESTS).replace(/\[/g, '{').replace(/\]/g, '}')}) do
	if i > ${n} then break end
	list[i] = { quest = q[1], title = q[2], guideId = q[3] }
end
E.CarriedQuests = function() return list end
local g = G.Get("${GUIDE}")
Polestar.UI.GuideEnd.Show({ guideId = g.id, next = g.next, undone = 0 })
stub.advance(0.5)`;

module.exports = {
	title: 'Carried quests: "Keep this" under a goal and the guide end\'s list (#1683)',
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 35, money: 52000 },
	place: { map: 1443, x: 53.0, y: 30.0, zone: 'Desolace', subzone: 'Thunder Axe Fortress' },
	guide: { id: GUIDE },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	capture: ['PolestarGuideFrame'],
	shots: {
		'keep-line': {
			title: 'Under "Collect Sceptre of Light": "Keep this: you hand it in later in Badlands"',
			lua: STEP('Tyranis and the Seer'),
		},
		'keep-only': {
			title: 'A goal with no other note: only the keep line under it ("Sceptre of Light" without its "on the top floor" note)',
			lua: STEP('Tyranis and the Seer', `for _, st in ipairs(E.GetGuide().steps) do
	for _, goal in ipairs(st.goals) do
		if goal.quest == 5741 then goal.note, goal.comment, goal.where = nil, nil, nil end
	end
end`),
		},
		'end-three': {
			title: 'The guide end with three carried quests',
			capture: ['PolestarGuideEnd'],
			lua: END(3),
		},
		'end-eight': {
			title: 'Eight carried quests: six, then "+2 more"',
			capture: ['PolestarGuideEnd'],
			lua: END(8),
		},
	},
};
