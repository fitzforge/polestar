'use strict';
// A compact walk table for the simulator's workers: the walks attachWalks reads
// (walks.js), held in typed arrays rather than Maps.
//
//   buildLookup(doc, NW) -> { bands, get(a, b, band) -> [yards, cost] | null, yd(a, b, band) -> yards | -1, has(a, b, band), zones(a, b), smooth, bytes }
//     smooth: the document's walked yards per stored yard (walks.js smoothOf; zones' yards take it).
//     zones(a, b): the base walk's yards per zone, flat [zone, yards, ...] (doc.zones, schema 4), or null.
//     doc: a walks doc (doc.pairs[band] = [a, b, yards, cost, oneWay, ...], walks.js pairStride:
//     a schema 2 doc, or one without a schema, [a, b, yards, cost, ...]), a and b world point
//     ids; a both-ways pair (oneWay 0) is used both ways, a one-way pair (oneWay 1) from a to b
//     only; NW: world.points.length (ids are 0..NW-1).
//     Per band a CSR table (offsets by point, neighbours sorted). Yards are the router's ×
//     its walked yards per yard (walks.js smoothOf), as attachWalks gives them; cost as stored. get(a, b, band) gives the one-way walk
//     from a to b when there is one, else the both-ways walk; for a band other than 0 it falls
//     back to band 0's walk when the pair isn't re-routed in that band.
//     yd(a, b, band): get's yards (same fallback) without allocating, -1 where get gives null,
//     Infinity for a pair the document marks unwalkable (doc.unwalkable: a cliff and its foot).
//     has(a, b, band): band holds the pair itself (no fallback); allocates nothing.
//     bytes: the typed arrays' total size.

const { smoothOf, pairStride } = require('./walks');

function buildBand(arr, NW, stride, smooth) {
	const oneWay = (i) => stride === 5 && arr[i + 4] === 1;
	const offsets = new Uint32Array(NW + 1);
	for (let i = 0; i < arr.length; i += stride) {
		offsets[arr[i] + 1]++;
		if (!oneWay(i)) offsets[arr[i + 1] + 1]++;
	}
	for (let p = 0; p < NW; p++) offsets[p + 1] += offsets[p];
	const total = offsets[NW];
	const nbr = new Int32Array(total);
	const yd = new Float32Array(total);
	const cost = new Float32Array(total);
	const one = new Uint8Array(total);
	const src = new Int32Array(total);
	const fill = offsets.slice(0, NW);
	const put = (a, b, y, c, o, i) => {
		const k = fill[a]++;
		nbr[k] = b;
		yd[k] = y;
		cost[k] = c;
		one[k] = o;
		src[k] = i / stride;
	};
	for (let i = 0; i < arr.length; i += stride) {
		const y = arr[i + 2] * smooth;
		if (oneWay(i)) put(arr[i], arr[i + 1], y, arr[i + 3], 1, i);
		else {
			put(arr[i], arr[i + 1], y, arr[i + 3], 0, i);
			put(arr[i + 1], arr[i], y, arr[i + 3], 0, i);
		}
	}
	// Sort each point's run by neighbour, both-ways walks before one-way ones, then source order;
	// the last of a neighbour's entries is kept: a one-way walk over the both-ways one, and of
	// two alike the last occurrence, as attachWalks' Map does. Runs are compacted in place.
	// Entries were filled in source order, so position within a run is the source order.
	let w = 0;
	let lo = 0;
	for (let p = 0; p < NW; p++) {
		const hi = offsets[p + 1];
		const idx = Array.from({ length: hi - lo }, (_, j) => lo + j).sort((x, z) => nbr[x] - nbr[z] || one[x] - one[z] || x - z);
		const sn = [];
		const sy = [];
		const sc = [];
		const ss = [];
		for (let j = 0; j < idx.length; j++) {
			const k = idx[j];
			if (j + 1 < idx.length && nbr[idx[j + 1]] === nbr[k]) continue; // a later entry wins
			sn.push(nbr[k]);
			sy.push(yd[k]);
			sc.push(cost[k]);
			ss.push(src[k]);
		}
		nbr.set(sn, w);
		yd.set(sy, w);
		cost.set(sc, w);
		src.set(ss, w);
		offsets[p] = w;
		w += sn.length;
		lo = hi;
	}
	offsets[NW] = w;
	if (w === nbr.length) return { offsets, nbr, yd, cost, src };
	return { offsets, nbr: nbr.slice(0, w), yd: yd.slice(0, w), cost: cost.slice(0, w), src: src.slice(0, w) };
}

function find(t, a, b) {
	let lo = t.offsets[a];
	let hi = t.offsets[a + 1] - 1;
	while (lo <= hi) {
		const mid = (lo + hi) >>> 1;
		const v = t.nbr[mid];
		if (v === b) return mid;
		if (v < b) lo = mid + 1;
		else hi = mid - 1;
	}
	return -1;
}

// A binary walks document (walks.js readWalks) brings its tables built for its world's point count
// (doc.nw): they are used as they are.
function buildLookup(doc, NW) {
	const tables = new Map();
	const stride = pairStride(doc);
	const built = doc.lookup && doc.nw === NW ? doc.lookup : null;
	let bytes = 0;
	for (const [band, arr] of Object.entries(doc.pairs)) {
		const t = built && built[band] ? built[band] : buildBand(arr, NW, stride, smoothOf(doc));
		tables.set(Number(band), t);
		bytes += t.offsets.byteLength + t.nbr.byteLength + t.yd.byteLength + t.cost.byteLength + t.src.byteLength;
	}
	const base = tables.get(0) || null;
	// The document's unwalkable base pairs (walks.js UNWALK_DZ), both ways.
	const unwalk = new Set();
	const uw = doc.unwalkable || [];
	for (let i = 0; i + 1 < uw.length; i += 2) {
		unwalk.add(uw[i] * NW + uw[i + 1]);
		unwalk.add(uw[i + 1] * NW + uw[i]);
	}
	const none = (a, b) => (unwalk.size && unwalk.has(a * NW + b) ? Infinity : -1);
	const get = (a, b, band = 0) => {
		if (!(a >= 0 && a < NW)) return null;
		const t = tables.get(band);
		if (t) {
			const k = find(t, a, b);
			if (k >= 0) return [t.yd[k], t.cost[k]];
		}
		if (band === 0 || !base) return null;
		const k = find(base, a, b);
		return k >= 0 ? [base.yd[k], base.cost[k]] : null;
	};
	const yd = (a, b, band = 0) => {
		if (!(a >= 0 && a < NW)) return -1;
		const t = tables.get(band);
		if (t) {
			const k = find(t, a, b);
			if (k >= 0) return t.yd[k];
		}
		if (band === 0 || !base) return none(a, b);
		const k = find(base, a, b);
		return k >= 0 ? base.yd[k] : none(a, b);
	};
	const has = (a, b, band = 0) => {
		if (!(a >= 0 && a < NW)) return false;
		const t = tables.get(band);
		return t !== undefined && find(t, a, b) >= 0;
	};
	// The base walk's yards per zone (doc.zones, schema 4): flat [zone, yards, ...], the
	// router's yards (× walks.js smoothOf for the walked line), or null (no walk, or no zones built).
	// A binary document's zones are one table ({ off, val, has }: walks.js writeWalks).
	const zoneList = doc.zones || null;
	const csr = zoneList && zoneList.off ? zoneList : null;
	const zones = (a, b) => {
		if (!zoneList || !base || !(a >= 0 && a < NW)) return null;
		const k = find(base, a, b);
		if (k < 0) return null;
		const s = base.src[k];
		if (!csr) return zoneList[s];
		return csr.has[s] ? csr.val.subarray(csr.off[s], csr.off[s + 1]) : null;
	};
	return { bands: [...tables.keys()].sort((x, z) => x - z), get, yd, has, zones, smooth: smoothOf(doc), bytes };
}

module.exports = { buildLookup, buildBand };
