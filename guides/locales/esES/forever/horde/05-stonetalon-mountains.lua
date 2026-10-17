-- Spanish (Spain) (esES): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kadrak
	-- {area:380} Crossroads · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale · {item:16783} Bundle of Reports
	["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "Desde {area:380}, sigue el camino al norte. {npc:8582} está en la torre de vigilancia de {area:1703}, donde el camino entra en {zone:1440}. Abre {item:16783} que te da.",

	-- Step 2: Warsong Scout
	-- {npc:12862} Warsong Scout
	["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Sigue al norte por el camino. {npc:12862} espera en el campamento maderero Grito de Guerra, al sur del Puesto del Hachazo.",

	-- Step 3: Splintertree Post
	-- {area:431} Splintertree Post
	["{area:431} is just north up the road."] = "{area:431} está justo al norte, siguiendo el camino.",

	-- Step 4: Night Run
	-- {npc:12696} Senani Thunderheart · {area:428} Night Run
	["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} está en {area:428}, el campamento Grito de Guerra justo al noreste del Puesto del Hachazo, junto al tablón de caza.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "Las presas de {npc:12696} (Ursangous, Shadumbra, Garrafilada) son para la próxima visita a {zone:1440}, a nivel 27.",

	-- Step 5: Warsong Outrider
	-- {npc:12864} Warsong Outrider · {area:428} Night Run · {area:430} Satyrnaar
	["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864} patrulla el camino al este de {area:428} hacia {area:430}.",

	-- Step 6: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "De camino al oeste, {npc:267214} está atrapado en un barranco al sur del camino principal, al sureste de {area:415}. Los Venados Necraste y los Osos de Vallefresno recorren los bosques a su alrededor.",

	-- Step 7: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Guía el {npc:271181} de {npc:267214} fuera del barranco hasta el camino principal en menos de cuatro minutos; si se rompe la canalización, vuelve a hablar con {npc:267214}.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, en el camino",

	-- Step 8: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand
	["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Cabalga al oeste por el camino principal a través de {zone:1440}, pasando {area:415} (Alianza: no te salgas del camino), hasta la costa. {area:2897} está en {area:414}, en el noroeste. Sus otras misiones son para la próxima visita, a nivel 27.",

	-- Step 9: Naga heads
	["Naga heads"] = "Cabezas de naga",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Todos los nagas Colafuria de la playa al norte del puesto sueltan cabezas.",

	-- Step 11: Back to Kadrak
	-- {npc:8582} Kadrak
	["Back to {npc:8582}"] = "Vuelve con {npc:8582}",
	-- {area:431} Splintertree Post · {area:1703} Mor'shan Rampart
	["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Vuela a {area:431} y cabalga al sur por el camino hasta {area:1703}.",

	-- Step 12: Malaka'jin
	-- {area:380} Crossroads · {zone:1413} Barrens · {area:2539} Malaka'jin
	["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Cabalga al sur hasta {area:380} y luego al oeste por el camino, saliendo de {zone:1413} hacia Sierra Espolón. La aldea trol de {area:2539} está en la entrada del cañón.",

	-- Step 13: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "El camino sube al norte como {area:1076}. {quest:1483} tiene una choza donde el camino se bifurca al este hacia {area:461}.",

	-- Step 14: Windshear Crag
	-- {area:461} Windshear Crag · {npc:4276} Piznik
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "Al este de Ziz, Ventura y Cía. está talando {area:461}; uno de los operarios lleva los planos. {npc:4276} trabaja en la pequeña mina del lado este: quédate con él mientras mina, los matones de Ventura y Cía. vienen a por él.",

	-- Step 15: Ziz Fizziks
	-- {area:392} Ratchet
	["Sputtervalve in {area:392}: the next guide passes there"] = "Petardol en {area:392}: la próxima guía pasa por allí",

	-- Step 16: Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Follow the road west to {area:460}."] = "Sigue el camino al oeste hasta {area:460}.",
	-- {npc:11860} Maggran Earthbinder · {object:19844} Great Lift
	["{npc:11860}: Grish is at the {object:19844}, in the next guide"] = "{npc:11860}: Grish está en {object:19844}, en la próxima guía",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: Piedrasoles relumbrantes de las arpías Furia Sangrienta",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, fuera de la puerta",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} en Zoram'gar, a nivel 27",

	-- Step 17: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Semillas de Gaia",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "Las Semillas de Gaia están en la hierba de la orilla sur de {area:464}, al norte del Refugio Roca del Sol.",

	-- Step 18: Stonetalon Peak
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Sigue el camino al norte hacia {area:467}. Los Antlered Coursers pastan por el camino; las Bestias de savia, los Corredores Crepusculares y los Dragones clarividentes recorren los bosques bajo el pico, y los druidas Cenarion ocupan la arboleda de allí.",

	-- Step 19: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "La siguiente misión de {npc:4198}, Ordanus, está en el lado de la Alianza de {zone:1440}. Sáltatela.",

	-- Step 20: The Charred Vale
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Al suroeste del Refugio Roca del Sol está {area:465}, quemada. Planta las Semillas de Gaia en los túmulos de tierra del fondo del valle; los elementales de fuego sueltan {item:16312}. Las arpías Furia Sangrienta y las emboscadoras anidan en el lado norte; las destripadoras y las plumabribonas, al sur.",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Túmulos de Gaia",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, de cualquier arpía Furia Sangrienta",

	-- Step 21: Sun Rock Retreat
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, arriba en la cornisa",
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, junto a {npc:11862}",

	-- Step 22: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Ride back down the {area:1076} to {area:2539}."] = "Vuelve a bajar por {area:1076} hasta {area:2539}.",

	-- Step 23: To the Undercity
	-- {area:1497} Undercity
	["To the {area:1497}"] = "A {area:1497}",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:1497} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter
	["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Cabalga al este hasta {area:380} y vuela a {zone:1454}. Toma el zepelín en las torres de fuera de {zone:1454} hacia {zone:1420}; {area:1497} está bajo {area:153}. El cuidador de murciélagos está en {object:36078}.",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Habla con {npc:10181}, en {object:36126}: {quest:93739}",

	-- Step 24: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606} está en {object:36070}.",

	-- Step 25: Beren's Peril
	-- {area:272} Tarren Mill · {zone:1458} Undercity · {area:228} Sepulcher · {area:231} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Si ya conoces la ruta de vuelo de {area:272}, vuela allí y salta a {area:272}. Si no, vuela de {zone:1458} a {area:228} y cabalga al sur por el camino pasando la Aldea Piroleña. Los no-muertos Corvozarpa rondan las ruinas de {area:231}, al este del camino en el sureste del bosque; un {npc:1973} suelta {item:271343}, que lleva a {object:645153}.",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, de un {npc:1973}",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}, de las Almas torturadas entre las ruinas",

	-- Step 26: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Usa {npc:212753} en {object:645153} como sacrificio voluntario y mata a {npc:212753} que responde. {quest:95883} es de élite: se recomienda ir en grupo.",

	-- Step 27: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "Vuelve al camino hacia el sur. Donde gira al este hacia {area:287}, {npc:2214} espera en {area:285}.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: Darthalia en {area:272}",

	-- Step 28: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Sigue el camino al este junto al río y luego sube al noreste por las colinas hasta {area:272}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "Al suroeste del Refugio Roca del Sol está {area:465}, quemado. Planta las Semillas de Gaia en los túmulos de tierra del fondo del valle; los elementales de fuego sueltan {item:16312}. Las arpías Furia Sangrienta y las emboscadoras anidan en el lado norte; las destripadoras y las plumabribonas, al sur.",
}
