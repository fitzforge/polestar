-- Headless game test through the WoW mock.
-- luajit tools/test_game.lua <script> ; script is a list of "tics action" lines
local M = dofile("tools/mock_wow.lua")
M.LoadAddon("build/FreedoomArcade", "FreedoomArcade.toc")
local D = FreedoomArcade
local G, UI = D.G, D.UI
-- fire ADDON_LOADED
for _, f in ipairs({}) do end
FreedoomArcadeDB = { width = 640, detail = "high", alwaysRun = true, mouseSens = 1, sound = true, showFPS = false }
UI._SetDB(FreedoomArcadeDB)

UI.Open()
local frame = FreedoomArcadeFrame
local shotN = 0
local function shot(name)
	shotN = shotN + 1
	local view
	-- find the view frame: child of FreedoomArcadeFrame with clip
	M.Screenshot(nil, "shots/" .. name .. ".ppm", 640, 480 + 24)
end

local function tic(n)
	for _ = 1, n do
		M.Advance(1 / 35)
		UI._OnUpdate(frame, 1 / 35)
	end
end

local function key(k, down)
	if down then UI._OnKeyDown(frame, k) else UI._OnKeyUp(frame, k) end
end
local function press(k) key(k, true); tic(1); key(k, false) end

local script = arg[1] or "default"
local t0 = os.clock()
if script == "default" then
	tic(5)
	shot("g00_title")
	press("ENTER")          -- title -> menu
	tic(2)
	shot("g01_menu")
	press("ENTER")          -- new game -> episode
	press("ENTER")          -- episode 1 -> skill
	tic(2)
	shot("g02_skill")
	press("ENTER")          -- hurt me plenty
	tic(10)
	shot("g03_start")
	key("W", true); tic(60); key("W", false)
	tic(5)
	shot("g04_walk")
	key("LEFT", true); tic(20); key("LEFT", false)
	key("LCTRL", true); tic(30); key("LCTRL", false)
	tic(3)
	shot("g05_fire")
	key("W", true); tic(120); key("W", false)
	press("SPACE")
	tic(40)
	shot("g06_more")
elseif script == "automap" then
	G.InitNew(2, 1, 1)
	key("W", true); tic(90); key("W", false)
	press("TAB"); tic(2)
	shot("am1_explored")
	G.player.powers[D.pw_allmap] = 1
	press("-"); press("-"); tic(2)
	shot("am2_allmap")
	press("TAB"); tic(2)
	shot("am3_back")
end
local p = G.player
print(string.format("state=%s tic=%d pos=(%.1f,%.1f,%.1f) angle=%.1f health=%d ammo=%d kills=%d/%d thinkers=%d quads=%d  cpu=%.2fs",
	G.state, G.gametic, p.mo and p.mo.x or 0, p.mo and p.mo.y or 0, p.mo and p.mo.z or 0,
	p.mo and p.mo.angle / D.ANGMAX * 360 or 0, p.health, p.ammo[0], p.killcount, G.totalkills, #D.P.thinkers, D.Draw.stats.quads, os.clock() - t0))
