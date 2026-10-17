-- Spanish (Spain) (esES): the guide forever/collectibles/mounts/neutral/galestrider (forever/collectibles/mounts/neutral/galestrider.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Galestrider"] = "Zancavendavales",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Aprende a montar",
	-- {skill:762} Riding · {spell:1285849} Galestrider Riding
	["Galestriders need level 40 and {skill:762} ({spell:1285849} comes with it in the Forever client). Any riding trainer of your faction teaches it; see the Level 40 mount guides for where."] = "Los zancavendavales requieren nivel 40 y {skill:762} (en el cliente de Forever, {spell:1285849} viene incluida). Te la enseña cualquier instructor de equitación de tu facción; consulta dónde en las guías de monturas de nivel 40.",

	-- Step 2: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Barco celeste desde {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} es la isla de inicio de los cielonatos; cualquiera puede visitarla. Un barco celeste sale del lado norte de {area:279} cada cinco minutos aprox. (otro vuela desde el norte de {zone:1456}; cualquier facción puede tomar cualquiera). Sáltate esto si ya estás en la isla.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste a {zone:2521}",

	-- Step 3: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste desde {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} es la isla de inicio de los cielonatos; cualquiera puede visitarla. Un barco celeste sale de los acantilados al sur de {area:17045}, al norte de {zone:1456}, cada cinco minutos aprox. (otro vuela desde {area:279}; cualquier facción puede tomar cualquiera). Sáltate esto si ya estás en la isla.",

	-- Step 4: Genn Fairweather
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["{npc:265756} is in {area:16638}, the island's harbour town, near the skyboat docks. The Forever client lists each Galestrider at 20g; choose one."] = "{npc:265756} está en {area:16638}, el pueblo portuario de la isla, cerca de los muelles de los barcos celestes. El cliente de Forever pone cada zancavendavales a 20 o; elige uno.",
	["20g"] = "20 o",
}
