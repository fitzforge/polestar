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

// The guides a route builds: the crafting guide and the paired guide on top of it, and the gathering guides
// (routes/<profession>.json with `"kind": "gathering"`, gathering/steps.js).
const ROUTED = ['blacksmithing', 'mining-blacksmithing', 'mining', 'herbalism', 'skinning', 'fishing', 'lockpicking'];
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
	const placed = (g) => /^(train|buy|auction|turnin|accept|complete|vendor)$/.test(g.verb) || (g.verb === 'learn') || (g.verb === 'goto') || (g.verb === 'collect' && /\b(gather|nearest)\b|@/.test(g.rest)) || (g.verb === 'skill');
	// Goals that may sit anywhere: a craft (its station step comes before when it needs one), a level, a task,
	// a skill, and what is done on the spot (equip the pole, put a lure on it, turn tracking on).
	const anywhere = (g) => /^(craft|level|task|skill|equip|use|cast)$/.test(g.verb);
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
			// One action: the goals of a step are one verb (a get's ways are its choice rows: collect, a vendor and
			// the Auction House).
			// A skill step's gotos are where the skill is earned (Lockpicking's boxes), not a second action.
			const verbs = new Set(goals.map((g) => (g.verb === 'auction' || g.verb === 'collect' || g.verb === 'task' ? 'get' : g.verb === 'buy' && goals.some((x) => x.verb === 'collect' || x.verb === 'auction') ? 'get' : g.verb === 'goto' && goals.some((x) => x.verb === 'skill') ? 'skill' : g.verb)));
			assert.ok(verbs.size === 1, `${at}: more than one action (${[...verbs].join(', ')})`);
		}
	}
});

test('the route rules: recipe learnable, materials got, tools and stations before their first need', { skip }, () => {
	const d = loadData();
	for (const name of ROUTED.filter(exists)) {
		const steps = stepsOf(read(name));
		const prof = Object.values(d.professions).find((p) => name.endsWith(p.name.toLowerCase()) && p.recipes && p.kind !== 'secondary');
		if (!prof) continue; // Fishing crafts nothing
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
		const prof = Object.values(d.professions).find((p) => name.endsWith(p.name.toLowerCase()) && p.recipes && p.kind !== 'secondary');
		if (!prof) continue; // Fishing and Lockpicking learn no trainer recipes
		const recipes = new Map(prof.recipes.map((r) => [r.spell, r]));
		let skill = 1;
		const visits = []; // trainer visits outside fork ways: { npcs, skill }
		for (const s of stepsOf(read(name))) {
			for (const g of s.goals) {
				const until = /\buntil (\d+)/.exec(g.rest);
				if (g.verb === 'craft' && until && recipes.has(Number(g.rest.split(' ')[0]))) skill = Math.max(skill, Number(until[1]));
				const m = /^(\d+) npc ([\d,]+)/.exec(g.rest);
				if (g.verb !== 'learn' || !m || s.when.length) continue;
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

test('a gathering route that trains a rank before its skill, or goes past the cap, fails the build', { skip }, () => {
	const { context } = require('../tools/lib/professions/gathering/common');
	const { SPECS } = require('../tools/lib/professions/gathering/specs');
	const { renderRoute } = require('../tools/lib/professions/gathering/steps');
	const ctx = context(DATA);
	const prof = SPECS.find((p) => p.file === 'fishing');
	const early = JSON.parse(JSON.stringify(loadRoute('fishing')));
	early.sections[0].steps.unshift({ train: 'Journeyman' });
	assert.throws(() => renderRoute(ctx, prof, early), /Journeyman needs skill 50; the route is at 1/);
	const past = JSON.parse(JSON.stringify(loadRoute('fishing')));
	past.sections[1].steps = past.sections[1].steps.filter((e) => !e.train);
	assert.throws(() => renderRoute(ctx, prof, past), /150 is past the Apprentice cap \(75\)/);
	const long = JSON.parse(JSON.stringify(loadRoute('fishing')));
	long.sections[0].steps[1].tip = 'Buy it from the vendor.';
	assert.throws(() => renderRoute(ctx, prof, long), /a tip that tells the player to do something/);
});

// #4504: Forever makes some of the curated kinds humanoids or demons with no skinning loot (the owlbeasts of the
// Hinterlands and Winterspring, the Redridge Thrashers): a Skinning loop never leads to a creature a player
// cannot skin (skinnable.json: type Beast, or skinning loot in the world database).
test('no skinning loop targets a creature that cannot be skinned (#4504)', { skip }, () => {
	const { context } = require('../tools/lib/professions/gathering/common');
	const S = require('../tools/lib/professions/gathering/skinning');
	const ctx = context(DATA);
	const can = S.skinnable();
	for (const owl of [2927, 2928, 2929]) assert.ok(!can.has(owl), `owlbeast ${owl} is no beast and has no skinning loot on Forever`);
	const route = loadRoute('skinning');
	const lists = Object.entries(S.BEASTS).map(([map, names]) => [Number(map), names]);
	for (const sec of route.sections) for (const e of sec.steps) for (const [zone, names] of Object.entries(e.mobs || {})) {
		const map = Object.keys(ctx.data.zones).find((z) => (ctx.data.zone(Number(z)) || {}).name === zone);
		lists.push([Number(map), names]);
	}
	const bad = [];
	for (const [map, names] of lists) for (const p of S.SKINNING_POINTS(ctx, map, 1, 300, names)) if (!can.has(p.id)) bad.push(`${map} ${p.name} (${p.id})`);
	assert.deepEqual([...new Set(bad)], []);
	const owlsOut = S.SKINNING_POINTS(ctx, 1425, 1, 300, ['Vicious Owlbeast', 'Primitive Owlbeast', 'Savage Owlbeast']);
	assert.deepEqual(owlsOut, [], 'the Hinterlands owlbeasts give no skinning point');
});

// Fitz's in-game test (Mining, 'Get 140 Copper Ore' offered the Auction House and put the ore on the Shopping list):
// a gathering guide never offers to buy what its own profession gathers, nor does a paired guide for what its
// gathering profession gathers: those are gathered (`collect … gather` with loops), with no `auction` goal, so the
// Materials window has no choice for them and the Shopping list holds only what is really bought. A crafting-only
// guide still offers the Auction House beside the gathering.
test('gathering and paired guides never offer to buy what their gathering profession gathers; crafting guides still do', () => {
	const GATHERS = { mining: 'Mining', herbalism: 'Herbalism', skinning: 'Skinning', fishing: 'Fishing', 'mining-blacksmithing': 'Mining', 'mining-engineering': 'Mining', 'herbalism-alchemy': 'Herbalism', 'skinning-leatherworking': 'Skinning', 'fishing-cooking': 'Fishing' };
	for (const [name, prof] of Object.entries(GATHERS).filter(([n]) => exists(n))) {
		const text = read(name);
		// Gathered: what a step gathers on its loops (a rare find with no loop, Silver Ore, stays a buy).
		const gathered = new Set();
		for (const block of text.split('\nstep ').filter((b) => /\n {2}loop /.test(b))) for (const m of block.matchAll(new RegExp(`^ {2}collect (\\d+) x\\d+.* gather ${prof}\\b`, 'gm'))) gathered.add(m[1]);
		const bought = [...text.matchAll(/^ {2}auction (\d+) /gm)].map((m) => m[1]).filter((id) => gathered.has(id));
		assert.deepEqual([...new Set(bought)], [], `${name}: ${prof} gathers these, yet the guide offers to buy them (the Shopping list would list them)`);
	}
	// The single gathering guides' own steps carry no buy row at all for what they gather.
	for (const name of ['mining', 'herbalism', 'skinning', 'fishing'].filter(exists)) {
		for (const s of stepsOf(read(name))) {
			if (!s.goals.some((g) => g.verb === 'collect' && /\bgather\b/.test(g.rest))) continue;
			assert.ok(!s.goals.some((g) => g.verb === 'auction' || g.verb === 'buy'), `${name}:${s.line} ${s.title}: a gather step with a buy row`);
		}
	}
	const smith = read('blacksmithing');
	assert.match(smith, /^ {2}collect 2835 x\d+ gather Mining 1\n(?: {2}loop [^\n]+\n)+ {2}auction 2835 x\d+$/m, 'Blacksmithing still offers Rough Stone at the Auction House');
});

// Fitz's in-game test (Mining, 'Cast Find Minerals'): a row that has the player cast a spell says where the spell
// is: profession spells in the Professions tab (K), Pick Lock in the Spellbook (P). Every profession guide, the
// paired ones included.
test('every step that casts a spell says where the spell is (Professions tab, or Spellbook for a class spell)', () => {
	const { spellWhere, PROFESSIONS_TAB, SPELLBOOK } = require('../tools/lib/professions/describe');
	const dir = path.join(ROOT, 'guides', 'forever', 'professions');
	let seen = 0;
	for (const file of fs.readdirSync(dir).filter((f) => f.endsWith('.guide'))) {
		const lines = fs.readFileSync(path.join(dir, file), 'utf8').split('\n');
		lines.forEach((l, i) => {
			if (!l.startsWith('step ')) return;
			const goals = [];
			for (let j = i + 1; j < lines.length && /^ {2}\S/.test(lines[j]); j++) goals.push(lines[j]);
			const title = l.slice(5);
			const where = spellWhere(title.split(' · ')[0], goals);
			if (!where) return;
			seen++;
			assert.ok(title.includes(where), `${file}:${i + 1} ${title}: the row does not say where the spell is (${where})`);
		});
	}
	assert.ok(seen > 50, `spell steps found (${seen})`);
	assert.match(read('mining'), new RegExp(`^step Turn on Find Minerals · ${PROFESSIONS_TAB.replace(/[()]/g, '\\$&')}$`, 'm'));
	if (exists('lockpicking')) assert.ok(read('lockpicking').includes(`· Pick Lock: ${SPELLBOOK}`));
});
