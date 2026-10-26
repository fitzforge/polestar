'use strict';
// Service NPCs as world points (sim v2 §1, R18): class trainers, repair,
// food and drink, ammunition, innkeepers. Friendly NPCs only. Each entry is
// { pt, npc }: a site of the NPC (one entry per point). Flight masters come
// from the faction's flight nodes (world.js), not from here.

const FOOD = /innkeeper|food|drink|baker|butcher|general (goods|supplies)|bartender/i;
const AMMO = /bowyer|gunsmith|ammunition|arrows|bullets/i;

// -> { trainer: { CLASS: [{ pt, npc }] }, repair, food, ammo, inn: [{ pt, npc }] } sorted by pt.
function pickServices({ npcs, trainers, faction, sitesOf, friendly }) {
	const out = { trainer: {}, repair: [], food: [], ammo: [], inn: [] };
	const add = (list, id) => {
		const s = sitesOf('npc', id);
		if (s) for (const site of s.sites) if (!list.some((x) => x.pt === site.pt)) list.push({ pt: site.pt, npc: Number(id) });
	};
	for (const n of Object.values(npcs)) {
		if (!n || !friendly(n.faction, faction)) continue;
		const roles = n.roles || [];
		const sub = n.subName || '';
		if (roles.includes('repair')) add(out.repair, n.id);
		if (roles.includes('vendor') && FOOD.test(sub)) add(out.food, n.id);
		if (roles.includes('vendor') && AMMO.test(sub)) add(out.ammo, n.id);
		if (roles.includes('innkeeper')) add(out.inn, n.id);
	}
	for (const t of Object.values(trainers || {})) {
		const n = npcs[String(t.id)];
		if (!n || !friendly(n.faction, faction)) continue;
		for (const cls of t.classes || []) add((out.trainer[cls] = out.trainer[cls] || []), t.id);
	}
	const byPt = (a, b) => a.pt - b.pt;
	for (const k of ['repair', 'food', 'ammo', 'inn']) out[k].sort(byPt);
	for (const k of Object.keys(out.trainer)) out.trainer[k].sort(byPt);
	return out;
}

// { pt: [kind…] } over every service list; trainers count as `trainer:CLASS`.
function serviceSetOf(services) {
	const set = {};
	const mark = (kind, list) => {
		for (const s of list) {
			const k = (set[s.pt] = set[s.pt] || []);
			if (!k.includes(kind)) k.push(kind);
		}
	};
	for (const [cls, list] of Object.entries(services.trainer || {})) mark(`trainer:${cls}`, list);
	for (const [kind, list] of Object.entries(services)) if (kind !== 'trainer') mark(kind, list);
	return set;
}

module.exports = { pickServices, serviceSetOf, FOOD, AMMO };
