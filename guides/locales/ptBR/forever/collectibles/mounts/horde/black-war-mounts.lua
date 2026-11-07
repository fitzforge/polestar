-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "{spell:1299382} vêm de campos de batalha, missões JxJ e tarefas semanais da temporada, com limite semanal; {spell:436438} (patente 11) libera as montarias de guerra negras. A aba Jogador x Jogador do painel do personagem mostra sua patente e o que você pode comprar. {skill:762} uma delas em velocidade máxima exige {skill:762} Profissional (nível 60). O Polestar não consegue ler sua patente, então este passo espera o nível 60 e {skill:762} Profissional.",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words)
	["{npc:12796} sells the mounts by the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Orcs ride the wolf, Trolls the raptor, Tauren the kodo, Undead the skeletal warhorse. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12796} vende as montarias junto a {area:2917}, no Vale da Honra de {zone:1454}, ao lado dos outros intendentes de honra. O cliente do Forever lista cada uma por 100g. Cada uma também exige a equitação do seu tipo: Orcs montam o lobo, Trolls o raptor, Taurens o kodo, Mortos-vivos o cavalo de guerra esquelético. Um Celonato, ou quem escolher a montaria de outra raça, precisa primeiro dessa equitação com o instrutor dela (Exaltado com a cidade da raça).",
	-- {npc:14329} Black War Wolf · {spell:825} Wolf Riding
	["{npc:14329}, {spell:825}, 100g"] = "{npc:14329}, {spell:825}, 100g",
	-- {npc:14330} Black War Raptor · {spell:10861} Raptor Riding
	["{npc:14330}, {spell:10861}, 100g"] = "{npc:14330}, {spell:10861}, 100g",
	-- {item:18247} Black War Kodo · {spell:18995} Kodo Riding
	["{item:18247}, {spell:18995}, 100g"] = "{item:18247}, {spell:18995}, 100g",
	-- {item:18248} Red Skeletal Warhorse · {spell:10906} Undead Horsemanship
	["{item:18248}, {spell:10906}, 100g"] = "{item:18248}, {spell:10906}, 100g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100g",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "No Forever, as patentes JxJ vêm de {spell:1299382} ganhos em campos de batalha e no JxJ mundial, com limite semanal; {spell:436438} (patente 11) libera as montarias de guerra pretas. O Polestar não consegue ler sua patente, então esta etapa espera o nível 40 e a perícia de montaria.",
	-- ["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796} vende as montarias no {area:2917}, no {object:172958} de {zone:1454}, ao lado dos outros intendentes de honra como {npc:12799}. O cliente do Forever lista cada uma a 100g; escolha uma.",
}
