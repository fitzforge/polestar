// node gmeasure.js <guides> <Faction> <Race> [Class] [to=30] [--json out]
// Guide-level measures with the judge (v2-reset judge, read-only): passed-by, avoidable
// returns (judge), plus deaths, training trips, trains, grind minutes, quests done, hours.
// Training trip: a train goal whose stop (goals until the walk leaves 400 yd) holds only
// service goals (train/vendor/sethome/getfp/repair/buy/learn/fly/hearth/goto).
process.env.POLESTAR_CAS = 'off';
process.env.POLESTAR_CAS_SKIP = 'walks';
const JR = process.env.JUDGE_ROOT;
process.chdir(JR);
const fs = require('fs');
const path = require('path');
const [guides, faction, race, clsArg, toArg] = process.argv.slice(2);
const cls = clsArg && clsArg !== '-' ? clsArg : null;
const to = Number(toArg || 30);
const SIM = process.env.SIM;
const jo = process.argv.indexOf('--json');
const JOUT = jo > 0 ? path.resolve(process.argv[jo + 1]) : null;
if (process.env.ALLEX) {
	const Module = require('module');
	const fn = JR + '/tools/lib/judge/returns.js';
	const m = new Module(fn, module);
	m.filename = fn;
	m.paths = Module._nodeModulePaths(path.dirname(fn));
	m._compile(fs.readFileSync(fn, 'utf8').replace('const EXAMPLES = 15', 'const EXAMPLES = 1000'), fn);
	require.cache[fn] = m;
}
(async () => {
	const { judge } = require(JR + '/tools/lib/judge/index');
	const r = await judge({ guides: path.resolve(guides), faction, race, cls, to, simDir: SIM });
	const { walkChain } = require(JR + '/tools/lib/judge/walk');
	const w = await walkChain({ guides: path.resolve(guides), faction, race, cls, simDir: SIM, to });
	const goals = w.goals.filter((g) => g.lvl != null && g.lvl < to);
	const SERV = new Set(['train', 'vendor', 'sethome', 'getfp', 'repair', 'buy', 'learn', 'fly', 'hearth', 'goto', 'boat', 'note', 'level', 'die', 'use', 'equip', 'skill', 'talk']);
	const d = (a, b) => (!a || !b || a.c !== b.c ? Infinity : Math.hypot(a.wx - b.wx, a.wy - b.wy));
	let deaths = 0, grindSec = 0, trains = 0, trainTrips = 0;
	const trips = [], types = {};
	for (let i = 0; i < goals.length; i++) {
		const g = goals[i];
		types[g.t] = (types[g.t] || 0) + 1;
		if (g.t === 'die') deaths++;
		if (g.t === 'level' && g.timeAfter != null) grindSec += g.timeAfter - g.time;
		if (g.t === 'train') {
			trains++;
			// The trainer's place: the goal's own, else a goto right before it (a
			// "Walk to X" then "train class"); a bare `train class` after other work
			// trains where the player stands (no trip).
			let at = g.w || (i > 0 && goals[i - 1].t === 'goto' ? goals[i - 1].w : null);
			if (!at) continue;
			let j = i, k = i;
			while (j > 0 && (!goals[j - 1].w || d(goals[j - 1].w, at) <= 400)) j--;
			while (k + 1 < goals.length && (!goals[k + 1].w || d(goals[k + 1].w, at) <= 400)) k++;
			const stay = goals.slice(j, k + 1);
			// A trip: the stop holds only services and the route comes back near where it
			// came from (prev -> next shorter than prev -> stop): a detour made to train.
			let pj = j - 1, nk = k + 1;
			while (pj >= 0 && (goals[pj].t === 'level' || !goals[pj].w)) pj--;
			while (nk < goals.length && (goals[nk].t === 'level' || !goals[nk].w)) nk++;
			const prev = pj >= 0 ? goals[pj].w : null;
			const next = nk < goals.length ? goals[nk].w : null;
			const back = prev && next && d(prev, next) < d(prev, at);
			if (back && stay.every((x) => SERV.has(x.t) || x.q == null)) { trainTrips++; trips.push(`${g.lvl.toFixed(1)} ${g.file}:${g.line} ${Math.round(d(prev, next))}<${Math.round(d(prev, at))}`); }
		}
	}
	const s = r.returns.summary;
	const row = {
		guides, to, hours: r.hours, endLevel: r.endLevel, questsDone: r.background.questsDone, zoneChanges: r.background.zoneChanges,
		passedBy: r.passedBy.count, pbNever: r.passedBy.never, pbLater: r.passedBy.later,
		qPerVisit: +(r.background.questsDone / s.areaVisits).toFixed(2), areaVisits: s.areaVisits, returns: s.avoidableReturns, wastedTrips: s.wastedTrips, leftBehind: s.leftBehind, sameMob: s.sameMobAvoidable,
		deaths, trains, trainTrips, grindMin: Math.round(grindSec / 60),
	};
	console.log(Object.entries(row).map(([k, v]) => `${k}=${v}`).join(' '));
	if (process.env.V) { console.log('types', JSON.stringify(types)); console.log('trainTrips', trips); }
	if (jo > 0) fs.writeFileSync(JOUT, JSON.stringify({ row, judge: r, trips }, null, 1));
})().catch((e) => { console.error(e.stack); process.exitCode = 1; });
