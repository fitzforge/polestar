-- German (deDE): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 56."] = "Für Charaktere der Stufe 49 bis 50, aber die meisten Quests hier sind Stufe 51-53: mit Absicht, wegen ihrer Erfahrung. Dieser erste Besuch bleibt in der Osthälfte des Kraters, wo die Bestien 48-52 sind, also zieh sie einzeln; die Pylonen, die Knochen und der Bau warten auf den späteren Un'Goro-Besuch mit etwa 56.",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Flieg nach {area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",

	-- Step 3: Theramore
	["Theramore"] = "Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} steht an den Docks, wo das Schiff anlegt.",

	-- Step 4: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",
	["Theramore flight master"] = "Flugmeister von Theramore",

	-- Step 5: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight from Theramore lands in {area:976}."] = "Der Flug von Theramore landet in {area:976}.",

	-- Step 7: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "Reite nach Westen zum Bau der Centipaar in den Dünen. Jeder Centipaar kann Insektenteile droppen.\nVorsicht: Schwärmer der Centipaar wirken {npc:4196} im und außerhalb des Kampfes, was kleine Adds bringt, die dich unterbrechen.",

	-- Step 8: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Reite nach Süden zum Ogergelände. Schläger und Vollstrecker (46-48) füllen es; {npc:12046} (49) steht in der Mitte mit Wachen um sich: Räum diese zuerst.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}, unter der Erde",

	-- Step 9: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}: Töte diese, sobald sie dir begegnen",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride west into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley.\nCareful: the thistleshrubs wander a lot, so you can easily pull extra mobs."] = "Reite nach Westen ins {quest:3362}. Die Tausammler droppen die Drüsen; nur manche sind voll, also behalte die gefüllte. Knorrige Distelwandler und Wurzelformer teilen sich das Tal.\nVorsicht: Die Distelwandler laufen viel umher, du ziehst leicht zusätzliche Mobs.",

	-- Step 10: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back north-east to {area:976}: {npc:11758} stands on the east side of town."] = "Reite zurück nach Nordosten nach {area:976}: {npc:11758} steht auf der Ostseite der Stadt.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, drinnen",

	-- Step 11: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Reite südlich am {area:1938} vorbei zum {area:981}, den Tunneln der Hazzali; die Ausrüstung von Scrimshank liegt tief drinnen.\nVorsicht: Ein Käfer bewacht die Ausrüstung. Viele Käfer patrouillieren in den Tunneln, einige davon Stufe 50, sodass Kämpfe oft zusätzliche Adds ziehen.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593}; unter der Erde",

	-- Step 12: Gadgetzan
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus · {zone:1428} Burning Steppes
	["For {npc:7740} in {zone:1457}, at the end of the {zone:1428} guide: keep it"] = "Für {npc:7740} in {zone:1457}, am Ende des Guides für {zone:1428}: Behalte es",

	-- Step 14: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Reite nach Westen aus {area:976} hinaus zur langen Rampe hinab in den {zone:1449}. {npc:9619} lagert am Fuß der Rampe, in der Südostecke des Kraters.",

	-- Step 15: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder · {item:280459} Crystal Infused Scale
	-- plural, as words: Venomhide Ravasaurs = {npc:6508} Venomhide Ravasaur
	["The dead Threshadon lies by the water north of {npc:9619}.\nCareful: Venomhide Ravasaurs (50-51) hunt along the water there: pull them one at a time before you loot the carcass.\nAny ravasaur may drop a {item:280459}: right-click it, {npc:9619} takes it."] = "Der tote Dreschadon liegt am Wasser nördlich von {npc:9619}.\nVorsicht: Gifthautravasaurier (50-51) jagen dort am Wasser: Zieh sie einzeln, bevor du den Kadaver plünderst.\nJeder Ravasaurus kann eine {item:280459} droppen: Rechtsklick darauf, {npc:9619} nimmt sie an.",

	-- Step 16: Torwa Pathfinder
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale"] = "{quest:87494}, falls ein Ravasaurus die Schuppe gedroppt hat",
	-- {area:1943} Ironstone Plateau
	["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "Die Gorillas auf dem {area:1943} tragen die Felle: Behalte es für den zweiten Besuch im Un'Goro, etwa auf Stufe 56",

	-- Step 17: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Lar'korwi-Weibchen und das Floß",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "Die Lar'korwi-Weibchen streifen durch den Dschungel westlich von {npc:9619}. Das zerstörte Floß liegt dort am Seeufer; das kleine Bündel liegt daneben im Wasser. Behalte Kompass, Karte und Schlüssel für {npc:8737}. Jedes Wildtier im Krater kann {item:11116} fallen lassen: Rechtsklick darauf.",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "{object:161504}, unter Wasser",

	-- Step 18: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Back east to {npc:9619} with the glands."] = "Zurück nach Osten zu {npc:9619} mit den Drüsen.",

	-- Step 19: Marshal's Refuge
	-- {npc:271301} Power Crystal · {object:157936} Un'Goro Dirt Pile
	["Ride north-west to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Reite nach Nordwesten zum Zufluchtsort.\nHalte weiten Abstand zu den Elite-Teufelssauriern und Stegodons. Heb von hier an jeden {npc:271301} und jeden {object:157936} auf, an dem du vorbeikommst.",
	-- {npc:9998} Shizzle
	["{npc:9998}: his scales come from the young beasts of the eastern jungle"] = "{npc:9998}: Seine Schuppen stammen von den jungen Tieren im östlichen Dschungel",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, hinten in der Zuflucht",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Endet bei {npc:9298} in {zone:1452}: Behalte es",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, hinten in der Höhle; unter der Erde",
	-- {npc:9272} Spark Nilminer · {npc:9271} Hol'anyee Marshal · {npc:9270} Williden Marshal · {npc:9618} Karna Remtravel
	["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "{npc:9272}, {npc:9271}, {npc:9270} und {npc:9618} haben Quests bei Mobs der Stufe 51-55: Heb sie dir für den späteren Besuch im Un'Goro auf, etwa auf Stufe 56.",

	-- Step 20: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} und der östliche Dschungel",
	-- {quest:3764} Un'Goro Soil · {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:9165} Fledgling Pterrordax
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher · Living Blazes = {npc:6521} Living Blaze · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride east into the eastern jungle: Bloodpetal Lashers and Threshers (48-50) drop the petals and {quest:3764}. Crystal clusters stand all over the crater, many around the foot of {area:537}: take a few extra of each colour.\nCareful: the Living Blazes (54-55) walk the top of {area:537}, and the Bloodpetal Flayers and Trappers (51-53) hold the jungle's south: take your crystals from the ridge's foot and your petals in the north.\n{npc:9998}'s scales: the {npc:9165} (48-50) glide over the north-east of the jungle and the Young Diemetradons (49-50) graze beside them. There are only ten of those: the Diemetradons (51) on the jungle's western edge, a short way west of the Threshers, drop the scales too. They are a level over you: take them one at a time."] = "Reite nach Osten in den östlichen Dschungel: Blutblütenpeitscher und -drescher (48-50) lassen die Blüten und {quest:3764} fallen. Kristallansammlungen stehen überall im Krater, viele am Fuß des {area:537}: Nimm von jeder Farbe ein paar mehr mit.\nVorsicht: Lebendige Feuer (54-55) laufen oben auf dem {area:537} umher, und Blutblütenschinder und -fallensteller (51-53) halten den Süden des Dschungels: Hol dir die Kristalle am Fuß des Kamms und die Blüten im Norden.\nSchuppen für {npc:9998}: {npc:9165} (48-50) gleiten über den Nordosten des Dschungels, und Junge Dimetrodons (49-50) grasen daneben. Davon gibt es nur zehn: Die Dimetrodons (51) am Westrand des Dschungels, ein Stück westlich der Drescher, lassen die Schuppen auch fallen. Sie sind eine Stufe über dir: Nimm sie einzeln.",
	-- {item:11316} Bloodpetal
	["{item:11316}, from the Lashers and Threshers"] = "{item:11316}, von den Peitschern und Dreschern",
	-- {quest:3764} Un'Goro Soil
	["{quest:3764}, from the Threshers and the dirt piles"] = "{quest:3764}, von den Dreschern und den Erdhaufen",

	-- Step 21: Lakkari Tar Pits
	-- plural, as words: Tar Lords = {npc:6519} Tar Lord
	["Crystal clusters stand all over the crater. The pits' Tar Lords (53-54) and the oozes around them (50-54) are over you: take the clusters on the jungle's north-eastern edge, among the Lashers and young beasts (48-50)."] = "Kristallansammlungen stehen überall im Krater. Die Teerfürsten der Gruben (53-54) und die Schlammbestien um sie herum (50-54) sind über dir: Nimm die Ansammlungen am Nordostrand des Dschungels, zwischen den Peitschern und jungen Tieren (48-50).",

	-- Step 22: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, unter der Erde",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Für {npc:7775} in {zone:1444}: Behalte es",

	-- Step 23: Level 49.79
	["Level 49.79"] = "Stufe 49,79",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Still short of level 49.79 after the refuge's hand-ins? Top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "Nach den Abgaben in der Zuflucht noch unter Stufe 49,79? Hol dir den Rest an den Blutblütenpeitschern und -dreschern (48-50) im östlichen Dschungel, wo du die Blüten gesammelt hast, bevor du den Krater verlässt.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "grinde {npc:6511}",

	-- Step 24: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Flieg nach {area:415}",
	-- {zone:1455} Ironforge · {zone:1427} Searing Gorge · {zone:1440} Ashenvale · {zone:1447} Azshara
	["The {zone:1455} quests were taken at the end of the {zone:1427} guide: fly straight on to {zone:1440} for {zone:1447}."] = "Die Quests aus {zone:1455} wurden am Ende des Guides für die {zone:1427} angenommen: Flieg direkt weiter nach {zone:1440} für {zone:1447}.",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Flugmeister in {area:541}",

	-- Step 25: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Zum {zone:1455}",

	-- Step 26: Mystic Ward
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: für Ogtinc in {zone:1447}, behalte es",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "{npc:7312}, der Magierlehrer: für {npc:8395} in {zone:1447}, behalte es",

	-- Step 29: Fly to Astranaar
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Flugmeister von {area:442}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "Archesonus steht neben König Magni im {object:171709}.",
	-- ["Below ground"] = "Unter der Erde",
	-- ["Bind and train"] = "Binden und trainieren",
	-- ["Bones and equipment"] = "Knochen und Ausrüstung",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Durchquere den Süden des Kraters zu {npc:9619} an der Rampe.",
	-- ["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Dinosaurierknochen liegen im Südwesten auf dem Boden, zwischen den Stegodons: Die sind Elite, sammle die Knochen um sie herum auf und hol den Rest von Dimetrodons. Die {item:11112} der Expedition liegt im südwestlichen Dschungel.",
	-- ["Eastern Pylon"] = "Östlicher Kristallpylon",
	-- ["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- ["Fly from {area:144} to {area:1537}."] = "Flieg von {area:144} nach {area:1537}.",
	-- ["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. The crater's beasts are 48-55 and the Gorishi silithids 51-54, so pull them one at a time."] = "Für Charaktere der Stufe 49 bis 50, aber die meisten Quests hier sind Stufe 51-53: mit Absicht, wegen ihrer Erfahrung. Die Bestien des Kraters sind 48-55 und die Silithiden der Gorishi 51-54, also zieh sie einzeln.",
	-- ["Four rune rubbings in {zone:1447}: keep it"] = "Vier Runenabriebe in {zone:1447}: Behalte es",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "Flieg von {area:144} nach {area:150}, nimm das Boot nach Theramore und flieg weiter nach {area:976}. {npc:9619}s erste Quest im Krater erfordert Stufe 48: Mach die Stufe hier voll, falls dir etwas fehlt.",
	-- ["Grind to 50"] = "Grinde bis 50",
	-- ["Grind to 51"] = "Grinde bis 51",
	-- ["Gryfe"] = "Gryfe",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Führ {npc:9999} nach Norden zu {area:541}. Wenn er ohnmächtig wird, benutze {item:11804} an ihm, um ihn zu wecken.",
	-- ["Level 50.4"] = "Stufe 50,4",
	-- ["Northern Pylon"] = "Nördlicher Kristallpylon",
	-- ["Pterrordax"] = "Pterrordax",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Reite die Rampe hinab in den Krater: {npc:9619} lagert an ihrem Fuß.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Reite nach Osten zum {area:1943}, wo der Roboter zwischen den Gorillas steht. Bleib dort aus der tiefen Höhle fern.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Reite nach Osten zum {area:537}, klettere hinauf und benutze {npc:10541} an den Lavaschloten nahe dem Gipfel.",
	-- ["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Reite an der Ostseite des Kraters nach Norden zu {area:541}, dem Lager in den Höhlen der Nordklippe. Mach einen großen Bogen um die Elite-Teufelssaurier und Stegodons. Sammle ab hier jeden Machtkristall und jede {object:157936} ein, an denen du vorbeikommst.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Reite an der Ostseite nach Norden zum Gorillaplateau. {npc:9622}, ein Gorilla der Stufe 55, sitzt in dessen tiefster Höhle: Säubere zuerst die Gorillas am Höhleneingang.",
	-- ["Ride north along the western jungle back to the refuge."] = "Reite durch den westlichen Dschungel nach Norden zurück zur Zuflucht.",
	-- ["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Reite nach Norden zum {area:1943}, wo der Roboter zwischen den Gorillas steht. Bleib dort aus der tiefen Höhle fern.",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Reite an den östlichen Klippen entlang nach Süden zu {npc:9619} am Fuß der Rampe.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "Reite an der Ostseite nach Süden. Junge Dimetrodons grasen im östlichen Dschungel, und {npc:9165} fliegen nahe den östlichen Klippen; beide lassen die Schuppen für {npc:9998} fallen.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "Reite an der Ostseite nach Süden. Young Diemetradons grasen im östlichen Dschungel, und {npc:9165} fliegen nahe den östlichen Klippen; beide lassen die Schuppen von {npc:9998} fallen. Die Kiste steht im verlassenen Lager im östlichen Dschungel.",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Reite nach Süden zum {area:537} in der Mitte des Kraters, dann nach Osten in den östlichen Dschungel. Kristallhaufen stehen überall im Krater, viele davon um den {area:537}: Nimm von jeder Farbe ein paar extra. Blutblütenpeitscher und Blutblütendrescher lassen die Blütenblätter fallen; die {item:11113} der Expedition liegt in einem verlassenen Lager im östlichen Dschungel.",
	-- ["Ride south-west past {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; Pterrordax nest on the southern cliffs if you still need kills.\nCareful: Gorishi silithids are level 51-54 and cast {spell:8137} or {spell:14120} in melee; Gorishi Workers have a 50% chance to call for help within 25 yd once they fall below 45% health."] = "Reite südwestlich an {npc:9619} vorbei: Der Silithidenbau füllt den Süden des Kraters. Benutze das Scraping Vial an einer Brutstätte, einer Kammer mit hängenden Larven. Gorishi-Wespen und -Arbeiter lassen {quest:3764} fallen; Pterrordax nisten an den südlichen Klippen, falls du noch Kills brauchst.\nVorsicht: Gorishi-Silithiden sind Stufe 51-54 und wirken im Nahkampf {spell:8137} oder {spell:14120}; Gorishi Workers rufen mit 50 % Wahrscheinlichkeit Hilfe im Umkreis von 25 Metern, sobald sie unter 45 % Gesundheit fallen.",
	-- ["Ride west back to the refuge."] = "Reite nach Westen zurück zur Zuflucht.",
	-- ["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Reite zurück nach Westen zum Zufluchtsort.\nHalte weiten Abstand zu den Elite-Teufelssauriern und Stegodons. Heb von hier an jeden {npc:271301} und jeden {object:157936} auf, an dem du vorbeikommst.",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Reite von {npc:9619} nach Westen: Der Silithidenbau füllt den Süden des Kraters. Benutze die Kratzphiole an einer Brutstätte, einer Kammer mit hängenden Larven. Wespen und Arbeiter der Gorishi lassen {quest:3764} fallen; {npc:9166} nisten an den Südklippen, falls dir noch Kills fehlen.",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Reite nach Westen aus {area:976} hinaus zur langen Rampe hinab in den {area:490}. {npc:9619} lagert am Fuß der Rampe, in der Südostecke des Kraters.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Reite nach Westen an {area:541} vorbei und an der Westseite nach Süden zu {area:543}: {npc:10302}, der Goblin, sitzt am Wasser.",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Der {area:1417} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Überspring diesen Schritt, um allein zu grinden.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "{area:978} statt Grinden bringt dich in einer Gruppe schneller ans Ziel. Die Trollstadt liegt im Nordwesten von {zone:1446}, gleich nördlich von {area:976}.",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Pterrordax on the slopes east of {area:541} before you leave the crater."] = "Nach den Abgaben in der Zuflucht noch unter Stufe 49,79? Hol dir den Rest an den Pterrordax an den Hängen östlich von {area:541}, bevor du den Krater verlässt.",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Die Silithiden der Centipaar krabbeln um die {area:982} im Westen von {zone:1446}, gleich östlich der Kraterrampe. Die Arbeiter sind am leichtesten zu ziehen.",
	-- ["The Gorishi hive"] = "Der Gorishi-Bau",
	-- ["The dead Threshadon lies by the water north of {npc:9619}."] = "Der tote Dreschadon liegt am Wasser nördlich von {npc:9619}.",
	-- ["The east side"] = "Die Ostseite",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Die Gorillas leben auf dem {area:1943}, östlich von {area:541}. Behalte ihre Felle für {npc:9619}. Bleib aus der tiefsten Höhle fern: {npc:9622} ist Stufe 55.",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Die Gorillas vom {area:1943} kommen in kleinen Gruppen und lassen für dich noch nichts fallen; {npc:9619}s Fellquest kommt später. Bleib aus der tiefsten Höhle fern: {npc:9622} ist Stufe 55.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Die Felle kommen nach Runde 2, auf dem Gorillaplateau",
	-- ["The pylon stands on the eastern cliffs."] = "Der Pylon steht auf den östlichen Klippen.",
	-- ["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "Der Pylon steht am Hang östlich des Zufluchtsorts. Pterrordax kreisen an den Hängen darum: Sie zählen für Spraggle und lassen die Schuppen von {npc:9998} fallen.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "Der Pylon steht am Hang östlich der Zuflucht. {npc:9166} kreisen über den Hängen darum: Sie zählen für {npc:9997} und lassen die Schuppen für {npc:9998} fallen.",
	-- ["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "Der Pylon steht auf den westlichen Klippen. {npc:9167} fliegen über die ganze Westseite.",
	-- ["The relics are in the {zone:1428}: keep it"] = "Die Relikte sind in der {zone:1428}: Behalte es",
	-- ["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",
	-- ["Top up here to level 49.51 before the hand-ins at {area:541}: they take you to level 50. Or, with a group, run the {area:2100} dungeon instead."] = "Füll hier bis Stufe 49,51 auf, bevor du bei {area:541} abgibst: Dadurch erreichst du Stufe 50. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:2100}.",
	-- ["Top up here to level 50.4 before the hand-ins at {area:3137}: they take you to level 51."] = "Füll hier bis Stufe 50,4 auf, bevor du bei {area:3137} abgibst: Dadurch erreichst du Stufe 51.",
	-- ["Western Pylon"] = "Westlicher Kristallpylon",
	-- ["Xiggs waits in the {object:32359}."] = "Xiggs wartet im {object:32359}.",
	-- ["grind on Pterrordax"] = "Grinde an Pterrordax",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "Grinde an den Wüstenläufern oder den Ogern der Dünenbrecher um {area:976}",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "Grinde an {npc:5458} bei {area:982}, {zone:1446}",
	-- ["grind on {npc:6116}"] = "Grinde an {npc:6116}",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "Grinde an {npc:6514} auf dem {area:1943}, {zone:1449}",
	-- ["grind on {npc:9164}"] = "Grinde an {npc:9164}",
	-- ["grind on {npc:9167}"] = "Grinde an {npc:9167}",
	-- ["{area:144} flight master"] = "Flugmeister in {area:144}",
	-- ["{area:978} (optional)"] = "{area:978} (optional)",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: Der letzte Guide bringt dich per Ruhestein hierher, daher ist das meist sofort abgehakt",
	-- ["{npc:7564}, once he has brewed the elixir: a few seconds"] = "{npc:7564}, sobald er das Elixier gebraut hat: ein paar Sekunden",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, hinten in der Höhle",
	-- ["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: Die Schlammbestien sind in {zone:1448}, behalte es",
	-- ["{npc:9618} stands just outside the refuge."] = "{npc:9618} steht gleich vor der Zuflucht.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Der Bau von {npc:9684} liegt im Dschungel nördlich von {npc:9619}, unterhalb der östlichen Klippen: Benutze dort {item:11568}. {npc:9684} ist Stufe 56: Fang mit voller Gesundheit an.",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9997}s Freund {npc:9999} wird vermisst.",
	-- ["{npc:9998}, at the refuge entrance"] = "{npc:9998}, am Eingang der Zuflucht",
	-- ["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, am Eingang der Zuflucht",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} sitzt am Südosthang des {area:537}, in der Mitte des Kraters.",
}
