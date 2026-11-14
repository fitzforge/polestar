-- Spanish (Spain) (esES): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 2: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. With both half pendants in your bags, stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then go to {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}: une las mitades en {area:2362}",

	-- Step 3: Aquatic Form
	-- {quest:5061} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take {quest:5061} from {npc:11802}, upstairs in his building. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "",

	-- Step 5: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "",

	-- Step 7: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 8: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "",

	-- Step 13: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, en la posada",
	-- {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, de {npc:1464}",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, en el muelle al norte de la posada",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "",
	-- {npc:270844} Sylessa Duskwhisper · {npc:2094} James Halloran
	["{npc:270844}, beside {npc:2094} by the docks"] = "{npc:270844}, junto a {npc:2094}, en los muelles",
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {area:205} stop"] = "",

	-- Step 14: James Halloran
	-- {area:17732} Excavation Site: Wetlands · {npc:2094} James Halloran
	["For your {area:17732} run, later in this guide: {npc:2094}, by the docks, wants hides from the raptors inside."] = "Para tu incursión en {area:17732}, más adelante en esta guía: {npc:2094}, junto a los muelles, quiere pieles de los raptores de dentro.",

	-- Step 15: Nord'el
	-- {item:279915} Nord'el · {area:150} Menethil Harbor
	["{item:279915} lies on the shore just south of {area:150}, a short walk past the town's south end. Then follow the coast north out of town to the hovels."] = "{item:279915} está en la orilla, justo al sur de {area:150}, a poca distancia del extremo sur del pueblo. Luego sigue la costa hacia el norte, fuera del pueblo, hasta las chozas.",

	-- Step 16: The Bluegill hovels
	["The Bluegill hovels"] = "Las chozas Branquiazul",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "",

	-- Step 17: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "",
	-- {npc:1158} Cursed Marine · {npc:270589} Nightveiled Rotheap
	["{npc:1158}; careful: {npc:270589}, a level 31 elite, roams this coast"] = "{npc:1158}; cuidado: {npc:270589}, un élite de nivel 31, ronda por esta costa",

	-- Step 18: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "",
	-- {npc:270844} Sylessa Duskwhisper
	["{npc:270844}, beside him"] = "{npc:270844}, a su lado",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649} in {area:442}, on this guide's boat trip: keep it"] = "Para {npc:3649} en {area:442}, en el viaje en barco de esta guía: guárdalo",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: para {npc:2104}, en el castillo",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "Para el Alto Señor Bolvar Fordragon en {object:2117}: guárdalo",

	-- Step 19: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "El capitán recorre la cubierta del barco naufragado; su caja fuerte está en la bodega.",

	-- Step 20: Raptor valley
	["Raptor valley"] = "El valle de los raptores",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "",

	-- Step 21: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "",

	-- Step 22: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "",
	-- {npc:1353} Sarltooth · {object:331} Loose Soil
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: pull them away one at a time, or work around them."] = "Las reliquias están en la propia excavación. {npc:1353}, un Tajobuche grande, merodea por el valle de los raptores, justo al oeste.\nLos Guardianes Goaz (élite, 32) están entre las reliquias y {object:331}: aléjalos de uno en uno o rodéalos.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: el {object:331}",

	-- Step 23: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078} y Whelgar",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "",

	-- Step 24: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "",

	-- Step 25: Prospector Whelgar
	["Below ground"] = "Bajo tierra",

	-- Step 26: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "",

	-- Step 27: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "",

	-- Step 28: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "",

	-- Step 29: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "",
	-- {area:1038} Dragonmaw Gates · {zone:1437} Wetlands
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor
	["Razormaw Incisors: from the raptors by the {area:1038}, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",
	-- {quest:98246} Trying Times
	["{quest:98246}: the Razormaw eggs, on the same loop"] = "",

	-- Step 30: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "",

	-- Step 31: Fen Creepers along the river
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers along the river"] = "",
	-- {npc:2093} Einar Stonegrip · {area:1024} Sundown Marsh · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["North-west from {npc:2093} to the river: Fen Creepers hide in its pools and along its banks all the way west to {area:1024}. Work west along it until you have twelve, then back east to {npc:1244}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "",

	-- Step 32: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",

	-- Step 33: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:260808} Highland Horror
	["For your {area:17732} run, on the way back west: {npc:1244} wants the root core of a {npc:260808} inside."] = "Para tu incursión en {area:17732}, de vuelta hacia el oeste: {npc:1244} quiere el núcleo de raíz de un {npc:260808} de dentro.",

	-- Step 34: Excavation Site: Wetlands
	-- {area:17732} Excavation Site: Wetlands · {npc:260808} Highland Horror · {npc:1244} Rethiel the Greenwarden · {npc:260326} Relic Guardian · {item:270865} Titan Relic · {npc:1077} Prospector Whelgar
	["{area:17732} is a dungeon for a group of five at about level 28 to 31. Its entrance lies just south of the road west, east of Whelgar's dig.\nInside: the Thicket raptors and Shadetooth drop the hides for Halloran, a {npc:260808} the root core for {npc:1244}. Saltspine, Shadetooth and the {npc:260326} are the bosses; the {npc:260326} drops a {item:270865}, which starts a quest for {npc:1077}."] = "{area:17732} es una mazmorra para un grupo de cinco, de nivel 28 a 31 más o menos. Su entrada está justo al sur del camino hacia el oeste, al este de la excavación de Whelgar.\nDentro: los raptores de la Espesura y Shadetooth sueltan las pieles para Halloran, y un {npc:260808} el núcleo de raíz para {npc:1244}. Saltspine, Shadetooth y el {npc:260326} son los jefes; el {npc:260326} suelta un {item:270865}, que inicia una misión para {npc:1077}.",
	-- {quest:98815} Highland Hides
	["{quest:98815}: the hides, inside"] = "{quest:98815}: las pieles, dentro",
	-- {quest:95646} Horrors in the Highland
	["{quest:95646}: the root core, inside"] = "{quest:95646}: el núcleo de raíz, dentro",

	-- Step 35: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, west of the entrance on the way back west."] = "{item:270865} de tu incursión en {area:17732}: {npc:1077} está bajo tierra en su excavación, al oeste de la entrada, de vuelta hacia el oeste.",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}, bajo tierra",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077}: para {npc:5387} en {zone:1455}, al final de esta guía",

	-- Step 36: Captain Stoutfist
	-- {area:150} Menethil Harbor · {area:2104} Deepwater Tavern · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1217} Glorin Steelbrow · {npc:2094} James Halloran
	["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:1217} in the {area:2104} south of it, {npc:2094} by the docks on the way to the boat."] = "",
	["On the top floor"] = "",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["{npc:1217}, in the {area:2104}"] = "",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks, on the way to the boat"] = "",

	-- Step 37: Level 28
	["Level 28"] = "Nivel 28",
	-- {zone:1437} Wetlands · {zone:1440} Ashenvale
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Still below level 28? That happens when you start this guide here without the {zone:1437} and {zone:1440} quests of the guides before it: top up on the Bluegill Raiders along the coast just south of Menethil before the boat, so {zone:1440}'s level 28-32 quests aren't too hard."] = "¿Aún por debajo del nivel 28? Pasa si empiezas esta guía aquí sin las misiones de {zone:1437} y {zone:1440} de las guías anteriores: sube con los Asaltantes Branquiazul de la costa, justo al sur de Menethil, antes del barco, para que las misiones de nivel 28-32 de {zone:1440} no sean demasiado difíciles.",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "sube nivel con {npc:1418}",

	-- Step 38: James Halloran
	-- {npc:2094} James Halloran
	["Your Excavation Site hides: {npc:2094}, by the docks."] = "Tus pieles del Yacimiento: {npc:2094}, junto a los muelles.",

	-- Step 39: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "",

	-- Step 40: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}, up the road from the dock."] = "{npc:3649} está en el extremo norte de {area:442}, subiendo por el camino desde el muelle.",
	-- {item:279915} Nord'el · {npc:270844} Sylessa Duskwhisper · {area:150} Menethil Harbor
	["{item:279915}, from {npc:270844} in {area:150}"] = "{item:279915}, de {npc:270844} en {area:150}",

	-- Step 41: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}."] = "",
	-- {area:442} Auberdine
	["Alexston's reply, if you still carry it (the route hands it in on 03-darkshore-return's first {area:442} stop)"] = "",

	-- Step 42: Auberdine
	-- {npc:3693} Terenthis
	["{npc:3693} stands by the flight master."] = "",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "",

	-- Step 43: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["Your {area:2797} brain stems: {npc:8997} stands a short walk west of {npc:3693}."] = "Tus troncos cerebrales de {area:2797}: {npc:8997} está un poco al oeste de {npc:3693}.",

	-- Step 44: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",

	-- Step 45: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {area:415} Astranaar
	["{npc:3845} stands by {area:415}'s flight master."] = "",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "",

	-- Step 46: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 47: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691} stands in the inn, beside the innkeeper."] = "{npc:3691} está en la posada, junto al tabernero.",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {zone:1439} Darkshore
	["{npc:3691}: {quest:990}, if you still carry it from {zone:1439}"] = "{npc:3691}: {quest:990}, si aún la llevas de {zone:1439}",

	-- Step 48: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria e {npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "",

	-- Step 49: Therysil
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["{npc:3585} stands at the {area:416}, a short walk from Melyria and {npc:3901}."] = "{npc:3585} está en {area:416}, a poca distancia de Melyria e {npc:3901}.",
	-- {npc:3585} Therysil · {quest:945} Therylune's Escape · {zone:1439} Darkshore
	["{npc:3585}: {quest:945}, if you still carry it from {zone:1439}"] = "{npc:3585}: {quest:945}, si aún la llevas de {zone:1439}",

	-- Step 50: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Sigue el camino al este hasta {area:419}; {npc:3916} está junto al pozo de la luna.",

	-- Step 51: Dartol's Rod
	["Dartol's Rod"] = "Vara de transformación de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Los Ancianos enloquecidos y los Ancianos marchitos al norte del pozo de la luna llevan la {item:5475}; el cofre gastado que abre está entre ellos.",

	-- Step 53: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Sigue el camino hacia el este hasta los campamentos sátiros de {area:429}; {npc:3920} se esconde en su borde.",

	-- Step 54: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} lidera a los sátiros de {area:429}; él lleva la rama.",

	-- Step 55: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind · {npc:221269} Maseara Autumnmoon
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there, {npc:221269} a few steps east of her."] = "{area:2358}, el puesto de los elfos de la noche en el extremo este del camino: allí está {npc:3848}, y {npc:221269} a unos pasos al este de ella.",
	-- {npc:221269} Maseara Autumnmoon · {area:430} Satyrnaar
	["{npc:221269}: her husband's trail in {area:430}, on the way back from the lake"] = "{npc:221269}: el rastro de su marido en {area:430}, de vuelta del lago",

	-- Step 56: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "",

	-- Step 57: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant (no name in this language: may be words)
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "",
	-- {object:669176} Gleaming Crescent Pendant (no name in this language: may be words) · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: para {npc:3961} en {area:415}",

	-- Step 58: Satyrnaar
	-- {area:430} Satyrnaar · {area:2358} Forest Song · {object:19901} Circle of Imprisonment · {object:673431} Kurothel's Knapsack (no name in this language: may be words) · {item:281014} Vine-Wrapped Scroll · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["North from the lake to the satyr camp of {area:430}, just west of {area:2358}: the {object:19901} stands in it, and {object:673431} lies beside it with the {item:281014}.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "Ve al norte desde el lago hasta el campamento sátiro de {area:430}, justo al oeste de {area:2358}: allí está el {object:19901}, y a su lado se encuentra {object:673431} con el {item:281014}.\nCuidado: los pícaros Almizcle Vil de {area:428} suelen ir en sigilo, y en {area:430} hay sátiros lanzadores de hechizos.",
	-- {item:281014} Vine-Wrapped Scroll · {object:673431} Kurothel's Knapsack (no name in this language: may be words)
	["{item:281014}, from {object:673431}"] = "{item:281014}, de {object:673431}",

	-- Step 59: Kayneth Stillwind
	-- {npc:3848} Kayneth Stillwind · {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Optional: {npc:3848} also offers {quest:1012}, three level 32 druids deep in {area:432}, a cave of quickly respawning, stealthed mobs, and back to her afterwards. It is above your level here: take it only if you are grouped or want the extra XP; the guide doesn't need it."] = "",
	-- {npc:221269} Maseara Autumnmoon
	["{npc:221269}, a few steps east"] = "{npc:221269}, a unos pasos al este",

	-- Step 60: The Dor'Danil Barrow Den's entrance
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}'s entrance"] = "",

	-- Step 61: Insane druids
	["Insane druids"] = "Druidas dementes",
	-- {area:432} The Dor'Danil Barrow Den · {npc:3940} Taneel Darkwood · {npc:3941} Uthil Mooncall · {npc:3942} Mavoris Cloudsbreak
	["The three druids are inside {area:432}, apart from each other: go in at its mouth, south of the Forsaken camp, not over the hill above them. {npc:3940} is in the eastern halls, {npc:3941} deepest down at the north-east end and {npc:3942} at the western end.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "",

	-- Step 63: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "El segundo {object:19901} está en el valle de {area:428}, de camino al oeste.",

	-- Step 65: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "El santuario está en la colina justo al sureste del pozo de la luna; sube por el sendero sinuoso.",

	-- Step 67: The Howling Vale
	-- {area:419} Howling Vale · {npc:3792} Terrowulf Packlord
	-- plural, as words: Terrowulf Fleshrippers = {npc:3789} Terrowulf Fleshripper
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end. Careful: Terrowulf Fleshrippers and Shadow Weavers (28-30) stand in tight packs around the tome, and the {npc:3792}, a level 32 rare, walks the vale. Pull the wolves one at a time from the tunnel and let the Packlord pass first."] = "Entra por el túnel en {area:419}; el tomo está en las ruinas de su extremo oeste. Cuidado: los Desgarracarnes y Tejesombras Terrolobo (28-30) están en grupos cerrados alrededor del tomo, y {npc:3792}, un raro de nivel 32, recorre el valle. Atrae a los lobos de uno en uno desde el túnel y deja pasar primero al Señor de la Manada.",

	-- Step 68: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["{npc:3691} and {npc:3961} are in the inn; {npc:3894} is inside the building just south of it."] = "",
	-- {npc:3961} Maliynn
	["{npc:3961}, in the inn"] = "",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside the building south of the inn"] = "",

	-- Step 69: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake · {item:5462} Dartol's Rod of Transformation
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}. Use {item:5462} near him first: he only speaks to you in furbolg form."] = "{npc:3897}, un furbolg al que no ha tocado la corrupción, está sentado al sur del camino, bajo {area:421}. Usa antes {item:5462} cerca de él: solo te habla si tienes forma de furbolg.",

	-- Step 70: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "",
	-- {item:5388} Ran Bloodtooth's Skull · {npc:3696} Ran Bloodtooth
	["{item:5388}, from {npc:3696}"] = "",

	-- Step 72: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "",

	-- Step 73: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {quest:967} The Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3663}: {quest:967}, if you still carry it from {zone:1439}"] = "{npc:3663}: {quest:967}, si aún la llevas de {zone:1439}",

	-- Step 74: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "",

	-- Step 75: Astranaar
	-- {area:415} Astranaar · {npc:3691} Raene Wolfrunner
	["South-east along the road to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "",

	-- Step 76: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 78: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 80: High Explorer Magellas
	-- {quest:98824} Prehistoric Prism · {npc:5387} High Explorer Magellas · {object:32356} Hall of Explorers (no name in this language: may be words) · {object:32372} Great Forge (no name in this language: may be words)
	["{quest:98824}: {npc:5387} stands in the {object:32356}, north-east of the {object:32372}."] = "{quest:98824}: {npc:5387} está en {object:32356}, al noreste de {object:32372}.",

	-- Step 81: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "Sacerdotes de {zone:1455}",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} y {npc:258785} están en {object:32386}, en {object:32362}.",

	-- Step 82: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "",

	-- Step 83: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square
	["{npc:1646} stands in the {object:2098}."] = "{npc:1646} está en {object:2098}.",
	-- {npc:1646} Baros Alexston · {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver
	["{npc:1646}: {quest:97914}, {npc:3649}'s letter, if you still carry it"] = "{npc:1646}: {quest:97914}, la carta de {npc:3649}, si aún la llevas",

	-- Step 84: Cathedral of Light
	["Cathedral of Light"] = "Catedral de la Luz",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Toma el {area:2257} desde {object:171524} hasta {object:28027} de {zone:1453} y luego camina hasta {object:2098}.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, en la catedral",

	-- Step 85: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "Solo si despojaste {quest:337} en {zone:1431}",

	-- Step 86: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "Vuelve a la catedral: {npc:928} está dentro.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "Para {npc:2228} en {area:271}: guárdalo",

	-- Step 87: Warden Thelwater
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square
	["For your {area:717} run: {npc:1719} keeps the {area:717}'s gate, south of the {object:2098}."] = "Para tu incursión en {area:717}: {npc:1719} guarda la puerta de {area:717}, al sur de {object:2098}.",

	-- Step 88: Warden Thelwater
	-- {npc:1719} Warden Thelwater · {quest:389} Bazil Thredd · {npc:1646} Baros Alexston
	["{npc:1719}: {quest:389}, from {npc:1646}"] = "{npc:1719}: {quest:389}, de {npc:1646}",

	-- Step 90: Stockade
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square · {npc:1663} Dextren Ward · {quest:389} Bazil Thredd
	["{area:717} is a dungeon for a group of five, about levels 23 to 29, and a run takes under an hour. Its gate is {npc:1719}'s, south of the {object:2098}.\nInside: the Defias prisoners, convicts and insurgents for Thelwater, {npc:1663}'s hand for Millstipe, and {quest:389} at the far end."] = "{area:717} es una mazmorra para un grupo de cinco, de nivel 23 a 29 más o menos, y una incursión dura menos de una hora. Su puerta es la de {npc:1719}, al sur de {object:2098}.\nDentro: los prisioneros, convictos e insurgentes Defias para Thelwater, la mano de {npc:1663} para Millstipe y {quest:389} al fondo.",

	-- Step 91: Warden Thelwater
	-- {npc:1719} Warden Thelwater
	["{npc:1719}, at the gate"] = "{npc:1719}, en la puerta",

	-- Step 93: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959} y {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, la quesería de {object:2096}",

	-- Step 94: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "Siguiente: vuela a {area:42}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, el puesto de los elfos de la noche en el extremo este del camino: allí está {npc:3848}.",
	-- ["{npc:3691}, in the inn"] = "{npc:3691}, en la posada",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, un furbolg al que no ha tocado la corrupción, está sentado al sur del camino, bajo {area:421}.",
}
