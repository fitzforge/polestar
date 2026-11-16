-- Spanish (Spain) (esES): the guide forever/horde/30-40/02-thousand-needles (forever/horde/30-40/02-thousand-needles.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 2: Alliance Relations
	-- {zone:1454} Orgrimmar · {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits
	["The zeppelin lands at the tower outside {zone:1454}'s main gate. {npc:5639} walks the Drag: if he isn't at the arrow, look along its streets to the south-west. {npc:5640} stands in the {object:172961} on the west side of the city."] = "El zepelín aterriza en la torre que hay fuera de la puerta principal de {zone:1454}. {npc:5639} recorre La Calle Mayor: si no está en la flecha, búscalo por sus calles al suroeste. {npc:5640} está en {object:172961}, en el lado oeste de la ciudad.",
	-- {npc:5639} Craven Drok
	["{npc:5639}: offered from level 30"] = "",
	-- {npc:5641} Takata Steelblade · {zone:1443} Desolace
	["for {npc:5641} in {zone:1443}, later in this guide"] = "",

	-- Step 3: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	["Train while you are in the city."] = "",

	-- Step 4: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} está en {object:172957}.",
	-- {npc:5892} Searn Firewarder · {npc:5905} Prate Cloudseer · {area:484} Freewind Post
	["{npc:5892}: for {npc:5905} by {area:484}, later in this guide"] = "",

	-- Step 5: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows
	["{npc:3428}'s {quest:1145} needed level 29 on the last guide's Crossroads stop: take it now, on a short flight to the Crossroads and back."] = "{quest:1145} de {npc:3428} requería nivel 29 en la parada en el Cruce de la guía anterior: acéptala ahora, con un vuelo corto al Cruce y de vuelta.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 6: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 7: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	["Crossroads flight master"] = "Maestro de vuelo del Cruce",

	-- Step 8: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, later in this guide"] = "para {npc:4483} en {area:439}, más adelante en esta guía",

	-- Step 10: Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {area:484} from there."] = "",

	-- Step 11: Islen Waterseer
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:5901} Islen Waterseer · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to {area:484} from {area:392}."] = "",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527} y tu {item:5177}",

	-- Step 12: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Vuela a {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 13: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 15: Prate Cloudseer
	-- {npc:5905} Prate Cloudseer
	["{npc:5905} hides in a small cave in the canyon wall north-east of the post, on the way east."] = "",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: tu {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} también inicia Elemental Aid ({area:1717}), la cadena de 33-40 hasta las armas de la Tempestad: forever/class/shaman/call-of-air-horde.",

	-- Step 16: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {area:484} Freewind Post
	["{npc:2986} waits on the mesa just north-east of {area:484}, across the rope bridges."] = "{npc:2986} espera en la meseta justo al noreste de {area:484}, cruzando los puentes de cuerda.",
	-- {npc:2986} Dorn Plainstalker · {npc:4490} Grenka Bloodscreech
	["{npc:2986}: {npc:4490}, in the harpy den west of the post"] = "{npc:2986}: {npc:4490}, en la guarida de arpías al oeste del puesto",

	-- Step 17: Jandia
	-- {npc:4877} Jandia · {area:484} Freewind Post
	["{npc:4877}, the trade supplies vendor, stands inside {area:484}'s inn."] = "{npc:4877}, la mercader de suministros comerciales, está dentro de la posada de {area:484}.",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}: the Screeching harpies of {area:487}"] = "{npc:4877}: las arpías chillonas de {area:487}",
	-- {npc:4877} Jandia
	["{npc:4877}: her stolen supplies lie in the same harpy den"] = "",

	-- Step 18: The Screeching Canyon: kill these as you meet them
	-- {area:483} The Screeching Canyon
	["{area:483}: kill these as you meet them"] = "",
	-- {area:2097} Darkcloud Pinnacle · {area:487} Roguefeather Den · {npc:4877} Jandia · {quest:98069} Stolen Freewind Supplies · {npc:4490} Grenka Bloodscreech · {npc:2986} Dorn Plainstalker
	["West of Freewind Post, below {area:2097}, the harpies of {area:487} (28-30). The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s; her {quest:98069} lie on the ground along the foot of the cliff and in the cave up on top. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her, for {npc:2986}'s claw."] = "Al oeste de Poblado Viento Libre, bajo {area:2097}, están las arpías de {area:487} (28-30). Las arpías chillonas, Plumaspícaras y Clamavientos de allí son para {npc:4877}; sus {quest:98069} están en el suelo al pie del acantilado y en la cueva de arriba. {npc:4490} (31) camina entre ellas: despeja las arpías a su alrededor antes de atraerla, para la garra de {npc:2986}.",
	-- {quest:98069} Stolen Freewind Supplies
	["{quest:98069}, on the ground around the den"] = "",
	-- {item:5843} Grenka's Claw · {npc:4490} Grenka Bloodscreech
	["{item:5843}, from {npc:4490}"] = "{item:5843}, de {npc:4490}",

	-- Step 19: Jandia
	-- {area:484} Freewind Post
	["Back east to {area:484}."] = "Vuelve al este a {area:484}.",
	-- {npc:4877} Jandia
	["{npc:4877}, inside the inn"] = "{npc:4877}, dentro de la posada",

	-- Step 20: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {npc:4499} Rok'Alim the Pounder
	["Back across to {npc:2986}'s mesa north-east of the post, then take the lift down to the canyon floor. {npc:2986}'s next test, {npc:4499}, is an elite: leave it."] = "Cruza de nuevo a la meseta de {npc:2986}, al noreste del poblado, y baja en el elevador al fondo del cañón. La siguiente prueba de {npc:2986}, {npc:4499}, es élite: déjala.",

	-- Step 21: Stormheart
	-- {npc:270094} Stormheart · {area:484} Freewind Post
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:270094} is a level 30 elite: most classes solo it at level 32, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:270094} walks the canyon road east of {area:484}'s lift, on the way to the salt flats: kill him for his heart."] = "Son enemigos élite: se recomienda ir en grupo, busca gente con quien hacerlo. {npc:270094} es un élite de nivel 30: la mayoría de clases lo matan solas a nivel 32, pero puede que necesites ayuda. Sáltalo si vas solo: la ruta te hace recuperar la experiencia matando enemigos.\n{npc:270094} recorre el camino del cañón al este del elevador de {area:484}, de camino a las salinas: mátalo para obtener su corazón.",
	-- {item:279186} Stormheart's Still-beating Heart · {npc:270094} Stormheart
	["{item:279186}, from {npc:270094}"] = "{item:279186}, de {npc:270094}",

	-- Step 22: Moktar Krin
	-- {npc:4483} Moktar Krin
	["Take the lift down and follow the canyon east. {npc:4483} camps on the north-western edge of the salt flats."] = "",

	-- Step 23: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "",
	-- {npc:4452} Kravel Koalbeard · {quest:5762} Hemet Nesingwary
	["{npc:4452}'s crate for {quest:5762} in Stranglethorn, later on the route"] = "",

	-- Step 24: Shimmering Flats: kill these as you meet them
	-- {area:439} Shimmering Flats
	["{area:439}: kill these as you meet them"] = "",
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["North-east of the raceway onto the flats. The Saltstone Basilisks (30-31) sun themselves north-west of it, and the Sparkleshell Tortoises (30-31) wander among them on the western flats; the Salt Flats Scavengers and Vultures circle the eastern flats. Every vulture drops a bone, about one tortoise in three a shell.\nCareful: Scavengers and Vultures use Execute when your health is low. The Sparkleshell Snappers (34-35) crowd round a half-buried ship in the north-east and are over you here: the Tortoises of the western flats drop the shells just as often, so stay with them. Take the venom from the Reavers (31-32) of the north half and leave the Scorpid Terrors (33-34) further south."] = "Al noreste del circuito, hacia los llanos. Los Basiliscos Gapo Salino (30-31) toman el sol al noroeste, y las Tortugas brillavalva (30-31) deambulan entre ellos en los llanos occidentales; los Carroñeros de los Llanos de Sal y los buitres sobrevuelan los llanos orientales. Cada buitre suelta un hueso y más o menos una de cada tres tortugas un caparazón.\nCuidado: Carroñeros y buitres usan Ejecutar cuando tienes poca salud. Los Sacudidores caparallantes (34-35) se agolpan en torno a un barco semienterrado al noreste y te superan de nivel: las tortugas de los llanos occidentales sueltan caparazones con la misma frecuencia, así que quédate con ellas. Consigue el veneno de los Atracadores (31-32) de la mitad norte y deja los Terrores escórpidos (33-34) más al sur.",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises of the western flats"] = "{item:5795}, de las Tortugas brillavalva de los llanos occidentales",
	-- {object:19868} Rocket Car Rubble
	["{object:19868}, all over the northern flats: pick it on the western flats, away from the Snappers"] = "{object:19868}, por todos los llanos del norte: recógelos en los llanos occidentales, lejos de los Sacudidores",
	-- {quest:1104} Salt Flat Venom
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["{quest:1104}, from the Scorpid Reavers of the north half"] = "",

	-- Step 25: Mirage Raceway
	["South-west back to the raceway."] = "",
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: his parts order goes to {quest:1111} in {area:392}, later on the route"] = "",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, at 39"] = "",
	-- {npc:4630} Pozzik · {area:392} Ratchet
	["{npc:4630}: for Gazlowe in {area:392}, later on the route"] = "",

	-- Step 26: Level 32
	["Level 32"] = "Nivel 32",
	-- {zone:1443} Desolace · {area:1717} Razorfen Kraul
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["The flats' south and the silithid dig are 32-35, {zone:1443}'s quests 32-38. Still below 32 after the raceway's hand-ins? Back north on the flats, the Scorpid Reavers (31-32) roam among the basilisks and tortoises: kill them until level 32; leave the Sparkleshell Snappers (34-35) and the Scorpid Terrors (33-34) alone. Or, with a group, run the {area:1717} dungeon instead."] = "El sur de los llanos y la excavación silítida son de nivel 32-35, y las misiones de {zone:1443}, 32-38. ¿Sigues por debajo de 32 tras las entregas del circuito? Vuelve al norte de los llanos: los Atracadores escórpidos (31-32) deambulan entre basiliscos y tortugas; mátalos hasta el nivel 32 y deja en paz a los Sacudidores caparallantes (34-35) y los Terrores escórpidos (33-34). O, con grupo, haz la mazmorra {area:1717}.",
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["Scorpid Reavers"] = "Atracadores escórpidos",
	-- {npc:4140} Scorpid Reaver
	["grind on {npc:4140}"] = "sube nivel con {npc:4140}",

	-- Step 27: The southern flats
	["The southern flats"] = "",
	-- plural, as words: Saltstone Crystalhides = {npc:4151} Saltstone Crystalhide
	["South of the raceway, the Saltstone Crystalhides (32-33) and Gazers (34-35) roam the far end of the flats.\nCareful: the level 35 Gazers can still be two over you: pull them one at a time from the camp's edge, never two together."] = "Al sur del circuito, los Vitropiel Gapo Salino (32-33) y los Contempladores (34-35) recorren el extremo de los llanos.\nCuidado: los Contempladores de nivel 35 aún pueden superarte en dos niveles: atráelos de uno en uno desde el borde del campamento, nunca dos a la vez.",

	-- Step 28: The Rustmaul Dig Site
	-- {item:5877} Cracked Silithid Carapace · {npc:4132} Silithid Ravager
	["West of them the silithid swarm the dig site. Searchers and Hive Drones walk among the mounds; the Invaders (34-35) stay inside the hive cave. The first silithid you kill drops a {item:5877}: open it.\nCareful: Hive Drones call for help when they fall to 20% health, and the {npc:4132} (37, rare) walks the dig: take the Searchers and Drones (32-34) outside first, then pull the Invaders (34-35) one at a time from the cave mouth."] = "Al oeste, los silítidos infestan la excavación. Buscadores y Zánganos de la colmena caminan entre los montículos; los Invasores (34-35) se quedan dentro de la cueva de la colmena. El primer silítido que mates suelta un {item:5877}: ábrelo.\nCuidado: los Zánganos piden ayuda al bajar al 20% de salud, y el {npc:4132} (37, raro) recorre la excavación: mata primero fuera a Buscadores y Zánganos (32-34) y luego atrae a los Invasores (34-35) de uno en uno desde la entrada de la cueva.",

	-- Step 29: Parts of the Swarm
	["Keep killing silithid at the dig site for the heart, the talons and the carapaces."] = "",

	-- Step 30: Moktar Krin
	-- {npc:4483} Moktar Krin
	["North from the dig to {npc:4483}'s camp on the western edge of the flats."] = "",

	-- Step 31: Mirage Raceway
	-- {area:976} Gadgetzan
	["East to the raceway, on the way south to {area:976}."] = "Ve al este hasta el circuito, de camino al sur hacia {area:976}.",

	-- Step 32: Gadgetzan
	-- {zone:1446} Tanaris · {area:976} Gadgetzan · {area:484} Freewind Post
	["South from the raceway over the {zone:1446} border to {area:976}, the walled goblin town: learn its flight path and fly back to {area:484} from there, which is quicker than the walk west across the flats, and the next guides fly straight to {area:976}."] = "Al sur desde el circuito, cruzando la frontera de {zone:1446}, hasta {area:976}, el pueblo goblin amurallado: aprende su ruta de vuelo y vuelve volando a {area:484} desde allí, que es más rápido que cruzar a pie las salinas hacia el oeste, y las siguientes guías vuelan directamente a {area:976}.",

	-- Step 34: Freewind Post
	-- {npc:10537} Cliffwatcher Longhorn
	["{npc:10537} stands in the middle of the post, on the way to the flight master."] = "",
	-- {npc:10537} Cliffwatcher Longhorn · {npc:11259} Nataka Longhorn · {zone:1443} Desolace
	["{npc:10537}: for {npc:11259} in {zone:1443}, next"] = "",

	-- Step 35: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Vuela a {area:460}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 37: Scrabblescrew's Camp
	-- {zone:1443} Desolace · {npc:11596} Smeed Scrabblescrew
	["Head south out of Stonetalon into {zone:1443} and follow the road south to {npc:11596}'s camp."] = "",

	-- Step 38: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:11259} Nataka Longhorn · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post, {npc:11259} up on its rise; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "",
	-- {npc:11259} Nataka Longhorn
	["{npc:11259}, up on the rise"] = "",

	-- Step 40: Takata Steelblade and Maurin Bonesplitter
	-- {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter
	["{npc:5641} and {npc:4498}"] = "{npc:5641} y {npc:4498}",

	-- Step 41: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo · {npc:11521} Kodo Apparition
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. At his camp, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time. Careful: leave the kodo skulls on the ground alone: opening one raises a {npc:11521} (37-38) that hits hard."] = "Usa el {item:13892} de {npc:11596} sobre un kodo envejecido, moribundo o {npc:4702} del cementerio y lleva el kodo domado de vuelta con {npc:11596}. En su campamento, habla con el kodo: así cuenta y puedes domar el siguiente. Cinco kodos, de uno en uno. Cuidado: no toques los cráneos de kodo del suelo: al abrir uno aparece una {npc:11521} (37-38) que pega fuerte.",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 43: Shadowprey Village
	-- {area:606} Gelkis Village · {npc:268705} Aka'rai · {quest:97265} Hate the Hatefury
	["Head west to the troll village on the coast, keeping clear of the {area:606} on the way. {npc:268705} stands on the path just north of the village.\n{npc:268705} may not be here on Forever: if {npc:268705} doesn't offer {quest:97265}, skip it."] = "",
	-- {npc:268705} Aka'rai · {area:603} Sargeron
	["{npc:268705}: the Hatefury satyrs of {area:603}, later in this guide"] = "",
	-- {npc:11877} Roon Wildmane · {quest:5762} Hemet Nesingwary
	["{npc:11877}: for {quest:5762} in Stranglethorn, next guide"] = "",
	-- {npc:6726} Thalon
	["{npc:6726}, at the village's south-west end"] = "",

	-- Step 44: Ethel Rethor
	-- {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress · {area:2406} Ranazjar Isle
	["Head north along the coast, then inland to the ruined tower of {area:2405}: {npc:11863} waits inside. The coast's clams and naga come after {area:599}, on one walk north to {area:2406}."] = "Ve al norte por la costa y luego hacia el interior hasta la torre en ruinas de {area:2405}: {npc:11863} espera dentro. Las almejas y los naga de la costa vienen después de {area:599}, en un solo recorrido hacia el norte hasta {area:2406}.",

	-- Step 45: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {npc:13019} Burning Blade Seer · {item:20310} Flayed Demon Skin · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {zone:1443} Desolace
	["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it. Leave the red {object:176581} for now: its {npc:11876} is 37, and the second {zone:1443} visit comes back for it."] = "Ve al este hasta {area:599}. Debilita a un cultista Filo Ardiente y usa la {item:6436} sobre él antes de que muera para llenar una {item:6435}. El {npc:13019} está en el piso superior de la fortaleza con el Cetro. Los cultistas también sueltan a veces una {item:20310} (1-5%); si te sale una, léela. Deja por ahora el {object:176581} rojo: su {npc:11876} es de nivel 37, y la segunda visita a {zone:1443} vuelve a por él.",
	["On the top floor"] = "",

	-- Step 46: Ethel Rethor
	-- {npc:11863} Azore Aldamort
	["Back west to {npc:11863}."] = "",
	-- {npc:11863} Azore Aldamort · {item:15803} Book of the Ancients · {npc:12369} Lord Kragaru · {area:2406} Ranazjar Isle
	["{npc:11863}'s next errand, the {item:15803}, needs {npc:12369} (38) out on {area:2406}: leave it, he is over your level."] = "El siguiente encargo de {npc:11863}, el {item:15803}, requiere a {npc:12369} (38) en {area:2406}: déjalo, está por encima de tu nivel.",

	-- Step 47: Rackmore's Log
	-- {object:177787} Rackmore's Log · {npc:11863} Azore Aldamort
	["{object:177787} lies on the ground just south-west of {npc:11863}'s tower, on the way down to the shore: read it. Its two keys drop only while you have the quest."] = "{object:177787} está en el suelo justo al suroeste de la torre de {npc:11863}, de camino a la orilla: léelo. Sus dos llaves solo caen mientras tienes la misión.",

	-- Step 48: Clam beds
	["Clam beds"] = "Lechos de almejas",
	-- {item:15874} Soft-shelled Clam · {item:15878} Rackmore's Silver Key
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler · Drysnap Crawlers = {npc:11562} Drysnap Crawler
	["West to the shore. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach: each clam you open on the sea floor, and some crawlers, give a {item:15874}. Open each one in your bags for its meat.\nThe Drysnap Crawlers and Pincers on the same beach carry {item:15878}, about one in seven."] = "Ve al oeste hasta la orilla. Las almejas gigantes de concha blanda yacen en los bajíos y los reptadores de arrecife enfurecidos recorren la playa: cada almeja que abres en el fondo del mar, y algunos reptadores, dan una {item:15874}. Ábrela en tus bolsas para obtener su carne.\nLos reptadores y tenazas Pinzaseca de la misma playa llevan {item:15878}, aproximadamente uno de cada siete.",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam
	["Giant Softshell Clams, on the sea floor"] = "",
	-- {item:15874} Soft-shelled Clam
	["{item:15874}: open it in your bags"] = "",
	["Underwater"] = "Bajo el agua",
	-- {item:15878} Rackmore's Silver Key
	["{item:15878}, from the Drysnap crabs"] = "{item:15878}, de los cangrejos Pinzaseca",

	-- Step 49: Sar'theris Strand
	-- {area:598} Sar'theris Strand · {item:15881} Rackmore's Golden Key · {zone:1443} Desolace
	["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), up to two over you at 33: work the Naga and Sorceresses (32-33) of the southern half until the key drops, and leave the north for the second {zone:1443} visit, at 38."] = "Sigue al norte hasta {area:598} para la {item:15881}: cualquier Filozante puede soltarla.\nCuidado: los mirmidones (34-35) ocupan la mitad norte de la playa junto a las brujas del mar y los oráculos (34-36, lanzadores), hasta dos niveles por encima de ti a 33: mata a los naga y hechiceras (32-33) de la mitad sur hasta que caiga la llave, y deja el norte para la segunda visita a {zone:1443}, a nivel 38.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, de los naga Filozante",

	-- Step 50: Rackmore's Chest
	-- {area:2406} Ranazjar Isle · {object:177786} Rackmore's Chest · {object:177673} Serpent Statue
	["Swim out to {area:2406} off the far northern tip: {object:177786} stands on the shore beside the {object:177673}. Open it with both keys; leave the statue alone."] = "Nada hasta {area:2406}, frente al extremo norte: {object:177786} está en la orilla junto a la {object:177673}. Ábrelo con ambas llaves; no toques la estatua.",

	-- Step 51: Sargeron
	-- {area:599} Thunder Axe Fortress · {area:603} Sargeron · {npc:268705} Aka'rai
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["Head east past {area:599} and along the northern hills to the satyrs' ruins of {area:603}. Kill every kind you meet for {npc:268705}; the Shadowstalkers walk unseen.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "",
	-- {npc:4671} Hatefury Trickster
	["{npc:4671}, on the way south"] = "",

	-- Step 52: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["South to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "",

	-- Step 53: Ghost Walker Post
	["South-west down the road to the post."] = "",
	-- {npc:5641} Takata Steelblade · {npc:5640} Keldran · {zone:1454} Orgrimmar
	["{npc:5641}: for {npc:5640} in {zone:1454}, next guide"] = "",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "El siguiente encargo de {npc:5641} te manda a por un señor demoníaco con escolta élite: omítelo.",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace · {area:607} Valley of Spears
	["{npc:5395} now offers Centaur Bounty: the second {zone:1443} visit, at 38, takes it on its way to the {area:607}."] = "{npc:5395} ofrece ahora Centaur Bounty: la segunda visita a {zone:1443}, a nivel 38, la acepta de camino a {area:607}.",

	-- Step 54: Shadowprey Village
	["West to Shadowprey: your hearthstone is bound there."] = "",
	-- {npc:268705} Aka'rai
	["{npc:268705}, on the path just north of the village"] = "",
	-- {item:14547} Hand of Iruxos · {zone:1443} Desolace · {zone:1454} Orgrimmar · {zone:1434} Stranglethorn Vale
	["Taiga's {item:14547}, Drulzegar's Other Fish to Fry and {zone:1443}'s other 37-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "La {item:14547} de Taiga, Other Fish to Fry de Drulzegar y las demás misiones de 37-40 de {zone:1443} esperan a la segunda visita, a nivel 38: las siguientes guías vuelan a {zone:1454} y toman el zepelín a {zone:1434}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {npc:11863}'s tower."] = "Vuelve al sur hasta la torre de {npc:11863}.",
	-- ["Keep north to {area:598}. The Slitherblade Myrmidons, Naga and Sorceresses hold the beach; pull them one at a time. Any Slitherblade can drop {item:15881}."] = "Sigue al norte hasta {area:598}. Los mirmidones, naga y hechiceras Filozante ocupan la playa; atráelos de uno en uno. Cualquier Filozante puede soltar {item:15881}.",
	-- ["Shadowprey's {quest:5381} and the coast's naga want 33. Below that? The Kolkar centaurs (30-32) of {area:609}, a short way east of {npc:11596}'s camp, are the nearest camp at your level: kill them until level 33. The Scorpashi Lashers (34-35) on the slopes north of the camp are higher. Or, with a group, run the {area:1717} dungeon instead."] = "{quest:5381} de la Aldea Cazasombras y los naga de la costa piden nivel 33. ¿Estás por debajo? Los centauros Kolkar (30-32) de {area:609}, un poco al este del campamento de {npc:11596}, son el campamento más cercano de tu nivel: mátalos hasta el nivel 33. Los azotadores Scorpashi (34-35) de las laderas al norte del campamento son de nivel más alto. O, con un grupo, haz en su lugar la mazmorra {area:1717}.",
	-- ["Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}. He is well above you: rest to full first. {object:177786} stands on the shore beside the statue: open it with both keys."] = "Nada hasta {area:2406}, frente al extremo norte, y usa {item:15766} en {object:177673}: aparece {npc:12369} (38); mátalo para obtener {quest:6027}. Tiene bastante más nivel que tú: descansa hasta estar al máximo antes. {object:177786} está en la orilla junto a la estatua: ábrelo con ambas llaves.",
	-- ["grind on {npc:4635}"] = "sube nivel con {npc:4635}",
	-- ["{item:15766}, on the {object:177673}"] = "{item:15766}, en {object:177673}",
}
