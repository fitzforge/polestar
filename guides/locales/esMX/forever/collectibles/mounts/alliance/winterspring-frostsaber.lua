-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring
	["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{npc:10618}, en {area:2241}, en el norte de {zone:1452}, ofrece las misiones repetibles Provisiones de sable de hielo, Intrusión Nevada y Gigantes arrasadores (nivel 58); son todo el camino hasta Exaltado, así que prepárate para semanas de entregas.",

	-- Step 2: Reins of the Winterspring Frostsaber
	["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "El cliente de Forever la pone a 200g y nivel 60, y no pide ningún rango de equitación.",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}, 200g",
}
