-- Free mode's door (#3701): the character's own quest log as a guide, in a
-- tab of its own (docs/ARCHITECTURE.md, "Free mode"). The mode itself is the
-- folder Polestar_FreeMode, loaded on demand: the first time Free mode starts,
-- or at ADDON_LOADED when a saved Free mode tab comes back (its planner kind,
-- below). Here: its settings, its command, the planner kind and what the guide
-- window asks before it is loaded; its own functions take these places as it
-- loads.
--
--   Free.GUIDE ; Free.ADDON
--   Free.IsGuide(id) -> bool ; Free.IsOn() -> bool   -- its guide; its tab open
--   Free.Load() -> true | nil, reason                -- Data.Pack(Free.ADDON)
--   Free.Start() / Free.Toggle()                      -- load, then the mode's own
--   Free.SetPick("balanced" | "near" | "xp")         -- setting free.pick
--   Free.Pick() -> rule ; Free.NextPick(rule?) -> rule ; Free.PickLabel(rule) -> text
--   Free.Why() -> text | nil                         -- why Free mode's first quest is first
--   Free.MenuItems() ; Free.RowItems(q) ; Free.ReturnTitle() ; Free.Stop()
--   Free.Say(reason)                                  -- why it could not start, in chat

local ADDON, ns = ...

local Lookup, L = ns.Lookup, ns.L
local Free = {}
ns.Free = Free

ns.RegisterDefaults("free", {
	-- "balanced": the XP for the trip, quests started and stops shared (Polestar_FreeMode/Order.lua);
	-- "near": the nearest quest first; "xp": the most XP a minute first
	pick = "balanced",
	hints = true, -- with no quest near, the zone with the most quests for your level first
	details = true, -- the XP of each hand-in and a collect's low drop rate on its line
})

-- The orders, in the order the window's switch steps through them.
Free.ORDERS = { "balanced", "near", "xp" }
local ORDER_AT = { balanced = 1, near = 2, xp = 3 }

Free.ADDON = "Polestar_FreeMode"
Free.GUIDE = Lookup.GuideId("free", "log")

function Free.IsGuide(id) return id == Free.GUIDE end

function Free.IsOn()
	local E = ns.Engine
	return E ~= nil and E.TabIds ~= nil and E.TabIds()[Free.GUIDE] == true
end

-- The door's own functions: once the folder is loaded, its take their place.
local door = {}

function Free.Load()
	if Free.Build then return true end
	local _, why = ns.Data.Pack(Free.ADDON)
	if not Free.Build then return nil, why or "missing" end
	return true
end

function Free.Say(why)
	ns.Print((why == "combat" and L["Free mode starts after combat."])
		or (why == "tabs" and L["Six tabs is the limit. Close one to open another."])
		or L["Free mode can't start: its folder Polestar_FreeMode or the Codex is missing or turned off."])
end

-- Loads the folder, then runs its function `name`.
local function via(name, ...)
	local ok, why = Free.Load()
	if not ok then
		Free.Say(why)
		return nil, why
	end
	if Free[name] ~= door[name] then return Free[name](...) end
	return nil, "missing"
end

function door.Start() return via("Start") end
function door.Toggle() return via("Toggle") end
function door.Stop() end
function door.ReturnTitle() return nil end
function door.RowItems() return nil end
function door.Why() return nil end
function door.MenuItems()
	return { { text = L["Free mode"], icon = "icon-explore", checked = false, tip = L["Your own quests as a guide: the arrow leads to the nearest one, then the next."],
		onClick = function() Free.Toggle() end } }
end
for k, fn in pairs(door) do Free[k] = fn end

-- The order in use: free.pick, else its default.
function Free.Pick()
	local v = ns.Get("free.pick")
	if ORDER_AT[v] then return v end
	return ns.GetBaseDefault("free.pick")
end

-- The order after `rule` (the one in use): balanced, nearest, most XP, round again.
function Free.NextPick(rule)
	local i = ORDER_AT[rule or Free.Pick()] or 1
	return Free.ORDERS[i % #Free.ORDERS + 1]
end

function Free.PickLabel(rule)
	return (rule == "balanced" and L["Balanced"]) or (rule == "xp" and L["Most XP a minute first"]) or L["Nearest first"]
end

function Free.SetPick(rule)
	ns.Set("free.pick", ORDER_AT[rule] and rule or ns.GetBaseDefault("free.pick"))
end

Lookup.RegisterPlanner("free", function()
	local ok, why = Free.Load()
	if not ok then return nil, why end
	return Free.Build()
end)

ns.RegisterCommand("free", function(arg)
	local ok, why = Free.Load()
	if not ok then return Free.Say(why) end
	Free.Command(arg)
end, L["Free mode: follow your own quests (on, off, balanced, nearest, xp)"])
