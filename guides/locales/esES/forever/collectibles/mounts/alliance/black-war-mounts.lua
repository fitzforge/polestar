-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "Monturas de guerra negras",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "Rango JcJ 11",
	-- {spell:1299382} Rank Points
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "En Forever, los rangos JcJ salen de los {spell:1299382} ganados en campos de batalla y en JcJ en el mundo, con un tope semanal; Comandante (rango 11) desbloquea las monturas de guerra negras. Polestar no puede leer tu rango, así que este paso espera al nivel 40 y a la habilidad de equitación.",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {area:2918} Champions' Hall · {zone:1453} Stormwind · {object:2100} Old Town · {npc:12805} Officer Areyn
	["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783} vende las monturas en {area:2918}, en {object:2100} de {zone:1453}, junto a los demás intendentes de honor como {npc:12805}. El cliente de Forever pone cada una a 100 o; elige una.",
	["100g"] = "100 o",
}
