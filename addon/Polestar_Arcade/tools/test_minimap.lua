local M = dofile("tools/mock_wow.lua")
M.LoadAddon("build/FreedoomArcade", "FreedoomArcade.toc")
local D = FreedoomArcade
FreedoomArcadeDB = nil
-- simulate ADDON_LOADED through the real event handler
for _, f in ipairs(M.Frames()) do
	local h = f.scripts.OnEvent
	if h then h(f, "ADDON_LOADED", "FreedoomArcade") end
end
local b = FreedoomArcadeMinimapButton
local fails = 0
local function check(c, m) print((c and "PASS " or "FAIL ") .. m); if not c then fails = fails + 1 end end
check(b ~= nil and b.visible, "minimap button created and shown")
check(math.abs(b.px) > 50 or math.abs(b.py) > 50, string.format("positioned on the rim (%.0f, %.0f)", b.px, b.py))
b.scripts.OnClick(b, "LeftButton")
check(FreedoomArcadeFrame and FreedoomArcadeFrame:IsShown(), "left-click opens the game")
b.scripts.OnClick(b, "LeftButton")
check(not FreedoomArcadeFrame:IsShown(), "left-click again closes it")
-- drag: cursor to the right of the minimap -> angle ~0
local gcp = GetCursorPosition
GetCursorPosition = function() return 1100, 540 end
b.scripts.OnDragStart(b); b.scripts.OnUpdate(b, 0.1); b.scripts.OnDragStop(b)
GetCursorPosition = gcp
check(math.abs(FreedoomArcadeDB.minimapPos) < 1 and b.px > 70, "drag moves it (pos " .. FreedoomArcadeDB.minimapPos .. ")")
SlashCmdList.FREEDOOMARCADE("minimap")
check(not b.visible and FreedoomArcadeDB.minimapHidden, "/doom minimap hides it")
SlashCmdList.FREEDOOMARCADE("minimap")
check(b.visible, "and shows it again")
FreedoomArcade_OnAddonCompartmentClick()
check(FreedoomArcadeFrame:IsShown(), "addon compartment click opens the game")
-- right-click menu
local G, P = D.G, D.P
b.scripts.OnClick(b, "RightButton")
check(FreedoomArcadeMinimapMenu and FreedoomArcadeMinimapMenu:IsShown(), "right-click opens the menu")
check(D.Minimap._ClickRow("1.  ") == false, "save slot disabled before a game is running")
G.InitNew(2, 1, 1)
for i = 1, 60 do G.input.forward = true; G.Ticker() end
G.input.forward = false
local x1, y1 = G.player.mo.x, G.player.mo.y
D.Minimap.ShowMenu()
check(D.Minimap._ClickRow("1.  ") == true, "save to slot 1")
check(FreedoomArcadeDB.saves and FreedoomArcadeDB.saves[1] and FreedoomArcadeDB.saves[1].map == 1, "slot 1 stored")
check(not FreedoomArcadeMinimapMenu:IsShown(), "menu closes after choosing")
for i = 1, 60 do G.input.right = true; G.input.forward = true; G.Ticker() end
G.input.right, G.input.forward = false, false
D.Minimap.ShowMenu()
D.Minimap._ClickRow("Quick save")
local qx, qy = G.player.mo.x, G.player.mo.y
check(FreedoomArcadeDB.quicksave ~= nil and (qx ~= x1 or qy ~= y1), "quick save from the menu")
for i = 1, 60 do G.input.forward = true; G.Ticker() end
G.input.forward = false
D.Minimap.ShowMenu()
-- load rows come after the "Load slot" header; the second "1.  " row is the load entry
local loadIndex
for i, row in ipairs(D.Minimap.menuRows) do
	if row.kind == "header" and row.text == "Load slot" then loadIndex = i + 1 end
end
FreedoomArcadeMinimapMenu.rows[loadIndex]:GetScript("OnClick")(FreedoomArcadeMinimapMenu.rows[loadIndex])
check(G.player.mo.x == x1 and G.player.mo.y == y1, "load slot 1 restores that position")
check(FreedoomArcadeFrame:IsShown(), "loading opens the game window")
local emptyRow = D.Minimap.menuRows[loadIndex + 1]
D.Minimap.ShowMenu()
check(D.Minimap.menuRows[loadIndex + 1].enabled == false, "empty load slot 2 is disabled")
D.Minimap._ClickRow("Quick load")
check(G.player.mo.x == qx and G.player.mo.y == qy, "quick load from the menu")
SlashCmdList.FREEDOOMARCADE("save 3")
check(FreedoomArcadeDB.saves[3] ~= nil, "/doom save 3")
SlashCmdList.FREEDOOMARCADE("load 1")
check(G.player.mo.x == x1, "/doom load 1")
print(fails == 0 and "ALL OK" or fails .. " failures")
