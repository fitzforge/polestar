'use strict';
// A gathering profession guide (Mining, Herbalism, Skinning) from its route file, the gathering form
// (tools/lib/professions/routes/<profession>.json with `"kind": "gathering"`; docs/forge/professions.md,
// "Gathering route files"). The route says what a first-timer does, in order; the farming loops are the
// gathering planner's (build.js plan(): the densest safe ground per band), so the paired guides and the
// crafting guides' Get steps keep the same loops. A route zone the planner did not pick adds its own loop,
// built the same way (stand safety included), or is reported when no safe loop exists there.
//
// Steps, one action each:
//   Learn <Profession> / Train <Rank> <Profession>   train <Profession> <Rank>     { "train": "<Rank>" }
//   Buy a <tool>                     buy <tool> x1 nearest                         { "tool": <item> }
//   Turn on <tracking>               cast <spell>                                  { "track": <spell>, "name" }
//   Learn <recipe>                   learn <spell> (the trainer visit's)           { "learn": <spell> }
//   Get N <ore>                      collect … gather with the band's loops, auction { "get": <item>, "count" }
//   Go to a forge                    goto … nearest over the forges by trainers     (before a smelt)
//   Smelt N <bars>                   craft <spell> xN                              { "smelt": <spell>, "count", "to" }
//   Mine/Pick/Skin … until N         skill <Profession> N on the band's loops      { "gather": N, "zones"?, "mobs"? }
// Checked when built (the build stops): a rank before its skill or past the cap, a recipe learned before its
// skill or not learned on the first visit that could teach it, a trainer recipe that gives points left out of
// a visit, a smelt without its ore in the bags, a gather target that is no band end, a tool vendor who does not
// sell it or serve the side, a tip over TIP_MAX or one that tells the player to do something.

const { FACTIONS, zoneName, fmt } = require('./common');
const { header } = require('../../generated');
const { ZONES } = require('./tables');

const CAP = { Apprentice: 75, Journeyman: 150, Expert: 225, Artisan: 300 };
const VERB = { Mining: 'Mine', Herbalism: 'Pick', Skinning: 'Skin' };
// A get's loops: those that give the item at least this share of their lap's yield.
const MIN_SHARE = 0.05;

// The header's last paragraph: how a gathering step's loops are chosen (build.js, farm.js).
const LOOPS_NOTE = 'Each gathering step offers farming loops through the densest ground of what the skill can gather (the server\'s own spawns, how often each is up, and what players\' recorded gathers gave): the arrow takes the one that gets you there soonest from where you are, never among creatures two or more levels above you, and away from the other faction\'s towns and guards. Waypoints are Era-frame; a map without one (Zephras Isle) compiles live.';

function comment(text) {
	const out = [''];
	for (const w of String(text).split(' ')) {
		const cur = out[out.length - 1];
		if (cur && cur.length + 1 + w.length > 100) out.push(w);
		else out[out.length - 1] = cur ? `${cur} ${w}` : w;
	}
	return out.map((l) => (l ? `# ${l}` : '#'));
}

// A zone's map id by its name: the gathering zone table's, else any zone of the data (the capitals' water).
function zoneId(ctx, name) {
	const id = Object.keys(ZONES).find((z) => zoneName(ctx, Number(z)) === name) || Object.keys(ctx.data.zones).find((z) => zoneName(ctx, Number(z)) === name);
	if (!id) throw new Error(`gathering route: unknown zone "${name}"`);
	return Number(id);
}

// -> { text, notes }: the guide and the route zones without a safe loop (for the build's report).
function renderRoute(ctx, prof, route) {
	const B = require('./build');
	const { skillLevel } = require('./farm');
	const { TIP_MAX, IMPERATIVE, stationPlaces } = require('../route');
	const P = prof.skill;
	const pq = /\s/.test(P) ? `"${P}"` : P;
	const pd = ctx.data.professionNamed(P);
	const recipes = new Map((pd.recipes || []).map((r) => [r.spell, r]));
	const itemName = (id) => (ctx.data.item(id) || {}).name || `item ${id}`;
	const errs = [];
	const notes = [];
	const bands = prof.bands ? B.plan(ctx, prof).filter((e) => e.kind === 'band') : [];

	// ------------------------------------------------------------- the route's own facts
	for (const t of route.tools || []) {
		for (const side of FACTIONS) {
			for (const v of (t.vendors || {})[side] || []) {
				const n = ctx.data.npc(v);
				const sells = ((ctx.data.item(t.item) || {}).vendors || []).includes(v);
				if (!n) errs.push(`tool ${t.item}: vendor ${v} is not in npcs.json`);
				else if (!sells) errs.push(`tool ${t.item}: ${n.name} does not sell it`);
				else if (n.faction && n.faction !== 'AH' && n.faction !== side[0]) errs.push(`tool ${t.item}: ${n.name} does not serve the ${side}`);
			}
		}
	}
	if (route.starter) {
		const q = ctx.data.quest(route.starter.quest);
		if (!q || !((q.rewards || {}).choices || []).includes(route.starter.item)) errs.push(`starter: quest ${route.starter.quest} offers no item ${route.starter.item}`);
	}

	// ------------------------------------------------------------- steps
	const out = [];
	const tipOf = (text) => {
		if (!text) return null;
		if (text.length > TIP_MAX) errs.push(`a tip over ${TIP_MAX} characters: "${text}"`);
		if (IMPERATIVE.test(text)) errs.push(`a tip that tells the player to do something (make it a step): "${text}"`);
		return text;
	};
	let lastKind = null;
	const step = (kind, title, tip, lines) => {
		const t = tipOf(tip);
		out.push('', `step ${title}`, ...(t ? [`  tip ${t}`] : []), ...lines);
		lastKind = kind;
	};
	let skill = 1;
	let rank = null;
	const known = new Set((pd.recipes || []).filter((r) => r.source === 'trainer' && !(r.cost > 0) && Number(r.learnedAt) <= 1).map((r) => r.spell));
	const visits = []; // skill at each trainer visit
	let visit = null; // { skill, learned: Set }
	const closeVisit = () => {
		if (!visit) return;
		// A trainer recipe that gives points from here is learned on this visit (no second trip for it).
		for (const r of pd.recipes || []) {
			if (r.source !== 'trainer' || !(r.cost > 0) || known.has(r.spell) || !prof.trainerRecipes || !prof.trainerRecipes(r)) continue;
			if (Number(r.learnedAt) <= visit.skill && Number(r.grey) > visit.skill && (route.unused || []).indexOf(r.spell) < 0) errs.push(`${r.name} gives points from ${visit.skill} and is taught on this visit: learn it here (or list it in \`unused\` with why)`);
		}
		visits.push(visit.skill);
		visit = null;
	};
	const openVisit = () => {
		if (!visit) visit = { skill };
	};
	const stock = new Map();
	const stations = new Map();
	const stationData = { npcs: ctx.data.npcs, objects: ctx.data.objects, items: new Proxy({}, { get: (o, k) => ctx.data.item(Number(k)) }), mapFrames: ctx.data.mapFrames || ctx.data['map-frames'] || {} };
	const stationLines = (focus) => {
		if (!stations.has(focus)) stations.set(focus, stationPlaces(focus, pd, route, stationData));
		return stations.get(focus).map((s) => `  goto ${s.x},${s.y} "${focus}" map ${s.map} ${s.f === 'l' ? 'live ' : ''}nearest${s.side ? ` only ${s.side}` : ''}`);
	};
	// The loop lines of a band, with the route's own zones added (each for its side). A zone with its own beasts
	// (`mobs`: zone -> beast names, Skinning) gets a loop over those beasts in place of the planner's there.
	const loopsOf = (b, e) => {
		let loops = b.loops.map((l) => ({ ...l, factions: l.factions.slice() }));
		for (const side of FACTIONS) {
			for (const name of ((e && e.zones) || {})[side] || []) {
				const map = zoneId(ctx, name);
				const mobs = (e.mobs || {})[name];
				const raw = mobs ? require('./skinning').SKINNING_POINTS(ctx, map, b.band.from, b.band.to, mobs) : B.pointsOf(ctx, prof, map, b.band.from, b.band.to);
				const pts = B.partPoints(raw, b.from, b.to);
				if (!mobs && loops.some((l) => l.zone === map && l.factions.includes(side))) continue;
				const f = pts.length >= 2 ? B.farmIn(ctx, prof, map, pts, side, skillLevel(b.from)) : null;
				if (!f) {
					notes.push(`${P} ${b.from}-${b.to}: ${name} has no safe loop for the ${side}${mobs ? ` on ${mobs.join(', ')}` : ''}`);
					continue;
				}
				if (mobs) {
					for (const l of loops) if (l.zone === map) l.factions = l.factions.filter((x) => x !== side);
					loops = loops.filter((l) => l.factions.length);
				}
				loops.push({ zone: map, farm: f, factions: [side] });
			}
		}
		return loops;
	};
	const bandAt = (to, from) => {
		const b = bands.filter((x) => x.to === to && x.from >= from - 0).pop() || bands.find((x) => x.to === to);
		if (!b) errs.push(`${P}: ${to} is no band end of the planner (${bands.map((x) => x.to).join(', ')})`);
		return b;
	};
	// A level step, once per level the route asks (the character's level only rises).
	let charLevel = 1;
	const reach = (n, tip) => {
		if (n <= charLevel) return;
		step('level', `Reach level ${n}`, tip, [`  level ${n}`]);
		charLevel = n;
	};
	// Fishing: each route water's round (fish-rounds.js: the stands players fished from, kept away from hostile
	// creatures above the band, the other faction's towns and guards, and boat docks) as a farming loop.
	const FR = P === 'Fishing' ? require('./fish-rounds') : null;
	const F = P === 'Fishing' ? require('./fishing') : null;
	const fishWatersAt = new Map();
	const fishWaters = (from, e) => {
		if (fishWatersAt.has(e)) return fishWatersAt.get(e);
		const band = { from, to: e.gather, level: e.level || 1, want: [] };
		const out = [];
		for (const side of FACTIONS) {
			for (const name of (e.zones || {})[side] || []) {
				const map = zoneId(ctx, name, true);
				let w = null;
				try {
					w = FR.asLoop(ctx, band, side, FR.roundAt(ctx, map, side, band));
				} catch (err) {
					w = null;
				}
				if (!w || w.stops.length < 2) {
					notes.push(`Fishing ${from}-${e.gather}: ${name} has no safe round for the ${side}`);
					continue;
				}
				const same = out.find((x) => x.map === w.map && x.stops.map((s) => `${s.pt.x},${s.pt.y}`).join(' ') === w.stops.map((s) => `${s.pt.x},${s.pt.y}`).join(' ') && x.level === w.level);
				if (same && same.sides) same.sides.push(side);
				else out.push({ ...w, sides: [side] });
			}
		}
		// One loop for both sides where the round is the same (`only` names who may take it).
		for (const w of out) if (w.sides.length > 1) w.only = 'Alliance,Horde';
		fishWatersAt.set(e, out);
		return out;
	};
	const CATCH_SECONDS = 15;
	const LURE_SECONDS = 600;
	// Artisan Fishing: the fishing trainer's quest, Nat Pagle's quest, his four fish (each at its fishing
	// location, fishing.js), the hand-in.
	const pagleSteps = (e) => {
		const pagle = ctx.data.quest(6607);
		const firsts = { Alliance: 6609, Horde: 6608 };
		for (const side of FACTIONS) {
			const q = ctx.data.quest(firsts[side]);
			const giver = ctx.data.npc(q.start.npc[0]);
			if (!(pagle.pre || []).includes(q.id)) errs.push(`quest ${q.id} is no step before Nat Pagle's in the data`);
			step('quest', `Accept ${q.title}`, `${giver.name}, the fishing trainer, sends you to Nat Pagle in Dustwallow Marsh.`, [`  only ${side}`, `  accept ${q.id}`]);
		}
		for (const side of FACTIONS) step('quest', `Hand in ${ctx.data.quest(firsts[side]).title}`, 'Nat Pagle fishes from a small island off the east coast, south of Theramore.', [`  only ${side}`, `  turnin ${firsts[side]}`]);
		step('quest', `Accept ${pagle.title}`, 'Four fish, each from its own water; about one catch in five brings it up there.', [`  accept 6607`]);
		for (const f of F.PAGLE_FISH) {
			const item = itemName(f.item);
			if (f.full > 225) step('buy', `Buy 2 ${itemName(F.BRIGHT_BAUBLES)}`, `Fish get away in ${zoneName(ctx, f.zone)} below skill ${f.full}; a lure adds 75 for ten minutes.`, [`  buy ${F.BRIGHT_BAUBLES} x2 nearest`]);
			const per = FACTIONS.map((side) => ({ side, c: F.spot(ctx, f, F.anchorFor(ctx, f, side), side) }));
			if (per.some((p) => !p.c)) errs.push(`no ${item} spot in ${zoneName(ctx, f.zone)}`);
			else {
				const same = Math.hypot(per[0].c.pt.x - per[1].c.pt.x, per[0].c.pt.y - per[1].c.pt.y) < 1;
				for (const p of same ? [per[0]] : per) step('collect', `Catch a ${item}`, e.where && e.where[f.item], [...(same ? [] : [`  only ${p.side}`]), `  zone ${zoneName(ctx, f.zone)}`, `  collect ${f.item} quest 6607 @${fmt(p.c.pt.x)},${fmt(p.c.pt.y)}`]);
			}
		}
		step('quest', `Hand in ${pagle.title}`, null, ['  zone Dustwallow Marsh', '  turnin 6607']);
		const art = (pd.ranks || []).find((x) => x.name === 'Artisan');
		step('train', `Train Artisan ${P}`, `Nat Pagle teaches it once his quest is done: needs ${P} skill ${art.minSkill} and level ${art.minLevel}.`, [`  train ${pq} Artisan`]);
	};

	for (const sec of route.sections) {
		closeVisit();
		out.push('', `section ${P} ${sec.from}-${sec.to}`);
		for (const e of sec.steps) {
			if (e.train) {
				const r = (pd.ranks || []).find((x) => x.name === e.train);
				if (!r) errs.push(`unknown rank ${e.train}`);
				else if (r.minSkill > skill) errs.push(`${e.train} needs skill ${r.minSkill}; the route is at ${skill}`);
				openVisit();
				rank = e.train;
				const title = e.train === 'Apprentice' ? `Learn ${P}` : `Train ${e.train} ${P}`;
				const tip = e.tip || (e.train === 'Apprentice' ? 'No character level needed.' : `Needs ${P} skill ${r.minSkill}${r.minLevel > 1 ? ` and level ${r.minLevel}` : ''}.`);
				step('train', title, tip, [`  train ${pq} ${e.train}`]);
			} else if (e.learn) {
				const r = recipes.get(e.learn);
				if (!r) {
					errs.push(`recipe ${e.learn} is not ${P}'s`);
					continue;
				}
				if (Number(r.learnedAt) > skill) errs.push(`${r.name} is taught from ${r.learnedAt}; the route is at ${skill}`);
				const earlier = visits.find((v) => v >= Number(r.learnedAt));
				if (earlier !== undefined) errs.push(`${r.name} was learnable on the visit at ${earlier}: learn it there`);
				openVisit();
				known.add(r.spell);
				step('learn', `Learn ${r.name}`, e.tip, [`  learn ${r.spell}`]);
			} else {
				closeVisit();
				if (e.tool) {
					const name = itemName(e.tool);
					step('tool', `Buy ${/s$/.test(name) ? '' : /^[aeiou]/i.test(name) ? 'an ' : 'a '}${name}`, e.tip, [`  buy ${e.tool} x1 nearest`]);
				} else if (e.track) {
					step('track', `Turn on ${e.name}`, e.tip, [`  cast ${e.track} "${e.name}"`]);
				} else if (e.get) {
					const b = bands.find((x) => x.from <= skill && skill < x.to) || bands[0];
					const lines = [];
					for (const l of loopsOf(b, null)) {
						const lap = B.bandYield(ctx, prof, l.farm.on, l.farm.up);
						const all = lap.reduce((s, x) => s + x.count, 0);
						const mine = lap.find((x) => x.item === e.get);
						if (!mine || mine.count < all * MIN_SHARE) continue;
						lines.push(B.loopLine(ctx, prof, l).replace(/ gain \S+/, ` yield ${fmt(mine.count)}`));
					}
					if (!lines.length) errs.push(`no ${P} loop at ${skill} gives ${itemName(e.get)}`);
					stock.set(e.get, (stock.get(e.get) || 0) + e.count);
					step('get', `Get ${e.count} ${itemName(e.get)}`, e.tip, [`  collect ${e.get} x${e.count} gather ${pq} ${e.rank || b.from}`, ...lines, `  auction ${e.get} x${e.count}`]);
				} else if (e.smelt) {
					const r = recipes.get(e.smelt);
					if (!r) {
						errs.push(`recipe ${e.smelt} is not ${P}'s`);
						continue;
					}
					if (!known.has(r.spell)) errs.push(`${r.name} is smelted before any step learns it`);
					for (const g of r.reagents) {
						const have = stock.get(g.item) || 0;
						if (have < g.count * e.count) errs.push(`${e.count} ${r.name} take ${g.count * e.count} ${itemName(g.item)}; the bags hold ${have}`);
						stock.set(g.item, have - g.count * e.count);
					}
					stock.set(r.item, (stock.get(r.item) || 0) + e.count);
					if (r.focus && lastKind !== 'smelt' && lastKind !== 'station') step('station', `Go to ${/^[aeiou]/i.test(r.focus) ? 'an' : 'a'} ${r.focus.toLowerCase()}`, null, stationLines(r.focus));
					step('smelt', `Smelt ${e.count} ${itemName(r.item)}s`, e.tip, [`  craft ${r.spell} x${e.count}`]);
					if (e.to) skill = Math.max(skill, e.to);
				} else if (e.gather && P === 'Fishing') {
					if (rank && e.gather > CAP[rank]) errs.push(`${e.gather} is past the ${rank} cap (${CAP[rank]})`);
					const waters = fishWaters(skill, e);
					fishWatersAt.set(e, waters);
					if (!waters.length) errs.push(`Fishing ${skill}-${e.gather}: no water with a safe round`);
					step('gather', `Fish ${e.title || 'here'} until ${e.gather}`, e.tip, [...waters.map((w) => `  ${FR.loopLine(ctx, w)}`), `  skill ${pq} ${e.gather}`]);
					skill = e.gather;
				} else if (e.gather) {
					const b = bandAt(e.gather, skill);
					if (!b) continue;
					if (rank && e.gather > CAP[rank]) errs.push(`${e.gather} is past the ${rank} cap (${CAP[rank]})`);
					const loops = loopsOf(b, e);
					const nodes = B.nodeSummary(prof, loops.flatMap((l) => l.farm.on), b.from, b.to);
					const lv = nodes.filter((n) => n.color && n.color !== 'grey').map((n) => n.level);
					const what = e.title || (prof.skins ? `beasts of level ${Math.min(...lv)}-${Math.max(...lv)}` : prof.bandTitle(nodes, b).replace(/ & /g, ' and '));
					step('gather', `${VERB[P]} ${what} until ${e.gather}`, e.tip, [...loops.map((l) => B.loopLine(ctx, prof, l)), `  skill ${pq} ${e.gather}`]);
					skill = e.gather;
				} else if (e.buy) {
					step('buy', `Buy ${e.count} ${e.plural || itemName(e.buy)}`, e.tip, [`  buy ${e.buy} x${e.count} nearest`]);
				} else if (e.lure) {
					// Enough lures for the next fishing step's catches below its waters' no-getaway skill (ten minutes each).
					const next = sec.steps[sec.steps.indexOf(e) + 1];
					const waters = next && next.gather ? fishWaters(skill, next) : [];
					fishWatersAt.set(next, waters);
					const full = Math.max(0, ...waters.map((w) => w.full || 0));
					const to = Math.min(full, next ? next.gather : skill);
					if (to <= skill) errs.push(`lure ${e.lure} before ${skill}: no water ahead loses fish`);
					const n = Math.max(1, Math.ceil((F.catches(skill, to) * CATCH_SECONDS) / LURE_SECONDS));
					step('buy', `Buy ${n} ${e.plural || itemName(e.lure)}`, e.tip || `For the water that loses fish below ${full}: ten minutes each, about ${n} to ${to}.`, [`  buy ${e.lure} x${n} nearest`]);
				} else if (e.equip) {
					step('equip', `Equip the ${itemName(e.equip)}`, e.tip, [`  equip ${e.equip}`]);
				} else if (e.use) {
					step('use', e.title || `Use ${/^[aeiou]/i.test(itemName(e.use)) ? 'an' : 'a'} ${itemName(e.use)}`, e.tip, [`  use ${e.use} anywhere`]);
				} else if (e.level) {
					reach(e.level, e.tip);
				} else if (e.spell) {
					// A class spell that opens the skill (Pick Lock): the class trainer, skipped once known.
					reach(e.minLevel || 1, e.levelTip);
					step('train', `Learn ${e.name}`, e.tip, [`  when !knows ${e.spell}`, '  train class']);
				} else if (e.pick) {
					// Lockpicking: boxes to pick at their places (each object's spawns on its map, from the data); the skill
					// stops at `levelCap` times the character level, so a level step comes first where the target asks it.
					if (route.levelCap) reach(Math.ceil(e.pick / route.levelCap), `${P} stops at ${route.levelCap} times your level: ${e.pick} needs level ${Math.ceil(e.pick / route.levelCap)}.`);
					const lines = [];
					for (const a of e.at) {
						const o = ctx.data.objects[a.object];
						const s = o && o.spawns && o.spawns[String(a.map)];
						if (!s) {
							errs.push(`object ${a.object} has no spawn on map ${a.map}`);
							continue;
						}
						const pts = [...(s.pts || []), ...(s.more || [])];
						const x = pts.reduce((t, p) => t + p[0], 0) / pts.length;
						const y = pts.reduce((t, p) => t + p[1], 0) / pts.length;
						lines.push(`  goto ${fmt(x)},${fmt(y)} "${a.label || o.name}" map ${a.map}${s.f === 'l' ? ' live' : ''}${a.only ? ` only ${a.only}` : ''} r 30`);
					}
					step('gather', `Pick ${e.title} until ${e.pick}`, e.tip, [...lines, `  skill ${pq} ${e.pick}${lines.length > 1 ? ' nearest' : ''}`]);
					skill = e.pick;
				} else if (e.book) {
					// A rank taught by a book (professions.json rank `book`): buy it, then read it.
					const r = (pd.ranks || []).find((x) => x.book && x.book.item === e.book);
					if (!r) {
						errs.push(`no rank of ${P} is taught by item ${e.book}`);
						continue;
					}
					if (r.minSkill > skill) errs.push(`${r.name} needs skill ${r.minSkill}; the route is at ${skill}`);
					step('buy', `Buy ${itemName(e.book)}`, e.tip, [`  buy ${e.book} x1 nearest`, `  auction ${e.book} x1`]);
					step('train', `Read ${itemName(e.book)}`, `It teaches ${r.name} ${P}: needs ${P} skill ${r.minSkill} and level ${r.minLevel}.`, [`  train ${pq} ${r.name} "Read ${itemName(e.book)}"`]);
					rank = r.name;
				} else if (e.pagle) {
					pagleSteps(e);
					rank = 'Artisan';
				} else errs.push(`unknown route step ${JSON.stringify(e)}`);
			}
		}
	}
	closeVisit();
	if (errs.length) throw new Error(`${P} route (tools/lib/professions/routes/${P.toLowerCase()}.json):\n  ${errs.join('\n  ')}`);

	const L = [header('guide', 'profession gathering build', `tools/lib/professions/routes/${prof.file}.json and data/forever`), `guide forever/professions/${prof.file}`, `title ${route.title || prof.title}`, 'category Professions', ...(route.class ? [`class ${route.class}`] : []), 'coords era', `levels ${route.levels || prof.levels}`, `zone ${route.zone || prof.headerZone}`, ''];
	for (const para of route.intro || []) L.push(...comment(para), '#');
	if (VERB[P] || P === 'Fishing') L.push(...comment(LOOPS_NOTE));
	return { text: `${[...L, ...out].join('\n').replace(/\n+$/, '')}\n`, notes };
}

module.exports = { renderRoute };
