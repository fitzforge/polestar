-- Spanish (Latin America) (esMX): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "Reputación: Darnassus",

	-- Step 1: Raedon Duskstriker: A Donation of Wool
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {item:14047} Runecloth · {quest:7801} Additional Runecloth
	["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725} acepta paño para {faction:69} en {faction:69}. Las primeras donaciones de Paño de lana, Paño de seda, Paño de tejido mágico y {item:14047} (60 paños cada una) se hacen una sola vez y dan la mayor reputación por paño; después, {quest:7801} se repite hasta Exaltado. Ser Exaltado con la ciudad de otra raza te permite comprar las monturas de esa raza. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",

	-- Step 2: Wool Cloth
	-- plural, as words: Riverpaw Bandits = {npc:452} Riverpaw Bandit
	["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Los Bandidos Zarparrío y los Capataces Zarparrío (nivel 16-18) lo sueltan aquí. La casa de subastas también sirve.",

	-- Step 4: Silk Cloth
	["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Los Mercenarios de la Hermandad en Stromgarde (nivel 31-32) lo sueltan aquí. La casa de subastas también sirve.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Los Ogros Machacaduna (nivel 45-48) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Los Adeptos oscuros y Magos oscuros (nivel 58-60) lo sueltan aquí; cada muerte de la Plaga aquí también cuenta para {object:92525} (consulta esa guía). También sirve la casa de subastas.",

	-- Step 9: Raedon Duskstriker: Runecloth delivered
	-- {npc:14725} Raedon Duskstriker · {item:14047} Runecloth
	["{npc:14725}: {item:14047} delivered"] = "{npc:14725}: {item:14047} entregado",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801} hasta Honorable",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801} pide 20 {item:14047} por entrega y se repite cuantas veces quieras. Lleva {item:14047} en múltiplos de 20 y entrégalos todos de una vez, una entrega tras otra. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801} hasta Reverenciado",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7801}, 20 {item:14047} cada vez. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801} hasta Exaltado",
	-- {quest:7801} Additional Runecloth · {faction:69} Darnassus · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7801} hasta ser Exaltado con {faction:69}. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
}
