'use strict';
// The use-item guard: a quest item a quest asks for that nothing drops, sells or holds, and that the
// game makes by using another item (Tanaris Field Sampling's Acceptable Samples, made by using the
// Untested Samples the beasts drop; Pamela's doll joined from its pieces), needs that use as a goal
// row: `use <item>` in the step that works the objective, or in a step before it in the same guide
// (any step of the guide for a step listed along the way). A step with only the count leaves the use
// to its tip, and a player who reads the goal rows never does it (CurseForge, 0.4.3: about two hours
// on Tanaris Field Sampling).
//
// What makes an item comes from the client's item tables (ItemEffect, ItemXItemEffect, SpellEffect:
// an item's use spell with a Create Item effect); the quests and items from data/forever. Skips
// without either. The rule reads the guide sources, so it covers every guide, hand-written or not.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { DATA, SOURCES } = require('../tools/lib/paths');
const { OFFICIAL_DIR } = require('../tools/lib/dsl/project');

// The newest client table build with the three tables.
function tableDir() {
	const root = path.join(SOURCES, 'wago');
	if (!fs.existsSync(root)) return null;
	const builds = fs.readdirSync(root).filter((b) => ['ItemEffect.csv', 'ItemXItemEffect.csv', 'SpellEffect.csv'].every((f) => fs.existsSync(path.join(root, b, f))));
	builds.sort((a, b) => a.localeCompare(b, 'en', { numeric: true }));
	return builds.length ? path.join(root, builds[builds.length - 1]) : null;
}
const TABLES = tableDir();
const skip = needs('quests.json', 'items.json') || (TABLES ? false : 'no client item tables in data/sources/wago (forge data build)');

// Rows of a numeric CSV as objects by its header.
function csv(file) {
	const [head, ...rows] = fs.readFileSync(path.join(TABLES, file), 'utf8').split(/\r?\n/).filter(Boolean);
	const keys = head.split(',');
	return rows.map((r) => Object.fromEntries(r.split(',').map((v, i) => [keys[i], v])));
}

// item made -> the items whose use makes it.
function madeBy() {
	const effects = new Map(csv('ItemEffect.csv').filter((e) => e.TriggerType === '0' && +e.SpellID > 0).map((e) => [e.ID, +e.SpellID]));
	const creates = new Map();
	for (const e of csv('SpellEffect.csv')) {
		if (e.Effect === '24' && +e.EffectItemType > 0) {
			const list = creates.get(+e.SpellID) || [];
			list.push(+e.EffectItemType);
			creates.set(+e.SpellID, list);
		}
	}
	const out = new Map();
	for (const x of csv('ItemXItemEffect.csv')) {
		const spell = effects.get(x.ItemEffectID);
		for (const made of creates.get(spell) || []) {
			if (!out.has(made)) out.set(made, new Set());
			out.get(made).add(+x.ItemID);
		}
	}
	return out;
}

// A guide's steps: { line, along, rows } with each row's code (the text before ` -- `).
function steps(text) {
	const out = [];
	let cur = null;
	text.split('\n').forEach((l, i) => {
		if (l === 'step' || l.startsWith('step ')) {
			cur = { line: i + 1, along: false, rows: [] };
			out.push(cur);
			return;
		}
		const t = l.trim();
		if (!cur || !t || t.startsWith('#')) return;
		if (!/^\s/.test(l)) {
			cur = null;
			return;
		}
		if (/^along\b/.test(t)) cur.along = true;
		cur.rows.push(t.split(' -- ')[0].trim());
	});
	return out;
}

// The objective a row works: [quest, objective or undefined] for `kill|collect|interact|talk|use … quest Q[.O]`
// and `complete Q`, else null.
function works(row) {
	const w = row.split(/\s+/);
	const q = row.match(/\bquest\s+(\d+)(?:\.(\d+))?/);
	if (['collect', 'kill', 'interact', 'talk', 'use'].includes(w[0]) && q) return [+q[1], q[2] ? +q[2] : undefined];
	const c = w[0] === 'complete' && (w[1] || '').match(/^(\d+)/);
	return c ? [+c[1], undefined] : null;
}

// Our guides as { name, text }, name the path under guides/.
function guideSources() {
	const walk = (dir) => fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(dir, e.name)) : e.name.endsWith('.guide') ? [path.join(dir, e.name)] : []));
	return walk(path.join(OFFICIAL_DIR, 'forever')).map((file) => ({ name: path.relative(OFFICIAL_DIR, file).split(path.sep).join('/'), text: fs.readFileSync(file, 'utf8') }));
}

// Every step of `sources` that works an objective made by an item's use with no `use` row for one of those items.
function missingUses(made, quests, items, sources) {
	const out = [];
	for (const { name, text } of sources) {
		const list = steps(text);
		list.forEach((step, si) => {
			for (const row of step.rows) {
				const w = works(row);
				if (!w) continue;
				const [q, oi] = w;
				(quests[q]?.objectives || []).forEach((o, k) => {
					if ((oi !== undefined && k + 1 !== oi) || o.type !== 'item') return;
					const it = items[o.id] || {};
					const drops = it.drops || {};
					if (!it.questItem || Object.keys(drops.npc || {}).length || Object.keys(drops.object || {}).length || (it.vendors || []).length) return;
					const from = made.get(o.id);
					if (!from) return;
					const pool = (step.along ? list : list.slice(0, si + 1)).flatMap((s) => s.rows);
					const used = pool.some((r) => {
						const [verb, id] = r.split(/\s+/);
						return verb === 'use' && from.has(+id);
					});
					if (!used) out.push(`${name}:${step.line} quest ${q}.${k + 1} (${it.name}) needs a use row for ${[...from].join(' or ')}`);
				});
			}
		});
	}
	return [...new Set(out)];
}

test('every step whose objective item is made by using another item has that use as a goal row', { skip }, () => {
	const quests = JSON.parse(fs.readFileSync(path.join(DATA, 'quests.json'), 'utf8'));
	const items = JSON.parse(fs.readFileSync(path.join(DATA, 'items.json'), 'utf8'));
	const made = madeBy();
	assert.deepEqual([...(made.get(9441) || [])], [9439], 'the client tables say the Untested Hyena Sample makes the Acceptable Hyena Sample');
	assert.deepEqual(missingUses(made, quests, items, guideSources()), []);
});

test('the use-item guard names a step that keeps the use in its tip, and passes it with the use row', { skip }, () => {
	const quests = JSON.parse(fs.readFileSync(path.join(DATA, 'quests.json'), 'utf8'));
	const items = JSON.parse(fs.readFileSync(path.join(DATA, 'items.json'), 'utf8'));
	const made = madeBy();
	// Tanaris Field Sampling as it was: the count, the use only in the tip.
	const before = 'step Tanaris Field Sampling\n  tip Each can drop an untested sample: use it.\n  accept 654\n  collect 9441 quest 654.2\n';
	assert.deepEqual(missingUses(made, quests, items, [{ name: 'before.guide', text: before }]), ['before.guide:1 quest 654.2 (Acceptable Hyena Sample) needs a use row for 9439']);
	const after = 'step Tanaris Field Sampling\n  accept 654\n  collect 9439\n  use 9439 quest 654.2\n  collect 9441 quest 654.2\n';
	assert.deepEqual(missingUses(made, quests, items, [{ name: 'after.guide', text: after }]), []);
	// A use in an earlier step of the same guide counts; one in a later step does not.
	const later = 'step A\n  collect 9441 quest 654.2\n\nstep B\n  use 9439\n';
	assert.equal(missingUses(made, quests, items, [{ name: 'later.guide', text: later }]).length, 1);
});
