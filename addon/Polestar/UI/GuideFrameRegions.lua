-- The guide window's kind regions (docs/ARCHITECTURE.md, "Guide kinds"): a
-- guide kind with regions (Core/Guides.lua, GuideKinds) shows them where the
-- card's header and goal rows sit, in order, after the banner and before
-- Then:, Up next and the foot. A kind without regions (leveling, class,
-- collectible, exploration, misc) keeps the card as it is.
--
--   GF.REGIONS[kind] = { id, ... }        the kind's regions, in order
--   GF.RegionOverride(view, kind) -> { id, ... } | nil
--       set by a part that takes the card for any kind (the docked dungeon
--       tracker inside its instance); nil leaves the kind's own
--   GF.RegionsFor(view, kind) -> { id, ... } | nil
--   GF.RegisterRegion(id, {
--     build  = function(parent) -> frame,          once per window (live, settings copy)
--     model  = function(view, kind) -> model | nil, nil: the region and its height are left out
--     paint  = function(frame, model, mode),      optional: text and colours, on a render only
--     layout = function(frame, model, width, mode) -> height,  measures and anchors only
--   })                                             mode "standard" | "compact"
--
-- A model may name the step's goals it stands for (`covers`: their indexes,
-- as a list or a set): their rows leave the card. With every open goal of
-- the step covered, the step's header goes too. Models come from
-- Engine.KindModel(id, view, kind) (pure data: the tests and the preview read
-- the same); a region's frame is a part in Theme.GuideParts() by its id and is
-- offered to the layout's guidePlace hook by its id (true: the layout places
-- it, Atlas's cards).

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local max = math.max

	GF.REGIONS = {
		profession = { "meter", "trainer", "stretch", "supplies", "buyList" },
		reputation = { "meter", "turnin", "supplies", "more" },
		dungeon = { "brief", "ready", "pickups", "entrance" },
	}

	function GF.RegionsFor(view, kind)
		return (GF.RegionOverride and GF.RegionOverride(view, kind)) or GF.REGIONS[kind]
	end

	local defs = {}
	function GF.RegisterRegion(id, def)
		if type(id) ~= "string" or type(def) ~= "table" or type(def.build) ~= "function" or type(def.model) ~= "function"
			or type(def.layout) ~= "function" then
			error("GF.RegisterRegion: id and { build, model, layout } expected", 2)
		end
		defs[id] = def
	end

	local card
	GF.Bind(function(p) card = p.card end)

	-- This window's region frames, built on first use; the regions the step
	-- shows now, in order: { { id, def, frame, model } }; the goals they cover.
	local frames, active = {}, { n = 0 }
	local covered, coveredView = {}, nil

	local function frameOf(id, def)
		local f = frames[id]
		if f then return f end
		f = def.build(card)
		f.psRegion = id
		frames[id] = f
		local parts = GF.SkinParts and GF.SkinParts()
		if parts and parts[id] == nil then parts[id] = f end
		return f
	end

	local function mode() return GF.Compact() and "compact" or "standard" end

	local function cover(model)
		local c = type(model) == "table" and model.covers
		if type(c) ~= "table" then return end
		for k, v in pairs(c) do
			if type(k) == "number" and v == true then covered[k] = true end
			if type(v) == "number" then covered[v] = true end
		end
	end

	-- Works out the regions for `view` (the step on the card) and paints them;
	-- every other region frame hides. A guide kind without regions allocates
	-- nothing here (it runs on every render). -> true when some region shows
	local EMPTY = {}
	function GF.FillRegions(view)
		local E = GF.Engine()
		local kind = E and E.GuideKind and E.GuideKind() or "leveling"
		local list = view and GF.RegionsFor(view, kind) or EMPTY
		if next(covered) then wipe(covered) end
		coveredView = view
		local hadMeter = GF.RegionShown("meter")
		active.n = 0
		local n, m = 0, mode()
		for _, id in ipairs(list) do
			local def = defs[id]
			local model = def and def.model(view, kind)
			if model ~= nil then
				local f = frameOf(id, def)
				n = n + 1
				local a = active[n] or {}
				active[n] = a
				a.id, a.def, a.frame, a.model = id, def, f, model
				-- A later region may read an earlier one's model as it paints (GF.RegionModel).
				active.n = n
				cover(model)
				if def.paint then def.paint(f, model, m) end
			end
		end
		for i = n + 1, #active do active[i] = nil end
		active.n = n
		-- The XP row leaves the skill out while the meter shows (UI/GuideFrameStatus.lua).
		if hadMeter ~= GF.RegionShown("meter") and GF.UpdateXP then GF.UpdateXP() end
		for id, f in pairs(frames) do
			if not GF.RegionShown(id) then f:Hide() end
		end
		return n > 0
	end

	-- Whether goal `index` of `view` stands in a region (its row leaves the card).
	function GF.RegionCovers(view, index)
		return view ~= nil and view == coveredView and covered[index] == true
	end

	-- Whether region `id` shows now; its model.
	function GF.RegionShown(id)
		for i = 1, active.n do
			if active[i].id == id then return true end
		end
		return false
	end
	function GF.RegionModel(id)
		for i = 1, active.n do
			if active[i].id == id then return active[i].model end
		end
		return nil
	end
	function GF.RegionFrame(id) return frames[id] end
	function GF.RegionsActive() return active.n > 0 end

	-- Lays the regions out in the card from y down, `width` wide (GF.Layout's
	-- layoutCard). A region the layout places itself (guidePlace by its id) takes
	-- no room here. -> y under the last region
	function GF.LayoutRegions(width, y)
		local m = mode()
		for i = 1, active.n do
			local a = active[i]
			local f = a.frame
			local h = a.def.layout(f, a.model, width, m) or 0
			if h > 0 then
				f:SetHeight(h)
				f:Show()
				if not GF.Claimed(a.id, f, width, h) then
					f:ClearAllPoints()
					f:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -y)
					f:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, -y)
					y = y + h
				end
			else
				f:Hide()
			end
		end
		return max(0, y)
	end

	-- The shown regions in the card, for GF.Placed: { id, frame } in order.
	function GF.PlacedRegions()
		local out = {}
		for i = 1, active.n do
			local f = active[i].frame
			if f:IsShown() and f:GetParent() == card then out[#out + 1] = { active[i].id, f } end
		end
		return out
	end
end)
