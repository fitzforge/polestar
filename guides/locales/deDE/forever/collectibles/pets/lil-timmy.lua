-- German (deDE): the guide forever/collectibles/pets/lil-timmy (forever/collectibles/pets/lil-timmy.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Lil Timmy
	-- {npc:8666} Lil Timmy · {npc:7386} White Kitten · {object:2098} Cathedral Square · {object:2096} Trade District · {object:2100} Old Town · {object:28027} Dwarven District
	["{npc:8666} sells the {npc:7386} (60s). He starts at {object:2098} and walks through the {object:2096}, {object:2100} and the {object:28027} before he vanishes near the square again; if he is not around, wait for him at {object:2098}. By beta reports he carries one kitten at a time: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "{npc:8666} verkauft das {npc:7386} (60s). Er beginnt bei {object:2098} und geht durch die {object:2096}, {object:2100} und das {object:28027}, bevor er in der Nähe des Platzes wieder verschwindet; ist er nicht da, warte bei {object:2098} auf ihn. Laut Beta-Berichten hat er ein Kätzchen auf einmal: Hat er keines, hat es gerade jemand gekauft. Jeder Haustiergegenstand lehrt seinen Begleiter, wenn du ihn benutzt; das Ziel bleibt danach abgehakt.",
	-- {item:8489} Cat Carrier (White Kitten)
	["{item:8489}, 60s"] = "{item:8489}, 60s",

	-- Step 2: Xaphod Bizznox
	-- {npc:7386} White Kitten · {npc:262471} Xaphod Bizznox · {area:2539} Malaka'jin · {zone:1442} Stonetalon Mountains · {zone:1413} Barrens
	["Horde players buy the {npc:7386} (60s) from {npc:262471}, a trader new in Forever, at {area:2539}, the Darkspear camp at the southern tip of {zone:1442}, on the way up from the {zone:1413}. He keeps one kitten at a time: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "Hordenspieler kaufen das {npc:7386} (60s) bei {npc:262471}, einem neuen Händler in Forever, bei {area:2539}, dem Lager der Darkspear an der Südspitze von {zone:1442}, auf dem Weg hinauf aus der {zone:1413}. Er hat ein Kätzchen auf einmal: Hat er keines, hat es gerade jemand gekauft. Jeder Haustiergegenstand lehrt seinen Begleiter, wenn du ihn benutzt; das Ziel bleibt danach abgehakt.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8666} sells the {npc:7386} (60s). He walks around the city, so the waypoint is only one point on his path; look along the nearby streets if he is not there. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8666} verkauft {npc:7386} (60s). Er läuft durch die Stadt, daher ist der Wegpunkt nur ein Punkt auf seinem Weg; sieh in den Straßen in der Nähe nach, falls er nicht dort ist. Jeder Haustiergegenstand lehrt dich seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
}
