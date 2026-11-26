-- The Free mode section of the hub (docs/ARCHITECTURE.md, "Free mode"), right
-- under Guides on the rail. This is its door: the page itself (Start or Return
-- to <guide>, the order, the hand-in route and every quest in the log with a
-- tick and a pin) is Polestar_FreeMode/Page.lua, which loads, like the mode,
-- the first time the page shows. Without the folder the page says why.
--
--   UI.ShowFreeMode()   -- the hub on this section

local ADDON, ns = ...
local UI, W = ns.UI, ns.Widgets
local L = ns.L
local SH = W.SHELL
local Free = ns.Free

local KEY = "FreeMode"
local frame, hub, note, built, why

local function ensure()
	if built then return true end
	local ok, reason = Free.Load()
	if not (ok and Free.Page) then
		why = reason or "missing"
		return false
	end
	Free.Page.Build(frame, hub)
	built = true
	return true
end

local function mainWidth()
	local w = hub and (hub:GetWidth() - (hub.psRail or 0) - (hub.psSidebar or SH.sidebar) - 2) or 0
	if w <= 0 then w = 878 end
	return w
end

local function build(parent, shell)
	frame, hub = parent, shell
	note = W.Text(parent, "note", "textDim")
	note:SetWordWrap(true)
	note:SetJustifyH("LEFT")
	note:SetJustifyV("TOP")
	note:SetPoint("TOPLEFT", parent, "TOPLEFT", SH.pad, -28)
	note:Hide()
	ensure()
end

local function render()
	if ensure() then
		note:Hide()
		Free.Page.Render()
		return
	end
	W.ShellTitle(hub, L["Free mode"], L["Your own quests as a guide: the arrow takes them in the order that gets the most done for the walk (or nearest first, or the most XP a minute)."])
	note:SetWidth(mainWidth() - SH.pad * 2)
	note:SetText(why == "combat" and L["Free mode starts after combat."]
		or L["Free mode can't start: its folder Polestar_FreeMode or the Codex is missing or turned off."])
	note:Show()
end

function UI.ShowFreeMode()
	local P = UI.Picker
	local win = PolestarPicker
	local was = win and win:IsShown()
	if P and P.ShowSection then P.ShowSection(KEY) end
	if not was and UI.ShowPicker then UI.ShowPicker() end
end

if UI.RegisterSection and Free then
	UI.RegisterSection({ key = KEY, label = L["Free mode"], icon = "icon-ownpath", order = 15, build = build, render = render })
end
