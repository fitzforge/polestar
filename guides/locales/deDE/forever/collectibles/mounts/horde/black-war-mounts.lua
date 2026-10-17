-- German (deDE): the guide forever/collectibles/mounts/horde/black-war-mounts (forever/collectibles/mounts/horde/black-war-mounts.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {spell:1299382} Rank Points · {spell:436438} Lieutenant General
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; {spell:436438} (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "Die PvP-Ränge in Forever kommen von {spell:1299382} aus Schlachtfeldern und Welt-PvP, mit wöchentlicher Obergrenze; {spell:436438} (Rang 11) schaltet die schwarzen Kriegsreittiere frei. Polestar kann deinen Rang nicht auslesen, daher wartet dieser Schritt auf Stufe 40 und die Reitfertigkeit.",

	-- Step 2: Raider Bork
	-- {npc:12796} Raider Bork · {area:2917} Hall of Legends · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:12799} Sergeant Ba'sha
	["{npc:12796} sells the mounts in the {area:2917} in {zone:1454}'s {object:172958}, beside the other honor quartermasters such as {npc:12799}. The Forever client lists each at 100g; choose one."] = "{npc:12796} verkauft die Reittiere in der {area:2917} im {object:172958} von {zone:1454}, neben den anderen Ehrenrüstmeistern wie {npc:12799}. Der Forever-Client listet jedes für 100g; wähle eins.",
	["100g"] = "100g",
}
