'use strict';
// Where a material comes from and what it is worth, for the profession
// planner. Costs are copper per unit, per faction:
//
//   vendor (unlimited stock on that side)  ItemSparse BuyPrice / VendorStackCount
//   anything else                          GATHER_FACTOR x the vendor sell price
//                                          (BuyPrice / 4 when it sells for 0),
//                                          x QUALITY_FACTOR for uncommon and better.
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
// Fish need a second profession and come one per cast from a few pools.
const FISHING_FACTOR = 3;

// Skinning products by name (the data has no skinning loot): leathers, hides,
// scales. Cured hides are tanned by Leatherworking and Enchanted Leather is
// made by Enchanting, not skinned.
const SKINNED = /^(?!Cured |Enchanted )(.*\s)?(Leather|Hide|Scale|Scales)$|Leather Scraps$/;
const DISENCHANTED = /^(Strange|Soul|Vision|Dream|Illusion) Dust$|^(Lesser|Greater) (Magic|Astral|Mystic|Nether|Eternal) Essence$|^(Small|Large) (Glimmering|Glowing|Radiant|Brilliant) Shard$/;
const CLOTH = /^(Linen|Wool|Silk|Mageweave|Runecloth|Felcloth|Mooncloth) Cloth$|^(Linen|Wool|Silk|Mageweave|Rune|Fel)cloth$/;

function gatherCost(m) {
	const base = m.sell > 0 ? m.sell : m.buy > 0 ? m.buy / 4 : MIN_GATHER_COST;
	return Math.max(MIN_GATHER_COST, base * GATHER_FACTOR * (QUALITY_FACTOR[m.quality] || 1));
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

// -> { kind, cost, note } for one faction. `ctx` = { professions, npcs, objects, zones, self }
// where `self` is the skill line being planned (its own recipes are handled by the planner).
function sourceOf(id, m, side, ctx) {
	if (!m) return { kind: 'unknown', cost: Infinity, note: 'no source in the reference data' };
	const vendors = (m.vendors && m.vendors[side]) || [];
	if (vendors.length && m.buy >= 0) {
		return { kind: 'vendor', cost: m.buy / (m.buyCount || 1), vendors, note: 'sold by trade supplies vendors' };
	}
	const cost = gatherCost(m);
	const other = (m.madeBy || []).filter((x) => x.skillLine !== ctx.self);
	const name = m.name || '';
	if (SKINNED.test(name)) return { kind: 'skinning', cost, note: 'Skinning (or the Auction House)' };
	if (m.gather && m.gather.herb) {
		const herbs = objectNames(m.gather.herb, ctx.objects);
		return { kind: 'herb', cost, note: `Herbalism${herbs.length ? `: ${herbs[0]}` : ''} (or the Auction House)` };
	}
	if (other.length) {
		const p = ctx.professions[other[0].skillLine];
		const r = p && (p.recipes || []).find((x) => x.spell === other[0].spell);
		const from = r && r.reagents && r.reagents[0] && p.materials && p.materials[r.reagents[0].item];
		const what = p && p.name === 'Mining' && from ? `smelt ${from.name}` : r ? r.name : 'craft it';
		// Transmutes have a cooldown, so their products (Arcanite Bar...) are scarce.
		const scarce = r && /^Transmute/.test(r.name) ? TRANSMUTE_FACTOR : 1;
		return { kind: 'crafted', cost: cost * scarce, note: `${p ? p.name : 'another profession'}: ${what} (or the Auction House)` };
	}
	if (m.gather && m.gather.mine) {
		const veins = objectNames(m.gather.mine, ctx.objects);
		return { kind: 'mine', cost, note: `Mining${veins.length ? `: ${veins[0]}` : ''} (or the Auction House)` };
	}
	if (DISENCHANTED.test(name)) return { kind: 'disenchant', cost, note: 'Enchanting: disenchant uncommon (green) gear (or the Auction House)' };
	if (m.gather && m.gather.fishing) return { kind: 'fishing', cost: cost * FISHING_FACTOR, note: 'Fishing (or the Auction House)' };
	if (CLOTH.test(name) && (m.dropCount || 0) >= 20) return { kind: 'cloth', cost, note: 'drops from humanoid mobs (or the Auction House)' };
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
