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
	{
		// Turesh: in Coldridge Valley the arrow pointed above ground, at Grik'nir inside the troll cave.
		guide: 'forever/alliance/dwarf-gnome/01-dun-morogh.guide',
		target: (g) => g.t === 'collect' && g.item === 2004, // Grelin Whitebeard's Journal, from Grik'nir the Cold
		mouth: { map: 1426, x: 26.93, y: 80.03 }, // marked in game (PR #16)
		tip: /inside the troll cave/,
	},
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
