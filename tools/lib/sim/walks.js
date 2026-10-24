'use strict';
// Routed walks (docs/SIMULATION.md §1 "Walks"): walking distances between the
// world's points from Polestar's walking router (addon/Polestar_Nav, run
// standalone by `nav eval`'s harness), so the simulator walks round cliffs,
// mountains and water as the arrow does, not straight through them. Without
// them every walk is the straight line × the continent's detour factor, which
// is right on average (1.3) but prices a walk through a mountain wall as if
// it were open ground: Silithus to Feralas is 1,785 yd straight and 13,807 yd
// walked.
//
//   walkPoints(world, maps) -> sorted world point indices a run can walk between: quest
//     givers, enders, accept and task sites, package steps, inns, transport nodes and starts,
//     on the maps the router has walking maps for (PACK.json `maps`)
//   walkQueries(world, { radius, style, maps }) -> one `many` query per point to every later
//     point (index order) on its landmass within `radius` yards, as the faction (profile)
//   buildWalks(world, { navDir, radius, style, workers, log, runQueries? }) -> walks document
//     { schema, faction, dataHash, nav, style, radius, points, pairs: [a, b, yards, ...] }
//     (a < b, world point indices; a pair the router could not walk is left out, so it
//     keeps the straight line × detour)
//   walksFile(simDir, faction, variant), navFingerprint(navDir)
//   attachWalks(world, simDir, { navDir, log }) -> world.walks = Map(a * NW + b -> yards, both
//     orders) when data/sim/walks-<faction>.json was built on this world and these walking
//     maps; else none (and a note why)
//   walkYards(world, a, b) -> routed yards between world points a and b, or undefined
//
// A walk is priced on one side's route (the faction's profile: its hostile towns
// cost more) in the arrow's default route style (balanced). The pairs are one
// direction's search (a to b), used both ways.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const crypto = require('node:crypto');
const { Worker, isMainThread, parentPort, workerData } = require('node:worker_threads');
const { ROOT } = require('../paths');

const WALKS_SCHEMA = 1;
const RADIUS = 4000; // yards: longer walks keep the straight line × detour (a flight or a ride usually wins)
const STYLE = 'balanced';
const NAV_DIR = path.join(ROOT, 'addon', 'Polestar_Nav');
const CHUNK = 8; // queries per worker job (progress granularity)

// A world variant (the group world, --elites) has its own points and hash,
// so its own walks: walks-horde-group.json beside walks-horde.json.
function walksFile(simDir, faction, variant = 'solo') {
	const v = variant && variant !== 'solo' ? `-${variant}` : '';
	return path.join(simDir, `walks-${String(faction).toLowerCase()}${v}.json`);
}

function readPack(navDir = NAV_DIR) {
	return JSON.parse(fs.readFileSync(path.join(navDir, 'PACK.json'), 'utf8'));
}

// The walking maps and router a walks file was built on: PACK.json (it lists
// every map file's sha256) and the router's code (API.lua, Routing/), the
// folder's own where it has them, else the repository's (as nav eval loads them).
function navFingerprint(navDir = NAV_DIR) {
	const h = crypto.createHash('sha1').update(fs.readFileSync(path.join(navDir, 'PACK.json')));
	const code = ['API.lua', ...fs.readdirSync(path.join(NAV_DIR, 'Routing')).sort().map((f) => `Routing/${f}`)];
	for (const f of code) {
		const own = path.join(navDir, f);
		h.update(`\n${f}\n`).update(fs.readFileSync(fs.existsSync(own) ? own : path.join(NAV_DIR, f)));
	}
	return h.digest('hex');
}

function walkPoints(world, maps) {
	const set = new Set();
	const add = (pt) => {
		if (pt != null && world.points[pt] && maps.has(world.points[pt][0])) set.add(pt);
	};
	for (const q of world.quests) {
		add(q.giver);
		add(q.ender);
		// Every giver and ender of a quest that has several (a guide is scored at the one it names).
		for (const pt of Object.values(q.gAlt || {})) add(pt);
		for (const pt of Object.values(q.eAlt || {})) add(pt);
		if (q.accept) add(q.accept.pt);
		for (const t of q.tasks) add(t.pt);
	}
	for (const p of world.packages) for (const s of p.steps) add(s[3]);
	for (const n of world.inns || []) add(n.pt);
	for (const n of world.nodes || []) add(n.pt);
	for (const s of Object.values(world.starts || {})) add(s.pt);
	return [...set].sort((a, b) => a - b);
}

function walkQueries(world, { radius = RADIUS, style = STYLE, maps }) {
	const P = world.points;
	const pts = walkPoints(world, maps);
	const queries = [];
	for (let i = 0; i < pts.length; i++) {
		const a = P[pts[i]];
		const targets = [];
		for (let j = i + 1; j < pts.length; j++) {
			const b = P[pts[j]];
			if (b[0] !== a[0] || b[1] !== a[1] || Math.hypot(b[2] - a[2], b[3] - a[3]) > radius) continue;
			targets.push(pts[j]);
		}
		if (!targets.length) continue;
		queries.push({
			type: 'many', id: String(pts[i]), map: a[0], from: [a[2], a[3], null],
			targets: targets.map((t) => [P[t][2], P[t][3], null]), profile: world.faction, style,
			ids: targets,
		});
	}
	return { points: pts, queries };
}

// Run the queries on `workers` threads, CHUNK at a time, each thread through
// the harness (spawnSync): [{ id, ids, yards }].
function runParallel(queries, { navDir, workers, log }) {
	const W = Math.max(1, Math.min(workers, Math.ceil(queries.length / CHUNK)));
	const jobs = [];
	for (let i = 0; i < queries.length; i += CHUNK) jobs.push(queries.slice(i, i + CHUNK));
	const out = [];
	const t0 = Date.now();
	return new Promise((resolve, reject) => {
		let next = 0;
		let done = 0;
		let live = W;
		const threads = Array.from({ length: W }, () => new Worker(__filename, { workerData: { walksWorker: true, navDir } }));
		const finish = (err) => {
			for (const w of threads) w.terminate();
			if (err) reject(err);
			else resolve(out);
		};
		const feed = (w) => {
			if (next >= jobs.length) {
				if (--live === 0) finish();
				return;
			}
			const job = jobs[next++];
			w.once('message', (msg) => {
				if (msg.error) return finish(new Error(msg.error));
				out.push(...msg.results);
				done += job.length;
				if (log && (done === queries.length || Math.floor((done - job.length) / 200) !== Math.floor(done / 200))) {
					const s = (Date.now() - t0) / 1000;
					log(`  walks: ${done}/${queries.length} points routed, ${s.toFixed(0)} s, about ${Math.round((s / done) * (queries.length - done))} s left`);
				}
				feed(w);
			});
			w.postMessage(job.map(({ ids, ...q }) => q));
		};
		for (const w of threads) {
			w.once('error', finish);
			feed(w);
		}
	}).then((results) => {
		const byId = new Map(queries.map((q) => [q.id, q]));
		return results.map((r) => ({ id: r.id, ids: byId.get(r.id).ids, yards: r.yards, ok: r.ok, reason: r.reason }));
	});
}

async function buildWalks(world, { navDir = NAV_DIR, radius = RADIUS, style = STYLE, workers = Math.max(1, os.availableParallelism() - 1), log, runQueries } = {}) {
	const maps = new Set(Object.keys(readPack(navDir).maps).map(Number));
	const { points, queries } = walkQueries(world, { radius, style, maps });
	if (log) log(`  walks: ${world.faction}: ${points.length} points, ${queries.reduce((n, q) => n + q.targets.length, 0)} pairs within ${radius} yd, on ${workers} workers`);
	const results = runQueries
		? runQueries({ navDir, queries: queries.map(({ ids, ...q }) => q) }).results.filter((r) => r.type === 'many').map((r) => ({ ...r, ids: queries.find((q) => q.id === r.id).ids }))
		: await runParallel(queries, { navDir, workers, log });
	const pairs = [];
	let failed = 0;
	for (const r of results.sort((x, y) => Number(x.id) - Number(y.id))) {
		const a = Number(r.id);
		r.ids.forEach((b, k) => {
			const y = r.yards && r.yards[k];
			if (typeof y === 'number' && y >= 0) pairs.push(a, b, Math.round(y * 10) / 10);
			else failed++;
		});
	}
	if (log) log(`  walks: ${pairs.length / 3} pairs routed, ${failed} the router could not walk (they keep the straight line × detour)`);
	return { schema: WALKS_SCHEMA, faction: world.faction, variant: world.variant || 'solo', dataHash: world.dataHash, nav: navFingerprint(navDir), style, radius, points: points.length, pairs };
}

function writeWalks(simDir, doc) {
	const file = walksFile(simDir, doc.faction, doc.variant);
	fs.mkdirSync(simDir, { recursive: true });
	fs.writeFileSync(`${file}.tmp`, JSON.stringify(doc));
	fs.renameSync(`${file}.tmp`, file);
	return file;
}

// world.walks for a run: the routed yards of every pair, keyed a * NW + b (world point indices, both orders).
function attachWalks(world, simDir, { navDir = NAV_DIR, log } = {}) {
	world.walks = null;
	world.walksId = null;
	const file = walksFile(simDir, world.faction, world.variant);
	if (!fs.existsSync(file)) {
		if (log) log(`  walks: no ${path.basename(file)}: walking is the straight line × detour (\`sim walks --faction ${world.faction.toLowerCase()}${world.variant === 'group' ? ' --elites' : ''}\` routes it)`);
		return null;
	}
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	let why = null;
	if (doc.schema !== WALKS_SCHEMA) why = `schema ${doc.schema}`;
	else if (doc.dataHash !== world.dataHash) why = 'built on another world';
	else if (fs.existsSync(path.join(navDir, 'PACK.json')) && doc.nav !== navFingerprint(navDir)) why = 'built on other walking maps';
	if (why) {
		if (log) log(`  walks: ${path.basename(file)} not used (${why}): walking is the straight line × detour; rerun \`sim walks --faction ${world.faction.toLowerCase()}${world.variant === 'group' ? ' --elites' : ''}\``);
		return null;
	}
	const NW = world.points.length;
	const m = new Map();
	for (let i = 0; i < doc.pairs.length; i += 3) {
		const a = doc.pairs[i];
		const b = doc.pairs[i + 1];
		m.set(a * NW + b, doc.pairs[i + 2]);
		m.set(b * NW + a, doc.pairs[i + 2]);
	}
	world.walks = m;
	// What a search result records (index.js assertFresh): these walks, on these maps.
	world.walksId = `${doc.nav.slice(0, 12)}:${doc.style}:${doc.radius}`;
	return m;
}

function walkYards(world, a, b) {
	return world.walks ? world.walks.get(a * world.points.length + b) : undefined;
}

if (!isMainThread && workerData && workerData.walksWorker) {
	const { runQueries } = require('../nav/eval/run');
	parentPort.on('message', (queries) => {
		try {
			const { results } = runQueries({ navDir: workerData.navDir, queries });
			parentPort.postMessage({ results: results.filter((r) => r.type === 'many').map((r) => ({ id: r.id, ok: r.ok, reason: r.reason, yards: r.yards })) });
		} catch (err) {
			parentPort.postMessage({ error: err && err.stack ? err.stack : String(err) });
		}
	});
}

module.exports = { WALKS_SCHEMA, RADIUS, STYLE, walksFile, navFingerprint, walkPoints, walkQueries, buildWalks, writeWalks, attachWalks, walkYards };
