-- Spanish (Latin America) (esMX): the guide forever/class/warlock/voidwalker-alliance (forever/class/warlock/voidwalker-alliance.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Alliance)"] = "Abisario (Alianza)",
	-- {npc:6122} Gakin the Darkbinder
	["Your tank demon at 10: the voidwalker, after a dark sorceress's choker and a fight in {npc:6122}'s crypt."] = "Tu demonio tanque a nivel 10: el abisario, después del collar de una hechicera oscura y una pelea en la cripta de {npc:6122}.",

	-- Step 1: Gakin's Summons (Humans)
	-- {quest:1685} Gakin's Summons
	["{quest:1685} (Humans)"] = "{quest:1685} (humanos)",
	-- {npc:6121} Remen Marcot · {area:87} Goldshire · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["At 10 {npc:6121}, in the cellar of the Lion's Pride Inn in {area:87} (the stairs down are in the back room past the butcher's table), sends you to {npc:6122} in {zone:1453}."] = "A nivel 10, {npc:6121}, en el sótano de la Posada Orgullo de León en {area:87} (la escalera de bajada está en la sala del fondo, pasando la mesa del carnicero), te manda con {npc:6122} en {zone:1453}.",
	-- {npc:6121} Remen Marcot
	["{npc:6121}, Lion's Pride Inn cellar"] = "{npc:6121}, sótano de la Posada Orgullo de León",

	-- Step 2: The Slaughtered Lamb (Gnomes)
	-- {quest:1715} The Slaughtered Lamb
	["{quest:1715} (Gnomes)"] = "{quest:1715} (gnomos)",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 10 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257} from {object:171524}. If {npc:6120} does not offer it, go to {npc:6122} anyway: he still gives you the next quest."] = "A nivel 10, {npc:6120}, el instructor de brujos en {object:32383} de {zone:1455}, te manda con {npc:6122} en {zone:1453}. Toma {area:2257} desde {object:171524}. Si {npc:6120} no te la ofrece, ve con {npc:6122} igual: te da la siguiente misión de todos modos.",

	-- Step 3: Gakin the Darkbinder
	-- {quest:1715} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{quest:1715} is the tavern in the {object:2101}; {npc:6122} is in its cellar, down the stairs inside."] = "{quest:1715} es la taberna de {object:2101}; {npc:6122} está en su sótano, bajando la escalera de adentro.",

	-- Step 4: Surena Caledon
	-- {npc:881} Surena Caledon · {area:62} Brackwell Pumpkin Patch · {npc:473} Morgan the Collector
	["{npc:881} (level 9) is inside the farmhouse at the {area:62}, south-east Elwynn near the Redridge road. {npc:473} (level 10) and a warrior stand with her and join the fight; Morgan gouges and goes for your imp, so keep him Feared. Put your damage over time on {npc:881} first, Fear the others, and loot her choker before you finish them: it stays yours even if you die after. She throws fireballs from range and is back three minutes after she dies. Have the quest before you kill her, or the choker does not drop."] = "{npc:881} (nivel 9) está dentro de la granja de {area:62}, en el sureste de Elwynn, cerca del camino a Crestagrana. {npc:473} (nivel 10) y un guerrero están con ella y se unen a la pelea; Morgan da golpes bajos y va por tu diablillo, así que mantenlo aterrado. Pon primero tu daño en el tiempo sobre {npc:881}, aterra a los otros y saquea su collar antes de rematarlos: sigue siendo tuyo aunque mueras después. Lanza bolas de fuego a distancia y vuelve tres minutos después de morir. Ten la misión antes de matarla, o el collar no cae.",

	-- Step 5: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:6122}. He hands you the {item:6928}. The circle is hard to find: take the stairs behind {npc:6122} down; part way along the lowest corridor a side stair on the left leads into a room with a glowing purple circle in the middle. Stand on it and use the choker. The voidwalker (level 10, not elite) gets dangerous below 30% health: {spell:14868}, Corruption and {spell:348} with your imp on it, Fear when it gets close. If it beats you, use the choker again. Keep the choker: {npc:6122} takes it back."] = "De vuelta con {npc:6122}. Te da {item:6928}. El círculo cuesta encontrarlo: baja por la escalera detrás de {npc:6122}; a mitad del pasillo más bajo, una escalera lateral a la izquierda lleva a una sala con un círculo morado brillante en el centro. Párate en él y usa el collar. El abisario (nivel 10, no élite) se vuelve peligroso por debajo del 30 % de salud: {spell:14868}, Corrupción y {spell:348} con tu diablillo encima, y Miedo cuando se acerque. Si te gana, usa el collar otra vez. Guarda el collar: {npc:6122} lo recupera.",
	-- {item:6928} Bloodstone Choker
	["{item:6928}, on the circle in the crypt"] = "{item:6928}, sobre el círculo de la cripta",
}
