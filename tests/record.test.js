'use strict';
// `record draft|list|trail` (tools/commands/record.js, tools/lib/recording/) against a
// normalized session (tests/fixtures/recordings/, schema 1: a Northshire →
// Goldshire → Stormwind session), and the pointer from the retired
// `record import|watch` to `forge record import`, which the last tests run on the
// addon's own chunks.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const { applyRecordings } = require('../tools/lib/data/recordings');
const { forge } = require('./helpers/cli');
const { draftGuide } = require('../tools/lib/recording/draft');

// The guide compiler's parser: drafts must parse cleanly.
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { checkLocation } = require('../tools/lib/dsl/places');
const { tmpdir } = require('./helpers/tmp');

const CLI = path.join(__dirname, '..', 'tools', 'polestar.js');
const HUMAN = '1791000000-Testchar';
const FIXTURE = path.join(__dirname, 'fixtures', 'recordings', `${HUMAN}.json`);

function readJson(file) {
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

// A recordings folder holding the fixture session.
function recordings() {
	const out = path.join(tmpdir('polestar-record-'), 'recordings');
	fs.mkdirSync(out, { recursive: true });
	fs.copyFileSync(FIXTURE, path.join(out, `${HUMAN}.json`));
	return out;
}

test('data build: recorded kills linked to a quest nobody knows are skipped, not fatal', () => {
	const db = {
		quests: { 7: { id: 7, title: 'Kobold Camp Cleanup', start: { npc: [], object: [], item: [] }, end: { npc: [], object: [] }, objectives: [{ type: 'kill', id: 6, count: 10, text: 'Kobold Vermin' }], source: ['era'] } },
		npcs: {}, objects: {}, items: {}, zones: {}, factions: null,
	};
	const rec = {
		schema: 1,
		events: [
			// accepted in a lost session: no accept, turnin, reward or progress event anywhere
			{ t: 1, e: 'kill', npc: 61000, npcName: 'Skyborne Raider', q: 90001, oi: 1, map: 1429, x: 40, y: 40 },
			{ t: 2, e: 'loot', item: 190001, itemName: 'Raider Insignia', q: 90002, oi: 2, map: 1429, x: 40, y: 41 },
			{ t: 3, e: 'kill', npc: 6, npcName: 'Kobold Vermin', q: 7, oi: 1, map: 1429, x: 47, y: 35 },
		],
	};
	assert.doesNotThrow(() => applyRecordings(db, [{ file: 'a.json', rec }]));
	assert.deepEqual(Object.keys(db.quests), ['7']);
	assert.equal(db.npcs[61000].name, 'Skyborne Raider');
	assert.equal(db.items[190001].name, 'Raider Insignia');
	assert.deepEqual(db.quests[7].objectives, [{ type: 'kill', id: 6, count: 10, text: 'Kobold Vermin' }]);
});

// Reviewed by hand: hub steps by NPC proximity, one kill line at the centroid
// of the kill objective's progress, the abandoned quest's accept and progress
// left out, the mark as a note (" -- " defused, quotes escaped), Stormwind as
// a zone change, the flight closing the last step.
const EXPECTED_DRAFT = String.raw`guide draft/alliance/human/2026-10-03-0400
title Elwynn Forest (draft 2026-10-03)
faction Alliance
race Human
levels 1-3
zone Elwynn Forest
coords live
# drafted from recording 1791000000-Testchar: Testchar-Test Realm, Warrior

step Deputy Willem
  accept 783 "A Threat Within" npc 823 @48.2,43.0
  turnin 783 "A Threat Within" npc 197 @48.9,41.6
  accept 7 "Kobold Camp Cleanup" npc 197 @48.9,41.6

step Kobold Camp Cleanup
  kill 6 x10 quest 7.1 @47.3,35.4
  # reached level 2 @46.4,37.6
  note "Kobolds respawn fast - pull at the \"tunnel\" mouth"
  # quest 7.2 (object): no target id recorded
  goto 46.9,35.2 "Supply crates searched"
  # died @47.1,35.0

step Marshal McBride
  turnin 7 "Kobold Camp Cleanup" npc 197 @48.9,41.6
  train 911 @50.2,42.3 only Warrior
  # abandoned quest 33 Wolves Across the Border

step Marshal Dughan
  accept 62 "The Fargodeep Mine" npc 240 @42.1,65.9
  sethome "Goldshire" @43.8,65.8
  vendor 1213 @41.7,65.5

step Dungar Longdrink
  zone Stormwind City
  getfp "Stormwind, Elwynn" npc 352 @66.3,62.1
  fly "Sentinel Hill"
`;

test('draft turns a session into a guide in the .guide DSL', () => {
	const session = readJson(FIXTURE);
	const draft = draftGuide(session);
	assert.equal(draft.id, 'draft/alliance/human/2026-10-03-0400');
	assert.equal(draft.name, 'alliance-human-2026-10-03-0400');
	assert.equal(draft.text, EXPECTED_DRAFT);
	// Quest XP rewards change nothing in the draft.
	const withRewards = structuredClone(session);
	Object.assign(withRewards.events[2], { rewardXp: 80, rewardXpBase: 80 });
	withRewards.events.splice(7, 0, { t: 59, e: 'reward', q: 33, rewardXp: 170, rewardXpBase: 170, lvl: 1 });
	assert.equal(draftGuide(withRewards).text, EXPECTED_DRAFT);
});

test('the draft parses without diagnostics in the guide compiler', () => {
	const diag = new Diagnostics();
	const guide = parseGuide(EXPECTED_DRAFT, 'draft.guide', diag);
	assert.deepEqual(diag.list, []);
	assert.equal(guide.id, 'draft/alliance/human/2026-10-03-0400');
	assert.deepEqual(
		guide.steps.map((s) => s.goals.map((g) => g.verb)),
		[
			['accept', 'turnin', 'accept'],
			['kill', 'note', 'goto'],
			['turnin', 'train'],
			['accept', 'sethome', 'vendor'],
			['getfp', 'fly'],
		],
	);
	const kill = guide.steps[1].goals[0];
	assert.deepEqual([kill.npc, kill.count, kill.quest, kill.oi, kill.x, kill.y], [6, 10, 7, 1, 47.3, 35.4]);
	assert.deepEqual(guide.steps[4].goals[0].zone.name, 'Stormwind City');
});

test('the recording keeps the full flight point name; the draft flies to its town, which lint accepts', () => {
	const session = readJson(FIXTURE);
	assert.equal(session.events.find((ev) => ev.e === 'taxi').to, 'Sentinel Hill, Westfall');
	const guide = parseGuide(draftGuide(session).text, 'draft.guide', new Diagnostics());
	const data = {
		inns: () => [],
		flightNodes: () => [{ name: 'Stormwind, Elwynn' }, { name: 'Sentinel Hill, Westfall' }],
		zone: () => null,
	};
	const travel = guide.steps.flatMap((s) => s.goals).filter((g) => g.verb === 'fly' || g.verb === 'getfp');
	assert.deepEqual(travel.map((g) => [g.verb, g.location]), [['getfp', 'Stormwind, Elwynn'], ['fly', 'Sentinel Hill']]);
	for (const g of travel) assert.equal(checkLocation(data, g.verb, g.location), null, `${g.verb} "${g.location}"`);
	// The full name is what the old draft wrote: lint flags it, the game never reports it on landing.
	assert.notEqual(checkLocation(data, 'fly', 'Sentinel Hill, Westfall'), null);
});

test('record CLI: list then draft, refusing to overwrite an edited draft; import and watch point to forge', () => {
	const out = recordings();
	const drafts = path.join(path.dirname(out), 'drafts');
	const run = (...args) => spawnSync(process.execPath, [CLI, 'record', ...args], { encoding: 'utf8' });

	const listed = run('list', '--recordings', out);
	assert.equal(listed.status, 0, listed.stderr);
	assert.match(listed.stdout, new RegExp(`${HUMAN}.*31 events.*Human WARRIOR Alliance`));

	const drafted = run('draft', HUMAN, '--recordings', out, '--out', drafts);
	assert.equal(drafted.status, 0, drafted.stderr);
	const file = path.join(drafts, 'alliance-human-2026-10-03-0400.guide');
	assert.equal(fs.readFileSync(file, 'utf8'), EXPECTED_DRAFT);

	fs.writeFileSync(file, 'edited by hand\n');
	const again = run('draft', path.join(out, `${HUMAN}.json`), '--out', drafts);
	assert.equal(again.status, 1);
	assert.equal(fs.readFileSync(file, 'utf8'), 'edited by hand\n');
	assert.equal(run('draft', HUMAN, '--recordings', out, '--out', drafts, '--force').status, 0);
	assert.equal(fs.readFileSync(file, 'utf8'), EXPECTED_DRAFT);

	for (const sub of ['import', 'watch']) {
		const r = run(sub);
		assert.equal(r.status, 2);
		assert.match(r.stderr, /forge record import/);
	}
});

test('record draft inside a guide pack writes a pack-prefixed draft into <pack>/drafts/', () => {
	const out = recordings();
	const session = readJson(FIXTURE);
	assert.equal(draftGuide(session, { pack: 'joe' }).id, 'joe/draft/alliance/human/2026-10-03-0400');
	assert.equal(draftGuide(session, { pack: 'guides' }).id, 'draft/alliance/human/2026-10-03-0400');

	const pack = tmpdir('polestar-pack-');
	fs.cpSync(path.join(__dirname, 'fixtures', 'packs', 'joe'), pack, { recursive: true });
	const r = spawnSync(process.execPath, [CLI, 'record', 'draft', HUMAN, '--recordings', out], { cwd: path.join(pack, 'guides'), encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	const file = path.join(pack, 'drafts', 'alliance-human-2026-10-03-0400.guide');
	const text = fs.readFileSync(file, 'utf8');
	assert.equal(text, EXPECTED_DRAFT.replace('guide draft/', 'guide joe/draft/'));
	assert.match(r.stdout, /joe\/draft\/alliance\/human\/2026-10-03-0400/);
	// --pack names the pack from anywhere.
	const other = tmpdir('polestar-pack-');
	fs.cpSync(path.join(__dirname, 'fixtures', 'packs', 'mini'), other, { recursive: true });
	const r2 = spawnSync(process.execPath, [CLI, 'record', 'draft', HUMAN, '--recordings', out, '--pack', other], { encoding: 'utf8' });
	assert.equal(r2.status, 0, r2.stderr);
	assert.match(fs.readFileSync(path.join(other, 'drafts', 'alliance-human-2026-10-03-0400.guide'), 'utf8'), /^guide mini\/draft\/alliance\/human\/2026-10-03-0400$/m);
});

// An hour of play recorded by the addon in the stub world (schema 2 chunks,
// tests/fixtures/recordings/Polestar_Recorder.lua), through `forge record import`.
test('forge record import turns the addon\'s chunks into a normalized schema 2 session', (t) => {
	const dir = tmpdir('polestar-record-');
	const svDir = path.join(dir, 'WTF', 'Account', 'TESTACCOUNT', 'SavedVariables');
	fs.mkdirSync(svDir, { recursive: true });
	fs.mkdirSync(path.join(dir, 'WTF', 'Account', 'TESTACCOUNT', 'Test Realm', 'Testchar'), { recursive: true });
	fs.copyFileSync(path.join(__dirname, 'fixtures', 'recordings', 'Polestar_Recorder.lua'), path.join(svDir, 'Polestar_Recorder.lua'));
	const out = path.join(dir, 'recordings');
	const r = forge(['record', 'import', '--wtf', path.join(dir, 'WTF'), '--out', out]);
	if (!r) return t.skip('no forge binary (rust/target/release/forge or $FORGE)');
	assert.equal(r.status, 0, r.stderr);
	assert.match(r.stdout, /13 chunk\(s\) archived; .*1 new/);
	assert.equal(fs.readdirSync(path.join(out, 'raw', 'local', 'testinstall1')).filter((f) => f.endsWith('.txt')).length, 13);
	const s = readJson(path.join(out, '20261003T040000Z-testinstall1-char000001.json'));
	assert.deepEqual(
		[s.schema, s.contributor, s.install, s.charId, s.locale, s.build, s.char],
		[2, 'local', 'testinstall1', 'char000001', 'enUS', 70338, { id: 'char000001', race: 'Human', class: 'WARRIOR', faction: 'Alliance', sex: 2, level: 1 }],
	);
	assert.equal(JSON.stringify(s).includes('Testchar'), false, 'no character name anywhere');
	assert.deepEqual(s.chunks, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]);
	const first = (e) => s.events.find((ev) => ev.e === e);
	assert.deepEqual(first('accept'), { t: 0, e: 'accept', q: 100, map: 1429, x: 50, y: 50, lvl: 1, items: [], choices: [], itemCounts: [], choiceCounts: [] });
	assert.deepEqual(first('kill'), { t: 38, e: 'kill', npc: 6, npcLvl: 4, cls: 'normal', map: 1429, x: 34.04, y: 50, xp: 45, rested: 22, q: 100, oi: 1 });
	assert.equal(first('progress').text, 'Kobold Vermin slain: 1/100');
	assert.deepEqual(first('turnin'), { t: 602, e: 'turnin', q: 100, npc: 810, map: 1429, x: 70.38, y: 50, lvl: 1, xpReward: 450, money: 120 });
	assert.deepEqual(first('fp').known, [2, 4]);
	assert.equal(s.events.filter((ev) => ev.e === 'drop').length, 120);
	assert.deepEqual(Object.keys(s.maps), ['1429']);

	// Again: nothing new; the session is unchanged.
	const again = forge(['record', 'import', '--wtf', path.join(dir, 'WTF'), '--out', out]);
	assert.match(again.stdout, /0 chunk\(s\) archived; .*0 new, 0 updated, 1 unchanged/);

	// The same file sent in loose (not inside this PC's game folders): it needs --vouch or --anonymize.
	const loose = path.join(svDir, 'Polestar_Recorder.lua');
	const refused = forge(['record', 'import', '--wtf', loose, '--out', out]);
	assert.equal(refused.status, 2);
	assert.match(refused.stderr, /--vouch <name>.*--anonymize/);
	assert.equal(forge(['record', 'import', '--wtf', loose, '--out', out, '--vouch', 'Alice']).status, 2, 'a vouched name is lowercase');
	assert.equal(forge(['record', 'import', '--wtf', loose, '--out', out, '--vouch', 'alice', '--anonymize']).status, 2);
	const vouched = forge(['record', 'import', '--wtf', loose, '--out', out, '--vouch', 'alice']);
	assert.equal(vouched.status, 0, vouched.stderr);
	assert.equal(readJson(path.join(out, '20261003T040000Z-sent-alice-testinstall1-char000001.json')).contributor, 'sent-alice');
	const anon = forge(['record', 'import', '--wtf', loose, '--out', out, '--anonymize']);
	assert.equal(anon.status, 0, anon.stderr);
	const anonFile = fs.readdirSync(out).find((f) => /-anon-[0-9a-f]{16}-testinstall1-char000001\.json$/.test(f));
	assert.ok(anonFile, fs.readdirSync(out).join(' '));
	assert.match(readJson(path.join(out, anonFile)).contributor, /^anon-[0-9a-f]{16}$/);
	// Each kept apart: the maintainer's own archive is untouched.
	assert.deepEqual(fs.readdirSync(path.join(out, 'raw')).filter((f) => f !== 'contributors.json').sort(), ['local', 'sent-alice', anonFile.match(/anon-[0-9a-f]{16}/)[0]].sort());
});

test('record trail: the trail-flagged positions between a mark "trail on" and its "trail off"', () => {
	const session = {
		schema: 2,
		session: '20261003T040000Z-char000001',
		events: [
			{ t: 0, e: 'pos', map: 1429, x: 40, y: 40, flags: 0 },
			{ t: 1, e: 'mark', text: 'trail on: Brill to the Magic Quarter', map: 1429, x: 40, y: 40 },
			{ t: 1.2, e: 'pos', map: 1429, x: 40, y: 40, flags: 64, speed: 7, trail: true },
			{ t: 1.5, e: 'pos', map: 1429, x: 40.06, y: 40, flags: 80, speed: 7, falling: true, trail: true },
			{ t: 2, e: 'mark', text: 'trail off: Brill to the Magic Quarter (2 points, 3 yd, off)', map: 1429, x: 40.06, y: 40 },
			{ t: 3, e: 'pos', map: 1429, x: 41, y: 40, flags: 0 },
		],
	};
	const out = path.join(recordings(), '..', 'trails.json');
	const file = path.join(path.dirname(out), 'session.json');
	fs.writeFileSync(file, JSON.stringify(session));
	const r = spawnSync(process.execPath, [CLI, 'record', 'trail', file, '--out', out], { encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	assert.match(r.stdout, /1 trail\(s\), 2 points/);
	assert.deepEqual(readJson(out), [
		{
			label: 'Brill to the Magic Quarter', start: 1, end: 2, reason: 'off',
			points: [
				{ t: 1.2, map: 1429, x: 40, y: 40, speed: 7, mounted: false, swimming: false, falling: false, indoors: false, flying: false },
				{ t: 1.5, map: 1429, x: 40.06, y: 40, speed: 7, mounted: false, swimming: false, falling: true, indoors: false, flying: false },
			],
		},
	]);
});
