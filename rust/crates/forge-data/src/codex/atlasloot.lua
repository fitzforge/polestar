
local AL_VERSION = 1
local function nameOf(prefix, id) return "{" .. prefix .. ":" .. tostring(id) .. "}" end
local function locale() return setmetatable({}, { __index = function(_, k) return k end }) end
POLESTAR_band = function(a, b)
  local r, bitv = 0, 1
  a, b = math.floor(a or 0), math.floor(b or 0)
  while a > 0 and b > 0 do
    if a % 2 == 1 and b % 2 == 1 then r = r + bitv end
    a, b, bitv = math.floor(a / 2), math.floor(b / 2), bitv * 2
  end
  return r
end
POLESTAR_AL = { stores = {}, order = {}, droprates = {} }
local Store = {}
function Store:AddDifficulty(dif, uniqueName)
  local meta = rawget(self, "__al")
  local key = tostring(uniqueName or dif)
  if not meta.diffIndex[key] then
    meta.diffs[#meta.diffs + 1] = { name = tostring(dif), unique = uniqueName and tostring(uniqueName) or nil }
    meta.diffIndex[key] = #meta.diffs
  end
  return meta.diffIndex[key]
end
function Store:AddContentType(typ)
  local meta = rawget(self, "__al")
  local key = tostring(typ)
  if not meta.ctypeIndex[key] then
    meta.ctypes[#meta.ctypes + 1] = key
    meta.ctypeIndex[key] = #meta.ctypes
  end
  return meta.ctypeIndex[key]
end
function Store:AddItemTableType(typ)
  local meta = rawget(self, "__al")
  meta.ttypes[#meta.ttypes + 1] = tostring(typ)
  return #meta.ttypes
end
function Store:AddExtraItemTableType(typ)
  local meta = rawget(self, "__al")
  for i, v in ipairs(meta.extras) do if v == typ then return i + 100 end end
  meta.extras[#meta.extras + 1] = tostring(typ)
  return #meta.extras + 100
end
local storeMt = {
  __index = Store,
  __newindex = function(t, k, v)
    local meta = rawget(t, "__al")
    if rawget(t, k) == nil then meta.order[#meta.order + 1] = k end
    rawset(t, k, v)
  end,
}
local Droprate = {}
function Droprate:AddData(d)
  if type(d) ~= "table" then return end
  for npc, items in pairs(d) do POLESTAR_AL.droprates[npc] = items end
end
function Droprate:GetData(npc, item) local d = POLESTAR_AL.droprates[npc] return d and d[item] end
local ContentPhase = {}
function ContentPhase:GetActivePhase() return 6 end
function ContentPhase:IsActive() return true end
function ContentPhase:GetForItemID() return nil end
function ContentPhase:GetPhaseTexture() return "" end
function ContentPhase:GetPhaseTextureForItemID() return "" end
AtlasLoot = {
  RETAIL_VERSION_NUM = 99, CLASSIC_VERSION_NUM = 1, BC_VERSION_NUM = 2, WRATH_VERSION_NUM = 3,
  CURRENT_VERSION_NUM = AL_VERSION, IS_CLASSIC = true, IS_BC = false, IS_WRATH = false, IS_RETAIL = false,
  Locales = locale(), IngameLocales = locale(),
  Data = {
    Droprate = Droprate,
    ContentPhase = ContentPhase,
    Requirements = { GetPvPRankName = function() return "" end, GetPvPRankIcon = function() return 0 end },
    Profession = { GetColorSkillRankNoSpell = function() return "" end },
  },
  ItemDB = {},
}
function AtlasLoot.ItemDB:Add(addonName)
  local name = tostring(addonName)
  if not POLESTAR_AL.stores[name] then
    local store = { __al = { order = {}, diffs = {}, diffIndex = {}, ctypes = {}, ctypeIndex = {}, ttypes = {}, extras = {} } }
    POLESTAR_AL.stores[name] = setmetatable(store, storeMt)
    POLESTAR_AL.order[#POLESTAR_AL.order + 1] = name
  end
  return POLESTAR_AL.stores[name]
end
function AtlasLoot.ReturnForGameVersion(classic) return classic end
function AtlasLoot:GetGameVersion() return AL_VERSION end
function AtlasLoot:GameVersion_EQ(v, r, f) if AL_VERSION == v then return r or true end return f end
function AtlasLoot:GameVersion_NE(v, r, f) if AL_VERSION ~= v then return r or true end return f end
function AtlasLoot:GameVersion_GT(v, r, f) if AL_VERSION > v then return r or true end return f end
function AtlasLoot:GameVersion_LT(v, r, f) if AL_VERSION < v then return r or true end return f end
function AtlasLoot:GameVersion_GE(v, r, f) if AL_VERSION >= v then return r or true end return f end
function AtlasLoot:GameVersion_LE(v, r, f) if AL_VERSION <= v then return r or true end return f end
function AtlasLoot:GetRetByFaction(horde, alliance) return alliance end
function AtlasLoot:AddInitFunc() end
function AtlasLoot:GetGameVersionDataTable()
  local use = {}
  local data = setmetatable({}, { __newindex = function(_, _, v) for k, x in pairs(v) do use[k] = x end end })
  return use, data
end
POLESTAR_NS.IS_CLASSIC = true
ATLASLOOT_IT_FILTERIGNORE, ATLASLOOT_IT_HORDE, ATLASLOOT_IT_ALLIANCE, ATLASLOOT_IT_AMOUNT1, ATLASLOOT_IT_AMOUNT2 = 900, 901, 902, 903, 904
for _, k in ipairs({ "COLLECTION", "DUNGEON", "FACTION", "PERMRECEVENTS", "PRIMPROFESSION", "PVP", "RAID", "RAID40", "RAID20",
  "REMOVED", "SEASONALEVENTS", "SECPROFESSION", "WORLD_BOSS", "COLLECTIONS", "CLASSPROFESSION", "UNKNOWN", "HORDE", "ALLIANCE" }) do
  _G["ATLASLOOT_" .. k .. "_COLOR"] = { 0, 0, 0, 1 }
end
FACTION_HORDE, FACTION_ALLIANCE, GENERAL, UNKNOWN = "Horde", "Alliance", "General", "Unknown"
for i = 1, 8 do _G["FACTION_STANDING_LABEL" .. i] = ({ "Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted" })[i] end
RAID_CLASS_COLORS = setmetatable({}, { __index = function() return { colorStr = "ffffffff", r = 1, g = 1, b = 1 } end })
WOW_PROJECT_ID, WOW_PROJECT_CLASSIC, WOW_PROJECT_MAINLINE = 2, 2, 1
function UnitFactionGroup() return "Alliance", "Alliance" end
function GetFactionInfoByID(id) return nameOf("faction", id) end
function CreateFrame() return POLESTAR_STUB end
function hooksecurefunc() end
C_Map = { GetAreaInfo = function(id) return nameOf("area", id) end }
C_Spell = { GetSpellTexture = function() return 0 end, GetSpellName = function(id) return nameOf("spell", id) end }
C_Reputation = { GetFactionDataByID = function() return nil end }

-- Dump: plain tables only, numbers as numbers, ids as string keys.
local function sortedNumKeys(t)
  local keys = {}
  for k, v in pairs(t) do if type(k) == "number" and type(v) == "table" then keys[#keys + 1] = k end end
  table.sort(keys)
  return keys
end
local function plainIds(v)
  if type(v) == "number" then return { v } end
  if type(v) ~= "table" then return nil end
  local out = {}
  for k, x in pairs(v) do if type(x) == "number" then out[#out + 1] = x end end
  table.sort(out)
  return #out > 0 and out or nil
end
local function scalar(v) local t = type(v) if t == "number" or t == "string" or t == "boolean" then return v end return nil end
local function dumpRows(dif, extras)
  local rows = {}
  for _, pos in ipairs(sortedNumKeys(dif)) do
    local r = dif[pos]
    local row = { p = scalar(r[1]), c2 = scalar(r[2]), c3 = scalar(r[3]), h = scalar(r[901]), a = scalar(r[902]) }
    for i, name in ipairs(extras) do
      if r[i + 100] ~= nil then row[name] = scalar(r[i + 100]) end
    end
    rows[#rows + 1] = row
  end
  return rows
end
local function dumpBoss(boss, extras)
  local out = {
    name = scalar(boss.name), npc = plainIds(boss.npcID), object = plainIds(boss.ObjectID),
    phase = scalar(boss.ContentPhase), ignore = boss.IgnoreAsSource and true or nil, extra = boss.ExtraList and true or nil,
    tt = scalar(boss.TableType), diffs = {},
  }
  for _, d in ipairs(sortedNumKeys(boss)) do
    local dif = boss[d]
    out.diffs[#out.diffs + 1] = { d = d, tt = scalar(dif.TableType), from = scalar(dif.GetItemsFromDiff), rows = dumpRows(dif, extras) }
  end
  return out
end
function POLESTAR_dumpStore(name)
  local store = POLESTAR_AL.stores[name]
  if not store then return nil end
  local meta = rawget(store, "__al")
  local contents = {}
  for _, key in ipairs(meta.order) do
    local c = rawget(store, key)
    if type(c) == "table" then
      local bosses = {}
      if type(c.items) == "table" then
        for _, i in ipairs(sortedNumKeys(c.items)) do bosses[#bosses + 1] = dumpBoss(c.items[i], meta.extras) end
      end
      local levels
      if type(c.LevelRange) == "table" then levels = { c.LevelRange[1], c.LevelRange[2], c.LevelRange[3] } end
      contents[#contents + 1] = {
        key = tostring(key), name = scalar(c.name), ctype = c.ContentType and meta.ctypes[c.ContentType] or nil,
        areaId = scalar(c.MapID), instanceId = scalar(c.InstanceID), levels = levels, phase = scalar(c.ContentPhase),
        factionId = scalar(c.FactionID), gv = scalar(c.gameVersion),
        tt = scalar(c.TableType), itt = type(c.items) == "table" and scalar(c.items.TableType) or nil,
        bosses = bosses,
      }
    end
  end
  return { contents = contents, diffs = meta.diffs, ttypes = meta.ttypes }
end
function POLESTAR_dumpDroprates()
  local out = {}
  for npc, items in pairs(POLESTAR_AL.droprates) do
    if type(items) == "table" then
      local row = {}
      for item, rate in pairs(items) do if type(rate) == "number" then row[tostring(item)] = rate end end
      out[tostring(npc)] = row
    end
  end
  return out
end
