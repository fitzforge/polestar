'use strict';
// `talk <npc> quest Q[.O]` (#859): a talk that is a quest objective, revealed
// one line at a time by the client. The JS compiler side of what forge-guide
// tests in rust/crates/forge-guide/tests/guide (dsl_parse.rs, dsl_validate.rs,
// dsl_along.rs); tests/parity.sh keeps the two compilers' output equal.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { fixtureData, guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Data } = require('../tools/lib/dsl/data');

// The fixture data plus 9710, whose lines are talks (Marshal McBride, Deputy
// Willem, Innkeeper Farley), and 9711, whose talk to Brother Danil is a
// legacy `kill` credit.
function talkData() {
	const base = fixtureData();
	const talk = (id, text) => ({ type: 'talk', id, count: 1, text });
	const quest = (id, title, objectives) => ({ ...base.quests[7], id, title, pre: [], objectives });
	const quests = {
		...base.quests,
		9710: quest(9710, 'Desperate Times', [talk(197, 'Marshal McBride'), talk(823, 'Deputy Willem'), talk(295, 'Innkeeper Farley')]),
		9711: quest(9711, 'A Word', [{ type: 'kill', id: 152, count: 1, text: 'Brother Danil' }]),
	};
	return new Data({ quests, npcs: base.npcs, objects: base.objects, items: base.items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

const OBJECTIVE_WARNINGS = /objective\(s\) in data|, not this npc|no objective for this/;
const goalsOf = (r) => plain(r.guides[0].steps).flatMap((s) => s.goals).filter((g) => g.t === 'talk' || g.t === 'kill');

test('talk takes `quest Q` or `quest Q.O` like kill, with its name and gossip', () => {
	const diag = new Diagnostics();
	const ast = parseGuide(guideText(['step S', '  talk 823 quest 7.2', '  talk 197 "Marshal McBride" quest 7 gossip 1', '  talk 295']), 'x.guide', diag);
	assert.deepEqual(diag.sorted(), []);
	const g = ast.steps.flatMap((s) => s.goals);
	assert.deepEqual([g[0].verb, g[0].npc, g[0].quest, g[0].oi], ['talk', 823, 7, 2]);
	assert.deepEqual([g[1].npc, g[1].npcName, g[1].quest, g[1].oi], [197, 'Marshal McBride', 7, undefined]);
	assert.equal(g[2].quest, undefined);
});

test('a talk with quest compiles to a quest objective goal; `quest Q` takes the index from the talk or legacy kill objective', () => {
	const src = guideText(['step S', '  accept 9710', '  accept 9711', '  talk 823 quest 9710.2', '  talk 295 quest 9710', '  talk 152 quest 9711.1', '  talk 152 quest 9711', '  turnin 9710', '  turnin 9711']);
	const r = compile(src, talkData());
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(r.warnings.filter((w) => OBJECTIVE_WARNINGS.test(w)), [], r.text);
	assert.deepEqual(
		goalsOf(r).map((g) => [g.t, g.npc, g.npcName, g.quest, g.title, g.oi, g.count]),
		[
			['talk', 823, 'Deputy Willem', 9710, 'Desperate Times', 2, undefined],
			['talk', 295, 'Innkeeper Farley', 9710, 'Desperate Times', 3, undefined],
			['talk', 152, 'Brother Danil', 9711, 'A Word', 1, undefined],
			['talk', 152, 'Brother Danil', 9711, 'A Word', 1, undefined],
		],
	);
});

test("a talk with quest naming another npc's line is an error that says which index is the npc's", () => {
	const src = guideText(['step S', '  accept 9710', '  talk 823 quest 9710.1', '  talk 197 quest 9710.1', '  talk 5479 quest 9710', '  turnin 9710']);
	const r = compile(src, talkData());
	const d = r.diag.sorted().filter((x) => x.severity === 'error' && /9710\.1 is/.test(x.message));
	assert.equal(d.length, 1, r.text);
	assert.equal(d[0].line, lineOf(src, 'talk 823 quest 9710.1'));
	assert.equal(d[0].message, 'quest 9710.1 is talk Marshal McBride x1, not this npc; Deputy Willem is 9710.2');
	assert.equal(d[0].hint, 'write `quest 9710.2`, or `quest 9710` to take the index from the npc');
	assert.deepEqual(
		r.warnings.filter((w) => w.includes('no objective for this npc')),
		[`test.guide:${lineOf(src, 'talk 5479 quest 9710')}: quest 9710 has no objective for this npc; write \`quest 9710.<objective>\``],
	);
});

test('a kill with quest on a talk objective of the same npc compiles and takes its index', () => {
	const src = guideText(['step S', '  accept 9710', '  kill 823 quest 9710', '  kill 197 quest 9710.1', '  turnin 9710']);
	const r = compile(src, talkData());
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(r.warnings.filter((w) => OBJECTIVE_WARNINGS.test(w)), [], r.text);
	assert.deepEqual(
		goalsOf(r).map((g) => [g.t, g.npc, g.quest, g.oi]),
		[
			['kill', 823, 9710, 2],
			['kill', 197, 9710, 1],
		],
	);
});

test('a talk with quest counts in an along step; a bare talk still warns', () => {
	const src = guideText(['step McBride', '  accept 7', 'step On the way', '  along', '  talk 6 quest 7.1', '  talk 197', 'step Back', '  turnin 7']);
	const r = compile(src);
	assert.deepEqual(r.errors, [], r.text);
	const warned = r.warnings.filter((w) => w.includes('in an `along` step never checks off'));
	assert.equal(warned.length, 1, r.text);
	assert.ok(warned[0].startsWith(`test.guide:${lineOf(src, 'talk 197')}: \`talk\` in an \`along\` step`), warned[0]);
});
