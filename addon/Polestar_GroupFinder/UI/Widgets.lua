-- Polestar Group Finder: the building blocks shared by every window.
--
-- Frames are painted by Polestar's Theme (Theme.Skin, Font, Color, Hex,
-- OnChanged); the game's own templates stand in where a call fails.

local _, ns = ...
local L = ns.L

local W = {}
ns.Widgets = W

W.WIDTH, W.PAD = 340, 12 -- the panels' width and inner margin
W.ROW_H = 38             -- a player row
W.ICON_BTN = 22          -- the Whisper / Invite icon buttons
W.BTN_COL = 2 * 22 + 4   -- width of their column

local BACKDROP = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 14, insets = { left = 3, right = 3, top = 3, bottom = 3 },
}

---------------------------------------------------------------------------
-- Theme
---------------------------------------------------------------------------

function W.Theme()
	local T = Polestar and Polestar.Theme
	if T and T.Skin and T.Font then return T end
	return nil
end

function W.Skin(frame, kind)
	local T = W.Theme()
	if T then pcall(T.Skin, frame, kind) end
	return frame
end

function W.Font(fs, role, fallback)
	local T = W.Theme()
	if not (T and pcall(T.Font, fs, role)) then fs:SetFontObject(fallback or GameFontHighlightSmall) end
	return fs
end

-- A font string on `parent`, painted for `role`.
function W.Text(parent, role, fallback)
	return W.Font(parent:CreateFontString(nil, "OVERLAY"), role, fallback)
end

-- "|cffrrggbb" for a Polestar colour token, else `fallback`.
function W.Hex(token, fallback)
	local T = W.Theme()
	if T and T.Hex then
		local ok, h = pcall(T.Hex, token)
		if ok and type(h) == "string" then return "|c" .. h end
	end
	return "|c" .. fallback
end
function W.Dim() return W.Hex("textMuted", "ff9a9aa6") end
function W.Soft() return W.Hex("textDim", "ffc8c8d0") end

---------------------------------------------------------------------------
-- Controls
---------------------------------------------------------------------------

function W.Button(parent, text, width, onClick, height)
	local b
	height = height or 22
	if W.Theme() then
		b = CreateFrame("Button", nil, parent)
		b:SetSize(width, height)
		b.psTextButton = true
		local fs = W.Text(b, "label", GameFontNormalSmall)
		fs:SetPoint("CENTER")
		b:SetFontString(fs)
		W.Skin(b, "button")
	else
		b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
		b:SetSize(width, height)
	end
	b:SetText(text)
	b:SetScript("OnClick", onClick)
	return b
end

-- An accent fill over button `b` that drains from right to left, as long as
-- `left()` says (0-1: 1 full, 0 or nil gone), read every frame.
function W.Drain(b, left)
	local fill = b:CreateTexture(nil, "ARTWORK", nil, -8)
	fill:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1)
	fill:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 1, 1)
	if fill.SetColorTexture then fill:SetColorTexture(0.9, 0.73, 0.4, 0.45) end
	local T = W.Theme()
	if T and T.Color then pcall(T.Color, fill, "accent", 0.45) end
	fill:Hide()
	b.psFill = fill
	local function paint(self)
		local f = left()
		if not f or f <= 0 then fill:Hide() return end
		fill:SetWidth(math.max(0.01, ((self:GetWidth() or 100) - 2) * math.min(1, f)))
		fill:Show()
	end
	b.psDrain = paint
	if b.HookScript then b:HookScript("OnUpdate", paint) else b:SetScript("OnUpdate", paint) end
	return fill
end

function W.Tip(frame, title, body, anchor)
	frame:HookScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, anchor or "ANCHOR_TOP")
		GameTooltip:SetText(title, 1, 1, 1)
		if body then GameTooltip:AddLine(body, nil, nil, nil, true) end
		GameTooltip:Show()
	end)
	frame:HookScript("OnLeave", function() GameTooltip:Hide() end)
end

-- A switch: Polestar's own checkbox when it runs, the game's else. The label
-- is part of the hit area, and the tooltip opens above it so it never
-- covers its own label. A click sets `key`, or calls onToggle(on).
function W.Check(parent, label, help, key, onToggle)
	local c
	if W.Theme() then
		c = CreateFrame("CheckButton", nil, parent)
		c:SetSize(18, 18)
		W.Skin(c, "checkbox")
	else
		c = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
		c:SetSize(22, 22)
	end
	local fs = W.Text(c, "label", GameFontHighlightSmall)
	fs:SetPoint("LEFT", c, "RIGHT", 4, 0)
	fs:SetText(label)
	c.label = fs
	c:SetHitRectInsets(0, -(fs:GetStringWidth() + 8), 0, 0)
	c:SetScript("OnClick", function(self)
		local on = self:GetChecked() and true or false
		if onToggle then onToggle(on) else ns.Set(key, on) end
	end)
	if help then W.Tip(c, label, help) end
	c.key = key
	return c
end

-- A window: themed (or the tooltip backdrop), closed by Escape.
-- `opts`: width, height, strata, alpha (backdrop), movable.
function W.Window(name, opts)
	local useTheme = W.Theme() ~= nil
	local f = CreateFrame("Frame", name, UIParent, (not useTheme and BackdropTemplateMixin) and "BackdropTemplate" or nil)
	f:SetSize(opts.width, opts.height)
	f:SetFrameStrata(opts.strata or "MEDIUM")
	f:SetClampedToScreen(true)
	f:EnableMouse(true)
	if useTheme then
		W.Skin(f, "window")
	elseif f.SetBackdrop then
		f:SetBackdrop(BACKDROP)
		f:SetBackdropColor(0.05, 0.05, 0.08, opts.alpha or 0.92)
	end
	if opts.movable then
		f:SetMovable(true)
		f:RegisterForDrag("LeftButton")
		f:SetScript("OnDragStart", function(self) if self:IsMovable() then self:StartMoving() end end)
		f:SetScript("OnDragStop", function(self)
			self:StopMovingOrSizing()
			if opts.onMoved then opts.onMoved(self) end
		end)
	end
	-- Escape closes it, with the keyboard and mouse (not with the gamepad interface: Init.lua).
	ns.P.CloseOnEscape(name)
	return f
end

function W.CloseButton(parent, onClick)
	local close
	if W.Theme() then
		close = CreateFrame("Button", nil, parent)
		close:SetSize(18, 18)
		close:SetPoint("TOPRIGHT", -8, -8)
		W.Skin(close, "close")
	else
		close = CreateFrame("Button", nil, parent, "UIPanelCloseButton")
		close:SetPoint("TOPRIGHT", 2, 2)
	end
	close:SetScript("OnClick", onClick or function() parent:Hide() end)
	return close
end

-- Our icon, then `text`, at the top left of a window.
function W.Title(parent, text)
	local icon = parent:CreateTexture(nil, "ARTWORK")
	ns.ApplyIcon(icon, 16)
	icon:SetPoint("TOPLEFT", W.PAD, -10)
	local T = W.Theme()
	if T and T.Color then pcall(T.Color, icon, "icon") end
	local title = W.Text(parent, "title", GameFontNormalLarge)
	title:SetPoint("LEFT", icon, "RIGHT", 6, 0)
	title:SetPoint("TOP", parent, "TOP", 0, -10)
	title:SetText(text)
	return title
end

-- Calls fn about once a second while `frame` is shown.
function W.EverySecond(frame, fn)
	local elapsed = 0
	frame:SetScript("OnUpdate", function(_, dt)
		elapsed = elapsed + dt
		if elapsed >= 1 then elapsed = 0 fn() end
	end)
end

---------------------------------------------------------------------------
-- Players
---------------------------------------------------------------------------

local function classColor(class)
	local c = class and RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
	if c and c.colorStr then return c.colorStr end
	return "ffffffff"
end

function W.Whisper(name)
	if ChatFrame_SendTell then
		ChatFrame_SendTell(name)
	elseif ChatFrame_OpenChat then
		ChatFrame_OpenChat("/w " .. name .. " ")
	end
end

-- A player already in a group cannot be invited: we ask them to invite us.
function W.CanOnlyAsk(e)
	return (e.size or 0) > 0
end

-- Can the row's Invite / Ask act? nil when it can, else why not: in a
-- group, only its leader invites, into room left, a solo player (two groups
-- do not merge).
function W.InviteBlocked(e)
	if not ns.InGroup() then return nil end
	if W.CanOnlyAsk(e) then return L["You are both in a group: groups do not merge."] end
	if not ns.Group.CanInvite() then return L["Only your group leader can invite."] end
	if ns.Group.PartySize() >= ns.Group.MAX_PARTY then return L["Your group is full."] end
	return nil
end

-- The Invite / Ask click on a player row: invites (or asks to join) and
-- whispers the matching message (Messages.lua), only on this click.
function W.Invite(e)
	local why = W.InviteBlocked(e)
	if why then ns.Print(why) return end
	local name, quests = e.name, e.quests
	-- Remembered, so that the finder can say hello, then goodbye once these quests are done.
	if ns.Leave and quests then ns.Leave.NoteInvite(name, quests) end
	if W.CanOnlyAsk(e) then
		ns.Messages.Whisper("ask", name, quests)
		return
	end
	ns.InviteUnit(name)
	ns.Messages.Whisper("invite", name, quests)
end

local KIND_NAMES = { k = L["kill"], n = L["named"], l = L["loot"], g = L["group"] }
function W.KindTag(kind)
	return kind and KIND_NAMES[kind] and ("(" .. KIND_NAMES[kind] .. ") ") or ""
end

function W.Distance(e)
	if e.yards then return string.format(L["%d yd"], math.floor(e.yards + 0.5)) end
	if e.sameZone then return L["same zone"] end
	return L["other zone"]
end

-- What is happening with this player (invited, waiting for their
-- invitation, already in a group), else how far.
local function stateText(e)
	if e.state == "invited" then return W.Hex("success", "ff6bd999") .. L["invited"] .. "|r" end
	if e.state == "asked" then return W.Hex("warning", "fffabf4d") .. L["pending"] .. "|r" end
	if (e.size or 0) > 0 then return W.Dim() .. L["in a group"] .. "|r" end
	return W.Dim() .. W.Distance(e) .. "|r"
end

-- Another player's progress on quest `id`, small: their first open
-- objective as "7/10 Kobold Vermin slain" (their counts, the words from our
-- own log: same quest, same objectives), "done" once all are; for a quest
-- search answer without counts, the percent they sent; "" when unknown.
function W.PeerProgress(e, id)
	local counts = e.counts and e.counts[id]
	if counts then
		local q = ns.Quests.Log()[id]
		local objectives = q and q.objectives or {}
		for i, c in ipairs(counts) do
			if c[1] < c[2] then
				local label = ns.Messages.ObjectiveLabel(objectives[i])
				return c[1] .. "/" .. c[2] .. (label ~= "" and (" " .. label) or "")
			end
		end
		return L["done"]
	end
	if e.pct then return e.pct >= 100 and L["done"] or (e.pct .. "%") end
	return ""
end


-- A small square button showing one of our icons, tinted like Polestar's
-- own (icon, accent on hover), with a tooltip; `tip` may be a function.
function W.IconButton(parent, icon, tip, onClick)
	local size = W.ICON_BTN
	local b = CreateFrame("Button", nil, parent)
	b:SetSize(size, size)
	b:RegisterForClicks("LeftButtonUp")
	W.Skin(b, "button")
	b.Icon = b:CreateTexture(nil, "OVERLAY")
	b.Icon:SetSize(size - 6, size - 6)
	b.Icon:SetPoint("CENTER")
	b.Icon:SetTexture(ns.P.Theme.Media(icon))
	local function paint(hover)
		hover = hover or b.psActive
		local T = W.Theme()
		local token = hover and "accent" or "icon"
		if T and T.Color and pcall(T.Color, b.Icon, token) then return end
		if hover then b.Icon:SetVertexColor(1, 0.82, 0, 1) else b.Icon:SetVertexColor(0.85, 0.88, 0.95, 1) end
	end
	paint(false)
	b.psPaint = paint
	b.psTip = tip
	b:SetScript("OnClick", onClick)
	b:SetScript("OnEnter", function(self)
		paint(true)
		local text = type(self.psTip) == "function" and self.psTip() or self.psTip
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText(text, 1, 1, 1)
		GameTooltip:Show()
	end)
	b:SetScript("OnLeave", function() paint(false) GameTooltip:Hide() end)
	return b
end

-- A player row: name, level and language on the first line, the state or
-- distance at its right, `info` (the quest, and their progress small) on
-- the second, the Whisper and Invite icons at the right. The tooltip lists
-- every shared quest with their progress.
function W.PlayerRow(parent)
	local PAD, BTN_COL = W.PAD, W.BTN_COL
	local r = CreateFrame("Frame", nil, parent)
	r:SetSize(W.WIDTH - 2 * PAD, W.ROW_H)
	r:EnableMouse(true)
	r.dist = W.Text(r, "small", GameFontHighlightSmall)
	r.dist:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(BTN_COL + 8), -3)
	r.dist:SetJustifyH("RIGHT")
	r.name = W.Text(r, "body", GameFontNormal)
	r.name:SetPoint("TOPLEFT", 0, -2)
	r.name:SetPoint("RIGHT", r.dist, "LEFT", -6, 0)
	r.name:SetJustifyH("LEFT")
	r.name:SetWordWrap(false)
	r.info = W.Text(r, "small", GameFontHighlightSmall)
	r.info:SetPoint("TOPLEFT", r.name, "BOTTOMLEFT", 0, -3)
	r.info:SetPoint("RIGHT", r, "RIGHT", -(BTN_COL + 8), 0)
	r.info:SetJustifyH("LEFT")
	r.info:SetWordWrap(false)
	r.invite = W.IconButton(r, "plus", function()
		local why = rawget(r.invite, "psWhy")
		if why then return why end
		return r.entry and W.CanOnlyAsk(r.entry) and L["Ask to join (they are in a group: you cannot invite them, so this whispers a request)"] or L["Invite"]
	end, function() if r.entry then W.Invite(r.entry) end end)
	r.invite:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.whisper = W.IconButton(r, "icon-talk", L["Whisper"], function() if r.entry then W.Whisper(r.entry.name) end end)
	r.whisper:SetPoint("RIGHT", r.invite, "LEFT", -4, 0)
	r:SetScript("OnEnter", function(self)
		local e = self.entry
		if not e then return end
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText(ns.ShortName(e.name), 1, 1, 1)
		for _, id in ipairs(e.quests) do
			local left = W.PeerProgress(e, id)
			GameTooltip:AddLine(W.KindTag(e.kinds and e.kinds[id]) .. ns.Quests.Title(id)
				.. (left ~= "" and ("  " .. W.Dim() .. left .. "|r") or ""), nil, nil, nil, true)
		end
		GameTooltip:AddLine(W.Distance(e), 0.6, 0.6, 0.65)
		GameTooltip:Show()
	end)
	r:SetScript("OnLeave", function() GameTooltip:Hide() end)
	return r
end

-- Shows entry `e` on row `r`, with `info` as the second line.
function W.FillRow(r, e, info)
	r.entry = e
	local lang = e.langTag and e.langTag ~= "?" and ("  " .. W.Dim() .. e.langTag .. "|r") or ""
	local level = e.level and e.level > 0 and (W.Dim() .. e.level .. "|r") or ""
	r.name:SetText(string.format("|c%s%s|r  %s%s", classColor(e.class), ns.ShortName(e.name), level, lang))
	r.dist:SetText(stateText(e))
	r.info:SetText(info)
	local why = W.InviteBlocked(e)
	r.invite.psWhy = why
	r.invite:SetEnabled(why == nil)
	r.invite:SetAlpha(why and 0.35 or 1)
end

-- Lays out up to #rows entries of `list` from `y` down; returns the new y.
function W.LayoutRows(parent, rows, list, y, info)
	for i = 1, #rows do
		local r, e = rows[i], list[i]
		if e then
			W.FillRow(r, e, info(e))
			r:SetWidth(parent:GetWidth() - 2 * W.PAD)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", parent, "TOPLEFT", W.PAD, -y)
			r:Show()
			y = y + W.ROW_H
		else
			r.entry = nil
			r:Hide()
		end
	end
	return y
end
