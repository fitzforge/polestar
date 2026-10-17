-- Spanish (Latin America) (esMX): the guide forever/exploration/kalimdor-30-45 (forever/exploration/kalimdor-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1414} Kalimdor
	["Exploration: {zone:1414} 30-45"] = "Exploración: {zone:1414} 30-45",

	-- Step 1: Desolace (1/2)
	-- {zone:1413} Barrens · {zone:1443} Desolace · {zone:1445} Dustwallow Marsh
	["Picks up west of the {zone:1413}, in {zone:1443}, and ends in {zone:1445}. 15 areas to discover here, levels 30-39."] = "Comienza al oeste de {zone:1413}, en {zone:1443}, y termina en {zone:1445}. 15 áreas por descubrir aquí, niveles 30-39.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Explorar todo el mapa del mundo con un solo personaje es un Desafío de legado de Forever (1 Punto de legado para toda la cuenta).",
	-- {zone:1442} Stonetalon Mountains · {zone:1443} Desolace · {area:608} Nijel's Point
	["Take the road south-west out of the {zone:1442} into {zone:1443}; {area:608} in the north is the Alliance town."] = "Toma el camino hacia el suroeste que sale de {zone:1442} hasta {zone:1443}; {area:608}, en el norte, es el pueblo de la Alianza.",
	-- {area:460} Sun Rock Retreat · {zone:1443} Desolace · {area:2408} Shadowprey Village
	["Fly to {area:460} and take the road south-west into {zone:1443}; {area:2408} on the west coast is the Horde town."] = "Vuela a {area:460} y toma el camino hacia el suroeste hasta {zone:1443}; {area:2408}, en la costa oeste, es el pueblo de la Horda.",
	-- {area:608} Nijel's Point · {npc:6706} Baritanas Skyriver
	["Flight path here: {area:608} ({npc:6706})."] = "Ruta de vuelo aquí: {area:608} ({npc:6706}).",
	-- {area:2408} Shadowprey Village
	["Flight path here: {area:2408} (Thalon)."] = "Ruta de vuelo aquí: {area:2408} (Thalon).",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "Pueblo de la Alianza: los personajes de la Horda solo necesitan tocar su borde (guardias)",

	-- Step 2: Desolace (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "Pueblo de la Horda: los personajes de la Alianza solo necesitan tocar su borde (guardias)",

	-- Step 3: Shen'dralas
	["7 areas to discover here."] = "7 áreas por descubrir aquí.",
	-- {zone:2652} Shen'dralas · {zone:1443} Desolace · {zone:1412} Mulgore · {area:2657} Valley of Bones
	["{zone:2652}, the ruins between {zone:1443} and {zone:1412}, is entered from southern {zone:1443} through the {area:2657}."] = "A {zone:2652}, las ruinas entre {zone:1443} y {zone:1412}, se entra desde el sur de {zone:1443} por {area:2657}.",

	-- Step 4: Feralas (1/2)
	["16 areas to discover here, levels 41-60."] = "16 áreas por descubrir aquí, niveles 41-60.",
	-- {zone:1443} Desolace · {zone:1444} Feralas
	["Go back into southern {zone:1443}; the road continues south into {zone:1444}."] = "Regresa al sur de {zone:1443}; el camino continúa hacia el sur hasta {zone:1444}.",
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast
	["{area:1116} on {area:1120} is the Alliance town (boat from the {area:1108})."] = "{area:1116}, en {area:1120}, es el pueblo de la Alianza (barco desde {area:1108}).",
	-- {area:1099} Camp Mojache
	["{area:1099} in the east is the Horde town."] = "{area:1099}, en el este, es el pueblo de la Horda.",
	-- {area:489} Thalanaar · {npc:8019} Fyldren Moonfeather
	["Flight paths here: {area:489} (Thyssiana), Feathermoon ({npc:8019})."] = "Rutas de vuelo aquí: {area:489} (Thyssiana), Bastión Plumaluna ({npc:8019}).",
	-- {area:1099} Camp Mojache
	["Flight path here: {area:1099} (Shyn)."] = "Ruta de vuelo aquí: {area:1099} (Shyn).",
	["level 60 area, well above this guide's range"] = "área de nivel 60, muy por encima del rango de esta guía",

	-- Step 6: Dustwallow Marsh
	["7 areas to discover here, levels 36-61."] = "7 áreas por descubrir aquí, niveles 36-61.",
	-- {area:150} Menethil Harbor · {area:513} Theramore Isle
	["Fly to Theramore (or take the boat from {area:150}); {area:513} is the Alliance town."] = "Vuela a Isla Theramore (o toma el barco desde {area:150}); {area:513} es el pueblo de la Alianza.",
	-- {zone:1445} Dustwallow Marsh · {zone:1413} Barrens · {area:496} Brackenwall Village
	["{zone:1445} is east of the southern {zone:1413}; {area:496} in the north-west is the Horde town."] = "{zone:1445} está al este del sur de {zone:1413}; {area:496}, en el noroeste, es el pueblo de la Horda.",
	["Flight path here: Theramore (Baldruc)."] = "Ruta de vuelo aquí: Isla Theramore (Baldruc).",
	-- {area:496} Brackenwall Village
	["Flight path here: {area:496} (Shardi)."] = "Ruta de vuelo aquí: {area:496} (Shardi).",
	["any one of these names counts"] = "cualquiera de estos nombres cuenta",
	["Horde town: Alliance characters only need to touch its edge (guards); any one of these names counts"] = "Pueblo de la Horda: los personajes de la Alianza solo necesitan tocar su borde (guardias); cualquiera de estos nombres cuenta",
	["level 61 area, well above this guide's range"] = "área de nivel 61, muy por encima del rango de esta guía",
	["Alliance town: Horde characters only need to touch its edge (guards); any one of these names counts"] = "Pueblo de la Alianza: los personajes de la Horda solo necesitan tocar su borde (guardias); cualquiera de estos nombres cuenta",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1108}"] = "{area:1108}",
}
