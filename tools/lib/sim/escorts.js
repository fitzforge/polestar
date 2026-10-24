'use strict';
// Escort runs: how far each escort NPC walks, how long it stops on the way,
// how fast it goes and how many ambushers it calls, from the world databases.
// The sim prices an escort from them (v2/work.js eventSec); players skip an
// escort that takes long, and so does the route unless it is worth its time.
//
//   await loadEscortFacts({ dataDir, sourcesDir, tdbDir, log }) -> facts, kept in
//     escortFactsFile(sourcesDir) (rewritten only when they change)
//   readEscortFacts(sourcesDir) -> facts | null
//   attachEscortRuns(world, facts) -> each escort quest's escortRun: { yd, waitSec,
//     speed, adds, follow } from its facts, null without (sim's loadWorld, after
//     the world is read: like the graveyards, not part of the world file or its
//     hash, so new facts need no world or walks rebuild)
//   facts: { [questId]: { npc, yd, waitSec, speed, adds, follow, src } }
//     npc      the escort NPC (the quest's starter with facts)
//     yd       its path's length (3D, yards), null when no source has the path
//     waitSec  the path's stops (the waypoints' wait times), seconds
//     speed    yd/s along the path: the walk (2.5 × speed_walk) or, when the
//              script runs it, the run (7 × speed_run)
//     adds     ambushers it summons on the way (each priced as a kill)
//     follow   a follower (FollowerAI): it walks after the player, no path
//     src      where the path came from: cmangos (script_waypoint), tdb (the
//              Forever world database's waypoint_path), cpp (the script's own
//              point list), or null
//
// Sources, for each escort quest (dsl/escort.js isEscort on quests.json) and its
// starter NPCs (the first with a path wins):
//   - the path: CMaNGOS classic-db script_waypoint (cmangos.js loadEscortPaths);
//     the Forever TrinityCore world database (data/local/forever-tdb/world.sqlite):
//     the path its SmartAI starts (action 53 WP_START, in its scripts or the
//     action lists they call), else its VMaNGOS entry path (810000000 + 10 × entry,
//     820000000 + 10 × entry + k); else the point list in its C++ script.
//   - the ambushes, the run and the follower: its C++ script in the database's
//     source tree (struct <ScriptName>[AI] : EscortAI | FollowerAI: its
//     SummonCreature calls, SetRun(true)), else its SmartAI scripts and the
//     action lists they call (action 12 SUMMON_CREATURE; WP_START's run flag),
//     else the CMaNGOS quest start script's summons (dbscripts_on_quest_start
//     command 10).
// Without the database (a clean checkout) only the CMaNGOS facts are there;
// without either, none, and the price takes the straight line (work.js).

const fs = require('node:fs');
const path = require('node:path');
const { isEscort } = require('../dsl/escort');
const { loadEscortPaths } = require('../travel/cmangos');
const { ROOT } = require('../paths');

const TDB_DIR = path.join(ROOT, 'data', 'local', 'forever-tdb');
const FACTS = 'escort_facts.json';
// Classic movement: walk 2.5 yd/s, run 7 yd/s, times the creature's speed_walk / speed_run.
const WALK_YD = 2.5;
const RUN_YD = 7;
// SmartAI: action types (TrinityCore SmartScriptMgr.h).
const SA_SUMMON = 12;
const SA_WP_START = 53;
const SA_CALL_LIST = 80;
const SA_RANDOM_LIST = 87;
const SA_RANGE_LIST = 88;
// VMaNGOS entry paths in the Forever database: 810000000 + 10 × entry, 820000000 + 10 × entry + k.
const ENTRY_PATHS = [810000000, 820000000];

const escortFactsFile = (sourcesDir) => path.join(sourcesDir, FACTS);

function readEscortFacts(sourcesDir) {
	const file = sourcesDir ? escortFactsFile(sourcesDir) : null;
	return file && fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null;
}

// Length (3D) and stops (ms) of a point list [[x, y, z, waitMs], ...].
function pathOf(pts) {
	let yd = 0;
	let wait = 0;
	for (let i = 0; i < pts.length; i++) {
		wait += pts[i][3] || 0;
		if (i) yd += Math.hypot(pts[i][0] - pts[i - 1][0], pts[i][1] - pts[i - 1][1], pts[i][2] - pts[i - 1][2]);
	}
	return { yd: Math.round(yd), waitSec: Math.round(wait / 1000) };
}

// The C++ escort and follower scripts of the database's source tree: name ->
// { follow, adds, run, points } (points: the struct's own point list, or null).
function cppScripts(srcDir) {
	const out = new Map();
	if (!srcDir || !fs.existsSync(srcDir)) return out;
	const files = [];
	(function walk(d) {
		for (const e of fs.readdirSync(d, { withFileTypes: true })) {
			const p = path.join(d, e.name);
			if (e.isDirectory()) walk(p);
			else if (e.name.endsWith('.cpp')) files.push(p);
		}
	})(srcDir);
	files.sort();
	const STRUCT = /^([ \t]*)struct (\w+) : public (EscortAI|FollowerAI)\b/gm;
	const ARRAY = /\b\w+ const (\w+)\[\] =\s*\{([\s\S]*?)\n\};/g;
	const POINT = /\{\s*\d+\s*,\s*(-?[\d.]+)f?\s*,\s*(-?[\d.]+)f?\s*,\s*(-?[\d.]+)f?\s*,\s*(\d+)\s*\}/g;
	for (const f of files) {
		const src = fs.readFileSync(f, 'utf8');
		if (!/: public (EscortAI|FollowerAI)\b/.test(src)) continue;
		const arrays = new Map();
		for (const m of src.matchAll(ARRAY)) {
			const pts = [...m[2].matchAll(POINT)].map((p) => [Number(p[1]), Number(p[2]), Number(p[3]), Number(p[4])]);
			if (pts.length > 1) arrays.set(m[1], pts);
		}
		for (const m of src.matchAll(STRUCT)) {
			const end = src.indexOf(`\n${m[1]}};`, m.index);
			const body = src.slice(m.index, end < 0 ? undefined : end);
			const ref = [...body.matchAll(/:\s*(\w+)\s*\)/g)].map((r) => r[1]).find((n) => arrays.has(n));
			const name = m[2].replace(/AI$/, '');
			if (out.has(name)) continue;
			out.set(name, {
				follow: m[3] === 'FollowerAI',
				adds: (body.match(/SummonCreature\s*\(/g) || []).length,
				run: /SetRun\s*\(\s*(true\s*)?\)/.test(body),
				points: ref ? arrays.get(ref) : null,
			});
		}
	}
	return out;
}

// The Forever database's facts of NPC entries: entry -> { path, adds, run, script,
// walk, runSpeed } (path: { yd, waitSec } or null; script: its ScriptName).
function tdbFacts(tdbDir, entries) {
	const out = new Map();
	const file = tdbDir ? path.join(tdbDir, 'world.sqlite') : null;
	if (!file || !fs.existsSync(file) || !entries.length) return out;
	const { DatabaseSync } = require('node:sqlite');
	const db = new DatabaseSync(file, { readOnly: true });
	try {
		const tmpl = db.prepare('SELECT ScriptName, speed_walk, speed_run FROM creature_template WHERE entry = ?');
		const smart = db.prepare('SELECT action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6 FROM smart_scripts WHERE entryorguid = ? AND source_type = ?');
		const nodes = db.prepare('SELECT PositionX, PositionY, PositionZ, Delay FROM waypoint_path_node WHERE PathId = ? ORDER BY NodeId');
		const entryPaths = db.prepare('SELECT PathId FROM waypoint_path WHERE PathId BETWEEN ? AND ? ORDER BY PathId');
		const pathOfId = (id) => {
			const pts = nodes.all(id).map((r) => [r.PositionX, r.PositionY, r.PositionZ, r.Delay]);
			return pts.length > 1 ? pathOf(pts) : null;
		};
		for (const e of entries) {
			const t = tmpl.get(e);
			if (!t) continue;
			// The NPC's scripts and the action lists they call, and their calls
			// (a Set visits what is added while it is walked).
			const all = smart.all(e, 0);
			const lists = new Set();
			const seeLists = (rs) => {
				for (const r of rs) {
					if (r.action_type === SA_CALL_LIST) lists.add(r.action_param1);
					else if (r.action_type === SA_RANDOM_LIST) for (const k of ['action_param1', 'action_param2', 'action_param3', 'action_param4', 'action_param5', 'action_param6']) { if (r[k] > 0) lists.add(r[k]); }
					else if (r.action_type === SA_RANGE_LIST) for (let id = r.action_param1; id > 0 && id <= r.action_param2; id++) lists.add(id);
				}
			};
			seeLists(all);
			for (const id of lists) {
				const rs = smart.all(id, 9);
				all.push(...rs);
				seeLists(rs);
			}
			let p = null;
			let run = false;
			for (const r of all) {
				if (r.action_type !== SA_WP_START || p) continue;
				p = pathOfId(r.action_param2);
				run = r.action_param1 === 1;
			}
			for (const base of ENTRY_PATHS) {
				if (p) break;
				for (const { PathId } of entryPaths.all(base + e * 10, base + e * 10 + 9)) if (!p) p = pathOfId(PathId);
			}
			out.set(e, {
				path: p,
				adds: all.filter((r) => r.action_type === SA_SUMMON).length,
				run,
				script: t.ScriptName || '',
				walk: WALK_YD * (t.speed_walk || 1),
				runSpeed: RUN_YD * (t.speed_run || 1),
			});
		}
	} finally {
		db.close();
	}
	return out;
}

// The escort facts of quests.json's escort quests (see the header).
function escortFacts(quests, { cmangos = null, tdb = new Map(), cpp = new Map() } = {}) {
	const out = {};
	for (const id of Object.keys(quests).map(Number).filter(Number.isFinite).sort((a, b) => a - b)) {
		const raw = quests[id];
		if (!isEscort(raw)) continue;
		const npcs = ((raw.start && raw.start.npc) || []).map(Number);
		let best = null;
		for (const npc of npcs) {
			const t = tdb.get(npc) || null;
			const s = t && t.script ? cpp.get(t.script) || null : null;
			const cm = cmangos && cmangos.paths ? cmangos.paths[npc] : null;
			let p = null;
			let src = null;
			if (cm) {
				p = { yd: cm[0], waitSec: cm[1] };
				src = 'cmangos';
			} else if (t && t.path) {
				p = t.path;
				src = 'tdb';
			} else if (s && s.points) {
				p = pathOf(s.points);
				src = 'cpp';
			}
			const run = s ? s.run : t ? t.run : false;
			const fact = {
				npc,
				yd: p ? p.yd : null,
				waitSec: p ? p.waitSec : 0,
				speed: Math.round((run ? (t ? t.runSpeed : RUN_YD) : (t ? t.walk : WALK_YD)) * 100) / 100,
				adds: s ? s.adds : t ? t.adds : (cmangos && cmangos.summons && cmangos.summons[id]) || 0,
				follow: !!(s && s.follow),
				src,
			};
			if (!best || (best.yd == null && fact.yd != null)) best = fact;
			if (best.yd != null) break;
		}
		if (best) out[id] = best;
	}
	return out;
}

// Builds the facts and keeps them beside the sources (see the header). The
// CMaNGOS extract is cached beside the classic-db dump; offline without it,
// the facts go without its paths.
async function loadEscortFacts({ dataDir, sourcesDir, tdbDir = TDB_DIR, offline = false, log = () => {} }) {
	const quests = JSON.parse(fs.readFileSync(path.join(dataDir, 'quests.json'), 'utf8'));
	let cmangos = null;
	try {
		cmangos = await loadEscortPaths({ sourcesDir, offline, log });
	} catch (err) {
		log(`  warning: CMaNGOS escort paths unavailable (${err.message})`);
	}
	const npcs = new Set();
	for (const q of Object.values(quests)) if (q && isEscort(q)) for (const n of (q.start && q.start.npc) || []) npcs.add(Number(n));
	const tdb = tdbFacts(tdbDir, [...npcs].sort((a, b) => a - b));
	const cpp = tdb.size ? cppScripts(path.join(tdbDir, 'repo', 'src', 'server', 'scripts')) : new Map();
	const facts = escortFacts(quests, { cmangos, tdb, cpp });
	const file = escortFactsFile(sourcesDir);
	const text = `${JSON.stringify(facts)}\n`;
	if (!fs.existsSync(file) || fs.readFileSync(file, 'utf8') !== text) {
		fs.mkdirSync(sourcesDir, { recursive: true });
		const tmp = `${file}.${process.pid}.tmp`; // runs on workers may write at once
		fs.writeFileSync(tmp, text);
		fs.renameSync(tmp, file);
	}
	return facts;
}

function attachEscortRuns(world, facts) {
	for (const q of world.quests || []) {
		if (!q.escort) continue;
		const f = facts ? facts[String(q.id)] : null;
		q.escortRun = f ? { yd: f.yd, waitSec: f.waitSec, speed: f.speed, adds: f.adds, follow: f.follow } : null;
	}
	return world;
}

module.exports = { loadEscortFacts, readEscortFacts, attachEscortRuns, escortFactsFile, escortFacts, pathOf, cppScripts, tdbFacts, TDB_DIR, WALK_YD, RUN_YD };
