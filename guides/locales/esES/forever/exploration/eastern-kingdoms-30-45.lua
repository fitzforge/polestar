-- Spanish (Spain) (esES): the guide forever/exploration/eastern-kingdoms-30-45 (forever/exploration/eastern-kingdoms-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 30-45"] = "Exploración: {zone:1415} 30-45",

	-- Step 1: Alterac Mountains (1/2)
	-- {zone:1424} Hillsbrad Foothills
	["Picks up in {zone:1424}, where the 1-30 guide leaves the Horde and passes the Alliance. 15 areas to discover here, levels 27-39."] = "Empieza en {zone:1424}, donde la guía 1-30 deja a la Horda y por donde pasa la Alianza. 15 áreas por descubrir aquí, niveles 27-39.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Explorar el mapa del mundo entero con un personaje es un Desafío de Legado de Forever (1 Punto de Legado para toda la cuenta).",
	-- {area:271} Southshore · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:271} in {zone:1424} and walk north into the {zone:1416}."] = "Vuela a {area:271}, en {zone:1424}, y camina hacia el norte hasta {zone:1416}.",
	-- {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:272} in {zone:1424} and walk north into the {zone:1416}."] = "Vuela a {area:272}, en {zone:1424}, y camina hacia el norte hasta {zone:1416}.",
	["any one of these names counts"] = "cualquiera de estos nombres cuenta",

	-- Step 3: Arathi Highlands (1/2)
	["16 areas to discover here, levels 30-40."] = "16 áreas por descubrir aquí, niveles 30-40.",
	-- {zone:1417} Arathi Highlands · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	["The {zone:1417} lie east of the {zone:1416} and {zone:1424}."] = "{zone:1417} están al este de {zone:1416} y {zone:1424}.",
	-- {area:320} Refuge Pointe · {area:321} Hammerfall
	["{area:320} in the middle is the Alliance town; {area:321} in the east is Horde."] = "{area:320}, en el centro, es el pueblo de la Alianza; {area:321}, al este, es de la Horda.",
	-- {area:321} Hammerfall · {area:320} Refuge Pointe
	["{area:321} in the east is the Horde town; {area:320} in the middle is Alliance."] = "{area:321}, al este, es el pueblo de la Horda; {area:320}, en el centro, es de la Alianza.",
	-- {area:320} Refuge Pointe · {npc:2835} Cedrik Prose
	["Flight path here: {area:320} ({npc:2835})."] = "Ruta de vuelo aquí: {area:320} ({npc:2835}).",
	-- {area:321} Hammerfall
	["Flight path here: {area:321} (Urda)."] = "Ruta de vuelo aquí: {area:321} (Urda).",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "Pueblo de la Alianza: los personajes de la Horda solo tienen que tocar su borde (guardias)",

	-- Step 4: Arathi Highlands (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "Pueblo de la Horda: los personajes de la Alianza solo tienen que tocar su borde (guardias)",
	["elite Syndicate and ogres inside the walls: the discovery triggers at the gate"] = "Sindicato y ogros élite tras los muros: el descubrimiento se activa en la puerta",

	-- Step 5: Badlands (1/2)
	["14 areas to discover here, levels 36-45."] = "14 áreas por descubrir aquí, niveles 36-45.",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {object:1668} Dun Algaz (no name in this language: may be words) · {zone:1432} Loch Modan · {zone:1418} Badlands
	["Cross the {area:880} south into the {zone:1437}, go through the {object:1668} pass into {zone:1432} and take the road south out of {zone:1432} into the {zone:1418}."] = "Cruza {area:880} hacia el sur hasta {zone:1437}, atraviesa el paso de {object:1668} hasta {zone:1432} y toma el camino que sale de {zone:1432} hacia el sur hasta {zone:1418}.",
	-- {area:144} Thelsamar · {zone:1432} Loch Modan
	["Faster: fly to {area:144} in {zone:1432}."] = "Más rápido: vuela a {area:144}, en {zone:1432}.",
	-- {area:340} Kargath
	["{area:340} in the west is the Horde town."] = "{area:340}, al oeste, es el pueblo de la Horda.",
	-- {area:340} Kargath
	["Flight path here: {area:340} (Gorrik)."] = "Ruta de vuelo aquí: {area:340} (Gorrik).",

	-- Step 7: Riverglades (1/2)
	["14 areas to discover here, levels 36-44."] = "14 áreas por descubrir aquí, niveles 36-44.",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1428} Burning Steppes · {zone:1433} Redridge Mountains · {zone:1446} Tanaris · {area:16727} Powderfuse Port · {area:17780} Krol'dok Stronghold
	["The {zone:2548} lie east of the {zone:1418} and the {zone:1428}: the way in is the fork east off the {zone:1433} road (a ship also runs from {zone:1446} to {area:16727}, the neutral goblin port on its coast). {area:17780} is an ogre clan's outdoor dungeon."] = "{zone:2548} está al este de {zone:1418} y {zone:1428}: se entra por el desvío hacia el este del camino de {zone:1433} (también hay un barco de {zone:1446} a {area:16727}, el puerto goblin neutral de su costa). {area:17780} es la mazmorra al aire libre de un clan de ogros.",

	-- Step 9: Stranglethorn Vale (1/4)
	-- {area:35} Booty Bay · {area:392} Ratchet
	["27 areas to discover here, levels 30-50. {area:35} at the southern tip is a neutral goblin port with a boat to {area:392}."] = "27 áreas por descubrir aquí, niveles 30-50. {area:35}, en el extremo sur, es un puerto goblin neutral con barco a {area:392}.",
	-- {area:42} Darkshire · {zone:1453} Stormwind · {zone:1431} Duskwood · {zone:1434} Stranglethorn Vale
	["Fly to {area:42} (or {zone:1453}) and take the road south out of {zone:1431} into northern {zone:1434}."] = "Vuela a {area:42} (o a {zone:1453}) y toma el camino que sale de {zone:1431} hacia el sur hasta el norte de {zone:1434}.",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:117} Grom'gol Base Camp
	["Take the zeppelin from {zone:1454} or the {zone:1458} to {area:117}."] = "Toma el zepelín de {zone:1454} o de {zone:1458} a {area:117}.",
	-- {area:35} Booty Bay
	["Flight path here: {area:35} (Gyll)."] = "Ruta de vuelo aquí: {area:35} (Gyll).",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Flight paths here: {area:35} (Gringer), {object:3202} (Thysta)."] = "Rutas de vuelo aquí: {area:35} (Gringer), {object:3202} (Thysta).",

	-- Step 10: Stranglethorn Vale (2/4)
	["free-for-all PvP inside the arena ring"] = "JcJ libre dentro del círculo de la arena",

	-- Step 11: Stranglethorn Vale (3/4)
	["level 50 area, well above this guide's range"] = "área de nivel 50, muy por encima del rango de esta guía",

	-- Step 12: Stranglethorn Vale (4/4)
	["elite ogres: discover it from the edge"] = "ogros élite: descúbrela desde el borde",

	-- Step 13: Swamp of Sorrows (1/2)
	["11 areas to discover here, levels 36-43."] = "11 áreas por descubrir aquí, niveles 36-43.",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows
	["Go back north into {zone:1431} and follow its road east through {zone:1430} (level 50+ creatures off the road) into the {zone:1435}."] = "Vuelve al norte a {zone:1431} y sigue su camino hacia el este por {zone:1430} (criaturas de nivel 50+ fuera del camino) hasta {zone:1435}.",
	-- {area:75} Stonard
	["{area:75} is the Horde town."] = "{area:75} es el pueblo de la Horda.",
	-- {area:75} Stonard
	["Flight path here: {area:75} (Breyk)."] = "Ruta de vuelo aquí: {area:75} (Breyk).",
}
