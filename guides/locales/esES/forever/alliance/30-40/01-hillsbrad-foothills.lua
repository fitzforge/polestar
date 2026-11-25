-- Spanish (Spain) (esES): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Angerfang Encampment
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: para {npc:2104}",

	-- Step 2: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South-east from Menethil to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "Al sureste desde Menethil, hasta {area:1036} de los Faucedraco: la primera catapulta está de camino y {object:671518} está en el campamento.",

	-- Step 4: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "Son enemigos élite: se recomienda agruparse, busca gente con quien hacerlo. {npc:2091} es un élite de nivel 32: la mayoría de las clases lo hacen solas a nivel 34, pero puede que necesites ayuda. Sáltalo si vas solo: la ruta te hace recuperar la experiencia matando enemigos.\nCuidado: hay lanzasombras a ambos lados de él, y al menos uno está vinculado a él, así que se suma cuando lo atraes. Hay centuriones y capitanes no élite repartidos por su anillo de tiendas.",

	-- Step 5: Golm
	-- {npc:271462} Golm · {npc:271338} Ados · {npc:271458} Neru · {npc:271460} Modr · {item:279996} Goaz Stone
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:271462}, {npc:271338}, {npc:271458} and {npc:271460} are level 32 elites, each called up by using the {item:279996} beside it. Skip them if you are alone. {npc:271462} stands in the south-eastern hills."] = "Son enemigos élite: se recomienda agruparse, busca gente con quien hacerlo. {npc:271462}, {npc:271338}, {npc:271458} y {npc:271460} son élites de nivel 32, y cada uno aparece al usar {item:279996} a su lado. Sáltalos si vas solo. {npc:271462} está en las colinas del sureste.",

	-- Step 6: Ados
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "Al noreste, hasta {area:1038}: {npc:271338} está en las puertas (usa la {item:279996}).",

	-- Step 7: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "{area:1038}: mátalos según te los encuentres",
	-- {area:1036} Angerfang Encampment · {area:205} Dun Modr · {area:1025} Green Belt · {item:280331} Malignant Rotclaw Flesh · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["The whelps nest in the hills north-east of the {area:1036}, and the Razormaw raptors hunt the highlands on the way north to {area:205}. The Maddened Rotclaws that roam these hills and the {area:1025} drop the {item:280331} that calls {quest:98283} out.\n{quest:98283} is elite: grouping up is advised."] = "Las crías anidan en las colinas al noreste de {area:1036}, y los raptores Faucedaga cazan en las tierras altas camino del norte hacia {area:205}. Las Garrapútridas enloquecidas ({npc:271334}) que vagan por estas colinas y {area:1025} sueltan {item:280331} que hace salir a {quest:98283}.\n{quest:98283} es élite: se recomienda ir en grupo.",
	-- {item:280331} Malignant Rotclaw Flesh · {quest:98283} Carnage
	["{item:280331}, for {quest:98283}"] = "{item:280331}, para {quest:98283}",

	-- Step 8: Carnage
	-- {quest:98283} Carnage · {item:280331} Malignant Rotclaw Flesh · {area:1038} Dragonmaw Gates
	["{quest:98283} only comes out when the {item:280331} is used at his lair on the hill north of the {area:1038}. He is a level 30 elite: grouping up is advised."] = "{quest:98283} solo sale cuando se usa {item:280331} en su guarida, en la colina al norte de {area:1038}. Es un élite de nivel 30: se recomienda ir en grupo.",
	-- {quest:98283} Carnage
	["{quest:98283} comes out to it"] = "{quest:98283} sale a por ella",
	-- {item:280331} Malignant Rotclaw Flesh · {quest:98283} Carnage
	["Use the {item:280331} at {quest:98283}'s lair"] = "Usa {item:280331} en la guarida de {quest:98283}",

	-- Step 9: Razormaw nests
	["Razormaw nests"] = "Nidos Tajobuche",
	-- {quest:98246} Trying Times · {quest:98283} Carnage
	-- plural, as words: Perfect Razormaw Eggs = {item:280132} Perfect Razormaw Egg
	["The Perfect Razormaw Eggs for {quest:98246} lie in the raptors' nests in the hills around {quest:98283}."] = "Los huevos Tajobuche perfectos para {quest:98246} están en los nidos de los raptores, en las colinas alrededor de {quest:98283}.",

	-- Step 10: Neru
	-- {npc:271458} Neru · {area:1038} Dragonmaw Gates · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271458} stands in the hills between the {area:1038} and {area:205} (use the {item:279996})."] = "{npc:271458} está en las colinas entre {area:1038} y {area:205} (usa {item:279996}).",

	-- Step 11: Rethiel the Greenwarden
	-- {quest:98283} Carnage
	["With {quest:98283}'s head and the flesh"] = "Con la cabeza de {quest:98283} y la carne",

	-- Step 12: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["North along the road to {area:205}. {npc:1071} and {npc:1075} stand together in the dwarves' camp on the east side of the road; the {object:147516} ruins west of it are full of elites."] = "Al norte por el camino hasta {area:205}. {npc:1071} y {npc:1075} están juntos en el campamento de los enanos, en el lado este del camino; las ruinas de {object:147516} al oeste están llenas de élites.",

	-- Step 13: Motley Garmason
	-- {quest:303} The Dark Iron War
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["{quest:303} is a group quest: 30 elite Dark Irons (27-31) in the ruins west of the camp. Skip it if you are alone."] = "{quest:303} es una misión de grupo: 30 Hierro Negro élite (27-31) en las ruinas al oeste del campamento. Sáltala si vas solo.",
	-- {npc:1074} Motley Garmason
	["{npc:1074}, in the camp"] = "{npc:1074}, en el campamento",

	-- Step 14: Ashlan Stonesmirk
	-- {quest:88756} Bring Back a Bang · {item:280806} Stolen Explosives · {object:147516} Dark Iron · {area:1016} Direforge Hill · {area:205} Dun Modr
	["{quest:88756} is a group quest: the {item:280806} lie in the {object:147516} camp on {area:1016}, south-east of {area:205}, among the same elite dwarves. Skip it if you are alone."] = "{quest:88756} es una misión de grupo: los {item:280806} están en el campamento de {object:147516} en {area:1016}, al sureste de {area:205}, entre los mismos enanos élite. Sáltala si vas solo.",
	-- {npc:1073} Ashlan Stonesmirk
	["{npc:1073}, in the camp"] = "{npc:1073}, en el campamento",

	-- Step 15: Captive Fire Elemental
	-- {npc:275049} Captive Fire Elemental · {object:147516} Dark Iron · {npc:1364} Balgaras the Foul · {npc:1072} Roggo Harlbarrow
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:275049} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "Son enemigos élite: se recomienda ir en grupo, busca gente con quien hacerlo. {npc:275049} está retenido en el extremo oeste de las ruinas de {object:147516}, más allá de enanos élite de nivel 27-30, y {npc:1364} (34, élite) puede estar entre ellos. Sácalo hacia el este de las ruinas y entrégalo a {npc:1072} en el campamento. Sáltala si vas solo.",

	-- Step 16: Modr
	-- {npc:271460} Modr · {area:205} Dun Modr · {item:279996} Goaz Stone
	["{npc:271460} stands in the ruins of {area:205} (use the {item:279996})."] = "{npc:271460} está en las ruinas de {area:205} (usa la {item:279996}).",

	-- Step 17: The Dark Iron War
	-- {npc:1364} Balgaras the Foul
	["These are elite mobs: grouping up is encouraged, look for people to do it with. Dark Iron Dwarves, Tunnelers, Saboteurs and Demolitionists (27-31) fill the ruins west of the camp; {npc:1364} (34, elite) walks among them."] = "Son enemigos élite: se recomienda agruparse, busca gente con quien hacerlo. Enanos, tuneleros, saboteadores y demoledores Hierro Negro (27-31) llenan las ruinas al oeste del campamento; {npc:1364} (34, élite) anda entre ellos.",

	-- Step 18: Direforge Hill
	-- {area:1016} Direforge Hill · {item:280806} Stolen Explosives · {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["These are elite mobs: grouping up is encouraged, look for people to do it with. South-east of Dun Modr, about 500 yards, the Dark Irons camp on {area:1016}: the {item:280806} lie among their tents. Then back past the camp and north to the {area:880}."] = "Son enemigos élite: se recomienda agruparse, busca gente con quien hacerlo. Al sureste de Dun Modr, a unos 500 m, el campamento Hierro Negro en {area:1016}: los {item:280806} están entre sus tiendas. Luego vuelve a pasar el campamento y sube al norte hasta {area:880}.",

	-- Step 19: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	-- {area:205} Dun Modr · {area:880} Thandol Span · {npc:1075} Rhag Garmason
	-- plural, as words: Dark Iron Saboteurs = {npc:1052} Dark Iron Saboteur
	["North along the road from {area:205} towards the {area:880}: Ebenezer Rustlocke's corpse lies under the span. Rustlocke's parchment goes back to {npc:1075}.\nTwo elite Dark Iron Saboteurs stand by the corpse inside the span: pull them one at a time, or loot the corpse and run out."] = "Al norte por el camino desde {area:205} hacia {area:880}: el cadáver de Ebenezer Rustlocke está debajo del puente. El pergamino de Rustlocke vuelve a {npc:1075}.\nDos saboteadores Hierro Negro élite están junto al cadáver, dentro del puente: atráelos de a uno, o saquea el cadáver y sal corriendo.",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}, dentro",
	["the same corpse"] = "el mismo cadáver",

	-- Step 20: Rhag Garmason
	-- {area:205} Dun Modr · {npc:1075} Rhag Garmason · {object:147516} Dark Iron
	["Back down the road to {area:205}: {npc:1075} wants the {object:147516} explosives under the far end of the span destroyed."] = "De vuelta por el camino hasta {area:205}: {npc:1075} quiere que destruyas los explosivos de {object:147516} que están bajo el otro extremo del puente.",

	-- Step 21: Motley Garmason
	-- {npc:1075} Rhag Garmason
	["in the camp, beside {npc:1075}"] = "en el campamento, junto a {npc:1075}",

	-- Step 23: The Cache of Explosives
	-- {object:2704} Cache of Explosives
	["The {object:2704}"] = "{object:2704}",
	-- {area:880} Thandol Span
	-- plural, as words: Dark Irons = {object:147516} Dark Iron
	["Over the {area:880}: the Dark Irons' cache of explosives sits by its Arathi end."] = "Cruza {area:880}: el alijo de explosivos de los Hierro Negro está junto a su extremo de Arathi.",

	-- Step 24: Waterlogged Envelope
	["Underwater"] = "Bajo el agua",

	-- Step 25: Rhag Garmason again
	-- {npc:1075} Rhag Garmason
	["{npc:1075} again"] = "De nuevo {npc:1075}",
	-- {area:205} Dun Modr
	["Back over the span and down the road through {area:205} on the way south."] = "De vuelta por el puente y bajando por el camino a través de {area:205}, de camino al sur.",
	-- {npc:2700} Captain Nials · {area:320} Refuge Pointe · {zone:1417} Arathi Highlands
	["for {npc:2700} at {area:320}, in the {zone:1417} guide"] = "",

	-- Step 27: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:270637} Howin Kindfeather
	["The root core from your {area:17732} run: {npc:1244} stands by the river, just east of {npc:270637}."] = "El núcleo de raíz de tu incursión en {area:17732}: {npc:1244} está junto al río, justo al este de {npc:270637}.",

	-- Step 28: Howin Kindfeather
	-- {quest:98246} Trying Times
	["{quest:98246}: the eggs"] = "{quest:98246}: los huevos",

	-- Step 29: Howin Kindfeather
	-- {quest:98291} Death to the Dragonmaw · {area:17716} Dragonmaw Retreat · {npc:270637} Howin Kindfeather
	["{quest:98291} is a group quest: 16 elite Dragonmaw (29-30) in {area:17716}, just east of {npc:270637}. Skip it if you are alone."] = "{quest:98291} es una misión de grupo: 16 Faucedraco élite (29-30) en {area:17716}, justo al este de {npc:270637}. Sáltala si vas solo.",

	-- Step 30: Dragonmaw Retreat
	-- {npc:270637} Howin Kindfeather
	-- plural, as words: Dragonmaw Reclaimers = {npc:271351} Dragonmaw Reclaimer
	["These are elite mobs: grouping up is encouraged, look for people to do it with. The Dragonmaw Reclaimers, Soulbinders and Infiltrators (29-30, elite) camp just east of {npc:270637}."] = "Son enemigos élite: se recomienda agruparse, busca gente con quien hacerlo. Los reivindicadores, vinculadores de almas e infiltrados Faucedraco (29-30, élite) acampan justo al este de {npc:270637}.",

	-- Step 31: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather
	["back west to {npc:270637}"] = "de vuelta al oeste, con {npc:270637}",

	-- Step 32: Prospector Whelgar
	["Below ground"] = "Bajo tierra",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} en {zone:1455}, al final de esta guía",

	-- Step 33: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, south of the road west."] = "{item:270865} de tu incursión en {area:17732}: {npc:1077} está bajo tierra en su excavación, al sur del camino hacia el oeste.",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}, bajo tierra",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077}: para {npc:5387} en {zone:1455}, al final de esta guía",

	-- Step 34: Prospector Whelgar
	-- {item:287959} Titan Relic · {npc:1077} Prospector Whelgar · {quest:98824} Prehistoric Prism
	["The {item:287959} is already with {npc:1077}: take {quest:98824} from him, below ground in his dig, south of the road west."] = "{item:287959} ya está con {npc:1077}: acepta {quest:98824} de él, bajo tierra en su excavación, al sur del camino del oeste.",

	-- Step 35: Menethil Harbor
	["West along the road to Menethil."] = "Al oeste por el camino hasta Puerto de Menethil.",
	["On the top floor"] = "En el piso superior",

	-- Step 36: Menethil Harbor
	-- {npc:4455} Red Jack Flint · {quest:1132} Fiora Longears
	["{npc:4455}, by the keep's door: for {quest:1132} in Theramore, in the next guide"] = "{npc:4455}, junto a la puerta del bastión: para {quest:1132} en Theramore, en la guía siguiente",

	-- Step 37: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2104} está en el piso de arriba de {area:2103}: sube por adentro, la flecha no distingue los pisos.",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}, back east along the road"] = "{npc:2104}: para {npc:270637}, de vuelta al este por el camino",

	-- Step 38: Howin Kindfeather
	-- {area:1025} Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Back east along the road to the {area:1025}: {npc:270637} camps among the Fenrunners, just west of {npc:1244}. Then west again to Menethil for the boat."] = "Vuelve al este por el camino hasta {area:1025}: {npc:270637} acampa entre los Correpantanos, justo al oeste de {npc:1244}. Luego otra vez al oeste hasta Menethil para tomar el barco.",

	-- Step 39: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1239} First Mate Fitzsimmons · {area:2104} Deepwater Tavern
	["{npc:2094} stands by the docks; {npc:1239} sits in the {area:2104}, south of the keep."] = "{npc:2094} está junto a los muelles; {npc:1239} está sentado en {area:2104}, al sur de la fortaleza.",

	-- Step 40: Captain Halyndor
	-- {npc:1160} Captain Halyndor · {npc:270589} Nightveiled Rotheap · {zone:1437} Wetlands
	["North along the coast from Menethil to the wreck of the Intrepid: {npc:1160} (30) is aboard, and the locked strongbox sits in the wreck. Careful: {npc:270589}, a level 31-32 elite, roams the {zone:1437}: give it a wide berth."] = "Al norte por la costa desde Menethil hasta el naufragio del Intrépido: {npc:1160} (30) está a bordo, y la caja fuerte cerrada está en el naufragio. Cuidado: {npc:270589}, un élite de nivel 31-32, ronda {zone:1437}: mantente bien lejos.",
	-- {item:2629} Intrepid Strongbox Key · {npc:1160} Captain Halyndor
	["{item:2629}, from {npc:1160}"] = "{item:2629}, de {npc:1160}",

	-- Step 41: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["Back south to Menethil: {npc:1217} stands in the {area:2104}."] = "De vuelta al sur a Menethil: {npc:1217} está en {area:2104}.",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "Para {npc:1284} en {zone:1453}, al final de esta guía",

	-- Step 42: Level 30.8
	["Level 30.8"] = "Nivel 30.8",
	-- {quest:474} Defeat Nek'rosh · {area:133} Gnomeregan · {area:796} Scarlet Monastery
	["Skipped {quest:474} and short of 30.8? Kill the Bluegill murlocs on the coast south of Menethil until level 30.8. Or, with a group, run the {area:133} dungeon or the {area:796} dungeon (Graveyard) instead."] = "¿Te saltaste {quest:474} y no llegas a 30.8? Mata múrlocs Branquiazul en la costa al sur de Menethil hasta el nivel 30.8. O, con un grupo, haz en su lugar la mazmorra {area:133} o la mazmorra {area:796} (Cementerio).",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "sube nivel con {npc:1418}",

	-- Step 43: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Barco a {area:271}",

	-- Step 44: Southshore
	-- {npc:2711} Phin Odelic · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly · {quest:98463} Talk of the Town
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side.\n{npc:2366} may not offer {quest:98463} on Forever: if she doesn't, skip it."] = "Al bajar del barco, sube por el muelle hasta el pueblo: {npc:2711} y el teniente Farren están junto a la posada, {npc:2430} arriba, {npc:2382} al este; la maestra de vuelo está en el extremo norte, {npc:2381} y {npc:2438} entre ella y la posada, y Maleb en el ayuntamiento, en el lado oeste.\nPuede que {npc:2366} no ofrezca {quest:98463} en Forever: si no lo hace, sáltala.",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: su rastro lleva a las Tierras Altas de Arathi",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "{npc:2228}, dentro",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale
	["{npc:2366}, in the inn: for {area:35} (the {zone:1434} guide)"] = "",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "{npc:2430}, en el piso de arriba",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: los leones vienen después",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, de {npc:2381}",
	-- {npc:2276} Magistrate Henry Maleb · {zone:1417} Arathi Highlands
	-- was: ["{npc:2276}, inside: keep it, the Syndicate camp waits for the road north to Arathi (05-arathi-highlands)"] = "{npc:2276}, dentro: guárdala, el campamento del Sindicato espera al camino al norte hacia Arathi (05-arathi-highlands)"
	["{npc:2276}, inside: keep it, the Syndicate camp waits for the road north to Arathi (the {zone:1417} guide)"] = "",

	-- Step 45: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {skill:165} Leatherworking · {item:2997} Bolt of Woolen Cloth · {skill:197} Tailoring
	["{npc:2438} makes a yeti fur cloak for anyone who brings a {item:3719} ({skill:165}) and a {item:2997} ({skill:197}); no vendor sells either, so this step shows only when you carry both."] = "{npc:2438} hace una capa de piel de yeti para quien le traiga una {item:3719} ({skill:165}) y un {item:2997} ({skill:197}); ningún mercader vende ninguno de los dos, así que este paso solo aparece cuando llevas ambos.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth
	["{npc:2438}, between the flight master and the inn: he wants a {item:3719} and a {item:2997} too"] = "{npc:2438}, entre el maestro de vuelo y la posada: también quiere una {item:3719} y un {item:2997}",

	-- Step 46: Torn Fin murlocs
	["Torn Fin murlocs"] = "Múrlocs Rompeanca",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "Los múrlocs Rompeanca abarrotan {area:295}, al suroeste de {area:271}.\nCuidado: un campamento tiene un grupo apretado de Oráculos que atacan todos a la vez.",

	-- Step 47: Farren
	["Farren"] = "Teniente Farren Orinelle",
	["Inside"] = "Dentro",

	-- Step 48: Murloc heads
	["Murloc heads"] = "Cabezas de múrloc",
	["Back to the same murlocs; not every one drops a head."] = "Vuelve a los mismos múrlocs; no todos sueltan una cabeza.",

	-- Step 50: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinadaga",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Los nagas ocupan la costa al sureste de {area:271}.",

	-- Step 51: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "Un informe para {object:2117}; dentro",

	-- Step 53: Southshore
	-- {npc:251493} Captain McManus · {quest:98059} Hillsbrad's Hoard · {item:279386} Sealed Company Request · {area:287} Hillsbrad · {area:271} Southshore
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave.\n{quest:98059}: {npc:251493} hands you a {item:279386} for the {area:287} council, in the farms west of {area:271}."] = "{npc:251493} está al noroeste del maestro de vuelo, de camino al norte hacia la cueva de los yetis.\n{quest:98059}: {npc:251493} te da una {item:279386} para el consejo de {area:287}, en las granjas al oeste de {area:271}.",

	-- Step 54: Yeti cave
	["Yeti cave"] = "Cueva de los yetis",
	-- {area:271} Southshore · {area:277} Foothill Caverns · {npc:13602} The Abominable Greench
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["The yetis live in the cave in the hills north of {area:271}.\nStay in the {area:277}: the cave further north has Mountain and Giant Yetis (32-34) in pairs and {npc:13602}, a level 36 elite."] = "Los yetis viven en la cueva de las colinas al norte de {area:271}.\nQuédate en {area:277}: la cueva más al norte tiene Yetis monteses y Yetis gigantes (32-34) en parejas y a {npc:13602}, un élite de nivel 36.",

	-- Step 55: Hillsbrad Fields
	-- {area:271} Southshore · {area:286} Hillsbrad Fields
	["West from {area:271} to the {area:286} farms."] = "Al oeste desde {area:271} hasta las granjas de {area:286}.",

	-- Step 56: Hillsbrad council
	-- {area:287} Hillsbrad
	["{area:287} council"] = "Consejo de {area:287}",
	-- {item:279386} Sealed Company Request · {area:287} Hillsbrad
	["Use the {item:279386} at the {area:287} council."] = "Usa {item:279386} en el consejo de {area:287}.",

	-- Step 57: Snapjaws
	["Snapjaws"] = "Quijafortes",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Las tortugas Quijaforte toman el sol junto al río al este de {area:271}, al sur de {area:272} (Horda).",

	-- Step 59: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:271} Southshore
	["{area:271} flight master"] = "Maestro de vuelo de {area:271}",

	-- Step 60: Hall of Explorers
	-- {npc:1356} Prospector Stormpike · {npc:2916} Historian Karnik · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words)
	["{npc:1356}, {npc:2916} and {npc:5637} stand in the {object:32356}, north-east of the flight master."] = "{npc:1356}, {npc:2916} y {npc:5637} están en {object:32356}, al noreste del maestro de vuelo.",
	["Level 30 and 32 spells"] = "Hechizos de nivel 30 y 32",

	-- Step 63: Sara Balloo
	-- {npc:2695} Sara Balloo · {zone:1455} Ironforge
	["{npc:2695}: for King Magni, on the same {zone:1455} stop"] = "{npc:2695}: para el Rey Magni Barbabronce, en la misma parada de {zone:1455}",

	-- Step 65: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",

	-- Step 66: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "La quesería de {object:2096}.",

	-- Step 67: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} espera en la taberna del Cerdo y el Silbato, en {object:2100}; él y sus dos matones pelean contigo, pero paran al ser derrotados.",
	-- {npc:4961} Dashel Stonefist
	["Beat {npc:4961} and his thugs: they give up"] = "Vence a {npc:4961} y a sus matones: se rinden",

	-- Step 68: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet · {zone:1434} Stranglethorn Vale
	-- was: ["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} entrena a los guerreros en {object:2100}, junto al Cerdo y el Silbato. {npc:6236} espera en {area:720}, en {zone:1413}, de camino a {area:392} mucho más tarde (40-50/01)."
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (the 40-50 {zone:1434} guide)."] = "",

	-- Step 70: Cathedral of Light
	["Cathedral of Light"] = "Catedral de la Luz",

	-- Step 72: Mage Quarter
	-- {npc:2708} Archmage Malin · {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} and {npc:4078} are in the {object:2164}; {npc:5081} south of the {object:2101}."] = "{npc:2708} y {npc:4078} están en {object:2164}; {npc:5081}, al sur de {object:2101}.",
	-- {npc:4078} Collin Mauren · {area:2240} Mirage Raceway
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{npc:4078}: the Saltstone Basilisks at the {area:2240} drop the scales, in the next guide"] = "{npc:4078}: los Basiliscos Salpiedra de {area:2240} sueltan las escamas, en la siguiente guía",

	-- Step 73: Druid training
	["Druid training"] = "Instrucción de druida",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{zone:1455} has no druid trainer: {npc:5504} stands in {zone:1453}, north-west of the {object:2101}."] = "{zone:1455} no tiene instructor de druidas: {npc:5504} está en {zone:1453}, al noroeste de {object:2101}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Una nueva {item:279996}, para los cuatro vigías titánicos de {zone:1437}",
	-- ["Back south down the road to the excavation site."] = "Vuelve al sur por el camino hasta la excavación.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Destruye los cuatro juegos de planes de ataque del campamento para {quest:98221}.",
	-- ["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- ["Follow the road east to {area:118}."] = "Sigue el camino hacia el este hasta {area:118}.",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} en {zone:1455}, al final de esta guía",
	-- ["From {npc:2432} in {area:271}"] = "Desde {npc:2432} en {area:271}",
	-- ["Golm"] = "Golm",
	-- ["Maddened Rotclaws roam the {area:1025} around {npc:1244}; one of them drops the flesh. {npc:1244} takes the quest only with {quest:98283}'s head too."] = "Las garrapútreas enajenados recorren {area:1025} alrededor de {npc:1244}; uno de ellos suelta la carne. {npc:1244} solo acepta la misión si también tienes la cabeza de {quest:98283}.",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Al norte por el camino hasta {area:205}. {npc:271460} está en las ruinas (usa la {item:279996}); {npc:271481} está retenido en el lado oeste: llévalo hasta {npc:1072}.",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Recoge todo en el pueblo antes de salir. Al bajar del barco, {npc:251493} es el primero que encuentras, al noroeste del maestro de vuelo; {npc:2381} y {npc:2438} están entre el maestro de vuelo y la posada; el Teniente Farren Orinelle y {npc:2366}, en la posada; el Magistrado Henry Maleb, en el ayuntamiento.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Las Crías rojas llenan las colinas al oeste de las puertas; los Garrapútrea enajenados, {area:1025}; los Tajobuche, las laderas del norte. Neru está en el noreste (usa la {item:279996}).\n{quest:98283} es élite: se recomienda ir en grupo.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Las Crías rojas llenan las colinas al oeste de las puertas; los Garrapútrea enajenados, {area:1025}; los Tajobuche, las laderas del norte. {npc:271458} está en el noreste (usa la {item:279996}).\n{quest:98283} es élite: se recomienda ir en grupo.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Al sur, hasta {area:1036} de los Faucedraco; {object:671518} está en el campamento.",
	-- ["Syndicate camp"] = "Campamento del Sindicato",
	-- ["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Toma el {area:2257} desde {object:28027} hasta {zone:1455}.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Los Guardianes de Goaz están justo al oeste del campamento del Prospector Whelgar: usa junto a uno la {item:279996} que te dio.",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "El campamento del Sindicato está en la frontera con las Montañas de Alterac, al norte de {area:287}, al oeste de {area:272} (Horda); los documentos están en el campamento, y sus Rateros y Ladrones son el Sindicato que quiere Maleb.",
	-- ["The Villards"] = "Los Villardo",
	-- ["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "El siguiente paso, {quest:474}, te enfrenta a un jefe élite: sáltatelo.",
	-- ["The whelps nest in the hills north-east of the {area:1036}; {quest:98283} prowls further north, and the Razormaw raptors hunt the highlands on the way north to {area:205}.\n{quest:98283} is elite: grouping up is advised."] = "Las crías anidan en las colinas al noreste de {area:1036}; {quest:98283} merodea más al norte, y los raptores Tajobuche cazan en las tierras altas de camino al norte hacia {area:205}.\n{quest:98283} es élite: se recomienda agruparse.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp.\nStay in the {area:277}: the cave further north has Mountain and Giant Yetis (32-34) in pairs and {npc:13602}, a level 36 elite."] = "Los yetis viven en la cueva de las colinas al norte de {area:271}, de camino al norte hacia el campamento del Sindicato.\nQuédate en {area:277}: la cueva más al norte tiene Yetis monteses y Yetis gigantes (32-34) en parejas y a {npc:13602}, un élite de nivel 36.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Los yetis viven en la cueva de las colinas al norte de {area:271}, de camino de vuelta al sur.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. The {npc:271481} is held at the far west end of the {object:147516} ruins, past level 27-30 elite dwarves, and {npc:1364} (34, elite) can be among them. Lead it east out of the ruins, then hand it in to {npc:1072} in the camp. Skip it if you are alone."] = "Son enemigos élite: se recomienda agruparse, busca gente con quien hacerlo. {npc:271481} está retenido en el extremo oeste de las ruinas de {object:147516}, pasando enanos élite de nivel 27-30, y {npc:1364} (34, élite) puede estar entre ellos. Llévalo al este, fuera de las ruinas, y entrégalo a {npc:1072} en el campamento. Sáltalo si vas solo.",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "Al oeste, hasta las granjas de {area:287}: pon la {item:279386} en la mesa de contabilidad del ayuntamiento, donde están {npc:2335} y los Consejeros de Trabalomas.",
	-- ["Whelps, raptors and {npc:271458}"] = "Crías, raptores y {npc:271458}",
	-- ["for {npc:2700} at {area:320}, in 05-arathi-highlands"] = "para {npc:2700} en {area:320}, en 05-arathi-highlands",
	-- ["{area:287} town hall"] = "Ayuntamiento de {area:287}",
	-- ["{area:287}'s town hall"] = "Ayuntamiento de {area:287}",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, un raptor élite",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} está en {area:2103}; {npc:2094} y {npc:270844} están juntos junto a la puerta norte.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} está en {area:2103}; {npc:2094} está junto a la puerta norte.",
	-- ["{npc:2276}, inside: keep it, the Syndicate camp waits for the road north to Arathi (05-arathi-highlands)"] = "{npc:2276}, dentro: guárdala, el campamento del Sindicato espera al camino al norte hacia Arathi (05-arathi-highlands)",
	-- ["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, en la posada: para {area:35} (04-stranglethorn-vale)",
	-- ["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} Ginsetti también quiere una {item:3719}, un {item:2997} e {item:2321}: fabricados o comprados; la capa se entrega cuando vuelvas a {area:271} más tarde.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: para {npc:3649} en {area:442} (02-desolace)",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} entrena a los guerreros en {object:2100}, junto al Cerdo y el Silbato. {npc:6236} espera en {area:720}, en {zone:1413}, de camino a {area:392} mucho más tarde (40-50/01).",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} espera al norte de {area:205}, junto a {area:881}; {npc:271322}, un poco más al noreste.",
}
