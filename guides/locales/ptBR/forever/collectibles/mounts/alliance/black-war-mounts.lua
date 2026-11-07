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
	-- {spell:1299382} Rank Points · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "{spell:1299382} vêm de campos de batalha, missões JxJ e tarefas semanais da temporada, com limite semanal; Comandante (patente 11) libera as montarias de guerra negras. A aba Jogador x Jogador do painel do personagem mostra sua patente e o que você pode comprar. {skill:762} uma delas em velocidade máxima exige {skill:762} Profissional (nível 60). O Polestar não consegue ler sua patente, então este passo espera o nível 60 e {skill:762} Profissional.",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {zone:1453} Stormwind · {object:2100} Old Town · {area:2918} Champions' Hall
	["{npc:12783} sells the mounts in {zone:1453}'s {object:2100} by the {area:2918}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Humans ride the steed, Night Elves the tiger, Gnomes the battlestrider, Dwarves the ram. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12783} vende as montarias na {object:2100} de {zone:1453}, junto a {area:2918}, ao lado dos outros intendentes de honra. O cliente do Forever lista cada uma por 100g. Cada uma também exige a equitação do seu tipo: Humanos montam o corcel, Elfos Noturnos o tigre, Gnomos o mecanotrote, Anões o carneiro. Um Celonato, ou quem escolher a montaria de outra raça, precisa primeiro dessa equitação com o instrutor dela (Exaltado com a cidade da raça).",
	-- {npc:14332} Black War Steed · {spell:824} Horse Riding
	["{npc:14332}, {spell:824}, 100g"] = "{npc:14332}, {spell:824}, 100g",
	-- {spell:22723} Black War Tiger · {spell:828} Tiger Riding
	["{spell:22723}, {spell:828}, 100g"] = "{spell:22723}, {spell:828}, 100g",
	-- {item:18243} Black Battlestrider · {spell:10907} Mechanostrider Piloting
	["{item:18243}, {spell:10907}, 100g"] = "{item:18243}, {spell:10907}, 100g",
	-- {item:18244} Black War Ram · {spell:826} Ram Riding
	["{item:18244}, {spell:826}, 100g"] = "{item:18244}, {spell:826}, 100g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100g",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "No Forever, as patentes JxJ vêm de {spell:1299382} ganhos em campos de batalha e no JxJ mundial, com limite semanal; Comandante (patente 11) libera as montarias de guerra pretas. O Polestar não consegue ler sua patente, então esta etapa espera o nível 40 e a perícia de montaria.",
	-- ["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783} vende as montarias no {area:2918}, em {object:2100}, {zone:1453}, ao lado dos outros intendentes de honra, como {npc:12805}. O cliente Forever cobra 100g por cada uma; escolha uma.",
}
