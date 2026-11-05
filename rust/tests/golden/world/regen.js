'use strict';
// Regenerates rust/tests/golden/world/expected with the JS world builder, atlas and rules
// (tools/lib/sim/world.js getWorld, tools/lib/judge/atlas.js, tools/lib/judge/rules.js) of the
// checkout $JS_ROOT (required: a checkout before the JS retirement, e.g. 734380d2a) on the committed mini repository root/ (the data slice,
// its client-table and CMaNGOS source slices and a copy of the rules file, root/data/rules.json). No walking
// grid (root/data/local/nav4 does not exist): no heights, no subzones. Not run in CI.
// usage: JS_ROOT=<checkout at 734380d2a> node rust/tests/golden/world/regen.js
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');

const HERE = __dirname;
const ROOT = path.join(HERE, 'root');
if (!process.env.JS_ROOT) {
	console.error('usage: JS_ROOT=<checkout at 734380d2a> node rust/tests/golden/world/regen.js (this checkout no longer has the JS judge atlas and rules)');
	process.exit(2);
}
const JS = path.resolve(process.env.JS_ROOT);
const OUT = path.join(HERE, 'expected');
const DATA = path.join(ROOT, 'data/forever');
const SOURCES = path.join(ROOT, 'data/sources');
process.env.POLESTAR_GRID = path.join(ROOT, 'data/local/nav4');
process.env.POLESTAR_CAS = 'off';
process.env.POLESTAR_CAS_SKIP = 'walks';

// The JS world reads its checkout's own rules file (sim/rules.js FILE): the copy must match it.
const rulesCopy = fs.readFileSync(path.join(ROOT, 'data/rules.json'));
if (!rulesCopy.equals(fs.readFileSync(require(path.join(JS, 'tools/lib/sim/rules')).FILE))) throw new Error('root/data/rules.json differs from the JS checkout\'s rules file: copy it first');

const { getWorld } = require(path.join(JS, 'tools/lib/sim/world'));
const { loadQuestXp } = require(path.join(JS, 'tools/lib/game/xp'));
const { buildAtlas, subzoneLookup } = require(path.join(JS, 'tools/lib/judge/atlas'));
const { makeProjector } = require(path.join(JS, 'tools/lib/route/geo'));
const { compileRun } = require(path.join(JS, 'tools/lib/sim/run'));
const { simRules, available, levelOk, makeRules } = require(path.join(JS, 'tools/lib/judge/rules'));

const gz = (file, v) => fs.writeFileSync(path.join(OUT, `${file}.gz`), zlib.gzipSync(typeof v === 'string' ? v : JSON.stringify(v), { level: 9 }));
const rd = (f) => JSON.parse(fs.readFileSync(path.join(DATA, `${f}.json`), 'utf8'));

(async () => {
	fs.rmSync(OUT, { recursive: true, force: true });
	fs.mkdirSync(OUT, { recursive: true });
	const simDir = fs.mkdtempSync(path.join(process.env.SCRATCH || OUT, '.simdir-'));
	const questXp = await loadQuestXp({ sourcesDir: SOURCES, offline: true });
	const worlds = {};
	for (const faction of ['Horde', 'Alliance']) {
		const w = getWorld({ dataDir: DATA, sourcesDir: SOURCES, simDir, faction, rebuild: true, questXp, log: console.error });
		worlds[faction] = w;
		gz(`world-${faction.toLowerCase()}.json`, fs.readFileSync(path.join(simDir, `world-${faction.toLowerCase()}.json`), 'utf8'));
	}
	fs.rmSync(simDir, { recursive: true, force: true });

	// Atlas (jsatlas.js's dump).
	const [quests, npcs, objects, items, frames] = ['quests', 'npcs', 'objects', 'items', 'map-frames'].map(rd);
	const sz = (s) => (s ? { id: s.id, name: s.name, zoneId: s.zoneId, zone: s.zone } : null);
	for (const faction of ['Horde', 'Alliance']) {
		const a = buildAtlas({ quests, npcs, objects, items, proj: makeProjector(frames), subzone: subzoneLookup({ gridDir: process.env.POLESTAR_GRID, sourcesDir: SOURCES }), faction });
		gz(`atlas-${faction.toLowerCase()}.json`, {
			areas: a.areas.map((x) => ({ id: x.id, map: x.map, c: x.c, name: x.name, subzone: sz(x.subzone), wx: x.wx, wy: x.wy, n: x.n, hub: x.hub, nodes: x.nodes, give: [...x.give], end: [...x.end], obj: [...x.obj].map(([q, l]) => [q, l.map((o) => [o.oi, o.key, o.n])]) })),
			zones: [...a.zones.values()].map((z) => ({ map: z.map, areas: z.areas.map((x) => x.id), hubs: z.hubs })),
			roles: [...a.roles].map(([q, r]) => [q, r.give.map((n) => n.key), r.end.map((n) => n.key), r.obj.map((l) => l.map((n) => n.key))]),
			nodes: [...a.nodes.values()].map((n) => [n.key, n.name, n.map, n.c, n.wx, n.wy, n.n, n.pts.length]),
		});
	}

	// Availability rule (jsrules.js).
	const rules = {};
	for (const [faction, race, cls] of [['Horde', 'Orc', 'Warrior'], ['Horde', 'Troll', null], ['Alliance', 'Human', 'Mage'], ['Alliance', 'Human', 'Paladin']]) {
		const run = compileRun(worlds[faction], { race, cls, packages: false, walkRun: false });
		const r = simRules(run);
		const ids = run.quests.map((q) => q.id);
		const solo = ids.filter((q) => r.soloOk(q));
		const pre = ids.map((q) => [q, r.prereqsOf(quests[q] || { id: q, excl: [] })]);
		const done = new Set(ids.filter((q) => q % 7 === 0));
		const taken = new Set([...done, ...ids.filter((q) => q % 11 === 0)]);
		const avail = [];
		for (const level of [3, 12.5, 30]) {
			for (const id of Object.keys(quests).map(Number)) {
				const a = available(quests[id], { level, done, taken, faction, race, cls }, quests, { prereqsOf: r.prereqsOf });
				avail.push([id, level, a.ok, a.reason]);
			}
		}
		const lv = [];
		for (const ql of [0, 1, 5, 9, 10, 12, 13]) for (const l of [5, 7.9, 10, 10.5]) lv.push([ql, l, levelOk(ql, l)]);
		rules[`${faction}:${race}:${cls}`] = { ids, solo, pre, avail, lv };
	}
	gz('rules-ref.json', rules);

	// makeRules on a made-up Orc Warrior walk (jswalkrules.js).
	{
		const run = compileRun(worlds.Horde, { race: 'Orc', cls: 'Warrior', packages: false, walkRun: false });
		const r = simRules(run);
		const qs = run.quests.filter((q) => q.level <= 12).sort((a, b) => a.level - b.level || a.id - b.id);
		const goals = [];
		let lvl = 1;
		for (const q of qs) {
			for (const t of ['accept', 'kill', 'turnin']) {
				const g = { i: goals.length, t, q: q.id, oi: t === 'kill' ? 1 : null, lvl };
				if (t === 'turnin') lvl = Math.min(60, lvl + 0.15);
				g.lvlAfter = lvl;
				goals.push(g);
			}
		}
		const R = makeRules({ goals, quests, prereqsOf: r.prereqsOf });
		const probe = Object.keys(quests).map(Number).filter((q) => q % 3 === 0);
		const out = { goals, at: [], closed: probe.map((q) => [q, R.closedByWalk(q)]) };
		for (const t of [0, 10, 50, 200, goals.length - 1]) for (const q of probe) {
			const a = R.acceptableAt(q, t);
			out.at.push([q, t, a.ok, a.why]);
		}
		gz('walkrules-ref.json', out);
	}
	for (const f of fs.readdirSync(OUT)) console.error(`${f}: ${fs.statSync(path.join(OUT, f)).size} bytes`);
})().catch((e) => {
	console.error(e.stack);
	process.exit(1);
});
