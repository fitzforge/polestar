-- Spanish (Spain) (esES): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Goldshire
	-- {zone:1453} Stormwind · {zone:1436} Westfall · {area:87} Goldshire · {npc:241} Remy "Two Times" · {npc:240} Marshal Dughan · {quest:40} A Fishy Peril · {quest:35} Further Concerns · {quest:109} Report to Gryan Stoutmantle
	["On the road from {zone:1453} to {zone:1436}, {area:87} is the first stop: {npc:241} stands outside the inn, {npc:240} beside him. {npc:241}'s {quest:40} goes straight to Dughan, who then gives {quest:35}; his {quest:109} goes with you to {zone:1436}."] = "",
	-- {npc:240} Marshal Dughan · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:240}: for {npc:234} at {area:108}"] = "",

	-- Step 2: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {area:18} Crystal Lake · {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["East along the road past {area:18}: {npc:248242} and {npc:248248} stand at the foot of the tower."] = "",

	-- Step 3: The bridge
	["The bridge"] = "El puente",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	-- plural, as words: Prowlers = {npc:118} Prowler
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it. His tools and Thomas's Prowlers and bears are south of the bridge, on the way back."] = "",

	-- Step 4: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "El campamento está al noreste del puente. Los Fajos de madera están alrededor del campamento y en el bosque al norte.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "",

	-- Step 5: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Está junto al río, al noroeste del campamento maderero.",

	-- Step 6: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Los Zahoríes bribones Defias acampan en las orillas de {area:86}; también sueltan los Pañuelos de lino rojo. {object:56} está en el poblado múrloc de la orilla noreste.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Pañuelos de lino rojo",

	-- Step 7: The gnoll camps
	["The gnoll camps"] = "Los campamentos gnoll",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Los gnolls Zarparrío acampan en las colinas al oeste de {area:86}; {quest:91725} están en sus campamentos.",

	-- Step 8: The Tower of Azora
	["Follow the hills south to the tower."] = "Sigue las colinas hacia el sur hasta la torre.",

	-- Step 9: Downstream
	-- {item:247813} Waterlogged Saw
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["East along the road, then into the river south of the bridge: the {item:247813}, Axe and Toolbox lie in it. Prowlers and Young Forest Bears roam its banks."] = "",

	-- Step 10: Surena Caledon
	-- {npc:6122} Gakin the Darkbinder · {quest:1689} The Binding · {item:6810} Surena's Choker · {npc:881} Surena Caledon · {area:62} Brackwell Pumpkin Patch
	["{npc:6122}'s {quest:1689} needs {item:6810}: {npc:881} (level 9) stands by the farmhouse of the {area:62}, just south of the river."] = "{quest:1689} de {npc:6122} requiere {item:6810}: {npc:881} (nivel 9) está junto a la granja de {area:62}, justo al sur del río.",

	-- Step 13: Goldshire
	-- {area:87} Goldshire · {zone:1436} Westfall · {npc:240} Marshal Dughan
	["Follow the road west to {area:87}, on the way to {zone:1436}: {npc:240} stands outside the inn."] = "",

	-- Step 14: The Binding
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6928} Bloodstone Choker · {zone:1436} Westfall
	["North along the road from {area:87} to {zone:1453}: {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}. Use the {item:6928} at the summoning circle there and defeat the voidwalker it calls, then back south through {area:87} to {zone:1436}."] = "Al norte por el camino de {area:87} a {zone:1453}: {npc:6122} espera en el sótano de {object:2164}, en {object:2101}. Usa {item:6928} en el círculo de invocación de allí y derrota al abisario que aparece; luego vuelve al sur por {area:87} hasta {zone:1436}.",
	-- {npc:5676} Summoned Voidwalker · {item:6928} Bloodstone Choker
	["{npc:5676}: use the {item:6928} at the circle"] = "{npc:5676}: usa {item:6928} en el círculo",

	-- Step 15: The Jansen Stead
	-- {zone:1436} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}: Humans may have it already from {npc:963} in Elwynn"] = "{npc:237}: puede que los Humanos ya lo tengan de {npc:963} en Elwynn",

	-- Step 17: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Solo si conseguiste una {item:1972} en el Bosque de Elwynn: haz clic derecho en ella",

	-- Step 18: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "Al sur por el camino, más allá del cruce. {npc:233} está fuera, {npc:235} en la casa, {npc:253395} en el granero al oeste. Jóvenes Colmillos y Desgarradores merodean los campos de la granja: empieza con los hígados y la carne del guiso de camino.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "",

	-- Step 19: Goretusk Snouts
	-- plural, as words: Goretusk Snouts = {item:731} Goretusk Snout
	["Goretusk Snouts"] = "",
	-- {area:108} Sentinel Hill
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks root in the fields along the road south from Saldean's to {area:108}: take their snouts on the way."] = "",

	-- Step 20: Sentinel Hill's tower and Thor
	-- {area:108} Sentinel Hill · {npc:523} Thor
	["{area:108}'s tower and {npc:523}"] = "",
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:523} Thor · {npc:878} Scout Galiaan · {npc:1323} Osric Strang · {zone:1453} Stormwind · {npc:279} Morgan Pestle · {object:2096} Trade District · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town · {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {npc:352} Dungar Longdrink
	["{npc:234} and {npc:821} stand at the top of the stone tower, {npc:491} inside it, {npc:523} the gryphon master on the south side of the hill with {npc:878} beside him. {npc:523} gives you Lewis' note for {npc:1323} with a free flight to {zone:1453}: take it now. In {zone:1453}, {npc:279}'s shop is in the {object:2096} by the gryphons, {npc:1323}'s shop, {object:2156}, in {object:2100}; {npc:1646} stands in {object:2098} on the way back to {npc:352}, the gryphon master."] = "",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "",
	-- {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:878}, beside {npc:523}"] = "",
	-- {npc:523} Thor · {zone:1453} Stormwind
	["{npc:523}: the free flight he offers goes to {zone:1453}"] = "{npc:523}: el vuelo gratis que te ofrece va a {zone:1453}",

	-- Step 21: Osric Strang
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, {object:2096}, by the gryphons"] = "",
	-- {npc:1323} Osric Strang · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town
	["{npc:1323}, {object:2156} in {object:2100}"] = "",

	-- Step 22: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:1323} Osric Strang · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["{npc:5480} trains warriors in {object:2100}, near {npc:1323}'s shop; the tram from {zone:1455} arrives in the {object:28027}, north of it. {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "{npc:5480} entrena a los guerreros en {object:2100}, cerca de la tienda de {npc:1323}; el tranvía de {zone:1455} llega a {object:28027}, al norte. {npc:6089} y {npc:6090} están juntos allí, junto a {object:2152}. {npc:6090} pelea contigo por su jarra. Si {npc:5480} no te ofrece {quest:1638}, ve directamente con {npc:6089}: te da {quest:1639} sin ella.",

	-- Step 23: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646}, {object:2098}: his compass is in his old house in {zone:1436}"] = "",

	-- Step 24: Class trainer
	["Class trainer"] = "Instructor de clase",
	-- {object:2100} Old Town · {object:2098} Cathedral Square · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["While you're in the city: Warriors and Rogues train in {object:2100}, Paladins and Priests in the Cathedral of Light across {object:2098}, Mages and Warlocks in the {object:2101}, Hunters in the {object:28027}."] = "Ya que estás en la ciudad: los guerreros y pícaros entrenan en {object:2100}, los paladines y sacerdotes en la Catedral de la Luz, al otro lado de {object:2098}, los magos y brujos en {object:2101} y los cazadores en {object:28027}.",

	-- Step 26: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {object:2098} Cathedral Square · {npc:1646} Baros Alexston
	["{npc:376} is in the Cathedral of Light, across {object:2098} from {npc:1646}."] = "",

	-- Step 27: Dungar Longdrink
	-- {npc:352} Dungar Longdrink
	["{npc:352}, the gryphon master"] = "",

	-- Step 28: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} y {npc:821} están en lo alto de la torre de piedra. {npc:491} está dentro de la torre; {npc:878}, en la ladera sur de la colina, junto a la posada y a {npc:523}, el maestro de grifos.",
	-- {npc:491} Quartermaster Lewis · {zone:1453} Stormwind
	["{npc:491}, inside: back from {zone:1453}"] = "",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, junto a {npc:878}",

	-- Step 30: Goretusk Livers as you go
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Goretusk Livers as you go"] = "",
	-- plural, as words: Goretusks = {npc:157} Goretusk · Young Goretusks = {npc:454} Young Goretusk
	["Goretusks and Young Goretusks root along every leg of this loop: kill the ones you pass for the pie's livers."] = "",

	-- Step 31: Stringy Vulture Meat as you go
	-- {item:729} Stringy Vulture Meat
	["{item:729} as you go"] = "",
	["Fleshrippers circle the fields along this loop: kill the ones you pass for the stew's meat."] = "",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: Desgarradores",

	-- Step 32: Red Leather Bandanas as you go
	-- {quest:153} Red Leather Bandanas
	["{quest:153} as you go"] = "",
	-- {item:829} Red Leather Bandana · {object:290} Furlbrow's Wardrobe
	["Every Defias on this loop can drop a {item:829}: the Trappers and Smugglers, and the guards at {object:290}."] = "",

	-- Step 33: Defias Trappers and Smugglers
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Defias Trappers and Smugglers"] = "",
	-- {area:108} Sentinel Hill · {area:918} Molsen Farm
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North-west from {area:108} toward {area:918}: Defias Trappers and Smugglers camp in the fields between them."] = "",

	-- Step 34: Molsen Farm's well
	-- {area:918} Molsen Farm
	["{area:918}'s well"] = "",
	["Fill the vial at the farm's well"] = "Llena el vial en el pozo de la granja",

	-- Step 35: Molsen Farm's Harvest Watchers
	-- {area:918} Molsen Farm
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["{area:918}'s Harvest Watchers"] = "",
	-- {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers and Golems work the fields around {area:918}; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone."] = "Los Vigilantes de la cosecha y los Gólems trabajan los campos alrededor de {area:918}; sueltan los isomuelles, los giroestabilizadores, {item:732} y a veces un {item:255155}. {npc:573}, un raro de nivel 20, anda por aquí: déjalo en paz.",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Vigilantes de la cosecha",
	-- {item:814} Flask of Oil · {npc:392} Captain Grayson · {area:115} Westfall Lighthouse
	["{item:814}: keep five for {npc:392} at the {area:115}, later on the route"] = "{item:814}: guarda cinco para {npc:392} en {area:115}, más adelante en la ruta",

	-- Step 36: The gnoll hills
	["The gnoll hills"] = "Las colinas de los gnolls",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["North to the hills above {area:111}: Riverpaw Gnolls and Scouts (level 11-13) roam there, east toward the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer."] = "",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Garras gnoll",

	-- Step 37: The Longshore murlocs
	-- {area:2} Longshore
	["The {area:2} murlocs"] = "",
	-- {area:916} The Jansen Stead
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the north coast from above the mine east toward the {area:916}: work along the beach eastward. They flee at low health: pull one at a time."] = "Los Correcostas múrloc y los Asaltantes ocupan la costa norte desde encima de la mina hacia el este, hasta {area:916}: recorre la playa hacia el este. Huyen con poca salud: atráelos de uno en uno.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Branquias de múrloc de Playa Larga",

	-- Step 38: Furlbrow's Wardrobe
	-- {object:290} Furlbrow's Wardrobe · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	["{object:290} stands in the ruined house east of the mine, on the way to the {area:916}.\nCareful: Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "",

	-- Step 39: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "",
	["Fill the vial at the well"] = "Llena el vial en el pozo",

	-- Step 40: Finish the Goretusk Livers
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Finish the Goretusk Livers"] = "",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Still short of eight? Young Goretusks root in the fields just west of {area:107}."] = "",

	-- Step 41: Finish the Stringy Vulture Meat
	-- {item:729} Stringy Vulture Meat
	["Finish the {item:729}"] = "",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Fleshrippers = {npc:199} Young Fleshripper
	["Still short of three? Young Fleshrippers circle the fields north-west of {area:107}."] = "",

	-- Step 43: Finish the Red Leather Bandanas
	-- {quest:153} Red Leather Bandanas
	["Finish the {quest:153}"] = "",
	-- {area:108} Sentinel Hill
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Still short of fifteen? Defias Trappers camp in the fields just west of {area:108}."] = "",

	-- Step 44: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Para {npc:266} en {area:69}, Montañas Crestagrana",

	-- Step 45: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "De vuelta al norte, más allá de {area:918}, hasta la mina: los Cavadores kóbold trabajan dentro.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Cavadores kóbold",

	-- Step 46: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "Al suroeste, hacia la costa, al oeste de {area:918}. Los Mineros Zarparrío trabajan en la cantera.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineros Zarparrío",

	-- Step 47: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {object:1166} Alexston's Chest · {area:219} Alexston Farmstead · {npc:1646} Baros Alexston · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}. {object:1166} stands in the farmhouse at the {area:219}, among them: {npc:1646}' compass is inside.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "",
	-- {item:2998} A Simple Compass · {object:1166} Alexston's Chest
	["{item:2998}, from {object:1166}"] = "",

	-- Step 48: Sentinel Hill
	-- {npc:523} Thor
	["{npc:523}, on the south side of the hill"] = "{npc:523}, en el lado sur de la colina",

	-- Step 50: High Priestess Laurena
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "{npc:376} está en la Catedral de la Luz.",

	-- Step 52: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "",
	-- {quest:2998} Tome of Divinity
	["Right-click the {quest:2998} he gives you"] = "",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "",

	-- Step 53: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 54: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 55: Shaman training
	["Shaman training"] = "Instrucción de chamán",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Ve a {zone:1453}. No tiene instructor de chamán: toma el {area:2257} desde el {object:28027} hasta {zone:1455}, entrena con {npc:258098}, luego toma el tren de vuelta para el barco.",

	-- Step 56: Tram to Ironforge
	-- {area:16919} Hall of Thanes · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["For your {area:16919} run: the {area:2257} from the {object:28027} to {zone:1455}."] = "Para tu incursión en {area:16919}: el {area:2257} desde {object:28027} hasta {zone:1455}.",

	-- Step 57: Thom Filch and Afadra Dunwall
	-- {npc:265003} Thom Filch · {npc:264943} Afadra Dunwall
	["{npc:265003} and {npc:264943}"] = "{npc:265003} y {npc:264943}",
	-- {area:16919} Hall of Thanes · {npc:265003} Thom Filch · {npc:264943} Afadra Dunwall · {object:171709} High Seat
	["For your {area:16919} run: {npc:265003} and {npc:264943} stand a few steps apart on the city's west side, west of the {object:171709}. The hall's door is a short walk further west."] = "Para tu incursión en {area:16919}: {npc:265003} y {npc:264943} están a pocos pasos el uno del otro en el lado oeste de la ciudad, al oeste de {object:171709}. La puerta de la sala está un poco más al oeste.",

	-- Step 58: Hall of Thanes
	-- {area:16919} Hall of Thanes · {zone:1455} Ironforge · {npc:264943} Afadra Dunwall · {npc:261319} Durgen Dirgehammer · {object:147516} Dark Iron · {npc:265002} Ghostly Attendant · {npc:261306} Faldrim Anvilmar · {item:281030} Treaty of Understanding
	-- plural, as words: Enraged Apparitions = {npc:263389} Enraged Apparition · Tormented Souls = {npc:263390} Tormented Soul · Dwarven Heirlooms = {item:274289} Dwarven Heirloom
	["{area:16919} is a dungeon for a group of five at about level 15 to 16, under {zone:1455}. Its door is on the west side of the city, a short walk west of {npc:264943}.\nInside: the Enraged Apparitions and Tormented Souls are {npc:264943}'s, the Dwarven Heirlooms Thom's, and {npc:261319}, the {object:147516} commander deep in the vaults, carries the head King Magni wants. A {npc:265002} inside gives An Ancient Grudge, for {npc:261306}, and takes it back there; a {item:281030} found inside starts a quest for King Magni."] = "{area:16919} es una mazmorra para un grupo de cinco, de nivel 15 a 16 más o menos, bajo {zone:1455}. Su puerta está en el lado oeste de la ciudad, un poco al oeste de {npc:264943}.\nDentro: las Apariciones enfurecidas y las Almas atormentadas son para {npc:264943}, las Reliquias enanas para Thom, y {npc:261319}, el comandante {object:147516} del fondo de las cámaras, lleva la cabeza que quiere el rey Magni. Un {npc:265002} de dentro da An Ancient Grudge, para {npc:261306}, y la recoge allí mismo; un {item:281030} que encuentras dentro inicia una misión para el rey Magni.",
	-- {quest:96403} Important Heirlooms
	["{quest:96403}: the heirlooms, inside"] = "{quest:96403}: las reliquias, dentro",
	-- {quest:96394} The Restless Dead
	["{quest:96394}, inside"] = "{quest:96394}, dentro",
	-- {quest:96393} Old Ironforge Incursion · {npc:261319} Durgen Dirgehammer
	["{quest:96393}: {npc:261319}, inside"] = "{quest:96393}: {npc:261319}, dentro",

	-- Step 61: King Magni Bronzebeard
	-- {quest:96393} Old Ironforge Incursion · {object:171709} High Seat
	["{quest:96393}: King Magni sits on the {object:171709}, east of the hall's door."] = "{quest:96393}: el rey Magni está sentado en {object:171709}, al este de la puerta de la sala.",

	-- Step 63: Back to Stormwind
	-- {zone:1453} Stormwind
	["Back to {zone:1453}"] = "",
	-- {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back from {object:171524} to {zone:1453}'s {object:28027}."] = "Vuelve en el tranvía de {object:171524} a {object:28027} de {zone:1453}.",
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tranvía a {zone:1453}",

	-- Step 64: Stormwind
	-- {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters), the Park (Druids)."] = "Instructores: {object:2100} (guerreros, pícaros), la Catedral (paladines, sacerdotes), {object:2101} (magos, brujos), {object:28027} (cazadores), el Parque (druidas).",
	["In through the main gate (already done if you are in the city)"] = "",
	["Level 12, 14 and 16 spells"] = "Hechizos de nivel 12, 14 y 16",

	-- Step 65: Back to Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back: it comes out in {zone:1453}'s {object:28027}, where the errands below start."] = "",

	-- Step 66: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} para Reunir los ingredientes del remedio (6123) en {zone:1439}: {npc:1313}, Suministros de alquimia; los herboristas la recogen allí",
	-- {npc:1416} Grimand Elmore · {npc:1343} Mountaineer Stormpike · {zone:1432} Loch Modan
	["{npc:1416}: his package for {npc:1343} in {zone:1432}, later on the route"] = "{npc:1416}: su paquete para {npc:1343} en {zone:1432}, más adelante en la ruta",
	-- {npc:7232} Borgus Steelhand · {object:28027} Dwarven District · {area:442} Auberdine
	["{npc:7232}, {object:28027}: for his brother in {area:442}"] = "",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, Sagrario del Mago: {quest:1861}",

	-- Step 68: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 69: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 70: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 71: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 72: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 74: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vende suministros de pesca junto al canal, justo al oeste de {object:2096}; {npc:267118} pesca en el puerto, de camino al barco.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, de {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:108}"] = "Vuelve a {area:108}",
	-- ["Defensive Stance"] = "Actitud defensiva",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Los Acechacaminos Defias y los Sacudillos recorren {area:20}; los Bandoleros (nivel 17) patrullan en parejas las colinas al sur y al este: sepáralos. La entrada a {area:1581}, en la herrería, es una mazmorra de grupo.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Los Saqueadores Defias y los Despojadores ocupan las granjas al oeste de {area:108}, entre el camino de la costa y {area:20}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Vuela o cabalga hasta {zone:1453}. Instructores: {object:2100} (guerreros, pícaros), la Catedral (paladines, sacerdotes), {object:2101} (magos, brujos), el Parque (druidas). {npc:11026} trabaja en {object:28027}; {npc:279}, en {object:2096}.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:23299} (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Vuela o cabalga hasta {zone:1453}. Instructores: {object:2100} (guerreros, pícaros), la Catedral (paladines, sacerdotes), {object:2101} (magos, brujos), {object:23299} (druidas). {npc:11026} trabaja en {object:28027}; {npc:279}, en {object:2096}.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Vuela o cabalga hasta {zone:1453}. {npc:5480} entrena a los guerreros en {object:2100}; {npc:6089} y {npc:6090} están juntos junto a {object:2152}, allí mismo. {npc:6090} pelea contigo por su jarra.",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Vuela o camina hasta {zone:1453}. Instructores: {object:2100} (Guerreros, Pícaros), la Catedral (Paladines, Sacerdotes), {object:2101} (Magos, Brujos), el Parque (Druidas).",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Vuela o camina hasta {zone:1453}. {npc:376} está en la Catedral de la Luz.",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Vuela o camina hasta {zone:1453}. {npc:5480} entrena guerreros en {object:2100}; {npc:6089} y {npc:6090} están juntos junto a {object:2152} allí. {npc:6090} luchará contigo por su jarra.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "Sigue el camino de Elwynn hasta {zone:1436}: los Furlbrow están sentados junto a su granja quemada, la primera al borde del camino. Recoge la avena de los Sacos de avena de los campos mientras avanzas.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Sigue el camino hacia el norte. {npc:233} está fuera, {npc:235} Saldean en la casa y {npc:253395} en el granero al oeste.",
	-- ["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Para {npc:11026}, en {object:28027} de {zone:1453}",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Más al norte por el camino. Los Cejade están sentados junto a su granja quemada. Recoge la avena de los Sacos de avena de los campos por el camino y llena el vial en el pozo de la finca.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Más al norte por el camino. Los Cejade están sentados junto a su granja quemada. Recoge la avena de los Sacos de avena de los campos por el camino.",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "¿Piedra de hogar en reutilización? Sigue el camino hacia el noreste.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Al norte de La Granja de Molsen. Los Tramperos Defias y los Contrabandistas acampan fuera de la mina; los Cavadores kóbold trabajan dentro. {object:290} está junto a la casa en ruinas al este de la mina.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "Al norte de La Granja de Molsen. Los Tramperos Defias y los Contrabandistas Defias acampan fuera de la mina. {object:290} está junto a la casa en ruinas al este de la mina.",
	-- ["Only if he takes the isosprings alone"] = "Solo si acepta los isomuelles por separado",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Cabalga hasta {zone:1453}. No tiene instructor de chamanes: toma el {area:2257} desde {object:28027} hasta {zone:1455}, entrena con {npc:258098} y vuelve en el tranvía para coger el barco.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "Los Gnomos de la Garra del Río y sus Exploradores (nivel 11-13) merodean por las colinas al sur de la costa, desde encima de {area:111} hasta el {area:916} hacia el este. Los gnomos más al sur y al oeste son de nivel 13-19: quédate en las colinas del norte.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Los Gnolls Zarparrío y los Exploradores recorren las colinas entre la costa y {area:916}.",
	-- ["Sacks of Oats"] = "Sacos de avena",
	-- ["The gnoll hills"] = "Las colinas de los gnolls",
	-- ["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "La mina está al suroeste de los campamentos gnoll. {item:247816} están cerca de la entrada; los Geománticos kóbold ocupan los túneles.",
	-- ["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels.\nCareful: {npc:471} (7-10), the Mine Spiders (7-9) and {npc:248474} (7) are elites deep in the mine: pull the kobolds one at a time near the entrance and back out if an elite comes; they're easier with a friend."] = "La mina está al suroeste de los campamentos gnoll. {item:247816} están cerca de la entrada; los Geománticos kóbold ocupan los túneles.\nCuidado: {npc:471} (7-10), las Arañas mineras (7-9) y {npc:248474} (7) son élites del fondo de la mina: atrae a los kóbolds de uno en uno cerca de la entrada y retírate si viene un élite; son más fáciles con un amigo.",
	-- ["The north coast"] = "La costa norte",
	-- ["The western farms"] = "Las granjas del oeste",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "Al oeste de La Granja de Molsen, hacia la costa. Los Mineros Zarparrío trabajan en la cantera.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Los Dentosangre jóvenes y los Desgarradores recorren los campos alrededor de la granja: empieza con los hígados y la carne del estofado a la vuelta.",
	-- ["{area:20} and the Defias hills"] = "{area:20} y las colinas Defias",
	-- ["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, {skill:171} Supplies; herbalists pick it there instead"] = "{item:2449} para Reunir los ingredientes del remedio (6123) en {zone:1439}: {npc:1313}, suministros de {skill:171}; los herboristas la recogen allí",
	-- ["{item:254676}, from the crates around {area:20}"] = "{item:254676}, de las cajas alrededor de {area:20}",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} y {npc:821} están en lo alto de la torre de piedra. {npc:491} está dentro de la torre; {npc:878} y {npc:253092}, en la ladera sur de la colina, junto a la posada y a {npc:523}, el maestro de grifos.",
	-- ["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}; los Humanos se lo quitaron a {npc:963} en Elwynn",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089}: Actitud defensiva",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153}: los suelta cualquier Defias",
}
