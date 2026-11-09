-- Riding reminder: at levels 40 and 60, if the character has not yet learned
-- riding (or the higher tier at 60), fires a RIDING_DUE event once per tier
-- with trainer location, cost info, and optional class-mount routing.
-- GuideFrame handles display.  When the player cannot afford it yet the module
-- watches PLAYER_MONEY and fires RIDING_MONEY so the banner can refresh the
-- affordability button live, once per tier (its own per-character flag).
--
-- Class routes (tier 1 / level 40 only):
--   WARLOCK: Strahad Farsan, Ratchet (Summon Felsteed chain 3631/4489 or
--     4487/4488 → 4490).  Skip once quest 4490 is done.
--   PALADIN + Alliance: Lord Grayson Shadowbreaker, Stormwind (Tome of
--     Nobility chain 1661/4485/4486).  Skip once quest 4486 is done.
--   PALADIN + Horde/Undead: no chain data; falls back to the riding trainer.
--   Class routes are tier 1 only.  At tier 2 every character goes to the
--   riding trainer.
--
-- Quest 4490 (Warlock chain) and 4486 (Paladin chain) both show "skill: null"
-- in data/forever – whether they also grant the riding skill is not confirmed
-- from the data; the notice therefore says "your class mount comes from this
-- quest; riding trainer otherwise" and the arrow is set regardless of gold
-- so the player can investigate for themselves.
--
-- Riding detection:
--   IsSpellKnown(33388/33391) tried first; skill line 762 (Compat.SKILL_LINES'
--   "riding") is the authoritative fallback used throughout the addon.
--   Spell ids 33388/33391 are TBC-era; factcheck.py has no spell lookup and
--   neither id appears in data/forever – reported in commit message.
--
-- Costs (copper):
--   Apprentice (level 40): 100 g = 1,000,000 c; 10% off Honored → 900,000 c
--   Journeyman (level 60): 1,000 g = 10,000,000 c; 10% off → 9,000,000 c
--
-- Home faction ids verified from data/forever/factions.json:
--   Orc 76 · Troll 530 · Tauren 81 · Scourge/Undead 68
--   Human 72 · NightElf 69 · Dwarf 47 · Gnome 54
--   Skyborne Alliance (High Order) 2779 · Skyborne Horde (Windshapers) 2778
--
-- Per-character state in PolestarCharDB.flags:
--   ridingReminder40 / ridingReminder60 — RIDING_DUE fired for tier
--   ridingArrow40    / ridingArrow60    — resolved (OnResolve called) for tier
--
-- Public API:
--   Riding.Check(level)              called on PLAYER_LEVEL_UP / PLAYER_ENTERING_WORLD
--   Riding.HasRiding(tier)           pure predicate, for tests
--   Riding.EffectiveCost(tier, fID)  cost after Honored discount (copper)
--   Riding.OnResolve(tier)           called by GuideFrame on banner dismiss

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local floor, format, pairs = math.floor, string.format, pairs

local Riding = {}
QoL.Riding = Riding

ns.RegisterDefaults("qol", { ridingReminder = true })

---------------------------------------------------------------------------
-- Riding detection
---------------------------------------------------------------------------

local APPRENTICE_SPELL  = 33388  -- TBC-era spell ids; may not exist in this client
local JOURNEYMAN_SPELL  = 33391
local RIDING_SKILL_LINE = 762    -- Compat.SKILL_LINES' riding: authoritative fallback

-- True when the character has learned riding at the given tier.
-- tier 1 = Apprentice (level 40), tier 2 = Journeyman (level 60).
function Riding.HasRiding(tier)
	local C = ns.Compat
	local spellID = tier == 1 and APPRENTICE_SPELL or JOURNEYMAN_SPELL
	if C.IsSpellKnown(spellID) then return true end
	local rank, maxRank
	if C.GetSkillRank then rank, maxRank = C.GetSkillRank(RIDING_SKILL_LINE) end
	if tier == 1 then
		return rank ~= nil and rank > 0
	else
		return maxRank ~= nil and maxRank >= 150
	end
end

---------------------------------------------------------------------------
-- Trainer data
---------------------------------------------------------------------------

local TRAINERS = {
	Orc      = { map = 1454, x = 69.4,  y = 13.1,  npc = 4752, npcName = "Kildar",               faction = 76  },
	Troll    = { map = 1411, x = 55.3,  y = 75.5,  npc = 7953, npcName = "Xar'Ti",               faction = 530 },
	Tauren   = { map = 1412, x = 46.8,  y = 62.0,  npc = 3690, npcName = "Kar Stormsinger",       faction = 81  },
	Scourge  = { map = 1420, x = 60.1,  y = 52.6,  npc = 4773, npcName = "Velma Warnam",          faction = 68  },
	Human    = { map = 1429, x = 84.3,  y = 64.9,  npc = 4732, npcName = "Randal Hunter",         faction = 72  },
	NightElf = { map = 1438, x = 25.3,  y = 50.2,  npc = 4753, npcName = "Jartsam",              faction = 69  },
	Dwarf    = { map = 1426, x = 63.7,  y = 50.1,  npc = 4772, npcName = "Ultham Ironhorn",       faction = 47  },
	Gnome    = { map = 1426, x = 49.2,  y = 48.1,  npc = 7954, npcName = "Binjy Featherwhistle", faction = 54  },
}
local TRAINERS_SKYBORNE = {
	Alliance = { map = 2521, x = 53.5, y = 80.5, npc = 265756, npcName = "Genn Fairweather", faction = 2779 },
	Horde    = { map = 2521, x = 53.5, y = 80.5, npc = 265756, npcName = "Genn Fairweather", faction = 2778 },
}
local STRAHAD = { map = 1413, x = 62.6,  y = 35.5,  npc = 6251, npcName = "Strahad Farsan"             }
local GRAYSON = { map = 1453, x = 48.43, y = 50.22, npc = 928, npcName = "Lord Grayson Shadowbreaker"  }

local function trainerFor(race, faction)
	if race == "Skyborne" then return TRAINERS_SKYBORNE[faction] end
	return TRAINERS[race]
end

---------------------------------------------------------------------------
-- Cost and discount
---------------------------------------------------------------------------

local BASE_COST = { [1] = 1000000, [2] = 10000000 }
local HONORED   = 5

local function effectiveCost(tier, factionID)
	local base = BASE_COST[tier]
	if factionID then
		local standing = ns.Compat.GetFactionStanding(factionID)
		if standing and standing >= HONORED then
			return floor(base * 0.9 + 0.5)
		end
	end
	return base
end

-- Public: effective cost after Honored discount (copper).  Used by GuideFrame
-- to compute affordability live without duplicating the discount logic.
function Riding.EffectiveCost(tier, factionID)
	return effectiveCost(tier, factionID)
end

local function isHonored(factionID)
	if not factionID then return false end
	local standing = ns.Compat.GetFactionStanding(factionID)
	return standing ~= nil and standing >= HONORED
end

---------------------------------------------------------------------------
-- Class routing  (tier 1 only)
---------------------------------------------------------------------------

local WARLOCK_FINAL = 4490
local PALADIN_FINAL = 4486

-- Returns (npc, factionID, classKind) for class-mount routing at tier 1.
-- classKind ("WARLOCK" | "PALADIN") signals free-mount wording + no-gold gate.
-- Returns nil, nil, nil when no class route applies or the chain is done.
local function classRoute(class, faction, tier)
	if tier ~= 1 then return nil, nil, nil end
	local C = ns.Compat
	if class == "WARLOCK" then
		if not C.IsQuestCompleted(WARLOCK_FINAL) then
			return STRAHAD, nil, "WARLOCK"
		end
	elseif class == "PALADIN" and faction == "Alliance" then
		if not C.IsQuestCompleted(PALADIN_FINAL) then
			return GRAYSON, nil, "PALADIN"
		end
	end
	return nil, nil, nil
end

---------------------------------------------------------------------------
-- Per-character flags
---------------------------------------------------------------------------

local NOTE_FLAGS  = { [1] = "ridingReminder40", [2] = "ridingReminder60" }
local ARROW_FLAGS = { [1] = "ridingArrow40",    [2] = "ridingArrow60"    }

local function markNote(tier)  local s = ns.CharState(); s.flags[NOTE_FLAGS[tier]]  = true end
local function markArrow(tier) local s = ns.CharState(); s.flags[ARROW_FLAGS[tier]] = true end
local function noteSeen(tier)  return ns.CharState().flags[NOTE_FLAGS[tier]]  == true end
local function arrowSeen(tier) return ns.CharState().flags[ARROW_FLAGS[tier]] == true end

---------------------------------------------------------------------------
-- PLAYER_MONEY watcher: fires RIDING_MONEY while any tier banner is pending
---------------------------------------------------------------------------

local ridingMoneyWatch = {}   -- tier -> true while watching for that tier
local moneyRegistered  = false

local onMoney  -- forward declaration

local function unregisterMoney()
	if moneyRegistered then
		ns.UnregisterEvent("PLAYER_MONEY", onMoney)
		moneyRegistered = false
	end
end

local function stopMoneyWatch(tier)
	ridingMoneyWatch[tier] = nil
	if not next(ridingMoneyWatch) then unregisterMoney() end
end

local function startMoneyWatch(tier)
	ridingMoneyWatch[tier] = true
	if not moneyRegistered then
		ns.RegisterEvent("PLAYER_MONEY", onMoney)
		moneyRegistered = true
	end
end

onMoney = function()
	if not next(ridingMoneyWatch) then unregisterMoney(); return end
	-- Prune stale entries (tier resolved or riding learned since last check).
	for tier in pairs(ridingMoneyWatch) do
		if arrowSeen(tier) or Riding.HasRiding(tier) then
			ridingMoneyWatch[tier] = nil
		end
	end
	if not next(ridingMoneyWatch) then unregisterMoney(); return end
	-- Let GuideFrame re-render the banner's affordability button.
	ns.Fire("RIDING_MONEY")
end

---------------------------------------------------------------------------
-- Resolve (called by GuideFrame on banner dismiss or "Take me there")
---------------------------------------------------------------------------

function Riding.OnResolve(tier)
	markArrow(tier)
	stopMoneyWatch(tier)
end

---------------------------------------------------------------------------
-- Core logic
---------------------------------------------------------------------------

-- Derives which tier applies to `level`.  Returns nil for levels below 40.
local function tierForLevel(level)
	if level >= 60 then return 2
	elseif level >= 40 then return 1
	end
end

function Riding.Check(level)
	if not QoL.On("ridingReminder") then return end

	local tier = tierForLevel(level)
	if not tier then return end

	-- Already resolved for this tier; ensure watcher is clean and bail.
	if arrowSeen(tier) then
		stopMoneyWatch(tier)
		return
	end

	-- Already learned (may have been learned since last session).
	if Riding.HasRiding(tier) then
		stopMoneyWatch(tier)
		return
	end

	local info = ns.Compat.GetPlayerInfo()
	local race    = info and info.race    or ""
	local class   = info and info.class   or ""
	local faction = info and info.faction or ""

	local classNpc, classFaction, classKind = classRoute(class, faction, tier)
	local trainer   = classNpc or trainerFor(race, faction)
	local factionID = classNpc and classFaction or (trainer and trainer.faction)

	-- Fire RIDING_DUE once per tier to bring up the banner.
	if not noteSeen(tier) then
		markNote(tier)
		-- Build a trainer sub-table; copy fields so the notice is immutable.
		local trainerNotice
		if trainer then
			local N = ns.Names
			trainerNotice = {
				npc     = trainer.npc,
				map     = trainer.map,
				x       = trainer.x,
				y       = trainer.y,
				npcName = (trainer.npc and N and N.Npc and N.Npc(trainer.npc)) or trainer.npcName,
				faction = trainer.faction,
			}
		end
		local notice = {
			tier      = tier,
			trainer   = trainerNotice,
			classKind = classKind,
			factionID = factionID,
			cost      = classKind and 0 or effectiveCost(tier, factionID),
		}
		ns.Fire("RIDING_DUE", notice)
	end

	-- Watch money for normal (non-class-mount) tiers so GuideFrame can toggle
	-- the "Take me there" button as the player's balance changes.
	if classKind == nil and not ridingMoneyWatch[tier] then
		startMoneyWatch(tier)
	end
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
	ns.SafeCall(Riding.Check, level)
end)

-- Also check on login so existing characters (installed at 40+) get the note.
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	local C = ns.Compat
	local info = C.GetPlayerInfo and C.GetPlayerInfo()
	if info then ns.SafeCall(Riding.Check, info.level) end
end)
