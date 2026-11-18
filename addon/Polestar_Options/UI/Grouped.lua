-- The switch for the settings window's new page ("New settings page", a
-- preview the player turns on in the window's header; PolestarDB.optionsLayout
-- = "grouped", account-wide, off by default). The switch records the choice;
-- the page itself, the same rows laid out in groups, is drawn by the rest of
-- this file once it is on.
--
-- Where the switch stands: on the current page after Menu scale (before the
-- close button); on the new page first of the icon buttons, right of the
-- search. Narrower than SWITCH_ROOM it is the switch alone, its tooltip
-- naming it.

local ns = Polestar
local UI, W = ns.UI, ns.Widgets
local L = ns.L
local O = UI.Options
local K = O.Kit
local floor = math.floor

local G = {}
O.Grouped = G

local B = {}

function G.On()
	return ns.DB().optionsLayout == "grouped"
end

local function win() return K.window() end

local SWITCH_ROOM, fitSwitch = 1000, nil

-- Where the switch stands: after Menu scale on the current page, first of the
-- icon buttons (right of the search) on the new one; the tools list runs
-- right to left, the search last.
local function placeSwitch()
	local w, b = win(), B.Switch
	if not (w and b) then return end
	b.psHeadAfterScale = not G.On() or nil
	local list = rawget(w, "psHeadTools")
	if not list then return end
	for i = #list, 1, -1 do if list[i] == b then table.remove(list, i) end end
	local at = #list + 1
	if G.On() then
		for i, t in ipairs(list) do if t == rawget(w, "Search") then at = i break end end
	end
	table.insert(list, at, b)
end
function G.Switch() return B.Switch end

-- The choice, saved for the account; an open window shows its page again.
function G.SetOn(on)
	local w = win()
	local was = G.On()
	ns.DB().optionsLayout = on and "grouped" or nil
	if B.Switch then B.Switch.Sw:Refresh() end
	placeSwitch()
	if w and w:IsShown() and was ~= (on and true or false) then
		local current, currentTab = K.current()
		O.Select(current and current.key, currentTab and currentTab.name)
	end
	fitSwitch()
end

-- The switch's label while the header has room for it (a main column of
-- SWITCH_ROOM); the switch alone, its tooltip naming it, in a narrower one.
function fitSwitch()
	local w, b = win(), B.Switch
	if not (w and b) then return end
	local room = (tonumber(rawget(w, "psMainW")) or 0) >= SWITCH_ROOM
	b.Label:SetShown(room)
	b:SetWidth(floor(b.Sw:GetWidth() + (room and (4 + b.Label:GetStringWidth()) or 0) + 0.5))
	if rawget(w, "HeaderTools") then w.HeaderTools.Place() end
end

local function ensureSwitch()
	local w = win()
	if not w or B.Switch then return end
	local b = CreateFrame("Button", nil, w.Header)
	b:SetHeight(24)
	b.Sw = W.Switch(b, G.On, function(v) G.SetOn(v) end)
	b.Sw:SetPoint("LEFT", b, "LEFT", 0, 0)
	b.Label = W.Text(b, "label", "textDim")
	b.Label:SetText(L["New settings page"])
	b.Label:SetPoint("LEFT", b.Sw, "RIGHT", 4, 0)
	b:SetWidth(floor(b.Sw:GetWidth() + 4 + b.Label:GetStringWidth() + 0.5))
	local lines = { L["A preview of the settings in groups, with tabs, a filter and a preview beside the rows. The same settings; switch it off for the current page."] }
	b.Sw.psTip, b.Sw.psTipLines = L["New settings page"], lines
	b:SetScript("OnClick", function() G.SetOn(not G.On()) end)
	b:SetScript("OnEnter", function(self)
		W.Color(self.Label, "text")
		W.Tooltip(self, "ANCHOR_BOTTOM", L["New settings page"], lines)
	end)
	b:SetScript("OnLeave", function(self)
		W.Color(self.Label, "textDim")
		W.HideTooltip(self)
	end)
	B.Switch = b
	w.psHeadTools = w.psHeadTools or {}
	w.psHeadTools[#w.psHeadTools + 1] = b
	placeSwitch()
	fitSwitch()
	w:HookScript("OnSizeChanged", fitSwitch)
end

local show = UI.ShowOptions
function UI.ShowOptions(...)
	local r = show(...)
	ensureSwitch()
	if B.Switch then B.Switch.Sw:Refresh() placeSwitch() fitSwitch() end
	return r
end
