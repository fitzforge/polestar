-- German (deDE): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{item:8705} in {zone:1444}",
	-- {zone:1444} Feralas
	["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "Jeder Roboter beginnt mit einem Notsignal, das Mobs in seinem Gebiet droppen (laut unseren Daten etwa 1-2,5% pro Kill). Fang in {zone:1444} an.",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "Rette OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "Bring das Signal zu OOX-22/FE in einer Höhle nahe {area:1105} und eskortiere ihn zum Steg im Gebiet {area:1108}. Die Abgabe ist in {area:35}; heb sie dir für später auf.",
	["Escort OOX-22/FE"] = "Eskortiere OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{item:8623} in {zone:1446}",
	-- {zone:1446} Tanaris
	["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "Die meisten Mobs in {zone:1446} können das Signal von OOX-17/TN droppen (laut unseren Daten etwa 0,5-3% pro Kill).",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "Rette OOX-17/TN",
	-- {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "Bring das Signal zu OOX-17/TN in {zone:1446} und eskortiere ihn zum {area:977}. Auch seine Abgabe ist in {area:35}.",
	["Escort OOX-17/TN"] = "Eskortiere OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{item:8704} im Gebiet {zone:1425}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "Die meisten Mobs im Gebiet {zone:1425} können das Signal von OOX-09/HL droppen (laut unseren Daten etwa 1-2,5% pro Kill).",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "Rette OOX-09/HL",
	-- {area:351} Skulk Rock
	["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "Bring das Signal zu OOX-09/HL an der Flussquelle nahe {area:351} und eskortiere ihn zum Ufer hinter den Aussichtsklippen.",
	["Escort OOX-09/HL"] = "Eskortiere OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{npc:7406} in {area:35}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406} ist in {area:35}. Sind alle drei Roboter zu Hause, bietet er {quest:3721} an; die Belohnung ist das {item:10398}. Benötigt Stufe 45.",
}
