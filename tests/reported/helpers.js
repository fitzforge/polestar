'use strict';
// Player-reported guide fixes, pinned so a route refresh (re-applying a new
// simulator route to the hand-written guides) cannot silently undo them: the
// helpers every tests/reported/<area>.test.js shares. Each case names the
// report it protects and checks behaviour on the guide compiled with the real
// reference data: goal order and where the arrow leads, not the guide's
// wording. The timed quest items have their own lint rule
// (tests/lint-timed.test.js); the Fargodeep Mine and Blackfathom Deeps mouths
// are in tests/guides-caves.test.js.
//
// Where a new case goes: the file of the guide it checks, by faction and band
// (horde-starts, horde-10-30, horde-30-40, horde-40-50, horde-50-60, and the
// same for alliance), class or other-guides; a check across several guides of
// one faction in <faction>-routes, across both factions' start zones in
// start-zones, anything wider in every-guide. A helper or constant more than
// one file needs goes here, exported at the end.
//
// Needs data/forever (forge data build); the cases skip without it, except the
// header-only Lookup regression, which uses a small display-data fixture.
// Player-reported guide fixes, pinned so a route refresh (re-applying a new
// simulator route to the hand-written guides) cannot silently undo them.
// Each case names the report it protects and checks behaviour on the guide
// compiled with the real reference data: goal order and where the arrow
// leads, not the guide's wording. The timed quest items have their own lint
// rule (tests/lint-timed.test.js); the Fargodeep Mine and Blackfathom Deeps
// mouths are in tests/guides-caves.test.js.
//
// Needs data/forever (forge data build); skips without it, except the
// header-only Lookup regression, which uses a small display-data fixture.

const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('../helpers/data');
const { compileSources, compileProject, OFFICIAL_DIR } = require('../../tools/lib/dsl/project');
const { loadData, Data } = require('../../tools/lib/dsl/data');
const { parseGuide } = require('../../tools/lib/dsl/parse');
const { Diagnostics } = require('../../tools/lib/dsl/diag');
const { loadCorrections } = require('../../tools/lib/data/corrections');
const { DATA, SOURCES, ROOT } = require('../../tools/lib/paths');
const { runAddon } = require('../helpers/lua');
const { writeTestPack } = require('../helpers/dsl');
const { buildSimPack, playGuide, SIMULATE } = require('../../tools/lib/playtest');
const { makeProjector, dist } = require('../../tools/lib/route/geo');
const { guideHeaders } = require('../helpers/guide-levels');

const skip = needs('quests.json', 'npcs.json', 'objects.json', 'map-frames.json');

// This regression needs no local reference build: compile the actual headers,
// whose index Lookup uses, with one inert step. Display names and zone ids are
// from the checked-in guide packs; quest mechanics are not part of this fixture.
const TOTEMS = [[5175, 'earth'], [5176, 'fire'], [5177, 'water'], [5178, 'air']];

// The starts two races share publish one guide per race (docs/forge/routes.md, "Publishing every
// start"): a report on the shared folder's guide holds on each race's copy.
const DUROTARS = ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide'];
const DUN_MOROGHS = ['forever/alliance/dwarf/01-dun-morogh.guide', 'forever/alliance/gnome/01-dun-morogh.guide'];
const [ORC_DUROTAR, TROLL_DUROTAR] = DUROTARS;
const [DWARF_DUN_MOROGH] = DUN_MOROGHS;
const TELDRASSIL = 'forever/alliance/nightelf/01-teldrassil.guide';
const ELWYNN = 'forever/alliance/human/01-elwynn-forest.guide';
const MULGORE = 'forever/horde/tauren/01-mulgore.guide';
const TIRISFAL = 'forever/horde/undead/01-tirisfal-glades.guide';
const STONETALON = 'forever/horde/05-stonetalon-mountains.guide';
const ASHENVALE = 'forever/alliance/06-ashenvale.guide';
const ASHENVALE_HORDE = 'forever/horde/07-ashenvale.guide';

let data;
const memo = new Map();
// The guide compiled with the reference data (its parse tree is `_ast`).
function compiled(guide) {
	if (!memo.has(guide)) {
		data = data || loadData(DATA);
		const file = path.join(OFFICIAL_DIR, guide);
		const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], data);
		assert.equal(guides.length, 1, `${guide} compiles`);
		memo.set(guide, guides[0]);
	}
	return memo.get(guide);
}
// The guide's goals in order, as { step, goal, s } (`s`: the step's number, as the Engine counts them).
function goals(guide) {
	return compiled(guide).steps.flatMap((step, s) => step.goals.map((goal) => ({ step, goal, s: s + 1 })));
}
// Every guide of ours, as paths relative to guides/ with forward slashes.
function allGuides() {
	const walk = (dir) => fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(dir, e.name)) : e.name.endsWith('.guide') ? [path.join(dir, e.name)] : []));
	return walk(path.join(OFFICIAL_DIR, 'forever')).map((file) => path.relative(OFFICIAL_DIR, file).split(path.sep).join('/'));
}

// Index of the first goal matching, asserted present.
function at(list, what, pred) {
	const i = list.findIndex(({ goal }) => pred(goal));
	assert.ok(i >= 0, `${what} is in the guide`);
	return i;
}
const is = (t, quest) => (g) => g.t === t && g.quest === quest;
// The list with the goals of `along` steps blanked, indices kept: such a step only lists what to pick
// up on the way until its label; the step that does the work is the labelled one.
const working = (list) => list.map((e) => (e.step.along ? { ...e, goal: {} } : e));
const located = ({ goal }) => goal.map != null && goal.x != null;
// Goals every character of the guide does (no `only` on the goal or its step).
const everyone = ({ step, goal }) => !step.only && !goal.only;
// A step only a character who runs a dungeon in the route has (`when dungeon "<Name>"`, not negated): no stop
// of the solo route, which a character on Skip, the default, plays.
const dungeonOnly = (step) => (step.when || []).some((p) => p.k === 'dungeon' && !p.neg);
// Goals a character of this class does (an `only` naming classes on the goal or its step must list it).
const forClass = (cls) => ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.classes || o.classes.includes(cls));

// Yards between two compiled points on one map (Era frame).
function yards(a, b) {
	const f = data.eraFrame(a.map);
	assert.ok(f && a.map === b.map, `points on one map with an Era frame (${a.map}, ${b.map})`);
	return Math.hypot(((f.right - f.left) * (a.x - b.x)) / 100, ((f.bottom - f.top) * (a.y - b.y)) / 100);
}

// The data counts the salve's cure and the yeti's fright as kill credit, so the goal stays a `kill`
// tracking the objective; its text says what to do. The hand-written druid guide says it itself; the
// generated leveling guides get it from data/places.json on the next build.
const USE_ITEM_873 = {
	'6124.1': 'Use the Curative Animal Salve on Sickly Deer',
	'6129.1': 'Use the Curative Animal Salve on Sickly Gazelles',
	'5163.1': "Use Umi's Mechanical Yeti beside Legacki",
	'5163.2': "Use Umi's Mechanical Yeti beside Sprinkle",
	'5163.3': "Use Umi's Mechanical Yeti beside Quixxil",
};

// --- Darkshore (Wogi): a Human at 20 was sent to grey quests.

// Darkshore and the guides after it, played by the Engine for a level-`level`
// Human with "Skip grey quests" on: the accepts it leaves out as grey
// (`skipped`), and each grey accept it keeps with the quest it says it opens
// and that line (`kept`).
function greyInDarkshore(level) {
	data = data || loadData(DATA);
	const files = ['03-darkshore', '03-loch-modan', '03-darkshore-return', '04-redridge-mountains', '05-duskwood', '06-ashenvale', '07-thousand-needles']
		.map((n) => path.join(OFFICIAL_DIR, 'forever/alliance', `${n}.guide`));
	const { guides } = compileSources(files.map((file) => ({ file, text: fs.readFileSync(file, 'utf8') })), data);
	const { dir, scripts } = writeTestPack(guides, data);
	try {
		const loads = scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
				w.level = ${level}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = true, autoSelectGuide = false } } }' },
			script: `do local ns = {}
				${loads}
				end
				stub.login(); stub.advance(0.5)
				local E = Polestar.Engine
				E.SetGuide("forever/alliance/03-darkshore")
				local skipped, kept = {}, {}
				for i = 1, #E.GetGuide().steps do
					for _, g in ipairs(E.GetStepView(i).goals) do
						if g.skippedGrey then skipped[#skipped + 1] = g.quest end
						if g.keptGrey then kept[tostring(g.quest)] = { g.keptGrey, g.keptGreyText } end
					end
				end
				emit({ skipped = skipped, kept = kept })`,
		});
		// An empty Lua table comes back as {}.
		const { skipped, kept } = emitted[0];
		return { skipped: Object.values(skipped), kept };
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

// --- Durotar (AndarKerran): A Pain in the Neck (96873) is for enchanters.

// A guide played by the Engine for one character (`who`: race, raceName,
// faction, cls, className, level), with `before` (Lua, `w` the stub world)
// run before login and `after` once the guide is open: what `script` (Lua,
// `E` the Engine) emits. `data`: the reference data to compile with (a copy
// with a correction applied, as `data build` applies it), else data/forever.
// `text` plays that text in the guide's place.
function engineRun(guide, who, { before = '', after = '', script, data: own, text }) {
	const ref = own || (data = data || loadData(DATA));
	const file = path.join(OFFICIAL_DIR, guide);
	const { guides } = compileSources([{ file, text: text ?? fs.readFileSync(file, 'utf8') }], ref);
	const { dir, scripts } = writeTestPack(guides, ref);
	try {
		const loads = scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = "${who.race}", "${who.raceName}", "${who.faction}", "${who.cls}", "${who.className}"
				w.level = ${who.level}
				${before}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }' },
			script: `do local ns = {}
				${loads}
				end
				stub.login(); stub.advance(0.5)
				local E = Polestar.Engine
				E.SetGuide("${guide.replace(/\.guide$/, '')}")
				${after}
				stub.advance(0.5)
				${script}`,
		});
		return emitted[0];
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

// The status of each goal of `quest` ("accept na", ...), with `skills` (Lua)
// set before login and `after` run once the guide is open.
function questGoalStatus(guide, quest, who, { skills = '', after = '' } = {}) {
	return Object.values(engineRun(guide, who, {
		before: skills,
		after,
		script: `local out = {}
			for i = 1, #E.GetGuide().steps do
				for _, g in ipairs(E.GetStepView(i).goals) do
					if g.quest == ${quest} then out[#out + 1] = g.t .. " " .. g.status end
				end
			end
			emit(out)`,
	})); // an empty Lua table comes back as {}
}

// What the guide window shows for step `s`: its goals ({ t, quest, status,
// text, optional }) and its groups (the goal numbers of each, in order), with
// `before` (Lua) setting up the world before login.
function stepView(guide, who, s, before = '') {
	const v = engineRun(guide, who, {
		before,
		script: `local v = E.GetStepView(${s})
			local out = { groups = {}, goals = {} }
			for k, grp in ipairs(v.groups) do out.groups[k] = grp.goals end
			for k, g in ipairs(v.goals) do
				out.goals[k] = { t = g.t, quest = g.quest or 0, oi = g.oi or 0, status = g.status, text = g.text or "", optional = g.optional }
			end
			emit(out)`,
	});
	return { goals: v.goals, groups: v.groups };
}

const TROLL_WARRIOR = { race: 'Troll', raceName: 'Troll', faction: 'Horde', cls: 'WARRIOR', className: 'Warrior', level: 12 };
const ORC_WARRIOR = { ...TROLL_WARRIOR, race: 'Orc', raceName: 'Orc' };
// A Warrior of the Durotar copy's own race.
const warriorOf = (guide) => (guide === TROLL_DUROTAR ? TROLL_WARRIOR : ORC_WARRIOR);

// --- The Barrens (Hotline, a Scourge Mage): Walton offered neither Unwelcome
// Guests nor Trouble in the Valley, and Vrang no Hermit Tanner. They are one
// chain: Vrang's Bruised Pride and Lion Hides and Vrang's Game, then The
// Hermit Tanner up to Walton, then Trouble in the Valley, then Unwelcome Guests.

// The Barrens' 15-21 stay (forever/horde/02-the-barrens since the Horde 12-30 re-chain, 2026-11-07: the
// former 12-16 guide and the first half of the former 19-23 guide in one); 04-the-barrens is its 24-26 return.
const BARRENS = 'forever/horde/02-the-barrens.guide';

// Rohkin (#957): the Bristleback camps step collected Mankrik's tusks
// (Consumed by Hatred, 899) before Camp Taurajo, then the guide sent them back
// into the same camps for Tribes at War (878) from Mangletooth. Every
// Bristleback 878 asks for drops tusks, so the tusks are collected on 878's
// step, after its accept; Mankrik's wife (Lost in Battle, 4921) stays on the
// walk south.
// Flow audit, The Barrens (#1078). 12-16: Orcs and Trolls walked to Ratchet for its flight path alone and
// back to the Crossroads, 25 minutes before the route went to Ratchet anyway; Kolkar Leaders' Regthar was
// passed at 0 yd and Barak's camp walked through, the quest taken 326 minutes later in the 19-23 guide.
// 19-23: Raptor Horns was walked past at Mebok on the first Ratchet stop and handed in on the second, 149
// minutes later; a Warrior was sent from Camp Taurajo to Thun'grim (2,300 yd) and back for one hand-in.
const BARRENS_12 = 'forever/horde/02-the-barrens.guide';

// --- Forever chains the quest data has no prerequisite for, so the guide took
// a follow-up at the same visit as the quest before it and the giver did not
// offer it: Baine's chain in Mulgore (Kori, #112) and Mull's report (#51),
// Bandarion Keep (whiteswag, #128) and Linnea's second Rear Guard Patrol (#51)
// in Tirisfal, Alther's Mill in Redridge (#126's report), The State of the
// Mines in Westfall (SouthernStyleSims, #143), Scout Support in Hillsbrad
// (Taako, #148) and Stopping the Cycle in the Wetlands (#51). The #128 sweep
// against the Forever quest chains found Quinn's potions in Silverpine (Wild
// Eyes and Return to Quinn (Again) after Return to Quinn) and, at 30-40, Bloom
// of the Heavens, Sentiments of the Lost, Shared Fury and Friend of the Kirin
// Tor, each taken without the part before it. Each accept comes after every
// quest it follows is handed in; the optional ones may be left out, never
// taken early.

const WESTFALL = 'forever/alliance/02-westfall.guide';
const REDRIDGE = 'forever/alliance/04-redridge-mountains.guide';
const HILLSBRAD_HORDE = 'forever/horde/06-hillsbrad-foothills.guide';
const SILVERPINE = 'forever/horde/03-silverpine-forest.guide';
const HILLSBRAD_ALLIANCE = 'forever/alliance/30-40/01-hillsbrad-foothills.guide';
const ASHENVALE_30 = 'forever/alliance/30-40/03-ashenvale.guide';
const ARATHI = 'forever/alliance/30-40/05-arathi-highlands.guide';
const DARKSHORE = 'forever/alliance/03-darkshore.guide';
// Darkshore's southern and last loops, after the Eastern Kingdoms loop (Alliance 12-20 re-order, 2026-11-07).
const DARKSHORE_RETURN = 'forever/alliance/03-darkshore-return.guide';
const LOCH_MODAN = 'forever/alliance/03-loch-modan.guide';
// Both Darkshore visits in chain order: a quest of the first visit before one of the return.
const darkshoreBoth = () => [...goals(DARKSHORE), ...goals(DARKSHORE_RETURN)];
const THOUSAND_NEEDLES = 'forever/alliance/07-thousand-needles.guide';
const WETLANDS = 'forever/alliance/06-wetlands.guide';
const collects = (item) => (g) => g.t === 'collect' && g.item === item;

// #2561's sweep, the whole class: a hand-in the giver takes straight from the
// bags (`turnin ... direct`, never in the log) can only be done with what the
// quest asks for in the bags, and nothing in the quest log tells the guide
// whether they are. A required one holds the route there, so its step must
// either gather the items itself before the hand-in or show only while the
// bags hold them (`when has <item> xN`); work that shared its step and holds
// the route for everyone moves to a step of its own. Each fixed stop is
// pinned below (with the work that must still hold), and every guide is
// checked for the class.
function directNeeds(quest) {
	const out = new Map();
	for (const o of data.quests[quest].objectives || []) if (o.type === 'item' && o.id) out.set(o.id, o.count || 1);
	return out;
}

// --- Alliance 12-21 level ranges (Discord, 2026-11-08: a Human "usually gets cut off in Westfall around 15 and a
// half"): #1274 set Westfall 13-17, Darkshore 17-19 and Loch Modan 19-21 from the Dwarf, Gnome, Night Elf and
// Skyborne levels, but Humans come from Elwynn and enter about 2 lower. The level model (0.3.5, mean
// over each start's classes) has Humans entering Westfall at 11.35, Darkshore at 15.27 and Loch Modan at 17.77,
// and the other starts leaving them at up to 17.54, 19.38 and 21.61. The per-start levels come from the level sim
// with locally calibrated parameters, so a test can't recompute them; these tests check the guides' own labels instead.
// Each guide's levels per faction (tests/helpers/guide-levels.js); tests/guides-levels.test.js checks the hand-offs
// and that every level has a guide on each side.
const headers = () => guideHeaders(OFFICIAL_DIR);

const BADLANDS = 'forever/alliance/30-40/06-badlands.guide';
const DESOLACE_SOUTH = 'forever/alliance/30-40/06b-desolace.guide';

// The same pattern elsewhere: a quest taken where the route already stands,
// instead of on a walk back to its giver later.
const STRANGLETHORN_HORDE = 'forever/horde/30-40/03-stranglethorn-vale.guide';

// --- Quests the guide accepted and turned in with nothing between waiting for
// their objectives, so the guide moved on to the turn-in with the quest
// unfinished: Camping 101: Cooking in Mulgore and Dun Morogh (speak with the
// cook) and, for the Alliance, It's a Secret to Everybody in Un'Goro (the
// Horde guide collects the compass, map and key).

const UN_GORO_ALLIANCE = 'forever/alliance/40-50/07-un-goro-crater.guide';

// uNBEx and Bennistrov (#1348): Herble keeps one Bronze Tube and is nearly always sold out (no tube in 30
// merchant windows of 19 players' recordings; Billibub Cogspinner in Stormwind none in 20 of 14). The players
// who handed Look to the Stars in bought it at the Stormwind Auction House, so the Stormwind stop before
// Darkshire sends them there, without holding anyone who has no use for it.
const STORMWIND_AH = { map: 1453, x: 61.2, y: 71.3 };
const atAuctionHouse = (g) => g.map === STORMWIND_AH.map && Math.hypot(g.x - STORMWIND_AH.x, g.y - STORMWIND_AH.y) <= 1;

// --- Zephras Isle (Sato, 0.2.3).

const ZEPHRAS_HORDE = 'forever/horde/skyborne/01-zephras-isle.guide';
const ZEPHRAS_ALLIANCE = 'forever/alliance/skyborne/01-zephras-isle.guide';
const SKYBORNE_HORDE = { race: 'Skyborne', raceName: 'Skyborne', faction: 'Horde', cls: 'ROGUE', className: 'Rogue', level: 6 };

// --- Boats in open water (Fitz's playtest at the Auberdine pier): a boat's
// stop in travel.json is where the ship stands (TaxiPathNode), most of them in
// open water 12-14 yd off the pier. A goto there completes only within 8 yd of
// it, so the step cannot finish without swimming and the arrow points into the
// sea. Every goto at a transport (within 40 yd of its stop) is on walkable
// ground: dry deck, pier or platform within 8 yd, on the navigation grid.

const NAV = path.join(ROOT, 'data', 'local', 'nav');
const navIndex = fs.existsSync(path.join(NAV, 'index.json')) ? JSON.parse(fs.readFileSync(path.join(NAV, 'index.json'), 'utf8')) : null;

// --- A goal on a neighbour's map (#246): Kadrak stands at the Mor'shan
// Rampart, in the Barrens (Forever's quest data; AreaTable puts the Rampart, 1703,
// under the Barrens), where the Barrens and Ashenvale maps overlap. The step's
// `zone Ashenvale` put him on Ashenvale's map, so the travel planner took him
// for a target in Ashenvale and sent players on the Gold Road through the
// zone crossing to its Ashenvale end, 110 yd past him, and back.
const STONETALON_HORDE = 'forever/horde/05-stonetalon-mountains.guide';

// --- Flow audit (2026-11-07): the Night Elf start's own Darkshore took the
// boat to Stormwind for Goldshire's training and A Fishy Peril, then sent every
// Night Elf back across the sea for the last part of Bashal'Aran (957: the
// Ancient Flame at Ameth'Aran, then Asterion) and took the boat out again. 957
// is open from the first Bashal'Aran visit: the second loop passes Ameth'Aran
// and ends at Asterion before Auberdine, so the sea is crossed once. The first
// loop captured a Plagued Lands bear 700 yards north-east and walked a thousand
// back south for it: the bears south of Auberdine are on the way to the
// furbolg camp (players' recordings tick it at either place).
const NE_DARKSHORE = 'forever/alliance/nightelf/02-darkshore.guide';
const nightElf = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes('NightElf'));

// --- Travel follow-ups of the flight path sweep (#964).
const forRaceOf = (race) => ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes(race));

// The guide and every guide its `next` leads to, in order. A guide for both factions (forever/40-50/shendralas) goes
// on to the start's faction's next guide, as the addon does.
function chainFrom(guide) {
	const side = (guide.match(/^forever\/(alliance|horde)\//) || [])[1];
	const out = [];
	for (let g = guide; g && !out.includes(g); ) {
		out.push(g);
		const c = compiled(g);
		const opts = [c.next, ...(c.nextChoices || [])].flat().filter(Boolean).map(String);
		const next = opts.find((id) => !side || !/^forever\/(alliance|horde)\//.test(id) || id.startsWith(`forever/${side}/`));
		g = next ? `${next.replace(/\.guide$/, '')}.guide` : null;
		if (g && !fs.existsSync(path.join(OFFICIAL_DIR, g))) break;
	}
	return out;
}
// --- end of Alliance 12-20 zone order

// --- Guide end (release blocker, 2026-11-08): 04-redridge-mountains' last step carried `vendor nearest` with its
// hand-ins, so a player who handed everything in without visiting a vendor never reached the guide's end
// (forge-addontest guides_end: the last step done ahead of the live one must end the guide). A vendor goal is
// a check-off the Engine ticks only when a merchant window opens during its step, so a required one holds
// any step whose real goals are done. The sell and repair stops are optional: no leveling guide's last step
// waits on one, and in the Alliance 12-20 guides no step does.
const forAllOnly = (o) => !(o && ((o.classes || []).length || (o.races || []).length));

const STARTS = {
	Horde: [[ORC_DUROTAR, 'Orc'], [TROLL_DUROTAR, 'Troll'], [MULGORE, 'Tauren'], [TIRISFAL, 'Scourge'], [ZEPHRAS_HORDE, 'Skyborne']],
	Alliance: [[DWARF_DUN_MOROGH, 'Dwarf'], [DUN_MOROGHS[1], 'Gnome'], [ELWYNN, 'Human'], [TELDRASSIL, 'NightElf'], [ZEPHRAS_ALLIANCE, 'Skyborne']],
};
const routeMemo = new Map();
// Every character's route on a side, as { who, cls, list }: `list` the goals in order as { step, goal, s, guide }.
function routes(side) {
	if (!routeMemo.has(side)) {
		routeMemo.set(side, STARTS[side].flatMap(([start, race]) => {
			const all = chainFrom(start).flatMap((guide) => goals(guide).map((e) => ({ ...e, guide })));
			const mine = all.filter(forRaceOf(race));
			return data.raceClasses(race, side).map((cls) => ({ who: `${race} ${cls}`, cls, list: mine.filter(forClass(cls)) }));
		}));
	}
	return routeMemo.get(side);
}
const where = ({ guide, s }) => `${guide.replace(/^forever\//, '').replace(/\.guide$/, '')} step ${s}`;
const forChar = (o, race, cls) => !o || ((!o.races || o.races.includes(race)) && (!o.classes || o.classes.includes(cls)));
// "<step> -> <step>" for each such pair in `guide` for one race and class.
function flightHops(guide, race, cls) {
	const nodes = new Map((data.travel?.taxi?.nodes || []).map((n) => [n.id, n.c]));
	const continent = (map) => (data.mapFrames.forever?.[map] || data.mapFrames.era?.[map] || {}).c;
	const steps = compiled(guide).steps.filter((step) => forChar(step.only, race, cls)).map((step) => ({ step, goals: step.goals.filter((g) => forChar(g.only, race, cls)) }));
	const work = (g) => !['goto', 'fly', 'note'].includes(g.t);
	const out = [];
	steps.forEach(({ step, goals }, i) => {
		const last = goals.map((g) => g.t).lastIndexOf('fly');
		if (last < 0 || step.when || !goals.slice(0, last).some((g) => g.t === 'goto' && g.x != null) || goals.slice(last + 1).some(work)) return;
		let on = nodes.get(goals[last].node);
		for (const { step: next, goals: later } of steps.slice(i + 1)) {
			if (next.when) return;
			const f = later.findIndex((g) => g.t === 'fly');
			const before = f < 0 ? later : later.slice(0, f);
			if (before.some(work)) return;
			for (const g of before.filter((g) => g.t === 'goto' && g.map != null)) {
				const c = continent(g.map);
				if (c == null) continue;
				if (on != null && c !== on) return;
				on = c;
			}
			if (f >= 0) {
				out.push(`${step.title} -> ${next.title}`);
				return;
			}
		}
	});
	return out;
}

// --- Horde 30-40 re-order (2026-11-07, the 30-40 review: 379 minutes of grind in Desolace &
// Hillsbrad and 310 in Stranglethorn, a top-up to 32.2 at Sargeron right after arriving at 30). The
// zones in the order their quest levels fit: Hillsbrad and a first
// Arathi visit 30-32, the Shimmering Flats and Desolace's 33-36 quests 32-34, Stranglethorn, Dustwallow
// with a short second Desolace stop for its 38-40 quests, Alterac and Arathi, the Badlands, then the
// flight to Booty Bay for 40-50. Martek the Exiled is taken once Hardened Shells is in (the game's
// prerequisites), and Stolen Freewind Supplies goes with Stop the Screeching.
const H3040 = ['01-hillsbrad-foothills', '02-thousand-needles', '03-stranglethorn-vale', '04-dustwallow-marsh', '05-arathi-highlands', '06-badlands'].map((n) => `forever/horde/30-40/${n}.guide`);

// The guide file's tip lines for the step holding the first goal that matches `re`.
function stepTips(guide, re) {
	const lines = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').split('\n');
	const k = lines.findIndex((l) => re.test(l));
	assert.ok(k >= 0, `${re} is in ${guide}`);
	let s = k;
	while (s > 0 && !/^step /.test(lines[s])) s--;
	let e = k;
	while (e < lines.length && !/^step /.test(lines[e + 1] || 'step ')) e++;
	return lines.slice(s, e + 1).filter((l) => /^\s+tip /.test(l)).map((l) => l.replace(/^\s+tip /, ''));
}

// --- Alliance 1-30 audit (#1415). Route review (2026-11-08/09) and players' recordings.

const PLACES = () => JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'places.json'), 'utf8')).places;
const whenOn = (step, k, q) => (step.when || []).some((p) => p.k === k && !p.neg && [p.q].flat().includes(q));

// --- Alliance 40-60 quest volume, 0.3.7 (2026-11-09) ---
const lvlOf = (goal) => goal.level + (goal.frac || 0);
const required = ({ goal }) => !goal.optional;

// creazy231's report (#1660): a Tauren Druid at 29 who skipped the 22-25 Hillsbrad guide opened Horde 30-40/01 with
// Battle of Hillsbrad 532, 539, 541 and Infiltration 533 hidden ("needs Battle of Hillsbrad / The Rescue from Hillsbrad
// Foothills"). The guide does Battle of Hillsbrad 527-528 and The Rescue (498) from Tarren Mill first, each step
// only until its chain's last quest is handed in. Since the level tidy (2026-11-15) Battle of Hillsbrad 529 (the
// smithy) is this guide's own for everyone (the 22-25 guide stops after 528), and Infiltration is on the 38-39 visit.
const HILLSBRAD_3040 = 'forever/horde/30-40/01-hillsbrad-foothills.guide';
const TAUREN_DRUID_29 = { race: 'Tauren', raceName: 'Tauren', faction: 'Horde', cls: 'DRUID', className: 'Druid', level: 29 };
// Per quest of the Hillsbrad chains: the statuses of its accept goals, and what the plan left out (guide.hidden).
function hillsbradChains(before) {
	return engineRun(HILLSBRAD_3040, TAUREN_DRUID_29, {
		before,
		script: `local out, hidden = {}, {}
			for i = 1, #E.GetGuide().steps do
				for _, g in ipairs(E.GetStepView(i).goals) do
					if g.t == "accept" and ({ [527] = 1, [528] = 1, [529] = 1, [498] = 1, [532] = 1, [533] = 1, [539] = 1, [541] = 1 })[g.quest] then
						out[tostring(g.quest)] = (out[tostring(g.quest)] and out[tostring(g.quest)] .. "," or "") .. g.status
					end
				end
			end
			for q in pairs(E.GetGuide().hidden or {}) do hidden[#hidden + 1] = q end
			table.sort(hidden)
			emit({ accepts = out, hidden = hidden })`,
	});
}

// Centaur reputation, Magram (Discord, 2026-11-10: "Magram rep missing from the guide"): the guide went to the Magram
// half only with Brutal Politics or Magram Alliance in the log, so a player who took only Buying Friendship: Magram,
// or had handed the choice quest in, stayed on the Gelkis steps; a Gelkis player who had handed in only Buying
// Friendship: Gelkis went on into the Magram half. Both Buying Friendships wait for Carved Centaur Totems
// (players' recordings).
const CENTAURS = 'forever/reputation/centaur-clans.guide';
const TAUREN_WARRIOR_40 = { race: 'Tauren', raceName: 'Tauren', faction: 'Horde', cls: 'WARRIOR', className: 'Warrior', level: 40 };

// The Riverglades guides, in both factions' routes since 0.4.0 (guides/forever/horde/40-50/01b-riverglades.guide and
// guides/forever/alliance/40-50/01b-riverglades.guide; any left in Polestar Experimental, experimental/guides, too):
// facts from players' recordings the routes stand on, read from the guide text so they hold without reference data.
const RIVERGLADES = path.join(ROOT, 'experimental', 'guides');
const RIVERGLADES_HORDE = path.join(ROOT, 'guides', 'forever', 'horde', '40-50', '01b-riverglades.guide');
const RG_ALLIANCE = path.join(ROOT, 'guides', 'forever', 'alliance', '40-50', '01b-riverglades.guide');
const codeOf = (line) => line.split('--')[0];

// A guide's steps as lists of code lines (comments cut): an experimental guide's file name, or a path.
const rivergladesSteps = (file) => fs.readFileSync(path.isAbsolute(file) ? file : path.join(RIVERGLADES, file), 'utf8').split(/\n(?=step\b)/).map((s) => s.split('\n').map(codeOf));
const anyLine = (lines, re) => lines.some((l) => re.test(l));
const dungeonKey = (s) => String(s).trim().toLowerCase().replace(/^the\s+/, '');

// --- Reported problems the reported-problems gate (#2042) found with no check of their own. Each case reads every
// guide that holds the quest or NPC, keyed by their ids, never by a guide file or a step number, so a renamed guide or
// a rebuilt route is checked the same way; a route that leaves the quest out has nothing to check.

// Every step of every guide with a goal matching `pred`, as { guide, step, goal }.
function stepsHolding(pred) {
	return allGuides().flatMap((guide) => compiled(guide).steps.flatMap((step) => step.goals.filter(pred).map((goal) => ({ guide, step, goal }))));
}
// A step's tips and the goal's own note, as one text.
const notesOf = (step, goal) => [].concat(step.note || [], goal.note || []).join(' ');
// The reference data, loaded if no guide has been compiled yet.
const refData = () => (data = data || loadData(DATA));

module.exports = {
	needs, compileSources, compileProject, OFFICIAL_DIR, loadData, Data, parseGuide, Diagnostics, loadCorrections, DATA,
	SOURCES, runAddon, writeTestPack, buildSimPack, playGuide, SIMULATE, makeProjector, dist, guideHeaders, skip, TOTEMS,
	DUROTARS, DUN_MOROGHS, ORC_DUROTAR, TROLL_DUROTAR, DWARF_DUN_MOROGH, TELDRASSIL, ELWYNN, MULGORE, TIRISFAL,
	STONETALON, ASHENVALE, ASHENVALE_HORDE, memo, compiled, goals, allGuides, at, is, working, located, everyone,
	dungeonOnly, forClass, yards, USE_ITEM_873, greyInDarkshore, engineRun, questGoalStatus, stepView, TROLL_WARRIOR,
	ORC_WARRIOR, warriorOf, BARRENS, BARRENS_12, WESTFALL, REDRIDGE, HILLSBRAD_HORDE, SILVERPINE, HILLSBRAD_ALLIANCE,
	ASHENVALE_30, ARATHI, DARKSHORE, DARKSHORE_RETURN, LOCH_MODAN, darkshoreBoth, THOUSAND_NEEDLES, WETLANDS, collects,
	directNeeds, headers, BADLANDS, DESOLACE_SOUTH, STRANGLETHORN_HORDE, UN_GORO_ALLIANCE, STORMWIND_AH, atAuctionHouse,
	ZEPHRAS_HORDE, ZEPHRAS_ALLIANCE, SKYBORNE_HORDE, NAV, navIndex, STONETALON_HORDE, NE_DARKSHORE, nightElf, forRaceOf,
	chainFrom, forAllOnly, STARTS, routeMemo, routes, where, forChar, flightHops, H3040, stepTips, PLACES, whenOn, lvlOf,
	required, HILLSBRAD_3040, TAUREN_DRUID_29, hillsbradChains, CENTAURS, TAUREN_WARRIOR_40, RIVERGLADES,
	RIVERGLADES_HORDE, RG_ALLIANCE, codeOf, rivergladesSteps, anyLine, dungeonKey, stepsHolding, notesOf, refData, ROOT,
};
