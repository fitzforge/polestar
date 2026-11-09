-- Live sync: the current draft plays in Polestar's guide window as it is
-- built (Polestar.Studio.SetDraft, spec 7.6). 0.5 s after the last edit,
-- never in combat (queued until PLAYER_REGEN_ENABLED). A draft Polestar
-- refuses is not played: Polestar keeps the last good one.
--
--   S.Sync.Enabled() / S.Sync.SetEnabled(on)   (PolestarStudioDB.sync, on by default)
--   S.Sync.Now()      hand the draft over at once (out of combat)
--   S.Sync.Pin(i)     "Play from this step": pin Polestar to step i of the draft
--   S.Sync.State() -> { ok, problems, at, pending }
-- Fires STUDIO_SYNCED(ok, problems).

local ADDON, S = ...
local L = S.L

local Sync = {}
S.Sync = Sync

local DEBOUNCE = 0.5
local state = { ok = nil, problems = nil, at = nil, pending = false }

local function api()
	local P = S.P()
	return P and P.Studio
end

function Sync.Enabled()
	return S.DB().sync and true or false
end

function Sync.State() return state end

local function send()
	local A = api()
	if not (A and A.SetDraft) then
		state.ok, state.problems = false, { L["This Polestar has no draft slot: update Polestar."] }
		S.Fire("STUDIO_SYNCED", false, state.problems)
		return
	end
	if S.InCombat() then
		state.pending = true
		return
	end
	state.pending = false
	local doc = S.Model.Current()
	if not doc then return end
	local payload = S.Model.ToPayload(doc)
	if not payload or #payload.guide.steps == 0 then
		state.ok, state.problems = false, { L["The guide has no step with a goal yet."] }
		S.Fire("STUDIO_SYNCED", false, state.problems)
		return
	end
	local ok, good, problems = pcall(A.SetDraft, payload)
	if not ok then
		good, problems = false, { tostring(good) }
	elseif type(problems) == "string" then
		problems = { problems }
	end
	state.ok, state.problems, state.at = good and true or false, problems, S.Now()
	S.Fire("STUDIO_SYNCED", state.ok, problems)
end

function Sync.Now()
	S.CancelDebounce("sync")
	send()
end

function Sync.SetEnabled(on)
	S.DB().sync = on and true or false
	if on then
		Sync.Now()
	else
		S.CancelDebounce("sync")
		state.pending = false
		local A = api()
		if A and A.ClearDraft then pcall(A.ClearDraft) end
	end
end

function Sync.Pin(i)
	local doc = S.Model.Current()
	local step = doc and doc.steps[i or S.Model.Selected() or 0]
	local A = api()
	if not (step and A and A.PinStep) then return false end
	if S.InCombat() then return false end
	-- the step must be in the draft Polestar plays
	if Sync.Enabled() then Sync.Now() end
	local ok, res = pcall(A.PinStep, doc.header.id, step.id)
	return ok and res ~= false
end

S.On("STUDIO_CHANGED", function(kind)
	if kind == "select" or not Sync.Enabled() then return end
	if kind == "doc" and not S.Model.Current() then
		local A = api()
		if A and A.ClearDraft then pcall(A.ClearDraft) end
		return
	end
	S.Debounce("sync", DEBOUNCE, send)
end)

S.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if state.pending and Sync.Enabled() then send() end
end)

-- The draft of the last session plays again after a reload.
S.RegisterEvent("PLAYER_ENTERING_WORLD", function(_, login, reload)
	if (login or reload) and Sync.Enabled() and S.Model.Current() then
		S.Debounce("sync", 2, send)
	end
end)
