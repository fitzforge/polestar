-- Action buttons: the quest item button, the Hearthstone button and the
-- target button and the rare button. Each is a named secure button (bindable as
-- `CLICK <name>:LeftButton`); what it does is set through attributes, and
-- every attribute, Show/Hide, scale or position change goes through
-- QoL.Secure, so in combat it waits for PLAYER_REGEN_ENABLED while the button
-- keeps doing what it did. Icon, count, cooldown and range tint are plain
-- textures and update at any time.
--
--   Quest item: the active tab's current `use` goal item; else the quest log
--     item of a quest in the current step; else a usable quest item in the
--     bags that one of the step's open quests handed over when taken
--     (Polestar.QuestDB; none without it), never one left from another quest.
--     Never during a flight.
--   Hearthstone: while the current step has an open `hearth` goal, never
--     during a flight.
--   Target: /targetexact for the current step's kill targets (every creature
--     their objective credits, `fromNpcs`), the creatures its `use` goals'
--     items work on (`fromNpcs`, #1614) and the mobs that drop its collect
--     items: the ones the guide sends you to for that goal (`fromNpcs`; where
--     the goal's spots hold other mobs, `fromNpcsAt`, those at the spot the
--     arrow takes alone, #1616), then the item's own droppers
--     (Polestar.QuestDB when loaded), passing over corpses; on a step with no
--     such mob, its NPC goals' NPCs (talk, accept, turn in, train...). The
--     arrow's goal comes first. After the step's own mobs (or with none), the
--     mobs of the While you're here rows, nearest row first (#1441). After the
--     step's NPCs too while the player is within the While you're here radius
--     of one; farther, the rows' mobs before the NPCs (#1623). A row the
--     arrow points at (clicked) comes before the step's own mobs (#2011).
--     Each name takes its own kind's mark and ping. Every click moves the next name to the
--     front. With qol.targetPlate (on by default) its icon shows what you do with the
--     name the next click targets (Buttons.TargetLook: a speech bubble, !,
--     ?, a sword, a bag, a skull for an elite, rare or boss), the name beside
--     it in that kind's colour, and a row of small icons for the names after
--     it; an elite's or an NPC's face once one of them has been seen (the
--     target, the mouseover or a nameplate: SetPortraitTexture, kept for the
--     session), with the action as a badge.
--   Rare: /targetexact for the rares in range (Polestar.Rares.Nearby): the
--     button comes up when the addon spots one and goes when it dies or is
--     out of sight; every click moves the next name to the front. When the
--     name in front is the founder's (Rares.IsFounder), its macro targets him
--     and waves instead (Buttons.FounderMacro).
--   Bag: while the bags are nearly full (QoL/Space.lua), the cheapest junk
--     in them with the free slot count; a press arms it, a second press
--     within a few seconds deletes it. It has no secure action: the delete
--     runs in its PostClick, on the press itself.
--   Target list (unless qol.targetSimple): a row beside the target button
--     for each of its names, with the creature's portrait and what it drops
--     for the step; a click on a row targets that one, with the target
--     button's mark and ping for its kind. The button then keeps the list's
--     order instead of moving the next name to the front, and a small
--     Polestar mark stands in its slot. There is no setting of its own: it
--     shows with qol.targetButton. The rows sit beside the target button in a
--     column, under it in a row (buttons.layout), and the rare button moves
--     along the set to clear them (Buttons.Offsets, Buttons.ListRect); they
--     take the Buttons page's look like the buttons (kinds "targetRow" and
--     "targetMark" for a skin's actionButton hook).
--   Step key: no button on screen, only a binding: the first open goal it can
--     act on, in guide order (a use goal's item, a hearth goal's Hearthstone,
--     a kill or collect's mobs, an NPC goal's NPC by name), else the quest
--     item. While it targets, or has nothing else to do, the mobs of the
--     While you're here rows follow the step's own names, nearest row first
--     (behavior.whileHereStepKey, #1316); on an NPC goal they follow the NPC,
--     or go before it while the player is farther than the While you're
--     here radius from the step's NPCs (#1623). While the flight map is open on the
--     live step, it takes the marked flight instead (QoL/Flight.lua,
--     Flight.Take). Independent of
--     the buttons' settings.
--   Mark target (off by default): the target button and the step key clear
--     the target first (out of combat) and end their macro with /tm, an icon
--     on a live hostile target (skull unless set) or an NPC (star), or a new
--     one each press (Buttons.MarkLine). The rare card's Target button
--     (Rares/Toast.lua, Buttons.RareCardMacro) marks its rare the same way.
--   Ping: the rare button and the rare card's Target button always follow
--     /targetexact with /ping [@target] (Buttons.PingLine), where the client
--     has the command; the target button (on mobs) and the step key only
--     with qol.pingTarget (off by default), never as a raid member without
--     lead or assist (Buttons.QuestPingLine).
--
-- All of them go with the guide window (ns.GuideShown); the step key stays.
-- In the game's Quick Keybind Mode they take a key under the cursor, and the
-- hidden ones show dimmed in their slots until it closes (QoL/QuickBind.lua).
--
-- The quest item, Hearthstone, target and rare buttons hang off one holder:
-- the hearth above the item, target and rare below (or in a row:
-- buttons.layout). A left-drag on any of them (or on the target list and its
-- Polestar mark) moves the set (out of combat; with ui.lockHud on, only a
-- Shift-drag); the position is per character, so the Hearthstone button,
-- shown only for hearth goals, appears in its slot of the moved set (the
-- rare button further out while the target list shows). The bag button stands on its own: the same drag moves only
-- it, to its own saved spot (by default two slots above the item, where it
-- sat in the set).
--
-- Their look is the Buttons page's (QoL/ButtonsOptions.lua, the buttons.*
-- settings): sizes, spacing and layout move protected frames, so they wait
-- out combat with the rest (place()); backing, border, text, glow and
-- opacity are plain regions and SetAlpha, and change at once. The same face
-- code draws the settings preview's plain buttons (Buttons.NewFace), never a
-- secure one.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local type, pairs, ipairs, tostring = type, pairs, ipairs, tostring
local concat, wipe = table.concat, wipe or function(t) for k in pairs(t) do t[k] = nil end return t end

local SIZE = 36
local RANGE_INTERVAL = 0.2
local MAX_NAMES = 5
local MACRO_LIMIT = 255
-- The target button's small icons for the names after the next one: size
-- (buttons.miniSize's default; the name moves up half of it for them), gap,
-- and how many faces it keeps.
local MINI = 14
local MINI_GAP = 3
local PORTRAIT_CAP = 16
-- The target list (TL: one table, as this file is at Lua's limit of 200
-- locals): up to TL.MAX rows, qol.targetRows of them (default MAX_NAMES);
-- a row's size, the gap between rows and the portrait's size; the small
-- Polestar mark that stands in for the target button beside the list; a
-- row's green wash while one is close (alpha over the panel) and the brighter
-- flash it starts with, so a row turning green is seen from the corner of
-- the eye. TL.rows: the rows (one per name, made as a list first needs them:
-- applyRows); TL.anchor: the mark (the set's handle and the way to its
-- settings). TL.info, cap, keep, progress, item: what TargetNames collects
-- for the rows (Buttons.TargetInfo).
local TL = { MAX = 8, W = 180, H = 30, GAP = 2, FACE = 26, ANCHOR = 22, NEAR = 0.3, FLASH = 0.7,
	rows = {}, info = {}, cap = MAX_NAMES }

local Buttons = {}
QoL.Buttons = Buttons

-- The holder's spot (it sits where the quest item button does) and each
-- kind's slot above (+) or below (-) it in a column; in a row, left (+) or
-- right (-) of it (Buttons.Offsets). The bag button's own spot, by default
-- where its old slot in the house column was (two above the item), so nothing
-- moves for a player who never dragged them; its slot in Buttons.Offsets is
-- where the settings preview draws it.
local DEFAULT_POS = { "CENTER", "CENTER", 260, -140 }
local SLOT = { bag = 2, hearth = 1, item = 0, target = -1, rare = -2 }
local BAG_LIFT = 2 * (SIZE + 8)
local BAG_DEFAULT_POS = { DEFAULT_POS[1], DEFAULT_POS[2], DEFAULT_POS[3], DEFAULT_POS[4] + BAG_LIFT }

-- How the buttons look (the Buttons page, QoL/ButtonsOptions.lua). Sizes are
-- pixels before qol.buttonScale; colours false for the theme's, else
-- { r, g, b[, a] }.
ns.RegisterDefaults("buttons", {
	itemSize = SIZE, hearthSize = SIZE, targetSize = SIZE, rareSize = SIZE, bagSize = SIZE,
	spacing = 8,           -- between two buttons of the set
	layout = "column",     -- column (Hearthstone above, target below) | row (left to right) | rowReverse
	padding = 2,           -- the icon's inset from the button's edge
	backing = "panel",     -- panel | dark | none
	backingColor = false,
	border = true,
	borderColor = false,
	borderSize = 1,
	hoverColor = false,    -- the hairline under the mouse; false: the accent
	labelScale = 1,        -- the names' text size against the theme's
	labelOutline = "auto", -- auto (the target's name outlined on its plate) | theme | outline | thick
	miniSize = MINI,       -- the target button's small icons and badge
	hotkey = true,         -- the key binding in the corner
	hotkeyScale = 1,       -- ... its text size against the theme's
	count = true,          -- the item count
	cooldownText = true,   -- the cooldown's countdown numbers
	idleAlpha = 1,         -- opacity out of combat (full under the mouse)
	alpha = 1,             -- opacity in combat
	glow = false,          -- a glow round a quest item or Hearthstone ready to use, and round the rare button
	glowColor = false,     -- false: the accent
})

local SIZE_KEY = { item = "buttons.itemSize", hearth = "buttons.hearthSize", target = "buttons.targetSize", rare = "buttons.rareSize", bag = "buttons.bagSize" }

-- A number setting held to lo..hi; def when it is none.
local function num(path, lo, hi, def)
	local v = tonumber(ns.Get(path))
	if not v then return def end
	return v < lo and lo or v > hi and hi or v
end

local function isColor(c)
	return type(c) == "table" and type(c[1]) == "number" and type(c[2]) == "number" and type(c[3]) == "number"
end

-- A kind's button size in pixels, before qol.buttonScale.
function Buttons.Size(kind)
	return num(SIZE_KEY[kind] or SIZE_KEY.item, 16, 96, SIZE)
end

function Buttons.Column()
	local l = ns.Get("buttons.layout")
	return l ~= "row" and l ~= "rowReverse"
end

-- Each kind's centre from the quest item button's, in button pixels before
-- qol.buttonScale: the slots walk out from it, each its own size plus the
-- spacing from the last. Column: bag and Hearthstone up, target and rare
-- down; row: bag and Hearthstone left, target and rare right; rowReverse
-- the other way round. rows: how many rows the target list shows beside the
-- target button (Buttons.ListRect); the rare button moves along the set to
-- clear them. -> { kind = { x, y } } (reused)
local offsets = { bag = {}, hearth = {}, item = { 0, 0 }, target = {}, rare = {} }
function Buttons.Offsets(rows)
	local gap = num("buttons.spacing", 0, 40, 8)
	local layout = ns.Get("buttons.layout")
	local sx, sy = 0, 1
	if layout == "row" then sx, sy = -1, 0 elseif layout == "rowReverse" then sx, sy = 1, 0 end
	local function walk(kinds, sign)
		local d, prev = 0, Buttons.Size("item")
		for i = 1, #kinds do
			local s = Buttons.Size(kinds[i])
			d = d + prev / 2 + gap + s / 2
			prev = s
			local o = offsets[kinds[i]]
			-- 0 on the other axis, never -0 (it would compare and print apart).
			o[1], o[2] = sx == 0 and 0 or sign * sx * d, sy == 0 and 0 or sign * sy * d
		end
	end
	walk({ "hearth", "bag" }, 1)
	walk({ "target", "rare" }, -1)
	local x0, x1, y0 = Buttons.ListRect(rows)
	if x0 then
		local t, r, h = offsets.target, offsets.rare, Buttons.Size("rare") / 2
		if layout == "row" then
			r[1] = math.max(r[1], t[1] + x1 + gap + h)
		elseif layout == "rowReverse" then
			r[1] = math.min(r[1], t[1] + x0 - gap - h)
		else
			r[2] = math.min(r[2], t[2] + y0 - gap - h)
		end
	end
	return offsets
end

local function Theme() return ns.Theme end

local function color(region, name, alpha)
	local T = Theme()
	local r, g, b, a = 1, 1, 1, 1
	if T and T.Color then r, g, b, a = T.Color(name) end
	a = (a or 1) * (alpha or 1)
	if region.SetVertexColor and region:GetObjectType() == "Texture" then
		region:SetVertexColor(r, g, b, a)
	elseif region.SetTextColor then
		region:SetTextColor(r, g, b, a)
	end
end

local function media(name)
	local T = Theme()
	return T and T.Media and T.Media(name) or ("Interface\\AddOns\\" .. ADDON .. "\\Media\\UI\\" .. name)
end

local function font(fs, role)
	local T = Theme()
	if T and T.Font then T.Font(fs, role) end
end

-- The hairline: buttons.hoverColor (else the accent) under the mouse; else
-- buttons.borderColor, or the theme's, or none with buttons.border off.
-- buttons.borderSize thick.
local function paintBorder(b, hover)
	local T = Theme()
	if not (T and T.Border) then return end
	local size = num("buttons.borderSize", 1, 4, 1)
	if hover then
		local c = ns.Get("buttons.hoverColor")
		if isColor(c) then
			T.Border(b, c[1], c[2], c[3], c[4] or 1, nil, size)
		else
			local r, g, bl = T.Accent()
			T.Border(b, r, g, bl, 1, nil, size)
		end
		return
	end
	if b.closeUnit or b.psNear then
		-- A target list row with one close enough to target (psNear: a
		-- preview's): a green edge, thicker than the border, with the border
		-- off too.
		local r, g, bl = T.Color("success")
		T.Border(b, r, g, bl, 1, nil, math.max(2, size))
		return
	end
	local own = ns.Get("buttons.borderColor")
	if not ns.Get("buttons.border") then
		T.Border(b, 0, 0, 0, 0, nil, size)
	elseif isColor(own) then
		T.Border(b, own[1], own[2], own[3], own[4] or 1, nil, size)
	else
		local r, g, bl, a = T.Color("border")
		T.Border(b, r, g, bl, (a or 0.08) * 2.5, nil, size)
	end
end

---------------------------------------------------------------------------
-- Position, size and scale (secure)
---------------------------------------------------------------------------

-- bag: the bag button, on a spot of its own; relabel: every button's name
-- placed again (placeLabel), once they exist.
local holder, set, bag, relabel
local placeLabel
-- How many of the target list's rows show (TL.rows with a name).
function TL.count()
	local n = 0
	for i = 1, #TL.rows do
		if TL.rows[i].applied then n = n + 1 end
	end
	return n
end

-- Which way the target list goes from the target button: in a column
-- beside it, on the side its name would take ("left", else "right"); in a
-- row (buttons.layout) under it, reaching away from the quest item button
-- ("below": rightwards, "belowLeft": leftwards in a reversed row).
function TL.side()
	local l = ns.Get("buttons.layout")
	if l == "row" then return "below" elseif l == "rowReverse" then return "belowLeft" end
	return ns.Get("qol.buttonTextSide") == "left" and "left" or "right"
end

-- The rows' box for n rows from the target button's centre, in button
-- pixels before qol.buttonScale (y up): x0, x1, y0, y1; nil for none. The
-- gap to the button is the set's spacing (buttons.spacing). side: TL.side()'s.
function Buttons.ListRect(n, side)
	n = tonumber(n) or 0
	if n < 1 then return nil end
	side = side or TL.side()
	local h, w, g = Buttons.Size("target") / 2, TL.W, num("buttons.spacing", 0, 40, 8)
	local tall = n * TL.H + (n - 1) * TL.GAP
	if side == "right" then return h + g, h + g + w, h - tall, h end
	if side == "left" then return -h - g - w, -h - g, h - tall, h end
	if side == "below" then return -h, w - h, -h - g - tall, -h - g end
	return h - w, h, -h - g - tall, -h - g
end

-- The Polestar mark and the rows on target button t (the live one, hidden,
-- or a preview's face): the mark in t's corner on the rows' side, the first
-- row where Buttons.ListRect puts it, each next one under the last. scale:
-- theirs (the live set's), else left as it is; side: TL.side()'s.
function Buttons.PlaceList(t, mark, rows, scale, side)
	if not t then return end
	side = side or TL.side()
	local g = num("buttons.spacing", 0, 40, 8)
	local right = side == "right" or side == "belowLeft"
	if mark then
		if scale then mark:SetScale(scale) end
		local m = math.min(TL.ANCHOR, Buttons.Size("target"))
		mark:SetSize(m, m)
		mark:ClearAllPoints()
		mark:SetPoint(right and "TOPRIGHT" or "TOPLEFT", t, right and "TOPRIGHT" or "TOPLEFT", 0, 0)
		-- Quick Keybind Mode's key name: away from the rows.
		local l = mark.Label
		if l then
			l:ClearAllPoints()
			if side == "right" then l:SetPoint("RIGHT", mark, "LEFT", -8, 0)
			elseif side == "left" then l:SetPoint("LEFT", mark, "RIGHT", 8, 0)
			else l:SetPoint("BOTTOM", mark, "TOP", 0, 4) end
		end
	end
	for i = 1, #rows do
		local r = rows[i]
		if scale then r:SetScale(scale) end
		r:ClearAllPoints()
		if i > 1 then
			r:SetPoint("TOP", rows[i - 1], "BOTTOM", 0, -TL.GAP)
		elseif side == "right" then
			r:SetPoint("TOPLEFT", t, "TOPRIGHT", g, 0)
		elseif side == "left" then
			r:SetPoint("TOPRIGHT", t, "TOPLEFT", -g, 0)
		elseif side == "below" then
			r:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, -g)
		else
			r:SetPoint("TOPRIGHT", t, "BOTTOMRIGHT", 0, -g)
		end
	end
end

local function savedPos()
	local p = QoL.State().buttonPos
	return type(p) == "table" and p or DEFAULT_POS
end

local function savedBagPos()
	local p = QoL.State().bagButtonPos
	return type(p) == "table" and p or BAG_DEFAULT_POS
end

-- Before the bag button had its own spot it sat two slots above the moved
-- set. Once per character: a set moved before then takes the bag button
-- along to that same place on screen (holder and button share the scale, so
-- the offsets add up), and from then on the two move apart.
local function adoptBagPos()
	local s = QoL.State()
	if s.bagButtonOwn then return end
	s.bagButtonOwn = true
	local p = s.buttonPos
	if type(p) == "table" and s.bagButtonPos == nil then
		s.bagButtonPos = { p[1], p[2], p[3], p[4] + BAG_LIFT }
	end
end

-- Holder position and scale, and the buttons at their sizes in their slots
-- (Buttons.Offsets). The holder takes the button scale too, so the saved
-- offsets and the slot spacing scale with the buttons; its clamp covers
-- every slot of the set and the target list's rows. The bag button on its
-- own spot, at its size and the same scale; the target list's mark and rows
-- beside the target button (Buttons.PlaceList). Secure: run it through
-- QoL.Secure (place), or from code that already is.
local function placeNow()
	local p, s = savedPos(), ns.Get("qol.buttonScale") or 1
	local n = TL.count()
	local at, item = Buttons.Offsets(n), Buttons.Size("item")
	local half = item / 2
	local left, right, top, bottom = 0, 0, 0, 0
	-- A box (x0, x1, y0, y1 from the quest item button's centre) into the clamp.
	local function cover(x0, x1, y0, y1)
		left, right = math.min(left, x0 + half), math.max(right, x1 - half)
		top, bottom = math.max(top, y1 - half), math.min(bottom, y0 + half)
	end
	for kind, o in pairs(at) do
		if kind ~= "bag" then
			local h = Buttons.Size(kind) / 2
			cover(o[1] - h, o[1] + h, o[2] - h, o[2] + h)
		end
	end
	-- And the target list's rows beside the target button.
	local x0, x1, y0, y1 = Buttons.ListRect(n)
	if x0 then
		local t = at.target
		cover(t[1] + x0, t[1] + x1, t[2] + y0, t[2] + y1)
	end
	holder:SetScale(s)
	holder:SetSize(item, item)
	holder:SetClampRectInsets(left, right, top, bottom)
	holder:ClearAllPoints()
	holder:SetPoint(p[1], UIParent, p[2], p[3], p[4])
	for i = 1, #set do
		local b = set[i]
		if b ~= bag then
			local o, size = at[b.psKind], Buttons.Size(b.psKind)
			b:SetScale(s)
			b:SetSize(size, size)
			b:ClearAllPoints()
			b:SetPoint("CENTER", holder, "CENTER", o[1], o[2])
		end
	end
	local bp, size = savedBagPos(), Buttons.Size("bag")
	bag:SetScale(s)
	bag:SetSize(size, size)
	bag:ClearAllPoints()
	bag:SetPoint(bp[1], UIParent, bp[2], bp[3], bp[4])
	for i = 1, #set do placeLabel(set[i]) end
	Buttons.PlaceList(Buttons.target, TL.anchor, TL.rows, s)
end

local function place()
	QoL.Secure("place", placeNow)
	-- An Above name follows whether the bag button stands over the set.
	if relabel then relabel() end
end

-- The frame a drag carries (the holder, or the bag button) and where its
-- spot is saved.
local moving
local function stopMoving()
	local f = moving
	if not f then return end
	moving = nil
	f:StopMovingOrSizing()
	local point, _, relPoint, x, y = f:GetPoint(1)
	if point then QoL.State()[f == bag and "bagButtonPos" or "buttonPos"] = { point, relPoint, x, y } end
	if relabel then relabel() end
end
-- Fires before lockdown begins: a drag still going stops while the set may move.
ns.RegisterEvent("PLAYER_REGEN_DISABLED", stopMoving)

-- Mouse clicks and drags. The secure click handler (SecureActionButton_OnClick)
-- acts on the press when the button's useOnKeyDown attribute (nil: the
-- ActionButtonUseKeyDown CVar) says so, else on the release; key bindings
-- (CLICK <name>:LeftButton) go through the same handler. Hovering a button
-- out of combat sets it to false before any press, so a mouse click acts on
-- its release whatever order the client runs OnMouseDown and the down-click
-- in, and a drag can start before anything fired. A drag sets it to true, so
-- the drag's release does nothing either. Leaving puts it back to nil (the
-- CVar again, for key bindings); a drag's end does so a frame later, after
-- the release's click, or back to false while the cursor is still on it.
local function useOnKeyDown(b, v)
	QoL.Secure("press:" .. b:GetName(), function() b:SetAttribute("useOnKeyDown", v) end)
end

local function hoverStart(b)
	if not QoL.InLockdown() then useOnKeyDown(b, false) end
end

local function hoverEnd(b)
	if not b.dragging then useOnKeyDown(b, nil) end
end

local function onDragStart(b)
	if QoL.InLockdown() then return end
	b.dragging = true
	useOnKeyDown(b, true)
	-- Locked: still a drag, so its release uses nothing, but the set stays.
	if ns.DragLocked() then return end
	moving = b == bag and bag or holder
	moving:StartMoving()
end

local function onDragStop(b)
	stopMoving()
	ns.After(0, function()
		b.dragging = nil
		local over = b:IsMouseOver() and not QoL.InLockdown()
		if over then useOnKeyDown(b, false) else useOnKeyDown(b, nil) end
	end)
end

---------------------------------------------------------------------------
-- The shared look: night panel, hairline (accent on hover), inset icon
---------------------------------------------------------------------------

-- A key's short label on a button, the way the game's action bars read: modifiers as one letter
-- (a, c, s, m), mouse buttons M4, the wheel MwU/MwD; any other key is the client's own (abbreviated)
-- name. The client spells mouse buttons out ("Mouse Button 4"), which ran across the icon (#1211).
local MOD_SHORT = { ALT = "a", CTRL = "c", SHIFT = "s", META = "m" }
function Buttons.KeyText(key)
	if type(key) ~= "string" or key == "" then return nil end
	local mods, base = "", key
	while true do
		local mod, rest = base:match("^(%u+)%-(.+)$")
		if not (mod and MOD_SHORT[mod]) then break end
		mods, base = mods .. MOD_SHORT[mod], rest
	end
	local n = base:match("^BUTTON(%d+)$")
	local text
	if n then
		text = "M" .. n
	elseif base == "MOUSEWHEELUP" then
		text = "MwU"
	elseif base == "MOUSEWHEELDOWN" then
		text = "MwD"
	else
		text = GetBindingText and GetBindingText(base, true) or base
		if type(text) ~= "string" or text == "" then text = base end
	end
	return mods .. text
end

-- The first key that runs `action` in play: with the gamepad interface on, a
-- button bound in its own binding context first (Polestar.Gamepad.BindingKeys).
function Buttons.BindingKey(action)
	local G = ns.Gamepad
	if G and G.BindingKeys then
		for _, key in ipairs(G.BindingKeys(action)) do
			if not G.IsChord(key) then return key end
		end
		return nil
	end
	return GetBindingKey and GetBindingKey(action) or nil
end

local function bindingText(b)
	return Buttons.KeyText(Buttons.BindingKey("CLICK " .. b:GetName() .. ":LeftButton"))
end

local function refreshHotkey(b)
	local t = bindingText(b)
	b.Hotkey:SetText(t or "")
end

-- The label's anchor pair for each qol.buttonTextSide: label point, button point, x, y.
local LABEL_SIDE = {
	right = { "LEFT", "RIGHT", 8, 0 },
	left = { "RIGHT", "LEFT", -8, 0 },
	above = { "BOTTOM", "TOP", 0, 4 },
	below = { "TOP", "BOTTOM", 0, -4 },
}

-- Above sits over the shown buttons stacked on top of b (the quest item
-- button over the target button, the Hearthstone over that, the bag button
-- while it still stands in its old slot over the live set), not in the 8 px
-- gap between them, where it would run into the button above. The stack is
-- b.psStack: the live set, or the settings preview's own buttons; in a row
-- nothing stands over b.
local function bagOverSet()
	local p, bp = savedPos(), savedBagPos()
	return bp[1] == p[1] and bp[2] == p[2] and bp[3] == p[3] and bp[4] == p[4] + BAG_LIFT
end

function placeLabel(b)
	local a = LABEL_SIDE[ns.Get("qol.buttonTextSide")] or LABEL_SIDE.right
	local column = Buttons.Column()
	-- The rare button sits under the target button, whose name has the space
	-- above: a rare's name goes below instead.
	if a == LABEL_SIDE.above and b.psKind == "rare" and column then a = LABEL_SIDE.below end
	local to, stack = b, b.psStack
	if a == LABEL_SIDE.above and stack and column then
		local slot, moved = SLOT[b.psKind], true
		while moved do
			moved = false
			for i = 1, #stack do
				local o = stack[i]
				-- The live bag button counts while it stands in its old slot only.
				local oSlot = SLOT[o.psKind]
				if o == bag and not bagOverSet() then oSlot = nil end
				if oSlot == slot + 1 and o:IsShown() then
					to, slot, moved = o, slot + 1, true
					break
				end
			end
		end
	end
	-- The target button's row of small icons (b.Minis, b.miniCount shown):
	-- right or left, a second line under the name, the pair centred on the
	-- button; above or below, on the name's line after it.
	local mine = b.psKind == "target"
	local rows = mine and (b.miniCount or 0) > 0
	local side = a == LABEL_SIDE.left and "left" or a == LABEL_SIDE.right and "right" or nil
	b.Label:ClearAllPoints()
	b.Label:SetPoint(a[1], to, a[2], a[3], (rows and side) and math.floor(num("buttons.miniSize", 8, 32, MINI) / 2) or a[4])
	if not mine then return end
	local minis = b.Minis
	for k = 1, #minis do
		local m = minis[k]
		m:ClearAllPoints()
		if side == "left" then
			if k == 1 then m:SetPoint("TOPRIGHT", b.Label, "BOTTOMRIGHT", 0, -3) else m:SetPoint("RIGHT", minis[k - 1], "LEFT", -MINI_GAP, 0) end
		elseif side == "right" then
			if k == 1 then m:SetPoint("TOPLEFT", b.Label, "BOTTOMLEFT", 0, -3) else m:SetPoint("LEFT", minis[k - 1], "RIGHT", MINI_GAP, 0) end
		else
			if k == 1 then m:SetPoint("LEFT", b.Label, "RIGHT", 6, 0) else m:SetPoint("LEFT", minis[k - 1], "RIGHT", MINI_GAP, 0) end
		end
	end
end

-- The face of a button of kind ("item", "hearth", "target", "rare", "bag"):
-- ground, inset icon, hover wash, cooldown, count, key and name, and for the
-- target button its action badge and small icons. Regions only, on any
-- Button: the live secure buttons and the settings preview's plain ones
-- (Buttons.NewFace) are drawn by the same code.
local function buildFace(b, kind)
	b.psKind = kind
	local bg = b:CreateTexture(nil, "BACKGROUND")
	bg:SetTexture(media("white"))
	bg:SetAllPoints(b)
	b.Bg = bg

	local icon = b:CreateTexture(nil, "ARTWORK")
	icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	b.Icon = icon

	local hl = b:CreateTexture(nil, "HIGHLIGHT")
	hl:SetTexture(media("white"))
	hl:SetAllPoints(icon)
	b.Hl = hl

	local cd = CreateFrame("Cooldown", nil, b, "CooldownFrameTemplate")
	cd:SetAllPoints(icon)
	b.Cooldown = cd

	local count = b:CreateFontString(nil, "OVERLAY")
	font(count, "number")
	count:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -3, 3)
	b.Count = count

	local hotkey = b:CreateFontString(nil, "OVERLAY")
	font(hotkey, "small")
	-- One line inside the button: a long key name is cut at the edge, never drawn across the label (#1211).
	hotkey:SetPoint("TOPLEFT", b, "TOPLEFT", 3, -3)
	hotkey:SetPoint("TOPRIGHT", b, "TOPRIGHT", -3, -3)
	hotkey:SetJustifyH("LEFT")
	hotkey:SetWordWrap(false)
	b.Hotkey = hotkey

	local label = b:CreateFontString(nil, "OVERLAY")
	font(label, "small")
	b.Label = label

	if kind == "target" or kind == "rare" then
		icon:SetTexture(media("qol-target"))
		icon:SetTexCoord(0, 1, 0, 1)
	end
	if kind == "target" then
		-- The action's glyph in the corner while a face stands in for the icon.
		local badge = b:CreateTexture(nil, "OVERLAY")
		badge:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1)
		badge:Hide()
		b.Badge = badge
		-- The names after the next one, as small icons (placeLabel lays them out).
		b.Minis = {}
		for k = 1, MAX_NAMES - 1 do
			local m = b:CreateTexture(nil, "OVERLAY")
			m:Hide()
			b.Minis[k] = m
		end
	end
end

-- Under combat (from PLAYER_REGEN_DISABLED to PLAYER_REGEN_ENABLED).
local fighting = false

-- The opacity of a button: full under the mouse, else buttons.alpha in
-- combat (inCombat; nil: now), buttons.idleAlpha out of it.
function Buttons.Alpha(inCombat, hover)
	if hover then return 1 end
	if inCombat == nil then inCombat = fighting end
	return num(inCombat and "buttons.alpha" or "buttons.idleAlpha", 0, 1, 1)
end

local function applyAlpha(b)
	b:SetAlpha(Buttons.Alpha(nil, b.psHover))
end

-- An item button's item ready now: in the bags, usable, off cooldown and not
-- out of range.
local function ready(b)
	local id = b.itemID
	if not id or b.tint == "far" or Client.ItemCount(id) == 0 or not Client.ItemUsable(id) then return false end
	local start, duration = Client.ItemCooldown(id)
	return not (duration and duration > 1.5 and start and GetTime and start + duration > GetTime())
end

-- The glow round a button (buttons.glow): a quest item or the Hearthstone
-- ready to use, the rare button while it is up; b.psReady stands in for the
-- preview's. It breathes unless ui.reduceMotion is on. Made on first use.
local function paintGlow(b)
	local kind = b.psKind
	local on = ns.Get("buttons.glow") and (b.psReady or kind == "rare" or ((kind == "item" or kind == "hearth") and ready(b))) or false
	b.psGlowOn = ns.Get("buttons.glow") and true or false
	local g = b.psGlow
	if not on then
		if g then g:Hide() end
		return
	end
	if not g then
		g = b:CreateTexture(nil, "BACKGROUND", nil, -8)
		g:SetTexture(media("glow"))
		g:SetPoint("TOPLEFT", b, "TOPLEFT", -12, 12)
		g:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 12, -12)
		g:SetBlendMode("ADD")
		local pulse = g:CreateAnimationGroup()
		pulse:SetLooping("BOUNCE")
		local fade = pulse:CreateAnimation("Alpha")
		fade:SetFromAlpha(1)
		fade:SetToAlpha(0.35)
		fade:SetDuration(0.8)
		g.psPulse = pulse
		b.psGlow = g
	end
	local T = Theme()
	local own, r, gr, bl, a = ns.Get("buttons.glowColor"), 1, 0.82, 0, 0.9
	if isColor(own) then
		r, gr, bl, a = own[1], own[2], own[3], own[4] or 0.9
	elseif T and T.Accent then
		r, gr, bl = T.Accent()
	end
	g:SetVertexColor(r, gr, bl, a)
	g:Show()
	if ns.Get("ui.reduceMotion") then
		g.psPulse:Stop()
	elseif not g.psPulse:IsPlaying() then
		g.psPulse:Play()
	end
end

-- The text's outline: buttons.labelOutline, or with "auto" the button's own
-- (on: the target's name on its plate).
local OUTLINE = { outline = true, thick = "thick" }
local function outlineLabel(b, auto)
	local T = Theme()
	if not (T and T.SetOutline) then return end
	local v = ns.Get("buttons.labelOutline")
	if v == "theme" then
		T.SetOutline(b.Label, false)
	elseif OUTLINE[v] then
		T.SetOutline(b.Label, OUTLINE[v])
	else
		T.SetOutline(b.Label, auto)
	end
end

-- What a skin's actionButton hook gets of a button (Skin API 2), made the
-- first time a skin hooks the buttons: its parts by the API's own names
-- (glow: the ready glow, nil until it first shows).
local function skinParts(b)
	local p = b.psSkinParts
	if not p then
		p = { ground = b.Bg, icon = b.Icon, highlight = b.Hl, cooldown = b.Cooldown, count = b.Count, hotkey = b.Hotkey,
			label = b.Label, badge = b.Badge }
		b.psSkinParts = p
	end
	p.glow = b.psGlow
	return p
end

-- The skin in use's own touch over Polestar's face, under the mouse or not.
local function skinHook(b)
	local T = Theme()
	if T and T.SkinHooks and T.SkinHooks("actionButton") then
		T.SkinHook("actionButton", b, b.psKind, skinParts(b), b.psHover and true or false)
	end
end

-- The look settings and the theme's colours on a face: backing, border, the
-- icon's inset, the texts (size, outline, which show), the small icons, the
-- glow; then the skin's hook. Plain regions, so at any time, in combat too;
-- size and place are protected (place()).
local paintTarget
local function paintFace(b)
	local T = Theme()
	local bg = b.Bg
	local backing, own = ns.Get("buttons.backing"), ns.Get("buttons.backingColor")
	if backing == "none" then
		bg:Hide()
	else
		bg:Show()
		if isColor(own) then bg:SetVertexColor(own[1], own[2], own[3], own[4] or 1) else color(bg, backing == "dark" and "scrim" or "panel") end
	end
	if T and T.Wash then b.Hl:SetVertexColor(T.Wash("hover")) else b.Hl:SetVertexColor(1, 1, 1, 0.07) end
	local pad = num("buttons.padding", 0, 8, 2)
	b.Icon:ClearAllPoints()
	b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", pad, -pad)
	b.Icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -pad, pad)
	color(b.Count, "text")
	color(b.Hotkey, "textDim")
	b.Count:SetShown(ns.Get("buttons.count") and true or false)
	b.Hotkey:SetShown(ns.Get("buttons.hotkey") and true or false)
	-- The client's countdown numbers, and cooldown-count addons (OmniCC).
	local numbers = ns.Get("buttons.cooldownText") and true or false
	if b.Cooldown.SetHideCountdownNumbers then b.Cooldown:SetHideCountdownNumbers(not numbers) end
	b.Cooldown.noCooldownCount = (not numbers) or nil
	if T and T.SetFontScale then
		T.SetFontScale(b.Label, num("buttons.labelScale", 0.6, 2, 1))
		T.SetFontScale(b.Hotkey, num("buttons.hotkeyScale", 0.6, 2, 1))
	end
	if b.psKind == "target" then
		local m = num("buttons.miniSize", 8, 32, MINI)
		b.Badge:SetSize(m, m)
		for k = 1, #b.Minis do b.Minis[k]:SetSize(m, m) end
	end
	paintBorder(b, b.psHover)
	paintGlow(b)
	if b.psKind == "target" then
		paintTarget(b)
	else
		if b.psKind == "rare" then color(b.Icon, "quest") end
		color(b.Label, "textDim")
		outlineLabel(b, false)
		placeLabel(b)
	end
	skinHook(b)
end
Buttons.Paint = paintFace

-- A face on a plain Button for the settings window's preview: never a
-- secure template, no scripts, nothing the clicks, the step key or the
-- holder see. Sized by Buttons.Size(kind); the caller fills it (icon, text,
-- b.aList... for the target) and repaints it with Buttons.Paint.
function Buttons.NewFace(parent, kind)
	local b = CreateFrame("Button", nil, parent)
	buildFace(b, kind)
	local size = Buttons.Size(kind)
	b:SetSize(size, size)
	paintFace(b)
	return b
end

-- Hover (border, skin, opacity, tooltip), drag and press handling shared by
-- the buttons and the target list's rows and mark.
local function wire(b, onEnter)
	b:SetScript("OnEnter", function(self)
		self.psHover = true
		-- The game's Quick Keybind Mode takes the hover (QoL/QuickBind.lua).
		if QoL.QuickBind.Hover(self) then return end
		paintBorder(self, true)
		if self.psKind then skinHook(self) end
		applyAlpha(self)
		hoverStart(self)
		if GameTooltip and onEnter then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			onEnter(self, GameTooltip)
			GameTooltip:Show()
		end
	end)
	b:SetScript("OnLeave", function(self)
		self.psHover = nil
		paintBorder(self, false)
		if self.psKind then skinHook(self) end
		applyAlpha(self)
		hoverEnd(self)
		if GameTooltip and GameTooltip:GetOwner() == self then GameTooltip:Hide() end
	end)
	b:SetScript("OnDragStart", onDragStart)
	b:SetScript("OnDragStop", onDragStop)
	-- A step that ends mid-drag hides the button the drag started on.
	b:SetScript("OnHide", function(self) if self.dragging then onDragStop(self) end end)
end

local function newButton(name, kind, onEnter)
	local b = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
	b.psLive = true
	local size = Buttons.Size(kind)
	b:SetSize(size, size)
	b:SetFrameStrata("MEDIUM")
	b:RegisterForClicks("AnyUp", "AnyDown")
	b:RegisterForDrag("LeftButton")
	-- A /reload in combat creates the buttons under lockdown.
	QoL.Secure("init:" .. name, function() if not b.itemID and not b.applied then b:Hide() end end)
	buildFace(b, kind)
	paintFace(b)
	local T = Theme()
	if T and T.OnChanged then T.OnChanged(function() paintFace(b) end) end

	wire(b, onEnter)

	refreshHotkey(b)
	applyAlpha(b)
	return b
end

---------------------------------------------------------------------------
-- Item buttons (quest item, Hearthstone)
---------------------------------------------------------------------------

local function paintItem(b)
	local id = b.itemID
	if not id then return end
	b.Icon:SetTexture(Client.ItemIcon(id) or media("icon-use"))
	local n = Client.ItemCount(id)
	b.Count:SetText(n > 1 and tostring(n) or "")
	local start, duration = Client.ItemCooldown(id)
	if duration and duration > 0 then b.Cooldown:SetCooldown(start, duration) else b.Cooldown:Clear() end
	b.Icon:SetDesaturated(n == 0 or not Client.ItemUsable(id))
	if b.psGlowOn then paintGlow(b) end
end

-- Range tint: red out of range, white otherwise; and with buttons.glow, the
-- glow as the item comes ready or goes out of range. Runs only while shown.
local function rangeUpdate(b, elapsed)
	b.rangeElapsed = (b.rangeElapsed or 0) + elapsed
	if b.rangeElapsed < RANGE_INTERVAL then return end
	b.rangeElapsed = 0
	local id = b.itemID
	if not id then return end
	local inRange = Client.ItemInRange(id)
	if inRange == false then
		if b.tint ~= "far" then
			b.tint = "far"
			color(b.Icon, "danger")
		end
	elseif b.tint ~= "near" then
		b.tint = "near"
		b.Icon:SetVertexColor(1, 1, 1, 1)
	end
	if b.psGlowOn then
		local now = ready(b)
		if now ~= b.psWasReady then
			b.psWasReady = now
			paintGlow(b)
		end
	end
end

local function itemTooltip(b, tip)
	if b.itemID and tip.SetItemByID then tip:SetItemByID(b.itemID) end
	if b.itemID and b.itemID == b.glowID then tip:AddLine(L["You can take the quest this item starts. Click to read it."], 1, 1, 1, true) end
	tip:AddLine(ns.Get("ui.lockHud") and L["Shift-drag to move."] or L["Drag to move."], 0.6, 0.6, 0.6)
end

local function newItemButton(name, kind)
	local b = newButton(name, kind, itemTooltip)
	b:SetScript("OnUpdate", ns.Safe(rangeUpdate))
	return b
end

-- The glow round a quest-starting item from the bags (QoL/QuestLoot.lua):
-- the soft glow in the accent, behind the button, pulsing unless
-- ui.reduceMotion. A texture, so it may change in combat; it follows the
-- item the button holds, never the one waiting for combat to end.
local GLOW_SCALE = 1.8
local function paintGlow(b)
	local on = b.itemID ~= nil and b.itemID == b.glowID
	local g = b.questGlow
	if not on then
		if g then
			if g.Pulse then g.Pulse:Stop() end
			g:Hide()
		end
		return
	end
	if not g then
		g = b:CreateTexture(nil, "BACKGROUND", nil, -1)
		g:SetPoint("CENTER", b, "CENTER", 0, 0)
		g:SetTexture(media("glow"))
		if g.SetBlendMode then g:SetBlendMode("ADD") end
		if g.CreateAnimationGroup then
			local ag = g:CreateAnimationGroup()
			ag:SetLooping("BOUNCE")
			local a = ag:CreateAnimation("Alpha")
			a:SetFromAlpha(1)
			a:SetToAlpha(0.35)
			a:SetDuration(0.7)
			g.Pulse = ag
		end
		b.questGlow = g
	end
	-- At the button's own size (the Buttons page's per-kind sizes).
	local glow = Buttons.Size(b.psKind or "item") * GLOW_SCALE
	g:SetSize(glow, glow)
	color(g, "accent")
	g:Show()
	if g.Pulse then
		if ns.Get("ui.reduceMotion") then g.Pulse:Stop() elseif not g.Pulse:IsPlaying() then g.Pulse:Play() end
	end
end

-- Apply the wanted item (secure) and repaint. glowID: the item glows while
-- the button holds it (a quest starter from the bags).
local function applyItem(b, itemID, glowID)
	b.wantID = itemID
	b.glowID = glowID
	QoL.Secure("item:" .. b:GetName(), function()
		local id = b.wantID
		b:SetAttribute("type", id and "item" or nil)
		b:SetAttribute("item", id and ("item:" .. id) or nil)
		b.itemID = id
		b.tint = nil
		if id then
			paintItem(b)
			b:Show()
		else
			b:Hide()
		end
		paintGlow(b)
	end)
	if b.itemID then paintItem(b) end
	paintGlow(b)
end

-- Usable item from a quest's log entry (e.g. a quest's special item).
local function logItem(questID)
	local Q = C_QuestLog
	if not (Q and Q.GetLogIndexForQuestID and GetQuestLogSpecialItemInfo) then return nil end
	local index = Q.GetLogIndexForQuestID(questID)
	if not index then return nil end
	return Client.ItemIDFromLink((GetQuestLogSpecialItemInfo(index)))
end

-- The open quests of the current step (reused).
local openQuests, openCount = {}, 0

-- First usable quest-class item in the bags that one of the step's open
-- quests handed over (Bethor's Potion, Thule Ravenclaw's reward, is none of
-- them); nil without Polestar.QuestDB, which knows what each quest hands over.
local function bagQuestItem()
	local QDB = ns.QuestDB
	if openCount == 0 or not (QDB and QDB.IsLoaded and QDB.IsLoaded() and QDB.HandsOver) then return nil end
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			local id = info and info.itemID
			if id and Client.ItemClass(id) == Client.CLASS_QUEST and Client.ItemSpell(id) then
				for i = 1, openCount do
					if QDB.HandsOver(openQuests[i], id) then return id end
				end
			end
		end
	end
	return nil
end

-- Item for the quest item button, or nil. view, raw: QoL.CurrentStep()'s,
-- when the caller has them. When the step has none: the "While you're here"
-- line's (Engine.GetWhileHere), its use goal's item or its quest's log item.
function Buttons.ChooseQuestItem(view, raw)
	if not view then view, raw = QoL.CurrentStep() end
	if not view then return nil end
	local goals = view.goals or {}
	for g = 1, #goals do
		local gv = goals[g]
		if gv.t == "use" and QoL.Open(gv) then
			local item = gv.item or (raw and raw[g] and raw[g].item)
			if item and Client.ItemCount(item) > 0 then return item end
		end
	end
	openCount = 0
	for g = 1, #goals do
		local gv = goals[g]
		if gv.quest and QoL.Open(gv) and gv.t ~= "accept" then
			openCount = openCount + 1
			openQuests[openCount] = gv.quest
			local item = logItem(gv.quest)
			if item and Client.ItemCount(item) > 0 then return item end
		end
	end
	local bag = bagQuestItem()
	if bag then return bag end
	local E = ns.Engine
	local here = E and E.GetWhileHere and E.GetWhileHere()
	if not (here and here.quest) then return nil end
	local rg = E.AlongGoal and E.AlongGoal(here.step, here.index)
	local item = here.t == "use" and (here.item or (rg and rg.item)) or nil
	if item and Client.ItemCount(item) > 0 then return item end
	item = logItem(here.quest)
	if item and Client.ItemCount(item) > 0 then return item end
	return nil
end

-- On a flight neither button nor the step key offers an item: the client
-- refuses item spells on a taxi and has no call that says which item would
-- work there (the Hearthstone button stayed up all the way when a player
-- flew instead of hearthing).
local function onTaxi()
	return ns.Compat.IsOnTaxi()
end

-- The Hearthstone can be used now: in the bags, and not on a flight.
local function canHearth()
	return Client.ItemCount(Client.HEARTHSTONE) > 0 and not onTaxi()
end

function Buttons.WantsHearth(view)
	if not view then view = QoL.CurrentStep() end
	if not view then return false end
	local goals = view.goals or {}
	for g = 1, #goals do
		if goals[g].t == "hearth" and QoL.Open(goals[g]) then return canHearth() end
	end
	return false
end

---------------------------------------------------------------------------
-- Target button
---------------------------------------------------------------------------

-- Goals done with an NPC: the target button names their NPCs on a step with
-- no mob to target, and the step key targets them by name.
local NPC_VERBS = { accept = true, turnin = true, talk = true, train = true, vendor = true, buy = true, sethome = true, getfp = true, learn = true }

-- The picture of what you do with a name: its goal's verb glyph (Media/UI).
-- An elite, rare or boss mob wears the skull instead (Buttons.TargetLook).
local VERB_ICON = {
	kill = "icon-kill", collect = "icon-collect", use = "icon-use", accept = "icon-accept", turnin = "icon-turnin", talk = "icon-talk",
	train = "icon-train", vendor = "icon-vendor", buy = "icon-buy", sethome = "icon-sethome", getfp = "icon-getfp", learn = "icon-learn",
}

-- The names (reused), and for each its goal's verb, its NPC id (nil when
-- not known) and whether the guide's data marks it elite, rare or a boss.
local names, nameVerb, nameNpc, nameSpecial, nameSeen = {}, {}, {}, {}, {}
-- Each open goal's names, in its own order, with their ids and marks, the
-- goal's verb, step and index, and how far each has been taken (reused).
local goalNames, goalIds, goalMarks, goalVerb, goalStep, goalIndex, goalPos, goalCount = {}, {}, {}, {}, {}, {}, {}, 0
-- TL.info: what the target list shows beside each name (reused; the first
-- goal that names it fills it in, later ones only what it lacks): { npc =
-- creature id, item = item name, chance = %, progress = its goal's have/need
-- count }.

-- A name the button may put after "/targetexact": a string with no control
-- characters. Names come from guide packs, which anyone can write, and a line
-- break would start a second macro line ("/run ...") that runs on the click.
function Buttons.MacroSafeName(n)
	return type(n) == "string" and n ~= "" and not n:find("%c")
end

-- TL.progress, TL.item: the goal being read's have/need count ({ cur, max })
-- and the item it collects, for TL.info; TL.keep: only the refresh's
-- TargetNames fills TL.info in. TL.cap: how many names TargetNames gives (the
-- target list asks for more).

local function newGoal(verb, s, g)
	TL.progress, TL.item = nil, nil
	goalCount = goalCount + 1
	goalNames[goalCount] = wipe(goalNames[goalCount] or {})
	goalIds[goalCount] = wipe(goalIds[goalCount] or {})
	goalMarks[goalCount] = wipe(goalMarks[goalCount] or {})
	goalVerb[goalCount], goalStep[goalCount], goalIndex[goalCount], goalPos[goalCount] = verb, s, g, 1
end

local function addName(n, id, special, chance)
	if not Buttons.MacroSafeName(n) then return end
	local list = goalNames[goalCount]
	local k = #list + 1
	list[k] = n
	goalIds[goalCount][k] = id or false
	goalMarks[goalCount][k] = special and true or false
	if not TL.keep then return end
	local info = TL.info[n]
	if not info then
		TL.info[n] = { npc = id, item = TL.item, chance = chance, progress = TL.progress }
		return
	end
	-- A later source of the same mob fills in what the first one lacked: a
	-- kill target that also drops the step's item shows the item.
	if not info.npc then info.npc = id end
	if not info.progress then info.progress = TL.progress end
	if not info.item and TL.item then info.item, info.chance = TL.item, chance
	elseif not info.chance and info.item == TL.item then info.chance = chance end
end

-- A collect's dominant source (`fromId`) with its rank (`fromRank`: 1 elite,
-- 2 rare elite, 3 boss, 4 rare) marks that one creature.
local function rankedSource(rg, id)
	return id ~= nil and (tonumber(rg.fromRank) or 0) > 0 and rg.fromId == id
end

-- Droppers as { id, name, chance } records, or as names with the records
-- beside them in meta (QuestDB.GetObjectiveMobs).
local function addDroppers(list, rg, meta)
	if type(list) ~= "table" then return end
	for i = 1, #list do
		local e = list[i]
		if type(e) == "table" then
			addName(e.name, e.id, rankedSource(rg, e.id), e.chance)
		else
			local m = type(meta) == "table" and meta[i] or nil
			addName(e, m and m.id, rankedSource(rg, m and m.id), m and m.chance)
		end
	end
end

-- A goal's `fromNpcs` entry (raw goal rg), in the client's language by its id.
local function addSource(e, rg)
	if type(e) ~= "table" then return end
	local N = ns.Names
	addName((N and N.Npc(e.npc)) or e.npcName, e.npc, rankedSource(rg, e.npc))
end

-- The places in `fromNpcs` of the mobs at the spot the arrow takes for raw
-- goal rg (`fromNpcsAt`: per spot in `spots` order, "1,2;3;;4";
-- Engine.SpotIndexOf), most spawns first, or nil (a reused list).
local spotAt = {}
local function spotSources(rg)
	local packed = type(rg) == "table" and rg.fromNpcsAt
	if type(packed) ~= "string" then return nil end
	local E = ns.Engine
	local at = E and E.SpotIndexOf and E.SpotIndexOf(rg)
	if not at then return nil end
	local k = 0
	for group in (packed .. ";"):gmatch("([^;]*);") do
		k = k + 1
		if k == at then
			wipe(spotAt)
			for n in group:gmatch("%d+") do spotAt[#spotAt + 1] = tonumber(n) end
			return spotAt[1] and spotAt or nil
		end
	end
	return nil
end

-- A goal the target button names mobs for: a kill, a collect, or a `use`
-- whose item works on creatures the guide's data names (`fromNpcs`, #1614).
local function mobGoal(gv, rg)
	return gv.t == "kill" or gv.t == "collect" or (gv.t == "use" and type((rg or gv).fromNpcs) == "table")
end

-- The goal the arrow points at, among the goals from `from` on, moves to
-- their front (it keeps its own names' order): its names come first, then
-- the others' in order.
local function arrowFirst(from)
	local E = ns.Engine
	local wp = E and E.GetWaypoint and E.GetWaypoint()
	if type(wp) ~= "table" or wp.goalIndex == nil then return end
	for i = from + 1, goalCount do
		if goalStep[i] == wp.stepIndex and goalIndex[i] == wp.goalIndex then
			local n, ids, marks, verb, s, g = goalNames[i], goalIds[i], goalMarks[i], goalVerb[i], goalStep[i], goalIndex[i]
			for j = i, from + 1, -1 do
				goalNames[j], goalIds[j], goalMarks[j] = goalNames[j - 1], goalIds[j - 1], goalMarks[j - 1]
				goalVerb[j], goalStep[j], goalIndex[j] = goalVerb[j - 1], goalStep[j - 1], goalIndex[j - 1]
			end
			goalNames[from], goalIds[from], goalMarks[from], goalVerb[from], goalStep[from], goalIndex[from] = n, ids, marks, verb, s, g
			return
		end
	end
end

-- The mobs of one open kill, collect or use goal (view gv, raw rg) into the
-- goal newGoal started last. qdb: Polestar.QuestDB when it is loaded.
local function addGoalNames(gv, rg, qdb)
	local N = ns.Names
	local src = rg.fromNpcs or gv.fromNpcs
	local p = gv.progress
	TL.progress = type(p) == "table" and p.kind == "count" and p or nil
	if gv.t == "kill" then
		-- /targetexact needs the name as the client writes it. Elite
		-- work (compiled `group`) marks the mob.
		local id = rg.npc or gv.npc
		local group = rg.group or gv.party
		addName((N and N.Npc(id)) or rg.target or gv.subject, id, type(group) == "table" and group.kind == "elite")
		-- Every other creature its objective credits (#1614).
		for i = 1, type(src) == "table" and #src or 0 do addSource(src[i], rg) end
		return
	end
	if gv.t == "use" then
		-- The creatures the item works on: those the quest's objective credits
		-- (Kodo Roundup's Aged, Dying and Ancient Kodos, #1614).
		for i = 1, type(src) == "table" and #src or 0 do addSource(src[i], rg) end
		return
	end
	-- The item a row shows, in the client's language where Polestar.Names has it.
	TL.item = (N and N.Item and N.Item(gv.item or rg.item)) or gv.itemName or rg.itemName
	-- The mobs the arrow leads to come first: the farm spot the engine
	-- chose (`collect … nearest`), then the guide's own sources for this
	-- point (`fromNpcs`). The item's droppers follow, and stand alone for
	-- a goal with neither: they are ranked by drop chance over the whole
	-- world, so for an item many creatures drop the best of them are
	-- mostly in other zones.
	local npc = gv.npc or rg.npc
	if npc then addName((N and N.Npc(npc)) or gv.npcName or rg.npcName, npc, rankedSource(rg, npc)) end
	-- Spots holding other mobs than the point (`fromNpcsAt`: Centaur Bounty's
	-- run through every centaur tribe's camps, #1616): the spot the arrow
	-- takes names its own mobs, which stand alone; the point's and the item's
	-- droppers are other camps' mobs.
	local here = type(src) == "table" and spotSources(rg)
	if here then
		local before = #goalNames[goalCount]
		for i = 1, #here do addSource(src[here[i]], rg) end
		if #goalNames[goalCount] > before then return end
	end
	for i = 1, type(src) == "table" and #src or 0 do addSource(src[i], rg) end
	if qdb then
		if gv.quest and rg.oi and qdb.GetObjectiveMobs then
			local mobs, meta = qdb.GetObjectiveMobs(gv.quest, rg.oi)
			addDroppers(mobs, rg, meta)
		elseif (gv.item or rg.item) and qdb.GetItemDroppers then
			addDroppers(qdb.GetItemDroppers(gv.item or rg.item), rg)
		end
	end
end

local function loadedQuestDB()
	local QDB = ns.QuestDB
	return QDB and QDB.IsLoaded and QDB.IsLoaded() and QDB or nil
end

-- The goals from `from` on into out (with their verbs, ids and marks, by
-- index): one name from each in order, then the next from each, up to
-- nameCap in all, never a name in seen.
local function interleave(from, out, verbs, ids, marks, seen)
	local more = true
	while more and #out < TL.cap do
		more = false
		for i = from, goalCount do
			local list, p = goalNames[i], goalPos[i]
			while list[p] and seen[list[p]] do p = p + 1 end
			if list[p] and #out < TL.cap then
				seen[list[p]] = true
				local k = #out + 1
				out[k], verbs[k], ids[k], marks[k] = list[p], goalVerb[i], goalIds[i][p] or nil, goalMarks[i][p]
				p = p + 1
				more = true
			end
			goalPos[i] = p
		end
	end
end

-- The open kill and collect rows While you're here shows now
-- (Engine.GetWhileHereList: nearest first, none while the rows are hidden),
-- each a goal after the ones started, with its raw goal (Engine.AlongGoal).
-- skip: a row already started (hereAimed's).
local function addHereGoals(qdb, skip)
	local E = ns.Engine
	if not (E and E.GetWhileHereList and E.AlongGoal) then return end
	for _, v in ipairs(E.GetWhileHereList()) do
		if v ~= skip and (v.t == "kill" or v.t == "collect") and QoL.Open(v) then
			newGoal(v.t, v.step, v.index)
			addGoalNames(v, E.AlongGoal(v.step, v.index) or v, qdb)
		end
	end
end

-- The open kill or collect row of While you're here the arrow points at
-- (the player clicked it: Engine.AimWhileHere), or nil.
local function hereAimed()
	local E = ns.Engine
	if not (E and E.GetWhileHereList and E.GetWaypoint) then return nil end
	local wp = E.GetWaypoint()
	if type(wp) ~= "table" or wp.goalIndex == nil then return nil end
	for _, v in ipairs(E.GetWhileHereList()) do
		if v.step == wp.stepIndex and v.index == wp.goalIndex then
			return (v.t == "kill" or v.t == "collect") and QoL.Open(v) and v or nil
		end
	end
	return nil
end

-- The places of the step's open NPC goals (talk, accept, turn in...) as
-- world points (reused): npcSpots fills them, npcsFar reads them (#1623).
local npcPts, npcPtN = {}, 0
local function npcSpots(goals, raws, own)
	npcPtN = 0
	local C = ns.Compat
	for g = 1, own do
		local gv = goals[g]
		local rg = raws and raws[g] or gv
		if QoL.Open(gv) and NPC_VERBS[gv.t] then
			local p = gv.map and gv or rg
			local c, wx, wy = C.MapToWorld(p.map, p.x, p.y, p.f)
			if c then
				npcPtN = npcPtN + 1
				local pt = npcPts[npcPtN] or {}
				npcPts[npcPtN] = pt
				pt[1], pt[2], pt[3] = c, wx, wy
			end
		end
	end
end

-- Whether the player stands farther than the While you're here radius
-- (behavior.whileHereRadius) from every place npcSpots found: false with
-- none, or while the player's place is unknown.
local function npcsFar()
	if npcPtN == 0 then return false end
	local pc, px, py = ns.Compat.GetPlayerWorldPosition()
	if not pc then return false end
	local r = tonumber(ns.Get("behavior.whileHereRadius")) or 180
	for i = 1, npcPtN do
		local pt = npcPts[i]
		if pt[1] == pc and (pt[2] - px) ^ 2 + (pt[3] - py) ^ 2 <= r * r then return false end
	end
	return true
end

-- Set by the target button's and the step key's names while a step's NPCs
-- and the While you're here rows' mobs share them: npcsFar() as they were
-- ordered by, so a walk across the radius re-orders them (Buttons' refresh
-- watches it); nil when no such list is up.
local farWatch = nil

-- Reverses entries i..j of each list in place (nil entries included).
local function reverse(i, j, ...)
	for l = 1, select("#", ...) do
		local t = select(l, ...)
		local a, b = i, j
		while a < b do
			t[a], t[b] = t[b], t[a]
			a, b = a + 1, b - 1
		end
	end
end

-- Entries 1..k of each list (n in all) move behind entries k+1..n, each part
-- in its own order.
local function moveBehind(k, n, ...)
	if k <= 0 or k >= n then return end
	reverse(1, k, ...)
	reverse(k + 1, n, ...)
	reverse(1, n, ...)
end

-- What the list shows beside name (the last TargetNames call with info), or nil.
function Buttons.TargetInfo(name)
	return TL.info[name]
end

-- Names for the target button (reused lists): one from each open goal in
-- guide order, the arrow's goal first, then the next from each, up to cap
-- (default MAX_NAMES; the target list asks for qol.targetRows, at most
-- TL.MAX), so a goal with many mobs (five creatures drop the Nightsaber
-- Fang) cannot crowd out the goals after it. view, raw: QoL.CurrentStep()'s,
-- when the caller has them. npcs: on a step with no mob to name, the step's
-- own NPC goals' NPCs (the target button; the step key and its loot check
-- want mobs only). here: after the step's own mobs (or with none), the mobs
-- of the While you're here rows the same way, nearest row first (the
-- arrow's row first). After the step's NPCs too, while the player is within
-- the While you're here radius of one of them; farther from all of them,
-- the rows' mobs come first and the NPCs after (#1441, #1623). A row the
-- arrow points at (the player clicked it) comes before the step's own goals:
-- the player chose to go and do it (#2011). -> names,
-- verbs, npc ids (nil: not known), marks (true: elite, rare or boss by the
-- guide's data), all by index. info: the target list's own call (the
-- refresh); only it sets what Buttons.TargetInfo has for each name, so the
-- step key's and the interact stage's calls leave the rows' records be.
function Buttons.TargetNames(view, raw, npcs, here, cap, info)
	TL.cap = math.max(1, math.min(TL.MAX, math.floor(tonumber(cap) or MAX_NAMES)))
	TL.keep = info and true or false
	wipe(names)
	wipe(nameVerb)
	wipe(nameNpc)
	wipe(nameSpecial)
	wipe(nameSeen)
	if TL.keep then wipe(TL.info) end
	goalCount = 0
	if not view then view, raw = QoL.CurrentStep() end
	if not view then
		TL.keep = false
		return names, nameVerb, nameNpc, nameSpecial
	end
	local qdb = loadedQuestDB()
	local E = ns.Engine
	local stepIndex = view.index or (E and E.GetStepIndex and E.GetStepIndex())
	-- The step's goals, then the Along the way list's (along steps and
	-- pinned quests, #644: Engine.GetAlong), each with its raw goal.
	local goals, raws = view.goals or {}, raw
	local own = #goals
	if E and E.GetAlong and E.AlongGoal then
		local all, allRaw = {}, {}
		for g = 1, #goals do all[g], allRaw[g] = goals[g], raw and raw[g] or goals[g] end
		for _, s in ipairs(E.GetAlong()) do
			for _, gv in ipairs(s.goals) do
				all[#all + 1] = gv
				allRaw[#all] = E.AlongGoal(gv.step, gv.index) or gv
			end
		end
		goals, raws = all, allRaw
	end
	local named = false
	-- The While you're here row the player aimed the arrow at, first (#2011).
	local aimed = here and E and E.AlongGoal and hereAimed()
	if aimed then
		newGoal(aimed.t, aimed.step, aimed.index)
		addGoalNames(aimed, E.AlongGoal(aimed.step, aimed.index) or aimed, qdb)
		named = #goalNames[goalCount] > 0
	end
	for g = 1, #goals do
		local gv = goals[g]
		local rg = raws and raws[g] or gv
		if QoL.Open(gv) and mobGoal(gv, rg) then
			if g <= own then newGoal(gv.t, stepIndex, g) else newGoal(gv.t, gv.step, gv.index) end
			addGoalNames(gv, rg, qdb)
			named = named or #goalNames[goalCount] > 0
		end
	end
	-- No mob to name: the NPCs of the step's own talk, accept, turn-in...
	-- goals, in the client's language by their ids where Polestar.Names has
	-- them.
	local npcNamed = false
	if npcs and not named then
		goalCount, aimed = 0, nil
		local N = ns.Names
		for g = 1, own do
			local gv = goals[g]
			local rg = raws and raws[g] or gv
			if QoL.Open(gv) and NPC_VERBS[gv.t] then
				newGoal(gv.t, stepIndex, g)
				local id = gv.npc or rg.npc
				addName((id and N and N.Npc(id)) or gv.npcName or rg.npcName, id)
				npcNamed = npcNamed or #goalNames[goalCount] > 0
			end
		end
	end
	arrowFirst(1)
	interleave(1, names, nameVerb, nameNpc, nameSpecial, nameSeen)
	if here then
		local first, before = goalCount + 1, #names
		addHereGoals(qdb, aimed)
		arrowFirst(first)
		interleave(first, names, nameVerb, nameNpc, nameSpecial, nameSeen)
		if npcNamed and #names > before then
			npcSpots(goals, raws, own)
			farWatch = npcsFar()
			if farWatch then moveBehind(before, #names, names, nameVerb, nameNpc, nameSpecial) end
		end
	end
	TL.keep = false
	return names, nameVerb, nameNpc, nameSpecial
end

-- The mobs of the While you're here rows alone, the way TargetNames adds
-- them (own reused lists): for the step key (#1316).
local hereNames, hereVerb, hereNpc, hereSpecial, hereSeen = {}, {}, {}, {}, {}
function Buttons.HereNames()
	wipe(hereNames)
	wipe(hereVerb)
	wipe(hereNpc)
	wipe(hereSpecial)
	wipe(hereSeen)
	TL.keep, TL.cap = false, MAX_NAMES
	goalCount = 0
	addHereGoals(loadedQuestDB())
	arrowFirst(1)
	interleave(1, hereNames, hereVerb, hereNpc, hereSpecial, hereSeen)
	return hereNames, hereVerb, hereNpc, hereSpecial
end

-- NPCs: "exists" out of combat, not "help": a neutral NPC (Booty Bay,
-- Gadgetzan) is no unit you can assist, and /cleartarget then /targetexact
-- have made the target that NPC. In a fight the target is not cleared, so
-- only one you cannot attack is marked, never the mob you are fighting.
local MARK_UNIT = { mob = "[@target,harm,nodead]", npc = "[@target,exists,nodead,nocombat][@target,noharm,nodead]" }
local MARK_KEY = { mob = "qol.markMob", npc = "qol.markNpc" }
local MARK_DEFAULT = { mob = 8, npc = 1 }
local OTHER = { mob = "npc", npc = "mob" }
-- Presses with a cycling mark: one count for both kinds, so when both cycle
-- an NPC's icon is not the next mob's.
local presses = 0

-- A mark setting as an icon 1-8, "cycle", or the kind's default.
local function markSetting(kind)
	local v = ns.Get(MARK_KEY[kind])
	if v == "cycle" then return v end
	v = tonumber(v)
	return v and v >= 1 and v <= 8 and v == math.floor(v) and v or MARK_DEFAULT[kind]
end

-- A client flag as true or false: false when the API is missing, nil when
-- the value is secret (Forever hides some in combat).
local function flag(fn, ...)
	if not fn then return false end
	local v = fn(...)
	if ns.Compat.IsSecret(v) then return nil end
	return v and true or false
end

-- Who may set an icon now. Alone, a party's leader, a raid's leader or
-- assistant: "set". Another party member: "free" -- anyone in a party can
-- set icons, so only a unit with none yet gets one and someone else's mark
-- is never replaced. A raid member without lead or assist: nil, no icon.
-- A secret value reads as the cautious answer.
function Buttons.MarkRight()
	local raid = flag(IsInRaid)
	local group = raid or flag(IsInGroup)
	if raid == false and group == false then return "set" end
	if flag(UnitIsGroupLeader, "player") then return "set" end
	if raid == false then return "free" end
	return flag(UnitIsGroupAssistant, "player") and "set" or nil
end

-- The /tm line for kind ("mob" or "npc"), nil while marking is off or not
-- allowed (Buttons.MarkRight). A fixed icon uses "!", so pressing again
-- never takes it off; "~" instead while only an unmarked unit may get one
-- (the client's /tm: "!n" skips a unit that has icon n, "~n" one that has
-- any). "cycle" puts the next icon on at each press, skipping the one the
-- other kind keeps, always with "~": a unit that already has an icon keeps
-- it. In combat the macro cannot change, so until the fight ends each press
-- puts on the same icon.
function Buttons.MarkLine(kind)
	if not kind or not QoL.On("markTarget") then return nil end
	local right = Buttons.MarkRight()
	if not right then return nil end
	local icon = markSetting(kind)
	if icon ~= "cycle" then return "/tm " .. MARK_UNIT[kind] .. (right == "set" and " !" or " ~") .. icon end
	local other, icons = markSetting(OTHER[kind]), {}
	for i = 1, 8 do
		if i ~= other then icons[#icons + 1] = i end
	end
	return "/tm " .. MARK_UNIT[kind] .. " ~" .. icons[presses % #icons + 1]
end

-- After a press with kind's mark: true when the next press puts on a new icon.
local function nextMark(kind)
	if not kind or not QoL.On("markTarget") or markSetting(kind) ~= "cycle" or not Buttons.MarkRight() then return false end
	presses = presses + 1
	return true
end

-- The /ping line after a mob's /targetexact, so the group sees where it is
-- (behind rocks or a building): the client's own command word (SLASH_PING1;
-- a localized client has its own) on the target. With no target the client
-- sends nothing for "[@target]". nil on a client without the command.
function Buttons.PingLine()
	local cmd = SLASH_PING1
	if type(cmd) ~= "string" or not cmd:find("^/[^%s%c]+$") then return nil end
	return cmd .. " [@target]"
end

-- The Target button's and step key's ping: only with "Ping what they target"
-- (qol.pingTarget, off by default), and never from a raid member without
-- lead or assist (Buttons.MarkRight nil: the raid's own callouts are theirs).
-- The rare button and the rare card always ping: a rare is worth one.
function Buttons.QuestPingLine()
	if not QoL.On("pingTarget") or not Buttons.MarkRight() then return nil end
	return Buttons.PingLine()
end

-- The macro for names, tried from names[preferred] on in click order. Out of
-- combat it starts from nothing ("/cleartarget [nocombat]"), so a target that
-- is none of the names -- a mob clicked by hand, the quest giver just turned
-- in to -- cannot stop the chain, and a press that finds no name marks
-- nothing; in a fight the target is left alone, since clearing it would cut
-- melee swings and Auto Shot. A plain /targetexact takes the nearest match,
-- corpse or not, so each line is followed by "/cleartarget [dead]", and every
-- later name is tried only while nothing is targeted ("[noexists]"): the
-- first living match is kept. A name that is not MacroSafeName never becomes
-- a line. ping: a /ping line (Buttons.PingLine) after the names; mark: a /tm
-- line (Buttons.MarkLine) for the end. Names past MACRO_LIMIT are dropped
-- from the end; the preferred name, the ping and the mark stay.
function Buttons.TargetMacro(list, preferred, mark, ping)
	local n = #list
	if n == 0 then return nil end
	local order = {}
	for k = 0, n - 1 do
		local name = list[(preferred - 1 + k) % n + 1]
		if Buttons.MacroSafeName(name) then order[#order + 1] = name end
	end
	local count = #order
	if count == 0 then return nil end
	local tail = (ping and ("\n" .. ping) or "") .. (mark and ("\n" .. mark) or "")
	local text
	repeat
		local lines = { "/cleartarget [nocombat]" }
		for k = 1, count do
			lines[#lines + 1] = (k == 1 and "/targetexact " or "/targetexact [noexists] ") .. order[k]
			lines[#lines + 1] = "/cleartarget [dead]"
		end
		text = concat(lines, "\n") .. tail
		count = count - 1
	until #text <= MACRO_LIMIT or count == 0
	return text
end

-- The rare alert card's Target button (Rares/Toast.lua): the one rare, the
-- ping, and the mob's mark while "Mark what they target" is on (and allowed:
-- Buttons.MarkRight). nil for a name that cannot be a macro line or does not
-- fit.
function Buttons.RareCardMacro(name)
	if not Buttons.MacroSafeName(name) then return nil end
	local text = Buttons.TargetMacro({ name }, 1, Buttons.MarkLine("mob"), Buttons.PingLine())
	if not text or #text > MACRO_LIMIT then return nil end
	return text
end

-- list, verbs, ids, marks: the names and what Buttons.TargetNames says of
-- each (copies); namesSig: the names alone, for the chat note; info: name
-- -> the record Buttons.TargetInfo had for it; foldFirst: the name a
-- folded row's macro tries first (one that came close); rowsFolded: the fold
-- the rows last took (applyRows).
local target = { list = {}, verbs = {}, ids = {}, marks = {}, sig = nil, namesSig = "", cycle = 1, info = {}, foldFirst = nil }

-- The mark and ping the target button's name i (default: the one the next
-- click tries first) takes: "npc" for an NPC goal's name, else "mob".
local function targetKind(i)
	return NPC_VERBS[target.verbs[i or target.cycle]] and "npc" or "mob"
end

-- The single button that cycles (qol.targetSimple) instead of the list.
local function simple() return QoL.On("targetSimple") end

-- Names seen in the world (the target, the mouseover, a nameplate) as an
-- elite, rare or boss this session, and the faces of the names seen: one
-- texture per name on the target button, SetPortraitTexture'd once, laid
-- over the icon or a small icon while that name shows (at most
-- PORTRAIT_CAP; the oldest is drawn over for a new one).
local seenSpecial, portraits, portraitOrder = {}, {}, {}
local ELITE_CLASS = { elite = true, rareelite = true, rare = true, worldboss = true }

local function codexSpecial(id)
	local C = ns.Codex
	if not (id and C and C.IsLoaded and C.IsLoaded() and C.Npc) then return false end
	local n = C.Npc(id)
	return n ~= nil and (n.elite or n.rare or n.boss) and true or false
end

-- What the button shows for a name: glyph (Media/UI), colour token, and
-- whether its face may stand in for the glyph. An NPC goal's verb in
-- success (friendly); an elite, rare or boss (the guide's data, the Codex
-- when loaded, or seen so this session) the skull in quest gold, with its
-- face; any other mob its verb in danger (hostile).
function Buttons.TargetLook(verb, name, id, special)
	if NPC_VERBS[verb] then return VERB_ICON[verb], "success", true end
	if special or (name and seenSpecial[name]) or codexSpecial(id) then return "icon-elite", "quest", true end
	return VERB_ICON[verb] or "icon-kill", "danger", false
end

-- The face kept for name, or nil.
function Buttons.Portrait(name)
	return name and portraits[name] or nil
end

local function portraitFor(b, name)
	local tex = portraits[name]
	if tex then return tex end
	if #portraitOrder >= PORTRAIT_CAP then
		local old = table.remove(portraitOrder, 1)
		tex = portraits[old]
		portraits[old] = nil
	else
		tex = b:CreateTexture(nil, "ARTWORK", nil, 1)
	end
	tex:Hide()
	portraits[name] = tex
	portraitOrder[#portraitOrder + 1] = name
	return tex
end

-- Repaint the target button from what its macro does now (b.aList at
-- b.aCycle): plain textures and text, so at any time, in combat too.
-- Without qol.targetPlate: the crosshair and the name in textDim. The
-- settings preview's face (b.psLive unset) shows glyphs only: the faces
-- seen are the live button's textures.
function paintTarget(b)
	local list, cycle = b.aList, b.aCycle or 1
	local n = list and #list or 0
	local name = list and list[cycle]
	-- Beside the list the rows show the names, not the button.
	b.Label:SetText((simple() or not b.psLive) and name or "")
	if b.psLive then
		for _, tex in pairs(portraits) do tex:Hide() end
	end
	local shown = 0
	if not (name and QoL.On("targetPlate")) then
		b.Icon:SetTexture(media("qol-target"))
		color(b.Icon, "danger")
		b.Icon:Show()
		b.Badge:Hide()
		font(b.Label, "small")
		color(b.Label, "textDim")
		outlineLabel(b, false)
	else
		local glyph, tone, face = Buttons.TargetLook(b.aVerbs[cycle], name, b.aIds[cycle], b.aMarks[cycle])
		local tex = face and b.psLive and portraits[name]
		if tex then
			tex:ClearAllPoints()
			tex:SetAllPoints(b.Icon)
			tex:Show()
			b.Icon:Hide()
			b.Badge:SetTexture(media(glyph))
			color(b.Badge, tone)
			b.Badge:Show()
		else
			b.Icon:SetTexture(media(glyph))
			color(b.Icon, tone)
			b.Icon:Show()
			b.Badge:Hide()
		end
		-- On the game world: the label size, outlined like the transparent window.
		font(b.Label, "label")
		color(b.Label, tone)
		outlineLabel(b, true)
		for k = 1, math.min(n - 1, #b.Minis) do
			local j = (cycle - 1 + k) % n + 1
			local m = b.Minis[k]
			local g2, t2, face2 = Buttons.TargetLook(b.aVerbs[j], list[j], b.aIds[j], b.aMarks[j])
			local tex2 = face2 and b.psLive and portraits[list[j]]
			m:SetTexture(media(g2))
			color(m, t2)
			if tex2 then
				tex2:ClearAllPoints()
				tex2:SetAllPoints(m)
				tex2:Show()
				m:Hide()
			else
				m:Show()
			end
			shown = k
		end
	end
	for k = shown + 1, #b.Minis do b.Minis[k]:Hide() end
	b.miniCount = shown
	placeLabel(b)
end


-- applyTarget: the target button and the list (secure: it runs through
-- QoL.Secure), defined with the rows.
local applyTarget

-- The target list's rows and mark, in a block of their own: this file is at
-- Lua's limit of 200 locals. What the rest of the file uses of them is on TL.
do
	-- The list folded to one row (the Polestar mark's left-click), per character.
	local function folded() return QoL.State().targetFolded and true or false end

	-- Defined with the rows below; the faces repaint a folded row's text.
	local paintText, paintCounts

	---------------------------------------------------------------------------
	-- Target list: a row per name beside the target button
	---------------------------------------------------------------------------

	-- The row's second line: the item the mob drops for the step; withChance
	-- (the row's tooltip) adds its drop chance when the data has one.
	local function rowNote(info, withChance)
		if not (info and info.item) then return nil end
		local c = withChance and info.chance
		if type(c) ~= "number" or c <= 0 then return info.item end
		local pct = c >= 10 and string.format("%d%%", math.floor(c + 0.5)) or (string.format("%.1f", c):gsub("%.0$", "") .. "%")
		return L["%s · %s"]:format(info.item, pct)
	end

	-- A row's colours: its name in its kind's colour as the simple button's
	-- plate has it (Buttons.TargetLook: success for an NPC, quest gold for an
	-- elite, rare or boss, danger for a mob; r.looks, set with the macro, read
	-- each paint so a mob seen to be elite turns gold at once); the
	-- crosshair green while one is close (r.closeUnit; a preview's r.psNear),
	-- else danger for a mob and textDim for an NPC, who is not hostile; the
	-- count in success once complete.
	local function paintTones(r)
		local look = r.looks and r.applied and r.looks[r.applied]
		local tone = look and select(2, Buttons.TargetLook(look[1], r.applied, look[2], look[3])) or "danger"
		color(r.Name, tone)
		color(r.Note, "textDim")
		color(r.Mark, (r.closeUnit or r.psNear) and "success" or (tone == "success" and "textDim" or "danger"))
		local p = r.info and r.info.progress
		local cur, max = p and tonumber(p.cur), p and tonumber(p.max)
		color(r.Count, cur and max and max > 0 and cur >= max and "success" or "text")
	end

	-- Faces: a close living mob's own portrait (the target, or a mob with a
	-- nameplate), else the creature's model by id, else the crosshair. Plain
	-- textures and a model, so they change in combat too.
	local FACE_UNITS = { "target" }
	for i = 1, 40 do FACE_UNITS[#FACE_UNITS + 1] = "nameplate" .. i end
	local closeByName = {}

	-- Close living mobs by name (reused); a unit the client keeps secret is
	-- passed over. Every value is checked with IsSecret before any test on it:
	-- testing a secret one throws.
	local function closeUnits()
		wipe(closeByName)
		-- A client or harness without these just has no close mob.
		if not (UnitExists and UnitIsDead and UnitIsPlayer and UnitName) then return closeByName end
		local secret = ns.Compat.IsSecret
		for _, unit in ipairs(FACE_UNITS) do
			local exists = UnitExists(unit)
			if not secret(exists) and exists then
				local dead, player, name = UnitIsDead(unit), UnitIsPlayer(unit), UnitName(unit)
				if not (secret(dead) or secret(player) or secret(name)) and not dead and not player
					and name and not closeByName[name] then
					closeByName[name] = unit
				end
			end
		end
		return closeByName
	end

	-- A row's green state (near): the wash, the green edge (paintBorder) and,
	-- turning green with flash set, one flash, unless motion is reduced.
	local function setNear(r, near, flash)
		if near then
			r.Near:Show()
			if flash and r.psPulse and not ns.Get("ui.reduceMotion") then
				r.Flash:Show()
				r.psPulse:Stop()
				r.psPulse:Play()
			end
		else
			r.Near:Hide()
			if r.psPulse then r.psPulse:Stop() end
			r.Flash:Hide()
		end
		paintBorder(r, r.psHover)
	end

	local function paintRowFace(r, units)
		local unit = units[r.applied]
		local m = r.Model
		-- The unit that makes the row close, so its death repaints it.
		r.closeUnit = unit
		-- The crosshair behind the face: green while a living one is close
		-- enough to target (paintTones).
		paintTones(r)
		local near = unit ~= nil
		if near ~= (r.near == true) then
			r.near = near
			setNear(r, near, true)
		end
		if r.npc and m.SetCreature then
			r.Face:SetTexture(nil)
			-- A model that was hidden is loaded again: the client may drop it.
			if m.npc ~= r.npc or not m:IsShown() then
				m:Show()
				m.npc = r.npc
				m:SetCreature(r.npc)
				if m.SetPortraitZoom then m:SetPortraitZoom(1) end
			end
			r.face = "model"
		elseif unit and SetPortraitTexture then
			-- No id for a model: the close mob's own portrait.
			m:Hide()
			r.face = unit
			SetPortraitTexture(r.Face, unit, true)
			r.Face:SetVertexColor(1, 1, 1, 1)
		else
			m:Hide()
			r.face = nil
			r.Face:SetTexture(nil)
		end
	end

	-- A folded row's macro holds only the names that fit in a macro. The first
	-- of the list that comes close is put first in a new macro, so the click
	-- targets the one the row shows; out of combat (a frame later, never from
	-- inside a secure run), in a fight once it ends.
	local refold = QoL.Coalesce(function() if Buttons.target then applyTarget(Buttons.target) end end)

	local function paintFaces()
		if not (TL.rows[1] and TL.rows[1].applied) then return end
		local units = closeUnits()
		-- A folded row shows the first of its macro's names that is close, else
		-- its first: plain text and textures, so it follows in combat too.
		local r1 = TL.rows[1]
		if r1.names then
			local close
			for k = 1, #r1.all do
				if units[r1.all[k]] then
					close = r1.all[k]
					break
				end
			end
			if close then
				if r1.names[1] ~= close and target.foldFirst ~= close then
					target.foldFirst = close
					refold()
				end
			elseif target.foldFirst then
				-- None close any more: back to the list's own order.
				target.foldFirst = nil
				refold()
			end
			local pick = r1.names[1]
			for k = 1, #r1.names do
				if units[r1.names[k]] then
					pick = r1.names[k]
					break
				end
			end
			if pick ~= r1.applied then
				r1.applied, r1.info = pick, r1.infos[pick]
				paintText(r1)
				paintCounts()
			end
		end
		for i = 1, #TL.rows do
			if TL.rows[i].applied then paintRowFace(TL.rows[i], units) end
		end
	end
	local paintFacesSoon = QoL.Coalesce(paintFaces)
	for _, event in ipairs({ "PLAYER_TARGET_CHANGED", "NAME_PLATE_UNIT_ADDED", "NAME_PLATE_UNIT_REMOVED", "UNIT_NAME_UPDATE" }) do
		ns.RegisterEvent(event, paintFacesSoon)
	end
	-- A mob that dies stays the target (or keeps its nameplate a moment), and no
	-- event above says so; its health does. Only for a unit that makes a row close.
	ns.RegisterEvent("UNIT_HEALTH", function(_, unit)
		unit = ns.Compat.Readable(unit)
		if not unit then return end
		for i = 1, #TL.rows do
			if TL.rows[i].applied and TL.rows[i].closeUnit == unit then return paintFacesSoon() end
		end
	end)

	-- A goal's have/need count ("3/8"), or nil.
	local function countText(info)
		local p = info and info.progress
		local cur, max = p and tonumber(p.cur), p and tonumber(p.max)
		if not (cur and max and max > 0) then return nil end
		return cur .. "/" .. max
	end

	-- The rows' counts, with the name and the item line stopping short of them.
	-- Plain text: it follows every kill and loot, in combat too.
	-- A row's name and item line from r.applied and r.info.
	paintText = function(r)
		local note = rowNote(r.info)
		-- The id the list holds for the name (r.looks), else the name's record's.
		local look = r.looks and r.applied and r.looks[r.applied]
		r.npc = (look and look[2]) or (r.info and r.info.npc) or nil
		r.Name:SetText(r.applied or "")
		r.Note:SetText(note or "")
		paintTones(r)
		r.Name:ClearAllPoints()
		if note then
			r.Name:SetPoint("BOTTOMLEFT", r.Face, "RIGHT", 6, 1)
		else
			r.Name:SetPoint("LEFT", r.Face, "RIGHT", 6, 0)
		end
	end

	local function paintCount(r)
		local text = r.applied and countText(r.info)
		r.Count:SetText(text or "")
		paintTones(r)
		if text then
			r.Name:SetPoint("RIGHT", r.Count, "LEFT", -6, 0)
			r.Note:SetPoint("RIGHT", r.Count, "LEFT", -6, 0)
		else
			r.Name:SetPoint("RIGHT", r, "RIGHT", -6, 0)
			r.Note:SetPoint("RIGHT", r, "RIGHT", -6, 0)
		end
	end

	paintCounts = function()
		for i = 1, #TL.rows do paintCount(TL.rows[i]) end
	end

	-- The rows' names, macros and visibility from the target list (secure:
	-- callers run it through QoL.Secure). Each row targets its own name, with
	-- the target button's mark and ping for its kind (#2036: a skull on a mob,
	-- a star on an NPC goal's NPC with qol.markTarget, on by default; the ping
	-- with qol.pingTarget, off by default, on both).
	-- Defined below; the rows are made when a list first needs them.
	local newRow

	local function applyRows()
		local list = simple() and {} or target.list
		-- The fold the rows took: in a fight the mark's click changes the
		-- setting at once, the rows only after it.
		target.rowsFolded = folded()
		-- Made here (out of combat, in the button's secure run) as the list first
		-- needs them, so a player who never sees the list, or only a short one,
		-- never carries the rest.
		for i = #TL.rows + 1, math.min(#list, TL.MAX) do TL.rows[i] = newRow(i) end
		-- Each name takes its own kind's mark and ping (targetKind).
		local function markPing(k)
			local kind = targetKind(k)
			return kind, Buttons.MarkLine(kind), Buttons.QuestPingLine()
		end
		local fold = folded() and #list > 1
		for i = 1, #TL.rows do
			local r, name, text, kind = TL.rows[i], list[i], nil, nil
			r.names, r.all, r.infos, r.looks = nil, nil, nil, {}
			if fold then
				-- Folded: the first row tries the names in the list's order, as the
				-- target button does, from one that came close (target.foldFirst),
				-- and keeps the names its macro holds (a macro fits about four).
				if i == 1 then
					local first = 1
					for k = 1, #list do
						if list[k] == target.foldFirst then first = k end
					end
					local mark, ping
					kind, mark, ping = markPing(first)
					text = Buttons.TargetMacro(list, first, mark, ping)
					if text and #text > MACRO_LIMIT then text = nil end
					if text then
						local n = select(2, text:gsub("/targetexact", ""))
						r.names, r.all, r.infos = {}, {}, {}
						for k = 1, #list do
							r.all[k] = list[k]
							r.infos[list[k]] = target.info[list[k]]
						end
						for k = 1, n do
							local at = (first - 2 + k) % #list + 1
							r.names[k] = list[at]
							r.looks[list[at]] = { target.verbs[at], target.ids[at], target.marks[at] }
						end
						name = r.names[1]
					end
				end
			elseif name then
				local mark, ping
				kind, mark, ping = markPing(i)
				r.looks[name] = { target.verbs[i], target.ids[i], target.marks[i] }
				text = Buttons.TargetMacro({ name }, 1, mark, ping)
				if text and #text > MACRO_LIMIT then text = nil end
			end
			r:SetAttribute("type", text and "macro" or nil)
			r:SetAttribute("macrotext", text)
			r.applied = text and name or nil
			-- The mark the row's click puts on (Buttons.AdvanceMark).
			r.kind = r.applied and kind or nil
			-- The row keeps the record of the name it targets: in a fight the list
			-- can move on while the row still targets the old name.
			r.info = r.applied and target.info[name] or nil
			paintText(r)
			if r.applied then r:Show() else r:Hide() end
		end
		paintCounts()
		paintFaces()
		-- The rare button moves to clear the rows (in place's own secure run, as
		-- a nested QoL.Secure would change its queue while it is being run).
		placeNow()
	end

	local function rowTooltip(r, tip)
		tip:SetText(r.applied or "")
		local info = r.info
		local note = rowNote(info, true)
		local count = countText(info)
		if note and count then note = L["%s · %s"]:format(note, count) end
		if note or count then tip:AddLine(note or count, 1, 1, 1) end
		if r.all and #r.all > 1 then
			tip:AddLine(L["Folded: targets the first of %d names that is close. Left-click the Polestar mark to show them all."]:format(#r.all), 1, 1, 1, true)
		end
		tip:AddLine(ns.Get("ui.lockHud") and L["Click to target it. Shift-drag to move."]
			or L["Click to target it. Drag to move."], 0.6, 0.6, 0.6)
	end

	-- A row's face: ground, the green wash and its flash, the crosshair, the
	-- portrait (and, live, the creature's model over it), the hover wash, the
	-- name, the count and the item line. Regions only, on any Button: the
	-- live secure rows and the settings previews' plain ones
	-- (Buttons.NewListFaces) are drawn by the same code. plain: no model.
	local function buildRow(r, plain)
		r.psKind = "targetRow"
		r:SetSize(TL.W, TL.H)
		local bg = r:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(media("white"))
		bg:SetAllPoints(r)
		r.Bg = bg

		-- A green wash over the row while one is close enough to target.
		local near = r:CreateTexture(nil, "BACKGROUND", nil, 1)
		near:SetTexture(media("white"))
		near:SetAllPoints(r)
		near:Hide()
		r.Near = near

		-- The flash a row starts green with: bright, then fading into the wash.
		local flash = r:CreateTexture(nil, "BACKGROUND", nil, 2)
		flash:SetTexture(media("white"))
		flash:SetAllPoints(r)
		flash:Hide()
		r.Flash = flash
		if flash.CreateAnimationGroup and not plain then
			-- Two blinks, then the flash fades into the wash.
			local pulse = flash:CreateAnimationGroup()
			local function step(order, from, to, seconds)
				local a = pulse:CreateAnimation("Alpha")
				a:SetOrder(order)
				a:SetFromAlpha(from)
				a:SetToAlpha(to)
				a:SetDuration(seconds)
			end
			step(1, 1, 0.15, 0.25)
			step(2, 0.15, 1, 0.2)
			step(3, 1, 0, 0.6)
			pulse:SetScript("OnFinished", function() flash:Hide() end)
			flash.Pulse, r.psPulse = pulse, pulse
		end

		local mark = r:CreateTexture(nil, "ARTWORK", nil, -1)
		mark:SetSize(TL.FACE, TL.FACE)
		mark:SetPoint("LEFT", r, "LEFT", 2, 0)
		mark:SetTexture(media("qol-target"))
		r.Mark = mark

		local face = r:CreateTexture(nil, "ARTWORK")
		face:SetSize(TL.FACE, TL.FACE)
		face:SetPoint("LEFT", r, "LEFT", 2, 0)
		r.Face = face

		-- Over the crosshair: a creature whose model is not loaded yet leaves it seen.
		if not plain then
			local model = CreateFrame("PlayerModel", nil, r)
			model:SetAllPoints(face)
			model:Hide()
			r.Model = model
		end

		local hl = r:CreateTexture(nil, "HIGHLIGHT")
		hl:SetTexture(media("white"))
		hl:SetAllPoints(r)
		r.Hl = hl

		local name = r:CreateFontString(nil, "OVERLAY")
		font(name, "body")
		name:SetJustifyH("LEFT")
		if name.SetWordWrap then name:SetWordWrap(false) end
		r.Name = name

		-- The goal's have/need count, at the row's right edge.
		local count = r:CreateFontString(nil, "OVERLAY")
		font(count, "number")
		count:SetJustifyH("RIGHT")
		count:SetPoint("RIGHT", r, "RIGHT", -6, 0)
		r.Count = count

		local note = r:CreateFontString(nil, "OVERLAY")
		font(note, "small")
		note:SetJustifyH("LEFT")
		if note.SetWordWrap then note:SetWordWrap(false) end
		note:SetPoint("TOPLEFT", face, "RIGHT", 6, -1)
		note:SetPoint("RIGHT", r, "RIGHT", -6, 0)
		r.Note = note
		-- What a skin's actionButton hook gets (Skin API 2; skinParts).
		r.psSkinParts = { ground = bg, icon = face, highlight = hl, label = name, count = count, note = note,
			crosshair = mark, wash = near, flash = flash }
	end

	-- The Polestar mark's face: ground, the logo, the hover wash, and the key
	-- name Quick Keybind Mode writes. Regions only, as buildRow's.
	local function buildMark(a)
		a.psKind = "targetMark"
		local bg = a:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(media("white"))
		bg:SetAllPoints(a)
		a.Bg = bg

		local logo = a:CreateTexture(nil, "ARTWORK")
		logo:SetTexture(media("logo"))
		logo:SetPoint("TOPLEFT", a, "TOPLEFT", 3, -3)
		logo:SetPoint("BOTTOMRIGHT", a, "BOTTOMRIGHT", -3, 3)
		a.Icon = logo

		local hl = a:CreateTexture(nil, "HIGHLIGHT")
		hl:SetTexture(media("white"))
		hl:SetAllPoints(logo)
		a.Hl = hl

		-- Empty but in Quick Keybind Mode, which writes the binding's name there
		-- while it shows the mark for binding (Buttons.PlaceList lays it out).
		local label = a:CreateFontString(nil, "OVERLAY")
		font(label, "small")
		a.Label = label
		a.psSkinParts = { ground = bg, icon = logo, highlight = hl, label = label }
	end

	-- The Buttons page's look on a row or the mark, as paintFace puts it on a
	-- button: the ground (buttons.backing, backingColor), the hover wash, the
	-- edge (paintBorder: buttons.border, borderColor, borderSize, hoverColor;
	-- green while one is close), the opacity (buttons.idleAlpha, alpha), the
	-- row's green wash, flash and colours; then the skin's actionButton hook
	-- (kind "targetRow" or "targetMark"). Plain regions: at any time, in
	-- combat too.
	local function paintLook(r)
		local T = Theme()
		local bg, backing, own = r.Bg, ns.Get("buttons.backing"), ns.Get("buttons.backingColor")
		if backing == "none" then
			bg:Hide()
		else
			bg:Show()
			if isColor(own) then bg:SetVertexColor(own[1], own[2], own[3], own[4] or 1) else color(bg, backing == "dark" and "scrim" or "panel") end
		end
		if T and T.Wash then r.Hl:SetVertexColor(T.Wash("hover")) else r.Hl:SetVertexColor(1, 1, 1, 0.07) end
		if r.psKind == "targetRow" then
			color(r.Near, "success", TL.NEAR)
			color(r.Flash, "success", TL.FLASH)
			color(r.Note, "textDim")
			paintTones(r)
		else
			color(r.Label, "textDim")
		end
		paintBorder(r, r.psHover)
		if r.psLive then applyAlpha(r) end
		skinHook(r)
	end

	newRow = function(i)
		local r = CreateFrame("Button", "PolestarTargetRow" .. i, UIParent, "SecureActionButtonTemplate")
		r.psLive = true
		r:SetFrameStrata("MEDIUM")
		r:RegisterForClicks("AnyUp", "AnyDown")
		r:RegisterForDrag("LeftButton")
		-- Made in a secure run (applyRows), which shows it once it has a name.
		r:Hide()
		buildRow(r)
		paintLook(r)
		local T = Theme()
		if T and T.OnChanged then T.OnChanged(function() paintLook(r) end) end
		wire(r, rowTooltip)
		r:HookScript("PostClick", function(self, _, down)
			if down or self.dragging then return end
			Buttons.AdvanceMark(self.kind or "mob")
		end)
		return r
	end

	local function anchorTooltip(a, tip)
		tip:SetText(L["Target list"])
		local key = bindingText(Buttons.target)
		if key then
			tip:AddLine(L["%s targets the first name in the list that is close."]:format(key), 1, 1, 1, true)
		else
			tip:AddLine(L["Bind a key to the target button (Options > Keybindings > Polestar, or hover this mark in Quick Keybind Mode) to target the first name in the list that is close."], 1, 1, 1, true)
		end
		if folded() ~= (target.rowsFolded or false) then
			-- Clicked in a fight: the rows follow when it ends.
			tip:AddLine(folded() and L["The list folds to one row after this fight."] or L["The whole list shows after this fight."], 1, 1, 1, true)
		else
			tip:AddLine(folded() and L["Left-click to show the whole list."] or L["Left-click to fold the list to one row."], 1, 1, 1, true)
		end
		tip:AddLine(ns.Get("ui.lockHud") and L["Right-click for its settings. Shift-drag to move."]
			or L["Right-click for its settings. Drag to move."], 0.6, 0.6, 0.6)
	end

	-- Not secure: it only moves the set and opens the settings.
	local function newAnchor()
		local a = CreateFrame("Button", "PolestarTargetAnchor", UIParent)
		a.psLive = true
		a:SetSize(TL.ANCHOR, TL.ANCHOR)
		a:SetFrameStrata("MEDIUM")
		-- A left-click folds the list to one row or opens it again; only a
		-- right-click opens the settings, so a click meant for a mob (or one in a
		-- fight) never does.
		a:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		a:RegisterForDrag("LeftButton")
		a:Hide()
		buildMark(a)
		paintLook(a)
		local T = Theme()
		if T and T.OnChanged then T.OnChanged(function() paintLook(a) end) end

		wire(a, anchorTooltip)
		a:SetScript("OnClick", function(self, which)
			if self.dragging then return end
			if which == "LeftButton" then
				-- The rows change only out of combat: in a fight the fold waits.
				QoL.State().targetFolded = not folded() or nil
				if Buttons.target then applyTarget(Buttons.target) end
				if GameTooltip and GameTooltip:GetOwner() == self then
					GameTooltip:ClearLines()
					anchorTooltip(self, GameTooltip)
					GameTooltip:Show()
				end
				return
			end
			if which ~= "RightButton" then return end
			if GameTooltip and GameTooltip:GetOwner() == self then GameTooltip:Hide() end
			-- Settings > Questing > Buttons, where Targeting is.
			ns.Fire("SHOW_OPTIONS", "targeting")
		end)
		return a
	end

	-- The target list on plain frames for the settings' previews (the Buttons
	-- page, Install's Targeting page): the Polestar mark and n rows, drawn by
	-- the live list's own code (buildRow, buildMark, paintLook); never a
	-- secure template, no scripts, nothing the clicks or the bindings see.
	-- -> { mark = frame, rows = { frame, ... } }
	function Buttons.NewListFaces(parent, n)
		local f = { mark = CreateFrame("Button", nil, parent), rows = {} }
		buildMark(f.mark)
		for i = 1, n or 3 do
			f.rows[i] = CreateFrame("Button", nil, parent)
			buildRow(f.rows[i], true)
		end
		return f
	end

	-- Paint faces f (Buttons.NewListFaces) as the live list would show
	-- entries[i] = { name, verb, id, elite, item, cur, max, near } and lay them
	-- out beside the target face t (Buttons.PlaceList; side: its, else the
	-- settings'). A row without an entry hides.
	function Buttons.PaintListFaces(f, t, entries, side)
		for i, r in ipairs(f.rows) do
			local e = entries[i]
			if e then
				r.applied = e.name
				r.looks = { [e.name] = { e.verb, e.id, e.elite } }
				r.info = { item = e.item, progress = e.max and { cur = e.cur or 0, max = e.max } or nil }
				r.psNear = e.near and true or nil
				paintText(r)
				paintCount(r)
				setNear(r, r.psNear, false)
				paintLook(r)
				r:Show()
			else
				r:Hide()
			end
		end
		paintLook(f.mark)
		Buttons.PlaceList(t, f.mark, f.rows, nil, side)
	end

	-- Every live row's and the mark's look again (a buttons.* setting, the
	-- opacity as a fight starts or ends).
	function TL.paintLooks()
		for i = 1, #TL.rows do paintLook(TL.rows[i]) end
		if TL.anchor then paintLook(TL.anchor) end
	end

	applyTarget = function(b)
		-- The Polestar mark is not secure: hidden with Polestar (or the guide) at
		-- once, in a fight too; the rows follow once it ends.
		if TL.anchor and not ns.GuideShown() then TL.anchor:Hide() end
		QoL.Secure("target", function()
			local list = target.list
			-- The list keeps its order: only the single button cycles.
			local cycle = simple() and target.cycle or 1
			-- A mob and an NPC goal's NPC are both pinged for the group (Fitz, 2026-11-13).
			local kind = targetKind(cycle)
			local text = Buttons.TargetMacro(list, cycle, Buttons.MarkLine(kind), Buttons.QuestPingLine())
			b:SetAttribute("type", text and "macro" or nil)
			b:SetAttribute("macrotext", text)
			b.applied = list[cycle]
			b.aList, b.aVerbs, b.aIds, b.aMarks, b.aCycle = list, target.verbs, target.ids, target.marks, cycle
			paintTarget(b)
			-- Beside the list the small Polestar mark takes the button's place;
			-- hidden, the button still answers its key binding, like the step key.
			if text and simple() then b:Show() else b:Hide() end
			if TL.anchor then
				-- Quick Keybind Mode reads it (QuickBind's `wanted`).
				TL.anchor.wanted = text ~= nil and not simple()
				if TL.anchor.wanted then TL.anchor:Show() else TL.anchor:Hide() end
			end
			applyRows()
		end)
	end

	TL.newAnchor, TL.paintTones, TL.rowNote, TL.paintCounts = newAnchor, paintTones, rowNote, paintCounts
end

-- A unit in the world (the target, the mouseover, a nameplate) named like
-- one of the target button's names (the new ones, or the ones it shows
-- while combat holds its macro): its classification marks an elite, rare
-- or boss, and its face is kept for that name. A secret value (Forever
-- hides units in combat) reads as unknown and is passed over.
local function listed(list, name)
	for i = 1, list and #list or 0 do
		if list[i] == name then return true end
	end
	return false
end

local function seeUnit(unit)
	local b = Buttons.target
	-- The plate's look, or the list's colours (beside the list the plate is off).
	if not (b and (target.list[1] or (b.aList and b.aList[1])) and (QoL.On("targetPlate") or not simple())) then return end
	local C = ns.Compat
	if not C.Readable(UnitExists and UnitExists(unit)) or C.Readable(UnitIsPlayer and UnitIsPlayer(unit)) ~= false then return end
	local name = C.Readable(UnitName and UnitName(unit))
	if not name or not (listed(target.list, name) or listed(b.aList, name)) then return end
	local changed = false
	local class = UnitClassification and C.Readable(UnitClassification(unit))
	if class and ELITE_CLASS[class] and not seenSpecial[name] then
		seenSpecial[name], changed = true, true
	end
	if not portraits[name] and SetPortraitTexture then
		SetPortraitTexture(portraitFor(b, name), unit)
		changed = true
	end
	if changed then
		paintTarget(b)
		for i = 1, #TL.rows do TL.paintTones(TL.rows[i]) end
	end
end
Buttons.SeeUnit = seeUnit

-- The units there are now: a new list's names may already be in sight.
local function seeAll()
	seeUnit("target")
	seeUnit("mouseover")
	local NP = C_NamePlate
	local plates = NP and NP.GetNamePlates and NP.GetNamePlates()
	for i = 1, plates and #plates or 0 do
		local unit = plates[i].namePlateUnitToken or (plates[i].UnitFrame and plates[i].UnitFrame.unit)
		if type(unit) == "string" then seeUnit(unit) end
	end
end

ns.RegisterEvent("PLAYER_TARGET_CHANGED", function() seeUnit("target") end)
ns.RegisterEvent("UPDATE_MOUSEOVER_UNIT", function() seeUnit("mouseover") end)
ns.RegisterEvent("NAME_PLATE_UNIT_ADDED", function(_, unit) if type(unit) == "string" then seeUnit(unit) end end)

local function targetTooltip(b, tip)
	tip:SetText(L["Target"])
	local locked = ns.Get("ui.lockHud")
	if not simple() then
		tip:AddLine(L["Targets the first name in the list that is close. Click a name to target that one."], 1, 1, 1, true)
		tip:AddLine(locked and L["Shift-drag to move."] or L["Drag to move."], 0.6, 0.6, 0.6)
		return
	end
	local T = Theme()
	local plate = QoL.On("targetPlate")
	for i = 1, #target.list do
		local r, g, bl = 1, 1, 1
		if plate and T and T.Color then
			local _, tone = Buttons.TargetLook(target.verbs[i], target.list[i], target.ids[i], target.marks[i])
			r, g, bl = T.Color(tone)
		end
		tip:AddLine(target.list[i], r, g, bl)
	end
	if QoL.On("markTarget") and target.list[1] then
		local right, icon = Buttons.MarkRight(), markSetting(targetKind())
		icon = icon == "cycle" and L["a new icon each press"]
			or ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_" .. icon .. ":0|t " .. (_G["RAID_TARGET_" .. icon] or icon))
		if right == "set" then
			tip:AddLine(string.format(L["Marks it with %s."], icon), 0.6, 0.6, 0.6, true)
		elseif right == "free" then
			tip:AddLine(string.format(L["Marks it with %s if it has no icon yet: you don't lead the party."], icon), 0.6, 0.6, 0.6, true)
		else
			tip:AddLine(L["Marks nothing: in a raid only the leader and assistants set icons."], 0.6, 0.6, 0.6, true)
		end
	end
	tip:AddLine(locked and L["Click again for the next name. Shift-drag to move."]
		or L["Click again for the next name. Drag to move."], 0.6, 0.6, 0.6)
end

---------------------------------------------------------------------------
-- Rare button
---------------------------------------------------------------------------

local rare = { list = {}, sig = nil, cycle = 1 }

local function isFounder(name)
	local R = ns.Rares
	return R and R.IsFounder and R.IsFounder(name) or false
end

-- The founder's macro: out of combat from nothing, his full name (as
-- Forever's own unit menu targets a surnamed player), then his first name
-- alone while nothing is targeted (Forever's menu falls back to it when the
-- client's regional unique names are off), then a wave: at him, or a plain
-- wave when neither matched. One click, never automatic.
function Buttons.FounderMacro(name)
	if not Buttons.MacroSafeName(name) then return nil end
	local lines = { "/cleartarget [nocombat]", "/targetexact " .. name }
	local first = name:match("^(%S+)%s")
	if first then lines[#lines + 1] = "/targetexact [noexists] " .. first end
	lines[#lines + 1] = "/wave"
	return concat(lines, "\n")
end

-- The macro for the name in front: the founder's, else the rares' from it
-- (the founder left out of their chain).
local function rareMacro(list, cycle)
	local front = list[cycle]
	if isFounder(front) then return Buttons.FounderMacro(front) end
	local rares, preferred = {}, 1
	for i = 1, #list do
		if not isFounder(list[i]) then
			rares[#rares + 1] = list[i]
			if i == cycle then preferred = #rares end
		end
	end
	return Buttons.TargetMacro(rares, preferred, nil, Buttons.PingLine())
end

local function applyRare(b)
	QoL.Secure("rare", function()
		local list = rare.list
		local text = rareMacro(list, rare.cycle)
		b:SetAttribute("type", text and "macro" or nil)
		b:SetAttribute("macrotext", text)
		b.applied = list[rare.cycle]
		b.Label:SetText(b.applied or "")
		if text then b:Show() else b:Hide() end
	end)
end

local function rareTooltip(b, tip)
	tip:SetText(isFounder(b.applied) and L["Target and wave"] or L["Target rare"])
	for i = 1, #rare.list do tip:AddLine(rare.list[i], 1, 1, 1) end
	tip:AddLine(ns.Get("ui.lockHud") and L["Click again for the next name. Shift-drag to move."]
		or L["Click again for the next name. Drag to move."], 0.6, 0.6, 0.6)
end

---------------------------------------------------------------------------
-- Bag button (QoL/Space.lua)
---------------------------------------------------------------------------

local function applyBag(b)
	local Space = QoL.Space
	local j = ns.GuideShown() and Space and Space.Low() and Space.Junk()
	b.junk = j or nil
	if j then
		b.Icon:SetTexture(Client.ItemIcon(j.id) or media("icon-use"))
		b.Icon:SetDesaturated(not Space.Armed())
		b.Count:SetText(tostring((Space.Free())))
		b.Label:SetText(Space.Armed() and L["Press again to delete"] or "")
	end
	QoL.Secure("bag", function()
		if b.junk then b:Show() else b:Hide() end
	end)
end

local function bagTooltip(b, tip)
	local Space = QoL.Space
	local j = b.junk
	local f, t = Space.Free()
	tip:SetText(L["Bag space"])
	tip:AddLine(string.format(L["Free slots: %d of %d"], f, t), 1, 1, 1)
	if j then
		tip:AddLine(string.format(L["Cheapest junk: %s (%s)"], Space.ItemText(j), j.value < math.huge and QoL.Money(j.value) or "?"), 1, 1, 1)
		tip:AddLine(L["Press twice to delete it."], 0.6, 0.6, 0.6)
	end
	tip:AddLine(ns.Get("ui.lockHud") and L["Shift-drag to move."] or L["Drag to move."], 0.6, 0.6, 0.6)
end

---------------------------------------------------------------------------
-- Step key
---------------------------------------------------------------------------

-- One clicked guide name, using the target button's macro and mark settings.
-- The view's chosen NPC wins over the raw goal;
-- collect subjects are items, so only their chosen or named NPC source can
-- be targeted. No world-wide dropper lookup or other goal is consulted.
function Buttons.GuideNameMacro(goal, raw)
	if not QoL.On("guideNameTarget") or type(goal) ~= "table" then return nil end
	raw = type(raw) == "table" and raw or goal
	local t = goal.t
	if t ~= "kill" and t ~= "collect" and not NPC_VERBS[t] then return nil end
	local N = ns.Names
	-- Keep a chosen name with its chosen ID: an unnamed/raw candidate must
	-- not replace the view's named candidate with another localized NPC.
	local chosen = goal.npc ~= nil or goal.npcName ~= nil
	local npc, name
	if chosen then npc, name = goal.npc, goal.npcName else npc, name = raw.npc, raw.npcName end
	name = (npc and N and N.Npc and N.Npc(npc)) or name
	if chosen and not name and t ~= "kill" then return nil end
	if not name then
		if t == "kill" then
			name = goal.subject or raw.target
		elseif t == "collect" then
			local source = goal.source
			if type(source) == "table" then
				if source.kind == "npc" then name = source.name end
			elseif raw.from and (raw.fromKind == nil or raw.fromKind == "npc") then
				name = (raw.fromId and N and N.Npc and N.Npc(raw.fromId)) or raw.from
			end
		end
	end
	if not Buttons.MacroSafeName(name) then return nil end
	local kind = (t == "kill" or t == "collect") and "mob" or "npc"
	local macro = Buttons.TargetMacro({ name }, 1, Buttons.MarkLine(kind))
	-- TargetMacro drops extra names to fit; a single long name cannot be trimmed.
	if not macro or #macro > MACRO_LIMIT then return nil end
	return macro, name, kind
end

-- What the step key does now. view, raw: QoL.CurrentStep()'s, when the
-- caller has them. -> "item", itemID | "target", names (reused list), the
-- one NPC's name among them or nil | "npc", name | nil. The route's own goals come first, in guide order, then
-- the optional ones, so an optional accept never takes the key.
local function stepGoal(view, raw, goals, optional)
	for g = 1, #goals do
		local gv = goals[g]
		local rg = raw and raw[g] or gv
		local isOptional = (rg.optional or gv.optional) and true or false
		if isOptional == optional and QoL.Open(gv) then
			local t = gv.t
			if t == "use" then
				local item = gv.item or rg.item
				if item and Client.ItemCount(item) > 0 and not onTaxi() then return "item", item end
			elseif t == "hearth" then
				if canHearth() then return "item", Client.HEARTHSTONE end
			elseif t == "kill" or t == "collect" then
				-- This goal's own mobs decide; the key then cycles all the step's.
				if #Buttons.TargetNames({ goals = { gv } }, { rg }) > 0 then return "target", Buttons.TargetNames(view, raw) end
			elseif NPC_VERBS[t] then
				-- A name that is not MacroSafeName is passed over, like no name.
				local name = gv.npcName or rg.npcName
				if Buttons.MacroSafeName(name) then return "npc", name end
			end
		end
	end
end

local stepNames, stepSeen = {}, {}
function Buttons.StepAction(view, raw)
	-- The open flight map's marked node first: the press flies there.
	local F = QoL.Flight
	local slot = F and F.TakeSlot and F.TakeSlot()
	if slot then return "fly", slot end
	if not view then view, raw = QoL.CurrentStep() end
	if not view then return nil end
	local goals = view.goals or {}
	local kind, value = stepGoal(view, raw, goals, false)
	if not kind then kind, value = stepGoal(view, raw, goals, true) end
	if not kind and not onTaxi() then
		local item = Buttons.ChooseQuestItem(view, raw)
		if item then kind, value = "item", item end
	end
	-- Targeting, or with nothing else to do: the While you're here rows' mobs
	-- after the step's own names (#1316; Buttons.HereNames, the target
	-- button's own helpers). An NPC: the rows' mobs after it, or before it
	-- while the player is beyond the While you're here radius of the step's
	-- NPCs (#1623). An item or the Hearthstone keeps the key.
	if (kind == "target" or kind == "npc" or not kind) and ns.Get("behavior.whileHereStepKey") then
		wipe(stepNames)
		wipe(stepSeen)
		local npc = kind == "npc" and value or nil
		if npc then
			stepNames[1], stepSeen[npc] = npc, true
		else
			for i = 1, kind and #value or 0 do
				stepNames[i], stepSeen[value[i]] = value[i], true
			end
		end
		local before = #stepNames
		local here = Buttons.HereNames()
		for i = 1, #here do
			if not stepSeen[here[i]] then
				stepSeen[here[i]] = true
				stepNames[#stepNames + 1] = here[i]
			end
		end
		if npc and #stepNames > before then
			npcSpots(goals, raw, #goals)
			local far = npcsFar()
			farWatch = far
			if far then moveBehind(before, #stepNames, stepNames) end
			return "target", stepNames, npc
		end
		if not npc and #stepNames > 0 then return "target", stepNames end
	end
	return kind, value
end

-- npc: the one NPC's name in a "target" list (Buttons.StepAction), or nil.
local step = { kind = nil, value = nil, list = {}, npc = nil, sig = nil, cycle = 1 }
-- The mark each kind of step key press puts on.
local STEP_MARK = { target = "mob", npc = "npc" }

-- The mark the step key's next press puts on: in a "target" list, the kind
-- of the name it tries first.
local function stepKind()
	if step.kind == "target" then return step.list[step.cycle] == step.npc and "npc" or "mob" end
	return STEP_MARK[step.kind]
end

local function applyStep(b)
	QoL.Secure("step", function()
		local text, item
		if step.kind == "target" then
			local kind = stepKind()
			text = Buttons.TargetMacro(step.list, step.cycle, Buttons.MarkLine(kind), Buttons.QuestPingLine())
		elseif step.kind == "npc" then
			text = Buttons.TargetMacro({ step.value }, 1, Buttons.MarkLine("npc"), Buttons.QuestPingLine())
		elseif step.kind == "item" then
			item = "item:" .. step.value
		end
		b:SetAttribute("type", item and "item" or text and "macro" or nil)
		b:SetAttribute("item", item)
		b:SetAttribute("macrotext", text)
	end)
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

local itemButton, hearthButton, targetButton, rareButton, stepButton, bagButton

---------------------------------------------------------------------------
-- The step key's interact stage (qol.stepInteract, off by default)
---------------------------------------------------------------------------

-- The quest window open now ("detail", "progress", "complete") and its quest.
local questWin, questWinQuest
-- The quest frame's button each stage presses (Blizzard's QuestFrame).
local QUEST_BUTTONS = { accept = "QuestFrameAcceptButton", continue = "QuestFrameCompleteButton", complete = "QuestFrameCompleteQuestButton" }
local STEP_BINDING = "CLICK PolestarStepButton:LeftButton"

-- An open goal of the step for which test(view goal, raw goal) holds.
local function openGoal(view, raw, test)
	local goals = view.goals or {}
	for g = 1, #goals do
		if QoL.Open(goals[g]) and test(goals[g], raw and raw[g] or goals[g]) then return goals[g] end
	end
	return nil
end

-- What the step key's next press does in place of its own action, or nil:
-- in a quest window of the live step's quest, "accept" (its accept),
-- "continue" or "complete" (its turn-in; with several rewards to choose
-- from, the player picks); else "interact" while the target is the live
-- step's NPC, or the corpse of one of its mobs (loot). Only with the
-- setting, the client's interact binding (BINDING_NAME_INTERACTTARGET), the
-- live step on screen, and never with the gamepad interface.
function Buttons.InteractStage(view, raw)
	if not (QoL.On("stepInteract") and BINDING_NAME_INTERACTTARGET) or ns.GamepadUI() then return nil end
	if not view then view, raw = QoL.CurrentStep() end
	local E = ns.Engine
	if not view or (E and E.GetLiveStep and E.GetLiveStep() ~= E.GetStepIndex()) then return nil end
	if questWin then
		local q = questWinQuest
		if questWin == "detail" then
			return openGoal(view, raw, function(gv) return gv.t == "accept" and gv.quest == q end) and "accept" or nil
		end
		if not openGoal(view, raw, function(gv) return gv.t == "turnin" and gv.quest == q end) then return nil end
		if questWin == "progress" then return "continue" end
		return (GetNumQuestChoices and GetNumQuestChoices() or 0) <= 1 and "complete" or nil
	end
	if not (UnitExists and UnitExists("target")) or (UnitIsPlayer and UnitIsPlayer("target")) then return nil end
	-- A secret name (Forever's combat restrictions) reads as unknown: comparing
	-- one throws (#1182); the NPC id still matches.
	local name = ns.Compat.Readable(UnitName and UnitName("target"))
	if UnitIsDead and UnitIsDead("target") then
		local list = Buttons.TargetNames(view, raw)
		for i = 1, #list do
			if list[i] == name then return "interact" end
		end
		return nil
	end
	if UnitCanAttack and UnitCanAttack("player", "target") then return nil end
	local npc = ns.Compat.GetNpcID("target")
	return openGoal(view, raw, function(gv, rg)
		return NPC_VERBS[gv.t] and ((npc ~= nil and (gv.npc or rg.npc) == npc) or (name ~= nil and (gv.npcName or rg.npcName) == name))
	end) and "interact" or nil
end

-- The step key's keys bound over to the stage's action (override bindings
-- owned by the step button), or back to the step key; out of combat only.
local interactSig = ""
local function applyInteract(stage)
	local keys = { GetBindingKey and GetBindingKey(STEP_BINDING) }
	local sig = stage and (stage .. "\n" .. concat(keys, "\n")) or ""
	if sig == interactSig or not stepButton then return end
	QoL.Secure("stepInteract", function()
		interactSig = sig
		ClearOverrideBindings(stepButton)
		if not stage then return end
		for i = 1, #keys do
			if stage == "interact" then
				SetOverrideBinding(stepButton, true, keys[i], "INTERACTTARGET")
			elseif _G[QUEST_BUTTONS[stage]] then
				SetOverrideBindingClick(stepButton, true, keys[i], QUEST_BUTTONS[stage], "LeftButton")
			end
		end
	end)
end
local refreshInteract = QoL.Coalesce(function() applyInteract(Buttons.InteractStage()) end)

for event, kind in pairs({ QUEST_DETAIL = "detail", QUEST_PROGRESS = "progress", QUEST_COMPLETE = "complete", QUEST_FINISHED = false }) do
	ns.RegisterEvent(event, function()
		questWin = kind or nil
		questWinQuest = kind and GetQuestID and GetQuestID() or nil
		refreshInteract()
	end)
end
for _, event in ipairs({ "PLAYER_TARGET_CHANGED", "PLAYER_REGEN_ENABLED", "UPDATE_BINDINGS", "LOOT_CLOSED" }) do
	ns.RegisterEvent(event, refreshInteract)
end

-- Every targeting entry point shares one mark cycle. Prepared secure macros
-- change only when safe; guide name overlays listen for the new selection.
function Buttons.AdvanceMark(kind)
	if not nextMark(kind) then return false end
	if targetButton then applyTarget(targetButton) end
	if stepButton then applyStep(stepButton) end
	ns.Fire("QOL_TARGET_MARK_CHANGED", kind)
	return true
end

-- While the target button's or the step key's names hold the step's NPCs
-- and the While you're here rows' mobs (farWatch set by them), a check each
-- second: crossing the radius re-orders them (#1623).
local FAR_POLL = 1
local farTicker, farWatched

local function refresh()
	if not itemButton then return end
	-- One view of the current step for all three buttons.
	local view, raw = QoL.CurrentStep()
	farWatch = nil
	local guideShown = ns.GuideShown()
	-- The step's item first; with none, a quest starter from the bags, glowing.
	-- Never on a taxi: the client refuses item spells there (#1583).
	local itemOn = QoL.On("itemButton") and guideShown and not onTaxi()
	local item = itemOn and view and Buttons.ChooseQuestItem(view, raw) or nil
	local QL = QoL.QuestLoot
	local loot = itemOn and not item and QL and QL.Current() or nil
	applyItem(itemButton, item or loot, loot)
	applyItem(hearthButton, QoL.On("hearthButton") and guideShown and view and Buttons.WantsHearth(view) and Client.HEARTHSTONE or nil)

	-- The list shows qol.targetRows names; the single button, the step key
	-- and the interact stage keep MAX_NAMES.
	local cap = not simple() and ns.Get("qol.targetRows") or MAX_NAMES
	local list, verbs, ids, marks
	if QoL.On("targetButton") and guideShown and view then list, verbs, ids, marks = Buttons.TargetNames(view, raw, true, true, cap, true) else list = {} end
	-- The mark settings and who may mark (Buttons.MarkRight) are part of both
	-- signatures, so changing one re-applies.
	local mark = QoL.On("markTarget") and (markSetting("mob") .. " " .. markSetting("npc") .. " " .. tostring(Buttons.MarkRight()) .. "\n") or ""
	-- And the ping (Buttons.QuestPingLine), on or off.
	mark = mark .. (Buttons.QuestPingLine() or "") .. "\n"
	local namesSig = concat(list, "\n")
	-- The list's portraits and notes too, so new data re-applies.
	local parts = { simple() and "simple" or "list", mark }
	for i = 1, #list do
		local info = Buttons.TargetInfo(list[i])
		-- Its verb, mark and id too: a name that turns from an NPC goal's into a
		-- mob's (or an elite) takes the other mark, ping and colour.
		parts[#parts + 1] = list[i] .. "\t" .. tostring(info and info.npc) .. "\t" .. tostring(TL.rowNote(info))
			.. "\t" .. tostring(verbs and verbs[i]) .. "\t" .. tostring(marks and marks[i]) .. "\t" .. tostring(ids and ids[i])
	end
	local sig = concat(parts, "\n")
	if sig ~= target.sig then
		target.sig = sig
		local copy, cv, ci, cm, info = {}, {}, {}, {}, {}
		for i = 1, #list do
			copy[i], cv[i], ci[i], cm[i] = list[i], verbs[i], ids[i], marks[i]
			info[list[i]] = Buttons.TargetInfo(list[i])
		end
		target.list, target.verbs, target.ids, target.marks, target.info = copy, cv, ci, cm, info
		target.cycle = 1
		-- The optional chat note, once per new set of names (not for a mark setting).
		if namesSig ~= target.namesSig then
			target.namesSig = namesSig
			if #copy > 0 and QoL.On("targetAnnounce") then ns.Print(L["Targeting: %s"]:format(concat(copy, ", "))) end
		end
		applyTarget(targetButton)
		seeAll()
	end
	-- Counts change with every kill and loot, and a drop chance can arrive
	-- with the QuestDB after the rows: not in the signature (the count is
	-- painted in combat too, the chance read by the tooltip).
	-- The list's own records: a row shares its name's record while it shows
	-- this list (applyRows), and keeps an older one while a fight holds it on
	-- an earlier step, so that one is left as it was.
	for name, info in pairs(target.info) do
		local fresh = Buttons.TargetInfo(name)
		if fresh then info.progress, info.chance = fresh.progress, fresh.chance end
	end
	TL.paintCounts()

	-- Not tied to the step: a rare can turn up on any of them.
	local R = ns.Rares
	local rares = QoL.On("rareButton") and guideShown and R and R.Nearby and R.Nearby() or {}
	local raresSig = concat(rares, "\n")
	if raresSig ~= rare.sig then
		rare.sig = raresSig
		local copy = {}
		for i = 1, #rares do
			if Buttons.MacroSafeName(rares[i]) then copy[#copy + 1] = rares[i] end
		end
		rare.list = copy
		rare.cycle = 1
		applyRare(rareButton)
	end

	local kind, value, npc = nil, nil, nil
	if view then kind, value, npc = Buttons.StepAction(view, raw) end
	local stepSig = mark .. (kind == "target" and ("target\n" .. tostring(npc) .. "\n" .. concat(value, "\n")) or (tostring(kind) .. "\n" .. tostring(value)))
	if stepSig ~= step.sig then
		step.sig, step.kind, step.npc, step.cycle = stepSig, kind, npc, 1
		local copy = {}
		if kind == "target" then
			for i = 1, #value do copy[i] = value[i] end
		else
			step.value = value
		end
		step.list = copy
		applyStep(stepButton)
	end
	farWatched = farWatch
	if farWatch ~= nil and not farTicker then
		farTicker = ns.NewTicker(FAR_POLL, function()
			if farWatched ~= nil and npcsFar() ~= farWatched then refresh() end
		end)
	elseif farWatch == nil and farTicker then
		farTicker:Cancel()
		farTicker = nil
	end
	applyInteract(Buttons.InteractStage(view, raw))

	applyBag(bagButton)
end
local refreshSoon = QoL.Coalesce(refresh)
Buttons.Refresh = refresh

local function repaintItems()
	if not itemButton then return end
	if itemButton.itemID then paintItem(itemButton) end
	if hearthButton.itemID then paintItem(hearthButton) end
end

local function create()
	if itemButton then return end
	-- Not named: the client's layout cache would save it as well.
	holder = CreateFrame("Frame", nil, UIParent)
	holder:SetSize(SIZE, SIZE)
	holder:SetMovable(true)
	holder:SetClampedToScreen(true)
	itemButton = newItemButton("PolestarQuestItemButton", "item")
	hearthButton = newItemButton("PolestarHearthButton", "hearth")
	-- A starter clicked on the button has been read: the next one takes its place.
	itemButton:HookScript("PostClick", function(self, _, down)
		if down or self.dragging then return end
		local id = self.itemID
		if id and id == self.glowID and QoL.QuestLoot then QoL.QuestLoot.Used(id) end
	end)
	targetButton = newButton("PolestarTargetButton", "target", targetTooltip)
	targetButton:HookScript("PostClick", function(self, _, down)
		if down or self.dragging then return end
		-- Only the single button moves to the next name; the list keeps its order.
		local n = simple() and #target.list or 0
		local kind = targetKind()
		if n > 1 then target.cycle = target.cycle % n + 1 end
		local marked = Buttons.AdvanceMark(kind)
		if n > 1 and not marked then applyTarget(targetButton) end
	end)
	rareButton = newButton("PolestarRareButton", "rare", rareTooltip)
	rareButton:HookScript("PostClick", function(self, _, down)
		if down or self.dragging then return end
		local n = #rare.list
		if n > 1 then
			rare.cycle = rare.cycle % n + 1
			applyRare(rareButton)
		end
	end)
	TL.anchor = TL.newAnchor()
	bagButton = newButton("PolestarBagButton", "bag", bagTooltip)
	bagButton:HookScript("PostClick", function(self, _, down)
		if down or self.dragging then return end
		local Space = QoL.Space
		if Space then Space.Press() end
		applyBag(self)
	end)
	-- On its own spot, moved by its own drag (onDragStart).
	bag = bagButton
	QoL.Secure("init:bagMove", function()
		bagButton:SetMovable(true)
		bagButton:SetClampedToScreen(true)
	end)
	adoptBagPos()
	-- The step key: a binding only, never shown. Press and release both
	-- reach it and useOnKeyDown stays nil, so the player's key-down setting
	-- (ActionButtonUseKeyDown) picks which one acts: once, either way.
	stepButton = CreateFrame("Button", "PolestarStepButton", UIParent, "SecureActionButtonTemplate")
	stepButton:RegisterForClicks("AnyUp", "AnyDown")
	QoL.Secure("init:PolestarStepButton", function() stepButton:Hide() end)
	stepButton:HookScript("PostClick", function(self, _, down)
		if down then return end
		-- No secure action while it flies: the press takes the marked node.
		if step.kind == "fly" then
			QoL.Flight.Take()
			return
		end
		local n = #step.list
		local names = step.kind == "target" and n > 1
		local kind = stepKind()
		if names then step.cycle = step.cycle % n + 1 end
		local marked = Buttons.AdvanceMark(kind)
		if names and not marked then applyStep(self) end
	end)
	Buttons.item, Buttons.hearth, Buttons.target, Buttons.rare, Buttons.step, Buttons.bag = itemButton, hearthButton, targetButton, rareButton, stepButton, bagButton
	Buttons.rows, Buttons.anchor = TL.rows, TL.anchor
	set = { bagButton, hearthButton, itemButton, targetButton, rareButton }
	-- Bindable from the game's Quick Keybind Mode, shown there while hidden
	-- (the step key has no button on screen: Options > Keybindings binds it).
	local QB = QoL.QuickBind
	local useIcon = function() return media("icon-use") end
	QB.Add(itemButton, { force = true, enabled = function() return QoL.On("itemButton") end, icon = useIcon })
	QB.Add(hearthButton, { force = true, enabled = function() return QoL.On("hearthButton") end,
		icon = function() return Client.ItemIcon(Client.HEARTHSTONE) or media("icon-hearth") end })
	-- Beside the list the button is hidden and the Polestar mark in its slot
	-- binds the button's key (the first name in the list that is close).
	QB.Add(targetButton, { force = true, enabled = function() return QoL.On("targetButton") and simple() end })
	QB.Add(TL.anchor, { force = true, enabled = function() return QoL.On("targetButton") and not simple() end,
		command = "CLICK PolestarTargetButton:LeftButton", wanted = function(a) return a.wanted == true end })
	QB.Add(rareButton, { force = true, enabled = function() return QoL.On("rareButton") end })
	QB.Add(bagButton, { force = true, enabled = function() return QoL.On("bagSpace") end,
		wanted = function(b) return b.junk ~= nil end, icon = useIcon })
	-- An Above name moves when a button over it comes or goes.
	local function placeLabels() for i = 1, #set do placeLabel(set[i]) end end
	for i = 1, #set do
		set[i].psStack = set
		set[i]:HookScript("OnShow", placeLabels)
		set[i]:HookScript("OnHide", placeLabels)
	end
	fighting = QoL.InLockdown()
	for i = 1, #set do applyAlpha(set[i]) end
	placeLabels()
	-- place() lays the names out too.
	relabel = placeLabels
	place()
end

-- The opacity in and out of combat: SetAlpha is no protected call, so it
-- changes as the fight starts.
local function combat(on)
	fighting = on
	if not set then return end
	for i = 1, #set do applyAlpha(set[i]) end
	-- The target list's rows and mark with them.
	TL.paintLooks()
end
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function() combat(true) end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function() combat(false) end)

-- The look settings that move or size the buttons (protected: place()).
local PLACE_KEYS = {
	["qol.buttonScale"] = true, ["buttons.itemSize"] = true, ["buttons.hearthSize"] = true, ["buttons.targetSize"] = true,
	["buttons.rareSize"] = true, ["buttons.bagSize"] = true, ["buttons.spacing"] = true, ["buttons.layout"] = true,
}

ns.OnLogin(function()
	create()
	refresh()
end)

QoL.OnStep(refreshSoon)
ns.RegisterEvent("BAG_UPDATE_DELAYED", function()
	repaintItems()
	refreshSoon()
end)
ns.RegisterEvent("QUEST_LOG_UPDATE", refreshSoon)
ns.RegisterEvent("BAG_UPDATE_COOLDOWN", repaintItems)
-- Who may mark (Buttons.MarkRight) follows the group.
ns.RegisterEvent("GROUP_ROSTER_UPDATE", refreshSoon)
ns.RegisterEvent("PARTY_LEADER_CHANGED", refreshSoon)
-- The quest item and Hearthstone buttons go when a flight starts and come
-- back on landing; in combat QoL.Secure holds the change until it ends.
ns.RegisterEvent("PLAYER_CONTROL_LOST", refreshSoon)
ns.RegisterEvent("PLAYER_CONTROL_GAINED", refreshSoon)
ns.RegisterEvent("UPDATE_BINDINGS", function()
	if not itemButton then return end
	refreshHotkey(itemButton)
	refreshHotkey(hearthButton)
	refreshHotkey(targetButton)
	refreshHotkey(rareButton)
	refreshHotkey(bagButton)
end)
ns.On("RARE_NEARBY", refreshSoon)
ns.On("FLIGHT_MARK_CHANGED", refreshSoon)
ns.On("QUESTDB_LOADED", refreshSoon)
ns.On("NAME_LEARNED", refreshSoon)
ns.On("BAG_SPACE", refreshSoon)
ns.On("WHILE_HERE_CHANGED", refreshSoon)
ns.On("QUEST_LOOT_CHANGED", refreshSoon)
-- The target button names the arrow's goal first.
ns.On("WAYPOINT_CHANGED", refreshSoon)
ns.On("SETTING_CHANGED", function(path)
	if not itemButton or type(path) ~= "string" then return end
	local all = path == ""
	if PLACE_KEYS[path] or path == "qol.buttonTextSide" or path == "qol" or path == "buttons" or all then
		place()
	end
	if path:sub(1, 8) == "buttons." or path == "buttons" or path == "ui.reduceMotion" or path == "ui" or all then
		for i = 1, #set do
			paintFace(set[i])
			applyAlpha(set[i])
		end
		TL.paintLooks()
	end
	if path == "qol.buttonTextSide" or path == "qol" or path == "" then
		for i = 1, #set do placeLabel(set[i]) end
	end
	if path == "qol.targetPlate" or path == "qol" or path == "" then
		paintTarget(targetButton)
		seeAll()
	end
	if path:sub(1, 4) == "qol." or path == "qol" or path == "ui.shown" or path == "ui"
		or path == "behavior.whileHereStepKey" or path == "behavior" or path == "" then refreshSoon() end
end)
ns.On("GUIDE_SHOWN", function() if itemButton then refreshSoon() end end) -- an instance hide (ns.GuideShown)

-- Back to the default spots (options button): the set's and the bag button's.
function Buttons.ResetPositions()
	local s = QoL.State()
	s.buttonPos, s.bagButtonPos = nil, nil
	if itemButton then place() end
end

-- Unlock mode (UI/Movers.lua): the holder (nil until the buttons are first
-- made), its spot { point, relPoint, x, y } in its own units, and a new spot
-- (nil: the default) applied as a drag's would be.
function Buttons.Holder() return holder end
-- How many of the target list's rows show beside the target button now
-- (Buttons.Offsets and Buttons.ListRect take it), for Unlock mode's box.
function Buttons.ListRows() return TL.count() end
function Buttons.SavedPos() return savedPos() end
function Buttons.SetPosition(p)
	QoL.State().buttonPos = type(p) == "table" and p or nil
	if itemButton then place() end
end
