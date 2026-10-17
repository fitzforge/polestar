'use strict';
// The planner's one command registry: the page calls it over HTTP
// (POST /api/cmd), agents over MCP (`planner mcp`) and WebMCP. Each command:
// { name (snake_case, the MCP tool name), description (for an AI agent),
// input (JSON Schema of the args), mutates (edits files: serialized),
// handler(ws, args, ctx) }. ctx: { clients () -> open pages, icons (the server's
// tools/planner/icons.js service, when it has one) }.
//
// run(ws, name, args, ctx) checks the args against `input` and calls the handler.

const fs = require('node:fs');
const path = require('node:path');
const { find, KINDS } = require('../lib/find');
const { CLASS_FILES, RACE_FILES, SIDES, classLabel, raceLabel } = require('../lib/game/races');
const { PlannerError } = require('./workspace');
const { ROOT } = require('../lib/paths');
const { NAMES: GLYPH_NAMES } = require('./glyphs');
const { UI, KINDS: KINDS_ICON } = require('./icons');

// --- schemas -----------------------------------------------------------------

const GUIDE_ID = { type: 'string', description: 'A guide id as written on its `guide` line, e.g. "forever/alliance/dwarf-gnome/01-dun-morogh" (guides_list lists them).' };
const HASH = { type: 'string', description: 'The `hash` of the GuideView you edit (guide_get / the last edit result): the edit is refused when the file changed since.' };
const LINE = { type: 'integer', minimum: 1, description: '1-based line number of a goal in the .guide file (GuideView steps[].goals[].line).' };
const PACK = { type: 'string', description: 'A pack id (planner_info packs[].id; "guides" is ours). Default: the first pack, ours.' };
const CHARACTER = {
	type: 'object',
	description: 'The character playing the route.',
	required: ['race', 'cls', 'faction'],
	properties: {
		race: { type: 'string', enum: RACE_FILES, description: 'Race file name (Undead is "Scourge"; Skyborne plays on either side).' },
		cls: { type: 'string', enum: CLASS_FILES, description: 'Class file name, upper case.' },
		faction: { type: 'string', enum: SIDES },
	},
	additionalProperties: false,
};
const CHOICES = {
	type: 'object',
	description: 'Route choices: guide id -> the id of the `next` guide to follow after it, where the guide offers several (guides_list nextChoices). Unnamed choices take the first option the character can follow.',
	additionalProperties: { type: 'string' },
};
const FIELDS = {
	type: 'object',
	description: 'Goal fields as GuideView goals[].fields shows them (the parser\'s output: `verb` plus the verb\'s fields; see verbs_schema). Example: { "verb": "kill", "npc": 1124, "count": 5 }.',
	additionalProperties: true,
};
const OP = {
	type: 'object',
	description: [
		'One source edit operation (written straight into the .guide file). `line` is a 1-based file line of a goal and `step` a 0-based step index (GuideView steps[].index), both as in the GuideView at `hash`, even for later ops of a batch; `index` is the 0-based position after the operation, in the guide as the earlier ops of the batch left it. Text values are one line each (no line breaks), except a tip, whose lines become one `tip` line each.',
		'{ op: "setCoords", line, x, y, map?, zoneMap?, frame?, yards? }: rewrite only the goal\'s coordinates (map percent 0-100 on uiMap `map`, in frame "era" or "live"); map is dropped when it equals the goal\'s zone (zoneMap, its uiMapID).',
		'{ op: "setRadius", line, r }: arrival radius in yards on goto/explore; r null removes it.',
		'{ op: "setGoal", line, fields }: the goal line rewritten from fields (indent, note and comment kept).',
		'{ op: "insertGoal", step, index, fields } / { op: "deleteGoal", line } / { op: "moveGoal", line, step, index }.',
		'{ op: "setStep", step, title?, tip?, only?, zone? }: omitted keeps, null or "" removes; tip lines are separated by \\n.',
		'{ op: "insertStep", index, title, goals: [fields] } / { op: "deleteStep", step } / { op: "moveStep", step, index }.',
		'{ op: "setHeader", key, value }: a header line (title, levels, next, coords...).',
	].join(' '),
	required: ['op'],
	properties: {
		op: { type: 'string', enum: ['setCoords', 'setRadius', 'setGoal', 'insertGoal', 'deleteGoal', 'moveGoal', 'setStep', 'insertStep', 'deleteStep', 'moveStep', 'setHeader'] },
		line: { type: 'integer', minimum: 1 },
		x: { type: 'number', description: 'Map percent, 0 west - 100 east.' },
		y: { type: 'number', description: 'Map percent, 0 north - 100 south.' },
		map: { type: ['integer', 'null'], description: 'uiMapID the coordinates are on.' },
		zoneMap: { type: ['integer', 'null'], description: 'uiMapID of the goal\'s zone in effect.' },
		frame: { type: ['string', 'null'], enum: ['era', 'live', null] },
		yards: { type: 'object', properties: { x: { type: 'number' }, y: { type: 'number' } }, description: 'Yards per map percent of the frame, for the written precision.' },
		r: { type: ['number', 'null'] },
		fields: FIELDS,
		step: { type: 'integer', minimum: 0 },
		index: { type: 'integer', minimum: 0 },
		title: { type: ['string', 'null'] },
		tip: { type: ['string', 'null'] },
		zone: { type: ['string', 'object', 'null'], description: 'setStep: the text after `zone ` as written ("Dun Morogh" or "map 1426"), or { name } / { map }; null or "" removes the step\'s zone line.' },
		only: { type: ['string', 'null'], description: 'setStep: the condition list as written, e.g. "Human,Dwarf".' },
		goals: { type: 'array', items: FIELDS },
		key: { type: 'string' },
		value: { type: ['string', 'number', 'null'] },
	},
	additionalProperties: false,
};
const NONE = { type: 'object', properties: {}, additionalProperties: false };
const NAV_POINT = {
	type: 'object',
	description: '{ map, x, y } (uiMapID, Era map percent) or { c, wx, wy } (world yards).',
	properties: { map: { type: 'integer', minimum: 1 }, x: { type: 'number' }, y: { type: 'number' }, c: { type: 'integer', minimum: 0 }, wx: { type: 'number' }, wy: { type: 'number' } },
	additionalProperties: false,
};

// --- a JSON Schema subset check (the keywords used above) --------------------

function typeOf(v) {
	if (v === null) return 'null';
	if (Array.isArray(v)) return 'array';
	if (typeof v === 'number') return Number.isInteger(v) ? 'integer' : 'number';
	return typeof v;
}

function check(schema, value, where) {
	if (schema.type) {
		const types = Array.isArray(schema.type) ? schema.type : [schema.type];
		const t = typeOf(value);
		if (!types.includes(t) && !(t === 'integer' && types.includes('number'))) throw new PlannerError(`${where} must be ${types.join(' or ')}, got ${t}`, 'bad_args');
	}
	if (schema.enum && !schema.enum.includes(value)) throw new PlannerError(`${where} must be one of ${schema.enum.map((e) => JSON.stringify(e)).join(', ')}`, 'bad_args');
	if (typeof value === 'number' && schema.minimum !== undefined && value < schema.minimum) throw new PlannerError(`${where} must be at least ${schema.minimum}`, 'bad_args');
	if (typeOf(value) === 'object') {
		for (const k of schema.required || []) if (value[k] === undefined) throw new PlannerError(`${where}.${k} is required`, 'bad_args');
		for (const [k, v] of Object.entries(value)) {
			if (v === undefined) continue;
			const sub = schema.properties && Object.hasOwn(schema.properties, k) ? schema.properties[k] : null;
			if (sub) check(sub, v, `${where}.${k}`);
			else if (schema.additionalProperties === false) throw new PlannerError(`${where}.${k} is not an argument here`, 'bad_args');
			else if (schema.additionalProperties && typeof schema.additionalProperties === 'object') check(schema.additionalProperties, v, `${where}.${k}`);
		}
	}
	if (typeOf(value) === 'array' && schema.items) value.forEach((v, i) => check(schema.items, v, `${where}[${i}]`));
}

// --- helpers -----------------------------------------------------------------

function version() {
	return JSON.parse(fs.readFileSync(path.join(ROOT, 'package.json'), 'utf8')).version;
}

function artInfo(artDir) {
	if (!artDir) return { available: false, build: null, continents: [] };
	try {
		const index = JSON.parse(fs.readFileSync(path.join(artDir, 'index.json'), 'utf8'));
		const continents = Object.entries(index.continents || {}).map(([c, v]) => ({ c: Number(c), name: v.name, maxLevel: v.maxLevel }));
		return { available: true, build: index.build || null, product: index.product || null, continents, zones: Object.keys(index.zones || {}).length };
	} catch {
		return { available: false, build: null, continents: [] };
	}
}

function iconInfo(icons) {
	const game = icons ? icons.info() : { ui: Object.keys(UI), kinds: KINDS_ICON, available: false };
	return { glyphs: GLYPH_NAMES, ui: game.ui, kinds: game.kinds, available: game.available };
}

// Every place an NPC or object spawns, as world points.
function spawnPoints(ws, kind, id) {
	const out = [];
	for (const s of ws.data.spawns(kind, id)) {
		const f = s.f === 'e' ? 'e' : 'l';
		for (const [x, y] of [...s.pts, ...s.more]) {
			const w = ws.geo.toWorld(s.map, x, y, f);
			if (w) out.push({ c: w.c, wx: w.wx, wy: w.wy, map: s.map, x, y });
		}
	}
	return out;
}

// The zone uiMapID a goal's parse `zone` spec names, or null.
function zoneMapOf(ws, spec) {
	if (!spec) return null;
	if (spec.map !== undefined) return spec.map;
	const found = ws.data.zoneNamed(spec.name);
	return found ? found.zone.id : null;
}

function goalAt(ast, line) {
	for (const st of (ast && ast.steps) || []) for (const g of st.goals) if (g.line === line) return g;
	return null;
}

function inside(p) {
	return p && p.x >= 0 && p.x <= 100 && p.y >= 0 && p.y <= 100;
}

// A world point as a goal writes it: in the zone map in effect (`zoneSpec`,
// a parse zone spec) when the point lies inside it, else in the smallest
// zone/city map holding it, in `frame` ('era' | 'live').
// -> { x, y, map, zoneMap, frame, yards: { x, y } (yards per map percent) }
function worldPoint(ws, zoneSpec, frame, c, wx, wy) {
	const f = frame === 'era' ? 'e' : 'l';
	const zoneMap = zoneMapOf(ws, zoneSpec);
	let map = null;
	let p = zoneMap !== null ? ws.geo.toMap(zoneMap, c, wx, wy, f) : null;
	if (inside(p)) map = zoneMap;
	else {
		const z = ws.geo.containing(c, wx, wy, f)[0];
		if (!z) throw new PlannerError(`no zone map holds ${c}:${Math.round(wx)},${Math.round(wy)}`, 'bad_args');
		map = z.map;
		p = z;
	}
	const b = ws.geo.frame(map, f);
	return { x: p.x, y: p.y, map, zoneMap, frame, yards: { x: Math.abs(b.right - b.left) / 100, y: Math.abs(b.bottom - b.top) / 100 } };
}

// The guide source of `a.id` at the edit's `a.hash`, refused when stale. -> { src, ast }
function editable(ws, a) {
	const src = ws.source(a.id);
	ws.syncFromDisk(src);
	if (a.hash !== src.hash) throw new PlannerError(`${src.file} changed since hash ${a.hash} (now ${src.hash}): reload the guide and edit again`, 'stale');
	return { src, ast: ws.compiled(src).ast };
}

// What timeline_get returns for `view` (see its description): the full
// Timeline is several MB for a 1-60 route, too much for an agent's context.
function timelineView(tl, view, guide, optional) {
	if (view === 'full') return tl;
	const r1 = (v) => Math.round(v * 10) / 10;
	const split = (s) => ({ travel: r1(s.travel), combat: r1(s.combat), interact: r1(s.interact), wait: r1(s.wait) });
	const stepRow = (s) => ({
		i: s.i, guide: tl.guides[s.gi].id, line: s.line, title: s.label, applies: s.applies,
		start: r1(s.start), seconds: r1(s.end - s.start), split: split(s.split),
		levelStart: s.levelStart, levelEnd: s.levelEnd, dings: s.dings, xp: Math.round(s.xp), estimate: s.estimate,
		routed: s.goals.filter((g) => g.route).length, straight: s.goals.filter((g) => g.routeReason).map((g) => ({ line: g.line, reason: g.routeReason })),
	});
	const guides = tl.guides.map((g) => ({
		id: g.id, title: g.title, file: g.file, start: r1(g.start), seconds: r1(g.end - g.start),
		levelStart: g.levelStart, levelEnd: g.levelEnd, steps: g.s1 - g.s0 + 1, next: g.next, choices: g.choices,
	}));
	const totals = { ...tl.totals, seconds: r1(tl.totals.seconds), split: split(tl.totals.split) };
	const nav = { build: tl.nav ? tl.nav.build : null, routing: tl.routing ? { ...tl.routing } : null };
	if (view === 'steps') {
		const steps = tl.steps.filter((s) => !guide || tl.guides[s.gi].id === guide).map(stepRow);
		return { character: tl.character, optional, totals, nav, guides, steps, warnings: tl.warnings.filter((w) => !guide || w.guide === guide) };
	}
	const slowest = tl.steps.filter((s) => s.applies).sort((a, b) => b.end - b.start - (a.end - a.start)).slice(0, 15).map(stepRow);
	return { character: tl.character, optional, totals, nav, guides, slowest, warnings: tl.warnings.slice(0, 40), warningCount: tl.warnings.length };
}

// The route a character starts on: our first leveling guide for them that no other guide hands over to.
function defaultStart(ws, character) {
	const list = ws.list();
	const named = new Set(list.flatMap((g) => g.nextChoices || (g.next ? [g.next] : [])));
	const fits = (g) => (!g.faction || g.faction === character.faction) && (!g.races || g.races.includes(character.race)) && (!g.classes || g.classes.includes(character.cls));
	const first = list.find((g) => g.category === 'Leveling' && !named.has(g.id) && fits(g)) || list.find(fits) || list[0];
	return first ? first.id : null;
}

const DEFAULT_CHARACTER = { race: 'Human', cls: 'WARRIOR', faction: 'Alliance' };
const CLS_NAMES = ['walk', 'steep', 'swim', 'jump', 'fall', 'indoor', 'climb', 'lift']; // tools/lib/nav/grid/format.js CLS
const round = (v, k) => Math.round(v * k) / k;

// nav_route: one walk on the grid through the workspace's route pool.
async function navRoute(ws, a) {
	const nav = ws.navRoutes();
	const info = nav ? nav.info() : null;
	if (!info || !info.available) throw new PlannerError('no navigation grid: run node tools/polestar.js nav build', 'not_found');
	const end = (p, name) => {
		if (p.c !== undefined && p.wx !== undefined && p.wy !== undefined) return { c: p.c, wx: p.wx, wy: p.wy };
		if (p.map !== undefined && p.x !== undefined && p.y !== undefined) {
			const w = ws.geo.toWorld(p.map, p.x, p.y, 'e');
			if (!w) throw new PlannerError(`${name}: map ${p.map} has no map frame`, 'bad_args');
			return { c: w.c, wx: w.wx, wy: w.wy };
		}
		throw new PlannerError(`${name}: give { map, x, y } or { c, wx, wy }`, 'bad_args');
	};
	const from = end(a.from, 'from');
	const to = end(a.to, 'to');
	const ch = a.character || DEFAULT_CHARACTER;
	const level = a.level || 1;
	const params = ws.params(ch.cls);
	const { profileFor } = require('../lib/nav/move');
	const profile = profileFor({ cls: ch.cls, level, params });
	const { routes, misses } = nav.provider();
	let r = routes(from, to, profile);
	if (!r) {
		await nav.compute(misses).promise;
		r = routes(from, to, profile) || { ok: false, reason: 'not computed' };
	}
	const yards = Math.hypot(to.wx - from.wx, to.wy - from.wy);
	const mounted = level >= params.mountLevel;
	const detour = from.c === 0 ? params.detour0 : from.c === 1 ? params.detour1 : 1.3;
	const straight = from.c === to.c ? { yards: round(yards, 10), seconds: round((yards * detour) / (params.runSpeed * (mounted ? params.mountMul : 1)), 10) } : null;
	const prof = { name: profile.name, mode: profile.mode, outdoor: round(profile.outdoor, 1000), indoor: round(profile.indoor, 1000), swim: round(profile.swim, 1000) };
	if (!r.ok) return { ok: false, reason: r.reason || 'no path', profile: prof, straight };
	const points = [];
	for (let i = 0; i < r.pts.length; i += 3) {
		const wx = r.pts[i];
		const wy = r.pts[i + 1];
		const z = ws.geo.containing(from.c, wx, wy, 'e')[0] || null;
		const cls = i / 3 < r.cls.length ? CLS_NAMES[r.cls[i / 3]] : null;
		points.push({ c: from.c, wx, wy, z: r.pts[i + 2], cls, map: z ? z.map : null, x: z ? round(z.x, 100) : null, y: z ? round(z.y, 100) : null });
	}
	return { ok: true, reason: null, yards: r.yards, seconds: r.seconds, byClass: r.byClass, falls: r.falls, profile: prof, points, straight };
}

// --- the registry ------------------------------------------------------------

const COMMANDS = [
	{
		name: 'planner_info',
		description: 'What the planner has loaded: its version, the packs (ours is "guides"), the local map art (available, client build, continents), the navigation grid walks are routed on (nav: { available, build (the nav build id timelines and routes are cached under), continents, aids (the arrow aids file exists: GET /nav/aids.json) }), the icons the page can ask for (icons: { glyphs: names for GET /glyph/<name>.png, ui: keys for GET /icon/ui/<key>.png, kinds: the /icon/<kind>/ kinds, available: game icons can be served }), races.json (each race file\'s playable sides and classes), the classes, and defaults (a character and a start guide). Call this first.',
		input: NONE,
		mutates: false,
		handler: (ws, a, ctx) => ({
			version: version(),
			packs: ws.packs.map((p) => ({ id: p.id, title: p.title, dir: path.relative(ROOT, p.dir).startsWith('..') ? p.dir : path.relative(ROOT, p.dir) || '.', official: p.official, folder: p.manifest.folder, guides: [...ws.sources.values()].filter((s) => s.pack === p && s.id).length })),
			art: artInfo(ws.artDir),
			nav: ws.navInfo(),
			icons: iconInfo(ctx && ctx.icons),
			races: ws.data.races,
			raceNames: Object.fromEntries(RACE_FILES.map((r) => [r, raceLabel(r)])),
			classes: CLASS_FILES.map((c) => ({ file: c, name: classLabel(c) })),
			continents: ws.geo.continents(),
			defaults: { character: DEFAULT_CHARACTER, start: defaultStart(ws, DEFAULT_CHARACTER), startLevel: null },
		}),
	},
	{
		name: 'guides_list',
		description: 'Every guide of the loaded packs (or of one pack) from its header: id, pack, file (repository-relative path of the .guide), title, faction, races and classes (file names, null = all), levels { min, max }, zone name, category, folder, next (the default next guide id) and nextChoices (every option when the guide offers a route choice, else null).',
		input: { type: 'object', properties: { pack: PACK }, additionalProperties: false },
		mutates: false,
		handler: (ws, a) => ws.list(a.pack),
	},
	{
		name: 'guide_get',
		description: 'One guide as a GuideView: { id, pack, file, hash, coords ("era"|"live", the guide\'s coordinate frame), header, steps: [{ index (0-based), line, end, title, tip, only, zone, goals: [{ line, verb, raw (the line as written), fields (parsed fields), label, explicit (coordinates written in the guide), compiled: { map, x, y, f, r, spots, spread, candidates } (what the compiler resolved: uiMapID + map percent, f "e" = Era frame), world: { c (continent/instance map id), wx (yards, north+), wy (yards, west+) } | null }] }], diagnostics: [{ severity, line, message, hint }] }. Pass `hash` to edits. `brief: true` leaves out each goal\'s `fields` and the compiler\'s spawn `spots` and smart-target `candidates` (a few times smaller).',
		input: { type: 'object', required: ['id'], properties: { id: GUIDE_ID, brief: { type: 'boolean', description: 'Smaller: no goal fields, spots or candidates.' } }, additionalProperties: false },
		mutates: false,
		handler: (ws, a) => {
			const view = ws.view(a.id);
			if (!a.brief) return view;
			const goal = ({ fields, compiled, ...g }) => ({ ...g, compiled: compiled && { map: compiled.map, x: compiled.x, y: compiled.y, f: compiled.f, r: compiled.r } });
			return { ...view, steps: view.steps.map((s) => ({ ...s, goals: s.goals.map(goal) })) };
		},
	},
	{
		name: 'route_get',
		description: 'The chain of guides a character plays from `start`, following each guide\'s `next` (choices[id] where given, else the first option the character can follow): [{ id, title, choices (nextChoices of that guide, or null) }].',
		input: { type: 'object', required: ['start', 'character'], properties: { start: GUIDE_ID, character: CHARACTER, choices: CHOICES }, additionalProperties: false },
		mutates: false,
		handler: (ws, a) =>
			ws.route(a).map((id) => {
				const src = ws.byId.get(id);
				const h = (src && src.header) || {};
				return { id, title: h.title || id, choices: h.next && h.next.length > 1 ? h.next.slice() : null };
			}),
	},
	{
		name: 'timeline_get',
		description: 'Play the route from `start` for a character (priors-based clock, XP and quest log). Walks are routed on the navigation grid when the planner has one (planner_info nav.available): a routed leg takes the path\'s time for the character\'s movement profile (mount, forms, indoors, swimming, falls); so are the hops between spawn points inside kill, collect and interact areas; a leg the grid cannot route, or one still being computed, keeps the straight-line estimate (distance x detour / speed; a hop the spacing model\'s walk) and marks its step `estimate`. Flights follow the points the taxi path flies (TaxiPathNode) at the flight-time model. `view` picks how much comes back: "summary" (default: totals { seconds, split { travel, combat, interact, wait }, level, xp, quests, legs (walk legs between places), routed (legs walked on the grid), hops (walks between spawn points inside kill, collect and interact areas), hopsRouted, routeSeconds, estimateSeconds (time of the straight legs and hops) }, nav { build, routing: { id, pending, done } while legs are being computed (ask again when pending is 0), else null }, each guide\'s start/end seconds and levels, the 15 slowest steps, the first 40 warnings), "steps" (every step, or only guide `guide`\'s: start and duration in seconds, split, levels, dings, XP, `estimate` (straight-line travel or another guess), routed (goals walked on the grid), straight ([{ line, reason }]: goals with a straight leg and why), source `line`), or "full" (the page\'s Timeline with goals (route { yards, byClass, falls } when routed, estimate and routeReason when straight), places, spawns, per-step state, the position track and events: several MB for a 1-60 route). startLevel overrides the level the first guide starts at. `optional` (default false): optional goals that are not quest work (rare kills, drops without a quest) are skipped, as they never hold a step in the addon (skip reason "optional"); true plays them like the rest.',
		input: {
			type: 'object',
			required: ['start', 'character'],
			properties: {
				start: GUIDE_ID, character: CHARACTER, choices: CHOICES,
				startLevel: { type: ['integer', 'null'], minimum: 1, description: 'Level at the route\'s start (default: the first guide\'s minimum level).' },
				view: { type: 'string', enum: ['summary', 'steps', 'full'], description: 'Default "summary".' },
				guide: { type: 'string', description: 'With view "steps": only this guide\'s steps.' },
				optional: { type: 'boolean', description: 'Play optional goals too (default false: skipped).' },
			},
			additionalProperties: false,
		},
		mutates: false,
		handler: (ws, a) => {
			const { view = 'summary', guide = null, ...args } = a;
			return timelineView(ws.timeline(args), view, guide, !!args.optional);
		},
	},
	{
		name: 'edit_apply',
		description: 'Apply source edit operations to a guide; they are written into its .guide file at once (and undoable with edit_undo as one edit). Refused (code "stale") when `hash` is not the file\'s current hash. Ops run in order; each names goals by `line` and steps by `step` as the GuideView at `hash` shows them (the planner follows them through the earlier ops), so a batch reads like the view it was written from; an op naming a goal or step an earlier op deleted is refused (code "bad_args"), and steps a batch inserts cannot be named by its later ops. Each op is re-parsed and refused when it adds parse errors; a refused op writes nothing of the batch. Returns { guide: the new GuideView (new hash), select: { line } | null (the line to select) }.',
		input: { type: 'object', required: ['id', 'hash', 'ops'], properties: { id: GUIDE_ID, hash: HASH, ops: { type: 'array', items: OP, description: 'Applied in order; `line`/`step` as in the GuideView at `hash`.' }, label: { type: 'string', description: 'Undo history label.' } }, additionalProperties: false },
		mutates: true,
		handler: (ws, a) => ws.edit(a),
	},
	{
		name: 'edit_move_world',
		description: 'Move a located goal (goto, or a goal with @x,y) to a world point and write it into the .guide file: in the goal\'s zone map when the point lies inside it, else in the smallest zone/city map holding it (adding `map <uiMapID>`), in the guide\'s coordinate frame (or the goal\'s own era/live word). c is the continent/instance map id (0 Eastern Kingdoms, 1 Kalimdor), wx yards north, wy yards west (GuideView goals[].world uses the same). Returns as edit_apply.',
		input: { type: 'object', required: ['id', 'hash', 'line', 'c', 'wx', 'wy'], properties: { id: GUIDE_ID, hash: HASH, line: LINE, c: { type: 'integer', minimum: 0 }, wx: { type: 'number' }, wy: { type: 'number' } }, additionalProperties: false },
		mutates: true,
		handler: (ws, a) => {
			const { src, ast } = editable(ws, a);
			const goal = goalAt(ast, a.line);
			if (!goal) throw new PlannerError(`no goal on line ${a.line} of ${src.file}`, 'bad_args');
			const p = worldPoint(ws, goal.zone, goal.frame || (ast.header && ast.header.coords) || 'era', a.c, a.wx, a.wy);
			return ws.edit({ id: a.id, hash: a.hash, ops: [{ op: 'setCoords', line: a.line, ...p }], label: 'Move waypoint' });
		},
	},
	{
		name: 'edit_insert_world',
		description: 'Insert a goto (or explore) goal at a world point, as one edit (one undo): into step `step` (0-based GuideView steps[].index) at goal position `index` (0-based; the step\'s goal count appends), or, with `title`, as the one goal of a new step inserted at position `step` (`index` ignored). Its coordinates are written as edit_move_world writes them: in the zone in effect there when the point lies inside it, else with `map <uiMapID>` of the smallest zone/city map holding it, in the guide\'s coordinate frame. c/wx/wy as edit_move_world; `text` is the goto label. Returns as edit_apply.',
		input: {
			type: 'object',
			required: ['id', 'hash', 'step', 'c', 'wx', 'wy'],
			properties: {
				id: GUIDE_ID, hash: HASH,
				step: { type: 'integer', minimum: 0 }, index: { type: 'integer', minimum: 0, description: 'Goal position in the step; required without `title`.' },
				title: { type: 'string', description: 'Insert a new step with this title (may be empty) holding the goal.' },
				verb: { type: 'string', enum: ['goto', 'explore'], description: 'Default goto.' },
				text: { type: 'string', description: 'The label ("Frostmane Hold"); optional.' },
				c: { type: 'integer', minimum: 0 }, wx: { type: 'number' }, wy: { type: 'number' },
			},
			additionalProperties: false,
		},
		mutates: true,
		handler: (ws, a) => {
			const { formatCoord } = require('../lib/planner/goalfmt');
			const { zoneAt } = require('../lib/planner/source');
			const { src, ast } = editable(ws, a);
			const newStep = a.title !== undefined;
			if (newStep ? a.step > ast.steps.length : !ast.steps[a.step]) throw new PlannerError(`no step ${a.step} in ${src.file}`, 'bad_args');
			if (!newStep && a.index === undefined) throw new PlannerError('`index` is required without `title`', 'bad_args');
			// The zone in effect where the goal lands, so its coordinates are read
			// in the zone they are written for. A goal goes right before goal
			// `index` (after any `zone` line above that goal): that goal's zone;
			// appended, right after the last goal: the last goal's zone. A new
			// step goes before step `step` (or after the last): the zone in effect
			// at that step line (or the file's end), not after its own `zone` lines.
			let zone;
			if (newStep) zone = zoneAt(src.text, a.step < ast.steps.length ? ast.steps[a.step].line : Number.MAX_SAFE_INTEGER);
			else {
				const st = ast.steps[a.step];
				const near = st.goals[a.index] || st.goals[a.index - 1] || null;
				if (!near) throw new PlannerError(`goal index ${a.index} is out of range (0-${st.goals.length})`, 'bad_args');
				zone = near.zone;
			}
			const frame = (ast.header && ast.header.coords) || 'era';
			const p = worldPoint(ws, zone, frame, a.c, a.wx, a.wy);
			const fields = { verb: a.verb || 'goto', x: Number(formatCoord(p.x, p.yards.x)), y: Number(formatCoord(p.y, p.yards.y)), explicitCoords: true };
			if (p.map !== p.zoneMap) fields.coordMap = p.map;
			if (a.text) fields.text = a.text;
			const op = newStep ? { op: 'insertStep', index: a.step, title: a.title, goals: [fields] } : { op: 'insertGoal', step: a.step, index: a.index, fields };
			return ws.edit({ id: a.id, hash: a.hash, ops: [op], label: newStep ? 'Add step' : 'Add waypoint' });
		},
	},
	{
		name: 'edit_undo',
		description: 'Undo the last planner edit (any guide file): the file gets its text back, only when it still holds the text the edit wrote (else code "conflict"; the entry stays on top and blocks older ones). With `drop: true` a conflicting top entry is dropped from the history instead (its file is left as it is; a top entry without conflict is undone as usual). Returns { file, label, dropped (true when dropped), guide: GuideView | null }.',
		input: { type: 'object', properties: { drop: { type: 'boolean', description: 'Drop the top entry when it conflicts.' } }, additionalProperties: false },
		mutates: true,
		handler: (ws, a) => ws.undo({ drop: !!a.drop }),
	},
	{
		name: 'edit_redo',
		description: 'Redo the last undone planner edit, when the file still holds the undone text (else code "conflict"). With `drop: true` a conflicting top entry is dropped instead. Returns { file, label, dropped, guide: GuideView | null }.',
		input: { type: 'object', properties: { drop: { type: 'boolean', description: 'Drop the top entry when it conflicts.' } }, additionalProperties: false },
		mutates: true,
		handler: (ws, a) => ws.redo({ drop: !!a.drop }),
	},
	{
		name: 'changes_list',
		description: 'The guide files that differ from their text when the planner started: [{ file, guide (id), added, removed (line counts) }].',
		input: NONE,
		mutates: false,
		handler: (ws) => ws.changes(),
	},
	{
		name: 'changes_revert',
		description: 'Write a guide file back to its text when the planner started (undoable). `file` as changes_list names it. Returns { file, guide: GuideView | null }.',
		input: { type: 'object', required: ['file'], properties: { file: { type: 'string' } }, additionalProperties: false },
		mutates: true,
		handler: (ws, a) => ws.revert(a.file),
	},
	{
		name: 'lint',
		description: 'Full compile check of a pack (every guide, cross-guide rules; another pack with our guides as context): [{ file, line, severity ("error"|"warning"), message, hint? }]. Writes nothing.',
		input: { type: 'object', properties: { pack: PACK }, additionalProperties: false },
		mutates: false,
		handler: (ws, a) => ws.lint(a.pack),
	},
	{
		name: 'pack_compile',
		description: 'Compile a pack into its addon folder like `polestar compile` (ours -> addon/Polestar_Guides, another pack -> <pack>/dist/<folder>); nothing is written when there are errors. Returns { ok, errors, warnings (counts), outDir, guides, diagnostics }.',
		input: { type: 'object', properties: { pack: PACK }, additionalProperties: false },
		mutates: true,
		handler: (ws, a) => ws.compilePack(a.pack),
	},
	{
		name: 'find',
		description: 'Look up quests, NPCs, objects, items, inns, flight points and guides in the reference data by id or name (`polestar find`). Each result has a `line`: a guide goal line ready to paste. race (file) / cls (file) / faction keep what such a character can use.',
		input: {
			type: 'object',
			required: ['text'],
			properties: {
				text: { type: 'string', description: 'An id or (part of) a name.' },
				kind: { type: 'string', enum: KINDS },
				faction: { type: 'string', enum: SIDES },
				race: { type: 'string', enum: RACE_FILES },
				cls: { type: 'string', enum: CLASS_FILES },
				limit: { type: 'integer', minimum: 1 },
			},
			additionalProperties: false,
		},
		mutates: false,
		handler: (ws, a) => {
			const guides = ws.list().map((g) => ({ id: g.id, title: g.title, faction: g.faction, races: g.races, classes: g.classes, levels: g.levels, zone: g.zone, next: g.nextChoices || (g.next ? [g.next] : []) }));
			return find(ws.data, guides, { text: a.text, kind: a.kind || null, faction: a.faction || null, race: a.race || null, cls: a.cls || null, limit: a.limit || 20 });
		},
	},
	{
		name: 'spawns_get',
		description: 'Where an NPC or object spawns, or where an item drops (its droppers\' spawns), as { name, points: [{ c, wx, wy (world yards), map, x, y (map percent) }], sources }. Give exactly one of npc, object, item (ids).',
		input: { type: 'object', properties: { npc: { type: 'integer', minimum: 1 }, object: { type: 'integer', minimum: 1 }, item: { type: 'integer', minimum: 1 } }, additionalProperties: false },
		mutates: false,
		handler: (ws, a) => {
			const given = ['npc', 'object', 'item'].filter((k) => a[k] !== undefined);
			if (given.length !== 1) throw new PlannerError('give exactly one of npc, object, item', 'bad_args');
			const kind = given[0];
			const id = a[kind];
			if (kind !== 'item') {
				const e = kind === 'npc' ? ws.data.npc(id) : ws.data.object(id);
				if (!e) throw new PlannerError(`${kind} ${id} is not in the reference data`, 'not_found');
				return { name: String(e.name), points: spawnPoints(ws, kind, id), sources: [{ kind, id, name: String(e.name), pct: null }] };
			}
			const item = ws.data.item(id);
			if (!item) throw new PlannerError(`item ${id} is not in the reference data`, 'not_found');
			const sources = [];
			const drops = item.drops || {};
			for (const k of ['npc', 'object']) {
				for (const [sid, pct] of Object.entries(drops[k] || {})) {
					const e = k === 'npc' ? ws.data.npc(Number(sid)) : ws.data.object(Number(sid));
					sources.push({ kind: k, id: Number(sid), name: e && e.name ? String(e.name) : null, pct: Number(pct) });
				}
			}
			sources.sort((x, y) => y.pct - x.pct || x.id - y.id);
			const points = sources.flatMap((s) => spawnPoints(ws, s.kind, s.id));
			return { name: String(item.name), points, sources };
		},
	},
	{
		name: 'nav_route',
		description: 'A walk on the navigation grid (the terrain the client has: slopes, caves, buildings, water, falls), as the timeline routes it: from `from` to `to`, each { map, x, y } (uiMapID and map percent in the Era frame, as guides write era coordinates) or { c, wx, wy } (world yards: c continent, wx north, wy west). The movement profile is the character\'s (default a Human Warrior) at `level` (default 1): run 7 yd/s, mount from level 40, Ghost Wolf, Travel Form and the like (tools/lib/nav/move.js). Returns { ok, reason (why not: "no surface near the start", "different regions" = cannot be walked, ...), yards, seconds, byClass (seconds per walk, steep, climb, swim, indoor, fall, lift), falls [{ h, damage (share of max health) }], profile, points: [{ c, wx, wy, z, cls (the segment class to the next point), map, x, y (Era map percent of the smallest zone map holding it) }] (simplified), straight { yards, seconds } (the straight-line estimate, for comparison) }. Computed in the planner\'s worker pool and cached; the first route on a continent can take a few seconds.',
		input: {
			type: 'object',
			required: ['from', 'to'],
			properties: {
				from: NAV_POINT, to: NAV_POINT, character: CHARACTER,
				level: { type: 'integer', minimum: 1, maximum: 60, description: 'Character level (default 1).' },
			},
			additionalProperties: false,
		},
		mutates: false,
		handler: (ws, a) => navRoute(ws, a),
	},
	{
		name: 'verbs_schema',
		description: 'The goal verbs of the guide format and their fields: { verbs: { <verb>: { positional: [field], modifiers: [field] } } }; use these names in edit fields.',
		input: NONE,
		mutates: false,
		handler: () => require('../lib/planner/goalfmt').verbSchema(),
	},
	{
		name: 'view_state',
		description: 'What the open planner page last reported it shows (guide, step, line, time t in seconds, mode edit/playback, playing, speed, start, character, camera), with `at` (ms epoch); null when no page reported yet.',
		input: NONE,
		mutates: false,
		handler: (ws) => ws.viewState,
	},
	{
		name: 'view_focus',
		description: 'Make the open planner page(s) select a guide (and a line or step) and frame it on the map. Returns { pages } (how many pages were told).',
		input: { type: 'object', required: ['id'], properties: { id: GUIDE_ID, line: LINE, step: { type: 'integer', minimum: 0, description: '0-based step index.' } }, additionalProperties: false },
		mutates: false,
		handler: (ws, a, ctx) => {
			ws.source(a.id);
			ws.emit('focus', a);
			return { pages: ctx.clients() };
		},
	},
	{
		name: 'view_seek',
		description: 'Move the open page\'s playback to time t (seconds from the route\'s start). Returns { pages }.',
		input: { type: 'object', required: ['t'], properties: { t: { type: 'number', minimum: 0 } }, additionalProperties: false },
		mutates: false,
		handler: (ws, a, ctx) => {
			ws.emit('seek', a);
			return { pages: ctx.clients() };
		},
	},
	{
		name: 'view_play',
		description: 'Start or pause the open page\'s playback; speed is the time multiplier (1-256). Returns { pages }.',
		input: { type: 'object', required: ['playing'], properties: { playing: { type: 'boolean' }, speed: { type: 'number', minimum: 1 } }, additionalProperties: false },
		mutates: false,
		handler: (ws, a, ctx) => {
			ws.emit('play', a);
			return { pages: ctx.clients() };
		},
	},
];

const BY_NAME = new Map(COMMANDS.map((c) => [c.name, c]));

// [{ name, description, input, mutates }] for /api/commands, MCP and WebMCP.
function describe() {
	return COMMANDS.map(({ name, description, input, mutates }) => ({ name, description, input, mutates }));
}

function command(name) {
	const c = BY_NAME.get(name);
	if (!c) throw new PlannerError(`unknown command "${name}"`, 'not_found');
	return c;
}

async function run(ws, name, args = {}, ctx = { clients: () => 0 }) {
	const c = command(name);
	const a = args === null || args === undefined ? {} : args;
	check(c.input, a, 'args');
	return c.handler(ws, a, ctx);
}

module.exports = { COMMANDS, describe, command, run };
