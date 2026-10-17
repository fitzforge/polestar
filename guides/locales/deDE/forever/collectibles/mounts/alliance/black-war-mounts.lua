-- German (deDE): the guide forever/collectibles/mounts/alliance/black-war-mounts (forever/collectibles/mounts/alliance/black-war-mounts.guide).
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
	-- {spell:1299382} Rank Points
	["Forever's PvP ranks come from {spell:1299382} earned in battlegrounds and world PvP, with a weekly cap; Commander (rank 11) unlocks the Black War mounts. Polestar cannot read your rank, so this step waits for level 40 and the riding skill."] = "In Forever kommen PvP-Ränge aus {spell:1299382}, die du in Schlachtfeldern und im Welt-PvP verdienst, mit wöchentlicher Obergrenze; Kommandant (Rang 11) schaltet die schwarzen Kriegsreittiere frei. Polestar kann deinen Rang nicht auslesen, daher wartet dieser Schritt auf Stufe 40 und die Reitfertigkeit.",

	-- Step 2: Lieutenant Karter
	-- {npc:12783} Lieutenant Karter · {area:2918} Champions' Hall · {zone:1453} Stormwind · {object:2100} Old Town · {npc:12805} Officer Areyn
	["{npc:12783} sells the mounts in the {area:2918} in {zone:1453}'s {object:2100}, beside the other honor quartermasters such as {npc:12805}. The Forever client lists each at 100g; choose one."] = "{npc:12783} verkauft die Reittiere in der {area:2918} in der {object:2100} von {zone:1453}, neben den anderen Ehren-Rüstmeistern wie {npc:12805}. Der Forever-Client listet jedes für 100g; wähle eins.",
	["100g"] = "100g",
}
