-- Dungeon walkthrough toolkit (spec 5.2): the boss goal for the target, and
-- an instance's boss list from Polestar.Codex.Instance in kill order (one
-- boss, or every boss as its own step).

local ADDON, S = ...
local L = S.L
local UI = S.UI
local ipairs, format, tostring = ipairs, string.format, tostring


local function instance(key)
	local X = S.Resolve.Codex()
	if not (X and X.Instance) then return nil end
	local ok, rec = pcall(X.Instance, key)
	return ok and rec or nil
end

-- The npc bosses of an instance record, in the Codex's order.
local function bosses(rec)
	local out = {}
	for _, b in ipairs(rec and rec.bosses or {}) do
		if b.npc then out[#out + 1] = b end
	end
	return out
end

-- The instance the author is in, as a Codex key, when the Codex knows it.
local function currentInstance()
	if not (IsInInstance and IsInInstance() and GetInstanceInfo) then return nil end
	local name = GetInstanceInfo()
	local X = S.Resolve.Codex()
	if not (X and X.Each and name) then return nil end
	local found
	X.Each("instance", function(key, n)
		if n == name then
			found = key
			return false
		end
	end)
	return found
end

local function addBoss(npc)
	UI.Resolve("Boss", npc)
end

local function allBosses(rec)
	local list = bosses(rec)
	if #list == 0 then
		UI.Say(L["Polestar knows no bosses for it."], "warning")
		return
	end
	for _, b in ipairs(list) do
		local i = S.Model.AddStep(b.name or "")
		S.Model.Select(i, nil)
		addBoss(b.npc)
	end
end

local function pickBoss(key)
	local rec = instance(key)
	if not rec then
		UI.Say(L["Polestar knows nothing about that instance."], "warning")
		return
	end
	local items = { { text = L["Every boss, one step each"], sub = format(L["%d bosses"], #bosses(rec)), value = "all" } }
	for k, b in ipairs(bosses(rec)) do
		local sub = b.role and L[b.role] or tostring(k)
		items[#items + 1] = { text = b.name or tostring(b.npc), sub = sub, value = b.npc }
	end
	UI.Pick({ title = rec.name or L["Bosses"], hint = L["In the order Polestar knows them."], items = items, onPick = function(it)
		if it.value == "all" then allBosses(rec) else addBoss(it.value) end
	end })
end

local function pickInstance()
	UI.Pick({ title = L["Which instance?"], hint = L["Type part of its name."], items = function(q)
		local out = {}
		for _, r in ipairs(UI.SearchCodex("instance", q, 60)) do out[#out + 1] = { text = r.name, value = r.id } end
		return out
	end, onPick = function(it) pickBoss(it.value) end })
end

S.Tools.Register({
	key = "boss", label = "Boss goal for the target", icon = "icon-dungeon", kit = "dungeon",
	tip = "Done when the boss dies; no position needed inside.",
	run = function()
		if not UI.Ready() then return end
		if not UnitExists("target") then
			UI.Say(L["Target the boss first."], "warning")
			return
		end
		addBoss("target")
	end,
})

S.Tools.Register({
	key = "bosslist", label = "Boss list", icon = "layers", kit = "dungeon",
	tip = "An instance's bosses in kill order: add one, or every one as its own step.",
	run = function()
		if not UI.Ready() then return end
		local key = currentInstance()
		if key then pickBoss(key) else pickInstance() end
	end,
})

S.Tools.Register({
	key = "entrance", label = "Waypoint at the entrance", icon = "flag", kit = "dungeon", belt = false,
	tip = "A goto at the instance's entrance, as Polestar knows it.",
	run = function()
		if not UI.Ready() then return end
		UI.Pick({ title = L["Which instance?"], items = function(q)
			local out = {}
			for _, r in ipairs(UI.SearchCodex("instance", q, 60)) do out[#out + 1] = { text = r.name, value = r.id } end
			return out
		end, onPick = function(it)
			local rec = instance(it.value)
			local e = rec and rec.entrance
			if not (e and e.map and e.x) then
				UI.Say(L["Polestar knows no entrance for it."], "warning")
				return
			end
			local src, out = UI.GotoAt(e.map, e.x, e.y, rec.name)
			if e.f == "e" then
				UI.SetMod(src, "frame", { "era" })
				out.f = "e"
			end
			UI.Add(src, out)
		end })
	end,
})
