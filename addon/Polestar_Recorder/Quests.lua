-- Quest records (docs/RECORDING.md, "Quests"): offer, detail, text, accept,
-- objectives, progress (diffs of C_QuestLog.GetQuestObjectives, positioned
-- at each increment), complete, turnin, abandon, the gossip option chosen,
-- and escort/timed quests. Also ns.Wanted(): the item objectives open now,
-- the drop-chance denominator of every `loot` record.

local ADDON, ns = ...

local type, pairs, ipairs, GetTime, tonumber, select, concat = type, pairs, ipairs, GetTime, tonumber, select, table.concat
local usable, Str, Num = ns.Usable, ns.Str, ns.Num

local CONTEXT_TTL = 600 -- seconds a QUEST_DETAIL / QUEST_COMPLETE context stays valid
local SCAN_DELAY = 0.1 -- coalesces bursts of quest log events into one scan
local OFFER_REPEAT = 60 -- a quest detail within this long of the same NPC's gossip is no new offer
local INDEX_SLICE = 200 -- quests per step while building the NPC -> quests index
local INDEX_STEP = 0.05

-- questID -> { cur = { [oi] = numFulfilled }, ready, fresh, listed (objectives recorded), escort }
local tracked = {}
local turnedIn = {} -- questID -> GetTime() of QUEST_TURNED_IN
local detail, completion -- NPC/position contexts of the open quest frame
local chosen -- { q, item } from GetQuestReward
local lastOffer = { kind = nil, id = nil, at = -math.huge }
local scanQueued = false
local progressHooks = {}
local wanted, wantedDirty = nil, true

-- fn(q, oi, objective, delta, t) after every recorded progress increment.
function ns.OnProgress(fn) progressHooks[#progressHooks + 1] = fn end

local function questID()
	local q = GetQuestID and GetQuestID()
	if type(q) == "number" and q > 0 then return q end
	return nil
end

local function isReady(q)
	if C_QuestLog.ReadyForTurnIn and C_QuestLog.ReadyForTurnIn(q) then return true end
	return C_QuestLog.IsComplete and C_QuestLog.IsComplete(q) and true or false
end

-- totalXp of a quest in the log, or nil while unknown. The global is what
-- Forever's own UI calls (Blizzard_FrameXMLUtil QuestUtils.lua) but it is
-- not in the API documentation, so it may vanish.
local function rewardXP(q)
	if type(GetQuestLogRewardXP) ~= "function" then return nil end
	local ok, total = pcall(GetQuestLogRewardXP, q)
	if not ok or type(total) ~= "number" or total <= 0 then return nil end
	return total
end

-- The ids of every quest in the log, in log order.
local function logIds()
	local out = {}
	if not (C_QuestLog.GetNumQuestLogEntries and C_QuestLog.GetInfo) then return out end
	for i = 1, C_QuestLog.GetNumQuestLogEntries() or 0 do
		local info = C_QuestLog.GetInfo(i)
		if info and not info.isHeader and type(info.questID) == "number" and info.questID > 0 then out[#out + 1] = info.questID end
	end
	return out
end

---------------------------------------------------------------------------
-- Objectives: the `objectives` record, progress, complete, escorts
---------------------------------------------------------------------------

local OBJ_TYPES = { monster = true, item = true, object = true, event = true, reputation = true, log = true }

-- "Kobold Vermin slain: 0/3" -> "Kobold Vermin slain" (also "0/3 Kobold ...").
local function objectiveText(text)
	if not (usable(text) and type(text) == "string") then return "" end
	text = text:gsub("%s*:?%s*%d+%s*/%s*%d+%s*$", ""):gsub("^%s*%d+%s*/%s*%d+%s*", "")
	return ns.ListText(ns.Scrub(text))
end

local function recordObjectives(q, objs)
	local out = {}
	for oi = 1, #objs do
		local o = objs[oi]
		local kind = usable(o.type) and OBJ_TYPES[o.type] and o.type or "log"
		out[oi] = kind .. ":" .. (Num(o.numRequired) and ("%d"):format(o.numRequired) or "") .. ":" .. objectiveText(o.text)
	end
	return ns.Rec("objectives", q, concat(out, ";"))
end

local function timed(q)
	if not C_QuestLog.GetTimeAllowed then return false end
	local ok, total = pcall(C_QuestLog.GetTimeAllowed, q)
	return ok and Num(total) ~= nil and total > 0
end

local function failed(q)
	return C_QuestLog.IsFailed and C_QuestLog.IsFailed(q) and true or false
end

-- Snapshot a quest's objectives without recording progress. `fresh`: just
-- accepted, so the objectives the client lists later count from 0 and are
-- recorded once they appear.
local function track(q, fresh)
	local st = tracked[q]
	if not st then
		st = { cur = {} }
		tracked[q] = st
	end
	local objs = C_QuestLog.GetQuestObjectives(q)
	if objs and #objs > 0 then
		for oi = 1, #objs do st.cur[oi] = objs[oi].numFulfilled or 0 end
		st.fresh = false
		if fresh and recordObjectives(q, objs) then st.listed = true end
	else
		st.fresh = fresh and true or false
	end
	if not fresh then st.listed = true end
	st.ready = isReady(q)
	wantedDirty = true
	return st
end

-- Every quest already in the log (at session start).
local function trackLog()
	for _, q in ipairs(logIds()) do
		if not tracked[q] then track(q, false) end
	end
end

local function escort(q, st, on)
	if (st.escort or false) == on then return end
	st.escort = on
	ns.Rec("escort", q, on, ns.P())
end

local function scan()
	scanQueued = false
	wantedDirty = true
	for q, st in pairs(tracked) do
		if C_QuestLog.IsOnQuest(q) then
			local objs = C_QuestLog.GetQuestObjectives(q)
			if objs then
				if not st.listed and #objs > 0 and recordObjectives(q, objs) then st.listed = true end
				local cur = st.cur
				for oi = 1, #objs do
					local o = objs[oi]
					local now = o.numFulfilled or 0
					local prev = cur[oi]
					if prev == nil and st.fresh then prev = 0 end
					if prev ~= nil and now > prev then
						if ns.Rec("progress", q, oi, now, o.numRequired, ns.P()) then
							local t = GetTime()
							for i = 1, #progressHooks do progressHooks[i](q, oi, o, now - prev, t) end
						end
					end
					cur[oi] = now
				end
				if #objs > 0 then st.fresh = false end
			end
			local ready = isReady(q)
			if st.ready == false and ready then ns.Rec("complete", q) end
			st.ready = ready
			local runs = timed(q) and not ready and not failed(q)
			if runs or st.escort then escort(q, st, runs) end
		end
	end
end

local function queueScan()
	wantedDirty = true
	if scanQueued then return end
	scanQueued = true
	C_Timer.After(SCAN_DELAY, scan)
end
ns.ScanQuests = scan

-- q, oi of the first unfinished objective of `kind` ("monster", "item")
-- whose text mentions `name`.
function ns.FindObjective(name, kind)
	if not name or name == "" then return nil end
	for q in pairs(tracked) do
		local objs = C_QuestLog.GetQuestObjectives(q)
		if objs then
			for oi = 1, #objs do
				local o = objs[oi]
				if not o.finished and (not kind or o.type == kind) and usable(o.text) and type(o.text) == "string" and o.text:find(name, 1, true) then
					return q, oi
				end
			end
		end
	end
	return nil
end

-- `questId:index` of every unfinished item objective in the log (nil: none).
function ns.Wanted()
	if not wantedDirty then return wanted end
	wantedDirty = false
	local out = {}
	for _, q in ipairs(logIds()) do
		local objs = C_QuestLog.GetQuestObjectives(q)
		if objs then
			for oi = 1, #objs do
				local o = objs[oi]
				if o.type == "item" and not o.finished then out[#out + 1] = ("%d:%d"):format(q, oi) end
			end
		end
	end
	wanted = #out > 0 and concat(out, ";") or nil
	return wanted
end

---------------------------------------------------------------------------
-- What Polestar's data says an NPC or object starts (for `offer`): an index
-- built from Polestar.QuestDB (or Polestar.Codex) when one is loaded, a
-- slice per step so it never stalls a frame. Never loads either.
---------------------------------------------------------------------------

local starts -- "c<npc>" | "o<object>" -> { questID, ... }, once built
local building

local function addStart(index, key, q)
	local list = index[key]
	if not list then
		list = {}
		index[key] = list
	end
	list[#list + 1] = q
end

-- The number of quests and step(i, index) adding quest i's starters, or nil
-- when no Polestar data is loaded.
local function indexSource()
	local P = Polestar
	if type(P) ~= "table" then return nil end
	local Q = P.QuestDB
	if type(Q) == "table" and type(Q.IsLoaded) == "function" and Q.IsLoaded() and type(Q.QuestIds) == "function"
		and type(Q.QuestRecord) == "function" and type(Q.Each) == "function" and type(Q.F) == "table" then
		local ids, field = Q.QuestIds(), Q.F.START
		return #ids, function(i, index)
			local q = ids[i]
			local r = Q.QuestRecord(q)
			if r then
				for _, ref in Q.Each(r[field]) do
					if type(ref) == "number" then addStart(index, ref > 0 and "c" .. ref or "o" .. -ref, q) end
				end
			end
		end
	end
	local C = P.Codex
	if type(C) == "table" and type(C.IsLoaded) == "function" and C.IsLoaded() and type(C.Each) == "function" and type(C.Quest) == "function" then
		local ids = {}
		C.Each("quest", function(id) ids[#ids + 1] = id end)
		return #ids, function(i, index)
			local rec = C.Quest(ids[i])
			local s = type(rec) == "table" and rec.start
			if type(s) == "table" then
				for _, n in ipairs(s.npc or {}) do addStart(index, "c" .. n, ids[i]) end
				for _, o in ipairs(s.object or {}) do addStart(index, "o" .. o, ids[i]) end
			end
		end
	end
	return nil
end

-- Builds the index INDEX_SLICE quests per step; `starts` is set once whole.
local function buildStarts()
	if starts or building then return end
	local n, step = indexSource()
	if not n then return end
	building = true
	local index, i = {}, 0
	local ticker
	ticker = C_Timer.NewTicker(INDEX_STEP, function()
		local stop = math.min(n, i + INDEX_SLICE)
		for j = i + 1, stop do step(j, index) end
		i = stop
		if i >= n then
			ticker:Cancel()
			building = false
			starts = index
		end
	end)
end

-- The quests Polestar's data says this NPC/object starts, or nil.
local function startsOf(kind, id)
	if not id or (kind ~= "c" and kind ~= "o") then return nil end
	if not starts then
		buildStarts()
		return nil
	end
	return starts[kind .. id]
end

---------------------------------------------------------------------------
-- Offers: gossip, quest greeting, quest detail
---------------------------------------------------------------------------

local function set(list)
	local s = {}
	for i = 1, #list do s[list[i]] = true end
	return s
end

local function recordOffer(kind, id, available, active)
	local log = logIds()
	local done, notOffered = {}, {}
	local candidates = startsOf(kind, id)
	if candidates then
		local shown, inLog = set(available), set(log)
		for _, q in ipairs(active) do shown[q] = true end
		for _, q in ipairs(candidates) do
			if C_QuestLog.IsQuestFlaggedCompleted and C_QuestLog.IsQuestFlaggedCompleted(q) then
				done[#done + 1] = q
			elseif not shown[q] and not inLog[q] then
				notOffered[#notOffered + 1] = q
			end
		end
	end
	lastOffer.kind, lastOffer.id, lastOffer.at = kind, id, GetTime()
	ns.Rec("offer", kind, id, ns.P(), ns.Ids(available), ns.Ids(active), ns.Ids(log), ns.Ids(done), ns.Ids(notOffered))
end

local function idsOf(list)
	local out = {}
	if type(list) == "table" then
		for i = 1, #list do
			local id = list[i] and list[i].questID
			if Num(id) and id > 0 then out[#out + 1] = id end
		end
	end
	return out
end

ns.On("GOSSIP_SHOW", function()
	if not (C_GossipInfo and ns.Recording()) then return end
	local available = idsOf(C_GossipInfo.GetAvailableQuests and C_GossipInfo.GetAvailableQuests())
	local active = idsOf(C_GossipInfo.GetActiveQuests and C_GossipInfo.GetActiveQuests())
	local kind, id = ns.Ref("npc")
	recordOffer(kind, id, available, active)
end)

ns.On("QUEST_GREETING", function()
	if not ns.Recording() then return end
	local available, active = {}, {}
	if GetNumAvailableQuests and GetAvailableQuestInfo then
		for i = 1, GetNumAvailableQuests() do
			local id = select(5, GetAvailableQuestInfo(i))
			if Num(id) and id > 0 then available[#available + 1] = id end
		end
	end
	if GetNumActiveQuests and GetActiveQuestID then
		for i = 1, GetNumActiveQuests() do
			local id = GetActiveQuestID(i)
			if Num(id) and id > 0 then active[#active + 1] = id end
		end
	end
	local kind, id = ns.Ref("npc")
	recordOffer(kind, id, available, active)
end)

---------------------------------------------------------------------------
-- Detail, text, accept
---------------------------------------------------------------------------

-- The NPC (or object) and position of the open quest frame.
local function context(q)
	local kind, id = ns.Ref("npc")
	local ctx = { q = q, kind = kind, id = id, at = GetTime() }
	ctx.map, ctx.x, ctx.y = ns.Position()
	return ctx
end

local function take(ctx, q)
	if not ctx then return nil end
	if ctx.q and ctx.q ~= q then return nil end
	if GetTime() - ctx.at > CONTEXT_TTL then return nil end
	return ctx
end

-- `itemId:count` of the open quest frame's rewards ("reward") or choices.
local function frameItems(kind, n)
	if not (Num(n) and n > 0) then return nil end
	local out = {}
	for i = 1, n do
		local _, _, count, _, _, id = GetQuestItemInfo(kind, i)
		if not (Num(id) and id > 0) then
			local link = GetQuestItemLink and GetQuestItemLink(kind, i)
			id = Str(link) and tonumber(link:match("item:(%d+)")) or nil
		end
		if id then out[#out + 1] = ("%d:%d"):format(id, Num(count) or 1) end
	end
	return #out > 0 and concat(out, ";") or nil
end

-- The rewards the quest frame shows (QUEST_DETAIL, QUEST_COMPLETE).
local function frameRewards(ctx)
	if type(GetQuestItemInfo) ~= "function" then return end
	if GetNumQuestRewards then ctx.items = frameItems("reward", GetNumQuestRewards()) end
	if GetNumQuestChoices then ctx.choices = frameItems("choice", GetNumQuestChoices()) end
	local money = Num(GetRewardMoney and GetRewardMoney())
	if money and money > 0 then ctx.rewardMoney = money end
end

local function recordText(q)
	local seen = ns.TextSeen()
	if seen[q] or not ns.Recording() then return end
	local title = Str(GetTitleText and GetTitleText())
	local objective = Str(GetObjectiveText and GetObjectiveText())
	local text = Str(GetQuestText and GetQuestText())
	if not (title or objective or text) then return end
	if ns.Rec("text", q, ns.Scrub(title), ns.Scrub(objective), ns.Scrub(text)) then seen[q] = true end
end

-- An item-started quest fires QUEST_DETAIL twice: once with the item id when
-- the item is used, again (without it) when its quest popup is clicked. The
-- second keeps the item of the first when it is for the same quest.
ns.On("QUEST_DETAIL", function(_, questStartItemID)
	local prev = detail
	local q = questID()
	detail = context(q)
	if Num(questStartItemID) and questStartItemID > 0 then
		detail.item = questStartItemID
	elseif prev and prev.item and prev.q == detail.q and detail.at - prev.at <= CONTEXT_TTL then
		detail.item = prev.item
		if not detail.kind then
			-- the popup has no giver unit; the item use's position is the start point
			detail.map, detail.x, detail.y = prev.map, prev.x, prev.y
		end
	end
	if not detail.kind and detail.item then detail.kind, detail.id = "i", detail.item end
	frameRewards(detail)
	if not (q and ns.Recording()) then return end
	local repeated = detail.kind == lastOffer.kind and detail.id == lastOffer.id and detail.at - lastOffer.at <= OFFER_REPEAT
	if not repeated and detail.kind ~= "i" then recordOffer(detail.kind, detail.id, { q }, {}) end
	-- The item quest's popup shows the same detail again: one record.
	local again = prev and prev.q == q and prev.kind == detail.kind and prev.id == detail.id and detail.at - prev.at <= OFFER_REPEAT
	if not again then ns.Rec("detail", q, detail.kind, detail.id, ns.PAt(detail.map, detail.x, detail.y), detail.item) end
	recordText(q)
end)

ns.On("QUEST_ACCEPTED", function(_, q)
	if not Num(q) then return end
	local ctx = take(detail, q)
	if ctx then detail = nil end
	ctx = ctx or context(nil)
	turnedIn[q] = nil
	ns.Rec("accept", q, ctx.kind, ctx.id, ns.PAt(ctx.map, ctx.x, ctx.y), UnitLevel("player"), rewardXP(q), ctx.rewardMoney, ctx.items, ctx.choices)
	track(q, true)
end)

---------------------------------------------------------------------------
-- Turn-in, abandon
---------------------------------------------------------------------------

local function onCompletionFrame(event)
	completion = context(questID())
	-- the reward frame; QUEST_PROGRESS shows only what the quest asks for
	if event == "QUEST_COMPLETE" then frameRewards(completion) end
end
ns.On("QUEST_PROGRESS", onCompletionFrame)
ns.On("QUEST_COMPLETE", onCompletionFrame)

-- The reward the player picks (hooked: runs after the client's own).
if type(GetQuestReward) == "function" then
	hooksecurefunc("GetQuestReward", function(choice)
		local q = questID()
		local id
		if Num(choice) and choice > 0 and type(GetQuestItemInfo) == "function" then id = Num(select(6, GetQuestItemInfo("choice", choice))) end
		chosen = { q = q, item = id }
	end)
end

ns.On("QUEST_TURNED_IN", function(_, q, xpReward, moneyReward)
	if not Num(q) then return end
	turnedIn[q] = GetTime()
	local ctx = take(completion, q)
	if ctx then completion = nil end
	ctx = ctx or context(nil)
	local item = chosen and chosen.q == q and chosen.item or nil
	chosen = nil
	local st = tracked[q]
	if st and st.escort then escort(q, st, false) end
	ns.Rec("turnin", q, ctx.kind, ctx.id, ns.PAt(ctx.map, ctx.x, ctx.y), UnitLevel("player"), Num(xpReward), Num(moneyReward), item)
	tracked[q] = nil
	wantedDirty = true
end)

-- QUEST_REMOVED fires for turn-ins too; a removal that no turn-in explains
-- (within a second, either order) is an abandon.
ns.On("QUEST_REMOVED", function(_, q)
	if not Num(q) then return end
	local st = tracked[q]
	tracked[q] = nil
	wantedDirty = true
	C_Timer.After(1, function()
		if turnedIn[q] then return end
		if C_QuestLog.IsQuestFlaggedCompleted and C_QuestLog.IsQuestFlaggedCompleted(q) then return end
		if st and st.escort then escort(q, st, false) end
		ns.Rec("abandon", q)
	end)
end)

ns.On("QUEST_LOG_UPDATE", queueScan)
ns.On("UNIT_QUEST_LOG_CHANGED", function(_, unit)
	if unit == "player" then queueScan() end
end)
ns.On("QUEST_WATCH_UPDATE", function(_, q)
	if Num(q) and not tracked[q] and C_QuestLog.IsOnQuest(q) then track(q, false) end
	queueScan()
end)

---------------------------------------------------------------------------
-- Gossip options chosen (hooked, never replaced)
---------------------------------------------------------------------------

local function optionText(match)
	local ok, options = pcall(C_GossipInfo.GetOptions)
	if not ok or type(options) ~= "table" then return nil, nil end
	for i, o in ipairs(options) do
		if match(o, i) then return Num(o.gossipOptionID), Str(o.name) end
	end
	return nil, nil
end

local function recordOption(id, text)
	if not ns.Recording() then return end
	local kind, npc = ns.Ref("npc")
	ns.Rec("gossip", kind, npc, ns.P(), id, ns.Scrub(text))
end

if C_GossipInfo then
	if type(C_GossipInfo.SelectOption) == "function" then
		hooksecurefunc(C_GossipInfo, "SelectOption", function(optionID)
			local id, text = optionText(function(o) return o.gossipOptionID == optionID end)
			recordOption(id or Num(optionID), text)
		end)
	end
	if type(C_GossipInfo.SelectOptionByIndex) == "function" then
		hooksecurefunc(C_GossipInfo, "SelectOptionByIndex", function(index)
			local id, text = optionText(function(o, i) return (o.orderIndex or (i - 1)) == index end)
			recordOption(id, text)
		end)
	end
end

---------------------------------------------------------------------------
-- Session start: baseline every quest already in the log
---------------------------------------------------------------------------

ns.OnSession(function()
	tracked = {}
	detail, completion, chosen = nil, nil, nil
	lastOffer.kind, lastOffer.id, lastOffer.at = nil, nil, -math.huge
	wantedDirty = true
	trackLog()
	buildStarts()
end)

-- The log is only fully populated after login; pick up anything missed.
ns.On("PLAYER_ENTERING_WORLD", function()
	C_Timer.After(2, trackLog)
end)
