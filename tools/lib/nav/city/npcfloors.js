'use strict';
// `nav city npc-floors`: the floor players stand on at an NPC whose spawn data gives no height there (a Forever NPC
// the spawn sources lack, one Forever moved: the Great Cat Spirit talks 90 yd from his classic-db spawn, Norric
// Lochthane deep in the Silver Stream Mine has none). Without it a guide goal at the NPC, the planner's measure and
// the arrow's walk are searched without a height and end on whichever surface is cheapest at the spot (the den's floor
// 12 yd under the spirit's, the mine's upper gallery). The recordings carry no height, so each player's last steps
// before the NPC's window are map-matched on the walking grid (match.js's matcher) and the window's floor read off:
//   anchors   NPC windows (match.js ANCHOR_KINDS) with no spawn of that NPC within HEIGHT_YARDS on the continent
//   places    an NPC's anchors grouped within PLACE yd (an NPC standing in two camps has two places)
//   windows   the breadcrumbs before each anchor, up to BACK_YD of walk and BACK_N samples, on one graph per place
//   floor     per person their most matched floor; the level (people within LEVEL yd) most people stood on, kept
//             when MIN_PEOPLE or more people and AGREE of them stood on it
// people: 'train' (the gate's training people only: a held-out walk never judges a height its own walker gave) or
// 'all' (what ships: data/npc-floors.json). Run over the world's zones (`nav city npc-floors` without --maps): the
// capitals' streets float over the ground they were built on, which these short windows can't tell apart (the city
// match's anchors and priors do); there the trail layer and the Codex's spawns give the floors.
//
//   npcFloors({ priv, grid, frames, spawnz, maps, people, log }) -> { about, npcs: [{ npc, c, wx, wy, z, people, of }] }
//   withFloors(spawnz, doc) -> spawnz with each record a spawn row [c, wx, wy, z, 0] of its NPC where it has none on
//     its continent within HEIGHT_YARDS (forge-data's add_recorded_heights does the same at the data build)

const fs = require('node:fs');
const path = require('node:path');
const { AreaGraph } = require('./graph');
const { segmentsOf, makeMatcher, isTest, blankCut, ANCHOR_KINDS } = require('./match');

const HEIGHT_YARDS = 15; // a goal's height comes from a spawn this close (forge-guide heights, Lookup.SpawnZ)
const PLACE = 25;
const BACK_YD = 120;
const BACK_N = 40;
const PAD = 30;
const LEVEL = 5; // (the Great Cat Spirit's floor reads 487.5 or 492: two surfaces 4 yd apart in one column)
const MIN_PEOPLE = 3;
const AGREE = 0.7;

// The NPC's spawn within HEIGHT_YARDS of (wx, wy) on continent c has a height.
function hasHeight(spawnz, npc, c, wx, wy) {
	for (const r of spawnz[String(npc)] || []) {
		if (r[0] === c && typeof r[3] === 'number' && Math.hypot(r[1] - wx, r[2] - wy) <= HEIGHT_YARDS) return true;
	}
	return false;
}

function readSessions(file) {
	if (!fs.existsSync(file)) return [];
	return fs.readFileSync(file, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
}

const median = (xs) => {
	const s = xs.slice().sort((a, b) => a - b);
	return s[Math.floor((s.length - 1) / 2)];
};

// Levels among values (people's floors): runs whose neighbours lie within LEVEL yd (a ramp or a few steps up to the
// NPC is one level: the Great Cat Spirit's 487.5-492), the most values first.
function levels(values) {
	const out = [];
	for (const z of values.slice().sort((a, b) => a - b)) {
		const last = out[out.length - 1];
		if (last && z - last[last.length - 1] <= LEVEL) last.push(z);
		else out.push([z]);
	}
	return out.sort((a, b) => b.length - a.length);
}

// One place's floor from each person's matched floors (byWho: [[z, ...] per person]): each person once, their most
// matched level's median; the level most people stood on, when MIN_PEOPLE or more and AGREE of them did.
// -> { z, people, of } | null
function floorOf(byWho) {
	const per = byWho.map((zs) => median(levels(zs)[0]));
	if (per.length < MIN_PEOPLE) return null;
	const best = levels(per)[0];
	if (best.length < MIN_PEOPLE || best.length < AGREE * per.length) return null;
	return { z: +median(best).toFixed(1), people: best.length, of: per.length };
}

// The breadcrumbs before seg[i] (the anchor) and the anchor itself.
function windowOf(seg, i) {
	let k = i;
	let yd = 0;
	while (k > 0 && i - k < BACK_N) {
		const d = Math.hypot(seg[k].wx - seg[k - 1].wx, seg[k].wy - seg[k - 1].wy);
		if (yd + d > BACK_YD) break;
		yd += d;
		k--;
	}
	return seg.slice(k, i + 1);
}

function npcFloors({ priv, grid, frames, spawnz, maps, people = 'all', log = () => {} }) {
	// npc -> [{ c, wx, wy, who, win }]
	const anchors = new Map();
	for (const map of maps) {
		const fr = frames[String(map)];
		if (!fr) continue;
		const c = fr.c;
		const npcZ = () => null; // (no anchor pins its own floor: the floor is what the walk to it says)
		let n = 0;
		for (const s of readSessions(path.join(priv, `${map}.jsonl`))) {
			if (people === 'train' && isTest(s.who)) continue;
			for (const seg of segmentsOf(s, map, frames, npcZ, blankCut())) {
				seg.forEach((x, i) => {
					if (!ANCHOR_KINDS.has(x.kind) || !x.npc || hasHeight(spawnz, x.npc, c, x.wx, x.wy)) return;
					const win = windowOf(seg, i);
					if (win.filter((w) => w.kind === 'pos').length < 2) return;
					if (!anchors.has(x.npc)) anchors.set(x.npc, []);
					anchors.get(x.npc).push({ c, wx: x.wx, wy: x.wy, who: s.who, win });
					n++;
				});
			}
		}
		if (n) log(`npc-floors ${map}: ${n} windows at NPCs without a height`);
	}
	const out = [];
	let places = 0;
	for (const [npc, list] of anchors) {
		// places: anchors within PLACE yd of a place's first
		const groups = [];
		for (const a of list) {
			const g = groups.find((p) => p.c === a.c && Math.hypot(p.wx - a.wx, p.wy - a.wy) <= PLACE);
			if (g) g.list.push(a);
			else groups.push({ c: a.c, wx: a.wx, wy: a.wy, list: [a] });
		}
		for (const place of groups) {
			if (new Set(place.list.map((a) => a.who)).size < MIN_PEOPLE) continue;
			places++;
			const pts = place.list.flatMap((a) => a.win);
			const box = {
				c: place.c,
				wxMin: Math.min(...pts.map((p) => p.wx)) - PAD, wxMax: Math.max(...pts.map((p) => p.wx)) + PAD,
				wyMin: Math.min(...pts.map((p) => p.wy)) - PAD, wyMax: Math.max(...pts.map((p) => p.wy)) + PAD,
			};
			const g = new AreaGraph(box, { grid });
			const m = makeMatcher(g);
			const st = blankCut();
			st.jumps = 0;
			const byWho = new Map();
			for (const a of place.list) {
				const pcs = m.viterbi(a.win, st);
				const last = a.win.length - 1;
				const pc = pcs.find((p) => p.from <= last && p.to >= last);
				if (!pc || pc.to === pc.from) continue; // a floor the walk to it doesn't reach says nothing
				const z = g.nz[pc.nodes[last - pc.from]];
				if (!byWho.has(a.who)) byWho.set(a.who, []);
				byWho.get(a.who).push(z);
			}
			const f = floorOf([...byWho.values()]);
			if (!f) continue;
			const ax = median(place.list.map((a) => a.wx));
			const ay = median(place.list.map((a) => a.wy));
			out.push({ npc: Number(npc), c: place.c, wx: +ax.toFixed(1), wy: +ay.toFixed(1), ...f });
		}
	}
	out.sort((a, b) => a.npc - b.npc || a.c - b.c || a.wx - b.wx);
	log(`npc-floors: ${anchors.size} NPCs without a height, ${places} places with ${MIN_PEOPLE}+ people, ${out.length} floors kept`);
	return {
		about: `The floor players stand on at NPCs whose spawn data gives no height there (\`nav city npc-floors\`, tools/lib/nav/city/npcfloors.js): their last steps before the NPC's window map-matched on the walking grid, kept where ${MIN_PEOPLE}+ people and ${Math.round(AGREE * 100)}% of those matched stood on one level (within ${LEVEL} yd). The data build adds each as a spawn height of its NPC (spawnz.json) where the NPC has none within ${HEIGHT_YARDS} yd. npc; c: continent; wx, wy: world yards (the windows' median); z: height; people: the people on that floor, of: all matched.`,
		npcs: out,
	};
}

function withFloors(spawnz, doc) {
	const out = { ...spawnz };
	for (const r of (doc && doc.npcs) || []) {
		if (hasHeight(out, r.npc, r.c, r.wx, r.wy)) continue;
		out[String(r.npc)] = [...(out[String(r.npc)] || []), [r.c, r.wx, r.wy, r.z, 0]];
	}
	return out;
}

module.exports = { npcFloors, floorOf, withFloors, HEIGHT_YARDS };
