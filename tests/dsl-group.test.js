'use strict';
// Group content (docs/GUIDE_FORMAT.md, "Group content"): the compiled `group`
// of a goal (elite work, a dungeon or raid quest, an instance map, the
// author's `group [N]`) and the guide's `group` flag.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { compile, groupData, lineOf, DATA_DIR } = require('./helpers/dsl');
const { loadData } = require('../tools/lib/dsl/data');
const { tmpdir } = require('./helpers/tmp');

function guide(body, extra = []) {
	return `${['guide t/group', 'title Group', 'faction Alliance', 'category Class', 'levels 1-60', 'zone Elwynn Forest', ...extra, '', ...body].join('\n')}\n`;
}

// The compiled guide and the `group` of its first step's goals (null: none).
function groups(src, data = groupData()) {
	const r = compile(src, data);
	assert.deepEqual(r.errors, []);
	return { guide: r.guides[0], goals: r.guides[0].steps[0].goals.map((g) => g.group || null) };
}

test('a kill of a hostile elite is elite group content with its rank; a friendly talk credit and a normal mob are not', () => {
	const { goals } = groups(guide(['step S', '  kill 95003', '  kill 95030', '  kill 6']));
	assert.deepEqual(goals, [{ kind: 'elite', rank: 1 }, null, null]);
});

test('a collect is elite group content only when every dropper is an elite', () => {
	const { goals } = groups(guide(['step S', '  collect 95100 x3', '  collect 95101 x3']));
	assert.deepEqual(goals, [{ kind: 'elite', rank: 1 }, null]);
});

test('every goal of a dungeon quest names the dungeon; a raid quest the raid; a breadcrumb with the area is not one', () => {
	const { goals } = groups(guide(['step S', '  accept 9600', '  kill 95040 quest 9600', '  complete 9600', '  turnin 9600', '  accept 9601', '  turnin 9601', '  accept 9602', '  turnin 9602']));
	const dungeon = { kind: 'dungeon', name: 'Hollow Deeps' };
	const raid = { kind: 'raid', name: 'Molten Core' };
	assert.deepEqual(goals, [dungeon, dungeon, dungeon, dungeon, raid, raid, null, null]);
});

test('a goal placed on an instance map is in that instance', () => {
	const { goals } = groups(guide(['step S', '  goto 50,50 map 9900 "Hollow gate"', '  goto 50,50 "Outside"']));
	assert.deepEqual(goals, [{ kind: 'dungeon', name: 'Hollow Deeps' }, null]);
});

test('`group [N]` is the author\'s word: it wins over what the data says, with or without a size', () => {
	const { goals } = groups(guide(['step S', '  kill 95003 group 3', '  accept 9600 group 5', '  talk 197 group', '  kill 6 optional group 2']));
	assert.deepEqual(goals, [{ kind: 'group', size: 3 }, { kind: 'group', size: 5 }, { kind: 'group' }, { kind: 'group', size: 2 }]);
});

test('a malformed group size is an error on its line', () => {
	// Each step keeps a valid goal, so the bad line is the only error.
	const step = (line) => guide(['step S', '  kill 6', line]);
	for (const size of ['0', '1', '41', '2.5', '-3']) {
		const src = step(`  kill 6 group ${size}`);
		assert.deepEqual(compile(src, groupData()).errors, [`test.guide:${lineOf(src, `  kill 6 group ${size}`)}: malformed group size "${size}" (2 to 40 players)`]);
	}
	const twice = step('  kill 95003 group group');
	assert.deepEqual(compile(twice, groupData()).errors, [`test.guide:${lineOf(twice, '  kill 95003 group group')}: duplicate \`group [N]\``]);
	const note = step('  note "Wait here" group 3');
	assert.deepEqual(compile(note, groupData()).errors, [`test.guide:${lineOf(note, '  note "Wait here" group 3')}: \`group [N]\` does not apply to \`note\``]);
});

test('the guide is flagged `group` when a goal of its route needs a group, not for an optional extra', () => {
	assert.equal(groups(guide(['step S', '  kill 6', '  kill 95003'])).guide.group, true);
	assert.equal(groups(guide(['step S', '  kill 6', '  kill 95003 optional'])).guide.group, undefined);
	assert.equal(groups(guide(['step S', '  kill 6'])).guide.group, undefined);
});

test('the compiled group reaches the pack: goal and guide keys in Guides.lua', () => {
	const { emitGuides } = require('../tools/lib/dsl/emit');
	const r = compile(guide(['step S', '  accept 9600', '  kill 95003 group 3']), groupData());
	const lua = emitGuides(r.guides.map((g) => ({ guide: g, source: 'test.guide' })));
	assert.match(lua, /\t\t\tgroup = true,\n\t\t\tsteps = \{/);
	assert.match(lua, /t = "accept", quest = 9600, [^\n]*group = \{ kind = "dungeon", name = "Hollow Deeps" \} \},/);
	assert.match(lua, /t = "kill", [^\n]*group = \{ kind = "group", size = 3 \} \},/);
});

test('loadData reads the instances (name, kind, map id) from the client tables in the sources folder beside the data folder', () => {
	const root = tmpdir();
	const dataDir = path.join(root, 'forever');
	fs.cpSync(DATA_DIR, dataDir, { recursive: true });
	assert.equal(loadData(dataDir).instances, null, 'no cached client tables: no instances');
	const build = path.join(root, 'sources', 'wago', '1.60.1.1');
	fs.mkdirSync(build, { recursive: true });
	fs.writeFileSync(path.join(build, 'Map.csv'), 'ID,MapName_lang,InstanceType,AreaTableID\n0,Eastern Kingdoms,0,0\n429,"Dire Maul",1,2557\n409,"Molten Core",2,2717\n');
	fs.writeFileSync(path.join(build, 'AreaTable.csv'), 'ID,AreaName_lang,ContinentID,ParentAreaID\n2557,"Dire Maul",429,0\n2717,"Molten Core",409,0\n3000,"Gordok Commons",429,2557\n');
	fs.writeFileSync(path.join(build, 'UiMapAssignment.csv'), 'UiMapID,MapID\n235,429\n236,429\n1429,0\n');
	assert.deepEqual(loadData(dataDir).instances, {
		build: '1.60.1.1',
		areas: { 2557: { kind: 'dungeon', name: 'Dire Maul', map: 429 }, 2717: { kind: 'raid', name: 'Molten Core', map: 409 }, 3000: { kind: 'dungeon', name: 'Dire Maul', map: 429 } },
		maps: { 235: { kind: 'dungeon', name: 'Dire Maul', map: 429 }, 236: { kind: 'dungeon', name: 'Dire Maul', map: 429 } },
	});
});
