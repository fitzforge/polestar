-- Spanish (Spain) (esES): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "Desde {area:144}, cabalga hacia el sur hasta {zone:1418}, luego al oeste más allá del pueblo de la Horda de {area:340} (mantén la distancia) y sube por el sendero hasta {zone:1427}. {area:1446} es el campamento con andamios del borde noroeste.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "El tablón {object:179827}",

	-- Step 2: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "El elfo de la noche está solo al oeste de {area:1446}. Escucha su historia.",

	-- Step 3: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Kalaran Espada del Viento está en el borde de La Caldera, al sur de {area:1446}. Escucha su historia.",

	-- Step 4: Golems and elementals
	["Golems and elementals"] = "Gólems y elementales",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Los Gólems de guerra pesados patrullan el fondo de La Caldera bajo Kalaran; los Elementales de magma vagan entre ellos. Gólems y elementales sueltan el aceite; los elementales, los corazones.",

	-- Step 6: Dark Iron dwarves
	-- {object:147516} Dark Iron
	["{object:147516} dwarves"] = "Enanos {object:147516}",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Capataces y Esclavistas Hierro Negro azuzan a los esclavos por toda La Caldera, y cualquiera puede llevar una {item:10551}. Los Vapoherreros Hierro Negro trabajan en los hornos del centro (la {item:18959}) y los Vigías Hierro Negro están en las crestas del sur (el Telescopio de vigía). Cualquier {object:147516} puede soltar la {item:11818}: guárdala.",

	-- Step 7: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Arañas de lava abrasadoras",
	["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Las arañas deambulan por las mesetas y charcas de lava del suroeste de la garganta.",

	-- Step 9: The Slag Pit
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} se abre en el norte de La Caldera. Los planos secretos están en su cornisa superior; los Incendosaurios nadan en las charcas de lava más adentro, así que atráelos hasta el borde. Mantente lejos de {npc:14621} y sus guardias élite del fondo.",

	-- Step 11: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "La letrina de Limugre",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Cabalga hacia el este por La Caldera hasta {area:247}, en el sureste. El prisionero de la letrina de madera quiere 15 {item:4306} y ocho geólogos Hierro Negro ({npc:5839}) muertos de la excavación que la rodea. La letrina también se abre con la llave, si encontraste una.",
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "La siguiente tarea del prisionero, El libro de contabilidad de {zone:1446}, te envía a {zone:1435} y {zone:1445}: omítela.",

	-- Step 12: Dorius Stonetender
	-- {object:147516} Dark Iron · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "El enano está junto al camino en la excavación. Síguelo hacia el norte por el camino y rechaza las emboscadas {object:147516}. Cuando termine, lee la {object:175704} que deja en el camino en {area:1959}.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, later"] = "Para {npc:8256} en {zone:1455}, más adelante",
}
