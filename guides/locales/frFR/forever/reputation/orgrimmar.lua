-- French (frFR): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "Réputation : Orgrimmar",

	-- Step 1: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {faction:76} Orgrimmar · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726} prend les étoffes pour {faction:76} à {faction:76}. Les premiers dons d'Etoffe de laine, d'Etoffe de soie, d'Etoffe de tisse-mage et de {item:14047} (60 étoffes chacun) ne se font qu'une fois et donnent le plus de réputation par étoffe ; ensuite, {quest:7832} se répète jusqu'à Exalté. Être exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Les Massacreurs de la KapitalRisk de {area:381} (niveau 16-17) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Les centaures kolkar (niveau 30-33) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) en laissent tomber ici ; chaque mort du Fléau ici compte aussi pour {object:92525} (voir ce guide). L'hôtel des ventes fonctionne aussi.",

	-- Step 9: Rashona Straglash: Runecloth delivered
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth
	["{npc:14726}: {item:14047} delivered"] = "{npc:14726} : {item:14047} livrée",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832} : Honoré",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832} prend 20 {item:14047} par remise et se répète autant que vous voulez. Apportez l'{item:14047} par multiples de 20 et rendez tout d'un coup, une remise après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832} : Révéré",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7832}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832} : Exalté",
	-- {quest:7832} Additional Runecloth · {faction:76} Orgrimmar · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7832} jusqu'à être exalté auprès de {faction:76}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",
}
