-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{item:8705} em {zone:1444}",
	-- {zone:1444} Feralas
	["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "Cada robô começa com um transmissor de emergência que os monstros da zona dele derrubam (cerca de 1-2,5% por abate em nossos dados). Comece em {zone:1444}.",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "Resgate OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "Leve o transmissor até OOX-22/FE, numa caverna perto de {area:1105}, e escolte-o até o cais em {area:1108}. A entrega é em {area:35}; guarde-a para depois.",
	["Escort OOX-22/FE"] = "Escolte OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{item:8623} em {zone:1446}",
	-- {zone:1446} Tanaris
	["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "A maioria dos monstros de {zone:1446} pode derrubar o transmissor de OOX-17/TN (cerca de 0,5-3% por abate em nossos dados).",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "Resgate OOX-17/TN",
	-- {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "Leve o transmissor até OOX-17/TN em {zone:1446} e escolte-o até {area:977}. A entrega também é em {area:35}.",
	["Escort OOX-17/TN"] = "Escolte OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{item:8704} em {zone:1425}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "A maioria dos monstros de {zone:1425} pode derrubar o transmissor de OOX-09/HL (cerca de 1-2,5% por abate em nossos dados).",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "Resgate OOX-09/HL",
	-- {area:351} Skulk Rock
	["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "Leve o transmissor até OOX-09/HL, na nascente do rio perto de {area:351}, e escolte-o até a praia depois dos Penhascos Panorâmicos.",
	["Escort OOX-09/HL"] = "Escolte OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{npc:7406} em {area:35}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406} está em {area:35}. Com os três robôs em casa, ele oferece {quest:3721}, cuja recompensa é o {item:10398}; exige nível 45.",
}
