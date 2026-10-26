-- German (deDE): the guide forever/class/warlock/incubus-horde (forever/class/warlock/incubus-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Horde)"] = "Inkubus (Horde)",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Ein zweiter Verführungsdämon, der männliche Sayaad, und eine Seelensplittertasche für deine Splitter.",

	-- Step 1: Devourer of Souls (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:5909} Cazul · {npc:5675} Carendin Halgar · {zone:1458} Undercity · {quest:1472} Devourer of Souls
	["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers offer the incubus, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one: this guide follows whichever {quest:1472} you took."] = "Mit 20 schickt dich {npc:5875} in {object:172960} unter {object:172982} zu {npc:5909} ein paar Schritte weiter. Zwei Lehrer bieten den Inkubus an, {npc:5875} hier und {npc:5675} in {zone:1458}, und du kannst nur einen nehmen: Dieser Guide folgt der Quest {quest:1472}, die du angenommen hast.",

	-- Step 2: Magar
	-- {npc:3363} Magar · {object:173018} Magar's Cloth Goods · {object:172960} Cleft of Shadow
	["{npc:3363} keeps {object:173018}, east of the {object:172960} along the main street. He asks you to look for his mate, Krilge."] = "{npc:3363} führt {object:173018}, östlich von {object:172960} an der Hauptstraße. Er bittet dich, nach seiner Gefährtin Krilge zu suchen.",

	-- Step 3: Fallen Sky Lake
	-- {area:422} Fallen Sky Lake · {zone:1440} Ashenvale · {area:431} Splintertree Post · {item:190232} Withered Scarf
	["{area:422} lies in southern {zone:1440}, south of {area:431}. The Shadethicket bog beasts around the lake drop the {item:190232}, about one in twenty."] = "{area:422} liegt im Süden von {zone:1440}, südlich von {area:431}. Die Sumpfbestien des Schattendickichts rund um den See lassen {item:190232} fallen, etwa eine von zwanzig.",

	-- Step 4: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade
	["Back to {npc:5875} in the {object:172960}. Take the scarf to the summoning circle in {npc:3216}'s tent nearby and defeat the incubus it calls."] = "Zurück zu {npc:5875} in {object:172960}. Bring den Schal zum Beschwörungskreis im Zelt von {npc:3216} in der Nähe und besiege den Inkubus, den er ruft.",
	-- {npc:5875} Gan'rul Bloodeye
	["{npc:5875}: he binds the incubus to you"] = "{npc:5875}: Er bindet den Inkubus an dich",

	-- Step 5: Devourer of Souls (Undercity)
	-- {object:1661} The Undercity · {npc:5675} Carendin Halgar · {quest:1472} Devourer of Souls · {npc:5875} Gan'rul Bloodeye · {object:36082} Magic Quarter · {npc:5693} Godrick Farsan
	["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "Die Version von {object:1661}, für Hexenmeister, die {quest:1472} bei {npc:5675} statt bei {npc:5875} angenommen haben. Mit 20 schickt dich {npc:5675} in {object:36082} zu {npc:5693} im Tempel der Verdammten, direkt nördlich von ihm.",

	-- Step 6: Avelina Lilly
	-- {npc:185333} Avelina Lilly · {area:279} Dalaran · {area:233} Ambermill · {zone:1421} Silverpine Forest
	["{npc:185333} works as a tailor for the {area:279} wizards at {area:233}, in eastern {zone:1421}. Take her heart."] = "{npc:185333} arbeitet als Schneiderin für die Magier von {area:279} in {area:233}, im Osten von {zone:1421}. Nimm ihr Herz.",

	-- Step 7: Isaac Pearson
	-- {npc:185334} Isaac Pearson · {area:392} Ratchet · {zone:1413} Barrens · {zone:1411} Durotar
	["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and walk or fly on to {area:392}."] = "{npc:185334} arbeitet in {area:392} an der Küste von {zone:1413}. Nimm den Zeppelin nach {zone:1411} und geh oder flieg weiter nach {area:392}.",

	-- Step 8: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Back to {npc:5675} in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "Zurück zu {npc:5675} in {object:36082}. Leg die Herzen am Beschwörungskreis unter ihm ab und besiege den Inkubus, den sie rufen.",
	-- {npc:5675} Carendin Halgar
	["{npc:5675}: he binds the incubus to you"] = "{npc:5675}: Er bindet den Inkubus an dich",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and ride or fly on to {area:392}."] = "{npc:185334} arbeitet in {area:392}, an der Küste von {zone:1413}. Nimm den Zeppelin nach {zone:1411} und reite oder flieg weiter nach {area:392}.",
}
