-- Spanish (Spain) (esES): the guide forever/class/shaman/call-of-water-alliance (forever/class/shaman/call-of-water-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94494} Call of Water
	["{quest:94494} (Alliance)"] = "{quest:94494} (Alianza)",
	-- {item:5177} Water Totem · {spell:5394} Healing Stream Totem
	["The {item:5177} that lets you place water totems, and {spell:5394} with it."] = "{item:5177}, que te permite colocar tótems de agua, y con él {spell:5394}.",

	-- Step 1: Eldrun Stormbreaker
	-- {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258043} Norric Lochthane · {zone:1432} Loch Modan
	["At 20 {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:258043} in {zone:1432}."] = "A nivel 20, {npc:258098}, el instructor de chamanes de {zone:1455}, te envía con {npc:258043} en {zone:1432}.",

	-- Step 2: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {area:146} Stonewrought Dam
	["{npc:258043}'s burrow hut stands on the north-western edge of the loch, south of {area:146}."] = "La cabaña excavada de {npc:258043} está en la orilla noroeste del lago, al sur de {area:146}.",

	-- Step 3: Hervdana Saegrund
	-- {npc:258203} Hervdana Saegrund · {zone:1437} Wetlands
	["{npc:258203}'s family lives in a cave beneath the southern falls of the {zone:1437}."] = "La familia de {npc:258203} vive en una cueva bajo las cascadas del sur de {zone:1437}.",

	-- Step 4: The brown waterskin
	["The brown waterskin"] = "El odre marrón",
	-- {item:265732} Unfilled Brown Waterskin · {npc:258203} Hervdana Saegrund
	["Fill the {item:265732} at the bottom of the waterfalls below {npc:258203}'s cave, where the fresh water meets the brackish."] = "Llena {item:265732} al pie de las cascadas bajo la cueva de {npc:258203}, donde el agua dulce se junta con la salobre.",

	-- Step 6: The red waterskin
	["The red waterskin"] = "El odre rojo",
	-- {area:71} Stonewatch Falls · {area:68} Lake Everstill · {item:265747} Unfilled Red Waterskin
	-- plural, as words: Murloc Nightcrawlers = {npc:544} Murloc Nightcrawler
	["{area:71} pour out of {area:68} at the east end of Redridge. Fill the {item:265747} at their foot, where the Murloc Nightcrawlers gather."] = "{area:71} brotan de {area:68}, en el extremo este de las Montañas Crestagrana. Llena {item:265747} a su pie, donde se reúnen los reptanoches múrloc.",

	-- Step 8: The blue waterskin
	["The blue waterskin"] = "El odre azul",
	-- {npc:258203} Hervdana Saegrund · {area:150} Menethil Harbor · {area:442} Auberdine · {area:271} Southshore · {area:415} Astranaar · {item:265772} Unfilled Blue Waterskin
	["{npc:258203}: take the boat from {area:150} to {area:442} (it stops in {area:271} on the way), then go south to {area:415}. Fill the {item:265772} in the lake around the town."] = "{npc:258203}: toma el barco de {area:150} a {area:442} (para en {area:271} por el camino) y luego ve al sur hasta {area:415}. Llena {item:265772} en el lago que rodea el pueblo.",

	-- Step 9: Hervdana Saegrund
	-- {item:7810} Vial of Purest Water · {npc:258043} Norric Lochthane
	["the {item:7810}, for {npc:258043}"] = "{item:7810}, para {npc:258043}",

	-- Step 10: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {item:6637} Water Sapta
	["{npc:258043}: your {item:6637}"] = "{npc:258043}: tu {item:6637}",

	-- Step 11: Stendel's Pond
	-- {area:919} Stendel's Pond · {area:20} Moonbrook · {item:6637} Water Sapta · {npc:5894} Corrupt Minor Manifestation of Water · {item:7811} Remaining Drops of Purest Water · {object:619896} Forgotten Shrine · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water
	["{area:919} lies outside {area:20}. Drink the {item:6637} there and defeat the {npc:5894} for its bracers, then place them and the {item:7811} on the {object:619896}. The {npc:5895} it calls forth gives you the {item:7813}."] = "{area:919} está a las afueras de {area:20}. Bebe allí {item:6637} y derrota a {npc:5894} para conseguir sus brazales; después colócalos junto con {item:7811} en {object:619896}. {npc:5895} que aparece te da {item:7813}.",
	-- {npc:5895} Minor Manifestation of Water
	["{npc:5895}, at the shrine"] = "{npc:5895}, en el santuario",

	-- Step 12: Norric Lochthane
	-- {npc:258043} Norric Lochthane · {spell:5394} Healing Stream Totem · {item:5177} Water Totem
	["{npc:258043}: {spell:5394} and your {item:5177}"] = "{npc:258043}: {spell:5394} y tu {item:5177}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:71} pour out of {area:68} at the east end of Redridge. Fill the {item:265747} at their foot, where the Murloc {item:6530} gather."] = "{area:71} brotan de {area:68}, en el extremo este de las Montañas Crestagrana. Llena {item:265747} a su pie, donde se reúnen los múrlocs ({item:6530}).",
}
