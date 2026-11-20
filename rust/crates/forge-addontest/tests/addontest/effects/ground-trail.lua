-- env: trail
-- The Ground trail page (Polestar_Options/Nav/WorldTrailOptions.lua; Nav/WorldTrail.lua, Maps/WorldTrailRender.lua):
-- its switch and the settings of its shape and sparkles on the live ground trail, as its painter draws it. A
-- straight walk of 200 yards, the player ten yards along it, the view down the route. Every check has the trail on
-- (its own switch's aside) and still: Flow toward goal at 0 and the twinkle held at one moment (the painter's clock
-- is its own and runs while it paints), so two reads differ by the setting alone and a fresh session reads what
-- this one read. The looks, the flow and the page's buttons: effects/ground-trail-looks.lua.
local R, W
local function r3(v) return math.floor((v or 0) * 1000 + 0.5) / 1000 end
-- A check with the trail on and still, under whatever else it names (`with`), with a value, prepare or cleanup of
-- its own (`more`).
local function still(probe, with, more)
	local e = { with = { ["nav.worldTrail"] = true, ["nav.worldTrailFlow"] = 0 }, probe = probe }
	for k, v in pairs(with or {}) do e.with[k] = v end
	for k, v in pairs(more or {}) do e[k] = v end
	return e
end
-- How many sparkles are painted (false: none, the trail is not drawn).
local function count()
	local g = R.GroundFrame()
	return g ~= nil and g:IsShown() and g.used > 0 and g.used
end
local function drawn() return count() ~= false end
-- The first sparkle painted and its glow.
local function first()
	local g = R.GroundFrame()
	if not (g and g:IsShown() and g.used > 0) then return nil end
	return g.stars[1], g.halos[1]
end
-- Where the last paint laid its sparkles in the world (the route runs along x, the player on it): the nearest and
-- the farthest ahead of the player, and the farthest to either side of the route.
local function lay()
	local _, shown = R.Fades()
	local near, far, side = math.huge, 0, 0
	for i = 1, shown and shown.n or 0 do
		local q = shown[i]
		local ahead = q.x - W.px
		if ahead < near then near = ahead end
		if ahead > far then far = ahead end
		if math.abs(q.y - W.py) > side then side = math.abs(q.y - W.py) end
	end
	if far == 0 then return false end
	return { near = r3(near), far = r3(far), side = r3(side) }
end
-- The yards between two sparkles next to each other along the route (a sparkle's number is its place in the row;
-- the glints scattered about one have numbers of their own, from 100000).
local function gap()
	local _, shown = R.Fades()
	local a
	for i = 1, shown and shown.n or 0 do
		local q = shown[i]
		if q.id < 100000 then
			if not a then a = q elseif q.id ~= a.id then return r3((q.x - a.x) / (q.id - a.id)) end
		end
	end
	return false
end
-- The walk's baked strip as Nav's walker hands it to the trail (flat ground), and walking maps that know the
-- ground everywhere but in the cells 25 to 34 yards ahead: a wall across the route.
local function wall()
	local leg = W.route.legs[1]
	local strip = { c = leg.pts[1][1], xs = {}, ys = {}, distances = {}, n = #leg.pts, generation = 1, strip = { 0, 0 } }
	local total = 0
	for i, p in ipairs(leg.pts) do
		strip.xs[i], strip.ys[i] = p[2], p[3]
		if i > 1 then total = total + math.sqrt((p[2] - strip.xs[i - 1]) ^ 2 + (p[3] - strip.ys[i - 1]) ^ 2) end
		strip.distances[i] = total
	end
	strip.stripYd, strip.m = total, #strip.strip
	Polestar.Nav.walk = { WorldTrail = function() return strip, { sourceAlong = W.px, off = 0, generation = strip.generation } end }
	local function cell(x) return math.floor((x + 29.5 * 1600 / 3) / (1600 / 3 / 128)) end
	W.engine(function(_, x, _, out)
		if cell(x) >= cell(35) and cell(x) <= cell(44) then return 0 end
		out[1], out[-1] = 0, 0
		return 1
	end)
end
local function open()
	W.engine(nil)
	Polestar.Nav.walk = nil
end
return {
	setup = function()
		R, W = Polestar.WorldTrail.Render, stub.worldTrail
		local T = Polestar.WorldTrail.Trail
		local twinkle = T.Sparkle
		T.Sparkle = function(id, _, style, fade) return twinkle(id, 0, style, fade) end
	end,
	-- A trail turned on fades in, and one whose route changed fades in over a little longer.
	settle = 1,
	probes = {
		["nav.worldTrail"] = { with = { ["nav.worldTrailFlow"] = 0 }, probe = drawn },
		-- Inside a building the trail is not drawn unless it is asked to be.
		["nav.worldTrailIndoors"] = still(drawn, nil, { prepare = function() W.indoors = true end, cleanup = function() W.indoors = nil end }),
		-- Past the wall: the trail's whole length with Fit to view off, cut short of the wall with it on (its
		-- length eases there, so the read waits, and tells the two apart by more than the easing leaves).
		["nav.worldTrailSight"] = still(function()
			stub.advance(4)
			local l = lay()
			return l and l.far > 40
		end, { ["nav.worldTrailLength"] = 50 }, { prepare = wall, cleanup = open }),
		["nav.worldTrailLength"] = still(function() local l = lay(); return l and l.far end),
		["nav.worldTrailGap"] = still(gap, { ["nav.worldTrailLength"] = 60 }),
		["nav.worldTrailWidth"] = still(function() local l = lay(); return l and l.side end),
		["nav.worldTrailAhead"] = still(function() local l = lay(); return l and l.near end),
		-- Fading toward its far end: every sparkle's alpha, added up.
		["nav.worldTrailFade"] = still(function()
			local g, sum = R.GroundFrame(), 0
			for i = 1, g and g.used or 0 do sum = sum + g.stars[i]:GetAlpha() end
			return r3(sum)
		end),
		["nav.worldTrailLift"] = still(function()
			local star = first()
			if not star then return false end
			local _, _, _, _, y = star:GetPoint(1)
			return r3(y)
		end),
		["nav.worldTrailIntensity"] = still(function() local star = first(); return star and r3(star:GetAlpha()) end),
		["nav.worldTrailSubtlety"] = still(function()
			local star, halo = first()
			return star and { r3(star:GetWidth()), halo:IsShown() and r3(halo:GetAlpha()) or 0 }
		end),
		["nav.worldTrailSize"] = still(function() local star = first(); return star and r3(star:GetWidth()) end),
		-- The ceiling at its lowest holds fewer than a long trail shows.
		["nav.worldTrailMax"] = still(count, { ["nav.worldTrailLength"] = 200 }, { value = 10 }),
		["nav.worldTrailColor"] = still(function()
			local star = first()
			if not star then return false end
			local r, g, b = star:GetVertexColor()
			return { r3(r), r3(g), r3(b) }
		end),
	},
}
