'use strict';
// Travel planner (addon/Polestar/Nav/Travel.lua): Dijkstra over walking,
// known flights, transports, the Hearthstone and learned paths, and how the
// arrow follows the route. Runs the real Core/Init.lua + Nav/Nav.xml against
// tests/lua/stub_nav.lua with a small fixture travel world (stub.nav.useTravelWorld).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { fakeLocale } = require('./helpers/locale');

const NAV = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] };

const PRELUDE = `
local N = Polestar.Nav
local A = N.arrow
local nav = stub.nav
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "Target")
end
local function route()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci or 1, legs and #legs or 0 do
		local l = legs[i]
		out[#out + 1] = l.kind .. "|" .. l.label
	end
	return out
end
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
`;

function run(script, { flightYards, before } = {}) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		before,
		addons: [NAV],
		login: true,
		script: `${PRELUDE}
nav.faction = "Alliance"
nav.useTravelWorld(${flightYards || 'nil'})
${script}`,
	}).emitted;
}

test('every leg caption is in the client language: flight, boat and tram', () => {
	const [out] = run(
		`
		nav.place(0, 600)
		known(1, 2)
		target(0, -780, "Kobolds")
		local flying = route()
		nav.place(0, 0, 1)
		target(-800, 100, "Docks quest")
		local boat = route()
		N.RegisterTravelData({ build = "test", taxi = {}, flights = {}, inns = {},
			transports = { { id = "tram-test", kind = "tram", faction = 1, ab = 100, ba = 100, waitA = 30, waitB = 30,
				a = { "Northgate", 0, 900, 0, 9000, 50, 5 }, b = { "Southgate", 0, -900, 0, 9000, 50, 95 } } } }, true)
		nav.place(890, 0)
		target(-950, 0, "Nightbane Shadow Weavers")
		emit({ flying = flying, boat = boat, tram = route() })`,
		{
			before: fakeLocale('itIT', {
				'Walk to the flight master': 'Geh zum Flugmeister',
				'Fly to %s': 'Flieg nach %s',
				'Walk to the boat': 'Geh zum Schiff',
				'Take the boat to %s': 'Nimm das Schiff nach %s',
				'Take the tram to %s': 'Nimm die Tiefenbahn nach %s',
			}),
		},
	);
	assert.deepEqual(out, {
		flying: ['walk|Geh zum Flugmeister', 'fly|Flieg nach East Hold', 'walk|Kobolds'],
		boat: ['walk|Geh zum Schiff', 'boat|Nimm das Schiff nach Testshire Docks', 'walk|Docks quest'],
		tram: ['tram|Nimm die Tiefenbahn nach Southgate', 'walk|Nightbane Shadow Weavers'],
	});
});

test('takes a known flight over a long walk, and walks when no flight is known', () => {
	const [out] = run(`
		nav.place(0, 600)                        -- 190 yd from West Hold
		known(1, 2)
		target(0, -780, "Kobolds")
		local flying = route()
		local legs = N.GetRoute()
		local total = legs[1].seconds + legs[1].rest
		known()
		target(0, -780, "Kobolds")
		emit({ flying = flying, total = total, walking = route() })`);
	assert.deepEqual(out.flying, ['walk|Walk to the flight master', 'fly|Fly to East Hold', 'walk|Kobolds']);
	assert.ok(out.total < 1380 / 7, `flying (${out.total} s) beats walking 1380 yd`);
	assert.deepEqual(out.walking, ['walk|Kobolds']);
});

test('never flies through a node the character does not know or cannot use', () => {
	const [out] = run(`
		nav.place(0, 790)
		known(1)                                  -- East Hold unknown
		target(0, -780)
		local unknownEnd = route()
		known(1, 3)                               -- Horde Roost "known" by an Alliance character
		target(500, -790)
		emit({ unknownEnd = unknownEnd, hordeNode = route() })`);
	assert.deepEqual(out.unknownEnd, ['walk|Target']);
	assert.deepEqual(out.hordeNode, ['walk|Target']);
});

test('crosses continents by boat', () => {
	const [out] = run(`
		nav.place(0, 0, 1)                        -- Farland, continent 1
		target(-800, 100, "Docks quest")
		local legs = N.GetRoute()
		emit({ route = route(), to = { legs[2].to.name, legs[2].to.c }, boatSecs = legs[2].seconds })`);
	assert.deepEqual(out.route, ['walk|Walk to the boat', 'boat|Take the boat to Testshire Docks', 'walk|Docks quest']);
	assert.deepEqual(out.to, ['Testshire Docks', 0]);
	assert.equal(out.boatSecs, 90, 'wait + ride');
});

test('hearths only when the stone is ready and it is actually faster', () => {
	const [out] = run(`
		local r = {}
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		r.ready = route()
		stub.advance(10)                          -- the client clock never reads 0
		nav.hearthCooldown = { GetTime(), 3600 }
		target(-520, -690, "Innkeeper quest")
		r.cooldown = route()
		nav.hearthCooldown = nil
		nav.place(-300, -700, 0)                  -- 200 yd from the target: walking is faster
		target(-520, -690, "Innkeeper quest")
		r.near = route()
		nav.items[6948] = nil
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		r.noStone = route()[2]
		emit(r)`);
	assert.deepEqual(out.ready, ['hearth|Hearth to Testshire Inn', 'walk|Innkeeper quest']);
	assert.deepEqual(out.cooldown, ['walk|Walk to the boat', 'boat|Take the boat to Testshire Docks', 'walk|Innkeeper quest']);
	assert.deepEqual(out.near, ['walk|Innkeeper quest']);
	assert.equal(out.noStone, 'boat|Take the boat to Testshire Docks');
});

test('the cooldown running out triggers a new plan with the hearth', () => {
	const [out] = run(`
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		stub.advance(10)
		nav.hearthCooldown = { GetTime(), 5 }
		nav.place(0, 0, 1)
		target(-520, -690, "Q")
		local before = route()[1]
		stub.advance(6.5)
		emit({ before = before, after = route()[1] })`);
	assert.equal(out.before, 'walk|Walk to the boat');
	assert.equal(out.after, 'hearth|Hearth to Testshire Inn');
});

// A hearth leg has no direction: the arrow's dial shows the Hearthstone glyph
// instead of an empty space above "Hearth to ...".
test('a hearth instruction shows the Hearthstone glyph on the arrow dial', () => {
	const [out] = run(`
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		stub.advance(0.2)
		emit({ A.GetMode(), A.distText:GetText(), A.dial:IsShown(), A.legIcon:IsShown(), (A.legIcon:GetTexture() or ""):match("[^\\\\]+$") })`);
	assert.deepEqual(out, ['instruction', 'Hearth to Testshire Inn', true, true, 'icon-hearth']);
});

test('learned walking paths change the route', () => {
	const [out] = run(
		`
		nav.place(0, 790)
		known(1, 2)
		target(0, -790)
		local before = route()
		N.AddTravelPaths({ nodes = { 0, 0, 780, 0, 9000,  0, 0, 0, 0, 9000,  0, 0, -780, 0, 9000 } })
		N.AddTravelPaths({ edges = { 1, 2, 780, 2, 3, 780 } })
		target(0, -790)
		local legs = N.GetRoute()
		emit({ before = before, after = route(), secs = legs[1].seconds })`,
		{ flightYards: 7500 },
	);
	assert.deepEqual(out.before, ['fly|Fly to East Hold', 'walk|Target']);
	assert.deepEqual(out.after, ['walk|Target']);
	assert.ok(out.secs < 1580 * 1.25 / 7, `the learned path (${out.secs} s) beats a straight-line estimate`);
});

test('the arrow follows the legs: walk, act at the flight master, re-plan on landing', () => {
	const [out] = run(`
		local r, changes = {}, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		stub.advance(0.2)
		r.walk = { A.GetMode(), A.distText:GetText(), A.labelText:GetText(), A.etaText:GetText(), A.GetAngle() }
		nav.place(0, 785)                         -- at the flight master
		stub.advance(0.2)
		r.at = { A.GetMode(), A.distText:GetText(), A.labelText:GetText(), A.dial:IsShown(), (A.legIcon:GetTexture() or ""):match("[^\\\\]+$") }
		nav.taxi = true
		stub.advance(0.2)
		r.flying = A.frame:IsShown()
		nav.place(0, -795)
		nav.taxi = false
		stub.advance(1.2)                         -- landed: the ticker re-plans
		r.landed = { A.GetMode(), A.distText:GetText(), A.labelText:GetText() }
		r.route = route()
		r.changes = changes
		emit(r)`);
	assert.equal(out.walk[0], 'travel');
	assert.equal(out.walk[1], '190 yd');
	assert.equal(out.walk[2], 'Walk to the flight master');
	assert.match(out.walk[3], /^\d+:\d\d total$/);
	assert.ok(Math.abs(Math.abs(out.walk[4]) - Math.PI / 2) < 1e-3, 'points west at the flight master');
	assert.deepEqual(out.at, ['instruction', 'Fly to East Hold', 'Kobolds', true, 'icon-fly'], 'the dial shows the flight glyph');
	assert.equal(out.flying, false);
	assert.deepEqual(out.landed, ['travel', '15 yd', 'Kobolds']);
	assert.deepEqual(out.route, ['walk|Kobolds']);
	assert.ok(out.changes >= 2, 'ROUTE_CHANGED on plan and re-plan');
});

test('opening the flight map records known nodes and re-plans', () => {
	const [out] = run(`
		nav.place(0, 790)
		target(0, -780)
		local before = route()
		nav.taxiMap = { mapID = 1415, nodes = { 1, 2 } }
		stub.fire("TAXIMAP_OPENED", 1)
		local saved = Polestar.CharState().flags.taxi
		emit({ before = before, after = route(), saved = { saved[1] == true, saved[2] == true, saved[3] == true } })`);
	assert.deepEqual(out.before, ['walk|Target']);
	assert.deepEqual(out.after, ['fly|Fly to East Hold', 'walk|Target']);
	assert.deepEqual(out.saved, [true, true, false]);
});

test('binding at an innkeeper teaches Nav what the bind location means', () => {
	const [out] = run(`
		nav.items[6948] = 1
		nav.bind = "Lion's Den Tavern"              -- a name the data does not list
		nav.place(0, 0, 1)
		target(-520, -690, "Q")
		local before = route()[1]
		nav.place(-505, -700, 0)                     -- standing at the innkeeper
		stub.fire("HEARTHSTONE_BOUND")
		nav.place(0, 0, 1)
		target(-520, -690, "Q")
		emit({ before = before, after = route()[1], learned = Polestar.CharState().flags.inn })`);
	assert.equal(out.before, 'walk|Walk to the boat');
	assert.equal(out.after, "hearth|Hearth to Lion's Den Tavern");
	assert.deepEqual(out.learned, { "lion's den tavern": 900 });
});

test('a target change re-plans; nav.travel off falls back to the direct arrow', () => {
	const [out] = run(`
		local r = {}
		known(1, 2)
		nav.place(0, 600)
		target(0, -780)
		r.first = #route()
		target(0, 500)
		r.second = route()
		target(0, -780)
		Polestar.Set("nav.travel", false)
		stub.advance(0.2)
		r.off = { N.GetRoute() == nil, A.GetMode(), A.labelText:GetText() }
		Polestar.Set("nav.travel", true)
		r.on = #route()
		emit(r)`);
	assert.equal(out.first, 3);
	assert.deepEqual(out.second, ['walk|Target']);
	assert.deepEqual(out.off, [true, 'travel', 'Target']);
	assert.equal(out.on, 3);
});

test('world map shows the final target pin plus the route waypoints', () => {
	const [out] = run(`
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		nav.showWorldMap(9000)
		local pins = nav.pins()
		local r = {}
		for _, pin in ipairs(pins) do
			local tip = nav.tooltipOf(pin)
			r[#r + 1] = { pin.data.layer.name, tip[1], tip[2] or false, math.floor(pin.width * 10 + 0.5) / 10 }
		end
		emit(r)`);
	assert.deepEqual(out, [
		['nav.target', 'Kobolds', '1380 yd', 22.4],
		['nav.route', 'Fly to East Hold', 'Travel route, step 1/3', 14.4],
		['nav.route', 'Kobolds', 'Travel route, step 2/3', 14.4],
	]);
});

test('EstimateTravel prices trips with the planner, caches briefly, and leaves the route alone', () => {
	const [out] = run(`
		local r, changes = {}, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		nav.place(0, 600)
		local m, x, y = nav.mapPoint(0, -780)
		local far = { map = m, x = x, y = y }
		r.walking = N.EstimateTravel(nil, far)
		known(1, 2)
		r.cached = N.EstimateTravel(nil, far)          -- same start cell within 5 s: cached
		stub.advance(6)
		r.flying = N.EstimateTravel(nil, far)
		local fm, fx, fy = nav.mapPoint(0, 780)
		r.fromPoint = N.EstimateTravel({ map = fm, x = fx, y = fy }, far)
		r.crossSea = N.EstimateTravel(nil, { map = 9001, x = 50, y = 50 })
		r.unknownMap = N.EstimateTravel(nil, { map = 4242, x = 50, y = 50 })
		r.route = N.GetRoute() == nil
		r.changes = changes
		emit(r)`);
	assert.ok(Math.abs(out.walking - (1380 * 1.25) / 7) < 2, `walk estimate ${out.walking}`);
	assert.equal(out.cached, out.walking);
	assert.ok(out.flying < out.walking / 2, `known flight is cheaper (${out.flying} s)`);
	assert.ok(out.fromPoint < out.flying, 'from the flight master itself is quicker still');
	assert.ok(out.crossSea > 0, 'the boat reaches the other continent');
	assert.equal(out.unknownMap, undefined);
	assert.equal(out.route, true, 'no route was planned');
	assert.equal(out.changes, 0, 'no ROUTE_CHANGED');
});

test('EstimateTravel stays cheap for a burst of candidates on the real network', () => {
	const [out] = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [NAV],
		login: true,
		script: `
			local N, nav = Polestar.Nav, stub.nav
			nav.faction = "Alliance"
			Polestar.RegisterMapFrames({ era = { [1436] = { c = 0, left = 3016.667, right = -483.333, top = -9400, bottom = -11733.333 },
				[1433] = { c = 0, left = -1570.833, right = -3741.667, top = -8575, bottom = -10022.916 } } })
			nav.place(-10500, 1046, 0)
			Polestar.CharState().flags.taxi = { [2] = true, [4] = true, [5] = true }
			local t0 = os.clock()
			local first
			for i = 1, 10 do
				local s = N.EstimateTravel(nil, { map = 1433, x = 20 + i, y = 44, f = "e" })
				first = first or s
			end
			emit({ ms = (os.clock() - t0) * 1000, first = first })`,
	}).emitted;
	assert.ok(out.first > 0 && out.first < 600, `Sentinel Hill -> Redridge by air: ${out.first} s`);
	assert.ok(out.ms < 200, `10 estimates took ${out.ms.toFixed(1)} ms`);
});

test('only discovered flight masters are recorded from the flight map', () => {
	const [out] = run(`
		nav.place(0, 790)
		target(0, -780)
		-- Current (0) here, East Hold listed as Unreachable (2): a pass-through node, not discovered.
		nav.taxiMap = { mapID = 1415, nodes = { { 1, 0 }, { 2, 2 } } }
		stub.fire("TAXIMAP_OPENED", 1)
		local saved = Polestar.CharState().flags.taxi
		local r = { saved = { saved[1] == true, saved[2] == true }, route = route() }
		nav.taxiMap = { mapID = 1415, nodes = { { 1, 0 }, { 2, 1 } } }
		stub.fire("TAXIMAP_OPENED", 1)
		r.after = route()
		emit(r)`);
	assert.deepEqual(out.saved, [true, false]);
	assert.deepEqual(out.route, ['walk|Target'], 'no flight to an undiscovered node');
	assert.deepEqual(out.after, ['fly|Fly to East Hold', 'walk|Target']);
});

test('the Hearthstone coming off cooldown mid-ride does not re-plan from the boat', () => {
	const [out] = run(`
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		stub.advance(10)
		nav.hearthCooldown = { GetTime(), 30 }
		nav.place(395, 0, 1)                             -- at Farland Pier
		target(-520, -690, "Q")
		stub.advance(0.2)
		local before = route()
		nav.place(200, 0, 1)                             -- sailing away from the pier
		stub.advance(35)                                 -- the stone comes off cooldown on the way (at 40 s)
		emit({ before = before, during = route(), leg = (select(2, N.GetRoute())) })`);
	assert.deepEqual(out.before, ['boat|Take the boat to Testshire Docks', 'walk|Q']);
	assert.deepEqual(out.during, out.before, 'still on the boat leg');
	assert.equal(out.leg, 1);
});

// Playtest: at Auberdine the walk to the boat ended at the ship's stop, in
// the water off the pier, and swam. An end with a board point (TravelData's
// 10th field, after the area: the deck, from the navigation grid) is the dock: the walk ends
// there, with its height, and boarding, leaving and arrival measure from it.
// The board points here lie 70 yd off their stops (real ones are 12-14 yd),
// past BOARD (60 yd), so measuring from the stop shows.
test('a boat end with a board point: the walk ends on the deck, and arriving there boards', () => {
	const [out] = run(`
		N.RegisterTravelData({ build = "test", taxi = {}, flights = {}, inns = {},
			transports = { { id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
				a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95, "e", nil, { wx = -900, wy = 70, z = 5.9 } },
				b = { "Farland Pier", 1, 400, 0, 9001, 50, 10, "e", nil, { wx = 400, wy = 70, z = 4.5 } } } } }, true)
		local function at(p) return p and { p.c, p.wx, p.wy, p.z or "none" } end
		local r = {}
		nav.place(0, 0, 1)                               -- Farland, continent 1
		target(-800, 100, "Docks quest")
		stub.advance(0.2)
		local legs = N.GetRoute()
		r.route = route()
		r.walkTo, r.rideFrom, r.rideTo = at(legs[1].to), at(legs[2].from), at(legs[2].to)
		r.stop = at(N.GetTravelData().transports[1].b)
		nav.place(400, 70, 1)                            -- on the deck at the board point (70 yd from the stop)
		stub.advance(0.2)
		r.atDeck = { (select(2, N.GetRoute())), route()[1] }
		nav.place(250, 70, 1)                            -- sailing away: 150 yd from the deck
		stub.advance(0.2)
		stub.advance(1.2)
		r.sailing = { (select(2, N.GetRoute())), route()[1] }
		nav.place(-900, 70)                              -- landed on the Testshire deck
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.advance(1.2)
		r.landed = route()
		emit(r)`);
	assert.deepEqual(out.route, ['walk|Walk to the boat', 'boat|Take the boat to Testshire Docks', 'walk|Docks quest']);
	assert.deepEqual(out.walkTo, [1, 400, 70, 4.5], 'the walk ends at the board point, with its height');
	assert.deepEqual(out.rideFrom, [1, 400, 70, 4.5], 'the ride is boarded there');
	assert.deepEqual(out.rideTo, [0, -900, 70, 5.9], 'and arrives at the far deck');
	assert.deepEqual(out.stop, [1, 400, 0, 'none'], 'the transport end stays the ship\'s stop');
	assert.deepEqual(out.atDeck, [2, 'boat|Take the boat to Testshire Docks'], 'at the deck: the ride');
	assert.deepEqual(out.sailing, [2, 'boat|Take the boat to Testshire Docks'], 'boarded at the deck: sailing away is the ride, no new plan');
	assert.deepEqual(out.landed, ['walk|Docks quest']);
});

// Igotthis rode the Deeprun Tram toward Duskwood and the arrow vanished: the
// tram is a map of its own (Map 369, no UiMap), so the client gives no player
// position on the ride. The arrow keeps the ride's caption and glyph, and
// points again on arrival.
test('on the tram, with no player position, the arrow keeps the ride caption and resumes on arrival', () => {
	const [out] = run(`
		N.RegisterTravelData({ build = "test", taxi = {}, flights = {}, inns = {},
			transports = { { id = "tram-test", kind = "tram", faction = 1, ab = 100, ba = 100, waitA = 30, waitB = 30,
				a = { "Northgate", 0, 900, 0, 9000, 50, 5 }, b = { "Southgate", 0, -900, 0, 9000, 50, 95 } } } }, true)
		local function snap()
			return { A.frame:IsShown(), A.GetMode() or "hidden", A.distText:GetText(), A.labelText:GetText(), A.dial:IsShown(),
				A.legIcon:IsShown(), (A.legIcon:GetTexture() or ""):match("[^\\\\]+$"), table.concat(route(), ", ") }
		end
		local r = {}
		nav.place(890, 0)                          -- at the Northgate door
		target(-950, 0, "Nightbane Shadow Weavers")
		stub.advance(0.2); r.door = snap()
		nav.player = nil                           -- through the portal: no position on the ride
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.advance(1.2); r.riding = snap()
		stub.advance(60); r.later = snap()
		nav.place(-895, 0)                         -- out at Southgate
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.advance(1.2); r.arrived = snap()
		emit(r)`);
	const RIDE = [true, 'instruction', 'Take the tram to Southgate', 'Nightbane Shadow Weavers', true, true, 'icon-boat',
		'tram|Take the tram to Southgate, walk|Nightbane Shadow Weavers'];
	assert.deepEqual(out.door, RIDE);
	assert.deepEqual(out.riding, RIDE, 'the ride keeps its caption with no position');
	assert.deepEqual(out.later, RIDE);
	assert.deepEqual(out.arrived, [true, 'travel', '55 yd', 'Nightbane Shadow Weavers', true, false, 'icon-boat', 'walk|Nightbane Shadow Weavers']);
});

test('walk legs are priced unmounted, so a fast mount never swaps a flight for a straight swim', () => {
	const [out] = run(
		`
		known(1, 2)
		nav.place(0, 600)
		nav.runSpeed = 7
		target(0, -780)
		local foot = route()
		nav.runSpeed = 14                                -- mounted
		target(0, -780)
		emit({ foot = foot, mounted = route() })`,
		{ flightYards: 4000 },
	);
	assert.deepEqual(out.foot, ['walk|Walk to the flight master', 'fly|Fly to East Hold', 'walk|Target']);
	assert.deepEqual(out.mounted, out.foot);
});

test('EstimateTravel takes a live-frame start and an Era-frame destination on a re-framed map', () => {
	const [out] = run(`
		-- Map 9000's Era frame is shifted from the live one (like Mulgore 1412).
		Polestar.RegisterMapFrames({ era = { [9000] = { c = 0, top = 1030, bottom = -970, left = 960, right = -1040 } } })
		nav.place(0, 0)
		local fm, fx, fy = nav.mapPoint(0, 0)            -- the player's live map position, no f
		local here = { map = fm, x = fx, y = fy }
		-- Era (50, 50) is world (30, -40): 50 yd away; the same numbers in the live frame are 0 yd away.
		local era = N.EstimateTravel(here, { map = 9000, x = 50, y = 50, f = "e" })
		local live = N.EstimateTravel(here, { map = 9000, x = 50, y = 50 })
		local ok, bad = pcall(N.EstimateTravel, here, { map = 4242, x = 1, y = 1, f = "e" })
		emit({ era = era, live = live, ok = ok, bad = bad == nil })`);
	assert.ok(Math.abs(out.era - (50 * 1.25) / 7) < 1.5, `era estimate ${out.era}`);
	assert.ok(out.live <= 1, `live estimate ${out.live}`);
	assert.deepEqual([out.ok, out.bad], [true, true]);
});
