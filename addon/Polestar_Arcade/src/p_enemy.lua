-- Monster AI and monster action functions (p_enemy.c)
local D = FreedoomArcade
local P = D.P
local A = D.actions

local floor, abs = math.floor, math.abs
local band, bor, bnot = D.band, D.bor, D.bnot
local P_Random = D.P_Random
local finesine, finecosine = D.finesine, D.finecosine
local ANGMAX, ANG90, ANG180, ANG270 = D.ANGMAX, D.ANG90, D.ANG180, D.ANG270
local MF = D.MF
local MT, S, SFX = D.MT, D.S, D.SFX
local mobjinfo = D.mobjinfo
local L = D.level

local DI_EAST, DI_NORTHEAST, DI_NORTH, DI_NORTHWEST = 0, 1, 2, 3
local DI_WEST, DI_SOUTHWEST, DI_SOUTH, DI_SOUTHEAST, DI_NODIR = 4, 5, 6, 7, 8
P.DI_NODIR = DI_NODIR

local opposite = { [0] = DI_WEST, DI_SOUTHWEST, DI_SOUTH, DI_SOUTHEAST, DI_EAST, DI_NORTHEAST, DI_NORTH, DI_NORTHWEST, DI_NODIR }
local diags = { [0] = DI_NORTHWEST, DI_NORTHEAST, DI_SOUTHWEST, DI_SOUTHEAST }
local XS = 47000 / 65536
local xspeed = { [0] = 1, XS, 0, -XS, -1, -XS, 0, XS }
local yspeed = { [0] = 0, XS, 1, XS, 0, -XS, -1, -XS }

local function S_StartSound(o, s) if D.S_StartSound then D.S_StartSound(o, s) end end
local SetMobjState = P.SetMobjState

------------------------------------------------------------------------ sound propagation
local soundtarget
local function RecursiveSound(sec, soundblocks)
	if sec.validcount == P.validcount and sec.soundtraversed <= soundblocks + 1 then return end
	sec.validcount = P.validcount
	sec.soundtraversed = soundblocks + 1
	sec.soundtarget = soundtarget
	local sides = L.sides
	for _, check in ipairs(sec.lines) do
		if band(check.flags, 4) ~= 0 then
			P.LineOpening(check)
			if P.openrange > 0 then
				local other
				if sides[check.sidenum[0]].sector == sec then
					other = sides[check.sidenum[1]].sector
				else
					other = sides[check.sidenum[0]].sector
				end
				if band(check.flags, 64) ~= 0 then
					if soundblocks == 0 then RecursiveSound(other, 1) end
				else
					RecursiveSound(other, soundblocks)
				end
			end
		end
	end
end

function P.NoiseAlert(target, emitter)
	soundtarget = target
	P.validcount = P.validcount + 1
	RecursiveSound(emitter.subsector.sector, 0)
end

------------------------------------------------------------------------ checks
local function CheckMeleeRange(actor)
	local pl = actor.target
	if not pl then return false end
	local dist = D.AproxDistance(pl.x - actor.x, pl.y - actor.y)
	if dist >= P.MELEERANGE - 20 + pl.info.radius then return false end
	if not P.CheckSight(actor, pl) then return false end
	return true
end
P.CheckMeleeRange = CheckMeleeRange

local function CheckMissileRange(actor)
	if not P.CheckSight(actor, actor.target) then return false end
	if band(actor.flags, MF.JUSTHIT) ~= 0 then
		actor.flags = band(actor.flags, bnot(MF.JUSTHIT))
		return true
	end
	if actor.reactiontime ~= 0 then return false end
	local dist = D.AproxDistance(actor.x - actor.target.x, actor.y - actor.target.y) - 64
	if actor.info.meleestate == 0 then dist = dist - 128 end
	dist = floor(dist)
	if actor.type == MT.MT_VILE then
		if dist > 14 * 64 then return false end
	end
	if actor.type == MT.MT_UNDEAD then
		if dist < 196 then return false end
		dist = floor(dist / 2)
	end
	if actor.type == MT.MT_CYBORG or actor.type == MT.MT_SPIDER or actor.type == MT.MT_SKULL then
		dist = floor(dist / 2)
	end
	if dist > 200 then dist = 200 end
	if actor.type == MT.MT_CYBORG and dist > 160 then dist = 160 end
	if P_Random() < dist then return false end
	return true
end

local function Move(actor)
	if actor.movedir == DI_NODIR then return false end
	local tryx = actor.x + actor.info.speed * xspeed[actor.movedir]
	local tryy = actor.y + actor.info.speed * yspeed[actor.movedir]
	local ok = P.TryMove(actor, tryx, tryy)
	if not ok then
		if band(actor.flags, MF.FLOAT) ~= 0 and P.floatok then
			if actor.z < P.tmfloorz then
				actor.z = actor.z + P.FLOATSPEED
			else
				actor.z = actor.z - P.FLOATSPEED
			end
			actor.flags = bor(actor.flags, MF.INFLOAT)
			return true
		end
		local hits = P.GetSpecHits()
		if #hits == 0 then return false end
		actor.movedir = DI_NODIR
		local good = false
		for i = #hits, 1, -1 do
			if P.UseSpecialLine(actor, hits[i], 0) then good = true end
		end
		return good
	else
		actor.flags = band(actor.flags, bnot(MF.INFLOAT))
	end
	if band(actor.flags, MF.FLOAT) == 0 then actor.z = actor.floorz end
	return true
end

local function TryWalk(actor)
	if not Move(actor) then return false end
	actor.movecount = band(P_Random(), 15)
	return true
end

local function NewChaseDir(actor)
	local olddir = actor.movedir
	local turnaround = opposite[olddir]
	local deltax = actor.target.x - actor.x
	local deltay = actor.target.y - actor.y
	local d1, d2
	if deltax > 10 then d1 = DI_EAST elseif deltax < -10 then d1 = DI_WEST else d1 = DI_NODIR end
	if deltay < -10 then d2 = DI_SOUTH elseif deltay > 10 then d2 = DI_NORTH else d2 = DI_NODIR end
	if d1 ~= DI_NODIR and d2 ~= DI_NODIR then
		actor.movedir = diags[(deltay < 0 and 2 or 0) + (deltax > 0 and 1 or 0)]
		if actor.movedir ~= turnaround and TryWalk(actor) then return end
	end
	if P_Random() > 200 or abs(deltay) > abs(deltax) then
		d1, d2 = d2, d1
	end
	if d1 == turnaround then d1 = DI_NODIR end
	if d2 == turnaround then d2 = DI_NODIR end
	if d1 ~= DI_NODIR then
		actor.movedir = d1
		if TryWalk(actor) then return end
	end
	if d2 ~= DI_NODIR then
		actor.movedir = d2
		if TryWalk(actor) then return end
	end
	if olddir ~= DI_NODIR then
		actor.movedir = olddir
		if TryWalk(actor) then return end
	end
	if band(P_Random(), 1) ~= 0 then
		for tdir = DI_EAST, DI_SOUTHEAST do
			if tdir ~= turnaround then
				actor.movedir = tdir
				if TryWalk(actor) then return end
			end
		end
	else
		for tdir = DI_SOUTHEAST, DI_EAST, -1 do
			if tdir ~= turnaround then
				actor.movedir = tdir
				if TryWalk(actor) then return end
			end
		end
	end
	if turnaround ~= DI_NODIR then
		actor.movedir = turnaround
		if TryWalk(actor) then return end
	end
	actor.movedir = DI_NODIR
end

local function LookForPlayers(actor, allaround)
	local player = D.G.player
	if not player or not player.mo then return false end
	if player.health <= 0 then return false end
	if not P.CheckSight(actor, player.mo) then return false end
	if not allaround then
		local an = (D.PointToAngle2(actor.x, actor.y, player.mo.x, player.mo.y) - actor.angle) % ANGMAX
		if an > ANG90 and an < ANG270 then
			local dist = D.AproxDistance(player.mo.x - actor.x, player.mo.y - actor.y)
			if dist > P.MELEERANGE then return false end
		end
	end
	actor.target = player.mo
	return true
end
P.LookForPlayers = LookForPlayers

------------------------------------------------------------------------ actions
function A.A_Fall(actor)
	actor.flags = band(actor.flags, bnot(MF.SOLID))
end

function A.A_KeenDie(mo)
	A.A_Fall(mo)
	for _, th in ipairs(P.thinkers) do
		if not th.removed and th.think == P.MobjThinker and th ~= mo and th.type == mo.type and th.health > 0 then
			return
		end
	end
	P.EV_DoDoor({ tag = 666 }, "open")
end

function A.A_Look(actor)
	actor.threshold = 0
	local targ = actor.subsector.sector.soundtarget
	local see = false
	if targ and band(targ.flags, MF.SHOOTABLE) ~= 0 then
		actor.target = targ
		if band(actor.flags, MF.AMBUSH) ~= 0 then
			if P.CheckSight(actor, actor.target) then see = true end
		else
			see = true
		end
	end
	if not see then
		if not LookForPlayers(actor, false) then return end
	end
	local ss = actor.info.seesound
	if ss ~= 0 then
		local sound
		if ss == SFX.posit1 or ss == SFX.posit2 or ss == SFX.posit3 then
			sound = SFX.posit1 + P_Random() % 3
		elseif ss == SFX.bgsit1 or ss == SFX.bgsit2 then
			sound = SFX.bgsit1 + P_Random() % 2
		else
			sound = ss
		end
		if actor.type == MT.MT_SPIDER or actor.type == MT.MT_CYBORG then
			S_StartSound(nil, sound)
		else
			S_StartSound(actor, sound)
		end
	end
	SetMobjState(actor, actor.info.seestate)
end

function A.A_Chase(actor)
	if actor.reactiontime ~= 0 then actor.reactiontime = actor.reactiontime - 1 end
	if actor.threshold ~= 0 then
		if not actor.target or actor.target.health <= 0 then
			actor.threshold = 0
		else
			actor.threshold = actor.threshold - 1
		end
	end
	if actor.movedir < 8 then
		actor.angle = actor.angle - actor.angle % 536870912
		local delta = (actor.angle - actor.movedir * 536870912) % ANGMAX
		if delta ~= 0 then
			if delta < 2147483648 then
				actor.angle = (actor.angle - D.ANG45) % ANGMAX
			else
				actor.angle = (actor.angle + D.ANG45) % ANGMAX
			end
		end
	end
	if not actor.target or band(actor.target.flags, MF.SHOOTABLE) == 0 then
		if LookForPlayers(actor, true) then return end
		SetMobjState(actor, actor.info.spawnstate)
		return
	end
	if band(actor.flags, MF.JUSTATTACKED) ~= 0 then
		actor.flags = band(actor.flags, bnot(MF.JUSTATTACKED))
		if D.G.gameskill ~= 4 then NewChaseDir(actor) end
		return
	end
	if actor.info.meleestate ~= 0 and CheckMeleeRange(actor) then
		if actor.info.attacksound ~= 0 then S_StartSound(actor, actor.info.attacksound) end
		SetMobjState(actor, actor.info.meleestate)
		return
	end
	if actor.info.missilestate ~= 0 then
		local skip = D.G.gameskill < 4 and actor.movecount ~= 0
		if not skip and CheckMissileRange(actor) then
			SetMobjState(actor, actor.info.missilestate)
			actor.flags = bor(actor.flags, MF.JUSTATTACKED)
			return
		end
	end
	actor.movecount = actor.movecount - 1
	if actor.movecount < 0 or not Move(actor) then
		NewChaseDir(actor)
	end
	if actor.info.activesound ~= 0 and P_Random() < 3 then
		S_StartSound(actor, actor.info.activesound)
	end
end

function A.A_FaceTarget(actor)
	if not actor.target then return end
	actor.flags = band(actor.flags, bnot(MF.AMBUSH))
	actor.angle = D.PointToAngle2(actor.x, actor.y, actor.target.x, actor.target.y)
	if band(actor.target.flags, MF.SHADOW) ~= 0 then
		actor.angle = (actor.angle + (P_Random() - P_Random()) * 2097152) % ANGMAX
	end
end
local A_FaceTarget = A.A_FaceTarget

function A.A_PosAttack(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	local angle = actor.angle
	local slope = P.AimLineAttack(actor, angle, P.MISSILERANGE)
	S_StartSound(actor, SFX.pistol)
	angle = angle + (P_Random() - P_Random()) * 1048576
	local damage = ((P_Random() % 5) + 1) * 3
	P.LineAttack(actor, angle, P.MISSILERANGE, slope, damage)
end

function A.A_SPosAttack(actor)
	if not actor.target then return end
	S_StartSound(actor, SFX.shotgn)
	A_FaceTarget(actor)
	local bangle = actor.angle
	local slope = P.AimLineAttack(actor, bangle, P.MISSILERANGE)
	for _ = 1, 3 do
		local angle = bangle + (P_Random() - P_Random()) * 1048576
		local damage = ((P_Random() % 5) + 1) * 3
		P.LineAttack(actor, angle, P.MISSILERANGE, slope, damage)
	end
end

function A.A_CPosAttack(actor)
	if not actor.target then return end
	S_StartSound(actor, SFX.shotgn)
	A_FaceTarget(actor)
	local bangle = actor.angle
	local slope = P.AimLineAttack(actor, bangle, P.MISSILERANGE)
	local angle = bangle + (P_Random() - P_Random()) * 1048576
	local damage = ((P_Random() % 5) + 1) * 3
	P.LineAttack(actor, angle, P.MISSILERANGE, slope, damage)
end

function A.A_CPosRefire(actor)
	A_FaceTarget(actor)
	if P_Random() < 40 then return end
	if not actor.target or actor.target.health <= 0 or not P.CheckSight(actor, actor.target) then
		SetMobjState(actor, actor.info.seestate)
	end
end

function A.A_SpidRefire(actor)
	A_FaceTarget(actor)
	if P_Random() < 10 then return end
	if not actor.target or actor.target.health <= 0 or not P.CheckSight(actor, actor.target) then
		SetMobjState(actor, actor.info.seestate)
	end
end

function A.A_BspiAttack(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	P.SpawnMissile(actor, actor.target, MT.MT_ARACHPLAZ)
end

function A.A_TroopAttack(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	if CheckMeleeRange(actor) then
		S_StartSound(actor, SFX.claw)
		local damage = (P_Random() % 8 + 1) * 3
		P.DamageMobj(actor.target, actor, actor, damage)
		return
	end
	P.SpawnMissile(actor, actor.target, MT.MT_TROOPSHOT)
end

function A.A_SargAttack(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	if CheckMeleeRange(actor) then
		local damage = ((P_Random() % 10) + 1) * 4
		P.DamageMobj(actor.target, actor, actor, damage)
	end
end

function A.A_HeadAttack(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	if CheckMeleeRange(actor) then
		local damage = (P_Random() % 6 + 1) * 10
		P.DamageMobj(actor.target, actor, actor, damage)
		return
	end
	P.SpawnMissile(actor, actor.target, MT.MT_HEADSHOT)
end

function A.A_CyberAttack(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	P.SpawnMissile(actor, actor.target, MT.MT_ROCKET)
end

function A.A_BruisAttack(actor)
	if not actor.target then return end
	if CheckMeleeRange(actor) then
		S_StartSound(actor, SFX.claw)
		local damage = (P_Random() % 8 + 1) * 10
		P.DamageMobj(actor.target, actor, actor, damage)
		return
	end
	P.SpawnMissile(actor, actor.target, MT.MT_BRUISERSHOT)
end

function A.A_SkelMissile(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	actor.z = actor.z + 16
	local mo = P.SpawnMissile(actor, actor.target, MT.MT_TRACER)
	actor.z = actor.z - 16
	mo.x = mo.x + mo.momx
	mo.y = mo.y + mo.momy
	mo.tracer = actor.target
end

local TRACEANGLE = 0xc000000
function A.A_Tracer(actor)
	if band(D.G.gametic, 3) ~= 0 then return end
	P.SpawnPuff(actor.x, actor.y, actor.z)
	local th = P.SpawnMobj(actor.x - actor.momx, actor.y - actor.momy, actor.z, MT.MT_SMOKE)
	th.momz = 1
	th.tics = th.tics - band(P_Random(), 3)
	if th.tics < 1 then th.tics = 1 end
	local dest = actor.tracer
	if not dest or dest.health <= 0 then return end
	local exact = D.PointToAngle2(actor.x, actor.y, dest.x, dest.y)
	if exact ~= actor.angle then
		if (exact - actor.angle) % ANGMAX > 0x80000000 then
			actor.angle = (actor.angle - TRACEANGLE) % ANGMAX
			if (exact - actor.angle) % ANGMAX < 0x80000000 then actor.angle = exact end
		else
			actor.angle = (actor.angle + TRACEANGLE) % ANGMAX
			if (exact - actor.angle) % ANGMAX > 0x80000000 then actor.angle = exact end
		end
	end
	local fa = floor(actor.angle / 524288)
	actor.momx = actor.info.speed * finecosine[fa]
	actor.momy = actor.info.speed * finesine[fa]
	local dist = D.AproxDistance(dest.x - actor.x, dest.y - actor.y)
	dist = floor(dist / actor.info.speed)
	if dist < 1 then dist = 1 end
	local slope = (dest.z + 40 - actor.z) / dist
	if slope < actor.momz then
		actor.momz = actor.momz - 0.125
	else
		actor.momz = actor.momz + 0.125
	end
end

function A.A_SkelWhoosh(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	S_StartSound(actor, SFX.skeswg)
end

function A.A_SkelFist(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	if CheckMeleeRange(actor) then
		local damage = ((P_Random() % 10) + 1) * 6
		S_StartSound(actor, SFX.skepch)
		P.DamageMobj(actor.target, actor, actor, damage)
	end
end

-- arch-vile
local corpsehit, viletryx, viletryy
local function PIT_VileCheck(thing)
	if band(thing.flags, MF.CORPSE) == 0 then return true end
	if thing.tics ~= -1 then return true end
	if thing.info.raisestate == 0 then return true end
	local maxdist = thing.info.radius + mobjinfo[MT.MT_VILE].radius
	if abs(thing.x - viletryx) > maxdist or abs(thing.y - viletryy) > maxdist then return true end
	corpsehit = thing
	corpsehit.momx, corpsehit.momy = 0, 0
	corpsehit.height = corpsehit.height * 4
	local check = P.CheckPosition(corpsehit, corpsehit.x, corpsehit.y)
	corpsehit.height = corpsehit.height / 4
	if not check then return true end
	return false
end

function A.A_VileChase(actor)
	if actor.movedir ~= DI_NODIR then
		viletryx = actor.x + actor.info.speed * xspeed[actor.movedir]
		viletryy = actor.y + actor.info.speed * yspeed[actor.movedir]
		local xl = floor((viletryx - L.bmaporgx - 64) / 128)
		local xh = floor((viletryx - L.bmaporgx + 64) / 128)
		local yl = floor((viletryy - L.bmaporgy - 64) / 128)
		local yh = floor((viletryy - L.bmaporgy + 64) / 128)
		for bx = xl, xh do
			for by = yl, yh do
				if not P.BlockThingsIterator(bx, by, PIT_VileCheck) then
					local temp = actor.target
					actor.target = corpsehit
					A_FaceTarget(actor)
					actor.target = temp
					SetMobjState(actor, S.S_VILE_HEAL1)
					S_StartSound(corpsehit, SFX.slop)
					local info = corpsehit.info
					SetMobjState(corpsehit, info.raisestate)
					corpsehit.height = corpsehit.height * 4
					corpsehit.flags = info.flags
					corpsehit.health = info.spawnhealth
					corpsehit.target = nil
					return
				end
			end
		end
	end
	A.A_Chase(actor)
end

function A.A_VileStart(actor) S_StartSound(actor, SFX.vilatk) end

function A.A_Fire(actor)
	local dest = actor.tracer
	if not dest then return end
	if not actor.target or not P.CheckSight(actor.target, dest) then return end
	local an = floor(dest.angle / 524288)
	P.UnsetThingPosition(actor)
	actor.x = dest.x + 24 * finecosine[an]
	actor.y = dest.y + 24 * finesine[an]
	actor.z = dest.z
	P.SetThingPosition(actor)
end
function A.A_StartFire(actor) S_StartSound(actor, SFX.flamst); A.A_Fire(actor) end
function A.A_FireCrackle(actor) S_StartSound(actor, SFX.flame); A.A_Fire(actor) end

function A.A_VileTarget(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	local fog = P.SpawnMobj(actor.target.x, actor.target.x, actor.target.z, MT.MT_FIRE)
	actor.tracer = fog
	fog.target = actor
	fog.tracer = actor.target
	A.A_Fire(fog)
end

function A.A_VileAttack(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	if not P.CheckSight(actor, actor.target) then return end
	S_StartSound(actor, SFX.barexp)
	P.DamageMobj(actor.target, actor, actor, 20)
	actor.target.momz = 1000 / actor.target.info.mass
	local an = floor(actor.angle / 524288)
	local fire = actor.tracer
	if not fire then return end
	fire.x = actor.target.x - 24 * finecosine[an]
	fire.y = actor.target.y - 24 * finesine[an]
	P.RadiusAttack(fire, actor, 70)
end

-- mancubus
local FATSPREAD = ANG90 / 8
local function setMissileMom(mo)
	local an = floor(mo.angle / 524288)
	mo.momx = mo.info.speed * finecosine[an]
	mo.momy = mo.info.speed * finesine[an]
end
function A.A_FatRaise(actor) A_FaceTarget(actor); S_StartSound(actor, SFX.manatk) end
function A.A_FatAttack1(actor)
	A_FaceTarget(actor)
	actor.angle = (actor.angle + FATSPREAD) % ANGMAX
	P.SpawnMissile(actor, actor.target, MT.MT_FATSHOT)
	local mo = P.SpawnMissile(actor, actor.target, MT.MT_FATSHOT)
	mo.angle = (mo.angle + FATSPREAD) % ANGMAX
	setMissileMom(mo)
end
function A.A_FatAttack2(actor)
	A_FaceTarget(actor)
	actor.angle = (actor.angle - FATSPREAD) % ANGMAX
	P.SpawnMissile(actor, actor.target, MT.MT_FATSHOT)
	local mo = P.SpawnMissile(actor, actor.target, MT.MT_FATSHOT)
	mo.angle = (mo.angle - FATSPREAD * 2) % ANGMAX
	setMissileMom(mo)
end
function A.A_FatAttack3(actor)
	A_FaceTarget(actor)
	local mo = P.SpawnMissile(actor, actor.target, MT.MT_FATSHOT)
	mo.angle = (mo.angle - FATSPREAD / 2) % ANGMAX
	setMissileMom(mo)
	mo = P.SpawnMissile(actor, actor.target, MT.MT_FATSHOT)
	mo.angle = (mo.angle + FATSPREAD / 2) % ANGMAX
	setMissileMom(mo)
end

-- lost soul
local SKULLSPEED = 20
function A.A_SkullAttack(actor)
	if not actor.target then return end
	local dest = actor.target
	actor.flags = bor(actor.flags, MF.SKULLFLY)
	S_StartSound(actor, actor.info.attacksound)
	A_FaceTarget(actor)
	local an = floor(actor.angle / 524288)
	actor.momx = SKULLSPEED * finecosine[an]
	actor.momy = SKULLSPEED * finesine[an]
	local dist = D.AproxDistance(dest.x - actor.x, dest.y - actor.y)
	dist = floor(dist / SKULLSPEED)
	if dist < 1 then dist = 1 end
	actor.momz = (dest.z + dest.height / 2 - actor.z) / dist
end

local function PainShootSkull(actor, angle)
	local count = 0
	for _, th in ipairs(P.thinkers) do
		if not th.removed and th.think == P.MobjThinker and th.type == MT.MT_SKULL then count = count + 1 end
	end
	if count > 20 then return end
	local an = floor((angle % ANGMAX) / 524288)
	local prestep = 4 + 3 * (actor.info.radius + mobjinfo[MT.MT_SKULL].radius) / 2
	local x = actor.x + prestep * finecosine[an]
	local y = actor.y + prestep * finesine[an]
	local z = actor.z + 8
	local newmobj = P.SpawnMobj(x, y, z, MT.MT_SKULL)
	if not P.TryMove(newmobj, newmobj.x, newmobj.y) then
		P.DamageMobj(newmobj, actor, actor, 10000)
		return
	end
	newmobj.target = actor.target
	A.A_SkullAttack(newmobj)
end
function A.A_PainAttack(actor)
	if not actor.target then return end
	A_FaceTarget(actor)
	PainShootSkull(actor, actor.angle)
end
function A.A_PainDie(actor)
	A.A_Fall(actor)
	PainShootSkull(actor, actor.angle + ANG90)
	PainShootSkull(actor, actor.angle + ANG180)
	PainShootSkull(actor, actor.angle + ANG270)
end

function A.A_Scream(actor)
	local ds = actor.info.deathsound
	if ds == 0 then return end
	local sound
	if ds == SFX.podth1 or ds == SFX.podth2 or ds == SFX.podth3 then
		sound = SFX.podth1 + P_Random() % 3
	elseif ds == SFX.bgdth1 or ds == SFX.bgdth2 then
		sound = SFX.bgdth1 + P_Random() % 2
	else
		sound = ds
	end
	if actor.type == MT.MT_SPIDER or actor.type == MT.MT_CYBORG then
		S_StartSound(nil, sound)
	else
		S_StartSound(actor, sound)
	end
end
function A.A_XScream(actor) S_StartSound(actor, SFX.slop) end
function A.A_Pain(actor)
	if actor.info.painsound ~= 0 then S_StartSound(actor, actor.info.painsound) end
end
function A.A_Explode(thingy) P.RadiusAttack(thingy, thingy.target, 128) end

function A.A_BossDeath(mo)
	local G = D.G
	local ep, map = G.gameepisode, G.gamemap
	if ep == 1 then
		if map ~= 8 or mo.type ~= MT.MT_BRUISER then return end
	elseif ep == 2 then
		if map ~= 8 or mo.type ~= MT.MT_CYBORG then return end
	elseif ep == 3 then
		if map ~= 8 or mo.type ~= MT.MT_SPIDER then return end
	elseif ep == 4 then
		if map == 6 then
			if mo.type ~= MT.MT_CYBORG then return end
		elseif map == 8 then
			if mo.type ~= MT.MT_SPIDER then return end
		else
			return
		end
	else
		if map ~= 8 then return end
	end
	if G.player.health <= 0 then return end
	for _, th in ipairs(P.thinkers) do
		if not th.removed and th.think == P.MobjThinker and th ~= mo and th.type == mo.type and th.health > 0 then
			return
		end
	end
	if ep == 1 then
		P.EV_DoFloor({ tag = 666 }, "lowerFloorToLowest")
		return
	elseif ep == 4 then
		if map == 6 then
			P.EV_DoDoor({ tag = 666 }, "blazeOpen")
			return
		elseif map == 8 then
			P.EV_DoFloor({ tag = 666 }, "lowerFloorToLowest")
			return
		end
	end
	G.ExitLevel()
end

function A.A_Hoof(mo) S_StartSound(mo, SFX.hoof); A.A_Chase(mo) end
function A.A_Metal(mo) S_StartSound(mo, SFX.metal); A.A_Chase(mo) end
function A.A_BabyMetal(mo) S_StartSound(mo, SFX.bspwlk); A.A_Chase(mo) end

-- boss brain (Doom II only; kept so states never reference a missing action)
local braintargets, braintargeton = {}, 0
function A.A_BrainAwake(mo)
	braintargets = {}
	braintargeton = 0
	for _, th in ipairs(P.thinkers) do
		if not th.removed and th.think == P.MobjThinker and th.type == MT.MT_BOSSTARGET then
			braintargets[#braintargets + 1] = th
		end
	end
	S_StartSound(nil, SFX.bossit)
end
function A.A_BrainPain(mo) S_StartSound(nil, SFX.bospn) end
function A.A_BrainScream(mo)
	for x = mo.x - 196, mo.x + 320 - 1, 8 do
		local th = P.SpawnMobj(x, mo.y - 320, 128 + P_Random() * 2, MT.MT_ROCKET)
		th.momz = P_Random() * 512 / 65536
		SetMobjState(th, S.S_BRAINEXPLODE1)
		th.tics = th.tics - band(P_Random(), 7)
		if th.tics < 1 then th.tics = 1 end
	end
	S_StartSound(nil, SFX.bosdth)
end
function A.A_BrainExplode(mo)
	local th = P.SpawnMobj(mo.x + (P_Random() - P_Random()) * 2048 / 65536, mo.y, 128 + P_Random() * 2, MT.MT_ROCKET)
	th.momz = P_Random() * 512 / 65536
	SetMobjState(th, S.S_BRAINEXPLODE1)
	th.tics = th.tics - band(P_Random(), 7)
	if th.tics < 1 then th.tics = 1 end
end
function A.A_BrainDie(mo) D.G.ExitLevel() end
local easy = 0
function A.A_BrainSpit(mo)
	easy = 1 - easy
	if D.G.gameskill <= 1 and easy == 0 then return end
	if #braintargets == 0 then return end
	local targ = braintargets[braintargeton + 1]
	braintargeton = (braintargeton + 1) % #braintargets
	local newmobj = P.SpawnMissile(mo, targ, MT.MT_SPAWNSHOT)
	newmobj.target = targ
	if newmobj.momy ~= 0 and newmobj.state[3] ~= 0 then
		newmobj.reactiontime = floor(((targ.y - mo.y) / newmobj.momy) / newmobj.state[3])
	end
	S_StartSound(nil, SFX.bospit)
end
function A.A_SpawnFly(mo)
	mo.reactiontime = mo.reactiontime - 1
	if mo.reactiontime ~= 0 then return end
	local targ = mo.target
	local fog = P.SpawnMobj(targ.x, targ.y, targ.z, MT.MT_SPAWNFIRE)
	S_StartSound(fog, SFX.telept)
	local r = P_Random()
	local t
	if r < 50 then t = MT.MT_TROOP elseif r < 90 then t = MT.MT_SERGEANT elseif r < 120 then t = MT.MT_SHADOWS
	elseif r < 130 then t = MT.MT_PAIN elseif r < 160 then t = MT.MT_HEAD elseif r < 162 then t = MT.MT_VILE
	elseif r < 172 then t = MT.MT_UNDEAD elseif r < 192 then t = MT.MT_BABY elseif r < 222 then t = MT.MT_FATSO
	elseif r < 246 then t = MT.MT_KNIGHT else t = MT.MT_BRUISER end
	local newmobj = P.SpawnMobj(targ.x, targ.y, targ.z, t)
	if LookForPlayers(newmobj, true) then SetMobjState(newmobj, newmobj.info.seestate) end
	P.TeleportMove(newmobj, newmobj.x, newmobj.y)
	P.RemoveMobj(mo)
end
function A.A_SpawnSound(mo) S_StartSound(mo, SFX.boscub); A.A_SpawnFly(mo) end

function A.A_PlayerScream(mo)
	S_StartSound(mo, SFX.pldeth)
end
