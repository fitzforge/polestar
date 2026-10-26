-- Leveling stat weights per class and talent spec, and what each class can
-- wear. Authored for Polestar from Classic Era's stat formulas; World of
-- Warcraft: Forever may have retuned some of them (verify in game and adjust
-- here, nowhere else).
--
-- How the numbers were set. One point of the spec's main stat is ~1.0 and
-- everything else is "worth this many points of it" while levelling (solo
-- questing first, dungeons second):
--   * Melee attack power: Warrior/Paladin/Shaman/Druid get 2 AP per Strength,
--     Rogues and Hunters 1 AP per Strength and 1 AP per Agility (Hunters also
--     2 ranged AP per Agility). 14 AP = 1 weapon DPS, so 1 weapon DPS is worth
--     ~7 Strength to a Warrior; less for hybrids that also cast.
--   * Agility: crit (about 1% per 20 Agility for Warriors/Paladins/Druids at
--     60, 29 for Rogues, 53 for Hunters, better at low level) plus 2 armor.
--   * Stamina: 10 health. Valued higher for solo survival than raid lists do.
--   * Intellect: 15 mana and a little spell crit. Spirit: out-of-combat
--     regeneration (the 5-second rule), worth a lot to Priests, Mages and
--     Warlocks while levelling, little to melee.
--   * Percent stats (crit, hit, spellCrit, spellHit, dodge, parry, block) are
--     per 1%; mp5/hp5 per point per 5 seconds; weapon DPS per 1 DPS.
--   * dps = the melee weapon's DPS (main hand; the off hand counts half, its
--     damage penalty), rdps = the ranged slot's DPS (bows, guns, crossbows,
--     thrown, wands). Feral Druids ignore weapon DPS: forms do not use it.
--   * sp = spell damage of every school, spFire etc. = one school only, heal =
--     healing. Classic +spell-power items carry both sp and heal, so damage
--     specs read the sp half and healers the heal half.

local ADDON, ns = ...

local Gear = ns.Gear or {}
ns.Gear = Gear

-- Stat keys a weight table may use (also the canonical item stat keys).
Gear.STAT_KEYS = {
	"str", "agi", "sta", "int", "spi", "armor", "health", "mana",
	"ap", "rap", "sp", "spArcane", "spFire", "spFrost", "spHoly", "spNature", "spShadow", "heal",
	"crit", "hit", "spellCrit", "spellHit", "mp5", "hp5", "defense", "dodge", "parry", "block", "blockValue",
	"dps", "rdps",
}

-- Specs in talent-tab order (C_SpecializationInfo index). `names` are the
-- enUS tab names, matched first; the index is the fallback. `default` is the
-- usual levelling spec, used before any talent point is spent.
Gear.CLASSES = {
	WARRIOR = { bit = 1, default = "arms", specs = {
		{ key = "arms", label = "Arms", names = { "arms" } },
		{ key = "fury", label = "Fury", names = { "fury" } },
		{ key = "protection", label = "Protection (tank)", names = { "protection" } },
	} },
	PALADIN = { bit = 2, default = "retribution", specs = {
		{ key = "holy", label = "Holy (healer)", names = { "holy" } },
		{ key = "protection", label = "Protection (tank)", names = { "protection" } },
		{ key = "retribution", label = "Retribution", names = { "retribution" } },
	} },
	HUNTER = { bit = 4, default = "beastmastery", specs = {
		{ key = "beastmastery", label = "Beast Mastery", names = { "beastmastery" } },
		{ key = "marksmanship", label = "Marksmanship", names = { "marksmanship" } },
		{ key = "survival", label = "Survival", names = { "survival" } },
	} },
	ROGUE = { bit = 8, default = "combat", specs = {
		{ key = "assassination", label = "Assassination", names = { "assassination" } },
		{ key = "combat", label = "Combat", names = { "combat" } },
		{ key = "subtlety", label = "Subtlety", names = { "subtlety" } },
	} },
	PRIEST = { bit = 16, default = "shadow", specs = {
		{ key = "discipline", label = "Discipline", names = { "discipline" } },
		{ key = "holy", label = "Holy (healer)", names = { "holy" } },
		{ key = "shadow", label = "Shadow", names = { "shadow" } },
	} },
	SHAMAN = { bit = 64, default = "enhancement", specs = {
		{ key = "elemental", label = "Elemental", names = { "elemental" } },
		{ key = "enhancement", label = "Enhancement", names = { "enhancement" } },
		{ key = "restoration", label = "Restoration (healer)", names = { "restoration" } },
	} },
	MAGE = { bit = 128, default = "frost", specs = {
		{ key = "arcane", label = "Arcane", names = { "arcane" } },
		{ key = "fire", label = "Fire", names = { "fire" } },
		{ key = "frost", label = "Frost", names = { "frost" } },
	} },
	WARLOCK = { bit = 256, default = "affliction", specs = {
		{ key = "affliction", label = "Affliction", names = { "affliction" } },
		{ key = "demonology", label = "Demonology", names = { "demonology" } },
		{ key = "destruction", label = "Destruction", names = { "destruction" } },
	} },
	DRUID = { bit = 1024, default = "feral", specs = {
		{ key = "balance", label = "Balance", names = { "balance" } },
		{ key = "feral", label = "Feral", names = { "feral", "feralcombat" } },
		{ key = "restoration", label = "Restoration (healer)", names = { "restoration" } },
	} },
}

Gear.WEIGHTS = {
	WARRIOR = {
		arms = { str = 1, agi = 0.6, sta = 0.5, spi = 0.1, armor = 0.02, ap = 0.5, crit = 10, hit = 9, dps = 7, rdps = 0.5,
			hp5 = 1, health = 0.05, defense = 0.2, dodge = 3, parry = 3, block = 0.3, blockValue = 0.05 },
		fury = { str = 1, agi = 0.65, sta = 0.5, spi = 0.1, armor = 0.02, ap = 0.5, crit = 11, hit = 11, dps = 6.5, rdps = 0.5,
			hp5 = 1, health = 0.05, defense = 0.2, dodge = 3, parry = 3 },
		protection = { sta = 1, str = 0.6, agi = 0.7, armor = 0.06, defense = 1.2, dodge = 12, parry = 12, block = 8, blockValue = 0.5,
			hit = 6, crit = 4, ap = 0.25, dps = 2.5, rdps = 0.3, hp5 = 1.5, health = 0.1, spi = 0.05 },
	},
	PALADIN = {
		holy = { int = 1, heal = 0.65, sp = 0.15, spHoly = 0.1, mp5 = 2.2, spi = 0.5, sta = 0.45, spellCrit = 7, str = 0.15,
			armor = 0.005, dps = 0.5, health = 0.05, mana = 0.06 },
		protection = { sta = 1, armor = 0.05, defense = 1, dodge = 10, parry = 10, block = 6, blockValue = 0.4, str = 0.5, agi = 0.5,
			int = 0.4, sp = 0.5, spHoly = 0.5, spellHit = 4, hit = 4, mp5 = 1, dps = 2, health = 0.1 },
		retribution = { str = 1, agi = 0.55, sta = 0.5, int = 0.35, spi = 0.15, armor = 0.02, ap = 0.5, crit = 9, hit = 9,
			sp = 0.3, spHoly = 0.3, mp5 = 1, dps = 7, hp5 = 0.5, health = 0.05, mana = 0.02 },
	},
	HUNTER = {
		beastmastery = { agi = 1, rap = 0.45, ap = 0.5, crit = 10, hit = 10, rdps = 6.5, sta = 0.55, int = 0.35, spi = 0.2,
			str = 0.1, armor = 0.02, mp5 = 1.2, dps = 0.5, mana = 0.02, health = 0.05 },
		marksmanship = { agi = 1, rap = 0.45, ap = 0.5, crit = 11, hit = 11, rdps = 7, sta = 0.5, int = 0.4, spi = 0.2,
			str = 0.1, armor = 0.02, mp5 = 1.2, dps = 0.5, mana = 0.02, health = 0.05 },
		survival = { agi = 1.1, rap = 0.45, ap = 0.55, crit = 11, hit = 10, rdps = 6.5, sta = 0.55, int = 0.35, spi = 0.2,
			str = 0.15, armor = 0.02, mp5 = 1, dps = 1, mana = 0.02, health = 0.05 },
	},
	ROGUE = {
		assassination = { agi = 1, str = 0.55, ap = 0.55, crit = 11, hit = 11, dps = 5.5, sta = 0.45, armor = 0.02, dodge = 2,
			rdps = 0.4, hp5 = 0.5, health = 0.05, spi = 0.05 },
		combat = { agi = 1, str = 0.55, ap = 0.55, crit = 10, hit = 12, dps = 6, sta = 0.45, armor = 0.02, dodge = 2,
			rdps = 0.4, hp5 = 0.5, health = 0.05, spi = 0.05 },
		subtlety = { agi = 1, str = 0.5, ap = 0.5, crit = 10, hit = 10, dps = 5.5, sta = 0.5, armor = 0.02, dodge = 2,
			rdps = 0.4, hp5 = 0.5, health = 0.05, spi = 0.05 },
	},
	PRIEST = {
		discipline = { int = 1, spi = 0.8, heal = 0.55, sp = 0.45, mp5 = 2, sta = 0.5, spellCrit = 6, spellHit = 3, rdps = 2.5,
			armor = 0.005, mana = 0.06, health = 0.05 },
		holy = { int = 1, spi = 0.85, heal = 0.7, sp = 0.3, mp5 = 2.2, sta = 0.45, spellCrit = 6, rdps = 2, armor = 0.005,
			mana = 0.06, health = 0.05 },
		shadow = { int = 0.85, spi = 0.9, sta = 0.65, sp = 1, spShadow = 1, spellHit = 9, spellCrit = 3, mp5 = 1.8, rdps = 3,
			heal = 0.05, armor = 0.005, mana = 0.05, health = 0.06 },
	},
	SHAMAN = {
		elemental = { int = 1, sp = 0.9, spNature = 0.9, spFire = 0.3, spFrost = 0.2, spellCrit = 8, spellHit = 8, mp5 = 2,
			spi = 0.35, sta = 0.5, str = 0.2, agi = 0.15, armor = 0.01, dps = 1.5, mana = 0.06, health = 0.05 },
		enhancement = { str = 1, agi = 0.7, ap = 0.5, crit = 9, hit = 9, dps = 7, sta = 0.5, int = 0.35, spi = 0.15, armor = 0.02,
			mp5 = 1, sp = 0.15, spNature = 0.15, block = 0.3, health = 0.05, mana = 0.02 },
		restoration = { int = 1, heal = 0.7, mp5 = 2.4, spi = 0.35, sta = 0.45, spellCrit = 6, sp = 0.1, armor = 0.005, dps = 0.5,
			mana = 0.06, health = 0.05 },
	},
	MAGE = {
		arcane = { int = 1, sp = 1.1, spArcane = 1.1, spFire = 0.4, spFrost = 0.4, spellCrit = 7, spellHit = 9, spi = 0.55,
			sta = 0.55, mp5 = 1.8, rdps = 1.5, armor = 0.005, mana = 0.07, health = 0.05 },
		fire = { int = 0.9, sp = 1.1, spFire = 1.1, spFrost = 0.2, spArcane = 0.2, spellCrit = 9, spellHit = 9, spi = 0.5,
			sta = 0.55, mp5 = 1.6, rdps = 1.5, armor = 0.005, mana = 0.06, health = 0.05 },
		frost = { int = 0.9, sp = 1.1, spFrost = 1.1, spFire = 0.2, spArcane = 0.2, spellCrit = 6, spellHit = 9, spi = 0.6,
			sta = 0.6, mp5 = 1.8, rdps = 1.5, armor = 0.005, mana = 0.06, health = 0.06 },
	},
	WARLOCK = {
		affliction = { sta = 0.8, int = 0.75, spi = 0.6, sp = 1, spShadow = 1, spFire = 0.2, spellHit = 9, spellCrit = 3,
			mp5 = 1, rdps = 2, armor = 0.005, health = 0.08, mana = 0.05 },
		demonology = { sta = 1, int = 0.75, spi = 0.55, sp = 0.85, spShadow = 0.85, spFire = 0.2, spellHit = 8, spellCrit = 3,
			mp5 = 1, rdps = 2, armor = 0.005, health = 0.1, mana = 0.05 },
		destruction = { sta = 0.7, int = 0.85, spi = 0.4, sp = 1, spShadow = 0.8, spFire = 0.6, spellHit = 9, spellCrit = 7,
			mp5 = 1, rdps = 2, armor = 0.005, health = 0.07, mana = 0.05 },
	},
	DRUID = {
		balance = { int = 1, sp = 0.9, spNature = 0.9, spArcane = 0.7, spellCrit = 6, spellHit = 8, spi = 0.5, sta = 0.5, mp5 = 2,
			heal = 0.1, armor = 0.005, mana = 0.06, health = 0.05 },
		feral = { str = 1, agi = 1, ap = 0.5, crit = 9, hit = 9, sta = 0.65, armor = 0.04, defense = 0.4, dodge = 6, int = 0.2,
			spi = 0.15, hp5 = 0.5, health = 0.07 },
		restoration = { int = 1, heal = 0.7, spi = 0.65, mp5 = 2.2, sta = 0.45, spellCrit = 4, sp = 0.1, armor = 0.005,
			mana = 0.06, health = 0.05 },
	},
}

-- Armor and weapon proficiencies (Classic Era trainers; weapon skills a class
-- can train count as usable). Armor subclasses: 1 cloth, 2 leather, 3 mail,
-- 4 plate; `armorAt40` is the heavier type learned at level 40. Relics:
-- 7 libram, 8 idol, 9 totem. Weapon subclasses: 0/1 axe 1H/2H, 2 bow, 3 gun,
-- 4/5 mace 1H/2H, 6 polearm, 7/8 sword 1H/2H, 10 staff, 13 fist, 15 dagger,
-- 16 thrown, 18 crossbow, 19 wand. `dualWield` = the level Dual Wield is
-- trained (Spell 674 known also counts).
local function set(...)
	local t = {}
	for i = 1, select("#", ...) do t[select(i, ...)] = true end
	return t
end

Gear.PROFICIENCY = {
	WARRIOR = { armor = 3, armorAt40 = 4, shield = true, dualWield = 20, weapons = set(0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 13, 15, 16, 18) },
	PALADIN = { armor = 3, armorAt40 = 4, shield = true, relic = 7, weapons = set(0, 1, 4, 5, 6, 7, 8) },
	HUNTER = { armor = 2, armorAt40 = 3, dualWield = 20, weapons = set(0, 1, 2, 3, 6, 7, 8, 10, 13, 15, 16, 18) },
	ROGUE = { armor = 2, dualWield = 10, weapons = set(2, 3, 4, 7, 13, 15, 16, 18) },
	PRIEST = { armor = 1, weapons = set(4, 10, 15, 19) },
	SHAMAN = { armor = 2, armorAt40 = 3, shield = true, relic = 9, weapons = set(0, 1, 4, 5, 10, 13, 15) },
	MAGE = { armor = 1, weapons = set(7, 10, 15, 19) },
	WARLOCK = { armor = 1, weapons = set(7, 10, 15, 19) },
	DRUID = { armor = 2, relic = 8, weapons = set(4, 5, 10, 13, 15) },
}
