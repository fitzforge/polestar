-- Polestar Group Finder: the active search.
--
-- A search is a session: the quests you look for, from the click that
-- started it until none is left. Quests leave it by themselves: when the
-- game says an objective is done (the log's read after a QUEST_LOG_UPDATE
-- burst: no open objective, complete, or gone from the log), the quest is
-- dropped and the change goes out (Comm.Update); the others stay, so one
-- search covers every objective of the place. The last quest leaving ends
-- the search and tells the others (Comm.Stop). A search also ends when you
-- turn the addon off, enter an instance or your group is full.

local _, ns = ...
local L = ns.L

local Session = {}
ns.Session = Session

local DEBOUNCE = 1.0 -- seconds after the last QUEST_LOG_UPDATE
local active = false
local list = {}      -- { { id, kind, step }, ... }
local set = {}       -- id -> true
local token = 0

function Session.Active() return active end
function Session.Has(id) return set[id] == true end
function Session.List() return list end
function Session.Count() return #list end

local function rebuild(quests)
	list, set = {}, {}
	for _, q in ipairs(quests) do
		list[#list + 1] = q
		set[q.id] = true
	end
end

-- Starts (or restarts: a new click) the search on `quests`.
function Session.Start(quests)
	rebuild(quests)
	active = #list > 0
	ns.searchedQuests = list
	ns.Fire("SESSION")
end

function Session.Stop(reason)
	if not active then return end
	active = false
	list, set = {}, {}
	ns.Fire("SESSION", reason)
end

-- Drops the quests whose objective is done; returns the ids dropped.
function Session.Prune()
	if not active then return {} end
	local gone, keep = {}, {}
	for _, q in ipairs(list) do
		if ns.Quests.Pending(q.id) then
			q.kind = ns.Quests.Kind(q.id) or q.kind
			keep[#keep + 1] = q
		else
			gone[#gone + 1] = q.id
		end
	end
	if #gone > 0 then rebuild(keep) end
	return gone
end

local function check()
	if not active then return end
	local gone = Session.Prune()
	if #gone == 0 then return end
	local titles = {}
	for i, id in ipairs(gone) do titles[i] = ns.Quests.Title(id) end
	if #list == 0 then
		active = false
		ns.Debug(L["Every objective is done: search stopped."])
		ns.Fire("SESSION", "done")
		if ns.Comm.Stop then ns.Comm.Stop() end
	else
		ns.Debug(L["Objective done: %s. Still searching for %d quest(s)."], table.concat(titles, ", "), #list)
		ns.Fire("SESSION", "pruned")
		if ns.Comm.Update then ns.Comm.Update() end
	end
end

-- One check per burst of log updates.
local function onLog()
	if not active then return end
	token = token + 1
	local mine = token
	ns.After(DEBOUNCE, function() if mine == token then check() end end)
end
ns.RegisterEvent("QUEST_LOG_UPDATE", onLog)
ns.RegisterEvent("QUEST_REMOVED", onLog)
ns.RegisterEvent("QUEST_TURNED_IN", onLog)

ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	if active and IsInInstance and IsInInstance() then Session.Stop("instance") end
end)
ns.On("ENABLED", function(on) if not on then Session.Stop("off") end end)

-- Exposed for tests and for Group.lua (group full).
Session.Check = check
