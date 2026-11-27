-- The Free mode section of the hub (docs/ARCHITECTURE.md, "Free mode"), right
-- under Guides on the rail. This is its door: the pages themselves (Main page,
-- where Free mode is turned on and off; Your quests; About Free mode) are
-- Polestar_FreeMode/Page.lua, which loads, like the mode, the first time the
-- section shows; they are the sidebar's three entries (Page.Nav, Page.Open).
-- Without the folder the section says why.
--
--   UI.ShowFreeMode(page?)   -- the hub on this section; page: "main" | "quests" | "about"

local ADDON, ns = ...
local UI, W = ns.UI, ns.Widgets
local L = ns.L
local SH = W.SHELL
local Free = ns.Free

local KEY = "FreeMode"
local frame, hub, note, built, why, want

local function ensure()
	if built then return true end
	local ok, reason = Free.Load()
	if not (ok and Free.Page) then
		why = reason or "missing"
		return false
	end
	Free.Page.Build(frame, hub)
	built = true
	if want then
		Free.Page.SetPage(want)
		want = nil
	end
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
	W.ShellTitle(hub, L["Free mode"], L["Your own quests, planned for you."])
	note:SetWidth(mainWidth() - SH.pad * 2)
	note:SetText(why == "combat" and L["Free mode starts after combat."]
		or L["Free mode can't start: its folder Polestar_FreeMode or the Codex is missing or turned off."])
	note:Show()
end

function UI.ShowFreeMode(page)
	want = page
	if built and want then
		Free.Page.SetPage(want)
		want = nil
	end
	local P = UI.Picker
	local win = PolestarPicker
	local was = win and win:IsShown()
	if P and P.ShowSection then P.ShowSection(KEY) end
	if not was and UI.ShowPicker then UI.ShowPicker() end
end

-- The sidebar: the section's three pages, a click shows one (Page.Nav, Page.Open).
local function nav()
	if built and Free.Page then return Free.Page.Nav() end
	return { { key = KEY, label = L["Free mode"], icon = "icon-freemode" } }, KEY
end

local function onNav(key)
	if built and Free.Page then Free.Page.Open(key) end
end

if UI.RegisterSection and Free then
	UI.RegisterSection({ key = KEY, label = L["Free mode"], icon = "icon-freemode", order = 15, build = build, render = render, nav = nav, onNav = onNav })
end
