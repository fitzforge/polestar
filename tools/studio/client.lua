-- The studio's client, loaded with the client stubs before the addons, on
-- top of the playground (tools/play: wow_stub.lua,
-- stub_world.lua, the preview overlay, driver.lua): the client APIs a
-- scenario's features read that the test stub lacks, answered from
-- STUDIO_DATA (tools/studio/clientdata.js: the Forever client's own spell
-- and item tables), and the helpers scenarios script with.
--
-- Client: C_Spell (name, subtext, texture, info, PickupSpell), GetSpellInfo,
-- the spellbook (C_SpellBook skill lines and items over world.spells), the
-- action bars (HasAction, GetActionInfo, PlaceAction, the cursor), C_Item /
-- GetItemInfo, the bags (C_Container: slots, item info, quest info, item
-- cooldowns), C_UnitAuras.GetPlayerAuraBySpellID, the game's spell and item
-- tooltip lines (GameTooltip:SetSpellByID / SetItemByID / SetHyperlink), and,
-- with a client atlas list, SetAtlas.
--
--   studio.ding(level)            PLAYER_LEVEL_UP, then 3 s of game time
--   studio.learn({ id, ... })     spells into the spellbook (SPELLS_CHANGED)
--   studio.bars({ [slot] = id })  action bar slots holding those spells
--   studio.bag(item, count[, { quest = id, active = bool }])  an item into the next bag slot (BAG_UPDATE_DELAYED)
--   studio.cooldown(item, secondsLeft, duration)              an item's cooldown
--   studio.aura(spell, secondsLeft | true)                    a buff on the player (UNIT_AURA)
--   studio.hover(frame)           the cursor onto a frame (its OnEnter)
--   studio.clearHeadsUps()        the card and the guide window's banners gone
--   studio.cardUntil(kind)        other heads-ups on the card answered (Later) until `kind` shows
--   studio.chat(lines)            the chat window stand-in with the last `lines` chat lines
--   studio.tooltipFrom(tip, owner)  a tooltip a stub keeps as text lines (the Quick Keybind
--                                 one: "kind: text") drawn as the game's tooltip at owner
--   studio.label(text, x, y)      a small caption on the screen (marks a stand-in)

studio = studio or {}

local D = STUDIO_DATA or { spells = {}, items = {} }
local w = stub.world
local M = stub.Methods

---------------------------------------------------------------------------
-- Spells and the spellbook
---------------------------------------------------------------------------

C_Spell = C_Spell or {}
local function S(id) return D.spells[tonumber(id) or -1] end
C_Spell.GetSpellName = function(id) local s = S(id); return s and s.name end
C_Spell.GetSpellTexture = function(id) local s = S(id); return s and s.icon end
C_Spell.GetSpellSubtext = function(id) local s = S(id); return s and s.sub ~= "" and s.sub or nil end
C_Spell.GetSpellInfo = function(id) local s = S(id); return s and { name = s.name, iconID = s.icon, spellID = id } end
C_Spell.RequestLoadSpellData = function() end
GetSpellInfo = function(id) local s = S(id); if s then return s.name, s.sub, s.icon end end
GetSpellTexture = C_Spell.GetSpellTexture
GetSpellSubtext = C_Spell.GetSpellSubtext

local function book()
	local ids = {}
	for id, on in pairs(w.spells) do if on and S(id) then ids[#ids + 1] = id end end
	table.sort(ids)
	return ids
end
C_SpellBook = C_SpellBook or {}
C_SpellBook.GetNumSpellBookSkillLines = function() return 1 end
C_SpellBook.GetSpellBookSkillLineInfo = function(i)
	if i == 1 then return { name = w.className or "", itemIndexOffset = 0, numSpellBookItems = #book() } end
end
C_SpellBook.GetSpellBookItemInfo = function(k)
	local id = book()[k]
	if id then return { spellID = id, itemType = Enum.SpellBookItemType.Spell, name = S(id).name } end
end
Enum.SpellBookSpellBank.Player = 0
Enum.SpellBookItemType.Spell = 1

function studio.learn(ids)
	for _, id in ipairs(ids) do w.spells[id] = true end
	stub.fire("SPELLS_CHANGED")
end

---------------------------------------------------------------------------
-- Action bars and the cursor
---------------------------------------------------------------------------

local bars, cursor = {}, nil
HasAction = function(slot) return bars[slot] ~= nil end
C_ActionBar = C_ActionBar or {}
C_ActionBar.HasAction = HasAction
GetActionInfo = function(slot) local id = bars[slot]; if id then return "spell", id end end
GetCursorInfo = function() if cursor then return "spell", cursor end end
PickupSpell = function(id) cursor = id end
C_Spell.PickupSpell = PickupSpell
ClearCursor = function() cursor = nil end
PlaceAction = function(slot)
	local old = bars[slot]
	bars[slot], cursor = cursor, old
	stub.fire("ACTIONBAR_SLOT_CHANGED", slot)
end

function studio.bars(t)
	for slot, id in pairs(t) do bars[slot] = id end
end

---------------------------------------------------------------------------
-- Items and the bags
---------------------------------------------------------------------------

local function I(id)
	if type(id) == "string" then id = tonumber(id:match("item:(%d+)")) end
	return D.items[tonumber(id) or -1]
end
local QUALITY = {
	[0] = { 0.62, 0.62, 0.62, "ff9d9d9d" }, [1] = { 1, 1, 1, "ffffffff" }, [2] = { 0.12, 1, 0, "ff1eff00" },
	[3] = { 0, 0.44, 0.87, "ff0070dd" }, [4] = { 0.64, 0.21, 0.93, "ffa335ee" }, [5] = { 1, 0.5, 0, "ffff8000" },
}
local function link(i)
	return "|c" .. QUALITY[i.quality][4] .. "|Hitem:" .. i.id .. "::::::::|h[" .. i.name .. "]|h|r"
end
C_Item = C_Item or {}
C_Item.GetItemInfo = function(id)
	local i = I(id)
	if not i then return nil end
	return i.name, link(i), i.quality, i.level, i.minLevel, "", "", 1, "", i.icon, i.sell, i.classID, 0
end
GetItemInfo = C_Item.GetItemInfo
C_Item.GetItemInfoInstant = function(id)
	local i = I(id)
	if i then return i.id, "", "", "", i.icon, i.classID, 0 end
end
GetItemInfoInstant = C_Item.GetItemInfoInstant
C_Item.GetItemIconByID = function(id) local i = I(id); return i and i.icon end
GetItemIcon = C_Item.GetItemIconByID
C_Item.GetItemNameByID = function(id) local i = I(id); return i and i.name end
C_Item.GetItemQualityByID = function(id) local i = I(id); return i and i.quality end
C_Item.IsItemDataCachedByID = function(id) return I(id) ~= nil end
C_Item.RequestLoadItemDataByID = function() end
GetItemQualityColor = function(q) local c = QUALITY[q] or QUALITY[1]; return c[1], c[2], c[3], c[4] end

local bags = {} -- bag -> slot -> { id, count, quest, active }
local cooldowns = {} -- item -> { start, duration }
C_Container = C_Container or {}
C_Container.GetContainerNumSlots = function(bag) return (bag >= 0 and bag <= 4) and 16 or 0 end
C_Container.GetContainerNumFreeSlots = function(bag)
	local n = C_Container.GetContainerNumSlots(bag)
	for _ in pairs(bags[bag] or {}) do n = n - 1 end
	return n, 0
end
C_Container.GetContainerItemInfo = function(bag, slot)
	local e = bags[bag] and bags[bag][slot]
	local i = e and I(e.id)
	if not e then return nil end
	return { itemID = e.id, iconFileID = i and i.icon, stackCount = e.count, quality = i and i.quality or 1,
		hyperlink = i and link(i) or ("item:" .. e.id), isLocked = false, hasNoValue = not (i and i.sell > 0) }
end
C_Container.GetContainerItemID = function(bag, slot) local e = bags[bag] and bags[bag][slot]; return e and e.id end
C_Container.GetContainerItemLink = function(bag, slot)
	local e = bags[bag] and bags[bag][slot]
	local i = e and I(e.id)
	return i and link(i) or nil
end
C_Container.GetContainerItemQuestInfo = function(bag, slot)
	local e = bags[bag] and bags[bag][slot]
	if not e then return { isQuestItem = false } end
	return { isQuestItem = e.quest ~= nil, questID = e.quest, isActive = e.active == true }
end
C_Container.GetItemCooldown = function(id)
	local c = cooldowns[id]
	if not c then return 0, 0, 1 end
	return c.start, c.duration, 1
end
GetItemCooldown = C_Container.GetItemCooldown

function studio.bag(id, count, opts)
	count = count or 1
	for bag = 0, 4 do
		bags[bag] = bags[bag] or {}
		for slot = 1, 16 do
			if not bags[bag][slot] then
				bags[bag][slot] = { id = id, count = count, quest = opts and opts.quest, active = opts and opts.active }
				w.addItem(id, count)
				stub.fire("BAG_UPDATE", bag)
				stub.fire("BAG_UPDATE_DELAYED")
				return bag, slot
			end
		end
	end
end

function studio.cooldown(id, left, duration)
	cooldowns[id] = { start = GetTime() - (duration - left), duration = duration }
	stub.fire("BAG_UPDATE_COOLDOWN")
end

---------------------------------------------------------------------------
-- Auras
---------------------------------------------------------------------------

local auras = {}
C_UnitAuras = C_UnitAuras or {}
C_UnitAuras.GetPlayerAuraBySpellID = function(id)
	local a = auras[id]
	if not a then return nil end
	local s = S(id)
	return { spellId = id, name = s and s.name, icon = s and s.icon, expirationTime = a == true and 0 or a, duration = 0 }
end
function studio.aura(id, left)
	auras[id] = left == true and true or (left and GetTime() + left) or nil
	stub.fire("UNIT_AURA", "player")
end

---------------------------------------------------------------------------
-- The game's tooltips (Forever's spell and item tooltip lines)
---------------------------------------------------------------------------

local QNAME = { [0] = "Poor", "Common", "Uncommon", "Rare", "Epic", "Legendary" }
local function installTips(tt)
	tt.SetSpellByID = function(self, id)
		local s = S(id)
		if not s then return end
		self:ClearLines()
		if s.sub ~= "" then self:AddDoubleLine(s.name, s.sub, 1, 1, 1, 0.5, 0.5, 0.5) else self:AddLine(s.name, 1, 1, 1) end
		if s.cost and s.range then self:AddDoubleLine(s.cost, s.range, 1, 1, 1, 1, 1, 1)
		elseif s.cost or s.range then self:AddLine(s.cost or s.range, 1, 1, 1) end
		if s.cooldown then self:AddDoubleLine(s.cast, s.cooldown, 1, 1, 1, 1, 1, 1) else self:AddLine(s.cast, 1, 1, 1) end
		if s.desc ~= "" then self:AddLine(s.desc, 1, 0.82, 0, true) end
	end
	tt.SetItemByID = function(self, id)
		local i = I(id)
		if not i then return end
		local c = QUALITY[i.quality]
		self:ClearLines()
		self:AddLine(i.name, c[1], c[2], c[3])
		if i.bonding == 1 then self:AddLine("Binds when picked up", 1, 1, 1)
		elseif i.bonding == 4 or i.classID == 12 then self:AddLine("Quest Item", 1, 1, 1) end
		if i.startsQuest > 0 then self:AddLine("This Item Begins a Quest", 1, 1, 1) end
		if i.minLevel > 1 then self:AddLine("Requires Level " .. i.minLevel, 1, 1, 1) end
		if i.desc ~= "" then self:AddLine('"' .. i.desc .. '"', 1, 0.82, 0, true) end
	end
	local setHyperlink = tt.SetHyperlink
	tt.SetHyperlink = function(self, l)
		local id = type(l) == "string" and tonumber(l:match("item:(%d+)"))
		if id and I(id) then return self:SetItemByID(id) end
		local sid = type(l) == "string" and tonumber(l:match("spell:(%d+)"))
		if sid and S(sid) then return self:SetSpellByID(sid) end
		return setHyperlink(self, l)
	end
	tt.SetBagItem = function(self, bag, slot)
		local e = bags[bag] and bags[bag][slot]
		if e then self:SetItemByID(e.id) end
	end
	tt.SetAction = function(self, slot)
		if bars[slot] then self:SetSpellByID(bars[slot]) end
	end
end
installTips(GameTooltip)
studio.installTips = installTips

---------------------------------------------------------------------------
-- Atlases (the art cache's atlas list, the members decoded into it)
---------------------------------------------------------------------------

if STUDIO_ATLAS then
	local A = STUDIO_ATLAS
	C_Texture = C_Texture or {}
	C_Texture.GetAtlasInfo = function(n)
		local a = type(n) == "string" and A[n:lower()]
		if a then return { file = a[1], width = a[2], height = a[3], leftTexCoord = a[4], rightTexCoord = a[5], topTexCoord = a[6], bottomTexCoord = a[7] } end
	end
	local setTexture = M.SetTexture
	M.SetAtlas = function(self, n, useSize)
		local a = type(n) == "string" and A[n:lower()]
		self.atlas = n
		if not a then return false end
		setTexture(self, a[1])
		self.texCoord = { a[4], a[5], a[6], a[7] }
		if useSize then self:SetSize(a[2], a[3]) end
		return true
	end
end

-- Interface files by path (the art cache's file list, the files decoded
-- into it): SetTexture and SetStatusBarTexture draw them by file ID.
if STUDIO_FILES then
	local F = STUDIO_FILES
	local function fileOf(p)
		if type(p) == "string" then
			local fid = F[(p:lower():gsub("/", "\\"):gsub("%.blp$", ""))]
			if fid then return fid end
		end
		return p
	end
	local setTexture, setBar = M.SetTexture, M.SetStatusBarTexture
	M.SetTexture = function(self, p, ...) return setTexture(self, fileOf(p), ...) end
	if setBar then M.SetStatusBarTexture = function(self, p, ...) return setBar(self, fileOf(p), ...) end end
end

---------------------------------------------------------------------------
-- Scenario helpers
---------------------------------------------------------------------------

function studio.ding(level)
	w.setLevel(level)
	stub.advance(3)
end

function studio.hover(f)
	if type(f) == "string" then f = _G[f] end
	if not f then error("studio.hover: no such frame", 2) end
	if play and play.hover and f.id ~= nil then
		play.hover(f.id)
	else
		stub.RunScript(f, "OnEnter")
	end
	stub.advance(0.3)
end

function studio.clearHeadsUps()
	local CT = Polestar.UI.ClassToast
	if CT and CT.current then CT.Hide() end
	local GF = Polestar.UI.GuideFrame
	-- GF.BannerNotice where the checkout has it; else as many dismissals as
	-- there are kinds of banner (one with none on screen only lays out again).
	for _ = 1, 8 do
		if not (GF and GF.DismissBanner) or (GF.BannerNotice and not GF.BannerNotice()) then break end
		GF.DismissBanner()
	end
	stub.advance(1)
end

function studio.cardUntil(kind)
	local CT = Polestar.UI.ClassToast
	for _ = 1, 6 do
		local cur = CT and CT.current
		if not cur or cur.kind == kind then break end
		CT.Hide()
		stub.advance(1)
	end
	return CT and CT.current and CT.current.kind
end

-- The chat window stand-in: the last `lines` chat lines in the game font,
-- bottom left, as ChatFrame1 sits.
local chat
function studio.chat(lines)
	lines = lines or 8
	if not chat then
		chat = CreateFrame("Frame", "StudioChat", UIParent)
		chat:SetSize(430, 180)
		chat:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 32, 210)
		chat:SetFrameStrata("LOW")
		local bg = chat:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints()
		bg:SetColorTexture(0, 0, 0, 0.35)
		chat.text = chat:CreateFontString(nil, "ARTWORK")
		chat.text:SetFont(STANDARD_TEXT_FONT, 14, "")
		chat.text:SetShadowOffset(1, -1)
		chat.text:SetShadowColor(0, 0, 0, 1)
		chat.text:SetPoint("BOTTOMLEFT", chat, "BOTTOMLEFT", 6, 6)
		chat.text:SetWidth(418)
		chat.text:SetJustifyH("LEFT")
		chat.text:SetWordWrap(true)
	end
	local msgs, out = stub.messages or {}, {}
	for i = math.max(1, #msgs - lines + 1), #msgs do out[#out + 1] = msgs[i] end
	chat.text:SetText(table.concat(out, "\n"))
	chat:Show()
end

local COLORS = { highlight = { 1, 1, 1 }, instruction = { 0.1, 1, 0.1 }, error = { 1, 0.125, 0.125 }, normal = { 1, 0.82, 0 } }
function studio.tooltipFrom(src, owner)
	local tip = GameTooltip
	tip:SetOwner(owner, "ANCHOR_RIGHT")
	for i, line in ipairs(src.lines or {}) do
		local kind, text = tostring(line):match("^(%a+): (.*)$")
		local c = COLORS[kind] or { 1, 1, 1 }
		if i == 1 then c = { 1, 1, 1 } end
		tip:AddLine(text or line, c[1], c[2], c[3], true)
	end
	tip:Show()
end

function studio.label(text, x, y)
	local f = CreateFrame("Frame", nil, UIParent)
	f:SetFrameStrata("TOOLTIP")
	f:SetSize(10, 10)
	f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, -y)
	local fs = f:CreateFontString(nil, "OVERLAY")
	fs:SetFont(STANDARD_TEXT_FONT, 12, "")
	fs:SetTextColor(0.75, 0.75, 0.75, 0.9)
	fs:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	fs:SetText(text)
	return f
end
