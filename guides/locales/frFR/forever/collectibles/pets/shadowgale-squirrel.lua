-- French (frFR): the guide forever/collectibles/pets/shadowgale-squirrel (forever/collectibles/pets/shadowgale-squirrel.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Aéronef depuis {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either)."] = "L'{zone:2521} est l'île de départ des Éolides ; d'après les retours de la bêta, tout le monde peut la visiter. Un brise-ciel part du côté nord de {area:279} environ toutes les cinq minutes (un autre vole depuis le nord des {zone:1456} ; chaque faction peut prendre l'un ou l'autre).",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Aéronef vers {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Aéronef depuis les {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either)."] = "L'{zone:2521} est l'île de départ des Éolides ; d'après les retours de la bêta, tout le monde peut la visiter. Un brise-ciel part des falaises au sud du {area:17045}, au nord des {zone:1456}, environ toutes les cinq minutes (un autre vole depuis {area:279} ; chaque faction peut prendre l'un ou l'autre).",

	-- Step 3: Revered with the Nightclaw Druids
	-- {faction:2758} Nightclaw Druids
	["Revered with the {faction:2758}"] = "Révéré auprès des {faction:2758}",
	-- {npc:254151} Vayn Moongaze · {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw · {faction:2758} Nightclaw Druids
	-- plural, as words: Al'Aketh Cultist's Ears = {item:258771} Al'Aketh Cultist's Ear · Nightclaw Druids = {npc:254152} Nightclaw Druid
	["{npc:254151}, the druids' quartermaster, waits inside their den in the {area:16631}, the cave just north-east of {npc:257944}'s camp. He sells the squirrel (50s) once you are Revered with the {faction:2758}. Get there young: the Shadowgale storyline and {npc:254151}'s first ear quest take you to Friendly, and his repeatable pays 1000 for five Al'Aketh Cultist's Ears up to level 18 but, by Classic's rules, only 200 from level 22. From Friendly to Revered that is about 80 ears at level 18 and about 400 at 22 or above. The Nightclaw Druids Reputation guide walks you through it."] = "{npc:254151}, l'intendant des druides, attend dans leur antre de la {area:16631}, la grotte juste au nord-est du camp de {npc:257944}. Il vend l'écureuil (50 pa) une fois que vous êtes Révéré auprès des {faction:2758}. Allez-y jeune : l'histoire de Shadowgale et la première quête d'oreilles de {npc:254151} vous amènent à Amical, et sa quête répétable rapporte 1000 points pour cinq oreilles de sectateur d'Al'Aketh jusqu'au niveau 18 mais, selon les règles de Classic, seulement 200 à partir du niveau 22. D'Amical à Révéré, cela fait environ 80 oreilles au niveau 18 et environ 400 au niveau 22 ou plus. Le guide de réputation des Druides Nightclaw vous accompagne.",
	["50s"] = "50 pa",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:254151} sells the squirrel (50s) once you are Revered with the {faction:2758}."] = "{npc:254151} vend l'écureuil (50 pa) une fois Révéré auprès des {faction:2758}.",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} est l'île de départ des Éolides ; tout le monde peut s'y rendre. Un aéronef part des falaises au sud du {area:17045}, au nord des {zone:1456}, environ toutes les cinq minutes (un autre part de {area:279} ; chaque faction peut prendre l'un ou l'autre). Passez cette étape si vous êtes déjà sur l'île.",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} est l'île de départ des Éolides ; tout le monde peut s'y rendre. Un aéronef part du nord de {area:279} environ toutes les cinq minutes (un autre part du nord des {zone:1456} ; chaque faction peut prendre l'un ou l'autre). Passez cette étape si vous êtes déjà sur l'île.",
}
