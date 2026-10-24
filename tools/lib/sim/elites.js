'use strict';
// Elite quests for a party (docs/SIMULATION.md, "Elite quests in the
// guides"): what each elite quest of the group world (--elites) is worth to
// a party on its searched route, and where it goes in our leveling guides.
//
// Worth: the route of a `sim run --party N --elites` result scored with the
// quest left out of the world (and with it what only it opens), against the
// route as it is. What the party loses without it is what it saves.
//
// Place: the chain lint would ask for (chainAt), as a block of steps after
// the first step of the faction's Leveling guides that visits the chain's
// first giver with every prerequisite outside it turned in before. Every
// step is `when group <quest>` (the elite quest, prerequisites and all), so
// the guide asks once and the solo route is unchanged. --apply writes the
// blocks and lints, taking out a block lint reports in (applyChecked). The
// lines are a draft for an author: `playtest --group do` plays them, a
// recording or a play checks the order.

const fs = require('node:fs');
const path = require('node:path');
const sim = require('./index');
const { compileRun, makeTables } = require('./run');
const { Evaluator } = require('./evaluate');
const { isElite } = require('../dsl/group');
const { blockingPrereqs } = require('../data/prereqs');
const { applicable, maskExcludes } = require('../dsl/conditions');

// Map distance (percent of the map) within which a step counts as at a giver.
const PLACE_NEAR = 3;
// Levels a guide may be below or above an elite quest's level and still take it.
const LEVELS_UNDER = 2;
const LEVELS_OVER = 4;
// The objective kinds a draft writes a goal for.
const WRITTEN = new Set(['kill', 'item', 'object']);

// res: a `sim run --elites` result; world: the group world.
// -> [{ id, title, zone, level, seconds }], most worth first, those worth
// more than `min` seconds.
function worth({ world, res, race, cls = null, params, min = 60 }) {
	const score = (w) => {
		const run = compileRun(w, { race, cls, family: 'solo' });
		const ev = new Evaluator(run, makeTables(run, params), { catchUp: true });
		return ev.evaluate(sim.routeFromKeys(run, res.best.route)).seconds;
	};
	const base = score(world);
	const out = [];
	for (const q of world.quests) {
		if (!q.elite) continue;
		const without = score({ ...world, quests: world.quests.filter((x) => x.id !== q.id) });
		if (without - base > min) out.push({ id: q.id, title: q.title || null, zone: q.zone, level: q.level, seconds: without - base });
	}
	return out.sort((a, b) => b.seconds - a.seconds);
}

const near = (goal, at) => goal.map === at.map && goal.x != null && Math.hypot(goal.x - at.x, goal.y - at.y) <= PLACE_NEAR;

// Where the quest's giver or ender is (an NPC, else an object: a WANTED
// poster): { kind, id, map, x, y } from the data's first spawn, or null.
function placeOf(data, who) {
	for (const kind of ['npc', 'object']) {
		for (const id of (who && who[kind]) || []) {
			const s = data.spawns(kind, id)[0];
			if (s) return { kind, id, map: s.map, x: s.pts[0][0], y: s.pts[0][1] };
		}
	}
	return null;
}

// The elites a quest's objectives need: their names, for the tip.
function eliteNames(data, objectives, sides) {
	const names = new Set();
	for (const o of objectives) {
		if (o.kind === 'kill') {
			const n = data.npc(o.id);
			if (n && isElite(n.rank, n.faction, sides)) names.add(n.name);
		} else if (o.kind === 'item') {
			const drops = ((data.item(o.id) || {}).drops || {}).npc || {};
			for (const id of Object.keys(drops)) {
				const n = data.npc(Number(id));
				if (n && isElite(n.rank, n.faction, sides)) names.add(n.name);
			}
		}
	}
	return [...names];
}

// The chain for quest id at one place on the route, prerequisites first, as
// lint checks it (validate.js): every blocking prerequisite in `all`, one of
// `any`; one these characters (`set`) cannot take is another race's or
// class's. `done`: quests turned in on the route before this place; `later`:
// quests a guide turns in elsewhere (not before here), which this place
// cannot have. -> { chain } or { why }.
function chainAt(data, id, { done, later, set }) {
	const chain = [];
	const seen = new Set();
	const takeable = (p) => {
		const q = data.quest(p);
		return !!q && !maskExcludes(set, q);
	};
	const visit = (qid) => {
		if (done.has(qid) || seen.has(qid)) return null;
		seen.add(qid);
		const q = data.quest(qid);
		if (!q) return `${qid} is not in the reference data`;
		if (maskExcludes(set, q)) return `${qid} is not for every character of the guide`;
		if (later.has(qid)) return `it needs ${qid}, which the guides turn in elsewhere`;
		const { all, any } = blockingPrereqs(q, (x) => data.quest(x));
		for (const p of all.filter(takeable)) {
			const why = visit(p);
			if (why) return why;
		}
		const open = any.filter(takeable);
		if (open.length && !open.some((p) => done.has(p))) {
			const why = visit(open.find((p) => !later.has(p)) || open[0]);
			if (why) return why;
		}
		chain.push(qid);
		return null;
	};
	const why = visit(id);
	return why ? { why } : { chain };
}

// The guides that lead into g by `next` (as lint walks them).
function predecessors(guides) {
	const byId = new Map(guides.map((g) => [g.id, g]));
	const preds = new Map();
	for (const g of guides) {
		for (const to of g.nextChoices || (g.next ? [g.next] : [])) {
			if (!byId.has(to)) continue;
			if (!preds.has(to)) preds.set(to, []);
			preds.get(to).push(g);
		}
	}
	return (g) => {
		const out = [];
		const seen = new Set([g.id]);
		const stack = [...(preds.get(g.id) || [])];
		while (stack.length) {
			const p = stack.pop();
			if (seen.has(p.id)) continue;
			seen.add(p.id);
			out.push(p);
			stack.push(...(preds.get(p.id) || []));
		}
		return out;
	};
}

// The steps for one quest, as { who, lines }: accept at its giver (left out
// when the route holds it already: `accepted`), its objectives, the turn-in
// at its ender. `who` names the NPC or object a step is at (null for the
// objectives), so steps at one place can be merged (mergeSteps).
function questSteps(data, faction, id, accepted = new Set()) {
	const quest = data.quest(id);
	const objectives = data.questObjectives(id);
	const elites = eliteNames(data, objectives, [faction]);
	const who = (end) => {
		const p = placeOf(data, end);
		return p ? `${p.kind}:${p.id}` : null;
	};
	const work = objectives.map((o) => (o.kind === 'kill' ? `  kill ${o.id} quest ${id}.${o.index}` : o.kind === 'item' ? `  collect ${o.id} quest ${id}.${o.index}` : o.kind === 'object' ? `  interact ${o.id} quest ${id}.${o.index}` : `  # ${id}.${o.index}: ${o.kind} ${o.name || ''}: write this goal by hand`));
	const out = [];
	if (!accepted.has(id)) out.push({ who: who(quest.start), title: quest.title, lines: [`  accept ${id}`] });
	if (work.length) out.push({ who: null, title: quest.title, lines: [...(elites.length ? [`  tip ${elites[0]} is elite: grouping up is advised.`] : []), ...work] });
	out.push({ who: who(quest.end), title: quest.title, lines: [`  turnin ${id}`] });
	return out;
}

// Steps at the same NPC or object one after the other become one (a turn-in
// and the follow-up's accept). -> guide lines, every step `when group <quest>`
// for the elite quest `quest` the block is for.
function mergeSteps(steps, quest) {
	const merged = [];
	for (const s of steps) {
		const last = merged[merged.length - 1];
		if (last && s.who && last.who === s.who) last.lines.push(...s.lines);
		else merged.push({ ...s, lines: [...s.lines] });
	}
	return merged.flatMap((s) => [`step ${s.title}`, `  when group ${quest}`, ...s.lines, '']);
}

// The draft for quest q (a worth() row): its chain as a block of steps, after
// the first step of the faction's Leveling guides (levels within
// LEVELS_UNDER/LEVELS_OVER) that visits the chain's first giver (a goal at
// that NPC or object, or within PLACE_NEAR of it) and has every prerequisite
// outside the chain turned in before it. -> { id, title, seconds, file,
// guide, after (step line), stepTitle, chain, lines, steps(chain) } or
// { id, why }.
function place({ guides, data, faction, q, ancestorsOf, turnedInAnywhere }) {
	const quest = data.quest(q.id);
	if (!quest) return { id: q.id, why: 'not in the reference data' };
	if (quest.classes) return { id: q.id, why: 'a class quest' };
	let why = 'no leveling guide visits its giver at its level';
	for (const g of guides) {
		if (g.category !== 'Leveling' || (g.faction && g.faction !== faction)) continue;
		const set = applicable([{ factions: g.faction ? [g.faction] : [faction], races: g.races || null, classes: g.classes || null }]);
		const done = new Set();
		const accepted = new Set();
		const take = (goal) => {
			if (goal.t === 'turnin') {
				done.add(goal.quest);
				accepted.delete(goal.quest);
			} else if (goal.t === 'accept') accepted.add(goal.quest);
		};
		for (const a of ancestorsOf(g)) for (const s of a.steps) s.goals.forEach(take);
		for (const step of g.steps) {
			step.goals.forEach(take);
			const later = { has: (id) => turnedInAnywhere.has(id) && !done.has(id) };
			const r = chainAt(data, q.id, { done, later, set });
			if (r.why) {
				why = r.why;
				continue;
			}
			const { chain } = r;
			// An objective with no goal to write (an event, a spell to cast) needs an author.
			const odd = chain.flatMap((id) => data.questObjectives(id).filter((o) => !WRITTEN.has(o.kind)).map((o) => `${id} has an objective of kind ${o.kind}`));
			if (odd.length) return { id: q.id, why: `${odd[0]}, which needs writing by hand` };
			const level = Math.max(...chain.map((id) => (data.quest(id) || {}).level || 0));
			if (level < (g.minLevel || 1) - LEVELS_UNDER || level > (g.maxLevel || 60) + LEVELS_OVER) break;
			const giver = placeOf(data, data.quest(chain[0]).start);
			if (!giver) return { id: q.id, why: `the giver of ${chain[0]} has no spawn in the data (an item starts it)` };
			const at = (goal) => (giver.kind === 'npc' && goal.npc === giver.id) || near(goal, giver);
			if (!step.goals.some(at)) continue;
			const held = new Set(accepted);
			const steps = (ids) => mergeSteps(ids.flatMap((id) => questSteps(data, faction, id, held)), q.id);
			return { id: q.id, title: quest.title, seconds: q.seconds, guide: g.id, file: g._ast && g._ast.file, after: step._line, stepTitle: step.title, chain, lines: steps(chain), steps };
		}
	}
	return { id: q.id, why };
}

// The last line of the step whose `step` line is `line` (1-based): its last
// indented line before the next step, section comment or end of file.
function stepEnd(lines, line) {
	let last = line;
	for (let i = line; i < lines.length; i++) {
		const l = lines[i];
		if (/^\S/.test(l)) break;
		if (l.trim()) last = i + 1;
	}
	return last;
}

// Write the drafts into their guide files, each chain's block after its step
// (a quest two drafts share goes in with the first). `texts`: file -> its
// text before any draft (read when missing). -> [{ id, file, from, to }]: the
// lines (1-based) each block holds in the written file.
function applyDrafts(drafts, root = process.cwd(), texts = new Map()) {
	const byFile = new Map();
	const taken = new Set();
	for (const d of drafts) {
		if (d.why || !d.file) continue;
		const chain = d.chain.filter((id) => !taken.has(id));
		if (!chain.length) continue;
		for (const id of chain) taken.add(id);
		if (!byFile.has(d.file)) byFile.set(d.file, []);
		byFile.get(d.file).push({ ...d, chain });
	}
	const blocks = [];
	for (const [file, list] of byFile) {
		const full = path.resolve(root, file);
		if (!texts.has(file)) texts.set(file, fs.readFileSync(full, 'utf8'));
		const lines = texts.get(file).split('\n');
		const ins = list.map((d, i) => ({ d, at: stepEnd(lines, d.after), i, text: ['', `# Group quests (sim elites): ${d.title}, about ${fmtMin(d.seconds)} saved for a party`, ...d.steps(d.chain).slice(0, -1)] }));
		// Top down in draft order, each block shifted by those above it.
		ins.sort((a, b) => a.at - b.at || a.i - b.i);
		let shift = 0;
		for (const x of ins) {
			blocks.push({ id: x.d.id, file, from: x.at + shift + 1, to: x.at + shift + x.text.length });
			shift += x.text.length;
		}
		// From the bottom up so line numbers hold; at one place, in draft order.
		for (const x of [...ins].reverse()) lines.splice(x.at, 0, ...x.text);
		fs.writeFileSync(full, lines.join('\n'));
	}
	return blocks;
}

// Lint our guides (lint --format json): -> [{ file, line, severity, message }].
function lintDiagnostics(root = process.cwd()) {
	const { spawnSync } = require('node:child_process');
	const r = spawnSync(process.execPath, [path.join(root, 'tools', 'polestar.js'), 'lint', '--format', 'json'], { cwd: root, encoding: 'utf8', maxBuffer: 1 << 28 });
	return JSON.parse(r.stdout).diagnostics;
}

// Apply the drafts, then lint: a block lint reports anything in is taken out
// again (its why says what), until lint reports nothing in a block. New
// diagnostics outside the blocks (a quest a block takes earlier than the
// route did) are returned for the author. -> { files, dropped, outside }.
function applyChecked(drafts, root = process.cwd(), lint = lintDiagnostics) {
	const key = (x) => `${x.file}\t${x.severity}\t${x.message}`;
	const before = new Set(lint(root).map(key));
	const texts = new Map();
	const dropped = [];
	let live = drafts.filter((d) => !d.why);
	for (;;) {
		const blocks = applyDrafts(live, root, texts);
		const diags = lint(root);
		const bad = new Map();
		for (const x of diags) {
			const b = blocks.find((b) => b.file === x.file && x.line >= b.from && x.line <= b.to);
			if (b && !bad.has(b.id)) bad.set(b.id, `lint: ${x.message}`);
		}
		if (!bad.size) {
			const outside = diags.filter((x) => !before.has(key(x)));
			return { files: [...new Set(blocks.map((b) => b.file))], dropped, outside };
		}
		for (const [id, why] of bad) dropped.push({ id, why });
		live = live.filter((d) => !bad.has(d.id));
		for (const [file, text] of texts) fs.writeFileSync(path.resolve(root, file), text);
	}
}

const fmtMin = (s) => `${(s / 60).toFixed(0)} min`;

function draftText(drafts, partySize) {
	const out = [];
	for (const d of drafts) {
		if (d.why) {
			out.push(`# ${d.id}: left out (${d.why})`);
			continue;
		}
		out.push(`# ${d.file}: ${d.id} ${d.title}, saves ${fmtMin(d.seconds)} for a party of ${partySize}${d.chain.length > 1 ? ` (with ${d.chain.slice(0, -1).join(', ')} first)` : ''}`);
		out.push(`#   after step "${d.stepTitle}" (line ${d.after}):`, ...d.lines);
	}
	return out.join('\n');
}

async function command(args, o) {
	const faction = sim.normFaction(args.faction);
	const cls = sim.normClass(args.class);
	const race = args.race || sim.START_RACES[faction][0];
	const simDir = o.simDir || sim.DEFAULTS.simDir;
	const objective = o.objective || 'time';
	// The group world's result (--elites is implied).
	const tag = o.tag && o.tag.endsWith('elites') ? o.tag : o.tag ? `${o.tag}-elites` : 'elites';
	const file = sim.resultFile(simDir, faction, race, cls, 'solo', objective, tag);
	if (!fs.existsSync(file)) {
		console.error(`sim elites: no result ${path.relative(process.cwd(), file)}: run \`sim run --faction ${faction.toLowerCase()} --race ${race} --elites\` with the same --party first`);
		return 1;
	}
	const { world } = await sim.loadWorld({ ...o, faction, variant: 'group' });
	const res = JSON.parse(fs.readFileSync(file, 'utf8'));
	sim.assertFresh(res, world, file);
	const { mean } = sim.paramsFor(simDir, cls, objective, o.overrides || {});
	const rows = worth({ world, res, race, cls, params: mean, min: (args.min ? Number(args.min) : 5) * 60 });
	const { findGuideFiles, compileSources, OFFICIAL_DIR } = require('../dsl/project');
	const { loadData } = require('../dsl/data');
	const data = loadData(o.dataDir || sim.DEFAULTS.dataDir);
	const files = findGuideFiles(OFFICIAL_DIR);
	const { guides } = compileSources(files.map((f) => ({ file: path.join('guides', f), source: f, text: fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8') })), data);
	// Quests a guide line turns in are done on the plain route; one it only
	// accepts (and leaves) needs the rest of its steps.
	const goals = guides.flatMap((g) => g.steps.flatMap((s) => s.goals));
	const turnedInAnywhere = new Set(goals.filter((x) => x.t === 'turnin').map((x) => x.quest));
	const ancestorsOf = predecessors(guides);
	const drafts = rows.filter((r) => !turnedInAnywhere.has(r.id)).map((q) => place({ guides, data, faction, q, ancestorsOf, turnedInAnywhere }));
	const party = mean.partySize || 1;
	console.log(`${faction} ${race}, party of ${party}: ${rows.length} elite quests save more than ${args.min || 5} min each; ${rows.length - drafts.length} are in the guides already`);
	const text = draftText(drafts, party);
	const out = path.join(simDir, 'elites', `${path.basename(file, '.json')}.guide-draft`);
	fs.mkdirSync(path.dirname(out), { recursive: true });
	fs.writeFileSync(out, `${text}\n`);
	console.log(text);
	console.log(`wrote ${path.relative(process.cwd(), out)}`);
	if (args.apply) {
		const { files, dropped, outside } = applyChecked(drafts);
		for (const d of dropped) console.log(`# ${d.id}: left out (${d.why})`);
		for (const f of files) console.log(`drafted into ${f}`);
		for (const x of outside) console.log(`${x.file}:${x.line}: ${x.severity}: ${x.message} (new since the drafts)`);
	}
	return 0;
}

module.exports = { worth, place, chainAt, predecessors, questSteps, mergeSteps, draftText, applyDrafts, applyChecked, stepEnd, command, PLACE_NEAR };
