'use strict';
// playtest --honest: the compiled guides played from their lines and the
// reference data only, with nothing free. The stub world of tools/lib/playtest.js
// accepts any quest, completes a quest's objectives at the turn-in and puts a
// `collect`'s items in the bags from nowhere, so a guide can play clean and
// still strand a player (docs/superpowers/research/2026-10-21-v2-playable-audit.md).
// Here the character gains a quest, an item, a flight path or a place only
// through a line that gives it, and each rule a line breaks is a finding:
//
//   R1  travel: a move to another continent needs a travel line before it
//       (hearth, a boat, zeppelin, tram, lift, portal or ride `goto`, a
//       deathskip); a move to another zone one (any goto, enter, fly, hearth,
//       die) unless it is a short step over the border; `fly` leaves from a
//       flight master where the guide leaves the player and needs both flight
//       paths learnt (`getfp`); `hearth` needs the inn bound (`sethome`).
//       Goals of an `along` step do not move the player.
//   R2  accept: the giver stands at the step's place; a quest started by an
//       item needs the item in the bags from an earlier line.
//   R3  items: `collect` needs a source in the data (a mob or object that
//       drops it, a vendor, a reward) near the goal's place; a quest item
//       drops only while a quest that asks for it is held (an item the data
//       does not flag but some quest asks for and no vendor sells: a
//       warning); `use` needs the item in the bags.
//   R4  NPCs: the NPC of an accept or turn-in is one of the quest's givers or
//       enders; a step titled with an NPC's name has a goal at that NPC; a
//       quest with several givers and no `npc` must resolve to the one near
//       the player.
//   R5  turn-in: the quest is in the log and every objective was credited by
//       an earlier line (a kill, collect, use or interact tied to it, or the
//       mobs and items it names); with the local knowledge base, its required
//       steps (use an item, combine, summon, escort, buy, loot an object) each
//       have a line.
//
// A broken line is reported, then played as the stub world would (the quest
// taken, the item given), so one cause gives one finding, not a cascade.
// Chains are played whole: each guide with no guide leading into it and
// every guide its `next` (the first option) leads to, carrying the state.
//
//   const { honestPlay } = require('./playtest-honest');
//   const findings = honestPlay(guides, data, { race: 'Orc', faction: 'Horde', cls: 'WARRIOR' }, { kb });
//   // [{ rule, severity: 'fail'|'warn', guide, file, line, step, title, reason, repair }]

const fs = require('node:fs');
const path = require('node:path');
const { Geo } = require('./planner/geo');

// A giver or ender "stands at" a goal within this many yards of one of its
// spawns (estimate: the compiler places a goal at a spawn; an `@` override
// near the NPC stays inside it).
const AT_NPC_YD = 80;
// A flight leaves from a flight master within this many yards of where the
// guide leaves the player (the hut and its yard; estimate).
const AT_FLIGHT_YD = 200;
// A move to another zone on the same continent shorter than this needs no
// travel line (a step over the border, a city gate; estimate).
const ZONE_STEP_YD = 600;
// A collect's source counts as at the goal within this many yards of one of
// its spawns (a camp's spread; estimate).
const SOURCE_YD = 400;
// A quest with several givers: another giver this much nearer to the player
// than the one the line resolves to is the one a player would go to (estimate).
const GIVER_NEARER_YD = 500;
// A travel `goto` that crosses water or the world: its label, or a dock. The
// words cover the route's hop modes (boat, zeppelin, tram, lift, portal, a
// quest ride; docs/superpowers/research/2026-10-21-v2-route-events.md).
const TRANSPORT_RE = /\b(boat|ship|zeppelin|portal|tram|ferry|dock|harbou?r|teleport|lift|elevator|ride|flight|gryphon|wyvern|bat|hippogryph)s?\b/i;
const DOCK_YD = 120;
// The knowledge base's step kinds a turn-in needs a line for (the objective
// kinds, kill and loot, are the data's objectives).
const KB_ACTIONS = new Set(['use-item', 'combine', 'summon', 'escort', 'buy', 'collect-object']);
const KB_FILE = path.join(__dirname, '..', '..', 'data', 'local', 'kb', 'forever-kb.sqlite');

// The knowledge base's required steps per quest, { quest: [{ n, action, target, item, fact }] },
// from `file` (default data/local/kb/forever-kb.sqlite); null when it is not there.
function loadKb(file = KB_FILE) {
	if (!file || !fs.existsSync(file)) return null;
	const { DatabaseSync } = require('node:sqlite');
	const db = new DatabaseSync(file, { readOnly: true });
	try {
		const out = new Map();
		const rows = db.prepare('select quest, n, action, target_kind, target, item, fact from steps where drives = 1 and n is not null order by quest, n').all();
		for (const r of rows) {
			if (!KB_ACTIONS.has(r.action) || (r.target == null && r.item == null)) continue;
			if (!out.has(r.quest)) out.set(r.quest, []);
			out.get(r.quest).push({ n: r.n, action: r.action, kind: r.target_kind, target: r.target, item: r.item, fact: r.fact });
		}
		return out;
	} finally {
		db.close();
	}
}

const titleOf = (data, q) => (data.quests[q] && data.quests[q].title) || `quest ${q}`;
const itemName = (data, i) => (data.items[i] && data.items[i].name) || `item ${i}`;
const npcName = (data, n) => (data.npcs[n] && data.npcs[n].name) || `NPC ${n}`;

// Whether an `only` ({ classes, races, factions }, "!x" excludes) lets the persona in.
function fits(only, { race, faction, cls }) {
	if (!only) return true;
	const group = (list, v) => {
		if (!list || !list.length) return true;
		const pos = list.filter((x) => !String(x).startsWith('!'));
		const neg = list.filter((x) => String(x).startsWith('!')).map((x) => String(x).slice(1).toUpperCase());
		const V = String(v).toUpperCase();
		if (neg.includes(V)) return false;
		return !pos.length || pos.some((x) => String(x).toUpperCase() === V || (V === 'SCOURGE' && String(x).toUpperCase() === 'UNDEAD'));
	};
	return group(only.classes, cls) && group(only.races, race) && group(only.factions, faction);
}

class World {
	constructor(data, persona, kb) {
		this.data = data;
		this.persona = persona;
		this.kb = kb;
		this.geo = new Geo(data.mapFrames, data.zones);
		this.level = 1;
		this.log = new Map(); // quest -> { credit: [], since: index of the accept's goal }
		this.done = new Set();
		this.bags = new Map();
		this.known = new Set(); // taxi nodes
		this.bound = null;
		this.pos = null; // { map, x, y, f, w: { c, wx, wy } }
		this.travelled = null; // the kind of the last travel line since pos: 'zone' | 'world'
		this.worked = []; // every executed goal, for the knowledge base's steps
		this.findings = [];
		this.nodes = new Map(((data.travel && data.travel.taxi && data.travel.taxi.nodes) || []).map((n) => [n.id, n]));
		this.needing = new Map(); // item -> quests whose objectives ask for it
		for (const q of Object.values(data.quests)) {
			for (const o of q.objectives || []) {
				if (o.type !== 'item') continue;
				if (!this.needing.has(o.id)) this.needing.set(o.id, []);
				this.needing.get(o.id).push(q.id);
			}
		}
		this._names = null;
	}

	// Whether the character's faction can use taxi node n (1 Alliance, 2 Horde, else both).
	usable(n) {
		const side = this.persona.faction === 'Alliance' ? 1 : this.persona.faction === 'Horde' ? 2 : 0;
		return !side || (n.faction !== 1 && n.faction !== 2) || n.faction === side;
	}

	// The taxi node of a getfp or fly line: its `node`, else by name among the usable ones.
	node(x) {
		if (x.node != null && this.nodes.has(x.node)) return this.nodes.get(x.node);
		const name = String(x.location || '').toLowerCase();
		for (const n of this.nodes.values()) {
			if (this.usable(n) && (String(n.short).toLowerCase() === name || String(n.name).toLowerCase() === name)) return n;
		}
		return null;
	}

	// NPC ids by lower-case name (for step titles).
	names() {
		if (!this._names) {
			this._names = new Map();
			for (const n of Object.values(this.data.npcs)) {
				const k = String(n.name || '').toLowerCase();
				if (!k) continue;
				if (!this._names.has(k)) this._names.set(k, []);
				this._names.get(k).push(n.id);
			}
		}
		return this._names;
	}

	// f: 'e' the Era frame, anything else (none) the live one (planner/geo.js).
	world(map, x, y, f) {
		return map != null && x != null && y != null ? this.geo.toWorld(map, x, y, f) : null;
	}

	dist(a, b) {
		if (!a || !b || a.c !== b.c) return Infinity;
		return Math.hypot(a.wx - b.wx, a.wy - b.wy);
	}

	// Yards from world point w to the nearest spawn of npc (Infinity without one on w's continent).
	npcDist(npc, w) {
		const n = this.data.npcs[npc];
		if (!n || !n.spawns || !w) return Infinity;
		let best = Infinity;
		for (const [map, s] of Object.entries(n.spawns)) {
			for (const p of [...(s.pts || []), ...(s.more || [])]) {
				const d = this.dist(this.world(Number(map), p[0], p[1], s.f), w);
				if (d < best) best = d;
			}
		}
		return best;
	}

	objDist(obj, w) {
		const o = this.data.objects && this.data.objects[obj];
		if (!o || !o.spawns || !w) return Infinity;
		let best = Infinity;
		for (const [map, s] of Object.entries(o.spawns)) {
			for (const p of [...(s.pts || []), ...(s.more || [])]) {
				const d = this.dist(this.world(Number(map), p[0], p[1], s.f), w);
				if (d < best) best = d;
			}
		}
		return best;
	}

	zoneName(map) {
		return this.geo.zoneName(map) || `map ${map}`;
	}

	has(item, n = 1) {
		return (this.bags.get(item) || 0) >= n;
	}

	give(item, n = 1) {
		if (item != null) this.bags.set(item, (this.bags.get(item) || 0) + n);
	}

	take(item, n) {
		this.bags.set(item, Math.max(0, (this.bags.get(item) || 0) - n));
	}

	held(q) {
		return this.log.has(q);
	}

	// The quests held now that ask for item.
	heldNeeding(item) {
		return (this.needing.get(item) || []).filter((q) => this.held(q));
	}

	// A goal tied to objective oi (1-based) of a held quest: the engine keeps
	// it open until the objective is done, so it credits all of it (at least n).
	credit(q, oi, n) {
		const e = this.log.get(q);
		if (!e) return;
		const o = this.data.quests[q] && (this.data.quests[q].objectives || [])[oi - 1];
		e.credit[oi - 1] = Math.max((e.credit[oi - 1] || 0) + n, (o && o.count) || 1);
	}

	accepted(q) {
		const quest = this.data.quests[q];
		this.log.set(q, { credit: [], since: this.worked.length });
		if (quest && quest.sourceItem) this.give(quest.sourceItem, 1);
	}
}

// Line numbers: each compiled goal matched to its source line (the step's
// goals in the source, by verb and id, in order), else the step's.
function goalLines(astStep, step) {
	const ast = (astStep && astStep.goals) || [];
	const used = new Set();
	return step.goals.map((g) => {
		const id = g.quest ?? g.item ?? g.npc ?? g.object ?? g.level ?? g.location ?? null;
		for (let i = 0; i < ast.length; i++) {
			if (used.has(i)) continue;
			const a = ast[i];
			const aid = a.quest ?? a.item ?? a.npc ?? a.object ?? a.level ?? a.location ?? null;
			if (a.verb === g.t && (id == null || aid == null || aid === id)) {
				used.add(i);
				return a.line;
			}
		}
		return astStep ? astStep.line : 0;
	});
}

function whenHolds(w, when) {
	for (const p of when || []) {
		let ok = true;
		const qs = p.q || [];
		switch (p.k) {
			case 'onquest': ok = qs.some((q) => w.held(q)); break;
			case 'turnedin': ok = qs.every((q) => w.done.has(q)); break;
			case 'complete': ok = qs.some((q) => w.held(q)); break;
			case 'available': ok = qs.some((q) => !w.held(q) && !w.done.has(q)); break;
			case 'has': ok = w.has(p.item, p.n || 1); break;
			case 'level': {
				const v = p.level ?? p.v ?? p.n;
				if (v == null || !p.op) ok = true;
				else ok = p.op === '<' ? w.level < v : p.op === '<=' ? w.level <= v : p.op === '>' ? w.level > v : p.op === '>=' ? w.level >= v : true;
				break;
			}
			case 'group': ok = w.groups === 'do'; break; // playtest's answer at group quests (skip: the solo route)
			case 'bound': ok = !p.location || w.bound == null || String(w.bound).toLowerCase() === String(p.location).toLowerCase(); break;
			default: ok = true;
		}
		if (p.neg && p.k !== 'level') ok = !ok;
		if (!ok) return false;
	}
	return true;
}

// Play `guides` (compiled, in chain order) as persona -> findings.
function playChain(chain, data, persona, { kb = null, report = null, groups = 'skip' } = {}) {
	const w = new World(data, persona, kb);
	w.groups = groups;
	for (const g of chain) playGuide(w, g, !report || report.has(g.id));
	return w.findings;
}

function playGuide(w, g, reporting) {
	const { data } = w;
	const file = (g._ast && g._ast.file) || g.id;
	const astSteps = (g._ast && g._ast.steps) || [];
	g.steps.forEach((s, si) => {
		if (!fits(s.only, w.persona) || !whenHolds(w, s.when)) return;
		const lines = goalLines(astSteps[si], s);
		const astGoals = (astSteps[si] && astSteps[si].goals) || [];
		const at = (gi) => ({ guide: g.id, file, line: lines[gi] || (astSteps[si] && astSteps[si].line) || 0, step: si + 1, title: s.title || '' });
		const find = (gi, rule, severity, reason, repair, extra = null) => {
			if (reporting) w.findings.push({ rule, severity, ...at(gi), reason, repair, ...extra });
		};
		w.step = `${g.id}#${si}`;
		const stepNpcs = new Set();
		s.goals.forEach((x, gi) => {
			if (!fits(x.only, w.persona)) return;
			if (x.npc != null && (x.t === 'accept' || x.t === 'turnin' || x.t === 'talk')) stepNpcs.add(x.npc);
			const explicitNpc = astGoals.some((a) => a.verb === x.t && a.quest === x.quest && a.npc != null);
			playGoal(w, g, x, gi, find, explicitNpc, !!s.along);
		});
		titleCheck(w, s, stepNpcs, find);
	});
}

// R4: a step with an accept, turn-in or talk whose title names an NPC who is
// none of: an NPC a goal of the step is at or kills (or loots from), a giver
// or ender of its quests (the one an accept or turn-in names, when it names
// one: Veteran Uzzek at Tarshaw Jaggedscar under "Torm Ragetotem"). A title
// that is the title of one of its quests (Sarkoth) is no NPC's.
function titleCheck(w, s, stepNpcs, find) {
	if (!s.title || !stepNpcs.size) return;
	const title = String(s.title).trim().toLowerCase();
	const ids = w.names().get(title);
	if (!ids) return;
	const allowed = new Set();
	const quests = new Map(); // quest -> the NPCs its accept or turn-in names
	for (const x of s.goals) {
		if (!fits(x.only, w.persona)) continue;
		if (x.npc != null) allowed.add(x.npc);
		if (x.fromKind === 'npc' && x.fromId != null) allowed.add(x.fromId);
		if (x.fromAlsoId != null) allowed.add(x.fromAlsoId);
		for (const n of x.fromNpcs || []) allowed.add(typeof n === 'object' ? n.npc ?? n.id : n);
		if (x.quest == null) continue;
		const q = w.data.quests[x.quest];
		if (q && String(q.title).toLowerCase() === title) return;
		if (!quests.has(x.quest)) quests.set(x.quest, { named: new Set(), q });
		if ((x.t === 'accept' || x.t === 'turnin') && x.npc != null) quests.get(x.quest).named.add(x.t);
	}
	for (const { named, q } of quests.values()) {
		if (!q) continue;
		if (!named.has('accept')) for (const n of (q.start && q.start.npc) || []) allowed.add(n);
		if (!named.has('turnin')) for (const n of (q.end && q.end.npc) || []) allowed.add(n);
	}
	if (ids.some((id) => allowed.has(id))) return;
	const at = [...stepNpcs].map((n) => npcName(w.data, n)).join(', ');
	find(0, 'R4', 'fail', `step titled "${s.title}" but its quest goals are at ${at}`, `title the step ${at}, or give the goal \`npc ${ids[0]}\``);
}

const TRAVEL_GOALS = new Set(['goto', 'enter', 'explore', 'fly', 'hearth', 'die']);

// R1 before a goal moves the character to (map, x, y). A move finding carries
// `from` and `to` ({ map, x, y, f }) and `inStep` (the from position was set by
// an earlier goal of the same step: a jump inside a step, not at its start).
function arrive(w, x, gi, find, to) {
	const from = w.pos;
	const isTravel = TRAVEL_GOALS.has(x.t);
	if (from && to.w && from.w) {
		const label = `${w.zoneName(from.map)} to ${w.zoneName(to.map)}`;
		const pt = (p) => ({ map: p.map, x: p.x, y: p.y, f: p.f });
		const extra = { from: pt(from), to: pt(to), inStep: w.posStep === w.step };
		if (from.w.c !== to.w.c) {
			const crossed = w.travelled === 'world' || x.t === 'hearth' || x.t === 'die' || (x.t === 'goto' && transportGoto(w, x, to.w));
			if (!crossed) find(gi, 'R1', 'fail', `continent change with no travel line: ${label}`, `add a travel step before it: \`goto\` the dock "Boat to …" / "Zeppelin to …", or \`hearth\`, then \`fly\` from a known flight path`, extra);
		} else if (from.map !== to.map && !isTravel && !w.travelled && w.dist(from.w, to.w) > ZONE_STEP_YD) {
			find(gi, 'R1', 'fail', `zone change with no travel line: ${label} (${Math.round(w.dist(from.w, to.w))} yd)`, `add \`goto\` (or \`fly\`) into ${w.zoneName(to.map)} with a label saying the way`, extra);
		}
	}
	w.pos = to;
	w.posStep = w.step;
	w.travelled = null;
}

// A goto whose label names a boat, zeppelin or portal, or that stands at a dock.
function transportGoto(w, x, at) {
	if (TRANSPORT_RE.test(x.text || '')) return true;
	for (const t of (w.data.travel && w.data.travel.transports) || []) {
		for (const end of [t.a, t.b]) {
			if (end && w.dist(w.world(end.map, end.x, end.y, end.f), at) < DOCK_YD) return true;
		}
	}
	return false;
}

function place(w, x) {
	if (x.map == null || x.x == null) return null;
	return { map: x.map, x: x.x, y: x.y, f: x.f, w: w.world(x.map, x.x, x.y, x.f) };
}

// along: the goal of an `along` step, done on the way under the next steps,
// so its place does not move the player (no R1 there).
function playGoal(w, g, x, gi, find, explicitNpc, along = false) {
	const { data } = w;
	const prior = w.pos;
	const p = place(w, x);
	// Travel lines that set the character down somewhere arrive themselves.
	if (x.t === 'fly') {
		const node = w.node(x);
		const id = node ? node.id : x.location;
		const here = prior && prior.w;
		// Where the flight starts: the flight master the guide leaves the player at.
		const nearest = (known) => {
			let best = null;
			for (const n of w.nodes.values()) {
				if (!w.usable(n) || (known && (!w.known.has(n.id) || n.id === id))) continue;
				const d = w.dist(w.world(n.map, n.x, n.y, 'e'), here);
				if (!best || d < best.d) best = { n, d };
			}
			return best;
		};
		if (!w.known.has(id)) find(gi, 'R1', 'fail', `fly to ${x.location}: its flight path was never learnt`, `add \`getfp "${(node && node.short) || x.location}"\` on an earlier visit, or walk`);
		if (here) {
			const at = nearest(false);
			if (at && at.d <= AT_FLIGHT_YD) {
				if (at.n.id !== id && !w.known.has(at.n.id)) find(gi, 'R1', 'fail', `fly from ${at.n.short}: its flight path was never learnt`, `add \`getfp "${at.n.short}"\` before the flight`);
				w.known.add(at.n.id);
			} else {
				const k = nearest(true);
				if (k) find(gi, 'R1', 'fail', `fly to ${x.location} with no flight master where the guide leaves the player (${w.zoneName(prior.map)} ${prior.x},${prior.y}): the nearest learnt one is ${k.n.short}, ${Math.round(k.d)} yd away`, `add a step to the ${k.n.short} flight master (\`goto\` it) before the flight`);
				else find(gi, 'R1', 'fail', `fly to ${x.location}: no flight path learnt to fly from`, `add \`getfp\` at the flight master the player stands at`);
			}
		}
		w.known.add(id);
		if (node) arriveAt(w, x, gi, find, { map: node.map, x: node.x, y: node.y, f: 'e' });
		w.travelled = null;
		return;
	}
	if (x.t === 'hearth') {
		if (w.bound && String(w.bound).toLowerCase() !== String(x.location).toLowerCase()) find(gi, 'R1', 'fail', `hearth to ${x.location}, but the hearthstone is bound to ${w.bound}`, `add \`sethome "${x.location}"\` before, or hearth to ${w.bound}`);
		const inn = ((data.travel && data.travel.inns) || []).find((i) => (i.names || [i.location]).some((n) => String(n).toLowerCase() === String(x.location).toLowerCase()));
		if (inn) arriveAt(w, x, gi, find, { map: inn.map, x: inn.x, y: inn.y, f: inn.f });
		w.travelled = null;
		return;
	}
	if (p && !along) arrive(w, x, gi, find, p);
	switch (x.t) {
		case 'goto':
		case 'enter':
		case 'explore':
			if (x.t === 'goto' && p && p.w && transportGoto(w, x, p.w)) w.travelled = 'world';
			else w.travelled = 'zone';
			return;
		case 'die':
			w.travelled = 'zone'; // a graveyard on the same continent
			return;
		case 'getfp':
			{
				const node = w.node(x);
				w.known.add(node ? node.id : x.location);
			}
			return;
		case 'sethome':
			w.bound = x.location;
			return;
		case 'level':
			w.level = Math.max(w.level, Math.floor(x.level || 0));
			return;
		case 'buy':
			w.give(x.item, x.count || 1);
			return;
		case 'accept':
			return accept(w, x, gi, find, explicitNpc, prior);
		case 'turnin':
			return turnin(w, g, x, gi, find);
		case 'kill':
			return kill(w, x);
		case 'collect':
			return collect(w, x, gi, find, p);
		case 'use':
			if (x.item != null && !w.has(x.item)) {
				const q = w.data.quests[x.quest];
				const given = q && q.sourceItem === x.item;
				if (!given) find(gi, 'R3', 'fail', `use ${itemName(data, x.item)}: it is not in the bags`, `add the line that gets it (\`collect ${x.item}\`, \`buy ${x.item}\`, or the accept that gives it) before`);
				w.give(x.item, 1);
			}
			if (x.quest && x.oi) w.credit(x.quest, x.oi, x.count || 1);
			w.worked.push(x);
			return;
		case 'interact':
			if (x.quest && x.oi) w.credit(x.quest, x.oi, x.count || 1);
			for (const [item, it] of Object.entries(data.items)) {
				if (it.drops && it.drops.object && x.object != null && it.drops.object[x.object] !== undefined) w.give(Number(item), 1);
			}
			w.worked.push(x);
			return;
		case 'complete': {
			const q = data.quests[x.quest];
			if (q && w.held(x.quest)) {
				(q.objectives || []).forEach((o, i) => {
					w.credit(x.quest, i + 1, o.count || 1);
					if (o.type === 'item') w.give(o.id, o.count || 1);
				});
			}
			w.worked.push(x);
			return;
		}
		default:
			w.worked.push(x);
	}
}

function arriveAt(w, x, gi, find, at) {
	arrive(w, x, gi, find, { ...at, w: w.world(at.map, at.x, at.y, at.f) });
}

function accept(w, x, gi, find, explicitNpc, prior) {
	const { data } = w;
	const q = data.quests[x.quest];
	if (!q) return w.accepted(x.quest);
	const start = q.start || { npc: [], object: [], item: [] };
	const name = titleOf(data, x.quest);
	// R2: an item-started quest needs its item.
	const byItem = start.item && start.item.length && (x.item != null || (!start.npc.length && !start.object.length));
	if (byItem) {
		const items = x.item != null ? [x.item] : start.item;
		if (!items.some((i) => w.has(i))) {
			const it = data.items[items[0]] || {};
			const srcs = [
				...Object.keys((it.drops && it.drops.npc) || {}).slice(0, 3).map((n) => `kill ${npcName(data, Number(n))}`),
				...Object.keys((it.drops && it.drops.object) || {}).slice(0, 3).map((o) => `loot ${(data.objects[o] && data.objects[o].name) || `object ${o}`}`),
			];
			find(gi, 'R2', 'fail', `accept ${name}: it starts from ${itemName(data, items[0])}, which no earlier line puts in the bags`, `${srcs.length ? `first ${srcs.join(' / ')} (\`collect ${items[0]}\`)` : `first \`collect ${items[0]}\``}, then accept; or move the accept to the step that loots it`);
			w.give(items[0], 1);
		}
	} else if (x.npc != null) {
		// R4: the line's NPC gives the quest.
		if (start.npc.length && !start.npc.includes(x.npc)) {
			find(gi, 'R4', 'fail', `accept ${name} at ${npcName(data, x.npc)}, who does not give it (givers: ${start.npc.map((n) => npcName(data, n)).join(', ')})`, `write \`npc ${start.npc[0]}\` and its place`);
		}
		// R2: the giver stands at the step's place.
		const here = w.world(x.map, x.x, x.y, x.f);
		if (here && w.npcDist(x.npc, here) > AT_NPC_YD) {
			find(gi, 'R2', 'fail', `accept ${name}: ${npcName(data, x.npc)} does not stand at the step's place (${w.zoneName(x.map)} ${x.x},${x.y})`, `drop the \`@\` or move it to ${npcName(data, x.npc)}`);
		}
		// R4: several givers, none written: the one a player near here would go to.
		if (!explicitNpc && start.npc.length > 1 && prior && prior.w) {
			const mine = w.npcDist(x.npc, prior.w);
			let best = null;
			for (const n of start.npc) {
				const d = w.npcDist(n, prior.w);
				if (n !== x.npc && d + GIVER_NEARER_YD < mine && (!best || d < best.d)) best = { n, d };
			}
			if (best) find(gi, 'R4', 'fail', `accept ${name}: several NPCs give it and the line names none, so it resolves to ${npcName(data, x.npc)} (${w.zoneName(x.map)}, ${Math.round(mine)} yd away); ${npcName(data, best.n)} is ${Math.round(best.d)} yd away`, `write \`accept ${x.quest} npc ${best.n}\` if the route takes it there`);
		}
	}
	w.accepted(x.quest);
	w.worked.push(x);
}

function turnin(w, g, x, gi, find) {
	const { data } = w;
	const q = data.quests[x.quest];
	const name = titleOf(data, x.quest);
	if (q && x.npc != null && q.end && q.end.npc.length && !q.end.npc.includes(x.npc)) {
		find(gi, 'R4', 'fail', `turn in ${name} at ${npcName(data, x.npc)}, who does not take it (enders: ${q.end.npc.map((n) => npcName(data, n)).join(', ')})`, `write \`npc ${q.end.npc[0]}\``);
	}
	if (x.direct) {
		w.done.add(x.quest);
		return;
	}
	if (!w.held(x.quest)) {
		find(gi, 'R5', w.done.size || w.log.size ? 'fail' : 'warn', `turn in ${name}: never accepted on the way here`, `add \`accept ${x.quest}\` before, or mark the turn-in \`direct\``);
		w.accepted(x.quest);
		if (q) (q.objectives || []).forEach((o, i) => { w.credit(x.quest, i + 1, o.count || 1); if (o.type === 'item') w.give(o.id, o.count || 1); });
	}
	const e = w.log.get(x.quest);
	if (q) {
		(q.objectives || []).forEach((o, i) => {
			const need = o.count || 1;
			const got = o.type === 'item' ? Math.max(w.bags.get(o.id) || 0, e.credit[i] || 0) : e.credit[i] || 0;
			if (got < need) {
				const what = o.type === 'item' ? `${need} ${o.text || itemName(data, o.id)}` : `${o.type} ${o.text || o.id} x${need}`;
				const verb = o.type === 'kill' ? 'kill' : o.type === 'item' ? 'collect' : 'complete';
				find(gi, 'R5', 'fail', `turn in ${name}: objective ${i + 1} (${what}) has ${got}/${need} from earlier lines`, `add \`${verb} ${o.type === 'kill' || o.type === 'item' ? o.id : x.quest} x${need} quest ${x.quest}.${i + 1}\` with its place before the turn-in`);
			}
			if (o.type === 'item') w.take(o.id, need);
		});
		// The knowledge base's required steps since the accept.
		const steps = w.kb && w.kb.get(x.quest);
		if (steps) {
			const since = w.worked.slice(e.since);
			for (const st of steps) {
				// An item step (use, combine, buy) needs a line naming the item;
				// a summon or escort one naming the NPC (or the item that summons);
				// an object's loot the item or the object.
				const byItem = st.action === 'use-item' || st.action === 'combine' || st.action === 'buy';
				const ids = (byItem && st.item != null ? [st.item] : [st.item, st.target]).filter((v) => v != null);
				const covered = since.some((y) => {
					if (y.t === 'complete' && y.quest === x.quest) return st.action === 'collect-object' || st.action === 'buy';
					return (byItem ? [y.item] : [y.item, y.npc, y.object, y.fromId]).some((v) => v != null && ids.includes(v));
				});
				if (!covered) {
					const target = st.item != null ? itemName(data, st.item) : st.kind === 'npc' ? npcName(data, st.target) : `${st.kind} ${st.target}`;
					find(gi, 'R5', 'fail', `turn in ${name}: required step ${st.n} (${st.action} ${target}) has no line`, `add a goal for it before the turn-in${st.fact ? `: ${st.fact}` : ''}`);
				}
			}
		}
	}
	w.log.delete(x.quest);
	w.done.add(x.quest);
	for (const it of (q && q.web && q.web.items) || []) w.give(Array.isArray(it) ? it[0] : it, Array.isArray(it) ? it[1] || 1 : 1);
	w.worked.push(x);
}

function kill(w, x) {
	const { data } = w;
	const n = x.count || 1;
	if (x.quest && x.oi) w.credit(x.quest, x.oi, n);
	// Held quests that ask for this mob, and the quest items it drops.
	for (const [q, e] of w.log) {
		if (q === x.quest) continue;
		const quest = data.quests[q];
		(quest && quest.objectives || []).forEach((o, i) => {
			if (o.type === 'kill' && o.id === x.npc) e.credit[i] = (e.credit[i] || 0) + n;
		});
	}
	for (const [q] of w.log) {
		const quest = data.quests[q];
		for (const o of (quest && quest.objectives) || []) {
			if (o.type !== 'item') continue;
			const it = data.items[o.id];
			if (it && it.drops && it.drops.npc && x.npc != null && it.drops.npc[x.npc] !== undefined && !w.has(o.id, o.count || 1)) w.give(o.id, (o.count || 1) - (w.bags.get(o.id) || 0));
		}
	}
	// Quest starters it drops (an item that starts a quest, not yet held).
	for (const q of Object.values(data.quests)) {
		for (const i of (q.start && q.start.item) || []) {
			const it = data.items[i];
			if (it && it.drops && it.drops.npc && x.npc != null && it.drops.npc[x.npc] !== undefined && !w.has(i) && !w.done.has(q.id)) w.give(i, 1);
		}
	}
	w.worked.push(x);
}

function collect(w, x, gi, find, p) {
	const { data } = w;
	const item = x.item;
	const n = x.count || 1;
	const it = data.items[item];
	const name = itemName(data, item);
	const optional = !!x.optional;
	if (!w.has(item, n)) {
		// Where the player collects: the goal's place, else where the guide left them.
		const at = p && p.w ? p : w.pos && w.pos.w ? w.pos : null;
		let sourced = true;
		const npcs = Object.keys((it && it.drops && it.drops.npc) || {}).map(Number);
		const objs = Object.keys((it && it.drops && it.drops.object) || {}).map(Number);
		const vendors = (it && it.vendors) || [];
		if (!npcs.length && !objs.length && !vendors.length) {
			sourced = false;
			find(gi, 'R3', optional ? 'warn' : 'fail', `collect ${name}: the data has no mob, object or vendor for it and no earlier line gives it`, `write the line that makes it (\`buy\` what it takes, the object to use, the quest that rewards it) before, or drop the goal`);
		} else if (at && !vendors.length) {
			const near = npcs.some((m) => w.npcDist(m, at.w) <= SOURCE_YD) || objs.some((o) => w.objDist(o, at.w) <= SOURCE_YD);
			if (!near) {
				sourced = false;
				const best = [...npcs.map((m) => ({ d: w.npcDist(m, at.w), name: npcName(data, m) })), ...objs.map((o) => ({ d: w.objDist(o, at.w), name: (data.objects[o] && data.objects[o].name) || `object ${o}` }))].sort((a, b) => a.d - b.d)[0];
				find(gi, 'R3', optional ? 'warn' : 'fail', `collect ${name} at ${w.zoneName(at.map)} ${at.x},${at.y}${p ? '' : ' (no place: where the guide left the player)'}: nothing there drops it${best && Number.isFinite(best.d) ? ` (nearest: ${best.name}, ${Math.round(best.d)} yd)` : ' on this continent'}`, `place the goal at a camp that drops it (\`collect ${item} nearest\`)`);
			}
		}
		// Quest items drop only while a quest that asks for them is held.
		const needers = w.needing.get(item) || [];
		if (needers.length && !vendors.length && !w.heldNeeding(item).length) {
			const qs = needers.slice(0, 2).map((q) => titleOf(data, q)).join(' / ');
			if (it && it.questItem) {
				sourced = false;
				find(gi, 'R3', optional ? 'warn' : 'fail', `collect ${name}: it drops only while ${qs} is held, and it is not`, `move the collect after \`accept ${needers[0]}\``);
			} else find(gi, 'R3', 'warn', `collect ${name}: ${qs} asks for it and none is held; it may drop only for the quest (the data does not say)`, `move the collect after \`accept ${needers[0]}\``);
		}
		// A required goal is played on (one cause, one finding); an optional
		// one the player could not do leaves the bags as they were.
		if (sourced || !optional) w.give(item, n - (w.bags.get(item) || 0));
	}
	if (x.quest && x.oi && w.has(item, n)) w.credit(x.quest, x.oi, n);
	w.worked.push(x);
}

// Chains through `next`: the main route, the first option offered without a
// `when` (a catch-up guide behind `when level<N` is its own chain), else the
// first. Each guide no other leads into, then each guide its next leads to,
// once; a cycle's guides start their own.
function chains(guides) {
	const byId = new Map(guides.map((g) => [g.id, g]));
	const nextOf = (g) => {
		const opts = g.nextChoices && g.nextChoices.length ? g.nextChoices : g.next ? [g.next] : [];
		return opts.find((id) => !(g.nextWhen && g.nextWhen[id])) || opts[0] || null;
	};
	// Roots: guides no option of another leads to (a catch-up guide is not one).
	const into = new Set(guides.flatMap((g) => (g.nextChoices && g.nextChoices.length ? g.nextChoices : g.next ? [g.next] : [])).filter((id) => byId.has(id)));
	const seen = new Set();
	const out = [];
	const walk = (g) => {
		const chain = [];
		while (g && !seen.has(g.id)) {
			seen.add(g.id);
			chain.push(g);
			g = byId.get(nextOf(g));
		}
		if (chain.length) out.push(chain);
	};
	for (const g of guides) if (!into.has(g.id)) walk(g);
	for (const g of guides) walk(g);
	return out;
}

// Play every chain holding a guide of `play` (ids) as each of its personas
// -> findings of those guides, by file and line.
function honestPlay(guides, data, personas, { kb = null, play = null, groups = 'skip' } = {}) {
	const report = play ? new Set(play) : null;
	const out = [];
	for (const chain of chains(guides)) {
		if (report && !chain.some((g) => report.has(g.id))) continue;
		for (const persona of personas(chain[0])) {
			for (const f of playChain(chain, data, persona, { kb, report, groups })) out.push({ ...f, race: persona.race, cls: persona.cls });
		}
	}
	return out.sort((a, b) => (a.file < b.file ? -1 : a.file > b.file ? 1 : a.line - b.line));
}

// "R3 fail forever/x/01.guide:12 step 4 "Title": reason\n  repair: …"
function findingLines(f) {
	return [`${f.rule} ${f.severity} ${f.file}:${f.line} (${f.race} ${f.cls ? f.cls[0] + f.cls.slice(1).toLowerCase() : ''}) step ${f.step}${f.title ? ` "${f.title}"` : ''}: ${f.reason}`, `  repair: ${f.repair}`];
}

module.exports = { honestPlay, playChain, chains, goalLines, loadKb, findingLines, KB_FILE };
