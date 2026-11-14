-- Spanish (Latin America) (esMX): the guide forever/horde/30-40/06-badlands (forever/horde/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "A {zone:1418}",
	-- {object:2673} Thandol Span (no name in this language: may be words) · {zone:1437} Wetlands · {object:1668} Dun Algaz (no name in this language: may be words) · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head for the {object:2673}, the great bridge at Arathi's southern edge, cross it and follow the road south through the {zone:1437} to the {object:1668} tunnel into {zone:1432}. {area:144}, the dwarf town on the road in the middle of {zone:1432}, has guards who attack the Horde: leave the road before it and pass the town on the hills to its west. The road leaves {zone:1432} to the south into the {zone:1418}; follow it to the goblin camp in the {area:1877}."] = "Ve hacia {object:2673}, el gran puente en el borde sur de Arathi, crúzalo y sigue el camino al sur por {zone:1437} hasta el túnel de {object:1668} hacia {zone:1432}. {area:144}, el pueblo enano en el camino en medio de {zone:1432}, tiene guardias que atacan a la Horda: sal del camino antes de llegar y pasa el pueblo por las colinas al oeste. El camino sale de {zone:1432} hacia el sur, a {zone:1418}; síguelo hasta el campamento goblin en {area:1877}.",

	-- Step 2: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: la carta de Fizzle Pernolatón de {area:439}",

	-- Step 3: The Dustbowl
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl
	["Head west along the road towards {area:340}; {npc:2921}'s camp sits in the {area:1878} halfway there."] = "Ve al oeste por el camino hacia {area:340}; el campamento de {npc:2921} está en {area:1878}, a medio camino.",

	-- Step 4: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "{area:340} es la fortaleza de la Horda construida en los acantilados del borde occidental de la zona. {npc:5394} está en el nivel superior de {area:340}, muy por encima del maestro de vuelo: sube por las rampas, la flecha no distingue los niveles.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "para Helgrum en {area:75}, alrededor del nivel 42",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "{npc:6868}, adentro",

	-- Step 5: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementales de roca inferiores",
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats between {area:340} and {npc:2921}'s camp, on the road back east. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards."] = "Los elementales pequeños vagan por las planicies entre {area:340} y el campamento de {npc:2921}, en el camino de regreso al este. Cada elemental de roca de la zona puede soltar los Fragmentos de elemental de roca de {npc:6868}.",

	-- Step 7: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "{zone:1418}: mátalos cuando te los encuentres",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards."] = "Los Coyotes del risco mayores y las Águilas ratoneras gigantes rondan la cuenca al sur de {area:1878}. Los coyotes sueltan tanto las mandíbulas como los colmillos; las Águilas ratoneras gigantes sueltan las mollejas.",

	-- Step 8: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementales de roca",
	-- {area:345} Agmond's End · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["South-east across the basin, the bigger Rock Elementals (39) stand on the slopes west of {area:345}; each one drops a slab. Every rock elemental can drop {npc:6868}'s Rock Elemental Shards."] = "Al sureste, cruzando la cuenca, los Elementales de roca más grandes (39) están en las laderas al oeste de {area:345}; cada uno suelta una losa. Cada elemental de roca puede soltar los Fragmentos de elemental de roca de {npc:6868}.",

	-- Step 9: Agmond's End
	-- {area:345} Agmond's End
	["Theldurin sits among the dwarven ruins at {area:345}, just east of the elementals."] = "Theldurin está entre las ruinas enanas de {area:345}, justo al este de los elementales.",

	-- Step 10: Stonevault troggs
	["Stonevault troggs"] = "Troggs Grutacanto",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End · {npc:2817} Rigglefuzz
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way north from {area:345}; the Bonesnappers and Shamans drop the flakes. The Buzzards for {npc:2817}'s wings circle the hills between the {area:1877} and {area:345}."] = "Los trogg Bóveda de Piedra excavan alrededor de las bocas de cueva al sur de {area:1877}, de camino al norte desde {area:345}; los Quebrahuesos y Chamanes sueltan las escamas. Las Águilas ratoneras para las alas de {npc:2817} dan vueltas por las colinas entre {area:1877} y {area:345}.",

	-- Step 11: Valley of Fangs
	-- {area:1517} Uldaman · {area:1877} Valley of Fangs · {npc:2817} Rigglefuzz · {npc:4618} Martek the Exiled
	["The road north to {area:1517} runs through the {area:1877}: {npc:2817} and {npc:4618} take the wings and the flakes on the way."] = "El camino al norte hacia {area:1517} atraviesa {area:1877}: {npc:2817} y {npc:4618} reciben las alas y las escamas de camino.",
	-- {area:2240} Mirage Raceway · {area:484} Freewind Post · {zone:1446} Tanaris
	["for Fizzle at the {area:2240}, on the way from {area:484} to {zone:1446} around level 43"] = "para Fizzle en {area:2240}, de camino de {area:484} a {zone:1446} alrededor del nivel 43",

	-- Step 12: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Sigue al norte por el camino; el cofre está en la excavación de {area:1517}, al pie de las ruinas al noroeste del camino.",
	["Below ground"] = "Bajo tierra",

	-- Step 13: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "Regresa al sur por el camino, pasando {area:1877}.",

	-- Step 14: The Dustbowl
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["North-west across the basin to {npc:2921}'s camp. Short of Jarkal's shards? The Lesser Rock Elementals (37) on the flats west of the camp drop them about one kill in five."] = "Al noroeste, cruzando la cuenca, hasta el campamento de {npc:2921}. ¿Te faltan los fragmentos de Jarkal? Los Elementales de roca inferiores (37) en las planicies al oeste del campamento los sueltan aproximadamente una de cada cinco muertes.",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s next study wants bracers from the Greater Rock Elementals (42-44) in the south-western gulches, well above you: leave it."] = "El siguiente estudio de {npc:2921} requiere brazales de los Elementales de roca superiores (42-44) en las quebradas del suroeste, muy por encima de tu nivel: déjalo.",

	-- Step 15: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["Head west back to {area:340}. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "Vuelve al oeste hasta {area:340}. {npc:5394} está en el nivel superior de {area:340}, muy por encima del maestro de vuelo: sube por las rampas, la flecha no distingue los niveles.",
	-- {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words)
	["The next guide flies from {area:340} to {object:3202}."] = "La siguiente guía vuela de {area:340} a {object:3202}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin está sentado entre las ruinas enanas de {area:345}, al sur de {area:1877}.",
	-- ["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: solo si llevas {item:2868} ({skill:164} o la casa de subastas)",
}
