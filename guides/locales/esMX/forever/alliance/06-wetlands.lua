-- Spanish (Latin America) (esMX): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Lanza {spell:18960}",

	-- Step 2: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. With both half pendants in your bags, stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then go to {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Lanza {spell:18960}. Con las dos mitades del colgante en tus bolsas, párate junto a {area:2362}, en la orilla noroeste del lago, y usa una mitad para unirlas; luego ve con {npc:11802} en {area:2361}. {npc:11802} está en el piso de arriba de su edificio: sube por adentro, la flecha no distingue los pisos.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}: une las mitades en {area:2362}",

	-- Step 3: Aquatic Form
	-- {quest:5061} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take {quest:5061} from {npc:11802}, upstairs in his building. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "Toma {quest:5061} de {npc:11802}, arriba en su edificio. Luego {npc:11800}, en {area:2361}, lleva a los druidas directo a {area:702}.",

	-- Step 5: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "Toma el portal de subida hasta {area:1658}, luego vuela de vuelta a {area:442} para el barco a {area:150}.",

	-- Step 7: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Vuela a {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maestro de vuelo de {area:442}",

	-- Step 8: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "A {zone:1457}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "Toma el barco desde el muelle de {area:442} hasta {area:150}.",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Vuela a {area:150}",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "Maestro de vuelo de {zone:1453}",

	-- Step 13: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, en la posada",
	-- {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, de {npc:1464}",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "{npc:2104}, junto al bastión; en el piso de arriba",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "{npc:2104}: {quest:98221}, los planes de ataque en {area:1036}",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, en el muelle al norte de la posada",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "{npc:2094}, junto a los muelles",
	-- {npc:270844} Sylessa Duskwhisper · {npc:2094} James Halloran
	["{npc:270844}, beside {npc:2094} by the docks"] = "{npc:270844}, junto a {npc:2094}, cerca de los muelles",
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {area:205} stop"] = "{npc:2097}, junto a la puerta norte: la recibe {npc:1071} en la parada de {area:205} de 30-40/01-hillsbrad-foothills",

	-- Step 14: Nord'el
	-- {item:279915} Nord'el · {area:150} Menethil Harbor
	["{item:279915} lies on the shore just south of {area:150}, a short walk past the town's south end. Then follow the coast north out of town to the hovels."] = "{item:279915} está en la orilla justo al sur de {area:150}, a poca distancia del extremo sur del pueblo. Luego sigue la costa al norte, fuera del pueblo, hasta las chozas.",

	-- Step 15: The Bluegill hovels
	["The Bluegill hovels"] = "Las chozas Branquiazul",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Sigue la costa al norte saliendo de Menethil hasta {area:1022}. Tres recipientes en las chozas de los múrlocs, de sur a norte: {object:261}, luego {object:142151}, luego {object:259} en el extremo norte.",

	-- Step 16: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "{area:1039}: mata a estos según te los encuentres",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "Sigue la costa al norte hasta el barco naufragado. Los marineros malditos recorren la playa, los marines malditos la cubierta; {npc:1159} está en la playa junto a la proa. Los crocoliscos gigantes de los Humedales acechan en la costa justo al norte.\nCuidado: Los trepadores del pantano se esconden en sigilo donde se divide el río, cerca del barco fantasma, y pueden sumarse a la pelea.",

	-- Step 17: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "Entrando desde el norte: {npc:2094} junto a los muelles, {npc:1242} en el muelle, {npc:2104} en el bastión, luego {npc:1239} en la posada.",
	-- {npc:270844} Sylessa Duskwhisper
	["{npc:270844}, beside him"] = "{npc:270844}, junto a él",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649} in {area:442}, on this guide's boat trip: keep it"] = "Para {npc:3649} en {area:442}, en el viaje en barco de esta guía: guárdalo",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: para {npc:2104}, en el castillo",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "{npc:2104}, en el piso de arriba",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Para Bolvar Fordragón en {object:2117}: guárdalo",

	-- Step 18: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "El capitán recorre la cubierta del barco naufragado; su caja fuerte está en la bodega.",

	-- Step 19: Raptor valley
	["Raptor valley"] = "El valle de los raptores",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "Sigue el camino al este: los raptores más grandes para {quest:295} cazan en el valle justo al oeste de la excavación.",

	-- Step 20: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "La excavación está en la colina al sur del camino: {npc:1078} arriba, {npc:1077} bajo tierra.",

	-- Step 21: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "{area:118}: mata a estos según te los encuentres",
	-- {npc:1353} Sarltooth · {object:331} Loose Soil
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: pull them away one at a time, or work around them."] = "Las reliquias están en la propia excavación. {npc:1353}, un gran Tajobuche, merodea por el valle de los raptores justo al oeste.\nLos celadores de Goaz (élite, 32) están entre las reliquias y {object:331}: apártalos de a uno, o rodéalos.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 22: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} y Whelgar",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "{npc:1077}, bajo tierra: {item:279993}, de los celadores de Goaz élite",

	-- Step 23: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "Celadores de Goaz",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "Los celadores de Goaz están justo al oeste del campamento de Whelgar: usa {item:279996} que te dio junto a uno.\n{npc:270892} es élite: se recomienda agruparse.",

	-- Step 24: Prospector Whelgar
	["Below ground"] = "Bajo tierra",

	-- Step 25: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "Una {item:279996} nueva, para los cuatro vigías titanes de {zone:1437}; bajo tierra. Sus corazones los sueltan élites de nivel 32 en la visita a {area:205}",

	-- Step 26: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "Al norte desde la excavación hasta el campamento Faucedraco: haz clic en los cuatro juegos de planes de ataque. El plan de {zone:1455} está en el extremo oeste del campamento, los otros tres más al este. {npc:2091}, un élite, está apartado al sureste: {quest:98221} no lo necesita.",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "{item:3337}: los asaltantes y correpantanos del campamento",

	-- Step 27: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "Sigue el camino al este hasta {area:1025}; {npc:1244} está junto al río. El pedernal de {quest:277} lo traes de tu última visita a {zone:1437}.",

	-- Step 28: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "{npc:270637} acampa entre los correpantanos, justo al oeste de {npc:1244}.",
	-- {area:1038} Dragonmaw Gates · {zone:1437} Wetlands
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor
	["Razormaw Incisors: from the raptors by the {area:1038}, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "Incisivos Tajobuche: de los raptores junto a {area:1038}, en el circuito de {zone:1437} de 30-40/01-hillsbrad-foothills",
	-- {quest:98246} Trying Times
	["{quest:98246}: the Razormaw eggs, on the same loop"] = "{quest:98246}: los huevos Tajobuche, en el mismo circuito",

	-- Step 29: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "Al este desde {npc:270637}: {npc:2093} está junto al camino.",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "{npc:2093}: para {npc:2094} en Menethil",

	-- Step 30: Fen Creepers along the river
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers along the river"] = "Trepadores del pantano a lo largo del río",
	-- {npc:2093} Einar Stonegrip · {area:1024} Sundown Marsh · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["North-west from {npc:2093} to the river: Fen Creepers hide in its pools and along its banks all the way west to {area:1024}. Work west along it until you have twelve, then back east to {npc:1244}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "Al noroeste desde {npc:2093} hasta el río: los trepadores del pantano se esconden en sus pozas y a lo largo de sus orillas, todo el camino al oeste hasta {area:1024}. Avanza al oeste por él hasta tener doce, luego vuelve al este con {npc:1244}.\nCuidado: Fuera de combate, los trepadores del pantano usan Sigilo de vez en cuando, así que están ocultos y cuesta verlos.",

	-- Step 31: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "{quest:98283}, un raptor élite, en el circuito de {zone:1437} de 30-40/01-hillsbrad-foothills",

	-- Step 32: Captain Stoutfist
	-- {area:150} Menethil Harbor · {area:2104} Deepwater Tavern · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1217} Glorin Steelbrow · {npc:2094} James Halloran
	["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:1217} in the {area:2104} south of it, {npc:2094} by the docks on the way to the boat."] = "Usa la piedra de hogar para volver a {area:150} si la vinculaste en {area:2104}, o camina al oeste por el camino: {npc:2104} está en el piso de arriba de {area:2103}, {npc:1217} en {area:2104}, al sur, y {npc:2094} junto a los muelles, de camino al barco.",
	["On the top floor"] = "En el piso superior",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "Para la catapulta Faucedraco, en el circuito de {zone:1437} de 30-40/01-hillsbrad-foothills",
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["{npc:1217}, in the {area:2104}"] = "{npc:1217}, en {area:2104}",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "Para {npc:1284} en {zone:1453}, al final de esta guía",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks, on the way to the boat"] = "{npc:2094}, junto a los muelles, de camino al barco",

	-- Step 33: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "El barco a {area:442} sale del extremo del muelle oeste de Menethil.",

	-- Step 34: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}, up the road from the dock."] = "{npc:3649} está en el extremo norte de {area:442}, camino arriba desde el muelle.",
	-- {item:279915} Nord'el · {npc:270844} Sylessa Duskwhisper · {area:150} Menethil Harbor
	["{item:279915}, from {npc:270844} in {area:150}"] = "{item:279915}, de {npc:270844} en {area:150}",

	-- Step 35: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}."] = "{npc:3649} está en el extremo norte de {area:442}.",
	-- {area:442} Auberdine
	["Alexston's reply, if you still carry it (the route hands it in on 03-darkshore-return's first {area:442} stop)"] = "La respuesta de Alexston, si todavía la llevas (la ruta la entrega en la primera parada en {area:442} de 03-darkshore-return)",

	-- Step 36: Auberdine
	-- {npc:3693} Terenthis
	["{npc:3693} stands by the flight master."] = "{npc:3693} está junto al maestro de vuelo.",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "{npc:3693}: la escolta de Volcor, del final de {zone:1439}",

	-- Step 37: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Vuela a {area:415}",

	-- Step 38: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {area:415} Astranaar
	["{npc:3845} stands by {area:415}'s flight master."] = "{npc:3845} está junto al maestro de vuelo de {area:415}.",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "Para {quest:4581} en {area:2358}",

	-- Step 39: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, adentro",

	-- Step 40: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria Sombrigélida y {npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "Las dos están juntas en el extremo oeste del camino, al suroeste de {area:415}.",

	-- Step 41: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Sigue el camino al este hasta {area:419}; {npc:3916} está junto al pozo de la luna.",

	-- Step 42: Dartol's Rod
	["Dartol's Rod"] = "Vara de transformación de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Los ancianos enloquecidos y marchitos al norte del pozo de la luna llevan la {item:5475}; el cofre desgastado que abre está entre ellos.",

	-- Step 43: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Toma el túnel hacia {area:419}; el tomo está en las ruinas de su extremo oeste.",

	-- Step 45: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Sigue el camino al este hasta los campamentos sátiros de {area:429}; {npc:3920} se esconde en su borde.",

	-- Step 46: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} dirige a los sátiros de {area:429}; él lleva la rama.",

	-- Step 47: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind · {npc:221269} Maseara Autumnmoon
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there, {npc:221269} a few steps east of her."] = "{area:2358}, el puesto de los elfos de la noche en el extremo este del camino: allí está {npc:3848}, y {npc:221269} a unos pasos al este de ella.",
	-- {npc:221269} Maseara Autumnmoon · {area:430} Satyrnaar
	["{npc:221269}: her husband's trail in {area:430}, on the way back from the lake"] = "{npc:221269}: el rastro de su esposo en {area:430}, de regreso del lago",

	-- Step 48: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "{area:432}: mata a estos según te los encuentres",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "El campamento de los Renegados está en el bosque al sur de {area:2358}.\nHay cofres oxidados alrededor de los campamentos de fúrbolgs Sombramatorral al oeste de los Renegados; ábrelos hasta que uno tenga el pomo.\nCuidado: Renegados no élite de nivel 28-30 más o menos vigilan el campamento. Algunos están en sigilo, y los que rodean la mesa suelen atacar juntos.",

	-- Step 49: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "{npc:3931} recorre la orilla de {quest:1035}, al suroeste de los cofres; {object:669176} está al norte del lago, por el camino.\nCuidado: Hay otros enemigos cerca de la isla, algunos bajo el agua. Despéjalos primero para que no se sumen cuando atraigas al oráculo.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: para {npc:3961} en {area:415}",

	-- Step 50: Satyrnaar
	-- {area:430} Satyrnaar · {area:2358} Forest Song · {object:19901} Circle of Imprisonment · {object:673431} Kurothel's Knapsack (no name in this language: may be words) · {item:281014} Vine-Wrapped Scroll · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["North from the lake to the satyr camp of {area:430}, just west of {area:2358}: the {object:19901} stands in it, and {object:673431} lies beside it with the {item:281014}.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "",
	-- {item:281014} Vine-Wrapped Scroll · {object:673431} Kurothel's Knapsack (no name in this language: may be words)
	["{item:281014}, from {object:673431}"] = "",

	-- Step 51: Kayneth Stillwind
	-- {npc:3848} Kayneth Stillwind · {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Optional: {npc:3848} also offers {quest:1012}, three level 32 druids deep in {area:432}, a cave of quickly respawning, stealthed mobs, and back to her afterwards. It is above your level here: take it only if you are grouped or want the extra XP; the guide doesn't need it."] = "Opcional: {npc:3848} también ofrece {quest:1012}, tres druidas de nivel 32 en lo profundo de {area:432}, una cueva de enemigos en sigilo que reaparecen rápido, y volver con ella después. Está por encima de tu nivel aquí: tómala solo si vas en grupo o quieres la experiencia extra; la guía no la necesita.",
	-- {npc:221269} Maseara Autumnmoon
	["{npc:221269}, a few steps east"] = "{npc:221269}, a unos pasos al este",

	-- Step 52: The Dor'Danil Barrow Den's entrance
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}'s entrance"] = "Entrada de {area:432}",

	-- Step 53: Insane druids
	["Insane druids"] = "Druidas dementes",
	-- {area:432} The Dor'Danil Barrow Den · {npc:3940} Taneel Darkwood · {npc:3941} Uthil Mooncall · {npc:3942} Mavoris Cloudsbreak
	["The three druids are inside {area:432}, apart from each other: go in at its mouth, south of the Forsaken camp, not over the hill above them. {npc:3940} is in the eastern halls, {npc:3941} deepest down at the north-east end and {npc:3942} at the western end.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Los tres druidas están dentro de {area:432}, separados: entra por su boca, al sur del campamento de los Renegados, no por la colina de encima. {npc:3940} está en las salas del este, {npc:3941} en lo más hondo, en el extremo noreste, y {npc:3942} en el extremo oeste.\nCuidado: La guarida tiene muchos enemigos que reaparecen rápido, entre ellos no-muertos en sigilo y patrullas, así que a menudo se suman enemigos de más a la pelea.",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "{npc:3940}, dentro de {area:432}",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "{npc:3941}, dentro de {area:432}",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "{npc:3942}, dentro de {area:432}",

	-- Step 55: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "El segundo {object:19901} está en el valle de {area:428}, de camino al oeste.",

	-- Step 57: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "El santuario está en la colina justo al sureste del pozo de la luna; sube por el sendero sinuoso.",

	-- Step 59: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["{npc:3691} and {npc:3961} are in the inn; {npc:3894} is inside the building just south of it."] = "{npc:3691} y {npc:3961} están en la posada; {npc:3894} está dentro del edificio justo al sur.",
	-- {npc:3961} Maliynn
	["{npc:3961}, in the inn"] = "{npc:3961}, en la posada",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside the building south of the inn"] = "{npc:3894}, dentro del edificio al sur de la posada",

	-- Step 60: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake · {item:5462} Dartol's Rod of Transformation
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}. Use {item:5462} near him first: he only speaks to you in furbolg form."] = "{npc:3897}, un fúrbolg libre de la corrupción, está sentado al sur del camino, debajo de {area:421}. Primero usa {item:5462} cerca de él: solo te habla si estás en forma de fúrbolg.",

	-- Step 61: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696} y sus guardias acampan justo al este de {npc:3897}.\nCuidado: Cerca del campamento andan lobos y arañas que pueden sumarse a la pelea. Algunos lobos van de a dos.",
	-- {item:5388} Ran Bloodtooth's Skull · {npc:3696} Ran Bloodtooth
	["{item:5388}, from {npc:3696}"] = "{item:5388}, de {npc:3696}",

	-- Step 63: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "Al oeste desde {npc:3897} por las colinas del sur hasta {area:416}: Melyria y {npc:3901} están juntas a su lado.",

	-- Step 64: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "Al norte hasta {area:413}.",

	-- Step 65: Astranaar
	-- {area:415} Astranaar · {npc:3691} Raene Wolfrunner
	["South-east along the road to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "Al sureste por el camino hasta {area:415}: {npc:3691} en la posada, el maestro de vuelo en el extremo oeste.",

	-- Step 66: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Vuela a {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Maestro de vuelo de {area:415}",

	-- Step 68: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "{npc:1571} es la maestra de vuelo junto a la posada de Menethil.",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maestro de vuelo de {area:150}",

	-- Step 70: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Sacerdotes de {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} y {npc:258785} están en {object:32386}, en {object:32362}.",

	-- Step 71: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "Tranvía a {zone:1453}",

	-- Step 72: Cathedral of Light
	["Cathedral of Light"] = "Cathedral of Light",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Toma {area:2257} desde {object:171524} hasta {object:28027} de {zone:1453} y luego camina hasta {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, en la catedral",

	-- Step 73: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Solo si obtuviste {quest:337} en {zone:1431}",

	-- Step 74: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "De vuelta a la catedral: {npc:928} está dentro.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Para {npc:2228} en {area:271}: guárdalo",

	-- Step 75: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} y {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, la quesería de {object:2096}",

	-- Step 76: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Siguiente: vuela a {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["North from the lake to the satyr camp of {area:430}, just west of {area:2358}: the {object:19901} stands in it, and Kurothel's Knapsack lies beside it with the {item:281014}.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "Al norte del lago, hasta el campamento sátiro de {area:430}, justo al oeste de {area:2358}: allí está {object:19901}, y la mochila de Kurothel está a su lado con {item:281014}.\nCuidado: los pícaros Almizcle Vil de {area:428} suelen ir en sigilo, y en {area:430} hay sátiros lanzadores de hechizos.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end. Careful: Terrowulf Fleshrippers and Shadow Weavers (28-30) stand in tight packs around the tome, and the {npc:3792}, a level 32 rare, walks the vale. Pull the wolves one at a time from the tunnel and let the Packlord pass first."] = "Toma el túnel hacia {area:419}; el tomo está en las ruinas de su extremo oeste. Cuidado: los desgarradores y tejesombras Luporror (28-30) están en manadas cerradas alrededor del tomo, y el {npc:3792}, una criatura rara de nivel 32, recorre el valle. Atrae a los lobos de uno en uno desde el túnel y deja pasar primero al Señor de la manada.",
	-- ["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "Las reliquias están en la propia excavación. {npc:1353}, un gran Tajobuche, merodea por el valle de raptores justo al oeste.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, el puesto de los elfos de la noche en el extremo este del camino: allí está {npc:3848}.",
	-- ["{item:15885}: join the two halves"] = "{item:15885}: une las dos mitades",
	-- ["{item:281014}, from Kurothel's Knapsack"] = "{item:281014}, de la mochila de Kurothel",
	-- ["{npc:3691}, in the inn"] = "{npc:3691}, en la posada",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, un fúrbolg libre de la corrupción, está sentado al sur del camino, debajo de {area:421}.",
}
