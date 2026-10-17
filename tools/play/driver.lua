-- The playground's Lua side (tools/play): one long-lived Lua 5.1 process
-- running the real addons against tests/lua/wow_stub.lua, the stub world and
-- the preview overlay (tools/preview/stub.lua), driven by tools/play/session.js
-- over stdin/stdout.
--
-- Loaded after the stubs and before any addon file. The session then loads
-- the addons, logs in and calls play.serve(), which reads requests forever:
--
--   <byte count>\n<Lua chunk>        the chunk runs; what it returns is the reply
--   @@R <json>\n                     the reply: { ok, value | error, errors, ms }
--
-- What this adds to the stubs, so the UI behaves as it does in the client:
--   - geometry: GetLeft/GetTop/GetRect/GetWidth/IsMouseOver... from the anchors
--     (the same rules tools/preview/render.js draws with), and the cursor;
--   - input: mouse focus with OnEnter/OnLeave, clicks (OnMouseDown/Up and
--     GLOBAL_MOUSE_DOWN/UP, OnClick for the buttons registered for it), the
--     wheel, drags that move or size frames (StartMoving/StartSizing),
--     sliders, keyboard focus and typing, Escape (UISpecialFrames), slash
--     commands;
--   - errors: a script, timer or message handler that raises is reported (as
--     the client's error frame does) and the caller carries on;
--   - a world map canvas (the Blizzard_MapCanvas shape Polestar reads) for Nav
--     pins, Maps' fog reveal and labels, with the zone's art when the local
--     art cache has it;
--   - SavedVariables and the character's world, serialized for the session.

play = play or {}
local M = stub.Methods
local RunScript = stub.RunScript
local SW, SH = 1920, 1080
local type, pairs, ipairs, tostring, tonumber, format = type, pairs, ipairs, tostring, tonumber, string.format

---------------------------------------------------------------------------
-- Errors: reported, never fatal (the client's error handler)
---------------------------------------------------------------------------

play.errors = {}
local errorSeq = 0
local function report(err)
	errorSeq = errorSeq + 1
	local msg = tostring(err)
	local trace = debug.traceback("", 2)
	local list = play.errors
	list[#list + 1] = { n = errorSeq, msg = msg, trace = trace, t = stub.now }
	if #list > 40 then table.remove(list, 1) end
	return msg
end
play.report = report
function geterrorhandler() return report end
function seterrorhandler() end

local function traceback(err) return { msg = tostring(err), trace = debug.traceback("", 2) } end

local guarded = setmetatable({}, { __mode = "k" }) -- fn -> its guard
local function guard(fn)
	if type(fn) ~= "function" then return fn end
	local g = guarded[fn]
	if g then return g end
	g = function(...)
		local n, args = select("#", ...), { ... }
		local ok, e = xpcall(function() return fn(unpack(args, 1, n)) end, traceback)
		if not ok then
			errorSeq = errorSeq + 1
			local list = play.errors
			list[#list + 1] = { n = errorSeq, msg = e.msg, trace = e.trace, t = stub.now }
			if #list > 40 then table.remove(list, 1) end
		end
	end
	guarded[fn] = g
	return g
end

-- Mouse scripts enable the mouse when set, as in the client; GetScript
-- returns what was set, not its guard.
local MOUSE_SCRIPTS = { OnEnter = true, OnLeave = true, OnMouseDown = true, OnMouseUp = true, OnClick = true, OnDragStart = true, OnDoubleClick = true }
local setScript, hookScript = M.SetScript, M.HookScript
function M.SetScript(self, name, fn)
	self.origScripts = self.origScripts or {}
	self.origScripts[name] = fn
	setScript(self, name, guard(fn))
	if fn and MOUSE_SCRIPTS[name] and self.mouse == nil then self.mouse = true end
	if fn and name == "OnMouseWheel" and self.mouseWheel == nil then self.mouseWheel = true end
end
function M.GetScript(self, name)
	if self.origScripts and self.origScripts[name] ~= nil then return self.origScripts[name] end
	return self.scripts[name]
end
function M.HookScript(self, name, fn) hookScript(self, name, guard(fn)) end

local after, newTimer, newTicker = C_Timer.After, C_Timer.NewTimer, C_Timer.NewTicker
function C_Timer.After(s, fn) return after(s, guard(fn)) end
function C_Timer.NewTimer(s, fn) return newTimer(s, guard(fn)) end
function C_Timer.NewTicker(s, fn, n) return newTicker(s, guard(fn), n) end

-- print() and emit() write to stdout in the test harness; here stdout is the
-- protocol, so they go to the chat log.
function print(...)
	local parts = {}
	for i = 1, select("#", ...) do parts[i] = tostring((select(i, ...))) end
	table.insert(stub.messages, table.concat(parts, " "))
end
function emit() end

---------------------------------------------------------------------------
-- Frames the client makes mouse- and keyboard-aware by kind
---------------------------------------------------------------------------

-- Visibility as the client has it: OnShow and OnHide fire when a frame's
-- visibility changes, which happens to every shown descendant when an
-- ancestor is shown or hidden; Show under a hidden parent fires nothing yet.
local function parentVisible(f)
	local p = f.parent
	while p do
		if not p.shown then return false end
		p = p.parent
	end
	return true
end
local function cascade(f, name)
	RunScript(f, name)
	local kids = f.children
	if not kids or #kids == 0 then return end
	local list = {}
	for i = 1, #kids do list[i] = kids[i] end
	for i = 1, #list do
		local c = list[i]
		if c.shown and c.parent == f then cascade(c, name) end
	end
end
function M.Show(self)
	if self.shown then return end
	self.shown = true
	if parentVisible(self) then cascade(self, "OnShow") end
end
function M.Hide(self)
	if not self.shown then return end
	local was = parentVisible(self)
	self.shown = false
	if was then cascade(self, "OnHide") end
end

local INPUT_KINDS = { Button = true, CheckButton = true, Slider = true, EditBox = true }
local createFrame = CreateFrame
function CreateFrame(kind, ...)
	local f = createFrame(kind, ...)
	if INPUT_KINDS[kind] then f.mouse = true end
	if kind == "EditBox" then f.text = f.text or "" end
	return f
end

function M.EnableMouse(self, v) self.mouse = v and true or false end
function M.EnableMouseWheel(self, v) self.mouseWheel = v and true or false end
function M.RegisterForDrag(self, ...)
	self.dragButtons = {}
	for i = 1, select("#", ...) do self.dragButtons[(select(i, ...))] = true end
end
function M.RegisterForClicks(self, ...)
	self.clickButtons = {}
	for i = 1, select("#", ...) do self.clickButtons[(select(i, ...))] = true end
end
function M.SetClampedToScreen(self, v) self.clamped = v and true or false end
function M.IsClampedToScreen(self) return self.clamped == true end
function M.SetResizeBounds(self, minW, minH, maxW, maxH) self.bounds = { minW, minH, maxW, maxH } end
function M.SetMinResize(self, w, h) self.bounds = self.bounds or {}; self.bounds[1], self.bounds[2] = w, h end
function M.SetMaxResize(self, w, h) self.bounds = self.bounds or {}; self.bounds[3], self.bounds[4] = w, h end
function M.StartMoving(self) self.moving = true; play.moving = self end
function M.StartSizing(self, point) self.sizing = point or "BOTTOMRIGHT"; play.sizing = self end
function M.StopMovingOrSizing(self)
	self.moving, self.sizing = false, nil
	if play.moving == self then play.moving = nil end
	if play.sizing == self then play.sizing = nil end
end
function M.IsDragging(self) return play.dragging == self end

-- The client fires OnTextChanged (userInput false) when code sets an edit
-- box's text, and the focus scripts when focus moves.
local setText = M.SetText
function M.SetText(self, t)
	local before = self.text
	setText(self, t)
	if self.kind == "EditBox" and self.text ~= before then RunScript(self, "OnTextChanged", false) end
end
function M.SetFocus(self)
	if stub.focus == self then return end
	local old = stub.focus
	stub.focus = self
	if old then RunScript(old, "OnEditFocusLost") end
	RunScript(self, "OnEditFocusGained")
end
function M.ClearFocus(self)
	if stub.focus ~= self then return end
	stub.focus = nil
	RunScript(self, "OnEditFocusLost")
end
function M.GetCursorPosition(self) return #(self.text or "") end
function M.SetCursorPosition() end
function M.HighlightText() end

-- The client makes a scroll frame its scroll child's parent (so it clips
-- and hides with it).
local setScrollChild = M.SetScrollChild
function M.SetScrollChild(self, c)
	setScrollChild(self, c)
	if type(c) == "table" and c.points then
		c.scrollOwner = self
		if c.parent ~= self then
			local old = c.parent
			if old and old.children then
				for i = #old.children, 1, -1 do
					if old.children[i] == c then table.remove(old.children, i) end
				end
			end
			c.parent = self
			table.insert(self.children, c)
		end
	end
end

---------------------------------------------------------------------------
-- Geometry from the anchors (screen pixels, top-left origin, as render.js)
---------------------------------------------------------------------------

local H = { LEFT = 0, CENTER = 0.5, RIGHT = 1, TOPLEFT = 0, TOP = 0.5, TOPRIGHT = 1, BOTTOMLEFT = 0, BOTTOM = 0.5, BOTTOMRIGHT = 1 }
local V = { TOP = 0, CENTER = 0.5, BOTTOM = 1, TOPLEFT = 0, LEFT = 0.5, TOPRIGHT = 0, RIGHT = 0.5, BOTTOMLEFT = 1, BOTTOMRIGHT = 1 }
local function isRegion(o) return o.kind == "Texture" or o.kind == "FontString" or o.kind == "MaskTexture" or o.kind == "Line" end
local function num(v) return type(v) == "number" and v or nil end

local function scaleOf(o)
	local s, f = 1, o
	if isRegion(o) then f = o.parent end
	while f do
		s = s * (num(f.scale) or 1)
		f = f.parent
	end
	return s
end
play.scaleOf = scaleOf

local visiting = {}
local memo -- o -> { x, y, w, h } while a snapshot is taken (nothing moves)
local function rectOf(o)
	if o == UIParent then return 0, 0, SW, SH end
	if memo then
		local r = memo[o]
		if r then return r[1], r[2], r[3], r[4] end
	end
	if visiting[o] then return 0, 0, 0, 0 end
	visiting[o] = true
	local s = scaleOf(o)
	local x, y, w, h
	local sp = o.scrollOwner
	if sp and sp.scrollChild == o then
		local px, py = rectOf(sp)
		x, y, w, h = px, py - (sp.scroll or 0) * s, (num(o.width) or 0) * s, (num(o.height) or 0) * s
	elseif #o.points == 0 then
		local px, py = 0, 0
		if o.parent then px, py = rectOf(o.parent) end
		x, y, w, h = px, py, (num(o.width) or 0) * s, (num(o.height) or 0) * s
	else
		local left, right, top, bottom, cx, cy
		for _, p in ipairs(o.points) do
			local rel = p.rel
			if type(rel) == "string" then rel = _G[rel] end
			rel = rel or o.parent
			local bx, by, bw, bh = 0, 0, 0, 0
			if type(rel) == "table" and rel.points then bx, by, bw, bh = rectOf(rel) end
			local ax = bx + bw * (H[p.relPoint] or 0) + (p.x or 0) * s
			local ay = by + bh * (V[p.relPoint] or 0) - (p.y or 0) * s
			local hx, vy = H[p.point] or 0, V[p.point] or 0
			if hx == 0 then left = ax elseif hx == 1 then right = ax else cx = ax end
			if vy == 0 then top = ay elseif vy == 1 then bottom = ay else cy = ay end
		end
		if left and right then w = right - left elseif num(o.width) then w = o.width * s end
		if top and bottom then h = bottom - top elseif num(o.height) then h = o.height * s end
		if o.kind == "FontString" then
			if not w then w = M.GetStringWidth(o) * s end
			if not h then h = M.GetStringHeight(o) * s end
		end
		w, h = w or 0, h or 0
		x = left or (right and right - w) or (cx and cx - w / 2) or 0
		y = top or (bottom and bottom - h) or (cy and cy - h / 2) or 0
	end
	visiting[o] = nil
	if memo then memo[o] = { x, y, w, h } end
	return x, y, w, h
end
play.rectOf = rectOf

-- A shown frame entirely outside a clipping ancestor (a scroll frame's rows
-- scrolled out of view) draws nothing and takes no mouse: left out of the dump.
local function clippedOut(f)
	local x, y, w, h = rectOf(f)
	local p = f.parent
	while p do
		if p.clips or p.kind == "ScrollFrame" then
			local cx, cy, cw, ch = rectOf(p)
			if x >= cx + cw or x + w <= cx or y >= cy + ch or y + h <= cy then return true end
		end
		p = p.parent
	end
	return false
end

local function twoSided(o, a, b)
	local ha, hb
	for _, p in ipairs(o.points) do
		local k = a[p.point]
		if k == 0 then ha = true elseif k == 1 then hb = true end
	end
	return ha and hb
end

function M.GetWidth(self)
	if twoSided(self, H) then
		local _, _, w = rectOf(self)
		return w / scaleOf(self)
	end
	if num(self.width) then return self.width end
	if self.kind == "FontString" then return M.GetStringWidth(self) end
	return 0
end
function M.GetHeight(self)
	if twoSided(self, V) then
		local _, _, _, h = rectOf(self)
		return h / scaleOf(self)
	end
	if num(self.height) then return self.height end
	if self.kind == "FontString" then return M.GetStringHeight(self) end
	return 0
end
function M.GetSize(self) return M.GetWidth(self), M.GetHeight(self) end
function M.GetLeft(self) local x = rectOf(self); return x / scaleOf(self) end
function M.GetRight(self) local x, _, w = rectOf(self); return (x + w) / scaleOf(self) end
function M.GetTop(self) local _, y = rectOf(self); return (SH - y) / scaleOf(self) end
function M.GetBottom(self) local _, y, _, h = rectOf(self); return (SH - y - h) / scaleOf(self) end
function M.GetCenter(self)
	local x, y, w, h = rectOf(self)
	local s = scaleOf(self)
	return (x + w / 2) / s, (SH - y - h / 2) / s
end
function M.GetRect(self)
	local x, y, w, h = rectOf(self)
	local s = scaleOf(self)
	return x / s, (SH - y - h) / s, w / s, h / s
end
function M.GetScaledRect(self)
	local x, y, w, h = rectOf(self)
	return x, SH - y - h, w, h
end
function M.IsMouseOver(self, top, bottom, left, right)
	local cx, cy = stub.cursor[1], stub.cursor[2]
	if cx < 0 then return false end
	local x, y, w, h = rectOf(self)
	local s = scaleOf(self)
	return cx >= x + (left or 0) * s and cx <= x + w + (right or 0) * s
		and cy <= SH - y + (top or 0) * s and cy >= SH - y - h + (bottom or 0) * s
end
function M.GetVerticalScrollRange(self)
	local c = self.scrollChild
	if not c then return self.scrollRange or 0 end
	return math.max(0, M.GetHeight(c) - M.GetHeight(self))
end

stub.cursor = { -1, -1 }
function GetMouseFocus() return play.mouseFocus end
function GetMouseFoci() return { play.mouseFocus } end
function GetCursorInfo() return nil end
function IsMouseButtonDown(b) return play.buttonDown ~= nil and (b == nil or b == play.buttonDown) end
function GetMouseButtonClicked() return play.lastButton end

---------------------------------------------------------------------------
-- Input
---------------------------------------------------------------------------

local function object(id)
	local o = id and preview.object(id)
	return o
end

-- x, y: screen pixels from the top left (the page's coordinates).
function play.cursor(x, y)
	if x == nil then
		stub.cursor = { -1, -1 }
	else
		stub.cursor = { x, SH - y }
	end
end

function play.hover(id, x, y)
	play.cursor(x, y)
	local new = object(id)
	local old = play.mouseFocus
	if new == old then return end
	play.mouseFocus = new
	preview.hover = new
	if old then RunScript(old, "OnLeave", true) end
	if new then RunScript(new, "OnEnter", true) end
end

local function clickable(f, button)
	local reg = f.clickButtons
	if not reg then return button == "LeftButton" end
	return reg[button .. "Up"] or reg.AnyUp or reg[button .. "Down"] or reg.AnyDown or false
end

local function clearFocusUnless(f)
	if stub.focus and stub.focus ~= f then M.ClearFocus(stub.focus) end
end

local function sliderTo(f, x)
	local sx, _, sw = rectOf(f)
	local lo, hi = f.minValue or 0, f.maxValue or 1
	local frac = sw > 0 and math.max(0, math.min(1, (x - sx) / sw)) or 0
	local v = lo + (hi - lo) * frac
	local step = f.valueStep
	if step and step > 0 then v = lo + math.floor((v - lo) / step + 0.5) * step end
	if v ~= f.value then
		f.value = v
		RunScript(f, "OnValueChanged", v, true)
	end
end

function play.mouseDown(id, button, x, y)
	play.cursor(x, y)
	local f = object(id)
	clearFocusUnless(f)
	button = button or "LeftButton"
	if not f then
		stub.fire("GLOBAL_MOUSE_DOWN", button)
		return
	end
	play.buttonDown, play.lastButton = button, button
	if f.kind == "Slider" and f.enabled ~= false then sliderTo(f, x) end
	if f.kind == "EditBox" then M.SetFocus(f) end
	if f.enabled ~= false or f.kind ~= "Button" then RunScript(f, "OnMouseDown", button) end
	stub.fire("GLOBAL_MOUSE_DOWN", button)
end

function play.mouseUp(id, button, x, y, clicked)
	play.cursor(x, y)
	local f = object(id)
	button = button or "LeftButton"
	play.buttonDown = nil
	if not f then
		stub.fire("GLOBAL_MOUSE_UP", button)
		return
	end
	if f.enabled ~= false or f.kind ~= "Button" then RunScript(f, "OnMouseUp", button) end
	stub.fire("GLOBAL_MOUSE_UP", button)
	if clicked and (f.kind == "Button" or f.kind == "CheckButton") and f.enabled ~= false and clickable(f, button) then
		if f.kind == "CheckButton" then f.checked = not f.checked end
		RunScript(f, "PreClick", button, false)
		RunScript(f, "OnClick", button, false)
		RunScript(f, "PostClick", button, false)
	end
end

function play.click(id, button, x, y)
	play.mouseDown(id, button, x, y)
	play.mouseUp(id, button, x, y, true)
end

function play.wheel(id, delta, x, y)
	play.cursor(x, y)
	local f = object(id)
	while f do
		if f.scripts and f.scripts.OnMouseWheel then
			RunScript(f, "OnMouseWheel", delta)
			return
		end
		f = f.parent
	end
end

-- A drag: the frame under the cursor gets OnMouseDown, then OnDragStart when
-- registered for the button. A frame that started moving or sizing follows
-- the cursor until the drag stops; a slider follows it too.
local drag
function play.dragStart(id, button, x, y, x0, y0)
	button = button or "LeftButton"
	play.mouseDown(id, button, x0 or x, y0 or y)
	local f = object(id)
	drag = { f = f, button = button, x = x0 or x, y = y0 or y }
	play.dragging = f
	if f and f.dragButtons and f.dragButtons[button] then RunScript(f, "OnDragStart", button) end
	local mv = play.moving or play.sizing
	if mv then
		local rx, ry, rw, rh = rectOf(mv)
		drag.target, drag.rect = mv, { rx, ry, rw, rh }
	end
	play.dragMove(x, y)
end

local function clampRect(f, x, y, w, h)
	if not f.clamped then return x, y end
	return math.max(0, math.min(SW - w, x)), math.max(0, math.min(SH - h, y))
end

function play.dragMove(x, y)
	if not drag then return end
	play.cursor(x, y)
	local f, t = drag.f, drag.target
	if f and f.kind == "Slider" and f.enabled ~= false then sliderTo(f, x) end
	if t and t.moving then
		local r = drag.rect
		local s = scaleOf(t)
		local nx, ny = clampRect(t, r[1] + (x - drag.x), r[2] + (y - drag.y), r[3], r[4])
		t.points = {}
		M.SetPoint(t, "TOPLEFT", UIParent, "BOTTOMLEFT", nx / s, (SH - ny) / s)
	elseif t and t.sizing then
		local r = drag.rect
		local s = scaleOf(t)
		local b = t.bounds or {}
		local dx, dy = (x - drag.x) / s, (y - drag.y) / s
		local w, h = r[3] / s, r[4] / s
		local pt = t.sizing
		if pt:find("RIGHT") then w = w + dx elseif pt:find("LEFT") then w = w - dx end
		if pt:find("BOTTOM") then h = h + dy elseif pt:find("TOP") then h = h - dy end
		w = math.max(b[1] or 1, math.min(b[3] or 1e6, w))
		h = math.max(b[2] or 1, math.min(b[4] or 1e6, h))
		-- Pinned by the opposite corner, as the client sizes.
		local left = pt:find("LEFT") and (r[1] + r[3]) / s - w or r[1] / s
		local top = pt:find("TOP") and (SH - r[2] - r[4]) / s + h or (SH - r[2]) / s
		t.points = {}
		M.SetPoint(t, "TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
		t.width, t.height = w, h
		RunScript(t, "OnSizeChanged", w, h)
	end
end

function play.dragStop(x, y)
	if not drag then return end
	play.dragMove(x, y)
	local f, button = drag.f, drag.button
	drag = nil
	play.dragging = nil
	if f and f.dragButtons and f.dragButtons[button] then RunScript(f, "OnDragStop") end
	play.mouseUp(f and play.idOf(f), button, x, y, false)
	if play.moving then M.StopMovingOrSizing(play.moving) end
	if play.sizing then M.StopMovingOrSizing(play.sizing) end
end

-- The dump id of an object (assigned on first sight).
function play.idOf(o)
	return o and play.ids[o]
end

-- Keys: into the focused edit box, else Escape closes windows.
local function utf8Drop(s)
	local i = #s
	while i > 0 do
		local b = s:byte(i)
		i = i - 1
		if b < 0x80 or b >= 0xC0 then break end
	end
	return s:sub(1, i)
end

local function closeSpecial()
	local closed = false
	for _, name in ipairs(UISpecialFrames) do
		local f = _G[name]
		if type(f) == "table" and f.shown and f.Hide then
			f:Hide()
			closed = true
		end
	end
	if WorldMapFrame.shown then
		WorldMapFrame:Hide()
		closed = true
	end
	return closed
end
play.closeSpecial = closeSpecial

function play.key(key, text)
	local f = stub.focus
	if f then
		if key == "ESCAPE" then
			if f.scripts.OnEscapePressed then RunScript(f, "OnEscapePressed") else M.ClearFocus(f) end
		elseif key == "ENTER" then
			RunScript(f, "OnEnterPressed")
		elseif key == "TAB" then
			RunScript(f, "OnTabPressed")
		elseif key == "BACKSPACE" then
			local t = f.text or ""
			if t ~= "" then
				f.text = utf8Drop(t)
				RunScript(f, "OnTextChanged", true)
			end
		elseif text and text ~= "" then
			local max = f.maxLetters
			if not (max and max > 0 and #(f.text or "") >= max) then
				f.text = (f.text or "") .. text
				RunScript(f, "OnChar", text)
				RunScript(f, "OnTextChanged", true)
			end
		end
		return
	end
	if key == "ESCAPE" then closeSpecial() end
end
function M.SetMaxLetters(self, n) self.maxLetters = n end

-- "/polestar options", "/run code", or any registered slash command.
function play.slash(line)
	line = tostring(line or ""):gsub("^%s+", "")
	local cmd, rest = line:match("^/(%S+)%s*(.-)%s*$")
	if not cmd then return false, "not a slash command" end
	cmd = cmd:lower()
	if cmd == "run" or cmd == "script" then
		local fn, err = loadstring(rest)
		if not fn then return false, err end
		guard(fn)()
		return true
	end
	for key, fn in pairs(SlashCmdList) do
		local i = 1
		while true do
			local s = _G["SLASH_" .. key .. i]
			if not s then break end
			if s:lower() == "/" .. cmd then
				guard(fn)(rest, nil)
				return true
			end
			i = i + 1
		end
	end
	table.insert(stub.messages, "|cffff6060Unknown command: /" .. cmd .. "|r")
	return false, "unknown command /" .. cmd
end

function play.popup(i, choice)
	local p = stub.popups[i]
	if not p then return end
	table.remove(stub.popups, i)
	local d = StaticPopupDialogs[p.which]
	if not d then return end
	local fn = choice == "accept" and d.OnAccept or d.OnCancel
	if fn then guard(fn)(nil, p.args[1], p.args[2]) end
end

---------------------------------------------------------------------------
-- The world map: tests/lua/wow_stub.lua's map canvas (the Blizzard_MapCanvas
-- shape Polestar reads), drawn as the client draws it
---------------------------------------------------------------------------

local NAV = "Interface\\AddOns\\Polestar\\Media\\Nav\\"
local MAP_W, MAP_H = 1002, 668

local map = WorldMapFrame
local canvas, art, mapName, me, meArrow
local LEVELS = { PIN_FRAME_LEVEL_MAP_EXPLORATION = 5, PIN_FRAME_LEVEL_QUEST_BLOB = 8 }

local function buildMap()
	-- Above the addon's windows, as the client raises the map when it opens.
	map:SetFrameStrata("FULLSCREEN")
	map:SetSize(MAP_W, MAP_H + 34)
	map:SetPoint("CENTER", UIParent, "CENTER", 0, 10)
	map.shown = false
	map.mouse = true
	local edge = map:CreateTexture(nil, "BACKGROUND")
	edge:SetPoint("TOPLEFT", -2, 2)
	edge:SetPoint("BOTTOMRIGHT", 2, -2)
	edge:SetColorTexture(0.02, 0.02, 0.03, 1)
	local head = map:CreateTexture(nil, "BORDER")
	head:SetPoint("TOPLEFT", 0, 0)
	head:SetPoint("TOPRIGHT", 0, 0)
	head.height = 34
	head:SetColorTexture(0.09, 0.08, 0.06, 1)
	mapName = map:CreateFontString(nil, "OVERLAY")
	mapName:SetFont(STANDARD_TEXT_FONT, 15, "")
	mapName:SetTextColor(1, 0.82, 0, 1)
	mapName:SetPoint("TOPLEFT", map, "TOPLEFT", 14, -9)
	local close = CreateFrame("Button", "WorldMapFrameCloseButton", map)
	close:SetSize(26, 26)
	close:SetPoint("TOPRIGHT", map, "TOPRIGHT", -4, -4)
	local x = close:CreateFontString(nil, "OVERLAY")
	x:SetFont(STANDARD_TEXT_FONT, 16, "")
	x:SetTextColor(0.9, 0.85, 0.7, 1)
	x:SetPoint("CENTER", close, "CENTER", 0, 0)
	x:SetText("x")
	close:SetScript("OnClick", function() map:Hide() end)
	map.ScrollContainer:ClearAllPoints()
	map.ScrollContainer:SetPoint("TOPLEFT", map, "TOPLEFT", 0, -34)
	map.ScrollContainer:SetSize(MAP_W, MAP_H)
	canvas = CreateFrame("Frame", nil, map.ScrollContainer)
	canvas:SetPoint("TOPLEFT", map.ScrollContainer, "TOPLEFT", 0, 0)
	canvas:SetSize(MAP_W, MAP_H)
	canvas:SetClipsChildren(true)
	canvas.mouse = true
	local ground = canvas:CreateTexture(nil, "BACKGROUND", nil, -8)
	ground:SetAllPoints(canvas)
	ground:SetColorTexture(0.2, 0.24, 0.18, 1)
	art = {}
	me = CreateFrame("Frame", nil, canvas)
	me:SetFrameLevel(canvas:GetFrameLevel() + 100)
	me:SetSize(24, 24)
	meArrow = me:CreateTexture(nil, "OVERLAY")
	meArrow:SetAllPoints(me)
	meArrow:SetTexture(NAV .. "arrow")
	function map.GetCanvas() return canvas end
	local levels = { GetValidFrameLevel = function(_, t) return canvas:GetFrameLevel() + (LEVELS[t] or 20) end }
	function map.GetPinFrameLevelsManager() return levels end
	function map.SetMapID(_, id) play.openMap(id) end
	if UISpecialFrames then table.insert(UISpecialFrames, "WorldMapFrame") end
end
buildMap()

local function paintArt(id)
	for _, t in ipairs(art) do t:Hide() end
	local layers = C_Map.GetMapArtLayers and C_Map.GetMapArtLayers(id)
	local info = layers and layers[1]
	local tex = info and C_Map.GetMapArtLayerTextures(id, 1)
	if not (info and tex and #tex > 0) then return false end
	local cols = math.ceil(info.layerWidth / info.tileWidth)
	for i, fid in ipairs(tex) do
		local t = art[i]
		if not t then
			t = canvas:CreateTexture(nil, "BACKGROUND", nil, -7)
			art[i] = t
		end
		local col, row = (i - 1) % cols, math.floor((i - 1) / cols)
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", canvas, "TOPLEFT", col * info.tileWidth, -row * info.tileHeight)
		t:SetSize(info.tileWidth, info.tileHeight)
		t:SetTexture(fid)
		t:Show()
	end
	return true
end

local function placeMe()
	local w = stub.world
	if w.map == stub.worldMapID and w.x and w.y then
		me:ClearAllPoints()
		me:SetPoint("CENTER", canvas, "TOPLEFT", w.x / 100 * MAP_W, -w.y / 100 * MAP_H)
		meArrow:SetRotation(w.facing or 0)
		me:Show()
	else
		me:Hide()
	end
end

-- Open the world map on uiMapID `id` (the player's map by default).
function play.openMap(id)
	id = id or stub.world.map
	stub.worldMapID = id
	local info = C_Map.GetMapInfo(id)
	mapName:SetText(info and info.name or ("Map " .. tostring(id)))
	paintArt(id)
	placeMe()
	map:Show()
	-- The map's next frame: what Polestar draws there shows at once.
	guard(stub.runMapFrame)(map, 0)
end
function play.toggleMap()
	if map.shown then map:Hide() else play.openMap() end
end

-- The minimap: a dark disc at the top right with the player at its centre.
local function buildMinimap()
	Minimap:ClearAllPoints()
	Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -36, -30)
	stub.minimapZoom = stub.minimapZoom or 2
	local rim = Minimap:CreateTexture(nil, "BACKGROUND", nil, -1)
	rim:SetTexture(NAV .. "pin-fill")
	rim:SetVertexColor(0.04, 0.04, 0.05, 1)
	rim:SetPoint("CENTER")
	rim:SetSize(146 * 64 / 42, 146 * 64 / 42)
	local disc = Minimap:CreateTexture(nil, "BACKGROUND")
	disc:SetTexture(NAV .. "pin-fill")
	disc:SetVertexColor(0.17, 0.2, 0.15, 1)
	disc:SetPoint("CENTER")
	disc:SetSize(140 * 64 / 42, 140 * 64 / 42)
	local player = CreateFrame("Frame", nil, Minimap)
	player:SetFrameLevel(100)
	player:SetSize(20, 20)
	player:SetPoint("CENTER")
	local arrow = player:CreateTexture(nil, "OVERLAY")
	arrow:SetAllPoints(player)
	arrow:SetTexture(NAV .. "arrow")
	play.minimapArrow = arrow
	local zone = UIParent:CreateFontString(nil, "OVERLAY")
	zone:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
	zone:SetTextColor(1, 0.82, 0, 1)
	zone:SetPoint("BOTTOM", Minimap, "TOP", 0, 8)
	play.zoneText = zone
end
buildMinimap()

---------------------------------------------------------------------------
-- The guide simulator's goal logic (tools/lib/playtest.js)
---------------------------------------------------------------------------

local actorSource, actorGuide, actor
function play.installSim(source)
	actorSource = source
end

local function actorFor(G)
	if actor and actorGuide == G then return actor end
	local fn, err = loadstring(actorSource .. "\nreturn act")
	if not fn then error(err) end
	actor, actorGuide = fn(), G
	return actor
end

local function syncZone()
	local w = stub.world
	local info = w.map and C_Map.GetMapInfo(w.map)
	if info and info.name and info.name ~= "" and info.name ~= w.zone then w.setZone(info.name, "") end
end
play.syncZone = syncZone

local function openGoal(view)
	for _, g in ipairs(view.goals) do
		if g.status ~= "done" and g.status ~= "na" and not g.optional and g.t ~= "note" then return g end
	end
end

-- Complete the current step's first open goal the way the simulator does.
-- -> what happened: "done" | "advanced" | "stuck" | "noguide"
function play.doGoal()
	local E = Polestar.Engine
	local G, i = E.GetGuide(), E.GetStepIndex()
	if not (G and i) then return "noguide" end
	local view = E.GetStepView(i)
	local open = openGoal(view)
	if not open then
		stub.advance(0.6)
		return E.GetStepIndex() ~= i and "advanced" or "stuck"
	end
	local act = actorFor(G)
	act(i, open, G.steps[i].goals[open.index])
	syncZone()
	local after = E.GetStepView(i)
	local same = E.GetStepIndex() == i and after and after.goals[open.index].status ~= "done"
	if same and open.manual then
		E.ToggleGoal(i, open.index)
		stub.advance(0.6)
		same = E.GetStepIndex() == i and E.GetStepView(i).goals[open.index].status ~= "done"
	end
	if same then return "stuck" end
	return E.GetStepIndex() ~= i and "advanced" or "done"
end

-- Play goals until the step changes (or the guide ends, or a goal sticks).
function play.playStep()
	local E = Polestar.Engine
	local i = E.GetStepIndex()
	for _ = 1, 80 do
		local r = play.doGoal()
		if r ~= "done" or E.GetStepIndex() ~= i then return r end
	end
	return "stuck"
end

-- Play the active guide to its end. -> result, steps played
function play.playGuide(limit)
	local E = Polestar.Engine
	local G = E.GetGuide()
	local n = 0
	for _ = 1, limit or 4000 do
		if E.GetGuide() ~= G or not E.GetStepIndex() then return "complete", n end
		local r = play.doGoal()
		if r == "stuck" or r == "noguide" then return r, n end
		n = n + 1
	end
	return "limit", n
end

---------------------------------------------------------------------------
-- Serialization (SavedVariables, the character's world)
---------------------------------------------------------------------------

local function serialize(v, indent, seen)
	local t = type(v)
	if t == "string" then return format("%q", v) end
	if t == "number" then
		if v ~= v or v == math.huge or v == -math.huge then return "0" end
		-- "%.0f", not "%d": Lua 5.1 on Windows formats "%d" through a 32-bit long.
		if v == math.floor(v) and math.abs(v) < 2 ^ 53 then return v == 0 and "0" or format("%.0f", v) end
		return format("%.17g", v)
	end
	if t == "boolean" then return tostring(v) end
	if t ~= "table" or seen[v] then return "nil" end
	seen[v] = true
	local pad = indent .. "\t"
	local parts = {}
	local n = #v
	for i = 1, n do parts[#parts + 1] = pad .. serialize(v[i], pad, seen) .. "," end
	local keys = {}
	for k in pairs(v) do
		local kt = type(k)
		if not (kt == "number" and k >= 1 and k <= n and k == math.floor(k)) and (kt == "string" or kt == "number" or kt == "boolean") then
			keys[#keys + 1] = k
		end
	end
	table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
	for _, k in ipairs(keys) do
		local val = v[k]
		local vt = type(val)
		if vt == "string" or vt == "number" or vt == "boolean" or vt == "table" then
			local key = (type(k) == "string" and k:match("^[%a_][%w_]*$")) and k or ("[" .. serialize(k, pad, seen) .. "]")
			parts[#parts + 1] = pad .. key .. " = " .. serialize(val, pad, seen) .. ","
		end
	end
	seen[v] = nil
	if #parts == 0 then return "{}" end
	return "{\n" .. table.concat(parts, "\n") .. "\n" .. indent .. "}"
end
play.serialize = function(v) return serialize(v, "", {}) end

-- SavedVariables as the client writes them: one assignment per variable.
function play.savedVariables(names)
	local out = {}
	for _, name in ipairs(names) do
		local v = _G[name]
		if v ~= nil then out[#out + 1] = name .. " = " .. serialize(v, "", {}) end
	end
	return table.concat(out, "\n") .. "\n"
end

local WORLD_KEYS = { "level", "xp", "xpMax", "race", "raceName", "raceID", "class", "className", "classID", "faction",
	"map", "x", "y", "facing", "bindLocation", "zone", "subzone", "log", "completed", "titles", "items", "skills",
	"spells", "recipes", "factions", "areas", "explored", "achievements" }
function play.worldSnapshot()
	local w, snap = stub.world, {}
	for _, k in ipairs(WORLD_KEYS) do snap[k] = w[k] end
	return "return " .. serialize(snap, "", {}) .. "\n"
end
function play.restoreWorld(snap)
	if type(snap) ~= "table" then return end
	for _, k in ipairs(WORLD_KEYS) do
		if snap[k] ~= nil then stub.world[k] = snap[k] end
	end
end

---------------------------------------------------------------------------
-- The reply: a compact JSON encoder (no key sorting; the dump is large)
---------------------------------------------------------------------------

local ESC = { ['"'] = '\\"', ['\\'] = '\\\\', ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t' }
local function escChar(c) return ESC[c] or format("\\u%04x", c:byte()) end
local floor, huge, find, gsub = math.floor, math.huge, string.find, string.gsub
local buf, n = {}, 0
local function encString(v)
	if find(v, '[%z\1-\31"\\]') then return '"' .. gsub(v, '[%z\1-\31"\\]', escChar) .. '"' end
	return '"' .. v .. '"'
end
local keyCache = {} -- object keys are a small fixed set
local function encKey(k)
	local s = keyCache[k]
	if not s then
		s = encString(k) .. ":"
		keyCache[k] = s
	end
	return s
end
local function enc(v)
	local t = type(v)
	n = n + 1
	if t == "string" then
		buf[n] = encString(v)
	elseif t == "number" then
		if v ~= v or v == huge or v == -huge then buf[n] = "null"
		-- "%.0f", not "%d", as in serialize().
		elseif v == floor(v) and v > -1e15 and v < 1e15 then buf[n] = v == 0 and "0" or format("%.0f", v)
		else buf[n] = format("%.10g", v) end
	elseif t == "boolean" then
		buf[n] = v and "true" or "false"
	elseif t == "table" then
		local len = #v
		if len > 0 or next(v) == nil then
			-- An array (Polestar's arrays have no holes); {} is an empty one.
			buf[n] = "["
			for i = 1, len do
				if i > 1 then n = n + 1; buf[n] = "," end
				enc(v[i])
			end
			n = n + 1
			buf[n] = "]"
		else
			buf[n] = "{"
			local first = true
			for k, val in pairs(v) do
				local vt, kt = type(val), type(k)
				if (vt == "string" or vt == "number" or vt == "boolean" or vt == "table") and (kt == "string" or kt == "number") then
					n = n + 1
					local key = kt == "string" and encKey(k) or ('"' .. tostring(k) .. '":')
					buf[n] = first and key or ("," .. key)
					first = false
					enc(val)
				end
			end
			n = n + 1
			buf[n] = "}"
		end
	else
		buf[n] = "null"
	end
end
function play.json(v)
	n = 0
	enc(v)
	local s = table.concat(buf, "", 1, n)
	for i = n + 1, #buf do buf[i] = nil end
	return s
end

---------------------------------------------------------------------------
-- The frame dump with what input needs
---------------------------------------------------------------------------

play.ids = setmetatable({}, { __mode = "k" })
preview.entryExtra = function(o, e)
	play.ids[o] = e.id
	if isRegion(o) or not o.scripts then return end
	if o.mouse then e.mouse = true end
	if o.mouseWheel or o.scripts.OnMouseWheel then e.wheel = true end
	if o.dragButtons and next(o.dragButtons) then e.drag = true end
	if o.enabled == false then e.disabled = true end
	if stub.focus == o then e.focus = true end
end

---------------------------------------------------------------------------
-- The session's state, for the control panel
---------------------------------------------------------------------------

local LOOK = { "ui.style", "ui.compact", "ui.scale", "ui.width", "ui.bgOpacity", "ui.opacity", "ui.scheme", "ui.accent",
	"ui.bgColor", "ui.brightness", "ui.upcoming", "ui.upcomingOpen", "ui.showNotes", "ui.menuScale", "ui.font", "ui.locked", "ui.shown" }

-- Stored overrides as { "path.to.key", value } pairs. An empty table holds no
-- override (a section reset to its defaults), so it is not reported: pasting
-- Polestar.Set("ui", {}) in game would wipe the whole section.
local function flatten(t, prefix, out)
	for k, v in pairs(t) do
		local key = prefix == "" and tostring(k) or (prefix .. "." .. tostring(k))
		if type(v) == "table" and not (#v > 0) then
			if next(v) ~= nil then flatten(v, key, out) end
		else
			out[#out + 1] = { key, v }
		end
	end
	return out
end

local function guideState()
	local E = Polestar.Engine
	local G = E and E.GetGuide and E.GetGuide()
	if not G then return nil end
	local i = E.GetStepIndex()
	local steps = {}
	for s, step in ipairs(G.steps) do steps[s] = step.title or ("Step " .. s) end
	local goals = {}
	local view = i and E.GetStepView(i)
	if view then
		local UI = Polestar.UI
		for gi, g in ipairs(view.goals) do
			local ok, text = pcall(UI.PlainGoalText, g)
			goals[gi] = { text = ok and text or tostring(g.t), status = g.status, t = g.t }
		end
	end
	local done, total = E.GetProgress()
	local tabs, active = E.GetTabs()
	local tabList = {}
	for ti, t in ipairs(tabs or {}) do tabList[ti] = { id = t.guideId, title = t.title } end
	local GF = Polestar.UI and Polestar.UI.GuideFrame
	return {
		id = G.id, title = G.title, step = i, count = #G.steps, steps = steps, goals = goals,
		done = done, total = total, pending = E.PendingRouteChoice and E.PendingRouteChoice() or nil,
		nextChoices = G.nextChoices, next = G.next, tabs = tabList, activeTab = active,
		hasTip = GF and GF.parts and GF.parts.tip and GF.parts.tip.shown or false,
		banner = GF and GF.BannerNotice and (GF.BannerNotice()) or nil,
	}
end

function play.state()
	local w = stub.world
	local ns = Polestar
	local look = {}
	for _, k in ipairs(LOOK) do look[k] = ns.Get(k) end
	local changed = flatten(ns.DB().settings, "", {})
	local quests = {}
	for q, entry in pairs(w.log) do
		local objs = {}
		for oi, o in ipairs(entry.objectives or {}) do objs[oi] = { o.numFulfilled or 0, o.numRequired or 1 } end
		quests[#quests + 1] = { id = q, title = entry.title or w.titles[q] or C_QuestLog.GetTitleForQuestID(q) or ("Quest " .. q), objectives = objs, ready = C_QuestLog.ReadyForTurnIn(q) }
	end
	table.sort(quests, function(a, b) return a.id < b.id end)
	local sections = {}
	local P = ns.UI and ns.UI.Picker
	if P and P.Sections then
		for i, s in ipairs(P.Sections()) do sections[i] = { key = s.key, label = s.label } end
	end
	local schemes = {}
	for i, k in ipairs(ns.Theme and ns.Theme.SCHEME_ORDER or {}) do schemes[i] = k end
	if stub.addonsLoaded.EllesmereUI then schemes[#schemes + 1] = "ellesmere" end
	local chat = {}
	local msgs = stub.messages
	for i = math.max(1, #msgs - 30), #msgs do chat[#chat + 1] = msgs[i] end
	local popups = {}
	for i, p in ipairs(stub.popups) do
		local d = StaticPopupDialogs[p.which]
		popups[i] = { which = p.which, text = d and d.text and format(d.text, unpack(p.args)) or p.which, accept = d and d.button1, cancel = d and d.button2 }
	end
	local focus = stub.focus
	return {
		now = stub.now,
		player = { level = w.level, race = w.race, class = w.class, faction = w.faction, map = w.map, x = w.x, y = w.y, zone = w.zone, subzone = w.subzone },
		guide = guideState(),
		waypoint = ns.Engine and ns.Engine.GetWaypoint and ns.Engine.GetWaypoint() or nil,
		look = look, changed = changed, schemes = schemes, eui = stub.addonsLoaded.EllesmereUI == true,
		quests = quests, sections = sections, section = P and P.Section and P.Section() or nil,
		hub = ns.UI and ns.UI.Picker and PolestarPicker and PolestarPicker.shown and true or false,
		worldMap = map.shown, worldMapID = stub.worldMapID,
		focus = focus and play.ids[focus] or nil,
		chat = chat, popups = popups, errorSeq = errorSeq,
	}
end

local function dumpVisible()
	memo = {}
	local ok, out = pcall(preview.dump, { visibleOnly = true, skip = clippedOut })
	memo = nil
	if not ok then error(out, 0) end
	return out
end

-- The frame and the state, after letting time run (fades, throttles).
function play.snapshot(dt, sinceError)
	if dt and dt > 0 then stub.advance(dt) end
	local w = stub.world
	if play.zoneText then play.zoneText:SetText(w.subzone ~= "" and w.subzone or w.zone or "") end
	if play.minimapArrow then play.minimapArrow:SetRotation(w.facing or 0) end
	if map.shown then placeMe() end
	local errs = {}
	for _, e in ipairs(play.errors) do
		if e.n > (sinceError or 0) then errs[#errs + 1] = e end
	end
	return {
		dump = { objects = dumpVisible(), eui = stub.euiS ~= nil, accent = stub.accent },
		state = play.state(),
		errors = errs,
	}
end

---------------------------------------------------------------------------
-- The request loop
---------------------------------------------------------------------------

local stdout = io.stdout
local function reply(t)
	stdout:write("@@R ", play.json(t), "\n")
	stdout:flush()
end

function play.serve()
	reply({ ok = true, value = "ready" })
	while true do
		local header = io.read("*l")
		if not header then return end
		local n = tonumber(header)
		if n then
			local code = io.read(n)
			local t0 = os.clock()
			local fn, err = loadstring(code, "=request")
			if not fn then
				reply({ ok = false, error = err })
			else
				local ok, res = xpcall(fn, traceback)
				if ok then
					reply({ ok = true, value = res, ms = (os.clock() - t0) * 1000 })
				else
					reply({ ok = false, error = res.msg, trace = res.trace })
				end
			end
		end
	end
end
