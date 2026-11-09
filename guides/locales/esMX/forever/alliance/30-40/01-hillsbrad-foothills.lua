-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["To {area:2104}"] = "",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook (no name in this language: may be words)
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "",

	-- Step 4: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "El siguiente paso, {quest:474}, te enfrenta a un jefe élite: sáltatelo.",
	-- {object:671518} Tattered Spellbook (no name in this language: may be words) · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: para {npc:2104}",

	-- Step 5: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "",

	-- Step 6: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "",

	-- Step 7: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 8: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "",
	-- {area:1036} Angerfang Encampment · {quest:98283} Carnage · {area:205} Dun Modr
	["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "",

	-- Step 9: Razormaw nests
	["Razormaw nests"] = "",
	-- {quest:98246} Trying Times · {quest:98283} Carnage
	-- plural, as words: Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["The Perfect Razormaw Eggs for {quest:98246} lie in the raptors' nests in the hills around {quest:98283}."] = "",

	-- Step 10: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "",

	-- Step 11: The Green Belt
	-- {area:1025} The Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the {area:1025} around {npc:1244}; one of them drops the flesh. {npc:1244} takes the quest only with {quest:98283}'s head too."] = "",

	-- Step 12: Rethiel the Greenwarden
	-- {quest:98283} Carnage
	["With {quest:98283}'s head and the flesh"] = "",

	-- Step 13: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron (no name in this language: may be words)
	["North along the road to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites."] = "",

	-- Step 14: Captive Fire Elemental
	-- {npc:271481} Captive Fire Elemental · {object:147516} Dark Iron (no name in this language: may be words) · {npc:1364} Balgaras the Foul · {npc:1072} Roggo Harlbarrow
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:271481} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "",

	-- Step 15: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "",

	-- Step 16: The Villards
	["The Villards"] = "Los Villard",
	-- {npc:5683} Corma Villard · {area:205} Dun Modr · {area:880} Thandol Span · {npc:271322} Essene Villard · {npc:1075} Rhag Garmason · {quest:87318} Hearts of the Lost
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["{npc:5683} waits on the road north of {area:205}, towards the {area:880}; {npc:271322} a short walk further north-east, and Ebenezer Rustlocke's corpse lies under the span beside her. Rustlocke's parchment goes back to {npc:1075}.\n{npc:5683} may not offer {quest:87318} yet: if she doesn't, skip it.\nTwo elite Dark Iron Saboteurs stand by the corpse inside the span: pull them one at a time, or loot the corpse and run out."] = "",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "",
	["the same corpse"] = "",

	-- Step 17: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron (no name in this language: may be words)
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "",

	-- Step 18: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end."] = "",

	-- Step 19: Waterlogged Envelope
	["Underwater"] = "",

	-- Step 20: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe
	["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "",

	-- Step 22: Howin Kindfeather
	-- {quest:98246} Trying Times
	["{quest:98246}: the eggs"] = "",

	-- Step 23: Prospector Whelgar
	["Below ground"] = "",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} en {zone:1455}, al final de esta guía",

	-- Step 24: Menethil Harbor
	["West along the road to Menethil."] = "Al oeste por el camino hasta Menethil.",
	["On the top floor"] = "",
	-- {npc:4455} Red Jack Flint · {quest:1132} Fiora Longears
	["{npc:4455}, by the keep's door: for {quest:1132} in Theramore, in the next guide"] = "",

	-- Step 25: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "",

	-- Step 26: Howin Kindfeather
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "",
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Para el rey Magni en {zone:1455}, al final de esta guía",

	-- Step 27: Level 30.8
	["Level 30.8"] = "",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "",

	-- Step 29: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Barco a {area:271}",

	-- Step 30: Southshore
	-- {npc:2711} Phin Odelic · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly · {quest:98463} Talk of the Town
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side.\n{npc:2366} may not offer {quest:98463} on Forever: if she doesn't, skip it."] = "",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: su rastro lleva a Tierras Altas de Arathi",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, en la posada: para {area:35} (04-stranglethorn-vale)",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: los leones vienen después",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, de {npc:2381}",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 31: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438} makes a yeti fur cloak for anyone who brings a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells either, so this step shows only when you carry both."] = "",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth
	["{npc:2438}, between the flight master and the inn: he wants a {item:3719} and a {item:2997} too"] = "",

	-- Step 32: Torn Fin murlocs
	["Torn Fin murlocs"] = "Múrlocs Rompeanca",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "",

	-- Step 33: Farren
	["Farren"] = "Farren",
	["Inside"] = "",

	-- Step 34: Murloc heads
	["Murloc heads"] = "Cabezas de múrloc",
	["Back to the same murlocs; not every one drops a head."] = "Regresa con los mismos múrlocs; no todos sueltan una cabeza.",

	-- Step 36: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinadaga",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Los nagas ocupan la costa al sureste de {area:271}.",

	-- Step 37: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "",

	-- Step 39: Southshore
	-- {npc:251493} Captain McManus · {quest:98059} Hillsbrad's Hoard · {item:279386} Sealed Company Request · {area:287} Hillsbrad · {area:271} Southshore
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave.\n{quest:98059}: {npc:251493} hands you a {item:279386} for the {area:287} council, in the farms west of {area:271}; you deliver it after the Syndicate camp."] = "",

	-- Step 40: Yeti cave
	["Yeti cave"] = "Cueva de los yetis",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp."] = "",

	-- Step 41: Alterac Mountains
	["Syndicate camp"] = "Campamento de la Hermandad",

	-- Step 42: Syndicate camp
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "",

	-- Step 43: Hillsbrad Fields
	-- {area:286} Hillsbrad Fields
	["South-west from the Syndicate camp to the {area:286} farms."] = "",

	-- Step 44: Hillsbrad council
	-- {area:287} Hillsbrad
	["{area:287} council"] = "",
	-- {item:279386} Sealed Company Request · {area:287} Hillsbrad
	["Use the {item:279386} at the {area:287} council."] = "",

	-- Step 45: Snapjaws
	["Snapjaws"] = "Quijafortes",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Las tortugas Quijaforte toman el sol a lo largo del río al este de {area:271}, al sur de {area:272} (Horda).",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:271} Southshore
	["{area:271} flight master"] = "",

	-- Step 48: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words)
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "",
	["Level 30 and 32 spells"] = "Hechizos de nivel 30 y 32",

	-- Step 52: King Magni Bronzebeard
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",

	-- Step 53: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 54: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "La quesería de {object:2096}.",

	-- Step 55: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} espera en la taberna El Cerdo Borracho, en {object:2100}; él y sus dos matones pelean contigo, pero se detienen al ser derrotados.",
	-- {npc:4961} Dashel Stonefist
	["Beat {npc:4961} and his thugs: they give up"] = "",

	-- Step 56: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} instruye a los guerreros en {object:2100}, junto a El Cerdo Borracho. {npc:6236} espera en {area:720}, en {zone:1413}, de camino a {area:392} mucho más tarde (40-50/01).",

	-- Step 58: Cathedral of Light
	["Cathedral of Light"] = "Cathedral of Light",

	-- Step 60: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:5081} south of the {object:2101}."] = "",

	-- Step 61: Druid training
	["Druid training"] = "Instrucción de druida",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Un nuevo {item:279996}, para los cuatro vigías titánicos alrededor de {zone:1437}",
	-- ["A report for {object:2117}"] = "Un informe para {object:2117}",
	-- ["Back south down the road to the excavation site."] = "Regresa al sur por el camino hasta la excavación.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Destruye los cuatro juegos de planes de ataque del campamento para {quest:98221}.",
	-- ["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- ["Follow the road east to {area:118}."] = "Sigue el camino hacia el este hasta {area:118}.",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Sigue el camino hacia el noreste hasta {area:1025}: {npc:270637} acampa a un lado y {npc:1244}, un poco al este.",
	-- ["For King Magni in {zone:1455}, at the end of this guide"] = "Para el rey Magni en {zone:1455}, al final de esta guía",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} en {zone:1455}, al final de esta guía",
	-- ["From {npc:2432} in {area:271}"] = "De {npc:2432} en {area:271}",
	-- ["Golm"] = "Golm",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Al norte por el camino hasta {area:205}. {npc:271460} está en las ruinas (usa {item:279996}); {npc:271481} está retenido en el lado oeste: llévalo hasta {npc:1072}.",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "Al noreste, hasta {area:1038}: ahí retienen a {npc:271373}, y {npc:271338} está en las puertas (usa {item:279996}).",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Recoge todo en el pueblo antes de salir. Al bajar del barco, {npc:251493} es el primero que encuentras, al noroeste del maestro de vuelo; {npc:2381} y {npc:2438} están entre el maestro de vuelo y la posada; Farren y {npc:2366}, en la posada; Maleb, en el ayuntamiento.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Las crías rojas llenan las colinas al oeste de las puertas; los Maddened Rotclaws, {area:1025}; los Tajobuche, las laderas del norte; Neru está en el noreste (usa {item:279996}).\n{quest:98283} es de élite: se recomienda ir en grupo.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Las crías rojas llenan las colinas al oeste de las puertas; los {npc:271334}, {area:1025}; los Tajobuche, las laderas del norte; {npc:271458} está en el noreste (usa {item:279996}).\n{quest:98283} es de élite: se recomienda ir en grupo.",
	-- ["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Al sur, hasta {area:1036} de los Faucedraco: la primera catapulta está de camino y {object:671518} está en el campamento.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Al sur, hasta {area:1036} de los Faucedraco; {object:671518} está en el campamento.",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Toma el {area:2257} desde {object:28027} hasta {zone:1455}.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Los Goaz Warders están justo al oeste del campamento de Whelgar: usa {item:279996} que te dio junto a uno.",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "El campamento de la Hermandad está en la frontera con Alterac, en el norte de {area:287}, al oeste de {area:272} (Horda); los documentos están en el campamento.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Los múrlocs Rompeanca abarrotan {area:295}, al suroeste de {area:271}.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Los yetis viven en la cueva de las colinas al norte de {area:271}, de camino de vuelta al sur.",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "Al oeste, hasta las granjas de {area:287}: coloca {item:279386} en la mesa de contabilidad del ayuntamiento, donde están {npc:2335} y los consejeros.",
	-- ["Whelps, raptors and {npc:271458}"] = "Crías, raptores y {npc:271458}",
	-- ["{area:287} town hall"] = "Ayuntamiento de {area:287}",
	-- ["{area:287}'s town hall"] = "Ayuntamiento de {area:287}",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, un raptor de élite",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} está en {area:2103}; {npc:2094} y {npc:270844} están juntos junto a la puerta norte.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} está en {area:2103}; {npc:2094} está junto a la puerta norte.",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}: para {npc:270637}",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} también quiere {item:3719}, {item:2997} y {item:2321}: fabricados o comprados; la capa se entrega cuando regreses a {area:271} más tarde.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: para {npc:3649} en {area:442} (02-desolace)",
	-- ["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} está en {object:2164}; {npc:211033}, cerca del canal; {npc:5081}, al sur de {object:2101}.",
	-- ["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} está en las colinas del sureste: usa {item:279996} junto a él.",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} espera al norte de {area:205}, junto a {area:881}; {npc:271322}, un poco más al noreste.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} no tiene instructor de druidas: entrena con {npc:5504} en {zone:1453} antes del tranvía.",
}
