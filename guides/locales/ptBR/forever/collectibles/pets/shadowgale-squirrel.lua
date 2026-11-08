-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/shadowgale-squirrel (forever/collectibles/pets/shadowgale-squirrel.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	["Skyboat from Dalaran"] = "",
	-- {zone:2521} Zephras Isle · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the north side of Dalaran about every five minutes (another flies from north of {zone:1456}; either faction may take either)."] = "",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste para {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste de {zone:1456}",
	-- {zone:2521} Zephras Isle · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the cliffs south of Skywatcher Plateau, north of {zone:1456}, about every five minutes (another flies from Dalaran; either faction may take either)."] = "",

	-- Step 3: Revered with the Nightclaw Druids
	-- {faction:2758} Nightclaw Druids
	["Revered with the {faction:2758}"] = "Reverenciado com {faction:2758}",
	-- {npc:254151} Vayn Moongaze · {npc:257944} Elegael Thornpaw · {faction:2758} Nightclaw Druids
	-- plural, as words: Al'Aketh Cultist's Ears = {item:258771} Al'Aketh Cultist's Ear · Nightclaw Druids = {npc:254152} Nightclaw Druid
	["{npc:254151}, the druids' quartermaster, waits inside their den in the Shadowgale Forest, the cave just north-east of {npc:257944}'s camp. He sells the squirrel (50s) once you are Revered with the {faction:2758}. Get there young: the Shadowgale storyline and {npc:254151}'s first ear quest take you to Friendly, and his repeatable pays 1000 for five Al'Aketh Cultist's Ears up to level 18 but, by Classic's rules, only 200 from level 22. From Friendly to Revered that is about 80 ears at level 18 and about 400 at 22 or above. The Nightclaw Druids Reputation guide walks you through it."] = "",
	["50s"] = "50s",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Skyboat from {area:279}"] = "Barco celeste de {area:279}",
	-- ["{npc:254151} sells the squirrel (50s) once you are Revered with the {faction:2758}."] = "{npc:254151} vende o esquilo (50s) quando você estiver Reverenciado com {faction:2758}.",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} é a ilha inicial dos Celonatos; qualquer um pode visitá-la. Um barco celeste parte dos penhascos ao sul de {area:17045}, ao norte de {zone:1456}, a cada cinco minutos, mais ou menos (outro sai de {area:279}; qualquer facção pode usar qualquer uma). Pule isto se já estiver na ilha.",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} é a ilha inicial dos Celonatos; qualquer um pode visitá-la. Um barco celeste parte do lado norte de {area:279} a cada cinco minutos, mais ou menos (outro sai do norte de {zone:1456}; qualquer facção pode usar qualquer uma). Pule isto se já estiver na ilha.",
}
