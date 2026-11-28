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
//   Train <Rank> <Profession>     train <Profession> <Rank>; a rank from a book: Buy <book> · <vendor>, Read
//                                 <book>; from a quest: Accept / Hand in <quest>; inside a dungeon: Go to
//                                 <dungeon>, Train … · <trainer> (or the trainer outside, where one is)
//   Learn <recipe>                learn <spell> npc <the section's trainers>, with every recipe a later band
//                                 of the rank uses that the skill already allows; or from plans in the bags
//   Buy <Pattern: X> · <vendor>   buy <recipe item> x1 npc <vendor>: a recipe vendors sell, before its band
//   Go to an anvil                goto … nearest over the stations of the recipe's spell focus in towns with
//                                 the profession's trainers or tool sellers (stations.json), before a craft
//                                 that needs one, unless the step before was a craft at one
//   Craft <recipe> until N        craft <spell> x<count> until N
//   Craft N <part>                craft <spell> xN: parts made for a later band, no skill; a tool the
//                                 profession makes itself (`tools` at "craft")
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
// Forever's Basic Campfire Kit: placed from the bags, it lights a cooking fire.
const CAMPFIRE_KIT = 279981;
// Stations only a camp has (a player's or a friend's, from a blueprint), never a town: a recipe that needs one
// cannot be pinned for a first-timer, so a route never crafts it.
const CAMP_STATIONS = ['Spinning Wheel', 'Loom', 'Tanning Rack', 'Sewing Machine'];

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
	// Vendors by side (`{ Alliance: [ids], Horde: [ids] }`) of `item`: each sells it and serves its side.
	const vendorsOk = (by, item, what) => {
		for (const side of SIDES) {
			for (const v of (by || {})[side] || []) {
				if (!npcs[v]) errs.push(`${what}: vendor ${v} is not in npcs.json`);
				else if (!sells(v, item)) errs.push(`${what}: ${npcs[v].name} does not sell it`);
				else if (!sideOk(npcs[v], side)) errs.push(`${what}: ${npcs[v].name} does not serve the ${side}`);
			}
		}
	};
	for (const t of route.tools || []) {
		if (t.at === 'craft') {
			if (!madeHere(prof, t.item)) errs.push(`tool ${t.item}: no ${prof.name} recipe makes it`);
		} else if (t.at === 'learn') vendorsOk(t.vendors, t.item, `tool ${t.item}`);
		else errs.push(`tool ${t.item}: \`at\` is "learn" (bought) or "craft" (made by a band), not "${t.at}"`);
	}
	for (const [item, by] of Object.entries(route.recipes || {})) {
		const what = `recipe item ${item}`;
		if (![...recipes.values()].some((r) => Number(r.recipeItem) === Number(item))) errs.push(`${what} teaches no ${prof.name} recipe`);
		for (const side of SIDES) if (!((by || {})[side] || []).length) errs.push(`${what}: no ${side} vendor`);
		vendorsOk(by, Number(item), what);
		// Several sellers go to the nearest of every one the data knows: the step names them all.
		for (const side of SIDES) {
			const ids = (by || {})[side] || [];
			if (ids.length < 2) continue;
			for (const v of (items[item] || {}).vendors || []) if (npcs[v] && sideOk(npcs[v], side) && !ids.includes(v)) errs.push(`${what}: ${npcs[v].name} sells it to the ${side} too; list every seller (the step goes to the nearest)`);
		}
	}
	// Who teaches the profession: its trainers, and the NPCs of a rank from a quest (the Triage doctors teach
	// Artisan First Aid's bandages) or the sellers of a rank's book.
	const rankNpcs = (r) => SIDES.flatMap((s) => [...((r.trainers || {})[s] || []), ...(((r.quest || {}).npcs || {})[s] || []), ...(((r.book || {}).vendors || {})[s] || [])]);
	const known = new Set([...(prof.trainers ? SIDES.flatMap((s) => prof.trainers[s] || []) : []), ...(prof.ranks || []).flatMap(rankNpcs)]);
	for (const sec of route.sections) {
		if (!RANKS.includes(sec.rank)) errs.push(`section ${sec.from}-${sec.to}: unknown rank ${sec.rank}`);
		const rank = (prof.ranks || []).find((r) => r.name === sec.rank);
		// The level a rank asks: a quest's own minimum level; a book's is the route's (the data's is Classic's
		// generic one); a trainer's the data's.
		if (sec.by && sec.by.quest) {
			for (const side of SIDES) {
				const q = quests[sec.by.quest[side]];
				if (q && q.minLevel && sec.level !== q.minLevel) errs.push(`${sec.rank}: level ${sec.level}, the ${side} quest asks ${q.minLevel}`);
			}
		} else if (!(sec.by && sec.by.book) && rank && rank.minLevel && sec.level !== rank.minLevel) errs.push(`${sec.rank}: level ${sec.level}, the data says ${rank.minLevel}`);
		for (const side of SIDES) {
			for (const id of [...(sec.teachers[side] || []), ...((sec.outside || {})[side] || [])]) {
				const n = npcs[id];
				if (!n) errs.push(`${sec.rank}: trainer ${id} is not in npcs.json`);
				else if (!known.has(id)) errs.push(`${sec.rank}: ${n.name} trains no ${prof.name} in the data`);
				else if (!sideOk(n, side)) errs.push(`${sec.rank}: ${n.name} does not serve the ${side}`);
			}
		}
		if (sec.by && sec.by.book) {
			if (!rank || !rank.book || Number(rank.book.item) !== sec.by.book) errs.push(`${sec.rank}: the data has no book ${sec.by.book} for this rank`);
			for (const side of SIDES) if (!((sec.by.vendors || {})[side] || []).length) errs.push(`${sec.rank}: no ${side} seller of the book`);
			vendorsOk(sec.by.vendors, sec.by.book, `${sec.rank} book`);
		}
		if (sec.by && sec.by.quest) {
			if (!rank || !rank.quest) errs.push(`${sec.rank}: the data has no quest for this rank`);
			for (const side of SIDES) {
				const q = sec.by.quest[side];
				if (!quests[q]) errs.push(`${sec.rank}: ${side} quest ${q} is not in quests.json`);
			}
		}
		if (sec.dungeon) {
			const inside = SIDES.flatMap((s) => (rank && rank.trainers && rank.trainers[s]) || []).filter((id) => insideOnly(npcs[id]));
			if (!inside.length) errs.push(`${sec.rank}: \`dungeon\`, but no trainer of the rank stands inside a dungeon in the data`);
		}
	}
	for (const [item, side] of Object.entries(route.vendors || {}).flatMap(([i, by]) => SIDES.map((s) => [[i, by[s] || []], s]))) {
		for (const v of item[1]) if (!sells(v, Number(item[0]))) errs.push(`item ${item[0]}: ${(npcs[v] || {}).name || v} does not sell it (${side})`);
	}
	const plans = new Set(bandsOf(route).filter((x) => x.fork).flatMap((x) => x.fork.ways.flatMap((w) => w.plans || [])));
	const tools = new Set((route.tools || []).map((t) => t.item));
	const byQuest = new Set(bandsOf(route).filter((x) => (x.band.quests || []).length).map((x) => x.band.recipe || x.band.make));
	for (const { band } of bandsOf(route).filter((x) => !x.band.disenchant)) {
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
		if (r.focus && CAMP_STATIONS.includes(r.focus)) errs.push(`${at} ${r.name}: needs a ${r.focus}, which only a camp has (no town has one), so no step can lead a player to it`);
		for (const t of r.tools || []) if (!tools.has(t)) errs.push(`${at} ${r.name}: needs tool ${t}, which \`tools\` does not list`);
		const item = Number(r.recipeItem) || 0;
		if (item && !(route.recipes || {})[item] && !plans.has(item) && !byQuest.has(spell) && !(route.taught || []).includes(spell)) errs.push(`${at} ${r.name}: taught by item ${item}; list its vendors in \`recipes\`, its quest in the band, the plans in a fork, or the spell in \`taught\``);
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

// An NPC who stands only inside a dungeon (no spawn on an outdoor map: Annora in Uldaman).
function insideOnly(npc) {
	return !!npc && (npc.instances || []).length > 0 && !Object.keys(npc.spawns || {}).length;
}

// The recipe of this profession that makes `item` (a grinding stone), or undefined. A material the route gets
// (`materials`: Mote of Magic, which Dust to Motes could make) is not one of its parts.
function madeHere(prof, item, route) {
	if (route && (route.materials || {})[item]) return undefined;
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
	// A recipe the data marks as from an item that trainers teach (`taught`).
	const taught = (r) => (route.taught || []).includes(r.spell);
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
		if (/(Leather|Hide|Scale|Leather Scraps)$/.test(name)) {
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
				// Loops of one faction only (Blindweed: a Horde zone): the other faction buys it.
				const sides = new Set(l.lines.flatMap((x) => (/ only (Alliance|Horde)\b/.exec(x) || [null, 'Alliance', 'Horde']).slice(1).filter(Boolean)));
				out.push(`  collect ${item} x${count} gather ${l.prof} ${l.skill}${sides.size === 1 ? ` only ${[...sides][0]}` : ''}`, ...l.lines);
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
	const step = (kind, title, { tip, lines = [], extra = {}, also = [], only = null } = {}) => {
		const t = tipOf(tip);
		const text = [`step ${title}`, ...[...when, ...also].map((w) => `  when ${w}`), ...(only ? [`  only ${only}`] : []), ...(t ? [`  tip ${t}`] : []), ...lines];
		out.push('', ...text);
		blocks.push({ kind, title, lines: text, when: [...when, ...also], way: curWay, ...extra });
		lastKind = kind;
		if (kind !== 'craft' && kind !== 'station') lastFocus = null;
	};
	// A band's steps after its gets: the recipe (a quest's plans after the hand-in), the quests, the craft. A
	// fork way keyed on plans in the bags holds on each recipe known once it is learned (`afterLearn`: spell ->
	// the `when` line it replaces and its replacement).
	const afterLearn = new Map();
	const bandSteps = (b, sec) => {
		const spell = b.recipe || b.make;
		const fromQuest = recipes.get(spell).recipeItem && (b.quests || []).length;
		if (!fromQuest) learnStep(b, sec);
		questSteps(b, sec);
		if (fromQuest) learnStep(b, sec);
		if (afterLearn.has(spell)) {
			const [from, to] = afterLearn.get(spell);
			when = when.map((w) => (w === from ? to : w));
			afterLearn.delete(spell);
		}
		craftStep(b, sec);
	};
	const learned = new Set();
	const done = new Set(); // quests handed in on every way so far
	const maybe = new Set(); // ... on some ways
	const stock = new Map(); // parts made earlier (grinding stones)
	const tools = new Set();
	const bought = new Set(); // recipe items bought
	let level = 1;
	let skill = 1; // the skill the route has reached
	// Each section's bands outside forks, in order (learns are batched over them).
	const secBands = new Map(route.sections.map((s) => [s, bandsOf({ sections: [s] }).filter((x) => x.way === null && !x.band.disenchant).map((x) => x.band)]));
	const npcName = (id) => ((data.npcs || {})[id] || {}).name || `NPC ${id}`;
	const orList = (xs) => (xs.length <= 1 ? xs.join('') : `${xs.slice(0, -1).join(', ')} or ${xs[xs.length - 1]}`);
	// "plans", "pattern", "recipe", "formula", "schematic", "manual": what a recipe item is called.
	const itemKind = (id) => {
		const m = /^(Plans|Pattern|Recipe|Formula|Schematic|Manual)\b/.exec(itemName(id));
		return m ? m[1].toLowerCase() : 'recipe';
	};
	// Something sold by vendors of each side, bought at one of them: one step when both sides share the vendors,
	// else one per side. A single vendor is pinned; several go to the nearest seller.
	const sellerSteps = (kind, item, by, opts = {}) => {
		const key = (s) => [...(by[s] || [])].sort((a, b) => a - b).join();
		const one = (ids, only) => step(kind, `Buy ${itemName(item)} · ${orList(ids.map(npcName))}`, { ...opts, only, lines: [`  buy ${item} x1 ${ids.length === 1 ? `npc ${ids[0]}` : 'nearest'}`] });
		if (key('Alliance') === key('Horde')) one(by.Alliance);
		else for (const s of SIDES) one(by[s], s);
	};
	// A recipe taught by an item a vendor sells: bought on the trip before its first craft.
	const recipeBuy = (r) => {
		const by = (route.recipes || {})[r.recipeItem];
		if (!by || bought.has(r.recipeItem)) return;
		bought.add(r.recipeItem);
		sellerSteps('recipe', r.recipeItem, by, { tip: by.note || null, also: [`!knows ${r.spell}`] });
	};
	// Where each recipe was first learned ({ sec, skill, lines }) and the section a repeat of it is in: a player
	// who loads the guide past that section never saw the learn, so a later section that crafts the recipe
	// repeats it (done at once for everyone else; #3401).
	const taughtAt = new Map();
	const again = new Map();
	const sectionNo = () => blocks.filter((b) => b.kind === 'section').length;
	const learnStep = (band, sec) => {
		const r = recipes.get(band.recipe || band.make);
		if (learned.has(r.spell)) {
			const first = taughtAt.get(r.spell);
			const here = sectionNo();
			if (first && first.sec !== here && again.get(r.spell) !== here) {
				again.set(r.spell, here);
				step('learn', `Learn ${r.name}`, { tip: `Taught at ${first.skill}; done at once if you learned it then.`, lines: first.lines });
			}
			return;
		}
		learned.add(r.spell);
		if (r.recipeItem && !taught(r)) {
			recipeBuy(r);
			// A recipe vendors sell: until it is in the bags the learn leads to the nearest seller (#3823).
			const lines = [`  learn ${r.spell}${(route.recipes || {})[r.recipeItem] ? ' nearest' : ''}`];
			taughtAt.set(r.spell, { sec: sectionNo(), skill: band.make ? skill : band.from, lines });
			step('learn', `Learn ${r.name}`, { tip: `From the ${itemKind(r.recipeItem)} in your bags.`, lines });
			return;
		}
		const lines = [`  learn ${r.spell} npc ${teacherIds(sec).join(',')}`];
		taughtAt.set(r.spell, { sec: sectionNo(), skill: band.make ? skill : band.from, lines });
		step('learn', `Learn ${r.name}`, { lines });
		learnAhead(sec, band, band.make ? skill : band.from, false);
	};
	const teacherIds = (sec) => [...new Set(SIDES.flatMap((s) => sec.teachers[s] || []))];
	// On a trainer visit at skill `now`: every recipe a band of this rank from `band` on (after it, unless `self`)
	// uses that the skill already allows, so no recipe takes a second trip the first could have taught.
	const learnAhead = (sec, band, now, self) => {
		const list = secBands.get(sec);
		const i = list.indexOf(band);
		if (curWay || i < 0) return;
		for (const b of list.slice(self ? i : i + 1)) {
			const x = recipes.get(b.recipe || b.make);
			if (!x || learned.has(x.spell) || (x.recipeItem && !taught(x)) || Number(x.learnedAt) > now) continue;
			learned.add(x.spell);
			const use = b.make ? `For the ${D.crafts(b.count, x.name)} later` : `For ${b.from}-${b.to}`;
			const xl = [`  learn ${x.spell} npc ${teacherIds(sec).join(',')}`];
			taughtAt.set(x.spell, { sec: sectionNo(), skill: now, lines: xl });
			step('learn', `Learn ${x.name}`, { tip: b === band ? null : `${use}: taught here now, so no second trip.`, lines: xl });
		}
	};
	const craftStep = (band, sec) => {
		const r = recipes.get(band.recipe || band.make);
		for (const t of r.tools || []) if (!tools.has(t)) throw new Error(`${P}: ${r.name} needs ${itemName(t)}, which no step before it buys or crafts`);
		if (r.focus && !(lastKind === 'craft' && lastFocus === r.focus) && !(lastKind === 'station' && lastFocus === r.focus)) {
			// A cooking fire: a town's, or one the player lights from a Basic Campfire Kit (Forever).
			const camp = r.focus === 'Cooking Fire';
			const lines = camp ? [...stationLines(r.focus).map((l) => `${l} either`), `  use ${CAMPFIRE_KIT} either`] : stationLines(r.focus);
			step('station', `Go to ${article(r.focus)} ${r.focus.toLowerCase()}`, { tip: camp ? 'A Basic Campfire Kit placed from your bags counts too.' : null, lines });
			lastFocus = r.focus;
		}
		for (const [k, n] of Object.entries(band.mats)) {
			// Every crafted item the band uses comes off the bags' stock (a material also got: what is there).
			if (madeHere(prof, Number(k)) === undefined) continue;
			const have = stock.get(Number(k)) || 0;
			// A part that is also got (Light Leather: crafted for points, then gathered or bought): the bags'
			// crafts first, the get the rest.
			if (have < n && !route.materials[k]) throw new Error(`${P}: ${band.from || 'make'}-${band.to || ''} ${r.name} uses ${n} ${itemName(k)}, the bags hold ${have}`);
			stock.set(Number(k), Math.max(0, have - n));
		}
		// The craft's count for the window ("about N crafts"), then its keep or heads-up line when both fit.
		const tool = (route.tools || []).some((t) => t.at === 'craft' && t.item === r.item) && !tools.has(r.item);
		const about = band.make || band.count < 2 ? null : `About ${band.count} crafts.`;
		const own = band.keep || band.note || (tool ? 'A tool: it stays in your bags, and later recipes need it.' : band.make ? `Parts for ${band.for}; no skill points from these.` : null);
		const tip = about && own ? (`${about} ${own}`.length <= TIP_MAX ? `${about} ${own}` : own) : about || own;
		if (band.make) {
			step('make', `Craft ${D.crafts(band.count, r.name)}`, { tip, lines: [`  craft ${r.spell} x${band.count}`], extra: { band } });
		} else {
			step('craft', `Craft ${D.crafts(band.count, r.name)} until ${band.to}`, { tip, lines: [`  craft ${r.spell} until ${band.to}`], extra: { band } });
			segments.push({ from: band.from, to: band.to, recipe: r, count: band.count, count90: band.count, need: Object.entries(band.mats).filter(([k]) => madeHere(prof, Number(k), route) === undefined).map(([k, n]) => ({ item: Number(k), count: n })), make: [], tools: [], when: when.slice() });
			skill = Math.max(skill, band.to);
		}
		lastFocus = r.focus || null;
		if (r.item) stock.set(r.item, (stock.get(r.item) || 0) + band.count * (r.itemCount || 1));
		if (tool) tools.add(r.item);
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
			// What earlier crafts left in the bags of a material that is also got (Light Leather) comes off.
			const spare = madeHere(prof, item) !== undefined ? Math.min(stock.get(item) || 0, e.n) : 0;
			const n = e.n - spare;
			if (n <= 0) continue;
			const withSmelt = route.smelt && route.smelt[item];
			for (const [v, per] of Object.entries((withSmelt && withSmelt.with) || {})) {
				step('buy', `Buy ${n * per} ${itemName(v)}`, { tip: `Smelting ${itemName(item)} takes ${per} ${itemName(v)} a bar.`, lines: [`  buy ${v} x${n * per} nearest`], also: [`skill Mining ${withSmelt.skill}`] });
			}
			const bar = !!(loopsFor(item) || {}).smelt;
			const why = forWhat(group, item, bar);
			const own = spare ? ` ${spare} more come from your own crafts.` : '';
			step('get', `Get ${n} ${itemName(item)}`, { tip: (why + own).length <= TIP_MAX ? why + own : why, lines: getLines(item, n), extra: { items: [{ item, count: n }], bands: group } });
		}
	};
	// A get's why line: the crafts it is for (each recipe once), and the plans a quest hands over for it.
	const forWhat = (group, item, bar) => {
		const by = new Map();
		for (const b of group) if ((b.mats || {})[item]) by.set(b.recipe || b.make, (by.get(b.recipe || b.make) || 0) + b.count);
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
		for (const b of list) for (const [k, n] of Object.entries(b.mats || {})) if (vendorOnly(k)) need.set(Number(k), (need.get(Number(k)) || 0) + n);
		for (const [item, n] of need) step('buy', `Buy ${n} ${itemName(item)}`, { tip: forWhat(list, item, false), lines: [`  buy ${item} x${n} nearest`] });
	};
	// Disenchanting raises Enchanting too (players' recordings: a point for nearly every item below 20, fewer
	// after, none from 60): the green items in the bags go first, so the crafts after it need fewer materials.
	// Done at the band's top or when the player says nothing is left to break.
	const disenchantStep = (b) => {
		step('disenchant', `Disenchant your green items until ${b.to}`, {
			tip: 'Disenchant is in the Enchanting window, not the spellbook. Nearly every item gives a point below 20.',
			lines: [`  skill ${pq} ${b.to} either`, '  task "No green items left to break" either'],
		});
	};
	// Bands into groups that share one get: consecutive bands whose gathered material is one and the same, and
	// parts crafted for a band (`make`) with that band.
	const groups = (list) => {
		const gathered = (b) => Object.keys(b.mats).filter((k) => route.materials[k] && !vendorOnly(k)).join();
		const out2 = [];
		let parts = [];
		for (const b of list) {
			if (b.disenchant) {
				out2.push([b]);
				continue;
			}
			if (b.make) {
				parts.push(b);
				continue;
			}
			const g = out2[out2.length - 1];
			const a = gathered(b);
			if (!parts.length && g && !(b.quests || []).length && !a.includes(',') && g.every((x) => !x.make && !x.disenchant && gathered(x) === a)) g.push(b);
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
	const trainStep = (sec, first = null) => {
		const ahead = () => first && learnAhead(sec, first, first.make ? skill : first.from, true);
		if (sec.rank === 'Apprentice') {
			step('train', `Learn ${P}`, { tip: 'No character level needed.', lines: [`  train ${P} Apprentice`] });
			// The recipes the rank teaches with it (Rough Sharpening Stone: learned at 1, free).
			for (const r of recipes.values()) if (r.source === 'trainer' && Number(r.learnedAt) <= 1 && !r.cost) learned.add(r.spell);
			for (const t of route.tools || []) {
				if (t.at !== 'learn' || tools.has(t.item)) continue;
				tools.add(t.item);
				step('tool', `Buy ${article(itemName(t.item))} ${itemName(t.item)}`, { tip: 'A tool: it stays in your bags, and most recipes need it.', lines: [`  buy ${t.item} x1 nearest`] });
			}
		} else if (sec.by && sec.by.book) {
			// A rank from a book: bought from its sellers, then read (the rank is learned from the bags). The
			// section's recipes the trainers already teach at its start (Silk Bandage at 150) are learned first, on
			// the trainer visit before the trip; the recipes the book's sellers also sell come on the same visit.
			const list = secBands.get(sec) || [];
			const ids = [...new Set(SIDES.flatMap((s) => sec.teachers[s] || []))];
			for (const b of list) {
				const x = recipes.get(b.recipe || b.make);
				if (!x || learned.has(x.spell) || (x.recipeItem && !taught(x)) || Number(x.learnedAt) > sec.from) continue;
				learned.add(x.spell);
				step('learn', `Learn ${x.name}`, { tip: `For ${b.from}-${b.to}: the trainers teach it, not the book's seller.`, lines: [`  learn ${x.spell} npc ${ids.join(',')}`] });
			}
			const needs = sec.level > level ? `Needs level ${sec.level} to read.` : null;
			sellerSteps('buy', sec.by.book, sec.by.vendors, { tip: needs });
			step('train', `Read ${itemName(sec.by.book)}`, { tip: `It teaches ${sec.rank} ${P} from your bags.`, lines: [`  train ${P} ${sec.rank}`] });
			const seller = new Set(SIDES.flatMap((s) => sec.by.vendors[s] || []));
			for (const b of list) {
				const x = recipes.get(b.recipe || b.make);
				const by = x && x.recipeItem && (route.recipes || {})[x.recipeItem];
				if (by && SIDES.every((s) => (by[s] || []).some((v) => seller.has(v)))) recipeBuy(x);
			}
		} else if (sec.by && sec.by.quest) {
			// A rank from a quest: its items got first, the feeder the side's trainer hands out (the data
			// hides the quest without it), then the quest taken, done and handed in; one set per side where the
			// quests differ.
			const ids = SIDES.map((s) => sec.by.quest[s]);
			const npcSide = (id, side) => {
				const n = (data.npcs || {})[id];
				return !!n && (!n.faction || n.faction === 'AH' || n.faction === side[0]);
			};
			const feeder = (q, side) => (quests[q].pre || []).filter((p) => quests[p] && ((quests[p].start || {}).npc || []).some((id) => npcSide(id, side)));
			const lvTip = (q) => {
				const lv = Math.max(sec.level, quests[q].minLevel || 0);
				return lv > level ? `Needs level ${lv}.` : null;
			};
			const items = new Map();
			for (const q of new Set(ids)) for (const o of quests[q].objectives || []) if (o.type === 'item') items.set(o.id, Math.max(items.get(o.id) || 0, o.count));
			for (const [item, n] of items) {
				if (!route.materials[item]) throw new Error(`${P}: ${sec.rank}: the quest asks for ${itemName(item)}; give its ways in \`materials\``);
				step('get', `Get ${n} ${itemName(item)}`, { tip: `For ${quests[ids[0]].title}, which teaches ${sec.rank} ${P}.`, lines: route.materials[item].length === 1 && route.materials[item][0] === 'vendor' ? [`  buy ${item} x${n} nearest`] : getLines(item, n), extra: { items: [{ item, count: n }], bands: [] } });
			}
			const questSteps2 = (q, only) => {
				const quest = quests[q];
				step('quest', `Accept ${quest.title}`, { only, tip: feeder(q, only || 'Alliance').length ? null : lvTip(q), lines: [`  accept ${q}`] });
				if ((quest.objectives || []).some((o) => o.type !== 'item')) step('quest', `Complete ${quest.title}`, { only, tip: sec.by.tip || null, lines: [`  complete ${q}`] });
				step('quest', `Hand in ${quest.title}`, { only, tip: `It teaches ${sec.rank} ${P}.`, lines: [`  turnin ${q}`] });
			};
			const same = ids[0] === ids[1];
			// The quests' level, reached before the first of them is taken (the window asks it once).
			const chain = ids.flatMap((q) => [q, ...feeder(q, 'Alliance'), ...feeder(q, 'Horde')]);
			const need = Math.max(sec.level, ...chain.map((q) => quests[q].minLevel || 0));
			if (need > level) {
				step('level', `Reach level ${need}`, { tip: `${quests[ids[0]].title} asks for level ${need}.`, lines: [`  level ${need}`] });
				level = need;
			}
			for (const [i, side] of SIDES.entries()) {
				const only = same && !feeder(ids[0], 'Alliance').length && !feeder(ids[0], 'Horde').length ? null : side;
				for (const p of feeder(ids[i], side)) {
					step('quest', `Accept ${quests[p].title}`, { only, tip: lvTip(p), lines: [`  accept ${p}`] });
					step('quest', `Hand in ${quests[p].title}`, { only, lines: [`  turnin ${p}`] });
				}
				if (!same) questSteps2(ids[i], side);
				if (!only) break;
			}
			if (same) questSteps2(ids[0], null);
		} else if (sec.dungeon) {
			// A rank only a trainer inside a dungeon teaches (Annora in Uldaman), or, where one exists, someone
			// outside who trains it too.
			const rank = (prof.ranks || []).find((r) => r.name === sec.rank) || {};
			const inside = [...new Set(SIDES.flatMap((s) => (rank.trainers || {})[s] || []))].filter((id) => insideOnly((data.npcs || {})[id]));
			const npc = (data.npcs || {})[inside[0]];
			const inst = (data.instances || {})[(npc.instances || [])[0]] || {};
			const where = typeof sec.dungeon === 'string' ? sec.dungeon : inst.name;
			if (!where) throw new Error(`${P}: ${sec.rank}: name the dungeon ${npc.name} stands in (\`dungeon: "<name>"\`)`);
			const needs = sec.level > level ? `Needs level ${sec.level}. ` : '';
			if (sec.outside) {
				for (const s of SIDES) {
					const ids = sec.outside[s] || [];
					step('train', `Train ${sec.rank} ${P} · ${orList(ids.map(npcName))}`, { only: s, tip: `${needs}${npc.name} teaches it too, inside ${where}.`, lines: [`  train ${ids[0]}`] });
				}
			} else {
				const door = (inst.entrances || []).slice().sort((a, b) => b.n - a.n)[0];
				if (!door) throw new Error(`${P}: ${sec.rank}: no entrance of ${where} in instances.json`);
				step('goto', `Go to ${where}`, { tip: `${needs}${npc.name}, the only ${sec.rank} trainer, is inside this dungeon.`, lines: [`  goto ${door.x},${door.y} "${where}" map ${door.map}`] });
				step('train', `Train ${sec.rank} ${P} · ${npc.name}`, { tip: sec.dungeonTip || `${where} is a dungeon: grouping up is advised.`, lines: [`  train ${inside[0]}`] });
				ahead();
			}
		} else {
			step('train', `Train ${sec.rank} ${P}`, { tip: sec.level > level ? `Needs level ${sec.level}.` : null, lines: [`  train ${P} ${sec.rank}`] });
			ahead();
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
			if (g[0].disenchant) return disenchantStep(g[0]);
			getSteps(g);
			if (!trained.has(sec.rank)) trainStep(sec, g[0]);
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
		const late = (r) => Number(r.learnedAt) > from;
		const planned = new Set();
		fork.ways.forEach((w) => {
			for (const p of w.plans || []) {
				if (planned.has(p)) continue;
				planned.add(p);
				step('plans', `Buy ${itemName(p)} at the Auction House`, { tip: w.why, lines: [`  auction ${p} x1 either`, '  task "None listed, or too dear" either'] });
			}
		});
		fork.ways.forEach((w, i) => {
			for (const r of keys[i] || []) {
				if (late(r) || learned.has(r.spell)) continue;
				step('learn', `Learn ${r.name}`, { tip: `From the ${itemKind(r.recipeItem)} in your bags.`, lines: [`  learn ${r.spell}`], also: [`has ${r.recipeItem}`] });
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
			// A way holds when all its plans are known (or, learned later, in the bags) and no earlier way does.
			// An earlier way not holding is one of its plans missing: of its plans this way lacks, an earlier way
			// that lacks a subset says it already, and what is left must be one plan each (`when` has no "or").
			const own = keys[i] || [];
			let sets = [];
			for (let j = 0; j < i; j++) {
				if (!keys[j]) continue;
				const s = keys[j].filter((r) => !own.includes(r));
				if (!s.length) throw new Error(`${P}: fork "${fork.fork}": way ${w.name} is never reached (way ${fork.ways[j].name} takes every player it would)`);
				if (!sets.some((t) => t.length === s.length && t.every((x) => s.includes(x)))) sets.push(s);
			}
			sets = sets.filter((s) => !sets.some((t) => t !== s && t.length < s.length && t.every((x) => s.includes(x))));
			const conds = [];
			for (const s of sets) {
				if (s.length > 1) throw new Error(`${P}: fork "${fork.fork}": way ${w.name} differs from an earlier way by ${s.length} plans; add a way with fewer of them first`);
				const r = s[0];
				conds.push(...(late(r) ? [`!has ${r.recipeItem}`, `!knows ${r.spell}`] : [`!knows ${r.spell}`]));
			}
			when = [...conds, ...own.map((r) => (late(r) ? `has ${r.recipeItem}` : `knows ${r.spell}`))];
			afterLearn.clear();
			for (const r of own) if (late(r)) afterLearn.set(r.spell, [`has ${r.recipeItem}`, `knows ${r.spell}`]);
			if (i > 0) lastSection = null;
			curWay = `${forks}:${i}`;
			runList(sec, w.route);
			afterLearn.clear();
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
		for (const b of list) for (const [k, n] of Object.entries(b.mats || {})) if (madeHere(prof, Number(k), route) === undefined) tally.set(Number(k), (tally.get(Number(k)) || 0) + n);
		materials.push({ from: sec.from, cap: sec.to, items: [...tally].filter(([k]) => !(route.materials[k].length === 1 && route.materials[k][0] === 'vendor')).map(([item, count]) => ({ item, name: itemName(item), count, uses: [] })) });
	}
	const { header } = require('../generated');
	const head = [
		header('guide', opts.command || `profession draft ${P} --out`, `tools/lib/professions/routes/${slug(P)}.json and data/forever`),
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
		if (b.disenchant) return `#${pad}  ${String(b.from).padStart(3)}-${String(b.to).padEnd(3)} disenchant green items (a point for nearly each)`;
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
