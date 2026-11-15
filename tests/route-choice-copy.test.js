'use strict';
// The copy of every "Choose your path" card (addon/Polestar/UI/RouteChoice.lua): each guide a route choice
// offers (a guide with more than one plain `next`; a `next ... when ...` picks by itself, it asks nothing)
// writes one short sentence (`pitch`, at most 60 characters: two lines at UI scale 1.0) and exactly 3 pros and
// 1 con (`pro`, `con`, at most 38 characters each: one line on the card). The card cuts a longer line rather
// than wrapping it, so a longer one would show cut.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.join(__dirname, '..');
const PITCH_MAX = 60;
const LINE_MAX = 38;

/** Every .guide file under `dir`, recursively. */
function guideFiles(dir) {
	const out = [];
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const f = path.join(dir, e.name);
		if (e.isDirectory()) out.push(...guideFiles(f));
		else if (e.name.endsWith('.guide')) out.push(f);
	}
	return out;
}

/** A guide's header (the lines before its first step): id, faction, next ids, pitch, pros, cons. */
function header(file) {
	const h = { file: path.relative(root, file), next: [], pros: [], cons: [] };
	for (const line of fs.readFileSync(file, 'utf8').split('\n')) {
		if (/^step\b/.test(line)) break;
		const m = /^(guide|faction|next|pitch|pro|con) (.*)$/.exec(line);
		if (!m) continue;
		const [, kw, rest] = m;
		if (kw === 'guide') h.id = rest.trim();
		else if (kw === 'faction') h.faction = rest.trim();
		else if (kw === 'next') { if (!/\swhen\s/.test(rest)) h.next.push(rest.trim().split(/\s+/)[0]); }
		else if (kw === 'pitch') h.pitch = rest.trim();
		else if (kw === 'pro') h.pros.push(rest.trim());
		else h.cons.push(rest.trim());
	}
	return h;
}

const guides = new Map();
for (const dir of ['guides', 'experimental/guides']) {
	for (const f of guideFiles(path.join(root, dir))) {
		const h = header(f);
		if (h.id) guides.set(h.id, h);
	}
}
// A guide for both factions (no `faction`) names each faction's next guide: that is no choice.
const offered = new Set();
let points = 0;
for (const h of guides.values()) {
	if (h.next.length < 2 || !h.faction) continue;
	points++;
	for (const id of h.next) offered.add(id);
}

test('route choices exist to check', () => {
	assert.ok(points >= 5, `only ${points} route choices found`);
});

test('every route choice card has one short sentence, 3 short pros and 1 short con', () => {
	const bad = [];
	const len = (s) => [...s].length;
	for (const id of [...offered].sort()) {
		const h = guides.get(id);
		if (!h) {
			bad.push(`${id}: offered but not found`);
			continue;
		}
		if (!h.pitch) bad.push(`${h.file}: no pitch`);
		else if (len(h.pitch) > PITCH_MAX) bad.push(`${h.file}: pitch ${len(h.pitch)} > ${PITCH_MAX} characters: ${h.pitch}`);
		if (h.pros.length !== 3) bad.push(`${h.file}: ${h.pros.length} pros, the card shows 3`);
		if (h.cons.length !== 1) bad.push(`${h.file}: ${h.cons.length} cons, the card shows 1`);
		for (const l of [...h.pros, ...h.cons]) {
			if (len(l) > LINE_MAX) bad.push(`${h.file}: ${len(l)} > ${LINE_MAX} characters: ${l}`);
		}
		for (const l of [h.pitch || '', ...h.pros, ...h.cons]) {
			if (l.includes('\u2014')) bad.push(`${h.file}: an em dash: ${l}`);
		}
	}
	assert.deepEqual(bad, []);
});
