-- The perf probe, /polestar perf: which of Polestar's own handlers make the
-- game stutter, measured on the player's machine, for a report they paste.
-- Off by default and off again after a reload; while off none of it runs
-- (Core/Init.lua, ns.SetProbe: the plain dispatchers stay in place), but for
-- the dozen QoL.Coalesce refreshes noting where they were made as they load.
--
-- On, every handler Polestar runs through its event frame, its message bus,
-- ns.Safe (OnUpdate scripts, ns.After/NewTicker/NewTimer) and ns.SafeCall
-- (QoL.Coalesce's refreshes among them), and the walking router's search
-- slices (Polestar_Nav's Path.after), is timed with debugprofilestop, and
-- kept:
--   - per handler: calls, total and own milliseconds (own: without the
--     handlers it ran inside it), the slowest call;
--   - spikes, the last RING of them: a call of SPIKE_MS or more, with the
--     handler, its event or message, and the guide step, the number of
--     quests in the log, combat and the map then; a frame where Polestar's
--     handlers together, or the game's profiler's figure for Polestar and
--     Polestar_Nav, came to FRAME_MS or more, with its three slowest calls
--     (many small handlers on one event stutter as much as one slow one);
--   - the game frames of HITCH_MS or more, and how many of them were
--     Polestar's;
--   - every SAMPLE_EVERY seconds the game's own addon profiler
--     (C_AddOnProfiler): each of Polestar's addons' recent average and peak
--     and the frames it took over 5, 10, 50 and 100 ms since the probe
--     started, all addons together, the whole game, and the TOP_K addons
--     by peak and by frames over 10 ms, by name, to set Polestar's against.
-- A handler is named by where it was made when that happened while the probe
-- was on ("Nav/Nav.lua:259") or it was noted then (ns.NoteMadeAt: each
-- QoL.Coalesce's "QoL/Buttons.lua:3580"), else by its name in Polestar's
-- tables ("Nav.Refresh"), else by its place among its event's handlers
-- ("#3/14"). The game's profiler's figures count every Polestar frame's
-- scripts, so far above what the handlers add up to, the time is in code the
-- probe does not wrap (a bare OnUpdate or C_Timer: UI/NameTargets.lua's
-- watcher, Alts/Snapshot.lua's write, Nav/Journey.lua's tell).
--
-- /polestar perf report shows it all to copy; /polestar report carries a
-- compact section (Perf.ReportLines). Nothing personal: no names, realms or
-- positions, only the map's number.

local ADDON, ns = ...
local L = ns.L
local floor, max, fmt, concat, sort = math.floor, math.max, string.format, table.concat, table.sort

local Perf = {}
ns.Perf = Perf

local SPIKE_MS = 2
local FRAME_MS = 5
local HITCH_MS = 50
local RING = 200
local SAMPLE_EVERY = 5
local TOP_K = 5
local CALIBRATE = 500
Perf.SPIKE_MS, Perf.FRAME_MS, Perf.HITCH_MS, Perf.RING = SPIKE_MS, FRAME_MS, HITCH_MS, RING

-- The plain SafeCall: this file loads before any probe is set.
local call = ns.SafeCall
local KIND = { "event", "message", "timer", "call" }
-- Our own files on the stack when a handler is made.
local SKIP = { [ADDON .. "/Core/Init.lua"] = true, [ADDON .. "/Core/Perf.lua"] = true }
-- The profiler's figures per addon, in this order.
local METRICS = { "RecentAverageTime", "PeakTime", "CountTimeOver5Ms", "CountTimeOver10Ms", "CountTimeOver50Ms", "CountTimeOver100Ms" }

local on, ran = false, false
local clock
local startedAt, stoppedAt
local cost -- the probe's own cost per call, ms
local stats, sites, calls
local ring, ringHead, ringCount, spikes, slowFrames
local hitches
local depth, debt, childMs = 0, 0, {}
-- This frame's handlers (the outermost ones) and its three slowest.
local fSum, fCalls = 0, 0
local fKey, fKind, fWhere, fMs = {}, {}, {}, { 0, 0, 0 }
local profiler, LAST, M
local base, last, overall, game, topPeak, topSlow
local watcher, sampler
local plain = {}

local function now() return (GetTime() or 0) - startedAt end

local function push(e)
	ringHead = ringHead % RING + 1
	ring[ringHead] = e
	if ringCount < RING then ringCount = ringCount + 1 end
end

-- The guide step, the quests in the log, combat and the map, when a spike
-- comes.
local function context(e)
	local E, C = ns.Engine, ns.Compat
	local g = E and E.GetGuide and E.GetGuide()
	e.guide = g and g.id
	e.step = E and E.GetStepIndex and E.GetStepIndex()
	local log = C and C.GetLogQuests and C.GetLogQuests()
	e.log = type(log) == "table" and #log or nil
	e.combat = InCombatLockdown and InCombatLockdown() or nil
	e.map = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")
end

local function frameName(x)
	if type(x) ~= "table" or type(x.GetObjectType) ~= "function" then return nil end
	return x.GetName and x:GetName() or "frame"
end

-- An event's or message's handler by its place among them now: it may be
-- gone by the time the report is made.
local function place(e)
	if type(e.key) == "function" and (e.kind == 1 or e.kind == 2) then e.at, e.of = ns.HandlerPlace(e.kind, e.where, e.key) end
	return e
end

local function spike(key, kind, where, ms, own, d, ...)
	spikes = spikes + 1
	local e = place({ t = now(), key = key, kind = kind, where = where, ms = ms, own = own, depth = d })
	if kind == 3 then e.on = frameName((...)) end
	context(e)
	push(e)
end

-- Runs fn through the plain SafeCall and times it. The probe's own work
-- inside a handler (its children's bookkeeping, noting where timers are
-- made) is `debt`, taken off the handler's time.
local function timed(fn, kind, where, ...)
	local d = depth + 1
	depth = d
	childMs[d] = 0
	local d0 = debt
	local t0 = clock()
	call(fn, ...)
	local t1 = clock()
	local ms = t1 - t0 - (debt - d0)
	local own = ms - childMs[d]
	depth = d - 1
	calls = calls + 1
	local key = sites[fn] or fn
	local s = stats[key]
	if not s then
		s = { n = 0, ms = 0, own = 0, max = 0, kind = kind, where = where }
		stats[key] = s
	elseif where ~= s.where then
		s.multi = true
	end
	s.n, s.ms, s.own = s.n + 1, s.ms + ms, s.own + own
	if ms > s.max then s.max = ms end
	if d > 1 then
		childMs[d - 1] = childMs[d - 1] + ms
	else
		fSum, fCalls = fSum + ms, fCalls + 1
		if ms > fMs[3] then
			local i = 3
			while i > 1 and ms > fMs[i - 1] do
				fKey[i], fKind[i], fWhere[i], fMs[i] = fKey[i - 1], fKind[i - 1], fWhere[i - 1], fMs[i - 1]
				i = i - 1
			end
			fKey[i], fKind[i], fWhere[i], fMs[i] = key, kind, where, ms
		end
	end
	if ms >= SPIKE_MS then spike(key, kind, where, ms, own, d, ...) end
	debt = debt + (clock() - t1)
end

local function clearFrame()
	fSum, fCalls = 0, 0
	for i = 1, 3 do fKey[i], fKind[i], fWhere[i], fMs[i] = nil, nil, nil, 0 end
end

local NAV = "Polestar_Nav"
local navLoaded

-- Once a frame: the frame's handlers against the profiler's figures.
local function onFrame()
	local mine, nav, all, app
	if profiler then
		mine = profiler.GetAddOnMetric(ADDON, LAST)
		-- The walking router's frames and timers are its own addon's.
		nav = navLoaded and profiler.GetAddOnMetric(NAV, LAST) or nil
		all = profiler.GetOverallMetric(LAST)
		app = profiler.GetApplicationMetric(LAST)
	end
	local ours = fSum >= FRAME_MS or (mine or 0) + (nav or 0) >= FRAME_MS
	if app and app >= HITCH_MS then
		hitches.n = hitches.n + 1
		if app > hitches.worst then hitches.worst = app end
		if ours then hitches.ours = hitches.ours + 1 end
	end
	if ours then
		slowFrames = slowFrames + 1
		local e = { t = now(), slow = true, ms = fSum, calls = fCalls, mine = mine, nav = nav, all = all, app = app, top = {} }
		for i = 1, 3 do
			if fKey[i] then e.top[i] = place({ key = fKey[i], kind = fKind[i], where = fWhere[i], ms = fMs[i] }) end
		end
		context(e)
		push(e)
	end
	clearFrame()
end

-- Polestar's addons that are loaded.
local function ownAddons()
	local A = C_AddOns or {}
	local count, info, loaded = A.GetNumAddOns or GetNumAddOns, A.GetAddOnInfo or GetAddOnInfo, A.IsAddOnLoaded or IsAddOnLoaded
	local out = { ADDON }
	if not (count and info and loaded) then return out end
	for i = 1, count() or 0 do
		local name = info(i)
		if type(name) == "string" and name ~= ADDON and name:find("^Polestar_") and loaded(name) and ns.OwnAddon(name) then
			out[#out + 1] = name
		end
	end
	return out
end

local function figures(read)
	local out = {}
	for i, m in ipairs(METRICS) do
		local ok, v = pcall(read, M[m])
		if not ok or type(v) ~= "number" then return nil end
		out[i] = v
	end
	return out
end

local function top(metric)
	local ok, list = pcall(profiler.GetTopKAddOnsForMetric, metric, TOP_K)
	if not ok or type(list) ~= "table" then return nil end
	local out = {}
	for _, r in ipairs(list) do
		if type(r) == "table" and type(r.addOnName) == "string" then out[#out + 1] = { name = r.addOnName, v = r.metricValue or 0 } end
	end
	return out
end

-- The profiler's figures now; the first of a run is the baseline the frame
-- counts are taken from.
local function sample()
	if not profiler then return end
	for _, name in ipairs(ownAddons()) do
		local v = figures(function(m) return profiler.GetAddOnMetric(name, m) end)
		if v then
			base[name] = base[name] or v
			last[name] = v
		end
	end
	local all = figures(profiler.GetOverallMetric)
	if all then
		base["*all"] = base["*all"] or all
		overall = all
	end
	local app = figures(profiler.GetApplicationMetric)
	if app then
		base["*game"] = base["*game"] or app
		game = app
	end
	topPeak = top(M.PeakTime) or topPeak
	topSlow = top(M.CountTimeOver10Ms) or topSlow
end

local function noteSite(fn)
	if type(fn) ~= "function" or sites[fn] ~= nil then return end
	local t = clock()
	sites[fn] = type(debugstack) == "function" and ns.OurSite(debugstack(2, 12, 0) or "", SKIP) or false
	debt = debt + (clock() - t)
end

-- While on, handlers made are noted where they are made.
local function wrapMaking()
	plain.RegisterEvent, plain.On, plain.Safe = ns.RegisterEvent, ns.On, ns.Safe
	ns.RegisterEvent = function(event, fn, unit)
		noteSite(fn)
		return plain.RegisterEvent(event, fn, unit)
	end
	ns.On = function(msg, fn)
		noteSite(fn)
		return plain.On(msg, fn)
	end
	ns.Safe = function(fn)
		noteSite(fn)
		return plain.Safe(fn)
	end
	-- The walking router's searches: a slice every frame while one runs
	-- (Polestar_Nav's PathJobs, scheduled with Path.after, bare C_Timer).
	local Path = Polestar_NavEngine
	if type(Path) == "table" and type(Path.after) == "function" then
		plain.navPath, plain.navAfter = Path, Path.after
		Path.after = function(fn)
			noteSite(fn)
			return plain.navAfter(function(...) timed(fn, 3, nil, ...) end)
		end
	end
end

local function unwrapMaking()
	ns.RegisterEvent, ns.On, ns.Safe = plain.RegisterEvent, plain.On, plain.Safe
	if plain.navPath then plain.navPath.after = plain.navAfter end
	plain.navPath, plain.navAfter = nil, nil
end

local function reset()
	stats, sites, calls = {}, setmetatable({}, { __mode = "k" }), 0
	ring, ringHead, ringCount, spikes, slowFrames = {}, 0, 0, 0, 0
	hitches = { n = 0, ours = 0, worst = 0 }
	base, last, overall, game, topPeak, topSlow = {}, {}, nil, nil, nil, nil
	depth, debt = 0, 0
	clearFrame()
end
reset()

-- The probe's own cost per call: CALIBRATE empty calls timed, against as
-- many through the plain SafeCall.
local function noop() end
local function calibrate()
	local t = clock()
	for _ = 1, CALIBRATE do call(noop) end
	local bare = clock() - t
	t = clock()
	for _ = 1, CALIBRATE do timed(noop, 4, nil) end
	local probed = clock() - t
	cost = max(0, probed - bare) / CALIBRATE
	stats[noop] = nil
	calls, debt = 0, 0
	clearFrame()
end

function Perf.IsOn() return on end
function Perf.Cost() return cost end

function Perf.Start()
	if on then return true end
	if type(debugprofilestop) ~= "function" then return false end
	clock = debugprofilestop
	M = Enum and Enum.AddOnProfilerMetric
	LAST = M and M.LastTime
	profiler = nil
	local P = C_AddOnProfiler
	if LAST and P and P.GetAddOnMetric and P.GetOverallMetric and P.GetApplicationMetric and P.GetTopKAddOnsForMetric
		and (not P.IsEnabled or P.IsEnabled()) and pcall(P.GetAddOnMetric, ADDON, LAST) then
		profiler = P
		local loaded = C_AddOns and C_AddOns.IsAddOnLoaded
		navLoaded = loaded and loaded(NAV) and pcall(P.GetAddOnMetric, NAV, LAST) or false
	end
	reset()
	startedAt, stoppedAt = GetTime() or 0, nil
	calibrate()
	on, ran = true, true
	sample()
	wrapMaking()
	ns.SetProbe(timed)
	watcher = watcher or CreateFrame("Frame")
	watcher:SetScript("OnUpdate", onFrame)
	-- Not ns.NewTicker: the probe's own sampling stays out of what it times.
	sampler = C_Timer.NewTicker(SAMPLE_EVERY, function() call(sample) end)
	return true
end

function Perf.Stop()
	if not on then return end
	on = false
	stoppedAt = GetTime() or 0
	ns.SetProbe(nil)
	unwrapMaking()
	watcher:SetScript("OnUpdate", nil)
	if sampler then sampler:Cancel() end
	sampler = nil
	call(sample)
end

function Perf.Reset()
	local was = on
	if was then Perf.Stop() end
	ran = false
	reset()
	if was then Perf.Start() end
end

---------------------------------------------------------------------------
-- The report
---------------------------------------------------------------------------

-- Polestar's functions by their names in its tables ("Nav.Refresh"), two
-- tables deep; built for each report.
local function nameMap()
	local names = {}
	local function walk(prefix, t, level)
		local n = 0
		for k, v in pairs(t) do
			n = n + 1
			if n > 2000 then break end
			if type(k) == "string" then
				if type(v) == "function" then
					if names[v] == nil then names[v] = prefix .. k end
				elseif type(v) == "table" and level < 2 and k:find("^%u") and rawget(v, 0) == nil then
					walk(prefix .. k .. ".", v, level + 1)
				end
			end
		end
	end
	walk("", ns, 0)
	return names
end

local names

-- at, of: its place among its event's handlers when the spike came (place).
local function label(key, kind, where, at, of)
	if type(key) ~= "string" then key = ns.MadeAt(key) or key end
	if type(key) == "string" then return (key:gsub("^" .. ADDON .. "/", "")) end
	local n = names and names[key]
	if n then return n end
	if not at and where and (kind == 1 or kind == 2) then at, of = ns.HandlerPlace(kind, where, key) end
	if at then return fmt("#%d/%d", at, of) end
	return "?"
end

-- "QUEST_LOG_UPDATE #3/14", "msg STEP_CHANGED Engine.Refresh", "timer
-- Nav/Nav.lua:259"; `multi` marks a handler of more than one event.
local function handler(key, kind, where, multi, at, of)
	local head = kind == 1 and where or kind == 2 and ("msg " .. tostring(where)) or KIND[kind] or "?"
	return head .. (multi and "+" or "") .. " " .. label(key, kind, where, at, of)
end

local function ms1(v) return fmt("%.1f", v or 0) end

local function duration(s)
	s = floor(s or 0)
	if s >= 3600 then return fmt("%dh%02dm", floor(s / 3600), floor(s % 3600 / 60)) end
	if s >= 60 then return fmt("%dm%02ds", floor(s / 60), s % 60) end
	return s .. "s"
end

local function contextText(e)
	local parts = {}
	if e.step then parts[#parts + 1] = "step " .. e.step end
	if e.log then parts[#parts + 1] = "log " .. e.log end
	if e.combat then parts[#parts + 1] = "combat" end
	if e.map then parts[#parts + 1] = "map " .. e.map end
	return concat(parts, " ")
end

local function spikeText(e)
	local s
	if e.slow then
		local tops = {}
		for i, t in ipairs(e.top) do tops[i] = handler(t.key, t.kind, t.where, nil, t.at, t.of) .. " " .. ms1(t.ms) end
		s = fmt("frame %s ms in %d calls", ms1(e.ms), e.calls)
		if e.mine then
			s = s .. fmt(" (profiler: Polestar %s%s, addons %s, game %s)", ms1(e.mine), e.nav and (", Polestar_Nav " .. ms1(e.nav)) or "", ms1(e.all), ms1(e.app))
		end
		if #tops > 0 then s = s .. ": " .. concat(tops, ", ") end
	else
		s = fmt("%s %s ms (own %s)", handler(e.key, e.kind, e.where, nil, e.at, e.of), ms1(e.ms), ms1(e.own))
		if e.depth > 1 then s = s .. " nested" end
		if e.on then s = s .. " on " .. e.on end
	end
	local c = contextText(e)
	return c ~= "" and (s .. " · " .. c) or s
end

-- The spikes, oldest first.
local function spikeList()
	local out = {}
	for i = ringCount - 1, 0, -1 do
		out[#out + 1] = ring[(ringHead - 1 - i) % RING + 1]
	end
	return out
end

local function byTotal()
	local list = {}
	for key, s in pairs(stats) do list[#list + 1] = { key = key, s = s } end
	sort(list, function(a, b) return a.s.ms > b.s.ms end)
	return list
end

local function worst(list, frames)
	local w
	for _, e in ipairs(list) do
		if (e.slow == true) == frames and (not w or e.ms > w.ms) then w = e end
	end
	return w
end

local function headLine()
	local span = (stoppedAt or GetTime() or 0) - (startedAt or 0)
	return fmt("Perf: %s %s · %d calls · %d over %d ms · %d frames over %d ms · %d game hitches over %d ms (Polestar in %d) · probe %s us a call",
		on and "on" or "off", duration(span), calls, spikes, SPIKE_MS, slowFrames, FRAME_MS, hitches.n, HITCH_MS, hitches.ours, fmt("%.1f", (cost or 0) * 1000))
end

-- One addon's profiler figures: average and peak in ms, frames over 5, 10,
-- 50 and 100 ms since the probe started.
local function figuresText(v, b)
	b = b or v
	return fmt("avg %s peak %s >5ms %d >10ms %d >50ms %d >100ms %d", fmt("%.2f", v[1]), ms1(v[2]),
		v[3] - b[3], v[4] - b[4], v[5] - b[5], v[6] - b[6])
end

local function topText(list)
	local out = {}
	for i, r in ipairs(list or {}) do out[i] = r.name .. " " .. ms1(r.v) end
	return concat(out, ", ")
end

local function topCount(list)
	local out = {}
	for i, r in ipairs(list or {}) do out[i] = r.name .. " " .. floor(r.v) end
	return concat(out, ", ")
end

-- Whether the probe ran this session (its figures stay after it is off).
function Perf.Ran() return ran end

-- The compact section for /polestar report: nil when the probe has not run
-- this session.
function Perf.ReportLines()
	if not ran then return nil end
	if on then call(sample) end
	names = nameMap()
	local list = spikeList()
	local out = { headLine() }
	local w = worst(list, false)
	if w then out[#out + 1] = "  worst call: " .. spikeText(w) end
	local f = worst(list, true)
	if f then out[#out + 1] = "  worst frame: " .. spikeText(f) end
	local totals, parts = byTotal(), {}
	for i = 1, math.min(3, #totals) do
		local t = totals[i]
		parts[i] = fmt("%s %s ms/%d max %s", handler(t.key, t.s.kind, t.s.where, t.s.multi), ms1(t.s.ms), t.s.n, ms1(t.s.max))
	end
	if #parts > 0 then out[#out + 1] = "  most time: " .. concat(parts, " · ") end
	local mine = last[ADDON]
	if mine then
		out[#out + 1] = "  profiler: Polestar " .. figuresText(mine, base[ADDON]) .. (topSlow and #topSlow > 0 and (" · most >10ms: " .. topCount(topSlow)) or "")
	end
	names = nil
	return out
end

-- Everything, for /polestar perf report.
function Perf.ReportText()
	if not ran then return nil end
	if on then call(sample) end
	names = nameMap()
	local out = { "Polestar " .. tostring(ns.version or "dev") .. " perf probe", headLine() }
	if next(last) then
		out[#out + 1] = "Profiler (avg and peak in ms; frames over 5/10/50/100 ms since the probe started):"
		local own = {}
		for name in pairs(last) do own[#own + 1] = name end
		sort(own)
		for _, name in ipairs(own) do out[#out + 1] = "  " .. name .. ": " .. figuresText(last[name], base[name]) end
		if overall then out[#out + 1] = "  all addons: " .. figuresText(overall, base["*all"]) end
		if game then out[#out + 1] = "  game: " .. figuresText(game, base["*game"]) end
		if topPeak and #topPeak > 0 then out[#out + 1] = "  top peak: " .. topText(topPeak) end
		if topSlow and #topSlow > 0 then out[#out + 1] = "  most frames >10ms: " .. topCount(topSlow) end
	else
		out[#out + 1] = "Profiler: not available on this client"
	end
	local totals = byTotal()
	if #totals > 0 then
		out[#out + 1] = "Most time (ms total / calls, own, max):"
		for i = 1, math.min(10, #totals) do
			local t = totals[i]
			out[#out + 1] = fmt("  %s %s/%d own %s max %s", handler(t.key, t.s.kind, t.s.where, t.s.multi), ms1(t.s.ms), t.s.n, ms1(t.s.own), ms1(t.s.max))
		end
	end
	local list = spikeList()
	if #list > 0 then
		local from = max(1, #list - 14)
		out[#out + 1] = fmt("Spikes (the last %d of %d, time since the probe started):", #list - from + 1, spikes + slowFrames)
		for i = from, #list do
			out[#out + 1] = fmt("  %s %s", duration(list[i].t), spikeText(list[i]))
		end
		if list[#list].guide then out[#out + 1] = "Guide at the last spike: " .. tostring(list[#list].guide) end
	end
	names = nil
	return concat(out, "\n")
end

-- Read-only views for tests.
function Perf.Stats()
	local out = {}
	names = nameMap()
	for key, s in pairs(stats or {}) do out[handler(key, s.kind, s.where, s.multi)] = s end
	names = nil
	return out
end
function Perf.Spikes() return spikeList() end
function Perf.Calls() return calls end

ns.RegisterCommand("perf", function(rest)
	local arg = (rest or ""):lower()
	if arg == "" then arg = on and "off" or "on" end
	if arg == "on" then
		if Perf.Start() then
			ns.Print(L["Perf probe on: Polestar now times its own work. Play as usual, then type /polestar report and paste it."])
		else
			ns.Print(L["The perf probe needs debugprofilestop, which this client does not have."])
		end
	elseif arg == "off" then
		Perf.Stop()
		ns.Print(L["Perf probe off. What it measured stays in /polestar report until you reload."])
	elseif arg == "report" then
		local text = Perf.ReportText()
		if text then
			ns.Fire("SHOW_COPY", L["Polestar perf report"], text)
		else
			ns.Print(L["The perf probe has not run yet: type /polestar perf to start it."])
		end
	elseif arg == "reset" then
		Perf.Reset()
		ns.Print(L["Perf probe: measurements cleared."])
	else
		ns.Print(L["/polestar perf: on, off, report or reset"])
	end
end, L["Find what makes your game stutter: times Polestar's own work (on, off, report, reset)"], true)
