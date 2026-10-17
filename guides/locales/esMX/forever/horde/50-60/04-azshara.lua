-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}, {object:172960}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}, {object:172957}: guárdala para {zone:1451}",

	-- Step 2: Fly to the Crossroads
	-- {area:380} Crossroads
	["Fly to the {area:380}"] = "Vuela a {area:380}",

	-- Step 3: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "Las cajas de {npc:256386}",
	-- {npc:256386} Dokimi · {area:380} Crossroads
	["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386} está en {area:380}. Abre cada caja que te dé y llévale lo que hay adentro.",

	-- Step 4: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",

	-- Step 5: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "El taller de Liv está en el extremo norte de los muelles de {area:392}; {object:149036} está adentro.",
	-- {object:149036} Marvon's Chest · {item:10556} Stone Circle
	["Open {object:149036} for the {item:10556}"] = "Abre {object:149036} para obtener {item:10556}",

	-- Step 6: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901} acampa en la orilla justo al norte de {area:392}.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "El agua purificada va a {area:2479}, en {zone:1448}: guárdala para después.",

	-- Step 7: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",

	-- Step 8: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "En {object:172961}. Lleva el paño de lana, de seda y de tejido mágico en tus bolsas.",

	-- Step 9: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "En {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "Las dos donaciones de {item:14047} se entregan más adelante en la ruta: empieza a guardar {item:14047}.",

	-- Step 10: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "Vuela a {area:1237}",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "Cabalga al este hasta las ruinas de la costa. Llena los cuatro viales de Cuely en las pozas de marea a lo largo de la orilla; las nagas Látigo de Ira patrullan entre ellas.",

	-- Step 13: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "Los elfos de sangre acampan en los acantilados del noreste, junto a {area:1227}.",

	-- Step 14: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Campamento de {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "El campamento de Rimtori está en el extremo este del campamento base. Lee {object:151286} allí y luego mata al Magus.",

	-- Step 15: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "Regresa cabalgando al oeste a {area:1237}.",

	-- Step 16: Belgrom Rockmaul
	-- {area:1637} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["Fly to {area:1637}; {npc:4485} is in the {object:172958}."] = "Vuela a {area:1637}; {npc:4485} está en {object:172958}.",

	-- Step 17: Zeppelin to the Undercity
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "Zepelín a {zone:1458}",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "La torre de zepelín está justo al noreste de la puerta principal de {zone:1454}; toma el zepelín a {zone:1458}.",
	["Zeppelin tower"] = "Torre del zepelín",

	-- Step 18: The Apothecarium
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}, a su lado",

	-- Step 19: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}, cerca",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050} regresa con {npc:10778} en {zone:1422}: guárdala.",

	-- Step 21: Prompt Potion Runner
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}, en la botica real",
}
