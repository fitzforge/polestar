-- German (deDE): the guide forever/collectibles/pets/halpa (forever/collectibles/pets/halpa.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8401} Halpa
	-- plural, as words: Prairie Dogs = {npc:2620} Prairie Dog
	["{npc:8401}'s Prairie Dogs"] = "Präriehunde von {npc:8401}",

	-- Step 1: Halpa
	-- {npc:8401} Halpa · {zone:1456} Thunder Bluff
	["{npc:8401} sells three whistles in {zone:1456} (50s each); the two ground squirrels are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8401} verkauft in {zone:1456} drei Pfeifen (je 50s); die beiden Erdhörnchen sind neu in Forever. Jeder Haustiergegenstand lehrt dich seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
	-- {item:10394} Prairie Dog Whistle
	["{item:10394}, 50s"] = "{item:10394}, 50s",
	["50s"] = "50s",
}
