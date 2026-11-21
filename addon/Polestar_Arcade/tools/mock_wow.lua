-- Minimal mock of the WoW UI API plus a software rasterizer for the textures it creates.
-- Run under LuaJIT. Lets us screenshot FreedoomArcade frames offline.
local ffi = require("ffi")
local M = {}
local ADDONS = assert(os.getenv("WOWDOOM_ADDONS"), "set WOWDOOM_ADDONS")

local allFrames = {}
local creation = 0
local now = 0

local Region = {}
Region.__index = Region
function Region:SetPoint(p, rel, rp, x, y)
	self.px, self.py = x or 0, y or 0
end
function Region:ClearAllPoints() end
function Region:SetAllPoints() self.all = true end
function Region:SetSize(w, h) self.w, self.h = w, h end
function Region:SetWidth(w) self.w = w end
function Region:SetHeight(h) self.h = h end
function Region:GetWidth() return self.w or 0 end
function Region:GetHeight() return self.h or 0 end
function Region:Show() self.visible = true end
function Region:Hide() self.visible = false end
function Region:IsShown() return self.visible end
function Region:SetAlpha(a) self.alpha = a end

local Texture = setmetatable({}, { __index = Region })
Texture.__index = Texture
function Texture:SetTexture(path, wh, wv, filter)
	self.path = path
	self.wrap = wh == "REPEAT"
	self.color = nil
	M.setTextureCalls = M.setTextureCalls + 1
end
function Texture:SetColorTexture(r, g, b, a)
	self.color = { r, g, b, a or 1 }
	self.path = nil
end
function Texture:SetTexCoord(...)
	local n = select("#", ...)
	if n == 4 then
		local l, r, t, b = ...
		self.tc = { l, t, l, b, r, t, r, b }
	else
		self.tc = { ... }
	end
end
function Texture:SetVertexColor(r, g, b, a) self.vc = { r, g, b, a or 1 } end
function Texture:SetSnapToPixelGrid() end
function Texture:SetTexelSnappingBias() end
function Texture:SetDrawLayer() end
function Texture:SetBlendMode() end

local Frame = setmetatable({}, { __index = Region })
Frame.__index = Frame
function Frame:CreateTexture(name, layer)
	creation = creation + 1
	local t = setmetatable({ parent = self, visible = true, order = creation, vc = { 1, 1, 1, 1 }, tc = { 0, 0, 0, 1, 1, 0, 1, 1 } }, Texture)
	self.textures[#self.textures + 1] = t
	return t
end
local Line = setmetatable({}, { __index = Region })
Line.__index = Line
function Line:SetStartPoint(_, _, x, y) self.sx, self.sy = x, y end
function Line:SetEndPoint(_, _, x, y) self.ex, self.ey = x, y end
function Line:SetThickness(t) self.th = t end
function Line:SetColorTexture(r, g, b, a) self.color = { r, g, b, a or 1 } end
function Frame:CreateLine()
	creation = creation + 1
	local l = setmetatable({ parent = self, visible = true, order = creation, isLine = true, th = 1, color = { 1, 1, 1, 1 } }, Line)
	self.textures[#self.textures + 1] = l
	return l
end
function Frame:EnableMouseWheel() end
function Frame:RegisterForClicks() end
function Frame:IsMouseOver() return false end
function Frame:SetHighlightTexture() end
function Frame:LockHighlight() end
function Frame:UnlockHighlight() end
function Frame:GetCenter() return 960, 540 end
function Frame:StartMoving() end
function Frame:StopMovingOrSizing() end
function Frame:ClearAllPoints() end
function Frame:SetPoint(p, rel, rp, x, y) self.px, self.py = x or 0, y or 0 end
function Frame:CreateFontString() return setmetatable({}, { __index = function() return function() end end }) end
function Frame:SetFrameLevel(l) self.level = l end
function Frame:GetFrameLevel() return self.level or 0 end
function Frame:SetFrameStrata() end
function Frame:SetScript(ev, fn) self.scripts[ev] = fn end
function Frame:GetScript(ev) return self.scripts[ev] end
function Frame:RegisterEvent() end
function Frame:UnregisterEvent() end
function Frame:EnableKeyboard() end
function Frame:EnableMouse() end
function Frame:SetPropagateKeyboardInput() end
function Frame:SetMovable() end
function Frame:RegisterForDrag() end
function Frame:SetClampedToScreen() end
function Frame:SetClipsChildren() end
function Frame:GetEffectiveScale() return 1 end
function Frame:SetToplevel() end

function CreateFrame(kind, name, parent)
	local f = setmetatable({ textures = {}, scripts = {}, parent = parent, visible = true, level = parent and (parent.level or 0) + 1 or 0 }, Frame)
	allFrames[#allFrames + 1] = f
	if name then _G[name] = f end
	return f
end
UIParent = CreateFrame("Frame")
UIParent.w, UIParent.h = 1920, 1080
function UIParent:GetWidth() return 1920 end
function GetTime() return now end
Minimap = CreateFrame("Frame")
Minimap.w, Minimap.h = 140, 140
GameTooltip = setmetatable({}, { __index = function() return function() end end })
function M.Advance(dt) now = now + dt end
function PlaySoundFile() return true end
function IsShiftKeyDown() return false end
function GetCursorPosition() return 0, 0 end
SlashCmdList = {}
DEFAULT_CHAT_FRAME = { AddMessage = function(_, m) print(m) end }
function LoadAddOn(name)
	local toc = ADDONS .. "/" .. name .. "/" .. name .. ".toc"
	local f = io.open(toc)
	if not f then return false, "MISSING" end
	for line in f:lines() do
		if line:match("%.lua$") then dofile(ADDONS .. "/" .. name .. "/" .. line) end
	end
	f:close()
	return true
end
C_AddOns = { LoadAddOn = LoadAddOn }
M.setTextureCalls = 0
function M.Frames() return allFrames end
math.atan2 = math.atan2 or math.atan

------------------------------------------------------------------------ TGA
local tgaCache = {}
local function loadTGA(path)
	local c = tgaCache[path]
	if c ~= nil then return c end
	local rel = path:gsub("^Interface\\AddOns\\", ""):gsub("\\", "/")
	local f = io.open(ADDONS .. "/" .. rel .. ".tga", "rb")
	if not f then
		print("missing texture " .. path)
		tgaCache[path] = false
		return false
	end
	local data = f:read("*a")
	f:close()
	local w = data:byte(13) + data:byte(14) * 256
	local h = data:byte(15) + data:byte(16) * 256
	local px = ffi.new("uint8_t[?]", w * h * 4)
	ffi.copy(px, data:sub(19), w * h * 4)
	c = { w = w, h = h, px = px } -- BGRA, bottom-up rows
	tgaCache[path] = c
	return c
end

------------------------------------------------------------------------ rasterizer
function M.Screenshot(root, outPath, W, H)
	local img = ffi.new("float[?]", W * H * 3)
	-- collect textures in draw order: frame level, then creation order
	local frames = {}
	for _, f in ipairs(allFrames) do
		local p, vis = f, true
		while p do if not p.visible then vis = false end p = p.parent end
		if vis then frames[#frames + 1] = f end
	end
	table.sort(frames, function(a, b)
		if a.level ~= b.level then return a.level < b.level end
		return false
	end)
	for _, f in ipairs(frames) do
		local list = {}
		for _, t in ipairs(f.textures) do if t.visible then list[#list + 1] = t end end
		table.sort(list, function(a, b) return a.order < b.order end)
		for _, t in ipairs(list) do
			local x0, y0 = t.px or 0, -(t.py or 0)
			local w, h = t.w or 0, t.h or 0
			local ix0, ix1 = math.floor(x0 + 0.5), math.floor(x0 + w + 0.5) - 1
			local iy0, iy1 = math.floor(y0 + 0.5), math.floor(y0 + h + 0.5) - 1
			if ix0 < 0 then ix0 = 0 end
			if iy0 < 0 then iy0 = 0 end
			if ix1 > W - 1 then ix1 = W - 1 end
			if iy1 > H - 1 then iy1 = H - 1 end
			local vc = t.vc
			if t.isLine then
				local x1, y1, x2, y2 = t.sx, -t.sy, t.ex, -t.ey
				local hw = t.th / 2
				local c = t.color
				local dx, dy = x2 - x1, y2 - y1
				local len2 = dx * dx + dy * dy
				local bx0 = math.max(0, math.floor(math.min(x1, x2) - hw))
				local bx1 = math.min(W - 1, math.ceil(math.max(x1, x2) + hw))
				local by0 = math.max(0, math.floor(math.min(y1, y2) - hw))
				local by1 = math.min(H - 1, math.ceil(math.max(y1, y2) + hw))
				for y = by0, by1 do
					for x = bx0, bx1 do
						local px, py = x + 0.5 - x1, y + 0.5 - y1
						local tt = len2 > 0 and (px * dx + py * dy) / len2 or 0
						if tt < 0 then tt = 0 elseif tt > 1 then tt = 1 end
						local qx, qy = px - tt * dx, py - tt * dy
						if qx * qx + qy * qy <= hw * hw then
							local o = (y * W + x) * 3
							img[o], img[o + 1], img[o + 2] = c[1], c[2], c[3]
						end
					end
				end
			elseif t.color then
				local c = t.color
				for y = iy0, iy1 do
					for x = ix0, ix1 do
						local o = (y * W + x) * 3
						local a = c[4] * vc[4]
						img[o] = img[o] * (1 - a) + c[1] * a
						img[o + 1] = img[o + 1] * (1 - a) + c[2] * a
						img[o + 2] = img[o + 2] * (1 - a) + c[3] * a
					end
				end
			elseif t.path then
				local tex = loadTGA(t.path)
				if tex then
					local tc = t.tc
					local tw, th, px = tex.w, tex.h, tex.px
					local wrap = t.wrap
					for y = iy0, iy1 do
						local tv = (y + 0.5 - y0) / h
						for x = ix0, ix1 do
							local s = (x + 0.5 - x0) / w
							-- bilinear blend of corner coords UL, LL, UR, LR
							local u = (1 - s) * ((1 - tv) * tc[1] + tv * tc[3]) + s * ((1 - tv) * tc[5] + tv * tc[7])
							local v = (1 - s) * ((1 - tv) * tc[2] + tv * tc[4]) + s * ((1 - tv) * tc[6] + tv * tc[8])
							local cx, cy = math.floor(u * tw), math.floor(v * th)
							if wrap then
								cx, cy = cx % tw, cy % th
							else
								if cx < 0 then cx = 0 elseif cx >= tw then cx = tw - 1 end
								if cy < 0 then cy = 0 elseif cy >= th then cy = th - 1 end
							end
							local po = ((th - 1 - cy) * tw + cx) * 4
							local a = px[po + 3] / 255 * vc[4]
							if a > 0 then
								local o = (y * W + x) * 3
								img[o] = img[o] * (1 - a) + px[po + 2] / 255 * vc[1] * a
								img[o + 1] = img[o + 1] * (1 - a) + px[po + 1] / 255 * vc[2] * a
								img[o + 2] = img[o + 2] * (1 - a) + px[po] / 255 * vc[3] * a
							end
						end
					end
				end
			end
		end
	end
	local f = io.open(outPath, "wb")
	f:write(string.format("P6\n%d %d\n255\n", W, H))
	local buf = ffi.new("uint8_t[?]", W * H * 3)
	for i = 0, W * H * 3 - 1 do
		local v = img[i]
		if v > 1 then v = 1 elseif v < 0 then v = 0 end
		buf[i] = math.floor(v * 255 + 0.5)
	end
	f:write(ffi.string(buf, W * H * 3))
	f:close()
end

function M.LoadAddon(dir, toc)
	for line in io.lines(dir .. "/" .. toc) do
		line = line:gsub("\r", "")
		if line:match("%.lua$") then
			dofile(dir .. "/" .. line:gsub("\\", "/"))
		end
	end
end

return M
