'use strict';
// A `turnin ... direct` in every look: the quest its giver offers and takes
// back in one talk reads "Hand in" with "<giver> offers it and takes it back
// in one talk: it never goes in your quest log" under it (Core/Engine.lua,
// Own.directText; UI.GoalSubline), where a plain turn-in reads "Turn in". A
// level 41 Orc Warrior on the shipped Stranglethorn Vale guide (horde
// 40-50/01) at "Witch Doctor Unbagwa", carrying Fin Fizracket's Stranglethorn
// Fever (348). Shots: <look>-step, and <look>-turnin for a plain turn-in
// (Booty Bay) beside it (studio direct-turnin/hearth-step ...).

const skins = require('./skins');

const LOOKS = { polestar: ['polestar', null], halo: ['halo', null] };
for (const [name, look] of Object.entries(skins.SKINS)) if (!look[2]) LOOKS[name] = look;

const AT = (title) => `local E = Polestar.Engine
stub.world.onQuest(348, { 1 }, "Stranglethorn Fever")
stub.fire("QUEST_LOG_UPDATE")
stub.advance(1)
local g, at = E.GetGuide()
for i, st in ipairs(g.steps) do if st.title == ${JSON.stringify(title)} then at = i; break end end
assert(at, "no step ${title}")
E.Goto(at)
stub.advance(0.5)
studio.clearHeadsUps()
Polestar.UI.GuideFrame.Layout()
stub.advance(0.5)`;

const shots = {};
for (const [name, [id, folder, variant]] of Object.entries(LOOKS)) {
	const base = skins.pick(id, folder, variant);
	shots[`${name}-step`] = { title: `${name}: "Hand in Stranglethorn Fever" at Unbagwa, with its one-talk line`, lua: `${base}\n${AT('Witch Doctor Unbagwa')}` };
	shots[`${name}-turnin`] = { title: `${name}: plain turn-ins at Booty Bay, "Turn in"`, lua: `${base}\n${AT('Booty Bay')}` };
}

module.exports = {
	title: 'A direct turn-in ("Hand in", offered and taken in one talk) in every look',
	character: { race: 'Orc', cls: 'WARRIOR', faction: 'Horde', level: 41, money: 52000 },
	place: { map: 1434, x: 35.3, y: 60.4, zone: 'Stranglethorn Vale', subzone: 'Mistvale Valley' },
	guide: { id: 'forever/horde/40-50/01-stranglethorn-vale' },
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	stubs: skins.stubs,
	art: skins.art,
	capture: ['PolestarGuideFrame'],
	shots,
};
