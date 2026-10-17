-- Spanish (Spain) (esES): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Vuela a {area:75}",
	-- {area:1446} Thorium Point
	["From {area:1446}'s flight master."] = "Desde el maestro de vuelo de {area:1446}.",

	-- Step 2: The bloodmages
	["The bloodmages"] = "Los magos sangrientos",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Sal de {area:75} hacia el oeste y ve al sur por el cañón hasta {zone:1419}; los dos magos sangrientos están junto al camino, nada más entrar.",

	-- Step 3: The northern beasts
	["The northern beasts"] = "Las bestias del norte",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "Las cinco misiones piden las mismas partes: reúnelas todas de una pasada. Al oeste del camino, los buitres {npc:5982}, las hienas risitas hambrientas, los aguijoneros Scorpok y los basiliscos Ojo de la Muerte comparten las colinas.",

	-- Step 4: The eastern slopes
	["The eastern slopes"] = "Las laderas del este",
	["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "Al este del camino, los jabalíes Cenicrín y los gruñones hozan en las laderas junto a los basiliscos Rocarroja. Evita a los jabinfernos de nivel 52, más al sur.",

	-- Step 5: The bloodmages
	["Ride back north to the bloodmages."] = "Vuelve al norte con los magos sangrientos.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "Sus misiones siguientes piden otra vez las mismas partes a cambio de un objeto de mejora y no dan experiencia: déjalas.",

	-- Step 6: Grind to 48
	["Grind to 48"] = "Sube al nivel 48",
	["Only if you are not level 48 yet."] = "Solo si aún no eres de nivel 48.",
	["Vulture hills"] = "Colinas de los buitres",
	-- {npc:5982} Black Slayer · {zone:1419} Blasted Lands
	["grind on {npc:5982} at the northern hills, {zone:1419}"] = "mata {npc:5982} en las colinas del norte, {zone:1419}",

	-- Step 7: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Vuela a {area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity
	["Ride north back to {area:75} and fly to the {area:1497}."] = "Vuelve al norte a {area:75} y vuela a {area:1497}.",

	-- Step 8: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
	-- {npc:6741} Innkeeper Norman · {zone:1456} Thunder Bluff
	["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: para {zone:1456}, hacia el nivel 50",

	-- Step 9: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Vuela a {area:272}",

	-- Step 10: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "Campamento de {npc:7801}",
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Ve al noreste desde {area:272} hasta {zone:1425} y sigue el camino hacia el este; {npc:7801} acampa en la colina al sur de {area:350} de los elfos.",

	-- Step 11: Highvale
	["Highvale"] = "Vallealto",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Los elfos de Vallealto acampan alrededor de {area:350}. Quema el informe, las notas y los archivos de sus campamentos. {npc:7780} está preso dentro del refugio: sácalo de allí y rechaza la emboscada por el camino.",

	-- Step 12: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "Al sur del refugio, los trols Secacorteza ocupan sus poblados. Todos llevan un cráneo: con veinte, usa {item:15002} para hacer el Pico cargado de Nimboya y clávalo dentro del poblado.",

	-- Step 13: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "Al este del poblado, la flor violeta crece en las colinas.",

	-- Step 14: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "De nuevo al suroeste, el exiliado se esconde junto a las ruinas de {area:353}.",

	-- Step 15: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Sigue los caminos hacia el este a través de {zone:1425} hasta el poblado trol de la costa este.",

	-- Step 16: Saltwater Snapjaws
	-- plural, as words: Saltwater Snapjaws = {npc:2505} Saltwater Snapjaw
	["Saltwater Snapjaws"] = "Quijafortes Aguasalada",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "Las tortugas grandes se arrastran por las playas al norte del poblado. Las botellas de oporto de {npc:2491} también están en estas playas, pero su misión no forma parte de esta ruta. Un quijaforte puede soltar, rara vez, la baliza de socorro de OOX-09/HL: guárdala.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, botín poco común",

	-- Step 17: Rin'ji's Secret
	-- {area:307} Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "El secreto está en {area:307}, sobre la playa.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "para {npc:7825} en {zone:1458}, hacia el nivel 50",

	-- Step 18: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "El almuerzo de {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "Al norte por la costa, la cesta de merienda de {npc:14731} está en el islote; la vigila un {npc:14748}.",

	-- Step 19: The Vilebranch temples
	["The Vilebranch temples"] = "Los templos Vilrama",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "Al oeste de la isla, los arrancacabelleras Vilrama ocupan los templos de {area:1884} y {area:1917}. Las herramientas del herrero Esco están en uno de los templos.",

	-- Step 20: The central hills
	["The central hills"] = "Las colinas centrales",
	-- {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Los acechadores melenargenta, las lechubestias salvajes y los Señores del Cielo Picovaja comparten las colinas entre los templos y {area:351}. Usa {item:9618} en las lechubestias que mates. Los Señores del Cielo también sueltan plumas elegantes largas: guarda diez para el segundo mensaje de {npc:14738}.",

	-- Step 21: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "Las cajas de {item:8684} están alrededor del campamento abandonado de la Horda en {area:351}, entre los mocos.",

	-- Step 22: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Solo con la baliza de socorro: el robot está en el nacimiento del río, al oeste de {area:351}. Escóltalo hacia el este hasta la orilla, más allá de {area:307}; su recompensa te espera con Oglethorpe en {area:35}.",

	-- Step 23: Silvermane Howlers
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["Silvermane Howlers"] = "Aulladores Melenargenta",
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "Al suroeste, los aulladores Melenargenta recorren las colinas al este de los poblados Secacorteza.",

	-- Step 24: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Vuelve al oeste a {area:350}; los forestales y tiradores están cerca del refugio, y los exploradores y avanzadas, en las laderas al sur.",

	-- Step 25: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "para {npc:6986} en {zone:1454}, hacia el nivel 50",

	-- Step 26: Vilebranch soothsayers
	["Vilebranch soothsayers"] = "Adivinos Vilrama",
	-- {area:355} Altar of Zul · {npc:8636} Morta'gya the Keeper
	["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "De vuelta al este, los adivinos Vilrama ocupan {area:355}, el templo trol al sur de las colinas centrales. Qiaga el Vigilante y {npc:8636} (élite, 50) están en la cima: mata a los adivinos de los escalones inferiores.",

	-- Step 27: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "La calavera del cazador Malkhor está en un montón bajo las ruinas Vilrama, y sus huesos, en otro montón al pie de {area:354}. Las vasijas de sangre contaminada están en las terrazas inferiores, y {npc:14757} está preso en la cima. No te salgas de los senderos: los trols de dentro son élite.",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, en la cima de {area:354}",
	-- {area:355} Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "Su siguiente encargo, que continúa en {area:355}, es para grupo.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Ve hasta el extremo oeste, a {area:348}, la ciudad de los Martillo Salvaje, y deja el mensaje junto al pozo del centro. La ciudad está llena de guardias de la Alianza: entra, déjalo y sal.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Pozo de {area:348}",

	-- Step 30: Revantusk Village
	-- {area:3317} Revantusk Village
	["The next guide starts here, at {area:3317}."] = "La siguiente guía empieza aquí, en {area:3317}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Sigue los caminos hacia el este a través de {zone:1425} hasta el poblado trol de la costa este.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "La calavera del cazador Malkhor está en un montón bajo las ruinas Vilrama, y sus huesos, en otro montón al pie de {area:354}. Las vasijas de {spell:19478} están en las terrazas inferiores, y {npc:14757} está preso en la cima. No te salgas de los senderos: los trols de dentro son élite.",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Ve al noreste desde {area:272} hasta {zone:1425} y sigue el camino hacia el este; {npc:7801} acampa en la colina al sur del {area:350} de los elfos.",
}
