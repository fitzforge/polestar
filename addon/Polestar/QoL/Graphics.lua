-- Unlocked graphics, vegetation density, extended scenery draw distance,
-- color correction, post-processing toggles, camera distance, and live FPS benchmark for WoW: Forever.
--
-- CVars adjusted:
--   groundEffectDensity          Grass density (up to 256, standard UI caps lower)
--   groundEffectDist             Grass visibility range (up to 500 yards)
--   terrainLodDist               Distance terrain keeps detailed LOD (up to 1500)
--   lodObjectFadeScale           Scenery object & doodad fade scale (up to 300%)
--   farclip                      Maximum horizon view distance (up to 10000)
--   Gamma, Brightness, Contrast  Client image controls
--   ffxGlow                      Full-screen bloom/glow (toggleable off for crisp visuals)
--   ffxDeath                     Grey screen when dead (toggleable off)
--   ResampleSharpness            Resampling filter sharpness
--   cameraDistanceMaxZoomFactor  Maximum camera distance zoom factor (up to 4.0 / 50 yd)
--   cameraFov                    Camera field of view (50 to 120)
--
-- World tinting uses a lightweight Frame anchored beneath UIParent on WorldFrame
-- with MOD and ADD blend textures, coloring the 3D world without altering the UI.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL

local Graphics = {}
QoL.Graphics = Graphics

local tintFrame, tintTextures
local isApplyingPreset = false
local pendingApply = false

---------------------------------------------------------------------------
-- Safe CVar helpers
---------------------------------------------------------------------------

local function getCVar(name)
	if C_CVar and C_CVar.GetCVar then return C_CVar.GetCVar(name) end
	return GetCVar and GetCVar(name) or nil
end

local function setCVar(name, value)
	if C_CVar and C_CVar.SetCVar then return C_CVar.SetCVar(name, tostring(value)) end
	if SetCVar then return SetCVar(name, tostring(value)) end
end

function Graphics.CVarSupported(name)
	return getCVar(name) ~= nil
end

local function writeCVar(name, value)
	if InCombatLockdown() or not Graphics.CVarSupported(name) or value == nil then return false end
	local current = getCVar(name)
	local curNum, valNum = tonumber(current), tonumber(value)
	if curNum and valNum and math.abs(curNum - valNum) < 0.0001 then return true end
	if current == tostring(value) then return true end
	pcall(setCVar, name, tostring(value))
	return true
end

---------------------------------------------------------------------------
-- Framerate measurement and feedback
---------------------------------------------------------------------------

local samples = {}
local fpsBefore, fpsAfter
local measuring = false
local measureDeadline = 0
local lastSampleTime = 0
local lastStatusText = nil

local fpsDriver = CreateFrame and CreateFrame("Frame")
if fpsDriver then fpsDriver:Hide() end

local function recordSample()
	if not GetTime or not GetFramerate then return end
	local now = GetTime()
	if now - lastSampleTime < 0.25 then return end
	lastSampleTime = now
	samples[#samples + 1] = { time = now, fps = GetFramerate() }
	while samples[1] and samples[1].time < now - 4 do
		table.remove(samples, 1)
	end
end

local function getMedianFps()
	local values = {}
	for _, s in ipairs(samples) do
		values[#values + 1] = s.fps
	end
	if #values == 0 then
		return GetFramerate and math.floor(GetFramerate() + 0.5) or 60
	end
	table.sort(values)
	local mid = math.floor(#values / 2) + 1
	local med = #values % 2 == 0 and (values[mid - 1] + values[mid]) / 2 or values[mid]
	return math.floor(med + 0.5)
end

local function finishMeasurement()
	measuring = false
	fpsAfter = getMedianFps()
	if not fpsBefore or not fpsAfter then return end
	local diff = fpsAfter - fpsBefore
	local pct = (fpsAfter / math.max(1, fpsBefore) - 1) * 100
	local color = diff >= 0 and "|cff4fd1c5" or (diff > -10 and "|cffffff00" or "|cffff6b6b")
	lastStatusText = string.format(L["Last change: %d \226\134\146 %d FPS (%+.0f%%)"], fpsBefore, fpsAfter, pct)
	if QoL.On("fpsFeedback") and ns.Print then
		ns.Print(string.format("Graphics: %d \226\134\146 %s%d FPS|r (%+.0f%%)", fpsBefore, color, fpsAfter, pct))
	end
end

local function beginMeasurement()
	if not GetTime or not GetFramerate then return end
	if not measuring then
		fpsBefore = getMedianFps()
	end
	measuring = true
	measureDeadline = GetTime() + 2.5
	if fpsDriver then fpsDriver:Show() end
end

if fpsDriver then
	fpsDriver:SetScript("OnUpdate", function()
		recordSample()
		if measuring and GetTime and GetTime() >= measureDeadline then
			finishMeasurement()
		end
		if not measuring then
			fpsDriver:Hide()
		end
	end)
end

function Graphics.MeasureFps(manual)
	if manual then
		recordSample()
		local cur = getMedianFps()
		lastStatusText = string.format(L["Current framerate: %d FPS"], cur)
		if ns.Print then
			ns.Print(string.format("Current framerate: |cff4fd1c5%d FPS|r", cur))
		end
	else
		beginMeasurement()
	end
end

function Graphics.GetFpsStatusText()
	if measuring then
		return L["Measuring framerate..."]
	end
	if lastStatusText then
		return lastStatusText
	end
	if GetFramerate then
		return string.format(L["Current framerate: %d FPS"], math.floor(GetFramerate() + 0.5))
	end
	return L["Framerate benchmark"]
end

---------------------------------------------------------------------------
-- World tinting (RGB color grading beneath UI)
---------------------------------------------------------------------------

local function applyTint(r, g, b)
	r, g, b = tonumber(r) or 0, tonumber(g) or 0, tonumber(b) or 0
	local active = (r ~= 0 or g ~= 0 or b ~= 0)
	if not active then
		if tintFrame then tintFrame:Hide() end
		return
	end
	if not tintFrame then
		if not WorldFrame or not CreateFrame then return end
		local layer = CreateFrame("Frame", "PolestarWorldTint", WorldFrame)
		layer:SetAllPoints(WorldFrame)
		layer:SetFrameStrata("BACKGROUND")
		layer:SetFrameLevel(0)
		layer:EnableMouse(false)
		tintFrame = layer
		tintTextures = {}
		for index, blend in ipairs({"MOD", "ADD"}) do
			local texture = layer:CreateTexture(nil, "BACKGROUND", nil, index - 1)
			texture:SetAllPoints()
			texture:SetBlendMode(blend)
			tintTextures[index] = texture
		end
	end
	local multiply = {
		1 - math.max(0, -r) * 0.006,
		1 - math.max(0, -g) * 0.006,
		1 - math.max(0, -b) * 0.006,
	}
	local add = {
		math.max(0, r) * 0.003,
		math.max(0, g) * 0.003,
		math.max(0, b) * 0.003,
	}
	tintTextures[1]:SetColorTexture(multiply[1], multiply[2], multiply[3], 1)
	tintTextures[2]:SetColorTexture(add[1], add[2], add[3], 1)
	tintFrame:Show()
end

---------------------------------------------------------------------------
-- Color presets
---------------------------------------------------------------------------

local PRESETS = {
	default = { gamma = 1.0, brightness = 50, contrast = 50, r = 0, g = 0, b = 0 },
	vivid = { gamma = 1.08, brightness = 50, contrast = 60, r = 5, g = 3, b = 0 },
	bright = { gamma = 1.18, brightness = 57, contrast = 50, r = 0, g = 0, b = 0 },
	dark = { gamma = 1.35, brightness = 54, contrast = 50, r = 0, g = 0, b = 0 },
	crisp = { gamma = 0.90, brightness = 48, contrast = 58, r = 0, g = 0, b = 0 },
	punchy = { gamma = 1.0, brightness = 50, contrast = 70, r = 0, g = 0, b = 0 },
	warm = { gamma = 1.0, brightness = 50, contrast = 52, r = 16, g = 5, b = -14 },
	cool = { gamma = 1.0, brightness = 50, contrast = 52, r = -12, g = 0, b = 16 },
	night = { gamma = 1.10, brightness = 48, contrast = 55, r = -20, g = -8, b = 18 },
	sepia = { gamma = 1.0, brightness = 50, contrast = 50, r = 18, g = 4, b = -28 },
	custom = {},
}

local function presetChoices()
	return {
		{ value = "default", label = L["Standard"] },
		{ value = "vivid", label = L["Vivid"] },
		{ value = "bright", label = L["Bright"] },
		{ value = "dark", label = L["Dark places"] },
		{ value = "crisp", label = L["Crisp"] },
		{ value = "punchy", label = L["High contrast"] },
		{ value = "warm", label = L["Warm"] },
		{ value = "cool", label = L["Cool"] },
		{ value = "night", label = L["Night"] },
		{ value = "sepia", label = L["Sepia"] },
		{ value = "custom", label = L["Custom"] },
	}
end

function Graphics.ApplyPreset(key)
	local p = PRESETS[key]
	if not p or key == "custom" then return end
	isApplyingPreset = true
	ns.Set("qol.gamma", p.gamma)
	ns.Set("qol.brightness", p.brightness)
	ns.Set("qol.contrast", p.contrast)
	ns.Set("qol.tintRed", p.r)
	ns.Set("qol.tintGreen", p.g)
	ns.Set("qol.tintBlue", p.b)
	isApplyingPreset = false
	Graphics.Apply()
end

---------------------------------------------------------------------------
-- Apply settings to client
---------------------------------------------------------------------------

function Graphics.Apply()
	if InCombatLockdown() then
		pendingApply = true
		return
	end
	if not QoL.On("graphicsEnabled") then
		if tintFrame then tintFrame:Hide() end
		return
	end

	-- Vegetation & Scenery
	writeCVar("groundEffectDensity", ns.Get("qol.grassDensity"))
	writeCVar("groundEffectDist", ns.Get("qol.grassDist"))
	writeCVar("terrainLodDist", ns.Get("qol.terrainLodDist"))
	writeCVar("lodObjectFadeScale", ns.Get("qol.objectFade"))
	writeCVar("farclip", ns.Get("qol.viewDist"))

	-- Color & Image Controls
	writeCVar("Gamma", ns.Get("qol.gamma"))
	writeCVar("Brightness", ns.Get("qol.brightness"))
	writeCVar("Contrast", ns.Get("qol.contrast"))

	-- Post-Processing effects
	if Graphics.CVarSupported("ffxGlow") then
		writeCVar("ffxGlow", QoL.On("noGlow") and "0" or "1")
	end
	if Graphics.CVarSupported("ffxDeath") then
		writeCVar("ffxDeath", QoL.On("noDeathEffect") and "0" or "1")
	end
	if Graphics.CVarSupported("ResampleSharpness") then
		writeCVar("ResampleSharpness", ns.Get("qol.sharpness"))
	end

	-- Camera
	writeCVar("cameraDistanceMaxZoomFactor", ns.Get("qol.cameraZoom"))
	if Graphics.CVarSupported("cameraFov") then
		writeCVar("cameraFov", ns.Get("qol.cameraFov"))
	end

	-- World Tint
	applyTint(ns.Get("qol.tintRed"), ns.Get("qol.tintGreen"), ns.Get("qol.tintBlue"))
end

ns.OnLogin(Graphics.Apply)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if pendingApply then
		pendingApply = false
		Graphics.Apply()
	end
end)

ns.On("SETTING_CHANGED", function(path)
	if path == "qol.colorPreset" then
		Graphics.ApplyPreset(ns.Get("qol.colorPreset"))
		beginMeasurement()
	elseif path == "qol.gamma" or path == "qol.brightness" or path == "qol.contrast" or
	       path == "qol.tintRed" or path == "qol.tintGreen" or path == "qol.tintBlue" then
		if not isApplyingPreset and ns.Get("qol.colorPreset") ~= "custom" then
			ns.Set("qol.colorPreset", "custom")
		end
		Graphics.Apply()
		beginMeasurement()
	elseif path:find("^qol%.grass") or path == "qol.terrainLodDist" or path == "qol.objectFade" or
	       path == "qol.viewDist" or path == "qol.sharpness" or path == "qol.noGlow" or
	       path == "qol.graphicsEnabled" then
		Graphics.Apply()
		beginMeasurement()
	elseif path:find("^qol%.") or path == "" then
		Graphics.Apply()
	end
end)

---------------------------------------------------------------------------
-- Options Registration
---------------------------------------------------------------------------

if not ns.RegisterOptions then return end

local QOL = L["Quality of Life"]
local TAB = L["Graphics"]

-- Helper for disabled state when graphicsEnabled is off
local function off() return not QoL.On("graphicsEnabled") end

-- 1. Performance & FPS Feedback
ns.RegisterOptions({
	page = QOL,
	tab = TAB,
	section = L["Performance & FPS"],
	controls = {
		{
			kind = "button",
			label = function() return Graphics.GetFpsStatusText() end,
			button = L["Check FPS"],
			help = L["Measures current framerate. Adjusting any graphics setting automatically tracks FPS impact before and after."],
			onClick = function() Graphics.MeasureFps(true) end,
			search = "fps, framerate, benchmark, performance, speed, measure",
		},
		{
			kind = "toggle",
			key = "qol.fpsFeedback",
			label = L["Show FPS change in chat"],
			help = L["Prints a message in chat showing the framerate impact a few seconds after changing graphics settings."],
			search = "fps, framerate, notification, chat, performance",
		},
	},
})

-- 2. Vegetation & Scenery
ns.RegisterOptions({
	page = QOL,
	tab = TAB,
	section = L["Vegetation & Scenery"],
	controls = {
		{
			kind = "toggle",
			key = "qol.graphicsEnabled",
			label = L["Enhanced graphics"],
			help = L["Apply unlocked grass density, extended scenery rendering distances, and color controls."],
			search = "graphics, visual, visuals, grass, density, view distance, scenery, landscape",
		},
		{
			kind = "slider",
			key = "qol.grassDensity",
			label = L["Grass density"],
			help = L["Amount of ground vegetation (groundEffectDensity). Up to 256 for dense ground cover."],
			min = 16, max = 256, step = 16, format = "%d",
			release = true, child = true, disabled = off,
			needs = function() return Graphics.CVarSupported("groundEffectDensity") end,
			search = "grass density, ground vegetation, flora, weeds, clutter",
		},
		{
			kind = "slider",
			key = "qol.grassDist",
			label = L["Grass distance"],
			help = L["Visibility range of ground vegetation (groundEffectDist). Up to 500 yards."],
			min = 50, max = 500, step = 10,
			format = function(v) return string.format(L["%d yd"], math.floor(v + 0.5)) end,
			release = true, child = true, disabled = off,
			needs = function() return Graphics.CVarSupported("groundEffectDist") end,
			search = "grass distance, foliage range, vegetation distance",
		},
		{
			kind = "slider",
			key = "qol.terrainLodDist",
			label = L["Terrain detail distance"],
			help = L["Range at which terrain keeps its detailed representation (terrainLodDist)."],
			min = 200, max = 1500, step = 50,
			format = function(v) return string.format(L["%d yd"], math.floor(v + 0.5)) end,
			release = true, child = true, disabled = off,
			needs = function() return Graphics.CVarSupported("terrainLodDist") end,
			search = "terrain lod, terrain detail, landscape distance",
		},
		{
			kind = "slider",
			key = "qol.objectFade",
			label = L["Object fade distance"],
			help = L["Visibility range scale for scenery objects and doodads (lodObjectFadeScale)."],
			min = 50, max = 300, step = 10, format = "%d%%",
			release = true, child = true, disabled = off,
			needs = function() return Graphics.CVarSupported("lodObjectFadeScale") end,
			search = "object fade, doodads, scenery distance, draw distance",
		},
		{
			kind = "slider",
			key = "qol.viewDist",
			label = L["View distance"],
			help = L["Maximum distance at which horizon scenery is rendered (farclip)."],
			min = 500, max = 10000, step = 250,
			format = function(v) return string.format(L["%d yd"], math.floor(v + 0.5)) end,
			release = true, child = true, disabled = off,
			needs = function() return Graphics.CVarSupported("farclip") end,
			search = "view distance, farclip, horizon, draw distance",
		},
	},
})

-- 3. Color & Post-Processing
ns.RegisterOptions({
	page = QOL,
	tab = TAB,
	section = L["Color & Post-Processing"],
	controls = {
		{
			kind = "dropdown",
			key = "qol.colorPreset",
			label = L["Color preset"],
			help = L["Quick atmospheric and color-grading profiles."],
			choices = presetChoices,
			disabled = off,
			search = "color profile, mood, atmospheric, vivid, warm, cool, sepia, tint",
		},
		{
			kind = "slider",
			key = "qol.gamma",
			label = L["Gamma"],
			help = L["Midtone luminance response (Gamma)."],
			min = 0.5, max = 2.5, step = 0.05, format = "%.2f",
			release = true, disabled = off,
			needs = function() return Graphics.CVarSupported("Gamma") end,
			search = "gamma, midtones, exposure, brightness",
		},
		{
			kind = "slider",
			key = "qol.brightness",
			label = L["Brightness"],
			help = L["Overall image brightness (Brightness)."],
			min = 0, max = 100, step = 1, format = "%d%%",
			release = true, disabled = off,
			needs = function() return Graphics.CVarSupported("Brightness") end,
			search = "brightness, light, dark",
		},
		{
			kind = "slider",
			key = "qol.contrast",
			label = L["Contrast"],
			help = L["Separation between dark and bright tones (Contrast)."],
			min = 0, max = 100, step = 1, format = "%d%%",
			release = true, disabled = off,
			needs = function() return Graphics.CVarSupported("Contrast") end,
			search = "contrast, dynamic range, separation",
		},
		{
			kind = "slider",
			key = "qol.tintRed",
			label = L["Red tint"],
			help = L["Red channel tint adjustment for the 3D world (does not tint the user interface)."],
			min = -50, max = 50, step = 1,
			format = function(v) return string.format("%+d", math.floor(v + 0.5)) end,
			release = true, disabled = off,
			search = "red tint, color balance, warm",
		},
		{
			kind = "slider",
			key = "qol.tintGreen",
			label = L["Green tint"],
			help = L["Green channel tint adjustment for the 3D world (does not tint the user interface)."],
			min = -50, max = 50, step = 1,
			format = function(v) return string.format("%+d", math.floor(v + 0.5)) end,
			release = true, disabled = off,
			search = "green tint, color balance",
		},
		{
			kind = "slider",
			key = "qol.tintBlue",
			label = L["Blue tint"],
			help = L["Blue channel tint adjustment for the 3D world (does not tint the user interface)."],
			min = -50, max = 50, step = 1,
			format = function(v) return string.format("%+d", math.floor(v + 0.5)) end,
			release = true, disabled = off,
			search = "blue tint, color balance, cool",
		},
		{
			kind = "toggle",
			key = "qol.noGlow",
			label = L["Disable full-screen glow"],
			help = L["Removes the client's blurry bloom/glow post-processing filter for a cleaner, crisper image (ffxGlow)."],
			disabled = off,
			needs = function() return Graphics.CVarSupported("ffxGlow") end,
			search = "glow, blur, vaseline, bloom, ffxGlow, sharp, crisp",
		},
		{
			kind = "toggle",
			key = "qol.noDeathEffect",
			label = L["Disable death effect"],
			help = L["Keeps full color and clear vision while dead instead of the grey screen (ffxDeath)."],
			disabled = off,
			needs = function() return Graphics.CVarSupported("ffxDeath") end,
			search = "death, corpse, grey screen, ghost, ffxDeath, black and white",
		},
		{
			kind = "slider",
			key = "qol.sharpness",
			label = L["Resample sharpness"],
			help = L["Strength of the resampling sharpening filter (ResampleSharpness)."],
			min = 0, max = 2.0, step = 0.05, format = "%.2f",
			release = true, disabled = off,
			needs = function() return Graphics.CVarSupported("ResampleSharpness") end,
			search = "sharpness, fsr, resample, filter, clarity",
		},
	},
})

-- 4. Camera
ns.RegisterOptions({
	page = QOL,
	tab = TAB,
	section = L["Camera"],
	controls = {
		{
			kind = "slider",
			key = "qol.cameraZoom",
			label = L["Maximum camera zoom"],
			help = L["Maximum zoom-out distance factor (cameraDistanceMaxZoomFactor). Up to 4.0 (50 yards)."],
			min = 1.0, max = 4.0, step = 0.1,
			format = function(v) return string.format("%.1fx", v) end,
			release = true, disabled = off,
			needs = function() return Graphics.CVarSupported("cameraDistanceMaxZoomFactor") end,
			search = "zoom, max zoom, camera distance, zoom out, distance factor",
		},
		{
			kind = "slider",
			key = "qol.cameraFov",
			label = L["Field of view"],
			help = L["Camera field of view in degrees (cameraFov)."],
			min = 50, max = 120, step = 1,
			format = function(v) return string.format("%d\194\176", math.floor(v + 0.5)) end,
			release = true, disabled = off,
			needs = function() return Graphics.CVarSupported("cameraFov") end,
			search = "fov, field of view, wide angle, camera angle",
		},
	},
})
