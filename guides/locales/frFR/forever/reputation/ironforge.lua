-- French (frFR): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "Réputation : Forgefer",

	-- Step 1: Mistina Steelshield: A Donation of Wool
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723} prend les étoffes pour {faction:47} à {faction:47}. Les premiers dons d'étoffe de laine, de soie, de tisse-mage et d'{item:14047} (60 étoffes chacun) se font une fois et donnent le plus de réputation par étoffe ; ensuite, {quest:7806} se répète jusqu'à Exalté. Être Exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",

	-- Step 2: Wool Cloth
	-- plural, as words: Riverpaw Bandits = {npc:452} Riverpaw Bandit
	["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Les Bandits et Sous-chefs Rivepatte (niveau 16-18) en lâchent ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 4: Silk Cloth
	["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Les Mercenaires du Syndicat du Donjon de Stromgarde (niveau 31-32) en lâchent ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en lâchent ici. L'hôtel des ventes fonctionne aussi.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et Ombremages (niveau 58-60) en lâchent ici ; chaque Fléau tué ici compte aussi pour l'{object:92525} (voir ce guide). L'hôtel des ventes fonctionne aussi.",

	-- Step 9: Mistina Steelshield: Runecloth delivered
	-- {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["{npc:14723}: {item:14047} delivered"] = "{npc:14723} : {item:14047} livrée",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806} jusqu'à Honoré",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806} prend 20 {item:14047} par remise et se répète à volonté. Apportez l'{item:14047} par multiples de 20 et rendez tout d'un coup, une remise après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806} jusqu'à Révéré",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7806}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806} jusqu'à Exalté",
	-- {quest:7806} Additional Runecloth · {faction:47} Ironforge · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7806} jusqu'à être Exalté auprès de {faction:47}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
}
