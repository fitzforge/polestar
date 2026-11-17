local M = dofile("tools/mock_wow.lua")
M.LoadAddon("build/FreedoomArcade", "FreedoomArcade.toc")
local D = FreedoomArcade
FreedoomArcadeDB = { width = 640, detail = "high", alwaysRun = true, mouseSens = 1, sound = true, showFPS = false }
D.UI._SetDB(FreedoomArcadeDB); D.UI.Open()
local worst, wname = 0
for ep = 1, 4 do
	local t = os.clock(); D.EnsureMapLoaded("E" .. ep .. "M1"); local lt = os.clock() - t
	print(string.format("load addon E%d: %.0f ms", ep, lt * 1000))
	for m = 1, 9 do
		local a = os.clock()
		D.G.InitNew(2, ep, m)
		local dt = os.clock() - a
		if dt > worst then worst, wname = dt, "E" .. ep .. "M" .. m end
	end
end
print(string.format("worst level init: %s %.0f ms", wname, worst * 1000))
