-- The guide window's banner: the notices above the step, and the wheel and
-- overview over the step number (UI/GuideFrame.lua).

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local UI, Theme, L, floor = ns.UI, ns.Theme, ns.L, math.floor
	local Engine = GF.Engine

	-- The window's parts and sizes, handed over by the core (GF.Bind).
	local F, banner
	local PAD
	GF.Bind(function(p, m)
		F, banner = p.F, p.banner
		PAD = m.PAD
	end)

	---------------------------------------------------------------------------
	-- Banners: the tab the player just closed, with its Reopen (for
	-- GF.CLOSED_SECONDS, shown even with no tab left); "Continue automatically"
	-- moving on from a finished leveling guide (for SKIPPED_SECONDS); the group
	-- quest the live step waits on
	-- (`when group`: Skip it, the default, or Do it with a group; it cannot be
	-- dismissed); the dungeon it waits on ("Dungeons in my route": Ask me; Run
	-- it or Skip it, never dismissed); a dungeon the party is running that the
	-- character skips (Quests/Party.lua Party.DungeonOffer: Run it this time or
	-- Not now, once a session per dungeon), and after "No group? Skip it" the
	-- dungeon's quests kept in the log; the step the player just skipped, with
	-- its undo; why the guide just moved past a quest (while that step's guide
	-- and next step are on screen); the step on screen when it is not the live
	-- one (skipped: unskip it; looked at with ‹ ›: back to the live step); at a
	-- chosen dungeon's run, until inside, "No group? Skip it", and a few steps
	-- before it the start-looking line; then the end of a leveling
	-- guide reached with steps still open (Start the next guide, GF.EndOffer),
	-- then the out-levelled offer
	-- (while its guide is active), then the training reminder, the riding one,
	-- then a Class guide that just opened (QoL/ClassQuests.lua), then the bags
	-- nearly full while the step collects (QoL/Space.lua: delete the cheapest
	-- junk, two clicks), then gear worth wearing from loot or a merchant
	-- (QoL/Wear.lua: Wear it, Not this one), last a newer Polestar or an old
	-- build (UI/UpdateCard.lua: Update; shown with no guide open too). Taking
	-- or dismissing one lets the next through.
	---------------------------------------------------------------------------

	local SKIPPED_SECONDS = 20 -- how long the "Skipped …" notices stay
	local notices = { closedTab = nil, questSkip = nil, stepSkip = nil, skipped = nil, away = nil, outlevel = nil, train = nil, riding = nil, classQuest = nil, dungeonKept = nil, soonSeen = nil }
	GF.notices = notices

	-- The step on screen when it is not the live step: { guideId, index, live,
	-- skipped }, or nil. Dismissed per step (notices.away holds the key).
	local function awayNotice(E, g)
		local view = GF.View()
		if not (E.GetLiveStep and view and g) then return nil end
		local index, live = E.GetStepIndex(), E.GetLiveStep()
		if not index or index ~= view.index or index == live then return nil end
		if not view.skipped and not live then return nil end
		local a = { guideId = g.id, index = index, live = live, skipped = view.skipped and true or false }
		if notices.away == g.id .. ":" .. index then return nil end
		return a
	end

	local function navTrip()
		local nav = ns.Nav
		return nav and nav.Trip and nav.Trip() or nil
	end

	-- The end of the active leveling guide reached while steps are still open
	-- (Engine.GuideEnded; the guide-end window's "Back to step N", UI/GuideEnd.lua):
	-- what to start from here, { guideId, label = "The Barrens (12–16)" } or
	-- { guideId, choose = true } for a route choice; nil with nothing to start,
	-- on a finished guide (its complete page offers the next one) or once
	-- dismissed (notices.endSeen, for the session).
	function GF.EndOffer(E, g)
		if not (g and E and E.GuideEnded and E.GetLiveStep and E.GetLiveStep() ~= nil) then return nil end
		if notices.endSeen == g.id or not E.GuideEnded(g.id) then return nil end
		local G = ns.Guides
		local nextId = E.NextGuide and E.NextGuide(g.id)
		local nextGuide = nextId and G and G.Get and G.Get(nextId)
		if nextGuide then
			local lv = UI.LevelRange(nextGuide.minLevel, nextGuide.maxLevel)
			return { guideId = g.id, label = (nextGuide.title or nextId) .. (lv and (" (" .. lv .. ")") or "") }
		end
		local choice = E.GetRouteChoice and E.GetRouteChoice(g.id)
		if choice and #choice.options >= 2 then return { guideId = g.id, choose = true } end
		return nil
	end

	-- The notice the banner shows now, if any. A copy shows none: what they
	-- say comes from the session (a trip, a tab closed, the bags, an update),
	-- not from its content.
	local function bannerNotice()
		if not GF.live then return nil end
		local view = GF.View()
		local E = Engine()
		local g = E and E.GetGuide and E.GetGuide()
		-- On the way to a nearby service, a dungeon or a trainer (Nav.StartTrip): the way back first.
		local t = navTrip()
		if t then return "trip", t end
		-- The tab just closed, until it is open again.
		local ct = notices.closedTab
		if ct and not (E and E.TabIds and E.TabIds()[ct.guideId]) then return "closedTab", ct end
		if notices.questSkip then return "questSkip", notices.questSkip end
		-- "Continue automatically" moved on from a finished leveling guide.
		local c = notices.continued
		if c and g ~= nil and g.id == c.to then return "continued", c end
		-- A quest the route had passed left the log: the guide holds and asks.
		local lq, ltitle
		if E and E.LostQuestion then lq, ltitle = E.LostQuestion() end
		if lq then return "lost", { quest = lq, title = ltitle } end
		local gq, gtitle
		if E and E.GroupQuestion then gq, gtitle = E.GroupQuestion() end
		if gq then return "group", { quest = gq, title = gtitle } end
		-- A dungeon in the route not answered yet (Engine.DungeonQuestion): the guide waits and asks.
		local dq = E and E.DungeonQuestion and E.DungeonQuestion()
		if dq then return "dungeon", dq end
		-- Your party is running a dungeon you skip (Party.DungeonOffer): run it with them, or not now.
		local P = ns.Party
		local po = P and P.DungeonOffer and P.DungeonOffer()
		if po then return "partyDungeon", po end
		-- After "No group? Skip it": the quests kept in the log, until closed.
		if notices.dungeonKept then return "dungeonKept", notices.dungeonKept end
		local k = notices.stepSkip
		if k and g ~= nil and g.id == k.guideId and (not view or view.index ~= k.step) then return "stepSkip", k end
		local s = notices.skipped
		if s and g ~= nil and g.id == s.guideId and E.GetStepIndex() == s.to then return "skipped", s end
		local a = E and awayNotice(E, g)
		if a then return "away", a end
		-- At a chosen dungeon's run, until inside: "No group? Skip it"; a few steps before it: start looking for a group.
		local dr = E and E.DungeonRun and E.DungeonRun()
		local C = ns.Compat
		if dr and not (C and C.IsInInstance and C.IsInInstance()) then return "dungeonRun", dr end
		local ds = E and E.DungeonSoon and E.DungeonSoon()
		if ds and notices.soonSeen ~= ds.map then return "dungeonSoon", ds end
		-- The live step's accepts would not fit in the quest log (Core/RoutePlan.lua).
		local lo = g ~= nil and view and E.GetLiveStep and view.index == E.GetLiveStep() and ns.RoutePlan and ns.RoutePlan.LogOverflow()
		if lo and notices.logSeen ~= g.id .. ":" .. view.index then
			lo.key = g.id .. ":" .. view.index
			return "log", lo
		end
		local en = GF.EndOffer(E, g)
		if en then return "ended", en end
		local o = notices.outlevel
		if o and g ~= nil and g.id == o.guideId then return "outlevel", o end
		if notices.train then return "train", notices.train end
		if notices.riding then return "riding", notices.riding end
		if notices.classQuest then return "classQuest", notices.classQuest end
		local Q = ns.QoL
		local bags = Q and Q.Space and Q.Space.Banner and Q.Space.Banner()
		if bags then return "bags", bags end
		local wear = Q and Q.Wear and Q.Wear.Offer and Q.Wear.Offer()
		if wear then return "wear", wear end
		-- A newer Polestar (UI/UpdateCard.lua): last, so it waits for every other.
		local UC = UI.UpdateCard
		local up = UC and UC.Banner and UC.Banner()
		if up then return "update", up end
		return nil
	end
	GF.BannerNotice = bannerNotice

	-- Skip the step on screen (the navigator's Skip, the menu).
	function GF.SkipStep()
		local E = Engine()
		if E and E.Skip and E.GetGuide and E.GetGuide() then E.Skip() end
	end

	-- Look at step i through Prev and Next, which change nothing (Goto would
	-- un-skip a skipped step). Steps not for this character are passed over, so
	-- it stops at the nearest one it can reach.
	function GF.LookAt(i)
		local E = Engine()
		if not (E and E.GetStepIndex and E.Next and E.Prev and type(i) == "number") then return end
		for _ = 1, E.GetStepCount() do
			local at = E.GetStepIndex()
			if not at or at == i then return end
			if at < i then E.Next() else E.Prev() end
			if E.GetStepIndex() == at then return end
		end
	end

	-- The wheel over the step number: each notch looks one step back (up) or on
	-- (down), ten with Shift, changing nothing. SCRUB_BACK seconds after the
	-- last notch the window is back on the live step, unless the player has
	-- moved on from where the wheel left it, or has been doing that step's work
	-- meanwhile (a goal done or counted up, a quest taken): then it stays, as
	-- after Next. In combat it waits until the fight is over.
	local SCRUB_BACK = 4
	local scrubAt -- { step, mark }: the last notch's, until it is settled

	-- What has been done on step i so far, as one string (GF.Scrub compares it).
	function GF.ScrubMark(E, i)
		local v = E.GetStepView(i)
		if not v then return "" end
		local parts = { tostring(v.status) }
		for g, goal in ipairs(v.goals or {}) do
			parts[#parts + 1] = g .. ":" .. tostring(goal.status) .. ":" .. tostring(goal.progress and goal.progress.cur or "")
		end
		return table.concat(parts, ",")
	end

	function GF.Scrub(delta)
		local E = Engine()
		if not (E and E.GetStepIndex and E.GetLiveStep and E.GetStepIndex()) then return end
		local n = ns.Compat.IsShiftKeyDown() and 10 or 1
		GF.LookAt(math.max(1, math.min(E.GetStepCount(), E.GetStepIndex() + (delta > 0 and -n or n))))
		local at = E.GetStepIndex()
		local mine = { step = at, mark = GF.ScrubMark(E, at) }
		scrubAt = mine
		local function back()
			if scrubAt ~= mine then return end
			local live = E.GetLiveStep()
			if E.GetStepIndex() ~= at or not live or at == live or GF.ScrubMark(E, at) ~= mine.mark then
				scrubAt = nil
				return
			end
			if ns.Compat.InCombat() then
				ns.After(SCRUB_BACK, back)
				return
			end
			scrubAt = nil
			GF.LookAt(live)
		end
		ns.After(SCRUB_BACK, back)
	end

	-- How long a closed tab's Reopen stays (TAB_CLOSED below; later: the guide
	-- list's Recently closed, the menus' Reopen closed tab, /polestar reopen,
	-- its key binding).
	GF.CLOSED_SECONDS = 10

	-- The notices the session raises, the live window's (a copy shows none).
	if GF.live then
		-- PLAYER_SKIPPED_STEP(guideId, step): from the window or /polestar skip, the
		-- banner offers the undo for SKIPPED_SECONDS.
		ns.On("PLAYER_SKIPPED_STEP", function(guideId, step)
			if not F or type(step) ~= "number" then return end
			local G = ns.Guides
			local g = G and G.Get and G.Get(guideId)
			local st = g and g.steps and g.steps[step]
			local notice = { guideId = guideId, step = step, title = st and st.title }
			notices.stepSkip = notice
			if ns.IsLoggedIn() then GF.Layout() end
			ns.After(SKIPPED_SECONDS, function()
				if notices.stepSkip == notice then
					notices.stepSkip = nil
					if F and ns.IsLoggedIn() then GF.Layout() end
				end
			end)
		end)

		-- PLAYER_SKIPPED_QUEST(questID, title): a quest skipped from its line's
		-- menu; the card has moved on, so the banner offers the undo for
		-- SKIPPED_SECONDS (the quest's accept keeps its own Undo).
		ns.On("PLAYER_SKIPPED_QUEST", function(questID, title)
			if not F or type(questID) ~= "number" then return end
			local notice = { quest = questID, title = title }
			notices.questSkip = notice
			if ns.IsLoggedIn() then GF.Layout() end
			ns.After(SKIPPED_SECONDS, function()
				if notices.questSkip == notice then
					notices.questSkip = nil
					if F and ns.IsLoggedIn() then GF.Layout() end
				end
			end)
		end)

		-- TAB_CLOSED(guideId): the player closed a tab; the banner offers to reopen
		-- it for GF.CLOSED_SECONDS.
		ns.On("TAB_CLOSED", function(guideId)
			if not F or type(guideId) ~= "string" then return end
			local G = ns.Guides
			local g = G and G.Get and G.Get(guideId)
			local notice = { guideId = guideId, title = g and g.title or guideId }
			notices.closedTab = notice
			if ns.IsLoggedIn() then GF.Layout() end
			ns.After(GF.CLOSED_SECONDS, function()
				if notices.closedTab == notice then
					notices.closedTab = nil
					if F and ns.IsLoggedIn() then GF.Layout() end
				end
			end)
		end)
	end

	local function trainerPlace(t)
		local zone = t.map and UI.MapName(t.map) or nil
		if t.npcName and zone then return t.npcName .. ", " .. zone end
		return t.npcName or zone
	end

	-- One link-style action in the banner (label, chevron).
	local function placeLink(link, text, x, y)
		link.Label:SetText(text)
		link:SetWidth(floor(link.Label:GetStringWidth() + 16 + 0.5))
		link:ClearAllPoints()
		link:SetPoint("TOPLEFT", banner.Text, "BOTTOMLEFT", x, y)
		link:Show()
		return link:GetWidth()
	end

	-- known, kind, n: the notice GF.Layout just read (bannerNotice), with
	-- nothing run in between; else it is read here.
	function GF.LayoutBanner(width, known, kind, n)
		if not known then kind, n = bannerNotice() end
		banner.psKind = kind
		banner.Jump.psDefault = (kind == "group" or kind == "lost" or kind == "dungeon" or kind == "dungeonRun" or kind == "partyDungeon") or nil -- the gamepad's first focus (UI/GamepadGuide.lua)
		banner.Text:SetWidth(width - PAD * 2 - 21 - 24)
		banner.Later:Hide()
		if kind == "skipped" then
			banner.Icon:SetTexture(Theme.Media("skip"))
			local lines = {}
			for i, k in ipairs(n.skips) do
				lines[i] = string.format(L["Skipped %s"], ns.Quoted(k.title) or "") .. (k.text and ("  \194\183  " .. k.text) or "")
			end
			banner.Text:SetText(table.concat(lines, "\n"))
			banner.Jump:Hide()
			banner.Close:Show()
			local h = floor(9 + banner.Text:GetStringHeight() + 9 + 0.5)
			banner:SetHeight(h)
			return h
		elseif kind == "continued" then
			-- "Durotar complete — continuing with The Barrens", for SKIPPED_SECONDS.
			banner.Icon:SetTexture(Theme.Media("check"))
			banner.Text:SetText(string.format(L["%s complete \226\128\148 continuing with %s"], n.fromTitle, n.toTitle))
			banner.Jump:Hide()
			banner.Close:Show()
			local h = floor(9 + banner.Text:GetStringHeight() + 9 + 0.5)
			banner:SetHeight(h)
			return h
		elseif kind == "dungeonKept" then
			-- After "No group? Skip it": the dungeon's quests stay in the log; their hand-ins pass unless done.
			banner.Icon:SetTexture(Theme.Media("icon-dungeon"))
			local names = {}
			for i, t in ipairs(n.titles) do names[i] = ns.Quoted(t) or t end
			banner.Text:SetText(string.format(L["Kept in your log: %s"], table.concat(names, ", ")) .. "\n"
				.. L["If you run it later, the dungeon's page has a hand-in guide for them."])
			banner.Jump:Hide()
			banner.Close:Show()
			local h = floor(9 + banner.Text:GetStringHeight() + 9 + 0.5)
			banner:SetHeight(h)
			return h
		elseif kind == "dungeonSoon" then
			-- A chosen dungeon's run a few steps ahead (Engine.DungeonSoon): time to find a group.
			banner.Icon:SetTexture(Theme.Media("icon-dungeon"))
			banner.Text:SetText(n.steps == 1 and string.format(L["%s next: start looking for a group."], n.name or "")
				or string.format(L["%s in %d steps: start looking for a group."], n.name or "", n.steps or 0))
			banner.Jump:Hide()
			banner.Close:Show()
			local h = floor(9 + banner.Text:GetStringHeight() + 9 + 0.5)
			banner:SetHeight(h)
			return h
		elseif kind == "closedTab" then
			banner.Icon:SetTexture(Theme.Media("close"))
			banner.Text:SetText(string.format(L["Closed %s"], n.title))
			placeLink(banner.Jump, L["Reopen"], 0, -4)
			banner.Close:Show()
		elseif kind == "questSkip" then
			banner.Icon:SetTexture(Theme.Media("skip"))
			banner.Text:SetText(string.format(L["Skipped %s"], ns.Quoted(n.title) or L["the quest"]) .. "  \194\183  " .. L["and the quests that follow from it"])
			placeLink(banner.Jump, L["Undo"], 0, -4)
			banner.Close:Show()
		elseif kind == "lost" then
			banner.Icon:SetTexture(Theme.Media("icon-accept"))
			banner.Text:SetText(string.format(L["%s is no longer in your quest log."], ns.Quoted(n.title) or L["the quest"]) .. "\n" .. L["The guide stays here until you choose."])
			local w = placeLink(banner.Jump, L["Go back for it"], 0, -4)
			placeLink(banner.Later, L["Skip it and what follows"], w + 10, -4)
			banner.Close:Hide()
		elseif kind == "log" then
			banner.Icon:SetTexture(Theme.Media("icon-accept"))
			local text = string.format(L["Quest log full: this step takes %d, and there is room for %d."], n.take, n.free)
			local names = {}
			for i, d in ipairs(n.drop) do names[i] = ns.Quoted(d.title) or ("#" .. d.quest) end
			if #names > 0 then text = text .. "\n" .. string.format(L["Room to make: %s"], table.concat(names, ", ")) end
			banner.Text:SetText(text)
			placeLink(banner.Jump, L["Make room"], 0, -4)
			banner.Close:Show()
		elseif kind == "group" then
			banner.Icon:SetTexture(Theme.Media("icon-kill"))
			banner.Text:SetText(string.format(L["Group quest: %s"], ns.Quoted(n.title) or "") .. "\n" .. L["It needs a group. Skip it and the guide keeps to the solo route."])
			-- Skip is the default answer: the accent link, the banner's main action.
			local w = placeLink(banner.Jump, L["Skip it"], 0, -4)
			placeLink(banner.Later, L["Do it with a group"], w + 10, -4)
			banner.Close:Hide()
		elseif kind == "dungeon" then
			-- "Ask me": the first step of a dungeon not answered yet holds the route until Run it or Skip it.
			banner.Icon:SetTexture(Theme.Media("icon-dungeon"))
			local text = string.format(L["Dungeon on your way: %s, for a group of five."], n.name or "")
			if n.quests and n.quests > 0 and n.runIn then
				text = text .. "\n" .. (n.quests == 1 and string.format(L["The guide picks up 1 quest for it and runs it in about %d steps."], n.runIn)
					or string.format(L["The guide picks up %d quests for it and runs it in about %d steps."], n.quests, n.runIn))
			end
			banner.Text:SetText(text .. "\n" .. L["Skip it and the guide keeps to the solo route."])
			local w = placeLink(banner.Jump, L["Run it"], 0, -4)
			placeLink(banner.Later, L["Skip it"], w + 10, -4)
			banner.Close:Hide()
		elseif kind == "partyDungeon" then
			-- A party member runs a dungeon this character skips (Party.DungeonOffer): once a session per dungeon.
			banner.Icon:SetTexture(Theme.Media("icon-dungeon"))
			banner.Text:SetText(string.format(L["Your party is running %s: run it with them?"], n.name or "") .. "\n"
				.. L["Not now keeps your route as it is."])
			local w = placeLink(banner.Jump, L["Run it this time"], 0, -4)
			placeLink(banner.Later, L["Not now"], w + 10, -4)
			banner.Close:Hide()
		elseif kind == "dungeonRun" then
			-- At a chosen dungeon's run, outside: no group found, the solo route goes on.
			banner.Icon:SetTexture(Theme.Media("icon-dungeon"))
			banner.Text:SetText(string.format(L["%s: a group of five runs it in about an hour."], n.name or "") .. "\n"
				.. L["No group? Skip it: the guide goes on with the solo route, and its quests stay in your log."])
			placeLink(banner.Jump, L["No group? Skip it"], 0, -4)
			banner.Close:Hide()
		elseif kind == "stepSkip" then
			banner.Icon:SetTexture(Theme.Media("skip"))
			local what = string.format(L["Step %d"], UI.StepNo(n.step))
			if n.title and n.title ~= "" then what = what .. "  \194\183  " .. n.title end
			banner.Text:SetText(string.format(L["Skipped %s"], what))
			placeLink(banner.Jump, L["Undo"], 0, -4)
			banner.Close:Show()
		elseif kind == "away" then
			banner.Icon:SetTexture(Theme.Media(n.skipped and "skip" or (n.live and n.index > n.live and "chevron-right" or "chevron-left")))
			if n.skipped then
				banner.Text:SetText(L["You skipped this step."])
				placeLink(banner.Jump, L["Unskip it"], 0, -4)
			else
				local live = UI.StepNo(n.live)
				banner.Text:SetText(string.format(n.index > n.live and L["Looking ahead. The guide is at step %d."]
					or L["Looking back. The guide is at step %d."], live))
				placeLink(banner.Jump, string.format(L["Back to step %d"], live), 0, -4)
			end
			banner.Close:Show()
		elseif kind == "trip" then
			banner.Icon:SetTexture(Theme.Media("icon-goto"))
			banner.Text:SetText(string.format(L["On the way to %s (%s)."], n.name or "", n.label or ""))
			placeLink(banner.Jump, L["Back to the guide"], 0, -4)
			banner.Close:Hide()
		elseif kind == "ended" then
			-- The end reached with steps still open: the next guide, when the player wants it.
			banner.Icon:SetTexture(Theme.Media("check"))
			banner.Text:SetText(L["You've reached the end of this guide."])
			placeLink(banner.Jump, n.choose and L["Choose where to go next"] or string.format(L["Start %s"], n.label), 0, -4)
			banner.Close:Show()
		elseif kind == "outlevel" then
			banner.Icon:SetTexture(Theme.Media("icon-level"))
			-- Finished quests the route hands in before the guide the jump goes to
			-- (RoutePlan.LeftBehind): said here, and the jump asks once.
			local left = ns.RoutePlan and ns.RoutePlan.LeftBehind(n.to)
			n.left = left and left.n > 0 and left or nil
			local text = L["You have outlevelled this guide."]
			if n.left then
				local what = n.left.n == 1 and L["1 finished quest here first"] or string.format(L["%d finished quests here first"], n.left.n)
				text = text .. "\n" .. (n.left.xp > 0 and string.format(L["%s (%d XP)"], what, n.left.xp) or what)
				if n.asked then text = text .. "\n" .. L["Jump anyway? They stay in your log, and the guide lists who takes each in."] end
			end
			banner.Text:SetText(text)
			-- The suggested guide is one of a route choice: offer the choice.
			local E = Engine()
			n.choiceFrom = n.to and E and E.RouteChoiceFor and E.RouteChoiceFor(n.to) or nil
			placeLink(banner.Jump, (n.left and n.asked) and L["Jump anyway"] or n.choiceFrom and L["Choose where to level next"] or string.format(L["Jump to %s"], n.title or ""), 0, -4)
			banner.Close:Show()
		elseif kind == "train" then
			banner.Icon:SetTexture(Theme.Media("icon-train"))
			local class = UI.PlayerClass and UI.PlayerClass() or nil
			local parts = { string.format(L["Level %d"], n.level or 0),
				class and string.format(L["new %s skills"], class) or L["new class skills"] }
			-- Where to train (Engine.TrainingAdvice, as the level-up spell card
			-- says it): the guide's own stop when it is near, and then no other
			-- trainer; else the planner's pick, live (the notice's when the
			-- engine has none).
			local E = Engine()
			local advice = E and E.TrainingAdvice and E.TrainingAdvice() or {}
			local trainer = not advice.guide and (advice.trainer or n.trainer) or nil
			local place = trainer and trainerPlace(trainer)
			if place then parts[#parts + 1] = place end
			local text = table.concat(parts, "  \194\183  ")
			-- How far the guide's own training stop is, from the live step (#668).
			local steps, title = advice.steps, advice.title
			if steps == false then
				text = text .. "\n" .. L["The guide has no class training ahead."]
			elseif advice.guide and steps <= 1 then
				text = text .. "\n" .. L["Your guide's current step trains you."]
			elseif steps then
				text = text .. "\n" .. string.format(L["The guide trains you in %d steps"], steps)
					.. (title and title ~= "" and (" (" .. title .. ")") or "") .. "."
			end
			banner.Text:SetText(text)
			local w = 0
			if trainer then
				w = placeLink(banner.Jump, L["Show"], 0, -4) + 10
			else
				banner.Jump:Hide()
			end
			placeLink(banner.Later, L["Later"], w, -4)
			banner.Close:Hide()
		elseif kind == "riding" then
			banner.Icon:SetTexture(Theme.Media("icon-mount"))
			local copper = GetMoney and GetMoney() or 0
			-- Affordability from pre-computed cost in the notice (class mounts are free).
			local cost = n.cost or 0
			local canAfford = n.classKind ~= nil or copper >= cost
			local DOT = "  \194\183  "
			local title, body
			if n.classKind == "WARLOCK" then
				title = L["Level 40: class mount (Warlock)"]
				body  = L["Summon Felsteed quest chain (Strahad Farsan, Ratchet); riding trainer otherwise."]
			elseif n.classKind == "PALADIN" then
				title = L["Level 40: class mount (Paladin)"]
				body  = L["Tome of Nobility quest chain (Lord Grayson Shadowbreaker, Stormwind); riding trainer otherwise."]
			else
				title = n.tier == 1 and L["Level 40: you can learn to ride"] or L["Level 60: Journeyman Riding"]
				local tierName = n.tier == 1 and L["Apprentice Riding"] or L["Journeyman Riding"]
				local baseGold = n.tier == 1 and L["100 g"] or L["1,000 g"]
				local bodyParts = { tierName .. DOT .. baseGold }
				-- Discount: always mention; "Honored: Xg" when standing is confirmed.
				local C = ns.Compat
				local standing = n.factionID and C and C.GetFactionStanding and C.GetFactionStanding(n.factionID)
				if standing and standing >= 5 then
					-- Discounted gold: tier 1 = 90 g, tier 2 = 900 g.
					local discountedGold = n.tier == 1 and 90 or 900
					bodyParts[#bodyParts + 1] = string.format(L["Honored: %d g"], discountedGold)
				else
					bodyParts[#bodyParts + 1] = L["10% off at Honored"]
				end
				-- Balance: gold-only to match "100 g" / "1,000 g" style.
				bodyParts[#bodyParts + 1] = string.format(L["You have %d g."], floor(copper / 10000))
				body = table.concat(bodyParts, DOT)
			end
			banner.Text:SetText(title .. "\n" .. body)
			if canAfford then
				placeLink(banner.Jump, L["Take me there"], 0, -4)
			else
				banner.Jump:Hide()
			end
			banner.Later:Hide()
			banner.Close:Show()
		elseif kind == "classQuest" then
			banner.Icon:SetTexture(Theme.Media("icon-train"))
			local title = string.format(L["Class quest ready: %s"], n.title or "")
			local lines = { title }
			if n.heads then lines[#lines + 1] = n.heads end
			if n.why then lines[#lines + 1] = n.why end
			banner.Text:SetText(table.concat(lines, "\n"))
			local w = placeLink(banner.Jump, L["Open in a tab"], 0, -4)
			placeLink(banner.Later, L["Later"], w + 10, -4)
			banner.Close:Show()
		elseif kind == "bags" then
			banner.Icon:SetTexture(Theme.Media("icon-collect"))
			local title = n.free == 0 and L["Your bags are full."]
				or string.format(n.free == 1 and L["Bags nearly full: %d slot left."] or L["Bags nearly full: %d slots left."], n.free)
			local j, Q = n.junk, ns.QoL
			if j then
				local worth = j.value < math.huge and Q.Money(j.value) or "?"
				banner.Text:SetText(title .. "\n" .. string.format(L["Cheapest junk: %s (%s)"], Q.Space.ItemText(j), worth))
				placeLink(banner.Jump, n.armed and L["Click again to delete it"] or L["Delete it"], 0, -4)
			else
				banner.Text:SetText(title .. "\n" .. L["No junk to make room with. Ctrl+Alt-click an item to mark it as junk."])
				banner.Jump:Hide()
			end
			banner.Close:Show()
		elseif kind == "wear" then
			banner.Icon:SetTexture(Theme.Media("icon-use"))
			local G = ns.Gear
			local parts = { string.format(L["Upgrade: %s"], n.link or "") }
			local gain = n.pct and G and G.GainText and G.GainText(n.pct)
			if gain then parts[#parts + 1] = gain end
			local slot = G and G.SlotName and G.SlotName(n.slot)
			if slot then parts[#parts + 1] = slot end
			banner.Text:SetText(table.concat(parts, "  \194\183  "))
			local w = placeLink(banner.Jump, L["Wear it"], 0, -4)
			placeLink(banner.Later, L["Not this one"], w + 10, -4)
			banner.Close:Show()
		elseif kind == "update" then
			banner.Icon:SetTexture(Theme.Media("reset"))
			banner.Text:SetText(UI.UpdateCard.BannerText(n))
			placeLink(banner.Jump, n.kind == "old" and L["How to update"] or L["Update"], 0, -4)
			banner.Close:SetShown(n.closable)
		end
		local h = floor(9 + banner.Text:GetStringHeight() + 4 + 18 + 9 + 0.5)
		banner:SetHeight(h)
		return h
	end

	-- The banner's main action: undo the skip, unskip the step on screen or go
	-- back to the live step, load the suggested guide into the current tab, or
	-- take the player to the trainer (a trip: until they get there).
	function GF.TakeBanner()
		local kind, n = bannerNotice()
		local E = Engine()
		if kind == "trip" then
			ns.Nav.EndTrip()
		elseif kind == "closedTab" then
			notices.closedTab = nil
			if E and E.ReopenClosedTab then E.ReopenClosedTab(n.guideId) end
		elseif kind == "questSkip" then
			notices.questSkip = nil
			if E and E.SkipQuest then E.SkipQuest(n.quest, false) end
		elseif kind == "lost" then
			if E and E.AnswerLost then E.AnswerLost(n.quest, "back") end
		elseif kind == "log" then
			if UI.ShowQuestRoom then UI.ShowQuestRoom() end
		elseif kind == "group" then
			if E and E.AnswerGroup then E.AnswerGroup(n.quest, "skip") end
		elseif kind == "dungeon" then
			if E and E.ChooseDungeon then E.ChooseDungeon(n.map, true) end
		elseif kind == "partyDungeon" then
			-- Run it this time: this dungeon only; "Dungeons in my route" stays.
			if ns.Party and ns.Party.AnswerDungeonOffer then ns.Party.AnswerDungeonOffer(n.map, true) end
		elseif kind == "dungeonRun" then
			-- The quests it keeps in the log are named once, until closed.
			local kept = E and E.SkipDungeon and E.SkipDungeon(n.map)
			if kept and #kept > 0 then notices.dungeonKept = { map = n.map, titles = kept } end
		elseif kind == "stepSkip" then
			notices.stepSkip = nil
			if E and E.Unskip then E.Unskip(n.step) end
		elseif kind == "away" then
			if n.skipped then
				if E and E.Unskip then E.Unskip(n.index) end
			elseif E and E.Goto and n.live then
				E.Goto(n.live)
			end
		elseif kind == "ended" then
			if n.choose then
				UI.ShowRouteChoice(n.guideId)
			elseif E and E.StartNext then
				E.StartNext(n.guideId)
			end
		elseif kind == "outlevel" then
			-- Finished quests the jump would leave behind: the first click asks.
			if n.left and not n.asked then
				n.asked = true
			else
				notices.outlevel = nil
				-- A route choice opens the choice window, which loads the zone picked.
				if not (n.choiceFrom and UI.ShowRouteChoice(n.choiceFrom)) and E and E.SetGuide and n.to then
					E.SetGuide(n.to)
				end
			end
		elseif kind == "train" then
			notices.train = nil
			local advice = E and E.TrainingAdvice and E.TrainingAdvice() or {}
			local t, nav2 = not advice.guide and (advice.trainer or n.trainer) or nil, ns.Nav
			if t and t.map and t.x and nav2 and nav2.SetTarget then
				nav2.StartTrip(nav2.SetTarget(t.map, t.x, t.y, t.npcName or L["Class trainer"], t.f, "trainer", t.z), nil, L["Class trainer"])
			end
		elseif kind == "riding" then
			notices.riding = nil
			local t, nav2 = n.trainer, ns.Nav
			if t and t.map and t.x and nav2 and nav2.SetTarget then
				nav2.StartTrip(nav2.SetTarget(t.map, t.x, t.y, t.npcName or L["Riding trainer"], t.f, "trainer"), nil, L["Riding trainer"])
			end
			local R = ns.QoL and ns.QoL.Riding
			if R and R.OnResolve then R.OnResolve(n.tier) end
		elseif kind == "classQuest" then
			notices.classQuest = nil
			if E and E.OpenTab then E.OpenTab(n.guideId) end
			local CQ = ns.QoL and ns.QoL.ClassQuests
			if CQ and CQ.Resolve then CQ.Resolve(n.guideId) end
		elseif kind == "bags" then
			-- The first click arms the item, the second deletes it.
			ns.QoL.Space.Press()
		elseif kind == "wear" then
			ns.QoL.Wear.Take()
		elseif kind == "update" then
			UI.UpdateCard.Show(true)
		end
		GF.Layout()
	end

	-- The banner's second action: Do it with a group for a group quest, Not
	-- this one for a gear offer (remembered), else Later (dismiss; a Class
	-- guide: until a higher level).
	function GF.LaterBanner()
		local kind, n = bannerNotice()
		local E = Engine()
		if kind == "group" then
			if E and E.AnswerGroup then E.AnswerGroup(n.quest, "do") end
			GF.Layout()
		elseif kind == "dungeon" then
			if E and E.ChooseDungeon then E.ChooseDungeon(n.map, false) end
			GF.Layout()
		elseif kind == "partyDungeon" then
			if ns.Party and ns.Party.AnswerDungeonOffer then ns.Party.AnswerDungeonOffer(n.map, false) end
			GF.Layout()
		elseif kind == "lost" then
			if E and E.AnswerLost then E.AnswerLost(n.quest, "skip") end
			GF.Layout()
		elseif kind == "wear" then
			ns.QoL.Wear.Decline()
			GF.Layout()
		else
			GF.DismissBanner(true)
		end
	end

	-- Dismiss the visible notice (training: until the next due level; a step on
	-- screen that is not the live one: until another step is; a Class guide: for
	-- good, or with `later` (the Later link) until a higher level; the bags:
	-- until they have room again; a gear offer: that copy only).
	function GF.DismissBanner(later)
		local kind, n = bannerNotice()
		if kind == "trip" then
			ns.Nav.EndTrip()
		elseif kind == "away" then
			-- Looking ahead or back: closed for this step (awayNotice), another step has its own
			notices.away = n.guideId .. ":" .. n.index
		elseif kind == "group" or kind == "lost" or kind == "dungeon" or kind == "dungeonRun" or kind == "partyDungeon" then
			-- a group quest, a lost one or a dungeon is answered, never dismissed (the party's dungeon: Not now)
		elseif kind == "dungeonSoon" then
			-- closed for this dungeon's run
			notices.soonSeen = n.map
		elseif kind == "log" then
			notices.logSeen = n.key
		elseif kind == "riding" then
			local R = ns.QoL and ns.QoL.Riding
			if R and R.OnResolve then R.OnResolve(n.tier) end
			notices.riding = nil
		elseif kind == "classQuest" then
			notices.classQuest = nil
			local CQ = ns.QoL and ns.QoL.ClassQuests
			if CQ and CQ.Resolve then CQ.Resolve(n.guideId, later == true) end
		elseif kind == "bags" then
			ns.QoL.Space.Dismiss()
		elseif kind == "wear" then
			ns.QoL.Wear.Dismiss()
		elseif kind == "update" then
			UI.UpdateCard.DismissBanner()
		elseif kind == "ended" then
			notices.endSeen = n.guideId
		elseif kind then
			notices[kind] = nil
		end
		GF.Layout()
	end

	-- More notices the session raises (the live window's).
	if GF.live then
		-- STEP_SKIPPED(fromStep, toStep, skips): the guide moved past quests the
		-- giver does not offer (or no longer can). Says why in the banner until the
		-- step changes again, dismissed, or SKIPPED_SECONDS pass; in chat when the
		-- window is hidden. Fires before STEP_CHANGED, whose render shows it.
		ns.On("STEP_SKIPPED", function(_, to, skips)
			if not F or type(skips) ~= "table" or #skips == 0 then return end
			local E = Engine()
			local g = E and E.GetGuide and E.GetGuide()
			if not g then return end
			local n = { guideId = g.id, to = to, skips = skips }
			notices.skipped = n
			if not F:IsShown() then
				for _, k in ipairs(skips) do
					ns.Print(string.format(L["Skipped %s"], ns.Quoted(k.title) or "") .. (k.text and (": " .. k.text) or ""))
				end
			end
			ns.After(SKIPPED_SECONDS, function()
				if notices.skipped ~= n then return end
				notices.skipped = nil
				if F:IsShown() and ns.IsLoggedIn() then GF.Layout() end
			end)
		end)
		-- GUIDE_OUTLEVELED(guideId, suggestedId): the player has outgrown the guide
		-- in the active tab; offer the suggested one until dismissed or taken.
		ns.On("GUIDE_OUTLEVELED", function(guideId, suggestedId)
			if not F then return end
			local G = ns.Guides
			local target = suggestedId and G and G.Get and G.Get(suggestedId)
			if not target then return end
			notices.outlevel = { guideId = guideId, to = suggestedId, title = target.title or suggestedId }
			if ns.IsLoggedIn() then GF.Layout() end
		end)
		-- GUIDE_CONTINUED(fromId, toId, carried): with "Continue automatically" a
		-- finished leveling guide handed off by itself. Said in the banner for
		-- SKIPPED_SECONDS, in chat while the window is hidden; the quests a later
		-- guide hands in (Engine.CarriedQuests) are said in chat, so they are kept.
		ns.On("GUIDE_CONTINUED", function(fromId, toId, carried)
			local G = ns.Guides
			local from, to = G and G.Get and G.Get(fromId), G and G.Get and G.Get(toId)
			if not (from and to) then return end
			local n = { to = toId, fromTitle = from.title or fromId, toTitle = to.title or toId }
			if not (F and F:IsShown()) then
				ns.Print(string.format(L["%s complete \226\128\148 continuing with %s"], n.fromTitle, n.toTitle))
			end
			if type(carried) == "table" and #carried > 0 then
				local titles = {}
				for i, c in ipairs(carried) do titles[i] = ns.Quoted(c.title) end
				ns.Print(string.format(L["Keep these, a later guide hands them in: %s"], table.concat(titles, ", ")))
			end
			if not F then return end
			notices.continued = n
			if ns.IsLoggedIn() then GF.Layout() end
			ns.After(SKIPPED_SECONDS, function()
				if notices.continued ~= n then return end
				notices.continued = nil
				if F:IsShown() and ns.IsLoggedIn() then GF.Layout() end
			end)
		end)
		-- TRAIN_DUE(level, trainer): new class skills are waiting. A later level's
		-- reminder replaces an older one.
		ns.On("TRAIN_DUE", function(level, trainer)
			if not F then return end
			notices.train = { level = level, trainer = type(trainer) == "table" and trainer or nil }
			if ns.IsLoggedIn() then GF.Layout() end
		end)
		-- RIDING_DUE(notice): player can learn riding; show the banner until resolved.
		ns.On("RIDING_DUE", function(notice)
			if not F then return end
			notices.riding = notice
			if ns.IsLoggedIn() then GF.Layout() end
		end)
		-- CLASS_QUEST_READY(notice): a Class guide this character can start now;
		-- offer it in a tab until taken or dismissed.
		ns.On("CLASS_QUEST_READY", function(notice)
			if not F then return end
			notices.classQuest = notice
			if ns.IsLoggedIn() then GF.Layout() end
		end)
		-- RIDING_MONEY: player's gold changed while a riding banner is pending; re-render
		-- so the "Take me there" button appears/disappears based on affordability.
		ns.On("RIDING_MONEY", function()
			if F and notices.riding and ns.IsLoggedIn() then GF.Layout() end
		end)
		-- CLASS_TRAINED(level): the character visited their class trainer; the
		-- reminder has done its job.
		ns.On("CLASS_TRAINED", function()
			if not F or not notices.train then return end
			notices.train = nil
			if ns.IsLoggedIn() then GF.Layout() end
		end)
		-- A trip (Nav.StartTrip) began or ended: its banner shows or goes.
		ns.On("NAV_TRIP", function()
			if F and ns.IsLoggedIn() then GF.Layout() end
		end)
		-- The bags' free slots or their cheapest junk changed (QoL/Space.lua), or
		-- the gear offer did (QoL/Wear.lua): their banners come, change or go.
		ns.On("BAG_SPACE", function()
			if F and ns.IsLoggedIn() then GF.Layout() end
		end)
		ns.On("WEAR_OFFER", function()
			if F and ns.IsLoggedIn() then GF.Layout() end
		end)
	end

	-- The wheel's last notch settled: the window stays on the step it shows
	-- (a click on the step number).
	function GF.ScrubDone() scrubAt = nil end
end)
