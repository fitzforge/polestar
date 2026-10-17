-- Russian (ruRU): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{item:8705} — зона {zone:1444}",
	-- {zone:1444} Feralas
	["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "Каждый робот начинается с аварийного маячка, который падает с существ его зоны (по нашим данным примерно 1-2,5% за убийство). Начните с зоны {zone:1444}.",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "Спасите КПX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "Отнесите маячок к КПX-22/FE в пещеру у места {area:1105}, затем сопроводите робота до причала (локация: {area:1108}). Задание сдается в месте {area:35}; оставьте его на потом.",
	["Escort OOX-22/FE"] = "Сопроводите КПX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{item:8623} — зона {zone:1446}",
	-- {zone:1446} Tanaris
	["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "Маячок КПХ-17/TN может выпасть с большинства существ зоны {zone:1446} (по нашим данным примерно 0,5-3% за убийство).",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "Спасите КПХ-17/TN",
	-- {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "Отнесите маячок к КПХ-17/TN (зона {zone:1446}), затем сопроводите робота до места {area:977}. Его задание тоже сдается в месте {area:35}.",
	["Escort OOX-17/TN"] = "Сопроводите КПХ-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{item:8704} — зона {zone:1425}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "Маячок КПХ-9/HL может выпасть с большинства существ зоны {zone:1425} (по нашим данным примерно 1-2,5% за убийство).",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "Спасите КПХ-9/HL",
	-- {area:351} Skulk Rock
	["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "Отнесите маячок к КПХ-9/HL в верховье реки у места {area:351}, затем сопроводите робота до берега за Отвесными скалами.",
	["Escort OOX-09/HL"] = "Сопроводите КПХ-9/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{npc:7406} — {area:35}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406} находится здесь: {area:35}. Когда все три робота дома, он предлагает задание {quest:3721}; награда — {item:10398}, нужен 45-й уровень.",
}
