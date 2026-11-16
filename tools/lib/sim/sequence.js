'use strict';
// Guide sequences (normalized events from tools/lib/sim/baselines) and
// package routes as flat step lists for Evaluator.evaluateSequence.
//
// Events: { t: 'accept'|'turnin'|'complete', q, npc?, object? } and { t: 'level', level, xp }.
// - accept: at the quest's giver, the one the event names when the quest has
//   several (a quest-starting item costs its kills);
// - complete: every objective site of the quest, in world order;
// - turnin: any site not yet done, then the ender (the named one, as for accept);
// - level: a checkpoint (grind to it when honoring checkpoints, else only marked);
// - dungeon quests (dungeon family): their objectives are the dungeon run,
//   inserted before the first complete/turn-in that needs it.
// Quests the character cannot take or the world lacks are listed in `unknown`.

const { K_ACCEPT, K_TASK, K_TURNIN, K_GRIND, K_DUNGEON } = require('./run');

// The point of the giver or ender an event names (`npc`/`object`), when the
// quest has more than one; else null (the world's own giver or ender).
function named(alts, qi, e) {
	const key = e.npc != null ? `npc:${e.npc}` : e.object != null ? `object:${e.object}` : null;
	const m = key && alts && alts.get(qi);
	return (m && m.get(key)) ?? null;
}

function compileSequence(run, events) {
	const kind = [];
	const q = [];
	const task = [];
	const pt = [];
	const unknown = new Set();
	const guides = [];
	const push = (k, a, b, c) => {
		kind.push(k);
		q.push(a);
		task.push(b);
		pt.push(c);
	};
	const ran = new Set();
	const runDungeon = (d) => {
		if (d < 0 || ran.has(d)) return;
		ran.add(d);
		push(K_DUNGEON, d, -1, run.dungeons[d].pt);
	};
	// Quests the sequence accepts: a dungeon quest's objectives run the dungeon only once the route took it
	// (a hand-in step behind `when complete` for a dungeon the character did not choose runs nothing).
	const took = new Set();
	const tasksOf = (qi) => {
		const d = run.qDungeon ? run.qDungeon[qi] : -1;
		if (d >= 0) return took.has(qi) ? runDungeon(d) : undefined;
		for (let t = run.qTask0[qi]; t < run.qTask1[qi]; t++) push(K_TASK, qi, t, run.taskPt[t]);
	};
	for (const e of events) {
		if (e.t === 'guide') {
			guides.push({ i: kind.length, title: e.title, zone: e.zone || null, levels: e.levels || null });
			continue;
		}
		if (e.t === 'level') {
			if (e.level >= 1 && e.level <= 60) push(K_GRIND, e.level, Math.max(0, Math.round(e.xp || 0)), -1);
			continue;
		}
		const qi = run.qIndex.get(Number(e.q));
		if (qi == null) {
			unknown.add(Number(e.q));
			continue;
		}
		if (e.t === 'accept') {
			took.add(qi);
			push(K_ACCEPT, qi, run.qAccept[qi], named(run.qGiverAlt, qi, e) ?? run.qGiver[qi]);
		} else if (e.t === 'complete') tasksOf(qi);
		else if (e.t === 'turnin') {
			tasksOf(qi);
			push(K_TURNIN, qi, -1, named(run.qEnderAlt, qi, e) ?? run.qEnder[qi]);
		}
	}
	return {
		kind: Int32Array.from(kind), q: Int32Array.from(q), task: Int32Array.from(task), pt: Int32Array.from(pt),
		unknown: [...unknown].sort((a, b) => a - b), guides,
	};
}

// A package route as a sequence (same steps the route evaluator runs).
function routeSequence(run, route) {
	const kind = [];
	const q = [];
	const task = [];
	const pt = [];
	for (const p of route) {
		for (let s = run.pkgStart[p]; s < run.pkgEnd[p]; s++) {
			kind.push(run.sKind[s]);
			q.push(run.sQuest[s]);
			task.push(run.sTask[s]);
			pt.push(run.sPt[s]);
		}
	}
	return { kind: Int32Array.from(kind), q: Int32Array.from(q), task: Int32Array.from(task), pt: Int32Array.from(pt), unknown: [], guides: [] };
}

module.exports = { compileSequence, routeSequence };
