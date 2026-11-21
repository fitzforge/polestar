'use strict';
// The guide simulator: a pack's guides played to the end in the
// real engine, against the stub world of tests/lua/stub_world.lua, once per
// class each guide branches on plus one class it never names, as every race
// that can reach it. At each step the simulated player completes the first
// open goal the way a player would (accept, kill, loot, walk there, talk,
// train, bind, level up...). Used by `polestar playtest` and
// tests/guides.test.js (every one of our guides), and by the tests that play
// one guide (buildSimPack, playGuide, SIMULATE). A guide starts with the
// prerequisites of its accepts that the guides chaining into it turn in
// already done, and those they leave for it to turn in in the log
// (chainDone), as for a player arriving on the route.
//
//   const { results, diag } = await playtest({ dir, manifest, official, filter, classes });
//   // results: [{ guide, race, faction, cls, ok, stuck: { step, title, reason, handOver? } | null, problems, landed }]
//
// Another pack is compiled with our guides as context and played with ours
// loaded as well: a guide whose `next` offers one of ours must land on one
// of its options (`landed`, the guide the engine opened) that applies to the
// character's race, class and faction, with something to do.
//
//   const pack = buildSimPack(['forever/professions/mining.guide']);  // ours, compiled + written to a temp dir
//   const [out] = playGuide(pack, guide, { race: 'Orc', faction: 'Horde', cls: 'WARRIOR' });
//   pack.dispose();
//
// SIMULATE plays the active guide and emits { done, stuck, visited, steps,
// missing, wrongPick, level }: `missing` lists accept/turn-in goals without a
// location, `wrongPick` candidate goals that picked an NPC the character may
// not use. playGuide runs one persona (`stubs`, `before` and `script` add to
// the run: `script` replaces SIMULATE when given, after SetGuide). luaValue(v)
// renders a JSON value as a Lua literal.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { runAddon, tocEntries } = require('../../tests/helpers/lua');
const { LuaPool } = require('./luapool');
const { OFFICIAL_DIR, findGuideFiles, compileSources, buildPackFiles, writePackDir } = require('./dsl/project');
const { DATA } = require('./paths');
const { RACE_BY_FILE } = require('./game/races');
const { buildPack } = require('./pack/build');
const { readManifest } = require('./pack/manifest');
const { loadData } = require('./dsl/data');
const { Diagnostics } = require('./dsl/diag');
const { honestPlay, guideFits, loadKb } = require('./playtest-honest');
const { personaVariants, personaTables, updatePoints, snapshotLines, SNAPSHOT_LUA } = require('./playtest-personas');
const { levelOffsetLua } = require('./playtest-level');

const CLASSES = ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK', 'DRUID'];

function luaValue(v) {
	if (v === null || v === undefined) return 'nil';
	if (typeof v === 'number' || typeof v === 'boolean') return String(v);
	if (typeof v === 'string') return JSON.stringify(v);
	if (Array.isArray(v)) return `{ ${v.map(luaValue).join(', ')} }`;
	return `{ ${Object.entries(v).map(([k, x]) => `[${/^\d+$/.test(k) ? k : JSON.stringify(k)}] = ${luaValue(x)}`).join(', ')} }`;
}

// Where each race starts (Era frame): the client's playercreateinfo spawn
// (Undead: the Deathknell crypt by Undertaker Mordo, world 1676.7, 1678.3;
// Human -8950, -132.5; Dwarf and Gnome -6240.3, 331; Night Elf 10311.3,
// 832.5; Orc and Troll -618.5, -4251.7; Tauren -2917.6, -258), in map percent.
// Non-leveling guides begin there instead of at their first waypoint, the way
// a player opens them, and the planner's playback starts a level 1 route there.
const HOME = {
	Human: [1429, 48.06, 43.65], Dwarf: [1426, 29.87, 71.98], Gnome: [1426, 29.87, 71.98], NightElf: [1438, 58.57, 44.79],
	Orc: [1411, 43.29, 68.85], Troll: [1411, 43.29, 68.85], Tauren: [1412, 44.88, 77.22], Scourge: [1420, 29.99, 71.73],
	// Zephras Isle has no Era frame: live coordinates (the world's start, 4089.6, 1849.4)
	Skyborne: [2521, 42.82, 23.37],
};

// Build compiled guides into `root/<folder>` -> { dir, files, scripts }:
// scripts are the files its TOC loads, absolute, in load order, then each race
// part's (every race: the sim registers them all, the engine applies each
// guide's races).
function writePackInto(root, { guides, manifest, data }) {
	const dir = path.join(root, manifest.folder);
	const files = buildPackFiles({ guides, manifest, data });
	writePackDir(dir, files);
	const parts = Object.keys(files)
		.filter((name) => name.startsWith('../') && name.endsWith('/Guides.lua'))
		.sort()
		.map((name) => path.join(dir, name));
	return { dir, files, scripts: [...tocEntries(dir).map((f) => path.join(dir, f)), ...parts] };
}

// The stub world's maps (w.addMap) from the reference data: Era frames where
// a map has one (goals there are written in Era coordinates); Forever-only
// maps such as Zephras Isle use their Forever frame.
function mapsLua(data) {
	const frames = { ...(data.mapFrames.forever || {}), ...(data.mapFrames.era || {}) };
	return Object.entries(frames)
		.map(([id, f]) => `w.addMap(${id}, { name = ${JSON.stringify((data.zones[id] && data.zones[id].name) || '')}, c = ${f.c}, left = ${f.left}, right = ${f.right}, top = ${f.top}, bottom = ${f.bottom} })`)
		.join('\n');
}

// SIM_WORK: per quest of the packs' guides, the objectives a hand-in cannot
// take on its own (kill, talk, object, event lines of the quest data), as
// { i = line, t = kind, id, map, x, y }. A quest's item lines stay out: an
// item may come before the accept, from a reward or a vendor, which the stub
// bags do not follow. The simulated player finishes these lines only through
// a goal that works them, or at the hand-in when the line is its ender
// (speak with, or click, the one who takes it in) or an event at the ender's
// spot; the game refuses any other hand-in (SIMULATE).
function workLua(list, data) {
	const qs = new Set();
	for (const { guides } of list) for (const g of guides) for (const s of g.steps || []) for (const x of s.goals) if (x.t === 'accept' && x.quest != null) qs.add(x.quest);
	const rows = [];
	for (const q of [...qs].sort((a, b) => a - b)) {
		const quest = data.quests[q];
		const lines = ((quest && quest.objectives) || [])
			.map((o, i) => ({ o, i: i + 1 }))
			.filter(({ o }) => o.type === 'kill' || o.type === 'talk' || o.type === 'object' || o.type === 'event')
			.map(({ o, i }) => `{ i = ${i}, t = ${JSON.stringify(o.type)}, id = ${o.id == null ? 'nil' : o.id}, n = ${o.count || 1}, map = ${o.map == null ? 'nil' : o.map}, x = ${o.x == null ? 'nil' : o.x}, y = ${o.y == null ? 'nil' : o.y} }`);
		if (lines.length) rows.push(`[${q}] = { ${lines.join(', ')} }`);
	}
	return `SIM_WORK = { ${rows.join(',\n')} }`;
}

// Each file runs the way the client runs it: with the addon name and a namespace.
const loadPack = (folder, scripts) =>
	['do local ns = {}', ...scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))(${JSON.stringify(folder)}, ns)`), 'end'].join('\n');

// Write packs ([{ guides, manifest }]) into one temp folder, in load order
// -> { loads, maps, dir, dispose }.
function simPacks(list, data) {
	const root = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-sim-'));
	const loads = list.map(({ guides, manifest }) => loadPack(manifest.folder, writePackInto(root, { guides, manifest, data }).scripts)).join('\n');
	return { loads, maps: mapsLua(data), work: workLua(list, data), dir: root, dispose: () => fs.rmSync(root, { recursive: true, force: true }) };
}

// Compile guide files of ours (relative to guides/, or { file, text }) with
// the reference data and write our pack -> { guides, diag, loads, maps, dir, dispose }.
function buildSimPack(files, data) {
	data = data || loadData(DATA);
	const sources = files.map((f) =>
		typeof f === 'string' ? { file: path.join('guides', f), source: f, text: fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8') } : { file: f.file, source: f.file, text: f.text },
	);
	const { guides, diag } = compileSources(sources, data);
	const { manifest } = readManifest(OFFICIAL_DIR, { official: true });
	return { guides, diag, ...simPacks([{ guides, manifest }], data) };
}

// Plays guide `g` from `pack` as one persona; returns runAddon's emitted values.
// With `handOver` (the guide ids g's `next` offers), the engine moves on by
// itself when g ends (behavior.guideEnd "continue", the recommended route) and a second
// value says where it landed: { guide, registered: [bool per id], step, open }.
// `groups`: the answer at every group quest (`when group`), "skip" (the solo
// route) or "do", as behavior.groupQuests sets it in game; never "ask", which
// would hold the play at the first one.
function playGuide(pack, g, opts) {
	return runAddon(playOptions(pack, g, opts)).emitted;
}

// The same play on a LuaPool (tools/lib/luapool.js) -> a promise of the emitted values.
async function playGuideIn(pool, pack, g, opts) {
	return (await pool.runAddon(playOptions(pack, g, opts))).emitted;
}

// runAddon's options for a play (playGuide).
function playOptions(pack, g, { race, faction, cls, stubs = [], before = '', script = null, handOver = null, groups = 'skip', dungeonMaps = [], saved = null, openStartGates = false }) {
	const raceName = race === 'Scourge' ? 'Undead' : race;
	const first = g.steps.flatMap((s) => s.goals).find((x) => x.map && x.x != null);
	const home = g.category && g.category !== 'Leveling' ? HOME[race] : null;
	const start = home ? { map: home[0], x: home[1], y: home[2] } : first;
	return {
		stubs: ['stub_world.lua', ...stubs],
		before: `
			local w = stub.world
			${pack.maps}
			${pack.work || ''}
			w.race, w.raceName = ${JSON.stringify(race)}, ${JSON.stringify(raceName)}
			w.class, w.className = ${JSON.stringify(cls)}, ${JSON.stringify(cls)}
			w.faction = ${JSON.stringify(faction)}
			w.level = ${g.minLevel || 1}
			${start ? `w.moveTo(${start.map}, ${start.x}, ${start.y}${start.z != null ? `, ${start.z}` : ''})` : ''}
			${before}`,
		addons: ['Polestar'],
		...(saved ? { saved: { Polestar: saved } } : {}),
		script: `
			${pack.loads}
			stub.login()
			stub.fire("QUEST_LOG_UPDATE") -- the client fills the quest log right after login
			Polestar.Set("behavior.guideEnd", ${handOver ? '"continue"' : '"ask"'})
			Polestar.Set("behavior.groupQuests", ${luaValue(groups)})
			Polestar.Set("behavior.dungeons", "skip") -- the solo route, whatever "Dungeons in my route" defaults to; --dungeon chooses below
			-- The arrow's journey off (a player's "travel planner off"): the simulated player is set down at each
			-- goal, never riding the journey's boats or portals, in a world without walking maps or floors, so a
			-- live route would still be on its first leg at the goal. Journey prices (Nav.EstimateTravel, which
			-- ns.TravelCost and route choices weigh) do not need it.
			Polestar.Set("nav.travel", false)
			${dungeonMaps.map((m) => `Polestar.Engine.ChooseDungeon(${Number(m)}, true)`).join('\n')}
			${handOver ? 'Polestar.Set("behavior.routeChoice", "recommended")' : ''}
			Polestar.Engine.SetGuide(${luaValue(g.id)})
			SIM_GUIDE = Polestar.Engine.GetGuide() -- a hand-over may replace it before SIMULATE starts
			stub.advance(0.6)
			${openStartGates && g.category === 'Class' ? `local openingGuide = ${luaValue(g.id)}\n${OPEN_START_GATES}` : ''}
			${script == null ? SIMULATE : script}
			${handOver ? handOverCheck(handOver, g.id) : ''}`,
	};
}

// A class guide can open on a notice instead of its steps. Exercise it as an
// eligible character, but never supply a quest the guide itself must work.
const OPEN_START_GATES = `
local E, w = Polestar.Engine, stub.world
local openedStartGates = {}
while SIM_GUIDE and SIM_GUIDE.id == openingGuide and E.GetGuide() == SIM_GUIDE do
	local gate = E.StartGate(SIM_GUIDE.id)
	if not gate then break end
	if gate.level and w.level < gate.level then
		local before = w.level
		w.setLevel(gate.level)
		if w.level <= before then break end
		openedStartGates[#openedStartGates+1] = "level " .. w.level .. " reached outside the guide"
	elseif gate.pre and not w.completed[gate.pre] then
		local inGuide = false
		for _, step in ipairs(SIM_GUIDE.steps) do
			for _, goal in ipairs(step.goals) do
				if goal.quest == gate.pre then inGuide = true; break end
			end
			if inGuide then break end
		end
		if inGuide then break end
		w.turnIn(gate.pre)
		openedStartGates[#openedStartGates+1] = ("quest %d (%s) completed outside the guide"):format(gate.pre, gate.preTitle)
	else
		break
	end
	stub.advance(0.6)
end`;

// Where the engine landed after a guide handed over to one of `ids`: which
// guide is open, whether each of ids is registered and offered when the
// guide ends (an option with `when` only while it holds), whether its
// current step holds a goal still to do, and `misfit`: false when the open
// guide applies to the character (the runtime's rule, Guides.GuideMatches),
// else the condition that leaves it out ("faction", "race" or "class").
function handOverCheck(ids, from) {
	return `do
	local E, G = Polestar.Engine, Polestar.Guides
	local H = E.GetGuide()
	local i = H and E.GetStepIndex()
	local open = false
	if i then
		for _, g in ipairs(E.GetStepView(i).goals) do
			if g.status ~= "done" and g.status ~= "na" then open = true; break end
		end
	end
	local misfit = false
	if H and not G.GuideMatches(H, Polestar.Compat.GetPlayerInfo()) then
		local P = Polestar.Compat.GetPlayerInfo()
		if H.faction and P.faction and H.faction:lower() ~= P.faction:lower() then misfit = "faction"
		elseif not G.ListMatches(H.races, P.race, G.NormRace) then misfit = "race"
		else misfit = "class" end
	end
	local registered, offered = {}, {}
	for k, id in ipairs(${luaValue(ids)}) do
		registered[k] = G.Get(id) ~= nil
		offered[k] = E.RouteOffered(${luaValue(from)}, id)
	end
	emit({ guide = H and H.id or false, registered = registered, offered = offered, step = i or false, open = open, misfit = misfit })
end`;
}

// The classes `race` can be on `faction` (races.json, from the client's
// CharBaseInfo): none for a race or side the table does not list, so only
// pairs that exist are played; every class only when the data has no table.
function playableClasses(data, race, faction) {
	if (!data.races || !Object.keys(data.races).length) return CLASSES;
	const sides = data.races[race];
	const side = sides && sides[faction];
	return side ? side.classes : [];
}

function namedClasses(guide) {
	const named = new Set((guide.classes || []).map((c) => String(c).toUpperCase()));
	const visit = (cond) => {
		for (const c of (cond && cond.classes) || []) named.add(String(c).toUpperCase());
	};
	for (const s of guide.steps) {
		visit(s.only);
		for (const g of s.goals) visit(g.only);
	}
	return named;
}

// Classes named by the `class` header or any `only` in the guide (or chain) that the
// race can be, plus one playable class it never names. A guide
// limited by its `class` header is played only as those classes, each of
// them. `only` (class files) replaces that choice with the given classes the
// race can be.
function classesFor(data, guide, race, faction, only = null, named = namedClasses(guide)) {
	let can = playableClasses(data, race, faction);
	if (guide.classes && guide.classes.length) {
		const allowed = guide.classes.map((c) => String(c).toUpperCase());
		can = can.filter((c) => allowed.includes(c));
	}
	if (only) return can.filter((c) => only.includes(c));
	const plain = can.find((c) => !named.has(c));
	return [...[...named].filter((c) => can.includes(c)), ...(plain ? [plain] : [])];
}

// The one side a race file is played on; null for Skyborne (both) or an unknown race.
function sideOf(race) {
	const sides = Object.keys((RACE_BY_FILE[race] || {}).sides || {});
	return sides.length === 1 ? sides[0] : null;
}

// Races the guide can be played as: those it names (header or any `only`)
// and those arriving from a previous guide (any route option: an Undead may
// pick the Barrens, a Human Darkshore), limited to its own faction and race
// list, plus a default race for each faction it allows that no named race
// covers. Faction follows the race.
function personasFor(guide, arriving = []) {
	const named = new Set(guide.races || []);
	const visit = (only) => {
		for (const r of (only && only.races) || []) named.add(r);
	};
	for (const s of guide.steps) {
		visit(s.only);
		for (const g of s.goals) visit(g.only);
	}
	for (const r of arriving) named.add(r);
	let races = [...named].map((r) => (r === 'Undead' ? 'Scourge' : r));
	races = [...new Set(races)].filter((r) => !guide.faction || !sideOf(r) || sideOf(r) === guide.faction);
	if (guide.races && guide.races.length) races = races.filter((r) => guide.races.map((x) => (x === 'Undead' ? 'Scourge' : x)).includes(r));
	for (const side of guide.faction ? [guide.faction] : ['Alliance', 'Horde']) {
		if (!races.some((r) => (sideOf(r) || side) === side)) races.push(side === 'Horde' ? 'Orc' : 'Human');
	}
	// A guide open to both factions (professions, reputation...) is also played
	// from the other home continent of each side, so "nearest" picks are tested
	// from Tirisfal and Teldrassil as well as Durotar and Elwynn.
	if (!guide.faction && !(guide.races && guide.races.length)) {
		for (const r of ['Scourge', 'NightElf']) if (!races.includes(r)) races.push(r);
	}
	return races.map((race) => ({ race, faction: sideOf(race) || guide.faction || 'Alliance' }));
}

// A persona for each class the guide (or chain) names (its `class` header or any `only`)
// that none of `personas` can be: the first race in races.json on the guide's
// side (its race list, if it has one) that can be it, so an `only Druid` step
// in a Horde guide is played as a Tauren rather than skipped.
function classPersonas(data, guide, personas, named = namedClasses(guide), admits = () => true) {
	if (!data.races || !Object.keys(data.races).length) return [];
	const allowed = guide.races && guide.races.length ? guide.races.map((x) => (x === 'Undead' ? 'Scourge' : x)) : null;
	const sides = guide.faction ? [guide.faction] : ['Alliance', 'Horde'];
	const added = [];
	for (const cls of named) {
		const all = [...personas, ...added];
		if (all.some(({ race, faction }) => playableClasses(data, race, faction).includes(cls) && admits({ race, faction, cls }))) continue;
		for (const [race, bySide] of Object.entries(data.races)) {
			if (allowed && !allowed.includes(race)) continue;
			const faction = sides.find((s) => bySide[s] && bySide[s].classes.includes(cls) && admits({ race, faction: s, cls }));
			if (faction) {
				added.push({ race, faction });
				break;
			}
		}
	}
	return added;
}

// The guide id of a .guide text (its `guide` line) and its `next` ids: every `next` line (a guide both
// factions play names each side's next guide on its own line), each without its `when` predicate.
function headerLinks(text) {
	const id = (text.match(/^guide\s+(\S+)/m) || [])[1];
	const next = [...text.matchAll(/^next\s+(.+)$/gm)].flatMap((m) => m[1].split(/\s+when\s/)[0].split(/[\s,]+/)).filter(Boolean);
	return { id, next };
}

// Every one of `all` (paths relative to dir) connected to a target through
// `next` (before or after it, any route option), the targets included,
// sorted: compiled together, turn-ins of quests picked up earlier in the
// chain validate and `next` resolves.
function withChain(dir, all, targets) {
	const idOf = new Map();
	const fileOf = new Map(); // id -> file
	const nextOf = new Map(); // file -> next ids (every route option)
	const intoId = new Map(); // next id -> files whose `next` names it
	for (const rel of all) {
		const { id, next } = headerLinks(fs.readFileSync(path.join(dir, rel), 'utf8'));
		idOf.set(rel, id);
		fileOf.set(id, rel);
		nextOf.set(rel, next);
		for (const n of next) intoId.set(n, [...(intoId.get(n) || []), rel]);
	}
	const set = new Set(targets);
	const queue = [...targets];
	while (queue.length) {
		const rel = queue.pop();
		const linked = [...(intoId.get(idOf.get(rel)) || [])];
		for (const n of nextOf.get(rel) || []) if (fileOf.has(n)) linked.push(fileOf.get(n));
		for (const other of linked) {
			if (!set.has(other)) {
				set.add(other);
				queue.push(other);
			}
		}
	}
	return [...set].sort();
}

// A file matches `filter` when its path or its guide id contains it, or,
// for a function, when filter(rel) says so.
function matches(dir, rel, filter) {
	if (!filter) return true;
	if (typeof filter === 'function') return filter(rel);
	if (rel.includes(filter)) return true;
	const { id } = headerLinks(fs.readFileSync(path.join(dir, rel), 'utf8'));
	return !!id && id.includes(filter);
}

// What went wrong in one play, as { stuck, problems }. `hand` (playGuide's
// second value) is where a hand-over to one of `handOver` (the `next`
// options) landed; any option counts (the engine picks the recommended one)
// when it applies to `persona` ({ race, faction, cls }). An option with
// `when` that does not hold at the end (hand.offered) is no hand-over; with
// none offered the guide ends there.
function outcome(out, handOver = null, hand = null, persona = null) {
	let stuck = null;
	const offered = handOver && hand && hand.offered ? handOver.filter((_, k) => hand.offered[k] !== false) : handOver;
	if (!out.done) {
		const s = out.stuck || {};
		const reason = s.why || (s.goal ? `goal ${s.goal} (${s.t}${s.text ? ` "${s.text}"` : ''}) stays ${s.status}` : 'the guide stopped before its end');
		stuck = { step: s.step != null ? s.step : null, title: s.title != null ? s.title : null, reason };
	} else if (handOver && hand && (offered.length || handOver.includes(hand.guide))) {
		const one = handOver.length === 1;
		let reason = null;
		let to = handOver.join(' or ');
		if (!handOver.includes(hand.guide)) {
			const registered = (hand.registered || []).some(Boolean);
			reason = registered ? `Polestar did not open ${one ? 'it' : 'any of them'}${hand.guide ? ` (${hand.guide} stayed open)` : ''}` : one ? 'it is not registered' : 'none of them is registered';
		} else if (hand.misfit) {
			// The engine opened a guide whose race, class or faction leaves this character out.
			to = hand.guide;
			const who = !persona ? 'such character' : hand.misfit === 'race' ? raceName(persona.race) : hand.misfit === 'class' ? titleCase(persona.cls) : `${persona.faction} character`;
			reason = `no ${who} can follow it`;
		} else if (!hand.step) reason = `${hand.guide} has no step for this character`;
		else if (!hand.open) reason = `${hand.guide} step ${hand.step} has nothing to do for this character`;
		if (reason) stuck = { step: null, title: null, handOver: to, reason };
	}
	const problems = [...Object.values(out.missing || {}).map((m) => `no location for ${m}`), ...Object.values(out.wrongPick || {})];
	return { stuck, problems };
}

// Whether an `only` ({ classes, races, factions }, "!x" excludes) lets the
// persona ({ race, faction, cls }) in: Guides.Matches.
function onlyFits(only, { race, faction, cls }) {
	const norm = (s) => String(s).toLowerCase().replace(/\s+/g, '').replace(/^undead$/, 'scourge');
	const fits = (list, value) => {
		if (!Array.isArray(list) || !list.length) return true;
		let positives = false;
		let hit = false;
		for (const raw of list) {
			const neg = String(raw).startsWith('!');
			const e = norm(neg ? String(raw).slice(1) : raw);
			if (neg && e === norm(value)) return false;
			if (!neg) {
				positives = true;
				if (e === norm(value)) hit = true;
			}
		}
		return hit || !positives;
	};
	return !only || (fits(only.classes, cls) && fits(only.races, race) && fits(only.factions, faction));
}

// A step's `when group` predicates with every group quest answered `groups`
// ("do" or "skip"); its other predicates are left to the play.
function groupsFit(when, groups) {
	return !(when || []).some((p) => p.k === 'group' && (groups === 'do') === !!p.neg);
}

// The dungeons a playtest player chose (`--dungeon`, as Options' "Dungeons in
// leveling guides" sets them): null or [] none (the solo route), "all", or a
// list of map ids and names ("36", "Wailing Caverns", "The Deadmines").
// -> chosen(p) for a compiled `when dungeon` predicate.
function dungeonPicker(dungeons) {
	if (dungeons === 'all') return () => true;
	const norm = (s) => String(s).trim().toLowerCase().replace(/^the\s+/, '');
	const set = new Set([].concat(dungeons || []).map(norm));
	return (p) => (p.map != null && set.has(String(p.map))) || (p.name != null && set.has(norm(p.name)));
}

// A step's `when dungeon` predicates with the dungeons `chosen` picks.
function dungeonsFit(when, chosen) {
	return !(when || []).some((p) => p.k === 'dungeon' && chosen(p) === !!p.neg);
}

// The map ids of every dungeon `chosen` picks among the guides' `when dungeon` predicates.
function dungeonMapsOf(guides, chosen) {
	const maps = new Set();
	for (const g of guides) for (const s of g.steps || []) for (const p of s.when || []) if (p.k === 'dungeon' && p.map != null && chosen(p)) maps.add(Number(p.map));
	return [...maps].sort((a, b) => a - b);
}

// The prerequisites (`pre`, `preAll`) of g's accepts that a player arriving
// on the route brings, as { done, carried, open }: `done`, those the guides
// chaining into g (through `next`, any route option, any number of guides
// back) turn in for the persona; `carried`, those they accept and leave for
// g only to hand in (no other goal of it in g): in the log, ready, on
// arrival; `open`, those they accept and leave for g to work and hand in (an
// objective goal of it in g, no accept): in the log with its objectives to do.
// The engine passes by an accept whose prerequisite is missing (issue #70).
function chainDone(guides, g, persona, groups = 'skip', chosen = dungeonPicker(null)) {
	const into = new Map();
	for (const from of guides) {
		for (const to of from.nextChoices || (from.next ? [from.next] : [])) into.set(to, [...(into.get(to) || []), from]);
	}
	const turned = new Set();
	const accepted = new Set();
	const seen = new Set([g.id]);
	const queue = [...(into.get(g.id) || [])];
	while (queue.length) {
		const from = queue.pop();
		if (seen.has(from.id)) continue;
		seen.add(from.id);
		for (const s of from.steps) {
			if (!onlyFits(s.only, persona) || !groupsFit(s.when, groups) || !dungeonsFit(s.when, chosen)) continue;
			for (const x of s.goals) {
				if (!x.quest || !onlyFits(x.only, persona)) continue;
				if (x.t === 'turnin') turned.add(x.quest);
				if (x.t === 'accept') accepted.add(x.quest);
			}
		}
		queue.push(...(into.get(from.id) || []));
	}
	// Quests g only hands in: a turn-in and no other goal of the quest; quests g accepts.
	const handIn = new Map();
	const acceptsHere = new Set();
	for (const s of g.steps) {
		for (const x of s.goals) {
			if (!x.quest) continue;
			handIn.set(x.quest, (handIn.get(x.quest) !== false) && x.t === 'turnin');
			if (x.t === 'accept') acceptsHere.add(x.quest);
		}
	}
	const done = new Set();
	const carried = new Set();
	const open = new Set();
	// A guide no other leads into whose step waits on a quest another guide hands in (`when turnedin`: The Eye of
	// Bhossca, a class guide of its own, after The Horn of Xelthos's 78307) is played as by a character who did that
	// guide: the quest is done.
	const elsewhere = (q) => !into.has(g.id) && !handIn.has(q) && guides.some((o) => o.id !== g.id && o.steps.some((s) => s.goals.some((x) => x.t === 'turnin' && x.quest === q)));
	for (const s of g.steps) {
		for (const p of s.when || []) if (p.k === 'turnedin' && !p.neg) for (const q of [].concat(p.q)) if (turned.has(q) || elsewhere(q)) done.add(q);
		for (const x of s.goals) {
			if (x.t !== 'accept') continue;
			for (const p of [...(x.pre || []), ...(x.preAll || [])]) {
				if (turned.has(p)) done.add(p);
				else if (accepted.has(p) && handIn.get(p)) carried.add(p);
				else if (accepted.has(p) && handIn.has(p) && !acceptsHere.has(p)) open.add(p);
			}
		}
	}
	const sorted = (set) => [...set].sort((a, b) => a - b);
	return { done: sorted(done), carried: sorted(carried), open: sorted(open) };
}

// The objectives g's goals count for quest q, as stub_world's onQuest takes
// them: the largest count per objective number (1 without one).
function objectivesIn(g, q) {
	const req = [];
	for (const s of g.steps) {
		for (const x of s.goals) if (x.quest === q && x.oi) req[x.oi - 1] = Math.max(req[x.oi - 1] || 1, x.count || 1);
	}
	return Array.from(req, (n) => n || 1);
}

// Reference data from `dir` for playtest; missing core files are an error in
// diag (a search over no data would only look like a broken guide).
function playData(dir, diag) {
	const data = loadData(dir);
	if (data.missingCore.length) diag.error(dir, 0, `reference data missing ${data.missingCore.join(', ')}: run forge data build (or pass --data / --context-data)`);
	return data;
}

// Compile the pack in `dir` (ours when `official`) and play its guides whose
// file or id contains `filter` (or that filter(rel) keeps), as every persona and class (`classes`: class
// files to play instead of the guide's own choice). Our guides play with the
// rest of their `next` chain compiled with them; another pack is built as
// compile builds it (tools/lib/pack/build.js buildPack, our guides in
// contextDir as context, read with contextDataDir's data) and plays with ours
// loaded: a guide whose `next` offers one of ours checks the engine lands on
// one of its options with something to do.
// -> { results, diag, played, dataMissing }: no results when the pack has
// errors; missing reference data (dataMissing) is the only error then
// (nothing is compiled without it).
// Plays run on a pool of `workers` long-lived Lua processes (LuaPool; each
// play in a fresh environment, so the results are a separate process's);
// onResult gets them in play order as they come in.
// `learn` (profession names): the player chose these professions, so the
// simulator takes the guide's optional `train` of each like any goal and then
// plays the steps behind `when skill` they open (on its own it takes no
// optional goal, so it never learns a profession).
// `levelOffset` (a whole number): the player is that many levels ahead of the
// guide's level (tools/lib/playtest-level.js).
async function playtest({ dir, manifest, official = false, filter = null, classes = null, groups = 'skip', dungeons = null, dataDir = DATA, data = null, contextDir = OFFICIAL_DIR, contextDataDir = DATA, onResult = null, workers = null, honest = false, kb = undefined, learn = null, levelOffset = 0, openStartGates = false }) {
	// Validate before loading data. The pool starts processes only when a play is queued.
	const pool = honest ? null : new LuaPool({ size: workers ?? (process.env.POLESTAR_PLAY_WORKERS === undefined ? undefined : Number(process.env.POLESTAR_PLAY_WORKERS)) });
	const dataDiag = new Diagnostics();
	data = data || playData(dataDir, dataDiag);
	const contextData = official ? null : contextDataDir && path.resolve(contextDataDir) !== path.resolve(dataDir) ? playData(contextDataDir, dataDiag) : data;
	if (dataDiag.hasErrors()) return { results: [], diag: dataDiag, played: 0, dataMissing: true };
	const skillLines = [];
	for (const name of learn || []) {
		const prof = data.professionNamed(name);
		if (!prof) dataDiag.error('--learn', 0, `profession "${name}" is not in the reference data (professions.json)`);
		else skillLines.push(prof.id);
	}
	if (dataDiag.hasErrors()) return { results: [], diag: dataDiag, played: 0 };
	const learnt = skillLines.length ? [`PLAYTEST_LEARN = ${luaValue(Object.fromEntries(skillLines.map((id) => [id, true])))}`] : [];
	let guides;
	let diag;
	let packs;
	let play;
	let ourIds = new Set();
	if (official) {
		const all = findGuideFiles(dir);
		const wanted = all.filter((f) => matches(dir, f, filter));
		play = new Set(wanted);
		const sources = withChain(dir, all, wanted).map((f) => ({ file: path.join(path.relative(process.cwd(), dir) || '.', f), source: f, text: fs.readFileSync(path.join(dir, f), 'utf8') }));
		({ guides, diag } = compileSources(sources, data));
		packs = [{ guides, manifest }];
	} else {
		({ guides, diag } = buildPack({ dir, manifest, diags: [], contextDir, contextDataDir }, { dataDir, cache: { data, contextData }, files: false }));
		play = new Set(findGuideFiles(dir).filter((f) => matches(dir, f, filter)));
		const ourSources = findGuideFiles(contextDir).map((f) => ({ file: path.join(contextDir, f), source: f, text: fs.readFileSync(path.join(contextDir, f), 'utf8') }));
		const ours = compileSources(ourSources, contextData, new Diagnostics()).guides;
		ourIds = new Set(ours.map((g) => g.id));
		const { manifest: ourManifest } = readManifest(OFFICIAL_DIR, { official: true });
		packs = [
			{ guides: ours, manifest: ourManifest },
			{ guides, manifest },
		];
	}
	const results = [];
	if (diag.hasErrors()) return { results, diag, played: 0 };
	const chosen = dungeonPicker(dungeons);
	if (honest) return honestRun({ guides, packs, play, data, classes, groups, chosen, kb, diag });
	const packIds = new Set(guides.map((g) => g.id));
	// Every compiled guide, for the chains into each one (chainDone).
	const chained = packs.flatMap((p) => p.guides);
	const dungeonMaps = dungeonMapsOf(chained, chosen);
	const sim = simPacks(packs, data);
	const pending = [];
	let shown = 0;
	const flush = () => {
		while (shown < results.length && results[shown]) {
			if (onResult) onResult(results[shown]);
			shown++;
		}
	};
	try {
		// Races that reach each guide from a previous one, through any route option.
		const arriving = new Map();
		for (const g of guides) {
			for (const to of g.nextChoices || (g.next ? [g.next] : [])) arriving.set(to, [...(arriving.get(to) || []), ...(g.races || [])]);
		}
		let played = 0;
		for (const g of guides) {
			if (!play.has(g._ast && g._ast.source)) continue;
			played++;
			// Every `next` option: the engine takes the recommended one, ours or the pack's.
			const options = g.nextChoices && g.nextChoices.length ? g.nextChoices : g.next ? [g.next] : [];
			const handOver = options.some((id) => ourIds.has(id) && !packIds.has(id)) ? options : null;
			let personas = personasFor(g, arriving.get(g.id));
			personas = [...personas, ...classPersonas(data, g, personas)];
			for (const { race, faction } of personas) {
				for (const cls of classesFor(data, g, race, faction, classes)) {
					const pre = chainDone(chained, g, { race, faction, cls }, groups, chosen);
					const before = levelOffsetLua(levelOffset) + [
						pre.done.length ? `w.complete(${luaValue(pre.done)})` : '',
						...pre.carried.map((q) => `w.onQuest(${q}, {})`),
						...pre.open.map((q) => `w.onQuest(${q}, ${luaValue(objectivesIn(g, q))})`),
						...learnt,
					].join('\n');
					const k = results.length;
					results.push(null);
					pending.push(playGuideIn(pool, sim, g, { race, faction, cls, handOver, before, groups, dungeonMaps, openStartGates }).then(([out, hand]) => {
						const { stuck, problems } = outcome(out, handOver, hand, { race, faction, cls });
						results[k] = { guide: g.id, race, faction, cls, ok: !stuck && !problems.length, stuck, problems, landed: hand ? hand.guide || null : null };
						if (out.startGates) results[k].startGates = out.startGates;
						flush();
					}));
				}
			}
		}
		await Promise.all(pending);
		return { results, diag, played };
	} finally {
		pool.close();
		sim.dispose();
	}
}

// A guide's steps as the Engine tells a changed guide from a kept one: each
// step's goals by verb and what they name.
const shapeOf = (g) => g.steps.map((s) => s.goals.map((x) => `${x.t}:${x.quest ?? x.npc ?? x.item ?? x.object ?? x.spell ?? ''}`).join(',')).join('|');

// playtest --persona (tools/lib/playtest-personas.js): our guides whose file
// or id contains `filter`, each played as one race and class (its first
// persona and class, as the plain playtest picks them) by the imperfect
// players `personas` names, every variant of each a play of its own. First a
// baseline play per guide (the persona's world, nothing taken away): a guide
// stuck there is reported once as `baseline` and its variants are not
// played. `from`: { dir, version } of the last release's guides, for the
// update persona (its leveling guides changed since, played to each of
// `points` steps on that release's pack, then on this one from the save).
// -> { results: [{ guide, persona, variant, race, faction, cls, stuck }], diag, played }
async function personaPlaytest({ dir = OFFICIAL_DIR, manifest, personas, filter = null, classes = null, sample = 8, points = 3, from = null, dataDir = DATA, data = null, onResult = null, workers = null, openStartGates = false, onStartGate = null }) {
	const diag = new Diagnostics();
	data = data || playData(dataDir, diag);
	if (diag.hasErrors()) return { results: [], diag, played: 0, dataMissing: true };
	const all = findGuideFiles(dir);
	const wanted = all.filter((f) => matches(dir, f, filter));
	const sources = withChain(dir, all, wanted).map((f) => ({ file: path.join(path.relative(process.cwd(), dir) || '.', f), source: f, text: fs.readFileSync(path.join(dir, f), 'utf8') }));
	const compiled = compileSources(sources, data);
	if (compiled.diag.hasErrors()) return { results: [], diag: compiled.diag, played: 0 };
	const guides = compiled.guides;
	const play = new Set(wanted);
	let old = null;
	if (personas.includes('update')) {
		if (!from) {
			diag.error('--from', 0, 'the update persona needs the last release\'s guides (--from <dir>)');
			return { results: [], diag, played: 0 };
		}
		const oldFiles = findGuideFiles(from.dir);
		const oldSources = oldFiles.map((f) => ({ file: path.join(from.dir, f), source: f, text: fs.readFileSync(path.join(from.dir, f), 'utf8') }));
		// The old guides compile against today's data: their errors are not this play's (diagnostics dropped).
		old = compileSources(oldSources, data, new Diagnostics()).guides;
	}
	const pool = new LuaPool({ size: workers ?? (process.env.POLESTAR_PLAY_WORKERS === undefined ? undefined : Number(process.env.POLESTAR_PLAY_WORKERS)) });
	const sim = simPacks([{ guides, manifest }], data);
	// The Engine maps a save onto changed guides only when its pack version differs from the save's (Own.updated);
	// a tree not yet bumped for its release (next before the release commit) still carries the last release's, so
	// its old pack is told apart, as every real update is.
	const oldVersion = from && from.version === manifest.version ? `${from.version}-before` : from && from.version;
	const oldSim = old ? simPacks([{ guides: old, manifest: { ...manifest, version: oldVersion } }], data) : null;
	const oldById = new Map((old || []).map((g) => [g.id, g]));
	const results = [];
	const arriving = new Map();
	for (const g of guides) for (const to of g.nextChoices || (g.next ? [g.next] : [])) arriving.set(to, [...(arriving.get(to) || []), ...(g.races || [])]);
	const stuckOf = (out) => (out ? outcome(out).stuck : { step: null, title: null, reason: 'the play ended without a result' });
	const lua = (persona) => `PERSONA = ${luaValue(persona)}\n${SIMULATE}`;
	// A quest the guides before took and worked, left only to hand in: in the log with each line of the data
	// done (the plain play gives it none; a guide that works it again, as an updated one may, finds them done).
	const carriedLua = (q) => {
		const lines = data.questObjectives(q).map((o) => ({ required: o.count || 1, fulfilled: o.count || 1, type: o.kind === 'item' ? 'item' : o.kind === 'object' ? 'object' : o.kind === 'event' ? 'event' : 'monster' }));
		return `w.onQuest(${q}, ${luaValue(lines)})`;
	};
	let played = 0;
	try {
		const jobs = [];
		for (const g of guides) {
			if (!play.has(g._ast && g._ast.source)) continue;
			played++;
			let list = personasFor(g, arriving.get(g.id));
			list = [...list, ...classPersonas(data, g, list)];
			const who = list.flatMap(({ race, faction }) => classesFor(data, g, race, faction, classes).map((cls) => ({ race, faction, cls })))[0];
			if (!who) continue;
			const pre = chainDone(guides, g, who);
			const before = [pre.done.length ? `w.complete(${luaValue(pre.done)})` : '', ...pre.carried.map(carriedLua), ...pre.open.map((q) => `w.onQuest(${q}, ${luaValue(objectivesIn(g, q))})`)].join('\n');
			const tables = personaTables(g, data);
			const base = { needs: tables.needs, gives: tables.gives, rewards: tables.rewards, restock: tables.restock };
			// All persona sessions use the same opening policy, including the
			// successful baseline (not a counted variant) and both sides of an update.
			const playSession = async (pack, guide, persona, variant, options) => {
				const emitted = await playGuideIn(pool, pack, guide, { ...who, openStartGates, ...options });
				if (onStartGate) {
					for (const gate of emitted.at(-1)?.startGates || []) onStartGate({ guide: guide.id, ...who, persona, variant }, gate);
				}
				return emitted;
			};
			const record = (persona, variant, stuck) => {
				const r = { guide: g.id, persona, variant, ...who, stuck };
				results.push(r);
				if (onResult) onResult(r);
			};
			jobs.push(
				(async () => {
					const [out] = await playSession(sim, g, 'baseline', 'nothing taken away', { before, script: lua(base) });
					const baseline = stuckOf(out);
					if (baseline) {
						record('baseline', 'nothing taken away', baseline);
						return;
					}
					const plays = [];
					for (const persona of personas.filter((p) => p !== 'update' && p !== 'fresh')) {
						for (const v of personaVariants(persona, g, data, sample)) {
							plays.push(playSession(sim, g, persona, v.variant, { before: `${before}\n${v.before}`, script: lua(v.persona) }).then(([o]) => record(persona, v.variant, stuckOf(o))));
						}
					}
					// fresh: a character who opens a guide some route leads into with none of the earlier guides' quests
					// done or carried. (A guide no route leads into keeps what it waits on from elsewhere: chainDone.)
					if (personas.includes('fresh') && arriving.has(g.id) && before.trim()) {
						const variant = 'opened the guide with nothing from the guides before it';
						plays.push(playSession(sim, g, 'fresh', variant, { script: lua(base) }).then(([o]) => record('fresh', variant, stuckOf(o))));
					}
					const was = oldById.get(g.id);
					if (personas.includes('update') && was && (g.category == null || g.category === 'Leveling') && shapeOf(was) !== shapeOf(g)) {
						const oldPre = chainDone(old, was, who);
						const oldBefore = [oldPre.done.length ? `w.complete(${luaValue(oldPre.done)})` : '', ...oldPre.carried.map(carriedLua), ...oldPre.open.map((q) => `w.onQuest(${q}, ${luaValue(objectivesIn(was, q))})`)].join('\n');
						const snapLines = snapshotLines(data, [was, g]);
						for (const k of updatePoints(was, points)) {
							const variant = `updated from ${from.version} at its step ${k} "${was.steps[k - 1].title || ''}"`;
							plays.push(
								playSession(oldSim, was, 'update', `before update: ${variant}`, { before: oldBefore, script: `${snapLines}\n${SNAPSHOT_LUA}\n${lua({ snapshots: [k] })}` }).then(async (emitted) => {
									const snap = emitted.find((e) => e && e.snapshot);
									if (!snap) return;
									// Where the save opened the updated guide: emitted first, the play's result after it.
									const [at, o] = await playSession(sim, g, 'update', variant, { before: snap.world, saved: snap.save, script: `stub.advance(11)\nemit({ at = Polestar.Engine.GetStepIndex() or false })\n${lua(base)}` });
									record('update', `${variant}, reopened at step ${at && at.at ? at.at : 'none'}`, stuckOf(o));
								}),
							);
						}
					}
					await Promise.all(plays);
				})(),
			);
		}
		await Promise.all(jobs);
		return { results, diag: compiled.diag, played };
	} finally {
		pool.close();
		sim.dispose();
		if (oldSim) oldSim.dispose();
	}
}

// playtest --honest (tools/lib/playtest-honest.js): the compiled guides
// played from their lines and the data only, each `next` chain whole from
// its first guide, sampling classes named throughout the chain while keeping
// that first guide's race, faction and class eligibility;
// findings for the guides of `play` (sources). No Lua. `kb`: the knowledge
// base file (default data/local/kb/forever-kb.sqlite when present; null: none).
// -> { results: [], findings, diag, played, plays, honest: true }
function honestRun({ guides, packs, play, data, classes, groups, chosen, kb, diag }) {
	if (kb != null && !fs.existsSync(kb)) {
		diag.error(kb, 0, 'knowledge base not found');
		return { results: [], findings: [], diag, played: 0, plays: 0, honest: true };
	}
	const all = packs.flatMap((p) => p.guides);
	const wanted = guides.filter((g) => play.has(g._ast && g._ast.source));
	const selected = new Set(wanted.map((g) => g.id));
	const arriving = new Map();
	for (const g of all) {
		for (const to of g.nextChoices || (g.next ? [g.next] : [])) arriving.set(to, [...(arriving.get(to) || []), ...(g.races || [])]);
	}
	let plays = 0;
	const personas = (root, chain) => {
		const named = new Set(chain.flatMap((g) => [...namedClasses(g)]));
		let list = personasFor(root, arriving.get(root.id));
		// Later race headers need their own candidates. A dual-faction race can
		// play either side, but every candidate must still fit the chain root.
		for (const name of new Set(chain.flatMap((g) => g.races || []))) {
			const race = name === 'Undead' ? 'Scourge' : name;
			for (const faction of root.faction ? [root.faction] : ['Alliance', 'Horde']) {
				if (sideOf(race) && sideOf(race) !== faction) continue;
				if (!list.some((p) => p.race === race && p.faction === faction)) list.push({ race, faction });
			}
		}
		list = list.filter((p) => guideFits({ races: root.races, faction: root.faction }, p));
		for (const guide of chain) {
			list = [...list, ...classPersonas(data, root, list, classes || named, (p) => guideFits(root, p) && guideFits(guide, p))];
		}
		const characters = list.flatMap(({ race, faction }) => classesFor(data, root, race, faction, classes, named).map((cls) => ({ race, faction, cls })))
			.filter((p) => chain.some((g) => selected.has(g.id) && guideFits(g, p)));
		// A compatible context guide does not count as playing the selection.
		plays += characters.length;
		return characters;
	};
	const findings = honestPlay(all, data, personas, { kb: kb === undefined ? loadKb() : kb ? loadKb(kb) : null, play: wanted.map((g) => g.id), groups, chosen });
	return { results: [], findings, diag, played: wanted.length, plays, honest: true };
}

const titleCase = (s) => s.charAt(0) + s.slice(1).toLowerCase();
const RACE_NAMES = { Scourge: 'Undead', NightElf: 'Night Elf' };
const raceName = (r) => RACE_NAMES[r] || r;

// "ok  mini/a (Human Warrior)"; "stuck mini/a (Orc Warrior) at step 2
// "Kobolds": goal 1 (kill) stays active".
function resultLines(r) {
	const who = `${raceName(r.race)} ${titleCase(r.cls)}`;
	const lines = (r.startGates || []).map((gate) => `${r.guide} (${who}): start gate opened: ${gate}`);
	if (r.ok) return [...lines, `ok  ${r.guide} (${who})`];
	if (r.stuck && r.stuck.handOver) lines.push(`stuck ${r.guide} (${who}) at hand-over to ${r.stuck.handOver}: ${r.stuck.reason}`);
	else if (r.stuck) lines.push(`stuck ${r.guide} (${who})${r.stuck.step != null ? ` at step ${r.stuck.step}` : ''}${r.stuck.title != null ? ` "${r.stuck.title}"` : ''}: ${r.stuck.reason}`);
	for (const p of r.problems) lines.push(`fail ${r.guide} (${who}): ${p}`);
	return lines;
}

const SIMULATE = `
local E, w = Polestar.Engine, stub.world
-- SIM_GUIDE (playGuide): the guide that was set, which the engine may already
-- have left for the next one; else the open guide.
local G = SIM_GUIDE or E.GetGuide()
-- PERSONA (playtest --persona, tools/lib/playtest-personas.js): an imperfect
-- player; nil for the perfect follower, which none of this touches. The world
-- holds back only what the persona went without: an item in \`lack\` (skipped,
-- lost, or long used up) that the bags do not hold again. A direct hand-in or
-- an item-started accept (\`needs\`) is refused without its items, and a
-- \`collect\` of an item only quests hand over (\`gives\`) finds nothing while
-- each of those quests is blocked: done before this play, or a direct hand-in
-- refused for its own items (the Applejack Still without apples).
local P = PERSONA
local lack, doneHere = {}, {}
if P then
	for _, it in ipairs(P.lack or {}) do lack[it] = true; w.removeItem(it) end
end
local function short(need)
	for item, n in pairs(need or {}) do
		if lack[item] and (w.items[item] or 0) < n then return true end
	end
	return false
end
local function blocked(q)
	if w.completed[q] and not doneHere[q] then return true end
	return P.needs ~= nil and P.needs[q] ~= nil and short(P.needs[q])
end
local function withheld(t, r)
	if not P then return false end
	if (t == "turnin" and r.direct) or t == "accept" then
		return P.needs ~= nil and short(P.needs[r.quest])
	end
	if (t == "collect" or t == "buy") and r.item and not r.quest and P.gives and P.gives[r.item] then
		for _, q in ipairs(P.gives[r.item]) do
			if not blocked(q) then return false end
		end
		return true
	end
	return false
end
-- Each line gets the type of the first goal pointing at it. Index item
-- objectives by quest and line: all the open requests see the same bags.
local objs, kinds, items = {}, {}, {}
local KIND = { kill = "monster", collect = "item", interact = "object", talk = "monster" }
for _, s in ipairs(G.steps) do
	for _, g in ipairs(s.goals) do
		if g.quest and g.oi then
			objs[g.quest] = objs[g.quest] or {}
			objs[g.quest][g.oi] = math.max(objs[g.quest][g.oi] or 1, g.count or 1)
			kinds[g.quest] = kinds[g.quest] or {}
			kinds[g.quest][g.oi] = kinds[g.quest][g.oi] or KIND[g.t]
			if g.t == "collect" and g.item and kinds[g.quest][g.oi] == "item" then
				items[g.quest] = items[g.quest] or {}
				items[g.quest][g.oi] = g.item
			end
		end
	end
end
-- A quest's lines: those the guide's goals point at, and its kill, talk,
-- object and event lines from the data (SIM_WORK), which only their goals
-- finish: the game takes no hand-in with one open (act's turnin).
local WORK_KIND = { kill = "monster", talk = "monster", object = "object", event = "event" }
local function workLines(q)
	local out = {}
	for _, l in ipairs(SIM_WORK and SIM_WORK[q] or {}) do out[l.i] = l end
	return out
end
local function objectivesFor(q)
	local list, o, n, work = {}, objs[q] or {}, 0, workLines(q)
	for i in pairs(o) do if i > n then n = i end end
	for i in pairs(work) do if i > n then n = i end end
	for i = 1, n do
		local l = work[i]
		list[i] = { required = math.max(o[i] or 1, l and l.n or 1), type = (kinds[q] and kinds[q][i]) or (l and WORK_KIND[l.t]) or "event" }
	end
	return list
end
local function syncItems(q, entry, item)
	for i, id in pairs(items[q] or {}) do
		local o = entry.objectives[i]
		if (not item or item == id) and o then
			local n = math.min(w.items[id] or 0, o.numRequired)
			if n ~= o.numFulfilled then w.progress(q, i, n) end
		end
	end
end
local function changeStack(item, delta)
	if delta ~= 0 then w.addItem(item, delta) end
	for q, entry in pairs(w.log) do syncItems(q, entry, item) end
end
-- Quests taken in this play (carried ones were worked before it), and the
-- hand-ins the game refused, with the lines left open.
local taken, refused = {}, {}
-- Whether data line l is done by the hand-in goal r itself: speaking with or
-- clicking its ender, or an event at the ender's spot.
local function atEnder(l, r)
	if (l.t == "kill" or l.t == "talk") then return l.id ~= nil and l.id == r.npc end
	if l.t == "object" then return l.id ~= nil and l.id == r.object end
	return l.t == "event" and l.map ~= nil and l.map == r.map and r.x ~= nil and math.abs(l.x - r.x) < 0.6 and math.abs(l.y - r.y) < 0.6
end
-- An unbound kill, talk or interact at a line's target counts for every quest
-- taken in this play that asks for it.
local function creditTarget(r)
	for q, entry in pairs(w.log) do
		if taken[q] then
			for i, l in pairs(workLines(q)) do
				local hit = l.id ~= nil and (((l.t == "kill" or l.t == "talk") and l.id == r.npc) or (l.t == "object" and l.id == r.object))
				local o = entry.objectives[i]
				if hit and o and not o.finished then w.progress(q, i, o.numRequired) end
			end
		end
	end
end
local function ensureSkill(r, line)
	if not w.skills[line] then w.learnSkill(line, r.skill or tostring(line), 1, 300) end
end
-- A goal with candidates must have picked one the character may use: the
-- player's faction (or both) and, when listed, race and class. NPC candidates
-- are matched by npc; farm spots (no npc) by the chosen position.
local wrongPick = {}
local function checkPick(i, g, r)
	if not r.candidates then return end
	local tag = w.faction == "Horde" and "H" or "A"
	local function bad(why) wrongPick[#wrongPick + 1] = ("step %d goal %d (%s): %s"):format(i, g.index, r.t, why) end
	if not (g.npc or g.map) then return bad("no usable candidate for " .. w.faction) end
	local function picked(c)
		if c.npc then return c.npc == g.npc end
		return c.map == g.map and c.x == g.x and c.y == g.y
	end
	for _, c in ipairs(r.candidates) do
		if picked(c) then
			if not (c.faction or "AH"):find(tag, 1, true) then
				bad(("picked %s (%s) for %s"):format(tostring(c.npcName), tostring(c.faction), w.faction))
			end
			return
		end
	end
	bad(("picked %s, which is not a candidate"):format(g.npc and ("npc " .. g.npc) or (tostring(g.map) .. " " .. tostring(g.x) .. "," .. tostring(g.y))))
end
-- PERSONA restock: a step that leads to a source of an item its own hand-in
-- or accept takes gives it back there (the player kills, clicks or asks again).
local function restocked(i, r)
	local list = P and P.restock and P.restock[i]
	local need = P and P.needs and r.quest and P.needs[r.quest]
	if not (list and need) then return false end
	for _, item in ipairs(list) do
		local n = need[item]
		if n and lack[item] and (w.items[item] or 0) < n then w.addItem(item, n - (w.items[item] or 0)) end
	end
	return not short(need)
end
-- PERSONA lose: the step where the bags got the item to lose; it goes once the
-- route leaves that step (the loop below).
local armed
local function act(i, g, r)
	local t, q = g.t, g.quest
	if withheld(t, r) and not restocked(i, r) then
		stub.advance(0.6)
		return
	end
	if not q and (t == "kill" or t == "talk" or t == "interact") then creditTarget(r) end
	if t == "accept" then
		if not w.log[q] and not w.completed[q] then
			w.accept(q, objectivesFor(q), g.subject)
			syncItems(q, w.log[q])
			taken[q] = true
		end
	elseif t == "turnin" then
		local entry = w.log[q]
		if entry then
			-- Lines the data has that no goal of the play worked hold the hand-in;
			-- the rest (item lines the bags may hold, lines of carried quests,
			-- the ender's own) are done here, as before. A persona's play works
			-- them too: what the quest log shows the player can always do (the
			-- perfect follower's play is the one that checks the guide works them).
			local work, open = taken[q] and not P and workLines(q) or {}, {}
			for oi, o in ipairs(entry.objectives) do
				if not o.finished then
					local l = work[oi]
					if l and not atEnder(l, r) then
						open[#open + 1] = ("%d (%s%s)"):format(oi, l.t, l.id and (" " .. l.id) or "")
					else
						w.progress(q, oi, o.numRequired)
					end
				end
			end
			if #open > 0 then
				refused[q] = table.concat(open, ", ")
				return
			end
		end
		doneHere[q] = true
		w.turnIn(q)
		if entry then
			for i, item in pairs(items[q] or {}) do
				local o = entry.objectives[i]
				if o then changeStack(item, -math.min(w.items[item] or 0, o.numRequired)) end
			end
		end
	elseif t == "complete" then
		if w.log[q] then w.finish(q) end
	elseif t == "abandon" then
		if w.log[q] then w.abandon(q) end
	elseif t == "destroy" then
		if g.item then w.removeItem(g.item) end
	elseif t == "deposit" then
		-- Into the bank: what the goal counts, else all the bags hold.
		if r.count and (w.items[r.item] or 0) < r.count then w.addItem(r.item, r.count - (w.items[r.item] or 0)) end
		w.deposit(r.item)
	elseif t == "equip" then
		w.equip(r.item, not r.off)
	elseif t == "collect" and r.item and q and g.oi and items[q] and items[q][g.oi] == r.item then
		local target = g.progress and g.progress.max or r.count or 1
		changeStack(r.item, math.max(0, target - (w.items[r.item] or 0)))
	elseif q and g.oi and (t == "kill" or t == "collect" or t == "use" or t == "interact" or t == "talk") then
		if w.log[q] then
			local o = w.log[q].objectives[g.oi]
			if o then w.progress(q, g.oi, o.numRequired) else w.finish(q) end
		end
	elseif q and (t == "kill" or t == "collect" or t == "use" or t == "interact" or t == "talk") then
		if w.log[q] then w.finish(q) end
	-- An auction goal: bought at the Auction House, a bag count as a buy is.
	elseif (t == "collect" or t == "buy" or t == "auction") and g.item then
		changeStack(g.item, math.max(0, ((g.progress and g.progress.max) or r.count or 1) - (w.items[g.item] or 0)))
		if P and P.lose == g.item then armed = i end
	elseif t == "goto" then
		w.moveTo(g.map, g.x, g.y, g.z)
	elseif t == "talk" then
		w.gossip(g.npc); w.close()
	elseif t == "train" then
		if r.skillLine and r.rank then
			-- A profession rank: the trainer raises the skill's cap.
			local cap = r.rankMax or ({ 75, 150, 225, 300 })[r.rank]
			local s = w.skills[r.skillLine]
			if s then
				w.skillUp(r.skillLine, s.rank, math.max(cap, s.maxRank or 0))
			else
				w.learnSkill(r.skillLine, r.skill or tostring(r.skillLine), 1, cap)
			end
		end
		w.trainer(g.npc or 1); w.close()
	elseif t == "vendor" then
		w.merchant(g.npc or 1); w.close()
	elseif t == "sethome" then
		w.bind(g.subject or g.npcName or "Inn")
	elseif t == "hearth" or t == "fly" or t == "enter" then
		w.setZone(g.subject, g.subject)
	elseif t == "die" then
		-- A deathskip: back alive beside the graveyard's Spirit Healer.
		w.moveTo(g.map, g.x, g.y, g.z)
		stub.fire("PLAYER_UNGHOST")
	elseif t == "level" then
		w.setLevel(math.max(w.level, tonumber((g.subject or ""):match("%d+")) or (w.level + 1)))
		-- A point inside the level ("level 12.5"): that share of its XP.
		local want = r and r.frac and w.level == r.level and math.ceil(r.frac * w.xpMax)
		if want and w.xp < want then w.setXP(want) end
	elseif t == "money" then
		if w.money < (r.money or 0) then w.setMoney(r.money) end
	elseif t == "skill" then
		local line = r.skillLine or r.skill
		ensureSkill(r, line)
		w.skillUp(line, r.level, math.max(r.level, w.skills[line].maxRank or 0))
	elseif t == "cast" then
		w.cast(r.spell)
	elseif t == "learn" then
		w.learnSpell(r.spell)
		w.learnRecipe(r.spell)
	elseif t == "craft" then
		if r.untilSkill then
			local line = r.skillLine or r.skill
			ensureSkill(r, line)
			w.skillUp(line, r.untilSkill, math.max(r.untilSkill, w.skills[line].maxRank or 0))
		elseif r.item then
			w.addItem(r.item, r.count or 1)
		end
	elseif t == "rep" then
		-- Points inside the standing (a rep goal with +points): that far along its bar.
		local points = r.points or 0
		w.setRep(r.faction, r.factionName or tostring(r.faction), r.standing, points, 0, math.max(3000, points))
	elseif t == "buff" then
		-- The aura on the player, or gone for a goal with off.
		w.setAura(r.spell, not r.off)
	elseif t == "explore" then
		local id = 900000 + i * 100 + g.index
		w.addArea(r.map, r.x - 1, r.y - 1, r.x + 1, r.y + 1, id)
		w.moveTo(r.map, r.x, r.y, r.z)
		w.explore(id)
		-- An explore tied to a quest is its find (an event line).
		if q and w.log[q] then
			local o = r.oi and w.log[q].objectives[r.oi]
			if o then w.progress(q, r.oi, o.numRequired) else w.finish(q) end
		end
	elseif t == "achieve" then
		local a = w.achievements[r.achievement]
		if not a then
			w.addAchievement(r.achievement, r.achievementName, { { "criterion", 1 } })
			a = w.achievements[r.achievement]
		end
		for ci, c in ipairs(a.criteria) do
			if not r.criteria or r.criteria == ci then w.criteria(r.achievement, ci, c.max) end
		end
	end
	-- A carried item this accept or hand-in puts in the bags (PERSONA rewards).
	if P and P.rewards and q and P.rewards[q] and (t == "accept" or t == "turnin") then
		for _, it in ipairs(P.rewards[q]) do
			w.addItem(it, 1)
			if P.lose == it then armed = i end
		end
	end
	stub.advance(0.6)
end
local visited, stuck, guard = {}, nil, 0
-- The engine may move on to the next guide (a hand-over) during any advance:
-- from then on nothing here may read or act on G's steps.
local function left() return E.GetGuide() ~= G end
-- PLAYTEST_LEARN (playtest --learn): the professions the player chose, by skill
-- line. An optional \`train\` of one of them is taken, once, the way a player who
-- chose it would; every other optional goal is left alone.
local trained = {}
local function chosenTrain(i, view)
	if not PLAYTEST_LEARN then return nil end
	for _, g in ipairs(view.goals) do
		local r = g.t == "train" and g.optional and g.status ~= "done" and not trained[i .. ":" .. g.index] and G.steps[i].goals[g.index]
		if r and r.skillLine and PLAYTEST_LEARN[r.skillLine] then return g end
	end
	return nil
end
-- PERSONA skip: the step skipped once (the window's Skip), going without what
-- its collects, buys and crafts would have put in the bags. PERSONA snapshots
-- (the update persona's first play): SNAPSHOT(k) runs once the route reaches
-- step k, for each k in order; the play ends after the last.
local skippedOnce, lostDone, snap = false, false, 1
while guard < 4000 do
	guard = guard + 1
	if armed and not lostDone and E.GetStepIndex() ~= armed then
		lostDone = true
		w.removeItem(P.lose)
		lack[P.lose] = true
		stub.advance(0.6)
	end
	local i = E.GetStepIndex()
	if not i or left() then break end
	if P and P.snapshots then
		while P.snapshots[snap] and i >= P.snapshots[snap] do
			SNAPSHOT(P.snapshots[snap])
			snap = snap + 1
		end
		if not P.snapshots[snap] then break end
	end
	visited[i] = true
	local view = E.GetStepView(i)
	local skipNow = P and P.skip == i and not skippedOnce
	-- A goal waiting for a level (an accept above the character's level, and
	-- its work with it): the simulated player gains no XP, so it reaches that
	-- level here, as a player has by then; the guide brings the quest back.
	local need = 0
	for _, g in ipairs(view.goals) do
		if g.unavailable == "level" then need = math.max(need, tonumber((g.unavailableText or ""):match("(%d+)")) or w.level + 1) end
		-- An accept waiting for a level is hidden from the view (status "na"), its level in waitsLevel.
		if g.waitsLevel then need = math.max(need, g.waitsLevel) end
	end
	local open
	-- A vendor check-off beside other work (g.side) is left alone, as by a
	-- player with nothing to sell: it must never hold the step.
	for _, g in ipairs(view.goals) do
		if g.status ~= "done" and g.status ~= "na" and g.status ~= "skipped" and not g.optional and not g.side and g.t ~= "note" then open = g; break end
	end
	-- A chosen profession's train is taken first, while its step is current: a
	-- step passed with its \`when\` failing keeps that outcome, so a profession
	-- learnt after the route left the step would not bring its steps back.
	local learn = chosenTrain(i, view)
	if skipNow then
		skippedOnce = true
		for _, x in ipairs(G.steps[i].goals) do
			if (x.t == "collect" or x.t == "buy" or x.t == "craft") and x.item and not x.quest then lack[x.item] = true end
			for _, it in ipairs(x.quest and P.rewards and P.rewards[x.quest] or {}) do lack[it] = true end
		end
		E.Skip()
		stub.advance(0.6)
		if left() then break end
	elseif learn then
		trained[i .. ":" .. learn.index] = true
		act(i, learn, G.steps[i].goals[learn.index])
		stub.advance(0.6)
		if left() then break end
	elseif need > w.level then
		w.setLevel(need)
		stub.advance(0.6)
		if left() then break end
	elseif not open then
		stub.advance(0.6)
		if left() then break end
		if E.GetStepIndex() == i then stuck = { step = i, title = view.title, why = "no open goal but the step did not advance" }; break end
	else
		checkPick(i, open, G.steps[i].goals[open.index])
		act(i, open, G.steps[i].goals[open.index])
		if left() then break end
		local after = E.GetStepView(i)
		local same = E.GetStepIndex() == i and after.goals[open.index].status ~= "done"
		if same and open.manual then
			E.ToggleGoal(i, open.index)
			stub.advance(0.6)
			if left() then break end
			same = E.GetStepIndex() == i and E.GetStepView(i).goals[open.index].status ~= "done"
		end
		if same then
			local quest = G.steps[i].goals[open.index].quest
			local why = open.t == "turnin" and quest and refused[quest]
			stuck = { step = i, title = view.title, goal = open.index, t = open.t, text = open.text, status = after.goals[open.index].status,
				why = why and ("the game takes no hand-in of quest %d: line %s, which no goal of the guide works, is not done"):format(quest, why) or nil }
			break
		end
	end
end
local missing = {}
for si, s in ipairs(G.steps) do
	for gi, g in ipairs(s.goals) do
		if (g.t == "accept" and not g.item or g.t == "turnin") and not (g.map and g.x and g.y) then
			missing[#missing + 1] = ("step %d goal %d: %s %s"):format(si, gi, g.t, tostring(g.title or g.quest))
		end
	end
end
local count = 0
for _ in pairs(visited) do count = count + 1 end
emit({ done = E.GetStepIndex() == nil or E.GetGuide() ~= G, stuck = stuck, visited = count, steps = #G.steps, missing = missing, wrongPick = wrongPick, level = w.level, startGates = openedStartGates and #openedStartGates > 0 and openedStartGates or nil })
`;

module.exports = { playtest, personaPlaytest, withChain, resultLines, buildSimPack, playGuide, playGuideIn, playOptions, writePackInto, chainDone, dungeonPicker, SIMULATE, HOME, CLASSES, luaValue };
