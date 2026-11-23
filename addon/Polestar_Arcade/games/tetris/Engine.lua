-- Tetris by beemerwt, a falling-block game in Polestar's Arcade (Polestar_Arcade/games/tetris).
-- GPL-3.0-only, as Polestar: see LICENSE in this folder and in the Polestar folder.
-- Original falling-block game. All positions are integer cells; y <= 0 is
-- the hidden spawn area. The saved run is account-wide like Doom's quicksave.
local ADDON = ...
local db = Polestar_TetrisDB
if type(db) ~= "table" then db = {}; Polestar_TetrisDB = db end
db.high = tonumber(db.high) or 0

local T = {}
PolestarTetris = T
T.db = db
T.width, T.height = 10, 20
local saved = CreateFrame("Frame")
saved:RegisterEvent("ADDON_LOADED")
saved:SetScript("OnEvent", function(_, _, name)
 if name ~= ADDON then return end
 if type(Polestar_TetrisDB) ~= "table" then Polestar_TetrisDB = {} end
 db = Polestar_TetrisDB
 db.high = tonumber(db.high) or 0
 if type(db.run) == "table" and not db.run.over then
  db.run.paused, db.run.needsRespawn = true, true
 end
 T.db = db
 saved:UnregisterEvent("ADDON_LOADED")
end)

local shapes = {
 I = {{0,1},{1,1},{2,1},{3,1}},
 O = {{1,0},{2,0},{1,1},{2,1}},
 T = {{1,0},{0,1},{1,1},{2,1}},
 S = {{1,0},{2,0},{0,1},{1,1}},
 Z = {{0,0},{1,0},{1,1},{2,1}},
 J = {{0,0},{0,1},{1,1},{2,1}},
 L = {{2,0},{0,1},{1,1},{2,1}},
}
T.shapes = shapes
local colors = { I={0.2,0.85,0.9}, O={0.95,0.8,0.2}, T={0.7,0.35,0.9},
 S={0.35,0.8,0.35}, Z={0.9,0.3,0.3}, J={0.3,0.45,0.9}, L={0.95,0.55,0.2} }
T.colors = colors
local kinds = {"I","O","T","S","Z","J","L"}

local function cells(p, x, y, rot)
 local out = {}
 x, y, rot = x or p.x, y or p.y, rot or p.rot
 for i, c in ipairs(shapes[p.kind]) do
  local cx, cy = c[1], c[2]
  if p.kind ~= "O" then
   local box = p.kind == "I" and 3 or 2
   for _ = 1, rot do cx, cy = box - cy, cx end
  end
  out[i] = {x + cx, y + cy}
 end
 return out
end
T.cells = cells

local function fits(g, p, x, y, rot)
 for _, c in ipairs(cells(p, x, y, rot)) do
  local cx, cy = c[1], c[2]
  if cx < 1 or cx > 10 or cy > 20 or (cy > 0 and g.board[cy][cx]) then return false end
 end
 return true
end
T.fits = fits

local function refill(g)
 while #g.queue < 7 do
  local bag = {unpack(kinds)}
  for i = #bag, 2, -1 do
   local j = math.random(i)
   bag[i], bag[j] = bag[j], bag[i]
  end
  for _, kind in ipairs(bag) do g.queue[#g.queue + 1] = kind end
 end
end

local function topout(g)
 g.over, g.paused = true, true
 if g.score > db.high then db.high = g.score end
end

local function spawn(g, kind)
 refill(g)
 g.piece = {kind = kind or table.remove(g.queue, 1), x = 4, y = 0, rot = 0}
 refill(g)
 g.holdUsed, g.lastRotate, g.lockTime, g.fallTime = false, false, 0, 0
 if not fits(g, g.piece) then topout(g) end
end

function T.New()
 local g = {board = {}, queue = {}, score = 0, lines = 0, level = 1,
  combo = -1, b2b = false, paused = false, over = false, hold = nil}
 for y = 1, 20 do g.board[y] = {} end
 db.run = g
 spawn(g)
 return g
end
function T.Run() return db.run end

-- The eight SRS transitions, in board coordinates (positive y downward).
local kicks = {
 ["0>1"]={{0,0},{-1,0},{-1,-1},{0,2},{-1,2}},
 ["1>0"]={{0,0},{1,0},{1,1},{0,-2},{1,-2}},
 ["1>2"]={{0,0},{1,0},{1,1},{0,-2},{1,-2}},
 ["2>1"]={{0,0},{-1,0},{-1,-1},{0,2},{-1,2}},
 ["2>3"]={{0,0},{1,0},{1,-1},{0,2},{1,2}},
 ["3>2"]={{0,0},{-1,0},{-1,1},{0,-2},{-1,-2}},
 ["3>0"]={{0,0},{-1,0},{-1,1},{0,-2},{-1,-2}},
 ["0>3"]={{0,0},{1,0},{1,-1},{0,2},{1,2}},
}
local iKicks = {
 ["0>1"]={{0,0},{-2,0},{1,0},{-2,1},{1,-2}},
 ["1>0"]={{0,0},{2,0},{-1,0},{2,-1},{-1,2}},
 ["1>2"]={{0,0},{-1,0},{2,0},{-1,-2},{2,1}},
 ["2>1"]={{0,0},{1,0},{-2,0},{1,2},{-2,-1}},
 ["2>3"]={{0,0},{2,0},{-1,0},{2,-1},{-1,2}},
 ["3>2"]={{0,0},{-2,0},{1,0},{-2,1},{1,-2}},
 ["3>0"]={{0,0},{1,0},{-2,0},{1,2},{-2,-1}},
 ["0>3"]={{0,0},{-1,0},{2,0},{-1,-2},{2,1}},
}
function T.Move(dx, dy)
 local g = db.run
 if not g or g.paused or g.over then return false end
 local p = g.piece
 if not fits(g, p, p.x + dx, p.y + dy) then return false end
 p.x, p.y = p.x + dx, p.y + dy
 g.lastRotate = false
 if dy > 0 then g.lockTime = 0 end
 return true
end
function T.Rotate(dir)
 local g = db.run
 if not g or g.paused or g.over then return false end
 local p = g.piece
 if p.kind == "O" then return true end
 local nextRot = (p.rot + dir + 4) % 4
 local list = (p.kind == "I" and iKicks or kicks)[p.rot .. ">" .. nextRot]
 for _, k in ipairs(list) do
  if fits(g, p, p.x + k[1], p.y + k[2], nextRot) then
   p.x, p.y, p.rot = p.x + k[1], p.y + k[2], nextRot
   g.lastRotate, g.lockTime = true, 0
   return true
  end
 end
 return false
end
local function tspin(g)
 if g.piece.kind ~= "T" or not g.lastRotate then return false end
 local p = g.piece
 local count = 0
 for _, corner in ipairs({{0,0},{2,0},{0,2},{2,2}}) do
  local x, y = p.x + corner[1], p.y + corner[2]
  if x < 1 or x > 10 or y > 20 or (y > 0 and g.board[y][x]) then count = count + 1 end
 end
 return count >= 3
end
local function lock(g)
 local spin = tspin(g)
 for _, c in ipairs(cells(g.piece)) do
  if c[2] <= 0 then topout(g); return end
  g.board[c[2]][c[1]] = g.piece.kind
 end
 local clear = 0
 local y = 20
 while y >= 1 do
  local full = true
  for x = 1, 10 do if not g.board[y][x] then full = false; break end end
  if full then
   table.remove(g.board, y)
   table.insert(g.board, 1, {})
   clear = clear + 1
  else y = y - 1 end
 end
 if clear > 0 then
  g.combo = g.combo + 1
  local base = spin and ({[1]=800,[2]=1200,[3]=1600})[clear]
   or ({[1]=100,[2]=300,[3]=500,[4]=800})[clear]
  local difficult = spin or clear == 4
  g.score = g.score + math.floor((base or 100) * g.level * (difficult and g.b2b and 1.5 or 1))
   + math.max(0, g.combo) * 50 * g.level
  g.b2b = difficult
  g.lines = g.lines + clear
  g.level = 1 + math.floor(g.lines / 10)
 else g.combo = -1 end
 if g.score > db.high then db.high = g.score end
 spawn(g)
end
function T.HardDrop()
 local g = db.run
 if not g or g.paused or g.over then return end
 local distance = 0
 while fits(g, g.piece, g.piece.x, g.piece.y + 1) do
  g.piece.y = g.piece.y + 1
  distance = distance + 1
 end
 g.score = g.score + distance * 2
 lock(g)
end
function T.SoftDrop()
 if T.Move(0, 1) then
  db.run.score = db.run.score + 1
  if db.run.score > db.high then db.high = db.run.score end
 end
end
function T.Hold()
 local g = db.run
 if not g or g.paused or g.over or g.holdUsed then return end
 local previous = g.piece.kind
 if g.hold then spawn(g, g.hold) else spawn(g) end
 g.hold, g.holdUsed = previous, true
end
function T.GhostY()
 local g = db.run
 if not g or not g.piece then return nil end
 local y = g.piece.y
 while fits(g, g.piece, g.piece.x, y + 1) do y = y + 1 end
 return y
end
function T.GhostCells()
 local g = db.run
 if not g or not g.piece or g.over then return {} end
 return cells(g.piece, g.piece.x, T.GhostY())
end
function T.Tick(dt)
 local g = db.run
 if not g or g.paused or g.over then return end
 local changed = false
 local speed = math.max(0.08, math.pow(0.8 - (g.level - 1) * 0.007, g.level - 1))
 g.fallTime = (g.fallTime or 0) + dt
 while g.fallTime >= speed do
  g.fallTime = g.fallTime - speed
  if fits(g, g.piece, g.piece.x, g.piece.y + 1) then
   g.piece.y = g.piece.y + 1
   changed = true
  else break end
 end
 if fits(g, g.piece, g.piece.x, g.piece.y + 1) then g.lockTime = 0
 else
  g.lockTime = (g.lockTime or 0) + dt
  if g.lockTime >= 0.5 then lock(g); changed = true end
 end
 return changed
end
function T.Pause()
 local g = db.run
 if not g or g.over then return end
 if g.paused and g.needsRespawn then
  g.piece.x, g.piece.y = 4, 0
  g.fallTime, g.lockTime = 0, 0
  g.needsRespawn = false
  if not fits(g, g.piece) then topout(g); return end
 end
 g.paused = not g.paused
end
function T.CloseRun()
 local g = db.run
 if g and not g.over then
  g.paused, g.needsRespawn = true, true
  if g.score > db.high then db.high = g.score end
  return true
 end
 return false
end
