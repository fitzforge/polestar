-- A small player coordinate readout at the bottom of the minimap (setting
-- maps.minimapCoords; the world map's own player and cursor readout lives in
-- WorldMap.lua's info bar). Map percent of the zone the player is in, to one
-- decimal (Maps.FormatCoords); blank where the client gives no position
-- (instances).
--
-- Cost: nothing until the setting is first turned on (no frame exists).
-- While on, a 5 Hz tick reads the position and repaints only when the shown
-- tenth changed; turning it off hides the frame, which stops the tick.

local ADDON, ns = ...
local Maps = ns.Maps

local floor = math.floor

local TICK = 0.2

local frame
local acc, shownX, shownY = 0, false, false

local function tenth(v)
	return v and floor(v * 10 + 0.5) or nil
end

local function update(force)
	local C = ns.Compat
	local _, x, y
	if C and C.GetPlayerMapPosition then _, x, y = C.GetPlayerMapPosition() end
	local tx, ty = tenth(x), tenth(y)
	if not force and tx == shownX and ty == shownY then return end
	shownX, shownY = tx, ty
	frame.Text:SetText(tx and Maps.FormatCoords(tx / 10, ty / 10) or "")
end

local function build()
	if frame then return frame end
	local W, T = ns.Widgets, ns.Theme
	if not (W and W.Text and Minimap) then return nil end
	frame = ns.CreateFrameUnder("Frame", "PolestarMinimapCoords", Minimap)
	frame:SetSize(72, 14)
	frame:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 10)
	frame:SetFrameLevel((Minimap:GetFrameLevel() or 1) + 5)
	frame.Text = W.Text(frame, "number", "text")
	frame.Text:SetPoint("CENTER", frame, "CENTER", 0, 0)
	frame.Text:SetJustifyH("CENTER")
	if T and T.SetOutline then T.SetOutline(frame.Text, true) end
	frame:SetScript("OnUpdate", function(_, dt)
		acc = acc + dt
		if acc < TICK then return end
		acc = 0
		update(false)
	end)
	frame:Hide()
	return frame
end

function Maps.RefreshMinimapCoords()
	if ns.Get("maps.minimapCoords") then
		if not build() then return end
		frame:Show()
		update(true)
	elseif frame then
		frame:Hide()
	end
end

ns.On("SETTING_CHANGED", function(path)
	if not ns.IsLoggedIn() then return end
	if path == "maps.minimapCoords" or path == "maps" or path == "" then Maps.RefreshMinimapCoords() end
end)

ns.OnLogin(Maps.RefreshMinimapCoords)
