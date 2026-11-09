-- Accept / Complete / Turn in (spec 5.1): the quest from the open quest
-- frame, else picked from the log (or the Codex by name or id); the giver,
-- the ender and the reward choice are filled by the resolver.
--
--   S.UI.PickQuest(title, onPick(questId), opts)  -- opts.codex: search every quest

local ADDON, S = ...
local L = S.L
local UI = S.UI
local format, ipairs, tostring, tonumber = string.format, ipairs, tostring, tonumber

-- Whether a quest panel (detail, progress, reward) is open: by its events,
-- as QuestFrame may be replaced by another addon's quest window.
local questOpen = false
for _, ev in ipairs({ "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_COMPLETE" }) do
	S.RegisterEvent(ev, function() questOpen = true end)
end
S.RegisterEvent("QUEST_FINISHED", function() questOpen = false end)

local function frameQuest()
	local q = GetQuestID and GetQuestID()
	if not (q and q > 0) then return nil end
	if questOpen or (QuestFrame and QuestFrame:IsShown()) then return q end
	return nil
end

function UI.PickQuest(title, onPick, opts)
	opts = opts or {}
	local log = {}
	for _, q in ipairs(S.Resolve.QuestLog and S.Resolve.QuestLog() or {}) do
		log[#log + 1] = { text = UI.QuestTitle(q), sub = tostring(q), value = q, icon = UI.Theme.Media("icon-accept") }
	end
	UI.Pick({ title = title, hint = L["Quests in your log; type a name or id to search every quest."], items = function(q)
		local out = {}
		for _, it in ipairs(log) do
			if q == "" or it.text:lower():find(q, 1, true) or it.sub == q then out[#out + 1] = it end
		end
		if #q >= 2 then
			for _, hit in ipairs(UI.SearchCodex("quest", q, 40)) do
				out[#out + 1] = { text = hit.name, sub = tostring(hit.id), value = hit.id }
			end
		end
		return out
	end, onPick = function(it) onPick(tonumber(it.value)) end })
end

local function questTool(key, label, icon, fn, tip, belt)
	S.Tools.Register({
		key = key, label = label, icon = icon, kit = "core", tip = tip, belt = belt,
		run = function()
			if not UI.Ready() then return end
			local q = frameQuest()
			if q then return UI.Resolve(fn, q) end
			UI.PickQuest(L[label], function(id) UI.Resolve(fn, id) end)
		end,
	})
end

questTool("accept", "Accept a quest", "icon-accept", "Accept", "The quest open in the quest frame, or one picked from your log.")
questTool("complete", "Complete a quest", "icon-complete", "Complete", "All of a quest's objectives done.", false)
questTool("turnin", "Turn in a quest", "icon-turnin", "Turnin", "The quest open in the quest frame (with the reward you took), or one picked.")
