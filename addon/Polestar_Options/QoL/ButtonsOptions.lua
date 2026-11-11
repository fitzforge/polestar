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

-- The settings a preview repaints for: its own keys, and their sections
-- set at once (a profile, a reset).
local OWN = {
	[""] = true, buttons = true, qol = true, ui = true, maps = true, nav = true,
	["qol.buttonScale"] = true, ["qol.buttonTextSide"] = true, ["qol.targetPlate"] = true, ["ui.reduceMotion"] = true,
	["qol.itemButton"] = true, ["qol.hearthButton"] = true, ["qol.targetButton"] = true, ["qol.rareButton"] = true,
	["nav.castPrompt"] = true,
}
local function owned(path)
	if type(path) ~= "string" then return true end
	return OWN[path] or path:sub(1, 8) == "buttons." or path:sub(1, 11) == "ui.launcher" or path:sub(1, 18) == "maps.minimapButton"
		or path:sub(1, 9) == "nav.arrow"
end

-- The stage's height when the window gives it none (a preview laid out on
-- its own); the room between two surfaces.
local STAGE_H, APART = 216, 56

-- A preview frame: the settings window's stage over the world the buttons
-- sit on (the zone you stand in), and repaint(f) on its settings and theme
-- changes, only while shown (else on the next show). f:Layout(width,
-- height) lays it out for the hero's height.
local function stage(view, repaint)
	local f = ns.UI.Preview.Stage(view, { height = STAGE_H, backdrop = "world" })
	local ground = f.Back
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
	-- -> the hero's height (the window's; STAGE_H laid out alone)
	function f:Layout(w, h)
		h = h or STAGE_H
		self:SetWidth(w)
		if dirty or w ~= self.psWidth or h ~= self.psHeight then
			self.psWidth, self.psHeight = w, h
			paint()
		end
		return h
	end
	return f
end

local function caption(f, text)
	local c = W.Text(f, "small", "textMuted")
	c:SetJustifyH("CENTER")
	c:SetText(text)
	return c
end

-- A part of a preview the player can click to reach its row (the window's
-- preview hotspots, FIXES-V2 E5); f.psHotspots[key] keeps each (tests).
local function hotspot(f, region, key)
	f.psHotspots = f.psHotspots or {}
	f.psHotspots[key] = f:Hot(region, key)
end

-- Columns across stage f (s:SideBySide): side by side at their own size,
-- smaller only where they would not fit, each on a soft shadow with its
-- caption under it. A column: { w, h (at k = 1), place = fn(k, left, top),
-- foot = the frame its shadow stands under, caption = a font string }.
local function lineUp(f, cols)
	if #cols > 0 then f:SideBySide(cols, { gap = APART }) end
end

---------------------------------------------------------------------------
-- Action buttons: the whole set as it lines up when every button shows
-- (bag, Hearthstone, quest item, target, rare), out of combat, over the
-- world it acts on: the mob the target button names (your target, its raid
-- mark when Mark target is on) and the rare the rare button names, further
-- off; and the quest item button in combat. A button turned off is drawn
-- faint.
---------------------------------------------------------------------------

local DEMO_ITEM_ICON = "Interface\\Icons\\INV_Misc_Note_01"
local DEMO_HEARTH_ICON = "Interface\\Icons\\INV_Misc_Rune_01"
local DEMO_BAG_ICON = "Interface\\Icons\\INV_Misc_Bag_08"
local SHOWN = { "bag", "hearth", "item", "target", "rare" }
local SWITCH = { item = "itemButton", hearth = "hearthButton", target = "targetButton", rare = "rareButton", bag = "bagSpace" }
-- The room a name beside the set takes, in button pixels.
local NAME_W, NAME_H = 120, 18

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

-- The set's parts on stage f: the faces in a group (the idle opacity), a
-- box over the buttons for their shadow and lights, the combat face.
local function buildSet(f)
	local set = { faces = {}, list = {} }
	set.group = CreateFrame("Frame", nil, f)
	set.group:SetSize(1, 1)
	for i, kind in ipairs(SHOWN) do
		local b = Buttons.NewFace(set.group, kind)
		set.faces[kind], set.list[i] = b, b
		b.psStack = set.list
	end
	set.box = CreateFrame("Frame", nil, f)
	set.single = CreateFrame("Frame", nil, f)
	set.single:SetSize(1, 1)
	set.combat = Buttons.NewFace(set.single, "item")
	set.idle, set.fight = caption(f, L["Out of combat"]), caption(f, L["In combat"])
	local faces = set.faces
	faces.hearth.Cooldown:SetCooldown(GetTime and GetTime() - 600 or 0, 3600)
	faces.bag.Icon:SetTexture(DEMO_BAG_ICON)
	faces.rare.Label:SetText(L["Thuros Lightfingers"])
	local target = faces.target
	target.aList = { L["Rot Hide Mongrel"], L["Scarlet Warrior"], L["Executor Zygand"] }
	target.aVerbs = { "kill", "collect", "turnin" }
	target.aIds, target.aMarks, target.aCycle = {}, { false, false, false }, 1
	hotspot(f, faces.hearth, "buttons.hearthSize")
	hotspot(f, faces.item, "buttons.itemSize")
	hotspot(f, target, "buttons.targetSize")
	hotspot(f, target.Label, "qol.buttonTextSide")
	hotspot(f, set.combat, "buttons.alpha")
	-- The world: the target's mob near the set, the rare further off and
	-- smaller (UI.Preview.Mob: a nameplate and its spot on the ground).
	local P, lv = ns.UI.Preview, ns.Levels and ns.Levels.Player and ns.Levels.Player() or {}
	lv = max(1, lv.level or 18)
	set.mob = P.Mob(f, { name = target.aList[1], level = lv, health = 0.64, target = true, mark = 8 })
	set.far = P.Mob(f, { name = faces.rare.Label:GetText(), level = lv, ring = { Theme.Color("rare") } })
	f:Light("qol.targetButton", set.mob)
	f:Light("qol.rareButton", set.far)
	-- The pointer on a setting's row lights the parts it changes.
	local all = { faces.bag, faces.hearth, faces.item, target, faces.rare, set.combat }
	local names = { target.Label, faces.rare.Label }
	local keys = { faces.hearth.Hotkey, faces.item.Hotkey, target.Hotkey }
	for key, parts in pairs({
		["qol.buttonScale"] = { set.box, set.combat }, ["buttons.layout"] = { set.box }, ["buttons.spacing"] = { set.box },
		["buttons.idleAlpha"] = { set.box }, ["buttons.alpha"] = { set.combat },
		["buttons.itemSize"] = { faces.item, set.combat }, ["buttons.hearthSize"] = { faces.hearth }, ["buttons.targetSize"] = { target },
		["buttons.rareSize"] = { faces.rare }, ["buttons.bagSize"] = { faces.bag },
		["qol.itemButton"] = { faces.item, set.combat }, ["qol.hearthButton"] = { faces.hearth }, ["qol.targetButton"] = { target },
		["qol.rareButton"] = { faces.rare },
		["buttons.padding"] = all, ["buttons.backing"] = all, ["buttons.backingColor"] = all, ["buttons.border"] = all,
		["buttons.borderColor"] = all, ["buttons.borderSize"] = all, ["buttons.hoverColor"] = all,
		["buttons.glow"] = { faces.item, faces.hearth, faces.rare }, ["buttons.glowColor"] = { faces.item, faces.hearth, faces.rare },
		["qol.buttonTextSide"] = names, ["buttons.labelScale"] = names, ["buttons.labelOutline"] = names,
		["qol.targetPlate"] = { target, target.Label }, ["buttons.miniSize"] = { target },
		["buttons.hotkey"] = keys, ["buttons.hotkeyScale"] = keys,
		["buttons.count"] = { faces.item.Count, set.combat.Count }, ["buttons.cooldownText"] = { faces.hearth },
	}) do
		f:Light(key, unpack(parts))
	end
	return set
end

-- The set's faces with the current values (their size, paint, a faint face
-- for a button turned off), and its columns for lineUp: the set out of
-- combat and, with `combat`, the quest item button in it.
local function setColumns(f, set, combat)
	local faces = set.faces
	local live = Buttons.item
	for _, b in ipairs({ faces.item, set.combat }) do
		b.Icon:SetTexture(itemIcon(live and live.itemID, DEMO_ITEM_ICON))
		b.Count:SetText("3")
		b.Hotkey:SetText(keyFor("PolestarQuestItemButton", "E"))
		-- Shown ready, so the glow setting shows.
		b.psReady = true
	end
	faces.hearth.Icon:SetTexture(itemIcon(QoL.Client and QoL.Client.HEARTHSTONE, DEMO_HEARTH_ICON))
	faces.hearth.Hotkey:SetText(keyFor("PolestarHearthButton", "H"))
	faces.target.Hotkey:SetText(keyFor("PolestarTargetButton", "T"))
	for _, b in ipairs(set.list) do
		local size = Buttons.Size(b.psKind)
		b:SetSize(size, size)
		Buttons.Paint(b)
		b:SetAlpha(QoL.On(SWITCH[b.psKind]) and 1 or 0.3)
	end
	set.combat:SetSize(Buttons.Size("item"), Buttons.Size("item"))
	Buttons.Paint(set.combat)
	set.combat:SetAlpha(QoL.On("itemButton") and 1 or 0.3)
	set.group:SetAlpha(Buttons.Alpha(false))
	set.single:SetAlpha(Buttons.Alpha(true))

	-- The set's box from its offsets, the names' room on their side.
	local at = Buttons.Offsets()
	local x0, x1, y0, y1 = math.huge, -math.huge, math.huge, -math.huge
	for _, b in ipairs(set.list) do
		local o, h = at[b.psKind], Buttons.Size(b.psKind) / 2
		b:ClearAllPoints()
		b:SetPoint("CENTER", set.group, "CENTER", o[1], o[2])
		x0, x1, y0, y1 = min(x0, o[1] - h), max(x1, o[1] + h), min(y0, o[2] - h), max(y1, o[2] + h)
	end
	local side = ns.Get("qol.buttonTextSide")
	local left = side == "left" and NAME_W or 0
	local right = (side == "right" or side == nil) and NAME_W or 0
	local up = side == "above" and NAME_H or 0
	local down = side == "below" and NAME_H or 0
	local t = f:TrueScale()
	local s = (tonumber(ns.Get("qol.buttonScale")) or 1) * t
	-- The world it acts on: the target's raid mark while Mark target is on,
	-- the rare's ring in the rares' colour.
	local mob, far = set.mob, set.far
	local mark = tonumber(ns.Get("qol.markMob"))
	mob.Mark:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. ((mark and mark >= 1 and mark <= 8) and floor(mark) or 8))
	mob.Mark:SetShown(QoL.On("markTarget") and true or false)
	far:Tint(Theme.Color("rare"))
	-- In stage units at k = 1 from the quest item button's centre (y up):
	-- the set with its names; the target a little left of it, its plate
	-- level with the set's top; the rare further left, further off (smaller
	-- and higher up), as they stand around you when the buttons name them.
	local FAR = 0.8
	local sx0, sx1, sy0, sy1 = (x0 - left) * s, (x1 + right) * s, (y0 - down) * s, (y1 + up) * s
	local mx, my = sx0 - (mob.HALF + 64) * t, sy1 - (mob.UP + 8) * t
	local fx, fy = mx - (mob.HALF + far.HALF * FAR + 36) * t, my + 34 * t
	local L, R = min(sx0, fx - far.HALF * FAR * t), sx1
	local T = max(sy1, my + mob.UP * t, fy + far.UP * FAR * t)
	local B = min(sy0, my - 18 * t, fy - 18 * FAR * t)
	local cols = {}
	cols[1] = { w = R - L, h = T - B, foot = set.box, caption = set.idle,
		place = function(k, l, top)
			-- The quest item button's centre on the stage.
			local cx, cy, g = l - L * k, top + T * k, s * k
			set.group:SetScale(g)
			set.group:ClearAllPoints()
			set.group:SetPoint("CENTER", f, "TOPLEFT", cx / g, -cy / g)
			set.box:ClearAllPoints()
			set.box:SetPoint("TOPLEFT", f, "TOPLEFT", cx + x0 * g, -(cy - y1 * g))
			set.box:SetSize((x1 - x0) * g, (y1 - y0) * g)
			mob:Stand(cx + mx * k, cy - my * k, t * k)
			far:Stand(cx + fx * k, cy - fy * k, t * k * FAR)
		end }
	set.fight:SetShown(combat and true or false)
	set.single:SetShown(combat and true or false)
	if combat then
		local size = Buttons.Size("item") * s
		cols[2] = { w = size, h = size, foot = set.combat, caption = set.fight,
			place = function(k, l, t)
				local g = s * k
				set.single:SetScale(g)
				set.single:ClearAllPoints()
				set.single:SetPoint("CENTER", f, "TOPLEFT", (l + size * k / 2) / g, -(t + size * k / 2) / g)
				set.combat:ClearAllPoints()
				set.combat:SetPoint("CENTER", set.single, "CENTER", 0, 0)
			end }
	end
	return cols
end

---------------------------------------------------------------------------
-- The floating button and the minimap button, on the edge of a minimap.
---------------------------------------------------------------------------

local MINIMAP_D = 140 -- the game's minimap, across

local function buildOthers(f)
	local UI, Maps = ns.UI, ns.Maps
	local o = {}
	if UI and UI.Launcher and UI.Launcher.Face then
		o.launcher = UI.Launcher.Face(CreateFrame("Button", nil, f))
		o.lCap = caption(f, L["Floating button"])
		hotspot(f, o.launcher, "ui.launcherSize")
		for _, key in ipairs({ "ui.launcherSize", "ui.launcher", "ui.launcherAlpha", "ui.launcherIcon", "ui.launcherBack" }) do
			f:Light(key, o.launcher)
		end
	end
	if Maps and Maps.MinimapButtonFace then
		-- A minimap as the Map pins page draws one: its ground, its rim and
		-- the player's arrow in the middle.
		o.mm = CreateFrame("Frame", nil, f)
		o.disc = o.mm:CreateTexture(nil, "BACKGROUND")
		o.disc:SetTexture("Interface\\AddOns\\Polestar\\Media\\Nav\\pin-fill")
		o.disc:SetPoint("CENTER")
		o.disc:SetSize(MINIMAP_D * 64 / 42, MINIMAP_D * 64 / 42) -- pin-fill's disc covers 42 of its 64 pixels
		o.disc:SetVertexColor(0.16, 0.2, 0.13, 1)
		local rim = o.mm:CreateTexture(nil, "BORDER")
		rim:SetTexture("Interface\\AddOns\\Polestar\\Media\\Map\\ring")
		rim:SetAllPoints(o.mm)
		W.Painter(rim, function(t)
			local r, g, b = Theme.Color("textDim")
			t:SetVertexColor(r, g, b, 0.6)
		end)
		local me = o.mm:CreateTexture(nil, "OVERLAY")
		me:SetTexture("Interface\\Minimap\\MinimapArrow")
		me:SetSize(26, 26)
		me:SetPoint("CENTER")
		o.minimap = Maps.MinimapButtonFace(CreateFrame("Button", nil, f))
		o.mCap = caption(f, L["Minimap button"])
		hotspot(f, o.minimap, "maps.minimapButtonSize")
		for _, key in ipairs({ "maps.minimapButtonSize", "maps.minimapButton", "maps.minimapButtonIcon" }) do
			f:Light(key, o.minimap)
		end
	end
	return o
end

-- Drawn even while turned off: how each would look. -> lineUp's columns
local function otherColumns(f, o)
	local UI, Maps = ns.UI, ns.Maps
	local t = f:TrueScale()
	local cols = {}
	if o.launcher then
		UI.Launcher.Paint(o.launcher)
		local lw, lh = o.launcher:GetWidth() * t, o.launcher:GetHeight() * t
		cols[#cols + 1] = { w = lw, h = lh, foot = o.launcher, caption = o.lCap,
			place = function(k, l, top)
				local g = t * k
				o.launcher:SetScale(g)
				o.launcher:ClearAllPoints()
				o.launcher:SetPoint("CENTER", f, "TOPLEFT", (l + lw * k / 2) / g, -(top + lh * k / 2) / g)
			end }
	end
	if o.minimap then
		Maps.PaintMinimapButton(o.minimap)
		local bw = o.minimap:GetWidth()
		-- The disc and the button on its edge where the live one sits by
		-- default: 225 degrees, its centre just past the rim.
		local a, r = math.rad(225), MINIMAP_D / 2 + 5
		local over = max(0, r + bw / 2 - MINIMAP_D / 2)
		local d = (MINIMAP_D + over) * t
		cols[#cols + 1] = { w = d, h = d, foot = o.mm, caption = o.mCap,
			place = function(k, l, top)
				local g = t * k
				o.mm:SetScale(g)
				o.mm:SetSize(MINIMAP_D, MINIMAP_D)
				o.mm:ClearAllPoints()
				-- The disc in the column's top right, the button over its lower left edge.
				o.mm:SetPoint("TOPLEFT", f, "TOPLEFT", (l + over * g) / g, -top / g)
				o.minimap:SetScale(g)
				o.minimap:ClearAllPoints()
				o.minimap:SetPoint("CENTER", o.mm, "CENTER", math.cos(a) * r, math.sin(a) * r)
			end }
	end
	return cols
end

---------------------------------------------------------------------------
-- The travel button under the arrow (Nav/Prompts.lua's PolestarTravelButton,
-- the Hearthstone's other button): the arrow (Nav's own dial) and under it a
-- plain frame in the travel button's look (the panel, the icon, the
-- hairline; never the secure button), holding your Hearthstone.
---------------------------------------------------------------------------

local TRAVEL, TRAVEL_GAP = 36, 6 -- Prompts.lua's SIZE and GAP

local function buildTravel(f)
	local A = ns.Nav and ns.Nav.arrow
	if not (ns.Nav and ns.Nav.prompts and A and A.BuildDial) then return nil end
	local tr = { A = A, look = {}, holder = CreateFrame("Frame", nil, f) }
	tr.holder:SetSize(A.WIDTH, A.HEIGHT + TRAVEL_GAP + TRAVEL)
	local dial = CreateFrame("Frame", nil, tr.holder)
	dial:SetSize(A.WIDTH, A.HEIGHT)
	dial:SetPoint("TOP", tr.holder, "TOP", 0, 0)
	tr.dial = A.BuildDial(dial)
	local b = CreateFrame("Frame", nil, tr.holder)
	b:SetSize(TRAVEL, TRAVEL)
	b:SetPoint("TOP", dial, "BOTTOM", 0, -TRAVEL_GAP)
	W.Fill(b, "panel", "BACKGROUND")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
	b.Icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
	b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	tr.button = b
	tr.cap = caption(f, L["Travel button"])
	hotspot(f, b, "nav.castPrompt")
	f:Light("nav.castPrompt", b)
	return tr
end

-- Its column for lineUp: the arrow toward the leg's end, the button under it
-- (faint while turned off, as a button of the set is).
local function travelColumn(f, tr)
	local A, t = tr.A, f:TrueScale()
	A.ReadLook(tr.look)
	A.PaintDial(tr.dial, tr.look, A.StyleFor(ns.Get("nav.arrowStyle")), "travel", 0.4, 1240, L["Goldshire"])
	local b = tr.button
	b.Icon:SetTexture(itemIcon(QoL.Client and QoL.Client.HEARTHSTONE, DEMO_HEARTH_ICON))
	local r, g, bl, a = Theme.Color("border")
	Theme.Border(b, r, g, bl, (a or 0.08) * 2.5)
	b:SetAlpha(ns.Get("nav.castPrompt") and 1 or 0.3)
	local w, h = tr.holder:GetWidth() * t, tr.holder:GetHeight() * t
	return { w = w, h = h, foot = b, caption = tr.cap,
		place = function(k, l, top)
			local g = t * k
			tr.holder:SetScale(g)
			tr.holder:ClearAllPoints()
			tr.holder:SetPoint("TOPLEFT", f, "TOPLEFT", l / g, -top / g)
		end }
end

-- The Action buttons tab: the set over its world, the combat button, and the
-- travel button under the arrow. f.Faces, f.Mobs, f.Travel: its parts, for
-- the tests.
local function buildActionPreview(view)
	local set, tr
	local f = stage(view, function(f)
		set = set or buildSet(f)
		if tr == nil then tr = buildTravel(f) or false end
		local cols = setColumns(f, set, true)
		if tr then cols[#cols + 1] = travelColumn(f, tr) end
		lineUp(f, cols)
	end)
	f.Faces = function() return set and set.faces, set and set.combat end
	f.Mobs = function() return set and set.mob, set and set.far end
	f.Travel = function() return tr and tr.button end
	return f
end

-- The Launcher & minimap tab.
local function buildLauncherPreview(view)
	local o
	local f = stage(view, function(f)
		o = o or buildOthers(f)
		lineUp(f, otherColumns(f, o))
	end)
	f.Faces = function() return o and o.launcher, o and o.minimap end
	return f
end

-- Essentials, a band (UI.Preview.Band): its dropdown picks the action
-- button set, the floating button or the minimap button, shown alone at its
-- real size. The set as the player laid it out (buttons.layout, the names'
-- side, the sizes and the scale; a button turned off is not drawn), out of
-- combat (its idle opacity), centred on its buttons, their names hanging to
-- their side. f.Faces, f.Pick: its parts and its pick, for the tests.
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
	local set = { faces = {}, list = {} }
	set.group = CreateFrame("Frame", nil, f)
	set.group:SetSize(1, 1)
	for i, kind in ipairs(SHOWN) do
		local b = Buttons.NewFace(set.group, kind)
		set.faces[kind], set.list[i] = b, b
		b.psStack = set.list
	end
	-- Over the buttons alone: what lights for the set as a whole.
	set.box = CreateFrame("Frame", nil, f)
	local faces = set.faces
	faces.hearth.Cooldown:SetCooldown(GetTime and GetTime() - 600 or 0, 3600)
	faces.bag.Icon:SetTexture(DEMO_BAG_ICON)
	faces.rare.Label:SetText(L["Thuros Lightfingers"])
	local target = faces.target
	target.aList = { L["Rot Hide Mongrel"], L["Scarlet Warrior"], L["Executor Zygand"] }
	target.aVerbs = { "kill", "collect", "turnin" }
	target.aIds, target.aMarks, target.aCycle = {}, { false, false, false }, 1
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
	local snap = ns.UI.Preview.Snap

	-- The set with the current values. -> its natural size and place.
	local function setContent(self)
		local item, live = faces.item, Buttons.item
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
		set.group:SetAlpha(Buttons.Alpha(false))
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
		if bx0 > bx1 then return nil end
		local g0 = (tonumber(ns.Get("qol.buttonScale")) or 1) * self:TrueScale()
		-- Centred on the buttons, the names hanging to their side: a box as
		-- wide either side of the buttons' middle as the farther edge.
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

	-- One button alone (the floating button, the minimap button) at its real size.
	local function oneContent(self, b, paint)
		paint(b)
		local t = self:TrueScale()
		local bw, bh = b:GetWidth() * t, b:GetHeight() * t
		return bw, bh, function(left, top, k)
			local g = t * k
			b:SetScale(g)
			b:ClearAllPoints()
			b:SetPoint("TOPLEFT", self, "TOPLEFT", snap(b, left / g), snap(b, -top / g))
		end
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
		return setContent(self)
	end
	return f
end

-- The previews, for the tests: (parent) -> f.
Buttons.ActionPreview = buildActionPreview
Buttons.LauncherPreview = buildLauncherPreview
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
		preview = buildActionPreview,
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
	{ page = PAGE, tab = OTHER, section = L["Floating & minimap"], preview = buildLauncherPreview, controls = {
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
