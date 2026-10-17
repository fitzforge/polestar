-- French (frFR): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring
	["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{npc:10618}, au {area:2241} au nord du {zone:1452}, propose les quêtes répétables « Provisions de sabres-de-givre », « L'incursion des Tombe-hiver » et « Géants déchaînés » (niveau 58) ; elles sont la seule voie vers Exalté : comptez des semaines de remises.",

	-- Step 2: Reins of the Winterspring Frostsaber
	["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Le client Forever l'affiche à 200 po au niveau 60, sans rang de monte requis.",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}, 200 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1452} Frostsaber"] = "Sabre-de-givre de {zone:1452}",
}
