-- Spanish (Latin America) (esMX): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orb of Orahil"] = "Orbe de Orahil",
	["An off-hand orb or a staff for your late 30s, down the felhound's or the infernal's path, your pick."] = "Un orbe de mano izquierda o un bastón para el final de tus 30, por el camino del can manáfago o del infernal, a tu elección.",

	-- Step 1: Knowledge of the Orb of Orahil (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "A nivel 35, {npc:461}, en {object:2164} en {object:2101}, te envía con {npc:6266} en {area:392}.",

	-- Step 2: Knowledge of the Orb of Orahil (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "A nivel 35, {npc:5172}, en {zone:1455}, te envía con {npc:6266} en {area:392}.",

	-- Step 3: Knowledge of the Orb of Orahil (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "A nivel 35, {npc:3326}, en {object:172960}, te envía con {npc:6266} en {area:392}.",

	-- Step 4: Knowledge of the Orb of Orahil (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "A nivel 35, {npc:4563}, en {object:36082}, te envía con {npc:6266} en {area:392}. El zepelín de {zone:1420} vuela a {zone:1411}.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} y sus dos acólitos están en la torre de la colina sobre {area:392}, junto a {npc:6251}.",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "Elige un acólito",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "Elige un acólito: solo puedes aceptar una de sus misiones. El camino del can manáfago de {npc:6254} termina con el orbe o {item:15106}; el camino del infernal de {npc:6252}, con el orbe o {item:15105}. La guía sigue el que aceptes.",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254}: te da {item:12647}",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252}: te da {item:12646}",

	-- Step 7: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb · {item:12647} Felhas Ruby · {npc:4678} Mana Eater · {item:12646} Infus Emerald · {npc:4676} Lesser Infernal
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "Los demonios de {area:602}, en el sur de {zone:1443}, tienen todo lo que necesitas. Los Invocadores Filo Ardiente llevan {item:7291}. En el camino del can manáfago, usa {item:12647} en un {npc:4678}, un can manáfago, y mátalo para obtener su espíritu; en el camino del infernal, usa {item:12646} en un {npc:4676} y mátalo.",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}, de los Invocadores Filo Ardiente",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater
	["{item:12648}, from a {npc:4678}"] = "{item:12648}, de un {npc:4678}",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}, de un {npc:4676}",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "El espíritu del demonio",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6546} Tabetha
	["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "Regresa primero con el espíritu con {npc:6266}, en la torre sobre {area:392}: después sigue la purificación de {npc:6546}.",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {npc:6549} Demon of the Orb · {item:7291} Infernal Orb
	["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546} vive en su granja, en el oeste de {zone:1445}. Ella invoca a {npc:6549} desde {item:7291}; es de élite: se recomienda ir en grupo.",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "{item:15108}",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "Regresa con {npc:6266} a la torre sobre {area:392} con el orbe purificado. En el camino del can manáfago, espera mientras completa {item:15108} y luego vuelve a hablar con ella.",
	["Wait for the orb"] = "Espera el orbe",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "En el camino del infernal, espera mientras {npc:6266} completa {item:15107} y luego vuelve a hablar con ella.",
}
