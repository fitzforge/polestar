-- What the addon allocates, told apart from what this client stub allocates
-- for it. Load after wow_stub.lua and the stubs that wrap CreateFrame or the
-- frame methods, before the addon.
--
-- The client keeps a frame's points, colours, textures and children in C, so
-- its methods allocate nothing in Lua; this stub keeps them in Lua tables (a
-- SetPoint, a SetVertexColor: a table each). A memory test that counts the
-- addon's garbage takes the stub's share out:
--
--   local total, addon = stub.alloc.measure(fn, ...)   -- KiB allocated while fn ran, the collector stopped
--   stub.alloc.made                                     -- frames, textures, font strings made so far
--
-- The stub's share is what its frame methods, CreateFrame and its event and
-- timer loop allocate, less the addon code they call back (scripts, event
-- handlers, timers), which is the addon's.
local gc = collectgarbage
local A = { stub = 0, s0 = 0, depth = 0, n = 0, saved = {}, made = { frames = 0, textures = 0, strings = 0 } }
for i = 1, 256 do A.saved[i] = 0 end
stub.alloc = A

local function leave(...)
	local d = A.depth - 1
	A.depth = d
	if d == 0 then A.stub = A.stub + (gc("count") - A.s0) end
	return ...
end
local function own(fn)
	return function(...)
		if A.depth == 0 then A.s0 = gc("count") end
		A.depth = A.depth + 1
		return leave(fn(...))
	end
end
local function back(...)
	A.depth = A.saved[A.n]
	A.n = A.n - 1
	A.s0 = gc("count")
	return ...
end
-- Addon code the stub calls: out of the stub's share while it runs.
local function addon(fn)
	return function(...)
		local d = A.depth
		if d == 0 then return fn(...) end
		A.stub = A.stub + (gc("count") - A.s0)
		A.n = A.n + 1
		A.saved[A.n] = d
		A.depth = 0
		return back(fn(...))
	end
end

-- wow_stub.lua's methods share one RunScript (an upvalue of theirs): replaced once for all of them.
local replaced = false
for _, fn in pairs(stub.Methods) do
	if not replaced and type(fn) == "function" then
		local i = 1
		while true do
			local name, v = debug.getupvalue(fn, i)
			if not name then break end
			if name == "RunScript" and type(v) == "function" then
				debug.setupvalue(fn, i, addon(v))
				replaced = true
				break
			end
			i = i + 1
		end
	end
end
assert(replaced, "stub_alloc.lua: wow_stub.lua's RunScript not found")
stub.RunScript = addon(stub.RunScript)

local M = stub.Methods
local function counting(field, fn)
	return function(...)
		A.made[field] = A.made[field] + 1
		return fn(...)
	end
end
M.CreateTexture = counting("textures", M.CreateTexture)
M.CreateLine = counting("textures", M.CreateLine)
M.CreateMaskTexture = counting("textures", M.CreateMaskTexture)
M.CreateFontString = counting("strings", M.CreateFontString)
for k, fn in pairs(M) do
	if type(fn) == "function" then M[k] = own(fn) end
end
CreateFrame = own(counting("frames", CreateFrame))
for _, k in ipairs({ "fire", "advance", "frameTimers", "runTimers" }) do
	if type(stub[k]) == "function" then stub[k] = own(stub[k]) end
end
local after, newTimer, newTicker = C_Timer.After, C_Timer.NewTimer, C_Timer.NewTicker
C_Timer.After = own(function(s, fn) return after(s, addon(fn)) end)
C_Timer.NewTimer = own(function(s, fn) return newTimer(s, addon(fn)) end)
C_Timer.NewTicker = own(function(s, fn, n) return newTicker(s, addon(fn), n) end)

-- -> KiB allocated while fn ran, the addon's share of it (the collector stopped meanwhile).
function A.measure(fn, ...)
	gc("stop")
	local c0, s0 = gc("count"), A.stub
	local ok, err = pcall(fn, ...)
	local total = gc("count") - c0
	local stubShare = A.stub - s0
	gc("restart")
	if not ok then error(err, 0) end
	return total, total - stubShare
end
