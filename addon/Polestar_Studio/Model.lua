-- The draft document: header, steps (each with a stable id) and goals, the
-- undo/redo journal and the selection. The only writer of drafts.
--
--   doc = {
--     header = { id = "handle/slug", title, faction = "Alliance|Horde|Both", races = {}, classes = {},
--                minLevel, maxLevel, category, zone, author, version, license, credits = {}, forkedFrom },
--     steps = { { id, title, note, only, goals = { { src = { verb, args, mods, note }, out = <goal> } },
--                 extra = { guide = {...}, source = {...} } } },
--     extra = { guide = {...}, source = {...} },   -- what an opened guide held that Studio does not edit
--     updated = <epoch seconds>,
--   }
--
-- Documents live in PolestarStudioDB.docs[header.id]; PolestarStudioDB.current
-- names the open one. Every mutation goes through the journal (session-long,
-- unbounded) and fires STUDIO_CHANGED(kind).

local ADDON, S = ...
local L = S.L

local Model = {}
S.Model = Model

local type, pairs, ipairs, tostring, tonumber = type, pairs, ipairs, tostring, tonumber
local tinsert, tremove, random, floor = table.insert, table.remove, math.random, math.floor

local undo, redo = {}, {} -- doc id -> { op, ... }
local sel = { i = nil, j = nil }

-- Guide types (header.category) and the category Polestar files them under.
Model.CATEGORIES = { "Leveling", "Dungeon", "Profession", "Collectible", "Chain", "Farm", "Reputation" }
Model.CATEGORY_OUT = {
	Leveling = "Leveling", Dungeon = "Dungeons", Profession = "Professions", Collectible = "Collectibles",
	Chain = "Miscellaneous", Farm = "Miscellaneous", Reputation = "Reputation",
}
Model.CATEGORY_IN = { Dungeons = "Dungeon", Professions = "Profession", Collectibles = "Collectible", Leveling = "Leveling", Reputation = "Reputation" }

local function docs() return S.DB().docs end

local function fire(kind) S.Fire("STUDIO_CHANGED", kind) end

---------------------------------------------------------------------------
-- Ids
---------------------------------------------------------------------------

local ID_CHARS = "abcdefghijklmnopqrstuvwxyz0123456789"

local function randomId()
	local t = {}
	for k = 1, 6 do
		local n = random(1, #ID_CHARS)
		t[k] = ID_CHARS:sub(n, n)
	end
	return table.concat(t)
end

-- A step id of 6 letters/digits no step of doc has.
function Model.NewStepId(doc)
	local used = {}
	for _, s in ipairs(doc and doc.steps or {}) do
		if s.id then used[s.id] = true end
	end
	local id
	repeat id = randomId() until not used[id]
	return id
end

local function validStepId(id)
	return type(id) == "string" and id:match("^[a-z0-9][a-z0-9][a-z0-9][a-z0-9][a-z0-9]?[a-z0-9]?[a-z0-9]?[a-z0-9]?$") ~= nil
end
Model.ValidStepId = validStepId

-- A guide id under handle not used by another draft: handle/slug[-n].
local function freeId(handle, slug, except)
	slug = S.Slug(slug)
	if slug == "" then slug = "guide" end
	local base = (handle or "me") .. "/" .. slug
	local id, n = base, 1
	while docs()[id] and docs()[id] ~= except do
		n = n + 1
		id = base .. "-" .. n
	end
	return id
end
Model.FreeId = freeId

---------------------------------------------------------------------------
-- Access
---------------------------------------------------------------------------

function Model.Doc(id)
	local d = id and docs()[id]
	return type(d) == "table" and d or nil
end

function Model.Current()
	return Model.Doc(S.DB().current)
end

function Model.SetCurrent(id)
	if id ~= nil and not Model.Doc(id) then return false end
	S.DB().current = id
	local doc = Model.Doc(id)
	sel.i = doc and #doc.steps > 0 and 1 or nil
	sel.j = nil
	fire("doc")
	return true
end

function Model.List()
	local out = {}
	for id, d in pairs(docs()) do
		if type(d) == "table" and type(d.header) == "table" then
			out[#out + 1] = { id = id, title = d.header.title or id, steps = #(d.steps or {}), updated = d.updated or 0 }
		end
	end
	table.sort(out, function(a, b)
		if a.updated ~= b.updated then return a.updated > b.updated end
		return a.id < b.id
	end)
	return out
end

function Model.Delete(id)
	if not Model.Doc(id) then return false end
	if S.Backup and S.Backup.Push then S.Backup.Push(docs()[id]) end
	docs()[id] = nil
	undo[id], redo[id] = nil, nil
	if S.DB().current == id then
		S.DB().current = nil
		sel.i, sel.j = nil, nil
	end
	fire("doc")
	return true
end

-- A step's index in the current doc by its id, or nil.
function Model.StepIndex(stepId, doc)
	doc = doc or Model.Current()
	for i, s in ipairs(doc and doc.steps or {}) do
		if s.id == stepId then return i end
	end
	return nil
end

---------------------------------------------------------------------------
-- Selection
---------------------------------------------------------------------------

function Model.Selected()
	local doc = Model.Current()
	if not doc then return nil, nil end
	local i, j = sel.i, sel.j
	if i and not doc.steps[i] then i, j = (#doc.steps > 0 and #doc.steps or nil), nil end
	if i and j and not doc.steps[i].goals[j] then j = nil end
	sel.i, sel.j = i, j
	return i, j
end

function Model.Select(i, j)
	sel.i, sel.j = i, j
	fire("select")
end

---------------------------------------------------------------------------
-- Journal: every mutation is an op applied forward or backward
---------------------------------------------------------------------------

-- Moves a list entry from one index to another.
local function move(list, from, to)
	local v = tremove(list, from)
	tinsert(list, to, v)
end

-- Re-keys doc from one guide id to another in the store.
local function rekey(doc, old, new)
	if old == new then return end
	local d = docs()
	if d[old] == doc then d[old] = nil end
	d[new] = doc
	if S.DB().current == old then S.DB().current = new end
	undo[new], redo[new] = undo[old], redo[old]
	undo[old], redo[old] = nil, nil
end

-- op applied to doc, backward when `back`; -> the change kind.
local function apply(doc, op, back)
	local k = op.op
	if k == "header" then
		local v = back and op.old or op.new
		local prev = doc.header[op.field]
		doc.header[op.field] = v
		if op.field == "id" then rekey(doc, prev, v) end
		return "header"
	elseif k == "step" then
		doc.steps[op.i][op.field] = back and op.old or op.new
		return "step"
	elseif k == "addStep" or k == "removeStep" then
		local insert = (k == "addStep") ~= (back and true or false)
		if insert then tinsert(doc.steps, op.i, op.step) else tremove(doc.steps, op.i) end
		return "step"
	elseif k == "moveStep" then
		if back then move(doc.steps, op.to, op.from) else move(doc.steps, op.from, op.to) end
		return "step"
	elseif k == "addGoal" or k == "removeGoal" then
		local goals = doc.steps[op.i].goals
		local insert = (k == "addGoal") ~= (back and true or false)
		if insert then tinsert(goals, op.j, op.goal) else tremove(goals, op.j) end
		return "goal"
	elseif k == "updateGoal" then
		doc.steps[op.i].goals[op.j] = back and op.old or op.new
		return "goal"
	elseif k == "moveGoal" then
		local goals = doc.steps[op.i].goals
		if back then move(goals, op.to, op.from) else move(goals, op.from, op.to) end
		return "goal"
	end
end

local function journal(id)
	local u = undo[id]
	if not u then
		u = {}
		undo[id] = u
	end
	return u
end

-- Applies op to the current doc, records it, fires the change.
local function commit(doc, op)
	local kind = apply(doc, op, false)
	doc.updated = S.Now()
	local id = doc.header.id
	local u = journal(id)
	u[#u + 1] = op
	redo[id] = nil
	fire(kind)
	return kind
end

function Model.CanUndo()
	local doc = Model.Current()
	local u = doc and undo[doc.header.id]
	return u ~= nil and #u > 0
end

function Model.CanRedo()
	local doc = Model.Current()
	local r = doc and redo[doc.header.id]
	return r ~= nil and #r > 0
end

function Model.Undo()
	local doc = Model.Current()
	if not doc then return false end
	local u = undo[doc.header.id]
	if not (u and #u > 0) then return false end
	local op = tremove(u)
	local kind = apply(doc, op, true)
	-- the id may have changed back: the journal follows the doc
	local id = doc.header.id
	redo[id] = redo[id] or {}
	redo[id][#redo[id] + 1] = op
	doc.updated = S.Now()
	fire(kind)
	return true
end

function Model.Redo()
	local doc = Model.Current()
	if not doc then return false end
	local r = redo[doc.header.id]
	if not (r and #r > 0) then return false end
	local op = tremove(r)
	local kind = apply(doc, op, false)
	local u = journal(doc.header.id)
	u[#u + 1] = op
	doc.updated = S.Now()
	fire(kind)
	return true
end

---------------------------------------------------------------------------
-- Creating and opening
---------------------------------------------------------------------------

local function newStep(doc, title)
	return { id = Model.NewStepId(doc), title = title or "", goals = {} }
end

local function playerLevel()
	local lvl = UnitLevel and S.Readable(UnitLevel("player"))
	return type(lvl) == "number" and lvl > 0 and lvl or 1
end

local function store(doc)
	local id = doc.header.id
	local old = docs()[id]
	if old and old ~= doc and S.Backup and S.Backup.Push then S.Backup.Push(old) end
	docs()[id] = doc
	undo[id], redo[id] = nil, nil
	return doc
end

-- A new draft with one empty step; it becomes the current one.
function Model.New(header)
	header = S.Copy(header or {})
	local handle = S.Handle() or "me"
	local h = {
		title = header.title and S.OneLine(header.title) or L["New guide"],
		faction = header.faction or "Both",
		races = header.races or {},
		classes = header.classes or {},
		minLevel = tonumber(header.minLevel) or playerLevel(),
		category = header.category or "Leveling",
		zone = header.zone,
		author = header.author or handle,
		version = tonumber(header.version) or 1,
		license = header.license or "CC-BY-4.0",
		credits = header.credits or {},
		forkedFrom = header.forkedFrom,
	}
	h.maxLevel = tonumber(header.maxLevel) or h.minLevel
	if h.zone == nil then
		local P = S.P()
		local map = P and P.Compat and P.Compat.GetPlayerMapPosition and P.Compat.GetPlayerMapPosition()
		h.zone = map
	end
	h.id = header.id or freeId(handle, h.title)
	local doc = { header = h, steps = {}, updated = S.Now() }
	doc.steps[1] = newStep(doc, "")
	store(doc)
	Model.SetCurrent(h.id)
	return doc
end

-- Guide keys Studio edits through the header; the rest is kept as it came.
local GUIDE_OWN = {
	id = true, pack = true, title = true, faction = true, races = true, classes = true, minLevel = true, maxLevel = true,
	category = true, zone = true, zoneName = true, author = true, version = true, credits = true, forkedFrom = true,
	steps = true, group = true,
}
local SOURCE_HEADER_OWN = {
	guide = true, title = true, levels = true, zone = true, faction = true, race = true, class = true,
	category = true, author = true, credits = true, ["forked-from"] = true, version = true,
}
local STEP_OWN = { id = true, title = true, note = true, only = true, when = true, goals = true }
local SOURCE_STEP_OWN = { title = true, id = true, only = true, tip = true, when = true, goals = true }

local function extraOf(t, own)
	local out
	for k, v in pairs(t or {}) do
		if not own[k] then
			out = out or {}
			out[k] = S.Copy(v)
		end
	end
	return out
end

-- Pairs a step's source goals with its compiled goals: by index when they
-- match one to one, else in order by verb (the compiler leaves out an
-- `area` with no spawns to shade).
local function pairGoals(srcGoals, outGoals)
	local out = {}
	if #srcGoals == #outGoals then
		for j = 1, #srcGoals do out[j] = { src = S.Copy(srcGoals[j]), out = S.Copy(outGoals[j]) } end
		return out
	end
	local k = 1
	for j = 1, #srcGoals do
		local src = srcGoals[j]
		local o = outGoals[k]
		if o and o.t == src.verb then
			out[j] = { src = S.Copy(src), out = S.Copy(o) }
			k = k + 1
		else
			out[j] = { src = S.Copy(src) }
		end
	end
	return out
end

-- payload ({ format, license, guide, source }) -> doc (not stored) | nil, reason
local function fromPayload(payload)
	if type(payload) ~= "table" or type(payload.guide) ~= "table" then return nil, L["This string holds no guide."] end
	local g, src = payload.guide, payload.source
	if type(src) ~= "table" or type(src.steps) ~= "table" then
		return nil, L["Read only: this guide carries no source. Ask its author for a Studio string."]
	end
	local h = {
		id = g.id, title = g.title, faction = g.faction or "Both", races = S.Copy(g.races or {}), classes = S.Copy(g.classes or {}),
		minLevel = g.minLevel, maxLevel = g.maxLevel, category = Model.CATEGORY_IN[g.category] or g.category or "Leveling",
		zone = g.zone, author = g.author, version = tonumber(g.version) or 1, license = payload.license or "CC-BY-4.0",
		credits = S.Copy(g.credits or {}), forkedFrom = S.Copy(g.forkedFrom),
	}
	if h.zone == nil and type(src.header) == "table" and type(src.header.zone) == "string" then
		h.zone = tonumber(src.header.zone:match("^map%s+(%d+)$")) or src.header.zone
	end
	local doc = { header = h, steps = {}, updated = S.Now() }
	local ge, se = extraOf(g, GUIDE_OWN), extraOf(src.header, SOURCE_HEADER_OWN)
	-- `next` is Studio's to edit unless options carry conditions (kept as they came)
	if g.nextWhen == nil and type(g.next) == "string" then
		h.next = S.Copy(g.nextChoices or { g.next })
		if ge then ge.next, ge.nextChoices = nil, nil end
		if se then se.next = nil end
		if ge and next(ge) == nil then ge = nil end
		if se and next(se) == nil then se = nil end
	end
	if ge or se then doc.extra = { guide = ge, source = se } end
	local used = {}
	for i, gs in ipairs(g.steps or {}) do
		local ss = src.steps[i] or { goals = {} }
		local id = gs.id or ss.id
		if not validStepId(id) or used[id] then id = nil end
		local step = {
			id = id, title = gs.title or ss.title or "", note = gs.note, only = S.Copy(gs.only),
			when = type(ss.when) == "table" and S.Copy(ss.when) or nil,
			goals = pairGoals(ss.goals or {}, gs.goals or {}),
		}
		local sge, sse = extraOf(gs, STEP_OWN), extraOf(ss, SOURCE_STEP_OWN)
		if sge or sse then step.extra = { guide = sge, source = sse } end
		doc.steps[i] = step
		if id then used[id] = true end
	end
	for _, step in ipairs(doc.steps) do
		if not step.id then
			step.id = Model.NewStepId(doc)
		end
	end
	return doc
end

-- A v2 payload opened as a draft (replacing a draft with the same id,
-- which goes to the backups first); it becomes the current one.
function Model.Open(payload)
	local doc, reason = fromPayload(payload)
	if not doc then return nil, reason end
	if type(doc.header.id) ~= "string" or doc.header.id == "" then return nil, L["This string holds no guide."] end
	store(doc)
	Model.SetCurrent(doc.header.id)
	return doc
end

-- Whether a licence lets others build on the work (no NoDerivatives).
function Model.AllowsDerivatives(license)
	if type(license) ~= "string" then return true end
	local l = license:upper()
	return not (l:find("%-ND") or l:find("ND%-") or l:find("NODERIV"))
end

-- A payload forked under handle: a new id, forkedFrom and credits kept.
function Model.Fork(payload, handle)
	if type(payload) ~= "table" then return nil, L["This string holds no guide."] end
	if not Model.AllowsDerivatives(payload.license) then
		return nil, (L["Its licence (%s) does not allow changed copies, so it cannot be forked."]):format(tostring(payload.license))
	end
	local doc, reason = fromPayload(payload)
	if not doc then return nil, reason end
	handle = S.Slug(handle or S.Handle() or "")
	if #handle < 2 then return nil, L["Set your handle first: it starts the ids of your guides."] end
	local h = doc.header
	local origId, origVersion, origAuthor = h.id, h.version, h.author
	local slug = type(origId) == "string" and (origId:match("/([^/]+)$") or origId) or h.title
	h.id = freeId(handle, slug)
	h.forkedFrom = type(origId) == "string" and { id = origId, version = tonumber(origVersion) or 1 } or nil
	h.credits = h.credits or {}
	if type(origAuthor) == "string" and origAuthor ~= "" and origAuthor ~= handle then
		local seen = false
		for _, c in ipairs(h.credits) do
			if c == origAuthor then seen = true end
		end
		if not seen and #h.credits < 32 then h.credits[#h.credits + 1] = origAuthor end
	end
	h.author = handle
	h.version = 1
	store(doc)
	Model.SetCurrent(h.id)
	return doc
end

---------------------------------------------------------------------------
-- Mutations
---------------------------------------------------------------------------

local function same(a, b)
	if a == b then return true end
	if type(a) ~= "table" or type(b) ~= "table" then return false end
	for k, v in pairs(a) do
		if not same(v, b[k]) then return false end
	end
	for k in pairs(b) do
		if a[k] == nil then return false end
	end
	return true
end

function Model.SetHeader(field, value)
	local doc = Model.Current()
	if not doc then return false end
	if field == "id" then
		if type(value) ~= "string" or not value:match("^[a-z0-9][a-z0-9%-]*/[a-z0-9][a-z0-9%-]*$") then
			return false, L["A guide id is your handle, a slash and a name: yendi/cozy-bag."]
		end
		if docs()[value] and docs()[value] ~= doc then return false, L["Another draft has that id."] end
	end
	if same(doc.header[field], value) then return true end
	commit(doc, { op = "header", field = field, old = S.Copy(doc.header[field]), new = S.Copy(value) })
	return true
end

-- The step to add to: i when given, else the selected one, else the last;
-- a doc without steps gets one.
local function stepFor(doc, i)
	if i and doc.steps[i] then return i end
	local si = Model.Selected()
	if si then return si end
	if #doc.steps == 0 then return Model.AddStep("") end
	return #doc.steps
end

function Model.AddStep(title, at)
	local doc = Model.Current()
	if not doc then return nil end
	local n = #doc.steps
	if at == nil then
		local si = Model.Selected()
		at = si and si + 1 or n + 1
	end
	if at < 1 then at = 1 end
	if at > n + 1 then at = n + 1 end
	commit(doc, { op = "addStep", i = at, step = newStep(doc, title and S.OneLine(title) or "") })
	sel.i, sel.j = at, nil
	fire("select")
	return at
end

function Model.SetStep(i, field, value)
	local doc = Model.Current()
	local step = doc and doc.steps[i]
	if not step or field == "goals" then return false end
	if field == "id" then
		if not validStepId(value) then return false, L["A step id is 4 to 8 lower-case letters or digits."] end
		for k, s in ipairs(doc.steps) do
			if k ~= i and s.id == value then return false, L["Another step has that id."] end
		end
	end
	if same(step[field], value) then return true end
	commit(doc, { op = "step", i = i, field = field, old = S.Copy(step[field]), new = S.Copy(value) })
	return true
end

function Model.RemoveStep(i)
	local doc = Model.Current()
	local step = doc and doc.steps[i]
	if not step then return false end
	commit(doc, { op = "removeStep", i = i, step = step })
	return true
end

function Model.MoveStep(from, to)
	local doc = Model.Current()
	if not (doc and doc.steps[from]) then return false end
	if to < 1 then to = 1 end
	if to > #doc.steps then to = #doc.steps end
	if from == to then return true end
	commit(doc, { op = "moveStep", from = from, to = to })
	if sel.i == from then sel.i = to end
	return true
end

-- -> i, j of the new goal (it becomes the selection)
function Model.AddGoal(i, src, out, at)
	local doc = Model.Current()
	if not doc or type(src) ~= "table" then return nil end
	i = stepFor(doc, i)
	local goals = doc.steps[i].goals
	local n = #goals
	if at == nil or at > n + 1 then at = n + 1 end
	if at < 1 then at = 1 end
	commit(doc, { op = "addGoal", i = i, j = at, goal = { src = src, out = out } })
	sel.i, sel.j = i, at
	fire("select")
	return at, i
end

function Model.UpdateGoal(i, j, src, out)
	local doc = Model.Current()
	local step = doc and doc.steps[i]
	local old = step and step.goals[j]
	if not old then return false end
	commit(doc, { op = "updateGoal", i = i, j = j, old = old, new = { src = src or old.src, out = out } })
	return true
end

function Model.RemoveGoal(i, j)
	local doc = Model.Current()
	local step = doc and doc.steps[i]
	local goal = step and step.goals[j]
	if not goal then return false end
	commit(doc, { op = "removeGoal", i = i, j = j, goal = goal })
	return true
end

function Model.MoveGoal(i, from, to)
	local doc = Model.Current()
	local step = doc and doc.steps[i]
	if not (step and step.goals[from]) then return false end
	if to < 1 then to = 1 end
	if to > #step.goals then to = #step.goals end
	if from == to then return true end
	commit(doc, { op = "moveGoal", i = i, from = from, to = to })
	if sel.i == i and sel.j == from then sel.j = to end
	return true
end

---------------------------------------------------------------------------
-- Payload
---------------------------------------------------------------------------

-- doc -> { format = 10, license, guide = <compiled>, source = <tree>, frames? },
-- map ({ [payload step] = { step = doc step, goals = { [payload goal] = doc goal } } }).
-- Steps without a resolved goal and goals without a compiled form stay out
-- of both trees, so they pair one to one (Checks reports them).
function Model.ToPayload(doc)
	doc = doc or Model.Current()
	if not doc then return nil end
	return S.Serialize.Payload(doc)
end

-- Seeds the step-id random source once per session.
if math.randomseed then math.randomseed(floor((GetTime and GetTime() or 0) * 1000) % 2147483647) end
