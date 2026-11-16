-- An opt-in route through ready quests in the whole log, independent of
-- leveling/dungeon guides. Only turn-ins: never pickups or unfinished work.
-- Rebuilt in its own tab on quest changes, without selecting that tab.
local ADDON, ns = ...
local L, Lookup = ns.L, ns.Lookup
local Handins = {}
ns.Handins = Handins

local KIND, ID = "handins", "ready"
local GID = Lookup.GuideId(KIND, ID)
local current, pending
local turned = {}

local function finished(id)
	local C = ns.Compat
	if C.IsQuestReadyForTurnIn(id) then return true end
	if C.GetQuestObjectives(id) ~= nil then return false end
	-- Some clients never mark a plain delivery complete. Require the Codex
	-- to confirm there are no objectives; missing log data alone is not proof.
	local rec = ns.Codex and ns.Codex.Quest(id)
	return rec ~= nil and #(rec.objectives or {}) == 0
end

function Handins.Ready()
	local ids, seen, C = {}, {}, ns.Compat
	for id, untilTime in pairs(turned) do if untilTime <= GetTime() then turned[id] = nil end end
	for _, id in ipairs(C.GetLogQuests()) do
		if not seen[id] and not (turned[id] and turned[id] > GetTime())
			and not C.IsQuestFailed(id) and finished(id) then
			ids[#ids + 1], seen[id] = id, true
		end
	end
	table.sort(ids)
	return ids
end

local function signature(ids) return table.concat(ids, ",") end

local function open()
	for _, tab in ipairs(ns.Engine.GetTabs()) do
		if tab.guideId == GID then return true end
	end
	return false
end

local function note(text)
	return { title = L["Hand in completed quests"], goals = { { t = "note", text = text } } }
end

local function point(e)
	local s = e and not e.hostile and e.spawn
	if not (s and s.map and s.x and s.y) then return nil end
	return { kind = e.npc and "npc" or "object", id = e.npc or e.object,
		name = e.name, map = s.map, x = s.x, y = s.y, f = s.f == "e" and "e" or nil, z = s.z }
end

local function collect(ids)
	local p = { signature = signature(ids), stops = {}, unplaced = {}, from = ns.PlayerPoint() }
	local byKey, player = {}, Lookup.PlayerInfo()
	for _, id in ipairs(ids) do
		local rec = ns.Codex.Quest(id)
		local title = ns.Compat.GetQuestTitle(id) or (rec and rec.title) or (L["Quest"] .. " " .. id)
		local q = { id = id, title = title }
		-- Recipient selection is cheap; transport-aware ordering is refined
		-- across frames after the guide opens. Other-faction fallbacks are not
		-- hand-in destinations for this character.
		local at = rec and point(Lookup.QuestEnd(rec["end"], p.from, player, true))
		if at then
			local key = table.concat({ at.kind, at.id, at.map, at.x, at.y, at.f or "l" }, ":")
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
		for _, q in ipairs(s.quests) do
			local g = { t = "turnin", quest = q.id, title = q.title, currentLog = true, map = at.map, x = at.x, y = at.y, f = at.f, z = at.z }
			if at.kind == "npc" then g.npc, g.npcName = at.id, at.name else g.object, g.objName = at.id, at.name end
			goals[#goals + 1] = g
		end
		steps[#steps + 1] = { title = at.name or L["Quest giver"], goals = goals,
			note = p.uncertain and p.uncertain[i] and L["Travel time to this hand-in is unknown. Its location is still shown."] or nil }
	end
	local notes = {}
	for _, q in ipairs(p.unplaced) do
		notes[#notes + 1] = { t = "note", text = (L["Where it is turned in is not known: %s"]):format(ns.Quoted(q.title)) }
	end
	if #notes > 0 then
		-- A note-only step is considered finished by the guide engine. Keep
		-- the remaining errands visible until the player deals with them.
		table.insert(notes, 1, { t = "task", text = L["Hand in these quests manually; their locations are not known."] })
		steps[#steps + 1] = { title = L["Hand-ins without a known location"], goals = notes }
	end
	if #steps == 0 then steps[1] = note(L["No quests in your log are ready to hand in."]) end
	if p.refining then steps[1].note = L["Refining the travel order. Travel times are estimates."] end
	if p.partial then
		local warning = L["Travel estimates are incomplete. The order uses the estimates available and approximate distances."]
		steps[1].note = steps[1].note and (steps[1].note .. " " .. warning) or warning
	end
	return { title = L["Hand in completed quests"], steps = steps }
end

function Handins.BuildGuide()
	-- Lookup restores saved tabs during ADDON_LOADED, before the quest log
	-- arrives. Keep that tab until login/quest events can fill it honestly.
	if not ns.IsLoggedIn() then
		return { title = L["Hand in completed quests"], steps = { note(L["Waiting for your quest log."]) } }
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

Lookup.RegisterPlanner(KIND, function(id)
	if id ~= ID then return nil, "unknown" end
	return Handins.BuildGuide()
end)
ns.RegisterCommand("handin", Handins.Start, L["Guide me through all completed quests in my log"])
ns.OnLogin(soon)
ns.RegisterEvent("QUEST_LOG_UPDATE", soon)
ns.RegisterEvent("QUEST_REMOVED", soon)
ns.RegisterEvent("QUEST_ACCEPTED", function(_, a, b)
	local id = b or a
	if id then turned[id] = nil end
	soon()
end)
ns.RegisterEvent("QUEST_TURNED_IN", function(_, id)
	if id then turned[id] = GetTime() + 10 end
	soon()
end)
ns.On("GUIDE_CHANGED", function()
	if not open() then current = nil end
	soon()
end)
ns.On("TAB_CLOSED", function(id) if id == GID then current = nil end end)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function() if current and not current.from then current = nil end; soon() end)
