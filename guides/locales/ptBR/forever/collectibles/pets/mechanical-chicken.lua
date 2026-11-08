-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- plural, as words: Coast Crawl Snapclaws = {npc:5327} Coast Crawl Snapclaw · Sprite Dragons = {npc:5276} Sprite Dragon
	["Each robot starts with a distress beacon that mobs in its zone drop, about one kill in 40 to 100 in Classic's data. In {zone:1444} the best are the Coast Crawl Snapclaws and Deepseers (levels 43-45) on the Forgotten Coast and the Sprite Dragons (47-48), about 2.5%; ogres, harpies, naga and Grimtotems drop it about 1%. You can loot it from level 40."] = "",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "Resgate OOX-22/FE",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["Right-click the beacon. OOX-22/FE sits in a cave near Feral Scar Vale, among yetis and apes. Its escort runs west along the road to the dock on the Forgotten Coast with three ambushes: three yetis, then three gorillas, then four or five gnolls with a caster. Bring a friend if you are under 47. The robot keeps walking unless it is hit, so stay close; if it will not move, another player has it: wait for it to come back. Its turn-in is in {object:3204}; keep the quest for later."] = "",
	["Escort OOX-22/FE"] = "Escolte OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{item:8623} em {zone:1446}",
	-- {zone:1446} Tanaris
	-- plural, as words: Treasure Hunting Pirates = {npc:7899} Treasure Hunting Pirate · Ground Pounders = {npc:9396} Ground Pounder
	["{zone:1446} mobs drop OOX-17/TN's beacon about one kill in 50 to 150. Best: the Treasure Hunting Pirates and Buccaneers on the south shore (44-45) and the Ground Pounders in the north (41-43), about 2%. You can loot it from level 43."] = "",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "Resgate OOX-17/TN",
	-- {zone:1446} Tanaris · {object:151975} Steamwheedle Port (no name in this language: may be words) · {object:3204} Booty Bay (no name in this language: may be words)
	["OOX-17/TN stands in the hills near the Gaping Chasm in south-east {zone:1446}. Its escort to {object:151975} has two ambushes: three scorpids near the start, three Wastewander bandits near the end. The robot has about 3,000 health and stops to fight what you attack, so it can tank for a moment while you recover. Its turn-in is in {object:3204} too."] = "",
	["Escort OOX-17/TN"] = "Escolte OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{item:8704} em {zone:1425}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs drop OOX-09/HL's beacon about once in 100 kills: Silvermane wolves, owlbeasts, Highvale elves, Witherbark and Vilebranch trolls. You can loot it from level 43."] = "",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "Resgate OOX-09/HL",
	-- plural, as words: Marauding Owlbeasts = {npc:7808} Marauding Owlbeast · Vilebranch Ambushers = {npc:7809} Vilebranch Ambusher
	["OOX-09/HL waits on the largest island of the lake west of Skulk Rock. Its escort to the shore beyond Overlook Cliff has two ambushes of three: Marauding Owlbeasts, then Vilebranch Ambushers; the robot warns you just before each."] = "",
	["Escort OOX-09/HL"] = "Escolte OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {object:3204} Booty Bay (no name in this language: may be words)
	["{npc:7406} in {object:3204}"] = "",
	-- {npc:7406} Oglethorpe Obnoticus · {object:3204} Booty Bay (no name in this language: may be words) · {npc:2490} First Mate Crazz · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {object:3204}, upstairs in the building north of the inn, above {npc:2490}. Hand in all three rescues; at level 45 he then offers {quest:3721}, which you turn straight back in for the {item:10398}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "Cada robô começa com um transmissor de emergência que os monstros da zona dele derrubam (cerca de 1-2,5% por abate em nossos dados). Comece em {zone:1444}.",
	-- ["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "A maioria dos monstros de {zone:1425} pode derrubar o transmissor de OOX-09/HL (cerca de 1-2,5% por abate em nossos dados).",
	-- ["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "A maioria dos monstros de {zone:1446} pode derrubar o transmissor de OOX-17/TN (cerca de 0,5-3% por abate em nossos dados).",
	-- ["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "Leve o transmissor até OOX-09/HL, na nascente do rio perto de {area:351}, e escolte-o até a praia depois dos Penhascos Panorâmicos.",
	-- ["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "Leve o transmissor até OOX-17/TN em {zone:1446} e escolte-o até {area:977}. A entrega também é em {area:35}.",
	-- ["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "Leve o transmissor até OOX-22/FE, numa caverna perto de {area:1105}, e escolte-o até o cais em {area:1108}. A entrega é em {area:35}; guarde-a para depois.",
	-- ["{npc:7406} in {area:35}"] = "{npc:7406} em {area:35}",
	-- ["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406} está em {area:35}. Com os três robôs em casa, ele oferece {quest:3721}, cuja recompensa é o {item:10398}; exige nível 45.",
}
