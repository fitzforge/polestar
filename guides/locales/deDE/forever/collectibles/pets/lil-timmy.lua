-- German (deDE): the guide forever/collectibles/pets/lil-timmy (forever/collectibles/pets/lil-timmy.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Lil Timmy
	-- {npc:8666} Lil Timmy · {npc:7386} White Kitten
	["{npc:8666} sells the {npc:7386} (60s). He walks around the city, so the waypoint is only one point on his path; look along the nearby streets if he is not there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8666} verkauft {npc:7386} (60s). Er läuft durch die Stadt, daher ist der Wegpunkt nur ein Punkt auf seinem Weg; sieh in den Straßen in der Nähe nach, falls er nicht dort ist. Jeder Haustiergegenstand lehrt dich seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
	-- {item:8489} Cat Carrier (White Kitten)
	["{item:8489}, 60s"] = "{item:8489}, 60s",
}
