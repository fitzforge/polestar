'use strict';
// Baked guide legs (Forge bakes them: rust/crates/forge-nav/src/bake.rs,
// rust/crates/forge/src/bake.rs; compile ships them: tools/lib/dsl/project.js;
// the addon follows them: addon/Polestar/Nav/Baked.lua, Nav/Walk.lua):
// B1: a guide's legs are the walks into its steps, from the last located goal
//     before each step to its first, on one continent.
// B3: a leg reads back as written (version 2: moves, floors, the ground strip
//     in runs); Nav.BakedLeg decodes the current guide's leg for a step and
//     nothing for a step without one; a version-1 leg (format 6) still reads.
// B5: compile writes the legs of a leveling guide whose leg ends hash as baked
//     into the race parts' Legs.lua (format 7): its own race part's races, or
//     every race of its faction; a changed guide goes without.
// B6: the decoded leg is Nav.follow.Step's path (Follow.lua's contract).
// B9: Polestar.RegisterLegs keeps a registered pack's legs for its own guide
//     ids only; Nav.BakedLeg reads them for the current guide.
// B10: the arrow follows the step's baked leg without a search, from the
//     player's place on it; straying from it asks for a search (the re-plan);
//     a goal the leg does not end at is searched as before.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const B = require('../tools/lib/nav/bake');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');
const { tmpdir } = require('./helpers/tmp');
const { DATA_DIR } = require('./helpers/dsl');
const { buildPack } = require('../tools/lib/pack/build');
const { commandPack } = require('../tools/lib/pack/locate');

// One map: wx = -10 * y, wy = -10 * x (map percent -> yards).
const FRAMES = { era: { 1: { c: 0, top: 0, bottom: -1000, left: 0, right: -1000 } } };
const goal = (x, y, t = 'goto') => ({ t, map: 1, x, y, f: 'e' });

test('nav-bake B1: one leg into each step, from the last located goal before it', () => {
	const g = { steps: [
		{ goals: [goal(10, 10), goal(12, 12, 'kill')] },
		{ goals: [{ t: 'note' }, goal(20, 20)] },
		{ goals: [goal(20.5, 20.5)] }, // under MIN_LEG_YD from the last
		{ goals: [goal(40, 30)] },
	] };
	const legs = B.stepTargets(g, FRAMES);
	assert.deepEqual(legs.map((l) => l.s), [2, 4]);
	assert.deepEqual([legs[0].from.wx, legs[0].from.wy, legs[0].to.wx, legs[0].to.wy], [-120, -120, -200, -200]);
});

// Level for 40 samples (a run past 32), two pairs of small changes, a single +3, a 19 yd drop (escaped), level.
const STRIP = [...Array(40).fill(30), 30.25, 30.5, 30, 29.5, 30.25, 11.25, 11.25];
const LEG = { pts: [[-100, -200.5, 30], [-150, -260, 32.25], [-151, -300, 40]], cls: [0, 7], floor: [0, 2], tail: 2.5, strip: STRIP };

// A version-1 leg (pack format 6, the first bake): no floors, one varint per strip change.
const V1 = (() => {
	const D = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
	const out = [];
	const put = (v) => {
		do {
			let d = v % 32;
			v = Math.floor(v / 32);
			if (v > 0) d += 32;
			out.push(D[d]);
		} while (v > 0);
	};
	const zig = (v) => (v < 0 ? -2 * v - 1 : 2 * v);
	[1, 2, zig(0), zig(0), zig(40), zig(10), zig(-20), zig(8), 0, 4, 2, zig(0), zig(2)].forEach(put);
	return out.join('');
})();

test('nav-bake B3: a leg reads back; Nav.BakedLeg decodes the current guide\'s leg for a step; version 1 still reads', () => {
	const s = B.encodeLeg(LEG);
	assert.match(s, /^[A-Za-z0-9+/]+$/);
	assert.deepEqual(B.decodeLeg(s), LEG);
	assert.ok(s.length < 40, `the level ground packs into runs (${s.length} digits)`);
	assert.deepEqual(B.decodeLeg(V1), { pts: [[0, 0, 10], [5, -10, 12]], cls: [0], floor: [0], tail: 1, strip: [10, 10.5] });
	const out = runAddon({
		stubs: ['stub_world.lua'],
		before: 'stub.world.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); stub.world.moveTo(1429, 48, 42)',
		addons: ['Polestar'],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/baked" }' },
		script: `${TEST_PACK}\n${TEST_SOURCE}
Polestar.RegisterGuide({ id = "test/baked", pack = "test", title = "Baked", minLevel = 1, maxLevel = 5,
	legs = { [2] = ${JSON.stringify(s)}, [3] = ${JSON.stringify(V1)} },
	steps = {
		{ title = "A", goals = { { t = "goto", map = 1429, x = 50, y = 40, f = "e" } } },
		{ title = "B", goals = { { t = "goto", map = 1429, x = 60, y = 60, f = "e" } } },
		{ title = "C", goals = { { t = "goto", map = 1429, x = 61, y = 60, f = "e" } } },
	} })
stub.login()
local Nav = Polestar.Nav
local leg = Nav.BakedLeg and Nav.BakedLeg(2)
local function r(v) return math.floor(v * 100 + 0.5) / 100 end
emit(leg and { n = leg.n, xs = leg.xs, ys = leg.ys, zs = leg.zs, cls = leg.cls, floor = leg.floor, strip = leg.strip, m = leg.m, c = leg.c,
	left = { r(leg.left[1]), r(leg.left[2]), r(leg.left[3]) } } or false)
emit(Nav.BakedLeg and Nav.BakedLeg(1) or false)
local id = leg and leg.id
emit({ same = Nav.BakedLeg(2).id == id, set = type(id) == "number" })
local v1 = Nav.BakedLeg(3)
emit(v1 and { n = v1.n, floor = v1.floor, strip = v1.strip } or false)`,
	}).emitted;
	const r = (v) => Math.round(v * 100) / 100;
	const d2 = r(Math.hypot(1, 40, 7.75) + 2.5);
	assert.deepEqual(out[0], {
		n: 3, xs: [-100, -150, -151], ys: [-200.5, -260, -300], zs: [30, 32.25, 40], cls: [0, 7], floor: [0, 2], strip: STRIP, m: STRIP.length, c: 0,
		left: [r(d2 + Math.hypot(50, 59.5, 2.25)), d2, 2.5],
	});
	assert.equal(out[1], false, 'a step without a leg: the arrow searches as before');
	assert.deepEqual(out[2], { same: true, set: true }, 'the same leg again keeps its id (no new decode)');
	assert.deepEqual(out[3], { n: 2, floor: [0], strip: [10, 10.5] }, 'a format-6 leg (version 1) reads');
});

test('nav-bake B5: compile writes an unchanged leveling guide\'s legs into the race parts\' Legs.lua, format 7; a changed guide goes without', () => {
	const dir = tmpdir('polestar-legs-');
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify({ id: 'legs', title: 'Legs', author: 'Ann', version: '1.0.0', license: 'CC0-1.0', folder: 'PolestarPack_Legs' }));
	fs.mkdirSync(path.join(dir, 'guides'));
	// A class chain (its own race part) and a zone guide of the faction (the faction's races).
	const chain = (x) => `guide legs/human-warrior/01\ntitle Elwynn Forest\nfaction Alliance\nrace Human\nclass Warrior\nlevels 1-10\nzone Elwynn Forest\n\nstep A\n  goto 48,42\n\nstep B\n  goto ${x},50\n`;
	const zone = 'guide legs/alliance/02\ntitle Westfall\nfaction Alliance\nlevels 10-20\nzone Elwynn Forest\n\nstep A\n  goto 30,30\n\nstep B\n  goto 40,60\n';
	fs.writeFileSync(path.join(dir, 'guides', 'a.guide'), chain(60));
	fs.writeFileSync(path.join(dir, 'guides', 'b.guide'), zone);
	const build = () => buildPack({ ...commandPack({ pack: dir }), contextDir: null }, { dataDir: DATA_DIR });
	const first = build();
	assert.doesNotMatch(String(first.files['LICENSE-DATA.txt']), /Leffe/, 'no baked legs: no credit for their maps');
	const frames = first.data.mapFrames;
	const leg = B.encodeLeg(LEG);
	const legs = Object.fromEntries(first.guides.map((g) => [g.id, { hash: B.guideHash(g, frames), steps: { 2: leg } }]));
	fs.writeFileSync(path.join(dir, 'legs.json'), JSON.stringify({ schema: 1, grid: 'test', legs }));
	const r = build();
	assert.match(String(r.files['PolestarPack_Legs.toc']), /X-Polestar-Format: 7/);
	assert.match(String(r.files['LICENSE-DATA.txt']), /Baked walking legs\n-+\n[\s\S]*Credit: Leffe's navigation maps\./, 'the legs credit the maps they were routed on');
	const human = String(r.files['../PolestarPack_Legs_Human/Legs.lua']);
	assert.match(human, /^-- Generated by .* from legs\.json/);
	assert.match(human, /Polestar\.RegisterLegs\("legs", "test", \{\n\t\["legs\/alliance\/02"\] = \{ \[2\] = "[A-Za-z0-9+/]+" \},\n\t\["legs\/human-warrior\/01"\] = \{ \[2\] = "[A-Za-z0-9+/]+" \},\n\}\)/);
	assert.match(String(r.files['../PolestarPack_Legs_Human/PolestarPack_Legs_Human.toc']), /\nGuides\.lua\nLegs\.lua\n$/);
	const dwarf = String(r.files['../PolestarPack_Legs_Dwarf/Legs.lua']);
	assert.match(dwarf, /legs\/alliance\/02/, 'the zone guide\'s legs go to every Alliance race');
	assert.doesNotMatch(dwarf, /human-warrior/, 'the chain\'s only to its own race');
	assert.equal(r.files['../PolestarPack_Legs_Dwarf/Guides.lua'], undefined, 'a legs-only part has no Guides.lua');
	assert.match(String(r.files['../PolestarPack_Legs_Dwarf/PolestarPack_Legs_Dwarf.toc']), /## Notes: The walks of Legs's leveling guides for Dwarf characters\.[^\n]*\n[\s\S]*\nLegs\.lua\n$/);
	assert.equal(r.files['../PolestarPack_Legs_Orc/Legs.lua'], undefined, 'no Horde part');
	assert.doesNotMatch(String(r.files['../PolestarPack_Legs_Human/Guides.lua']), /legs = /, 'no legs inline any more');
	fs.writeFileSync(path.join(dir, 'guides', 'a.guide'), chain(70));
	const moved = build();
	assert.doesNotMatch(String(moved.files['../PolestarPack_Legs_Human/Legs.lua']), /human-warrior/);
	assert.ok(moved.diag.list.some((d) => /changed since their legs were baked/.test(d.message)));
});

test('nav-bake B6: the decoded leg is the follower\'s path: Nav.follow.Step aims along it from its start', () => {
	const s = B.encodeLeg({ pts: [[0, 0, 10], [0, -60, 10], [-60, -60, 10], [-60, -120, 10]], cls: [0, 0, 0], tail: 1, strip: [] });
	const out = runAddon({
		stubs: ['stub_world.lua'],
		before: 'stub.world.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); stub.world.moveTo(1429, 48, 42)',
		addons: ['Polestar'],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/baked" }' },
		script: `${TEST_PACK}\n${TEST_SOURCE}
Polestar.RegisterGuide({ id = "test/baked", pack = "test", title = "Baked", minLevel = 1, maxLevel = 5,
	legs = { [2] = ${JSON.stringify(s)} },
	steps = {
		{ title = "A", goals = { { t = "goto", map = 1429, x = 50, y = 40, f = "e" } } },
		{ title = "B", goals = { { t = "goto", map = 1429, x = 54, y = 52, f = "e" } } },
	} })
stub.login()
local Nav = Polestar.Nav
local leg = Nav.BakedLeg(2)
local S = {}
Nav.follow.Reset(S)
local ax, ay = Nav.follow.Step(leg.xs, leg.ys, leg.zs, leg.left, leg.n, S, 1, -2, leg.n)
emit({ ax = math.floor(ax + 0.5), ay = math.floor(ay + 0.5), left = math.floor(S.left + 0.5), idx = S.idx })`,
	}).emitted[0];
	// From the start, along the first straight (x 0): the aim lies on it, ahead.
	assert.equal(out.ax, 0);
	assert.ok(out.ay < -2 && out.ay >= -60, `aim y ${out.ay}`);
	assert.equal(out.idx, 2);
	assert.ok(out.left > 170 && out.left < 182, `left ${out.left}`);
});

test('nav-bake B9: Polestar.RegisterLegs keeps a registered pack\'s legs for its own guides; Nav.BakedLeg reads them', () => {
	const s = B.encodeLeg(LEG);
	const out = runAddon({
		stubs: ['stub_world.lua'],
		before: 'stub.world.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); stub.world.moveTo(1429, 48, 42)',
		addons: ['Polestar'],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/baked" }' },
		script: `${TEST_PACK}\n${TEST_SOURCE}
Polestar.RegisterGuide({ id = "test/baked", pack = "test", title = "Baked", minLevel = 1, maxLevel = 5,
	steps = {
		{ title = "A", goals = { { t = "goto", map = 1429, x = 50, y = 40, f = "e" } } },
		{ title = "B", goals = { { t = "goto", map = 1429, x = 60, y = 60, f = "e" } } },
	} })
Polestar.RegisterLegs("test", "grid 1", { ["test/baked"] = { [2] = ${JSON.stringify(s)}, [3] = 7 }, ["other/guide"] = { [2] = ${JSON.stringify(s)} } })
Polestar.RegisterLegs("nopack", "grid 1", { ["nopack/g"] = { [2] = ${JSON.stringify(s)} } })
stub.login()
local Nav, G = Polestar.Nav, Polestar.Guides
local leg = Nav.BakedLeg(2)
emit({ n = leg and leg.n or false, c = leg and leg.c or false, three = G.Legs("test/baked")[3] == nil,
	other = G.Legs("other/guide") == nil, nopack = G.Legs("nopack/g") == nil })`,
	}).emitted[0];
	assert.deepEqual(out, { n: 3, c: 0, three: true, other: true, nopack: true });
});

// The arrow with a baked leg (tests/nav-spf.test.js's fake engine and world:
// map 9000, the world origin at map (50, 50), 20 yd per map percent).
const ENGINE = `
fake = { calls = {} }
Polestar_NavEngine = {
	Find = function(map, from, to, callback, o)
		local job = { map = map, from = from, to = to, callback = callback }
		fake.calls[#fake.calls + 1] = job
		return job
	end,
	Cancel = function(job) job.cancelled = true end,
	Busy = function() return false end,
	Available = function() return true end,
}`;

function arrow(legString, script) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		before: ENGINE,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] }],
		login: true,
		script: `
local N, nav = Polestar.Nav, stub.nav
local floor = math.floor
Polestar.Engine.GetGuide = function() return { id = "t/g", legs = { [1] = ${JSON.stringify(legString)} } } end
nav.engine.views[1] = { goals = { { map = 9000, x = 80, y = 50 } } }
local function target(wx, wy)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, "Target")
end
local function aim()
	local state, dist, _, dn, dw = N.Sample()
	local p = nav.player
	if not dn then return { state } end
	return { state, floor(dist + 0.5), floor(p.wx + dn + 0.5), floor(p.wy + dw + 0.5) }
end
${script}`,
	}).emitted;
}

test('nav-bake B10: the arrow follows the step\'s baked leg without a search; straying from it searches; another goal is searched', () => {
	// The leg: (0, 0) -> (100, -100) -> (100, -500) -> (0, -600), the goal at its end.
	const s = B.encodeLeg({ pts: [[0, 0, 10], [100, -100, 10], [100, -500, 10], [0, -600, 10]], cls: [0, 0, 0], tail: 0, strip: [] });
	const [out] = arrow(s, `
local r = {}
nav.place(50, -40)
target(0, -600)
r.first = aim()
r.calls = #fake.calls
nav.place(100, -100)
aim()
nav.place(100, -300)
r.along = aim()
r.callsAlong = #fake.calls
nav.place(300, -300)
aim()
r.callsOff = #fake.calls
emit(r)`);
	assert.equal(out.calls, 0, 'no search: the leg is the path');
	assert.equal(out.first[0], 'travel');
	assert.ok(Math.abs(out.first[1] - 620) <= 3, `yards left along the leg from the player's place on it: ${out.first[1]}`);
	assert.equal(out.along[1], 341, 'along the leg as along a searched path');
	assert.equal(out.callsAlong, 0);
	assert.equal(out.callsOff, 1, 'off the leg: a search');
	const [other] = arrow(s, `
nav.place(50, -40)
target(0, -300)
aim()
emit(#fake.calls)`);
	assert.equal(other, 1, 'a goal the leg does not end at: searched as before');
	const [far] = arrow(s, `
nav.place(400, 200)
target(0, -600)
aim()
emit(#fake.calls)`);
	assert.equal(far, 1, 'a player far from the leg: searched as before');
});
