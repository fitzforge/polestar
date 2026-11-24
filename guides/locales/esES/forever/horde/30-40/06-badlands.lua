-- Spanish (Spain) (esES): the guide forever/horde/30-40/06-badlands (forever/horde/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Hacia {zone:1418}",
	-- {object:2673} Thandol Span · {zone:1437} Wetlands · {object:1668} Dun Algaz (no name in this language: may be words) · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head for the {object:2673}, the great bridge at Arathi's southern edge, cross it and follow the road south through the {zone:1437} to the {object:1668} tunnel into {zone:1432}. {area:144}, the dwarf town on the road in the middle of {zone:1432}, has guards who attack the Horde: leave the road before it and pass the town on the hills to its west. The road leaves {zone:1432} to the south into the {zone:1418}; follow it to the goblin camp in the {area:1877}."] = "Dirígete a {object:2673}, el gran puente en el borde sur de Arathi, crúzalo y sigue el camino al sur por {zone:1437} hasta el túnel de {object:1668} que lleva a {zone:1432}. {area:144}, el pueblo enano en el camino en medio de {zone:1432}, tiene guardias que atacan a la Horda: sal del camino antes de llegar y rodea el pueblo por las colinas del oeste. El camino sale de {zone:1432} por el sur hacia {zone:1418}; síguelo hasta el campamento goblin de {area:1877}.",

	-- Step 2: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: la carta de Fizzle desde {area:439}",

	-- Step 3: Rigglefuzz: Pearl Diving
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl · Giant Clams = {object:2744} Giant Clam
	["{npc:2817} buys nine Blue Pearls (Giant Clams on the sea floor, or the Auction House): this step shows only when you carry them."] = "",
	-- {item:4611} Blue Pearl
	["{item:4611}, in your bags"] = "",

	-- Step 4: The Dustbowl
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl
	["Head west along the road towards {area:340}; {npc:2921}'s camp sits in the {area:1878} halfway there."] = "Dirígete al oeste por el camino hacia {area:340}; el campamento de {npc:2921} está en {area:1878}, a medio camino.",

	-- Step 5: Lotwil Veriatus: Coolant Heads Prevail
	-- {npc:2921} Lotwil Veriatus · {item:3829} Frost Oil · {skill:171} Alchemy
	["{npc:2921} wants a {item:3829} ({skill:171} or the Auction House): this step shows only when you carry one."] = "",
	-- {item:3829} Frost Oil
	["{item:3829}, in your bags"] = "",

	-- Step 6: Lotwil Veriatus: Gyro... What?
	-- {item:4389} Gyrochronatom · {skill:202} Engineering
	["Then a {item:4389} ({skill:202}, or the engineering supply vendors): this step shows only when you carry one."] = "",
	-- {item:4389} Gyrochronatom
	["{item:4389}, in your bags"] = "",

	-- Step 7: Lucien Tosselwrench: Liquid Stone
	-- {npc:2921} Lotwil Veriatus · {item:929} Healing Potion · {item:3823} Lesser Invisibility Potion · {skill:171} Alchemy
	["Lucien, beside {npc:2921}, wants a {item:929} and a {item:3823} ({skill:171} or the Auction House): this step shows only when you carry both."] = "",
	-- {item:929} Healing Potion
	["{item:929}, in your bags"] = "",
	-- {item:3823} Lesser Invisibility Potion
	["{item:3823}, in your bags"] = "",

	-- Step 8: Kargath
	-- {area:340} Kargath · {quest:1418} Neeka Bloodscar
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge. {quest:1418} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "{area:340} es la fortaleza de la Horda construida en los acantilados del borde oeste de la zona. {quest:1418} está en el nivel superior de {area:340}, muy por encima del maestro de vuelo: sube por las rampas, la flecha no distingue los niveles.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "para Helgrum en {area:75}, sobre el nivel 42",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "{npc:6868}, dentro",

	-- Step 9: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementales de piedra inferiores",
	-- {area:340} Kargath · {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats between {area:340} and {npc:2921}'s camp, on the road back east. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards."] = "Los elementales pequeños flotan por la llanura entre {area:340} y el campamento de {npc:2921}, en el camino de vuelta al este. Cualquier elemental de roca de la zona puede soltar los Fragmentos de elemental de roca de {npc:6868}.",

	-- Step 11: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "{zone:1418}: mata a estos según te los encuentres",
	-- {area:1878} The Dustbowl · {zone:1418} Badlands · {npc:2817} Rigglefuzz
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard · Malevolent Mirages = {npc:269756} Malevolent Mirage
	-- was: ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards. Careful: Malevolent Mirages (42, elite) drift across the {zone:1418}: give them a wide berth.\nCareful: the Giant Buzzards are 39-41, and the 41s are two over you at 39: pick the 39s and 40s and pull them one at a time. The Buzzards (37) you kill later for {npc:2817}'s wings drop gizzards too, more rarely."] = "Los Coyotes del risco mayores y las Águilas ratoneras gigantes recorren la cuenca al sur de {area:1878}. Los coyotes sueltan tanto las mandíbulas como los colmillos; las Águilas ratoneras gigantes sueltan las mollejas. Cuidado: los Espejismos malévolos (42, élite) vagan por {zone:1418}: mantente bien lejos.\nCuidado: las Águilas ratoneras gigantes son de nivel 39-41, y las de 41 te sacan dos niveles si eres de 39: elige las de 39 y 40 y atráelas de una en una. Las águilas ratoneras (37) que matarás luego por las alas para {npc:2817} también sueltan mollejas, aunque con menos frecuencia."
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards. Careful: Malevolent Mirages (42, elite) drift across the {zone:1418}: give them a wide berth.\nCareful: the Giant Buzzards are 39-41, and the 41s are two over you at 39: pick the 39s and 40s and pull them one at a time. The Buzzards (37) you kill later for {npc:2817}'s wings drop gizzards too, more rarely.\nCareful: Zaricotl (55, a rare buzzard) circles over the {zone:1418} too: if you see him, keep away."] = "",

	-- Step 12: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementales de piedra",
	-- {area:345} Agmond's End · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard · Malevolent Mirages = {npc:269756} Malevolent Mirage
	["South-east across the basin, the bigger Rock Elementals (39) stand on the slopes west of {area:345}; each one drops a slab. Every rock elemental can drop {npc:6868}'s Rock Elemental Shards. Careful: Malevolent Mirages (42, elite) drift across these slopes too."] = "Al sureste cruzando la cuenca, los elementales de piedra más grandes (39) están en las laderas al oeste de {area:345}; cada uno suelta una losa. Cualquier elemental de roca puede soltar los Fragmentos de elemental de roca de {npc:6868}. Cuidado: los espejismos malévolos (42, élite) también flotan por estas laderas.",

	-- Step 13: Agmond's End
	-- {area:345} Agmond's End · {area:1517} Uldaman
	["Theldurin sits among the dwarven ruins at {area:345}, just east of the elementals. His tablet lies just inside {area:1517}'s cave mouth, beside level 38 elites: a quest for a group."] = "Theldurin está sentado entre las ruinas enanas de {area:345}, justo al este de los elementales. Su tablilla está justo al entrar por la boca de la cueva de {area:1517}, junto a élites de nivel 38: una misión para grupo.",

	-- Step 14: Stonevault troggs
	["Stonevault troggs"] = "Troggs Grutacanto",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End · {npc:2817} Rigglefuzz
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way north from {area:345}; the Bonesnappers and Shamans drop the flakes. The Buzzards for {npc:2817}'s wings circle the hills between the {area:1877} and {area:345}."] = "Los troggs Grutacanto excavan alrededor de las bocas de las cuevas al sur de {area:1877}, de camino al norte desde {area:345}; los Cascahuesos y los chamanes sueltan las escamas. Los buitres para las alas de {npc:2817} vuelan en círculos sobre las colinas entre {area:1877} y {area:345}.",

	-- Step 15: Valley of Fangs
	-- {area:1517} Uldaman · {area:1877} Valley of Fangs · {npc:2817} Rigglefuzz · {npc:4618} Martek the Exiled
	["The road north to {area:1517} runs through the {area:1877}: {npc:2817} and {npc:4618} take the wings and the flakes on the way."] = "El camino al norte hacia {area:1517} pasa por {area:1877}: {npc:2817} y {npc:4618} reciben las alas y las escamas en el camino.",
	-- {area:2240} Mirage Raceway · {area:484} Freewind Post · {zone:1446} Tanaris
	["for Fizzle at the {area:2240}, on the way from {area:484} to {zone:1446} around level 43"] = "para Fizzle en {area:2240}, de camino de {area:484} a {zone:1446} alrededor del nivel 43",

	-- Step 16: Ancient Chest
	-- {area:1517} Uldaman · {zone:1418} Badlands · {npc:2932} Magregan Deepshadow
	-- plural, as words: Obsidian Golems = {npc:4872} Obsidian Golem · Shadowforge Diggers = {npc:4846} Shadowforge Digger
	["Keep north on the road to {area:1517}'s entrance, in the north of the {zone:1418}: the chest lies just inside the cave mouth. {npc:2932} and the Obsidian Golems (38) stand beside it and Shadowforge Diggers (35-36) work the tunnel, all elite: keep your group together."] = "Sigue al norte por el camino hasta la entrada de {area:1517}, en el norte de {zone:1418}: el cofre está justo dentro de la boca de la cueva. {npc:2932} y los Gólems de obsidiana (38) están a su lado y los Excavadores Forjatiniebla (35-36) trabajan en el túnel, todos élite: mantén unido a tu grupo.",
	["Below ground"] = "Bajo tierra",

	-- Step 17: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "Regresa al sur por el camino, pasando {area:1877}.",

	-- Step 18: The Dustbowl
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["North-west across the basin to {npc:2921}'s camp. Short of Jarkal's shards? The Lesser Rock Elementals (37) on the flats west of the camp drop them about one kill in five."] = "Al noroeste cruzando la cuenca hasta el campamento de {npc:2921}. ¿Te faltan fragmentos de Jarkal? Los elementales de piedra inferiores (37) de la llanura al oeste del campamento los sueltan más o menos una de cada cinco veces.",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s next study wants bracers from the Greater Rock Elementals (42-44) in the south-western gulches, well above you: leave it."] = "El siguiente estudio de {npc:2921} pide brazales de los elementales de piedra mayores (42-44) de los barrancos del suroeste, que te superan bastante en nivel: déjalo.",

	-- Step 19: Kargath
	-- {area:340} Kargath · {npc:5394} Neeka Bloodscar
	["Head west back to {area:340}. {npc:5394} stands on {area:340}'s upper level, high above the flight master: take the ramps up, the arrow cannot tell the levels apart."] = "Regresa al oeste a {area:340}. {npc:5394} está en el nivel superior de {area:340}, muy por encima del maestro de vuelo: sube por las rampas, la flecha no distingue los niveles.",
	-- {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity · {npc:4486} Genavie Callow
	["The next guide flies from {area:340} to {object:3202}; Warriors, Paladins, Rogues, Priests, Mages and Warlocks go by the {zone:1458} first, for their training and {npc:4486}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Sigue al norte por el camino; el cofre está en la excavación de {area:1517}, al pie de las ruinas al noroeste del camino.",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; the Giant Buzzards drop the gizzards. Careful: Malevolent Mirages (42, elite) drift across the {zone:1418}: give them a wide berth.\nCareful: the Giant Buzzards are 39-41, and the 41s are two over you at 39: pick the 39s and 40s and pull them one at a time. The Buzzards (37) you kill later for {npc:2817}'s wings drop gizzards too, more rarely."] = "Los Coyotes del risco mayores y las Águilas ratoneras gigantes recorren la cuenca al sur de {area:1878}. Los coyotes sueltan tanto las mandíbulas como los colmillos; las Águilas ratoneras gigantes sueltan las mollejas. Cuidado: los Espejismos malévolos (42, élite) vagan por {zone:1418}: mantente bien lejos.\nCuidado: las Águilas ratoneras gigantes son de nivel 39-41, y las de 41 te sacan dos niveles si eres de 39: elige las de 39 y 40 y atráelas de una en una. Las águilas ratoneras (37) que matarás luego por las alas para {npc:2817} también sueltan mollejas, aunque con menos frecuencia.",
	-- ["The next guide flies from {area:340} to {object:3202}."] = "La siguiente guía vuela de {area:340} a {object:3202}.",
	-- ["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin está entre las ruinas enanas de {area:345}, al sur de {area:1877}.",
	-- ["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: solo si llevas {item:2868} ({skill:164} o la casa de subastas)",
}
