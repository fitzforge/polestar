'use strict';
// Reference for the walk store's stage 1 parity: walklookup (JS) answers on a sample of pairs of a walks file.
// node lookup-sample.js <simDir> <faction> <out.bin> [n=100000] [seed=1]
// out: i32 n, then n × { i32 a, i32 b, i32 band, f32 yd (lookup.yd), f32 getYd, f32 getCost, i32 got (get != null), i32 has }
const fs = require('node:fs');
const ROOT = require('node:path').resolve(__dirname, '../../../..');
const { readWalks } = require(`${ROOT}/tools/lib/sim/walks`);
const { buildLookup } = require(`${ROOT}/tools/lib/sim/walklookup`);
const [simDir, faction, out, nArg, seedArg] = process.argv.slice(2);
const n = Number(nArg || 100000);
let seed = Number(seedArg || 1);
const rnd = () => ((seed = (Math.imul(seed, 1103515245) + 12345) >>> 0) / 4294967296);
const t0 = Date.now();
const doc = readWalks(simDir, faction);
const NW = doc.nw;
const L = buildLookup(doc, NW);
console.log('read+lookup', (Date.now() - t0) / 1000, 's, bands', L.bands.join(','), 'bytes', L.bytes);
const bands = L.bands;
const pickIn = (band) => {
	const t = doc.lookup[band];
	const k = Math.floor(rnd() * t.nbr.length);
	let lo = 0, hi = NW; // the row holding k
	while (hi - lo > 1) { const m = (lo + hi) >> 1; if (t.offsets[m] <= k) lo = m; else hi = m; }
	return [lo, t.nbr[k]];
};
const buf = Buffer.alloc(4 + n * 32);
buf.writeInt32LE(n, 0);
const uw = doc.unwalkable;
let hits = 0, inf = 0, none = 0;
for (let i = 0; i < n; i++) {
	const r = rnd();
	let a, b, band = bands[Math.floor(rnd() * bands.length)];
	if (r < 0.45) [a, b] = pickIn(0);
	else if (r < 0.65) { const bb = bands[1 + Math.floor(rnd() * (bands.length - 1))]; [a, b] = pickIn(bb); band = rnd() < 0.8 ? bb : band; }
	else if (r < 0.75 && uw.length) { const k = 2 * Math.floor(rnd() * (uw.length / 2)); [a, b] = rnd() < 0.5 ? [uw[k], uw[k + 1]] : [uw[k + 1], uw[k]]; }
	else { a = Math.floor(rnd() * NW); b = Math.floor(rnd() * NW); }
	if (rnd() < 0.1) [a, b] = [b, a];
	const yd = L.yd(a, b, band);
	const g = L.get(a, b, band);
	const o = 4 + i * 32;
	buf.writeInt32LE(a, o); buf.writeInt32LE(b, o + 4); buf.writeInt32LE(band, o + 8);
	buf.writeFloatLE(yd, o + 12);
	buf.writeFloatLE(g ? g[0] : -1, o + 16); buf.writeFloatLE(g ? g[1] : -1, o + 20);
	buf.writeInt32LE(g ? 1 : 0, o + 24); buf.writeInt32LE(L.has(a, b, band) ? 1 : 0, o + 28);
	if (yd === Infinity) inf++; else if (yd < 0) none++; else hits++;
}
fs.writeFileSync(out, buf);
// A route's lookups, timed: n random yd() calls.
const t1 = process.hrtime.bigint();
let s = 0;
for (let i = 0; i < n; i++) { const o = 4 + i * 32; s += L.yd(buf.readInt32LE(o), buf.readInt32LE(o + 4), buf.readInt32LE(o + 8)) > 0 ? 1 : 0; }
const ns = Number(process.hrtime.bigint() - t1);
console.log(`sample ${n}: ${hits} walks, ${inf} unwalkable, ${none} none; JS yd ${(ns / n).toFixed(0)} ns/lookup (${s})`);
