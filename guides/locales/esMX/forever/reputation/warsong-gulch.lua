-- Spanish (Latin America) (esMX): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "Reputación: Garganta Grito de Guerra",

	-- Step 1: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890} hasta Amistoso",
	-- {faction:890} Silverwing Sentinels · {zone:1460} Warsong Gulch
	["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890} son los elfos de la noche que defienden {zone:1460}. Su reputación viene del campo de batalla: cada bandera enemiga que captura tu equipo se la otorga a todo el equipo. Ponte en cola con cualquier maestro de batalla. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- {npc:14733} Sentinel Farsong
	["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733} acepta Marcas de Honor de la Garganta Grito de Guerra para ¡Expulsa al invasor!, una vez por rango de nivel (según los datos); compruébalo en el juego.",

	-- Step 2: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890} hasta Honorable",
	-- {zone:1460} Warsong Gulch · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Sigue jugando en {zone:1460} y capturando banderas. En los fines de semana de Llamada a las armas: {zone:1460}, {npc:15351} en las capitales acepta tres Marcas de Honor de la Garganta Grito de Guerra a cambio de reputación extra.",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753} entrega un paquete de provisiones de las Centinelas según el nivel",

	-- Step 3: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890} hasta Reverenciado",
	-- {zone:1460} Warsong Gulch
	["Keep capturing flags in {zone:1460}."] = "Sigue capturando banderas en {zone:1460}.",

	-- Step 4: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890} hasta Exaltado",
	-- {faction:890} Silverwing Sentinels
	["Exalted with the {faction:890} earns a Legacy Point."] = "Ser Exaltado con {faction:890} otorga un Punto de legado.",

	-- Step 5: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889} hasta Amistoso",
	-- {faction:889} Warsong Outriders · {zone:1440} Ashenvale
	["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889} son los orcos que talan {zone:1440}. Su reputación viene del campo de batalla: cada bandera enemiga que captura tu equipo se la otorga a todo el equipo. Ponte en cola con cualquier maestro de batalla. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- {npc:14781} Captain Shatterskull
	["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781} acepta Marcas de Honor de la Garganta Grito de Guerra para Acaba con los usurpadores Ala de Plata, una vez por rango de nivel (según los datos); compruébalo en el juego.",

	-- Step 6: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889} hasta Honorable",
	-- {zone:1460} Warsong Gulch · {npc:15350} Horde Warbringer
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "Sigue jugando en {zone:1460} y capturando banderas. En los fines de semana de Llamada a las armas: {zone:1460}, {npc:15350} en las capitales acepta tres Marcas de Honor de la Garganta Grito de Guerra a cambio de reputación extra.",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754} entrega un paquete de provisiones de los Escoltas según el nivel",

	-- Step 7: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889} hasta Reverenciado",

	-- Step 8: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889} hasta Exaltado",
	-- {faction:889} Warsong Outriders
	["Exalted with the {faction:889} earns a Legacy Point."] = "Ser Exaltado con {faction:889} otorga un Punto de legado.",
}
