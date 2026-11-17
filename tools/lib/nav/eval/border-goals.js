'use strict';
// The border sweep's goals (rust/crates/forge-addontest/tests/addontest/nav-e2e.rs border_sweep, #1543, #2048):
//   node tools/lib/nav/eval/border-goals.js <repo> <out.json> [dist=250]
// every located goal of a leveling guide (Polestar_Guides*/Guides.lua, both factions; one per faction within 20 yd),
// with its guide's faction and minLevel and the 8 points dist yd round it: the test takes the first in another zone
// on the walking maps' ground as the start.
const fs = require('node:fs');
const path = require('node:path');
const tree = path.resolve(process.argv[2]);
const out = process.argv[3];
const DIST = +(process.argv[4] || 250);
const { Geo } = require(path.join(tree, 'tools/lib/planner/geo.js'));
const D = path.join(tree, 'data/forever');
const zones = JSON.parse(fs.readFileSync(path.join(D, 'zones.json')));
const geo = new Geo(JSON.parse(fs.readFileSync(path.join(D, 'map-frames.json'))), zones);
const starts = [];
const seen = new Set();
for (const d of fs.readdirSync(path.join(tree, 'addon')).sort()) {
	const f = path.join(tree, 'addon', d, 'Guides.lua');
	if (!d.startsWith('Polestar_Guides') || !fs.existsSync(f)) continue;
	for (const block of fs.readFileSync(f, 'utf8').split('\n-- Source: ').slice(1)) {
		if (!/category = "Leveling"/.test(block)) continue;
		const id = block.slice(0, block.indexOf('\n'));
		const faction = (block.match(/faction = "(\w+)"/) || [])[1];
		const level = +((block.match(/minLevel = (\d+)/) || [])[1] || 1);
		const factions = faction === 'Alliance' || faction === 'Horde' ? [faction] : ['Alliance', 'Horde'];
		let gi = 0;
		for (const m of block.matchAll(/map = (\d+), x = ([\d.]+), y = ([\d.]+)(?:, z = (-?[\d.]+))?(, f = "e")?/g)) {
			gi++;
			const map = +m[1];
			const w = geo.toWorld(map, +m[2], +m[3], m[5] ? 'e' : 'l');
			if (!w || ![0, 1].includes(w.c)) continue;
			for (const fa of factions) {
				const key = `${fa}|${w.c}|${Math.round(w.wx / 20)}|${Math.round(w.wy / 20)}`;
				if (seen.has(key)) continue;
				seen.add(key);
				const cand = [];
				for (let k = 0; k < 8; k++) {
					const a = (k * Math.PI) / 4;
					cand.push([+(w.wx + DIST * Math.cos(a)).toFixed(1), +(w.wy + DIST * Math.sin(a)).toFixed(1)]);
				}
				starts.push({ id: `${gi} ${fa[0]} ${id}`, faction: fa, level, c: w.c, gx: +w.wx.toFixed(1), gy: +w.wy.toFixed(1), tmap: map, tx: +m[2], ty: +m[3], tf: m[5] ? 'e' : 'l', tz: m[4] === undefined ? null : +m[4], cand });
			}
		}
	}
}
fs.writeFileSync(out, JSON.stringify(starts));
console.log(`${starts.length} goals`);
