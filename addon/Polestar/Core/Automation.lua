-- Quest automation: accept and turn in the quests the guide wants right now.
-- Contract: docs/ARCHITECTURE.md, "Engine" (Automation).
--
-- Rules: settings behavior.autoAccept / behavior.autoTurnin; holding Shift
-- suppresses both; only `accept`/`turnin` goals of the live step qualify
-- (never a step ahead, nor one the player only looks at); a reward with
-- several choices is always
-- left to the player, as are quests that cost money or flag for PvP, and
-- (behavior.warnClosing) quests that close another one for good.
--
-- After an accept or turn-in of its own, the game often opens the NPC's next
-- window by itself: the follow-up of the quest just handed in, or the NPC's
-- other quests again (#360). With behavior.closeSkipped (on by default),
-- that window is closed when it shows only quests the guide is not taking
-- now: only the first quest window the game opens at the same NPC within
-- FOLLOW seconds of Polestar's own accept or turn-in, never one the player
-- opened, never with Shift held or in combat, and never a gossip window that
-- also offers the NPC's other services.
--
-- Quest frame functions are the Forever (Mainline-family) ones used by
-- Blizzard_UIPanels_Game/Mainline/QuestFrame.lua: GetQuestID, AcceptQuest,
-- AcknowledgeAutoAcceptQuest, QuestGetAutoAccept, QuestFlagsPVP,
-- IsQuestCompletable, CompleteQuest, GetNumQuestChoices, GetQuestMoneyToGet,
-- GetQuestReward, GetNumActiveQuests, GetActiveTitle, GetActiveQuestID,
-- SelectActiveQuest, GetNumAvailableQuests, GetAvailableQuestInfo,
-- SelectAvailableQuest, CloseQuest; gossip uses C_GossipInfo (select by
-- questID, as GossipFrameShared.lua does; GetOptions, CloseGossip).

local ADDON, ns = ...

local L = ns.L

local Automation = {}
ns.Automation = Automation

local function suppressed()
	return ns.Compat.IsShiftKeyDown()
end

local function canAccept()
	return ns.Get("behavior.autoAccept") and not suppressed()
end

local function canTurnIn()
	return ns.Get("behavior.autoTurnin") and not suppressed()
end

local function wantsAccept(q)
	return q and q ~= 0 and ns.Engine.WantsQuest("accept", q)
end

-- A `turnin ... direct`: handed in straight from the giver's window with no
-- accept, so the NPC lists it among the quests it offers, not the ones in the
-- log. Picking it there opens the progress window, which onProgress finishes.
-- Wanted only while its goal is not done (a repeatable's giver keeps offering it).
local function wantsDirect(q)
	return q and q ~= 0 and ns.Engine.WantsQuest("direct", q)
end

-- A quest in the log by its `turnin` goal; one not in the log (its progress or
-- reward panel opened from the giver's offers) only by a `direct` goal not done.
local function wantsTurnIn(q)
	if not (q and q ~= 0) then return false end
	if ns.Compat.IsOnQuest(q) then return ns.Engine.WantsQuest("turnin", q) end
	return wantsDirect(q)
end

local function questID()
	return GetQuestID and GetQuestID() or nil
end

---------------------------------------------------------------------------
-- The window the game opens after Polestar's accept or turn-in (#360)
---------------------------------------------------------------------------

-- The game opens its next window at the NPC as soon as the server answers;
-- a window later than this is one the player opened.
local FOLLOW = 2
local acted -- { npc, at }: the NPC of Polestar's last accept or turn-in, and when

-- Called just before Polestar's own accept or turn-in, while the NPC is open.
local function noteActed()
	local npc = ns.Compat.GetNpcID("npc")
	acted = npc and { npc = npc, at = GetTime() } or nil
end

-- Whether the quest window just opened is the one the game opened by itself
-- after Polestar's accept or turn-in at this NPC. Only the first window after
-- it counts: whatever opens next, the player opened.
local function gameFollowUp()
	local a = acted
	acted = nil
	if not a then return false end
	return a.npc == ns.Compat.GetNpcID("npc") and GetTime() - a.at <= FOLLOW
end

-- A quest the guide takes now: one to accept that is not taken yet, one in
-- the log to hand in, or one to hand in `direct`, whatever the automation
-- settings (with one of them off, the player does it). The guide's step can
-- lag the accept just made, so the log decides between accept and turn-in.
local function guideTakes(q)
	if not (q and q ~= 0) then return false end
	local C, E = ns.Compat, ns.Engine
	if C.IsOnQuest(q) then return E.WantsQuest("turnin", q) end
	if E.WantsQuest("direct", q) then return true end
	return E.WantsQuest("accept", q) and not C.IsQuestCompleted(q)
end

local function anyTaken(list, key)
	for i = 1, #list do
		if guideTakes(list[i][key or "questID"]) then return true end
	end
	return false
end

local function mayClose()
	return ns.Get("behavior.closeSkipped") and not suppressed() and not ns.Compat.InCombat()
end

-- The quest window ("detail" or "greeting") or gossip window the game opened
-- after Polestar's accept or turn-in: closed when it shows nothing the guide
-- takes. An unknown quest (id 0) is left open.
local function closeSkipped(kind)
	if not mayClose() then return end
	if kind == "detail" then
		local q = questID()
		if not (q and q ~= 0) or guideTakes(q) then return end
	elseif kind == "greeting" then
		local list = {}
		for i = 1, GetNumActiveQuests and GetNumActiveQuests() or 0 do list[#list + 1] = { questID = GetActiveQuestID(i) } end
		for i = 1, GetNumAvailableQuests and GetNumAvailableQuests() or 0 do
			list[#list + 1] = { questID = select(5, GetAvailableQuestInfo(i)) }
		end
		if anyTaken(list) then return end
	else
		local G = C_GossipInfo
		if not (G and G.CloseGossip and G.GetOptions) then return end
		if #(G.GetOptions() or {}) > 0 then return end -- a vendor, trainer, innkeeper...: the player may want it
		if anyTaken(G.GetActiveQuests and G.GetActiveQuests() or {}) then return end
		if anyTaken(G.GetAvailableQuests and G.GetAvailableQuests() or {}) then return end
		G.CloseGossip()
		return
	end
	if CloseQuest then CloseQuest() end
end

-- The quest window functions return true when they acted.

---------------------------------------------------------------------------
-- Quest frame
---------------------------------------------------------------------------

local function onDetail()
	if not canAccept() then return false end
	local q = questID()
	if not wantsAccept(q) then return false end
	if ns.Closes.HoldsOffer() then return false end -- closes another quest for good: the player chooses
	if QuestFlagsPVP and QuestFlagsPVP() then return false end -- needs the PvP confirmation
	noteActed()
	if QuestGetAutoAccept and QuestGetAutoAccept() then
		if AcknowledgeAutoAcceptQuest then AcknowledgeAutoAcceptQuest() end
	elseif AcceptQuest then
		AcceptQuest()
	end
	return true
end

local function onProgress()
	if not canTurnIn() then return end
	local q = questID()
	if not wantsTurnIn(q) then return end
	if IsQuestCompletable and IsQuestCompletable() and CompleteQuest then CompleteQuest() end
end

local function onComplete()
	if not canTurnIn() then return end
	local q = questID()
	if not wantsTurnIn(q) then return end
	local choices = GetNumQuestChoices and GetNumQuestChoices() or 0
	if choices > 1 then
		ns.Print(L["Choose a reward to finish the turn-in."])
		return
	end
	local money = GetQuestMoneyToGet and GetQuestMoneyToGet() or 0
	if money and money > 0 then return end -- costs gold: leave the confirmation to the player
	noteActed()
	if GetQuestReward then GetQuestReward(choices == 1 and 1 or 0) end
end

-- Greeting panel (several quests from one NPC/object): turn-ins first, since
-- they often unlock the follow-up to accept.
local function onGreeting()
	local turnin, accept = canTurnIn(), canAccept()
	if not (turnin or accept) then return false end
	local numActive = GetNumActiveQuests and GetNumActiveQuests() or 0
	if turnin and GetActiveTitle and GetActiveQuestID and SelectActiveQuest then
		for i = 1, numActive do
			local _, isComplete = GetActiveTitle(i)
			if isComplete and wantsTurnIn(GetActiveQuestID(i)) then
				SelectActiveQuest(i)
				return true
			end
		end
	end
	local numAvailable = GetNumAvailableQuests and GetNumAvailableQuests() or 0
	if (accept or turnin) and GetAvailableQuestInfo and SelectAvailableQuest then
		for i = 1, numAvailable do
			local q = select(5, GetAvailableQuestInfo(i))
			if (accept and wantsAccept(q)) or (turnin and wantsDirect(q)) then
				SelectAvailableQuest(i)
				return true
			end
		end
	end
	return false
end

---------------------------------------------------------------------------
-- Gossip
---------------------------------------------------------------------------

local function onGossip()
	local G = C_GossipInfo
	if not G then return false end
	local turnin, accept = canTurnIn(), canAccept()
	if turnin and G.GetActiveQuests and G.SelectActiveQuest then
		local active = G.GetActiveQuests() or {}
		for i = 1, #active do
			local info = active[i]
			if info.isComplete and wantsTurnIn(info.questID) then
				G.SelectActiveQuest(info.questID)
				return true
			end
		end
	end
	if (accept or turnin) and G.GetAvailableQuests and G.SelectAvailableQuest then
		local available = G.GetAvailableQuests() or {}
		for i = 1, #available do
			local info = available[i]
			if (accept and wantsAccept(info.questID)) or (turnin and wantsDirect(info.questID)) then
				G.SelectAvailableQuest(info.questID)
				return true
			end
		end
	end
	return false
end

-- Exposed for tests and for a future "do it now" button.
Automation.OnQuestDetail = onDetail
Automation.OnQuestProgress = onProgress
Automation.OnQuestComplete = onComplete
Automation.OnQuestGreeting = onGreeting
Automation.OnGossipShow = onGossip

-- The Engine handles the same events (talk tracking); it does not depend on
-- the order. Automation needs the Engine's current step, which is fresh as
-- of the last evaluation.
--
-- A window the game opens after Polestar's accept or turn-in that automation
-- does not act on is closed when it shows nothing the guide takes. The close
-- waits for the next frame, so the Engine reads the window first (it notes
-- the quests an NPC offers), and is dropped if the window has changed since.
local windows = 0 -- quest and gossip windows opened or closed so far

-- kind: "detail", "greeting" or "gossip"; nil for the progress and reward
-- windows, never closed (they are a turn-in under way).
local function follow(handler, kind)
	return function()
		windows = windows + 1
		local after = gameFollowUp()
		if handler() or not (after and kind) then return end
		local mine = windows
		local function close() if windows == mine then closeSkipped(kind) end end
		if C_Timer and C_Timer.After then ns.After(0, close) else close() end
	end
end

local function changed() windows = windows + 1 end

ns.RegisterEvent("QUEST_DETAIL", follow(onDetail, "detail"))
ns.RegisterEvent("QUEST_PROGRESS", follow(onProgress))
ns.RegisterEvent("QUEST_COMPLETE", follow(onComplete))
ns.RegisterEvent("QUEST_GREETING", follow(onGreeting, "greeting"))
ns.RegisterEvent("GOSSIP_SHOW", follow(onGossip, "gossip"))
ns.RegisterEvent("QUEST_FINISHED", changed)
ns.RegisterEvent("GOSSIP_CLOSED", changed)
