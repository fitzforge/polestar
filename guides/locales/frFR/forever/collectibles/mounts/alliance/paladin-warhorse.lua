-- French (frFR): the guide forever/collectibles/mounts/alliance/paladin-warhorse (forever/collectibles/mounts/alliance/paladin-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse"] = "Cheval de guerre de paladin",
	["Your first mount at 40, summoned at will: a paladin buys no horse."] = "Votre première monture au niveau 40, invoquée à volonté : un paladin n'achète pas de cheval.",

	-- Step 1: The Tome of Nobility (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 40 {npc:5149} in the {object:32362} sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "Au niveau 40, {npc:5149} dans {object:32362} vous envoie voir {npc:6171} à la cathédrale de la Lumière de {zone:1453}. Prenez le tram de {zone:1455} à {zone:1453}.",

	-- Step 2: Summon Warhorse
	-- {npc:6171} Duthorian Rall · {item:6779} Tome of Nobility · {spell:13819} Summon Warhorse
	["{npc:6171} stands in the Cathedral of Light. Turning in the {item:6779} teaches {spell:13819}; Paladins do not buy a mount."] = "{npc:6171} se trouve dans la cathédrale de la Lumière. Rendre le {item:6779} vous apprend {spell:13819} ; les paladins n'achètent pas de monture.",
}
