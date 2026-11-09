-- Spanish (Latin America) (esMX): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "",

	-- Step 2: The Hinterlands
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "Campamento de {npc:7801}",

	-- Step 3: Gilveradin Sunchaser's camp
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Cabalga al noreste desde {area:272} hacia {zone:1425} y al este por el camino; {npc:7801} acampa en la colina al sur de {area:350}, de los elfos.",

	-- Step 4: Highvale
	["Highvale"] = "Vallealto",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way.\nCareful: Groups of about three elves ambush the escort, usually twice."] = "",

	-- Step 5: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "Al este del poblado, la flor violeta crece en las colinas.",
	["Underwater"] = "",

	-- Step 6: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Sigue los caminos al este cruzando {zone:1425} hasta el poblado trol de la costa este.",

	-- Step 8: Revantusk Village
	-- {quest:7849} Separation Anxiety · {quest:7845} Kidnapped Elder Torntusk! · {quest:7850} Dark Vessels · {area:354} Jintha'Alor · {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{quest:7849}, {quest:7845} and {quest:7850} are group quests: they send you into {area:354}, whose trolls are elite (46-50). Take them with a group of three or more; skip them if you are alone, the route has you grind the experience back.\n{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 9: The Overlook Cliffs: kill these as you meet them
	-- {area:307} The Overlook Cliffs
	["{area:307}: kill these as you meet them"] = "",
	-- {npc:2491} Whiskey Slim · {area:307} The Overlook Cliffs
	["The big turtles crawl along the beaches north of the village, and {npc:2491}'s bottles of port lie on the same beaches, from the village up to the {area:307}: pick them up as you go. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "",
	-- {object:2068} Pupellyverbos Port
	["{object:2068}, on the beaches"] = "",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, botín raro",

	-- Step 10: The Overlook Cliffs: kill these as you meet them
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} is a level 48 elite: most classes solo it at level 50, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 11: Rin'ji's Secret
	-- {area:307} The Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "El secreto está en {area:307}, sobre la playa.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "para {npc:7825} en {zone:1458}, alrededor del nivel 50",

	-- Step 12: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "El almuerzo de {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Al norte por la costa, la canasta de picnic de {npc:14731} está en la islita; un {npc:14748} la custodia.",

	-- Step 14: Shaol'watha: kill these as you meet them
	-- {area:1917} Shaol'watha
	["{area:1917}: kill these as you meet them"] = "",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha · {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko · {spell:7367} Infected Bite · {npc:2925} Silvermane Howler
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples.\nThe Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message.\nCareful: Silvermane Stalkers are level 47-48 and stay stealthed while out of combat. Up close they use {spell:7367}. When a {npc:2925} falls to 50% health or lower, it calls for help from anything within 25 yd."] = "",

	-- Step 15: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "Las cajas de {item:8684} están alrededor del campamento abandonado de la Horda en {area:351}, entre los mocos.",

	-- Step 16: Wildkin Muisek
	-- {area:1883} Valorwind Lake
	["Careful: Stealthed wolves and griffons roam the {area:1883} area."] = "",

	-- Step 17: The Altar of Zul: kill these as you meet them
	-- {area:355} The Altar of Zul
	["{area:355}: kill these as you meet them"] = "",
	-- {area:355} The Altar of Zul · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west of the lake, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps.\nSouth-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "",

	-- Step 18: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} The Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}.\nCareful: Two ambushes spawn during the escort: first three wildkin owlbeasts, then three trolls. Before each, the robot halts and announces it senses danger. Oozes, stealthed wolves and a large turtle along the path can join fights, and they respawn even if cleared beforehand."] = "",

	-- Step 19: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "para {npc:6986} en {zone:1454}, alrededor del nivel 50",

	-- Step 20: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "De vuelta al oeste a {area:350}; los forestales y tiradores se quedan cerca del refugio, y los exploradores y avanzadas en las laderas al sur.",

	-- Step 21: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. The trolls inside are elite: stay with your group and keep to the paths."] = "",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, en la cima de {area:354}",
	-- {area:355} The Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "Su siguiente petición, que sigue en {area:355}, es para grupo.",

	-- Step 22: Revantusk Village
	-- {npc:14731} Lard
	["{npc:14731}, inside"] = "",

	-- Step 23: Revantusk Village
	-- {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 25: Level 49.02
	["Level 49.02"] = "",
	-- {quest:7816} Gammerita, Mon! · {area:354} Jintha'Alor · {area:2100} Maraudon
	["If you skipped {quest:7816} or the {area:354} group quests, grind here to level 49.02 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon instead."] = "",
	-- {npc:2505} Saltwater Snapjaw
	["grind on {npc:2505}"] = "",

	-- Step 26: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "De nuevo al suroeste, el exiliado se esconde junto a las ruinas de {area:353}.",

	-- Step 28: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Al sur del refugio, los trols Secacorteza ocupan sus poblados. Todos llevan un cráneo: con veinte, usa {item:15002} para hacer la Pica cargada de Nimboya y luego clávala dentro del poblado.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Cabalga todo el camino al oeste hasta {area:348}, el pueblo de los Martillo Salvaje, y coloca el mensaje junto al pozo del centro. El pueblo está lleno de guardias de la Alianza: entra, colócalo y sal.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Pozo de {area:348}",

	-- Step 31: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Vuela a {area:75}",
	-- {area:3317} Revantusk Village
	["{area:3317} flight master"] = "",

	-- Step 32: Fel'zerul
	["On the top floor"] = "",

	-- Step 33: Fallen Hero of the Horde
	-- {zone:1419} Blasted Lands
	["The ghostly orc stands by the road where the swamp meets the canyon into the {zone:1419}. Listen to his story."] = "",

	-- Step 35: Fallen Hero of the Horde
	-- {npc:7623} Dispatch Commander Ruag · {area:75} Stonard · {zone:1419} Blasted Lands
	["for {npc:7623} in {area:75}, after the {zone:1419}"] = "",

	-- Step 36: The bloodmages
	["The bloodmages"] = "Los magos de sangre",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Cabalga al oeste desde {area:75} y al sur por el cañón hacia {zone:1419}; los dos magos de sangre están junto al camino, justo al entrar.",

	-- Step 37: Serpent's Coil: kill these as you meet them
	-- {area:1440} Serpent's Coil
	["{area:1440}: kill these as you meet them"] = "",
	-- {npc:5982} Black Slayer · {spell:5416} Venom Sting · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills.\nEast of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown."] = "",

	-- Step 38: The bloodmages
	["Ride back north to the bloodmages."] = "Regresa cabalgando al norte con los magos de sangre.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "Sus siguientes misiones piden las mismas partes otra vez a cambio de un objeto de mejora y no dan experiencia: déjalas.",

	-- Step 39: Stonard
	-- {area:75} Stonard
	["Ride back north through the canyon to {area:75}."] = "",
	-- {npc:7643} Bengor · {npc:950} Swamp Talker
	["{npc:7643}'s The {npc:950} is a level 55 quest: leave it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "Al este del camino, los jabalíes Cenicrín y los Gruñones hozan en las laderas junto a los basiliscos Rocarroja. Aléjate de los Jabinfernos de nivel 52, más al sur.",
	-- ["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- ["Follow the roads east across the {area:47} to the troll village on the eastern coast."] = "Sigue los caminos al este cruzando {area:47} hasta el poblado trol de la costa este.",
	-- ["From {area:1446}'s flight master."] = "Desde el maestro de vuelo de {area:1446}.",
	-- ["Grind to 48"] = "Sube a nivel 48",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "La calavera del cazador Malkhor está en un montón bajo las ruinas Vilrama, y sus huesos en otro montón al pie de {area:354}. Las vasijas de sangre corrupta están en las terrazas inferiores y {npc:14757} está cautivo en la cima. No te salgas de los senderos: los trols de adentro son élite.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "La calavera del cazador Malkhor está en un montón bajo las ruinas Vilrama, y sus huesos en otro montón al pie de {area:354}. Las vasijas de {spell:19478} están en las terrazas inferiores y {npc:14757} está cautivo en la cima. No te salgas de los senderos: los trols de adentro son élite.",
	-- ["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "De regreso al este, los veritas Vilrama ocupan {area:355}, el templo trol al sur de las colinas centrales. Qiaga y {npc:8636} (élite, 50) están en la cima: enfréntate a los veritas en los escalones inferiores.",
	-- ["Only if you are not level 48 yet."] = "Solo si aún no eres nivel 48.",
	-- ["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Solo con el localizador de emergencia: el robot está en el nacimiento del río al oeste de {area:351}. Escóltalo al este hasta la orilla más allá de {area:307}; su recompensa te espera con Oglethorpe en {area:35}.",
	-- ["Ride north back to {area:75} and fly to the {area:1497}."] = "Regresa cabalgando al norte a {area:75} y vuela a {area:1497}.",
	-- ["Ride north-east from {area:272} into the {area:47} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Cabalga al noreste desde {area:272} hacia {area:47} y al este por el camino; {npc:7801} acampa en la colina al sur de {area:350}, de los elfos.",
	-- ["Saltwater Snapjaws"] = "Quijafortes marinos ({npc:2505})",
	-- ["Silvermane Howlers"] = "Aulladores melenargenta ({npc:2925})",
	-- ["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "Al suroeste, los Aulladores melenargenta ({npc:2925}) recorren las colinas al este de los poblados Secacorteza.",
	-- ["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Los elfos Vallealto acampan alrededor de {area:350}. Quema el informe, las notas y los registros en sus campamentos. {npc:7780} está cautivo dentro del refugio: guíalo afuera y defiéndete de la emboscada en el camino.",
	-- ["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Los Acechadores melenargenta ({npc:2926}), las Lechubestias salvajes ({npc:2929}) y los Señores del Cielo Picovaja ({npc:2659}) comparten las colinas entre los templos y {area:351}. Usa {item:9618} en las lechubestias que mates. Los Señores del Cielo también sueltan Plumas elegantes largas ({item:4589}): guarda diez para el segundo mensaje de {npc:14738}.",
	-- ["The Vilebranch temples"] = "Los templos Vilrama",
	-- ["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "Las tortugas grandes se arrastran por las playas al norte del poblado. Las botellas de oporto de {npc:2491} también están en estas playas, pero su misión no está en esta ruta. Un quijaforte puede soltar el localizador de emergencia de OOX-09/HL, pero rara vez: guárdalo.",
	-- ["The central hills"] = "Las colinas centrales",
	-- ["The eastern slopes"] = "Las laderas del este",
	-- ["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "Las cinco misiones piden las mismas partes: reúnelas todas en un solo recorrido. Al oeste del camino, los buitres {npc:5982}, las Hienas risitas famélicas ({npc:5984}), los Aguijoneros Scorpok ({npc:5988}) y los basiliscos Ojo de la Muerte comparten las colinas.",
	-- ["The next guide starts here, at {area:3317}."] = "La siguiente guía empieza aquí, en {area:3317}.",
	-- ["The northern beasts"] = "Las bestias del norte",
	-- ["Vilebranch soothsayers"] = "Veritas Vilrama",
	-- ["Vulture hills"] = "Colinas de los buitres",
	-- ["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "Al oeste de la isla, los arrancacabelleras Vilrama ocupan los templos de {area:1884} y {area:1917}. Las herramientas de Arbolescoria están en uno de los templos.",
	-- ["grind on {npc:5982} at the northern hills, {zone:1419}"] = "farmea {npc:5982} en las colinas del norte, {zone:1419}",
	-- ["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: para {zone:1456}, alrededor del nivel 50",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
}
