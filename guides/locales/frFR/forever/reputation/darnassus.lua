-- French (frFR): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "Réputation : Darnassus",

	-- Step 1: Raedon Duskstriker: A Donation of Wool
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {item:14047} Runecloth · {quest:7801} Additional Runecloth
	["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725} recueille le tissu pour {faction:69}, à {faction:69}. Les premiers dons de laine, de soie, de tisse-mage et de {item:14047} (60 étoffes chacun) ne se font qu'une fois et rapportent le plus de réputation par étoffe ; ensuite, {quest:7801} se répète jusqu'à Exalté. Être Exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",

	-- Step 2: Wool Cloth
	-- plural, as words: Riverpaw Bandits = {npc:452} Riverpaw Bandit
	["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Les Bandits et Sous-chefs Rivepatte (niveau 16-18) en lâchent ici. L'hôtel des ventes convient aussi.",

	-- Step 4: Silk Cloth
	["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Les Mercenaires du Syndicat au Donjon de Stromgarde (niveau 31-32) en lâchent ici. L'hôtel des ventes convient aussi.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en lâchent ici. L'hôtel des ventes convient aussi.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) en lâchent ici ; chaque Fléau tué ici compte aussi pour {object:92525} (voir ce guide). L'hôtel des ventes convient aussi.",

	-- Step 9: Raedon Duskstriker: Runecloth delivered
	-- {npc:14725} Raedon Duskstriker · {item:14047} Runecloth
	["{npc:14725}: {item:14047} delivered"] = "{npc:14725} : {item:14047} livrée",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801} jusqu'à Honoré",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801} demande 20 {item:14047} par rendu et se répète autant que vous voulez. Apportez du {item:14047} par multiples de 20 et rendez tout d'un coup, un rendu après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans {zone:1423}, ou l'hôtel des ventes.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801} jusqu'à Révéré",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7801}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans {zone:1423}, ou l'hôtel des ventes.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801} jusqu'à Exalté",
	-- {quest:7801} Additional Runecloth · {faction:69} Darnassus · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7801} jusqu'à être Exalté auprès de {faction:69}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans {zone:1423}, ou l'hôtel des ventes.",
}
