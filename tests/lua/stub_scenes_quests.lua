-- The quest scenes (rust/crates/forge-addontest/tests/scenes: questlog, automation, firstrun, update): a
-- character placed partway through the guide Polestar loaded for it, NPCs to talk to, the client pieces the
-- shared stubs leave out (bags, repair, invitations: below), and saved variables written out as the client
-- writes them at logout. Loaded after stub_world.lua.
--
--   ScenesQ.goldshire()                  Elwynn Forest (map 1429), standing by Marshal Dughan in Goldshire, level 10
--   ScenesQ.wetlands()                   Wetlands (map 1437), at Menethil Harbor, level 27
--   local at = ScenesQ.place(npc)        after login: the quest log and the quests turned in for the step of the
--                                        loaded guide that hands in most quests to `npc` (its number: at.step);
--                                        at.ready / at.working: the guide's quests in the log, finished or not
--   ScenesQ.walked(at)                   then the goals of no quest before that step ticked: the guide stands there
--   ScenesQ.inGuide(q)                   whether the loaded guide names quest q
--   local added, named = ScenesQ.fillLog(25)   finished quests the guide does not name, until the log holds 25
--   ScenesQ.talk(npc, "gossip"|"greeting")     opens the NPC's window with the log's quests it ends, again after
--                                        each automatic action; -> the busiest open's CPU ms
--   ScenesQ.serialize(value)             a value as Lua source
--   ScenesQ.saved({ "PolestarDB", ... }) "PolestarDB = {...}\n...": those globals, as the client saves them

local w = stub.world
ScenesQ = {}

function ScenesQ.goldshire()
	w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
	w.zone, w.subzone = "Elwynn Forest", "Goldshire"
	w.moveTo(1429, 42.3, 66.2)
	w.level = 10
	w.resting = true
end

function ScenesQ.wetlands()
	w.addMap(1437, { name = "Wetlands", c = 0, left = -389.583, right = -4525, top = -2147.917, bottom = -4904.167 })
	w.zone, w.subzone = "Wetlands", "Menethil Harbor"
	w.moveTo(1437, 10.8, 59.7)
	w.level = 27
end

local function guide()
	local E = Polestar and Polestar.Engine
	return E and E.GetGuide and E.GetGuide()
end

function ScenesQ.inGuide(q)
	local g = guide()
	for _, step in ipairs(g and g.steps or {}) do
		for _, goal in ipairs(step.goals or {}) do
			if goal.quest == q then return true end
		end
	end
	return false
end

-- The client's state for a character that has played the loaded guide up to step `at`: every quest the guide
-- turns in before it turned in; every quest it took before it and has not handed in, in the log (finished when
-- the guide's work for it, a kill, a collect, comes before `at`, or it has none); the professions it trained
-- before it learned. No events: the client's state as it logs in; QUEST_LOG_UPDATE after.
local function playTo(g, at)
	local accepted, handed, worked = {}, {}, {}
	for i, step in ipairs(g.steps) do
		for _, goal in ipairs(step.goals or {}) do
			local q = goal.quest
			if q then
				if goal.t == "accept" then accepted[q] = accepted[q] or i
				elseif goal.t == "turnin" then handed[q] = handed[q] or i
				else worked[q] = worked[q] or i end
			end
			if goal.t == "train" and goal.skillLine and i < at then
				w.skills[goal.skillLine] = { name = goal.skill or "Skill", rank = goal.rankMax or 75, maxRank = goal.rankMax or 75 }
			end
		end
	end
	local done, ready, working = {}, {}, {}
	for q, i in pairs(handed) do
		if i < at then done[#done + 1] = q end
	end
	w.complete(done)
	for q, i in pairs(accepted) do
		if i < at and not (handed[q] and handed[q] < at) then
			local finished = not worked[q] or worked[q] < at
			w.onQuest(q, { { required = 1, fulfilled = finished and 1 or 0 } })
			local list = finished and ready or working
			list[#list + 1] = q
		end
	end
	table.sort(ready)
	table.sort(working)
	return { step = at, ready = ready, working = working }
end

function ScenesQ.place(npc)
	local g = guide()
	if not g then return nil end
	local best, most = nil, 0
	for i, step in ipairs(g.steps) do
		local n = 0
		for _, goal in ipairs(step.goals or {}) do
			if goal.t == "turnin" and goal.npc == npc then n = n + 1 end
		end
		if n > most then best, most = i, n end
	end
	if not best then return nil end
	local at = playTo(g, best)
	at.guide = g.id
	stub.fire("SKILL_LINES_CHANGED")
	stub.fire("QUEST_LOG_UPDATE")
	stub.advance(3)
	return at
end

-- After ScenesQ.place: the goals of no quest (travel, hearth, training, vendors) in the loaded guide's steps
-- before `at` ticked in the save, as a player who walked the route there has them, so the guide stands at `at`.
function ScenesQ.walked(at)
	local g = guide()
	if not (g and at) then return end
	PolestarCharDB.manual = PolestarCharDB.manual or {}
	local m = PolestarCharDB.manual[g.id] or {}
	PolestarCharDB.manual[g.id] = m
	for s = 1, at.step - 1 do
		for i, goal in ipairs(g.steps[s].goals) do
			if not goal.quest then m[s .. ":" .. i] = true end
		end
	end
	stub.fire("QUEST_LOG_UPDATE")
	stub.advance(3)
end

-- Finished quests the Elwynn guide does not name: five whose enders stand in Goldshire (quest -> NPC: Marshal
-- Dughan, Smith Argus, Innkeeper Farley), then ones handed in elsewhere.
ScenesQ.OFF_NEAR = { { 123, 240 }, { 147, 240 }, { 176, 240 }, { 118, 514 }, { 69, 295 } }
ScenesQ.OFF_FAR = { 12, 102, 22, 65, 132, 135, 92, 26, 36, 38, 151, 153, 9, 64, 103, 104, 116, 125, 127, 128 }

local function logSize()
	local n = 0
	for _ in pairs(w.log) do n = n + 1 end
	return n
end

-- Fills the log to `n` quests with finished quests the loaded guide does not name (the near ones first):
-- -> the quests added, and those of the lists the guide names (left out).
function ScenesQ.fillLog(n)
	local added, named = {}, {}
	local function add(q)
		if logSize() >= n or w.log[q] then return end
		if ScenesQ.inGuide(q) then named[#named + 1] = q return end
		w.onQuest(q, { { required = 1, fulfilled = 1 } })
		added[#added + 1] = q
	end
	for _, e in ipairs(ScenesQ.OFF_NEAR) do add(e[1]) end
	for _, q in ipairs(ScenesQ.OFF_FAR) do add(q) end
	stub.fire("QUEST_LOG_UPDATE")
	stub.advance(3)
	return added, named
end

-- Quest -> the NPC that ends it: the loaded guide's hand-in NPC, or OFF_NEAR's.
function ScenesQ.enders()
	local out = {}
	for _, e in ipairs(ScenesQ.OFF_NEAR) do out[e[1]] = e[2] end
	local g = guide()
	for _, step in ipairs(g and g.steps or {}) do
		for _, goal in ipairs(step.goals or {}) do
			if goal.t == "turnin" and goal.quest and goal.npc and not out[goal.quest] then out[goal.quest] = goal.npc end
		end
	end
	return out
end

-- Talks to `npc` ("gossip" or "greeting" window) offering the log's quests it ends, and again after each
-- automatic action (the client opens the window again after a hand-in), at most 8 times. -> the CPU ms the
-- busiest open took.
function ScenesQ.talk(npc, how)
	local ends, worst = ScenesQ.enders(), 0
	for _ = 1, 8 do
		local active = {}
		for q in pairs(w.log) do
			if ends[q] == npc then active[#active + 1] = { questID = q, isComplete = C_QuestLog.ReadyForTurnIn(q) } end
		end
		table.sort(active, function(a, b) return a.questID < b.questID end)
		local before = #Scene.autoLog
		local cost = Scene.work(function()
			if how == "greeting" then w.greeting(npc, { active = active }) else w.gossip(npc, { active = active }) end
			stub.advance(0.5)
		end)
		worst = math.max(worst, cost.ms)
		for _ = 1, 6 do if w.frame then stub.advance(0.5) end end
		if w.frame then w.close() end
		stub.advance(0.5)
		if #Scene.autoLog == before then break end
	end
	return worst
end

local function key(k)
	if type(k) == "string" and k:match("^[%a_][%w_]*$") then return k end
	if type(k) == "string" then return "[" .. string.format("%q", k) .. "]" end
	return "[" .. tostring(k) .. "]"
end

local function write(v, out, seen)
	local t = type(v)
	if t == "string" then out[#out + 1] = string.format("%q", v)
	elseif t == "number" then
		if v ~= v or v == math.huge or v == -math.huge then out[#out + 1] = "0" else out[#out + 1] = string.format("%.17g", v) end
	elseif t == "boolean" then out[#out + 1] = tostring(v)
	elseif t == "table" then
		if seen[v] then error("a saved table holds itself", 0) end
		seen[v] = true
		out[#out + 1] = "{"
		local keys = {}
		for k in pairs(v) do
			local kt = type(k)
			if kt == "string" or kt == "number" or kt == "boolean" then keys[#keys + 1] = k end
		end
		table.sort(keys, function(a, b)
			local ta, tb = type(a), type(b)
			if ta ~= tb then return ta < tb end
			if ta == "boolean" then return tostring(a) < tostring(b) end
			return a < b
		end)
		for _, k in ipairs(keys) do
			local value = v[k]
			local vt = type(value)
			if vt == "string" or vt == "number" or vt == "boolean" or vt == "table" then
				out[#out + 1] = key(k) .. "="
				write(value, out, seen)
				out[#out + 1] = ","
			end
		end
		out[#out + 1] = "}"
		seen[v] = nil
	else out[#out + 1] = "nil" end
end

function ScenesQ.serialize(value)
	local out = {}
	write(value, out, {})
	return table.concat(out)
end

function ScenesQ.saved(names)
	local out = {}
	for _, name in ipairs(names) do
		local v = _G[name]
		if v ~= nil then out[#out + 1] = name .. " = " .. ScenesQ.serialize(v) end
	end
	return table.concat(out, "\n")
end

---------------------------------------------------------------------------
-- Client pieces the shared stubs leave out, so an automatic action reaches the scene's counters: bags with a
-- grey item (C_Container), the merchant's repair, the flight map's TakeTaxiNode, the answers to invitations,
-- summons, resurrections and duels, the trainer. Globals defined here are wrapped by the counters
-- (tests/scenes/common.rs COUNTERS); the others count themselves (ScenesQ.act).
--
--   ScenesQ.bag[slot] = { id, count }    bag 0's slots (16); w.itemInfo[id].price: its sell price
--   ScenesQ.repairCost                   copper GetRepairAllCost answers (0: nothing to repair)
--   ScenesQ.invite(name, friend)         PARTY_INVITE_REQUEST from a friend or a stranger
---------------------------------------------------------------------------

-- An action the counters do not wrap: counted as they count theirs.
function ScenesQ.act(label, a)
	if not Scene then return end
	Scene.auto[label] = (Scene.auto[label] or 0) + 1
	Scene.autoLog[#Scene.autoLog + 1] = label .. "(" .. tostring(a) .. ")"
end

ScenesQ.bag, ScenesQ.repairCost, ScenesQ.friends = {}, 0, {}
NUM_BAG_SLOTS = NUM_BAG_SLOTS or 4

local getItemInfo = C_Item.GetItemInfo
function C_Item.GetItemInfo(item)
	local r = { getItemInfo(item) }
	local id = tonumber(item) or tonumber(tostring(item):match("item:(%d+)"))
	local it = id and w.itemInfo[id]
	if r[1] and it and it.price then r[11] = it.price end
	return unpack(r, 1, 14)
end
GetItemInfo = C_Item.GetItemInfo

C_Container = C_Container or {}
function C_Container.GetContainerNumSlots(bag) return bag == 0 and 16 or 0 end
function C_Container.GetContainerNumFreeSlots(bag)
	if bag ~= 0 then return 0, 0 end
	local used = 0
	for _ in pairs(ScenesQ.bag) do used = used + 1 end
	return 16 - used, 0
end
function C_Container.GetContainerItemInfo(bag, slot)
	local s = bag == 0 and ScenesQ.bag[slot]
	if not s then return nil end
	local it = w.itemInfo[s.id] or {}
	return { itemID = s.id, quality = it.quality or 1, stackCount = s.count or 1, hasNoValue = not it.price, isLocked = false,
		hyperlink = ("|cff9d9d9d|Hitem:%d::::::::|h[%s]|h|r"):format(s.id, it.name or "?"), iconFileID = 134400 }
end
function C_Container.GetContainerItemID(bag, slot) local s = bag == 0 and ScenesQ.bag[slot]; return s and s.id end
function C_Container.GetContainerItemQuestInfo() return { isQuestItem = false, questID = nil, isActive = false } end
-- At a merchant, using an item sells it.
function C_Container.UseContainerItem(bag, slot)
	local s = bag == 0 and ScenesQ.bag[slot]
	if not s then return end
	if w.frame and w.frame.kind == "merchant" then
		ScenesQ.bag[slot] = nil
		w.items[s.id] = nil
		stub.fire("BAG_UPDATE", 0)
		stub.fire("BAG_UPDATE_DELAYED")
	end
end
UseContainerItem = C_Container.UseContainerItem

function GetRepairAllCost() return ScenesQ.repairCost, ScenesQ.repairCost > 0 end
function RepairAllItems() ScenesQ.repairCost = 0 end
function CanGuildBankRepair() return false end
function BuyMerchantItem() end
function GetMerchantNumItems() return 0 end
function TakeTaxiNode() end
function ConfirmBinder() end
function AcceptGroup() end
function DeclineGroup() end
function DeclineGuild() ScenesQ.act("DeclineGuild") end
function CancelDuel() ScenesQ.act("CancelDuel") end
function AcceptResurrect() ScenesQ.act("AcceptResurrect") end
function RepopMe() ScenesQ.act("RepopMe") end
function QuestLogPushQuest(q) ScenesQ.act("QuestLogPushQuest", q) end
function BuyTrainerService(i) ScenesQ.act("BuyTrainerService", i) end
function GetNumTrainerServices() return 0 end
C_SummonInfo = C_SummonInfo or {}
function C_SummonInfo.ConfirmSummon() ScenesQ.act("C_SummonInfo.ConfirmSummon") end
function C_SummonInfo.GetSummonConfirmSummoner() return "Ana" end
function C_SummonInfo.GetSummonConfirmAreaName() return "Goldshire" end
function C_SummonInfo.GetSummonConfirmTimeLeft() return 110 end
C_FriendList = C_FriendList or {}
function C_FriendList.IsFriend(guid) return ScenesQ.friends[guid] == true end
function C_FriendList.GetFriendInfo(name) return ScenesQ.friends[name] and { name = name, connected = true } or nil end

function ScenesQ.invite(name, friend)
	local guid = "Player-1-" .. name
	ScenesQ.friends[guid], ScenesQ.friends[name] = friend or nil, friend or nil
	stub.fire("PARTY_INVITE_REQUEST", name, false, false, false, false, false, guid)
end

---------------------------------------------------------------------------
-- Login and the client state an update carries
--
--   ScenesQ.loginMs()                    CPU ms from PLAYER_LOGIN (before any addon's handler) to now
--   ScenesQ.world()                      the quest log, the quests turned in and the professions, as Lua source
--   ScenesQ.restore(t)                   puts a ScenesQ.world() table back (before login: no events)
--   ScenesQ.disabled                     names passed to C_AddOns.DisableAddOn
---------------------------------------------------------------------------

do
	local clock = CreateFrame("Frame")
	clock:RegisterEvent("PLAYER_LOGIN")
	clock:SetScript("OnEvent", function() ScenesQ.loginAt = os.clock() end)
end

function ScenesQ.loginMs()
	return ScenesQ.loginAt and (os.clock() - ScenesQ.loginAt) * 1000 or -1
end

function ScenesQ.world()
	return ScenesQ.serialize({ log = w.log, completed = w.completed, skills = w.skills })
end

function ScenesQ.restore(t)
	for q, e in pairs(t.log or {}) do w.log[q] = e end
	for q, v in pairs(t.completed or {}) do w.completed[q] = v end
	for line, s in pairs(t.skills or {}) do w.skills[line] = s end
end

ScenesQ.disabled = {}
local disable = C_AddOns.DisableAddOn
function C_AddOns.DisableAddOn(name, ...)
	ScenesQ.disabled[#ScenesQ.disabled + 1] = tostring(name)
	for _, a in ipairs(stub.addons) do
		if a.name == name then a.enabled = false end
	end
	if disable then return disable(name, ...) end
end
DisableAddOn = C_AddOns.DisableAddOn

-- A reward window's items (QuestFrame QuestInfo: GetQuestItemInfo / GetQuestItemLink): its choices are
-- ScenesQ.choices' items in order, a cloth and a leather piece by default.
ScenesQ.choices = { 2577, 2578 }
w.itemInfo[2577] = { name = "Blended Bean Brew", quality = 1, classID = 0, subclassID = 0 }
w.itemInfo[2578] = { name = "Barbaric Linen Vest", quality = 2, classID = 4, subclassID = 2 }
function GetNumQuestRewards() return 0 end
function GetQuestItemInfo(kind, i)
	local id = kind == "choice" and i <= GetNumQuestChoices() and ScenesQ.choices[i]
	if not id then return nil end
	local it = w.itemInfo[id] or {}
	return it.name or "?", 134400, 1, it.quality or 1, true, id
end
function GetQuestItemLink(kind, i)
	local id = kind == "choice" and i <= GetNumQuestChoices() and ScenesQ.choices[i]
	if not id then return nil end
	return ("|cffffffff|Hitem:%d::::::::|h[%s]|h|r"):format(id, (w.itemInfo[id] or {}).name or "?")
end
GetQuestLogItemLink = GetQuestItemLink

-- The reward window's choice buttons (QuestInfoRewardsFrame.RewardButtons), shown while a reward window is open
-- (Polestar marks the best choice on them).
QuestInfoFrame = QuestInfoFrame or CreateFrame("Frame", "QuestInfoFrame", UIParent)
QuestInfoFrame.rewardsFrame = QuestInfoFrame.rewardsFrame or CreateFrame("Frame", "QuestInfoRewardsFrame", QuestInfoFrame)
QuestInfoRewardsFrame = QuestInfoFrame.rewardsFrame
QuestInfoRewardsFrame.RewardButtons = {}
for i = 1, 2 do
	local b = CreateFrame("Button", "QuestInfoRewardsFrameQuestInfoItem" .. i, QuestInfoRewardsFrame)
	b.type, b.objectType = "choice", "item"
	b:SetID(i)
	QuestInfoRewardsFrame.RewardButtons[i] = b
end
QuestInfoRewardsFrame:Hide()
local questComplete, close = w.questComplete, w.close
function w.questComplete(npc, q, opts)
	local n = opts and opts.choices or w.choices[q] or 0
	for i, b in ipairs(QuestInfoRewardsFrame.RewardButtons) do b:SetShown(i <= n) end
	QuestInfoRewardsFrame:Show()
	return questComplete(npc, q, opts)
end
function w.close()
	QuestInfoRewardsFrame:Hide()
	return close()
end
