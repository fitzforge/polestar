-- Spanish (Latin America) (esMX): the guide forever/horde/troll/01-durotar (forever/horde/troll/01-durotar.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} espera dentro de la Guarida, el edificio justo al oeste de {npc:10176}.",
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, donde empiezas",
	["Inside"] = "",

	-- Step 2: Training weapons and boars
	["Training weapons and boars"] = "Armas de entrenamiento y jabalíes",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "Las armas están alrededor de la Guarida y del campo de entrenamiento; los Jabalíes jaspeados ({npc:3098}) recorren todo el fondo del valle.",

	-- Step 3: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} está justo dentro de la entrada de la cueva; {npc:3159}, al fondo de la cueva, detrás de él.",
	-- {npc:3143} Gornek
	["{npc:3143}, inside"] = "",
	-- {npc:3707} Ken'jai
	["{npc:3707}, the priest trainer at the Den"] = "{npc:3707}, el instructor de sacerdotes en la Guarida",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave; below ground"] = "",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, junto al fuego de cocina",

	-- Step 4: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} yace herido al pie de las colinas al noroeste de la Guarida.",

	-- Step 5: Valley of Trials: kill these as you meet them
	-- {area:363} Valley of Trials
	["{area:363}: kill these as you meet them"] = "",
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua · {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way.\nThe {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "",

	-- Step 6: Back to the Den
	["Back to the Den"] = "De vuelta a la Guarida",

	-- Step 7: Class trainer
	["Class trainer"] = "",

	-- Step 8: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:363} Valley of Trials
	["{npc:246344} in {zone:1456}; {area:363} has no paladin trainer"] = "",

	-- Step 9: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:363} Valley of Trials
	["{npc:3034} in {zone:1412}; {area:363} has no druid trainer"] = "",

	-- Step 10: Back to the Den
	-- {npc:11378} Foreman Thazz'ril
	["{npc:11378}, at the lumber pile east of the Den"] = "",

	-- Step 11: Lazy Peons
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Despierta a {quest:5441} con {item:16114}",

	-- Step 14: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "Dentro de la cueva, sigue derecho en la primera bifurcación, luego a la derecha y sigue el arroyo a tu izquierda hasta la cascada: el pico brilla junto al agua, detrás de una columna de roca.",

	-- Step 15: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "Dentro de la cueva, sigue la pared derecha todo el camino, pasando sobre el arroyo: {npc:3183} espera al final.",
	["Below ground"] = "",

	-- Step 16: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Pezuñas de {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Los acechadores viles recorren la ladera bajo la cueva, en el lado norte del valle.",

	-- Step 17: Zureetha Fargaze
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "{object:654925}, en el suelo a su lado",

	-- Step 18: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} está afuera de la Guarida. {area:639} es la colina justo al sur: bebe {item:6635} allí para ver a la {npc:5891} y luego llévale {item:6656} a {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, en {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} y tu {item:5175}",

	-- Step 19: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} está en el camino, en la salida este del valle.",

	-- Step 20: Sen'jin Village
	-- {area:367} Sen'jin Village
	["Follow the road east out of the valley to {area:367} on the coast."] = "Sigue el camino al este fuera del valle hasta {area:367}, en la costa.",
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: solo encantadores; el residuo se obtiene desencantando Colgantes embrujados ({item:275724})",
	-- {npc:5880} Un'Thuwa
	["{npc:5880}, the mage trainer in Sen'jin"] = "",

	-- Step 21: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "La fogata de {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "",

	-- Step 22: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town; inside"] = "",

	-- Step 23: Razor Hill
	-- {npc:3191} Cook Torka
	["{npc:3191}: Camping 101 asks you to learn it"] = "",
	-- {npc:6928} Innkeeper Grosk
	["{npc:6928}, inside"] = "",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, en la torre de vigilancia",

	-- Step 24: Prickly pears
	["Prickly pears"] = "Higos chumbos",
	["The prickly pears grow among the quilboar huts just west of town."] = "Los higos chumbos crecen entre las chozas de los jabaespines, justo al oeste del pueblo.",

	-- Step 26: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "El fuerte está en la costa al sureste de {area:362}. El hacha, el arco y el escudo de los asaltantes están en sus afueras. Los marineros y marines sueltan {item:4870}. {npc:3192} espera en lo alto del fuerte; su llave abre el cofre a su lado, que contiene {item:4881}.",
	["Upstairs"] = "",

	-- Step 27: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3147} Furl Scornbrow · {npc:3142} Orgnil Soulscar · {npc:266940} Turroc
	["Back north-west to {area:362}: {npc:3139} first, then {npc:3147} in the watchtower, then {npc:3142} and {npc:266940} on the way out east to the shore."] = "",
	-- {npc:266940} Turroc
	["{npc:266940}, inside"] = "",

	-- Step 28: Scuttle Coast: kill these as you meet them
	-- {area:373} Scuttle Coast
	["{area:373}: kill these as you meet them"] = "",
	-- {area:362} Razor Hill
	["Makrura and surf crawlers line the beaches north-east of Sen'jin; the Taillasher eggs sit in nests along the beach.\nThe gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin."] = "",
	["Underwater"] = "",

	-- Step 29: Bloodtalon Matriarch
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there; Durotar Tigers roam the isle and the shore south of Sen'jin."] = "",

	-- Step 30: Echo Isles: kill these as you meet them
	-- {area:368} Echo Isles
	["{area:368}: kill these as you meet them"] = "",
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle.\nWade back west to the shore south of Sen'jin when the isles are done."] = "",

	-- Step 32: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366} está al oeste de Sen'jin. Los tres planes de ataque están en el suelo entre las tiendas de los centauros. {npc:275811} también está cautiva en el risco.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Libera a {npc:275811} y acompáñala a salvo fuera del risco",

	-- Step 35: Level 10
	["Level 10"] = "",
	-- {quest:840} Conscript of the Horde · {area:362} Razor Hill
	["Top up here to level 10: {quest:840}, at {area:362}, needs level 10."] = "",
	-- {npc:3111} Razormane Quilboar
	["grind on {npc:3111}"] = "",

	-- Step 36: Razor Hill
	-- {npc:3169} Tarshaw Jaggedscar
	["{npc:3169}, inside"] = "",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, junto a la posada",
	-- {npc:3706} Tai'jin · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["{npc:3706}, for {npc:6018} in {zone:1454}: keep it"] = "{npc:3706}, para {npc:6018} en {zone:1454}: guárdala",

	-- Step 37: Far Watch Post
	-- {area:814} Southfury River · {npc:3337} Kargal Battlescar · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge: {npc:3337} stands at {area:379} above it, on your way to {npc:5907}."] = "",

	-- Step 42: Kranal Fiss
	-- {area:814} Southfury River · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge, past {area:379} and on along the ridge: {npc:5907} stands alone above the Razormane camp."] = "",

	-- Step 43: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back over the bridge and south along the {zone:1411} bank of the river to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "",

	-- Step 44: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Los jabaespines y exploradores ocupan las chozas al oeste del pueblo; los polvorosos y guardias de batalla ocupan los campamentos más al oeste.",

	-- Step 45: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Head north-east to the road toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "",

	-- Step 46: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb · {area:371} Dustwind Cave · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}. Shamans: the Burning Blade Cultists by {area:371}, at the ravine's south end, drop the {item:6652}."] = "",

	-- Step 47: Deathskip to Northern Durotar
	["Deathskip to Northern Durotar"] = "",
	-- {npc:3118} Dustwind Storm Witch · {npc:6491} Spirit Healer
	["Die to the mobs at 52.0,21.4 ({npc:3118}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 49: Thunder Ridge: kill these as you meet them
	-- {area:369} Thunder Ridge
	["{area:369}: kill these as you meet them"] = "",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nFizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly."] = "",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestícalo con {item:15908}",

	-- Step 50: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "La choza de Misha está al sur de los truenagartos. Los crocoliscos a lo largo de {area:814}, al oeste, llevan {item:4891}.",

	-- Step 52: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} está en la orilla al este de {area:362}. El tridente, el estandarte y la daga están en la playa a su alrededor.",

	-- Step 54: Paladin trainer
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:362} Razor Hill
	["{npc:246344} in {zone:1456}; {area:362} has no paladin trainer"] = "",

	-- Step 55: Mage trainer
	["Mage trainer"] = "",
	-- {npc:5884} Mai'ah · {zone:1411} Durotar · {area:362} Razor Hill
	["{npc:5884} in {zone:1411}; {area:362} has no mage trainer"] = "",

	-- Step 56: Druid trainer
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:362} Razor Hill
	["{npc:3034} in {zone:1412}; {area:362} has no druid trainer"] = "",

	-- Step 57: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3142} Orgnil Soulscar
	["Back to {area:362}: {npc:3139}, then {npc:3142}."] = "",

	-- Step 58: Spitelash naga
	["Spitelash naga"] = "Nagas Látigo de Ira",
	-- {area:370} Drygulch Ravine · {npc:275657} Heglan Shadeeye · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["North-east to the beach below {area:370}, north of {npc:275657}: Spitelash Scouts and Attendants hold it. Hunters: tame a {npc:3107} on the beach."] = "",

	-- Step 59: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} acampa en la colina al oeste de la playa de las nagas, al sur de {quest:827}.",

	-- Step 61: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "La puerta principal de {zone:1454} está justo al oeste de {area:817}. {npc:5875} está en {object:172960}, el cañón bajo {object:172982}.",

	-- Step 62: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 63: Back to Durotar
	-- {zone:1411} Durotar
	["Back to {zone:1411}"] = "",

	-- Step 64: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Entrada de {area:817}",

	-- Step 65: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Los sectarios de Filo Ardiente ocupan las cuevas de {quest:827}; cualquiera suelta un {item:4871}. {npc:3204}, un brujo de nivel 14, está en lo más profundo y suelta {item:4903}.",

	-- Step 66: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595} está en {area:817}, entre los sectarios con los que acabas de pelear.",

	-- Step 67: Into Orgrimmar
	-- {zone:1454} Orgrimmar
	["Into {zone:1454}"] = "",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "De vuelta con {npc:5875} en {object:172960}. Usa {item:7464} en el círculo de invocación de allí y derrota al abisario para vincularlo.",

	-- Step 72: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "De vuelta a {area:362}.",

	-- Step 73: Razor Hill
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, un gigante de mar élite",

	-- Step 74: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, de vuelta en {area:362}",

	-- Step 75: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Los Escórpidos acorazados ({npc:3126}) se arrastran por las llanuras al oeste de {area:362}. Domestica uno y luego regresa con {npc:3171}.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "",

	-- Step 76: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {npc:3337} Kargal Battlescar · {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["West from {area:362} over the {area:814} bridge: {npc:3337} and {npc:5810} stand together at {area:379} above it. From there the road north through {zone:1411} leads to {zone:1454}."] = "",

	-- Step 77: Thunder lizards on the way north
	["Thunder lizards on the way north"] = "",
	-- {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {item:6486} Singed Scale · {npc:5810} Uzzek · {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, beside the road north to {zone:1454}; any of them can drop a {item:6486}. {npc:5810} takes it when the next guide passes {area:379}."] = "",

	-- Step 79: Ormak Grimshot
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:379} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "",

	-- Step 80: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 81: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "A {zone:1454}",
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {quest:829} Neeru Fireblade · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Follow the road north from {area:379} to {zone:1454}'s main gate. The next guide starts in {zone:1454}: {quest:829} takes the cultists' quest, the trainers teach your new ranks, and the zeppelin leaves from the towers outside the gate for {zone:1420} and {zone:1421}. {zone:1413} come after Silverpine."] = "",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "De vuelta al este, a la orilla al norte de {npc:275657}. Los Exploradores Látigo de Ira ({npc:275662}) y los Asistentes ocupan la playa bajo {area:370}. Cazadores: domestiquen un {npc:3107} en la playa.",
	-- ["Back south to {area:362}."] = "De vuelta al sur a {area:362}.",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Los Truenagartos ({npc:3130}) y los Lomorrayos ({npc:3131}) pastan en {area:369}, al otro lado del puente; cualquiera puede soltar {item:6486}.",
	-- ["Thunder lizards across the river"] = "Truenagartos al otro lado del río",
	-- ["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there."] = "Vadea hasta la isla norte de las Islas del Eco. La Matriarca merodea entre los raptores de allí.",
}
