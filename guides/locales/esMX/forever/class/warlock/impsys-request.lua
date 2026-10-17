-- Spanish (Latin America) (esMX): the guide forever/class/warlock/impsys-request (forever/class/warlock/impsys-request.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14470} Impsy
	["A staff, off-hand or robe for your 50s; {npc:14470}'s own errand, not a step of the Dreadsteed chain."] = "Un bastón, una pieza de mano izquierda o una toga para los 50; un encargo propio de {npc:14470}, no un paso de la cadena del Corcelorror.",

	-- Step 1: An Imp's Request (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448}."] = "A nivel 50, {npc:461} en {object:2164}, en {object:2101}, te manda con {npc:14470} en {zone:1448}.",

	-- Step 2: An Imp's Request (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448}."] = "A nivel 50, {npc:5172} en {zone:1455} te manda con {npc:14470} en {zone:1448}.",

	-- Step 3: An Imp's Request (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448}."] = "A nivel 50, {npc:3326} en {object:172960} te manda con {npc:14470} en {zone:1448}.",

	-- Step 4: An Imp's Request (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:14470} Impsy · {zone:1448} Felwood
	["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448}."] = "A nivel 50, {npc:4563} en {object:36082} te manda con {npc:14470} en {zone:1448}.",

	-- Step 5: Felcloth
	-- {npc:14470} Impsy · {item:14256} Felcloth · {area:1763} Jaedenar
	["{npc:14470} wants one {item:14256}: the Jadefire satyrs and the demons of {area:1763} drop it."] = "{npc:14470} quiere una {item:14256}: la sueltan los sátiros Fuego de Jade y los demonios de {area:1763}.",

	-- Step 6: Impsy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {zone:1448} Felwood · {area:1763} Jaedenar · {item:18762} Shard of the Green Flame
	["{npc:14470} waits beside {npc:14469} in central {zone:1448}, just east of {area:1763}. This chain is {npc:14470}'s own and is not part of the Dreadsteed chain; Niby and {npc:14470} also give the {item:18762} chain here."] = "{npc:14470} espera junto a {npc:14469} en el centro de {zone:1448}, justo al este de {area:1763}. Esta cadena es propia de {npc:14470} y no forma parte de la cadena del Corcelorror; Niby y {npc:14470} también dan aquí la cadena del {item:18762}.",

	-- Step 7: Rotting Wood and Bloodvenom
	-- {item:20613} Rotting Wood
	["{item:20613} and Bloodvenom"] = "{item:20613} y veneno de sangre",
	-- {zone:1448} Felwood · {item:20613} Rotting Wood · {area:1763} Jaedenar · {item:20614} Bloodvenom Essence
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Irontree treants in northern {zone:1448} drop the {item:20613}; the Tainted Oozes around {area:1763} the {item:20614}."] = "Los antárboles Troncoferro del norte de {zone:1448} sueltan la {item:20613}; los Mocos corruptos alrededor de {area:1763}, la {item:20614}.",

	-- Step 8: Impsy again
	-- {npc:14470} Impsy
	["{npc:14470} again"] = "{npc:14470} de nuevo",

	-- Step 9: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears
	["The six troll guardians of the {area:1417}, a level 50 dungeon, each drop a Voodoo Feather: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance."] = "Los seis guardianes trol de {area:1417}, un calabozo de nivel 50, sueltan cada uno una pluma vudú: lleva un grupo de cinco. El templo está en medio de {area:74}; nada hacia abajo para llegar a la entrada.",
}
