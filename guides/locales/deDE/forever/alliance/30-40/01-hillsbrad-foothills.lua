-- German (deDE): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Angerfang Encampment
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: für {npc:2104}",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Nach Südosten von Menethil zum {area:1036} der Drachenmaul: Das erste Katapult steht auf dem Weg, und das {object:671518} liegt im Lager.",

	-- Step 4: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:2091} ist ein Elite der Stufe 32: Die meisten Klassen schaffen ihn allein auf Stufe 34, aber du brauchst vielleicht Hilfe. Überspring ihn, wenn du allein bist: Die Route lässt dich die Erfahrung wieder erfarmen.\nVorsicht: Shadowcasters stehen zu beiden Seiten von ihm, und mindestens einer ist mit ihm verbunden und greift ein, wenn er gezogen wird. Nicht-Elite-Centurions und -Captains stehen verteilt um seinen Zeltring.",

	-- Step 5: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. {npc:271462}, {npc:271338}, {npc:271458} und {npc:271460} sind Elites der Stufe 32, die jeweils beschworen werden, indem du den {item:279996} neben ihnen benutzt. Überspring sie, wenn du allein bist. {npc:271462} steht in den südöstlichen Hügeln.",

	-- Step 6: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "Geh nach Nordosten zu den {area:1038}: {npc:271338} steht an den Toren (benutze {item:279996}).",

	-- Step 7: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "{area:1038}: Töte diese, sobald sie dir begegnen",
	-- {area:1036} Angerfang Encampment · {quest:98283} Carnage · {area:205} Dun Modr
	["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "Die Welpen nisten in den Hügeln nordöstlich des {area:1036}; {quest:98283} streift weiter nördlich umher, und die Razormaw-Raptoren jagen im Hochland auf dem Weg nach Norden zu {area:205}.\n{quest:98283} ist ein Elite: Eine Gruppe wird empfohlen.",

	-- Step 8: Razormaw nests
	["Razormaw nests"] = "Razormaw-Nester",
	-- {quest:98246} Trying Times · {quest:98283} Carnage
	-- plural, as words: Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["The Perfect Razormaw Eggs for {quest:98246} lie in the raptors' nests in the hills around {quest:98283}."] = "Die Perfect Razormaw Eggs für {quest:98246} liegen in den Raptornestern in den Hügeln rund um {quest:98283}.",

	-- Step 9: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "{npc:271458} steht in den Hügeln zwischen dem {area:1038} und {area:205} (benutze den {item:279996}).",

	-- Step 10: The Green Belt
	-- {area:1025} The Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the {area:1025} around {npc:1244}; one of them drops the flesh. {npc:1244} takes the quest only with {quest:98283}'s head too."] = "Maddened Rotclaws streifen durch den {area:1025} rund um {npc:1244}; einer von ihnen lässt das Fleisch fallen. {npc:1244} gibt die Quest nur, wenn du auch den Kopf von {quest:98283} hast.",

	-- Step 11: Rethiel the Greenwarden
	-- {quest:98283} Carnage
	["With {quest:98283}'s head and the flesh"] = "Mit dem Kopf von {quest:98283} und dem Fleisch",

	-- Step 12: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North along the road to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites."] = "Nach Norden entlang der Straße nach {area:205}. {npc:1071} und {npc:1075} stehen zusammen im Lager der Zwerge an der Ostseite der Straße; die Ruinen von {object:147516} westlich davon sind voller Elites.",

	-- Step 13: Captive Fire Elemental
	-- {npc:271481} Captive Fire Elemental · {object:147516} Dark Iron · {npc:1364} Balgaras the Foul · {npc:1072} Roggo Harlbarrow
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:271481} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Mitspieler dafür. Der {npc:271481} wird am äußersten Westende der Ruinen von {object:147516} festgehalten, hinter Elite-Zwergen der Stufe 27-30, und {npc:1364} (34, Elite) kann unter ihnen sein. Führ ihn nach Osten aus den Ruinen und gib ihn dann bei {npc:1072} im Lager ab. Überspring ihn, wenn du allein bist.",

	-- Step 14: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "{npc:271460} steht in den Ruinen von {area:205} (benutze den {item:279996}).",

	-- Step 15: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	-- {area:205} Dun Modr · {area:880} Thandol Span · {npc:1075} Rhag Garmason
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["North along the road from {area:205} towards the {area:880}: Ebenezer Rustlocke's corpse lies under the span. Rustlocke's parchment goes back to {npc:1075}.\nTwo elite Dark Iron Saboteurs stand by the corpse inside the span: pull them one at a time, or loot the corpse and run out."] = "Nach Norden entlang der Straße von {area:205} in Richtung {area:880}: Ebenezer Rustlockes Leiche liegt unter dem Brückenbogen. Rustlockes Pergament geht zurück an {npc:1075}.\nZwei Elite-Dark-Iron-Saboteurs stehen bei der Leiche innerhalb der Brücke: Zieh sie einzeln, oder plündere die Leiche und lauf hinaus.",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}, drinnen",
	["the same corpse"] = "dieselbe Leiche",

	-- Step 16: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "Zurück die Straße hinunter nach {area:205}: {npc:1075} will die Sprengstoffe von {object:147516} am fernen Ende der Brücke zerstört haben.",

	-- Step 17: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "Die {object:2704}",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end."] = "Über die {area:880}: Das Sprengstofflager der Dunkeleisen liegt an ihrem Arathi-Ende.",

	-- Step 18: Waterlogged Envelope
	["Underwater"] = "Unter Wasser",

	-- Step 19: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "Noch einmal {npc:1075}",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "Zurück über die Brücke und die Straße durch {area:205} nach Süden.",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe
	["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "für {npc:2700} in {area:320}, in 05-arathi-highlands",

	-- Step 21: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:270637} Howin Kindfeather
	["The root core from your {area:17732} run: {npc:1244} stands by the river, just east of {npc:270637}."] = "Der Wurzelkern aus deinem Run durch {area:17732}: {npc:1244} steht am Fluss, gleich östlich von {npc:270637}.",

	-- Step 22: Howin Kindfeather
	-- {quest:98246} Trying Times
	["{quest:98246}: the eggs"] = "{quest:98246}: die Eier",

	-- Step 23: Prospector Whelgar
	["Below ground"] = "Unter der Erde",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Für {npc:2916} in {zone:1455}, am Ende dieses Guides",

	-- Step 24: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, south of the road west."] = "{item:270865} aus deinem Run durch {area:17732}: {npc:1077} ist unter der Erde in seiner Ausgrabung, südlich der Straße nach Westen.",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}, unter der Erde",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077}: für {npc:5387} in {zone:1455}, am Ende dieses Guides",

	-- Step 25: Menethil Harbor
	["West along the road to Menethil."] = "Nach Westen die Straße entlang nach Menethil.",
	["On the top floor"] = "Im obersten Stockwerk",

	-- Step 26: Menethil Harbor
	-- {npc:4455} Red Jack Flint · {quest:1132} Fiora Longears
	["{npc:4455}, by the keep's door: for {quest:1132} in Theramore, in the next guide"] = "{npc:4455}, an der Tür der Festung: für {quest:1132} in Theramore, im nächsten Guide",

	-- Step 27: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2104} steht im obersten Stockwerk von {area:2103}: Geh drinnen nach oben, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "{npc:2104}: für {npc:270637}, zurück nach Osten entlang der Straße",

	-- Step 28: Howin Kindfeather
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "Zurück nach Osten entlang der Straße zum {area:1025}: {npc:270637} lagert zwischen den Fenrunners, direkt westlich von {npc:1244}. Dann wieder nach Westen nach Menethil zum Boot.",

	-- Step 29: Level 30.8
	["Level 30.8"] = "Stufe 30,8",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "{quest:474} übersprungen und noch unter 30,8? Töte die Bluegill-Murlocs an der Küste südlich von Menethil, bis du Stufe 30,8 hast. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:133} oder den Dungeon {area:796} (Friedhof).",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "Grinde an {npc:1418}",

	-- Step 31: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Schiff nach {area:271}",

	-- Step 32: Southshore
	-- {npc:2711} Phin Odelic · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly · {quest:98463} Talk of the Town
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side.\n{npc:2366} may not offer {quest:98463} on Forever: if she doesn't, skip it."] = "Geh vom Boot aus den Pier hinauf in die Stadt: {npc:2711} und Lieutenant Farren stehen beim Gasthaus, {npc:2430} oben, {npc:2382} östlich davon; der Flugmeister ist am Nordende, {npc:2381} und {npc:2438} zwischen ihr und dem Gasthaus, Maleb im Rathaus an der Westseite.\n{npc:2366} bietet {quest:98463} auf Forever vielleicht nicht an: Falls nicht, überspring sie.",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: Seine Spur führt nach Arathi",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "{npc:2228}, drinnen",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, im Gasthaus: für {area:35} (04-stranglethorn-vale)",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "{npc:2430}, oben",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: Die Löwen kommen später",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, von {npc:2381}",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}, drinnen",

	-- Step 33: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438} makes a yeti fur cloak for anyone who brings a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells either, so this step shows only when you carry both."] = "{npc:2438} fertigt einen Yeti-Fellumhang für alle, die einen {item:3719} ({skill:165}) und einen {item:2997} ({skill:197}) bringen; kein Händler verkauft eines von beiden, deshalb erscheint dieser Schritt nur, wenn du beide bei dir hast.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth
	["{npc:2438}, between the flight master and the inn: he wants a {item:3719} and a {item:2997} too"] = "{npc:2438}, zwischen dem Flugmeister und dem Gasthaus: Er will auch einen {item:3719} und einen {item:2997}",

	-- Step 34: Torn Fin murlocs
	["Torn Fin murlocs"] = "Murlocs der Fetzenflossen",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "Die Torn-Fin-Murlocs wimmeln im {area:295}, südwestlich von {area:271}.\nVorsicht: Ein Lager enthält eine dichte Gruppe von Oracles, die alle gemeinsam angreifen.",

	-- Step 35: Farren
	["Farren"] = "Farren",
	["Inside"] = "Drinnen",

	-- Step 36: Murloc heads
	["Murloc heads"] = "Murlocköpfe",
	["Back to the same murlocs; not every one drops a head."] = "Zurück zu denselben Murlocs; nicht jeder lässt einen Kopf fallen.",

	-- Step 38: Daggerspine naga
	["Daggerspine naga"] = "Naga der Säbelflossen",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Die Naga halten das Ufer südöstlich von {area:271}.",

	-- Step 39: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "Ein Bericht für {object:2117}; drinnen",

	-- Step 41: Southshore
	-- {npc:251493} Captain McManus · {quest:98059} Hillsbrad's Hoard · {item:279386} Sealed Company Request · {area:287} Hillsbrad · {area:271} Southshore
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave.\n{quest:98059}: {npc:251493} hands you a {item:279386} for the {area:287} council, in the farms west of {area:271}; you deliver it after the Syndicate camp."] = "{npc:251493} steht nordwestlich des Flugmeisters, auf dem Weg nach Norden zur Yetihöhle.\n{quest:98059}: {npc:251493} gibt dir einen {item:279386} für den Rat von {area:287} in den Farmen westlich von {area:271}; du lieferst ihn nach dem Lager des Syndikats ab.",

	-- Step 42: Yeti cave
	["Yeti cave"] = "Yetihöhle",
	-- {area:271} Southshore · {area:277} Foothill Caverns · {npc:13602} The Abominable Greench
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp.\nStay in the {area:277}: the cave further north has Mountain and Giant Yetis (32-34) in pairs and {npc:13602}, a level 36 elite."] = "Die Yetis leben in der Höhle in den Hügeln nördlich von {area:271}, auf dem Weg nach Norden zum Lager des Syndikats.\nBleib in {area:277}: In der Höhle weiter nördlich gibt es Berg- und Riesenyetis (32-34) in Paaren und {npc:13602}, eine Elite der Stufe 36.",

	-- Step 43: Alterac Mountains
	["Syndicate camp"] = "Syndikatslager",

	-- Step 44: Syndicate camp
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "Das Lager des Syndikats liegt an der Grenze zu Alterac im Norden von {area:287}, westlich von {area:272} (Horde); die Dokumente liegen im Lager, und seine Footpads und Thieves sind das Syndikat, das Maleb meint.",

	-- Step 45: Hillsbrad Fields
	-- {area:286} Hillsbrad Fields
	["South-west from the Syndicate camp to the {area:286} farms."] = "Südwestlich vom Lager des Syndikats zu den Farmen von {area:286}.",

	-- Step 46: Hillsbrad council
	-- {area:287} Hillsbrad
	["{area:287} council"] = "Rat von {area:287}",
	-- {item:279386} Sealed Company Request · {area:287} Hillsbrad
	["Use the {item:279386} at the {area:287} council."] = "Benutze den {item:279386} beim Rat von {area:287}.",

	-- Step 47: Snapjaws
	["Snapjaws"] = "Schnappkiefer",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Die Schnappkiefer-Schildkröten sonnen sich am Fluss östlich von {area:271}, südlich von {area:272} (Horde).",

	-- Step 49: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- {area:271} Southshore
	["{area:271} flight master"] = "Flugmeister von {area:271}",

	-- Step 50: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words)
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "{npc:1356}, {npc:2916} und {npc:5637} stehen im {object:32356}, nordöstlich des Flugmeisters.",
	["Level 30 and 32 spells"] = "Zauber der Stufen 30 und 32",

	-- Step 53: Sara Balloo
	-- {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["{npc:2695}: for King Magni, on the same {zone:1455} stop"] = "{npc:2695}: für König Magni, beim selben Halt in {zone:1455}",

	-- Step 55: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",

	-- Step 56: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "Der Käseladen im {object:2096}.",

	-- Step 57: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} wartet in der Taverne „Zum Schwein und Pfeife“ in {object:2100}; er und seine zwei Schläger greifen dich an, hören aber auf, sobald sie besiegt sind.",
	-- {npc:4961} Dashel Stonefist
	["Beat {npc:4961} and his thugs: they give up"] = "Besiege {npc:4961} und seine Schläger: Sie geben auf",

	-- Step 58: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} bildet in {object:2100} Krieger aus, neben der Taverne „Zum Schwein und Pfeife“. {npc:6236} wartet auf {area:720} im {zone:1413}, auf dem Weg nach {area:392} viel später (40-50/01).",

	-- Step 60: Cathedral of Light
	["Cathedral of Light"] = "Kathedrale des Lichts",

	-- Step 62: Mage Quarter
	-- {npc:2708} Archmage Malin · {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} and {npc:4078} are in the {object:2164}; {npc:5081} south of the {object:2101}."] = "{npc:2708} und {npc:4078} sind im {object:2164}; {npc:5081} südlich des {object:2101}.",
	-- {npc:4078} Collin Mauren · {area:2240} Mirage Raceway
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{npc:4078}: the Saltstone Basilisks at the {area:2240} drop the scales, in the next guide"] = "{npc:4078}: Die Saltstone Basilisks an der {area:2240} lassen die Schuppen fallen, im nächsten Guide",

	-- Step 63: Druid training
	["Druid training"] = "Druidenausbildung",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "{zone:1455} hat keinen Druidenlehrer: {npc:5504} steht in {zone:1453}, nordwestlich des {object:2101}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Ein neuer {item:279996}, für die vier Titanenwächter rund um das {zone:1437}",
	-- ["A report for {object:2117}"] = "Ein Bericht für {object:2117}",
	-- ["Back south down the road to the excavation site."] = "Die Straße zurück nach Süden zur Ausgrabungsstätte.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Zerstöre die vier Sätze Angriffspläne im Lager für {quest:98221}.",
	-- ["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- ["Follow the road east to {area:118}."] = "Folge der Straße nach Osten zu {area:118}.",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Folge der Straße nach Nordosten in {area:1025}: {npc:270637} lagert daneben, {npc:1244} ein Stück weiter östlich.",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Für {npc:2916} in {zone:1455}, am Ende dieses Guides",
	-- ["From {npc:2432} in {area:271}"] = "Von {npc:2432} in {area:271}",
	-- ["Golm"] = "Golm",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Nach Norden die Straße entlang nach {area:205}. {npc:271460} steht in den Ruinen (benutze {item:279996}); {npc:271481} wird auf der Westseite festgehalten: Führ ihn hinaus zu {npc:1072}.",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "Nach Nordosten zu {area:1038}: {npc:271373} werden dort festgehalten, und {npc:271338} steht an den Toren (benutze {item:279996}).",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Nimm im Ort alles mit, bevor du aufbrichst. Vom Schiff aus triffst du zuerst {npc:251493}, nordwestlich des Flugmeisters; {npc:2381} und {npc:2438} stehen zwischen Flugmeister und Gasthaus, Farren und {npc:2366} im Gasthaus, Maleb im Rathaus.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Rote Welpen füllen die Hügel westlich der Tore, Wahnsinnige Faulklauen ({npc:271334}) {area:1025}, Scharfzähne die nördlichen Hänge; Neru steht im Nordosten (benutze {item:279996}).\n{quest:98283} ist Elite: Such dir am besten eine Gruppe.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Rote Welpen füllen die Hügel westlich der Tore, Wahnsinnige Faulklauen ({npc:271334}) {area:1025}, Scharfzähne die nördlichen Hänge; {npc:271458} steht im Nordosten (benutze {item:279996}).\n{quest:98283} ist Elite: Eine Gruppe wird empfohlen.",
	-- ["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Nach Süden zum {area:1036} der Dragonmaw: Das erste Katapult steht auf dem Weg, und {object:671518} liegt im Lager.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Nach Süden zum {area:1036} des Drachenmals; {object:671518} liegt im Lager.",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Nimm die {area:2257} vom {object:28027} nach {zone:1455}.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Die Goazwärter stehen gleich westlich von Whelgars Lager: Benutze neben einem davon {item:279996}, den er dir gegeben hat.",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "Das Syndikatslager liegt an der Grenze zu Alterac im Norden von {area:287}, westlich von {area:272} (Horde); die Dokumente liegen im Lager.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Die Murlocs der Fetzenflossen drängen sich am {area:295}, südwestlich von {area:271}.",
	-- ["The Villards"] = "Die Villards",
	-- ["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "Der nächste Schritt, {quest:474}, stellt dich gegen einen Elite-Häuptling: Überspring ihn.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Die Yetis leben in der Höhle in den Hügeln nördlich von {area:271}, auf deinem Rückweg nach Süden.",
	-- ["To {area:2104}"] = "Nach {area:2104}",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "Nach Westen zu den Höfen von {area:287}: Leg {item:279386} auf den Buchhaltungstisch im Rathaus, wo {npc:2335} und die Ratsherren stehen.",
	-- ["Whelps, raptors and {npc:271458}"] = "Welpen, Raptoren und {npc:271458}",
	-- ["{area:287} town hall"] = "Rathaus von {area:287}",
	-- ["{area:287}'s town hall"] = "Rathaus von {area:287}",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, ein Elite-Raptor",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} steht in {area:2103}; {npc:2094} und {npc:270844} stehen zusammen am Nordtor.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} steht in {area:2103}; {npc:2094} steht am Nordtor.",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}: für {npc:270637}",
	-- ["{npc:211033}: only offered once you have handed in library books (the Library Books guide)"] = "{npc:211033}: wird erst angeboten, wenn du Bibliotheksbücher abgegeben hast (der Guide Bibliotheksbücher)",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} will außerdem {item:3719}, {item:2997} und {item:2321}: hergestellt oder gekauft; den Umhang gibst du ab, wenn du später wieder in {area:271} bist.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: für {npc:3649} in {area:442} (02-desolace)",
	-- ["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} ist im {object:2164}; {npc:211033} nahe dem Kanal; {npc:5081} südlich vom {object:2101}.",
	-- ["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} steht in den südöstlichen Hügeln: Benutze daneben {item:279996}.",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} wartet nördlich von {area:205} am {area:881}; {npc:271322} ein kurzes Stück weiter nordöstlich.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} hat keinen Druidenlehrer: Trainiere vor der Bahn bei {npc:5504} in {zone:1453}.",
}
