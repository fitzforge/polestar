-- Spanish (Latin America) (esMX): the guide forever/exploration/eastern-kingdoms-1-30 (forever/exploration/eastern-kingdoms-1-30.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 1-30"] = "Exploración: {zone:1415} 1-30",

	-- Step 1: Elwynn Forest (1/2)
	-- {zone:1429} Elwynn Forest · {zone:1426} Dun Morogh
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Alliance starts in {zone:1429}; dwarves and gnomes can begin at the {zone:1426} step. 12 areas to discover here, levels 5-10."] = "Descubrir un área da experiencia según su nivel, así que esto se hace mientras subes de nivel. La Alianza empieza en {zone:1429}; los enanos y gnomos pueden empezar en el paso de {zone:1426}. 12 áreas por descubrir aquí, niveles 5-10.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Explorar todo el mapa del mundo con un personaje es un Desafío de Legado de Forever (1 Punto de Legado para toda la cuenta).",
	-- {area:9} Northshire Valley · {zone:1429} Elwynn Forest · {area:87} Goldshire
	["{area:9} opens onto {zone:1429}; {area:87} is south down the road."] = "{area:9} da a {zone:1429}; {area:87} está al sur, siguiendo el camino.",

	-- Step 2: Elwynn Forest (2/2)
	["any one of these names counts"] = "cualquiera de estos nombres cuenta",

	-- Step 3: Westfall (1/2)
	["14 areas to discover here, levels 9-18."] = "14 áreas por descubrir aquí, niveles 9-18.",
	-- {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:120} Westbrook Garrison
	["{zone:1436} borders {zone:1429} to the west: follow the road out past the {area:120}."] = "{zone:1436} limita al oeste con {zone:1429}: sigue el camino más allá de {area:120}.",
	-- {area:108} Sentinel Hill
	["Flight path here: {area:108} (Thor)."] = "Ruta de vuelo aquí: {area:108} (Thor).",

	-- Step 5: Duskwood (1/2)
	["13 areas to discover here, levels 10-30."] = "13 áreas por descubrir aquí, niveles 10-30.",
	-- {zone:1431} Duskwood · {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:42} Darkshire
	["{zone:1431} is east of {zone:1436} and south of {zone:1429}. Its road runs east to {area:42}."] = "{zone:1431} está al este de {zone:1436} y al sur de {zone:1429}. Su camino va al este hasta {area:42}.",
	-- {area:42} Darkshire · {npc:2409} Felicia Maline
	["Flight path here: {area:42} ({npc:2409})."] = "Ruta de vuelo aquí: {area:42} ({npc:2409}).",

	-- Step 7: Redridge Mountains (1/2)
	["11 areas to discover here, levels 15-24."] = "11 áreas por descubrir aquí, niveles 15-24.",
	-- {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood
	["Redridge starts at {area:1002}, where the roads from {zone:1429} and {zone:1431} meet."] = "Las Montañas Crestagrana empiezan en {area:1002}, donde se juntan los caminos de {zone:1429} y {zone:1431}.",
	-- {area:69} Lakeshire · {npc:931} Ariena Stormfeather
	["Flight path here: {area:69} ({npc:931})."] = "Ruta de vuelo aquí: {area:69} ({npc:931}).",

	-- Step 9: Dun Morogh (1/3)
	["18 areas to discover here, levels 4-12."] = "18 áreas por descubrir aquí, niveles 4-12.",
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind City · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "Toma el {area:2257} desde {object:28027} de {zone:1453} hasta {zone:1455} (o vuela a {zone:1455}) y luego sal de la ciudad por sus puertas.",

	-- Step 12: Loch Modan (1/2)
	["11 areas to discover here, levels 10-18."] = "11 áreas por descubrir aquí, niveles 10-18.",
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:925} Algaz Station
	["Leave {zone:1426} east through the gate tunnel; it opens into {zone:1432} at {area:925}."] = "Sal de {zone:1426} hacia el este por el túnel de la puerta; da a {zone:1432} en {area:925}.",
	-- {area:144} Thelsamar · {npc:1572} Thorgrum Borrelson
	["Flight path here: {area:144} ({npc:1572})."] = "Ruta de vuelo aquí: {area:144} ({npc:1572}).",

	-- Step 14: Wetlands (1/2)
	["15 areas to discover here, levels 20-30."] = "15 áreas por descubrir aquí, niveles 20-30.",
	-- {area:925} Algaz Station · {area:836} Dun Algaz · {zone:1437} Wetlands
	["From {area:925}, the road north through the {area:836} pass leads into the {zone:1437}."] = "Desde {area:925}, el camino al norte por el paso de {area:836} lleva a {zone:1437}.",
	-- {area:150} Menethil Harbor · {npc:1571} Shellei Brondir
	["Flight path here: {area:150} ({npc:1571})."] = "Ruta de vuelo aquí: {area:150} ({npc:1571}).",
	-- {area:1038} Dragonmaw Gates · {area:1037} Grim Batol
	["the discovery triggers at the {area:1038}: do not go into {area:1037} itself"] = "el descubrimiento se activa en {area:1038}: no entres en {area:1037}",

	-- Step 16: Hillsbrad Foothills (1/2)
	["12 areas to discover here, levels 20-31."] = "12 áreas por descubrir aquí, niveles 20-31.",
	-- {area:881} Thandol Span · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {zone:1424} Hillsbrad Foothills
	["Cross the {area:881} in northern {zone:1437} into the {zone:1417} (level 30+ creatures off the road), follow the road west past {area:320} and on into {zone:1424}."] = "Cruza {area:881}, en el norte de {zone:1437}, hacia {zone:1417} (criaturas de nivel 30+ fuera del camino); sigue el camino al oeste más allá de {area:320} y continúa hasta {zone:1424}.",
	-- {area:271} Southshore · {npc:2432} Darla Harris
	["Flight path here: {area:271} ({npc:2432})."] = "Ruta de vuelo aquí: {area:271} ({npc:2432}).",
	-- {area:272} Tarren Mill
	["Horde guards: touch the edge of {area:272} and move on"] = "Guardias de la Horda: toca el borde de {area:272} y sigue",

	-- Step 18: Silverpine Forest (1/2)
	["15 areas to discover here, levels 10-20."] = "15 áreas por descubrir aquí, niveles 10-20.",
	-- {area:287} Hillsbrad · {area:285} Southpoint Tower · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["Follow the road west from {area:287} past {area:285} into {zone:1421}, Horde country with Horde guards at the {area:228}."] = "Sigue el camino al oeste desde {area:287}, más allá de {area:285}, hasta {zone:1421}, territorio de la Horda con guardias de la Horda en {area:228}.",
	-- {area:228} Sepulcher
	["Horde guards: touch the edge of {area:228} and move on"] = "Guardias de la Horda: toca el borde de {area:228} y sigue",

	-- Step 20: Tirisfal Glades (1/3)
	["17 areas to discover here, levels 5-10."] = "17 áreas por descubrir aquí, niveles 5-10.",
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {area:154} Deathknell · {zone:1458} Undercity
	["Silverpine's road north leads into {zone:1420}. {area:159}, {area:154} and the {zone:1458} ruins are Horde ground."] = "El camino al norte del Bosque de Argénteos lleva a {zone:1420}. {area:159}, {area:154} y las ruinas de {zone:1458} son territorio de la Horda.",
	-- {area:153} Ruins of Lordaeron
	["Horde guards: touch the edge of {area:153} and move on"] = "Guardias de la Horda: toca el borde de {area:153} y sigue",

	-- Step 21: Tirisfal Glades (2/3)
	-- {area:159} Brill
	["Horde guards: touch the edge of {area:159} and move on"] = "Guardias de la Horda: toca el borde de {area:159} y sigue",

	-- Step 22: Tirisfal Glades (3/3)
	-- {area:154} Deathknell
	["Horde guards: touch the edge of {area:154} and move on"] = "Guardias de la Horda: toca el borde de {area:154} y sigue",

	-- Step 23: Tirisfal Glades (1/3)
	-- {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Horde starts in {zone:1420}; orcs, trolls and tauren arrive by zeppelin from {zone:1454}. 17 areas to discover here, levels 5-10."] = "Descubrir un área da experiencia según su nivel, así que esto se hace mientras subes de nivel. La Horda empieza en {zone:1420}; los orcos, trols y tauren llegan en zepelín desde {zone:1454}. 17 áreas por descubrir aquí, niveles 5-10.",
	-- {area:154} Deathknell · {zone:1420} Tirisfal Glades · {area:159} Brill · {zone:1458} Undercity
	["{area:154} opens onto {zone:1420}; {area:159} is east along the road. Orcs, trolls and tauren arrive at the zeppelin tower by the {zone:1458}."] = "{area:154} da a {zone:1420}; {area:159} está al este, siguiendo el camino. Los orcos, trols y tauren llegan a la torre del zepelín junto a {zone:1458}.",

	-- Step 26: Silverpine Forest (1/2)
	-- {zone:1421} Silverpine Forest · {zone:1420} Tirisfal Glades · {area:159} Brill
	["{zone:1421} is south of {zone:1420}: follow the road south from {area:159}."] = "{zone:1421} está al sur de {zone:1420}: sigue el camino al sur desde {area:159}.",
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["Flight path here: {area:228} ({npc:2226})."] = "Ruta de vuelo aquí: {area:228} ({npc:2226}).",

	-- Step 28: Hillsbrad Foothills (1/2)
	-- {zone:1424} Hillsbrad Foothills · {area:285} Southpoint Tower · {area:272} Tarren Mill · {area:271} Southshore
	["At the south end of Silverpine the road turns east into {zone:1424} by {area:285}. {area:272} in the north-east is the Horde town; {area:271} is Alliance."] = "En el extremo sur del Bosque de Argénteos, el camino gira al este hacia {zone:1424} junto a {area:285}. {area:272}, al noreste, es el pueblo de la Horda; {area:271} es de la Alianza.",
	-- {area:272} Tarren Mill
	["Flight path here: {area:272} (Zarise)."] = "Ruta de vuelo aquí: {area:272} (Zarise).",

	-- Step 29: Hillsbrad Foothills (2/2)
	-- {area:271} Southshore
	["Alliance guards: touch the edge of {area:271} and move on"] = "Guardias de la Alianza: toca el borde de {area:271} y sigue",

	-- Step 30: Wetlands (1/2)
	-- {area:287} Hillsbrad · {zone:1417} Arathi Highlands · {area:881} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["Walk east from {area:287} into the {zone:1417} (level 30+ creatures off the road), south to the {area:881} bridge, and across it into the {zone:1437}. {area:150} is an Alliance town."] = "Camina al este desde {area:287} hasta {zone:1417} (criaturas de nivel 30+ fuera del camino), al sur hasta el puente de {area:881}, y crúzalo hacia {zone:1437}. {area:150} es un pueblo de la Alianza.",

	-- Step 31: Wetlands (2/2)
	-- {area:150} Menethil Harbor
	["Alliance guards: touch the edge of {area:150} and move on"] = "Guardias de la Alianza: toca el borde de {area:150} y sigue",

	-- Step 32: Loch Modan (1/2)
	-- {area:836} Dun Algaz · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:925} Algaz Station
	["The {area:836} pass in south-eastern {zone:1437} leads down into {zone:1432} by {area:925}."] = "El paso de {area:836}, en el sureste de {zone:1437}, baja hasta {zone:1432} junto a {area:925}.",

	-- Step 33: Loch Modan (2/2)
	-- {area:144} Thelsamar
	["Alliance guards: touch the edge of {area:144} and move on"] = "Guardias de la Alianza: toca el borde de {area:144} y sigue",

	-- Step 34: Dun Morogh (1/3)
	-- {area:925} Algaz Station · {zone:1426} Dun Morogh · {area:131} Kharanos · {zone:1455} Ironforge
	["From {area:925} take the tunnel west into {zone:1426}. {area:131} and {zone:1455}'s gates are Alliance ground."] = "Desde {area:925}, toma el túnel al oeste hacia {zone:1426}. {area:131} y las puertas de {zone:1455} son territorio de la Alianza.",

	-- Step 35: Dun Morogh (2/3)
	-- {area:809} Gates of Ironforge
	["Alliance guards: touch the edge of {area:809} and move on; any one of these names counts"] = "Guardias de la Alianza: toca el borde de {area:809} y sigue; cualquiera de estos nombres cuenta",
	-- {area:131} Kharanos
	["Alliance guards: touch the edge of {area:131} and move on"] = "Guardias de la Alianza: toca el borde de {area:131} y sigue",

	-- Step 36: Dun Morogh (3/3)
	-- {area:132} Coldridge Valley
	["Alliance guards: touch the edge of {area:132} and move on; any one of these names counts"] = "Guardias de la Alianza: toca el borde de {area:132} y sigue; cualquiera de estos nombres cuenta",

	-- Step 37: Duskwood (1/2)
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:117} Grom'gol Base Camp · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	["Hearth or fly back to the {zone:1458} (or go to {zone:1454}), take the zeppelin to {area:117} in {zone:1434} and walk north along the road into {zone:1431}. Northern Stranglethorn is level 30+ off the road."] = "Usa tu piedra de hogar o vuela de vuelta a {zone:1458} (o ve a {zone:1454}), toma el zepelín a {area:117} en {zone:1434} y camina al norte por el camino hasta {zone:1431}. El norte de la Vega de Tuercespina es de nivel 30+ fuera del camino.",
	-- {area:42} Darkshire
	["Alliance guards: touch the edge of {area:42} and move on"] = "Guardias de la Alianza: toca el borde de {area:42} y sigue",

	-- Step 39: Westfall (1/2)
	-- {zone:1436} Westfall · {zone:1431} Duskwood · {area:108} Sentinel Hill
	["{zone:1436} borders {zone:1431} to the west. {area:108} is an Alliance town."] = "{zone:1436} limita al oeste con {zone:1431}. {area:108} es un pueblo de la Alianza.",

	-- Step 40: Westfall (2/2)
	-- {area:108} Sentinel Hill
	["Alliance guards: touch the edge of {area:108} and move on"] = "Guardias de la Alianza: toca el borde de {area:108} y sigue",

	-- Step 41: Elwynn Forest (1/2)
	["12 areas to discover here, levels 5-10."] = "12 áreas por descubrir aquí, niveles 5-10.",
	-- {zone:1429} Elwynn Forest · {zone:1436} Westfall · {zone:1431} Duskwood · {area:87} Goldshire · {area:9} Northshire Valley · {zone:1453} Stormwind City
	["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429} está al norte de {zone:1436} y {zone:1431}. {area:87}, {area:9} y las puertas de {zone:1453} son territorio de la Alianza con guardias.",
	-- {zone:1453} Stormwind City
	["Alliance guards: touch the edge of {zone:1453} and move on; any one of these names counts"] = "Guardias de la Alianza: toca el borde de {zone:1453} y sigue; cualquiera de estos nombres cuenta",
	-- {area:9} Northshire Valley
	["Alliance guards: touch the edge of {area:9} and move on"] = "Guardias de la Alianza: toca el borde de {area:9} y sigue",
	-- {area:87} Goldshire
	["Alliance guards: touch the edge of {area:87} and move on"] = "Guardias de la Alianza: toca el borde de {area:87} y sigue",

	-- Step 43: Redridge Mountains (1/2)
	-- {zone:1429} Elwynn Forest · {area:1002} Three Corners · {area:69} Lakeshire
	["Go east through {zone:1429} to {area:1002}, where Redridge starts. {area:69} is an Alliance town."] = "Ve al este por {zone:1429} hasta {area:1002}, donde empiezan las Montañas Crestagrana. {area:69} es un pueblo de la Alianza.",
	-- {area:69} Lakeshire
	["Alliance guards: touch the edge of {area:69} and move on"] = "Guardias de la Alianza: toca el borde de {area:69} y sigue",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Flight path here: {area:228} ({npc:2226})."] = "Ruta de vuelo aquí: {area:228} ({npc:2226}).",
	-- ["Horde guards: touch the edge of {area:228} and move on"] = "Guardias de la Horda: toca el borde de {area:228} y sigue",
	-- ["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "Toma el {area:2257} desde {object:28027} de {zone:1453} hasta {zone:1455} (o vuela a {zone:1455}) y luego sal de la ciudad por sus puertas.",
	-- ["The {area:228}"] = "{area:228}",
	-- ["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429} está al norte de {zone:1436} y {zone:1431}. {area:87}, {area:9} y las puertas de {zone:1453} son territorio de la Alianza con guardias.",
}
