-- French (frFR): the guide forever/collectibles/pets/green-wing-macaw (forever/collectibles/pets/green-wing-macaw.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Deadmines: Defias Pirates
	-- {area:1581} The Deadmines
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["{area:1581}: Defias Pirates"] = "{area:1581} : Pirates défias",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["{area:1581} is a group of five at level 17-26, under {area:20}: go in at the {area:20} mine and follow the tunnel down to the instance portal. The Defias Pirates (elite, level 19-20) on and around the ship at the far end drop the macaw about once in 30 kills, so plan on several runs; a character well past the dungeon's level clears it alone. The cage can be traded: look at the Auction House too."] = "Les {area:1581} sont un donjon pour un groupe de cinq de niveau 17-26, sous {area:20} : entrez par la mine de {area:20} et suivez le tunnel jusqu'au portail de l'instance. Les Pirates défias (élites, niveau 19-20) sur le navire au fond et autour lâchent l'ara environ une fois sur 30 : prévoyez plusieurs passages ; un personnage d'un niveau bien supérieur au donjon le nettoie seul. La cage peut être échangée : regardez aussi à l'hôtel des ventes.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, dans la mine de {area:20}",
	-- {area:1581} The Deadmines
	["{area:1581} portal, at the bottom of the mine"] = "Portail des {area:1581}, au fond de la mine",
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["Defias Pirates, on the ship"] = "Pirates défias, sur le navire",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defias Pirates"] = "Pirates défias",
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Defias Pirates on and around the ship drop the macaw about 3.5% of the time in our data."] = "{area:1581} est un donjon pour cinq sous {area:20} ; le portail de l'instance est dans la mine de {area:20}. Les Pirates défias sur le navire et autour laissent tomber l'ara environ 3,5 % du temps selon nos données.",
	-- ["{area:1581} portal, inside the {area:20} mine"] = "Portail de {area:1581}, dans la mine de {area:20}",
}
