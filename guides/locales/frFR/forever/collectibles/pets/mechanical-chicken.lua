-- French (frFR): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{item:8705} à {zone:1444}",
	-- {zone:1444} Feralas
	["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "Chaque robot commence par une balise de détresse que laissent tomber les monstres de sa zone (environ 1-2.5% par mort selon nos données). Commencez à {zone:1444}.",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "Secourir OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "Apportez la balise à OOX-22/FE dans une grotte près du {area:1105}, puis escortez-le jusqu'au quai de la {area:1108}. La quête se rend à {area:35} ; gardez-la pour plus tard.",
	["Escort OOX-22/FE"] = "Escorter OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{item:8623} à {zone:1446}",
	-- {zone:1446} Tanaris
	["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "La plupart des monstres de {zone:1446} peuvent laisser tomber la balise d'OOX-17/TN (environ 0.5-3% par mort selon nos données).",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "Secourir OOX-17/TN",
	-- {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "Apportez la balise à OOX-17/TN à {zone:1446}, puis escortez-le jusqu'à {area:977}. Cette quête se rend aussi à {area:35}.",
	["Escort OOX-17/TN"] = "Escorter OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{item:8704} dans les {zone:1425}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "La plupart des monstres des {zone:1425} peuvent laisser tomber la balise d'OOX-09/HL (environ 1-2.5% par mort selon nos données).",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "Secourir OOX-09/HL",
	-- {area:351} Skulk Rock
	["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "Apportez la balise à OOX-09/HL à la source de la rivière près du {area:351}, puis escortez-le jusqu'au rivage au-delà des Hauts-Surplombs.",
	["Escort OOX-09/HL"] = "Escorter OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{npc:7406} à {area:35}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406} est à {area:35}. Une fois les trois robots rentrés, il propose {quest:3721}, qui récompense par le {item:10398} ; niveau 45 requis.",
}
