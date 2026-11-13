-- The settings window's Buttons page (look group, key "buttons"): the action
-- buttons (quest item, Hearthstone, target, rare, bag; QoL/Buttons.lua), the
-- floating button (UI/Launcher.lua) and the minimap button
-- (Maps/MinimapButton.lua). Every row has real effect on the live buttons:
-- each module repaints them on SETTING_CHANGED. On the secure action
-- buttons, size, spacing and layout are protected and wait out combat
-- (QoL.Secure); the rest is plain regions and changes at once.
--
-- Each tab pins a band over its rows (UI.Preview.Band): the element it sets,
-- alone at its real size, drawn by the modules' own face code on plain frames
-- (Buttons.NewFace, Launcher.Face, Maps.MinimapButtonFace): never a secure
-- template, never the live buttons, no click, step or binding hook. Nothing
-- is built until the page first shows; it repaints on its settings only
-- while shown.

local ns = Polestar
local QoL = ns.QoL
local Buttons = QoL and QoL.Buttons
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
if not (Buttons and Buttons.NewFace and ns.RegisterOptions and Theme and W) then return end

local floor, min, max = math.floor, math.min, math.max

local PAGE = L["Buttons"]
local NEW = "0.3.8"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function px(v) return string.format(L["%d px"], floor(v + 0.5)) end

---------------------------------------------------------------------------
-- The bands (UI.Preview.Band): each element alone at its real size, on the
-- window's ground, a label under each when there are several.
---------------------------------------------------------------------------

local DEMO_ITEM_ICON = "Interface\\Icons\\INV_Misc_Note_01"
local DEMO_HEARTH_ICON = "Interface\\Icons\\INV_Misc_Rune_01"
local DEMO_BAG_ICON = "Interface\\Icons\\INV_Misc_Bag_08"
local SHOWN = { "bag", "hearth", "item", "target", "rare" }
local SWITCH = { item = "itemButton", hearth = "hearthButton", target = "targetButton", rare = "rareButton", bag = "bagSpace" }
-- The room between two elements side by side; the travel button (Nav/Prompts.lua's SIZE);
-- a name's line over or under a button (the preset cards).
local APART, TRAVEL, NAME_H = 56, 36, 18

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

-- A part of a band the player can click to reach its row (the window's
-- preview hotspots); f.psHotspots[key] keeps each (tests).
local function hotspot(f, region, key)
	f.psHotspots = f.psHotspots or {}
	f.psHotspots[key] = f:Hot(region, key)
end

-- The action button set on band f: the faces (Buttons.NewFace) in a group,
-- out of combat or in it (`combat`: its opacity), and a box over the
-- buttons alone for what lights the set as a whole.
local function newSet(f, combat)
	local set = { faces = {}, list = {}, combat = combat }
	set.group = CreateFrame("Frame", nil, f)
	set.group:SetSize(1, 1)
	for i, kind in ipairs(SHOWN) do
		local b = Buttons.NewFace(set.group, kind)
		set.faces[kind], set.list[i] = b, b
		b.psStack = set.list
	end
	set.box = CreateFrame("Frame", nil, f)
	local faces = set.faces
	faces.hearth.Cooldown:SetCooldown(GetTime and GetTime() - 600 or 0, 3600)
	faces.bag.Icon:SetTexture(DEMO_BAG_ICON)
	faces.rare.Label:SetText(L["Thuros Lightfingers"])
	local target = faces.target
	target.aList = { L["Rot Hide Mongrel"], L["Scarlet Warrior"], L["Executor Zygand"] }
	target.aVerbs = { "kill", "collect", "turnin" }
	target.aIds, target.aMarks, target.aCycle = {}, { false, false, false }, 1
	return set
end

-- The set with the current values, as the player laid it out (buttons.layout,
-- the names' side, the sizes and the scale; a button turned off is not
-- drawn), at its opacity. -> its natural size (band units, k = 1) and what
-- places it at (left, top, k), centred on its buttons with the names hanging
-- to their side; nil with no button on.
local function setContent(self, set)
	local faces, snap = set.faces, ns.UI.Preview.Snap
	local item, live, target = faces.item, Buttons.item, faces.target
	item.Icon:SetTexture(itemIcon(live and live.itemID, DEMO_ITEM_ICON))
	item.Count:SetText("3")
	item.Hotkey:SetText(keyFor("PolestarQuestItemButton", "E"))
	-- Shown ready, so the glow setting shows.
	item.psReady = true
	faces.hearth.Icon:SetTexture(itemIcon(QoL.Client and QoL.Client.HEARTHSTONE, DEMO_HEARTH_ICON))
	faces.hearth.Hotkey:SetText(keyFor("PolestarHearthButton", "H"))
	target.Hotkey:SetText(keyFor("PolestarTargetButton", "T"))
	for _, b in ipairs(set.list) do
		local size = Buttons.Size(b.psKind)
		b:SetSize(size, size)
		Buttons.Paint(b)
		-- A button turned off is not on screen: not in the band either.
		b:SetShown(QoL.On(SWITCH[b.psKind]) and true or false)
	end
	set.group:SetAlpha(Buttons.Alpha(set.combat))
	local at = Buttons.Offsets()
	local x0, x1, y0, y1 = math.huge, -math.huge, math.huge, -math.huge
	local bx0, bx1, by0, by1 = math.huge, -math.huge, math.huge, -math.huge
	local function grow(l, r, b, t) x0, x1, y0, y1 = min(x0, l), max(x1, r), min(y0, b), max(y1, t) end
	local side = ns.Get("qol.buttonTextSide") or "right"
	for _, b in ipairs(set.list) do
		local o, h = at[b.psKind], Buttons.Size(b.psKind) / 2
		b:ClearAllPoints()
		b:SetPoint("CENTER", set.group, "CENTER", o[1], o[2])
		if b:IsShown() then
			grow(o[1] - h, o[1] + h, o[2] - h, o[2] + h)
			bx0, bx1, by0, by1 = min(bx0, o[1] - h), max(bx1, o[1] + h), min(by0, o[2] - h), max(by1, o[2] + h)
			-- The names beside the target and rare buttons, as drawn.
			local lab = rawget(b, "Label")
			if lab and lab:IsShown() and (lab:GetText() or "") ~= "" then
				local lw, lh = lab:GetStringWidth() or 0, lab:GetStringHeight() or 12
				if side == "left" then grow(o[1] - h - 6 - lw, o[1], o[2] - lh / 2, o[2] + lh / 2)
				elseif side == "above" then grow(o[1] - lw / 2, o[1] + lw / 2, o[2], o[2] + h + 4 + lh)
				elseif side == "below" then grow(o[1] - lw / 2, o[1] + lw / 2, o[2] - h - 4 - lh, o[2])
				else grow(o[1], o[1] + h + 6 + lw, o[2] - lh / 2, o[2] + lh / 2) end
			end
		end
	end
	set.box:SetShown(bx0 <= bx1)
	if bx0 > bx1 then return nil end
	local g0 = (tonumber(ns.Get("qol.buttonScale")) or 1) * self:TrueScale()
	-- Centred on the buttons, the names hanging to their side: a box as wide
	-- either side of the buttons' middle as the farther edge.
	local bcx = (bx0 + bx1) / 2
	local half = max(bcx - x0, x1 - bcx)
	return 2 * half * g0, (y1 - y0) * g0, function(left, top, k)
		local g = g0 * k
		set.group:SetScale(g)
		set.group:ClearAllPoints()
		local cx, cy = left + (half - bcx) * g, top + y1 * g
		set.group:SetPoint("CENTER", self, "TOPLEFT", snap(self, cx) / g, -snap(self, cy) / g)
		set.box:ClearAllPoints()
		set.box:SetPoint("TOPLEFT", self, "TOPLEFT", cx + bx0 * g, -(cy - by1 * g))
		set.box:SetSize((bx1 - bx0) * g, (by1 - by0) * g)
	end
end

-- One frame alone (the floating button, the minimap button, the travel
-- button) at its real size, painted first. -> its size and place
local function oneContent(self, b, paint)
	if paint then paint(b) end
	local t, snap = self:TrueScale(), ns.UI.Preview.Snap
	local bw, bh = b:GetWidth() * t, b:GetHeight() * t
	return bw, bh, function(left, top, k)
		local g = t * k
		b:SetScale(g)
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", self, "TOPLEFT", snap(b, left / g), snap(b, -top / g))
	end
end

-- Elements side by side, APART between them, their feet on one line, a
-- label under each. items: { { w, h, place, label }, ... } -> the band's Content values
local function lineUp(items)
	local total, tall, labels = 0, 0, {}
	for i, it in ipairs(items) do
		if it.label then labels[#labels + 1] = { it.label, total + it.w / 2 } end
		total = total + it.w + (i < #items and APART or 0)
		tall = max(tall, it.h)
	end
	return total, tall, function(left, top, k)
		local x = left
		for _, it in ipairs(items) do
			it.place(x, top + (tall - it.h) * k, k)
			x = x + (it.w + APART) * k
		end
	end, #labels > 0 and labels or nil
end

-- The travel button (Nav/Prompts.lua's PolestarTravelButton, the
-- Hearthstone's other button), alone: a plain frame in its look (the panel,
-- the icon, the hairline; never the secure button), holding your
-- Hearthstone, faint while it is turned off. nil without the prompts.
local function newTravel(f)
	if not (ns.Nav and ns.Nav.prompts) then return nil end
	local b = CreateFrame("Frame", nil, f)
	b:SetSize(TRAVEL, TRAVEL)
	W.Fill(b, "panel", "BACKGROUND")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
	b.Icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
	b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	hotspot(f, b, "nav.castPrompt")
	f:Light("nav.castPrompt", b)
	return b
end

local function paintTravel(b)
	b.Icon:SetTexture(itemIcon(QoL.Client and QoL.Client.HEARTHSTONE, DEMO_HEARTH_ICON))
	local r, g, bl, a = Theme.Color("border")
	Theme.Border(b, r, g, bl, (a or 0.08) * 2.5)
	b:SetAlpha(ns.Get("nav.castPrompt") and 1 or 0.3)
end

-- Action buttons: the set out of combat and in it (the tab sets the combat
-- opacity), side by side, labelled; its dropdown picks the travel button
-- instead, alone, and hovering its row picks it (f:Focus). f.Faces, f.Travel,
-- f.Pick: its parts and its pick, for the tests.
local function buildActionBand(view)
	local pick = "action"
	local picker = ns.Nav and ns.Nav.prompts and { choices = { { value = "action", label = L["Action buttons"] }, { value = "travel", label = L["Travel button"] } },
		get = function() return pick end, set = function(v) pick = v end } or nil
	local f = ns.UI.Preview.Band(view, { watch = { "buttons.", "qol.", "nav.castPrompt" }, picker = picker })
	local travel = newTravel(f)
	local idle, fight = newSet(f, false), newSet(f, true)
	idle.label, fight.label = f:Label(L["Out of combat"]), f:Label(L["In combat"])
	local fo, ff = idle.faces, fight.faces
	hotspot(f, fo.hearth, "buttons.hearthSize")
	hotspot(f, fo.item, "buttons.itemSize")
	hotspot(f, fo.target, "buttons.targetSize")
	hotspot(f, fo.target.Label, "qol.buttonTextSide")
	hotspot(f, ff.item, "buttons.alpha")
	-- The pointer on a setting's row lights the parts it changes, in both sets.
	local function both(...)
		local out = {}
		for i = 1, select("#", ...) do
			local kind = select(i, ...)
			out[#out + 1], out[#out + 2] = fo[kind], ff[kind]
		end
		return out
	end
	local names = { fo.target.Label, fo.rare.Label, ff.target.Label, ff.rare.Label }
	local keys = { fo.hearth.Hotkey, fo.item.Hotkey, fo.target.Hotkey, ff.hearth.Hotkey, ff.item.Hotkey, ff.target.Hotkey }
	local all = both("bag", "hearth", "item", "target", "rare")
	local boxes = { idle.box, fight.box }
	for key, parts in pairs({
		["qol.buttonScale"] = boxes, ["buttons.layout"] = boxes, ["buttons.spacing"] = boxes,
		["buttons.idleAlpha"] = { idle.box }, ["buttons.alpha"] = { fight.box },
		["buttons.itemSize"] = both("item"), ["buttons.hearthSize"] = both("hearth"), ["buttons.targetSize"] = both("target"),
		["buttons.rareSize"] = both("rare"), ["buttons.bagSize"] = both("bag"),
		["qol.itemButton"] = both("item"), ["qol.hearthButton"] = both("hearth"), ["qol.targetButton"] = both("target"),
		["qol.rareButton"] = both("rare"),
		["buttons.padding"] = all, ["buttons.backing"] = all, ["buttons.backingColor"] = all, ["buttons.border"] = all,
		["buttons.borderColor"] = all, ["buttons.borderSize"] = all, ["buttons.hoverColor"] = all,
		["buttons.glow"] = both("item", "hearth", "rare"), ["buttons.glowColor"] = both("item", "hearth", "rare"),
		["qol.buttonTextSide"] = names, ["buttons.labelScale"] = names, ["buttons.labelOutline"] = names,
		["qol.targetPlate"] = { fo.target, fo.target.Label, ff.target, ff.target.Label }, ["buttons.miniSize"] = both("target"),
		["buttons.hotkey"] = keys, ["buttons.hotkeyScale"] = keys,
		["buttons.count"] = { fo.item.Count, ff.item.Count }, ["buttons.cooldownText"] = both("hearth"),
	}) do
		f:Light(key, unpack(parts))
	end
	f.Faces = function() return fo, ff.item end
	f.Travel = function() return travel end
	f.Pick = function(v)
		if v ~= nil then pick = v end
		return pick
	end
	function f:Focus(key)
		local want = key == "nav.castPrompt" and "travel" or key and "action" or pick
		if travel and want ~= pick then
			pick = want
			ns.UI.Preview.Again(self)
		end
	end
	function f:Content()
		local onTravel = travel and pick == "travel"
		for _, set in ipairs({ idle, fight }) do
			set.group:SetShown(not onTravel)
			set.box:SetShown(not onTravel)
			set.label:SetShown(not onTravel)
		end
		if travel then travel:SetShown(onTravel and true or false) end
		if onTravel then return oneContent(self, travel, paintTravel) end
		local items = {}
		for _, set in ipairs({ idle, fight }) do
			local w, h, place = setContent(self, set)
			if w then items[#items + 1] = { w = w, h = h, place = place, label = set.label } end
		end
		if #items == 0 then return nil end
		return lineUp(items)
	end
	return f
end

-- Launcher & minimap: the floating button and the minimap button side by
-- side, each alone, labelled; one turned off drawn faint, as it would look.
-- f.Faces: its parts, for the tests.
local function buildLauncherBand(view)
	local UI, Maps = ns.UI, ns.Maps
	local f = ns.UI.Preview.Band(view, { watch = { "ui.launcher", "maps.minimapButton" } })
	local parts = {}
	if UI and UI.Launcher and UI.Launcher.Face then
		local b = UI.Launcher.Face(CreateFrame("Button", nil, f))
		parts[#parts + 1] = { b = b, paint = UI.Launcher.Paint, on = function() return ns.Get("ui.launcher") end, label = f:Label(L["Floating button"]) }
		hotspot(f, b, "ui.launcherSize")
		for _, key in ipairs({ "ui.launcherSize", "ui.launcher", "ui.launcherAlpha", "ui.launcherIcon", "ui.launcherBack" }) do f:Light(key, b) end
		f.psLauncher = b
	end
	if Maps and Maps.MinimapButtonFace then
		local b = Maps.MinimapButtonFace(CreateFrame("Button", nil, f))
		parts[#parts + 1] = { b = b, paint = Maps.PaintMinimapButton, on = function() return ns.Get("maps.minimapButton") ~= false end, label = f:Label(L["Minimap button"]) }
		hotspot(f, b, "maps.minimapButtonSize")
		for _, key in ipairs({ "maps.minimapButtonSize", "maps.minimapButton", "maps.minimapButtonIcon" }) do f:Light(key, b) end
		f.psMinimap = b
	end
	f.Faces = function() return rawget(f, "psLauncher"), rawget(f, "psMinimap") end
	function f:Content()
		if #parts == 0 then return nil end
		local items = {}
		for i, p in ipairs(parts) do
			local w, h, place = oneContent(self, p.b, p.paint)
			p.b:SetAlpha(p.on() and 1 or 0.35)
			items[i] = { w = w, h = h, place = place, label = p.label }
		end
		return lineUp(items)
	end
	return f
end

-- Essentials, a band: its dropdown picks the action button set, the floating
-- button or the minimap button, shown alone at its real size; the set out of
-- combat, as the player laid it out. f.Faces, f.Pick: its parts and its pick,
-- for the tests.
local function buildEssentialsBand(view)
	local UI, Maps = ns.UI, ns.Maps
	local pick = "action"
	local choices = { { value = "action", label = L["Action buttons"] } }
	local launcher = UI and UI.Launcher and UI.Launcher.Face
	local minimap = Maps and Maps.MinimapButtonFace
	if launcher then choices[#choices + 1] = { value = "launcher", label = L["Floating button"] } end
	if minimap then choices[#choices + 1] = { value = "minimap", label = L["Minimap button"] } end
	local f = ns.UI.Preview.Band(view, { watch = { "buttons.", "qol.", "ui.launcher", "maps.minimapButton" },
		picker = { choices = choices, get = function() return pick end, set = function(v) pick = v end } })
	local set = newSet(f, false)
	local faces = set.faces
	local target = faces.target
	local hots = { set = {}, launcher = {}, minimap = {} }
	hots.set = { f:Hot(faces.hearth, "buttons.hearthSize"), f:Hot(faces.item, "buttons.itemSize"), f:Hot(target, "buttons.targetSize"),
		f:Hot(faces.rare, "buttons.rareSize") }
	local names = { target.Label, faces.rare.Label }
	for key, parts in pairs({
		["qol.buttonScale"] = { set.box }, ["buttons.layout"] = { set.box }, ["buttons.idleAlpha"] = { set.box },
		["buttons.itemSize"] = { faces.item }, ["buttons.hearthSize"] = { faces.hearth }, ["buttons.targetSize"] = { target },
		["buttons.rareSize"] = { faces.rare }, ["buttons.bagSize"] = { faces.bag },
		["qol.itemButton"] = { faces.item }, ["qol.hearthButton"] = { faces.hearth }, ["qol.targetButton"] = { target },
		["qol.rareButton"] = { faces.rare }, ["qol.buttonTextSide"] = names,
	}) do
		f:Light(key, unpack(parts))
	end
	local lb, mb
	if launcher then
		lb = launcher(CreateFrame("Button", nil, f))
		hots.launcher = { f:Hot(lb, "ui.launcherSize") }
		for _, key in ipairs({ "ui.launcherSize", "ui.launcher", "ui.launcherAlpha", "ui.launcherIcon", "ui.launcherBack" }) do f:Light(key, lb) end
	end
	if minimap then
		mb = minimap(CreateFrame("Button", nil, f))
		hots.minimap = { f:Hot(mb, "maps.minimapButtonSize") }
		for _, key in ipairs({ "maps.minimapButtonSize", "maps.minimapButton", "maps.minimapButtonIcon" }) do f:Light(key, mb) end
	end
	f.Faces = function() return faces, lb, mb end
	f.Pick = function(v)
		if v ~= nil then pick = v end
		return pick
	end
	function f:Content()
		local onSet = pick == "action"
		set.group:SetShown(onSet)
		set.box:SetShown(onSet)
		if lb then lb:SetShown(pick == "launcher") end
		if mb then mb:SetShown(pick == "minimap") end
		for which, list in pairs(hots) do
			local on = (which == "set" and onSet) or which == pick
			for _, h in pairs(list) do h:SetShown(on) end
		end
		if pick == "launcher" and lb then return oneContent(self, lb, UI.Launcher.Paint) end
		if pick == "minimap" and mb then return oneContent(self, mb, Maps.PaintMinimapButton) end
		return setContent(self, set)
	end
	return f
end

-- The previews, for the tests: (parent) -> f.
Buttons.ActionPreview = buildActionBand
Buttons.LauncherPreview = buildLauncherBand
Buttons.EssentialsPreview = buildEssentialsBand

---------------------------------------------------------------------------
-- The controls (CONTRACT-V2 layout): one section per element in the order
-- the eye meets it (the set, each button, its plate, its names, its corner
-- text, then opacity and glow); a feature's on/off in its section header
-- (`toggle`) or inline beside its size (`extras`); secondary knobs behind the
-- row's cog (`more`). Help shows as the row's tooltip.
---------------------------------------------------------------------------

local ACTION, OTHER = L["Action buttons"], L["Launcher & minimap"]

-- A button's size, with its on/off inline beside it (toggleKey), if any;
-- toggleLabel: the switch's own name, where the button's alone is not enough.
local function sizeRow(kind, label, help, toggleKey, toggleHelp, off, toggleLabel)
	local row = { kind = "slider", key = "buttons." .. kind .. "Size", label = label, min = 20, max = 80, step = 1, format = px, new = NEW,
		disabled = off, help = help,
		search = "size, bigger, smaller, huge, tiny, large, button size, scale, pixels, " .. kind }
	if toggleKey then
		row.extras = { { kind = "toggle", key = toggleKey, label = toggleLabel or label, help = toggleHelp,
			search = "show, hide, on, off, button, keybind, hotkey, " .. kind } }
	end
	return row
end

-- The Hearthstone's two buttons side by side (QoL/Options.lua's pair): its
-- size and switch in the action set, then the travel button under the arrow
-- (its switch; the Nav module's, when it is loaded).
local HO = QoL.HearthOptions or {}
local hearthRow = sizeRow("hearth", L["Hearthstone"], L["The Hearthstone button's size, before the scale. The switch beside it shows or hides the button."],
	"qol.hearthButton", HO.hearthHelp, nil, L["Hearthstone in the button set"])
hearthRow.extras[1].search = hearthRow.extras[1].search .. ", hearthstone, hs, hs button, action button"
local travelRow = HO.travel and HO.travel()

-- The rows given, without the ones not there (nil).
local function present(...)
	local out = {}
	for i = 1, select("#", ...) do
		local c = select(i, ...)
		if c then out[#out + 1] = c end
	end
	return out
end

local ICON_CHOICES = {
	{ value = "logo", label = L["Polestar logo"] },
	{ value = "accent", label = L["Emblem in the accent"] },
	{ value = "white", label = L["White emblem"] },
}

local SPECS = {
	-- The set as a whole: its scale, the way it lines up, the gaps, how solid it is.
	{ page = PAGE, key = "buttons", icon = "icon-use", order = 25, group = "look", tab = ACTION, section = L["Button set"],
		preview = buildActionBand,
		subtitle = L["The quest item, Hearthstone, target and rare buttons, the travel button under the arrow, the floating button and the minimap button."],
		controls = {
		{ kind = "slider", key = "qol.buttonScale", label = L["Scale"], min = 0.6, max = 1.6, step = 0.05, format = percent,
			help = L["Scale of the quest item, Hearthstone, target and rare buttons. Drag one to move them all. Sizes and layout change once a fight ends."],
			search = "scale, bigger, smaller, button scale, button size, huge, tiny, all buttons" },
		{ kind = "dropdown", key = "buttons.layout", label = L["Direction"], new = NEW,
			help = L["How the set lines up from the quest item button: a column (Hearthstone above, target below) or a row either way. In a row, names read best above or below."],
			search = "layout, direction, growth, grow, stack, column, row, horizontal, vertical, orientation",
			choices = { { value = "column", label = L["Column"] }, { value = "row", label = L["Row"] }, { value = "rowReverse", label = L["Row, reversed"] } } },
		{ kind = "slider", key = "buttons.spacing", label = L["Spacing"], min = 0, max = 40, step = 1, format = px, new = NEW,
			help = L["The gap between two buttons of the set."],
			search = "gap, space between, padding, distance, tight, apart, spread" },
		{ kind = "button", icon = "reset", button = L["Reset"], label = L["Position"],
			help = L["Put the buttons back in their default spot. Drag any of them to move the set."],
			search = "move buttons, button position, reset position, drag, place", onClick = function() Buttons.ResetPositions() end },
		{ kind = "slider", key = "buttons.idleAlpha", label = L["Opacity"], min = 0, max = 1, step = 0.05, format = percent, new = NEW,
			help = L["How solid the buttons are outside a fight. Under the mouse they are always solid; at 0% they still work."],
			search = "opacity, transparency, alpha, fade, idle, out of combat, see through, faint, hide" },
		{ kind = "slider", key = "buttons.alpha", label = L["Combat opacity"], min = 0, max = 1, step = 0.05, format = percent, new = NEW,
			help = L["How solid the buttons are while you fight."],
			search = "opacity, transparency, alpha, fade, in combat, fight, see through" },
	} },
	-- Each button: its size, and whether it shows at all; the Hearthstone's
	-- two buttons side by side on one line.
	{ page = PAGE, tab = ACTION, section = L["Buttons"], controls = present(
		sizeRow("item", L["Quest item"], L["The quest item button's size, before the scale. The switch beside it shows or hides the button."],
			"qol.itemButton", L["A button for the current step's quest item, with count, cooldown and range. Bind it under Key Bindings > AddOns."]),
		sizeRow("target", L["Target"], L["The target button's size, before the scale. The switch beside it shows or hides the button."],
			"qol.targetButton", L["Targets the current step's mobs by name, or the NPCs it sends you to when it has no mob; each click moves to the next name. Bindable."]),
		hearthRow,
		travelRow,
		sizeRow("rare", L["Rare"], L["The rare button's size, before the scale. The switch beside it shows or hides the button."],
			"qol.rareButton", L["Shows a button that targets a rare Polestar spotted nearby, until it dies or is out of sight. Bindable."]),
		sizeRow("bag", L["Bag"], L["The bag space button's size (the cheapest junk, when your bags are nearly full), before the scale."], nil, nil,
			function() return not QoL.On("bagSpace") end),
		{ kind = "slider", key = "buttons.padding", label = L["Icon inset"], min = 0, max = 8, step = 1, format = px, new = NEW,
			help = L["How far the icon sits in from the button's edge."],
			search = "padding, inset, icon size, margin, border gap, zoom" }) },
	-- The plate behind each icon, its hairline, and the glow round it.
	{ page = PAGE, tab = ACTION, section = L["Plate"], controls = {
		{ kind = "dropdown", key = "buttons.backing", label = L["Background"], new = NEW,
			help = L["The plate behind each icon: the panel colour, a darker one, or none (the icon alone). The swatch sets your own colour and opacity."],
			search = "background, backing, plate, backdrop, panel, dark, transparent, none, fill",
			choices = { { value = "panel", label = L["Panel"] }, { value = "dark", label = L["Dark"] }, { value = "none", label = L["None"] } },
			extras = { { kind = "color", key = "buttons.backingColor", label = L["Background colour"], alpha = true, new = NEW,
				help = L["Your own colour and opacity for the plate. Right-click to go back to the background's."],
				search = "background colour, plate colour, backdrop colour, tint, transparency",
				shown = function() return Theme.Color(ns.Get("buttons.backing") == "dark" and "scrim" or "panel") end } } },
		{ kind = "toggle", key = "buttons.border", label = L["Border"], new = NEW,
			help = L["The hairline round each button. Under the mouse it lights up either way. The swatch sets its colour, the cog its thickness."],
			search = "border, edge, outline, frame, hairline, line",
			extras = { { kind = "color", key = "buttons.borderColor", label = L["Border colour"], alpha = true, new = NEW,
				help = L["Right-click to go back to the theme's hairline."],
				search = "border colour, edge colour, outline colour",
				shown = function() return Theme.Color("border") end } },
			more = { { kind = "slider", key = "buttons.borderSize", label = L["Thickness"], min = 1, max = 4, step = 1, format = px, new = NEW,
				help = L["How thick the border is, the hover's too."],
				search = "border width, thick border, thin border, edge size" } } },
		{ kind = "color", key = "buttons.hoverColor", label = L["Hover"], new = NEW,
			help = L["The border under the mouse. Right-click to go back to the accent."],
			search = "hover, mouseover, highlight colour, accent",
			shown = function() return Theme.Accent() end,
			source = function() return L["Accent"] end },
		{ kind = "toggle", key = "buttons.glow", label = L["Glow when ready"], new = NEW,
			help = L["A glow round the quest item or Hearthstone button while it can be used now (in range, off cooldown), and round the rare button while a rare is up. It breathes unless Reduce motion is on. The swatch sets its colour."],
			search = "glow, flash, highlight, usable, ready, proc, shine, pulse, attention",
			extras = { { kind = "color", key = "buttons.glowColor", label = L["Glow colour"], alpha = true, new = NEW,
				help = L["Right-click to go back to the accent."],
				search = "glow colour, flash colour, highlight colour",
				shown = function() return Theme.Accent() end } } },
	} },
	-- The texts: the names beside the target and rare buttons, and those inside each button.
	{ page = PAGE, tab = ACTION, section = L["Text"], controls = {
		{ kind = "dropdown", key = "qol.buttonTextSide", label = L["Name position"],
			help = L["Where the target's name shows around the target button: right, left, above or below."],
			search = "name side, label position, text side, left, right, above, below, target name position",
			choices = { { value = "right", label = L["Right"] }, { value = "left", label = L["Left"] }, { value = "above", label = L["Above"] }, { value = "below", label = L["Below"] } } },
		{ kind = "slider", key = "buttons.labelScale", label = L["Text size"], min = 0.6, max = 2, step = 0.05, format = percent, new = NEW,
			help = L["The size of the names beside the target and rare buttons, against the theme's. The cog sets their outline."],
			search = "text size, font size, name size, bigger names, smaller names, label size, huge, tiny",
			more = { { kind = "dropdown", key = "buttons.labelOutline", label = L["Outline"], new = NEW,
				help = L["Automatic outlines the target's name while it shows who it targets, over the game world; the theme's follows your text outline."],
				search = "outline, font outline, thick outline, shadow, readable, legible",
				choices = { { value = "auto", label = L["Automatic"] }, { value = "theme", label = L["The theme's"] },
					{ value = "outline", label = L["Outline"] }, { value = "thick", label = L["Thick outline"] } } } } },
		{ kind = "toggle", key = "qol.targetPlate", label = L["Who it targets"], info = true,
			help = L["The target button's icon shows what you do next: talk, accept, turn in, kill or loot, a skull for an elite, rare or boss, or their face once you have seen them. Their name sits beside it, green for a friendly NPC, red for a mob, gold for an elite or rare, with small icons for the names after it. The cog sets those icons' size."],
			search = "target icon, target name, portrait, npc name, elite, boss, plate, show who it targets",
			disabled = function() return not QoL.On("targetButton") end,
			more = { { kind = "slider", key = "buttons.miniSize", label = L["Next names' icons"], min = 8, max = 32, step = 1, format = px, new = NEW,
				help = L["The small icons for the names after the next one, under the target's name, and the action badge on a face."],
				search = "small icons, mini icons, next targets, badge size, queue" } } },
		{ kind = "toggle", key = "buttons.hotkey", label = L["Key binding"], new = NEW,
			help = L["The key a button is bound to, in its top corner. The cog sets its size."],
			search = "keybind, hotkey, key text, binding label, shortcut",
			more = { { kind = "slider", key = "buttons.hotkeyScale", label = L["Text size"], min = 0.6, max = 2, step = 0.05, format = percent, new = NEW,
				help = L["The size of the key binding text, against the theme's."],
				search = "keybind size, hotkey size, bigger key, font size" } } },
		{ kind = "toggle", key = "buttons.count", label = L["Item count"], new = NEW,
			help = L["How many of the item you carry, in the bottom corner."],
			search = "count, stack, number, quantity, charges" },
		{ kind = "toggle", key = "buttons.cooldownText", label = L["Cooldown numbers"], new = NEW,
			help = L["The time left on the item's cooldown, over the sweep. Off hides the game's numbers and those of cooldown addons such as OmniCC."],
			search = "cooldown text, timer, countdown, omnicc, numbers, seconds" },
	} },

	-- The floating button and the minimap button: each on/off beside its size.
	{ page = PAGE, tab = OTHER, section = L["Floating & minimap"], preview = buildLauncherBand, controls = {
		{ kind = "slider", key = "ui.launcherSize", label = L["Floating button"], min = 16, max = 96, step = 1, format = px, new = NEW,
			help = L["The floating button's size. The switch beside it shows it: a small Polestar button you can put anywhere on the screen. Click to hide or show Polestar, right-click for a menu, drag to move it."],
			search = "launcher size, floating button size, bigger, smaller, huge, tiny",
			extras = { { kind = "toggle", key = "ui.launcher", label = L["Floating button"],
				help = L["A small Polestar button you can put anywhere on the screen. Click to hide or show Polestar, right-click for a menu, drag to move it. It hides with the window in combat and in dungeons when those are set to Hide."],
				search = "launcher, floating icon, floating button, show, hide, toggle, open polestar, quick" } } },
		{ kind = "slider", key = "ui.launcherAlpha", label = L["Opacity"], min = 0.1, max = 1, step = 0.05, format = percent, new = NEW,
			help = L["How solid the floating button is."],
			search = "launcher opacity, transparency, alpha, fade, faint" },
		{ kind = "dropdown", key = "ui.launcherIcon", label = L["Icon"], new = NEW,
			help = L["The floating button's mark: Polestar's logo, or its emblem alone in your accent colour or in white."],
			search = "launcher icon, logo, emblem, colour, white, accent, monochrome", choices = ICON_CHOICES },
		{ kind = "toggle", key = "ui.launcherBack", label = L["Disc"], new = NEW,
			help = L["The round plate behind the floating button's icon. Off, the icon stands alone."],
			search = "background, backing, disc, circle, plate, transparent" },
		{ kind = "slider", key = "maps.minimapButtonSize", label = L["Minimap button"], min = 20, max = 64, step = 1, format = px, new = NEW,
			help = L["The minimap button's size. The switch beside it shows it on the edge of the minimap. A minimap addon that gathers buttons may size it its own way."],
			search = "minimap button size, bigger, smaller, icon size",
			extras = { { kind = "toggle", key = "maps.minimapButton", label = L["Minimap button"],
				help = L["A Polestar button on the edge of the minimap. Click to hide or show Polestar, right-click for a menu, drag to move it."],
				search = "minimap icon, minimap button, hide button, launcher" } } },
		{ kind = "dropdown", key = "maps.minimapButtonIcon", label = L["Minimap icon"], new = NEW,
			help = L["The minimap button's mark: Polestar's logo, or its emblem alone in your accent colour or in white."],
			search = "minimap icon, logo, emblem, colour, white, accent, monochrome", choices = ICON_CHOICES },
	} },
}

---------------------------------------------------------------------------
-- Essentials (the page's lead tab): four looks of the button set as picture
-- cards, then the ten settings players change most, each a reference to its
-- row on Action buttons or Launcher & minimap.
---------------------------------------------------------------------------

local O = ns.UI and ns.UI.Options
if O and O.PresetCards and O.Ref then
	local R = O.Ref
	-- A preset's card: the Hearthstone, quest item and target buttons as the
	-- set lines them up with the preset's values, drawn by the buttons' own
	-- face code (Buttons.NewFace, Size, Paint, Offsets, Alpha) and fitted in.
	local function drawSetCard(art, _, values)
		local cw, ch = art:GetWidth(), art:GetHeight()
		if not (cw and cw > 0) then cw = W.CARD_W - 2 end
		if not (ch and ch > 0) then ch = W.CARD_ART end
		local g = art.psGroup
		if not g then
			W.Fill(art, "scrim", "BACKGROUND", -6)
			g = CreateFrame("Frame", nil, art)
			g:SetSize(1, 1)
			g.faces = {}
			for i, kind in ipairs({ "hearth", "item", "target" }) do
				local b = Buttons.NewFace(g, kind)
				b.psStack = g.faces
				g.faces[i] = b
			end
			g.faces[1].Icon:SetTexture(itemIcon(QoL.Client and QoL.Client.HEARTHSTONE, DEMO_HEARTH_ICON))
			g.faces[2].Icon:SetTexture(DEMO_ITEM_ICON)
			g.faces[2].Count:SetText("3")
			for i, key in ipairs({ "H", "E", "T" }) do g.faces[i].Hotkey:SetText(key) end
			local t = g.faces[3]
			t.aList, t.aVerbs, t.aIds, t.aMarks, t.aCycle = { L["Kobold Vermin"] }, { "kill" }, {}, { false }, 1
			art.psGroup = g
		end
		O.WithSettings(values, function()
			local at = Buttons.Offsets()
			local x0, x1, y0, y1 = math.huge, -math.huge, math.huge, -math.huge
			for _, b in ipairs(g.faces) do
				local size = Buttons.Size(b.psKind)
				b:SetSize(size, size)
				b.psReady = true
				Buttons.Paint(b)
				local o, h = at[b.psKind], size / 2
				b:ClearAllPoints()
				b:SetPoint("CENTER", g, "CENTER", o[1], o[2])
				x0, x1, y0, y1 = min(x0, o[1] - h), max(x1, o[1] + h), min(y0, o[2] - h), max(y1, o[2] + h)
			end
			-- The target's name beside it, on its side: the card holds it too.
			local tb, o = g.faces[3], at.target
			local lw, side, h = tb.Label:GetStringWidth() + 6, ns.Get("qol.buttonTextSide"), Buttons.Size("target") / 2
			if side == "left" then
				x0 = min(x0, o[1] - h - lw)
			elseif side == "above" or side == "below" then
				x0, x1 = min(x0, o[1] - lw / 2), max(x1, o[1] + lw / 2)
				if side == "above" then y1 = max(y1, o[2] + h + NAME_H) else y0 = min(y0, o[2] - h - NAME_H) end
			else
				x1 = max(x1, o[1] + h + lw)
			end
			-- The set at 45% of its scale (so a bigger set shows bigger), smaller
			-- only when it would not fit the card.
			local s = (tonumber(ns.Get("qol.buttonScale")) or 1) * 0.45
			s = min(s, (ch - 14) / (y1 - y0), (cw - 16) / (x1 - x0))
			g:SetScale(max(0.05, s))
			g:ClearAllPoints()
			g:SetPoint("CENTER", art, "CENTER", -(x0 + x1) / 2, -(y0 + y1) / 2)
			g:SetAlpha(Buttons.Alpha(false))
		end)
	end
	local PRESETS = {
		{ value = "polestar", label = L["Polestar"], set = {}, draw = drawSetCard },
		{ value = "large", label = L["Large"], draw = drawSetCard,
			help = L["Bigger buttons with bigger names and key bindings."],
			set = { ["qol.buttonScale"] = 1.3, ["buttons.labelScale"] = 1.2, ["buttons.hotkeyScale"] = 1.2 } },
		{ value = "row", label = L["Row"], draw = drawSetCard,
			help = L["The buttons side by side, their names below them."],
			set = { ["buttons.layout"] = "row", ["qol.buttonTextSide"] = "below" } },
		{ value = "quiet", label = L["Quiet"], draw = drawSetCard,
			help = L["Half seen out of combat, no glow and no background plate."],
			set = { ["buttons.idleAlpha"] = 0.5, ["buttons.glow"] = false, ["buttons.backing"] = "none" } },
	}
	local ESSENTIALS = L["Essentials"]
	local list = {
		{ page = PAGE, tab = ESSENTIALS, lead = true, section = L["Presets"], preview = buildEssentialsBand,
			controls = { O.PresetCards({ presets = PRESETS }) } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Buttons"], jump = { tab = ACTION, section = L["Buttons"] },
			controls = { R("slider", "buttons.itemSize"), R("slider", "buttons.hearthSize"), R("slider", "buttons.targetSize"), R("slider", "buttons.rareSize") } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Button set"], jump = { tab = ACTION, section = L["Button set"] },
			controls = { R("slider", "qol.buttonScale"), R("dropdown", "buttons.layout"), R("dropdown", "qol.buttonTextSide"), R("slider", "buttons.idleAlpha"),
				R("slider", "ui.launcherSize"), R("slider", "maps.minimapButtonSize") } },
	}
	for _, spec in ipairs(list) do SPECS[#SPECS + 1] = spec end
end

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
