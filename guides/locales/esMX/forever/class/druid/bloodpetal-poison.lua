-- Spanish (Latin America) (esMX): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "Experiencia en Un'Goro a nivel 50 y dos pociones de sanación; Forever quitó la elección de objeto de Classic.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lanza {spell:18960}. {npc:12042} está en {area:2361}; tu instructor de clase ofrece la misma misión.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "Vuela a {area:976} y cabalga al oeste hasta la larga rampa que baja a {zone:1449}: {npc:9619} acampa a su pie, en la esquina sureste del cráter.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "Aguijones Gorishi y {item:22434}",
	-- {item:22434} Bloodcap
	-- plural, as words: Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "Las Avispas, Trabajadores y Atracadores Gorishi de la colmena del sur del cráter sueltan los aguijones; los Brotes sangrepétalo que dan el {item:22434} crecen por toda la mitad oeste del cráter.",

	-- Step 5: Toxic Test
	-- {item:22432} Devilsaur Barb · {npc:6498} Devilsaur
	-- plural, as words: Devilsaurs = {npc:6498} Devilsaur
	["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "Usa la {item:22432} en un {npc:6498}. Los demosaurios son élite (nivel 54-55) y recorren el cráter: se recomienda ir en grupo.",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: clávale la {item:22432}",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion
	["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477} está en {area:74}, en {zone:1435}. {npc:8580} guarda el fondo del templo: es jefe de calabozo, así que lleva un grupo.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "Vuelve con {npc:9619} en la esquina sureste de {zone:1449}.",
}
