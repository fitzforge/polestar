-- Preview overlay on tests/lua/wow_stub.lua: makes the generic client stub
-- behave enough like the real client for layout (anchors replace by point
-- name, text is measured with the real font metrics and wrapped), records the
-- properties drawing needs, and dumps every frame, texture and string as JSON
-- for tools/preview/render.js.
--
-- Loaded after wow_stub.lua and stub_ui.lua. `preview.metrics` is filled in
-- by the Node side before this file runs:
--   preview.metrics[fontFile] = { upm = n, adv = { [codepoint] = em, ... }, fallback = em }

preview = preview or {}
local M = stub.Methods

local seq = 0
local function stamp(o)
	seq = seq + 1
	o.seq = seq
	return o
end

local createFrame = CreateFrame
function CreateFrame(...)
	return stamp(createFrame(...))
end
local createTexture, createFontString = M.CreateTexture, M.CreateFontString
function M.CreateTexture(...) return stamp(createTexture(...)) end
function M.CreateFontString(...) return stamp(createFontString(...)) end

-- The client keys anchors by point: setting TOPLEFT again replaces it.
function M.SetPoint(self, point, rel, relPoint, x, y)
	if type(rel) == "number" then rel, relPoint, x, y = nil, nil, rel, relPoint end
	if type(rel) == "string" and relPoint == nil then rel, relPoint = nil, rel end
	-- SetPoint(point, frame, x, y): the frame's same point.
	if type(rel) == "table" and type(relPoint) == "number" then relPoint, x, y = point, relPoint, x end
	local p = { point = point, rel = rel, relPoint = relPoint or point, x = x or 0, y = y or 0 }
	for i = 1, #self.points do
		if self.points[i].point == point then
			self.points[i] = p
			return
		end
	end
	table.insert(self.points, p)
end

function M.SetJustifyH(self, j) self.justifyH = j end
function M.SetJustifyV(self, j) self.justifyV = j end
function M.SetWordWrap(self, v) self.wrap = v and true or false end
function M.SetNonSpaceWrap() end
function M.SetSpacing(self, s) self.spacing = s end
function M.SetMaxLines(self, n) self.maxLines = n end
function M.SetShadowOffset(self, x, y) self.shadow = { x, y } end
function M.SetShadowColor(self, r, g, b, a) self.shadowColor = { r, g, b, a } end
function M.SetThumbTexture(self, t) if type(t) == "table" then self.thumbTexture = t end end
function M.GetThumbTexture(self) return self.thumbTexture end
function M.SetClipsChildren(self, v) self.clips = v and true or false end
function M.SetTextInsets(self, l, r, t, b) self.insets = { l, r, t, b } end
function M.SetMultiLine(self, v) self.multiLine = v and true or false end
-- Gradients (the modern signature: orientation, min colour, max colour; for
-- VERTICAL, min is the bottom) and desaturation, for the renderer.
function M.SetGradient(self, orientation, minColor, maxColor)
	local function rgba(c) return { c.r or 1, c.g or 1, c.b or 1, c.a or 1 } end
	self.gradient = { orientation = orientation, min = rgba(minColor), max = rgba(maxColor) }
end
function M.SetDesaturation(self, v) self.desaturation = v end
-- A frame without an explicit level sits one above its parent, as in the
-- client (and as render.js orders them).
function M.GetFrameLevel(self)
	if self.level then return self.level end
	local p = self.parent
	return p and p.GetFrameLevel and (p:GetFrameLevel() + 1) or 0
end

---------------------------------------------------------------------------
-- Text measurement with real metrics
---------------------------------------------------------------------------

local function fontKey(self)
	local path = self.font and self.font[1] or ""
	local file = path:match("([^\\/]+)$") or path
	if preview.metrics[file] then return file end
	return preview.fallbackFont
end

local function codepoints(s)
	local out = {}
	local i, n = 1, #s
	while i <= n do
		local c = s:byte(i)
		local cp, len
		if c < 0x80 then cp, len = c, 1
		elseif c < 0xE0 then cp, len = (c % 0x20) * 64 + (s:byte(i + 1) % 64), 2
		elseif c < 0xF0 then cp, len = (c % 0x10) * 4096 + (s:byte(i + 1) % 64) * 64 + (s:byte(i + 2) % 64), 3
		else cp, len = (c % 0x08) * 262144 + (s:byte(i + 1) % 64) * 4096 + (s:byte(i + 2) % 64) * 64 + (s:byte(i + 3) % 64), 4 end
		out[#out + 1] = cp
		i = i + len
	end
	return out
end

-- Visible text: colour codes out, "||" -> "|".
function preview.plain(s)
	s = tostring(s or "")
	s = s:gsub("||", "\1"):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("\1", "|")
	return s
end

function preview.width(file, size, s)
	local m = preview.metrics[file]
	local w = 0
	for _, cp in ipairs(codepoints(s)) do w = w + (m.adv[cp] or m.fallback) end
	return w * size
end

-- The breakable pieces of a word: CJK characters (ideographs, kana, their
-- punctuation) one by one, as the client wraps between any two of them;
-- everything else whole.
local function pieces(word)
	if not word:find("[\226-\239]") then return { word } end
	local out, run = {}, ""
	for ch in word:gmatch("[%z\1-\127\192-\247][\128-\191]*") do
		local cp = codepoints(ch)[1]
		if (cp >= 0x2E80 and cp <= 0x9FFF) or (cp >= 0xF900 and cp <= 0xFAFF) or (cp >= 0xFE30 and cp <= 0xFE4F) or (cp >= 0xFF00 and cp <= 0xFFEF) then
			if run ~= "" then out[#out + 1] = run end
			out[#out + 1], run = ch, ""
		else
			run = run .. ch
		end
	end
	if run ~= "" then out[#out + 1] = run end
	return out
end

-- Greedy word wrap, the same rule render.js uses.
function preview.wrap(file, size, text, width)
	local lines = {}
	for para in (text .. "\n"):gmatch("(.-)\n") do
		local line = ""
		for word in para:gmatch("%S+") do
			for i, piece in ipairs(pieces(word)) do
				local candidate = line == "" and piece or (line .. (i == 1 and " " or "") .. piece)
				if line ~= "" and preview.width(file, size, candidate) > width + 0.01 then
					lines[#lines + 1] = line
					line = piece
				else
					line = candidate
				end
			end
		end
		lines[#lines + 1] = line
	end
	return lines
end

function M.GetStringWidth(self)
	local size = (self.font and self.font[2]) or 12
	local widest = 0
	for line in (preview.plain(self.text) .. "\n"):gmatch("(.-)\n") do
		widest = math.max(widest, preview.width(fontKey(self), size, line))
	end
	return widest
end
M.GetUnboundedStringWidth = M.GetStringWidth

local function lineCount(self)
	local size = (self.font and self.font[2]) or 12
	local text = preview.plain(self.text)
	local n
	if self.wrap ~= false and (self.width or 0) > 0 then
		n = #preview.wrap(fontKey(self), size, text, self.width)
	else
		n = 1
		for _ in text:gmatch("\n") do n = n + 1 end
	end
	if self.maxLines and self.maxLines > 0 then n = math.min(n, self.maxLines) end
	return n
end

function M.GetStringHeight(self)
	local size = (self.font and self.font[2]) or 12
	local n = lineCount(self)
	return n * size + (n - 1) * (self.spacing or 0)
end
function M.GetLineHeight(self) return (self.font and self.font[2]) or 12 end
function M.GetNumLines(self) return lineCount(self) end

---------------------------------------------------------------------------
-- Dump
---------------------------------------------------------------------------

local ids, nextId = {}, 0
local objects = setmetatable({}, { __mode = "v" }) -- id -> object, for preview.object
local function idOf(o)
	if not o then return nil end
	local id = ids[o]
	if not id then
		nextId = nextId + 1
		id = nextId
		ids[o] = id
		objects[id] = o
	end
	return id
end

-- The object a dump id names (ids are stable for the life of the run).
function preview.object(id) return objects[id] end

-- An anchor's relative frame: an object, or a global frame name.
local function relOf(p)
	if type(p.rel) == "string" then return _G[p.rel] end
	return p.rel
end

local function num(v) return type(v) == "number" and v or nil end
local function str(v) return type(v) == "string" and v or nil end

local function copy(t)
	if not t then return nil end
	local c = {}
	for i = 1, #t do c[i] = t[i] end
	return c
end

local function entry(o)
	local pts = {}
	for i, p in ipairs(o.points) do
		pts[i] = { point = p.point, rel = idOf(relOf(p)), relPoint = p.relPoint, x = p.x, y = p.y }
	end
	-- Addons keep their own fields on frames too (a frame's `layer` or
	-- `level` table); only values of the client's types are the client's.
	local e = {
		id = idOf(o), seq = o.seq or 0, kind = o.kind, name = str(o.name), parent = idOf(o.parent),
		points = pts, w = num(o.width), h = num(o.height), shown = o.shown ~= false, alpha = num(o.alpha) or 1,
		scale = num(o.scale), strata = str(o.strata), level = num(o.level), layer = str(o.layer), sublayer = num(o.sublayer),
		texture = (type(o.texture) == "string" or type(o.texture) == "number") and o.texture or nil, color = copy(o.color),
		vertexColor = copy(o.vertexColor), texCoord = copy(o.texCoord), gradient = o.gradient, desaturation = o.desaturation,
		rotation = o.rotation, blend = o.blend, vertexOffset = copy(o.vertexOffset),
	}
	-- A Line (CreateLine): its two ends, each relative to a point of a frame, and its thickness.
	if o.kind == "Line" then
		local function point(p)
			if not p then return nil end
			return { point = p[1], rel = idOf(relOf({ rel = p[2] }) or o.parent), x = p[3] or 0, y = p[4] or 0 }
		end
		e.line = { from = point(o.startPoint), to = point(o.endPoint), thickness = num(o.thickness) or 1 }
	end
	if o.kind == "FontString" then
		e.text = o.text
		e.font = o.font and { fontKey(o), o.font[2], o.font[3] or "" } or { preview.fallbackFont, 12, "" }
		e.textColor = copy(o.textColor)
		e.justifyH, e.justifyV = o.justifyH or "CENTER", o.justifyV or "MIDDLE"
		e.wrap = o.wrap ~= false
		e.spacing = o.spacing or 0
		e.maxLines = o.maxLines
		e.shadow = o.shadow and copy(o.shadow)
		e.shadowColor = copy(o.shadowColor)
	else
		e.scrollChild = idOf(o.scrollChild)
		e.vscroll = o.scroll
		e.clips = o.clips or o.kind == "ScrollFrame"
		e.checked = o.checked
		e.checkedTexture = idOf(o.checkedTexture)
		e.thumbTexture = idOf(o.thumbTexture)
		e.mask = idOf(o.mask)
		e.value, e.minValue, e.maxValue = o.value, o.minValue, o.maxValue
		e.euiSkin = o.euiSkin
		e.euiOpts = o.euiOpts
		e.euiSelected = o.euiSelected
		e.hover = preview.hover == o or nil
	end
	-- preview.entryExtra(object, entry): a caller's own fields (tools/play).
	if preview.entryExtra then preview.entryExtra(o, e) end
	return e
end

-- An edit box's typed text, as the client draws it: in the box's font and
-- colour, inside its text insets, left-aligned; one line, or wrapped from
-- the top in a multi-line box.
local typed = setmetatable({}, { __mode = "k" }) -- edit box -> stand-in font string
local function typedText(box)
	if box.kind ~= "EditBox" or type(box.text) ~= "string" or box.text == "" or box.shown == false then return nil end
	local fs = typed[box]
	if not fs then
		fs = {}
		typed[box] = fs
	end
	local ins = box.insets or {}
	local multi = box.multiLine == true
	fs.kind, fs.parent, fs.layer = "FontString", box, "OVERLAY"
	fs.points = {
		{ point = "TOPLEFT", rel = box, relPoint = "TOPLEFT", x = ins[1] or 0, y = multi and -(ins[3] or 0) or 0 },
		{ point = "BOTTOMRIGHT", rel = box, relPoint = "BOTTOMRIGHT", x = -(ins[2] or 0), y = multi and (ins[4] or 0) or 0 },
	}
	fs.text, fs.font, fs.textColor = box.text, box.font, box.textColor
	fs.justifyH, fs.justifyV, fs.wrap = "LEFT", multi and "TOP" or "MIDDLE", multi
	fs.shadow, fs.shadowColor = box.shadow, box.shadowColor
	return fs
end

-- opts.visibleOnly: only what can be drawn (shown frames under shown
-- parents, their shown regions), plus every object those anchor to, for
-- geometry (a hidden anchor target is dumped with shown = false).
-- opts.skip(frame): true leaves a shown frame out (one clipped out of view).
function preview.dump(opts)
	local out = {}
	if opts and opts.visibleOnly then
		local added, queue = {}, {}
		local function add(o)
			if type(o) ~= "table" or added[o] or not o.points then return end
			added[o] = true
			out[#out + 1] = entry(o)
			queue[#queue + 1] = o
		end
		local function shownChain(f)
			while f do
				if f.shown == false then return false end
				f = f.parent
			end
			return true
		end
		add(UIParent)
		for _, f in ipairs(stub.frames) do
			if f ~= UIParent and shownChain(f) and not (opts.skip and opts.skip(f)) then
				add(f)
				for _, r in ipairs(f.regions) do
					if r.shown ~= false then add(r) end
				end
				-- Lines are regions in the client; the test stub keeps them with the children.
				for _, c in ipairs(f.children) do
					if c.kind == "Line" and c.shown ~= false then add(c) end
				end
				local fs = typedText(f)
				if fs then add(fs) end
			end
		end
		local i = 1
		while i <= #queue do
			local o = queue[i]
			i = i + 1
			for _, p in ipairs(o.points) do add(relOf(p)) end
			if o.kind == "Line" then
				if o.startPoint then add(relOf({ rel = o.startPoint[2] })) end
				if o.endPoint then add(relOf({ rel = o.endPoint[2] })) end
			end
			add(o.parent)
			add(o.scrollChild)
			add(o.thumbTexture)
			add(o.checkedTexture)
		end
		return out
	end
	local function addFrame(f)
		out[#out + 1] = entry(f)
		for _, r in ipairs(f.regions) do out[#out + 1] = entry(r) end
		for _, c in ipairs(f.children) do
			if c.kind == "Line" then out[#out + 1] = entry(c) end
		end
		local fs = typedText(f)
		if fs then out[#out + 1] = entry(fs) end
	end
	addFrame(UIParent)
	for _, f in ipairs(stub.frames) do
		if f ~= UIParent then addFrame(f) end
	end
	-- Button state textures created lazily by the stub are regions too.
	return out
end

function preview.emit(extra)
	emit({ objects = preview.dump(), extra = extra or {}, eui = stub.euiS ~= nil, accent = stub.accent })
end

---------------------------------------------------------------------------
-- Tooltips drawn as the client draws them (opt in, tools/play): the lines
-- a GameTooltip is given become font strings on a dark ground with a thin
-- border, sized to the text and anchored to the owner when shown. The
-- stub's `lines` (plain strings) are kept as before.
---------------------------------------------------------------------------

local TIP_PAD, TIP_GAP, TIP_WRAP = 10, 2, 280
local TIP_ANCHORS = {
	ANCHOR_RIGHT = { "BOTTOMLEFT", "TOPRIGHT" }, ANCHOR_LEFT = { "BOTTOMRIGHT", "TOPLEFT" },
	ANCHOR_TOP = { "BOTTOM", "TOP" }, ANCHOR_BOTTOM = { "TOP", "BOTTOM" },
	ANCHOR_TOPLEFT = { "BOTTOMLEFT", "TOPLEFT" }, ANCHOR_TOPRIGHT = { "BOTTOMRIGHT", "TOPRIGHT" },
	ANCHOR_BOTTOMLEFT = { "TOPRIGHT", "BOTTOMLEFT" }, ANCHOR_BOTTOMRIGHT = { "TOPLEFT", "BOTTOMRIGHT" },
}

local function tipLayout(tt)
	local rows = tt.tipRows
	local pool = tt.tipPool
	local widest, y = 0, TIP_PAD
	for i = 1, #rows do
		local row = pool[i]
		if not row then
			row = { left = M.CreateFontString(tt, nil, "ARTWORK"), right = M.CreateFontString(tt, nil, "ARTWORK") }
			pool[i] = row
		end
		local r = rows[i]
		local size = i == 1 and 14 or 12
		for _, fs in ipairs({ row.left, row.right }) do
			fs:SetFont(STANDARD_TEXT_FONT, size, "")
			fs:SetShadowOffset(1, -1)
			fs:SetShadowColor(0, 0, 0, 1)
			fs.width = nil
			fs:ClearAllPoints()
		end
		row.left:SetText(r.left)
		row.left:SetTextColor(r.lc[1], r.lc[2], r.lc[3], 1)
		row.left:SetJustifyH("LEFT")
		row.left:SetWordWrap(false)
		row.right:SetText(r.right or "")
		row.right:SetTextColor(r.rc[1], r.rc[2], r.rc[3], 1)
		row.right:SetJustifyH("RIGHT")
		row.left:Show()
		row.right:SetShown(r.right ~= nil)
		if not r.wrap then
			local w = row.left:GetStringWidth() + (r.right and (row.right:GetStringWidth() + 20) or 0)
			if w > widest then widest = w end
		end
	end
	local wrapW = math.max(math.min(TIP_WRAP, math.max(widest, 200)), widest)
	local maxW = widest
	for i = 1, #rows do
		local row, r = pool[i], rows[i]
		row.left:SetPoint("TOPLEFT", tt, "TOPLEFT", TIP_PAD, -y)
		if r.wrap then
			row.left:SetWordWrap(true)
			row.left:SetWidth(wrapW)
			local w = math.min(wrapW, row.left:GetStringWidth())
			if w > maxW then maxW = w end
		end
		if r.right then row.right:SetPoint("TOPRIGHT", tt, "TOPRIGHT", -TIP_PAD, -y) end
		y = y + row.left:GetStringHeight() + TIP_GAP
	end
	for i = #rows + 1, #pool do
		pool[i].left:Hide()
		pool[i].right:Hide()
	end
	tt.width = math.max(tt.tipMinW or 0, maxW + TIP_PAD * 2)
	tt.height = y - TIP_GAP + TIP_PAD
	local owner, anchor = tt.owner, tt.anchor
	local a = TIP_ANCHORS[anchor or ""]
	if a and owner then
		tt.points = {}
		M.SetPoint(tt, a[1], owner, a[2], tt.tipX or 0, tt.tipY or 0)
	elseif anchor == "ANCHOR_CURSOR" then
		local cx, cy = GetCursorPosition()
		tt.points = {}
		M.SetPoint(tt, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", cx + 16 + (tt.tipX or 0), cy + 8 + (tt.tipY or 0))
	elseif #tt.points == 0 then
		M.SetPoint(tt, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -100, 120)
	end
end

local function tipInstall(tt)
	if tt.tipRows then return tt end
	tt.tipRows, tt.tipPool, tt.lines = {}, {}, tt.lines or {}
	tt.strata = "TOOLTIP"
	tt.clamped = true
	tt.shown = false
	local bg = M.CreateTexture(tt, nil, "BACKGROUND", nil, -8)
	bg.points = {}
	M.SetPoint(bg, "TOPLEFT", tt, "TOPLEFT", 0, 0)
	M.SetPoint(bg, "BOTTOMRIGHT", tt, "BOTTOMRIGHT", 0, 0)
	bg:SetColorTexture(0.02, 0.02, 0.05, 0.92)
	local edges = { { "TOPLEFT", "TOPRIGHT", 0, 1 }, { "BOTTOMLEFT", "BOTTOMRIGHT", 0, 1 }, { "TOPLEFT", "BOTTOMLEFT", 1, 0 }, { "TOPRIGHT", "BOTTOMRIGHT", 1, 0 } }
	for _, e in ipairs(edges) do
		local t = M.CreateTexture(tt, nil, "BORDER")
		M.SetPoint(t, e[1], tt, e[1], 0, 0)
		M.SetPoint(t, e[2], tt, e[2], 0, 0)
		if e[3] == 1 then t.width = 1 else t.height = 1 end
		t:SetColorTexture(0.45, 0.46, 0.52, 1)
	end
	local function row(left, lc, right, rc, wrap)
		tt.tipRows[#tt.tipRows + 1] = { left = tostring(left or ""), lc = lc, right = right ~= nil and tostring(right) or nil, rc = rc or { 1, 1, 1 }, wrap = wrap and true or false }
	end
	function tt.SetOwner(self, owner, anchor, x, y)
		self.owner, self.anchor, self.tipX, self.tipY = owner, anchor, x, y
		self.lines, self.tipRows, self.tipMinW = {}, {}, nil
		if anchor ~= "ANCHOR_NONE" and anchor ~= "ANCHOR_PRESERVE" then self.points = {} end
	end
	function tt.GetOwner(self) return self.owner end
	function tt.IsOwned(self, f) return self.owner == f end
	function tt.ClearLines(self) self.lines, self.tipRows = {}, {} end
	function tt.AddLine(self, text, r, g, b, wrap)
		table.insert(self.lines, tostring(text))
		row(text, { r or 1, g or 0.82, b or 0 }, nil, nil, wrap)
	end
	function tt.AddDoubleLine(self, l, r, lr, lg, lb, rr, rg, rb)
		table.insert(self.lines, tostring(l) .. " | " .. tostring(r))
		row(l, { lr or 1, lg or 0.82, lb or 0 }, r, { rr or 1, rg or 0.82, rb or 0 })
	end
	function tt.SetText(self, text, r, g, b, _, wrap)
		self.lines, self.tipRows = { tostring(text) }, {}
		row(text, { r or 1, g or 1, b or 1 }, nil, nil, wrap)
	end
	function tt.SetHyperlink(self, link)
		local name = type(link) == "string" and link:match("|h%[(.-)%]|h") or tostring(link)
		self:SetText(name)
	end
	function tt.NumLines(self) return #self.tipRows end
	function tt.SetMinimumWidth(self, w) self.tipMinW = w end
	function tt.Show(self)
		tipLayout(self)
		M.Show(self)
	end
	return tt
end

function preview.enableTooltips()
	tipInstall(GameTooltip)
	local create = CreateFrame
	CreateFrame = function(kind, ...)
		local f = create(kind, ...)
		if kind == "GameTooltip" then tipInstall(f) end
		return f
	end
	GameTooltip_SetDefaultAnchor = function(tt, parent)
		tt:SetOwner(parent, "ANCHOR_NONE")
		tt.points = {}
		M.SetPoint(tt, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -100, 120)
	end
end
