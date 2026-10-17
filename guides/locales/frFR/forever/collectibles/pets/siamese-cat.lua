-- French (frFR): the guide forever/collectibles/pets/siamese-cat (forever/collectibles/pets/siamese-cat.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Siamese Cat"] = "Chat siamois",

	-- Step 1: The Deadmines: Cookie
	-- {area:1581} The Deadmines
	["{area:1581}: Cookie"] = "{area:1581} : Macaron",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. Cookie, the murloc cook near the ship at the end, drops the Siamese about 15% of the time in our data."] = "{area:1581} est un donjon à cinq sous {area:20} ; le portail se trouve dans la mine de {area:20}. Macaron, le cuisinier murloc près du navire à la fin, laisse tomber le Siamois environ 15 % du temps selon nos données.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581} portal, inside the {area:20} mine"] = "Portail de {area:1581}, dans la mine de {area:20}",
	["Cookie"] = "Macaron",
}
