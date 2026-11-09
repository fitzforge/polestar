-- The settings window's Buttons page (look group, key "buttons"): the action
-- buttons (quest item, Hearthstone, target, rare, bag; QoL/Buttons.lua), the
-- floating button (UI/Launcher.lua) and the minimap button
-- (Maps/MinimapButton.lua). Every row has real effect on the live buttons:
-- each module repaints them on SETTING_CHANGED. On the secure action
-- buttons, size, spacing and layout are protected and wait out combat
-- (QoL.Secure); the rest is plain regions and changes at once.
--
-- Each tab pins a live preview over its rows, drawn by the modules' own face
-- code on plain frames (Buttons.NewFace, Launcher.Face,
-- Maps.MinimapButtonFace): never a secure template, never the live buttons,
-- no click, step or binding hook. Nothing is built until the page first
-- shows; it repaints on its settings only while shown.

local ADDON, ns = ...
local QoL = ns.QoL
local Buttons = QoL and QoL.Buttons
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
if not (Buttons and Buttons.NewFace and ns.RegisterOptions and Theme and W) then return end

local floor, min, max = math.floor, math.min, math.max

local PAGE = L["Buttons"]
local NEW = "0.3.7"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function px(v) return string.format(L["%d px"], floor(v + 0.5)) end

local function itemOff() return not QoL.On("itemButton") end
local function hearthOff() return not QoL.On("hearthButton") end
local function targetOff() return not QoL.On("targetButton") end
local function rareOff() return not QoL.On("rareButton") end
local function noBacking() return ns.Get("buttons.backing") == "none" end
local function borderOff() return not ns.Get("buttons.border") end
local function hotkeyOff() return not ns.Get("buttons.hotkey") end
local function glowOff() return not ns.Get("buttons.glow") end
local function launcherOff() return not ns.Get("ui.launcher") end
local function minimapOff() return not ns.Get("maps.minimapButton") end

-- The settings a preview repaints for: its own keys, and their sections
-- set at once (a profile, a reset).
local OWN = {
	[""] = true, buttons = true, qol = true, ui = true, maps = true,
	["qol.buttonScale"] = true, ["qol.buttonTextSide"] = true, ["qol.targetPlate"] = true, ["ui.reduceMotion"] = true,
}
local function owned(path)
	if type(path) ~= "string" then return true end
	return OWN[path] or path:sub(1, 8) == "buttons." or path:sub(1, 11) == "ui.launcher" or path:sub(1, 18) == "maps.minimapButton"
end

local STAGE_H, TOP, BOTTOM = 200, 30, 30

-- A preview frame: the deepest ground and the inner hairline (the window
-- draws "Preview" and "Live" over it), and repaint(f) on its settings and
-- theme changes, only while shown (else on the next show). f:Layout(width)
-- places it across the whole column.
local function stage(view, repaint)
	local f = CreateFrame("Frame", nil, view)
	f:SetHeight(STAGE_H)
	if f.SetClipsChildren then f:SetClipsChildren(true) end
	local ground = W.Fill(f, "scrim", "BACKGROUND", -8)
	W.Painter(f, function(self) Theme.Border(self, Theme.Wash("divider")) end)
	local dirty = true
	local function paint()
		dirty = false
		repaint(f)
	end
	f.Paint = paint
	ns.On("SETTING_CHANGED", function(path)
		if not owned(path) then return end
		if f:IsVisible() then paint() else dirty = true end
	end)
	W.Painter(ground, function()
		if f:IsVisible() then paint() else dirty = true end
	end)
	f:SetScript("OnShow", function() if dirty then paint() end end)
	function f:Layout(w)
		self:SetWidth(w)
		if dirty or w ~= self.psWidth then
			self.psWidth = w
			paint()
		end
		return STAGE_H
	end
	return f
end

local function caption(f, text)
	local c = W.Text(f, "small", "textMuted")
	c:SetJustifyH("CENTER")
	c:SetText(text)
	return c
end

---------------------------------------------------------------------------
-- Action buttons: the Hearthstone, quest item and target buttons as the set
-- stacks them, out of combat, and the quest item button in combat.
---------------------------------------------------------------------------

local DEMO_ITEM_ICON = "Interface\\Icons\\INV_Misc_Note_01"
local DEMO_HEARTH_ICON = "Interface\\Icons\\INV_Misc_Rune_01"
local SHOWN = { "hearth", "item", "target" }

-- The player's own binding for a button, else a stand-in so the key text
-- setting shows.
local function keyFor(name, demo)
	local key = GetBindingKey and GetBindingKey("CLICK " .. name .. ":LeftButton")
	return Buttons.KeyText(key) or demo
end

local function itemIcon(id, demo)
	local C = QoL.Client
	return id and C and C.ItemIcon and C.ItemIcon(id) or demo
end

local function buildActionPreview(view)
	local faces, set, combat
	local group, single
	local idle, fight
	local function repaint(f)
		if not faces then
			-- Built on the first paint, from the module's own face code.
			group = CreateFrame("Frame", nil, f)
			group:SetSize(1, 1)
			faces, set = {}, {}
			for i, kind in ipairs(SHOWN) do
				local b = Buttons.NewFace(group, kind)
				faces[kind], set[i] = b, b
				b.psStack = set
			end
			single = CreateFrame("Frame", nil, f)
			single:SetSize(1, 1)
			combat = Buttons.NewFace(single, "item")
			idle = caption(f, L["Out of combat"])
			fight = caption(f, L["In combat"])
			local hearth = faces.hearth
			hearth.Cooldown:SetCooldown(GetTime and GetTime() - 600 or 0, 3600)
			local target = faces.target
			target.aList = { L["Rot Hide Mongrel"], L["Scarlet Warrior"], L["Executor Zygand"] }
			target.aVerbs = { "kill", "collect", "turnin" }
			target.aIds, target.aMarks, target.aCycle = {}, { false, false, false }, 1
		end
		local live = Buttons.item
		for _, b in ipairs({ faces.item, combat }) do
			b.Icon:SetTexture(itemIcon(live and live.itemID, DEMO_ITEM_ICON))
			b.Count:SetText("3")
			b.Hotkey:SetText(keyFor("PolestarQuestItemButton", "E"))
			-- Shown ready, so the glow setting shows.
			b.psReady = true
		end
		faces.hearth.Icon:SetTexture(itemIcon(QoL.Client and QoL.Client.HEARTHSTONE, DEMO_HEARTH_ICON))
		faces.hearth.Hotkey:SetText(keyFor("PolestarHearthButton", "H"))
		faces.target.Hotkey:SetText(keyFor("PolestarTargetButton", "T"))
		for _, b in ipairs(set) do
			local size = Buttons.Size(b.psKind)
			b:SetSize(size, size)
			Buttons.Paint(b)
		end
		combat:SetSize(Buttons.Size("item"), Buttons.Size("item"))
		Buttons.Paint(combat)

		-- The set's box from its offsets, fitted to the left part at the
		-- button scale (smaller only when it would not fit).
		local width = f.psWidth or 0
		if width <= 0 then return end
		local at = Buttons.Offsets()
		local x0, x1, y0, y1 = math.huge, -math.huge, math.huge, -math.huge
		for _, b in ipairs(set) do
			local o, h = at[b.psKind], Buttons.Size(b.psKind) / 2
			b:ClearAllPoints()
			b:SetPoint("CENTER", group, "CENTER", o[1], o[2])
			x0, x1, y0, y1 = min(x0, o[1] - h), max(x1, o[1] + h), min(y0, o[2] - h), max(y1, o[2] + h)
		end
		local room = STAGE_H - TOP - BOTTOM
		local colW = width * 0.62
		local s = tonumber(ns.Get("qol.buttonScale")) or 1
		s = min(s, room / (y1 - y0), (colW * 0.6) / (x1 - x0))
		local cx, cy = width * 0.3, -(TOP + room / 2)
		group:SetScale(s)
		group:ClearAllPoints()
		group:SetPoint("CENTER", f, "TOPLEFT", cx / s - (x0 + x1) / 2, cy / s - (y0 + y1) / 2)
		group:SetAlpha(Buttons.Alpha(false))
		idle:ClearAllPoints()
		idle:SetPoint("BOTTOM", f, "BOTTOMLEFT", cx, 10)

		local fx = width * 0.82
		local cs = min(tonumber(ns.Get("qol.buttonScale")) or 1, room / Buttons.Size("item"))
		single:SetScale(cs)
		single:ClearAllPoints()
		single:SetPoint("CENTER", f, "TOPLEFT", fx / cs, cy / cs)
		combat:ClearAllPoints()
		combat:SetPoint("CENTER", single, "CENTER", 0, 0)
		single:SetAlpha(Buttons.Alpha(true))
		fight:ClearAllPoints()
		fight:SetPoint("BOTTOM", f, "BOTTOMLEFT", fx, 10)
	end
	local f = stage(view, repaint)
	f.Faces = function() return faces, combat end
	return f
end

---------------------------------------------------------------------------
-- The floating button and the minimap button, on an edge of a minimap.
---------------------------------------------------------------------------

local MINIMAP_D = 120

local function buildLauncherPreview(view)
	local launcher, minimap, disc, lCap, mCap, built
	local function repaint(f)
		local UI, Maps = ns.UI, ns.Maps
		if not built then
			built = true
			if UI and UI.Launcher and UI.Launcher.Face then
				launcher = UI.Launcher.Face(CreateFrame("Button", nil, f))
				lCap = caption(f, L["Floating button"])
			end
			if Maps and Maps.MinimapButtonFace then
				disc = W.Tex(f, "BORDER", "circle", "control")
				disc:SetSize(MINIMAP_D, MINIMAP_D)
				minimap = Maps.MinimapButtonFace(CreateFrame("Button", nil, f))
				mCap = caption(f, L["Minimap button"])
			end
		end
		-- Drawn even while turned off: how it would look.
		if launcher then UI.Launcher.Paint(launcher) end
		if minimap then Maps.PaintMinimapButton(minimap) end
		local width = f.psWidth or 0
		if width <= 0 then return end
		local cy = -(TOP + (STAGE_H - TOP - BOTTOM) / 2)
		if launcher then
			launcher:ClearAllPoints()
			launcher:SetPoint("CENTER", f, "TOPLEFT", width * 0.3, cy)
			lCap:ClearAllPoints()
			lCap:SetPoint("BOTTOM", f, "BOTTOMLEFT", width * 0.3, 10)
		end
		if minimap then
			local mx = width * 0.7
			disc:ClearAllPoints()
			disc:SetPoint("CENTER", f, "TOPLEFT", mx, cy)
			-- Where the live one sits by default: 225 degrees, on the edge.
			local a, r = math.rad(225), MINIMAP_D / 2 + 5
			minimap:ClearAllPoints()
			minimap:SetPoint("CENTER", disc, "CENTER", math.cos(a) * r, math.sin(a) * r)
			mCap:ClearAllPoints()
			mCap:SetPoint("BOTTOM", f, "BOTTOMLEFT", mx, 10)
		end
	end
	local f = stage(view, repaint)
	f.Faces = function() return launcher, minimap end
	return f
end

-- The previews, for the tests: (parent) -> f.
Buttons.ActionPreview = buildActionPreview
Buttons.LauncherPreview = buildLauncherPreview

---------------------------------------------------------------------------
-- The controls
---------------------------------------------------------------------------

local ACTION, OTHER = L["Action buttons"], L["Launcher & minimap"]

local function sizeRow(kind, label, help, off)
	return { kind = "slider", key = "buttons." .. kind .. "Size", label = label, min = 20, max = 80, step = 1, format = px, new = NEW,
		disabled = off, help = help,
		search = "size, bigger, smaller, huge, tiny, large, button size, scale, pixels, " .. kind }
end

local ICON_CHOICES = {
	{ value = "logo", label = L["Polestar logo"] },
	{ value = "accent", label = L["Emblem in the accent"] },
	{ value = "white", label = L["White emblem"] },
}

local SPECS = {
	{ page = PAGE, key = "buttons", icon = "icon-use", order = 25, group = "look", tab = ACTION, section = L["Which buttons"],
		preview = buildActionPreview,
		subtitle = L["The quest item, Hearthstone, target and rare buttons, the floating button and the minimap button: size, layout, backing, text, opacity and glow. Sizes and layout wait until a fight ends; the rest changes at once."],
		controls = {
		{ kind = "toggle", key = "qol.itemButton", label = L["Quest item button"],
			help = L["A button for the current step's quest item, with count, cooldown and range. Bind it under Key Bindings > AddOns."],
			search = "use item, quest item, keybind, hotkey, item bar" },
		{ kind = "toggle", key = "qol.hearthButton", label = L["Hearthstone button"],
			help = L["Shows your Hearthstone while the guide says to hearth. Bindable."], search = "hearth, hearthstone, keybind, hotkey" },
		{ kind = "toggle", key = "qol.targetButton", label = L["Target button"],
			help = L["Targets the current step's mobs by name, or the NPCs it sends you to when it has no mob; each click moves to the next name. Bindable."],
			search = "target macro, find mob, keybind, hotkey" },
		{ kind = "toggle", key = "qol.targetPlate", label = L["Show who it targets"], disabled = targetOff, child = true,
			help = L["The target button's icon shows what you do next: talk, accept, turn in, kill or loot, a skull for an elite, rare or boss, or their face once you have seen them. Their name sits beside it, green for a friendly NPC, red for a mob, gold for an elite or rare, with small icons for the names after it."],
			search = "target icon, target name, portrait, npc name, elite, boss, plate" },
		{ kind = "toggle", key = "qol.rareButton", label = L["Rare button"],
			help = L["Shows a button that targets a rare Polestar spotted nearby, until it dies or is out of sight. Bindable."], search = "rare elite, target rare, keybind" },
	} },
	{ page = PAGE, tab = ACTION, section = L["Size and layout"], controls = {
		{ kind = "slider", key = "qol.buttonScale", label = L["Button size"], min = 0.6, max = 1.6, step = 0.05, format = percent,
			help = L["Scale of the quest item, Hearthstone, target and rare buttons. Drag one to move them all."],
			search = "scale, bigger, smaller, button scale, huge, tiny, all buttons" },
		sizeRow("item", L["Quest item button size"], L["The quest item button's width and height, before the scale above."], itemOff),
		sizeRow("hearth", L["Hearthstone button size"], L["The Hearthstone button's width and height, before the scale above."], hearthOff),
		sizeRow("target", L["Target button size"], L["The target button's width and height, before the scale above."], targetOff),
		sizeRow("rare", L["Rare button size"], L["The rare button's width and height, before the scale above."], rareOff),
		sizeRow("bag", L["Bag button size"], L["The bag space button's width and height (the cheapest junk, when your bags are nearly full), before the scale above."],
			function() return not QoL.On("bagSpace") end),
		{ kind = "slider", key = "buttons.spacing", label = L["Spacing"], min = 0, max = 40, step = 1, format = px, new = NEW,
			help = L["The gap between two buttons of the set."],
			search = "gap, space between, padding, distance, tight, apart, spread" },
		{ kind = "dropdown", key = "buttons.layout", label = L["Growth direction"], new = NEW,
			help = L["How the set lines up from the quest item button. In a row, names read best above or below."],
			search = "layout, direction, grow, stack, column, row, horizontal, vertical, orientation",
			choices = { { value = "column", label = L["Column: Hearthstone above, target below"] },
				{ value = "row", label = L["Row: Hearthstone left, target right"] },
				{ value = "rowReverse", label = L["Row: Hearthstone right, target left"] } } },
		{ kind = "slider", key = "buttons.padding", label = L["Icon inset"], min = 0, max = 8, step = 1, format = px, new = NEW,
			help = L["How far the icon sits in from the button's edge."],
			search = "padding, inset, icon size, margin, border gap, zoom" },
		{ kind = "button", icon = "reset", button = L["Reset"], label = L["Reset button positions"], help = L["Put the buttons back in their default spot."],
			search = "move buttons, button position", onClick = function() Buttons.ResetPositions() end },
	} },
	{ page = PAGE, tab = ACTION, section = L["Backing and border"], controls = {
		{ kind = "dropdown", key = "buttons.backing", label = L["Backing"], new = NEW,
			help = L["The plate behind each icon: the panel colour, a darker one, or none (the icon alone)."],
			search = "background, plate, backdrop, panel, dark, transparent, none, fill",
			choices = { { value = "panel", label = L["Panel"] }, { value = "dark", label = L["Dark"] }, { value = "none", label = L["None"] } } },
		{ kind = "color", key = "buttons.backingColor", label = L["Backing colour"], alpha = true, new = NEW, child = true, disabled = noBacking,
			help = L["Your own colour and opacity for the plate. Right-click to go back to the backing's."],
			search = "background colour, plate colour, backdrop colour, tint, transparency",
			shown = function() return Theme.Color(ns.Get("buttons.backing") == "dark" and "scrim" or "panel") end,
			source = function() return L["Backing"] end },
		{ kind = "toggle", key = "buttons.border", label = L["Border"], new = NEW,
			help = L["The hairline round each button. Under the mouse it lights up either way."],
			search = "border, edge, outline, frame, hairline, line" },
		{ kind = "color", key = "buttons.borderColor", label = L["Border colour"], alpha = true, new = NEW, child = true, disabled = borderOff,
			help = L["Right-click to go back to the theme's hairline."],
			search = "border colour, edge colour, outline colour",
			shown = function() return Theme.Color("border") end,
			source = function() return L["Theme"] end },
		{ kind = "slider", key = "buttons.borderSize", label = L["Border thickness"], min = 1, max = 4, step = 1, format = px, new = NEW, child = true,
			help = L["How thick the border is, the hover's too."],
			search = "border width, thick border, thin border, edge size" },
		{ kind = "color", key = "buttons.hoverColor", label = L["Hover colour"], new = NEW,
			help = L["The border under the mouse. Right-click to go back to the accent."],
			search = "hover, mouseover, highlight colour, accent",
			shown = function() return Theme.Accent() end,
			source = function() return L["Accent"] end },
	} },
	{ page = PAGE, tab = ACTION, section = L["Text"], controls = {
		{ kind = "dropdown", key = "qol.buttonTextSide", label = L["Target name position"],
			help = L["Where the target's name shows around the target button: right, left, above or below."],
			search = "name side, label position, text side, left, right, above, below",
			choices = { { value = "right", label = L["Right"] }, { value = "left", label = L["Left"] }, { value = "above", label = L["Above"] }, { value = "below", label = L["Below"] } } },
		{ kind = "slider", key = "buttons.labelScale", label = L["Name size"], min = 0.6, max = 2, step = 0.05, format = percent, new = NEW,
			help = L["The size of the names beside the target and rare buttons, against the theme's."],
			search = "text size, font size, bigger names, smaller names, label size, huge, tiny" },
		{ kind = "dropdown", key = "buttons.labelOutline", label = L["Name outline"], new = NEW,
			help = L["Automatic outlines the target's name while it shows who it targets, over the game world; the theme's follows your text outline."],
			search = "outline, font outline, thick outline, shadow, readable, legible",
			choices = { { value = "auto", label = L["Automatic"] }, { value = "theme", label = L["The theme's"] },
				{ value = "outline", label = L["Outline"] }, { value = "thick", label = L["Thick outline"] } } },
		{ kind = "slider", key = "buttons.miniSize", label = L["Next names' icons"], min = 8, max = 32, step = 1, format = px, new = NEW, disabled = targetOff,
			help = L["The small icons for the names after the next one, under the target's name, and the action badge on a face."],
			search = "small icons, mini icons, next targets, badge size, queue" },
		{ kind = "toggle", key = "buttons.hotkey", label = L["Key binding text"], new = NEW,
			help = L["The key a button is bound to, in its top corner."],
			search = "keybind, hotkey, key text, binding label, shortcut" },
		{ kind = "slider", key = "buttons.hotkeyScale", label = L["Key text size"], min = 0.6, max = 2, step = 0.05, format = percent, new = NEW, child = true, disabled = hotkeyOff,
			help = L["The size of the key binding text, against the theme's."],
			search = "keybind size, hotkey size, bigger key, font size" },
		{ kind = "toggle", key = "buttons.count", label = L["Item count"], new = NEW,
			help = L["How many of the item you carry, in the bottom corner."],
			search = "count, stack, number, quantity, charges" },
		{ kind = "toggle", key = "buttons.cooldownText", label = L["Cooldown numbers"], new = NEW,
			help = L["The time left on the item's cooldown, over the sweep. Off hides the game's numbers and those of cooldown addons such as OmniCC."],
			search = "cooldown text, timer, countdown, omnicc, numbers, seconds" },
	} },
	{ page = PAGE, tab = ACTION, section = L["Opacity and glow"], controls = {
		{ kind = "slider", key = "buttons.idleAlpha", label = L["Opacity out of combat"], min = 0, max = 1, step = 0.05, format = percent, new = NEW,
			help = L["How solid the buttons are outside a fight. Under the mouse they are always solid; at 0% they still work."],
			search = "opacity, transparency, alpha, fade, idle, out of combat, see through, faint, hide" },
		{ kind = "slider", key = "buttons.alpha", label = L["Opacity in combat"], min = 0, max = 1, step = 0.05, format = percent, new = NEW,
			help = L["How solid the buttons are while you fight."],
			search = "opacity, transparency, alpha, fade, combat, fight, see through" },
		{ kind = "toggle", key = "buttons.glow", label = L["Glow when ready"], new = NEW,
			help = L["A glow round the quest item or Hearthstone button while it can be used now (in range, off cooldown), and round the rare button while a rare is up. It breathes unless Reduce motion is on."],
			search = "glow, flash, highlight, usable, ready, proc, shine, pulse, attention" },
		{ kind = "color", key = "buttons.glowColor", label = L["Glow colour"], alpha = true, new = NEW, child = true, disabled = glowOff,
			help = L["Right-click to go back to the accent."],
			search = "glow colour, flash colour, highlight colour",
			shown = function() return Theme.Accent() end,
			source = function() return L["Accent"] end },
	} },

	{ page = PAGE, tab = OTHER, section = L["Floating button"], preview = buildLauncherPreview, controls = {
		{ kind = "toggle", key = "ui.launcher", label = L["Floating button"],
			help = L["A small Polestar button you can put anywhere on the screen. Click to show or hide the guide, right-click for a menu, drag to move it. It hides with the window in combat and in dungeons when those are set to Hide."],
			search = "launcher, floating icon, floating button, show, hide, toggle, open polestar, quick" },
		{ kind = "slider", key = "ui.launcherSize", label = L["Size"], min = 16, max = 96, step = 1, format = px, new = NEW, child = true, disabled = launcherOff,
			help = L["The floating button's width and height."],
			search = "launcher size, bigger, smaller, huge, tiny, floating button size" },
		{ kind = "slider", key = "ui.launcherAlpha", label = L["Opacity"], min = 0.1, max = 1, step = 0.05, format = percent, new = NEW, child = true, disabled = launcherOff,
			help = L["How solid the floating button is."],
			search = "launcher opacity, transparency, alpha, fade, faint" },
		{ kind = "dropdown", key = "ui.launcherIcon", label = L["Icon"], new = NEW, child = true, disabled = launcherOff,
			help = L["Polestar's logo, or its emblem alone in your accent colour or in white."],
			search = "launcher icon, logo, emblem, colour, white, accent, monochrome", choices = ICON_CHOICES },
		{ kind = "toggle", key = "ui.launcherBack", label = L["Disc behind it"], new = NEW, child = true, disabled = launcherOff,
			help = L["The round plate behind the icon. Off, the icon stands alone."],
			search = "background, backing, disc, circle, plate, transparent" },
	} },
	{ page = PAGE, tab = OTHER, section = L["Minimap button"], controls = {
		{ kind = "toggle", key = "maps.minimapButton", label = L["Minimap button"],
			help = L["A Polestar button on the edge of the minimap. Click to show or hide the guide, right-click for settings, drag to move it."],
			search = "minimap icon, minimap button, hide button, launcher" },
		{ kind = "slider", key = "maps.minimapButtonSize", label = L["Size"], min = 20, max = 64, step = 1, format = px, new = NEW, child = true, disabled = minimapOff,
			help = L["The minimap button's width and height. A minimap addon that gathers buttons may size it its own way."],
			search = "minimap button size, bigger, smaller, icon size" },
		{ kind = "dropdown", key = "maps.minimapButtonIcon", label = L["Icon"], new = NEW, child = true, disabled = minimapOff,
			help = L["Polestar's logo, or its emblem alone in your accent colour or in white."],
			search = "minimap icon, logo, emblem, colour, white, accent, monochrome", choices = ICON_CHOICES },
	} },
}

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
