-- German (deDE): the guide forever/collectibles/mounts/neutral/galestrider (forever/collectibles/mounts/neutral/galestrider.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Galestrider"] = "Windschreiter",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Reiten lernen",
	-- {skill:762} Riding
	["Galestriders need level 40 and {skill:762}. Train it at your own race's riding trainer; see the Level 40 mount guides for where."] = "Galestrider brauchen Stufe 40 und {skill:762}. Lerne es beim Reitlehrer deiner eigenen Rasse; wo, steht in den Guides für Reittiere der Stufe 40.",

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

	-- Step 4: Riding with Genn Fairweather
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["{skill:762} with {npc:265756}"] = "{skill:762} bei {npc:265756}",
	-- {skill:762} Riding · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Skyborne learn {skill:762} from {npc:265756} himself for 100g, and it comes with a Galestrider. He stands at the {area:17684} in {area:16638}, near the skyboat docks."] = "Himmelsgeborene lernen {skill:762} bei {npc:265756} selbst für 100g, und ein Galestrider gehört dazu. Er steht an den {area:17684} in {area:16638}, nahe den Docks der Himmelsboote.",
	-- {npc:265756} Genn Fairweather
	["{npc:265756}, riding trainer"] = "{npc:265756}, Reitlehrer",

	-- Step 5: Galestrider Riding for other races
	-- {spell:1285849} Galestrider Riding
	["{spell:1285849} for other races"] = "{spell:1285849} für andere Rassen",
	-- {spell:1285849} Galestrider Riding · {skill:762} Riding · {npc:265756} Genn Fairweather
	["Any race can buy Galestriders, but riding one also takes {spell:1285849}, which only the Skyborne get with {skill:762}. Other races can learn it too, but how is not known yet: in Classic another race's riding needed Exalted with its home faction, here the High Order (Alliance) or the Windshapers (Horde). Ask {npc:265756} before you buy."] = "Jede Rasse kann Galestrider kaufen, aber um einen zu reiten, braucht man auch {spell:1285849}, das nur die Himmelsgeborenen mit {skill:762} bekommen. Andere Rassen können es ebenfalls lernen, aber wie, ist noch nicht bekannt: In Classic brauchte das Reiten einer anderen Rasse Ehrfürchtig bei deren Heimatfraktion, hier die Hohe Ordnung (Allianz) oder die Windformer (Horde). Frag {npc:265756}, bevor du kaufst.",

	-- Step 6: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756} is at the {area:17684} in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Galestrider at 20g; choose one."] = "{npc:265756} ist an den {area:17684} in {area:16638}, der Hafenstadt der Insel, nahe den Docks der Himmelsboote. Der Forever-Client führt jeden Galestrider für 20g; such dir einen aus.",
	["20g"] = "20g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Galestriders need level 40 and {skill:762} ({spell:1285849} comes with it in the Forever client). Any riding trainer of your faction teaches it; see the Level 40 mount guides for where."] = "Windschreiter erfordern Stufe 40 und {skill:762} ({spell:1285849} gibt es im Forever-Client dazu). Jeder Reitlehrer deiner Fraktion lehrt es; wo, steht in den Guides für Reittiere mit Stufe 40.",
	-- ["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Galestrider at 20g; choose one."] = "{npc:265756} ist in {area:16638}, der Hafenstadt der Insel, nahe den Anlegestellen der Himmelsboote. Der Forever-Client führt jeden Windschreiter für 20g; wähle einen.",
}
