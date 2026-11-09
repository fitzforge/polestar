-- Travel (spec 5.1): `sethome`, `hearth`, `getfp`, `fly`, from the live bind
-- location, the innkeeper or flight master being talked to, and the taxi map.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local ipairs = ipairs

local function bind()
	return GetBindLocation and GetBindLocation() or nil
end

S.Tools.Register({
	key = "sethome", label = "Set home here", icon = "icon-sethome", kit = "core",
	tip = "Talk to the innkeeper (or bind) first: the inn and its innkeeper are filled.",
	run = function()
		if not UI.Ready() then return end
		UI.Resolve("SetHome", bind())
	end,
})

S.Tools.Register({
	key = "hearth", label = "Hearth", icon = "icon-hearth", kit = "core", belt = false,
	tip = "Hearth to where your hearthstone is bound.",
	run = function()
		if not UI.Ready() then return end
		UI.Resolve("Hearth", bind())
	end,
})

S.Tools.Register({
	key = "getfp", label = "Get the flight path", icon = "icon-getfp", kit = "core",
	tip = "With the flight master's map open: this flight point and its flight master.",
	run = function()
		if not UI.Ready() then return end
		local src, out = S.Resolve.GetFP()
		if src then return UI.Add(src, out) end
		UI.Prompt({ title = L["Flight path"], label = L["The flight point's name (\"Stormwind\")."], onAccept = function(text)
			if text ~= "" then UI.Resolve("GetFP", text) end
		end })
	end,
})

-- The taxi map's destinations, when it is open.
local function taxiNodes()
	local out = {}
	if not (NumTaxiNodes and TaxiNodeName) then return out end
	for i = 1, NumTaxiNodes() or 0 do
		local name = TaxiNodeName(i)
		local kind = TaxiNodeGetType and TaxiNodeGetType(i)
		if name and kind ~= "CURRENT" and kind ~= "NONE" then
			out[#out + 1] = { text = name, value = (name:match("^([^,]+)")) }
		end
	end
	return out
end

S.Tools.Register({
	key = "fly", label = "Fly", icon = "icon-fly", kit = "core", belt = false,
	tip = "Pick the destination on the open flight map, or name it.",
	run = function()
		if not UI.Ready() then return end
		local nodes = taxiNodes()
		if #nodes > 0 then
			return UI.Pick({ title = L["Fly to"], items = nodes, onPick = function(it) UI.Resolve("Fly", it.value) end })
		end
		UI.Prompt({ title = L["Fly"], label = L["The town to fly to, as the flight map names it (\"Stormwind\")."], onAccept = function(text)
			if text ~= "" then UI.Resolve("Fly", text) end
		end })
	end,
})
