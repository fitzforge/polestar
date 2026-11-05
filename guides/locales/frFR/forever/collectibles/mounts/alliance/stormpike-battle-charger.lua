-- French (frFR): the guide forever/collectibles/mounts/alliance/stormpike-battle-charger (forever/collectibles/mounts/alliance/stormpike-battle-charger.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stormpike Guard
	-- {area:2839} Alterac Valley · {faction:730} Stormpike Guard · {npc:13217} Thanthaldis Snowgleam · {zone:1416} Alterac Mountains · {area:287} Hillsbrad · {npc:13216} Gaelden Hammersmith
	["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins; the Alterac Valley Reputation guide shows the fastest way. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "La {area:2839} (niveau 51+) fait monter la {faction:730} : gagnez, prenez des tours et des cimetières, et rendez les objets du champ de bataille ; le guide de réputation de la vallée d'Alterac montre le chemin le plus rapide. {npc:13217} attend hors du champ de bataille, à la frontière des {zone:1416}, au-dessus d'{area:287} ; {npc:13216}, dans la {area:2839}, vend la même monture.",

	-- Step 2: Stormpike Battle Charger
	-- {skill:762} Riding
	["The Forever client lists it at 200g and level 60. It runs at full speed, so riding it needs Journeyman {skill:762}; any Alliance race can ride it."] = "Le client Forever l'affiche à 200 po et au niveau 60. Elle va à pleine vitesse, la monter demande donc la {skill:762} (compagnon) ; toute race de l'Alliance peut la monter.",
	-- {npc:13217} Thanthaldis Snowgleam
	["{npc:13217}, 200g"] = "{npc:13217}, 200 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Le client Forever l'affiche à 200 po et niveau 60, sans rang de monte requis.",
	-- ["{area:2839} (level 51+) raises {faction:730}: win, capture towers and graveyards, and hand in the battleground's turn-ins. {npc:13217} waits outside the battleground on the {zone:1416} border above {area:287}; {npc:13216} inside {area:2839} sells the same mount."] = "{area:2839} (niveau 51+) fait monter {faction:730} : gagnez, prenez tours et cimetières, et rendez les objets de quête du champ de bataille. {npc:13217} attend hors du champ de bataille, à la limite des {zone:1416} au-dessus d'{area:287} ; {npc:13216}, dans {area:2839}, vend la même monture.",
}
