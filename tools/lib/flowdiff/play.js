'use strict';
// flow-diff's player (tools/commands/flow-diff.js): plays one tree's leveling
// route through that tree's own engine and playtest, the way `playtest` plays
// it, and writes what each play did, step by step. It runs as its own process
// with the tree's modules (tools/lib/playtest.js and what it loads), so an
// older checkout plays with its own compiler, addon and stub world:
//
//   node tools/lib/flowdiff/play.js <job.json>
//
// job: { tree, data, out, guides: [text] | null, skipQuests: [ids], cls, levelOffset, workers, cache, label }
//   tree     the checkout (guides/, addon/Polestar, tools/, tests/lua with data/forever beside them)
//   data     the reference data (data/forever) every play reads
//   guides   play each start's route only up to its last guide whose id contains one of these
//            (null: every leveling guide on the default routes)
//   levelOffset  the player that many levels ahead of each guide's level (../playtest-level.js: this
//            tool's, so a tree whose playtest predates it plays it too); 0 or missing: none
//   cache    a folder of earlier plays (keyed by the engine, the compiled guide, the persona and the level offset)
// out: { label, engine, guides: { id: { title, faction, races, next, steps: [{ title, goals }], legs } },
//        branches: [{ start, race, faction, guides: [ids] }],
//        plays: { "id|faction": { race, faction, cls, ok, stuck, trace: [{ s, t, q, map, x, y, node, lv }] } } }
// A trace entry is one goal the simulated player acted on (SIMULATE's act):
// its step, verb, quest, place (the engine's choice of candidate) and the
// character's level then.

const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const { levelOffsetLua } = require('../playtest-level');

const DEFAULT_RACE = { Horde: 'Orc', Alliance: 'Human' };

// The tree's SIMULATE with the trace added: each goal acted on, emitted after
// SIMULATE's own result. With quests to skip, they are skipped (the window's
// "Skip this quest", Engine.SkipQuest) before the play, and the simulated
// player leaves the goals that then read "skipped" alone, as a player who
// skipped them does (SIMULATE's open goal: the first not done, not na). The
// anchors are SIMULATE's own lines since 0.3.x; a tree without them can't be traced.
const ACT = 'local function act(i, g, r)\n';
const OPEN = 'g.status ~= "done" and g.status ~= "na"';
const TRACE_PRELUDE = `
FLOW = {}
local function FLOW_ACT(i, g, r)
	local w = stub.world
	r = r or {}
	FLOW[#FLOW + 1] = { s = i, t = g.t, q = g.quest, map = g.map or r.map, x = g.x or r.x, y = g.y or r.y, node = r.node, lv = w.level }
end
`;

function traced(simulate, skipQuests) {
	if (!simulate.includes(ACT)) throw new Error("this tree's playtest SIMULATE has no act() anchor: flow-diff can't trace it");
	let sim = simulate.replace(ACT, `${ACT}\tFLOW_ACT(i, g, r)\n`);
	let skip = '';
	if (skipQuests.length) {
		if (sim.split(OPEN).length !== 2) throw new Error("this tree's playtest SIMULATE has no single open-goal test: flow-diff can't skip quests in it");
		sim = sim.replace(OPEN, `${OPEN} and g.status ~= "skipped"`);
		skip = `for _, q in ipairs({ ${skipQuests.join(', ')} }) do Polestar.Engine.SkipQuest(q) end\nstub.advance(0.6)\n`;
	}
	return TRACE_PRELUDE + skip + sim + '\nemit(FLOW)\n';
}

const sha = (...parts) => {
	const h = crypto.createHash('sha256');
	for (const p of parts) h.update(typeof p === 'string' ? p : JSON.stringify(p)).update('\0');
	return h.digest('hex');
};

// A play's cache key: the engine, the compiled guide (without its source tree), the persona, what the play starts
// with and the script; a level offset other than 0 too, so an offset play never reads a plain play's entry (nor one
// of another offset), while a plain play keeps its keys.
function playKey(engine, g, persona, before, script, levelOffset = 0) {
	const { _ast, ...plain } = g;
	return sha(engine, plain, persona, before, script, ...(levelOffset ? [{ levelOffset }] : []));
}

// Every file under dir, sorted, for the engine's key.
function filesUnder(dir) {
	const out = [];
	const walk = (d) => {
		for (const e of fs.readdirSync(d, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : 1))) {
			const p = path.join(d, e.name);
			if (e.isDirectory()) walk(p);
			else if (e.isFile()) out.push(p);
		}
	};
	if (fs.existsSync(dir)) walk(dir);
	return out;
}

// What a play depends on besides its guide: the addon, the stub world, the
// playtest and the data's build.
function engineKey(tree, data) {
	const h = crypto.createHash('sha256');
	const files = [
		...filesUnder(path.join(tree, 'addon', 'Polestar')),
		...filesUnder(path.join(tree, 'tests', 'lua')),
		path.join(tree, 'tests', 'helpers', 'lua.js'),
		path.join(tree, 'tools', 'lib', 'playtest.js'),
	].map((f) => [path.relative(tree, f), f]);
	// The data by its build, wherever it lies.
	files.push(['data/forever/meta.json', path.join(data, 'meta.json')]);
	for (const [name, f] of files) {
		if (!fs.existsSync(f)) continue;
		h.update(name).update('\0').update(fs.readFileSync(f)).update('\0');
	}
	return h.digest('hex');
}

// The start guides and the default route from each: a start guide is one with
// a race list that no other start's `next` leads into; each guide's `next`
// (else its first option outside the experimental pack) to the end.
function branchesOf(guides) {
	const byId = new Map(guides.map((g) => [g.id, g]));
	const starts = guides.filter((g) => Array.isArray(g.races) && g.races.length && g.category === 'Leveling');
	const pointed = new Set(starts.map((g) => g.next).filter(Boolean));
	const out = [];
	const nextOf = (g) => g.next || (g.nextChoices || []).find((id) => !String(id).startsWith('polestar-experimental/')) || null;
	for (const s of starts) {
		if (pointed.has(s.id)) continue;
		const factions = s.faction ? [s.faction] : ['Horde', 'Alliance'];
		for (const faction of factions) {
			for (const race of s.races) {
				const chain = [];
				for (let g = s; g && !chain.includes(g.id) && g.category === 'Leveling'; g = byId.get(nextOf(g))) {
					if (g.faction && g.faction !== faction) break;
					chain.push(g.id);
				}
				out.push({ start: race === 'Scourge' ? 'Undead' : race, race, faction, guides: chain });
			}
		}
	}
	// One branch per start race and faction (a start guide two races share gives each its own).
	const seen = new Set();
	return out.filter((b) => {
		const k = `${b.race}/${b.faction}/${b.guides[0]}`;
		if (seen.has(k)) return false;
		seen.add(k);
		return true;
	});
}

// The race and class a guide is played as on `faction`: a start guide's first
// race, else the faction's first branch race that reaches it, else Orc or
// Human; `cls` when the race can be it, else the race's first class.
function personaFor(g, faction, arriving, data, cls) {
	const race = (Array.isArray(g.races) && g.races[0]) || arriving || DEFAULT_RACE[faction];
	const classes = ((data.races && data.races[race] && data.races[race][faction]) || {}).classes || [];
	const header = Array.isArray(g.classes) && g.classes.length ? g.classes : null;
	const pick = header ? header.find((c) => !classes.length || classes.includes(c)) || header[0] : !classes.length || classes.includes(cls) ? cls : classes[0];
	return { race, faction, cls: pick };
}

// The objectives g's goals count for quest q, as the playtest gives an open
// quest on arrival (stub_world's onQuest): the largest count per objective.
function objectivesIn(g, q) {
	const req = [];
	for (const s of g.steps) for (const x of s.goals) if (x.quest === q && x.oi) req[x.oi - 1] = Math.max(req[x.oi - 1] || 1, x.count || 1);
	return Array.from(req, (n) => n || 1);
}

async function main(jobFile) {
	const job = JSON.parse(fs.readFileSync(jobFile, 'utf8'));
	const tree = path.resolve(job.tree);
	const T = (p) => require(path.join(tree, 'tools', 'lib', p));
	const { buildSimPack, playGuideIn, chainDone, withChain, SIMULATE } = T('playtest.js');
	const { LuaPool } = T('luapool.js');
	const { findGuideFiles, OFFICIAL_DIR } = T(path.join('dsl', 'project.js'));
	const { loadData } = T(path.join('dsl', 'data.js'));
	if (path.resolve(OFFICIAL_DIR) !== path.join(tree, 'guides')) throw new Error(`${tree}: its tools read guides from ${OFFICIAL_DIR}`);
	const data = loadData(job.data);
	const script = traced(SIMULATE, job.skipQuests || []);
	const log = (s) => process.stderr.write(`[${job.label}] ${s}\n`);

	// The leveling guides and every guide their `next` links reach (the shared 40-50 zones).
	const all = findGuideFiles(OFFICIAL_DIR);
	const files = withChain(OFFICIAL_DIR, all, all.filter((f) => /^forever\/(alliance|horde)\//.test(f.split(path.sep).join('/'))));
	const t0 = Date.now();
	const pack = buildSimPack(files, data);
	if (pack.diag.hasErrors()) {
		pack.dispose();
		const errs = pack.diag.errors.slice(0, 5).map((d) => `${d.file}:${d.line}: ${d.message}`).join('\n');
		throw new Error(`${tree}: the guides don't compile:\n${errs}`);
	}
	log(`compiled ${pack.guides.length} guides in ${((Date.now() - t0) / 1000).toFixed(0)} s`);
	const leveling = pack.guides.filter((g) => g.category === 'Leveling');
	const branches = branchesOf(leveling);
	const engine = engineKey(tree, job.data);
	const cache = job.cache ? path.resolve(job.cache) : null;
	if (cache) fs.mkdirSync(cache, { recursive: true });

	// Every guide on a branch, played once per faction that reaches it, as the
	// first branch race that reaches it. With `guides` (filters: text in the
	// id), a branch is played up to its last guide that matches, so the zones
	// before a matching guide are known.
	const matches = (id) => !job.guides || job.guides.some((f) => id.includes(f));
	const wanted = new Map();
	for (const b of branches) {
		const last = b.guides.reduce((n, id, i) => (matches(id) ? i : n), -1);
		for (const id of b.guides.slice(0, last + 1)) {
			const k = `${id}|${b.faction}`;
			if (!wanted.has(k)) wanted.set(k, { id, faction: b.faction, arriving: b.race });
		}
	}
	const byId = new Map(pack.guides.map((g) => [g.id, g]));
	const pool = new LuaPool({ size: job.workers || undefined });
	const plays = {};
	let played = 0;
	let cached = 0;
	try {
		await Promise.all(
			[...wanted.values()]
				.map(async ({ id, faction, arriving }) => {
					const g = byId.get(id);
					const persona = personaFor(g, faction, arriving, data, job.cls || 'WARRIOR');
					const pre = chainDone(pack.guides, g, persona);
					const before = [
						pre.done.length ? `w.complete({ ${pre.done.join(', ')} })` : '',
						...pre.carried.map((q) => `w.onQuest(${q}, {})`),
						...(pre.open || []).map((q) => `w.onQuest(${q}, { ${objectivesIn(g, q).map((n) => `{ required = ${n} }`).join(', ')} })`),
					].join('\n');
					const key = playKey(engine, g, persona, before, script, job.levelOffset || 0);
					const file = cache && path.join(cache, `${key}.json`);
					let rec = null;
					if (file && fs.existsSync(file)) {
						rec = JSON.parse(fs.readFileSync(file, 'utf8'));
						cached++;
					} else {
						const [out, trace] = await playGuideIn(pool, pack, g, { ...persona, before: levelOffsetLua(job.levelOffset || 0) + before, script });
						rec = { ...persona, ok: Boolean(out && out.done && !out.stuck), stuck: (out && out.stuck) || null, trace: Array.isArray(trace) ? trace : [] };
						if (file) fs.writeFileSync(file, JSON.stringify(rec));
						played++;
					}
					plays[`${id}|${faction}`] = rec;
				}),
		);
	} finally {
		pool.close();
		pack.dispose();
	}
	log(`${played} plays, ${cached} from the cache, in ${((Date.now() - t0) / 1000).toFixed(0)} s`);
	// The baked legs (guides/legs.json) of each guide whose leg ends still hash the same (compileProject's readLegs).
	const legsFile = path.join(tree, 'guides', 'legs.json');
	const legs = fs.existsSync(legsFile) ? JSON.parse(fs.readFileSync(legsFile, 'utf8')).legs || {} : {};
	let guideHash = null;
	try {
		({ guideHash } = T(path.join('nav', 'bake.js')));
	} catch {
		guideHash = null;
	}
	const guides = {};
	for (const g of leveling) {
		const entry = legs[g.id];
		guides[g.id] = {
			title: g.title || g.id,
			faction: g.faction || null,
			races: g.races || null,
			next: g.next || null,
			steps: g.steps.map((s) => ({ title: s.title || '', goals: s.goals.map((x) => ({ t: x.t, q: x.quest ?? null, map: x.map ?? null, x: x.x ?? null, y: x.y ?? null })) })),
			legs: entry && guideHash && entry.hash === guideHash(g, data.mapFrames) ? entry.steps || {} : null,
		};
	}
	fs.writeFileSync(job.out, JSON.stringify({ label: job.label, engine, guides, branches, plays }));
}

if (require.main === module) {
	main(process.argv[2]).then(
		() => process.exit(0),
		(e) => {
			process.stderr.write(`${e && e.stack ? e.stack : e}\n`);
			process.exit(1);
		},
	);
}

module.exports = { traced, branchesOf, personaFor, playKey };
