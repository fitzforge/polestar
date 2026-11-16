-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "Monturas de guerra negras",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "Rango JcJ 11",
	-- {spell:1299382} Rank Points · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "Los {spell:1299382} salen de los campos de batalla, las misiones JcJ y las tareas semanales de la temporada, con un tope semanal; Comandante (rango 11) desbloquea las monturas de guerra negras. La pestaña Jugador contra Jugador del panel de personaje muestra tu rango y lo que puedes comprar. Usar {skill:762} con una a toda velocidad requiere {skill:762} de oficial (nivel 60). Polestar no puede leer tu rango, así que este paso espera al nivel 60 y a {skill:762} de oficial.",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {zone:1453} Stormwind · {object:2100} Old Town · {area:2918} Champions' Hall
	["{npc:12783} sells the mounts in {zone:1453}'s {object:2100} by the {area:2918}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Humans ride the steed, Night Elves the tiger, Gnomes the battlestrider, Dwarves the ram. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12783} vende las monturas en {object:2100} de {zone:1453}, junto a {area:2918}, al lado de los otros intendentes de honor. El cliente de Forever las lista a 100 de oro cada una. Cada una también pide la equitación de su tipo: los humanos montan el corcel, los elfos de la noche el tigre, los gnomos el zancudo de batalla y los enanos el carnero. Un Cielonato, o quien elija la montura de otra raza, primero necesita esa equitación de su instructor (Exaltado con la ciudad de esa raza).",
	-- {npc:14332} Black War Steed · {spell:824} Horse Riding
	["{npc:14332}, {spell:824}, 100g"] = "{npc:14332}, {spell:824}, 100 de oro",
	-- {spell:22723} Black War Tiger · {spell:828} Tiger Riding
	["{spell:22723}, {spell:828}, 100g"] = "{spell:22723}, {spell:828}, 100 de oro",
	-- {item:18243} Black Battlestrider · {spell:10907} Mechanostrider Piloting
	["{item:18243}, {spell:10907}, 100g"] = "{item:18243}, {spell:10907}, 100 de oro",
	-- {item:18244} Black War Ram · {spell:826} Ram Riding
	["{item:18244}, {spell:826}, 100g"] = "{item:18244}, {spell:826}, 100 de oro",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["100g"] = "100g",
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Los rangos JcJ de Forever salen de {spell:1299382} que ganas en campos de batalla y en JcJ del mundo, con un límite semanal; Comandante (rango 11) desbloquea las monturas de guerra negras. Polestar no puede leer tu rango, así que este paso espera al nivel 40 y a la habilidad de equitación.",
	-- ["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783} vende las monturas en {area:2918}, en {object:2100} de {zone:1453}, junto a los demás intendentes de honor como {npc:12805}. El cliente de Forever pone cada una a 100g; elige una.",
}
