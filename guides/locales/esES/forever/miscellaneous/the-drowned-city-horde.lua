-- Spanish (Spain) (esES): the guide forever/miscellaneous/the-drowned-city-horde (forever/miscellaneous/the-drowned-city-horde.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16550} The Drowned City
	["{area:16550} (Horde)"] = "{area:16550} (Horda)",
	-- {area:16550} The Drowned City
	["Every Horde quest of the {area:16550} in one run, lead-ins included."] = "Todas las misiones de la Horda de {area:16550} en una pasada, con las misiones que las preceden incluidas.",

	-- Step 2: The Vile Reef
	-- {object:58} Gri'lek the Wanderer · {area:104} Vile Reef · {object:3202} Grom'gol (no name in this language: may be words)
	["The tablet, {object:58}, lies on the sea floor of the {area:104}, west of {object:3202}. Mind your breath."] = "La tablilla, {object:58}, yace en el fondo del mar de {area:104}, al oeste de {object:3202}. Vigila tu respiración.",

	-- Step 4: Fall of Gurubashi
	-- {area:102} Ruins of Zul'Kunda · {area:104} Vile Reef
	["In the {area:102}, on the hill north of the {area:104}. Click the tablet for the rubbing."] = "En {area:102}, en la colina al norte de {area:104}. Haz clic en la tablilla para el calco.",

	-- Step 6: The Lost City's entrance
	["The Lost City's entrance"] = "La entrada de la Ciudad Perdida",
	-- {area:104} Vile Reef · {area:17853} Sunken Hollow · {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Brinescale Skirmishers = {npc:262397} Brinescale Skirmisher
	["Brinescale Skirmishers around the {area:104} drop the tridents. The cavern entrance the quest asks for is under the reef, in {area:17853}: due west of {object:3202} and south-west of the reef's tablet."] = "Los Escaramuzadores Escama de Sal de los alrededores de {area:104} sueltan los tridentes. La entrada de la caverna que pide la misión está bajo el arrecife, en {area:17853}: justo al oeste de {object:3202} y al suroeste de la tablilla del arrecife.",

	-- Step 8: Krazek
	-- {area:35} Booty Bay
	["In {area:35}. Both factions take his two quests, from level 34."] = "En {area:35}. Ambas facciones aceptan sus dos misiones, a partir del nivel 34.",

	-- Step 9: Mazu'kon
	-- {zone:1412} Mulgore
	["Northern {zone:1412}. A long trip, but the idol only drops while his quest is in your log."] = "Al norte de {zone:1412}. Un viaje largo, pero el ídolo solo se obtiene mientras su misión está en tu registro.",

	-- Step 10: To the The Drowned City
	-- {area:16550} The Drowned City
	["To the {area:16550}"] = "Hacia {area:16550}",
	-- {area:17853} Sunken Hollow · {area:104} Vile Reef · {object:3202} Grom'gol (no name in this language: may be words)
	["A dungeon for five players of level 35 to 42. Meet your group at its entrance in {area:17853}, under the {area:104}: from the shore west of {object:3202}, swim due west. Water breathing helps."] = "Una mazmorra para cinco jugadores, de nivel 35 a 42. Reúnete con tu grupo en su entrada, en {area:17853}, bajo {area:104}: desde la orilla al oeste de {object:3202}, nada hacia el oeste. Respirar bajo el agua ayuda.",

	-- Step 11: First tablet
	["First tablet"] = "Primera tablilla",
	-- {npc:258905} Zul'Alai
	-- plural, as words: Makrura Snappers = {npc:258897} Makrura Snapper · Chasm Crawlers = {npc:258818} Chasm Crawler
	["Past the Makrura Snappers and Chasm Crawlers waits {npc:258905}, the first boss. The first tablet comes soon after him: click it for the rubbing."] = "Tras los Pinzas Makrura y los Reptadores del Abismo aguarda {npc:258905}, el primer jefe. La primera tablilla llega poco después: haz clic en ella para el calco.",

	-- Step 12: Var'Taka
	-- {npc:258924} Var'Taka · {npc:260042} Captain Dreadrise
	-- plural, as words: Brinescale Explorers = {npc:258799} Brinescale Explorer
	["Brinescale Explorers and Sorceresses guard the way to {npc:258924}, the second boss. The second tablet is close to him. Once he is dead, disrupt the barrier close to where he fell; you do it once more after {npc:260042}."] = "Los Exploradores Escama de Sal y las Hechiceras custodian el camino hacia {npc:258924}, el segundo jefe. La segunda tablilla está cerca de él. En cuanto haya muerto, altera la barrera cerca de donde cayó; lo haces una vez más después de {npc:260042}.",

	-- Step 13: Captain Dreadrise
	["The Saltseer pirates hold his ground: Murderers, Manhunters, Cultists and Coroners, and any of them can drop an artifact. The third tablet is among them, before you reach the captain. After he dies, disrupt the barrier a second time."] = "Los piratas Vistosalado dominan su territorio: Asesinos, Cazahombres, Cultistas y Forenses, y cualquiera de ellos puede soltar un artefacto. La tercera tablilla está entre ellos, antes de que llegues al capitán. Después de que muera, altera la barrera por segunda vez.",
	-- {npc:773} Krazek
	["One pass through the pirates may give fewer than ten: {npc:773} takes the quest whenever you have them."] = "Una pasada por los piratas puede dar menos de diez: {npc:773} acepta la misión cuando los tengas.",

	-- Step 14: Deathless Marrow
	-- {npc:260202} Deathless Marrow
	["Past the Champions of the Deep, {npc:260202} fights with his guardians. He drops the idol."] = "Tras los Campeones de las Profundidades, {npc:260202} lucha con sus guardianes. Suelta el ídolo.",

	-- Step 15: Min'loth the Serpent
	["The last boss. The fourth tablet is near him, and its rubbing still counts after he dies."] = "El último jefe. La cuarta tablilla está cerca de él, y su calco sigue contando después de muerto.",

	-- Step 17: Krazek
	["Once you have the ten artifacts."] = "Cuando tengas los diez artefactos.",

	-- Step 18: Master Gadrin
	-- {area:367} Sen'jin Village · {zone:1411} Durotar
	["{area:367}, in southern {zone:1411}."] = "{area:367}, en el sur de {zone:1411}.",
}
