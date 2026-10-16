'use strict';
// `questdb build` (tools/lib/questdb, tools/commands/questdb.js): spawn
// clustering, what the database keeps and drops, record layouts, faction
// derivation, caps, determinism, the size budget, and that the generated
// addon/Polestar_QuestDB is a load-on-demand addon that loads under Lua 5.1
// within its memory budget.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const { clusterPoints } = require('../tools/lib/questdb/cluster');
const { buildQuestDB, writeQuestDB, questFaction } = require('../tools/lib/questdb/build');
const { findLua } = require('../tools/lib/lua');
const { ROOT } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');

const FIX = path.join(__dirname, 'fixtures', 'questdb');
const REAL = path.join(ROOT, 'data', 'forever');
const ADDON = path.join(ROOT, 'addon', 'Polestar_QuestDB');
const BUDGET = 3 * 1024 * 1024; // bytes of Lua
const DATA_FILES = ['Quests.lua', 'Npcs.lua', 'Objects.lua', 'Items.lua'];

const tmp = () => tmpdir('polestar-questdb-');
const FRAME = { c: 0, left: 1500, right: -1500, top: 500, bottom: -1500 }; // 30 yd per x %, 20 yd per y %

// Loads data files with a minimal AddData under plain Lua 5.1; returns the
// script's printed JSON-ish output lines.
function luaLoad(dir, tail) {
	const prog = `
Polestar = { QuestDB = {} }
local data = { quests = {}, npcs = {}, objects = {}, items = {} }
local meta
function Polestar.QuestDB.AddData(kind, recs) if kind == "meta" then meta = recs return end local t = data[kind] for k, v in pairs(recs) do t[k] = v end end
collectgarbage("collect"); collectgarbage("collect")
local before = collectgarbage("count")
for _, f in ipairs({ ${DATA_FILES.map((f) => JSON.stringify(path.join(dir, f))).join(', ')} }) do assert(loadfile(f))("Polestar_QuestDB", {}) end
collectgarbage("collect"); collectgarbage("collect")
local kb = collectgarbage("count") - before
${tail}`;
	const file = path.join(tmp(), 'load.lua');
	fs.writeFileSync(file, prog);
	const r = spawnSync(findLua(), [file], { encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	return r.stdout.trim().split('\n');
}

test('spawn points cluster into centroids with a radius in yards, largest first', () => {
	const campA = [[40, 40], [40.5, 40.2], [41, 40], [40.2, 41]];
	const campB = [[60, 60], [60.4, 60.4]];
	const lone = [[90, 10]];
	const clusters = clusterPoints([...campB, ...lone, ...campA], FRAME, { radius: 70 });
	assert.equal(clusters.length, 3);
	assert.deepEqual(clusters.map((c) => c.n), [4, 2, 1]);
	assert.deepEqual([clusters[0].x, clusters[0].y], [40.4, 40.3]);
	// Farthest camp-A point (41, 40) from the emitted centre (40.4, 40.3): 0.6 % x 30 yd, 0.3 % x 20 yd.
	assert.equal(clusters[0].r, Math.ceil(Math.hypot(0.6 * 30, 0.3 * 20)));
	assert.equal(clusters[2].r, 0);
	// Order of input never matters; the cap keeps the largest clusters.
	assert.deepEqual(clusterPoints([...campA].reverse().concat(lone, campB), FRAME), clusters);
	assert.deepEqual(clusterPoints([...campA, ...campB, ...lone], FRAME, { cap: 1 }).map((c) => c.n), [4]);
	// A wide radius merges the camps.
	assert.equal(clusterPoints([...campA, ...campB], FRAME, { radius: 2000 }).length, 1);
});

test('a cluster radius covers every member from the centre as emitted, rounded to 0.1', () => {
	// The centroid 10.07 rounds to 10.1: 10.04 lies 0.06 % (1.8 yd) from it, not the 0.03 % from the centroid.
	assert.deepEqual(clusterPoints([[10.04, 10], [10.1, 10]], FRAME), [{ x: 10.1, y: 10, r: 2, n: 2 }]);
});

test('quest faction comes from the race mask, else from the givers', () => {
	const npcs = { 1: { faction: 'A' }, 2: { faction: 'H' }, 3: { faction: 'AH' } };
	assert.equal(questFaction({ races: 77 }, npcs), 1);
	assert.equal(questFaction({ races: 8 }, npcs), 1);
	assert.equal(questFaction({ races: 178 }, npcs), 2);
	assert.equal(questFaction({ races: 5 | 2 }, npcs), null);
	assert.equal(questFaction({ races: null, start: { npc: [1] } }, npcs), 1);
	assert.equal(questFaction({ races: null, start: { npc: [1, 2] } }, npcs), null);
	assert.equal(questFaction({ races: null, start: { npc: [3] } }, npcs), null);
	assert.equal(questFaction({ races: null, start: { npc: [], object: [5] } }, npcs), null);
});

test('the fixture database keeps quest-related entities only, in the documented layouts', () => {
	const { db, files, stats, warnings } = buildQuestDB({ dataDir: FIX });
	assert.deepEqual(warnings, []);
	assert.equal(stats.quests, 15);
	assert.ok(!db.npcs.has(9999), 'NPC no quest references is dropped');
	assert.ok(!db.items.has(2000), 'item no quest references is dropped');
	assert.ok(db.npcs.has(40) && db.objects.has(77), 'drop sources of objective items are kept');
	assert.deepEqual(Object.keys(db.mapFrames).sort(), ['1411', '1426', '1429'], 'only maps with points get frames');
	assert.deepEqual(db.quests.get(7), ['Kobold Camp Cleanup', 2, 1, null, null, 1, 197, 197, null, 783, null, [1, 6, 10], 1429, null, null, null, null, null, null]);
	assert.deepEqual(db.quests.get(16)[6], -31, 'object givers are negative refs');
	assert.deepEqual(db.quests.get(18)[11], [3, 55, null, 4, 1, null]);
	assert.deepEqual(db.quests.get(18)[13], [1429, 0, 40.5, 70.3]);
	assert.deepEqual(db.quests.get(19)[9], [33, 60]);
	assert.deepEqual(db.quests.get(19)[18], [772, 900], 'the items the quest hands over, once each: sourceItem and requiredItems');
	assert.equal(db.quests.get(12)[15], 10, 'holiday');
	assert.deepEqual(db.items.get(772), ['Large Candle', 2, 6, 40, 40, 20.5, 1, 77, 100, 253]);
	assert.deepEqual(db.npcs.get(197), ['Marshal McBride', 1429, 0, 1, 48.9, 41.6, 0]);
	assert.match(files['Quests.lua'], /^\[7\]=\{"Kobold Camp Cleanup",2,1,nil,nil,1,197,197,nil,783,nil,\{1,6,10\},1429\},$/m);
	assert.match(files['MapFrames.lua'], /Polestar\.RegisterMapFrames\(\{ era = \{/);
	assert.match(files['MapFrames.lua'], /\[1429\] = \{bottom=-1500,c=0,left=1500,right=-1500,top=500\},/);
	assert.match(files['LICENSE-DATA.txt'], /Fixture notice\./);
});

test('caps limit drop sources', () => {
	const { db } = buildQuestDB({ dataDir: FIX, options: { maxDroppers: 1, maxObjectSources: 0, maxVendors: 0 } });
	assert.deepEqual(db.items.get(772), ['Large Candle', 1, 6, 40, 0]);
	assert.ok(!db.npcs.has(40), 'a dropper past the cap is not pulled in');
});

test('every known spawn of an entity lies in one of its clusters: no cap, and the points the data cap left out count', () => {
	const dir = tmp();
	for (const f of fs.readdirSync(FIX)) fs.copyFileSync(path.join(FIX, f), path.join(dir, f));
	const npcs = JSON.parse(fs.readFileSync(path.join(FIX, 'npcs.json'), 'utf8'));
	// Kobold Vermin: its camps, plus ten lone spawns 240 yd apart that the data's cap left out.
	const more = Array.from({ length: 10 }, (_, i) => [10 + i * 8, 90]);
	npcs[6].spawns[1429].more = more;
	fs.writeFileSync(path.join(dir, 'npcs.json'), JSON.stringify(npcs));
	const rec = buildQuestDB({ dataDir: dir }).db.npcs.get(6);
	assert.equal(rec[1], 1429);
	const clusters = [];
	for (let k = 0; k < rec[3]; k++) clusters.push({ x: rec[4 + k * 3], y: rec[5 + k * 3], r: rec[6 + k * 3] });
	assert.ok(clusters.length > 8, `${clusters.length} clusters: past the old cap of 8`);
	// The fixture's Elwynn frame: 30 yd per x percent, 20 yd per y percent.
	const inside = ([x, y]) => clusters.some((c) => Math.hypot((x - c.x) * 30, (y - c.y) * 20) <= c.r);
	assert.deepEqual([...npcs[6].spawns[1429].pts, ...more].filter((p) => !inside(p)), []);
	for (const [x, y] of more) assert.ok(clusters.some((c) => c.x === x && c.y === y), `a marker at the lone spawn ${x},${y}`);
});

test('builds are byte-identical and the TOC is a load-on-demand Polestar addon', () => {
	const a = tmp();
	const b = tmp();
	writeQuestDB(buildQuestDB({ dataDir: FIX }), a);
	writeQuestDB(buildQuestDB({ dataDir: FIX }), b);
	const names = fs.readdirSync(a).sort();
	assert.deepEqual(names, fs.readdirSync(b).sort());
	for (const n of names) assert.equal(fs.readFileSync(path.join(a, n), 'utf8'), fs.readFileSync(path.join(b, n), 'utf8'), n);
	const toc = fs.readFileSync(path.join(a, 'Polestar_QuestDB.toc'), 'utf8');
	assert.match(toc, /^## Interface: 16001$/m);
	assert.match(toc, /^## LoadOnDemand: 1$/m);
	assert.match(toc, /^## Dependencies: Polestar$/m);
	// A stale data file from an older layout is removed on rebuild.
	fs.writeFileSync(path.join(a, 'Old.lua'), '-- stale');
	writeQuestDB(buildQuestDB({ dataDir: FIX }), a);
	assert.ok(!fs.existsSync(path.join(a, 'Old.lua')));
	const [counts] = luaLoad(a, 'local n = 0 for _ in pairs(data.quests) do n = n + 1 end print(n .. " " .. data.quests[7][1] .. " " .. #data.npcs[6])');
	assert.equal(counts, '15 Kobold Camp Cleanup 13');
});

test('the command writes the addon and reports size and memory', () => {
	const out = tmp();
	const r = spawnSync(process.execPath, [path.join(ROOT, 'tools', 'polestar.js'), 'questdb', 'build', '--data', FIX, '--out', out, '--json'], { encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	const stats = JSON.parse(r.stdout);
	assert.equal(stats.quests, 15);
	assert.ok(stats.luaBytes > 0 && stats.memoryBytes > 0);
	assert.ok(fs.existsSync(path.join(out, 'Quests.lua')));
});

test('the real database fits the size budget and builds deterministically', { skip: !fs.existsSync(path.join(REAL, 'quests.json')) && 'data/forever not built' }, () => {
	const one = buildQuestDB({ dataDir: REAL });
	const two = buildQuestDB({ dataDir: REAL });
	assert.deepEqual(one.files, two.files);
	assert.ok(one.stats.luaBytes <= BUDGET, `Lua ${one.stats.luaBytes} bytes over budget`);
	assert.ok(one.stats.quests > 4000);
	console.log(`questdb real: Lua ${(one.stats.luaBytes / 1048576).toFixed(2)} MB, estimated memory ${(one.stats.memoryBytes / 1048576).toFixed(2)} MB`);
});

test('the shipped addon/Polestar_QuestDB loads under Lua 5.1 within budget', { skip: !fs.existsSync(path.join(ADDON, 'Quests.lua')) && 'not generated' }, () => {
	const toc = fs.readFileSync(path.join(ADDON, 'Polestar_QuestDB.toc'), 'utf8');
	assert.match(toc, /^## LoadOnDemand: 1$/m);
	assert.match(toc, /^## Dependencies: Polestar$/m);
	const bytes = DATA_FILES.concat('MapFrames.lua').reduce((s, f) => s + fs.statSync(path.join(ADDON, f)).size, 0);
	assert.ok(bytes <= BUDGET, `Lua ${bytes} bytes over budget`);
	const [line] = luaLoad(ADDON, 'print(string.format("%d %s %.2f", (function() local n = 0 for _ in pairs(data.quests) do n = n + 1 end return n end)(), data.quests[7] and data.quests[7][1] or "-", kb / 1024))');
	const [n, ...rest] = line.split(' ');
	const mb = Number(rest.pop());
	assert.ok(Number(n) > 4000);
	assert.equal(rest.join(' '), 'Kobold Camp Cleanup');
	assert.ok(mb < 8, `resident ${mb} MB`);
	console.log(`questdb shipped: Lua ${(bytes / 1048576).toFixed(2)} MB, resident ${mb} MB under Lua 5.1`);
});
