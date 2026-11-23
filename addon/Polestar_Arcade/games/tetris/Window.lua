-- Tetris by beemerwt, a falling-block game in Polestar's Arcade (Polestar_Arcade/games/tetris).
-- GPL-3.0-only, as Polestar: see LICENSE in this folder and in the Polestar folder.
-- The window and its keys; Maps/Arcade.lua opens it (the flight card, /polestar tetris, the guide
-- menu), puts it away before a landing, and keeps one game open at a time.
local T = PolestarTetris
local L = Polestar.L
local tile = 20
local frame, blocks, ghost, status, score, nextPreview, holdPreview, pauseButton
local held, repeatAt = {}, {}
local clock = 0
local repeating = {LEFT=true, RIGHT=true, DOWN=true, PADDLEFT=true, PADDRIGHT=true, PADDDOWN=true}

local function label(parent, text, x, y)
 local f = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
 f:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
 f:SetText(text)
 return f
end

local function paint(texture, kind, alpha)
 if not kind then texture:Hide(); return end
 local c = T.colors[kind]
 texture:SetColorTexture(c[1], c[2], c[3], alpha or 1)
 texture:Show()
end

local function makePreview(parent, title, x)
 label(parent, title, x, -123)
 local slot = CreateFrame("Frame", nil, parent)
 slot:SetSize(56, 56)
 slot:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -142)
 slot.cells = {}
 for y = 1, 4 do
  for col = 1, 4 do
   local bg = slot:CreateTexture(nil, "ARTWORK", nil, 0)
   bg:SetSize(13, 13)
   bg:SetPoint("TOPLEFT", slot, "TOPLEFT", (col-1)*14, -(y-1)*14)
   bg:SetColorTexture(0.12, 0.14, 0.19, 1)
   local block = slot:CreateTexture(nil, "ARTWORK", nil, 1)
   block:SetAllPoints(bg)
   block:Hide()
   slot.cells[(y-1)*4 + col] = block
  end
 end
 return slot
end

local function renderPreview(slot, kind)
 slot.kind = kind
 for _, cell in ipairs(slot.cells) do cell:Hide() end
 if not kind then return end
 for _, pos in ipairs(T.cells({kind=kind, x=1, y=1, rot=0})) do
  paint(slot.cells[(pos[2]-1)*4 + pos[1]], kind)
 end
end

local function render()
 if not frame then return end
 local g = T.Run()
 if not g then return end
 for y = 1, 20 do
  for x = 1, 10 do
   paint(blocks[y][x], g.board[y][x])
   ghost[y][x]:Hide()
  end
 end
 if g.piece and not g.over then
  for _, c in ipairs(T.GhostCells()) do
   if c[2] > 0 and c[2] <= 20 then paint(ghost[c[2]][c[1]], g.piece.kind, 0.3) end
  end
  for _, c in ipairs(T.cells(g.piece)) do
   if c[2] > 0 and c[2] <= 20 then paint(blocks[c[2]][c[1]], g.piece.kind) end
  end
 end
 score:SetText(L["Score %d\nLines %d\nLevel %d\nBest %d"]:format(g.score, g.lines, g.level, T.db.high))
 renderPreview(nextPreview, g.queue[1])
 renderPreview(holdPreview, g.hold)
 status:SetText(g.over and L["Game over — New game"] or (g.paused and L["Paused — press P or Start"] or ""))
 pauseButton:SetText(g.over and L["New game"] or (g.paused and L["Resume"] or L["Pause"]))
end

local function action(key)
 if key == "P" or key == "PADFORWARD" then T.Pause()
 elseif key == "N" then T.New()
 elseif key == "LEFT" or key == "PADDLEFT" then T.Move(-1, 0)
 elseif key == "RIGHT" or key == "PADDRIGHT" then T.Move(1, 0)
 elseif key == "DOWN" or key == "PADDDOWN" then T.SoftDrop()
 elseif key == "UP" or key == "X" or key == "PAD1" then T.Rotate(1)
 elseif key == "Z" or key == "PAD2" then T.Rotate(-1)
 elseif key == "SPACE" or key == "PAD3" or key == "PADDUP" then T.HardDrop()
 elseif key == "C" or key == "LSHIFT" or key == "PAD4" or key == "PADLSHOULDER" then T.Hold()
 elseif key == "ESCAPE" then PolestarTetrisAPI.Close(true) end
 render()
end

local function makeButton(parent, text, x, y, width, click)
 local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
 b:SetSize(width, 22)
 b:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
 b:SetText(text)
 b:SetScript("OnClick", click)
 return b
end

local function make()
 local f = CreateFrame("Frame", "PolestarTetrisFrame", UIParent, "BackdropTemplate")
 frame = f
 f:SetSize(420, 478)
 f:SetPoint("CENTER")
 f:SetFrameStrata("DIALOG")
 f:SetClampedToScreen(true)
 f:EnableMouse(true)
 f:EnableKeyboard(true)
 if f.EnableGamePadButton then f:EnableGamePadButton(true) end
 f:SetBackdrop({bgFile = "Interface/Buttons/WHITE8X8", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 14})
 f:SetBackdropColor(0.04, 0.05, 0.09, 0.96)
 label(f, L["Polestar Tetris"], 14, -12)
 score = label(f, "", 222, -45)
 nextPreview = makePreview(f, L["Next"], 222)
 holdPreview = makePreview(f, L["Hold"], 320)
 f.NextPreview, f.HoldPreview = nextPreview, holdPreview
 status = label(f, "", 14, -457)
 f.KeyboardControls = label(f, L["Arrows move\nX/Z rotate  |  C hold\nSpace hard drop\nP pause  |  N new game"], 222, -215)
 f.GamepadControls = label(f, L["D-pad move\nA/B rotate  |  Y hold\nX hard drop  |  Start pause"], 222, -290)
 pauseButton = makeButton(f, L["Pause"], 220, -360, 185, function()
  if T.Run() and T.Run().over then T.New() else T.Pause() end
  render()
 end)
 makeButton(f, L["New game"], 220, -388, 185, function() T.New(); render() end)
 makeButton(f, L["Close"], 220, -416, 185, function() PolestarTetrisAPI.Close(true) end)
 blocks, ghost = {}, {}
 for y = 1, 20 do
  blocks[y], ghost[y] = {}, {}
  for x = 1, 10 do
   local bg = f:CreateTexture(nil, "ARTWORK", nil, 0)
   bg:SetSize(tile - 1, tile - 1)
   bg:SetPoint("TOPLEFT", f, "TOPLEFT", 14 + (x-1)*tile, -50 - (y-1)*tile)
   bg:SetColorTexture(0.13, 0.15, 0.2, 1)
   local gh = f:CreateTexture(nil, "ARTWORK", nil, 1)
   gh:SetAllPoints(bg)
   ghost[y][x] = gh
   local b = f:CreateTexture(nil, "OVERLAY", nil, 1)
   b:SetAllPoints(bg)
   blocks[y][x] = b
  end
 end
 f:SetScript("OnKeyDown", function(_, key)
  action(key)
  if repeating[key] then held[key], repeatAt[key] = true, clock + 0.25 end
 end)
 f:SetScript("OnGamePadButtonDown", function(_, key)
  action(key)
  if repeating[key] then held[key], repeatAt[key] = true, clock + 0.25 end
 end)
 f:SetScript("OnKeyUp", function(_, key) held[key] = nil end)
 f:SetScript("OnGamePadButtonUp", function(_, key) held[key] = nil end)
 f:SetScript("OnHide", function() held = {}; repeatAt = {}; T.CloseRun() end)
 f:SetScript("OnUpdate", function(_, dt)
  clock = clock + dt
  for key in pairs(held) do
   if clock >= (repeatAt[key] or 0) then
    action(key)
    repeatAt[key] = clock + 0.07
   end
  end
  if T.Tick(dt) then render() end
 end)
 f:Hide()
 if Polestar.Gamepad and Polestar.Gamepad.Register then
  Polestar.Gamepad.Register(f, {
   rows = function() return {} end,
   key = function(key) action(key); return true end,
   back = function() PolestarTetrisAPI.Close(true) end,
  })
 end
 return f
end

PolestarTetrisAPI = {
 version = 1,
 Open = function()
  if InCombatLockdown and InCombatLockdown() then return false end
  if not frame then make() end
  if not T.Run() then T.New() end
  frame:Show()
  render()
  return true
 end,
 Close = function()
  if not frame or not frame:IsShown() then return false end
  local saved = T.CloseRun()
  frame:Hide()
  return saved
 end,
 IsOpen = function() return frame and frame:IsShown() or false end,
}

-- A fight with the window open (on the ground as on a flight): the run is saved and paused and the
-- keys are the character's again.
Polestar.RegisterEvent("PLAYER_REGEN_DISABLED", function()
 if not PolestarTetrisAPI.IsOpen() then return end
 PolestarTetrisAPI.Close(true)
 Polestar.Print(L["Tetris is saved and paused for the fight: type %s to continue."]:format("/polestar tetris"))
end)

Polestar.Arcade.Register("tetris", PolestarTetrisAPI)
