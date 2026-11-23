-- The guide window's tab styles (guideWindow.tabStyle) (UI/GuideFrame.lua).
-- "underline" is the strip above the navigator
-- (UI/GuideFrameTabs.lua); "switcher" (the navigator's title as a menu of
-- the open guides), "edge" (small icon tabs on the window's top edge) and
-- "strip" (an icon column down its left edge) are drawn by UI/TabStyles/
-- (their own load-on-demand folder before 0.4.3, #3507).

local _, ns = ...
local STYLES = { underline = true, switcher = true, edge = true, strip = true }

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
	-- The frames of this window's styles (UI/TabStyles/TabStyles.lua reads and adds to them). -> own, or nil
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
	-- tabs show (guideWindow.tabs, the Engine has tabs); nil otherwise.
	-- Compact mode keeps the player's style, with the strip down the left as
	-- the edge tabs above the window; underline gives way there to the slim
	-- strip (GF.StripShown), so it is nil.
	function GF.TabStyle()
		if not (strip and strip.psHasTabs) or not GF.On("tabs") then return nil end
		local s = ns.Get("guideWindow.tabStyle")
		if s == "strip" and GF.Compact() then s = "edge" end
		if not STYLES[s] or s == "underline" then return not GF.Compact() and "underline" or nil end
		return s
	end

	-- The style's frames, made on its first use, and how far they reach past
	-- the window's edges (GF.Layout): before the layout's hooks run, so a
	-- skin's guideLayout dresses them and sees the reach from the first time.
	-- The window has no × of its own (nor a Hide window row in "…": #3073).
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
