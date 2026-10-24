'use strict';
// playtest --honest (tools/lib/playtest-honest.js): tiny guides, each played
// from its lines and the reference data only, once with the line a player
// could not follow (a finding of the rule) and once fixed (none). The cases
// are the v2 audit's (docs/superpowers/research/2026-10-21-v2-playable-audit.md)
// where they fit.
//
// Needs data/forever; skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { needs } = require('./helpers/data');

const skip = needs('quests.json', 'npcs.json', 'items.json', 'objects.json', 'travel.json');

let data = null;
function play(text, { persona = ORC, kb = null } = {}) {
	const { compileSources } = require('../tools/lib/dsl/project');
	const { loadData } = require('../tools/lib/dsl/data');
	const { DATA } = require('../tools/lib/paths');
	const { playChain } = require('../tools/lib/playtest-honest');
	data = data || loadData(DATA);
	const head = `guide test/honest\ntitle Honest\nlevels 1-60\nzone ${persona.faction === 'Horde' ? 'Durotar' : 'Elwynn Forest'}\n\n`;
	const { guides } = compileSources([{ file: 'honest.guide', source: 'honest.guide', text: head + text }], data);
	return playChain(guides, data, persona, { kb });
}
const ORC = { race: 'Orc', faction: 'Horde', cls: 'WARRIOR' };
const HUMAN = { race: 'Human', faction: 'Alliance', cls: 'WARRIOR' };
const of = (findings, rule, severity = 'fail') => findings.filter((f) => f.rule === rule && f.severity === severity);

test('R2: a quest started by an item needs the item from an earlier line (The Admiral\'s Orders before the chest)', { skip }, () => {
	const bad = play('step Aged Envelope\n  accept 830 item 4881\n');
	assert.match(of(bad, 'R2')[0].reason, /starts from Aged Envelope/);
	assert.match(of(bad, 'R2')[0].repair, /Benedict's Chest/);
	assert.equal(of(bad, 'R2')[0].line, 7);
	const good = play('step Benedict\'s Chest\n  collect 4881\n  accept 830 item 4881\n');
	assert.deepEqual(of(good, 'R2'), []);
});

test('R2: the giver stands at the step\'s place', { skip }, () => {
	assert.match(of(play('step Gornek\n  accept 788 @60,60\n'), 'R2')[0].reason, /Gornek does not stand at the step's place/);
	assert.deepEqual(of(play('step Gornek\n  accept 788\n'), 'R2'), []);
});

test('R1: another continent needs a travel line before it (Darkshore to Redridge)', { skip }, () => {
	const bad = play('step Boars\n  kill 3098 @44.5,70.6\n\nstep Wolves\n  zone Elwynn Forest\n  kill 69 @40,70\n');
	assert.match(of(bad, 'R1')[0].reason, /continent change with no travel line: Durotar to Elwynn Forest/);
	const good = play('step Boars\n  kill 3098 @44.5,70.6\n\nstep Home\n  hearth "Goldshire"\n\nstep Wolves\n  zone Elwynn Forest\n  kill 69 @40,70\n');
	assert.deepEqual(of(good, 'R1'), []);
	const boat = play('step Boars\n  kill 3098 @44.5,70.6\n\nstep Zeppelin\n  goto 50.8,13.8 "Zeppelin to Grom\'gol"\n\nstep Raptors\n  zone Stranglethorn Vale\n  goto 32,28\n');
	assert.deepEqual(of(boat, 'R1'), [], 'a goto labelled with the transport crosses');
	assert.deepEqual({ from: of(bad, 'R1')[0].from.map, to: of(bad, 'R1')[0].to.map, inStep: of(bad, 'R1')[0].inStep }, { from: 1411, to: 1429, inStep: false }, 'a move finding names both places, at a step boundary');
	assert.equal(of(play('step Both\n  kill 3098 @44.5,70.6\n  zone Elwynn Forest\n  kill 69 @40,70\n'), 'R1')[0].inStep, true, 'a jump inside one step');
});

test('R1: another zone far away needs a travel line (Razor Hill to the Barrens)', { skip }, () => {
	const bad = play('step Boars\n  kill 3098 @44.5,70.6\n\nstep Zhevra\n  zone The Barrens\n  kill 3242 @55,40\n');
	assert.match(of(bad, 'R1')[0].reason, /zone change with no travel line: Durotar to The Barrens/);
	const good = play('step Boars\n  kill 3098 @44.5,70.6\n\nstep Zhevra\n  zone The Barrens\n  goto 55,40 "Follow the road west into the Barrens"\n  kill 3242 @55,40\n');
	assert.deepEqual(of(good, 'R1'), []);
	const along = play('step Boars\n  kill 3098 @44.5,70.6\n\nstep Zhevra (on the way)\n  along\n  zone The Barrens\n  kill 3242 @55,40\n\nstep Scorpids\n  zone Durotar\n  kill 3124 @41.5,67.8\n');
	assert.deepEqual(of(along, 'R1'), [], 'an along step\'s goals do not move the player');
});

test('R1: fly needs both flight paths learnt, from the flight master the guide leaves the player at', { skip }, () => {
	const bad = play('step Orgrimmar\n  zone Orgrimmar\n  goto 45.3,63.8\n\nstep Fly\n  fly "Crossroads"\n');
	assert.ok(of(bad, 'R1').some((f) => /fly to Crossroads: its flight path was never learnt/.test(f.reason)));
	assert.ok(of(bad, 'R1').some((f) => /fly from Orgrimmar: its flight path was never learnt/.test(f.reason)));
	const learnt = 'step Crossroads\n  zone The Barrens\n  goto 51.5,30.4\n  getfp "Crossroads"\n\nstep Orgrimmar\n  zone Orgrimmar\n  goto 45.3,63.8 "Walk north to Orgrimmar"\n  getfp "Orgrimmar"\n\n';
	assert.deepEqual(of(play(`${learnt}step Fly\n  fly "Crossroads"\n`), 'R1'), []);
	const away = play(`${learnt}step Valley\n  zone Durotar\n  goto 44.5,70.6 "Ride south to the Valley of Trials"\n\nstep Fly\n  fly "Crossroads"\n`);
	assert.match(of(away, 'R1')[0].reason, /no flight master where the guide leaves the player .*nearest learnt one is Orgrimmar/);
});

test('R3: a collect needs a source in the data (An Apple Treat\'s applejack)', { skip }, () => {
	const bad = play('step An Apple Treat\n  accept 91738\n  collect 247824 quest 91738.1\n', { persona: HUMAN });
	assert.match(of(bad, 'R3')[0].reason, /Thunder Applejack: the data has no mob, object or vendor/);
	assert.deepEqual(of(play('step Bread\n  buy 4540 x5 nearest\n', { persona: HUMAN }), 'R3'), [], 'a buy is a source');
});

test('R3: a quest item drops only while its quest is held', { skip }, () => {
	const bad = play('step Tails\n  collect 4862 x10\n\nstep Gornek\n  accept 789\n');
	assert.match(of(bad, 'R3')[0].reason, /drops only while Sting of the Scorpid is held/);
	const good = play('step Gornek\n  accept 789\n\nstep Tails\n  collect 4862 x10 quest 789.1\n');
	assert.deepEqual(of(good, 'R3'), []);
});

test('R4: a title that is its quest\'s title or its kill target is no other NPC (Sarkoth, Goldtooth)', { skip }, () => {
	assert.deepEqual(of(play('step Hana\'zua\n  accept 790\n\nstep Sarkoth\n  kill 3281 quest 790.1\n  turnin 790\n'), 'R4'), [], 'the quest is titled Sarkoth');
	assert.deepEqual(of(play('step Goldtooth\n  accept 47\n  kill 327 x1\n', { persona: HUMAN }), 'R4'), [], 'Goldtooth is the step\'s kill target');
	assert.match(of(play('step Goldtooth\n  accept 47\n', { persona: HUMAN }), 'R4')[0].reason, /step titled "Goldtooth"/, 'with no goal at him, the title names another NPC');
});

test('R4: a step titled with an NPC has its goal at that NPC (Veteran Uzzek at "Torm Ragetotem")', { skip }, () => {
	const bad = play('step Torm Ragetotem\n  accept 1505 npc 3169\n');
	assert.match(of(bad, 'R4')[0].reason, /step titled "Torm Ragetotem" but its quest goals are at Tarshaw Jaggedscar/);
	assert.deepEqual(of(play('step Tarshaw Jaggedscar\n  accept 1505 npc 3169\n'), 'R4'), []);
});

test('R4: the NPC of an accept gives the quest', { skip }, () => {
	assert.match(of(play('step Zureetha Fargaze\n  accept 788 npc 3145\n'), 'R4')[0].reason, /Zureetha Fargaze, who does not give it/);
	assert.deepEqual(of(play('step Gornek\n  accept 788 npc 3143\n'), 'R4'), []);
});

test('R5: a turn-in needs every objective credited by an earlier line', { skip }, () => {
	const bad = play('step Gornek\n  accept 788\n  turnin 788\n');
	assert.match(of(bad, 'R5')[0].reason, /objective 1 \(kill Mottled Boar x10\) has 0\/10/);
	const good = play('step Gornek\n  accept 788\n\nstep Boars\n  kill 3098 x10 quest 788.1\n\nstep Gornek\n  turnin 788\n');
	assert.deepEqual(of(good, 'R5'), []);
});

test('R5: a turn-in needs a line for each of the knowledge base\'s required steps', { skip }, () => {
	const kb = new Map([[5441, [{ n: 1, action: 'use-item', kind: 'npc', target: 10556, item: 16114, fact: 'Use the blackjack on a sleeping peon.' }]]]);
	const bad = play('step Foreman Thazz\'ril\n  accept 5441\n\nstep Lazy Peons\n  kill 10556 x5 quest 5441.1\n\nstep Foreman Thazz\'ril\n  turnin 5441\n', { kb });
	assert.match(of(bad, 'R5')[0].reason, /required step 1 \(use-item Foreman's Blackjack\) has no line/);
	const good = play('step Foreman Thazz\'ril\n  accept 5441\n\nstep Lazy Peons\n  use 16114 quest 5441.1\n\nstep Foreman Thazz\'ril\n  turnin 5441\n', { kb });
	assert.deepEqual(of(good, 'R5'), []);
});

test('chains follow the main route; a catch-up guide behind `when` is its own chain', () => {
	const { chains } = require('../tools/lib/playtest-honest');
	const g = (id, next, nextChoices, nextWhen) => ({ id, next, nextChoices, nextWhen, steps: [] });
	const out = chains([g('a-catchup', 'b'), g('a', 'a-catchup', ['a-catchup', 'b'], { 'a-catchup': [{ k: 'level', op: '<', n: 9 }] }), g('b', null)]);
	assert.deepEqual(out.map((c) => c.map((x) => x.id)), [['a', 'b'], ['a-catchup']]);
});
