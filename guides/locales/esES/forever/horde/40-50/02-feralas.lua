-- Spanish (Spain) (esES): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Vuela a {object:3202}",
	-- {area:1978} Misty Reed Post · {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words)
	["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Vuelve cabalgando hacia el noroeste desde {area:1978} hasta {area:75} y vuela a {object:3202}.",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "El zepelín a {zone:1454} sale de la torre junto a {object:3202}; aterriza justo fuera de la puerta principal de {zone:1454}.",
	["Zeppelin tower"] = "Torre del zepelín",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Equitación a nivel 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. {npc:4752} entrena a los orcos en {object:172958}, junto a la perrera de {npc:3362}; no se conoce instructor de equitación Cielonato, así que los cielonatos también deben probar con {npc:4752}. Las demás monturas de tu raza cuestan 20 de oro cada una: Coleccionables, Monturas · Nivel 40 tiene una guía para cada una.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instructor de equitación",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Lobos: {npc:3362}, junto a {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Zancavendavales: {npc:265756}, en {area:16638}, en la Isla de Zephras.",

	-- Step 5: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. En Classic cada raza la aprende del instructor de su raza: el tuyo es {npc:7953}, en {area:367}, en la costa de {zone:1411}, con los raptores de Zjolnir (20 de oro cada uno) a su lado. Puede que en Forever cualquier raza aprenda de cualquier instructor de equitación (sin confirmar): prueba primero con {npc:4752} en {object:172958} de {zone:1454}, que es el más cercano, y omite este paso si te entrena.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instructor de equitación",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptores: Zjolnir, junto a {npc:7953}, en {area:367}.",

	-- Step 6: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. En Classic cada raza la aprende del instructor de su raza: el tuyo es {npc:3690}, en {area:222}, con los kodos de {npc:3685} (20 de oro cada uno) a su lado. Puede que en Forever cualquier raza aprenda de cualquier instructor de equitación (sin confirmar): prueba primero con {npc:4752} en {object:172958} de {zone:1454}, que es el más cercano, y omite este paso si te entrena.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instructor de equitación",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, junto a {npc:3690}, en {area:222}.",

	-- Step 7: Riding at 40
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Equitación requiere nivel 40 y cuesta 100 de oro; al aprenderla recibes una montura. En Classic cada raza la aprende del instructor de su raza: la tuya es {npc:4773}, en {area:159}, con los caballos esqueléticos de {npc:4731} (20 de oro cada uno) a su lado. Puede que en Forever cualquier raza aprenda de cualquier instructor de equitación (sin confirmar): prueba primero con {npc:4752} en {object:172958} de {zone:1454}, que es el más cercano, y omite este paso si te entrena.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instructora de equitación",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Caballos esqueléticos: {npc:4731}, junto a {npc:4773}, en {area:159}.",

	-- Step 8: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {zone:1454} Orgrimmar · {area:484} Freewind Post
	["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Tu instructor está en {area:1638}: {npc:3033} (druidas) en {area:1639}, {npc:246344} (paladines). Vuela allí desde {zone:1454} y luego sigue hasta {area:484}.",

	-- Step 9: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392}, por el Corcel vil",

	-- Step 10: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Vuela a {area:484}",
	-- {area:484} Freewind Post · {zone:1446} Tanaris
	["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Vuela a {area:484}, baja por el ascensor al este del puesto, cruza los llanos salados y sigue hacia el sur hasta {zone:1446}.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} es el pueblo goblin amurallado justo pasada la frontera de {zone:1446}.",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "{object:150075} de la plaza",

	-- Step 12: Eastern Wastewander camps
	["Eastern Wastewander camps"] = "Campamentos Deambulador del este",
	-- {area:976} Gadgetzan
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Los bandidos y ladrones acampan en las dunas al este de {area:976}. Cualquier Deambulador puede llevar una bolsa de agua: guarda diez, cinco para cada una de las recompensas de Luglunket.",
	["water pouches in your bags"] = "bolsas de agua en tus bolsas",

	-- Step 14: Southern Wastewander camps
	["Southern Wastewander camps"] = "Campamentos Deambulador del sur",
	-- {area:976} Gadgetzan
	["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Los magos oscuros, pícaros y asesinos acampan al sureste de {area:976}.",

	-- Step 15: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Cabalga hacia el noreste hasta Puerto Bonvapor, el puerto goblin de la costa.",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: los Pícaros estridadores del valle viven en {zone:1444}",

	-- Step 16: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Al sur por la costa, los piratas del Mar del Sur ocupan la cala. {npc:7883} y el cargamento robado están en los muelles del fondo. Cualquier pirata puede soltar un sombrero; los secuestradores, más a menudo.",

	-- Step 17: Steamwheedle Port
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "para {area:35}, hacia el nivel 50",

	-- Step 18: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "Vuelve cabalgando hacia el oeste hasta {area:976}.",

	-- Step 19: Fly to Freewind Post
	-- {area:484} Freewind Post · {area:2237} Whitereach Post · {zone:1444} Feralas · {area:1099} Camp Mojache
	["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Vuela a {area:484} y cabalga hacia el oeste por los cañones, pasando {area:2237}; el camino sube a la jungla de {zone:1444} y sigue hasta {area:1099}.",

	-- Step 20: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: para {zone:1454}, hacia el nivel 45",

	-- Step 21: Woodpaw north camp
	["Woodpaw north camp"] = "Campamento Zarpaleña del norte",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Los gnolls Zarpaleña acampan en las colinas justo al noroeste de Mojache; cualquiera puede soltar una crin.",

	-- Step 22: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "Al norte de los gnolls, los ogros ocupan un puesto en lo alto de una colina; atrae hacia ti a los magos ogros. El cobalto está en los montículos de tierra alrededor del puesto, y el pergamino está en el suelo, dentro.",

	-- Step 23: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: dentro de una hora",

	-- Step 24: Sprite darters and Woodpaw alphas
	["Sprite darters and Woodpaw alphas"] = "Duendes dardo y Alfas Zarpaleña",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Los duendes dardo revolotean sobre la arboleda justo al oeste de Mojache; casi todos sueltan un ala. Los Alfas Zarpaleña dirigen los campamentos al suroeste: mátalos antes de una hora.",

	-- Step 26: Grimtotem camp
	["Grimtotem camp"] = "Campamento Tótem Siniestro",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "Los tauren Tótem Siniestro acampan junto a la arboleda de los duendes dardo; asaltantes, naturalistas y chamanes llevan cuernos.",

	-- Step 27: Woodpaw battle map
	["Woodpaw battle map"] = "Mapa de batalla Zarpaleña",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "El mapa de batalla está en el campamento Zarpaleña al sur de Mojache.",

	-- Step 28: Southern Gordunni ruins
	["Southern Gordunni ruins"] = "Ruinas Gordunni del sur",
	-- {area:1105} Feral Scar Vale
	["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Cabalga hacia el suroeste hasta las ruinas de ogros bajo {area:1105}. Están llenas de chamanes, brujos y destructores; los Señores de la Magia del extremo sur llevan el orbe.",

	-- Step 29: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "para {zone:1454}, hacia el nivel 45",

	-- Step 30: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "La colmena Zukk'ash excava en las colinas al sureste del campamento; {quest:7731} espera en su cámara más profunda.",

	-- Step 32: Rogue Vale screechers
	["Rogue Vale screechers"] = "Pícaros estridadores del valle",
	-- {zone:1444} Feralas · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Cabalga hacia el oeste hasta el centro de {zone:1444}. Mata a un {npc:5308}, usa {item:10699} en su cuerpo y mata al espíritu que surge.",

	-- Step 33: The Forgotten Coast
	-- plural, as words: Coast Crawl Deepseers = {npc:5328} Coast Crawl Deepseer
	["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Sigue cabalgando hacia el oeste hasta la costa. Los Videnistas y Quebradores Reptacostas de las playas sueltan la baliza de socorro de OOX-22/FE aproximadamente una de cada cuarenta muertes: si cae, úsala para empezar la misión.",

	-- Step 34: Homing Robot OOX-22/FE
	-- {area:1105} Feral Scar Vale · {area:1108} The Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Solo con la baliza de socorro: el robot está en una cueva pequeña en el lado norte de {area:1105}. Escóltalo hasta el muelle de {area:1108}; yetis y gorilas te tienden emboscadas por el camino. Su recompensa te espera en {area:35} para una visita posterior.",

	-- Step 35: Hearth to Camp Mojache
	-- {area:1099} Camp Mojache
	["Hearth to {area:1099}"] = "Piedra de hogar a {area:1099}",

	-- Step 36: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Vuela a {area:1637}. Los hermanos Droffers tienen su tienda en La Calle Mayor.",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "para {zone:1425}, hacia el nivel 48",

	-- Step 37: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelín a {object:3202}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar
	["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "El zepelín a {object:3202} sale de la torre justo al noreste de la puerta principal de {zone:1454}.",

	-- Step 38: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Vuela a {area:75}",
	-- {area:75} Stonard
	["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, la maestra de vuelo, está justo al este de la torre del zepelín. Vuela a {area:75}: allí empieza la siguiente guía.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the {object:172959}."] = "Vuela a {area:1637}. Los hermanos Droffers tienen su tienda en {object:172959}.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Solo con la baliza de socorro: el robot está en una cueva pequeña en el lado norte de {area:1105}. Escóltalo hasta el muelle de {area:1108}; yetis y gorilas te tienden emboscadas por el camino. Su recompensa te espera en {area:35} para una visita posterior.",
}
