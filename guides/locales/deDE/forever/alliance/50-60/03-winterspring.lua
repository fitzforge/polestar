-- German (deDE): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Flieg nach {area:2255}",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "Flugmeister von {area:489}",

	-- Step 2: Everlook
	-- {area:2255} Everlook · {npc:11754} Meggi Peppinrocker
	["The flight lands in {area:2255}: {npc:11754} and Umi stand around the town before you ride west."] = "",
	-- {npc:11754} Meggi Peppinrocker · {npc:9298} Donova Snowden · {area:2255} Everlook
	-- was: ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} läuft um {area:2255} umher: Schau in den Kreis auf der Karte"
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
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299}, at the graveyard just east of {area:976}, later in this guide"] = "",

	-- Step 5: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: Töte sie, wenn du ihnen begegnest",
	-- {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {item:14047} Runecloth · {npc:11557} Meilosh
	-- plural, as words: Winterfall Ritual Totems = {quest:8471} Winterfall Ritual Totem
	["The western Winterfall camp sits in the hills between {npc:9298} and the tunnel. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need): right-click it. They also drop Winterfall Ritual Totems (about one in thirty) and {item:14047}, which only matter if you are Neutral (the totem) or Friendly ({npc:11557}'s {item:14047}) with the Timbermaw: keep them then.\nCareful: the Pathfinders are 53 and the Totemics 54, but the Den Watchers inside the camp are 55: take the camp from its edge and pull one at a time."] = "",
	-- {item:14047} Runecloth · {npc:11557} Meilosh
	["{item:14047}, for {npc:11557}, if you are Friendly with the Timbermaw"] = "",

	-- Step 6: Winterfall Ritual Totem
	-- {npc:11558} Kernda
	["{npc:11558} takes the totem; the quest needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["For {npc:11558} in {area:1769}, later in this guide: keep it"] = "",

	-- Step 7: Donova Snowden
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	["The Deadwood cauldron in {area:1762}, at the {zone:1448} end of the tunnel"] = "",

	-- Step 8: Felwood
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden · {zone:1448} Felwood
	["Through {area:1769}'s tunnel, just north of {npc:9298}, to {zone:1448}."] = "",
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{area:1769}, {zone:1448} side"] = "",

	-- Step 9: Deadwood Cauldron
	-- {area:1762} Felpaw Village
	["The Deadwood cauldron stands at the top of {area:1762}, just west of the cave mouth."] = "",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298}, on this guide's {zone:1452} loop: keep it"] = "",

	-- Step 10: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride south from the cave to {area:1998}, the night elves' camp on the road."] = "",

	-- Step 11: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Flieg nach {area:392}",

	-- Step 12: Fly to Theramore
	["Fly to Theramore"] = "Flieg nach Theramore",

	-- Step 13: The Barrens
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "Reite von Theramore nach Westen in {zone:1413} und die Küste nach Norden hinauf bis {area:392}.",

	-- Step 14: Ratchet
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: the ash is in Un'Goro; inside"] = "",

	-- Step 15: The Stone Circle
	-- {quest:3444} The Stone Circle
	["{quest:3444} stands on the hill just south-west of the flight master."] = "",

	-- Step 16: Islen Waterseer
	-- {npc:5901} Islen Waterseer
	["{npc:5901} stands on the coast south-east of town."] = "",
	-- {zone:1448} Felwood
	["For Greta in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 17: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Flugmeister in {area:392}",

	-- Step 18: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, drinnen",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro"] = "",

	-- Step 19: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir
	["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} ist ein Geist auf dem Friedhof direkt östlich der Stadt: Trink dort ein {item:11243}, das dich tötet, lass deinen Geist frei und sprich als Geist mit ihm. Lauf dann zurück zu deinem Körper, um wiederbelebt zu werden: Der Grabstein steht in der Nähe.",
	-- {npc:8737} Linken · {area:541} Marshal's Refuge
	["{npc:8737} in {area:541}, Un'Goro: keep it"] = "",

	-- Step 20: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Reite nach Südwesten zum Lager von {npc:7771} bei {area:1938}.",
	-- {npc:7771} Marvon Rivetseeker · {area:1417} Sunken Temple
	["{npc:7771}'s next task, Into the Depths, is inside the {area:1417}: skip it."] = "",

	-- Step 22: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Flieg nach {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Flugmeister von {area:976}",

	-- Step 23: Marshal's Refuge
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9999} Ringo · {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9618} Karna Remtravel
	["Fly from {area:976} to {area:541}. {npc:9997}'s friend {npc:9999} has gone missing; {npc:8737} stands at the back of the refuge, with {npc:9117} in the cave behind him; {npc:9618} stands just outside, on the way out east."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, unter der Erde",
	-- {npc:9116} Eridan Bluewind · {zone:1448} Felwood
	["For {npc:9116} in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 24: Northern Pylon
	["Northern Pylon"] = "Nördlicher Kristallpylon",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:6584} King Mosh
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}.\nCareful: {npc:6584} (60), a rare devilsaur, roams the crater's west around 27,46: if you meet him, ride away."] = "",

	-- Step 25: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Reite nach Osten zum {area:1943}, wo der Roboter zwischen den Gorillas steht. Bleib dort aus der tiefen Höhle fern.",
	["Below ground"] = "Unter der Erde",

	-- Step 26: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau
	["{area:1943}: kill these as you meet them"] = "{area:1943}: Töte diese, wenn du ihnen begegnest",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Die Gorillas leben auf dem {area:1943}, gleich östlich des Pylons: Sammle die Felle für {npc:9619} jetzt, solange du hier oben bist. Halte dich von der tiefsten Höhle fern: {npc:9622} ist Stufe 55.\nVorsicht: Un'Goro-Gorillas (Stufe 50-51) rufen Verbündete im Umkreis von 20 Metern zu Hilfe, sobald sie auf 25 % Gesundheit fallen. In der Gegend gibt es eine Höhle voller Affen, und Kämpfe dort ziehen viele zusätzliche Gegner an.",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478}; unterirdisch",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479}; unterirdisch",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480}; unterirdisch",

	-- Step 28: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: Töte sie, wenn du ihnen begegnest",
	-- {area:538} Lakkari Tar Pits
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Die Teerbestien und Teerlords suhlen sich in den {area:538}, südlich der Zuflucht auf dem Weg hinab in den Krater.",

	-- Step 29: The crater
	["The crater"] = "Der Krater",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Tar Beasts suhlen sich im {area:538}; die Feuerelementare von {area:537} in der Mitte tragen die Asche; die Gorishi-Wespen des {area:540} im Süden tragen die Drüse. Jede Kreatur im Krater kann {item:11018} fallen lassen.\nVorsicht: Gorishi Workers, die unter 45 % Gesundheit fallen, rufen mit 50 % Wahrscheinlichkeit Verbündete in 25 yd Umkreis zu Hilfe.",

	-- Step 30: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619} lagert am Fuß der Rampe in den Krater.",
	-- {quest:4291} The Scent of Lar'korwi
	["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, falls du sie noch vom ersten Besuch hast",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "Die Felle stammen von den Gorillas auf {area:1943}",
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, falls ein Ravasaurus seit dem ersten Besuch die Schuppe fallen gelassen hat",

	-- Step 31: Damaged Blue Crystal
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "Der {item:280417} liegt ein kurzes Stück westlich von {npc:9619}s Lager.",

	-- Step 34: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Die Gorillas leben auf {area:1943}, östlich von {area:541}. Behalte ihre Felle für {npc:9619}. Halte dich aus der tiefsten Höhle fern: {npc:9622} ist Stufe 55.\nVorsicht: Un'Goro Gorillas (Stufe 50-51) rufen Verbündete in 20 yd Umkreis zu Hilfe, sobald sie auf 25 % Gesundheit fallen. In der Gegend gibt es eine Höhle voller Affen, und ein Kampf dort bringt viele Adds.",

	-- Step 36: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Reite an der Ostseite nach Norden zum Gorillaplateau. {npc:9622}, ein Gorilla der Stufe 55, sitzt in dessen tiefster Höhle: Säubere zuerst die Gorillas am Höhleneingang.",

	-- Step 37: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there.\nCareful: {npc:9684} is level 56, a level or two over you here: start at full health, and clear the raptors around the lair first."] = "",

	-- Step 38: Eastern Pylon and the crate
	["Eastern Pylon and the crate"] = "Östlicher Pylon und die Kiste",
	-- {npc:9684} Lar'korwi · {item:11113} Crate of Foodstuffs
	["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "Der Pylon steht auf den östlichen Klippen über dem Bau von {npc:9684}; die {item:11113} der Expedition steht im verlassenen Lager im östlichen Dschungel.",

	-- Step 39: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Durchquere den Süden des Kraters zu {npc:9619} an der Rampe.",

	-- Step 40: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}: Töte sie, wenn du ihnen begegnest",

	-- Step 41: The Gorishi hive
	["The Gorishi hive"] = "",
	["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "Nach Westen am Südrand des Kraters entlang: Der Gorishi-Bau füllt ihn. Benutze die Schabphiole an einer Brutstätte, einer Kammer mit hängenden Larven.",

	-- Step 42: Bones and equipment
	["Bones and equipment"] = "Knochen und Ausrüstung",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle.\nCareful: Gruff (57), a rare devilsaur, prowls the south around 38,75: if you meet him, ride away."] = "",

	-- Step 43: Western Pylon
	["Western Pylon"] = "Westlicher Kristallpylon",
	["The pylon stands on the western cliffs."] = "Der Pylon steht auf den westlichen Klippen.",

	-- Step 44: Krakle
	-- {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["North-east from the pylon to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 45: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Reite nach Osten zum {area:537}, klettere hinauf und benutze {npc:10541} an den Lavaschloten nahe dem Gipfel.",

	-- Step 46: Krakle
	-- {npc:10302} Krakle
	["Back west to {npc:10302} at the hot springs."] = "",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}, later in this guide: keep it"] = "",

	-- Step 47: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} sitzt am Südosthang des {area:537}, in der Mitte des Kraters.",

	-- Step 48: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 50: Fly to Gadgetzan
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Flugmeister in {area:541}",

	-- Step 51: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen · {area:540} Slithering Scar
	["Pestlezugg's next task, Pawn Captures Queen, sends you back to the {npc:10041} in the {area:540}: skip it."] = "",

	-- Step 53: Liv Rizzlefix
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, drinnen",

	-- Step 54: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Flieg nach {area:415}",

	-- Step 55: Felwood
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Reite von {area:415} nach Norden hinaus nach {zone:1448} zum {area:2479}, dem Lager der Druiden an der Straße.",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 56: The Emerald Sanctuary
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {area:2253} Starfall Village
	["{npc:10924}: for {npc:11079} in {area:2253}, later in this guide; keep it"] = "",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, drinnen",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Warte kurz auf {npc:9116}",
	-- {npc:9116} Eridan Bluewind · {npc:222647} Ancient Spirit · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1448} Felwood
	["{npc:9116}'s next task, {npc:222647}, ends with {npc:3848} at {area:2358}, south of the route once {zone:1448} is done: skip it."] = "",
	-- {npc:9116} Eridan Bluewind
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["{npc:9116}'s next task, Silver Heart, sends you to the Irontree Stompers in the north and back here: skip it."] = "",

	-- Step 57: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Kohlenbecken in {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns: pull at the edge of each group and fight one pack at a time.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "{object:176159}, unterirdisch",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}, unterirdisch",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}, unterirdisch",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}, unterirdisch",
	-- {item:11515} Corrupted Soul Shard · {npc:9528} Arathandris Silversky
	["{item:11515}, from the same cultists: {npc:9528} takes six by the Sanctuary if you did Cleansing Felwood"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}, in ihrer Zelle; unterirdisch",

	-- Step 58: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "Führ sie aus {area:1770} hinaus und halte sie am Leben, bis sie draußen vor der Höhle ist: Räume zuerst den Weg zurück.",

	-- Step 60: Greta Mosshoof: A Final Blow
	-- {quest:5242} A Final Blow · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold
	["{quest:5242} is a group quest at this level: {npc:9861} (52), {npc:9860} (54) and {npc:9517} (57) fight together at the back of {area:1770}. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "",

	-- Step 61: Rakaiah
	-- {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Back into {area:1770}: the succubus {npc:9518} (56) waits on the way to its deepest chamber, with Trey Lightforge's remains beside her.\nCareful: {npc:9518} is level 56: clear the cultists around her first and fight her at full health."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}, unterirdisch",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}, unterirdisch",

	-- Step 62: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["{npc:9861} and {npc:9860} guard {npc:9517} in {area:1770}'s deepest chamber, just past {npc:9518}.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}, unterirdisch",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}, unterirdisch",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517}; unterirdisch",

	-- Step 63: The Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "Reite zurück nach Südosten zum Refugium.",

	-- Step 64: Arathandris Silversky
	-- {npc:9528} Arathandris Silversky · {area:1770} Shadow Hold
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["{npc:9528} is in the ruins just down the road from the Sanctuary: he takes the six Corrupted Soul Shards (from both trips into {area:1770}) on the spot."] = "",

	-- Step 66: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Ride north up the road to the cave mouth of {area:1769}."] = "",

	-- Step 67: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["{npc:11558} stands just inside the {area:1769} cave: she needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: läuft hier umher: Schau in den Kreis auf der Karte",

	-- Step 69: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557}; unterirdisch",

	-- Step 70: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Nach {zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 71: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride on to {npc:9298}'s camp beside the hot springs."] = "",
	-- {quest:980} The New Springs · {area:2256} Darkwhisper Gorge
	["{quest:980}' follow-up, Strange Sources, is at {area:2256}'s mouth among elite giants and Hederine: skip it."] = "",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["The {quest:5086} are just back through the tunnel, in {zone:1448}"] = "",

	-- Step 72: Felwood
	-- {zone:1448} Felwood · {area:1998} Talonbranch Glade · {quest:5086} Toxic Horrors · {area:1767} Irontree Woods
	["Back through the tunnel to {zone:1448} and south past {area:1998}: the {quest:5086} (53) roam the north-eastern tip of {area:1767}."] = "",
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "{quest:5086}",

	-- Step 73: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "Vorsicht: Ancient Irontree Walkers, Elites der Stufe 59, stehen zwischen den {quest:5086}: Bekämpfe die Horrors an der Nordostspitze des Lagers (etwa 50.6,22.4) einzeln und halte vor jedem Pull nach einem Walker Ausschau.",

	-- Step 74: Winterspring
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["Back north through {area:1769}'s tunnel to {npc:9298}."] = "",

	-- Step 76: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452}: Töte sie, wenn du ihnen begegnest",
	-- {quest:5087} Winterfall Runners · {area:2246} Frostfire Hot Springs · {zone:1448} Felwood · {spell:5384} Feign Death
	["The {quest:5087} (57) carry their crates along the road between {area:2246} and {zone:1448}'s tunnel.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest.\nCareful: the {quest:5087} are 57, over you here: pull one at a time, away from the camp."] = "",

	-- Step 78: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Reite auf der Straße nach Osten nach {area:2255}.",
	-- {npc:11755} Harlo Wigglesworth · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village
	["{npc:11755}: for {npc:10301} in {area:2253}, just back up the road"] = "",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep it for the Plaguelands, on the next guide; inside"] = "",

	-- Step 79: Starfall Village
	-- {area:2253} Starfall Village · {npc:11079} Wynd Nightchaser · {npc:10301} Jaron Stoneshaper
	["Ride back north-west to {area:2253} on its hill: {npc:11079} and {npc:10301} stand together."] = "",
	-- {quest:5250} Starfall
	["The relics are in the ruins just south of {quest:5250}"] = "",

	-- Step 80: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village · {npc:10304} Aurora Skycaller · {zone:1423} Eastern Plaguelands
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins: {npc:10304} in the {zone:1423} takes them, on the next guide."] = "",

	-- Step 81: The road to Everlook: furs and horns
	-- {area:2255} Everlook
	["The road to {area:2255}: furs and horns"] = "",
	-- {area:2255} Everlook · {npc:9298} Donova Snowden
	-- plural, as words: Thick Yeti Furs = {item:12366} Thick Yeti Fur · Uncracked Chillwind Horns = {item:12444} Uncracked Chillwind Horn · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind · Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Still short of Thick Yeti Furs or Uncracked Chillwind Horns? The Rogue Ice Thistles and the Fledgling Chillwinds (both 53-55) live along the road west of {area:2255}, toward {npc:9298}. The hills east of {area:2255} hold only the Ice Thistle Yetis (55-56), Matriarchs and Patriarchs, and the Chillwind Chimaeras (55-57) and Ravagers (57-59): don't hunt the furs and horns there."] = "",

	-- Step 83: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Makellose Yetihörner",
	["Check the two outdoor Matriarchs (56) on the western slope of the yetis' hills. Leave the Patriarchs (57) and the cave alone. If you don't get both horns on this pass, skip the hunt and Umi's hand-in."] = "",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Loot the horns from Ice Thistle Matriarchs"] = "",

	-- Step 84: Everlook
	-- {area:2255} Everlook · {area:976} Gadgetzan
	["Umi's next task scares three goblins in {area:2255}, {area:976} and Un'Goro, behind the route now: skip it."] = "",

	-- Step 85: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}s Lager",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	-- was: ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Reite nach Südosten das Tal hinunter zu {npc:10301}s beschädigter Kiste im Schnee bei {area:2245}; sein zerstörter Wagen steht gleich östlich davon."
	["Ride south-east from {area:2255} down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 86: Sindrayl
	-- {zone:1452} Winterspring · {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:10897} Sindrayl · {area:2361} Nighthaven
	["Ride back north up the valley and west along the road to the tunnel at {zone:1452}'s western end, where Salfa stands. Walk into {area:1769} and take the {area:493} branch of the tunnel down to {area:493}. {npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn. The next guide flies on from here."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "Jeder Winterquell-Furbolg kann das Totem fallen lassen, etwa bei jedem dreißigsten Kill: Wenn der Grind keines gebracht hat, töte sie hier weiter, bis es fällt, und klicke es dann mit Rechtsklick an.",
	-- ["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "Jeder Furbolg hier kann ein {item:12771} (etwa bei jedem zehnten: Es kommt innerhalb der Kills, die diese Quests brauchen) und ein {quest:8471} (etwa bei jedem dreißigsten) fallen lassen: Klicke mit Rechtsklick an, was auch immer fällt. Behalte den {item:14047}, den die Furbolgs fallen lassen, für Meilosh.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "Zurück in die Hügel: Nur die Eisdistelmatriarchinnen (56-57) und -patriarchen (57-58) tragen die Hörner.\nVorsicht: Nimm die Matriarchinnen am Rand der Hügel einzeln und lass die Patriarchen in Ruhe: Die Hörner droppen bei beiden.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "Zurück in die Hügel: Nur die Ice Thistle Matriarchs und Patriarchs tragen die Hörner.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "Zurück in die Hügel: Nur die Eisdistelmatriarchinnen und Eisdistelpatriarchen tragen die Hörner. Töte weiter Yetis bis Stufe 54: Harlos Wildekinquests sind vorher rot.",
	-- ["Back to {npc:11053} at {area:3197}."] = "Zurück zu {npc:11053} im {area:3197}.",
	-- ["Boat to {area:150}"] = "Schiff nach {area:150}",
	-- ["Fly to {area:271}"] = "Flieg nach {area:271}",
	-- ["Fly to {area:3197}"] = "Flieg nach {area:3197}",
	-- ["Follow the road east across the zone to the chapel."] = "Folge der Straße nach Osten durch das Gebiet zur Kapelle.",
	-- ["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Folge der Straße nach Westen zu {npc:9298}s Lager neben den heißen Quellen.",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Folge der südlichen Straße nach Osten nach {area:139}; die Ruinen von {area:2262} liegen südlich davon. {npc:10926}s Geist spielt beim zerstörten Haus am Südende.",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Folge der südlichen Straße nach Osten nach {zone:1423}; die Ruinen von {area:2262} liegen südlich davon. {npc:10926}s Geist spielt beim zerstörten Haus am Südende.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Folge {npc:9298}s Wegbeschreibung zum Eingang von {area:2256}, vorbei an den Frosthagelriesen: Passiere sie einzeln.",
	-- ["For Kernda in {area:1769}: keep it"] = "Für Kernda in {area:1769}: behalten",
	-- ["Free Darrowshire Spirits: talk to them"] = "Befreie Geister von Darrowshire: Sprich mit ihnen",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Eisdistelyetis leben in den Hügeln südlich von {area:2244}, Eiswindschimären im Tal Richtung {area:2255}.",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "Eisdistelyetis leben in den Hügeln südlich von {area:2244}, Eiswindschimären im Tal Richtung {area:2255}.\nVorsicht: Die Eisdistelyetis sind 55-56 und die Schimären 55-57: Nimm die Wilden Eisdistelyetis (53-55) und die Eiswindjungen (53-55) am Rand der Hügel und lass die Eiswindverheerer (57-59) in Ruhe.",
	-- ["Inside"] = "Drinnen",
	-- ["Into {zone:1423}"] = "Nach {zone:1423}",
	-- ["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "Die Gefäße werden beim Besuch in Un'Goro im {zone:1451}-Guide gefüllt: Behalten",
	-- ["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Behalten: Gregan in {zone:1444} braut das Elixier später",
	-- ["Level 55 at {area:2246}"] = "Stufe 55 bei {area:2246}",
	-- ["Level 55.05"] = "Stufe 55,05",
	-- ["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "Nach Nordwesten aus dem Lager zu {area:199}, westlich von Andorhal: {npc:11075} (53) bewacht den Kessel zwischen den Plappernden Ghulen (54).",
	-- ["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "An der Straße nach Osten aus dem {area:3197} steht {npc:10927}s Bauernhaus auf {area:197}: Ihre Quest {quest:5142} geht an denselben Geist in {area:2262}.",
	-- ["On {npc:10978}, by the inn"] = "Bei {npc:10978}, am Gasthaus",
	-- ["Optional: {area:1417}"] = "Optional: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Sammle die Vorräte um den Wagen auf und hol dir {npc:10301}s Amulett von den Eulenbestien in der Nähe zurück.",
	-- ["Pristine Yeti Horns"] = "Makellose Yetihörner",
	-- ["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Reinherz, Dumah, Tapferfaust und MacDonnell stehen in der Mitte des Lagers, beim Flugmeister.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Reite nach Norden nach {area:2627}. {npc:12384} lebt in der zerstörten Hütte, sein Quittungsbuch liegt im zerstörten Gasthaus in der Nähe.",
	-- ["Ride north up the valley, past {area:2255}, to {area:2253}."] = "Reite das Tal nach Norden hinauf, an {area:2255} vorbei, bis {area:2253}.",
	-- ["Ride north-west back to the village."] = "Reite nach Nordwesten zurück ins Dorf.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Reite nach Südosten das Tal hinunter zu {npc:10301}s beschädigter Kiste im Schnee bei {area:2245}; sein zerstörter Wagen steht gleich östlich davon.",
	-- ["Ride west along the road to the night elf village."] = "Reite auf der Straße nach Westen zum Nachtelfendorf.",
	-- ["Ride west along the road to {npc:10301}."] = "Reite auf der Straße nach Westen zu {npc:10301}.",
	-- ["Scare {npc:10978} with {item:12928}"] = "Verscheuche {npc:10978} mit {item:12928}",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Nach den Yetis noch nicht Stufe 54? {area:1417} (50-54) in einer Gruppe statt Grinden bringt dich schneller dorthin. Kehr danach nach {area:2255} zurück.",
	-- ["The Deadwood cauldron in {zone:1448}: keep it"] = "Der Kessel der Totenwaldfelle in {zone:1448}: behalten",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "Die Geißel um {area:2264}, westlich der Kapelle, lässt beide Arten von Geißelsteinen fallen; aus ihnen erheben sich Geister von Darrowshire: Sprich mit jedem, um ihn zu befreien.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Die Geißel um {area:2264}, westlich der Kapelle, lässt beide Arten von Geißelsteinen fallen; Darrowshire Spirits steigen aus ihnen auf: Sprich jeden an, um ihn zu befreien.\nVorsicht: {npc:10411} wird unsichtbar, wenn er nicht im Kampf ist, und ruft Rockwing Gargoyles, sobald ein Kampf beginnt. Es gibt nur 3, und sie respawnen alle 15 Min.",
	-- ["The Winterfall camp"] = "Das Lager der Winterfelle",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "Das Furbolgdorf der Winterfelle liegt östlich von {area:2255}: Schamanen (56-57), Höhlenbehüter (55-56) und Ursas (57-58), alle über deiner Stufe. Töte zuerst die Schamanen, sie heilen, und lock vom Rand aus. {npc:10738} in der Höhle hinten ist Elite: Bleib draußen.",
	-- ["The next guide starts here and flies to {area:3197}."] = "Der nächste Guide beginnt hier und fliegt nach {area:3197}.",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "Die Ruinen liegen um den gefrorenen See südlich von {area:2253}. Sammle die vier Reliktfragmente in den Ruinen und die Mondbestrahlten Federn am Boden, wo die Wildekin umherstreifen.",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "Die drei Teile der Puppe liegen in den zerstörten Häusern von {area:2262}; beim Aufheben können Geister erscheinen. Füge sie zur Puppe zusammen.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "Das westliche Lager der Winterfelle liegt in den Hügeln zwischen {npc:11556} und {npc:9298}. Jeder Furbolg hier kann {item:12771} (etwa einer von zehn) und selten {quest:8471} fallen lassen: Rechtsklicke, was immer fällt. Behalte {quest:6031}, das die Furbolgs fallen lassen, für Meilosh.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}."] = "Das westliche Lager der Winterquell liegt in den Hügeln zwischen {npc:11556} und {npc:9298}. Jeder Furbolg hier kann einen {item:12771} fallen lassen (etwa bei jedem zehnten: Er kommt innerhalb der Kills, die diese Quests brauchen) und ein {quest:8471} (etwa bei jedem dreißigsten: Es kommt innerhalb der Grind-Runden): Klicke mit Rechtsklick an, was auch immer fällt. Behalte die {item:14047}, die die Furbolgs fallen lassen, für Meilosh.\nDie übrige Arbeit in {zone:1452} ist Stufe 55-58: Bleib bis Stufe 54 in diesem Lager, damit deine ersten Kills auch für {npc:9298} und {npc:11556} zählen.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "Das westliche Lager der Winterfelle liegt in den Hügeln zwischen {npc:11556} und {npc:9298}. Grinde hier zuerst bis Stufe 55 an den Pfadfindern (53-54) am Rand des Lagers: Die Höhlenwächter drinnen sind 55-56. Sie zu töten erhöht deinen Ruf bei den Holzschlundfeste-Furbolgs und füllt deine Taschen mit {item:14047} für Meilosh. Oder lauf mit einer Gruppe stattdessen {area:1584} oder {area:2577}.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Die westlichen Furbolgs der Winterfelle lassen die Perlen fallen.",
	-- ["The {area:2247}"] = "{area:2247}",
	-- ["To {zone:1455}"] = "Zum {zone:1455}",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for."] = "Grinde hier bis Stufe 55,05, bevor du bei {area:2255} abgibst: Das bringt dich auf Stufe 56. Grinde die Winterquell-Furbolgs am {area:2246} (Pathfinders, Totemics, Den Watchers): Sie zu töten erhöht deinen Ruf bei den Timbermaw, den die Quests hier und der Weg durch {area:1769} brauchen; einer von ihnen lässt das {quest:8471} fallen, und sie füllen deine Taschen mit den dreißig Runenstoffen, die Meilosh verlangt.",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "Grinde hier bis Stufe 55.05, bevor du in {area:2255} abgibst: Das bringt dich auf Stufe 56. Grinde die Furbolgs der Winterfelle bei {area:2246} (Pfadfinder, Totemiker, Höhlenwächter): Sie zu töten erhöht deinen Ruf bei den Holzschlundfeste-Furbolgs, den die Quests hier und der Weg durch {area:1769} brauchen; einer von ihnen lässt das {quest:8471} fallen, und sie füllen deine Taschen mit den dreißig Runenstoffen, die Meilosh verlangt. Oder lauf mit einer Gruppe stattdessen {area:1584} oder {area:2577}.",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Geh durch {area:1769} nach {zone:1448} und flieg weiter in die Östlichen Königreiche ({area:442}, das Schiff nach {area:150}). Flieg nach {area:271} und reite auf der Straße nach Norden durch das Alteracgebirge nach {area:3197}.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Dein Ruhestein ist nicht auf {zone:1455} gesetzt (der Guide für {zone:1425} bindet dich dort mit Stufe 47, und dieser Guide verlässt {zone:1452} darüber): Binde dich stattdessen in {area:2255}, für die Wege zurück in die Stadt.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Dein Ruhestein ist nicht auf {zone:1455} gesetzt (der Guide für {zone:1425} bindet dich dort, und dieser Guide verlässt {zone:1452} darüber): Binde dich stattdessen in {area:2255}, für die Wege zurück in die Stadt.",
	-- ["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "Dein Ruhestein ist noch auf {zone:1455} gesetzt: Von dort ist der Greif nach {area:3197} etwa zehn Minuten schneller als der Flug von {area:2255} nach Theramore und das Schiff.",
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr ist Elite: Eine Gruppe wird empfohlen. Er wartet ganz unten in {area:2261}, der Krypta im Südwesten des Gebiets.",
	-- ["grind on {npc:7442}"] = "Grinde an {npc:7442}",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "grinde {npc:7460} bei {area:2247}, {zone:1452}",
	-- ["{area:150} flight master"] = "Flugmeister von {area:150}",
	-- ["{area:199} cauldron"] = "Kessel im {area:199}",
	-- ["{area:2247}: kill these as you meet them"] = "{area:2247}: Töte sie, wenn du ihnen begegnest",
	-- ["{area:2255} flight master"] = "Flugmeister in {area:2255}",
	-- ["{area:2255}'s inn"] = "Gasthaus von {area:2255}",
	-- ["{item:12383}, 110 yd north"] = "{item:12383}, 110 yd nördlich",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, eine seltene Beute",
	-- ["{item:12886}; inside"] = "{item:12886}; drinnen",
	-- ["{item:12888}; inside"] = "{item:12888}; drinnen",
	-- ["{item:15785}; below ground"] = "{item:15785}; unterirdisch",
	-- ["{npc:10301}'s supplies"] = "{npc:10301}s Vorräte",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: beide für die Pestländer behalten",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}: Behalte beides für das Pestland; drinnen",
	-- ["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431}: Behalte es für die Pestländer; drinnen",
	-- ["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "{npc:10739} steht am Hof bei {area:202}, an der Straße nach Osten in die {zone:1423}.",
	-- ["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "{npc:10838}: Die Wachtürme sind in Andorhal, behalte es",
	-- ["{npc:10926}'s doll"] = "{npc:10926}s Puppe",
	-- ["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: Behalte es für {area:2262}",
	-- ["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} und {npc:10977} folgen später",
	-- ["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}: Zaeldarr ist ein Elite der Stufe 54",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} ist ein Elitegegner der Stufe 54",
	-- ["{npc:11053}: the cauldron is at {area:200}, keep it"] = "{npc:11053}: Der Kessel ist in {area:200}, behalte es",
	-- ["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "{npc:11063}s nächste Aufgabe bei {area:2264} liegt zwischen Geißel-Mobs der Stufe 57-60: Überspringe sie.",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: Der letzte Guide bindet dich hier, daher ist das meist sofort abgehakt",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} bewacht den Eingang von {area:1769}, nordwestlich von {npc:9298}.",
	-- ["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} steht direkt am Ausgang des Tunnels von {area:1769} nach {zone:1452}, wo du herauskommst.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: Die Termiten kommen später, im {area:2627}",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: für {area:2262} behalten",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}: Behalte es für {area:2262}; drinnen",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} läuft um {area:2255} umher: Schau in den Kreis auf der Karte",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} ist Elite: Eine Gruppe wird empfohlen. Er wartet ganz unten im {area:2261}, der Krypta im Südwesten des Gebiets.",
	-- ["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616} arbeitet in {object:32356}: Gib ihm jetzt auf dem Weg die Schlammgefäße aus {zone:1448}.",
	-- ["{object:175894}, inside"] = "{object:175894}, drinnen",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, in {area:28}: behalten",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, in {zone:1422}: behalten",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, später für Meilosh",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, eine seltene Beute",
	-- ["{zone:1455} flight master"] = "Flugmeister in {zone:1455}",
	-- ["{zone:1455} inn"] = "Gasthaus von {zone:1455}",
}
