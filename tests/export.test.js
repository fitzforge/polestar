'use strict';
// The import string writer (tools/lib/pack/importstring.js) and
// `polestar export <file.guide>`: the guide data it carries is exactly what
// Guides.lua registers, the string reads back, and export lints first and
// refuses what a string cannot carry. The addon's reader: import.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { compile, fixtureData, DATA_DIR } = require('./helpers/dsl');
const { polestar } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const { luaToJson } = require('../tools/lib/lua');
const { emitGuides, guideData } = require('../tools/lib/dsl/emit');
const { importString, encodeImport, decodeImport, LIMITS, PREFIX } = require('../tools/lib/pack/importstring');

const GUIDE = (id, extra = '') => `guide ${id}
title Northshire Valley
faction Alliance
levels 1-6
zone Elwynn Forest
${extra}
step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
  accept 7

step Kobold camp
  goto 47.6,35.1 "Kobold camp"
  kill 6 x10 quest 7.1

step Back to the abbey
  turnin 7
`;

// [] and {} are one empty Lua table; luaToJson writes it as {}.
function norm(v) {
	if (Array.isArray(v)) return v.length ? v.map(norm) : {};
	if (v && typeof v === 'object') {
		const keys = Object.keys(v);
		if (!keys.length) return {};
		return Object.fromEntries(keys.sort().map((k) => [k, norm(v[k])]));
	}
	return v;
}

test('guideData is what Guides.lua registers, number rounding included, without the pack', () => {
	const c = compile({ 'a.guide': GUIDE('yendi/northshire') }, fixtureData(), { pack: 'yendi', author: 'Yendi' });
	assert.deepEqual(c.errors, []);
	const g = c.guides[0]._localised || c.guides[0];
	const lua = emitGuides([{ guide: g }]);
	const registered = luaToJson({ prelude: `G = {} Polestar = { RegisterGuide = function(g) G[#G + 1] = g end }\n${lua}`, expr: 'return G[1]' });
	const { pack, ...rest } = registered;
	assert.equal(pack, 'yendi');
	assert.deepEqual(norm(JSON.parse(JSON.stringify(guideData(g)))), norm(rest));
});

test('a string reads back to its payload; a damaged one does not', () => {
	const payload = { format: 3, license: 'MIT', guide: { id: 'yendi/x', title: 'Ünïcode “quotes”', steps: [{ goals: [{ t: 'level', level: 2 }] }] } };
	const s = encodeImport(payload);
	assert.ok(s.startsWith(PREFIX));
	assert.match(s, /^!PS1![0-9a-f]{8}![A-Za-z0-9+/]+={0,2}$/);
	assert.deepEqual(decodeImport(s), payload);
	assert.deepEqual(decodeImport(`  ${s.slice(0, 30)}\n${s.slice(30)}  `), payload, 'whitespace from a chat paste is ignored');
	assert.throws(() => decodeImport(s.slice(0, -8)), /damaged/);
	assert.throws(() => decodeImport(`!PS1!00000000!${s.slice(14)}`), /checksum/);
	assert.throws(() => decodeImport('hello'), /not a Polestar import string/);
});

test('importString refuses Polestar\'s own guides and guides over the step cap', () => {
	const data = fixtureData();
	const ours = compile({ 'a.guide': GUIDE('forever/alliance/x') }, data, { pack: 'guides' }).guides[0];
	assert.match(importString(ours, { manifest: { id: 'guides', license: 'GPL-3.0-only' }, data }).error, /Polestar's own guides/);
	const steps = Array.from({ length: LIMITS.steps + 1 }, (_, i) => `step Step ${i + 1}\n  level ${(i % 59) + 2}\n`).join('\n');
	const long = compile({ 'b.guide': `guide yendi/long\ntitle Long\nlevels 1-60\nzone Elwynn Forest\n\n${steps}` }, data, { pack: 'yendi' });
	assert.deepEqual(long.errors, []);
	assert.match(importString(long.guides[0], { manifest: { id: 'yendi', license: 'MIT' }, data }).error, /61 steps; an import string holds a guide of 60 steps at most/);
	const ok = importString(compile({ 'c.guide': GUIDE('yendi/ok') }, data, { pack: 'yendi' }).guides[0], { manifest: { id: 'yendi', license: 'MIT' }, data });
	const back = decodeImport(ok.text);
	assert.equal(back.license, 'MIT');
	assert.equal(back.guide.id, 'yendi/ok');
	assert.equal(back.guide.pack, undefined);
	assert.ok(back.frames && back.frames['1429'], 'the Era frame of the map its goals use');
});

// A pack in a temp folder, checked against the fixture data with an empty
// context (our guides are not needed to export one of the pack's).
function pack(files) {
	const dir = tmpdir('polestar-export-');
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify({ id: 'yendi', title: "Yendi's Guides", author: 'Yendi', version: '1.0.0', license: 'CC-BY-4.0' }));
	fs.mkdirSync(path.join(dir, 'context'));
	for (const [name, text] of Object.entries(files)) {
		fs.mkdirSync(path.dirname(path.join(dir, name)), { recursive: true });
		fs.writeFileSync(path.join(dir, name), text);
	}
	return dir;
}

function exportGuide(dir, file, extra = []) {
	return polestar(['export', path.join(dir, file), '--data', DATA_DIR, '--context', path.join(dir, 'context'), '--context-data', DATA_DIR, ...extra], { cwd: dir });
}

test('export prints the string of the guide in the file on stdout, and nothing else there', () => {
	const dir = pack({ 'guides/northshire.guide': GUIDE('yendi/northshire', 'next yendi/goldshire\n'), 'guides/goldshire.guide': GUIDE('yendi/goldshire') });
	const r = exportGuide(dir, 'guides/northshire.guide');
	assert.equal(r.status, 0, r.stderr);
	const lines = r.stdout.trim().split('\n');
	assert.equal(lines.length, 1);
	const p = decodeImport(lines[0]);
	assert.equal(p.guide.id, 'yendi/northshire');
	assert.equal(p.license, 'CC-BY-4.0');
	assert.equal(p.guide.author, 'Yendi');
	assert.equal(p.guide.steps.length, 4);
	assert.match(r.stderr, /exported yendi\/northshire: 4 steps/);
	assert.match(r.stderr, /leads on to yendi\/goldshire: players import that guide first/);
});

test('export refuses a guide with lint errors, but not for another guide\'s', () => {
	const dir = pack({ 'good.guide': GUIDE('yendi/good'), 'bad.guide': GUIDE('yendi/bad').replace('accept 783', 'accept 99999999') });
	const bad = exportGuide(dir, 'bad.guide');
	assert.equal(bad.status, 1);
	assert.equal(bad.stdout, '');
	assert.match(bad.stderr, /export failed: lint found \d+ errors? in \S*bad\.guide/);
	const good = exportGuide(dir, 'good.guide');
	assert.equal(good.status, 0, good.stderr);
	assert.equal(decodeImport(good.stdout).guide.id, 'yendi/good');
});

test('export refuses a file of two guides, a file outside any pack, and asks for one .guide file', () => {
	const dir = pack({ 'two.guide': `${GUIDE('yendi/a')}\n${GUIDE('yendi/b')}` });
	const two = exportGuide(dir, 'two.guide');
	if (two.status === 0) assert.fail('a file of two guides exported');
	assert.equal(two.stdout, '');
	assert.match(two.stderr, /holds 2 guides|export failed/);
	const loose = tmpdir('polestar-export-loose-');
	fs.writeFileSync(path.join(loose, 'x.guide'), GUIDE('yendi/x'));
	const none = polestar(['export', path.join(loose, 'x.guide'), '--data', DATA_DIR], { cwd: loose });
	assert.equal(none.status, 1);
	assert.match(none.stderr, /is in no pack/);
	assert.equal(polestar(['export']).status, 2);
	assert.equal(polestar(['export', 'pack.json']).status, 2);
});

test('importString refuses a text over the cap and a payload over the cap, as the addon would', () => {
	const manifest = { id: 'yendi', license: 'MIT' };
	const long = { id: 'yendi/long', title: 'a'.repeat(LIMITS.text + 1), steps: [{ goals: [{ t: 'level', level: 2 }] }] };
	assert.match(importString(long, { manifest, data: null }).error, /guide\.title is longer than 4096 bytes/);
	const steps = Array.from({ length: LIMITS.steps }, () => ({ note: 'n'.repeat(4000), goals: [{ t: 'note', text: 't'.repeat(1000) }] }));
	const big = { id: 'yendi/big', title: 'Big', steps };
	const r = importString(big, { manifest, data: null });
	assert.match(r.error, /bytes of guide data; Polestar reads 262144 at most/);
});

test('importString refuses a guide whose spots, predicates, jumps, reagents, sources, quest lists or names pass their caps, as the addon would', () => {
	const manifest = { id: 'yendi', license: 'MIT' };
	const when = { k: 'level', n: 2 };
	const quests = Array.from({ length: LIMITS.pre + 1 }, (_, i) => i + 1);
	const goal = (extra) => ({ t: 'kill', npc: 1, map: 1429, x: 50, y: 50, ...extra });
	const guide = (step, top = {}) => ({ id: 'yendi/padded', title: 'Padded', ...top, steps: [{ goals: [goal()], ...step }] });
	const cases = [
		['guide.steps[1].goals[1].spots', guide({ goals: [goal({ spots: Array.from({ length: LIMITS.spots + 1 }, () => ({ x: 50, y: 50, r: 1 })) })] })],
		['guide.steps[1].when', guide({ when: Array.from({ length: LIMITS.when + 1 }, () => when) })],
		['guide.steps[1].when[1].pre', guide({ when: [{ k: 'quest', pre: quests }] })],
		['guide.steps[1].skipto', guide({ skipto: Array.from({ length: LIMITS.skipto + 1 }, () => ({ to: 'x', when })) })],
		['guide.steps[1].goals[1].reagents', guide({ goals: [goal({ reagents: Array.from({ length: LIMITS.reagents + 1 }, () => ({ item: 1, count: 1 })) })] })],
		['guide.steps[1].goals[1].fromNpcs', guide({ goals: [goal({ fromNpcs: Array.from({ length: LIMITS.fromNpcs + 1 }, () => ({ npc: 1 })) })] })],
		['guide.steps[1].goals[1].closedBy', guide({ goals: [goal({ closedBy: quests })] })],
		['guide.names', guide({}, { names: Object.fromEntries(Array.from({ length: LIMITS.tokens + 1 }, (_, i) => [`npc:${i}`, 'A'])) })],
	];
	for (const [place, g] of cases) {
		const { error } = importString(g, { manifest, data: null });
		assert.ok(error && error.includes(`yendi/padded: ${place} has `), `${place}: ${error}`);
	}
	const fine = guide({ goals: [goal({ spots: Array.from({ length: LIMITS.spots }, () => ({ x: 50, y: 50, r: 1 })) })] });
	assert.equal(importString(fine, { manifest, data: null }).error, undefined);
});

test('the writer\'s caps are the addon\'s (Core/Import.lua LIMITS)', () => {
	const src = fs.readFileSync(path.join(__dirname, '..', 'addon', 'Polestar', 'Core', 'Import.lua'), 'utf8');
	const body = /^local LIMITS = \{([^}]*)\}/m.exec(src)[1];
	const lua = Object.fromEntries([...body.matchAll(/(\w+) = (\d+)/g)].map((m) => [m[1], Number(m[2])]));
	assert.deepEqual(lua, LIMITS);
});
