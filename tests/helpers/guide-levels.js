'use strict';
// Our guides' headers as the level checks read them (tests/guides-levels.test.js, guides-reported.test.js): each
// guide's levels for each faction it serves (`levels <min>-<max>`, or `levels <min>-<max> Alliance|Horde` on a guide
// both factions play: docs/GUIDE_FORMAT.md, "Header"), its `next` guides and its category.

const fs = require('node:fs');
const path = require('node:path');
const { parseGuide } = require('../../tools/lib/dsl/parse');
const { Diagnostics } = require('../../tools/lib/dsl/diag');

const FACTIONS = ['Alliance', 'Horde'];

// dir: a pack folder (guides/) -> { [id]: { file, faction, category, next: [id, ...], min, max, levels: { Alliance, Horde } } }
// for every guide under dir/forever. min/max: the span of its ranges; levels[f]: { min, max } for a faction it
// serves (both without a `faction` header), absent for one it does not.
function guideHeaders(dir) {
	const walk = (d) => fs.readdirSync(d, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(d, e.name)) : e.name.endsWith('.guide') ? [path.join(d, e.name)] : []));
	const out = {};
	for (const full of walk(path.join(dir, 'forever'))) {
		const file = path.relative(dir, full).split(path.sep).join('/');
		const ast = parseGuide(fs.readFileSync(full, 'utf8'), file, new Diagnostics());
		if (!ast || !ast.id) continue;
		const h = ast.header;
		const levels = {};
		for (const f of FACTIONS) {
			const r = (!h.faction || h.faction === f) && ((h.factionLevels && h.factionLevels[f]) || h.levels);
			if (r) levels[f] = { min: r.min, max: r.max };
		}
		const ranges = Object.values(levels);
		if (!ranges.length) continue;
		out[ast.id] = {
			file,
			faction: h.faction,
			category: h.category || 'Leveling',
			next: h.next || [],
			min: Math.min(...ranges.map((r) => r.min)),
			max: Math.max(...ranges.map((r) => r.max)),
			levels,
		};
	}
	return out;
}

module.exports = { guideHeaders, FACTIONS };
