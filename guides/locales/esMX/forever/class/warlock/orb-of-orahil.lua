-- Spanish (Latin America) (esMX): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:6266} and her two acolytes stand in {npc:6251}'s tower on the hill above {area:392}."] = "{npc:6266} y sus dos acólitos están en la torre de {npc:6251}, en la colina sobre {area:392}.",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "Elige un acólito",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, the shadow versions; {npc:6252}'s infernal path with the Orb or {item:15105}, much the same items on the fire side. Most warlocks lean on shadow, but compare the four in their tooltips first. The guide follows the one you take. Keep the ruby or the emerald: it is handed back."] = "Elige un acólito: solo puedes tomar una de sus misiones. El camino del can vil de {npc:6254} termina con el Orbe o {item:15106}, las versiones de sombras; el camino del infernal de {npc:6252}, con el Orbe o {item:15105}, casi los mismos objetos del lado del fuego. La mayoría de los brujos se apoya en las sombras, pero compara primero los cuatro en sus descripciones. La guía sigue el que tomes. Guarda el rubí o la esmeralda: se devuelve.",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254}: te da {item:12647}",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252}: te da {item:12646}",

	-- Step 7: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:1120} Drain Soul
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter · Ley Hunters = {npc:4685} Ley Hunter · Lesser Infernals = {npc:4676} Lesser Infernal
	["{area:602} fills south-central {zone:1443}, east of {area:2408}. The Burning Blade Summoners (level 38-39, warlocks with imps) carry the {item:7291} every time. For the spirit, bring your demon to low health with your damage over time, then channel the ruby or the emerald on it and keep channelling while it dies, as with {spell:1120}: the gem does no damage of its own. The ruby works on the coven's felhounds: the two Mana Eaters (37-38) in the north, and the Mage Hunters (38) and Ley Hunters (39) further south. The emerald works on the Lesser Infernals (36-37, sixteen of them, fire-resistant)."] = "{area:602} ocupa el centro-sur de {zone:1443}, al este de {area:2408}. Los invocadores del Filo Ardiente (nivel 38-39, brujos con diablillos) llevan {item:7291} siempre. Para el espíritu, baja la salud de tu demonio con tu daño en el tiempo, luego canaliza el rubí o la esmeralda sobre él y sigue canalizando mientras muere, como con {spell:1120}: la gema no hace daño por sí misma. El rubí sirve con los canes viles del aquelarre: los dos devoradores de maná (37-38) del norte, y los cazamagos (38) y cazadores de líneas ley (39) más al sur. La esmeralda sirve con los infernales menores (36-37, son dieciséis, resistentes al fuego).",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}, de los Invocadores Filo Ardiente",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater · {npc:4681} Mage Hunter · {npc:4685} Ley Hunter
	["{item:12648}, from a {npc:4678}, {npc:4681} or {npc:4685}"] = "{item:12648}, de un {npc:4678}, {npc:4681} o {npc:4685}",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}, de un {npc:4676}",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "El espíritu del demonio",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet
	["Back to {npc:6266} in the tower above {area:392} with the spirit and the gem first: her orb follows from it."] = "De vuelta con {npc:6266}, en la torre sobre {area:392}, primero con el espíritu y la gema: su orbe viene después.",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {zone:1413} Barrens · {npc:6549} Demon of the Orb · {spell:710} Banish
	["{npc:6546} lives at her farm in the middle of {zone:1445}, south of the road from the {zone:1413} and south-west of Theramore; a spirit healer stands beside it. Deadmire, a level 45 crocolisk, patrols the creeks just north-east. Hand in the orb now; Cleansing waits for level 38. Before you accept it, clear the spiders and crocolisks around her paddock. Accepting starts a 3-minute timer: she walks to the paddock and lets the {npc:6549} out. It is elite (level 40): grouping up is encouraged; a warlock of about 40 can solo it with Fear or {spell:710} and damage over time, a level 38 one brings a friend. The timer keeps running after the kill, so hand in at once. If time runs out, abandon the quest and take it from {npc:6546} again."] = "{npc:6546} vive en su granja, en el centro de {zone:1445}, al sur del camino que viene de {zone:1413} y al suroeste de Theramore; a su lado hay un Ángel de la Resurrección. Lodomuerto, un crocolisco de nivel 45, patrulla los arroyos justo al noreste. Entrega ahora el orbe; “La purificación” espera al nivel 38. Antes de tomarla, limpia las arañas y los crocoliscos de alrededor de su corral. Al tomarla empieza un temporizador de 3 minutos: ella va al corral y suelta al {npc:6549}. Es élite (nivel 40): se recomienda ir en grupo; un brujo de nivel 40 aproximadamente puede hacerlo solo con Miedo o {spell:710} y daño periódico; uno de nivel 38 debería llevar a un amigo. El temporizador sigue corriendo después de la muerte, así que entrega de inmediato. Si se acaba el tiempo, abandona la misión y vuelve a tomarla de {npc:6546}.",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "{item:15108}",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, accept her last quest and wait beside her while she completes the {item:15108} (do not attack her: the quest log calls it a kill), then speak to her again and pick the off-hand orb or the staff."] = "De vuelta con {npc:6266}, en la torre sobre {area:392}, con el orbe purificado. En el camino del can vil, acepta su última misión y espera a su lado mientras completa {item:15108} (no la ataques: el registro de misiones lo llama matar), luego vuelve a hablarle y elige el orbe de mano izquierda o el bastón.",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she makes the orb"] = "Espera junto a {npc:6266} mientras hace el orbe",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, accept her last quest and wait beside {npc:6266} while she completes the {item:15107}, then speak to her again and pick the off-hand orb or the staff."] = "En el camino del infernal, acepta su última misión y espera junto a {npc:6266} mientras completa {item:15107}, luego vuelve a hablarle y elige el orbe de mano izquierda o el bastón.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "Regresa con {npc:6266} a la torre sobre {area:392} con el orbe purificado. En el camino del can manáfago, espera mientras completa {item:15108} y luego vuelve a hablar con ella.",
	-- ["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "Regresa primero con el espíritu con {npc:6266}, en la torre sobre {area:392}: después sigue la purificación de {npc:6546}.",
	-- ["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "En el camino del infernal, espera mientras {npc:6266} completa {item:15107} y luego vuelve a hablar con ella.",
	-- ["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "Elige un acólito: solo puedes aceptar una de sus misiones. El camino del can manáfago de {npc:6254} termina con el orbe o {item:15106}; el camino del infernal de {npc:6252}, con el orbe o {item:15105}. La guía sigue el que aceptes.",
	-- ["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "Los demonios de {area:602}, en el sur de {zone:1443}, tienen todo lo que necesitas. Los Invocadores Filo Ardiente llevan {item:7291}. En el camino del can manáfago, usa {item:12647} en un {npc:4678}, un can manáfago, y mátalo para obtener su espíritu; en el camino del infernal, usa {item:12646} en un {npc:4676} y mátalo.",
	-- ["Wait for the orb"] = "Espera el orbe",
	-- ["{item:12648}, from a {npc:4678}"] = "{item:12648}, de un {npc:4678}",
	-- ["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} y sus dos acólitos están en la torre de la colina sobre {area:392}, junto a {npc:6251}.",
	-- ["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546} vive en su granja, en el oeste de {zone:1445}. Ella invoca a {npc:6549} desde {item:7291}; es de élite: se recomienda ir en grupo.",
}
