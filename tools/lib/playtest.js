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
//   const { results, diag } = playtest({ dir, manifest, official, filter, classes });
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
const { OFFICIAL_DIR, findGuideFiles, compileSources, buildPackFiles, writePackDir } = require('./dsl/project');
const { DATA } = require('./paths');
const { RACE_BY_FILE } = require('./game/races');
const { buildPack } = require('./pack/build');
const { readManifest } = require('./pack/manifest');
const { loadData } = require('./dsl/data');
const { Diagnostics } = require('./dsl/diag');

const CLASSES = ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK', 'DRUID'];

function luaValue(v) {
	if (v === null || v === undefined) return 'nil';
	if (typeof v === 'number' || typeof v === 'boolean') return String(v);
	if (typeof v === 'string') return JSON.stringify(v);
	if (Array.isArray(v)) return `{ ${v.map(luaValue).join(', ')} }`;
	return `{ ${Object.entries(v).map(([k, x]) => `[${/^\d+$/.test(k) ? k : JSON.stringify(k)}] = ${luaValue(x)}`).join(', ')} }`;
}

// Where each race starts (Era frame): non-leveling guides begin there instead
// of at their first waypoint, the way a player opens them.
const HOME = {
	Human: [1429, 48.2, 42.0], Dwarf: [1426, 29.9, 71.2], Gnome: [1426, 29.9, 71.2], NightElf: [1438, 58.6, 44.4],
	Orc: [1411, 43.3, 68.5], Troll: [1411, 43.3, 68.5], Tauren: [1412, 44.2, 76.1], Scourge: [1420, 32.5, 63.2],
	Skyborne: [2521, 42.8, 23.4], // Zephras Isle has no Era frame: live coordinates
};

// Build compiled guides into `root/<folder>` -> { dir, files, scripts }:
// scripts are the files its TOC loads, absolute, in load order.
function writePackInto(root, { guides, manifest, data }) {
	const dir = path.join(root, manifest.folder);
	const files = buildPackFiles({ guides, manifest, data });
	writePackDir(dir, files);
	return { dir, files, scripts: tocEntries(dir).map((f) => path.join(dir, f)) };
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

// Each file runs the way the client runs it: with the addon name and a namespace.
const loadPack = (folder, scripts) =>
	['do local ns = {}', ...scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))(${JSON.stringify(folder)}, ns)`), 'end'].join('\n');

// Write packs ([{ guides, manifest }]) into one temp folder, in load order
// -> { loads, maps, dir, dispose }.
function simPacks(list, data) {
	const root = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-sim-'));
	const loads = list.map(({ guides, manifest }) => loadPack(manifest.folder, writePackInto(root, { guides, manifest, data }).scripts)).join('\n');
	return { loads, maps: mapsLua(data), dir: root, dispose: () => fs.rmSync(root, { recursive: true, force: true }) };
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
// itself when g ends (autoNextGuide, the recommended route) and a second
// value says where it landed: { guide, registered: [bool per id], step, open }.
// `groups`: the answer at every group quest (`when group`), "skip" (the solo
// route) or "do", as behavior.groupQuests sets it in game; never "ask", which
// would hold the play at the first one.
function playGuide(pack, g, { race, faction, cls, stubs = [], before = '', script = null, handOver = null, groups = 'skip' }) {
	const raceName = race === 'Scourge' ? 'Undead' : race;
	const first = g.steps.flatMap((s) => s.goals).find((x) => x.map && x.x != null);
	const home = g.category && g.category !== 'Leveling' ? HOME[race] : null;
	const start = home ? { map: home[0], x: home[1], y: home[2] } : first;
	return runAddon({
		stubs: ['stub_world.lua', ...stubs],
		before: `
			local w = stub.world
			${pack.maps}
			w.race, w.raceName = ${JSON.stringify(race)}, ${JSON.stringify(raceName)}
			w.class, w.className = ${JSON.stringify(cls)}, ${JSON.stringify(cls)}
			w.faction = ${JSON.stringify(faction)}
			w.level = ${g.minLevel || 1}
			${start ? `w.moveTo(${start.map}, ${start.x}, ${start.y})` : ''}
			${before}`,
		addons: ['Polestar'],
		script: `
			${pack.loads}
			stub.login()
			stub.fire("QUEST_LOG_UPDATE") -- the client fills the quest log right after login
			Polestar.Set("behavior.autoNextGuide", ${handOver ? 'true' : 'false'})
			Polestar.Set("behavior.groupQuests", ${luaValue(groups)})
			${handOver ? 'Polestar.Set("behavior.routeChoice", "recommended")' : ''}
			Polestar.Engine.SetGuide(${luaValue(g.id)})
			SIM_GUIDE = Polestar.Engine.GetGuide() -- a hand-over may replace it before SIMULATE starts
			stub.advance(0.6)
			${script == null ? SIMULATE : script}
			${handOver ? handOverCheck(handOver, g.id) : ''}`,
	}).emitted;
}

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

// Classes named by the `class` header or any `only` in the guide that the
// race can be, plus one playable class the guide never names. A guide
// limited by its `class` header is played only as those classes, each of
// them. `only` (class files) replaces that choice with the given classes the
// race can be.
function classesFor(data, guide, race, faction, only = null) {
	let can = playableClasses(data, race, faction);
	if (guide.classes && guide.classes.length) {
		const allowed = guide.classes.map((c) => String(c).toUpperCase());
		can = can.filter((c) => allowed.includes(c));
	}
	if (only) return can.filter((c) => only.includes(c));
	const named = new Set((guide.classes || []).map((c) => String(c).toUpperCase()));
	const visit = (cond) => {
		for (const c of (cond && cond.classes) || []) named.add(String(c).toUpperCase());
	};
	for (const s of guide.steps) {
		visit(s.only);
		for (const g of s.goals) visit(g.only);
	}
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

// A persona for each class the guide names (its `class` header or any `only`)
// that none of `personas` can be: the first race in races.json on the guide's
// side (its race list, if it has one) that can be it, so an `only Druid` step
// in a Horde guide is played as a Tauren rather than skipped.
function classPersonas(data, guide, personas) {
	if (!data.races || !Object.keys(data.races).length) return [];
	const named = new Set((guide.classes || []).map((c) => String(c).toUpperCase()));
	const visit = (cond) => {
		for (const c of (cond && cond.classes) || []) named.add(String(c).toUpperCase());
	};
	for (const s of guide.steps) {
		visit(s.only);
		for (const g of s.goals) visit(g.only);
	}
	const allowed = guide.races && guide.races.length ? guide.races.map((x) => (x === 'Undead' ? 'Scourge' : x)) : null;
	const sides = guide.faction ? [guide.faction] : ['Alliance', 'Horde'];
	const added = [];
	for (const cls of named) {
		const all = [...personas, ...added];
		if (all.some(({ race, faction }) => playableClasses(data, race, faction).includes(cls))) continue;
		for (const [race, bySide] of Object.entries(data.races)) {
			if (allowed && !allowed.includes(race)) continue;
			const faction = sides.find((s) => bySide[s] && bySide[s].classes.includes(cls));
			if (faction) {
				added.push({ race, faction });
				break;
			}
		}
	}
	return added;
}

// The guide id of a .guide text (its `guide` line) and its `next` ids.
function headerLinks(text) {
	const id = (text.match(/^guide\s+(\S+)/m) || [])[1];
	const next = ((text.match(/^next\s+(.+)$/m) || [])[1] || '').split(/[\s,]+/).filter(Boolean);
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

// A file matches `filter` when its path or its guide id contains it.
function matches(dir, rel, filter) {
	if (!filter) return true;
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

// The prerequisites (`pre`, `preAll`) of g's accepts that a player arriving
// on the route brings, as { done, carried }: `done`, those the guides
// chaining into g (through `next`, any route option, any number of guides
// back) turn in for the persona; `carried`, those they accept and leave for
// g only to hand in (no other goal of it in g): in the log, ready, on
// arrival. The engine passes by an accept whose prerequisite is missing
// (issue #70).
// A step's `when group` predicates with every group quest answered `groups`
// ("do" or "skip"); its other predicates are left to the play.
function groupsFit(when, groups) {
	return !(when || []).some((p) => p.k === 'group' && (groups === 'do') === !!p.neg);
}

function chainDone(guides, g, persona, groups = 'skip') {
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
			if (!onlyFits(s.only, persona) || !groupsFit(s.when, groups)) continue;
			for (const x of s.goals) {
				if (!x.quest || !onlyFits(x.only, persona)) continue;
				if (x.t === 'turnin') turned.add(x.quest);
				if (x.t === 'accept') accepted.add(x.quest);
			}
		}
		queue.push(...(into.get(from.id) || []));
	}
	// Quests g only hands in: a turn-in and no other goal of the quest.
	const handIn = new Map();
	for (const s of g.steps) {
		for (const x of s.goals) if (x.quest) handIn.set(x.quest, (handIn.get(x.quest) !== false) && x.t === 'turnin');
	}
	const done = new Set();
	const carried = new Set();
	for (const s of g.steps) {
		for (const x of s.goals) {
			if (x.t !== 'accept') continue;
			for (const p of [...(x.pre || []), ...(x.preAll || [])]) {
				if (turned.has(p)) done.add(p);
				else if (accepted.has(p) && handIn.get(p)) carried.add(p);
			}
		}
	}
	const sorted = (set) => [...set].sort((a, b) => a - b);
	return { done: sorted(done), carried: sorted(carried) };
}

// Reference data from `dir` for playtest; missing core files are an error in
// diag (a search over no data would only look like a broken guide).
function playData(dir, diag) {
	const data = loadData(dir);
	if (data.missingCore.length) diag.error(dir, 0, `reference data missing ${data.missingCore.join(', ')}: run node tools/polestar.js data build (or pass --data / --context-data)`);
	return data;
}

// Compile the pack in `dir` (ours when `official`) and play its guides whose
// file or id contains `filter`, as every persona and class (`classes`: class
// files to play instead of the guide's own choice). Our guides play with the
// rest of their `next` chain compiled with them; another pack is built as
// compile builds it (tools/lib/pack/build.js buildPack, our guides in
// contextDir as context, read with contextDataDir's data) and plays with ours
// loaded: a guide whose `next` offers one of ours checks the engine lands on
// one of its options with something to do.
// -> { results, diag, played, dataMissing }: no results when the pack has
// errors; missing reference data (dataMissing) is the only error then
// (nothing is compiled without it).
function playtest({ dir, manifest, official = false, filter = null, classes = null, groups = 'skip', dataDir = DATA, data = null, contextDir = OFFICIAL_DIR, contextDataDir = DATA, onResult = null }) {
	const dataDiag = new Diagnostics();
	data = data || playData(dataDir, dataDiag);
	const contextData = official ? null : contextDataDir && path.resolve(contextDataDir) !== path.resolve(dataDir) ? playData(contextDataDir, dataDiag) : data;
	if (dataDiag.hasErrors()) return { results: [], diag: dataDiag, played: 0, dataMissing: true };
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
	const packIds = new Set(guides.map((g) => g.id));
	// Every compiled guide, for the chains into each one (chainDone).
	const chained = packs.flatMap((p) => p.guides);
	const sim = simPacks(packs, data);
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
					const pre = chainDone(chained, g, { race, faction, cls }, groups);
					const before = [
						pre.done.length ? `w.complete(${luaValue(pre.done)})` : '',
						...pre.carried.map((q) => `w.onQuest(${q}, {})`),
					].join('\n');
					const [out, hand] = playGuide(sim, g, { race, faction, cls, handOver, before, groups });
					const { stuck, problems } = outcome(out, handOver, hand, { race, faction, cls });
					const r = { guide: g.id, race, faction, cls, ok: !stuck && !problems.length, stuck, problems, landed: hand ? hand.guide || null : null };
					results.push(r);
					if (onResult) onResult(r);
				}
			}
		}
		return { results, diag, played };
	} finally {
		sim.dispose();
	}
}

const titleCase = (s) => s.charAt(0) + s.slice(1).toLowerCase();
const RACE_NAMES = { Scourge: 'Undead', NightElf: 'Night Elf' };
const raceName = (r) => RACE_NAMES[r] || r;

// "ok  mini/a (Human Warrior)"; "stuck mini/a (Orc Warrior) at step 2
// "Kobolds": goal 1 (kill) stays active".
function resultLines(r) {
	const who = `${raceName(r.race)} ${titleCase(r.cls)}`;
	if (r.ok) return [`ok  ${r.guide} (${who})`];
	const lines = [];
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
-- Each line gets the type of the first goal pointing at it, as the game gives
-- every line one: the engine reads a quest collect with no item line from the
-- bags, which the simulator does not fill.
local objs, kinds = {}, {}
local KIND = { kill = "monster", collect = "item", interact = "object" }
for _, s in ipairs(G.steps) do
	for _, g in ipairs(s.goals) do
		if g.quest and g.oi then
			objs[g.quest] = objs[g.quest] or {}
			objs[g.quest][g.oi] = math.max(objs[g.quest][g.oi] or 1, g.count or 1)
			kinds[g.quest] = kinds[g.quest] or {}
			kinds[g.quest][g.oi] = kinds[g.quest][g.oi] or KIND[g.t]
		end
	end
end
local function objectivesFor(q)
	local list, o, n = {}, objs[q], 0
	if o then for i in pairs(o) do if i > n then n = i end end end
	for i = 1, n do list[i] = { required = o[i] or 1, type = kinds[q][i] or "event" } end
	return list
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
local function act(i, g, r)
	local t, q = g.t, g.quest
	if t == "accept" then
		if not w.log[q] and not w.completed[q] then w.accept(q, objectivesFor(q), g.subject) end
	elseif t == "turnin" then
		if w.log[q] then w.finish(q) end
		w.turnIn(q)
	elseif t == "complete" then
		if w.log[q] then w.finish(q) end
	elseif q and g.oi and (t == "kill" or t == "collect" or t == "use" or t == "interact") then
		if w.log[q] then
			local o = w.log[q].objectives[g.oi]
			if o then w.progress(q, g.oi, o.numRequired) else w.finish(q) end
		end
	elseif q and (t == "kill" or t == "collect" or t == "use" or t == "interact") then
		if w.log[q] then w.finish(q) end
	elseif (t == "collect" or t == "buy") and g.item then
		w.addItem(g.item, (g.progress and g.progress.max) or 1)
	elseif t == "goto" then
		w.moveTo(g.map, g.x, g.y)
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
	elseif t == "hearth" or t == "fly" then
		w.setZone(g.subject, g.subject)
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
		w.setRep(r.faction, r.factionName or tostring(r.faction), r.standing, 0, 0, 3000)
	elseif t == "explore" then
		local id = 900000 + i * 100 + g.index
		w.addArea(r.map, r.x - 1, r.y - 1, r.x + 1, r.y + 1, id)
		w.moveTo(r.map, r.x, r.y)
		w.explore(id)
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
	stub.advance(0.6)
end
local visited, stuck, guard = {}, nil, 0
-- The engine may move on to the next guide (a hand-over) during any advance:
-- from then on nothing here may read or act on G's steps.
local function left() return E.GetGuide() ~= G end
while guard < 4000 do
	guard = guard + 1
	local i = E.GetStepIndex()
	if not i or left() then break end
	visited[i] = true
	local view = E.GetStepView(i)
	local open
	for _, g in ipairs(view.goals) do
		if g.status ~= "done" and g.status ~= "na" and not g.optional and g.t ~= "note" then open = g; break end
	end
	if not open then
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
			stuck = { step = i, title = view.title, goal = open.index, t = open.t, text = open.text, status = after.goals[open.index].status }
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
emit({ done = E.GetStepIndex() == nil or E.GetGuide() ~= G, stuck = stuck, visited = count, steps = #G.steps, missing = missing, wrongPick = wrongPick, level = w.level })
`;

module.exports = { playtest, resultLines, buildSimPack, playGuide, writePackInto, chainDone, SIMULATE, HOME, CLASSES, luaValue };
