'use strict';
// Completionist guides from a completionist route (docs/SIMULATION.md
// "Completionist", `sim export` of a completionist result): the simulator's
// executed steps (export.js executedSteps) as `category Completionist` guides
// that follow the guide conventions (docs/GUIDE_FORMAT.md):
//   - one guide per stretch of the route: a zone visit with BIG turn-ins or
//     more starts a guide, a smaller one joins the guide before it unless
//     that guide already runs LONG and the visit has 3+ turn-ins; a guide is
//     named after its zones with the most goals;
//   - a step per place and kind of stop (consecutive goals within STEP_R
//     yards): quest givers and enders named after the NPC (or the hub, when a
//     flight path or bind opens the step), objectives "<area>: <targets>",
//     with `zone` where the zone changes; `hearth` as "Back to <inn>";
//   - objectives as `kill` / `collect` / `interact` goals tied to the quest
//     (the world's tasks record which objectives they hold), `complete` for
//     events and escorts, `buy … nearest` for vendor items;
//   - an elite quest's goals all `optional`, with the step tip "<Target> is
//     elite: grouping up is advised."; a step left with optional goals only
//     joins the next step (or the one before at the end);
//   - profession quests whose giver is in the guide's zones: one player-facing
//     note in the last step (not routed: they need the skill);
//   - header comments: where the route comes from, the flow, the optional
//     elites, what is left to other guides (class, dungeon quests).
//
//   const guides = completionistGuides({ world, run, data, entries, meta, place, coverage, base, limit });
//   // [{ id, file, text, levels: [lo, hi], zones, quests, seconds }]

const { K_ACCEPT, K_TASK, K_TURNIN, K_DUNGEON } = require('./run');

const SHORT = 6; // goals: a zone with fewer is left out of the guide's title
const BIG = 12; // turn-ins: a visit with this many starts a guide
const LONG = 3 * 3600; // seconds: a guide this long takes no more 3+ turn-in visits
const STEP_R = 150; // yards: consecutive goals this close share a step
const ELITE = new Set([1, 2, 3]);
// An object objective the quest does not have you click (as
// tests/guides-patterns.test.js reads it).
const NOT_A_CLICK = /\/sit\b|\buse your\b[^.]*\bracial\b|\bcast\b/i;

// An item only vendors sell: its only droppers are its vendors (the data
// lists a vendor's stock as its drops, so the world reads Rhapsody Malt as a
// kill of the Kharanos barkeep); as tests/guides-patterns.test.js reads it.
function vendorOnly(it) {
	if (!it || !Array.isArray(it.vendors) || !it.vendors.length) return false;
	const vendors = new Set(it.vendors.map(Number));
	const drops = it.drops || {};
	if (Object.keys(drops.object || {}).length || (it.containers || []).length) return false;
	return Object.keys(drops.npc || {}).every((npc) => vendors.has(Number(npc)));
}

function slug(s) {
	return String(s).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '');
}

// The folder band of a guide starting at `level`: 1-20, then by tens.
function band(level) {
	if (level < 20) return '1-20';
	const lo = Math.min(50, Math.floor(level / 10) * 10);
	return `${lo}-${lo + 10}`;
}

// Elite targets of a quest ([{ name, level }]; level "11" or "52-54", null
// when unrecorded): elite kill objectives, elite droppers of its objective
// items and of its starting item.
function eliteTargets(raw, data) {
	const out = [];
	const add = (npcId) => {
		const n = data.npcs[String(npcId)];
		if (!(n && ELITE.has(n.rank) && !n.faction && n.name) || out.some((t) => t.name === String(n.name))) return;
		const lo = Number.parseInt(n.level, 10);
		const hi = Number.parseInt(n.levelMax, 10);
		const level = Number.isFinite(lo) ? (Number.isFinite(hi) && hi !== lo ? `${lo}-${hi}` : String(lo)) : null;
		out.push({ name: String(n.name), level });
	};
	for (const o of (raw && raw.objectives) || []) {
		if (!o) continue;
		if (o.type === 'kill') add(o.id);
		else if (o.type === 'item') {
			const drops = (((data.items[String(o.id)] || {}).drops || {}).npc) || {};
			const ids = Object.keys(drops);
			// Only when no normal mob drops it too (the route used the elite).
			if (ids.length && ids.every((id) => ELITE.has((data.npcs[id] || {}).rank) || (data.npcs[id] || {}).faction)) ids.forEach(add);
		}
	}
	for (const item of ((raw && raw.start) || {}).item || []) for (const id of Object.keys((((data.items[String(item)] || {}).drops || {}).npc) || {})) add(id);
	return out;
}

// The step tip for its elite targets: the house wording (validate.js
// eliteTip), with their levels so a player can tell whether to group; one
// sentence for several ("A (level 35-36) and B (level 37) are elite: …
// well above level 37."), naming three at most (a camp of six Moonrage
// worgen reads "…, Moonrage Elder (level 14-15) and 3 more are elite").
function eliteTip(targets) {
	const named = targets.slice(0, targets.length > 4 ? 3 : 4).map((t) => (t.level ? `${t.name} (level ${t.level})` : t.name));
	if (targets.length > named.length) named.push(`${targets.length - named.length} more`);
	const list = named.length > 1 ? `${named.slice(0, -1).join(', ')} and ${named[named.length - 1]}` : named[0];
	const top = Math.max(0, ...targets.map((t) => (t.level ? Number(t.level.split('-').pop()) : 0)));
	const be = targets.length > 1 ? 'are' : 'is';
	return top ? `${list} ${be} elite: grouping up is advised unless you are well above level ${top}.` : `${list} ${be} elite: grouping up is advised.`;
}

// Timed quest items (items.json `duration`, tools/lib/dsl/timed.js): the
// route's order knows nothing of them, so Durnan's Scalding Mornbrew (five
// minutes) would wait an hour for its turn-in. A step that gets one (an
// `accept` whose quest hands it over, a `collect` or `buy` of it) is followed by the
// rest of that quest: its later goals (an escort's `complete`, other
// objectives) and the turn-in that spends the item, each in a step titled as
// before, the first with a tip on how long the item lasts.
// steps: [{ title, goals: [{ text, q }] }] -> the same, reordered.
function straightTurnins(steps, data, home = null) {
	const timed = (id) => {
		const it = data.items[String(id)];
		return it && it.duration > 0 ? it : null;
	};
	const spends = (q, item) => {
		const raw = data.quests[String(q)] || {};
		return raw.sourceItem === item || (raw.objectives || []).some((o) => o && o.type === 'item' && o.id === item) || (raw.requiredItems || []).includes(item);
	};
	// Each step's effective zone (`zone` lines carry over to later steps).
	let cur = home;
	const out = steps.map((s) => {
		if (s.zone) cur = s.zone;
		return { ...s, goals: s.goals.slice(), _z: cur };
	});
	const handled = new Set(); // getter goals already straightened
	for (let s = 0; s < out.length; s++) {
		for (const goal of out[s].goals.slice()) {
			if (handled.has(goal)) continue;
			handled.add(goal);
			const m = /^(accept|collect|buy) (\d+)/.exec(goal.text || '');
			if (!m) continue;
			const item = m[1] === 'accept' ? (data.quests[m[2]] || {}).sourceItem : Number(m[2]);
			const it = item && timed(item);
			if (!it) continue;
			// The first later turn-in that spends it.
			let at = null;
			for (let k = s + 1; k < out.length && !at; k++) {
				const j = out[k].goals.findIndex((x) => /^turnin /.test(x.text || '') && x.q != null && spends(x.q, item));
				if (j >= 0) at = { k, j };
			}
			if (!at) continue;
			const q = out[at.k].goals[at.j].q;
			// The quest's goals from here to its turn-in, by step.
			const moved = [];
			for (let k = s + 1; k <= at.k; k++) {
				const mine = out[k].goals.filter((x) => x.q === q);
				if (!mine.length) continue;
				moved.push({ ...out[k], goals: mine });
			}
			// Already straight on: nothing else between. A hearthstone on the
			// way is the route's own quick way there: the walk would be slower.
			const between = out.slice(s + 1, at.k + 1);
			if (between.some((x) => x.goals.some((y) => /^hearth\b/.test(y.text || '')))) continue;
			const others = between.some((x) => x.goals.some((y) => y.q !== q));
			if (!others) continue;
			for (let k = s + 1; k <= at.k; k++) out[k].goals = out[k].goals.filter((x) => x.q !== q);
			const mins = Math.max(1, Math.round(it.duration / 60));
			moved[0].goals[0] = { ...moved[0].goals[0], tip: `${it.name} lasts ${mins} minute${mins === 1 ? '' : 's'}: go straight on with it.` };
			out.splice(s + 1, 0, ...moved);
			// Scan this step again for its other timed items: this one's goals
			// now follow straight on, so it is left as is.
			s--;
			break;
		}
	}
	// Zone lines from each step's own zone: a moved step keeps the zone it was
	// in, and the step after it says where the route is again.
	const kept = out.filter((s) => s.goals.length);
	let prev = home;
	for (const s of kept) {
		s.zone = s._z !== prev ? s._z : null;
		prev = s._z;
		delete s._z;
	}
	return kept;
}

// Goal lines for one executed step. -> [{ text, optional, elite: [{ name, level }] }]
function goalsFor(e, ctx) {
	const { run, data } = ctx;
	const qi = run.qIndex.get(e.q);
	const wq = run.quests[qi];
	const raw = data.quests[String(e.q)] || {};
	const opt = wq.elite ? ' optional' : '';
	const elite = wq.elite ? eliteTargets(raw, data) : [];
	const out = [];
	const add = (text, extra = {}) => out.push({ text: `${text}${opt}`, optional: !!wq.elite, elite, q: e.q, ...extra });
	const name = (kind, id) => {
		const rec = (kind === 'npc' ? data.npcs : kind === 'item' ? data.items : data.objects || {})[String(id)];
		return rec && rec.name ? String(rec.name) : null;
	};
	if (e.kind === K_ACCEPT) {
		// A quest started by an item: loot it first (the item's droppers).
		const item = ((raw.start || {}).item || [])[0];
		if (wq.accept && item) {
			const from = /\(drop: (.+)\)$/.exec(wq.gName || '');
			const tip = from && name('item', item) ? `${from[1]} drops the ${name('item', item)}: right-click it to start ${wq.title}.` : null;
			add(`collect ${item} x1`, { target: name('item', item), tip });
		}
		add(`accept ${e.q}`);
	} else if (e.kind === K_TURNIN) add(`turnin ${e.q}`);
	else if (e.kind === K_TASK) {
		// The task at this point (the hook passes the point, not the task).
		let task = null;
		for (let t = run.qTask0[qi]; t < run.qTask1[qi]; t++) if (run.taskPt[t] === e.pt) task = wq.tasks[t - run.qTask0[qi]];
		const objs = raw.objectives || [];
		const lines = [];
		const own = ctx.faction === 'Alliance' ? 'A' : 'H';
		let whole = !task || !task.objs || !task.objs.some((oi) => oi >= 0);
		const seen = new Set();
		(task ? task.objs : []).forEach((oi, wi) => {
			const o = objs[oi];
			if (oi < 0 || !o) {
				whole = true;
				return;
			}
			if (seen.has(oi)) return;
			seen.add(oi);
			const work = task.work[wi] || [];
			if (o.type === 'kill') {
				// Kill credit for a conversation or a deed on an NPC of the
				// character's side (work 'use'): the quest's own goal.
				const fac = String((data.npcs[String(o.id)] || {}).faction || '').toUpperCase();
				if (work[0] !== 'kill' || fac.includes(own)) whole = true;
				else lines.push([`kill ${o.id} quest ${e.q}.${oi + 1}`, name('npc', o.id)]);
			} else if (o.type === 'item') {
				if (work[0] === 'buy' || vendorOnly(data.items[String(o.id)])) lines.push([`buy ${o.id} x${Number(o.count) > 0 ? o.count : 1} nearest`, name('item', o.id)]);
				else if (work[0] === 'kill' || (work[0] === 'use' && work[1] !== 1)) lines.push([`collect ${o.id} quest ${e.q}.${oi + 1}`, name('item', o.id)]);
				else whole = true; // handed over, or made on the spot
			} else if (o.type === 'object') {
				// Not a click (/sit at a campfire, a racial cast at a ley line):
				// the goal says what the quest asks, in its own words.
				const how = (String(raw.objectiveText || '').split(/(?<=\.)\s+/).find((x) => NOT_A_CLICK.test(x)) || '').replace(/\.$/, '').replace(/"/g, "'");
				lines.push([`interact ${o.id} quest ${e.q}.${oi + 1}${how ? ` "${how}"` : ''}`, name('object', o.id)]);
			}
			else whole = true;
		});
		// `complete` holds its step until every objective is done: only at the
		// quest's last site (its other sites' kills and loot are goals of their own).
		const seenTasks = (ctx.taskSeen.get(e.q) || 0) + 1;
		ctx.taskSeen.set(e.q, seenTasks);
		const last = seenTasks >= run.qTask1[qi] - run.qTask0[qi];
		if (whole && last) add(`complete ${e.q}`, { target: wq.title });
		else for (const [l, target] of lines) add(l, { target });
	}
	return out;
}

function completionistGuides({ world, run, data, entries, meta, place, coverage = null, base, limit = Infinity }) {
	const W = world.points;
	const ptOf = (e) => W[run.ptList[e.pt]];
	const zoneOf = (e) => world.zones[ptOf(e)[4]] || `map ${ptOf(e)[4]}`;
	const ctx = { run, data, faction: world.faction, taskSeen: new Map() };
	// Quests the route takes but never hands in (the coverage report's
	// "missed") get no goals: a guide never accepts what it cannot finish.
	const finished = new Set(entries.filter((e) => e.type === 'step' && e.kind === K_TURNIN).map((e) => e.q));
	// Zone visits (dungeon runs never occur: the family has none).
	const visits = [];
	for (const e of entries) {
		if (e.type === 'step' && e.kind === K_DUNGEON) continue;
		const z = zoneOf(e);
		const last = visits[visits.length - 1];
		if (!last || (e.type === 'step' && last.zone !== z)) visits.push({ zone: z, entries: [e] });
		else last.entries.push(e);
	}
	const turnins = (v) => v.entries.filter((e) => e.type === 'step' && e.kind === K_TURNIN).length;
	// Visits -> guides: a visit with BIG turn-ins or more starts a guide; a
	// smaller one joins the guide before it, unless that guide already runs
	// LONG and this visit is more than a stop (3+ turn-ins): the route's many
	// short cleanup trips become a few guides of a couple of hours each.
	const groups = [];
	for (const v of visits) {
		const g = groups[groups.length - 1];
		const span = g ? v.entries[0].time - g.visits[0].entries[0].time : 0;
		if (g && turnins(v) < BIG && !(span >= LONG && turnins(v) >= 3)) g.visits.push(v);
		else groups.push({ visits: [v] });
	}
	const guides = [];
	const profByZone = new Map();
	for (const o of (coverage && coverage.out) || []) {
		if (o.reason !== 'profession') continue;
		if (!profByZone.has(o.zone)) profByZone.set(o.zone, []);
		profByZone.get(o.zone).push(o);
	}
	const outByZone = (reason) => {
		const m = new Map();
		for (const o of (coverage && coverage.out) || []) if (o.reason === reason) {
			if (!m.has(o.zone)) m.set(o.zone, []);
			m.get(o.zone).push(o);
		}
		return m;
	};
	const dungeonByZone = outByZone('dungeon');
	const profName = (raw) => {
		const p = data.professions && data.professions[String(raw.skill)];
		return p ? `${p.name}${raw.skillLevel ? ` ${raw.skillLevel}` : ''}` : 'a profession';
	};
	for (let gi = 0; gi < groups.length && gi < limit; gi++) {
		const entriesG = groups[gi].visits.flatMap((v) => v.entries);
		// Zones by goal count: the title's (top two) and the header zone.
		const count = new Map();
		for (const e of entriesG) if (e.type === 'step') count.set(zoneOf(e), (count.get(zoneOf(e)) || 0) + 1);
		const zonesByCount = [...count.entries()].sort((a, b) => b[1] - a[1]).map(([z]) => z);
		const zonesInOrder = [...new Set(groups[gi].visits.map((v) => v.zone))];
		const titleZones = zonesInOrder.filter((z) => zonesByCount.slice(0, 2).includes(z) && count.get(z) >= SHORT);
		const title = (titleZones.length ? titleZones : [zonesByCount[0]]).join(' & ');
		const levels = entriesG.map((e) => e.level);
		const lo = Math.max(1, Math.floor(Math.min(...levels)));
		const hi = Math.max(lo, Math.min(60, Math.ceil(Math.max(...levels))));
		// Numbered to sort in route order (the menu lists a chain by id): as many digits as the whole route needs.
		const pad = Math.max(2, String(groups.length).length);
		guides.push({ gi, entries: entriesG, title, zone: zonesByCount[0], zones: zonesInOrder, lo, hi, id: `${base}/${String(gi + 1).padStart(pad, '0')}-${slug(title)}`, seconds: entriesG[entriesG.length - 1].time - entriesG[0].time, start: entriesG[0].time });
	}
	// Each guide's time runs to the next guide's start.
	for (let i = 0; i + 1 < guides.length; i++) guides[i].seconds = guides[i + 1].start - guides[i].start;
	return guides.map((g, i) => {
		// Steps.
		const steps = [];
		let cur = null;
		let zone = g.zone;
		const near = (a, b) => {
			const A = W[run.ptList[a]];
			const B = W[run.ptList[b]];
			return A[1] === B[1] && A[4] === B[4] && Math.hypot(A[2] - B[2], A[3] - B[3]) <= STEP_R;
		};
		const quests = new Set();
		const eliteQuests = new Map();
		const unfinished = new Set();
		const placeOf = (pt) => place(run.ptList[pt]);
		// Flight paths and binds are learned on the way into a place: their
		// goals open the step at that place (the house style: `sethome` and
		// `getfp` in the hub's step).
		let pending = [];
		for (const e of g.entries) {
			if (e.type !== 'step') {
				if (e.type === 'fp' || e.type === 'bind') {
					const goal = { text: e.type === 'fp' ? `getfp "${e.name}"` : `sethome "${e.inn}"` };
					if (cur && cur.talk && near(cur.pt, e.pt)) cur.goals.push(goal);
					else pending.push({ goal, pt: e.pt });
					continue;
				}
				cur = null;
				if (e.type === 'hearth') steps.push({ title: `Back to ${e.inn}`, goals: [{ text: `hearth "${e.inn}"` }] });
				else if (e.type === 'grind') {
					const to = Math.min(60, Math.floor(e.to + 1e-6));
					if (to > Math.floor(e.from)) steps.push({ title: e.spot ? `${e.spot.mob} (level ${to})` : `Level ${to}`, goals: [{ text: `level ${to}${e.spot ? ` -- grind on ${e.spot.mob} (level ${e.spot.level})${e.spot.area ? ` at ${e.spot.area}` : ''}` : ''}` }] });
				}
				continue;
			}
			if (!finished.has(e.q)) {
				unfinished.add(e.q);
				continue;
			}
			const z = zoneOf(e);
			// A step per place and per kind of stop: quest givers and enders
			// (named after the NPC, or the hub when it also has a flight path
			// or inn) or objectives (named after the area and the targets, below).
			const talk = e.kind !== K_TASK;
			if (!cur || !near(cur.pt, e.pt) || cur.talk !== talk) {
				const wq = run.quests[run.qIndex.get(e.q)];
				const npc = e.kind === K_ACCEPT ? (wq.accept ? null : wq.gName) : e.kind === K_TURNIN ? wq.eName : null;
				const here = pending.filter((p) => near(p.pt, e.pt));
				const name = (talk && !here.length && npc) || placeOf(e.pt) || z;
				cur = { title: name, area: placeOf(e.pt) || z, pt: e.pt, talk, zone: z !== zone ? z : null, goals: here.map((p) => p.goal) };
				zone = z;
				steps.push(cur);
			}
			// Learned elsewhere (on a flight's landing, say): a step of their own.
			for (const p of pending) if (!cur.goals.includes(p.goal)) steps.splice(steps.length - 1, 0, { title: placeOf(p.pt) || z, goals: [p.goal] });
			pending = [];
			quests.add(e.q);
			for (const goal of goalsFor(e, ctx)) {
				if (cur.goals.some((x) => x.text === goal.text)) continue;
				cur.goals.push(goal);
				if (goal.elite && goal.elite.length) eliteQuests.set(goal.q, goal.elite);
			}
		}
		for (const p of pending) steps.push({ title: placeOf(p.pt) || g.zone, goals: [p.goal] });
		// Objective steps: "<Area>: <targets>" (the first two), e.g.
		// "Northshire Valley: Kobold Vermin and Tough Wolf Meat".
		for (const s of steps) {
			if (s.talk !== false) continue;
			const targets = [...new Set(s.goals.map((x) => x.target).filter(Boolean))];
			if (targets.length) s.title = `${s.area}: ${targets.slice(0, 2).join(' and ')}${targets.length > 2 ? ' and more' : ''}`;
		}
		// A step of optional goals only is done at once: its goals join the
		// nearest step in the same zone that holds a goal (the next ones
		// first), else the next step, else the one before. A `zone` it set
		// passes to the next step still standing.
		const eff = [];
		steps.forEach((x, k) => { eff[k] = x.zone || (k ? eff[k - 1] : g.zone); });
		const holds = (x) => x.goals.some((y) => !y.optional);
		for (let s = 0; s < steps.length; s++) {
			const st = steps[s];
			if (!st.goals.length || holds(st)) continue;
			const after = steps.map((x, k) => k).filter((k) => k > s && holds(steps[k]));
			const before = steps.map((x, k) => k).filter((k) => k < s && holds(steps[k])).reverse();
			// A move may not pass another goal of the same quests (an accept
			// before its objectives, the objectives before the turn-in).
			const qs = new Set(st.goals.map((x) => x.q).filter((q) => q != null));
			const ok = (k) => !steps.slice(Math.min(s, k) + 1, Math.max(s, k)).some((x) => x.goals.some((y) => qs.has(y.q)));
			const cand = [...after, ...before].filter(ok);
			const k = cand.find((j) => eff[j] === eff[s]) ?? cand[0];
			if (k == null) continue;
			steps[k].goals.splice(k > s ? 0 : steps[k].goals.length, 0, ...st.goals);
			st.goals = [];
			if (st.zone) {
				const next = steps.find((x, j) => j > s && x.goals.length);
				if (next && !next.zone) next.zone = st.zone;
			}
		}
		const kept = straightTurnins(steps.filter((s) => s.goals.length), data, g.zone);
		// Profession quests given in this guide's zones: a note in the last step.
		const prof = g.zones.flatMap((z) => profByZone.get(z) || []).filter((o) => !guides.slice(0, i).some((x) => x.zones.includes(o.zone)));
		if (prof.length && kept.length) {
			const list = prof.map((o) => `${o.title} (${profName(data.quests[String(o.id)] || {})})`).join(', ');
			kept[kept.length - 1].goals.push({ text: `note "Profession quests here, for players with the skill: ${list.replace(/"/g, "'")}."` });
		}
		// Text.
		const L = [
			`guide ${g.id}`,
			`title ${g.title}`,
			`faction ${meta.faction}`,
			`race ${meta.race}`,
			`levels ${g.lo}-${g.hi}`,
			`zone ${g.zone}`,
			'category Completionist',
			`folder Completionist · ${meta.race} ${band(guides[0] === g ? 1 : g.lo)}`,
			`keywords completionist, every quest${g.zones.length > 1 ? `, ${g.zones.join(', ')}` : ''}`,
		];
		if (i + 1 < guides.length) L.push(`next ${guides[i + 1].id}`);
		const elites = [...eliteQuests.entries()].map(([q, ts]) => `${data.quests[String(q)] ? data.quests[String(q)].title : q} (${q}; ${ts.map((t) => (t.level ? `${t.name} ${t.level}` : t.name)).join(', ')})`);
		const dungeons = g.zones.flatMap((z) => (dungeonByZone.get(z) || []).map((o) => `${o.title} (${o.id})`));
		const wrap = (text) => {
			const out = [];
			let line = '#';
			for (const w of text.split(' ')) {
				if (line.length + w.length + 1 > 78) {
					out.push(line);
					line = '#';
				}
				line += ` ${w}`;
			}
			if (line !== '#') out.push(line);
			return out;
		};
		L.push('');
		// Areas in route order (consecutive repeats once), for the flow line.
		const areas = [];
		for (const s of kept) {
			const a = s.area;
			if (a && areas[areas.length - 1] !== a) areas.push(a);
		}
		const flow = areas.length > 14 ? [...areas.slice(0, 13), '…'] : areas;
		L.push(...wrap(`Route: guide ${i + 1} of ${guides.length} of ${meta.label}: levels ${g.lo} to ${g.hi}, ${quests.size} quests, ${(g.seconds / 3600).toFixed(1)} h under the model. The order is the simulator's (\`sim run --objective completionist\`, then \`sim export\`; docs/SIMULATION.md §10): fix a step in the exporter or the data, not only here, so the next export keeps it.`));
		L.push('#');
		L.push(...wrap(`Flow (${g.zones.join(', ')}): ${flow.join(' -> ')}.`));
		if (elites.length) {
			L.push('#');
			L.push(...wrap(`Optional (elite: grouping up is advised): ${elites.join('; ')}.`));
		}
		if (unfinished.size) {
			L.push('#');
			L.push(...wrap(`Left out: ${[...unfinished].map((q) => `${(data.quests[String(q)] || {}).title || q} (${q})`).join(', ')}: the route takes them here but cannot finish them (the coverage report's missed quests).`));
		}
		if (prof.length) {
			L.push('#');
			L.push(...wrap(`Profession quests here are not routed (they need the skill): ${prof.map((o) => `${o.id} ${o.title}`).join('; ')}.`));
		}
		L.push('#');
		L.push(...wrap(`Left to other guides: class quests (the Class category)${dungeons.length ? `; dungeon quests (the Dungeons guides): ${dungeons.join(', ')}` : ''}.`));
		// The chain's first step: the other starting zones are grey by the time
		// the route gets there, so "Skip grey quests" would skip them silently.
		const greyTip = 'Every quest counts here, grey ones too: keep Options > Automation > "Skip grey quests" off.';
		kept.forEach((s, k) => {
			// A title is the rest of the line, but the parser reads quotes
			// (an item called One "Gerenzo", of Stonetalon).
			L.push('', `step ${s.title.replace(/"/g, "'")}`);
			if (s.zone) L.push(`  zone ${s.zone}`);
			const elites = [];
			for (const t of s.goals.flatMap((x) => x.elite || [])) if (!elites.some((e) => e.name === t.name)) elites.push(t);
			const tips = elites.length ? [eliteTip(elites)] : [];
			for (const x of s.goals) if (x.tip && !tips.includes(x.tip)) tips.push(x.tip);
			if (i === 0 && k === 0) tips.unshift(greyTip);
			if (tips.length) L.push(`  tip ${tips.join(' ')}`);
			for (const goal of s.goals) L.push(`  ${goal.text}`);
		});
		return { id: g.id, file: `${g.id}.guide`, text: `${L.join('\n')}\n`, levels: [g.lo, g.hi], zones: g.zones, quests: quests.size, seconds: g.seconds };
	});
}

module.exports = { completionistGuides, eliteTargets, straightTurnins, band };
