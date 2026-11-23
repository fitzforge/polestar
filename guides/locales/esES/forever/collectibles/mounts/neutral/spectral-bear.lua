-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: 55 Legacy Points
	["55 Legacy Points"] = "55 puntos de Legado",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard · {npc:6791} Innkeeper Wiley · {area:392} Ratchet · {zone:1413} Barrens
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one, and every point the account earns counts here, spent or not. The Legacy Challenges guide plans them. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. Claim each one from {npc:6791} at the inn in {area:392}, on the {zone:1413} coast: he offers a \"Legacy Reward\" quest once you have the points."] = "Los puntos de Legado son de toda la cuenta: cada desafío de Legado (una clase que llega a 25, 45 y 60, profesiones, JcJ, exploración) vale uno, y cada punto que gana la cuenta cuenta aquí, gastado o no. La guía de desafíos de Legado los planifica. El registro de progreso da {item:281060} con 15, {npc:268840} con 25, {item:277717} con 40 y las riendas con 55. Reclama cada una con {npc:6791} en la posada de {area:392}, en la costa de {zone:1413}: te ofrece una misión «Legacy Reward» en cuanto tengas los puntos.",
	-- {npc:6791} Innkeeper Wiley
	["from {npc:6791}"] = "",

	-- Step 2: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} de oficial",
	-- {skill:762} Riding
	["The bear runs at full speed: riding it needs level 60 and Journeyman {skill:762} (Forever client), from your race's riding trainer; see the Level 60 mount guides."] = "El oso corre a máxima velocidad: montarlo requiere nivel 60 y {skill:762} de oficial (cliente de Forever), del instructor de equitación de tu raza; consulta las guías de monturas de nivel 60.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Spectral Bear"] = "Oso espectral",
}
