-- German (deDE): the guide forever/collectibles/mounts/neutral/swift-galestrider (forever/collectibles/mounts/neutral/swift-galestrider.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Galestrider"] = "Schneller Windschreiter",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {skill:762} Riding
	["Swift Galestriders need level 60 and Journeyman {skill:762} from a riding trainer of your faction; see the Level 60 mount guides for where."] = "Schnelle Windschreiter erfordern Stufe 60 und {skill:762} (Geselle) von einem Reitlehrer deiner Fraktion; wo, steht in den Reittier-Guides für Stufe 60.",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Himmelsboot von {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} ist die Startinsel der Himmelsgeborenen; jeder darf sie besuchen. Etwa alle fünf Minuten legt ein Himmelsboot an der Nordseite von {area:279} ab (ein weiteres fliegt nördlich von {zone:1456} ab; beide Fraktionen dürfen beide nehmen). Überspringe das, wenn du schon auf der Insel bist.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Himmelsboot nach {zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Himmelsboot von {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} ist die Startinsel der Himmelsgeborenen; jeder darf sie besuchen. Etwa alle fünf Minuten legt ein Himmelsboot an den Klippen südlich von {area:17045} ab, nördlich von {zone:1456} (ein weiteres fliegt von {area:279} ab; beide Fraktionen dürfen beide nehmen). Überspringe das, wenn du schon auf der Insel bist.",

	-- Step 4: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756} ist in {area:16638}, der Hafenstadt der Insel, nahe den Anlegestellen der Himmelsboote. Der Forever-Client führt jeden schnellen Windschreiter für 200g; wähle einen.",
	["200g"] = "200g",
}
