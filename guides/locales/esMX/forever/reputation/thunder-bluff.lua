-- Spanish (Latin America) (esMX): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "Reputación: Cima del Trueno",

	-- Step 1: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {faction:81} Thunder Bluff · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728} acepta paño para {faction:81} en {faction:81}. Las primeras donaciones de Paño de lana, Paño de seda, Paño de tejido mágico y {item:14047} (60 paños cada una) se hacen una sola vez y dan la mayor reputación por paño; después, {quest:7825} se repite hasta Exaltado. Ser Exaltado con la ciudad de otra raza te permite comprar las monturas de esa raza. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Los Déspotas de Ventura y Cía. de {area:381} (nivel 16-17) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Los Centauros Kolkar (nivel 30-33) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Los Ogros Machacaduna (nivel 45-48) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Los Adeptos oscuros y Magos oscuros (nivel 58-60) lo sueltan aquí; cada muerte de la Plaga aquí también cuenta para {object:92525} (consulta esa guía). También sirve la casa de subastas.",

	-- Step 9: Rumstag Proudstrider: Runecloth delivered
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth
	["{npc:14728}: {item:14047} delivered"] = "{npc:14728}: {item:14047} entregado",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825} hasta Honorable",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825} pide 20 {item:14047} por entrega y se repite cuantas veces quieras. Lleva {item:14047} en múltiplos de 20 y entrégalos todos de una vez, una entrega tras otra. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825} hasta Reverenciado",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7825}, 20 {item:14047} cada vez. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825} hasta Exaltado",
	-- {quest:7825} Additional Runecloth · {faction:81} Thunder Bluff · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Sigue entregando {quest:7825} hasta ser Exaltado con {faction:81}. {item:14047}: Adeptos oscuros y Magos oscuros (nivel 58-60) en {zone:1423}, o la casa de subastas.",
}
