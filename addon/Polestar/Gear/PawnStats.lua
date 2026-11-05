-- Pawn stat names -> Polestar's stat keys (Gear.STAT_KEYS), for importing a
-- Pawn scale string (Pawn.lua). Pawn names are matched without regard to case.
--
-- Pawn's names are those of its UIStrings.lua (Pawn 2.13.17, Classic client).
--
-- Units: Classic has no ratings. Pawn's CritRating, HitRating, DodgeRating and
-- the like count the item's percent (an item with "+1% crit" has CritRating 1),
-- which is what Polestar's crit, hit, dodge, parry and block keys hold, so
-- they map one to one. DefenseRating is defense skill points, as `defense`.
--
-- `to` is the list of Polestar keys the weight is given to. A `generic` entry
-- fills those keys only where no specific entry of the string names them: Dps
-- covers both weapon slots until MeleeDps or RangedDps say otherwise.
--
-- Pawn stats with no Polestar key, so ignored (and named in the import
-- summary): ArcaneResist, FireResist, FrostResist, NatureResist, ShadowResist
-- and AllResist (Polestar scores no resistance), FeralAp (Polestar's feral
-- weights read plain attack power and weapon DPS), Speed, MinDamage and
-- MaxDamage (a weapon's speed and damage range; Polestar scores its DPS), and
-- anything Classic does not have (HasteRating, ExpertiseRating,
-- ArmorPenetration, SpellPower, ...).

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
}

-- Keys of a Pawn string that describe the scale, not a stat. Any key whose
-- value is not a number is metadata too, whatever its name.
Gear.PAWN_META = {
	class = true, spec = true, classid = true, specid = true,
	icon = true, color = true, visible = true, provider = true, version = true,
}
