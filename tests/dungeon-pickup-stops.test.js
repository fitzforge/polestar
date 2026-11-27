'use strict';
// The pick-up guide's stops on the real dungeon pages (Dungeons/Pickup.lua, route): givers who stand within
// the leveling stop's reach (60 yards) of one another are one step, not one step each. Stratholme's Light's
// Hope givers (Betina Bigglezink, Smokey LaRue, Leonid Barthalomew, Duke Nicholas Zverenhoff stand within 2
// map units of each other) and its two givers in one spot (Lilith the Lithe, Seril Scourgebane). Needs the
// built Codex (local; skipped without it); a map unit is 10 yards here, the maps' own sizes are not in the
// test world. The rule on a world of our own: tests/dungeon-outside.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, ADDONS } = require('./helpers/lua');
const { localPacks } = require('./helpers/profile');

const skip = !fs.existsSync(path.join(ADDONS, 'Polestar_Codex', 'Polestar_Codex.toc')) && 'the Codex is not built (forge data codex)';

function steps(faction, race) {
	const packs = localPacks();
	const [out] = runAddon({
		stubs: ['stub_world.lua', ...packs.stubs],
		before: packs.before,
		addons: ['Polestar'],
		login: true,
		script: `
local w = stub.world
w.level, w.race, w.raceName, w.faction = 60, "${race}", "${race}", "${faction}"
w.class, w.className = "WARRIOR", "WARRIOR"
Polestar.Dungeons.Load()
Polestar.Compat.MapToWorld = function(m, x, y) return 0, (x or 0) * 10, (y or 0) * 10 end
local def = Polestar.Dungeons.PickupGuide("stratholme")
local out = {}
for i, s in ipairs(def.steps) do
	local names = {}
	for _, g in ipairs(s.goals) do if g.t == "accept" and g.npcName then names[#names + 1] = g.npcName end end
	out[i] = names
end
emit(out)`,
	}).emitted;
	return out.map((n) => Object.values(n));
}

for (const [faction, race] of [['Horde', 'Orc'], ['Alliance', 'Human']]) {
	test(`Stratholme's givers who stand together are one step (${faction})`, { skip }, () => {
		const list = steps(faction, race);
		const has = (...names) => list.some((s) => names.every((n) => s.includes(n)));
		assert.ok(has('Betina Bigglezink', 'Smokey LaRue', 'Leonid Barthalomew the Revered', 'Duke Nicholas Zverenhoff'), JSON.stringify(list.slice(0, 4)));
		assert.ok(has('Lilith the Lithe', 'Seril Scourgebane'), JSON.stringify(list));
		// Not one step for them all: the two places are a continent apart.
		assert.ok(!has('Betina Bigglezink', 'Lilith the Lithe'));
	});
}
