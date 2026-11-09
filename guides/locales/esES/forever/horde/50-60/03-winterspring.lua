-- Spanish (Spain) (esES): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "",
	["Linken's letter"] = "La carta de Linken",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} la da {npc:7775} en {zone:1444}, más adelante en esta guía.",

	-- Step 4: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Abrecaminos, vigilantes del cubil y totémicos comparten los campamentos fúrbolg alrededor de las fuentes termales; las Lechubestias andrajosas deambulan por las laderas entre ellos. Mata primero a los totémicos. Guarda todo el {item:14047} que consigas para Meilosh.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, botín raro de los fúrbolgs Nevada",

	-- Step 5: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} se entrega en el {object:176091} de {zone:1448}, en un viaje posterior.",

	-- Step 6: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Lechubestias enfurecidas",
	-- {area:2251} Lake Kel'Theril · {area:2246} Frostfire Hot Springs · {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "",

	-- Step 8: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "Las misiones de Gregor y Harlo llevan a otras zonas: guárdalas.",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "",

	-- Step 9: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yetis Cardo Nevado",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Las colinas de los yetis empiezan justo al sureste de {area:2255}. Todos los yetis sueltan pelaje; solo las matriarcas y patriarcas sueltan cuernos, así que déjalos para después de la entrega.",

	-- Step 11: Level 55.04
	["Level 55.04"] = "",
	-- {area:2255} Everlook · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "",
	-- {npc:7460} Ice Thistle Patriarch
	["grind on {npc:7460}"] = "",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cuernos de yeti prístinos",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Las matriarcas y patriarcas pegan fuerte: atráelos de uno en uno.",
	["Below ground"] = "",

	-- Step 13: Chillwind chimaeras
	["Chillwind chimaeras"] = "Quimeras venfresco",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Las quimeras deambulan por los campos nevados al sur y al oeste de {area:2255}. Aléjate de la cueva de {area:2245}: sus dragonantes azules son élite.",

	-- Step 14: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "La tercera broma de Umi va contra goblins de {area:976} y Un'Goro: guárdala para más tarde.",

	-- Step 15: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "El poblado fúrbolg llena el valle al noreste de {area:2255}. Mata primero a los chamanes; curan. {npc:10738}, en la cueva del fondo, es élite: no entres.",

	-- Step 16: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 18: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, un enano, acampa en {area:1137}, al noroeste de {area:1099}; tiene el elixir.",

	-- Step 20: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",

	-- Step 21: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 22: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} en {area:1639}; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} espera en {zone:1450}: guárdala para más tarde.",

	-- Step 23: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "",

	-- Step 24: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 25: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 26: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "En {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Cualquier fúrbolg Nevada puede llevar las cuentas; los campamentos justo al sur de {npc:11556} son los más cercanos.",
	-- ["Back at {area:1099}."] = "De vuelta en {area:1099}.",
	-- ["Back to {area:2255}"] = "De vuelta a {area:2255}",
	-- ["Chillwind chimaeras"] = "Quimeras venfresco",
	-- ["From Krakle in Un'Goro"] = "De Krakle en Un'Goro",
	-- ["Frostfire Winterfall camp"] = "Campamento Nevada de los Baños de Fuego de Escarcha",
	-- ["Frostfire Winterfall camps"] = "Campamentos Nevada de los Baños de Fuego de Escarcha",
	-- ["Grind to 55"] = "Sube hasta el nivel 55",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Está en {area:1641}. Cada donación pide tela de tus bolsas; entrégalas cuando la tengas, más adelante en la ruta.",
	-- ["In the {object:172961}."] = "En {object:172961}.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Abrecaminos, vigilantes del cubil y totémicos comparten los campamentos fúrbolg alrededor de las fuentes termales; las Lechubestias andrajosas deambulan por las laderas entre ellos. Mata primero a los totémicos. Guarda todo el {item:14047} que consigas para Meilosh.",
	-- ["Ride back west to {area:2246}."] = "Vuelve al oeste hasta {area:2246}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Cabalga al este y luego al sur bajando por {area:2249}. Los Gigantes Machacahielo de allí son élite de nivel 59: ve por el centro y no te detengas. La fuente extraña está en la boca de {area:2256}, en el extremo sur.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Cabalga al oeste por el camino pasando {area:2251}; las Lechubestias enfurecidas deambulan por las colinas al norte.",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "sube de nivel con {npc:7440} en {area:2244}, {zone:1452}",
	-- ["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255} es el pueblo goblin del lado este del valle.",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, botín raro de los fúrbolgs Nevada",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, a su lado",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} está junto a la salida a {zone:1452} del túnel de {area:1769}, al norte de las fuentes termales.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} compra {item:11040} cultivado con tu {quest:3761}.",
	-- ["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298} acampa entre las pozas humeantes de {area:2246}, al oeste del valle.",
}
