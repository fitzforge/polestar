-- Automap (am_map.c): top-down line map of the level, toggled with Tab.
local D = FreedoomArcade
local AM = {}
D.AM = AM

local floor = math.floor
local cos, sin = math.cos, math.sin
local band = D.band
local Draw = D.Draw
local L = D.level

local ML_SECRET, ML_DONTDRAW, ML_MAPPED = 32, 128, 256
local LAYER = 1 -- under sprites/HUD; the 3D view isn't drawn while the map is up

AM.active = false
AM.scale = 0.2          -- screen pixels per map unit (Doom's INITSCALEMTOF)
local MINSCALE, MAXSCALE = 0.02, 2.0

-- colours from PLAYPAL
local WALL = { 1, 0, 0 }              -- one-sided walls (REDS)
local FLOORCHANGE = { 0.75, 0.48, 0.29 } -- floor height change (BROWNS)
local CEILCHANGE = { 1, 1, 0 }        -- ceiling height change (YELLOWS)
local UNSEEN = { 0.51, 0.51, 0.51 }   -- revealed by the computer map (GRAYS)
local TELEPORT = { 0.6, 0.1, 0.1 }
local KEYBLUE = { 0.25, 0.4, 1 }
local KEYYELLOW = { 1, 0.85, 0.1 }
local KEYRED = { 1, 0.15, 0.15 }
local PLAYER = { 1, 1, 1 }

local keyColor = {
	[26] = KEYBLUE, [32] = KEYBLUE, [99] = KEYBLUE, [133] = KEYBLUE,
	[27] = KEYYELLOW, [34] = KEYYELLOW, [136] = KEYYELLOW, [137] = KEYYELLOW,
	[28] = KEYRED, [33] = KEYRED, [134] = KEYRED, [135] = KEYRED,
}

-- player arrow from am_map.c, in map units (R = 8*PLAYERRADIUS/7)
local R = 8 * 16 / 7
local arrow = {
	{ -R + R / 8, 0, R, 0 },
	{ R, 0, R - R / 2, R / 4 },
	{ R, 0, R - R / 2, -R / 4 },
	{ -R + R / 8, 0, -R - R / 8, R / 4 },
	{ -R + R / 8, 0, -R - R / 8, -R / 4 },
	{ -R + 3 * R / 8, 0, -R + R / 8, R / 4 },
	{ -R + 3 * R / 8, 0, -R + R / 8, -R / 4 },
}

function AM.Toggle()
	AM.active = not AM.active
end

function AM.Zoom(dir)
	if dir > 0 then
		AM.scale = AM.scale * 1.25
	else
		AM.scale = AM.scale / 1.25
	end
	if AM.scale < MINSCALE then AM.scale = MINSCALE end
	if AM.scale > MAXSCALE then AM.scale = MAXSCALE end
end

-- Cohen-Sutherland clip to the map window
local W, H
local function outcode(x, y)
	local c = 0
	if x < 0 then c = c + 1 elseif x > W then c = c + 2 end
	if y < 0 then c = c + 4 elseif y > H then c = c + 8 end
	return c
end

local function clipLine(x1, y1, x2, y2)
	local c1, c2 = outcode(x1, y1), outcode(x2, y2)
	for _ = 1, 8 do
		if c1 == 0 and c2 == 0 then return x1, y1, x2, y2 end
		if band(c1, c2) ~= 0 then return nil end
		local c = c1 ~= 0 and c1 or c2
		local x, y
		if band(c, 8) ~= 0 then
			x = x1 + (x2 - x1) * (H - y1) / (y2 - y1); y = H
		elseif band(c, 4) ~= 0 then
			x = x1 + (x2 - x1) * (0 - y1) / (y2 - y1); y = 0
		elseif band(c, 2) ~= 0 then
			y = y1 + (y2 - y1) * (W - x1) / (x2 - x1); x = W
		else
			y = y1 + (y2 - y1) * (0 - x1) / (x2 - x1); x = 0
		end
		if c == c1 then
			x1, y1 = x, y; c1 = outcode(x1, y1)
		else
			x2, y2 = x, y; c2 = outcode(x2, y2)
		end
	end
	return nil
end

function AM.Draw(player)
	W, H = 320, D.R.viewheight
	local mo = player.mo
	local px, py = mo.x, mo.y
	local s = AM.scale
	local cx, cy = W / 2, H / 2
	Draw.Rect(LAYER, 0, 0, W, H, 0, 0, 0, 1)

	local allmap = player.powers[D.pw_allmap] ~= 0
	local lines = L.lines
	local thick = 1
	for i = 0, L.numlines - 1 do
		local ln = lines[i]
		local col
		local mapped = ln.mapped or band(ln.flags, ML_MAPPED) ~= 0
		if mapped then
			if band(ln.flags, ML_DONTDRAW) == 0 then
				local bs = ln.backsector
				if keyColor[ln.special] then
					col = keyColor[ln.special]
				elseif ln.special == 39 or ln.special == 97 then
					col = TELEPORT
				elseif not bs or band(ln.flags, ML_SECRET) ~= 0 then
					col = WALL
				elseif bs.floorheight ~= ln.frontsector.floorheight then
					col = FLOORCHANGE
				elseif bs.ceilingheight ~= ln.frontsector.ceilingheight then
					col = CEILCHANGE
				end
			end
		elseif allmap and band(ln.flags, ML_DONTDRAW) == 0 then
			col = UNSEEN
		end
		if col then
			local x1 = cx + (ln.v1.x - px) * s
			local y1 = cy - (ln.v1.y - py) * s
			local x2 = cx + (ln.v2.x - px) * s
			local y2 = cy - (ln.v2.y - py) * s
			x1, y1, x2, y2 = clipLine(x1, y1, x2, y2)
			if x1 then
				Draw.Line(LAYER + 1, x1, y1, x2, y2, col[1], col[2], col[3], 1, thick)
			end
		end
	end

	-- player arrow (never smaller than at the default zoom)
	local as = s < 0.2 and 0.2 or s
	local ang = mo.angle / D.BAM_PER_RAD
	local c, sn = cos(ang), sin(ang)
	for _, a in ipairs(arrow) do
		local ax1 = cx + (a[1] * c - a[2] * sn) * as
		local ay1 = cy - (a[1] * sn + a[2] * c) * as
		local ax2 = cx + (a[3] * c - a[4] * sn) * as
		local ay2 = cy - (a[3] * sn + a[4] * c) * as
		Draw.Line(LAYER + 2, ax1, ay1, ax2, ay2, PLAYER[1], PLAYER[2], PLAYER[3], 1, thick)
	end

	-- level name, bottom left like Doom
	local G = D.G
	local name = string.format("E%dM%d", G.gameepisode, G.gamemap)
	local lvl = D.R.GfxTex(string.format("WILV%d%d", G.gameepisode - 1, G.gamemap - 1))
	if lvl and lvl.h < 24 then
		Draw.Patch(LAYER + 2, 2, H - lvl.h - 1, lvl)
	else
		G.DrawText(LAYER + 2, 2, H - 9, name)
	end
end
