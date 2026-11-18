-- env: trail
-- The Ground trail page's looks, its flow and its buttons (Polestar_Options/Nav/WorldTrailOptions.lua;
-- Nav/WorldTrail.lua, Maps/WorldTrailRender.lua): on the live ground trail and on the Look row. The walk of
-- effects/ground-trail.lua, the twinkle held as there; the sparkles flow here, so each read is one their drift does
-- not change (how far apart they are, their colour, how far one moves in a given time).
local R
local function r3(v) return math.floor((v or 0) * 1000 + 0.5) / 1000 end
local function drawn()
	local g = R.GroundFrame()
	return g ~= nil and g:IsShown() and g.used > 0
end
-- The sparkles of the last paint that stand in the row along the route, by their numbers: where each is along it
-- (the route runs along x; the glints scattered about one have numbers of their own, from 100000).
local function row()
	local _, shown = R.Fades()
	local at = {}
	for i = 1, shown and shown.n or 0 do
		if shown[i].id < 100000 then at[shown[i].id] = shown[i].x end
	end
	return at
end
-- The yards between two sparkles next to each other along the route.
local function gap()
	local at, a, b = row(), nil, nil
	for id in pairs(at) do
		if not a or id < a then a, b = id, a elseif not b or id < b then b = id end
	end
	return a and b and r3((at[b] - at[a]) / (b - a)) or false
end
-- How far a sparkle moves toward the goal in half a second.
local function drift()
	local was = row()
	stub.advance(0.5)
	local now, id = row(), nil
	for k in pairs(now) do
		if was[k] and (not id or k < id) then id = k end
	end
	return id and r3(now[id] - was[id]) or false
end
-- The Look row as the page has it: the look it shows and how many it lists.
local function look()
	for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
		for _, c in ipairs(spec.controls or {}) do
			if c.label == Polestar.L["Look"] and c.get then return { shows = c.get(), lists = #c.choices() } end
		end
	end
	return false
end
return {
	setup = function()
		R = Polestar.WorldTrail.Render
		local T = Polestar.WorldTrail.Trail
		local twinkle = T.Sparkle
		T.Sparkle = function(id, _, style, fade) return twinkle(id, 0, style, fade) end
	end,
	settle = 1,
	probes = {
		["nav.worldTrailFlow"] = { with = { ["nav.worldTrail"] = true }, probe = drift },
		-- A look sets the trail's shape and sparkles at once: the next one in the list lays them further apart.
		["Ground trail:Look"] = { with = { ["nav.worldTrail"] = true }, probe = function()
			local g = R.GroundFrame()
			if not drawn() then return false end
			local r, gr, b = g.stars[1]:GetVertexColor()
			return { gap(), r3(r), r3(gr), r3(b) }
		end },
		-- A tuned trail saved: the Look row shows it as the saved look, no longer as Custom.
		["Ground trail:Save custom look"] = { press = true, with = { ["nav.worldTrailSize"] = 20 }, probe = look,
			cleanup = function() Polestar.Set("nav.worldTrailCustomLook", nil) end },
		-- The warning's row, shown while the trail's waypoint is off: its button turns that switch on.
		["Ground trail:The trail's waypoint is off. The trail reads the camera's angle from it, and without it the trail is drawn short once you have moved the camera."] = {
			press = true, with = { ["nav.worldTrail"] = true, ["nav.worldTrailWaypoint"] = false },
			probe = function() return Polestar.Get("nav.worldTrailWaypoint") end,
		},
		-- A tuned trail that is on: off again and back to the default look.
		["Ground trail:Reset ground trail"] = { press = true, with = { ["nav.worldTrail"] = true, ["nav.worldTrailSize"] = 20 },
			probe = function() return { drawn(), Polestar.WorldTrail.CurrentLook() } end },
	},
}
