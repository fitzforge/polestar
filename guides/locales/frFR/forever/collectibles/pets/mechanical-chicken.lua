-- French (frFR): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- plural, as words: Coast Crawl Snapclaws = {npc:5327} Coast Crawl Snapclaw · Sprite Dragons = {npc:5276} Sprite Dragon
	["Each robot starts with a distress beacon that mobs in its zone drop, about one kill in 40 to 100 in Classic's data. In {zone:1444} the best are the Coast Crawl Snapclaws and Deepseers (levels 43-45) on the Forgotten Coast and the Sprite Dragons (47-48), about 2.5%; ogres, harpies, naga and Grimtotems drop it about 1%. You can loot it from level 40."] = "",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "Secourir OOX-22/FE",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["Right-click the beacon. OOX-22/FE sits in a cave near Feral Scar Vale, among yetis and apes. Its escort runs west along the road to the dock on the Forgotten Coast with three ambushes: three yetis, then three gorillas, then four or five gnolls with a caster. Bring a friend if you are under 47. The robot keeps walking unless it is hit, so stay close; if it will not move, another player has it: wait for it to come back. Its turn-in is in {object:3204}; keep the quest for later."] = "",
	["Escort OOX-22/FE"] = "Escorter OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{item:8623} à {zone:1446}",
	-- {zone:1446} Tanaris
	-- plural, as words: Treasure Hunting Pirates = {npc:7899} Treasure Hunting Pirate · Ground Pounders = {npc:9396} Ground Pounder
	["{zone:1446} mobs drop OOX-17/TN's beacon about one kill in 50 to 150. Best: the Treasure Hunting Pirates and Buccaneers on the south shore (44-45) and the Ground Pounders in the north (41-43), about 2%. You can loot it from level 43."] = "Les monstres de {zone:1446} lâchent la balise d'OOX-17/TN environ une fois sur 50 à 150. Les meilleurs : les Pirates chasseurs de trésor et les Boucaniers sur la rive sud (44-45) et les Marteleurs terrestres au nord (41-43), environ 2 %. Vous pouvez la ramasser dès le niveau 43.",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "Secourir OOX-17/TN",
	-- {zone:1446} Tanaris · {object:151975} Steamwheedle Port (no name in this language: may be words) · {object:3204} Booty Bay (no name in this language: may be words)
	["OOX-17/TN stands in the hills near the Gaping Chasm in south-east {zone:1446}. Its escort to {object:151975} has two ambushes: three scorpids near the start, three Wastewander bandits near the end. The robot has about 3,000 health and stops to fight what you attack, so it can tank for a moment while you recover. Its turn-in is in {object:3204} too."] = "",
	["Escort OOX-17/TN"] = "Escorter OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{item:8704} dans les {zone:1425}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs drop OOX-09/HL's beacon about once in 100 kills: Silvermane wolves, owlbeasts, Highvale elves, Witherbark and Vilebranch trolls. You can loot it from level 43."] = "La plupart des monstres des {zone:1425} lâchent la balise d'OOX-09/HL environ une fois sur 100 : les loups Crins-d'argent, les chouettards, les elfes de Hautval, les trolls Fânécorce et Vilebranch. Vous pouvez la ramasser dès le niveau 43.",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "Secourir OOX-09/HL",
	-- plural, as words: Marauding Owlbeasts = {npc:7808} Marauding Owlbeast · Vilebranch Ambushers = {npc:7809} Vilebranch Ambusher
	["OOX-09/HL waits on the largest island of the lake west of Skulk Rock. Its escort to the shore beyond Overlook Cliff has two ambushes of three: Marauding Owlbeasts, then Vilebranch Ambushers; the robot warns you just before each."] = "",
	["Escort OOX-09/HL"] = "Escorter OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {object:3204} Booty Bay (no name in this language: may be words)
	["{npc:7406} in {object:3204}"] = "",
	-- {npc:7406} Oglethorpe Obnoticus · {object:3204} Booty Bay (no name in this language: may be words) · {npc:2490} First Mate Crazz · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {object:3204}, upstairs in the building north of the inn, above {npc:2490}. Hand in all three rescues; at level 45 he then offers {quest:3721}, which you turn straight back in for the {item:10398}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "Chaque robot commence par une balise de détresse que laissent tomber les monstres de sa zone (environ 1-2.5% par mort selon nos données). Commencez à {zone:1444}.",
	-- ["Each robot starts with a distress beacon that mobs in its zone drop, about one kill in 40 to 100 in Classic's data. In {zone:1444} the best are the Coast Crawl Snapclaws and Deepseers (levels 43-45) on the {area:1108} and the Sprite Dragons (47-48), about 2.5%; ogres, harpies, naga and Grimtotems drop it about 1%. You can loot it from level 40."] = "Chaque robot commence par une balise de détresse que lâchent les monstres de sa zone, environ une fois sur 40 à 100 d'après les données de Classic. En {zone:1444}, les meilleurs sont les Claque-pinces côtiers et les Voyants des profondeurs (niveau 43-45) sur la {area:1108} et les Petits dragons féeriques (47-48), environ 2,5 % ; les ogres, les harpies, les nagas et les Totems-sinistres la lâchent environ 1 % du temps. Vous pouvez la ramasser dès le niveau 40.",
	-- ["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "La plupart des monstres des {zone:1425} peuvent laisser tomber la balise d'OOX-09/HL (environ 1-2.5% par mort selon nos données).",
	-- ["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "La plupart des monstres de {zone:1446} peuvent laisser tomber la balise d'OOX-17/TN (environ 0.5-3% par mort selon nos données).",
	-- ["OOX-09/HL waits on the largest island of the lake west of {area:351}. Its escort to the shore beyond Overlook Cliff has two ambushes of three: Marauding Owlbeasts, then Vilebranch Ambushers; the robot warns you just before each."] = "OOX-09/HL attend sur la plus grande île du lac à l'ouest du {area:351}. Son escorte jusqu'au rivage au-delà d'Overlook Cliff compte deux embuscades de trois : des Chouettards maraudeurs, puis des Embusqués Vilebranch ; le robot vous prévient juste avant chacune.",
	-- ["OOX-17/TN stands in the hills near the {area:981} in south-east {zone:1446}. Its escort to {area:977} has two ambushes: three scorpids near the start, three Wastewander bandits near the end. The robot has about 3,000 health and stops to fight what you attack, so it can tank for a moment while you recover. Its turn-in is in {area:35} too."] = "OOX-17/TN se tient dans les collines près du {area:981}, au sud-est de {zone:1446}. Son escorte jusqu'à {area:977} compte deux embuscades : trois scorpides près du départ, trois bandits Bat-le-désert près de l'arrivée. Le robot a environ 3 000 points de vie et s'arrête pour combattre ce que vous attaquez : il peut donc encaisser un moment pendant que vous récupérez. Sa quête se rend aussi à {area:35}.",
	-- ["Right-click the beacon. OOX-22/FE sits in a cave near {area:1105}, among yetis and apes. Its escort runs west along the road to the dock on the {area:1108} with three ambushes: three yetis, then three gorillas, then four or five gnolls with a caster. Bring a friend if you are under 47. The robot keeps walking unless it is hit, so stay close; if it will not move, another player has it: wait for it to come back. Its turn-in is in {area:35}; keep the quest for later."] = "Faites un clic droit sur la balise. OOX-22/FE se trouve dans une grotte près du {area:1105}, parmi des yétis et des singes. Son escorte file vers l'ouest par la route jusqu'au quai de la {area:1108}, avec trois embuscades : trois yétis, puis trois gorilles, puis quatre ou cinq gnolls avec un lanceur de sorts. Venez avec un ami si vous êtes en dessous du niveau 47. Le robot continue de marcher tant qu'il n'est pas frappé, restez donc près de lui ; s'il refuse de bouger, un autre joueur l'escorte : attendez qu'il revienne. Sa quête se rend à {area:35} ; gardez-la pour plus tard.",
	-- ["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "Apportez la balise à OOX-09/HL à la source de la rivière près du {area:351}, puis escortez-le jusqu'au rivage au-delà des Hauts-Surplombs.",
	-- ["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "Apportez la balise à OOX-17/TN à {zone:1446}, puis escortez-le jusqu'à {area:977}. Cette quête se rend aussi à {area:35}.",
	-- ["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "Apportez la balise à OOX-22/FE dans une grotte près du {area:1105}, puis escortez-le jusqu'au quai de la {area:1108}. La quête se rend à {area:35} ; gardez-la pour plus tard.",
	-- ["{npc:7406} in {area:35}"] = "{npc:7406} à {area:35}",
	-- ["{npc:7406} is in {area:35}, upstairs in the building north of the inn, above {npc:2490}. Hand in all three rescues; at level 45 he then offers {quest:3721}, which you turn straight back in for the {item:10398}."] = "{npc:7406} est à {area:35}, à l'étage du bâtiment au nord de l'auberge, au-dessus de {npc:2490}. Rendez les trois sauvetages ; au niveau 45, il propose ensuite {quest:3721}, que vous lui rendez aussitôt contre le {item:10398}.",
	-- ["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406} est à {area:35}. Une fois les trois robots rentrés, il propose {quest:3721}, qui récompense par le {item:10398} ; niveau 45 requis.",
}
