-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/neutral/galestrider (forever/collectibles/mounts/neutral/galestrider.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Galestrider"] = "Zancavientos",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprende a montar",
	-- {skill:762} Riding
	["Galestriders need level 40 and {skill:762}. Train it at your own race's riding trainer; see the Level 40 mount guides for where."] = "Los zancavientos piden nivel 40 y {skill:762}. Entrénala con el instructor de equitación de tu raza; las guías de monturas de nivel 40 dicen dónde.",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Barco celeste desde {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} es la isla inicial de los Cielonatos; cualquiera puede visitarla. Un barco celeste sale del lado norte de {area:279} más o menos cada cinco minutos (otro vuela desde el norte de {zone:1456}; cualquier facción puede tomar cualquiera). Omite esto si ya estás en la isla.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste a {zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste desde {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} es la isla inicial de los Cielonatos; cualquiera puede visitarla. Un barco celeste sale de los acantilados al sur de {area:17045}, al norte de {zone:1456}, más o menos cada cinco minutos (otro vuela desde {area:279}; cualquier facción puede tomar cualquiera). Omite esto si ya estás en la isla.",

	-- Step 4: Riding with Genn Fairweather
	-- {skill:762} Riding · {npc:265756} Genn Fairweather
	["{skill:762} with {npc:265756}"] = "{skill:762} con {npc:265756}",
	-- {skill:762} Riding · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Skyborne learn {skill:762} from {npc:265756} himself for 100g, and it comes with a Galestrider. He stands at the {area:17684} in {area:16638}, near the skyboat docks."] = "Los Cielonato aprenden {skill:762} con el propio {npc:265756} por 100 de oro, y viene con un zancavientos. Está en {area:17684}, en {area:16638}, cerca de los muelles de los barcos celestes.",
	-- {npc:265756} Genn Fairweather
	["{npc:265756}, riding trainer"] = "{npc:265756}, instructor de equitación",

	-- Step 5: Galestrider Riding for other races
	-- {spell:1285849} Galestrider Riding
	["{spell:1285849} for other races"] = "{spell:1285849} para otras razas",
	-- {spell:1285849} Galestrider Riding · {skill:762} Riding · {npc:265756} Genn Fairweather
	["Any race can buy Galestriders, but riding one also takes {spell:1285849}, which only the Skyborne get with {skill:762}. Other races can learn it too, but how is not known yet: in Classic another race's riding needed Exalted with its home faction, here the High Order (Alliance) or the Windshapers (Horde). Ask {npc:265756} before you buy."] = "Cualquier raza puede comprar zancavientos, pero para montar uno también hace falta {spell:1285849}, que solo los Cielonato reciben con {skill:762}. Las demás razas también pueden aprenderla, pero todavía no se sabe cómo: en Classic la equitación de otra raza pedía Exaltado con su facción de origen, aquí la Alta Orden (Alianza) o los Formavientos (Horda). Pregúntale a {npc:265756} antes de comprar.",

	-- Step 6: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756} is at the {area:17684} in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Galestrider at 20g; choose one."] = "{npc:265756} está en {area:17684}, en {area:16638}, el pueblo portuario de la isla, cerca de los muelles de los barcos celestes. El cliente de Forever lista cada zancavientos a 20 de oro; elige uno.",
	["20g"] = "20 o",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Galestriders need level 40 and {skill:762} ({spell:1285849} comes with it in the Forever client). Any riding trainer of your faction teaches it; see the Level 40 mount guides for where."] = "Los Zancavientos requieren nivel 40 y {skill:762} ({spell:1285849} viene incluida en el cliente de Forever). Cualquier instructor de equitación de tu facción la enseña; consulta dónde en las guías de monturas de nivel 40.",
	-- ["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Galestrider at 20g; choose one."] = "{npc:265756} está en {area:16638}, el pueblo portuario de la isla, cerca de los muelles de los barcos celestes. El cliente de Forever vende cada Zancavientos a 20 o; elige uno.",
}
