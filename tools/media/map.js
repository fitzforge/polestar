'use strict';
// The map and minimap marks (Polestar.Pins): one family of glyphs on a
// 24-unit grid, from the map icons design handoff (direction "1a",
// geometric: filled silhouettes cut out by 1.5-unit gaps, a 3-unit stroke for
// the linear parts), and the kit every mark is built from: a bevelled
// medallion per skin (the one painted piece), and white masks the addon tints
// (rings, glow, the minimap edge pointer, the count badge).
//
// Each glyph is a white mask the addon tints with SetVertexColor, so a mark
// takes any colour at run time (the player's accent, a state). Two things are
// baked in: a relief (the glyph's grey runs from white over its top 38% to
// 58% at the bottom, so the tint is shaded) and a black contour (the glyph
// grown by 1.25 units, black at 92%, under it: black stays black under a
// tint, as the arrow's dark edge in nav.js). The texture covers the grid with
// a 1.5-unit margin for that contour: 27 units over 64 px, so the addon draws
// it 27/24 of the mark's size.
//
// The glyphs are written as SVG path data (M L H V C S A Z, absolute and
// relative), filled even-odd (inner sub-paths cut out) or stroked with round
// caps; pathShape() turns each into a signed distance in grid units.

const path = require('node:path');
const { Canvas, sdf } = require('../lib/tga');

const WHITE = [1, 1, 1, 1];
const TEX = 64;            // glyph texture, px
const FRAME = 27;          // grid units it covers (24 + 1.5 margin each side)
const ORIGIN = -1.5;       // grid unit at the texture's left/top edge
const PX = TEX / FRAME;    // px per grid unit
const STROKE = 3;          // the family's stroke, grid units
const CONTOUR = 1.25;      // contour growth, grid units
const CONTOUR_ALPHA = 0.92;
const RELIEF_FROM = 0.38;  // relief: white down to here (fraction of the 24-unit height)
const RELIEF_TO = 0.58;    // then down to this grey at the bottom

// ---------------------------------------------------------------------------
// SVG path data -> polylines -> signed distance
// ---------------------------------------------------------------------------

const ARC_STEP = Math.PI / 24;
const CURVE_STEPS = 16;

function tokens(d) {
	const out = [];
	const re = /([MmLlHhVvCcSsAaZz])|(-?(?:\d+\.?\d*|\.\d+)(?:e-?\d+)?)/g;
	let m;
	while ((m = re.exec(d))) out.push(m[1] || Number(m[2]));
	return out;
}

// Endpoint arc (SVG F.6.5) to points, the start excluded.
function arcPoints(x1, y1, rx, ry, phi, large, sweep, x2, y2) {
	if (rx === 0 || ry === 0) return [[x2, y2]];
	rx = Math.abs(rx);
	ry = Math.abs(ry);
	const cp = Math.cos(phi), sp = Math.sin(phi);
	const dx = (x1 - x2) / 2, dy = (y1 - y2) / 2;
	const x1p = cp * dx + sp * dy, y1p = -sp * dx + cp * dy;
	const lam = (x1p * x1p) / (rx * rx) + (y1p * y1p) / (ry * ry);
	if (lam > 1) {
		rx *= Math.sqrt(lam);
		ry *= Math.sqrt(lam);
	}
	const num = rx * rx * ry * ry - rx * rx * y1p * y1p - ry * ry * x1p * x1p;
	const den = rx * rx * y1p * y1p + ry * ry * x1p * x1p;
	let co = Math.sqrt(Math.max(0, num / den));
	if (large === sweep) co = -co;
	const cxp = (co * rx * y1p) / ry, cyp = (-co * ry * x1p) / rx;
	const cx = cp * cxp - sp * cyp + (x1 + x2) / 2, cy = sp * cxp + cp * cyp + (y1 + y2) / 2;
	const ang = (ux, uy, vx, vy) => {
		const a = Math.atan2(ux * vy - uy * vx, ux * vx + uy * vy);
		return a;
	};
	const t1 = ang(1, 0, (x1p - cxp) / rx, (y1p - cyp) / ry);
	let dt = ang((x1p - cxp) / rx, (y1p - cyp) / ry, (-x1p - cxp) / rx, (-y1p - cyp) / ry);
	if (!sweep && dt > 0) dt -= 2 * Math.PI;
	if (sweep && dt < 0) dt += 2 * Math.PI;
	const n = Math.max(2, Math.ceil(Math.abs(dt) / ARC_STEP));
	const pts = [];
	for (let i = 1; i <= n; i++) {
		const t = t1 + (dt * i) / n;
		const ex = rx * Math.cos(t), ey = ry * Math.sin(t);
		pts.push([cp * ex - sp * ey + cx, sp * ex + cp * ey + cy]);
	}
	pts[pts.length - 1] = [x2, y2];
	return pts;
}

function cubicPoints(x0, y0, x1, y1, x2, y2, x3, y3) {
	const pts = [];
	for (let i = 1; i <= CURVE_STEPS; i++) {
		const t = i / CURVE_STEPS, u = 1 - t;
		pts.push([
			u * u * u * x0 + 3 * u * u * t * x1 + 3 * u * t * t * x2 + t * t * t * x3,
			u * u * u * y0 + 3 * u * u * t * y1 + 3 * u * t * t * y2 + t * t * t * y3,
		]);
	}
	return pts;
}

// -> [{ pts: [[x, y], ...], closed }]
function parsePath(d) {
	const t = tokens(d);
	const subs = [];
	let i = 0, cmd = null, x = 0, y = 0, sx = 0, sy = 0, cur = null, lastC = null;
	const num = () => t[i++];
	const start = (nx, ny) => {
		cur = { pts: [[nx, ny]], closed: false };
		subs.push(cur);
		x = sx = nx;
		y = sy = ny;
	};
	const to = (pts) => {
		for (const p of pts) cur.pts.push(p);
		const last = pts[pts.length - 1];
		x = last[0];
		y = last[1];
	};
	while (i < t.length) {
		if (typeof t[i] === 'string') cmd = t[i++];
		const rel = cmd === cmd.toLowerCase();
		const C = cmd.toUpperCase();
		if (C === 'Z') {
			cur.closed = true;
			x = sx;
			y = sy;
			lastC = null;
			cmd = null;
			continue;
		}
		if (C === 'M') {
			const nx = num() + (rel ? x : 0), ny = num() + (rel ? y : 0);
			start(nx, ny);
			cmd = rel ? 'l' : 'L';
			lastC = null;
		} else if (C === 'L') {
			to([[num() + (rel ? x : 0), num() + (rel ? y : 0)]]);
			lastC = null;
		} else if (C === 'H') {
			to([[num() + (rel ? x : 0), y]]);
			lastC = null;
		} else if (C === 'V') {
			to([[x, num() + (rel ? y : 0)]]);
			lastC = null;
		} else if (C === 'C' || C === 'S') {
			let x1, y1;
			if (C === 'C') {
				x1 = num() + (rel ? x : 0);
				y1 = num() + (rel ? y : 0);
			} else {
				x1 = lastC ? 2 * x - lastC[0] : x;
				y1 = lastC ? 2 * y - lastC[1] : y;
			}
			const x2 = num() + (rel ? x : 0), y2 = num() + (rel ? y : 0);
			const x3 = num() + (rel ? x : 0), y3 = num() + (rel ? y : 0);
			to(cubicPoints(x, y, x1, y1, x2, y2, x3, y3));
			lastC = [x2, y2];
		} else if (C === 'A') {
			const rx = num(), ry = num(), rot = num(), large = num(), sweep = num();
			const x2 = num() + (rel ? x : 0), y2 = num() + (rel ? y : 0);
			to(arcPoints(x, y, rx, ry, (rot * Math.PI) / 180, !!large, !!sweep, x2, y2));
			lastC = null;
		} else {
			throw new Error(`unsupported path command ${cmd}`);
		}
	}
	return subs;
}

function segDist(px, py, ax, ay, bx, by) {
	const pax = px - ax, pay = py - ay, bax = bx - ax, bay = by - ay;
	const l = bax * bax + bay * bay;
	const h = l > 0 ? Math.max(0, Math.min(1, (pax * bax + pay * bay) / l)) : 0;
	return Math.hypot(pax - bax * h, pay - bay * h);
}

// A filled path (even-odd: inner sub-paths are holes): signed distance in
// grid units, negative inside.
function fillShape(d) {
	const subs = parsePath(d);
	const edges = [];
	for (const s of subs) {
		const p = s.pts;
		for (let k = 0; k < p.length; k++) {
			const a = p[k], b = p[(k + 1) % p.length];
			edges.push([a[0], a[1], b[0], b[1]]);
		}
	}
	return (x, y) => {
		let dist = Infinity, inside = false;
		for (const [ax, ay, bx, by] of edges) {
			dist = Math.min(dist, segDist(x, y, ax, ay, bx, by));
			if (ay > y !== by > y && x < ((bx - ax) * (y - ay)) / (by - ay) + ax) inside = !inside;
		}
		return inside ? -dist : dist;
	};
}

// A stroked path (round caps and joins): distance to its lines minus half the width.
function strokeShape(d, w) {
	const subs = parsePath(d);
	const segs = [];
	for (const s of subs) {
		const p = s.pts;
		const n = s.closed ? p.length : p.length - 1;
		for (let k = 0; k < n; k++) {
			const a = p[k], b = p[(k + 1) % p.length];
			segs.push([a[0], a[1], b[0], b[1]]);
		}
	}
	const half = w / 2;
	return (x, y) => {
		let dist = Infinity;
		for (const [ax, ay, bx, by] of segs) dist = Math.min(dist, segDist(x, y, ax, ay, bx, by));
		return dist - half;
	};
}

// ---------------------------------------------------------------------------
// The glyphs (handoff direction "1a"). Each is a list of { f: path } filled
// even-odd or { s: path, w } stroked (w defaults to STROKE).
// ---------------------------------------------------------------------------

const n = (v) => Math.round(v * 100) / 100;
const Ci = (x, y, r) => `M${n(x - r)} ${n(y)}a${r} ${r} 0 1 0 ${n(2 * r)} 0a${r} ${r} 0 1 0 ${n(-2 * r)} 0Z`;
const El = (x, y, rx, ry) => `M${n(x - rx)} ${n(y)}a${rx} ${ry} 0 1 0 ${n(2 * rx)} 0a${rx} ${ry} 0 1 0 ${n(-2 * rx)} 0Z`;
const Re = (x, y, w, h) => `M${x} ${y}h${w}v${h}h${-w}Z`;
const RR = (x, y, w, h, r) =>
	`M${n(x + r)} ${y}h${n(w - 2 * r)}a${r} ${r} 0 0 1 ${r} ${r}v${n(h - 2 * r)}a${r} ${r} 0 0 1 ${-r} ${r}h${n(-(w - 2 * r))}a${r} ${r} 0 0 1 ${-r} ${-r}v${n(-(h - 2 * r))}a${r} ${r} 0 0 1 ${r} ${-r}Z`;
const STAR = (x, y, rx, ry, w) =>
	`M${x} ${n(y - ry)}L${n(x + w)} ${n(y - w)}L${n(x + rx)} ${y}L${n(x + w)} ${n(y + w)}L${x} ${n(y + ry)}L${n(x - w)} ${n(y + w)}L${n(x - rx)} ${y}L${n(x - w)} ${n(y - w)}Z`;
const POLY = (pts) => 'M' + pts.map((p) => n(p[0]) + ' ' + n(p[1])).join('L') + 'Z';
function GEAR(cx, cy, ro, ri, k) {
	const st = (Math.PI * 2) / k, p = [];
	for (let i = 0; i < k; i++) {
		const a = i * st - Math.PI / 2;
		for (const [o, r] of [[-0.3, ri], [-0.15, ro], [0.15, ro], [0.3, ri]]) p.push([cx + r * Math.cos(a + o * st), cy + r * Math.sin(a + o * st)]);
	}
	return POLY(p);
}
const F = (d) => ({ f: d });
const S = (d, w) => ({ s: d, w });
const PIN = 'M12 22.5C12 22.5 4.5 15.25 4.5 9.75A7.5 7.5 0 0 1 19.5 9.75C19.5 15.25 12 22.5 12 22.5Z';

const GLYPHS = {
	target: [F(PIN + STAR(12, 9.75, 4.5, 4.75, 1.2))],
	'pin-small': [F(PIN)],
	pin: [F(PIN + Ci(12, 9.75, 3))],
	stop: [F(PIN + Ci(12, 9.75, 3.5) + Ci(12, 9.75, 1.5))],
	elevator: [F(RR(5, 2.5, 14, 19, 2.5) + 'M12 5.75L15.75 10.25H8.25Z' + 'M12 18.25L8.25 13.75H15.75Z')],
	portal: [S(El(12, 12, 6.25, 8.75)), F(El(12, 12, 2.25, 4.25))],
	bridge: [F('M1.5 7.5H22.5V11H20.5V20.5H16.5V17.5A4.5 4.5 0 0 0 7.5 17.5V20.5H3.5V11H1.5Z')],
	cave: [F('M2 20.5C2 11.5 6.5 4.5 12 4.5S22 11.5 22 20.5Z' + 'M8 20.5V16A4 4 0 0 1 16 16V20.5Z')],
	pass: [F('M1 20.5L8.5 6.5L12.5 13.25L15.75 9L23 20.5Z' + 'M10.5 20.5L12.25 15.5H13.75L15.5 20.5Z')],
	flightmaster: [
		F('M12 9.5C10 6.5 6.5 4.75 1.5 5.25C4.25 6.75 5.75 9 6.25 11.75C8.6 11.75 10.6 12.75 12 15C13.4 12.75 15.4 11.75 17.75 11.75C18.25 9 19.75 6.75 22.5 5.25C17.5 4.75 14 6.5 12 9.5Z'),
		F('M12 13L14.5 16.75L12 21L9.5 16.75Z'),
		F(Ci(12, 6.5, 2)),
	],
	boat: [F('M2.5 15H21.5L18.25 20.5H5.75Z'), F('M11 2.75V13.25H4Z'), F('M13 4.75L19.75 13.25H13Z')],
	zeppelin: [F(El(13.5, 9.5, 8.5, 5.25)), F('M1 5L6.75 8V11L1 14Z'), F(Re(11, 14, 1.5, 3.5)), F(Re(14.5, 14, 1.5, 3.5)), F('M9.5 17H17L15.75 20.5H10.75Z')],
	tram: [F(RR(5, 2.5, 14, 15.5, 3.5) + RR(7.5, 5, 9, 5.5, 1) + Ci(9, 14.25, 1.5) + Ci(15, 14.25, 1.5)), S('M8.5 18.5L6.5 21.5M15.5 18.5L17.5 21.5', 2.5)],
	inn: [F('M12 2.5L22 10.5H19.5V21H4.5V10.5H2Z' + 'M9.5 21V16.5A2.5 2.5 0 0 1 14.5 16.5V21Z'), F(Re(15.75, 3.5, 2.5, 4))],
	dungeon: [F('M3.5 21.5V11A8.5 8.5 0 0 1 20.5 11V21.5Z' + 'M7 21.5V11.5A5 5 0 0 1 17 11.5V21.5Z'), F(STAR(12, 15.5, 3.5, 3.75, 1))],
	raid: [F('M2 21.5V3.5H5.5V6.5H7.5V3.5H11V6.5H13V3.5H16.5V6.5H18.5V3.5H22V21.5Z' + 'M7.5 21.5V14A4.5 4.5 0 0 1 16.5 14V21.5Z'), F(STAR(12, 16.75, 3, 3, 0.85))],
	repair: [F('M2 6.5H18.5C18.5 8.75 19.75 10 22.5 10.25V11.5H16.25L15 15.25H17.75V19.5H6.25V15.25H9L7.75 11.25C5 11 2.75 9.75 2 7.75Z')],
	mailbox: [F('M3 5H21L12 12Z'), F('M3 8.25L12 15.25L21 8.25V19H3Z')],
	'trainer-class': [F('M11 6.25C8.75 4.75 5.75 4.25 2.25 4.75V19C5.75 18.5 8.75 19 11 20.5Z'), F('M13 6.25C15.25 4.75 18.25 4.25 21.75 4.75V19C18.25 18.5 15.25 19 13 20.5Z')],
	'trainer-weapon': [S('M3.5 20.5L20 4'), S('M20.5 20.5L4 4'), S('M4.75 14.75L9.25 19.25', 2.5), S('M19.25 14.75L14.75 19.25', 2.5)],
	auction: [F('M10.45 2.67L14.33 6.55L6.55 14.33L2.67 10.45Z'), S('M9.5 9.5L19.75 19.75'), F(RR(2.5, 19, 10, 2.75, 1))],
	bank: [F('M12 2L22 7.25V9H2V7.25Z'), F(Re(4, 10.5, 3.5, 7.5)), F(Re(10.25, 10.5, 3.5, 7.5)), F(Re(16.5, 10.5, 3.5, 7.5)), F(Re(2, 19.5, 20, 2.5))],
	battlemaster: [F(Re(3.75, 2, 2.5, 20)), F('M7.75 3.5H21L17.75 8.25L21 13H7.75Z')],
	ankh: [S(El(12, 7, 3.25, 4)), F(RR(4.5, 11.75, 15, 2.75, 1.375)), F('M10.5 14H13.5L14.75 21.5H9.25Z')],
	stable: [F('M4.5 3V12.5A7.5 7.5 0 0 0 19.5 12.5V3H15.75V12.5A3.75 3.75 0 0 1 8.25 12.5V3Z'), F(Re(3.5, 2.5, 5.75, 2)), F(Re(14.75, 2.5, 5.75, 2))],
	'trainer-profession': [F('M2.5 9C6 4.5 9 3 12 3S18 4.5 21.5 9L19.5 10.25C16.5 7.5 14.25 6.5 12 6.5S7.5 7.5 4.5 10.25Z'), S('M12 5.5V21.5')],
	vendor: [F('M8.5 2.5H15.5L13.75 5.75H10.25Z'), F('M10 7.5H14C18.5 9.25 20.75 12.75 20.75 15.75C20.75 19.5 17.5 21.5 12 21.5S3.25 19.5 3.25 15.75C3.25 12.75 5.5 9.25 10 7.5Z')],
	'quest-available': [F('M9.5 3H14.5L13.5 15H10.5Z'), F(Ci(12, 19.25, 2.25))],
	'quest-turnin': [S('M7.5 8.25A4.5 4.5 0 1 1 14.4 12.05C12.9 13 12 13.75 12 15.25', 3.25), F(Ci(12, 19.75, 2.25))],
	kill: [
		F(
			'M12 2.75C7.25 2.75 3.75 6.25 3.75 10.75C3.75 13.5 5 15.6 7 16.9V20.25C7 20.9 7.5 21.25 8 21.25H16C16.5 21.25 17 20.9 17 20.25V16.9C19 15.6 20.25 13.5 20.25 10.75C20.25 6.25 16.75 2.75 12 2.75Z' +
				Ci(8.6, 11, 2.35) + Ci(15.4, 11, 2.35) + 'M12 13.75L13.4 16.5H10.6Z' + Re(9.5, 18.5, 1.5, 2.75) + Re(13, 18.5, 1.5, 2.75),
		),
	],
	use: [F(GEAR(12, 12, 10, 7.25, 8) + Ci(12, 12, 3))],
	explore: [S(Ci(12, 12, 8.25)), F('M16.25 7.75L13.6 13.6L7.75 16.25L10.4 10.4Z')],
	loot: [F('M2.5 13.5H8L9.5 16.5H14.5L16 13.5H21.5V21H2.5Z'), F(Re(10.5, 2.5, 3, 7)), F('M6.75 8.5H17.25L12 13.75Z')],
	rare: [S(Ci(12, 12, 6.75)), S('M12 1.75V7.25M12 16.75V22.25M1.75 12H7.25M16.75 12H22.25'), F(Ci(12, 12, 1.75))],
	treasure: [F('M3 10V8.25A3.75 3.75 0 0 1 6.75 4.5H17.25A3.75 3.75 0 0 1 21 8.25V10Z'), F('M3 11.75H21V20.25H3Z' + 'M10.5 11.75H13.5V15L12 16.25L10.5 15Z')],
	corpse: [F('M5 21.5V10A7 7 0 0 1 19 10V21.5Z' + 'M11 6.25H13V8.75H15.5V10.75H13V16H11V10.75H8.5V8.75H11Z')],
};

// A glyph's signed distance (grid units): the union of its elements.
function glyphShape(els) {
	const parts = els.map((e) => (e.f != null ? fillShape(e.f) : strokeShape(e.s, e.w || STROKE)));
	return (x, y) => {
		let d = Infinity;
		for (const s of parts) d = Math.min(d, s(x, y));
		return d;
	};
}

// The relief: white over the top 38% of the 24-unit grid, then down to 58% grey.
function relief(gy) {
	const t = Math.max(0, Math.min(1, gy / 24));
	if (t <= RELIEF_FROM) return 1;
	return 1 - ((1 - RELIEF_TO) * (t - RELIEF_FROM)) / (1 - RELIEF_FROM);
}

// A glyph texture: the contour (black, 92%) under the glyph (white, relief).
function glyph(els) {
	const shape = glyphShape(els);
	const c = new Canvas(TEX, TEX);
	for (let y = 0; y < TEX; y++) {
		for (let x = 0; x < TEX; x++) {
			const gx = ORIGIN + (x + 0.5) / PX, gy = ORIGIN + (y + 0.5) / PX;
			const d = shape(gx, gy) * PX; // px
			const ga = Math.max(0, Math.min(1, 0.5 - d));
			const ca = Math.max(0, Math.min(1, 0.5 - (d - CONTOUR * PX))) * CONTOUR_ALPHA;
			const oa = ga + ca * (1 - ga);
			if (oa <= 0) continue;
			const v = (relief(gy) * ga) / oa;
			const i = (y * TEX + x) * 4;
			c.px[i] = c.px[i + 1] = c.px[i + 2] = v;
			c.px[i + 3] = oa;
		}
	}
	return c;
}

// ---------------------------------------------------------------------------
// The kit
// ---------------------------------------------------------------------------

const hex = (h) => [parseInt(h.slice(1, 3), 16) / 255, parseInt(h.slice(3, 5), 16) / 255, parseInt(h.slice(5, 7), 16) / 255];
function stops(list, t) {
	t = Math.max(0, Math.min(1, t));
	for (let k = 1; k < list.length; k++) {
		const [t1, c1] = list[k];
		const [t0, c0] = list[k - 1];
		if (t <= t1) {
			const u = t1 > t0 ? (t - t0) / (t1 - t0) : 0;
			return c0.map((v, j) => v + (c1[j] - v) * u);
		}
	}
	return list[list.length - 1][1];
}

// The medallion of each skin (the handoff's svg/kit/medallion-<skin>.svg, 64
// px): a black hairline at 80% (85% in Hearth), a bevelled rim in a vertical
// gradient, and the ground in a radial gradient lit at 36% of its height, with
// a 1 px inner shadow along its top. Painted: the one piece the addon draws
// untinted.
const MEDALLIONS = {
	polestar: {
		edge: 0.8, ground: 25.315,
		rim: [[0, hex('#F6DC9C')], [0.45, hex('#E6BA66')], [1, hex('#8F6A2C')]],
		base: [[0, hex('#2D3963')], [0.58, hex('#141B36')], [1, hex('#0A0D1A')]],
	},
	halo: {
		edge: 0.8, ground: 26.84,
		rim: [[0, hex('#FFFAF2')], [0.45, hex('#D2C9BD')], [1, hex('#6E665D')]],
		base: [[0, hex('#241E18')], [0.58, hex('#0E0B08')], [1, hex('#080604')]],
	},
	hearth: {
		edge: 0.85, ground: 24.705,
		rim: [[0, hex('#FBE7A6')], [0.35, hex('#D9A84A')], [0.7, hex('#8A5F1E')], [1, hex('#4A3010')]],
		base: [[0, hex('#52301F')], [0.55, hex('#2C150E')], [1, hex('#170A07')]],
	},
};

function medallion(m) {
	const c = new Canvas(64, 64);
	const C = 32;
	const inner = 64 / 22; // 1 px of a 22 px medallion, in texture px
	c.fill(sdf.circle(C, C, 31.5), [0, 0, 0, m.edge]);
	// The rim: a vertical gradient over its own height.
	for (let y = 0; y < 64; y++) {
		for (let x = 0; x < 64; x++) {
			const px = x + 0.5, py = y + 0.5;
			const r = Math.hypot(px - C, py - C);
			const i = (y * 64 + x) * 4;
			let col = null, a = 0;
			const rimA = Math.max(0, Math.min(1, 30.5 - r + 0.5));
			if (rimA > 0) {
				col = stops(m.rim, (py - (C - 30.5)) / 61);
				a = rimA;
			}
			const baseA = Math.max(0, Math.min(1, m.ground - r + 0.5));
			if (baseA > 0) {
				// Radial: centre (0.5, 0.36) of the ground's box, radius 0.64 of it.
				const box = m.ground * 2, bx = C - m.ground, by = C - m.ground;
				const t = Math.hypot((px - (bx + 0.5 * box)) / box, (py - (by + 0.36 * box)) / box) / 0.64;
				let g = stops(m.base, t);
				// The inner shadow: 1 px along the top of the ground, at 70%.
				const fromEdge = m.ground - r;
				const top = Math.max(0, (C - py) / m.ground);
				const sh = 0.7 * Math.max(0, 1 - fromEdge / inner) * top;
				g = g.map((v) => v * (1 - sh));
				col = col ? col.map((v, j) => v * (1 - baseA) + g[j] * baseA) : g;
				a = Math.max(a, baseA);
			}
			if (!col) continue;
			const da = c.px[i + 3];
			const oa = a + da * (1 - a);
			for (let j = 0; j < 3; j++) c.px[i + j] = (col[j] * a + c.px[i + j] * da * (1 - a)) / oa;
			c.px[i + 3] = oa;
		}
	}
	return c;
}

// The ring (kit/ring.svg): 1.5 px on a 32 px circle; the dashed ring
// (kit/ring-dashed.svg): 1 px, dashes of 3 on 2.
function ring() {
	return new Canvas(64, 64).fill(sdf.ring(32, 32, 30.5, 3), WHITE);
}
function ringDashed() {
	const c = new Canvas(64, 64);
	const r = 31, circ = 2 * Math.PI * r, dash = (3 / 32) * 64, gap = (2 / 32) * 64;
	const period = circ / Math.round(circ / (dash + gap));
	const on = period * (dash / (dash + gap));
	return c.fill((x, y) => {
		const ringD = Math.abs(Math.hypot(x - 32, y - 32) - r) - 1;
		const a = (Math.atan2(y - 32, x - 32) + Math.PI) * r;
		const p = a % period;
		const dashD = p < on ? 0 : Math.min(p - on, period - p);
		return Math.max(ringD, dashD - 0.0);
	}, WHITE);
}

// The glow (kit/glow.svg): a radial fade, 55% at the centre, 22% at 45%, 0 at the rim.
function glow() {
	const c = new Canvas(64, 64);
	for (let y = 0; y < 64; y++) {
		for (let x = 0; x < 64; x++) {
			const t = Math.hypot(x + 0.5 - 32, y + 0.5 - 32) / 32;
			if (t >= 1) continue;
			const a = t < 0.45 ? 0.55 + (0.22 - 0.55) * (t / 0.45) : 0.22 * (1 - (t - 0.45) / 0.55);
			const i = (y * 64 + x) * 4;
			c.px[i] = c.px[i + 1] = c.px[i + 2] = 1;
			c.px[i + 3] = a;
		}
	}
	return c;
}

// The minimap edge pointer (kit/edge.svg): a triangle pointing up, 16 by 12.
function edge() {
	return new Canvas(32, 32).fill(sdf.polygon([[16, 4], [32, 28], [0, 28]]), WHITE);
}

// The badge (kit/badge.svg): a capsule 32 by 16, drawn as three slices for a
// width that follows its text (left cap, middle, right cap: 8 + 16 + 8 px).
function badge() {
	return new Canvas(32, 16).fill(sdf.box(16, 8, 15.25, 7.25, 7.25), WHITE);
}

// The glyphs the addon uses, by file name (Media/Map/icon-<name>.tga).
function generate(addonRoot) {
	const dir = path.join(addonRoot, 'Media', 'Map');
	const out = [];
	for (const [name, els] of Object.entries(GLYPHS)) out.push(glyph(els).write(path.join(dir, `icon-${name}.tga`)));
	for (const [skin, m] of Object.entries(MEDALLIONS)) out.push(medallion(m).write(path.join(dir, `medallion-${skin}.tga`)));
	out.push(ring().write(path.join(dir, 'ring.tga')));
	out.push(ringDashed().write(path.join(dir, 'ring-dashed.tga')));
	out.push(glow().write(path.join(dir, 'glow.tga')));
	out.push(edge().write(path.join(dir, 'edge.tga')));
	out.push(badge().write(path.join(dir, 'badge.tga')));
	return out;
}

module.exports = { name: 'map', generate, GLYPHS, parsePath, glyphShape, FRAME, TEX };
