'use strict';
// Paired profession guides: one route that levels a gathering profession and the crafting profession it
// feeds together (Herbalism + Alchemy, Mining + Blacksmithing, Mining + Engineering, Skinning +
// Leatherworking), built by `profession gathering build` beside the single guides. The crafting side is
// the crafting guide's own plan and steps (guide.js draftGuide: recipes, trainers, vendor goods, forks,
// counts for 9 players in 10); the gathering side is the gathering guide's bands and loops (gathering/
// build.js plan). They are blended stretch by stretch, the flow players follow: before each crafting
// stretch, a gathering step whose loop gives that stretch's materials, sized to what it still needs
// after what earlier gathering left in the bags, and which raises the gathering skill as it goes; then
// the craft. Rules (docs/forge/professions.md, "Profession guide rules"):
//   - a gather step's loops are those of the gathering band the skill is in (never a band above it), its
//     `collect` the loop target (the arrow walks the loop until the bags hold the stretch's materials),
//     other materials of the stretch bag counts, each with its Auction House way;
//   - when the next stretch needs a material the skill cannot gather yet, catch-up steps (skill goals on
//     the gathering guide's loops) bring it there first, and a skill floor step guards a band change;
//   - gathering ranks are trained at the crafting trainer visit when the skill allows (one trip), else on
//     their own step where the gathering guide trains them; the smelts a bar needs are learned before it;
//   - the gathering skill reaches 300 before the last crafting stretch (a section the crafting skill
//     has passed is done, so nothing may come after it);
//   - counts are cumulative within a crafting section, as the engine's section counts expect
//     (docs/GUIDE_FORMAT.md, "Sections").
// The simulation of the gathering skill uses the gathering guide's own numbers: a loop's skill-ups per
// node (farm.js `gain` over the nodes up on a lap) and what a node gives (players' recorded gathers,
// build.js bandYield), averaged over the band's loops.

const { draftGuide, draftData, itemLoops } = require('./guide');
const B = require('./gathering/build');
const { GUIDE_HEADER, money, fmt, rankInfo } = require('./gathering/common');
const D = require('./describe');

// The pairs: gathering first (the `skills` header order).
const PAIRS = [
	{ file: 'herbalism-alchemy', gather: 'Herbalism', craft: 'Alchemy', verb: 'Pick', doing: 'herbalism', zone: 'Orgrimmar' },
	{ file: 'mining-blacksmithing', gather: 'Mining', craft: 'Blacksmithing', verb: 'Mine', doing: 'mining', zone: 'Ironforge' },
	{ file: 'mining-engineering', gather: 'Mining', craft: 'Engineering', verb: 'Mine', doing: 'mining', zone: 'Ironforge' },
	{ file: 'skinning-leatherworking', gather: 'Skinning', craft: 'Leatherworking', verb: 'Skin', doing: 'skinning', zone: 'Orgrimmar' },
];

// A share of a stretch's material below this many is not worth a step of its own: the next step's loop
// gives it (rounding noise of the simulation).
const MIN_SHORT = 3;

let dataCache = null;
function dataFor(ctx) {
	if (!dataCache || dataCache.dir !== ctx.data.dir) dataCache = { dir: ctx.data.dir, data: draftData(ctx.data.dir) };
	return dataCache.data;
}

// The draft's lines as blocks: { step: title, lines: [step line, its indented lines] } or { raw: line }.
function blocks(text) {
	const out = [];
	for (const l of text.replace(/\n+$/, '').split('\n')) {
		if (/^step /.test(l)) out.push({ step: l.slice(5), lines: [l] });
		else if (/^ {2}\S/.test(l) && out.length && out[out.length - 1].step !== undefined) out[out.length - 1].lines.push(l);
		else out.push({ raw: l });
	}
	return out;
}

const roundDown = (v) => Math.max(1, Math.floor(v / 5) * 5);

// The gathering side: the gathering guide's plan, each band with its rates (per node gathered: skill
// points, items) and its loops.
function gatherTrack(ctx, gprof) {
	return B.plan(ctx, gprof).map((e) => {
		if (e.kind !== 'band') return { ...e };
		let gain = 0;
		let lap = 0;
		let up = 0;
		const items = new Map();
		const perLoop = [];
		for (const l of e.loops) {
			const f = l.farm;
			gain += f.gain / f.up;
			lap += B.lapSeconds(gprof, f);
			up += f.up;
			const y = new Map(B.bandYield(ctx, gprof, f.on, f.up).map((x) => [x.item, x.count]));
			perLoop.push(y);
			for (const [item, n] of y) items.set(item, (items.get(item) || 0) + n / f.up);
		}
		const n = e.loops.length;
		for (const [k, v] of items) items.set(k, v / n);
		return { ...e, rate: { gain: gain / n, items, lap: lap / n, up: up / n }, perLoop };
	});
}

// The smelts of Mining (bar -> recipe) and the ore a bar comes from, per bar: [{ raw, per }] (bars per ore).
function smeltsOf(ctx) {
	const mining = ctx.data.professionNamed('Mining') || {};
	return new Map((mining.recipes || []).filter((r) => r.source === 'trainer' && /^Smelt /.test(r.name) && r.item).map((r) => [r.item, r]));
}

function rawsOf(item, smelts, gathered, depth = 0) {
	if (gathered.has(item)) return [{ raw: item, per: 1 }];
	const r = smelts.get(item);
	if (!r || depth > 2) return null;
	const out = [];
	for (const g of r.reagents) {
		const sub = rawsOf(g.item, smelts, gathered, depth + 1);
		if (!sub) continue; // a vendor reagent (Coal for Steel)
		for (const s of sub) out.push({ raw: s.raw, per: (s.per * (r.itemCount || 1)) / g.count });
	}
	return out.length ? out : null;
}

function renderPair(ctx, pair) {
	const data = dataFor(ctx);
	const { SPECS } = require('./gathering/specs');
	const gprof = SPECS.find((p) => p.skill === pair.gather);
	const G = pair.gather;
	const P = pair.craft;
	const draft = draftGuide(P, data);
	const itemName = (id) => (ctx.data.item(id) || {}).name || `item ${id}`;
	const track = gatherTrack(ctx, gprof);
	const smelts = smeltsOf(ctx);
	// What the gathering side gives: every item a band's loops give at a twentieth of their yield or more.
	const gathered = new Set();
	for (const e of track) {
		for (const y of e.perLoop || []) {
			const all = [...y.values()].reduce((a, n) => a + n, 0);
			for (const [item, n] of y) if (n >= all / 20) gathered.add(item);
		}
	}
	const partner = (item) => rawsOf(item, smelts, gathered);
	const segs = [...draft.plan.segments.map((s) => ({ seg: s, path: 'A' })), ...(draft.alt ? draft.alt.segments.map((s) => ({ seg: s, path: 'B' })) : [])];
	const lastOf = { A: draft.plan.segments[draft.plan.segments.length - 1], B: draft.alt ? draft.alt.segments[draft.alt.segments.length - 1] : null };

	// ------------------------------------------------------------ simulation state
	// g: the gathering skill expected; ptr: the next gathering track entry; cap: the gathering rank's cap;
	// pending: gathering ranks and recipes due but not trained yet (they wait for a crafting trainer visit,
	// or until the skill needs them); stock: what gathering left in the bags (item -> count); floor: the
	// highest gathering skill a step has asked so far; cum: counts asked in the current section.
	let st = { g: 1, ptr: 0, cap: 75, pending: [], stock: new Map(), learned: new Set(), floor: 1, cum: new Map(), sinceTrainer: false };
	const clone = (s) => ({ ...s, pending: s.pending.slice(), stock: new Map(s.stock), learned: new Set(s.learned), cum: new Map(s.cum) });
	const report = { gathered: new Map(), stretches: 0, seconds: 0, catchUp: 0, farmed: 0 };
	const out = [];
	let when = null; // the current fork path's `when` line
	const push = (lines) => {
		const [head, ...rest] = lines;
		out.push('', head);
		if (when) out.push(when);
		out.push(...rest);
	};
	// A gathering track entry (a rank or its recipes) as goals and a sentence.
	const trainLines = (e) => {
		const lines = [];
		if (e.kind === 'train') {
			lines.push(`  train ${G} ${e.rank.name}`);
			st.cap = Math.max(st.cap, e.rank.max);
		}
		for (const r of e.recipes || []) {
			lines.push(`  learn ${r.spell}`);
			st.learned.add(r.spell);
		}
		return lines;
	};
	const trainText = (e) => {
		const recipes = (e.recipes || []).map((r) => `${r.name} (${money(r.cost)})`);
		if (e.kind === 'train') {
			const info = rankInfo(ctx, G, e.rank.name) || {};
			return `Train ${e.rank.name} ${G} on this visit too: it raises ${G}'s cap to ${e.rank.max}, needs ${G} ${e.rank.learnAt}${info.cost ? ` and costs ${money(info.cost)}` : ''} (the arrow picks the nearest ${G} trainer of your faction)${recipes.length ? `; learn ${D.list(recipes)} there too` : ''}.`;
		}
		return `A ${G} trainer also teaches ${D.list(recipes)}: ${gprof.recipesWhy}`;
	};
	// Train what is pending (before the skill passes the cap, or when nothing else takes it).
	const trainPending = () => {
		for (const e of st.pending) {
			const title = e.kind === 'train' ? `${e.rank.name} ${G}` : (e.recipes || []).map((r) => r.name).join(' & ');
			push([`step ${title}`, `  tip ${trainText(e).replace(/^Train (.*?) on this visit too: it/, '$1')}`, ...trainLines(e)]);
		}
		st.pending = [];
		st.sinceTrainer = false;
	};
	const band = () => {
		const e = track[st.ptr];
		return e && e.kind === 'band' ? e : null;
	};
	// Move past the band entries the skill has finished; ranks and recipes that fall due wait in `pending`.
	const settle = () => {
		for (;;) {
			const e = track[st.ptr];
			if (!e) return;
			if (e.kind === 'learn') st.ptr++;
			else if (e.kind === 'band' && st.g >= e.to - 1e-9) st.ptr++;
			else if ((e.kind === 'train' && st.g + 1e-9 >= e.rank.learnAt) || (e.kind === 'recipes' && st.g + 1e-9 >= e.at)) {
				st.pending.push(e);
				st.ptr++;
			} else return;
		}
	};
	// Before gathering in band e: the rank its top needs, and the skill its loops need.
	const ready = (e) => {
		if (e.to > st.cap && st.pending.some((x) => x.kind === 'train')) trainPending();
		floorFor(e);
	};
	const loopsGain = (e) => e.loops.map((l) => B.loopLine(ctx, gprof, l));
	// The band's loops as `yield` loops for a collect item (its raws: [{ raw, per }]): what one lap gives of it.
	const loopsYield = (e, raws) =>
		e.loops
			.map((l, i) => {
				const y = Math.min(...raws.map((r) => (e.perLoop[i].get(r.raw) || 0) * r.per));
				return y >= 0.5 ? B.loopLine(ctx, gprof, l).replace(/ gain [\d.]+ /, ` yield ${fmt(y)} `) : null;
			})
			.filter(Boolean);
	// Gather `n` nodes in band e (`skill` false: a band the skill is past, no points): skill, stock and the
	// report move on.
	const gatherNodes = (e, n, skill = true) => {
		const from = st.g;
		if (skill) st.g = Math.min(e.to, st.g + n * e.rate.gain);
		for (const [item, per] of e.rate.items) {
			st.stock.set(item, (st.stock.get(item) || 0) + n * per);
			report.gathered.set(item, (report.gathered.get(item) || 0) + n * per);
		}
		report.seconds += (n / e.rate.up) * e.rate.lap;
		return { from, to: st.g };
	};
	// A skill-only step on band e's loops from skill `from` to `to` (catch-up, the end, or a floor).
	const skillStep = (e, from, to, tip) => {
		const nodes = B.nodeSummary(gprof, e.loops.flatMap((l) => l.farm.on), e.from, e.to);
		push([`step ${G} ${from}-${to}: ${gprof.bandTitle(nodes, e)}`, `  tip ${tip}`, ...loopsGain(e), `  skill ${G} ${to}`]);
		st.floor = Math.max(st.floor, to);
		st.sinceTrainer = true;
	};
	// Keep the skill at or above band e's start: the loops of e need it (a step most players find done).
	const floorFor = (e) => {
		if (st.floor >= e.from) return;
		const prev = [...track.slice(0, st.ptr)].reverse().find((x) => x.kind === 'band');
		if (prev) skillStep(prev, Math.floor(st.floor), e.from, `${G} ${e.from} first: the next loops need it. Most players are past it already from the steps above, and then this step is done.`);
		st.floor = Math.max(st.floor, e.from);
	};
	// The skill to `to`, band by band on the gathering guide's loops: catch-up or the finish.
	const raiseTo = (to, why) => {
		settle();
		for (let e = band(); e && st.g < to - 1e-9; e = band()) {
			ready(e);
			const target = Math.min(e.to, to);
			const n = (target - st.g) / e.rate.gain;
			const { from } = gatherNodes(e, n);
			report.catchUp += n;
			const got = [...e.rate.items].map(([item, per]) => ({ item, n: Math.round((n * per) / 5) * 5 })).filter((x) => x.n >= 5);
			const yields = got.length ? ` The loop also gives about ${D.list(got.slice(0, 4).map((x) => `${x.n} ${itemName(x.item)}`))}: keep them, the next stretches use them.` : '';
			skillStep(e, Math.floor(from), target, `${why(Math.floor(from), target)}${yields} ${PICK}`);
			settle();
		}
	};
	const PICK = `The arrow takes the loop that gets you there soonest from where you are and walks it; each loop keeps to creatures no more than a level above you and away from the other faction's towns, and the window names it and its lap.`;
	// Where to gather an item: the band the skill is in while its loops give at least half of what the best
	// band reachable so far gives per node (a trickle of it is no place to farm 240 of it); past that, the
	// richest band below when one gives half of the best of all (no more skill-ups there), else the first
	// band above that does (the skill catches up to it first).
	const RICH = 0.5;
	const bands = track.filter((x) => x.kind === 'band');
	const rate = (e, raw) => (e && e.rate.items.get(raw)) || 0;
	const bestOf = (list, raw) => list.reduce((m, x) => Math.max(m, rate(x, raw)), 0);
	const below = (e) => bands.filter((x) => x.from <= (e ? e.from : 300));
	const here = (e, raw) => !!e && rate(e, raw) > 0 && rate(e, raw) >= RICH * bestOf(below(e), raw);
	const lowerBest = (e, raw) => (bestOf(below(e), raw) >= RICH * bestOf(bands, raw) ? below(e).slice().sort((a, b) => rate(b, raw) - rate(a, raw) || b.from - a.from)[0] : null);
	const above = (e, raw) => bands.find((x) => e && x.from >= e.to && rate(x, raw) >= RICH * bestOf(bands, raw)) || null;

	// The gathering for one crafting stretch: materials `collects` ([{ item, count, raws }]).
	const gatherFor = (seg, collects) => {
		const need = new Map();
		for (const c of collects) for (const r of c.raws) need.set(r.raw, (need.get(r.raw) || 0) + c.count / r.per);
		const short = () => {
			const s = new Map();
			for (const [raw, n] of need) if (n - (st.stock.get(raw) || 0) >= MIN_SHORT) s.set(raw, n - (st.stock.get(raw) || 0));
			return s;
		};
		const fromStock = new Map([...need].map(([raw, n]) => [raw, Math.min(st.stock.get(raw) || 0, n)]));
		const src = new Map(); // raw -> { e, skill } where it was gathered
		let range = null; // the skill range of the final gathering
		for (let guard = 0; guard < 40; guard++) {
			settle();
			const s = short();
			if (!s.size) break;
			const e = band();
			const now = [...s.keys()].filter((raw) => here(e, raw));
			if (!now.length) {
				const lower = [...s.keys()].map((raw) => [raw, lowerBest(e, raw)]).filter(([, x]) => x);
				const up = [...s.keys()].filter((raw) => !lower.some(([r]) => r === raw)).map((raw) => [raw, above(e, raw)]).filter(([, x]) => x);
				if (up.length) {
					// A band above gives it: catch up there first.
					const next = up.map(([, x]) => x).sort((a, b) => a.from - b.from)[0];
					const names = D.list(up.filter(([, x]) => x === next).map(([raw]) => itemName(raw)));
					raiseTo(next.from, (a, b) => `${G} ${a} to ${b} before ${seg.recipe.name}: its ${names} come from ${G} ${next.from}.`);
					continue;
				}
				// The skill is past the bands that give it best: farm it there, no skill-ups.
				for (const [raw, at] of lower) {
					const n = s.get(raw) / rate(at, raw);
					gatherNodes(at, n, false);
					report.farmed += n;
					src.set(raw, { e: at, skill: false });
				}
				range = range || [st.g, st.g];
				break;
			}
			const here_ = now;
			ready(e);
			const n = Math.max(...here_.map((raw) => s.get(raw) / rate(e, raw)));
			const toEnd = (e.to - st.g) / e.rate.gain;
			for (const raw of here_) src.set(raw, { e, skill: true });
			if (n <= toEnd + 1e-9) {
				const { from, to } = gatherNodes(e, n);
				range = [from, to];
				continue;
			}
			// The band ends first: gather it to its end (skill goal), then on in the next band.
			const a = Math.floor(st.g);
			gatherNodes(e, toEnd);
			skillStep(e, a, e.to, `${pair.verb} from ${G} ${a} to ${e.to} for ${seg.recipe.name}: this loop gives ${D.list(here_.map(itemName))}, and the next one the rest from ${G} ${e.to}. ${PICK}`);
			settle();
		}
		range = range || [st.g, st.g];
		// The step that collects the stretch's materials: the main one (most to gather) is the loop target.
		const counts = collects.map((c) => {
			const prev = st.cum.get(c.item) || 0;
			st.cum.set(c.item, prev + c.count);
			return { ...c, total: prev + c.count };
		});
		for (const [raw, n] of need) st.stock.set(raw, Math.max(0, (st.stock.get(raw) || 0) - n));
		const weight = (c) => Math.max(...c.raws.map((r) => c.count / r.per - (fromStock.get(r.raw) || 0)));
		const main = counts.slice().sort((a, b) => weight(b) - weight(a) || a.item - b.item)[0];
		const where = main.raws.map((r) => src.get(r.raw)).find(Boolean) || null;
		let loops = where ? loopsYield(where.e, main.raws) : [];
		let skillAsk = where ? where.e.from : 1;
		if (!loops.length) {
			// Nothing gathered for it here (the bags hold it): the gathering guides' best loops for it.
			const raw = main.raws.slice().sort((a, b) => a.per - b.per)[0];
			const l = itemLoops(data, raw.raw, raw.per);
			loops = l ? l.lines : [];
			skillAsk = l ? l.skill : 1;
		}
		const made = (c) => c.raws.length > 1 || c.raws[0].raw !== c.item;
		const ask = (c) => Math.max(skillAsk, ...(made(c) ? [(smelts.get(c.item) || {}).learnedAt || 1] : []));
		const kept = [...need].map(([raw, n]) => ({ raw, n: Math.round(fromStock.get(raw) || 0), of: Math.round(n) })).filter((x) => x.n >= MIN_SHORT);
		const toGet = [...need].map(([raw, n]) => ({ raw, n: Math.max(0, Math.ceil(n - (fromStock.get(raw) || 0))) })).filter((x) => x.n >= MIN_SHORT);
		const smeltNames = counts.filter(made).map((c) => `${c.count} ${itemName(c.item)}`);
		const [g0, g1] = range.map(Math.floor);
		const rise = g1 > g0 ? ` (${G} ${g0} to ${g1})` : (where && !where.skill) || !toGet.length ? '' : ` (${G} ${g0})`;
		const lower = where && !where.skill ? ` at the loops of ${G} ${where.e.from}-${where.e.to}, the richest in it (they give no more points)` : '';
		const flow = `${toGet.length ? `${pair.verb} ${D.list(toGet.map((x) => `${x.n} ${itemName(x.raw)}`))}${rise}${lower}` : 'Your bags hold it already'}${smeltNames.length ? `, smelt ${D.list(smeltNames)} at a forge` : ''}, then craft ${D.crafts(seg.count, seg.recipe.name)} (${P} ${seg.from} to ${seg.to}).`;
		const why = `${D.list(counts.map((c) => `${c.count} ${itemName(c.item)}`))} for ${P} ${seg.from}-${seg.to}: ${D.crafts(seg.count90 || seg.count, seg.recipe.name)}${kept.length ? `; from your ${pair.doing} on the way: ${D.list(kept.map((x) => `${x.n} of ${x.of} ${itemName(x.raw)}`))}` : ''}.`;
		const raws = [...need.keys()].map(itemName);
		const bars = counts.filter(made).map((c) => itemName(c.item));
		const title = `${pair.verb} ${D.list(raws)}${bars.length ? `, smelt ${D.list(bars)}` : ''}${g1 > g0 ? ` (${G} ${g0}-${g1})` : ''}`;
		const lines = [`step ${title}`];
		lines.push(`  tip ${why} ${flow} The arrow takes the ${G} loop that gets you them soonest from where you are and walks it until your bags hold them; the window names the loop, its lap and the laps left. Or buy them at the Auction House.`);
		lines.push(`  collect ${main.item} x${main.total} gather ${G} ${ask(main)}`);
		lines.push(...loops);
		for (const c of counts) if (c !== main) lines.push(`  collect ${c.item} x${c.total} anywhere gather ${G} ${ask(c)}`);
		for (const c of counts) lines.push(`  auction ${c.item} x${c.total}`);
		push(lines);
		st.sinceTrainer = true;
		report.stretches++;
	};
	// The smelts the stretch's bars need, learned before the gathering (a trainer step of their own when
	// the gathering track has not taught them).
	const smeltsFor = (collects) => {
		const want = [];
		const add = (item) => {
			const r = smelts.get(item);
			if (!r || gathered.has(item)) return;
			if (!st.learned.has(r.spell) && r.learnedAt > 1 && !want.includes(r)) want.push(r);
			for (const g of r.reagents) add(g.item);
		};
		for (const c of collects) add(c.item);
		if (!want.length) return;
		push([`step ${want.map((r) => r.name).join(' & ')}`, `  tip A Mining trainer teaches ${D.list(want.map((r) => `${r.name} (Mining ${r.learnedAt}, ${money(r.cost)})`))}: the bars of the next stretch are smelted from what you mine.`, ...want.map((r) => `  learn ${r.spell}`)]);
		for (const r of want) st.learned.add(r.spell);
	};

	// ------------------------------------------------------------ the blend
	const bl = blocks(draft.text);
	const headerEnd = bl.findIndex((b) => b.step !== undefined || /^section |^# -{10,}/.test(b.raw || ''));
	const comments = bl.slice(0, headerEnd).filter((b) => /^#/.test(b.raw || '') && !/^# Generated by /.test(b.raw)).map((b) => b.raw);
	let held = []; // recipe visits and quest plans waiting for their craft step
	let forkSnap = null;
	const isTrainer = (b) => new RegExp(`^(Learn ${P}|(Journeyman|Expert|Artisan) ${P}|${P} recipes (at|for) )`).test(b.step);
	// Merge what the gathering track has pending into a crafting trainer visit: one trip for both.
	const mergeDue = (b) => {
		settle();
		if (!st.pending.length) return b.lines;
		const add = st.pending.flatMap(trainLines);
		const texts = st.pending.map(trainText);
		st.pending = [];
		const lines = b.lines.slice();
		const tip = lines.findIndex((l) => /^ {2}tip /.test(l));
		if (tip >= 0) lines[tip] = `${lines[tip]} ${texts.join(' ')}`;
		return [...lines, ...add];
	};
	const emitBlock = (b) => {
		if (b.raw !== undefined) {
			out.push(b.raw);
			if (/^section /.test(b.raw)) st.cum = new Map();
			return;
		}
		let lines = b.lines.slice(1).filter((l) => !/^ {2}when /.test(l));
		if (isTrainer(b)) {
			lines = mergeDue({ lines: [b.lines[0], ...lines] }).slice(1);
			if (st.sinceTrainer) lines = lines.map((l) => l.replace(/^( {2}tip )Still at the (\S+) trainer: /, '$1Back to the $2 trainer: '));
			lines = lines.map((l) => (/^ {2}tip /.test(l) ? l.replace(/ Come with all of it in your bags[^]*?One trip instead of \d+\./, ' The gathering steps below come between the visits: learn each recipe when you are back for it.') : l));
			st.sinceTrainer = false;
		}
		push([b.lines[0], ...lines]);
	};
	for (let i = headerEnd; i < bl.length; i++) {
		const b = bl[i];
		if (b.raw !== undefined) {
			emitBlock(b);
			continue;
		}
		const w = b.lines.find((l) => /^ {2}when /.test(l)) || null;
		// A fork: path A goes on from the state at the fork, path B starts again from it.
		if (w && w !== when) {
			if (/!knows/.test(w)) {
				if (forkSnap) st = clone(forkSnap);
			} else if (!forkSnap) forkSnap = clone(st);
		}
		when = w;
		if (b.step === `Learn ${P}`) {
			// The first visit: both professions.
			const lines = b.lines.slice(1);
			const tip = lines.findIndex((l) => /^ {2}tip /.test(l));
			lines[tip] = `${lines[tip]} Learn Apprentice ${G} on the same trip: any ${G} trainer of your faction teaches it at any level, and the arrow picks the nearest.${gprof.tool ? ` Buy a ${gprof.tool.name} from a trade goods or general vendor: ${gprof.tool.why}` : ''}`;
			lines.splice(lines.findIndex((l) => /^ {2}train /.test(l)) + 1, 0, `  train ${G} Apprentice`, ...(gprof.tool ? [`  buy ${gprof.tool.item} x1 nearest`] : []));
			if (track[0] && track[0].kind === 'learn') st.ptr = 1;
			push([`step Learn ${G} and ${P}`, ...lines]);
			continue;
		}
		// A Get it step for what the blend gathers (the gathering side's loops give it, or it is smelted from
		// what they give) is replaced by the stretches' gather steps; a placed one (a hide at its beasts) stays.
		const collect = b.lines.map((l) => /^ {2}collect (\d+) x\d+ (?!@).*gather (\S+) /.exec(l)).find(Boolean);
		if (/^Get /.test(b.step) && collect && collect[2] === G && partner(Number(collect[1]))) {
			continue; // the blend gathers it stretch by stretch
		}
		const craft = b.lines.map((l) => /^ {2}craft (\d+) until (\d+)/.exec(l)).find(Boolean);
		if (!craft) {
			if (/ recipes at \d+$/.test(b.step) || b.lines.some((l) => /^ {2}accept /.test(l))) held.push(b);
			else emitBlock(b);
			continue;
		}
		const path = w && /!knows/.test(w) ? 'B' : 'A';
		const found = segs.find((x) => x.path === (draft.alt ? path : 'A') && x.seg.recipe.spell === Number(craft[1]) && x.seg.to === Number(craft[2]));
		if (!found) throw new Error(`${pair.file}: no plan segment for ${b.step}`);
		const seg = found.seg;
		const collects = seg.need.map((n) => ({ item: n.item, count: n.count, raws: partner(n.item) })).filter((c) => c.raws);
		if (collects.length) {
			smeltsFor(collects);
			gatherFor(seg, collects);
		}
		if (seg === lastOf[found.path]) raiseTo(300, (a, c) => `${G} ${a} to ${c} before the last stretch: the guide ends with ${P}, so finish ${G} here.`);
		for (const h of held) emitBlock(h);
		held = [];
		emitBlock(b);
	}
	for (const h of held) emitBlock(h);

	// ------------------------------------------------------------ header
	const gatheredTotal = [...report.gathered].filter(([, n]) => n >= 5).sort((a, b) => b[1] - a[1]);
	const head = [
		GUIDE_HEADER,
		`guide forever/professions/${pair.file}`,
		`title ${G} + ${P} 1-300`,
		'category Professions',
		'kind profession',
		`skills ${G}, ${P}`,
		'levels 5-60',
		'zone Azeroth',
		'',
		...wrap(`${G} and ${P} 1-300 together, for both factions: each ${P} stretch starts with a ${G} loop sized to what that stretch needs, which also raises ${G}, and the craft follows with the materials in your bags. Spares carry to the next stretch, and when a stretch needs what ${G} cannot gather yet, ${G} catches up first. ${G} ranks are trained at the ${P} trainer visit when the skill allows. ${G} reaches 300 before the last ${P} stretch.`),
		'#',
		...wrap(`The ${G} loops are the ${G} guide's (densest ground at a safe level, picked where you are); the ${P} route, its recipes, trainers, vendor goods and counts the ${P} guide's (enough for 9 players in 10). Anything ${G} does not give is bought or farmed as there (Gather, Buy or Mix).`),
		'#',
		...wrap(`ASSUMED: how far ${G} rises on a stretch's materials is the ${G} guide's expected skill-ups per node on the band's loops and what players' recorded gathers gave per node, averaged over the band's loops.`),
		...wrap(`About ${Math.round(report.seconds / 3600)} hours of ${pair.doing} in ${report.stretches} gathering stretches; it gathers about ${D.list(gatheredTotal.slice(0, 6).map(([item, n]) => `${Math.round(n / 10) * 10} ${itemName(item)}`))}.`),
		'#',
		...comments,
		'',
	];
	const text = `${[...head, ...out].join('\n').replace(/\n{3,}/g, '\n\n').replace(/\n+$/, '')}\n`;
	return { text, report };
}

function wrap(text, width = 100) {
	const out = [];
	let cur = '#';
	for (const w of text.split(' ')) {
		if (`${cur} ${w}`.length > width && cur !== '#') {
			out.push(cur);
			cur = `# ${w}`;
		} else cur = `${cur} ${w}`;
	}
	if (cur !== '#') out.push(cur);
	return out;
}

// ------------------------------------------------------------ Tailoring + Enchanting
// Neither gathers: the cloth comes from the mobs a player kills (or the Auction House), and Enchanting's dust
// and essences from disenchanting green gear. The blend flows that way: each rank bracket levels Tailoring
// first, then Enchanting, and the green armour Tailoring made in the bracket is disenchanted for it. The
// counts are honest: what disenchanting the bracket's own crafts gives (disenchant.json: Forever's server
// data for each item level, the client's item levels), set against what Enchanting asks; the rest is
// bought or looted, as in the Enchanting guide. Disenchanting asks Enchanting skill by item level (Classic's
// rule, ASSUMED): Tailoring's greens of a bracket are disenchanted when Enchanting has reached that bracket.
const DE = require('./disenchant.json');
// The Enchanting skill disenchanting an item of this level asks (Classic's).
const deSkill = (ilvl) => (ilvl <= 20 ? 1 : ilvl <= 25 ? 25 : ilvl <= 30 ? 50 : ilvl <= 35 ? 75 : ilvl <= 40 ? 100 : ilvl <= 45 ? 125 : ilvl <= 50 ? 150 : ilvl <= 55 ? 175 : ilvl <= 60 ? 200 : 225);
const CAPS = [75, 150, 225, 300];

// What disenchanting `n` of a green armour piece of item level `ilvl` gives: Map(item -> expected count).
function disenchant(ilvl, n) {
	const band = DE.bands.find((b) => ilvl >= b.ilvl[0] && ilvl <= b.ilvl[1]);
	const out = new Map();
	for (const l of (band && band.loot) || []) out.set(l.item, (out.get(l.item) || 0) + (n * l.chance * (l.min + l.max)) / 200);
	return out;
}

// A draft's blocks after its header, grouped by rank bracket (the cap of each section's range).
function byBracket(text) {
	const bl = blocks(text);
	const start = bl.findIndex((b) => b.step !== undefined || /^section |^# -{10,}/.test(b.raw || ''));
	const groups = new Map(CAPS.map((c) => [c, []]));
	let cap = 75;
	for (let i = start; i < bl.length; i++) {
		const b = bl[i];
		const sec = /^section .* (\d+)-(\d+)$/.exec(b.raw || '');
		const banner = /^# -{10,} .*\((\d+)-(\d+)\)$/.exec(b.raw || '');
		const m = sec || banner;
		if (m) cap = CAPS.find((c) => c >= Number(m[2])) || 300;
		groups.get(cap).push(b);
	}
	return { header: bl.slice(0, start), groups };
}

function renderCloth(ctx) {
	const data = dataFor(ctx);
	const T = draftGuide('Tailoring', data);
	const E = draftGuide('Enchanting', data);
	const itemName = (id) => (ctx.data.item(id) || {}).name || `item ${id}`;
	const t = byBracket(T.text);
	const e = byBracket(E.text);
	// The Tailoring fork (Runecloth Shoulders' pattern at 265): its paths come last, after Enchanting 225-300,
	// since a path's last step may say what is left of Tailoring and hold there.
	const forkAt = T.alt ? T.alt.segments[0].from : 301;
	// Per bracket: the greens Tailoring makes before the fork and what disenchanting them gives.
	const greens = (segs, cap) =>
		segs
			.filter((s) => (CAPS.find((c) => c > s.from) || 300) === cap && s.from < forkAt && DE.tailoring[s.recipe.item])
			.map((s) => ({ name: s.recipe.name, n: s.count * (s.recipe.itemCount || 1), ilvl: DE.tailoring[s.recipe.item], from: s.from, to: s.to }));
	const yields = (list) => {
		const out = new Map();
		for (const g of list) for (const [item, n] of disenchant(g.ilvl, g.n)) out.set(item, (out.get(item) || 0) + n);
		return out;
	};
	const report = { de: new Map(), asked: new Map() };
	const out = [];
	const emit = (b) => out.push(...(b.raw !== undefined ? [b.raw] : b.lines));
	let enchantAt = 1; // the Enchanting skill the route has reached when a bracket's greens come
	for (const cap of CAPS) {
		const tb = t.groups.get(cap);
		// The fork's blocks: from the section or banner that opens the fork step's range on.
		let cut = tb.findIndex((b) => b.step !== undefined && b.lines.some((l) => /^ {2}when /.test(l)));
		if (cut >= 0) {
			while (cut > 0 && (tb[cut - 1].raw !== undefined || !tb[cut - 1].lines.some((l) => /^ {2}craft /.test(l)))) cut--;
		} else cut = tb.length;
		// Both ranks on one visit: an Enchanting rank any trainer teaches is trained at the Tailoring rank's
		// visit (the city trainers stand in the same capitals); a rank only a few trainers teach keeps its trip.
		const eRank = e.groups.get(cap).find((b) => b.step !== undefined && /^(Journeyman|Expert|Artisan) Enchanting$/.test(b.step));
		const eTrain = eRank && eRank.lines.find((l) => /^ {2}train Enchanting \w+$/.test(l));
		const eLevel = eRank && eRank.lines.find((l) => /^ {2}level \d+$/.test(l));
		for (const b of tb.slice(0, cut)) {
			if (eTrain && b.step !== undefined && /^(Journeyman|Expert|Artisan) Tailoring$/.test(b.step)) {
				const lines = b.lines.slice();
				const tip = lines.findIndex((l) => /^ {2}tip /.test(l));
				const rank = eRank.step.split(' ')[0];
				const need = { Journeyman: 50, Expert: 125, Artisan: 200 }[rank];
				lines[tip] = `${lines[tip]} Train ${rank} Enchanting on the same trip (it needs Enchanting ${need}${eLevel ? ` and character level ${eLevel.trim().split(' ')[1]}` : ''}; the arrow picks the nearest Enchanting trainer who teaches it): the Enchanting steps below need it.`;
				const at = lines.findIndex((l) => /^ {2}train Tailoring /.test(l));
				lines.splice(at + 1, 0, '  train Enchanting ' + rank);
				emit({ lines });
			} else emit(b);
		}
		const a = greens(T.plan.segments, cap);
		const got = yields(a);
		for (const [item, n] of got) report.de.set(item, (report.de.get(item) || 0) + n);
		const later = a.filter((g) => deSkill(g.ilvl) > enchantAt);
		const listOf = (m) => D.list([...m].filter(([, n]) => n >= 1).sort((x, y) => y[1] - x[1]).map(([item, n]) => `${Math.round(n)} ${itemName(item)}`));
		const deText = a.length
			? `Disenchant the green armour you made for Tailoring ${cap === 75 ? 1 : CAPS[CAPS.indexOf(cap) - 1]}-${cap}: ${D.list(a.map((g) => `${D.crafts(Math.round(g.n), g.name)}${deSkill(g.ilvl) > 1 ? ` (item level ${g.ilvl}, from Enchanting ${deSkill(g.ilvl)})` : ''}`))} give about ${listOf(got)}.${later.length ? ` ${D.list(later.map((g) => g.name))} ${later.length > 1 ? 'ask' : 'asks'} more Enchanting than you have at the bracket's start: keep ${later.length > 1 ? 'them' : 'it'} and disenchant ${later.length > 1 ? 'them' : 'it'} as your skill gets there.` : ''}`
			: '';
		// The Enchanting bracket: the disenchanting line leads its rank step (else its first step), and each
		// dust's Get it step says how much of it the Tailoring crafts give.
		const eb = e.groups.get(cap);
		const lead = eb.find((b) => b.step !== undefined && /^(Learn|Journeyman|Expert|Artisan) Enchanting$/.test(b.step)) || eb.find((b) => b.step !== undefined);
		for (const b of eb) {
			if (b.raw !== undefined) {
				out.push(b.raw);
				continue;
			}
			const lines = b.lines.slice();
			const tip = lines.findIndex((l) => /^ {2}tip /.test(l));
			if (b === lead && deText && tip >= 0) lines[tip] = `  tip ${deText} ${lines[tip].slice(6)}`;
			const c = /^Get /.test(b.step) && lines.map((l) => /^ {2}collect (\d+) x(\d+)/.exec(l)).find(Boolean);
			if (c && tip >= 0) {
				const item = Number(c[1]);
				const ask = Number(c[2]);
				report.asked.set(item, (report.asked.get(item) || 0) + ask);
				const n = Math.min(ask, Math.round(got.get(item) || 0));
				const rest = ask - n;
				if (n >= 1) lines[tip] = lines[tip].replace(/^( {2}tip [^.]*\.)/, `$1 Disenchanting your Tailoring crafts of this bracket gives about ${n} of them (see ${lead.step}); ${rest > 0 ? `the other ${rest} come from greens you loot or the Auction House.` : 'that covers them.'}`);
			}
			out.push(...lines);
		}
		for (const b of tb.slice(cut)) emit(b);
		enchantAt = cap;
	}
	const comment = (h) => h.filter((b) => /^#/.test(b.raw || '') && !/^# Generated by /.test(b.raw)).map((b) => b.raw);
	const sum = (m) => [...m.values()].reduce((x, n) => x + n, 0);
	const head = [
		GUIDE_HEADER,
		'guide forever/professions/tailoring-enchanting',
		'title Tailoring + Enchanting 1-300',
		'category Professions',
		'kind profession',
		'skills Tailoring, Enchanting',
		'levels 5-60',
		'zone Azeroth',
		'',
		...wrap('Tailoring and Enchanting 1-300 together, for both factions: neither needs a gathering profession. Each rank bracket levels Tailoring first, then Enchanting, and the green armour Tailoring made in the bracket is disenchanted for Enchanting\'s dust and essences. The Enchanting steps say how much of what they ask your own crafts give; the rest comes from greens you loot or the Auction House (Gather, Buy or Mix).'),
		'#',
		...wrap(`What disenchanting gives is Forever's server data for green armour of each item level, and the item levels the client's; the item level bands and the Enchanting skill disenchanting asks are Classic's (ASSUMED). Over the route your own crafts give about ${Math.round(sum(report.de))} enchanting materials against the ${Math.round(sum(report.asked))} the Enchanting steps ask for.`),
		'#',
		'# Tailoring:',
		...comment(t.header),
		'#',
		'# Enchanting:',
		...comment(e.header),
		'',
	];
	const text = `${[...head, ...out].join('\n').replace(/\n{3,}/g, '\n\n').replace(/\n+$/, '')}\n`;
	return { text, report };
}

// The gathering build's spec entries (gathering/specs.js SPECS): one file each.
const PAIR_SPECS = [...PAIRS.map((p) => ({ file: p.file, pair: p, render: (ctx) => renderPair(ctx, p).text })), { file: 'tailoring-enchanting', render: (ctx) => renderCloth(ctx).text }];

module.exports = { PAIRS, PAIR_SPECS, renderPair, renderCloth, disenchant, gatherTrack, blocks };
