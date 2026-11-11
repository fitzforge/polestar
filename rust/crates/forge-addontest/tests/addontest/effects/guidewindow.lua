-- env: ui
-- The Guide window page (Polestar_Options/UI/Looks/GuideWindow.lua; UI/GuideFrame*.lua): every setting on the live
-- guide window, three guides open in tabs, on a step with three goals.
local GF, F, P, Anim
local TABS
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function size(fs) return select(2, fs:GetFont()) end
local function flags(fs) return select(3, fs:GetFont()) or "" end
local function firstRow() for _, r in ipairs(GF.rows) do if r:IsShown() and r.psGoal then return r end end end
local function pointX(region) local p = region.points and region.points[1]; return p and p.x end
local function snapshot()
	local r = firstRow()
	local _, _, _, iconX, iconY = r.Icon:GetPoint(1)
	return {
		height = math.floor(F:GetHeight() + 0.5), width = math.floor(F:GetWidth() + 0.5), scale = F:GetScale(),
		strip = P.strip:IsShown() and P.strip:GetHeight() or 0, nav = P.nav:GetHeight(),
		foot = P.foot:IsShown(), line = P.line:GetHeight(), pct = P.foot.Pct:IsShown(),
		rowH = r:GetHeight(), rowText = size(r.Text), rowTextX = pointX(r.Text), icon = r.Icon:GetWidth(), iconY = iconY,
		check = r.Check:GetWidth(), name = size(P.person.Name), tip = size(P.tip.Text), tipShown = P.tip:IsShown(), count = size(P.nav.Steps.Count),
		steps = P.nav.Steps:IsShown(), title = P.nav.Title:IsShown(), skip = P.nav.Skip:IsShown(), report = P.nav.Report:IsShown(),
		markW = r.Mark:GetWidth(), markA = r.Mark:GetAlpha(), markColor = rgba(r.Mark), fill = rgba(P.line.Fill),
		bgColor = F.psBgColor or false, bgAlpha = F.psBgAlpha or false, noBorder = F.psNoBorder or false,
		alpha = F:GetAlpha(), shown = F:IsShown(), rules = P.after.Rule:GetAlpha(), person = P.person:IsShown(),
	}
end
local function one(key) return function() return snapshot()[key] end end
local TRANSPARENT = { ["ui.style"] = "transparent" }
local function shade()
	local s = GF.shades[firstRow().Text]
	return s and s.shown and select(4, s.parts[1]:GetVertexColor()) or false
end
local function veil() return GF.veil and GF.veil.parts and select(4, GF.veil.parts[1]:GetVertexColor()) or false end
local function inCombat() stub.inCombat = true; Polestar.Fire("COMBAT_CHANGED", true); stub.fire("PLAYER_REGEN_DISABLED"); stub.advance(0.5) end
local function outOfCombat() stub.inCombat = false; stub.fire("PLAYER_REGEN_ENABLED"); stub.advance(0.5) end
-- The next step: whether its card slides in, and over how long.
local function slide()
	uistub.setStep(4)
	local t = P.card.psTweens and P.card.psTweens.offset
	local out = { running = Anim.IsRunning(P.card, "offset"), dur = t and t.dur or false }
	stub.advance(1)
	uistub.setStep(3)
	stub.advance(1)
	return out
end
-- Kobold Vermin (the step's third goal) turning done, 0.9 s on (past the hold, into the fold): the share of its row's
-- height left (it shuts like a drawer) or its whole height (it only fades); then open again.
local function fold()
	local g = uistub.goal(3, 3)
	local cur, status = g.progress and g.progress.cur, g.status
	if g.progress then g.progress.cur = g.progress.max or 10 end
	g.status = "done"
	uistub.update()
	stub.advance(0.9)
	local k = false
	for _, r in ipairs(GF.rows) do
		if r:IsShown() and r.psFold then k = r.psK or 1 end
	end
	if g.progress then g.progress.cur = cur end
	g.status = status
	uistub.update()
	stub.advance(1)
	return k
end
return {
	setup = function()
		GF, F, Anim = Polestar.UI.GuideFrame, PolestarGuideFrame, Polestar.Anim
		TABS = { { uistub.elwynn, 3 }, { uistub.tailoring, 2 }, { uistub.stormwindRep, 2 } }
		uistub.openTabs(TABS, 1)
		F = PolestarGuideFrame
		P = GF.parts
		-- The client's line spacing of a string, which the stub lacks: the tip's wrapped lines take it.
		local M = stub.Methods
		if not rawget(M, "SetSpacing") then
			M.SetSpacing = function(self, s) self.spacing = s end
			M.GetSpacing = function(self) return self.spacing or 0 end
			P.tip.Text:SetSpacing(3)
		end
	end,
	settle = 0.3,
	probes = {
		["ui.style"] = { value = "transparent", probe = function() return { snapshot().bgColor, flags(firstRow().Text), F.psSkin and F.psSkin.bg and F.psSkin.bg:IsShown() } end },
		["ui.backing"] = { with = TRANSPARENT, value = "dark", probe = function() return { veil(), shade() } end },
		["guideWindow.veil"] = { with = { ["ui.style"] = "transparent", ["ui.backing"] = "dark" }, probe = veil },
		["guideWindow.shade"] = { with = TRANSPARENT, probe = shade },
		["guideWindow.outline"] = { with = TRANSPARENT, value = "thick", probe = function() return flags(firstRow().Text) end },
		-- The chrome over the world: the tabs and the step bar's buttons, with the cursor away.
		["ui.barShown"] = { with = TRANSPARENT, prepare = function() if GF.Watch then GF.Watch() end end,
			probe = function() return { P.strip:GetAlpha(), P.nav.Steps:GetAlpha() } end },
		["ui.scale"] = one("scale"),
		["ui.width"] = one("width"),
		-- A tall step (the biggest goals and spacing, six steps up next): the cap on the window's height.
		["ui.maxHeight"] = { value = 0.3, with = { ["guideWindow.goalSize"] = 1.8, ["guideWindow.rowSpacing"] = 12, ["ui.upcoming"] = 6 }, probe = one("height") },
		["guideWindow.padding"] = one("rowTextX"),
		["ui.compact"] = function() return { snapshot().person, snapshot().height } end,
		["guideWindow.bgOpacity"] = function() return { snapshot().bgAlpha, rgba(F.psSkin.bg) } end,
		["guideWindow.bgColor"] = function() return { snapshot().bgColor, rgba(F.psSkin.bg) } end,
		["ui.opacity"] = one("alpha"),
		["guideWindow.idleAlpha"] = one("alpha"),
		["guideWindow.border"] = one("noBorder"),
		["guideWindow.rules"] = function() return { P.strip.Rule:IsShown(), P.after.Rule:GetAlpha() } end,
		["ui.combat"] = { value = "hide", prepare = inCombat, probe = function() return { F:IsShown(), F:GetAlpha() } end, cleanup = outOfCombat },
		["guideWindow.combatAlpha"] = { with = { ["ui.combat"] = "fade" }, prepare = inCombat, probe = function() return F:GetAlpha() end, cleanup = outOfCombat },
		["ui.instance"] = { prepare = function() uistub.instance = "party"; stub.fire("PLAYER_ENTERING_WORLD"); stub.advance(0.5) end,
			probe = function() return F:IsShown() end,
			cleanup = function() uistub.instance = nil; stub.fire("PLAYER_ENTERING_WORLD"); stub.advance(0.5) end },
		["guideWindow.hideTaxi"] = { prepare = function() UnitOnTaxi = function() return true end; GF.ApplyVisibility() end,
			probe = function() GF.ApplyVisibility(); return F:IsShown() end,
			cleanup = function() UnitOnTaxi = function() return false end; GF.ApplyVisibility() end },
		["ui.growUp"] = function() local p, _, rp = F:GetPoint(1); return { p, rp } end,
		["ui.barsBottom"] = { with = { ["ui.growUp"] = true }, probe = function() local p, _, rp = P.strip:GetPoint(1); return { p, rp } end },
		["guideWindow.stepAnim"] = function() return slide().running end,
		["guideWindow.animSpeed"] = function() return slide().dur end,
		["guideWindow.tabHeight"] = one("strip"),
		["guideWindow.tabs"] = one("strip"),
		["guideWindow.navHeight"] = one("nav"),
		["guideWindow.barTextSize"] = one("count"),
		["guideWindow.stepCount"] = one("steps"),
		["guideWindow.guideTitle"] = { with = { ["guideWindow.stepCount"] = false }, probe = one("title") },
		["guideWindow.skipButton"] = one("skip"),
		["guideWindow.reportButton"] = one("report"),
		["guideWindow.titleSize"] = one("name"),
		["guideWindow.goalSize"] = one("rowText"),
		["guideWindow.detailSize"] = function() return size(P.person.Where) end,
		["guideWindow.glyphSize"] = one("icon"),
		["guideWindow.rowSpacing"] = one("rowH"),
		["guideWindow.lineSpacing"] = function() return P.tip.Text:GetSpacing() end,
		["guideWindow.checkSize"] = one("check"),
		["guideWindow.targetBarWidth"] = one("markW"),
		["guideWindow.targetBar"] = one("markA"),
		["guideWindow.targetBarColor"] = one("markColor"),
		["guideWindow.noteSize"] = one("tip"),
		["ui.showNotes"] = one("tipShown"),
		["ui.upcoming"] = function() return P.upnext:IsShown() and P.upnext:GetHeight() or 0 end,
		["guideWindow.upSize"] = { with = { ["ui.upcoming"] = 3 }, probe = function()
			for _, fs in ipairs({ P.upnext:GetRegions() }) do if fs.GetFont and fs:IsShown() then return size(fs) end end
			return P.upnext:GetHeight()
		end },
		["guideWindow.progressHeight"] = one("line"),
		["guideWindow.progress"] = one("foot"),
		["guideWindow.progressColor"] = one("fill"),
		["guideWindow.progressPct"] = one("pct"),
		["guideWindow.foldAnim"] = fold,
		-- A preset card (Compact): the window narrower, without the step's person.
		["Guide window:Presets"] = function() return { snapshot().width, snapshot().person } end,
	},
}
