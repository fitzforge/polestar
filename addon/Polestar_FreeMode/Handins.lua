-- The quest room's hand-in guides (carried/log and carried/<quest id>).
-- Rebuilt in their existing tabs on quest changes, without selecting them.
local ns = Polestar
local L, Lookup = ns.L, ns.Lookup
local Handins = ns.Handins

local KIND, ID = "carried", "log"
local GID = Lookup.GuideId(KIND, ID)
local plans, pending = {}, false

local function signature(ids) return table.concat(ids, ",") end

local function plannerId(guideId)
	local kind, id = Lookup.ParseGuideId(guideId)
	if kind == KIND then return id end
end

local function open(guideId)
	local E = ns.Engine
	if not (E and E.GetTabs) then return false end
	for _, tab in ipairs(E.GetTabs()) do
		if (guideId and tab.guideId == guideId) or (not guideId and plannerId(tab.guideId)) then return true end
	end
	return false
end

local function note(title, text)
	return { title = title, goals = { { t = "note", text = text } } }
end

local function questTitle(id)
	local rec = ns.Codex.Quest(id)
	return ns.Compat.GetQuestTitle(id) or (rec and rec.title) or (L["Quest"] .. " " .. id)
end

local function guideTitle(quest)
	return quest and questTitle(quest) or L["Hand in your finished quests"]
end

local function collect(ids, quest)
	local p = { title = guideTitle(quest), signature = signature(ids), stops = {}, unplaced = {}, from = ns.PlayerPoint() }
	local byKey = {}
	for _, id in ipairs(ids) do
		local q = { id = id, title = quest and p.title or questTitle(id) }
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
	-- A single destination needs no travel-order refinement.
	p.refining = not quest and p.from ~= nil and #p.stops > 0 and ns.Nav and ns.Nav.EstimateTravelCooperative ~= nil
	return p
end

local function render(p, quest)
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
	if #steps == 0 then steps[1] = note(p.title, Handins.NotReady(quest)) end
	if p.refining then
		local warning = L["Refining the travel order. Travel times are estimates."]
		steps[1].note = steps[1].note and (steps[1].note .. " " .. warning) or warning
	end
	if p.partial then
		local warning = L["Travel estimates are incomplete. The order uses the estimates available and approximate distances."]
		steps[1].note = steps[1].note and (steps[1].note .. " " .. warning) or warning
	end
	return { title = p.title, steps = steps }
end

local function same(plan, ids)
	return plan and not plan.cancelled and plan.signature == signature(ids)
end

function Handins.BuildGuide(quest)
	-- Lookup restores saved tabs during ADDON_LOADED, before the quest log
	-- arrives. Keep that tab until login/quest events can fill it honestly.
	if not ns.IsLoggedIn() then
		local title = guideTitle(quest)
		return { title = title, steps = { note(title, L["Waiting for your quest log."]) } }
	end
	local id, ids = quest or ID, Handins.Ready(quest)
	if not same(plans[id], ids) then plans[id] = collect(ids, quest) end
	return render(plans[id], quest)
end

local function publish(id)
	local def, reason = Lookup.BuildGuide(KIND, id)
	if not def then return nil, reason end
	return ns.RegisterGuide(def)
end

local function refine()
	local plan = plans[ID]
	if not (plan and plan.refining and not plan.started) then return end
	plan.started = true
	ns.HandinRoute.Refine(plan.stops, plan.from, function()
		if plans[ID] ~= plan or not open(GID) then return false end
		-- Quest updates can change and revert before the refresh debounce.
		-- Remember cancellation so that the next refresh restarts the job.
		if signature(Handins.Ready()) ~= plan.signature then plan.cancelled = true; return false end
		return true
	end, function(order, uncertain, partial)
		plan.order, plan.uncertain, plan.refining, plan.partial = order or plan.order, uncertain, false, partial
		if publish(ID) then ns.Fire("PACKS_CHANGED") end
	end)
end

function Handins.Refresh(force)
	local E = ns.Engine
	if not (ns.IsLoggedIn() and E and E.GetTabs) then return end
	local changed
	for _, tab in ipairs(E.GetTabs()) do
		local id = plannerId(tab.guideId)
		if id then
			local quest = type(id) == "number" and id or nil
			if force or not same(plans[id], Handins.Ready(quest)) then
				plans[id] = nil
				if publish(id) then changed = true end
			end
		end
	end
	if changed then
		ns.Fire("PACKS_CHANGED")
		if open(GID) then refine() end
	end
end

local function soon()
	if pending or not ns.IsLoggedIn() or not open() then return end
	pending = true
	ns.After(0.5, function()
		pending = false
		Handins.Refresh()
	end)
end

function Handins.Start(quest)
	if #Handins.Ready(quest) == 0 then
		ns.Print(Handins.NotReady(quest))
		return nil, "nothing"
	end
	local id = quest or ID
	plans[id] = nil
	local gid, reason = Lookup.Guide(KIND, id)
	if gid then
		if id == ID then refine() end
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
	if not open(GID) then plans[ID] = nil end
	soon()
end)
ns.On("TAB_CLOSED", function(guideId)
	local id = plannerId(guideId)
	if id then plans[id] = nil end
end)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	for id, plan in pairs(plans) do
		if not plan.from then plans[id] = nil end
	end
	soon()
end)
