-- Transit: when boats, zeppelins, the Deeprun Tram and lifts leave, and
-- which class teleports this character can cast now, for the travel planner
-- (Travel.lua), its captions and the alerts.
--
-- Ported from Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later,
-- used with permission): Transport/Model.lua, Timetable.lua, Observer.lua,
-- Sync.lua and Teleports.lua.
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
--
-- Every transport runs a fixed loop (TravelData.lua: `travel build` from the
-- CMaNGOS transport model, the client's TransportAnimation tracks and the
-- periods CMaNGOS classic-db sniffed), but where in its loop it is depends
-- on the server's uptime, which no API tells. So the loop is timed by
-- watching: riding a transport, the player's positions are matched against
-- the loop's track, and the phase most samples agree on dates the loop (a
-- sighting: epoch = server ms at phase 0). Sightings last six hours (a
-- restart resets the loops), are kept per realm, and, with nav.shareTransit
-- (off by default), shared with the guild and group on this realm, whose
-- sightings then count too (your own ride always wins).
-- Untimed, a ride costs its expected wait: the mean over the loop.
--
-- API (times in seconds; `now` = Transit.Now(), server time with a fraction;
-- `id` = a TravelData transport id, the transport entry itself, or a lift
-- id from LiftNear; `side` = "a"|"b" (the end boarded at), "top"|"bottom"
-- for lifts, nil = whichever leaves first):
--   Transit.NextDeparture(kind, id, now, side) -> wait, ride, timed
--       wait from `now` until it leaves with you aboard (`now` = when you
--       reach the dock); ride until you are off at the other end. Untimed:
--       the expected values, timed = false. nil for an unknown id.
--   Transit.NextArrival(kind, id, now, side) -> arriveIn (0 = there now),
--       departIn; nil while untimed
--   Transit.Caption(kind, id, now, side) -> "Next boat in 1:20", "Boat
--       docked, leaves in 0:40", untimed "Next boat in about 2:55"; nil for
--       an unknown id
--   Transit.Riding(now) -> { kind, route, dock, arriveIn } | nil   (dock: its name to show)
--   Transit.LiftNear(c, wx, wy [, yards]) -> liftId, name (to show)
--   Transit.Teleports(now) -> usable class teleports, see below
-- Fires ns.Fire("NAV_TRANSIT", changed, own) when a sighting changes a
-- timing or the usable teleports change: changed = { [service id] = kind }
-- of the transports and lifts whose timing moved (nil: anything, e.g. the
-- teleports), own = true for the player's own ride or teleports (fired at
-- once), nil for shared sightings (gathered and fired at most every 20 s).

local ADDON, ns = ...
local L = ns.L

local Transit = {}
ns.Transit = Transit

ns.RegisterDefaults("nav", { teleports = true, shareTransit = false })

local type, pairs, ipairs, next, pcall = type, pairs, ipairs, next, pcall
local floor, ceil, max, min, huge, sqrt = math.floor, math.ceil, math.max, math.min, math.huge, math.sqrt
local format, concat = string.format, table.concat

local MAX_AGE = 6 * 3600     -- s: a sighting older than this is dropped (a restart resets the loops)
local OWN_TRUST = 3600       -- s: your own sighting this recent is not replaced by another player's
local CLOCK_SLACK = 5        -- s: how far ahead of this clock a shared sighting may be dated
local NEAR, NEAR_LIFT = 40, 10 -- yd: a position this close to a moving leg is on it
local AGREE, AGREE_LIFT = 8000, 2000 -- ms: phase offsets this close are one transport
local CLEAR_LEAD = 1.25      -- the winning route's support over the runner-up's
local RIDE_GAP = 30000       -- ms: no matching sample for this long ends a ride
local FIT_EVERY = 10         -- samples between fits during a ride
local MAX_SAMPLES = 300      -- per route and ride
local QUIET = 600            -- s: a repeat of your own sighting this recent is routine
local SAMPLE_EVERY = 1       -- s
local LIFT_NEAR = 40         -- yd: LiftNear's default reach
local GCD = 1.5

---------------------------------------------------------------------------
-- Data (TravelData.lua calls Register)
---------------------------------------------------------------------------

local routes, services, teleportData = {}, {}, {}
local routeEnds, stopName = {}, {} -- [route] = service | { { name, area }, ... } (its ends); [route][stop index] = { name, area } | a landing's word
local routeServices = {}           -- [route] = { [service id] = kind }: who a sighting retimes

-- Names to show, in the client's language (Polestar.Names: the AreaTable
-- area a place, tram or lift is named by), else the data's English.
local LIFT_OF = { north = L["%s, north lift"], south = L["%s, south lift"], east = L["%s, east lift"], west = L["%s, west lift"] }

local function areaName(name, area)
	local N = ns.Names
	return (area and N and N.Area(area)) or name
end

local function serviceName(s)
	local N = ns.Names
	local place = s.area and N and N.Area(s.area)
	if not place then return s.name end
	return s.dir and LIFT_OF[s.dir] and format(LIFT_OF[s.dir], place) or place
end

local function routeName(id)
	local e = routeEnds[id]
	if not e then return nil end
	if e.kind then return serviceName(e) end
	local out = {}
	for i, p in ipairs(e) do out[i] = areaName(p[1], p[2]) end
	return concat(out, " - ")
end

local function dockName(d)
	if type(d) == "table" then return areaName(d[1], d[2]) end
	return d
end

local function pointOf(t)
	return t and { name = t[1], c = t[2], wx = t[3], wy = t[4], map = t[5], x = t[6], y = t[7], f = t[8] or "e", area = t[9] }
end

function Transit.Register(d)
	if type(d) ~= "table" then return end
	routes, services, teleportData = d.routes or {}, d.services or {}, {}
	routeEnds, stopName, routeServices = {}, {}, {}
	-- Each car's frames: a loop's cars follow one another, each ending on a
	-- jump frame (the Great Lift's two cars share a loop but not a place).
	for _, route in pairs(routes) do
		local cars, first = {}, 1
		for i, f in ipairs(route.frames or {}) do
			if (f[6] or 0) ~= 0 or i == #route.frames then
				cars[#cars + 1] = { first, i }
				first = i + 1
			end
		end
		route.cars = cars
	end
	local ids = {}
	for id in pairs(services) do ids[#ids + 1] = id end
	table.sort(ids)
	for _, id in ipairs(ids) do
		local s = services[id]
		local names = {}
		if s.kind == "lift" then
			names = { L["top"], L["bottom"] }
		else
			for k, n in ipairs(s.ends or {}) do names[k] = { n, s.areas and s.areas[k] } end
		end
		for _, part in ipairs(s.routes or {}) do
			local stops = stopName[part.route] or {}
			stopName[part.route] = stops
			local retimes = routeServices[part.route] or {}
			routeServices[part.route] = retimes
			retimes[id] = s.kind
			for k, side in ipairs({ "a", "b" }) do
				for _, i in ipairs(part[side] or {}) do stops[i] = stops[i] or names[k] end
			end
			if s.kind == "lift" or s.kind == "tram" then
				routeEnds[part.route] = s
			else
				local list = routeEnds[part.route] or {}
				routeEnds[part.route] = list
				for _, n in ipairs(names) do
					local seen = false
					for _, m in ipairs(list) do seen = seen or m[1] == n[1] end
					if not seen then list[#list + 1] = n end
				end
			end
		end
	end
	for i, t in ipairs(d.teleports or {}) do
		teleportData[i] = { spell = t.spell, name = t.name, cast = t.cast or 10, reagents = t.reagents, bind = t.bind, to = pointOf(t.to) }
	end
end

---------------------------------------------------------------------------
-- Clock: server seconds with a fraction (GetServerTime is whole seconds;
-- GetTime carries the fraction, its offset kept at the largest lead seen).
---------------------------------------------------------------------------

local clockOffset
function Transit.Now()
	local server = GetServerTime and GetServerTime()
	local t = GetTime and GetTime()
	if not (server and t) then return server or 0 end
	local lead = server - t
	if not clockOffset or lead > clockOffset or clockOffset - lead > 2 then clockOffset = lead end
	return t + clockOffset
end

---------------------------------------------------------------------------
-- Sightings: PolestarDB.transit[realm][route] = { epoch = server ms at
-- phase 0, seen = server s, source = "you"|"player" }
---------------------------------------------------------------------------

local realmName
local function store()
	local db = ns.DB()
	if type(db.transit) ~= "table" then db.transit = {} end
	if not realmName then
		local C = ns.Compat
		local ok, info = pcall(C and C.GetPlayerInfo or function() end)
		realmName = ok and type(info) == "table" and type(info.realm) == "string" and info.realm ~= "" and info.realm or nil
	end
	local realm = realmName or "?"
	local s = db.transit[realm]
	if type(s) ~= "table" then
		s = {}
		db.transit[realm] = s
	end
	return s
end

local function fresh(anchor, now)
	return type(anchor) == "table" and type(anchor.epoch) == "number" and type(anchor.seen) == "number"
		and now - anchor.seen <= MAX_AGE and anchor or nil
end

local function anchorOf(route, now)
	return fresh(store()[route], now)
end

-- Whether an incoming sighting replaces the held one. Your own ride always
-- replaces another player's; another player's never replaces a ride of your
-- own under an hour old; otherwise only a newer one counts.
local function newer(incoming, held, now)
	if not fresh(held, now) then return true end
	if incoming.source == "you" and held.source ~= "you" then return true end
	if held.source == "you" and incoming.source ~= "you" and now - held.seen < OWN_TRUST then return false end
	return incoming.seen > held.seen
end

local function sighted(route, anchor, now)
	local s = store()
	if not routes[route] or not newer(anchor, s[route], now) then return false end
	s[route] = { epoch = anchor.epoch, seen = anchor.seen, source = anchor.source }
	return true
end

-- The transports and lifts a route's sighting retimes, as NAV_TRANSIT's `changed`.
local function changedBy(route, into)
	into = into or {}
	for id, kind in pairs(routeServices[route] or {}) do into[id] = kind end
	return into
end

-- Tests and /polestar tools: forget every sighting on this realm.
function Transit.ForgetSightings()
	local db = ns.DB()
	if type(db.transit) == "table" then db.transit[realmName or "?"] = nil end
	ns.Fire("NAV_TRANSIT", nil, true)
end

-- Tests: record a sighting { epoch, seen, source } as if seen or received.
function Transit.Sighted(route, anchor)
	local now = Transit.Now()
	if type(anchor) ~= "table" or not sighted(route, anchor, now) then return false end
	ns.Fire("NAV_TRANSIT", changedBy(route), anchor.source == "you" or nil)
	return true
end

---------------------------------------------------------------------------
-- Loop arithmetic (ms)
---------------------------------------------------------------------------

-- A stop's next visit at `phase`: docked now (arriveIn 0) or arriving in
-- arriveIn; departIn either way. A visit leaving sooner than `board` is too
-- soon to catch: the one after it counts.
local function visit(period, stop, phase, board)
	local arrive = stop[1]
	local stay = (stop[2] - arrive) % period
	local since = (phase - arrive) % period
	local arriveIn
	if since < stay then
		arriveIn = 0
		if stay - since >= board then return 0, stay - since end
		arriveIn = period - since
	else
		arriveIn = (arrive - phase) % period
		if arriveIn + stay < board then arriveIn = arriveIn + period end
	end
	return arriveIn, arriveIn + stay
end

-- ms riding from stop i to the next arrival at any stop of `to`.
local function rideFrom(route, i, to)
	local best, depart, period = huge, route.stops[i][2], route.period
	for _, j in ipairs(to) do
		local r = (route.stops[j][1] - depart) % period
		if r < best then best = r end
	end
	return best
end

local SIDES = { a = "a", b = "b", top = "a", bottom = "b" }

local function serviceOf(id)
	if type(id) == "table" then id = id.id end
	return id and services[id], id
end

-- The soonest timed departure from side `from`: departIn, arriveIn, ride (ms,
-- from `now` + pre), or nil while none of the service's loops is timed.
local function timedFrom(s, from, now, board)
	local to = from == "a" and "b" or "a"
	local t = (now + (s.pre or 0)) * 1000
	local bestD, bestA, bestR
	for _, part in ipairs(s.routes or {}) do
		local route = routes[part.route]
		local anchor = route and anchorOf(part.route, now)
		if anchor then
			local phase = (t - anchor.epoch) % route.period
			for _, i in ipairs(part[from] or {}) do
				local arriveIn, departIn = visit(route.period, route.stops[i], phase, board)
				if not bestD or departIn < bestD then
					bestD, bestA, bestR = departIn, arriveIn, rideFrom(route, i, part[to] or {})
				end
			end
		end
	end
	return bestD, bestA, bestR
end

-- Over the given side, or both when side is nil: the soonest.
local function soonest(s, side, now, board)
	local from = SIDES[side]
	if from then return timedFrom(s, from, now, board) end
	local d, a, r = timedFrom(s, "a", now, board)
	local d2, a2, r2 = timedFrom(s, "b", now, board)
	if d2 and (not d or d2 < d) then return d2, a2, r2 end
	return d, a, r
end

function Transit.NextDeparture(kind, id, now, side)
	local s = serviceOf(id)
	if not s then return nil end
	now = now or Transit.Now()
	local d, _, r = soonest(s, side, now, (s.board or 0) * 1000)
	if d and r < huge then return (s.pre or 0) + d / 1000, r / 1000 + (s.post or 0), true end
	local from = SIDES[side]
	local wait, ride = s.wait or {}, s.ride or {}
	if from then return wait[from], ride[from], false end
	if (wait.b or huge) < (wait.a or huge) then return wait.b, ride.b, false end
	return wait.a, ride.a, false
end

function Transit.NextArrival(kind, id, now, side)
	local s = serviceOf(id)
	if not s then return nil end
	local d, a = soonest(s, side, now or Transit.Now(), 0)
	if not d then return nil end
	local pre = s.pre or 0
	return pre + a / 1000, pre + d / 1000, true
end

local function countdown(seconds)
	seconds = max(0, ceil(seconds))
	return format("%d:%02d", floor(seconds / 60), seconds % 60)
end
Transit.Countdown = countdown

-- The captions, each a literal L["..."] so `i18n keys` finds it.
local HERE = {
	boat = L["Boat docked, leaves in %s"],
	zeppelin = L["Zeppelin docked, leaves in %s"],
	tram = L["Tram boarding, leaves in %s"],
	lift = L["Lift here, leaves in %s"],
}
local NEXT = {
	boat = L["Next boat in %s"],
	zeppelin = L["Next zeppelin in %s"],
	tram = L["Next tram in %s"],
	lift = L["Next lift in %s"],
}

local ABOUT = {
	boat = L["Next boat in about %s"],
	zeppelin = L["Next zeppelin in about %s"],
	tram = L["Next tram in about %s"],
	lift = L["Next lift in about %s"],
}

-- Timed: when it docks, or while docked when it leaves. Untimed: the
-- expected wait, said as "about".
function Transit.Caption(kind, id, now, side)
	local s = serviceOf(id)
	if not s then return nil end
	local k = HERE[s.kind] and s.kind or kind
	if not HERE[k] then return nil end
	now = now or Transit.Now()
	local arriveIn, departIn = Transit.NextArrival(kind, id, now, side)
	if arriveIn then
		if arriveIn <= 0 then return format(HERE[k], countdown(departIn)) end
		return format(NEXT[k], countdown(arriveIn))
	end
	local wait = Transit.NextDeparture(kind, id, now, side)
	if not wait then return nil end
	return format(ABOUT[k], countdown(wait))
end

-- Every lift: { id, name, c, wx, wy, top, bottom } (z of its landings), for
-- splitting a walk at the lifts it rides.
function Transit.Lifts()
	local list = {}
	for id, s in pairs(services) do
		if s.kind == "lift" then
			list[#list + 1] = { id = id, name = serviceName(s), c = s.c, wx = s.wx, wy = s.wy, top = s.top, bottom = s.bottom }
		end
	end
	table.sort(list, function(a, b) return a.id < b.id end)
	return list
end

function Transit.LiftNear(c, wx, wy, yards)
	if not (c and wx and wy) then return nil end
	local reach = yards or LIFT_NEAR
	local best, bestId = reach * reach, nil
	for id, s in pairs(services) do
		if s.kind == "lift" and s.c == c then
			local dx, dy = s.wx - wx, s.wy - wy
			local d = dx * dx + dy * dy
			if d <= best and (not bestId or d < best or id < bestId) then best, bestId = d, id end
		end
	end
	if bestId then return bestId, serviceName(services[bestId]) end
	return nil
end

---------------------------------------------------------------------------
-- Watching rides (Shortest Path Forever's observer)
---------------------------------------------------------------------------

-- Every phase (ms) at which a route passes within reach of the position
-- while moving; a docked transport stands still, so a stop yields none.
local function phases(route, map, x, y, z, out)
	for i = #out, 1, -1 do out[i] = nil end
	local frames = route.frames
	local near = route.kind == "lift" and NEAR_LIFT or NEAR
	for i = 1, #frames - 1 do
		local a, b = frames[i], frames[i + 1]
		if a[3] == map and (a[6] or 0) == 0 then
			local dx, dy = b[4] - a[4], b[5] - a[5]
			local dz, oz = 0, 0
			if z and a[7] and b[7] then dz, oz = b[7] - a[7], z - a[7] end
			local length = dx * dx + dy * dy + dz * dz
			local t = 0
			if length > 0 then t = min(1, max(0, ((x - a[4]) * dx + (y - a[5]) * dy + oz * dz) / length)) end
			local px, py, pz = a[4] + t * dx - x, a[5] + t * dy - y, t * dz - oz
			if t > 0 and t < 1 and px * px + py * py + pz * pz <= near * near then
				out[#out + 1] = a[2] + t * (b[1] - a[2])
			end
		end
	end
	return out
end

-- The epoch most samples of one ride agree on, and how many agree (nil when
-- too few do, or they span too little time: someone standing near a leg
-- drifts a second per second, a rider holds for the whole leg).
local function fitEpoch(route, samples)
	local period, offsets = route.period, {}
	local fit = route.fit or {}
	local agree = route.kind == "lift" and AGREE_LIFT or AGREE
	for _, sample in ipairs(samples) do
		for _, p in ipairs(sample.phases) do
			offsets[#offsets + 1] = { offset = (sample.now - p) % period, now = sample.now }
		end
	end
	local best, support = nil, 0
	for _, center in ipairs(offsets) do
		local members, sum, first, last = 0, 0, huge, -huge
		for _, other in ipairs(offsets) do
			local delta = (other.offset - center.offset + period / 2) % period - period / 2
			if delta <= agree / 2 and delta >= -agree / 2 then
				members, sum = members + 1, sum + delta
				if other.now < first then first = other.now end
				if other.now > last then last = other.now end
			end
		end
		if members > support and last - first >= (fit.span or 30000) then
			best, support = (center.offset + sum / members) % period, members
		end
	end
	if support < (fit.samples or 10) then return nil, support end
	return best, support
end

-- The route a ride was on: the best supported fit, clearly ahead of every
-- other (loops sharing a lane both fit the shared part).
local function rideRoute(fits)
	local best, runnerUp
	for id, fit in pairs(fits) do
		if not best or fit.support > fits[best].support or (fit.support == fits[best].support and id < best) then
			if best and (not runnerUp or fits[best].support > runnerUp) then runnerUp = fits[best].support end
			best = id
		elseif not runnerUp or fit.support > runnerUp then
			runnerUp = fit.support
		end
	end
	if best and (not runnerUp or fits[best].support >= CLEAR_LEAD * runnerUp) then return best end
	return nil
end

Transit.fitEpoch, Transit.rideRoute, Transit.phases = fitEpoch, rideRoute, phases -- tests

local ride            -- { samples = { [route] = {...} }, count, last = ms, announced = route }
local previous = {}
local scratch = {}

local function position()
	local C = ns.Compat
	if not (C and C.GetPlayerUnitPosition) then return nil end
	return C.GetPlayerUnitPosition()
end

local function speedOf(nowMs, x, y, z, map)
	local speed = 0
	if previous.map == map and nowMs > previous.now then
		local dx, dy, dz = x - previous.x, y - previous.y, z - previous.z
		speed = sqrt(dx * dx + dy * dy + dz * dz) * 1000 / (nowMs - previous.now)
	end
	previous.now, previous.x, previous.y, previous.z, previous.map = nowMs, x, y, z, map
	return speed
end

local share -- forward: the sync below

local function record()
	if not ride then return end
	local fits = {}
	for id, samples in pairs(ride.samples) do
		local epoch, support = fitEpoch(routes[id], samples)
		if epoch then fits[id] = { epoch = epoch, support = support } end
	end
	local id = rideRoute(fits)
	if not id then return end
	local now = Transit.Now()
	local held = anchorOf(id, now)
	local routine = held and held.source == "you" and now - held.seen < QUIET
	-- Announced (no more fits until the ride ends) only once it is stored.
	if sighted(id, { epoch = fits[id].epoch, seen = floor(now), source = "you" }, now) then
		ride.announced = id
		if not routine then
			ns.Print(format(L["Timed the %s from your ride."], routeName(id) or id))
			if share then share(id) end
		end
		ns.Fire("NAV_TRANSIT", changedBy(id), true)
	end
end

local function sample()
	local nowMs = Transit.Now() * 1000
	local x, y, z, map = position()
	local C = ns.Compat
	local onTaxi = C and C.IsOnTaxi and C.IsOnTaxi()
	local speed = x and not onTaxi and speedOf(nowMs, x, y, z or 0, map) or 0
	if speed > 0 then
		for id, route in pairs(routes) do
			local fit = route.fit or {}
			if speed >= (fit.speed or 12) then
				local found = phases(route, map, x, y, z, scratch)
				if #found > 0 then
					scratch = {}
					ride = ride or { samples = {}, count = 0 }
					local list = ride.samples[id] or {}
					ride.samples[id] = list
					list[#list + 1] = { now = nowMs, phases = found }
					if #list > MAX_SAMPLES then table.remove(list, 1) end
					ride.last = nowMs
				end
			end
		end
		if ride and ride.last == nowMs then
			ride.count = ride.count + 1
			if not ride.announced and ride.count % FIT_EVERY == 0 then record() end
		end
	end
	if ride and nowMs - ride.last > RIDE_GAP then
		record()
		ride = nil
	end
end

-- Where car k of a loop is at `phase` (ms): x, y, z.
local function carAt(route, k, phase)
	local range = route.cars and route.cars[k]
	if not range then return nil end
	local frames = route.frames
	for i = range[1], range[2] do
		local f, g = frames[i], frames[i + 1]
		if phase >= f[1] and phase <= f[2] then return f[4], f[5], f[7] end
		if g and i < range[2] and phase > f[2] and phase < g[1] then
			local t = (phase - f[2]) / (g[1] - f[2])
			local z = f[7] and g[7] and f[7] + t * (g[7] - f[7]) or nil
			return f[4] + t * (g[4] - f[4]), f[5] + t * (g[5] - f[5]), z
		end
	end
	return nil
end

-- The car of a loop the player is on: the one nearest them now (a loop
-- with one car: that one).
local function carOf(route, phase)
	if not route.cars or #route.cars < 2 then return nil end
	local x, y, z = position()
	if not x then return nil end
	local best, bestD
	for k = 1, #route.cars do
		local cx, cy, cz = carAt(route, k, phase)
		if cx then
			local dz = (z and cz) and (z - cz) or 0
			local d = (cx - x) ^ 2 + (cy - y) ^ 2 + dz * dz
			if not bestD or d < bestD then best, bestD = k, d end
		end
	end
	return best
end

function Transit.Riding(now)
	local id = ride and ride.announced
	local route = id and routes[id]
	if not route then return nil end
	now = now or Transit.Now()
	local anchor = anchorOf(id, now)
	if not anchor then return nil end
	local phase = (now * 1000 - anchor.epoch) % route.period
	-- Stops carry their car on loops of several (stop[7]): only the car
	-- ridden counts, or riding one Great Lift car down reads the other's top.
	local car = route.stops[1] and route.stops[1][7] and carOf(route, phase)
	local best, at
	for i, stop in ipairs(route.stops) do
		if not car or (stop[7] or 1) == car then
			local arriveIn = (stop[1] - phase) % route.period
			if arriveIn > 0 and (not best or arriveIn < best) then best, at = arriveIn, i end
		end
	end
	if not best then return nil end
	return { kind = route.kind, route = id, dock = stopName[id] and dockName(stopName[id][at]), arriveIn = best / 1000 }
end

---------------------------------------------------------------------------
-- Sharing sightings with the guild and group (Shortest Path Forever's sync)
-- "S" .. "<route>:<seen s>:<phase ms at seen>;..." a sighting each;
-- "Q" asks for the sender's own sightings.
---------------------------------------------------------------------------

local PREFIX = "PolestarT1"
local MAX_MESSAGE = 240
local REPLY_EVERY = 30                -- s: at most one reply per channel this often
local REPLY_DELAY_MIN, REPLY_DELAY_MAX = 2, 12 -- s: a reply waits a random while, and is skipped if others answered
local REMOTE_EVERY = 20               -- s: shared sightings retime the route at most this often
-- Only this realm's players time this realm's loops: guild, party and raid,
-- never instance chat (cross-realm), a raid in a battleground or arena, or a
-- sender named with another realm.
local ACCEPTED = { GUILD = true, PARTY = true, RAID = true }
local lastReply, pendingReply = {}, {}
local pendingRemote, remoteTimer, lastRemote = {}, false, nil

local function sharing()
	return ns.Get("nav.shareTransit") and C_ChatInfo and C_ChatInfo.SendAddonMessage and true or false
end

local function inPvp()
	if not IsInInstance then return false end
	local inside, kind = IsInInstance()
	return inside and (kind == "pvp" or kind == "arena") or false
end

-- Whether a sender is someone else on this realm.
local function fromThisRealm(sender)
	if type(sender) ~= "string" or sender == "" then return false end
	local name = Ambiguate and Ambiguate(sender, "none") or sender
	local me = UnitName and UnitName("player")
	if me and name == me then return false end
	local realm = name:match("%-(.+)$")
	if not realm then return true end
	local mine = GetNormalizedRealmName and GetNormalizedRealmName()
	return type(mine) == "string" and realm == mine
end
Transit.fromThisRealm = fromThisRealm -- tests

local function encode(id, anchor)
	local route = routes[id]
	if not route then return nil end
	return format("%s:%d:%d", id, anchor.seen, floor((anchor.seen * 1000 - anchor.epoch) % route.period))
end

-- Validated sightings of one message; anything malformed, unknown,
-- future-dated or stale is dropped. A sighting dated a little ahead (clock
-- skew) counts as seen now, so it can never outrank one seen later.
local function decode(message, now)
	local out = {}
	for id, seenText, phaseText in message:gmatch("([%w%-]+):(%d+):(%d+)") do
		local route, seen, phase = routes[id], tonumber(seenText), tonumber(phaseText)
		if route and seen and phase and phase < route.period and seen <= now + CLOCK_SLACK and now - seen <= MAX_AGE then
			out[id] = { epoch = seen * 1000 - phase, seen = min(seen, floor(now)), source = "player" }
		end
	end
	return out
end
Transit.encode, Transit.decode = encode, decode -- tests

local function channels()
	local list = {}
	if IsInGuild and IsInGuild() then list[#list + 1] = "GUILD" end
	if IsInRaid and IsInRaid() then
		if not inPvp() then list[#list + 1] = "RAID" end
	elseif IsInGroup and IsInGroup() then
		list[#list + 1] = "PARTY"
	end
	return list
end

local function send(kind, entries, chatType)
	local message, parts = kind, {}
	for _, e in ipairs(entries) do
		if #message + #e + 1 > MAX_MESSAGE and #parts > 0 then
			pcall(C_ChatInfo.SendAddonMessage, PREFIX, kind .. concat(parts, ";"), chatType)
			message, parts = kind, {}
		end
		parts[#parts + 1] = e
		message = message .. e .. ";"
	end
	if #parts > 0 or kind == "Q" then pcall(C_ChatInfo.SendAddonMessage, PREFIX, kind .. concat(parts, ";"), chatType) end
end

function share(id)
	if not sharing() then return end
	local anchor = anchorOf(id, Transit.Now())
	local entry = anchor and encode(id, anchor)
	if not entry then return end
	for _, chatType in ipairs(channels()) do send("S", { entry }, chatType) end
end

-- Your own fresh sightings no reply already seen covers (`covered`: route ->
-- the newest seen another reply carried).
local function ownSightings(now, covered)
	local entries = {}
	for id, anchor in pairs(store()) do
		if fresh(anchor, now) and anchor.source == "you" and not (covered and covered[id] and covered[id] >= anchor.seen) then
			entries[#entries + 1] = encode(id, anchor)
		end
	end
	table.sort(entries)
	return entries
end

-- Shared sightings retime the route together, at most every REMOTE_EVERY s.
local function flushRemote()
	remoteTimer = false
	if not next(pendingRemote) then return end
	local changed = pendingRemote
	pendingRemote, lastRemote = {}, GetTime()
	ns.Fire("NAV_TRANSIT", changed, nil)
end

local function remoteChanged(route)
	changedBy(route, pendingRemote)
	if remoteTimer then return end
	local wait = lastRemote and lastRemote + REMOTE_EVERY - GetTime() or 0
	if wait <= 0 or not (C_Timer and C_Timer.After) then
		flushRemote()
	else
		remoteTimer = true
		C_Timer.After(wait, flushRemote)
	end
end

-- A query is answered after a random wait, with only what no other reply
-- on that channel has covered meanwhile.
local function reply(chatType)
	local pending = pendingReply[chatType]
	pendingReply[chatType] = nil
	if not (pending and sharing()) then return end
	local now = Transit.Now()
	local entries = ownSightings(now, pending.covered)
	if #entries > 0 then
		lastReply[chatType] = now
		send("S", entries, chatType)
	end
end

local function onAddonMessage(_, prefix, message, chatType, sender)
	if prefix ~= PREFIX or not ACCEPTED[chatType] or type(message) ~= "string" or not sharing() then return end
	if chatType == "RAID" and inPvp() then return end
	if not fromThisRealm(sender) then return end
	local now = Transit.Now()
	local kind = message:sub(1, 1)
	if kind == "S" then
		local pending = pendingReply[chatType]
		for id, anchor in pairs(decode(message:sub(2), now)) do
			if pending and (pending.covered[id] or -huge) < anchor.seen then pending.covered[id] = anchor.seen end
			if sighted(id, anchor, now) then remoteChanged(id) end
		end
	elseif kind == "Q" and not pendingReply[chatType] and now - (lastReply[chatType] or -huge) >= REPLY_EVERY then
		pendingReply[chatType] = { covered = {} }
		local delay = REPLY_DELAY_MIN + math.random() * (REPLY_DELAY_MAX - REPLY_DELAY_MIN)
		if C_Timer and C_Timer.After then
			C_Timer.After(delay, function() reply(chatType) end)
		else
			reply(chatType)
		end
	end
end

---------------------------------------------------------------------------
-- Class teleports
---------------------------------------------------------------------------

local NONE = {}
local usable, usableKey = {}, nil

local function known(t)
	local C = ns.Compat
	return C and C.IsSpellKnown and C.IsSpellKnown(t.spell) or false
end

local function stocked(t)
	local r = t.reagents
	if not r then return true end
	local C = ns.Compat
	for i = 1, #r - 1, 2 do
		if not (C and C.GetItemCount) or (C.GetItemCount(r[i]) or 0) < r[i + 1] then return false end
	end
	return true
end

-- Seconds until the spell is off cooldown (0 = now; the global cooldown
-- does not count).
local function cooldown(spell)
	local C = ns.Compat
	local start, duration = 0, 0
	if C and C.GetSpellCooldown then start, duration = C.GetSpellCooldown(spell) end
	if start <= 0 or duration <= GCD then return 0 end
	return max(0, start + duration - GetTime())
end

-- -> { { spell, name (the client's, in its language), cast = s, ready = s until castable, to = point | nil,
--   bind = true (lands at the bind point) }, ... }: known, with reagents in
-- the bags. The entries keep their identity while the set is unchanged.
function Transit.Teleports(now)
	if not ns.Get("nav.teleports") then return NONE end
	local list, keys = {}, {}
	for _, t in ipairs(teleportData) do
		if known(t) and stocked(t) then
			list[#list + 1] = t
			keys[#keys + 1] = t.spell
		end
	end
	local key = concat(keys, ",")
	if key ~= usableKey then
		usableKey, usable = key, {}
		for i, t in ipairs(list) do
			local N = ns.Names
			usable[i] = { spell = t.spell, name = (N and N.Spell(t.spell)) or t.name, cast = t.cast, to = t.to, bind = t.bind, ready = 0 }
		end
	end
	for _, u in ipairs(usable) do u.ready = cooldown(u.spell) end
	return usable
end

-- The usable set (and readiness) as a key, to notice a change.
local function teleportState()
	if not ns.Get("nav.teleports") then return "" end
	local parts = {}
	for _, u in ipairs(Transit.Teleports()) do parts[#parts + 1] = u.spell .. (u.ready > 0 and "c" or "") end
	return concat(parts, ",")
end

local lastTeleports
local function teleportsChanged()
	local state = teleportState()
	if lastTeleports ~= nil and state ~= lastTeleports then ns.Fire("NAV_TRANSIT", nil, true) end
	lastTeleports = state
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

local ticker, tick = nil, 0

ns.OnLogin(function()
	local s, now = store(), Transit.Now()
	for id, anchor in pairs(s) do
		if not fresh(anchor, now) or not routes[id] then s[id] = nil end
	end
	lastTeleports = teleportState()
	if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then pcall(C_ChatInfo.RegisterAddonMessagePrefix, PREFIX) end
	if C_Timer and C_Timer.NewTicker and not ticker then
		ticker = C_Timer.NewTicker(SAMPLE_EVERY, function()
			sample()
			tick = tick + 1
			if tick % 5 == 0 then teleportsChanged() end
		end)
	end
	-- Ask the guild for its sightings once the chat channels are up.
	if C_Timer and C_Timer.After then
		C_Timer.After(15, function()
			if sharing() and IsInGuild and IsInGuild() then send("Q", {}, "GUILD") end
		end)
	end
end)

ns.RegisterEvent("CHAT_MSG_ADDON", onAddonMessage)
-- A /reload or logout on board would otherwise lose the ride so far.
ns.RegisterEvent("PLAYER_LEAVING_WORLD", function() if ride then record() end end)
ns.RegisterEvent("SPELLS_CHANGED", teleportsChanged)
ns.RegisterEvent("BAG_UPDATE_DELAYED", teleportsChanged)
ns.On("SETTING_CHANGED", function(path)
	if path == "nav.teleports" or path == "nav" or path == "" then teleportsChanged() end
end)

Transit.sample = sample -- tests drive the observer tick
