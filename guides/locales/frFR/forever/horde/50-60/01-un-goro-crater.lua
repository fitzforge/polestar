-- French (frFR): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Into Un'Goro Crater
	-- {area:490} Un'Goro Crater
	["Into {area:490}"] = "",
	-- {area:1938} Broken Pillar · {area:490} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "",

	-- Step 3: Bloodpetal Thresher on the way
	-- {npc:6511} Bloodpetal Thresher
	["{npc:6511} on the way"] = "",

	-- Step 4: Super Sticky Tar on the way
	-- {item:11834} Super Sticky Tar
	["{item:11834} on the way"] = "",

	-- Step 5: Out of the refuge
	["Out of the refuge"] = "Hors du refuge",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, à l'entrée du refuge",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, juste dehors",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "Dès maintenant, ramassez chaque Cristal de puissance (bleu, vert, rouge, jaune) et chaque tas de {quest:3761} sur votre route : 25 terres en tout, 20 pour Hamuul et 5 pour Pestlezugg.",

	-- Step 6: Webbed Diemetradon Scale on the way
	-- {item:11830} Webbed Diemetradon Scale
	["{item:11830} on the way"] = "",

	-- Step 7: The Gorishi hive
	["The Gorishi hive"] = "La ruche Gorishi",
	-- {npc:9998} Shizzle
	["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. Pterrordax nest on the cliffs above the hive; their scales are for {npc:9998}."] = "",

	-- Step 8: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "",
	-- {item:11834} Super Sticky Tar · {area:537} Fire Plume Ridge
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Gorishi Workers = {npc:6552} Gorishi Worker
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}.\nRide south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nThe crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons.\nCareful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast Silithid Pox and Tunnelers and the Hive Guard use Tunneler Acid."] = "",
	-- {npc:6512} Bloodpetal Trapper
	["grind on {npc:6512}"] = "",

	-- Step 9: Un'Goro Crater: kill these as you meet them
	-- {area:490} Un'Goro Crater
	["{area:490}: kill these as you meet them"] = "",
	-- {npc:9998} Shizzle · {npc:8659} Jes'rimon · {npc:9167} Frenzied Pterrordax
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "",
	-- {npc:9164} Elder Diemetradon
	["grind on {npc:9164}"] = "",

	-- Step 10: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Stégodons et ravasaures",

	-- Step 11: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "L'équipement perdu de l'expédition se trouve dans la jungle du sud-ouest.",

	-- Step 12: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",
	-- {npc:6551} Gorishi Wasp
	["grind on {npc:6551}"] = "",

	-- Step 13: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} campe dans le coin sud-est du cratère.",

	-- Step 14: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "Au nord de Torwa, un battrodon mort gît au bord de l'eau.",

	-- Step 16: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Compagnes de Lar'korwi ({npc:9683})",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "Les Compagnes de Lar'korwi ({npc:9683}) rôdent dans la jungle au nord-ouest de {npc:9619}.",

	-- Step 17: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "Le radeau est sur la rive du lac du sud-est ; le petit paquetage est dans l'eau à côté.",
	["Underwater"] = "",

	-- Step 19: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "",
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time."] = "",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, butin rare",
	["Use the Mangled Journal to start it"] = "Utilisez Un journal abîmé pour la commencer",
	-- {npc:6507} Ravasaur Hunter
	["grind on {npc:6507}"] = "",

	-- Step 20: Bloodpetal Lasher on the way
	-- {npc:6509} Bloodpetal Lasher
	["{npc:6509} on the way"] = "",
	-- {npc:6509} Bloodpetal Lasher · {area:541} Marshal's Refuge
	["{npc:6509} along the way to {area:541}"] = "",

	-- Step 21: Un'Goro Crater: kill these as you meet them
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["The expedition's crate sits at an abandoned camp in the eastern jungle.\nRide north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "",

	-- Step 23: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, à l'entrée",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Gardez la quête {quest:4147} de {npc:9118} et la lettre de {npc:8737} pour des guides ultérieurs.",

	-- Step 24: Northern Pylon
	["Northern Pylon"] = "Pylône nord",
	["The pylon stands on the slope east of the refuge."] = "Le pylône se dresse sur la pente à l'est du refuge.",

	-- Step 25: Eastern Pylon
	["Eastern Pylon"] = "Pylône est",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Descendez le côté est du cratère jusqu'au pylône sur les falaises de l'est.",

	-- Step 26: Western Pylon
	["Western Pylon"] = "Pylône ouest",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Traversez le sud du cratère jusqu'au pylône sur les falaises de l'ouest.",

	-- Step 27: Level 51.81
	["Level 51.81"] = "",
	-- {area:16985} The Shaper's Terrace
	["Top up here to level 51.81 before the hand-ins at {area:16985}: they take you to level 52."] = "",

	-- Step 28: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "Retournez au nord jusqu'au {area:541}.",
	["Below ground"] = "",

	-- Step 29: Hearth to Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}"] = "",

	-- Step 30: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "",

	-- Step 31: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:10041} Gorishi Hive Queen
	["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "La quête suivante de Pestlezugg demande la {npc:10041}, un boss élite. Passez-la.",

	-- Step 32: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",

	-- Step 33: Into Redridge Mountains
	-- {zone:1433} Redridge Mountains
	["Into {zone:1433}"] = "",

	-- Step 34: Into Burning Steppes
	-- {area:46} Burning Steppes
	["Into {area:46}"] = "",

	-- Step 36: Level 52
	["Level 52"] = "",
	-- {quest:4061} The Rise of the Machines · {area:340} Kargath
	["Top up here to level 52: {quest:4061}, at {area:340}, needs level 52."] = "",
	-- {npc:7032} Greater Obsidian Elemental
	["grind on {npc:7032}"] = "",

	-- Step 37: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {area:3} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {area:3}."] = "",

	-- Step 38: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Voler jusqu'à {area:340}",

	-- Step 39: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "Vers la {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Prenez le col à l'ouest de {area:340} vers la {zone:1427}, puis traversez la gorge vers le sud jusqu'au long pont qui mène au {area:254}. À l'intérieur, descendez les passerelles à chaînes et sortez par le sud ; évitez les chemins vers les portails de donjon.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Pont vers le {area:254}",

	-- Step 40: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "La montagne débouche près du {area:252}, plein d'orcs de niveau 55-57. Suivez la route vers l'est le long des falaises du nord jusqu'au camp de la Horde à la {area:251}.",

	-- Step 41: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900 · {npc:7039} War Reaver · {quest:4296} Tablet of the Seven
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence.\nRide west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "",

	-- Step 42: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Longez les falaises vers le sud jusqu'au {quest:3821}, la colline des ogres Brûlentrailles. Les restes de {npc:9136} gisent à son pied.",

	-- Step 43: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} arpente les grottes et galeries de mine du {quest:3821} ; s'il est absent, tuez les ogres autour des entrées jusqu'à son retour.",

	-- Step 44: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Retournez au nord-est à la {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Gardez la Lettre de {npc:10267} : {quest:4808} est à {area:2255}, {zone:1452}.",

	-- Step 45: Kargath
	-- {npc:2921} Lotwil Veriatus · {area:1584} Blackrock Depths
	["Theodora's next errand goes to {npc:2921} east of town and then into {area:1584}: skip it."] = "",

	-- Step 47: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "",
	-- {area:340} Kargath
	["{area:340} flight master"] = "",

	-- Step 48: Apothecary Lydon
	["Inside"] = "",

	-- Step 49: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 50: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "",

	-- Step 51: Undercity
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, près du maître des chauves-souris",
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, l'Apothicarium : les fioles se remplissent plus tard en {zone:1447}",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",

	-- Step 53: The Bulwark
	-- {zone:1458} Undercity · {area:85} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Prenez une {object:176092} dans la caisse à côté de Derrington pour {quest:5096}, à faire au retour. Équipez la {quest:5401} : les Pierres du Fléau ne tombent que si vous la portez.",

	-- Step 55: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {area:139} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "",

	-- Step 56: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The book lies in the ruined inn of {area:2627}.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "",
	["Upstairs"] = "",

	-- Step 57: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Revenez au sud jusqu'à la route et suivez-la vers l'est à travers toute la zone jusqu'à la {area:2268}.",

	-- Step 58: Eastern Plaguelands: kill these as you meet them
	-- {area:139} Eastern Plaguelands
	["{area:139}: kill these as you meet them"] = "",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Avec la quête de {npc:11063} dans votre journal, le Fléau tué laisse parfois un {npc:11064} ; parlez-lui pour le libérer. Tuez des morts-vivants en chevauchant vers le sud-ouest jusqu'à {area:2262}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Libérez des Esprits de Darrowshire ({npc:11064}) : parlez-leur",

	-- Step 59: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "Le fantôme de {npc:10926} se tient dans les ruines de {area:2262}, au sud-ouest.",

	-- Step 60: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "La tête de la poupée et ses deux côtés sont dans les maisons autour de {npc:10926} ; assemblez-les depuis vos sacs.",

	-- Step 61: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "Gardez {quest:5152} : Marlene vit à la {area:197}, dans les {zone:1422}.",

	-- Step 62: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "",

	-- Step 63: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "",

	-- Step 64: Hearth to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Hearth to {area:2268}"] = "",

	-- Step 65: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Retour à la {area:2268}",
	["The next guide starts here, at the chapel's flight master."] = "Le guide suivant commence ici, au maître de vol de la chapelle.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Black Broodlings"] = "Rejetons noirs",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Les Rejetons noirs nichent dans les collines juste à l'est de la {area:251}. Utilisez le {item:12284} de {npc:10267} sur un rejeton presque mort pour capturer son essence.",
	-- ["Bloodpetal Flayers"] = "Ecorcheurs Pétale-de-sang",
	-- ["Darrowshire Spirits"] = "Esprits de Darrowshire ({npc:11064})",
	-- ["Escort {npc:9999}"] = "Escorter {npc:9999}",
	-- ["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Volez jusqu'à {area:1637} et entraînez-vous avant le zeppelin de {object:3202} : l'étape à {zone:1458} plus loin dans ce guide n'a pas de maître chasseur ni chaman.",
	-- ["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "Volez jusqu'à {area:1637}, prenez le zeppelin pour {object:3202} puis volez jusqu'à {area:340}, construit dans les falaises du bord ouest de {zone:1418}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Volez vers {area:1638} et entraînez-vous auprès de {npc:3033} ({area:1639}), puis volez jusqu'à {area:1637} pour le zeppelin de {object:3202}.",
	-- ["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Suivez la route vers l'est à travers les {zone:1422} et traversez la rivière vers les {zone:1423} ; quittez-la vers le nord pour {area:2627}, la ville en ruine du nord-ouest. {npc:12384} est assis dans une cabane à sa lisière.",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "Depuis le {area:1938}, chevauchez vers l'ouest jusqu'à la longue rampe qui descend dans le {zone:1449}, puis longez la paroi nord du cratère jusqu'au {area:541}, un camp dans les grottes de la falaise. Tout le monde ici est neutre.",
	-- ["Gorillas"] = "Gorilles",
	-- ["Into {zone:1449}"] = "Vers le {zone:1449}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Gardez l'appât : {npc:9684} est de niveau 56, et la seconde boucle passe par son repaire.",
	-- ["Lashers and Threshers"] = "Flagellants et Batteurs",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Menez {npc:9999} au nord jusqu'au {area:541}. Quand il s'évanouit, utilisez la {item:11804} sur lui pour le réveiller.",
	-- ["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Quittez {zone:1458} et suivez la route vers l'est à travers les {zone:1420} jusqu'à la {area:152}, le fort réprouvé de la frontière.",
	-- ["Power Crystals and soil"] = "Cristaux de puissance et terre",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Chevauchez vers l'est jusqu'au volcan ({area:537}), escaladez-le et utilisez {npc:10541} sur la cheminée de lave près du sommet, puis revenez à l'ouest voir {npc:10302}.",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Chevauchez vers le nord par le côté est. Les Flagellants et Batteurs Pétale-de-sang remplissent la jungle.",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Chevauchez vers le sud-ouest le long des falaises de l'ouest. Les {npc:9167} survolent le côté ouest, et les Trappeurs Pétale-de-sang poussent dans la même jungle.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Chevauchez vers le sud-ouest jusqu'au volcan au milieu du cratère : {area:537}. Les Ecorcheurs Pétale-de-sang poussent à son pied.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "Chevauchez vers l'ouest jusqu'au site de fouilles. Les golems {npc:7039} (53) y rôdent et lâchent souvent les éclats ; la {quest:4296} se dresse au milieu, parmi les nains de Thaurissan. Copiez-la.",
	-- ["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "Au sud des sources chaudes, les stégodons broutent ; les Os de dinosaure tombent sur eux ou gisent au sol. Les dimeurtrodons voisins portent les écailles que veut {npc:9998}. Les ravasaures chassent en meute au sud-ouest : leurs griffes sont pour {npc:8659}, et parfois l'un d'eux porte Un journal abîmé (butin rare : prenez sa quête seulement si vous l'obtenez). Évitez Gruff, un stégodon de niveau 57.",
	-- ["Termite mounds"] = "Termitières",
	-- ["Thaurissan dig site"] = "Site de fouilles de Thaurissan",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Les Grandes termitières parsèment les collines à l'est de {area:2627}. Utilisez le {item:15042} sur chaque termitière rencontrée.",
	-- ["The book lies in the ruined inn of {area:2627}."] = "Le livre est dans l'auberge en ruine de {area:2627}.",
	-- ["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Les amas de cristaux sont partout dans le cratère, beaucoup autour du volcan ({area:537}). Prenez-en quelques-uns de plus de chaque couleur pour les pylônes.",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "La caisse de l'expédition est dans un camp abandonné de la jungle de l'est.",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Les gorilles vivent sur le plateau du nord-est. N'entrez pas dans la grotte la plus profonde : {npc:9622} y vit.",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "La ruche silithide occupe le sud du cratère. Les guêpes et ouvriers Gorishi lâchent la Glande olfactive Gorishi ; utilisez la fiole sur la masse d'œufs dans la première salle. La Reine Gorishi, au fond, est un boss élite : n'entrez pas dans sa salle. Les {npc:9166} nichent sur les falaises au-dessus de la ruche ; leurs écailles sont pour {npc:9998}.",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Les fosses de goudron sont juste au sud du refuge. Les Bêtes, Rôdeurs et Rampeurs du goudron lâchent le {item:11834}.",
	-- ["The wooden sign beside {npc:9997}"] = "Le panneau en bois à côté de {npc:9997}",
	-- ["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "La tâche suivante de Theodora passe par Lotwil à l'est du bourg, puis par les {area:1584} : passez-la.",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "La quête de Theodora à {area:340} demande le niveau 52. Les Rôdeurs du goudron et Seigneurs du goudron juste au sud du refuge sont le camp le plus proche.",
	-- ["Western jungle"] = "Jungle de l'ouest",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "tuez des Rôdeurs du goudron aux {area:538}, {zone:1449}",
	-- ["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} vous envoie voir {npc:9298} à {zone:1452} : gardez la quête.",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Le gobelin {npc:10302} se trouve aux {area:543}, juste à l'est du pylône.",
	-- ["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250} rôde juste à l'ouest de {area:2262}.",
	-- ["{npc:8390}, the {object:36072}: the vials fill in {zone:1447} later"] = "{npc:8390}, {object:36072} : les fioles se remplissent plus tard en {zone:1447}",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, au fond de la grotte",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619} demande maintenant la fourrure d'{npc:9622}, dans la grotte du nord-est : passez-la.",
	-- ["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "{npc:9623} demande ensuite une {item:10561}, un objet d'{skill:202}. Passez-la sauf si vous en avez une.",
	-- ["{npc:9623}, the robot on the plateau"] = "{npc:9623}, le robot sur le plateau",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Le repaire de {npc:9684} est juste au sud du pylône. Utilisez-y l'appât de {npc:9619} ; {npc:9684} est de niveau 56 et frappe fort : commencez avec toute votre vie.",
	-- ["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} est assis sur la crête, perdu et épuisé.",
}
