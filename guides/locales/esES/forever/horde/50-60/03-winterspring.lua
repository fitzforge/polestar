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
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} está justo en la salida a {zone:1452} del túnel de {area:1769}, por donde sales.",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "Cabalga al sur desde el túnel: {npc:9298} acampa entre las pozas humeantes de {area:2246}, al oeste del valle.",
	["Linken's letter"] = "La carta de Linken",
	-- {quest:980} The New Springs
	["{quest:980}, from Krakle in Un'Goro"] = "",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas · {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide. {npc:9298}'s next errand, Strange Sources, is at the mouth of {area:2256} among level 59-60 elites: it waits for the last guide's {zone:1452} loop."] = "",

	-- Step 4: Winterspring
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {npc:9298} Donova Snowden
	["Ride east along the road past {area:2251} to {area:2255} first: its yeti and chimaera errands bring you about a quarter of a level, which the Frostfire furbolg camps want; {npc:9298}'s camps come on the ride back west."] = "",

	-- Step 5: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255} es el pueblo goblin del lado este del valle, pasadas las colinas de los lechúcicos.",
	["Gregor's quests lead to other zones: keep them."] = "Las misiones de Gregor llevan a otras zonas: guárdalas.",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "",

	-- Step 6: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yetis Cardo Nevado",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur. Careful: the Ice Thistle Yetis are 55-56: take the 55s one at a time, and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "",

	-- Step 7: Chillwind chimaeras
	["Chillwind chimaeras"] = "Quimeras venfresco",
	-- {area:2255} Everlook · {area:2251} Lake Kel'Theril · {area:2245} Mazthoril
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Careful: Chillwind Chimaeras are 55-57: take only the 55s, and the Fledgling Chillwinds (53-55) by {area:2251}, which carry the horns too. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "",

	-- Step 8: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	-- was: ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Umi: guárdala, los Cuernos de yeti prístinos se consiguen en la parada de {area:2255} de la Guía de {zone:1423}, hacia el nivel 57"
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 56"] = "",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "Las matriarcas y patriarcas que llevan los cuernos de Umi son de nivel 56-58: déjalos para esa parada posterior.",

	-- Step 9: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Lechubestias enfurecidas",
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {area:2246} Frostfire Hot Springs
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	-- was: ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Las Lechubestias enfurecidas deambulan por las colinas al norte de {area:2251}, junto al camino entre {area:2246} y {area:2255}. Cuidado: las más grandes son de nivel 56: atráelas de una en una."
	["Ride back west: Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2255} and {area:2246}. Careful: the biggest are level 56: pull them one at a time."] = "",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	-- was: ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Abrecaminos, vigías del cubil y totémicos comparten los campamentos fúrbolg alrededor de las fuentes termales; las Lechubestias pulgosas deambulan por las laderas entre ellos. Mata primero a los totémicos. Guarda todo el {item:14047} que consigas para Meilosh.\nCuidado: los vigías del cubil llegan al nivel 56: atráelos de uno en uno y aléjate de los tótems de los campamentos."
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers are 55-56: pull the 55s, one at a time, and keep clear of the camps' totems."] = "",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, botín raro de los fúrbolgs Nevada",

	-- Step 11: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} se entrega en el {object:176091} de {zone:1448}, en un viaje posterior.",

	-- Step 12: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "",
	-- {zone:1448} Felwood · {area:2255} Everlook · {area:431} Splintertree Post · {area:1237} Valormok
	["{zone:1448}'s southern hand-ins are next: ride back east to {area:2255}'s flight master, fly to {area:431} (by way of {area:1237}) and ride north into {zone:1448}, so the forest is ridden once, south to north."] = "",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 13: Overlord Ror
	-- {zone:1448} Felwood · {area:1761} Deadwood Village
	["Ride north-west along the road into {zone:1448}. Ror stands at the far south end of {area:1761}, just inside the border."] = "",

	-- Step 14: Emerald Sanctuary
	["North to the druids' camp."] = "",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, en el lado oeste del Santuario",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {area:392} Ratchet
	["Keep {quest:5158}: {npc:5901} is by {area:392}, on the next guide."] = "",

	-- Step 15: The Jadefire moonwell
	["The Jadefire moonwell"] = "La poza de la luna Fuego de Jade",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride north-west past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "",

	-- Step 16: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["North up the road to {area:1997}."] = "",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring · {zone:1423} Eastern Plaguelands
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{npc:10306}'s Moontouched Owlbeasts are 57-58, in {zone:1452}: keep it for the {zone:1423} guide's {zone:1452} stop."] = "",

	-- Step 17: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "El gatito de {npc:9996}",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten back to the Jadefire moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "{item:12565}, en la poza de la luna Fuego de Jade",

	-- Step 19: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Vuela a {area:1099}",
	-- {area:1997} Bloodvenom Post
	["{area:1997} flight master"] = "",

	-- Step 21: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "La {item:11242} crece dentro de un edificio en ruinas al norte del campamento de {npc:7775}, al este de {area:1114} de las arpías: entra por la parte rota de su muro.",

	-- Step 22: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "Vuelve al sur con {npc:7775}. Guarda el elixir y no lo bebas todavía: te mata, y así es como conocerás más tarde a Gaeriyan junto a {area:976}.",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}, la recompensa de {npc:7775}",

	-- Step 24: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Vuela a {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",

	-- Step 25: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 26: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} en {area:1639}; {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} espera en {zone:1450}: guárdala para más tarde.",

	-- Step 27: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "",

	-- Step 29: Magatha Grimtotem
	-- {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise
	["{npc:4046} stands on {area:1639}."] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["Delivery to {npc:4046}, from Jediga in {zone:1447}"] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["{npc:4046}'s payment goes back to Jediga in {zone:1447}, which the route doesn't pass again: leave it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Cualquier fúrbolg Nevada puede llevar las cuentas; los campamentos justo al sur de {npc:11556} son los más cercanos.",
	-- ["Back at {area:1099}."] = "De vuelta en {area:1099}.",
	-- ["Back to {area:2255}"] = "De vuelta a {area:2255}",
	-- ["Below ground"] = "Bajo tierra",
	-- ["Chillwind chimaeras"] = "Quimeras venfresco",
	-- ["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- ["From Krakle in Un'Goro"] = "De Krakle en Un'Goro",
	-- ["Frostfire Winterfall camp"] = "Campamento Nevada de los Baños de Fuego de Escarcha",
	-- ["Frostfire Winterfall camps"] = "Campamentos Nevada de los Baños de Fuego de Escarcha",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "Las misiones de Gregor y Harlo llevan a otras zonas: guárdalas.",
	-- ["Grind to 55"] = "Sube hasta el nivel 55",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Está en {area:1641}. Cada donación pide tela de tus bolsas; entrégalas cuando la tengas, más adelante en la ruta.",
	-- ["In the {object:172958}."] = "En {object:172958}.",
	-- ["In the {object:172961}."] = "En {object:172961}.",
	-- ["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Las matriarcas y patriarcas pegan fuerte: atráelos de uno en uno.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Abrecaminos, vigilantes del cubil y totémicos comparten los campamentos fúrbolg alrededor de las fuentes termales; las Lechubestias andrajosas deambulan por las laderas entre ellos. Mata primero a los totémicos. Guarda todo el {item:14047} que consigas para Meilosh.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Abrecaminos, vigías del cubil y totémicos comparten los campamentos fúrbolg alrededor de las fuentes termales; las Lechubestias pulgosas deambulan por las laderas entre ellos. Mata primero a los totémicos. Guarda todo el {item:14047} que consigas para Meilosh.\nCuidado: los vigías del cubil llegan al nivel 56: atráelos de uno en uno y aléjate de los tótems de los campamentos.",
	-- ["Pristine Yeti Horns"] = "Cuernos de yeti prístinos",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Las Lechubestias enfurecidas deambulan por las colinas al norte de {area:2251}, junto al camino entre {area:2246} y {area:2255}. Cuidado: las más grandes son de nivel 56: atráelas de una en una.",
	-- ["Ride back west to {area:2246}."] = "Vuelve al oeste hasta {area:2246}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Cabalga al este y luego al sur bajando por {area:2249}. Los Gigantes Machacahielo de allí son élite de nivel 59: ve por el centro y no te detengas. La fuente extraña está en la boca de {area:2256}, en el extremo sur.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Cabalga al oeste por el camino pasando {area:2251}; las Lechubestias enfurecidas deambulan por las colinas al norte.",
	-- ["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Las quimeras deambulan por los campos nevados al sur y al oeste de {area:2255}. Aléjate de la cueva de {area:2245}: sus dragonantes azules son élite.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "El poblado fúrbolg llena el valle al noreste de {area:2255}. Mata primero a los chamanes; curan. {npc:10738}, en la cueva del fondo, es élite: no entres.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "Las colinas de los yetis empiezan justo al sureste de {area:2255}. Todos los yetis sueltan pelaje: céntrate en los Yetis Cardo Nevado (55-56) y deja las matriarcas y patriarcas (56-58), cuyos cuernos son para una visita posterior.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Las colinas de los yetis empiezan justo al sureste de {area:2255}. Todos los yetis sueltan pelaje; solo las matriarcas y patriarcas sueltan cuernos, así que déjalos para después de la entrega.",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Sube aquí hasta el nivel 55.04 antes de las entregas en {area:2255}: te llevan al nivel 56. Los yetis Cardo Nevado (55-56) son los de menor nivel aquí; las matriarcas y patriarcas (56-58) pegan más fuerte. O, con un grupo, haz en su lugar la mazmorra {area:1584} o la mazmorra {area:1583} (inferior).",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "La tercera broma de Umi va contra goblins de {area:976} y Un'Goro: guárdala para más tarde.",
	-- ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Umi: guárdala, los Cuernos de yeti prístinos se consiguen en la parada de {area:2255} de la Guía de {zone:1423}, hacia el nivel 57",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "sube de nivel con {npc:7440} en {area:2244}, {zone:1452}",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, botín raro de los fúrbolgs Nevada",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, a su lado",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "{npc:7775}, un enano, acampa en {area:1137}, al noroeste de {area:1099}. Solo prepara el {item:11243} a partir de una {item:11242} que le lleves.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "{npc:7775}, un enano, acampa en {area:1137}, al noroeste de {area:1099}; tiene el elixir.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} compra {item:11040} cultivado con tu {quest:3761}.",
	-- ["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} la da {npc:7775} en {zone:1444}, más adelante en esta guía.",
}
