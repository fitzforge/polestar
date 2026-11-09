-- Polestar.Studio: the public door for Polestar Studio (docs/ARCHITECTURE.md, "Polestar Studio's door").
--
-- Polestar Studio, a separate addon, builds a guide in game and plays it in
-- Polestar while it is built: its live draft. The draft is a payload as in
-- a v2 import string, decoded (Core/Import.lua: { format, license, guide,
-- source?, frames? }), and goes through the same shape and checks as an
-- import (Import.Build, Import.Check). It plays under the id
-- `studio/<slug>` (slug: the guide id after the author's handle, so
-- `yendi/cozy-bag` plays as `studio/cozy-bag`), in the pack `studio`
-- (Core/Guides.lua, reserved), which exists only once Studio is enabled, is
-- never stored in PolestarDB.imports, and is never listed under Imported.
-- The entry kept for export and Share keeps the author's own id.
--
--   Studio.Enable()                          -- register the `studio` pack (SetDraft does it too)
--   Studio.SetDraft(payload) -> true | false, { problems }   -- register or replace the draft; never in combat
--   Studio.ClearDraft()                      -- drop the draft; its tab goes absent
--   Studio.PinStep(guideId, stepId) -> bool  -- open the guide and look at the step carrying stepId
--   Studio.Checks(payload) -> { { step = i|nil, goal = j|nil, message } }  -- every problem found
--   Studio.DraftId(guideId) -> "studio/<slug>"  -- the id a guide plays under as a draft
--   Studio.Entry(draftId) -> entry | nil     -- the live draft's entry (a copy, the author's id), for Share

local ADDON, ns = ...
local L = ns.L
local Guides = ns.Guides
local Import = ns.Import

local type, pairs, ipairs, tonumber, tostring = type, pairs, ipairs, tonumber, tostring

local Studio = {}
ns.Studio = Studio

local PACK = "studio"
local current -- the id the live draft plays under
local currentEntry -- its built entry (the author's id)

local function copy(v)
	if type(v) ~= "table" then return v end
	local out = {}
	for k, x in pairs(v) do out[k] = copy(x) end
	return out
end

function Studio.Enable()
	if Guides.Pack(PACK) then return end
	ns.RegisterPack({ id = PACK, draft = true, title = L["Draft (Studio)"] })
end

function Studio.DraftId(id)
	local slug = type(id) == "string" and (id:match("^[^/]+/(.+)$") or id) or ""
	return "studio/" .. (slug:gsub("/", "-"))
end

-- A built entry -> a copy playing under its draft id (its `next` to itself too).
local function live(entry)
	local out = copy(entry)
	local g = out.guide
	if type(g) ~= "table" then return out end
	local own, id = g.id, Studio.DraftId(g.id)
	g.id = id
	if g.next == own then g.next = id end
	for i, t in ipairs(g.nextChoices or {}) do
		if t == own then g.nextChoices[i] = id end
	end
	return out
end

-- payload -> the built entry (the author's id) and its live copy, both
-- passing the import checks as a draft | nil, { problems }
local function checked(payload)
	local entry, reason = Import.Build(payload)
	if not entry then return nil, { reason } end
	local playing = live(entry)
	reason = Import.Check(playing, { draft = true })
	if reason then return nil, { reason } end
	return entry, playing
end

function Studio.SetDraft(payload)
	if InCombatLockdown and InCombatLockdown() then return false, { L["Not in combat."] } end
	Studio.Enable()
	local entry, playing = checked(payload)
	if not entry then return false, playing end
	local id = playing.guide.id
	local frames = Import.NewFrames(playing)
	if frames then ns.RegisterMapFrames({ era = frames }, PACK) end
	local def = copy(playing.guide)
	def.pack = PACK
	def.license = playing.license
	-- Registered again under the same id, the guide is replaced in place
	-- (the engine's PACKS_CHANGED moves its tab to it, at the step looked
	-- at); refused, the last good draft stays.
	local ok, err = ns.RegisterGuide(def)
	if not ok then return false, { (L["Guide %s was refused: %s."]):format(ns.EscapeText(id), ns.EscapeText(tostring(err))) } end
	if current and current ~= id then Guides.DropDraft(current) end
	current, currentEntry = id, entry
	ns.Fire("PACKS_CHANGED", PACK)
	local Engine = ns.Engine
	if Engine and Engine.TabIds and not Engine.TabIds()[id] then Engine.OpenTab(id) end
	return true
end

function Studio.ClearDraft()
	if not current then return end
	Guides.DropDraft(current)
	current, currentEntry = nil, nil
	ns.Fire("PACKS_CHANGED", PACK)
end

-- guideId: any registered guide's id, or the draft's by its author's id.
function Studio.PinStep(guideId, stepId)
	if type(guideId) == "string" and current and not Guides.Get(guideId) and Studio.DraftId(guideId) == current then guideId = current end
	local g = type(guideId) == "string" and Guides.Get(guideId)
	local Engine = ns.Engine
	if not (g and Engine) then return false end
	local at
	for i, step in ipairs(g.steps) do
		if step.id == stepId then
			at = i
			break
		end
	end
	if not at then return false end
	if not Engine.OpenTab(guideId) then return false end
	Engine.Goto(at)
	return true
end

-- A message naming "step N" (and "goal M") -> step, goal.
local function placeOf(message)
	local s, g = message:match("step (%d+) goal (%d+)")
	if s then return tonumber(s), tonumber(g) end
	s = message:match("step (%d+)")
	return s and tonumber(s) or nil, nil
end

function Studio.Checks(payload)
	local out = {}
	local entry, reason = Import.Build(payload)
	if not entry then return { { message = reason } } end
	-- Every goal on its own, so the panel lists each.
	local seen = {}
	for s, step in ipairs(entry.guide.steps or {}) do
		for g, goal in ipairs(step.goals or {}) do
			local err = Guides.CheckGoal(goal)
			if err then
				out[#out + 1] = { step = s, goal = g, message = err }
				seen[s .. ":" .. g] = true
			end
		end
	end
	local playing = live(entry)
	reason = Import.Check(playing, { draft = true })
	if reason then
		local s, g = placeOf(reason)
		if not (s and g and seen[s .. ":" .. g]) then out[#out + 1] = { step = s, goal = g, message = reason } end
	end
	local err = Guides.Validate(copy(playing.guide))
	if err then
		local s, g = placeOf(err)
		-- Import.Check names Validate's reason too ("Guide <id> was refused: <reason>.").
		local named = reason and reason:find(ns.EscapeText(err), 1, true)
		if not (s and g and seen[s .. ":" .. g]) and not named then out[#out + 1] = { step = s, goal = g, message = err } end
	end
	return out
end

function Studio.Entry(draftId)
	if draftId == nil or draftId ~= current then return nil end
	return copy(currentEntry)
end
