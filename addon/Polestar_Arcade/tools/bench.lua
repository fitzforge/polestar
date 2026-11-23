local M = dofile("tools/mock_wow.lua")
M.LoadAddon("build/FreedoomArcade", "FreedoomArcade.toc")
local D = FreedoomArcade
local G, UI = D.G, D.UI
FreedoomArcadeDB = { width = 640, detail = arg[2] or "high", alwaysRun = true, mouseSens = 1, sound = true, showFPS = false }
UI._SetDB(FreedoomArcadeDB)
UI.Open()
SlashCmdList.FREEDOOMARCADE("detail " .. FreedoomArcadeDB.detail)
G.InitNew(2, 1, tonumber(arg[1]) or 1)
local frame = FreedoomArcadeFrame
local inp = G.input
local N = 350
local tr, tg = 0, 0
local maxr = 0
local qsum = 0
for i = 1, N do
	inp.forward = (i % 120) < 80
	inp.left = (i % 120) >= 80
	inp.fire = (i % 50) < 10
	local a = os.clock()
	G.Ticker()
	local b = os.clock()
	G.Display()
	local c = os.clock()
	tg = tg + (b - a); tr = tr + (c - b)
	if c - b > maxr then maxr = c - b end
	qsum = qsum + D.Draw.stats.quads
end
print(string.format("map E1M%s detail=%s: game %.2f ms/tic, render %.2f ms/frame (max %.1f), avg quads %d, textures created %d",
	arg[1] or 1, FreedoomArcadeDB.detail, tg / N * 1000, tr / N * 1000, maxr * 1000, qsum / N, D.Draw.TextureCount()))
