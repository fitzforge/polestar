-- env: nav
-- The Arrow page (Polestar_Options/Nav/ArrowOptions.lua, Nav/Arrow.lua): every setting on the live arrow, which
-- points at a target 300 yd away (arrival and "no goal" where a setting draws them).
local N, A, nav
local function target(wx, wy) local m, x, y = nav.mapPoint(wx, wy); N.SetTarget(m, x, y, "Marshal Dughan, by the gate of the keep") end
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function textColour(fs) local r, g, b = fs:GetTextColor(); return { r, g, b } end
local function font(fs) local path, size, flags = fs:GetFont(); return { path, size, flags } end
local function far() nav.place(0, 0); stub.advance(0.5) end
local function arrived() nav.place(0, 299); stub.advance(0.3) end
return {
	setup = function()
		N, A, nav = Polestar.Nav, Polestar.Nav.arrow, stub.nav
		target(0, 300)
		far()
	end,
	cleanup = function() far() end,
	probes = {
		["nav.arrow"] = function() return A.frame:IsShown() end,
		["nav.arrowStyle"] = { value = "flat", probe = function() return { A.GetStyle(), A.sheet:IsVisible(), A.body:IsVisible() } end },
		["nav.arrowScale"] = function() return A.frame:GetScale() end,
		["nav.arrowColor"] = function() return { rgba(A.body), rgba(A.sheet) } end,
		["nav.arrowAlpha"] = function() return A.frame:GetAlpha() end,
		-- 20 yd out: the near colour.
		["nav.arrowNearColor"] = { prepare = function() nav.place(0, 280); stub.advance(0.3) end, probe = function() return { rgba(A.body), rgba(A.sheet) } end },
		-- 150 yd out: inside the default range the colour has started to shift.
		["nav.arrowNearRange"] = { prepare = function() nav.place(0, 150); stub.advance(0.3) end, probe = function() return { rgba(A.body), rgba(A.sheet) } end },
		-- A step sideways turns the bearing about 0.2 rad: how far the arrow has eased round a moment later
		-- (the turn's damping, under the per-frame cap).
		["nav.arrowTurn"] = function()
			far(); stub.advance(2)
			nav.place(60, 0); stub.advance(0.1)
			local a = math.floor(A.GetAngle() * 1000 + 0.5)
			far(); stub.advance(2)
			return a
		end,
		-- The dial's ring and glow are the flat and 3D styles' (a skin's own arrow may have neither).
		["nav.arrowRingColor"] = { with = { ["nav.arrowStyle"] = "flat" }, prepare = arrived, probe = function() return rgba(A.ring) end },
		["nav.arrowPulse"] = { with = { ["nav.arrowStyle"] = "flat" }, prepare = arrived,
			probe = function() local w0 = A.ring:GetWidth(); stub.advance(0.3); return w0 ~= A.ring:GetWidth() end },
		["nav.arrowGlowStrength"] = { with = { ["nav.arrowStyle"] = "flat" }, probe = function() return rgba(A.glow)[4] end },
		["nav.arrowGlow"] = { with = { ["nav.arrowStyle"] = "flat" }, probe = function() return A.glow:IsVisible() end },
		-- Arriving: the chime played, or not.
		["nav.arrivalSound"] = function()
			far()
			local n = #stub.sounds
			arrived()
			local played = #stub.sounds > n
			far()
			return played
		end,
		["nav.hideArrowWithGuide"] = { with = { ["ui.shown"] = false }, probe = function() return A.frame:IsShown() end },
		["nav.arrowNoTarget"] = { prepare = function() N.ClearTarget(); stub.advance(0.3) end,
			probe = function() return { A.frame:IsVisible(), A.GetMode(), A.ring:IsVisible() } end,
			cleanup = function() target(0, 300) end },
		["nav.arrowCombatAlpha"] = { prepare = function() stub.inCombat = true; stub.fire("PLAYER_REGEN_DISABLED") end,
			probe = function() return A.frame:GetAlpha() end,
			cleanup = function() stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED") end },
		-- Reset position: the arrow back at the top of the screen.
		["Arrow:Position"] = { press = true, prepare = function() Polestar.Set("nav.arrowPos", { point = "CENTER", relPoint = "CENTER", x = 120, y = -40 }) end,
			probe = function() return { A.frame:GetPoint(1) } end },
		["nav.arrowDistSize"] = function() return font(A.distText)[2] end,
		["nav.arrowDistance"] = function() return A.distText:IsShown() end,
		["nav.arrowDistColor"] = function() return textColour(A.distText) end,
		["nav.distanceUnit"] = function() return A.distText:GetText() end,
		["nav.arrowLabelSize"] = function() return font(A.labelText)[2] end,
		["nav.arrowLabelColor"] = function() return textColour(A.labelText) end,
		["nav.arrowLabelWidth"] = function() return A.labelText:GetWidth() end,
		["nav.arrowLabelLines"] = function() return { A.labelText:GetMaxLines(), A.labelText:IsShown() } end,
		["nav.arrowEtaSize"] = function() return font(A.etaText)[2] end,
		-- Walking toward the goal at 10 yd/s: the arrival time shows, or not.
		["nav.arrowEta"] = function()
			for i = 1, 12 do nav.place(0, i); stub.advance(0.1) end
			local shown = A.etaText:IsVisible()
			far()
			return shown
		end,
		["nav.arrowEtaColor"] = function() return textColour(A.etaText) end,
		["nav.arrowTextPos"] = function() return { (A.dial:GetPoint(1)), (A.etaText:GetPoint(1)) } end,
		["nav.arrowFont"] = { value = "fira", probe = function() return font(A.distText)[1] end },
		["nav.arrowOutline"] = function() return font(A.distText)[3] end,
		["nav.arrowBacking"] = function() return A.backing:IsShown() end,
		["nav.arrowBackingAlpha"] = { with = { ["nav.arrowBacking"] = true }, probe = function() return rgba(A.backing)[4] end },
	},
}
