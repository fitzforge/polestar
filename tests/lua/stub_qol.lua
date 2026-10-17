-- A fake world for Quality of Life tests (addon/Polestar/QoL), loaded after
-- wow_stub.lua. It installs contract-faithful fakes for the Engine, Nav and
-- Pins (just before ADDON_LOADED, after the addon files ran), overrides the
-- map half of Compat with one flat test map, and provides the client APIs QoL
-- uses: XP, bags and items, merchant (guild repair, goods), trainer, quest
-- rewards, gossip,
-- taxi map, death, loot, requests from other players (q.social), popups
-- (q.showPopup), UIErrorsFrame message types, and installed-but-unloaded
-- addons (q.installed).
--
-- Secure frames are enforced: on a frame created from a Secure* template,
-- SetAttribute, Show, Hide, SetPoint, ClearAllPoints and SetScale raise a Lua
-- error while stub.inCombat is true, as the client blocks them.
--
-- Map 9000 (continent 0) spans world wx 1000..-1000 (top..bottom) and
-- wy 1000..-1000 (left..right): map (50, 50) is the origin, 1% = 20 yd.
-- Zone 9002 lies south of it (wx -1000..-3000), and continent map 9100 holds
-- both (9000 is its top half). Nav.journey.ZonePoint moves a 9100 point onto
-- the zone under it.
--
--   local q = stub.qol
--   q.step({ { t = "kill", target = "Kobold Vermin" }, { t = "use", item = 900, quest = 7, oi = 1 } })
--   q.addItem(bag, slot, itemID, count)        -- q.items[id] = { quality, price, classID, spell, noValue }
--   q.combat(true|false)                        -- PLAYER_REGEN_DISABLED / ENABLED
--   q.click(frame, down)                        -- OnClick + PostClick (button "LeftButton")
--   q.gainXP(n)                                 -- UnitXP moves, PLAYER_XP_UPDATE (levels up past xpMax)
--   q.calls                                     -- { { "UseContainerItem", bag, slot }, { "GetQuestReward", i }, ... }

local q = {
	level = 10, xp = 0, xpMax = 1000, rested = nil, maxLevel = 60,
	xpMaxFor = function(level) return 1000 + (level - 10) * 100 end,
	bags = {},
	items = {},
	calls = {},
	money = 0,
	repair = { can = false, cost = 0 },
	choices = {},
	questMoney = 0,
	gossip = { options = {}, available = 0, active = {}, force = false },
	taxiNodes = {},
	ghost = false,
	corpse = nil, -- { x, y } percent on map 9000 (any map answers, off its edge too)
	runSpeed = 7,
	player = { c = 0, wx = 0, wy = 0 },
	npc = nil,
	bind = "Goldshire",
	loot = 0,
	specialItems = {}, -- questID -> itemID (quest log special item)
	engine = { step = nil, view = nil, guide = nil, waypoint = nil },
	nav = { target = nil, sets = {}, releases = 0, clears = 0, route = nil, ci = 1 },
	pins = {},
	cooldowns = {},
	inRange = nil,
	target = false,
}
stub.qol = q

for bag = 0, 4 do q.bags[bag] = { size = bag == 0 and 16 or 0, slots = {} } end

local function call(...) table.insert(q.calls, { ... }) end

---------------------------------------------------------------------------
-- Secure frames
---------------------------------------------------------------------------

local M = stub.Methods
local function guard(name)
	local original = M[name]
	M[name] = function(self, ...)
		if self.secure and stub.inCombat then error("protected call in combat: " .. tostring(self.name) .. ":" .. name, 2) end
		return original(self, ...)
	end
end
for _, name in ipairs({ "SetAttribute", "Show", "Hide", "SetPoint", "ClearAllPoints", "SetScale" }) do guard(name) end

local createFrame = CreateFrame
function CreateFrame(kind, name, parent, template, id)
	local f = createFrame(kind, name, parent, template, id)
	if type(template) == "string" and template:find("Secure") then f.secure = true end
	return f
end

function q.combat(on)
	stub.inCombat = on and true or false
	stub.fire(on and "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED")
end

function q.click(f, down)
	stub.RunScript(f, "PreClick", "LeftButton", down)
	stub.RunScript(f, "OnClick", "LeftButton", down)
	stub.RunScript(f, "PostClick", "LeftButton", down)
end

---------------------------------------------------------------------------
-- Player, XP, death
---------------------------------------------------------------------------

function UnitLevel(unit) if unit == "player" then return q.level end end
function UnitXP(unit) if unit == "player" then return q.xp end end
function UnitXPMax(unit) if unit == "player" then return q.xpMax end end
function GetXPExhaustion() return q.rested end
function GetMaxPlayerLevel() return q.maxLevel end
function UnitIsGhost(unit) return unit == "player" and q.ghost end
function UnitExists(unit) if unit == "target" then return q.target end return unit == "player" end
function GetUnitSpeed(unit) if unit == "player" then return 0, q.runSpeed, 0, 0 end end

function q.gainXP(n)
	q.xp = q.xp + n
	while q.xp >= q.xpMax do
		q.xp = q.xp - q.xpMax
		q.level = q.level + 1
		q.xpMax = q.xpMaxFor(q.level)
	end
	stub.fire("PLAYER_XP_UPDATE", "player")
end

C_DeathInfo = {}
function C_DeathInfo.GetCorpseMapPosition(map)
	if not q.corpse then return nil end
	local C = Polestar.Compat
	local c, wx, wy = C.MapToWorld(9000, q.corpse[1], q.corpse[2])
	local x, y = C.WorldToMap(c, wx, wy, map)
	if not x then return nil end
	return CreateVector2D(x / 100, y / 100)
end

---------------------------------------------------------------------------
-- Bags and items
---------------------------------------------------------------------------

-- q.items[id] = { name, quality = 0..5, price (sell, copper), classID, spell, noValue, icon }
function q.addItem(bag, slot, id, count)
	q.bags[bag].slots[slot] = { itemID = id, stackCount = count or 1 }
end

local function slotInfo(bag, slot)
	local b = q.bags[bag]
	local s = b and b.slots[slot]
	if not s then return nil end
	local it = q.items[s.itemID] or {}
	return {
		itemID = s.itemID, stackCount = s.stackCount, quality = it.quality, isLocked = s.locked or false,
		hasNoValue = it.noValue or false, hyperlink = "|Hitem:" .. s.itemID .. "|h[" .. (it.name or "?") .. "]|h",
		iconFileID = it.icon or 134400, itemName = it.name or "?",
	}
end

C_Container = {}
function C_Container.GetContainerNumSlots(bag) return q.bags[bag] and q.bags[bag].size or 0 end
C_Container.GetContainerItemInfo = slotInfo
function C_Container.UseContainerItem(bag, slot)
	call("UseContainerItem", bag, slot)
	local s = q.bags[bag].slots[slot]
	if s and q.merchantOpen then
		local it = q.items[s.itemID] or {}
		q.money = q.money + (it.price or 0) * s.stackCount
		q.sold = q.sold or {}
		table.insert(q.sold, s.itemID)
		q.bags[bag].slots[slot] = nil
	end
end
function C_Container.GetItemCooldown(id)
	local c = q.cooldowns[id]
	if c then return c[1], c[2], 1 end
	return 0, 0, 1
end

C_Item = {}
function C_Item.GetItemCount(id)
	local n = 0
	for bag = 0, 4 do
		for _, s in pairs(q.bags[bag].slots) do
			if s.itemID == id then n = n + s.stackCount end
		end
	end
	return n
end
function C_Item.GetItemIconByID(id) return (q.items[id] and q.items[id].icon) or 134400 end
function C_Item.IsItemInRange() return q.inRange end
function C_Item.IsUsableItem(id) return true end
-- Wearing lands a moment later, once the server answers: one copy leaves the
-- bags for q.worn[slot] (slot -> item ID), BAG_UPDATE_DELAYED, then
-- PLAYER_EQUIPMENT_CHANGED. q.refuse[id]: that item never goes on (its bind
-- confirmation cancelled).
q.worn, q.refuse = {}, {}
function C_Item.EquipItemByName(item, slot)
	call("EquipItemByName", item, slot)
	local id = tonumber(tostring(item):match("item:(%d+)"))
	if q.refuse[id] then return end
	C_Timer.After(0.1, function()
		for bag = 0, 4 do
			for s, it in pairs(q.bags[bag].slots) do
				if it.itemID == id then
					q.bags[bag].slots[s] = nil
					if slot then q.worn[slot] = id end
					stub.fire("BAG_UPDATE_DELAYED")
					stub.fire("PLAYER_EQUIPMENT_CHANGED", slot, false)
					return
				end
			end
		end
	end)
end
function C_Item.GetItemSpell(id) local it = q.items[id]; if it and it.spell then return "Use", it.spell end end
function C_Item.GetItemInfoInstant(id)
	local it = q.items[id] or {}
	return id, "", "", "", it.icon or 134400, it.classID or 0, 0
end
function C_Item.GetItemInfo(item)
	local id = type(item) == "number" and item or tonumber(tostring(item):match("item:(%d+)"))
	local it = id and q.items[id]
	if not it or it.uncached then return nil end
	return it.name, "|Hitem:" .. id .. "|h[" .. (it.name or "?") .. "]|h", it.quality, 1, 1, "", "", 1, "", 134400, it.price
end

C_QuestLog = {}
function C_QuestLog.GetLogIndexForQuestID(questID) if q.specialItems[questID] then return questID end end
function GetQuestLogSpecialItemInfo(index)
	local id = q.specialItems[index]
	if id then return "|cffffffff|Hitem:" .. id .. "::::::::|h[Quest Item]|h|r", 134400, 1, false end
end

---------------------------------------------------------------------------
-- Merchant
---------------------------------------------------------------------------

function GetMoney() return q.money end
function CanMerchantRepair() return q.repair.can end
function GetRepairAllCost() return q.repair.cost, q.repair.cost > 0 end
function RepairAllItems(guild)
	call("RepairAllItems", guild and "guild" or "own")
	q.money = q.money - (guild and 0 or q.repair.cost)
	q.repair.cost = 0
end

-- Goods for sale: q.goods = { { id, price (per purchase), stackCount (items
-- per purchase), numAvailable (-1: unlimited), maxStack, extendedCost } }.
-- A purchase is paid at once and lands in the bags q.landDelay seconds later,
-- as the server answers.
q.goods = {}
q.landDelay = 0.1
function GetMerchantNumItems() return #q.goods end
function GetMerchantItemID(i) return q.goods[i] and q.goods[i].id end
function GetMerchantItemInfo(i)
	local g = q.goods[i]
	if not g then return nil end
	local it = q.items[g.id] or {}
	return it.name, 134400, g.price or 0, g.stackCount or 1, g.numAvailable or -1, true, true, g.extendedCost or false
end
function GetMerchantItemMaxStack(i) return q.goods[i] and (q.goods[i].maxStack or 20) or 0 end
-- The server refuses a purchase over the stack limit, not in whole stacks,
-- beyond the stock (counted in items here) or your money: nothing is paid
-- and nothing lands (q.refused counts them).
q.refused = 0
function BuyMerchantItem(i, quantity)
	quantity = quantity or 1
	call("BuyMerchantItem", i, quantity)
	local g = q.goods[i]
	if not (g and q.merchantOpen) then return end
	local per = g.stackCount or 1
	local cost = (g.price or 0) * quantity / per
	local stock = g.numAvailable or -1
	if quantity > (g.maxStack or 20) or quantity % per ~= 0 or cost > q.money or (stock >= 0 and quantity > stock) then
		q.refused = q.refused + 1
		return
	end
	q.money = q.money - cost
	if stock >= 0 then g.numAvailable = stock - quantity end
	C_Timer.After(q.landDelay, function()
		for slot = 1, q.bags[0].size do
			if not q.bags[0].slots[slot] then
				q.addItem(0, slot, g.id, quantity)
				break
			end
		end
		stub.fire("BAG_UPDATE_DELAYED")
	end)
end

function q.openMerchant()
	q.merchantOpen = true
	stub.fire("MERCHANT_SHOW")
end
function q.closeMerchant()
	q.merchantOpen = false
	stub.fire("MERCHANT_CLOSED")
end

---------------------------------------------------------------------------
-- Trainer: q.trainer = { tradeskill = bool, services = { { name, rank, kind
-- ("available" | "unavailable" | "used"), cost }, ... } }. A purchase lands
-- a moment later, as from the server: the money is taken, the service is
-- used and moves to the end of the list (the indexes shift), then
-- TRAINER_UPDATE. A service with `refuse = true` is refused: nothing comes back.
-- q.classTrainers holds the npcs the Engine knows as trainers of the
-- character's class; q.openTrainer(npc) opens one of them unless given another.
---------------------------------------------------------------------------

q.trainer = { tradeskill = false, services = {} }
function IsTradeskillTrainer() return q.trainer.tradeskill end
function GetNumTrainerServices() return #q.trainer.services end
function GetTrainerServiceInfo(i)
	local s = q.trainer.services[i]
	if s then return s.name, s.kind, 136096, 1, s.rank, "" end
end
function GetTrainerServiceCost(i)
	local s = q.trainer.services[i]
	if s then return s.cost or 0, q.trainer.tradeskill end
end
function BuyTrainerService(i)
	local s = q.trainer.services[i]
	call("BuyTrainerService", s and s.name, s and s.rank)
	C_Timer.After(0.1, function()
		if not (s and s.kind == "available" and not s.refuse and q.money >= (s.cost or 0)) then return end
		q.money = q.money - (s.cost or 0)
		s.kind = "used"
		local list = q.trainer.services
		for j = 1, #list do
			if list[j] == s then table.remove(list, j); break end
		end
		list[#list + 1] = s
		if q.trainerOpen then stub.fire("TRAINER_UPDATE") end
	end)
end

q.classTrainers = { [198] = true }
function q.openTrainer(npc)
	q.npc = npc or 198
	q.trainerOpen = true
	stub.fire("TRAINER_SHOW")
end
function q.closeTrainer()
	q.npc = nil
	q.trainerOpen = false
	stub.fire("TRAINER_CLOSED")
end

---------------------------------------------------------------------------
-- Quest rewards: q.choices = { { id, count }, ... }; reward buttons like QuestInfo's
---------------------------------------------------------------------------

QuestInfoRewardsFrame = CreateFrame("Frame", "QuestInfoRewardsFrame", UIParent)
QuestInfoRewardsFrame.RewardButtons = {}
QuestInfoFrame = CreateFrame("Frame", "QuestInfoFrame", UIParent)
QuestInfoFrame.rewardsFrame = QuestInfoRewardsFrame

-- q.rewards = { { id, count }, ... }: the items every turn-in gives. With
-- q.landRewards, a turn-in puts the chosen item and those in the first free
-- slots of bag 0 a moment later, then BAG_UPDATE_DELAYED, and the reward
-- panel empties (QUEST_FINISHED).
q.rewards = {}
local function rewardOf(kind, i)
	if kind == "choice" then return q.choices[i] end
	if kind == "reward" then return q.rewards[i] end
end
function GetNumQuestChoices() return #q.choices end
function GetNumQuestRewards() return #q.rewards end
function GetQuestItemInfo(kind, i)
	local c = rewardOf(kind, i)
	if not c then return nil end
	local it = q.items[c.id] or {}
	return it.name, 134400, c.count or 1, it.quality, true, c.id
end
function GetQuestItemLink(kind, i)
	local c = rewardOf(kind, i)
	if not c or (q.items[c.id] and q.items[c.id].uncached) then return nil end
	return "|Hitem:" .. c.id .. "|h[" .. ((q.items[c.id] or {}).name or "?") .. "]|h"
end
function GetQuestMoneyToGet() return q.questMoney end
function GetQuestReward(i)
	call("GetQuestReward", i)
	if not q.landRewards then return end
	local given = {}
	if q.choices[i] then given[#given + 1] = q.choices[i] end
	for _, r in ipairs(q.rewards) do given[#given + 1] = r end
	C_Timer.After(0.1, function()
		local slots = q.bags[0].slots
		for _, r in ipairs(given) do
			for slot = 1, q.bags[0].size do
				if not slots[slot] then q.addItem(0, slot, r.id, r.count); break end
			end
		end
		stub.fire("BAG_UPDATE_DELAYED")
		q.choices, q.rewards = {}, {}
		stub.fire("QUEST_FINISHED")
	end)
end

-- Open the reward panel with the current q.choices, laying out buttons the way
-- QuestInfo does (LargeQuestRewardItemButtonTemplate: a 39px Icon at TOPLEFT).
function q.questComplete()
	local buttons = QuestInfoRewardsFrame.RewardButtons
	for i, b in ipairs(buttons) do b:Hide() end
	for i = 1, #q.choices do
		local b = buttons[i]
		if not b then
			b = CreateFrame("Button", nil, QuestInfoRewardsFrame)
			b:SetSize(147, 41)
			b.Icon = b:CreateTexture(nil, "BACKGROUND")
			b.Icon:SetSize(39, 39)
			b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
			buttons[i] = b
		end
		b.type, b.objectType = "choice", "item"
		b:SetID(i)
		b:Show()
	end
	stub.fire("QUEST_COMPLETE")
end

---------------------------------------------------------------------------
-- Gossip and taxi
---------------------------------------------------------------------------

C_GossipInfo = {}
function C_GossipInfo.GetOptions() return q.gossip.options end
function C_GossipInfo.GetNumAvailableQuests() return q.gossip.available end
function C_GossipInfo.GetNumActiveQuests() return #q.gossip.active end
function C_GossipInfo.GetActiveQuests() return q.gossip.active end
function C_GossipInfo.GetAvailableQuests() return {} end
function C_GossipInfo.ForceGossip() return q.gossip.force end
function C_GossipInfo.SelectOption(id) call("SelectOption", id) end
function C_GossipInfo.SelectOptionByIndex(i) call("SelectOptionByIndex", i) end

function q.openGossip(npc, opts)
	q.npc = npc
	q.gossip.options = opts.options or {}
	q.gossip.available = opts.available or 0
	q.gossip.active = opts.active or {}
	q.gossip.force = opts.force or false
	stub.fire("GOSSIP_SHOW")
end

TaxiFrame = CreateFrame("Frame", "TaxiFrame", UIParent)
TaxiFrame.shown = false
function NumTaxiNodes() return #q.taxiNodes end
function TaxiNodeName(i) return q.taxiNodes[i] end
function TakeTaxiNode(i) call("TakeTaxiNode", i) end

function q.openTaxi(names)
	q.taxiNodes = names
	for i = 1, #names do
		local b = _G["TaxiButton" .. i] or CreateFrame("Button", "TaxiButton" .. i, TaxiFrame)
		b:Show()
	end
	TaxiFrame:Show()
	stub.fire("TAXIMAP_OPENED", 1)
	stub.runTimers()
end

---------------------------------------------------------------------------
-- Loot, requests from other players, errors, battlegrounds
---------------------------------------------------------------------------

function GetNumLootItems() return q.loot end
function LootSlot(i) call("LootSlot", i) end
function IsModifiedClick() return false end

-- q.social = { friends = { [name|guid] = true }, bnet = { [guid] = true }, guild = { [name|guid] = true },
--   combat = { [unit|name] = true }, canTeleport, queued, offerer, corpseDelay, summoner, area,
--   gamepad, hardcore, battleground, selfRes = n }
q.social = { friends = {}, bnet = {}, guild = {}, combat = {}, canTeleport = true, queued = false,
	offerer = nil, corpseDelay = 0, summoner = "Mage", area = "Ironforge", gamepad = false, hardcore = false,
	battleground = false, selfRes = 0 }
local social = q.social

C_FriendList = {}
function C_FriendList.IsFriend(guid) return social.friends[guid] == true end
function C_FriendList.GetFriendInfo(name) if social.friends[name] then return { name = name } end end
C_BattleNet = {}
function C_BattleNet.GetGameAccountInfoByGUID(guid) if social.bnet[guid] then return { playerGuid = guid } end end
function IsGuildMember(guid) return social.guild[guid] == true end
C_GuildInfo = {}
function C_GuildInfo.MemberExistsByName(name) return social.guild[name] == true end
function UnitAffectingCombat(unit) return social.combat[unit] == true end
function PlayerCanTeleport() return social.canTeleport end
function WillAcceptInviteRemoveQueues() return social.queued end
C_SummonInfo = {}
function C_SummonInfo.ConfirmSummon() call("ConfirmSummon") end
function C_SummonInfo.GetSummonConfirmSummoner() return social.summoner end
function C_SummonInfo.GetSummonConfirmAreaName() return social.area end
function AcceptResurrect() call("AcceptResurrect") end
function ResurrectGetOfferer() return social.offerer end
function GetCorpseRecoveryDelay() return social.corpseDelay end
function AcceptGroup() call("AcceptGroup") end
function DeclineGroup() call("DeclineGroup") end
function DeclineGuild() call("DeclineGuild") end
function CancelDuel() call("CancelDuel") end
C_GameRules = {}
function C_GameRules.IsHardcoreActive() return social.hardcore end
C_PvP = {}
function C_PvP.IsBattleground() return social.battleground end
function C_DeathInfo.GetSelfResurrectOptions()
	local out = {}
	for i = 1, social.selfRes do out[i] = { name = "Soulstone", optionType = 0, id = i, canUse = true, isLimited = false, priority = 0 } end
	return out
end
function RepopMe() call("RepopMe") end
C_InputInterfaceStyle = {}
function C_InputInterfaceStyle.GetCurrentStyle() return social.gamepad and 1 or 0 end
Enum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }

-- Popups: shown ones by which; StaticPopup_Hide records the close and whether
-- the dialog was marked answered first.
q.shownPopups = {}
function StaticPopup_FindVisible(which) return q.shownPopups[which] end
function StaticPopup_Hide(which)
	local d = q.shownPopups[which]
	if d then
		call("StaticPopup_Hide", which, d.inviteAccepted or false)
		q.shownPopups[which] = nil
	end
end
function q.showPopup(which) q.shownPopups[which] = { which = which } end

GuildInviteFrame = CreateFrame("Frame", "GuildInviteFrame", UIParent)
GuildInviteFrame:Hide()
GuildInviteFrame:SetScript("OnHide", function() call("GuildInviteFrame:Hide") end)

-- UIErrorsFrame:SetMessageTypeEnabled as Blizzard_UIErrorsFrame defines it.
LE_GAME_ERR_OUT_OF_RAGE, LE_GAME_ERR_OUT_OF_RANGE, LE_GAME_ERR_SPELL_COOLDOWN = 101, 102, 103
LE_GAME_ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS, LE_GAME_ERR_INV_FULL = 104, 105
BLACK_LISTED_MESSAGE_TYPES = { [LE_GAME_ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS] = true } -- Forever's Camelot override
function UIErrorsFrame.SetMessageTypeEnabled(self, t, enabled) BLACK_LISTED_MESSAGE_TYPES[t] = not enabled end

-- Guild repair
function CanGuildBankRepair() return q.repair.guild == true end

-- Installed addons that have not loaded (yet): q.installed[name] = true
-- (enabled for this character) or false (disabled).
q.installed = {}
function C_AddOns.DoesAddOnExist(name) return q.installed[name] ~= nil or stub.addonsLoaded[name] == true end
function C_AddOns.GetAddOnInfo(name)
	local enabled = q.installed[name] == true or stub.addonsLoaded[name] == true
	return name, name, "", enabled, enabled and nil or "DISABLED", "INSECURE"
end

---------------------------------------------------------------------------
-- Engine, Nav, Pins fakes and the map half of Compat
---------------------------------------------------------------------------

local Engine = {}
q.Engine = Engine
function Engine.GetStepIndex() return q.engine.step end
function Engine.GetStepView(i) if i == q.engine.step then return q.engine.view end end
function Engine.GetGuide() return q.engine.guide end
function Engine.GetWaypoint() return q.engine.waypoint end
function Engine.IsClassTrainer(npc) return npc ~= nil and q.classTrainers[npc] == true end

-- A step from raw goals: views get status "active" unless goal.status says otherwise.
function q.step(goals, index)
	index = index or (q.engine.step or 0) + 1
	local raw, views = {}, {}
	for g, goal in ipairs(goals) do
		local r = {}
		for k, v in pairs(goal) do if k ~= "status" and k ~= "subject" then r[k] = v end end
		raw[g] = r
		views[g] = {
			index = g, t = goal.t, status = goal.status or "active",
			subject = goal.subject or goal.target or goal.itemName or goal.location,
			quest = goal.quest, npc = goal.npc, item = goal.item,
		}
	end
	local steps = {}
	steps[index] = { goals = raw }
	q.engine.step = index
	q.engine.view = { index = index, status = "current", goals = views }
	q.engine.guide = { id = "test", steps = steps }
	Polestar.Fire("STEP_CHANGED", index)
	stub.runTimers()
end

local Nav = {}
q.Nav = Nav
function Nav.SetTarget(map, x, y, label, f)
	local t = { map = map, x = x, y = y, label = label, f = f, kind = "manual" }
	q.nav.target = t
	table.insert(q.nav.sets, t)
	return true
end
function Nav.GetTarget() return q.nav.target end
function Nav.ReleaseTarget()
	q.nav.releases = q.nav.releases + 1
	q.nav.target = nil
end
function Nav.ClearTarget()
	q.nav.clears = q.nav.clears + 1
	q.nav.target = nil
end
function Nav.GetRoute() return q.nav.route, q.nav.route and q.nav.ci or nil end

local Pins = {}
q.Pins = Pins
function Pins.SetLayer(layer, pins, opts) q.pins[layer] = pins end
function Pins.ClearLayer(layer) q.pins[layer] = nil end

local MAP = { c = 0, top = 1000, bottom = -1000, left = 1000, right = -1000 }
local MAPS = {
	[9000] = MAP,
	[9002] = { c = 0, top = -1000, bottom = -3000, left = 1000, right = -1000 },
	[9100] = { c = 0, top = 1000, bottom = -3000, left = 1000, right = -1000 },
}
local ZONES = { 9000, 9002 }

C_Map = C_Map or {}
function C_Map.GetMapInfo(id)
	if not MAPS[id] then return nil end
	return { mapID = id, mapType = id == 9100 and 2 or 3, parentMapID = id == 9100 and 0 or 9100 }
end

local function mapToWorld(map, x, y)
	local m = MAPS[map]
	if not m then return nil end
	return m.c, m.top + (m.bottom - m.top) * y / 100, m.left + (m.right - m.left) * x / 100
end
local function worldToMap(c, wx, wy, map)
	local m = MAPS[map]
	if not m or c ~= m.c then return nil end
	return (wy - m.left) / (m.right - m.left) * 100, (wx - m.top) / (m.bottom - m.top) * 100
end
-- The zone whose map holds a world point: map, x, y.
local function zoneAt(c, wx, wy)
	for _, id in ipairs(ZONES) do
		local x, y = worldToMap(c, wx, wy, id)
		if x and x >= 0 and x <= 100 and y >= 0 and y <= 100 then return id, x, y end
	end
end
Nav.journey = {}
function Nav.journey.ZonePoint(map, x, y)
	if map ~= 9100 then return map, x, y end
	return zoneAt(mapToWorld(map, x, y))
end

function q.mapPoint(wx, wy)
	return 9000, (wy - MAP.left) / (MAP.right - MAP.left) * 100, (wx - MAP.top) / (MAP.bottom - MAP.top) * 100
end

local addonLoaded = stub.addonLoaded
function stub.addonLoaded(name)
	if name == "Polestar" and Polestar then
		Polestar.Engine = Engine
		Polestar.Nav = Nav
		Polestar.Pins = Pins
		local C = Polestar.Compat
		function C.MapToWorld(map, x, y, frame)
			if frame == "e" then return nil end
			return mapToWorld(map, x, y)
		end
		C.WorldToMap = worldToMap
		function C.GetPlayerWorldPosition()
			local p = q.player
			return p.c, p.wx, p.wy
		end
		function C.GetPlayerMapPosition()
			local p = q.player
			if p.c ~= MAP.c then return nil end
			local map, x, y = zoneAt(p.c, p.wx, p.wy)
			if not map then map, x, y = q.mapPoint(p.wx, p.wy) end
			return map, x, y
		end
		function C.GetPlayerInfo() return { name = "Testchar", level = q.level, faction = "Alliance" } end
		function C.GetNpcID(unit) if unit == "npc" then return q.npc end end
		function C.GetBindLocation() return q.bind end
		function C.IsShiftKeyDown() return stub.keys.shift end
	end
	return addonLoaded(name)
end
