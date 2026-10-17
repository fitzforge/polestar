-- Spanish (Spain) (esES): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2842} Poisons
	["{spell:2842} (Alliance)"] = "{spell:2842} (Alianza)",
	-- {spell:2842} Poisons · {item:7676} Thistle Tea
	["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "En Forever, {spell:2842} se aprende con esta cadena, no con el instructor; incluye la receta de {item:7676}.",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332} at SI:7 in {object:2100} sends you to {npc:7024} in {zone:1436}."] = "A nivel 20, {npc:332}, en el IV:7 de {object:2100}, te envía con {npc:7024} en {zone:1436}.",

	-- Step 2: Agent Kearnen
	-- {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {npc:7051} Malformed Defias Drone
	["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024} vigila la torre de {npc:7053} desde las colinas del extremo este de {zone:1436}, junto a la frontera con {zone:1431}. El {npc:7051} (nivel 23) que guarda la torre lleva su llave; el diario de Klaven está en el cofre de arriba.",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}, in the {object:123214}"] = "{item:7908}, en el {object:123214}",

	-- Step 3: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Cabalga al norte por el Bosque de Elwynn hasta {zone:1453}; Mathias Shaw está en el IV:7, en {object:2100}.",

	-- Step 4: Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207} trabaja en el sótano del IV:7, el Cuartel. Escribe /lay down a su lado para que te examine.",
	["/lay down"] = "/lay down",

	-- Step 5: The cure's ingredients
	["The cure's ingredients"] = "Los ingredientes de la cura",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {item:8431} Spool of Light Chartreuse Silk Thread · {item:3372} Leaded Vial · {item:4371} Bronze Tube
	["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "Todo está en {zone:1453}: los Gump venden {item:3421}, el {item:8431} está en la ciudad y los mercaderes más cercanos venden un {item:3372} y un {item:4371}.",

	-- Step 6: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "De vuelta con {npc:7207}",
}
