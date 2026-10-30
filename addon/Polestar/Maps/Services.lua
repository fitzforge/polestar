-- Service NPCs and mailboxes, through the existing pin renderer. Off by
-- default, like the other map layers. Nothing is read at login: the Codex is
-- read the first time the world map opens with the layer on (or at once when
-- its minimap icons are on), in small batches outside combat.
-- Flight masters and inns are not categories here: the travel layers
-- (Maps/TravelPins.lua, maps.taxiPins and maps.innPins) own them, so an NPC
-- with either role is left to those layers rather than drawn twice.
local ADDON, ns = ...
local Maps, L = ns.Maps, ns.L
local type, ipairs, pairs = type, ipairs, pairs
local LAYER = "maps.services"

-- `on`: the lean set a player gets when turning the layer on; the rest are opt-in.
local CATEGORIES = {
	{ key = "repair", label = L["Repair"], texture = "Repair" },
	{ key = "mailbox", label = L["Mailboxes"], texture = "Mailbox", on = true },
	{ key = "class", label = L["Class trainers"], texture = "Class", on = true },
	{ key = "weapon", label = L["Weapon masters"], icon = "icon-train" },
	{ key = "auctioneer", label = L["Auctioneers"], texture = "Auctioneer" },
	{ key = "banker", label = L["Bankers"], icon = "Interface\\Icons\\INV_Misc_TreasureChest01a" },
	{ key = "battlemaster", label = L["Battlemasters"], texture = "BattleMaster" },
	{ key = "spirithealer", label = L["Spirit healers"], icon = "Interface\\Icons\\Spell_Holy_GuardianSpirit" },
	{ key = "stablemaster", label = L["Stable masters"], texture = "StableMaster" },
	{ key = "trainer", label = L["Profession trainers"], texture = "Profession" },
	{ key = "vendor", label = L["Vendors"], texture = "Banker" },
}
Maps.ServiceCategories = CATEGORIES
local filters = {}
for _, category in ipairs(CATEGORIES) do
	filters[category.key] = category.on == true
	category.icon = category.icon or ("Interface\\Minimap\\Tracking\\" .. category.texture)
	if not category.icon:find("[\\/]") then category.icon = ns.Theme.Media(category.icon) end
end
ns.RegisterDefaults("maps", { servicePins = false, serviceMinimap = false, serviceFilters = filters })

local function rolesOf(record)
	local roles = {}
	local nearby = ns.Nav and ns.Nav.nearby
	local weapon = record.kind ~= "object" and nearby and nearby.WEAPON_MASTERS and nearby.WEAPON_MASTERS[record.id]
	local classOrWeapon = weapon and true or false
	if weapon then roles.weapon = true end
	local info = ns.Compat.GetPlayerInfo and ns.Compat.GetPlayerInfo() or {}
	for _, role in ipairs(record.roles or {}) do
		if type(role) == "string" then
			if role:sub(1, 6) == "class:" then
				classOrWeapon = true
				if role:sub(7) == info.class then roles.class = true end
			elseif role:sub(1, 8) == "trainer:" then
				roles.trainer = true
			else
				roles[role] = true
				if role == "weapon" then classOrWeapon = true end
			end
		end
	end
	if classOrWeapon then roles.trainer = nil end
	return roles
end

local function rgb(key)
	if ns.Theme and ns.Theme.Color then return ns.Theme.Color(key) end
	return 1, 1, 1
end

-- One icon per NPC and spawn, using the first enabled service it offers.
-- Its tooltip keeps the other roles, so a repair vendor needs only one pin.
function Maps.BuildServicePins(records)
	local pins, seen = {}, {}
	local mailboxes = {}
	local function repeatedMailbox(spawn)
		local c, wx, wy = ns.Compat.MapToWorld(spawn.map, spawn.x, spawn.y, spawn.f)
		if not c then return false end
		for _, point in ipairs(mailboxes) do
			if point.c == c and (point.wx - wx) ^ 2 + (point.wy - wy) ^ 2 <= 100 then return true end
		end
		-- Mailbox spawn lists include repeated player observations within interaction range.
		mailboxes[#mailboxes + 1] = { c = c, wx = wx, wy = wy }
		return false
	end
	local info = ns.Compat.GetPlayerInfo and ns.Compat.GetPlayerInfo() or {}
	local faction = info.faction == "Alliance" and "A" or info.faction == "Horde" and "H" or nil
	for _, record in ipairs(records or {}) do
		if record.faction == nil or record.faction == "AH" or (faction and record.faction == faction) then
			local roles, selected, labels = rolesOf(record), nil, {}
			-- Inns and flight masters are the travel layers' (see the top).
			if not (roles.innkeeper or roles.flightmaster) then
				for _, category in ipairs(CATEGORIES) do
					if roles[category.key] then
						labels[#labels + 1] = category.label
						if not selected and ns.Get("maps.serviceFilters." .. category.key) then selected = category end
					end
				end
			end
			if selected then
				for _, spawn in ipairs(record.spawns or {}) do
					local map, x, y = spawn.map, spawn.x, spawn.y
					if type(map) == "number" and map > 0 and type(x) == "number" and type(y) == "number"
						and x >= 0 and x <= 100 and y >= 0 and y <= 100 then
						local key = table.concat({ record.kind or "npc", record.id, map, x, y }, ":")
						if not seen[key] and (not roles.mailbox or not repeatedMailbox(spawn)) then
							seen[key] = true
							local name = record.name or tostring(record.id)
							local p = { id = record.id, kind = record.kind or "npc", category = selected.key,
								name = name, subName = record.subName,
								map = map, x = x, y = y, f = spawn.f, icon = selected.icon,
								size = 16, color = { 1, 1, 1, 1 }, backdrop = true, priority = 1 }
							p.tooltip = function(tip)
								tip:SetText(name, rgb("text"))
								if record.subName and record.subName ~= "" then tip:AddLine(record.subName, rgb("textDim")) end
								tip:AddLine(table.concat(labels, " · "), rgb("textDim"))
								tip:AddLine(Maps.FormatCoords(x, y), rgb("textMuted"))
								tip:AddLine(L["Click to set a waypoint"], rgb("textDim"))
							end
							p.onClick = function(button)
								if button == "LeftButton" and ns.Nav and ns.Nav.SetTarget then
									ns.Nav.SetTarget(map, x, y, name, spawn.f, p.kind)
								end
							end
							pins[#pins + 1] = p
						end
					end
				end
			end
		end
	end
	return pins
end

local records, job, failure, loading, scheduled, wanted
local refresh, step
local function publish()
	Maps.HideServiceMenu()
	if not (ns.Pins and ns.Pins.SetLayer) then return end
	if not ns.Get("maps.servicePins") or not records then ns.Pins.ClearLayer(LAYER); return end
	ns.Pins.SetLayer(LAYER, Maps.BuildServicePins(records), {
		world = true, minimap = ns.Get("maps.serviceMinimap") == true, edge = false,
		minMapType = Enum and Enum.UIMapType and Enum.UIMapType.Zone or 3,
		worldLayout = Maps.LayoutServicePins,
	})
end

local function inCombat()
	return InCombatLockdown and InCombatLockdown()
end

local function schedule()
	if scheduled then return end
	if C_Timer and C_Timer.After then
		scheduled = true
		C_Timer.After(0.01, function() scheduled = false; step() end)
	end
end

step = function()
	if not job or not ns.Get("maps.servicePins") or inCombat() then return end
	local current = job
	for _ = 1, 100 do
		local source = current.sources[current.source]
		if not source then
			records, job = current.records, nil
			publish()
			return
		end
		local id = source.ids[current.index]
		if id then
			local rec = source.read(id)
			if rec then current.records[#current.records + 1] = rec end
			current.index = current.index + 1
		else
			current.source, current.index = current.source + 1, 1
		end
	end
	schedule()
end

refresh = function()
	if not ns.IsLoggedIn() or loading then return end
	if not ns.Get("maps.servicePins") then publish(); return end
	if records then publish(); return end
	-- Not before the world map has opened, unless minimap icons are on.
	if not (wanted or ns.Get("maps.serviceMinimap")) then return end
	if inCombat() then return end
	if job then schedule(); return end
	loading = true
	local source, why = Maps.ServiceSource()
	loading = false
	if not source then
		if failure ~= why then
			failure = why
			ns.Print(L["NPC service data is unavailable. Reinstall the complete Polestar package, including Polestar_Codex."])
		end
		return
	end
	failure = nil
	local sources = { source }
	local mailboxes = Maps.ServiceMailboxSource()
	if mailboxes then sources[#sources + 1] = mailboxes end
	job = { sources = sources, source = 1, index = 1, records = {} }
	step()
end
Maps.RefreshServicePins = refresh

-- The world map opened (Maps/ServiceClusters.lua's watcher): from now on the
-- layer may read the Codex.
function Maps.ServiceMapShown()
	if wanted then return end
	wanted = true
	refresh()
end

local function addMenu(_, root)
	local menu = root:CreateButton(L["Polestar: NPC services"])
	local function checkbox(parent, label, key)
		return parent:CreateCheckbox(label, function() return ns.Get(key) == true end, function()
			ns.Set(key, not ns.Get(key))
			return MenuResponse and MenuResponse.Refresh
		end)
	end
	checkbox(menu, L["Show NPC services"], "maps.servicePins")
	checkbox(menu, L["Service icons on the minimap"], "maps.serviceMinimap")
	menu:CreateDivider()
	for _, category in ipairs(CATEGORIES) do
		checkbox(menu, category.label, "maps.serviceFilters." .. category.key)
	end
end
Maps.AddServiceMenu = addMenu

local controls = {
	{ kind = "toggle", key = "maps.servicePins", label = L["Show NPC services"],
		help = L["Marks friendly service NPCs and mailboxes on zone and city maps using Polestar's bundled Codex. Click an individual icon to set a waypoint, or a city group to choose an NPC and destination; choose categories here or in the map's tracking menu. Flight masters and inns have their own toggles under Dungeons and travel."] },
	{ kind = "toggle", key = "maps.serviceMinimap", label = L["Service icons on the minimap"],
		help = L["Shows the enabled NPC service categories on the minimap as well."],
		child = true, disabled = function() return not ns.Get("maps.servicePins") end },
}
for _, category in ipairs(CATEGORIES) do
	controls[#controls + 1] = { kind = "toggle", key = "maps.serviceFilters." .. category.key, label = category.label,
		help = category.key == "class" and L["Shows trainers for your character's class."] or L["Shows this service category on the map."],
		child = true, disabled = function() return not ns.Get("maps.servicePins") end }
end
ns.RegisterOptions({ page = L["Map"], tab = L["Rares & travel"], section = L["NPC services"], controls = controls })

ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "maps" or path == "maps.servicePins" or path == "maps.serviceMinimap"
		or path == "maps.serviceFilters" or (type(path) == "string" and path:sub(1, 20) == "maps.serviceFilters.") then refresh() end
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", refresh)
ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if name == "Polestar_Codex" then refresh() end
end)
local function invalidate()
	records, job = nil, nil
	refresh()
end
ns.On("CODEX_LOADED", invalidate)
ns.On("NAMES_LOADED", invalidate)
ns.OnLogin(function()
	if not ns.GamepadUI() and Menu and Menu.ModifyMenu then
		Menu.ModifyMenu("MENU_WORLD_MAP_TRACKING", addMenu)
		Menu.ModifyMenu("MENU_MINIMAP_TRACKING", addMenu)
	end
	if ns.Theme and ns.Theme.OnChanged then ns.Theme.OnChanged(publish) end
	refresh()
end)
