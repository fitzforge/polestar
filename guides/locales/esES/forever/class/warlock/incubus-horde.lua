-- Spanish (Spain) (esES): the guide forever/class/warlock/incubus-horde (forever/class/warlock/incubus-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Horde)"] = "Íncubo (Horda)",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Un segundo demonio seductor, el sayaad masculino, y una bolsa para tus fragmentos de alma.",

	-- Step 1: Devourer of Souls (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:5909} Cazul · {npc:5675} Carendin Halgar · {zone:1458} Undercity · {quest:1472} Devourer of Souls
	["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers offer the incubus, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one: this guide follows whichever {quest:1472} you took."] = "A nivel 20, {npc:5875}, en la {object:172960} bajo el {object:172982}, te envía con {npc:5909}, a pocos pasos. Dos instructores ofrecen el íncubo, {npc:5875} aquí y {npc:5675} en {zone:1458}, y solo puedes aceptar uno: esta guía sigue la {quest:1472} que hayas aceptado.",

	-- Step 2: Magar
	-- {npc:3363} Magar · {object:173018} Magar's Cloth Goods · {object:172960} Cleft of Shadow
	["{npc:3363} keeps {object:173018}, east of the {object:172960} along the main street. He asks you to look for his mate, Krilge."] = "{npc:3363} lleva {object:173018}, al este de la {object:172960} por la calle principal. Te pide que busques a su pareja, Krilge.",

	-- Step 3: Fallen Sky Lake
	-- {area:422} Fallen Sky Lake · {zone:1440} Ashenvale · {area:431} Splintertree Post · {item:190232} Withered Scarf
	["{area:422} lies in southern {zone:1440}, south of {area:431}. The Shadethicket bog beasts around the lake drop the {item:190232}, about one in twenty."] = "{area:422} está en el sur de {zone:1440}, al sur del {area:431}. Las bestias de pantano Sombramatorral alrededor del lago sueltan {item:190232}, una de cada veinte aprox.",

	-- Step 4: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade
	["Back to {npc:5875} in the {object:172960}. Take the scarf to the summoning circle in {npc:3216}'s tent nearby and defeat the incubus it calls."] = "Vuelve con {npc:5875} en la {object:172960}. Lleva el pañuelo al círculo de invocación de la tienda de {npc:3216}, cerca, y derrota al íncubo que aparece.",
	-- {npc:5875} Gan'rul Bloodeye
	["{npc:5875}: he binds the incubus to you"] = "{npc:5875}: vincula el íncubo a ti",

	-- Step 5: Devourer of Souls (Undercity)
	-- {object:1661} The Undercity · {npc:5675} Carendin Halgar · {quest:1472} Devourer of Souls · {npc:5875} Gan'rul Bloodeye · {object:36082} Magic Quarter · {npc:5693} Godrick Farsan
	["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "La versión de {object:1661}, para brujos que aceptaron {quest:1472} de {npc:5675} en lugar de la de {npc:5875}. A nivel 20, {npc:5675}, en el {object:36082}, te envía con {npc:5693}, en el templo justo al norte de él.",

	-- Step 6: Avelina Lilly
	-- {npc:185333} Avelina Lilly · {area:279} Dalaran · {area:233} Ambermill · {zone:1421} Silverpine Forest
	["{npc:185333} works as a tailor for the {area:279} wizards at {area:233}, in eastern {zone:1421}. Take her heart."] = "{npc:185333} trabaja de sastre para los magos de {area:279} en {area:233}, en el este del {zone:1421}. Consigue su corazón.",

	-- Step 7: Isaac Pearson
	-- {npc:185334} Isaac Pearson · {area:392} Ratchet · {zone:1413} Barrens · {zone:1411} Durotar
	["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and ride or fly on to {area:392}."] = "{npc:185334} trabaja en {area:392}, en la costa de {zone:1413}. Toma el zepelín a {zone:1411} y sigue a caballo o volando hasta {area:392}.",

	-- Step 8: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Back to {npc:5675} in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "Vuelve con {npc:5675} en el {object:36082}. Pon los corazones en el círculo de invocación bajo él y derrota al íncubo que aparece.",
	-- {npc:5675} Carendin Halgar
	["{npc:5675}: he binds the incubus to you"] = "{npc:5675}: vincula el íncubo a ti",
}
