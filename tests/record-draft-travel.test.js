'use strict';
// Schema 2 records travel identities, not the schema 1 location labels. Use
// the committed travel builder fixtures and real import path to cover both.
const { test, before } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { draftGuide } = require('../tools/lib/recording/draft');
const { buildTravel } = require('../tools/lib/travel/build');
const { Data } = require('../tools/lib/dsl/data');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { checkLocation } = require('../tools/lib/dsl/places');
const { polestar, forge } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');

const FIX = path.join(__dirname, 'fixtures');
const legacy = JSON.parse(fs.readFileSync(path.join(FIX, 'recordings', '1791000000-Testchar.json'), 'utf8'));
let travel;
before(async () => {
	({ travel } = await buildTravel({
		dataDir: path.join(FIX, 'travel', 'data'),
		recordingsDir: path.join(FIX, 'travel', 'recordings'),
		sourcesDir: path.join(FIX, 'travel', 'sources'),
		offline: true,
		shippedFile: null,
	}));
});

function session(events) {
	return { ...legacy, schema: 2, events: [{ t: 0, e: 'zone', map: 1429, x: 43.8, y: 65.8 }, ...events] };
}

// These identities and positions are also emitted by the real Recorder
// probe. They come from the existing recording/travel fixtures.
function travelEvents() {
	return [
		{ t: 1, e: 'bind', npc: 295, map: 1429, x: 43.8, y: 65.8 },
		{ t: 2, e: 'zone', map: 1453, x: 66.3, y: 62.1 },
		{ t: 3, e: 'fp', npc: 352, node: 2, known: [2, 4], map: 1453, x: 66.3, y: 62.1 },
		{ t: 4, e: 'taxi', fromNode: 2, toNode: 4 },
	];
}

function parsed(text) {
	const diag = new Diagnostics();
	const guide = parseGuide(text, 'recorded.guide', diag);
	assert.deepEqual(diag.list, []);
	return guide;
}

function goals(text) {
	return parsed(text).steps.flatMap((s) => s.goals);
}

function assertTravel(text) {
	const places = goals(text).filter((g) => ['sethome', 'getfp', 'fly'].includes(g.verb));
	assert.deepEqual(places.map((g) => [g.verb, g.location]), [
		['sethome', 'Goldshire'], ['getfp', 'Stormwind, Elwynn'], ['fly', 'Sentinel Hill'],
	]);
	assert.deepEqual(places.slice(0, 2).map((g) => [g.npc, g.x, g.y]), [[295, 43.8, 65.8], [352, 66.3, 62.1]]);
	const data = new Data({ travel });
	for (const g of places) assert.equal(checkLocation(data, g.verb, g.location), null, `${g.verb} ${g.location}`);
}

test('schema 2 bindings and flights use exact identities from fixture-built travel data', () => {
	assertTravel(draftGuide(session(travelEvents()), { travel }).text);
});

test('schema 1 labels still win over reference data and numeric identities', () => {
	const recorded = structuredClone(legacy);
	recorded.events.find((e) => e.e === 'fp').node = 4;
	recorded.events.find((e) => e.e === 'taxi').toNode = 2;
	const conflicting = structuredClone(travel);
	conflicting.inns.find((i) => i.npc === 295).location = 'Sentinel Hill';
	assert.equal(draftGuide(recorded, { travel: conflicting }).text, draftGuide(legacy).text);
});

function unresolvedSession(unknown = false) {
	const events = travelEvents();
	if (unknown) {
		events.find((e) => e.e === 'bind').npc = 990001;
		events.find((e) => e.e === 'fp').node = 990002;
		events.find((e) => e.e === 'taxi').toNode = 990003;
	}
	return session([
		{ t: 0.5, e: 'mark', text: 'Before the recorded flight', map: 1429, x: 43.8, y: 65.8 },
		...events,
		{ t: 5, e: 'mark', text: 'After the recorded flight', map: 1453, x: 66.3, y: 62.1 },
	]);
}

function assertUnresolved(text, ids = [295, 2, 4]) {
	assert.match(text, new RegExp(`# TODO:.*recorded hearth bind.*NPC ${ids[0]}`));
	assert.match(text, new RegExp(`# TODO:.*recorded flight point.*taxi node ${ids[1]}`));
	assert.match(text, new RegExp(`# TODO:.*recorded flight destination.*taxi node ${ids[2]}`));
	const guide = parsed(text);
	assert.deepEqual(guide.steps.map((s) => s.goals.map((g) => g.verb)), [['note'], ['note']], 'the unresolved flight still ends the earlier step');
	assert.ok(text.indexOf('recorded flight destination') < text.lastIndexOf('\nstep'), 'the author comment stays before the flight boundary');
}

test('without travel data, author comments retain the recorded identities and flight boundary', () => {
	assertUnresolved(draftGuide(unresolvedSession()).text);
});

test('unknown travel identities are not replaced with another known place', () => {
	assertUnresolved(draftGuide(unresolvedSession(true), { travel }).text, [990001, 990002, 990003]);
});

test('missing producer identities cannot match reference rows without an identity', () => {
	const recorded = unresolvedSession();
	delete recorded.events.find((e) => e.e === 'bind').npc;
	delete recorded.events.find((e) => e.e === 'fp').node;
	delete recorded.events.find((e) => e.e === 'taxi').toNode;
	const incomplete = structuredClone(travel);
	delete incomplete.inns.find((i) => i.npc === 295).npc;
	delete incomplete.taxi.nodes.find((n) => n.id === 2).id;
	assertUnresolved(draftGuide(recorded, { travel: incomplete }).text, ['unknown', 'unknown', 'unknown']);
});

test('ambiguous exact identities remain author comments instead of picking the first match', () => {
	const ambiguous = structuredClone(travel);
	for (const n of travel.taxi.nodes) ambiguous.taxi.nodes.push({ ...n });
	ambiguous.inns.push({ ...travel.inns.find((i) => i.npc === 295) });
	assertUnresolved(draftGuide(unresolvedSession(), { travel: ambiguous }).text);
});

test('a session containing only unresolved travel gives an actionable no-draft error', () => {
	assert.throws(() => draftGuide(session(travelEvents())), (error) => {
		assert.match(error.message, /unresolved travel/i);
		assert.match(error.message, /travel data/i);
		return true;
	});
});

test('leading and consecutive unresolved flights do not create empty steps', () => {
	const text = draftGuide(session([
		{ t: 1, e: 'taxi', fromNode: 2, toNode: 4 },
		{ t: 2, e: 'taxi', fromNode: 4, toNode: 2 },
		{ t: 3, e: 'vendor', npc: 1213, map: 1429, x: 41.7, y: 65.5 },
	])).text;
	assert.deepEqual(parsed(text).steps.map((s) => s.goals.map((g) => g.verb)), [['vendor']]);
	assert.match(text, /recorded flight destination.*taxi node 4/);
	assert.match(text, /recorded flight destination.*taxi node 2/);
});

test('an unresolved flight separates nearby hub goals and retains their positions', () => {
	const text = draftGuide(session([
		{ t: 1, e: 'vendor', npc: 1213, map: 1429, x: 41.7, y: 65.5 },
		{ t: 2, e: 'bind', npc: 295, map: 1429, x: 43.8, y: 65.8 },
		{ t: 3, e: 'taxi', fromNode: 2, toNode: 4 },
		{ t: 4, e: 'vendor', npc: 1213, map: 1429, x: 41.7, y: 65.5 },
	])).text;
	assert.deepEqual(parsed(text).steps.map((s) => s.goals.map((g) => g.verb)), [['vendor'], ['vendor']]);
	assert.match(text, /recorded hearth bind.*NPC 295.*map 1429.*@43\.8,65\.8/);
});

test('record draft --data reads a travel-only directory and emits named travel goals', () => {
	const dir = tmpdir('polestar-draft-travel-');
	const data = path.join(dir, 'data');
	fs.mkdirSync(data);
	fs.writeFileSync(path.join(data, 'travel.json'), JSON.stringify(travel));
	const file = path.join(dir, 'session.json');
	const out = path.join(dir, 'draft.guide');
	fs.writeFileSync(file, JSON.stringify(session(travelEvents())));
	const r = polestar(['record', 'draft', file, '--data', data, '--out', out]);
	assert.equal(r.status, 0, r.stderr);
	assertTravel(fs.readFileSync(out, 'utf8'));
});

test('record draft without optional travel.json still writes useful goals and unresolved comments', () => {
	const dir = tmpdir('polestar-draft-travel-');
	const file = path.join(dir, 'session.json');
	const out = path.join(dir, 'draft.guide');
	fs.writeFileSync(file, JSON.stringify(unresolvedSession()));
	const r = polestar(['record', 'draft', file, '--data', dir, '--out', out]);
	assert.equal(r.status, 0, r.stderr);
	assertUnresolved(fs.readFileSync(out, 'utf8'));
});

test('the real imported Recorder fixture keeps its flight-master visit and flight in the draft', (t) => {
	const dir = tmpdir('polestar-draft-import-');
	const wtf = path.join(dir, 'WTF');
	const account = path.join(wtf, 'Account', 'TESTACCOUNT');
	const saved = path.join(account, 'SavedVariables');
	fs.mkdirSync(saved, { recursive: true });
	fs.mkdirSync(path.join(account, 'Test Realm', 'Testchar'), { recursive: true });
	fs.copyFileSync(path.join(FIX, 'recordings', 'Polestar_Recorder.lua'), path.join(saved, 'Polestar_Recorder.lua'));
	const out = path.join(dir, 'recordings');
	const r = forge(['record', 'import', '--wtf', wtf, '--out', out]);
	if (!r) return t.skip('no forge binary (rust/target/release/forge or $FORGE)');
	assert.equal(r.status, 0, r.stderr);
	const imported = JSON.parse(fs.readFileSync(path.join(out, '20261003T040000Z-testinstall1-char000001.json'), 'utf8'));
	assert.equal(imported.schema, 2);
	assert.equal(imported.events.find((e) => e.e === 'fp').node, 2);
	assert.equal(imported.events.find((e) => e.e === 'taxi').toNode, 4);
	const flights = goals(draftGuide(imported, { travel }).text).filter((g) => g.verb === 'getfp' || g.verb === 'fly');
	assert.deepEqual(flights.map((g) => [g.verb, g.location]), [['getfp', 'Stormwind, Elwynn'], ['fly', 'Sentinel Hill']]);
});
