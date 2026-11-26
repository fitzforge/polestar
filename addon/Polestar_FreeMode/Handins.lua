-- The quest room's "Hand in your finished quests" guide (carried/log).
-- Rebuilt in its existing tab on quest changes, without selecting that tab.
local ns = Polestar
local L, Lookup = ns.L, ns.Lookup
local Handins = ns.Handins

local KIND, ID = "carried", "log"
local GID = Lookup.GuideId(KIND, ID)
local current, pending

local function signature(ids) return table.concat(ids, ",") end

local function open()
	local E = ns.Engine
	if not (E and E.GetTabs) then return false end
	for _, tab in ipairs(E.GetTabs()) do
		if tab.guideId == GID then return true end
	end
	return false
end

local function note(text)
	return { title = L["Hand in your finished quests"], goals = { { t = "note", text = text } } }
end

local function collect(ids)
	local p = { signature = signature(ids), stops = {}, unplaced = {}, from = ns.PlayerPoint() }
	local byKey = {}
	for _, id in ipairs(ids) do
		local rec = ns.Codex.Quest(id)
		local title = ns.Compat.GetQuestTitle(id) or (rec and rec.title) or (L["Quest"] .. " " .. id)
		local q = { id = id, title = title }
		-- Recipient selection is cheap; transport-aware ordering is refined
		-- across frames after the guide opens. Other-faction fallbacks are not
		-- hand-in destinations for this character.
		local at = ns.RoutePlan.Ender(id)
		if at then
			local key = table.concat({ at.npc and "npc" or "object", at.npc or at.object, at.map, at.x, at.y, at.f or "l" }, ":")
			local stop = byKey[key]
			if not stop then
				stop = { key = key, at = at, inP = at, outP = at, deps = {}, quests = {} }
				byKey[key], p.stops[#p.stops + 1] = stop, stop
			end
			stop.quests[#stop.quests + 1] = q
		else
			p.unplaced[#p.unplaced + 1] = q
		end
	end
	p.order = ns.HandinRoute.Order(p.stops, p.from)
	p.refining = p.from ~= nil and #p.stops > 0 and ns.Nav and ns.Nav.EstimateTravelCooperative ~= nil
	return p
end

local function render(p)
	local steps = {}
	for _, i in ipairs(p.order) do
		local s = p.stops[i]
		local at, goals = s.at, {}
		-- The waypoint is the entrance; each goal keeps the inside hint even
		-- when the player hides the step's tips.
		local hint = at.inside and string.format(L["%s: inside %s."], at.name or "?", at.zone or "?") or nil
		for _, q in ipairs(s.quests) do
			local g = { t = "turnin", quest = q.id, title = q.title, currentLog = true, map = at.map, x = at.x, y = at.y, f = at.f, z = at.z }
			g.note = hint
			if at.npc then g.npc, g.npcName = at.npc, at.name else g.object, g.objName = at.object, at.name end
			goals[#goals + 1] = g
		end
		if p.uncertain and p.uncertain[i] then
			local warning = L["Travel time to this hand-in is unknown. Its location is still shown."]
			hint = hint and (hint .. " " .. warning) or warning
		end
		steps[#steps + 1] = { title = at.name or L["Quest giver"], goals = goals, note = hint }
	end
	local unplaced = {}
	for _, q in ipairs(p.unplaced) do
		-- These are still live quest-log attempts. A generic task could retain
		-- its check-off when the same repeatable is accepted again immediately.
		unplaced[#unplaced + 1] = { t = "turnin", quest = q.id, title = q.title, currentLog = true,
			note = (L["Where it is turned in is not known: %s"]):format(ns.Quoted(q.title)) }
	end
	if #unplaced > 0 then
		steps[#steps + 1] = { title = L["Hand-ins without a known location"], goals = unplaced,
			note = #p.stops == 0 and L["None of these has a known place to hand it in."] or nil }
	end
	if #steps == 0 then steps[1] = note(L["No quests in your log are ready to hand in."]) end
	if p.refining then
		local warning = L["Refining the travel order. Travel times are estimates."]
		steps[1].note = steps[1].note and (steps[1].note .. " " .. warning) or warning
	end
	if p.partial then
		local warning = L["Travel estimates are incomplete. The order uses the estimates available and approximate distances."]
		steps[1].note = steps[1].note and (steps[1].note .. " " .. warning) or warning
	end
	return { title = L["Hand in your finished quests"], steps = steps }
end

function Handins.BuildGuide()
	-- Lookup restores saved tabs during ADDON_LOADED, before the quest log
	-- arrives. Keep that tab until login/quest events can fill it honestly.
	if not ns.IsLoggedIn() then
		return { title = L["Hand in your finished quests"], steps = { note(L["Waiting for your quest log."]) } }
	end
	local ids = Handins.Ready()
	if not current or current.cancelled or current.signature ~= signature(ids) then current = collect(ids) end
	return render(current)
end

local function publish()
	local def, reason = Lookup.BuildGuide(KIND, ID)
	if not def then return nil, reason end
	local ok, err = ns.RegisterGuide(def)
	if ok then ns.Fire("PACKS_CHANGED") end
	return ok, err
end

local function refine()
	local plan = current
	if not (plan and plan.refining and not plan.started) then return end
	plan.started = true
	ns.HandinRoute.Refine(plan.stops, plan.from, function()
		if current ~= plan or not open() then return false end
		-- Quest updates can change and revert before the refresh debounce.
		-- Remember cancellation so that the next refresh restarts the job.
		if signature(Handins.Ready()) ~= plan.signature then plan.cancelled = true; return false end
		return true
	end, function(order, uncertain, partial)
		plan.order, plan.uncertain, plan.refining, plan.partial = order or plan.order, uncertain, false, partial
		publish()
	end)
end

function Handins.Refresh(force)
	if not (ns.IsLoggedIn() and open()) then return end
	local ids = Handins.Ready()
	if not force and current and not current.cancelled and current.signature == signature(ids) then return end
	current = nil
	local ok = publish()
	if ok then refine() end
end

local function soon()
	if pending or not ns.IsLoggedIn() or not open() then return end
	pending = true
	ns.After(0.5, function()
		pending = false
		Handins.Refresh()
	end)
end

function Handins.Start()
	if #Handins.Ready() == 0 then
		ns.Print(L["No quests in your log are ready to hand in."])
		return nil, "nothing"
	end
	current = nil
	local gid, reason = Lookup.Guide(KIND, ID)
	if gid then
		refine()
		ns.Fire("SHOW_FRAME")
	elseif reason == "tabs" then
		ns.Print(L["Six tabs is the limit. Close one to open another."])
	elseif reason == "combat" then
		ns.Print(L["Wait until combat ends to load the quest data."])
	else
		ns.Print(L["The hand-in guide could not load. Check that the Polestar_Codex addon is installed and enabled."])
	end
	return gid, reason
end

ns.OnLogin(soon)
ns.RegisterEvent("QUEST_LOG_UPDATE", soon)
ns.RegisterEvent("QUEST_REMOVED", soon)
ns.RegisterEvent("QUEST_ACCEPTED", soon)
ns.RegisterEvent("QUEST_TURNED_IN", soon)
ns.On("GUIDE_CHANGED", function()
	if not open() then current = nil end
	soon()
end)
ns.On("TAB_CLOSED", function(id) if id == GID then current = nil end end)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function() if current and not current.from then current = nil end; soon() end)
