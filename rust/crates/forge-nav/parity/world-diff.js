'use strict';
// What changed between two sim worlds for the quests a chain takes (a v1chain.js seed's goals):
// XP, levels, giver/ender/task places (moved more than 5 yd, or a height change), quests only in one.
// node world-diff.js <old world.json> <new world.json> <seed.json>
const fs = require('node:fs');
const [oldF, newF, seedF] = process.argv.slice(2);
const A = JSON.parse(fs.readFileSync(oldF, 'utf8'));
const B = JSON.parse(fs.readFileSync(newF, 'utf8'));
const seed = JSON.parse(fs.readFileSync(seedF, 'utf8'));
const ids = [...new Set(seed.goals.map((g) => g.q).filter((q) => q != null))];
const qa = new Map(A.quests.map((q) => [q.id, q]));
const qb = new Map(B.quests.map((q) => [q.id, q]));
const at = (W, pt) => (pt == null ? null : W.points[pt]);
const moved = (p, q) => (!p || !q ? p !== q : p[0] !== q[0] || Math.hypot(p[2] - q[2], p[3] - q[3]) > 5 || (p[5] == null) !== (q[5] == null) || Math.abs((p[5] || 0) - (q[5] || 0)) > 3);
const out = { quests: ids.length, onlyOld: [], onlyNew: [], xp: [], level: [], giver: [], ender: [], tasks: [] };
let xpOld = 0;
let xpNew = 0;
for (const id of ids) {
	const a = qa.get(id);
	const b = qb.get(id);
	if (!a || !b) {
		(a ? out.onlyOld : out.onlyNew).push(id);
		continue;
	}
	xpOld += a.xp || 0;
	xpNew += b.xp || 0;
	if ((a.xp || 0) !== (b.xp || 0)) out.xp.push([id, a.title, a.xp, b.xp]);
	if (a.level !== b.level || a.minLevel !== b.minLevel) out.level.push([id, a.title, `${a.minLevel}/${a.level}`, `${b.minLevel}/${b.level}`]);
	for (const k of ['giver', 'ender']) {
		const p = at(A, a[k]);
		const q = at(B, b[k]);
		if (moved(p, q)) out[k].push([id, a.title, p && [p[2], p[3], p[5]], q && [q[2], q[3], q[5]], p && q ? Math.round(Math.hypot(p[2] - q[2], p[3] - q[3])) : null]);
	}
	const ta = (a.tasks || []).map((t) => at(A, t.pt));
	const tb = (b.tasks || []).map((t) => at(B, t.pt));
	if (ta.length !== tb.length || ta.some((p, i) => moved(p, tb[i]))) out.tasks.push([id, a.title, ta.length, tb.length]);
}
console.log(`world ${A.dataHash} -> ${B.dataHash}: ${A.points.length} -> ${B.points.length} points, ${A.quests.length} -> ${B.quests.length} quests`);
console.log(`chain quests ${ids.length}: only old ${out.onlyOld.length} ${JSON.stringify(out.onlyOld)}, only new ${out.onlyNew.length} ${JSON.stringify(out.onlyNew)}`);
console.log(`XP changed on ${out.xp.length} (sum ${xpOld} -> ${xpNew}): ${JSON.stringify(out.xp.slice(0, 12))}`);
console.log(`levels changed on ${out.level.length}: ${JSON.stringify(out.level.slice(0, 8))}`);
console.log(`givers moved ${out.giver.length}: ${JSON.stringify(out.giver.slice(0, 6))}`);
console.log(`enders moved ${out.ender.length}: ${JSON.stringify(out.ender.slice(0, 6))}`);
console.log(`task places changed on ${out.tasks.length}: ${JSON.stringify(out.tasks.slice(0, 8))}`);
const changed = (A.inputs && B.inputs) ? Object.keys(B.inputs).filter((k) => A.inputs[k] !== B.inputs[k]) : [];
console.log(`inputs changed: ${changed.join(', ')}`);
