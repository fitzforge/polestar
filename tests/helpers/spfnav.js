'use strict';
// Shortest Path Forever's walking-map decoder in Node, line for line after
// his Routing/PathGrid.lua (decodeGrid, decodeHeights, decodeFloors,
// decodeGraph, surface) and Path.lua's in-cluster moves (search), for the
// packer's tests (tools/lib/nav/pack.js). GPL-3.0-or-later, Cillian
// Berragan, used with his permission.
// Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.

const zlib = require('node:zlib');

const B64 = {};
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'.split('').forEach((ch, i) => (B64[ch.charCodeAt(0)] = i));
const sym = (s, i) => B64[s.charCodeAt(i - 1)]; // Lua's 1-based byte
const num = (s, i, width) => {
	const v = sym(s, i) * 64 + sym(s, i + 1);
	return width === 2 ? v : v * 64 + sym(s, i + 2);
};
const DX = [1, -1, 0, 0, 1, 1, -1, -1];
const DY = [0, 0, 1, -1, 1, -1, 1, -1];
const OPP = [1, 0, 3, 2, 7, 6, 5, 4];

// The data table a pack's files define: { cx0, cy0, nx, ny, cells, swim, zstep, graph, grid, height, floor, class,
// classed } with the packed blocks inflated (tools/load_nav.lua); classed: a map of format 2 (a class field).
function loadPack(files, map) {
	const meta = files.get(`Nav${map}.lua`);
	const field = (name) => Number(new RegExp(`\\t${name} = (-?[\\d.]+),`).exec(meta)[1]);
	const D = { cx0: field('cx0'), cy0: field('cy0'), nx: field('nx'), ny: field('ny'), cells: field('cells'), swim: field('swim'), zstep: field('zstep'), graph: {}, grid: {}, height: {}, floor: {}, class: {} };
	D.classed = /^\tclass = \{\},$/m.test(meta);
	for (const [name, src] of files) {
		if (!new RegExp(`^Nav${map}_\\d+\\.lua$`).test(name)) continue;
		for (const m of src.matchAll(/data\.packed\.(graph|grid|height|floor|class)\[(\d+)\] = \{([^}]*)\}/g)) {
			const blocks = [...m[3].matchAll(/"([A-Za-z0-9+/=]+)"/g)].map((b) => zlib.inflateSync(Buffer.from(b[1], 'base64')).toString('ascii'));
			D[m[1]][Number(m[2])] = blocks.join('');
		}
	}
	return D;
}

function surface(C, val, z, at, lc, layer, h) {
	const first = at.get(-(lc + 1));
	if (layer === 0) return val[lc] !== 0 ? lc : null;
	if (layer > 0) {
		const node = first === undefined ? undefined : first + layer - 1;
		return node !== undefined && at.get(node) === lc ? node : null;
	}
	let best = null;
	let gap = null;
	if (val[lc] !== 0) {
		best = lc;
		gap = Math.abs(z[lc] - h);
	}
	let node = first;
	while (node !== undefined && at.get(node) === lc) {
		if (gap === null || Math.abs(z[node] - h) < gap) {
			best = node;
			gap = Math.abs(z[node] - h);
		}
		node++;
	}
	return best;
}

// One cluster (0-based k): val, m (open moves + 16 * flags), z, at, links (node -> [d + 8 * (layer + 1)]), 0-based nodes.
function decodeCluster(D, k) {
	const s = D.grid[k + 1];
	if (!s) return null;
	const C = D.cells;
	const N = C * C;
	const val = [];
	const m = [];
	let valueCode = 0;
	let moveCode = 0;
	for (let i = 1; i <= s.length; i++) {
		const v = sym(s, i);
		if (v < 48) {
			valueCode = Math.floor(v / 16);
			moveCode = (v % 16) * 16;
			val.push(valueCode);
			m.push(moveCode);
		} else {
			for (let r = 48; r <= v; r++) {
				val.push(valueCode);
				m.push(moveCode);
			}
		}
	}
	if (val.length !== N) throw new Error(`cluster ${k}: ${val.length} cells, expected ${N}`);
	for (let a = N - 1; a >= 0; a--) {
		const ly = a % C;
		const f = m[a] / 16;
		if (val[a] !== 0) {
			if (a + C < N && val[a + C] !== 0 && f % 2 === 0) m[a] += 1;
			if (ly < C - 1 && val[a + 1] !== 0 && Math.floor(f) % 4 < 2) m[a] += 2;
		}
		if (a + C < N && val[a] !== 0) {
			if (ly < C - 1 && val[a + C + 1] !== 0 && ((m[a] % 2 === 1 && m[a + C] % 4 >= 2) || (m[a] % 4 >= 2 && m[a + 1] % 2 === 1) || Math.floor(f) % 8 >= 4)) m[a] += 4;
			if (ly > 0 && val[a + C - 1] !== 0 && ((m[a] % 2 === 1 && m[a + C - 1] % 4 >= 2) || (val[a - 1] !== 0 && m[a - 1] % 64 < 32 && m[a - 1] % 32 < 16) || f >= 8)) m[a] += 8;
		}
	}
	// Heights.
	const z = [];
	const hs = D.height[k + 1];
	let pos = 1;
	let rep = 0;
	let delta = 0;
	let last = 0;
	for (let i = 0; i < N; i++) {
		if (val[i] === 0) continue;
		const pred = i % C > 0 && z[i - 1] !== undefined ? z[i - 1] / D.zstep : i >= C && z[i - C] !== undefined ? z[i - C] / D.zstep : last;
		let v;
		if (rep > 0) {
			rep--;
			v = pred + delta;
		} else {
			const c = sym(hs, pos);
			if (c === 47) {
				v = num(hs, pos + 1, 2) - 2048;
				pos += 3;
			} else {
				delta = c - 23;
				pos++;
				while (pos <= hs.length && sym(hs, pos) >= 48) {
					rep += sym(hs, pos) - 47;
					pos++;
				}
				v = pred + delta;
			}
		}
		last = v;
		z[i] = v * D.zstep;
	}
	// Floors.
	const at = new Map();
	const links = new Map();
	const fs = D.floor[k + 1];
	const add = (node, d, layer) => {
		if (!links.has(node)) links.set(node, []);
		const l = links.get(node);
		if (!l.includes(d + 8 * (layer + 1))) l.push(d + 8 * (layer + 1));
	};
	let node = N;
	if (fs) {
		pos = 4;
		for (let n = num(fs, 1, 3); n > 0; n--) {
			const lc = num(fs, pos, 3);
			const count = sym(fs, pos + 3);
			pos += 4;
			at.set(-(lc + 1), node);
			for (let c = 0; c < count; c++) {
				val[node] = sym(fs, pos);
				z[node] = num(fs, pos + 1, 2) - 2048;
				at.set(node, lc);
				const steps = num(fs, pos + 3, 2);
				for (let d = 0; d < 8; d++) if (steps & (1 << d)) add(node, d, -1);
				pos += 5;
				node++;
			}
		}
		const lastFloor = node;
		for (let n = num(fs, pos, 3); n > 0; n--) {
			add(num(fs, pos + 3, 3), sym(fs, pos + 6), sym(fs, pos + 7));
			pos += 5;
		}
		for (let f = N; f < lastFloor; f++) {
			const lc = at.get(f);
			const layer = f - at.get(-(lc + 1)) + 1;
			for (const e of links.get(f) || []) {
				const d = e % 8;
				const tx = Math.floor(lc / C) + DX[d];
				const ty = (lc % C) + DY[d];
				if (tx >= 0 && ty >= 0 && tx < C && ty < C) {
					const t = surface(C, val, z, at, tx * C + ty, Math.floor(e / 8) - 1, z[f]);
					if (t !== null && t < N) add(t, OPP[d], layer);
				}
			}
		}
	}
	// Ground classes (Routing/PathGrid.lua decodeClasses): one per node, run-length; past the end (or none) 0.
	const cls = new Array(node).fill(0);
	const cs = D.class && D.class[k + 1];
	if (cs) {
		let n = 0;
		let value = 0;
		for (let i = 1; i <= cs.length; i++) {
			const v = sym(cs, i);
			if (v < 48) {
				value = v;
				cls[n++] = value;
			} else {
				for (let r = 48; r <= v; r++) cls[n++] = value;
			}
		}
	}
	return { C, N, val, m, z, at, links, nodes: node, cls };
}

// Path.lua search's moves out of node u inside the cluster: [v, length].
function movesOf(cl, u) {
	const { C, N, val, m, z, at, links } = cl;
	const out = [];
	const cell = u < N ? u : at.get(u);
	const ux = Math.floor(cell / C);
	const uy = cell % C;
	if (u < N) {
		const mi = m[u] % 16;
		if (mi % 2 === 1) out.push([u + C, 1]);
		if (ux > 0 && m[u - C] % 2 === 1) out.push([u - C, 1]);
		if (mi % 4 >= 2) out.push([u + 1, 1]);
		if (uy > 0 && m[u - 1] % 4 >= 2) out.push([u - 1, 1]);
		if (mi % 8 >= 4) out.push([u + C + 1, Math.SQRT2]);
		if (mi >= 8) out.push([u + C - 1, Math.SQRT2]);
		if (ux > 0 && uy > 0 && m[u - C - 1] % 8 >= 4) out.push([u - C - 1, Math.SQRT2]);
		if (ux > 0 && uy < C - 1 && m[u - C + 1] % 16 >= 8) out.push([u - C + 1, Math.SQRT2]);
	}
	for (const e of links.get(u) || []) {
		const d = e % 8;
		const tx = ux + DX[d];
		const ty = uy + DY[d];
		if (tx >= 0 && ty >= 0 && tx < C && ty < C) {
			const v = surface(C, val, z, at, tx * C + ty, Math.floor(e / 8) - 1, z[u]);
			if (v !== null) out.push([v, d >= 4 ? Math.SQRT2 : 1]);
		}
	}
	return out;
}

// Nodes reachable from `from` inside one cluster.
function reach(cl, from) {
	const seen = new Set([from]);
	const stack = [from];
	while (stack.length) {
		const u = stack.pop();
		for (const [v] of movesOf(cl, u)) {
			if (!seen.has(v)) {
				seen.add(v);
				stack.push(v);
			}
		}
	}
	return seen;
}

// A cluster's entrances: [{ cell, layer, comp, edges: [{ cluster offset, node, costs, yards }] }]: format 1 costs
// [swimming, walking on water] (yards undefined), format 2 (D.classed) costs [Alliance, Horde, none] and yards.
function decodeGraph(D, k) {
	const s = D.graph[k + 1];
	if (!s) return [];
	const n = num(s, 1, 2);
	const out = [];
	let pos = 3;
	for (let i = 0; i < n; i++) {
		out.push({ cell: num(s, pos, 3), layer: sym(s, pos + 3), comp: num(s, pos + 4, 2), degree: sym(s, pos + 6), edges: [] });
		pos += 7;
	}
	for (const e of out) {
		for (let j = 0; j < e.degree; j++) {
			if (D.classed) {
				e.edges.push({ offset: sym(s, pos), node: num(s, pos + 1, 2), costs: [num(s, pos + 3, 3), num(s, pos + 6, 3), num(s, pos + 9, 3)], yards: num(s, pos + 12, 2) });
				pos += 14;
			} else {
				e.edges.push({ offset: sym(s, pos), node: num(s, pos + 1, 2), costs: [num(s, pos + 3, 2), num(s, pos + 5, 2)] });
				pos += 7;
			}
		}
	}
	if (pos !== s.length + 1) throw new Error(`graph ${k}: ${s.length + 1 - pos} characters left over`);
	return out;
}

// Cluster (0-based) and local cell of a world point (PathGrid.lua locate).
function locate(D, wx, wy) {
	const TILE = 1600 / 3;
	const cs = TILE / D.cells;
	const gx = Math.floor((wx - D.cx0 * TILE) / cs);
	const gy = Math.floor((wy - D.cy0 * TILE) / cs);
	if (gx < 0 || gy < 0 || gx >= D.nx * D.cells || gy >= D.ny * D.cells) return null;
	const C = D.cells;
	return { k: Math.floor(gx / C) * D.ny + Math.floor(gy / C), lc: (gx % C) * C + (gy % C) };
}

module.exports = { loadPack, decodeCluster, decodeGraph, movesOf, reach, surface, locate };
