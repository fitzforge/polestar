-- Session (spec 4.3): while testing a draft, time on the current step, XP
-- per hour, deaths, laps and their yield (farm loops), and a timeline. It
-- answers "is this route smooth?".
--
--   S.UI.Session.Lap()   -- close a farm loop: items looted since the last lap

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local Theme, W = UI.Theme, UI.W
local format, floor, ipairs, max, tostring = string.format, math.floor, ipairs, math.max, tostring

local SE = {}
UI.Session = SE
local widget
local TIMELINE = 40

local state = { start = nil, stepAt = nil, step = nil, xp = 0, deaths = 0, laps = {}, lapLoot = 0, lapStart = nil, events = {} }

local function now() return GetTime() end

local function clock(s)
	s = floor(s or 0)
	if s >= 3600 then return format("%d:%02d:%02d", floor(s / 3600), floor(s / 60) % 60, s % 60) end
	return format("%d:%02d", floor(s / 60), s % 60)
end

local function event(text)
	if not state.start then return end
	local list = state.events
	list[#list + 1] = { at = now() - state.start, text = text }
	if #list > TIMELINE then table.remove(list, 1) end
	if widget and widget:IsShown() then widget:Refresh() end
end

function SE.Reset()
	state = { start = now(), stepAt = now(), step = nil, xp = 0, deaths = 0, laps = {}, lapLoot = 0, lapStart = now(), events = {} }
	state.lastXP = UnitXP and UnitXP("player") or 0
	state.lastMax = UnitXPMax and UnitXPMax("player") or 0
	event(L["Session started"])
end

function SE.Lap()
	if not state.start then SE.Reset() end
	local t = now() - (state.lapStart or now())
	state.laps[#state.laps + 1] = { secs = t, loot = state.lapLoot }
	event(format(L["Lap %d: %s, %d items"], #state.laps, clock(t), state.lapLoot))
	state.lapLoot, state.lapStart = 0, now()
end

local function refresh(f)
	if not state.start then
		f.Lines:SetText(L["Start a session, then play your draft: Studio times each step, counts XP, deaths and farm laps."])
		f.Timeline:SetText("")
		W.SetButtonText(f.Start, L["Start"])
		return
	end
	W.SetButtonText(f.Start, L["Restart"])
	local total = now() - state.start
	local perHour = total > 0 and state.xp / total * 3600 or 0
	local lines = {
		format(L["Session %s"], clock(total)),
		format(L["On this step %s%s"], clock(now() - (state.stepAt or state.start)), state.step and format(L[" (step %d)"], state.step) or ""),
		format(L["XP %d  \194\183  %d per hour"], state.xp, floor(perHour + 0.5)),
		format(L["Deaths %d"], state.deaths),
	}
	if #state.laps > 0 or state.lapLoot > 0 then
		local sum, secs = 0, 0
		for _, l in ipairs(state.laps) do sum, secs = sum + l.loot, secs + l.secs end
		local n = max(1, #state.laps)
		lines[#lines + 1] = format(L["Laps %d  \194\183  %.1f items per lap  \194\183  %s per lap  \194\183  this lap %d"], #state.laps, sum / n, clock(secs / n), state.lapLoot)
	end
	f.Lines:SetText(table.concat(lines, "\n"))
	local tl = {}
	for k = #state.events, max(1, #state.events - 9), -1 do
		local e = state.events[k]
		tl[#tl + 1] = clock(e.at) .. "  " .. e.text
	end
	f.Timeline:SetText(table.concat(tl, "\n"))
end

-- Polestar's own step changes: time on step and the timeline.
if P.On then
	P.On("STEP_CHANGED", function(current)
		if not state.start then return end
		local spent = now() - (state.stepAt or state.start)
		if state.step then event(format(L["Step %d done in %s"], state.step, clock(spent))) end
		state.step, state.stepAt = current, now()
	end)
end

S.RegisterEvent("PLAYER_XP_UPDATE", function()
	if not state.start then return end
	local xp, top = UnitXP("player"), UnitXPMax("player")
	local gain = xp - (state.lastXP or xp)
	if gain < 0 then gain = (state.lastMax or 0) - (state.lastXP or 0) + xp end
	state.xp = state.xp + max(0, gain)
	state.lastXP, state.lastMax = xp, top
end)
S.RegisterEvent("PLAYER_LEVEL_UP", function(_, level) event(format(L["Reached level %s"], tostring(level))) end)
S.RegisterEvent("PLAYER_DEAD", function()
	if not state.start then return end
	state.deaths = state.deaths + 1
	event(L["Died"])
end)
S.RegisterEvent("QUEST_TURNED_IN", function(_, q) event(format(L["Turned in %s"], UI.QuestTitle and UI.QuestTitle(q) or tostring(q))) end)
S.RegisterEvent("QUEST_ACCEPTED", function(_, a, b)
	local q = b or a
	event(format(L["Accepted %s"], UI.QuestTitle and UI.QuestTitle(q) or tostring(q)))
end)
S.RegisterEvent("CHAT_MSG_LOOT", function(_, msg, ...)
	if not state.start or type(msg) ~= "string" then return end
	local own = LOOT_ITEM_SELF and msg:find((LOOT_ITEM_SELF:gsub("%%s", "")), 1, true)
	local multi = LOOT_ITEM_SELF_MULTIPLE and msg:find((LOOT_ITEM_SELF_MULTIPLE:gsub("%%s.*", "")), 1, true)
	if own or multi then
		local n = tonumber(msg:match("x(%d+)%.?$")) or 1
		state.lapLoot = state.lapLoot + n
	end
end)

UI.Widget("Session", "Session", 320, 260, function(f)
	widget = f
	local b = f.Body
	f.Lines = UI.Text(b, "label", "text", true)
	f.Lines:SetPoint("TOPLEFT", b, "TOPLEFT", 12, -10)
	f.Lines:SetPoint("RIGHT", b, "RIGHT", -12, 0)
	f.Lines:SetSpacing(3)
	f.Timeline = UI.Text(b, "small", "textDim", true)
	f.Timeline:SetPoint("TOPLEFT", b, "TOPLEFT", 12, -100)
	f.Timeline:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -12, 40)
	f.Start = W.Button(b, L["Start"], function() SE.Reset(); refresh(f) end, { height = 24, primary = true })
	f.Start:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 10, 8)
	f.LapB = W.Button(b, L["Lap"], function() SE.Lap(); refresh(f) end, { height = 24 })
	f.LapB:SetPoint("LEFT", f.Start, "RIGHT", 6, 0)
	f.LapB.psTip = L["A farm loop done: Studio notes its time and the items looted on it."]
	f.Refresh = refresh
	local t = 0
	f:SetScript("OnUpdate", function(self, dt)
		t = t + dt
		if t < 1 then return end
		t = 0
		refresh(self)
	end)
end, { point = { "TOPRIGHT", "TOPRIGHT", -220, -200 } })
