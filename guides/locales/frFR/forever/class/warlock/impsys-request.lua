-- French (frFR): the guide forever/class/warlock/impsys-request (forever/class/warlock/impsys-request.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14470} Impsy
	["A staff, off-hand or robe for your 50s; {npc:14470}'s own errand, not a step of the Dreadsteed chain."] = "Un bâton, une main gauche ou une robe pour vos niveaux 50 ; une mission propre à {npc:14470}, pas une étape de la chaîne du Destrier de l'effroi.",

	-- Step 1: An Imp's Request (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448}."] = "Au niveau 50, {npc:461}, à {object:2164}, dans {object:2101}, vous envoie voir {npc:14470} en {zone:1448}.",

	-- Step 2: An Imp's Request (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448}."] = "Au niveau 50, {npc:5172}, à {zone:1455}, vous envoie voir {npc:14470} en {zone:1448}.",

	-- Step 3: An Imp's Request (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448}."] = "Au niveau 50, {npc:3326}, à {object:172960}, vous envoie voir {npc:14470} en {zone:1448}.",

	-- Step 4: An Imp's Request (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448}."] = "Au niveau 50, {npc:4563}, à {object:36082}, vous envoie voir {npc:14470} en {zone:1448}.",

	-- Step 5: Felcloth
	-- {npc:14470} Impsy · {item:14256} Felcloth · {area:1763} Jaedenar
	["{npc:14470} wants one {item:14256}: the Jadefire satyrs and the demons of {area:1763} drop it."] = "{npc:14470} veut une {item:14256} : les satyres Jadefeu et les démons de {area:1763} en laissent.",

	-- Step 6: Impsy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {zone:1448} Felwood · {area:1763} Jaedenar · {item:18762} Shard of the Green Flame
	["{npc:14470} waits beside {npc:14469} in central {zone:1448}, just east of {area:1763}. This chain is {npc:14470}'s own and is not part of the Dreadsteed chain; Niby and {npc:14470} also give the {item:18762} chain here."] = "{npc:14470} attend à côté de {npc:14469}, au centre de {zone:1448}, juste à l'est de {area:1763}. Cette chaîne est propre à {npc:14470} et ne fait pas partie de la chaîne du Destrier de l'effroi ; Niby le Tout-puissant et {npc:14470} donnent aussi ici la chaîne de {item:18762}.",

	-- Step 7: Rotting Wood and Bloodvenom
	-- {item:20613} Rotting Wood
	["{item:20613} and Bloodvenom"] = "{item:20613} et Vénéneuse",
	-- {zone:1448} Felwood · {item:20613} Rotting Wood · {area:1763} Jaedenar · {item:20614} Bloodvenom Essence
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Irontree treants in northern {zone:1448} drop the {item:20613}; the Tainted Oozes around {area:1763} the {item:20614}."] = "Les tréants Arbrefer du nord de {zone:1448} laissent {item:20613} ; les Limons corrompus autour de {area:1763}, {item:20614}.",

	-- Step 8: Impsy again
	-- {npc:14470} Impsy
	["{npc:14470} again"] = "De nouveau {npc:14470}",

	-- Step 9: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears
	["The six troll guardians of the {area:1417}, a level 50 dungeon, each drop a Voodoo Feather: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance."] = "Les six gardiens trolls de {area:1417}, un donjon de niveau 50, laissent chacun une plume vaudou : venez à cinq. Le temple se dresse au milieu de {area:74} ; plongez pour en atteindre l'entrée.",
}
