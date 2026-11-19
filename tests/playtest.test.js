'use strict';
// polestar playtest: a pack's guides played to the end for every class they
// branch on plus one they never name, with our guides loaded beside them.
//
// Needs data/forever and Lua 5.1; skips without them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { quiet, polestar } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const { needs } = require('./helpers/data');
const { DATA_DIR } = require('./helpers/dsl');
const { findLua } = require('../tools/lib/lua');
const cmd = require('../tools/commands/playtest');
const { playtest, chainDone, dungeonPicker } = require('../tools/lib/playtest');
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

test('invalid explicit worker counts fail before loading reference data', async () => {
	for (const workers of [-1, 0, 1.5, Infinity, NaN]) {
		await assert.rejects(playtest({ workers }), /worker count must be a positive integer/, String(workers));
	}
});

test('invalid POLESTAR_PLAY_WORKERS fails the command instead of silently skipping plays', { skip: !hasLua && 'no Lua 5.1' }, () => {
	for (const value of ['-1', '0', '1.5', 'Infinity', 'NaN', 'nope', '', ' ']) {
		const r = polestar(['playtest', '--pack', path.join(PACKS, 'plays')], { env: { POLESTAR_PLAY_WORKERS: value } });
		assert.equal(r.status, 1, `${JSON.stringify(value)}: ${r.stdout}\n${r.stderr}`);
		assert.match(r.stderr, /worker count must be a positive integer/, value);
	}
});

test('valid worker settings reach the data checks; an explicit count wins and honest play needs no workers', async () => {
	const saved = process.env.POLESTAR_PLAY_WORKERS;
	const dataDir = tmpdir();
	const check = async (options = {}) => assert.equal((await playtest({ dataDir, ...options })).dataMissing, true);
	try {
		delete process.env.POLESTAR_PLAY_WORKERS;
		await check();
		for (const value of ['1', '2']) {
			process.env.POLESTAR_PLAY_WORKERS = value;
			await check();
		}
		process.env.POLESTAR_PLAY_WORKERS = '-1';
		await check({ workers: 1 });
		await check({ honest: true });
	} finally {
		if (saved === undefined) delete process.env.POLESTAR_PLAY_WORKERS;
		else process.env.POLESTAR_PLAY_WORKERS = saved;
	}
});

test('a guide starts with the prerequisites its accepts need that the guides chaining into it turn in for the character done, those they leave for it only to hand in in the log, and those it works in the log with their objectives open', () => {
	const step = (goals, only) => ({ only, goals });
	const a = { id: 'a', next: 'b', steps: [step([{ t: 'turnin', quest: 7003 }, { t: 'turnin', quest: 7638, only: { races: ['Human'] } }, { t: 'turnin', quest: 1 }, { t: 'accept', quest: 739 }, { t: 'accept', quest: 2 }, { t: 'accept', quest: 6127 }])] };
	const b = { id: 'b', nextChoices: ['c', 'x'], steps: [step([{ t: 'turnin', quest: 7721 }], { classes: ['Druid'] })] };
	const c = {
		id: 'c',
		steps: [step([
			{ t: 'turnin', quest: 739 },
			{ t: 'accept', quest: 704, pre: [739] },
			{ t: 'accept', quest: 3, pre: [2] }, // 2 is carried but never turned in here
			{ t: 'collect', quest: 6127, oi: 1 }, // 6127's objective is done here: in the log, not ready
			{ t: 'turnin', quest: 6127 },
			{ t: 'accept', quest: 6128, pre: [6127] },
			{ t: 'accept', quest: 7725, pre: [7003] },
			{ t: 'accept', quest: 7726, pre: [7721] },
			{ t: 'accept', quest: 7637, preAll: [7638] },
			{ t: 'accept', quest: 3261, pre: [905] },
		])],
	};
	const guides = [a, b, c];
	assert.deepEqual(chainDone(guides, c, { race: 'Dwarf', faction: 'Alliance', cls: 'WARRIOR' }), { done: [7003], carried: [739], open: [6127] });
	assert.deepEqual(chainDone(guides, c, { race: 'Human', faction: 'Alliance', cls: 'DRUID' }), { done: [7003, 7638, 7721], carried: [739], open: [6127] });
	assert.deepEqual(chainDone(guides, a, { race: 'Human', faction: 'Alliance', cls: 'DRUID' }), { done: [], carried: [], open: [] });
});

test('the chain credits a turn-in behind `when group` only when the play answers do; `when !group` only when it skips', () => {
	const a = { id: 'a', next: 'b', steps: [{ goals: [{ t: 'turnin', quest: 10 }] }, { when: [{ k: 'group', q: 11 }], goals: [{ t: 'turnin', quest: 11 }] }, { when: [{ k: 'group', q: 11, neg: true }], goals: [{ t: 'turnin', quest: 12 }] }] };
	const b = { id: 'b', steps: [{ goals: [{ t: 'accept', quest: 20, pre: [10] }, { t: 'accept', quest: 21, pre: [11] }, { t: 'accept', quest: 22, pre: [12] }] }] };
	const who = { race: 'Human', faction: 'Alliance', cls: 'WARRIOR' };
	assert.deepEqual(chainDone([a, b], b, who), { done: [10, 12], carried: [], open: [] }, 'skip by default');
	assert.deepEqual(chainDone([a, b], b, who, 'do'), { done: [10, 11], carried: [], open: [] });
});

test('the chain credits a turn-in behind `when dungeon` only for a chosen dungeon (by name or map id); `when !dungeon` only for one not chosen', () => {
	const a = { id: 'a', next: 'b', steps: [{ when: [{ k: 'dungeon', name: 'The Deadmines', map: 36 }], goals: [{ t: 'turnin', quest: 11 }] }, { when: [{ k: 'dungeon', name: 'The Deadmines', map: 36, neg: true }], goals: [{ t: 'turnin', quest: 12 }] }] };
	const b = { id: 'b', steps: [{ goals: [{ t: 'accept', quest: 21, pre: [11] }, { t: 'accept', quest: 22, pre: [12] }] }] };
	const who = { race: 'Human', faction: 'Alliance', cls: 'WARRIOR' };
	assert.deepEqual(chainDone([a, b], b, who), { done: [12], carried: [], open: [] }, 'none chosen by default: the solo route');
	for (const chosen of [['Deadmines'], ['The Deadmines'], ['36'], 'all']) assert.deepEqual(chainDone([a, b], b, who, 'skip', dungeonPicker(chosen)), { done: [11], carried: [], open: [] }, String(chosen));
	assert.deepEqual(chainDone([a, b], b, who, 'skip', dungeonPicker(['Wailing Caverns'])), { done: [12], carried: [], open: [] });
});

test('--group takes do or skip; anything else is refused', async () => {
	const bad = await quiet(() => cmd.run(['--group', 'maybe']));
	assert.equal(bad.result, 2);
	assert.match(bad.out, /--group must be do or skip/);
});

test('--learn takes profession names separated by commas, and not with --honest', async () => {
	for (const bad of ['Herbalism,', ',Skinning']) {
		const r = await quiet(() => cmd.run(['--learn', bad]));
		assert.equal(r.result, 2, bad);
		assert.match(r.out, /--learn takes profession names separated by commas/);
	}
	const honest = await quiet(() => cmd.run(['--honest', '--learn', 'Herbalism']));
	assert.equal(honest.result, 2);
	assert.match(honest.out, /--learn plays in the addon: it does not go with --honest/);
});

test('--learn plays a player who chose the profession: the optional train is taken and the step behind `when skill` is played; without it neither is', { skip }, async () => {
	const pack = path.join(PACKS, 'skill');
	const without = await quiet(() => cmd.run(['--pack', pack, '--class', 'Warrior']));
	assert.equal(without.result, 0, without.out);
	assert.deepEqual(lines(without.out).filter((l) => /^(ok|stuck) /.test(l)), ['ok  skill/northshire (Human Warrior)']);
	const chose = await quiet(() => cmd.run(['--pack', pack, '--class', 'Warrior', '--learn', 'Herbalism']));
	assert.equal(chose.result, 1, chose.out);
	assert.deepEqual(lines(chose.out).filter((l) => /^(ok|stuck) /.test(l)), ['stuck skill/northshire (Human Warrior) at step 3 "Herbs": goal 1 (goto "Go to Nowhere") stays active']);
	// Another profession's choice leaves Herbalism's train alone.
	const other = await quiet(() => cmd.run(['--pack', pack, '--class', 'Warrior', '--learn', 'Mining']));
	assert.equal(other.result, 0, other.out);
	const unknown = await quiet(() => cmd.run(['--pack', pack, '--class', 'Warrior', '--learn', 'Basketweaving']));
	assert.equal(unknown.result, 1);
	assert.match(unknown.out, /profession "Basketweaving" is not in the reference data/);
});

// --level-offset: the simulated player starts a level-1 guide at level 1 + n. The fixture's `when level>=2` step
// leads nowhere: a character one level ahead plays it and is stuck there; one at the guide's level (or behind it,
// never below 1) skips it.
test('--level-offset plays a character n levels ahead: a step behind `when level>=2` in a level-1 guide is visited only one level ahead', { skip }, async () => {
	const pack = path.join(PACKS, 'ahead');
	const plain = await quiet(() => cmd.run(['--pack', pack, '--class', 'Warrior']));
	assert.equal(plain.result, 0, plain.out);
	assert.deepEqual(lines(plain.out).filter((l) => /^(ok|stuck) /.test(l)), ['ok  ahead/northshire (Human Warrior)']);
	const ahead = await quiet(() => cmd.run(['--pack', pack, '--class', 'Warrior', '--level-offset', '1']));
	assert.equal(ahead.result, 1, ahead.out);
	assert.deepEqual(lines(ahead.out).filter((l) => /^(ok|stuck) /.test(l)), ['stuck ahead/northshire (Human Warrior) at step 2 "Ahead": goal 1 (goto "Go to Nowhere") stays active']);
	const behind = await quiet(() => cmd.run(['--pack', pack, '--class', 'Warrior', '--level-offset', '-3']));
	assert.equal(behind.result, 0, behind.out);
	const bad = await quiet(() => cmd.run(['--pack', pack, '--level-offset', '1.5']));
	assert.equal(bad.result, 2);
	assert.match(bad.out, /--level-offset takes a whole number/);
	const honest = await quiet(() => cmd.run(['--honest', '--level-offset', '1']));
	assert.equal(honest.result, 2);
	assert.match(honest.out, /--level-offset plays the simulated player: it does not go with --honest/);
});

test('a stuck step is reported with guide, step, title and class; exit 1', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'stuck')]));
	assert.equal(result, 1);
	const stuck = lines(out).filter((l) => l.startsWith('stuck '));
	assert.deepEqual(stuck, ['stuck stuck/northshire (Human Warrior) at step 2 "Never finished": goal 1 (goto "Go to Nowhere") stays active']);
	assert.match(out, /playtest failed: 1 guide, 1 play: 1 stuck/);
});

// The simulated player used to finish a quest at its hand-in, so a guide with no goal for an escort (Kerlonian's,
// 5321, 2026-11-16) played clean while players were sent to the hand-in with the escort undone. The game takes no
// hand-in with a line open: a kill, talk, object or event line no goal works holds the play there.
test('a hand-in whose quest has a line no goal works is stuck there; with the goal it plays through', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'handin'), '--class', 'Warrior']));
	assert.equal(result, 1, out);
	const stuck = lines(out).filter((l) => l.startsWith('stuck '));
	assert.equal(stuck.length, 1, out);
	assert.match(stuck[0], /^stuck handin\/bare \(Night Elf Warrior\) at step 2 "Maestra's Post": the game takes no hand-in of quest 5321: line \d \(event\), which no goal of the guide works, is not done$/);
	assert.ok(lines(out).includes('ok  handin/worked (Night Elf Warrior)'), out);
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

test('a hand-over must land on a guide the character can follow: a Human handed to the Dwarf guide is stuck', { skip }, async () => {
	const { result, out } = await quiet(() => cmd.run(['--pack', path.join(PACKS, 'misfit')]));
	assert.equal(result, 1, out);
	assert.deepEqual(lines(out).filter((l) => /^(ok|stuck) /.test(l)), [
		'stuck misfit/northshire (Human Warrior) at hand-over to forever/alliance/dwarf/01-dun-morogh: no Human can follow it',
		'ok  misfit/northshire (Dwarf Warrior)',
	]);
});

test('a route choice lands on whichever option the engine recommends, not only the first', { skip }, async () => {
	const pack = commandPack({ pack: path.join(PACKS, 'handover') });
	const { results } = await playtest({ dir: pack.dir, manifest: pack.manifest, filter: 'tirisfal', contextDir: pack.contextDir, contextDataDir: pack.contextDataDir });
	assert.equal(results.length, 1);
	assert.equal(results[0].ok, true, JSON.stringify(results[0]));
	assert.equal(results[0].landed, 'forever/horde/03-silverpine-forest', 'the recommended option here is the second one');
});

test('a `next` option whose `when` does not hold is no hand-over: the engine goes on to one offered, or the guide ends there', { skip }, async () => {
	const pack = commandPack({ pack: path.join(PACKS, 'handover') });
	const play = async (filter) => (await playtest({ dir: pack.dir, manifest: pack.manifest, filter, contextDir: pack.contextDir, contextDataDir: pack.contextDataDir })).results;
	const [one] = await play('conditional');
	assert.equal(one.ok, true, JSON.stringify(one));
	assert.equal(one.landed, 'forever/horde/02-the-barrens', 'Silverpine, recommended otherwise, is not offered below level 40');
	const [ends] = await play('ends');
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

// Honest mode needs no Lua or private reference data. Leave out the kill to
// prove that a matching character really plays the guide and finds its error.
function honestMageArgs(broken = false, otherClassGuide = false) {
	const dir = tmpdir('polestar-honest-class-');
	fs.writeFileSync(path.join(dir, 'mage.guide'), [
		'guide test/mage', 'title Mage fixture', 'faction Alliance', 'class Mage',
		'race Human', 'levels 1-10', 'zone Elwynn Forest', 'step Kobolds',
		'  accept 7', ...(broken ? [] : ['  kill 6 x10 quest 7.1']), '  turnin 7', '',
	].join('\n'));
	if (otherClassGuide) fs.writeFileSync(path.join(dir, 'warrior.guide'), [
		'guide test/warrior', 'title Warrior fixture', 'faction Alliance', 'class Warrior',
		'race Human', 'levels 1-10', 'zone Elwynn Forest', 'step Here', '  goto 48,42', '',
	].join('\n'));
	return ['--honest', '--guides', dir, '--data', DATA_DIR];
}

for (const format of ['text', 'json']) {
	test(`--honest --class refuses a guide no character can play (${format})`, async () => {
		const r = await quiet(() => cmd.run([...honestMageArgs(true), '--class', 'Warrior', '--format', format]));
		assert.equal(r.result, 1, r.out);
		assert.match(r.out, /playtest(?: --honest)? failed: nothing played/);
		assert.doesNotMatch(r.out, /playtest --honest ok|"ok":\s*true/);
	});
}

test('--honest does not count a compatible class from outside the selected guide chain', async () => {
	const r = await quiet(() => cmd.run([...honestMageArgs(true, true), '--filter', 'test/mage', '--class', 'Warrior']));
	assert.equal(r.result, 1, r.out);
	assert.match(r.out, /nothing played/);
});

test('--honest keeps an unmatched guide filter distinct from an unplayable class', async () => {
	const r = await quiet(() => cmd.run([...honestMageArgs(), '--class', 'Mage', '--filter', 'nothing-here', '--format', 'json']));
	assert.equal(r.result, 1, r.out);
	assert.match(r.out, /no guide matches "nothing-here"/);
	assert.doesNotMatch(r.out, /nothing played/);
});

test('--honest succeeds when a matching class plays a guide with no findings', async () => {
	const args = [...honestMageArgs(), '--class', 'Mage'];
	const text = await quiet(() => cmd.run(args));
	assert.equal(text.result, 0, text.out);
	assert.match(text.out, /playtest --honest ok: 1 guide: 0 fails/);
	const json = await quiet(() => cmd.run([...args, '--format', 'json']));
	assert.equal(json.result, 0, json.out);
	const report = JSON.parse(json.out);
	assert.equal(report.ok, true);
	assert.equal(report.played, 1);
	assert.deepEqual(report.findings, []);
});

test('--honest reports the unfinished quest when a matching class plays it', async () => {
	const r = await quiet(() => cmd.run([...honestMageArgs(true), '--class', 'Mage', '--format', 'json']));
	assert.equal(r.result, 1, r.out);
	const report = JSON.parse(r.out);
	assert.equal(report.ok, false);
	assert.equal(report.played, 1);
	assert.ok(report.findings.some((f) => f.rule === 'R5' && f.severity === 'fail' && f.cls === 'MAGE' && /0\/10/.test(f.reason)), r.out);
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
	assert.match(r.out, /error: reference data missing quests\.json.*: run forge data build/);
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

test('a `buff` goal, a `buff … off` goal and a `rep` goal with points play through: the player gains and loses the aura and earns the points', { skip }, async () => {
	const pack = commandPack({ pack: path.join(PACKS, 'blessed') });
	const { results } = await playtest({ dir: pack.dir, manifest: pack.manifest, classes: ['WARRIOR'], contextDir: pack.contextDir, contextDataDir: pack.contextDataDir });
	assert.ok(results.length > 0);
	for (const r of results) assert.equal(r.ok, true, JSON.stringify(r));
});

test('a `deposit` goal, with and without a count, and an `equip` goal on and off play through: the player banks the item and wears the other', { skip }, async () => {
	const pack = commandPack({ pack: path.join(PACKS, 'banked') });
	const { results } = await playtest({ dir: pack.dir, manifest: pack.manifest, classes: ['WARRIOR'], contextDir: pack.contextDir, contextDataDir: pack.contextDataDir });
	assert.ok(results.length > 0);
	for (const r of results) assert.equal(r.ok, true, JSON.stringify(r));
});

test('level goals inside a level play through: the player gets that share of the level\'s XP', { skip }, async () => {
	const pack = commandPack({ pack: path.join(PACKS, 'halflevel') });
	const { results } = await playtest({ dir: pack.dir, manifest: pack.manifest, classes: ['WARRIOR'], contextDir: pack.contextDir, contextDataDir: pack.contextDataDir });
	assert.ok(results.length > 0);
	for (const r of results) assert.equal(r.ok, true, JSON.stringify(r));
});
