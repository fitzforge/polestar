-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/neutral/deathcharger (forever/collectibles/mounts/neutral/deathcharger.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Deathcharger"] = "Destrero de la muerte",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} de oficial",
	-- {item:13335} Deathcharger's Reins · {skill:762} Riding
	["{item:13335} needs level 60 and Journeyman {skill:762} to ride (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "{item:13335} requiere nivel 60 y {skill:762} de oficial para montar (cliente de Forever). Apréndela con el instructor de equitación de tu raza; consulta las guías de monturas de nivel 60.",

	-- Step 2: Stratholme: Baron Rivendare
	-- {area:2279} Stratholme · {object:175461} Service Entrance · {object:175440} Elders' Square · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare
	["{area:2279} is a group of five, level 58-60. The {object:175461} at {object:175440}, in north-western {zone:1423}, leads to the undead side; {npc:10440} waits in the Slaughter House at its end. Our data gives the reins a 0.02% drop chance (pfQuest, Era): one in about five thousand kills. Nothing shows Forever changing it."] = "{area:2279} es para un grupo de cinco, nivel 58-60. {object:175461} en {object:175440}, en el noroeste de {zone:1423}, lleva al lado no-muerto; {npc:10440} espera en el Slaughter House, al final. Nuestros datos dan a las riendas un 0.02% de probabilidad (pfQuest, Era): una de cada unas cinco mil muertes. Nada indica que Forever lo haya cambiado.",
	-- {object:175461} Service Entrance
	["Stratholme {object:175461}"] = "{object:175461} de Stratholme",
}
