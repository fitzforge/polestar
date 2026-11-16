-- Pawn stat names -> Polestar's stat keys (Gear.STAT_KEYS), for importing a
-- Pawn scale string (Pawn.lua). Pawn names are matched without regard to case.
--
-- Pawn's names are those of its UIStrings.lua (Pawn 2.13.17, Classic client).
--
-- Units (#1538): a Pawn scale weighs a rating per rating point, as the item
-- shows it ("+14 critical strike rating" is CritRating 14). Polestar's keys
-- hold percent, as the item's ratings are read (Gear.RATINGS: Forever's
-- rating per 1%), so Pawn.Weights multiplies a rating stat's weight by its
-- rate (Gear.RATING_RATE: crit and spell crit 14, hit, spell hit, haste,
-- expertise and armor penetration 10, dodge 12, parry 15, block 5) and
-- Pawn.Build divides it back: CritRating=1 is crit 14 in Polestar, and
-- exports as CritRating=1 again. DefenseRating is defense skill points, one
-- for one, as `defense`.
--
-- `to` is the list of Polestar keys the weight is given to. A `generic` entry
-- fills those keys only where no specific entry of the string names them: Dps
-- covers both weapon slots until MeleeDps or RangedDps say otherwise.
-- OffHandDps is the off hand's weapon DPS (ohDps); without it an off hand
-- counts half of the melee weight.
--
-- Pawn stats with no Polestar key, so ignored (and named in the import
-- summary): ArcaneResist, FireResist, FrostResist, NatureResist, ShadowResist
-- and AllResist (Polestar scores no resistance), FeralAp (Polestar's feral
-- weights read plain attack power and weapon DPS), Speed, MinDamage and
-- MaxDamage (a weapon's speed and damage range; Polestar scores its DPS), and
-- what Polestar has no key for (SpellPower, ...).
--
-- HasteRating, ExpertiseRating and ArmorPenetration (Forever's ratings, #1529)
-- map to haste, expertise and armorPen, converted as CritRating above.

local ADDON, ns = ...

local Gear = ns.Gear or {}
ns.Gear = Gear

-- { pawn = canonical Pawn name, to = { polestar keys }, generic = bool, alias = { other spellings } }
Gear.PAWN_STATS = {
	{ pawn = "Strength", to = { "str" } },
	{ pawn = "Agility", to = { "agi" } },
	{ pawn = "Stamina", to = { "sta" } },
	{ pawn = "Intellect", to = { "int" } },
	{ pawn = "Spirit", to = { "spi" } },

	{ pawn = "Armor", to = { "armor" } },
	{ pawn = "Health", to = { "health" } },
	{ pawn = "Mana", to = { "mana" } },
	{ pawn = "Hp5", to = { "hp5" } },
	{ pawn = "Mp5", to = { "mp5" } },

	{ pawn = "Ap", to = { "ap" } },
	{ pawn = "Rap", to = { "rap" } },
	{ pawn = "Dps", to = { "dps", "rdps" }, generic = true },
	{ pawn = "MeleeDps", to = { "dps" } },
	{ pawn = "OffHandDps", to = { "ohDps" } },
	{ pawn = "RangedDps", to = { "rdps" } },

	{ pawn = "SpellDamage", to = { "sp" } },
	{ pawn = "ArcaneSpellDamage", to = { "spArcane" } },
	{ pawn = "FireSpellDamage", to = { "spFire" } },
	{ pawn = "FrostSpellDamage", to = { "spFrost" } },
	{ pawn = "HolySpellDamage", to = { "spHoly" } },
	{ pawn = "NatureSpellDamage", to = { "spNature" } },
	{ pawn = "ShadowSpellDamage", to = { "spShadow" } },
	{ pawn = "Healing", to = { "heal" } },

	{ pawn = "CritRating", to = { "crit" } },
	{ pawn = "HitRating", to = { "hit" } },
	{ pawn = "SpellCritRating", to = { "spellCrit" } },
	{ pawn = "SpellHitRating", to = { "spellHit" } },
	{ pawn = "DefenseRating", to = { "defense" } },
	{ pawn = "DodgeRating", to = { "dodge" } },
	{ pawn = "ParryRating", to = { "parry" } },
	{ pawn = "BlockRating", to = { "block" } },
	{ pawn = "BlockValue", to = { "blockValue" } },
	{ pawn = "HasteRating", to = { "haste" } },
	{ pawn = "ExpertiseRating", to = { "expertise" } },
	{ pawn = "ArmorPenetration", to = { "armorPen" } },
}

-- Keys of a Pawn string that describe the scale, not a stat. Any key whose
-- value is not a number is metadata too, whatever its name.
Gear.PAWN_META = {
	class = true, spec = true, classid = true, specid = true,
	icon = true, color = true, visible = true, provider = true, version = true,
}
