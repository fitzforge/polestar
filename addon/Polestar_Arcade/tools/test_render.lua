-- Static render test: luajit tools/test_render.lua MAP out.ppm [angleDegrees]
local M = dofile("tools/mock_wow.lua")
for _, f in ipairs({ "src/core.lua", "build/FreedoomArcade/data/info.lua", "build/FreedoomArcade/data/assets.lua",
	"src/level.lua", "src/draw.lua", "src/render.lua" }) do dofile(f) end
local D = FreedoomArcade
local map = arg[1] or "E1M1"
D.EnsureMapLoaded(map)
local L = D.LoadLevelGeometry(map)
local root = CreateFrame("Frame", nil, UIParent)
D.Draw.Init(root)
D.Draw.SetScale(640, 400)
D.R.SetViewSize(320, 168)
D.R.Init()
local px, py, pa
for _, t in ipairs(L.mapthings) do
	if t.type == 1 then px, py, pa = t.x, t.y, t.angle end
end
if arg[3] then pa = tonumber(arg[3]) end
if arg[4] then px = tonumber(arg[4]); py = tonumber(arg[5]) end
local ss = D.PointInSubsector(px, py)
local vz = ss.sector.floorheight + 41
local t0 = os.clock()
local N = 20
for i = 1, N do
	D.Draw.Begin()
	D.R.RenderView(px, py, vz, pa / 360 * D.ANGMAX, 0, false, nil)
	D.Draw.End()
end
local dt = (os.clock() - t0) / N
local nds, nvp, nvs = D.R.Stats()
print(string.format("frame %.2f ms  quads=%d drawsegs=%d visplanes=%d", dt * 1000, D.Draw.stats.quads, nds, nvp))
M.Screenshot(root, arg[2] or "out.ppm", 640, 400)
