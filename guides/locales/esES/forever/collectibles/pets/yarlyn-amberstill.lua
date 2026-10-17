-- Spanish (Spain) (esES): the guide forever/collectibles/pets/yarlyn-amberstill (forever/collectibles/pets/yarlyn-amberstill.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:1263} Yarlyn Amberstill
	["{npc:1263}'s Rabbits"] = "Conejos de {npc:1263}",

	-- Step 1: Yarlyn Amberstill
	-- {npc:1263} Yarlyn Amberstill · {area:803} Amberstill Ranch · {area:131} Kharanos
	["{npc:1263} stands at {area:803}, east of {area:131}. Each rabbit crate costs 20s; the Arctic and Brown crates are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:1263} está en {area:803}, al este de {area:131}. Cada cajón de conejos cuesta 20 p; los cajones ártico y marrón son nuevos en Forever. Cada objeto de mascota te enseña su compañero al usarlo; los objetivos siguen marcados después.",
	-- {item:8497} Rabbit Crate (Snowshoe)
	["{item:8497}, 20s"] = "{item:8497}, 20 p",
	["20s"] = "20 p",
}
