-- Game flow (g_game.c), status bar (st_stuff.c), menus, intermission.
local D = FreedoomArcade
local G = D.G or {}
D.G = G
local P = D.P
local R = D.R
local floor = math.floor
local band = D.band

G.gameskill = 2
G.gameepisode = 1
G.gamemap = 1
G.gametic = 0
G.totalkills, G.totalitems, G.totalsecret = 0, 0, 0
G.respawnmonsters = false
G.state = "title" -- title | menu | level | intermission | finale
G.paused = false

------------------------------------------------------------------------ player
local function newPlayer()
	local p = {
		playerstate = "reborn",
		cmd = { forwardmove = 0, sidemove = 0, angleturn = 0, buttons = 0, weapon = 0 },
		viewz = 0, viewheight = P.VIEWHEIGHT, deltaviewheight = 0, bob = 0,
		health = 100, armorpoints = 0, armortype = 0,
		powers = { [0] = 0, 0, 0, 0, 0, 0 },
		cards = { [0] = false, false, false, false, false, false },
		backpack = false,
		weaponowned = { [0] = true, true, false, false, false, false, false, false, false },
		ammo = { [0] = 50, 0, 0, 0 },
		maxammo = { [0] = 200, 50, 300, 50 },
		readyweapon = 1, pendingweapon = 1,
		attackdown = false, usedown = false,
		cheats = 0, refire = 0,
		killcount = 0, itemcount = 0, secretcount = 0,
		message = nil, damagecount = 0, bonuscount = 0,
		attacker = nil, extralight = 0, fixedcolormap = 0,
		psprites = { [0] = { sx = 0, sy = 0, tics = 0 }, { sx = 0, sy = 0, tics = 0 } },
	}
	return p
end
G.player = newPlayer()

function G.PlayerReborn()
	local old = G.player
	local p = newPlayer()
	p.killcount, p.itemcount, p.secretcount = old.killcount, old.itemcount, old.secretcount
	p.cheats = old.cheats
	p.playerstate = "live"
	G.player = p
	return p
end

-- carry inventory between levels, drop keys/powers (G_PlayerFinishLevel)
local function PlayerFinishLevel(p)
	for i = 0, 5 do p.powers[i] = 0; p.cards[i] = false end
	if p.mo then p.mo.flags = band(p.mo.flags, D.bnot(D.MF.SHADOW)) end
	p.extralight = 0
	p.fixedcolormap = 0
	p.damagecount = 0
	p.bonuscount = 0
end

------------------------------------------------------------------------ levels
local function MapName(ep, map) return "E" .. ep .. "M" .. map end

function G.DoLoadLevel()
	local name = MapName(G.gameepisode, G.gamemap)
	if not D.EnsureMapLoaded(name) then
		D.Print("map " .. name .. " is not available")
		G.state = "menu"
		return
	end
	R.skytexture = "SKY" .. G.gameepisode
	G.totalkills, G.totalitems, G.totalsecret = 0, 0, 0
	local p = G.player
	p.killcount, p.itemcount, p.secretcount = 0, 0, 0
	D.LoadLevelGeometry(name)
	P.InitThinkers()
	P.leveltime = 0
	P.InitPicAnims()
	for _, mt in ipairs(D.level.mapthings) do
		P.SpawnMapThing(mt)
	end
	P.SpawnSpecials()
	G.state = "level"
	if D.AM then D.AM.active = false end
	G.levelstarttic = G.gametic
	p.message = name
	if D.Sound then D.Sound.LevelStart() end
end

function G.InitNew(skill, episode, map)
	G.gameskill = skill
	G.gameepisode = episode
	G.gamemap = map
	G.respawnmonsters = skill == 4
	G.player = newPlayer()
	-- nightmare: faster monsters/missiles are skipped for simplicity
	D.ClearRandom()
	G.DoLoadLevel()
end

function G.ExitLevel()
	G.secretexit = false
	G.gameaction = "completed"
end

function G.SecretExitLevel()
	G.secretexit = true
	G.gameaction = "completed"
end

local function DoCompleted()
	local p = G.player
	PlayerFinishLevel(p)
	G.wi = {
		ep = G.gameepisode, last = G.gamemap,
		kills = G.totalkills > 0 and floor(p.killcount * 100 / G.totalkills) or 100,
		items = G.totalitems > 0 and floor(p.itemcount * 100 / G.totalitems) or 100,
		secret = G.totalsecret > 0 and floor(p.secretcount * 100 / G.totalsecret) or 100,
		time = floor(P.leveltime / 35),
		tic = 0,
	}
	local m = G.gamemap
	if G.secretexit then
		G.nextmap = 9
	elseif m == 9 then
		local back = { 4, 6, 7, 3 }
		G.nextmap = back[G.gameepisode] or 4
	else
		G.nextmap = m + 1
	end
	if m == 8 then G.nextmap = nil end
	G.state = "intermission"
	if D.Sound then D.Sound.Start(nil, D.SFX.barexp) end
end

local function WorldDone()
	if not G.nextmap then
		G.state = "finale"
		G.finaletic = 0
		return
	end
	G.gamemap = G.nextmap
	G.DoLoadLevel()
end

------------------------------------------------------------------------ input -> ticcmd
local forwardmove = { 25, 50 }
local sidemove = { 24, 40 }
local angleturn = { 640, 1280, 320 }
G.input = { forward = false, back = false, left = false, right = false, strafeleft = false, straferight = false,
	strafe = false, run = false, fire = false, use = false, weapon = nil, mousex = 0 }
G.alwaysRun = true

local turnheld = 0
local function BuildTiccmd(cmd)
	local inp = G.input
	local speed = (inp.run ~= G.alwaysRun) and 2 or 1
	cmd.forwardmove, cmd.sidemove, cmd.angleturn, cmd.buttons = 0, 0, 0, 0
	if inp.left or inp.right then turnheld = turnheld + 1 else turnheld = 0 end
	local tspeed = turnheld < 6 and 3 or speed
	if inp.strafe then
		if inp.right then cmd.sidemove = cmd.sidemove + sidemove[speed] end
		if inp.left then cmd.sidemove = cmd.sidemove - sidemove[speed] end
	else
		if inp.right then cmd.angleturn = cmd.angleturn - angleturn[tspeed] end
		if inp.left then cmd.angleturn = cmd.angleturn + angleturn[tspeed] end
	end
	if inp.forward then cmd.forwardmove = cmd.forwardmove + forwardmove[speed] end
	if inp.back then cmd.forwardmove = cmd.forwardmove - forwardmove[speed] end
	if inp.straferight then cmd.sidemove = cmd.sidemove + sidemove[speed] end
	if inp.strafeleft then cmd.sidemove = cmd.sidemove - sidemove[speed] end
	if inp.fire then cmd.buttons = cmd.buttons + D.BT_ATTACK end
	if inp.use then cmd.buttons = cmd.buttons + D.BT_USE end
	if inp.weapon then
		cmd.buttons = cmd.buttons + D.BT_CHANGE
		cmd.weapon = inp.weapon
		inp.weapon = nil
	end
	if inp.mousex ~= 0 then
		cmd.angleturn = cmd.angleturn - floor(inp.mousex * 40)
		inp.mousex = 0
	end
	if cmd.forwardmove > 50 then cmd.forwardmove = 50 elseif cmd.forwardmove < -50 then cmd.forwardmove = -50 end
	if cmd.sidemove > 40 then cmd.sidemove = 40 elseif cmd.sidemove < -40 then cmd.sidemove = -40 end
end

------------------------------------------------------------------------ ticker
G.messageTics = 0
G.messageText = nil

function G.Ticker()
	G.gametic = G.gametic + 1
	if G.state == "level" then
		if G.paused then return end
		local p = G.player
		if p.playerstate == "reborn" then
			-- single player death: restart the level with a fresh player
			G.player = newPlayer()
			G.DoLoadLevel()
			return
		end
		BuildTiccmd(p.cmd)
		P.PlayerThink(p)
		P.RunThinkers()
		P.UpdateSpecials()
		P.leveltime = P.leveltime + 1
		if p.message then
			G.messageText = p.message
			G.messageTics = 4 * 35
			p.message = nil
		end
		if G.messageTics > 0 then G.messageTics = G.messageTics - 1 end
		G.ST_Ticker()
		if G.gameaction == "completed" then
			G.gameaction = nil
			DoCompleted()
		end
	elseif G.state == "intermission" then
		G.wi.tic = G.wi.tic + 1
	elseif G.state == "finale" then
		G.finaletic = G.finaletic + 1
	end
end

------------------------------------------------------------------------ status bar
local Draw = D.Draw
local HUD = 2000
local face = { kind = "st", n = 0, count = 0, oldhealth = -1, priority = 0, lastattackdown = -1, oldweaponsowned = {} }

local function painLevel(p)
	local health = p.health > 100 and 100 or p.health
	if health < 0 then health = 0 end
	return floor(((100 - health) * 5) / 101)
end

local function setFace(priority, kind, count)
	face.priority = priority
	face.kind = kind
	face.count = count
end

-- ST_updateFaceWidget, with faces named by kind instead of numeric offsets
function G.ST_Ticker()
	local p = G.player
	local rnd = D.M_Random()
	if face.priority < 10 and p.health <= 0 then
		setFace(9, "dead", 1)
	end
	if face.priority < 9 and p.bonuscount > 0 then
		local gotnew = false
		for i = 0, 8 do
			if face.oldweaponsowned[i] ~= p.weaponowned[i] then
				if face.oldweaponsowned[i] ~= nil then gotnew = true end
				face.oldweaponsowned[i] = p.weaponowned[i]
			end
		end
		if gotnew then setFace(8, "evil", 2 * 35) end
	end
	if face.priority < 8 and p.damagecount > 0 and p.attacker and p.attacker ~= p.mo then
		if face.oldhealth - p.health > 20 then
			setFace(7, "ouch", 35)
		else
			local badguyangle = D.PointToAngle2(p.mo.x, p.mo.y, p.attacker.x, p.attacker.y)
			local diffang = (badguyangle - p.mo.angle) % D.ANGMAX
			local right = diffang > D.ANG180
			if right then diffang = D.ANGMAX - diffang end
			if diffang < D.ANG45 then
				setFace(7, "kill", 35)
			elseif right then
				setFace(7, "right", 35)
			else
				setFace(7, "left", 35)
			end
		end
	end
	if face.priority < 7 and p.damagecount > 0 then
		if face.oldhealth - p.health > 20 then
			setFace(7, "ouch", 35)
		else
			setFace(6, "kill", 35)
		end
	end
	if face.priority < 6 then
		if p.attackdown then
			if face.lastattackdown == -1 then
				face.lastattackdown = 70
			else
				face.lastattackdown = face.lastattackdown - 1
				if face.lastattackdown == 0 then
					setFace(5, "kill", 1)
					face.lastattackdown = 1
				end
			end
		else
			face.lastattackdown = -1
		end
	end
	if face.priority < 5 then
		if band(p.cheats, 2) ~= 0 or p.powers[D.pw_invulnerability] > 0 then
			setFace(4, "god", 1)
		end
	end
	if face.count <= 0 then
		face.kind = "st"
		face.n = rnd % 3
		face.count = 17
		face.priority = 0
	end
	face.count = face.count - 1
	face.oldhealth = p.health
end

local function faceName(p)
	local l = painLevel(p)
	local k = face.kind
	if k == "dead" then return "STFDEAD0" end
	if k == "god" then return "STFGOD0" end
	if k == "ouch" then return "STFOUCH" .. l end
	if k == "evil" then return "STFEVL" .. l end
	if k == "kill" then return "STFKILL" .. l end
	if k == "left" then return "STFTL" .. l .. "0" end
	if k == "right" then return "STFTR" .. l .. "0" end
	return "STFST" .. l .. face.n
end

local function GfxTex(n) return R.GfxTex(n) end

local function DrawNum(x, y, num, width, prefix, l)
	local t0 = GfxTex(prefix .. "0")
	if not t0 then return end
	local w = t0.w
	local neg = num < 0
	if neg then num = -num end
	if num == 0 then
		Draw.Patch(l, x - w, y, t0)
		return
	end
	local digits = 0
	while num > 0 and digits < width do
		x = x - w
		Draw.Patch(l, x, y, GfxTex(prefix .. (num % 10)))
		num = floor(num / 10)
		digits = digits + 1
	end
	if neg then Draw.Patch(l, x - 8, y, GfxTex("STTMINUS")) end
end

function G.DrawStatusBar()
	local p = G.player
	Draw.Patch(HUD, 0, 168, GfxTex("STBAR"))
	local wi = D.weaponinfo[p.readyweapon]
	if wi[1] ~= 5 then
		DrawNum(44, 171, p.ammo[wi[1]], 3, "STTNUM", HUD + 1)
	end
	DrawNum(90, 171, p.health, 3, "STTNUM", HUD + 1)
	Draw.Patch(HUD + 1, 90, 171, GfxTex("STTPRCNT"))
	Draw.Patch(HUD + 1, 104, 168, GfxTex("STARMS"))
	for i = 0, 5 do
		local owned = p.weaponowned[i + 1]
		Draw.Patch(HUD + 2, 111 + (i % 3) * 12, 172 + floor(i / 3) * 10, GfxTex((owned and "STYSNUM" or "STGNUM") .. (i + 2)))
	end
	Draw.Patch(HUD + 1, 143, 168, GfxTex(faceName(p)))
	DrawNum(221, 171, p.armorpoints, 3, "STTNUM", HUD + 1)
	Draw.Patch(HUD + 1, 221, 171, GfxTex("STTPRCNT"))
	-- keys (skull keys override cards of the same colour)
	for i = 0, 2 do
		local k
		if p.cards[i + 3] then k = i + 3 elseif p.cards[i] then k = i end
		if k then Draw.Patch(HUD + 1, 239, 171 + i * 10, GfxTex("STKEYS" .. k)) end
	end
	local ay = { [0] = 173, 179, 191, 185 }
	for i = 0, 3 do
		DrawNum(288, ay[i], p.ammo[i], 3, "STYSNUM", HUD + 1)
		DrawNum(314, ay[i], p.maxammo[i], 3, "STYSNUM", HUD + 1)
	end
end

-- HU font text
function G.DrawText(l, x, y, text, r, g, b)
	local cx = x
	text = text:upper()
	for i = 1, #text do
		local c = text:byte(i)
		if c == 32 then
			cx = cx + 4
		else
			local t = GfxTex(string.format("STCFN%03d", c))
			if t then
				Draw.Patch(l, cx, y, t, r, g, b)
				cx = cx + t.w
			else
				cx = cx + 4
			end
		end
	end
	return cx
end

function G.TextWidth(text)
	local w = 0
	text = text:upper()
	for i = 1, #text do
		local c = text:byte(i)
		local t = c ~= 32 and GfxTex(string.format("STCFN%03d", c))
		w = w + (t and t.w or 4)
	end
	return w
end

local function DrawFlash(p)
	local cnt = p.damagecount
	if p.powers[D.pw_strength] > 0 then
		local bzc = 12 - floor(p.powers[D.pw_strength] / 64)
		if bzc > cnt then cnt = bzc end
	end
	if cnt > 0 then
		local pal = floor((cnt + 7) / 8)
		if pal > 8 then pal = 8 end
		Draw.Rect(HUD - 10, 0, 0, 320, R.viewheight, 1, 0, 0, pal * 0.09)
	elseif p.bonuscount > 0 then
		local pal = floor((p.bonuscount + 7) / 8)
		if pal > 4 then pal = 4 end
		Draw.Rect(HUD - 10, 0, 0, 320, R.viewheight, 0.85, 0.75, 0.3, pal * 0.06)
	elseif p.powers[D.pw_ironfeet] > 4 * 32 or band(p.powers[D.pw_ironfeet], 8) ~= 0 then
		Draw.Rect(HUD - 10, 0, 0, 320, R.viewheight, 0, 1, 0, 0.12)
	end
	if p.fixedcolormap == 32 then
		Draw.Rect(HUD - 11, 0, 0, 320, R.viewheight, 0.85, 0.85, 0.85, 0.35)
	end
end

------------------------------------------------------------------------ menus
G.menu = { page = "main", item = 1 }
local menus = {
	main = { title = "M_DOOM", titley = 2, x = 97, y = 64, items = {
		{ "M_NGAME", function() G.menu.page = "episode"; G.menu.item = 1 end },
		{ "M_QUITG", function() if D.UI then D.UI.Close() end end },
	} },
	episode = { title = "M_EPISOD", titley = 38, x = 48, y = 63, items = {
		{ "M_EPI1", function() G.menu.episode = 1; G.menu.page = "skill"; G.menu.item = 3 end },
		{ "M_EPI2", function() G.menu.episode = 2; G.menu.page = "skill"; G.menu.item = 3 end },
		{ "M_EPI3", function() G.menu.episode = 3; G.menu.page = "skill"; G.menu.item = 3 end },
		{ "M_EPI4", function() G.menu.episode = 4; G.menu.page = "skill"; G.menu.item = 3 end },
	} },
	skill = { title = "M_NEWG", titley = 14, x = 48, y = 63, sub = "M_SKILL", items = {
		{ "M_JKILL", function() G.InitNew(0, G.menu.episode, 1) end },
		{ "M_ROUGH", function() G.InitNew(1, G.menu.episode, 1) end },
		{ "M_HURT", function() G.InitNew(2, G.menu.episode, 1) end },
		{ "M_ULTRA", function() G.InitNew(3, G.menu.episode, 1) end },
		{ "M_NMARE", function() G.InitNew(4, G.menu.episode, 1) end },
	} },
}

function G.OpenMenu()
	G.menuReturn = G.state
	G.state = "menu"
	G.menu.page = "main"
	G.menu.item = 1
end

function G.MenuKey(action)
	local m = menus[G.menu.page]
	local SFX = D.SFX
	if action == "up" then
		G.menu.item = G.menu.item - 1
		if G.menu.item < 1 then G.menu.item = #m.items end
		if D.Sound then D.Sound.Start(nil, SFX.pstop) end
	elseif action == "down" then
		G.menu.item = G.menu.item + 1
		if G.menu.item > #m.items then G.menu.item = 1 end
		if D.Sound then D.Sound.Start(nil, SFX.pstop) end
	elseif action == "enter" then
		if D.Sound then D.Sound.Start(nil, SFX.pistol) end
		m.items[G.menu.item][2]()
	elseif action == "back" then
		if G.menu.page == "skill" then
			G.menu.page = "episode"; G.menu.item = G.menu.episode or 1
		elseif G.menu.page == "episode" then
			G.menu.page = "main"; G.menu.item = 1
		elseif G.menuReturn == "level" then
			G.state = "level"
		end
		if D.Sound then D.Sound.Start(nil, SFX.swtchx) end
	end
end

local function DrawMenu()
	local m = menus[G.menu.page]
	Draw.Patch(HUD + 20, 94, m.titley, GfxTex(m.title))
	if m.sub then Draw.Patch(HUD + 20, 54, 38, GfxTex(m.sub)) end
	for i, it in ipairs(m.items) do
		Draw.Patch(HUD + 20, m.x, m.y + (i - 1) * 16, GfxTex(it[1]))
	end
	local skull = (floor(G.gametic / 8) % 2 == 0) and "M_SKULL1" or "M_SKULL2"
	Draw.Patch(HUD + 21, m.x - 32, m.y - 5 + (G.menu.item - 1) * 16, GfxTex(skull))
end

------------------------------------------------------------------------ intermission / finale
local function DrawIntermission()
	local wi = G.wi
	Draw.PatchStretched(HUD + 10, 0, 0, 320, 200, GfxTex("WIMAP" .. (wi.ep - 1)) or GfxTex("INTERPIC"))
	local lv = GfxTex("WILV" .. (wi.ep - 1) .. (wi.last - 1))
	if lv then
		Draw.Patch(HUD + 11, (320 - lv.w) / 2, 2, lv)
		Draw.Patch(HUD + 11, (320 - GfxTex("WIF").w) / 2, 2 + lv.h * 5 / 4, GfxTex("WIF"))
	end
	local t = wi.tic
	local function pct(y, label, val, start)
		Draw.Patch(HUD + 11, 50, y, GfxTex(label))
		if t >= start then
			local shown = math.min(val, floor((t - start) * 4))
			DrawNum(270, y, shown, 3, "WINUM", HUD + 11)
			Draw.Patch(HUD + 11, 270, y, GfxTex("WIPCNT"))
		end
	end
	pct(50, "WIOSTK", wi.kills, 10)
	pct(50 + 2 * 16, "WIOSTI", wi.items, 40)
	pct(50 + 4 * 16, "WISCRT2", wi.secret, 70)
	Draw.Patch(HUD + 11, 16, 168, GfxTex("WITIME"))
	if t >= 100 then
		local secs = wi.time
		local mm, ss = floor(secs / 60), secs % 60
		local x = 160 - 8
		DrawNum(x, 168, ss, 2, "WINUM", HUD + 11)
		if ss < 10 then Draw.Patch(HUD + 11, x - 2 * GfxTex("WINUM0").w, 168, GfxTex("WINUM0")) end
		Draw.Patch(HUD + 11, x - 2 * GfxTex("WINUM0").w - GfxTex("WICOLON").w, 168, GfxTex("WICOLON"))
		DrawNum(x - 2 * GfxTex("WINUM0").w - GfxTex("WICOLON").w, 168, mm, 2, "WINUM", HUD + 11)
		if floor(t / 16) % 2 == 0 then
			G.DrawText(HUD + 12, 180, 186, "PRESS USE TO CONTINUE")
		end
	end
end

local finaleText = {
	"YOU HAVE CONQUERED THIS EPISODE.",
	"",
	"THE NIGHTMARE IS OVER... FOR NOW.",
	"",
	"PRESS USE TO RETURN TO THE MENU.",
}
local function DrawFinale()
	Draw.Rect(HUD + 10, 0, 0, 320, 200, 0.05, 0.02, 0.02, 1)
	for i, line in ipairs(finaleText) do
		G.DrawText(HUD + 11, 20, 40 + i * 12, line)
	end
end

function G.Continue()
	if G.state == "intermission" then
		if G.wi.tic < 100 then
			G.wi.tic = 100
		else
			WorldDone()
		end
	elseif G.state == "finale" then
		G.state = "title"
	elseif G.state == "title" then
		G.OpenMenu()
		G.menuReturn = "title"
	end
end

------------------------------------------------------------------------ frame drawing
function G.Display()
	Draw.Begin()
	local st = G.state
	if st == "level" or (st == "menu" and G.menuReturn == "level") then
		local p = G.player
		if p.mo and D.AM.active then
			D.AM.Draw(p)
		elseif p.mo then
			R.RenderView(p.mo.x, p.mo.y, p.viewz, p.mo.angle, p.extralight, p.fixedcolormap ~= 0, p)
			DrawFlash(p)
		end
		G.DrawStatusBar()
		if G.messageTics > 0 and G.messageText then
			G.DrawText(HUD + 5, 2, 2, G.messageText)
		end
		if G.paused and st == "level" then
			local t = GfxTex("M_PAUSE")
			if t then Draw.Patch(HUD + 5, (320 - t.w) / 2, 4, t) end
		end
		if st == "menu" then
			Draw.Rect(HUD + 15, 0, 0, 320, 200, 0, 0, 0, 0.5)
			DrawMenu()
		end
	elseif st == "menu" then
		Draw.PatchStretched(HUD + 10, 0, 0, 320, 200, GfxTex("TITLEPIC"))
		Draw.Rect(HUD + 15, 0, 0, 320, 200, 0, 0, 0, 0.35)
		DrawMenu()
	elseif st == "title" then
		Draw.PatchStretched(HUD + 10, 0, 0, 320, 200, GfxTex("TITLEPIC"))
		if floor(G.gametic / 20) % 2 == 0 then
			local msg = "PRESS ENTER"
			G.DrawText(HUD + 11, (320 - G.TextWidth(msg)) / 2, 186, msg)
		end
	elseif st == "intermission" then
		DrawIntermission()
	elseif st == "finale" then
		DrawFinale()
	end
	Draw.End()
end
