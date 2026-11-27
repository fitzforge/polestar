-- German (deDE): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {zone:1428} Burning Steppes
	["Un'Goro first, then {area:340}, the {zone:1427} and the {zone:1428}."] = "Zuerst Un'Goro, dann {area:340}, {zone:1427} und {zone:1428}.",

	-- Step 2: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "Hinab in den {zone:1449}",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "Reite von der {area:1938} nach Westen zur langen Rampe, die sich in den {zone:1449} hinabwindet, und folge dann der Nordwand des Kraters nach {area:541}, einem Lager in den Klippenhöhlen. Alle hier sind neutral.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, hinten in der Höhle; unter der Erde",
	-- {npc:9997} Spraggle Frock · {npc:9167} Frenzied Pterrordax
	["the wooden sign beside {npc:9997}, by the flight master: the {npc:9167} (51-54) come on the pylon loop"] = "das Holzschild neben {npc:9997}, beim Flugmeister: Die {npc:9167} (51-54) kommen auf der Pylonenrunde",

	-- Step 3: Out of the refuge
	["Out of the refuge"] = "Raus aus der Zuflucht",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, am Eingang der Zuflucht",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, gleich draußen",
	-- {npc:271301} Power Crystal · {quest:3761} Un'Goro Soil · {quest:4496} Bungle in the Jungle
	["From here on pick up every {npc:271301} (blue, green, red, yellow) and every {quest:3761} pile you pass: 20 for Hamuul, and 5 more for Pestlezugg if you carry {quest:4496}."] = "Sammle ab jetzt jeden {npc:271301} (blau, grün, rot, gelb) und jeden Haufen {quest:3761} auf deinem Weg ein: 20 für Hamuul und 5 weitere für Pestlezugg, falls du {quest:4496} hast.",

	-- Step 4: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}. Careful: the Lurkers reach 54 and the Tar Lords stand among them: take the Tar Beasts (50-51) and Creepers (51-52)."] = "Die Teergruben liegen gleich südlich der Zuflucht. Teerbestien, Teerlauerer und Teerkriecher lassen {item:11834} fallen. Vorsicht: Die Lauerer erreichen Stufe 54 und die Teerfürsten stehen zwischen ihnen: Nimm die Teerbestien (50-51) und Kriecher (51-52).",

	-- Step 5: Pterrordax
	-- {npc:9166} Pterrordax · {npc:9998} Shizzle · {npc:9997} Spraggle Frock · {npc:9167} Frenzied Pterrordax
	["{npc:9166} (50-52) fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}, and {npc:9997}'s sign wants ten of them. Leave the {npc:9167} over the west for the pylon loop."] = "{npc:9166} (50-52) fliegen über den Osten des Kraters, von den Hängen unterhalb der Zuflucht nach Süden; ihre Schwimmhautschuppen sind für {npc:9998}, und das Schild von {npc:9997} will zehn davon. Lass die {npc:9167} im Westen für die Pylonenrunde.",

	-- Step 6: Power Crystals and soil
	-- plural, as words: Power Crystals = {npc:271301} Power Crystal
	["Power Crystals and soil"] = "Machtkristalle und Erde",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Die Kristallgruppen stehen überall im Krater, viele rund um den Ort {area:537}. Nimm von jeder Farbe ein paar mehr für die Pylonen mit.",

	-- Step 7: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: Töte sie, wenn du ihnen begegnest",
	-- {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:8659} Jes'rimon
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Dinosaur Bones = {item:11114} Dinosaur Bone · Elder Diemetradons = {npc:9164} Elder Diemetradon · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Dinosaur Bones lie on the ground among the Stegodons and drop from the Diemetradons nearby, which also carry the scales {npc:9998} wants. Careful: the Stegodons are elites (52-53): pick the bones up around them, don't pull them; the Elder Diemetradons are 53-55, take the smaller ones. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. Bloodpetal Trappers grow in the jungle there. Careful: the biggest Trappers are 53: pull them one at a time."] = "Reite nach Südwesten zu {area:537}, dem Vulkan in der Mitte des Kraters. Blutblütenschinder wachsen rund um seinen Fuß.\nSüdlich der heißen Quellen liegen Dinosaurierknochen zwischen den Stegodons am Boden und fallen von den Dimetrodons in der Nähe, die auch die Schuppen für {npc:9998} tragen. Vorsicht: Die Stegodons sind Elite (52-53): Sammle die Knochen um sie herum, zieh sie nicht; die Alten Dimetrodons sind 53-55, nimm die kleineren. Ravasaurier jagen im Südwesten in Rudeln: Ihre Klauen sind für {npc:8659}, und hin und wieder trägt einer ein Zerfleddertes Tagebuch (ein seltener Drop: Nimm die Quest nur an, wenn du eines bekommst). Meide Gruff, einen Stegodon der Stufe 57.\nReite nach Südwesten entlang der westlichen Klippen. Dort im Dschungel wachsen Blutblütenfallen. Vorsicht: Die größten Fallen sind Stufe 53: Zieh sie einzeln.",

	-- Step 8: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "Die verlorene Ausrüstung der Expedition liegt im südwestlichen Dschungel.",

	-- Step 9: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd. The Hive Guards (54) and the Queen stand inside the hive: work the Workers and Wasps outside it."] = "Vorsicht: Arbeiter der Gorishi, die unter 45% Gesundheit fallen, rufen mit 50% Wahrscheinlichkeit Verbündete im Umkreis von 25 yd zu Hilfe. Die Stockwachen (54) und die Königin stehen im Stock: Kümmere dich um die Arbeiter und Wespen draußen.",

	-- Step 11: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Stegodons und Ravasaurier",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, seltene Beute",
	["Use the Mangled Journal to start it"] = "Benutze Ein zerfleddertes Tagebuch, um sie zu starten",
	-- {item:280459} Crystal Infused Scale
	["{item:280459}, a rare drop from the ravasaurs and Diemetradons"] = "{item:280459}, ein seltener Drop von den Ravasauriern und Dimetrodons",
	-- {quest:87494} Microcrystal Contamination · {npc:9619} Torwa Pathfinder
	["Use the scale to start {quest:87494}, for {npc:9619}"] = "Benutze die Schuppe, um {quest:87494} für {npc:9619} zu starten",

	-- Step 12: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} lagert in der Südostecke des Kraters.",
	-- {npc:9619} Torwa Pathfinder · {quest:87492} Uncanny Crystal
	["{npc:9619}: {quest:87492}, a short ride west of his camp"] = "{npc:9619}: {quest:87492}, ein kurzer Ritt westlich seines Lagers",
	-- {npc:9619} Torwa Pathfinder · {quest:4289} The Apes of Un'Goro
	["{npc:9619}: {quest:4289}, the gorillas of the north-east plateau on the pylon loop"] = "{npc:9619}: {quest:4289}, die Gorillas auf dem nordöstlichen Plateau auf der Pylonenrunde",

	-- Step 13: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {quest:87494} Microcrystal Contamination
	["{npc:9619}: {quest:87494}, if the scale dropped"] = "{npc:9619}: {quest:87494}, falls die Schuppe gedroppt ist",

	-- Step 14: Fresh Threshadon Carcass
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["North of Torwa, a dead Threshadon lies by the water. The {item:280417} lies on the ground a short ride west of {npc:9619}'s camp."] = "Nördlich von Torwa liegt ein toter Threshadon am Wasser. Der {item:280417} liegt einen kurzen Ritt westlich des Lagers von {npc:9619} am Boden.",

	-- Step 16: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Lar'korwi-Weibchen",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "Die Lar'korwi-Weibchen streifen durch den Dschungel nordwestlich von {npc:9619}.",

	-- Step 17: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "Das Floß liegt am Ufer des südöstlichen Sees; das kleine Bündel liegt daneben im Wasser.",
	["Underwater"] = "Unter Wasser",

	-- Step 19: Lashers and Threshers
	["Lashers and Threshers"] = "Peitscher und Drescher",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Reite an der Ostseite nach Norden. Blutblütenpeitscher und -drescher füllen den Dschungel.",

	-- Step 20: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}: Töte sie, wenn du ihnen begegnest",
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "Die Kiste der Expedition steht in einem verlassenen Lager im östlichen Dschungel.",

	-- Step 21: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, am Eingang",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, unter der Erde",
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}, beside the flight master: {npc:9999} is found at the end of this loop"] = "{npc:9997}, neben dem Flugmeister: {npc:9999} findest du am Ende dieser Runde",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Behalte {quest:4147} von {npc:9118} und den Brief von {npc:8737} für spätere Guides.",

	-- Step 22: Northern Pylon
	["Northern Pylon"] = "Nördlicher Kristallpylon",
	["The pylon stands on the slope east of the refuge."] = "Der Pylon steht am Hang östlich der Zuflucht.",

	-- Step 23: Gorillas
	["Gorillas"] = "Gorillas",
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on the north-east plateau: {npc:9619} wants two pelts of each kind, and the Thunderers (52-53) are the biggest. Stay out of the deepest cave: {npc:9622} lives there."] = "Die Gorillas leben auf dem nordöstlichen Plateau: {npc:9619} will je zwei Felle jeder Art, und die Donnerer (52-53) sind die größten. Halte dich von der hintersten Höhle fern: Dort lebt {npc:9622}.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau; below ground"] = "{npc:9623}, der Roboter auf dem Plateau; unterirdisch",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "{npc:9623} will dann ein {item:10561}, einen Gegenstand aus {skill:202}. Überspringe das, außer du hast eins.",

	-- Step 24: Un'Goro Crater: kill these as you meet them
	-- {spell:8137} Silithid Pox · {spell:14120} Tunneler Acid
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast {spell:8137} and Tunnelers and the Hive Guard use {spell:14120}."] = "Vorsicht: Gorishi Workers rufen unter 45% Gesundheit möglicherweise Verbündete im Umkreis von 25 yd zu Hilfe; Silithiden wirken {spell:8137}, und die Tunnelers und die Hive Guards benutzen {spell:14120}.",

	-- Step 25: Eastern Pylon
	["Eastern Pylon"] = "Östlicher Kristallpylon",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Reite die Ostseite des Kraters hinab zum Pylon auf den östlichen Klippen.",

	-- Step 26: The Marshlands
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time."] = "Vorsicht: Hier streifen viele Ravasaurier umher, du ziehst also leicht mehrere gleichzeitig.",

	-- Step 27: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {area:1942} The Marshlands
	["{npc:9619}'s camp is in the south-east corner, a short ride from the {area:1942}."] = "Das Lager von {npc:9619} liegt in der Südostecke, ein kurzer Ritt von {area:1942} entfernt.",

	-- Step 29: Western Pylon
	["Western Pylon"] = "Westlicher Kristallpylon",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Durchquere den Süden des Kraters zum Pylon auf den westlichen Klippen.",

	-- Step 30: Frenzied Pterrordax: kill these as you meet them
	-- {npc:9167} Frenzied Pterrordax
	["{npc:9167}: kill these as you meet them"] = "{npc:9167}: Töte sie, wenn du ihnen begegnest",
	-- {npc:9167} Frenzied Pterrordax
	["The {npc:9167} fly over the western cliffs around the pylon. Careful: the biggest are 54: pull them one at a time."] = "Die Exemplare von {npc:9167} fliegen über den westlichen Klippen rund um den Pylon. Vorsicht: Die größten sind Stufe 54: Zieh sie einzeln.",

	-- Step 31: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Der Goblin {npc:10302} sitzt am Ort {area:543}, gleich östlich des Pylons.",

	-- Step 32: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	-- plural, as words: Living Blazes = {npc:6521} Living Blaze · Scorching Elementals = {npc:6520} Scorching Elemental
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}.\nCareful: Living Blazes (54-55) and Scorching Elementals (53-54) burn on the slopes: ride up the path and pull only what stands on it."] = "Reite nach Osten bis {area:537}, steig hinauf und nutze {npc:10541} am Lavaschlot nahe dem Gipfel, dann reite nach Westen zurück zu {npc:10302}.\nVorsicht: Lebende Flammen (54-55) und Versengende Elementare (53-54) brennen an den Hängen: reite den Pfad hoch und zieh nur, was darauf steht.",

	-- Step 33: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} schickt dich zu {npc:9298} in {zone:1452}: Behalte es.",

	-- Step 34: Ringo
	-- {area:537} Fire Plume Ridge · {npc:9999} Ringo
	["Ride east again to the foot of {area:537}: {npc:9999} sits on its eastern slope, lost and exhausted."] = "Reite wieder nach Osten zum Fuß von {area:537}: {npc:9999} sitzt an seinem östlichen Hang, verirrt und erschöpft.",

	-- Step 35: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Führ {npc:9999} nach Norden nach {area:541}. Wenn er ohnmächtig wird, benutze {item:11804} an ihm, um ihn zu wecken.",

	-- Step 36: J.D. Collie
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9117} J.D. Collie
	["{area:541}: {npc:9997} beside the flight master, {npc:9117} below ground."] = "{area:541}: {npc:9997} neben dem Flugmeister, {npc:9117} unter der Erde.",
	-- {npc:9997} Spraggle Frock
	["{npc:9997}, beside the flight master"] = "{npc:9997}, neben dem Flugmeister",
	["Below ground"] = "Unter der Erde",

	-- Step 37: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "Nach {area:976}",

	-- Step 38: Andi Lynn
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn · {area:983} Dunemaul Compound
	["The hearth lands in {area:976}: {npc:11758} takes the {area:983}."] = "Die Herd-Landstriche in {area:976}: {npc:11758} übernimmt den {area:983}.",

	-- Step 39: Tran'rek
	-- {npc:7876} Tran'rek
	["{npc:7876} stands beside the wind rider master."] = "{npc:7876} steht neben dem Windreiter-Meister.",

	-- Step 41: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, drinnen",

	-- Step 42: Orgrimmar
	-- {area:1637} Orgrimmar · {area:16727} Powderfuse Port · {zone:1458} Undercity
	["Fly to {area:1637} and train before the boat to {area:16727}: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Flieg nach {area:1637} und lerne bei den Lehrern, bevor du das Boot nach {area:16727} nimmst: Der Halt in {zone:1458} später in diesem Guide hat keinen Jäger- oder Schamanenlehrer.",

	-- Step 43: Back to Gadgetzan
	-- {area:976} Gadgetzan
	["Back to {area:976}"] = "Zurück nach {area:976}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 44: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Boot nach {area:16727}",
	-- {npc:9706} Yorba Screwspigot · {quest:4324} Yuka Screwspigot · {area:251} Flame Crest
	["{npc:9706}, by the dock: for {quest:4324} at {area:251}, later in this guide"] = "{npc:9706}, am Dock: für {quest:4324} in {area:251}, später in diesem Guide",

	-- Step 45: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {zone:1418} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {zone:1418}."] = "Verlasse {zone:2548} zu Fuß nach Nordwesten, nördlich von {area:16685}, in {zone:1418}.",

	-- Step 46: Kargath
	-- {area:340} Kargath · {zone:1418} Badlands
	["{area:340} is built into the cliffs on the {zone:1418}' west edge."] = "{area:340} ist in die Klippen am Westrand von {zone:1418} gebaut.",

	-- Step 47: Kargath's poster
	-- {area:340} Kargath
	["{area:340}'s poster"] = "{area:340}'s Poster",
	-- {area:1584} Blackrock Depths · {area:254} Blackrock Mountain · {area:340} Kargath
	["For your {area:1584} run, next, on the way through {area:254}: the WANTED poster in {area:340} wants the Anvilrage dwarves inside thinned out."] = "Für deinen nächsten {area:1584}-Durchlauf, auf dem Weg durch {area:254}: Das WANTED-Plakat in {area:340} verlangt, die Anvilrage-Zwerge drinnen zu dezimieren.",

	-- Step 48: Thunderheart
	-- {npc:9084} Thunderheart · {area:340} Kargath · {quest:3906} Disharmony of Flame · {npc:9026} Overmaster Pyron · {area:1584} Blackrock Depths · {area:254} Blackrock Mountain
	["{npc:9084} stands in {area:340} beside the Hierophant. His {quest:3906} is {npc:9026} (52, elite), at the {area:1584} portal inside {area:254}, on the way through the mountain: a fight for a group."] = "{npc:9084} steht in {area:340} neben dem Hierophanten. Seine {quest:3906} ist {npc:9026} (52, Elite), am Portal von {area:1584} innerhalb von {area:254}, auf dem Weg durch den Berg: ein Kampf für eine Gruppe.",

	-- Step 49: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "In die {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["Take the pass out of {area:340}'s west side into the {zone:1427} and ride west to {npc:8479}, on the rim of the Cauldron south of {area:1446}."] = "Nimm den Pass aus dem Westen von {area:340} in den {zone:1427} und reite nach Westen zu {npc:8479}, am Rand des Kessels südlich von {area:1446}.",

	-- Step 51: The Flame's Casing
	-- {npc:8479} Velarok Windblade · {item:10552} Symbol of Ragnaros
	["The Twilight's Hammer cultists camp in the hills west of {npc:8479}. The {item:10552} drops from their Dark Shamans (47-48), Fire Guards (48-49) and Geomancers (49-50): elites, but two to five levels under you now, so one at a time is fine. The Idolaters (49-51) at the altar further north drop it too, more rarely: leave them alone."] = "Die Kultisten des Twilight's Hammer lagern in den Hügeln westlich von {npc:8479}. Der {item:10552} fällt von ihren Dark Shamans (47-48), Fire Guards (48-49) und Geomancers (49-50): Eliten, aber jetzt zwei bis fünf Stufen unter dir, also reicht einzeln. Die Idolaters (49-51) am Altar weiter nördlich lassen ihn ebenfalls fallen, seltener: Lass sie in Ruhe.",

	-- Step 53: The Torch of Retribution
	-- {npc:8479} Velarok Windblade
	["Listen to {npc:8479}'s story once more."] = "Hör dir die Geschichte von {npc:8479} noch einmal an.",

	-- Step 54: Velarok Windblade
	-- {quest:3453} The Torch of Retribution · {npc:8479} Velarok Windblade · {quest:3462} Squire Maltrake
	["{quest:3453} lies on the ground at {npc:8479}'s feet; {quest:3462} stands beside him."] = "{quest:3453} liegt zu Füßen von {npc:8479} auf dem Boden; {quest:3462} steht neben ihm.",

	-- Step 55: Sentry Braziers
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Sentry Braziers"] = "Wachkohlenbecken",
	-- {object:149047} Torch of Retribution
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Carry the {object:149047} south along the rim of the Cauldron and light the four Sentry Braziers, from the south-west round to the east."] = "Trage das {object:149047} nach Süden entlang des Randes des Kessels und entzünde die vier Wachposten-Kohlenpfannen, vom Südwesten her nach Osten.",

	-- Step 56: Squire Maltrake
	-- {npc:8509} Squire Maltrake · {npc:8479} Velarok Windblade
	["Back north to {npc:8509} beside {npc:8479}."] = "Zurück nach Norden zu {npc:8509} neben {npc:8479}.",
	-- {object:149502} Hoard of the Black Dragonflight · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous · {zone:1428} Burning Steppes
	["The {object:149502} holds a {item:10575}: keep it for {npc:9459} in the {zone:1428}"] = "Der {object:149502} enthält einen {item:10575}: behalte ihn für {npc:9459} in {zone:1428}",

	-- Step 57: Into Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Into {area:254}"] = "Nach {area:254}",
	-- {area:254} Blackrock Mountain
	["Ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Reite nach Süden über die Schlucht zur langen Brücke in {area:254}. Folge drinnen den Kettenstegen nach unten und geh durch den Südausgang heraus; bleib von den Wegen zu den Dungeonportalen fern.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Brücke in den Berg ({area:254})",

	-- Step 58: Overmaster Pyron
	-- {npc:9026} Overmaster Pyron · {area:1584} Blackrock Depths
	["With your group: {npc:9026} (52, elite) guards the way to the {area:1584} portal, down the walkways inside the mountain."] = "Mit deiner Gruppe: {npc:9026} (52, Elite) bewacht den Weg zum {area:1584}-Portal, die Laufstege innerhalb des Berges hinunter.",

	-- Step 59: Blackrock Depths
	-- {area:1584} Blackrock Depths · {zone:1428} Burning Steppes
	["{area:1584} is a dungeon for a group of five from about level 48, the biggest in the mountain: its Anvilrage dwarves are this quest's, and you need not go further in than they are. Its portal is deep inside the mountain, down the chain walkways from the bridge.\nInside: the Anvilrage Guardsmen, Wardens and Footmen. Then back out of the portal and on through the mountain's southern exit to the {zone:1428}."] = "{area:1584} ist ein Dungeon für eine Gruppe aus fünf Spielern ab etwa Stufe 48, der größte im Berg: Seine Anvilrage-Zwerge sind die dieser Quest, und du musst nicht weiter hinein als bis zu ihnen. Das Portal liegt tief im Berg, über die Kettenstege von der Brücke hinab.\nDrinnen: die Anvilrage Guardsmen, Wardens und Footmen. Dann zurück aus dem Portal und weiter durch den Südausgang des Bergs in die {zone:1428}.",
	-- {quest:4081} KILL ON SIGHT: Dark Iron Dwarves
	["{quest:4081}: the Anvilrage dwarves, inside"] = "{quest:4081}: die Anvilrage-Zwerge, drinnen",

	-- Step 60: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "Der Berg lässt dich neben der {area:252} hinaus, voller Orcs der Stufe 55-57. Folge der Straße an den nördlichen Klippen nach Osten zum Lager der Horde am {area:251}.",

	-- Step 61: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Folge den Klippen nach Süden zum {quest:3821}, dem Hügel der Oger der Feuermägen. Die Überreste von {npc:9136} liegen an seinem Fuß.",

	-- Step 62: Sha'ni Proudtusk
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["Only from level 53: her next errand is {quest:3822} (54), who walks the caves of {quest:3821} among ogres of 50-53."] = "Erst ab Stufe 53: Ihr nächster Auftrag ist {quest:3822} (54), der durch die Höhlen des {quest:3821} zwischen Ogern der Stufe 50-53 streift.",

	-- Step 63: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} durchstreift die Höhlen und Minenstollen des {quest:3821}; ist er nicht da, räum die Oger an den Eingängen weg, bis er zurückkommt.",

	-- Step 64: Cyrus Therepentous
	-- {quest:3821} Dreadmaul Rock · {zone:1428} Burning Steppes · {object:149502} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Ride north-east from {quest:3821} to the small cave in the far east of the {zone:1428}. Open the {object:149502} from the {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight.\nCareful: Volchan (60, a rare fire elemental) roams the hills around {npc:9459}'s cave: if he is about, wait for him to pass."] = "Reite von {quest:3821} nach Nordosten zur kleinen Höhle ganz im Osten des {zone:1428}. Öffne das {object:149502} aus dem {zone:1427} wegen seines {item:10575}, dann sag {npc:9459}, dass du Beweise für deine Taten bringst: Kein Drache zu bekämpfen.\nVorsicht: Volchan (60, ein seltenes Feuerelementar) streift durch die Hügel um {npc:9459}s Höhle: Wenn er unterwegs ist, warte, bis er vorbeizieht.",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, aus dem Hort",
	-- {npc:9459} Cyrus Therepentous · {area:1584} Blackrock Depths
	["{npc:9459}' next errand is in {area:1584}: leave it."] = "Der nächste Auftrag von {npc:9459} ist in {area:1584}: lass ihn.",

	-- Step 65: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}: Töte sie, wenn du ihnen begegnest",
	-- {quest:4296} Tablet of the Seven · {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900 · {npc:7040} Black Dragonspawn · {npc:7044} Black Drake
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Ride west to the dig site. The {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence.\nCareful: a {npc:7040} and a {npc:7044}, elites of 50-53, wander the same hills, and Volchan (60, a rare fire elemental) roams them too: pull the broodlings away from them, or bring a group."] = "Reite nach Westen zur Ausgrabungsstätte. {quest:4296} steht in ihrer Mitte unter den Thaurissan-Zwergen. Kopiere es.\nBlack Broodlings nisten in den Hügeln direkt östlich von {area:251}. Benutze {npc:10267}s {item:12284} auf einen Broodling, wenn er fast tot ist, um seine Essenz zu fangen.\nVorsicht: Ein {npc:7040} und ein {npc:7044}, Elites der Stufen 50-53, wandern durch dieselben Hügel, und Volchan (60, ein seltenes Feuerelementar) streift dort ebenfalls umher: Zieh die Broodlings von ihnen weg oder bring eine Gruppe mit.",

	-- Step 66: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Zurück nach Nordosten zum {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Behalte {npc:10267}s Brief: {quest:4808} ist in {area:2255}, {zone:1452}.",

	-- Step 70: Warlord Goretooth
	-- {area:1584} Blackrock Depths · {npc:9077} Warlord Goretooth · {area:340} Kargath
	["The Anvilrage dwarves of your {area:1584} run: {npc:9077}, in {area:340}."] = "Die Anvilrage-Zwerge aus deinem Run durch {area:1584}: {npc:9077}, in {area:340}.",

	-- Step 71: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Flieg zur {area:1497}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Flugmeister in {area:340}",

	-- Step 72: Harbinger Balthazad
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, neben dem Fledermausführer",

	-- Step 73: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} steht im {object:36082}.",

	-- Step 74: Oran Snakewrithe
	-- {quest:2995} Lines of Communication · {object:144073} Highvale Report · {area:350} Quel'Danil Lodge · {zone:1425} The Hinterlands · {zone:1419} Blasted Lands
	["{quest:2995}'s work is not in this guide: burn the {object:144073}, Notes and Records in the elves' camps around {area:350}, in {zone:1425} & {zone:1419} (its Highvale step). Load that guide for the arrows."] = "Die Arbeit von {quest:2995} ist in diesem Guide nicht enthalten: verbrenne die {object:144073}, die Notizen und Aufzeichnungen in den Elfenlager um {area:350}, in {zone:1425} & {zone:1419} (seinem Highvale-Schritt). Lade diesen Guide für die Pfeile ab.",

	-- Step 75: Undercity
	-- {npc:8390} Chemist Cuely · {item:10695} Box of Empty Vials · {zone:1447} Azshara
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["{npc:8390}, the Apothecarium: a {item:10695} comes with the quest. Keep four bag slots free and open it for Empty Vials Labeled #1 to #4, filled in {zone:1447} later"] = "{npc:8390}, das Apothekengewölbe: Eine {item:10695} kommt mit der Quest. Halte vier Taschenplätze frei und öffne sie für mit #1 bis #4 beschriftete Phiolen, die später in {zone:1447} gefüllt werden",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, near Cuely in the Apothecarium"] = "{npc:5204}, in der Nähe von Cuely im Apothecarium",

	-- Step 77: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Verlass {zone:1458} und reite auf der Straße nach Osten durch {zone:1420} zum {area:152}, der Festung der Verlassenen an der Grenze.",
	-- {quest:5405} Argent Dawn Commission
	["Equip the {quest:5405}: Scourgestones only drop while you wear it."] = "Trage das {quest:5405}: Die Scourgestone fallen nur, wenn du es trägst.",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions
	["{item:12814}, from the {object:176092} next to Derrington: {quest:5096}, done on the way back"] = "{item:12814}, von dem {object:176092} an Derrington: {quest:5096}, auf dem Rückweg erledigt",

	-- Step 78: Scarlet forward camp
	["Scarlet forward camp"] = "Vorgeschobenes Lager des Scharlachroten Kreuzzugs",
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {item:12814} Flame in a Bottle
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {item:12814} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "Vom {area:152} über die Straße nach Osten in die {zone:1422}. Das Zeltdorf der Schwarzen Kreuzzüger liegt direkt hinter Felstone Farm, zwischen {area:199} und {area:200}. Brenne das Befehlszelt mit dem {item:12814} nieder und pflanze das Banner der Scourge. Vorsicht: Die Schwarzen Kreuzzüger um die Zelte erreichen Stufe 54 und invokern: komme von der Seite heran, die dem Befehlszelt am nächsten ist, und lasse die anderen unberührt.",

	-- Step 79: Janice Felstone
	-- {npc:10778} Janice Felstone
	["Back a few steps west to Felstone Farm, the first farm along the road; {npc:10778} waits in the house."] = "Ein paar Schritte zurück nach Westen zum Hof der Felsteins, dem ersten Hof an der Straße; {npc:10778} wartet im Haus.",
	["Upstairs"] = "Oben",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house; inside"] = "{object:175894}, neben dem Haus; drinnen",
	-- {npc:10781} Royal Overseer Bauhaus · {zone:1458} Undercity · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["Keep the parcel: {npc:10781} is in the {zone:1458}. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Behalte das Paket: {npc:10781} ist in {zone:1458}. Der nächste Guide beginnt mit {npc:10739} beim {area:202}, südöstlich von hier.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:2268}"] = "Zurück zur {area:2268}",
	-- ["Black Broodlings"] = "Schwarze Brutlinge",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Schwarze Brutlinge nisten in den Hügeln gleich östlich vom {area:251}. Benutze {npc:10267}s {item:12284} an einem fast toten Brutling, um seine Essenz einzufangen.",
	-- ["Bloodpetal Flayers"] = "Blutblütenschinder",
	-- ["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Vorsicht: Gorishi Workers, die unter 45% Gesundheit fallen, rufen mit 50% Wahrscheinlichkeit Verbündete im Umkreis von 25 yd zu Hilfe.",
	-- ["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time.\nBelow level 52, keep hunting the ravasaurs here after the eighth claw: {quest:4061} at {area:340} needs level 52, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Vorsicht: In der Gegend streifen viele Ravasaurs umher, sodass du leicht mehrere gleichzeitig ziehst.\nSolange du unter Stufe 52 bist, jage hier nach der achten Klaue weiter Ravasaurs: {quest:4061} in {area:340} braucht Stufe 52, und die Quests im Pestland am Ende dieses Guides sind Stufe 55. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1417} oder den Dungeon {area:2100}.",
	-- ["Darrowshire Spirits"] = "Geister von Darrowshire",
	-- ["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Flieg nach {area:1637} und trainiere vor dem Zeppelin nach {object:3202}: Der Halt in {zone:1458} später in diesem Guide hat keinen Jäger- oder Schamanenlehrer.",
	-- ["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "Flieg nach {area:1637}, nimm den Zeppelin nach {object:3202} und flieg von dort nach {area:340}, das in die Klippen am Westrand des Gebiets {zone:1418} gebaut ist.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Flieg nach {area:1638} und trainiere bei {npc:3033} im Gebiet {area:1639}; flieg dann nach {area:1637} zum Zeppelin nach {object:3202}.",
	-- ["Fly to {area:272}"] = "Flieg nach {area:272}",
	-- ["Fly to {area:340}"] = "Flieg nach {area:340}",
	-- ["Follow the road east through the {area:28} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Folge der Straße nach Osten durch das Gebiet {area:28} und über den Fluss ins Gebiet {area:139}; verlass es nach Norden zum {area:2627}, der zerstörten Stadt im Nordwesten. {npc:12384} sitzt in einer Hütte an ihrem Rand.",
	-- ["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Folge der Straße nach Osten durch das Gebiet {zone:1422} und über den Fluss ins Gebiet {zone:1423}; verlass es nach Norden zum {area:2627}, der zerstörten Stadt im Nordwesten. {npc:12384} sitzt in einer Hütte an ihrem Rand.",
	-- ["For your {area:1584} run, next, on the way through {area:254}: the {object:164867} poster in {area:340} wants the Anvilrage dwarves inside thinned out."] = "Für deinen Run durch {area:1584}, als Nächstes, auf dem Weg durch {area:254}: Das Plakat {object:164867} in {area:340} will, dass die Anvilrage-Zwerge drinnen dezimiert werden.",
	-- ["Free Darrowshire Spirits: talk to them"] = "Befreie Geister von Darrowshire: Sprich mit ihnen",
	-- ["From here on pick up every {npc:271301} (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "Sammle ab jetzt jeden {npc:271301} (blau, grün, rot, gelb) und jeden Haufen {quest:3761} auf deinem Weg ein: insgesamt 25 Erde, 20 für Hamuul und 5 für Pestlezugg.",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Folge vom {area:152} aus der Straße nach Osten in die {zone:1422}. Die Zelte des Scharlachroten Kreuzzugs stehen gleich hinter dem Hof der Felsteins, zwischen {area:199} und {area:200}. Zünde das Kommandozelt mit {object:176092} an und pflanz das Banner der Geißel auf.",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "Folge vom {area:152} aus der Straße nach Osten in die {zone:1422}. Die Zelte des Scharlachroten Kreuzzugs stehen gleich hinter dem Hof der Felsteins, zwischen {area:199} und {area:200}. Zünde das Kommandozelt mit {object:176092} an und pflanz das Banner der Geißel auf. Vorsicht: Die Scharlachroten um die Zelte sind bis Stufe 54 und die Beschwörer wirken Zauber: Komm von der Seite, die dem Kommandozelt am nächsten ist, und lass die anderen in Ruhe.",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "Reite von der {area:1938} nach Westen zur langen Rampe, die sich in den {area:490} hinabwindet, und folge dann der Nordwand des Kraters nach {area:541}, einem Lager in den Klippenhöhlen. Alle hier sind neutral.",
	-- ["Gorillas"] = "Gorillas",
	-- ["Inside"] = "Drinnen",
	-- ["Into {area:490}"] = "Hinab in den {area:490}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Behalte den Köder: {npc:9684} ist Stufe 56, und die zweite Runde führt an seinem Unterschlupf vorbei.",
	-- ["Keep the parcel: {npc:10781} is in the {zone:1458}. Keep {quest:5901}: its termite mounds are in {area:2627}, on the next guide's ride to Tirion. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Behalte das Paket: {npc:10781} ist in {zone:1458}. Behalte {quest:5901}: Die Termitenhügel dafür stehen im {area:2627}, auf dem Ritt zu Tirion im nächsten Guide. Der nächste Guide beginnt mit {npc:10739} beim {area:202}, südöstlich von hier.",
	-- ["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "Behalte {quest:5152}: Marlene wohnt am {area:197} im Gebiet {zone:1422}.",
	-- ["Keep {quest:5901}: its termite mounds are in {area:2627}, on the next guide's ride to Tirion. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Behalte {quest:5901}: Die Termitenhügel dafür stehen im {area:2627}, auf dem Ritt zu Tirion im nächsten Guide. Der nächste Guide beginnt mit {npc:10739} beim {area:202}, südöstlich von hier.",
	-- ["Lashers and Threshers"] = "Peitscher und Drescher",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Führe {npc:9999} nach Norden nach {area:541}. Wenn er ohnmächtig wird, benutze {item:11804} an ihm, um ihn zu wecken.",
	-- ["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "Verlass {zone:1458} und reite auf der Straße nach Osten durch {area:85} zum {area:152}, der Festung der Verlassenen an der Grenze.",
	-- ["Level 51"] = "Stufe 51",
	-- ["North of Torwa, a dead Threshadon lies by the water."] = "Nördlich von Torwa liegt ein toter Dreschadon am Wasser.",
	-- ["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "Pestlezuggs nächste Quest braucht die {npc:10041}, einen Elite-Boss. Überspringe sie.",
	-- ["Power Crystals and soil"] = "Machtkristalle und Erde",
	-- ["Pterrordax"] = "Pterrordax",
	-- ["Pterrordax fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}."] = "Pterrordax fliegen über den Osten des Kraters, von den Hängen unterhalb der Zuflucht nach Süden; ihre Schwimmhautschuppen sind für {npc:9998}.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Reite nach Osten zum Ort {area:537}, steig hinauf und benutze {npc:10541} am Lavaschlot nahe dem Gipfel; reite dann zurück nach Westen zu {npc:10302}.",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Reite an der Ostseite nach Norden. Blutblütenpeitscher und -drescher füllen den Dschungel.",
	-- ["Ride north back to {area:541}."] = "Reite nach Norden zurück nach {area:541}.",
	-- ["Ride north back to {area:541}: {npc:9117} below ground, {npc:9997} beside the flight master."] = "Reite nach Norden zurück nach {area:541}: {npc:9117} unter der Erde, {npc:9997} neben dem Flugmeister.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Reite nach Nordwesten nach Andorhal. {npc:10667} wartet im zerstörten Gasthaus auf der Westseite der Stadt; die Skelette drinnen sind 54-57, also bleib am Rand.",
	-- ["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Reite nach Süden zurück zur Straße und folge ihr nach Osten durch das ganze Gebiet zur {area:2268}.",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Reite an den westlichen Klippen entlang nach Südwesten. {npc:9167} fliegen über die Westseite, und Blutblütenfallen wachsen im selben Dschungel.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Reite nach Südwesten zum Ort {area:537}, dem Vulkan in der Mitte des Kraters. Blutblütenschinder wachsen um seinen Fuß.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Reite nach Südwesten zu {area:537}, dem Vulkan in der Mitte des Kraters. Bloodpetal Flayers wachsen rund um seinen Fuß.\nSüdlich der heißen Quellen grasen Stegodons, und Dinosaur Bones fallen von ihnen oder liegen am Boden; Diemetradons in der Nähe tragen die Schuppen, die {npc:9998} will. Ravasaurs jagen im Südwesten in Rudeln: Ihre Klauen sind für {npc:8659}, und hin und wieder trägt einer ein Mangled Journal (ein seltener Drop: Nimm die Quest nur an, wenn du eines bekommst). Meide Gruff, einen Stegodon der Stufe 57.\nReite weiter nach Südwesten entlang der westlichen Klippen. {npc:9167} fliegen über der Westseite, und Bloodpetal Trappers wachsen im selben Dschungel.",
	-- ["Ride west to the dig site. The {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence.\nCareful: a {npc:7040} and a {npc:7044}, elites of 50-53, wander the same hills: pull the broodlings away from them, or bring a group."] = "Reite nach Westen zur Ausgrabungsstätte. {quest:4296} steht in ihrer Mitte zwischen den Thaurissan-Zwergen. Kopiere sie.\nSchwarze Brutlinge nisten in den Hügeln direkt östlich von {area:251}. Benutze {item:12284} von {npc:10267} an einem Brutling, wenn er fast tot ist, um seine Essenz einzufangen.\nVorsicht: Eine {npc:7040} und ein {npc:7044}, Elites der Stufe 50-53, wandern durch dieselben Hügel: Zieh die Brutlinge von ihnen weg oder nimm eine Gruppe mit.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "Reite nach Westen zur Ausgrabungsstätte. {npc:7039}-Golems (53) stampfen dort herum und lassen oft die Splitter fallen; die {quest:4296} steht in der Mitte zwischen den Thaurissanischen Zwergen. Kopiere sie.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Reite nach Westen zur Ausgrabungsstätte. {npc:7039}-Golems (53) stampfen darum herum und lassen die Splitter oft fallen; {quest:4296} steht in ihrer Mitte zwischen den Thaurissan-Zwergen. Kopiere sie.\nBlack Broodlings nisten in den Hügeln direkt östlich von {area:251}. Benutze {item:12284} von {npc:10267} an einem Broodling, wenn er fast tot ist, um seine Essenz einzufangen.",
	-- ["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "Südlich der heißen Quellen grasen Stegodons; Dinosaurierknochen fallen von ihnen oder liegen am Boden. Dimetrodons in der Nähe tragen die Schuppen, die {npc:9998} will. Ravasaurier jagen im Südwesten in Rudeln: Ihre Klauen sind für {npc:8659}, und ab und zu trägt einer Ein zerfleddertes Tagebuch (seltene Beute: Nimm dessen Quest nur an, wenn du eins bekommst). Meide Gruff, einen Stegodon der Stufe 57.",
	-- ["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Nimm einen {object:176092} aus der Kiste neben Derrington für {quest:5096}, die du auf dem Rückweg erledigst. Leg die {quest:5401} an: Geißelsteine fallen nur, solange du sie trägst.",
	-- ["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5405}: Scourgestones only drop while you wear it."] = "Nimm einen {object:176092} aus der Kiste neben Derrington für {quest:5096}, die du auf dem Rückweg erledigst. Leg die {quest:5405} an: Geißelsteine fallen nur, solange du sie trägst.",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Nimm den Pass an der Westseite von {area:340} in die {zone:1427} und reite dann nach Süden durch die Schlucht zur langen Brücke in den Berg ({area:254}). Folge drinnen den Kettenstegen nach unten und verlass ihn durch den Südausgang; bleib von den Wegen zu den Dungeonportalen fern.",
	-- ["Termite mounds"] = "Termitenhügel",
	-- ["Thaurissan dig site"] = "Thaurissanische Ausgrabungsstätte",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Die Annalen liegen zwischen den Modrigen Folianten im Rathaus von Andorhal; öffne sie, bis du den richtigen findest.",
	-- ["The Gorishi hive"] = "Der Schwarm der Gorishi",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Die Großen Termitenhügel stehen überall in den Hügeln östlich von {area:2627}. Benutze den {item:15042} an jedem Hügel, an dem du vorbeikommst.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Die Zelte des Scharlachroten Kreuzzugs stehen zwischen {area:199} und {area:200}. Zünde das Kommandozelt mit {object:176092} an und pflanz das Banner der Geißel auf.",
	-- ["The book lies in the ruined inn of {area:2627}."] = "Das Buch liegt im zerstörten Gasthaus von {area:2627}.",
	-- ["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "Der Kopf der Puppe und ihre beiden Seiten liegen in den Häusern um {npc:10926}; füge sie in deinen Taschen zusammen.",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "Die Kiste der Expedition steht in einem verlassenen Lager im östlichen Dschungel.",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Die Gorillas leben auf dem nordöstlichen Plateau. Bleib aus der hintersten Höhle fern: Dort lebt {npc:9622}.",
	-- ["The hearth lands in {area:976}: {npc:11758} takes the {area:983} and Tran'rek Thistleshrub Valley, both done on the way into the crater."] = "Der Ruhestein bringt dich nach {area:976}: {npc:11758} nimmt {area:983} und das Tal von Tran'rek Distelstrauch an, beides auf dem Weg in den Krater erledigt.",
	-- ["The next guide starts here, at the chapel's flight master."] = "Der nächste Guide beginnt hier, beim Flugmeister der Kapelle.",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "Der Silithidenschwarm füllt den Süden des Kraters. Wespen und Arbeiter der Gorishi lassen die Duftdrüse fallen; benutze die Kratzphiole an der Eiermasse in der ersten Kammer. Die Schwarmkönigin ganz unten ist ein Elite-Boss: Bleib aus ihrer Kammer fern. {npc:9166} nisten auf den Klippen über dem Schwarm; ihre Schuppen sind für {npc:9998}.",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Die Teergruben liegen gleich südlich der Zuflucht. Teerbestien, Teerlauerer und Teerkriecher lassen {item:11834} fallen.",
	-- ["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",
	-- ["The {object:164867} poster"] = "Das Plakat {object:164867}",
	-- ["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "Theodoras nächster Auftrag führt zu Lotwil östlich der Stadt und dann in die {area:1584}: Überspringe ihn.",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "Theodoras Quest in {area:340} braucht Stufe 52. Die Teerlauerer und Teerfürsten gleich südlich der Zuflucht sind das nächste Lager.",
	-- ["To {area:197}"] = "Zum {area:197}",
	-- ["Top up here to level 51 before the crater's loop: its {npc:9166} and Bloodpetal Flayers are up to level 52. The Bloodpetal Threshers (49-50) on the slopes south-east of the refuge are under your level, and {npc:9118} wants five of them. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Levle hier bis Stufe 51 vor der Kraterrunde: Ihre {npc:9166} und Blutblütenschinder sind bis Stufe 52. Die Blutblütendrescher (49-50) an den Hängen südöstlich der Zuflucht liegen unter deiner Stufe, und {npc:9118} will fünf davon. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:1417} oder {area:2100}.",
	-- ["Western jungle"] = "Westlicher Dschungel",
	-- ["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Mit {npc:11063}s Quest im Questlog hinterlässt erschlagene Geißel manchmal einen {npc:11064}; sprich mit ihm, um ihn zu befreien. Töte Untote auf dem Ritt nach Südwesten nach {area:2262}.",
	-- ["grind on Pterrordax"] = "Grinde an Pterrordax",
	-- ["grind on Ravasaur"] = "grinde Ravasaur",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "Töte Teerlauerer an den {area:538}, {zone:1449}",
	-- ["grind on {npc:6511}"] = "grinde {npc:6511}",
	-- ["grind on {npc:6551}"] = "grinde {npc:6551}",
	-- ["the wooden sign beside {npc:9997}, by the flight master: the pterrordax are on this guide's ground"] = "das Holzschild neben {npc:9997}, beim Flugmeister: Die Pterrordax liegen auf dem Gelände dieses Guides",
	-- ["{area:272} flight master"] = "Flugmeister von {area:272}",
	-- ["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}s Geist steht in den Ruinen von {area:2262} im Südwesten.",
	-- ["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250} lauert gleich westlich von {area:2262}.",
	-- ["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",
	-- ["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, im Apothekarium: Die Phiolen füllst du später in {zone:1447}",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, hinten in der Höhle",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619} will jetzt das Fell von {npc:9622}, zurück in der nordöstlichen Höhle: Überspringe es.",
	-- ["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "{npc:9623} will dann ein {item:10561}, einen Gegenstand aus {skill:202}. Überspringe das, außer du hast eins.",
	-- ["{npc:9623}, the robot on the plateau"] = "{npc:9623}, der Roboter auf dem Plateau",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Der Unterschlupf von {npc:9684} liegt gleich südlich des Pylons. Benutze dort {npc:9619}s Köder; {npc:9684} ist Stufe 56 und schlägt hart zu, also fang mit voller Gesundheit an.",
	-- ["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} sitzt verirrt und erschöpft auf dem Grat.",
	-- ["{quest:5211}'s spirits come with the {zone:1423} guide's {area:2264} stop: keep it."] = "Die Geister für {quest:5211} kommen beim Halt in {area:2264} im Guide für {zone:1423}: Behalte sie.",
}
