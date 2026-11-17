'use strict';
// flow-diff's numbers (tools/commands/flow-diff.js, docs/ROUTE-FEEL.md "Flow
// diff"): what two trees' plays of the leveling route (tools/lib/flowdiff/play.js)
// do to the route's flow, per guide and per branch.
//
//   const a = measure(baseDump, ctx), b = measure(headDump, ctx);
//   const diff = compare(a, b, { allow });   // -> { guides, revisits, trips, carried, moved, blocking }
//   renderMd(diff)                            // the PR body's table
//
// ctx: { proj (flow/data.js Proj), zones (zones.json), nodes (taxi node id -> [c, wx, wy, map]),
//        legs: { guideId: { step: legString } }, tripYd }
//
// - Zone visits: the zones a play's goals lie in, in order, consecutive repeats
//   merged. A revisit is a visit to a zone the branch (one start's default
//   route, guide after guide) had been in and left before.
// - One-quest trips: a visited step whose work is one quest, more than tripYd
//   yards (or a zone away) from the work of the steps before and after it.
// - Carried: per branch and quest, the guides from its accept to its hand-in
//   (0: the same guide); a span that grew is listed.
// - Travel: walking (the baked leg into a step when it runs from where the
//   player stands to the goal, else the straight line), flights (taxi
//   distance x 1.25 at 30 yd/s + 30 s), 4 minutes per boat, zeppelin or portal,
//   12 s per hearth: the flow audit's prices (flow/walk.js).
// - Moved: a quest's accept or hand-in in another step (guide, step title and
//   its occurrence) of the written guides.

const { WALK_YPS, FLY_YPS, dist, decodeLeg } = require('../flow/data');

const WORK = new Set(['accept', 'turnin', 'complete', 'kill', 'collect', 'use', 'interact', 'talk', 'escort']);

const zoneOf = (ctx, map) => {
	const z = map != null && ctx.zones[String(map)];
	return z && z.name ? z.name : map != null ? `map ${map}` : null;
};

// The acts of one play with their place: { ...act, pos: [c, wx, wy] | null, zone }.
function placed(trace, ctx) {
	return trace.map((a) => {
		if (a.t === 'fly') {
			const n = ctx.nodes.get(a.node);
			return { ...a, pos: n ? n.slice(0, 3) : null, zone: n ? zoneOf(ctx, n[3]) : null };
		}
		const pos = a.map != null && a.x != null ? ctx.proj.at(a.map, a.x, a.y) : null;
		return { ...a, pos, zone: pos ? zoneOf(ctx, a.map) : null };
	});
}

const pathLen = (pts) => {
	let d = 0;
	for (let i = 1; i < pts.length; i++) d += Math.hypot(pts[i][0] - pts[i - 1][0], pts[i][1] - pts[i - 1][1]);
	return d;
};

// Travel seconds of one play: { walk, fly, other, yd }.
function travel(acts, legs) {
	const out = { walk: 0, fly: 0, other: 0, yd: 0 };
	let pos = null;
	let hearthed = false;
	const used = new Set();
	for (const a of acts) {
		if (a.t === 'hearth') {
			out.other += 12;
			hearthed = true;
			continue;
		}
		if (!a.pos) continue;
		if (a.t === 'fly') {
			const d = pos ? dist(pos, a.pos) : Infinity;
			out.fly += (d < Infinity ? d * 1.25 : 3000) / FLY_YPS + 30;
		} else if (pos && !hearthed) {
			if (a.pos[0] !== pos[0]) out.other += 240;
			else {
				let yd = dist(pos, a.pos);
				const leg = legs && !used.has(a.s) ? legs[String(a.s)] : null;
				const pts = leg ? decodeLeg(leg) : null;
				if (pts && Math.hypot(pts[0][0] - pos[1], pts[0][1] - pos[2]) < 120 && Math.hypot(pts[pts.length - 1][0] - a.pos[1], pts[pts.length - 1][1] - a.pos[2]) < 80) {
					yd = pathLen([[pos[1], pos[2]], ...pts, [a.pos[1], a.pos[2]]]);
					used.add(a.s);
				}
				out.walk += yd / WALK_YPS;
				out.yd += yd;
			}
		}
		pos = a.pos;
		hearthed = false;
	}
	return out;
}

// The steps a play visited, in order: { s, title, quests, work, pos (its first
// work's place, else its last walk's end), zone, walk (only `goto`s), ride
// (a flight, hearth or a continent change in it) }.
function stopsOf(acts, guide) {
	const stops = [];
	let pos = null;
	for (const a of acts) {
		let st = stops[stops.length - 1];
		if (!st || st.s !== a.s) {
			st = { s: a.s, title: (guide.steps[a.s - 1] || {}).title || '', quests: new Set(), work: 0, pos: null, zone: null, walk: true, ride: false };
			stops.push(st);
		}
		if (a.t === 'fly' || a.t === 'hearth' || (a.pos && pos && a.pos[0] !== pos[0])) st.ride = true;
		if (a.pos) pos = a.pos;
		if (a.t !== 'goto') st.walk = false;
		if (WORK.has(a.t) && a.q != null) {
			st.quests.add(a.q);
			if (!st.work) {
				st.pos = a.pos;
				st.zone = a.zone;
			}
			st.work++;
		} else if (a.t === 'goto' && !st.work && a.pos) {
			st.pos = a.pos;
			st.zone = a.zone;
		}
	}
	return stops;
}

// The trips of one play: a step whose work is one quest, more than tripYd
// (or a zone) from the work before and after it ("one-quest"), and a walk to
// a place no work follows within tripYd that adds more than tripYd to the way
// from the work before to the work after ("empty": a stop with nothing for
// the player, #2154). A flight, hearth or boat on the way is no trip.
function tripsOf(gid, stops, tripYd) {
	const out = [];
	const yd = (a, b) => (a && b && dist(a, b) < Infinity ? Math.round(dist(a, b)) : null);
	for (let i = 0; i < stops.length; i++) {
		const st = stops[i];
		if (!st.pos) continue;
		let b = i - 1;
		while (b >= 0 && !stops[b].work) b--;
		let n = i + 1;
		while (n < stops.length && !stops[n].work) n++;
		const before = stops[b];
		const after = stops[n];
		// The guide's first or last work is no trip: the guides around it place it.
		if (!before || !after || !before.pos || !after.pos) continue;
		if (stops.slice(b + 1, n + 1).some((x) => x.ride)) continue;
		const row = { guide: gid, s: st.s, title: st.title, zone: st.zone, fromYd: yd(before.pos, st.pos), toYd: yd(st.pos, after.pos), from: before.zone, to: after.zone };
		if (st.work && st.quests.size === 1) {
			const far = (o) => o.zone !== st.zone || dist(o.pos, st.pos) > tripYd;
			if (far(before) && far(after)) out.push({ kind: 'one-quest', quest: [...st.quests][0], ...row });
		} else if (st.walk) {
			const detour = dist(before.pos, st.pos) + dist(st.pos, after.pos) - dist(before.pos, after.pos);
			if (detour < Infinity && detour > tripYd && dist(st.pos, after.pos) > tripYd) out.push({ kind: 'empty', quest: null, detourYd: Math.round(detour), ...row });
		}
	}
	return out;
}

// Zone visits of one play: [{ zone, s }] (s: the step the visit starts at).
function visitsOf(acts) {
	const out = [];
	for (const a of acts) {
		if (!a.zone) continue;
		if (!out.length || out[out.length - 1].zone !== a.zone) out.push({ zone: a.zone, s: a.s });
	}
	return out;
}

// One tree's numbers.
function measure(dump, ctx) {
	const plays = {};
	for (const [key, p] of Object.entries(dump.plays)) {
		const [gid] = key.split('|');
		const guide = dump.guides[gid];
		const acts = placed(p.trace, ctx);
		const trips = tripsOf(gid, stopsOf(acts, guide), ctx.tripYd);
		plays[key] = {
			gid,
			race: p.race,
			cls: p.cls,
			ok: p.ok,
			stuck: p.stuck,
			visits: visitsOf(acts),
			travel: travel(acts, ctx.legs[gid]),
			trips,
			accepts: [...new Set(acts.filter((a) => a.t === 'accept' && a.q != null).map((a) => a.q))],
			turnins: [...new Set(acts.filter((a) => a.t === 'turnin' && a.q != null).map((a) => a.q))],
			sig: JSON.stringify(acts.map((a) => [a.s, a.t, a.q, a.map, a.x, a.y, a.node])),
		};
	}
	const branches = dump.branches.map((b) => {
		const label = `${b.start}/${b.faction}`;
		const seq = [];
		const revisits = [];
		const carried = new Map();
		b.guides.forEach((gid, gi) => {
			const p = plays[`${gid}|${b.faction}`];
			if (!p) return;
			for (const v of p.visits) {
				const last = seq[seq.length - 1];
				if (last && last.zone === v.zone) continue;
				const before = seq.slice(0, -1).reverse().find((x) => x.zone === v.zone);
				if (before) revisits.push({ branch: label, guide: gid, s: v.s, zone: v.zone, left: before.guide, leftStep: before.s, from: last.zone });
				seq.push({ zone: v.zone, guide: gid, s: v.s });
			}
			for (const q of p.accepts) if (!carried.has(q)) carried.set(q, { quest: q, from: gid, fi: gi, to: null, ti: null });
			for (const q of p.turnins) {
				const c = carried.get(q);
				if (c && c.to == null) Object.assign(c, { to: gid, ti: gi });
			}
		});
		const spans = [...carried.values()].map((c) => ({ ...c, span: c.ti == null ? null : c.ti - c.fi }));
		return { label, guides: b.guides, zones: seq, revisits, carried: spans };
	});
	return { plays, branches, guides: dump.guides };
}

// quest -> verb -> [place] in the written guides: "guide#title#n" (the n-th step of that title).
function placesOf(guides) {
	const out = new Map();
	for (const [gid, g] of Object.entries(guides)) {
		const seen = new Map();
		g.steps.forEach((st, i) => {
			const n = (seen.get(st.title) || 0) + 1;
			seen.set(st.title, n);
			for (const x of st.goals) {
				if ((x.t !== 'accept' && x.t !== 'turnin') || x.q == null) continue;
				if (!out.has(x.q)) out.set(x.q, { accept: [], turnin: [] });
				const list = out.get(x.q)[x.t];
				const key = `${gid}#${st.title}#${n}`;
				if (!list.some((p) => p.key === key)) list.push({ key, guide: gid, step: i + 1, title: st.title });
			}
		});
	}
	return out;
}

const countBy = (items, keyOf) => {
	const m = new Map();
	for (const it of items) {
		const k = keyOf(it);
		if (!m.has(k)) m.set(k, []);
		m.get(k).push(it);
	}
	return m;
};

const revisitKey = (r) => `${r.guide}|${r.zone}|${r.left}`;
// A one-quest trip by its guide and quest, an empty walk by its guide and step title.
const tripKey = (t) => (t.kind === 'empty' ? `${t.guide}|empty|${t.title}` : `${t.guide}|${t.quest}`);

// The row of `data/flow-diff-allow.json` (`allow`) that accepts a new revisit or trip.
function allowed(allow, kind, item) {
	const names = (a) => (kind === 'revisit' ? a.zone === item.zone : item.kind === 'empty' ? a.step === item.title : Number(a.quest) === item.quest);
	return (allow || []).find((a) => a.kind === kind && a.guide === item.guide && names(a));
}

// What changed from base to head.
function compare(base, head, { allow = [] } = {}) {
	// Revisits: per branch, the count of each (guide, zone, guide left) that grew.
	const newRev = new Map();
	const goneRev = new Map();
	const baseBr = new Map(base.branches.map((b) => [b.label, b]));
	for (const hb of head.branches) {
		const bb = baseBr.get(hb.label) || { revisits: [] };
		const hc = countBy(hb.revisits, revisitKey);
		const bc = countBy(bb.revisits, revisitKey);
		for (const [k, list] of hc) {
			if (list.length > (bc.get(k) || []).length) {
				const r = newRev.get(k) || { ...list[0], branches: [] };
				r.branches.push(hb.label);
				newRev.set(k, r);
			}
		}
		for (const [k, list] of bc) {
			if (list.length > (hc.get(k) || []).length) {
				const r = goneRev.get(k) || { ...list[0], branches: [] };
				r.branches.push(hb.label);
				goneRev.set(k, r);
			}
		}
	}
	// One-quest trips by guide and quest, over every play.
	const trips = (m) => new Map(Object.values(m.plays).flatMap((p) => p.trips.map((t) => [tripKey(t), t])));
	const bt = trips(base);
	const ht = trips(head);
	const newTrips = [...ht].filter(([k]) => !bt.has(k)).map(([, t]) => t);
	const goneTrips = [...bt].filter(([k]) => !ht.has(k)).map(([, t]) => t);
	// Carried spans that grew (the largest over the branches), or a hand-in the head no longer reaches.
	const spans = (m) => {
		const out = new Map();
		for (const b of m.branches) {
			for (const c of b.carried) {
				const cur = out.get(c.quest);
				const span = c.span == null ? Infinity : c.span;
				if (!cur || span > cur.spanN) out.set(c.quest, { ...c, spanN: span, branch: b.label });
			}
		}
		return out;
	};
	const bs = spans(base);
	const hs = spans(head);
	const carried = [];
	for (const [q, h] of hs) {
		const b = bs.get(q);
		if (b && h.spanN > b.spanN) carried.push({ quest: q, branch: h.branch, base: { from: b.from, to: b.to, span: b.span }, head: { from: h.from, to: h.to, span: h.span } });
	}
	// Moved accepts and hand-ins.
	const bp = placesOf(base.guides);
	const hp = placesOf(head.guides);
	const moved = [];
	for (const q of new Set([...bp.keys(), ...hp.keys()])) {
		for (const verb of ['accept', 'turnin']) {
			const a = (bp.get(q) || { [verb]: [] })[verb];
			const b = (hp.get(q) || { [verb]: [] })[verb];
			const ak = new Set(a.map((p) => p.key));
			const bk = new Set(b.map((p) => p.key));
			const from = a.filter((p) => !bk.has(p.key));
			const to = b.filter((p) => !ak.has(p.key));
			if (from.length || to.length) moved.push({ quest: q, verb, from, to });
		}
	}
	// Per guide: the guides whose written steps or play changed.
	const guides = [];
	const ids = new Set([...Object.keys(base.plays), ...Object.keys(head.plays)]);
	for (const key of [...ids].sort()) {
		const a = base.plays[key];
		const b = head.plays[key];
		const [gid, faction] = key.split('|');
		const written = JSON.stringify((base.guides[gid] || {}).steps) !== JSON.stringify((head.guides[gid] || {}).steps);
		if (a && b && a.sig === b.sig && !written) continue;
		const zones = (p) => (p ? p.visits.map((v) => v.zone) : null);
		const mins = (p) => (p ? { walk: +(p.travel.walk / 60).toFixed(1), fly: +(p.travel.fly / 60).toFixed(1), other: +(p.travel.other / 60).toFixed(1) } : null);
		guides.push({
			guide: gid,
			faction,
			persona: b ? `${b.race} ${b.cls}` : `${a.race} ${a.cls}`,
			written,
			base: a ? { zones: zones(a), travel: mins(a), ok: a.ok, stuck: a.stuck } : null,
			head: b ? { zones: zones(b), travel: mins(b), ok: b.ok, stuck: b.stuck } : null,
			newRevisits: [...newRev.values()].filter((r) => r.guide === gid).length,
			goneRevisits: [...goneRev.values()].filter((r) => r.guide === gid).length,
			newTrips: newTrips.filter((t) => t.guide === gid).length,
			goneTrips: goneTrips.filter((t) => t.guide === gid).length,
		});
	}
	const revisits = { added: [...newRev.values()], gone: [...goneRev.values()] };
	for (const r of revisits.added) r.allowed = allowed(allow, 'revisit', r)?.reason || null;
	for (const t of newTrips) t.allowed = allowed(allow, 'trip', t)?.reason || null;
	const blocking = revisits.added.filter((r) => !r.allowed).length + newTrips.filter((t) => !t.allowed).length;
	return { guides, revisits, trips: { added: newTrips, gone: goneTrips }, carried, moved, blocking };
}

const short = (gid) => String(gid || '').replace(/^forever\//, '');
const zoneList = (z) => (z ? z.join(' > ') : '(not played)');

// The flow diff as markdown for a pull request body.
function renderMd(diff, { base = 'base', head = 'head', limit = 25 } = {}) {
	const out = [`### Flow diff: ${base} -> ${head}`, ''];
	if (!diff.guides.length && !diff.moved.length) return [...out, 'No leveling guide plays differently.'].join('\n');
	out.push('| Guide | Zones (base -> head) | Walk / fly min | Revisits | Trips |', '|---|---|---|---|---|');
	for (const g of diff.guides) {
		const zb = zoneList(g.base && g.base.zones);
		const zh = zoneList(g.head && g.head.zones);
		const zones = zb === zh ? zh : `${zb}<br>-> ${zh}`;
		const t = (x) => (x ? `${x.walk} / ${x.fly}` : '-');
		const tr = g.base && g.head && t(g.base.travel) === t(g.head.travel) ? t(g.head.travel) : `${t(g.base && g.base.travel)} -> ${t(g.head && g.head.travel)}`;
		const n = (add, gone) => (add || gone ? `+${add} -${gone}` : '0');
		const stuck = g.head && g.head.stuck ? ' (stuck)' : '';
		out.push(`| ${short(g.guide)} (${g.faction}, ${g.persona})${stuck} | ${zones} | ${tr} | ${n(g.newRevisits, g.goneRevisits)} | ${n(g.newTrips, g.goneTrips)} |`);
	}
	const list = (title, items, fmt) => {
		if (!items.length) return;
		out.push('', `**${title}**`, '', ...items.slice(0, limit).map((x) => `- ${fmt(x)}`));
		if (items.length > limit) out.push(`- ... and ${items.length - limit} more (JSON)`);
	};
	const why = (x) => (x.allowed ? ` (allowed: ${x.allowed})` : '');
	list('New revisits', diff.revisits.added, (r) => `${short(r.guide)} step ${r.s}: back into ${r.zone} from ${r.from}, left in ${short(r.left)} step ${r.leftStep} (${r.branches.join(', ')})${why(r)}`);
	list('Revisits gone', diff.revisits.gone, (r) => `${short(r.guide)}: ${r.zone} from ${r.from} (${r.branches.join(', ')})`);
	const yd = (v, z) => (v == null ? z : `${v} yd`);
	const trip = (t) => (t.kind === 'empty' ? `a walk with nothing there (${t.detourYd} yd out of the way)` : `quest ${t.quest} alone`);
	list('New trips', diff.trips.added, (t) => `${short(t.guide)} step ${t.s} "${t.title}": ${trip(t)} in ${t.zone}, ${yd(t.fromYd, t.from)} from the work before, ${yd(t.toYd, t.to)} to the next${why(t)}`);
	list('Trips gone', diff.trips.gone, (t) => `${short(t.guide)} step ${t.s} "${t.title}": ${trip(t)}`);
	const span = (c) => `${short(c.from)} -> ${c.to ? short(c.to) : 'never handed in'}`;
	list('Carried longer', diff.carried, (c) => `quest ${c.quest} (${c.branch}): ${span(c.base)} (${c.base.span ?? '-'}) -> ${span(c.head)} (${c.head.span ?? 'never'})`);
	const at = (ps) => (ps.length ? ps.map((p) => `${short(p.guide)} step ${p.step} "${p.title}"`).join(', ') : 'nowhere');
	list('Moved quests', diff.moved, (m) => `${m.verb} ${m.quest}: ${at(m.from)} -> ${at(m.to)}`);
	return out.join('\n');
}

module.exports = { measure, compare, renderMd, travel, stopsOf, tripsOf, visitsOf, placed };
