'use strict';
// A crafting profession guide from its curated route (routes/<profession>.json; docs/forge/professions.md,
// "Route files"): the bands to craft (from, to, recipe, count, materials), the trainers of each rank's
// section, the tools and where they are sold, the forks where plans from the Auction House or a quest open
// a cheaper way, and how each material is got. The facts are checked against data/forever when the guide is
// built (checkRoute): every recipe, its reagents times the count, every trainer, vendor and quest.
//
// Steps, one action each, each with its place, its count and what finishes it (written for a player who has
// never levelled a profession):
//   Learn <Profession>            train <Profession> Apprentice (the nearest trainer)
//   Buy a <tool>                  buy <tool> x1 nearest, where the route says (at the first trainer visit)
//   Buy N <vendor good>           buy <item> xN nearest: a section's vendor goods at its first need
//   Get N <material>              the material's ways as choice rows: `collect … gather` with the gathering
//                                 guides' loops, `collect … nearest` farm spots, `auction`; sized to the
//                                 crafts up to the next trainer visit (gets of one material merge across
//                                 bands that only a recipe visit separates)
//   Train <Rank> <Profession>     train <Profession> <Rank>
//   Learn <recipe>                learn <spell> npc <the section's trainers>, or from plans in the bags
//   Go to an anvil                goto … nearest over the stations of the recipe's spell focus in towns with
//                                 the profession's trainers or tool sellers (stations.json), before a craft
//                                 that needs one, unless the step before was a craft at one
//   Craft <recipe> until N        craft <spell> x<count> until N
//   Craft N <part>                craft <spell> xN: parts made for a later band, no skill
//   Buy <plans> at the Auction House / Hand in <quest>   the way into a fork or a quest's plans
// Tips are at most one short line of why or a heads-up (TIP_MAX), never an instruction: every action is a
// step or a goal.

const fs = require('node:fs');
const path = require('node:path');
const D = require('./describe');

const DIR = path.join(__dirname, 'routes');
const SIDES = ['Alliance', 'Horde'];
const RANKS = ['Apprentice', 'Journeyman', 'Expert', 'Artisan'];
// A tip is one short line (docs/forge/professions.md, rule 8); longer ones fail the build.
const TIP_MAX = 120;
// Words that make a tip an instruction (an action belongs in a step or a goal).
const IMPERATIVE = /\b(buy|go to|learn|talk to|train|travel to|head to|visit|pick up|open)\b/i;
// A station within this many yards of a trainer of the profession or a seller of its tool is the town's.
const TOWN_YARDS = 120;
// One station per this many yards (a town has one candidate).
const STATION_SPREAD = 250;

const slug = (name) => String(name).toLowerCase().replace(/[^a-z0-9]+/g, '-');

// The route file of a profession, or null.
function loadRoute(name) {
	const file = path.join(DIR, `${slug(name)}.json`);
	return fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null;
}

// Every band of a route, in order, with the section and fork way it is in: [{ band, section, way, fork }].
function bandsOf(route) {
	const out = [];
	const walk = (list, section, way, fork) => {
		for (const x of list) {
			if (x.fork) x.ways.forEach((w, i) => walk(w.route, section, i, x));
			else out.push({ band: x, section, way, fork });
		}
	};
	for (const s of route.sections) walk(s.route, s, null, null);
	return out;
}

// Throws on any fact the route states that the data does not bear out.
function checkRoute(route, prof, data) {
	const errs = [];
	const recipes = new Map((prof.recipes || []).map((r) => [r.spell, r]));
	const items = data.items || {};
	const npcs = data.npcs || {};
	const quests = data.quests || {};
	const sideOk = (npc, side) => !npc.faction || npc.faction === 'AH' || npc.faction === side[0];
	const sells = (vendor, item) => ((items[item] || {}).vendors || []).includes(vendor);
	for (const t of route.tools || []) {
		for (const side of SIDES) {
			for (const v of (t.vendors || {})[side] || []) {
				if (!npcs[v]) errs.push(`tool ${t.item}: vendor ${v} is not in npcs.json`);
				else if (!sells(v, t.item)) errs.push(`tool ${t.item}: ${npcs[v].name} does not sell it`);
				else if (!sideOk(npcs[v], side)) errs.push(`tool ${t.item}: ${npcs[v].name} does not serve the ${side}`);
			}
		}
	}
	const known = new Set([...(prof.trainers ? SIDES.flatMap((s) => prof.trainers[s] || []) : []), ...(prof.ranks || []).flatMap((r) => SIDES.flatMap((s) => (r.trainers || {})[s] || []))]);
	for (const sec of route.sections) {
		if (!RANKS.includes(sec.rank)) errs.push(`section ${sec.from}-${sec.to}: unknown rank ${sec.rank}`);
		const rank = (prof.ranks || []).find((r) => r.name === sec.rank);
		if (rank && rank.minLevel && sec.level !== rank.minLevel) errs.push(`${sec.rank}: level ${sec.level}, the data says ${rank.minLevel}`);
		for (const side of SIDES) {
			for (const id of sec.teachers[side] || []) {
				const n = npcs[id];
				if (!n) errs.push(`${sec.rank}: trainer ${id} is not in npcs.json`);
				else if (!known.has(id)) errs.push(`${sec.rank}: ${n.name} trains no ${prof.name} in the data`);
				else if (!sideOk(n, side)) errs.push(`${sec.rank}: ${n.name} does not serve the ${side}`);
			}
		}
	}
	for (const [item, side] of Object.entries(route.vendors || {}).flatMap(([i, by]) => SIDES.map((s) => [[i, by[s] || []], s]))) {
		for (const v of item[1]) if (!sells(v, Number(item[0]))) errs.push(`item ${item[0]}: ${(npcs[v] || {}).name || v} does not sell it (${side})`);
	}
	for (const { band } of bandsOf(route)) {
		const spell = band.recipe || band.make;
		const r = recipes.get(spell);
		const at = band.make ? `make ${spell}` : `${band.from}-${band.to}`;
		if (!r) {
			errs.push(`${at}: recipe ${spell} is not ${prof.name}'s`);
			continue;
		}
		const want = {};
		for (const g of r.reagents || []) want[g.item] = g.count * band.count;
		const got = band.mats || {};
		for (const k of new Set([...Object.keys(want), ...Object.keys(got)])) {
			if (want[k] !== got[k]) errs.push(`${at} ${r.name}: ${band.count} crafts take ${want[k] || 0} of item ${k}, the route says ${got[k] || 0}`);
		}
		if (band.recipe && Number(r.learnedAt) > band.from) errs.push(`${at} ${r.name}: learned at ${r.learnedAt}, after the band starts`);
		if (band.recipe && Number(r.grey) > 0 && Number(r.grey) <= band.from && !(route.colours || {})[spell]) errs.push(`${at} ${r.name}: grey at ${r.grey} in the data; give its colour in \`colours\` with the evidence`);
		for (const q of band.quests || []) if (!quests[q]) errs.push(`${at}: quest ${q} is not in quests.json`);
		for (const k of Object.keys(got)) {
			const ways = (route.materials || {})[k];
			if (!ways && !recipes.has(madeHere(prof, Number(k)))) errs.push(`${at}: material ${k} has no ways in \`materials\``);
			if (ways && ways.includes('auction') && (items[k] || {}).bop) errs.push(`material ${k} binds when picked up: no Auction House way`);
			if (ways && ways.includes('vendor') && !((items[k] || {}).vendors || []).length) errs.push(`material ${k}: no vendor sells it`);
		}
	}
	if (errs.length) throw new Error(`${prof.name} route (tools/lib/professions/routes/${slug(prof.name)}.json):\n  ${errs.join('\n  ')}`);
}

// The recipe of this profession that makes `item` (a grinding stone), or undefined.
function madeHere(prof, item) {
	const r = (prof.recipes || []).find((x) => x.item === item);
	return r ? r.spell : undefined;
}

// World yards of a zone point: [continent, x, y], or null on a map without a frame.
function worldOf(frames, map, x, y, f) {
	const fr = (f === 'l' ? frames.forever : frames.era)?.[map] || frames.era?.[map];
	if (!fr) return null;
	return [fr.c, fr.top + ((fr.bottom - fr.top) * y) / 100, fr.left + ((fr.right - fr.left) * x) / 100];
}

// The stations of a spell focus a profession's player is sent to: one per town that has a trainer of the
// profession or a seller of one of its tools, each for the factions that town serves.
// -> [{ map, x, y, f, side: 'Alliance'|'Horde'|null }]
function stationPlaces(focus, prof, route, data) {
	const ids = require('./stations').load()[focus];
	if (!ids) throw new Error(`no stations of "${focus}" in tools/lib/professions/stations.json (profession stations)`);
	const frames = data.mapFrames || {};
	const npcs = data.npcs || {};
	const anchors = [];
	const trainerIds = new Set([...SIDES.flatMap((s) => (prof.trainers || {})[s] || []), ...(prof.ranks || []).flatMap((r) => SIDES.flatMap((s) => (r.trainers || {})[s] || []))]);
	const toolIds = new Set((route.tools || []).flatMap((t) => (data.items[t.item] || {}).vendors || []));
	for (const id of new Set([...trainerIds, ...toolIds])) {
		const n = npcs[id];
		for (const [map, s] of Object.entries((n && n.spawns) || {})) {
			for (const p of s.pts || []) {
				const w = worldOf(frames, map, p[0], p[1], s.f);
				if (w) anchors.push({ w, faction: n.faction || 'AH' });
			}
		}
	}
	const found = [];
	for (const id of ids) {
		const o = (data.objects || {})[id];
		for (const [map, s] of Object.entries((o && o.spawns) || {})) {
			for (const p of s.pts || []) {
				const w = worldOf(frames, map, p[0], p[1], s.f);
				if (!w) continue;
				const near = anchors.filter((a) => a.w[0] === w[0] && Math.hypot(a.w[1] - w[1], a.w[2] - w[2]) <= TOWN_YARDS);
				if (!near.length) continue;
				const f = new Set(near.map((a) => a.faction));
				const side = f.has('A') && !f.has('H') ? 'Alliance' : f.has('H') && !f.has('A') ? 'Horde' : null;
				found.push({ map: Number(map), x: Math.round(p[0] * 10) / 10, y: Math.round(p[1] * 10) / 10, f: s.f === 'l' ? 'l' : 'e', side, w, near: near.length });
			}
		}
	}
	// One per town: the station with the most of its town's trainers and sellers near it.
	found.sort((a, b) => b.near - a.near || a.map - b.map || a.x - b.x || a.y - b.y);
	const kept = [];
	for (const s of found) if (!kept.some((k) => k.w[0] === s.w[0] && Math.hypot(k.w[1] - s.w[1], k.w[2] - s.w[2]) < STATION_SPREAD)) kept.push(s);
	kept.sort((a, b) => a.map - b.map || a.x - b.x || a.y - b.y);
	return kept.map(({ map, x, y, f, side }) => ({ map, x, y, f, side }));
}

function routeGuide(name, data, opts = {}) {
	const { itemLoops } = require('./guide');
	const profs = data.professions || {};
	const prof = Object.values(profs).find((p) => p && String(p.name).toLowerCase() === String(name).toLowerCase());
	const route = opts.route || loadRoute(prof.name);
	checkRoute(route, prof, data);
	const P = prof.name;
	const pq = /\s/.test(P) ? `"${P}"` : P;
	const recipes = new Map((prof.recipes || []).map((r) => [r.spell, r]));
	const items = data.items || {};
	const mats = prof.materials || {};
	const itemName = (id) => (mats[id] || items[id] || {}).name || `item ${id}`;
	const recipeName = (spell) => recipes.get(spell).name;
	const quests = data.quests || {};
	const mines = (profs[186] || {}).recipes || [];
	const tipOf = (text) => {
		if (!text) return null;
		if (text.length > TIP_MAX) throw new Error(`${P}: a tip over ${TIP_MAX} characters: "${text}"`);
		if (IMPERATIVE.test(text)) throw new Error(`${P}: a tip that tells the player to do something (make it a step): "${text}"`);
		return text;
	};
	const stations = new Map();
	const stationLines = (focus) => {
		if (!stations.has(focus)) stations.set(focus, stationPlaces(focus, prof, route, data));
		return stations.get(focus).map((s) => `  goto ${s.x},${s.y} "${focus}" map ${s.map} ${s.f === 'l' ? 'live ' : ''}nearest${s.side ? ` only ${s.side}` : ''}`);
	};
	const article = (w) => (/^[aeiou]/i.test(w) ? 'an' : 'a');

	// ---------------------------------------------------------------- material ways
	// The gathering loops that give `item`: { skill, prof, lines }, or null. A bar Mining smelts takes the loops of
	// its ore (Bronze Bar: the scarcer of Copper and Tin; Steel Bar: Iron Ore, the Coal bought).
	// Where an item is gathered: the `gather` of any profession's materials table (an ore is Mining's).
	const mined = (id) => Object.values(profs).some((p) => (((p.materials || {})[id] || {}).gather || {}).mine);
	const loopsFor = (item) => {
		const m = mats[item] || {};
		const it = items[item] || {};
		const name = m.name || it.name || '';
		const g = m.gather || it.gather || {};
		if (g.herb) {
			const l = itemLoops(data, item);
			return l && { ...l, prof: 'Herbalism' };
		}
		if (g.mine) {
			const l = itemLoops(data, item);
			return l && { ...l, prof: 'Mining' };
		}
		if (/(Leather|Hide|Scale)$/.test(name)) {
			const l = itemLoops(data, item);
			return l && { ...l, prof: 'Skinning' };
		}
		const smelt = mines.find((r) => r.item === item);
		if (!smelt) return null;
		const tries = [];
		for (const rg of smelt.reagents || []) {
			const ore = mined(rg.item) ? rg.item : null;
			if (ore) {
				tries.push({ ore, per: (smelt.itemCount || 1) / rg.count, rank: smelt.learnedAt || 1 });
				continue;
			}
			const sub = mines.find((r) => r.item === rg.item);
			const subOre = sub && (sub.reagents || []).find((x) => mined(x.item));
			if (subOre) tries.push({ ore: subOre.item, per: ((smelt.itemCount || 1) / rg.count) * ((sub.itemCount || 1) / subOre.count), rank: Math.max(smelt.learnedAt || 1, sub.learnedAt || 1) });
		}
		const found = tries.map((t) => ({ t, l: itemLoops(data, t.ore, t.per) })).filter((x) => x.l);
		if (!found.length) return null;
		found.sort((a, b) => a.l.lines.length - b.l.lines.length || a.t.ore - b.t.ore);
		const { t, l } = found[0];
		return { lines: l.lines, skill: Math.max(l.skill, t.rank), prof: 'Mining', smelt };
	};
	// The goal lines of a Get step: the ways of `materials`, in order.
	const getLines = (item, count) => {
		const ways = route.materials[item];
		const out = [];
		for (const way of ways) {
			if (way === 'gather') {
				const l = loopsFor(item);
				if (!l) throw new Error(`${P}: no gathering loop gives ${itemName(item)}`);
				out.push(`  collect ${item} x${count} gather ${l.prof} ${l.skill}`, ...l.lines);
			} else if (way === 'drop') {
				const f = data.farmable ? data.farmable(item) : null;
				const lv = D.CLOTH_LEVELS[itemName(item)];
				const lo = f ? Math.min(...SIDES.map((s) => f[s]).filter((x) => x != null)) : null;
				if (!lv && !(f && Number.isFinite(lo))) throw new Error(`${P}: no farm spot for ${itemName(item)}`);
				const levels = lv ? `${lv[0]}-${lv[1]}` : `${lo}-${Math.max(lo + 1, f.top || 0)}`;
				out.push(`  collect ${item} x${count} nearest gather levels ${levels}`);
			} else if (way === 'auction') {
				out.push(`  auction ${item} x${count}`);
			} else if (way === 'disenchant') {
				// The disenchant way: green armour of these "Requires Level"s breaks into it (the window's row).
				const t = D.disenchantLevels(itemName(item));
				if (!t) throw new Error(`${P}: ${itemName(item)} is not a disenchanted material`);
				out.push(`  collect ${item} x${count} anywhere gather Enchanting 1 levels ${t.min}-${t.max}`);
			} else if (way === 'vendor') {
				out.push(`  buy ${item} x${count} nearest`);
			} else throw new Error(`${P}: unknown way "${way}" for ${itemName(item)}`);
		}
		return out;
	};

	// ---------------------------------------------------------------- walk
	const out = [];
	const blocks = []; // { kind, lines, when, band?, items? } for pairs.js
	const segments = [];
	const materials = [];
	let when = []; // the current fork way's `when` lines
	let lastKind = null;
	let forks = 0;
	let curWay = null; // the fork way a step is on ("<fork>:<way>"), for pairs.js
	let lastFocus = null;
	const step = (kind, title, { tip, lines = [], extra = {}, also = [] } = {}) => {
		const t = tipOf(tip);
		const text = [`step ${title}`, ...[...when, ...also].map((w) => `  when ${w}`), ...(t ? [`  tip ${t}`] : []), ...lines];
		out.push('', ...text);
		blocks.push({ kind, title, lines: text, when: [...when, ...also], way: curWay, ...extra });
		lastKind = kind;
		if (kind !== 'craft' && kind !== 'station') lastFocus = null;
	};
	// A band's steps after its gets: the recipe (a quest's plans after the hand-in), the quests, the craft. A
	// fork way keyed on plans in the bags holds on the recipe known once it is learned (`afterLearn`).
	let afterLearn = null;
	const bandSteps = (b, sec) => {
		const fromQuest = b.recipe && recipes.get(b.recipe).recipeItem && (b.quests || []).length;
		if (b.recipe && !fromQuest) learnStep(b, sec);
		questSteps(b, sec);
		if (fromQuest) learnStep(b, sec);
		if (afterLearn && afterLearn.spell === b.recipe) {
			when = afterLearn.when;
			afterLearn = null;
		}
		craftStep(b, sec);
	};
	const learned = new Set();
	const done = new Set(); // quests handed in on every way so far
	const maybe = new Set(); // ... on some ways
	const stock = new Map(); // parts made earlier (grinding stones)
	const tools = new Set();
	let level = 1;

	const learnStep = (band, sec) => {
		const r = recipes.get(band.recipe);
		if (learned.has(r.spell)) return;
		learned.add(r.spell);
		if (r.recipeItem) {
			step('learn', `Learn ${r.name}`, { tip: 'From the plans in your bags.', lines: [`  learn ${r.spell}`] });
			return;
		}
		const ids = [...new Set(SIDES.flatMap((s) => sec.teachers[s] || []))];
		step('learn', `Learn ${r.name}`, { lines: [`  learn ${r.spell} npc ${ids.join(',')}`] });
	};
	const craftStep = (band, sec) => {
		const r = recipes.get(band.recipe || band.make);
		if (r.focus && !(lastKind === 'craft' && lastFocus === r.focus) && !(lastKind === 'station' && lastFocus === r.focus)) {
			step('station', `Go to ${article(r.focus)} ${r.focus.toLowerCase()}`, { lines: stationLines(r.focus) });
			lastFocus = r.focus;
		}
		for (const [k, n] of Object.entries(band.mats)) {
			if (madeHere(prof, Number(k)) === undefined) continue;
			const have = stock.get(Number(k)) || 0;
			if (have < n) throw new Error(`${P}: ${band.from || 'make'}-${band.to || ''} ${r.name} uses ${n} ${itemName(k)}, the bags hold ${have}`);
			stock.set(Number(k), have - n);
		}
		// The craft's count for the window ("about N crafts"), then its keep or heads-up line when both fit.
		const about = band.make ? null : `About ${band.count} crafts.`;
		const own = band.keep || band.note || (band.make ? `Parts for ${band.for}; no skill points from these.` : null);
		const tip = about && own ? (`${about} ${own}`.length <= TIP_MAX ? `${about} ${own}` : own) : about || own;
		if (band.make) {
			step('make', `Craft ${D.crafts(band.count, r.name)}`, { tip, lines: [`  craft ${r.spell} x${band.count}`], extra: { band } });
		} else {
			step('craft', `Craft ${D.crafts(band.count, r.name)} until ${band.to}`, { tip, lines: [`  craft ${r.spell} until ${band.to}`], extra: { band } });
			segments.push({ from: band.from, to: band.to, recipe: r, count: band.count, count90: band.count, need: Object.entries(band.mats).filter(([k]) => madeHere(prof, Number(k)) === undefined).map(([k, n]) => ({ item: Number(k), count: n })), make: [], tools: [], when: when.slice() });
		}
		lastFocus = r.focus || null;
		if (r.item) stock.set(r.item, (stock.get(r.item) || 0) + band.count * (r.itemCount || 1));
	};
	const questSteps = (band, sec) => {
		for (const q of band.quests || []) {
			const quest = quests[q];
			if (quest.minLevel > level) {
				step('level', `Reach level ${quest.minLevel}`, { tip: `${quest.title} asks for level ${quest.minLevel}.`, lines: [`  level ${quest.minLevel}`] });
				level = quest.minLevel;
			}
			// A hand-in straight from the giver's window takes its items from the bags: the step waits for them.
			const asks = (quest.objectives || []).filter((o) => o.type === 'item').map((o) => `has ${o.id} x${o.count}`);
			step('quest', `Hand in ${quest.title}`, { lines: [`  turnin ${q}${quest.direct ? ' direct' : ''}`], also: quest.direct ? asks : [] });
			done.add(q);
		}
	};
	// The items a band's quests ask to be handed in (Thorium Bars for plans): item -> { n }, for the quests not
	// handed in on every way here (after a fork, a way that already handed one in keeps a few spare bars).
	const questItems = (band) => {
		const need = new Map();
		for (const q of band.quests || []) {
			if (done.has(q) && !maybe.has(q)) continue;
			for (const o of quests[q].objectives || []) {
				if (o.type === 'item') need.set(o.id, (need.get(o.id) || 0) + o.count);
			}
		}
		return need;
	};
	const vendorOnly = (k) => {
		const w = route.materials[k];
		return !!w && w.length === 1 && w[0] === 'vendor';
	};
	// One Get step per material a group of bands needs (vendor goods are a section's; parts come from the bags).
	const getSteps = (group) => {
		const need = new Map(); // item -> { n }
		const add = (k, n) => need.set(k, { n: ((need.get(k) || {}).n || 0) + n });
		for (const b of group) {
			for (const [k, n] of Object.entries(b.mats)) if (route.materials[k] && !vendorOnly(k)) add(Number(k), n);
			for (const [k, n] of questItems(b)) add(k, n);
		}
		for (const [item, e] of need) {
			const withSmelt = route.smelt && route.smelt[item];
			for (const [v, per] of Object.entries((withSmelt && withSmelt.with) || {})) {
				step('buy', `Buy ${e.n * per} ${itemName(v)}`, { tip: `Smelting ${itemName(item)} takes ${per} ${itemName(v)} a bar.`, lines: [`  buy ${v} x${e.n * per} nearest`], also: [`skill Mining ${withSmelt.skill}`] });
			}
			const bar = !!(loopsFor(item) || {}).smelt;
			step('get', `Get ${e.n} ${itemName(item)}`, { tip: forWhat(group, item, bar), lines: getLines(item, e.n), extra: { items: [{ item, count: e.n }], bands: group } });
		}
	};
	// A get's why line: the crafts it is for (each recipe once), and the plans a quest hands over for it.
	const forWhat = (group, item, bar) => {
		const by = new Map();
		for (const b of group) if (b.mats[item]) by.set(b.recipe || b.make, (by.get(b.recipe || b.make) || 0) + b.count);
		const uses = [...by].map(([spell, n]) => D.crafts(n, recipeName(spell)));
		const quest = group.some((b) => (b.quests || []).some((q) => (quests[q].objectives || []).some((o) => o.id === item)));
		let text = `For ${D.list([...uses, ...(quest ? ['the plans'] : [])])}.`;
		if (text.length > TIP_MAX) text = `For the crafts to ${group[group.length - 1].to}.`;
		const extra = bar ? ' No Mining? The bars, not the ore.' : '';
		return text.length + extra.length <= TIP_MAX ? text + extra : text;
	};
	// A list's vendor goods, bought at one stop before its first craft.
	const vendorSteps = (list) => {
		const need = new Map();
		for (const b of list) for (const [k, n] of Object.entries(b.mats)) if (vendorOnly(k)) need.set(Number(k), (need.get(Number(k)) || 0) + n);
		for (const [item, n] of need) step('buy', `Buy ${n} ${itemName(item)}`, { tip: forWhat(list, item, false), lines: [`  buy ${item} x${n} nearest`] });
	};
	// Bands into groups that share one get: consecutive bands whose gathered material is one and the same, and
	// parts crafted for a band (`make`) with that band.
	const groups = (list) => {
		const gathered = (b) => Object.keys(b.mats).filter((k) => route.materials[k] && !vendorOnly(k)).join();
		const out2 = [];
		let parts = [];
		for (const b of list) {
			if (b.make) {
				parts.push(b);
				continue;
			}
			const g = out2[out2.length - 1];
			const a = gathered(b);
			if (!parts.length && g && !(b.quests || []).length && !a.includes(',') && g.every((x) => !x.make && gathered(x) === a)) g.push(b);
			else out2.push([...parts, b]);
			parts = [];
		}
		if (parts.length) out2.push(parts);
		return out2;
	};
	let lastSection = null;
	const section = (from, to) => {
		const key = `${from}-${to}`;
		if (lastSection === key) return;
		lastSection = key;
		out.push('', `section ${pq} ${from}-${to}`);
		blocks.push({ kind: 'section', from, to, lines: [`section ${pq} ${from}-${to}`] });
	};
	const trainStep = (sec) => {
		if (sec.rank === 'Apprentice') {
			step('train', `Learn ${P}`, { tip: 'No character level needed.', lines: [`  train ${pq} Apprentice`] });
			// The recipes the rank teaches with it (Rough Sharpening Stone: learned at 1, free).
			for (const r of recipes.values()) if (r.source === 'trainer' && Number(r.learnedAt) <= 1 && !r.cost) learned.add(r.spell);
			for (const t of route.tools || []) {
				if (t.at !== 'learn' || tools.has(t.item)) continue;
				tools.add(t.item);
				step('tool', `Buy ${article(itemName(t.item))} ${itemName(t.item)}`, { tip: 'A tool: it stays in your bags, and most recipes need it.', lines: [`  buy ${t.item} x1 nearest`] });
			}
		} else {
			step('train', `Train ${sec.rank} ${P}`, { tip: sec.level > level ? `Needs level ${sec.level}.` : null, lines: [`  train ${pq} ${sec.rank}`] });
		}
		level = Math.max(level, sec.level);
		trained.add(sec.rank);
	};
	const trained = new Set();
	// A list of bands in order, a section per group: the vendor goods, then per group its gets, the rank when it
	// is due (after the first gets, so one trip to the trainer trains it and learns the recipe; Apprentice first),
	// the learns, quests, stations and crafts.
	const runList = (sec, list) => {
		groups(list).forEach((g, i) => {
			const real = g.filter((b) => !b.make);
			if (real.length) section(real[0].from, real[real.length - 1].to);
			if (!trained.has(sec.rank) && sec.rank === 'Apprentice') trainStep(sec);
			if (i === 0) vendorSteps(list);
			getSteps(g);
			if (!trained.has(sec.rank)) trainStep(sec);
			for (const b of g) bandSteps(b, sec);
		});
	};

	for (const sec of route.sections) {
		const plain = [];
		for (const x of sec.route) {
			if (!x.fork) {
				plain.push(x);
				continue;
			}
			if (plain.length) runList(sec, plain.splice(0));
			runFork(sec, x);
		}
		if (plain.length) runList(sec, plain.splice(0));
	}

	// A fork: the rank if due, each way's plans bought at the Auction House when listed (or "none listed"),
	// learned now where the skill allows; then each way's bands, each step holding while its way does: the plans
	// known (or, learned later, in the bags), the earlier ways' not. Each way's sections start again at the fork.
	function runFork(sec, fork) {
		forks++;
		const first = fork.ways[0].route.find((b) => !b.make);
		const from = first.from;
		section(from, groups(fork.ways[0].route)[0].filter((b) => !b.make).slice(-1)[0].to);
		if (!trained.has(sec.rank)) trainStep(sec);
		const keys = fork.ways.map((w) => (w.plans ? recipesOfPlans(w.plans) : null));
		fork.ways.forEach((w) => {
			for (const p of w.plans || []) step('plans', `Buy ${itemName(p)} at the Auction House`, { tip: w.why, lines: [`  auction ${p} x1 either`, '  task "None listed, or too dear" either'] });
		});
		fork.ways.forEach((w, i) => {
			for (const r of keys[i] || []) {
				if (Number(r.learnedAt) > from) continue;
				step('learn', `Learn ${r.name}`, { tip: 'From the plans in your bags.', lines: [`  learn ${r.spell}`], also: [`has ${r.recipeItem}`] });
				learned.add(r.spell);
			}
		});
		const before = { learned: new Set(learned), done: new Set(done), maybe: new Set(maybe), stock: new Map(stock), level };
		const reset = (to, s) => {
			to.clear();
			for (const x of s) Array.isArray(x) ? to.set(x[0], x[1]) : to.add(x);
		};
		let after = null;
		const doneSets = [];
		fork.ways.forEach((w, i) => {
			reset(learned, before.learned);
			reset(done, before.done);
			reset(maybe, before.maybe);
			reset(stock, before.stock);
			level = before.level;
			const conds = [];
			for (let j = 0; j < i; j++) {
				const r = (keys[j] || [])[0];
				if (!r) continue;
				if (Number(r.learnedAt) <= from) conds.push(`!knows ${r.spell}`);
				else conds.push(`!has ${r.recipeItem}`, `!knows ${r.spell}`);
			}
			const own = (keys[i] || [])[0];
			const lateKey = own && Number(own.learnedAt) > from ? own : null;
			const ownWhen = own ? (lateKey ? `has ${own.recipeItem}` : `knows ${own.spell}`) : null;
			when = [...conds, ...(ownWhen ? [ownWhen] : [])];
			if (lateKey) afterLearn = { spell: lateKey.spell, when: [...conds, `knows ${own.spell}`] };
			if (i > 0) lastSection = null;
			curWay = `${forks}:${i}`;
			runList(sec, w.route);
			afterLearn = null;
			doneSets.push(new Set(done));
			if (i === 0) after = { learned: new Set(learned), stock: new Map(stock), level };
		});
		when = [];
		curWay = null;
		// After the fork: a quest every way handed in is done; one some ways did may be (its get comes in two).
		const every = [...doneSets[0]].filter((q) => doneSets.every((s) => s.has(q)));
		const some = new Set(doneSets.flatMap((s) => [...s]));
		reset(done, some);
		reset(maybe, [...some].filter((q) => !every.includes(q)));
		reset(learned, after.learned);
		reset(stock, after.stock);
		level = after.level;
		lastSection = null;
	}

	function recipesOfPlans(plans) {
		return plans.map((p) => [...recipes.values()].find((r) => r.recipeItem === p)).filter(Boolean);
	}

	// ---------------------------------------------------------------- header
	for (const sec of route.sections) {
		const list = bandsOf({ sections: [sec] }).filter((x) => x.way === null || x.way === 0).map((x) => x.band);
		const tally = new Map();
		for (const b of list) for (const [k, n] of Object.entries(b.mats)) if (madeHere(prof, Number(k)) === undefined) tally.set(Number(k), (tally.get(Number(k)) || 0) + n);
		materials.push({ from: sec.from, cap: sec.to, items: [...tally].filter(([k]) => !(route.materials[k].length === 1 && route.materials[k][0] === 'vendor')).map(([item, count]) => ({ item, name: itemName(item), count, uses: [] })) });
	}
	const { header } = require('../generated');
	const head = [
		header('guide', `profession draft ${P} --out`, `tools/lib/professions/routes/${slug(P)}.json and data/forever`),
		`guide forever/professions/${slug(P)}`,
		`title ${P} 1-300`,
		'category Professions',
		'levels 5-60',
		'zone Azeroth',
		'',
		...(route.intro || []).flatMap((p, i) => [...(i ? ['#'] : []), ...comment(p)]),
		'#',
		...routeTable(route, recipes, itemName),
	];
	const text = `${[...head, ...out].join('\n').replace(/\n{3,}/g, '\n\n').replace(/\n+$/, '')}\n`;
	const plan = { profession: prof, segments, total: 0, reach: 300 };
	return { text, plan, alt: null, materials, blocks, route };
}

// The header's comment lines: the route, band by band, with each way of a fork.
function routeTable(route, recipes, itemName) {
	const lines = ['# The route (crafts are about what it takes; yellow and green recipes can take a few more):'];
	const band = (b, pad) => {
		const r = recipes.get(b.recipe || b.make);
		const mats = Object.entries(b.mats).map(([k, n]) => `${n} ${itemName(k)}`).join(', ');
		return b.make ? `#${pad}  make ${b.count} ${r.name}: ${mats}` : `#${pad}  ${String(b.from).padStart(3)}-${String(b.to).padEnd(3)} ${b.count} ${r.name}: ${mats}`;
	};
	for (const s of route.sections) {
		lines.push(`# ${s.rank} (${s.from}-${s.to}), from level ${s.level}:`);
		for (const x of s.route) {
			if (!x.fork) lines.push(band(x, ''));
			else {
				for (const w of x.ways) {
					lines.push(`#   ${w.plans ? `with ${w.plans.map(itemName).join(' and ')}` : `${w.name} (no plans)`}:`);
					for (const b of w.route) lines.push(band(b, '  '));
				}
			}
		}
	}
	return lines;
}

// A paragraph as `#` comment lines of at most 100 characters.
function comment(text) {
	const out = [];
	let cur = '#';
	for (const w of text.split(' ')) {
		if (`${cur} ${w}`.length > 100 && cur !== '#') {
			out.push(cur);
			cur = `# ${w}`;
		} else cur = `${cur} ${w}`;
	}
	if (cur !== '#') out.push(cur);
	return out;
}

module.exports = { loadRoute, checkRoute, routeGuide, stationPlaces, bandsOf, TIP_MAX, IMPERATIVE };
