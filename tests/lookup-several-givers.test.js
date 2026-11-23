'use strict';
// A quest several NPCs give (#3368, Zack: Camp Mojache, one herald in each Horde capital). Lookup's guides used
// to take it from the giver nearest where the guide was built and kept that one: a Tauren standing beside Bluff
// Runner Windstrider in Thunder Bluff was still sent to Warcaller Gorlach in Orgrimmar. Now the accept carries
// every giver of the character's side as `candidates`, and the Engine picks the nearest again on step start,
// zone change and landing, as it does for `train` and `vendor nearest` goals. Givers of the other side never come
// into it. Synthetic Codex (tests/fixtures/codex/lookup.json), real Core, Lookup and Dungeons.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack } = require('./helpers/codex');
const { luaValue } = require('../tools/lib/playtest');

const DELIVERY = 9950; // given in Amber Vale (9001) and in Ember Hollow (9002), handed in to Captain Hale
const TAKE = 9951; // the dungeon's quest, after the delivery
const ROWAN = 5008; // Amber Vale 48,50 (the fixture's)
const WARDEN = 5030; // Ember Hollow 50,50
const GRUNT = 5031; // Ember Hollow 51,50, the Horde's
const TITLE = 'Word for the Captain';

function fixture() {
	const codex = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures/codex/lookup.json'), 'utf8'));
	const npc = (id, name, faction, map, x, y) => ({ id, name, level: 25, levelMax: null, faction, rare: false, elite: false, boss: false,
		instance: null, roles: ['questgiver'], spawns: [{ map, x, y, f: 'e' }] });
	codex.npcs[WARDEN] = npc(WARDEN, 'Warden Ash', 'A', 9002, 50, 50);
	codex.npcs[GRUNT] = npc(GRUNT, 'Grunt Mosk', 'H', 9002, 51, 50);
	const quest = (id, title, start, pre, objectives) => ({
		id, title, level: 18, minLevel: 10, faction: 'A', races: null, classes: null,
		start: { npc: start, object: [], item: [] }, end: { npc: [5009], object: [] },
		pre, preAny: [], objectives, zone: 9001, rewards: [], choices: [],
	});
	codex.quests[DELIVERY] = quest(DELIVERY, TITLE, [ROWAN, WARDEN, GRUNT], [], []);
	codex.quests[TAKE] = quest(TAKE, 'Into the Crypt', [5009], [DELIVERY], [{ type: 'kill', id: 5013, count: 1, text: 'Lord Ashcroft' }]);
	return codex;
}

const dungeon = { name: 'Ashen Crypt', minLevel: 18, maxLevel: 26, entrance: { map: 9001, x: 30, y: 70, f: 'e' }, quests: { A: 1, H: 0 } };
const page = { quests: [{ id: TAKE, title: 'Into the Crypt', faction: 'A', level: 18, minLevel: 10,
	start: { kind: 'npc', id: 5009, name: 'Captain Hale', map: 9001, x: 47, y: 52, f: 'e' },
	finish: { kind: 'npc', id: 5009, name: 'Captain Hale', map: 9001, x: 47, y: 52, f: 'e' }, bosses: [] }], chain: {} };

// Opens `open` (Lua returning a guide id) standing in Amber Vale, then walks to Ember Hollow; emits the guide's
// accept goal for the delivery as built, and the live step's view of it before and after the move.
function run(open) {
	const codex = fixture();
	const pack = writeCodexPack(codex);
	const maps = Object.entries(codex.frames).map(([id, frame]) => `w.addMap(${id}, ${luaValue({ name: codex.zones[id].name, ...frame })})`).join('\n');
	try {
		return runAddon({
			stubs: ['stub_world.lua'],
			before: `${pack.stubLua}\nlocal w = stub.world\n${maps}\nw.level = 20\nw.race, w.raceName, w.faction = "Human", "Human", "Alliance"\nw.class, w.className = "WARRIOR", "Warrior"\nw.moveTo(9001, 50, 50)`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml'] }],
			login: true,
			script: `assert(Polestar.Codex.Load())
local D, E, w = Polestar.Dungeons, Polestar.Engine, stub.world
D.Register("meta", { schema = 1 })
D.Register("dungeon", { ashen_crypt = ${luaValue(dungeon)} }, { ashen_crypt = ${JSON.stringify(`return ${luaValue(page)}`)} })
local id, reason = ${open}
assert(id, "not opened: " .. tostring(reason))
local guide = E.GetGuide()
local built
for _, s in ipairs(guide.steps) do for _, g in ipairs(s.goals) do
	if g.t == "accept" and g.quest == ${DELIVERY} then
		local c = {}
		for k, v in ipairs(g.candidates or {}) do c[k] = v.npc end
		built = { npc = g.npc, candidates = c }
	end
end end
local function live()
	local view = E.GetStepView(E.GetStepIndex())
	for _, g in ipairs(view and view.goals or {}) do
		if g.t == "accept" and g.quest == ${DELIVERY} then return { npc = g.npc or false, map = g.map or false, title = view.title or false } end
	end
	return false
end
local before = live()
w.moveTo(9002, 50.5, 50)
stub.fire("ZONE_CHANGED_NEW_AREA")
stub.runTimers()
emit({ built = built or false, before = before, after = live() })`,
		}).emitted;
	} finally {
		pack.cleanup();
	}
}

function check([r]) {
	assert.ok(r.built, 'the guide takes the delivery');
	assert.deepEqual(r.before, { npc: ROWAN, map: 9001, title: TITLE }, 'the live step names the giver beside the player');
	assert.deepEqual(r.after, { npc: WARDEN, map: 9002, title: TITLE }, 'in Ember Hollow, Warden Ash beside the player, not Elder Rowan back in Amber Vale; the step is named after the quest, not one giver');
	assert.equal(r.built.npc, ROWAN, 'built in Amber Vale: Elder Rowan, beside the player');
	assert.deepEqual(Object.values(r.built.candidates).sort(), [ROWAN, WARDEN], 'every giver of the character\'s side, never the Horde\'s Grunt Mosk');
}

test("a quest's Lookup guide takes it from whichever of its givers is nearest, picked again as the player moves (#3368, Zack)", () => {
	check(run(`Polestar.Lookup.Guide("quest", ${DELIVERY})`));
});

test("a dungeon pick-up's prerequisite several NPCs give is taken from the nearest of them, picked again as the player moves (#3368, Zack: Camp Mojache)", () => {
	check(run('D.PickUp("ashen_crypt")'));
});
