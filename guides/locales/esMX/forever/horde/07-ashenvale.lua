-- Spanish (Latin America) (esMX): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zoram'gar Outpost
	-- {area:392} Ratchet · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale
	["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "Vuela de {area:392} a {area:2897}, en la costa de {zone:1440}.",
	-- {npc:12717} Muglash
	["{npc:12717}: starts his escort at once"] = "{npc:12717}: su escolta empieza de inmediato",

	-- Step 2: Vorsha the Lasher
	-- {npc:12717} Muglash
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717} camina al norte por la playa hasta un brasero naga. Apaga el brasero y luego protégelo de las oleadas de nagas hasta que Vorsha la Azotadora muera.",
	["Naga brazier"] = "Brasero naga",

	-- Step 3: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "Ruinas de {area:2797}",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "El camino hacia los zafiros pasa por las ruinas hundidas en el extremo norte de la playa: baja las escaleras al foso.",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "Zafiros de Aku'Mai",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "Los zafiros son cristales azules en las paredes de los túneles que llevan al portal de {area:2797}, bajo tierra y fuera de la instancia: nada hacia abajo desde el foso, bajo el muro, hasta la cueva. Los sátiros y nagas de los túneles son élite: se recomienda ir en grupo. Los cristales reaparecen rápido, así que no hace falta adentrarse.",

	-- Step 5: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "{npc:12736} ofrece luego una misión de {area:2797}; déjala salvo que tengas grupo.",

	-- Step 6: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "Al este de Zoram'gar, los furbolgs Piel de Cardo llenan el poblado y las colinas alrededor de su bastión.",

	-- Step 7: Thistlefur Hold
	["Thistlefur Hold"] = "Bastión Piel de Cardo",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "Dentro del bastión, hay Cofres trol ({object:178144}) a lo largo de los túneles. {npc:12818} está cautivo en lo más profundo: libéralo y protégelo hasta la salida; luego corre a casa, a {area:428}.",

	-- Step 8: Zoram'gar Outpost
	["Back west to Zoram'gar before heading east for good."] = "Regresa al oeste a Zoram'gar antes de dirigirte al este definitivamente.",

	-- Step 9: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "Sigue el camino principal al este, pasando {area:415} (Alianza: no te salgas del camino). {npc:12678}, un gran oso pardo, ronda {area:418} al sur del camino, al oeste de {area:421}. Su pata inicia la siguiente misión de cacería.",

	-- Step 10: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "Fuente de {area:418}",
	-- {area:418} Ruins of Stardust · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "La fuente está en medio de {area:418}: usa {item:7767} allí.",

	-- Step 11: Alonso
	-- {npc:210995} Alonso · {area:421} Mystral Lake
	["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}, una adición de Forever, está en la orilla oeste de {area:421} con tres misiones rápidas de Matadragones.",

	-- Step 12: Tideress
	-- {npc:12759} Tideress · {area:421} Mystral Lake · {item:16408} Befouled Water Globe
	["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}, un elemental de agua corrupto, flota en {area:421}. Su {item:16408} inicia una misión para Puesto del Hachazo.",

	-- Step 13: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "Los furbolgs Maderiza ocupan el bosque al este de {area:421}, al sur del camino. Coloca {item:16972} en {object:178206} y defiéndelo: los furbolgs vienen a derribarlo. {npc:12918} llega al final; su tótem cae en la canasta.",

	-- Step 14: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "Sigue al este por el camino. {npc:12858} espera al suroeste del Aserradero Grito de Guerra. Él y sus bruteros asaltan {area:2360}: deja que ellos atraigan la atención de los enemigos y quédate con {npc:12858} hasta que {npc:12860} muera.",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} está en el aserradero. Las Avanzadas elfas de la noche acechan en el bosque al sureste; usan sigilo, así que estate atento.",

	-- Step 16: Splintertree Post
	-- {area:431} Splintertree Post · {area:428} Night Run
	["North up the road to {area:431} and {area:428} beside it."] = "Al norte por el camino hasta {area:431} y {area:428}, a su lado.",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}: solo si llevas las páginas del manual",

	-- Step 17: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}, una gran sable de la noche, merodea el bosque al sureste del Aserradero Grito de Guerra. Su garra inicia la siguiente misión de cacería.",

	-- Step 18: Felmusk satyrs
	["Felmusk satyrs"] = "Sátiros Putredor",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "Al noroeste de Puesto del Hachazo, los sátiros Putredor acampan en el bosque. Cualquier sátiro puede soltar cuernos.",

	-- Step 19: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}, una pantera de las sombras, acecha el bosque alrededor de {area:426}, al oeste del campamento Putredor. Su cabeza inicia la siguiente misión de cacería.",

	-- Step 20: Mystral Lake
	-- {area:421} Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "De vuelta al suroeste, a {area:421}. Los Elementales de agua podrida ({npc:3917}) flotan alrededor de sus orillas; el mirador está en la isla, frente al puesto de la Alianza.",
	["Gazebo"] = "Mirador",

	-- Step 23: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:222} Bloodhoof Village · {npc:2995} Tal
	["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "Vuela a {area:1638} si conoces la ruta de vuelo. Si no, vuela a {area:378}, cabalga al oeste hacia {zone:1412} pasando {area:222} hasta {area:1638} y obtén su ruta de vuelo con {npc:2995}, en la elevación central.",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "Habla con {npc:3057}, en {area:1638}: {quest:93739}",

	-- Step 24: The Earthen Ring
	["The Earthen Ring"] = "El Anillo de la Tierra",
	-- {zone:1456} Thunder Bluff · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury
	["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "Baja en un elevador desde {zone:1456}. El campamento del Anillo de la Tierra está al norte de los riscos: {npc:264074}, {npc:264072} y {npc:259118}.",

	-- Step 25: Gloomrise
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "Al norte del campamento, las arañas invaden el cementerio de {area:17044}. Usa {item:273015} de {npc:264074} en los Cadáveres roídos ({npc:264096}); las Tejedoras sueltan {item:273181}. {npc:264082} está en el extremo norte: su {item:273658} inicia {quest:96294}.",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "Muestras de toxina de Alto Penumbroso ({item:273001}), de los Cadáveres roídos ({npc:264096})",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, de las Tejedoras del Alto Penumbroso ({npc:264081})",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}"] = "{item:273658}, de {npc:264082}",

	-- Step 26: The Earthen Ring
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "Regresa al sur al campamento y luego sube a {zone:1456} para volar a {area:378}.",

	-- Step 27: Brine
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {npc:5899} Brine · {area:1718} Great Lift
	["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "Vuela de {zone:1456} a {area:378}. La choza de {npc:5899} está en la loma sobre el abrevadero de los jabaespines, al sur del campamento, en el camino a {area:1718}.",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "para {npc:5901}, al sur de {area:392}: siguiente guía",

	-- Step 28: Great Lift
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {zone:1413} Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "Vuela de {zone:1456} a {area:378} y toma el camino al sur hasta {area:1718}, al fondo de {zone:1413}.",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, en lo alto del elevador",

	-- Step 29: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "Baja en el elevador y sigue el camino al este por los cañones hasta {area:484}, un poblado tauren en lo alto de las mesetas. Su elevador está en el lado norte.",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}, junto al maestro de jinetes del viento",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "{npc:4877}, la vendedora de suministros comerciales: las Arpías estridentes de {area:487}",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "El cartel de Se busca junto a {npc:10537}",

	-- Step 30: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "Baja en el elevador. El huevo está en un nido en el fondo del cañón, en uno de tres lugares: al sureste de las mesetas (52.3,55.2), al este (56.4,50.4) o al suroeste (37.6,56.1).",

	-- Step 32: Galak centaurs
	["Galak centaurs"] = "Centauros Galak",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "Los campamentos Galak llenan el cañón al norte de Poblado Viento Libre; Exploradores, Retadores y Cazavientos comparten cada campamento. Un {npc:10617} solitario camina entre los campamentos: mátalo cuando lo veas, su nota inicia una misión para {area:2237}.",

	-- Step 33: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986} está en lo alto de una meseta al este de los campamentos Galak. Para {quest:1149}, camina hasta el final de los tablones a su lado y salta: aterrizas a salvo.",

	-- Step 35: Grimtotem camps
	["Grimtotem camps"] = "Campamentos Tótem Siniestro",
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "Al oeste de Poblado Viento Libre, los campamentos Tótem Siniestro bajo {area:2097}. Las Notas secretas están en Cofres de documentos ({object:176344}) en los campamentos sureste, suroeste y noroeste.",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}, campamento sureste",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}, campamento suroeste",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}, campamento noroeste",

	-- Step 36: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "Sube por el sendero hasta la cima de {area:2097}. {npc:10646} está cautiva junto a {npc:10896} (29): primero acaba con los guardias y con {npc:10896}, luego libérala y protégela en el descenso; los emboscadores Tótem Siniestro te atacan en el camino.",

	-- Step 37: Whitereach Post
	-- {area:2237} Whitereach Post
	["Follow the canyon west to {area:2237}."] = "Sigue el cañón al oeste hasta {area:2237}.",
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "La siguiente misión de {npc:10428}, El fuego Sagrado, termina en {zone:1456}, fuera de esta ruta. Omítela.",
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "Mata al {npc:10720} que viene por {npc:10638}",

	-- Step 38: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "Al oeste de Campamento del Tramo Blanco, los dracoleones anidan en los acantilados de {area:482}; los huevos están en los nidos. {npc:10427} espera en el lado este de la zona de nidos: libéralo y mantenlo con vida en el regreso a {area:2237}.",

	-- Step 40: Roguefeather Den
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "Al sur de Cumbre de la Nube Negra, las arpías de {area:487}. {npc:4490} (31) camina entre ellas: reduce las arpías a su alrededor antes de atraerla. Las Arpías estridentes, Malaplumas y Clamavientos de allí son las de {npc:4877}.",

	-- Step 43: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499}, un elemental de roca que golpea fuerte, recorre los acantilados de {area:482}. {npc:4499} es élite: se recomienda ir en grupo.",

	-- Step 44: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Sigue el cañón al este, fuera de las mesetas, hasta el desierto de sal. Los goblins y gnomos de {area:2240} son neutrales y dan misiones a ambas facciones.",
	["His crate is for Stranglethorn, later on the route"] = "Su caja es para Vega de Tuercespina, más adelante en la ruta",

	-- Step 45: The salt flats
	["The salt flats"] = "El desierto de sal",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868} está por todo el desierto al norte de la pista. Los Atracadores escórpidos ({npc:4140}) y las Tortugas brillavalva ({npc:4142}) deambulan por la mitad norte, los Carroñeros del Desierto de Sal ({npc:4154}) vuelan en círculos y los Basiliscos Piedra de sal ({npc:4147}) pastan al oeste de la pista. Los Vitropiel deambulan por el centro del desierto y los Observadores (34-35, cinco niveles más que tú: de uno en uno) por el extremo sur.",

	-- Step 46: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}: su carta va para Martek en {zone:1418}, alrededor del nivel 38",

	-- Step 47: Freewind Post
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to {zone:1454}."] = "La siguiente guía vuela desde aquí a {zone:1454}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Shadumbra"] = "Shadumbra",
	-- ["Sharptalon"] = "Garfafilada",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Tideress"] = "Marearess",
	-- ["Ursangous"] = "Ursangous",
}
