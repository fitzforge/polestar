-- French (frFR): the guide forever/collectibles/pets/halpa (forever/collectibles/pets/halpa.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8401} Halpa
	-- plural, as words: Prairie Dogs = {npc:2620} Prairie Dog
	["{npc:8401}'s Prairie Dogs"] = "Chiens de prairie de {npc:8401}",

	-- Step 1: Halpa
	-- {npc:8401} Halpa · {zone:1456} Thunder Bluff
	["{npc:8401} sells three whistles in {zone:1456} (50s each); the two ground squirrels are new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8401} vend trois sifflets aux {zone:1456} (50 pa chacun) ; les deux écureuils terrestres sont nouveaux dans Forever. Chaque objet de mascotte apprend sa compagnie quand vous l'utilisez ; les objectifs restent cochés ensuite.",
	-- {item:10394} Prairie Dog Whistle
	["{item:10394}, 50s"] = "{item:10394}, 50 pa",
	["50s"] = "50 pa",
}
