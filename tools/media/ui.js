'use strict';
// The UI's textures: white glyphs the addon tints at runtime (one per goal verb,
// plus the controls), a soft glow, a soft shadow for window edges, a filled
// circle, a solid white, and the addon logo. Everything is drawn here from
// signed distance shapes, so the art stays editable and owned by the project.
//
// Glyphs are designed on a 24-unit grid (stroke 2.25) and rendered at 32 px:
// the guide window shows them at 14-16 UI units, so 32 px stays crisp from UI
// scale 0.64 up to 2x without mipmaps.

const path = require('node:path');
const { Canvas, sdf } = require('../lib/tga');

const SIZE = 32;
const K = SIZE / 24;
const STROKE = 2.25;

// Grid units -> pixels.
const g = (v) => v * K;

const line = (ax, ay, bx, by, w = STROKE) => sdf.segment(g(ax), g(ay), g(bx), g(by), g(w) / 2);
const poly = (pts) => sdf.polygon(pts.map(([x, y]) => [g(x), g(y)]));
const dot = (cx, cy, r) => sdf.circle(g(cx), g(cy), g(r));
const ring = (cx, cy, r, w = STROKE) => sdf.ring(g(cx), g(cy), g(r), g(w));
const box = (cx, cy, hw, hh, r = 0) => sdf.box(g(cx), g(cy), g(hw), g(hh), g(r));
const polyline = (pts, w = STROKE) => sdf.union(...pts.slice(1).map((p, i) => line(pts[i][0], pts[i][1], p[0], p[1], w)));
// The grid point at radius r and angle deg (screen space) from (cx, cy).
const polar = (cx, cy, r, deg) => [cx + r * Math.cos((deg * Math.PI) / 180), cy + r * Math.sin((deg * Math.PI) / 180)];

// An arc of a ring with round caps. Angles in degrees, screen space (y down):
// 0 = right, 90 = down, -90 = up; drawn from a0 to a1 increasing.
function arc(cx, cy, r, a0, a1, w = STROKE) {
	const [px, py, pr, half] = [g(cx), g(cy), g(r), g(w) / 2];
	const t0 = (a0 * Math.PI) / 180;
	const t1 = (a1 * Math.PI) / 180;
	const e0 = [px + pr * Math.cos(t0), py + pr * Math.sin(t0)];
	const e1 = [px + pr * Math.cos(t1), py + pr * Math.sin(t1)];
	return (x, y) => {
		let a = Math.atan2(y - py, x - px);
		while (a < t0) a += Math.PI * 2;
		if (a <= t1) return Math.abs(Math.hypot(x - px, y - py) - pr) - half;
		return Math.min(Math.hypot(x - e0[0], y - e0[1]), Math.hypot(x - e1[0], y - e1[1])) - half;
	};
}

// Rotate a shape about a point (degrees, screen space).
function rotate(shape, deg, cx = 12, cy = 12) {
	const t = (-deg * Math.PI) / 180;
	const c = Math.cos(t), s = Math.sin(t);
	const [ox, oy] = [g(cx), g(cy)];
	return (x, y) => {
		const dx = x - ox, dy = y - oy;
		return shape(ox + dx * c - dy * s, oy + dx * s + dy * c);
	};
}

const { union, subtract } = sdf;

// A five-point star, outer radius r.
function star(cx, cy, r, inner = 0.45) {
	const pts = [];
	for (let i = 0; i < 10; i++) {
		const a = (-90 + i * 36) * (Math.PI / 180);
		const rr = i % 2 === 0 ? r : r * inner;
		pts.push([cx + rr * Math.cos(a), cy + rr * Math.sin(a)]);
	}
	return poly(pts);
}

// A bird in flight: two shallow wing arcs meeting at the body.
const bird = (cx, cy, s = 1) =>
	union(arc(cx - 4.6 * s, cy + 1.5 * s, 4.6 * s, -160, -20, 2.4), arc(cx + 4.6 * s, cy + 1.5 * s, 4.6 * s, -160, -20, 2.4));

const chevron = (deg) => rotate(polyline([[7, 9.5], [12, 14.5], [17, 9.5]], 2.5), deg);

const GLYPHS = {
	// Quest verbs follow the game's own vocabulary where it has one: "!" offers a
	// quest, "?" takes it back.
	'icon-accept': union(line(12, 4, 12, 13.6, 3.4), dot(12, 19.4, 2)),
	'icon-turnin': union(arc(12, 8.6, 4.6, -180, 50, 3), line(14.96, 12.12, 12, 14.6, 3), line(12, 14.6, 12, 15.1, 3), dot(12, 19.6, 2)),
	'icon-complete': union(line(6, 3.5, 6, 21, 2.4), poly([[6.5, 4], [19.5, 4], [16, 8.5], [19.5, 13], [6.5, 13]])),
	'icon-kill': union(
		poly([[20.5, 3.5], [20, 7.2], [10.6, 16.6], [7.4, 13.4], [16.8, 4]]),
		line(5.6, 11.6, 12.4, 18.4, 2.4),
		line(8.6, 15.4, 5.2, 18.8, 2.6),
		dot(4.3, 19.7, 1.9),
	),
	'icon-collect': union(
		subtract(dot(12, 15, 6.8), line(9, 9.2, 15, 9.2, 1)),
		poly([[9.6, 6.2], [14.4, 6.2], [15.2, 9.6], [8.8, 9.6]]),
		poly([[7, 3], [17, 3], [14.6, 6.6], [9.4, 6.6]]),
	),
	'icon-goto': subtract(union(dot(12, 9.5, 6.8), poly([[6.2, 13.1], [17.8, 13.1], [12, 21.8]])), dot(12, 9.5, 2.6)),
	'icon-talk': subtract(
		union(box(12, 10.5, 9, 6.8, 2.6), poly([[6.5, 15], [12, 15], [5.6, 21]])),
		union(dot(8, 10.5, 1.35), dot(12, 10.5, 1.35), dot(16, 10.5, 1.35)),
	),
	'icon-interact': poly([[6, 2.5], [6, 19.5], [10.2, 15.6], [13.2, 21.8], [16, 20.5], [13.1, 14.3], [18.6, 14.3]]),
	'icon-use': union(
		poly([[12, 2.5], [14, 10], [21.5, 12], [14, 14], [12, 21.5], [10, 14], [2.5, 12], [10, 10]]),
		poly([[19, 2.5], [19.8, 4.2], [21.5, 5], [19.8, 5.8], [19, 7.5], [18.2, 5.8], [16.5, 5], [18.2, 4.2]]),
	),
	'icon-sethome': subtract(union(poly([[12, 2.6], [22, 11.4], [2, 11.4]]), box(12, 15.6, 6.6, 5.6)), box(12, 18.2, 1.9, 3.1, 0.4)),
	'icon-hearth': subtract(box(12, 12.4, 7, 8.8, 6.2), union(arc(12, 12.4, 3.6, -200, 100, 1.8), dot(12, 12.4, 1))),
	'icon-getfp': union(bird(10.5, 13.5, 1), line(19, 2.8, 19, 9.2, 2.2), line(15.8, 6, 22.2, 6, 2.2)),
	'icon-fly': bird(12, 12.5, 1.15),
	// Boats, zeppelins and trams: a sailing ship (map pins for docks).
	'icon-boat': union(
		poly([[2.5, 15.4], [21.5, 15.4], [18.4, 20.4], [5.6, 20.4]]),
		line(12, 2.6, 12, 15, 1.8),
		poly([[13.4, 3.6], [20, 13.2], [13.4, 13.2]]),
		poly([[10.6, 5.4], [10.6, 13.2], [5, 13.2]]),
	),
	'icon-train': union(poly([[2.2, 5.6], [11, 7.4], [11, 20.6], [2.2, 18.8]]), poly([[21.8, 5.6], [13, 7.4], [13, 20.6], [21.8, 18.8]])),
	// Chokepoints a walk passes (route stops on the map): a gate with its
	// portcullis, a bridge over its arch, a cave mouth in a hill, a lift
	// between its up and down arrows, a pass between two cliffs.
	'icon-gate': union(
		line(5, 21, 5, 10.5), line(19, 21, 19, 10.5), arc(12, 10.5, 7, -180, 0),
		line(9.6, 8, 9.6, 21, 1.6), line(14.4, 8, 14.4, 21, 1.6), line(5, 14.4, 19, 14.4, 1.6),
	),
	'icon-bridge': union(line(2.5, 9.5, 21.5, 9.5, 2.6), arc(12, 20.5, 8.5, -180, 0), line(3.5, 9.5, 3.5, 20.5), line(20.5, 9.5, 20.5, 20.5)),
	'icon-cave': subtract(poly([[1.5, 20.5], [9.6, 4], [13.4, 9.4], [15.8, 6.8], [22.5, 20.5]]), union(dot(12, 20.5, 5), box(12, 21.5, 5, 1))),
	'icon-lift': union(line(4.5, 12, 19.5, 12, 2.6), poly([[12, 2.5], [17.5, 8.5], [6.5, 8.5]]), poly([[12, 21.5], [17.5, 15.5], [6.5, 15.5]])),
	'icon-pass': union(poly([[1.5, 21], [1.5, 4], [9.2, 9.4], [10.4, 21]]), poly([[22.5, 21], [22.5, 6], [15, 10.6], [13.6, 21]])),
	'icon-buy': union(
		polyline([[2.5, 4.5], [5.4, 4.5], [8, 15.6], [18.6, 15.6]], 2.2),
		poly([[6.4, 7], [21.4, 7], [19.4, 13.2], [7.8, 13.2]]),
		dot(9.2, 19.6, 1.9),
		dot(17.2, 19.6, 1.9),
	),
	'icon-vendor': union(
		subtract(dot(15, 9.4, 6.6), dot(9, 14.6, 8.4)),
		subtract(dot(9, 14.6, 6.6), ring(9, 14.6, 4.1, 1.3)),
	),
	'icon-level': union(polyline([[6, 12.5], [12, 6.5], [18, 12.5]], 2.6), polyline([[6, 18.5], [12, 12.5], [18, 18.5]], 2.6)),
	'icon-note': subtract(dot(12, 12, 9.5), union(line(12, 10.6, 12, 17, 2.5), dot(12, 7.1, 1.6))),
	// Professions: rising bars for a skill rank, a scroll for a recipe to
	// learn, an anvil for crafting.
	'icon-skill': union(box(5.5, 16.5, 2.3, 4.5, 0.8), box(12, 13.5, 2.3, 7.5, 0.8), box(18.5, 10, 2.3, 11, 0.8)),
	'icon-learn': union(
		subtract(box(12, 12, 6.6, 7.4, 0.6), union(line(8.8, 9.6, 15.2, 9.6, 1.3), line(8.8, 12.6, 15.2, 12.6, 1.3), line(8.8, 15.6, 13, 15.6, 1.3))),
		box(12, 3.6, 8.6, 1.9, 1.9),
		box(12, 20.4, 8.6, 1.9, 1.9),
	),
	'icon-craft': union(
		poly([[2.5, 6], [16.5, 6], [16.5, 7.4], [21.5, 7.4], [18, 11.6], [16, 11.6], [14.2, 14.2], [9.8, 14.2], [8, 11.6], [6, 11.6]]),
		box(12, 16.4, 2.6, 2.4),
		box(12, 19.8, 6.2, 1.6, 0.6),
	),
	// Reputation: a heraldic shield with a chevron cut through it.
	'icon-rep': subtract(
		union(box(12, 7.6, 8, 4.6, 1.2), poly([[4, 9], [20, 9], [19.2, 14.2], [12, 21.8], [4.8, 14.2]])),
		polyline([[7.4, 11.6], [12, 15.2], [16.6, 11.6]], 2),
	),
	// Exploration: a compass rose.
	'icon-explore': union(
		ring(12, 12, 9, 1.8),
		subtract(poly([[12, 4.6], [15, 12], [12, 19.4], [9, 12]]), dot(12, 12, 1.1)),
	),
	// A dungeon or raid entrance: an archway open at the ground, a portal
	// spark inside it.
	'icon-dungeon': union(
		subtract(union(box(12, 15.6, 7.6, 6), dot(12, 9.6, 7.6)), union(box(12, 17.4, 4.4, 4.6), dot(12, 12.8, 4.4))),
		poly([[12, 10.4], [12.9, 13.2], [15.4, 14], [12.9, 14.8], [12, 17.6], [11.1, 14.8], [8.6, 14], [11.1, 13.2]]),
	),
	// Options in the hub rail: three tracks with their knobs (not the gear,
	// which is the Gear section's).
	sliders: union(
		line(4, 6.5, 20, 6.5, 1.9), line(4, 12, 20, 12, 1.9), line(4, 17.5, 20, 17.5, 1.9),
		dot(8.5, 6.5, 2.7), dot(15.5, 12, 2.7), dot(10.5, 17.5, 2.7),
	),
	// Achievement: a trophy cup.
	'icon-achieve': union(
		subtract(union(box(12, 5.4, 6.4, 1.9), dot(12, 7.6, 6.4)), box(12, 1.4, 7, 3)),
		arc(5.4, 8.4, 2.6, 90, 300, 1.8),
		arc(18.6, 8.4, 2.6, -120, 90, 1.8),
		box(12, 15.2, 1.4, 2.4),
		box(12, 19.6, 5.4, 1.8, 0.6),
	),
	// Guides, the hub rail's own section: an open book, its pages lined.
	guides: subtract(
		union(
			poly([[11.1, 7.2], [11.1, 20.6], [7, 18.8], [2.2, 19.4], [2.2, 5.4], [7, 4.8]]),
			poly([[12.9, 7.2], [12.9, 20.6], [17, 18.8], [21.8, 19.4], [21.8, 5.4], [17, 4.8]]),
		),
		union(line(4.8, 9.8, 8.8, 9.6, 1.2), line(4.8, 13.4, 8.8, 13.2, 1.2), line(15.2, 9.6, 19.2, 9.8, 1.2), line(15.2, 13.2, 19.2, 13.4, 1.2)),
	),
	// Mounts: a horseshoe, toe up, the heels cut flat and turned in, nailed.
	'icon-mount': subtract(
		ring(12, 12.4, 7, 4),
		union(
			poly([[12, 12.4], polar(12, 12.4, 20, 58), polar(12, 12.4, 20, 122)]),
			...[160, 212, 328, 20].map((a) => dot(...polar(12, 12.4, 7, a), 0.8)),
		),
	),
	// Treasure: a chest, its arched lid over the body, the clasp on the seam.
	'icon-treasure': union(
		subtract(
			union(sdf.intersect(dot(12, 18.6, 14), box(12, 8.4, 9, 4)), box(12, 16.2, 9, 4.8, 1)),
			union(line(2, 11.6, 22, 11.6, 1.3), box(12, 12.4, 2.6, 3.2, 0.8)),
		),
		box(12, 12.6, 1.4, 2, 0.4),
	),

	check: polyline([[5, 12.6], [10, 17.4], [19.2, 7]], 3),
	cross: union(line(6.5, 6.5, 17.5, 17.5, 2.8), line(17.5, 6.5, 6.5, 17.5, 2.8)),
	close: union(line(7.5, 7.5, 16.5, 16.5, 2.1), line(16.5, 7.5, 7.5, 16.5, 2.1)),
	'chevron-down': chevron(0),
	'chevron-up': chevron(180),
	'chevron-left': chevron(90),
	'chevron-right': chevron(-90),
	gear: subtract(
		union(dot(12, 12, 6.6), ...[0, 45, 90, 135].map((a) => rotate(box(12, 12, 1.9, 9.4, 0.6), a))),
		dot(12, 12, 2.7),
	),
	search: union(ring(10.5, 10.5, 6, 2.4), line(15, 15, 20.2, 20.2, 2.8)),
	lock: union(box(12, 15.4, 7.2, 5.6, 1.4), arc(12, 9, 4.2, -180, 0, 2.3), line(7.8, 9, 7.8, 10.4, 2.3), line(16.2, 9, 16.2, 10.4, 2.3)),
	menu: union(dot(5.5, 12, 2), dot(12, 12, 2), dot(18.5, 12, 2)),
	skip: union(poly([[4.5, 5.5], [15, 12], [4.5, 18.5]]), line(18.5, 6, 18.5, 18, 2.6)),
	// Report a problem: a beetle from above, its shell split down the back,
	// the head apart from it, three legs a side.
	bug: union(
		subtract(box(12, 14.4, 5.6, 6.6, 5.6), line(12, 11.4, 12, 22, 1.3)),
		sdf.intersect(dot(12, 6.6, 3.2), box(12, 4.6, 4, 2)),
		line(7.2, 11.6, 3.4, 9.4, 2), line(6.8, 15, 2.8, 15, 2), line(7.2, 18.4, 3.6, 20.6, 2),
		line(16.8, 11.6, 20.6, 9.4, 2), line(17.2, 15, 21.2, 15, 2), line(16.8, 18.4, 20.4, 20.6, 2),
	),
	star: star(12, 12.8, 10),
	resize: union(line(20, 9, 9, 20, 1.8), line(20, 15, 15, 20, 1.8)),
	compact: union(line(5, 8, 19, 8, 2.4), line(5, 12, 19, 12, 2.4), line(5, 16, 13, 16, 2.4)),
	reset: union(arc(12, 12.5, 7.2, -150, 160, 2.4), poly([[2.2, 4.4], [9.4, 6.2], [4.4, 11.4]])),
	circle: (x, y) => Math.hypot(x - SIZE / 2, y - SIZE / 2) - (SIZE / 2 - 1),
	// Options pages and shell controls.
	window: subtract(box(12, 12, 9.4, 8.4, 2), union(box(12, 13.9, 7.2, 4.3, 0.6), dot(6.6, 6.4, 0.9), dot(9.4, 6.4, 0.9))),
	bolt: poly([[13.6, 2.2], [5.2, 13.6], [11, 13.6], [9.8, 21.8], [18.8, 9.6], [12.8, 9.6]]),
	palette: union(ring(12, 12, 8.4, 2.2), (x, y) => Math.max(Math.hypot(x - g(12), y - g(12)) - g(8.4), g(12) - x)),
	record: union(ring(12, 12, 9, 2), dot(12, 12, 4.4)),
	info: subtract(dot(12, 12, 9.5), union(line(12, 10.6, 12, 17, 2.5), dot(12, 7.1, 1.6))),
	plus: union(line(12, 5, 12, 19, 2.4), line(5, 12, 19, 12, 2.4)),
	reload: union(arc(12, 12.5, 7.2, -60, 250, 2.4), poly([[19.6, 2.6], [20.4, 10], [13.2, 8.2]])),
	layers: union(
		poly([[12, 3], [21, 8], [12, 13], [3, 8]]),
		polyline([[3.6, 12.2], [12, 16.8], [20.4, 12.2]], 2.1),
		polyline([[3.6, 16.2], [12, 20.8], [20.4, 16.2]], 2.1),
	),
	// Integrations (other addons Polestar works with): a plug, two prongs
	// over its body, the cable out of the bottom.
	plug: union(
		line(9, 2.8, 9, 7.6, 2.2), line(15, 2.8, 15, 7.6, 2.2),
		box(12, 11.2, 6.6, 3.8, 1.4),
		poly([[8.4, 14.4], [15.6, 14.4], [13.6, 18], [10.4, 18]]),
		line(12, 17.4, 12, 21.4, 2.25),
	),
	// Gamepad (UI/Gamepad.lua): the options page's controller, and the
	// PlayStation face buttons drawn as their shapes (Xbox's are letters, set
	// as text). The D-pad uses the chevrons.
	gamepad: subtract(
		union(
			box(12, 10.6, 9.6, 4.8, 3.4),
			rotate(box(5.6, 15.4, 2.8, 4.6, 2.6), 18, 5.6, 15.4),
			rotate(box(18.4, 15.4, 2.8, 4.6, 2.6), -18, 18.4, 15.4),
		),
		union(box(7.2, 10.6, 2.9, 0.8), box(7.2, 10.6, 0.8, 2.9), dot(16.2, 9, 1.15), dot(18.4, 11.4, 1.15)),
	),
	'pad-cross': union(line(6.5, 6.5, 17.5, 17.5, 2.6), line(17.5, 6.5, 6.5, 17.5, 2.6)),
	'pad-circle': ring(12, 12, 6.6, 2.6),
	'pad-square': subtract(box(12, 12, 6.8, 6.8), box(12, 12, 4.2, 4.2)),
	'pad-triangle': polyline([[12, 4.6], [19.4, 17.6], [4.6, 17.6], [12, 4.6]], 2.6),
};

function glyph(shape) {
	return new Canvas(SIZE, SIZE).fill(shape, [1, 1, 1, 1]);
}

// The Discord mark, only ever beside the link to the Polestar Discord: the
// symbol from Discord's brand kit (discord.com/branding) exactly as it is
// published, scaled whole to 21 grid units wide and centred, filled white
// and tinted Discord's Blurple at runtime (the Theme token `discord`). It is
// Discord's trademark, the one mark Polestar ships that it did not draw
// (THIRD_PARTY.md).
const DISCORD_SYMBOL = 'M40.575 0C39.9562 1.09866 39.4006 2.2352 38.8954 3.397C34.0967 2.67719 29.2096 2.67719 24.3982 3.397C23.9057 2.2352 23.3374 1.09866 22.7186 0C18.2104 0.770324 13.8157 2.12155 9.64839 4.02841C1.38951 16.2652 -0.845688 28.1863 0.265599 39.9432C5.10222 43.517 10.5197 46.2447 16.2909 47.9874C17.5916 46.2447 18.7407 44.3883 19.7257 42.4562C17.8568 41.7616 16.0509 40.8903 14.3208 39.88C14.7755 39.5517 15.2175 39.2107 15.6468 38.8824C25.7873 43.6559 37.5316 43.6559 47.6847 38.8824C48.1141 39.236 48.5561 39.577 49.0107 39.88C47.2806 40.9029 45.4748 41.7616 43.5931 42.4688C44.5781 44.4009 45.7273 46.2573 47.028 48C52.7991 46.2573 58.2167 43.5422 63.0533 39.9684C64.3666 26.3299 60.8055 14.5099 53.6452 4.04104C49.4905 2.13418 45.0959 0.782952 40.5876 0.0252565L40.575 0ZM21.1401 32.7072C18.0209 32.7072 15.4321 29.8785 15.4321 26.3804C15.4321 22.8824 17.9199 20.041 21.1275 20.041C24.3351 20.041 26.886 22.895 26.8354 26.3804C26.7849 29.8658 24.3224 32.7072 21.1401 32.7072ZM42.1788 32.7072C39.047 32.7072 36.4834 29.8785 36.4834 26.3804C36.4834 22.8824 38.9712 20.041 42.1788 20.041C45.3864 20.041 47.9246 22.895 47.8741 26.3804C47.8236 29.8658 45.3611 32.7072 42.1788 32.7072Z';
const DISCORD_W = 64, DISCORD_H = 48; // the symbol's viewBox

// An SVG path of absolute M, L, C and Z commands -> its subpaths as point
// lists, each cubic flattened into `steps` segments. A point repeating the
// one before it (or a closing point on the first) is dropped: a zero-length
// edge has no direction, and the polygon closes itself.
function svgSubpaths(d, steps = 16) {
	const tokens = d.match(/[MLCZ]|-?(?:\d+\.?\d*|\.\d+)(?:e-?\d+)?/gi);
	const out = [];
	let pts = null, i = 0, cmd = null;
	const num = () => Number(tokens[i++]);
	const add = (x, y) => {
		const last = pts[pts.length - 1];
		if (!last || last[0] !== x || last[1] !== y) pts.push([x, y]);
	};
	while (i < tokens.length) {
		if (/^[MLCZ]$/i.test(tokens[i])) cmd = tokens[i++].toUpperCase();
		if (cmd === 'M') {
			pts = [];
			out.push(pts);
			add(num(), num());
			cmd = 'L';
		} else if (cmd === 'L') {
			add(num(), num());
		} else if (cmd === 'C') {
			const [x0, y0] = pts[pts.length - 1];
			const x1 = num(), y1 = num(), x2 = num(), y2 = num(), x3 = num(), y3 = num();
			for (let k = 1; k <= steps; k++) {
				const t = k / steps, u = 1 - t;
				add(u * u * u * x0 + 3 * u * u * t * x1 + 3 * u * t * t * x2 + t * t * t * x3, u * u * u * y0 + 3 * u * u * t * y1 + 3 * u * t * t * y2 + t * t * t * y3);
			}
		} else if (cmd === 'Z') {
			const [first, last] = [pts[0], pts[pts.length - 1]];
			if (pts.length > 1 && first[0] === last[0] && first[1] === last[1]) pts.pop();
			cmd = null;
		} else {
			throw new Error(`svgSubpaths: unsupported path data at "${tokens[i]}"`);
		}
	}
	return out;
}

// The symbol's first subpath is its outline, the other two its eyes.
function discordMark() {
	const s = 21 / DISCORD_W;
	const ox = 12 - (DISCORD_W * s) / 2, oy = 12 - (DISCORD_H * s) / 2;
	const [outline, ...eyes] = svgSubpaths(DISCORD_SYMBOL).map((pts) => poly(pts.map(([x, y]) => [ox + x * s, oy + y * s])));
	return subtract(outline, union(...eyes));
}

// A soft round glow: opaque-ish centre falling to nothing at the edge.
function glow() {
	return new Canvas(64, 64).fill(sdf.circle(32, 32, 6), [1, 1, 1, 1], { feather: 50 });
}

// A soft box for nine-slicing window shadows: the shape occupies the middle
// 24 px and fades to zero 16 px out. Slice at 20 px from each edge.
function shadow() {
	return new Canvas(64, 64).fill(sdf.box(32, 32, 12, 12, 2), [1, 1, 1, 1], { feather: 22 });
}

function white() {
	return new Canvas(8, 8).fill(() => -1, [1, 1, 1, 1]);
}

// ---------------------------------------------------------------------------
// Identity. The Polestar emblem is a four-point guiding star set in a fine
// ring: long north/south rays that break through the ring, short east/west
// rays inside it. Provenance: drawn here, procedurally, licence-free.
// ---------------------------------------------------------------------------

const GOLD = [0.9, 0.73, 0.4];
const GOLD_LIGHT = [1, 0.93, 0.76];
const NAVY = [0.039, 0.051, 0.086];

// A four-point star: tips at (cx, cy -/+ ry) and (cx -/+ rx, cy), waist w.
function guideStar(cx, cy, rx, ry, w) {
	return sdf.polygon([[cx, cy - ry], [cx + w, cy - w], [cx + rx, cy], [cx + w, cy + w], [cx, cy + ry], [cx - w, cy + w], [cx - rx, cy], [cx - w, cy - w]]);
}

// The emblem on a canvas of side n (white, tintable).
function emblemShape(n) {
	const c = n / 2;
	const s = n / 128;
	const ring = sdf.subtract(sdf.ring(c, c, 44 * s, 2.6 * s), sdf.box(c, c, 7 * s, 60 * s));
	return sdf.union(ring, guideStar(c, c, 30 * s, 60 * s, 7.5 * s));
}

function emblem() {
	return new Canvas(128, 128).fill(emblemShape(128), [1, 1, 1, 1]);
}

// The same emblem as fine linework, for faint watermarks behind content:
// a hollow star and a double ring, so it reads as an engraving at 3% alpha.
function watermark() {
	const n = 256, c = 128;
	const star = guideStar(c, c, 62, 122, 15);
	const hollow = (x, y) => Math.abs(star(x, y)) - 1.1;
	const rings = sdf.union(sdf.ring(c, c, 90, 2), sdf.ring(c, c, 98, 1));
	const cut = sdf.box(c, c, 16, 124);
	return new Canvas(n, n).fill(sdf.union(hollow, sdf.subtract(rings, cut)), [1, 1, 1, 1]);
}

// The addon logo (TOC IconTexture): the gold emblem on a night tile.
function logo() {
	const c = new Canvas(64, 64);
	const tile = sdf.box(32, 32, 30, 30, 12);
	c.fill(tile, [...NAVY, 1]);
	c.fill(sdf.intersect(tile, sdf.circle(32, 32, 3)), [...GOLD, 0.35], { feather: 44 });
	c.fill(sdf.intersect(tile, emblemShape(64)), [...GOLD, 1]);
	c.fill(guideStar(32, 32, 5, 9, 1.4), [...GOLD_LIGHT, 1]);
	c.fill(sdf.ring(32, 32, 29.5, 1), [1, 1, 1, 0.07]);
	return c;
}

// Deterministic noise, so regenerating never churns the committed files.
function prng(seed) {
	let a = seed >>> 0;
	return () => {
		a = (a + 0x6d2b79f5) >>> 0;
		let t = a;
		t = Math.imul(t ^ (t >>> 15), t | 1);
		t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
		return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
	};
}

// The night-sky header band, 1024x128, drawn at 1:1 (the UI crops it with
// texcoords, never stretches it), as two layers so every colour scheme gets
// its own sky over its own ground (Polestar.Theme.Band):
// - band: the sky as a white alpha mask, opaque at the top and gone by 108px,
//   with fine grain; tinted with the scheme's sky colour over the window
//   ground, so it always fades into whatever ground sits under it. The curve
//   holds Night's old baked band (navy top, a darker middle, then the ground).
// - band-stars: scattered stars that thin out toward the bottom, one faint
//   constellation in the right third, clear of the title, and a faint lift
//   toward the upper right where it sits; white, tinted by the star token.
const SKY_H = 108;
function band() {
	const W = 1024, H = 128;
	const c = new Canvas(W, H);
	const rnd = prng(0x10de57a2);
	const px = c.px;
	const mid = 0.25; // how much sky is left halfway down
	for (let y = 0; y < H; y++) {
		const t = Math.min(1, y / SKY_H);
		const e = t * t * (3 - 2 * t);
		const w = e < 0.5 ? 1 - (1 - mid) * (e * 2) : mid * (1 - (e - 0.5) * 2);
		for (let x = 0; x < W; x++) {
			const i = (y * W + x) * 4;
			px[i] = px[i + 1] = px[i + 2] = 1;
			px[i + 3] = Math.max(0, Math.min(1, w * (1 + (rnd() - 0.5) * 0.12)));
		}
	}
	return c;
}

function bandStars() {
	const W = 1024, H = 128;
	const c = new Canvas(W, H);
	const px = c.px;
	for (let y = 0; y < H; y++) {
		const t = Math.min(1, y / SKY_H);
		const e = t * t * (3 - 2 * t);
		for (let x = 0; x < W; x++) {
			const glow = Math.max(0, 1 - Math.hypot((x - 760) / 520, (y - 10) / 120)) * 0.04 * (1 - e);
			const i = (y * W + x) * 4;
			px[i] = 0.86; px[i + 1] = 0.9; px[i + 2] = 1;
			px[i + 3] = glow;
		}
	}
	const stars = prng(0x5ea5);
	for (let n = 0; n < 230; n++) {
		const x = stars() * W, yy = Math.pow(stars(), 1.6) * 100;
		const b = stars();
		const r = 0.35 + b * b * 0.75;
		const a = (0.18 + b * 0.6) * (1 - yy / 125);
		c.fill(sdf.circle(x, yy, r), [0.86, 0.9, 1, a]);
		if (b > 0.93) c.fill(sdf.circle(x, yy, 0.5), [0.86, 0.9, 1, a * 0.35], { feather: 7 });
	}
	const pts = [[668, 30], [712, 18], [758, 38], [806, 28], [842, 52], [902, 44], [934, 70]];
	for (let i = 1; i < pts.length; i++) {
		c.fill(sdf.segment(pts[i - 1][0], pts[i - 1][1], pts[i][0], pts[i][1], 0.32), [0.8, 0.86, 1, 0.16]);
	}
	for (const [x, y] of pts) {
		c.fill(sdf.circle(x, y, 0.5), [0.95, 0.97, 1, 0.5], { feather: 6 });
		c.fill(sdf.circle(x, y, 1.05), [0.97, 0.98, 1, 0.95]);
	}
	return c;
}

// ---------------------------------------------------------------------------
// The wordmark: "POLESTAR" engraved in Cinzel (The Cinzel Project Authors,
// SIL Open Font License 1.1; tools/media/fonts/). Only these rendered images
// ship in the addon, not the font. Outlines come straight from the font's
// glyf table (its Regular master), filled with the non-zero rule at 4x4
// supersampling and grown by `bold` px on every side, so the hairlines and
// serifs hold at sidebar size instead of dissolving into the ground.
//
// Two cuts, each drawn 1:1 for where it shows, the ink starting at x 1 and
// centred on the canvas's middle line, so the UI places them by their box:
// - wordmark:       caps 22px (About, the game's Settings canvas), 256x32
// - wordmark-small: caps 15px (the shell sidebar), 256x32
// ---------------------------------------------------------------------------

function flatten(contours, scale, ox, oy) {
	const edges = [];
	for (const contour of contours) {
		const pts = contour.map((p) => ({ x: ox + p.x * scale, y: oy - p.y * scale, on: p.on }));
		if (pts.length < 2) continue;
		// Expand implied on-curve points between consecutive off-curve ones.
		const seq = [];
		for (let i = 0; i < pts.length; i++) {
			const p = pts[i], q = pts[(i + 1) % pts.length];
			seq.push(p);
			if (!p.on && !q.on) seq.push({ x: (p.x + q.x) / 2, y: (p.y + q.y) / 2, on: true });
		}
		const s = seq.findIndex((p) => p.on);
		if (s < 0) continue;
		const ring = seq.slice(s).concat(seq.slice(0, s));
		ring.push(ring[0]);
		const poly = [ring[0]];
		for (let i = 1; i < ring.length; i++) {
			const p = ring[i];
			if (p.on) poly.push(p);
			else {
				const a = poly[poly.length - 1], b = ring[i + 1];
				for (let k = 1; k <= 8; k++) {
					const t = k / 8, u = 1 - t;
					poly.push({ x: u * u * a.x + 2 * u * t * p.x + t * t * b.x, y: u * u * a.y + 2 * u * t * p.y + t * t * b.y });
				}
				i++;
			}
		}
		for (let i = 1; i < poly.length; i++) edges.push([poly[i - 1].x, poly[i - 1].y, poly[i].x, poly[i].y]);
	}
	return edges;
}

function winding(edges, x, y) {
	let w = 0;
	for (const [x0, y0, x1, y1] of edges) {
		if (y0 <= y) {
			if (y1 > y && (x1 - x0) * (y - y0) - (x - x0) * (y1 - y0) > 0) w++;
		} else if (y1 <= y && (x1 - x0) * (y - y0) - (x - x0) * (y1 - y0) < 0) w--;
	}
	return w;
}

// Is (x, y) within r of any edge?
function nearEdge(edges, x, y, r) {
	const r2 = r * r;
	for (const [x0, y0, x1, y1] of edges) {
		const dx = x1 - x0, dy = y1 - y0;
		const len = dx * dx + dy * dy;
		const t = len ? Math.max(0, Math.min(1, ((x - x0) * dx + (y - y0) * dy) / len)) : 0;
		const ex = x0 + t * dx - x, ey = y0 + t * dy - y;
		if (ex * ex + ey * ey <= r2) return true;
	}
	return false;
}

function engrave({ capH, bold, tracking, W = 256, H = 32 }) {
	const { Font } = require('../preview/font');
	const font = new Font(path.join(__dirname, 'fonts', 'Cinzel-Variable.ttf'));
	const text = 'POLESTAR';
	const scale = capH / 700; // Cinzel caps are 700 units tall
	const track = tracking * capH;
	let x = 1 + bold;
	const base = (H + capH) / 2;
	const edges = [];
	for (const ch of text) {
		const gid = font.glyphId(ch.codePointAt(0));
		edges.push(...flatten(font.contours(gid), scale, x, base));
		x += font.advance(gid) * scale + track;
	}
	const c = new Canvas(W, H);
	const S = 4;
	const reach = bold + 1;
	for (let py = 0; py < H; py++) {
		const row = edges.filter(([, y0, , y1]) => Math.max(y0, y1) >= py - reach && Math.min(y0, y1) <= py + 1 + reach);
		if (!row.length) continue;
		for (let pxl = 0; pxl < W; pxl++) {
			let hit = 0;
			for (let sy = 0; sy < S; sy++) {
				for (let sx = 0; sx < S; sx++) {
					const qx = pxl + (sx + 0.5) / S, qy = py + (sy + 0.5) / S;
					if (winding(row, qx, qy) !== 0 || (bold > 0 && nearEdge(row, qx, qy, bold))) hit++;
				}
			}
			if (!hit) continue;
			const i = (py * W + pxl) * 4;
			c.px[i] = 1;
			c.px[i + 1] = 1;
			c.px[i + 2] = 1;
			c.px[i + 3] = hit / (S * S);
		}
	}
	return c;
}

const wordmark = () => engrave({ capH: 22, bold: 0.8, tracking: 0.15 });
const wordmarkSmall = () => engrave({ capH: 15, bold: 0.6, tracking: 0.16 });

function generate(addonRoot) {
	const dir = path.join(addonRoot, 'Media', 'UI');
	const written = [];
	for (const [name, shape] of Object.entries(GLYPHS)) written.push(glyph(shape).write(path.join(dir, `${name}.tga`)));
	written.push(glyph(discordMark()).write(path.join(dir, 'discord.tga')));
	written.push(glow().write(path.join(dir, 'glow.tga')));
	written.push(shadow().write(path.join(dir, 'shadow.tga')));
	written.push(white().write(path.join(dir, 'white.tga')));
	written.push(logo().write(path.join(dir, 'logo.tga')));
	written.push(emblem().write(path.join(dir, 'emblem.tga')));
	written.push(watermark().write(path.join(dir, 'watermark.tga')));
	written.push(band().write(path.join(dir, 'band.tga')));
	written.push(bandStars().write(path.join(dir, 'band-stars.tga')));
	written.push(wordmark().write(path.join(dir, 'wordmark.tga')));
	written.push(wordmarkSmall().write(path.join(dir, 'wordmark-small.tga')));
	return written;
}

// GLYPHS (24-unit shapes in SIZE-pixel space), emblemShape, band and
// bandStars are also read by the route planner, which renders the same art
// at its own sizes for the browser (tools/planner/glyphs.js).
module.exports = { name: 'ui', generate, GLYPHS, SIZE, emblemShape, band, bandStars };
