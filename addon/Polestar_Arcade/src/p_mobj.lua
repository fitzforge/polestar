-- Things, thinkers, movement and collision: p_tick.c, p_mobj.c, p_maputl.c, p_map.c, p_sight.c
local D = FreedoomArcade
local P = D.P or {}
D.P = P

local floor, abs = math.floor, math.abs
local band, bor, bnot = D.band, D.bor, D.bnot
local P_Random = D.P_Random
local finesine, finecosine = D.finesine, D.finecosine
local L = D.level

local MF = D.MF
local MF_SPECIAL, MF_SOLID, MF_SHOOTABLE = MF.SPECIAL, MF.SOLID, MF.SHOOTABLE
local MF_NOSECTOR, MF_NOBLOCKMAP = MF.NOSECTOR, MF.NOBLOCKMAP
local MF_NOGRAVITY, MF_DROPOFF, MF_PICKUP, MF_NOCLIP = MF.NOGRAVITY, MF.DROPOFF, MF.PICKUP, MF.NOCLIP
local MF_FLOAT, MF_TELEPORT, MF_MISSILE, MF_DROPPED = MF.FLOAT, MF.TELEPORT, MF.MISSILE, MF.DROPPED
local MF_SHADOW, MF_NOBLOOD, MF_CORPSE, MF_INFLOAT = MF.SHADOW, MF.NOBLOOD, MF.CORPSE, MF.INFLOAT
local MF_COUNTKILL, MF_COUNTITEM, MF_SKULLFLY = MF.COUNTKILL, MF.COUNTITEM, MF.SKULLFLY
local MF_SPAWNCEILING, MF_AMBUSH = MF.SPAWNCEILING, MF.AMBUSH

local ML_BLOCKING, ML_BLOCKMONSTERS, ML_TWOSIDED = 1, 2, 4
local BOXTOP, BOXBOTTOM, BOXLEFT, BOXRIGHT = 1, 2, 3, 4
local MAXRADIUS = 32
local ANGMAX = D.ANGMAX

P.ONFLOORZ = -2147483648
P.ONCEILINGZ = 2147483647
P.GRAVITY = 1
P.MAXMOVE = 30
P.USERANGE = 64
P.MELEERANGE = 64
P.MISSILERANGE = 32 * 64
P.VIEWHEIGHT = 41
P.FLOATSPEED = 4
local STOPSPEED = 0x1000 / 65536
local FRICTION = 0xe800 / 65536
local MAXMOVE = P.MAXMOVE

P.validcount = 0
P.leveltime = 0

local states = D.states
local mobjinfo = D.mobjinfo
local MT = D.MT
local S = D.S

------------------------------------------------------------------------ thinkers
local thinkers = {}
P.thinkers = thinkers

function P.InitThinkers()
	for i = #thinkers, 1, -1 do thinkers[i] = nil end
end

function P.AddThinker(t)
	t.removed = false
	thinkers[#thinkers + 1] = t
end

function P.RemoveThinker(t)
	t.removed = true
end

function P.RunThinkers()
	local i = 1
	while i <= #thinkers do
		local t = thinkers[i]
		if not t.removed and t.think then
			t.think(t)
		end
		i = i + 1
	end
	-- compact
	local j = 0
	local n = #thinkers
	for k = 1, n do
		local t = thinkers[k]
		if not t.removed then
			j = j + 1
			thinkers[j] = t
		end
	end
	for k = j + 1, n do thinkers[k] = nil end
end

------------------------------------------------------------------------ geometry helpers
local function PointOnLineSide(x, y, line)
	local v1 = line.v1
	local ldx, ldy = line.dx, line.dy
	if ldx == 0 then
		if x <= v1.x then return ldy > 0 and 1 or 0 end
		return ldy < 0 and 1 or 0
	end
	if ldy == 0 then
		if y <= v1.y then return ldx < 0 and 1 or 0 end
		return ldx > 0 and 1 or 0
	end
	local dx, dy = x - v1.x, y - v1.y
	local left = ldy * dx
	local right = dy * ldx
	if right < left then return 0 end
	return 1
end
P.PointOnLineSide = PointOnLineSide

local function BoxOnLineSide(box, ld)
	local p1, p2
	local st = ld.slopetype
	if st == 0 then -- horizontal
		p1 = box[BOXTOP] > ld.v1.y and 1 or 0
		p2 = box[BOXBOTTOM] > ld.v1.y and 1 or 0
		if ld.dx < 0 then p1, p2 = 1 - p1, 1 - p2 end
	elseif st == 1 then -- vertical
		p1 = box[BOXRIGHT] < ld.v1.x and 1 or 0
		p2 = box[BOXLEFT] < ld.v1.x and 1 or 0
		if ld.dy < 0 then p1, p2 = 1 - p1, 1 - p2 end
	elseif st == 2 then
		p1 = PointOnLineSide(box[BOXLEFT], box[BOXTOP], ld)
		p2 = PointOnLineSide(box[BOXRIGHT], box[BOXBOTTOM], ld)
	else
		p1 = PointOnLineSide(box[BOXRIGHT], box[BOXTOP], ld)
		p2 = PointOnLineSide(box[BOXLEFT], box[BOXBOTTOM], ld)
	end
	if p1 == p2 then return p1 end
	return -1
end
P.BoxOnLineSide = BoxOnLineSide

local function PointOnDivlineSide(x, y, dl)
	if dl.dx == 0 then
		if x <= dl.x then return dl.dy > 0 and 1 or 0 end
		return dl.dy < 0 and 1 or 0
	end
	if dl.dy == 0 then
		if y <= dl.y then return dl.dx < 0 and 1 or 0 end
		return dl.dx > 0 and 1 or 0
	end
	local left = dl.dy * (x - dl.x)
	local right = (y - dl.y) * dl.dx
	if right < left then return 0 end
	return 1
end

local function InterceptVector(v2, v1)
	local den = v1.dy * v2.dx - v1.dx * v2.dy
	if den == 0 then return 0 end
	local num = (v1.x - v2.x) * v1.dy + (v2.y - v1.y) * v1.dx
	return num / den
end

-- line opening
P.opentop, P.openbottom, P.openrange, P.lowfloor = 0, 0, 0, 0
local function LineOpening(linedef)
	if linedef.sidenum[1] == -1 then
		P.openrange = 0
		return
	end
	local front, back = linedef.frontsector, linedef.backsector
	if front.ceilingheight < back.ceilingheight then
		P.opentop = front.ceilingheight
	else
		P.opentop = back.ceilingheight
	end
	if front.floorheight > back.floorheight then
		P.openbottom = front.floorheight
		P.lowfloor = back.floorheight
	else
		P.openbottom = back.floorheight
		P.lowfloor = front.floorheight
	end
	P.openrange = P.opentop - P.openbottom
end
P.LineOpening = LineOpening

------------------------------------------------------------------------ blockmap links
local function UnsetThingPosition(thing)
	if band(thing.flags, MF_NOSECTOR) == 0 then
		if thing.snext then thing.snext.sprev = thing.sprev end
		if thing.sprev then
			thing.sprev.snext = thing.snext
		else
			thing.subsector.sector.thinglist = thing.snext
		end
		thing.snext, thing.sprev = nil, nil
	end
	if band(thing.flags, MF_NOBLOCKMAP) == 0 then
		if thing.bnext then thing.bnext.bprev = thing.bprev end
		if thing.bprev then
			thing.bprev.bnext = thing.bnext
		else
			local bx = floor((thing.x - L.bmaporgx) / 128)
			local by = floor((thing.y - L.bmaporgy) / 128)
			if bx >= 0 and bx < L.bmapwidth and by >= 0 and by < L.bmapheight then
				local idx = by * L.bmapwidth + bx
				if L.blocklinks[idx] == thing then
					L.blocklinks[idx] = thing.bnext or false
				end
			end
		end
		thing.bnext, thing.bprev = nil, nil
	end
end
P.UnsetThingPosition = UnsetThingPosition

local function SetThingPosition(thing)
	local ss = D.PointInSubsector(thing.x, thing.y)
	thing.subsector = ss
	if band(thing.flags, MF_NOSECTOR) == 0 then
		local sec = ss.sector
		thing.sprev = nil
		thing.snext = sec.thinglist
		if sec.thinglist then sec.thinglist.sprev = thing end
		sec.thinglist = thing
	end
	if band(thing.flags, MF_NOBLOCKMAP) == 0 then
		local bx = floor((thing.x - L.bmaporgx) / 128)
		local by = floor((thing.y - L.bmaporgy) / 128)
		if bx >= 0 and bx < L.bmapwidth and by >= 0 and by < L.bmapheight then
			local idx = by * L.bmapwidth + bx
			local head = L.blocklinks[idx]
			thing.bprev = nil
			thing.bnext = head or nil
			if head then head.bprev = thing end
			L.blocklinks[idx] = thing
		else
			thing.bnext, thing.bprev = nil, nil
		end
	end
end
P.SetThingPosition = SetThingPosition

local function BlockLinesIterator(x, y, func)
	if x < 0 or y < 0 or x >= L.bmapwidth or y >= L.bmapheight then return true end
	local bml = L.blockmaplump
	local offset = bml[4 + y * L.bmapwidth + x]
	local lines = L.lines
	local vc = P.validcount
	local i = offset
	while true do
		local ln = bml[i]
		if ln == -1 then break end
		local ld = lines[ln]
		if ld and ld.validcount ~= vc then
			ld.validcount = vc
			if not func(ld) then return false end
		end
		i = i + 1
	end
	return true
end
P.BlockLinesIterator = BlockLinesIterator

local function BlockThingsIterator(x, y, func)
	if x < 0 or y < 0 or x >= L.bmapwidth or y >= L.bmapheight then return true end
	local mobj = L.blocklinks[y * L.bmapwidth + x]
	while mobj do
		local nxt = mobj.bnext
		if not func(mobj) then return false end
		mobj = nxt
	end
	return true
end
P.BlockThingsIterator = BlockThingsIterator

------------------------------------------------------------------------ intercepts / path traverse
local intercepts = {}
local numintercepts = 0
local trace = { x = 0, y = 0, dx = 0, dy = 0 }
P.trace = trace
local earlyout = false

local function newIntercept(frac, line, thing)
	numintercepts = numintercepts + 1
	local ic = intercepts[numintercepts]
	if not ic then ic = {}; intercepts[numintercepts] = ic end
	ic.frac = frac
	ic.isaline = line ~= nil
	ic.line = line
	ic.thing = thing
end

local dl_tmp = { x = 0, y = 0, dx = 0, dy = 0 }
local function AddLineIntercepts(ld)
	local s1, s2
	if trace.dx > 16 or trace.dy > 16 or trace.dx < -16 or trace.dy < -16 then
		s1 = PointOnDivlineSide(ld.v1.x, ld.v1.y, trace)
		s2 = PointOnDivlineSide(ld.v2.x, ld.v2.y, trace)
	else
		s1 = PointOnLineSide(trace.x, trace.y, ld)
		s2 = PointOnLineSide(trace.x + trace.dx, trace.y + trace.dy, ld)
	end
	if s1 == s2 then return true end
	dl_tmp.x, dl_tmp.y, dl_tmp.dx, dl_tmp.dy = ld.v1.x, ld.v1.y, ld.dx, ld.dy
	local frac = InterceptVector(trace, dl_tmp)
	if frac < 0 then return true end
	if earlyout and frac < 1 and not ld.backsector then
		return false
	end
	newIntercept(frac, ld, nil)
	return true
end

local function AddThingIntercepts(thing)
	-- C: (trace.dx ^ trace.dy) > 0
	local tracepositive = (trace.dx < 0) == (trace.dy < 0) and trace.dx ~= trace.dy
	local r = thing.radius
	local x1, y1, x2, y2
	if tracepositive then
		x1, y1, x2, y2 = thing.x - r, thing.y + r, thing.x + r, thing.y - r
	else
		x1, y1, x2, y2 = thing.x - r, thing.y - r, thing.x + r, thing.y + r
	end
	local s1 = PointOnDivlineSide(x1, y1, trace)
	local s2 = PointOnDivlineSide(x2, y2, trace)
	if s1 == s2 then return true end
	dl_tmp.x, dl_tmp.y, dl_tmp.dx, dl_tmp.dy = x1, y1, x2 - x1, y2 - y1
	local frac = InterceptVector(trace, dl_tmp)
	if frac < 0 then return true end
	newIntercept(frac, nil, thing)
	return true
end

local function TraverseIntercepts(func, maxfrac)
	local count = numintercepts
	while count > 0 do
		count = count - 1
		local dist = 1e30
		local best
		for i = 1, numintercepts do
			local ic = intercepts[i]
			if ic.frac < dist then
				dist = ic.frac
				best = ic
			end
		end
		if dist > maxfrac then return true end
		if not func(best) then return false end
		best.frac = 1e30
	end
	return true
end

P.PT_ADDLINES, P.PT_ADDTHINGS, P.PT_EARLYOUT = 1, 2, 4

function P.PathTraverse(x1, y1, x2, y2, flags, trav)
	earlyout = band(flags, 4) ~= 0
	P.validcount = P.validcount + 1
	numintercepts = 0
	local orgx, orgy = L.bmaporgx, L.bmaporgy
	if (x1 - orgx) % 128 == 0 then x1 = x1 + 1 end
	if (y1 - orgy) % 128 == 0 then y1 = y1 + 1 end
	trace.x, trace.y = x1, y1
	trace.dx, trace.dy = x2 - x1, y2 - y1

	local bx1, by1 = (x1 - orgx) / 128, (y1 - orgy) / 128
	local bx2, by2 = (x2 - orgx) / 128, (y2 - orgy) / 128
	local xt1, yt1 = floor(bx1), floor(by1)
	local xt2, yt2 = floor(bx2), floor(by2)

	local mapxstep, mapystep, partial, xstep, ystep
	if xt2 > xt1 then
		mapxstep = 1
		partial = 1 - (bx1 - xt1)
		ystep = (by2 - by1) / abs(bx2 - bx1)
	elseif xt2 < xt1 then
		mapxstep = -1
		partial = bx1 - xt1
		ystep = (by2 - by1) / abs(bx2 - bx1)
	else
		mapxstep = 0
		partial = 1
		ystep = 256
	end
	local yintercept = by1 + partial * ystep

	if yt2 > yt1 then
		mapystep = 1
		partial = 1 - (by1 - yt1)
		xstep = (bx2 - bx1) / abs(by2 - by1)
	elseif yt2 < yt1 then
		mapystep = -1
		partial = by1 - yt1
		xstep = (bx2 - bx1) / abs(by2 - by1)
	else
		mapystep = 0
		partial = 1
		xstep = 256
	end
	local xintercept = bx1 + partial * xstep

	local mapx, mapy = xt1, yt1
	local addlines, addthings = band(flags, 1) ~= 0, band(flags, 2) ~= 0
	for _ = 0, 63 do
		if addlines then
			if not BlockLinesIterator(mapx, mapy, AddLineIntercepts) then return false end
		end
		if addthings then
			if not BlockThingsIterator(mapx, mapy, AddThingIntercepts) then return false end
		end
		if mapx == xt2 and mapy == yt2 then break end
		if floor(yintercept) == mapy then
			yintercept = yintercept + ystep
			mapx = mapx + mapxstep
		elseif floor(xintercept) == mapx then
			xintercept = xintercept + xstep
			mapy = mapy + mapystep
		else
			-- float rounding: step along the major axis
			if abs(bx2 - bx1) > abs(by2 - by1) then
				mapx = mapx + mapxstep
			else
				mapy = mapy + mapystep
			end
		end
	end
	return TraverseIntercepts(trav, 1)
end

------------------------------------------------------------------------ mobj states
local actions = D.actions or {}
D.actions = actions

local RemoveMobj

local function SetMobjState(mobj, state)
	repeat
		if state == 0 then
			mobj.state = nil
			mobj.statenum = 0
			RemoveMobj(mobj)
			return false
		end
		local st = states[state]
		mobj.state = st
		mobj.statenum = state
		mobj.tics = st[3]
		mobj.sprite = st[1]
		mobj.frame = st[2]
		local act = st[4]
		if act then
			local fn = actions[act]
			if fn then fn(mobj) end
		end
		state = st[5]
	until mobj.tics ~= 0
	return true
end
P.SetMobjState = SetMobjState

local function S_StartSound(origin, sfx)
	if D.S_StartSound then D.S_StartSound(origin, sfx) end
end

local function ExplodeMissile(mo)
	mo.momx, mo.momy, mo.momz = 0, 0, 0
	SetMobjState(mo, mobjinfo[mo.type].deathstate)
	mo.tics = mo.tics - band(P_Random(), 3)
	if mo.tics < 1 then mo.tics = 1 end
	mo.flags = band(mo.flags, bnot(MF_MISSILE))
	if mo.info.deathsound ~= 0 then
		S_StartSound(mo, mo.info.deathsound)
	end
end
P.ExplodeMissile = ExplodeMissile

------------------------------------------------------------------------ P_CheckPosition etc
local tmbbox = { 0, 0, 0, 0 }
local tmthing, tmflags, tmx, tmy
P.floatok = false
P.tmfloorz, P.tmceilingz, P.tmdropoffz = 0, 0, 0
P.ceilingline = nil
local spechit = {}
local numspechit = 0

local function PIT_CheckLine(ld)
	local bb = ld.bbox
	if tmbbox[BOXRIGHT] <= bb[BOXLEFT] or tmbbox[BOXLEFT] >= bb[BOXRIGHT]
		or tmbbox[BOXTOP] <= bb[BOXBOTTOM] or tmbbox[BOXBOTTOM] >= bb[BOXTOP] then
		return true
	end
	if BoxOnLineSide(tmbbox, ld) ~= -1 then return true end
	if not ld.backsector then return false end
	if band(tmthing.flags, MF_MISSILE) == 0 then
		if band(ld.flags, ML_BLOCKING) ~= 0 then return false end
		if not tmthing.player and band(ld.flags, ML_BLOCKMONSTERS) ~= 0 then return false end
	end
	LineOpening(ld)
	if P.opentop < P.tmceilingz then
		P.tmceilingz = P.opentop
		P.ceilingline = ld
	end
	if P.openbottom > P.tmfloorz then P.tmfloorz = P.openbottom end
	if P.lowfloor < P.tmdropoffz then P.tmdropoffz = P.lowfloor end
	if ld.special ~= 0 then
		numspechit = numspechit + 1
		spechit[numspechit] = ld
	end
	return true
end

local function PIT_CheckThing(thing)
	if band(thing.flags, MF_SOLID + MF_SPECIAL + MF_SHOOTABLE) == 0 then return true end
	local blockdist = thing.radius + tmthing.radius
	if abs(thing.x - tmx) >= blockdist or abs(thing.y - tmy) >= blockdist then return true end
	if thing == tmthing then return true end
	if band(tmthing.flags, MF_SKULLFLY) ~= 0 then
		local damage = ((P_Random() % 8) + 1) * tmthing.info.damage
		P.DamageMobj(thing, tmthing, tmthing, damage)
		tmthing.flags = band(tmthing.flags, bnot(MF_SKULLFLY))
		tmthing.momx, tmthing.momy, tmthing.momz = 0, 0, 0
		SetMobjState(tmthing, tmthing.info.spawnstate)
		return false
	end
	if band(tmthing.flags, MF_MISSILE) ~= 0 then
		if tmthing.z > thing.z + thing.height then return true end
		if tmthing.z + tmthing.height < thing.z then return true end
		local tgt = tmthing.target
		if tgt and (tgt.type == thing.type
			or (tgt.type == MT.MT_KNIGHT and thing.type == MT.MT_BRUISER)
			or (tgt.type == MT.MT_BRUISER and thing.type == MT.MT_KNIGHT)) then
			if thing == tgt then return true end
			if thing.type ~= MT.MT_PLAYER then return false end
		end
		if band(thing.flags, MF_SHOOTABLE) == 0 then
			return band(thing.flags, MF_SOLID) == 0
		end
		local damage = ((P_Random() % 8) + 1) * tmthing.info.damage
		P.DamageMobj(thing, tmthing, tmthing.target, damage)
		return false
	end
	if band(thing.flags, MF_SPECIAL) ~= 0 then
		local solid = band(thing.flags, MF_SOLID) ~= 0
		if band(tmflags, MF_PICKUP) ~= 0 then
			P.TouchSpecialThing(thing, tmthing)
		end
		return not solid
	end
	return band(thing.flags, MF_SOLID) == 0
end

local function setupTm(thing, x, y)
	tmthing = thing
	tmflags = thing.flags
	tmx, tmy = x, y
	local r = thing.radius
	tmbbox[BOXTOP] = y + r
	tmbbox[BOXBOTTOM] = y - r
	tmbbox[BOXRIGHT] = x + r
	tmbbox[BOXLEFT] = x - r
	local newsubsec = D.PointInSubsector(x, y)
	P.ceilingline = nil
	P.tmfloorz = newsubsec.sector.floorheight
	P.tmdropoffz = P.tmfloorz
	P.tmceilingz = newsubsec.sector.ceilingheight
	P.validcount = P.validcount + 1
	numspechit = 0
end

local function CheckPosition(thing, x, y)
	setupTm(thing, x, y)
	if band(tmflags, MF_NOCLIP) ~= 0 then return true end
	local orgx, orgy = L.bmaporgx, L.bmaporgy
	local xl = floor((tmbbox[BOXLEFT] - orgx - MAXRADIUS) / 128)
	local xh = floor((tmbbox[BOXRIGHT] - orgx + MAXRADIUS) / 128)
	local yl = floor((tmbbox[BOXBOTTOM] - orgy - MAXRADIUS) / 128)
	local yh = floor((tmbbox[BOXTOP] - orgy + MAXRADIUS) / 128)
	for bx = xl, xh do
		for by = yl, yh do
			if not BlockThingsIterator(bx, by, PIT_CheckThing) then return false end
		end
	end
	xl = floor((tmbbox[BOXLEFT] - orgx) / 128)
	xh = floor((tmbbox[BOXRIGHT] - orgx) / 128)
	yl = floor((tmbbox[BOXBOTTOM] - orgy) / 128)
	yh = floor((tmbbox[BOXTOP] - orgy) / 128)
	for bx = xl, xh do
		for by = yl, yh do
			if not BlockLinesIterator(bx, by, PIT_CheckLine) then return false end
		end
	end
	return true
end
P.CheckPosition = CheckPosition

local function PIT_StompThing(thing)
	if band(thing.flags, MF_SHOOTABLE) == 0 then return true end
	local blockdist = thing.radius + tmthing.radius
	if abs(thing.x - tmx) >= blockdist or abs(thing.y - tmy) >= blockdist then return true end
	if thing == tmthing then return true end
	if not tmthing.player and D.G.gamemap ~= 30 then return false end
	P.DamageMobj(thing, tmthing, tmthing, 10000)
	return true
end

function P.TeleportMove(thing, x, y)
	setupTm(thing, x, y)
	local orgx, orgy = L.bmaporgx, L.bmaporgy
	local xl = floor((tmbbox[BOXLEFT] - orgx - MAXRADIUS) / 128)
	local xh = floor((tmbbox[BOXRIGHT] - orgx + MAXRADIUS) / 128)
	local yl = floor((tmbbox[BOXBOTTOM] - orgy - MAXRADIUS) / 128)
	local yh = floor((tmbbox[BOXTOP] - orgy + MAXRADIUS) / 128)
	for bx = xl, xh do
		for by = yl, yh do
			if not BlockThingsIterator(bx, by, PIT_StompThing) then return false end
		end
	end
	UnsetThingPosition(thing)
	thing.floorz = P.tmfloorz
	thing.ceilingz = P.tmceilingz
	thing.x, thing.y = x, y
	SetThingPosition(thing)
	return true
end

local function TryMove(thing, x, y)
	P.floatok = false
	if not CheckPosition(thing, x, y) then return false end
	if band(thing.flags, MF_NOCLIP) == 0 then
		if P.tmceilingz - P.tmfloorz < thing.height then return false end
		P.floatok = true
		if band(thing.flags, MF_TELEPORT) == 0 and P.tmceilingz - thing.z < thing.height then return false end
		if band(thing.flags, MF_TELEPORT) == 0 and P.tmfloorz - thing.z > 24 then return false end
		if band(thing.flags, MF_DROPOFF + MF_FLOAT) == 0 and P.tmfloorz - P.tmdropoffz > 24 then return false end
	end
	UnsetThingPosition(thing)
	local oldx, oldy = thing.x, thing.y
	thing.floorz = P.tmfloorz
	thing.ceilingz = P.tmceilingz
	thing.x, thing.y = x, y
	SetThingPosition(thing)
	if band(thing.flags, MF_TELEPORT + MF_NOCLIP) == 0 then
		while numspechit > 0 do
			local ld = spechit[numspechit]
			numspechit = numspechit - 1
			local side = PointOnLineSide(thing.x, thing.y, ld)
			local oldside = PointOnLineSide(oldx, oldy, ld)
			if side ~= oldside and ld.special ~= 0 then
				P.CrossSpecialLine(ld, oldside, thing)
			end
		end
	end
	return true
end
P.TryMove = TryMove

local function ThingHeightClip(thing)
	local onfloor = thing.z == thing.floorz
	CheckPosition(thing, thing.x, thing.y)
	thing.floorz = P.tmfloorz
	thing.ceilingz = P.tmceilingz
	if onfloor then
		thing.z = thing.floorz
	else
		if thing.z + thing.height > thing.ceilingz then
			thing.z = thing.ceilingz - thing.height
		end
	end
	if thing.ceilingz - thing.floorz < thing.height then return false end
	return true
end

------------------------------------------------------------------------ sliding
local bestslidefrac, secondslidefrac
local bestslideline, secondslideline
local slidemo
local tmxmove, tmymove

local function HitSlideLine(ld)
	if ld.slopetype == 0 then tmymove = 0 return end
	if ld.slopetype == 1 then tmxmove = 0 return end
	local side = PointOnLineSide(slidemo.x, slidemo.y, ld)
	local lineangle = D.PointToAngle2(0, 0, ld.dx, ld.dy)
	if side == 1 then lineangle = (lineangle + D.ANG180) % ANGMAX end
	local moveangle = D.PointToAngle2(0, 0, tmxmove, tmymove)
	local deltaangle = (moveangle - lineangle) % ANGMAX
	if deltaangle > D.ANG180 then deltaangle = (deltaangle + D.ANG180) % ANGMAX end
	local la = floor(lineangle / 524288)
	local da = floor(deltaangle / 524288)
	local movelen = D.AproxDistance(tmxmove, tmymove)
	local newlen = movelen * finecosine[da]
	tmxmove = newlen * finecosine[la]
	tmymove = newlen * finesine[la]
end

local function PTR_SlideTraverse(ic)
	local li = ic.line
	local blocking = false
	if band(li.flags, ML_TWOSIDED) == 0 then
		if PointOnLineSide(slidemo.x, slidemo.y, li) == 1 then
			return true
		end
		blocking = true
	else
		LineOpening(li)
		if P.openrange < slidemo.height then blocking = true
		elseif P.opentop - slidemo.z < slidemo.height then blocking = true
		elseif P.openbottom - slidemo.z > 24 then blocking = true end
	end
	if not blocking then return true end
	if ic.frac < bestslidefrac then
		secondslidefrac = bestslidefrac
		secondslideline = bestslideline
		bestslidefrac = ic.frac
		bestslideline = li
	end
	return false
end

local function SlideMove(mo)
	slidemo = mo
	local hitcount = 0
	while true do
		hitcount = hitcount + 1
		if hitcount == 3 then
			if not TryMove(mo, mo.x, mo.y + mo.momy) then TryMove(mo, mo.x + mo.momx, mo.y) end
			return
		end
		local leadx, trailx, leady, traily
		if mo.momx > 0 then
			leadx, trailx = mo.x + mo.radius, mo.x - mo.radius
		else
			leadx, trailx = mo.x - mo.radius, mo.x + mo.radius
		end
		if mo.momy > 0 then
			leady, traily = mo.y + mo.radius, mo.y - mo.radius
		else
			leady, traily = mo.y - mo.radius, mo.y + mo.radius
		end
		bestslidefrac = 1 + 1 / 65536
		P.PathTraverse(leadx, leady, leadx + mo.momx, leady + mo.momy, 1, PTR_SlideTraverse)
		P.PathTraverse(trailx, leady, trailx + mo.momx, leady + mo.momy, 1, PTR_SlideTraverse)
		P.PathTraverse(leadx, traily, leadx + mo.momx, traily + mo.momy, 1, PTR_SlideTraverse)
		if bestslidefrac == 1 + 1 / 65536 then
			if not TryMove(mo, mo.x, mo.y + mo.momy) then TryMove(mo, mo.x + mo.momx, mo.y) end
			return
		end
		bestslidefrac = bestslidefrac - 0x800 / 65536
		if bestslidefrac > 0 then
			local newx = mo.momx * bestslidefrac
			local newy = mo.momy * bestslidefrac
			if not TryMove(mo, mo.x + newx, mo.y + newy) then
				if not TryMove(mo, mo.x, mo.y + mo.momy) then TryMove(mo, mo.x + mo.momx, mo.y) end
				return
			end
		end
		bestslidefrac = 1 - (bestslidefrac + 0x800 / 65536)
		if bestslidefrac > 1 then bestslidefrac = 1 end
		if bestslidefrac <= 0 then return end
		tmxmove = mo.momx * bestslidefrac
		tmymove = mo.momy * bestslidefrac
		HitSlideLine(bestslideline)
		mo.momx, mo.momy = tmxmove, tmymove
		if TryMove(mo, mo.x + tmxmove, mo.y + tmymove) then return end
	end
end
P.SlideMove = SlideMove

------------------------------------------------------------------------ attacks
P.linetarget = nil
local shootthing, shootz, la_damage, attackrange, aimslope
local topslope, bottomslope

local function PTR_AimTraverse(ic)
	if ic.isaline then
		local li = ic.line
		if band(li.flags, ML_TWOSIDED) == 0 then return false end
		LineOpening(li)
		if P.openbottom >= P.opentop then return false end
		local dist = attackrange * ic.frac
		if li.frontsector.floorheight ~= li.backsector.floorheight then
			local slope = (P.openbottom - shootz) / dist
			if slope > bottomslope then bottomslope = slope end
		end
		if li.frontsector.ceilingheight ~= li.backsector.ceilingheight then
			local slope = (P.opentop - shootz) / dist
			if slope < topslope then topslope = slope end
		end
		if topslope <= bottomslope then return false end
		return true
	end
	local th = ic.thing
	if th == shootthing then return true end
	if band(th.flags, MF_SHOOTABLE) == 0 then return true end
	local dist = attackrange * ic.frac
	local thingtopslope = (th.z + th.height - shootz) / dist
	if thingtopslope < bottomslope then return true end
	local thingbottomslope = (th.z - shootz) / dist
	if thingbottomslope > topslope then return true end
	if thingtopslope > topslope then thingtopslope = topslope end
	if thingbottomslope < bottomslope then thingbottomslope = bottomslope end
	aimslope = (thingtopslope + thingbottomslope) / 2
	P.linetarget = th
	return false
end

local function PTR_ShootTraverse(ic)
	if ic.isaline then
		local li = ic.line
		if li.special ~= 0 then P.ShootSpecialLine(shootthing, li) end
		local hit = false
		if band(li.flags, ML_TWOSIDED) == 0 then
			hit = true
		else
			LineOpening(li)
			local dist = attackrange * ic.frac
			if li.frontsector.floorheight ~= li.backsector.floorheight then
				if (P.openbottom - shootz) / dist > aimslope then hit = true end
			end
			if not hit and li.frontsector.ceilingheight ~= li.backsector.ceilingheight then
				if (P.opentop - shootz) / dist < aimslope then hit = true end
			end
			if not hit then return true end
		end
		local frac = ic.frac - 4 / attackrange
		local x = trace.x + trace.dx * frac
		local y = trace.y + trace.dy * frac
		local z = shootz + aimslope * (frac * attackrange)
		if li.frontsector.ceilingpic == D.R.SKYFLAT then
			if z > li.frontsector.ceilingheight then return false end
			if li.backsector and li.backsector.ceilingpic == D.R.SKYFLAT then return false end
		end
		P.SpawnPuff(x, y, z)
		return false
	end
	local th = ic.thing
	if th == shootthing then return true end
	if band(th.flags, MF_SHOOTABLE) == 0 then return true end
	local dist = attackrange * ic.frac
	local thingtopslope = (th.z + th.height - shootz) / dist
	if thingtopslope < aimslope then return true end
	local thingbottomslope = (th.z - shootz) / dist
	if thingbottomslope > aimslope then return true end
	local frac = ic.frac - 10 / attackrange
	local x = trace.x + trace.dx * frac
	local y = trace.y + trace.dy * frac
	local z = shootz + aimslope * (frac * attackrange)
	if band(th.flags, MF_NOBLOOD) ~= 0 then
		P.SpawnPuff(x, y, z)
	else
		P.SpawnBlood(x, y, z, la_damage)
	end
	if la_damage ~= 0 then
		P.DamageMobj(th, shootthing, shootthing, la_damage)
	end
	return false
end

function P.AimLineAttack(t1, angle, distance)
	local an = floor((angle % ANGMAX) / 524288)
	shootthing = t1
	local x2 = t1.x + distance * finecosine[an]
	local y2 = t1.y + distance * finesine[an]
	shootz = t1.z + t1.height / 2 + 8
	topslope = 100 / 160
	bottomslope = -100 / 160
	attackrange = distance
	P.linetarget = nil
	P.PathTraverse(t1.x, t1.y, x2, y2, 3, PTR_AimTraverse)
	if P.linetarget then return aimslope end
	return 0
end

function P.LineAttack(t1, angle, distance, slope, damage)
	local an = floor((angle % ANGMAX) / 524288)
	shootthing = t1
	la_damage = damage
	local x2 = t1.x + distance * finecosine[an]
	local y2 = t1.y + distance * finesine[an]
	shootz = t1.z + t1.height / 2 + 8
	attackrange = distance
	aimslope = slope
	P.attackrange = distance
	P.PathTraverse(t1.x, t1.y, x2, y2, 3, PTR_ShootTraverse)
end

local usething
local function PTR_UseTraverse(ic)
	local line = ic.line
	if line.special == 0 then
		LineOpening(line)
		if P.openrange <= 0 then
			S_StartSound(usething, D.SFX.noway)
			return false
		end
		return true
	end
	local side = 0
	if PointOnLineSide(usething.x, usething.y, line) == 1 then side = 1 end
	P.UseSpecialLine(usething, line, side)
	return false
end

function P.UseLines(player)
	usething = player.mo
	local an = floor(player.mo.angle / 524288)
	local x1, y1 = player.mo.x, player.mo.y
	local x2 = x1 + P.USERANGE * finecosine[an]
	local y2 = y1 + P.USERANGE * finesine[an]
	P.PathTraverse(x1, y1, x2, y2, 1, PTR_UseTraverse)
end

local bombsource, bombspot, bombdamage
local function PIT_RadiusAttack(thing)
	if band(thing.flags, MF_SHOOTABLE) == 0 then return true end
	if thing.type == MT.MT_CYBORG or thing.type == MT.MT_SPIDER then return true end
	local dx = abs(thing.x - bombspot.x)
	local dy = abs(thing.y - bombspot.y)
	local dist = dx > dy and dx or dy
	dist = floor(dist - thing.radius)
	if dist < 0 then dist = 0 end
	if dist >= bombdamage then return true end
	if P.CheckSight(thing, bombspot) then
		P.DamageMobj(thing, bombspot, bombsource, bombdamage - dist)
	end
	return true
end

function P.RadiusAttack(spot, source, damage)
	local dist = damage + MAXRADIUS
	local yh = floor((spot.y + dist - L.bmaporgy) / 128)
	local yl = floor((spot.y - dist - L.bmaporgy) / 128)
	local xh = floor((spot.x + dist - L.bmaporgx) / 128)
	local xl = floor((spot.x - dist - L.bmaporgx) / 128)
	bombspot, bombsource, bombdamage = spot, source, damage
	for y = yl, yh do
		for x = xl, xh do
			BlockThingsIterator(x, y, PIT_RadiusAttack)
		end
	end
end

local crushchange, nofit
local function PIT_ChangeSector(thing)
	if ThingHeightClip(thing) then return true end
	if thing.health <= 0 then
		SetMobjState(thing, S.S_GIBS)
		thing.flags = band(thing.flags, bnot(MF_SOLID))
		thing.height = 0
		thing.radius = 0
		return true
	end
	if band(thing.flags, MF_DROPPED) ~= 0 then
		RemoveMobj(thing)
		return true
	end
	if band(thing.flags, MF_SHOOTABLE) == 0 then return true end
	nofit = true
	if crushchange and band(P.leveltime, 3) == 0 then
		P.DamageMobj(thing, nil, nil, 10)
		local mo = P.SpawnMobj(thing.x, thing.y, thing.z + thing.height / 2, MT.MT_BLOOD)
		mo.momx = (P_Random() - P_Random()) / 16
		mo.momy = (P_Random() - P_Random()) / 16
	end
	return true
end

function P.ChangeSector(sector, crunch)
	nofit = false
	crushchange = crunch
	local bb = sector.blockbox
	for x = bb[BOXLEFT], bb[BOXRIGHT] do
		for y = bb[BOXBOTTOM], bb[BOXTOP] do
			BlockThingsIterator(x, y, PIT_ChangeSector)
		end
	end
	return nofit
end

------------------------------------------------------------------------ sight
local sightzstart, s_topslope, s_bottomslope
local strace = { x = 0, y = 0, dx = 0, dy = 0 }
local t2x, t2y

local function DivlineSide(x, y, node)
	if node.dx == 0 then
		if x == node.x then return 2 end
		if x <= node.x then return node.dy > 0 and 1 or 0 end
		return node.dy < 0 and 1 or 0
	end
	if node.dy == 0 then
		if y == node.y then return 2 end
		if y <= node.y then return node.dx < 0 and 1 or 0 end
		return node.dx > 0 and 1 or 0
	end
	local left = node.dy * (x - node.x)
	local right = (y - node.y) * node.dx
	if right < left then return 0 end
	if left == right then return 2 end
	return 1
end

local divl = { x = 0, y = 0, dx = 0, dy = 0 }
local function CrossSubsector(num)
	local sub = L.subsectors[num]
	local segs = L.segs
	local vc = P.validcount
	for i = sub.firstline, sub.firstline + sub.numlines - 1 do
		local seg = segs[i]
		local line = seg.linedef
		if line.validcount ~= vc then
			line.validcount = vc
			local v1, v2 = line.v1, line.v2
			local s1 = DivlineSide(v1.x, v1.y, strace)
			local s2 = DivlineSide(v2.x, v2.y, strace)
			if s1 ~= s2 then
				divl.x, divl.y, divl.dx, divl.dy = v1.x, v1.y, v2.x - v1.x, v2.y - v1.y
				s1 = DivlineSide(strace.x, strace.y, divl)
				s2 = DivlineSide(t2x, t2y, divl)
				if s1 ~= s2 then
					if band(line.flags, ML_TWOSIDED) == 0 then return false end
					local front, back = seg.frontsector, seg.backsector
					if not back then return false end
					if not (front.floorheight == back.floorheight and front.ceilingheight == back.ceilingheight) then
						local opentop = front.ceilingheight < back.ceilingheight and front.ceilingheight or back.ceilingheight
						local openbottom = front.floorheight > back.floorheight and front.floorheight or back.floorheight
						if openbottom >= opentop then return false end
						local frac = InterceptVector(strace, divl)
						if frac > 0 then
							if front.floorheight ~= back.floorheight then
								local slope = (openbottom - sightzstart) / frac
								if slope > s_bottomslope then s_bottomslope = slope end
							end
							if front.ceilingheight ~= back.ceilingheight then
								local slope = (opentop - sightzstart) / frac
								if slope < s_topslope then s_topslope = slope end
							end
							if s_topslope <= s_bottomslope then return false end
						end
					end
				end
			end
		end
	end
	return true
end

local function CrossBSPNode(bspnum)
	if bspnum >= 32768 then
		if bspnum == 65535 then return CrossSubsector(0) end
		return CrossSubsector(bspnum - 32768)
	end
	local bsp = L.nodes[bspnum]
	local side = DivlineSide(strace.x, strace.y, bsp)
	if side == 2 then side = 0 end
	if not CrossBSPNode(bsp.children[side]) then return false end
	if side == DivlineSide(t2x, t2y, bsp) then return true end
	return CrossBSPNode(bsp.children[1 - side])
end

function P.CheckSight(t1, t2)
	local s1 = t1.subsector.sector.id
	local s2 = t2.subsector.sector.id
	local pnum = s1 * L.numsectors + s2
	local bytenum = floor(pnum / 8)
	local bitnum = pnum % 8
	local rm = L.rejectmatrix
	if bytenum < #rm then
		local b = rm:byte(bytenum + 1)
		if floor(b / 2 ^ bitnum) % 2 == 1 then return false end
	end
	P.validcount = P.validcount + 1
	sightzstart = t1.z + t1.height - t1.height / 4
	s_topslope = (t2.z + t2.height) - sightzstart
	s_bottomslope = t2.z - sightzstart
	strace.x, strace.y = t1.x, t1.y
	t2x, t2y = t2.x, t2.y
	strace.dx, strace.dy = t2.x - t1.x, t2.y - t1.y
	return CrossBSPNode(L.numnodes - 1)
end

------------------------------------------------------------------------ mobj movement
local function XYMovement(mo)
	if mo.momx == 0 and mo.momy == 0 then
		if band(mo.flags, MF_SKULLFLY) ~= 0 then
			mo.flags = band(mo.flags, bnot(MF_SKULLFLY))
			mo.momx, mo.momy, mo.momz = 0, 0, 0
			SetMobjState(mo, mo.info.spawnstate)
		end
		return
	end
	local player = mo.player
	if mo.momx > MAXMOVE then mo.momx = MAXMOVE elseif mo.momx < -MAXMOVE then mo.momx = -MAXMOVE end
	if mo.momy > MAXMOVE then mo.momy = MAXMOVE elseif mo.momy < -MAXMOVE then mo.momy = -MAXMOVE end
	local xmove, ymove = mo.momx, mo.momy
	repeat
		local ptryx, ptryy
		if xmove > MAXMOVE / 2 or ymove > MAXMOVE / 2 then
			ptryx = mo.x + xmove / 2
			ptryy = mo.y + ymove / 2
			xmove, ymove = xmove / 2, ymove / 2
		else
			ptryx = mo.x + xmove
			ptryy = mo.y + ymove
			xmove, ymove = 0, 0
		end
		if not TryMove(mo, ptryx, ptryy) then
			if mo.player then
				SlideMove(mo)
			elseif band(mo.flags, MF_MISSILE) ~= 0 then
				local cl = P.ceilingline
				if cl and cl.backsector and cl.backsector.ceilingpic == D.R.SKYFLAT then
					RemoveMobj(mo)
					return
				end
				ExplodeMissile(mo)
			else
				mo.momx, mo.momy = 0, 0
			end
		end
	until xmove == 0 and ymove == 0

	if player and band(player.cheats, 4) ~= 0 then
		mo.momx, mo.momy = 0, 0
		return
	end
	if band(mo.flags, MF_MISSILE + MF_SKULLFLY) ~= 0 then return end
	if mo.z > mo.floorz then return end
	if band(mo.flags, MF_CORPSE) ~= 0 then
		if mo.momx > 0.25 or mo.momx < -0.25 or mo.momy > 0.25 or mo.momy < -0.25 then
			if mo.floorz ~= mo.subsector.sector.floorheight then return end
		end
	end
	if mo.momx > -STOPSPEED and mo.momx < STOPSPEED and mo.momy > -STOPSPEED and mo.momy < STOPSPEED
		and (not player or (player.cmd.forwardmove == 0 and player.cmd.sidemove == 0)) then
		if player then
			local sn = player.mo.statenum - S.S_PLAY_RUN1
			if sn >= 0 and sn < 4 then SetMobjState(player.mo, S.S_PLAY) end
		end
		mo.momx, mo.momy = 0, 0
	else
		mo.momx = mo.momx * FRICTION
		mo.momy = mo.momy * FRICTION
	end
end

local function ZMovement(mo)
	if mo.player and mo.z < mo.floorz then
		mo.player.viewheight = mo.player.viewheight - (mo.floorz - mo.z)
		mo.player.deltaviewheight = (P.VIEWHEIGHT - mo.player.viewheight) / 8
	end
	mo.z = mo.z + mo.momz
	if band(mo.flags, MF_FLOAT) ~= 0 and mo.target then
		if band(mo.flags, MF_SKULLFLY + MF_INFLOAT) == 0 then
			local dist = D.AproxDistance(mo.x - mo.target.x, mo.y - mo.target.y)
			local delta = (mo.target.z + mo.height / 2) - mo.z
			if delta < 0 and dist < -(delta * 3) then
				mo.z = mo.z - P.FLOATSPEED
			elseif delta > 0 and dist < delta * 3 then
				mo.z = mo.z + P.FLOATSPEED
			end
		end
	end
	if mo.z <= mo.floorz then
		if band(mo.flags, MF_SKULLFLY) ~= 0 then mo.momz = -mo.momz end
		if mo.momz < 0 then
			if mo.player and mo.momz < -P.GRAVITY * 8 then
				mo.player.deltaviewheight = mo.momz / 8
				S_StartSound(mo, D.SFX.oof)
			end
			mo.momz = 0
		end
		mo.z = mo.floorz
		if band(mo.flags, MF_MISSILE) ~= 0 and band(mo.flags, MF_NOCLIP) == 0 then
			ExplodeMissile(mo)
			return
		end
	elseif band(mo.flags, MF_NOGRAVITY) == 0 then
		if mo.momz == 0 then
			mo.momz = -P.GRAVITY * 2
		else
			mo.momz = mo.momz - P.GRAVITY
		end
	end
	if mo.z + mo.height > mo.ceilingz then
		if mo.momz > 0 then mo.momz = 0 end
		mo.z = mo.ceilingz - mo.height
		if band(mo.flags, MF_SKULLFLY) ~= 0 then mo.momz = -mo.momz end
		if band(mo.flags, MF_MISSILE) ~= 0 and band(mo.flags, MF_NOCLIP) == 0 then
			ExplodeMissile(mo)
			return
		end
	end
end

local function NightmareRespawn(mobj)
	local sp = mobj.spawnpoint
	local x, y = sp.x, sp.y
	if not CheckPosition(mobj, x, y) then return end
	local mo = P.SpawnMobj(mobj.x, mobj.y, mobj.subsector.sector.floorheight, MT.MT_TFOG)
	S_StartSound(mo, D.SFX.telept)
	local ss = D.PointInSubsector(x, y)
	mo = P.SpawnMobj(x, y, ss.sector.floorheight, MT.MT_TFOG)
	S_StartSound(mo, D.SFX.telept)
	local z = band(mobj.info.flags, MF_SPAWNCEILING) ~= 0 and P.ONCEILINGZ or P.ONFLOORZ
	mo = P.SpawnMobj(x, y, z, mobj.type)
	mo.spawnpoint = sp
	mo.angle = D.ANG45 * floor(sp.angle / 45)
	if band(sp.options, 8) ~= 0 then mo.flags = bor(mo.flags, MF_AMBUSH) end
	mo.reactiontime = 18
	RemoveMobj(mobj)
end

local function MobjThinker(mobj)
	if mobj.momx ~= 0 or mobj.momy ~= 0 or band(mobj.flags, MF_SKULLFLY) ~= 0 then
		XYMovement(mobj)
		if mobj.removed then return end
	end
	if mobj.z ~= mobj.floorz or mobj.momz ~= 0 then
		ZMovement(mobj)
		if mobj.removed then return end
	end
	if mobj.tics ~= -1 then
		mobj.tics = mobj.tics - 1
		if mobj.tics == 0 then
			SetMobjState(mobj, mobj.state[5])
		end
	else
		if band(mobj.flags, MF_COUNTKILL) == 0 then return end
		if not D.G.respawnmonsters then return end
		mobj.movecount = mobj.movecount + 1
		if mobj.movecount < 12 * 35 then return end
		if band(P.leveltime, 31) ~= 0 then return end
		if P_Random() > 4 then return end
		NightmareRespawn(mobj)
	end
end
P.MobjThinker = MobjThinker

function P.SpawnMobj(x, y, z, mtype)
	local info = mobjinfo[mtype]
	local mobj = {
		type = mtype, info = info,
		x = x, y = y, z = 0,
		radius = info.radius, height = info.height,
		flags = info.flags, health = info.spawnhealth,
		momx = 0, momy = 0, momz = 0,
		angle = 0, movedir = 0, movecount = 0,
		reactiontime = 0, threshold = 0,
		lastlook = P_Random() % 4,
		think = MobjThinker,
		validcount = 0,
	}
	if D.G.gameskill ~= 4 then mobj.reactiontime = info.reactiontime end
	local st = states[info.spawnstate]
	mobj.state = st
	mobj.statenum = info.spawnstate
	mobj.tics = st[3]
	mobj.sprite = st[1]
	mobj.frame = st[2]
	SetThingPosition(mobj)
	mobj.floorz = mobj.subsector.sector.floorheight
	mobj.ceilingz = mobj.subsector.sector.ceilingheight
	if z == P.ONFLOORZ then
		mobj.z = mobj.floorz
	elseif z == P.ONCEILINGZ then
		mobj.z = mobj.ceilingz - info.height
	else
		mobj.z = z
	end
	P.AddThinker(mobj)
	return mobj
end

RemoveMobj = function(mobj)
	if mobj.removed then return end
	UnsetThingPosition(mobj)
	if D.S_StopSound then D.S_StopSound(mobj) end
	P.RemoveThinker(mobj)
end
P.RemoveMobj = RemoveMobj

function P.SpawnPuff(x, y, z)
	z = z + (P_Random() - P_Random()) / 64
	local th = P.SpawnMobj(x, y, z, MT.MT_PUFF)
	th.momz = 1
	th.tics = th.tics - band(P_Random(), 3)
	if th.tics < 1 then th.tics = 1 end
	if P.attackrange == P.MELEERANGE then
		SetMobjState(th, S.S_PUFF3)
	end
end

function P.SpawnBlood(x, y, z, damage)
	z = z + (P_Random() - P_Random()) / 64
	local th = P.SpawnMobj(x, y, z, MT.MT_BLOOD)
	th.momz = 2
	th.tics = th.tics - band(P_Random(), 3)
	if th.tics < 1 then th.tics = 1 end
	if damage <= 12 and damage >= 9 then
		SetMobjState(th, S.S_BLOOD2)
	elseif damage < 9 then
		SetMobjState(th, S.S_BLOOD3)
	end
end

local function CheckMissileSpawn(th)
	th.tics = th.tics - band(P_Random(), 3)
	if th.tics < 1 then th.tics = 1 end
	th.x = th.x + th.momx / 2
	th.y = th.y + th.momy / 2
	th.z = th.z + th.momz / 2
	if not TryMove(th, th.x, th.y) then
		ExplodeMissile(th)
	end
end
P.CheckMissileSpawn = CheckMissileSpawn

function P.SpawnMissile(source, dest, mtype)
	local th = P.SpawnMobj(source.x, source.y, source.z + 32, mtype)
	if th.info.seesound ~= 0 then S_StartSound(th, th.info.seesound) end
	th.target = source
	local an = D.PointToAngle2(source.x, source.y, dest.x, dest.y)
	if band(dest.flags, MF_SHADOW) ~= 0 then
		an = (an + (P_Random() - P_Random()) * 1048576) % ANGMAX
	end
	th.angle = an
	local fa = floor(an / 524288)
	th.momx = th.info.speed * finecosine[fa]
	th.momy = th.info.speed * finesine[fa]
	local dist = D.AproxDistance(dest.x - source.x, dest.y - source.y)
	dist = floor(dist / th.info.speed)
	if dist < 1 then dist = 1 end
	th.momz = (dest.z - source.z) / dist
	CheckMissileSpawn(th)
	return th
end

function P.SpawnPlayerMissile(source, mtype)
	local an = source.angle
	local slope = P.AimLineAttack(source, an, 16 * 64)
	if not P.linetarget then
		an = (an + 67108864) % ANGMAX
		slope = P.AimLineAttack(source, an, 16 * 64)
		if not P.linetarget then
			an = (an - 134217728) % ANGMAX
			slope = P.AimLineAttack(source, an, 16 * 64)
		end
		if not P.linetarget then
			an = source.angle
			slope = 0
		end
	end
	local th = P.SpawnMobj(source.x, source.y, source.z + 32, mtype)
	if th.info.seesound ~= 0 then S_StartSound(th, th.info.seesound) end
	th.target = source
	th.angle = an
	local fa = floor(an / 524288)
	th.momx = th.info.speed * finecosine[fa]
	th.momy = th.info.speed * finesine[fa]
	th.momz = th.info.speed * slope
	CheckMissileSpawn(th)
	return th
end

------------------------------------------------------------------------ map things
function P.SpawnPlayer(mthing)
	local p = D.G.player
	if p.playerstate == "reborn" then p = D.G.PlayerReborn() end
	local mobj = P.SpawnMobj(mthing.x, mthing.y, P.ONFLOORZ, MT.MT_PLAYER)
	mobj.angle = D.ANG45 * floor(mthing.angle / 45)
	mobj.player = p
	mobj.health = p.health
	p.mo = mobj
	p.playerstate = "live"
	p.refire = 0
	p.message = nil
	p.damagecount = 0
	p.bonuscount = 0
	p.extralight = 0
	p.fixedcolormap = 0
	p.viewheight = P.VIEWHEIGHT
	P.SetupPsprites(p)
end

local doomednumToType
function P.SpawnMapThing(mthing)
	if mthing.type == 11 then return end -- deathmatch start
	if mthing.type <= 4 then
		if mthing.type == 1 then
			D.G.playerstart = mthing
			P.SpawnPlayer(mthing)
		end
		return
	end
	if band(mthing.options, 16) ~= 0 then return end -- multiplayer only
	local skill = D.G.gameskill
	local bit
	if skill == 0 then bit = 1 elseif skill == 4 then bit = 4 else bit = 2 ^ (skill - 1) end
	if band(mthing.options, bit) == 0 then return end
	if not doomednumToType then
		doomednumToType = {}
		for i = 0, #mobjinfo do
			local dn = mobjinfo[i].doomednum
			if dn ~= -1 and not doomednumToType[dn] then doomednumToType[dn] = i end
		end
	end
	local i = doomednumToType[mthing.type]
	if not i then return end
	local z = band(mobjinfo[i].flags, MF_SPAWNCEILING) ~= 0 and P.ONCEILINGZ or P.ONFLOORZ
	local mobj = P.SpawnMobj(mthing.x, mthing.y, z, i)
	mobj.spawnpoint = mthing
	if mobj.tics > 0 then mobj.tics = 1 + (P_Random() % mobj.tics) end
	if band(mobj.flags, MF_COUNTKILL) ~= 0 then D.G.totalkills = D.G.totalkills + 1 end
	if band(mobj.flags, MF_COUNTITEM) ~= 0 then D.G.totalitems = D.G.totalitems + 1 end
	mobj.angle = D.ANG45 * floor(mthing.angle / 45)
	if band(mthing.options, 8) ~= 0 then mobj.flags = bor(mobj.flags, MF_AMBUSH) end
end

function P.GetSpecHits()
	local t = {}
	for i = 1, numspechit do t[i] = spechit[i] end
	return t
end
