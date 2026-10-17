-- French (frFR): the guide forever/horde/orc-troll/01-durotar (forever/horde/orc-troll/01-durotar.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, à votre point de départ",

	-- Step 2: Gornek
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} attend dans l'Antre, le bâtiment juste à l'ouest de {npc:10176}.",

	-- Step 3: Training weapons and boars
	["Training weapons and boars"] = "Armes d'entraînement et sangliers",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "Les armes traînent autour de l'Antre et du terrain d'entraînement ; les Sangliers tachetés parcourent tout le fond de la vallée.",

	-- Step 4: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} se tient juste à l'entrée de la grotte ; {npc:3159} au fond de la grotte, derrière lui.",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave"] = "{npc:3159}, au fond de la grotte",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}, le maître des démonistes au fond de la grotte",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}, le maître des voleurs dans l'Antre",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}, le maître des guerriers à côté de l'Antre",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}, le maître des chasseurs à côté de l'Antre",
	-- {npc:3707} Ken'jai
	["{npc:3707}, the priest trainer at the Den"] = "{npc:3707}, le maître des prêtres à l'Antre",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}, le maître des chamans à côté de l'Antre",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}, le maître des mages, à l'entrée de l'Antre",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, près du feu de cuisine",

	-- Step 5: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} gît blessé au pied des collines au nord-ouest de l'Antre.",

	-- Step 6: Sarkoth
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way."] = "{quest:790}, un grand scorpide, rôde sur la pente au sud de {npc:3287} parmi les Scorpides ouvriers ; cueillez les Pommes de cactus près des cactus en chemin.",

	-- Step 8: Back to the Den
	["Back to the Den"] = "Retour à l'Antre",

	-- Step 9: Foreman Thazz'ril
	["The foreman stands at the lumber pile east of the Den."] = "Le contremaître se tient près du tas de bois à l'est de l'Antre.",

	-- Step 10: Lazy Peons
	-- {item:16114} Foreman's Blackjack
	["Hit the sleeping peons north of the Den with the {item:16114}."] = "Frappez les péons endormis au nord de l'Antre avec la {item:16114}.",
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Réveillez {quest:5441} avec la {item:16114}",

	-- Step 12: North end of the valley
	["North end of the valley"] = "Extrémité nord de la vallée",
	-- {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "{quest:792} grouillent sur la pente sous {area:365}, la grotte du côté nord de la vallée.",

	-- Step 13: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "Dans la grotte, allez tout droit à la première bifurcation, puis à droite, et suivez le ruisseau sur votre gauche jusqu'à la cascade : la pioche brille près de l'eau, derrière une colonne de roche.",

	-- Step 14: Back at the Den
	["Back at the Den"] = "De retour à l'Antre",

	-- Step 15: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller
	["{npc:5887} stands just outside the Den."] = "{npc:5887} se tient juste devant l'Antre.",

	-- Step 17: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "Dans la grotte, longez la paroi de droite tout du long, en passant le ruisseau : {npc:3183} attend au fond.",

	-- Step 18: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Sabots de {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Les Traqueurs corrompus parcourent la pente sous la grotte, du côté nord de la vallée.",

	-- Step 19: Zureetha Fargaze
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "le {object:654925} par terre à côté d'elle",

	-- Step 20: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} se tient devant l'Antre. {area:639} est la colline juste au sud : buvez-y le {item:6635} pour voir la {npc:5891}, puis rapportez le {item:6656} à {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, sur {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887} : {npc:5873} et votre {item:5175}",

	-- Step 21: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} se tient sur la route, à la sortie est de la vallée.",

	-- Step 22: Sen'jin Village
	-- {area:367} Sen'jin Village
	["Follow the road east out of the valley to {area:367} on the coast."] = "Suivez la route vers l'est hors de la vallée jusqu'au {area:367}, sur la côte.",

	-- Step 23: Ridgeshade spiders
	["Ridgeshade spiders"] = "Araignées noirecrête",
	-- {area:362} Razor Hill
	["The spiders lurk in the hills along the road north toward {area:362}."] = "Les araignées se cachent dans les collines le long de la route au nord, vers {area:362}.",

	-- Step 24: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "Feu de camp de {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "{npc:265809} campe juste au sud de {area:362}. Asseyez-vous près de son feu de camp (/sit) jusqu'à ce que l'amélioration {spell:1229451} apparaisse.",

	-- Step 25: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town"] = "{npc:266940}, du côté est de la ville",
	-- {npc:3191} Cook Torka
	["Talk to {npc:3191}"] = "Parlez à {npc:3191}",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, dans la tour de guet",

	-- Step 26: Prickly pears
	["Prickly pears"] = "Figues de Barbarie",
	["The prickly pears grow among the quilboar huts just west of town."] = "Les figues de Barbarie poussent parmi les huttes des huran juste à l'ouest de la ville.",

	-- Step 28: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Les Hurans et les Eclaireurs Tranchecrin tiennent les huttes à l'ouest de la ville ; les Lève-poussière et les Gardes de guerre tiennent les camps plus à l'ouest.",

	-- Step 30: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "Le donjon se dresse sur la côte au sud-est de {area:362}. La hache, l'arc et le bouclier des pillards traînent aux abords. Les Marins et Soldats de marine de Kul Tiras laissent tomber les {item:4870}. {npc:3192} attend au sommet du donjon ; sa clé ouvre le coffre à côté de lui, qui contient la {item:4881}.",

	-- Step 32: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Follow the road north toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "Suivez la route au nord vers {zone:1454}. {npc:3293} campe à côté ; les sacs volés traînent le long de la route au sud de lui.",

	-- Step 33: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}."] = "Les Terrevent sauvages et les Sorcières des tempêtes Terrevent nichent dans {area:370}, à l'est de {npc:3293}. Une Sorcière des tempêtes laisse tomber l'{item:277661}.",

	-- Step 35: Thunder lizards
	["Thunder lizards"] = "Lézards-tonnerre",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}."] = "Les Lézards-tonnerre et les Foudroyants paissent sur {area:369}, juste à l'ouest et au sud-ouest de {npc:3293}.",

	-- Step 37: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "La hutte de Misha se trouve au sud des lézards. Les crocilisques le long de {area:814}, à l'ouest, portent l'{item:4891}.",

	-- Step 38: The wreckage
	["The wreckage"] = "L'épave",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin."] = "Les Boîtes à outils gnomes gisent dans l'épave le long du rivage à l'est et au sud-est de {area:362}. Suivez le rivage au sud jusqu'à Sen'jin.",

	-- Step 39: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881} : enchanteurs uniquement, le résidu s'obtient en désenchantant des Pendentifs maléficiés",

	-- Step 40: Makrura and crawlers
	["Makrura and crawlers"] = "Makruras et clampants",
	["Makrura and surf crawlers line the beaches north-east of Sen'jin."] = "Les makruras et les Clampants de l'écume bordent les plages au nord-est de Sen'jin.",

	-- Step 41: Bloodtalon Matriarch
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there."] = "Traversez à gué jusqu'à l'île de l'Écho la plus au nord. La Matriarche y rôde parmi les raptors.",

	-- Step 42: Echo Isles
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "Dirigez-vous vers le sud à travers les îles. Les idoles des loas sont éparpillées sur les îles du sud ; les Trolls vaudous et les Trolls maléficiés les gardent et laissent tomber les Pendentifs maléficiés. {quest:826} et la cage de Minshina se trouvent sur l'île la plus au sud.",

	-- Step 43: South-east shore
	["South-east shore"] = "Rivage sud-est",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade back west to the shore south of Sen'jin. Durotar Tigers roam it and the Taillasher eggs sit in nests along the beach."] = "Revenez à gué vers l'ouest jusqu'au rivage au sud de Sen'jin. Des Tigres de Durotar ({npc:3121}) y rôdent et les Oeufs de fouette-queue reposent dans des nids le long de la plage.",

	-- Step 45: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366} se trouve à l'ouest de Sen'jin. Les trois plans d'attaque sont posés au sol parmi les tentes des centaures. {npc:275811} est aussi retenue à la Combe.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Libérez {npc:275811} et escortez-la hors de la Combe",

	-- Step 47: Razor Hill
	-- {area:362} Razor Hill
	["Follow the road north to {area:362}."] = "Suivez la route au nord jusqu'à {area:362}.",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, près de l'auberge",
	-- {npc:3706} Tai'jin · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["{npc:3706}, for {npc:6018} in {zone:1454}: keep it"] = "{npc:3706}, pour {npc:6018} à {zone:1454} : gardez-la",

	-- Step 48: Fizzle Darkstorm
	-- {area:369} Thunder Ridge · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	["Fizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way."] = "Fizzle tient le camp de la Lame ardente sur {area:369}, au nord-ouest de {area:362}. Chasseurs : apprivoisez un {npc:3099} avec le {item:15908} en chemin.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Apprivoisez-le avec le {item:15908}",

	-- Step 50: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} se tient sur le rivage à l'est de {area:362}. Le trident, la bannière et la dague traînent sur la plage autour de lui.",

	-- Step 51: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} campe sur la colline à l'ouest de la plage des nagas, au sud de {quest:827}.",

	-- Step 52: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "La porte principale d'{zone:1454} se trouve juste à l'ouest de {area:817}. {npc:5875} se tient dans {object:172960}, le canyon sous {object:172982}.",

	-- Step 53: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Entrée de {area:817}",

	-- Step 54: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Les sectateurs de la Lame ardente tiennent les grottes de {quest:827} ; chacun d'eux peut laisser tomber un {item:4871}. {npc:3204}, un démoniste de niveau 14, se tient au fond et laisse tomber l'{item:4903}.",

	-- Step 55: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "La {object:58595} se trouve dans {area:817}, parmi les sectateurs que vous venez de combattre.",

	-- Step 56: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "Retournez voir {npc:5875} dans {object:172960}. Utilisez les {item:7464} sur le cercle d'invocation et vainquez le marcheur du Vide pour le lier.",

	-- Step 58: Razor Hill
	-- {area:362} Razor Hill
	["Back south to {area:362}."] = "Retournez au sud jusqu'à {area:362}.",

	-- Step 59: Spitelash naga
	["Spitelash naga"] = "Nagas Fouette-bile",
	-- {npc:275657} Heglan Shadeeye · {area:370} Drygulch Ravine · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "Retournez à l'est jusqu'au rivage au nord de {npc:275657}. Les Eclaireurs et les Domestiques fouette-bile tiennent la plage sous {area:370}. Chasseurs : apprivoisez un {npc:3107} sur la plage.",

	-- Step 60: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "Retournez à {area:362}.",
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142} : {npc:275666}, un géant des mers élite",

	-- Step 61: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "{npc:275666}, un jeune géant des mers, arpente la côte nord de {zone:1411}, au nord de la plage des nagas. {npc:275666} est élite : il est conseillé de se grouper.",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, de retour à {area:362}",

	-- Step 62: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Les Scorpides blindés rampent dans les plaines à l'ouest de {area:362}. Apprivoisez-en un, puis retournez voir {npc:3171}.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "{npc:3171} : {npc:3352}, à {zone:1454}, enseigne {spell:5149}",

	-- Step 63: Ormak Grimshot
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:362} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Suivez la route au nord depuis {area:362} jusqu'à la porte principale d'{zone:1454}, juste à l'ouest de {area:817}. {npc:3352} se tient avec les maîtres des chasseurs dans {object:172958}.",

	-- Step 64: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} Barrens
	["Follow the road west from {area:362} over the {area:814} bridge; {area:379} sits just above it on the {zone:1413} side."] = "Suivez la route à l'ouest depuis {area:362} et franchissez le pont de {area:814} ; {area:379} se trouve juste au-dessus, côté {zone:1413}.",

	-- Step 65: Thunder lizards across the river
	["Thunder lizards across the river"] = "Lézards-tonnerre de l'autre côté du fleuve",
	-- {area:369} Thunder Ridge · {item:6486} Singed Scale
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Les Lézards-tonnerre et les Foudroyants paissent sur {area:369}, de l'autre côté du pont ; chacun d'eux peut laisser tomber une {item:6486}.",

	-- Step 67: The Crossroads
	-- {area:379} Far Watch Post · {area:380} The Crossroads · {zone:1413} Barrens
	["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Suivez la route au sud-ouest depuis {area:379} jusqu'à la {area:380}. Le guide des {zone:1413} commence ici.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Suivez la route au sud-ouest depuis {area:379} jusqu'à {area:380}. Le guide {zone:1413} commence ici.",
	-- ["{area:364}'s cave mouth"] = "Entrée de la grotte de {area:364}",
	-- ["{npc:3171}: Tame Beast"] = "{npc:3171} : Apprivoiser une bête",
	-- ["{npc:3352}: Beast Training"] = "{npc:3352} : Dressage des bêtes",
	-- ["{npc:5875}: Summon Voidwalker"] = "{npc:5875} : Invocation d'un marcheur du Vide",
}
