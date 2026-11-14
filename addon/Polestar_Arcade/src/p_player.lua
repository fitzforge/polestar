-- Player: pickups & damage (p_inter.c), weapons (p_pspr.c), movement (p_user.c)
local D = FreedoomArcade
local P = D.P
local A = D.actions
local PA = {}
D.pactions = PA

local floor, abs = math.floor, math.abs
local band, bor, bnot = D.band, D.bor, D.bnot
local P_Random = D.P_Random
local finesine, finecosine = D.finesine, D.finecosine
local ANGMAX, ANG90, ANG180 = D.ANGMAX, D.ANG90, D.ANG180
local MF = D.MF
local MT, S, SFX = D.MT, D.S, D.SFX
local states = D.states
local SetMobjState = P.SetMobjState

local function S_StartSound(o, s) if D.S_StartSound then D.S_StartSound(o, s) end end

-- enums
local wp_fist, wp_pistol, wp_shotgun, wp_chaingun, wp_missile, wp_plasma, wp_bfg, wp_chainsaw, wp_supershotgun = 0, 1, 2, 3, 4, 5, 6, 7, 8
local wp_nochange = 10
local am_clip, am_shell, am_cell, am_misl, am_noammo = 0, 1, 2, 3, 5
local pw_invulnerability, pw_strength, pw_invisibility, pw_ironfeet, pw_allmap, pw_infrared = 0, 1, 2, 3, 4, 5
D.wp_nochange = wp_nochange
D.pw_invulnerability, D.pw_strength, D.pw_invisibility, D.pw_ironfeet, D.pw_allmap, D.pw_infrared = 0, 1, 2, 3, 4, 5

local BT_ATTACK, BT_USE, BT_CHANGE = 1, 2, 4
D.BT_ATTACK, D.BT_USE, D.BT_CHANGE = BT_ATTACK, BT_USE, BT_CHANGE

local MAXHEALTH = 100
local BONUSADD = 6
local BASETHRESHOLD = 100

-- {ammo, upstate, downstate, readystate, atkstate, flashstate}
local weaponinfo = {
	[0] = { am_noammo, S.S_PUNCHUP, S.S_PUNCHDOWN, S.S_PUNCH, S.S_PUNCH1, 0 },
	{ am_clip, S.S_PISTOLUP, S.S_PISTOLDOWN, S.S_PISTOL, S.S_PISTOL1, S.S_PISTOLFLASH },
	{ am_shell, S.S_SGUNUP, S.S_SGUNDOWN, S.S_SGUN, S.S_SGUN1, S.S_SGUNFLASH1 },
	{ am_clip, S.S_CHAINUP, S.S_CHAINDOWN, S.S_CHAIN, S.S_CHAIN1, S.S_CHAINFLASH1 },
	{ am_misl, S.S_MISSILEUP, S.S_MISSILEDOWN, S.S_MISSILE, S.S_MISSILE1, S.S_MISSILEFLASH1 },
	{ am_cell, S.S_PLASMAUP, S.S_PLASMADOWN, S.S_PLASMA, S.S_PLASMA1, S.S_PLASMAFLASH1 },
	{ am_cell, S.S_BFGUP, S.S_BFGDOWN, S.S_BFG, S.S_BFG1, S.S_BFGFLASH1 },
	{ am_noammo, S.S_SAWUP, S.S_SAWDOWN, S.S_SAW, S.S_SAW1, 0 },
	{ am_shell, S.S_DSGUNUP, S.S_DSGUNDOWN, S.S_DSGUN, S.S_DSGUN1, S.S_DSGUNFLASH1 },
}
D.weaponinfo = weaponinfo

local clipammo = { [0] = 10, 4, 20, 1 }
D.maxammo = { [0] = 200, 50, 300, 50 }

------------------------------------------------------------------------ messages (d_englsh.h)
local MSG = {
	GOTARMOR = "Picked up the armor.", GOTMEGA = "Picked up the MegaArmor!",
	GOTHTHBONUS = "Picked up a health bonus.", GOTARMBONUS = "Picked up an armor bonus.",
	GOTSTIM = "Picked up a stimpack.", GOTMEDINEED = "Picked up a medikit that you REALLY need!",
	GOTMEDIKIT = "Picked up a medikit.", GOTSUPER = "Supercharge!",
	GOTBLUECARD = "Picked up a blue keycard.", GOTYELWCARD = "Picked up a yellow keycard.",
	GOTREDCARD = "Picked up a red keycard.", GOTBLUESKUL = "Picked up a blue skull key.",
	GOTYELWSKUL = "Picked up a yellow skull key.", GOTREDSKULL = "Picked up a red skull key.",
	GOTINVUL = "Invulnerability!", GOTBERSERK = "Berserk!", GOTINVIS = "Partial Invisibility",
	GOTSUIT = "Radiation Shielding Suit", GOTMAP = "Computer Area Map", GOTVISOR = "Light Amplification Visor",
	GOTMSPHERE = "MegaSphere!", GOTCLIP = "Picked up a clip.", GOTCLIPBOX = "Picked up a box of bullets.",
	GOTROCKET = "Picked up a rocket.", GOTROCKBOX = "Picked up a box of rockets.",
	GOTCELL = "Picked up an energy cell.", GOTCELLBOX = "Picked up an energy cell pack.",
	GOTSHELLS = "Picked up 4 shotgun shells.", GOTSHELLBOX = "Picked up a box of shotgun shells.",
	GOTBACKPACK = "Picked up a backpack full of ammo!", GOTBFG9000 = "You got the BFG9000!  Oh, yes.",
	GOTCHAINGUN = "You got the chaingun!", GOTCHAINSAW = "A chainsaw!  Find some meat!",
	GOTLAUNCHER = "You got the rocket launcher!", GOTPLASMA = "You got the plasma gun!",
	GOTSHOTGUN = "You got the shotgun!", GOTSHOTGUN2 = "You got the super shotgun!",
}
D.MSG = MSG

------------------------------------------------------------------------ giving
local function GiveAmmo(player, ammo, num)
	if ammo == am_noammo then return false end
	if player.ammo[ammo] == player.maxammo[ammo] then return false end
	if num ~= 0 then num = num * clipammo[ammo] else num = floor(clipammo[ammo] / 2) end
	local skill = D.G.gameskill
	if skill == 0 or skill == 4 then num = num * 2 end
	local oldammo = player.ammo[ammo]
	player.ammo[ammo] = player.ammo[ammo] + num
	if player.ammo[ammo] > player.maxammo[ammo] then player.ammo[ammo] = player.maxammo[ammo] end
	if oldammo ~= 0 then return true end
	local rw = player.readyweapon
	if ammo == am_clip then
		if rw == wp_fist then
			player.pendingweapon = player.weaponowned[wp_chaingun] and wp_chaingun or wp_pistol
		end
	elseif ammo == am_shell then
		if (rw == wp_fist or rw == wp_pistol) and player.weaponowned[wp_shotgun] then
			player.pendingweapon = wp_shotgun
		end
	elseif ammo == am_cell then
		if (rw == wp_fist or rw == wp_pistol) and player.weaponowned[wp_plasma] then
			player.pendingweapon = wp_plasma
		end
	elseif ammo == am_misl then
		if rw == wp_fist and player.weaponowned[wp_missile] then
			player.pendingweapon = wp_missile
		end
	end
	return true
end
P.GiveAmmo = GiveAmmo

local function GiveWeapon(player, weapon, dropped)
	local gaveammo = false
	local ammo = weaponinfo[weapon][1]
	if ammo ~= am_noammo then
		gaveammo = GiveAmmo(player, ammo, dropped and 1 or 2)
	end
	local gaveweapon = false
	if not player.weaponowned[weapon] then
		gaveweapon = true
		player.weaponowned[weapon] = true
		player.pendingweapon = weapon
	end
	return gaveweapon or gaveammo
end
P.GiveWeapon = GiveWeapon

local function GiveBody(player, num)
	if player.health >= MAXHEALTH then return false end
	player.health = player.health + num
	if player.health > MAXHEALTH then player.health = MAXHEALTH end
	player.mo.health = player.health
	return true
end

local function GiveArmor(player, armortype)
	local hits = armortype * 100
	if player.armorpoints >= hits then return false end
	player.armortype = armortype
	player.armorpoints = hits
	return true
end

local function GiveCard(player, card)
	if player.cards[card] then return end
	player.bonuscount = BONUSADD
	player.cards[card] = true
end

local function GivePower(player, power)
	if power == pw_invulnerability then player.powers[power] = 30 * 35 return true end
	if power == pw_invisibility then
		player.powers[power] = 60 * 35
		player.mo.flags = bor(player.mo.flags, MF.SHADOW)
		return true
	end
	if power == pw_infrared then player.powers[power] = 120 * 35 return true end
	if power == pw_ironfeet then player.powers[power] = 60 * 35 return true end
	if power == pw_strength then
		GiveBody(player, 100)
		player.powers[power] = 1
		return true
	end
	if player.powers[power] ~= 0 then return false end
	player.powers[power] = 1
	return true
end

local SPR = {}
for i = 0, #D.sprnames do SPR[D.sprnames[i]] = i end

function P.TouchSpecialThing(special, toucher)
	local delta = special.z - toucher.z
	if delta > toucher.height or delta < -8 then return end
	local sound = SFX.itemup
	local player = toucher.player
	if not player or toucher.health <= 0 then return end
	local name = D.sprnames[special.sprite]
	local dropped = band(special.flags, MF.DROPPED) ~= 0
	if name == "ARM1" then
		if not GiveArmor(player, 1) then return end
		player.message = MSG.GOTARMOR
	elseif name == "ARM2" then
		if not GiveArmor(player, 2) then return end
		player.message = MSG.GOTMEGA
	elseif name == "BON1" then
		player.health = player.health + 1
		if player.health > 200 then player.health = 200 end
		player.mo.health = player.health
		player.message = MSG.GOTHTHBONUS
	elseif name == "BON2" then
		player.armorpoints = player.armorpoints + 1
		if player.armorpoints > 200 then player.armorpoints = 200 end
		if player.armortype == 0 then player.armortype = 1 end
		player.message = MSG.GOTARMBONUS
	elseif name == "SOUL" then
		player.health = player.health + 100
		if player.health > 200 then player.health = 200 end
		player.mo.health = player.health
		player.message = MSG.GOTSUPER
		sound = SFX.getpow
	elseif name == "MEGA" then
		player.health = 200
		player.mo.health = player.health
		GiveArmor(player, 2)
		player.message = MSG.GOTMSPHERE
		sound = SFX.getpow
	elseif name == "BKEY" then
		if not player.cards[0] then player.message = MSG.GOTBLUECARD end
		GiveCard(player, 0)
	elseif name == "YKEY" then
		if not player.cards[1] then player.message = MSG.GOTYELWCARD end
		GiveCard(player, 1)
	elseif name == "RKEY" then
		if not player.cards[2] then player.message = MSG.GOTREDCARD end
		GiveCard(player, 2)
	elseif name == "BSKU" then
		if not player.cards[3] then player.message = MSG.GOTBLUESKUL end
		GiveCard(player, 3)
	elseif name == "YSKU" then
		if not player.cards[4] then player.message = MSG.GOTYELWSKUL end
		GiveCard(player, 4)
	elseif name == "RSKU" then
		if not player.cards[5] then player.message = MSG.GOTREDSKULL end
		GiveCard(player, 5)
	elseif name == "STIM" then
		if not GiveBody(player, 10) then return end
		player.message = MSG.GOTSTIM
	elseif name == "MEDI" then
		if not GiveBody(player, 25) then return end
		if player.health < 25 then player.message = MSG.GOTMEDINEED else player.message = MSG.GOTMEDIKIT end
	elseif name == "PINV" then
		if not GivePower(player, pw_invulnerability) then return end
		player.message = MSG.GOTINVUL
		sound = SFX.getpow
	elseif name == "PSTR" then
		if not GivePower(player, pw_strength) then return end
		player.message = MSG.GOTBERSERK
		if player.readyweapon ~= wp_fist then player.pendingweapon = wp_fist end
		sound = SFX.getpow
	elseif name == "PINS" then
		if not GivePower(player, pw_invisibility) then return end
		player.message = MSG.GOTINVIS
		sound = SFX.getpow
	elseif name == "SUIT" then
		if not GivePower(player, pw_ironfeet) then return end
		player.message = MSG.GOTSUIT
		sound = SFX.getpow
	elseif name == "PMAP" then
		if not GivePower(player, pw_allmap) then return end
		player.message = MSG.GOTMAP
		sound = SFX.getpow
	elseif name == "PVIS" then
		if not GivePower(player, pw_infrared) then return end
		player.message = MSG.GOTVISOR
		sound = SFX.getpow
	elseif name == "CLIP" then
		if not GiveAmmo(player, am_clip, dropped and 0 or 1) then return end
		player.message = MSG.GOTCLIP
	elseif name == "AMMO" then
		if not GiveAmmo(player, am_clip, 5) then return end
		player.message = MSG.GOTCLIPBOX
	elseif name == "ROCK" then
		if not GiveAmmo(player, am_misl, 1) then return end
		player.message = MSG.GOTROCKET
	elseif name == "BROK" then
		if not GiveAmmo(player, am_misl, 5) then return end
		player.message = MSG.GOTROCKBOX
	elseif name == "CELL" then
		if not GiveAmmo(player, am_cell, 1) then return end
		player.message = MSG.GOTCELL
	elseif name == "CELP" then
		if not GiveAmmo(player, am_cell, 5) then return end
		player.message = MSG.GOTCELLBOX
	elseif name == "SHEL" then
		if not GiveAmmo(player, am_shell, 1) then return end
		player.message = MSG.GOTSHELLS
	elseif name == "SBOX" then
		if not GiveAmmo(player, am_shell, 5) then return end
		player.message = MSG.GOTSHELLBOX
	elseif name == "BPAK" then
		if not player.backpack then
			for i = 0, 3 do player.maxammo[i] = player.maxammo[i] * 2 end
			player.backpack = true
		end
		for i = 0, 3 do GiveAmmo(player, i, 1) end
		player.message = MSG.GOTBACKPACK
	elseif name == "BFUG" then
		if not GiveWeapon(player, wp_bfg, false) then return end
		player.message = MSG.GOTBFG9000
		sound = SFX.wpnup
	elseif name == "MGUN" then
		if not GiveWeapon(player, wp_chaingun, dropped) then return end
		player.message = MSG.GOTCHAINGUN
		sound = SFX.wpnup
	elseif name == "CSAW" then
		if not GiveWeapon(player, wp_chainsaw, false) then return end
		player.message = MSG.GOTCHAINSAW
		sound = SFX.wpnup
	elseif name == "LAUN" then
		if not GiveWeapon(player, wp_missile, false) then return end
		player.message = MSG.GOTLAUNCHER
		sound = SFX.wpnup
	elseif name == "PLAS" then
		if not GiveWeapon(player, wp_plasma, false) then return end
		player.message = MSG.GOTPLASMA
		sound = SFX.wpnup
	elseif name == "SHOT" then
		if not GiveWeapon(player, wp_shotgun, dropped) then return end
		player.message = MSG.GOTSHOTGUN
		sound = SFX.wpnup
	elseif name == "SGN2" then
		if not GiveWeapon(player, wp_supershotgun, dropped) then return end
		player.message = MSG.GOTSHOTGUN2
		sound = SFX.wpnup
	else
		return
	end
	if band(special.flags, MF.COUNTITEM) ~= 0 then player.itemcount = player.itemcount + 1 end
	P.RemoveMobj(special)
	player.bonuscount = player.bonuscount + BONUSADD
	S_StartSound(nil, sound)
end

------------------------------------------------------------------------ damage
function P.KillMobj(source, target)
	target.flags = band(target.flags, bnot(MF.SHOOTABLE + MF.FLOAT + MF.SKULLFLY))
	if target.type ~= MT.MT_SKULL then target.flags = band(target.flags, bnot(MF.NOGRAVITY)) end
	target.flags = bor(target.flags, MF.CORPSE + MF.DROPOFF)
	target.height = target.height / 4
	if band(target.flags, MF.COUNTKILL) ~= 0 then
		D.G.player.killcount = D.G.player.killcount + 1
	end
	if target.player then
		target.flags = band(target.flags, bnot(MF.SOLID))
		target.player.playerstate = "dead"
		P.DropWeapon(target.player)
	end
	if target.health < -target.info.spawnhealth and target.info.xdeathstate ~= 0 then
		SetMobjState(target, target.info.xdeathstate)
	else
		SetMobjState(target, target.info.deathstate)
	end
	target.tics = target.tics - band(P_Random(), 3)
	if target.tics < 1 then target.tics = 1 end
	local item
	local t = target.type
	if t == MT.MT_WOLFSS or t == MT.MT_POSSESSED then
		item = MT.MT_CLIP
	elseif t == MT.MT_SHOTGUY then
		item = MT.MT_SHOTGUN
	elseif t == MT.MT_CHAINGUY then
		item = MT.MT_CHAINGUN
	else
		return
	end
	local mo = P.SpawnMobj(target.x, target.y, P.ONFLOORZ, item)
	mo.flags = bor(mo.flags, MF.DROPPED)
end

function P.DamageMobj(target, inflictor, source, damage)
	if band(target.flags, MF.SHOOTABLE) == 0 then return end
	if target.health <= 0 then return end
	if band(target.flags, MF.SKULLFLY) ~= 0 then
		target.momx, target.momy, target.momz = 0, 0, 0
	end
	local player = target.player
	if player and D.G.gameskill == 0 then damage = floor(damage / 2) end
	if inflictor and band(target.flags, MF.NOCLIP) == 0
		and (not source or not source.player or source.player.readyweapon ~= wp_chainsaw) then
		local ang = D.PointToAngle2(inflictor.x, inflictor.y, target.x, target.y)
		local thrust = damage * 0.125 * 100 / target.info.mass
		if damage < 40 and damage > target.health and target.z - inflictor.z > 64 and band(P_Random(), 1) ~= 0 then
			ang = (ang + ANG180) % ANGMAX
			thrust = thrust * 4
		end
		local fa = floor(ang / 524288)
		target.momx = target.momx + thrust * finecosine[fa]
		target.momy = target.momy + thrust * finesine[fa]
	end
	if player then
		if target.subsector.sector.special == 11 and damage >= target.health then
			damage = target.health - 1
		end
		if damage < 1000 and (band(player.cheats, 2) ~= 0 or player.powers[pw_invulnerability] ~= 0) then
			return
		end
		if player.armortype ~= 0 then
			local saved
			if player.armortype == 1 then saved = floor(damage / 3) else saved = floor(damage / 2) end
			if player.armorpoints <= saved then
				saved = player.armorpoints
				player.armortype = 0
			end
			player.armorpoints = player.armorpoints - saved
			damage = damage - saved
		end
		player.health = player.health - damage
		if player.health < 0 then player.health = 0 end
		player.attacker = source
		player.damagecount = player.damagecount + damage
		if player.damagecount > 100 then player.damagecount = 100 end
	end
	target.health = target.health - damage
	if target.health <= 0 then
		P.KillMobj(source, target)
		return
	end
	if P_Random() < target.info.painchance and band(target.flags, MF.SKULLFLY) == 0 then
		target.flags = bor(target.flags, MF.JUSTHIT)
		SetMobjState(target, target.info.painstate)
	end
	target.reactiontime = 0
	if (target.threshold == 0 or target.type == MT.MT_VILE) and source and source ~= target and source.type ~= MT.MT_VILE then
		target.target = source
		target.threshold = BASETHRESHOLD
		if target.statenum == target.info.spawnstate and target.info.seestate ~= 0 then
			SetMobjState(target, target.info.seestate)
		end
	end
end

------------------------------------------------------------------------ psprites
local ps_weapon, ps_flash = 0, 1
local WEAPONBOTTOM, WEAPONTOP = 128, 32
local LOWERSPEED, RAISESPEED = 6, 6
local BFGCELLS = 40

local function SetPsprite(player, position, stnum)
	local psp = player.psprites[position]
	repeat
		if stnum == 0 then
			psp.state = nil
			psp.statenum = 0
			break
		end
		local st = states[stnum]
		psp.state = st
		psp.statenum = stnum
		psp.tics = st[3]
		if st[6] ~= 0 then
			psp.sx = st[6]
			psp.sy = st[7]
		end
		local act = st[4]
		if act then
			local fn = PA[act]
			if fn then
				fn(player, psp)
				if not psp.state then break end
			end
		end
		stnum = psp.state[5]
	until psp.tics ~= 0
end
P.SetPsprite = SetPsprite

local function BringUpWeapon(player)
	if player.pendingweapon == wp_nochange then player.pendingweapon = player.readyweapon end
	if player.pendingweapon == wp_chainsaw then S_StartSound(player.mo, SFX.sawup) end
	local newstate = weaponinfo[player.pendingweapon][2]
	player.pendingweapon = wp_nochange
	player.psprites[ps_weapon].sy = WEAPONBOTTOM
	SetPsprite(player, ps_weapon, newstate)
end

local function CheckAmmo(player)
	local ammo = weaponinfo[player.readyweapon][1]
	local count
	if player.readyweapon == wp_bfg then count = BFGCELLS
	elseif player.readyweapon == wp_supershotgun then count = 2
	else count = 1 end
	if ammo == am_noammo or player.ammo[ammo] >= count then return true end
	local own, am = player.weaponowned, player.ammo
	if own[wp_plasma] and am[am_cell] > 0 then player.pendingweapon = wp_plasma
	elseif own[wp_chaingun] and am[am_clip] > 0 then player.pendingweapon = wp_chaingun
	elseif own[wp_shotgun] and am[am_shell] > 0 then player.pendingweapon = wp_shotgun
	elseif am[am_clip] > 0 then player.pendingweapon = wp_pistol
	elseif own[wp_chainsaw] then player.pendingweapon = wp_chainsaw
	elseif own[wp_missile] and am[am_misl] > 0 then player.pendingweapon = wp_missile
	elseif own[wp_bfg] and am[am_cell] > 40 then player.pendingweapon = wp_bfg
	else player.pendingweapon = wp_fist end
	SetPsprite(player, ps_weapon, weaponinfo[player.readyweapon][3])
	return false
end

local function FireWeapon(player)
	if not CheckAmmo(player) then return end
	SetMobjState(player.mo, S.S_PLAY_ATK1)
	SetPsprite(player, ps_weapon, weaponinfo[player.readyweapon][5])
	P.NoiseAlert(player.mo, player.mo)
end

function P.DropWeapon(player)
	SetPsprite(player, ps_weapon, weaponinfo[player.readyweapon][3])
end

function PA.A_WeaponReady(player, psp)
	local ms = player.mo.statenum
	if ms == S.S_PLAY_ATK1 or ms == S.S_PLAY_ATK2 then
		SetMobjState(player.mo, S.S_PLAY)
	end
	if player.readyweapon == wp_chainsaw and psp.statenum == S.S_SAW then
		S_StartSound(player.mo, SFX.sawidl)
	end
	if player.pendingweapon ~= wp_nochange or player.health == 0 then
		SetPsprite(player, ps_weapon, weaponinfo[player.readyweapon][3])
		return
	end
	if band(player.cmd.buttons, BT_ATTACK) ~= 0 then
		if not player.attackdown or (player.readyweapon ~= wp_missile and player.readyweapon ~= wp_bfg) then
			player.attackdown = true
			FireWeapon(player)
			return
		end
	else
		player.attackdown = false
	end
	local angle = (128 * P.leveltime) % 8192
	psp.sx = 1 + player.bob * finecosine[angle]
	angle = angle % 4096
	psp.sy = WEAPONTOP + player.bob * finesine[angle]
end

function PA.A_ReFire(player, psp)
	if band(player.cmd.buttons, BT_ATTACK) ~= 0 and player.pendingweapon == wp_nochange and player.health > 0 then
		player.refire = player.refire + 1
		FireWeapon(player)
	else
		player.refire = 0
		CheckAmmo(player)
	end
end

function PA.A_CheckReload(player, psp) CheckAmmo(player) end

function PA.A_Lower(player, psp)
	psp.sy = psp.sy + LOWERSPEED
	if psp.sy < WEAPONBOTTOM then return end
	if player.playerstate == "dead" then
		psp.sy = WEAPONBOTTOM
		return
	end
	if player.health == 0 then
		SetPsprite(player, ps_weapon, 0)
		return
	end
	player.readyweapon = player.pendingweapon
	BringUpWeapon(player)
end

function PA.A_Raise(player, psp)
	psp.sy = psp.sy - RAISESPEED
	if psp.sy > WEAPONTOP then return end
	psp.sy = WEAPONTOP
	SetPsprite(player, ps_weapon, weaponinfo[player.readyweapon][4])
end

function PA.A_GunFlash(player, psp)
	SetMobjState(player.mo, S.S_PLAY_ATK2)
	SetPsprite(player, ps_flash, weaponinfo[player.readyweapon][6])
end

function PA.A_Punch(player, psp)
	local damage = (P_Random() % 10 + 1) * 2
	if player.powers[pw_strength] ~= 0 then damage = damage * 10 end
	local angle = (player.mo.angle + (P_Random() - P_Random()) * 262144) % ANGMAX
	local slope = P.AimLineAttack(player.mo, angle, P.MELEERANGE)
	P.LineAttack(player.mo, angle, P.MELEERANGE, slope, damage)
	if P.linetarget then
		S_StartSound(player.mo, SFX.punch)
		player.mo.angle = D.PointToAngle2(player.mo.x, player.mo.y, P.linetarget.x, P.linetarget.y)
	end
end

function PA.A_Saw(player, psp)
	local damage = 2 * (P_Random() % 10 + 1)
	local angle = (player.mo.angle + (P_Random() - P_Random()) * 262144) % ANGMAX
	local slope = P.AimLineAttack(player.mo, angle, P.MELEERANGE + 1)
	P.LineAttack(player.mo, angle, P.MELEERANGE + 1, slope, damage)
	if not P.linetarget then
		S_StartSound(player.mo, SFX.sawful)
		return
	end
	S_StartSound(player.mo, SFX.sawhit)
	local mo = player.mo
	angle = D.PointToAngle2(mo.x, mo.y, P.linetarget.x, P.linetarget.y)
	local d = (angle - mo.angle) % ANGMAX
	local A20, A21 = ANG90 / 20, ANG90 / 21
	if d > ANG180 then
		if d < ANGMAX - A20 then
			mo.angle = (angle + A21) % ANGMAX
		else
			mo.angle = (mo.angle - A20) % ANGMAX
		end
	else
		if d > A20 then
			mo.angle = (angle - A21) % ANGMAX
		else
			mo.angle = (mo.angle + A20) % ANGMAX
		end
	end
	mo.flags = bor(mo.flags, MF.JUSTATTACKED)
end

local function useAmmo(player, n)
	local a = weaponinfo[player.readyweapon][1]
	player.ammo[a] = player.ammo[a] - (n or 1)
end

function PA.A_FireMissile(player, psp)
	useAmmo(player)
	P.SpawnPlayerMissile(player.mo, MT.MT_ROCKET)
end

function PA.A_FireBFG(player, psp)
	useAmmo(player, BFGCELLS)
	P.SpawnPlayerMissile(player.mo, MT.MT_BFG)
end

function PA.A_FirePlasma(player, psp)
	useAmmo(player)
	SetPsprite(player, ps_flash, weaponinfo[player.readyweapon][6] + band(P_Random(), 1))
	P.SpawnPlayerMissile(player.mo, MT.MT_PLASMA)
end

local bulletslope = 0
local function BulletSlope(mo)
	local an = mo.angle
	bulletslope = P.AimLineAttack(mo, an, 16 * 64)
	if not P.linetarget then
		an = (an + 67108864) % ANGMAX
		bulletslope = P.AimLineAttack(mo, an, 16 * 64)
		if not P.linetarget then
			an = (an - 134217728) % ANGMAX
			bulletslope = P.AimLineAttack(mo, an, 16 * 64)
		end
	end
end

local function GunShot(mo, accurate)
	local damage = 5 * (P_Random() % 3 + 1)
	local angle = mo.angle
	if not accurate then angle = (angle + (P_Random() - P_Random()) * 262144) % ANGMAX end
	P.LineAttack(mo, angle, P.MISSILERANGE, bulletslope, damage)
end

function PA.A_FirePistol(player, psp)
	S_StartSound(player.mo, SFX.pistol)
	SetMobjState(player.mo, S.S_PLAY_ATK2)
	useAmmo(player)
	SetPsprite(player, ps_flash, weaponinfo[player.readyweapon][6])
	BulletSlope(player.mo)
	GunShot(player.mo, player.refire == 0)
end

function PA.A_FireShotgun(player, psp)
	S_StartSound(player.mo, SFX.shotgn)
	SetMobjState(player.mo, S.S_PLAY_ATK2)
	useAmmo(player)
	SetPsprite(player, ps_flash, weaponinfo[player.readyweapon][6])
	BulletSlope(player.mo)
	for _ = 1, 7 do GunShot(player.mo, false) end
end

function PA.A_FireShotgun2(player, psp)
	S_StartSound(player.mo, SFX.dshtgn)
	SetMobjState(player.mo, S.S_PLAY_ATK2)
	useAmmo(player, 2)
	SetPsprite(player, ps_flash, weaponinfo[player.readyweapon][6])
	BulletSlope(player.mo)
	for _ = 1, 20 do
		local damage = 5 * (P_Random() % 3 + 1)
		local angle = (player.mo.angle + (P_Random() - P_Random()) * 524288) % ANGMAX
		P.LineAttack(player.mo, angle, P.MISSILERANGE, bulletslope + (P_Random() - P_Random()) * 32 / 65536, damage)
	end
end

function PA.A_FireCGun(player, psp)
	S_StartSound(player.mo, SFX.pistol)
	local a = weaponinfo[player.readyweapon][1]
	if player.ammo[a] == 0 then return end
	SetMobjState(player.mo, S.S_PLAY_ATK2)
	useAmmo(player)
	SetPsprite(player, ps_flash, weaponinfo[player.readyweapon][6] + psp.statenum - S.S_CHAIN1)
	BulletSlope(player.mo)
	GunShot(player.mo, player.refire == 0)
end

function PA.A_Light0(player) player.extralight = 0 end
function PA.A_Light1(player) player.extralight = 1 end
function PA.A_Light2(player) player.extralight = 2 end
function PA.A_BFGsound(player) S_StartSound(player.mo, SFX.bfg) end
function PA.A_OpenShotgun2(player) S_StartSound(player.mo, SFX.dbopn) end
function PA.A_LoadShotgun2(player) S_StartSound(player.mo, SFX.dbload) end
function PA.A_CloseShotgun2(player, psp)
	S_StartSound(player.mo, SFX.dbcls)
	PA.A_ReFire(player, psp)
end

function A.A_BFGSpray(mo)
	for i = 0, 39 do
		local an = (mo.angle - ANG90 / 2 + ANG90 / 40 * i) % ANGMAX
		P.AimLineAttack(mo.target, an, 16 * 64)
		local lt = P.linetarget
		if lt then
			P.SpawnMobj(lt.x, lt.y, lt.z + lt.height / 4, MT.MT_EXTRABFG)
			local damage = 0
			for _ = 1, 15 do damage = damage + band(P_Random(), 7) + 1 end
			P.DamageMobj(lt, mo.target, mo.target, damage)
		end
	end
end

function P.SetupPsprites(player)
	for i = 0, 1 do
		player.psprites[i] = player.psprites[i] or { sx = 0, sy = 0, tics = 0 }
		player.psprites[i].state = nil
	end
	player.pendingweapon = player.readyweapon
	BringUpWeapon(player)
end

local function MovePsprites(player)
	for i = 0, 1 do
		local psp = player.psprites[i]
		if psp.state then
			if psp.tics ~= -1 then
				psp.tics = psp.tics - 1
				if psp.tics == 0 then
					SetPsprite(player, i, psp.state[5])
				end
			end
		end
	end
	player.psprites[ps_flash].sx = player.psprites[ps_weapon].sx
	player.psprites[ps_flash].sy = player.psprites[ps_weapon].sy
end

------------------------------------------------------------------------ p_user
local onground = false
local VIEWHEIGHT = P.VIEWHEIGHT

local function Thrust(player, angle, move)
	local fa = floor((angle % ANGMAX) / 524288)
	player.mo.momx = player.mo.momx + move * finecosine[fa]
	player.mo.momy = player.mo.momy + move * finesine[fa]
end

local function CalcHeight(player)
	local mo = player.mo
	player.bob = (mo.momx * mo.momx + mo.momy * mo.momy) / 4
	if player.bob > 16 then player.bob = 16 end
	if band(player.cheats, 4) ~= 0 or not onground then
		player.viewz = mo.z + VIEWHEIGHT
		if player.viewz > mo.ceilingz - 4 then player.viewz = mo.ceilingz - 4 end
		player.viewz = mo.z + player.viewheight
		return
	end
	local angle = floor(8192 / 20 * P.leveltime) % 8192
	local bob = player.bob / 2 * finesine[angle]
	if player.playerstate == "live" then
		player.viewheight = player.viewheight + player.deltaviewheight
		if player.viewheight > VIEWHEIGHT then
			player.viewheight = VIEWHEIGHT
			player.deltaviewheight = 0
		end
		if player.viewheight < VIEWHEIGHT / 2 then
			player.viewheight = VIEWHEIGHT / 2
			if player.deltaviewheight <= 0 then player.deltaviewheight = 1 / 65536 end
		end
		if player.deltaviewheight ~= 0 then
			player.deltaviewheight = player.deltaviewheight + 0.25
			if player.deltaviewheight == 0 then player.deltaviewheight = 1 / 65536 end
		end
	end
	player.viewz = mo.z + player.viewheight + bob
	if player.viewz > mo.ceilingz - 4 then player.viewz = mo.ceilingz - 4 end
end
P.CalcHeight = CalcHeight

local function MovePlayer(player)
	local cmd = player.cmd
	local mo = player.mo
	mo.angle = (mo.angle + cmd.angleturn * 65536) % ANGMAX
	onground = mo.z <= mo.floorz
	if cmd.forwardmove ~= 0 and onground then
		Thrust(player, mo.angle, cmd.forwardmove / 32)
	end
	if cmd.sidemove ~= 0 and onground then
		Thrust(player, mo.angle - ANG90, cmd.sidemove / 32)
	end
	if (cmd.forwardmove ~= 0 or cmd.sidemove ~= 0) and mo.statenum == S.S_PLAY then
		SetMobjState(mo, S.S_PLAY_RUN1)
	end
end

local ANG5 = ANG90 / 18
local function DeathThink(player)
	MovePsprites(player)
	if player.viewheight > 6 then player.viewheight = player.viewheight - 1 end
	if player.viewheight < 6 then player.viewheight = 6 end
	player.deltaviewheight = 0
	onground = player.mo.z <= player.mo.floorz
	CalcHeight(player)
	local mo = player.mo
	if player.attacker and player.attacker ~= mo then
		local angle = D.PointToAngle2(mo.x, mo.y, player.attacker.x, player.attacker.y)
		local delta = (angle - mo.angle) % ANGMAX
		if delta < ANG5 or delta > ANGMAX - ANG5 then
			mo.angle = angle
			if player.damagecount > 0 then player.damagecount = player.damagecount - 1 end
		elseif delta < ANG180 then
			mo.angle = (mo.angle + ANG5) % ANGMAX
		else
			mo.angle = (mo.angle - ANG5) % ANGMAX
		end
	elseif player.damagecount > 0 then
		player.damagecount = player.damagecount - 1
	end
	if band(player.cmd.buttons, BT_USE) ~= 0 then
		player.playerstate = "reborn"
	end
end

function P.PlayerThink(player)
	local mo = player.mo
	if band(player.cheats, 1) ~= 0 then
		mo.flags = bor(mo.flags, MF.NOCLIP)
	else
		mo.flags = band(mo.flags, bnot(MF.NOCLIP))
	end
	local cmd = player.cmd
	if band(mo.flags, MF.JUSTATTACKED) ~= 0 then
		cmd.angleturn = 0
		cmd.forwardmove = 100
		cmd.sidemove = 0
		mo.flags = band(mo.flags, bnot(MF.JUSTATTACKED))
	end
	if player.playerstate == "dead" then
		DeathThink(player)
		return
	end
	if mo.reactiontime > 0 then
		mo.reactiontime = mo.reactiontime - 1
	else
		MovePlayer(player)
	end
	CalcHeight(player)
	if mo.subsector.sector.special ~= 0 then
		P.PlayerInSpecialSector(player)
	end
	if band(cmd.buttons, BT_CHANGE) ~= 0 then
		local newweapon = cmd.weapon
		if newweapon == wp_fist and player.weaponowned[wp_chainsaw]
			and not (player.readyweapon == wp_chainsaw and player.powers[pw_strength] ~= 0) then
			newweapon = wp_chainsaw
		end
		if player.weaponowned[newweapon] and newweapon ~= player.readyweapon then
			player.pendingweapon = newweapon
		end
	end
	if band(cmd.buttons, BT_USE) ~= 0 then
		if not player.usedown then
			P.UseLines(player)
			player.usedown = true
		end
	else
		player.usedown = false
	end
	MovePsprites(player)
	local pw = player.powers
	if pw[pw_strength] ~= 0 then pw[pw_strength] = pw[pw_strength] + 1 end
	if pw[pw_invulnerability] > 0 then pw[pw_invulnerability] = pw[pw_invulnerability] - 1 end
	if pw[pw_invisibility] > 0 then
		pw[pw_invisibility] = pw[pw_invisibility] - 1
		if pw[pw_invisibility] == 0 then mo.flags = band(mo.flags, bnot(MF.SHADOW)) end
	end
	if pw[pw_infrared] > 0 then pw[pw_infrared] = pw[pw_infrared] - 1 end
	if pw[pw_ironfeet] > 0 then pw[pw_ironfeet] = pw[pw_ironfeet] - 1 end
	if player.damagecount > 0 then player.damagecount = player.damagecount - 1 end
	if player.bonuscount > 0 then player.bonuscount = player.bonuscount - 1 end
	if pw[pw_invulnerability] > 0 then
		if pw[pw_invulnerability] > 4 * 32 or band(pw[pw_invulnerability], 8) ~= 0 then
			player.fixedcolormap = 32
		else
			player.fixedcolormap = 0
		end
	elseif pw[pw_infrared] > 0 then
		if pw[pw_infrared] > 4 * 32 or band(pw[pw_infrared], 8) ~= 0 then
			player.fixedcolormap = 1
		else
			player.fixedcolormap = 0
		end
	else
		player.fixedcolormap = 0
	end
end
