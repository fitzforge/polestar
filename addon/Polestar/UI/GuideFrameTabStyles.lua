-- The guide window's tab styles (guideWindow.tabStyle) (UI/GuideFrame.lua).
-- "underline" is the strip above the navigator
-- (UI/GuideFrameTabs.lua); "switcher" (the navigator's title as a menu of
-- the open guides), "edge" (small icon tabs on the window's top edge) and
-- "strip" (an icon column down its left edge) live in Polestar_TabStyles
-- (load on demand), loaded the first time one of them is drawn. Without it
-- the window keeps the underline style and says so once in the chat.

local ADDON, ns = ...
local L = ns.L
local STYLES = { underline = true, switcher = true, edge = true, strip = true }
local TAB_STYLES = "Polestar_TabStyles"

-- Polestar_TabStyles, loaded once when a window first needs it. -> loaded
local tried, loaded = false, false
local function loadStyles()
	if loaded or tried then return loaded end
	tried = true
	local A = C_AddOns
	local load = A and A.LoadAddOn or LoadAddOn
	local ok, done = false, false
	if load then ok, done = pcall(load, TAB_STYLES) end
	loaded = ok and done and true or false
	if not loaded then ns.Print(L["The other tab styles are missing or turned off (Polestar_TabStyles): the tabs show above the step bar."]) end
	return loaded
end

ns.UI.GuideFrame.Part(function(GF)
	local Theme = ns.Theme
	local F, strip, nav
	-- This window's style frames: a table once its parts exist, each made the
	-- first time it is drawn (a window on underline with tabs off makes none).
	local own

	-- A style's frame joins the window: among its parts for a skin's hooks
	-- (Skin API 2; Theme.GuideParts hands it out from now on, nil before),
	-- the chrome that fades with the bars, in the skin's colours.
	local PART_KEY = { switch = "tabSwitch", edge = "tabEdge", side = "tabSide" }
	local function register()
		if not GF.parts then return end
		local skinParts = GF.SkinParts and GF.SkinParts()
		for k, key in pairs(PART_KEY) do
			local f = own[k]
			if f and GF.parts[key] ~= f then
				GF.parts[key] = f
				if skinParts then skinParts[key] = f end
			end
		end
	end
	-- The frames of this window's styles (Polestar_TabStyles reads and adds to them). -> own, or nil
	function GF.TabStyleFrames() return own end
	function GF.AdoptTabFrame(k, f)
		own[k] = f
		local chrome = GF.chrome
		chrome[#chrome + 1] = f
		f:SetAlpha(nav.Menu:GetAlpha())
		Theme.Repaint(f)
		register()
		return f
	end

	GF.Bind(function(p)
		F, strip, nav = p.F, p.strip, p.nav
		if nav and F and not own and GF.chrome then
			own = {}
			-- A skin's close square fades with the bars too.
			local chrome = GF.chrome
			chrome[#chrome + 1] = nav.Close
		end
		if own then register() end
	end)

	-- The style the window draws its tabs in: guideWindow.tabStyle while the
	-- tabs show (guideWindow.tabs, the Engine has tabs); nil otherwise. A
	-- style of Polestar_TabStyles loads it; without it, underline. Compact
	-- mode keeps the player's style, with the strip down the left as the edge
	-- tabs above the window; underline gives way there to the slim strip
	-- (GF.StripShown), so it is nil.
	function GF.TabStyle()
		if not (strip and strip.psHasTabs) or not GF.On("tabs") then return nil end
		local s = ns.Get("guideWindow.tabStyle")
		if s == "strip" and GF.Compact() then s = "edge" end
		if s ~= "underline" and STYLES[s] and not GF.TabStyleBuild and not loadStyles() then s = nil end
		if not STYLES[s] or s == "underline" then return not GF.Compact() and "underline" or nil end
		return s
	end

	-- The style's frames, made on its first use, and how far they reach past
	-- the window's edges (GF.Layout): before the layout's hooks run, so a
	-- skin's guideLayout dresses them and sees the reach from the first time.
	-- The window has no × of its own: "…" has Hide window.
	function GF.PlaceTabStyle()
		if not own then return end
		local style = GF.TabStyle()
		if style and style ~= "underline" and GF.TabStyleBuild then GF.TabStyleBuild(style) end
		GF.PlaceReach(style)
	end

	-- How far the window's own parts stand past its top and bottom edges (the
	-- edge style's tabs: on the top edge, or the bottom one with the bars
	-- there), kept on the window frame (F.psTopReach, F.psBottomReach) for
	-- what sits on those edges: the heads-up card (UI/ClassToast.lua), a
	-- layout's cards above the window (Theme.GuideReach). Set with the style,
	-- before the layout's hooks run. -> top, bottom
	function GF.TopReach()
		return F and F.psTopReach or 0, F and F.psBottomReach or 0
	end
	function GF.PlaceReach(style)
		if not F then return end
		local _, out = 0, 0
		if style and GF.TabStyleReach then _, out = GF.TabStyleReach(style) end
		local bottom = GF.BarsBottom()
		local top, under = bottom and 0 or out, bottom and out or 0
		if F.psTopReach == top and F.psBottomReach == under then return end
		F.psTopReach, F.psBottomReach = top, under
		-- The heads-up card on the live window steps clear of the tabs.
		local CT = GF.live and ns.UI.ClassToast
		if CT and CT.Place then CT.Place(false) end
	end

	-- Draw the tabs in the style in use (GF.Layout, after the layout's hooks
	-- placed the navigator; TABS_CHANGED). No style: none of them show.
	function GF.RenderTabStyle()
		if GF.StripShown() then GF.RenderTabs() end
		if own and GF.TabStyleDraw then GF.TabStyleDraw(GF.TabStyle()) end
	end

	-- How far the styles drawn outside the window reach past its left and top
	-- (bottom, with the bars there) edges: a host showing a copy (the settings
	-- preview) leaves that room. -> left, top
	function GF.TabsOutside()
		local style = GF.TabStyle()
		if GF.TabStyleReach then return GF.TabStyleReach(style) end
		return 0, 0
	end
end)
