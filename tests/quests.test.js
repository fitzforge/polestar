'use strict';
// Polestar.QuestDB at runtime (addon/Polestar/Quests) on a database built by
// `questdb build` from tests/fixtures/questdb: load-on-demand, lookups,
// available-quest filtering (prerequisites, level, race, class, faction,
// exclusive groups, holidays), objective and turn-in markers through the
// Pins contract, tooltip lines, nameplate icons, and that an unchanged quest
// log costs no rebuild.

const { test, before } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { buildQuestDB, writeQuestDB } = require('../tools/lib/questdb/build');
const { tmpdir } = require('./helpers/tmp');

const FIX = path.join(__dirname, 'fixtures', 'questdb');
let dbFiles;

before(() => {
	const out = tmpdir('polestar-questdb-');
	writeQuestDB(buildQuestDB({ dataDir: FIX }), out);
	dbFiles = ['MapFrames.lua', 'Quests.lua', 'Npcs.lua', 'Objects.lua', 'Items.lua'].map((f) => path.join(out, f));
});

const lua = (s) => JSON.stringify(s);

// The map marker layers are off by default; these tests exercise them, so the
// default saved profile turns them on.
const MARKERS_ON = 'PolestarDB = { schema = 1, settings = { qol = { mapObjectives = true, minimapObjectives = true, objectiveAreas = true, turnInMarkers = true, availableQuests = true } } }';

// Loads the full addon with the fake Pins installed, logs in, runs `script`.
function run(script, { setup = '', saved = { Polestar: MARKERS_ON } } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_quests.lua'],
		before: `
stub.quests.dbFiles = { ${dbFiles.map(lua).join(', ')} }
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 40)
for q, t in pairs({ [7] = "Kobold Camp Cleanup", [18] = "Gathering Wood", [33] = "Wolves Across the Border", [60] = "Kobold Candles" }) do w.titles[q] = t end
${setup}`,
		addons: ['Polestar'],
		saved,
		script: `
local w, sq, Q = stub.world, stub.quests, Polestar.QuestDB
sq.installPins()
stub.login()
stub.advance(0.3)
local function layer(name) local l = sq.pins.layers[name]; return l and l.pins or {} end
local function kinds(name)
	local out = {}
	for _, p in ipairs(layer(name)) do out[#out + 1] = p.header .. "@" .. p.x .. "," .. p.y .. ":" .. p.icon end
	table.sort(out)
	return out
end
${script}`,
	}).emitted;
}

test('loads the database at login and answers lookups', () => {
	const [loaded, q7, npc, mobs, droppers, item, frame] = run(`
emit({ Q.IsLoaded(), sq.loadCalls })
emit(Q.GetQuest(7))
emit(Q.GetNpc(6))
emit(Q.GetObjectiveMobs(60, 1))
emit(Q.GetItemDroppers(772))
emit(Q.GetItem(772))
emit(Polestar.MapFrames.era[1429])
`);
	assert.deepEqual(loaded, [true, 1]);
	assert.equal(q7.title, 'Kobold Camp Cleanup');
	assert.equal(q7.faction, 'Alliance');
	assert.deepEqual(q7.pre, [783]);
	assert.deepEqual(q7.start.npc, [197]);
	assert.deepEqual(q7.objectives, [{ kind: 'kill', id: 6, count: 10 }]);
	assert.equal(npc.name, 'Kobold Vermin');
	assert.equal(npc.spawns.length, 3, 'two camps east and one far camp, one cluster each');
	assert.ok(npc.spawns.every((s) => s.map === 1429 && s.f === 'e' && s.r >= 0));
	assert.deepEqual(mobs, ['Kobold Vermin', 'Kobold Miner'], 'droppers, best chance first');
	assert.deepEqual(droppers.map((d) => [d.id, d.chance]), [[6, 40], [40, 20.5]]);
	assert.deepEqual(item.objects, [{ id: 77, name: 'Candle Crate', chance: 100 }]);
	assert.deepEqual(item.vendors, [{ id: 253, name: 'William Pestle' }]);
	assert.deepEqual(frame, { c: 0, left: 1500, right: -1500, top: 500, bottom: -1500 });
});

test('HandsOver answers from the quest\'s handed-over items; a record without them (an older database) or an unknown quest says no, without an error', () => {
	const [answers] = run('emit({ Q.HandsOver(19, 772), Q.HandsOver(19, 900), Q.HandsOver(19, 1), Q.HandsOver(7, 772), Q.HandsOver(99999, 772) })');
	assert.deepEqual(answers, [true, true, false, false, false]);
});

test('does not load the database when qol.questDB is off', () => {
	const [state] = run('local c = {}; for _, call in ipairs(sq.pins.calls) do if call[2]:find("^quests%.") then c[#c + 1] = call end end; emit({ Q.IsLoaded(), sq.loadCalls, Q.IsRunning(), #c })', {
		saved: { Polestar: 'PolestarDB = { schema = 1, settings = { qol = { questDB = false } } }' },
	});
	assert.deepEqual(state, [false, 0, false, 0]);
});

test('available quests honour prerequisites, level, race, class, faction, exclusive groups and holidays', () => {
	const [start, after783, at10, lowLevel, reasons, markers] = run(`
emit(Q.GetAvailableQuests())
w.turnIn(783)                       -- unlocks 7 (pre 783)
stub.advance(0.3)
emit(Q.GetAvailableQuests())
w.setLevel(10)                      -- 10 opens up; level <= 4 quests turn grey
stub.advance(0.3)
emit(Q.GetAvailableQuests())
Polestar.Set("qol.lowLevelQuests", true)
stub.advance(0.3)
emit(Q.GetAvailableQuests())
emit({ Q.WhyUnavailable(5), Q.WhyUnavailable(9), Q.WhyUnavailable(13), Q.WhyUnavailable(12), Q.WhyUnavailable(14), Q.WhyUnavailable(19) })
emit(kinds("quests.available"))
`, { setup: 'w.complete({ 15 })' });
	// 14 is exclusive with completed 15; 19 needs 33 or 60; 17 starts from an item.
	assert.deepEqual(start, [16, 18, 33, 783], 'level 1: 7 needs 783, 60 needs level 2');
	assert.deepEqual(after783, [7, 16, 18, 33]);
	assert.deepEqual(at10, [10], 'everything else is grey at level 10');
	assert.deepEqual(lowLevel, [7, 10, 16, 18, 33, 60]);
	assert.deepEqual(reasons, ['eligibility', 'eligibility', 'eligibility', 'eligibility', 'exclusive', 'prerequisite']);
	assert.deepEqual(markers, [
		'Eagan Peltskinner@48.9,40.2:icon-accept',
		'Marshal McBride@48.9,41.6:icon-accept',
		'Wanted Poster@50,50:icon-accept',
		'William Pestle@43.3,65.7:icon-accept',
	]);
});

test('prerequisites are any-of', () => {
	const [before33, after33] = run(`
emit(Q.IsAvailable(19))
w.turnIn(33)
stub.advance(0.3)
emit(Q.IsAvailable(19))
`, { setup: 'w.setLevel(3)' });
	assert.equal(before33, false);
	assert.equal(after33, true);
});

test('a turn-in or accept rechecks only the quests it can unlock or close, and agrees with a full scan', () => {
	const [full, turnIn, accept, same] = run(`
local function checks(fn)
	local before = Q.stats.availableChecks
	fn()
	stub.advance(0.3)
	return Q.stats.availableChecks - before
end
emit(checks(function() w.setLevel(3) end))       -- a level-up rechecks every candidate
emit(checks(function() w.turnIn(33) end))         -- 19 needs 33
emit(checks(function() w.accept(18, {}, "Gathering Wood") end))
local incremental = Q.GetAvailableQuests()
Q.Stop(); Q.Start(); Q.Flush()
emit(table.concat(incremental, ",") == table.concat(Q.GetAvailableQuests(), ","))
`);
	assert.ok(full > 3, `a full scan checks every candidate (${full})`);
	assert.ok(turnIn < full && turnIn >= 1, `turn-in: ${turnIn} of ${full}`);
	assert.ok(accept < full && accept >= 1, `accept: ${accept} of ${full}`);
	assert.equal(same, true, 'the incremental set equals a fresh scan');
});

test('Horde characters see Horde quests, not Alliance ones', () => {
	const [list] = run('emit(Q.GetAvailableQuests())', { setup: 'w.faction = "Horde"; w.race = "Orc"; w.raceName = "Orc"' });
	assert.ok(list.includes(9));
	assert.ok(!list.includes(783) && !list.includes(33));
	assert.ok(list.includes(16), 'object-started quests have no faction');
});

// The fixture plus quests shaped like the QuestieDB merge: 9400 is Human-only
// (Forever mask 1), 9401 High Order Skyborne-only (2^32), 9402 an Era mask
// (pfQuest only, Human), 9403 a Horde quest for Windshaper Skyborne only
// (2^33); 9410 lists only breadcrumbs in `pre`; 9411 needs 783 and 33
// (preAll); 9412 either (preAny); 9420 is level 9 with no minimum level.
function extraDb() {
	const dir = tmpdir('polestar-questdb-extra-');
	for (const f of fs.readdirSync(FIX)) fs.copyFileSync(path.join(FIX, f), path.join(dir, f));
	const quests = JSON.parse(fs.readFileSync(path.join(FIX, 'quests.json'), 'utf8'));
	const base = quests[783];
	const q = (id, extra) => ({ ...base, id, title: `Quest ${id}`, source: ['questie-forever'], ...extra });
	Object.assign(quests, {
		9400: q(9400, { races: 1 }),
		9401: q(9401, { races: 2 ** 32 }),
		9402: q(9402, { races: 1, source: ['pfquest'] }),
		9403: { ...quests[9], id: 9403, title: 'Quest 9403', source: ['questie-forever'], races: 2 ** 33 },
		9410: q(9410, { pre: [9413], breadcrumbs: [9413] }),
		9413: q(9413, { breadcrumbFor: 9410 }),
		9411: q(9411, { pre: [783, 33], preAll: [783, 33] }),
		9412: q(9412, { pre: [783, 33], preAny: [783, 33] }),
		9420: q(9420, { level: 9, minLevel: 1 }),
	});
	fs.writeFileSync(path.join(dir, 'quests.json'), JSON.stringify(quests));
	const out = tmpdir('polestar-questdb-');
	writeQuestDB(buildQuestDB({ dataDir: dir }), out);
	return ['MapFrames.lua', 'Quests.lua', 'Npcs.lua', 'Objects.lua', 'Items.lua'].map((f) => path.join(out, f));
}

test('Skyborne: the race mask\'s high bits decide; Era-only masks never exclude it', () => {
	const files = extraDb();
	const check = 'emit({ Q.WhyUnavailable(9400) or "ok", Q.WhyUnavailable(9401) or "ok", Q.WhyUnavailable(9402) or "ok", Q.WhyUnavailable(9403) or "ok" })';
	const db = `stub.quests.dbFiles = { ${files.map(lua).join(', ')} }`;
	const [sky] = run(check, { setup: `${db}; w.race = "Skyborne"; w.raceName = "High Order Skyborne"` });
	assert.deepEqual(sky, ['eligibility', 'ok', 'ok', 'eligibility'], 'Human-only is not for Skyborne; High Order-only is; an Era mask stays open; Horde never');
	const [human] = run(check, { setup: db });
	assert.deepEqual(human, ['ok', 'eligibility', 'ok', 'eligibility']);
	const [wind] = run(check, { setup: `${db}; w.faction = "Horde"; w.race = "Skyborne"; w.raceName = "Windshaper Skyborne"` });
	assert.deepEqual(wind, ['eligibility', 'eligibility', 'eligibility', 'ok'], 'Windshaper (2^33) takes its own quest, not High Order\'s (2^32) or Alliance ones');
	const [orc] = run(check, { setup: `${db}; w.faction = "Horde"; w.race = "Orc"; w.raceName = "Orc"` });
	assert.deepEqual(orc[3], 'eligibility', 'a Skyborne-only mask excludes Era races');
	const [list] = run('emit(Q.GetAvailableQuests())', { setup: `${db}; w.race = "Skyborne"; w.raceName = "High Order Skyborne"` });
	assert.ok(list.includes(9401) && !list.includes(9400) && !list.includes(9403), 'the giver markers follow the same filter');
});

test('prerequisites: breadcrumbs never block, preAll needs every one, preAny one', () => {
	const files = extraDb();
	const [before, after783, after33] = run(`
emit({ Q.WhyUnavailable(9410) or "ok", Q.WhyUnavailable(9411) or "ok", Q.WhyUnavailable(9412) or "ok" })
w.turnIn(783); stub.advance(0.3)
emit({ Q.WhyUnavailable(9411) or "ok", Q.WhyUnavailable(9412) or "ok" })
w.turnIn(33); stub.advance(0.3)
emit({ Q.WhyUnavailable(9411) or "ok" })
`, { setup: `stub.quests.dbFiles = { ${files.map(lua).join(', ')} }` });
	assert.deepEqual(before, ['ok', 'prerequisite', 'prerequisite']);
	assert.deepEqual(after783, ['prerequisite', 'ok']);
	assert.deepEqual(after33, ['ok']);
});

test('objective markers follow progress and become a turn-in marker when ready', () => {
	const [accepted, tooltip, partial, ready, gone] = run(`
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
emit(kinds("quests.objectives"))
emit(sq.pinTooltip(layer("quests.objectives")[1]))
w.progress(7, 1, 4)
stub.advance(0.3)
emit(sq.pinTooltip(layer("quests.objectives")[1]))
w.progress(7, 1, 10)
stub.advance(0.3)
emit({ kinds("quests.objectives"), kinds("quests.turnin"), sq.pins.layers["quests.turnin"].opts })
w.turnIn(7)
stub.advance(0.3)
emit({ sq.pins.layers["quests.objectives"] == nil, sq.pins.layers["quests.turnin"] == nil })
`, { setup: 'w.complete({ 783 })' });
	assert.deepEqual(accepted, [
		'Kobold Vermin@47.8,35.8:icon-kill',
		'Kobold Vermin@50.3,35.8:icon-kill',
		'Kobold Vermin@70.3,70.2:icon-kill',
	]);
	assert.deepEqual(tooltip, ['Kobold Vermin', 'Kobold Camp Cleanup', '  Kobold Vermin: 0/10']);
	assert.deepEqual(partial, ['Kobold Vermin', 'Kobold Camp Cleanup', '  Kobold Vermin: 4/10']);
	assert.deepEqual(ready[0], {}, 'no objective markers once complete');
	assert.deepEqual(ready[1], ['Marshal McBride@48.9,41.6:icon-turnin']);
	assert.deepEqual(ready[2], { world: true, minimap: true, edge: false, scale: 1 });
	assert.deepEqual(gone, [true, true]);
});

// The fixture plus quests whose objective names overlap: 9500 needs Kobold
// Vermin (6) and Kobold Vermin Runt (9500), a name containing the other;
// 9501 needs 6 and 9501, a second NPC also named Kobold Vermin; 9502 the
// same two, 8 of one and 5 of the other.
function overlapDb() {
	const dir = tmpdir('polestar-questdb-overlap-');
	for (const f of fs.readdirSync(FIX)) fs.copyFileSync(path.join(FIX, f), path.join(dir, f));
	const quests = JSON.parse(fs.readFileSync(path.join(FIX, 'quests.json'), 'utf8'));
	const npcs = JSON.parse(fs.readFileSync(path.join(FIX, 'npcs.json'), 'utf8'));
	const npc = (id, name, pts) => ({ ...npcs[6], id, name, spawns: { 1429: { f: 'e', pts } } });
	npcs[9500] = npc(9500, 'Kobold Vermin Runt', [[20, 20], [20.4, 20.3]]);
	npcs[9501] = npc(9501, 'Kobold Vermin', [[30, 80], [30.4, 80.3]]);
	const kill = (id, count, text) => ({ type: 'kill', id, count, text });
	const q = (id, objectives) => ({ ...quests[7], id, title: `Quest ${id}`, pre: [], objectives });
	quests[9500] = q(9500, [kill(6, 8, 'Kobold Vermin'), kill(9500, 5, 'Kobold Vermin Runt')]);
	quests[9501] = q(9501, [kill(6, 8, 'Kobold Vermin'), kill(9501, 8, 'Kobold Vermin')]);
	quests[9502] = q(9502, [kill(6, 8, 'Kobold Vermin'), kill(9501, 5, 'Kobold Vermin')]);
	fs.writeFileSync(path.join(dir, 'quests.json'), JSON.stringify(quests));
	fs.writeFileSync(path.join(dir, 'npcs.json'), JSON.stringify(npcs));
	const out = tmpdir('polestar-questdb-');
	writeQuestDB(buildQuestDB({ dataDir: dir }), out);
	return ['MapFrames.lua', 'Quests.lua', 'Npcs.lua', 'Objects.lua', 'Items.lua'].map((f) => path.join(out, f));
}

// Progress of quest q's objective on NPC `npc`: "cur/max" plus "done".
const PROGRESS = `
local function prog(q, npc)
	for _, o in ipairs(Q._index.npc[npc] or {}) do
		if o.q == q then return o.cur .. "/" .. o.max .. (o.done and " done" or "") end
	end
	return "none"
end`;

test('one client line per objective: an exact name beats a name inside another, the longest name searches first, leftovers pair last', () => {
	const files = overlapDb();
	const [exact, later, substring, position] = run(`${PROGRESS}
w.accept(9500, { { text = "Kobold Vermin Runt slain: 5/5", required = 5, fulfilled = 5 }, { text = "Kobold Vermin slain: 0/8", required = 8 } })
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500), kinds("quests.objectives") })
w.progress(9500, 2, 3)
stub.advance(0.3)
w.progress(9500, 2, 4)
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
w.abandon(9500)
stub.advance(0.3)
w.accept(9500, { { text = "Slay Kobold Vermin Runts: 1/5", required = 5, fulfilled = 1 }, { text = "Slay Kobold Vermin: 2/8", required = 8, fulfilled = 2 } })
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
w.abandon(9500)
stub.advance(0.3)
w.accept(9500, { { text = "Kobold Vermin Runt slain: 5/5", required = 5, fulfilled = 5 }, { text = "Vermines tuées : 2/8", required = 8, fulfilled = 2 } })
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
`, { setup: `stub.quests.dbFiles = { ${files.map(lua).join(', ')} }` });
	assert.deepEqual(exact[0], '0/8', '"Kobold Vermin" is not read from the Runt line');
	assert.deepEqual(exact[1], '5/5 done');
	assert.deepEqual(exact[2], [
		'Kobold Vermin@47.8,35.8:icon-kill',
		'Kobold Vermin@50.3,35.8:icon-kill',
		'Kobold Vermin@70.3,70.2:icon-kill',
	], 'the unfinished objective keeps its markers; the finished Runts have none');
	assert.deepEqual(later, ['4/8', '5/5 done'], 'repeated scans keep the assignment');
	assert.deepEqual(substring, ['2/8', '1/5'], 'the longer name claims its line before the shorter one can');
	assert.deepEqual(position, ['2/8', '5/5 done'], 'an unmatched objective takes the line left over, never a claimed one');
});

test('objectives of one name take one line each, in order, and share the only one the client shows', () => {
	const files = overlapDb();
	const [two, one] = run(`${PROGRESS}
w.accept(9501, { { text = "Kobold Vermin slain: 8/8", required = 8, fulfilled = 8 }, { text = "Kobold Vermin slain: 3/8", required = 8, fulfilled = 3 } })
stub.advance(0.3)
emit({ prog(9501, 6), prog(9501, 9501) })
w.abandon(9501)
stub.advance(0.3)
w.accept(9501, { { text = "Kobold Vermin slain: 3/8", required = 8, fulfilled = 3 } })
stub.advance(0.3)
emit({ prog(9501, 6), prog(9501, 9501) })
`, { setup: `stub.quests.dbFiles = { ${files.map(lua).join(', ')} }` });
	assert.deepEqual(two, ['8/8 done', '3/8']);
	assert.deepEqual(one, ['3/8', '3/8']);
});

test('lines of counts alone are matched again when their names arrive, though the line count stays', () => {
	const files = overlapDb();
	const [early, named, later] = run(`${PROGRESS}
w.accept(9500, { { text = " slain: 0/5", required = 5 }, { text = ": 0/8", required = 8 } })
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
local lines = w.log[9500].objectives
lines[1].text, lines[2].text = "Kobold Vermin Runt slain: 0/5", "Kobold Vermin slain: 0/8"
w.progress(9500, 1, 2)
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
w.progress(9500, 2, 3)
stub.advance(0.3)
emit({ prog(9500, 6), prog(9500, 9500) })
`, { setup: `stub.quests.dbFiles = { ${files.map(lua).join(', ')} }` });
	assert.deepEqual(early, ['0/5', '0/8'], 'nameless lines pair by position for now');
	assert.deepEqual(named, ['0/8', '2/5'], 'the names re-pair the lines: the Runts\' count is not read as the Vermin\'s');
	assert.deepEqual(later, ['3/8', '2/5']);
});

test('objectives of one name take the line requiring their own count before database order', () => {
	const files = overlapDb();
	const [split] = run(`${PROGRESS}
w.accept(9502, { { text = "Kobold Vermin slain: 1/5", required = 5, fulfilled = 1 }, { text = "Kobold Vermin slain: 2/8", required = 8, fulfilled = 2 } })
stub.advance(0.3)
emit({ prog(9502, 6), prog(9502, 9501) })
`, { setup: `stub.quests.dbFiles = { ${files.map(lua).join(', ')} }` });
	assert.deepEqual(split, ['2/8', '1/5']);
});

test('a turn-in the client never lists counts as done only for a short while, and not past a stop', () => {
	const script = (restart) => `
w.turnIn(783)
w.completed[783] = nil              -- a repeatable: the client never lists it
stub.advance(0.3)
emit({ Q.GetAvailableQuests(), kinds("quests.available") })
${restart ? 'Q.Stop(); Q.Start(); Q.Flush()' : 'stub.advance(10)'}
emit({ Q.GetAvailableQuests(), kinds("quests.available") })`;
	for (const setup of ['', 'C_QuestLog.GetAllCompletedQuestIDs = nil']) {
		const [before] = run('emit({ Q.GetAvailableQuests(), kinds("quests.available") })', { setup });
		for (const restart of [false, true]) {
			const [bridged, after] = run(script(restart), { setup });
			const label = `${setup || 'bulk list'}${restart ? ', restarted' : ''}`;
			assert.ok(bridged[0].includes(7) && !bridged[0].includes(783), `${label}: done during the window`);
			assert.deepEqual(after, before, `${label}: offered again afterwards, its follow-up closed`);
		}
	}
});

test('a turn-in counts as done before the client\'s completed flag catches up, and only for that quest', () => {
	const turnIn = (lag) => `
w.turnIn(783)
${lag ? 'w.completed[783] = nil              -- the client has not listed it yet' : ''}
stub.advance(0.3)
emit({ Q.GetAvailableQuests(), Q.WhyUnavailable(783) or "ok", kinds("quests.available") })
w.completed[783] = true
stub.fire("QUEST_LOG_UPDATE")
stub.advance(0.3)
emit({ Q.GetAvailableQuests(), kinds("quests.available") })`;
	for (const setup of ['', 'C_QuestLog.GetAllCompletedQuestIDs = nil']) {
		const [now, later] = run(turnIn(false), { setup });
		const [lagNow, lagLater] = run(turnIn(true), { setup });
		assert.ok(now[0].includes(7) && !now[0].includes(783), 'the fixture: 783 unlocks 7');
		assert.deepEqual(lagNow, now, `${setup || 'bulk list'}: 783 done and 7 open at once, nothing else moves`);
		assert.deepEqual(lagLater, later, `${setup || 'bulk list'}: unchanged once the client catches up`);
		assert.deepEqual(lagLater, lagNow.filter((_, i) => i !== 1));
	}
});

test('item, object and event objectives mark their sources; shared clusters carry one pin', () => {
	const [candles, wood, mapIndex] = run(`
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local pins = {}
for _, p in ipairs(layer("quests.objectives")) do pins[#pins + 1] = p.header .. ":" .. p.icon .. ":" .. #p.refs end
table.sort(pins)
emit(pins)
w.abandon(60); w.abandon(7)
w.accept(18, { { text = "Bundle of Wood: 0/1", type = "object", required = 1 }, { text = "Scout the farm", type = "event", required = 1 } })
stub.advance(0.3)
emit(kinds("quests.objectives"))
emit(#Q.GetMarkers(1429, "objectives"))
`, { setup: 'w.complete({ 783 }); w.setLevel(4)' });
	// Kobold Vermin is killed for 7 and drops candles for 60: one pin per
	// cluster with both objectives, under the kill glyph (the higher rank).
	assert.deepEqual(candles, [
		'Candle Crate:icon-collect:1',
		'Kobold Miner:icon-collect:1',
		'Kobold Vermin:icon-kill:2',
		'Kobold Vermin:icon-kill:2',
		'Kobold Vermin:icon-kill:2',
		'William Pestle:icon-vendor:1',
	]);
	assert.deepEqual(wood, ['Bundle of Wood@30.2,30.1:icon-interact', 'Gathering Wood@40.5,70.3:icon-explore']);
	assert.equal(mapIndex, 2);
});

test('after a rebuild a cluster two quests shared shows only the quest still needing it', () => {
	const [shared, after, tip] = run(`
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local function vermin()
	local out = {}
	for _, p in ipairs(layer("quests.objectives")) do
		if p.header == "Kobold Vermin" then out[#out + 1] = p.icon .. ":" .. #p.refs end
	end
	table.sort(out)
	return out
end
emit(vermin())
w.progress(7, 1, 10)                -- 7's kill objective is done: only 60's candles still need the kobolds
stub.advance(0.3)
emit(vermin())
for _, p in ipairs(layer("quests.objectives")) do
	if p.header == "Kobold Vermin" then emit(sq.pinTooltip(p)) break end
end
`, { setup: 'w.complete({ 783 }); w.setLevel(4)' });
	assert.deepEqual(shared, ['icon-kill:2', 'icon-kill:2', 'icon-kill:2']);
	assert.deepEqual(after, ['icon-collect:1', 'icon-collect:1', 'icon-collect:1'], 'the kill glyph and the done quest are gone');
	assert.ok(tip.some((l) => /Kobold Candles/.test(l)) && !tip.some((l) => /Kobold Camp Cleanup/.test(l)), JSON.stringify(tip));
});

// The suite's quest line: Hooks.AddLine
// with "<Quest>:" left in the quest colour and "<what> cur/max" right in
// textDim, success once done. The stub tooltip joins the halves with " | ".
test('a mob two quests need names both quests and your progress on its tooltip', () => {
	const [lines, item, startItem, colours, off, secret] = run(`
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
w.progress(7, 1, 3)
stub.advance(0.3)
emit(sq.hoverUnit(6))
emit(sq.hoverItem(772))
emit(sq.hoverItem(1972))
w.progress(7, 1, 10)
stub.advance(0.3)
local seen = {}
local add = GameTooltip.AddDoubleLine
GameTooltip.AddDoubleLine = function(self, l, r, lr, lg, lb, rr, rg, rb)
	seen[#seen + 1] = { l, { lr, lg, lb }, { rr, rg, rb } }
	return add(self, l, r)
end
sq.hoverUnit(6)
GameTooltip.AddDoubleLine = add
local function same(c, name) local t = Q.Color(name); return c[1] == t.r and c[2] == t.g and c[3] == t.b end
emit({ same(seen[1][2], "quest"), same(seen[1][3], "success"), same(seen[2][2], "quest"), same(seen[2][3], "textDim") })
Polestar.Set("qol.questTooltips", false)
emit(sq.hoverUnit(6))
Polestar.Set("qol.questTooltips", true)
stub.advance(0.3)
emit(sq.hoverUnit(6, true))         -- GUID is a secret value (combat): no lines, no error
`, { setup: 'w.complete({ 783 })' });
	assert.deepEqual(lines, ['?', 'Kobold Camp Cleanup: | Kill Kobold Vermin 3/10', 'Kobold Candles: | Large Candle 0/8']);
	assert.deepEqual(item, ['?', 'Kobold Candles: | 0/8']);
	assert.deepEqual(startItem, ['?', 'Starts a quest: | A Strange Note']);
	assert.deepEqual(colours, [true, true, true, true], 'title in the quest colour; progress textDim, success once done');
	assert.deepEqual(off, ['?']);
	assert.deepEqual(secret, ['?']);
});

test('object tooltips by id or, without one, by name', () => {
	const [byId, byName] = run(`
w.accept(18, { { text = "Bundle of Wood: 0/1", type = "object", required = 1 } })
stub.advance(0.3)
emit(sq.hoverObject(55, "Bundle of Wood"))
emit(sq.hoverObject(nil, "Bundle of Wood"))
`);
	assert.deepEqual(byId, ['?', 'Gathering Wood: | Not done']);
	assert.deepEqual(byName, ['?', 'Gathering Wood: | Not done']);
});

// Sapphires of Aku'Mai (6563): the sapphire drops from three objects that
// share its name, so the name index met the one objective three times and
// the tooltip of an object hovered without an id listed it three times.
test('an item several objects of one name drop names its objective once on their tooltip', () => {
	const [byName, byId] = run(`
local d = Q._data
d.objects[78], d.objects[79] = d.objects[77], d.objects[77]
local r = d.items[772]
local j = 3 + 2 * r[2]
local item = {}
for i = 1, j + 2 * r[j] do item[#item + 1] = r[i] end
item[j] = r[j] + 2
item[#item + 1], item[#item + 2], item[#item + 3], item[#item + 4] = 78, 100, 79, 100
for i = j + 2 * r[j] + 1, #r do item[#item + 1] = r[i] end
d.items[772] = item
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
stub.advance(0.3)
emit(sq.hoverObject(nil, "Candle Crate"))
emit(sq.hoverObject(78, "Candle Crate"))
`, { setup: 'w.complete({ 783 })' });
	assert.deepEqual(byName, ['?', 'Kobold Candles: | Large Candle 0/8']);
	assert.deepEqual(byId, ['?', 'Kobold Candles: | Large Candle 0/8']);
});

test('an unchanged quest log costs no rebuild and no Pins call', () => {
	const [first, after] = run(`
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local function snap() return { rebuilds = Q.stats.rebuilds, changes = Q.stats.changes, publishes = Q.stats.publishes, available = Q.stats.availableScans, calls = #sq.pins.calls } end
emit(snap())
for _ = 1, 5 do
	stub.fire("QUEST_LOG_UPDATE")
	stub.fire("UNIT_QUEST_LOG_CHANGED", "player")
	stub.advance(0.1)
end
stub.advance(1)
emit(snap())
`, { setup: 'w.complete({ 783 })' });
	assert.ok(first.calls > 0);
	assert.deepEqual(after, first);
});

test('a progress count alone rebuilds no marker and calls no Pins; tooltips read it live; a finished objective rebuilds', () => {
	const [base, tick, tip, done] = run(`
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local updates = 0
Polestar.On("QUESTDB_UPDATED", function() updates = updates + 1 end)
local function snap() return { rebuilds = Q.stats.rebuilds, calls = #sq.pins.calls, pins = #layer("quests.objectives"), updates = updates } end
emit(snap())
w.progress(7, 1, 4)
stub.advance(0.3)
emit(snap())
emit(sq.pinTooltip(layer("quests.objectives")[1]))
w.progress(7, 1, 10)
stub.advance(0.3)
emit(snap())
`, { setup: 'w.complete({ 783 })' });
	assert.ok(base.pins > 0);
	assert.deepEqual(tick, { ...base, updates: base.updates + 1 }, 'kill count 4/10: same markers, no Pins call, one update for tooltips and nameplates');
	assert.ok(tip.some((l) => /4\/10/.test(l)), `the marker tooltip reads the live count: ${JSON.stringify(tip)}`);
	assert.equal(done.rebuilds, base.rebuilds + 1, 'objective done: markers rebuilt');
	assert.equal(done.pins, 0, 'its kill markers are gone');
});

test('quest log events are coalesced into one update per throttle window', () => {
	const [scans] = run(`
local before = Q.stats.scans
for _ = 1, 20 do stub.fire("QUEST_LOG_UPDATE") end
stub.advance(0.3)
emit(Q.stats.scans - before)
`);
	assert.equal(scans, 1);
});

test('marker settings reach the Pins layers', () => {
	const [noMinimap, noMap, noAvailable] = run(`
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
Polestar.Set("qol.minimapObjectives", false)
stub.advance(0.3)
emit({ sq.pins.layers["quests.objectives"].opts, sq.pins.layers["quests.available"].opts })
Polestar.Set("qol.mapObjectives", false)
stub.advance(0.3)
emit(sq.pins.layers["quests.objectives"] == nil)
Polestar.Set("qol.availableQuests", false)
stub.advance(0.3)
emit({ sq.pins.layers["quests.available"] == nil, #Q.GetAvailableQuests() })
`, { setup: 'w.complete({ 783 })' });
	assert.deepEqual(noMinimap, [{ world: true, minimap: false, edge: false, scale: 1 }, { world: true, minimap: false, edge: false, scale: 1 }]);
	assert.equal(noMap, true);
	assert.deepEqual(noAvailable, [true, 0]);
});

test('nameplate icons mark objective mobs until the objective is done', () => {
	const [shown, secretPlate, done] = run(`
Polestar.Set("qol.nameplateIcons", true)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
sq.addPlate("nameplate1", 6)
sq.addPlate("nameplate2", 197)
emit(Q.NameplateIcons())
sq.addPlate("nameplate3", 6, true)  -- GUID secret: no icon, no error
emit(Q.NameplateIcons())
w.progress(7, 1, 10)
stub.advance(0.3)
emit(Q.NameplateIcons())
`, { setup: 'w.complete({ 783 })' });
	assert.deepEqual(shown, ['nameplate1']);
	assert.deepEqual(secretPlate, ['nameplate1']);
	assert.deepEqual(done, {}, 'empty');
});

test('nameplate icons carry the progress of the objectives still open, live, beside the icon', () => {
	const [both, live, oneLeft, gone, single] = run(`
Polestar.Set("qol.nameplateIcons", true)
w.accept(60, { { text = "Large Candle: 0/8", type = "item", required = 8 } })
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.progress(7, 1, 3)
w.progress(60, 1, 1)
stub.advance(0.3)
sq.addPlate("nameplate1", 6)
local function count(unit)
	local f = Q.NameplateIcon(unit)
	local fs = f and f.count
	if not (fs and fs:IsShown() and f:IsShown()) then return nil end
	local point, rel, relPoint = fs:GetPoint(1)
	return { text = fs:GetText(), api = Q.NameplateCount(unit), at = point .. " " .. (rel == f and "icon" or "?") .. " " .. relPoint }
end
emit(count("nameplate1"))
w.progress(7, 1, 4)                 -- a kill: the plate reads it on the next update
stub.advance(0.3)
emit(count("nameplate1"))
w.progress(7, 1, 10)                -- 7 done: only the candles are left
stub.advance(0.3)
emit(count("nameplate1"))
w.progress(60, 1, 8)
stub.advance(0.3)
emit({ Q.NameplateIcons(), count("nameplate1") == nil, Q.NameplateCount("nameplate1") == nil })
-- A one-off objective has no count to show: the icon alone, no stale text
-- from the frame's last plate.
w.turnIn(7); w.turnIn(60)
w.accept(7, { { text = "Kobold Vermin slain: 0/1", type = "monster", required = 1 } })
stub.advance(0.3)
emit({ Q.NameplateIcons(), count("nameplate1") == nil })
`, { setup: 'w.complete({ 783 }); w.setLevel(4)' });
	assert.deepEqual(both, { text: '3/10 · 1/8', api: '3/10 · 1/8', at: 'RIGHT icon LEFT' }, 'quest 7 then quest 60, left of the icon');
	assert.equal(live.text, '4/10 · 1/8');
	assert.equal(oneLeft.text, '1/8');
	assert.deepEqual(gone, [{}, true, true], 'all done: no icon, no count');
	assert.deepEqual(single, [['nameplate1'], true]);
});

test('nameplate icons sit beside the health bar the player sees, above the frame that draws it', () => {
	const [eui, out] = run(`
Polestar.Set("qol.nameplateIcons", true)
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
local function frame(kind, parent, label, level, wd, ht)
	local f = CreateFrame(kind, nil, parent)
	f.label, f.level = label, level
	if wd then f:SetSize(wd, ht) end
	return f
end
-- Blizzard's own plate: the UnitFrame with its health bar.
local function blizzard(plate)
	plate.label, plate.level = "base", 3
	plate.UnitFrame = frame("Frame", plate, "unitframe", 4)
	plate.UnitFrame.healthBar = frame("StatusBar", plate.UnitFrame, "blizzard bar", 5, 120, 8)
end
local function where(unit)
	local f = Q.NameplateIcon(unit)
	local point, rel, relPoint, x, y = f:GetPoint(1)
	return { at = point .. " " .. (rel.label or "?") .. " " .. relPoint .. " " .. x .. "," .. y,
		parent = f:GetParent().label or "?", level = f:GetFrameLevel(), size = f:GetWidth() }
end
sq.addPlate("nameplate1", 6, false, function(plate) plate.label = "base" end)
sq.addPlate("nameplate2", 6, false, blizzard)
sq.addPlate("nameplate3", 6, false, function(plate) -- Plater-like
	blizzard(plate)
	plate.UnitFrame:SetAlpha(0)
	plate.unitFrame = frame("Frame", plate, "plater", 6)
	plate.unitFrame.healthBar = frame("StatusBar", plate.unitFrame, "plater bar", 7, 110, 12)
end)
sq.addPlate("nameplate4", 6, false, function(plate) -- an addon this code does not know
	blizzard(plate)
	plate.UnitFrame:Hide()
	frame("Frame", plate, "decor", 8, 20, 20)
	frame("StatusBar", frame("Frame", plate, "small", 8), "small bar", 9, 40, 4)
	local holder = frame("Frame", plate, "generic", 8)
	frame("StatusBar", frame("Frame", holder, "inner", 9), "generic bar", 10, 100, 18)
end)
-- EllesmereUI Nameplates builds its plate in its own NAME_PLATE_UNIT_ADDED
-- handler (it may run after this one) and fades Blizzard's UnitFrame to alpha 0.
sq.addPlate("nameplate5", 6, false, blizzard)
local before = where("nameplate5")
local base = C_NamePlate.GetNamePlateForUnit("nameplate5")
local p = frame("Frame", base, "eui", 4)
p.nameplate = base
p.health = frame("StatusBar", p, "eui bar", 10, 140, 24)
base.UnitFrame:SetAlpha(0)
EllesmereNameplates_NS = { plates = { nameplate5 = p }, friendlyPlates = {} }
stub.runTimers()
emit({ before = before, after = where("nameplate5") })
local out = {}
for i = 1, 4 do out[i] = where("nameplate" .. i) end
emit(out)
`, { setup: 'w.complete({ 783 })' });
	assert.deepEqual(eui, {
		before: { at: 'RIGHT blizzard bar LEFT -3,0', parent: 'base', level: 10, size: 14 },
		after: { at: 'RIGHT eui bar LEFT -3,0', parent: 'eui', level: 15, size: 20 },
	});
	assert.deepEqual(out, [
		{ at: 'BOTTOM base TOP 0,-2', parent: 'base', level: 6, size: 16 },
		{ at: 'RIGHT blizzard bar LEFT -3,0', parent: 'base', level: 10, size: 14 },
		{ at: 'RIGHT plater bar LEFT -3,0', parent: 'plater', level: 12, size: 14 },
		{ at: 'RIGHT generic bar LEFT -3,0', parent: 'generic', level: 15, size: 18 },
	]);
});

test('turning the database off clears every layer', () => {
	const [layers] = run(`
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
stub.advance(0.3)
Polestar.Set("qol.questDB", false)
local n = 0
for name in pairs(sq.pins.layers) do if name:find("^quests%.") then n = n + 1 end end
emit({ n, Q.IsRunning(), Q.ObjectivesForNpc(6) == nil })
`, { setup: 'w.complete({ 783 })' });
	assert.deepEqual(layers, [0, false, true]);
});

// Quest settings live on the Questing page (its Quests tab) and their map
// markers on the Map page, with every other map icon; their keys sit under
// the `qol.` section the module registered from its start.
test('registers its settings on the Questing page and its markers on the Map page', () => {
	const [defaults, pages, elsewhere] = run(`
local keys = { "questDB", "mapObjectives", "minimapObjectives", "objectiveAreas", "turnInMarkers", "availableQuests",
	"lowLevelQuests", "questLevelWindow", "questTooltips", "nameplateIcons", "questLevels", "guideHighlight", "guideDim" }
local d, mine = {}, {}
for _, k in ipairs(keys) do d[k] = Polestar.GetDefault("qol." .. k); mine["qol." .. k] = true end
emit(d)
local out, other = { Questing = {}, Map = {} }, {}
local reg = Polestar.Widgets and Polestar.Widgets.OptionsRegistry or {}
if #reg == 0 then reg = Q.OPTIONS end
for _, spec in ipairs(reg) do
	for _, c in ipairs(spec.controls) do
		if c.key and mine[c.key] then
			local list = out[spec.page]
			if list and (spec.page == "Map" or spec.tab == "Quests") then
				list[#list + 1] = c.key .. (c.help and "+help" or "")
			else
				other[#other + 1] = c.key
			end
		end
	end
end
emit(out)
emit(other)
`);
	assert.deepEqual(defaults, {
		questDB: true, mapObjectives: false, minimapObjectives: false, objectiveAreas: false, turnInMarkers: false,
		availableQuests: false, lowLevelQuests: false, questLevelWindow: 5, questTooltips: true, nameplateIcons: false,
		questLevels: true, guideHighlight: true, guideDim: false,
	});
	assert.deepEqual(pages.Questing, ['qol.questDB+help', 'qol.questTooltips+help', 'qol.nameplateIcons+help', 'qol.questLevels+help']);
	assert.deepEqual(pages.Map, [
		'qol.availableQuests+help', 'qol.questLevelWindow+help', 'qol.lowLevelQuests+help', 'qol.mapObjectives+help',
		'qol.objectiveAreas+help', 'qol.turnInMarkers+help', 'qol.minimapObjectives+help',
		'qol.guideHighlight+help', 'qol.guideDim+help',
	]);
	assert.deepEqual(elsewhere, {}, 'no quest setting on another page');
});

test('with the shipped database and the real Pins service, quest 7 gets objective markers', { skip: !fs.existsSync(path.join(__dirname, '..', 'addon', 'Polestar_QuestDB', 'Quests.lua')) && 'not generated' }, () => {
	const shipped = path.join(__dirname, '..', 'addon', 'Polestar_QuestDB');
	const files = ['MapFrames.lua', 'Quests.lua', 'Npcs.lua', 'Objects.lua', 'Items.lua'].map((f) => path.join(shipped, f));
	const [result] = runAddon({
		stubs: ['stub_world.lua', 'stub_quests.lua'],
		before: `stub.quests.dbFiles = { ${files.map(lua).join(', ')} }
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 40)
w.complete({ 783 })`,
		addons: ['Polestar'],
		saved: { Polestar: MARKERS_ON },
		login: true,
		script: `
local w, Q = stub.world, Polestar.QuestDB
stub.advance(0.3)
local avail = #Q.GetAvailableQuests()
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } }, "Kobold Camp Cleanup")
stub.advance(0.3)
local pins = Polestar.Pins.GetLayer("quests.objectives") or {}
emit({ avail = avail, pins = #pins, header = pins[1] and pins[1].header, era = Polestar.MapFrames.era[1429] ~= nil, avail7 = Q.IsAvailable(7) })`,
	}).emitted;
	assert.ok(result.avail > 0, 'a fresh level-1 Human has quests to take');
	assert.ok(result.pins > 0);
	assert.equal(result.header, 'Kobold Vermin');
	assert.equal(result.era, true);
	assert.equal(result.avail7, false, 'a quest in the log is not available');
});

test('quests under a collapsed quest-log header still get markers', () => {
	const [atLogin, accepted, removed] = run(`
emit(#layer("quests.objectives"))
sq.collapsed[33] = true
w.accept(33, { { text = "Tough Wolf Meat: 0/8", type = "item", required = 8 } })
stub.advance(0.3)
local wolves = 0
for _, p in ipairs(layer("quests.objectives")) do if p.header == "Young Wolf" then wolves = wolves + 1 end end
emit(wolves)
w.abandon(7)
stub.advance(0.3)
local kobolds = 0
for _, p in ipairs(layer("quests.objectives")) do if p.header == "Kobold Vermin" then kobolds = kobolds + 1 end end
emit(kobolds)
`, { setup: 'w.complete({ 783 }); w.onQuest(7, { { text = "Kobold Vermin slain: 2/10", type = "monster", required = 10, fulfilled = 2 } }); stub.quests.collapsed[7] = true' });
	assert.equal(atLogin, 3, 'found by the login sweep');
	assert.equal(accepted, 1, 'found through QUEST_ACCEPTED');
	assert.equal(removed, 0, 'dropped once the client says it is gone');
});

test('level window: quests more than N levels above yours are hidden ("high"); 10 shows any', () => {
	const files = extraDb();
	const why = 'emit({ Q.WhyUnavailable(9420) or "ok", Q.WhyUnavailable(60) or "ok", Q.WhyUnavailable(16) or "ok", Q.WhyUnavailable(33) or "ok" })';
	const [byDefault, plusOne, own, any, markers] = run(`
${why}
Polestar.Set("qol.questLevelWindow", 1); stub.advance(0.3)
${why}
Polestar.Set("qol.questLevelWindow", 0); stub.advance(0.3)
${why}
Polestar.Set("qol.questLevelWindow", 10); stub.advance(0.3)
${why}
local n = 0
for _, p in ipairs(layer("quests.available")) do for _, q in ipairs(p.refs) do if q == 9420 then n = n + 1 end end end
emit(n)
`, { setup: `stub.quests.dbFiles = { ${files.map(lua).join(', ')} }; w.setLevel(2)` });
	// Level 2: 9420 is level 9, 60 level 4, 16 level 3, 33 level 2.
	assert.deepEqual(byDefault, ['high', 'ok', 'ok', 'ok'], 'default +5: level 9 is too high at 2');
	assert.deepEqual(plusOne, ['high', 'high', 'ok', 'ok']);
	assert.deepEqual(own, ['high', 'high', 'high', 'ok']);
	assert.deepEqual(any, ['ok', 'ok', 'ok', 'ok']);
	assert.ok(markers > 0, 'its giver is marked once the window allows it');
});

test('done quests: completed ones never show, from the bulk list or per quest when the client has none', () => {
	const check = `
emit({ Q.WhyUnavailable(33) or "ok", Q.IsAvailable(33), Q.IsAvailable(18) })
w.turnIn(18); stub.advance(0.3)
emit({ Q.WhyUnavailable(18) or "ok", Q.IsAvailable(18) })`;
	const [bulk, bulkAfter] = run(check, { setup: 'w.complete({ 33 })' });
	assert.deepEqual(bulk, ['done', false, true]);
	assert.deepEqual(bulkAfter, ['done', false]);
	const [single, singleAfter] = run(check, { setup: 'w.complete({ 33 }); C_QuestLog.GetAllCompletedQuestIDs = nil' });
	assert.deepEqual(single, ['done', false, true], 'C_QuestLog.IsQuestFlaggedCompleted answers per quest');
	assert.deepEqual(singleAfter, ['done', false]);
});

// Pin selection: what ends up in each layer and how it looks.
test('pin selection: objective areas, turn-in toggle, and the guide step highlighted with the rest dimmed', () => {
	const [areas, noAreas, focus, dim, off, noTurnIn] = run(`
w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
w.accept(33, { { text = "Tough Wolf Meat: 0/8", type = "item", required = 8 } })
w.progress(33, 1, 8)
stub.advance(0.3)
local function look(name)
	local out = {}
	for _, p in ipairs(layer(name)) do
		local accent = Q.Color("accent")
		out[#out + 1] = { h = p.header, area = p.area and true or false, radius = p.radius, ring = p.ring == accent, back = p.backdrop == true,
			size = p.size, mini = p.minimapSize, a = p.color[4], focus = p.focus or "none" }
	end
	table.sort(out, function(a, b) if a.h ~= b.h then return a.h < b.h end return (a.radius or 0) < (b.radius or 0) end)
	return out
end
emit(look("quests.objectives"))
Polestar.Set("qol.objectiveAreas", false); stub.advance(0.3)
emit(look("quests.objectives"))
Polestar.Set("qol.objectiveAreas", true)
-- a guide whose current step kills for quest 7
local E = Polestar.Engine
E.GetGuide = function() return { id = "test", steps = { { goals = { { t = "kill", quest = 7, target = "Kobold Vermin" } } } } } end
E.GetStepIndex = function() return 1 end
Polestar.Fire("STEP_CHANGED", 1); stub.advance(0.3)
emit({ look("quests.objectives"), look("quests.turnin"), look("quests.available") })
Polestar.Set("qol.guideDim", true); stub.advance(0.3)
emit({ look("quests.objectives"), look("quests.turnin"), look("quests.available") })
E.GetGuide = function() return nil end
Polestar.Fire("GUIDE_CHANGED", nil); stub.advance(0.3)
emit({ look("quests.objectives"), look("quests.available") })
Polestar.Set("qol.turnInMarkers", false); stub.advance(0.3)
emit(sq.pins.layers["quests.turnin"] == nil)
`, { setup: 'w.complete({ 783 })' });
	const S = { kill: 16, killMini: 14, turnin: 18, available: 16 };
	// Kobold Vermin: two camps spread over yards (areas), one tight pair (none).
	assert.equal(areas.length, 3);
	assert.ok(areas.every((p) => p.h === 'Kobold Vermin' && p.focus === 'none' && !p.ring && p.back && p.size === S.kill && p.mini === S.killMini),
		'glyph on its dark disc, 16 px on the world map, 14 on the minimap');
	assert.ok(areas.filter((p) => p.area).length >= 1, 'spread clusters get an area');
	assert.ok(areas.every((p) => p.area === (p.radius !== undefined)), 'area only where the cluster radius reaches MIN_AREA');
	assert.ok(noAreas.every((p) => !p.area), 'qol.objectiveAreas off: no areas');
	const [fObj, fTurn, fAvail] = focus;
	assert.ok(fObj.every((p) => p.focus === 'focus' && p.ring && p.size === S.kill * 1.3 && p.mini === S.killMini * 1.3),
		'the step quest: same glyph, x1.3, circled in the accent');
	assert.ok(fTurn.every((p) => p.focus === 'none' && !p.ring && p.size === S.turnin && p.a === 1), 'not in the step, not dimmed by default');
	assert.ok(fAvail.length > 0 && fAvail.every((p) => p.focus === 'none'));
	assert.deepEqual([fObj.length, fTurn.length], [3, 1], 'three Vermin clusters; one turn-in (Eagan Peltskinner)');
	const [dObj, dTurn, dAvail] = dim;
	assert.ok(dAvail.length > 0 && off[0].length === 3 && off[1].length > 0);
	assert.ok(dObj.every((p) => p.focus === 'focus' && p.a === 1));
	assert.ok(dTurn.every((p) => p.focus === 'dim' && p.back && Math.abs(p.a - 0.6) < 1e-9), 'qol.guideDim: everything else recedes to 0.6');
	assert.ok(dAvail.every((p) => p.focus === 'dim'));
	assert.ok(off[0].every((p) => p.focus === 'none' && !p.ring) && off[1].every((p) => p.focus === 'none' && p.a === 1), 'no guide: plain look');
	assert.equal(noTurnIn, true, 'qol.turnInMarkers off clears the turn-in layer');
});

test('the database loads on demand: not while every quest feature is off, at once when one turns on', () => {
	const allOff = '{ questDB = true, mapObjectives = false, minimapObjectives = false, availableQuests = false, turnInMarkers = false, questTooltips = false, nameplateIcons = false }';
	const [before, after] = run(`
emit({ Q.IsLoaded(), sq.loadCalls, Q.IsRunning() })
Polestar.Set("qol.questTooltips", true)
stub.advance(0.3)
emit({ Q.IsLoaded(), sq.loadCalls, Q.IsRunning() })
`, { saved: { Polestar: `PolestarDB = { schema = 1, settings = { qol = ${allOff} } }` } });
	assert.deepEqual(before, [false, 0, false]);
	assert.deepEqual(after, [true, 1, true]);
});
