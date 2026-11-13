-- A bounded, opt-in itinerary over real tab objectives. Engine owns progress;
-- this module only orders snapshots and owns the selected navigation target.
local _, ns = ...
local L = ns.L
local R = { MAX_STEPS = 8, MAX_GOALS = 64, MAX_INSERTIONS = 5 }
ns.CombinedRoute = R
local revision, queued, target, plan = 0, false, nil, nil
local approved, declined, charged = {}, {}, {}
local anchor, spent = nil, 0

function R.State()
	local s = ns.CharState().combinedRoute
	if type(s) ~= "table" or type(s.members) ~= "table" then return nil end
	return s
end

function R.Enabled()
	local s = R.State()
	return s and s.enabled == true and s.main ~= nil
end

function R.OwnsNavigation()
	return R.Enabled() and not R.State().paused and not (UnitIsDeadOrGhost and UnitIsDeadOrGhost("player"))
end
function R.Target() return R.OwnsNavigation() and target or nil end
function R.View() return R.Enabled() and plan or nil end
function R.Approved(key) return approved[key] == true end

-- Pure deterministic planner. estimate may yield, but must not mutate inputs.
-- Only certified eligible goals can be inserted; unknown travel is not zero.
function R.Build(snapshot, estimate, budget, alreadySpent, keep)
	local copies = {}
	for i, source in ipairs(snapshot) do
		local row = {}
		for k, value in pairs(source) do row[k] = value end
		copies[i] = row
	end
	snapshot = copies
	local out, deferred, seen, candidates = {}, {}, {}, {}
	local primary, cursor
	for _, row in ipairs(snapshot) do
		if row.main and row.ready and row.waypoint and not primary then primary = row end
	end
	local remaining = math.max(0, budget - (alreadySpent or 0))
	for _, row in ipairs(snapshot) do
		local existing = row.semantic and seen[row.semantic]
		if existing then
			existing.refs[#existing.refs + 1] = row.ref
			local named = false
			for _, title in ipairs(existing.titles) do if title == row.title then named = true end end
			if not named then existing.titles[#existing.titles + 1] = row.title end
			if row.main then existing.main = true end
		else
			row.refs, row.titles = { row.ref }, { row.title }
			if row.semantic then seen[row.semantic] = row end
			if row.main then
				out[#out + 1] = row
			elseif row.ready and row.waypoint and (primary or row.urgent) then
				candidates[#candidates + 1] = row
			else
				row.reason = row.reason or L["Waiting for earlier objectives"]
				deferred[#deferred + 1] = row
			end
		end
	end
	local inserted = {}
	-- Once explicitly started, an escort or timed chain owns navigation until
	-- its live quest state releases it; the player must not be led away mid-run.
	for i = #candidates, 1, -1 do
		if candidates[i].urgent then table.insert(inserted, 1, table.remove(candidates, i)) end
	end
	if #inserted > 0 or primary and primary.urgent then
		for _, row in ipairs(candidates) do row.reason = L["Finish the active activity first"]; deferred[#deferred + 1] = row end
		candidates = {}
	end
	while primary and #candidates > 0 do
		if #inserted >= R.MAX_INSERTIONS then
			for _, row in ipairs(candidates) do row.reason = L["Upcoming work: plan continues after this stop"]; deferred[#deferred + 1] = row end
			break
		end
		local best, cost
		local base = estimate(cursor, primary.waypoint)
		for i, row in ipairs(candidates) do
			local a, b = estimate(cursor, row.waypoint), estimate(row.waypoint, primary.waypoint)
			local extra = base and a and b and (row.paid and 0 or math.max(0, a + b - base)) or nil
			row.travelUnknown = extra == nil
			if extra and extra <= remaining and (not best or row.key == keep or (candidates[best].key ~= keep and extra < cost)) then
				best, cost = i, extra
			end
		end
		if not best then
			for _, row in ipairs(candidates) do
				row.reason = row.travelUnknown and L["Travel estimate unavailable"] or L["Outside added-travel budget"]
				deferred[#deferred + 1] = row
			end
			break
		end
		local row = table.remove(candidates, best)
		row.extra = cost
		inserted[#inserted + 1], cursor, remaining = row, row.waypoint, remaining - cost
	end
	local result = {}
	for _, row in ipairs(inserted) do result[#result + 1] = row end
	for _, row in ipairs(out) do result[#result + 1] = row end
	for _, row in ipairs(deferred) do result[#result + 1] = row end
	return { rows = result, anchor = primary and (primary.anchor or primary.key), addedTravel = budget - remaining, budget = budget }
end

local function publish(p)
	plan = p
	local nextTarget
	if R.OwnsNavigation() then
		for _, row in ipairs(p.rows) do
			if row.ready and row.waypoint and not row.reason then nextTarget = row; break end
		end
	end
	if nextTarget and not nextTarget.main and not charged[nextTarget.key] then
		charged[nextTarget.key] = true
		spent = spent + (nextTarget.extra or 0)
	end
	R.State().ledger = { anchor = anchor, spent = spent, charged = charged }
	local old = target
	target = nextTarget
	local changed = (old and old.key) ~= (target and target.key)
	if old and target then
		for _, key in ipairs({ "map", "x", "y", "f", "z", "label", "r", "spot" }) do
			if old.waypoint[key] ~= target.waypoint[key] then changed = true end
		end
		if old.ref.raw ~= target.ref.raw then changed = true end
	end
	if changed then
		ns.Fire("WAYPOINT_CHANGED", target and target.waypoint or (not R.OwnsNavigation() and ns.Engine.GetWaypoint() or nil))
	end
	ns.Fire("COMBINED_ROUTE_CHANGED")
end

function R.Invalidate()
	revision = revision + 1
	if queued or not R.Enabled() then return end
	queued = true
	local function begin()
		if not R.Enabled() then queued = false; return end
		local version = revision
		local snapshots = ns.Engine.CombinedSnapshot()
		if not R.Enabled() then queued = false; return end
		for _, row in ipairs(snapshots) do row.paid = charged[row.key] end
		local s = R.State()
		local co = coroutine.create(function()
			local function estimate(a, b)
				local value, why
				repeat
					if ns.Nav and ns.Nav.EstimateTravel then value, why = ns.Nav.EstimateTravel(a, b, true, true) end
					coroutine.yield()
				until why ~= "busy"
				return value
			end
			return R.Build(snapshots, estimate, s.budget or 300, spent, target and target.key)
		end)
		local function advance()
			if version ~= revision or not R.Enabled() then queued = false; R.Invalidate(); return end
			local ok, result = coroutine.resume(co)
			if not ok then
				queued = false
				ns.Debug("combined route", result)
				R.Pause()
				return
			end
			if coroutine.status(co) ~= "dead" then ns.After(0.01, advance); return end
			if result.anchor ~= anchor then
				anchor, spent, charged = result.anchor, 0, {}
				-- Rebuild once with the new stop's independent detour budget.
				queued = false
				R.Invalidate()
				return
			end
			queued = false
			publish(result)
		end
		advance()
	end
	ns.After(0, begin)
end

function R.SetMain(id)
	if not ns.Engine.TabIds()[id] then return false end
	local s = R.State() or { members = {}, budget = 300 }
	s.main, s.enabled, s.paused = id, true, false
	s.members[id] = nil
	ns.Engine.ClearCombinedManual()
	if ns.Nav and ns.Nav.ReleaseTarget then ns.Nav.ReleaseTarget() end
	ns.CharState().combinedRoute = s
	plan, target, anchor, spent, charged = nil, nil, nil, 0, {}
	s.ledger = nil
	ns.Fire("WAYPOINT_CHANGED", nil)
	R.Invalidate()
	return true
end

function R.Add(id, on)
	local s = R.State()
	if not s or not ns.Engine.TabIds()[id] or id == s.main then return false end
	s.members[id] = on ~= false or nil
	R.Invalidate()
	return true
end

function R.SetBudget(seconds)
	local s = R.State()
	if not s or type(seconds) ~= "number" or seconds ~= seconds then return false end
	s.budget = math.max(0, math.min(1800, math.floor(seconds)))
	R.Invalidate()
	return true
end

function R.Pause()
	if not R.Enabled() then return end
	R.State().paused = true
	target = nil
	ns.Engine.RequestUpdate()
	ns.Fire("WAYPOINT_CHANGED", ns.Engine.GetWaypoint())
	ns.Fire("COMBINED_ROUTE_CHANGED")
end

function R.Resume()
	if not R.Enabled() then return end
	R.State().paused = false
	declined = {}
	ns.Engine.ClearCombinedManual()
	if ns.Nav and ns.Nav.ReleaseTarget then ns.Nav.ReleaseTarget() end
	ns.Fire("WAYPOINT_CHANGED", nil)
	R.Invalidate()
end

function R.Disable()
	if not R.State() then return end
	R.State().enabled = false
	revision = revision + 1
	plan, target = nil, nil
	ns.Engine.ClearCombinedManual()
	ns.Engine.RequestUpdate()
	ns.Fire("WAYPOINT_CHANGED", ns.Engine.GetWaypoint())
	ns.Fire("COMBINED_ROUTE_CHANGED")
end

function R.Confirm(key, yes)
	if not plan then return false end
	for _, row in ipairs(plan.rows) do
		if row.commitment == key then
			approved[key], declined[key] = yes == true or nil, yes ~= true or nil
			if yes and row.groupQuest then ns.Engine.AnswerGroup(row.groupQuest, "do") end
			R.Invalidate()
			return true
		end
	end
	return false
end
function R.Declined(key) return declined[key] == true end

for _, event in ipairs({ "STEP_CHANGED", "STEP_UPDATED", "TABS_CHANGED", "QUEST_LOG_CHANGED", "LEVEL_CHANGED", "PACKS_CHANGED", "SKILL_CHANGED", "BAGS_CHANGED" }) do
	ns.On(event, function() R.Invalidate() end)
end
ns.OnLogin(function()
	local s = R.State()
	local ledger = s and s.ledger
	if type(ledger) == "table" and type(ledger.anchor) == "string" and type(ledger.spent) == "number" and type(ledger.charged) == "table" then
		anchor, spent, charged = ledger.anchor, math.max(0, math.min(ledger.spent, 1800)), ledger.charged
	end
	R.Invalidate()
end)
function R.Continue(from, to)
	local s = R.State()
	if not s or not s.enabled then return end
	if s.main == from then s.main = to end
	if s.members[from] then s.members[from], s.members[to] = nil, true end
	R.Invalidate()
end
ns.On("GUIDE_CONTINUED", R.Continue)
ns.On("ROUTE_CHOSEN", R.Continue)
ns.RegisterEvent("QUEST_REMOVED", function(_, q)
	if type(q) ~= "number" then return end
	for _, kind in ipairs({ "escort:", "timed:", "closing:" }) do
		approved[kind .. q], declined[kind .. q] = nil, nil
	end
	R.Invalidate()
end)

local inInstance
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	local inside = ns.Compat.IsInInstance()
	if inInstance and not inside then
		for key in pairs(approved) do if key:sub(1, 8) == "dungeon:" then approved[key] = nil end end
		R.Invalidate()
	end
	inInstance = inside
end)

-- Position and world changes also invalidate cost estimates. This modest
-- poll never runs the planner while disabled or while an earlier job runs.
local function poll()
	if R.Enabled() and not queued then R.Invalidate() end
	ns.After(5, poll)
end
ns.After(5, poll)
