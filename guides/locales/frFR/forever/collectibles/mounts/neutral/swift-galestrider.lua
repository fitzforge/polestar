-- French (frFR): the guide forever/collectibles/mounts/neutral/swift-galestrider (forever/collectibles/mounts/neutral/swift-galestrider.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Galestrider"] = "Swift Galestrider",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (compagnon)",
	-- {skill:762} Riding
	["Swift Galestriders need level 60 and Journeyman {skill:762}. Train it at your own race's riding trainer; see the Level 60 mount guides for where."] = "Les trotteurs des trombes rapides demandent le niveau 60 et la {skill:762} (compagnon). Apprenez-la auprès du maître de monte de votre race ; les guides de montures du niveau 60 indiquent où.",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Aéronef depuis {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} est l'île de départ des Éolides ; tout le monde peut s'y rendre. Un aéronef part du côté nord de {area:279} environ toutes les cinq minutes (un autre part du nord de {zone:1456} ; les deux factions peuvent prendre l'un ou l'autre). Passez ceci si vous êtes déjà sur l'île.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Aéronef vers {zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Aéronef depuis {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} est l'île de départ des Éolides ; tout le monde peut s'y rendre. Un aéronef part des falaises au sud de {area:17045}, au nord de {zone:1456}, environ toutes les cinq minutes (un autre part de {area:279} ; les deux factions peuvent prendre l'un ou l'autre). Passez ceci si vous êtes déjà sur l'île.",

	-- Step 4: Journeyman Riding with Genn Fairweather
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["Journeyman {skill:762} with {npc:265756}"] = "{skill:762} (compagnon) auprès de {npc:265756}",
	-- {skill:762} Riding · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Skyborne train Journeyman {skill:762} with {npc:265756} himself for 1,000g; Blizzard says it comes with a mount. He stands at the {area:17684} in {area:16638}, near the skyboat docks."] = "Les Éolides apprennent la {skill:762} (compagnon) auprès de {npc:265756} lui-même pour 1 000 po ; d'après Blizzard, elle s'accompagne d'une monture. Il se tient aux {area:17684}, à {area:16638}, près des quais des brise-ciel.",
	-- {npc:265756} Genn Fairweather
	["{npc:265756}, riding trainer"] = "{npc:265756}, maître de monte",

	-- Step 5: Galestrider Riding for other races
	-- {spell:1285849} Galestrider Riding
	["{spell:1285849} for other races"] = "{spell:1285849} pour les autres races",
	-- {spell:1285849} Galestrider Riding · {skill:762} Riding · {npc:265756} Genn Fairweather
	["Any race can buy Galestriders, but riding one also takes {spell:1285849}, which only the Skyborne get with {skill:762}. Other races can learn it too, but how is not known yet: in Classic another race's riding needed Exalted with its home faction, here the High Order (Alliance) or the Windshapers (Horde). Ask {npc:265756} before you buy."] = "Toute race peut acheter des trotteurs des trombes, mais en monter un demande aussi {spell:1285849}, que seuls les Éolides reçoivent avec la {skill:762}. Les autres races peuvent aussi l'apprendre, mais on ne sait pas encore comment : dans Classic, la monte d'une autre race demandait d'être Exalté auprès de sa faction d'origine, ici le Haut ordre (Alliance) ou les Façonneurs-de-vent (Horde). Demandez à {npc:265756} avant d'acheter.",

	-- Step 6: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756} is at the {area:17684} in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756} est aux {area:17684}, à {area:16638}, le port de l'île, près des quais des brise-ciel. Le client Forever affiche chaque trotteur des trombes rapide à 200 po ; choisissez-en un.",
	["200g"] = "200 po",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Swift Galestriders need level 60 and Journeyman {skill:762} from a riding trainer of your faction; see the Level 60 mount guides for where."] = "Les Swift Galestriders exigent le niveau 60 et {skill:762} (compagnon) auprès d'un maître d'équitation de votre faction ; voir les guides des montures de niveau 60 pour savoir où.",
	-- ["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Swift Galestrider at 200g; choose one."] = "{npc:265756} est à {area:16638}, la ville portuaire de l'île, près des quais des aéronefs. Le client Forever affiche chaque Swift Galestrider à 200 po ; choisissez-en un.",
}
