-- Quick settings: a small popover from the guide window's menu ("Quick
-- settings", just before Options) with the few settings players change in the
-- middle of play: the window's lock and opacity, the arrow, auto-accept and
-- auto turn-in, the route lines; then "All settings…", which opens the
-- settings window (SHOW_OPTIONS). Core, small, built on first open: it never
-- needs the settings window's own addon. Rows are the settings window's
-- compact halves (W.CompactRow), one column, 32 px; help in their tooltips.
-- Escape, a click outside it or the menu button again closes it; with the
-- gamepad it takes the focus like any Polestar window (B closes).

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, ipairs = math.floor, ipairs

local QS = {}
UI.QuickSettings = QS

local WIDTH, ROW_H, FOOT_H = 280, 32, 44

local function percent(v) return floor(v * 100 + 0.5) .. "%" end

-- The settings, in the order they show. A key nothing registered a default
-- for (its module not loaded) is left out.
QS.ROWS = {
	{ kind = "toggle", key = "ui.locked", label = L["Lock window"], help = L["Prevents moving and resizing."] },
	{ kind = "slider", key = "ui.opacity", label = L["Opacity"], min = 0.3, max = 1, step = 0.05, format = percent,
		help = L["The whole guide window, text included."] },
	{ kind = "toggle", key = "nav.arrow", label = L["Arrow"], help = L["Points to the current goal."] },
	{ kind = "toggle", key = "behavior.autoAccept", label = L["Auto-accept"], help = L["Accepts the guide's quests when you talk to their givers."] },
	{ kind = "toggle", key = "behavior.autoTurnin", label = L["Auto turn-in"], help = L["Hands in the guide's quests when you talk to their NPCs."] },
	{ kind = "toggle", key = "nav.routeLines", label = L["Route lines"], help = L["The way to the goal on the world map and the minimap."] },
}

local pop

local function build()
	pop = CreateFrame("Frame", "PolestarQuickSettings", ns.UIParent)
	pop:SetFrameStrata("DIALOG")
	pop:SetFrameLevel(20)
	pop:SetClampedToScreen(true)
	pop:EnableMouse(true)
	Theme.Skin(pop, "panel")
	pop.Title = W.Text(pop, "heading", "text")
	pop.Title:SetText(L["Quick settings"])
	pop.Title:SetPoint("TOPLEFT", pop, "TOPLEFT", 16, -12)
	pop.Rule = W.Divider(pop)
	pop.Rule:SetPoint("TOPLEFT", pop, "TOPLEFT", 1, -W.CARD_HEADER)
	pop.Rule:SetPoint("TOPRIGHT", pop, "TOPRIGHT", -1, -W.CARD_HEADER)
	pop.rows = {}
	local y = W.CARD_HEADER + 1
	for _, c in ipairs(QS.ROWS) do
		if ns.GetDefault(c.key) ~= nil then
			local w
			if c.kind == "slider" then
				w = W.Slider(pop, c.label, c.key, c.min, c.max, c.step, c.format, c.help)
			else
				w = W.Toggle(pop, c.label, c.key, c.help)
			end
			W.CompactRow(w, { height = ROW_H })
			w:SetPoint("TOPLEFT", pop, "TOPLEFT", 0, -y)
			y = y + W.LayoutRow(w, WIDTH)
			pop.rows[c.key] = w
		end
	end
	-- All settings…: the settings window, where everything else is.
	local all = W.Button(pop, L["All settings\226\128\166"], function()
		QS.Hide()
		ns.Fire("SHOW_OPTIONS")
	end, { width = WIDTH - 32 })
	all:SetPoint("TOP", pop, "TOPLEFT", WIDTH / 2, -(y + 8))
	pop.All = all
	pop:SetSize(WIDTH, y + FOOT_H)
	-- A click anywhere else closes it.
	local catcher = CreateFrame("Button", nil, ns.UIParent)
	catcher:SetAllPoints(UIParent)
	catcher:SetFrameStrata("DIALOG")
	catcher:SetFrameLevel(1)
	catcher:RegisterForClicks("AnyUp")
	catcher:SetScript("OnClick", function() QS.Hide() end)
	catcher:Hide()
	pop.Catcher = catcher
	pop:SetScript("OnHide", function() catcher:Hide() end)
	pop:Hide()
	ns.CloseOnEscape("PolestarQuickSettings")
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(pop, { back = function() QS.Hide() end })
	end
end

-- Open by `anchor` (the guide window's menu button), its right edges lined
-- up under it.
function QS.Show(anchor)
	if not pop then build() end
	W.HideMenu()
	pop:ClearAllPoints()
	if anchor then
		pop:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -4)
	else
		pop:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
	pop.Catcher:Show()
	pop:Show()
	pop:Raise()
	Anim.To(pop, "alpha", 0, 1, Anim.FAST, "out")
	return pop
end

function QS.Hide()
	if pop then pop:Hide() end
end

function QS.Shown() return pop ~= nil and pop:IsShown() end

-- Open, or close it when it is open.
function QS.Toggle(anchor)
	if QS.Shown() then return QS.Hide() end
	return QS.Show(anchor)
end

-- The popover's rows by setting key (tests).
function QS.Rows() return pop and pop.rows or {} end
