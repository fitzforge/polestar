-- Spanish (Latin America) (esMX): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 35 to 36, but several quests here are level 37-38: on purpose, for their experience. The water elementals are 36-37: pull them one at a time."] = "Para personajes de nivel 35 a 36, pero varias misiones de aquí son de nivel 37-38: a propósito, por su experiencia. Los elementales de agua son de nivel 36-37: atráelos de uno en uno.",

	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "En {object:2164}, si todavía lo llevas",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Vuela a {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maestro de vuelo de {zone:1453}",

	-- Step 3: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "A {zone:1434}",

	-- Step 4: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "Desde {zone:1431} toma el camino al sur; el campamento está en las colinas al oeste del camino.",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}, if 30-40/04 didn't give it: for {npc:773} in {area:35}"] = "{npc:770}, si 30-40/04 no te la dio: para {npc:773} en {area:35}",

	-- Step 5: Nesingwary's Expedition
	-- {npc:717} Ajeck Rouack
	["South along the road: the hunters' tents stand just west of it. {npc:717} and Hemet gave you these on the first loop: take them now only if you didn't."] = "Al sur por el camino: las tiendas de los cazadores están justo al oeste. {npc:717} y Hemet te las dieron en el primer circuito: tómalas ahora solo si no lo hiciste.",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}. Keep it for the later visit if you skip {npc:729} on the raptor hill."] = "",
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:715}, if 30-40/04 didn't give it: the Lashtail Raptors, after the jungle ruins"] = "{npc:715}, si 30-40/04 no te la dio: los raptores colazote, después de las ruinas de la jungla",

	-- Step 6: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "Al este hacia {area:101}: los registros de Herod están en una choza en su lado oeste.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}, arriba",

	-- Step 7: Kurzen's Compound
	-- {npc:218230} Wendel Mathers · {spell:7964} Smoke Bomb · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["{npc:218230}, a cook, is caged at the compound's western edge: take his quest now and keep it, his cage key and the fighter's uniform come on the 40-50 Stranglethorn guide, when the Subchiefs and Elites are your level. Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}. {npc:813}, an elite of 39-40, stands at the compound's north end: leave him be."] = "{npc:218230}, un cocinero, está enjaulado en el borde oeste del complejo: acepta su misión ahora y consérvala; la llave de su jaula y el uniforme de luchador vienen en la guía de Tuercespina 40-50, cuando los subjefes y élites sean de tu nivel. Los reductores de cabezas están más adentro del complejo; los comandos acechan en sigilo a su alrededor y en la cueva, y la caja fuerte de Herod está junto a la entrada de la cueva. Recoge las páginas de Colinas Verdes cuando caigan.\nCuidado: los comandos Kurzen son de nivel 34-35, no élite, y suelen aparecer en sigilo; cerca de la muerte usan {spell:7964}. {npc:813}, un élite de nivel 39-40, está en el extremo norte del complejo: déjalo en paz.",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage"] = "{npc:218230}, en su jaula",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}, bajo tierra",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}, bajo tierra",

	-- Step 8: The jungle ruins
	["The jungle ruins"] = "Las ruinas de la jungla",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west.\nCareful: the Saltscale murlocs on the shore near the second tablet are elite (35-37): swim to the tablet from the water and keep clear of them."] = "Al oeste a través de la jungla hacia las ruinas trol: cada una guarda una tablilla de piedra de las leyendas trol; las dos primeras en las ruinas al suroeste del campamento de Nesingwary, las dos últimas en la colina del noroeste.\nCuidado: los múrlocs Escamasal de la orilla cerca de la segunda tablilla son élite (35-37): nada hasta la tablilla desde el agua y mantente lejos de ellos.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006}: {object:58}; bajo el agua",

	-- Step 9: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "La isla embrujada está justo frente a la costa, al oeste de la segunda tablilla: los elementales de agua menores surgen del agua a su alrededor.",

	-- Step 10: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "Las {area:102}",
	-- {npc:268992} Zimmix Sputterspark · {item:277957} Primitive Key
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}, then lead him out of the ruins. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "Al norte por la costa hasta las ruinas de la colina: allí están las dos últimas tablillas. {npc:268992}, un goblin, está enjaulado junto a la tercera tablilla: cualquier Sangrapellejo puede soltar su {item:277957}; luego guíalo fuera de las ruinas. Los envíos robados están en el borde este de las ruinas. Recoge las páginas de Colinas Verdes a medida que caigan.\nCuidado: los rabiosos, cazadores de cabezas y médicos brujos Sangrapellejo (36-37) ocupan el centro de las ruinas: atráelos de uno en uno.",
	-- {npc:268992} Zimmix Sputterspark
	["{npc:268992}, in his cage beside the third tablet"] = "{npc:268992}, en su jaula junto a la tercera tablilla",
	-- {item:277957} Primitive Key
	["{item:277957}, from the Bloodscalp trolls"] = "{item:277957}, de los trols Sangrapellejo",
	-- {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["For {npc:4631} in {area:35}, at the end of this loop"] = "Para el {npc:4631} en {area:35}, al final de este recorrido",

	-- Step 11: Sin'Dall on the raptor hill
	-- {npc:729} Sin'Dall
	["{npc:729} on the raptor hill"] = "",
	-- {npc:729} Sin'Dall
	["{npc:729} (37) prowls the hilltop."] = "",

	-- Step 12: The Lashtail raptors
	["The Lashtail raptors"] = "Los raptores colazote",
	-- {quest:187} Tiger Mastery · {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["East from the ruins, hunt Lashtail Raptors around the hill south-west of Nesingwary's camp. If you have {quest:187}, are at least 36 and see {npc:729} (37) alone, you can take her paw here or leave the hunt for your next visit."] = "",

	-- Step 13: Ajeck Rouack
	-- {npc:717} Ajeck Rouack
	["Hand the paw to {npc:717} beside Hemet."] = "",

	-- Step 14: Nesingwary's Expedition
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["{npc:715}: the Jungle Stalkers come in 40-50"] = "{npc:715}: los acechadores de la selva vienen en 40-50",

	-- Step 15: Rebel Camp
	-- {area:99} Rebel Camp
	["North-east up the road to the {area:99}, then back south through the jungle."] = "Al noreste por el camino hacia el {area:99}, luego vuelve al sur a través de la jungla.",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "{npc:733}: los comandos y reductores de cabezas caídos en el complejo",
	-- plural, as words: Skullsplitter Witch Doctors = {npc:670} Skullsplitter Witch Doctor
	["keep it: the Skullsplitter Witch Doctors (41-42) wait for the 40-50 Stranglethorn guide"] = "consérvala: los médicos brujos Machacacráneos (41-42) esperan a la guía de Tuercespina 40-50",

	-- Step 16: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Crocoliscos Quijaforte",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to {area:35}."] = "Los crocoliscos Quijaforte toman sol a lo largo del río en medio de la jungla, de camino al sur hacia {area:35}.",

	-- Step 17: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, adentro",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, en el piso de arriba de la taberna",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Para el archimago Ansirem en {zone:1416}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, en el piso de arriba",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, en el piso de arriba",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}, en el piso de arriba: esta misión opcional pide cuatro {item:4278}. Extrae de depósitos de sangrita inferior en {zone:1417} con {skill:186} 75, o compra el mineral en la casa de subastas o pídeselo a un amigo minero. Los kóbolds no lo sueltan; omite esta misión si no puedes conseguir el mineral.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, adentro",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley «Lobo de Mar», en el piso superior",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks"] = "{npc:4631}, en los muelles",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East from the ruins to the hilltop south-west of Nesingwary's camp: the Lashtail Raptors run in the jungle around it. Leave {npc:729}, the great tiger (37) on the hilltop, to the 40-50 Stranglethorn guide: you're about 35 here. Then on to the hunters' tents."] = "Al este de las ruinas hacia la cima al suroeste del campamento de Nesingwary: los raptores colazote corren por la jungla a su alrededor. Deja a {npc:729}, el gran tigre (37) de la cima, para la guía de Tuercespina 40-50: aquí tienes cerca de nivel 35. Luego sigue a las tiendas de los cazadores.",
	-- ["East to the {area:99}, on the way back to Nesingwary's camp."] = "Al este hacia el {area:99}, de camino de vuelta al campamento de Nesingwary.",
	-- ["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "Para personajes de nivel 35 a 36, pero varias misiones de aquí son de nivel 37-41: a propósito, por su experiencia. Los trols Machacacráneos de {quest:205} son de nivel 39-42, así que atráelos de uno en uno.",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "Los reductores de cabezas están más adentro del complejo; los comandos acechan en sigilo a su alrededor y en la cueva, y la caja fuerte de Herod está junto a la entrada de la cueva. Recoge las páginas de Colinas Verdes cuando caigan.\nCuidado: Los comandos de Kurzen son de nivel 34-35, no élite, y suelen aparecer en sigilo; cerca de la muerte usan {spell:7964}.",
	-- ["Level 36"] = "Nivel 36",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Recorre las ruinas trol del norte y del centro: cada una guarda una tablilla de piedra de las leyendas trol. Las panteras Faucesombría merodean en sigilo por la jungla a su alrededor; el campamento de Ventura y Cía. en {area:37} lleva los cristales caídos.",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "Al norte por la costa hasta las ruinas de la colina: allí están las dos últimas tablillas. Recoge las páginas de Colinas Verdes cuando caigan.",
	-- ["Skullsplitter trolls"] = "Trols Machacacráneos",
	-- ["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "Los crocoliscos Quijaforte toman sol a lo largo del río en medio de la jungla, de camino al sur hacia las ruinas Machacacráneos.",
	-- ["South along the road: the hunters' tents stand just west of it."] = "Al sur por el camino: las tiendas de los cazadores están justo al oeste.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "Al sur del recinto hacia el {area:37}: los geólogos de Ventura y Cía. en los campamentos de su orilla llevan los cristales caídos, y las panteras Faucesombría merodean en sigilo por la jungla al sur y al este del lago.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals. Careful: Venture Co. Agents (39) walk among them: take the Geologists on the camps' edges, one at a time. Shadowmaw Panthers (37-38) prowl stealthed in the jungle south and east of the lake: keep to the shore camps."] = "Al sur del complejo hacia el {area:37}: los geólogos de Ventura y Cía. en los campamentos de su orilla llevan los cristales caídos. Cuidado: entre ellos andan agentes de Ventura y Cía. (39): ataca a los geólogos de los bordes de los campamentos, de uno en uno. Las panteras Faucesombría (37-38) merodean en sigilo por la jungla al sur y al este del lago: quédate en los campamentos de la orilla.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Los trols Machacacráneos ocupan las ruinas al este del camino entre Nesingwary y {object:3202}.",
	-- ["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "Al oeste a través de la jungla hacia las ruinas trol: cada una guarda una tablilla de piedra de las leyendas trol; las dos primeras en las ruinas al suroeste del campamento de Nesingwary, las dos últimas en la colina del noroeste.",
	-- ["grind on {npc:1152}"] = "farmea {npc:1152}",
	-- ["{npc:717}, if 30-40/04 didn't give it: {npc:729}, in the 40-50 Stranglethorn guide"] = "{npc:717}, si 30-40/04 no te la dio: {npc:729}, en la guía 40-50 de Tuercespina",
	-- ["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718}: las panteras Faucesombría merodean alrededor del {area:37}, después de {area:101}",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: para {npc:773} en {area:35}",
	-- ["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "Los trols Machacacráneos de {quest:205} son de nivel 39-42. ¿Por debajo de 36? Sigue matando crocoliscos Quijaforte a lo largo del río hasta el nivel 36. O, con un grupo, haz en su lugar la mazmorra {area:796} (Armería) o la mazmorra {area:1316}.",
}
