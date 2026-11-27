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

-- A popover of its own: opts = { name (its frame's global name), title, rows (as QS.ROWS, read when it is
-- first shown), all = fn (its foot's All settings…), noReset (its rows show no reset to default) }. The guide window's is one (QS.Show below); a module
-- makes its own the same way (the group finder's panel cog, Polestar_GroupFinder/UI/Panel.lua).
function QS.New(opts)
	local pop
	local P = {}

	local function build()
		pop = CreateFrame("Frame", opts.name, ns.UIParent)
		pop:SetFrameStrata("DIALOG")
		pop:SetFrameLevel(20)
		pop:SetClampedToScreen(true)
		pop:EnableMouse(true)
		-- A popup over other frames: its ground never see-through (Theme's menuBg).
		pop.psMenu = true
		Theme.Skin(pop, "panel")
		pop.Title = W.Text(pop, "heading", "text")
		pop.Title:SetText(opts.title)
		pop.Title:SetPoint("TOPLEFT", pop, "TOPLEFT", 16, -12)
		pop.Rule = W.Divider(pop)
		pop.Rule:SetPoint("TOPLEFT", pop, "TOPLEFT", 1, -W.CARD_HEADER)
		pop.Rule:SetPoint("TOPRIGHT", pop, "TOPRIGHT", -1, -W.CARD_HEADER)
		pop.rows = {}
		local y = W.CARD_HEADER + 1
		local rows = type(opts.rows) == "function" and opts.rows() or opts.rows
		for _, c in ipairs(rows) do
			if ns.GetDefault(c.key) ~= nil then
				local w
				if c.kind == "slider" then
					w = W.Slider(pop, c.label, c.key, c.min, c.max, c.step, c.format, c.help)
				else
					w = W.Toggle(pop, c.label, c.key, c.help)
				end
				w.psNoReset = opts.noReset or nil
				W.CompactRow(w, { height = ROW_H })
				w:SetPoint("TOPLEFT", pop, "TOPLEFT", 0, -y)
				y = y + W.LayoutRow(w, WIDTH)
				pop.rows[c.key] = w
			end
		end
		-- All settings…: the settings window, where everything else is.
		local all = W.Button(pop, L["All settings\226\128\166"], function()
			P.Hide()
			opts.all()
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
		catcher:SetScript("OnClick", function() P.Hide() end)
		catcher:Hide()
		pop.Catcher = catcher
		pop:SetScript("OnHide", function() catcher:Hide() end)
		pop:Hide()
		ns.CloseOnEscape(opts.name)
		if ns.Gamepad and ns.Gamepad.Register then
			ns.Gamepad.Register(pop, { back = function() P.Hide() end })
		end
	end

	-- Open by `anchor`, its right edges lined up under it.
	function P.Show(anchor)
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

	function P.Hide()
		if pop then pop:Hide() end
	end

	function P.Shown() return pop ~= nil and pop:IsShown() end

	-- Open, or close it when it is open.
	function P.Toggle(anchor)
		if P.Shown() then return P.Hide() end
		return P.Show(anchor)
	end

	-- The popover's rows by setting key (tests).
	function P.Rows() return pop and pop.rows or {} end

	return P
end

-- The guide window's, opened from its menu (UI/GuideFrameMenu.lua).
local guide = QS.New({ name = "PolestarQuickSettings", title = L["Quick settings"], rows = function() return QS.ROWS end,
	all = function() ns.Fire("SHOW_OPTIONS") end })
QS.Show, QS.Hide, QS.Shown, QS.Toggle, QS.Rows = guide.Show, guide.Hide, guide.Shown, guide.Toggle, guide.Rows
