-- Spanish (Spain) (esES): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Vuela a {area:150}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 2: Red Jack Flint
	-- {npc:4455} Red Jack Flint · {area:2103} Menethil Keep
	["{npc:4455} stands by {area:2103}'s door, just north of the flight master."] = "{npc:4455} está junto a la puerta de {area:2103}, justo al norte del maestro de vuelo.",
	-- {quest:1132} Fiora Longears
	["For {quest:1132} in Theramore's inn, where this guide's boat goes"] = "Para {quest:1132} en la posada de Theramore, adonde va el barco de esta guía",

	-- Step 3: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern · {npc:4963} Mikhail · {npc:5082} Vincent Hyal
	["{npc:1217} stands in the {area:2104}, south of the keep, where {npc:4963} and {npc:5082} wait too."] = "{npc:1217} está en {area:2104}, al sur del torreón, donde también esperan {npc:4963} y {npc:5082}.",
	["Inside"] = "",

	-- Step 4: Deepwater Tavern
	-- {quest:1248} The Missing Diplomat · {npc:4963} Mikhail
	["Tapoke Jahn (34) slips out of the tavern once you take {quest:1248}: stay close behind him. He turns on you outside, a friend joins him, and he gives up once badly hurt. If you lose him the quest fails: abandon it and take it again from {npc:4963}."] = "",

	-- Step 5: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "El pecio del Flying Osprey está en las aguas poco profundas al sur del torreón.",

	-- Step 6: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Lingotes Forjaluz",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Los múrlocs Branquiazul de la playa al suroeste de Menethil llevan los lingotes.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "",

	-- Step 7: Glorin Steelbrow
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, after Stranglethorn"] = "",

	-- Step 9: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "El maestro de vuelo está junto a la puerta de {area:514}; {npc:5083} y {npc:4964} están dentro de la ciudadela.",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "",
	-- {npc:4964} Commander Samaul · {area:503} Sentry Point
	["{npc:4964}: {area:503} is the watchtower on the road west, next"] = "",
	-- {quest:1132} Fiora Longears
	["{quest:1132}, inside the inn in the north of town"] = "{quest:1132}, dentro de la posada, en el norte del pueblo",
	-- {npc:4456} Fiora Longears · {area:415} Astranaar
	["{npc:4456}'s next errand goes to {area:415}, off this route: leave it."] = "",
	-- {quest:1132} Fiora Longears · {zone:1441} Thousand Needles
	["{quest:1132}: the wyverns are in {zone:1441}, later in this guide"] = "",

	-- Step 10: Sentry Point
	-- {area:503} Sentry Point · {area:403} Shady Rest Inn · {npc:4967} Archmage Tervosh
	["Follow the road north-west out of Theramore to the watchtower at {area:503}, where the road to the {area:403} turns west. Look around the tower: {npc:4967} appears at its foot, and you hand the quest in to him there."] = "",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the foot of the tower"] = "",
	-- {npc:4967} Archmage Tervosh · {npc:4966} Private Hendel · {area:504} North Point Tower · {zone:1445} Dustwallow Marsh
	["{npc:4967}: {npc:4966} holds {area:504}, for the {zone:1445} visit at 39"] = "",
	-- {npc:4966} Private Hendel · {zone:1445} Dustwallow Marsh
	["Take Tervosh's next errand now: he stands here only right after the hand-in. {npc:4966} waits for the next {zone:1445} visit, at about 39."] = "",

	-- Step 11: The Shady Rest Inn
	-- {zone:1413} Barrens
	["Follow the road west to the burned inn on the road toward the {zone:1413}: the black shield and Reethe's guard badge lie in the ashes and the hoofprints are in the mud beside the inn."] = "",
	-- {object:21042} Theramore Guard Badge
	["{object:21042}: for Captain Vimes, on the way back through Theramore"] = "",

	-- Step 12: Into Barrens
	-- {zone:1413} Barrens
	["Into {zone:1413}"] = "",

	-- Step 13: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "En el camino al sur por {zone:1413}, {npc:6244} acampa al este del camino, al noreste de {area:378}; acércate desde el este y evita a los guardias de la Horda.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: en {zone:1440}, de camino a {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: el íncubo, junto a la súcubo; la {item:190309} está cerca de {quest:1738}",

	-- Step 14: Myriam Moonsinger
	-- {npc:12866} Myriam Moonsinger · {area:1316} Razorfen Downs · {area:485} Great Lift
	-- plural, as words: Razorfen Battleguards = {npc:7873} Razorfen Battleguard · Death's Head Cultists = {npc:7872} Death's Head Cultist
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:12866} stands by the entrance of {area:1316}, a few hundred yards north-east of the top of the {area:485}; the Razorfen Battleguards, Thornweavers and Death's Head Cultists (33-34, elite) hold the thorny slopes around her. Skip it if you are alone."] = "",

	-- Step 15: Henrig Lonebrow's Journal
	-- {area:485} Great Lift · {zone:1441} Thousand Needles · {item:5791} Henrig Lonebrow's Journal · {area:2097} Darkcloud Pinnacle
	["Down the {area:485} into {zone:1441}. Careful: wait on the platform until the lift is level with it before you step on, and stay on it until it stops; the drop beside it kills. {item:5791} lies a couple of hundred yards north-east of the lift's foot, in {area:2097}, where the Grimtotems (25-27) camp."] = "",
	-- {item:5791} Henrig Lonebrow's Journal · {npc:4048} Falfindel Waywarder · {area:482} Highperch
	["{item:5791}: for {npc:4048}, just past {area:482}"] = "",

	-- Step 16: Highperch
	-- {area:482} Highperch
	["West to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac."] = "",

	-- Step 17: Falfindel Waywarder
	-- {npc:4048} Falfindel Waywarder · {area:482} Highperch · {zone:1444} Feralas · {area:489} Thalanaar · {area:1717} Razorfen Kraul
	["{npc:4048} camps north of {area:482}, just over the border into {zone:1444} on the path up to {area:489}: hand him the journal. His next quest is inside {area:1717}: leave it."] = "",

	-- Step 18: Thousand Needles
	-- {area:484} Freewind Post
	["East through the canyons. {area:484}, a Horde camp with guards, sits on the mesa here: keep to the canyon floor and give the foot of its lifts a wide berth."] = "Al este por los cañones. {area:484}, un campamento de la Horda con guardias, está sobre la meseta: quédate en el fondo del cañón y mantente bien lejos del pie de sus elevadores.",
	-- {area:482} Highperch
	["The canyons east of {area:482}"] = "",

	-- Step 20: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Sigue los cañones al este hasta El Desierto de Sal. Los goblins y gnomos del {area:2240} son neutrales y dan misiones a ambas facciones.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Para {quest:5762}, en la Vega de Tuercespina, más tarde",

	-- Step 21: Mirage Raceway: kill these as you meet them
	-- {area:2240} Mirage Raceway
	["{area:2240}: kill these as you meet them"] = "",
	-- {object:19868} Rocket Car Rubble · {npc:5935} Ironeye the Invincible
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Saltstone Gazers = {npc:4150} Saltstone Gazer · Scorpid Terrors = {npc:4139} Scorpid Terror
	-- was: ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half."] = "Hay {object:19868} por todo el llano. Los Atracadores escórpidos y los Carroñeros de los Llanos de Sal deambulan por la mitad norte, y las Tortugas brillavalva (30-31) por el centro: mátalas para conseguir los caparazones. Cuidado: los Sacudidores caparallantes (34-35) deambulan por todo el llano, y los Observadores Gapo Salino (34-35) y los Terrores escórpidos (33-34) ocupan el extremo sur: déjalos y quédate en la mitad norte."
	["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half.\nCareful: {npc:5935} (37, rare) roams the south-east of the flats, around 83-88,71-84: leave it be."] = "",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises"] = "{item:5795}, de las Tortugas brillavalva",
	-- {npc:4078} Collin Mauren · {zone:1453} Stormwind
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["Crystalized Scale, from the Saltstone Basilisks: eight for {npc:4078} in {zone:1453}"] = "",

	-- Step 22: Mirage Raceway
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: for {quest:1111} on {area:392}'s dock, where this guide ends"] = "",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, at the end of 30-40"] = "",
	-- {npc:4630} Pozzik · {npc:3391} Gazlowe · {area:392} Ratchet
	["{npc:4630}: for {npc:3391} in {area:392}, on the way to the boat"] = "",

	-- Step 23: Into Tanaris
	-- {zone:1446} Tanaris
	["Into {zone:1446}"] = "",
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris
	["From the raceway follow the road south out of the {area:439} into {zone:1446}."] = "",

	-- Step 24: Gadgetzan
	-- {area:976} Gadgetzan · {npc:7823} Bera Stonehammer
	["{area:976} is a short walk down the road; keep to it. {npc:7823}, the Alliance flight master, stands inside the walls."] = "",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "Vuela a Theramore",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maestro de vuelo de {area:976}",

	-- Step 26: Theramore
	-- {npc:4456} Fiora Longears · {npc:4948} Adjutant Tesoran · {area:514} Foothold Citadel · {npc:4941} Caz Twosprocket
	["{npc:4456} is in the north of town, Captain Vimes and {npc:4948} on the top floor of {area:514}; {npc:4941} stands in the town."] = "",
	-- {zone:1445} Dustwallow Marsh
	["Vimes's next errand, The Deserters, is for the {zone:1445} visit at 39: leave it."] = "",

	-- Step 27: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {area:35} Booty Bay · {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["From Theramore follow the road north-west through the marsh into the {zone:1413} and up the coast to {area:392}: Stranglethorn starts at {area:35}, across the sea. {area:392}'s gryphon master stands above the dock; {npc:3391} is upstairs in the house above it; {quest:1111} waits on the dock by the boat."] = "",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631}, on {area:35}'s dock where the boat lands"] = "",
	-- {quest:1111} Wharfmaster Dizzywig · {quest:1039} The Barrens Port · {npc:8026} Thyn'tel Bladeweaver · {zone:1457} Darnassus
	["{quest:1111}: {quest:1039}, from {npc:8026} in {zone:1457}"] = "",
	-- {quest:1111} Wharfmaster Dizzywig · {npc:3945} Caravaneer Ruzzgot · {area:35} Booty Bay
	["{quest:1111}: for {npc:3945} in {area:35}, where the boat lands"] = "",
	-- {area:2240} Mirage Raceway
	["Dizzywig's next errand goes back to the {area:2240}, which the route next visits at 45: leave it."] = "",

	-- Step 28: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco a {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Vuelve al oeste por el camino hasta los campamentos sátiros de {area:429}.",
	-- ["Boat to {area:150}"] = "Barco a {area:150}",
	-- ["Dartol's Rod"] = "Vara de transformación de Dartol",
	-- ["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Sigue el camino hacia el este hasta los campamentos sátiros de {area:429}; {npc:3920} se esconde en su borde.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Sigue el camino hacia el oeste desde {area:415}; {area:413} queda al norte.",
	-- ["From {area:608}"] = "Desde {area:608}",
	-- ["Geltharis"] = "Geltharis",
	-- ["Insane druids"] = "Druidas dementes",
	-- ["Melyria and {npc:3901}"] = "Melyria e {npc:3901}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Hay cofres oxidados alrededor de los campamentos furbolg Sombramatorral al oeste de los Renegados; ábrelos hasta que uno tenga el pomo.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "Toma el barco a {area:150} en los muelles de {area:442}.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Entra por el túnel en {area:419}; el tomo está en las ruinas de su extremo oeste.",
	-- ["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Los Ancianos enloquecidos y los Ancianos marchitos al norte del pozo de la luna llevan la {item:5475}; el cofre gastado que abre está entre ellos.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "El campamento de los Renegados está en el bosque al sur de {area:2358}.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "El pozo de la luna está en las colinas al noreste de {area:415}.",
	-- ["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "El segundo {object:19901} está en el valle de {area:428}, de camino al oeste.",
	-- ["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "El santuario está en la colina justo al sureste del pozo de la luna; sube por el sendero sinuoso.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Los tres druidas están juntos en el campamento de los Renegados al sur de {area:2358}.",
	-- ["The two stand together at the western end of the road."] = "Las dos están juntas en el extremo oeste del camino.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "El pecio del Flying Osprey está en las aguas poco profundas al sur del torreón.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "El {npc:3931} recorre la orilla del {quest:1035}, al suroeste de los cofres; el {object:669176} está al norte del lago, de camino.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "El {object:19901} está en el campamento sátiro de {area:430}, más al este por el camino.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, el puesto de los elfos de la noche en el extremo este del camino: allí están {npc:3848} y {npc:221269}.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, el puesto de los elfos de la noche en el extremo este del camino: allí está {npc:3848}.",
	-- ["{area:429} satyrs"] = "Sátiros de {area:429}",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} está en la planta superior del torreón de Menethil.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} y sus guardias acampan justo al este de {npc:3897}.",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, un furbolg al que no ha tocado la corrupción, está sentado al sur del camino, bajo {area:421}.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: para {npc:1480} en Menethil, al final de esta guía",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} lidera a los sátiros de {area:429}; él lleva la rama.",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} y {npc:4962} están en la posada de Menethil; Tapoke te ataca cuando hablas con {npc:4963}, pero se rinde al ser derrotado. {npc:1480} está a poca distancia al noreste de la posada.",
	-- ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half."] = "Hay {object:19868} por todo el llano. Los Atracadores escórpidos y los Carroñeros de los Llanos de Sal deambulan por la mitad norte, y las Tortugas brillavalva (30-31) por el centro: mátalas para conseguir los caparazones. Cuidado: los Sacudidores caparallantes (34-35) deambulan por todo el llano, y los Observadores Gapo Salino (34-35) y los Terrores escórpidos (33-34) ocupan el extremo sur: déjalos y quédate en la mitad norte.",
	-- ["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: para {npc:3961} en {area:415}",
}
