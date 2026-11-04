-- Baked legs: the walk into a guide step, routed offline (forge build's legs
-- stage, rust/crates/forge-nav/src/bake.rs: Leffe's navigation maps, our grid
-- where his have no way or a detour) and carried as one string per step: in
-- a race part's Legs.lua (pack format 7, Polestar.RegisterLegs, Core/Guides.lua
-- Guides.Legs) or on the guide itself (`legs = { [step] = "..." }`, format 6).
-- Nav.BakedLeg(step) decodes the current guide's leg into reused arrays; the
-- arrow follows it (Nav/Walk.lua) and searches as before without one.
--
--   Nav.BakedLeg(step) -> leg | nil, leg = {
--     c,                         continent (the world position's)
--     n,                         points, 1..n
--     xs, ys, zs,                world yards (x north, y west); zs[i] a height
--     left,                      yards from point i to the goal: left[n] the
--                                last point's distance to the goal
--     cls,                       move of the segment i -> i+1 (1..n-1), as
--                                the grid's classes: 0 walk, 1 steep, 2 swim,
--                                3 jump, 4 drop, 5 indoor, 6 climb, 7 lift
--     floor,                     floor of the segment i -> i+1 (1..n-1): its
--                                surface's index in its column on the maps it
--                                was baked on, 0 the lowest (0 in a version-1 leg)
--     strip, m,                  the ground height every Nav.BAKED_STRIP_YD
--                                along the line, 1..m (the ground trail)
--     step, guide,               what it is for
--     id,                        a number that changes with each leg decoded
--                                (the follower resets its state on a new one)
--   }
-- The arrays are reused: the next call with another leg rewrites them, so a
-- caller copies what it keeps. A step without a leg, a leg of another
-- continent or a string that does not read returns nil.
--
-- The string: base-64 digits (A-Z a-z 0-9 + /), each five bits of a varint
-- plus a continuation bit (32), signed values zigzagged: the version (2), n;
-- per point dx, dy (0.5 yd) and dz (0.25 yd) from the one before (the first
-- from 0); n-1 moves; n-1 floors; the tail (0.25 yd); m; then the strip's
-- changes from the height before (0.25 yd, the first from point 1's height),
-- one digit per token: 32..63 a run of 1..32 unchanged heights, 0..24 two
-- changes a, b in -2..2 (digit (a + 2) * 5 + b + 2), 25..30 one change of
-- -3, -2, -1, 1, 2 or 3, 31 one change whose zig value follows as a varint.
-- Version 1 (format 6) has no floors and one zigzagged varint per strip change.

local ADDON, ns = ...

local Nav = ns.Nav
local byte, floor = string.byte, math.floor
local sqrt = math.sqrt

Nav.BAKED_STRIP_YD = 2
local QXY, QZ = 0.5, 0.25

local VALUE = {}
do
	local digits = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	for i = 1, #digits do VALUE[byte(digits, i)] = i - 1 end
end

-- The strip's single-change tokens 25..30.
local SINGLE = { [25] = -3, [26] = -2, [27] = -1, [28] = 1, [29] = 2, [30] = 3 }

local leg = { xs = {}, ys = {}, zs = {}, left = {}, cls = {}, floor = {}, strip = {}, n = 0, m = 0 }
local cached -- the string the arrays hold now
local decodes = 0

local function unzig(u)
	if u % 2 == 1 then return -(u + 1) / 2 end
	return u / 2
end

-- Decode string s into `leg`; false when it does not read.
local function decode(s)
	local pos, len = 1, #s
	local function digit()
		if pos > len then return nil end
		local d = VALUE[byte(s, pos)]
		pos = pos + 1
		return d
	end
	local function nextVal()
		local v, mul = 0, 1
		while true do
			local d = digit()
			if not d then return nil end
			if d >= 32 then
				v = v + (d - 32) * mul
				mul = mul * 32
			else
				return v + d * mul
			end
		end
	end
	local function signed()
		local u = nextVal()
		return u and unzig(u)
	end
	local version = nextVal()
	if version ~= 1 and version ~= 2 then return false end
	local n = nextVal()
	if not n or n < 2 then return false end
	local xs, ys, zs, cls, fl, left, strip = leg.xs, leg.ys, leg.zs, leg.cls, leg.floor, leg.left, leg.strip
	local qx, qy, qz = 0, 0, 0
	for i = 1, n do
		local dx, dy, dz = signed(), signed(), signed()
		if not (dx and dy and dz) then return false end
		qx, qy, qz = qx + dx, qy + dy, qz + dz
		xs[i], ys[i], zs[i] = qx * QXY, qy * QXY, qz * QZ
	end
	for i = 1, n - 1 do
		local c = nextVal()
		if not c then return false end
		cls[i] = c
	end
	for i = 1, n - 1 do
		local f = 0
		if version == 2 then
			f = nextVal()
			if not f then return false end
		end
		fl[i] = f
	end
	local tail = nextVal()
	local m = nextVal()
	if not (tail and m) then return false end
	local sz = floor(zs[1] / QZ + 0.5)
	local k = 0
	while k < m do
		if version == 1 then
			local d = signed()
			if not d then return false end
			sz = sz + d
			k = k + 1
			strip[k] = sz * QZ
		else
			local d = digit()
			if not d then return false end
			if d >= 32 then
				for _ = 1, d - 31 do
					k = k + 1
					strip[k] = sz * QZ
				end
			elseif d < 25 then
				sz = sz + floor(d / 5) - 2
				k = k + 1
				strip[k] = sz * QZ
				sz = sz + d % 5 - 2
				k = k + 1
				strip[k] = sz * QZ
			else
				local c = SINGLE[d]
				if not c then
					local u = nextVal()
					if not u then return false end
					c = unzig(u)
				end
				sz = sz + c
				k = k + 1
				strip[k] = sz * QZ
			end
		end
	end
	if k ~= m or pos <= len then return false end
	-- Yards to the goal from each point, back from the tail.
	left[n] = tail * QZ
	for i = n - 1, 1, -1 do
		local dx, dy, dz = xs[i + 1] - xs[i], ys[i + 1] - ys[i], zs[i + 1] - zs[i]
		left[i] = left[i + 1] + sqrt(dx * dx + dy * dy + dz * dz)
	end
	for i = n + 1, #xs do xs[i], ys[i], zs[i], left[i] = nil, nil, nil, nil end
	for i = n, #cls do cls[i] = nil end
	for i = n, #fl do fl[i] = nil end
	for i = m + 1, #strip do strip[i] = nil end
	leg.n, leg.m = n, m
	return true
end

-- The current guide's leg into step `step`, decoded; nil without one.
function Nav.BakedLeg(step)
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	if not g or type(step) ~= "number" then return nil end
	local legs = rawget(g, "legs")
	if type(legs) ~= "table" then legs = ns.Guides and ns.Guides.Legs and ns.Guides.Legs(g.id) end
	local s = type(legs) == "table" and legs[step]
	if type(s) ~= "string" then return nil end
	if s ~= cached then
		cached = nil
		if not decode(s) then return nil end
		cached = s
		decodes = decodes + 1
		leg.id = decodes
	end
	-- The leg's continent: the step's own (its first located goal), as the
	-- compiler placed it; the follower works in the player's.
	local view = E.GetStepView and E.GetStepView(step)
	local c
	for _, gv in ipairs(view and view.goals or {}) do
		if gv.map and gv.x and gv.y then
			c = ns.Compat.MapToWorld(gv.map, gv.x, gv.y, gv.f)
			if c then break end
		end
	end
	leg.c, leg.step, leg.guide = c, step, g.id
	return leg
end
