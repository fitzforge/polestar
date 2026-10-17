-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "Montarias de Guerra Negras",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "Patente JxJ 11",
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "No Forever, as patentes JxJ vêm de {spell:1299382} ganhos em campos de batalha e no JxJ mundial, com limite semanal; {spell:436438} (patente 11) libera as montarias de guerra pretas. O Polestar não consegue ler sua patente, então esta etapa espera o nível 40 e a perícia de montaria.",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:12799} Sergeant Ba'sha
	["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796} vende as montarias no {area:2917}, no {object:172958} de {zone:1454}, ao lado dos outros intendentes de honra como {npc:12799}. O cliente do Forever lista cada uma a 100g; escolha uma.",
	["100g"] = "100g",
}
