-- French (frFR): the guide forever/class/mage/arcane-refreshment (forever/class/mage/arcane-refreshment.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10140} Conjure Water · {area:2577} Dire Maul
	["The level 60 {spell:10140}, from a {area:2577} library: drink for you and your group."] = "{spell:10140} de niveau 60, tiré d'une bibliothèque de {area:2577} : de quoi boire pour vous et votre groupe.",
	["Shen'dralar reputation"] = "Réputation Shen'dralar",

	-- Step 1: Lorekeeper Lydros
	-- {area:1099} Camp Mojache · {area:2577} Dire Maul · {zone:1444} Feralas · {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key
	["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing (or the North wing with a {item:18249})."] = "Prenez un vol pour Pennelune (Alliance) ou {area:1099} (Horde) et rendez-vous à {area:2577}, au centre de {zone:1444}. {npc:14368} attend dans l'Athenaeum, la bibliothèque, accessible par l'aile Ouest (ou par l'aile Nord avec une {item:18249}).",

	-- Step 2: Hydrospawn
	["Hydrospawn"] = "Hydrogénos",
	["Hydrospawn, a water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool."] = "Hydrogénos, un élémentaire d'eau, vit dans le quartier Crochebois (Hache-tripes Est) : poursuivez le diablotin Pusillin jusqu'à ce qu'il se retourne pour combattre, nettoyez la salle des satyres, puis descendez la rampe en spirale jusqu'au bassin.",
	-- {item:18299} Hydrospawn Essence
	["{item:18299}: Hydrospawn"] = "{item:18299} : Hydrogénos",

	-- Step 3: Back to Lydros
	["Back to Lydros"] = "Retour auprès de Lydros",
}
