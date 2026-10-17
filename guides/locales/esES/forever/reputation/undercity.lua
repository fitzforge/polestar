-- Spanish (Spain) (esES): the guide forever/reputation/undercity (forever/reputation/undercity.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Undercity Reputation"] = "Reputación: Entrañas",

	-- Step 1: Ralston Farnsley: A Donation of Wool
	-- {npc:14729} Ralston Farnsley · {faction:68} Undercity · {item:14047} Runecloth · {quest:7819} Additional Runecloth
	["{npc:14729} takes cloth for {faction:68} in {faction:68}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7819} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14729} recoge paño para {faction:68} en {faction:68}. Las primeras donaciones de lana, seda, paño mágico y {item:14047} (60 paños cada una) se hacen una sola vez y dan la mayor reputación por paño; después, {quest:7819} se repite hasta Exaltado. Ser Exaltado con la ciudad de otra raza te permite comprar sus monturas. La ventaja de Legado Diplomático de Forever aumenta la reputación que ganas.",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Lo sueltan los Déspotas de Ventura y Cía. de la {area:381} (nivel 16-17). También puedes comprarlo en la casa de subastas.",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Lo sueltan los centauros Kolkar de aquí (nivel 30-33). También puedes comprarlo en la casa de subastas.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Lo sueltan los ogros Machacaduna de aquí (nivel 45-48). También puedes comprarlo en la casa de subastas.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Lo sueltan los Adeptos oscuros y Magos oscuros de aquí (nivel 58-60); cada miembro de la Plaga que mates aquí también cuenta para la reputación con {object:92525} (consulta esa guía). También puedes comprarlo en la casa de subastas.",

	-- Step 9: Ralston Farnsley: Runecloth delivered
	-- {npc:14729} Ralston Farnsley · {item:14047} Runecloth
	["{npc:14729}: {item:14047} delivered"] = "{npc:14729}: {item:14047} entregado",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Honored"] = "{quest:7819} hasta Honorable",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7819} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7819} pide 20 de {item:14047} por entrega y se repite tantas veces como quieras. Lleva {item:14047} en múltiplos de 20 y entrégalo todo de una vez, una entrega tras otra. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Revered"] = "{quest:7819} hasta Venerado",
	-- {quest:7819} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7819}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7819}, 20 de {item:14047} cada vez. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7819} Additional Runecloth
	["{quest:7819} to Exalted"] = "{quest:7819} hasta Exaltado",
	-- {quest:7819} Additional Runecloth · {faction:68} Undercity · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7819} until {faction:68} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7819} hasta llegar a Exaltado con {faction:68}. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
}
