'use strict';
// Approach chains from recorded walks (`travel chain`,
// tools/lib/travel/crossings.js `recordedChain`): the walks that reach a
// target, where each leaves the straight line to it, the walked path from
// there simplified into chain nodes, and a candidate entry for the local
// crossings file that validates and leads the planner in at the mouth.
//
// The fixture world is Westfall from tests/fixtures/travel. The target stands
// inside a mountain; the cave's mouth faces east. Walks are laid out in yards
// east and north of the target and recorded as breadcrumbs every 25 yd, as the
// Recorder does.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { recordedChain, validateCrossings } = require('../tools/lib/travel/crossings');
const { recordedWalks } = require('../tools/lib/travel/paths');
const { buildTravel, writeTravel } = require('../tools/lib/travel/build');
const { planRoute } = require('../tools/lib/travel/route');
const { Frames } = require('../tools/lib/travel/geo');
const { polestar } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');

const FIX = path.join(__dirname, 'fixtures', 'travel');
const readFix = (f) => JSON.parse(fs.readFileSync(path.join(FIX, 'data', f), 'utf8'));
const frames = new Frames(readFix('map-frames.json').era, readFix('zones.json'));

const MAP = 1436; // Westfall
const T = { map: MAP, x: 50, y: 50 };
const O = frames.toWorld(T.map, T.x, T.y);
// Yards east and north of the target -> world (wx grows north, wy grows west).
const world = ([e, n]) => ({ c: O.c, wx: O.wx + n, wy: O.wy - e });
const yardsTo = (p, [e, n]) => {
	const w = world([e, n]);
	const q = frames.toWorld(p.map, p.x, p.y);
	return Math.hypot(q.wx - w.wx, q.wy - w.wy);
};

// The scene, in yards from the target.
const DETOUR = [0, -100]; // where a walk from the south meets the mountain
const MOUTH = [90, 30]; // the cave's mouth, on the east face
const CAVE = [MOUTH, [60, 70], [20, 60], [-20, 30], [0, 0]]; // the way in
const FROM_SOUTH = [[0, -400], DETOUR, [120, -100], [120, 30], ...CAVE];
const FROM_EAST = [[400, 30], ...CAVE];

// Breadcrumbs every 25 yd along a polyline, 4 s apart, as map percent.
function crumbs(line, t0 = 0) {
	const pts = [];
	let carry = 0;
	for (let i = 1; i < line.length; i++) {
		const [ae, an] = line[i - 1];
		const [be, bn] = line[i];
		const len = Math.hypot(be - ae, bn - an);
		for (let d = carry; d < len; d += 25) pts.push([ae + ((be - ae) * d) / len, an + ((bn - an) * d) / len]);
		carry = (25 - ((len - carry) % 25)) % 25;
	}
	pts.push(line[line.length - 1]);
	return pts.map((p, i) => {
		const w = world(p);
		const m = frames.toMap(MAP, w.c, w.wx, w.wy);
		return { t: t0 + i * 4, e: 'pos', map: MAP, x: Math.round(m.x * 100) / 100, y: Math.round(m.y * 100) / 100 };
	});
}

const recording = (session, ...lines) => {
	const events = [];
	for (const line of lines) {
		if (events.length) events.push({ t: events[events.length - 1].t + 1, e: 'death' });
		events.push(...crumbs(line, events.length ? events[events.length - 1].t + 60 : 0));
	}
	return { file: `${session}.json`, rec: { schema: 1, session, events } };
};

const chainFor = (recordings, opts = {}) => {
	const { walks } = recordedWalks({ recordings, frames });
	return recordedChain({ walks, target: T, frames, ...opts });
};

const near = (node, at, yards, what) => {
	const d = yardsTo(node, at);
	assert.ok(d <= yards, `${what}: ${Math.round(d)} yd from [${at}] (${JSON.stringify(node)})`);
};

test('a walk around a mountain into a cave becomes a chain from where it leaves the straight line to the target', () => {
	const { chain, approaches } = chainFor([recording('south', FROM_SOUTH)]);
	assert.equal(approaches.length, 1);
	assert.ok(chain, 'a candidate');
	assert.equal(chain.open, 'mouth');
	const nodes = chain.nodes;
	near(nodes[0], DETOUR, 25, 'the mouth is where the walk turned away from the target');
	near(nodes[nodes.length - 1], [0, 0], 30, 'the last node is at the target');
	// The corners of the detour and the bends of the cave survive simplification (to within a breadcrumb); the breadcrumbs in between do not.
	for (const corner of [[120, -100], [120, 30], ...CAVE.slice(0, 4)]) {
		assert.ok(nodes.some((n) => yardsTo(n, corner) <= 25), `a node near [${corner}]`);
	}
	assert.ok(nodes.length <= 10, `${nodes.length} nodes`);
	assert.ok(nodes.every((n) => n.map === MAP && n.radius >= 3 && n.radius <= 15));
	assert.ok(nodes.every((n) => !('caption' in n)), 'no --name: every caption is the addon\'s translated default');
	assert.deepEqual(validateCrossings({ schema: 1, chains: [chain] }, frames).errors, []);
});

test('with walks from two sides, the chain starts at the cave mouth where they meet', () => {
	// One session walks in from the south and leaves to the east: its way out, reversed, is a second approach.
	const out = [...FROM_EAST].reverse();
	const both = [recording('both', [...FROM_SOUTH, ...out.slice(1)])];
	assert.deepEqual(chainFor(both).approaches.map((a) => a.direction), ['in'], 'ways out only count with reverse');
	const { chain, approaches } = chainFor(both, { reverse: true });
	assert.deepEqual(approaches.map((a) => a.direction).sort(), ['in', 'out']);
	near(chain.nodes[0], MOUTH, 20, 'the mouth');
	assert.ok(chain.nodes.every((n) => yardsTo(n, [120, -100]) > 40), 'no node on the detour around the mountain');
	near(chain.nodes[chain.nodes.length - 1], [0, 0], 30, 'the last node');
	const south = approaches.find((a) => a.direction === 'in');
	near(south.mouth, DETOUR, 25, 'the other walk is reported with its own departure');
	assert.ok(south.yards > approaches.find((a) => a.direction === 'out').yards);
});

test('only straight walks mean no chain; beside one that goes around they are reported, not followed; one that never reaches the target says how close it came', () => {
	const straight = chainFor([recording('straight', [[0, -400], [0, 0]])]);
	assert.equal(straight.chain, null);
	assert.equal(straight.approaches.length, 1);
	assert.equal(straight.approaches[0].mouth, null);

	// One walk goes straight (with no height it may be on the hill above the cave), another goes around: the chain is the detour.
	const walks = [recording('around', FROM_SOUTH), recording('straight', [[0, -400], [0, 0]])];
	const mixed = chainFor(walks);
	assert.ok(mixed.chain, 'a straight walk does not cancel the chain');
	near(mixed.chain.nodes[0], DETOUR, 25, 'the mouth');
	assert.deepEqual(mixed.approaches.map((a) => [a.session, a.mouth === null]), [['around', false], ['straight', true]]);
	// sessions keeps only the chosen walks.
	assert.deepEqual(chainFor(walks, { sessions: ['straight'] }).approaches.map((a) => a.session), ['straight']);
	assert.equal(chainFor(walks, { sessions: ['straight'] }).chain, null);
	assert.deepEqual(chainFor(walks, { sessions: ['around'] }).approaches.map((a) => a.session), ['around']);
	// The same in one unbroken walk: in around the mountain, back out the same way, then straight in.
	const twice = chainFor([recording('twice', [...FROM_SOUTH, ...[...FROM_SOUTH].reverse().slice(1), [0, -20]])]);
	assert.ok(twice.chain);
	assert.ok(twice.approaches.some((a) => a.mouth === null), 'the second visit is an approach of its own');

	const missed = chainFor([recording('missed', [[0, -400], [0, -100], [200, -100]])]);
	assert.equal(missed.chain, null);
	assert.deepEqual(missed.approaches, []);
	assert.equal(Math.round(missed.nearest), 100);
});

test('only walks from beyond --within yards count, and a death breaks a walk', () => {
	// Starts 150 yd out: too close to tell where the straight line ends.
	const short = chainFor([recording('short', [[0, -150], DETOUR, [120, -100], [120, 30], ...CAVE])]);
	assert.deepEqual(short.approaches, []);
	assert.equal(chainFor([recording('short', [[0, -150], DETOUR, [120, -100], [120, 30], ...CAVE])], { within: 120 }).approaches.length, 1);
	// The walk is cut by a death at the detour: the part after it starts too close.
	const cut = chainFor([recording('cut', [[0, -400], DETOUR], [DETOUR, [120, -100], [120, 30], ...CAVE])]);
	assert.deepEqual(cut.approaches, []);
});

test('travel chain prints a candidate entry, and with it the planner enters the cave at its mouth', async () => {
	const dir = tmpdir('polestar-chains-');
	const recDir = path.join(dir, 'recordings');
	fs.mkdirSync(recDir);
	const { rec } = recording('both', [...FROM_SOUTH, ...[...FROM_EAST].reverse().slice(1)]);
	fs.writeFileSync(path.join(recDir, 'both.json'), JSON.stringify(rec));
	const args = ['travel', 'chain', '--to', `${MAP},${T.x},${T.y}`, '--name', 'Test Mine', '--reverse', '--data', path.join(FIX, 'data'), '--recordings', recDir];

	const text = polestar(args);
	assert.equal(text.status, 0, text.stderr + text.stdout);
	assert.match(text.stdout, /approach chain candidate for Westfall 50, 50: review it in game before use/);
	assert.match(text.stdout, /2 walk\(s\) reach the target from 300 yd or more/);
	assert.match(text.stdout, /"id": "test-mine"/);

	const json = polestar([...args, '--json']);
	assert.equal(json.status, 0, json.stderr + json.stdout);
	const chain = JSON.parse(json.stdout);
	assert.equal(chain.nodes[0].caption, 'Go to Test Mine');
	assert.ok(chain.nodes.slice(1).every((n) => !('caption' in n)), 'the rest take the translated default');

	const crossingsFile = path.join(dir, 'crossings.json');
	fs.writeFileSync(crossingsFile, JSON.stringify({ schema: 1, frame: 'e', chains: [chain] }));
	const result = await buildTravel({ dataDir: path.join(FIX, 'data'), recordingsDir: path.join(FIX, 'recordings'), sourcesDir: path.join(FIX, 'sources'), offline: true, shippedFile: null, crossingsFile });
	writeTravel(result, { jsonOut: path.join(dir, 'travel.json'), luaOut: path.join(dir, 'TravelData.lua'), travelAddonDir: path.join(dir, 'Polestar_Travel') });
	for (const f of ['map-frames.json', 'zones.json']) fs.copyFileSync(path.join(FIX, 'data', f), path.join(dir, f));
	const south = frames.toMap(MAP, O.c, world([0, -400]).wx, world([0, -400]).wy);
	const common = { dataDir: dir, travelLua: path.join(dir, 'TravelData.lua'), from: { map: MAP, x: south.x, y: south.y }, to: T };
	assert.equal(planRoute(common).length, 1, 'without the chain the arrow points straight at the target');
	const legs = planRoute({ ...common, crossingsLua: path.join(dir, 'Polestar_Travel', 'Crossings.lua') });
	assert.equal(legs[0].label, 'Go to Test Mine');
	assert.ok(Math.hypot(legs[0].to.wx - world(MOUTH).wx, legs[0].to.wy - world(MOUTH).wy) <= 20, 'the first leg ends at the mouth');
	assert.equal(legs[legs.length - 1].label, 'Westfall 50, 50');
	assert.ok(legs.length >= 4, `${legs.length} legs`);

	const openDir = path.join(dir, 'open');
	fs.mkdirSync(openDir);
	fs.writeFileSync(path.join(openDir, 'straight.json'), JSON.stringify(recording('straight', [[0, -400], [0, 0]]).rec));
	const open = polestar(['travel', 'chain', '--to', `${MAP},${T.x},${T.y}`, '--data', path.join(FIX, 'data'), '--recordings', openDir]);
	assert.equal(open.status, 0, open.stderr + open.stdout);
	assert.match(open.stdout, /no chain needed for Westfall 50, 50: every recorded walk reaches it on the straight line \(straight\)/);

	// A straight walk beside a detour: warned about, and the chain is still drafted; --session picks walks.
	fs.writeFileSync(path.join(openDir, 'around.json'), JSON.stringify(recording('around', FROM_SOUTH).rec));
	const mixedArgs = ['travel', 'chain', '--to', `${MAP},${T.x},${T.y}`, '--data', path.join(FIX, 'data'), '--recordings', openDir];
	const mixed = polestar(mixedArgs);
	assert.equal(mixed.status, 0, mixed.stderr + mixed.stdout);
	assert.match(mixed.stderr, /warning: straight reach Westfall 50, 50 on the straight line; drafting from the walks that detour/);
	assert.match(mixed.stdout, /approach chain candidate for Westfall 50, 50/);
	const picked = polestar([...mixedArgs, '--session', 'around']);
	assert.equal(picked.status, 0, picked.stderr + picked.stdout);
	assert.doesNotMatch(picked.stderr, /warning/);
	assert.match(picked.stdout, /1 walk\(s\) reach the target from 300 yd or more \(around\)/);
	const onlyStraight = polestar([...mixedArgs, '--session', 'straight']);
	assert.match(onlyStraight.stdout, /no chain needed/);

	const none = polestar(['travel', 'chain', '--to', `${MAP},90,10`, '--data', path.join(FIX, 'data'), '--recordings', recDir]);
	assert.equal(none.status, 1);
	assert.match(none.stdout, /no recorded walk reaches Westfall 90, 10 from 300 yd or more \(the nearest passes \d+ yd away\)/);
});
