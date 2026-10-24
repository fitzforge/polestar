-- The Characters section of the hub: one row per character on the account,
-- each as of its last logout (Snapshot.lua), the playing one live. The tab
-- row sorts them (last played, most rested, level); the sidebar lists them,
-- and picking one selects its row. Each row
-- shows the class, level, last played, the XP bar with rested XP projected
-- to now behind it, the guide being followed, and where the character stands
-- (zone, hearth, gold, professions). Click a row to select it; "Forget"
-- drops the selected character's snapshot (never the one playing).
--
-- Registered with UI.RegisterSection; opened by SHOW_ALTS (/polestar alts).

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local Alts = ns.Alts
local Compat = ns.Compat
local L = ns.L
local max, min, floor, ipairs, pairs, format = math.max, math.min, math.floor, ipairs, pairs, string.format

if not (UI and W and W.SHELL and Alts) then return end

local SH = W.SHELL
local FOOT_PAD = 16
local FOOT_H = 28 + FOOT_PAD * 2
local ROW_H = 128
local ROW_GAP = 8
local COL_X = 248 -- where a row's right column (bar and facts) starts
local LABEL_W = 124
local DOT = "  \194\183  "

local AV = {}
UI.AltsSection = AV

local root, shellRef, scroll, foot, empty
local rows = {}
local selected -- the selected character's key
local shown = {}

local SORTS = {
	{ key = "seen", label = L["Last played"] },
	{ key = "rested", label = L["Most rested"] },
	{ key = "level", label = L["Level"] },
}

-- The professions' names where the client gives none (Compat.GetSkillLineName).
local PROF_NAMES = {
	[171] = L["Alchemy"], [164] = L["Blacksmithing"], [333] = L["Enchanting"], [202] = L["Engineering"],
	[182] = L["Herbalism"], [165] = L["Leatherworking"], [186] = L["Mining"], [393] = L["Skinning"],
	[197] = L["Tailoring"], [185] = L["Cooking"], [356] = L["Fishing"], [129] = L["First Aid"],
}

local function ago(t, now)
	local d = max(0, now - (t or now))
	if d < 60 then return L["just now"] end
	if d < 3600 then return format(L["%d min ago"], floor(d / 60)) end
	if d < 86400 then return format(L["%d h ago"], floor(d / 3600)) end
	local days = floor(d / 86400)
	return days == 1 and L["yesterday"] or format(L["%d days ago"], days)
end

local function thousands(n)
	local s = tostring(floor(n))
	while true do
		local k
		s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then return s end
	end
end


local function profLine(profs)
	local list = {}
	for line, rank in pairs(profs or {}) do list[#list + 1] = { line = line, rank = rank } end
	if #list == 0 then return L["None yet"] end
	table.sort(list, function(a, b)
		if a.rank ~= b.rank then return a.rank > b.rank end
		return a.line < b.line
	end)
	local out = {}
	for i, p in ipairs(list) do
		local name = Compat.GetSkillLineName and Compat.GetSkillLineName(p.line) or PROF_NAMES[p.line] or tostring(p.line)
		out[i] = name .. " " .. p.rank
	end
	return table.concat(out, DOT)
end

local function guideLine(e)
	local t = e.tabs and (e.tabs[e.active or 1] or e.tabs[1])
	if not (t and t.title) then return "" end
	if t.complete then return t.title .. DOT .. L["complete"] end
	return t.title .. DOT .. format(L["step %d of %d"], t.step or 1, t.count or 1)
end

local function rowWidth()
	local full = shellRef and (shellRef:GetWidth() - (shellRef.psRail or 0) - (shellRef.psSidebar or SH.sidebar) - 2) or 0
	if full <= 0 then full = 654 end
	return full - SH.pad * 2
end

local function fact(r, i, label)
	local l = W.Text(r, "caption", "textMuted")
	l:SetPoint("TOPLEFT", r, "TOPLEFT", COL_X, -(52 + (i - 1) * 15))
	l:SetWidth(LABEL_W)
	l:SetText(label)
	local v = W.Text(r, "small", "text")
	v:SetPoint("TOPLEFT", r, "TOPLEFT", COL_X + LABEL_W, -(52 + (i - 1) * 15))
	return v
end

local function row(i)
	local r = rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, scroll.Child)
	r:SetHeight(ROW_H)
	W.Fill(r, "panel")
	W.Hover(r)
	r.Selected = r:CreateTexture(nil, "BACKGROUND", nil, 1)
	r.Selected:SetTexture(Theme.Media("white"))
	r.Selected:SetAllPoints(r)
	W.Painter(r.Selected, function(t) t:SetVertexColor(Theme.Wash("selected")) end)
	r.Bar = r:CreateTexture(nil, "ARTWORK")
	r.Bar:SetTexture(Theme.Media("white"))
	r.Bar:SetWidth(2)
	r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
	r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
	W.Color(r.Bar, "accent")
	r.Name = W.Text(r, "body", "text")
	r.Name:SetPoint("TOPLEFT", r, "TOPLEFT", 14, -14)
	r.Chip = W.Chip(r)
	r.Chip:SetPoint("LEFT", r.Name, "RIGHT", 8, 0)
	r.Class = W.Text(r, "small", "textDim")
	r.Class:SetPoint("TOPLEFT", r, "TOPLEFT", 14, -36)
	r.Last = W.Text(r, "small", "textMuted")
	r.Last:SetPoint("TOPLEFT", r, "TOPLEFT", 14, -54)
	r.Guide = W.Text(r, "small", "textDim")
	r.Guide:SetPoint("TOPLEFT", r, "TOPLEFT", 14, -82)
	r.Guide:SetWidth(COL_X - 14 - 12)
	r.XP = W.ProgressLine(r, 8)
	r.XP:SetPoint("TOPLEFT", r, "TOPLEFT", COL_X, -16)
	r.Rested = r.XP:CreateTexture(nil, "BORDER")
	r.Rested:SetTexture(Theme.Media("white"))
	r.Rested:SetPoint("TOPLEFT", r.XP, "TOPLEFT", 0, 0)
	r.Rested:SetPoint("BOTTOMLEFT", r.XP, "BOTTOMLEFT", 0, 0)
	r.Rested:SetWidth(0.01)
	W.Color(r.Rested, "accent", 0.4)
	r.Pct = W.Text(r, "small", "text")
	r.Pct:SetPoint("TOPLEFT", r, "TOPLEFT", COL_X, -30)
	r.RestedText = W.Text(r, "small", "textDim")
	r.RestedText:SetJustifyH("RIGHT")
	r.Zone = fact(r, 1, L["Zone"])
	r.Hearth = fact(r, 2, L["Hearthstone"])
	r.Gold = fact(r, 3, L["Gold"])
	r.Profs = fact(r, 4, L["Professions"])
	r.Profs:SetWordWrap(true) -- a long list takes a second line
	r.Profs:SetJustifyV("TOP")
	r:SetScript("OnClick", function(self) AV.Select(self.psKey) end)
	rows[i] = r
	return r
end

local function restedText(e, now)
	local rested = Alts.Rested(e, now)
	if not rested or rested <= 0 or not e.xpMax or e.xpMax <= 0 then return "" end
	if rested >= Alts.REST_CAP * e.xpMax - 1 then return format(L["Fully rested (%s levels)"], Alts.REST_CAP) end
	if not Alts.IsCurrent(e) and not e.resting then
		return format(L["+%d%% \194\183 not at an inn, slower"], floor(rested / e.xpMax * 100 + 0.5))
	end
	return format(L["+%s rested"], thousands(rested))
end

local function paint(r, e, now, width)
	local current = Alts.IsCurrent(e)
	local cr, cg, cb
	if e.class then cr, cg, cb = Theme.ClassColor(e.class) end -- nil would give the player's colour
	r.psKey = e.key
	r:SetWidth(width)
	local on = selected == e.key
	r.Selected:SetShown(on)
	r.Bar:SetShown(on)
	r.Name:SetText(e.name or "?")
	if cr then
		W.Uncolor(r.Name)
		r.Name:SetTextColor(cr, cg, cb, 1)
	else
		W.Color(r.Name, "text")
	end
	r.Name:SetWidth(min(220, floor(r.Name:GetStringWidth() + 2)))
	if current then W.SetChip(r.Chip, L["Playing"]) else r.Chip:Hide() end
	local classText = UI.ClassName and UI.ClassName(e.class) or tostring(e.class or "")
	local raceText = UI.RaceName and UI.RaceName(e.race) or tostring(e.race or "")
	r.Class:SetText(format(L["Level %d %s %s"], e.level or 1, raceText, classText))
	r.Last:SetText(current and L["Playing now"] or format(L["Last played %s"], ago(e.seen, now)))
	r.Guide:SetText(guideLine(e))

	local barW = width - COL_X - 14
	r.XP:SetWidth(barW)
	local frac = (e.xpMax and e.xpMax > 0) and min(1, (e.xp or 0) / e.xpMax) or 0
	local rested = Alts.Rested(e, now)
	local restedFrac = (rested and e.xpMax and e.xpMax > 0) and min(1, ((e.xp or 0) + rested) / e.xpMax) or 0
	W.SetProgress(r.XP, frac, barW)
	r.Rested:SetWidth(max(0.01, barW * restedFrac))
	r.Rested:SetShown(restedFrac > frac)
	local level = e.level or 1
	if level >= Alts.MaxLevel() then
		r.Pct:SetText(L["Max level"])
	elseif e.xpMax and e.xpMax > 0 then
		r.Pct:SetText(format(L["%d%% to %d"], floor(frac * 100), level + 1))
	else
		r.Pct:SetText("")
	end
	local rt = restedText(e, now)
	r.RestedText:SetText(rt)
	r.RestedText:ClearAllPoints()
	r.RestedText:SetPoint("TOPRIGHT", r, "TOPRIGHT", -14, -30)

	local valueW = barW - LABEL_W
	r.Zone:SetText(e.zone or "")
	r.Hearth:SetText(e.bind or "")
	r.Gold:SetText(ns.MoneyText(e.money))
	r.Profs:SetText(profLine(e.profs))
	for _, fs in ipairs({ r.Zone, r.Hearth, r.Gold, r.Profs }) do fs:SetWidth(valueW) end
	r:Show()
	return rt
end

function AV.Build(parent, shell)
	if root then return root end
	shellRef = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)

	foot = CreateFrame("Frame", nil, root)
	foot:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT", 0, 0)
	foot:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
	foot:SetHeight(FOOT_H)
	foot.Rule = W.Divider(foot)
	foot.Rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	foot.Rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	local xpSwatch = W.Tex(foot, "ARTWORK", "white", "accent")
	xpSwatch:SetSize(12, 8)
	xpSwatch:SetPoint("LEFT", foot, "LEFT", SH.pad, 0)
	local xpText = W.Text(foot, "small", "textDim")
	xpText:SetPoint("LEFT", xpSwatch, "RIGHT", 6, 0)
	xpText:SetText(L["Experience"])
	local restSwatch = W.Tex(foot, "ARTWORK", "white", "accent")
	W.Color(restSwatch, "accent", 0.4)
	restSwatch:SetSize(12, 8)
	restSwatch:SetPoint("LEFT", xpText, "RIGHT", 16, 0)
	local restText = W.Text(foot, "small", "textDim")
	restText:SetPoint("LEFT", restSwatch, "RIGHT", 6, 0)
	restText:SetText(L["Rested, projected to now"])
	foot.Forget = W.Button(foot, L["Forget"], nil, { height = 28 })
	foot.Forget.psSetText = W.SetButtonText
	W.Confirm(foot.Forget, L["Forget"], function() AV.Forget() end)
	foot.Forget:SetPoint("RIGHT", foot, "RIGHT", -SH.pad, 0)

	scroll = W.Scroll(root)
	scroll:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
	scroll:SetPoint("BOTTOMRIGHT", foot, "TOPRIGHT", 0, 0)
	empty = W.Text(scroll.Child, "note", "textMuted")
	empty:SetPoint("TOPLEFT", scroll.Child, "TOPLEFT", SH.pad, -8)
	empty:SetText(L["No characters yet."])
	root.Note = W.Text(scroll.Child, "note", "textDim")
	root.Note:SetWordWrap(true)
	root.Note:SetJustifyV("TOP")
	root.Note:SetPoint("TOPLEFT", scroll.Child, "TOPLEFT", SH.pad, -12)
	return root
end

-- The saved characters, the playing one brought up to now first (so the page
-- never lacks it before the login write, or mixes old XP with live rested).
-- With the module off nothing is written: what was saved is listed as it is.
local function entries()
	local on = Alts.Enabled()
	if on then Alts.Write(true) end
	return Alts.List(ns.Get("alts.sort")), on
end

local function subtitle(list, on)
	local me = Alts.Key()
	local info = Compat.GetPlayerInfo()
	local n = #list
	local realms, nRealms = {}, 0
	for _, e in ipairs(list) do
		if not realms[e.realm or ""] then
			realms[e.realm or ""] = true
			nRealms = nRealms + 1
		end
	end
	local sub
	if not on then
		sub = L["Turned off: showing what was saved"]
	elseif nRealms > 1 then
		sub = format(L["%d characters on %d realms \194\183 each as of their last logout"], n, nRealms)
	elseif n == 1 and list[1].key == me then
		sub = format(L["1 character on %s"], info.realm or "")
	elseif n == 1 then
		sub = format(L["1 character on %s \194\183 each as of their last logout"], info.realm or "")
	else
		sub = format(L["%d characters on %s \194\183 each as of their last logout"], n, info.realm or "")
	end
	local Maps = ns.Maps
	if on and Maps and Maps.GetInstanceStatus and ns.Get("maps.instances") then
		local st = Maps.GetInstanceStatus()
		shown.instances = { st.inHour, st.perHour }
		-- Its own line: beside the count it wraps mid-figure in a narrow window.
		sub = sub .. "\n" .. format(L["Instances this hour: %d/%d"], st.inHour or 0, st.perHour or 0)
	end
	return sub
end

function AV.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	local sortKey = ns.Get("alts.sort")
	local list, on = entries()
	local now = Compat.Now()
	local width = rowWidth()
	local me = Alts.Key()
	if not selected then selected = me end

	local sub = subtitle(list, on)
	if shellRef then
		W.ShellTitle(shellRef, L["Characters"], sub)
		local tabs = {}
		for i, t in ipairs(SORTS) do tabs[i] = { key = t.key, label = t.label } end
		W.ShellTabs(shellRef, tabs, sortKey, function(k) AV.SetSort(k) end)
	end
	shown.subtitle = sub

	local y = 8
	if on then
		root.Note:Hide()
	else
		root.Note:SetWidth(width)
		root.Note:SetText(L["Characters is turned off. Turn it on under Options > Discovery > Characters."])
		root.Note:Show()
		y = 12 + floor(root.Note:GetStringHeight() + 0.5) + 12
	end
	shown.keys, shown.rested, shown.tops = {}, {}, {}
	for i, e in ipairs(list) do
		local r = row(i)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", scroll.Child, "TOPLEFT", SH.pad, -y)
		shown.rested[i] = paint(r, e, now, width)
		shown.keys[i] = e.key
		shown.tops[i] = y
		y = y + ROW_H + ROW_GAP
	end
	for i = #list + 1, #rows do rows[i]:Hide() end
	empty:SetText(L["No characters yet."])
	empty:ClearAllPoints()
	empty:SetPoint("TOPLEFT", scroll.Child, "TOPLEFT", SH.pad, -y)
	empty:SetShown(#list == 0)
	shown.off = not on
	scroll.Child:SetWidth(width + SH.pad * 2)
	W.SetScrollContent(scroll, y + 8)

	local sel
	for _, e in ipairs(list) do if e.key == selected then sel = e end end
	if not sel then selected = me end
	local canForget = sel ~= nil and sel.key ~= me
	foot.Forget:SetEnabled(canForget)
	-- A second click within 3 seconds forgets (W.Confirm); a new selection disarms it.
	local text = canForget and format(L["Forget %s"], sel.name or "") or L["Forget"]
	if foot.Forget.psFor ~= selected then foot.Forget.psArmed, foot.Forget.psFor = nil, selected end
	foot.Forget.psConfirmText = text
	if not foot.Forget.psArmed then W.SetButtonText(foot.Forget, text) end
	shown.selected = selected
	shown.rows = #list
end

-- The sidebar: one entry per character, in the class's colour, level at the
-- right; the selected one marked.
function AV.Nav()
	local list = Alts.List(ns.Get("alts.sort")) -- Render has just written the playing character
	local out = {}
	for i, e in ipairs(list) do
		local r, g, b
		if e.class then r, g, b = Theme.ClassColor(e.class) end -- nil would give the player's colour
		local name = e.name or "?"
		if r then name = format("|cff%02x%02x%02x%s|r", floor(r * 255 + 0.5), floor(g * 255 + 0.5), floor(b * 255 + 0.5), name) end
		out[i] = { key = e.key, label = name, count = e.level }
	end
	return out, selected or Alts.Key()
end

local function repaint()
	local P = UI.Picker
	if root and root:IsVisible() and P and P.Render then P.Render() else AV.Render() end
end

function AV.Select(key)
	selected = key
	repaint()
end

-- A sidebar pick: select it and bring its row into view.
function AV.OnNav(key)
	AV.Select(key)
	for i, k in ipairs(shown.keys or {}) do
		if k == key and scroll then W.ScrollTo(scroll, max(0, shown.tops[i] - 8)) end
	end
end

function AV.SetSort(key)
	ns.Set("alts.sort", key)
	repaint()
end

function AV.Forget()
	if selected and Alts.Forget(selected) then
		selected = nil
		repaint()
	end
end

function AV.Shown() return shown end
AV.rows = rows
AV.forgetButton = function() return foot and foot.Forget end

function AV.Show()
	local P = UI.Picker
	if UI.ShowPicker then UI.ShowPicker() end
	if P and P.ShowSection then P.ShowSection("Characters") end
	AV.Render()
end

ns.On("SHOW_ALTS", AV.Show)
ns.On("ALTS_UPDATED", function() if root and root:IsVisible() then repaint() end end)

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Characters", label = L["Characters"], icon = "house", order = 60,
		build = AV.Build, render = AV.Render,
		nav = AV.Nav, onNav = AV.OnNav,
	})
end
