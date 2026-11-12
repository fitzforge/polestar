'use strict';
// A profession guide starts where the character is (0.3.7, professions-start):
// the skill range as a heading over its steps (Engine.GetStepView(i).section,
// UI/GuideFrame.lua) and in the step overview (GF.ShowOverview, a click on the
// step number). A level 60 Orc opens the shipped First Aid 1-300 guide with
// First Aid at 120 of 150, then at 1 of 75 (just learned). Needs a checkout
// with the compiled pack carrying `section` (--checkout <worktree>).

const FIRST_AID = 129; // SkillLine: First Aid

const OPEN = (rank, max) => `local w, E = stub.world, Polestar.Engine
${rank === null ? '' : `w.learnSkill(${FIRST_AID}, "First Aid", ${rank}, ${max})`}
stub.fire("SKILL_LINES_CHANGED")
E.SetGuide("forever/professions/first-aid")
stub.advance(2)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

// The step number's click (its hit frame), as the player opens it.
const OVERVIEW = `local GF = Polestar.UI.GuideFrame
stub.RunScript(GF.parts.nav.Steps.Hit, "OnMouseUp", "LeftButton")
stub.advance(0.3)`;

module.exports = {
	title: 'Profession guides start where you are: the skill range heading (professions-start)',
	character: { race: 'Orc', cls: 'WARRIOR', faction: 'Horde', level: 60, money: 500000 },
	place: { map: 1454, x: 54.0, y: 68.0, zone: 'Orgrimmar', subzone: 'Valley of Spirits' },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	capture: ['PolestarGuideFrame'],
	shots: {
		'skill-120': { title: 'First Aid 120/150: the heading "First Aid 115-125" in the accent, the live step its bandages', lua: OPEN(120, 150) },
		'skill-120-overview': {
			title: 'The step overview at 120: the range headings between the steps, the current one in the accent',
			capture: ['PolestarGuideFrame', 'PolestarMenu'],
			lua: `${OPEN(120, 150)}\n${OVERVIEW}`,
		},
		'skill-1': { title: 'First Aid just learned (1/75): "First Aid 1-40", step 1', lua: OPEN(1, 75) },
		'skill-none': { title: 'No First Aid yet: "First Aid 1-40", step 1 (Learn First Aid)', lua: OPEN(null) },
	},
};
