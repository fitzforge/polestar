-- French (frFR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2255} Everlook · {zone:1448} Felwood · {zone:1452} Winterspring
	["{area:2255} first, then Un'Goro, then {zone:1448} and {zone:1452} again."] = "D'abord {area:2255}, puis Un'Goro, puis de nouveau {zone:1448} et {zone:1452}.",

	-- Step 1: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Prendre un vol pour {area:2255}",

	-- Step 2: Everlook
	-- {area:2255} Everlook · {npc:11754} Meggi Peppinrocker
	["The flight lands in {area:2255}: {npc:11754} and Umi stand around the town before you ride west."] = "",
	-- {npc:11754} Meggi Peppinrocker · {npc:9298} Donova Snowden · {area:2255} Everlook
	-- was: ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} se promène autour de {area:2255} : cherchez dans le cercle sur la carte"
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
	["{area:2246}: kill these as you meet them"] = "{area:2246} : tuez-les au passage",
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
	["Fly to {area:392}"] = "",

	-- Step 13: Fly to Theramore
	["Fly to Theramore"] = "Volez jusqu'à Theramore",

	-- Step 14: The Barrens
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "Depuis Theramore, chevauchez vers l'ouest dans {zone:1413}, puis vers le nord le long de la côte jusqu'à {area:392}.",

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
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan · {npc:9623} A-Me 01 · {quest:4243} Chasing A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{area:976}'s Auction House is the last one before Un'Goro. There, {npc:9623} ({quest:4243}) asks for a {item:10561}, an {skill:202} item, before her escort: buy one here if you want that chain."] = "L'hôtel des ventes de {area:976} est le dernier avant Un'Goro. Là, {npc:9623} ({quest:4243}) demande un {item:10561}, un objet d'{skill:202}, avant son escorte : achetez-en un ici si vous voulez cette chaîne.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro"] = "",

	-- Step 20: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir
	["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} est un fantôme au cimetière juste à l'est de la ville : buvez-y un {item:11243}, qui vous tue, libérez votre esprit et parlez-lui sous forme de fantôme. Ensuite, retournez à votre corps pour revenir à la vie : la pierre tombale se trouve tout près.",
	-- {npc:8737} Linken · {area:541} Marshal's Refuge
	["{npc:8737} in {area:541}, Un'Goro: keep it"] = "",

	-- Step 21: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Chevauchez vers le sud-ouest jusqu'au camp de {npc:7771}, à {area:1938}.",
	-- {npc:7771} Marvon Rivetseeker · {area:1417} Sunken Temple
	["{npc:7771}'s next task, Into the Depths, is inside the {area:1417}: skip it."] = "",

	-- Step 23: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Prendre un vol pour {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maître de vol de {area:976}",

	-- Step 24: Marshal's Refuge
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9999} Ringo · {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9618} Karna Remtravel
	["Fly from {area:976} to {area:541}. {npc:9997}'s friend {npc:9999} has gone missing; {npc:8737} stands at the back of the refuge, with {npc:9117} in the cave behind him; {npc:9618} stands just outside, on the way out east."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Le panneau en bois à côté de {npc:9997}",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, sous terre",
	-- {npc:9116} Eridan Bluewind · {zone:1448} Felwood
	["For {npc:9116} in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 25: Northern Pylon
	["Northern Pylon"] = "Pylône nord",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:6584} King Mosh
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}.\nCareful: {npc:6584} (60), a rare devilsaur, roams the crater's west around 27,46: if you meet him, ride away."] = "",

	-- Step 26: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Chevauchez vers l'est jusqu'à {area:1943}, où le robot se tient parmi les gorilles. N'entrez pas dans la grotte profonde.",
	["Below ground"] = "Sous terre",

	-- Step 27: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau
	["{area:1943}: kill these as you meet them"] = "{area:1943} : tuez-les au passage",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Les gorilles vivent sur le {area:1943}, juste à l'est du pylône : prenez dès maintenant les peaux pour {npc:9619}, tant que vous êtes là-haut. Évitez la grotte la plus profonde : {npc:9622} est de niveau 55.\nAttention : les Gorilles d'Un'Goro (niveau 50-51) appellent à l'aide leurs alliés à moins de 20 m dès qu'ils tombent à 25 % de vie. Il y a dans la zone une grotte pleine de singes, et y combattre attire beaucoup de renforts.",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478} ; sous terre",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479} ; sous terre",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480} ; sous terre",

	-- Step 29: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538} : tuez-les au passage",
	-- {area:538} Lakkari Tar Pits
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Les Bêtes du goudron et les Seigneurs du goudron se vautrent dans les {area:538}, au sud du refuge, sur le chemin qui descend dans le cratère.",

	-- Step 30: The crater
	["The crater"] = "Le cratère",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Les Bêtes du goudron se vautrent dans les {area:538} ; les élémentaires de feu de la {area:537}, au centre, portent la cendre ; les guêpes Gorishi de la {area:540}, au sud, portent la glande. Toutes les créatures du cratère peuvent laisser tomber de la {item:11018}.\nAttention : les Ouvriers Gorishi qui passent sous 45 % de vie ont 50 % de chances d'appeler à l'aide leurs alliés à moins de 25 m.",

	-- Step 31: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619} campe au pied de la rampe qui descend dans le cratère.",
	-- {quest:4291} The Scent of Lar'korwi
	["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, si vous l'avez encore depuis la première visite",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "Les peaux viennent des gorilles de {area:1943}",
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, si un ravasaure a laissé tomber l'écaille depuis la première visite",

	-- Step 32: Damaged Blue Crystal
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "Le {item:280417} se trouve à courte distance à l'ouest du camp de {npc:9619}.",

	-- Step 35: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Les gorilles vivent sur le {area:1943}, à l'est de {area:541}. Gardez leurs peaux pour {npc:9619}. Évitez la grotte la plus profonde : {npc:9622} est de niveau 55.\nAttention : les Gorilles d'Un'Goro (niveau 50-51) appellent à l'aide leurs alliés à moins de 20 m dès qu'ils tombent à 25 % de vie. Il y a dans la zone une grotte pleine de singes, et y combattre attire beaucoup de renforts.",

	-- Step 37: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Chevauchez vers le nord par le côté est jusqu'au plateau des gorilles. {npc:9622}, un gorille de niveau 55, se tient dans sa grotte la plus profonde : éliminez d'abord les gorilles de l'entrée.",

	-- Step 38: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there.\nCareful: {npc:9684} is level 56, a level or two over you here: start at full health, and clear the raptors around the lair first."] = "",

	-- Step 39: Eastern Pylon and the crate
	["Eastern Pylon and the crate"] = "Pylône est et la caisse",
	-- {npc:9684} Lar'korwi · {item:11113} Crate of Foodstuffs
	["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "Le pylône se dresse sur les falaises est au-dessus du repaire de {npc:9684} ; la {item:11113} de l'expédition se trouve au camp abandonné dans la jungle est.",

	-- Step 40: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Traversez le sud du cratère jusqu'à {npc:9619}, près de la rampe.",

	-- Step 41: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942} : tuez-les au passage",

	-- Step 42: The Gorishi hive
	["The Gorishi hive"] = "La ruche Gorishi",
	["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "Allez vers l'ouest le long du sud du cratère : la ruche gorishi l'occupe. Utilisez la fiole à grattage sur un couvoir, une salle aux larves suspendues.",

	-- Step 43: Bones and equipment
	["Bones and equipment"] = "Os et équipement",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle.\nCareful: Gruff (57), a rare devilsaur, prowls the south around 38,75: if you meet him, ride away."] = "",

	-- Step 44: Western Pylon
	["Western Pylon"] = "Pylône ouest",
	["The pylon stands on the western cliffs."] = "Le pylône se dresse sur les falaises ouest.",

	-- Step 45: Krakle
	-- {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["North-east from the pylon to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 46: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Chevauchez vers l'est jusqu'à {area:537}, gravissez-la et utilisez {npc:10541} sur les évents de lave près du sommet.",

	-- Step 47: Krakle
	-- {npc:10302} Krakle
	["Back west to {npc:10302} at the hot springs."] = "",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}, later in this guide: keep it"] = "",

	-- Step 48: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} est assis sur la pente sud-est de {area:537}, au milieu du cratère.",

	-- Step 49: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escortez {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Menez {npc:9999} vers le nord jusqu'au {area:541}. Quand il s'évanouit, utilisez {item:11804} sur lui pour le réveiller.",

	-- Step 51: Fly to Gadgetzan
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "",

	-- Step 52: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen · {area:540} Slithering Scar
	["Pestlezugg's next task, Pawn Captures Queen, sends you back to the {npc:10041} in the {area:540}: skip it."] = "",

	-- Step 54: Liv Rizzlefix
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, à l'intérieur",

	-- Step 55: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Prendre un vol pour {area:415}",

	-- Step 56: Felwood
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Chevauchez vers le nord en quittant {area:415} pour entrer dans le {zone:1448}, jusqu'au {area:2479}, le camp des druides au bord de la route.",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 57: Eridan Bluewind
	-- {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary
	["{npc:9116} stands inside, in the {area:2479}."] = "{npc:9116} se tient à l'intérieur, dans {area:2479}.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, à l'intérieur",

	-- Step 58: The Emerald Sanctuary
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {area:2253} Starfall Village
	["{npc:10924}: for {npc:11079} in {area:2253}, later in this guide; keep it"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Patientez un instant pour {npc:9116}",
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
	["{object:176159}, below ground"] = "{object:176159}, sous terre",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}, sous terre",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}, sous terre",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}, sous terre",
	-- {item:11515} Corrupted Soul Shard · {npc:9528} Arathandris Silversky
	["{item:11515}, from the same cultists: {npc:9528} takes six by the Sanctuary if you did Cleansing Felwood"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}, dans sa cellule ; sous terre",

	-- Step 60: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "Faites-la sortir de {area:1770} et gardez-la en vie jusqu'à ce qu'elle soit hors de la grotte : dégagez d'abord le chemin du retour.",

	-- Step 62: Greta Mosshoof: A Final Blow
	-- {quest:5242} A Final Blow · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold
	["{quest:5242} is a group quest at this level: {npc:9861} (52), {npc:9860} (54) and {npc:9517} (57) fight together at the back of {area:1770}. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "",

	-- Step 63: Rakaiah
	-- {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Back into {area:1770}: the succubus {npc:9518} (56) waits on the way to its deepest chamber, with Trey Lightforge's remains beside her.\nCareful: {npc:9518} is level 56: clear the cultists around her first and fight her at full health."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}, sous terre",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}, sous terre",

	-- Step 64: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["{npc:9861} and {npc:9860} guard {npc:9517} in {area:1770}'s deepest chamber, just past {npc:9518}.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}, sous terre",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}, sous terre",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517} ; sous terre",

	-- Step 65: The Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "Retournez vers le sud-est jusqu'au Sanctuaire.",

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
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558} : se promène ici : cherchez à l'intérieur du cercle sur la carte",

	-- Step 71: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557} ; sous terre",

	-- Step 72: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Vers {zone:1452}",
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
	["The {quest:5086}"] = "Les {quest:5086}",

	-- Step 75: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "Attention : des Anciens marcheurs Bois-de-fer, des élites de niveau 59, se tiennent parmi les {quest:5086} : attaquez les Horreurs à la pointe nord-est du camp (vers 50.6,22.4), une à la fois, et cherchez un marcheur des yeux avant chaque attaque.",

	-- Step 76: Winterspring
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["Back north through {area:1769}'s tunnel to {npc:9298}."] = "",

	-- Step 78: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452} : tuez-les au passage",
	-- {quest:5087} Winterfall Runners · {area:2246} Frostfire Hot Springs · {zone:1448} Felwood · {spell:5384} Feign Death
	["The {quest:5087} (57) carry their crates along the road between {area:2246} and {zone:1448}'s tunnel.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest.\nCareful: the {quest:5087} are 57, over you here: pull one at a time, away from the camp."] = "",

	-- Step 80: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Suivez la route vers l'est jusqu'à {area:2255}.",
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
	["Pristine Yeti Horns"] = "Cornes de yéti en parfait état ({item:12367})",
	["Check the two outdoor Matriarchs (56) on the western slope of the yetis' hills. Leave the Patriarchs (57) and the cave alone. If you don't get both horns on this pass, skip the hunt and Umi's hand-in."] = "",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Loot the horns from Ice Thistle Matriarchs"] = "",

	-- Step 86: Everlook
	-- {area:2255} Everlook · {area:976} Gadgetzan
	["Umi's next task scares three goblins in {area:2255}, {area:976} and Un'Goro, behind the route now: skip it."] = "",

	-- Step 87: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "Camp de {npc:10301}",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	-- was: ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Descendez la vallée vers le sud-est jusqu'à la caisse endommagée de {npc:10301} dans la neige à {area:2245}, son chariot détruit juste à l'est."
	["Ride south-east from {area:2255} down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 88: Sindrayl
	-- {zone:1452} Winterspring · {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:10897} Sindrayl · {area:2361} Nighthaven
	["Ride back north up the valley and west along the road to the tunnel at {zone:1452}'s western end, where Salfa stands. Walk into {area:1769} and take the {area:493} branch of the tunnel down to {area:493}. {npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn. The next guide flies on from here."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "Tout furbolg Tombe-hiver peut lâcher le totem, environ une victime sur trente : si le complément d'expérience ne vous en a pas donné, continuez à les tuer ici jusqu'à ce qu'il tombe, puis faites un clic droit dessus.",
	-- ["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "Tout furbolg ici peut lâcher un {item:12771} (environ un sur dix : il vient au fil des victimes que demandent ces quêtes) et un {quest:8471} (environ un sur trente) : faites un clic droit sur ce qui tombe. Gardez l'{item:14047} que lâchent les furbolgs pour Meilosh.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "Retour aux collines : seuls les Matriarches (56-57) et Patriarches (57-58) Chardon de glace portent les cornes.\nAttention : prenez les Matriarches en bordure des collines, une à la fois, et laissez les Patriarches : les cornes tombent sur les deux.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "Retournez dans les collines : seuls les Matriarches et Patriarches Chardon de glace portent les cornes.",
	-- ["Back to {npc:11053} at {area:3197}."] = "Retournez voir la {npc:11053} à {area:3197}.",
	-- ["Boat to {area:150}"] = "Bateau pour {area:150}",
	-- ["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Attention : {npc:10411} devient invisible hors combat et appelle des Gargouilles Aile-de-roc dès qu'un combat commence. Il n'en existe que 3 et ils réapparaissent toutes les 15 min.",
	-- ["Fly to {area:271}"] = "Prendre un vol pour {area:271}",
	-- ["Fly to {area:3197}"] = "Prendre un vol pour {area:3197}",
	-- ["Follow the road east across the zone to the chapel."] = "Suivez la route vers l'est à travers la zone jusqu'à la Chapelle de l'Espoir de Lumière.",
	-- ["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Suivez la route vers l'ouest jusqu'au camp de {npc:9298} Snowden, près des sources chaudes.",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Suivez la route du sud vers l'est jusqu'aux {area:139} ; les ruines de {area:2262} se trouvent au sud de celle-ci. Le fantôme de {npc:10926} joue près de la maison en ruine, à l'extrémité sud.",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Suivez la route du sud vers l'est jusqu'en {zone:1423} ; les ruines de {area:2262} sont au sud de la route. Le fantôme de {npc:10926} Redpath joue près de la maison en ruine, au bout sud.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Suivez les indications de {npc:9298} Snowden jusqu'à l'entrée de {area:2256}, après les Géants Cognegivre : passez-les un par un.",
	-- ["For Kernda in {area:1769}: keep it"] = "Pour Kernda à {area:1769} : gardez-le",
	-- ["Free Darrowshire Spirits: talk to them"] = "Libérez des Esprits de Darrowshire ({npc:11064}) : parlez-leur",
	-- ["Hearth to {area:2255}"] = "Pierre de foyer vers {area:2255}",
	-- ["Hearth to {area:2268}"] = "Pierre de foyer vers {area:2268}",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Les Yétis Chardon de glace vivent dans les collines au sud de {area:2244}, les Chimères Noroît dans la vallée vers {area:2255}.",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "Les yétis Chardon de glace vivent dans les collines au sud de {area:2244}, les Chimères Noroît dans la vallée vers {area:2255}.\nAttention : les Yétis Chardon de glace sont 55-56 et les Chimères 55-57 : prenez les Chardons de glace insoumis (53-55) et les Petites Noroît (53-55) en bordure des collines, et laissez tranquilles les Ravageurs Noroît (57-59).",
	-- ["Inside"] = "À l'intérieur",
	-- ["Into {zone:1423}"] = "Vers {zone:1423}",
	-- ["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "Ses bocaux se remplissent lors de la visite d'Un'Goro du guide de {zone:1451} : gardez-la",
	-- ["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Gardez-le : Gregan Brewspewer, en {zone:1444}, prépare l'élixir plus tard",
	-- ["Level 55 at {area:2246}"] = "Niveau 55 aux {area:2246}",
	-- ["Level 55.05"] = "Niveau 55.05",
	-- ["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "Sortez du camp vers le nord-ouest jusqu'à {area:199}, à l'ouest d'Andorhal : le {npc:11075} (53) garde le chaudron parmi les Goules jacassantes (54).",
	-- ["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "Sur la route vers l'est en sortant de {area:3197}, la ferme de {npc:10927} se dresse sur {area:197} : sa quête {quest:5142} mène au même fantôme à {area:2262}.",
	-- ["On the way"] = "En chemin",
	-- ["On {npc:10978}, by the inn"] = "Sur {npc:10978}, près de l'auberge",
	-- ["Optional: {area:1417}"] = "Facultatif : {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Ramassez les fournitures autour du chariot et reprenez l'amulette de {npc:10301} aux chouettards voisins.",
	-- ["Pristine Yeti Horns"] = "Cornes de yéti en parfait état",
	-- ["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Pureheart, Dumah, Valorfist et MacDonnell se tiennent vers le centre du camp, près du maître de vol.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Chevauchez vers le nord jusqu'à {area:2627}. {npc:12384} vit dans la cabane en ruine, et son livre de reçus est dans l'auberge en ruine voisine.",
	-- ["Ride north up the valley, past {area:2255}, to {area:2253}."] = "Remontez la vallée vers le nord, en passant {area:2255}, jusqu'à {area:2253}.",
	-- ["Ride north-west back to the village."] = "Retournez au village au nord-ouest.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Descendez la vallée vers le sud-est jusqu'à la caisse endommagée de {npc:10301} dans la neige à {area:2245}, son chariot détruit juste à l'est.",
	-- ["Ride west along the road to the night elf village."] = "Chevauchez vers l'ouest sur la route jusqu'au village elfe de la nuit.",
	-- ["Ride west along the road to {npc:10301}."] = "Chevauchez vers l'ouest sur la route jusqu'à {npc:10301} Stoneshaper.",
	-- ["Scare {npc:10978} with {item:12928}"] = "Effrayez {npc:10978} avec {item:12928}",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Pas encore niveau 54 après les yétis ? En groupe, faire {area:1417} (50-54) plutôt que tuer des monstres vous y amène plus vite. Revenez ensuite à {area:2255}.",
	-- ["The Deadwood cauldron in {zone:1448}: keep it"] = "Le Chaudron des Mort-bois en {zone:1448} : gardez-la",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Le Fléau autour de {area:2264}, à l'ouest de la chapelle, lâche les deux sortes de Pierres du Fléau ; des Esprits de Darrowshire en surgissent : parlez à chacun pour le libérer.\nAttention : {npc:10411} devient invisible hors combat et appelle des Gargouilles Aile-de-roc dès qu'un combat commence. Il n'en existe que 3, et elles réapparaissent toutes les 15 min.",
	-- ["The Winterfall camp"] = "Le camp Tombe-hiver",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "Le village des furbolgs Tombe-hiver s'étend à l'est de {area:2255} : Chamans (56-57), Protecteurs (55-56) et Ursa (57-58) Tombe-hiver, tous plus forts que vous. Tuez d'abord les Chamans, ils soignent, et attirez-les depuis la lisière. {npc:10738}, dans la grotte du fond, est élite : n'y allez pas.",
	-- ["The next guide starts here and flies to {area:3197}."] = "Le guide suivant commence ici et vole vers {area:3197}.",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Les ruines entourent le lac gelé au sud de {area:2253}. Ramassez les quatre fragments de relique dans les ruines et les Plumes de Chouettard lunaire au sol là où rôdent les Indomptables.",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Les trois morceaux de la poupée sont dans les maisons en ruine de {area:2262} ; en ramasser un peut faire surgir des fantômes. Assemblez-les pour obtenir la poupée.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "Le camp Tombe-hiver de l'ouest est dans les collines entre {npc:11556} et {npc:9298} Snowden. Chaque furbolg ici peut laisser {item:12771} (environ une fois sur dix) et, rarement, {quest:8471} : faites un clic droit sur ce qui tombe. Gardez {quest:6031} laissé par les furbolgs pour Meilosh.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}."] = "Le camp occidental des Tombe-hiver se trouve dans les collines entre {npc:11556} et {npc:9298}. Tout furbolg ici peut lâcher une {item:12771} (environ une sur dix : elle vient au fil des victimes que demandent ces quêtes) et un {quest:8471} (environ un sur trente : il vient au fil des compléments d'expérience) : faites un clic droit sur ce qui tombe. Gardez l'{item:14047} que lâchent les furbolgs pour Meilosh.\nLe reste du travail dans {zone:1452} est de niveau 55-58 : restez sur ce camp jusqu'au niveau 54, pour que vos premières victimes comptent aussi pour {npc:9298} et {npc:11556}.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "Le camp occidental des Tombe-hiver se trouve dans les collines entre {npc:11556} et {npc:9298}. Montez d'abord ici jusqu'au niveau 55 sur ses Guides (53-54) en bordure du camp : les Protecteurs de la tanière à l'intérieur sont 55-56. Les tuer augmente votre réputation auprès des Grumegueules et remplit vos sacs d'{item:14047} pour Meilosh. Ou, en groupe, faites plutôt {area:1584} ou {area:2577}.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Les furbolgs Tombe-hiver de l'ouest laissent les perles.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["To {zone:1455}"] = "Vers {zone:1455}",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56."] = "Montez ici jusqu'au niveau 55.05 avant de rendre les quêtes ({area:2255}) : elles vous font passer au niveau 56.",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for."] = "Montez ici jusqu'au niveau 55.05 avant de rendre les quêtes à {area:2255} : elles vous font passer au niveau 56. Tuez en boucle les furbolgs Tombe-hiver qui campent près de {area:2246} (Guides, Totémiques, Protecteurs) : les tuer augmente votre réputation auprès des Grumegueules, nécessaire pour les quêtes d'ici et la traversée de {area:1769}, l'un d'eux lâche le {quest:8471}, et ils remplissent vos sacs des trente Étoffes runiques que demande Meilosh.",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "Montez ici jusqu'au niveau 55.05 avant de rendre les quêtes à {area:2255} : elles vous font passer au niveau 56. Tuez en boucle les furbolgs Tombe-hiver qui campent près de {area:2246} (Guides, Totémiques, Protecteurs) : les tuer augmente votre réputation auprès des Grumegueules, nécessaire pour les quêtes d'ici et la traversée de {area:1769}, l'un d'eux lâche le {quest:8471}, et ils remplissent vos sacs des trente Étoffes runiques que demande Meilosh. Ou, en groupe, faites plutôt {area:1584} ou {area:2577}.",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Traversez {area:1769} jusqu'en {zone:1448} et poursuivez en vol vers les Royaumes de l'Est ({area:442}, puis le bateau pour {area:150}). Volez jusqu'à {area:271} et remontez la route vers le nord à travers Alterac jusqu'à {area:3197}.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Votre pierre de foyer n'est pas liée à {zone:1455} (le guide des {zone:1425} vous y lie au niveau 47, et ce guide quitte {zone:1452} par là) : liez-la plutôt à {area:2255}, pour les allers-retours en ville.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Votre Pierre de foyer n'est pas liée à {zone:1455} (le guide des {zone:1425} vous y lie, et ce guide quitte {zone:1452} par là) : liez-la plutôt à {area:2255}, pour les allers-retours en ville.",
	-- ["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "Votre pierre de foyer est toujours liée à {zone:1455} : de là, le griffon pour {area:3197} est environ dix minutes plus rapide que le vol de {area:2255} vers Theramore puis le bateau.",
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr le Banni est élite : il est conseillé de grouper. Il attend au fond de {area:2261}, la crypte au sud-ouest de la zone.",
	-- ["grind on {npc:11552}"] = "tuez en boucle : {npc:11552}",
	-- ["grind on {npc:7442}"] = "tuez en boucle : {npc:7442}",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "tuez des {npc:7460} à {area:2247}, {zone:1452}",
	-- ["{area:150} flight master"] = "Maître de vol de {area:150}",
	-- ["{area:199} cauldron"] = "Chaudron de {area:199}",
	-- ["{area:2247}: kill these as you meet them"] = "{area:2247} : tuez-les au passage",
	-- ["{area:2255} flight master"] = "Maître de vol de {area:2255}",
	-- ["{area:2255}'s inn"] = "Auberge de {area:2255}",
	-- ["{area:2269}: kill these as you meet them"] = "{area:2269} : tuez-les au passage",
	-- ["{area:489} flight master"] = "Maître de vol de {area:489}",
	-- ["{item:12367} along the way to {area:2255}"] = "{item:12367} sur le chemin de {area:2255}",
	-- ["{item:12367} on the way"] = "{item:12367} en chemin",
	-- ["{item:12383} on the way"] = "{item:12383} en chemin",
	-- ["{item:12383}, 110 yd north"] = "{item:12383}, à 110 mètres au nord",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, butin rare",
	-- ["{item:12886}; inside"] = "{item:12886} ; à l'intérieur",
	-- ["{item:12888}; inside"] = "{item:12888} ; à l'intérieur",
	-- ["{item:15785}; below ground"] = "{item:15785} ; sous terre",
	-- ["{npc:10301}'s supplies"] = "Fournitures de {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431} : gardez les deux pour les Maleterres",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431} : gardez les deux pour les Maleterres ; à l'intérieur",
	-- ["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431} : gardez-la pour les Maleterres ; à l'intérieur",
	-- ["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "{npc:10739} se tient près de la ferme du {area:202}, sur la route vers l'est menant aux {zone:1423}.",
	-- ["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "{npc:10838} : les tours de guet sont à Andorhal, gardez-la",
	-- ["{npc:10926}'s doll"] = "Poupée de {npc:10926}",
	-- ["{npc:10927}: keep it for {area:2262}"] = "{npc:10927} : gardez-la pour {area:2262}",
	-- ["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978} : {npc:7583} et {npc:10977} viennent plus tard",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, près des tombes au sud de la chapelle",
	-- ["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038} : Zaeldarr le Banni est un élite de niveau 54",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038} : {npc:12250} est un élite de niveau 54",
	-- ["{npc:11053}: the cauldron is at {area:200}, keep it"] = "{npc:11053} : le chaudron est à {area:200}, gardez-la",
	-- ["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "La tâche suivante de {npc:11063}, à {area:2264}, se déroule au milieu du Fléau de niveau 57-60 : passez-la.",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} garde l'entrée de {area:1769}, au nord-ouest de {npc:9298} Snowden.",
	-- ["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} se tient juste à la sortie du tunnel de {area:1769} côté {zone:1452}, là où vous débouchez.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616} : les termites viendront plus tard, à {area:2627}",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629} : gardez-la pour {area:2262}",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629} : gardez-la pour {area:2262} ; à l'intérieur",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} se promène autour de {area:2255} : cherchez dans le cercle sur la carte",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} est élite : il est conseillé de grouper. Il attend au fond du {area:2261}, la crypte au sud-ouest de la zone.",
	-- ["{npc:7440} along the way to {npc:9298}"] = "{npc:7440} sur le chemin de {npc:9298}",
	-- ["{npc:7441} along the way to {npc:9298}"] = "{npc:7441} sur le chemin de {npc:9298}",
	-- ["{npc:7442} along the way to {npc:9298}"] = "{npc:7442} sur le chemin de {npc:9298}",
	-- ["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616} travaille dans le {object:32356} : remettez-lui maintenant les bocaux de limon de {zone:1448}, en passant.",
	-- ["{object:175894}, inside"] = "{object:175894}, à l'intérieur",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, dans les {area:28} : gardez-la",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, en {zone:1422} : gardez-la",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, pour Meilosh plus tard",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, butin rare",
	-- ["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",
	-- ["{zone:1455} inn"] = "Auberge de {zone:1455}",
}
