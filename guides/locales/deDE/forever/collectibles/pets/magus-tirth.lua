-- German (deDE): the guide forever/collectibles/pets/magus-tirth (forever/collectibles/pets/magus-tirth.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {item:11023} Ancona Chicken · {area:484} Freewind Post · {area:976} Gadgetzan · {zone:1446} Tanaris
	["{npc:6548} at the {area:2240}, the goblin and gnome racetrack in the {area:439} of south-eastern {zone:1441}, sells the {item:11023} (1g) to both sides. The nearest flight paths are {area:484} (Horde) and {area:976} in {zone:1446} (both sides); from {area:976}, ride north into the {area:439}. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "{npc:6548} an der {area:2240}, der Goblin- und Gnomen-Rennstrecke in den {area:439} im Südosten von {zone:1441}, verkauft die {item:11023} (1g) an beide Seiten. Die nächsten Flugrouten sind {area:484} (Horde) und {area:976} in {zone:1446} (beide Seiten); von {area:976} reite nach Norden in die {area:439}. Jeder Haustiergegenstand lehrt seinen Begleiter, wenn du ihn benutzt; das Ziel bleibt danach abgehakt.",
	-- {item:11023} Ancona Chicken
	["{item:11023}, 1g"] = "{item:11023}, 1g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:6548} at the {area:2240}, in the {area:439} of south-eastern {zone:1441}, sells the {item:11023} (1g). Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:6548} auf der {area:2240} in {area:439} im Südosten von {zone:1441} verkauft {item:11023} (1g). Jeder Haustiergegenstand lehrt dich seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
}
