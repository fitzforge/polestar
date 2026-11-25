-- Spanish (Spain) (esES): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2255} Everlook · {zone:1448} Felwood · {zone:1452} Winterspring
	["{area:2255} first, then Un'Goro, then {zone:1448} and {zone:1452} again."] = "Primero {area:2255}, luego Un'Goro y después de nuevo {zone:1448} y {zone:1452}.",

	-- Step 1: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Vuela a {area:2255}",

	-- Step 2: Everlook
	-- {area:2255} Everlook · {npc:11754} Meggi Peppinrocker
	["The flight lands in {area:2255}: {npc:11754} and Umi stand around the town before you ride west."] = "",
	-- {npc:11754} Meggi Peppinrocker · {npc:9298} Donova Snowden · {area:2255} Everlook
	["{npc:11754}, for {npc:9298}: walks around {area:2255}, look inside the circle on the map"] = "",
	-- {npc:10305} Umi Rumplesnicker
	-- plural, as words: Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle
	["{npc:10305}: the Rogue Ice Thistles on the road west carry the furs"] = "",

	-- Step 3: The road west: feathers, furs and horns
	["The road west: feathers, furs and horns"] = "",
	-- {npc:9298} Donova Snowden · {item:12366} Thick Yeti Fur · {item:12444} Uncracked Chillwind Horn · {npc:10468} Felnok Steelspring
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["Moontouched Feathers lie on the ground all along the road west to {npc:9298}, where the Ragged Owlbeasts (53) roam: pick them up as you ride.\nThe same road crosses the Rogue Ice Thistles' ground (about one in three drops a {item:12366} for Umi) and the Fledgling Chillwinds' (about one in five drops an {item:12444} for {npc:10468}): work both here, around the road's middle.\nCareful: both are 53-55: pull the lower ones and take them one at a time."] = "",
	-- {item:12366} Thick Yeti Fur
	-- plural, as words: Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle
	["{item:12366}, from the Rogue Ice Thistles"] = "",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["{item:12444}, from the Fledgling Chillwinds"] = "",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["{npc:9298} camps beside the hot springs at the western end of the road."] = "",
	-- {item:11243} Videre Elixir
	["With the {item:11243} from Gregan"] = "",

	-- Step 5: Donova Snowden
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299}, at the graveyard just east of {area:976}, later in this guide"] = "",

	-- Step 6: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: mátalos según te los encuentres",
	-- {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {item:14047} Runecloth · {npc:11557} Meilosh
	-- plural, as words: Winterfall Ritual Totems = {quest:8471} Winterfall Ritual Totem
	["The western Winterfall camp sits in the hills between {npc:9298} and the tunnel. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need): right-click it. They also drop Winterfall Ritual Totems (about one in thirty) and {item:14047}, which only matter if you are Neutral (the totem) or Friendly ({npc:11557}'s {item:14047}) with the Timbermaw: keep them then.\nCareful: the Pathfinders are 53 and the Totemics 54, but the Den Watchers inside the camp are 55: take the camp from its edge and pull one at a time."] = "",
	-- {item:14047} Runecloth · {npc:11557} Meilosh
	["{item:14047}, for {npc:11557}, if you are Friendly with the Timbermaw"] = "",

	-- Step 7: Winterfall Ritual Totem
	-- {npc:11558} Kernda
	["{npc:11558} takes the totem; the quest needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["For {npc:11558} in {area:1769}, later in this guide: keep it"] = "",

	-- Step 8: Donova Snowden
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	["The Deadwood cauldron in {area:1762}, at the {zone:1448} end of the tunnel"] = "",

	-- Step 9: Felwood
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden · {zone:1448} Felwood
	["Through {area:1769}'s tunnel, just north of {npc:9298}, to {zone:1448}."] = "",
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{area:1769}, {zone:1448} side"] = "",

	-- Step 10: Deadwood Cauldron
	-- {area:1762} Felpaw Village
	["The Deadwood cauldron stands at the top of {area:1762}, just west of the cave mouth."] = "",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298}, on this guide's {zone:1452} loop: keep it"] = "",

	-- Step 11: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride south from the cave to {area:1998}, the night elves' camp on the road."] = "",

	-- Step 12: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",

	-- Step 13: Fly to Theramore
	["Fly to Theramore"] = "Vuela a Theramore",

	-- Step 14: The Barrens
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "Desde Theramore, cabalga al oeste hacia {zone:1413} y al norte por la costa hasta {area:392}.",

	-- Step 15: Ratchet
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: the ash is in Un'Goro; inside"] = "",

	-- Step 16: The Stone Circle
	-- {quest:3444} The Stone Circle
	["{quest:3444} stands on the hill just south-west of the flight master."] = "",

	-- Step 17: Islen Waterseer
	-- {npc:5901} Islen Waterseer
	["{npc:5901} stands on the coast south-east of town."] = "",
	-- {zone:1448} Felwood
	["For Greta in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 18: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maestro de vuelo de {area:392}",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan · {npc:9623} A-Me 01 · {quest:4243} Chasing A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{area:976}'s Auction House is the last one before Un'Goro. There, {npc:9623} ({quest:4243}) asks for a {item:10561}, an {skill:202} item, before her escort: buy one here if you want that chain."] = "La casa de subastas de {area:976} es la última antes de Un'Goro. Allí {npc:9623} ({quest:4243}) pide un {item:10561}, un objeto de {skill:202}, antes de su escolta: compra uno aquí si quieres esa cadena.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, dentro",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro"] = "",

	-- Step 20: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir
	["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} es un fantasma en el cementerio justo al este del pueblo: bebe un {item:11243} allí, lo que te mata, libera tu espíritu y habla con él como fantasma. Luego corre de vuelta a tu cuerpo para resucitar: la lápida está cerca.",
	-- {npc:8737} Linken · {area:541} Marshal's Refuge
	["{npc:8737} in {area:541}, Un'Goro: keep it"] = "",

	-- Step 21: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Cabalga al suroeste hasta el campamento de {npc:7771} en el {area:1938}.",
	-- {npc:7771} Marvon Rivetseeker · {area:1417} Sunken Temple
	["{npc:7771}'s next task, Into the Depths, is inside the {area:1417}: skip it."] = "",

	-- Step 23: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Vuela a {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maestro de vuelo de {area:976}",

	-- Step 24: Marshal's Refuge
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9999} Ringo · {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9618} Karna Remtravel
	["Fly from {area:976} to {area:541}. {npc:9997}'s friend {npc:9999} has gone missing; {npc:8737} stands at the back of the refuge, with {npc:9117} in the cave behind him; {npc:9618} stands just outside, on the way out east."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "El cartel de madera junto a {npc:9997}",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, bajo tierra",
	-- {npc:9116} Eridan Bluewind · {zone:1448} Felwood
	["For {npc:9116} in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 25: Northern Pylon
	["Northern Pylon"] = "Pilón del norte",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:6584} King Mosh
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}.\nCareful: {npc:6584} (60), a rare devilsaur, roams the crater's west around 27,46: if you meet him, ride away."] = "",

	-- Step 26: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Cabalga al este hasta {area:1943}, donde el robot está entre los gorilas. No entres en la cueva profunda de allí.",
	["Below ground"] = "Bajo tierra",

	-- Step 27: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau
	["{area:1943}: kill these as you meet them"] = "{area:1943}: mata a estos según los encuentres",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Los gorilas viven en {area:1943}, justo al este de la torre: consigue ahora las pieles para {npc:9619}, ya que estás aquí arriba. No entres en la cueva más profunda: {npc:9622} es de nivel 55.\nCuidado: los gorilas de Un'Goro (nivel 50-51) piden ayuda a los aliados en un radio de 20 m cuando bajan al 25% de salud. Hay una cueva llena de simios en la zona, y luchar allí atrae a muchos enemigos.",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478}; bajo tierra",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479}; bajo tierra",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480}; bajo tierra",

	-- Step 29: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: mátalos según te los encuentres",
	-- {area:538} Lakkari Tar Pits
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Las bestias de alquitrán y los señores del alquitrán se revuelcan en {area:538}, al sur del refugio, en la bajada al cráter.",

	-- Step 30: The crater
	["The crater"] = "El cráter",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Las bestias de alquitrán se revuelcan en {area:538}; los elementales de fuego de {area:537}, en el centro, llevan la ceniza; las avispas Gorishi de {area:540}, en el sur, llevan la glándula. Cualquier criatura del cráter puede soltar {item:11018}.\nCuidado: Las trabajadores Gorishi que bajan del 45% de salud tienen un 50% de probabilidad de pedir ayuda a los aliados a menos de 25 m.",

	-- Step 31: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619} acampa al pie de la rampa de entrada al cráter.",
	-- {quest:4291} The Scent of Lar'korwi
	["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, si aún la llevas de la primera visita",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "Las pieles salen de los gorilas de {area:1943}",
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, si un ravasaurio ha soltado la escama desde la primera visita",

	-- Step 32: Damaged Blue Crystal
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "El {item:280417} está a poca distancia al oeste del campamento de {npc:9619}.",

	-- Step 35: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Los gorilas viven en {area:1943}, al este de {area:541}. Guarda sus pieles para {npc:9619}. No entres en la cueva más profunda: {npc:9622} es de nivel 55.\nCuidado: Los gorilas de Un'Goro (nivel 50-51) piden ayuda a los aliados a menos de 20 m cuando bajan al 25% de salud. En la zona hay una cueva llena de simios, y pelear ahí trae muchos enemigos de más.",

	-- Step 37: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Cabalga al norte por el lado este hasta la meseta de los gorilas. {npc:9622}, un gorila de nivel 55, está en su cueva más profunda: limpia primero los gorilas de la entrada.",

	-- Step 38: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there.\nCareful: {npc:9684} is level 56, a level or two over you here: start at full health, and clear the raptors around the lair first."] = "",

	-- Step 39: Eastern Pylon and the crate
	["Eastern Pylon and the crate"] = "Torre oriental y el cajón",
	-- {npc:9684} Lar'korwi · {item:11113} Crate of Foodstuffs
	["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "La torre está en los acantilados del este, sobre la guarida de {npc:9684}; el {item:11113} de la expedición está en el campamento abandonado de la jungla oriental.",

	-- Step 40: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Cruza el sur del cráter hasta {npc:9619}, junto a la rampa.",

	-- Step 41: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}: mátalos según te los encuentres",

	-- Step 42: The Gorishi hive
	["The Gorishi hive"] = "La colmena Gorishi",
	["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "Al oeste por el sur del cráter: lo llena la colmena Gorishi. Usa el vial de raspado en un criadero, una cámara con larvas colgando.",

	-- Step 43: Bones and equipment
	["Bones and equipment"] = "Huesos y equipo",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle.\nCareful: Gruff (57), a rare devilsaur, prowls the south around 38,75: if you meet him, ride away."] = "",

	-- Step 44: Western Pylon
	["Western Pylon"] = "Pilón del oeste",
	["The pylon stands on the western cliffs."] = "La torre está en los acantilados del oeste.",

	-- Step 45: Krakle
	-- {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["North-east from the pylon to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 46: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Cabalga al este hasta {area:537}, súbela y usa {npc:10541} en las grietas de lava cerca de la cima.",

	-- Step 47: Krakle
	-- {npc:10302} Krakle
	["Back west to {npc:10302} at the hot springs."] = "",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}, later in this guide: keep it"] = "",

	-- Step 48: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado en la ladera sureste de {area:537}, en el centro del cráter.",

	-- Step 49: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolta a {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 51: Fly to Gadgetzan
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Maestro de vuelo de {area:541}",

	-- Step 52: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen · {area:540} Slithering Scar
	["Pestlezugg's next task, Pawn Captures Queen, sends you back to the {npc:10041} in the {area:540}: skip it."] = "",

	-- Step 54: Liv Rizzlefix
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, dentro",

	-- Step 55: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Vuela a {area:415}",

	-- Step 56: Felwood
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "",

	-- Step 57: Eridan Bluewind
	-- {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary
	["{npc:9116} stands inside, in the {area:2479}."] = "{npc:9116} está dentro, en {area:2479}.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, dentro",

	-- Step 58: The Emerald Sanctuary
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {area:2253} Starfall Village
	["{npc:10924}: for {npc:11079} in {area:2253}, later in this guide; keep it"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Espera un momento a {npc:9116}",
	-- {npc:9116} Eridan Bluewind · {npc:222647} Ancient Spirit · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1448} Felwood
	["{npc:9116}'s next task, {npc:222647}, ends with {npc:3848} at {area:2358}, south of the route once {zone:1448} is done: skip it."] = "",
	-- {npc:9116} Eridan Bluewind
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["{npc:9116}'s next task, Silver Heart, sends you to the Irontree Stompers in the north and back here: skip it."] = "",

	-- Step 59: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Braseros de {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns: pull at the edge of each group and fight one pack at a time.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "{object:176159}, bajo tierra",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}, bajo tierra",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}, bajo tierra",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}, bajo tierra",
	-- {item:11515} Corrupted Soul Shard · {npc:9528} Arathandris Silversky
	["{item:11515}, from the same cultists: {npc:9528} takes six by the Sanctuary if you did Cleansing Felwood"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}, en su celda; bajo tierra",

	-- Step 60: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "Llévala fuera de {area:1770} y mantenla con vida hasta que esté afuera de la cueva: despeja antes el camino de vuelta.",

	-- Step 62: Greta Mosshoof: A Final Blow
	-- {quest:5242} A Final Blow · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold
	["{quest:5242} is a group quest at this level: {npc:9861} (52), {npc:9860} (54) and {npc:9517} (57) fight together at the back of {area:1770}. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "",

	-- Step 63: Rakaiah
	-- {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Back into {area:1770}: the succubus {npc:9518} (56) waits on the way to its deepest chamber, with Trey Lightforge's remains beside her.\nCareful: {npc:9518} is level 56: clear the cultists around her first and fight her at full health."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}, bajo tierra",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}, bajo tierra",

	-- Step 64: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["{npc:9861} and {npc:9860} guard {npc:9517} in {area:1770}'s deepest chamber, just past {npc:9518}.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}, bajo tierra",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}, bajo tierra",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517}; bajo tierra",

	-- Step 65: The Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "Vuelve al sureste hasta el Santuario.",

	-- Step 66: Arathandris Silversky
	-- {npc:9528} Arathandris Silversky · {area:1770} Shadow Hold
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["{npc:9528} is in the ruins just down the road from the Sanctuary: he takes the six Corrupted Soul Shards (from both trips into {area:1770}) on the spot."] = "",

	-- Step 68: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Ride north up the road to the cave mouth of {area:1769}."] = "",

	-- Step 69: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["{npc:11558} stands just inside the {area:1769} cave: she needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: recorre esta zona: busca dentro del círculo del mapa",

	-- Step 71: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557}; bajo tierra",

	-- Step 72: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Hacia {zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 73: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride on to {npc:9298}'s camp beside the hot springs."] = "",
	-- {quest:980} The New Springs · {area:2256} Darkwhisper Gorge
	["{quest:980}' follow-up, Strange Sources, is at {area:2256}'s mouth among elite giants and Hederine: skip it."] = "",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["The {quest:5086} are just back through the tunnel, in {zone:1448}"] = "",

	-- Step 74: Felwood
	-- {zone:1448} Felwood · {area:1998} Talonbranch Glade · {quest:5086} Toxic Horrors · {area:1767} Irontree Woods
	["Back through the tunnel to {zone:1448} and south past {area:1998}: the {quest:5086} (53) roam the north-eastern tip of {area:1767}."] = "",
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "{quest:5086}",

	-- Step 75: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "Cuidado: los Caminantes ancestrales Troncoferro, élites de nivel 59, están entre {quest:5086}: ataca a los Horrores en la punta noreste del campamento (hacia 50.6,22.4), de uno en uno, y busca un caminante antes de cada ataque.",

	-- Step 76: Winterspring
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["Back north through {area:1769}'s tunnel to {npc:9298}."] = "",

	-- Step 78: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452}: mata a estos según te los encuentres",
	-- {quest:5087} Winterfall Runners · {area:2246} Frostfire Hot Springs · {zone:1448} Felwood · {spell:5384} Feign Death
	["The {quest:5087} (57) carry their crates along the road between {area:2246} and {zone:1448}'s tunnel.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest.\nCareful: the {quest:5087} are 57, over you here: pull one at a time, away from the camp."] = "",

	-- Step 80: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Cabalga hacia el este por el camino hasta {area:2255}.",
	-- {npc:11755} Harlo Wigglesworth · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village
	["{npc:11755}: for {npc:10301} in {area:2253}, just back up the road"] = "",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep it for the Plaguelands, on the next guide; inside"] = "",

	-- Step 81: Starfall Village
	-- {area:2253} Starfall Village · {npc:11079} Wynd Nightchaser · {npc:10301} Jaron Stoneshaper
	["Ride back north-west to {area:2253} on its hill: {npc:11079} and {npc:10301} stand together."] = "",
	-- {quest:5250} Starfall
	["The relics are in the ruins just south of {quest:5250}"] = "",

	-- Step 82: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village · {npc:10304} Aurora Skycaller · {zone:1423} Eastern Plaguelands
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins: {npc:10304} in the {zone:1423} takes them, on the next guide."] = "",

	-- Step 83: The road to Everlook: furs and horns
	-- {area:2255} Everlook
	["The road to {area:2255}: furs and horns"] = "",
	-- {area:2255} Everlook · {npc:9298} Donova Snowden
	-- plural, as words: Thick Yeti Furs = {item:12366} Thick Yeti Fur · Uncracked Chillwind Horns = {item:12444} Uncracked Chillwind Horn · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind · Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Still short of Thick Yeti Furs or Uncracked Chillwind Horns? The Rogue Ice Thistles and the Fledgling Chillwinds (both 53-55) live along the road west of {area:2255}, toward {npc:9298}. The hills east of {area:2255} hold only the Ice Thistle Yetis (55-56), Matriarchs and Patriarchs, and the Chillwind Chimaeras (55-57) and Ravagers (57-59): don't hunt the furs and horns there."] = "",

	-- Step 85: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Cuernos de yeti prístinos",
	["Check the two outdoor Matriarchs (56) on the western slope of the yetis' hills. Leave the Patriarchs (57) and the cave alone. If you don't get both horns on this pass, skip the hunt and Umi's hand-in."] = "",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Loot the horns from Ice Thistle Matriarchs"] = "",

	-- Step 86: Everlook
	-- {area:2255} Everlook · {area:976} Gadgetzan
	["Umi's next task scares three goblins in {area:2255}, {area:976} and Un'Goro, behind the route now: skip it."] = "",

	-- Step 87: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "El campamento de {npc:10301}",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	-- was: ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cabalga al sureste valle abajo hasta la caja dañada de {npc:10301}, en la nieve de {area:2245}, con su carro destrozado justo al este."
	["Ride south-east from {area:2255} down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 88: Sindrayl
	-- {zone:1452} Winterspring · {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:10897} Sindrayl · {area:2361} Nighthaven
	["Ride back north up the valley and west along the road to the tunnel at {zone:1452}'s western end, where Salfa stands. Walk into {area:1769} and take the {area:493} branch of the tunnel down to {area:493}. {npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn. The next guide flies on from here."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "Cualquier fúrbolg de aquí puede soltar un {item:12771} (más o menos uno de cada diez: sale entre las muertes que piden estas misiones) y un {quest:8471} (más o menos uno de cada treinta): haz clic derecho en el que caiga. Guarda el {item:14047} que sueltan los fúrbolgs para Meilosh.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "Vuelve a las colinas: solo las Matriarcas Cardo Nevado (56-57) y los Patriarcas (57-58) llevan los cuernos.\nCuidado: ve a por las Matriarcas del borde de las colinas, de una en una, y deja a los Patriarcas: los cuernos caen de ambos.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "Vuelve a las colinas: solo las Matriarcas Cardo Nevado y los patriarcas llevan los cuernos.",
	-- ["Back to {npc:11053} at {area:3197}."] = "Vuelve con {npc:11053} en {area:3197}.",
	-- ["Boat to {area:150}"] = "Barco a {area:150}",
	-- ["Fly to {area:271}"] = "Vuela a {area:271}",
	-- ["Fly to {area:3197}"] = "Vuela a {area:3197}",
	-- ["Follow the road east across the zone to the chapel."] = "Sigue el camino al este cruzando la zona hasta la capilla.",
	-- ["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Sigue el camino al oeste hasta el campamento de {npc:9298}, junto a las aguas termales.",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Sigue el camino del sur hacia el este hasta {area:139}; las ruinas de {area:2262} están al sur. El fantasma de {npc:10926} juega junto a la casa en ruinas del extremo sur.",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Sigue el camino del sur hacia el este hasta {zone:1423}; las ruinas de {area:2262} están al sur. El fantasma de {npc:10926} juega junto a la casa en ruinas del extremo sur.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Sigue las indicaciones de {npc:9298} hasta la entrada de {area:2256}, pasando a los gigantes Machacahielo: pásalos de uno en uno.",
	-- ["For Kernda in {area:1769}: keep it"] = "Para Kernda en {area:1769}: guárdalo",
	-- ["Free Darrowshire Spirits: talk to them"] = "Libera espíritus de Villa Darrow ({npc:11064}): habla con ellos",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Los yetis Cardo Nevado viven en las colinas al sur de {area:2244}, y las Quimeras venfresco en el valle hacia {area:2255}.",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "Los yetis Cardo Nevado viven en las colinas al sur de {area:2244}, y las Quimeras Viento Gélido en el valle hacia {area:2255}.\nCuidado: los Yetis Cardo Nevado son de nivel 55-56 y las Quimeras de 55-57: ve a por los Cardos Nevados huidos (53-55) y los Volantones Viento Gélido (53-55) del borde de las colinas, y deja en paz a los Devastadores Viento Gélido (57-59).",
	-- ["Inside"] = "Dentro",
	-- ["Into {zone:1423}"] = "Hacia {zone:1423}",
	-- ["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "Sus tarros se llenan en la visita a Un'Goro de la guía de {zone:1451}: guárdalo",
	-- ["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Guárdalo: Gregan, en {zone:1444}, prepara el elixir más adelante",
	-- ["Level 55 at {area:2246}"] = "Nivel 55 en {area:2246}",
	-- ["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "Sal del campamento hacia el noroeste hasta {area:199}, al oeste de Andorhal: {npc:11075} (53) guarda la caldera entre los Necrófagos farfullantes (54).",
	-- ["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "En el camino al este de {area:3197}, la granja de {npc:10927} está en {area:197}: su misión {quest:5142} lleva al mismo fantasma de {area:2262}.",
	-- ["On {npc:10978}, by the inn"] = "Sobre {npc:10978}, junto a la posada",
	-- ["Optional: {area:1417}"] = "Opcional: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Recoge los suministros alrededor del carro y recupera el amuleto de {npc:10301} de las lechubestias cercanas.",
	-- ["Pristine Yeti Horns"] = "Cuernos de yeti prístinos",
	-- ["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Puracorazón, Dumah, Puño de Valor y MacDonnell están por el centro del campamento, junto al maestro de vuelo.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cabalga al norte hasta {area:2627}. {npc:12384} vive en la choza en ruinas y su libro de recibos está en la posada en ruinas cercana.",
	-- ["Ride north-west back to the village."] = "Cabalga al noroeste de vuelta al pueblo.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cabalga al sureste valle abajo hasta la caja dañada de {npc:10301}, en la nieve de {area:2245}, con su carro destrozado justo al este.",
	-- ["Ride west along the road to the night elf village."] = "Cabalga al oeste por el camino hasta el pueblo de los elfos de la noche.",
	-- ["Ride west along the road to {npc:10301}."] = "Cabalga al oeste por el camino hasta {npc:10301}.",
	-- ["Scare {npc:10978} with {item:12928}"] = "Asusta a {npc:10978} con {item:12928}",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "¿No llegas al nivel 54 después de los yetis? Hacer {area:1417} (50-54) en grupo en vez de matar enemigos te lleva allí más rápido. Después vuelve a {area:2255}.",
	-- ["The Deadwood cauldron in {zone:1448}: keep it"] = "El caldero Muertobosque de {zone:1448}: guárdalo",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "La Plaga alrededor de {area:2264}, al oeste de la capilla, suelta ambos tipos de Piedra de la Plaga; de ellos surgen espíritus de Villa Darrow: habla con cada uno para liberarlo.\nCuidado: {npc:10411} se vuelve invisible fuera de combate y llama a gárgolas Alarroca en cuanto empieza el combate. Solo hay 3 y reaparecen cada 15 min.",
	-- ["The Winterfall camp"] = "El campamento Nevada",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "El poblado de los fúrbolgs Nevada está al este de {area:2255}: chamanes (56-57), vigilantes del cubil (55-56) y ursas (57-58), todos por encima de ti. Mata primero a los chamanes, que curan, y atrae desde el borde. {npc:10738}, en la cueva del fondo, es élite: no entres.",
	-- ["The next guide starts here and flies to {area:3197}."] = "La siguiente guía empieza aquí y vuela a {area:3197}.",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Las ruinas rodean el lago helado al sur de {area:2253}. Recoge los cuatro fragmentos de reliquia que hay en las ruinas y las Plumas Lunadón del suelo, donde merodean los lechúcicos.",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Las tres piezas de la muñeca están en las casas en ruinas de {area:2262}; al recoger una pueden aparecer fantasmas. Combínalas para formar la muñeca.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "El campamento Nevada del oeste está en las colinas entre {npc:11556} y {npc:9298}. Cualquier fúrbolg de aquí puede soltar un {item:12771} (más o menos uno de cada diez) y, rara vez, un {quest:8471}: haz clic derecho en el que caiga. Guarda el {quest:6031} que sueltan los fúrbolgs para Meilosh.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "El campamento Nevada del oeste está en las colinas entre {npc:11556} y {npc:9298}. Sube primero aquí hasta el nivel 55 con sus Exploradores (53-54) en el borde del campamento: los Vigías de la guarida del interior son de nivel 55-56. Matarlos aumenta tu reputación con los Fauces de Madera y te llena las bolsas de {item:14047} para Meilosh. O, si tienes grupo, haz {area:1584} o {area:2577}.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Los fúrbolgs Nevada del oeste sueltan las cuentas.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["To {zone:1455}"] = "A {zone:1455}",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "Sube aquí hasta el nivel 55.05 antes de las entregas en {area:2255}: te llevan al nivel 56. Mata a los fúrbolgs Nevada acampados junto a {area:2246} (Exploradores, Totémicos, Vigías de la guarida): matarlos aumenta tu reputación con los Fauces de Madera, que necesitan las misiones de aquí y el paso por {area:1769}; uno de ellos suelta el {quest:8471}, y te llenan las bolsas con los treinta paños rúnicos que pide Meilosh. O, si tienes grupo, haz {area:1584} o {area:2577}.",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Atraviesa {area:1769} hasta {zone:1448} y vuela hacia Reinos del Este ({area:442}, el barco a {area:150}). Vuela a {area:271} y cabalga al norte por el camino a través de Montañas de Alterac hasta {area:3197}.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Tu piedra de hogar no está vinculada en {zone:1455} (la guía de {zone:1425} te vincula allí a nivel 47, y esta guía sale de {zone:1452} pasando por allí): vincúlala en {area:2255}, para los viajes de vuelta al pueblo.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Tu piedra de hogar no está vinculada en {zone:1455} (la guía de {zone:1425} te vincula allí, y esta guía sale de {zone:1452} pasando por allí): vincúlala en {area:2255}, para los viajes de vuelta al pueblo.",
	-- ["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "Tu piedra de hogar sigue vinculada en {zone:1455}: desde allí, el grifo a {area:3197} es unos diez minutos más rápido que el vuelo de {area:2255} a Theramore y el barco.",
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr es élite: se recomienda ir en grupo. Espera al fondo de {area:2261}, la cripta del suroeste de la zona.",
	-- ["grind on {npc:7442}"] = "mata {npc:7442}",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "mata {npc:7460} en {area:2247}, {zone:1452}",
	-- ["{area:150} flight master"] = "Maestro de vuelo de {area:150}",
	-- ["{area:199} cauldron"] = "Caldera de {area:199}",
	-- ["{area:2247}: kill these as you meet them"] = "{area:2247}: mátalos según te los encuentres",
	-- ["{area:2255} flight master"] = "Maestro de vuelo de {area:2255}",
	-- ["{area:2255}'s inn"] = "La posada de {area:2255}",
	-- ["{area:489} flight master"] = "Maestro de vuelo de {area:489}",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, botín poco frecuente",
	-- ["{npc:10301}'s supplies"] = "Los suministros de {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}: guarda ambos para las Tierras de la Peste; dentro",
	-- ["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431}: guárdalo para las Tierras de la Peste; dentro",
	-- ["{npc:10926}'s doll"] = "La muñeca de {npc:10926}",
	-- ["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: guárdalo para {area:2262}",
	-- ["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} y {npc:10977} vienen después",
	-- ["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}: Zaeldarr es un élite de nivel 54",
	-- ["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "La siguiente tarea de {npc:11063}, en {area:2264}, está entre la Plaga de nivel 57-60: sáltala.",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} guarda la entrada de {area:1769}, al noroeste de {npc:9298}.",
	-- ["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} está justo en la salida a {zone:1452} del túnel de {area:1769}, por donde sales.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: las termitas vienen más tarde, en {area:2627}",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}: guárdalo para {area:2262}; dentro",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} es élite: se recomienda ir en grupo. Espera al fondo de {area:2261}, la cripta del suroeste de la zona.",
	-- ["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616} trabaja en {object:32356}: entrégale ahora los tarros de moco de {zone:1448}, de paso.",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, en {area:28}: guárdala",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, en {zone:1422}: guárdala",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, para Meilosh más adelante",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, botín poco frecuente",
	-- ["{zone:1455} flight master"] = "Maestro de vuelo de {zone:1455}",
	-- ["{zone:1455} inn"] = "Posada de {zone:1455}",
}
