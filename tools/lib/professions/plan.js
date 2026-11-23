'use strict';
// Cheapest sensible 1-300 plan for one crafting profession.
//
// Model. Crafting a recipe at skill k gives a point with probability
//   1                                  k < yellow   (orange)
//   (grey - k) / (grey - yellow)       yellow <= k < grey (yellow, then green)
//   0                                  k >= grey
// (the Classic formula), so reaching k+1 takes 1/p crafts on average. A
// segment crafts one recipe from skill s to t; its cost is the expected crafts
// times the material cost of one craft, plus a switching cost of
// SWITCH_BASE + SWITCH_CRAFTS crafts' worth of materials (another recipe to
// learn and another shopping list), plus the recipe's vendor price. A dynamic
// program over skill 1..300 picks the cheapest chain of segments.
//
// Segments end at the rank caps (75, 150, 225): the next rank is trained there.
// A recipe is usable from the skill its trainer or recipe item asks for, and
// only if both factions can get it (trainer recipes, or recipe items sold on
// both sides). Recipes needing a specialization, a race or class, or a
// special crafting station (Black Anvil, Moonwell...) are left out, as are
// recipes whose materials have no known source. Costs per faction come from
// materials.js; the plan uses the dearer side so one route serves both.
//
// A material that a usable recipe of this profession makes (bolts of cloth,
// grinding stones, tubes...) is crafted when that is cheaper than getting it.
// Crafting those intermediates gives points too while they are not grey, so a
// segment's skill per craft counts them (a Bolt of Linen Cloth per Linen Belt
// is two chances at a point, not one). Tools (Blacksmith Hammer, Runed Copper
// Rod...) are bought or crafted once.
//
// `opts.exclude` (spell -> reason) leaves recipes out by hand (tools/lib/
// professions/specs.js: a material with no dependable source on Forever, a
// recipe the guide handles apart); `opts.noLevel` (spell -> reason) keeps a
// recipe for making an intermediate or a tool but never levels on it (the
// Gyromatic Micro-Adjustor is a tool you need once); `opts.auction` (spell ->
// skill) lets a pattern that drops in the world and does not bind be bought
// at the Auction House, from that skill on (Tailoring past 265, where no
// trainer or vendor pattern without a camp station is left); `opts.notBefore`
// (spell -> skill) uses a recipe, to level or to make an intermediate, only from
// that skill on (Tailoring's Runecloth recipes wait for Artisan: Runecloth drops
// from humanoids of level 45-60, past where a tailor of 205 stands).

const { sourceOf } = require('./materials');

const CAPS = [75, 150, 225, 300];
const SWITCH_BASE = 500; // copper
const SWITCH_CRAFTS = 5;
// A recipe bought from a vendor is usually a trip out of town and often
// limited stock: it has to save more than this to beat a trainer recipe.
const VENDOR_TRIP = 3000; // copper
// A world-drop pattern bought at the Auction House: dearer and less certain.
const AUCTION_TRIP = 10000; // copper
const SIDES = ['Alliance', 'Horde'];
const STATIONS = new Set([undefined, 'Anvil', 'Forge', 'Cooking Fire']);
const GATHERED = new Set(['vendor', 'skinning', 'herb', 'mine', 'cloth', 'fishing', 'disenchant', 'crafted']);

function nextCap(s) {
	return CAPS.find((c) => c > s) || 300;
}

function chance(r, k) {
	if (!(r.grey > 0) || k >= r.grey) return 0;
	if (k < r.yellow) return 1;
	const span = r.grey - r.yellow;
	return span > 0 ? (r.grey - k) / span : 1;
}

// Expected crafts to go from skill s to t with recipe r.
function expectedCrafts(r, s, t) {
	let n = 0;
	for (let k = s; k < t; k++) {
		const p = chance(r, k);
		if (p <= 0) return Infinity;
		n += 1 / p;
	}
	return n / (r.skillUps || 1);
}

// A recipe item one copy of which is enough: limited-stock vendors count. A
// vendor with no faction in npcs.json is one of two kinds. A Classic NPC (one
// pfQuest knows) stands in a neutral town and serves both sides: Kania in
// Cenarion Hold, Qia in Everlook, the goblins of Booty Bay, Gadgetzan and
// Ratchet (older data builds said "AH" for them; the current ones carry no
// side). A Forever-new NPC with no side (Pexmit, "Someone's Minion", in Mount
// Hyjal) may not sell to anyone, so it counts for neither.
function bothSidesSell(m, npcs = {}) {
	const ok = (id) => {
		const n = npcs[id];
		return !n || n.faction != null || (n.source || []).includes('pfquest');
	};
	const has = (side) => [...((m && m.vendors && m.vendors[side]) || []), ...((m && m.limitedVendors && m.limitedVendors[side]) || [])].some(ok);
	return has('Alliance') && has('Horde');
}

// A recipe quest from quests.json: { id, title, items: [{ item, count }], skill, level, pre: [ids] },
// or null when the data lacks it.
function questOf(id, quests) {
	const q = quests[id];
	if (!q) return null;
	const items = (q.objectives || []).filter((o) => o.type === 'item' && o.id).map((o) => ({ item: o.id, count: o.count || 1 }));
	return { id: q.id, title: q.title, items, skill: q.skillLevel || 0, level: q.minLevel || 0, pre: q.preAny || q.pre || [] };
}

// `data` = { professions, npcs, objects, zones, quests }; `prof` = professions[id].
// `opts.questRecipes` (spell -> quest id): plans a quest hands over (Derotain Mudsipper's Imperial
// Plate plans for Thorium Bars). The data has no quest rewards, so the spec names them; the quest
// (quests.json) gives what it asks for, its skill and level, and the quest before it. Such a recipe
// is usable from the quest's skill, and learning it costs the items handed in plus a trip.
function planProfession(prof, data, { from = 1, to = 300, exclude = {}, noLevel = {}, questRecipes = {}, auction = {}, notBefore = {} } = {}) {
	const ctx = { professions: data.professions, npcs: data.npcs || {}, objects: data.objects || {}, zones: data.zones || {}, self: prof.id };
	const mats = prof.materials || {};
	const excluded = [];
	const usable = [];
	for (const r0 of prof.recipes) {
		let r = r0;
		const quest = questRecipes[r.spell] != null ? questOf(questRecipes[r.spell], data.quests || {}) : null;
		if (quest && r.source !== 'trainer' && r.source !== 'vendor') r = { ...r0, source: 'quest', quest };
		let why = exclude[r.spell] || null;
		if (why) {
			// left out by hand
		} else if (!(r.grey > 0)) why = 'gives no skill';
		else if (r.requires) why = 'needs a specialization';
		else if (r.races || r.classes) why = 'race or class only';
		else if (!STATIONS.has(r.focus)) why = `needs a ${r.focus}`;
		else if (/^Transmute/.test(r.name)) why = 'transmute (cooldown, Philosopher\'s Stone)';
		else if (r.reputation) why = 'recipe needs reputation';
		else if (r.source === 'vendor' && !bothSidesSell(mats[r.recipeItem], ctx.npcs)) why = 'recipe sold to one faction only';
		else if (auction[r.spell] && !(r.source === 'drop' && !(mats[r.recipeItem] || {}).bop)) why = 'pattern is not a world drop that can be traded';
		else if (r.source !== 'trainer' && r.source !== 'vendor' && r.source !== 'quest' && !auction[r.spell]) why = `recipe is a ${r.source}`;
		if (why) excluded.push({ spell: r.spell, why });
		else usable.push(r);
	}
	const bySpell = new Map(usable.map((r) => [r.spell, r]));
	const makers = new Map(); // item -> usable recipes of this profession that make it
	for (const r of usable) {
		if (!r.item) continue;
		if (!makers.has(r.item)) makers.set(r.item, []);
		makers.get(r.item).push(r);
	}

	// Unit cost of an item: get it, or craft it with this profession.
	const memo = new Map();
	function unit(item, depth = 0) {
		if (memo.has(item)) return memo.get(item);
		const src = {};
		let get = 0;
		for (const side of SIDES) {
			src[side] = sourceOf(item, mats[item], side, ctx);
			get = Math.max(get, src[side].cost);
		}
		let best = { cost: get, src, craft: null, req: 1 };
		// Something this profession makes is crafted when the other routes are a
		// mob drop or unknown (potions, oils, parts); a material that is bought,
		// gathered, skinned, fished or disenchanted is crafted only when cheaper
		// (Light Leather from scraps loses to skinning it).
		// A vendor good sold only far from the capitals (Wizzle Brassbolts' blasting powder) counts as
		// one the profession makes itself.
		const gathered = SIDES.some((side) => GATHERED.has(src[side].kind) && !src[side].remote);
		if (depth < 3) {
			memo.set(item, best); // cycle guard
			let craft = null;
			for (const r of makers.get(item) || []) {
				let c = 0;
				let req = Math.max(r.learnedAt, notBefore[r.spell] || 0);
				for (const g of r.reagents) {
					const u = unit(g.item, depth + 1);
					c += u.cost * g.count;
					req = Math.max(req, u.req);
				}
				c /= r.itemCount || 1;
				if (!Number.isFinite(c)) continue;
				if (!craft || c < craft.cost - 1e-9 || (Math.abs(c - craft.cost) < 1e-9 && r.spell < craft.craft.spell)) {
					craft = { cost: c, src, craft: r, req };
				}
			}
			if (craft && (!gathered || craft.cost < best.cost - 1e-9)) best = craft;
		}
		memo.set(item, best);
		return best;
	}

	// Intermediates crafted for one craft of `item` x `count`: spell -> { recipe, n }.
	function subCrafts(item, count, depth, acc) {
		const u = unit(item);
		if (!u.craft || depth >= 3) return acc;
		const n = count / (u.craft.itemCount || 1);
		const prev = acc.get(u.craft.spell);
		if (prev) prev.n += n;
		else acc.set(u.craft.spell, { recipe: u.craft, n });
		for (const g of u.craft.reagents) subCrafts(g.item, g.count * n, depth + 1, acc);
		return acc;
	}

	const info = new Map(); // spell -> { cost, req, learn, subs }
	for (const r of usable) {
		let cost = 0;
		let req = Math.max(r.learnedAt, auction[r.spell] || 0, notBefore[r.spell] || 0);
		const subs = new Map();
		for (const g of r.reagents) {
			const u = unit(g.item);
			cost += u.cost * g.count;
			req = Math.max(req, u.req);
			subCrafts(g.item, g.count, 0, subs);
		}
		for (const t of r.tools || []) {
			const u = unit(t);
			if (!Number.isFinite(u.cost)) cost = Infinity;
			req = Math.max(req, u.req);
		}
		let learn = auction[r.spell] ? AUCTION_TRIP : r.source === 'vendor' ? (r.cost || 0) + VENDOR_TRIP : r.cost || 0;
		if (r.source === 'quest') {
			// The quest's hand-in (20 Thorium Bars a plan) and the trip to its giver.
			learn = VENDOR_TRIP + r.quest.items.reduce((a, g) => a + unit(g.item).cost * g.count, 0);
			req = Math.max(req, r.quest.skill);
		}
		info.set(r.spell, { cost, req, learn, subs: [...subs.values()] });
	}

	// Expected points from one craft of `r` at skill k: its own chance plus its
	// intermediates' (crafted for it at about the same skill).
	const pointsAt = (r, k) => {
		const p = chance(r, k);
		if (p <= 0) return 0;
		let pts = p * (r.skillUps || 1);
		for (const s of info.get(r.spell).subs) pts += s.n * chance(s.recipe, k) * (s.recipe.skillUps || 1);
		return pts;
	};

	// Dynamic program over skill.
	const best = new Array(to + 1).fill(Infinity);
	const back = new Array(to + 1).fill(null);
	best[from] = 0;
	const order = usable.filter((r) => !noLevel[r.spell]).sort((a, b) => a.spell - b.spell);
	for (let s = from; s < to; s++) {
		if (!Number.isFinite(best[s])) continue;
		const cap = Math.min(nextCap(s), to);
		for (const r of order) {
			const inf = info.get(r.spell);
			if (!Number.isFinite(inf.cost) || inf.req > s || s >= r.grey) continue;
			const fixed = best[s] + SWITCH_BASE + SWITCH_CRAFTS * inf.cost + inf.learn;
			let crafts = 0;
			for (let t = s + 1; t <= cap; t++) {
				const p = pointsAt(r, t - 1);
				if (p <= 0) break;
				crafts += 1 / p;
				const total = fixed + crafts * inf.cost;
				if (total < best[t] - 1e-6) {
					best[t] = total;
					back[t] = { s, spell: r.spell, crafts };
				}
			}
		}
	}
	// Forever gates some last points behind crafting stations (Tailoring
	// 295-300: every recipe that still gives a point needs a Spinning Wheel, a
	// Loom or a Moonwell, or is learned from a drop, an item or a reputation
	// vendor): plan as far as the usable recipes go. `reach` < `to` says where
	// the plan stops.
	let reach = to;
	if (!Number.isFinite(best[to])) {
		reach = from;
		for (let s = from; s <= to; s++) if (Number.isFinite(best[s])) reach = s;
		if (reach === from) throw new Error(`${prof.name}: no recipe chain starts at ${from}`);
	}
	const segments = [];
	for (let t = reach; t > from; ) {
		const b = back[t];
		segments.unshift({ spell: b.spell, from: b.s, to: t, crafts: b.crafts });
		t = b.s;
	}
	// Expand each segment's shopping list: reagents, crafted intermediates, tools.
	// A tool this profession makes comes in the first segment that can learn it while it is still
	// orange (the Arclight Spanner at 50-75 gives its point there), else where it is first needed.
	const toolAt = new Map(); // segment index -> tools to make there
	const placed = new Set();
	segments.forEach((seg, i) => {
		for (const t of bySpell.get(seg.spell).tools || []) {
			if (placed.has(t)) continue;
			placed.add(t);
			const c = unit(t).craft;
			const at = c ? segments.findIndex((s, j) => j < i && s.from >= info.get(c.spell).req && s.from < c.yellow) : -1;
			const k = at >= 0 ? at : i;
			if (!toolAt.has(k)) toolAt.set(k, []);
			toolAt.get(k).push(t);
		}
	});
	// What a segment crafts to level (Thick Leather, Rugged Leather, a Bolt of
	// Runecloth) stays in the bags and counts against the later segments' needs.
	const toolsHave = new Set();
	const questsDone = new Set();
	const stock = new Map(); // item -> count crafted by earlier segments, not yet used
	segments.forEach((seg, i) => {
		const r = bySpell.get(seg.spell);
		seg.recipe = r;
		seg.count = Math.ceil(seg.crafts - 1e-9);
		seg.cost = info.get(r.spell).cost * seg.crafts;
		const need = new Map(); // item -> count to get
		const make = []; // { recipe, count } crafted intermediates, deepest first
		// item -> names of the recipes it goes into: the recipe, or for a tool's
		// materials the tool (a Runed Golden Rod's pearl, not the enchant).
		const uses = new Map();
		const add = (item, count, depth, user) => {
			const have = Math.min(stock.get(item) || 0, count);
			if (have) {
				stock.set(item, stock.get(item) - have);
				count -= have;
				seg.fromStock = seg.fromStock || [];
				seg.fromStock.push({ item, count: have });
			}
			if (!count) return;
			const u = unit(item);
			if (u.craft && depth < 3) {
				const n = Math.ceil(count / (u.craft.itemCount || 1));
				for (const g of u.craft.reagents) add(g.item, g.count * n, depth + 1, user || u.craft);
				const prev = make.find((m) => m.recipe.spell === u.craft.spell);
				if (prev) prev.count += n;
				else make.push({ recipe: u.craft, count: n, item, depth });
			} else {
				need.set(item, (need.get(item) || 0) + count);
				if (!uses.has(item)) uses.set(item, []);
				const name = (user || r).name;
				if (!uses.get(item).includes(name)) uses.get(item).push(name);
			}
		};
		seg.tools = [];
		for (const t of toolAt.get(i) || []) {
			if (toolsHave.has(t)) continue;
			toolsHave.add(t);
			const u = unit(t);
			seg.tools.push({ item: t, craft: u.craft || null });
			add(t, 1, 0, null);
		}
		for (const g of r.reagents) add(g.item, g.count * seg.count, 0, r);
		// A quest recipe's hand-in comes with the first segment that crafts it.
		if (r.source === 'quest' && !questsDone.has(r.quest.id)) {
			questsDone.add(r.quest.id);
			for (const g of r.quest.items) add(g.item, g.count, 0, r);
		}
		make.sort((a, b) => b.depth - a.depth || a.recipe.spell - b.recipe.spell);
		seg.make = make;
		seg.need = [...need.entries()].sort((a, b) => a[0] - b[0]).map(([item, count]) => ({ item, count, src: unit(item).src, uses: uses.get(item) }));
		if (r.item) stock.set(r.item, (stock.get(r.item) || 0) + seg.count * (r.itemCount || 1));
	});
	return { profession: prof, segments, total: best[reach], reach, excluded };
}

module.exports = { planProfession, expectedCrafts, chance, nextCap, CAPS, SWITCH_BASE, SWITCH_CRAFTS };
