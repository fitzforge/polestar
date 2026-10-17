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
// Tools (Blacksmith Hammer, Runed Copper Rod...) are bought or crafted once.

const { sourceOf } = require('./materials');

const CAPS = [75, 150, 225, 300];
const SWITCH_BASE = 500; // copper
const SWITCH_CRAFTS = 5;
// A recipe bought from a vendor is usually a trip out of town and often
// limited stock: it has to save more than this to beat a trainer recipe.
const VENDOR_TRIP = 3000; // copper
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

// A recipe item one copy of which is enough: limited-stock vendors count.
function bothSidesSell(m) {
	const has = (side) => ((m && m.vendors && m.vendors[side]) || []).length + ((m && m.limitedVendors && m.limitedVendors[side]) || []).length > 0;
	return has('Alliance') && has('Horde');
}

// `data` = { professions, npcs, objects, zones }; `prof` = professions[id].
function planProfession(prof, data, { from = 1, to = 300 } = {}) {
	const ctx = { professions: data.professions, npcs: data.npcs || {}, objects: data.objects || {}, zones: data.zones || {}, self: prof.id };
	const mats = prof.materials || {};
	const excluded = [];
	const usable = [];
	for (const r of prof.recipes) {
		let why = null;
		if (!(r.grey > 0)) why = 'gives no skill';
		else if (r.requires) why = 'needs a specialization';
		else if (r.races || r.classes) why = 'race or class only';
		else if (!STATIONS.has(r.focus)) why = `needs a ${r.focus}`;
		else if (/^Transmute/.test(r.name)) why = 'transmute (cooldown, Philosopher\'s Stone)';
		else if (r.reputation) why = 'recipe needs reputation';
		else if (r.source === 'vendor' && !bothSidesSell(mats[r.recipeItem])) why = 'recipe sold to one faction only';
		else if (r.source !== 'trainer' && r.source !== 'vendor') why = `recipe is a ${r.source}`;
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
		const gathered = SIDES.some((side) => GATHERED.has(src[side].kind));
		if (depth < 3) {
			memo.set(item, best); // cycle guard
			let craft = null;
			for (const r of makers.get(item) || []) {
				let c = 0;
				let req = r.learnedAt;
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

	const info = new Map(); // spell -> { cost, req, tools }
	for (const r of usable) {
		let cost = 0;
		let req = r.learnedAt;
		for (const g of r.reagents) {
			const u = unit(g.item);
			cost += u.cost * g.count;
			req = Math.max(req, u.req);
		}
		for (const t of r.tools || []) {
			const u = unit(t);
			if (!Number.isFinite(u.cost)) cost = Infinity;
			req = Math.max(req, u.req);
		}
		const learn = r.source === 'vendor' ? (r.cost || 0) + VENDOR_TRIP : 0;
		info.set(r.spell, { cost, req, learn });
	}

	// Dynamic program over skill.
	const best = new Array(to + 1).fill(Infinity);
	const back = new Array(to + 1).fill(null);
	best[from] = 0;
	const order = usable.slice().sort((a, b) => a.spell - b.spell);
	for (let s = from; s < to; s++) {
		if (!Number.isFinite(best[s])) continue;
		const cap = Math.min(nextCap(s), to);
		for (const r of order) {
			const inf = info.get(r.spell);
			if (!Number.isFinite(inf.cost) || inf.req > s || s >= r.grey) continue;
			const fixed = best[s] + SWITCH_BASE + SWITCH_CRAFTS * inf.cost + inf.learn;
			let crafts = 0;
			for (let t = s + 1; t <= cap; t++) {
				const p = chance(r, t - 1);
				if (p <= 0) break;
				crafts += 1 / p / (r.skillUps || 1);
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
	const toolsHave = new Set();
	for (const seg of segments) {
		const r = bySpell.get(seg.spell);
		seg.recipe = r;
		seg.count = Math.ceil(seg.crafts - 1e-9);
		seg.cost = info.get(r.spell).cost * seg.crafts;
		const need = new Map(); // item -> count to get
		const make = []; // { recipe, count } crafted intermediates, deepest first
		const add = (item, count, depth) => {
			const u = unit(item);
			if (u.craft && depth < 3) {
				const n = Math.ceil(count / (u.craft.itemCount || 1));
				for (const g of u.craft.reagents) add(g.item, g.count * n, depth + 1);
				const prev = make.find((m) => m.recipe.spell === u.craft.spell);
				if (prev) prev.count += n;
				else make.push({ recipe: u.craft, count: n, item, depth });
			} else {
				need.set(item, (need.get(item) || 0) + count);
			}
		};
		seg.tools = [];
		for (const t of r.tools || []) {
			if (toolsHave.has(t)) continue;
			toolsHave.add(t);
			const u = unit(t);
			seg.tools.push({ item: t, craft: u.craft || null });
			add(t, 1, 0);
		}
		for (const g of r.reagents) add(g.item, g.count * seg.count, 0);
		make.sort((a, b) => b.depth - a.depth || a.recipe.spell - b.recipe.spell);
		seg.make = make;
		seg.need = [...need.entries()].sort((a, b) => a[0] - b[0]).map(([item, count]) => ({ item, count, src: unit(item).src }));
	}
	return { profession: prof, segments, total: best[reach], reach, excluded };
}

module.exports = { planProfession, expectedCrafts, chance, nextCap, CAPS, SWITCH_BASE, SWITCH_CRAFTS };
