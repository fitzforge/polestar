-- French (frFR): the guide forever/class/warlock/incubus-horde (forever/class/warlock/incubus-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Horde)"] = "Incube (Horde)",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Un second démon séducteur, le sayaad mâle, et un sac de fragments d'âme pour porter vos fragments.",

	-- Step 1: Devourer of Souls (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:5909} Cazul · {npc:5675} Carendin Halgar · {zone:1458} Undercity · {quest:1472} Devourer of Souls
	["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers offer the incubus, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one: this guide follows whichever {quest:1472} you took."] = "Au niveau 20, {npc:5875}, dans la {object:172960} sous la {object:172982}, vous envoie voir {npc:5909} à quelques pas. Deux maîtres proposent l'incube, {npc:5875} ici et {npc:5675} à {zone:1458}, et vous ne pouvez en prendre qu'un : ce guide suit la quête {quest:1472} que vous avez prise.",

	-- Step 2: Magar
	-- {npc:3363} Magar · {object:173018} Magar's Cloth Goods · {object:172960} Cleft of Shadow
	["{npc:3363} keeps {object:173018}, east of the {object:172960} along the main street. He asks you to look for his mate, Krilge."] = "{npc:3363} tient {object:173018}, à l'est de la {object:172960}, le long de la rue principale. Il vous demande de chercher sa compagne, Krilge.",

	-- Step 3: Fallen Sky Lake
	-- {area:422} Fallen Sky Lake · {zone:1440} Ashenvale · {area:431} Splintertree Post · {item:190232} Withered Scarf
	["{area:422} lies in southern {zone:1440}, south of {area:431}. The Shadethicket bog beasts around the lake drop the {item:190232}, about one in twenty."] = "Le {area:422} se trouve dans le sud d'{zone:1440}, au sud du {area:431}. Les bêtes des tourbières Sombretaillis autour du lac laissent tomber l'{item:190232}, environ une fois sur vingt.",

	-- Step 4: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade
	["Back to {npc:5875} in the {object:172960}. Take the scarf to the summoning circle in {npc:3216}'s tent nearby and defeat the incubus it calls."] = "Retournez voir {npc:5875} dans la {object:172960}. Apportez l'écharpe au cercle d'invocation dans la tente de {npc:3216}, tout près, et vainquez l'incube qu'elle appelle.",
	-- {npc:5875} Gan'rul Bloodeye
	["{npc:5875}: he binds the incubus to you"] = "{npc:5875} : il vous lie l'incube",

	-- Step 5: Devourer of Souls (Undercity)
	-- {object:1661} The Undercity · {npc:5675} Carendin Halgar · {quest:1472} Devourer of Souls · {npc:5875} Gan'rul Bloodeye · {object:36082} Magic Quarter · {npc:5693} Godrick Farsan
	["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "La version de {object:1661}, pour les démonistes qui ont pris la quête {quest:1472} de {npc:5675} au lieu de celle de {npc:5875}. Au niveau 20, {npc:5675}, dans le {object:36082}, vous envoie voir {npc:5693} dans le temple des Damnés, juste au nord.",

	-- Step 6: Avelina Lilly
	-- {npc:185333} Avelina Lilly · {area:279} Dalaran · {area:233} Ambermill · {zone:1421} Silverpine Forest
	["{npc:185333} works as a tailor for the {area:279} wizards at {area:233}, in eastern {zone:1421}. Take her heart."] = "{npc:185333} travaille comme couturière pour les sorciers de {area:279} à {area:233}, dans l'est de la {zone:1421}. Prenez son cœur.",

	-- Step 7: Isaac Pearson
	-- {npc:185334} Isaac Pearson · {area:392} Ratchet · {zone:1413} Barrens · {zone:1411} Durotar
	["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and ride or fly on to {area:392}."] = "{npc:185334} travaille à {area:392}, sur la côte des {zone:1413}. Prenez le zeppelin jusqu'à {zone:1411}, puis continuez à monture ou en vol jusqu'à {area:392}.",

	-- Step 8: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Back to {npc:5675} in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "Retournez voir {npc:5675} dans le {object:36082}. Placez les cœurs sur le cercle d'invocation en dessous de lui et vainquez l'incube qu'ils appellent.",
	-- {npc:5675} Carendin Halgar
	["{npc:5675}: he binds the incubus to you"] = "{npc:5675} : il vous lie l'incube",
}
