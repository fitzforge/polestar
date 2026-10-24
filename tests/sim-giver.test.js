'use strict';
// A quest with more than one giver or ender (Cenarion Aid 8254: Brother
// Joshua in Stormwind and High Priest Rohan in Ironforge) is scored at the
// one the guide names. The world used to keep the first friendly giver and
// ender only, so a guide sending the player to the other one was scored on a
// trip it never makes (docs/legacy/SIMULATION-js.md §5).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const { buildWorld } = require('../tools/lib/sim/world');
const { compileRun, makeTables, K_ACCEPT, K_TURNIN } = require('../tools/lib/sim/run');
const { Evaluator } = require('../tools/lib/sim/evaluate');
const { compileSequence } = require('../tools/lib/sim/sequence');
const { effective, means } = require('../tools/lib/sim/params');
const { loadPolestarRoutes } = require('../tools/lib/sim/baselines/polestar');
const syn = require('./fixtures/sim/synthetic');
const { tmpdir } = require('./helpers/tmp');

const FIX = path.join(__dirname, 'fixtures', 'sim', 'polestar');

// Errand (509) is given and taken back by Elder Testa in Testvale (listed
// first) and by Warden Fieldy in Farfield, 1000 yards east.
function setup() {
	const data = syn.makeData();
	data.quests[509] = { ...data.quests[503], id: 509, title: 'Errand', start: { npc: [1, 2], object: [], item: [] }, end: { npc: [1, 2], object: [] }, zone: syn.VALE };
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	w.questXp = syn.questXpRows();
	const run = compileRun(w, { race: 'Orc', family: 'solo' });
	const ev = new Evaluator(run, makeTables(run, means(effective({ calibrated: {} }))), {});
	return { w, run, ev, qi: run.qIndex.get(509) };
}

// Word to the Warden (Testvale to Farfield), then Errand at the giver and
// ender `who` names.
const errand = (who) => [
	{ t: 'accept', q: 503 }, { t: 'turnin', q: 503 },
	{ t: 'accept', q: 509, ...who }, { t: 'turnin', q: 509, ...who },
];

test('world: every friendly giver and ender of a quest that has several, by entity; one alone adds nothing', () => {
	const { w, run, qi } = setup();
	const q = w.quests.find((x) => x.id === 509);
	assert.deepEqual(Object.keys(q.gAlt), ['npc:1', 'npc:2']);
	assert.deepEqual(Object.keys(q.eAlt), ['npc:1', 'npc:2']);
	assert.equal(q.gAlt['npc:1'], q.giver, 'the first friendly giver stays the giver');
	assert.equal(q.eAlt['npc:1'], q.ender);
	assert.notEqual(q.gAlt['npc:2'], q.giver);
	const single = w.quests.find((x) => x.id === 504);
	assert.equal(single.gAlt, undefined);
	assert.equal(single.eAlt, undefined);
	assert.deepEqual([...run.qGiverAlt.get(qi).keys()], ['npc:1', 'npc:2']);
	assert.equal(run.qGiverAlt.has(run.qIndex.get(504)), false);
});

test('sequences: accept and turn-in at the giver and ender the event names; unnamed or unknown ones stay at the world\'s', () => {
	const { run, qi } = setup();
	const at = (events, kind) => {
		const seq = compileSequence(run, events);
		const i = [...seq.kind].findIndex((k, j) => k === kind && seq.q[j] === qi);
		return seq.pt[i];
	};
	const fieldy = run.qGiverAlt.get(qi).get('npc:2');
	assert.equal(at(errand({ npc: 2 }), K_ACCEPT), fieldy);
	assert.equal(at(errand({ npc: 2 }), K_TURNIN), run.qEnderAlt.get(qi).get('npc:2'));
	assert.equal(at(errand({}), K_ACCEPT), run.qGiver[qi]);
	assert.equal(at(errand({ npc: 777 }), K_ACCEPT), run.qGiver[qi]);
	assert.equal(at(errand({ object: 2 }), K_ACCEPT), run.qGiver[qi]);
});

test('a guide that takes the quest where it already stands scores no trip back to the first giver', () => {
	const { run, ev } = setup();
	const time = (who) => ev.evaluateSequence(compileSequence(run, errand(who)), {}).endTravel;
	const named = time({ npc: 2 });
	const first = time({});
	assert.ok(named < first, `travel with Errand at Warden Fieldy ${named.toFixed(0)} s, at Elder Testa ${first.toFixed(0)} s`);
});

test('polestar: accept and turn-in events carry the npc the guide names', () => {
	const dir = tmpdir('sim-giver-');
	fs.cpSync(path.join(FIX, 'guides'), dir, { recursive: true });
	const file = path.join(dir, 'forever', 'horde', 'orc', '01-start.guide');
	const text = fs.readFileSync(file, 'utf8')
		.replace('  accept 90001 "Synthetic Task"\n', '  accept 90001 "Synthetic Task" npc 99010\n')
		.replace('  turnin 90001 "Synthetic Task"\n', '  turnin 90001 "Synthetic Task" npc 99011\n');
	fs.writeFileSync(file, text);
	const r = loadPolestarRoutes({ guidesDir: dir, dataDir: path.join(FIX, 'data'), race: 'Orc' });
	const ev = r.default.events.filter((e) => e.q === 90001 && e.t !== 'complete');
	assert.deepEqual(ev, [{ t: 'accept', q: 90001, npc: 99010 }, { t: 'turnin', q: 90001, npc: 99011 }]);
});
