-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{item:8705} en {zone:1444}",
	-- {zone:1444} Feralas
	["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "Cada robot empieza con un localizador de emergencia que sueltan los enemigos de su zona (un 1-2.5% por muerte según nuestros datos). Empieza en {zone:1444}.",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "Rescata a OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "Lleva el localizador a OOX-22/FE, en una cueva cerca de {area:1105}, y escóltalo hasta el muelle de {area:1108}. Su entrega es en {area:35}; déjala para después.",
	["Escort OOX-22/FE"] = "Escolta a OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{item:8623} en {zone:1446}",
	-- {zone:1446} Tanaris
	["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "Casi todos los enemigos de {zone:1446} pueden soltar el localizador de OOX-17/TN (un 0.5-3% por muerte según nuestros datos).",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "Rescata a OOX-17/TN",
	-- {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "Lleva el localizador a OOX-17/TN en {zone:1446} y escóltalo hasta {area:977}. Su entrega también es en {area:35}.",
	["Escort OOX-17/TN"] = "Escolta a OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{item:8704} en {zone:1425}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "Casi todos los enemigos de {zone:1425} pueden soltar el localizador de OOX-09/TI (un 1-2.5% por muerte según nuestros datos).",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "Rescata a OOX-09/TI",
	-- {area:351} Skulk Rock
	["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "Lleva el localizador a OOX-09/TI, en el nacimiento del río cerca de {area:351}, y escóltalo hasta la orilla más allá de Los Acantilados Dominantes.",
	["Escort OOX-09/HL"] = "Escolta a OOX-09/TI",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{npc:7406} en {area:35}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406} está en {area:35}. Con los tres robots en casa, te ofrece {quest:3721}, cuya recompensa es la {item:10398}; requiere nivel 45.",
}
