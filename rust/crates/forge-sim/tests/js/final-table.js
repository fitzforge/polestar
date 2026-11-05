// The sim port's result tables from forge sim route/shared JSONs: node final-table.js <dir>
// (files <faction>-<start>-<v1|camps>-r<seed>[-draws3].json and shared-<faction>-<model>.json).
const fs = require('fs');
const path = require('path');
const dir = process.argv[2];
const read = (f) => (fs.existsSync(path.join(dir, f)) ? JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8')) : null);
const h = (x) => (x == null || !Number.isFinite(x) ? '-' : x.toFixed(2));
const starts = [['horde', 'Orc'], ['horde', 'Troll'], ['horde', 'Tauren'], ['horde', 'Undead'], ['horde', 'Skyborne'], ['alliance', 'Human'], ['alliance', 'Dwarf'], ['alliance', 'Gnome'], ['alliance', 'NightElf'], ['alliance', 'Skyborne']];
for (const model of ['v1', 'camps']) {
	console.log(`\n### Model: ${model === 'v1' ? "v1's (walks on)" : 'v1 + camps + spots (walks on)'}\n`);
	console.log('| start | v1 to 30 / 60 | improved to 30 / 60 (best of 3 seeds) | 3 seeds to 60 | same orders, other model v1 → improved | gate v1 → improved | holdout gain (16 draws): mean, min, P>0 | returns / passed-by (sim guards) v1 → best | added / dropped | reordered quests (events / common) | shifted only |');
	console.log('|---|---|---|---|---|---|---|---|---|---|---|');
	for (const [f, s] of starts) {
		const runs = [1, 2, 3].map((r) => read(`${f}-${s}-${model}-r${r}.json`)).filter(Boolean);
		if (!runs.length) continue;
		const best = runs.reduce((a, b) => (b.improved.hours60 < a.improved.hours60 ? b : a));
		const df = best.diff;
		const hm = runs.map((r) => r.holdout.mean);
		console.log(`| ${f === 'horde' ? 'H' : 'A'} ${s} | ${h(best.v1.hours30)} / ${h(best.v1.hours60)} | ${h(best.improved.hours30)} / ${h(best.improved.hours60)} | ${runs.map((r) => h(r.improved.hours60)).join(', ')} | ${h(best.v1Other.hours60)} → ${h(best.improvedOther.hours60)} | ${h(best.v1Gate.hours60)} → ${h(best.improvedGate.hours60)} | ${h(best.holdout.mean)}, ${h(best.holdout.min)}, ${(100 * best.holdout.share_positive).toFixed(0)} % (seeds ${hm.map(h).join(', ')}) | ${best.guardsV1 ? `${best.guardsV1.avoidable_returns} → ${best.guardsImproved.avoidable_returns} / ${best.guardsV1.passed_by} → ${best.guardsImproved.passed_by}` : '-'} | ${df.added.length} / ${df.dropped.length} | ${df.reordered.length} (${df.reordered_events} / ${df.common_events}) | ${df.shifted_only} |`);
	}
}
console.log('\n### Shared 12-60 route per faction (sum over starts × slow/avg/fast; lost = shared − own best, h)\n');
for (const f of ['horde', 'alliance']) {
	for (const model of ['v1', 'camps']) {
		const d = read(`shared-${f}-${model}.json`);
		if (!d) continue;
		console.log(`- ${f} ${model}: sum ${h(d.seedSum)} → ${h(d.bestSum)} h; ${d.rows.filter((r) => r.profile === 'avg').map((r) => `${r.start} join L${r.join_level.toFixed(1)} v1 ${h(r.v1)} own ${h(r.own)} shared ${h(r.shared)}`).join('; ')}; lost range ${h(Math.min(...d.rows.map((r) => r.lost)))} … ${h(Math.max(...d.rows.map((r) => r.lost)))}`);
	}
}
