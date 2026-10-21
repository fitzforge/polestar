'use strict';
// polestar playtest: a pack's guides played to the end for every class they
// branch on plus one they never name, with our guides loaded beside them.
//
// Needs data/forever and Lua 5.1; skips without them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { quiet, polestar } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const { needs } = require('./helpers/data');
const { findLua } = require('../tools/lib/lua');
const cmd = require('../tools/commands/playtest');
const { playtest, chainDone } = require('../tools/lib/playtest');
const { commandPack } = require('../tools/lib/pack/locate');

const PACKS = path.join(__dirname, 'fixtures', 'packs');
const hasLua = (() => {
	try {
		return !!findLua();
	} catch {
		return false;
	}
})();
const skip = needs('quests.json') || (!hasLua && 'no Lua 5.1');

const lines = (out) => out.split('\n').filter(Boolean);

test('a guide starts with the prerequisites its accepts need that the guides chaining into it turn in for the character done, and those they leave for it only to hand in in the log', () => {
	const step = (goals, only) => ({ only, goals });
	const a = { id: 'a', next: 'b', steps: [step([{ t: 'turnin', quest: 7003 }, { t: 'turnin', quest: 7638, only: { races: ['Human'] } }, { t: 'turnin', quest: 1 }, { t: 'accept', quest: 739 }, { t: 'accept', quest: 2 }, { t: 'accept', quest: 6127 }])] };
	const b = { id: 'b', nextChoices: ['c', 'x'], steps: [step([{ t: 'turnin', quest: 7721 }], { classes: ['Druid'] })] };
	const c = {
		id: 'c',
		steps: [step([
			{ t: 'turnin', quest: 739 },
			{ t: 'accept', quest: 704, pre: [739] },
			{ t: 'accept', quest: 3, pre: [2] }, // 2 is carried but never turned in here
			{ t: 'collect', quest: 6127, oi: 1 }, // 6127's objective is done here, so it is not carried ready
			{ t: 'turnin', quest: 6127 },
			{ t: 'accept', quest: 6128, pre: [6127] },
			{ t: 'accept', quest: 7725, pre: [7003] },
			{ t: 'accept', quest: 7726, pre: [7721] },
			{ t: 'accept', quest: 7637, preAll: [7638] },
			{ t: 'accept', quest: 3261, pre: [905] },
		])],
	};
	const guides = [a, b, c];
	assert.deepEqual(chainDone(guides, c, { race: 'Dwarf', faction: 'Alliance', cls: 'WARRIOR' }), { done: [7003], carried: [739] });
	assert.deepEqual(chainDone(guides, c, { race: 'Human', faction: 'Alliance', cls: 'DRUID' }), { done: [7003, 7638, 7721], carried: [739] });
	assert.deepEqual(chainDone(guides, a, { race: 'Human', faction: 'Alliance', cls: 'DRUID' }), { done: [], carried: [] });
});

test('the chain credits a turn-in behind `when group` only when the play answers do; `when !group` only when it skips', () => {
	const a = { id: 'a', next: 'b', steps: [{ goals: [{ t: 'turnin', quest: 10 }] }, { when: [{ k: 'group', q: 11 }], goals: [{ t: 'turnin', quest: 11 }] }, { when: [{ k: 'group', q: 11, neg: true }], goals: [{ t: 'turnin', quest: 12 }] }] };
	const b = { id: 'b', steps: [{ goals: [{ t: 'accept', quest: 20, pre: [10] }, { t: 'accept', quest: 21, pre: [11] }, { t: 'accept', quest: 22, pre: [12] }] }] };
	const who = { race: 'Human', faction: 'Alliance', cls: 'WARRIOR' };
	assert.deepEqual(chainDone([a, b], b, who), { done: [10, 12], carried: [] }, 'skip by default');
	assert.deepEqual(chainDone([a, b], b, who, 'do'), { done: [10, 11], carried: [] });
});

test('--group takes do or skip; anything else is refused', async () => {
	const bad = await quiet(() => cmd.run(['--group', 'maybe']));
	assert.equal(bad.result, 2);
	assert.match(bad.out, /--group must be do or skip/);
});

test('a stuck step is reported with guide, step, title and class; exit 1', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'stuck')]));
	assert.equal(result, 1);
	const stuck = lines(out).filter((l) => l.startsWith('stuck '));
	assert.deepEqual(stuck, ['stuck stuck/northshire (Human Warrior) at step 2 "Never finished": goal 1 (goto "Go to Nowhere") stays active']);
	assert.match(out, /playtest failed: 1 guide, 1 play: 1 stuck/);
});

test('a guide that plays through, handing over to one of ours, prints ok with race and class for each class it branches on that the race can be, plus one it never names; exit 0', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run(['--filter', 'northshire', '--pack', path.join(PACKS, 'plays')]));
	assert.equal(result, 0, out);
	// Its Shaman and Druid step is not played: no Human is either.
	assert.deepEqual(lines(out).filter((l) => l.startsWith('ok ')), ['ok  plays/northshire (Human Warrior)', 'ok  plays/northshire (Human Paladin)']);
	assert.match(out, /playtest ok: 1 guide, 2 plays: 0 stuck, 0 failed/);
});

test('a hand-over to one of ours that does not land is stuck at the hand-over; exit 1', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'plays')]));
	assert.equal(result, 1, out);
	assert.deepEqual(lines(out).filter((l) => l.startsWith('stuck ')), [
		'stuck plays/done-on-arrival (Human Warrior) at hand-over to forever/alliance/human/01-elwynn-forest: Polestar did not open it (plays/done-on-arrival stayed open)',
	]);
	assert.match(out, /playtest failed: 2 guides, 3 plays: 1 stuck, 0 failed/);
});

test('a hand-over in the middle of the last act stops the simulator on the pack guide and lands on ours', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run(['--filter', 'northshire', path.join(PACKS, 'handover')]));
	assert.equal(result, 0, out);
	assert.deepEqual(lines(out), ['ok  handover/northshire (Human Warrior)', 'playtest ok: 1 guide, 1 play: 0 stuck, 0 failed']);
});

test('a hand-over must land on a guide the character can follow: a Human handed to a Dwarf and Gnome guide is stuck', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'misfit')]));
	assert.equal(result, 1, out);
	assert.deepEqual(lines(out).filter((l) => /^(ok|stuck) /.test(l)), [
		'stuck misfit/northshire (Human Warrior) at hand-over to forever/alliance/dwarf-gnome/01-dun-morogh: no Human can follow it',
		'ok  misfit/northshire (Dwarf Warrior)',
	]);
});

test('a route choice lands on whichever option the engine recommends, not only the first', { skip }, () => {
	const pack = commandPack({ pack: path.join(PACKS, 'handover') });
	const { results } = playtest({ dir: pack.dir, manifest: pack.manifest, filter: 'tirisfal', contextDir: pack.contextDir, contextDataDir: pack.contextDataDir });
	assert.equal(results.length, 1);
	assert.equal(results[0].ok, true, JSON.stringify(results[0]));
	assert.equal(results[0].landed, 'forever/horde/03-silverpine-forest', 'the recommended option here is the second one');
});

test('a `next` option whose `when` does not hold is no hand-over: the engine goes on to one offered, or the guide ends there', { skip }, () => {
	const pack = commandPack({ pack: path.join(PACKS, 'handover') });
	const play = (filter) => playtest({ dir: pack.dir, manifest: pack.manifest, filter, contextDir: pack.contextDir, contextDataDir: pack.contextDataDir }).results;
	const [one] = play('conditional');
	assert.equal(one.ok, true, JSON.stringify(one));
	assert.equal(one.landed, 'forever/horde/02-the-barrens', 'Silverpine, recommended otherwise, is not offered below level 40');
	const [ends] = play('ends');
	assert.equal(ends.ok, true, JSON.stringify(ends));
	assert.equal(ends.landed, 'handover/ends');
});

test('--class plays only that class; a filter matching nothing exits 1; a class no race can be plays nothing, exit 1', { skip }, async () => {
	const one = await quiet(() => cmd.run(['--filter', 'northshire', '--pack', path.join(PACKS, 'plays'), '--class', 'mage']));
	assert.equal(one.result, 0, one.out);
	assert.deepEqual(lines(one.out).filter((l) => l.startsWith('ok ')), ['ok  plays/northshire (Human Mage)']);
	const none = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'plays'), '--filter', 'nothing-here']));
	assert.equal(none.result, 1);
	assert.match(none.out, /no guide matches "nothing-here"/);
	const shaman = await quiet(() => cmd.run(['--filter', 'northshire', '--pack', path.join(PACKS, 'plays'), '--class', 'shaman']));
	assert.equal(shaman.result, 1, shaman.out);
	assert.match(shaman.out, /playtest failed: nothing played: 1 guide, but no race can play a Shaman/);
	const bad = await quiet(() => cmd.run(['--class', 'Monk']));
	assert.equal(bad.result, 2);
});

test('context folders go through the same checks as compile: a typo is a usage error', async () => {
	const missing = path.join(tmpdir(), 'missing');
	for (const flag of ['--context', '--context-data']) {
		const r = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'plays'), flag, missing]));
		assert.equal(r.result, 2, r.out);
		assert.match(r.out, new RegExp(`${flag} .*missing is not a folder`));
	}
});

test('missing reference data is an error naming data build, not a stuck or empty run', { skip: hasLua ? false : 'no Lua 5.1' }, async () => {
	const empty = tmpdir();
	const r = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'plays'), '--data', empty, '--context-data', empty]));
	assert.equal(r.result, 1, r.out);
	assert.match(r.out, /error: reference data missing quests\.json.*: run node tools\/polestar\.js data build/);
	assert.match(r.out, /playtest failed: no reference data to play against/);
	assert.doesNotMatch(r.out, /`lint`/);
	assert.doesNotMatch(r.out, /^(ok|stuck) /m);
});

test('without Lua 5.1 playtest says so and points to doctor, without a stack trace; exit 1', () => {
	const bin = tmpdir();
	const r = polestar(['playtest', path.join(PACKS, 'plays')], { env: { PATH: bin, LUA: path.join(bin, 'no-lua') } });
	assert.equal(r.status, 1, r.stderr);
	assert.match(r.stderr, /playtest failed: No Lua 5\.1 interpreter found .* Run `polestar doctor` for the install steps\./);
	assert.doesNotMatch(r.stderr, /\n\s+at /, 'no stack trace');
});

test('the pack folder is the one argument; two folders, or a folder and --pack, are a usage error', async () => {
	const two = await quiet(() => cmd.run([path.join(PACKS, 'plays'), path.join(PACKS, 'stuck')]));
	assert.equal(two.result, 2, two.out);
	assert.match(two.out, /one pack folder only/);
	const both = await quiet(() => cmd.run([path.join(PACKS, 'plays'), '--pack', path.join(PACKS, 'stuck')]));
	assert.equal(both.result, 2, both.out);
	assert.match(both.out, /the pack folder is named twice/);
	const none = await quiet(() => cmd.run([tmpdir()]));
	assert.equal(none.result, 2, none.out);
	assert.match(none.out, /no pack\.json in /);
});

test('a class no persona\'s race can be is played as the first race of the guide\'s side that can be it: an `only Druid` step in a Horde guide and a `class Druid` guide play as Tauren; `class Shaman, Druid` plays each', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run([path.join(PACKS, 'classes')]));
	assert.equal(result, 0, out);
	const ok = lines(out).filter((l) => l.startsWith('ok '));
	assert.ok(ok.includes('ok  classes/mulgore (Tauren Druid)'), out);
	assert.ok(ok.includes('ok  classes/mulgore (Orc Warrior)'), out);
	assert.ok(ok.includes('ok  classes/druid (Tauren Druid)'), out);
	assert.deepEqual(ok.filter((l) => l.includes('classes/totems')), ['ok  classes/totems (Orc Shaman)', 'ok  classes/totems (Tauren Shaman)', 'ok  classes/totems (Tauren Druid)']);
});

test('level goals inside a level play through: the player gets that share of the level\'s XP', { skip }, () => {
	const pack = commandPack({ pack: path.join(PACKS, 'halflevel') });
	const { results } = playtest({ dir: pack.dir, manifest: pack.manifest, classes: ['WARRIOR'], contextDir: pack.contextDir, contextDataDir: pack.contextDataDir });
	assert.ok(results.length > 0);
	for (const r of results) assert.equal(r.ok, true, JSON.stringify(r));
});
