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
		alpha = F:GetAlpha(), shown = F:IsShown(), rules = P.after.Rule:IsShown(), person = P.person:IsShown(),
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
		-- The window's own text size: its goal text, and its height growing with it.
		["ui.guideTextSize"] = function() return { snapshot().rowText, snapshot().height } end,
		["ui.width"] = one("width"),
		-- A tall step (the biggest goals and spacing, six steps up next): the cap on the window's height.
		["ui.maxHeight"] = { value = 0.3, with = { ["guideWindow.goalSize"] = 1.8, ["guideWindow.rowSpacing"] = 12, ["ui.upcoming"] = 6 }, probe = one("height") },
		-- Fixed: the window is the height for a short step too (#1067); the progress bar under the last goal or on
		-- the window's edge.
		["ui.heightMode"] = { value = "fixed", probe = one("height") },
		["ui.footAt"] = { value = "edge", with = { ["ui.heightMode"] = "fixed" },
			probe = function() local p, rel, rp, _, y = P.foot:GetPoint(1); return { p, rp, rel == F, y } end },
		["guideWindow.padding"] = one("rowTextX"),
		["ui.compact"] = function() return { snapshot().person, snapshot().height } end,
		["guideWindow.bgOpacity"] = function() return { snapshot().bgAlpha, rgba(F.psSkin.bg) } end,
		["guideWindow.bgColor"] = function() return { snapshot().bgColor, rgba(F.psSkin.bg) } end,
		["ui.opacity"] = one("alpha"),
		["guideWindow.idleAlpha"] = one("alpha"),
		["guideWindow.border"] = one("noBorder"),
		["guideWindow.rules"] = function() return { P.strip.Rule:IsShown(), P.after.Rule:IsShown() } end,
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
		["guideWindow.tabStyle"] = { with = { ["guideWindow.tabs"] = true }, probe = function()
			local function shown(f) return f and f:IsShown() or false end
			return { P.strip:IsShown(), shown(P.tabSwitch), shown(P.tabEdge), shown(P.tabSide) }
		end },
		["guideWindow.navHeight"] = one("nav"),
		-- Another tab's step 10 yd off: its card shows, or not (the tab's place and the player's are given for the
		-- look, then put back).
		["guideWindow.otherTabNear"] = function()
			local E, C, OT = Polestar.Engine, Polestar.Compat, Polestar.UI.OtherTabCard
			local places, here, world = E.OtherTabPlaces, C.GetPlayerWorldPosition, C.MapToWorld
			E.OtherTabPlaces = function() return { { index = 2, guideId = "Effects/other", title = "Other", step = 1, stepNumber = 1, map = 1, x = 10, y = 0 } } end
			C.GetPlayerWorldPosition = function() return 1, 0, 0 end
			C.MapToWorld = function(_, x, y) return 1, x, y end
			OT.Check()
			local shown = OT.Shown() ~= nil
			E.OtherTabPlaces, C.GetPlayerWorldPosition, C.MapToWorld = places, here, world
			OT.Check()
			return shown
		end,
		["guideWindow.barTextSize"] = one("count"),
		["guideWindow.stepCount"] = one("steps"),
		["guideWindow.guideTitle"] = { with = { ["guideWindow.stepCount"] = false }, probe = one("title") },
		["guideWindow.skipButton"] = one("skip"),
		["guideWindow.reportButton"] = one("report"),
		["guideWindow.allStepsButton"] = function() return P.nav.AllSteps:IsShown() end,
		["guideWindow.titleSize"] = one("name"),
		["guideWindow.lastSteps"] = function() return { P.last.psCount, snapshot().height } end,
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
		-- The XP row's line: the pace part goes (#2371, #2379). The step has no level target here, so the pace is a
		-- fixed line for the check.
		["guideWindow.pace"] = {
			prepare = function()
				GF.psPaceText = GF.PaceText
				GF.PaceText = function() return "On pace for level 6 by step 12" end
				GF.UpdateXP()
			end,
			probe = function() return GF.xp.psHas and GF.xp.Text:GetText() or false end,
			cleanup = function()
				GF.PaceText, GF.psPaceText = GF.psPaceText, nil
				GF.UpdateXP()
			end },
		-- The XP row's own line (#3304): XP an hour, time to level and the pace go; with nothing else to say the row
		-- goes too.
		["guideWindow.xpLine"] = {
			prepare = function()
				GF.psPaceText = GF.PaceText
				GF.PaceText = function() return "On pace for level 6 by step 12" end
				GF.UpdateXP()
			end,
			probe = function() return GF.xp.psHas and GF.xp.Text:GetText() or false end,
			cleanup = function()
				GF.PaceText, GF.psPaceText = GF.psPaceText, nil
				GF.UpdateXP()
			end },
		-- The Still to do rows (#3303): a quest an update left behind the player (Engine.GetBehind, the fake
		-- Engine's answer) as a row under the step.
		["guideWindow.stillToDo"] = {
			prepare = function()
				Polestar.Engine.GetBehind = function() return { { quest = 1, title = "Left behind", zone = "Elwynn Forest" } } end
				uistub.update()
			end,
			probe = function()
				for _, r in ipairs(GF.alongRows) do
					if r:IsShown() and r.psBehind then return r.Text:GetText() end
				end
				return false
			end,
			cleanup = function()
				Polestar.Engine.GetBehind = nil
				uistub.update()
			end },
		-- The quest log notices (#4112): three quests off the route (RoutePlan.OffRoute) as the card's cleanup line,
		-- and a finished quest no guide ahead hands in (RoutePlan.Carried) as a row under the step. The off-route list
		-- is read when the step changes: the step changes and comes back.
		["guideWindow.questLogNotices"] = {
			prepare = function()
				local P = Polestar.RoutePlan
				P.psOffRoute, P.psCarried = P.OffRoute, P.Carried
				P.OffRoute = function() return { { quest = 1, title = "A" }, { quest = 2, title = "B" }, { quest = 3, title = "C" } } end
				P.Carried = function() return { { quest = 4, title = "Finished", xp = 100 } } end
				uistub.setStep(2)
				uistub.setStep(3)
			end,
			probe = function()
				local off, carried = false, false
				for _, l in ipairs(GF.lines) do
					if l:IsShown() and l.psRoom then off = l.Text:GetText() end
				end
				for _, r in ipairs(GF.alongRows) do
					if r:IsShown() and r.psCarried then carried = r.Text:GetText() end
				end
				return { off, carried }
			end,
			cleanup = function()
				local P = Polestar.RoutePlan
				P.OffRoute, P.Carried, P.psOffRoute, P.psCarried = P.psOffRoute, P.psCarried, nil, nil
				uistub.setStep(2)
				uistub.setStep(3)
			end },
		["guideWindow.foldAnim"] = fold,
		-- The step's "N left out here" line (Engine.LeftOutHere, the fake Engine's answer for the step).
		["guideWindow.leftOut"] = function()
			Polestar.Engine.LeftOutHere = function() return { { quest = 1, title = "Left out", kind = "pre", text = "Requires another quest first" } } end
			uistub.update()
			for _, l in ipairs(GF.lines) do
				if l:IsShown() and l.psOut then return true end
			end
			return false
		end,
		-- A preset card (Compact): the window narrower, without the step's person.
		["Guide window:Presets"] = function() return { snapshot().width, snapshot().person } end,
	},
}
