-- Action buttons: the quest item button, the Hearthstone button and the
-- target button. Each is a named secure button (bindable as
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
--   Hearthstone: while the current step has an open `hearth` goal.
--   Target: /targetexact for the current step's kill targets and the mobs
--     that drop its collect items (Polestar.QuestDB when loaded); every click
--     moves the next name to the front.
--   Step key: no button on screen, only a binding: the first open goal it can
--     act on, in guide order (a use goal's item, a hearth goal's Hearthstone,
--     a kill or collect's mobs, an NPC goal's NPC by name), else the quest
--     item. Independent of the three buttons' settings.
--
-- The buttons hang off one holder: hearth above the item, target below. A
-- left-drag on any of them moves the set (out of combat); the position is
-- per character, so the Hearthstone button, shown only for hearth goals,
-- appears in its slot of the moved set.

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

local Buttons = {}
QoL.Buttons = Buttons

-- The holder's spot (it sits where the quest item button does) and each
-- button's slot above (+) or below (-) it, GAP button units apart.
local DEFAULT_POS = { "CENTER", "CENTER", 260, -140 }
local GAP = 44
local SLOT = { PolestarHearthButton = 1, PolestarQuestItemButton = 0, PolestarTargetButton = -1 }

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

local function paintBorder(b, hover)
	local T = Theme()
	if not (T and T.Border) then return end
	if hover then
		local r, g, bl = T.Accent()
		T.Border(b, r, g, bl, 1)
	else
		local r, g, bl, a = T.Color("border")
		T.Border(b, r, g, bl, (a or 0.08) * 2.5)
	end
end

---------------------------------------------------------------------------
-- Position and scale (secure)
---------------------------------------------------------------------------

local holder, set

local function savedPos()
	local p = QoL.State().buttonPos
	return type(p) == "table" and p or DEFAULT_POS
end

-- Holder position and scale, and the buttons in their slots. The holder takes
-- the button scale too, so the saved offsets and the slot spacing scale with
-- the buttons.
local function place()
	QoL.Secure("place", function()
		local p, s = savedPos(), ns.Get("qol.buttonScale") or 1
		holder:SetScale(s)
		holder:ClearAllPoints()
		holder:SetPoint(p[1], UIParent, p[2], p[3], p[4])
		for i = 1, #set do
			local b = set[i]
			b:SetScale(s)
			b:ClearAllPoints()
			b:SetPoint("CENTER", holder, "CENTER", 0, SLOT[b:GetName()] * GAP)
		end
	end)
end

local moving = false
local function stopMoving()
	if not moving then return end
	moving = false
	holder:StopMovingOrSizing()
	local point, _, relPoint, x, y = holder:GetPoint(1)
	if point then QoL.State().buttonPos = { point, relPoint, x, y } end
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
	moving = true
	holder:StartMoving()
end

local function onDragStop(b)
	stopMoving()
	C_Timer.After(0, function()
		b.dragging = nil
		local over = b:IsMouseOver() and not QoL.InLockdown()
		if over then useOnKeyDown(b, false) else useOnKeyDown(b, nil) end
	end)
end

---------------------------------------------------------------------------
-- The shared look: night panel, hairline (accent on hover), inset icon
---------------------------------------------------------------------------

local function bindingText(b)
	if not GetBindingKey then return nil end
	local key = GetBindingKey("CLICK " .. b:GetName() .. ":LeftButton")
	if not key then return nil end
	if GetBindingText then return GetBindingText(key, true) end
	return key
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

local function placeLabel(b)
	local a = LABEL_SIDE[ns.Get("qol.buttonTextSide")] or LABEL_SIDE.right
	b.Label:ClearAllPoints()
	b.Label:SetPoint(a[1], b, a[2], a[3], a[4])
end

local function newButton(name, onEnter)
	local b = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
	b:SetSize(SIZE, SIZE)
	b:SetFrameStrata("MEDIUM")
	b:RegisterForClicks("AnyUp", "AnyDown")
	b:RegisterForDrag("LeftButton")
	-- A /reload in combat creates the buttons under lockdown.
	QoL.Secure("init:" .. name, function() if not b.itemID and not b.applied then b:Hide() end end)

	local bg = b:CreateTexture(nil, "BACKGROUND")
	bg:SetTexture(media("white"))
	bg:SetAllPoints(b)
	color(bg, "panel")
	b.Bg = bg

	local icon = b:CreateTexture(nil, "ARTWORK")
	icon:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
	icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
	icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	b.Icon = icon

	local hl = b:CreateTexture(nil, "HIGHLIGHT")
	hl:SetTexture(media("white"))
	hl:SetAllPoints(icon)
	local T = Theme()
	if T and T.Wash then hl:SetVertexColor(T.Wash("hover")) else hl:SetVertexColor(1, 1, 1, 0.07) end

	local cd = CreateFrame("Cooldown", nil, b, "CooldownFrameTemplate")
	cd:SetAllPoints(icon)
	b.Cooldown = cd

	local count = b:CreateFontString(nil, "OVERLAY")
	font(count, "number")
	color(count, "text")
	count:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -3, 3)
	b.Count = count

	local hotkey = b:CreateFontString(nil, "OVERLAY")
	font(hotkey, "small")
	color(hotkey, "textDim")
	hotkey:SetPoint("TOPLEFT", b, "TOPLEFT", 3, -3)
	b.Hotkey = hotkey

	local label = b:CreateFontString(nil, "OVERLAY")
	font(label, "small")
	color(label, "textDim")
	b.Label = label
	placeLabel(b)

	paintBorder(b, false)
	local T = Theme()
	if T and T.OnChanged then
		T.OnChanged(function()
			color(bg, "panel")
			color(count, "text")
			color(hotkey, "textDim")
			color(label, "textDim")
			paintBorder(b, false)
		end)
	end

	b:SetScript("OnEnter", function(self)
		paintBorder(self, true)
		hoverStart(self)
		if GameTooltip and onEnter then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			onEnter(self, GameTooltip)
			GameTooltip:Show()
		end
	end)
	b:SetScript("OnLeave", function(self)
		paintBorder(self, false)
		hoverEnd(self)
		if GameTooltip and GameTooltip:GetOwner() == self then GameTooltip:Hide() end
	end)
	b:SetScript("OnDragStart", onDragStart)
	b:SetScript("OnDragStop", onDragStop)
	-- A step that ends mid-drag hides the button the drag started on.
	b:SetScript("OnHide", function(self) if self.dragging then onDragStop(self) end end)

	refreshHotkey(b)
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
end

-- Range tint: red out of range, white otherwise. Runs only while shown.
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
end

local function itemTooltip(b, tip)
	if b.itemID and tip.SetItemByID then tip:SetItemByID(b.itemID) end
	tip:AddLine(L["Drag to move."], 0.6, 0.6, 0.6)
end

local function newItemButton(name)
	local b = newButton(name, itemTooltip)
	b:SetScript("OnUpdate", rangeUpdate)
	return b
end

-- Apply the wanted item (secure) and repaint.
local function applyItem(b, itemID)
	b.wantID = itemID
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
	end)
	if b.itemID then paintItem(b) end
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
-- when the caller has them.
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
	return bagQuestItem()
end

function Buttons.WantsHearth(view)
	if not view then view = QoL.CurrentStep() end
	if not view then return false end
	local goals = view.goals or {}
	for g = 1, #goals do
		if goals[g].t == "hearth" and QoL.Open(goals[g]) then
			return Client.ItemCount(Client.HEARTHSTONE) > 0
		end
	end
	return false
end

---------------------------------------------------------------------------
-- Target button
---------------------------------------------------------------------------

local names, nameSeen = {}, {}

-- A name the button may put after "/targetexact": a string with no control
-- characters. Names come from guide packs, which anyone can write, and a line
-- break would start a second macro line ("/run ...") that runs on the click.
function Buttons.MacroSafeName(n)
	return type(n) == "string" and n ~= "" and not n:find("%c")
end

local function addName(n)
	if not Buttons.MacroSafeName(n) or nameSeen[n] or #names >= MAX_NAMES then return end
	nameSeen[n] = true
	names[#names + 1] = n
end

local function addDroppers(list)
	if type(list) ~= "table" then return end
	for i = 1, #list do
		local e = list[i]
		addName(type(e) == "table" and e.name or e)
	end
end

-- Names for the target button, in guide order (reused list). view, raw:
-- QoL.CurrentStep()'s, when the caller has them.
function Buttons.TargetNames(view, raw)
	wipe(names)
	wipe(nameSeen)
	if not view then view, raw = QoL.CurrentStep() end
	if not view then return names end
	local QDB = ns.QuestDB
	local qdb = QDB and QDB.IsLoaded and QDB.IsLoaded()
	local goals = view.goals or {}
	for g = 1, #goals do
		local gv = goals[g]
		local rg = raw and raw[g] or gv
		if QoL.Open(gv) then
			if gv.t == "kill" then
				-- /targetexact needs the name as the client writes it.
				local N = ns.Names
				addName((N and N.Npc(rg.npc or gv.npc)) or rg.target or gv.subject)
			elseif gv.t == "collect" and qdb then
				if gv.quest and rg.oi and QDB.GetObjectiveMobs then
					addDroppers(QDB.GetObjectiveMobs(gv.quest, rg.oi))
				elseif (gv.item or rg.item) and QDB.GetItemDroppers then
					addDroppers(QDB.GetItemDroppers(gv.item or rg.item))
				end
			end
		end
	end
	return names
end

-- "/targetexact" lines with names[preferred] last, so it wins when present.
-- A name that is not MacroSafeName never becomes a line.
function Buttons.TargetMacro(list, preferred)
	local n = #list
	if n == 0 then return nil end
	local lines = {}
	for k = 1, n do
		local idx = (preferred + k - 1) % n + 1
		if Buttons.MacroSafeName(list[idx]) then lines[#lines + 1] = "/targetexact " .. list[idx] end
	end
	if #lines == 0 then return nil end
	local text = concat(lines, "\n")
	while #text > MACRO_LIMIT and #lines > 1 do
		table.remove(lines, 1)
		text = concat(lines, "\n")
	end
	return text
end

local target = { list = {}, sig = nil, cycle = 1 }

local function applyTarget(b)
	QoL.Secure("target", function()
		local list = target.list
		local text = Buttons.TargetMacro(list, target.cycle)
		b:SetAttribute("type", text and "macro" or nil)
		b:SetAttribute("macrotext", text)
		b.applied = list[target.cycle]
		b.Label:SetText(b.applied or "")
		if text then b:Show() else b:Hide() end
	end)
end

local function targetTooltip(b, tip)
	tip:SetText(L["Target"])
	for i = 1, #target.list do tip:AddLine(target.list[i], 1, 1, 1) end
	tip:AddLine(L["Click again for the next name. Drag to move."], 0.6, 0.6, 0.6)
end

---------------------------------------------------------------------------
-- Step key
---------------------------------------------------------------------------

-- Goals done with an NPC, whom the step key targets by name.
local NPC_VERBS = { accept = true, turnin = true, talk = true, train = true, vendor = true, buy = true, sethome = true, getfp = true, learn = true }

-- What the step key does now. view, raw: QoL.CurrentStep()'s, when the
-- caller has them. -> "item", itemID | "target", names (reused list) |
-- "npc", name | nil. The route's own goals come first, in guide order, then
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
				if item and Client.ItemCount(item) > 0 then return "item", item end
			elseif t == "hearth" then
				if Client.ItemCount(Client.HEARTHSTONE) > 0 then return "item", Client.HEARTHSTONE end
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

function Buttons.StepAction(view, raw)
	if not view then view, raw = QoL.CurrentStep() end
	if not view then return nil end
	local goals = view.goals or {}
	local kind, value = stepGoal(view, raw, goals, false)
	if not kind then kind, value = stepGoal(view, raw, goals, true) end
	if kind then return kind, value end
	local item = Buttons.ChooseQuestItem(view, raw)
	if item then return "item", item end
	return nil
end

local step = { kind = nil, value = nil, list = {}, sig = nil, cycle = 1 }

local function applyStep(b)
	QoL.Secure("step", function()
		local text, item
		if step.kind == "target" then
			text = Buttons.TargetMacro(step.list, step.cycle)
		elseif step.kind == "npc" then
			text = Buttons.TargetMacro({ step.value }, 1)
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

local itemButton, hearthButton, targetButton, stepButton

local function refresh()
	if not itemButton then return end
	-- One view of the current step for all three buttons.
	local view, raw = QoL.CurrentStep()
	applyItem(itemButton, QoL.On("itemButton") and view and Buttons.ChooseQuestItem(view, raw) or nil)
	applyItem(hearthButton, QoL.On("hearthButton") and view and Buttons.WantsHearth(view) and Client.HEARTHSTONE or nil)

	local list = QoL.On("targetButton") and view and Buttons.TargetNames(view, raw) or {}
	local sig = concat(list, "\n")
	if sig ~= target.sig then
		target.sig = sig
		local copy = {}
		for i = 1, #list do copy[i] = list[i] end
		target.list = copy
		target.cycle = 1
		applyTarget(targetButton)
	end

	local kind, value = nil, nil
	if view then kind, value = Buttons.StepAction(view, raw) end
	local stepSig = kind == "target" and ("target\n" .. concat(value, "\n")) or (tostring(kind) .. "\n" .. tostring(value))
	if stepSig ~= step.sig then
		step.sig, step.kind, step.cycle = stepSig, kind, 1
		local copy = {}
		if kind == "target" then
			for i = 1, #value do copy[i] = value[i] end
		else
			step.value = value
		end
		step.list = copy
		applyStep(stepButton)
	end
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
	-- The clamp covers the hearth and target slots too.
	holder:SetClampRectInsets(0, 0, GAP, -GAP)
	itemButton = newItemButton("PolestarQuestItemButton")
	hearthButton = newItemButton("PolestarHearthButton")
	targetButton = newButton("PolestarTargetButton", targetTooltip)
	targetButton.Icon:SetTexture(media("qol-target"))
	targetButton.Icon:SetTexCoord(0, 1, 0, 1)
	color(targetButton.Icon, "danger")
	targetButton:HookScript("PostClick", function(self, _, down)
		if down or self.dragging then return end
		local n = #target.list
		if n > 1 then
			target.cycle = target.cycle % n + 1
			applyTarget(targetButton)
		end
	end)
	-- The step key: a binding only, never shown.
	stepButton = CreateFrame("Button", "PolestarStepButton", UIParent, "SecureActionButtonTemplate")
	stepButton:RegisterForClicks("AnyUp", "AnyDown")
	QoL.Secure("init:PolestarStepButton", function() stepButton:Hide() end)
	stepButton:HookScript("PostClick", function(self, _, down)
		if down then return end
		local n = #step.list
		if step.kind == "target" and n > 1 then
			step.cycle = step.cycle % n + 1
			applyStep(self)
		end
	end)
	Buttons.item, Buttons.hearth, Buttons.target, Buttons.step = itemButton, hearthButton, targetButton, stepButton
	set = { hearthButton, itemButton, targetButton }
	place()
end

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
ns.RegisterEvent("UPDATE_BINDINGS", function()
	if not itemButton then return end
	refreshHotkey(itemButton)
	refreshHotkey(hearthButton)
	refreshHotkey(targetButton)
end)
ns.On("QUESTDB_LOADED", refreshSoon)
ns.On("SETTING_CHANGED", function(path)
	if not itemButton or type(path) ~= "string" then return end
	if path == "qol.buttonScale" or path == "qol" or path == "" then
		place()
	end
	if path == "qol.buttonTextSide" or path == "qol" or path == "" then
		for i = 1, #set do placeLabel(set[i]) end
	end
	if path:sub(1, 4) == "qol." or path == "qol" or path == "" then refreshSoon() end
end)

-- Back to the default spot (options button).
function Buttons.ResetPositions()
	QoL.State().buttonPos = nil
	if itemButton then place() end
end
