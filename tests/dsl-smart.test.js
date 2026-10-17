'use strict';
// Smart targets: `train <Profession> [Rank]`, `train class`, `buy … nearest`,
// `vendor nearest`, `sethome nearest` compile to candidate sets
// (docs/ARCHITECTURE.md "Smart logic"); `trainers build`; `qlvl`/`pre` on
// accepts for the engine's grey-quest skipping; a quest's profession on its
// goals for the engine's profession gate.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK } = require('./helpers/packs');
const { compile, guideText, lineOf, plain, fixtureData, writeTestPack, DATA_DIR } = require('./helpers/dsl');
const { quiet } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const { loadData } = require('../tools/lib/dsl/data');
const trainersCmd = require('../tools/commands/trainers');

const head = (faction, extra = []) => ['guide t/s', 'title S', ...(faction ? [`faction ${faction}`] : []), 'levels 1-60', 'zone Elwynn Forest', ...extra, ''];

function goals(lines, data) {
	const r = compile(`${lines.join('\n')}\n`, data);
	return { r, goals: r.guides.length ? plain(r.guides[0].steps.flatMap((s) => s.goals)) : [] };
}

function only(list, re) {
	return list.filter((m) => re.test(m));
}

// A copy of the fixture data folder with edits applied: edit(raw) mutates parsed JSON by file name.
function dataWith(edit) {
	const dir = tmpdir();
	const raw = {};
	for (const f of fs.readdirSync(DATA_DIR)) raw[f] = JSON.parse(fs.readFileSync(path.join(DATA_DIR, f), 'utf8'));
	edit(raw);
	for (const [f, v] of Object.entries(raw)) fs.writeFileSync(path.join(dir, f), JSON.stringify(v));
	return { dir, data: loadData(dir) };
}

test('train <Profession>: rank trainers of the guide factions, with skill line, rank and cap', () => {
	const { r, goals: g } = goals([...head('Alliance'), 'step S', '  train Mining', '  train Mining Expert']);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(g[0], {
		t: 'train',
		skill: 'Mining',
		skillLine: 186,
		rank: 1,
		rankMax: 75,
		candidates: [{ npc: 1681, npcName: 'Brock Stoneseeker', map: 1426, x: 37, y: 47.8, f: 'e', faction: 'A' }],
	});
	assert.deepEqual([g[1].rank, g[1].rankMax, g[1].candidates.map((c) => c.npc)], [3, 225, [1681]]);
	// No faction: both sides' trainers, each tagged.
	const both = goals([...head(null), 'step S', '  train Mining']).goals[0];
	assert.deepEqual(both.candidates.map((c) => [c.npc, c.faction]), [[1681, 'A'], [3175, 'H']]);
});

test('train <Profession>: book and quest ranks point at the book vendor and quest giver', () => {
	const { r, goals: g } = goals([...head(null), 'step S', '  train First Aid Expert', '  train Mining Artisan']);
	// The Expert First Aid book is only sold to the Alliance in this data.
	assert.deepEqual(only(r.warnings, /no vendor of the First Aid Expert book for Horde/).length, 1);
	assert.deepEqual(g[0].candidates.map((c) => [c.npc, c.faction]), [[2805, 'A']]);
	// Listed as quest giver for both factions: tagged for both even though npcs.json says Alliance.
	assert.deepEqual(g[1].candidates.map((c) => [c.npc, c.faction]), [[8125, 'AH']]);
	assert.deepEqual(r.errors, []);
});

test('train <Profession>: the default rank follows earlier skill targets and never repeats a trained rank', () => {
	const src = [
		...head('Alliance'),
		'step S',
		'  train Mining',
		'  skill Mining 50',
		'  train Mining',
		'  skill Mining 75',
		'  train Mining',
		'  skill Mining 150',
		'  train Mining',
		'  craft 3276 until 230',
		'  train First Aid',
	];
	const { r, goals: g } = goals(src);
	const trains = g.filter((x) => x.t === 'train').map((x) => [x.skill, x.rank]);
	assert.deepEqual(trains, [
		['Mining', 1],
		['Mining', 2],
		['Mining', 3], // skill 75 alone still means Journeyman, which is already trained: next is Expert
		['Mining', 4], // ... and that one was trained early, so 150 moves on to Artisan
		['First Aid', 4], // `craft … until 230` counts as a First Aid target (Artisan; minimum skill 225)
	]);
	assert.deepEqual(only(r.warnings, /means/), [
		`test.guide:${lineOf(src.join('\n'), '  skill Mining 75') + 1}: \`train Mining\` means Expert here (needs skill 125), but no earlier \`skill Mining\` target reaches 125; name the rank or add the skill goal`,
		`test.guide:${lineOf(src.join('\n'), '  skill Mining 150') + 1}: \`train Mining\` means Artisan here (needs skill 225), but no earlier \`skill Mining\` target reaches 225; name the rank or add the skill goal`,
	]);
	const done = compile(`${[...head('Alliance'), 'step S', '  train Mining Artisan', '  train Mining'].join('\n')}\n`);
	assert.deepEqual(done.errors, ['test.guide:9: `train Mining`: Artisan is already trained earlier in this guide']);
});

test('train <Profession> npc <id> keeps the trainer; errors for unknown professions and coordinates', () => {
	const g = goals([...head('Alliance'), 'step S', '  train Mining npc 1681']).goals[0];
	assert.deepEqual(g, { t: 'train', npc: 1681, npcName: 'Brock Stoneseeker', skill: 'Mining', skillLine: 186, rank: 1, rankMax: 75, map: 1426, x: 37, y: 47.8, f: 'e' });
	const src = [...head('Alliance'), 'step S', '  train Basket Weaving', '  train Mining @50,50', '  train only Warrior', '  train 911'];
	const r = compile(`${src.join('\n')}\n`);
	assert.deepEqual(r.errors, [
		'test.guide:8: unknown profession "Basket Weaving" (write `train <Profession> [Apprentice|Journeyman|Expert|Artisan]`, `train class` or `train <npcId>`)',
		'test.guide:9: smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id',
	]);
	// The plain forms still compile as before.
	assert.deepEqual(plain(r.guides[0].steps[0].goals.slice(2)).map((x) => x.npc), [undefined, 911]);
});

test('train class: class trainers of the classes and factions the goal applies to', () => {
	// Without trainers.json the curated list is used, resolved by name and map in npcs.json.
	const { r, goals: g } = goals([...head('Alliance', ['class Warrior,Mage']), 'step S', '  train class']);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(r.warnings, []);
	assert.deepEqual(g[0].class, true);
	assert.deepEqual(
		g[0].candidates.map((c) => [c.npc, c.npcName, c.faction, c.classes]),
		[
			[911, 'Llane Beshere', 'A', ['WARRIOR']],
			[198, 'Khelden Bremen', 'A', ['MAGE']],
			[5479, 'Wu Shen', 'A', ['WARRIOR']],
		],
	);
	// "Lyria Du Lac" is curated for Elwynn, but the fixture has her only in Durotar: not trusted.
	assert.ok(!g[0].candidates.some((c) => c.npc === 913));
	// A goal-level `only` narrows the classes.
	const mage = goals([...head('Alliance'), 'step S', '  train class only Mage']).goals[0];
	assert.deepEqual(mage.candidates.map((c) => c.npc), [198]);
});

test('train class: missing coverage warns per faction and class; no candidate at all is an error', () => {
	// Horde Mage: the fixture has no Horde mage trainer (Frang is a warrior).
	const horde = compile(`${[...head('Horde', ['class Warrior,Mage']), 'step S', '  train class'].join('\n')}\n`);
	assert.deepEqual(horde.errors, []);
	assert.deepEqual(horde.warnings, ['test.guide:9: no Mage trainer for Horde in data (trainers.json)']);
	const none = compile(`${[...head('Horde', ['class Druid']), 'step S', '  train class'].join('\n')}\n`);
	assert.deepEqual(none.errors, ['test.guide:9: `train` found no class trainer in data for Horde characters; name one with an npc id instead']);
	const npc = compile(`${[...head('Alliance'), 'step S', '  level 2', '  train class npc 911'].join('\n')}\n`);
	assert.deepEqual(npc.errors, ['test.guide:9: `train class` picks the trainer at runtime; drop `npc`']);
});

test('train class reads trainers.json when present', () => {
	const { data } = dataWith((raw) => {
		raw['trainers.json'] = { 3153: { id: 3153, name: 'Frang', classes: ['MAGE'], sources: ['guide'] } };
	});
	const { r, goals: g } = goals([...head('Horde', ['class Mage']), 'step S', '  train class'], data);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(g[0].candidates.map((c) => [c.npc, c.classes]), [[3153, ['MAGE']]]);
});

test('buy … nearest, vendor nearest and sethome nearest: vendors, repairers and innkeepers with faction tags', () => {
	const { r, goals: g } = goals([...head(null), 'step S', '  buy 159 x5 nearest', '  vendor nearest', '  sethome nearest', '  sethome "nearest"']);
	assert.deepEqual(r.errors, []);
	assert.deepEqual(g[0].candidates.map((c) => [c.npc, c.faction]), [[152, 'A'], [295, 'A']]);
	assert.equal(g[0].count, 5);
	assert.equal(g[0].npc, undefined);
	// Sell junk and repair: only NPCs that repair (Brother Danil and Jark only sell).
	assert.deepEqual(g[1], {
		t: 'vendor',
		candidates: [
			{ npc: 190, npcName: 'Dermot Johns', map: 1429, x: 47.6, y: 41.4, f: 'e', faction: 'A' },
			{ npc: 54, npcName: 'Corina Steele', map: 1429, x: 41.5, y: 65.9, f: 'e', faction: 'A' },
			{ npc: 3163, npcName: 'Uhgar', map: 1411, x: 52, y: 40.5, f: 'e', faction: 'H' },
		],
	});
	// The goblin innkeeper has no faction in npcs.json: a neutral town serves both.
	// Stranglethorn shares the continent with Elwynn, so the goblin inn ranks before Durotar's.
	assert.deepEqual(g[2].candidates.map((c) => [c.npc, c.faction]), [[295, 'A'], [6807, 'AH'], [6928, 'H']]);
	assert.equal(g[2].location, undefined);
	assert.deepEqual(g[3], { t: 'sethome', location: 'nearest' });
	// Spring Water has no Horde vendor here, but this guide also serves Horde.
	assert.deepEqual(only(r.warnings, /no vendor of item 159 for Horde/), ['test.guide:7: no vendor of item 159 for Horde in data, but this goal applies to Horde characters']);
});

test('nearest: the guide faction (and race) filters candidates; nothing usable is an error', () => {
	const alliance = goals([...head('Alliance'), 'step S', '  vendor nearest']).goals[0];
	assert.deepEqual(alliance.candidates.map((c) => c.npc), [190, 54]);
	const humans = goals([...head(null, ['race Human']), 'step S', '  vendor nearest']).goals[0];
	assert.deepEqual(humans.candidates.map((c) => c.npc), [190, 54]);
	const src = [...head('Horde'), 'step S', '  buy 159 nearest', '  buy 6948 nearest', '  vendor nearest npc 3164', '  sethome nearest @1,1'];
	assert.deepEqual(compile(`${src.join('\n')}\n`).errors, [
		'test.guide:8: `buy` found no vendor of item 159 in data for Horde characters; name one with an npc id instead',
		'test.guide:9: `buy` found no vendor of item 6948 in data for Horde characters; name one with an npc id instead',
		'test.guide:10: `nearest` picks the NPC at runtime; drop `npc`, or drop `nearest` to keep that NPC',
		'test.guide:11: smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id',
	]);
});

test('candidate sets keep one candidate per town on every map, nearest to the previous goal first', () => {
	const { data } = dataWith((raw) => {
		const npcs = raw['npcs.json'];
		const smith = (id, name, map, x, y) => {
			npcs[id] = { id, name, level: 5, faction: 'A', roles: ['repair', 'vendor'], spawns: { [map]: { f: 'e', pts: [[x, y]] } } };
		};
		// Four smiths a few yards apart in one town, three in a village far west, one in Stormwind.
		for (let i = 0; i < 4; i++) smith(90000 + i, `Town Smith ${i}`, 1429, 80 + i * 0.3, 50);
		for (let i = 0; i < 3; i++) smith(90010 + i, `Village Smith ${i}`, 1429, 20 + i * 0.3, 50);
		smith(90100, 'City Smith', 1453, 50, 50);
	});
	const ids = goals([...head('Alliance'), 'step S', '  goto 95,50', '  vendor nearest'], data).goals[1].candidates.map((c) => c.npc);
	// One per town, the town's smith nearest the previous goal first; no town is dropped for a cap.
	assert.equal(ids[0], 90003, ids.join(','));
	assert.equal(ids.filter((id) => id >= 90000 && id <= 90003).length, 1, ids.join(','));
	assert.equal(ids.filter((id) => id >= 90010 && id <= 90012).length, 1, ids.join(','));
	for (const id of [90100, 190, 54]) assert.ok(ids.includes(id), `${id} missing from ${ids.join(',')}`);
});

test('a map with only a Forever frame keeps one candidate per town too, not one per map (#299: Zephras Isle)', () => {
	const { data } = dataWith((raw) => {
		// Zephras Isle: a map Forever added, so map-frames.json has only its Forever frame.
		raw['map-frames.json'].forever = { 2521: { c: 2991, left: 4231.25, right: -1331.25, top: 4956.25, bottom: 1247.917 } };
		const npcs = raw['npcs.json'];
		const smith = (id, name, x, y) => {
			npcs[id] = { id, name, level: 5, faction: 'A', roles: ['repair', 'vendor'], spawns: { 2521: { pts: [[x, y]] } } };
		};
		// Two smiths a few yards apart in one village, one in another village 20% of the map south.
		smith(91000, 'Isle Smith A', 42.8, 23.6);
		smith(91001, 'Isle Smith B', 42.9, 23.6);
		smith(91002, 'Shen Smith', 42.0, 44.9);
	});
	const isle = goals([...head('Alliance'), 'step S', '  vendor nearest'], data).goals[0].candidates.filter((c) => c.map === 2521);
	// Both villages stay, so the engine can send a player in the southern one to its own smith;
	// placed by neither frame, every one after the first on the map was dropped.
	assert.deepEqual(isle.map((c) => c.npc).sort(), [91000, 91002], isle.map((c) => c.npcName).join(', '));
});

test('accept goals carry the quest level and prerequisites for grey-quest skipping', () => {
	const g = goals([...head('Alliance'), 'step S', '  accept 9500', '  accept 783 lvl 3']).goals;
	assert.deepEqual([g[0].qlvl, g[0].pre, g[1].qlvl, g[1].pre, g[1].minLevel], [3, [9201, 783], 1, undefined, 3]);
	const unknown = goals([...head('Alliance'), 'step S', '  accept 424242 "New"']).goals[0];
	assert.deepEqual([unknown.qlvl, unknown.pre], [undefined, undefined]);
});

test('every goal of a quest that needs a profession carries it; a Leveling guide warns on its non-optional goals unless it trains the profession first', () => {
	// Kobold Camp Cleanup (7) needs Mining 50, Wolves Across the Border (33) Mining with no level (rank 1).
	const { data } = dataWith((raw) => {
		Object.assign(raw['quests.json'][7], { skill: 186, skillLevel: 50, pre: [] });
		Object.assign(raw['quests.json'][33], { skill: 186 });
	});
	const src = (category, lines) => [...head('Alliance', [`category ${category}`]), 'step S', ...lines];
	const steps = ['  accept 7', '  kill 6 quest 7', '  turnin 7 optional', '  accept 33 optional', '  accept 9500'];
	const { r, goals: g } = goals(src('Leveling', steps), data);
	assert.deepEqual(
		g.map((x) => [x.t, x.profLine, x.profName, x.profRank]),
		[['accept', 186, 'Mining', 50], ['kill', 186, 'Mining', 50], ['turnin', 186, 'Mining', 50], ['accept', 186, 'Mining', 1], ['accept', undefined, undefined, undefined]],
	);
	const text = `${src('Leveling', steps).join('\n')}\n`;
	const warned = only(r.warnings, /needs Mining/);
	assert.deepEqual(warned, [
		`test.guide:${lineOf(text, 'accept 7')}: quest 7 (Kobold Camp Cleanup) needs Mining 50, and the guide does not train it before here: characters without it never see this goal`,
		`test.guide:${lineOf(text, 'kill 6 quest 7')}: quest 7 (Kobold Camp Cleanup) needs Mining 50, and the guide does not train it before here: characters without it never see this goal`,
	]);
	// Trained earlier in the guide (levelled to the quest's rank above 1), or another category: no warning.
	const warns = (category, lines) => only(goals(src(category, lines), data).r.warnings, /needs Mining/).length;
	assert.equal(warns('Leveling', ['  train Mining', '  accept 33']), 0);
	assert.equal(warns('Leveling', ['  train Mining', '  accept 7']), 1);
	assert.equal(warns('Leveling', ['  skill Mining 50', '  accept 7']), 0);
	assert.equal(warns('Class', steps), 0);
	// The Core's registry takes the new fields.
	const pack = compile(text.replace(/^guide t\//, 'guide test/'), data, { pack: 'test' });
	const file = path.join(writeTestPack(pack.guides, data).dir, 'Guides.lua');
	assert.match(fs.readFileSync(file, 'utf8'), /profLine = 186, profName = "Mining", profRank = 50/);
	const [out] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `
			${TEST_PACK}
			local results = {}
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) local ok, e = real(g); results[#results + 1] = ok and "ok" or e; return ok, e end
			assert(loadfile(${JSON.stringify(file)}))("Polestar_Guides", {})
			emit({ results = results })`,
	}).emitted;
	assert.deepEqual(out.results, ['ok']);
});

test('smart goals emit Lua the real engine registry accepts, and round-trip', () => {
	const src = [...head(null), 'step S', '  train Mining', '  train class', '  buy 159 nearest', '  vendor nearest', '  sethome nearest', '  accept 9500'];
	const r = compile(`${src.join('\n')}\n`.replace(/^guide t\//, 'guide test/'), undefined, { pack: 'test' });
	assert.deepEqual(r.errors, []);
	const file = path.join(writeTestPack(r.guides).dir, 'Guides.lua');
	const lua = fs.readFileSync(file, 'utf8');
	assert.match(lua, /\{ t = "train", class = true, candidates = \{ \{ npc = 911, npcName = "Llane Beshere", map = 1429, x = 50\.2, y = 42\.3, f = "e", faction = "A", classes = \{ "WARRIOR" \} \}/);
	assert.match(lua, /\{ t = "accept", quest = 9500, title = "Either Way", npc = 823, npcName = "Deputy Willem", minLevel = 1, qlvl = 3, pre = \{ 9201, 783 \},/);
	const [out] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `
			${TEST_PACK}
			local got, results = nil, {}
			local real = Polestar.RegisterGuide
			Polestar.RegisterGuide = function(g) got = g; local ok, e = real(g); results[#results + 1] = ok and "ok" or e; return ok, e end
			assert(loadfile(${JSON.stringify(file)}))("Polestar_Guides", {})
			emit({ results = results, guide = got })`,
	}).emitted;
	assert.deepEqual(out.results, ['ok']);
	assert.deepEqual(out.guide, plain(r.guides[0]));
});

test('trainers build: guide goals, recordings and the curated list, verified and deterministic', async () => {
	const guides = tmpdir();
	fs.writeFileSync(
		path.join(guides, 'a.guide'),
		guideText(['step S', '  train 3153 only Warrior', '  train 198 only Mage', '  train 911 only Warrior,Paladin', '  train 2329', 'step T', '  only Rogue', '  train 152']),
	);
	const recordings = tmpdir();
	const session = (cls, events) => ({ schema: 1, char: { name: 'T', class: cls }, events });
	fs.writeFileSync(path.join(recordings, 'a.json'), JSON.stringify(session('MAGE', [{ t: 1, e: 'trainer', npc: 5479, npcName: 'Wu Shen' }, { t: 2, e: 'trainer', npc: 3175 }, { t: 3, e: 'trainer', npc: 6928 }])));
	fs.writeFileSync(path.join(recordings, 'b.json'), JSON.stringify(session('WARRIOR', [{ t: 1, e: 'trainer', npc: 6928 }])));
	const data = tmpdir();
	for (const f of fs.readdirSync(DATA_DIR)) fs.copyFileSync(path.join(DATA_DIR, f), path.join(data, f));
	const lua = path.join(tmpdir(), 'ClassTrainers.lua');
	const args = ['build', '--guides', guides, '--data', data, '--recordings', recordings, '--lua', lua];
	const { result, out } = await quiet(() => trainersCmd.run(args));
	assert.equal(result, 0, out);
	assert.match(out, /curated WARRIOR trainer "Lyria Du Lac" not found on map 1429/);
	const first = fs.readFileSync(path.join(data, 'trainers.json'), 'utf8');
	const t = JSON.parse(first);
	assert.deepEqual(
		Object.values(t).map((x) => [x.id, x.classes, x.sources]),
		[
			[152, ['ROGUE'], ['guide']], // step-level `only Rogue`
			[198, ['MAGE'], ['curated', 'guide']],
			[911, ['WARRIOR'], ['curated']], // the two-class goal is ignored
			[3153, ['WARRIOR'], ['curated', 'guide']],
			[5479, ['WARRIOR', 'MAGE'], ['curated', 'record']],
		],
	);
	// 3175 is a profession trainer and 6928 was opened by two classes: neither is a class trainer.
	assert.ok(!t[3175] && !t[6928] && !t[2329]);
	await quiet(() => trainersCmd.run(args));
	assert.equal(fs.readFileSync(path.join(data, 'trainers.json'), 'utf8'), first);
	assert.equal((await quiet(() => trainersCmd.run(['rebuild']))).result, 2);
	// The Lua registers each trainer where it stands, with the frames to place
	// it: the training reminder picks the nearest one of the character's class.
	const nearest = (race, faction, map, x, y) =>
		runAddon({
			stubs: ['stub_world.lua'],
			before: `stub.world.race, stub.world.faction, stub.world.class = "${race}", "${faction}", "WARRIOR"; stub.world.moveTo(${map}, ${x}, ${y})`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			script: `assert(loadfile(${JSON.stringify(lua)}))("Polestar", Polestar)\nstub.login()\nlocal t = Polestar.Engine.NearestClassTrainer()\nemit({ npc = t and t.npc, faction = t and t.faction })`,
		}).emitted[0];
	assert.deepEqual(nearest('Human', 'Alliance', 1429, 48, 42), { npc: 911, faction: 'A' });
	assert.deepEqual(nearest('Orc', 'Horde', 1411, 43, 68), { npc: 3153, faction: 'H' });
});

test('trainers build reads the pack guides only: Recorder drafts and dist/ are skipped', async () => {
	const guides = tmpdir();
	fs.writeFileSync(path.join(guides, 'a.guide'), guideText(['step S', '  train 152 only Rogue']));
	// 3175 is a profession trainer: a draft's `only Warrior` must not make it a class trainer.
	for (const dir of ['drafts', 'dist']) {
		fs.mkdirSync(path.join(guides, dir));
		fs.writeFileSync(path.join(guides, dir, 'x.guide'), guideText(['step S', '  train 3175 only Warrior']));
	}
	const data = tmpdir();
	for (const f of fs.readdirSync(DATA_DIR)) fs.copyFileSync(path.join(DATA_DIR, f), path.join(data, f));
	const args = ['build', '--guides', guides, '--data', data, '--recordings', tmpdir(), '--lua', path.join(tmpdir(), 'ClassTrainers.lua')];
	const { result, out } = await quiet(() => trainersCmd.run(args));
	assert.equal(result, 0, out);
	assert.match(out, /from guides 1 goals/);
	const t = JSON.parse(fs.readFileSync(path.join(data, 'trainers.json'), 'utf8'));
	assert.deepEqual(t[152] && t[152].sources, ['guide']);
	assert.ok(!t[3175]);
});

test('every Era-frame coordinate in an emitted pack, candidates included, has its map frame registered', () => {
	// A Durotar guide whose trainer candidates stand in Elwynn, Stormwind and
	// Dun Morogh: those maps' frames must ship too, or the engine cannot place them.
	const durotar = `${['guide t/d', 'title D', 'levels 1-60', 'zone Durotar', '', 'step S', '  train First Aid Apprentice', '  train Mining', '  train class', '  vendor nearest', '  sethome nearest'].join('\n')}\n`;
	const fixtureGuides = require('../tools/lib/dsl/project').findGuideFiles(require('./helpers/dsl').GUIDES_DIR);
	const sources = { 'd.guide': durotar };
	for (const f of fixtureGuides) sources[f] = fs.readFileSync(path.join(require('./helpers/dsl').GUIDES_DIR, f), 'utf8');
	const r = compile(sources);
	assert.deepEqual(r.errors, []);
	const { files, scripts: order } = writeTestPack(r.guides);
	const [out] = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua'] }],
		script: `
			local frames, guides = {}, {}
			Polestar.RegisterPack = function() end
			Polestar.RegisterMapFrames = function(t) for k, v in pairs(t.era) do frames[k] = v end end
			Polestar.RegisterGuide = function(g) guides[#guides + 1] = g end
			for _, f in ipairs({ ${order.map((f) => JSON.stringify(f)).join(', ')} }) do assert(loadfile(f))("Polestar_Guides", {}) end
			local missing, era, seen = {}, 0, {}
			local function walk(t, where)
				if seen[t] then return end
				seen[t] = true
				if t.f == "e" then
					era = era + 1
					if not frames[t.map] then missing[#missing + 1] = where .. " map " .. tostring(t.map) end
				end
				for k, v in pairs(t) do if type(v) == "table" then walk(v, where .. "." .. tostring(k)) end end
			end
			for _, g in ipairs(guides) do walk(g, g.id) end
			local candidateMaps = {}
			for _, g in ipairs(guides) do
				if g.id == "t/d" then
					for _, goal in ipairs(g.steps[1].goals) do
						for _, c in ipairs(goal.candidates or {}) do candidateMaps[c.map] = true end
					end
				end
			end
			local maps = {}
			for m in pairs(candidateMaps) do maps[#maps + 1] = m end
			table.sort(maps)
			emit({ missing = table.concat(missing, "; "), era = era, candidateMaps = maps })`,
	}).emitted;
	assert.equal(out.missing, '');
	assert.ok(out.era > 20, String(out.era));
	// The repro's shape: candidates on maps other than the guide's own zone.
	assert.ok(out.candidateMaps.includes(1429) && out.candidateMaps.includes(1426), out.candidateMaps.join(','));
	assert.match(files['MapFrames.lua'], /\[1426\] = /);
});
