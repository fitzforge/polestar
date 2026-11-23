-- German (deDE): the guide forever/collectibles/pets/yarlyn-amberstill (forever/collectibles/pets/yarlyn-amberstill.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:1263} Yarlyn Amberstill
	["{npc:1263}'s Rabbits"] = "Hasen von {npc:1263}",

	-- Step 1: Yarlyn Amberstill
	-- {npc:1263} Yarlyn Amberstill · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["{npc:1263} stands at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}, the ram breeder. Each rabbit crate costs 20s; the Arctic and Brown crates are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:1263} steht bei {area:803}, östlich von {area:131} an der Straße nach {zone:1432}, neben {npc:1261}, dem Widderzüchter. Jede Kaninchenkiste kostet 20s; die Kisten Arktis und Braun sind neu in Forever. Jeder Haustiergegenstand lehrt seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
	-- {item:8497} Rabbit Crate (Snowshoe)
	["{item:8497}, 20s"] = "{item:8497}, 20s",
	["20s"] = "20s",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:1263} stands at {area:803}, east of {area:131}. Each rabbit crate costs 20s; the Arctic and Brown crates are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:1263} steht beim {area:803}, östlich von {area:131}. Jeder Hasenkäfig kostet 20s; der Arktis- und der Braun-Käfig sind neu in Forever. Jeder Haustier-Gegenstand lehrt dir beim Benutzen seinen Begleiter; die Ziele bleiben danach abgehakt.",
}
