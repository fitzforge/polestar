-- Spanish (Spain) (esES): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255} es el pueblo goblin del lado este del valle.",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "Las misiones de Gregor y Harlo llevan a otras zonas: guárdalas.",

	-- Step 2: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yetis Cardo Nevado",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Las colinas de los yetis empiezan justo al sureste de {area:2255}. Todos los yetis sueltan pelaje; solo las matriarcas y patriarcas sueltan cuernos, así que déjalos para después de la entrega.",

	-- Step 4: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cuernos de yeti prístinos",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Las matriarcas y patriarcas pegan fuerte: atráelos de uno en uno.",

	-- Step 5: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "La tercera broma de Umi va contra goblins de {area:976} y Un'Goro: guárdala para más tarde.",

	-- Step 6: Chillwind chimaeras
	["Chillwind chimaeras"] = "Quimeras venfresco",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Las quimeras deambulan por los campos nevados al sur y al oeste de {area:2255}. Aléjate de la cueva de {area:2245}: sus dragonantes azules son élite.",

	-- Step 8: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Lechubestias enfurecidas",
	-- {area:2251} Lake Kel'Theril
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Cabalga al oeste por el camino pasando {area:2251}; las Lechubestias enfurecidas deambulan por las colinas al norte.",

	-- Step 9: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298} acampa entre las pozas humeantes de {area:2246}, al oeste del valle.",
	["From Krakle in Un'Goro"] = "De Krakle en Un'Goro",
	["Linken's letter"] = "La carta de Linken",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} la da {npc:7775} en {zone:1444}, más adelante en esta guía.",

	-- Step 10: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} está junto a la salida a {zone:1452} del túnel de {area:1769}, al norte de las fuentes termales.",

	-- Step 11: Frostfire Winterfall camps
	["Frostfire Winterfall camps"] = "Campamentos Nevada de los Baños de Fuego de Escarcha",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Abrecaminos, vigilantes del cubil y totémicos comparten los campamentos fúrbolg alrededor de las fuentes termales; las Lechubestias andrajosas deambulan por las laderas entre ellos. Mata primero a los totémicos. Guarda todo el {item:14047} que consigas para Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, botín raro de los fúrbolgs Nevada",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, botín raro de los fúrbolgs Nevada",

	-- Step 12: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} se entrega en el {object:176091} de {zone:1448}, en un viaje posterior.",

	-- Step 13: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Cabalga al este y luego al sur bajando por {area:2249}. Los Gigantes Machacahielo de allí son élite de nivel 59: ve por el centro y no te detengas. La fuente extraña está en la boca de {area:2256}, en el extremo sur.",

	-- Step 14: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "El poblado fúrbolg llena el valle al noreste de {area:2255}. Mata primero a los chamanes; curan. {npc:10738}, en la cueva del fondo, es élite: no entres.",

	-- Step 15: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "Vuelve al oeste hasta {area:2246}.",

	-- Step 17: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Cualquier fúrbolg Nevada puede llevar las cuentas; los campamentos justo al sur de {npc:11556} son los más cercanos.",
	["Frostfire Winterfall camp"] = "Campamento Nevada de los Baños de Fuego de Escarcha",

	-- Step 19: Back to Everlook
	-- {area:2255} Everlook
	["Back to {area:2255}"] = "De vuelta a {area:2255}",

	-- Step 20: Grind to 55
	["Grind to 55"] = "Sube hasta el nivel 55",
	-- {npc:7440} Winterfall Den Watcher · {area:2244} Winterfall Village · {zone:1452} Winterspring
	["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "sube de nivel con {npc:7440} en {area:2244}, {zone:1452}",

	-- Step 21: A Little Luck
	-- {npc:10307} Witch Doctor Mau'ari
	["{npc:10307}, beside him"] = "{npc:10307}, a su lado",

	-- Step 22: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Vuela a {area:1099}",

	-- Step 23: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, un enano, acampa en {area:1137}, al noroeste de {area:1099}; tiene el elixir.",

	-- Step 24: Talo Thornhoof
	-- {area:1099} Camp Mojache
	["Back at {area:1099}."] = "De vuelta en {area:1099}.",

	-- Step 25: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",

	-- Step 26: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Está en {area:1641}. Cada donación pide tela de tus bolsas; entrégalas cuando la tengas, más adelante en la ruta.",

	-- Step 28: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} en {area:1639}; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} espera en {zone:1450}: guárdala para más tarde.",

	-- Step 29: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil
	["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} compra {item:11040} cultivado con tu {quest:3761}.",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",

	-- Step 31: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "En {object:172961}.",

	-- Step 32: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "En {object:172958}.",
}
