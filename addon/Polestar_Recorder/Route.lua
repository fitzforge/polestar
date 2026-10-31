-- Route telemetry (docs/RECORDING.md, "Guide", "Movement"): where the player
-- stands in Polestar's guide, so the data build can measure each step (time,
-- XP, combat vs travel), and with or without Polestar: combat start/end, AFK
-- on/off and revives.
--
-- `step` reasons: `next` (Engine.Next), `skip` (Engine.Skip, or the engine
-- stepping past a step whose quests are unavailable: STEP_SKIPPED), `back`
-- (Engine.Prev, or any move to an earlier step), `pick` (Engine.Goto, a
-- guide picked or switched), `done` (GUIDE_COMPLETED), `auto` (the engine
-- moving on by itself; also the step in force when a session starts). The
-- player's actions are hooked (hooksecurefunc: after the engine has moved),
-- so a step change is written a moment later, with the reason its action
-- left.
--
-- Polestar is optional: everything here reads it through the global, guarded
-- and pcall'd, and attaches whenever it shows up (it may load after us).

local ADDON, ns = ...

local type, pcall, GetTime = type, pcall, GetTime

local DEDUP_WINDOW = 1 -- seconds: GUIDE_CHANGED then STEP_CHANGED for the same state
local REASON_WINDOW = 1 -- seconds an action's reason waits for its step change

local function engine()
	local P = Polestar
	if type(P) ~= "table" or type(P.Engine) ~= "table" then return nil end
	return P.Engine
end

local function call(E, name)
	local fn = E and E[name]
	if type(fn) ~= "function" then return nil end
	local ok, v = pcall(fn)
	if ok then return v end
	return nil
end

local function guideIdOf(v)
	if type(v) == "table" then v = v.id end
	if type(v) == "string" then return v end
	return nil
end

-- The active tab's guide id and step index.
local function active()
	local E = engine()
	local g = guideIdOf(call(E, "GetGuide"))
	local i = call(E, "GetStepIndex")
	return g, type(i) == "number" and i or nil
end

local last = { guide = nil, step = nil, at = -math.huge }
local hint = { reason = nil, at = -math.huge } -- the player's last guide action
local queued -- { guide, step, reason, p } waiting for its action's reason

local function write(guide, step, reason, p)
	if not ns.Rec("step", guide, step, reason, p) then return end
	if reason ~= "done" then last.guide, last.step, last.at = guide, step, GetTime() end
end

local function flushQueued()
	local q = queued
	queued = nil
	if not q then return end
	local reason = q.reason
	if GetTime() - hint.at <= REASON_WINDOW and hint.reason then
		reason = hint.reason
		hint.reason = nil
	end
	write(q.guide, q.step, reason, q.p)
end

local function same(guide, step)
	return guide == last.guide and step == last.step and GetTime() - last.at < DEDUP_WINDOW
end

local function onStepChanged(index)
	local guide = active()
	local step = type(index) == "number" and index or nil
	if same(guide, step) then return end
	local reason = "auto"
	if guide == last.guide and step and last.step and step < last.step then reason = "back" end
	if queued then flushQueued() end
	queued = { guide = guide, step = step, reason = reason, p = ns.P() }
	C_Timer.After(0, flushQueued)
end

local function onGuideChanged(id)
	id = guideIdOf(id)
	local guide, step = active()
	if guide ~= id then step = nil end
	if same(id, step) then return end
	if queued then flushQueued() end
	write(id, step, "pick", ns.P())
end

local function onGuideCompleted(id)
	id = guideIdOf(id)
	if id then write(id, nil, "done", ns.P()) end
end

local function onSkipped() hint.reason, hint.at = "skip", GetTime() end

local HOOKS = { Next = "next", Skip = "skip", Prev = "back", Goto = "pick" }

local attached = false
local function attach()
	if attached then return end
	local P = Polestar
	if type(P) ~= "table" or type(P.On) ~= "function" then return end
	attached = true
	P.On("STEP_CHANGED", onStepChanged)
	P.On("GUIDE_CHANGED", onGuideChanged)
	P.On("GUIDE_COMPLETED", onGuideCompleted)
	P.On("STEP_SKIPPED", onSkipped)
	local E = engine()
	if E then
		for name, reason in pairs(HOOKS) do
			if type(E[name]) == "function" then
				hooksecurefunc(E, name, function() hint.reason, hint.at = reason, GetTime() end)
			end
		end
	end
end
ns.AttachPolestar = attach

ns.On("ADDON_LOADED", function(_, name)
	if name == ADDON or name == "Polestar" then attach() end
end)
ns.On("PLAYER_LOGIN", attach)

---------------------------------------------------------------------------
-- Combat, AFK, revive
---------------------------------------------------------------------------

local REVIVE_WINDOW = 30 -- seconds between the spirit healer's dialog and the revive

local combat, afk, dead = false, false, false
local spiritHealerAt, resurrectAt = -math.huge, -math.huge
local released = false

local function inCombat()
	if UnitAffectingCombat then
		local v = UnitAffectingCombat("player")
		if ns.Usable(v) then return v and true or false end
	end
	return false
end

ns.On("PLAYER_REGEN_DISABLED", function()
	combat = true
	ns.Rec("combat", true, ns.P())
end)

ns.On("PLAYER_REGEN_ENABLED", function()
	if not combat then return end
	combat = false
	ns.Rec("combat", false, ns.P())
end)

ns.On("PLAYER_FLAGS_CHANGED", function(_, unit)
	if unit ~= "player" or not UnitIsAFK then return end
	local v = UnitIsAFK("player")
	if not ns.Usable(v) then return end
	v = v and true or false
	if v == afk then return end
	afk = v
	ns.Rec("afk", v)
end)

ns.On("PLAYER_DEAD", function()
	dead, released = true, false
end)

-- Released: a ghost now.
ns.On("PLAYER_ALIVE", function()
	if dead and UnitIsGhost and UnitIsGhost("player") then released = true end
end)
ns.On("CONFIRM_XP_LOSS", function() spiritHealerAt = GetTime() end)
ns.On("RESURRECT_REQUEST", function() resurrectAt = GetTime() end)

-- PLAYER_ALIVE also fires on releasing the spirit (still a ghost); only a
-- living player counts as revived. How: the spirit healer (its dialog came
-- up), the corpse (a ghost back alive), else resurrected by someone.
local function revived()
	if not dead then return end
	if UnitIsDeadOrGhost and UnitIsDeadOrGhost("player") then return end
	dead = false
	local now = GetTime()
	local how
	if now - spiritHealerAt <= REVIVE_WINDOW then
		how = "s"
	elseif now - resurrectAt <= REVIVE_WINDOW or not released then
		how = "r"
	else
		how = "c"
	end
	ns.Rec("revive", ns.P(), how)
end
ns.On("PLAYER_ALIVE", revived)
ns.On("PLAYER_UNGHOST", revived)

---------------------------------------------------------------------------
-- Session start (login or /reload): where the guide stands now
---------------------------------------------------------------------------

ns.OnSession(function()
	attach()
	last.guide, last.step, last.at = nil, nil, -math.huge
	queued = nil
	combat = inCombat()
	afk = false
	if UnitIsAFK then
		local v = UnitIsAFK("player")
		if ns.Usable(v) then afk = v and true or false end
	end
	dead = UnitIsDeadOrGhost and UnitIsDeadOrGhost("player") and true or false
	released = dead and UnitIsGhost and UnitIsGhost("player") and true or false
	local guide, step = active()
	if guide then write(guide, step, "auto", ns.P()) end
end)
