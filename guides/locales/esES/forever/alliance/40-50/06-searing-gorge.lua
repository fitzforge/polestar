-- Spanish (Spain) (esES): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "A {zone:1455}",

	-- Step 2: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Vuela a {area:144}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",

	-- Step 3: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "",

	-- Step 4: Searing Gorge
	["The Grimesilt outhouse"] = "La letrina de Limugre",

	-- Step 5: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Desde {area:144}, cabalga hacia el sur hasta {zone:1418}, luego al oeste más allá del pueblo de la Horda de {area:340} (mantén la distancia) y sube por el sendero hasta {zone:1427}: {area:247} está justo al entrar, en el sureste. El prisionero de la letrina de madera quiere 15 {item:4306} y ocho geólogos Hierro Negro muertos de la excavación que la rodea. La letrina también se abre con la llave, si encontraste una.",

	-- Step 6: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "La siguiente tarea del prisionero, El libro de contabilidad de {zone:1446}, te envía a {zone:1435} y {zone:1445}: omítela.",

	-- Step 7: Level 48.27
	["Level 48.27"] = "",
	-- {item:3985} Monogrammed Sash
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan."] = "",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "",

	-- Step 8: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "Dorius está junto al camino, al lado de {area:247}. Escóltalo hacia el noreste hasta {area:1959} y mantenlo con vida; cuando termine, lee la {object:175704} que deja en el camino.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, at the end of this guide"] = "Para {npc:8256} en {zone:1455}, al final de esta guía",

	-- Step 9: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "Cabalga hacia el oeste por el norte de la garganta hasta {area:1446}, el campamento con andamios del borde noroeste.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "El tablón {object:179827}",

	-- Step 11: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "El elfo de la noche está solo al oeste de {area:1446}. Escucha su historia.",

	-- Step 14: Searing Lava Spiders
	-- plural, as words: Searing Lava Spiders = {npc:5857} Searing Lava Spider
	["Searing Lava Spiders"] = "Arañas de lava abrasadoras",
	-- {npc:8436} Zamael Lunthistle
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to Velarok."] = "Las arañas deambulan por las mesetas y charcas de lava al sur de {npc:8436}, de camino a Velarok.",

	-- Step 15: Velarok Windblade
	["Velarok Windblade"] = "Velarok Windblade",
	-- {area:1446} Thorium Point
	["Velarok stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Velarok está en el borde de La Caldera, al sur de {area:1446}. Escucha su historia.",

	-- Step 18: Golems and elementals
	["Golems and elementals"] = "Gólems y elementales",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Velarok; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Los Gólems de guerra pesados patrullan el fondo de La Caldera bajo Velarok; los Elementales de magma vagan entre ellos. Gólems y elementales sueltan el aceite; los elementales, los corazones.",

	-- Step 20: Dark Iron dwarves: kill these as you meet them
	["Dark Iron dwarves: kill these as you meet them"] = "",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Capataces y Esclavistas Hierro Negro azuzan a los esclavos por toda La Caldera, y cualquiera puede llevar una {item:10551}. Los Vapoherreros Hierro Negro trabajan en los hornos del centro (la {item:18959}) y los Vigías Hierro Negro están en las crestas del sur (el Telescopio de vigía). Cualquier {object:147516} puede soltar la {item:11818}: guárdala.\nCuidado: los Esclavistas Hierro Negro (nivel 45-46) piden ayuda a los aliados a menos de 15 m cuando los atraes, lanzan Red desde hasta 15 m y usan Desgarrar cuerpo a cuerpo.",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} se abre en el norte de La Caldera. Los planos secretos están en su cornisa superior; los Incendosaurios nadan en las charcas de lava más adentro, así que atráelos hasta el borde. Mantente lejos de {npc:14621} y sus guardias élite del fondo.",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "",

	-- Step 24: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 26: Level 48.66
	["Level 48.66"] = "",
	-- {quest:7701} WANTED: Overseer Maltorius
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan."] = "",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "",

	-- Step 28: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 30: The Torch of Retribution
	["Listen to Velarok's story once more."] = "Escucha la historia de Velarok una vez más.",

	-- Step 31: Velarok Windblade
	-- {quest:3453} The Torch of Retribution · {quest:3462} Squire Maltrake
	["{quest:3453} lies on the ground at Velarok's feet; {quest:3462} stands beside him."] = "{quest:3453} está en el suelo a los pies de Velarok; {quest:3462} está a su lado.",
	-- {quest:3462} Squire Maltrake · {area:1446} Thorium Point
	["{quest:3462}: hand it in on the way back to {area:1446}"] = "{quest:3462}: entrégala de camino de vuelta a {area:1446}",

	-- Step 32: Sentry Braziers
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Sentry Braziers"] = "Braseros de centinela",
	-- {object:149047} Torch of Retribution
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Carry the {object:149047} south along the rim of the Cauldron and light the four Sentry Braziers, from the south-west round to the south-east."] = "Lleva la {object:149047} hacia el sur por el borde de La Caldera y enciende los cuatro Braseros de centinela, del suroeste al sureste.",

	-- Step 33: Level 48.98
	["Level 48.98"] = "",
	-- {quest:3452} The Flame's Casing
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan."] = "",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "",

	-- Step 34: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",
	["Below ground"] = "Bajo tierra",

	-- Step 36: Squire Maltrake
	-- {npc:8509} Squire Maltrake · {area:1446} Thorium Point
	["{npc:8509} and the dragonflight's hoard are beside Velarok, on the rim south of {area:1446}."] = "{npc:8509} y el tesoro del Vuelo Negro están junto a Velarok, en el borde al sur de {area:1446}.",
	-- {object:149502} Hoard of the Black Dragonflight · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous · {zone:1428} Burning Steppes
	["The {object:149502} it gives holds a {item:10575}: keep it for {npc:9459} in the {zone:1428}"] = "El {object:149502} que te da contiene una {item:10575}: guárdala para {npc:9459}, en {zone:1428}",

	-- Step 38: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "",

	-- Step 39: Hall of Explorers
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: los mocos están en {zone:1448}, guárdala",

	-- Step 40: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Cuatro calcos de runas en {zone:1447}: guárdala",

	-- Step 41: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 42: Xiggs Fuselighter
	-- {object:32359} Military Ward (no name in this language: may be words)
	["Xiggs waits in the {object:32359}."] = "Xiggs espera en el Distrito Militar ({object:32359}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["For {npc:8256} in {area:1537}, later"] = "Para {npc:8256} en {area:1537}, más adelante",
	-- ["Greater Lava Spiders"] = "Arañas de lava abrasadoras",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: la guía anterior te trae aquí con la piedra de hogar, así que esto suele marcarse al instante",
	-- ["{object:147516} dwarves"] = "Enanos {object:147516}",
}
