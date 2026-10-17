'use strict';
// Cross-guide validation (docs/GUIDE_FORMAT.md, "Validation"): duplicate ids,
// `next` targets (known, and followable by the guide's faction, races and
// classes), quests turned in / worked on without an earlier accept in
// the guide or any guide chaining into it, accepts the guide's characters can
// never take, missing prerequisites, accepts above the plausible level,
// accepts closed by an exclusive quest taken earlier, accepts never turned in
// on a route, `complete` on quests without objectives, required elite work in
// Leveling guides, `|` in player-facing text, a `goto` placed right before a
// goal that already leads to the same place, and timed quest items carried
// longer than they last (timed.js).
//
// Our house rules (required elite work, the solo filter) are errors in our
// pack (`guides`) and warnings in every other.
//
// validateGuides(guides, data, diag) — guides are resolver output (resolve.js).
// validateSoloPolicy(guides, excluded, diag) — lint only: leveling goals on
// quests the simulator's solo filter excludes (tools/lib/sim/solo.js).
// validatePackFrames(guides, data, ours, ourData, diag) — another pack's map
// frames that differ from the ones our guides register.

const { applicable, maskExcludes, raceSides, characterKeys, whoLabel } = require('./conditions');
const { raceLabel, classLabel, RACE_BY_FILE } = require('../game/races');
const { blockingPrereqs } = require('../data/prereqs');
const SOLO = require('../sim/solo');
const { eliteWork } = require('./group');
const { PIPE_HINT } = require('../pack/manifest');
const { MAX_LEVEL, CUM_XP } = require('../game/xp');
const { checkTimedItems } = require('./timed');

// Quest XP is only part of what a questing route earns; mob kills on the way
// add roughly as much again. Generous on purpose: this only drives a warning.
const ROUTE_XP_FACTOR = 2;

function xpAt(level) {
	return CUM_XP[Math.max(1, Math.min(MAX_LEVEL, level))];
}

function levelAt(xp) {
	let l = 1;
	while (l < MAX_LEVEL && CUM_XP[l + 1] <= xp) l++;
	return l;
}

const OBJECTIVE_VERBS = new Set(['kill', 'collect', 'interact', 'use']);

function guideLayer(g) {
	return { factions: g.faction ? [g.faction] : null, races: g.races || null, classes: g.classes || null };
}

// A `next` option no character of guide g can follow: the races or classes
// of `other` (with what each race can be, from races.json) leave none of
// g's characters. -> { message, hint } | null. Unknown race names are not
// checked; a faction mismatch is reported on its own.
function followProblem(g, other, data) {
	if ([g, other].some((x) => (x.races || []).some((r) => !RACE_BY_FILE[r]))) return null;
	const classesOf = (r, s) => data.raceClasses(r, s);
	if (!characterKeys([guideLayer(g)], classesOf).size) return null;
	if (characterKeys([guideLayer(g), guideLayer(other)], classesOf).size) return null;
	const flags = `${g.races ? ` --race ${raceLabel(g.races[0])}` : ''}${g.classes ? ` --class ${classLabel(g.classes[0])}` : ''}`;
	const same = g.classes ? (g.races ? 'races and classes' : 'classes') : 'races';
	return {
		message: `no ${whoLabel(g)} character can follow ${other.id} (it is for ${whoLabel(other)} only)`,
		hint: `pick a guide for the same ${same}: \`polestar find --kind guide <zone>${flags}\``,
	};
}

// Elite work (group.js `eliteWork`): Leveling guides route solo characters,
// so it may appear only as an `optional` extra.
// Goals already reported as elite errors, so the lint solo policy skips them.
const eliteReported = new WeakSet();

function eliteTip(target) {
	return `in a Leveling guide make the goal \`optional\` with the tip "${target} is elite: grouping up is advised."`;
}

// Our house rules: errors in our pack, warnings in every other.
function houseRule(diag, g) {
	return g.pack === 'guides' ? diag.error.bind(diag) : diag.warn.bind(diag);
}

function hasPipe(s) {
	return typeof s === 'string' && s.includes('|');
}

// Header keys (as parsed) and the keyword the author writes them with.
const PIPE_HEADER = [
	['title', 'title'],
	['folder', 'folder'],
	['pitch', 'pitch'],
	['pros', 'pro'],
	['cons', 'con'],
	['author', 'author'],
];
// Names a goal line may give in quotes (parsed key -> what it is).
const PIPE_NAMES = [
	['title', 'the quest title'],
	['target', 'the target name'],
	['npcName', 'the NPC name'],
	['itemName', 'the item name'],
	['objName', 'the object name'],
	['spellName', 'the spell name'],
	['factionName', 'the faction name'],
	['achievementName', 'the achievement name'],
];

// Player-facing text exactly as the author wrote it (the parsed guide, so
// names filled in from data and defaults such as the pack's author are not
// reported): header title, folder, pitch, pros, cons and author; step titles
// and tips; goal texts, notes and quoted names (rewards included). Polestar
// shows it as written (every `|` is escaped when a guide registers), so a `|`
// prints literally.
function checkPipes(g, diag) {
	const ast = g._ast;
	const warn = (line, what) => diag.warn(ast.file, line, `${what} contains "|", which prints literally in game`, PIPE_HINT);
	const h = ast.header || {};
	for (const [key, keyword] of PIPE_HEADER) {
		const v = h[key];
		if (Array.isArray(v)) {
			// pro and con repeat: each entry at its own line.
			const at = ast.lines[key] || [];
			v.forEach((x, i) => hasPipe(x) && warn(at[i] || ast.lines[keyword] || ast.line, `\`${keyword}\``));
		} else if (hasPipe(v)) warn(ast.lines[keyword] || ast.line, `\`${keyword}\``);
	}
	for (const s of ast.steps || []) {
		if (hasPipe(s.title)) warn(s.line, 'the step title');
		if (hasPipe(s.tip)) warn(s.line, 'the step tip');
		for (const goal of s.goals) {
			if (hasPipe(goal.text)) warn(goal.line, 'the goal text');
			if (hasPipe(goal.note)) warn(goal.line, 'the goal note');
			for (const [key, what] of PIPE_NAMES) if (hasPipe(goal[key])) warn(goal.line, what);
			if ([...(goal.rewardChoices || []), ...(goal.rewardItems || [])].some((r) => hasPipe(r.itemName))) warn(goal.line, 'the item name');
		}
	}
}

// fn(map, guide, goal) for every map an emitted coordinate uses: the goal's
// own map/x/y and any coordinate list on it (smart-target `candidates`).
function forEachGoalMap(guides, fn) {
	for (const g of guides) {
		for (const s of g.steps) {
			for (const goal of s.goals) {
				if (goal.map !== undefined) fn(goal.map, g, goal);
				for (const v of Object.values(goal)) {
					if (!Array.isArray(v)) continue;
					for (const el of v) if (el && typeof el === 'object' && el.map !== undefined) fn(el.map, g, goal);
				}
			}
		}
	}
}

const FRAME_KEYS = ['c', 'left', 'right', 'top', 'bottom'];

// Another pack's Era frame for a map our guides also use, with other bounds
// (from other reference data): in game our frame wins, so the pack's
// coordinates on that map would land elsewhere. Once per map, at its first use.
function validatePackFrames(guides, data, ours, ourData, diag) {
	const ourFrames = new Map();
	forEachGoalMap(ours, (map) => {
		if (!ourFrames.has(map)) ourFrames.set(map, ourData.eraFrame(map));
	});
	const seen = new Set();
	forEachGoalMap(guides, (map, g, goal) => {
		if (seen.has(map)) return;
		seen.add(map);
		const mine = data.eraFrame(map);
		const theirs = ourFrames.get(map);
		if (!mine || !theirs || FRAME_KEYS.every((k) => mine[k] === theirs[k])) return;
		diag.warn(g._ast.file, goal._line, `map ${map}: this pack's Era frame differs from the one Polestar's guides register; in game Polestar's wins, so coordinates on this map may be off`);
	});
}

// The message for elite work (group.js `eliteWork`): a `kill` of an elite, or
// a `collect` of an item only elites drop. Null when the goal is not elite work.
function eliteGoal(goal, sides, data) {
	const elite = eliteWork(goal, sides, data);
	if (!elite) return null;
	if (goal.t === 'kill') return `\`kill\` npc ${goal.npc} (${elite.names[0]}) is elite; ${eliteTip(elite.names[0])}`;
	const item = `\`collect\` item ${goal.item}${goal.itemName ? ` (${goal.itemName})` : ''}`;
	return `${item} drops only from elites (${elite.names.join(', ')}); ${eliteTip(elite.names[0])}`;
}

// The characters a goal applies to, as "side|race|class" keys, narrowed by the
// quest's own race and class masks (so a class quest without `only` still
// applies to that class alone). Two goals can meet on one character only when
// their sets share a key.
function characters(layers, quest) {
	const set = applicable(layers);
	const out = new Set();
	for (const side of set.factions) {
		for (const race of set.races) {
			if (!raceSides(race).includes(side)) continue;
			for (const cls of set.classes) {
				const one = { races: [race], classes: [cls], factions: [side], unknownRace: !RACE_BY_FILE[race] };
				if (!quest || !maskExcludes(one, quest)) out.add(`${side}|${race}|${cls}`);
			}
		}
	}
	return out;
}

function meets(a, b) {
	for (const k of a) if (b.has(k)) return true;
	return false;
}

function minus(a, b) {
	const out = new Set();
	for (const k of a) if (!b.has(k)) out.add(k);
	return out;
}

function questName(data, id, title) {
	const q = data.quest(id);
	const t = (q && q.title) || title;
	return t ? `${id} (${t})` : String(id);
}

// A `goto` is redundant when the goal right after it (notes skipped) has its
// own location within GOTO_REDUNDANT_YARDS of the goto point: the arrow leads
// to that goal directly. The yards run to the edge of the goal's nearest spawn
// area (`spots`, radius r), else to its point. Kept: a goto followed by another
// goto (a path), by a goal without a location, an optional one or one for other
// characters (`only`), one on another map, or a kill or drop whose target has
// no known spawn (an instance boss placed at the entrance the goto names); a
// goto farther away (an approach over a long ride); gotos in steps that travel
// (`fly`, `hearth`).
const GOTO_REDUNDANT_YARDS = 200;
const TRAVEL_VERBS = new Set(['fly', 'hearth']);

// World position in yards of a compiled point on `map` (frame `f`: "e" Era,
// else live, read with the Era bounds when the live ones are unknown), or null
// when the map has no bounds.
function worldPoint(data, map, x, y, f) {
	const era = (data.mapFrames && data.mapFrames.era) || {};
	const live = (data.mapFrames && data.mapFrames.forever) || {};
	const b = f === 'e' ? era[map] : live[map] || era[map];
	if (!b) return null;
	return [b.left + ((b.right - b.left) * x) / 100, b.top + ((b.bottom - b.top) * y) / 100];
}

function goalLabel(goal) {
	const what = goal.target || goal.itemName || goal.npcName || goal.objName || goal.title || goal.text;
	return `\`${goal.t}${what ? ` ${what}` : ''}\``;
}

// A kill or collect whose target spawns nowhere in the data (inside an
// instance, new content): its point only stands in for the target.
function unspawnedTarget(data, goal) {
	if (goal.t === 'kill') return goal.npc === undefined || !data.spawns('npc', goal.npc).length;
	if (goal.t !== 'collect') return false;
	const it = goal.item !== undefined ? data.item(goal.item) : null;
	const drops = (it && it.drops) || {};
	return !['npc', 'object'].some((kind) => Object.keys(drops[kind] || {}).some((id) => data.spawns(kind, Number(id)).length));
}

function checkRedundantGotos(g, data, diag) {
	for (const step of g.steps) {
		if (step.goals.some((goal) => TRAVEL_VERBS.has(goal.t))) continue;
		step.goals.forEach((goto, i) => {
			if (goto.t !== 'goto' || goto.x === undefined) return;
			const next = step.goals.slice(i + 1).find((goal) => goal.t !== 'note');
			if (!next || next.t === 'goto' || next.x === undefined || next.optional || next.map !== goto.map || unspawnedTarget(data, next)) return;
			if (JSON.stringify(next.only || null) !== JSON.stringify(goto.only || null)) return;
			const at = worldPoint(data, goto.map, goto.x, goto.y, goto.f);
			if (!at) return;
			let yards = Infinity;
			for (const p of [{ x: next.x, y: next.y, r: 0 }, ...(next.spots || [])]) {
				const w = worldPoint(data, next.map, p.x, p.y, next.f);
				if (w) yards = Math.min(yards, Math.max(0, Math.hypot(w[0] - at[0], w[1] - at[1]) - (p.r || 0)));
			}
			if (yards > GOTO_REDUNDANT_YARDS) return;
			const label = goalLabel(next);
			diag.warn(
				g._ast.file,
				goto._line,
				`\`goto ${goto.x},${goto.y}\`${goto.text ? ` "${goto.text}"` : ''} sends the player where ${label} (line ${next._line}) already leads, ${Math.round(yards)} yards away`,
				`remove the goto: the arrow leads to ${label} directly`,
			);
		});
	}
}

function validateGuides(guides, data, diag) {
	const byId = new Map();
	for (const g of guides) {
		const ast = g._ast;
		if (byId.has(g.id)) {
			const first = byId.get(g.id)._ast;
			diag.error(ast.file, ast.line, `duplicate guide id "${g.id}" (also in ${first.file}:${first.line})`);
			continue;
		}
		byId.set(g.id, g);
	}
	// Predecessors through `next` and every route choice (`nextChoices`).
	const preds = new Map();
	for (const g of byId.values()) {
		for (const to of g.nextChoices || (g.next ? [g.next] : [])) {
			if (!byId.has(to)) {
				diag.error(g._ast.file, g._ast.lines.next, `\`next\` points to unknown guide "${to}"`, 'list guide ids with `polestar find --kind guide <text>`');
				continue;
			}
			const other = byId.get(to);
			if (g.faction && other.faction && other.faction !== g.faction) {
				diag.error(g._ast.file, g._ast.lines.next, `\`next\` offers ${other.faction} guide "${to}" after a ${g.faction} guide`);
			} else {
				const why = followProblem(g, other, data);
				if (why) diag.error(g._ast.file, g._ast.lines.next, why.message, why.hint);
			}
			if (!preds.has(to)) preds.set(to, []);
			preds.get(to).push(g);
		}
		if (g.nextChoices) {
			for (const to of g.nextChoices) {
				const other = byId.get(to);
				if (other && !other.pitch) diag.warn(other._ast.file, other._ast.line, `"${to}" is a route choice after "${g.id}" but has no \`pitch\`; the choice window shows its pitch, pros and cons`);
			}
		}
	}

	const ancestors = (g) => {
		const out = [];
		const seen = new Set([g.id]);
		const stack = [...(preds.get(g.id) || [])];
		while (stack.length) {
			const p = stack.pop();
			if (seen.has(p.id)) {
				if (p.id === g.id && !out.includes(p)) out.push(p);
				continue;
			}
			seen.add(p.id);
			out.push(p);
			stack.push(...(preds.get(p.id) || []));
		}
		return out;
	};

	const goalsOf = (g) => g.steps.flatMap((s) => s.goals.map((goal) => ({ step: s, goal })));

	// Route XP: entry = max(guide minLevel, best exit of any predecessor).
	const exitMemo = new Map();
	const entryXp = (g, visiting) => {
		let xp = xpAt(g.minLevel || 1);
		for (const p of preds.get(g.id) || []) {
			if (visiting.has(p.id)) continue;
			xp = Math.max(xp, exitXp(p, visiting));
		}
		return xp;
	};
	const walkXp = (g, start, onGoal) => {
		let xp = start;
		for (const { step, goal } of goalsOf(g)) {
			if (onGoal) onGoal(step, goal, xp);
			if (goal.t === 'turnin') {
				const q = data.quest(goal.quest);
				// Data XP, else the XP the turn-in line states (`xp <N>`).
				const qxp = q && q.xp > 0 ? q.xp : goal.rewards && goal.rewards.xp > 0 ? goal.rewards.xp : 0;
				if (qxp > 0) xp += qxp * ROUTE_XP_FACTOR;
			} else if (goal.t === 'level') xp = Math.max(xp, xpAt(goal.level));
		}
		return xp;
	};
	const exitXp = (g, visiting = new Set()) => {
		if (exitMemo.has(g.id)) return exitMemo.get(g.id);
		visiting.add(g.id);
		const out = walkXp(g, entryXp(g, visiting));
		visiting.delete(g.id);
		exitMemo.set(g.id, out);
		return out;
	};

	// Accept and turn-in goals with the characters they apply to, per guide.
	const questGoalMemo = new Map();
	const questGoals = (g) => {
		if (!questGoalMemo.has(g.id)) {
			const gl = guideLayer(g);
			const list = [];
			for (const { step, goal } of goalsOf(g)) {
				if (goal.quest === undefined || (goal.t !== 'accept' && goal.t !== 'turnin')) continue;
				list.push({ goal, chars: characters([gl, step._only, goal._only], data.quest(goal.quest)) });
			}
			questGoalMemo.set(g.id, list);
		}
		return questGoalMemo.get(g.id);
	};
	const successors = (g) => (g.nextChoices || (g.next ? [g.next] : [])).map((id) => byId.get(id)).filter(Boolean);
	// Characters for whom every route from the start of guide h turns quest q
	// in (null: every character, for a loop back into a guide being walked).
	const coveredMemo = new Map();
	const covered = (h, q, visiting = new Set()) => {
		const key = `${h.id}|${q}`;
		if (coveredMemo.has(key)) return coveredMemo.get(key);
		if (visiting.has(h.id)) return null;
		visiting.add(h.id);
		const next = successors(h);
		let after = next.length ? null : new Set();
		for (const s of next) {
			const c = covered(s, q, visiting);
			if (c) after = after ? new Set([...after].filter((k) => c.has(k))) : c;
		}
		visiting.delete(h.id);
		let out = null;
		if (after) {
			out = new Set(after);
			for (const t of questGoals(h)) if (t.goal.t === 'turnin' && t.goal.quest === q) for (const k of t.chars) out.add(k);
		}
		coveredMemo.set(key, out);
		return out;
	};

	for (const g of byId.values()) {
		const file = g._ast.file;
		checkPipes(g, diag);
		checkRedundantGotos(g, data, diag);
		const accepted = new Set();
		const turnedIn = new Set();
		const learned = new Set();
		// Quests accepted or turned in earlier on the path -> their character sets.
		const taken = new Map();
		const take = (t) => {
			if (!taken.has(t.goal.quest)) taken.set(t.goal.quest, []);
			taken.get(t.goal.quest).push(t.chars);
		};
		for (const a of ancestors(g)) {
			for (const { goal } of goalsOf(a)) {
				if (goal.t === 'accept') accepted.add(goal.quest);
				if (goal.t === 'turnin') turnedIn.add(goal.quest);
				if (goal.t === 'learn') learned.add(goal.spell);
			}
			for (const t of questGoals(a)) take(t);
		}
		const own = new Map(questGoals(g).map((t) => [t.goal, t]));
		// Quests handed in straight from the NPC's window (`turnin <id> direct`),
		// in this guide or the chain into it: they have no accept, and nothing
		// tracks their objectives. Gathered before the walk so a goal that comes
		// earlier in the file still gets the message for the right reason.
		const direct = new Set();
		for (const a of [...ancestors(g), g]) {
			for (const { goal } of goalsOf(a)) if (goal.t === 'turnin' && goal.direct) direct.add(goal.quest);
		}
		const gl = guideLayer(g);
		const leveling = g.category === 'Leveling';
		for (const { step, goal } of goalsOf(g)) {
			const ln = goal._line;
			const q = goal.quest !== undefined ? data.quest(goal.quest) : null;
			if (leveling && !goal.optional) {
				const elite = eliteGoal(goal, applicable([gl, step._only, goal._only]).factions, data);
				if (elite) {
					houseRule(diag, g)(file, ln, elite);
					eliteReported.add(goal);
				}
			}
			// A direct hand-in is offered like an accept, so its availability,
			// prerequisites and exclusive quests are checked the same way.
			const directTurnin = goal.t === 'turnin' && goal.direct === true;
			if (goal.t === 'accept' || directTurnin) {
				const set = applicable([gl, step._only, goal._only]);
				if (q) {
					const why = maskExcludes(set, q);
					if (why) {
						diag.error(file, ln, `quest ${goal.quest} (${goal.title}) is not available to any ${why === 'race' ? 'race' : 'class'} this ${goal._only ? 'goal' : 'step'} applies to`);
					}
					// Only blocking prerequisites count (tools/lib/data/prereqs.js): every
					// one of `all`, one of `any`; breadcrumbs never block.
					const { all, any } = blockingPrereqs(q, (id) => data.quest(id));
					// A prerequisite these characters cannot take is someone else's variant.
					const takeable = (p) => {
						const pq = data.quest(p);
						return !(pq && maskExcludes(set, pq));
					};
					const name = (p) => {
						const pq = data.quest(p);
						return pq && pq.title ? `${p} (${pq.title})` : String(p);
					};
					for (const p of all.filter((p) => !turnedIn.has(p) && takeable(p))) {
						diag.warn(file, ln, `quest ${goal.quest} needs ${name(p)} turned in first, but the chain never turns it in`);
					}
					if (any.length && !any.some((p) => turnedIn.has(p))) {
						const open = any.filter(takeable).map(name);
						if (open.length === 1) {
							diag.warn(file, ln, `quest ${goal.quest} needs ${open[0]} turned in first, but the chain never turns it in`);
						} else if (open.length > 1) {
							diag.warn(file, ln, `quest ${goal.quest} needs one of ${open.join(', ')} turned in first, but the chain turns in none of them`);
						}
					}
					// Exclusive quests (`excl`, Questie exclusiveTo): the game does not
					// offer this one while one of them is in the log or done.
					const mine = own.get(goal);
					for (const e of q.excl || []) {
						if ((taken.get(e) || []).some((chars) => meets(chars, mine.chars))) {
							diag.warn(file, ln, `quest ${questName(data, goal.quest, goal.title)} is not offered once ${questName(data, e)} is in the log or done, and the chain takes that quest earlier`);
						}
					}
				}
				if (directTurnin) {
					if (accepted.has(goal.quest)) {
						diag.error(file, ln, `\`turnin\` for quest ${goal.quest} is marked \`direct\`, but the chain accepts that quest earlier: drop \`direct\``);
					}
					turnedIn.add(goal.quest);
				} else {
					accepted.add(goal.quest);
				}
				take(own.get(goal));
			} else if (goal.t === 'turnin' || goal.t === 'complete' || (OBJECTIVE_VERBS.has(goal.t) && goal.quest !== undefined)) {
				if (!accepted.has(goal.quest)) {
					if (direct.has(goal.quest)) {
						diag.error(file, ln, `\`${goal.t}\` for quest ${questName(data, goal.quest, goal.title)}, which is handed in directly (\`turnin ${goal.quest} direct\`): it is never in the quest log, so nothing tracks its objectives. Get what it asks for with a plain \`buy\` or \`collect\`, without \`quest\``);
					} else {
						// A repeatable its giver takes back: likely handed in from the window.
						const rq = goal.t === 'turnin' ? q : null;
						const selfHandin = rq && rq.repeatable && rq.start && rq.end && (rq.start.npc || []).some((n) => (rq.end.npc || []).includes(n));
						diag.error(file, ln, `\`${goal.t}\` for quest ${goal.quest} that is never accepted earlier in this guide or a guide chaining into it`, selfHandin ? 'a repeatable quest its giver takes back straight from the quest window: write `turnin <id> direct`' : undefined);
					}
				}
				if (goal.t === 'turnin') {
					turnedIn.add(goal.quest);
					take(own.get(goal));
				}
				if (goal.t === 'complete' && q && Array.isArray(q.objectives) && q.objectives.length === 0) {
					diag.warn(file, ln, `\`complete\` for quest ${questName(data, goal.quest, goal.title)}, which has no objectives: the action is the turn-in; use \`turnin\``);
				}
			} else if (goal.t === 'learn') {
				learned.add(goal.spell);
			} else if (goal.t === 'craft' && !learned.has(goal.spell)) {
				const found = data.recipe(goal.spell);
				const r = found && found.recipe;
				// Recipes a trainer hands out free with the profession are known without a `learn`.
				const starter = r && r.source === 'trainer' && Number(r.learnedAt) <= 1 && r.cost !== undefined && Number(r.cost) === 0;
				if (!starter) {
					diag.warn(file, ln, `\`craft\` ${goal.spell} (${goal.spellName || 'unknown recipe'}) before any \`learn ${goal.spell}\` earlier in this guide or a guide chaining into it`);
				}
			}
		}

		// Accepts (not `optional`) the route never turns in: later in this guide,
		// else on every route after it, checked per route choice.
		const qg = questGoals(g);
		qg.forEach((a, i) => {
			if (a.goal.t !== 'accept' || a.goal.optional || !a.chars.size) return;
			let open = a.chars;
			for (const t of qg.slice(i + 1)) if (t.goal.t === 'turnin' && t.goal.quest === a.goal.quest) open = minus(open, t.chars);
			if (!open.size) return;
			const name = questName(data, a.goal.quest, a.goal.title);
			const some = (left) => (left.size < a.chars.size ? ' for some of the characters it applies to' : '');
			const routes = successors(g).map((s) => {
				const c = covered(s, a.goal.quest);
				return { s, left: c ? minus(open, c) : new Set() };
			});
			// A next guide whose race, class or faction leaves out every character
			// still holding the quest: its turn-ins never count for them.
			const outside = (r) => !meets(r.left, characters([guideLayer(r.s)]));
			const why = (r, it) => (outside(r) ? ` (${it} is for ${whoLabel(r.s)} only, so its turn-ins do not count)` : '');
			const hint = (excluded) =>
				`turn it in later in this guide${excluded ? ', or pick a `next` guide these characters can follow' : ' or in a guide after it'}, or make the accept \`optional\` when the player may leave it`;
			const failing = routes.filter((r) => r.left.size);
			if (!routes.length || failing.length === routes.length) {
				const left = new Set(routes.length ? failing.flatMap((r) => [...r.left]) : open);
				const reasons = failing.filter(outside).map((r) => why(r, `"${r.s.id}"`).slice(2, -1));
				const because = reasons.length ? ` (${reasons.join('; ')})` : '';
				diag.warn(file, a.goal._line, `quest ${name} is accepted but never turned in later in this guide or a guide after it${some(left)}${because}`, hint(reasons.length > 0));
				return;
			}
			for (const r of failing) diag.warn(file, a.goal._line, `quest ${name} is accepted but never turned in on the route through "${r.s.id}"${some(r.left)}${why(r, 'it')}`, hint(outside(r)));
		});

		// The route's level at each goal (when XP data exists): accepts above
		// it warn, and the timed-item check times kills at it.
		const levels = new Map();
		if (data.hasXp) {
			walkXp(g, entryXp(g, new Set([g.id])), (step, goal, xp) => {
				const reach = levelAt(xp);
				levels.set(goal, reach);
				if (goal.t !== 'accept' || !(goal.minLevel > 0)) return;
				if (goal.minLevel > reach) {
					diag.warn(file, goal._line, `quest ${goal.quest} needs level ${goal.minLevel}, but the route plausibly reaches only level ${reach} here`);
				}
			});
		}
		checkTimedItems(g, data, diag, {
			levelAt: (goal) => levels.get(goal),
			characters: (step, goal) => characters([gl, step._only, goal._only], goal.quest !== undefined ? data.quest(goal.quest) : null),
			meets,
		});
	}
}

// Leveling guides route solo characters: a goal that needs a quest the
// simulator's solo filter excludes in a solo category (or as a profession
// quest) should be `optional`; an elite one must be (an error, unless the
// goal was already reported as elite work). `excluded` maps a faction to the
// world's exclusions by quest id ({ title, reason, category }, world.excluded
// in data/sim/world-<faction>.json); a missing faction is not checked. A
// `turnin <id> direct` is no repeatable to grind: the route hands it in once,
// for what it opens (Distracting Jarven frees the barrel).
const SOLO_GOALS = new Set(['accept', 'turnin', 'complete', ...OBJECTIVE_VERBS]);

function soloExclusion(e) {
	if (e.category) return SOLO.CATEGORIES.includes(e.category) ? e.category : null;
	return e.reason === 'profession' ? 'profession' : null;
}

function validateSoloPolicy(guides, excluded, diag) {
	for (const g of guides) {
		if (g.category !== 'Leveling') continue;
		const gl = guideLayer(g);
		for (const step of g.steps) {
			for (const goal of step.goals) {
				if (goal.optional || goal.quest === undefined || !SOLO_GOALS.has(goal.t) || eliteReported.has(goal)) continue;
				for (const side of applicable([gl, step._only, goal._only]).factions) {
					const e = excluded[side] && excluded[side].get(goal.quest);
					const why = e && soloExclusion(e);
					if (!why || (why === 'repeatable' && goal.direct)) continue;
					const title = e.title || goal.title;
					if (why === 'elite') {
						houseRule(diag, g)(g._ast.file, goal._line, `quest ${goal.quest} (${title}) is elite (solo filter: ${e.reason}); ${eliteTip(title)}`);
					} else {
						diag.warn(g._ast.file, goal._line, `quest ${goal.quest} (${title}) is excluded from solo leveling (${why}: ${e.reason}); make the goal \`optional\``);
					}
					break;
				}
			}
		}
	}
}

module.exports = { validateGuides, validateSoloPolicy, validatePackFrames, forEachGoalMap, xpAt, levelAt };
