-- German (deDE): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{item:8705} in {zone:1444}",
	-- {zone:1444} Feralas · {area:1108} Forgotten Coast
	-- plural, as words: Coast Crawl Snapclaws = {npc:5327} Coast Crawl Snapclaw · Sprite Dragons = {npc:5276} Sprite Dragon
	["Each robot starts with a distress beacon that mobs in its zone drop, about one kill in 40 to 100 in Classic's data. In {zone:1444} the best are the Coast Crawl Snapclaws and Deepseers (levels 43-45) on the {area:1108} and the Sprite Dragons (47-48), about 2.5%; ogres, harpies, naga and Grimtotems drop it about 1%. You can loot it from level 40."] = "Jeder Roboter beginnt mit einem Notsignal, das Gegner seiner Zone fallen lassen, etwa bei einem von 40 bis 100 Kills nach den Daten von Classic. In {zone:1444} sind am besten die Coast Crawl Snapclaws und Deepseers (Stufe 43-45) an der {area:1108} und die Sprite Dragons (47-48), etwa 2,5%; Oger, Harpyien, Naga und Grimmtotem lassen es mit etwa 1% fallen. Du kannst es ab Stufe 40 plündern.",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "Rette OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Right-click the beacon. OOX-22/FE sits in a cave near {area:1105}, among yetis and apes. Its escort runs west along the road to the dock on the {area:1108} with three ambushes: three yetis, then three gorillas, then four or five gnolls with a caster. Bring a friend if you are under 47. The robot keeps walking unless it is hit, so stay close; if it will not move, another player has it: wait for it to come back. Its turn-in is in {area:35}; keep the quest for later."] = "Klicke das Signal mit der rechten Maustaste an. OOX-22/FE sitzt in einer Höhle bei {area:1105}, zwischen Yetis und Affen. Seine Eskorte läuft westlich die Straße entlang zum Dock an der {area:1108} mit drei Hinterhalten: drei Yetis, dann drei Gorillas, dann vier oder fünf Gnolle mit einem Zauberer. Bring einen Freund mit, wenn du unter 47 bist. Der Roboter läuft weiter, solange er nicht getroffen wird, bleib also in der Nähe; will er sich nicht bewegen, hat ihn ein anderer Spieler: Warte, bis er zurückkommt. Seine Abgabe ist in {area:35}; behalte die Quest für später.",
	["Escort OOX-22/FE"] = "Eskortiere OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{item:8623} in {zone:1446}",
	-- {zone:1446} Tanaris
	-- plural, as words: Treasure Hunting Pirates = {npc:7899} Treasure Hunting Pirate · Ground Pounders = {npc:9396} Ground Pounder
	["{zone:1446} mobs drop OOX-17/TN's beacon about one kill in 50 to 150. Best: the Treasure Hunting Pirates and Buccaneers on the south shore (44-45) and the Ground Pounders in the north (41-43), about 2%. You can loot it from level 43."] = "Gegner in {zone:1446} lassen das Signal von OOX-17/TN etwa bei einem von 50 bis 150 Kills fallen. Am besten: die Treasure Hunting Pirates und Buccaneers am Südufer (44-45) und die Ground Pounders im Norden (41-43), etwa 2%. Du kannst es ab Stufe 43 plündern.",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "Rette OOX-17/TN",
	-- {area:981} Gaping Chasm · {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["OOX-17/TN stands in the hills near the {area:981} in south-east {zone:1446}. Its escort to {area:977} has two ambushes: three scorpids near the start, three Wastewander bandits near the end. The robot has about 3,000 health and stops to fight what you attack, so it can tank for a moment while you recover. Its turn-in is in {area:35} too."] = "OOX-17/TN steht in den Hügeln nahe {area:981} im Südosten von {zone:1446}. Seine Eskorte nach {area:977} hat zwei Hinterhalte: drei Skorpide nahe dem Start, drei Wastewander-Banditen nahe dem Ende. Der Roboter hat etwa 3.000 Gesundheit und hält an, um gegen das zu kämpfen, was du angreifst, er kann also kurz tanken, während du dich erholst. Seine Abgabe ist ebenfalls in {area:35}.",
	["Escort OOX-17/TN"] = "Eskortiere OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{item:8704} im Gebiet {zone:1425}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs drop OOX-09/HL's beacon about once in 100 kills: Silvermane wolves, owlbeasts, Highvale elves, Witherbark and Vilebranch trolls. You can loot it from level 43."] = "Die meisten Gegner in {zone:1425} lassen das Signal von OOX-09/HL etwa bei jedem 100. Kill fallen: Silvermane-Wölfe, Eulenbiester, Highvale-Elfen, Witherbark- und Vilebranch-Trolle. Du kannst es ab Stufe 43 plündern.",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "Rette OOX-09/HL",
	-- {area:351} Skulk Rock
	-- plural, as words: Marauding Owlbeasts = {npc:7808} Marauding Owlbeast · Vilebranch Ambushers = {npc:7809} Vilebranch Ambusher
	["OOX-09/HL waits on the largest island of the lake west of {area:351}. Its escort to the shore beyond Overlook Cliff has two ambushes of three: Marauding Owlbeasts, then Vilebranch Ambushers; the robot warns you just before each."] = "OOX-09/HL wartet auf der größten Insel im See westlich von {area:351}. Seine Eskorte zum Ufer hinter Overlook Cliff hat zwei Hinterhalte zu je drei: Marauding Owlbeasts, dann Vilebranch Ambushers; der Roboter warnt dich kurz vor jedem.",
	["Escort OOX-09/HL"] = "Eskortiere OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{npc:7406} in {area:35}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {npc:2490} First Mate Crazz · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}, upstairs in the building north of the inn, above {npc:2490}. Hand in all three rescues; at level 45 he then offers {quest:3721}, which you turn straight back in for the {item:10398}."] = "{npc:7406} ist in {area:35}, oben im Gebäude nördlich des Gasthauses, über {npc:2490}. Gib alle drei Rettungen ab; auf Stufe 45 bietet er dann {quest:3721} an, die du sofort zurückgibst, um das {item:10398} zu erhalten.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "Jeder Roboter beginnt mit einem Notsignal, das Mobs in seinem Gebiet droppen (laut unseren Daten etwa 1-2,5% pro Kill). Fang in {zone:1444} an.",
	-- ["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "Die meisten Mobs im Gebiet {zone:1425} können das Signal von OOX-09/HL droppen (laut unseren Daten etwa 1-2,5% pro Kill).",
	-- ["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "Die meisten Mobs in {zone:1446} können das Signal von OOX-17/TN droppen (laut unseren Daten etwa 0,5-3% pro Kill).",
	-- ["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "Bring das Signal zu OOX-09/HL an der Flussquelle nahe {area:351} und eskortiere ihn zum Ufer hinter den Aussichtsklippen.",
	-- ["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "Bring das Signal zu OOX-17/TN in {zone:1446} und eskortiere ihn zum {area:977}. Auch seine Abgabe ist in {area:35}.",
	-- ["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "Bring das Signal zu OOX-22/FE in einer Höhle nahe {area:1105} und eskortiere ihn zum Steg im Gebiet {area:1108}. Die Abgabe ist in {area:35}; heb sie dir für später auf.",
	-- ["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406} ist in {area:35}. Sind alle drei Roboter zu Hause, bietet er {quest:3721} an; die Belohnung ist das {item:10398}. Benötigt Stufe 45.",
}
