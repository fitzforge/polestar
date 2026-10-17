'use strict';
// talents build (tools/lib/talents/build.js): a plan's picks by name resolved
// on the class's trait tree and replayed under the client's rules, against a
// small made-up tree; then the committed Builds.lua against the cached
// Forever tables when they are on this machine (data/sources is not in git).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { treeFacts, resolveBuild, replay, buildTalents, buildAllTalents, emitLua, PREREQ_RULE, TABLES, CLASSES } = require('../tools/lib/talents/build');

// Two columns of a made-up Paladin tree: A (3 ranks) -> B (arrow, 1 rank),
// C gated on 3 points in column one; D alone in column two.
function tables() {
	const n = (ID, PosX, PosY) => ({ ID, TraitTreeID: 1100, PosX, PosY });
	return {
		SkillLineXTraitTree: [{ ID: 1, SkillLineID: 184, TraitTreeID: 1100 }],
		TraitNode: [n(1, 1000, 100), n(2, 1600, 100), n(3, 1000, 700), n(4, 9000, 100), { ID: 9, TraitTreeID: 5, PosX: 0, PosY: 0 }],
		TraitNodeXTraitNodeEntry: [1, 2, 3, 4].map((i) => ({ ID: i, TraitNodeID: i, TraitNodeEntryID: 10 + i, _Index: 0 })),
		TraitNodeEntry: [[11, 3], [12, 1], [13, 2], [14, 5]].map(([ID, MaxRanks]) => ({ ID, TraitDefinitionID: ID + 10, MaxRanks })),
		TraitDefinition: [21, 22, 23, 24].map((ID) => ({ ID, SpellID: ID + 100, OverrideName_lang: '' })),
		SpellName: [['121', 'Alpha'], ['122', 'Beta'], ['123', 'Gamma'], ['124', 'Delta']].map(([ID, Name_lang]) => ({ ID, Name_lang })),
		TraitNodeGroupXTraitNode: [
			{ TraitNodeGroupID: 50, TraitNodeID: 1 }, { TraitNodeGroupID: 50, TraitNodeID: 2 }, { TraitNodeGroupID: 50, TraitNodeID: 3 },
			{ TraitNodeGroupID: 60, TraitNodeID: 3 },
		],
		TraitNodeGroupXTraitCond: [{ TraitCondID: 70, TraitNodeGroupID: 60 }],
		TraitCond: [{ ID: 70, CondType: 0, TraitNodeGroupID: 50, SpentAmountRequired: 3 }],
		TraitEdge: [{ LeftTraitNodeID: 1, RightTraitNodeID: 2, Type: 2 }, { LeftTraitNodeID: 2, RightTraitNodeID: 1, Type: 0 }],
	};
}

const SOURCE = { class: 'PALADIN', source: 'X', sourceUrl: 'https://example.invalid', summary: 's', order: ['One', 'Two'] };
const pick = (level, tree, talent, rank, note) => ({ level, tree, talent, rank, ...(note ? { note } : {}) });

test('treeFacts: the class tree only, spec columns by position, rows, gates and arrows', () => {
	const f = treeFacts(tables(), 'PALADIN');
	assert.equal(f.treeID, 1100);
	assert.deepEqual(Object.keys(f.nodes).map(Number), [1, 2, 3, 4]);
	assert.deepEqual(f.specs, [[1, 2, 3], [4]]);
	assert.deepEqual([f.nodes[3].spec, f.nodes[3].row, f.nodes[3].col], [1, 2, 1]);
	assert.deepEqual([f.nodes[2].col, f.nodes[4].spec], [2, 2]);
	assert.equal(f.nodes[2].name, 'Beta');
	assert.deepEqual(f.gates, { 3: [{ group: 50, need: 3 }] });
	assert.deepEqual(f.groups, { 50: [1, 2, 3] });
	assert.deepEqual(f.edges, [{ from: 1, to: 2 }], 'a VisualOnly line (Type 0) is not an arrow');
});

test('resolveBuild: names within their column; an unknown name or tree is an error', () => {
	const f = treeFacts(tables(), 'PALADIN');
	const r = resolveBuild(f, SOURCE, { key: 'k', picks: [pick(10, 'One', 'Alpha', 1, 'why'), pick(11, 'Two', 'Alpha', 1), pick(12, 'Three', 'Delta', 1)] });
	assert.deepEqual(r.picks, [{ level: 10, node: 1, rank: 1 }]);
	assert.deepEqual(r.notes, { 10: 'why' });
	assert.equal(r.errors.length, 2);
	assert.match(r.errors[0], /no Two talent named "Alpha"/);
	assert.match(r.errors[1], /unknown tree "Three"/);
});

test('replay: levels, ranks, tier gates and arrows (full rank, or one rank with "started")', () => {
	const f = treeFacts(tables(), 'PALADIN');
	const p = (level, node, rank) => ({ level, node, rank });
	assert.equal(PREREQ_RULE, 'full', 'full rank until checked in game');
	assert.deepEqual(replay(f, [p(10, 1, 1), p(11, 1, 2), p(12, 1, 3), p(13, 2, 1), p(14, 3, 1)]), []);
	assert.match(replay(f, [p(10, 1, 1), p(11, 2, 1)])[0], /needs Alpha 3\/3/);
	assert.deepEqual(replay(f, [p(10, 1, 1), p(11, 2, 1)], { prereq: 'started' }), []);
	assert.match(replay(f, [p(10, 1, 1), p(11, 3, 1)])[0], /needs 3 points in its tree, has 1/);
	assert.match(replay(f, [p(10, 1, 2)])[0], /rank 2 after 0/);
	assert.match(replay(f, [p(11, 4, 1)])[0], /expected level 10/);
});

test('replay: of several arrows into one talent, any one opens it (the Hunter\'s Intimidation)', () => {
	const t = tables();
	// Gamma (3) gets a second arrow, from Beta (2), beside its tier gate.
	t.TraitEdge.push({ LeftTraitNodeID: 2, RightTraitNodeID: 3, Type: 2 }, { LeftTraitNodeID: 4, RightTraitNodeID: 3, Type: 2 });
	t.TraitNodeGroupXTraitCond = [];
	const f = treeFacts(t, 'PALADIN');
	const p = (level, node, rank) => ({ level, node, rank });
	assert.deepEqual(replay(f, [p(10, 4, 1), p(11, 4, 2), p(12, 4, 3), p(13, 4, 4), p(14, 4, 5), p(15, 3, 1)]), [], 'Delta alone is enough');
	assert.match(replay(f, [p(10, 3, 1)])[0], /needs Beta 1\/1 or Delta 5\/5/);
});

test('treeFacts: a Required arrow (type 3) beside another into one talent is refused, not guessed', () => {
	const t = tables();
	t.TraitEdge.push({ LeftTraitNodeID: 4, RightTraitNodeID: 2, Type: 3 });
	assert.throws(() => treeFacts(t, 'PALADIN'), /Required arrow beside others/);
});

test('buildTalents: the Lua names its rule, the snapshot and each plan, notes by level', () => {
	const src = { ...SOURCE, builds: [{ key: 'one', spec: 'One', split: '3/0', link: 'L', picks: [pick(10, 'One', 'Alpha', 1, 'Say "hi"'), pick(11, 'One', 'Alpha', 2)] }] };
	const r = buildTalents(src, tables(), { header: '-- H' });
	assert.deepEqual(r.errors, []);
	assert.match(r.lua, /^-- H\n/);
	assert.match(r.lua, /prereq = "full"/);
	assert.match(buildTalents(src, tables(), { header: '-- H', prereq: 'started' }).lua, /prereq = "started"/, 'the rule it checked with');
	assert.match(r.lua, /\[1\] = \{ 11, 3, 121, 1, 1, 1, "Alpha" \},/);
	assert.match(r.lua, /\[3\] = \{ \{ 50, 3 \} \},/);
	assert.match(r.lua, /edges = \{ \{ 1, 2 \} \},/);
	assert.match(r.lua, /\{ 1, 1 \}, \{ 1, 2 \},/);
	assert.match(r.lua, /\[10\] = L\["Say \\"hi\\""\],/);
});

test('treeFacts: a stray copy of a talent far off the grid is left out; a talent on the grid is kept', () => {
	const t = tables();
	// Node 5: Delta again (spell 124), at ten times column two's PosX, as the
	// Hunter tree's second Lightning Reflexes. Node 6: Gamma again, on the grid.
	t.TraitNode.push({ ID: 5, TraitTreeID: 1100, PosX: 90000, PosY: 100 }, { ID: 6, TraitTreeID: 1100, PosX: 9000, PosY: 700 });
	t.TraitNodeXTraitNodeEntry.push({ ID: 5, TraitNodeID: 5, TraitNodeEntryID: 14, _Index: 0 }, { ID: 6, TraitNodeID: 6, TraitNodeEntryID: 13, _Index: 0 });
	const f = treeFacts(t, 'PALADIN');
	assert.deepEqual(f.strays, [5]);
	assert.equal(f.nodes[5], undefined);
	assert.deepEqual(f.specs, [[1, 2, 3], [4, 6]], 'no fourth column');
	// Below the grid (PosY ten times the deepest row), as the Priest tree's second Holy Specialization.
	const u = tables();
	u.TraitNode.push({ ID: 5, TraitTreeID: 1100, PosX: 9000, PosY: 7000 });
	u.TraitNodeXTraitNodeEntry.push({ ID: 5, TraitNodeID: 5, TraitNodeEntryID: 11, _Index: 0 });
	const g = treeFacts(u, 'PALADIN');
	assert.deepEqual(g.strays, [5]);
	assert.equal(Math.max(...Object.values(g.nodes).map((n) => n.row)), 2, 'no extra row');
});

test('treeFacts: rows a few units apart are one row', () => {
	const t = tables();
	t.TraitNode[1].PosY = 110; // Beta, 10 below Alpha
	const f = treeFacts(t, 'PALADIN');
	assert.deepEqual([f.nodes[1].row, f.nodes[2].row, f.nodes[3].row], [1, 1, 2]);
});

test('CLASSES: every class has its tree by class skill line', () => {
	assert.deepEqual(Object.keys(CLASSES).sort(), ['DRUID', 'HUNTER', 'MAGE', 'PALADIN', 'PRIEST', 'ROGUE', 'SHAMAN', 'WARLOCK', 'WARRIOR']);
	assert.equal(new Set(Object.values(CLASSES).map((c) => c.skillLine)).size, 9);
});

test('buildAllTalents: one T.Register per class, by class; one class is the single-class file', () => {
	const t = tables();
	t.SkillLineXTraitTree.push({ ID: 2, SkillLineID: CLASSES.WARRIOR.skillLine, TraitTreeID: 1100 });
	const plan = (cls) => ({ ...SOURCE, class: cls, builds: [{ key: 'one', spec: 'One', split: '1/0', link: 'L', picks: [pick(10, 'One', 'Alpha', 1)] }] });
	const r = buildAllTalents([plan('WARRIOR'), plan('PALADIN')], t, { header: '-- H' });
	assert.deepEqual(r.errors, []);
	assert.equal(r.lua.match(/^T\.Register\(\{$/gm).length, 2);
	assert.ok(r.lua.indexOf('class = "PALADIN"') < r.lua.indexOf('class = "WARRIOR"'), 'sorted by class');
	assert.equal(r.lua.match(/^local ADDON, ns = \.\.\.$/gm).length, 1);
	const one = buildAllTalents([plan('PALADIN')], t, { header: '-- H' });
	assert.equal(one.lua, buildTalents(plan('PALADIN'), t, { header: '-- H' }).lua);
	assert.equal(one.lua, emitLua('-- H', one.results[0].facts, one.results[0].source, one.results[0].builds));
});

test('buildAllTalents: two files for one class, or a bad pick, name the class', () => {
	const plan = (talent) => ({ ...SOURCE, builds: [{ key: 'one', spec: 'One', split: '1/0', link: 'L', picks: [pick(10, 'One', talent, 1)] }] });
	assert.match(buildAllTalents([plan('Alpha'), plan('Alpha')], tables()).errors[0], /^PALADIN: more than one plan file/);
	assert.match(buildAllTalents([plan('Nope')], tables()).errors[0], /^PALADIN one pick 1 .*no One talent named "Nope"/);
});

// The committed file matches the plans and the Forever tables (when cached).
const ROOT = path.join(__dirname, '..');
const CACHE = path.join(ROOT, 'data', 'sources', 'wago', '1.60.1.70374');
const cached = TABLES.every((t) => fs.existsSync(path.join(CACHE, `${t}.csv`)));

test('talents check: Builds.lua is up to date and every plan\'s picks are legal', { skip: !cached && 'no cached Forever trait tables' }, async () => {
	const cmd = require('../tools/commands/talents');
	const log = console.log;
	console.log = () => {};
	try {
		assert.equal(await cmd.run(['check', '--offline']), 0);
	} finally {
		console.log = log;
	}
});

test('treeFacts on the Forever tables: three spec columns for every class, Hunter and Priest strays left out', { skip: !cached && 'no cached Forever trait tables' }, async () => {
	const { loadTables } = require('../tools/lib/professions/tables');
	const { tables } = await loadTables({ sourcesDir: path.join(ROOT, 'data', 'sources'), build: '1.60.1.70374', offline: true, tables: TABLES, log: () => {} });
	const strays = {};
	for (const cls of Object.keys(CLASSES)) {
		const f = treeFacts(tables, cls);
		assert.equal(f.specs.length, 3, cls);
		if (f.strays.length) strays[cls] = f.strays;
		const names = f.specs.map((ids) => ids.map((id) => f.nodes[id].name));
		for (const col of names) assert.equal(new Set(col).size, col.length, `${cls}: a talent name twice in one column`);
	}
	assert.deepEqual(strays, { HUNTER: [104982], PRIEST: [105865] });
	// The Druid's Nature's Splendor needs Nature's Majesty; the line back is drawn only.
	const druid = treeFacts(tables, 'DRUID');
	const named = (n) => Number(Object.keys(druid.nodes).find((id) => druid.nodes[id].name === n));
	const pair = druid.edges.filter((e) => [e.from, e.to].includes(named("Nature's Majesty")));
	assert.deepEqual(pair, [{ from: named("Nature's Majesty"), to: named("Nature's Splendor") }]);
});
