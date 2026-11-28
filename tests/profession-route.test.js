'use strict';
// Profession guides built from a curated route (tools/lib/professions/routes/<profession>.json, route.js;
// docs/forge/professions.md, "Route files"): the facts are checked against the data, and every step of the
// committed guide is one action a first-timer can follow on its own. Each step answers four things without
// its tip: what (one action), where (a place the arrow can lead to, or any station with the nearest pinned),
// how many (a count where it applies) and done when (a goal that finishes it). Tips are one short line of why
// or a heads-up, never an instruction. The route rules: every band's recipe is learnable where it is crafted
// (a learn step before it, or known with the rank), each craft's materials come from a get step (or parts
// crafted) before it, tools before their first use, a station before its first need.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.join(__dirname, '..');
const DATA = path.join(ROOT, 'data', 'forever');
const skip = !fs.existsSync(path.join(DATA, 'professions.json')) && 'needs data/forever';
const { loadRoute, checkRoute, TIP_MAX, IMPERATIVE } = require('../tools/lib/professions/route');

// The guides a route builds: the crafting guide and the paired guide on top of it.
const ROUTED = ['blacksmithing', 'mining-blacksmithing', 'alchemy', 'herbalism-alchemy', 'tailoring', 'leatherworking', 'skinning-leatherworking', 'tailoring-enchanting', 'enchanting', 'engineering', 'mining-engineering', 'first-aid', 'cooking'];
const slugOf = (name) => String(name).toLowerCase().replace(/[^a-z0-9]+/g, '-');
// The profession a routed guide levels by its route: the crafting one of a pair (its file name ends with it).
const profOf = (d, name) => Object.values(d.professions).find((p) => p && p.recipes && name.endsWith(slugOf(p.name)) && (p.kind !== 'secondary' || name === slugOf(p.name)));
const read = (name) => fs.readFileSync(path.join(ROOT, 'guides', 'forever', 'professions', `${name}.guide`), 'utf8');
const exists = (name) => fs.existsSync(path.join(ROOT, 'guides', 'forever', 'professions', `${name}.guide`));

// The guide's steps: { title, when: [...], tip, goals: [{ verb, rest }], line }.
function stepsOf(text) {
	const out = [];
	let cur = null;
	text.split('\n').forEach((l, i) => {
		if (l.startsWith('step ')) {
			cur = { title: l.slice(5), when: [], tip: null, goals: [], line: i + 1 };
			out.push(cur);
		} else if (/^\S/.test(l)) cur = null;
		else if (cur && /^ {2}\S/.test(l)) {
			const [, verb, rest = ''] = /^ {2}(\S+)\s*(.*)$/.exec(l);
			if (verb === 'when') cur.when.push(rest);
			else if (verb === 'tip') cur.tip = rest;
			else if (verb !== 'loop' && verb !== 'zone' && verb !== 'only') cur.goals.push({ verb, rest });
		}
	});
	return out;
}

let data = null;
const loadData = () => {
	if (!data) data = require('../tools/lib/professions/guide').draftData(DATA);
	return data;
};

test('tips are one short line, never an instruction', () => {
	for (const name of ROUTED.filter(exists)) {
		for (const s of stepsOf(read(name))) {
			if (!s.tip) continue;
			assert.ok(s.tip.length <= TIP_MAX, `${name}:${s.line} ${s.title}: a tip of ${s.tip.length} characters (at most ${TIP_MAX}): ${s.tip}`);
			assert.doesNotMatch(s.tip, IMPERATIVE, `${name}:${s.line} ${s.title}: the tip tells the player to do something; make it a step: ${s.tip}`);
		}
	}
});

test('every step says what, where, how many and when it is done, on its own', () => {
	// Goals that lead somewhere (the arrow): a smart target, a place, a loop or farm, a trainer list.
	const placed = (g) => /^(train|buy|auction|turnin|accept|complete|vendor)$/.test(g.verb) || (g.verb === 'learn') || (g.verb === 'goto') || (g.verb === 'collect' && /\b(gather|nearest|@)/.test(g.rest)) || (g.verb === 'skill');
	// Goals that may sit anywhere: a craft (its station step comes before when it needs one), a level, a task.
	const anywhere = (g) => /^(craft|level|task|skill)$/.test(g.verb) || (g.verb === 'use' && /\beither\b/.test(g.rest));
	// A craft until a skill says its count in the title ("Craft 30 Rough Sharpening Stones until 25").
	const counted = (g, s) => (g.verb === 'craft' && /\buntil \d+/.test(g.rest) ? /^Craft \d+ /.test(s.title) : !/^(buy|auction|collect|craft)$/.test(g.verb) || /\bx\d+\b/.test(g.rest));
	for (const name of ROUTED.filter(exists)) {
		for (const s of stepsOf(read(name))) {
			const at = `${name}:${s.line} ${s.title}`;
			const goals = s.goals.filter((g) => g.verb !== 'note');
			assert.ok(goals.length, `${at}: no goal (what is done?)`);
			assert.ok(goals.some((g) => !/\boptional\b/.test(g.rest)), `${at}: only optional goals (nothing finishes the step)`);
			assert.ok(goals.every((g) => placed(g) || anywhere(g)), `${at}: a goal with no place: ${goals.map((g) => g.verb).join(', ')}`);
			assert.ok(goals.every((g) => counted(g, s)), `${at}: a material or craft without a count`);
			// One action: the goals of a step are one verb (a get's ways are its choice rows: collect and auction).
			// An `either` task or kit beside the action is its other way out ("No green items left to break", a
			// Basic Campfire Kit beside the cooking fires), not a second action.
			const main = goals.filter((g) => !(/^(task|use)$/.test(g.verb) && /\beither\b/.test(g.rest)));
			const verbs = new Set((main.length ? main : goals).map((g) => (g.verb === 'auction' || g.verb === 'collect' || g.verb === 'task' ? 'get' : g.verb === 'buy' && goals.some((x) => x.verb === 'collect') ? 'get' : g.verb)));
			assert.ok(verbs.size === 1, `${at}: more than one action (${[...verbs].join(', ')})`);
		}
	}
});

test('the route rules: recipe learnable, materials got, tools and stations before their first need', { skip }, () => {
	const d = loadData();
	for (const name of ROUTED.filter(exists)) {
		const steps = stepsOf(read(name));
		const prof = profOf(d, name);
		const recipes = new Map(prof.recipes.map((r) => [r.spell, r]));
		const known = new Set(prof.recipes.filter((r) => Number(r.learnedAt) <= 1 && !r.cost && r.source === 'trainer').map((r) => r.spell));
		const got = new Set();
		const tools = new Set();
		let station = null;
		for (const s of steps) {
			const at = `${name}:${s.line} ${s.title}`;
			for (const g of s.goals) {
				const id = Number(g.rest.split(' ')[0]);
				if (g.verb === 'learn') known.add(id);
				if (g.verb === 'collect' || g.verb === 'auction' || g.verb === 'buy') {
					got.add(id);
					tools.add(id);
				}
				if (g.verb === 'goto' && / nearest\b/.test(g.rest)) station = /"([^"]+)"/.exec(g.rest)[1];
				if (g.verb === 'craft') {
					const r = recipes.get(id);
					if (!r) continue; // the other profession of a pair
					assert.ok(known.has(id), `${at}: crafts ${r.name} before any step learns it`);
					for (const rg of r.reagents) {
						const part = prof.recipes.some((x) => x.item === rg.item);
						assert.ok(got.has(rg.item) || part, `${at}: ${r.name} needs item ${rg.item}, which no step before it gets`);
					}
					for (const t of r.tools || []) assert.ok(tools.has(t), `${at}: ${r.name} needs tool ${t}, bought or crafted by no step before it`);
					if (r.focus) assert.equal(station, r.focus, `${at}: ${r.name} needs ${r.focus}; the step before it goes to ${station || 'none'}`);
					tools.add(r.item); // a tool the profession crafts itself (Arclight Spanner, runed rods)
				}
			}
			if (s.goals.some((g) => g.verb !== 'craft' && g.verb !== 'goto')) station = s.goals.some((g) => g.verb === 'goto') ? station : null;
		}
	}
});

test('a trainer visit learns every recipe of the rank the skill already allows: no second trip', { skip }, () => {
	const d = loadData();
	for (const name of ROUTED.filter(exists)) {
		const prof = profOf(d, name);
		const recipes = new Map(prof.recipes.map((r) => [r.spell, r]));
		let skill = 1;
		const visits = []; // trainer visits outside fork ways: { npcs, skill }
		for (const s of stepsOf(read(name))) {
			for (const g of s.goals) {
				const until = /\buntil (\d+)/.exec(g.rest);
				if (g.verb === 'craft' && until && recipes.has(Number(g.rest.split(' ')[0]))) skill = Math.max(skill, Number(until[1]));
				const m = /^(\d+) npc ([\d,]+)/.exec(g.rest);
				// A repeat of an earlier learn (for a player who loads the guide past it) is no trip: done at once.
				if (g.verb !== 'learn' || !m || s.when.length || /^Taught at /.test(s.tip || '')) continue;
				const r = recipes.get(Number(m[1]));
				if (!r) continue;
				const early = visits.find((v) => v.npcs === m[2] && v.skill >= Number(r.learnedAt) && v.skill < skill);
				assert.ok(!early, `${name}:${s.line} ${s.title}: learnable (from ${r.learnedAt}) on the visit at skill ${early && early.skill}; a second trip`);
				visits.push({ npcs: m[2], skill });
			}
		}
	}
});

test('fork ways tell plans apart, and the boots-only Radiant way reaches 300', { skip }, () => {
	const steps = stepsOf(read('blacksmithing'));
	const boots = steps.filter((s) => s.when.includes('knows 16656') && s.when.includes('!has 12713') && s.when.includes('!knows 16725'));
	assert.ok(boots.some((s) => s.goals.some((g) => g.verb === 'craft' && /until 300/.test(g.rest))), 'a player with only Plans: Radiant Boots has a way to 300');
	assert.equal(steps.filter((s) => /^Buy Plans: Radiant Boots/.test(s.title)).length, 1, 'plans two ways share are bought once');
});

test('the route format: vendor recipes, crafted tools, camp stations, ranks from a book or quest, a dungeon trainer', { skip }, () => {
	const d = loadData();
	const prof = d.professions[164];
	const base = loadRoute('Blacksmithing');
	const copy = () => JSON.parse(JSON.stringify(base));
	// A recipe from an item: its vendors, a quest or fork plans, else the build stops.
	const noVendor = copy();
	noVendor.sections[3].route[1].quests = [];
	assert.throws(() => checkRoute(noVendor, prof, d), /Imperial Plate Bracers: taught by item 12690; list its vendors in `recipes`/);
	// A tool must be listed: bought on the first visit or crafted.
	const noTool = copy();
	noTool.tools = [];
	assert.throws(() => checkRoute(noTool, prof, d), /needs tool 5956, which `tools` does not list/);
	const badTool = copy();
	badTool.tools.push({ item: 6219, at: 'craft' });
	assert.throws(() => checkRoute(badTool, prof, d), /tool 6219: no Blacksmithing recipe makes it/);
	// A camp-only station is never a route's.
	const tailor = d.professions[197];
	const loom = { profession: 'Tailoring', tools: [], materials: { 14048: ['auction'], 14343: ['auction'], 7080: ['auction'], 14341: ['vendor'] }, sections: [{ rank: 'Artisan', from: 285, to: 300, level: 35, teachers: { Alliance: [], Horde: [] }, route: [{ from: 285, to: 290, recipe: 1297123, count: 1, mats: { 14048: 4, 14343: 1, 7080: 3, 14341: 6 } }] }], recipes: {} };
	assert.throws(() => checkRoute(loom, tailor, d), /needs a Loom, which only a camp has/);
	// A rank from a book or a quest, and a rank only a dungeon trainer teaches.
	const fa = d.professions[129];
	const book = { profession: 'First Aid', tools: [], materials: {}, sections: [{ rank: 'Expert', from: 150, to: 225, level: 1, by: { book: 16084, vendors: { Alliance: [2805], Horde: [13476] } }, teachers: { Alliance: [], Horde: [] }, route: [] }] };
	checkRoute(book, fa, d);
	book.sections[0].by.book = 16083;
	assert.throws(() => checkRoute(book, fa, d), /the data has no book 16083 for this rank/);
	const ench = d.professions[333];
	const inside = { profession: 'Enchanting', tools: [], materials: {}, sections: [{ rank: 'Expert', from: 150, to: 225, level: 20, dungeon: true, teachers: { Alliance: [], Horde: [] }, route: [] }] };
	assert.throws(() => checkRoute(inside, ench, d), /`dungeon`, but no trainer of the rank stands inside a dungeon/);
});

test('a route whose counts the data does not bear out fails the build, naming the band', { skip }, () => {
	const d = loadData();
	const route = JSON.parse(JSON.stringify(loadRoute('Blacksmithing')));
	route.sections[0].route[0].mats['2835'] = 31;
	const prof = d.professions[164];
	assert.throws(() => checkRoute(route, prof, d), /1-25 Rough Sharpening Stone: 30 crafts take 30 of item 2835, the route says 31/);
	const wrong = JSON.parse(JSON.stringify(loadRoute('Blacksmithing')));
	wrong.sections[1].teachers.Alliance.push(3355);
	assert.throws(() => checkRoute(wrong, prof, d), /Saru Steelfury does not serve the Alliance/);
});

test('count rows use the plural: Empty Vials, Motes of Magic, Bronze Bars; mass nouns, herbs and ore stay', () => {
	const D = require('../tools/lib/professions/describe');
	const cases = [
		[54, 'Empty Vial', false, '54 Empty Vials'],
		[19, 'Mote of Magic', false, '19 Motes of Magic'],
		[91, 'Bronze Bar', false, '91 Bronze Bars'],
		[10, 'Light Hide', false, '10 Light Hides'],
		[88, 'Heart of Fire', false, '88 Hearts of Fire'],
		[20, 'Star Ruby', false, '20 Star Rubies'],
		[1, 'Copper Rod', false, '1 Copper Rod'],
		[60, 'Linen Cloth', false, '60 Linen Cloth'],
		[105, 'Ruined Leather Scraps', false, '105 Ruined Leather Scraps'],
		[28, 'Coarse Thread', false, '28 Coarse Thread'],
		[50, 'Strange Dust', false, '50 Strange Dust'],
		[198, 'Rough Stone', false, '198 Rough Stone'],
		[47, 'Stonescale Eel', false, '47 Stonescale Eel'],
		[9, 'Silverleaf', true, '9 Silverleaf'],
		[25, "Khadgar's Whisker", true, "25 Khadgar's Whisker"],
	];
	for (const [n, name, mass, want] of cases) assert.equal(D.items(n, name, mass), want);
	for (const name of ROUTED.filter(exists)) {
		for (const s of stepsOf(read(name))) assert.doesNotMatch(s.title, /^(Buy|Get) \d+ (Empty Vial|Leaded Vial|Crystal Vial|Mote of Magic|\S+ Bar)$/, `${name}:${s.line} ${s.title}: the count's plural`);
	}
});

test('what to keep is in the craft\'s row ("· keep them for the belts"), never a tip; kept crafts finish on their count', () => {
	for (const name of ROUTED.filter(exists)) {
		for (const s of stepsOf(read(name))) {
			assert.doesNotMatch(s.tip || '', /\bkeep\b/i, `${name}:${s.line} ${s.title}: a keep instruction belongs in the row`);
			if (/ · keep /.test(s.title)) assert.ok(s.goals.some((g) => g.verb === 'craft' && /^\d+ x\d+$/.test(g.rest)), `${name}:${s.line} ${s.title}: a kept craft is done on its count`);
		}
	}
	assert.ok(stepsOf(read('tailoring')).some((s) => s.title === 'Craft 30 Bolts of Linen Cloth · keep them for the belts'));
});

test('pair gathering rows name what is gathered: the herbs, ore or beasts of the loops', () => {
	const rows = (name) => stepsOf(read(name)).map((s) => s.title);
	const herb = rows('herbalism-alchemy').filter((t) => /^Pick .* until Herbalism \d+$/.test(t));
	assert.ok(herb.length && herb.every((t) => !/^Pick until/.test(t)), 'Herbalism rows name the herbs');
	const skin = rows('skinning-leatherworking');
	assert.ok(skin.filter((t) => / until Skinning \d+$/.test(t)).every((t) => /^Skin beasts of level \d+-\d+ until Skinning \d+$/.test(t)), 'Skinning rows give the beasts\' levels');
	assert.ok(skin.some((t) => /^Skin beasts for \d+ Ruined Leather Scraps$/.test(t)), 'Skin beasts for N Ruined Leather Scraps');
});
