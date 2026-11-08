-- German (deDE): the guide forever/collectibles/pets/narkk (forever/collectibles/pets/narkk.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:2663} Narkk
	["{npc:2663}'s Parrots"] = "Papageien von {npc:2663}",

	-- Step 1: Narkk
	-- {npc:2663} Narkk · {object:3204} Booty Bay (no name in this language: may be words) · {npc:2664} Kelsey Yance
	["{npc:2663}, the pirate supplier in {object:3204}, sells two parrots (40s each), with no stock limit. He stands next to {npc:2664}, the cook. {object:3204} is neutral: the boat from Ratchet and the Stranglethorn road both arrive there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "",
	-- {item:8495} Parrot Cage (Senegal)
	["{item:8495}, 40s"] = "{item:8495}, 40s",
	-- {item:8496} Parrot Cage (Cockatiel)
	["{item:8496}, 40s"] = "{item:8496}, 40s",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:2663}, the pirate supplier in {area:35}, sells two parrots (40s each). {area:35} is neutral: the boat from {area:392} and the Stranglethorn road both arrive there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:2663}, der Piratenausrüster in {area:35}, verkauft zwei Papageien (je 40s). {area:35} ist neutral: Das Boot aus {area:392} und die Straße durchs Schlingendorntal kommen beide dort an. Jeder Haustier-Gegenstand lehrt dir beim Benutzen seinen Begleiter; die Ziele bleiben danach abgehakt.",
}
