-- Quality of Life: the questing helpers players expect from a leveling addon,
-- each behind a "qol.*" setting on the Questing or Quality of Life options
-- page (their rows: Polestar_Options/QoL/Options.lua).
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
	questLoot = true,        -- ... also shows a looted item that starts a quest you can take, glowing (QoL/QuestLoot.lua)
	bagGlow = true,          -- the step's item glows in the bags
	targetButton = true,     -- target macro button
	targetPlate = true,      -- ... its icon shows the action, its name in the target's colour, the next names as small icons
	targetAnnounce = false,  -- ... a chat line when its names change
	targetRows = 5,          -- how many names the target list shows (1-8)
	targetSimple = false,    -- the target button alone, cycling, without its list of names
	targetListStyle = "full", -- the list's look: full, slim, names only, or portraits alone in a column or a strip
	targetCloseName = true,  -- portraits: the close one's name beside its face
	targetPortraits = "model", -- the list's faces: "model" (3D) or "flat" (2D once seen, else an icon)
	guideNameTarget = false, -- opt in: extend navigation clicks to targeting, with shared marking settings
	rareButton = true,       -- target button for a rare the addon spotted
	hearthButton = true,     -- Hearthstone button while a hearth goal is active
	markTarget = true,       -- raid icon on what the target button, step key and objective clicks target
	pingTarget = false,      -- /ping the mob the target button and step key target (QoL/Buttons.lua)
	markMob = "8",           -- its icon on mobs (1-8, "cycle"): skull
	markNpc = "1",           -- and on NPCs: star
	stepInteract = false,    -- the step key talks to, loots and accepts with its target (QoL/Buttons.lua)
	buttonScale = 1,
	buttonTextSide = "right", -- which side of the button its name sits on
	xpTracker = true,
	xpTargetMark = true,     -- the guide's level target on the game's XP bar
	questXPOverlay = true,
	boostedRest = true,      -- Boosted Rest and the sleeping bag on the XP line, the party's in the party panel
	sellJunk = true,
	autoRepair = true,
	repairGuild = false,     -- guild bank first when the rank allows
	buyGoals = false,        -- buy what the step's buy goals still need
	restock = true,          -- the merchant's Restock button, for the amounts set per character
	itemMarks = true,        -- junk and keep marks: Ctrl+Alt-click and the two mark keys (QoL/Marks.lua)
	itemMarksClick = true,   -- ... Ctrl+Alt-click cycles the marks (off: only the keys mark)
	bagSpace = true,         -- free bag slots: the junk button and the bags-full banner
	bagsLow = 2,             -- ... at this many free slots or fewer
	spareBag = false,        -- ... offer to put a bag from the bags in an empty bag slot first, on a press (QoL/Space.lua, #2369)
	rewardHighlight = true,
	rewardAutoPick = false,
	rewardEquip = false,     -- wear what a turn-in gives when it is an upgrade
	wearOffer = true,        -- offer gear from loot or a merchant that is an upgrade
	flightAutoOpen = true,
	flightHighlight = true,
	flightAutoTake = false,  -- take the guide's flight as soon as the flight map opens (QoL/Flight.lua, #1621)
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
	instanceTrack = true,    -- in a dungeon, the quest tracker watches only its quests (QoL/InstanceTrack.lua)
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
	local view = E.GetStepView(i, true)
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

-- One quest as a refresh reads it, appended to `into` from n: in the log or
-- not, ready or failed, and each objective's counts and state. -> the new n
local function readQuest(C, into, n, q)
	into[n + 1] = q
	into[n + 2] = (C.IsOnQuest(q) and 1 or 0) + (C.IsQuestReadyForTurnIn(q) and 2 or 0) + (C.IsQuestFailed(q) and 4 or 0)
	n = n + 2
	local objs = C.GetQuestObjectives(q)
	if objs then
		for k = 1, #objs do
			local o = objs[k]
			into[n + 1], into[n + 2], into[n + 3] = o.numFulfilled, o.numRequired, o.finished and 1 or 0
			n = n + 3
		end
	end
	into[n + 1] = -1 -- the quest's end
	return n + 1
end

-- What the step's refreshes read of the quest log, in `into` (wiped first):
-- how many quests it holds, and each quest of the current step's goals and of
-- the While-here line (QoL/Buttons.lua ChooseQuestItem's and TargetNames'
-- quests, QoL/BagGlow.lua's). -> its length; nil when the Engine or the log
-- can't say.
local function readStepLog(into)
	local E, C, QL = ns.Engine, ns.Compat, C_QuestLog
	if not (E and E.GetGuide and E.GetStepIndex and QL and QL.GetNumQuestLogEntries) then return nil end
	local n = 1
	into[1] = QL.GetNumQuestLogEntries() or 0
	local guide, i = E.GetGuide(), E.GetStepIndex()
	local step = guide and i and guide.steps and guide.steps[i]
	local goals = step and step.goals
	for g = 1, goals and #goals or 0 do
		local q = goals[g].quest
		if type(q) == "number" then n = readQuest(C, into, n, q) end
	end
	local here = E.GetWhileHere and E.GetWhileHere()
	if here and type(here.quest) == "number" then n = readQuest(C, into, n, here.quest) end
	for k = #into, n + 1, -1 do into[k] = nil end
	return n
end

-- That read and its version: one more each time a read differs from the one
-- before. Read once per moment (ns.Moment), whatever the number of readers.
local logNow, logWas, logVersion, logMoment = {}, {}, 0, nil
local function logVersionNow()
	local moment = ns.Moment()
	if moment == logMoment then return logVersion end
	logMoment = moment
	logNow, logWas = logWas, logNow
	local n = readStepLog(logNow)
	local same = n ~= nil and n == #logWas
	for k = 1, same and n or 0 do
		if logNow[k] ~= logWas[k] then
			same = false
			break
		end
	end
	if not same then logVersion = logVersion + 1 end
	return logVersion
end

-- Recompute fn once on the next frame after any number of calls. The
-- refresh runs from a timer of its own, with its errors caught and noted as
-- ns.Safe does, but in the moment it finds (ns.Moment): the refreshes of one
-- frame then share the step view the first of them builds (QoL.CurrentStep,
-- Engine.GetStepView shared). Anything between them that changes what the
-- view shows (a game event, a message, an Engine request, another timer of
-- Polestar's) starts a new moment, and the next refresh builds a fresh one.
-- A kill's burst asked for two views, one per refresh (#2555).
-- -> soon(), and onLog() for QUEST_LOG_UPDATE: the client sends it for much
-- that leaves the log as it was (several per kill, some per loot, fifty in a
-- burst), and a refresh that reads the step's view costs about half a
-- millisecond. A refresh that onLog asks for reads the step's part of the log
-- as it runs (readStepLog: one read per moment, whatever the number of
-- refreshes, and the step's view reads the same lines then), and a run asked
-- for only by onLog skips fn when that part is as at its last run. The step
-- itself changing comes through QoL.OnStep and soon() as before, the bags
-- through BAG_UPDATE_DELAYED.
function QoL.Coalesce(fn)
	local scheduled, other, logged, seen = false, false, false, nil
	local function run()
		scheduled = false
		if logged then
			local v = logVersionNow()
			if not other and v == seen then return end
			seen = v
		end
		other = false
		fn()
	end
	local function due() ns.SafeCall(run) end
	local function schedule()
		if scheduled then return end
		scheduled = true
		if C_Timer and C_Timer.After then C_Timer.After(0, due) else run() end
	end
	return function()
		other = true
		schedule()
	end, function()
		logged = true
		schedule()
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

-- The last bag index to scan: the backpack is 0, the bag slots 1 to
-- NUM_BAG_SLOTS, and on a client with a reagent bag slot that one comes last
-- (NUM_TOTAL_EQUIPPED_BAG_SLOTS, Enum.BagIndex.ReagentBag).
function Client.NumBags()
	return NUM_TOTAL_EQUIPPED_BAG_SLOTS or NUM_BAG_SLOTS or 4
end

-- The reagent bag slot: any bag past the regular slots. It takes only
-- reagents, whatever family the client reports for it.
function Client.IsReagentBag(bag)
	return bag > (NUM_BAG_SLOTS or 4)
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

-- Whether the slot holds a quest's item or one that begins a quest (#1557: a grey quest starter,
-- Noboru's Cudgel, was deleted as junk): such an item is never sold or deleted. False on a client
-- without C_Container.GetContainerItemQuestInfo.
function Client.SlotQuest(bag, slot)
	local C = C_Container
	local info = C and C.GetContainerItemQuestInfo and C.GetContainerItemQuestInfo(bag, slot)
	return info ~= nil and (info.isQuestItem == true or (info.questID or 0) > 0)
end

-- The quest the slot's item begins, while that quest is not in the log
-- (QuestInfoFields.questID and isActive); nil otherwise or on a client without
-- C_Container.GetContainerItemQuestInfo.
function Client.SlotStartsQuest(bag, slot)
	local C = C_Container
	local info = C and C.GetContainerItemQuestInfo and C.GetContainerItemQuestInfo(bag, slot)
	local q = info and readable(info.questID)
	if type(q) ~= "number" or q <= 0 or info.isActive == true then return nil end
	return q
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

-- Whether a regular bag slot (1 to NUM_BAG_SLOTS) has no bag in it: the
-- client gives an empty slot no container slots and no worn item.
function Client.BagSlotEmpty(bag)
	if bag < 1 or bag > (NUM_BAG_SLOTS or 4) then return false end
	if Client.NumSlots(bag) > 0 then return false end
	local C = C_Container
	local inv = C and C.ContainerIDToInventoryID and C.ContainerIDToInventoryID(bag)
	return not (inv and Client.WornID(inv))
end

-- Puts the bag a bag slot holds into the empty bag slot `into` (PickupContainerItem,
-- then PutItemInBag on that slot's inventory ID). Never with something already on the
-- cursor; when the bag does not go in, the cursor is cleared, which puts it back. true
-- when it went.
function Client.EquipBag(bag, slot, into)
	local C = C_Container
	if not (C and C.PickupContainerItem and C.ContainerIDToInventoryID and PutItemInBag and CursorHasItem) then return false end
	if CursorHasItem() then return false end
	C.PickupContainerItem(bag, slot)
	if not CursorHasItem() then return false end
	PutItemInBag(C.ContainerIDToInventoryID(into))
	if CursorHasItem() then
		if ClearCursor then ClearCursor() end
		return false
	end
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

-- true / false, or nil when range does not apply (no target, no range, in combat).
function Client.ItemInRange(itemID)
	if not (C_Item and C_Item.IsItemInRange and UnitExists and UnitExists("target")) then return nil end
	-- The client blocks addons' range checks in combat, on friendly targets too (#871, #1198).
	if inLockdown() then return nil end
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

-- "1g 23s 45c", "5s 0c", "25c": from the largest coin on, in the coins'
-- symbols (ns.CoinSymbols), the gold in thousands.
function QoL.Money(copper)
	copper = floor(copper or 0)
	local g, s, c = floor(copper / 10000), floor(copper / 100) % 100, copper % 100
	local G, S, C = ns.CoinSymbols()
	if g > 0 then return format("%s%s %d%s %d%s", ns.Thousands(g), G, s, S, c, C) end
	if s > 0 then return format("%d%s %d%s", s, S, c, C) end
	return format("%d%s", c, C)
end

-- "1h 05m", "12m", "40s"
function QoL.Duration(seconds)
	if not seconds then return "-" end
	seconds = floor(seconds + 0.5)
	if seconds >= 3600 then return format(L["%dh %02dm"], floor(seconds / 3600), floor(seconds / 60) % 60) end
	if seconds >= 60 then return format(L["%dm"], floor(seconds / 60)) end
	return format(L["%ds"], seconds)
end
