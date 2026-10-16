'use strict';
// Zone crossings from Carbonite (github.com/IrcDirk/Carbonite-Classic,
// GPL-3.0; released under the GPL by Carbon Based Creations, LLC), its
// Classic Era data file Carbonite/Data/classic/ZoneConnections.lua, into a
// crossings file (crossings.js, schema 1) that `travel build` ships in
// TravelData.lua.
//
//   const { parseZoneConnections, carboniteCrossings } = require('tools/lib/travel/carbonite');
//   const doc = carboniteCrossings(text, frames, { source, radius });   // throws when nothing parses
//
// Each entry is "flags|kind|name1|uiMap1|x1|y1|name2|uiMap2|x2|y2" (Carbonite's
// MapEngine.lua reads it the same way): flags bit 1 joins both ways, kind 1 is
// a walk between two zones of one continent; the other kinds (0, 2, 3, 5:
// portals, boats, zeppelins, the tram) are TravelData's own transports and are
// left out. Map percent of the Classic Era client maps, as our crossings file.
// Carbonite gives no arrival radius: RADIUS yards (decided here, the radius
// most crossings in a hand-made set use).

const RADIUS = 30;
const WALK = 1;

// Lua source -> [{ flags, kind, a: { map, x, y }, b: { map, x, y } }].
function parseZoneConnections(text) {
	const out = [];
	const re = /^\s*"([^\n]*?)",?\s*(?:--.*)?$/gm;
	let m;
	while ((m = re.exec(text))) {
		// Localised names are concatenated in (.."|"..L["..."].."|"..): only the numbers matter.
		const parts = m[1].replace(/"\s*\.\.\s*L\["[^"]*"\]\s*\.\.\s*"/g, '').split('|');
		if (parts.length !== 10) continue;
		const n = (i) => Number(parts[i]);
		const e = { flags: n(0), kind: n(1), a: { map: n(3), x: n(4), y: n(5) }, b: { map: n(7), x: n(8), y: n(9) } };
		if ([e.flags, e.kind, e.a.map, e.a.x, e.a.y, e.b.map, e.b.x, e.b.y].every(Number.isFinite)) out.push(e);
	}
	return out;
}

const slug = (s) => String(s).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');

// Lua source -> a crossings file document: the walks between zones, two-way
// unless flags bit 1 is clear, ids "carbonite-<zone>--<zone>" (-2, -3 ... for
// a second point on the same border).
function carboniteCrossings(text, frames, { source, radius = RADIUS } = {}) {
	const walks = parseZoneConnections(text).filter((e) => e.kind === WALK && (e.a.x !== 0 || e.a.y !== 0));
	if (!walks.length) throw new Error('no walking zone connections in the file (expected "7|1|...|uiMap|x|y|...|uiMap|x|y" entries)');
	const seen = new Map();
	const crossings = walks.map((e) => {
		const base = `carbonite-${slug(frames.name(e.a.map) || e.a.map)}--${slug(frames.name(e.b.map) || e.b.map)}`;
		const k = (seen.get(base) || 0) + 1;
		seen.set(base, k);
		const end = (p) => ({ map: p.map, x: p.x, y: p.y, radius });
		const c = { id: k === 1 ? base : `${base}-${k}`, a: end(e.a), b: end(e.b) };
		if ((e.flags & 1) === 0) c.oneWay = true;
		return c;
	});
	return { schema: 1, frame: 'e', source, crossings };
}

module.exports = { parseZoneConnections, carboniteCrossings, RADIUS };
