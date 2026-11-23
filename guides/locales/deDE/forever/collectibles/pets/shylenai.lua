-- German (deDE): the guide forever/collectibles/pets/shylenai (forever/collectibles/pets/shylenai.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8665} Shylenai
	["{npc:8665}'s Owls"] = "Eulen von {npc:8665}",

	-- Step 1: Shylenai
	-- {npc:8665} Shylenai · {area:1659} Craftsmen's Terrace · {zone:1457} Darnassus · {item:280803} Eagle Owl
	["{npc:8665}, the owl trainer, stands on the {area:1659} in {zone:1457}, beside the food and general goods vendors. She sells three owls (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665}, die Eulenlehrerin, steht auf der {area:1659} in {zone:1457}, neben den Händlern für Essen und allgemeine Waren. Sie verkauft drei Eulen (je 50s); die {item:280803} ist neu in Forever. Jeder Haustiergegenstand lehrt seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
	-- {item:8500} Great Horned Owl
	["{item:8500}, 50s"] = "{item:8500}, 50s",
	-- {item:8501} Hawk Owl
	["{item:8501}, 50s"] = "{item:8501}, 50s",
	["50s"] = "50s",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8665} sells three owls in {zone:1457} (50s each); the {item:280803} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8665} verkauft drei Eulen in {zone:1457} (je 50s); der {item:280803} ist neu in Forever. Jeder Haustier-Gegenstand lehrt dir beim Benutzen seinen Begleiter; die Ziele bleiben danach abgehakt.",
}
