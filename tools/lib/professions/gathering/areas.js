'use strict';
// Gathering areas for the Herbalism, Mining and Skinning bands: the places a character roams for a band's
// nodes (or beasts), each a subzone or a stretch of open ground of one zone, with how many nodes it keeps up,
// the least character level safe in it, its shape and its node spots. A guide writes one as an `area` line
// (docs/GUIDE_FORMAT.md, "Gathering areas"); the arrow leads to the area and rests inside it.
//
// areasIn(ctx, prof, map, points, { faction, respawn, level, maxLevel }) -> [area], best first (rankScore):
//   points: the band part's node or beast points (route points with `w`, `up`, `name`, `req`, `level`).
//   1. Each point asks a character level (loop.js pointLevels: no hostile creature that can reach it more
//      than a level above you, none of them an elite; never by the other faction's towns). Points by an elite
//      or a town are left out, and so are those above `maxLevel`.
//   2. The rest are grouped into patches of PATCH_YARDS round the heaviest ground (weighted, greedy).
//   3. Each patch is named after the subzone that holds most of its nodes (the client's map overlays:
//      WorldMapOverlay hit rects and AreaTable names), else after the subzone nearest it (`near`: "Durotar: near
//      Razor Hill"); patches of one name within MERGE_YARDS are one area.
//   4. An area asks the level that LEVEL_SHARE of its nodes (by how often each is up) ask, and of the ground
//      inside it (a SAMPLE_YARDS grid): its nodes above that are left out, so one camp of higher creatures does
//      not lift the whole area. Never below the zone's own level (tables.js ZONES min). An elite or a town of the
//      other faction anywhere inside rules the area out.
//   5. Its shape: the convex hull of its nodes, PAD_YARDS out, at most MAX_CORNERS corners; its spots: up to
//      MAX_DOTS nodes, the most often up first.
//   6. Its worth (rankScore): skill-ups (or nodes) up at once per yard of a sweep through its nodes, where a
//      sweep costs its walk (never under the walk of the nodes' respawn) plus `prof.stopYards` per node.
// skillLevel(skill): the character level a band is planned for, a fifth of the skill and at least 5
// (ASSUMED: a character levelling with the profession; any starting area's creatures are level 5 or below).

const fs = require('node:fs');
const path = require('node:path');
const { dist } = require('../../route/geo');
const { planTour, pathLength } = require('../../route/tour');
const { pointLevels } = require('./loop');
const { ZONES } = require('./tables');
const { SOURCES } = require('../../paths');

// The knobs a profession may set in its spec (`areaTuning`: { patchYards, … }, specs.js); areasIn reads them into T
// for the call. patchYards: a patch's reach round its seed; mergeYards: how far apart patches of one name (or a
// sparse one and its neighbour) still join; levelShare: the share of an area's nodes its level covers; minNodes,
// minUp: the least an area holds (points, nodes up at once); tierGrowth, groundShare: below; goodUp: a patch with
// fewer nodes up joins its neighbour (growSmall); maxSpan: the widest two joined patches may be.
const DEFAULTS = { patchYards: 400, mergeYards: 900, levelShare: 0.8, minNodes: 3, minUp: 1.5, tierGrowth: 0.25, groundShare: 0.5, goodUp: 6, maxSpan: 1500 };
let T = DEFAULTS;
const SAMPLE_YARDS = 30;
const MAX_SAMPLES = 600;
const PAD_YARDS = 30;
const MAX_CORNERS = 10;
const MAX_DOTS = 40;
// A sweep through more nodes than this follows the heaviest ones (the rest lie on its way).
const MAX_TOUR = 60;
// tierGrowth: a level cuts its own areas when this much more of the nodes (by how often each is up) open there than
// at the level before; an area cut again at a higher level must hold this much more. groundShare: the ground
// between the nodes counts at its median, the half of it a character roams most (the camps at its edges are what
// the nodes' own level already keeps them from).
// Nodes this near an elite or a town inside an area leave it (and its outline with them), at most this many times.
const CLEAR_YARDS = 90;
const CLEAR_TRIES = 3;
// Running speed, yards per second.
const RUN = 7;
// Worth kept per level an area asks above the band's planned character level: an area two levels above must
// be nearly twice as good to win, four levels above three times.
const LEVEL_DECAY = 0.75;

function skillLevel(skill) {
	return Math.max(5, Math.round(skill / 5));
}

// An area's worth for ranking in a band planned for character level `level`.
function rankScore(a, level) {
	return a ? a.score * LEVEL_DECAY ** Math.max(0, a.level - level) : 0;
}

function up(p) {
	return p.up === undefined ? 1 : p.up;
}

// A zone's own level (tables.js ZONES min) is the least an area there asks: its creatures stand on the way in.
function floorOf(map) {
	return (ZONES[map] && ZONES[map].min) || 1;
}

// ------------------------------------------------------------------ subzones

// The client's map overlays (exploration/areas.js reads the same tables): per zone map, its subzones as world
// boxes from their hit rects (the texture's rect when the hit rect is empty), live frame. Read once.
const OVERLAY_BUILD = '1.60.1.70338';
const CANVAS_W = 1002;
const CANVAS_H = 668;
let overlayRows = null;
function overlays(sourcesDir = SOURCES) {
	if (overlayRows) return overlayRows;
	const dir = path.join(sourcesDir, 'wago', OVERLAY_BUILD);
	const read = (t) => {
		const f = path.join(dir, `${t}.csv`);
		return fs.existsSync(f) ? require('../../data/csv').parseCsv(fs.readFileSync(f, 'utf8')) : null;
	};
	const ov = read('WorldMapOverlay');
	const xart = read('UiMapXMapArt');
	const areas = read('AreaTable');
	overlayRows = { byMap: new Map(), names: new Map() };
	if (!(ov && xart && areas)) return overlayRows;
	for (const a of areas) overlayRows.names.set(Number(a.ID), String(a.AreaName_lang).trim());
	const art = new Map();
	for (const r of xart) {
		if (Number(r.PhaseID) !== 0) continue;
		const k = Number(r.UiMapArtID);
		if (!art.has(k)) art.set(k, []);
		art.get(k).push(Number(r.UiMapID));
	}
	for (const o of ov) {
		const ids = [0, 1, 2, 3].map((i) => Number(o[`AreaID_${i}`])).filter((id) => id && overlayRows.names.has(id));
		if (!ids.length) continue;
		let x0 = Number(o.HitRectLeft);
		let x1 = Number(o.HitRectRight);
		let y0 = Number(o.HitRectTop);
		let y1 = Number(o.HitRectBottom);
		if (!(x1 > x0 && y1 > y0)) {
			x0 = Number(o.OffsetX);
			x1 = x0 + Number(o.TextureWidth);
			y0 = Number(o.OffsetY);
			y1 = y0 + Number(o.TextureHeight);
		}
		if (!(x1 > x0 && y1 > y0)) continue;
		const rect = { id: ids[0], x0: (x0 / CANVAS_W) * 100, x1: (x1 / CANVAS_W) * 100, y0: (y0 / CANVAS_H) * 100, y1: (y1 / CANVAS_H) * 100 };
		for (const map of art.get(Number(o.UiMapArtID)) || []) {
			if (!overlayRows.byMap.has(map)) overlayRows.byMap.set(map, []);
			overlayRows.byMap.get(map).push(rect);
		}
	}
	return overlayRows;
}

// The subzones of `map` in world yards: [{ id, name, c, ax, ay, bx, by, cx, cy, size }] (a box from corner a to b).
const subCache = new WeakMap();
function subzonesOf(ctx, map) {
	let byMap = subCache.get(ctx.data);
	if (!byMap) subCache.set(ctx.data, (byMap = new Map()));
	if (byMap.has(map)) return byMap.get(map);
	const O = overlays(ctx.sourcesDir);
	const zoneArea = (ctx.data.zones && ctx.data.zones[String(map)] && ctx.data.zones[String(map)].areaId) || null;
	const out = [];
	for (const r of O.byMap.get(Number(map)) || []) {
		if (r.id === zoneArea) continue;
		const a = ctx.project.point(map, r.x0, r.y0, 'l');
		const b = ctx.project.point(map, r.x1, r.y1, 'l');
		const ax = Math.min(a.wx, b.wx);
		const bx = Math.max(a.wx, b.wx);
		const ay = Math.min(a.wy, b.wy);
		const by = Math.max(a.wy, b.wy);
		out.push({ id: r.id, name: O.names.get(r.id), c: a.c, ax, ay, bx, by, cx: (ax + bx) / 2, cy: (ay + by) / 2, size: (bx - ax) * (by - ay) });
	}
	byMap.set(map, out);
	return out;
}

// The subzone a world point lies in (the smallest box holding it), or null.
function subzoneAt(subs, pt) {
	let best = null;
	for (const s of subs) if (s.c === pt.c && pt.wx >= s.ax && pt.wx <= s.bx && pt.wy >= s.ay && pt.wy <= s.by && (!best || s.size < best.size)) best = s;
	return best;
}

// ------------------------------------------------------------------ shapes

// Greedy weighted patches: the seed is the point with the heaviest ground within `radius`, the patch that
// ground; the next seed is found over what is left. -> [[point]] heaviest first.
function patches(points, radius) {
	const pts = points.slice().sort((a, b) => a.pt.wx - b.pt.wx || a.pt.wy - b.pt.wy || String(a.name).localeCompare(String(b.name)));
	const cell = (p, dx = 0, dy = 0) => `${p.pt.c}|${Math.floor(p.pt.wx / radius) + dx}|${Math.floor(p.pt.wy / radius) + dy}`;
	const grid = new Map();
	pts.forEach((p, i) => {
		const k = cell(p);
		if (!grid.has(k)) grid.set(k, []);
		grid.get(k).push(i);
	});
	const near = pts.map((p) => {
		const list = [];
		for (let dx = -1; dx <= 1; dx++) for (let dy = -1; dy <= 1; dy++) for (const j of grid.get(cell(p, dx, dy)) || []) if (dist(p.pt, pts[j].pt) <= radius) list.push(j);
		return list.sort((a, b) => a - b);
	});
	const taken = new Uint8Array(pts.length);
	const weight = (i) => near[i].reduce((s, j) => s + (taken[j] ? 0 : pts[j].w), 0);
	const out = [];
	let left = pts.length;
	while (left) {
		let best = -1;
		let bestW = -1;
		for (let i = 0; i < pts.length; i++) {
			if (taken[i]) continue;
			const w = weight(i);
			if (w > bestW + 1e-9) {
				bestW = w;
				best = i;
			}
		}
		const members = near[best].filter((j) => !taken[j]);
		for (const j of members) taken[j] = 1;
		left -= members.length;
		out.push(members.map((j) => pts[j]));
	}
	return out;
}

function centroid(list) {
	let wx = 0;
	let wy = 0;
	let w = 0;
	for (const p of list) {
		const k = up(p) || 1e-3;
		wx += p.pt.wx * k;
		wy += p.pt.wy * k;
		w += k;
	}
	return { c: list[0].pt.c, wx: wx / w, wy: wy / w };
}

// Convex hull of world points (Andrew's monotone chain), counter-clockwise.
function hull(pts) {
	const p = [...new Map(pts.map((q) => [`${q.wx.toFixed(1)},${q.wy.toFixed(1)}`, q])).values()].sort((a, b) => a.wx - b.wx || a.wy - b.wy);
	if (p.length < 3) return p;
	const cross = (o, a, b) => (a.wx - o.wx) * (b.wy - o.wy) - (a.wy - o.wy) * (b.wx - o.wx);
	const lower = [];
	for (const q of p) {
		while (lower.length >= 2 && cross(lower[lower.length - 2], lower[lower.length - 1], q) <= 0) lower.pop();
		lower.push(q);
	}
	const upper = [];
	for (let i = p.length - 1; i >= 0; i--) {
		const q = p[i];
		while (upper.length >= 2 && cross(upper[upper.length - 2], upper[upper.length - 1], q) <= 0) upper.pop();
		upper.push(q);
	}
	return [...lower.slice(0, -1), ...upper.slice(0, -1)];
}

// The area's outline: the hull of its nodes PAD_YARDS out (a lone node or a line of them: a ring of eight corners
// round them), at most MAX_CORNERS corners (the corner that changes the outline least goes first).
function outline(list) {
	const c = centroid(list);
	let h = hull(list.map((p) => p.pt));
	if (h.length < 3) {
		const far = Math.max(PAD_YARDS, ...list.map((p) => dist(p.pt, c) + PAD_YARDS));
		h = [];
		for (let k = 0; k < 8; k++) h.push({ wx: c.wx + far * Math.cos((k * Math.PI) / 4), wy: c.wy + far * Math.sin((k * Math.PI) / 4) });
	} else {
		h = h.map((q) => {
			const d = Math.hypot(q.wx - c.wx, q.wy - c.wy) || 1;
			return { wx: q.wx + ((q.wx - c.wx) / d) * PAD_YARDS, wy: q.wy + ((q.wy - c.wy) / d) * PAD_YARDS };
		});
	}
	const area2 = (a, b, q) => Math.abs((b.wx - a.wx) * (q.wy - a.wy) - (b.wy - a.wy) * (q.wx - a.wx));
	while (h.length > MAX_CORNERS) {
		let k = 0;
		let least = Infinity;
		for (let i = 0; i < h.length; i++) {
			const v = area2(h[(i + h.length - 1) % h.length], h[(i + 1) % h.length], h[i]);
			if (v < least) {
				least = v;
				k = i;
			}
		}
		h.splice(k, 1);
	}
	return h.map((q) => ({ c: c.c, wx: q.wx, wy: q.wy }));
}

function inside(poly, wx, wy) {
	let inn = false;
	for (let i = 0, j = poly.length - 1; i < poly.length; j = i++) {
		const a = poly[i];
		const b = poly[j];
		if (a.wy > wy !== b.wy > wy && wx < ((b.wx - a.wx) * (wy - a.wy)) / (b.wy - a.wy) + a.wx) inn = !inn;
	}
	return inn;
}

// Grid points inside the outline, SAMPLE_YARDS apart (at most MAX_SAMPLES: wider apart for a large area).
function samples(poly) {
	const xs = poly.map((q) => q.wx);
	const ys = poly.map((q) => q.wy);
	const [x0, x1, y0, y1] = [Math.min(...xs), Math.max(...xs), Math.min(...ys), Math.max(...ys)];
	let step = SAMPLE_YARDS;
	while (((x1 - x0) / step) * ((y1 - y0) / step) > MAX_SAMPLES) step *= 1.5;
	const out = [];
	for (let x = x0 + step / 2; x < x1; x += step) for (let y = y0 + step / 2; y < y1; y += step) if (inside(poly, x, y)) out.push({ pt: { c: poly[0].c, wx: x, wy: y } });
	return out;
}

// The `share` quantile of `values`, each weighed by `weights`.
function quantile(values, weights, share) {
	const order = values.map((v, i) => [v, weights[i]]).sort((a, b) => a[0] - b[0]);
	const total = order.reduce((s, x) => s + x[1], 0);
	let acc = 0;
	for (const [v, w] of order) {
		acc += w;
		if (acc >= share * total - 1e-9) return v;
	}
	return order.length ? order[order.length - 1][0] : 1;
}

// World point -> map percent in the frame of `f` (the bounds route.js projects that frame with).
function toMap(ctx, map, q, live) {
	const b = live ? (ctx.data.mapFrames && ctx.data.mapFrames.forever && ctx.data.mapFrames.forever[String(map)]) || ctx.project.bounds(map) : ctx.project.bounds(map);
	return { x: ((q.wy - b.left) / (b.right - b.left)) * 100, y: ((q.wx - b.top) / (b.bottom - b.top)) * 100 };
}

// The seconds a sweep through an area's nodes takes: its walk (never under its nodes' respawn) and the stops.
function sweepSeconds(prof, a) {
	return (Math.max(a.walk, a.respawn * RUN) + (prof.stopYards || 0) * a.up) / RUN;
}

// ------------------------------------------------------------------ areas
const memo = new WeakMap();
function areasIn(ctx, prof, map, points, { faction = null, respawn = 300, maxLevel = 60 } = {}) {
	if (!points.length) return [];
	const key = `${map}|${faction}|${respawn}|${maxLevel}`;
	let byKey = memo.get(points);
	if (!byKey) memo.set(points, (byKey = new Map()));
	if (byKey.has(key)) return byKey.get(key);
	T = { ...DEFAULTS, ...(prof.areaTuning || {}) };
	const lv = pointLevels(ctx, map, points, faction);
	const all = [];
	points.forEach((p, i) => {
		if (lv[i] !== null && lv[i] <= maxLevel) all.push({ ...p, lv: lv[i] });
	});
	// The levels areas are cut at: each level the nodes ask where TIER_GROWTH more of them (by how often each is
	// up) open than at the last one, so a character of 3 gets the areas safe at 3 (Mulgore's copper by Camp
	// Narache and the plains round it), one of 10 the larger ones that take the camps in.
	const tiers = [];
	let last = 0;
	for (const l of [...new Set(all.map((p) => p.lv))].sort((a, b) => a - b)) {
		const w = all.reduce((s, p) => s + (p.lv <= l ? up(p) : 0), 0);
		if (!tiers.length || w >= last * (1 + T.tierGrowth)) {
			tiers.push(l);
			last = w;
		}
	}
	const found = [];
	for (const tier of tiers) {
		for (const a of tierAreas(ctx, prof, map, all.filter((p) => p.lv <= tier), { faction, respawn, maxLevel })) {
			// The same area at a higher level (by its name, or by most of its nodes under another name) only when it
			// holds TIER_GROWTH more nodes than at a lower one.
			const lower = found.filter((b) => (b.name === a.name && b.near === a.near) || shared(a, b) >= SAME_SHARE);
			if (lower.some((b) => b.level === a.level || a.up < b.up * (1 + T.tierGrowth))) continue;
			found.push(a);
		}
	}
	found.sort((a, b) => b.score - a.score || a.level - b.level || a.name.localeCompare(b.name));
	byKey.set(key, found);
	return found;
}

// The share of `a`'s nodes (by how often each is up) that `b` holds too.
const SAME_SHARE = 0.6;
function shared(a, b) {
	const inB = new Set(b.on.map((p) => `${p.pt.c}|${p.pt.wx}|${p.pt.wy}|${p.name}`));
	return a.on.reduce((s, p) => s + (inB.has(`${p.pt.c}|${p.pt.wx}|${p.pt.wy}|${p.name}`) ? up(p) : 0), 0) / (a.up || 1);
}

// The ground inside an outline is clear: no elite and no town of the other faction can reach any of it.
function clearGround(ctx, map, list, faction) {
	return !pointLevels(ctx, map, samples(outline(list)), faction).some((l) => l === null);
}

// A patch with its nodes near an elite or a town of the other faction left out (CLEAR_YARDS), the outline drawn
// again without them, up to CLEAR_TRIES times, so an elite in a corner cuts the corner rather than the whole
// area; null when too few nodes are left or the ground is still not clear.
function cleaned(ctx, map, list, faction) {
	for (let k = 0; k <= CLEAR_TRIES; k++) {
		if (list.length < T.minNodes) return null;
		const ground = samples(outline(list));
		const gl = pointLevels(ctx, map, ground, faction);
		if (!gl.some((l) => l === null)) return list;
		const bad = ground.filter((g, i) => gl[i] === null);
		list = list.filter((p) => !bad.some((g) => dist(g.pt, p.pt) < CLEAR_YARDS));
	}
	return null;
}

// Sparse ground (a band's Tin and Iron a few nodes to a hill): a patch with fewer than GOOD_UP nodes up joins its
// nearest patch within MERGE_YARDS, closest pair first, while the two together span at most MAX_SPAN yards, the
// ground inside stays clear (`ok`) and they lie in one subzone or one of them in open ground (`subOf`: the subzone
// holding most of a patch, or null), so an area is a stretch worth roaming, not a pair of veins, and a subzone of
// its own (Red Cloud Mesa) keeps its name.
function growSmall(groups, ok, subOf) {
	const g = groups.map((list) => ({ list, c: centroid(list), up: list.reduce((s, p) => s + up(p), 0), sub: subOf(list) }));
	const span = (a, b) => {
		const all = [...a.list, ...b.list];
		const xs = all.map((p) => p.pt.wx);
		const ys = all.map((p) => p.pt.wy);
		return Math.hypot(Math.max(...xs) - Math.min(...xs), Math.max(...ys) - Math.min(...ys));
	};
	const refused = new Set();
	for (;;) {
		let best = null;
		for (let i = 0; i < g.length; i++) {
			for (let j = i + 1; j < g.length; j++) {
				const a = g[i];
				const b = g[j];
				if (Math.min(a.up, b.up) >= T.goodUp || a.c.c !== b.c.c || refused.has(`${a.c.wx},${b.c.wx}`)) continue;
				if (a.sub && b.sub && a.sub !== b.sub) continue;
				const d = dist(a.c, b.c);
				if (d > T.mergeYards || (best && d >= best.d) || span(a, b) > T.maxSpan) continue;
				best = { i, j, d };
			}
		}
		if (!best) break;
		const list = [...g[best.i].list, ...g[best.j].list];
		if (!ok(list)) {
			refused.add(`${g[best.i].c.wx},${g[best.j].c.wx}`);
			continue;
		}
		g[best.i] = { list, c: centroid(list), up: g[best.i].up + g[best.j].up, sub: g[best.i].sub || g[best.j].sub };
		g.splice(best.j, 1);
	}
	return g.sort((a, b) => b.up - a.up);
}

// The areas over `open` (points safe at `maxLevel`, each with its level `lv`), steps 2-6 above.
function tierAreas(ctx, prof, map, open, { faction, respawn, maxLevel }) {
	const subs = subzonesOf(ctx, map);
	const zone = ctx.data.zones && ctx.data.zones[String(map)];
	const ok = (list) => clearGround(ctx, map, list, faction);
	// The subzone holding at least half of a patch's nodes (by how often each is up), or null.
	const subOf = (list) => {
		const by = new Map();
		for (const p of list) {
			const s = subzoneAt(subs, p.pt);
			if (s) by.set(s, (by.get(s) || 0) + up(p));
		}
		const total = list.reduce((s, p) => s + up(p), 0);
		let best = null;
		for (const [s, w] of by) if (!best || w > by.get(best)) best = s;
		return best && by.get(best) >= total / 2 ? best : null;
	};
	const clean = patches(open, T.patchYards)
		.map((list) => cleaned(ctx, map, list, faction))
		.filter(Boolean);
	const named = growSmall(clean, ok, subOf).map(({ list, sub }) => {
		const c = centroid(list);
		if (sub) return { list, c, sub, near: false };
		let nearest = null;
		for (const s of subs) if (s.c === c.c && (!nearest || Math.hypot(s.cx - c.wx, s.cy - c.wy) < Math.hypot(nearest.cx - c.wx, nearest.cy - c.wy))) nearest = s;
		return { list, c, sub: nearest, near: !!nearest };
	});
	// One area per name: patches of a name within MERGE_YARDS of the first join it while the ground stays clear; one
	// farther off (or that would take in an elite) is left out: the first keeps the name.
	const merged = [];
	for (const p of named) {
		const name = p.sub ? `${p.sub.id}|${p.near}` : 'zone';
		const into = merged.find((m) => m.name === name && dist(m.c, p.c) <= T.mergeYards);
		if (into && ok([...into.list, ...p.list])) into.list.push(...p.list);
		else if (!merged.some((m) => m.name === name)) merged.push({ ...p, list: p.list.slice(), name });
	}
	const live = open.length > 0 && open[0].pt.f === 'l';
	const out = [];
	for (const m of merged) {
		// The level LEVEL_SHARE of its nodes ask; the nodes above go. The ground's creatures count as the nodes' do.
		let level = quantile(
			m.list.map((p) => p.lv),
			m.list.map((p) => up(p) || 1e-3),
			T.levelShare,
		);
		let list = m.list.filter((p) => p.lv <= level);
		if (list.length < T.minNodes || list.reduce((s, p) => s + up(p), 0) < T.minUp) continue;
		const gl = pointLevels(ctx, map, samples(outline(list)), faction);
		if (gl.some((l) => l === null)) continue;
		if (gl.length) level = Math.max(level, quantile(gl, gl.map(() => 1), T.groundShare));
		level = Math.max(level, floorOf(map));
		if (level > maxLevel) continue;
		list = list.filter((p) => p.lv <= level);
		if (list.length < T.minNodes) continue;
		const poly = outline(list);
		const nodes = list.reduce((s, p) => s + up(p), 0);
		const gain = list.reduce((s, p) => s + p.w, 0);
		const heavy = list
			.slice()
			.sort((a, b) => up(b) - up(a) || a.pt.wx - b.pt.wx)
			.slice(0, MAX_TOUR);
		const first = heavy[0];
		const rest = planTour(first.pt, heavy.slice(1), first.pt);
		const walk = heavy.length > 1 ? pathLength(first.pt, rest, first.pt) : 0;
		const area = {
			map,
			name: m.sub ? m.sub.name : (zone && zone.name) || `map ${map}`,
			aid: m.sub ? m.sub.id : (zone && zone.areaId) || null,
			near: m.near,
			level,
			on: list,
			up: nodes,
			gain,
			walk,
			respawn,
			live,
			poly: poly.map((q) => toMap(ctx, map, q, live)),
			dots: heavy.slice(0, MAX_DOTS).map((p) => ({ x: p.pt.x, y: p.pt.y })),
			centre: centroid(list),
		};
		area.score = gain / (Math.max(walk, respawn * RUN) + (prof.stopYards || 0) * nodes);
		if (prof.skins) {
			const levels = list.map((p) => p.level).filter((l) => Number.isFinite(l));
			if (levels.length) area.levels = [Math.min(...levels), Math.max(...levels)];
		}
		out.push(area);
	}
	return out;
}

module.exports = { areasIn, rankScore, skillLevel, sweepSeconds, subzonesOf, floorOf, RUN, LEVEL_DECAY, DEFAULTS };
