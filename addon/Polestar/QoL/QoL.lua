-- Quality of Life: the questing helpers players expect from a leveling addon,
-- each behind a "qol.*" setting on the Questing or Quality of Life options
-- page (QoL/Options.lua).
-- This file holds what the features share: settings, the out-of-combat queue
-- for secure frames, the current step's goals, and the client calls Compat
-- does not cover (bags, items, XP, money). Every client function used here
-- is declared in Forever's API documentation or used by its FrameXML.

local ADDON, ns = ...
local L = ns.L

local QoL = {}
ns.QoL = QoL

local type, pairs, select, tonumber = type, pairs, select, tonumber
local floor, format = math.floor, string.format

-- EllesmereUI modules that already do some of these jobs (docs/SUITE.md,
-- "Modules": Polestar integrates with EllesmereUI, never fights it). While
-- the module is installed and enabled for this character, the overlapping
-- toggle defaults to off; the player can still turn it on.
local COVERED = {
	sellJunk = "EllesmereUIQoL",           -- Auto Sell Junk
	autoRepair = "EllesmereUIQoL",         -- Auto Repair
	repairGuild = "EllesmereUIQoL",        -- Use Guild Bank Funds
	fastLoot = "EllesmereUIQoL",           -- Quick Loot
	skipGossip = "EllesmereUIQoL",         -- Auto Select Single Gossip
	hideErrors = "EllesmereUIQoL",         -- Hide Error Messages
	acceptPartyFriends = "EllesmereUIFriends", -- auto-accept invites from friends
}

-- The EllesmereUI module doing `key`'s job, when it is there; nil otherwise.
function QoL.CoveredBy(key)
	local name = COVERED[key]
	return name and ns.Compat.AddOnPresent(name) and name or nil
end

local defaults = {
	itemButton = true,       -- quest item button
	bagGlow = true,          -- the step's item glows in the bags
	targetButton = true,     -- target macro button
	rareButton = true,       -- target button for a rare the addon spotted
	hearthButton = true,     -- Hearthstone button while a hearth goal is active
	markTarget = false,      -- raid icon on what the target button and step key target
	markMob = "8",           -- its icon on mobs (1-8, "cycle"): skull
	markNpc = "1",           -- and on NPCs: star
	stepInteract = false,    -- the step key talks to, loots and accepts with its target (QoL/Buttons.lua)
	buttonScale = 1,
	buttonTextSide = "right", -- which side of the button its name sits on
	xpTracker = true,
	xpTargetMark = true,     -- the guide's level target on the game's XP bar
	sellJunk = true,
	autoRepair = true,
	repairGuild = false,     -- guild bank first when the rank allows
	buyGoals = false,        -- buy what the step's buy goals still need
	restock = true,          -- the merchant's Restock button, for the amounts set per character
	itemMarks = true,        -- Ctrl+Alt-click marks an item as junk or to keep
	bagSpace = true,         -- free bag slots: the junk button and the bags-full banner
	bagsLow = 2,             -- ... at this many free slots or fewer
	trainAll = false,        -- learn every spell a class trainer offers now
	rewardHighlight = true,
	rewardAutoPick = false,
	rewardEquip = false,     -- wear what a turn-in gives when it is an upgrade
	wearOffer = true,        -- offer gear from loot or a merchant that is an upgrade
	flightAutoOpen = true,
	flightHighlight = true,
	stepGossip = true,       -- pick the gossip option the live step asks for, open goods or training for its buy and train goals (QoL/Gossip.lua)
	autoBind = false,        -- bind the Hearthstone at the step's innkeeper
	deathHelper = true,
	breathWarning = false,   -- red screen edge, sound and taskbar flash as breath runs out (QoL/Breath.lua)
	instantQuestText = true,
	skipGossip = true,
	fastLoot = true,
	hideErrors = false,      -- combat error spam ("Not enough rage", "Out of range")
	autoReleasePvP = false,  -- release at once in battlegrounds
	hideQuestTracker = false, -- the game's objective tracker, as Questie can
	declineDuels = false,    -- friends and guild excepted
	declineGuildInvites = false,
	declinePartyStrangers = false,
	acceptPartyFriends = false,
	acceptSummon = false,
	acceptResurrect = false,
}
for key in pairs(COVERED) do
	if defaults[key] and QoL.CoveredBy(key) then defaults[key] = false end
end
ns.RegisterDefaults("qol", defaults)

local paths = {}
-- Setting "qol.<key>" as a boolean.
function QoL.On(key)
	local p = paths[key]
	if not p then
		p = "qol." .. key
		paths[key] = p
	end
	return ns.Get(p) and true or false
end

-- Per-character module state, recreated when SavedVariables come back nil.
function QoL.State()
	local s = ns.CharState()
	local q = s.qol
	if type(q) ~= "table" then
		q = {}
		s.qol = q
	end
	return q
end

function QoL.Shift()
	return ns.Compat and ns.Compat.IsShiftKeyDown and ns.Compat.IsShiftKeyDown() or false
end

-- A game event handled only while one of `keys` ("qol.<key>" settings) is on:
-- registered when the first turns on, unregistered when the last turns off,
-- so a feature that is off costs nothing. Follows saved settings from
-- ADDON_LOADED on.
local watches = {}

local function sync(w)
	local on = false
	for i = 1, #w.keys do
		if QoL.On(w.keys[i]) then
			on = true
			break
		end
	end
	if on == w.live then return end
	w.live = on
	if on then ns.RegisterEvent(w.event, w.fn) else ns.UnregisterEvent(w.event, w.fn) end
end

local initialized = false
function QoL.WhileOn(keys, event, fn)
	local w = { keys = type(keys) == "table" and keys or { keys }, event = event, fn = fn, live = false }
	watches[#watches + 1] = w
	if initialized then sync(w) end
	return w
end

-- Whether `event` is registered for a watch right now (tests, /pole status).
function QoL.Watching(event)
	for i = 1, #watches do
		if watches[i].event == event and watches[i].live then return true end
	end
	return false
end

ns.OnInit(function()
	initialized = true
	for i = 1, #watches do sync(watches[i]) end
end)

ns.On("SETTING_CHANGED", function(path)
	if not initialized or not (path == "" or path == "qol" or path:sub(1, 4) == "qol.") then return end
	for i = 1, #watches do sync(watches[i]) end
end)

-- Reference data (Data.lua, generated by `node tools/polestar.js qol build`).
QoL.data = { spiritHealers = {}, flightMasters = {}, reagentVendors = {} }
function QoL.SetData(d)
	if type(d) ~= "table" then return end
	local fm, reagents = {}, {}
	for _, id in ipairs(d.flightMasters or {}) do fm[id] = true end
	for _, id in ipairs(d.reagentVendors or {}) do reagents[id] = true end
	QoL.data = { spiritHealers = d.spiritHealers or {}, flightMasters = fm, reagentVendors = reagents }
end

---------------------------------------------------------------------------
-- Secure frames: attribute, visibility and position changes are protected
-- in combat. QoL.Secure(key, fn) runs fn now, or once combat ends (the last
-- request per key wins).
---------------------------------------------------------------------------

local queued = {}

local function inLockdown()
	return InCombatLockdown and InCombatLockdown() and true or false
end
QoL.InLockdown = inLockdown

function QoL.Secure(key, fn)
	if inLockdown() then
		queued[key] = fn
		return false
	end
	queued[key] = nil
	fn()
	return true
end

function QoL.HasQueued(key)
	return queued[key] ~= nil
end

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	for key, fn in pairs(queued) do
		queued[key] = nil
		ns.SafeCall(fn)
	end
end)

---------------------------------------------------------------------------
-- The active tab's current step: its view (statuses) and raw goals (fields
-- the view omits, such as `oi`, `target`, `location`).
---------------------------------------------------------------------------

function QoL.CurrentStep()
	local E = ns.Engine
	if not (E and E.GetStepIndex and E.GetStepView) then return nil end
	local i = E.GetStepIndex()
	if not i then return nil end
	local view = E.GetStepView(i)
	if not view then return nil end
	local guide = E.GetGuide and E.GetGuide()
	local step = guide and guide.steps and guide.steps[i]
	return view, step and step.goals or nil
end

-- A goal still to do (not done, not inapplicable).
function QoL.Open(goalView)
	local s = goalView and goalView.status
	return s == "active" or s == "pending"
end

-- Recompute fn once on the next frame after any number of calls.
function QoL.Coalesce(fn)
	local scheduled = false
	local function run()
		scheduled = false
		fn()
	end
	return function()
		if scheduled then return end
		scheduled = true
		if C_Timer and C_Timer.After then ns.After(0, run) else run() end
	end
end

-- Fire `fn` on every message that can change the current step.
function QoL.OnStep(fn)
	ns.On("STEP_CHANGED", fn)
	ns.On("STEP_UPDATED", fn)
	ns.On("GUIDE_CHANGED", fn)
	ns.On("TABS_CHANGED", fn)
end

---------------------------------------------------------------------------
-- Gossip and Blizzard's dialogs, for the helpers that answer them
---------------------------------------------------------------------------

-- The open gossip offers a quest to pick up or one to hand in: the quest
-- automation goes first, so a helper leaves such a gossip alone.
function QoL.HasQuestBusiness()
	local G = C_GossipInfo
	if not G then return false end
	if (G.GetNumAvailableQuests and G.GetNumAvailableQuests() or 0) > 0 then return true end
	if G.GetActiveQuests then
		local active = G.GetActiveQuests() or {}
		for i = 1, #active do
			if active[i].isComplete then return true end
		end
	end
	return false
end

-- Picks a gossip option by its ID, else its order index; false when the
-- client offers neither.
function QoL.SelectGossip(opt)
	local G = C_GossipInfo
	if opt.gossipOptionID and G and G.SelectOption then
		G.SelectOption(opt.gossipOptionID)
	elseif G and G.SelectOptionByIndex then
		G.SelectOptionByIndex(opt.orderIndex)
	else
		return false
	end
	return true
end

-- Answering through the API leaves Blizzard's dialog up, so it is closed on
-- the next frame, after Blizzard's own handler has shown it; `mark` is a
-- field its OnHide reads to know it was answered. Under Forever's Gamepad
-- interface style (ns.GamepadUI, Core/Init.lua) dialogs belong to the
-- gamepad focus system and are left for the player to dismiss.
function QoL.ClosePopup(which, mark)
	local function close()
		if ns.GamepadUI() or not StaticPopup_Hide then return end
		if mark and StaticPopup_FindVisible then
			local dialog = StaticPopup_FindVisible(which)
			if dialog then dialog[mark] = 1 end
		end
		StaticPopup_Hide(which)
	end
	if C_Timer and C_Timer.After then ns.After(0, close) else close() end
end

---------------------------------------------------------------------------
-- Client calls Compat does not cover. Secret values read as unknown.
---------------------------------------------------------------------------

local Client = {}
QoL.Client = Client

local readable = ns.Compat.Readable

Client.HEARTHSTONE = 6948
Client.QUALITY_POOR = 0
Client.QUALITY_COMMON = 1
Client.CLASS_QUEST = 12 -- Enum.ItemClass.Questitem
Client.CLASS_PROJECTILE = 6 -- Enum.ItemClass.Projectile
Client.RANGED_SLOT = 18

function Client.NumBags()
	return NUM_BAG_SLOTS or 4
end

function Client.NumSlots(bag)
	local C = C_Container
	if C and C.GetContainerNumSlots then return C.GetContainerNumSlots(bag) or 0 end
	return 0
end

-- ContainerItemInfo { itemID, quality, stackCount, hasNoValue, isLocked, hyperlink } | nil
function Client.SlotInfo(bag, slot)
	local C = C_Container
	if C and C.GetContainerItemInfo then return C.GetContainerItemInfo(bag, slot) end
	return nil
end

function Client.UseSlot(bag, slot)
	local C = C_Container
	if C and C.UseContainerItem then C.UseContainerItem(bag, slot) end
end

-- Free slots in one bag and its family: 0 (or nil) for a bag that holds
-- anything, a bit set for a quiver, ammo pouch, soul or profession bag.
function Client.FreeSlots(bag)
	local C = C_Container
	if not (C and C.GetContainerNumFreeSlots) then return 0, nil end
	local free, family = C.GetContainerNumFreeSlots(bag)
	return readable(free) or 0, readable(family)
end

-- Destroys what a bag slot holds. Only on a press (DeleteCursorItem has
-- restrictions: the client's own delete dialog calls it from its button),
-- never with something already on the cursor, which the pickup would
-- swap in. true when the item went.
function Client.DeleteSlot(bag, slot)
	local C = C_Container
	if not (C and C.PickupContainerItem and DeleteCursorItem and CursorHasItem) then return false end
	if CursorHasItem() then return false end
	C.PickupContainerItem(bag, slot)
	if not CursorHasItem() then return false end
	DeleteCursorItem()
	return true
end

function Client.ItemCount(itemID)
	local C = ns.Compat
	if C and C.GetItemCount then return C.GetItemCount(itemID) or 0 end
	return 0
end

-- start, duration (0, 0 when ready or unknown)
function Client.ItemCooldown(itemID)
	local fn = (C_Container and C_Container.GetItemCooldown) or (C_Item and C_Item.GetItemCooldown)
	if not fn then return 0, 0 end
	local start, duration = fn(itemID)
	return readable(start) or 0, readable(duration) or 0
end

function Client.ItemIcon(itemID)
	if C_Item and C_Item.GetItemIconByID then return C_Item.GetItemIconByID(itemID) end
	return nil
end

-- true / false, or nil when range does not apply (no target, no range).
function Client.ItemInRange(itemID)
	if not (C_Item and C_Item.IsItemInRange and UnitExists and UnitExists("target")) then return nil end
	return readable(C_Item.IsItemInRange(itemID, "target"))
end

function Client.ItemUsable(itemID)
	if C_Item and C_Item.IsUsableItem then return C_Item.IsUsableItem(itemID) and true or false end
	return true
end

function Client.ItemSpell(itemID)
	if C_Item and C_Item.GetItemSpell then return C_Item.GetItemSpell(itemID) end
	return nil
end

function Client.ItemClass(itemID)
	if C_Item and C_Item.GetItemInfoInstant then return (select(6, C_Item.GetItemInfoInstant(itemID))) end
	return nil
end

-- classID, subclassID (C_Item.GetItemInfoInstant: cached or not).
function Client.ItemKind(itemID)
	if not (C_Item and C_Item.GetItemInfoInstant) then return nil end
	local _, _, _, _, _, classID, subclassID = C_Item.GetItemInfoInstant(itemID)
	return classID, subclassID
end

-- The level an item can be used from, nil while uncached.
function Client.ItemMinLevel(itemID)
	if not (itemID and C_Item and C_Item.GetItemInfo) then return nil end
	return (select(5, C_Item.GetItemInfo(itemID)))
end

-- A spell's name in the client's language, nil when unknown.
function Client.SpellName(spellID)
	if C_Spell and C_Spell.GetSpellName then return C_Spell.GetSpellName(spellID) end
	if GetSpellInfo then return (GetSpellInfo(spellID)) end
	return nil
end

-- Item ID of what the character wears in an inventory slot.
function Client.WornID(slot)
	return GetInventoryItemID and GetInventoryItemID("player", slot) or nil
end

-- Vendor sell price per item in copper, nil while uncached.
function Client.SellPrice(item)
	if not (item and C_Item and C_Item.GetItemInfo) then return nil end
	return (select(11, C_Item.GetItemInfo(item)))
end

function Client.ItemIDFromLink(link)
	return link and tonumber(link:match("item:(%d+)")) or nil
end

function Client.Money()
	return GetMoney and GetMoney() or 0
end

-- "1g 23s 45c", zero parts left out.
function QoL.Money(copper)
	copper = floor(copper or 0)
	local g, s, c = floor(copper / 10000), floor(copper / 100) % 100, copper % 100
	if g > 0 then return format("%dg %ds %dc", g, s, c) end
	if s > 0 then return format("%ds %dc", s, c) end
	return format("%dc", c)
end

-- "1h 05m", "12m", "40s"
function QoL.Duration(seconds)
	if not seconds then return "-" end
	seconds = floor(seconds + 0.5)
	if seconds >= 3600 then return format(L["%dh %02dm"], floor(seconds / 3600), floor(seconds / 60) % 60) end
	if seconds >= 60 then return format(L["%dm"], floor(seconds / 60)) end
	return format(L["%ds"], seconds)
end
