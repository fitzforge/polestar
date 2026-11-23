'use strict';
// polestar playtest --persona (tools/lib/playtest-personas.js): the imperfect
// players. Their tables and variants from a guide and the data; a play that
// loses the item a direct hand-in takes is stuck unless the hand-in's step
// waits for the item (An Apple Treat); the command's options.
//
// The plays need data/forever and Lua 5.1; they skip without them.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { quiet } = require('./helpers/cli');
const { needs, DATA } = require('./helpers/data');
const { findLua } = require('../tools/lib/lua');
const cmd = require('../tools/commands/playtest');
const { Data, loadData } = require('../tools/lib/dsl/data');
const { buildSimPack, playGuide, personaPlaytest, SIMULATE, luaValue } = require('../tools/lib/playtest');
const { personaTables, personaVariants, updatePoints, snapshotLines, SNAPSHOT_LUA } = require('../tools/lib/playtest-personas');
const { readManifest } = require('../tools/lib/pack/manifest');
const { OFFICIAL_DIR } = require('../tools/lib/dsl/project');

const hasLua = (() => {
	try {
		return !!findLua();
	} catch {
		return false;
	}
})();
const skip = needs('quests.json', 'items.json') || (!hasLua && 'no Lua 5.1');

// 100: handed in on the spot for a Thunder Applejack (900), which only 101 (the still, a direct hand-in for
// apples, 901) hands over. 102: started by a letter (902). 103: an ordinary quest; 104 repeatable.
const quest = (id, extra) => ({ id, title: `Quest ${id}`, start: { npc: [1], object: [], item: [] }, objectives: [], ...extra });
const data = new Data({
	quests: {
		100: quest(100, { direct: true, objectives: [{ type: 'item', id: 900, count: 1 }] }),
		101: quest(101, { direct: true, repeatable: true, objectives: [{ type: 'item', id: 901, count: 4 }], web: { items: [[900, 1]] } }),
		102: quest(102, { start: { npc: [], object: [], item: [902] } }),
		103: quest(103, { pre: [99] }),
		104: quest(104, { repeatable: true }),
		99: quest(99),
	},
	items: { 900: { id: 900, name: 'Thunder Applejack', drops: { npc: {}, object: {} }, vendors: [] }, 901: { id: 901, name: 'Apple', drops: { npc: {}, object: {} }, vendors: [5] }, 902: { id: 902, name: 'Letter', drops: { npc: { 7: 1 }, object: {} }, vendors: [] } },
});
const step = (title, goals) => ({ title, goals });
const guide = {
	id: 't/g',
	steps: [
		step('Farm', [{ t: 'buy', item: 901 }]),
		step('Still', [{ t: 'turnin', quest: 101, direct: true, optional: true }, { t: 'collect', item: 900 }]),
		step('Garrison', [{ t: 'turnin', quest: 100, direct: true }, { t: 'accept', quest: 103 }, { t: 'accept', quest: 104 }]),
		step('Loot', [{ t: 'collect', item: 902, optional: true }]),
		step('Read', [{ t: 'accept', quest: 102 }]),
	],
};

test('the tables: what direct hand-ins and item-started accepts take, and the items only quests hand over', () => {
	assert.deepEqual(personaTables(guide, data), { needs: { 100: { 900: 1 }, 101: { 901: 4 }, 102: { 902: 1 } }, gives: { 900: [101] }, rewards: { 101: [900] }, restock: {}, carried: [900, 902] });
	// A step that leads to the item's source (the letter's dropper, npc 7) gives it back there.
	const looted = { id: 't/l', steps: [step('Loot', [{ t: 'kill', npc: 7 }, { t: 'accept', quest: 102 }])] };
	assert.deepEqual(personaTables(looted, data).restock, { 1: [902] });
});

test('skip plays every step that gets an item a later goal hands over, then an even sample of the rest', () => {
	assert.deepEqual(
		personaVariants('skip', guide, data, 3).map((v) => v.persona.skip),
		[1, 2, 4],
	);
	assert.match(personaVariants('skip', guide, data, 3)[0].variant, /^skips step 1 "Farm"$/);
});

test('lost loses each carried item after the step that gets it, or carries none into the guide', () => {
	const v = personaVariants('lost', guide, data);
	assert.deepEqual(
		v.map((x) => [x.variant, x.persona.lose ?? null, x.persona.lack ?? null]),
		[
			['loses Thunder Applejack (900) after getting it', 900, null],
			['loses Letter (902) after getting it', 902, null],
		],
	);
});

test('elsewhere did each quest the guide offers, with the chain before it, never a repeatable one', () => {
	const v = personaVariants('elsewhere', guide, data, 8);
	assert.deepEqual(
		v.map((x) => [x.variant, x.before]),
		[
			['did 100 (Quest 100) before the guide', 'w.complete({100})'],
			['did 102 (Quest 102) before the guide', 'w.complete({102})'],
			['did 103 (Quest 103) before the guide', 'w.complete({103,99})'],
		],
	);
});

test('update leaves the old guide at points spread over its steps, never its first', () => {
	assert.deepEqual(updatePoints({ steps: new Array(100) }, 3), [25, 50, 75]);
	assert.deepEqual(updatePoints({ steps: new Array(2) }, 3), [2]);
	assert.deepEqual(updatePoints({ steps: [1] }, 3), []);
});

test('--persona names known personas; update needs --from; not with --honest', async () => {
	for (const [args, re] of [
		[['--persona', 'nope'], /--persona must be skip, lost, elsewhere, update, fresh or all \(got "nope"\)/],
		[['--persona', 'update'], /the update persona needs --from/],
		[['--persona', 'skip', '--honest'], /does not go with --honest/],
		[['--persona', 'skip', '--sample', '0'], /--sample must be a whole number/],
	]) {
		const { result, out } = await quiet(() => cmd.run(args));
		assert.equal(result, 2, args.join(' '));
		assert.match(out, re);
	}
});

test('persona baselines and variants report the class start gate; strict personas stop there', { skip }, async () => {
	const args = ['--persona', 'skip', '--sample', '1', '--filter', 'forever/class/shaman/call-of-earth-alliance'];
	const plain = await quiet(() => cmd.run(args));
	assert.equal(plain.result, 0, plain.out);
	assert.match(plain.out, /\[baseline: nothing taken away\]: start gate opened: quest 179 \(Dwarven Outfitters\) completed outside the guide/);
	assert.match(plain.out, /\[skip: skips step [^\n]+\]: start gate opened: quest 179 \(Dwarven Outfitters\) completed outside the guide/);
	assert.match(plain.out, /persona skip: 1 play, 0 stuck/);
	const strict = await quiet(() => cmd.run([...args, '--strict-start-gates']));
	assert.equal(strict.result, 1, strict.out);
	assert.match(strict.out, /\[baseline: nothing taken away\] at step 1 "Archaic Rune"/);
	assert.doesNotMatch(strict.out, /start gate opened/);
});

// An Apple Treat (91738), handed in on the spot for the Thunder Applejack (247824).
const appleGuide = (gate) => `guide forever/alliance/apple-test
title Apple
faction Alliance
levels 7-10
zone Elwynn Forest

step Westbrook
  collect 247824 x1 @24.6,58.0

step Road
  goto 30.0,60.0

step Garrison
${gate ? '  when has 247824\n' : ''}  turnin 91738 direct

step After
  goto 40.0,60.0
`;

let realData = null;
const playApple = (gate, persona) => {
	realData = realData || loadData(DATA);
	const pack = buildSimPack([{ file: 'apple.guide', text: appleGuide(gate) }], realData);
	try {
		assert.ok(!pack.diag.hasErrors(), JSON.stringify(pack.diag.errors));
		const g = pack.guides[0];
		const t = personaTables(g, realData);
		const [out] = playGuide(pack, g, { race: 'Human', faction: 'Alliance', cls: 'WARRIOR', script: `PERSONA = ${luaValue({ needs: t.needs, gives: t.gives, ...persona })}\n${SIMULATE}` });
		return out;
	} finally {
		pack.dispose();
	}
};

test('a play that loses the Applejack is held at An Apple Treat; the gated step passes; nothing lost plays through', { skip }, () => {
	const lost = playApple(false, { lose: 247824 });
	assert.equal(lost.done, false);
	assert.equal(lost.stuck.title, 'Garrison');
	assert.equal(lost.stuck.t, 'turnin');
	assert.equal(playApple(true, { lose: 247824 }).done, true);
	assert.equal(playApple(false, {}).done, true);
	// Skipping the step that gets it is the same.
	assert.equal(playApple(false, { skip: 1 }).stuck.title, 'Garrison');
	assert.equal(playApple(true, { skip: 1 }).done, true);
});

// Tiger Mastery (188): the old guide takes it for a later guide and works none of it; the updated one collects
// Sin'Dall's paw (3879) and hands it in. The save the old guide left opens the updated one with the quest in the
// log as the game has it, its paw line included, so the collect can finish.
const tigerGuide = (body) => `guide forever/horde/tiger-test
title Tiger
faction Horde
levels 36-37
zone Stranglethorn Vale

step Nesingwary's camp
  accept 188
${body}`;

test('update: a quest the old guide only took opens the updated guide with every line the game gives it', { skip }, () => {
	realData = realData || loadData(DATA);
	const was = buildSimPack([{ file: 'tiger.guide', text: tigerGuide('\nstep Grom\'gol\n  goto 32.0,28.0\n') }], realData);
	const now = buildSimPack([{ file: 'tiger.guide', text: tigerGuide('\nstep Sin\'Dall\n  collect 3879 quest 188 @31.8,16.4\n\nstep Back at the camp\n  turnin 188\n') }], realData);
	try {
		assert.ok(!was.diag.hasErrors() && !now.diag.hasErrors(), JSON.stringify([...was.diag.errors, ...now.diag.errors]));
		const who = { race: 'Orc', faction: 'Horde', cls: 'WARRIOR' };
		const old = was.guides[0];
		const g = now.guides[0];
		const emitted = playGuide(was, old, { ...who, before: 'stub.world.level = 36\nstub.world.complete({ 187 })', script: `${snapshotLines(realData, [old, g])}\n${SNAPSHOT_LUA}\nPERSONA = ${luaValue({ snapshots: [2] })}\n${SIMULATE}` });
		const snap = emitted.find((e) => e && e.snapshot);
		assert.ok(snap, JSON.stringify(emitted));
		const t = personaTables(g, realData);
		const [out] = playGuide(now, g, { ...who, before: snap.world, saved: snap.save, script: `stub.advance(11)\nPERSONA = ${luaValue({ needs: t.needs, gives: t.gives })}\n${SIMULATE}` });
		assert.equal(out.done, true, JSON.stringify(out.stuck));
		assert.match(snap.world, /w\.onQuest\(188, \{\[1\]=\{[^}]*\["type"\]="item"/);
	} finally {
		was.dispose();
		now.dispose();
	}
});

// Kobold Camp Cleanup (7), a step of its own added after the one that hands in A Threat Within (783), behind a
// player the last release left past it. A tree not yet bumped for its release carries that release's version;
// the update persona still plays a real update (the Engine maps a save only across versions), so the added step
// passes behind them and they reopen where they were (the old Road, now step 4), not on it.
const northshire = (added) => `guide forever/alliance/update-test
title Northshire
faction Alliance
levels 1-3
zone Elwynn Forest

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
${added ? '\nstep Kobold Camp Cleanup\n  accept 7\n' : ''}
step Road
  goto 48.0,40.0

step Hill
  goto 52.0,50.0
`;

test('update: a tree carrying the last release\'s version still updates the save, never sending it back', { skip }, async () => {
	const root = fs.mkdtempSync(path.join(os.tmpdir(), 'persona-update-'));
	try {
		for (const [dir, added] of [['now', true], ['was', false]]) {
			fs.mkdirSync(path.join(root, dir, 'forever/alliance'), { recursive: true });
			fs.writeFileSync(path.join(root, dir, 'forever/alliance/update-test.guide'), northshire(added));
		}
		const manifest = { ...readManifest(OFFICIAL_DIR, { official: true }).manifest, version: '9.9.9' };
		const { results, diag } = await personaPlaytest({ dir: path.join(root, 'now'), manifest, personas: ['update'], from: { dir: path.join(root, 'was'), version: '9.9.9' } });
		assert.ok(!diag.hasErrors(), JSON.stringify(diag.errors));
		const after = results.find((r) => /at its step 3 /.test(r.variant));
		assert.ok(after, JSON.stringify(results));
		assert.match(after.variant, /reopened at step 4$/);
	} finally {
		fs.rmSync(root, { recursive: true, force: true });
	}
});
