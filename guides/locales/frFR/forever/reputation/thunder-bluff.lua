-- French (frFR): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "Réputation : Thunder Bluff",

	-- Step 1: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {faction:81} Thunder Bluff · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728} accepte le tissu pour {faction:81}, à {faction:81}. Les premiers dons de laine, de soie, de tisse-mage et de {item:14047} (60 tissus chacun) ne se font qu'une fois et rapportent le plus de réputation par tissu ; ensuite, {quest:7825} se répète jusqu'à Exalté. Être Exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Les Massacreurs de la KapitalRisk de la {area:381} (niveau 16-17) en laissent tomber ici. L'Hôtel des ventes convient aussi.",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Les Centaures kolkar (niveau 30-33) en laissent tomber ici. L'Hôtel des ventes convient aussi.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les Ogres Cognedune (niveau 45-48) en laissent tomber ici. L'Hôtel des ventes convient aussi.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) en laissent tomber ici ; chaque Fléau tué ici compte aussi pour {object:92525} (voir ce guide). L'Hôtel des ventes convient aussi.",

	-- Step 9: Rumstag Proudstrider: Runecloth delivered
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth
	["{npc:14728}: {item:14047} delivered"] = "{npc:14728} : {item:14047} livré",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825} jusqu'à Honoré",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825} demande 20 {item:14047} par rendu et se répète autant que vous voulez. Apportez du {item:14047} par multiples de 20 et rendez tout d'un coup, un rendu après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'Hôtel des ventes.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825} jusqu'à Révéré",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7825}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'Hôtel des ventes.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825} jusqu'à Exalté",
	-- {quest:7825} Additional Runecloth · {faction:81} Thunder Bluff · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7825} jusqu'à être Exalté auprès de {faction:81}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'Hôtel des ventes.",
}
