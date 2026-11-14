-- Sector / line specials: p_spec.c, p_doors.c, p_floor.c, p_plats.c, p_ceilng.c,
-- p_lights.c, p_switch.c, p_telept.c
local D = FreedoomArcade
local P = D.P
local floor = math.floor
local band, bor = D.band, D.bor
local P_Random = D.P_Random
local finesine, finecosine = D.finesine, D.finecosine
local MF, MT, SFX = D.MF, D.MT, D.SFX
local L = D.level
local R = D.R

local ML_TWOSIDED, ML_SECRET = 4, 32

local function S_StartSound(o, s) if D.S_StartSound then D.S_StartSound(o, s) end end
local function secSound(sec, s) S_StartSound(sec.soundorg, s) end

------------------------------------------------------------------------ helpers
local function getNextSector(line, sec)
	if band(line.flags, ML_TWOSIDED) == 0 then return nil end
	if line.frontsector == sec then return line.backsector end
	return line.frontsector
end

local function FindLowestFloorSurrounding(sec)
	local f = sec.floorheight
	for _, check in ipairs(sec.lines) do
		local other = getNextSector(check, sec)
		if other and other.floorheight < f then f = other.floorheight end
	end
	return f
end

local function FindHighestFloorSurrounding(sec)
	local f = -500
	for _, check in ipairs(sec.lines) do
		local other = getNextSector(check, sec)
		if other and other.floorheight > f then f = other.floorheight end
	end
	return f
end

local function FindNextHighestFloor(sec, currentheight)
	local min
	for _, check in ipairs(sec.lines) do
		local other = getNextSector(check, sec)
		if other and other.floorheight > currentheight then
			if not min or other.floorheight < min then min = other.floorheight end
		end
	end
	return min or currentheight
end

local function FindLowestCeilingSurrounding(sec)
	local h = D.MAXINT
	for _, check in ipairs(sec.lines) do
		local other = getNextSector(check, sec)
		if other and other.ceilingheight < h then h = other.ceilingheight end
	end
	return h
end

local function FindHighestCeilingSurrounding(sec)
	local h = 0
	for _, check in ipairs(sec.lines) do
		local other = getNextSector(check, sec)
		if other and other.ceilingheight > h then h = other.ceilingheight end
	end
	return h
end

local function FindSectorFromLineTag(line, start)
	for i = start + 1, L.numsectors - 1 do
		if L.sectors[i].tag == line.tag then return i end
	end
	return -1
end

local function FindMinSurroundingLight(sector, max)
	local min = max
	for _, line in ipairs(sector.lines) do
		local check = getNextSector(line, sector)
		if check and check.lightlevel < min then min = check.lightlevel end
	end
	return min
end

------------------------------------------------------------------------ plane movement
local OK, CRUSHED, PASTDEST = 0, 1, 2

local function MovePlane(sector, speed, dest, crush, floorOrCeiling, direction)
	if floorOrCeiling == 0 then
		if direction == -1 then
			if sector.floorheight - speed < dest then
				local lastpos = sector.floorheight
				sector.floorheight = dest
				if P.ChangeSector(sector, crush) then
					sector.floorheight = lastpos
					P.ChangeSector(sector, crush)
				end
				return PASTDEST
			else
				local lastpos = sector.floorheight
				sector.floorheight = sector.floorheight - speed
				if P.ChangeSector(sector, crush) then
					sector.floorheight = lastpos
					P.ChangeSector(sector, crush)
					return CRUSHED
				end
			end
		else
			if sector.floorheight + speed > dest then
				local lastpos = sector.floorheight
				sector.floorheight = dest
				if P.ChangeSector(sector, crush) then
					sector.floorheight = lastpos
					P.ChangeSector(sector, crush)
				end
				return PASTDEST
			else
				local lastpos = sector.floorheight
				sector.floorheight = sector.floorheight + speed
				if P.ChangeSector(sector, crush) then
					if crush then return CRUSHED end
					sector.floorheight = lastpos
					P.ChangeSector(sector, crush)
					return CRUSHED
				end
			end
		end
	else
		if direction == -1 then
			if sector.ceilingheight - speed < dest then
				local lastpos = sector.ceilingheight
				sector.ceilingheight = dest
				if P.ChangeSector(sector, crush) then
					sector.ceilingheight = lastpos
					P.ChangeSector(sector, crush)
				end
				return PASTDEST
			else
				local lastpos = sector.ceilingheight
				sector.ceilingheight = sector.ceilingheight - speed
				if P.ChangeSector(sector, crush) then
					if crush then return CRUSHED end
					sector.ceilingheight = lastpos
					P.ChangeSector(sector, crush)
					return CRUSHED
				end
			end
		else
			if sector.ceilingheight + speed > dest then
				local lastpos = sector.ceilingheight
				sector.ceilingheight = dest
				if P.ChangeSector(sector, crush) then
					sector.ceilingheight = lastpos
					P.ChangeSector(sector, crush)
				end
				return PASTDEST
			else
				sector.ceilingheight = sector.ceilingheight + speed
				P.ChangeSector(sector, crush)
			end
		end
	end
	return OK
end

------------------------------------------------------------------------ doors
local VDOORSPEED, VDOORWAIT = 2, 150

local function T_VerticalDoor(door)
	local sec = door.sector
	if door.direction == 0 then
		door.topcountdown = door.topcountdown - 1
		if door.topcountdown == 0 then
			if door.type == "blazeRaise" then
				door.direction = -1
				secSound(sec, SFX.bdcls)
			elseif door.type == "normal" then
				door.direction = -1
				secSound(sec, SFX.dorcls)
			elseif door.type == "close30ThenOpen" then
				door.direction = 1
				secSound(sec, SFX.doropn)
			end
		end
	elseif door.direction == 2 then
		door.topcountdown = door.topcountdown - 1
		if door.topcountdown == 0 then
			if door.type == "raiseIn5Mins" then
				door.direction = 1
				door.type = "normal"
				secSound(sec, SFX.doropn)
			end
		end
	elseif door.direction == -1 then
		local res = MovePlane(sec, door.speed, sec.floorheight, false, 1, -1)
		if res == PASTDEST then
			local t = door.type
			if t == "blazeRaise" or t == "blazeClose" then
				sec.specialdata = nil
				P.RemoveThinker(door)
				secSound(sec, SFX.bdcls)
			elseif t == "normal" or t == "close" then
				sec.specialdata = nil
				P.RemoveThinker(door)
			elseif t == "close30ThenOpen" then
				door.direction = 0
				door.topcountdown = 35 * 30
			end
		elseif res == CRUSHED then
			if door.type ~= "blazeClose" and door.type ~= "close" then
				door.direction = 1
				secSound(sec, SFX.doropn)
			end
		end
	elseif door.direction == 1 then
		local res = MovePlane(sec, door.speed, door.topheight, false, 1, 1)
		if res == PASTDEST then
			local t = door.type
			if t == "blazeRaise" or t == "normal" then
				door.direction = 0
				door.topcountdown = door.topwait
			elseif t == "close30ThenOpen" or t == "blazeOpen" or t == "open" then
				sec.specialdata = nil
				P.RemoveThinker(door)
			end
		end
	end
end

local function newDoor(sec)
	local door = { kind = "door", think = T_VerticalDoor, sector = sec, topwait = VDOORWAIT, speed = VDOORSPEED, topcountdown = 0, direction = 0, topheight = 0 }
	P.AddThinker(door)
	sec.specialdata = door
	return door
end

function P.EV_DoDoor(line, dtype)
	local secnum, rtn = -1, false
	while true do
		secnum = FindSectorFromLineTag(line, secnum)
		if secnum < 0 then break end
		local sec = L.sectors[secnum]
		if not sec.specialdata then
			rtn = true
			local door = newDoor(sec)
			door.type = dtype
			if dtype == "blazeClose" then
				door.topheight = FindLowestCeilingSurrounding(sec) - 4
				door.direction = -1
				door.speed = VDOORSPEED * 4
				secSound(sec, SFX.bdcls)
			elseif dtype == "close" then
				door.topheight = FindLowestCeilingSurrounding(sec) - 4
				door.direction = -1
				secSound(sec, SFX.dorcls)
			elseif dtype == "close30ThenOpen" then
				door.topheight = sec.ceilingheight
				door.direction = -1
				secSound(sec, SFX.dorcls)
			elseif dtype == "blazeRaise" or dtype == "blazeOpen" then
				door.direction = 1
				door.topheight = FindLowestCeilingSurrounding(sec) - 4
				door.speed = VDOORSPEED * 4
				if door.topheight ~= sec.ceilingheight then secSound(sec, SFX.bdopn) end
			elseif dtype == "normal" or dtype == "open" then
				door.direction = 1
				door.topheight = FindLowestCeilingSurrounding(sec) - 4
				if door.topheight ~= sec.ceilingheight then secSound(sec, SFX.doropn) end
			end
		end
	end
	return rtn
end

local function needKey(player, a, b, msg)
	if not player.cards[a] and not player.cards[b] then
		player.message = msg
		S_StartSound(nil, SFX.oof)
		return true
	end
	return false
end

local function EV_DoLockedDoor(line, dtype, thing)
	local p = thing.player
	if not p then return false end
	local s = line.special
	if s == 99 or s == 133 then
		if needKey(p, 0, 3, "You need a blue key to activate this object") then return false end
	elseif s == 134 or s == 135 then
		if needKey(p, 2, 5, "You need a red key to activate this object") then return false end
	elseif s == 136 or s == 137 then
		if needKey(p, 1, 4, "You need a yellow key to activate this object") then return false end
	end
	return P.EV_DoDoor(line, dtype)
end

local function EV_VerticalDoor(line, thing)
	local player = thing.player
	local s = line.special
	if s == 26 or s == 32 then
		if not player then return end
		if needKey(player, 0, 3, "You need a blue key to open this door") then return end
	elseif s == 27 or s == 34 then
		if not player then return end
		if needKey(player, 1, 4, "You need a yellow key to open this door") then return end
	elseif s == 28 or s == 33 then
		if not player then return end
		if needKey(player, 2, 5, "You need a red key to open this door") then return end
	end
	if line.sidenum[1] == -1 then return end
	local sec = L.sides[line.sidenum[1]].sector
	local door = sec.specialdata
	if door then
		if s == 1 or s == 26 or s == 27 or s == 28 or s == 117 then
			if door.direction == -1 then
				door.direction = 1
			else
				if not thing.player then return end
				door.direction = -1
			end
			return
		end
	end
	if s == 117 or s == 118 then
		secSound(sec, SFX.bdopn)
	else
		secSound(sec, SFX.doropn)
	end
	door = newDoor(sec)
	door.direction = 1
	if s == 1 or s == 26 or s == 27 or s == 28 then
		door.type = "normal"
	elseif s == 31 or s == 32 or s == 33 or s == 34 then
		door.type = "open"
		line.special = 0
	elseif s == 117 then
		door.type = "blazeRaise"
		door.speed = VDOORSPEED * 4
	elseif s == 118 then
		door.type = "blazeOpen"
		line.special = 0
		door.speed = VDOORSPEED * 4
	else
		door.type = "normal"
	end
	door.topheight = FindLowestCeilingSurrounding(sec) - 4
end

local function SpawnDoorCloseIn30(sec)
	local door = newDoor(sec)
	sec.special = 0
	door.direction = 0
	door.type = "normal"
	door.topcountdown = 30 * 35
end

local function SpawnDoorRaiseIn5Mins(sec)
	local door = newDoor(sec)
	sec.special = 0
	door.direction = 2
	door.type = "raiseIn5Mins"
	door.topheight = FindLowestCeilingSurrounding(sec) - 4
	door.topcountdown = 5 * 60 * 35
end

------------------------------------------------------------------------ floors
local FLOORSPEED = 1

local function T_MoveFloor(fl)
	local sec = fl.sector
	local res = MovePlane(sec, fl.speed, fl.floordestheight, fl.crush, 0, fl.direction)
	if band(P.leveltime, 7) == 0 then secSound(sec, SFX.stnmov) end
	if res == PASTDEST then
		sec.specialdata = nil
		if fl.direction == 1 then
			if fl.type == "donutRaise" then
				sec.special = fl.newspecial
				sec.floorpic = fl.texture
			end
		elseif fl.direction == -1 then
			if fl.type == "lowerAndChange" then
				sec.special = fl.newspecial
				sec.floorpic = fl.texture
			end
		end
		P.RemoveThinker(fl)
		secSound(sec, SFX.pstop)
	end
end

local function newFloor(sec)
	local fl = { kind = "floor", think = T_MoveFloor, sector = sec, crush = false, direction = 1, speed = FLOORSPEED, floordestheight = sec.floorheight, newspecial = 0 }
	P.AddThinker(fl)
	sec.specialdata = fl
	return fl
end

function P.EV_DoFloor(line, ftype)
	local secnum, rtn = -1, false
	while true do
		secnum = FindSectorFromLineTag(line, secnum)
		if secnum < 0 then break end
		local sec = L.sectors[secnum]
		if not sec.specialdata then
			rtn = true
			local fl = newFloor(sec)
			fl.type = ftype
			if ftype == "lowerFloor" then
				fl.direction = -1
				fl.floordestheight = FindHighestFloorSurrounding(sec)
			elseif ftype == "lowerFloorToLowest" then
				fl.direction = -1
				fl.floordestheight = FindLowestFloorSurrounding(sec)
			elseif ftype == "turboLower" then
				fl.direction = -1
				fl.speed = FLOORSPEED * 4
				fl.floordestheight = FindHighestFloorSurrounding(sec)
				if fl.floordestheight ~= sec.floorheight then fl.floordestheight = fl.floordestheight + 8 end
			elseif ftype == "raiseFloorCrush" or ftype == "raiseFloor" then
				if ftype == "raiseFloorCrush" then fl.crush = true end
				fl.direction = 1
				fl.floordestheight = FindLowestCeilingSurrounding(sec)
				if fl.floordestheight > sec.ceilingheight then fl.floordestheight = sec.ceilingheight end
				if ftype == "raiseFloorCrush" then fl.floordestheight = fl.floordestheight - 8 end
			elseif ftype == "raiseFloorTurbo" then
				fl.direction = 1
				fl.speed = FLOORSPEED * 4
				fl.floordestheight = FindNextHighestFloor(sec, sec.floorheight)
			elseif ftype == "raiseFloorToNearest" then
				fl.direction = 1
				fl.floordestheight = FindNextHighestFloor(sec, sec.floorheight)
			elseif ftype == "raiseFloor24" then
				fl.direction = 1
				fl.floordestheight = sec.floorheight + 24
			elseif ftype == "raiseFloor512" then
				fl.direction = 1
				fl.floordestheight = sec.floorheight + 512
			elseif ftype == "raiseFloor24AndChange" then
				fl.direction = 1
				fl.floordestheight = sec.floorheight + 24
				sec.floorpic = line.frontsector.floorpic
				sec.special = line.frontsector.special
			elseif ftype == "raiseToTexture" then
				local minsize = D.MAXINT
				fl.direction = 1
				for _, ln in ipairs(sec.lines) do
					if band(ln.flags, ML_TWOSIDED) ~= 0 then
						for sd = 0, 1 do
							local side = L.sides[ln.sidenum[sd]]
							if side and side.bottomtexture then
								local h = R.TextureHeight(side.bottomtexture)
								if h < minsize then minsize = h end
							end
						end
					end
				end
				fl.floordestheight = sec.floorheight + minsize
			elseif ftype == "lowerAndChange" then
				fl.direction = -1
				fl.floordestheight = FindLowestFloorSurrounding(sec)
				fl.texture = sec.floorpic
				for _, ln in ipairs(sec.lines) do
					if band(ln.flags, ML_TWOSIDED) ~= 0 then
						local other
						if L.sides[ln.sidenum[0]].sector == sec then
							other = L.sides[ln.sidenum[1]].sector
						else
							other = L.sides[ln.sidenum[0]].sector
						end
						if other.floorheight == fl.floordestheight then
							fl.texture = other.floorpic
							fl.newspecial = other.special
							break
						end
					end
				end
			end
		end
	end
	return rtn
end

local function EV_BuildStairs(line, stype)
	local secnum, rtn = -1, false
	while true do
		secnum = FindSectorFromLineTag(line, secnum)
		if secnum < 0 then break end
		local sec = L.sectors[secnum]
		if not sec.specialdata then
			rtn = true
			local speed, stairsize
			if stype == "build8" then
				speed, stairsize = FLOORSPEED / 4, 8
			else
				speed, stairsize = FLOORSPEED * 4, 16
			end
			local fl = newFloor(sec)
			fl.direction = 1
			fl.speed = speed
			local height = sec.floorheight + stairsize
			fl.floordestheight = height
			local texture = sec.floorpic
			local ok
			repeat
				ok = false
				for _, ln in ipairs(sec.lines) do
					if band(ln.flags, ML_TWOSIDED) ~= 0 and ln.frontsector.id == secnum then
						local tsec = ln.backsector
						if tsec.floorpic == texture then
							height = height + stairsize
							if not tsec.specialdata then
								sec = tsec
								secnum = tsec.id
								local f2 = newFloor(sec)
								f2.direction = 1
								f2.speed = speed
								f2.floordestheight = height
								ok = true
								break
							end
						end
					end
				end
			until not ok
		end
	end
	return rtn
end

local function EV_DoDonut(line)
	local secnum, rtn = -1, false
	while true do
		secnum = FindSectorFromLineTag(line, secnum)
		if secnum < 0 then break end
		local s1 = L.sectors[secnum]
		if not s1.specialdata then
			rtn = true
			local s2 = getNextSector(s1.lines[1], s1)
			if s2 then
				for _, ln in ipairs(s2.lines) do
					if band(ln.flags, ML_TWOSIDED) ~= 0 and ln.backsector ~= s1 then
						local s3 = ln.backsector
						local fl = newFloor(s2)
						fl.type = "donutRaise"
						fl.direction = 1
						fl.speed = FLOORSPEED / 2
						fl.texture = s3.floorpic
						fl.newspecial = 0
						fl.floordestheight = s3.floorheight
						fl = newFloor(s1)
						fl.type = "lowerFloor"
						fl.direction = -1
						fl.speed = FLOORSPEED / 2
						fl.floordestheight = s3.floorheight
						break
					end
				end
			end
		end
	end
	return rtn
end

------------------------------------------------------------------------ plats
local PLATSPEED, PLATWAIT = 1, 3
local UP, DOWN, WAITING, IN_STASIS = 0, 1, 2, 3
local activeplats = {}

local function RemoveActivePlat(plat)
	for i, p in ipairs(activeplats) do
		if p == plat then
			plat.sector.specialdata = nil
			P.RemoveThinker(plat)
			table.remove(activeplats, i)
			return
		end
	end
end

local function T_PlatRaise(plat)
	local sec = plat.sector
	if plat.status == UP then
		local res = MovePlane(sec, plat.speed, plat.high, plat.crush, 0, 1)
		if plat.type == "raiseAndChange" or plat.type == "raiseToNearestAndChange" then
			if band(P.leveltime, 7) == 0 then secSound(sec, SFX.stnmov) end
		end
		if res == CRUSHED and not plat.crush then
			plat.count = plat.wait
			plat.status = DOWN
			secSound(sec, SFX.pstart)
		elseif res == PASTDEST then
			plat.count = plat.wait
			plat.status = WAITING
			secSound(sec, SFX.pstop)
			local t = plat.type
			if t == "blazeDWUS" or t == "downWaitUpStay" or t == "raiseAndChange" or t == "raiseToNearestAndChange" then
				RemoveActivePlat(plat)
			end
		end
	elseif plat.status == DOWN then
		local res = MovePlane(sec, plat.speed, plat.low, false, 0, -1)
		if res == PASTDEST then
			plat.count = plat.wait
			plat.status = WAITING
			secSound(sec, SFX.pstop)
		end
	elseif plat.status == WAITING then
		plat.count = plat.count - 1
		if plat.count == 0 then
			if sec.floorheight == plat.low then plat.status = UP else plat.status = DOWN end
			secSound(sec, SFX.pstart)
		end
	end
end

local function ActivateInStasis(tag)
	for _, p in ipairs(activeplats) do
		if p.tag == tag and p.status == IN_STASIS then
			p.status = p.oldstatus
			p.think = T_PlatRaise
		end
	end
end

local function EV_StopPlat(line)
	for _, p in ipairs(activeplats) do
		if p.status ~= IN_STASIS and p.tag == line.tag then
			p.oldstatus = p.status
			p.status = IN_STASIS
			p.think = nil
		end
	end
end

local function EV_DoPlat(line, ptype, amount)
	local secnum, rtn = -1, false
	if ptype == "perpetualRaise" then ActivateInStasis(line.tag) end
	while true do
		secnum = FindSectorFromLineTag(line, secnum)
		if secnum < 0 then break end
		local sec = L.sectors[secnum]
		if not sec.specialdata then
			rtn = true
			local plat = { kind = "plat", think = T_PlatRaise, type = ptype, sector = sec, crush = false, tag = line.tag, count = 0, low = sec.floorheight, high = sec.floorheight, wait = 0, speed = PLATSPEED, status = UP }
			P.AddThinker(plat)
			sec.specialdata = plat
			if ptype == "raiseToNearestAndChange" then
				plat.speed = PLATSPEED / 2
				sec.floorpic = L.sides[line.sidenum[0]].sector.floorpic
				plat.high = FindNextHighestFloor(sec, sec.floorheight)
				plat.wait = 0
				plat.status = UP
				sec.special = 0
				secSound(sec, SFX.stnmov)
			elseif ptype == "raiseAndChange" then
				plat.speed = PLATSPEED / 2
				sec.floorpic = L.sides[line.sidenum[0]].sector.floorpic
				plat.high = sec.floorheight + amount
				plat.wait = 0
				plat.status = UP
				secSound(sec, SFX.stnmov)
			elseif ptype == "downWaitUpStay" or ptype == "blazeDWUS" then
				plat.speed = PLATSPEED * (ptype == "blazeDWUS" and 8 or 4)
				plat.low = FindLowestFloorSurrounding(sec)
				if plat.low > sec.floorheight then plat.low = sec.floorheight end
				plat.high = sec.floorheight
				plat.wait = 35 * PLATWAIT
				plat.status = DOWN
				secSound(sec, SFX.pstart)
			elseif ptype == "perpetualRaise" then
				plat.speed = PLATSPEED
				plat.low = FindLowestFloorSurrounding(sec)
				if plat.low > sec.floorheight then plat.low = sec.floorheight end
				plat.high = FindHighestFloorSurrounding(sec)
				if plat.high < sec.floorheight then plat.high = sec.floorheight end
				plat.wait = 35 * PLATWAIT
				plat.status = band(P_Random(), 1)
				secSound(sec, SFX.pstart)
			end
			activeplats[#activeplats + 1] = plat
		end
	end
	return rtn
end

------------------------------------------------------------------------ ceilings
local CEILSPEED = 1
local activeceilings = {}

local function RemoveActiveCeiling(c)
	for i, a in ipairs(activeceilings) do
		if a == c then
			c.sector.specialdata = nil
			P.RemoveThinker(c)
			table.remove(activeceilings, i)
			return
		end
	end
end

local function T_MoveCeiling(c)
	local sec = c.sector
	if c.direction == 1 then
		local res = MovePlane(sec, c.speed, c.topheight, false, 1, 1)
		if band(P.leveltime, 7) == 0 and c.type ~= "silentCrushAndRaise" then secSound(sec, SFX.stnmov) end
		if res == PASTDEST then
			local t = c.type
			if t == "raiseToHighest" then
				RemoveActiveCeiling(c)
			elseif t == "silentCrushAndRaise" or t == "fastCrushAndRaise" or t == "crushAndRaise" then
				if t == "silentCrushAndRaise" then secSound(sec, SFX.pstop) end
				c.direction = -1
			end
		end
	elseif c.direction == -1 then
		local res = MovePlane(sec, c.speed, c.bottomheight, c.crush, 1, -1)
		if band(P.leveltime, 7) == 0 and c.type ~= "silentCrushAndRaise" then secSound(sec, SFX.stnmov) end
		if res == PASTDEST then
			local t = c.type
			if t == "silentCrushAndRaise" or t == "crushAndRaise" or t == "fastCrushAndRaise" then
				if t == "silentCrushAndRaise" then secSound(sec, SFX.pstop) end
				if t ~= "fastCrushAndRaise" then c.speed = CEILSPEED end
				c.direction = 1
			elseif t == "lowerAndCrush" or t == "lowerToFloor" then
				RemoveActiveCeiling(c)
			end
		elseif res == CRUSHED then
			local t = c.type
			if t == "silentCrushAndRaise" or t == "crushAndRaise" or t == "lowerAndCrush" then
				c.speed = CEILSPEED / 8
			end
		end
	end
end

local function ActivateInStasisCeiling(line)
	for _, c in ipairs(activeceilings) do
		if c.tag == line.tag and c.direction == 0 then
			c.direction = c.olddirection
			c.think = T_MoveCeiling
		end
	end
end

local function EV_CeilingCrushStop(line)
	local rtn = false
	for _, c in ipairs(activeceilings) do
		if c.tag == line.tag and c.direction ~= 0 then
			c.olddirection = c.direction
			c.think = nil
			c.direction = 0
			rtn = true
		end
	end
	return rtn
end

local function EV_DoCeiling(line, ctype)
	local secnum, rtn = -1, false
	if ctype == "fastCrushAndRaise" or ctype == "silentCrushAndRaise" or ctype == "crushAndRaise" then
		ActivateInStasisCeiling(line)
	end
	while true do
		secnum = FindSectorFromLineTag(line, secnum)
		if secnum < 0 then break end
		local sec = L.sectors[secnum]
		if not sec.specialdata then
			rtn = true
			local c = { kind = "ceiling", think = T_MoveCeiling, sector = sec, crush = false, direction = 0, speed = CEILSPEED, topheight = sec.ceilingheight, bottomheight = sec.floorheight }
			P.AddThinker(c)
			sec.specialdata = c
			if ctype == "fastCrushAndRaise" then
				c.crush = true
				c.topheight = sec.ceilingheight
				c.bottomheight = sec.floorheight + 8
				c.direction = -1
				c.speed = CEILSPEED * 2
			elseif ctype == "silentCrushAndRaise" or ctype == "crushAndRaise" or ctype == "lowerAndCrush" or ctype == "lowerToFloor" then
				if ctype == "silentCrushAndRaise" or ctype == "crushAndRaise" then
					c.crush = true
					c.topheight = sec.ceilingheight
				end
				c.bottomheight = sec.floorheight
				if ctype ~= "lowerToFloor" then c.bottomheight = c.bottomheight + 8 end
				c.direction = -1
				c.speed = CEILSPEED
			elseif ctype == "raiseToHighest" then
				c.topheight = FindHighestCeilingSurrounding(sec)
				c.direction = 1
				c.speed = CEILSPEED
			end
			c.tag = sec.tag
			c.type = ctype
			activeceilings[#activeceilings + 1] = c
		end
	end
	return rtn
end

------------------------------------------------------------------------ lights
local GLOWSPEED, STROBEBRIGHT, FASTDARK, SLOWDARK = 8, 5, 15, 35

local function T_FireFlicker(f)
	f.count = f.count - 1
	if f.count ~= 0 then return end
	local amount = band(P_Random(), 3) * 16
	if f.sector.lightlevel - amount < f.minlight then
		f.sector.lightlevel = f.minlight
	else
		f.sector.lightlevel = f.maxlight - amount
	end
	f.count = 4
end

local function SpawnFireFlicker(sector)
	sector.special = 0
	P.AddThinker({ kind = "flicker", think = T_FireFlicker, sector = sector, maxlight = sector.lightlevel,
		minlight = FindMinSurroundingLight(sector, sector.lightlevel) + 16, count = 4 })
end

local function T_LightFlash(f)
	f.count = f.count - 1
	if f.count ~= 0 then return end
	if f.sector.lightlevel == f.maxlight then
		f.sector.lightlevel = f.minlight
		f.count = band(P_Random(), f.mintime) + 1
	else
		f.sector.lightlevel = f.maxlight
		f.count = band(P_Random(), f.maxtime) + 1
	end
end

local function SpawnLightFlash(sector)
	sector.special = 0
	local f = { kind = "flash", think = T_LightFlash, sector = sector, maxlight = sector.lightlevel,
		minlight = FindMinSurroundingLight(sector, sector.lightlevel), maxtime = 64, mintime = 7 }
	f.count = band(P_Random(), f.maxtime) + 1
	P.AddThinker(f)
end

local function T_StrobeFlash(f)
	f.count = f.count - 1
	if f.count ~= 0 then return end
	if f.sector.lightlevel == f.minlight then
		f.sector.lightlevel = f.maxlight
		f.count = f.brighttime
	else
		f.sector.lightlevel = f.minlight
		f.count = f.darktime
	end
end

local function SpawnStrobeFlash(sector, fastOrSlow, inSync)
	local f = { kind = "strobe", think = T_StrobeFlash, sector = sector, darktime = fastOrSlow, brighttime = STROBEBRIGHT,
		maxlight = sector.lightlevel, minlight = FindMinSurroundingLight(sector, sector.lightlevel) }
	if f.minlight == f.maxlight then f.minlight = 0 end
	sector.special = 0
	if inSync == 0 then f.count = band(P_Random(), 7) + 1 else f.count = 1 end
	P.AddThinker(f)
end

local function EV_StartLightStrobing(line)
	local secnum = -1
	while true do
		secnum = FindSectorFromLineTag(line, secnum)
		if secnum < 0 then break end
		local sec = L.sectors[secnum]
		if not sec.specialdata then SpawnStrobeFlash(sec, SLOWDARK, 0) end
	end
end

local function EV_TurnTagLightsOff(line)
	for j = 0, L.numsectors - 1 do
		local sector = L.sectors[j]
		if sector.tag == line.tag then
			local min = sector.lightlevel
			for _, tl in ipairs(sector.lines) do
				local tsec = getNextSector(tl, sector)
				if tsec and tsec.lightlevel < min then min = tsec.lightlevel end
			end
			sector.lightlevel = min
		end
	end
end

local function EV_LightTurnOn(line, bright)
	for i = 0, L.numsectors - 1 do
		local sector = L.sectors[i]
		if sector.tag == line.tag then
			if bright == 0 then
				for _, tl in ipairs(sector.lines) do
					local temp = getNextSector(tl, sector)
					if temp and temp.lightlevel > bright then bright = temp.lightlevel end
				end
			end
			sector.lightlevel = bright
		end
	end
end

local function T_Glow(g)
	if g.direction == -1 then
		g.sector.lightlevel = g.sector.lightlevel - GLOWSPEED
		if g.sector.lightlevel <= g.minlight then
			g.sector.lightlevel = g.sector.lightlevel + GLOWSPEED
			g.direction = 1
		end
	else
		g.sector.lightlevel = g.sector.lightlevel + GLOWSPEED
		if g.sector.lightlevel >= g.maxlight then
			g.sector.lightlevel = g.sector.lightlevel - GLOWSPEED
			g.direction = -1
		end
	end
end

local function SpawnGlowingLight(sector)
	P.AddThinker({ kind = "glow", think = T_Glow, sector = sector, minlight = FindMinSurroundingLight(sector, sector.lightlevel),
		maxlight = sector.lightlevel, direction = -1 })
	sector.special = 0
end

------------------------------------------------------------------------ switches
local switchPairs = {}
do
	local list = {
		{ "SW1BRCOM", "SW2BRCOM" }, { "SW1BRN1", "SW2BRN1" }, { "SW1BRN2", "SW2BRN2" }, { "SW1BRNGN", "SW2BRNGN" },
		{ "SW1BROWN", "SW2BROWN" }, { "SW1COMM", "SW2COMM" }, { "SW1COMP", "SW2COMP" }, { "SW1DIRT", "SW2DIRT" },
		{ "SW1EXIT", "SW2EXIT" }, { "SW1GRAY", "SW2GRAY" }, { "SW1GRAY1", "SW2GRAY1" }, { "SW1METAL", "SW2METAL" },
		{ "SW1PIPE", "SW2PIPE" }, { "SW1SLAD", "SW2SLAD" }, { "SW1STARG", "SW2STARG" }, { "SW1STON1", "SW2STON1" },
		{ "SW1STON2", "SW2STON2" }, { "SW1STONE", "SW2STONE" }, { "SW1STRTN", "SW2STRTN" },
		{ "SW1BLUE", "SW2BLUE" }, { "SW1CMT", "SW2CMT" }, { "SW1GARG", "SW2GARG" }, { "SW1GSTON", "SW2GSTON" },
		{ "SW1HOT", "SW2HOT" }, { "SW1LION", "SW2LION" }, { "SW1SATYR", "SW2SATYR" }, { "SW1SKIN", "SW2SKIN" },
		{ "SW1VINE", "SW2VINE" }, { "SW1WOOD", "SW2WOOD" },
		{ "SW1PANEL", "SW2PANEL" }, { "SW1ROCK", "SW2ROCK" }, { "SW1MET2", "SW2MET2" }, { "SW1WDMET", "SW2WDMET" },
		{ "SW1BRIK", "SW2BRIK" }, { "SW1MOD1", "SW2MOD1" }, { "SW1ZIM", "SW2ZIM" }, { "SW1STON6", "SW2STON6" },
		{ "SW1TEK", "SW2TEK" }, { "SW1MARB", "SW2MARB" }, { "SW1SKULL", "SW2SKULL" },
	}
	for _, p in ipairs(list) do
		switchPairs[p[1]] = p[2]
		switchPairs[p[2]] = p[1]
	end
end

local BUTTONTIME = 35
local buttons = {}

local function StartButton(line, where, texture, time)
	for _, b in ipairs(buttons) do
		if b.line == line then return end
	end
	buttons[#buttons + 1] = { line = line, where = where, btexture = texture, btimer = time, soundorg = line.frontsector.soundorg }
end

local function ChangeSwitchTexture(line, useAgain)
	if not useAgain then line.special = 0 end
	local side = L.sides[line.sidenum[0]]
	local sound = SFX.swtchn
	if line.special == 11 then sound = SFX.swtchx end
	local org = line.frontsector.soundorg
	local t = side.toptexture
	if t and switchPairs[t] then
		S_StartSound(org, sound)
		side.toptexture = switchPairs[t]
		if useAgain then StartButton(line, "top", t, BUTTONTIME) end
		return
	end
	t = side.midtexture
	if t and switchPairs[t] then
		S_StartSound(org, sound)
		side.midtexture = switchPairs[t]
		if useAgain then StartButton(line, "middle", t, BUTTONTIME) end
		return
	end
	t = side.bottomtexture
	if t and switchPairs[t] then
		S_StartSound(org, sound)
		side.bottomtexture = switchPairs[t]
		if useAgain then StartButton(line, "bottom", t, BUTTONTIME) end
		return
	end
end

------------------------------------------------------------------------ teleport
local function EV_Teleport(line, side, thing)
	if band(thing.flags, MF.MISSILE) ~= 0 then return false end
	if side == 1 then return false end
	local tag = line.tag
	for i = 0, L.numsectors - 1 do
		if L.sectors[i].tag == tag then
			for _, m in ipairs(P.thinkers) do
				if not m.removed and m.think == P.MobjThinker and m.type == MT.MT_TELEPORTMAN and m.subsector.sector.id == i then
					local oldx, oldy, oldz = thing.x, thing.y, thing.z
					if not P.TeleportMove(thing, m.x, m.y) then return false end
					thing.z = thing.floorz
					if thing.player then thing.player.viewz = thing.z + thing.player.viewheight end
					local fog = P.SpawnMobj(oldx, oldy, oldz, MT.MT_TFOG)
					S_StartSound(fog, SFX.telept)
					local an = floor(m.angle / 524288)
					fog = P.SpawnMobj(m.x + 20 * finecosine[an], m.y + 20 * finesine[an], thing.z, MT.MT_TFOG)
					S_StartSound(fog, SFX.telept)
					if thing.player then thing.reactiontime = 18 end
					thing.angle = m.angle
					thing.momx, thing.momy, thing.momz = 0, 0, 0
					return true
				end
			end
		end
	end
	return false
end

------------------------------------------------------------------------ line triggers
function P.CrossSpecialLine(line, side, thing)
	if not thing.player then
		local t = thing.type
		if t == MT.MT_ROCKET or t == MT.MT_PLASMA or t == MT.MT_BFG or t == MT.MT_TROOPSHOT
			or t == MT.MT_HEADSHOT or t == MT.MT_BRUISERSHOT then
			return
		end
		local s = line.special
		if not (s == 39 or s == 97 or s == 125 or s == 126 or s == 4 or s == 10 or s == 88) then return end
	end
	local s = line.special
	local G = D.G
	-- W1 (once)
	if s == 2 then P.EV_DoDoor(line, "open"); line.special = 0
	elseif s == 3 then P.EV_DoDoor(line, "close"); line.special = 0
	elseif s == 4 then P.EV_DoDoor(line, "normal"); line.special = 0
	elseif s == 5 then P.EV_DoFloor(line, "raiseFloor"); line.special = 0
	elseif s == 6 then EV_DoCeiling(line, "fastCrushAndRaise"); line.special = 0
	elseif s == 8 then EV_BuildStairs(line, "build8"); line.special = 0
	elseif s == 10 then EV_DoPlat(line, "downWaitUpStay", 0); line.special = 0
	elseif s == 12 then EV_LightTurnOn(line, 0); line.special = 0
	elseif s == 13 then EV_LightTurnOn(line, 255); line.special = 0
	elseif s == 16 then P.EV_DoDoor(line, "close30ThenOpen"); line.special = 0
	elseif s == 17 then EV_StartLightStrobing(line); line.special = 0
	elseif s == 19 then P.EV_DoFloor(line, "lowerFloor"); line.special = 0
	elseif s == 22 then EV_DoPlat(line, "raiseToNearestAndChange", 0); line.special = 0
	elseif s == 25 then EV_DoCeiling(line, "crushAndRaise"); line.special = 0
	elseif s == 30 then P.EV_DoFloor(line, "raiseToTexture"); line.special = 0
	elseif s == 35 then EV_LightTurnOn(line, 35); line.special = 0
	elseif s == 36 then P.EV_DoFloor(line, "turboLower"); line.special = 0
	elseif s == 37 then P.EV_DoFloor(line, "lowerAndChange"); line.special = 0
	elseif s == 38 then P.EV_DoFloor(line, "lowerFloorToLowest"); line.special = 0
	elseif s == 39 then EV_Teleport(line, side, thing); line.special = 0
	elseif s == 40 then EV_DoCeiling(line, "raiseToHighest"); P.EV_DoFloor(line, "lowerFloorToLowest"); line.special = 0
	elseif s == 44 then EV_DoCeiling(line, "lowerAndCrush"); line.special = 0
	elseif s == 52 then G.ExitLevel()
	elseif s == 53 then EV_DoPlat(line, "perpetualRaise", 0); line.special = 0
	elseif s == 54 then EV_StopPlat(line); line.special = 0
	elseif s == 56 then P.EV_DoFloor(line, "raiseFloorCrush"); line.special = 0
	elseif s == 57 then EV_CeilingCrushStop(line); line.special = 0
	elseif s == 58 then P.EV_DoFloor(line, "raiseFloor24"); line.special = 0
	elseif s == 59 then P.EV_DoFloor(line, "raiseFloor24AndChange"); line.special = 0
	elseif s == 104 then EV_TurnTagLightsOff(line); line.special = 0
	elseif s == 108 then P.EV_DoDoor(line, "blazeRaise"); line.special = 0
	elseif s == 109 then P.EV_DoDoor(line, "blazeOpen"); line.special = 0
	elseif s == 100 then EV_BuildStairs(line, "turbo16"); line.special = 0
	elseif s == 110 then P.EV_DoDoor(line, "blazeClose"); line.special = 0
	elseif s == 119 then P.EV_DoFloor(line, "raiseFloorToNearest"); line.special = 0
	elseif s == 121 then EV_DoPlat(line, "blazeDWUS", 0); line.special = 0
	elseif s == 124 then G.SecretExitLevel()
	elseif s == 125 then
		if not thing.player then EV_Teleport(line, side, thing); line.special = 0 end
	elseif s == 130 then P.EV_DoFloor(line, "raiseFloorTurbo"); line.special = 0
	elseif s == 141 then EV_DoCeiling(line, "silentCrushAndRaise"); line.special = 0
	-- WR (repeatable)
	elseif s == 72 then EV_DoCeiling(line, "lowerAndCrush")
	elseif s == 73 then EV_DoCeiling(line, "crushAndRaise")
	elseif s == 74 then EV_CeilingCrushStop(line)
	elseif s == 75 then P.EV_DoDoor(line, "close")
	elseif s == 76 then P.EV_DoDoor(line, "close30ThenOpen")
	elseif s == 77 then EV_DoCeiling(line, "fastCrushAndRaise")
	elseif s == 79 then EV_LightTurnOn(line, 35)
	elseif s == 80 then EV_LightTurnOn(line, 0)
	elseif s == 81 then EV_LightTurnOn(line, 255)
	elseif s == 82 then P.EV_DoFloor(line, "lowerFloorToLowest")
	elseif s == 83 then P.EV_DoFloor(line, "lowerFloor")
	elseif s == 84 then P.EV_DoFloor(line, "lowerAndChange")
	elseif s == 86 then P.EV_DoDoor(line, "open")
	elseif s == 87 then EV_DoPlat(line, "perpetualRaise", 0)
	elseif s == 88 then EV_DoPlat(line, "downWaitUpStay", 0)
	elseif s == 89 then EV_StopPlat(line)
	elseif s == 90 then P.EV_DoDoor(line, "normal")
	elseif s == 91 then P.EV_DoFloor(line, "raiseFloor")
	elseif s == 92 then P.EV_DoFloor(line, "raiseFloor24")
	elseif s == 93 then P.EV_DoFloor(line, "raiseFloor24AndChange")
	elseif s == 94 then P.EV_DoFloor(line, "raiseFloorCrush")
	elseif s == 95 then EV_DoPlat(line, "raiseToNearestAndChange", 0)
	elseif s == 96 then P.EV_DoFloor(line, "raiseToTexture")
	elseif s == 97 then EV_Teleport(line, side, thing)
	elseif s == 98 then P.EV_DoFloor(line, "turboLower")
	elseif s == 105 then P.EV_DoDoor(line, "blazeRaise")
	elseif s == 106 then P.EV_DoDoor(line, "blazeOpen")
	elseif s == 107 then P.EV_DoDoor(line, "blazeClose")
	elseif s == 120 then EV_DoPlat(line, "blazeDWUS", 0)
	elseif s == 126 then
		if not thing.player then EV_Teleport(line, side, thing) end
	elseif s == 128 then P.EV_DoFloor(line, "raiseFloorToNearest")
	elseif s == 129 then P.EV_DoFloor(line, "raiseFloorTurbo")
	end
end

function P.ShootSpecialLine(thing, line)
	if not thing.player and line.special ~= 46 then return end
	local s = line.special
	if s == 24 then
		P.EV_DoFloor(line, "raiseFloor")
		ChangeSwitchTexture(line, false)
	elseif s == 46 then
		P.EV_DoDoor(line, "open")
		ChangeSwitchTexture(line, true)
	elseif s == 47 then
		EV_DoPlat(line, "raiseToNearestAndChange", 0)
		ChangeSwitchTexture(line, false)
	end
end

function P.UseSpecialLine(thing, line, side)
	if side ~= 0 then
		if line.special ~= 124 then return false end
	end
	if not thing.player then
		if band(line.flags, ML_SECRET) ~= 0 then return false end
		local s = line.special
		if not (s == 1 or s == 32 or s == 33 or s == 34) then return false end
	end
	local s = line.special
	local G = D.G
	local function sw(ok, again)
		if ok then ChangeSwitchTexture(line, again) end
	end
	if s == 1 or s == 26 or s == 27 or s == 28 or s == 31 or s == 32 or s == 33 or s == 34 or s == 117 or s == 118 then
		EV_VerticalDoor(line, thing)
	-- switches, once
	elseif s == 7 then sw(EV_BuildStairs(line, "build8"), false)
	elseif s == 9 then sw(EV_DoDonut(line), false)
	elseif s == 11 then ChangeSwitchTexture(line, false); G.ExitLevel()
	elseif s == 14 then sw(EV_DoPlat(line, "raiseAndChange", 32), false)
	elseif s == 15 then sw(EV_DoPlat(line, "raiseAndChange", 24), false)
	elseif s == 18 then sw(P.EV_DoFloor(line, "raiseFloorToNearest"), false)
	elseif s == 20 then sw(EV_DoPlat(line, "raiseToNearestAndChange", 0), false)
	elseif s == 21 then sw(EV_DoPlat(line, "downWaitUpStay", 0), false)
	elseif s == 23 then sw(P.EV_DoFloor(line, "lowerFloorToLowest"), false)
	elseif s == 29 then sw(P.EV_DoDoor(line, "normal"), false)
	elseif s == 41 then sw(EV_DoCeiling(line, "lowerToFloor"), false)
	elseif s == 71 then sw(P.EV_DoFloor(line, "turboLower"), false)
	elseif s == 49 then sw(EV_DoCeiling(line, "crushAndRaise"), false)
	elseif s == 50 then sw(P.EV_DoDoor(line, "close"), false)
	elseif s == 51 then ChangeSwitchTexture(line, false); G.SecretExitLevel()
	elseif s == 55 then sw(P.EV_DoFloor(line, "raiseFloorCrush"), false)
	elseif s == 101 then sw(P.EV_DoFloor(line, "raiseFloor"), false)
	elseif s == 102 then sw(P.EV_DoFloor(line, "lowerFloor"), false)
	elseif s == 103 then sw(P.EV_DoDoor(line, "open"), false)
	elseif s == 111 then sw(P.EV_DoDoor(line, "blazeRaise"), false)
	elseif s == 112 then sw(P.EV_DoDoor(line, "blazeOpen"), false)
	elseif s == 113 then sw(P.EV_DoDoor(line, "blazeClose"), false)
	elseif s == 122 then sw(EV_DoPlat(line, "blazeDWUS", 0), false)
	elseif s == 127 then sw(EV_BuildStairs(line, "turbo16"), false)
	elseif s == 131 then sw(P.EV_DoFloor(line, "raiseFloorTurbo"), false)
	elseif s == 133 or s == 135 or s == 137 then sw(EV_DoLockedDoor(line, "blazeOpen", thing), false)
	elseif s == 140 then sw(P.EV_DoFloor(line, "raiseFloor512"), false)
	-- buttons, repeatable
	elseif s == 42 then sw(P.EV_DoDoor(line, "close"), true)
	elseif s == 43 then sw(EV_DoCeiling(line, "lowerToFloor"), true)
	elseif s == 45 then sw(P.EV_DoFloor(line, "lowerFloor"), true)
	elseif s == 60 then sw(P.EV_DoFloor(line, "lowerFloorToLowest"), true)
	elseif s == 61 then sw(P.EV_DoDoor(line, "open"), true)
	elseif s == 62 then sw(EV_DoPlat(line, "downWaitUpStay", 1), true)
	elseif s == 63 then sw(P.EV_DoDoor(line, "normal"), true)
	elseif s == 64 then sw(P.EV_DoFloor(line, "raiseFloor"), true)
	elseif s == 66 then sw(EV_DoPlat(line, "raiseAndChange", 24), true)
	elseif s == 67 then sw(EV_DoPlat(line, "raiseAndChange", 32), true)
	elseif s == 65 then sw(P.EV_DoFloor(line, "raiseFloorCrush"), true)
	elseif s == 68 then sw(EV_DoPlat(line, "raiseToNearestAndChange", 0), true)
	elseif s == 69 then sw(P.EV_DoFloor(line, "raiseFloorToNearest"), true)
	elseif s == 70 then sw(P.EV_DoFloor(line, "turboLower"), true)
	elseif s == 114 then sw(P.EV_DoDoor(line, "blazeRaise"), true)
	elseif s == 115 then sw(P.EV_DoDoor(line, "blazeOpen"), true)
	elseif s == 116 then sw(P.EV_DoDoor(line, "blazeClose"), true)
	elseif s == 123 then sw(EV_DoPlat(line, "blazeDWUS", 0), true)
	elseif s == 132 then sw(P.EV_DoFloor(line, "raiseFloorTurbo"), true)
	elseif s == 99 or s == 134 or s == 136 then sw(EV_DoLockedDoor(line, "blazeOpen", thing), true)
	elseif s == 138 then EV_LightTurnOn(line, 255); ChangeSwitchTexture(line, true)
	elseif s == 139 then EV_LightTurnOn(line, 35); ChangeSwitchTexture(line, true)
	end
	return true
end

function P.PlayerInSpecialSector(player)
	local sector = player.mo.subsector.sector
	if player.mo.z ~= sector.floorheight then return end
	local s = sector.special
	local lt = P.leveltime
	local ironfeet = player.powers[D.pw_ironfeet] ~= 0
	if s == 5 then
		if not ironfeet and band(lt, 31) == 0 then P.DamageMobj(player.mo, nil, nil, 10) end
	elseif s == 7 then
		if not ironfeet and band(lt, 31) == 0 then P.DamageMobj(player.mo, nil, nil, 5) end
	elseif s == 16 or s == 4 then
		if not ironfeet or P_Random() < 5 then
			if band(lt, 31) == 0 then P.DamageMobj(player.mo, nil, nil, 20) end
		end
	elseif s == 9 then
		player.secretcount = player.secretcount + 1
		sector.special = 0
		player.message = "A secret is revealed!"
	elseif s == 11 then
		player.cheats = band(player.cheats, D.bnot(2))
		if band(lt, 31) == 0 then P.DamageMobj(player.mo, nil, nil, 20) end
		if player.health <= 10 then D.G.ExitLevel() end
	end
end

------------------------------------------------------------------------ animations
local anims = {}
local linespecials = {}

local animdefs = {
	{ false, "NUKAGE3", "NUKAGE1", 8 }, { false, "FWATER4", "FWATER1", 8 }, { false, "SWATER4", "SWATER1", 8 },
	{ false, "LAVA4", "LAVA1", 8 }, { false, "BLOOD3", "BLOOD1", 8 }, { false, "RROCK08", "RROCK05", 8 },
	{ false, "SLIME04", "SLIME01", 8 }, { false, "SLIME08", "SLIME05", 8 }, { false, "SLIME12", "SLIME09", 8 },
	{ true, "BLODGR4", "BLODGR1", 8 }, { true, "SLADRIP3", "SLADRIP1", 8 }, { true, "BLODRIP4", "BLODRIP1", 8 },
	{ true, "FIREWALL", "FIREWALA", 8 }, { true, "GSTFONT3", "GSTFONT1", 8 }, { true, "FIRELAVA", "FIRELAV3", 8 },
	{ true, "FIREMAG3", "FIREMAG1", 8 }, { true, "FIREBLU2", "FIREBLU1", 8 }, { true, "ROCKRED3", "ROCKRED1", 8 },
	{ true, "BFALL4", "BFALL1", 8 }, { true, "SFALL4", "SFALL1", 8 }, { true, "WFALL4", "WFALL1", 8 },
	{ true, "DBRAIN4", "DBRAIN1", 8 },
}

function P.InitPicAnims()
	anims = {}
	local texByIndex, flatByIndex = {}, {}
	for name, m in pairs(D.TEXTURES) do texByIndex[m[1]] = name end
	for name, idx in pairs(D.FLATS) do flatByIndex[idx] = name end
	for _, ad in ipairs(animdefs) do
		local istex, endname, startname, speed = ad[1], ad[2], ad[3], ad[4]
		local a, b
		if istex then
			a = D.TEXTURES[startname] and D.TEXTURES[startname][1]
			b = D.TEXTURES[endname] and D.TEXTURES[endname][1]
		else
			a, b = D.FLATS[startname], D.FLATS[endname]
		end
		if a and b and b > a then
			local names = {}
			for i = a, b do names[#names + 1] = istex and texByIndex[i] or flatByIndex[i] end
			anims[#anims + 1] = { istexture = istex, names = names, speed = speed }
		end
	end
end

function P.UpdateSpecials()
	local lt = P.leveltime
	for _, anim in ipairs(anims) do
		local n = #anim.names
		local trans = anim.istexture and R.texturetranslation or R.flattranslation
		for i = 1, n do
			local pic = anim.names[((floor(lt / anim.speed) + i - 1) % n) + 1]
			trans[anim.names[i]] = pic
		end
	end
	for _, line in ipairs(linespecials) do
		if line.special == 48 then
			local sd = L.sides[line.sidenum[0]]
			sd.textureoffset = sd.textureoffset + 1
		end
	end
	for i = #buttons, 1, -1 do
		local b = buttons[i]
		b.btimer = b.btimer - 1
		if b.btimer <= 0 then
			local sd = L.sides[b.line.sidenum[0]]
			if b.where == "top" then sd.toptexture = b.btexture
			elseif b.where == "middle" then sd.midtexture = b.btexture
			else sd.bottomtexture = b.btexture end
			S_StartSound(b.soundorg, SFX.swtchn)
			table.remove(buttons, i)
		end
	end
end

function P.SpawnSpecials()
	for k in pairs(R.texturetranslation) do R.texturetranslation[k] = nil end
	for k in pairs(R.flattranslation) do R.flattranslation[k] = nil end
	for i = 0, L.numsectors - 1 do
		local sector = L.sectors[i]
		local s = sector.special
		if s == 1 then SpawnLightFlash(sector)
		elseif s == 2 then SpawnStrobeFlash(sector, FASTDARK, 0)
		elseif s == 3 then SpawnStrobeFlash(sector, SLOWDARK, 0)
		elseif s == 4 then SpawnStrobeFlash(sector, FASTDARK, 0); sector.special = 4
		elseif s == 8 then SpawnGlowingLight(sector)
		elseif s == 9 then D.G.totalsecret = D.G.totalsecret + 1
		elseif s == 10 then SpawnDoorCloseIn30(sector)
		elseif s == 12 then SpawnStrobeFlash(sector, SLOWDARK, 1)
		elseif s == 13 then SpawnStrobeFlash(sector, FASTDARK, 1)
		elseif s == 14 then SpawnDoorRaiseIn5Mins(sector)
		elseif s == 17 then SpawnFireFlicker(sector)
		end
	end
	P.InitLineSpecials()
	activeplats = {}
	activeceilings = {}
	buttons = {}
end

function P.InitLineSpecials()
	for k in pairs(R.texturetranslation) do R.texturetranslation[k] = nil end
	for k in pairs(R.flattranslation) do R.flattranslation[k] = nil end
	linespecials = {}
	for i = 0, L.numlines - 1 do
		if L.lines[i].special == 48 then linespecials[#linespecials + 1] = L.lines[i] end
	end
end

------------------------------------------------------------------------ save game support
P.specialThinks = {
	door = T_VerticalDoor, floor = T_MoveFloor, plat = T_PlatRaise, ceiling = T_MoveCeiling,
	flicker = T_FireFlicker, flash = T_LightFlash, strobe = T_StrobeFlash, glow = T_Glow,
}

function P.GetSpecialLists()
	return activeplats, activeceilings, buttons
end

function P.SetSpecialLists(plats, ceilings, btns)
	activeplats, activeceilings, buttons = plats, ceilings, btns
end
