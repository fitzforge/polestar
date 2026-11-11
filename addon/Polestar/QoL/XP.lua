-- XP and pace: XP per hour (this session and the last 15 minutes), time to
-- level, kills and quests to level, rested XP, and per-level splits kept in
-- CharState().qol.xp.splits[level] = { seconds, xp, kills, quests, at, partial }.
--
--   Polestar.QoL.GetXPStats() -> stats | nil (nil while qol.xpTracker is off)
--     stats = { level, xp, xpMax, remaining, percent, rested, restedPercent, maxed,
--               sessionXP, sessionSeconds, sessionRate, rollingRate, rate, timeToLevel,
--               sessionKills, sessionQuests, avgKillXP, avgQuestXP, killsToLevel, questsToLevel,
--               levelSeconds, splits }
--     rates are XP per hour; seconds are play time; one reused table (read it, do not keep it).
--   message QOL_XP_UPDATED(stats) after every XP change
--
-- Where XP came from: QUEST_TURNED_IN carries the quest's XP; the rest of a
-- gain is a kill when CHAT_MSG_COMBAT_XP_GAIN arrives within a second of it
-- (either order), otherwise other XP (exploration). The chat text is never
-- parsed: it can be a secret value in combat.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local readable = ns.Compat.Readable

local type, floor, ceil, min, max = type, math.floor, math.ceil, math.min, math.max
local format = string.format

local XP = {}
QoL.XP = XP

local ROLLING = 900     -- seconds of the rolling rate
local MIN_SPAN = 60     -- rates never divide by less than a minute
local RING = 256        -- recent gains kept for the rolling rate
local KILL_KEEP = 20    -- kills averaged for kills-to-level
local QUEST_KEEP = 10   -- quests averaged for quests-to-level
local MATCH = 1         -- seconds between an XP gain and the event explaining it
XP.ROLLING = ROLLING

---------------------------------------------------------------------------
-- Ring buffers (no allocation per gain)
---------------------------------------------------------------------------

local gainT, gainA, gainHead, gainN = {}, {}, 0, 0
local kills, killHead, killN = {}, 0, 0
local quests, questHead, questN = {}, 0, 0

local function pushGain(t, a)
	gainHead = gainHead % RING + 1
	gainT[gainHead], gainA[gainHead] = t, a
	if gainN < RING then gainN = gainN + 1 end
end

local function rollingSum(now)
	local sum, i = 0, gainHead
	for _ = 1, gainN do
		if now - gainT[i] > ROLLING then break end
		sum = sum + gainA[i]
		i = i - 1
		if i < 1 then i = RING end
	end
	return sum
end

local function pushKill(a)
	killHead = killHead % KILL_KEEP + 1
	kills[killHead] = a
	if killN < KILL_KEEP then killN = killN + 1 end
end

local function popKill()
	if killN == 0 then return end
	kills[killHead] = nil
	killHead = killHead - 1
	if killHead < 1 then killHead = KILL_KEEP end
	killN = killN - 1
end

local function pushQuest(a)
	questHead = questHead % QUEST_KEEP + 1
	quests[questHead] = a
	if questN < QUEST_KEEP then questN = questN + 1 end
end

local function average(list, n, keep, head)
	if n == 0 then return nil end
	local sum, i = 0, head
	for _ = 1, n do
		sum = sum + list[i]
		i = i - 1
		if i < 1 then i = keep end
	end
	return sum / n
end

---------------------------------------------------------------------------
-- State
---------------------------------------------------------------------------

local session = { start = nil, xp = 0, kills = 0, quests = 0 }
local last = { level = nil, xp = 0, xpMax = 0 }
local lastTick
local pendingQuest, pendingAt = 0, 0      -- quest XP announced, not yet seen as a gain
local unclaimed, unclaimedAt = 0, 0       -- a gain waiting for its kill message
local killMsgAt                           -- kill message waiting for its gain
local lastKill, lastKillAt                -- last kill sample (undone if it was a quest)

local function now() return GetTime() end

local function levelState()
	local q = QoL.State()
	local s = q.xp
	if type(s) ~= "table" then
		s = {}
		q.xp = s
	end
	if type(s.splits) ~= "table" then s.splits = {} end
	return s
end

local function freshLevel(s, level, partial)
	s.level = level
	s.levelSeconds, s.levelXP, s.levelKills, s.levelQuests = 0, 0, 0, 0
	s.partial = partial and true or nil
end

-- Play time at this level, persisted.
local function tick()
	local t = now()
	if lastTick then
		local s = levelState()
		s.levelSeconds = (s.levelSeconds or 0) + (t - lastTick)
	end
	lastTick = t
end

local function readClient()
	local level = readable(UnitLevel and UnitLevel("player"))
	local xp = readable(UnitXP and UnitXP("player"))
	local xpMax = readable(UnitXPMax and UnitXPMax("player"))
	return level, xp, xpMax
end

local function closeLevel(s, level)
	s.splits[level] = {
		seconds = floor((s.levelSeconds or 0) + 0.5),
		xp = s.levelXP or 0,
		kills = s.levelKills or 0,
		quests = s.levelQuests or 0,
		at = GetServerTime and GetServerTime() or nil,
		partial = s.partial,
	}
end

local function killSample(a)
	pushKill(a)
	session.kills = session.kills + 1
	local s = levelState()
	s.levelKills = (s.levelKills or 0) + 1
	lastKill, lastKillAt = a, now()
end

local function enabled() return QoL.On("xpTracker") end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local function fireUpdate()
	if enabled() then ns.Fire("QOL_XP_UPDATED", XP.GetStats()) end
end

-- Split one gain into quest XP already announced and the rest.
local function classify(d)
	local t = now()
	if pendingQuest > 0 and t - pendingAt > MATCH * 2 then pendingQuest = 0 end
	local q = min(d, pendingQuest)
	pendingQuest = pendingQuest - q
	local rest = d - q
	if rest <= 0 then return end
	if killMsgAt and t - killMsgAt <= MATCH then
		killMsgAt = nil
		killSample(rest)
	else
		unclaimed, unclaimedAt = rest, t
	end
end

local function onXP()
	local level, xp, xpMax = readClient()
	if not (level and xp and xpMax) then return end
	tick()
	local s = levelState()
	local d = 0
	if last.level then
		if level > last.level or xp < last.xp then
			-- Levelled (UnitLevel can lag one event behind; XP never drops otherwise).
			local newLevel = max(level, last.level + 1)
			local carry = max(0, last.xpMax - last.xp)
			s.levelXP = (s.levelXP or 0) + carry
			closeLevel(s, last.level)
			freshLevel(s, newLevel, false)
			d = carry + xp
			s.levelXP = xp
			level = newLevel
		else
			d = xp - last.xp
			s.levelXP = (s.levelXP or 0) + d
		end
	end
	last.level, last.xp, last.xpMax = level, xp, xpMax
	if d > 0 then
		session.xp = session.xp + d
		pushGain(now(), d)
		classify(d)
	end
	fireUpdate()
end

local function onKillMessage()
	local t = now()
	if unclaimed > 0 and t - unclaimedAt <= MATCH then
		local a = unclaimed
		unclaimed = 0
		killSample(a)
	else
		killMsgAt = t
	end
end

local function onTurnedIn(_, questID, xpReward)
	xpReward = readable(xpReward) or 0
	local s = levelState()
	session.quests = session.quests + 1
	s.levelQuests = (s.levelQuests or 0) + 1
	if xpReward <= 0 then return end
	pushQuest(xpReward)
	local t = now()
	if unclaimed > 0 and t - unclaimedAt <= MATCH then
		-- The gain came first: it was (partly) this quest.
		local a = min(unclaimed, xpReward)
		unclaimed = unclaimed - a
		xpReward = xpReward - a
	elseif lastKill and lastKillAt and t - lastKillAt <= MATCH and lastKill == xpReward then
		-- A kill message and the quest's gain coincided: that "kill" was the quest.
		popKill()
		session.kills = session.kills - 1
		s.levelKills = max(0, (s.levelKills or 0) - 1)
		lastKill = nil
		xpReward = 0
	end
	if xpReward > 0 then
		pendingQuest, pendingAt = pendingQuest + xpReward, t
	end
	fireUpdate()
end
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.xpTracker" or path == "qol" or path == "" then
		ns.Fire("QOL_XP_UPDATED", QoL.GetXPStats())
	end
end)

local function start()
	local level, xp, xpMax = readClient()
	session.start = now()
	lastTick = now()
	if not level then return end
	local s = levelState()
	if s.level ~= level then freshLevel(s, level, (xp or 0) > 0) end
	last.level, last.xp, last.xpMax = level, xp or 0, xpMax or 0
end

ns.OnLogin(start)
ns.RegisterEvent("PLAYER_XP_UPDATE", function(_, unit)
	if unit == nil or unit == "player" then onXP() end
end)
ns.RegisterEvent("QUEST_TURNED_IN", onTurnedIn)
ns.RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN", onKillMessage)
ns.RegisterEvent("UPDATE_EXHAUSTION", fireUpdate)
ns.RegisterEvent("PLAYER_LOGOUT", tick)

---------------------------------------------------------------------------
-- API
---------------------------------------------------------------------------

local stats = {}

function XP.GetStats()
	local level, xp, xpMax = readClient()
	level, xp, xpMax = level or last.level or 0, xp or last.xp or 0, xpMax or last.xpMax or 0
	local t = now()
	local s = levelState()
	local maxLevel = GetMaxPlayerLevel and GetMaxPlayerLevel() or nil
	local maxed = xpMax <= 0 or (maxLevel ~= nil and level >= maxLevel)
	local remaining = maxed and 0 or max(0, xpMax - xp)
	local rested = readable(GetXPExhaustion and GetXPExhaustion()) or 0

	local sessionSeconds = session.start and (t - session.start) or 0
	local sessionRate = session.xp / max(sessionSeconds, MIN_SPAN) * 3600
	local rollingRate = rollingSum(t) / max(min(sessionSeconds, ROLLING), MIN_SPAN) * 3600
	local rate = rollingRate > 0 and rollingRate or sessionRate
	local avgKill = average(kills, killN, KILL_KEEP, killHead)
	local avgQuest = average(quests, questN, QUEST_KEEP, questHead)

	stats.level, stats.xp, stats.xpMax, stats.remaining = level, xp, xpMax, remaining
	stats.percent = xpMax > 0 and xp / xpMax * 100 or 100
	stats.rested = rested
	stats.restedPercent = xpMax > 0 and rested / xpMax * 100 or 0
	stats.maxed = maxed
	stats.sessionXP, stats.sessionSeconds = session.xp, sessionSeconds
	stats.sessionRate, stats.rollingRate, stats.rate = sessionRate, rollingRate, rate
	stats.timeToLevel = (not maxed and rate > 0) and remaining / rate * 3600 or nil
	stats.sessionKills, stats.sessionQuests = session.kills, session.quests
	stats.avgKillXP, stats.avgQuestXP = avgKill, avgQuest
	stats.killsToLevel = (not maxed and avgKill and avgKill > 0) and ceil(remaining / avgKill) or nil
	stats.questsToLevel = (not maxed and avgQuest and avgQuest > 0) and ceil(remaining / avgQuest) or nil
	stats.levelSeconds = (s.levelSeconds or 0) + (lastTick and (t - lastTick) or 0)
	stats.splits = s.splits
	return stats
end

function QoL.GetXPStats()
	if not enabled() then return nil end
	return XP.GetStats()
end

function XP.ResetSession()
	session.start, session.xp, session.kills, session.quests = now(), 0, 0, 0
	gainHead, gainN = 0, 0
	fireUpdate()
end

-- "12.3k" for large numbers.
local function short(n)
	if n >= 10000 then return format("%.1fk", n / 1000) end
	return format("%d", floor(n + 0.5))
end
XP.Short = short

-- One line for chat or a compact footer.
function XP.Summary(st)
	st = st or XP.GetStats()
	if st.maxed then return format(L["Level %d"], st.level) end
	local parts = { format(L["Level %d %.1f%%"], st.level, st.percent) }
	if st.rate > 0 then
		parts[#parts + 1] = format(L["%s XP/h"], short(st.rate))
		parts[#parts + 1] = format(L["%s to level"], QoL.Duration(st.timeToLevel))
	end
	if st.killsToLevel then parts[#parts + 1] = format(L["%d kills"], st.killsToLevel) end
	if st.rested > 0 then parts[#parts + 1] = format(L["rested %s"], short(st.rested)) end
	return table.concat(parts, " · ")
end

ns.RegisterCommand("xp", function()
	local st = QoL.GetXPStats()
	if not st then
		ns.Print(L["The XP tracker is off (Options > Quality of Life > Trackers & map)."])
		return
	end
	ns.Print(XP.Summary(st))
	ns.Print(format(L["Session: %s XP in %s (%s XP/h), %d kills, %d quests"], short(st.sessionXP),
		QoL.Duration(st.sessionSeconds), short(st.sessionRate), st.sessionKills, st.sessionQuests))
	local shown = 0
	for lvl = st.level - 1, 1, -1 do
		local sp = st.splits[lvl]
		if sp then
			ns.Print(format(L["Level %d: %s, %d kills, %d quests%s"], lvl, QoL.Duration(sp.seconds), sp.kills, sp.quests,
				sp.partial and L[" (partial)"] or ""))
			shown = shown + 1
			if shown >= 5 then break end
		end
	end
end, L["XP per hour, time to level and level splits"])
