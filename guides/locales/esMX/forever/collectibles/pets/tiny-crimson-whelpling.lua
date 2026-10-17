-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/tiny-crimson-whelpling (forever/collectibles/pets/tiny-crimson-whelpling.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wetlands whelps
	-- {zone:1437} Wetlands
	["{zone:1437} whelps"] = "Crías de {zone:1437}",
	-- {zone:1437} Wetlands
	-- plural, as words: Flamesnorting Whelps = {npc:1044} Flamesnorting Whelp
	["The Red, Crimson and Flamesnorting Whelps (levels 23-26) in the eastern {zone:1437} drop it about once in 600-1,600 kills in our data."] = "Las Crías rojas, Crías carmesí y Crías escupefuego (niveles 23-26) del este de {zone:1437} lo sueltan más o menos una vez cada 600-1,600 muertes según nuestros datos.",
}
