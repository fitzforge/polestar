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
const UNDEAD = { race: 'Scourge', faction: 'Horde', cls: 'WARRIOR' };
const DWARF = { race: 'Dwarf', faction: 'Alliance', cls: 'WARRIOR' };
const NIGHTELF = { race: 'NightElf', faction: 'Alliance', cls: 'WARRIOR' };
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
	// An Undead: an Orc knows Orgrimmar's flight path from the first login.
	const bad = play('step Orgrimmar\n  zone Orgrimmar\n  goto 45.3,63.8\n\nstep Fly\n  fly "Crossroads"\n', { persona: UNDEAD });
	assert.ok(of(bad, 'R1').some((f) => /fly to Crossroads: its flight path was never learnt/.test(f.reason)));
	assert.ok(of(bad, 'R1').some((f) => /fly from Orgrimmar: its flight path was never learnt/.test(f.reason)));
	const learnt = 'step Crossroads\n  zone The Barrens\n  goto 51.5,30.4\n  getfp "Crossroads"\n\nstep Orgrimmar\n  zone Orgrimmar\n  goto 45.3,63.8 "Walk north to Orgrimmar"\n  getfp "Orgrimmar"\n\n';
	assert.deepEqual(of(play(`${learnt}step Fly\n  fly "Crossroads"\n`), 'R1'), []);
	const away = play(`${learnt}step Valley\n  zone Durotar\n  goto 44.5,70.6 "Ride south to the Valley of Trials"\n\nstep Fly\n  fly "Crossroads"\n`);
	assert.match(of(away, 'R1')[0].reason, /no flight master where the guide leaves the player .*nearest learnt one is Orgrimmar/);
});

// Each race knows its capital's flight path from the first login (Night Elves Auberdine too), so the Dwarf start
// route's flight from Thelsamar to Ironforge and the Night Elf one's from Rut'theran Village to Auberdine need no
// `getfp` before them. Another race still does.
test('R1: a character knows its race\'s starting flight paths (Thelsamar to Ironforge, Rut\'theran Village to Auberdine)', { skip }, () => {
	const thelsamar = 'step Thelsamar\n  zone Loch Modan\n  goto 33.9,50.8\n  getfp "Thelsamar"\n\nstep Fly\n  fly "Ironforge"\n';
	assert.deepEqual(of(play(thelsamar, { persona: DWARF }), 'R1'), []);
	assert.match(of(play(thelsamar, { persona: HUMAN }), 'R1')[0].reason, /fly to Ironforge: its flight path was never learnt/);
	const ruttheran = 'step Rut\'theran Village\n  zone Teldrassil\n  goto 58.4,93.9\n\nstep Fly\n  fly "Auberdine"\n';
	assert.deepEqual(of(play(ruttheran, { persona: NIGHTELF }), 'R1'), []);
	assert.equal(of(play(ruttheran, { persona: HUMAN }), 'R1').length, 2, 'neither end is a Human\'s');
});

// A guide pack's zone at 38 is a chain of its own: the character has what every start route of its race learnt in
// the guides below 38 (Menethil Harbor on the way north), not an empty flight map.
test('R1: a chain opening above level 1 starts with the flight paths every start route of its race learns below it', { skip }, () => {
	const { compileSources } = require('../tools/lib/dsl/project');
	const { honestPlay } = require('../tools/lib/playtest-honest');
	data = data || require('../tools/lib/dsl/data').loadData(require('../tools/lib/paths').DATA);
	const head = (id, levels, next) => `guide test/${id}\ntitle ${id}\nfaction Alliance\n${id.startsWith('start') ? 'race Human\n' : ''}levels ${levels}\nzone Elwynn Forest\n${next ? `next test/${next}\n` : ''}\n`;
	const menethil = 'step Menethil Harbor\n  zone Wetlands\n  goto 9.5,59.7 "Take the road north"\n  getfp "Menethil Harbor"\n';
	const wait = 'step Northshire\n  goto 48,42\n';
	const pack = head('pack', '38-45') + 'step Menethil Harbor\n  zone Wetlands\n  goto 9.5,59.7\n\nstep Fly\n  fly "Stormwind"\n';
	const run = (...texts) => {
		const { guides } = compileSources(texts.map((text, i) => ({ file: `g${i}.guide`, source: `g${i}.guide`, text })), data);
		return of(honestPlay(guides, data, () => [HUMAN], { play: ['test/pack'] }), 'R1').map((f) => f.reason);
	};
	const unknown = [/fly from Menethil Harbor: its flight path was never learnt/];
	const matches = (reasons, res) => assert.deepEqual(reasons.map((r) => res.some((re) => re.test(r))), res.map(() => true), reasons.join('; '));
	matches(run(pack), unknown);
	assert.deepEqual(run(head('start-a', '1-10', 'mid') + wait, head('mid', '10-30') + menethil, pack), [], 'learnt below 38 on the only start route');
	matches(run(head('start-a', '1-10', 'mid') + wait, head('mid', '10-30') + menethil, head('start-b', '1-12') + wait, pack), unknown);
	matches(run(head('start-a', '1-10', 'late') + wait, head('late', '38-45') + menethil, pack), unknown);
});

test('R3: a collect needs a source in the data (An Apple Treat\'s applejack)', { skip }, () => {
	const bad = play('step An Apple Treat\n  accept 91738\n  collect 247824 quest 91738.1\n', { persona: HUMAN });
	assert.match(of(bad, 'R3')[0].reason, /Thunder Applejack: the data has no mob, object or vendor/);
	assert.deepEqual(of(play('step Bread\n  buy 4540 x5 nearest\n', { persona: HUMAN }), 'R3'), [], 'a buy is a source');
});

test('R3: a loop step\'s collect finds its source near any of its spots, not only the first (Gordo\'s Report)', { skip }, () => {
	// Gordo walks the road from Brill to the west; Patience asks for his report. The loop's first spot is
	// 488 yards from his spawn, its last stands on it.
	const head = 'step Executor Zygand\n  zone Tirisfal Glades\n  accept 99141\n\nstep Gordo\n  zone Tirisfal Glades\n';
	play(head, { persona: UNDEAD });
	// Gordo hands his report over when asked (data/rules.json H31c); a data build may not list him as its
	// source, so the test gives him as one for its own run.
	const drops = data.items[286202].drops;
	const had = drops.npc[10666];
	drops.npc[10666] = had === undefined ? 100 : had;
	try {
		const looped = play(head + '  loop\n  goto 53.8,53.1\n  goto 49.7,58.0\n  goto 43.1,54.7\n  collect 286202 quest 99141.3\n', { persona: UNDEAD });
		assert.deepEqual(of(looped, 'R3').map((f) => f.reason), [], 'Gordo stands at the last spot of the loop');
		const single = play(head + '  collect 286202 quest 99141.3 @53.8,53.1\n', { persona: UNDEAD });
		assert.match(of(single, 'R3')[0].reason, /Gordo's Report at Tirisfal Glades 53.8,53.1: nothing there drops it/, 'one place far from him is still a finding');
	} finally {
		if (had === undefined) delete drops.npc[10666];
	}
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

// A `talk ... quest Q.O` line credits the objective it names (Kodo Roundup's tamed kodos are talked to; the data
// counts them as a kill objective).
test('R5: a talk tied to an objective credits it (Kodo Roundup)', { skip }, () => {
	const head = 'step Smeed Scrabblescrew\n  zone Desolace\n  accept 5561\n\n';
	const turnin = 'step Smeed Scrabblescrew\n  zone Desolace\n  turnin 5561\n';
	assert.match(of(play(head + turnin, { persona: HUMAN }), 'R5')[0].reason, /objective 1 \(kill Aged Kodo x5\) has 0\/5/);
	assert.deepEqual(of(play(`${head}step Kodos\n  zone Desolace\n  talk 4700 quest 5561.1 @60.6,61.6\n\n${turnin}`, { persona: HUMAN }), 'R5'), []);
});

test('R5: a `talk <npc> quest Q.O` line credits that objective (Lost in Battle: the Beaten Corpse)', { skip }, () => {
	const bad = play('step Mankrik\n  zone The Barrens\n  accept 4921\n  turnin 4921\n');
	assert.match(of(bad, 'R5')[0].reason, /objective 1 \(talk Beaten Corpse x1\) has 0\/1/);
	const good = play('step Mankrik\n  zone The Barrens\n  accept 4921\n\nstep The Beaten Corpse\n  zone The Barrens\n  talk 10668 quest 4921.1 @49.3,50.3\n\nstep Mankrik\n  zone The Barrens\n  turnin 4921\n');
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

test('`when dungeon` holds only for a dungeon the honest player chose; `when !dungeon` for the solo route', () => {
	const { whenHolds } = require('../tools/lib/playtest-honest');
	const { dungeonPicker } = require('../tools/lib/playtest');
	const run = [{ k: 'dungeon', name: 'The Deadmines', map: 36 }];
	const solo = [{ k: 'dungeon', name: 'The Deadmines', map: 36, neg: true }];
	for (const chosen of [null, dungeonPicker(null), dungeonPicker(['Wailing Caverns'])]) {
		assert.equal(whenHolds({ chosen }, run), false);
		assert.equal(whenHolds({ chosen }, solo), true);
	}
	assert.equal(whenHolds({ chosen: dungeonPicker(['Deadmines']) }, run), true);
	assert.equal(whenHolds({ chosen: dungeonPicker('all') }, solo), false);
});

// A `when` line with a single-quest predicate (`complete`, `turnedin`, `available`, `group`: dsl/when.js QUEST_ONE)
// compiles with one quest id, not a list; the honest play read every predicate as a list and crashed
// (`qs.every is not a function`).
test('a step behind `when complete <quest>` or `when turnedin <quest>` plays, holding or not', { skip }, () => {
	const text = 'step Gornek\n  accept 789\n\nstep Back\n  when complete 789\n  turnin 789\n\nstep Later\n  when turnedin 789\n  accept 790\n';
	assert.doesNotThrow(() => play(text));
	assert.doesNotThrow(() => play('step Alone\n  when !turnedin 789\n  accept 789\n'));
});

// It's a Secret to Everybody (3845): the quest hands over A Small Pack (11107), and the compass, map and key come out
// of it (items.json `containers`). Each collect opens the held pack; none needs a mob, object or vendor.
test('R3: an item in a held container comes out of it (A Small Pack\'s compass, map and key)', { skip }, () => {
	const text = 'step A Wrecked Raft\n  zone Un\'Goro Crater\n  accept 3844 object 161505\n  turnin 3844 object 161504\n  accept 3845 object 161504\n  collect 11104 quest 3845.1\n  collect 11105 quest 3845.2\n  collect 11106 quest 3845.3\n';
	assert.deepEqual(of(play(text, { persona: HUMAN }), 'R3').map((f) => f.reason), []);
	const before = 'step The pack\n  zone Un\'Goro Crater\n  collect 11104\n';
	assert.match(of(play(before, { persona: HUMAN }), 'R3')[0].reason, /Large Compass: the data has no mob, object or vendor/, 'without the pack it is still a finding');
});
