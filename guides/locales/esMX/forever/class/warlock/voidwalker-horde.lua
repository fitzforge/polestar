-- Spanish (Latin America) (esMX): the guide forever/class/warlock/voidwalker-horde (forever/class/warlock/voidwalker-horde.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Horde)"] = "Abisario (Horda)",
	["Your tank demon at 10: the voidwalker, after a stolen book and a fight at a summoning circle."] = "Tu demonio tanque a nivel 10: el abisario, después de un libro robado y una pelea en un círculo de invocación.",

	-- Step 1: Gan'rul's Summons (Orcs and Trolls)
	-- {quest:1506} Gan'rul's Summons
	["{quest:1506} (Orcs and Trolls)"] = "{quest:1506} (orcos y trols)",
	-- {npc:3294} Ophek · {npc:5875} Gan'rul Bloodeye · {area:362} Razor Hill · {npc:3172} Dhugru Gorelust · {object:172960} Cleft of Shadow · {zone:1454} Orgrimmar · {object:172982} Valley of Strength · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:5724} Ageron Kargal · {area:159} Brill
	["At 10 {npc:3294} sends you to {npc:5875}. He stands outside at the back of {area:362}'s barracks, the big building on the east side of town (not the inn), a few steps from {npc:3172}, the warlock trainer. {npc:5875} stands with the senior warlocks in the {object:172960}, the cavern under {zone:1454}'s {object:172982}. An Orc or Troll leveling in {zone:1420} can take the {zone:1458} version from {npc:5724} in {area:159} instead (the {zone:1458} steps below): you can do only one of the two."] = "A nivel 10, {npc:3294} te manda con {npc:5875}. Está afuera, en la parte de atrás del cuartel de {area:362}, el edificio grande del lado este del pueblo (no la posada), a pocos pasos de {npc:3172}, el instructor de brujos. {npc:5875} está con los brujos veteranos en {object:172960}, la caverna debajo de {object:172982} de {zone:1454}. Un orco o trol que sube de nivel en {zone:1420} puede tomar en su lugar la versión de {zone:1458} con {npc:5724} en {area:159} (los pasos de {zone:1458}, más abajo): solo puedes hacer una de las dos.",

	-- Step 2: Skull Rock
	-- {area:817} Skull Rock · {zone:1454} Orgrimmar · {object:58595} Burning Blade Stash · {npc:3204} Gazz'uz
	-- plural, as words: Burning Blade Apprentices = {npc:3198} Burning Blade Apprentice
	["{area:817} is the cave in the cliffs just east of {zone:1454}'s gate. Inside, take the right-hand ramp up and follow it to the top: the {object:58595} sits on that upper ledge, which cannot be reached from the lower floor. The cave is packed with Burning Blade Apprentices and Fanatics (level 9-11, many with voidwalkers) that respawn quickly, and {npc:3204}, a level 14 Burning Blade warlock, stands near the stash. Old notes call him elite; Forever's data lists him as normal. At 10 it is hard alone: pull one pack at a time and Fear the extra, wait for 11, or go with a friend. The stash always holds the tablet."] = "{area:817} es la cueva en los acantilados justo al este de la puerta de {zone:1454}. Adentro, toma la rampa de la derecha y síguela hasta arriba: {object:58595} está en esa cornisa superior, a la que no se llega desde el piso de abajo. La cueva está llena de aprendices y fanáticos del Filo Ardiente (nivel 9-11, muchos con abisarios) que reaparecen rápido, y {npc:3204}, un brujo del Filo Ardiente de nivel 14, está cerca del alijo. Notas viejas dicen que es élite; los datos de Forever lo listan como normal. A nivel 10 es difícil solo: atrae un grupo a la vez y aterra al que sobre, espera al nivel 11 o ve con un amigo. El alijo siempre tiene la tablilla.",
	-- {item:6535} Tablet of Verga · {object:58595} Burning Blade Stash
	["{item:6535}, in the {object:58595}"] = "{item:6535}, en {object:58595}",

	-- Step 3: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {item:7464} Glyphs of Summoning · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5875}. He hands you the {item:7464}: take them across the {object:172960} to {npc:3216}'s tent, stand on the purple circle on its floor and use them. The voidwalker (level 10, not elite) hits hard at 30% health and leaves after three minutes, so start at once: {spell:14868}, Corruption and {spell:348}, send your imp in, and Fear it when you need a breather. If it beats you or leaves, the glyphs are not used up: use them again on the circle. Keep the glyphs: {npc:5875} takes them back."] = "De vuelta con {npc:5875}. Te da {item:7464}: llévalos cruzando {object:172960} hasta la tienda de {npc:3216}, párate en el círculo morado del suelo y úsalos. El abisario (nivel 10, no élite) pega fuerte al 30 % de salud y se va a los tres minutos, así que empieza enseguida: {spell:14868}, Corrupción y {spell:348}, manda a tu diablillo y aterralo cuando necesites un respiro. Si te gana o se va, los glifos no se gastan: úsalos otra vez sobre el círculo. Guarda los glifos: {npc:5875} los recupera.",
	-- {item:7464} Glyphs of Summoning
	["{item:7464}, on the circle in Neeru's tent"] = "{item:7464}, sobre el círculo de la tienda de Neeru",

	-- Step 4: Halgar's Summons (Undercity)
	-- {npc:5724} Ageron Kargal · {area:2119} Gallows' End Tavern · {area:159} Brill · {npc:5675} Carendin Halgar · {zone:1420} Tirisfal Glades · {npc:5875} Gan'rul Bloodeye · {zone:1458} Undercity · {object:36082} Magic Quarter
	["At 10 {npc:5724}, upstairs in the {area:2119} in {area:159}, sends you to {npc:5675}: the version for the Undead, and for Orcs and Trolls who level in {zone:1420} instead of taking {npc:5875}'s. {npc:5675} stands in the {zone:1458}'s {object:36082}, by the Temple of the Damned."] = "A nivel 10, {npc:5724}, en el piso de arriba de {area:2119} en {area:159}, te manda con {npc:5675}: la versión para los no-muertos, y para los orcos y trols que suben de nivel en {zone:1420} en vez de tomar la de {npc:5875}. {npc:5675} está en {object:36082} de {zone:1458}, junto al Templo de los Malditos.",
	-- {npc:5724} Ageron Kargal · {area:159} Brill
	["{npc:5724}, upstairs in the {area:159} inn"] = "{npc:5724}, en el piso de arriba de la posada de {area:159}",

	-- Step 5: Perrine's Chest
	-- {zone:1458} Undercity · {area:154} Deathknell · {npc:1662} Captain Perrine · {npc:1537} Scarlet Zealot
	["The Scarlet tower stands in the fields west of the {zone:1458}'s ruins (not the tower near {area:154}). The grimoire is in the small chest on the ground floor, under the stairs; ignore the chest upstairs. {npc:1662} (level 9) and a {npc:1537} guard it: kill them, or Fear the zealot while you deal with Perrine. Scarlet Missionaries and Zealots (level 7-9) walk the fields around the tower. The chest is back three seconds after anyone opens it."] = "La torre Escarlata está en los campos al oeste de las ruinas de {zone:1458} (no la torre cerca de {area:154}). El grimorio está en el cofrecito de la planta baja, debajo de la escalera; ignora el cofre de arriba. {npc:1662} (nivel 9) y un {npc:1537} lo custodian: mátalos, o aterra al fanático mientras te encargas de Perrine. Los misioneros y fanáticos Escarlata (nivel 7-9) recorren los campos alrededor de la torre. El cofre vuelve tres segundos después de que alguien lo abre.",
	-- {item:6285} Egalin's Grimoire · {object:37098} Perrine's Chest
	["{item:6285}, in {object:37098}"] = "{item:6285}, en {object:37098}",

	-- Step 6: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {item:6284} Runes of Summoning · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5675}. He hands you the {item:6284}: go down the stairs from him to the summoning circle and use them while standing on it. Fight the voidwalker (level 10, not elite) on the circle: if it wanders off, the city guards may kill it and the kill does not count. {spell:14868}, Corruption and {spell:348} with your imp tanking bring it down; it hits harder below 30%. If you lose, use the runes again. Keep the runes: {npc:5675} takes them back."] = "De vuelta con {npc:5675}. Te da {item:6284}: baja la escalera desde donde está él hasta el círculo de invocación y úsalas parado en él. Pelea con el abisario (nivel 10, no élite) en el círculo: si se aleja, los guardias de la ciudad pueden matarlo y esa muerte no cuenta. {spell:14868}, Corrupción y {spell:348} con tu diablillo como tanque lo bajan; pega más fuerte por debajo del 30 %. Si pierdes, usa las runas otra vez. Guarda las runas: {npc:5675} las recupera.",
	-- {item:6284} Runes of Summoning · {npc:5675} Carendin Halgar
	["{item:6284}, on the circle below {npc:5675}"] = "{item:6284}, sobre el círculo debajo de {npc:5675}",
}
