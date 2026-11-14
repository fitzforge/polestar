'use strict';
// The flow audit over every start x class branch of a compiled guide set (docs/ROUTE-FEEL.md): each branch walked
// strict and, with Dynamic Questing, again as the player who takes the While-here lines; per guide the mean (and max)
// over the branches that play it, the findings with the share of branches that meet them, and per branch the chain's
// totals.

const { WALK_YPS, loadData, timedQuests, pyRound } = require('./data');
const { Walk, Router, okeyOf, Counter, truthy, list } = require('./walk');
const { analyse } = require('./analyse');

const IRRITATIONS = ['passed_givers_near', 'passed_enders', 'deferred', 'missed_merges', 'backtracks_avoidable', 'reversals', 'thin_hub_visits'];

// Walking minutes a player feels as wasted: avoidable stops' detours, ground walked twice, hub zigzag.
function wastedMin(m) {
	return m.flow_cost_min + m.retrace_min + m.hub_zigzag_yd / WALK_YPS / 60;
}

// Moments a player notices: ran past a giver or ender, came back for work, turned around, thin visits. `along` lists
// are counted but not scored: their goals are scored where the work is done, like any step's.
function irritations(m) {
	return IRRITATIONS.reduce((s, k) => s + m[k], 0);
}

// The flow score: per 10 quests handed in, so long and short guides compare.
function score(m) {
	return 10 * (wastedMin(m) + irritations(m)) / Math.max(m.quests, 5);
}

// The start guides and their branches: every race a start guide is for, every class the race plays.
function branchesOf(G, races, { faction = '', starts = [], classes = [] } = {}) {
	const startGuides = [...G.values()].filter((g) => truthy(g.races));
	const pointed = new Set(startGuides.map((g) => g.next));
	const out = [];
	for (const g of startGuides) {
		if (pointed.has(g.id)) continue;   // a start guide another start's `next` leads into is not a start
		if (faction && g.faction !== faction) continue;
		for (const race of list(g.races)) {
			const fac = g.faction;
			const label = race === 'Scourge' ? 'Undead' : race;
			const start = race === 'Skyborne' ? `${label}-${fac}` : label;
			if (starts.length && !starts.includes(start.toLowerCase()) && !starts.includes(label.toLowerCase())) continue;
			for (const cls of list(((races[race] || {})[fac] || {}).classes)) {
				if (classes.length && !classes.includes(cls)) continue;
				out.push({ start, race, cls, first: g.id });
			}
		}
	}
	return out;
}

// The per-guide numbers of one branch's walk and its analysis.
function guideRow(w, r, gid, G) {
	const fs = r.findings.filter((f) => f.pass_gid === gid);
	const cnt = (pred) => fs.filter(pred).length;
	const row = {
		passed_givers_near: cnt((f) => f.type === 'passed-giver' && f.tier === 'near'),
		passed_givers_hub: cnt((f) => f.type === 'passed-giver' && f.tier === 'hub'),
		passed_enders: cnt((f) => f.type === 'passed-ender'),
		deferred: cnt((f) => f.type === 'deferred'),
		missed_merges: cnt((f) => f.type === 'missed-merge'),
		backtracks: r.backtracks.filter((b) => b.gid === gid).length,
		backtracks_avoidable: r.backtracks.filter((b) => b.gid === gid && b.avoidable).length,
		hub_revisits_avoidable: r.revisits.filter((v) => v.gid === gid && v.avoidable).length,
		along_steps: w.alongSteps.get(gid),
		hub_zigzag_yd: pyRound(r.zig.get(gid)),
		reversals: r.reversals.filter((x) => x.gid === gid).length,
		retrace_pct: pyRound(100 * r.retrace_g.get(gid) / Math.max(r.walked_g.get(gid), 1), 1),
		retrace_min: pyRound(r.retrace_g.get(gid) / WALK_YPS / 60, 1),
		// A pass through a town with no accept or turn-in (a boat, a flight master, travel) is not a town visit.
		thin_hub_visits: r.hubv.filter((h) => h.gid === gid && h.accepts + h.turnins === 1).length,
		log_max: r.log_by_gid.get(gid),
		flow_cost_min: pyRound(r.cost.get(gid), 1),
		walk_km: pyRound(w.walkYd.get(gid) / 1000, 1),
		quests: w.entries.filter((e) => e.gid === gid && e.goal.t === 'turnin').length,
	};
	row.yd_per_quest = pyRound(w.walkYd.get(gid) / Math.max(row.quests, 1));
	const ge = w.entries.filter((e) => e.gid === gid);
	const lvs = ge.filter((e) => e.lv !== undefined).map((e) => e.lv);
	row.level_start = lvs.length ? lvs[0] : 0;
	row.level_end = lvs.length ? lvs[lvs.length - 1] : 0;
	row.home_quests = w.entries.filter((e) => e.gid === gid && e.goal.t === 'turnin' && e.zone === G.get(gid).zoneName).length;
	row.home_yd_per_quest = pyRound(w.homeYd.get(gid) / Math.max(row.home_quests, 1));
	const tt = ge.filter((e) => e.t0 != null);
	row.minutes = tt.length ? pyRound((tt[tt.length - 1].t1 - tt[0].t0) / 60, 1) : 0;
	const hv = r.hubv.filter((h) => h.gid === gid && h.accepts + h.turnins > 0);
	row.hub_visits = hv.length;
	row.hub_interactions = hv.reduce((s, h) => s + h.accepts + h.turnins, 0);
	row.door_moves = r.hubv.filter((h) => h.gid === gid).reduce((s, h) => s + h.doors, 0);
	row.building_reentries = r.hubv.filter((h) => h.gid === gid).reduce((s, h) => s + h.reentries, 0);
	// Dynamic Questing: goals of this guide taken on a While-here line (0 on the strict walk)
	row.wh_work = ge.filter((e) => e.dyn_from != null && e.goal.t !== 'turnin').length;
	row.wh_turnins = ge.filter((e) => e.dyn_from != null && e.goal.t === 'turnin').length;
	// Organisation: this guide's pick-ups handed in in a later guide, picked up long before their work, never handed in;
	// the log's time-weighted mean while in this guide
	const car = r.org.carried.filter((c) => c.gid === gid);
	row.carried_out = car.length;
	row.carried_far = car.filter((c) => c.far).length;
	row.carried_min = pyRound(car.reduce((s, c) => s + c.min, 0), 1);
	row.early_pickups = r.org.early.filter((c) => c.gid === gid).length;
	row.never_handed = r.org.never.filter((c) => c.gid === gid).length;
	row.log_mean = r.org.log_mean_g[gid] ?? 0.0;
	// Dungeons in the route: trips only for dungeon quests, the runs' door detours, pick-up to run
	const ex = r.dng.excursions.filter((x) => x.gid === gid);
	row.dng_trips = ex.filter((x) => x.type !== 'dungeon-run').length;
	row.dng_trip_min = pyRound(ex.filter((x) => x.type !== 'dungeon-run').reduce((s, x) => s + x.min, 0), 1);
	row.dng_door_min = pyRound(ex.filter((x) => x.type === 'dungeon-run').reduce((s, x) => s + x.min, 0), 1);
	row.dng_to_run_min = pyRound(r.dng.carry.filter((c) => c.gid === gid).reduce((s, c) => s + (c.to_run_min || 0), 0), 1);
	return [row, fs];
}

// How the dynamic walk took a strict finding on a While-here line: the move, or null. Passed givers and missed merges
// never are (While-here never offers an accept).
function whCovered(f, w0, w) {
	if (f.type === 'deferred') return w.dynDone.get(okeyOf(w0.entries[f.k].goal)) || null;
	if (f.type === 'passed-ender') return w.dynTurned.get(f.quest) || null;
	return null;
}

// One row per key over the branches: the first branch's fields, `share` (branches with it / branches that play the
// guide) and the mean of each numeric field; most shared first, then the longest.
function grouped(items, keyf, nb, nums) {
	const groups = new Map();
	for (const c of items) {
		const k = keyf(c);
		if (!groups.has(k)) groups.set(k, []);
		groups.get(k).push(c);
	}
	const out = [];
	for (const cl of groups.values()) {
		const row = {};
		for (const [k, v] of Object.entries(cl[0])) if (k !== 'branch') row[k] = v;
		for (const f of nums) {
			const vals = cl.map((c) => c[f]).filter((v) => v != null);
			row[f] = vals.length ? pyRound(vals.reduce((s, v) => s + v, 0) / vals.length, 1) : null;
		}
		row.share = `${new Set(cl.map((c) => c.branch)).size}/${nb}`;
		out.push(row);
	}
	const shareN = (x) => Number(x.share.split('/')[0]);
	out.sort((a, b) => shareN(b) - shareN(a) || (nums.length ? (b[nums[0]] || 0) - (a[nums[0]] || 0) : 0));
	return out;
}

function sharedSort(list_, keyOf, extra) {
	const branches = new Map();
	for (const x of list_) {
		const k = keyOf(x);
		if (!branches.has(k)) branches.set(k, new Set());
		branches.get(k).add(x.branch);
	}
	return { branches, sorted: [...list_].sort((a, b) => branches.get(keyOf(b)).size - branches.get(keyOf(a)).size || extra(a, b)) };
}

// The audit: { branches: [...], guides: { id: { branches, mean, max, findings, ... } }, dynamic, route, dungeons }.
// opts: addon guides ({ guides, legs }), dataDir, starts/classes filters, guide (id substring), noLegs, longFly, dynamic
// ("036" | "037" | null), whTake ("near" | "all"), followups, route (list of id substrings), dungeons ("all", ids, "").
function runAudit(compiled, dataDir, opts = {}, log = () => {}) {
	const { faction = '', starts = [], classes = [], guide = '', noLegs = false, longFly = 2500, dynamic = null, whTake = 'near', followups = true, route = [], dungeons = '', dungeonQuests = 'all' } = opts;
	const data = loadData(dataDir);
	const G = new Map();
	for (const g of compiled.guides) if (g.category === 'Leveling') G.set(g.id, g);
	const legs = noLegs ? {} : compiled.legs;
	const timed = dynamic ? timedQuests(dataDir, data.quests) : new Map();
	const perGuide = new Map();
	const pg = (gid) => {
		if (!perGuide.has(gid)) perGuide.set(gid, { rows: [], branches: [], strict_rows: [], strict_findings: [], findings: [], backs: [], revs: [], zig: [], revisits: [], carried: [], early: [], never: [], dng_exc: [], dng_carry: [] });
		return perGuide.get(gid);
	};
	const branchRows = [];
	for (const b of branchesOf(G, data.races, { faction, starts, classes })) {
		const common = { race: b.race, cls: b.cls, guides: G, legs, data, longFly, dungeons, dungeonQuests };
		let w = new Walk({ ...common, chain: new Router(b.first, route, dungeons, dungeonQuests) });
		let r = analyse(w, data.quests, data.proj);
		const bkey = `${b.start}/${b.cls}`;
		let strict = null;
		if (dynamic) {
			const w0 = w, r0 = r;
			const future = new Map([...w0.turninAt].map(([q, i]) => [q, w0.entries[i].lv]));
			w = new Walk({ ...common, chain: w0.chain, dyn: dynamic, future, timed, take: whTake, followups });
			r = analyse(w, data.quests, data.proj);
			strict = [w0, r0];
		}
		const seen = [...new Set(w.entries.map((e) => e.gid))];
		for (const gid of seen) {
			if (guide && !gid.includes(guide)) continue;
			const [row, fs] = guideRow(w, r, gid, G);
			const p = pg(gid);
			p.rows.push(row);
			p.branches.push(bkey);
			if (strict) {
				const [w0, r0] = strict;
				if (w0.walkYd.has(gid) || w0.entries.some((e) => e.gid === gid)) {
					const [row0, fs0] = guideRow(w0, r0, gid, G);
					p.strict_rows.push(row0);
					for (const f of fs0) {
						const mv = whCovered(f, w0, w);
						const { k: _k, j: _j, ...f2 } = f;
						f2.branch = bkey;
						if (mv) f2.wh = { at_step: mv.at_step, yd: mv.yd, lv: mv.lv, t: mv.t };
						p.strict_findings.push(f2);
					}
				}
			}
			for (const f of fs) {
				const { k: _k, j: _j, ...f2 } = f;
				p.findings.push({ ...f2, branch: bkey });
			}
			for (const x of r.backtracks) if (x.gid === gid) p.backs.push({ ...x, branch: bkey });
			for (const x of r.reversals) if (x.gid === gid) p.revs.push({ ...x, branch: bkey });
			for (const x of r.zig_ex) if (x.gid === gid) p.zig.push({ ...x, branch: bkey });
			for (const x of r.revisits) if (x.gid === gid) p.revisits.push({ ...x, branch: bkey });
			for (const [key, lst] of [['carried', r.org.carried], ['early', r.org.early], ['never', r.org.never], ['dng_exc', r.dng.excursions], ['dng_carry', r.dng.carry]]) {
				for (const c of lst) if (c.gid === gid) p[key].push({ ...c, branch: bkey });
			}
		}
		const zrows = {};
		for (const z of new Set(w.entries.map((e) => e.zone).filter(Boolean))) {
			const fs = r.findings.filter((f) => f.zone === z);
			const n = (pred) => fs.filter(pred).length;
			const hz = r.hubv.filter((h) => h.zone === z);
			zrows[z] = {
				quests: w.entries.filter((e) => e.zone === z && e.goal.t === 'turnin').length,
				walk_km: pyRound(w.walkYdZone.get(z) / 1000, 2),
				passed_givers_near: n((f) => f.type === 'passed-giver' && f.tier === 'near'),
				passed_givers_hub: n((f) => f.type === 'passed-giver' && f.tier === 'hub'),
				passed_enders: n((f) => f.type === 'passed-ender'),
				deferred: n((f) => f.type === 'deferred'),
				missed_merges: n((f) => f.type === 'missed-merge'),
				backtracks_avoidable: r.backtracks.filter((x) => x.zone === z && x.avoidable).length,
				backtracks: r.backtracks.filter((x) => x.zone === z).length,
				hub_revisits_avoidable: r.revisits.filter((v) => v.zone === z && v.avoidable).length,
				hub_zigzag_yd: pyRound(r.zig_ex.filter((x) => x.zone === z).reduce((s, x) => s + x.extra_yd, 0)),
				reversals: r.reversals.filter((x) => x.zone === z).length,
				retrace_km: pyRound(r.retrace.get(z) / 1000, 2),
				sampled_km: pyRound(r.walked_zone.get(z) / 1000, 2),
				passed_givers_costly: n((f) => f.type === 'passed-giver' && (f.detour_min || 0) > 0),
				hub_visits: hz.filter((h) => h.accepts + h.turnins > 0).length,
				thin_hub_visits: hz.filter((h) => h.accepts + h.turnins === 1).length,
				hub_interactions: hz.reduce((s, h) => s + h.accepts + h.turnins, 0),
				door_moves: hz.reduce((s, h) => s + h.doors, 0),
				building_reentries: hz.reduce((s, h) => s + h.reentries, 0),
				sweep_quests: hz.reduce((s, h) => s + (h.sweep_q || 0), 0),
				sweeps: hz.filter((h) => h.sweep_q).length,
				flow_cost_min: pyRound(r.cost_zone.get(z), 1),
			};
		}
		const org = r.org, dn = r.dng;
		const brow = {
			branch: bkey, zones: zrows, end_level: pyRound(w.endLevel, 2), hours: pyRound(w.endT / 3600, 1), log_max: r.log_max,
			flow_cost_min: pyRound([...r.cost.values()].reduce((s, v) => s + v, 0), 1), findings: r.findings.length, chain: w.chain,
			backtracks: r.backtracks.length, backtracks_avoidable: r.backtracks.filter((x) => x.avoidable).length, reversals: r.reversals.length,
			passed_givers_near: r.findings.filter((f) => f.type === 'passed-giver' && f.tier === 'near').length,
			passed_enders: r.findings.filter((f) => f.type === 'passed-ender').length,
			carried: org.carried.length, carried_far: org.carried.filter((c) => c.far).length,
			carried_hours: pyRound(org.carried.reduce((s, c) => s + c.min, 0) / 60, 2), carried_crumbs: org.carried.filter((c) => c.crumb).length,
			early_pickups: org.early.length, never_handed: org.never.length, log_mean: org.log_mean,
			dng_trips: dn.excursions.filter((x) => x.type !== 'dungeon-run').length,
			dng_trip_min: pyRound(dn.excursions.filter((x) => x.type !== 'dungeon-run').reduce((s, x) => s + x.min, 0), 1),
			dng_door_min: pyRound(dn.excursions.filter((x) => x.type === 'dungeon-run').reduce((s, x) => s + x.min, 0), 1),
			dng_quests: dn.carry.length,
		};
		if (strict) {
			const [w0, r0] = strict;
			Object.assign(brow, {
				strict_hours: pyRound(w0.endT / 3600, 2), strict_end_level: pyRound(w0.endLevel, 2), strict_findings: r0.findings.length,
				hours_exact: pyRound(w.endT / 3600, 2), wh_moves: w.dynMoves.length,
				wh_covered: r0.findings.filter((f) => whCovered(f, w0, w) !== null).length,
			});
		}
		branchRows.push(brow);
		log(`${bkey.padEnd(28)} lvl ${w.endLevel.toFixed(1).padStart(5)}  ${(w.endT / 3600).toFixed(1).padStart(5)} h  findings ${String(r.findings.length).padStart(4)}  ` +
			`backtracks ${String(r.backtracks.length).padStart(3)}  flow cost ${brow.flow_cost_min.toFixed(1).padStart(6)} min  log max ${r.log_max}` +
			(strict ? `  | strict ${(strict[0].endT / 3600).toFixed(1).padStart(5)} h  findings ${strict[1].findings.length}  WH moves ${w.dynMoves.length}` : ''));
	}

	const guides = {};
	for (const [gid, p] of perGuide) {
		const rows = p.rows;
		const keys = Object.keys(rows[0]);
		const mean = {}, max = {};
		for (const k of keys) {
			mean[k] = pyRound(rows.reduce((s, r) => s + r[k], 0) / rows.length, 1);
			max[k] = Math.max(...rows.map((r) => r[k]));
		}
		const nb = rows.length;
		const fkey = (f) => `${f.type}|${f.quest}|${f.pass_step}|${f.take_gid}|${f.take_step}`;
		const { branches: fb, sorted: fsorted } = sharedSort(p.findings, fkey, (a, b) => (b.detour_min || 0) - (a.detour_min || 0) || b.min_between - a.min_between);
		const ex = [];
		const seenF = new Set();
		for (const f of fsorted) {
			const key = fkey(f);
			if (seenF.has(key)) continue;
			seenF.add(key);
			ex.push({ ...f, share: `${fb.get(key).size}/${nb}` });
		}
		const bkey = (b) => `${b.step}|${b.from_step}`;
		const { branches: bb, sorted: bsorted } = sharedSort(p.backs, bkey, (a, b) => Number(!a.avoidable) - Number(!b.avoidable));
		const backs = [];
		const seenB = new Set();
		for (const b of bsorted) {
			const key = bkey(b);
			if (seenB.has(key)) continue;
			seenB.add(key);
			backs.push({ ...b, share: `${bb.get(key).size}/${nb}` });
		}
		const zc = new Counter();
		for (const k of new Set(p.zig.map((z) => `${z.step}|${z.to_step}|${z.branch}`))) zc.add(k.split('|').slice(0, 2).join('|'));
		const zig = [];
		const seenZ = new Set();
		for (const z of [...p.zig].sort((a, b) => b.extra_yd - a.extra_yd)) {
			const key = `${z.step}|${z.to_step}`;
			if (seenZ.has(key)) continue;
			seenZ.add(key);
			zig.push({ ...z, share: `${zc.get(key)}/${nb}` });
		}
		const rc = new Counter();
		for (const k of new Set(p.revs.map((x) => `${x.step}|${x.branch}`))) rc.add(Number(k.split('|')[0]));
		const revs = [];
		const seenR = new Set();
		for (const x of [...p.revs].sort((a, b) => (b.in_yd + b.out_yd) - (a.in_yd + a.out_yd))) {
			if (seenR.has(x.step)) continue;
			seenR.add(x.step);
			revs.push({ ...x, share: `${rc.get(x.step)}/${nb}` });
		}
		const s = { branches: nb, mean, max, findings: ex, backtracks: backs, zigzags: zig.slice(0, 10), reversals: revs.slice(0, 15), revisits: p.revisits.slice(0, 50) };
		s.carried = grouped(p.carried, (c) => `${c.quest}|${c.step}|${c.to_gid}|${c.to_step}`, nb, ['min', 'span']);
		s.early = grouped(p.early, (c) => `${c.quest}|${c.step}|${c.work_gid}|${c.work_step}`, nb, ['min', 'span']);
		s.never = grouped(p.never, (c) => `${c.quest}|${c.step}`, nb, []);
		s.dng_exc = grouped(p.dng_exc, (c) => `${c.type}|${c.step}|${c.door_step}`, nb, ['min']);
		s.dng_carry = grouped(p.dng_carry, (c) => `${c.quest}|${c.step}`, nb, ['to_run_min', 'to_run_span', 'after_run_min']);
		if (p.strict_rows.length) {
			const sr = p.strict_rows;
			s.strict_mean = {};
			for (const k of Object.keys(sr[0])) s.strict_mean[k] = pyRound(sr.reduce((t, r) => t + r[k], 0) / sr.length, 1);
			const cnt = new Counter();
			for (const f of p.strict_findings) cnt.add(`${f.type}|${'wh' in f}`);
			s.wh_covered_mean = {};
			for (const t of ['passed-giver', 'passed-ender', 'deferred', 'missed-merge']) s.wh_covered_mean[t] = pyRound(cnt.get(`${t}|true`) / nb, 2);
			const groups = new Map();
			for (const f of p.strict_findings) {
				const key = fkey(f);
				if (!groups.has(key)) groups.set(key, []);
				groups.get(key).push(f);
			}
			const lst = [];
			for (const fl of groups.values()) {
				const cov = fl.filter((f) => 'wh' in f);
				const f = (cov.length ? cov : fl)[0];
				const row = {};
				for (const k of ['type', 'tier', 'quest', 'title', 'npc', 'target', 'zone', 'pass_step', 'take_gid', 'take_step', 'min_between', 'closest_yd', 'detour_min']) row[k] = f[k] ?? null;
				lst.push({ ...row, share: `${fl.length}/${nb}`, covered: `${cov.length}/${fl.length}`, wh: f.wh || null });
			}
			lst.sort((a, b) => (a.type < b.type ? -1 : a.type > b.type ? 1 : 0) || Number(b.share.split('/')[0]) - Number(a.share.split('/')[0]));
			s.strict_findings = lst;
		}
		guides[gid] = s;
	}
	return { branches: branchRows, guides, dynamic, route, dungeons, dungeon_quests: dungeons ? dungeonQuests : null };
}

// The experimental route choices a faction's leveling guides offer (`next` options in Polestar Experimental) and the
// compiled guides hold (compile the experimental pack too), as [label, guide id]: "riverglades" for
// polestar-experimental/riverglades-horde-1.
function routeChoices(compiled, faction) {
	const have = new Set(compiled.guides.map((g) => g.id));
	const out = new Map();
	for (const g of compiled.guides) {
		if (g.category !== 'Leveling' || g.faction !== faction || String(g.id).startsWith('polestar-experimental/')) continue;
		for (const c of list(g.nextChoices)) {
			if (!String(c).startsWith('polestar-experimental/') || !have.has(c)) continue;
			const label = c.slice('polestar-experimental/'.length).replace(/(-(horde|alliance))?(-\d+)?$/, '');
			if (!out.has(label)) out.set(label, c);
		}
	}
	return [...out.entries()];
}

const short = (gid) => String(gid || '').replace(/^forever\//, '');
const fmt1 = (v) => (Number.isInteger(v) ? `${v}.0` : String(v));

// The audit as a readable report: the guides ranked by flow score, the strict and dynamic walks side by side, and
// examples per guide.
function renderMd(res, nex = 6) {
	const ranked = Object.entries(res.guides).sort((a, b) => score(b[1].mean) - score(a[1].mean));
	const out = ['# Flow audit', '', 'Means over every start x class branch that plays the guide (max in brackets).', '',
		'| # | guide | score /10 quests | quests | wasted walk min | retrace % | reversals | passed givers ≤40 yd (hub) | passed enders | deferred / missed merge | backtracks (avoidable) | thin hub visits | hub zigzag yd | along | log max | yd/quest |',
		'|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|'];
	ranked.forEach(([gid, s], i) => {
		const m = s.mean, x = s.max;
		out.push(`| ${i + 1} | ${short(gid)} | ${score(m).toFixed(1)} | ${fmt1(m.quests)} | ${wastedMin(m).toFixed(1)} | ${fmt1(m.retrace_pct)} | ${fmt1(m.reversals)} | ` +
			`${fmt1(m.passed_givers_near)} (${fmt1(m.passed_givers_hub)}) | ${fmt1(m.passed_enders)} | ${fmt1(m.deferred)} / ${fmt1(m.missed_merges)} | ` +
			`${fmt1(m.backtracks)} (${fmt1(m.backtracks_avoidable)}) | ${fmt1(m.thin_hub_visits)} | ${fmt1(m.hub_zigzag_yd)} | ${fmt1(m.along_steps)} | ${x.log_max} | ${fmt1(m.yd_per_quest)} |`);
	});
	const dyn = ranked.filter(([, s]) => s.strict_mean);
	if (dyn.length) {
		out.push('', '## Dynamic Questing: strict walk → dynamic walk', '',
			'Scores and counts are the strict walk\'s → the dynamic one\'s (the table above is the dynamic walk). "taken on a line": the strict walk\'s walked-past enders and deferred work the dynamic player did on a While-here line (no route edit needed).', '',
			'| guide | score | passed givers ≤40 yd | passed enders | deferred | backtracks (avoidable) | minutes | lines taken (work / hand-ins) | strict enders / deferred taken on a line |',
			'|---|---|---|---|---|---|---|---|---|');
		for (const [gid, s] of dyn) {
			const a = s.strict_mean, m = s.mean, cv = s.wh_covered_mean || {};
			out.push(`| ${short(gid)} | ${score(a).toFixed(1)} → ${score(m).toFixed(1)} | ${fmt1(a.passed_givers_near)} → ${fmt1(m.passed_givers_near)} | ` +
				`${fmt1(a.passed_enders)} → ${fmt1(m.passed_enders)} | ${fmt1(a.deferred)} → ${fmt1(m.deferred)} | ${fmt1(a.backtracks_avoidable)} → ${fmt1(m.backtracks_avoidable)} | ` +
				`${fmt1(a.minutes)} → ${fmt1(m.minutes)} | ${fmt1(m.wh_work)} / ${fmt1(m.wh_turnins)} | ${cv['passed-ender'] || 0} / ${cv.deferred || 0} |`);
		}
	}
	out.push('', '## Organisation per guide', '', 'Means per branch: quests this guide picks up and a later guide hands in (carried far: through a whole guide, or 2+ hours), pick-ups an hour or more before their work, pick-ups never handed in, and the quest log\'s mean.', '',
		'| guide | carried out (far) | carried minutes | early pick-ups | never handed in | log mean | dungeon trips (min) | door detours min |', '|---|---|---|---|---|---|---|---|');
	for (const [gid, s] of ranked) {
		const m = s.mean;
		out.push(`| ${short(gid)} | ${fmt1(m.carried_out)} (${fmt1(m.carried_far)}) | ${fmt1(m.carried_min)} | ${fmt1(m.early_pickups)} | ${fmt1(m.never_handed)} | ${fmt1(m.log_mean)} | ${fmt1(m.dng_trips)} (${fmt1(m.dng_trip_min)}) | ${fmt1(m.dng_door_min)} |`);
	}
	out.push('', '## Examples per guide', '');
	for (const [gid, s] of ranked) {
		out.push(`### ${gid}`);
		for (const f of s.findings.slice(0, nex)) {
			const where = `step ${f.pass_step} → step ${f.take_step}${f.take_gid === gid ? '' : ` of ${short(f.take_gid)}`}`;
			const det = f.detour_min ? `, detour ${f.detour_min} min` : '';
			const what = f.type.startsWith('passed') ? f.npc : f.target;
			out.push(`- ${f.type} (${f.tier}${'closest_yd' in f ? `, ${f.closest_yd} yd` : ''}): ${f.title} (${f.quest}) ${what || ''}: ${where}, ${f.min_between} min later${det} [${f.share}]`);
		}
		for (const x of (s.reversals || []).slice(0, 3)) out.push(`- reversal at step ${x.step}: ${x.in_yd} yd in, ${x.out_yd} yd back out (${x.at}) [${x.share}]`);
		for (const z of (s.zigzags || []).slice(0, 2)) out.push(`- hub zigzag: steps ${z.step}-${z.to_step} at ${z.hub}: ${z.extra_yd} yd more than nearest-first [${z.share}]`);
		for (const b of s.backtracks.slice(0, 3)) {
			out.push(`- backtrack${b.avoidable ? ' (avoidable)' : ''}: step ${b.from_step} → out ${b.yd_out} yd → step ${b.step} ${b.min_since} min later: ${b.goals.join('; ')} [${b.share}]`);
		}
		for (const c of (s.carried || []).filter((x) => !x.crumb || x.span > 2).slice(0, 3)) {
			out.push(`- carried: ${c.title} (${c.quest}) step ${c.step} → ${short(c.to_gid)} step ${c.to_step}, ${c.min} min, ${c.span} guides [${c.share}]`);
		}
		for (const c of (s.never || []).slice(0, 3)) out.push(`- never handed in: ${c.title} (${c.quest}) step ${c.step} [${c.share}]`);
		for (const x of (s.dng_exc || []).slice(0, 3)) out.push(`- ${x.type}: steps ${x.step}${x.door_step ? ` (door at ${x.door_step})` : ''}, ${x.min} min: ${x.goals.join('; ')} [${x.share}]`);
		out.push('');
	}
	return out.join('\n');
}

module.exports = { runAudit, branchesOf, guideRow, grouped, score, wastedMin, irritations, routeChoices, renderMd, IRRITATIONS };
