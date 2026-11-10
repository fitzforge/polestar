'use strict';
// Quest prerequisites in route order, branch by branch. Every path through
// the leveling guides (a start guide, then each `next` option in turn, until
// the path comes back to a guide it already holds) is played as each race and
// class it is for. An accept, or a `direct` hand-in, needs its blocking
// prerequisites (tools/lib/data/prereqs.js: every one of `all`, one of `any`)
// handed in by an earlier line that the same character plays: steps and goals
// whose `only` lets the character in and whose `when` holds. `when group` is
// played both ways (the solo route and the group one).
//
// Lint's check (rust/crates/forge-guide/src/validate.rs) counts a hand-in
// anywhere in the guides leading into a guide, from any start and for any race.
// A giver doesn't offer a Human's quest because a Night Elf's start handed in its
// prerequisite, so here each path and character is played alone.
//
//   const { prereqOrder } = require('./prereq-order');
//   prereqOrder(guides, data)
//   // -> [{ guide, file, line, quest, title, missing: [ids], any, optional, path: [guide ids], race, cls, groups }]
//   //    one per accept line and missing set (the first path and character it shows on)

const { blockingPrereqs } = require('../data/prereqs');
const { RACE_FILES, RACE_BY_FILE } = require('../game/races');
const { questOpen, raceBit } = require('../sim/run');
const { goalLines, whenHolds, fits } = require('../playtest-honest');

const FACTIONS = ['Alliance', 'Horde'];

function leveling(g) {
	return (g.category == null || g.category === 'Leveling') && FACTIONS.includes(g.faction);
}

// A path's races: the start's `race` header, else its faction's races.
function racesOf(g) {
	const named = Array.isArray(g.races) ? g.races.filter((r) => RACE_FILES.includes(r) && RACE_BY_FILE[r].sides[g.faction] !== undefined) : [];
	return named.length ? named : RACE_FILES.filter((r) => RACE_BY_FILE[r].sides[g.faction] !== undefined);
}

// Every path from each start: guides no other leveling guide leads to (a
// cycle with no way in starts at its first guide).
function paths(guides) {
	const list = guides.filter(leveling);
	const byId = new Map(list.map((g) => [g.id, g]));
	const options = (g) => (g.nextChoices && g.nextChoices.length ? g.nextChoices : g.next ? [g.next] : []).filter((id) => byId.has(id));
	const into = new Set(list.flatMap(options));
	const out = [];
	const reached = new Set();
	const walk = (path) => {
		const g = path[path.length - 1];
		reached.add(g.id);
		const next = options(g).filter((id) => !path.some((p) => p.id === id));
		if (!next.length) out.push(path);
		for (const id of next) walk([...path, byId.get(id)]);
	};
	for (const g of list) if (!into.has(g.id)) walk([g]);
	for (const g of list) if (!reached.has(g.id)) walk([g]);
	return out;
}

function playPath(path, data, persona, groups, report) {
	const rbit = raceBit(persona.race, {}, persona.faction);
	const open = (id) => {
		const q = data.quests[id];
		return !q || questOpen(q, persona.faction, rbit, persona.cls);
	};
	const log = new Set();
	const w = { done: new Set(), held: (q) => log.has(q), has: () => true, level: 1, groups, bound: null };
	const questOf = (id) => data.quests[id] || null;
	for (const g of path) {
		w.level = Math.max(w.level, g.minLevel || 1);
		const astSteps = (g._ast && g._ast.steps) || [];
		g.steps.forEach((s, si) => {
			if (!fits(s.only, persona) || !whenHolds(w, s.when)) return;
			const lines = goalLines(astSteps[si], s);
			s.goals.forEach((x, gi) => {
				if (!fits(x.only, persona)) return;
				if (x.t === 'level') w.level = Math.max(w.level, Math.floor(x.level || 0));
				const direct = x.t === 'turnin' && x.direct === true;
				if (x.t === 'accept' || direct) {
					const q = data.quests[x.quest];
					if (q && open(x.quest)) {
						const { all, any } = blockingPrereqs(q, questOf);
						const missing = all.filter((p) => !w.done.has(p) && open(p));
						const anyOpen = any.filter(open);
						const anyMissing = any.length && !any.some((p) => w.done.has(p)) && anyOpen.length;
						if (missing.length || anyMissing) report(g, lines[gi] || (astSteps[si] && astSteps[si].line) || 0, x, anyMissing ? [...missing, ...anyOpen] : missing, !!anyMissing && !missing.length);
					}
					if (direct) w.done.add(x.quest);
					else log.add(x.quest);
				} else if (x.t === 'turnin') {
					log.delete(x.quest);
					w.done.add(x.quest);
				} else if (x.t === 'abandon') log.delete(x.quest);
			});
		});
	}
}

function prereqOrder(guides, data) {
	const out = new Map();
	for (const path of paths(guides)) {
		const start = path[0];
		for (const race of racesOf(start)) {
			const own = data.raceClasses ? data.raceClasses(race, start.faction) : [];
			const classes = Array.isArray(start.classes) && start.classes.length ? own.filter((c) => start.classes.includes(c)) : own;
			for (const cls of classes.length ? classes : [null]) {
				const persona = { race, faction: start.faction, cls };
				for (const groups of ['skip', 'do']) {
					playPath(path, data, persona, groups, (g, line, x, missing, any) => {
						const file = (g._ast && g._ast.file) || g.id;
						const k = `${file}:${line}:${x.quest}:${missing.join(',')}`;
						if (out.has(k)) return;
						out.set(k, { guide: g.id, file, line, quest: x.quest, title: (data.quests[x.quest] || {}).title || '', missing, any, optional: !!x.optional, path: path.map((p) => p.id), race, cls, groups });
					});
				}
			}
		}
	}
	return [...out.values()].sort((a, b) => (a.file < b.file ? -1 : a.file > b.file ? 1 : a.line - b.line));
}

module.exports = { prereqOrder, paths };
