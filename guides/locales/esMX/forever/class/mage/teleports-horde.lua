-- Spanish (Latin America) (esMX): the guide forever/class/mage/teleports-horde (forever/class/mage/teleports-horde.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Horde)"] = "Teletransportes y portales (Horda)",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "Los teletransportes a tus ciudades a nivel 20 y 30, y los portales de grupo a nivel 40 y 50, del instructor de portales de cada ciudad.",

	-- Step 1: Teleport: Orgrimmar
	-- {object:173161} Darkbriar Lodge (no name in this language: may be words) · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {npc:5958} Thuul · {spell:3567} Teleport: Orgrimmar · {item:17031} Rune of Teleportation
	["At 20 go to {object:173161} in {zone:1454}'s {object:172961}, where the mage trainers live. {npc:5958}, the portal trainer, stands on the upper floor and teaches {spell:3567} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor), so carry a few."] = "A nivel 20 ve a {object:173161}, en {object:172961} de {zone:1454}, donde viven los instructores de magos. {npc:5958}, el instructor de portales, está en el piso de arriba y enseña {spell:3567} por 20 de plata. Cada teletransporte gasta una {item:17031} (10 de plata en cualquier vendedor de componentes), así que lleva algunas.",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}, 10 p cada una",

	-- Step 2: Teleport: Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {object:36082} Magic Quarter · {spell:3563} Teleport: Undercity · {npc:4575} Hannah Akeley
	["Take the zeppelin from the tower outside {zone:1454}'s gate to {zone:1420} and walk into the {zone:1458}. {npc:2492}, the portal trainer, stands in the {object:36082} with the mage trainers: {spell:3563}, 20 silver. {npc:4575} beside him sells the runes."] = "Toma el zepelín desde la torre afuera de la puerta de {zone:1454} hasta {zone:1420} y entra caminando a {zone:1458}. {npc:2492}, el instructor de portales, está en {object:36082} con los instructores de magos: {spell:3563}, 20 de plata. {npc:4575}, a su lado, vende las runas.",

	-- Step 3: Teleport: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {zone:1454} Orgrimmar · {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {spell:3566} Teleport: Thunder Bluff
	["At 30. {zone:1456} is in {zone:1412}: fly there from {zone:1454} or the Crossroads. {npc:5957}, the portal trainer, stands with the mage trainers in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart. She teaches {spell:3566} for 80 silver."] = "A nivel 30. {zone:1456} está en {zone:1412}: vuela ahí desde {zone:1454} o el Cruce. {npc:5957}, la instructora de portales, está con los instructores de magos en {area:2197}, la cueva debajo de {area:1640}: baja por dentro, la flecha no distingue los pisos. Enseña {spell:3566} por 80 de plata.",

	-- Step 4: Portals to Orgrimmar and the Undercity
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Portals to {zone:1454} and the {zone:1458}"] = "Portales a {zone:1454} y {zone:1458}",
	-- {item:17032} Rune of Portals · {npc:5958} Thuul · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {spell:11417} Portal: Orgrimmar · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {spell:11418} Portal: Undercity
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:5958} in {object:173161} has {spell:11417}; teleport to the {zone:1458} for {npc:2492}'s {spell:11418}."] = "A nivel 40, los instructores de portales enseñan los portales: una entrada que todo tu grupo puede cruzar, por 1 de oro 50 de plata cada uno. Cada portal gasta una {item:17032} (20 de plata en cualquier vendedor de componentes). {npc:5958}, en {object:173161}, tiene {spell:11417}; teletranspórtate a {zone:1458} para {spell:11418} de {npc:2492}.",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}, 20 p cada una",

	-- Step 5: Portal: Thunder Bluff
	-- {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {spell:11420} Portal: Thunder Bluff · {spell:3566} Teleport: Thunder Bluff
	["At 50 {npc:5957}, down in the {area:2197} under {area:1640} in {zone:1456}, teaches the last one, {spell:11420}, for 3 gold 20 silver. Use your {spell:3566} to get there."] = "A nivel 50, {npc:5957}, abajo en {area:2197} debajo de {area:1640} en {zone:1456}, enseña el último, {spell:11420}, por 3 de oro 20 de plata. Usa tu {spell:3566} para llegar.",
}
