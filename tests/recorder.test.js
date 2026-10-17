'use strict';
// The in-game recorder (addon/Polestar_Recorder) against the quest/map/unit
// world of tests/lua/stub_recorder.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const REC = 'Polestar_Recorder';

// Lua helpers available to every script.
const PRELUDE = `
local function S() return PolestarRecorderDB.sessions[PolestarRecorderDB.current] end
local function events(kind)
	local out = {}
	for _, e in ipairs(S().events) do
		if kind == nil or e.e == kind then out[#out + 1] = e end
	end
	return out
end
local function kinds(skip)
	local out = {}
	for _, e in ipairs(S().events) do
		if not (skip and skip[e.e]) then out[#out + 1] = e.e end
	end
	return out
end
local NOISE = { pos = true, zone = true }
`;

function run(script, opts = {}) {
	return runAddon({
		stubs: ['stub_recorder.lua'],
		addons: [REC],
		login: true,
		...opts,
		script: PRELUDE + script,
	}).emitted;
}

const KOBOLDS = `{ title = "Kobold Camp Cleanup", level = 2, objectives = { { text = "Kobold Vermin slain: %d/%d", type = "monster", numRequired = 3 } } }`;

test('accept, objective progress and turn-in are recorded with the NPCs and places involved', () => {
	const [out] = run(`
		stub.world.xp = 40
		stub.moveTo(48.2, 41.9)
		local willem = stub.creature(823, "Deputy Willem")
		stub.offerQuest(7, willem, "Deputy Willem", "Kobold Camp Cleanup")
		stub.advance(3)
		stub.moveTo(48.4, 42.3) -- the accept still belongs where the quest giver stood
		stub.acceptQuest(7, ${KOBOLDS})
		stub.setUnit("npc", nil)
		for i = 1, 3 do
			stub.moveTo(46 + i, 35)
			local g = stub.creature(6, "Kobold Vermin")
			stub.setUnit("target", g, "Kobold Vermin")
			stub.fire("PLAYER_TARGET_CHANGED")
			stub.partyKill(g)
			stub.unitDied(g)
			stub.setProgress(7, 1, i)
			stub.advance(10)
		end
		stub.moveTo(48.2, 41.9)
		stub.turnIn(7, willem, "Deputy Willem", 170, 35)
		local accept, turnin = events("accept")[1], events("turnin")[1]
		local progress, kills = {}, {}
		for _, e in ipairs(events("progress")) do progress[#progress + 1] = { e.q, e.oi, e.cur, e.max, e.x, e.text } end
		for _, e in ipairs(events("kill")) do kills[#kills + 1] = { e.npc, e.npcName, e.q, e.oi, e.x } end
		accept.t, turnin.t = nil, nil
		emit({ kinds = kinds(NOISE), accept = accept, turnin = turnin, progress = progress, kills = kills, complete = events("complete")[1].q })`);

	assert.deepEqual(out.kinds, ['accept', 'kill', 'slain', 'progress', 'kill', 'slain', 'progress', 'kill', 'slain', 'progress', 'complete', 'turnin']);
	assert.deepEqual(out.accept, {
		e: 'accept', q: 7, title: 'Kobold Camp Cleanup', qlvl: 2, lvl: 1, xp: 40,
		npc: 823, npcName: 'Deputy Willem', map: 1429, x: 48.2, y: 41.9,
	});
	assert.deepEqual(out.turnin, {
		e: 'turnin', q: 7, xpReward: 170, money: 35, lvl: 1,
		npc: 823, npcName: 'Deputy Willem', map: 1429, x: 48.2, y: 41.9,
	});
	assert.deepEqual(out.progress, [
		[7, 1, 1, 3, 47, 'Kobold Vermin slain: 1/3'],
		[7, 1, 2, 3, 48, 'Kobold Vermin slain: 2/3'],
		[7, 1, 3, 3, 49, 'Kobold Vermin slain: 3/3'],
	]);
	assert.deepEqual(out.kills, [
		[6, 'Kobold Vermin', 7, 1, 47],
		[6, 'Kobold Vermin', 7, 1, 48],
		[6, 'Kobold Vermin', 7, 1, 49],
	]);
	assert.equal(out.complete, 7);
});

test('kills that advance no quest objective are not recorded; an unseen kill is linked by the progress it caused', () => {
	const [out] = run(`
		stub.acceptQuest(7, ${KOBOLDS})
		stub.moveTo(40, 40)
		-- the player kills a wolf: no objective mentions it, nothing advances
		local wolf = stub.creature(299, "Young Wolf")
		stub.setUnit("target", wolf, "Young Wolf")
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.partyKill(wolf)
		stub.unitDied(wolf)
		-- someone else's kill nearby, never targeted
		stub.unitDied((stub.creature(6, "Kobold Vermin")))
		stub.advance(5)
		-- a kobold the player never targeted or saw dies, then the objective advances
		stub.moveTo(41, 42)
		local unseen = stub.creature(6)
		stub.unitDied(unseen)
		stub.advance(0.5)
		stub.setProgress(7, 1, 1)
		-- a quest-related unit (client flag) the player targeted and killed
		stub.advance(5)
		local flagged = stub.creature(1000, "Kobold Laborer")
		stub.setUnit("target", flagged, "Kobold Laborer", true)
		stub.fire("PLAYER_TARGET_CHANGED")
		stub.partyKill(flagged)
		local kills = {}
		for _, e in ipairs(events("kill")) do kills[#kills + 1] = { npc = e.npc, name = e.npcName, q = e.q, oi = e.oi, x = e.x, y = e.y } end
		emit(kills)`);

	assert.deepEqual(out, [
		{ npc: 6, name: 'Kobold Vermin', q: 7, oi: 1, x: 41, y: 42 },
		{ npc: 1000, name: 'Kobold Laborer', x: 41, y: 42 },
	]);
});

test('breadcrumbs are recorded only while moving, and only after enough distance or time', () => {
	// Elwynn Forest in the stub is 5200 yd wide: 1 yd = 100/5200 % of the map.
	const [out] = run(`
		local YD = 100 / 5200
		local x = 30
		local function walk(seconds, yardsPerSecond)
			for _ = 1, seconds do
				x = x + yardsPerSecond * YD
				stub.moveTo(x, 50)
				stub.advance(1)
			end
		end
		local function count() return #events("pos") end
		stub.world.moving = false
		walk(10, 7)                 -- position changes but the player is not moving (e.g. a boat)
		local idle = count()
		stub.world.moving = true
		walk(1, 7)                  -- first point once moving
		local first = count()
		walk(15, 1)                 -- 15 yd in 15 s: under both thresholds
		local slow = count()
		walk(6, 1)                  -- 20 s since the last point and over 4 yd: one point
		local slowGap = count()
		walk(20, 10)                -- 200 yd at run speed: a point every 25+ yd
		local run = count()
		stub.world.onTaxi = true
		walk(20, 30)                -- flights are not breadcrumbed
		local taxi = count()
		local pts = events("pos")
		local minStep = math.huge
		for i = first + 1, run do
			local d = (pts[i].x - pts[i - 1].x) / YD
			if d < minStep then minStep = d end
		end
		emit({ idle = idle, first = first, slow = slow, slowGap = slowGap, run = run, taxi = taxi, minStep = minStep })`);

	assert.equal(out.idle, 0);
	assert.equal(out.first, 1);
	assert.equal(out.slow, 1);
	assert.equal(out.slowGap, 2);
	assert.equal(out.run, 2 + 6); // 200 yd at 10 yd/s with a 25 yd minimum: every 3 s -> 6 points
	assert.equal(out.taxi, out.run);
	assert.ok(out.minStep >= 4, `consecutive points ${out.minStep} yd apart`);
});

test('every login starts a new session; a UI reload continues the current one', () => {
	const [first] = run(`
		SlashCmdList.POLESTARREC("mark first login")
		emit(stub.serialize(PolestarRecorderDB))`);

	const [second] = run(
		`
		SlashCmdList.POLESTARREC("mark second login")
		local keys = {}
		for k, s in pairs(PolestarRecorderDB.sessions) do
			local marks = {}
			for _, e in ipairs(s.events) do if e.e == "mark" then marks[#marks + 1] = e.text end end
			keys[#keys + 1] = { key = k, marks = marks, char = s.char.name, started = s.started }
		end
		table.sort(keys, function(a, b) return a.started < b.started end)
		emit({ sessions = keys, current = PolestarRecorderDB.current, db = stub.serialize(PolestarRecorderDB) })`,
		{ before: 'stub.epoch = stub.epoch + 3600', saved: { [REC]: `PolestarRecorderDB = ${first}` } },
	);
	assert.deepEqual(
		second.sessions.map((s) => [s.key, s.marks, s.char]),
		[
			['1791000000-Testchar', ['first login'], 'Testchar'],
			['1791003600-Testchar', ['second login'], 'Testchar'],
		],
	);
	assert.equal(second.current, '1791003600-Testchar');

	const [reloaded] = run(
		`
		stub.fire("PLAYER_LOGIN")
		stub.fire("PLAYER_ENTERING_WORLD", false, true)
		SlashCmdList.POLESTARREC("mark after reload")
		local n, marks = 0, {}
		for _ in pairs(PolestarRecorderDB.sessions) do n = n + 1 end
		for _, e in ipairs(S().events) do if e.e == "mark" then marks[#marks + 1] = { e.text, e.t } end end
		emit({ n = n, current = PolestarRecorderDB.current, marks = marks })`,
		{ login: false, before: 'stub.epoch = stub.epoch + 3700', saved: { [REC]: `PolestarRecorderDB = ${second.db}` } },
	);
	assert.equal(reloaded.n, 2);
	assert.equal(reloaded.current, '1791003600-Testchar');
	assert.deepEqual(reloaded.marks.map((m) => m[0]), ['second login', 'after reload']);
	assert.ok(reloaded.marks[1][1] >= 100, 'event times keep counting from the session start');
});

test('a nil PolestarRecorderDB (cold-start bug) neither errors nor loses the live session', () => {
	const [out] = run(
		`
		SlashCmdList.POLESTARREC("on") -- a lost table also lost the opt-in
		SlashCmdList.POLESTARREC("mark before")
		PolestarRecorderDB = nil -- the table vanishes under the running session
		SlashCmdList.POLESTARREC("mark after")
		stub.fire("PLAYER_LOGOUT")
		local marks = {}
		for _, e in ipairs(S().events) do if e.e == "mark" then marks[#marks + 1] = e.text end end
		emit({ type = type(PolestarRecorderDB), schema = PolestarRecorderDB.schema, marks = marks, key = S().session })`,
		{ saved: { [REC]: 'PolestarRecorderDB = nil' } },
	);
	assert.deepEqual(out, { type: 'table', schema: 1, marks: ['before', 'after'], key: '1791000000-Testchar' });

	const [garbage] = run(`SlashCmdList.POLESTARREC("on")\nemit({ ok = type(S().events) == "table" })`, { saved: { [REC]: 'PolestarRecorderDB = "corrupt"' } });
	assert.deepEqual(garbage, { ok: true });
});

// Recording is opt-in: a fresh install writes nothing, not even a session,
// until the player turns it on; on starts a session at once in play, and off
// stops writing until it is on again.
test('recording is off until the player turns it on: no session, no events; on starts one, off stops writing', () => {
	const [out] = run(
		`
		local function sessions() local n = 0 for _ in pairs(PolestarRecorderDB.sessions) do n = n + 1 end return n end
		stub.fire("PLAYER_LEVEL_UP", 2)
		SlashCmdList.POLESTARREC("mark ignored")
		local off = { sessions = sessions(), current = PolestarRecorderDB.current or false, enabled = PolestarRecorderDB.enabled or false }
		SlashCmdList.POLESTARREC("on")
		SlashCmdList.POLESTARREC("mark kept")
		local on = { sessions = sessions(), marks = #events("mark") }
		SlashCmdList.POLESTARREC("off")
		SlashCmdList.POLESTARREC("mark dropped")
		SlashCmdList.POLESTARREC("on")
		emit({ off = off, on = on, after = #events("mark"), enabled = PolestarRecorderDB.enabled })`,
		{ saved: { [REC]: 'PolestarRecorderDB = nil' } },
	);
	assert.deepEqual(out.off, { sessions: 0, current: false, enabled: false });
	assert.deepEqual(out.on, { sessions: 1, marks: 1 });
	assert.equal(out.after, 1, 'nothing is written while off');
	assert.equal(out.enabled, true);
});

test('gossip, flight masters, flights, binds, trainers, vendors, loot, levels, deaths, abandons and zones', () => {
	const [out] = run(`
		local function at(x, y) stub.moveTo(x, y) end
		-- gossip with quests on offer
		at(10, 10)
		stub.world.gossip = { available = { 33, 18 }, active = { 7 } }
		stub.setUnit("npc", (stub.creature(197, "Marshal McBride")), "Marshal McBride")
		stub.fire("GOSSIP_SHOW")
		stub.world.gossip = { available = {}, active = {} }
		stub.fire("GOSSIP_SHOW") -- nothing on offer: not recorded
		-- a new flight master, opened twice
		at(20, 20)
		stub.world.taxi = { { nodeID = 2, name = "Stormwind, Elwynn", state = 0, slotIndex = 1 }, { nodeID = 4, name = "Sentinel Hill, Westfall", state = 1, slotIndex = 2 } }
		stub.setUnit("npc", (stub.creature(352, "Dungar Longdrink")), "Dungar Longdrink")
		stub.fire("TAXIMAP_OPENED", 0)
		stub.fire("TAXIMAP_OPENED", 0)
		-- a refused flight (not enough money): never on the taxi, not recorded
		stub.world.taxi[1].name, stub.world.taxi[2].name = "Stormwind, Elwynn", "Lakeshire, Redridge"
		TakeTaxiNode(2)
		stub.advance(7)
		-- the real flight: recorded once the player is on the taxi
		stub.world.taxi[2].name = "Sentinel Hill, Westfall"
		TakeTaxiNode(2)
		stub.world.onTaxi = true
		stub.fire("PLAYER_CONTROL_LOST")
		stub.advance(7) -- later confirmation checks do not record it twice
		stub.world.onTaxi = false
		-- hearth, trainer, vendor
		at(30, 30)
		stub.world.bind = "Goldshire"
		stub.fire("HEARTHSTONE_BOUND")
		stub.setUnit("npc", (stub.creature(911, "Llane Beshere")), "Llane Beshere")
		stub.fire("TRAINER_SHOW")
		stub.setUnit("npc", (stub.creature(78, "Janos Hammerknuckle")), "Janos Hammerknuckle")
		stub.fire("MERCHANT_SHOW")
		-- loot: the quest item is recorded when looted, the wolf meat is not
		stub.acceptQuest(33, { title = "Wolves Across the Border", objectives = { { text = "Tough Wolf Meat: %d/%d", type = "item", numRequired = 8 } } })
		at(40, 40)
		stub.world.loot = { { name = "Tough Wolf Meat", item = 750, count = 2 }, { name = "Ruined Pelt", item = 4865 }, { name = "Kobold Candle", item = 772, quest = true, questID = 60 } }
		stub.fire("LOOT_OPENED", false, false)
		stub.fire("LOOT_SLOT_CLEARED", 1)
		stub.fire("LOOT_SLOT_CLEARED", 2)
		stub.fire("LOOT_SLOT_CLEARED", 3)
		stub.fire("LOOT_CLOSED")
		-- level, death, abandon, zone
		stub.world.level = 2
		stub.fire("PLAYER_LEVEL_UP", 2, 10, 0, 0, 0, 0, 0, 0)
		stub.fire("PLAYER_DEAD")
		stub.abandon(33)
		stub.world.zone, stub.world.subzone = "Stormwind City", "Trade District"
		stub.moveTo(60, 70, 1453)
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.fire("ZONE_CHANGED") -- same map and zone: no duplicate
		local s = S()
		local list = {}
		for _, e in ipairs(s.events) do
			if e.e ~= "pos" and e.e ~= "accept" then
				local copy = {}
				for k, v in pairs(e) do if k ~= "t" then copy[k] = v end end
				list[#list + 1] = copy
			end
		end
		emit({ events = list, maps = { s.maps[1429] and s.maps[1429].name, s.maps[1453] and s.maps[1453].top } })`);

	assert.deepEqual(out.events, [
		{ e: 'zone', map: 1429, zone: 'Elwynn Forest', subzone: 'Northshire Valley' },
		{ e: 'gossip', npc: 197, npcName: 'Marshal McBride', available: [33, 18], active: [7], map: 1429, x: 10, y: 10 },
		{ e: 'fp', location: 'Stormwind, Elwynn', npc: 352, npcName: 'Dungar Longdrink', map: 1429, x: 20, y: 20 },
		{ e: 'taxi', from: 'Stormwind, Elwynn', to: 'Sentinel Hill, Westfall' },
		{ e: 'bind', location: 'Goldshire', map: 1429, x: 30, y: 30 },
		{ e: 'trainer', npc: 911, npcName: 'Llane Beshere', map: 1429, x: 30, y: 30 },
		{ e: 'vendor', npc: 78, npcName: 'Janos Hammerknuckle', map: 1429, x: 30, y: 30 },
		{ e: 'loot', item: 750, itemName: 'Tough Wolf Meat', count: 2, q: 33, oi: 1, map: 1429, x: 40, y: 40 },
		{ e: 'loot', item: 772, itemName: 'Kobold Candle', count: 1, q: 60, map: 1429, x: 40, y: 40 },
		{ e: 'level', lvl: 2, map: 1429, x: 40, y: 40 },
		{ e: 'death', map: 1429, x: 40, y: 40 },
		{ e: 'abandon', q: 33 },
		{ e: 'zone', map: 1453, zone: 'Stormwind City', subzone: 'Trade District' },
	]);
	assert.deepEqual(out.maps, ['Elwynn Forest', 1722.17]);
});

test('quest XP rewards: on the accept when cached, as a later reward event when not, nothing when the client lacks the API', () => {
	const [out] = run(`
		stub.world.level = 4
		stub.world.rewards[7] = { 450, 420 }
		stub.acceptQuest(7, ${KOBOLDS})
		-- not cached at QUEST_ACCEPTED: the next log update that knows it records it
		stub.acceptQuest(33, { title = "Wolves Across the Border", level = 4, objectives = {} })
		stub.advance(1)
		local beforeCache = #events("reward")
		stub.world.rewards[33] = { 380, 380 }
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(1)
		stub.fire("QUEST_LOG_UPDATE") -- already recorded: not again
		stub.advance(1)
		-- the global disappears (it is not in Forever's API docs)
		GetQuestLogRewardXP = nil
		stub.acceptQuest(60, { title = "Kobold Candles", level = 4, objectives = {} })
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(1)
		local function strip(e) local c = {} for k, v in pairs(e) do if k ~= "t" and k ~= "map" and k ~= "x" and k ~= "y" then c[k] = v end end return c end
		local accepts, rewards = {}, {}
		for _, e in ipairs(events("accept")) do accepts[#accepts + 1] = strip(e) end
		for _, e in ipairs(events("reward")) do rewards[#rewards + 1] = strip(e) end
		emit({ accepts = accepts, rewards = rewards, beforeCache = beforeCache })`);

	assert.deepEqual(out.accepts, [
		{ e: 'accept', q: 7, title: 'Kobold Camp Cleanup', qlvl: 2, lvl: 4, xp: 0, rewardXp: 450, rewardXpBase: 420 },
		{ e: 'accept', q: 33, title: 'Wolves Across the Border', qlvl: 4, lvl: 4, xp: 0 },
		{ e: 'accept', q: 60, title: 'Kobold Candles', qlvl: 4, lvl: 4, xp: 0 },
	]);
	assert.equal(out.beforeCache, 0);
	assert.deepEqual(out.rewards, [{ e: 'reward', q: 33, rewardXp: 380, rewardXpBase: 380, lvl: 4 }]);
});

test('quest XP rewards of quests already in the log are recorded once per session, not again after a reload', () => {
	const LOG = `
		stub.world.level = 5
		stub.world.quests[33] = { title = "Wolves Across the Border", level = 4, objectives = {} }
		stub.world.quests[7] = { title = "Kobold Camp Cleanup", level = 2, objectives = {} }
		stub.world.log = { 33, 7 }
		stub.world.rewards[33] = { 380, 380 }`;
	const [first] = run(
		`
		local atLogin = #events("reward")
		stub.world.rewards[7] = { 450, 420 }
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(1)
		local qs = {}
		for _, e in ipairs(events("reward")) do qs[#qs + 1] = { e.q, e.rewardXp, e.rewardXpBase, e.lvl } end
		emit({ atLogin = atLogin, rewards = qs, db = stub.serialize(PolestarRecorderDB) })`,
		{ before: LOG },
	);
	assert.equal(first.atLogin, 1);
	assert.deepEqual(first.rewards, [
		[33, 380, 380, 5],
		[7, 450, 420, 5],
	]);

	const [reloaded] = run(
		`
		stub.fire("PLAYER_LOGIN")
		stub.fire("PLAYER_ENTERING_WORLD", false, true)
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(3)
		emit(#events("reward"))`,
		{ login: false, before: `${LOG}\nstub.world.rewards[7] = { 450, 420 }`, saved: { [REC]: `PolestarRecorderDB = ${first.db}` } },
	);
	assert.equal(reloaded, 2);
});

test('/psrec: off pauses recording, maps dumps world bounds, talents dumps the trait tree, clear needs confirmation', () => {
	const [out] = run(`
		local cmd = SlashCmdList.POLESTARREC
		cmd("off")
		cmd("mark ignored")
		cmd("on")
		cmd("mark kept")
		local marks = {}
		for _, e in ipairs(events("mark")) do marks[#marks + 1] = e.text end
		cmd("maps")
		local elwynn = PolestarRecorderDB.maps[1429]
		local mapCount = 0
		for _ in pairs(PolestarRecorderDB.maps) do mapCount = mapCount + 1 end
		stub.world.talents = {
			configID = 9, treeIDs = { 400 },
			groups = { { groupID = 1, treeID = 400, displayName = "Arms", orderIndex = 0, icon = 1, skillLineID = 26 } },
			nodes = { [5] = { ID = 5, posX = 100, posY = 200, maxRanks = 5, type = 0, isVisible = true, entryIDs = { 50 }, groupIDs = { 1 }, visibleEdges = { { targetNode = 6 } } },
			          [6] = { ID = 6, posX = 100, posY = 400, maxRanks = 1, type = 0, isVisible = false, entryIDs = {}, groupIDs = { 1 } } },
			entries = { [50] = { definitionID = 500, maxRanks = 5, type = 1 } },
			defs = { [500] = { spellID = 12282 } },
			spells = { [12282] = "Improved Heroic Strike" },
		}
		cmd("talents")
		local talents = PolestarRecorderDB.talents.WARRIOR
		local before = #events()
		cmd("clear")
		local armed = PolestarRecorderDB.sessions[PolestarRecorderDB.current] ~= nil and #events() == before
		stub.advance(31)
		cmd("clear confirm") -- too late: re-arms instead
		local stillThere = #events() == before
		cmd("clear confirm")
		local n = 0
		for _ in pairs(PolestarRecorderDB.sessions) do n = n + 1 end
		for i = 1, 600 do cmd("mark " .. i) end
		emit({
			marks = marks, elwynn = elwynn, mapCount = mapCount,
			talent = { class = talents.class, nodes = #talents.trees[1].nodes, node = talents.trees[1].nodes[1], group = talents.trees[1].groups[1].name },
			armed = armed, stillThere = stillThere, sessionsAfterClear = n, mapsAfterClear = next(PolestarRecorderDB.maps) == nil,
			markCount = #events("mark"), dropped = S().dropped.mark,
		})`);

	assert.deepEqual(out.marks, ['kept']);
	assert.deepEqual(out.elwynn, { name: 'Elwynn Forest', type: 3, parent: 1415, c: 0, top: 1800, left: 1100, bottom: -1666.67, right: -4100 });
	assert.equal(out.mapCount, 4);
	assert.deepEqual(out.talent, {
		class: 'WARRIOR',
		nodes: 1,
		group: 'Arms',
		node: {
			id: 5, x: 100, y: 200, type: 0, maxRanks: 5, groups: [1], edges: [6],
			entries: [{ id: 50, definition: 500, maxRanks: 5, type: 1, spell: 12282, name: 'Improved Heroic Strike' }],
		},
	});
	assert.equal(out.armed, true);
	assert.equal(out.stillThere, true);
	assert.equal(out.sessionsAfterClear, 1);
	assert.equal(out.mapsAfterClear, true);
	assert.equal(out.markCount, 500);
	assert.equal(out.dropped, 100);
});

test('/psrec speaks the client\'s language through the Recorder\'s own locale file; English where it has no translation', () => {
	const before = `function GetLocale() return "ruRU" end
do
	local load = loadfile
	function loadfile(file)
		if file:match("Polestar_Recorder[/\\\\]Locales[/\\\\]ruRU%.lua$") then
			return function(_, ns) ns.L["recording %s"] = "запись: %s"; ns.L["on"] = "вкл" end
		end
		return load(file)
	end
end`;
	const [lines] = run(`
stub.messages = {}
SlashCmdList.POLESTARREC("on")
SlashCmdList.POLESTARREC("mark")
emit(stub.messages)`, { before });
	assert.ok(lines[0].includes('запись: |cff4fd18fвкл|r'), lines[0]);
	assert.ok(lines[1].includes('usage: /psrec mark <text>'), lines[1]);
});
