'use strict';
// The quests a finished leveling guide leaves in the log, at its end, in
// every look: the guide window's end card (UI/GuideFrame.lua,
// GF.EndQuestLines: "10 quests in your log carry on to later guides" and
// "2 quests aren't part of your route" under "Up next"), the guide-end
// window (UI/GuideEnd.lua: "Carried to later guides", then "Not part of your
// route" and "Keep or abandon them"), and the two lists they open (the Quest
// room's "later" and "offroute"). A level 33 Human Warrior at the end of
// Wetlands & Hillsbrad Foothills (alliance 30-40/01), carrying every quest
// the guide hands on to a later guide (its compiled `carriedTo`) and two it
// never uses, Tharil'zun (19) and A Grim Task (304). The shot reads the
// guide as finished (no live step), as the engine does at its end. Shots:
// <look>-card, <look>-popup, <look>-offroute, <look>-later (studio
// guide-end-quests/hearth-card ...).

const skins = require('./skins');

const GUIDE = 'forever/alliance/30-40/01-hillsbrad-foothills';

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

// The log: the guide's carried quests and the two off the route; then the
// guide read as finished.
const SETUP = `local E, w = Polestar.Engine, stub.world
local g = E.GetGuide()
local seen = {}
for _, st in ipairs(g.steps) do
	for _, goal in ipairs(st.goals) do
		if goal.carriedTo and goal.quest and not seen[goal.quest] then
			seen[goal.quest] = true
			w.onQuest(goal.quest, { 1 }, goal.title)
		end
	end
end
w.onQuest(19, { 1 }, "Tharil'zun")
w.onQuest(304, { 1 }, "A Grim Task")
stub.fire("QUEST_LOG_UPDATE")
stub.advance(1)
E.GetStepIndex = function() return nil end
E.SkippedOut = function() return nil end
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Render()
stub.advance(0.5)`;

const POPUP = `Polestar.UI.GuideEnd.Show({ guideId = ${JSON.stringify(GUIDE)}, next = Polestar.Engine.GetGuide().next, undone = 0 })
stub.advance(1)`;

const LIST = (mode) => `Polestar.UI.ShowQuestRoom(${JSON.stringify(mode)}, ${JSON.stringify(GUIDE)})
stub.advance(0.5)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = `${skins.pick(id, folder, variant)}\n${SETUP}`;
	shots[`${name}-card`] = { title: `${name}: the end card, the two quest lines under "Up next"`, lua: base };
	shots[`${name}-popup`] = { title: `${name}: the guide-end window, carried and not part of the route`, capture: ['PolestarGuideEnd'], lua: `${base}\n${POPUP}` };
	shots[`${name}-offroute`] = { title: `${name}: "Not part of your route", each with Abandon`, capture: ['PolestarQuestRoom'], lua: `${base}\n${LIST('offroute')}` };
	shots[`${name}-later`] = { title: `${name}: "Carried to later guides", each with its guide`, capture: ['PolestarQuestRoom'], lua: `${base}\n${LIST('later')}` };
}

module.exports = {
	title: 'The guide\'s end: quests carried on and quests not part of the route, in every look',
	character: { race: 'Human', cls: 'WARRIOR', faction: 'Alliance', level: 33, money: 42000 },
	place: { map: 1437, x: 10.8, y: 60.4, zone: 'Wetlands', subzone: 'Menethil Harbor' },
	guide: { id: GUIDE },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	shots,
};
