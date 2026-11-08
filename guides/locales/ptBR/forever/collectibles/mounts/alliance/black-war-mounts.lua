-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "Montarias de Guerra Pretas",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "Patente JxJ 11",
	-- {skill:762} Riding
	["Rank Points come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {zone:1453} Stormwind · {object:2100} Old Town · {object:179725} Champions' Hall (no name in this language: may be words)
	["{npc:12783} sells the mounts in {zone:1453}'s {object:2100} by the {object:179725}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Humans ride the steed, Night Elves the tiger, Gnomes the battlestrider, Dwarves the ram. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "",
	-- {npc:14332} Black War Steed
	["{npc:14332}, Horse Riding, 100g"] = "",
	["Black War Tiger, Tiger Riding, 100g"] = "",
	-- {item:18243} Black Battlestrider
	["{item:18243}, Mechanostrider Piloting, 100g"] = "",
	-- {item:18244} Black War Ram
	["{item:18244}, Ram Riding, 100g"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100g",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "No Forever, as patentes JxJ vêm de {spell:1299382} ganhos em campos de batalha e no JxJ mundial, com limite semanal; Comandante (patente 11) libera as montarias de guerra pretas. O Polestar não consegue ler sua patente, então esta etapa espera o nível 40 e a perícia de montaria.",
	-- ["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783} vende as montarias no {area:2918}, em {object:2100}, {zone:1453}, ao lado dos outros intendentes de honra, como {npc:12805}. O cliente Forever cobra 100g por cada uma; escolha uma.",
}
