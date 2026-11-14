'use strict';
// Goals underground: the arrow leads to the cave's mouth before a target that
// lies inside a cave or mine, since a straight line to it ends on the ground
// above. Each case is a player report: the authored guide compiled with the
// real reference data, the last located goal before the target must be a
// `goto` at the mouth, and the step's tip must say the target is underground.
//
// Needs data/forever (forge data build); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { compileSources, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { loadData } = require('../tools/lib/dsl/data');
const { DATA } = require('../tools/lib/paths');

const skip = needs('quests.json', 'npcs.json', 'objects.json');

const CASES = [
	{
		// Verium: the arrow sent him onto the hill above the Fargodeep Mine.
		guide: 'forever/alliance/human/01-elwynn-forest.guide',
		target: (g) => g.t === 'collect' && g.item === 981, // Bernice's Necklace, from Goldtooth
		mouth: { map: 1429, x: 39.5, y: 82.4 }, // players' reports (quests 87, 62) put the entrance near 39.5,82.4
		tip: /inside the Fargodeep Mine/,
	},
	{
		// Mightie: the Sapphires are in the tunnels to the Blackfathom Deeps portal, not on the strand.
		guide: 'forever/horde/07-ashenvale.guide',
		target: (g) => g.t === 'collect' && g.item === 16784, // Sapphire of Aku'Mai
		mouth: { map: 1440, x: 14.5, y: 14.2 }, // the client's Blackfathom Deeps entrance, the ruins' pit
		tip: /tunnels leading to the Blackfathom Deeps portal/,
	},
	...['dwarf', 'gnome'].map((race) => ({
		// Turesh: in Coldridge Valley the arrow pointed above ground, at Grik'nir inside the troll cave.
		guide: `forever/alliance/${race}/01-dun-morogh.guide`,
		target: (g) => g.t === 'collect' && g.item === 2004, // Grelin Whitebeard's Journal, from Grik'nir the Cold
		mouth: { map: 1426, x: 26.93, y: 80.03 }, // marked in game (PR #16)
		tip: /inside the troll cave/,
	})),
	{
		// Onrevax (#392): the Whispering Elixir bottles are in the basement under Shadowvale's ruined house.
		guide: 'forever/horde/undead/01-tirisfal-glades.guide',
		target: (g) => g.t === 'collect' && g.item === 268801, // Bottle of Whispering Elixir
		mouth: { map: 1420, x: 12.9, y: 65.7 }, // players' notes on quest 95314 in Forever's quest data: "entrance to the basement at 12.9, 65.7"
		tip: /basement under the ruined house/,
	},
	{
		// The same basement: a Paladin's Faintly Glowing Bones drop from its Lurchers and Mystics.
		guide: 'forever/horde/undead/01-tirisfal-glades.guide',
		target: (g) => g.t === 'collect' && g.item === 286259, // Faintly Glowing Bone
		mouth: { map: 1420, x: 12.9, y: 65.7 }, // players' notes on quest 99152: "entrance is in a burned house at 13,65", "these NPCs can be found underground"
		tip: /basement under the ruined house/,
	},
	...[3940, 3941, 3942].map((npc) => ({
		// Bennistrov (#1336): Insane Druids' arrow led over the hill above The Dor'Danil Barrow Den, not into it.
		// (Optional since #1415's vWL4; the entrance step stays, as #1336 and #1341 promised.)
		guide: 'forever/alliance/06-wetlands.guide',
		target: (g) => g.t === 'kill' && g.quest === 1012 && g.npc === npc, // Taneel Darkwood, Uthil Mooncall, Mavoris Cloudsbreak
		mouth: { map: 1440, x: 75.95, y: 75.45 }, // players' recordings: where 2 people walked in and out of the barrow; the reporter stood there
		tip: /inside The Dor'Danil Barrow Den[^.]*go in at its mouth/,
	})),
	...[
		(g) => g.t === 'collect' && g.item === 3405, // Raven Claw Talisman, the first relic chest
		(g) => g.t === 'accept' && g.quest === 2541, // The Sleeping Druid, from Oben Rageclaw in its depths
	].map((target) => ({
		// #1336 sweep (Pynte, #583): the walking maps have no way into the Ban'ethil Barrow Den, so the arrow crossed the hill.
		guide: 'forever/alliance/nightelf/01-teldrassil.guide',
		target,
		mouth: { map: 1438, x: 44.3, y: 57.9 }, // players' recordings: where 18 people walked into the barrow
		tip: /sleeps in its depths, and the four relic chests sit in the lower rooms/,
	})),
	{
		// The same barrow in the Darnassus reputation guide's Dolanaar hub (#1336 sweep).
		guide: 'forever/reputation/darnassus.guide',
		target: (g) => g.t === 'collect' && g.item === 3405, // Raven Claw Talisman
		mouth: { map: 1438, x: 44.3, y: 57.9 },
		tip: /relics of Wakening lie in the Ban'ethil Barrow Den/,
	},
	{
		// #1506: the walking maps have no way into Algaz Station, Captain Rugelfuss's bunker at the tunnel post,
		// from anywhere in Loch Modan, so the arrow drew a straight line from the trogg site.
		guide: 'forever/alliance/03-loch-modan.guide',
		target: (g) => g.t === 'turnin' && g.quest === 86585, // Banner of the Fallen, to Captain Rugelfuss
		mouth: { map: 1432, x: 23.5, y: 75.6 }, // players' recordings: 16 people walked in at 23.33,75.75 -> 23.33,74.55
		tip: /inside the bunker at the tunnel post: go in by its door/,
	},
];

let data;
function compiled(guide) {
	data = data || loadData(DATA);
	const file = path.join(OFFICIAL_DIR, guide);
	const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], data);
	assert.equal(guides.length, 1, `${guide} compiles`);
	return guides[0];
}

for (const c of CASES) {
	test(`${c.guide}: the arrow reaches the target through the cave mouth at ${c.mouth.x},${c.mouth.y}`, { skip }, () => {
		const goals = compiled(c.guide).steps.flatMap((step) => step.goals.map((goal) => ({ step, goal })));
		const at = goals.findIndex(({ goal }) => c.target(goal));
		assert.ok(at > 0, 'the target goal is in the guide');
		// (Other work of the target's own step, done in the same basement after the mouth's goto, is
		// not a waypoint on the way in: the Shadowvale step's bottles before a Paladin's bones.)
		const before = goals.slice(0, at).reverse().find(({ step, goal }) => goal.map != null && goal.x != null && (step !== goals[at].step || goal.t === 'goto'));
		assert.ok(before, 'a located goal comes before the target');
		const { t, map, x, y } = before.goal;
		assert.deepEqual({ t, map, x, y }, { t: 'goto', ...c.mouth }, `the waypoint before "${goals[at].step.title}" is the mouth`);
		assert.match(goals[at].step.note || '', c.tip);
	});
}

// Goals underground where the walking maps do join the cave or mine: the goal carries its floor's height, so the
// arrow's walk goes in through the mouth instead of ending on the hill over the target (heights.js: an objective's
// object or creature, or the objects its item comes out of; a collect's sources; a goto leading to a goal with one).
// Each case is a player report.
const FLOORS = [
	{
		// Pilsnerinn (#2126): the Filled Etched Phial is used on the Ancient Brazier deep in Splithoof Hold, and the
		// arrow went up the Great Lift to the hill over the cave instead of in at its mouth.
		guide: 'forever/horde/07-ashenvale.guide',
		target: (g) => g.t === 'use' && g.quest === 1197 && g.oi === 1,
		z: -70.5, // the Ancient Brazier's spawn (spawnz.json), the object the Cloven Hoof comes out of
	},
	{
		// Redrett (#1782): the Rod of Helcular at the Flames of Azel and Veraz, in the Foothill Caverns under Darrow Hill.
		guide: 'forever/horde/30-40/01-hillsbrad-foothills.guide',
		target: (g) => g.t === 'use' && g.quest === 553 && g.oi === 1,
		z: 72.9, // the Flame of Azel's spawn (spawnz.json)
	},
	{
		guide: 'forever/horde/30-40/01-hillsbrad-foothills.guide',
		target: (g) => g.t === 'use' && g.quest === 553 && g.oi === 2,
		z: 53.5, // the Flame of Veraz, a level down
	},
	{
		// Redrett (#1786): "Azurelode Mine" leads to the Hillsbrad Miners inside, not onto the hill over the tunnels.
		guide: 'forever/horde/30-40/01-hillsbrad-foothills.guide',
		target: (g) => g.t === 'goto' && g.area === 288 && g.x === 28.5 && g.y === 55,
		z: 21.3, // the miners' kill goal it leads to
	},
];

for (const c of FLOORS) {
	test(`${c.guide}: a goal underground carries its floor's height (${c.z})`, { skip }, () => {
		const goal = compiled(c.guide).steps.flatMap((step) => step.goals).find(c.target);
		assert.ok(goal, 'the target goal is in the guide');
		assert.equal(goal.z, c.z, JSON.stringify(goal));
	});
}
