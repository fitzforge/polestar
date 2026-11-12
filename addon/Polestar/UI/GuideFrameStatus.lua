-- The guide window's XP and party lines (UI/GuideFrame.lua).

local ADDON, ns = ...
local UI, Theme, L = ns.UI, ns.Theme, ns.L
local GF = UI.GuideFrame
local whenReady = GF.WhenReady

-- The window's parts and sizes, handed over by the core (GF.Bind).
local PAD
GF.Bind(function(p, m)
	PAD = m.PAD
end)

-- Where the character stands against the guide (Core/Levels.lua, Levels.Pace),
-- in one line; stats: the QoL tracker's, whose XP an hour turns XP short into
-- grinding time. "Behind" only past GF.PACE_SLACK levels short of the route's
-- target (Fitz, 0.3.6: a few bars short read as a warning and players thought
-- they were behind); within it, on pace. On pace: "On pace for level 14 by
-- step 32"; at the guide's end, the level the route gets you to ("level 22.4
-- by step 97"). Behind, with a `level` goal ahead that grinds it: "Behind by
-- 2.4 levels: step 32 grinds to level 14 (≈12m)", said plainly. Behind with
-- none, in the warning colour: "Behind by 2.4 levels for level 24 by step 21:
-- grind ≈1h 10m before then" (or "and no grind step ahead"). "≈" is "~" in a
-- face without it (Theme.Approx, #1906). A quest 3+
-- levels over the character (pace.hard) is named only on the step where it is
-- fought, calmly: "On pace, but Ashenvale Outrunners (24) at step 4 is hard:
-- you're 21.3; reach 22 first", or the "Behind:" form past the slack. nil
-- without a target ahead or the Codex.
GF.PACE_SLACK = 1
function GF.PaceText(stats)
	local Lv = ns.Levels
	local pace = Lv and Lv.Pace and Lv.Pace()
	if not pace then return nil end
	local Q = ns.QoL
	local rate = type(stats) == "table" and type(stats.rate) == "number" and stats.rate > 0 and stats.rate or nil
	-- The time a grind takes, "about" (Theme.Approx: "≈12m", or "~12m" in a face without "≈").
	local function grind(xp)
		if not (rate and type(xp) == "number" and xp > 0 and Q and Q.Duration) then return nil end
		return Theme.Approx() .. Q.Duration(xp / rate * 3600)
	end
	local level = pace.target % 1 == 0 and string.format("%d", pace.target) or string.format("%.1f", pace.target)
	local stepNo = UI.StepNo(pace.step)
	local behind = (pace.short or 0) > GF.PACE_SLACK
	local h = pace.hard
	if h and h.step ~= pace.live then h = nil end
	if h then
		local name, at, you, time = ns.Quoted(h.title) or L["Quest"], UI.StepNo(h.step), GF.LevelText(h.reach), grind(h.xp)
		if not behind then
			return time and string.format(L["On pace, but %s (%d) at step %d is hard: you're %s; grind %s first"], name, h.level, at, you, time)
				or string.format(L["On pace, but %s (%d) at step %d is hard: you're %s; reach %d first"], name, h.level, at, you, h.need)
		end
		local text = time and string.format(L["Behind: %s (%d) at step %d, you're %s; grind %s first"], name, h.level, at, you, time)
			or string.format(L["Behind: %s (%d) at step %d, you're %s; reach %d first"], name, h.level, at, you, h.need)
		return "|c" .. Theme.Hex("warning") .. text .. "|r"
	end
	if not behind then
		-- At a guide's end there is no goal to meet, only the level the route
		-- gets you to: say that one, which a character already at the guide's
		-- top passes (15-21 at 21: "level 22.4", never "level 21").
		if pace.kind == "end" and type(pace.reach) == "number" and pace.reach > pace.target then level = GF.LevelText(pace.reach) end
		return string.format(L["On pace for level %s by step %d"], level, stepNo)
	end
	local by = string.format(L["%s levels"], string.format("%.1f", pace.short))
	local time = grind(pace.xp)
	if pace.kind == "goal" then
		-- The guide grinds it at that step: said plainly, not as a warning.
		return time and string.format(L["Behind by %s: step %d grinds to level %s (%s)"], by, stepNo, level, time)
			or string.format(L["Behind by %s: step %d grinds to level %s"], by, stepNo, level)
	end
	local text = time and string.format(L["Behind by %s for level %s by step %d: grind %s before then"], by, level, stepNo, time)
		or string.format(L["Behind by %s for level %s by step %d, and no grind step ahead"], by, level, stepNo)
	return "|c" .. Theme.Hex("warning") .. text .. "|r"
end

-- XP pace from the QoL tracker and the route's pace (GF.PaceText). Hidden
-- when both are off, at max level, or before there is anything to show.
function GF.UpdateXP(stats)
	if not GF.xp then return end
	local Q = ns.QoL
	if stats == nil and Q and Q.GetXPStats then
		local ok, s = pcall(Q.GetXPStats)
		stats = ok and s or nil
	end
	local parts = {}
	if type(stats) == "table" and not stats.maxed and Q then
		local short = Q.XP and Q.XP.Short
		if type(stats.rate) == "number" and stats.rate > 0 and short then
			parts[#parts + 1] = string.format(L["%s XP/h"], short(stats.rate))
		end
		if type(stats.timeToLevel) == "number" and Q.Duration then
			parts[#parts + 1] = string.format(L["%s to level"], Q.Duration(stats.timeToLevel))
		end
	end
	local restLine
	if not (type(stats) == "table" and stats.maxed) then
		local pace = GF.PaceText(stats)
		if pace then parts[#parts + 1] = pace end
		-- Boosted Rest and the sleeping bag (QoL/Rest.lua): empty while its
		-- setting is off or there is nothing to say.
		local rest = Q and Q.Rest and Q.Rest.Parts()
		if rest and #rest > 0 then restLine = table.concat(rest, "  \194\183  ") end
	end
	local xp = GF.xp
	local line = #parts > 0 and table.concat(parts, "  \194\183  ") or nil
	-- Its own line under the XP line; alone, in the XP line's place.
	if not line then line, restLine = restLine, nil end
	local had, hadRest = xp.psHas, xp.psRest ~= nil
	xp.psHas, xp.psRest = line ~= nil, restLine
	if line then
		xp.Text:SetText(line)
		xp.psLine = line
		local ok, summary = pcall(function() return Q.XP and Q.XP.Summary and Q.XP.Summary(stats) end)
		xp.psSummary = ok and summary or nil
	end
	xp.Rest:SetText(restLine or "")
	xp.Rest:SetShown(restLine ~= nil)
	if had ~= xp.psHas or hadRest ~= (restLine ~= nil) then
		xp:SetHeight(restLine and GF.XPROW.h + GF.XPROW.restH or GF.XPROW.h)
		xp.Icon:SetPoint("LEFT", xp, "LEFT", PAD, restLine and GF.XPROW.iconY or -1)
		GF.Layout()
	end
end

ns.On("QOL_XP_UPDATED", whenReady(function(stats) GF.UpdateXP(stats) end))
ns.On("QOL_REST_UPDATED", whenReady(function() GF.UpdateXP() end))
ns.OnLogin(function() GF.UpdateXP() end)
ns.On("STEP_CHANGED", whenReady(function() GF.UpdateXP() end))

-- The party line (Quests/Party.lua, Party.StepLine): hidden without one;
-- "Go on without them" at its end while the group waits on the step.
function GF.UpdateParty()
	if not GF.party then return end
	local P = ns.Party
	local text, holding
	if P and P.StepLine then text, holding = P.StepLine() end
	local had = GF.party.psText ~= nil
	GF.party.psText, GF.party.psHolding = text, holding and true or false
	if text then GF.party.Text:SetText(text) end
	local goOn = GF.party.GoOn
	goOn:SetShown(holding and true or false)
	GF.party.Text:SetPoint("RIGHT", holding and goOn or GF.party, holding and "LEFT" or "RIGHT", holding and -8 or -PAD, 0)
	if had ~= (text ~= nil) then GF.Layout() end
end
for _, msg in ipairs({ "PARTY_PROGRESS", "STEP_CHANGED", "STEP_UPDATED", "GUIDE_CHANGED" }) do
	ns.On(msg, whenReady(function() GF.UpdateParty() end))
end
