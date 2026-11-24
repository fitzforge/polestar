'use strict';
// Where a material comes from and what it is worth, for the profession
// planner. Costs are copper per unit, per faction:
//
//   vendor (unlimited stock on that side)  ItemSparse BuyPrice / VendorStackCount
//   anything else                          GATHER_FACTOR x the vendor sell price
//                                          (BuyPrice / 4 when it sells for 0),
//                                          x QUALITY_FACTOR for uncommon and better;
//                                          cloth and leather use the square root of
//                                          the sell price (TIERED_BASE, below).
//
// Four times the sell price stands in for the Auction House price or the time
// it takes to farm the material; quality multiplies it because green and blue
// materials are scarce. It only has to rank recipes sensibly against each
// other, not predict prices. Materials with no known source cost Infinity, so
// the planner never picks a recipe that needs them.
//
// A material made by a recipe of the profession being planned is costed by
// the planner (it may be cheaper to craft it); see plan.js.

const GATHER_FACTOR = 4;
const QUALITY_FACTOR = { 0: 1, 1: 1, 2: 3, 3: 10, 4: 50, 5: 50 };
const MIN_GATHER_COST = 10;
const TRANSMUTE_FACTOR = 10;
// Fish need a second profession, come one per cast from a few schools, and
// sell for next to nothing: their sell price undervalues the time they take.
const FISHING_FACTOR = 6;
// ...and a cast takes about as long as picking a herb a level band higher.
const MIN_FISH_COST = 400;
// Made by another profession: a friend's craft or the Auction House, a dozen
// at a time at best.
const CROSS_FACTOR = 6;
// Cloth comes one piece per few humanoid kills, never from a node: a stack of
// it takes far longer than its sell price says.
const CLOTH_FACTOR = 3;
// A hide comes off about one beast in twenty, a leather off every other one
// (the world DB's skinning loot: Light/Medium/Heavy/Thick/Rugged Hide 4-5%
// per skin against 37-49% for the leather), yet it sells for only 1.3-2.5x
// the leather: its sell price says far too little about the skinning it takes.
const HIDE_FACTOR = 4;
// Cloth and leather drop at much the same rate from Linen to Runecloth and
// from Light to Rugged Leather (the world DB: median 10-25% a kill for cloth,
// 37-49% a skin for leather), and a kill at your own level takes about as
// long at 20 as at 55, so a piece costs much the same effort whatever its
// tier, while the sell price climbs 30-fold from Linen to Runecloth. Priced by
// the sell price, the planner sent tailors through 915 Wool Cloth to dodge
// Silk; the square root keeps the order (better cloth is worth more and comes
// later) without letting it decide: copper = 100 x sqrt(sell / 100).
const TIERED_BASE = 100;
// Disenchanted materials sell to vendors for next to nothing, so their sell
// price says nothing about what they take: copper per unit by tier (relative
// Auction House worth in Classic; dusts cheapest, then essences, then shards).
// Only their ranking against each other and against gathered materials matters.
// That is their worth to an enchanter, who breaks greens for them; any other
// profession gets them from an enchanter or the Auction House, like another
// profession's goods (CROSS_FACTOR): a leatherworker's Mystic Heavy Armor Kit
// at 2 Soul Dust a craft loses to plain leather.
const DISENCHANT_VALUE = {
	'Strange Dust': 500,
	'Lesser Magic Essence': 800,
	'Greater Magic Essence': 2400,
	'Small Glimmering Shard': 3000,
	'Soul Dust': 1000,
	'Lesser Astral Essence': 1500,
	'Greater Astral Essence': 4500,
	'Large Glimmering Shard': 6000,
	'Small Glowing Shard': 5000,
	'Vision Dust': 2000,
	'Lesser Mystic Essence': 3000,
	'Greater Mystic Essence': 9000,
	'Large Glowing Shard': 10000,
	'Small Radiant Shard': 10000,
	'Dream Dust': 3000,
	'Lesser Nether Essence': 4000,
	'Greater Nether Essence': 12000,
	'Large Radiant Shard': 25000,
	'Small Brilliant Shard': 30000,
	'Illusion Dust': 5000,
	'Lesser Eternal Essence': 15000,
	'Greater Eternal Essence': 45000,
	'Large Brilliant Shard': 150000,
};

const ENCHANTING = 333;

// A disenchanted material's worth to the profession being planned (`ctx.self`).
function disenchantValue(name, ctx) {
	const v = DISENCHANT_VALUE[name];
	return v && ctx.self !== ENCHANTING ? v * CROSS_FACTOR : v;
}

// Skinning products by name (the data has no skinning loot): leathers, hides,
// scales. Cured hides are tanned by Leatherworking and Enchanted Leather is
// made by Enchanting, not skinned.
const SKINNED = /^(?!Cured |Enchanted )(.*\s)?(Leather|Hide|Scale|Scales)$|Leather Scraps$/;
const DISENCHANTED = /^(Strange|Soul|Vision|Dream|Illusion) Dust$|^(Lesser|Greater) (Magic|Astral|Mystic|Nether|Eternal) Essence$|^(Small|Large) (Glimmering|Glowing|Radiant|Brilliant) Shard$/;
const CLOTH = /^(Linen|Wool|Silk|Mageweave|Runecloth|Felcloth|Mooncloth) Cloth$|^(Linen|Wool|Silk|Mageweave|Rune|Fel)cloth$/;

function gatherCost(m) {
	let base = m.sell > 0 ? m.sell : m.buy > 0 ? m.buy / 4 : MIN_GATHER_COST;
	if (tiered(m.name || '')) base = TIERED_BASE * Math.sqrt(base / TIERED_BASE);
	return Math.max(MIN_GATHER_COST, base * GATHER_FACTOR * (QUALITY_FACTOR[m.quality] || 1));
}

function tiered(name) {
	return CLOTH.test(name) || SKINNED.test(name);
}

// The map an npc really stands on. An NPC near a zone border is listed on
// both maps (Drakk Stonehand: Aerie Peak in The Hinterlands, and the edge of
// Hillsbrad Foothills); its point farthest from the map edges is the real one,
// and a capital city beats the zone around it (the gathering/common.js
// npcSpawn rule). Ties: the lowest map id.
const CITY_MAPS = new Set([1453, 1454, 1455, 1456, 1457, 1458]);
function homeMap(npc) {
	let best = null;
	for (const [map, s] of Object.entries((npc && npc.spawns) || {})) {
		for (const p of (s && s.pts) || []) {
			const score = (CITY_MAPS.has(Number(map)) ? 1000 : 0) + Math.min(p[0], 100 - p[0], p[1], 100 - p[1]);
			if (!best || score > best.score || (score === best.score && Number(map) < best.map)) best = { map: Number(map), score };
		}
	}
	return best ? best.map : null;
}

function zoneOf(npc, zones) {
	const map = homeMap(npc);
	return map != null && zones[map] && zones[map].name ? zones[map].name : null;
}

function objectNames(ids, objects) {
	const names = [];
	for (const id of ids || []) {
		const o = objects[id];
		if (o && o.name && !names.includes(o.name)) names.push(o.name);
	}
	return names;
}

// What a miner pays to smelt `item` (copper per bar): the ore at its gathered worth, vendor Coal at
// its price, a bar made from bars (Steel from Iron, Bronze from Copper and Tin) at those bars' worth.
// Null when Mining smelts no such bar. Steel Bar sells for 60c, a fifth of the Iron Bar and Coal it
// is made of: a bar is worth at least what goes into it.
function smeltCost(item, side, ctx, depth = 0) {
	const mining = Object.values(ctx.professions || {}).find((p) => p && p.name === 'Mining');
	const r = mining && (mining.recipes || []).find((x) => x.item === item && (x.reagents || []).length);
	if (!r || depth > 3) return null;
	let c = 0;
	for (const g of r.reagents) {
		const mm = (mining.materials || {})[g.item];
		if (!mm) return null;
		const vendors = (mm.vendors && mm.vendors[side]) || [];
		c += g.count * (vendors.length && mm.buy >= 0 ? mm.buy / (mm.buyCount || 1) : barCost(g.item, mm, side, ctx, depth + 1));
	}
	return c / (r.itemCount || 1);
}

// A smelted bar's worth: its gathered worth, or what smelting it takes when that is more.
function barCost(item, m, side, ctx, depth = 0) {
	const smelt = smeltCost(item, side, ctx, depth);
	return Math.max(gatherCost(m), smelt != null ? smelt : 0);
}

// -> { kind, cost, note } for one faction. `ctx` = { professions, npcs, objects, zones, self }
// where `self` is the skill line being planned (its own recipes are handled by the planner).
// A vendor good no seller of the side offers in a capital is `remote` (Coarse Blasting Powder and
// Silver Contacts only at Wizzle Brassbolts on the Mirage Raceway): the planner crafts it when the
// profession can.
function sourceOf(id, m, side, ctx) {
	if (!m) return { kind: 'unknown', cost: Infinity, note: 'no source in the reference data' };
	const vendors = (m.vendors && m.vendors[side]) || [];
	// A dust or essence that a vendor sells for more than it is worth to the
	// profession (Strange Dust at 8s to an enchanter; most of its sellers keep
	// one to four) stays a disenchanting material: an enchanter breaks greens for it.
	const deValue = DISENCHANTED.test(m.name || '') ? disenchantValue(m.name, ctx) : null;
	if (vendors.length && m.buy >= 0 && !(deValue && deValue < m.buy / (m.buyCount || 1))) {
		const remote = !vendors.some((v) => CITY_MAPS.has(homeMap((ctx.npcs || {})[v])));
		return { kind: 'vendor', cost: m.buy / (m.buyCount || 1), vendors, remote, note: 'sold by trade supplies vendors' };
	}
	const cost = gatherCost(m);
	const other = (m.madeBy || []).filter((x) => x.skillLine !== ctx.self);
	const name = m.name || '';
	if (SKINNED.test(name)) return { kind: 'skinning', cost: / Hide$/.test(name) ? cost * HIDE_FACTOR : cost, note: 'Skinning (or the Auction House)' };
	if (m.gather && m.gather.herb) {
		const herbs = objectNames(m.gather.herb, ctx.objects);
		return { kind: 'herb', cost, note: `Herbalism${herbs.length ? `: ${herbs[0]}` : ''} (or the Auction House)` };
	}
	if (other.length) {
		const p = ctx.professions[other[0].skillLine];
		const r = p && (p.recipes || []).find((x) => x.spell === other[0].spell);
		const from = r && p.materials ? (r.reagents || []).map((g) => (p.materials[g.item] || {}).name).filter(Boolean) : [];
		const what = p && p.name === 'Mining' && from.length ? `smelt ${from.join(' and ')}` : r ? r.name : 'craft it';
		// Transmutes have a cooldown, so their products (Arcanite Bar...) are scarce;
		// another crafter's goods (an alchemist's elixir for a tailor) need a friend
		// or the Auction House. Bars are smelted by the miner a smith or engineer
		// usually is.
		const scarce = r && /^Transmute/.test(r.name) ? TRANSMUTE_FACTOR : p && p.name === 'Mining' ? 1 : CROSS_FACTOR;
		const worth = p && p.name === 'Mining' ? barCost(id, m, side, ctx) : cost;
		return { kind: 'crafted', cost: worth * scarce, note: `${p ? p.name : 'another profession'}: ${what} (or the Auction House)` };
	}
	if (m.gather && m.gather.mine) {
		const veins = objectNames(m.gather.mine, ctx.objects);
		return { kind: 'mine', cost, note: `Mining${veins.length ? `: ${veins[0]}` : ''} (or the Auction House)` };
	}
	if (DISENCHANTED.test(name)) return { kind: 'disenchant', cost: disenchantValue(name, ctx) || cost, note: 'Enchanting: disenchant uncommon (green) gear (or the Auction House)' };
	if (m.gather && m.gather.fishing) return { kind: 'fishing', cost: Math.max(cost * FISHING_FACTOR, MIN_FISH_COST), note: 'Fishing (or the Auction House)' };
	if (CLOTH.test(name) && (m.dropCount || 0) >= 20) return { kind: 'cloth', cost: cost * CLOTH_FACTOR, note: 'drops from humanoid mobs (or the Auction House)' };
	if (m.drops && m.drops.length) {
		const d = m.drops[0];
		const npc = ctx.npcs[d.npc];
		const where = npc ? zoneOf(npc, ctx.zones) : null;
		const label = npc ? `${npc.name}${where ? ` (${where})` : ''}` : `npc ${d.npc}`;
		return { kind: 'drop', cost, note: `drops from ${label}${m.dropCount > 1 ? ' and other mobs' : ''} (or the Auction House)` };
	}
	const limited = (m.limitedVendors && m.limitedVendors[side]) || [];
	if (limited.length) {
		const npc = ctx.npcs[limited[0]];
		return { kind: 'limited', cost: Math.max(cost, m.buy || 0), vendors: limited, note: `limited stock at ${npc ? npc.name : 'a vendor'}${m.bop ? '' : ' (or the Auction House)'}` };
	}
	return { kind: 'unknown', cost: Infinity, note: 'no source in the reference data' };
}

module.exports = { sourceOf, gatherCost, zoneOf, homeMap, GATHER_FACTOR, QUALITY_FACTOR };
