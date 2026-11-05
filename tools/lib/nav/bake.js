'use strict';
// Baked guide legs (data/local/research/NavArchitecture.md §4.1 L1, §4.5):
// what compile needs of them. The legs are routed and packed by Forge
// (`forge guide bake`, forge build's legs stage: rust/crates/forge/src/bake.rs
// and rust/crates/forge-nav/src/bake.rs, the string's one definition), written
// beside the guides as legs.json; compile reads them (tools/lib/dsl/project.js
// readLegs) while a guide's leg ends still hash as when they were baked.
//
//   stepTargets(guide, frames) -> [{ s, from, to }]   the legs: step s's first
//     located goal, from the last located goal before it, on one continent
//   guideHash(guide, frames)              the guide's leg ends, hashed (staleness)
//   goalWorld(goal, frames)               a compiled goal's world position
//   encodeLeg(leg) / decodeLeg(string)    the leg string, version 2 (as
//     forge-nav's bake.rs writes it; decodeLeg reads version 1 too), for tests
//
// The string (printable, one Lua literal): base-64 digits (A-Z a-z 0-9 + /),
// each 5 bits of a varint plus a continuation bit (32); signed values
// zigzagged. Fields: version (2), n; per point dx, dy (QXY yd) and dz (QZ yd)
// from the previous one (the first from 0); n-1 segment moves; n-1 segment
// floors; tail (QZ yd from the last point to the goal); m; the strip's m
// ground heights as changes in QZ yd from the one before (the first from the
// first point's z), one digit per token: 32..63 a run of 1..32 unchanged;
// 0..24 two changes a, b in -2..2 ((a + 2) * 5 + b + 2); 25..30 one change of
// -3, -2, -1, 1, 2 or 3; 31 one change whose zig value follows as a varint.
// The encoder takes a run when two level samples come next, else a pair when
// it can, else a single. Version 1 has no floors and one zigzagged varint per
// strip change.

const crypto = require('node:crypto');

const MIN_LEG_YD = 15;
const QXY = 0.5;
const QZ = 0.25;
const VERSION = 2;

const DIGITS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
const VALUE = new Map([...DIGITS].map((ch, i) => [ch, i]));

function putVarint(out, v) {
	let u = v;
	do {
		let d = u % 32;
		u = Math.floor(u / 32);
		if (u > 0) d += 32;
		out.push(DIGITS[d]);
	} while (u > 0);
}
const zig = (v) => (v < 0 ? -2 * v - 1 : 2 * v);
const unzig = (u) => (u % 2 ? -(u + 1) / 2 : u / 2);

// The world position of a compiled goal (its own place, else its first
// candidate's, else its first spawn spot's), or null.
function goalWorld(goal, frames) {
	let map = goal.map;
	let x = goal.x;
	let y = goal.y;
	let f = goal.f;
	if ((x == null || y == null) && Array.isArray(goal.candidates) && goal.candidates[0]) ({ map, x, y, f } = goal.candidates[0]);
	if ((x == null || y == null) && Array.isArray(goal.spots) && goal.spots[0]) ({ x, y } = goal.spots[0]);
	if (map == null || x == null || y == null) return null;
	const b = f === 'e' ? frames.era && frames.era[map] : (frames.forever && frames.forever[map]) || (frames.era && frames.era[map]);
	if (!b) return null;
	return { c: b.c, wx: b.top + ((b.bottom - b.top) * y) / 100, wy: b.left + ((b.right - b.left) * x) / 100 };
}

// Step s (1-based, as the addon counts) and its leg in: from the last located
// goal before the step to its first located goal, on one continent and at
// least MIN_LEG_YD apart.
function stepTargets(guide, frames) {
	const out = [];
	let last = null;
	guide.steps.forEach((step, i) => {
		let first = null;
		let end = null;
		for (const goal of step.goals || []) {
			if (goal.t === 'note') continue;
			const p = goalWorld(goal, frames);
			if (!p) continue;
			if (!first) first = p;
			end = p;
		}
		if (first && last && last.c === first.c && Math.hypot(first.wx - last.wx, first.wy - last.wy) >= MIN_LEG_YD) out.push({ s: i + 1, from: last, to: first });
		if (end) last = end;
	});
	return out;
}

function guideHash(guide, frames) {
	const h = crypto.createHash('sha1');
	for (const t of stepTargets(guide, frames)) h.update(`${t.s}:${legKey(t)};`);
	return h.digest('hex').slice(0, 12);
}

const legKey = (t) => `${t.from.c}:${Math.round(t.from.wx)},${Math.round(t.from.wy)}>${Math.round(t.to.wx)},${Math.round(t.to.wy)}`;

function encodeLeg({ pts, cls, floor = cls.map(() => 0), tail, strip }) {
	const out = [];
	putVarint(out, VERSION);
	putVarint(out, pts.length);
	let px = 0;
	let py = 0;
	let pz = 0;
	for (const [x, y, z] of pts) {
		const qx = Math.round(x / QXY);
		const qy = Math.round(y / QXY);
		const qz = Math.round(z / QZ);
		putVarint(out, zig(qx - px));
		putVarint(out, zig(qy - py));
		putVarint(out, zig(qz - pz));
		px = qx;
		py = qy;
		pz = qz;
	}
	for (const c of cls) putVarint(out, c);
	for (const f of floor) putVarint(out, f);
	putVarint(out, Math.max(0, Math.round(tail / QZ)));
	putVarint(out, strip.length);
	let sz = Math.round(pts[0][2] / QZ);
	const ds = strip.map((z) => {
		const q = Math.round(z / QZ);
		const d = q - sz;
		sz = q;
		return d;
	});
	let i = 0;
	while (i < ds.length) {
		const a = ds[i];
		const b = ds[i + 1];
		if (a === 0 && b === 0) {
			let j = i;
			while (j < ds.length && ds[j] === 0 && j - i < 32) j++;
			out.push(DIGITS[31 + (j - i)]);
			i = j;
		} else if (b !== undefined && Math.abs(a) <= 2 && Math.abs(b) <= 2) {
			out.push(DIGITS[(a + 2) * 5 + (b + 2)]);
			i += 2;
		} else if (a === 0) {
			out.push(DIGITS[32]);
			i++;
		} else if (Math.abs(a) <= 3) {
			out.push(DIGITS[25 + SINGLE.indexOf(a)]);
			i++;
		} else {
			out.push(DIGITS[31]);
			putVarint(out, zig(a));
			i++;
		}
	}
	return out.join('');
}

// The strip's single-change tokens 25..30.
const SINGLE = [-3, -2, -1, 1, 2, 3];

function decodeLeg(s) {
	let i = 0;
	const digit = () => {
		if (i >= s.length) throw new Error('leg: cut short');
		const d = VALUE.get(s[i++]);
		if (d === undefined) throw new Error('leg: not a digit');
		return d;
	};
	const next = () => {
		let v = 0;
		let mul = 1;
		for (;;) {
			const d = digit();
			v += (d % 32) * mul;
			if (d < 32) return v;
			mul *= 32;
		}
	};
	const version = next();
	if (version !== 1 && version !== 2) throw new Error(`leg version ${version}`);
	const n = next();
	const pts = [];
	let qx = 0;
	let qy = 0;
	let qz = 0;
	for (let k = 0; k < n; k++) {
		qx += unzig(next());
		qy += unzig(next());
		qz += unzig(next());
		pts.push([qx * QXY, qy * QXY, qz * QZ]);
	}
	const cls = [];
	for (let k = 0; k < n - 1; k++) cls.push(next());
	const floor = [];
	for (let k = 0; k < n - 1; k++) floor.push(version === 2 ? next() : 0);
	const tail = next() * QZ;
	const m = next();
	const strip = [];
	let sz = Math.round(pts[0][2] / QZ);
	while (strip.length < m) {
		if (version === 1) {
			sz += unzig(next());
			strip.push(sz * QZ);
			continue;
		}
		const d = digit();
		if (d >= 32) {
			for (let k = 0; k < d - 31; k++) strip.push(sz * QZ);
		} else if (d < 25) {
			for (const c of [Math.floor(d / 5) - 2, (d % 5) - 2]) {
				sz += c;
				strip.push(sz * QZ);
			}
		} else {
			sz += d < 31 ? SINGLE[d - 25] : unzig(next());
			strip.push(sz * QZ);
		}
	}
	if (strip.length !== m || i !== s.length) throw new Error('leg: does not read');
	return { pts, cls, floor, tail, strip };
}

module.exports = { stepTargets, guideHash, goalWorld, encodeLeg, decodeLeg };
