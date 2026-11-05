'use strict';
// Reference dump for tests/guidetext_parity.rs: runs guidetext.js scoreTarget on one target and writes
// <out>/<tag>.ref.json { res, goals, sim, ms }: the scorer's result, its goals with the sim replay's levels
// (the sim evaluator isn't in Rust yet), and the sim view it read (run quests, world quest ids, excluded,
// packages). guidetext.js is read, not edited: its source is compiled with one line added that hands its
// goals and world to this script.
// usage: node guidetext-dump.js <guidetext.js> <target> <out.json>   (POLESTAR_JUDGE_* env as guidetext.js)
const fs = require('node:fs');
const Module = require('node:module');
const [, , GT, target, out] = process.argv;
const src = fs.readFileSync(GT, 'utf8').replace('\tconst res = {', '\tglobalThis.__gt = { goals, run, world };\n\tconst res = {');
const m = new Module(GT, module);
m.filename = GT;
m.paths = Module._nodeModulePaths(require('node:path').dirname(GT));
m._compile(src, GT);
const { scoreTarget, parseTarget } = m.exports;
(async () => {
	const t0 = Date.now();
	const res = await scoreTarget(parseTarget(target), { out: false, log: () => {} });
	const ms = Date.now() - t0;
	const { goals, run, world } = globalThis.__gt;
	const pt = (i) => { const p = world.points[i]; return [p[0], p[2], p[3]]; };
	const sim = {
		run: run.quests.map((q) => ({ id: q.id, title: q.title, level: q.level, hubGiver: q.hubGiver ?? null, tasks: q.tasks.map((t) => pt(t.pt)) })),
		worldQuests: world.quests.map((q) => q.id),
		excluded: (world.excluded || []).map((e) => ({ id: e.id, category: e.category ?? null, reason: String(e.reason) })),
		packages: world.packages.map((p) => ({ key: p.key, zone: p.zone, quests: p.quests })),
		bandWidth: world.bandWidth ?? null,
		dataHash: world.dataHash ?? null,
	};
	const gs = goals.map((g) => ({
		i: g.i, guide: g.guide, file: g.file, line: g.line ?? null, step: g.step ?? null, t: g.t, q: g.q, oi: g.oi,
		optional: g.optional, passing: !!g.passing, map: g.map, w: g.w, npc: g.npc, level: g.level, title: g.title,
		lvl: g.lvl, time: g.time, lvlAfter: g.lvlAfter, timeAfter: g.timeAfter,
	}));
	fs.writeFileSync(out, JSON.stringify({ res, goals: gs, sim, ms }));
	console.log(`${target}: ${goals.length} goals, ${ms} ms`);
})().catch((e) => { console.error(e); process.exit(1); });
