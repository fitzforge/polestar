-- German (deDE): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "Hinab in den {zone:1449}",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "Reite von der {area:1938} nach Westen zur langen Rampe, die sich in den {zone:1449} hinabwindet, und folge dann der Nordwand des Kraters nach {area:541}, einem Lager in den Klippenhöhlen. Alle hier sind neutral.",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Das Holzschild neben {npc:9997}",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}, hinten in der Höhle",

	-- Step 2: Out of the refuge
	["Out of the refuge"] = "Raus aus der Zuflucht",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, am Eingang der Zuflucht",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, gleich draußen",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "Sammle ab jetzt jeden Machtkristall (blau, grün, rot, gelb) und jeden Haufen {quest:3761} auf deinem Weg ein: insgesamt 25 Erde, 20 für Hamuul und 5 für Pestlezugg.",

	-- Step 3: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Die Teergruben liegen gleich südlich der Zuflucht. Teerbestien, Teerlauerer und Teerkriecher lassen {item:11834} fallen.",

	-- Step 4: Western jungle
	["Western jungle"] = "Westlicher Dschungel",
	-- {npc:9167} Frenzied Pterrordax
	-- plural, as words: Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Reite an den westlichen Klippen entlang nach Südwesten. {npc:9167} fliegen über die Westseite, und Blutblütenfallen wachsen im selben Dschungel.",

	-- Step 5: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Stegodons und Ravasaurier",
	-- {npc:9998} Shizzle · {npc:8659} Jes'rimon
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "Südlich der heißen Quellen grasen Stegodons; Dinosaurierknochen fallen von ihnen oder liegen am Boden. Dimetrodons in der Nähe tragen die Schuppen, die {npc:9998} will. Ravasaurier jagen im Südwesten in Rudeln: Ihre Klauen sind für {npc:8659}, und ab und zu trägt einer Ein zerfleddertes Tagebuch (seltene Beute: Nimm dessen Quest nur an, wenn du eins bekommst). Meide Gruff, einen Stegodon der Stufe 57.",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, seltene Beute",
	["Use the Mangled Journal to start it"] = "Benutze Ein zerfleddertes Tagebuch, um sie zu starten",

	-- Step 6: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "Die verlorene Ausrüstung der Expedition liegt im südwestlichen Dschungel.",

	-- Step 7: The Gorishi hive
	["The Gorishi hive"] = "Der Schwarm der Gorishi",
	-- {npc:9166} Pterrordax · {npc:9998} Shizzle
	["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "Der Silithidenschwarm füllt den Süden des Kraters. Wespen und Arbeiter der Gorishi lassen die Duftdrüse fallen; benutze die Kratzphiole an der Eiermasse in der ersten Kammer. Die Schwarmkönigin ganz unten ist ein Elite-Boss: Bleib aus ihrer Kammer fern. {npc:9166} nisten auf den Klippen über dem Schwarm; ihre Schuppen sind für {npc:9998}.",

	-- Step 8: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "Das Floß liegt am Ufer des südöstlichen Sees; das kleine Bündel liegt daneben im Wasser.",

	-- Step 9: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} lagert in der Südostecke des Kraters.",

	-- Step 10: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "Nördlich von Torwa liegt ein toter Dreschadon am Wasser.",

	-- Step 12: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Lar'korwi-Weibchen",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "Die Lar'korwi-Weibchen streifen durch den Dschungel nordwestlich von {npc:9619}.",

	-- Step 13: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Behalte den Köder: {npc:9684} ist Stufe 56, und die zweite Runde führt an seinem Unterschlupf vorbei.",

	-- Step 14: Lashers and Threshers
	["Lashers and Threshers"] = "Peitscher und Drescher",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Reite an der Ostseite nach Norden. Blutblütenpeitscher und -drescher füllen den Dschungel.",

	-- Step 15: Crate of Foodstuffs
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "Die Kiste der Expedition steht in einem verlassenen Lager im östlichen Dschungel.",

	-- Step 16: Gorillas
	["Gorillas"] = "Gorillas",
	-- {npc:9622} U'cha
	["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Die Gorillas leben auf dem nordöstlichen Plateau. Bleib aus der hintersten Höhle fern: Dort lebt {npc:9622}.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau"] = "{npc:9623}, der Roboter auf dem Plateau",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "{npc:9623} will dann ein {item:10561}, einen Gegenstand aus {skill:202}. Überspringe das, außer du hast eins.",

	-- Step 17: Bloodpetal Flayers
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer
	["Bloodpetal Flayers"] = "Blutblütenschinder",
	-- {area:537} Fire Plume Ridge
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Reite nach Südwesten zum Ort {area:537}, dem Vulkan in der Mitte des Kraters. Blutblütenschinder wachsen um seinen Fuß.",

	-- Step 18: Power Crystals and soil
	["Power Crystals and soil"] = "Machtkristalle und Erde",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Die Kristallgruppen stehen überall im Krater, viele rund um den Ort {area:537}. Nimm von jeder Farbe ein paar mehr für die Pylonen mit.",

	-- Step 19: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} sitzt verirrt und erschöpft auf dem Grat.",

	-- Step 20: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Eskortiere {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Führe {npc:9999} nach Norden nach {area:541}. Wenn er ohnmächtig wird, benutze {item:11804} an ihm, um ihn zu wecken.",

	-- Step 21: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, am Eingang",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Behalte {quest:4147} von {npc:9118} und den Brief von {npc:8737} für spätere Guides.",

	-- Step 22: Northern Pylon
	["Northern Pylon"] = "Nördlicher Kristallpylon",
	["The pylon stands on the slope east of the refuge."] = "Der Pylon steht am Hang östlich der Zuflucht.",

	-- Step 23: Eastern Pylon
	["Eastern Pylon"] = "Östlicher Kristallpylon",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Reite die Ostseite des Kraters hinab zum Pylon auf den östlichen Klippen.",

	-- Step 24: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Der Unterschlupf von {npc:9684} liegt gleich südlich des Pylons. Benutze dort {npc:9619}s Köder; {npc:9684} ist Stufe 56 und schlägt hart zu, also fang mit voller Gesundheit an.",

	-- Step 25: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619} will jetzt das Fell von {npc:9622}, zurück in der nordöstlichen Höhle: Überspringe es.",

	-- Step 26: Western Pylon
	["Western Pylon"] = "Westlicher Kristallpylon",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Durchquere den Süden des Kraters zum Pylon auf den westlichen Klippen.",

	-- Step 27: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Der Goblin {npc:10302} sitzt am Ort {area:543}, gleich östlich des Pylons.",

	-- Step 28: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Reite nach Osten zum Ort {area:537}, steig hinauf und benutze {npc:10541} am Lavaschlot nahe dem Gipfel; reite dann zurück nach Westen zu {npc:10302}.",

	-- Step 29: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} schickt dich zu {npc:9298} in {zone:1452}: Behalte es.",

	-- Step 30: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "Reite nach Norden zurück nach {area:541}.",

	-- Step 31: Lakkari Tar Pits
	-- {area:340} Kargath
	-- plural, as words: Tar Lurkers = {npc:6518} Tar Lurker · Tar Lords = {npc:6519} Tar Lord
	["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "Theodoras Quest in {area:340} braucht Stufe 52. Die Teerlauerer und Teerfürsten gleich südlich der Zuflucht sind das nächste Lager.",
	-- {area:538} Lakkari Tar Pits · {zone:1449} Un'Goro Crater
	-- plural, as words: Tar Lurkers = {npc:6518} Tar Lurker
	["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "Töte Teerlauerer an den {area:538}, {zone:1449}",

	-- Step 32: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen
	["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "Pestlezuggs nächste Quest braucht die {npc:10041}, einen Elite-Boss. Überspringe sie.",

	-- Step 33: Orgrimmar
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity
	["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Flieg nach {area:1637} und trainiere vor dem Zeppelin nach {object:3202}: Der Halt in {zone:1458} später in diesem Guide hat keinen Jäger- oder Schamanenlehrer.",

	-- Step 34: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:1637} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Flieg nach {area:1638} und trainiere bei {npc:3033} im Gebiet {area:1639}; flieg dann nach {area:1637} zum Zeppelin nach {object:3202}.",

	-- Step 35: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Flieg nach {area:340}",
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {area:340} Kargath · {zone:1418} Badlands
	["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "Flieg nach {area:1637}, nimm den Zeppelin nach {object:3202} und flieg von dort nach {area:340}, das in die Klippen am Westrand des Gebiets {zone:1418} gebaut ist.",

	-- Step 36: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "In die {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Nimm den Pass an der Westseite von {area:340} in die {zone:1427} und reite dann nach Süden durch die Schlucht zur langen Brücke in den Berg ({area:254}). Folge drinnen den Kettenstegen nach unten und verlass ihn durch den Südausgang; bleib von den Wegen zu den Dungeonportalen fern.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Brücke in den Berg ({area:254})",

	-- Step 37: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "Der Berg lässt dich neben der {area:252} hinaus, voller Orcs der Stufe 55-57. Folge der Straße an den nördlichen Klippen nach Osten zum Lager der Horde am {area:251}.",

	-- Step 38: Black Broodlings
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings"] = "Schwarze Brutlinge",
	-- {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Schwarze Brutlinge nisten in den Hügeln gleich östlich vom {area:251}. Benutze {npc:10267}s {item:12284} an einem fast toten Brutling, um seine Essenz einzufangen.",

	-- Step 39: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Folge den Klippen nach Süden zum {quest:3821}, dem Hügel der Oger der Feuermägen. Die Überreste von {npc:9136} liegen an seinem Fuß.",

	-- Step 40: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} durchstreift die Höhlen und Minenstollen des {quest:3821}; ist er nicht da, räum die Oger an den Eingängen weg, bis er zurückkommt.",

	-- Step 41: Thaurissan dig site
	["Thaurissan dig site"] = "Thaurissanische Ausgrabungsstätte",
	-- {npc:7039} War Reaver · {quest:4296} Tablet of the Seven
	["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "Reite nach Westen zur Ausgrabungsstätte. {npc:7039}-Golems (53) stampfen dort herum und lassen oft die Splitter fallen; die {quest:4296} steht in der Mitte zwischen den Thaurissanischen Zwergen. Kopiere sie.",

	-- Step 42: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Zurück nach Nordosten zum {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Behalte {npc:10267}s Brief: {quest:4808} ist in {area:2255}, {zone:1452}.",

	-- Step 43: Kargath
	-- {area:1584} Blackrock Depths
	["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "Theodoras nächster Auftrag führt zu Lotwil östlich der Stadt und dann in die {area:1584}: Überspringe ihn.",

	-- Step 44: Undercity
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, neben dem Fledermausführer",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, im Apothekarium: Die Phiolen füllst du später in {zone:1447}",

	-- Step 45: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Verlass {zone:1458} und reite auf der Straße nach Osten durch {zone:1420} zum {area:152}, der Festung der Verlassenen an der Grenze.",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Nimm einen {object:176092} aus der Kiste neben Derrington für {quest:5096}, die du auf dem Rückweg erledigst. Leg die {quest:5401} an: Geißelsteine fallen nur, solange du sie trägst.",

	-- Step 46: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Folge der Straße nach Osten durch das Gebiet {zone:1422} und über den Fluss ins Gebiet {zone:1423}; verlass es nach Norden zum {area:2627}, der zerstörten Stadt im Nordwesten. {npc:12384} sitzt in einer Hütte an ihrem Rand.",

	-- Step 47: Augustus' Receipt Book
	-- {area:2627} Terrordale
	["The book lies in the ruined inn of {area:2627}."] = "Das Buch liegt im zerstörten Gasthaus von {area:2627}.",

	-- Step 49: Termite mounds
	["Termite mounds"] = "Termitenhügel",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Die Großen Termitenhügel stehen überall in den Hügeln östlich von {area:2627}. Benutze den {item:15042} an jedem Hügel, an dem du vorbeikommst.",

	-- Step 50: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Reite nach Süden zurück zur Straße und folge ihr nach Osten durch das ganze Gebiet zur {area:2268}.",

	-- Step 51: Darrowshire Spirits
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Darrowshire Spirits"] = "Geister von Darrowshire",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Mit {npc:11063}s Quest im Questlog hinterlässt erschlagene Geißel manchmal einen {npc:11064}; sprich mit ihm, um ihn zu befreien. Töte Untote auf dem Ritt nach Südwesten nach {area:2262}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Befreie Geister von Darrowshire: Sprich mit ihnen",

	-- Step 52: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}s Geist steht in den Ruinen von {area:2262} im Südwesten.",

	-- Step 53: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "Der Kopf der Puppe und ihre beiden Seiten liegen in den Häusern um {npc:10926}; füge sie in deinen Taschen zusammen.",

	-- Step 54: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "Behalte {quest:5152}: Marlene wohnt am {area:197} im Gebiet {zone:1422}.",

	-- Step 55: Zaeldarr the Outcast
	-- {npc:12250} Zaeldarr the Outcast · {area:2262} Darrowshire
	["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250} lauert gleich westlich von {area:2262}.",

	-- Step 56: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Zurück zur {area:2268}",
	["The next guide starts here, at the chapel's flight master."] = "Der nächste Guide beginnt hier, beim Flugmeister der Kapelle.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Verlass {zone:1458} und reite auf der Straße nach Osten durch {zone:1420} zum Ort {area:152}, der Festung der Verlassenen an der Grenze.",
}
