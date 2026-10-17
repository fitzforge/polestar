-- Spanish (Spain) (esES): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:2094} James Halloran · {npc:270844} Sylessa Duskwhisper
	["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} está en {area:2103}; {npc:2094} y {npc:270844} están juntos junto a la puerta norte.",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}"] = "{npc:2104}: para {npc:270637}",
	-- {npc:270844} Sylessa Duskwhisper · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: para {npc:3649} en {area:442} (02-desolace)",

	-- Step 2: Prospector Whelgar
	-- {area:118} Whelgar's Excavation Site
	["Follow the road east to {area:118}."] = "Sigue el camino hacia el este hasta {area:118}.",

	-- Step 3: Goaz Warder
	-- {item:279996} Goaz Stone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Los Guardianes de Goaz están justo al oeste del campamento del Prospector Whelgar: usa junto a uno la {item:279996} que te dio.",

	-- Step 4: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Una nueva {item:279996}, para los cuatro vigías titánicos de {zone:1437}",

	-- Step 5: The Green Belt
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Sigue el camino hacia el noreste hasta {area:1025}: {npc:270637} acampa junto a él y {npc:1244}, un poco al este.",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, un raptor élite",

	-- Step 6: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "Al sur, hasta {area:1036} de los Faucedraco; {object:671518} está en el campamento.",
	-- {quest:98221} From the Ashes
	["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Destruye los cuatro juegos de planes de ataque del campamento para {quest:98221}.",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: para {npc:2104}",

	-- Step 7: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} está en las colinas del sureste: usa la {item:279996} junto a él.",

	-- Step 8: Dragonmaw Gates
	-- {area:1038} Dragonmaw Gates · {npc:271373} Subdued Dragonspawn · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "Al noreste, hasta {area:1038}: allí retienen a {npc:271373} y {npc:271338} está en las puertas (usa la {item:279996}).",

	-- Step 9: Whelps, raptors and Neru
	-- {npc:271458} Neru
	["Whelps, raptors and {npc:271458}"] = "Crías, raptores y {npc:271458}",
	-- {area:1025} The Green Belt · {npc:271458} Neru · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Las Crías rojas llenan las colinas al oeste de las puertas; los Garrapútrea enajenados, {area:1025}; los Tajobuche, las laderas del norte. {npc:271458} está en el noreste (usa la {item:279996}).\n{quest:98283} es élite: se recomienda ir en grupo.",

	-- Step 10: The Green Belt
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Para el Rey Magni Barbabronce en {zone:1455}, al final de esta guía",

	-- Step 11: Dun Modr
	-- {area:205} Dun Modr · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental · {npc:1072} Roggo Harlbarrow
	["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "Al norte por el camino hasta {area:205}. {npc:271460} está en las ruinas (usa la {item:279996}); {npc:271481} está retenido en el lado oeste: llévalo hasta {npc:1072}.",

	-- Step 12: The Villards
	["The Villards"] = "Los Villardo",
	-- {npc:5683} Comar Villard · {area:205} Dun Modr · {area:881} Thandol Span · {npc:271322} Essene Villard
	["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} espera al norte de {area:205}, junto a {area:881}; {npc:271322}, un poco más al noreste.",

	-- Step 13: Prospector Whelgar
	["Back south down the road to the excavation site."] = "Vuelve al sur por el camino hasta la excavación.",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Para {npc:2916} en {zone:1455}, al final de esta guía",

	-- Step 14: Menethil Harbor
	["West along the road to Menethil."] = "Al oeste por el camino hasta Puerto de Menethil.",

	-- Step 15: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Barco a {area:271}",

	-- Step 16: Southshore
	-- {npc:251493} Captain McManus · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly
	["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Recoge todo en el pueblo antes de salir. Al bajar del barco, {npc:251493} es el primero que encuentras, al noroeste del maestro de vuelo; {npc:2381} y {npc:2438} están entre el maestro de vuelo y la posada; el Teniente Farren Orinelle y {npc:2366}, en la posada; el Magistrado Henry Maleb, en el ayuntamiento.",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, de {npc:2381}",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: los leones vienen después",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, en la posada: para {area:35} (04-stranglethorn-vale)",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: su rastro lleva a las Tierras Altas de Arathi",

	-- Step 17: Torn Fin murlocs
	["Torn Fin murlocs"] = "Múrlocs Rompeanca",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Los múrlocs Rompeanca abarrotan {area:295}, al suroeste de {area:271}.",

	-- Step 18: Farren
	["Farren"] = "Teniente Farren Orinelle",

	-- Step 19: Murloc heads
	["Murloc heads"] = "Cabezas de múrloc",
	["Back to the same murlocs; not every one drops a head."] = "Vuelve a los mismos múrlocs; no todos sueltan una cabeza.",

	-- Step 21: Daggerspine naga
	["Daggerspine naga"] = "Nagas Espinadaga",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Los nagas ocupan la costa al sureste de {area:271}.",

	-- Step 22: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}"] = "Un informe para {object:2117}",

	-- Step 23: Snapjaws
	["Snapjaws"] = "Quijafortes",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Las tortugas Quijaforte toman el sol junto al río al este de {area:271}, al sur de {area:272} (Horda).",

	-- Step 24: Syndicate camp
	["Syndicate camp"] = "Campamento del Sindicato",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "El campamento del Sindicato está en la frontera con las Montañas de Alterac, al norte de {area:287}, al oeste de {area:272} (Horda); los documentos están en el campamento.",

	-- Step 25: Yeti cave
	["Yeti cave"] = "Cueva de los yetis",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Los yetis viven en la cueva de las colinas al norte de {area:271}, de camino de vuelta al sur.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} Ginsetti también quiere una {item:3719}, un {item:2997} e {item:2321}: fabricados o comprados; la capa se entrega cuando vuelvas a {area:271} más tarde.",

	-- Step 26: Hillsbrad's town hall
	-- {area:287} Hillsbrad
	["{area:287}'s town hall"] = "Ayuntamiento de {area:287}",
	-- {area:287} Hillsbrad · {item:279386} Sealed Company Request · {npc:2335} Magistrate Burnside
	["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "Al oeste, hasta las granjas de {area:287}: pon la {item:279386} en la mesa de contabilidad del ayuntamiento, donde están {npc:2335} y los Consejeros de Trabalomas.",
	-- {area:287} Hillsbrad
	["{area:287} town hall"] = "Ayuntamiento de {area:287}",

	-- Step 28: Fly to Stormwind City
	-- {zone:1453} Stormwind City
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {npc:2432} Darla Harris · {area:271} Southshore
	["From {npc:2432} in {area:271}"] = "Desde {npc:2432} en {area:271}",

	-- Step 29: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "La quesería de {object:2096}.",

	-- Step 30: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} espera en la taberna del Cerdo y el Silbato, en {object:2100}; él y sus dos matones pelean contigo, pero paran al ser derrotados.",

	-- Step 31: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} entrena a los guerreros en {object:2100}, junto al Cerdo y el Silbato. {npc:6236} espera en {area:720}, en {zone:1413}, de camino a {area:392} mucho más tarde (40-50/01).",

	-- Step 33: Cathedral of Light
	["Cathedral of Light"] = "Catedral de la Luz",

	-- Step 34: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} está en {object:2164}; {npc:211033}, cerca del canal; {npc:5081}, al sur de {object:2101}.",

	-- Step 36: Druid training
	["Druid training"] = "Instrucción de druida",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind City
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} no tiene instructor de druidas: entrena con {npc:5504} en {zone:1453} antes del tranvía.",

	-- Step 37: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Toma el {area:2257} desde {object:28027} hasta {zone:1455}.",
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	["Level 30 and 32 spells"] = "Hechizos de nivel 30 y 32",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Sigue el camino hacia el noreste hasta {area:1025}: {npc:270637} acampa junto a él y {npc:1244}, un poco al este.",
	-- ["Golm"] = "Golm",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Las Crías rojas llenan las colinas al oeste de las puertas; los Garrapútrea enajenados, {area:1025}; los Tajobuche, las laderas del norte. Neru está en el noreste (usa la {item:279996}).\n{quest:98283} es élite: se recomienda ir en grupo.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455} no tiene instructor de druidas: entrena con {npc:5504} en {zone:1453} antes del tranvía.",
}
