'use strict';
// Guards over the paired profession guides (tools/lib/professions/pairs.js, docs/forge/professions.md): each
// reaches 300 in both skills or says what is left; a gathering step never asks for more gathering skill than
// the steps before it brought; no crafting step asks for a material that no step before it in its section
// gathers, buys or crafts (or a section before it, for what a bracket buys once); the header names both
// skills; every gathering step leads with what it is for. They read the committed guides and data/forever.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA, needs } = require('./helpers/data');

const GUIDES = path.join(__dirname, '..', 'guides', 'forever', 'professions');
const PAIRS = [
	['herbalism-alchemy', 'Herbalism', 'Alchemy'],
	['mining-blacksmithing', 'Mining', 'Blacksmithing'],
	['mining-engineering', 'Mining', 'Engineering'],
	['skinning-leatherworking', 'Skinning', 'Leatherworking'],
	['fishing-cooking', 'Fishing', 'Cooking'],
	['tailoring-enchanting', 'Tailoring', 'Enchanting'],
];
const skip = needs('professions.json', 'items.json');
// A pair whose crafting guide is built from a route file (route.js) is written in single steps: a step may hold
// several `when` lines (a fork way and its plans), and the way a step is on shows in its whole `when` set.
const { loadRoute } = require('../tools/lib/professions/route');
// A pair built on a routed crafting guide (one action a step). Fishing + Cooking is not, though Cooking has a route
// file: its cooking is its fishing bands' own (pair-fishing.js over gathering/fish-rounds.js).
const routed = (craft) => craft !== 'Cooking' && !!loadRoute(craft);

const read = (name) => fs.readFileSync(path.join(GUIDES, `${name}.guide`), 'utf8');
const json = (name) => JSON.parse(fs.readFileSync(path.join(DATA, `${name}.json`), 'utf8'));

// The steps of a guide: { title, lines, section, when }.
function steps(text) {
	const out = [];
	let section = null;
	for (const l of text.split('\n')) {
		const sec = /^section (.+) (\d+)-(\d+)$/.exec(l);
		if (sec) section = `${sec[1]} ${sec[2]}-${sec[3]}`;
		const m = /^step (.*)$/.exec(l);
		if (m) out.push({ title: m[1], lines: [], section, when: null });
		else if (out.length && /^ {2}\S/.test(l)) {
			const s = out[out.length - 1];
			s.lines.push(l.trim());
			if (/^when /.test(l.trim())) s.when = s.when ? `${s.when} & ${l.trim()}` : l.trim();
		}
	}
	return out;
}

// The ways through a guide: each fork path's `when` (its steps and the unbranched ones), or one way (null).
function paths(all) {
	const w = [...new Set(all.map((s) => s.when).filter(Boolean))];
	return w.length ? w : [null];
}

test('every paired guide is a profession guide naming both skills, gathering (or Tailoring) first', { skip }, () => {
	for (const [file, a, b] of PAIRS) {
		const head = read(file).split('\n').slice(0, 12);
		assert.ok(head.includes('kind profession'), file);
		assert.ok(head.includes(`skills ${a}, ${b}`), file);
		assert.ok(head.includes(`title ${a} + ${b} 1-300`), file);
	}
});

test('each pair reaches 300 in both skills on every path, or its last step says what is left', { skip }, () => {
	for (const [file, a, b] of PAIRS) {
		const all = steps(read(file));
		if (a === 'Tailoring' && routed(a) && routed(b)) {
			// Neither gathers: each crafts to 300 in its own sections (Tailoring's way without a world-drop pattern
			// stops short and its last step says what is left).
			const to300 = new Set();
			let prof = null;
			for (const l of read(file).split('\n')) {
				const sec = /^section (\S+) \d+-\d+$/.exec(l);
				if (sec) prof = sec[1];
				if (/^ {2}craft \d+ until 300$/.test(l)) to300.add(prof);
			}
			assert.deepEqual([...to300].sort(), [a, b].sort(), `${file}: a craft to 300 for each`);
			assert.match(read(file), /only the two Auction House patterns reach 300/, `${file}: Tailoring's way without a pattern says what is left`);
			continue;
		}
		if (routed(b)) {
			// Every way ends crafting to 300, the gathering skill at 300 before it: a skill step, or the gathering
			// on the way that brings it there ("Mining 280 to 300 on the way").
			const ends = all.filter((s) => s.lines.some((l) => /^craft \d+ until 300$/.test(l)));
			assert.ok(ends.length, `${file}: a craft to 300`);
			const at300 = (s) => s.lines.includes(`skill ${a} 300`) || s.lines.some((l) => new RegExp(`^tip .*${a} \\d+ to 300 on the way`).test(l));
			for (const c of ends) assert.ok(all.slice(0, all.indexOf(c)).some(at300), `${file} ${c.title} (${c.when || 'every way'}): ${a} 300 before it`);
			continue;
		}
		for (const w of paths(all)) {
			const on = all.filter((s) => s.when === null || s.when === w);
			for (const skill of [a, b]) {
				const reached = on.some((s) => s.lines.includes(`skill ${skill} 300`));
				assert.ok(reached, `${file} ${w || ''}: ${skill} 300`);
			}
		}
	}
});

test('the gathering skill reaches 300 before the last crafting stretch (a passed section is done)', { skip }, () => {
	for (const [file, a, b] of PAIRS.filter((p) => p[1] !== 'Tailoring' && !routed(p[2]))) {
		const all = steps(read(file));
		for (const w of paths(all)) {
			const on = all.filter((s) => s.when === null || s.when === w);
			const last = on.map((s, i) => (s.lines.some((l) => new RegExp(`^craft \\d+ until`).test(l)) ? i : -1)).filter((i) => i >= 0).pop();
			const done = on.findIndex((s) => s.lines.includes(`skill ${a} 300`));
			assert.ok(done >= 0 && done < last, `${file} ${w || ''}: ${a} 300 at step ${done}, last craft at ${last} (${b})`);
		}
	}
});

test('a gathering step never asks more gathering skill than the steps before it brought', { skip }, () => {
	for (const [file, g] of PAIRS.filter((p) => p[1] !== 'Tailoring')) {
		const bad = [];
		const all = steps(read(file));
		for (const w of paths(all)) {
			let have = 1;
			for (const s of all.filter((x) => x.when === null || x.when === w)) {
				for (const l of s.lines) {
					const ask = new RegExp(`^collect \\d+ x\\d+ (?:anywhere )?gather ${g} (\\d+)`).exec(l);
					// A loop target asks the skill of its loops; a bag count beside it (a smelt's skill) is the trainer's.
					if (ask && !/ anywhere /.test(l) && Number(ask[1]) > have) bad.push(`${file} ${s.title}: ${l} (skill ${have} so far)`);
				}
				for (const l of s.lines) {
					const m = new RegExp(`^skill ${g} (\\d+)`).exec(l);
					if (m) have = Math.max(have, Number(m[1]));
				}
				// The gathering on the way raises the skill too ("Mining 230 to 250 on the way").
				for (const l of s.lines) {
					const r = new RegExp(`^tip .*${g} \\d+ to (\\d+) on the way`).exec(l);
					if (r) have = Math.max(have, Number(r[1]));
				}
			}
		}
		assert.deepEqual(bad, []);
	}
});

test('no crafting step asks for a material no step before it gathers, buys or crafts', { skip }, () => {
	const professions = json('professions');
	const recipe = new Map();
	for (const p of Object.values(professions)) for (const r of p.recipes) recipe.set(r.spell, r);
	for (const [file] of PAIRS) {
		const bad = [];
		const all = steps(read(file));
		const every = routed(file.split('-')[1].replace(/^./, (c) => c.toUpperCase()));
		// A routed pair's ways share their gets in a fork section: what any step before gets counts (the route's
		// own rule, tests/profession-route.test.js, checks each way's order).
		for (const w of every ? [null] : paths(all)) {
			const supplied = new Set(); // what any step before gets, buys or makes
			for (const s of every ? all : all.filter((x) => x.when === null || x.when === w)) {
				for (const l of s.lines) {
					const got = /^(?:collect|buy|auction) (\d+)/.exec(l);
					if (got) supplied.add(Number(got[1]));
				}
				for (const l of s.lines) {
					const c = /^craft (\d+)/.exec(l);
					if (!c) continue;
					const r = recipe.get(Number(c[1]));
					for (const g of (r && r.reagents) || []) if (!supplied.has(g.item)) bad.push(`${file} ${s.title}: ${r.name} takes item ${g.item}`);
					if (r && r.item) supplied.add(r.item);
				}
			}
		}
		assert.deepEqual([...new Set(bad)], []);
	}
});

test('before each crafting step, the gathering steps of its section hold what the section\'s crafts so far take', { skip }, () => {
	const professions = json('professions');
	const recipe = new Map();
	for (const p of Object.values(professions)) for (const r of p.recipes) recipe.set(r.spell, r);
	for (const [file, g] of PAIRS.filter((p) => p[1] !== 'Tailoring')) {
		const bad = [];
		const all = steps(read(file));
		for (const w of paths(all)) {
			let section = null;
			let have = new Map(); // item -> the section's gather count so far (counts are cumulative in a section)
			let made = new Map(); // item -> what the section's crafts so far make of it (Light Leather from scraps)
			let need = new Map(); // item -> what the section's crafts so far take, at their expected counts
			// Each `only` of a step is its own way through (a starting area's variant): counted apart.
			const onlyOf = (s) => (s.lines.find((l) => /^only /.test(l)) || '').slice(5);
			for (const s of all.filter((x) => x.when === null || x.when === w)) {
				if (s.section !== section) {
					section = s.section;
					have = new Map();
					made = new Map();
					need = new Map();
				}
				const key = (item) => `${onlyOf(s)}|${item}`;
				for (const l of s.lines) {
					const c = new RegExp(`^collect (\\d+) x(\\d+) (?:anywhere )?gather ${g} `).exec(l);
					if (c) have.set(key(Number(c[1])), Math.max(have.get(key(Number(c[1]))) || 0, Number(c[2])));
				}
				const craft = s.lines.map((l) => /^craft (\d+) until/.exec(l)).find(Boolean);
				const about = /about (\d+) crafts to/.exec(s.lines.find((l) => /^tip /.test(l)) || '');
				if (!craft || !about) continue;
				const r = recipe.get(Number(craft[1]));
				for (const x of (r && r.reagents) || []) {
					const k = key(x.item);
					if (!have.has(k)) continue;
					need.set(k, (need.get(k) || 0) + Number(about[1]) * x.count);
					const got = have.get(k) + (made.get(k) || 0);
					if (got < need.get(k)) bad.push(`${file} ${s.title}: ${need.get(k)} item ${x.item} by now, ${got} gathered or made in ${section}`);
				}
				if (r && r.item) made.set(key(r.item), (made.get(key(r.item)) || 0) + Number(about[1]) * (r.itemCount || 1));
			}
		}
		assert.deepEqual(bad, []);
	}
});

test('every gathering step leads with its count and what it is for', { skip }, () => {
	for (const [file, g, c] of PAIRS.filter((p) => p[1] !== 'Tailoring')) {
		const verb = { Herbalism: 'Pick', Mining: 'Mine', Skinning: 'Skin', Fishing: 'Fish' }[g];
		const gathers = steps(read(file)).filter((s) => s.title.startsWith(`${verb} `) && !/ until /.test(s.title));
		assert.ok(gathers.length >= 5, `${file}: ${gathers.length} gathering steps`);
		for (const s of gathers) {
			const tip = s.lines.find((l) => /^tip /.test(l)) || '';
			if (routed(c)) {
				// One action: the count in the title, one short line of what it is for.
				assert.match(s.title, new RegExp(`^${verb}(?: and smelt| beasts for)? \\d+ `), `${file} ${s.title}`);
				assert.match(tip, /^tip For .{1,116}$/, `${file} ${s.title}`);
			} else assert.match(tip, new RegExp(`^tip \\d+ .+? for ${c} \\d+-\\d+: [^.]+\\.`), `${file} ${s.title}`);
			assert.ok(s.lines.some((l) => /^loop /.test(l) || /^goto /.test(l)), `${file} ${s.title}: its loops, or the one stand it is fished at`);
		}
	}
});

test('Tailoring + Enchanting counts what disenchanting its own crafts gives, per bracket', { skip }, () => {
	const t = read('tailoring-enchanting');
	const counted = new Set([...t.matchAll(/Your Tailoring greens of (\d+-\d+) give about \d+ when disenchanted\./g)].map((m) => m[1]));
	assert.ok(counted.size >= 3, `${counted.size} brackets count Tailoring's greens`);
	// One trip: Learn Enchanting straight after Learn Tailoring; Journeyman Enchanting straight after Journeyman Tailoring.
	const titles = steps(t).map((s) => s.title);
	assert.equal(titles[titles.indexOf('Learn Tailoring') + 1], 'Learn Enchanting');
	assert.equal(titles[titles.indexOf('Train Journeyman Tailoring') + 1], 'Train Journeyman Enchanting');
});
