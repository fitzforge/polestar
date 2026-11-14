-- Renderer: a floating point port of Doom's r_bsp / r_segs / r_plane / r_things.
-- Instead of writing pixels, it emits textured quads to D.Draw:
--   walls and sky  -> one quad per screen column
--   floors/ceilings -> one quad per horizontal span (texcoords interpolate along the span)
--   sprites / masked midtextures -> quads clipped into runs of columns, each on its own layer
local D = FreedoomArcade
local R = {}
D.R = R

local floor, ceil, abs, sqrt = math.floor, math.ceil, math.abs, math.sqrt
local cos, sin = math.cos, math.sin
local pi = math.pi
local band = D.band

local ML_DONTPEGTOP, ML_DONTPEGBOTTOM, ML_TWOSIDED = 8, 16, 4
local SIL_NONE, SIL_BOTTOM, SIL_TOP, SIL_BOTH = 0, 1, 2, 3
local FF_FULLBRIGHT = 32768
local FF_FRAMEMASK = 32767
local MF_SHADOW = 0x40000
local UNSET = 32767
local MAXSHORT = 32767

local L = D.level
local Draw -- set in R.Init

------------------------------------------------------------------------ texture info
local texpath = D.ADDON_PATH .. "tex\\"
local wallCache, flatCache, spriteCache, gfxCache = {}, {}, {}, {}

R.texturetranslation = {} -- name -> name (animated walls)
R.flattranslation = {}    -- name -> name (animated flats)

function R.WallTex(name)
	local t = wallCache[name]
	if t == nil then
		local m = D.TEXTURES[name]
		if m then
			t = { path = texpath .. "w" .. m[1], w = m[2], h = m[3], wrap = true, name = name }
		else
			t = false
		end
		wallCache[name] = t
	end
	return t
end

function R.FlatTex(name)
	local t = flatCache[name]
	if t == nil then
		local idx = D.FLATS[name]
		t = idx and { path = texpath .. "f" .. idx, w = 64, h = 64, wrap = true, name = name } or false
		flatCache[name] = t
	end
	return t
end

-- sprites / gfx: {path, w, h, leftoffset, topoffset, potW, potH}
local function patchInfo(cache, tbl, prefix, name)
	local t = cache[name]
	if t == nil then
		local m = tbl[name]
		if m then
			t = { path = texpath .. prefix .. m[1], w = m[2], h = m[3], lo = m[4], to = m[5], pw = m[6], ph = m[7], wrap = false, name = name }
		else
			t = false
		end
		cache[name] = t
	end
	return t
end
function R.SpriteTex(name) return patchInfo(spriteCache, D.SPRITELUMPS, "s", name) end
function R.GfxTex(name) return patchInfo(gfxCache, D.GFX, "g", name) end

function R.TextureHeight(name)
	local t = R.WallTex(name)
	return t and t.h or 0
end

------------------------------------------------------------------------ view setup
local RW, RH          -- render columns / rows
local CW              -- logical pixels per render column (320 / RW)
local centerx, centery
local projx, projy
local xlat = {}        -- per column: lateral/forward ratio at column centre
local xangle = {}      -- per column: angle offset (radians) at column centre
local yslope = {}
local screenheightarray, negonearray = {}, {}
local scalelight = {}  -- [lightnum][index] -> brightness
local zlight = {}

R.SKYFLAT = "F_SKY1"
R.skytexture = "SKY1"

function R.SetViewSize(columns, viewheight)
	RW, RH = columns, viewheight
	CW = 320 / RW
	centerx = RW / 2
	centery = floor(RH / 2)
	projx = RW / 2
	projy = 160
	for x = 0, RW - 1 do
		xlat[x] = (centerx - (x + 0.5)) / projx
		xangle[x] = math.atan(xlat[x])
		screenheightarray[x] = RH
		negonearray[x] = -1
	end
	for y = 0, RH - 1 do
		local dy = abs((y - centery) + 0.5)
		yslope[y] = projy / dy
	end
	local LF = D.LIGHTFACTOR
	for i = 0, 15 do
		local startmap = (15 - i) * 4
		scalelight[i] = {}
		for j = 0, 47 do
			local level = startmap - floor(j / 2)
			if level < 0 then level = 0 elseif level > 31 then level = 31 end
			scalelight[i][j] = LF[level]
		end
		zlight[i] = {}
		for j = 0, 127 do
			local scale = floor(160 / (j + 1))
			local level = startmap - floor(scale / 2)
			if level < 0 then level = 0 elseif level > 31 then level = 31 end
			zlight[i][j] = LF[level]
		end
	end
	R.viewwidth, R.viewheight, R.columns = RW, RH, RW
end

------------------------------------------------------------------------ per frame state
local viewx, viewy, viewz, viewangle, viewcos, viewsin, viewrad
local extralight = 0
local fixedbright = false
local validcount = 0

-- solidsegs
local ssf, ssl = {}, {}
local ssn = 0

-- clip arrays
local ceilingclip, floorclip = {}, {}

-- openings: per-drawseg saved arrays (sprite clip, masked columns, scales)
local openings = {}
local lastopening = 0

-- drawsegs
local drawsegs = {}
local ds_n = 0

-- visplanes
local visplanes = {}
local vp_n = 0
local vp_first = {} -- key -> first plane index
local floorplane, ceilingplane

-- vissprites
local vissprites = {}
local vs_n = 0
local vsorted = {}

-- current seg
local curline, frontsector, backsector, sidedef, linedef

local layer = 1 -- next sprite/masked layer

------------------------------------------------------------------------ planes
local function NewPlane(height, picnum, lightlevel, minx, maxx)
	vp_n = vp_n + 1
	local pl = visplanes[vp_n]
	if not pl then
		pl = { top = {}, bottom = {}, minx = 0, maxx = RW - 1, clearlo = -1, clearhi = RW }
		for x = -1, RW do pl.top[x] = UNSET; pl.bottom[x] = -1 end
		visplanes[vp_n] = pl
	else
		local top, bottom = pl.top, pl.bottom
		local lo, hi = pl.clearlo, pl.clearhi
		if lo < -1 then lo = -1 end
		if hi > RW then hi = RW end
		for x = lo, hi do top[x] = UNSET; bottom[x] = -1 end
	end
	pl.height, pl.picnum, pl.lightlevel = height, picnum, lightlevel
	pl.minx, pl.maxx = minx, maxx
	pl.clearlo, pl.clearhi = RW, -1
	return pl
end

local function FindPlane(height, picnum, lightlevel)
	if picnum == R.SKYFLAT then
		height, lightlevel = 0, 0
	end
	local key = picnum .. "|" .. height .. "|" .. lightlevel
	local idx = vp_first[key]
	if idx then return visplanes[idx] end
	local pl = NewPlane(height, picnum, lightlevel, RW, -1)
	vp_first[key] = vp_n
	return pl
end

local function CheckPlane(pl, start, stop)
	local intrl, intrh, unionl, unionh
	if start < pl.minx then
		intrl, unionl = pl.minx, start
	else
		unionl, intrl = pl.minx, start
	end
	if stop > pl.maxx then
		intrh, unionh = pl.maxx, stop
	else
		unionh, intrh = pl.maxx, stop
	end
	local top = pl.top
	local x = intrl
	while x <= intrh do
		if top[x] ~= UNSET then break end
		x = x + 1
	end
	if x > intrh then
		pl.minx, pl.maxx = unionl, unionh
		return pl
	end
	return NewPlane(pl.height, pl.picnum, pl.lightlevel, start, stop)
end

local function markRange(pl, x)
	if x < pl.clearlo then pl.clearlo = x end
	if x > pl.clearhi then pl.clearhi = x end
end

------------------------------------------------------------------------ walls
local function lightnumFor(sector)
	local ln = floor(sector.lightlevel / 16) + extralight
	if curline and curline.v1.y == curline.v2.y then
		ln = ln - 1
	elseif curline and curline.v1.x == curline.v2.x then
		ln = ln + 1
	end
	if ln < 0 then ln = 0 elseif ln > 15 then ln = 15 end
	return ln
end

local function lightFromScale(lights, scale)
	if fixedbright then return 1 end
	local j = floor(scale * 16)
	if j > 47 then j = 47 elseif j < 0 then j = 0 end
	return lights[j]
end

-- emits one vertical wall column [yl, yh] using texture tex at column u
local function WallColumn(x, yl, yh, tex, u, texmid, scale, bright)
	local iscale = 1 / scale
	local w, h = tex.w, tex.h
	local col = floor(u) % w
	local uu = (col + 0.5) / w
	local v1 = (texmid + (yl - centery) * iscale) / h
	local v2 = (texmid + (yh + 1 - centery) * iscale) / h
	local shift = -floor(v1)
	v1, v2 = v1 + shift, v2 + shift
	local sx = x * CW
	Draw.Quad(0, sx, yl, sx + CW, yh + 1, tex, uu, v1, uu, v2, uu, v1, uu, v2, bright, bright, bright, 1)
end

local function StoreWallRange(start, stop, A_f, A_l, B_f, B_l, seglen)
	ds_n = ds_n + 1
	local ds = drawsegs[ds_n]
	if not ds then ds = {}; drawsegs[ds_n] = ds end
	ds.curline = curline
	ds.x1, ds.x2 = start, stop

	sidedef = curline.sidedef
	linedef = curline.linedef
	linedef.mapped = true

	local fs = frontsector
	local bs = backsector
	local worldtop = fs.ceilingheight - viewz
	local worldbottom = fs.floorheight - viewz
	local worldhigh, worldlow = 0, 0

	local midtexture, toptexture, bottomtexture, maskedtexture = false, false, false, false
	local rw_midtexturemid, rw_toptexturemid, rw_bottomtexturemid = 0, 0, 0
	local markfloor, markceiling
	local tt = R.texturetranslation

	ds.maskedtexturecol = nil
	ds.sprtopclip, ds.sprbottomclip = nil, nil
	ds.bsilheight, ds.tsilheight = D.MAXINT, D.MININT
	ds.scales = nil

	if not bs then
		local name = sidedef.midtexture
		midtexture = name and R.WallTex(tt[name] or name)
		markfloor, markceiling = true, true
		if midtexture then
			if band(linedef.flags, ML_DONTPEGBOTTOM) ~= 0 then
				rw_midtexturemid = fs.floorheight + midtexture.h - viewz
			else
				rw_midtexturemid = worldtop
			end
			rw_midtexturemid = rw_midtexturemid + sidedef.rowoffset
		end
		ds.silhouette = SIL_BOTH
		ds.sprtopclip = screenheightarray
		ds.sprtopoff = 0
		ds.sprbottomclip = negonearray
		ds.sprbottomoff = 0
		ds.bsilheight = D.MAXINT
		ds.tsilheight = D.MININT
	else
		ds.silhouette = SIL_NONE
		if fs.floorheight > bs.floorheight then
			ds.silhouette = SIL_BOTTOM
			ds.bsilheight = fs.floorheight
		elseif bs.floorheight > viewz then
			ds.silhouette = SIL_BOTTOM
			ds.bsilheight = D.MAXINT
		end
		if fs.ceilingheight < bs.ceilingheight then
			ds.silhouette = ds.silhouette + (band(ds.silhouette, SIL_TOP) == 0 and SIL_TOP or 0)
			ds.tsilheight = fs.ceilingheight
		elseif bs.ceilingheight < viewz then
			ds.silhouette = ds.silhouette + (band(ds.silhouette, SIL_TOP) == 0 and SIL_TOP or 0)
			ds.tsilheight = D.MININT
		end
		if bs.ceilingheight <= fs.floorheight then
			ds.sprbottomclip = negonearray
			ds.sprbottomoff = 0
			ds.bsilheight = D.MAXINT
			ds.silhouette = D.bor(ds.silhouette, SIL_BOTTOM)
		end
		if bs.floorheight >= fs.ceilingheight then
			ds.sprtopclip = screenheightarray
			ds.sprtopoff = 0
			ds.tsilheight = D.MININT
			ds.silhouette = D.bor(ds.silhouette, SIL_TOP)
		end

		worldhigh = bs.ceilingheight - viewz
		worldlow = bs.floorheight - viewz

		if fs.ceilingpic == R.SKYFLAT and bs.ceilingpic == R.SKYFLAT then
			worldtop = worldhigh
		end

		markfloor = worldlow ~= worldbottom or bs.floorpic ~= fs.floorpic or bs.lightlevel ~= fs.lightlevel
		markceiling = worldhigh ~= worldtop or bs.ceilingpic ~= fs.ceilingpic or bs.lightlevel ~= fs.lightlevel

		if bs.ceilingheight <= fs.floorheight or bs.floorheight >= fs.ceilingheight then
			markceiling, markfloor = true, true
		end

		if worldhigh < worldtop then
			local name = sidedef.toptexture
			toptexture = name and R.WallTex(tt[name] or name)
			if toptexture then
				if band(linedef.flags, ML_DONTPEGTOP) ~= 0 then
					rw_toptexturemid = worldtop
				else
					rw_toptexturemid = bs.ceilingheight + toptexture.h - viewz
				end
			end
		end
		if worldlow > worldbottom then
			local name = sidedef.bottomtexture
			bottomtexture = name and R.WallTex(tt[name] or name)
			if band(linedef.flags, ML_DONTPEGBOTTOM) ~= 0 then
				rw_bottomtexturemid = worldtop
			else
				rw_bottomtexturemid = worldlow
			end
		end
		rw_toptexturemid = rw_toptexturemid + sidedef.rowoffset
		rw_bottomtexturemid = rw_bottomtexturemid + sidedef.rowoffset

		if sidedef.midtexture then
			maskedtexture = true
			ds.maskedtexturecol = openings
			ds.maskoff = lastopening - start
			lastopening = lastopening + (stop - start + 1)
		end
	end

	if fs.floorheight >= viewz then markfloor = false end
	if fs.ceilingheight <= viewz and fs.ceilingpic ~= R.SKYFLAT then markceiling = false end

	-- per column scales (also stored for sprite / masked clipping)
	ds.scales = openings
	ds.scaleoff = lastopening - start
	lastopening = lastopening + (stop - start + 1)

	local lights = scalelight[lightnumFor(fs)]
	local textureoffset = curline.offset + sidedef.textureoffset
	local dF, dL = B_f - A_f, B_l - A_l
	local scaleoff = ds.scaleoff
	local maskoff = ds.maskoff

	if markceiling and ceilingplane then
		ceilingplane = CheckPlane(ceilingplane, start, stop)
	end
	if markfloor and floorplane then
		floorplane = CheckPlane(floorplane, start, stop)
	end
	local cplane, fplane = ceilingplane, floorplane
	if not cplane then markceiling = false end
	if not fplane then markfloor = false end

	local scale1, scale2
	for x = start, stop do
		local lat = xlat[x]
		local denom = dL - lat * dF
		local t
		if denom ~= 0 then t = (lat * A_f - A_l) / denom else t = 0 end
		if t < 0 then t = 0 elseif t > 1 then t = 1 end
		local z = A_f + t * dF
		local scale
		if z < 0.01 then scale = 64 else
			scale = projy / z
			if scale > 64 then scale = 64 elseif scale < 0.00390625 then scale = 0.00390625 end
		end
		if x == start then scale1 = scale end
		scale2 = scale
		openings[scaleoff + x] = scale

		local top = centery - worldtop * scale
		local bottom = centery - worldbottom * scale

		local cc, fc = ceilingclip[x], floorclip[x]
		local yl = ceil(top)
		if yl < cc + 1 then yl = cc + 1 end

		if markceiling then
			local t1 = cc + 1
			local b1 = yl - 1
			if b1 >= fc then b1 = fc - 1 end
			if t1 <= b1 then
				cplane.top[x] = t1
				cplane.bottom[x] = b1
				markRange(cplane, x)
			end
		end

		local yh = floor(bottom)
		if yh >= fc then yh = fc - 1 end

		if markfloor then
			local t1 = yh + 1
			local b1 = fc - 1
			if t1 <= cc then t1 = cc + 1 end
			if t1 <= b1 then
				fplane.top[x] = t1
				fplane.bottom[x] = b1
				markRange(fplane, x)
			end
		end

		local u = textureoffset + t * seglen
		local bright = lightFromScale(lights, scale)

		if midtexture then
			if yl <= yh then
				WallColumn(x, yl, yh, midtexture, u, rw_midtexturemid, scale, bright)
			end
			ceilingclip[x] = RH
			floorclip[x] = -1
		else
			if toptexture then
				local mid = floor(centery - worldhigh * scale)
				if mid >= fc then mid = fc - 1 end
				if mid >= yl then
					WallColumn(x, yl, mid, toptexture, u, rw_toptexturemid, scale, bright)
					ceilingclip[x] = mid
				else
					ceilingclip[x] = yl - 1
				end
			elseif markceiling then
				ceilingclip[x] = yl - 1
			end

			if bottomtexture then
				local mid = ceil(centery - worldlow * scale)
				if mid <= ceilingclip[x] then mid = ceilingclip[x] + 1 end
				if mid <= yh then
					WallColumn(x, mid, yh, bottomtexture, u, rw_bottomtexturemid, scale, bright)
					floorclip[x] = mid
				else
					floorclip[x] = yh + 1
				end
			elseif markfloor then
				floorclip[x] = yh + 1
			end

			if maskedtexture then
				openings[maskoff + x] = u
			end
		end
	end
	ds.scale1, ds.scale2 = scale1, scale2

	-- save sprite clipping info
	if (band(ds.silhouette, SIL_TOP) ~= 0 or maskedtexture) and not ds.sprtopclip then
		local off = lastopening - start
		for x = start, stop do openings[off + x] = ceilingclip[x] end
		ds.sprtopclip, ds.sprtopoff = openings, off
		lastopening = lastopening + (stop - start + 1)
	end
	if (band(ds.silhouette, SIL_BOTTOM) ~= 0 or maskedtexture) and not ds.sprbottomclip then
		local off = lastopening - start
		for x = start, stop do openings[off + x] = floorclip[x] end
		ds.sprbottomclip, ds.sprbottomoff = openings, off
		lastopening = lastopening + (stop - start + 1)
	end
	if maskedtexture and band(ds.silhouette, SIL_TOP) == 0 then
		ds.silhouette = D.bor(ds.silhouette, SIL_TOP)
		ds.tsilheight = D.MININT
	end
	if maskedtexture and band(ds.silhouette, SIL_BOTTOM) == 0 then
		ds.silhouette = D.bor(ds.silhouette, SIL_BOTTOM)
		ds.bsilheight = D.MAXINT
	end
	ceilingplane, floorplane = cplane or ceilingplane, fplane or floorplane
end

------------------------------------------------------------------------ solid segs
local cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len

local function ClipSolidWallSegment(first, last)
	local start = 1
	while ssl[start] < first - 1 do start = start + 1 end
	if first < ssf[start] then
		if last < ssf[start] - 1 then
			StoreWallRange(first, last, cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len)
			-- insert new clippost at start
			for i = ssn, start, -1 do
				ssf[i + 1], ssl[i + 1] = ssf[i], ssl[i]
			end
			ssn = ssn + 1
			ssf[start], ssl[start] = first, last
			return
		end
		StoreWallRange(first, ssf[start] - 1, cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len)
		ssf[start] = first
	end
	if last <= ssl[start] then return end
	local nxt = start
	local crunch = false
	while last >= ssf[nxt + 1] - 1 do
		StoreWallRange(ssl[nxt] + 1, ssf[nxt + 1] - 1, cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len)
		nxt = nxt + 1
		if last <= ssl[nxt] then
			ssl[start] = ssl[nxt]
			crunch = true
			break
		end
	end
	if not crunch then
		StoreWallRange(ssl[nxt] + 1, last, cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len)
		ssl[start] = last
	end
	if nxt == start then return end
	-- remove start+1 .. nxt
	local dst = start
	for i = nxt + 1, ssn do
		dst = dst + 1
		ssf[dst], ssl[dst] = ssf[i], ssl[i]
	end
	ssn = dst
end

local function ClipPassWallSegment(first, last)
	local start = 1
	while ssl[start] < first - 1 do start = start + 1 end
	if first < ssf[start] then
		if last < ssf[start] - 1 then
			StoreWallRange(first, last, cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len)
			return
		end
		StoreWallRange(first, ssf[start] - 1, cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len)
	end
	if last <= ssl[start] then return end
	while last >= ssf[start + 1] - 1 do
		StoreWallRange(ssl[start] + 1, ssf[start + 1] - 1, cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len)
		start = start + 1
		if last <= ssl[start] then return end
	end
	StoreWallRange(ssl[start] + 1, last, cur_Af, cur_Al, cur_Bf, cur_Bl, cur_len)
end

-- clip a view-space segment to the 90 degree frustum; returns screen x range or nil
local function ProjectRange(Af, Al, Bf, Bl)
	local t0, t1 = 0, 1
	-- left plane: f - l >= 0
	local a, b = Af - Al, Bf - Bl
	if a < 0 and b < 0 then return nil end
	if a < 0 then local t = a / (a - b); if t > t0 then t0 = t end
	elseif b < 0 then local t = a / (a - b); if t < t1 then t1 = t end end
	-- right plane: f + l >= 0
	a, b = Af + Al, Bf + Bl
	if a < 0 and b < 0 then return nil end
	if a < 0 then local t = a / (a - b); if t > t0 then t0 = t end
	elseif b < 0 then local t = a / (a - b); if t < t1 then t1 = t end end
	if t0 >= t1 then return nil end
	local dF, dL = Bf - Af, Bl - Al
	local f0, l0 = Af + t0 * dF, Al + t0 * dL
	local f1, l1 = Af + t1 * dF, Al + t1 * dL
	if f0 <= 0.0001 or f1 <= 0.0001 then
		-- touching the eye point; treat as full edge
		if f0 <= 0.0001 and f1 <= 0.0001 then return nil end
	end
	local sx1 = f0 > 0.0001 and (centerx - l0 / f0 * projx) or (l0 >= 0 and 0 or RW)
	local sx2 = f1 > 0.0001 and (centerx - l1 / f1 * projx) or (l1 >= 0 and 0 or RW)
	if sx1 > sx2 then sx1, sx2 = sx2, sx1 end
	local x1 = ceil(sx1 - 0.5)
	local x2 = ceil(sx2 - 0.5) - 1
	if x1 < 0 then x1 = 0 end
	if x2 > RW - 1 then x2 = RW - 1 end
	if x1 > x2 then return nil end
	return x1, x2
end

local function AddLine(seg)
	local v1, v2 = seg.v1, seg.v2
	-- backface: viewer must be on the right (front) side of v1->v2
	local ldx, ldy = v2.x - v1.x, v2.y - v1.y
	if (viewx - v1.x) * ldy - (viewy - v1.y) * ldx <= 0 then return end

	local dx, dy = v1.x - viewx, v1.y - viewy
	local Af = dx * viewcos + dy * viewsin
	local Al = -dx * viewsin + dy * viewcos
	dx, dy = v2.x - viewx, v2.y - viewy
	local Bf = dx * viewcos + dy * viewsin
	local Bl = -dx * viewsin + dy * viewcos

	local x1, x2 = ProjectRange(Af, Al, Bf, Bl)
	if not x1 then return end

	curline = seg
	backsector = seg.backsector
	cur_Af, cur_Al, cur_Bf, cur_Bl = Af, Al, Bf, Bl
	local len = seg.length
	if not len then
		len = sqrt(ldx * ldx + ldy * ldy)
		seg.length = len
	end
	cur_len = len

	if not backsector then
		return ClipSolidWallSegment(x1, x2)
	end
	if backsector.ceilingheight <= frontsector.floorheight or backsector.floorheight >= frontsector.ceilingheight then
		return ClipSolidWallSegment(x1, x2)
	end
	if backsector.ceilingheight ~= frontsector.ceilingheight or backsector.floorheight ~= frontsector.floorheight then
		return ClipPassWallSegment(x1, x2)
	end
	if backsector.ceilingpic == frontsector.ceilingpic and backsector.floorpic == frontsector.floorpic
		and backsector.lightlevel == frontsector.lightlevel and not seg.sidedef.midtexture then
		return
	end
	return ClipPassWallSegment(x1, x2)
end

-- checkcoord from r_bsp.c (1-based box indices: top, bottom, left, right)
local checkcoord = {
	[0] = { 4, 1, 3, 2 }, { 4, 1, 3, 1 }, { 4, 2, 3, 1 }, { 1, 1, 1, 1 },
	{ 3, 1, 3, 2 }, { 1, 1, 1, 1 }, { 4, 2, 4, 1 }, { 1, 1, 1, 1 },
	{ 3, 1, 4, 2 }, { 3, 2, 4, 2 }, { 3, 2, 4, 1 },
}

local function CheckBBox(box)
	local boxx, boxy
	if viewx <= box[3] then boxx = 0 elseif viewx < box[4] then boxx = 1 else boxx = 2 end
	if viewy >= box[1] then boxy = 0 elseif viewy > box[2] then boxy = 1 else boxy = 2 end
	local boxpos = boxy * 4 + boxx
	if boxpos == 5 then return true end
	local cc = checkcoord[boxpos]
	local x1, y1, x2, y2 = box[cc[1]], box[cc[2]], box[cc[3]], box[cc[4]]
	local ax, ay = x1 - viewx, y1 - viewy
	local bx, by = x2 - viewx, y2 - viewy
	-- corner 1 must be counter-clockwise of corner 2, else we're sitting on a line
	if bx * ay - by * ax <= 0 then return true end
	local Af = ax * viewcos + ay * viewsin
	local Al = -ax * viewsin + ay * viewcos
	local Bf = bx * viewcos + by * viewsin
	local Bl = -bx * viewsin + by * viewcos
	local sx1, sx2 = ProjectRange(Af, Al, Bf, Bl)
	if not sx1 then return false end
	local start = 1
	while ssl[start] < sx2 do start = start + 1 end
	if sx1 >= ssf[start] and sx2 <= ssl[start] then
		return false
	end
	return true
end

------------------------------------------------------------------------ sprites
local function ProjectSprite(thing)
	local tr_x, tr_y = thing.x - viewx, thing.y - viewy
	local tz = tr_x * viewcos + tr_y * viewsin
	if tz < 4 then return end
	local tx = tr_x * viewsin - tr_y * viewcos -- positive = right
	if abs(tx) > tz * 4 then return end

	local sprdef = D.SPRITEDEFS[thing.sprite]
	if not sprdef then return end
	local frame = band(thing.frame, FF_FRAMEMASK)
	local sf = sprdef[frame]
	if not sf then return end
	local lumpname, flip
	if sf[1] then
		local ang = D.PointToAngle2(viewx, viewy, thing.x, thing.y)
		local rot = floor(((ang - thing.angle + 268435456 * 9) % 4294967296) / 536870912)
		lumpname, flip = sf[2 + rot * 2], sf[3 + rot * 2]
	else
		lumpname, flip = sf[2], sf[3]
	end
	if not lumpname then return end
	local tex = R.SpriteTex(lumpname)
	if not tex then return end

	local xscale = projx / tz
	local left = tx - tex.lo
	local sxL = centerx + left * xscale
	local sxR = centerx + (left + tex.w) * xscale
	local x1 = ceil(sxL - 0.5)
	local x2 = ceil(sxR - 0.5) - 1
	if x1 > RW - 1 or x2 < 0 or x1 > x2 then return end

	vs_n = vs_n + 1
	local vis = vissprites[vs_n]
	if not vis then vis = {}; vissprites[vs_n] = vis end
	vis.tex = tex
	vis.flip = flip
	vis.scale = projy / tz
	vis.xscale = xscale
	vis.sxL, vis.sxR = sxL, sxR
	vis.gx, vis.gy, vis.gz = thing.x, thing.y, thing.z
	vis.gzt = thing.z + tex.to
	vis.texturemid = vis.gzt - viewz
	vis.x1 = x1 < 0 and 0 or x1
	vis.x2 = x2 >= RW and RW - 1 or x2
	vis.shadow = band(thing.flags, MF_SHADOW) ~= 0
	if fixedbright or band(thing.frame, FF_FULLBRIGHT) ~= 0 then
		vis.bright = 1
	else
		vis.bright = lightFromScale(R.spritelights, vis.scale)
	end
end

local function AddSprites(sec)
	if sec.validcount == validcount then return end
	sec.validcount = validcount
	local ln = floor(sec.lightlevel / 16) + extralight
	if ln < 0 then ln = 0 elseif ln > 15 then ln = 15 end
	R.spritelights = scalelight[ln]
	local thing = sec.thinglist
	while thing do
		ProjectSprite(thing)
		thing = thing.snext
	end
end

------------------------------------------------------------------------ BSP
local function Subsector(num)
	local sub = L.subsectors[num]
	frontsector = sub.sector
	local fs = frontsector
	local fp = R.flattranslation
	if fs.floorheight < viewz then
		floorplane = FindPlane(fs.floorheight, fp[fs.floorpic] or fs.floorpic, fs.lightlevel)
	else
		floorplane = nil
	end
	if fs.ceilingheight > viewz or fs.ceilingpic == R.SKYFLAT then
		ceilingplane = FindPlane(fs.ceilingheight, fp[fs.ceilingpic] or fs.ceilingpic, fs.lightlevel)
	else
		ceilingplane = nil
	end
	AddSprites(fs)
	local segs = L.segs
	local first = sub.firstline
	for i = first, first + sub.numlines - 1 do
		AddLine(segs[i])
	end
end

local function RenderBSPNode(bspnum)
	if bspnum >= 32768 then
		if bspnum == 65535 then Subsector(0) else Subsector(bspnum - 32768) end
		return
	end
	local bsp = L.nodes[bspnum]
	local side
	local x, y = viewx, viewy
	if bsp.dx == 0 then
		if x <= bsp.x then side = bsp.dy > 0 and 1 or 0 else side = bsp.dy < 0 and 1 or 0 end
	elseif bsp.dy == 0 then
		if y <= bsp.y then side = bsp.dx < 0 and 1 or 0 else side = bsp.dx > 0 and 1 or 0 end
	else
		side = ((y - bsp.y) * bsp.dx >= bsp.dy * (x - bsp.x)) and 1 or 0
	end
	RenderBSPNode(bsp.children[side])
	if CheckBBox(bsp.bbox[1 - side]) then
		RenderBSPNode(bsp.children[1 - side])
	end
end

------------------------------------------------------------------------ plane drawing
local spanstart = {}
local mp_tex, mp_height, mp_lights

local function MapPlane(y, x1, x2)
	if x2 < x1 then return end
	local distance = mp_height * yslope[y]
	-- world positions at the left edge of x1 and right edge of x2
	local la = (centerx - x1) / projx * distance
	local lb = (centerx - (x2 + 1)) / projx * distance
	local fx, fy = viewx + viewcos * distance, viewy + viewsin * distance
	-- left vector = (-sin, cos)
	local wx1, wy1 = fx - viewsin * la, fy + viewcos * la
	local wx2, wy2 = fx - viewsin * lb, fy + viewcos * lb
	local u1, v1 = wx1 / 64, -wy1 / 64
	local u2, v2 = wx2 / 64, -wy2 / 64
	local su = -floor(u1 < u2 and u1 or u2)
	local sv = -floor(v1 < v2 and v1 or v2)
	u1, u2, v1, v2 = u1 + su, u2 + su, v1 + sv, v2 + sv
	local bright
	if fixedbright then bright = 1 else
		local j = floor(distance / 16)
		if j > 127 then j = 127 end
		bright = mp_lights[j]
	end
	Draw.Quad(0, x1 * CW, y, (x2 + 1) * CW, y + 1, mp_tex, u1, v1, u1, v1, u2, v2, u2, v2, bright, bright, bright, 1)
end

local function MakeSpans(x, t1, b1, t2, b2)
	while t1 < t2 and t1 <= b1 do
		MapPlane(t1, spanstart[t1], x - 1)
		t1 = t1 + 1
	end
	while b1 > b2 and b1 >= t1 do
		MapPlane(b1, spanstart[b1], x - 1)
		b1 = b1 - 1
	end
	while t2 < t1 and t2 <= b2 do
		spanstart[t2] = x
		t2 = t2 + 1
	end
	while b2 > b1 and b2 >= t2 do
		spanstart[b2] = x
		b2 = b2 - 1
	end
end

local function DrawSky(pl)
	local tex = R.WallTex(R.texturetranslation[R.skytexture] or R.skytexture)
	if not tex then return end
	local top, bottom = pl.top, pl.bottom
	local w, h = tex.w, tex.h
	-- sky: columns map linearly to angle; group columns with identical extents into quads of <= 8
	local x = pl.minx
	local maxx = pl.maxx
	local ANGLETOSKY = 4194304 -- 2^22
	while x <= maxx do
		local t, b = top[x], bottom[x]
		if t <= b then
			local x2 = x
			while x2 + 1 <= maxx and x2 + 1 - x < 8 and top[x2 + 1] == t and bottom[x2 + 1] == b do
				x2 = x2 + 1
			end
			-- sky texture column for a screen position (continuous)
			local function skyu(sx)
				local a = viewrad + math.atan((centerx - sx) / projx)
				return (a * D.BAM_PER_RAD / ANGLETOSKY) / w
			end
			local u1, u2 = skyu(x), skyu(x2 + 1)
			local s = -floor(u1 < u2 and u1 or u2)
			u1, u2 = u1 + s, u2 + s
			-- texture rows: 100 + (y - centery) at full height (sky is drawn at 1:1 in 200-line space)
			local v1 = (100 + (t - centery)) / h
			local v2 = (100 + (b + 1 - centery)) / h
			local sv = -floor(v1)
			v1, v2 = v1 + sv, v2 + sv
			Draw.Quad(0, x * CW, t, (x2 + 1) * CW, b + 1, tex, u1, v1, u1, v2, u2, v1, u2, v2, 1, 1, 1, 1)
			x = x2 + 1
		else
			x = x + 1
		end
	end
end

local function DrawPlanes()
	for i = 1, vp_n do
		local pl = visplanes[i]
		if pl.minx <= pl.maxx then
			if pl.picnum == R.SKYFLAT then
				DrawSky(pl)
			else
				local tex = R.FlatTex(pl.picnum)
				if tex then
					mp_tex = tex
					mp_height = abs(pl.height - viewz)
					local ln = floor(pl.lightlevel / 16) + extralight
					if ln < 0 then ln = 0 elseif ln > 15 then ln = 15 end
					mp_lights = zlight[ln]
					local top, bottom = pl.top, pl.bottom
					top[pl.maxx + 1] = UNSET
					top[pl.minx - 1] = UNSET
					markRange(pl, pl.maxx + 1)
					markRange(pl, pl.minx - 1)
					for x = pl.minx, pl.maxx + 1 do
						MakeSpans(x, top[x - 1], bottom[x - 1], top[x], bottom[x])
					end
				end
			end
		end
	end
end

------------------------------------------------------------------------ masked drawing
local clipbot, cliptop = {}, {}

local function PointOnSegSide(x, y, line)
	local lx, ly = line.v1.x, line.v1.y
	local ldx, ldy = line.v2.x - lx, line.v2.y - ly
	if ldx == 0 then
		if x <= lx then return ldy > 0 end
		return ldy < 0
	end
	if ldy == 0 then
		if y <= ly then return ldx < 0 end
		return ldx > 0
	end
	return (y - ly) * ldx >= ldy * (x - lx)
end

local function RenderMaskedSegRange(ds, x1, x2)
	local seg = ds.curline
	local fs, bs = seg.frontsector, seg.backsector
	if not bs then return end
	local name = seg.sidedef.midtexture
	name = R.texturetranslation[name] or name
	local tex = R.WallTex(name)
	if not tex then return end
	curline = seg
	local lights = scalelight[lightnumFor(fs)]
	local texturemid
	if band(seg.linedef.flags, ML_DONTPEGBOTTOM) ~= 0 then
		texturemid = (fs.floorheight > bs.floorheight and fs.floorheight or bs.floorheight) + tex.h - viewz
	else
		texturemid = (fs.ceilingheight < bs.ceilingheight and fs.ceilingheight or bs.ceilingheight) - viewz
	end
	texturemid = texturemid + seg.sidedef.rowoffset

	local mcol, moff = ds.maskedtexturecol, ds.maskoff
	local sc, soff = ds.scales, ds.scaleoff
	local tclip, toff = ds.sprtopclip, ds.sprtopoff
	local bclip, boff = ds.sprbottomclip, ds.sprbottomoff
	local w, h = tex.w, tex.h
	local used = false
	for x = x1, x2 do
		local u = mcol[moff + x]
		if u then
			local scale = sc[soff + x]
			local top = centery - texturemid * scale
			local bot = top + h * scale
			local yl = ceil(top)
			local yh = ceil(bot) - 1
			local ct = tclip[toff + x]
			local cb = bclip[boff + x]
			if yl <= ct then yl = ct + 1 end
			if yh >= cb then yh = cb - 1 end
			if yl <= yh then
				local col = floor(u) % w
				local uu = (col + 0.5) / w
				local v1 = (yl - top) / scale / h
				local v2 = (yh + 1 - top) / scale / h
				local bright = lightFromScale(lights, scale)
				local sx = x * CW
				Draw.Quad(layer, sx, yl, sx + CW, yh + 1, tex, uu, v1, uu, v2, uu, v1, uu, v2, bright, bright, bright, 1)
				used = true
			end
			mcol[moff + x] = false
		end
	end
	if used then layer = layer + 1 end
end

local function DrawVisSprite(vis)
	local tex = vis.tex
	local scale = vis.scale
	local spritetop = centery - vis.texturemid * scale
	local spritebot = spritetop + tex.h * scale
	local pw, ph = tex.pw, tex.ph
	local w = tex.w
	local xscale = vis.xscale
	local sxL = vis.sxL
	local x = vis.x1
	local x2 = vis.x2
	local r, g, b, a = vis.bright, vis.bright, vis.bright, 1
	if vis.shadow then r, g, b, a = 0.05, 0.05, 0.05, 0.5 end
	local ylTop = ceil(spritetop)
	local yhBot = ceil(spritebot) - 1
	local drew = false
	while x <= x2 do
		local ct, cb = cliptop[x], clipbot[x]
		local xe = x
		while xe + 1 <= x2 and cliptop[xe + 1] == ct and clipbot[xe + 1] == cb do xe = xe + 1 end
		local yl, yh = ylTop, yhBot
		if yl <= ct then yl = ct + 1 end
		if yh >= cb then yh = cb - 1 end
		if yl <= yh then
			local ua = (x - sxL) / xscale
			local ub = (xe + 1 - sxL) / xscale
			if vis.flip then ua, ub = w - ua, w - ub end
			if ua < 0 then ua = 0 elseif ua > w then ua = w end
			if ub < 0 then ub = 0 elseif ub > w then ub = w end
			ua, ub = ua / pw, ub / pw
			local va = (yl - spritetop) / scale / ph
			local vb = (yh + 1 - spritetop) / scale / ph
			Draw.Quad(layer, x * CW, yl, (xe + 1) * CW, yh + 1, tex, ua, va, ua, vb, ub, va, ub, vb, r, g, b, a)
			drew = true
		end
		x = xe + 1
	end
	if drew then layer = layer + 1 end
end

local function DrawSprite(spr)
	local x1, x2 = spr.x1, spr.x2
	for x = x1, x2 do clipbot[x] = -2; cliptop[x] = -2 end
	for i = ds_n, 1, -1 do
		local ds = drawsegs[i]
		if not (ds.x1 > x2 or ds.x2 < x1 or (ds.silhouette == 0 and not ds.maskedtexturecol)) then
			local r1 = ds.x1 < x1 and x1 or ds.x1
			local r2 = ds.x2 > x2 and x2 or ds.x2
			local scale, lowscale
			if ds.scale1 > ds.scale2 then
				lowscale, scale = ds.scale2, ds.scale1
			else
				lowscale, scale = ds.scale1, ds.scale2
			end
			if scale < spr.scale or (lowscale < spr.scale and not PointOnSegSide(spr.gx, spr.gy, ds.curline)) then
				if ds.maskedtexturecol then
					RenderMaskedSegRange(ds, r1, r2)
				end
			else
				local sil = ds.silhouette
				if spr.gz >= ds.bsilheight then sil = band(sil, 2) end
				if spr.gzt <= ds.tsilheight then sil = band(sil, 1) end
				if sil == 1 or sil == 3 then
					local bc, bo = ds.sprbottomclip, ds.sprbottomoff
					for x = r1, r2 do
						if clipbot[x] == -2 then clipbot[x] = bc[bo + x] end
					end
				end
				if sil == 2 or sil == 3 then
					local tc, to = ds.sprtopclip, ds.sprtopoff
					for x = r1, r2 do
						if cliptop[x] == -2 then cliptop[x] = tc[to + x] end
					end
				end
			end
		end
	end
	for x = x1, x2 do
		if clipbot[x] == -2 then clipbot[x] = RH end
		if cliptop[x] == -2 then cliptop[x] = -1 end
	end
	DrawVisSprite(spr)
end

local function spriteLess(a, b) return a.scale < b.scale end

local function DrawPlayerSprites(player)
	local mo = player.mo
	local ln = floor(mo.subsector.sector.lightlevel / 16) + extralight
	if ln < 0 then ln = 0 elseif ln > 15 then ln = 15 end
	local lights = scalelight[ln]
	local invis = player.powers and player.powers[D.pw_invisibility] or 0
	local shadow = invis > 4 * 32 or band(invis, 8) ~= 0
	for i = 0, 1 do
		local psp = player.psprites[i]
		if psp and psp.state then
			local st = psp.state
			local sprdef = D.SPRITEDEFS[st[1]]
			local sf = sprdef and sprdef[band(st[2], FF_FRAMEMASK)]
			local tex = sf and sf[2] and R.SpriteTex(sf[2])
			if tex then
				-- logical 320x200 coordinates
				local x1 = psp.sx - tex.lo
				local texturemid = 100 + 0.5 - (psp.sy - tex.to)
				local ytop = (RH / 2) - texturemid
				local bright
				if fixedbright or band(st[2], FF_FULLBRIGHT) ~= 0 then bright = 1 else bright = lights[47] end
				local r, g, b, a = bright, bright, bright, 1
				if shadow then r, g, b, a = 0.05, 0.05, 0.05, 0.5 end
				local ybot = ytop + tex.h
				local v2 = tex.h / tex.ph
				local cy2 = ybot
				if cy2 > RH then
					v2 = (RH - ytop) / tex.ph
					cy2 = RH
				end
				local u1, u2 = 0, tex.w / tex.pw
				if sf[3] then u1, u2 = u2, u1 end
				if cy2 > ytop then
					Draw.Quad(1000 + i, x1, ytop, x1 + tex.w, cy2, tex, u1, 0, u1, v2, u2, 0, u2, v2, r, g, b, a)
				end
			end
		end
	end
end

local function DrawMasked(player)
	-- sort vissprites far to near
	for i = 1, vs_n do vsorted[i] = vissprites[i] end
	for i = vs_n + 1, #vsorted do vsorted[i] = nil end
	table.sort(vsorted, spriteLess)
	for i = 1, vs_n do
		DrawSprite(vsorted[i])
	end
	for i = ds_n, 1, -1 do
		local ds = drawsegs[i]
		if ds.maskedtexturecol then
			RenderMaskedSegRange(ds, ds.x1, ds.x2)
		end
	end
	if player and player.psprites then
		DrawPlayerSprites(player)
	end
end

------------------------------------------------------------------------ entry
function R.Init()
	Draw = D.Draw
	if not RW then R.SetViewSize(320, 168) end
end

-- view = {x, y, z, angle (BAM), extralight, fixedbright, player}
function R.RenderView(vx, vy, vz, vangle, xlight, fullbright, player)
	viewx, viewy, viewz = vx, vy, vz
	viewangle = vangle
	viewrad = vangle / D.BAM_PER_RAD
	viewcos, viewsin = cos(viewrad), sin(viewrad)
	extralight = xlight or 0
	fixedbright = fullbright or false
	validcount = validcount + 1
	R.validcount = validcount

	-- clear clip segs
	ssf[1], ssl[1] = -1e9, -1
	ssf[2], ssl[2] = RW, 1e9
	ssn = 2
	for x = 0, RW - 1 do
		ceilingclip[x] = -1
		floorclip[x] = RH
	end
	lastopening = 0
	ds_n = 0
	vp_n = 0
	for k in pairs(vp_first) do vp_first[k] = nil end
	vs_n = 0
	layer = 1

	RenderBSPNode(L.numnodes - 1)
	DrawPlanes()
	DrawMasked(player)
end

function R.Stats()
	return ds_n, vp_n, vs_n
end
