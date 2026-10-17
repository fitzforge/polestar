'use strict';
// A profession plan (plan.js) -> a .guide (docs/GUIDE_FORMAT.md) for both
// factions and every race. Trainers and vendors are smart targets that the
// engine resolves at runtime to the nearest one of the player's faction
// (`train <Profession> <Rank>`, `buy <item> xN nearest`), so the guide has
// no faction or race branches except where the content really differs:
// farming spots for gathered and dropped materials are picked per faction.
// Per rank bracket (1-75, 75-150, 150-225, 225-300):
//   1. the rank: level gate, smart `train`, the trainer recipes learnable now,
//      and vendor reagents and tools for the whole bracket (`buy … nearest`);
//   2. recipe items sold by vendors (`buy <recipe> nearest`);
//   3. gathered and dropped materials, per faction, each with a farming spot
//      picked from the reference data (see farmSpot);
//   4. one shared `craft <recipe> until <N>` step per plan segment, with
//      `skill` checkpoints at 75/150/225/300.
// Recipes a trainer teaches only later in the bracket get a `learn` step
// right before the segment that needs them.

const { planProfession, CAPS } = require('./plan');
const { homeMap } = require('./materials');
const { ZONES } = require('./gathering/tables');
const { BEASTS } = require('./gathering/skinning');
const { header } = require('../generated');

const SIDES = ['Alliance', 'Horde'];
const RANK_NAMES = ['Apprentice', 'Journeyman', 'Expert', 'Artisan'];
const CRAFTING = new Set([171, 164, 333, 202, 165, 197]);
const MILESTONES = new Set([150, 225, 300]);
const FARM_KINDS = new Set(['herb', 'mine', 'fishing', 'cloth', 'drop']);
// Material kinds that come from killing mobs (materials.js sourceOf).
const MOB_KINDS = new Set(['cloth', 'drop']);
const MAX_PTS = 30;
const NEAR_BEST = 0.7;
// A skinned material with a mob dropping it at this rate (percent) or more is
// placed at those mobs instead of the curated beast-list guess.
const SKIN_DROP_MIN = 5;
// Drop rate (percent) that counts as a real source; the compiler's `collect`
// checks use the same 2% (tools/lib/dsl/farmspots.js MIN_CHANCE).
const REAL_DROP = 2;
// Rank trainers the reference data has no spawn for (game knowledge of where
// they stand): the guide names them explicitly, with a note.
const TRAINER_NOTES = {
	Annora: 'Annora teaches Artisan Enchanting inside the Uldaman dungeon (Badlands); bring a group',
};

function slug(name) {
	return String(name).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

function quote(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"')}"`;
}

function money(copper) {
	const c = Math.round(copper);
	const g = Math.floor(c / 10000);
	const s = Math.floor((c % 10000) / 100);
	if (g >= 10) return `${g}g`;
	if (g > 0) return `${g}g ${s}s`;
	if (s > 0) return `${s}s`;
	return `${c % 100}c`;
}

const round1 = (v) => Math.round(v * 10) / 10;

// Where an npc stands: { map, x, y } | null, on its interior map (see homeMap).
function anchor(npc) {
	const h = homeMap(npc);
	if (!h) return null;
	const p = npc.spawns[h].pts[0];
	return { map: h, x: p[0], y: p[1] };
}

// The point of `pts` with the most other points within 8 map units.
function densest(pts) {
	let best = pts[0];
	let most = -1;
	for (const p of pts) {
		let n = 0;
		for (const q of pts) if (Math.hypot(p[0] - q[0], p[1] - q[1]) <= 8) n++;
		if (n > most) {
			most = n;
			best = p;
		}
	}
	return best;
}

// Maps of towns: every spawn of a service NPC (innkeeper, flight master,
// vendor...), whatever its faction. Mobs standing there are town guards
// (Booty Bay Bruisers, Gadgetzan Bruisers...), never a farming spot.
const TOWN_ROLES = new Set(['innkeeper', 'flightmaster', 'vendor', 'repair', 'banker', 'auctioneer', 'stablemaster']);
const TOWN_RADIUS = 6; // map units
const townCache = new WeakMap();
function townPoints(data) {
	if (townCache.has(data)) return townCache.get(data);
	const out = new Map(); // map -> [[x, y]]
	for (const n of Object.values(data.npcs || {})) {
		if (!(n.roles || []).some((r) => TOWN_ROLES.has(r))) continue;
		for (const [map, s] of Object.entries(n.spawns || {})) {
			if (!out.has(Number(map))) out.set(Number(map), []);
			out.get(Number(map)).push(...((s && s.pts) || []));
		}
	}
	townCache.set(data, out);
	return out;
}

function outsideTowns(pts, map, data) {
	const town = townPoints(data).get(map) || [];
	return pts.filter((p) => !town.some((q) => Math.hypot(p[0] - q[0], p[1] - q[1]) <= TOWN_RADIUS));
}

// A zone's side (gathering/tables.js ZONES): 'A', 'H', 'AH' (contested), or
// null for zones outside that table (cities, dungeons, unusual maps).
function zoneFriendly(map, side) {
	const z = ZONES[map];
	return !!(z && z.side && z.side.includes(side === 'Alliance' ? 'A' : 'H'));
}

// Where a faction farms a material: the herb/ore/fishing node, or the hostile
// non-elite mob outside towns or the clickable object (Giant Clams for pearls),
// whose (drop chance x spawn points) is highest on an outdoor zone, preferring
// zones that side can work in (ZONES side) and the faction's home continent
// (where its capital trainer stands). Mob and object sources at REAL_DROP
// percent or more win over rarer ones (a 0.1% drop from a murloc that spawns
// everywhere is not where pearls come from).
// -> { map, x, y, label, level, object } | null
function farmSpot(itemId, kind, side, home, data, minChance = 0) {
	const it = (data.items || {})[itemId];
	if (!it || !it.drops) return null;
	const zones = data.zones || {};
	const frames = (data.mapFrames && data.mapFrames.era) || {};
	const cands = [];
	const consider = (entity, chance, label, level, mob) => {
		for (const [map, s] of Object.entries(entity.spawns || {})) {
			const z = zones[map];
			if (!z || z.type !== 3 || !s.pts || !s.pts.length) continue;
			const pts = mob ? outsideTowns(s.pts, Number(map), data) : s.pts;
			if (!pts.length) continue;
			const c = frames[map] ? frames[map].c : null;
			const score = (chance / 100) * Math.min(pts.length, MAX_PTS) * (c === home ? 1 : 0.25) * (zoneFriendly(Number(map), side) ? 1 : 0.3);
			cands.push({ score, map: Number(map), pts, label, level, id: entity.id });
		}
	};
	if (kind === 'herb' || kind === 'mine' || kind === 'fishing') {
		const role = kind;
		for (const [oid, chance] of Object.entries(it.drops.object || {})) {
			const o = (data.objects || {})[oid];
			if (o && (o.roles || []).includes(role)) consider(o, Number(chance) || 0, o.name, null, false);
		}
	} else {
		const real = (c) => Number(c) >= Math.max(minChance, REAL_DROP);
		const npcSources = Object.entries(it.drops.npc || {}).filter(([nid, chance]) => {
			const n = (data.npcs || {})[nid];
			// faction null is hostile or neutral; A/H/AH are friendly to someone.
			return n && n.faction == null && !((n.rank || 0) > 0) && !(n.roles || []).length && Number(chance) >= minChance;
		});
		// Chests are random loot; anything else droppable that is not a node is clickable (clams).
		const objSources = Object.entries(it.drops.object || {}).filter(([oid, chance]) => {
			const o = (data.objects || {})[oid];
			const roles = (o && o.roles) || [];
			return o && real(chance) && (!roles.length || (o.name && /Clam/.test(o.name)));
		});
		const anyReal = npcSources.some(([, c]) => real(c)) || objSources.length;
		for (const [nid, chance] of npcSources) {
			if (anyReal && !real(chance)) continue;
			const n = data.npcs[nid];
			const level = n.levelMax && n.levelMax !== n.level ? `${n.level}-${n.levelMax}` : `${n.level}`;
			consider(n, Number(chance) || 0, n.name, level, true);
		}
		for (const [oid, chance] of objSources) consider({ ...data.objects[oid], object: true }, Number(chance) || 0, data.objects[oid].name, null, false);
	}
	if (!cands.length) return null;
	cands.sort((a, b) => b.score - a.score || a.id - b.id || a.map - b.map);
	// Among spots nearly as good as the best, the lowest-level zone (ZONES min
	// level) is the one a character gathering these materials is likely near.
	const lvl = (c) => (ZONES[c.map] ? ZONES[c.map].min : 99);
	const best = cands.filter((c) => c.score >= cands[0].score * NEAR_BEST).sort((a, b) => lvl(a) - lvl(b) || b.score - a.score || a.id - b.id || a.map - b.map)[0];
	const [x, y] = densest(best.pts);
	return { map: best.map, x: round1(x), y: round1(y), label: best.label, level: best.level, object: !best.level };
}

// Skinned materials by the level of the beasts that yield them (Classic game
// knowledge; the data has no skinning loot). `beast` narrows the beasts by name.
const HIDE_TIERS = [
	{ re: /^Ruined Leather Scraps$/, min: 1, max: 15 },
	{ re: /^Light (Leather|Hide)$/, min: 5, max: 20 },
	{ re: /^Medium (Leather|Hide)$/, min: 18, max: 30 },
	{ re: /^Heavy (Leather|Hide)$/, min: 28, max: 40 },
	{ re: /^Thick (Leather|Hide)$/, min: 38, max: 50 },
	{ re: /^Rugged (Leather|Hide)$/, min: 48, max: 60 },
	{ re: /^Turtle Scale$/, min: 30, max: 50, beast: /Tortoise|Turtle|Snapper|Snapjaw/ },
	{ re: /^Scorpid Scale$/, min: 40, max: 52, beast: /Scorpid|Scorpashi/ },
	{ re: /^Heavy Scorpid Scale$/, min: 50, max: 60, beast: /Scorpid/ },
];

// Where a faction skins a material: the zone in the curated beast lists
// (gathering/skinning.js BEASTS) with the most hostile, non-elite beast spawns
// of the material's level band, preferring zones that side can work in and
// its home continent. -> { map, x, y, beasts: [names], min, max } | null
function skinSpot(itemName, side, home, data) {
	const tier = HIDE_TIERS.find((t) => t.re.test(itemName));
	if (!tier) return null;
	const frames = (data.mapFrames && data.mapFrames.era) || {};
	const byName = new Map();
	for (const n of Object.values(data.npcs || {})) {
		if (!byName.has(n.name)) byName.set(n.name, []);
		byName.get(n.name).push(n);
	}
	let best = null;
	for (const map of Object.keys(BEASTS).map(Number).sort((a, b) => a - b)) {
		const pts = [];
		const names = [];
		for (const name of BEASTS[map]) {
			if (tier.beast && !tier.beast.test(name)) continue;
			for (const n of byName.get(name) || []) {
				if (n.faction != null || (n.rank || 0) > 0) continue;
				if (!(n.level >= tier.min && n.level <= tier.max)) continue;
				const s = n.spawns && n.spawns[map];
				if (!s || !s.pts || !s.pts.length) continue;
				pts.push(...outsideTowns(s.pts, map, data));
				if (!names.includes(name)) names.push(name);
			}
		}
		if (!pts.length) continue;
		const c = frames[map] ? frames[map].c : null;
		const score = Math.min(pts.length, MAX_PTS * 2) * (c === home ? 1 : 0.25) * (zoneFriendly(map, side) ? 1 : 0.3);
		if (!best || score > best.score) best = { score, map, pts, names };
	}
	if (!best) return null;
	const [x, y] = densest(best.pts);
	return { map: best.map, x: round1(x), y: round1(y), beasts: best.names.sort(), min: tier.min, max: tier.max };
}

function draftGuide(name, data, opts = {}) {
	const profs = data.professions || {};
	const prof = Object.values(profs).find((p) => p && String(p.name).toLowerCase() === String(name).toLowerCase());
	if (!prof) throw new Error(`unknown profession "${name}"`);
	if (!CRAFTING.has(prof.id)) throw new Error(`${prof.name} is not a crafting profession (Alchemy, Blacksmithing, Enchanting, Engineering, Leatherworking, Tailoring)`);
	const plan = planProfession(prof, data, opts);
	const goal = opts.to || 300;
	const npcs = data.npcs || {};
	const zones = data.zones || {};
	const frames = (data.mapFrames && data.mapFrames.era) || {};
	const mats = prof.materials || {};
	const P = prof.name;
	const pq = /\s/.test(P) ? quote(P) : P;
	const out = [];
	const line = (s = '') => out.push(s);
	// `zone` is sticky: steps after a farming spot go back to the world map, so
	// their goals are not resolved against that farming zone.
	let curZone = 'Azeroth';
	const world = () => {
		if (curZone === 'Azeroth') return;
		line('  zone Azeroth');
		curZone = 'Azeroth';
	};
	const matName = (id) => (mats[id] && mats[id].name) || `item ${id}`;
	const zoneName = (map) => (zones[map] && zones[map].name) || null;
	// Home continent per faction (where its capital trainer stands): farming spots prefer it.
	const homeOf = (side) => {
		const main = prof.mainTrainer && prof.mainTrainer[side];
		const at = anchor(npcs[main]);
		return at && frames[at.map] ? frames[at.map].c : side === 'Alliance' ? 0 : 1;
	};
	// A rank whose trainers have no known spawn is trained at a named NPC.
	const fixedTrainer = (rankIdx) => {
		const rank = prof.ranks[rankIdx] || {};
		const ids = [...new Set(SIDES.flatMap((s) => (rank.trainers && rank.trainers[s]) || []))];
		if (!ids.length || ids.some((id) => anchor(npcs[id]))) return null;
		return ids.sort((a, b) => a - b)[0];
	};

	line(header('guide', `profession draft ${P} --out`, "Forever's client tables"));
	line(`guide forever/professions/${slug(P)}`);
	line(`title ${P} 1-300`);
	line('category Professions');
	line('levels 5-60');
	line('zone Azeroth');
	line('');
	line('# Data:');
	line("# The Forever client's tables (recipes, skill thresholds, reagents, vendor");
	line('# prices) via wago.tools, with Classic Era filling the few spells and items');
	line('# they lack; pfQuest (vendors, drops, nodes) and a curated trainer list');
	line('# checked against npcs.json. Forever changed many thresholds, reagents and');
	line('# names from Classic, so Classic recipe tables do not apply.');
	line('#');
	line('# Trainers and vendors are smart targets: the engine sends each character to');
	line('# the nearest one of its faction. Farming spots are picked per faction.');
	line('#');
	line('# Recipe choice: cheapest expected cost to 300 (Classic skill-up chances:');
	line('# certain while orange, falling from yellow to grey), with gathered materials');
	line('# valued at 4x their vendor sell price; see tools/lib/professions/plan.js.');
	line('# Material counts are expected values; yellow and green crafts can take more.');
	line('#');
	line('# Route:');
	for (const s of plan.segments) line(`#   ${String(s.from).padStart(3)}-${String(s.to).padEnd(3)} ${s.recipe.name} (about ${s.count})`);
	if (plan.reach < goal) line(`#   ${String(plan.reach).padStart(3)}-${goal} not routed: no trainer or vendor recipe gives points there`);

	const learned = new Set(prof.recipes.filter((r) => r.source === 'trainer' && r.learnedAt <= 1 && r.cost === 0).map((r) => r.spell));
	const toolsDone = new Set();
	const bought = new Set(); // vendor recipes already bought
	let gate = 5; // character level the guide has asked for so far (header levels 5-60)
	const needs = (seg) => {
		const seen = new Set();
		return [...seg.make.map((m) => m.recipe), seg.recipe].filter((r) => (seen.has(r.spell) ? false : (seen.add(r.spell), true)));
	};

	const brackets = [];
	for (const seg of plan.segments) {
		const cap = CAPS.find((c) => c > seg.from) || 300;
		let b = brackets[brackets.length - 1];
		if (!b || b.cap !== cap) brackets.push((b = { cap, from: seg.from, segments: [] }));
		b.segments.push(seg);
	}

	brackets.forEach((b, bi) => {
		const rankIdx = CAPS.indexOf(b.cap);
		const rank = prof.ranks[rankIdx] || { name: RANK_NAMES[rankIdx], max: b.cap, minLevel: 5, minSkill: 0 };
		const trainRank = bi === 0 || b.from >= ((prof.ranks[rankIdx - 1] || {}).max || CAPS[rankIdx - 1]);
		// Bracket totals.
		const totals = new Map(); // item -> { count, src }
		const tools = [];
		for (const seg of b.segments) {
			for (const n of seg.need) {
				const t = totals.get(n.item);
				if (t) t.count += n.count;
				else totals.set(n.item, { item: n.item, count: n.count, src: n.src });
			}
			for (const t of seg.tools) if (!t.craft && !toolsDone.has(t.item)) tools.push(t.item);
		}
		const list = [...totals.values()].sort((a, c) => a.item - c.item);
		const vendorRecipes = [];
		for (const seg of b.segments) for (const r of needs(seg)) if (r.source === 'vendor' && !bought.has(r.spell) && !vendorRecipes.includes(r)) vendorRecipes.push(r);
		const cost = b.segments.reduce((a, s) => a + s.cost, 0);

		// 1. The rank, the recipes learnable now, the vendor supplies.
		const firstLearn = [];
		for (const seg of b.segments) for (const r of needs(seg)) if (r.source === 'trainer' && !learned.has(r.spell) && r.learnedAt <= b.from && !firstLearn.includes(r)) firstLearn.push(r);
		line('');
		line(`step ${trainRank ? `${rank.name} ${P}` : `${P} supplies for ${b.from}-${b.cap}`}`);
		world();
		const tip = [];
		if (bi === 0) tip.push(`${P} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts.`);
		else if (trainRank) tip.push(`${rank.name} needs character level ${rank.minLevel} and ${P} ${rank.minSkill}; it raises the cap to ${rank.max}.`);
		tip.push(`Materials for ${b.from}-${b.cap} are worth about ${money(cost)} in all.`);
		line(`  tip ${tip.join(' ')}`);
		if (trainRank && rank.minLevel > 5) line(`  level ${rank.minLevel}`);
		if (trainRank) gate = Math.max(gate, rank.minLevel);
		const fixed = trainRank ? fixedTrainer(rankIdx) : null;
		if (trainRank) {
			if (fixed) line(`  train ${fixed}${TRAINER_NOTES[(npcs[fixed] || {}).name] ? ` -- ${TRAINER_NOTES[npcs[fixed].name]}` : ''}`);
			else line(`  train ${pq} ${rank.name}`);
			if (bi === 0) line(`  skill ${pq} 1`);
		}
		// A fixed trainer (no spawn in the data) only for recipes above the previous rank's cap.
		const pin = (r, npc) => (npc && r.learnedAt > (CAPS[rankIdx - 1] || 0) ? ` npc ${npc}` : '');
		for (const r of firstLearn) line(`  learn ${r.spell}${pin(r, fixed)}`);
		for (const t of list) {
			const kinds = SIDES.map((side) => t.src[side].kind);
			if (!kinds.includes('vendor')) continue;
			const tool = tools.includes(t.item);
			const what = tool ? ` -- ${matName(t.item)}: a tool, keep it in your bags` : '';
			const count = tool ? '' : ` x${t.count}`;
			if (kinds.every((k) => k === 'vendor')) line(`  buy ${t.item}${count} nearest${what}`);
			else SIDES.forEach((side, i) => kinds[i] === 'vendor' && line(`  buy ${t.item}${count} nearest only ${side}${what}`));
		}
		for (const r of firstLearn) learned.add(r.spell);
		for (const t of tools) toolsDone.add(t);

		// 2. Recipe items from vendors.
		for (const r of vendorRecipes) {
			bought.add(r.spell);
			const m = mats[r.recipeItem] || {};
			const limited = SIDES.some((side) => ((m.limitedVendors && m.limitedVendors[side]) || []).length);
			line('');
			line(`step ${m.name || `Recipe for ${r.name}`}`);
			world();
			const stock = limited ? ` Vendors sell it in limited stock that restocks${m.bop ? '' : '; the Auction House often has it too'}.` : '';
			line(`  tip Teaches ${r.name} (needs ${P} ${r.learnedAt}).${stock}`);
			line(`  buy ${r.recipeItem} nearest`);
		}

		// 3. Gathered and dropped materials. Mob drops the compiler can place
		// (`data.farmable(item)` -> { Alliance, Horde }: a qualifying farm spot
		// safe for that side) become one `collect … nearest` step that the
		// engine resolves by level, faction and travel time. Nodes, fish and the
		// rest keep a farming spot per faction where the spots differ.
		const shared = [];
		for (const t of list) {
			const kinds = SIDES.map((side) => t.src[side].kind);
			if (kinds.every((k) => k === 'vendor')) continue;
			const need = SIDES.filter((side, i) => kinds[i] !== 'vendor');
			// The engine skips spots whose mobs are 3+ levels above the player; the
			// player is at least at the last `level` gate here.
			const ok = data.farmable ? data.farmable(t.item) : null;
			if (ok && need.every((side) => MOB_KINDS.has(t.src[side].kind) && ok[side] != null && ok[side] - gate < 3)) {
				line('');
				line(`step ${matName(t.item)}`);
				world();
				if (need.length === 1) line(`  only ${need[0]}`);
				line('  tip Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too.');
				line(`  collect ${t.item} x${t.count} nearest`);
				continue;
			}
			const spotFor = (side) => {
				const kind = t.src[side].kind;
				if (kind === 'skinning') {
					// Beasts the data says yield it at a real rate (Turtle Scale from
					// turtles) beat the level-band guess from the curated beast lists.
					const fromData = farmSpot(t.item, 'drop', side, homeOf(side), data, SKIN_DROP_MIN);
					return fromData ? { ...fromData, skin: true } : skinSpot(matName(t.item), side, homeOf(side), data);
				}
				return FARM_KINDS.has(kind) ? farmSpot(t.item, kind, side, homeOf(side), data) : null;
			};
			const spots = SIDES.map((side) => (t.src[side].kind !== 'vendor' ? spotFor(side) : null));
			if (spots.every((s) => !s) && kinds.every((k) => k !== 'vendor')) {
				// No farming spot (skinning, disenchanting, other professions): one shared goal.
				shared.push(`  collect ${t.item} x${t.count} -- ${t.src.Alliance.note}`);
				continue;
			}
			const same = spots[0] && spots[1] && spots[0].map === spots[1].map && spots[0].x === spots[1].x && spots[0].y === spots[1].y;
			const sides = same ? [null] : SIDES;
			sides.forEach((side) => {
				const i = side === 'Horde' ? 1 : 0;
				const src = t.src[side || 'Alliance'];
				if (src.kind === 'vendor') return;
				const s = spots[i];
				line('');
				line(`step ${matName(t.item)}${side ? ` (${side})` : ''}`);
				if (side) line(`  only ${side}`);
				if (s) {
					line(`  zone ${zoneName(s.map)}`);
					curZone = zoneName(s.map);
					const how = {
						herb: s.label === matName(t.item) ? `Pick ${s.label} with Herbalism; this is the densest patch in the data` : `${matName(t.item)} comes from ${s.label} nodes (Herbalism); this is the densest patch in the data`,
						mine: s.label === matName(t.item) ? `Mine ${s.label}; this is the densest cluster in the data` : `${matName(t.item)} comes from ${s.label} nodes (Mining); this is the densest cluster in the data`,
						fishing: `Fish ${s.label}; this is where the data has most of them`,
						skinning: s.beasts ? `Skin ${s.beasts.join(', ')} here (beasts of level ${s.min}-${s.max} yield it); the Skinning guide routes this` : `Kill and skin ${s.label} (level ${s.level}) here`,
					}[src.kind] || (s.object ? `Open ${s.label}s here` : `${s.label} (level ${s.level}) drop it here`);
					line(`  tip ${how}. The Auction House works too.`);
					line(`  collect ${t.item} x${t.count} @${s.x},${s.y} era`);
				} else {
					world();
					line(`  collect ${t.item} x${t.count} -- ${src.note}`);
				}
			});
		}
		if (shared.length) {
			line('');
			line(`step ${P} materials for ${b.from}-${b.cap}`);
			world();
			line('  tip Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House.');
			for (const g of shared) line(g);
		}

		// 4. Crafting, with a trainer visit for recipes learnable only later.
		for (const seg of b.segments) {
			const late = needs(seg).filter((r) => r.source === 'trainer' && !learned.has(r.spell));
			if (late.length) {
				const fx = fixedTrainer(rankIdx);
				line('');
				line(`step ${P} recipes at ${seg.from}`);
				world();
				line(`  tip Back to ${/^[AEIOU]/.test(P) ? 'an' : 'a'} ${P} trainer: ${late.map((r) => r.name).join(', ')} ${late.length > 1 ? 'are' : 'is'} taught from ${P} ${Math.max(...late.map((r) => r.learnedAt))}.`);
				for (const r of late) line(`  learn ${r.spell}${pin(r, fx)}`);
				for (const r of late) learned.add(r.spell);
			}
			const r = seg.recipe;
			line('');
			line(`step ${r.name} to ${seg.to}`);
			world();
			const notes = [];
			if (seg.from < r.yellow) notes.push(`Orange (a point every craft) until ${r.yellow}, yellow until ${r.green}, green until ${r.grey}.`);
			else notes.push(`Yellow until ${r.green}, green until ${r.grey}: not every craft gives a point.`);
			if (r.focus) notes.push(`Needs ${/^[AEIOU]/.test(r.focus) ? 'an' : 'a'} ${r.focus.toLowerCase()} nearby.`);
			if (r.enchant) notes.push('Enchant your own gear: any item for that slot will do.');
			if (MILESTONES.has(seg.to)) notes.push(`${P} ${seg.to} is a Legacy System milestone.`);
			else if (seg.to === 75) notes.push('75 is the Apprentice cap.');
			line(`  tip ${notes.join(' ')}`);
			for (const r2 of needs(seg)) {
				if (r2.source === 'vendor' && !learned.has(r2.spell)) {
					line(`  learn ${r2.spell} -- from the recipe in your bags`);
					learned.add(r2.spell);
				}
			}
			for (const m of seg.make) line(`  craft ${m.recipe.spell} x${m.count}${seg.tools.some((t) => t.item === m.item) ? ' -- a tool: keep it in your bags' : ''}`);
			line(`  craft ${r.spell} until ${seg.to}`);
			if (CAPS.includes(seg.to)) line(`  skill ${pq} ${seg.to}`);
		}
	});
	// Past the plan's reach every recipe that still gives a point is one the
	// planner leaves out: name the ones the player could use at that skill.
	if (plan.reach < goal) {
		const why = new Map(plan.excluded.map((e) => [e.spell, e.why.replace(/^recipe is a item$/, 'recipe from an item')]));
		const open = prof.recipes.filter((r) => why.has(r.spell) && r.grey > plan.reach && r.learnedAt <= plan.reach && !r.races && !r.classes);
		const names = [...new Map(open.map((r) => [r.name, `${r.name} (${why.get(r.spell)})`])).values()].slice(0, 5);
		line('');
		line(`step ${P} ${plan.reach}-${goal}`);
		world();
		line(`  tip On Forever no recipe a trainer teaches or both factions' vendors sell gives ${P} points past ${plan.reach}, so Polestar has no route for the last points.${names.length ? ` Recipes that still do: ${names.join(', ')}.` : ''}`);
		line(`  skill ${pq} ${goal}`);
	}
	return { text: `${out.join('\n')}\n`, plan };
}

module.exports = { draftGuide, farmSpot, skinSpot, money, slug };
