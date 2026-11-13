-- Materials: a profession guide's materials, gathered or bought (docs/GUIDE_FORMAT.md, "Materials"). An item a
-- guide both gathers (`collect … gather`) and buys (`auction`) takes one way at a time: the player's pick for it,
-- else the way they chose for the guide (Gather, Buy or Mix; for a guide they never answered, Options' default, Mix
-- while that default is to ask). Mix gathers what the character can (the profession and rank its `gather` names,
-- the levels of the mobs it drops from) and buys the rest. The Engine applies only the goals of the way an item
-- takes (Engine.lua, Own.materialApplies); the windows read the counts and prices here.
--
--   Materials.Way(guide, item, player) -> "gather" | "buy", reason
--   Materials.Mode(guideId[, item]) -> mode ("gather" | "buy" | "mix"), answered, pick ("gather" | "buy" | nil)
--   Materials.Asks(guideId) -> true while the guide's way is still to ask for (no answer, Options' default "ask")
--   Materials.SetMode(guideId, mode), Materials.SetWay(guideId, item, way | nil) -> true | false
--     (MATERIALS_CHANGED, guideId; Gather all and Buy all clear the picks, Mix keeps them)
--   Materials.Have(item) -> total, parts { bags, bank, mail, coming, alts = { { name, count } }, altsCounted }
--   Materials.Stored(item) -> bank, mail, coming: this character's, out of the bags
--   Materials.Nearest("mailbox" | "bank") -> place | nil: where the arrow fetches a material from
--   Materials.Index(guide) -> { [item] = { gather = { { goal, step } }, auction = { ... } } }
--   Materials.Price(item, count) -> copper | nil, info { each, age, source = "search" | "auctionator", short }
--   Materials.NoteSearch(item, rows): rows { { price = unit copper, quantity } } a search the player made showed
--   Materials.Tracked() -> { [item] = true }: the materials counted
--   Materials.OwnCounts() -> { [item] = n } | nil: this character's (bags, bank, mail), for the Characters page
--
-- Reasons: "selfFound" (a Self-Found character has no Auction House), "noBuy" (nothing buys it in this guide),
-- "noGather" (nothing gathers it in this guide), "picked" (the player's pick), "mode" (the guide's way), "skill"
-- (the profession or rank its gather way takes is missing), "low" (its mobs more than Materials.LOW levels above
-- the character), "past" (looted while levelling, cloth or meat, and the character Materials.PAST levels beyond
-- its mobs), "mix" (Mix gathers it).
--
-- Counts: the bags live; the bank live while it is open, else as at the character's last visit (BANKFRAME_OPENED,
-- PLAYERBANKSLOTS_CHANGED, BANKFRAME_CLOSED; before the first, what the client reports); the mail as at the last
-- look at the inbox (MAIL_INBOX_UPDATE; cash-on-delivery mail left out), plus what the character bought at the
-- Auction House since (COMMODITY_PURCHASED, ITEM_PURCHASED: it comes by mail); the account's other characters of
-- this realm and faction from their Characters snapshot (Alts/Snapshot.lua, `mats`), shown always and counted only
-- with professions.altMaterials on (Fitz). The mail and the purchases count every item: Materials.Have is the one
-- count of what the character holds, the auction house buys' too (Quests/AuctionBuys.lua). The bank snapshot holds
-- the materials of the profession guides and of the guides in the tabs (Materials.Tracked), never the whole bank;
-- an item it does not hold reads what the client reports.
--
-- Prices: what the searches made through Polestar's shopping list showed (Materials.NoteSearch), the cheapest
-- listings, so a count is priced for that many, kept per auction house (realm and faction) for PRICE_DAYS; else
-- Auctionator's when it is installed (its public API). Shown with their age; they decide nothing.

local _, ns = ...
local Compat = ns.Compat
local pairs, ipairs, type, next, min, max = pairs, ipairs, type, next, math.min, math.max

local Materials = {}
ns.Materials = Materials

ns.RegisterDefaults("professions", {
	materials = "ask", -- a guide never answered: "ask" (the guide asks; Mix meanwhile) | "mix" | "gather" | "buy"
	altMaterials = false, -- other characters' materials count toward what is still to get
})

local MODES = { gather = true, buy = true, mix = true }
Materials.LOW, Materials.PAST = 2, 5
local PRICE_DAYS = 14
local PRICE_ROWS = 40 -- listings kept per item, cheapest first: enough to price a bracket's cloth
local CALLER = "Polestar" -- the caller id Auctionator's API asks for

---------------------------------------------------------------------------
-- State
---------------------------------------------------------------------------

-- Per character: guides[guideId] = { mode, ways = { [item] = way } }; the bank, mail and coming counts per item;
-- bankSeen once the bank was looked at.
local function state()
	local s = ns.CharState()
	local m = s.materials
	if type(m) ~= "table" then
		m = {}
		s.materials = m
	end
	if type(m.guides) ~= "table" then m.guides = {} end
	if type(m.bank) ~= "table" then m.bank = {} end
	if type(m.mail) ~= "table" then m.mail = {} end
	if type(m.coming) ~= "table" then m.coming = {} end
	return m
end

-- Per account: prices[house][item] = { t = time seen, rows = { { p = unit copper, q = quantity } } }.
local function prices()
	local db = ns.DB()
	if type(db.materials) ~= "table" then db.materials = {} end
	if type(db.materials.prices) ~= "table" then db.materials.prices = {} end
	return db.materials.prices
end

local function refresh()
	local E = ns.Engine
	if E and E.RequestUpdate then E.RequestUpdate() end
end

---------------------------------------------------------------------------
-- The ways
---------------------------------------------------------------------------

-- Per guide's steps (weak: steps a guide releases take theirs along): item -> { gather = { { goal, step } },
-- auction = { ... } }, the steps walked once.
local indexes = setmetatable({}, { __mode = "k" })
function Materials.Index(guide)
	local steps = guide and guide.steps
	if not steps then return {} end
	local ix = indexes[steps]
	if ix then return ix end
	ix = {}
	for _, step in ipairs(steps) do
		for _, goal in ipairs(step.goals) do
			local way = (goal.t == "auction" and "auction") or (goal.t == "collect" and goal.gather and "gather") or nil
			if way and goal.item then
				local e = ix[goal.item]
				if not e then
					e = { gather = {}, auction = {} }
					ix[goal.item] = e
				end
				local list = e[way]
				list[#list + 1] = { goal = goal, step = step }
			end
		end
	end
	indexes[steps] = ix
	return ix
end

-- The first goal of `list` that is this character's (its step's and its own `only`).
local function firstFor(list, player)
	local matches = ns.Guides.Matches
	for _, e in ipairs(list) do
		if matches(e.step.only, player) and matches(e.goal.only, player) then return e.goal end
	end
	return nil
end

function Materials.SelfFound()
	local P = C_PlayerInfo
	if not (P and P.IsSelfFoundActive) then return false end
	local ok, v = pcall(P.IsSelfFoundActive)
	return ok and Compat.Readable(v) == true
end

-- Whether the character can take gather goal g's way now; else false and why ("skill" | "low" | "past").
function Materials.CanGather(g, player)
	local w = type(g.gather) == "table" and g.gather or nil
	if not w then return true end
	if (w.skillLine or w.skill) and Compat.GetSkillRank and Compat.Supports("skill") then
		local rank = Compat.GetSkillRank(w.skillLine or w.skill)
		if (rank or 0) < (w.rank or 1) then return false, "skill" end
	end
	local level = player and player.level or 1
	if w.min and level < w.min - Materials.LOW then return false, "low" end
	-- A bag count with no place (cloth or meat looted while levelling) comes no more once the character is past
	-- its mobs; a farm spot stays one.
	if w.max and level > w.max + Materials.PAST and not g.x and not g.candidates then return false, "past" end
	return true
end

function Materials.Mode(guideId, item)
	local c = guideId and state().guides[guideId]
	local mode = type(c) == "table" and MODES[c.mode] and c.mode or nil
	local answered = mode ~= nil
	if not mode then
		local d = ns.Get("professions.materials")
		mode = MODES[d] and d or "mix"
	end
	local pick = item and answered and type(c.ways) == "table" and c.ways[item] or nil
	return mode, answered, (pick == "gather" or pick == "buy") and pick or nil
end

function Materials.Asks(guideId)
	local _, answered = Materials.Mode(guideId)
	return not answered and ns.Get("professions.materials") == "ask" and not Materials.SelfFound()
end

function Materials.Way(guide, item, player)
	local e = guide and item and Materials.Index(guide)[item]
	if not e then return "gather", "noBuy" end
	if Materials.SelfFound() then return "gather", "selfFound" end
	if not firstFor(e.auction, player) then return "gather", "noBuy" end
	local g = firstFor(e.gather, player)
	if not g then return "buy", "noGather" end
	local mode, _, pick = Materials.Mode(guide.id, item)
	if pick then return pick, "picked" end
	if mode == "buy" then return "buy", "mode" end
	local can, why = Materials.CanGather(g, player)
	if mode == "gather" then
		-- Gather all still buys what takes a profession the character lacks: there is no gathering it.
		if why == "skill" then return "buy", "skill" end
		return "gather", "mode"
	end
	if not can then return "buy", why end
	return "gather", "mix"
end

local function changed(guideId)
	ns.Fire("MATERIALS_CHANGED", guideId)
	local E = ns.Engine
	if E and E.RefreshMaterials then E.RefreshMaterials() end
end

local function choiceFor(guideId)
	local g = state().guides
	local c = g[guideId]
	if type(c) ~= "table" then
		c = {}
		g[guideId] = c
	end
	return c
end

function Materials.SetMode(guideId, mode)
	if not (type(guideId) == "string" and MODES[mode]) then return false end
	local c = choiceFor(guideId)
	c.mode = mode
	if mode ~= "mix" then c.ways = nil end
	changed(guideId)
	return true
end

-- A pick answers the guide too: Mix with that pick when it had no answer or was Gather all or Buy all.
function Materials.SetWay(guideId, item, way)
	if not (type(guideId) == "string" and type(item) == "number") or (way ~= nil and way ~= "gather" and way ~= "buy") then return false end
	local c = choiceFor(guideId)
	c.mode = "mix"
	if way then
		if type(c.ways) ~= "table" then c.ways = {} end
		c.ways[item] = way
	elseif type(c.ways) == "table" then
		c.ways[item] = nil
		if next(c.ways) == nil then c.ways = nil end
	end
	changed(guideId)
	return true
end

-- Options' default for new guides and the other characters' counts change ways and counts in every guide.
ns.On("SETTING_CHANGED", function(path)
	if path == "professions.materials" or path == "professions.altMaterials" or path == "professions" or path == "" then changed(nil) end
end)

---------------------------------------------------------------------------
-- Counts
---------------------------------------------------------------------------

-- The profession guides' materials and those of the guides in the tabs (their steps are in), worked out again when
-- either changes.
local tracked
function Materials.Tracked()
	if tracked then return tracked end
	tracked = {}
	local G, E = ns.Guides, ns.Engine
	local tabs = E and E.TabIds and E.TabIds() or {}
	for _, h in ipairs(G and G.List and G.List() or {}) do
		local def = (h.category == "Professions" or tabs[h.id]) and G.Get(h.id)
		if def and rawget(def, "steps") then
			for item in pairs(Materials.Index(def)) do tracked[item] = true end
		end
	end
	return tracked
end
ns.On("GUIDES_REGISTERED", function() tracked = nil end)
ns.On("TABS_CHANGED", function() tracked = nil end)

local bankOpen = false

local function bagCount(item)
	return Compat.GetItemCount(item) or 0
end

local function liveBank(item)
	return max(0, (Compat.GetItemCount(item, true) or 0) - bagCount(item))
end

-- The bank: live while it is open or before the first visit; else the snapshot, and for an item it does not hold
-- (tracked only since), what the client reports.
local function bankCount(item)
	local s = state()
	if bankOpen or not s.bankSeen then return liveBank(item) end
	local n = s.bank[item]
	if n == nil then return liveBank(item) end
	return n
end

-- The bank as it is now, for every tracked item (0 kept: the snapshot holds the item).
local function takeBank()
	local s = state()
	local bank = {}
	for item in pairs(Materials.Tracked()) do bank[item] = liveBank(item) end
	s.bank, s.bankSeen = bank, true
end

-- The mail as the inbox lists it now, every item, cash on delivery left out; what was bought since the last look
-- is in it.
local function takeMail()
	if not (GetInboxNumItems and GetInboxHeaderInfo and GetInboxItem) then return end
	local mail = {}
	for i = 1, Compat.Readable(GetInboxNumItems()) or 0 do
		local _, _, _, _, _, cod, _, itemCount = GetInboxHeaderInfo(i)
		if (Compat.Readable(cod) or 0) == 0 and (Compat.Readable(itemCount) or 0) > 0 then
			for a = 1, ATTACHMENTS_MAX_RECEIVE or 16 do
				local _, id, _, count = GetInboxItem(i, a)
				id, count = Compat.Readable(id), Compat.Readable(count)
				if id and (count or 0) > 0 then mail[id] = (mail[id] or 0) + count end
			end
		end
	end
	local s = state()
	s.mail, s.coming = mail, {}
end

local function counted()
	refresh()
	ns.Fire("MATERIALS_COUNTS")
end

ns.RegisterEvent("BANKFRAME_OPENED", function()
	bankOpen = true
	takeBank()
	counted()
end)
ns.RegisterEvent("PLAYERBANKSLOTS_CHANGED", function()
	if not bankOpen then return end
	takeBank()
	counted()
end)
ns.RegisterEvent("BANKFRAME_CLOSED", function()
	if bankOpen then takeBank() end
	bankOpen = false
	counted()
end)
ns.RegisterEvent("MAIL_INBOX_UPDATE", function()
	takeMail()
	counted()
end)

-- Bought at the Auction House (any item): on its way by mail until the next look at the inbox.
local function bought(item, quantity)
	item = Compat.Readable(item)
	if type(item) ~= "number" then return end
	local coming = state().coming
	coming[item] = (coming[item] or 0) + max(1, Compat.Readable(quantity) or 1)
	counted()
end
ns.RegisterEvent("COMMODITY_PURCHASED", function(_, item, quantity) bought(item, quantity) end)
ns.RegisterEvent("ITEM_PURCHASED", function(_, item) bought(item, 1) end)

function Materials.Stored(item)
	local s = state()
	return bankCount(item), s.mail[item] or 0, s.coming[item] or 0
end

-- The nearest "mailbox" or "bank" (a banker) for the arrow to fetch a material from (Nav/Nearby.lua): { id, name,
-- map, x, y, f, z } | nil (no navigation module, no such place on the player's side).
function Materials.Nearest(kind)
	local nav = ns.Nav
	local nearby = nav and nav.nearby
	if not (nearby and nearby.Find) then return nil end
	return (nearby.Find(kind))
end

-- The account's other characters of this realm and faction holding `item`: { { name, count } }, most first.
local function altsWith(item)
	local A = ns.Alts
	local out = {}
	if not (A and A.List and A.Enabled and A.Enabled()) then return out end
	local info = Compat.GetPlayerInfo()
	for _, e in ipairs(A.List()) do
		local n = type(e.mats) == "table" and e.mats[item]
		if type(n) == "number" and n > 0 and not A.IsCurrent(e) and e.faction == info.faction and (e.realm == nil or e.realm == info.realm) then
			out[#out + 1] = { name = e.name or e.key, count = n }
		end
	end
	table.sort(out, function(a, b) return a.count > b.count end)
	return out
end

function Materials.Have(item)
	local bank, mail, coming = Materials.Stored(item)
	local parts = { bags = bagCount(item), bank = bank, mail = mail, coming = coming, alts = altsWith(item) }
	local total = parts.bags + bank + mail + coming
	parts.altsCounted = ns.Get("professions.altMaterials") and true or false
	if parts.altsCounted then
		for _, a in ipairs(parts.alts) do total = total + a.count end
	end
	return total, parts
end

function Materials.OwnCounts()
	local out
	for item in pairs(Materials.Tracked()) do
		local bank, mail, coming = Materials.Stored(item)
		local n = bagCount(item) + bank + mail + coming
		if n > 0 then
			out = out or {}
			out[item] = n
		end
	end
	return out
end

---------------------------------------------------------------------------
-- Prices
---------------------------------------------------------------------------

local function house()
	local info = Compat.GetPlayerInfo()
	return (info.realm or "?") .. "-" .. (info.faction or "?")
end

function Materials.NoteSearch(item, rows)
	if type(item) ~= "number" or type(rows) ~= "table" then return end
	local list = {}
	for _, r in ipairs(rows) do
		local p, q = Compat.Readable(r.price), Compat.Readable(r.quantity)
		if type(p) == "number" and p > 0 and type(q) == "number" and q > 0 then list[#list + 1] = { p = p, q = q } end
	end
	table.sort(list, function(a, b) return a.p < b.p end)
	for i = #list, PRICE_ROWS + 1, -1 do list[i] = nil end
	local all = prices()
	local h = house()
	all[h] = all[h] or {}
	all[h][item] = #list > 0 and { t = Compat.Now(), rows = list } or nil
	refresh()
	ns.Fire("MATERIALS_PRICES", item)
end

local function auctionator(item)
	local api = Auctionator and Auctionator.API and Auctionator.API.v1
	if not (api and api.GetAuctionPriceByItemID) then return nil end
	local ok, price = pcall(api.GetAuctionPriceByItemID, CALLER, item)
	if not (ok and type(price) == "number" and price > 0) then return nil end
	local days
	if api.GetAuctionAgeByItemID then
		local okAge, d = pcall(api.GetAuctionAgeByItemID, CALLER, item)
		days = okAge and type(d) == "number" and d or nil
	end
	return price, days
end

function Materials.Price(item, count)
	count = max(1, count or 1)
	local h = prices()[house()]
	local rec = h and h[item]
	local now = Compat.Now()
	if type(rec) == "table" and type(rec.rows) == "table" and rec.rows[1] and now - (rec.t or 0) <= PRICE_DAYS * 86400 then
		local total, left = 0, count
		for _, r in ipairs(rec.rows) do
			local take = min(left, r.q)
			total, left = total + take * r.p, left - take
			if left <= 0 then break end
		end
		return total, { each = rec.rows[1].p, age = now - rec.t, source = "search", short = left > 0 and left or nil }
	end
	local each, days = auctionator(item)
	if each then return each * count, { each = each, age = days and days * 86400 or nil, source = "auctionator" } end
	return nil
end

-- Prices older than PRICE_DAYS are forgotten at login.
ns.OnLogin(function()
	local cutoff = Compat.Now() - PRICE_DAYS * 86400
	for _, items in pairs(prices()) do
		if type(items) == "table" then
			for item, rec in pairs(items) do
				if type(rec) ~= "table" or (rec.t or 0) < cutoff then items[item] = nil end
			end
		end
	end
end)
