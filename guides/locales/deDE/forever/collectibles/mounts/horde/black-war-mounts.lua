-- German (deDE): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
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
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General · {skill:762} Riding
	["{spell:1299382} come from battlegrounds, PvP quests and the season's weekly tasks, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. The Player vs. Player tab of your character pane shows your rank and what you may buy. {skill:762} one at full speed needs Journeyman {skill:762} (level 60). Polestar cannot read your rank, so this step waits for level 60 and Journeyman {skill:762}."] = "{spell:1299382} stammen aus Schlachtfeldern, PvP-Quests und den Wochenaufgaben der Saison, mit einer Wochengrenze; {spell:436438} (Rang 11) schaltet die Schwarzen Kriegsreittiere frei. Der Reiter-Tab im PvP-Reiter deines Charakterfensters zeigt deinen Rang und was du kaufen darfst. Um eines davon mit voller Geschwindigkeit zu reiten ({skill:762}), brauchst du {skill:762} (Geselle) (Stufe 60). Polestar kann deinen Rang nicht lesen, deshalb wartet dieser Schritt auf Stufe 60 und {skill:762} (Geselle).",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["{npc:12796} sells the mounts by the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters. The Forever client lists each at 100g. Each one also needs its kind's riding: Orcs ride the wolf, Trolls the raptor, Tauren the kodo, Undead the skeletal warhorse. A Skyborne, or anyone choosing another race's mount, first needs that riding from its trainer (Exalted with the race's city)."] = "{npc:12796} verkauft die Reittiere bei der {area:2917} in der {object:172958} von {zone:1454}, neben den anderen Ehren-Rüstmeistern. Der Forever-Client führt jedes für 100g. Jedes braucht außerdem das Reiten seiner Art: Orcs reiten den Wolf, Trolle den Raptor, Tauren den Kodo, Untote das Skeletal Warhorse. Ein Himmelsgeborener oder jeder, der das Reittier einer anderen Rasse wählt, braucht dieses Reiten zuerst bei dessen Lehrer (Ehrfürchtig bei der Stadt der Rasse).",
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
	-- ["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Die PvP-Ränge in Forever kommen von {spell:1299382} aus Schlachtfeldern und Welt-PvP, mit wöchentlicher Obergrenze; {spell:436438} (Rang 11) schaltet die schwarzen Kriegsreittiere frei. Polestar kann deinen Rang nicht auslesen, daher wartet dieser Schritt auf Stufe 40 und die Reitfertigkeit.",
	-- ["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796} verkauft die Reittiere in der {area:2917} im {object:172958} von {zone:1454}, neben den anderen Ehrenrüstmeistern wie {npc:12799}. Der Forever-Client listet jedes für 100g; wähle eins.",
}
