-- Spanish (Latin America) (esMX): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "El centro de {zone:1454}",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, para \"Ojolodo\" Jarl",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "{npc:3354}, {object:172958}: para {area:720}, más adelante en esta guía (se ofrece desde el nivel 30)",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "Vuela al Cruce",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} está junto al maestro de vuelo del Cruce.",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "para {npc:4485} en {zone:1454}, al final de esta guía",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Vuela a {area:378}",
	["Crossroads flight master"] = "Maestro de vuelo del Cruce",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Ve al este desde {area:378} por el camino hacia el pantano. {area:403}, calcinada, está a un lado justo después de la frontera; el escudo, la insignia y las huellas de pezuña están dentro y junto a la ruina.",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "Toma el camino al norte en la bifurcación hasta el poblado ogro de Poblado Murohelecho.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, en el borde sur del poblado, donde entra el camino",

	-- Step 11: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} espera en {area:2302}, al este del poblado. Síguelo hasta Reethe y mantenlo con vida durante la pelea que se desata.",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "Stinky Ignatz",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Ve al norte hasta {area:502}. Stinky está al pie de la colina; escóltalo mientras recoge hojas de frijol de pantano justo al sur.",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "Múrlocs Ancalodo",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Los múrlocs Ancalodo llenan la costa al este y noreste de {area:502}; todos los tipos sueltan cabezas.",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "Swamp Eye Jarl",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Jarl vive en {area:497}, al sureste de {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, junto a la mansión",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "{quest:1218}, si no las compraste en {zone:1454}",

	-- Step 15: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "{area:496}: mata a estos según te los encuentres",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Regresa al oeste cruzando el pantano. Los Escupetósigos Colmiumbrío de las lomas al norte de Poblado Murohelecho sueltan las bolsas de veneno. Los Infiltrados de Theramore (35-36) se mueven a escondidas por el mismo bosque: van en sigilo, así que mira con atención.\nLas arañas Niebla Negra pululan en la entrada de la cueva al noroeste de Poblado Murohelecho; todos los tipos sueltan ojos.\nCuidado: Los acechadores Colmiumbrío (nivel 36-37) usan Sigilo para ocultarse fuera de combate y lanzan Veneno una vez en pelea.\nCuidado: Las arañas en sigilo de la misma zona te atacan en cuanto te ven.\nCuidado: Los acechadores Niebla Negra se mueven en sigilo y usan veneno una vez en combate. Las arañas están muy juntas, así que es común que se sumen más; atraer objetivos sueltos desde el borde exterior lo reduce.",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Head east back to the {area:497}."] = "Regresa al este a {area:497}.",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, ahora que {npc:4791} leyó el informe",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "solo si llevas una {item:3853} ({skill:164} o la casa de subastas)",

	-- Step 18: The Theramore Docks
	-- {area:513} Theramore Isle · {object:20925} Captain's Footlocker
	["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer."] = "Al sureste desde la mansión hasta {area:513}: {object:20925} está en el fondo del mar frente a los muelles del lado este de la isla. Entra y sal nadando y mantente lejos de los muelles y del pueblo: los guardias de Theramore son de nivel 53-57, y morir aquí implica una larga carrera de regreso desde el Ángel de la Resurrección.",
	["Underwater"] = "Bajo el agua",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "Regresa al oeste a Poblado Murohelecho con la cabeza: {npc:4503} está en el borde sur del poblado, donde entra el camino, y {npc:4791} en el poblado.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words)
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "Para {npc:2519} en {object:3202}, en forever/horde/40-50/01-stranglethorn-vale",

	-- Step 20: Level 37.5
	["Level 37.5"] = "Nivel 37.5",
	-- {zone:1443} Desolace
	["{zone:1443}'s last quests and Alterac are 38-41. Still below 37.5 after Brackenwall's hand-ins? The Darkmist spiders and Lurkers (35-38) by the cavern north-west of the village are the closest: kill them until level 37.5."] = "Las últimas misiones de {zone:1443} y Alterac son de nivel 38-41. ¿Sigues por debajo de 37.5 después de las entregas de Poblado Murohelecho? Las arañas y los acechadores Niebla Negra (35-38) junto a la cueva al noroeste del poblado son los más cercanos: mátalos hasta el nivel 37.5.",
	["Darkmist cavern"] = "Cueva Niebla Negra",
	-- {npc:4377} Darkmist Lurker
	["grind on {npc:4377}"] = "farmea {npc:4377}",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "Maestro de vuelo de {area:496}",

	-- Step 22: Ratchet
	-- {npc:3446} Mebok Mizzyrix
	["{npc:3446} stands below Gazlowe's house by the flight master, towards the docks."] = "{npc:3446} está debajo de la casa de Gazlowe, junto al maestro de vuelo, en dirección a los muelles.",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Dirígete al sur por la costa desde {area:392} hasta {area:720}. {npc:6236} está junto a la arena: pisa la rejilla para empezar la pelea; los retadores llegan de uno en uno, y luego {npc:6238} (33).",

	-- Step 24: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "Vuela a {area:2408}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maestro de vuelo de {area:392}",

	-- Step 25: Shadowprey Village
	-- {npc:11624} Taiga Wisemane
	["{npc:11624} stands in the village."] = "{npc:11624} está en la aldea.",

	-- Step 26: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "Dirígete al este hasta {area:602}. Con {quest:5381} de {npc:11624} en tus bolsas, abre el anillo de un portal demoníaco: sale un {npc:11937} (38-39); mátalo para cerrar ese portal. Seis portales. Cuidado: Los infernales, los guardias apocalípticos y los invocadores del Filo Ardiente caminan cerca de muchos portales y pueden unirse; mata primero a los enemigos cercanos o aleja al guardián, por ejemplo hacia el lago central del aquelarre.",

	-- Step 27: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["North to the post; {npc:5412} stands beside {npc:5395}."] = "Al norte, al puesto; {npc:5412} está junto a {npc:5395}.",
	-- {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["{npc:5395}: his {quest:1366}, from the same Maraudine"] = "{npc:5395}: su {quest:1366}, de los mismos Maraudine",

	-- Step 28: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["West of the post, the Maraudine centaurs hold the {area:607}. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Maraudine (36-39) in the valley: the Magram's village in the south-east has the same drops, but its Necromancers (42-43) and Guardians (39-41) are well above you."] = "Al oeste del puesto, los centauros Maraudine ocupan {area:607}. Cualquier Maraudine puede soltar un {item:254432} y una oreja para {quest:1366} de {npc:5395}. Quédate con los Maraudine (36-39) del valle: la aldea de los Magram en el sureste tiene el mismo botín, pero sus nigromantes (42-43) y guardianes (39-41) te superan bastante en nivel.",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} está cautiva en el campamento Maraudine del extremo oeste del valle; libérala y escóltala fuera del valle por el este.\nCuidado: Los grupos programados están vinculados y solo aparecen durante la escolta, así que no puedes despejarlos antes ni atraerlos de uno en uno. Sí ayuda despejar a los centauros normales del camino antes de empezar.",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} espera en el campamento goblin del lado oeste de {area:596}.",

	-- Step 31: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {zone:1443} Desolace · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["Head south-east to the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge. Use the {item:15848} at the arrow to draw the Magrami Spectres: they drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "Dirígete al sureste hasta los campos de huesos de {area:2657}, donde rondan los devastadores no muertos, en el borde sur de {zone:1443}. Usa {item:15848} en la flecha para atraer a los espectros Magrami: sueltan el ectoplasma.\nCuidado: Los necrokhans Magram y los devoracadáveres (45, élite) recorren los campos de huesos justo al oeste de la flecha y te superan bastante en nivel: usa la caja en la flecha, en el lado este del valle, y aleja a los espectros de ellos.",

	-- Step 32: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard
	["North to the goblin camp on the west side of the {area:596}."] = "Al norte, al campamento goblin en el lado oeste de {area:596}.",

	-- Step 34: Shadowprey
	["Shadowprey"] = "Aldea Cazasombras",
	["West to Shadowprey."] = "Al oeste, a Aldea Cazasombras.",

	-- Step 35: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "Vuela de {area:2408} a {area:1638} y entrena con {npc:3033} en {area:1639}; desde allí, sigue volando a {zone:1454}.",

	-- Step 36: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",

	-- Step 37: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "De vuelta a {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Maestro de vuelo de {zone:1456}",

	-- Step 38: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "{npc:4485} está en {object:172958}.",

	-- Step 39: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "El taller de {npc:3412} está en {object:172958}, junto a {npc:4485}: entrega {quest:2841} si hiciste {area:133}.",

	-- Step 40: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "Instructores de {zone:1454}",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "Entrena mientras estás en la ciudad; los demás entrenan en {zone:1458}, a continuación.",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "La siguiente guía toma el zepelín de {zone:1458} desde la torre que está fuera de la puerta principal.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "Arañas Colmiumbrío",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "Para {npc:2519} en {object:3202}, en la siguiente guía",
	-- ["Hearth to {area:392}"] = "Usa tu piedra de hogar para ir a {area:392}",
	-- ["Kodo bones and ghosts"] = "Huesos de kodo y fantasmas",
	-- ["Maraudine totems"] = "Tótems Maraudine",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Recoge los huesos de kodo esparcidos por el cementerio y usa {item:15848} entre los huesos: los fantasmas que atrae sueltan el ectoplasma.",
	-- ["Ride back west to Brackenwall with the head."] = "Regresa cabalgando al oeste a Poblado Murohelecho con la cabeza.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Cabalga al este hasta {area:602}. Usa la vara de destierro junto a cada portal demoníaco para cerrar seis de ellos.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "Cabalga al norte desde el aquelarre hasta {npc:5412}, en {area:597}.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "Cabalga al norte por el camino hasta la choza junto al camino al norte del cementerio.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Cabalga al noreste hasta {area:607}. {npc:12277} está cautiva en el campamento de los centauros Maraudine; libérala y escóltala fuera del valle por el este.",
	-- ["Ride on south-west to Shadowprey."] = "Sigue cabalgando al suroeste hasta Aldea Cazasombras.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Cabalga al sur desde {area:2405} hacia {area:607}. Los Exploradores Maraudine ({npc:4654}), Retadores, Aplastadores, Cazavientos y Merodeadores (36-39) sueltan {quest:93225}.",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Cabalga al oeste, de vuelta por el pantano. Los Escupetósigos Colmiumbrío ({npc:4414}) en las lomas al norte de Poblado Murohelecho sueltan las bolsas de veneno. Los Infiltrados de Theramore ({npc:4834}) (35-36) se mueven por el mismo bosque: usan sigilo, así que mira con atención.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Cabalga al oeste hasta la torre de {npc:11863} en {area:2405}, en la costa noroeste.",
	-- ["Slitherblade coast"] = "Costa Filozante",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Los de Filo Ardiente ocupan la fortaleza al noroeste de {area:2407}. Usa {item:14523} en el {npc:11876} de la fortaleza para obtener {item:13542}.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Las arañas Niebla Negra pululan en la entrada de la cueva al noroeste de Poblado Murohelecho; todos los tipos sueltan ojos.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Las nagas Filozante ocupan la costa al norte de {area:2405}, hasta {area:598}. {npc:12369} custodia {quest:6027} en la punta norte.",
	-- ["The next guide takes you back to {zone:1434}."] = "La siguiente guía te lleva de vuelta a {zone:1434}.",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "La caravana de {npc:11626} se detiene en el camino, al borde de {area:602}. Escóltala al este pasando el aquelarre; los demonios la atacan dos veces.",
	-- ["{npc:3391}: for {npc:4631} in {area:35}, on the first {area:35} stop of 40-50"] = "{npc:3391}: para {npc:4631} en {area:35}, en la primera parada en {area:35} de 40-50",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} y {npc:5412} están en el poblado justo al oeste del campamento de {npc:11596}.",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}: Actitud rabiosa",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: la guía anterior te vincula aquí, así que esto suele marcarse de inmediato",
}
