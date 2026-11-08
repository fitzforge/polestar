-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Deepwater Tavern
	["To Deepwater Tavern"] = "",
	["Deepwater Tavern"] = "",

	-- Step 2: Angerfang Encampment
	["Angerfang Encampment"] = "",
	-- {object:671518} Tattered Spellbook (no name in this language: may be words)
	["South-east from Menethil to the Dragonmaw's Angerfang Encampment: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "",

	-- Step 4: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "",
	-- {object:671518} Tattered Spellbook (no name in this language: may be words) · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: para {npc:2104}",

	-- Step 5: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "",

	-- Step 6: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "",

	-- Step 7: Ados
	-- {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the Dragonmaw Gates: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 8: Dragonmaw Gates: kill these as you meet them
	["Dragonmaw Gates: kill these as you meet them"] = "",
	-- {quest:98283} Carnage · {object:376} Dun Modr (no name in this language: may be words)
	["The whelps nest in the hills north-east of the Angerfang Encampment; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {object:376}.\n{quest:98283} is elite: grouping up is advised."] = "",

	-- Step 9: Neru
	-- {npc:271458} Neru · {object:376} Dun Modr (no name in this language: may be words) · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the Dragonmaw Gates and {object:376} (use the {item:279996})."] = "",

	-- Step 10: The Green Belt
	["The Green Belt"] = "",
	-- {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Maddened Rotclaws roam the Green Belt around {npc:1244}."] = "",

	-- Step 11: Dun Modr
	-- {object:376} Dun Modr (no name in this language: may be words) · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {npc:1072} Roggo Harlbarrow · {npc:271481} Captive Fire Elemental
	["North along the road to {object:376}. {npc:1071}, {npc:1075} and {npc:1072} stand together in the dwarves' camp; the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "",

	-- Step 12: Modr
	-- {npc:271460} Modr · {object:376} Dun Modr (no name in this language: may be words) · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {object:376} (use the {item:279996})."] = "",

	-- Step 13: The Villards
	["The Villards"] = "Los Villard",
	-- {npc:5683} Comar Villard · {object:376} Dun Modr (no name in this language: may be words) · {object:2673} Thandol Span (no name in this language: may be words) · {npc:271322} Essene Villard · {npc:1075} Rhag Garmason
	["{npc:5683} waits on the road north of {object:376}, towards the {object:2673}; {npc:271322} a short walk further north-east, and Ebenezer Rustlocke's corpse lies under the span beside her. Rustlocke's parchment goes back to {npc:1075}."] = "",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "",
	["the same corpse"] = "",

	-- Step 14: Rhag Garmason
	-- {object:376} Dun Modr (no name in this language: may be words) · {npc:1075} Rhag Garmason · {object:147516} Dark Iron (no name in this language: may be words)
	["Back down the road to {object:376}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "",

	-- Step 15: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "",
	-- {object:2673} Thandol Span (no name in this language: may be words) · {npc:2696} Foggy MacKreel
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {object:2673}: the Dark Irons' cache of explosives sits by its Arathi end. {npc:2696} stands a short walk west of it."] = "",

	-- Step 17: Waterlogged Envelope
	["Underwater"] = "",

	-- Step 18: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "",
	-- {object:376} Dun Modr (no name in this language: may be words)
	["Back over the span and down the road through {object:376} on the way south."] = "",
	-- {npc:2700} Captain Nials · {object:2685} Refuge Pointe (no name in this language: may be words)
	["for {npc:2700} at {object:2685}, in 05-arathi-highlands"] = "",

	-- Step 20: Prospector Whelgar
	["Below ground"] = "",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} en {zone:1455}, al final de esta guía",

	-- Step 21: Menethil Harbor
	["West along the road to Menethil."] = "Al oeste por el camino hasta Menethil.",
	["On the top floor"] = "",

	-- Step 22: Menethil Harbor
	-- {npc:2104} Captain Stoutfist
	["{npc:2104} stands on the top floor of Menethil Keep: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 23: Level 30.8
	["Level 30.8"] = "",
	-- {quest:474} Defeat Nek'rosh
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the Gnomeregan dungeon or the Scarlet Monastery dungeon (Graveyard) instead."] = "",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "",

	-- Step 25: Boat to Southshore
	["Boat to Southshore"] = "",

	-- Step 26: Southshore
	["Southshore"] = "",
	-- {npc:2711} Phin Odelic · {npc:2705} Brewmeister Bilger · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2705} below it and {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side."] = "",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: su rastro lleva a Tierras Altas de Arathi",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "",
	-- {npc:2366} Barkeep Kelly · {object:3204} Booty Bay (no name in this language: may be words)
	["{npc:2366}, in the inn: for {object:3204} (04-stranglethorn-vale)"] = "",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: los leones vienen después",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, de {npc:2381}",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438}: only if you have or can buy a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells them"] = "",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 27: Torn Fin murlocs
	["Torn Fin murlocs"] = "Múrlocs Rompeanca",
	["The Torn Fin murlocs crowd the Western Strand, south-west of Southshore.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "",

	-- Step 28: Farren
	["Farren"] = "Farren",
	["Inside"] = "",

	-- Step 29: Murloc heads
	["Murloc heads"] = "Cabezas de múrloc",
	["Back to the same murlocs; not every one drops a head."] = "Regresa con los mismos múrlocs; no todos sueltan una cabeza.",

	-- Step 31: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinadaga",
	["The naga hold the shore south-east of Southshore."] = "",

	-- Step 32: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "",

	-- Step 34: Southshore
	-- {npc:251493} Captain McManus
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave."] = "",

	-- Step 35: Yeti cave
	["Yeti cave"] = "Cueva de los yetis",
	["The yetis live in the cave in the hills north of Southshore, on the way north to the Syndicate camp."] = "",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring · {item:2321} Fine Thread
	["{npc:2438} also wants a {item:3719} ({skill:165}), a {item:2997} ({skill:197}) and {item:2321} (any trade supplier): the cloak is turned in when you are back in Southshore later."] = "",

	-- Step 37: Syndicate camp
	["Syndicate camp"] = "Campamento de la Hermandad",
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["The Syndicate camp sits on the Alterac border in northern Hillsbrad, west of {object:1772} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "",

	-- Step 38: Snapjaws
	["Snapjaws"] = "Quijafortes",
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["The Snapjaw turtles bask along the river east of Southshore, south of {object:1772} (Horde)."] = "",

	-- Step 41: Fly to Ironforge
	-- {zone:1455} Ironforge
	["Fly to {zone:1455}"] = "",
	["Southshore flight master"] = "",

	-- Step 42: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words)
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "",
	["Level 30 and 32 spells"] = "Hechizos de nivel 30 y 32",

	-- Step 46: King Magni Bronzebeard
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",

	-- Step 47: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 48: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "La quesería de {object:2096}.",

	-- Step 49: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} espera en la taberna El Cerdo Borracho, en {object:2100}; él y sus dos matones pelean contigo, pero se detienen al ser derrotados.",

	-- Step 50: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {zone:1413} Barrens
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on Fray Island in the {zone:1413}, on the way to Ratchet much later (40-50/01)."] = "",

	-- Step 52: Cathedral of Light
	["Cathedral of Light"] = "Cathedral of Light",

	-- Step 54: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:5081} south of the {object:2101}."] = "",

	-- Step 55: Druid training
	["Druid training"] = "Instrucción de druida",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Un nuevo {item:279996}, para los cuatro vigías titánicos alrededor de {zone:1437}",
	-- ["A report for {object:2117}"] = "Un informe para {object:2117}",
	-- ["Back south down the road to the excavation site."] = "Regresa al sur por el camino hasta la excavación.",
	-- ["Boat to {area:271}"] = "Barco a {area:271}",
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
	-- ["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Las tortugas Quijaforte toman el sol a lo largo del río al este de {area:271}, al sur de {area:272} (Horda).",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "El campamento de la Hermandad está en la frontera con Alterac, en el norte de {area:287}, al oeste de {area:272} (Horda); los documentos están en el campamento.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Los múrlocs Rompeanca abarrotan {area:295}, al suroeste de {area:271}.",
	-- ["The Villards"] = "Los Villard",
	-- ["The naga hold the shore south-east of {area:271}."] = "Los nagas ocupan la costa al sureste de {area:271}.",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "El siguiente paso, Derrota a Nek'rosh, te enfrenta a un jefe élite: sáltatelo.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Los yetis viven en la cueva de las colinas al norte de {area:271}, de camino de vuelta al sur.",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "Al oeste, hasta las granjas de {area:287}: coloca {item:279386} en la mesa de contabilidad del ayuntamiento, donde están {npc:2335} y los consejeros.",
	-- ["Whelps, raptors and {npc:271458}"] = "Crías, raptores y {npc:271458}",
	-- ["{area:287} town hall"] = "Ayuntamiento de {area:287}",
	-- ["{area:287}'s town hall"] = "Ayuntamiento de {area:287}",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, un raptor de élite",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} está en {area:2103}; {npc:2094} y {npc:270844} están juntos junto a la puerta norte.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} está en {area:2103}; {npc:2094} está junto a la puerta norte.",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}: para {npc:270637}",
	-- ["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, en la posada: para {area:35} (04-stranglethorn-vale)",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} también quiere {item:3719}, {item:2997} y {item:2321}: fabricados o comprados; la capa se entrega cuando regreses a {area:271} más tarde.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: para {npc:3649} en {area:442} (02-desolace)",
	-- ["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} está en {object:2164}; {npc:211033}, cerca del canal; {npc:5081}, al sur de {object:2101}.",
	-- ["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} está en las colinas del sureste: usa {item:279996} junto a él.",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} instruye a los guerreros en {object:2100}, junto a El Cerdo Borracho. {npc:6236} espera en {area:720}, en {zone:1413}, de camino a {area:392} mucho más tarde (40-50/01).",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} espera al norte de {area:205}, junto a {area:881}; {npc:271322}, un poco más al noreste.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} no tiene instructor de druidas: entrena con {npc:5504} en {zone:1453} antes del tranvía.",
}
