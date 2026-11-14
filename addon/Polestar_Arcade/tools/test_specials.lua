local M = dofile("tools/mock_wow.lua")
M.LoadAddon("build/FreedoomArcade", "FreedoomArcade.toc")
local D = FreedoomArcade
local G, UI, P, L = D.G, D.UI, D.P, D.level
FreedoomArcadeDB = { width = 640, detail = "high", alwaysRun = true, mouseSens = 1, sound = true, showFPS = false }
UI._SetDB(FreedoomArcadeDB)
UI.Open()
local function run(n) for _ = 1, n do G.Ticker() end end
local fails = 0
local function check(cond, msg) print((cond and "PASS " or "FAIL ") .. msg); if not cond then fails = fails + 1 end end

-- run all maps briefly with a wandering player to catch runtime errors
for ep = 1, 4 do for m = 1, 9 do
	G.InitNew(3, ep, m)
	local inp = G.input
	local ok, err = pcall(function()
		for i = 1, 200 do
			inp.forward = (i % 60) < 40; inp.right = (i % 60) >= 40; inp.fire = (i % 30) < 5; inp.use = (i % 20) == 0
			G.Ticker()
			if i % 10 == 0 then G.Display() end
		end
	end)
	if not ok then print("ERROR E" .. ep .. "M" .. m .. ": " .. tostring(err)); fails = fails + 1 end
end end
print("ran all 36 maps")

-- doors: find a manual door (special 1) in E1M1 and use it
G.InitNew(2, 1, 1)
local p = G.player
local doorline
for i = 0, L.numlines - 1 do if L.lines[i].special == 1 then doorline = L.lines[i] break end end
check(doorline ~= nil, "E1M1 has a manual door")
if doorline then
	local sec = L.sides[doorline.sidenum[1]].sector
	local before = sec.ceilingheight
	P.UseSpecialLine(p.mo, doorline, 0)
	run(60)
	check(sec.ceilingheight > before, string.format("door opened %d -> %d", before, sec.ceilingheight))
	run(300)
	check(sec.ceilingheight == before, "door closed again: " .. sec.ceilingheight)
end
-- lift (downWaitUpStay 62 / 88 / 21 / 10) anywhere in episode 1
local found
for m = 1, 9 do
	G.InitNew(2, 1, m)
	for i = 0, L.numlines - 1 do
		local s = L.lines[i].special
		if s == 62 or s == 21 or s == 88 or s == 10 or s == 120 or s == 123 then found = L.lines[i] break end
	end
	if found then
		local tag = found.tag
		local sec
		for j = 0, L.numsectors - 1 do if L.sectors[j].tag == tag then sec = L.sectors[j] break end end
		local before = sec.floorheight
		P.UseSpecialLine(G.player.mo, found, 0)
		P.CrossSpecialLine(found, 0, G.player.mo)
		run(40)
		check(sec.floorheight < before, string.format("E1M%d lift lowered %d -> %d", m, before, sec.floorheight))
		run(250)
		check(sec.floorheight == before, "lift returned " .. sec.floorheight)
		break
	end
end
-- exit -> intermission -> next map
G.InitNew(2, 1, 1)
G.ExitLevel()
run(2)
check(G.state == "intermission", "exit goes to intermission")
G.Display()
M.Screenshot(nil, "shots/t_inter.ppm", 640, 504)
G.Continue(); G.Continue()
check(G.state == "level" and G.gamemap == 2, "continued to E1M2")
-- secret exit from E1M3 -> E1M9 -> back to E1M4
G.InitNew(2, 1, 3); G.SecretExitLevel(); run(2); G.Continue(); G.Continue()
check(G.gamemap == 9, "secret exit to E1M9")
G.ExitLevel(); run(2); G.Continue(); G.Continue()
check(G.gamemap == 4, "E1M9 returns to E1M4")
-- death and respawn
for k in pairs(G.input) do if type(G.input[k]) == "boolean" then G.input[k] = false end end
G.InitNew(2, 1, 1)
p = G.player
P.DamageMobj(p.mo, nil, nil, 1000)
run(80)
check(p.playerstate == "dead", "player died")
G.input.use = true; run(3); G.input.use = false; run(3)
check(G.player.health == 100 and G.player.mo and G.state == "level", "respawned after death")
-- monster kills via damage
G.InitNew(2, 1, 1)
local killed = 0
for _, th in ipairs(P.thinkers) do
	if th.flags and D.band(th.flags, D.MF.COUNTKILL) ~= 0 then P.DamageMobj(th, G.player.mo, G.player.mo, 1000); killed = killed + 1 end
end
run(100)
check(G.player.killcount == killed, "killcount " .. G.player.killcount .. "/" .. killed)
G.Display()
print(fails == 0 and "ALL OK" or (fails .. " failures"))
