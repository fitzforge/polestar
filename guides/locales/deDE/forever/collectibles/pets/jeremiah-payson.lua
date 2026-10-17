-- German (deDE): the guide forever/collectibles/pets/jeremiah-payson (forever/collectibles/pets/jeremiah-payson.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}'s Cockroaches"] = "Kakerlaken von {npc:8403}",

	-- Step 1: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson · {zone:1458} Undercity
	["{npc:8403} sells three cockroaches in the {zone:1458} (50s each); the Plagued and Undercity Cockroaches are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8403} verkauft drei Kakerlaken in {zone:1458} (je 50s); die Verseuchte Kakerlake und die Kakerlake von Undercity sind neu in Forever. Jeder Haustiergegenstand lehrt dich beim Benutzen seinen Begleiter; die Ziele bleiben danach abgehakt.",
	-- {item:10393} Cockroach
	["{item:10393}, 50s"] = "{item:10393}, 50s",
	["50s"] = "50s",
}
