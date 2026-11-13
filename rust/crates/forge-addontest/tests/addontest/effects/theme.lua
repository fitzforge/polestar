-- env: ui
-- The Theme page (Polestar_Options/UI/Looks/Theme.lua; Theme/Theme.lua, SkinApi.lua, Widgets.lua): every setting on
-- live Polestar text and windows: strings in each role and subject colour, a panel, the starlit band, the guide
-- window with a guide open, an animation, the game menu's Polestar button.
local T, W, GF
local body, heading, small, muted, dim, panel, sky
local subjects = {}
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function textRgb(fs) local r, g, b = fs:GetTextColor(); return { r, g, b } end
local function font(fs) local p, s, f = fs:GetFont(); return { p, s, f or "" } end
local function shadow(fs) return select(4, fs:GetShadowColor()) end
local function ground(f) return f.psSkin and f.psSkin.bg and rgba(f.psSkin.bg) or false end
local function frame()
	local e = GF.psBorder and GF.psBorder[1]
	return { border = e and e:IsShown() or false, colour = e and rgba(e) or false, px = e and e:GetHeight() or false,
		band = select(4, Polestar.UI.GuideFrame.parts.band:GetVertexColor()), shadow = GF.psShadow ~= nil and GF.psShadow:IsShown() and select(4, GF.psShadow:GetVertexColor()) or false,
		ground = ground(GF) }
end
local function subject(name) return function() return textRgb(subjects[name]) end end
return {
	setup = function()
		T, W = Polestar.Theme, Polestar.Widgets
		-- The UI stub's player has no class: a Warrior's, for the class accent.
		if not UnitClass then UnitClass = function(unit) if unit == "player" then return "Warrior", "WARRIOR", 1 end end end
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		GF = PolestarGuideFrame
		body, heading = W.Text(UIParent, "body", "text"), W.Text(UIParent, "heading", "text")
		small, muted, dim = W.Text(UIParent, "small", "textDim"), W.Text(UIParent, "small", "textMuted"), W.Text(UIParent, "body", "textDim")
		body:SetText("Hello"); heading:SetText("Title")
		for _, name in ipairs(T.SUBJECTS) do subjects[name] = W.Text(UIParent, "body", name) end
		panel = T.Skin(CreateFrame("Frame", nil, UIParent), "panel")
		sky = T.Band(UIParent, "BACKGROUND")
		-- A skin with variants and a layout of its own, for the cards and buttons that show only then.
		assert(T.RegisterSkin("duo", { name = "Duo", addon = "Test_Duo", preset = { ["ui.fontOutline"] = "thick" },
			variants = { { id = "flat", name = "Flat", tokens = { accent = "#ff00ff" } }, { id = "deep", name = "Deep", tokens = { accent = "#00ffff" } } } }))
	end,
	probes = {
		["ui.skin"] = { value = "halo", probe = function() return { T.SkinId(), ground(GF), font(body) } end },
		["Theme:Variant"] = { with = { ["ui.skin"] = "duo" }, value = "deep", probe = function() return { T.Accent() } end },
		["Theme:Apply Polestar's layout"] = { press = true, with = { ["ui.skin"] = "duo" }, probe = function() return font(body)[3] end,
			cleanup = function() Polestar.Set("ui.fontOutline", nil) end },
		["Theme:Undo layout"] = { press = true, with = { ["ui.skin"] = "duo" }, prepare = function() T.ApplySkinPreset("duo") end,
			probe = function() return font(body)[3] end, cleanup = function() Polestar.Set("ui.fontOutline", nil) end },
		["ui.accent"] = function() return { T.Accent() } end,
		["ui.classAccent"] = function() return { T.Accent() } end,
		["ui.scheme"] = { value = "graphite", probe = function() return ground(GF) end },
		["ui.bgOpacity"] = function() return ground(GF) end,
		["ui.bgColor"] = function() return ground(GF) end,
		["ui.brightness"] = function() return ground(GF) end,
		["ui.panelColor"] = function() return ground(panel) end,
		["ui.sidebarColor"] = function() return { T.Color("sidebar") } end,
		["ui.font"] = { value = "inter", probe = function() return font(body) end },
		["ui.textSize"] = function() return font(body) end,
		["ui.headingFont"] = { value = "inter", probe = function() return font(heading) end },
		["ui.headingSize"] = function() return font(heading) end,
		["ui.fontOutline"] = { value = "thick", probe = function() return font(body) end },
		["ui.textShadow"] = { value = "none", probe = function() return shadow(body) end },
		["ui.smallSize"] = function() return font(small) end,
		["ui.textColor"] = function() return textRgb(body) end,
		["ui.textDimColor"] = function() return textRgb(dim) end,
		["ui.textMutedColor"] = function() return textRgb(muted) end,
		["ui.colors.npc"] = subject("npc"), ["ui.colors.quest"] = subject("quest"), ["ui.colors.item"] = subject("item"),
		["ui.colors.place"] = subject("place"), ["ui.colors.object"] = subject("object"), ["ui.colors.area"] = subject("area"),
		["ui.colors.dungeon"] = subject("dungeon"), ["ui.colors.rare"] = subject("rare"), ["ui.colors.skill"] = subject("skill"),
		["ui.colors.spell"] = subject("spell"), ["ui.colors.faction"] = subject("faction"), ["ui.colors.achievement"] = subject("achievement"),
		["ui.colors.level"] = subject("level"), ["ui.colors.success"] = subject("success"), ["ui.colors.warning"] = subject("warning"),
		["ui.colors.danger"] = subject("danger"),
		["ui.borderSize"] = function() return frame() end,
		["ui.border"] = function() return frame() end,
		["ui.borderColor"] = function() return frame() end,
		["ui.borderAccent"] = function() return frame() end,
		["ui.shadowStrength"] = function() return { GF.psShadow and GF.psShadow:GetAlpha() or false, select(4, T.Color("shadow")) } end,
		["ui.shadow"] = function() return frame() end,
		["ui.starAlpha"] = function() return select(4, sky.psStars:GetVertexColor()) end,
		["ui.band"] = function() return frame() end,
		["ui.haze"] = function() return { T.Color("haze") } end,
		["ui.hairlineOpacity"] = function() return frame() end,
		["ui.rim"] = function() return T.ShowsRim() end,
		-- The game menu (Esc) open: its Polestar button.
		["ui.gameMenuButton"] = function()
			GameMenuFrame:Show(); stub.advance(0.1)
			local shown = _G.PolestarGameMenuButton ~= nil and PolestarGameMenuButton:IsVisible()
			GameMenuFrame:Hide()
			return shown
		end,
		["ui.reduceMotion"] = function() return Polestar.Anim.Reduced() end,
		["ui.animSpeed"] = function()
			local o = CreateFrame("Frame", nil, UIParent)
			Polestar.Anim.To(o, "alpha", 0, 1, 0.2)
			return o.psTweens.alpha.dur
		end,
	},
}
