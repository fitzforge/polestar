-- Detail-area service groups on region maps; other views keep exact pins.
local ADDON, ns = ...
local Maps, L = ns.Maps, ns.L
local PAGE = 10
local menuOwner

local function closeMenu()
	if menuOwner and ns.Widgets.MenuShown(menuOwner) then ns.Widgets.HideMenu() end
	menuOwner = nil
end
Maps.HideServiceMenu = closeMenu

local function choose(group, owner)
	local W = ns.Widgets
	if not (owner and W and W.ShowMenu) then return end
	if W.MenuShown(owner) then closeMenu(); return end
	closeMenu()
	menuOwner = owner
	if not owner.serviceMenuHook then
		owner.serviceMenuHook = true
		owner:HookScript("OnHide", function(self) if menuOwner == self then closeMenu() end end)
	end
	local categories, list
	local function show(items)
		W.ShowMenu(owner, items, { point = "TOPLEFT", relPoint = "BOTTOMRIGHT", minWidth = 220 })
	end
	list = function(category, page)
		local members = group.categories[category.key]
		local items = { { text = L["Back"], onClick = categories } }
		for i = (page - 1) * PAGE + 1, math.min(page * PAGE, #members) do
			local pin = members[i]
			items[#items + 1] = {
				text = Maps.ServiceIcon(category) .. " " .. pin.name .. "  |cffaaaaaa" .. Maps.FormatCoords(pin.x, pin.y) .. "|r",
				tip = pin.subName,
				onClick = function() pin.onClick("LeftButton") end,
			}
		end
		if page > 1 then items[#items + 1] = { text = L["Previous"], onClick = function() list(category, page - 1) end } end
		if page * PAGE < #members then items[#items + 1] = { text = L["Next"], onClick = function() list(category, page + 1) end } end
		show(items)
	end
	categories = function()
		local items = {}
		for _, category in ipairs(Maps.ServiceCategories) do
			local members = group.categories[category.key]
			if members then
				items[#items + 1] = { text = Maps.ServiceIcon(category) .. " " .. category.label .. " (" .. #members .. ")",
					onClick = function() list(category, 1) end }
			end
		end
		show(items)
	end
	categories()
end

local function detailOf(map, region)
	for _ = 1, 12 do
		if not map or map == 0 or map == region then return nil end
		local info = C_Map.GetMapInfo(map)
		if not info then return nil end
		if info.parentMapID == region then return map end
		map = info and info.parentMapID
	end
end

-- A group: a 30 px medallion with up to three of its services' glyphs and a
-- badge with how many service points it holds.
local GROUP_MEDAL = 30
local function pile(members, detail)
	local group = { members = members, categories = {}, count = #members, stack = {},
		size = GROUP_MEDAL / 1.4, medalSize = GROUP_MEDAL, badge = #members,
		color = Maps.ServiceColor(), priority = 1 }
	for _, d in ipairs(members) do
		local p = d.pin
		local category = group.categories[p.category]
		if not category then category = {}; group.categories[p.category] = category end
		category[#category + 1] = p
	end
	local services = {}
	for _, category in ipairs(Maps.ServiceCategories) do
		local entries = group.categories[category.key]
		if entries then
			services[#services + 1] = category.label .. " (" .. #entries .. ")"
			if #group.stack < 3 then group.stack[#group.stack + 1] = category.mark end
			table.sort(entries, function(a, b)
				if a.name ~= b.name then return a.name < b.name end
				if a.map ~= b.map then return a.map < b.map end
				if a.x ~= b.x then return a.x < b.x end
				return a.y < b.y
			end)
		end
	end
	group.icon = group.stack[1]
	group.tooltip = function(tip)
		local info = C_Map.GetMapInfo(detail)
		tip:SetText(info and info.name or L["NPC services"])
		tip:AddLine(L["%d service points"]:format(group.count), 1, 1, 1)
		for _, text in ipairs(services) do tip:AddLine(text, 0.75, 0.75, 0.75) end
		tip:AddLine(L["Click to expand"], 1, 0.82, 0.25)
	end
	group.onClick = function(button, owner) if button == "LeftButton" then choose(group, owner) end end
	return group
end

function Maps.LayoutServicePins(projected, view)
	if not (C_Map and C_Map.GetMapInfo) then return projected end
	local info = C_Map.GetMapInfo(view.mapID)
	local zone = Enum and Enum.UIMapType and Enum.UIMapType.Zone or 3
	if not info or info.mapType ~= zone then return projected end
	-- Cities share UIMapType.Zone; the existing level-range catalog lists outdoor regions.
	if not Maps.GetZoneLevels(view.mapID) then return projected end
	local cities, groups, order, out = {}, {}, {}, {}
	for _, d in ipairs(projected) do
		local map = d.pin.map
		local city = map and cities[map]
		if map and city == nil then city = detailOf(map, view.mapID) or false; cities[map] = city end
		if not city and C_Map.GetMapInfoAtPosition then
			local at = C_Map.GetMapInfoAtPosition(view.mapID, d.x / 100, d.y / 100)
			if at and at.mapID and at.mapID > 0 and at.mapID ~= view.mapID and at.mapType and at.mapType >= zone then city = at.mapID end
		end
		if city then
			if not groups[city] then groups[city] = {}; order[#order + 1] = city end
			table.insert(groups[city], d)
		else
			out[#out + 1] = d
		end
	end
	for _, city in ipairs(order) do
		local members = groups[city]
		if #members < 3 then
			for _, d in ipairs(members) do out[#out + 1] = d end
		else
			local x, y = 0, 0
			for _, d in ipairs(members) do x, y = x + d.x, y + d.y end
			local group = pile(members, city)
			group.city = city
			out[#out + 1] = { pin = group, x = x / #members, y = y / #members }
		end
	end
	return out
end

local watched
local function watchMap()
	if watched or not WorldMapFrame or not ns.MapCanvas then return end
	watched = ns.MapCanvas.Watch(WorldMapFrame, function(_, what)
		if what == "show" and Maps.ServiceMapShown then Maps.ServiceMapShown() end
		if what == "hide" or what == "map" or what == "size" or what == "scale" then closeMenu() end
	end)
end
ns.OnLogin(watchMap)
ns.RegisterEvent("ADDON_LOADED", function(_, name) if name == "Blizzard_WorldMap" then watchMap() end end)
