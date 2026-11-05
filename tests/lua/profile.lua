-- Profiling for harness runs (load after wow_stub.lua, before any addon).
--
--   stub.profile.start({ sample = 1000 })  begin accumulating (sample: VM
--                                          instructions between stack samples, 0/nil = off)
--   stub.profile.stop()
--   stub.profile.reset()
--   stub.profile.report(limit)             { handlers = {...}, functions = {...}, lines = {...}, total = ms }
--   stub.profile.total()                   CPU ms in top-level handlers since start/reset
--   stub.profile.measure(fn)               CPU ms fn takes, nested handlers included
--
-- Every game event handler (frame OnEvent and Polestar's ns.RegisterEvent),
-- message bus listener (ns.On), OnUpdate script and C_Timer callback is timed
-- with os.clock(), exclusive of nested handlers (a message fired from inside a
-- handler is charged to its listener). A handler's key is
-- "<file>:<line> <event|message|OnUpdate|timer>", so the file names the module.
-- The sampler walks the Lua stack every `sample` instructions: `functions`
-- counts each function once per sample it is on the stack (inclusive), `lines`
-- the line the VM was executing (self).

local P = {}
stub.profile = P

local clock = os.clock
local running = false
local handlers = {}
local fnSamples, lineSamples, names = {}, {}, {}
local sampleEvery = 0
local nested = {} -- stack of child time accumulators
local total = 0

local function short(src)
	src = (src or "?"):gsub("^@", "")
	return src:match("addon/(.+)$") or src:match("tests/(.+)$") or src
end

local function keyOf(fn)
	local i = debug.getinfo(fn, "S")
	return short(i.source) .. ":" .. tostring(i.linedefined)
end

-- Runs fn(...) charged to `key`; returns nothing (handlers' returns are unused).
local function timed(key, fn, ...)
	if not running then return fn(...) end
	nested[#nested + 1] = 0
	local t0 = clock()
	local ok, err = pcall(fn, ...)
	local spent = clock() - t0
	local child = table.remove(nested)
	local h = handlers[key]
	if not h then
		h = { key = key, calls = 0, incl = 0, excl = 0 }
		handlers[key] = h
	end
	h.calls = h.calls + 1
	h.incl = h.incl + spent
	h.excl = h.excl + spent - child
	if #nested > 0 then nested[#nested] = nested[#nested] + spent else total = total + spent end
	if not ok then error(err, 0) end
end

-- Event delivery and OnUpdate, the way wow_stub.lua does them, but timed.
local RunScript = stub.RunScript
local Methods = stub.Methods
local function runTimed(f, name, label, ...)
	local fn = f.scripts[name]
	if fn then timed(keyOf(fn) .. " " .. label, fn, f, ...) end
	local hooks = f.hooks[name]
	if hooks then
		for i = 1, #hooks do timed(keyOf(hooks[i]) .. " " .. label, hooks[i], f, ...) end
	end
end

local fire = stub.fire
function stub.fire(ev, ...)
	if not running then return fire(ev, ...) end
	local list = {}
	for _, f in ipairs(stub.frames) do
		if f.events[ev] then list[#list + 1] = f end
	end
	for _, f in ipairs(list) do runTimed(f, "OnEvent", ev, ev, ...) end
end

function stub.advance(seconds)
	local step = 0.05
	local remaining = seconds or 0
	repeat
		local dt = math.min(step, remaining)
		stub.now = stub.now + dt
		remaining = remaining - dt
		for _, f in ipairs(stub.frames) do
			if f.scripts.OnUpdate and Methods.IsVisible(f) then
				if running then runTimed(f, "OnUpdate", "OnUpdate", dt) else RunScript(f, "OnUpdate", dt) end
			end
		end
		stub.frameTimers()
	until remaining <= 1e-9
end

local After, NewTimer, NewTicker = C_Timer.After, C_Timer.NewTimer, C_Timer.NewTicker
local function wrap(fn)
	local key = keyOf(fn) .. " timer"
	return function(...) return timed(key, fn, ...) end
end
function C_Timer.After(s, fn) return After(s, wrap(fn)) end
function C_Timer.NewTimer(s, fn) return NewTimer(s, wrap(fn)) end
function C_Timer.NewTicker(s, fn, n) return NewTicker(s, wrap(fn), n) end

-- Polestar's own event and message registrations, wrapped as they are made
-- (one wrapper per function and name, so Unregister finds it again).
local wrappers = setmetatable({}, { __mode = "k" })
local function wrapNamed(fn, name)
	local byName = wrappers[fn]
	if not byName then
		byName = {}
		wrappers[fn] = byName
	end
	local w = byName[name]
	if not w then
		local key = keyOf(fn) .. " " .. tostring(name)
		w = function(...) return timed(key, fn, ...) end
		byName[name] = w
	end
	return w
end
local WRAP = { RegisterEvent = true, UnregisterEvent = true, On = true }
local function instrument(ns)
	setmetatable(ns, {
		__newindex = function(t, k, v)
			if WRAP[k] and type(v) == "function" then
				local orig = v
				v = function(name, fn, ...)
					if type(fn) == "function" then fn = wrapNamed(fn, name) end
					return orig(name, fn, ...)
				end
			end
			rawset(t, k, v)
		end,
	})
end
setmetatable(_G, {
	__newindex = function(t, k, v)
		if k == "Polestar" and type(v) == "table" then instrument(v) end
		rawset(t, k, v)
	end,
})

local function hook()
	local seen = {}
	local level = 2
	local top = true
	while true do
		local i = debug.getinfo(level, "Sln")
		if not i then break end
		if i.what ~= "C" then
			local src = short(i.source)
			if top then
				local l = src .. ":" .. tostring(i.currentline)
				lineSamples[l] = (lineSamples[l] or 0) + 1
				top = false
			end
			local k = src .. ":" .. tostring(i.linedefined)
			if not seen[k] then
				seen[k] = true
				fnSamples[k] = (fnSamples[k] or 0) + 1
				if i.name and not names[k] then names[k] = i.name end
			end
		end
		level = level + 1
	end
end

function P.start(opts)
	running = true
	sampleEvery = opts and opts.sample or 0
	if sampleEvery and sampleEvery > 0 then debug.sethook(hook, "", sampleEvery) end
end

function P.stop()
	running = false
	debug.sethook()
end

function P.reset()
	handlers, fnSamples, lineSamples, names, total = {}, {}, {}, {}, 0
end

function P.total() return total * 1000 end

-- CPU ms spent in timed addon handlers while fn runs (fn's own code, such as a
-- direct Engine call, is included: it is measured from outside).
function P.measure(fn)
	local wasRunning = running
	running = true
	nested[#nested + 1] = 0
	local t0 = clock()
	fn()
	local spent = clock() - t0
	table.remove(nested)
	running = wasRunning
	return spent * 1000
end

local function sorted(map, value, limit)
	local list = {}
	for k, v in pairs(map) do list[#list + 1] = { k, v } end
	table.sort(list, function(a, b) return value(a[2]) > value(b[2]) end)
	local out = {}
	for i = 1, math.min(limit or 40, #list) do out[i] = list[i] end
	return out
end

function P.report(limit)
	local hs = {}
	for _, e in ipairs(sorted(handlers, function(h) return h.excl end, limit)) do
		local h = e[2]
		hs[#hs + 1] = { key = h.key, calls = h.calls, incl = h.incl * 1000, excl = h.excl * 1000 }
	end
	local fs = {}
	for _, e in ipairs(sorted(fnSamples, function(n) return n end, limit)) do
		fs[#fs + 1] = { key = e[1], name = names[e[1]], samples = e[2] }
	end
	local ls = {}
	for _, e in ipairs(sorted(lineSamples, function(n) return n end, limit)) do
		ls[#ls + 1] = { key = e[1], samples = e[2] }
	end
	local n = 0
	for _, c in pairs(lineSamples) do n = n + c end
	return { handlers = hs, functions = fs, lines = ls, total = total * 1000, samples = n, clock = clock() * 1000 }
end
