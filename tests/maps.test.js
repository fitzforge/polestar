'use strict';
// Maps module (addon/Polestar/Maps): travel pin layers built from the travel
// data, the flight timer (learning real durations, falling back to estimates),
// the instance tracker (hourly window, runs, lockouts) and its options.
// Runs Core, Theme, Nav and Maps against stub_world.lua + stub_maps.lua with
// the small travel world in stub.maps.travel.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.xml'];

const PRELUDE = `
local M = Polestar.Maps
local m = stub.maps
local w = stub.world
Polestar.Nav.RegisterTravelData(m.travel, true)
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
-- A tooltip that records what a pin's tooltip function wrote.
local function tip(fn)
	local lines = {}
	local t = {}
	function t:SetText(s) lines[#lines + 1] = s end
	function t:AddLine(s) lines[#lines + 1] = s end
	function t:AddDoubleLine(l, r) lines[#lines + 1] = l .. " | " .. r end
	fn(t)
	return lines
end
`;

// travelPins: turn the travel icon layers on (they are off by default).
const TRAVEL_PINS = 'PolestarDB = { schema = 1, settings = { maps = { taxiPins = true, dockPins = true, innPins = true } } }';

function run(script, { faction = 'Alliance', travelPins = false } = {}) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua'],
		before: `stub.maps.useWorld(); stub.maps.place(0, 800); stub.world.faction = "${faction}"`,
		addons: [{ name: 'Polestar', files: FILES }],
		saved: travelPins ? { Polestar: TRAVEL_PINS } : undefined,
		login: true,
		script: PRELUDE + script,
	}).emitted;
}

// ---------------------------------------------------------------------------
// Travel pins
// ---------------------------------------------------------------------------

test('pin layers come from the travel data: own-faction and neutral flight masters, known vs undiscovered', () => {
	const [out] = run(`
		known(1)
		w.bind("West Hold")
		M.RefreshTravelPins()
		local P = Polestar.Pins
		local taxi = {}
		for _, p in ipairs(P.GetLayer("maps.taxi")) do
			taxi[#taxi + 1] = { id = p.nodeID, known = p.known, icon = p.icon, c = p.c, wx = p.wx, wy = p.wy }
		end
		local docks = {}
		for _, p in ipairs(P.GetLayer("maps.docks")) do docks[#docks + 1] = p.transport .. ">" .. p.dest end
		local inns = {}
		for _, p in ipairs(P.GetLayer("maps.inns")) do inns[#inns + 1] = { bound = p.bound, glow = p.glow or false, icon = p.icon } end
		local g = { Polestar.Theme.Color("success") }
		local a = { Polestar.Theme.Color("warning") }
		local layer = P.GetLayer("maps.taxi")
		emit({ taxi = taxi, docks = docks, inns = inns,
			knownColor = layer[1].color[1] == g[1] and layer[1].color[2] == g[2],
			unknownColor = layer[2].color[1] == a[1] and layer[2].color[2] == a[2],
			minimap = #P.GetMinimapFrames("maps.taxi") })`, { travelPins: true });
	assert.deepEqual(out.taxi, [
		{ id: 1, known: true, icon: 'icon-fly', c: 0, wx: 0, wy: 800 },
		{ id: 2, known: false, icon: 'icon-fly', c: 0, wx: 0, wy: -800 },
		{ id: 3, known: false, icon: 'icon-fly', c: 0, wx: 600, wy: 0 },
	], 'the Horde-only Red Fort is left out');
	assert.deepEqual(out.docks, ['boat-west>Far Isle', 'boat-west>West Dock'], 'the Horde zeppelin is left out');
	assert.deepEqual(out.inns, [{ bound: true, glow: true, icon: 'icon-hearth' }, { bound: false, glow: false, icon: 'icon-hearth' }]);
	assert.equal(out.knownColor, true);
	assert.equal(out.unknownColor, true);
	assert.equal(out.minimap, 0, 'minimap travel icons are off by default');
});

test('tooltips name destinations with learned or estimated flight times, and where boats go', () => {
	const [out] = run(`
		known(1, 3)
		M.LearnFlight(1, 3, nil, nil, 41.4)
		M.RefreshTravelPins()
		local P = Polestar.Pins
		local west = P.GetLayer("maps.taxi")[1]
		local dock = P.GetLayer("maps.docks")[1]
		local inn = P.GetLayer("maps.inns")[2]
		emit({ west = tip(west.tooltip), dock = tip(dock.tooltip), inn = tip(inn.tooltip) })`, { travelPins: true });
	assert.deepEqual(out.west, [
		'West Hold, Testshire',
		'Flight master, known',
		' ',
		'Flights from here',
		'East Hold (not discovered) | ~1:42', // 3000 yd at 30 yd/s + 2 s
		'Mid Camp | 0:41', // learned
	]);
	assert.deepEqual(out.dock, ['Boat to Far Isle', 'From West Dock', 'Ride | 1:40', 'Departs about every | 5:20']);
	assert.deepEqual(out.inn, ['Mid Camp', 'Inn']);
});

test('the Horde sees its own and neutral nodes; settings drop and restore layers', () => {
	const [out] = run(`
		known()
		M.RefreshTravelPins()
		local P = Polestar.Pins
		local ids = {}
		for _, p in ipairs(P.GetLayer("maps.taxi")) do ids[#ids + 1] = p.nodeID end
		local docks = {}
		for _, p in ipairs(P.GetLayer("maps.docks")) do docks[#docks + 1] = p.transport end
		Polestar.Set("maps.taxiPins", false)
		stub.runTimers()
		local off = P.GetLayer("maps.taxi") == nil
		Polestar.Set("maps.taxiPins", true)
		Polestar.Set("maps.travelMinimap", true)
		stub.runTimers()
		emit({ ids = ids, docks = docks, off = off, back = #P.GetLayer("maps.taxi") })`, { faction: 'Horde', travelPins: true });
	assert.deepEqual(out.ids, [3, 4]);
	assert.deepEqual(out.docks, ['zeppelin-red', 'zeppelin-red']);
	assert.equal(out.off, true);
	assert.equal(out.back, 2);
});

test('discovering a flight master on the taxi map recolours its pin', () => {
	const [out] = run(`
		known(1)
		M.RefreshTravelPins()
		local before = Polestar.Pins.GetLayer("maps.taxi")[3].known
		m.openTaxi(3, { 1 })
		stub.runTimers()
		emit({ before = before, after = Polestar.Pins.GetLayer("maps.taxi")[3].known })`, { travelPins: true });
	assert.deepEqual(out, { before: false, after: true });
});

// ---------------------------------------------------------------------------
// Flight timer
// ---------------------------------------------------------------------------

const FLY = `
local function fly(from, slotTo, reach, wx, wy, seconds)
	m.openTaxi(from, reach)
	TakeTaxiNode(slotTo)
	m.board()
	stub.advance(0.5)
	local dest, left, source = M.GetFlight()
	local f = stub.frame("PolestarFlightTimer")
	local shown = { dest = dest, left = left and math.floor(left + 0.5), source = source,
		text = f and f.Time:GetText(), title = f and f.Dest:GetText(), visible = f and f:IsShown() }
	stub.advance(seconds - 0.5)
	m.place(wx, wy)
	m.land()
	stub.advance(0.5)
	shown.after = M.GetFlight() or false
	shown.frameAfter = f and f:IsShown()
	return shown
end
`;

test('the flight timer estimates an unflown route, then learns and prefers the real duration', () => {
	const [out] = run(`${FLY}
		known(1, 2, 3)
		local first = fly(1, 2, { 3, 2 }, 600, 0, 40)      -- West Hold -> Mid Camp, 40 s
		local learned = Polestar.CharState().flightTimes["1>3"]
		local second = fly(1, 2, { 3, 2 }, 600, 0, 40)
		emit({ first = first, learned = learned, second = second })`);
	// 1000 yd / 30 yd/s + 2 s = 35 s estimated.
	assert.equal(out.first.dest, 'Mid Camp');
	assert.equal(out.first.source, 'estimate');
	assert.equal(out.first.left, 35);
	assert.equal(out.first.text, '~0:35');
	assert.equal(out.first.title, 'Mid Camp');
	assert.equal(out.first.visible, true);
	assert.equal(out.first.after, false);
	assert.equal(out.first.frameAfter, false);
	assert.ok(out.learned >= 40 && out.learned <= 41, `learned ${out.learned}`);
	assert.equal(out.second.source, 'learned');
	assert.equal(out.second.left, out.learned);
	assert.equal(out.second.text, `0:${out.learned}`);
});

test('estimates route only over known flight masters', () => {
	const [out] = run(`
		local all = M.EstimateFlight(1, 2, 1, { [1] = true, [2] = true, [3] = true })
		local direct = M.EstimateFlight(1, 2, 1, { [1] = true, [2] = true })
		local horde = M.EstimateFlight(1, 4, 1, { [1] = true, [3] = true, [4] = true })
		emit({ all = all, direct = direct, horde = horde or false })`);
	assert.equal(out.all, 71, 'via Mid Camp: 2 x (1000/30 + 2)');
	assert.equal(out.direct, 102, 'Mid Camp unknown: the long direct leg');
	assert.equal(out.horde, false, 'an Alliance character cannot fly to a Horde node');
});

test('a flight that does not end at its destination is not learned; the timer counts past zero as landing', () => {
	const [out] = run(`${FLY}
		known(1, 2, 3)
		local f = fly(1, 2, { 3, 2 }, 0, -800, 50)        -- landed at East Hold instead
		local times = Polestar.CharState().flightTimes or {}
		m.openTaxi(1, { 3 })
		TakeTaxiNode(2)
		m.board()
		stub.advance(36)
		local late = stub.frame("PolestarFlightTimer").Time:GetText()
		local during = Polestar.CharState().flightNow
		emit({ learned = times["1>3"] or false, late = late, during = during and during.to or false })`);
	assert.equal(out.learned, false);
	assert.equal(out.late, 'landing');
	assert.equal(out.during, 3, 'the flight in progress is saved for a reload');
});

test('the flight timer stays out of the way when disabled', () => {
	const [out] = run(`${FLY}
		Polestar.Set("maps.flightTimer", false)
		known(1, 3)
		local f = fly(1, 1, { 3 }, 600, 0, 40)
		emit({ visible = f.visible or false, learned = (Polestar.CharState().flightTimes or {})["1>3"] or false })`);
	assert.deepEqual(out, { visible: false, learned: false });
});

// ---------------------------------------------------------------------------
// Instance tracker
// ---------------------------------------------------------------------------

test('the hourly window counts entries in the last hour and says when a slot frees', () => {
	const [out] = run(`
		local now = 100000
		local e = {}
		for _, ago in ipairs({ 3500, 3000, 1800, 600, 60 }) do e[#e + 1] = { t = now - ago } end
		local a = { M.InstanceWindow(e, now, 5, 30) }
		local b = { M.InstanceWindow(e, now + 100, 5, 30) }      -- the oldest has dropped out
		local c = { M.InstanceWindow(e, now, 3, 0) }             -- a lower cap: two must drop first
		local d = { M.InstanceWindow({}, now, 5, 30) }
		-- the daily cap: 4 entries over the last day, cap 4
		local day = { { t = now - 80000 }, { t = now - 50000 }, { t = now - 7200 }, { t = now - 100 } }
		local f = { M.InstanceWindow(day, now, 5, 4) }
		emit({ a = a, b = b, c = c, d = d, f = f })`);
	assert.deepEqual(out.a, [5, 5, 100, 100]);
	assert.deepEqual(out.b, [4, 5, 0, 500]);
	assert.deepEqual(out.c, [5, 5, 1800, 100]);
	assert.deepEqual(out.d, [0, 0, 0]);
	assert.deepEqual(out.f, [1, 4, 6400, 3500]);
});

test('entering counts once per instance; re-entering continues the run; a reset starts a new one', () => {
	const [out] = run(`
		local function st() local s = M.GetInstanceStatus(); return { s.inHour, s.wait } end
		local steps = {}
		m.enter("The Deadmines", 36)
		steps[#steps + 1] = st()
		m.jump(300)
		m.leave()                                  -- corpse run
		m.jump(120)
		m.enter("The Deadmines", 36)
		steps[#steps + 1] = st()
		m.leave()
		stub.fire("CHAT_MSG_SYSTEM", "The Deadmines has been reset.")
		m.enter("The Deadmines", 36)
		steps[#steps + 1] = st()
		m.leave()
		m.enter("Wailing Caverns", 43)
		m.leave()
		m.enter("Shadowfang Keep", 33)
		m.leave()
		m.enter("Blackfathom Deeps", 48)
		m.leave()
		steps[#steps + 1] = st()
		m.jump(3600)
		steps[#steps + 1] = st()
		local runs = Polestar.CharState().instanceRuns
		emit({ steps = steps, runs = #runs, firstTime = runs[1].time, firstReset = runs[1].reset or false,
			entries = #PolestarDB.instances.entries, char = PolestarDB.instances.entries[1].char })`);
	assert.deepEqual(out.steps[0], [1, 0]);
	assert.deepEqual(out.steps[1], [1, 0], 'going back into the same instance does not count');
	assert.deepEqual(out.steps[2], [2, 0], 'after a reset it is a new instance');
	assert.deepEqual(out.steps[3], [5, 3600 - 420], 'capped: the first entry frees a slot 420 s later');
	assert.deepEqual(out.steps[4], [0, 0]);
	assert.equal(out.runs, 5);
	assert.equal(out.firstTime, 300, 'time inside, not the corpse run');
	assert.equal(out.firstReset, true);
	assert.equal(out.entries, 5);
	assert.equal(out.char, 'Testchar-Test Realm');
});

test('a run records its time and experience, across a level-up', () => {
	const [out] = run(`
		w.level, w.xp, w.xpMax = 20, 300, 400
		stub.fire("PLAYER_XP_UPDATE", "player")
		m.enter("Razorfen Kraul", 47)
		m.addXP(50)
		m.addXP(120)                -- 370 + 120: levels to 21 with 90 into the next
		m.jump(900)
		local live = M.RunSeconds(M.GetInstanceStatus().run)
		m.leave()
		m.addXP(40)                 -- outside: not part of the run
		local run = Polestar.CharState().instanceRuns[1]
		emit({ xp = run.xp, time = run.time, live = live, level = run.level })`);
	assert.deepEqual(out, { xp: 170, time: 900, live: 900, level: 20 });
});

test('a different instance copy seen in a creature GUID splits a resumed run and counts it', () => {
	const [out] = run(`
		m.enter("The Stockade", 34)
		w.units.target = "Creature-0-4372-34-100-1706-0000AAAA"
		stub.fire("PLAYER_TARGET_CHANGED")
		m.jump(600)
		m.leave()
		m.jump(60)
		m.enter("The Stockade", 34)              -- looks like the same run...
		w.units.target = "Creature-0-4372-34-200-1706-0000BBBB"
		stub.fire("PLAYER_TARGET_CHANGED")      -- ...but it is another copy
		local s = M.GetInstanceStatus()
		local runs = Polestar.CharState().instanceRuns
		emit({ inHour = s.inHour, runs = #runs, firstTime = runs[1].time, zones = { runs[1].zone, runs[2].zone } })`);
	assert.deepEqual(out, { inHour: 2, runs: 2, firstTime: 600, zones: ['100', '200'] });
});

test('saved raid lockouts count down, and the slash command reports everything', () => {
	const [out] = run(`
		m.saved = { { name = "Molten Core", id = 1, reset = 200000, total = 10, done = 4, difficultyName = "40 Player" },
			{ name = "Onyxia's Lair", id = 2, reset = 5000, locked = false } }
		RequestRaidInfo()
		stub.runTimers()
		m.jump(1000)
		local locks = M.GetSavedLockouts()
		m.enter("Ragefire Chasm", 389)
		stub.messages = {}
		SlashCmdList.POLESTAR("instances")
		stub.runTimers()
		emit({ locks = locks, messages = stub.messages })`);
	assert.equal(out.locks.length, 1, 'only locked instances');
	assert.equal(out.locks[0].name, 'Molten Core');
	assert.equal(out.locks[0].resetIn, 199000);
	const text = out.messages.join('\n');
	assert.match(text, /Instances this hour: 1\/5/);
	assert.match(text, /Last 24 hours: 1\/30/);
	assert.match(text, /Ragefire Chasm \(Testchar-Test Realm\)/);
	assert.match(text, /Molten Core \(40 Player\): resets in 2d 7h, 4\/10/);
	assert.match(text, /Forever may differ/);
});

test('the compact tracker is off until a player turns it on, then shows while it matters and follows its settings', () => {
	const [out] = run(`
		local f = stub.frame("PolestarInstanceTracker")
		m.enter("Ragefire Chasm", 389)
		local default = f:IsShown()
		Polestar.Set("maps.instanceDisplay", true)
		local inside = { shown = f:IsShown(), count = f.Count:GetText(), run = f.Run:GetText() }
		m.leave()
		local after = f:IsShown()
		Polestar.Set("maps.instanceDisplay", false)
		local off = f:IsShown()
		Polestar.Set("maps.instanceDisplay", true)
		Polestar.Set("maps.perHour", 1)
		local capped = f.Wait:GetText()
		m.jump(3601)
		stub.advance(1.1)
		emit({ default = default, inside = inside, after = after, off = off, capped = capped, expired = f:IsShown() })`);
	assert.equal(out.default, false, 'off by default, even inside a new instance');
	assert.deepEqual(out.inside, { shown: true, count: '1/5 this hour', run: 'Ragefire Chasm' });
	assert.equal(out.after, true, 'still shown while an entry is inside the hour');
	assert.equal(out.off, false);
	assert.equal(out.capped, 'next in 1:00:00', 'the only entry is a second old');
	assert.equal(out.expired, false, 'hidden once the hour has passed');
});

// ---------------------------------------------------------------------------
// World map zone info
// ---------------------------------------------------------------------------

test('the world map shows zone ranges on the continent, the hovered zone, and player/cursor coordinates', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua'],
		before: 'stub.maps.useWorld(); stub.maps.withMapCanvas(); stub.maps.place(0, 800); stub.world.level = 8',
		addons: [{ name: 'Polestar', files: FILES }],
		login: true,
		script: `
			local M, m = Polestar.Maps, stub.maps
			M.RegisterZoneLevels({ [9000] = { 10, 20, 50, 50 } })
			local function labels()
				local out = {}
				for _, f in ipairs(stub.frames) do
					if f.parent == stub.maps.canvas and f.Range and f:IsShown() then
						local p = f.points[1]
						out[#out + 1] = { name = f.Name:GetText(), range = f.Range:GetText(), x = p.x, y = p.y, scale = f:GetScale() }
					end
				end
				return out
			end
			local bar = stub.frame("PolestarMapInfo")
			m.showMap(9100)
			m.cursor = { 0.4, 0.3 }
			stub.advance(0.2)
			local continent = { labels = labels(), zone = bar.Zone:GetText(), coords = bar.Coords:GetText() }
			m.canvasScale = 2
			for p in pairs(WorldMapFrame.dataProviders) do if p.OnCanvasScaleChanged then p:OnCanvasScaleChanged() end end
			local zoomed = labels()
			m.cursor = nil
			m.showMap(9000)
			stub.advance(0.2)
			local zone = { labels = #labels(), zone = bar.Zone:GetText(), coords = bar.Coords:GetText() }
			Polestar.Set("maps.coords", false)
			Polestar.Set("maps.zoneLevels", false)
			emit({ continent = continent, zoomed = zoomed, zone = zone, hidden = not bar:IsShown() })`,
	}).emitted;
	assert.deepEqual(out.continent.labels, [{ name: 'Testshire', range: '10–20', x: 400, y: -300, scale: 1 }]);
	assert.equal(out.continent.zone, 'Testshire  10–20');
	assert.equal(out.continent.coords, 'Player 42.0, 30.0     Cursor 40.0, 30.0');
	assert.deepEqual(out.zoomed, [{ name: 'Testshire', range: '10–20', x: 800, y: -600, scale: 0.5 }], 'labels keep their size when zooming');
	assert.equal(out.zone.labels, 0, 'labels are for continent maps');
	assert.equal(out.zone.zone, 'Testshire  10–20');
	assert.equal(out.zone.coords, 'Player 10.0, 50.0');
	assert.equal(out.hidden, true);
});

// ---------------------------------------------------------------------------
// Options
// ---------------------------------------------------------------------------

test('every Maps setting is registered with a label and help: map features on the Map page, flights and instances under Quality of Life', () => {
	const [out] = run(`
		local pages, missing = {}, {}
		for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
			for _, c in ipairs(spec.controls) do
				if c.key and c.key:find("^maps%.") then
					if not (c.label and c.help) then missing[#missing + 1] = c.key end
					pages[spec.page] = pages[spec.page] or {}
					table.insert(pages[spec.page], c.key)
				end
			end
		end
		emit({ pages = pages, missing = table.concat(missing, ",") })`);
	assert.equal(out.missing, '');
	assert.deepEqual(Object.keys(out.pages).sort(), ['Map', 'Quality of Life']);
	assert.deepEqual(out.pages.Map.sort(), [
		'maps.coords', 'maps.dockPins', 'maps.dungeonPins', 'maps.innPins', 'maps.minimapCoords', 'maps.reveal',
		'maps.taxiPins', 'maps.travelMinimap', 'maps.zoneLevels',
	]);
	assert.deepEqual(out.pages['Quality of Life'].sort(), [
		'maps.flightTimer', 'maps.instanceDisplay', 'maps.instances', 'maps.perDay', 'maps.perHour',
	]);
});
