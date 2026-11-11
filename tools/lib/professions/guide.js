'use strict';
// A profession plan (plan.js) -> a .guide (docs/GUIDE_FORMAT.md) for both
// factions and every race. Trainers and vendors are smart targets that the
// engine resolves at runtime to the nearest one of the player's faction
// (`train <Profession> <Rank>`, `buy <item> xN nearest`), so the guide has
// no faction or race branches except where the content really differs:
// farming spots for gathered and dropped materials are picked per faction.
// The header explains the profession (specs.js: Forever's changes,
// specialisations, camping) and lists the route with what each range costs.
// Per rank bracket (1-75, 75-150, 150-225, 225-300):
//   1. the rank: who teaches it, skill, level and price, the trainer recipes
//      learnable now (with their prices) and the bracket's shopping totals;
//   2. vendor reagents and tools for the whole bracket (`buy … nearest`), with
//      the sellers in the main trainer's town and the money they take;
//   3. recipe items sold by vendors (`buy <recipe> nearest`), each with its
//      sellers by faction and place, price and stock;
//   4. gathered and dropped materials with a farming spot (a node, beasts or
//      humanoids by level, a dropping mob, a clam), per faction where the
//      spots differ (see farmSpot); materials with no spot (disenchanting,
//      another profession's goods) are named in the first craft step using them;
//   5. one shared `craft <recipe> until <N>` step per plan segment: colour at
//      the start, crafts, materials per craft, why this recipe, the specs.js
//      notes for that skill (specialisations), with `skill` checkpoints at
//      75/150/225/300.
// Recipes a trainer teaches only later in the bracket get a `learn` step
// right before the segment that needs them.

const { planProfession, CAPS } = require('./plan');
const { homeMap } = require('./materials');
const { ZONES } = require('./gathering/tables');
const { byBanners } = require('./sections');
const { BEASTS } = require('./gathering/skinning');
const { RACE_GROUPS, TWO_SIDED, raceCondition, maxZoneLevel } = require('./gathering/groups');
const { header } = require('../generated');
const D = require('./describe');
const { SPECS } = require('./specs');

const SIDES = ['Alliance', 'Horde'];
const RANK_NAMES = ['Apprentice', 'Journeyman', 'Expert', 'Artisan'];
const CRAFTING = new Set([171, 164, 333, 202, 165, 197]);
// Professions whose sniffed Forever trainer list has the Journeyman rank (level 10): Blacksmithing,
// Leatherworking, Tailoring (world DB trainer_spell, lists 376, 385 and 388).
const JOURNEYMAN_SNIFFED = new Set([164, 165, 197]);
const MILESTONES = new Set([150, 225, 300]);
const FARM_KINDS = new Set(['herb', 'mine', 'fishing', 'cloth', 'drop']);
// Material kinds that come from killing mobs (materials.js sourceOf).
const MOB_KINDS = new Set(['cloth', 'drop']);
// Node materials (herbs, ores and the gems and secondary herbs found with them).
const NODE_KINDS = new Set(['herb', 'mine']);
// A node material found in fewer than this many nodes in a hundred is no farming
// spot: the guide says how rare it is and sends the player to the Auction House.
const RARE_NODE = 10;
// Brackets up to this cap farm nodes and skin beasts per starting area
// (gathering/groups.js RACE_GROUPS: the start zone, else the next one), not per
// faction.
const LOCAL_CAP = 150;
const LOCAL_KINDS = new Set(['herb', 'mine', 'skinning']);
// ...in a zone with at least this many of its nodes (three Mageroyal in Elwynn
// Forest are no patch to farm 77 from), and at least MIN_LOCAL_UP of them up at
// once (Loch Modan lists seven Iron Deposit points but keeps under two up).
const MIN_LOCAL_PTS = 8;
const MIN_LOCAL_UP = 3;
const MAX_PTS = 30;
// Nodes up at once count up to this many: past it a zone is as good as another, and
// Zephras Isle (no spawn pools: all 146 Silverleaf up) does not outweigh the mainland.
const MAX_UP = 20;
const NEAR_BEST = 0.7;
// A node zone above the bracket's starting level stays out while the zones under it
// hold at least this share of the best (farmSpot `opts.maxZone`).
const LEVEL_CAP_SHARE = 0.5;
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
// Hostile mobs whose kill costs reputation a player wants (the world DB's
// creature_onkill_reputation): every Timbermaw furbolg costs 25 Timbermaw
// Hold reputation, whose tunnels lead to Moonglade and Everlook (Qia's
// patterns) and whose quartermaster sells Timbermaw patterns. Never a farm
// spot (Runecloth went to Timbermaw Ursa in Azshara).
const PROTECTED_MOBS = new Set([6184, 6185, 6186, 6187, 6188, 6189, 6651, 11516, 11552, 11553, 11555, 11557, 11558]);
// Cloth comes from humanoids of its band (describe.js CLOTH_LEVELS); a mob
// this many levels outside it is a different player's farm (Mageweave went
// to the Shadowsworn Adepts of the Blasted Lands, level 52-53).
const CLOTH_SLACK = 2;

function slug(name) {
	return String(name).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
}

function quote(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"')}"`;
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
// whose (drop chance x how many there are) is highest on an outdoor zone,
// preferring zones that side can work in (ZONES side) and the faction's home
// continent (where its capital trainer stands). Mobs and objects count their
// spawn points; herbs and veins count the nodes the zone keeps up at once
// (gathering/node-abundance.json: The Barrens lists 8 Mithril points but keeps
// under two up, The Hinterlands keeps seventeen). Mob and object sources need
// REAL_DROP percent or more (a 0.1% drop from a murloc that spawns everywhere is
// not where pearls come from): a material only rarer sources drop has no spot.
// `opts.maps` (a Set) keeps spots on those maps (a starting area); `opts.maxLevel`
// leaves out mobs above that level (a level-48 mob is no spot for skill 150);
// `opts.minPts` skips zones with fewer spawn points, `opts.minUp` node zones
// keeping fewer up at once.
// -> { map, x, y, label, level, object, chance, frame } | null; `frame` 'l' is a
// point in Forever's live frame (Zephras Isle, Mulgore), written `live`.
function farmSpot(itemId, kind, side, home, data, minChance = 0, opts = {}) {
	const it = (data.items || {})[itemId];
	if (!it || !it.drops) return null;
	const zones = data.zones || {};
	const frames = (data.mapFrames && data.mapFrames.era) || {};
	const cands = [];
	const consider = (entity, chance, label, level, mob, node = false) => {
		for (const [map, s] of Object.entries(entity.spawns || {})) {
			const z = zones[map];
			if (!z || z.type !== 3 || !s.pts || !s.pts.length) continue;
			if (opts.maps && !opts.maps.has(Number(map))) continue;
			const pts = mob ? outsideTowns(s.pts, Number(map), data) : s.pts;
			if (!pts.length || (opts.minPts && pts.length < opts.minPts)) continue;
			const up = node ? Math.min(D.nodesUp(data, map, label, pts.length), MAX_UP) : Math.min(pts.length, MAX_PTS);
			// A map without a spawn-pool table has only its points to go by (minPts above).
			if (up <= 0 || (node && opts.minUp && D.nodeTable(data, map) && up < opts.minUp)) continue;
			const c = frames[map] ? frames[map].c : null;
			const score = (chance / 100) * up * (c === home ? 1 : 0.25) * (zoneFriendly(Number(map), side) ? 1 : 0.3);
			cands.push({ score, map: Number(map), pts, label, level, id: entity.id, chance, f: s.f });
		}
	};
	if (kind === 'herb' || kind === 'mine' || kind === 'fishing') {
		const role = kind;
		const nodes = Object.entries(it.drops.object || {})
			.map(([oid, chance]) => [(data.objects || {})[oid], chance])
			.filter(([o]) => o && (o.roles || []).includes(role));
		// The node a gatherer reaches first: Dense Stone from Small Thorium Veins
		// (skill 245), not the Rich Thorium Veins (275) that drop it too.
		const skill = (o) => D.nodeSkill(o.name);
		const low = Math.min(...nodes.map(([o]) => skill(o)).filter((v) => v != null));
		for (const [o, chance] of nodes) {
			if (skill(o) != null && skill(o) > low) continue;
			consider(o, Number(chance) || 0, o.name, null, false, role !== 'fishing');
		}
	} else {
		const real = (c) => Number(c) >= Math.max(minChance, REAL_DROP);
		const band = kind === 'cloth' ? D.CLOTH_LEVELS[it.name] : null;
		const npcSources = Object.entries(it.drops.npc || {}).filter(([nid, chance]) => {
			const n = (data.npcs || {})[nid];
			// faction null is hostile or neutral; A/H/AH are friendly to someone.
			if (!n || n.faction != null || (n.rank || 0) > 0 || (n.roles || []).length || Number(chance) < minChance) return false;
			if (PROTECTED_MOBS.has(Number(nid))) return false;
			if (opts.maxLevel && n.level > opts.maxLevel) return false;
			return !band || (n.level >= band[0] - CLOTH_SLACK && (n.levelMax || n.level) <= band[1] + CLOTH_SLACK);
		});
		// Chests are random loot; anything else droppable that is not a node is clickable (clams).
		const objSources = Object.entries(it.drops.object || {}).filter(([oid, chance]) => {
			const o = (data.objects || {})[oid];
			const roles = (o && o.roles) || [];
			return o && real(chance) && (!roles.length || (o.name && /Clam/.test(o.name)));
		});
		// Below REAL_DROP a mob is no farm spot (a Black Pearl at 0.2% from Silt
		// Crawlers is two hundred kills a pearl): no spot, and the guide says so.
		for (const [nid, chance] of npcSources) {
			if (!real(chance)) continue;
			const n = data.npcs[nid];
			const level = n.levelMax && n.levelMax !== n.level ? `${n.level}-${n.levelMax}` : `${n.level}`;
			consider(n, Number(chance) || 0, n.name, level, true);
		}
		for (const [oid, chance] of objSources) consider({ ...data.objects[oid], object: true }, Number(chance) || 0, data.objects[oid].name, null, false);
	}
	if (!cands.length) return null;
	cands.sort((a, b) => b.score - a.score || a.id - b.id || a.map - b.map);
	const lvl = (c) => (ZONES[c.map] ? ZONES[c.map].min : 99);
	// `opts.maxZone`: zones a character of that level works in (ZONES min level), kept while
	// their best is at least half the overall best (Goldthorn at Expert: Arathi, not Feralas;
	// Small Thorium has no zone under 45 worth the trip, so the cap gives way).
	let pool = cands;
	if (opts.maxZone) {
		const within = cands.filter((c) => lvl(c) <= opts.maxZone);
		if (within.length && within[0].score >= cands[0].score * LEVEL_CAP_SHARE) pool = within;
	}
	// Among spots nearly as good as the best, the lowest-level zone (ZONES min
	// level) is the one a character gathering these materials is likely near.
	const best = pool.filter((c) => c.score >= pool[0].score * NEAR_BEST).sort((a, b) => lvl(a) - lvl(b) || b.score - a.score || a.id - b.id || a.map - b.map)[0];
	const [x, y] = densest(best.pts);
	return { map: best.map, x: round1(x), y: round1(y), label: best.label, level: best.level, object: !best.level, chance: best.chance, frame: best.f === 'l' ? 'live' : 'era' };
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
// its home continent. `opts.maps` (Set of map ids) limits the zones (a
// starting area). -> { map, x, y, frame, beasts: [names], min, max } | null;
// frame 'live' for spawns the Era map frames lack (Zephras Isle), else 'era'.
function skinSpot(itemName, side, home, data, opts = {}) {
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
		if (opts.maps && !opts.maps.has(map)) continue;
		const pts = [];
		const names = [];
		let live = false;
		for (const name of BEASTS[map]) {
			if (tier.beast && !tier.beast.test(name)) continue;
			for (const n of byName.get(name) || []) {
				if (n.faction != null || (n.rank || 0) > 0) continue;
				if (!(n.level >= tier.min && n.level <= tier.max)) continue;
				const s = n.spawns && n.spawns[map];
				if (!s || !s.pts || !s.pts.length) continue;
				pts.push(...outsideTowns(s.pts, map, data));
				if (s.f === 'l') live = true;
				if (!names.includes(name)) names.push(name);
			}
		}
		if (!pts.length) continue;
		const c = frames[map] ? frames[map].c : null;
		const score = Math.min(pts.length, MAX_PTS * 2) * (c === home ? 1 : 0.25) * (zoneFriendly(map, side) ? 1 : 0.3);
		if (!best || score > best.score) best = { score, map, pts, names, live };
	}
	if (!best) return null;
	const [x, y] = densest(best.pts);
	return { map: best.map, x: round1(x), y: round1(y), frame: best.live ? 'live' : 'era', beasts: best.names.sort(), min: tier.min, max: tier.max };
}

// Wraps `text` into `#` comment lines of at most `width` characters.
function commentLines(text, width = 100) {
	const out = [];
	let cur = '';
	for (const word of String(text).split(/\s+/).filter(Boolean)) {
		if (cur && cur.length + 1 + word.length > width - 2) {
			out.push(`# ${cur}`);
			cur = word;
		} else cur = cur ? `${cur} ${word}` : word;
	}
	if (cur) out.push(`# ${cur}`);
	return out;
}

function colorAt(r, k) {
	if (k < r.yellow) return 'orange';
	if (k < r.green) return 'yellow';
	if (k < r.grey) return 'green';
	return 'grey';
}

// "3 Bolt of Linen Cloth" list of a recipe's reagents.
function reagentList(r, matName) {
	return D.list(r.reagents.map((g) => `${g.count} ${matName(g.item)}`));
}

function draftGuide(name, data, opts = {}) {
	const profs = data.professions || {};
	const prof = Object.values(profs).find((p) => p && String(p.name).toLowerCase() === String(name).toLowerCase());
	if (!prof) throw new Error(`unknown profession "${name}"`);
	if (!CRAFTING.has(prof.id)) throw new Error(`${prof.name} is not a crafting profession (Alchemy, Blacksmithing, Enchanting, Engineering, Leatherworking, Tailoring)`);
	const spec = opts.spec || SPECS[prof.name] || {};
	// spec.to: the plan stops there and the last step explains the rest (the
	// recipes past it cost far more per point than anything a player would do).
	const planTo = Math.min(opts.to || 300, spec.to || 300);
	const auction = spec.auction || {};
	const plan = planProfession(prof, data, { from: opts.from, to: planTo, exclude: { ...(spec.exclude || {}), ...(opts.exclude || {}) }, noLevel: spec.noLevel || {}, questRecipes: spec.questRecipes || {}, auction, notBefore: spec.notBefore || {} });
	const goal = opts.to || 300;
	const npcs = data.npcs || {};
	const zones = data.zones || {};
	const frames = (data.mapFrames && data.mapFrames.era) || {};
	const mats = prof.materials || {};
	const P = prof.name;
	const pq = /\s/.test(P) ? quote(P) : P;
	const out = [];
	// `sink` is where `line` writes: a rank step held back for the one-visit
	// order (below) is written aside and placed after the bracket's shopping.
	let sink = out;
	const line = (s = '') => sink.push(s);
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
	// A node material with a rare chance per node (farmSpot `chance`): how rare, where.
	const rareText = (item, s) => {
		const nodes = D.nodeNames(data, ((mats[item] || {}).gather || {})[s.kind] || []);
		const gather = s.kind === 'herb' ? 'picking herbs' : 'mining';
		return `${matName(item)} turns up in about one ${D.list(nodes.length ? nodes : [s.label]).replace(/ and ([^,]+)$/, ' or $1')} in ${Math.round(100 / s.chance)}: buy it at the Auction House, or keep the ones you find while ${gather}`;
	};
	// Home continent per faction (where its capital trainer stands): farming spots prefer it.
	const homeOf = (side) => {
		const main = prof.mainTrainer && prof.mainTrainer[side];
		const at = anchor(npcs[main]);
		return at && frames[at.map] ? frames[at.map].c : side === 'Alliance' ? 0 : 1;
	};
	// Where a material with no farming spot comes from: a drop no mob or object
	// gives at REAL_DROP percent (Black Pearl) is a rare find, not its first dropper's.
	const rareDrop = (item) => {
		const d = ((data.items || {})[item] || {}).drops || {};
		return ![...Object.values(d.npc || {}), ...Object.values(d.object || {})].some((c) => Number(c) >= REAL_DROP);
	};
	const noSpot = (item, src, side) =>
		src.kind === 'drop' && rareDrop(item) ? `${matName(item)} is a rare drop (no mob gives it one time in ${Math.round(100 / REAL_DROP)}): buy it at the Auction House, or keep the ones you find` : D.sourceText(data, item, mats[item], src, side);
	// A rank whose trainers have no known spawn is trained at a named NPC.
	const fixedTrainer = (rankIdx) => {
		const rank = prof.ranks[rankIdx] || {};
		const ids = [...new Set(SIDES.flatMap((s) => (rank.trainers && rank.trainers[s]) || []))];
		if (!ids.length || ids.some((id) => anchor(npcs[id]))) return null;
		return ids.sort((a, b) => a - b)[0];
	};
	// What learning a recipe costs, in words.
	const priceOf = (r) => {
		if (r.source === 'vendor') return r.cost ? D.money(r.cost) : 'its vendor price';
		if (r.cost != null) return D.money(r.cost);
		return null; // a trainer price Forever's data does not have
	};
	const learnWhen = (r) => `${r.name} (from ${r.learnedAt}${priceOf(r) ? `, ${priceOf(r)}` : ''})`;
	// A rank's price: Forever's (trainer lists), else the spec's `rankCost` (Classic's).
	const rankPrice = (rank) => {
		if (rank.cost) return { cost: rank.cost, classic: false };
		const c = (spec.rankCost || {})[rank.name];
		return c ? { cost: c, classic: true } : null;
	};

	// Brackets and their totals.
	const brackets = [];
	for (const seg of plan.segments) {
		const cap = CAPS.find((c) => c > seg.from) || 300;
		let b = brackets[brackets.length - 1];
		if (!b || b.cap !== cap) brackets.push((b = { cap, from: seg.from, segments: [] }));
		b.segments.push(seg);
	}
	const needs = (seg) => {
		const seen = new Set();
		return [...seg.make.map((m) => m.recipe), seg.recipe].filter((r) => (seen.has(r.spell) ? false : (seen.add(r.spell), true)));
	};
	const learnedFree = new Set(prof.recipes.filter((r) => r.source === 'trainer' && r.learnedAt <= 1 && r.cost === 0).map((r) => r.spell));
	for (const b of brackets) {
		const totals = new Map(); // item -> { item, count, src: { side: source } }
		for (const seg of b.segments) {
			for (const n of seg.need) {
				const t = totals.get(n.item);
				if (t) t.count += n.count;
				else totals.set(n.item, { item: n.item, count: n.count, src: n.src, uses: [] });
				const tt = totals.get(n.item);
				for (const u of n.uses || [seg.recipe.name]) if (!tt.uses.includes(u)) tt.uses.push(u);
			}
		}
		b.list = [...totals.values()].sort((a, c) => a.item - c.item);
		b.vendorCost = 0;
		for (const t of b.list) {
			if (SIDES.every((s) => t.src[s].kind === 'vendor')) b.vendorCost += Math.max(...SIDES.map((s) => t.src[s].cost)) * t.count;
		}
		b.recipes = [];
		for (const seg of b.segments) for (const r of needs(seg)) if (!learnedFree.has(r.spell) && !b.recipes.includes(r) && !brackets.some((o) => o !== b && o.recipes && o.recipes.includes(r))) b.recipes.push(r);
		b.learnCost = b.recipes.reduce((a, r) => a + (r.cost || 0), 0);
		b.unpriced = b.recipes.filter((r) => r.source === 'trainer' && r.cost == null);
		b.gathered = b.list.filter((t) => !SIDES.every((s) => t.src[s].kind === 'vendor'));
	}
	// A herb, ore or hide leather that the bracket before also gathers is picked
	// there in one go (152 Briarthorn at 75-150, not 128 and then 24 more at the
	// same patch after Expert): its later count moves to the earliest bracket
	// that gathers it. Ore moves only as a top-up (no more than the earlier
	// count): 234 Heavy Stone stays after Expert rather than 262 Iron Deposits
	// before it. Cloth never moves (Runecloth by the thousand).
	const NODE = new Set(['herb', 'mine', 'skinning']);
	for (let i = brackets.length - 1; i > 0; i--) {
		const b = brackets[i];
		const prev = brackets[i - 1];
		for (const t of b.gathered.slice()) {
			if (!SIDES.every((s) => NODE.has(t.src[s].kind))) continue;
			const p = prev.gathered.find((x) => x.item === t.item);
			if (!p) continue;
			if (SIDES.some((s) => t.src[s].kind === 'mine') && t.count > p.count - (p.ahead || []).reduce((a, x) => a + x.count, 0)) continue;
			p.count += t.count;
			for (const u of t.uses) if (!p.uses.includes(u)) p.uses.push(u);
			p.ahead = [...(p.ahead || []), { count: t.count, from: b.from, cap: b.cap }, ...(t.ahead || [])];
			b.list = b.list.filter((x) => x !== t);
			b.gathered = b.gathered.filter((x) => x !== t);
		}
	}

	// ------------------------------------------------------------ header
	line(header('guide', `profession draft ${P} --out`, "Forever's client tables, trainer lists and data/forever"));
	line(`guide forever/professions/${slug(P)}`);
	line(`title ${P} 1-300`);
	line('category Professions');
	line('levels 5-60');
	line('zone Azeroth');
	line('');
	for (const para of spec.intro || []) {
		for (const l of commentLines(para)) line(l);
		line('#');
	}
	line('# Route (crafts are expected counts; yellow and green crafts can take more):');
	for (const s of plan.segments) {
		const r = s.recipe;
		const how = auction[r.spell] ? 'pattern from the Auction House' : r.source === 'vendor' ? `recipe ${priceOf(r)}` : r.source === 'quest' ? `quest, ${D.list(r.quest.items.map((g) => `${g.count} ${matName(g.item)}`))}` : r.learnedAt <= 1 && !r.cost ? 'known' : `trainer${r.cost != null ? ` ${D.money(r.cost)}` : ''}`;
		line(`#   ${String(s.from).padStart(3)}-${String(s.to).padEnd(3)} ${r.name}, about ${s.count} (${how}): ${reagentList(r, matName)} each`);
	}
	if (plan.reach < goal) line(`#   ${String(plan.reach).padStart(3)}-${goal} ${spec.lastRoute || 'no trainer or vendor recipe gives points without a camp station'} (see the last step)`);
	line('#');
	line('# Shopping per bracket (vendor goods at vendor prices; gathered or dropped materials by count):');
	for (const b of brackets) {
		const rank = prof.ranks[CAPS.indexOf(b.cap)] || {};
		const parts = [];
		const rp = rankPrice(rank);
		if (rp) parts.push(`${rank.name} ${D.money(rp.cost)}${rp.classic ? ' (Classic price)' : ''}`);
		if (b.learnCost) parts.push(`recipes ${D.money(b.learnCost)}${b.unpriced.length ? ' plus unpriced trainer recipes' : ''}`);
		else if (b.unpriced.length) parts.push('trainer recipes (prices not in the data)');
		if (b.vendorCost) parts.push(`vendor goods ${D.money(b.vendorCost)}`);
		const g = b.gathered.map((t) => `${t.count} ${matName(t.item)}`);
		for (const l of commentLines(`  ${b.from}-${b.cap}: ${parts.join(', ') || 'nothing to buy'}${g.length ? `; gather or buy ${D.list(g)}` : ''}.`)) line(l);
	}
	line('#');
	const estimated = plan.segments.flatMap((s) => needs(s)).filter((r, i, a) => r.learnedAtEstimated && a.indexOf(r) === i);
	const notes = [
		"Data: recipes, colours and reagents from the Forever client's tables; trainer learn skills and prices from Forever's sniffed trainer lists (they reach skill 50-150); vendors, stock and drops from data/forever. Materials are valued at about four times their vendor sell price (cloth and leather by the square root of it, hides four times higher; tools/lib/professions/materials.js) to rank recipes against each other, never as a price forecast.",
		...(estimated.length
			? [
					`ASSUMED: learn skills of ${D.list(estimated.map((r) => `${r.name} ${r.learnedAt}`))} (no sniffed Forever list teaches them: Classic's trainer skill moved as far as Forever moved the recipe's colours, which the sniffed lists bear out on 126 of 129 recipes). In-game check: the skill the trainer asks; their prices are not in the data.`,
				]
			: []),
		// Forever's sniffed trainer lists ask level 1 for Apprentice, and 10 for Journeyman only in
		// the Blacksmithing, Leatherworking and Tailoring lists: the other gates are Classic's.
		`ASSUMED: rank level gates ${D.list(prof.ranks.filter((r) => r.minLevel > 1 && !(r.name === 'Journeyman' && JOURNEYMAN_SNIFFED.has(prof.id))).map((r) => `${r.name} ${r.minLevel}`))} (Classic's; Forever's sniffed lists ask level 1 for Apprentice${JOURNEYMAN_SNIFFED.has(prof.id) ? ' and 10 for Journeyman' : ''}). In-game check: the level each trainer asks.`,
		...(spec.assumed || []),
	];
	for (const n of notes) for (const l of commentLines(n)) line(l);

	// ------------------------------------------------------------ brackets
	const learned = new Set(learnedFree);
	const toolsDone = new Set();
	const bought = new Set(); // vendor recipes already bought
	let gate = 5; // character level the guide has asked for so far
	let campDone = !spec.camp;
	const questsTaken = new Set(); // recipe quests (and the quests before them) already in the guide
	// The camp recipe's learn goals: one spell, or one per faction (Faction Banner).
	const campLearn = () => {
		campDone = true;
		const c = spec.camp;
		return c.spells ? c.spells.map((x) => `  learn ${x.spell} only ${x.only}`) : [`  learn ${c.spell}`];
	};
	// The camp tip at skill `s`: the spec's text, and whether the recipe still gives points then.
	const campTip = (s) => {
		const c = spec.camp;
		const r = prof.recipes.find((x) => x.spell === (c.spells ? c.spells[0].spell : c.spell));
		const pts = r && r.grey > s ? ` At ${s} it still gives points until ${r.grey}: make one or two now.` : '';
		return `${c.tip}${pts}`;
	};
	// spec.notes: text added to the craft step whose range holds `at` (or the first after it).
	const pendingNotes = (spec.notes || []).slice().sort((a, c) => a.at - c.at);

	brackets.forEach((b, bi) => {
		const rankIdx = CAPS.indexOf(b.cap);
		const rank = prof.ranks[rankIdx] || { name: RANK_NAMES[rankIdx], max: b.cap, minLevel: 1, minSkill: 0 };
		const trainRank = bi === 0 || b.from >= ((prof.ranks[rankIdx - 1] || {}).max || CAPS[rankIdx - 1]);
		const tools = [];
		for (const seg of b.segments) for (const t of seg.tools) if (!t.craft && !toolsDone.has(t.item)) tools.push(t.item);
		const vendorRecipes = [];
		for (const seg of b.segments) for (const r of needs(seg)) if (r.source === 'vendor' && !bought.has(r.spell) && !vendorRecipes.includes(r)) vendorRecipes.push(r);
		const firstLearn = [];
		for (const seg of b.segments) for (const r of needs(seg)) if (r.source === 'trainer' && !learned.has(r.spell) && r.learnedAt <= b.from && !firstLearn.includes(r)) firstLearn.push(r);
		const fixed = trainRank ? fixedTrainer(rankIdx) : null;
		// One visit: a rank only a few far-off trainers teach (Expert and Artisan
		// Alchemy, Expert Enchanting) whose later recipes in the bracket those same
		// trainers teach. The player gathers first, trains the rank, crafts there
		// and learns each recipe on reaching its skill, instead of a trip per
		// recipe. Not for recipes that need a station (anvil, forge). A learn pinned
		// to another rank's trainers (spec.taughtBy: Rugged Leather at Drakk
		// Stonehand or Hahrana Ironhide) keeps its own trip, when it comes after the
		// bracket's other learns.
		const few = rankIdx >= 2 && SIDES.map((s) => D.rankTrainers(data, rank, s, prof)).every((l) => l.length && l.length <= 4);
		const lateAll = [];
		for (const seg of b.segments) for (const r of needs(seg)) if (r.source === 'trainer' && !learned.has(r.spell) && !firstLearn.includes(r) && !lateAll.includes(r)) lateAll.push(r);
		const teachesHere = (r) => {
			const rk = prof.ranks.find((x) => x && x.trainers && x.max >= r.learnedAt);
			return !!rk && SIDES.every((s) => ((rank.trainers || {})[s] || []).every((id) => ((rk.trainers || {})[s] || []).includes(id)));
		};
		const pinnedHere = (r) => !!(spec.taughtBy || {})[r.spell];
		const lateHere = lateAll.filter((r) => !pinnedHere(r));
		const lateFrom = (rs) => b.segments.filter((seg) => needs(seg).some((r) => rs.includes(r))).map((seg) => seg.from);
		const pinnedLate = lateAll.filter(pinnedHere);
		const oneVisit =
			trainRank &&
			!fixed &&
			few &&
			lateHere.length > 0 &&
			lateHere.every(teachesHere) &&
			(!pinnedLate.length || Math.min(...lateFrom(pinnedLate)) > Math.max(...lateFrom(lateHere))) &&
			!b.segments.some((seg) => needs(seg).some((r) => r.focus));
		const visits = new Set(lateFrom(lateHere)).size + 1;

		line('');
		line(`# ---------------------------------------------------------------- ${rank.name} (${b.from}-${b.cap})`);

		// 1. The rank and the recipes learnable now (held back to after the
		// gathering on a one-visit bracket).
		const held = [];
		if (oneVisit) sink = held;
		line('');
		line(`step ${trainRank ? (bi === 0 ? `Learn ${P}` : `${rank.name} ${P}`) : `${P} recipes for ${b.from}-${b.cap}`}`);
		if (!oneVisit) world();
		const tip = [];
		if (trainRank) {
			const who = (() => {
				if (fixed) return TRAINER_NOTES[(npcs[fixed] || {}).name] || `${D.npcPlace(data, fixed)} teaches it`;
				const lists = SIDES.map((s) => D.rankTrainers(data, rank, s, prof));
				if (rankIdx >= 2 && lists.every((l) => l.length && l.length <= 4)) return `Only a few trainers teach it: Alliance ${D.list(lists[0])}; Horde ${D.list(lists[1])}. The arrow picks the nearest of your faction`;
				// Journeyman: the starting-town trainers (Smith Argus, Dwukk) teach Apprentice only.
				const all = SIDES.map((s) => new Set(((prof.trainers || {})[s]) || []));
				const some = SIDES.some((s, i) => ((rank.trainers || {})[s] || []).length && ((rank.trainers || {})[s] || []).length < all[i].size);
				if (some && lists.every((l) => l.length)) return `Not every ${P} trainer teaches it: Alliance ${D.list(lists[0])}; Horde ${D.list(lists[1])}. The arrow picks the nearest of your faction`;
				return `Any ${P} trainer of your faction teaches it; the arrow picks the nearest`;
			})();
			const rp = rankPrice(rank);
			const price = rp ? ` for ${D.money(rp.cost)}${rp.classic ? " (Classic's price; Forever's is not in the data)" : ''}` : '';
			if (bi === 0) tip.push(`${rank.name} ${P} lets you craft up to ${rank.max}${price}, ${rank.minLevel > 1 ? `from character level ${rank.minLevel}` : 'at any character level'}. ${who}.`);
			else tip.push(`${rank.name} raises the cap from ${(prof.ranks[rankIdx - 1] || {}).max || CAPS[rankIdx - 1]} to ${rank.max}${price}; it needs ${P} ${rank.minSkill} and character level ${rank.minLevel}, so you can take it on any visit from ${rank.minSkill}. ${who}.`);
		}
		if (firstLearn.length) tip.push(`Learn now: ${D.list(firstLearn.map(learnWhen))}.`);
		if (bi === 0 && spec.apprentice) tip.push(spec.apprentice);
		if (!campDone && spec.camp && b.from >= spec.camp.at) {
			tip.push(campTip(b.from));
		}
		const shopping = [];
		const mny = [];
		if (b.learnCost) mny.push(`${D.money(b.learnCost)} of recipes`);
		if (b.vendorCost) mny.push(`${D.money(b.vendorCost)} of vendor goods`);
		if (mny.length) shopping.push(`about ${D.list(mny)}`);
		if (b.gathered.length) shopping.push(`${D.list(b.gathered.map((t) => `${t.count} ${matName(t.item)}`))} to gather or buy`);
		if (shopping.length) tip.push(`${b.from}-${b.cap} takes ${shopping.join(', plus ')}.`);
		if (oneVisit) {
			const later = pinnedLate.length ? ` ${D.list(pinnedLate.map(learnWhen))} takes a second trip, to other trainers (below).` : '';
			tip.push(`Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach ${D.list(lateHere.map(learnWhen))}, and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of ${visits}.${later}`);
		}
		line(`  tip ${tip.join(' ')}`);
		if (trainRank && rank.minLevel > gate) {
			line(`  level ${rank.minLevel}`);
			gate = rank.minLevel;
		}
		if (trainRank) {
			if (fixed) line(`  train ${fixed}`);
			else line(`  train ${pq} ${rank.name}`);
			if (bi === 0) line(`  skill ${pq} 1`);
		}
		// A fixed trainer (no spawn in the data: Annora) teaches the rank step's recipes too.
		const pin = (r, npc) => (npc && r.learnedAt > (CAPS[rankIdx - 1] || 0) ? ` npc ${npc}` : '');
		for (const r of firstLearn) line(`  learn ${r.spell}${fixed ? ` npc ${fixed}` : ''}`);
		if (!campDone && spec.camp && b.from >= spec.camp.at) for (const l of campLearn()) line(l);
		for (const r of firstLearn) learned.add(r.spell);
		sink = out;

		// 2. Vendor goods for the whole bracket, and (optional) the vendor half of a bar a miner
		// smelts (Coal for Steel Bars: Smelt Steel takes an Iron Bar and a Coal).
		const buys = b.list.filter((t) => SIDES.some((s) => t.src[s].kind === 'vendor'));
		const mining = Object.values(profs).find((p) => p && p.name === 'Mining');
		const smeltBuys = [];
		for (const t of b.list) {
			if (!SIDES.every((s) => t.src[s].kind === 'crafted')) continue;
			const r = mining && (mining.recipes || []).find((x) => x.item === t.item && (x.reagents || []).length);
			for (const g of (r && r.reagents) || []) {
				const m = (mining.materials || {})[g.item] || {};
				if (!(m.buy > 0) || !SIDES.every((s) => ((m.vendors || {})[s] || []).length)) continue;
				smeltBuys.push({ item: g.item, name: m.name, count: Math.ceil((t.count * g.count) / (r.itemCount || 1)), cost: (m.buy / (m.buyCount || 1)) * Math.ceil((t.count * g.count) / (r.itemCount || 1)), bar: matName(t.item), bars: t.count, skill: r.learnedAt, other: r.reagents.filter((x) => x.item !== g.item).map((x) => ((mining.materials || {})[x.item] || {}).name).filter(Boolean) });
			}
		}
		if (buys.length || smeltBuys.length) {
			line('');
			line(`step ${P} ${b.from}-${b.cap}: vendor goods`);
			world();
			const each = buys.map((t) => {
				const tool = tools.includes(t.item);
				const m = mats[t.item] || {};
				const unit = m.buy > 0 ? m.buy / (m.buyCount || 1) : 0;
				return tool ? `${matName(t.item)} (a tool: one, kept in your bags${unit ? `, ${D.money(m.buy)}` : ''})` : `${t.count} ${matName(t.item)}${unit ? ` (${D.money(unit * t.count)})` : ''}`;
			});
			const town = SIDES.map((s) => {
				const names = [...new Set(buys.flatMap((t) => D.townVendors(data, prof, t.item, mats[t.item], s)))];
				const at = D.mainTown(data, prof, s);
				return names.length && at ? `${at}: ${D.list(names.slice(0, 3))}` : null;
			}).filter(Boolean);
			const oneSide = buys.filter((t) => !SIDES.every((s) => t.src[s].kind === 'vendor'));
			const parts = [];
			if (buys.length) parts.push(`Buy the whole bracket's share in one go: ${D.list(each)}${b.vendorCost ? `; about ${D.money(b.vendorCost)} in all` : ''}. The arrow picks the nearest seller of your faction${town.length ? ` (${town.join('; ')})` : ''}.${oneSide.length ? ` ${D.list(oneSide.map((t) => matName(t.item)))}: no vendor of the other faction sells ${oneSide.length > 1 ? 'them' : 'it'}; that side gathers or buys ${oneSide.length > 1 ? 'them' : 'it'} at the Auction House (next steps).` : ''}`);
			for (const s of smeltBuys) parts.push(`If you smelt the ${s.bars} ${s.bar} yourself (Mining ${s.skill}: ${D.list([...s.other, s.name].map((n) => D.article(n)))} each), buy ${s.count} ${s.name} too (${D.money(s.cost)}, trade and blacksmithing suppliers); skip ${s.count > 1 ? 'them' : 'it'} if you buy the bars.`);
			line(`  tip ${parts.join(' ')}`);
			for (const t of buys) {
				const kinds = SIDES.map((side) => t.src[side].kind);
				const tool = tools.includes(t.item);
				const count = tool ? '' : ` x${t.count}`;
				const what = tool ? ' -- a tool, keep it in your bags' : '';
				if (kinds.every((k) => k === 'vendor')) line(`  buy ${t.item}${count} nearest${what}`);
				else SIDES.forEach((side, i) => kinds[i] === 'vendor' && line(`  buy ${t.item}${count} nearest only ${side}${what}`));
			}
			for (const s of smeltBuys) line(`  buy ${s.item} x${s.count} nearest optional`);
		}
		for (const t of tools) toolsDone.add(t);

		// 3. Recipe items from vendors.
		for (const r of vendorRecipes) {
			bought.add(r.spell);
			const m = mats[r.recipeItem] || {};
			const perSide = SIDES.map((side) => {
				const free = ((m.vendors && m.vendors[side]) || []).map((id) => D.npcPlace(data, id)).filter(Boolean);
				const lim = ((m.limitedVendors && m.limitedVendors[side]) || []).map((id) => D.npcPlace(data, id)).filter(Boolean);
				return D.list([...new Set([...free, ...lim.map((n) => `${n}, limited stock`)])].sort().slice(0, 4));
			});
			const sellers = perSide[0] === perSide[1] ? [perSide[0]] : SIDES.map((side, i) => (perSide[i] ? `${side}: ${perSide[i]}` : null)).filter(Boolean);
			const limitedOnly = SIDES.some((side) => !((m.vendors && m.vendors[side]) || []).length && ((m.limitedVendors && m.limitedVendors[side]) || []).length);
			line('');
			line(`step ${m.name || `Recipe for ${r.name}`}`);
			world();
			const stock = limitedOnly ? ` Its sellers keep one or two in stock that come back some time after a sale${m.bop ? '; it binds when picked up, so the Auction House never has it' : '; the Auction House often has it too'}.` : '';
			const soldBy = sellers.filter(Boolean).length ? ` Sold by ${sellers.filter(Boolean).join('; ')}.` : '';
			line(`  tip ${m.name || 'The recipe'} teaches ${r.name} (${P} ${r.learnedAt}) for ${priceOf(r)}.${soldBy}${stock}`);
			line(`  buy ${r.recipeItem} nearest`);
		}

		// 4. Gathered and dropped materials. Mob drops the compiler can place
		// (`data.farmable(item)` -> { Alliance, Horde }: a qualifying farm spot
		// safe for that side) become one `collect … nearest` step that the
		// engine resolves by level, faction and travel time. Nodes, fish and the
		// rest keep a farming spot per faction where the spots differ.
		const shared = new Map(); // item -> where it comes from, for materials with no farm spot
		for (const t of b.list) {
			const kinds = SIDES.map((side) => t.src[side].kind);
			if (kinds.every((k) => k === 'vendor')) continue;
			const need = SIDES.filter((side, i) => kinds[i] !== 'vendor');
			const ahead = (t.ahead || []).map((a) => `${a.count} of them for ${a.from}-${a.cap}`);
			const forWhat = `${t.count} ${matName(t.item)} for ${D.list(t.uses)}${ahead.length ? ` (${D.list(ahead)}: pick them all now)` : ''}`;
			// Cloth: counted in the bags, from humanoids of its band as the character
			// levels, or the Auction House. No farm spot: a trip to a named camp is a
			// long journey for what the player loots anyway; `anywhere` keeps the
			// compiler from placing the count at one dropper of hundreds.
			if (need.every((side) => t.src[side].kind === 'cloth')) {
				const lv = D.CLOTH_LEVELS[matName(t.item)];
				line('');
				line(`step ${matName(t.item)}`);
				world();
				if (need.length === 1) line(`  only ${need[0]}`);
				line(`  tip ${forWhat}: humanoids${lv ? ` of level ${lv[0]}-${lv[1]}` : ''} drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House.`);
				line(`  collect ${t.item} x${t.count} anywhere`);
				continue;
			}
			// The engine skips spots whose mobs are 3+ levels above the player; the
			// player is at least at the last `level` gate here.
			const ok = data.farmable ? data.farmable(t.item) : null;
			if (ok && need.every((side) => MOB_KINDS.has(t.src[side].kind) && ok[side] != null && ok[side] - gate < 3)) {
				line('');
				line(`step ${matName(t.item)}`);
				world();
				if (need.length === 1) line(`  only ${need[0]}`);
				line(`  tip ${forWhat}: ${D.sourceText(data, t.item, mats[t.item], t.src[need[0]], need[0])}. The arrow picks a farm spot for your level and faction.`);
				line(`  collect ${t.item} x${t.count} nearest`);
				continue;
			}
			// Droppers a character can farm by the bracket's end (skill 225: level 47 at most).
			const maxLevel = maxZoneLevel(b.cap);
			const spotFor = (side, maps = null, minPts = 0, minUp = 0) => {
				const kind = t.src[side].kind;
				if (kind === 'skinning') {
					// Beasts the data says yield it at a real rate (Turtle Scale from
					// turtles) beat the level-band guess from the curated beast lists.
					const fromData = farmSpot(t.item, 'drop', side, homeOf(side), data, SKIN_DROP_MIN, { maps, minPts });
					return fromData ? { ...fromData, skin: true } : skinSpot(matName(t.item), side, homeOf(side), data, { maps });
				}
				// Herbs and veins: zones a character at the bracket's start works in, when they are worth it.
				const maxZone = NODE_KINDS.has(kind) ? maxZoneLevel(b.from) : 0;
				return FARM_KINDS.has(kind) ? farmSpot(t.item, kind, side, homeOf(side), data, 0, { maps, maxLevel: kind === 'drop' ? maxLevel : 0, minPts, minUp, maxZone }) : null;
			};
			// A gem that turns up in one vein of a hundred (Shadowgem) is no spot to farm.
			const rare = (s) => s && NODE_KINDS.has(s.kind) && s.chance > 0 && s.chance < RARE_NODE;
			// Who goes where: one spot per faction, and while the character is still
			// near its starting area (to Journeyman) one per starting area where the
			// node grows (or the beasts roam) there or in the next zone, so a Night
			// Elf picks Peacebloom in Teldrassil and an Undead in Tirisfal, not on the
			// other continent. With neither, the group's own continent beats the
			// faction's spot across the sea (Medium Leather for an Undead in
			// Hillsbrad, not Ashenvale).
			const entries = []; // { sides, races (null: the whole faction), spot }
			const sameSpot = (a, c) => a && c && a.map === c.map && a.x === c.x && a.y === c.y;
			for (const side of SIDES) {
				if (t.src[side].kind === 'vendor') continue;
				const kind = t.src[side].kind;
				const base = spotFor(side);
				if (base) base.kind = kind;
				if (!(b.cap <= LOCAL_CAP && LOCAL_KINDS.has(kind) && base && !rare(base))) {
					entries.push({ sides: [side], races: null, spot: base });
					continue;
				}
				const local = [];
				for (const g of RACE_GROUPS[side]) {
					const near = (maps) => spotFor(side, new Set(maps), MIN_LOCAL_PTS, MIN_LOCAL_UP);
					const onContinent = () => (base && frames[base.map] && frames[base.map].c !== g.c ? near(Object.keys(frames).map(Number).filter((m) => frames[m].c === g.c)) : null);
					const s = near(g.start) || near(g.next) || onContinent() || base;
					s.kind = kind;
					const prev = local.find((e) => sameSpot(e.spot, s));
					if (prev) prev.races.push(...g.races);
					else local.push({ sides: [side], races: [...g.races], spot: s });
				}
				if (local.length === 1) entries.push({ sides: [side], races: null, spot: local[0].spot });
				else entries.push(...local);
			}
			// The same spot for both factions (Zephras Isle for the Skyborne) is one step,
			// unless only one side's Skyborne go there (Undead and the Alliance in
			// Hillsbrad: a merged `only` would send the Horde Skyborne too).
			for (let i = 0; i < entries.length; i++) {
				for (let k = entries.length - 1; k > i; k--) {
					const a = entries[i];
					const c = entries[k];
					if (!sameSpot(a.spot, c.spot) || !a.races !== !c.races) continue;
					if (a.races && [...a.races, ...c.races].some((x) => TWO_SIDED.has(x) && !(a.races.includes(x) && c.races.includes(x)))) continue;
					a.sides.push(...c.sides);
					if (a.races) a.races.push(...c.races.filter((x) => !a.races.includes(x)));
					entries.splice(k, 1);
				}
			}
			if (entries.every((e) => !e.spot || rare(e.spot)) && kinds.every((k) => k !== 'vendor')) {
				// No farming spot (disenchanting, other professions, a rare find): no
				// goal of its own (the craft step's `craft … until` needs it anyway);
				// its source goes into the tip of the first craft step that uses it.
				const r0 = entries.find((e) => rare(e.spot));
				shared.set(t.item, r0 ? rareText(t.item, r0.spot) : noSpot(t.item, t.src.Alliance, 'Alliance'));
				continue;
			}
			for (const e of entries) {
				const side = e.sides.length === 1 ? e.sides[0] : null;
				const s0 = t.src[side || 'Alliance'];
				const s = e.spot;
				if (!s || rare(s)) {
					const prev = shared.get(t.item);
					const text = `${side ? `${side}: ` : ''}${s ? rareText(t.item, s) : noSpot(t.item, s0, side || 'Alliance')}`;
					shared.set(t.item, prev ? `${prev}; ${text}` : text);
					continue;
				}
				line('');
				line(`step ${matName(t.item)}${e.races ? ` (${zoneName(s.map)})` : side ? ` (${side})` : ''}`);
				if (e.races) line(`  only ${raceCondition(e.races, e.sides)}`);
				else if (side) line(`  only ${side}`);
				const about = `${forWhat}: ${D.sourceText(data, t.item, mats[t.item], s0, side || 'Alliance', { zones: !e.races, marked: s.map })}.`;
				line(`  zone ${zoneName(s.map)}`);
				curZone = zoneName(s.map);
				const here = {
					herb: `The densest patch of ${s.label} in ${zoneName(s.map)} is marked`,
					mine: `The densest cluster of ${s.label} in ${zoneName(s.map)} is marked`,
					fishing: `Fish ${s.label} here`,
					skinning: s.beasts ? `Skin ${D.list(s.beasts)} here (level ${s.min}-${s.max}); the Skinning guide routes this` : `Kill and skin ${s.label} (level ${s.level}) here`,
				}[s0.kind] || (s.object ? `Open the ${s.label}s here` : `It drops from ${s.label} (level ${s.level}) here`);
				// A drop's own note names the first dropper in the data (often a rare or a
				// raid boss); the spot's mobs are the ones to farm.
				const dropAbout = s0.kind === 'drop' ? `${forWhat}: ${s.object ? `open the ${s.label}s at the marked spot` : `it drops from ${s.label} (level ${s.level}) at the marked spot`}, or buy it at the Auction House.` : null;
				line(`  tip ${dropAbout || `${about} ${here}.`}`);
				line(`  collect ${t.item} x${t.count} @${s.x},${s.y} ${s.frame || 'era'}`);
			}
		}
		if (oneVisit) {
			// The held rank step, back on the world map after the farming spots.
			line(held[0]);
			line(held[1]);
			world();
			for (const l of held.slice(2)) line(l);
		}

		// 5. Crafting, with a trainer visit for recipes learnable only later.
		for (const seg of b.segments) {
			const late = needs(seg).filter((r) => r.source === 'trainer' && !learned.has(r.spell));
			if (late.length) {
				const fx = fixedTrainer(rankIdx);
				line('');
				line(`step ${P} recipes at ${seg.from}`);
				world();
				const camp = !campDone && spec.camp && seg.from >= spec.camp.at;
				// spec.taughtBy: recipes only a later rank's trainers teach (Rugged
				// Leather at Drakk Stonehand or Hahrana Ironhide): the learn is pinned
				// to them, and the rank itself is offered there when the skill allows.
				const onlyAt = (r) => {
					const idx = RANK_NAMES.indexOf((spec.taughtBy || {})[r.spell]);
					return idx > 0 && prof.ranks[idx] ? { idx, rank: prof.ranks[idx] } : null;
				};
				const anywhere = late.filter((r) => !onlyAt(r));
				const pinned = late.filter((r) => onlyAt(r));
				const parts = [];
				if (anywhere.length) parts.push(oneVisit ? `Still at the ${rank.name} trainer: ${D.list(anywhere.map(learnWhen))}.` : `Back to ${D.article(P)} trainer: ${D.list(anywhere.map(learnWhen))}.`);
				let offer = null;
				for (const r of pinned) {
					const { idx, rank } = onlyAt(r);
					const who = SIDES.map((s) => `${s} ${D.list(D.rankTrainers(data, rank, s, prof))}`).join('; ');
					parts.push(`${learnWhen(r)} is taught only by the ${rank.name} trainers: ${who}.`);
					if (idx > rankIdx && seg.from >= rank.minSkill && (!offer || offer.idx < idx)) offer = { idx, rank };
				}
				if (offer) parts.push(`You can train ${offer.rank.name} there now if you are level ${offer.rank.minLevel} (it needs ${P} ${offer.rank.minSkill}), which saves the trip at ${CAPS[offer.idx - 1]}.`);
				line(`  tip ${parts.join(' ')}${camp ? ` ${campTip(seg.from)}` : ''}`);
				for (const r of anywhere) line(`  learn ${r.spell}${pin(r, fx)}`);
				for (const r of pinned) {
					const { rank } = onlyAt(r);
					const ids = SIDES.map((s) => (rank.trainers && rank.trainers[s]) || []);
					if (ids.every((l) => l.length === 1)) SIDES.forEach((s, i) => line(`  learn ${r.spell} npc ${ids[i][0]} only ${s}`));
					else line(`  learn ${r.spell}`);
				}
				if (offer) line(`  train ${pq} ${offer.rank.name} optional`);
				if (camp) for (const l of campLearn()) line(l);
				for (const r of late) learned.add(r.spell);
			}
			const r = seg.recipe;
			if (r.source === 'quest' && !learned.has(r.spell)) {
				// A quest hands over the plans (Derotain Mudsipper's Imperial Plate plans for Thorium Bars).
				const q = r.quest;
				const qs = data.quests || {};
				const giver = ((qs[q.id] || {}).start || {}).npc || [];
				const who = giver.length ? D.npcPlace(data, giver[0]) : null;
				const m = mats[r.recipeItem] || {};
				const plans = m.name || `the plans for ${r.name}`;
				const pre = q.pre.filter((id) => !questsTaken.has(id) && qs[id]);
				const preText = pre.map((id) => `${qs[id].title || `quest ${id}`} first${(qs[id].objectives || []).length ? '' : ' (it asks for nothing)'}`);
				line('');
				line(`step ${plans}`);
				// The quests' goals sit in the giver's zone (Derotain in Gadgetzan, Tanaris).
				const gmap = giver.length ? homeMap(npcs[giver[0]]) : null;
				if (gmap && zoneName(gmap)) {
					line(`  zone ${zoneName(gmap)}`);
					curZone = zoneName(gmap);
				} else world();
				line(`  tip ${who || 'A quest giver'} trades ${plans} (${P} ${r.learnedAt}) for ${D.list(q.items.map((g) => `${g.count} ${matName(g.item)}`))} in ${q.title}, which needs ${P} ${q.skill} and character level ${q.level}${preText.length ? `; take ${D.list(preText)}` : ''}.${m.bop ? ' The plans bind when picked up.' : ''}`);
				if (q.level > gate) {
					line(`  level ${q.level}`);
					gate = q.level;
				}
				for (const id of pre) {
					line(`  accept ${id}`);
					line(`  turnin ${id}`);
					questsTaken.add(id);
				}
				line(`  accept ${q.id}`);
				line(`  turnin ${q.id}`);
				questsTaken.add(q.id);
			}
			line('');
			line(`step ${r.name} to ${seg.to}`);
			world();
			const notes = [];
			const color = colorAt(r, seg.from);
			notes.push(`${r.name} is ${color} at ${seg.from} (yellow ${r.yellow}, green ${r.green}, grey ${r.grey}): about ${seg.count} crafts to ${seg.to}${color === 'orange' && seg.to <= r.yellow ? ', a point every craft' : ''}.`);
			notes.push(`Each takes ${reagentList(r, matName)}${(r.itemCount || 1) > 1 ? ` and makes ${r.itemCount}` : ''}.`);
			if (seg.make.length) {
				// Counts are items, not crafts (a Stonescale Oil craft makes two), and
				// only an intermediate that is not grey yet gives points.
				const made = seg.make.filter((m) => !seg.tools.some((t) => t.item === m.item));
				const parts = made.map((m) => {
					const each = m.recipe.itemCount || 1;
					return each > 1 ? `${m.count * each} ${m.recipe.name} (${m.count} crafts)` : `${m.count} ${m.recipe.name}`;
				});
				const live = made.filter((m) => m.recipe.grey > seg.from);
				const pts = !live.length ? '' : live.length === made.length ? `: ${made.length > 1 ? 'they give' : 'it gives'} points too while not grey` : `: ${D.list(live.map((m) => m.recipe.name))} ${live.length > 1 ? 'give' : 'gives'} points too while not grey`;
				if (parts.length) notes.push(`Make the ${D.list(parts)} first${pts}.`);
			}
			if (seg.fromStock) notes.push(`Use the ${D.list(seg.fromStock.map((s) => `${s.count} ${matName(s.item)}`))} you made earlier; the counts above leave them out.`);
			const why = (spec.tips || {})[r.spell];
			if (auction[r.spell]) notes.push(`Its pattern (${matName(r.recipeItem)}) drops from mobs all over the world and does not bind: buy it at the Auction House.`);
			if (why) notes.push(why);
			else if (r.source === 'vendor') notes.push('Its recipe is the one bought above; it is the cheapest way through these points in the data.');
			else if (r.source === 'quest') notes.push('Its plans are the quest reward above; it is the cheapest way through these points in the data.');
			else if (!auction[r.spell]) notes.push('The trainer teaches it, and it is the cheapest way through these points in the data.');
			while (pendingNotes.length && pendingNotes[0].at < seg.to) notes.push(pendingNotes.shift().text);
			if (r.focus) notes.push(`Needs ${D.article(r.focus.toLowerCase())} nearby.`);
			// A tool made here for a later recipe (plan.js makes it while it still gives a point).
			for (const t of seg.tools) notes.push(!t.craft ? `${matName(t.item)} is a tool: keep it in your bags.` : (r.tools || []).includes(t.item) ? `Make the ${matName(t.item)} first: the recipe needs it in your bags, so keep it there.` : `Make the ${matName(t.item)} now, while it still gives a point: a later recipe needs it in your bags, so keep it there.`);
			for (const n of seg.need) {
				if (!shared.has(n.item)) continue;
				const total = (b.list.find((x) => x.item === n.item) || n).count;
				notes.push(`${matName(n.item)} (${total} for ${b.from}-${b.cap}): ${shared.get(n.item)}.`);
				shared.delete(n.item);
			}
			if (r.enchant) notes.push('Enchant any item for that slot in your bags, even a grey one.');
			if (MILESTONES.has(seg.to)) notes.push(`${P} ${seg.to} is a Legacy System milestone.`);
			line(`  tip ${notes.join(' ')}`);
			for (const r2 of needs(seg)) {
				if ((r2.source === 'vendor' || r2.source === 'quest' || auction[r2.spell]) && !learned.has(r2.spell)) {
					line(`  learn ${r2.spell} -- from the ${auction[r2.spell] ? 'pattern bought at the Auction House' : 'recipe in your bags'}`);
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
		line(`  tip ${spec.last || `On Forever no recipe a trainer teaches or both factions' vendors sell gives ${P} points past ${plan.reach}, so Polestar has no route for the last points.${names.length ? ` Recipes that still do: ${names.join(', ')}.` : ''}`}`);
		line(`  skill ${pq} ${goal}`);
	}
	// Each bracket's range is a section (the guide window's heading; the guide starts at the player's skill).
	return { text: `${byBanners(out.join('\n'), P)}\n`, plan };
}

module.exports = { draftGuide, farmSpot, skinSpot, money: D.money, slug };
