-- Save/load round trip + aggro handling
local M = dofile("tools/mock_wow.lua")
M.LoadAddon("build/FreedoomArcade", "FreedoomArcade.toc")
local D = FreedoomArcade
local G, P, L, UI = D.G, D.P, D.level, D.UI
FreedoomArcadeDB = { width = 640, detail = "high", alwaysRun = true, mouseSens = 1, sound = true, showFPS = false, aggroPause = true }
UI._SetDB(FreedoomArcadeDB)
UI.Open()
local fails = 0
local function check(c, m) print((c and "PASS " or "FAIL ") .. m); if not c then fails = fails + 1 end end
local function run(n) for _ = 1, n do G.Ticker() end end

-- fingerprint of the whole simulation
local function fingerprint()
	local parts = { P.leveltime, string.format("%.3f,%.3f,%.3f", G.player.mo.x, G.player.mo.y, G.player.mo.z), G.player.health }
	for _, th in ipairs(P.thinkers) do
		if not th.removed then
			if th.think == P.MobjThinker then
				parts[#parts + 1] = string.format("m%d:%.3f,%.3f,%.3f,%d,%d,%d", th.type, th.x, th.y, th.z, th.statenum, th.tics, th.health)
			elseif th.kind then
				parts[#parts + 1] = th.kind .. (th.sector and th.sector.floorheight .. "/" .. th.sector.ceilingheight or "")
			end
		end
	end
	for i = 0, L.numsectors - 1 do parts[#parts + 1] = L.sectors[i].lightlevel end
	parts[#parts + 1] = table.concat({ D.GetRandomState() }, ",")
	return table.concat(parts, "|")
end

for _, mapn in ipairs({ { 1, 1 }, { 1, 3 }, { 2, 4 }, { 4, 2 } }) do
	for k in pairs(G.input) do if type(G.input[k]) == "boolean" then G.input[k] = false end end
	G.InitNew(3, mapn[1], mapn[2])
	-- play a bit: walk, shoot, open doors
	for i = 1, 300 do
		G.input.forward = (i % 80) < 50; G.input.right = (i % 80) >= 50; G.input.fire = (i % 25) < 4; G.input.use = (i % 15) == 0
		G.Ticker()
		if G.player.playerstate ~= "live" then break end
	end
	for k in pairs(G.input) do if type(G.input[k]) == "boolean" then G.input[k] = false end end
	if G.player.playerstate == "live" and G.state == "level" then
		check(UI.QuickSave(), string.format("E%dM%d quicksave", mapn[1], mapn[2]))
		run(70)
		local expected = fingerprint()
		-- mess the world up, then load and replay the same 70 tics
		run(200)
		check(UI.QuickLoad(), "quickload")
		run(70)
		local got = fingerprint()
		check(got == expected, "E" .. mapn[1] .. "M" .. mapn[2] .. " replay after load is identical")
		if got ~= expected then
			local a, b = expected, got
			local n = 1
			while a:sub(n, n) == b:sub(n, n) do n = n + 1 end
			print("  differ at: " .. a:sub(math.max(1, n - 60), n + 60))
			print("  got      : " .. b:sub(math.max(1, n - 60), n + 60))
		end
	end
end

-- save survives being written as SavedVariables (no functions / cycles)
local function serialize(v, seen)
	local t = type(v)
	if t == "table" then
		assert(not seen[v], "cycle"); seen[v] = true
		local out = {}
		for k, x in pairs(v) do out[#out + 1] = "[" .. serialize(k, seen) .. "]=" .. serialize(x, seen) end
		seen[v] = nil
		return "{" .. table.concat(out, ",") .. "}"
	elseif t == "string" then return string.format("%q", v)
	elseif t == "number" or t == "boolean" then return tostring(v)
	else error("bad type " .. t) end
end
local ok, s = pcall(serialize, FreedoomArcadeDB.quicksave, {})
check(ok, "save serializes cleanly (" .. (ok and #s or 0) .. " bytes)")
if ok then
	local reloaded = loadstring("return " .. s)()
	FreedoomArcadeDB.quicksave = reloaded
	check(UI.QuickLoad(), "load from re-parsed SavedVariables text")
	run(10)
end

-- aggro
UI.Open()
G.paused = false
check(FreedoomArcadeFrame:IsShown(), "window open before combat")
UI.OnAggro()
check(not FreedoomArcadeFrame:IsShown(), "aggro closed the window")
check(G.paused and G.keepPaused, "aggro paused the game")
local before = P.leveltime
UI.Open()
run(20)
check(P.leveltime == before and G.paused, "still paused after reopening")
UI._OnKeyDown(FreedoomArcadeFrame, "P"); UI._OnKeyUp(FreedoomArcadeFrame, "P")
run(5)
check(not G.paused and P.leveltime > before, "P resumes")
print(fails == 0 and "ALL OK" or fails .. " failures")
