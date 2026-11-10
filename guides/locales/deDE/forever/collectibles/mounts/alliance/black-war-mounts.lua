-- German (deDE): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Black War Mounts"] = "Schwarze Kriegsreittiere",

	-- Step 1: PvP rank 11
	["PvP rank 11"] = "PvP-Rang 11",
	-- {spell:1299382} Rank Points · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "{spell:1299382} stammen aus Schlachtfeldern, PvP-Quests und den Wochenaufgaben der Saison, mit einer Wochengrenze; Kommandant (Rang 11) schaltet die Schwarzen Kriegsreittiere frei. Der Reiter-Tab im PvP-Reiter deines Charakterfensters zeigt deinen Rang und was du kaufen darfst. Um eines davon mit voller Geschwindigkeit zu reiten ({skill:762}), brauchst du {skill:762} (Geselle) (Stufe 60). Polestar kann deinen Rang nicht lesen, deshalb wartet dieser Schritt auf Stufe 60 und {skill:762} (Geselle).",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {zone:1453} Stormwind · {object:2100} Old Town · {area:2918} Champions' Hall
	["{npc:12783} sells the mounts in {zone:1453}'s {object:2100} by the {area:2918}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Humans ride the steed, Night Elves the tiger, Gnomes the battlestrider, Dwarves the ram. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12783} verkauft die Reittiere in der {object:2100} von {zone:1453} bei der {area:2918}, neben den anderen Ehren-Rüstmeistern. Der Forever-Client führt jedes für 100g. Jedes braucht außerdem das Reiten seiner Art: Menschen reiten das Ross, Nachtelfen den Tiger, Gnome den Mechanostrider, Zwerge den Widder. Ein Himmelsgeborener oder jeder, der das Reittier einer anderen Rasse wählt, braucht dieses Reiten zuerst bei dessen Lehrer (Ehrfürchtig bei der Stadt der Rasse).",
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
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "In Forever kommen PvP-Ränge aus {spell:1299382}, die du in Schlachtfeldern und im Welt-PvP verdienst, mit wöchentlicher Obergrenze; Kommandant (Rang 11) schaltet die schwarzen Kriegsreittiere frei. Polestar kann deinen Rang nicht auslesen, daher wartet dieser Schritt auf Stufe 40 und die Reitfertigkeit.",
	-- ["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783} verkauft die Reittiere in der {area:2918} in der {object:2100} von {zone:1453}, neben den anderen Ehren-Rüstmeistern wie {npc:12805}. Der Forever-Client listet jedes für 100g; wähle eins.",
}
