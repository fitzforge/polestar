-- Save games (p_saveg.c equivalent). A save is a plain Lua table (no functions or
-- cycles) so it can live in SavedVariables. Object references become indices.
local D = FreedoomArcade
local G, P = D.G, D.P
local L = D.level
local states, mobjinfo = D.states, D.mobjinfo

local SAVE_VERSION = 3

local MOBJ_FIELDS = { "type", "x", "y", "z", "angle", "momx", "momy", "momz", "statenum", "tics", "flags",
	"health", "movedir", "movecount", "reactiontime", "threshold", "lastlook", "radius", "height",
	"floorz", "ceilingz" }
local PLAYER_FIELDS = { "playerstate", "viewz", "viewheight", "deltaviewheight", "bob", "health", "armorpoints",
	"armortype", "backpack", "readyweapon", "pendingweapon", "attackdown", "usedown", "cheats", "refire",
	"killcount", "itemcount", "secretcount", "damagecount", "bonuscount", "extralight", "fixedcolormap" }
local PLAYER_ARRAYS = { "powers", "cards", "weaponowned", "ammo", "maxammo" }

local function copyArray(t, first, last)
	local out = {}
	for i = first, last do out[#out + 1] = t[i] end
	return out
end

local function restoreArray(dst, src, first)
	for i, v in ipairs(src) do dst[first + i - 1] = v end
end

function G.SaveGame()
	if G.state ~= "level" then return nil, "not in a level" end
	local p = G.player
	if not p.mo or p.playerstate ~= "live" then return nil, "you can't save while dead" end

	local save = {
		version = SAVE_VERSION,
		episode = G.gameepisode, map = G.gamemap, skill = G.gameskill,
		leveltime = P.leveltime,
		totalkills = G.totalkills, totalitems = G.totalitems, totalsecret = G.totalsecret,
		rnd = { D.GetRandomState() },
		time = date and date("%Y-%m-%d %H:%M") or os.date("%Y-%m-%d %H:%M"),
	}

	-- index thinkers (mobjs and specials) in run order
	local index = {}
	local list = {}
	for _, th in ipairs(P.thinkers) do
		if not th.removed and (th.think == P.MobjThinker or th.kind) then
			list[#list + 1] = th
			index[th] = #list
		end
	end

	local function ref(v)
		if type(v) ~= "table" then return nil end
		return index[v]
	end

	-- sectors
	local secs = {}
	for i = 0, L.numsectors - 1 do
		local s = L.sectors[i]
		secs[i + 1] = { s.floorheight, s.ceilingheight, s.floorpic, s.ceilingpic, s.lightlevel, s.special, s.tag,
			ref(s.specialdata) or false, ref(s.soundtarget) or false, s.soundtraversed or 0 }
	end
	save.sectors = secs

	-- lines: changed special/flags only, plus a 0/1 string of which lines are on the automap
	local lines, mapped = {}, {}
	for i = 0, L.numlines - 1 do
		local ln = L.lines[i]
		if ln.special ~= ln.ospecial or ln.flags ~= ln.oflags then
			lines[#lines + 1] = { i, ln.special, ln.flags }
		end
		mapped[i + 1] = ln.mapped and "1" or "0"
	end
	save.lines = lines
	save.mapped = table.concat(mapped)

	-- sides: only those whose offsets/textures changed (switches, scrollers)
	local sides = {}
	local i = 0
	while L.sides[i] do
		local sd = L.sides[i]
		local o = sd.orig
		if sd.textureoffset ~= o[1] or sd.rowoffset ~= o[2] or sd.toptexture ~= o[3] or sd.bottomtexture ~= o[4] or sd.midtexture ~= o[5] then
			sides[#sides + 1] = { i, sd.textureoffset, sd.rowoffset, sd.toptexture or false, sd.bottomtexture or false, sd.midtexture or false }
		end
		i = i + 1
	end
	save.sides = sides

	-- thinkers
	local ths = {}
	for n, th in ipairs(list) do
		local e = {}
		if th.think == P.MobjThinker then
			e.k = "mobj"
			local v = {}
			for fi, f in ipairs(MOBJ_FIELDS) do v[fi] = th[f] end
			e.v = v
			e.target = ref(th.target)
			e.tracer = ref(th.tracer)
			if th.spawnpoint then
				local sp = th.spawnpoint
				e.spawnpoint = { sp.x, sp.y, sp.angle, sp.type, sp.options }
			end
			if th.player then e.isplayer = true end
		else
			e.k = "special"
			e.stopped = th.think == nil
			for key, v in pairs(th) do
				local tv = type(v)
				if key ~= "think" and key ~= "removed" then
					if tv == "number" or tv == "string" or tv == "boolean" then
						e[key] = v
					elseif tv == "table" and v.floorheight and v.id then
						e[key] = { sec = v.id }
					end
				end
			end
		end
		ths[n] = e
	end
	save.thinkers = ths

	local plats, ceilings, buttons = P.GetSpecialLists()
	save.plats, save.ceilings, save.buttons = {}, {}, {}
	for _, pl in ipairs(plats) do save.plats[#save.plats + 1] = index[pl] end
	for _, c in ipairs(ceilings) do save.ceilings[#save.ceilings + 1] = index[c] end
	for _, b in ipairs(buttons) do
		save.buttons[#save.buttons + 1] = { b.line.id, b.where, b.btexture, b.btimer }
	end

	-- player
	local ps = {}
	for _, f in ipairs(PLAYER_FIELDS) do ps[f] = p[f] end
	for _, f in ipairs(PLAYER_ARRAYS) do
		local t = p[f]
		local last = 0
		while t[last + 1] ~= nil do last = last + 1 end
		ps[f] = copyArray(t, 0, last)
	end
	ps.mo = index[p.mo]
	ps.attacker = ref(p.attacker)
	ps.psprites = {}
	for k = 0, 1 do
		local psp = p.psprites[k]
		ps.psprites[k + 1] = { psp.state and psp.statenum or 0, psp.tics or 0, psp.sx or 0, psp.sy or 0 }
	end
	save.player = ps
	return save
end

function G.LoadGame(save)
	if type(save) ~= "table" or save.version ~= SAVE_VERSION then return false, "no compatible save" end
	local name = "E" .. save.episode .. "M" .. save.map
	if not D.EnsureMapLoaded(name) then return false, "map " .. name .. " unavailable" end

	G.gameepisode, G.gamemap, G.gameskill = save.episode, save.map, save.skill
	G.respawnmonsters = save.skill == 4
	D.R.skytexture = "SKY" .. save.episode
	D.LoadLevelGeometry(name)
	P.InitThinkers()
	P.InitPicAnims()
	P.leveltime = save.leveltime
	G.totalkills, G.totalitems, G.totalsecret = save.totalkills, save.totalitems, save.totalsecret

	-- geometry state
	for i, s in ipairs(save.sectors) do
		local sec = L.sectors[i - 1]
		sec.floorheight, sec.ceilingheight, sec.floorpic, sec.ceilingpic = s[1], s[2], s[3], s[4]
		sec.lightlevel, sec.special, sec.tag = s[5], s[6], s[7]
		sec.soundtraversed = s[10] or 0
	end
	for _, l in ipairs(save.lines) do
		local ln = L.lines[l[1]]
		ln.special, ln.flags = l[2], l[3]
	end
	local mapped = save.mapped
	for i = 0, L.numlines - 1 do
		if mapped:byte(i + 1) == 49 then L.lines[i].mapped = true end
	end
	for _, sd in ipairs(save.sides) do
		local side = L.sides[sd[1]]
		side.textureoffset, side.rowoffset = sd[2], sd[3]
		side.toptexture, side.bottomtexture, side.midtexture = sd[4] or false, sd[5] or false, sd[6] or false
	end
	P.InitLineSpecials()

	-- thinkers
	local objs = {}
	for n, e in ipairs(save.thinkers) do
		if e.k == "mobj" then
			local st = states[e.v[9]]
			local mo = { info = mobjinfo[e.v[1]], think = P.MobjThinker, validcount = 0 }
			for fi, f in ipairs(MOBJ_FIELDS) do mo[f] = e.v[fi] end
			mo.state = st
			mo.sprite, mo.frame = st[1], st[2]
			if e.spawnpoint then
				local sp = e.spawnpoint
				mo.spawnpoint = { x = sp[1], y = sp[2], angle = sp[3], type = sp[4], options = sp[5] }
			end
			P.SetThingPosition(mo)
			P.AddThinker(mo)
			objs[n] = mo
		else
			local th = {}
			for key, v in pairs(e) do
				if key ~= "k" and key ~= "stopped" then
					if type(v) == "table" and v.sec then
						th[key] = L.sectors[v.sec]
					else
						th[key] = v
					end
				end
			end
			if not e.stopped then th.think = P.specialThinks[e.kind] end
			P.AddThinker(th)
			objs[n] = th
		end
	end
	for n, e in ipairs(save.thinkers) do
		if e.k == "mobj" then
			objs[n].target = e.target and objs[e.target] or nil
			objs[n].tracer = e.tracer and objs[e.tracer] or nil
		end
	end
	for i, s in ipairs(save.sectors) do
		local sec = L.sectors[i - 1]
		sec.specialdata = s[8] and objs[s[8]] or nil
		sec.soundtarget = s[9] and objs[s[9]] or nil
	end
	local plats, ceilings, buttons = {}, {}, {}
	for _, n in ipairs(save.plats) do plats[#plats + 1] = objs[n] end
	for _, n in ipairs(save.ceilings) do ceilings[#ceilings + 1] = objs[n] end
	for _, b in ipairs(save.buttons) do
		local line = L.lines[b[1]]
		buttons[#buttons + 1] = { line = line, where = b[2], btexture = b[3], btimer = b[4], soundorg = line.frontsector.soundorg }
	end
	P.SetSpecialLists(plats, ceilings, buttons)

	-- player
	local ps = save.player
	local p = G.player
	for _, f in ipairs(PLAYER_FIELDS) do p[f] = ps[f] end
	for _, f in ipairs(PLAYER_ARRAYS) do restoreArray(p[f], ps[f], 0) end
	p.mo = objs[ps.mo]
	p.mo.player = p
	p.attacker = ps.attacker and objs[ps.attacker] or nil
	p.message = nil
	for k = 0, 1 do
		local s = ps.psprites[k + 1]
		local psp = p.psprites[k]
		psp.statenum = s[1]
		psp.state = s[1] ~= 0 and states[s[1]] or nil
		psp.tics, psp.sx, psp.sy = s[2], s[3], s[4]
	end
	local cmd = p.cmd
	cmd.forwardmove, cmd.sidemove, cmd.angleturn, cmd.buttons = 0, 0, 0, 0

	D.SetRandomState(save.rnd[1], save.rnd[2])
	G.state = "level"
	G.gameaction = nil
	if D.AM then D.AM.active = false end
	if D.Sound then D.Sound.LevelStart() end
	return true
end
