'use strict';
// Patterns behind player-reported guide bugs, checked across every guide so a
// route refresh cannot bring them back anywhere: a giver beside the spawn
// passed by (#73), class letters handed in with nothing to train (#103),
// "Click X" on something you cast or /sit at (#92, #100), a click hidden
// behind the field goals it is done among (#102), and a bought item the route
// never buys (#88). tests/guides-reported.test.js pins each report itself.
// Every test names all its offenders as guide:line.
//
// Needs data/forever (node tools/polestar.js data build); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { needs } = require('./helpers/data');
const { officialGuides, stepGroups } = require('./helpers/guide-engine');
const { worldPoint } = require('../tools/lib/dsl/heights');

const skip = needs('quests.json', 'npcs.json', 'objects.json', 'items.json', 'map-frames.json', 'trainers.json', 'races.json');

const RACE_NAMES = { NightElf: 'Night Elf', Scourge: 'Undead' };
const className = (cls) => cls[0] + cls.slice(1).toLowerCase();
const who = (race, faction, cls, level) => ({ race, raceName: RACE_NAMES[race] || race, faction, cls, className: className(cls), level });

// A goal's "guide:line".
const where = (guide, goal) => `${guide.id}:${goal._line}`;

// The guide's goals in order, as { step, goal, s (1-based step), g (1-based goal in its step), i }.
function flat(guide) {
	const out = [];
	guide.steps.forEach((step, s) => step.goals.forEach((goal, g) => out.push({ step, goal, s: s + 1, g: g + 1, i: out.length })));
	return out;
}

// Whether an `only` ({ races, classes, factions }) admits the character, as
// Guides.Matches reads it: a `!` entry excludes, plain entries must name it.
function listOk(list, v) {
	if (!Array.isArray(list) || !list.length) return true;
	let positive = false;
	for (const raw of list) {
		const neg = raw[0] === '!';
		const e = (neg ? raw.slice(1) : raw).toLowerCase();
		if (neg && e === v.toLowerCase()) return false;
		if (!neg) {
			positive = true;
			if (e === v.toLowerCase()) return true;
		}
	}
	return !positive;
}
const admits = (only, c) => !only || (listOk(only.classes, c.cls) && listOk(only.races, c.race) && listOk(only.factions, c.faction));
// The same for a class alone: races and sides are not looked at.
const admitsClass = (only, cls) => !only || listOk(only.classes, cls);

// Yards between two located points on one continent (the frames the sweep
// used: tools/lib/dsl/heights.js worldPoint), or Infinity.
function yards(data, a, b) {
	const pa = a.wx !== undefined ? a : worldPoint(data, a);
	const pb = b.wx !== undefined ? b : worldPoint(data, b);
	if (!pa || !pb || pa.c !== pb.c) return Infinity;
	return Math.hypot(pa.wx - pb.wx, pa.wy - pb.wy);
}
const located = (p) => p && p.map != null && p.x != null && p.y != null;

// --- 1. The first person the Engine sends a new character to stands by the spawn (#73).

// The race's spawn point (playercreateinfo) as a world point: c the
// continent, wx north, wy west.
const STARTS = [
	{ guide: 'forever/alliance/human/01-elwynn-forest', races: [['Human', 'Alliance']], spawn: { c: 0, wx: -8949.95, wy: -132.493 } },
	{ guide: 'forever/alliance/dwarf-gnome/01-dun-morogh', races: [['Dwarf', 'Alliance'], ['Gnome', 'Alliance']], spawn: { c: 0, wx: -6240.32, wy: 331.033 } },
	{ guide: 'forever/alliance/nightelf/01-teldrassil', races: [['NightElf', 'Alliance']], spawn: { c: 1, wx: 10311.3, wy: 832.463 } },
	{ guide: 'forever/horde/orc-troll/01-durotar', races: [['Orc', 'Horde'], ['Troll', 'Horde']], spawn: { c: 1, wx: -618.518, wy: -4251.67 } },
	{ guide: 'forever/horde/tauren/01-mulgore', races: [['Tauren', 'Horde']], spawn: { c: 1, wx: -2917.58, wy: -257.98 } },
	{ guide: 'forever/horde/undead/01-tirisfal-glades', races: [['Scourge', 'Horde']], spawn: { c: 0, wx: 1676.35, wy: 1677.45 } },
];
const NEAR_SPAWN_YARDS = 30;

test('every starting guide first sends a new character to a giver beside the spawn, not past one', { skip }, () => {
	const { guides, data } = officialGuides();
	const offenders = new Map();
	for (const start of STARTS) {
		const guide = guides.find((g) => g.id === start.guide);
		assert.ok(guide, `${start.guide} compiles`);
		for (const [race, faction] of start.races) {
			for (const cls of data.raceClasses(race, faction)) {
				const [view] = stepGroups(guide, data, who(race, faction, cls, 1), [1]);
				const people = view.groups.filter((grp) => grp.kind !== 'here' && grp.pending > 0 && located(grp));
				assert.ok(people.length, `${guide.id} ${race} ${cls}: step 1 has a person to go to`);
				const focused = view.groups[view.focus - 1];
				const first = focused && focused.kind !== 'here' && located(focused) ? focused : people[0];
				const nearest = people.reduce((a, b) => (yards(data, start.spawn, b) < yards(data, start.spawn, a) ? b : a));
				const apart = yards(data, first, nearest);
				if (apart <= NEAR_SPAWN_YARDS) continue;
				const line = `${guide.id}: step 1 focuses ${first.name} (${Math.round(yards(data, start.spawn, first))} yd from the spawn), ` +
					`${Math.round(apart)} yd from ${nearest.name} (${Math.round(yards(data, start.spawn, nearest))} yd from the spawn)`;
				if (!offenders.has(line)) offenders.set(line, []);
				offenders.get(line).push(`${race} ${cls}`);
			}
		}
	}
	assert.deepEqual([...offenders].map(([line, chars]) => `${line} [${chars.join(', ')}]`), []);
});

// --- 2. A class letter is handed in on a training visit (#103).

const STARTING_GUIDE = /^forever\/(alliance|horde)\/[^/]+\/01-/;

// The class trainer a `train class` goal (or a `train` at a class trainer)
// sends `cls` to: the candidate nearest where the player is then, read as the
// step's first other located goal, else the last located goal before it.
function trainerOf(data, list, at, cls, trainers) {
	const { goal, s } = list[at];
	if (!goal.class) return trainers.has(goal.npc) ? goal.npc : null;
	const cands = (goal.candidates || []).filter((c) => !c.classes || c.classes.includes(cls));
	let from = (list.find((e, k) => k !== at && e.s === s && located(e.goal)) || {}).goal || null;
	for (let i = at - 1; i >= 0 && !from; i--) if (located(list[i].goal)) from = list[i].goal;
	if (!from) return cands.length === 1 ? cands[0].npc : null;
	let best = null;
	for (const c of cands) {
		const d = yards(data, from, c);
		if (d < Infinity && (!best || d < best.d)) best = { d, npc: c.npc };
	}
	return best && best.npc;
}

// Goals within this of the trainer are one visit to him; a flight, hearth or
// boat ends the visit.
const VISIT_YARDS = 40;
const TRAVEL = new Set(['fly', 'hearth', 'boat']);

// The goals of `list` around index `at` done on the same visit as it: the run
// of goals on either side whose located ones stay within VISIT_YARDS of it.
function visit(data, list, at) {
	const here = list[at].goal;
	const near = (e) => !TRAVEL.has(e.goal.t) && (!located(e.goal) || yards(data, here, e.goal) <= VISIT_YARDS);
	let a = at;
	let b = at;
	while (a > 0 && near(list[a - 1])) a--;
	while (b < list.length - 1 && near(list[b + 1])) b++;
	return list.slice(a, b + 1);
}

// The level 1-2 class letters (sigils, scrolls, notes) that send a new
// character to the trainer (#103). Level 3-4 class quests (The Stolen Tome,
// Call of Earth) are a different visit: they come with their own spells.
test('a starting guide hands a class letter to its trainer on a training visit, or never trains there later', { skip }, () => {
	const { guides, data } = officialGuides();
	const trainers = new Map(data.classTrainers().map((t) => [t.id, t.classes]));
	const offenders = [];
	for (const guide of guides.filter((g) => STARTING_GUIDE.test(g.id))) {
		const all = flat(guide);
		for (const entry of all) {
			const { goal } = entry;
			if (goal.t !== 'turnin' || !trainers.has(goal.npc)) continue;
			const q = data.quest(goal.quest);
			if (!q || !q.classes || !(q.level >= 1 && q.level <= 2)) continue;
			for (const cls of trainers.get(goal.npc)) {
				const mine = (e) => admitsClass(e.step.only, cls) && admitsClass(e.goal.only, cls);
				if (!mine(entry)) continue;
				const trains = (e) => e.goal.t === 'train' && (e.goal.class || trainers.has(e.goal.npc)) && mine(e);
				if (all.some((e) => e.s === entry.s && trains(e))) continue;
				const list = all.filter(mine);
				const at = list.indexOf(entry);
				if (visit(data, list, at).some((e) => trains(e) && trainerOf(data, list, list.indexOf(e), cls, trainers) === goal.npc)) continue;
				const later = list.find((e, k) => e.i > entry.i && trains(e) && trainerOf(data, list, k, cls, trainers) === goal.npc);
				if (later) offenders.push(`${where(guide, goal)}: ${q.title} (${goal.quest}) handed to ${goal.npcName || goal.npc} with no training (${cls}), who trains at ${where(guide, later.goal)}`);
			}
		}
	}
	assert.deepEqual([...new Set(offenders)], []);
});

// --- 3. "Click X" only for what is clicked (#92, #100).

// An objective you do by /sit, a racial or a spell, not by clicking.
const NOT_A_CLICK = /\/sit\b|\buse your\b[^.]*\bracial\b|\bcast\b/i;
// Interacts the checks below get wrong, each with why it is a click:
// 'quest.objective': reason.
const CLICK_EXCEPTIONS = {};

test('an interact shown as "Click X" is for an object the quest has you click', { skip }, () => {
	const { guides, data } = officialGuides();
	const offenders = [];
	for (const guide of guides) {
		for (const { goal } of flat(guide)) {
			if (goal.t !== 'interact' || !goal.quest) continue;
			if (goal.text && !/^Click\b/i.test(goal.text)) continue; // its own wording, not "Click X"
			if (CLICK_EXCEPTIONS[`${goal.quest}.${goal.oi}`]) continue;
			const q = data.quest(goal.quest);
			if (!q) continue;
			const why = [];
			if (NOT_A_CLICK.test(q.objectiveText || '')) why.push(`the quest says "${(q.objectiveText.match(NOT_A_CLICK) || [])[0]}"`);
			const o = goal.oi ? (q.objectives || [])[goal.oi - 1] : null;
			if (goal.oi) {
				if (!o) why.push(`it has no objective ${goal.oi}`);
				else if (o.type === 'object' && o.id !== goal.object) why.push(`objective ${goal.oi} is object ${o.id}`);
				else if (o.type === 'item') {
					const it = data.item(o.id);
					if (!it || !it.drops || !it.drops.object || !(String(goal.object) in it.drops.object)) why.push(`objective ${goal.oi} (${o.text || o.id}) does not come from it`);
				} else if (o.type !== 'object') why.push(`objective ${goal.oi} is ${o.type === 'event' ? 'an event' : `a ${o.type}`} ("${o.text || ''}")`);
			}
			if (why.length) offenders.push(`${where(guide, goal)}: Click ${goal.objName || goal.object} for ${q.title} (${goal.quest}${goal.oi ? `.${goal.oi}` : ''}): ${why.join('; ')}`);
		}
	}
	assert.deepEqual(offenders, []);
});

// --- 4. A click done among the field goals is shown with them (#102).

// A character who can do the goal: the guide's side and races, the step's
// and the goal's `only`.
function characterFor(guide, step, goal, data) {
	for (const [race, sides] of Object.entries(data.races)) {
		for (const faction of Object.keys(sides)) {
			if (guide.faction && guide.faction !== faction) continue;
			if (guide.races && guide.races.length && !guide.races.includes(race)) continue;
			for (const cls of data.raceClasses(race, faction)) {
				const c = { race, faction, cls };
				if (admits(step.only, c) && admits(goal.only, c) && (!guide.classes || !guide.classes.length || guide.classes.includes(cls))) return c;
			}
		}
	}
	return null;
}
const spawnCount = (data, object) => data.spawns('object', object).reduce((n, s) => n + s.pts.length + s.more.length, 0);
const FIELD = new Set(['kill', 'collect']);

test('an interact for a quest objective at an object with several spawns shows with the kills and collects of its step, not in a group of its own', { skip }, () => {
	const { guides, data } = officialGuides();
	const offenders = [];
	for (const guide of guides) {
		// step -> [{ goal, g, character }]
		const cases = new Map();
		guide.steps.forEach((step, s) => {
			if (!step.goals.some((x) => FIELD.has(x.t))) return;
			step.goals.forEach((goal, g) => {
				if (goal.t !== 'interact' || !goal.quest || !goal.oi || spawnCount(data, goal.object) < 2) return;
				const c = characterFor(guide, step, goal, data);
				assert.ok(c, `${where(guide, goal)}: some character can do it`);
				if (!cases.has(s + 1)) cases.set(s + 1, []);
				cases.get(s + 1).push({ goal, g: g + 1, c });
			});
		});
		// One Engine run per character.
		const byChar = new Map();
		for (const [s, list] of cases) {
			for (const k of list) {
				const key = `${k.c.race}/${k.c.faction}/${k.c.cls}`;
				if (!byChar.has(key)) byChar.set(key, { c: k.c, steps: new Map() });
				const steps = byChar.get(key).steps;
				if (!steps.has(s)) steps.set(s, []);
				steps.get(s).push(k);
			}
		}
		for (const { c, steps } of byChar.values()) {
			const nums = [...steps.keys()];
			const views = stepGroups(guide, data, who(c.race, c.faction, c.cls, Math.max(guide.minLevel || 1, 1)), nums);
			nums.forEach((s, n) => {
				const { groups } = views[n];
				const goals = guide.steps[s - 1].goals;
				const field = (grp) => grp.goals.some((g) => FIELD.has(goals[g - 1].t));
				for (const { goal, g } of steps.get(s)) {
					const at = groups.findIndex((grp) => grp.goals.includes(g));
					const own = groups[at];
					if (!own || own.kind === 'here' || field(own)) continue;
					const named = (list) => list.flatMap((grp) => grp.goals.map((x) => goals[x - 1]).filter((x) => FIELD.has(x.t)).map((x) => `${x.t} ${x.target || x.npcName || x.itemName || x.npc || x.item}`));
					const click = `${where(guide, goal)}: Click ${goal.objName || goal.object} (${goal.quest}.${goal.oi}, ${spawnCount(data, goal.object)} spawns)`;
					const before = groups.slice(0, at).filter(field);
					const after = groups.slice(at + 1).filter(field);
					// Behind them it stays hidden until they are done (#102); ahead
					// of them it hides them until every click is done.
					if (before.length) offenders.push(`${click} waits behind ${named(before).join(', ')}`);
					else if (after.length) offenders.push(`${click} holds back ${named(after).join(', ')}`);
				}
			});
		}
	}
	assert.deepEqual(offenders, []);
});

// --- 5. An item the quest needs that only a vendor sells is bought on the way (#88).

// Items the data lists as sold that are not bought, each with why:
// item id: reason.
const VENDOR_EXCEPTIONS = {
	6265: 'Soul Shard: warlocks make their own; its one vendor is a test NPC',
	16763: 'Warsong Runner Update: handed out by the Warsong scout, whom the data lists as its vendor; the guide collects it from him',
	16764: 'Warsong Scout Update: handed out by the Warsong scout, whom the data lists as its vendor; the guide collects it from him',
	16765: 'Warsong Outrider Update: handed out by the Warsong outrider, whom the data lists as its vendor; the guide collects it from him',
};

// Sold, and dropped by nothing but the vendors themselves, from no object or container.
function vendorOnly(it) {
	if (!it || !Array.isArray(it.vendors) || !it.vendors.length) return false;
	const vendors = new Set(it.vendors.map(Number));
	const drops = it.drops || {};
	if (Object.keys(drops.object || {}).length || (it.containers || []).length) return false;
	return Object.keys(drops.npc || {}).every((npc) => vendors.has(Number(npc)));
}

test('a turn-in that needs an item only vendors sell has a buy for it, in its guide or on every route into it', { skip }, () => {
	const { guides, data } = officialGuides();
	const byId = new Map(guides.map((g) => [g.id, g]));
	const preds = new Map();
	for (const g of guides) for (const n of [].concat(g.next || [])) {
		if (!preds.has(n)) preds.set(n, []);
		preds.get(n).push(g.id);
	}
	const buys = (guide, item, before = Infinity) => flat(guide).some(({ goal, i }) => i < before && goal.t === 'buy' && goal.item === item);
	// Every guide chain leading into `id` buys it.
	const covered = (id, item, seen = new Set()) => {
		if (seen.has(id) || !byId.has(id)) return false;
		seen.add(id);
		if (buys(byId.get(id), item)) return true;
		const p = preds.get(id) || [];
		return p.length > 0 && p.every((x) => covered(x, item, new Set(seen)));
	};
	const offenders = [];
	for (const guide of guides) {
		for (const { goal, i } of flat(guide)) {
			if (goal.t !== 'turnin') continue;
			const q = data.quest(goal.quest);
			if (!q) continue;
			for (const o of q.objectives || []) {
				if (o.type !== 'item' || q.sourceItem === o.id || VENDOR_EXCEPTIONS[o.id]) continue;
				const it = data.item(o.id);
				if (!vendorOnly(it)) continue;
				if (buys(guide, o.id, i)) continue;
				const p = preds.get(guide.id) || [];
				if (p.length && p.every((x) => covered(x, o.id))) continue;
				offenders.push(`${where(guide, goal)}: ${q.title} (${goal.quest}) needs ${it.name} (${o.id}), sold by ${it.vendors.length} vendor(s), and no buy comes before it${p.length ? ` here or in every guide leading in (${p.join(', ')})` : ''}`);
			}
		}
	}
	assert.deepEqual(offenders, []);
});
