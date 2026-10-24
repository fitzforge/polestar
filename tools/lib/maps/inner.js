'use strict';
// Which of two maps holding the same place the player is in (#384): a city
// over the zone around it. Shared by the Codex and the sim world.

// A frame as a world rectangle (frames are written corner to corner, either
// way round).
function boxOf(fr) {
	return fr && {
		c: fr.c,
		x0: Math.min(fr.left, fr.right), x1: Math.max(fr.left, fr.right),
		y0: Math.min(fr.top, fr.bottom), y1: Math.max(fr.top, fr.bottom),
	};
}

// Box `b` lies wholly within `a` and is smaller: its map is inside the other's
// (Darnassus within Teldrassil, a zone within a continent). Frames of
// neighbouring zones overlap without either holding the other, so this is not
// a size test.
function within(b, a) {
	if (!(b && a && b.c === a.c)) return false;
	if (!(b.x0 >= a.x0 && b.x1 <= a.x1 && b.y0 >= a.y0 && b.y1 <= a.y1)) return false;
	return (b.x1 - b.x0) * (b.y1 - b.y0) < (a.x1 - a.x0) * (a.y1 - a.y0);
}

// A map you are inside rather than crossing: a capital or a battleground.
// Their frames stand well apart from the zones' — Ironforge 791 yd on its
// long side, Undercity 959, Thunder Bluff 1044, Darnassus 1058, Warsong Gulch
// 1146, Stormwind City 1344 and Orgrimmar 1403, then nothing until Arathi
// Basin at 1756 and Redridge Mountains at 2171. (journal.js tells continents
// from zones by size the same way.)
const INNER_MAX = 1500; // yards on the long side
function enclosed(b) {
	return !!b && Math.max(b.x1 - b.x0, b.y1 - b.y0) <= INNER_MAX;
}

// Of two maps holding the same place, `b` is the one the player is in: an
// enclosed map beats the open zone around it, and otherwise the map whose
// frame lies inside the other's.
function moreInner(b, a) {
	if (enclosed(b) && !enclosed(a)) return true;
	return within(b, a);
}

module.exports = { INNER_MAX, boxOf, within, enclosed, moreInner };
