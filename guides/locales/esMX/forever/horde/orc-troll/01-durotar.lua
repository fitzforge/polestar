-- Spanish (Latin America) (esMX): the guide forever/horde/orc-troll/01-durotar (forever/horde/orc-troll/01-durotar.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, donde empiezas",

	-- Step 2: Gornek
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} espera dentro de la Guarida, el edificio justo al oeste de {npc:10176}.",

	-- Step 3: Training weapons and boars
	["Training weapons and boars"] = "Armas de entrenamiento y jabalíes",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "Las armas están alrededor de la Guarida y del campo de entrenamiento; los Jabalíes jaspeados ({npc:3098}) recorren todo el fondo del valle.",

	-- Step 4: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} está justo dentro de la entrada de la cueva; {npc:3159}, al fondo de la cueva, detrás de él.",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave"] = "{npc:3159}, al fondo de la cueva",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}, el instructor de brujos al fondo de la cueva",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}, el instructor de pícaros en la Guarida",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}, el instructor de guerreros junto a la Guarida",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}, el instructor de cazadores junto a la Guarida",
	-- {npc:3707} Ken'jai
	["{npc:3707}, the priest trainer at the Den"] = "{npc:3707}, el instructor de sacerdotes en la Guarida",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}, el instructor de chamanes junto a la Guarida",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}, la instructora de magos, en la entrada de la Guarida",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, junto al fuego de cocina",

	-- Step 5: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} yace herido al pie de las colinas al noroeste de la Guarida.",

	-- Step 6: Sarkoth
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way."] = "{quest:790}, un escórpido grande, merodea la ladera al sur de {npc:3287} entre los Escórpidos obreros ({npc:3124}); recoge las Manzanas de cactus ({item:11583}) junto a los cactus en el camino.",

	-- Step 8: Back to the Den
	["Back to the Den"] = "De vuelta a la Guarida",

	-- Step 9: Foreman Thazz'ril
	["The foreman stands at the lumber pile east of the Den."] = "El capataz está junto a la pila de madera al este de la Guarida.",

	-- Step 10: Lazy Peons
	-- {item:16114} Foreman's Blackjack
	["Hit the sleeping peons north of the Den with the {item:16114}."] = "Golpea a los peones dormidos al norte de la Guarida con {item:16114}.",
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Despierta a {quest:5441} con {item:16114}",

	-- Step 12: North end of the valley
	["North end of the valley"] = "Extremo norte del valle",
	-- {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "{quest:792} pululan en la ladera bajo {area:365}, la cueva del lado norte del valle.",

	-- Step 13: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "Dentro de la cueva, sigue derecho en la primera bifurcación, luego a la derecha y sigue el arroyo a tu izquierda hasta la cascada: el pico brilla junto al agua, detrás de una columna de roca.",

	-- Step 14: Back at the Den
	["Back at the Den"] = "De vuelta en la Guarida",

	-- Step 15: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller
	["{npc:5887} stands just outside the Den."] = "{npc:5887} está justo afuera de la Guarida.",

	-- Step 17: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "Dentro de la cueva, sigue la pared derecha todo el camino, pasando sobre el arroyo: {npc:3183} espera al final.",

	-- Step 18: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Pezuñas de {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Los acechadores viles recorren la ladera bajo la cueva, en el lado norte del valle.",

	-- Step 19: Zureetha Fargaze
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "{object:654925}, en el suelo a su lado",

	-- Step 20: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} está afuera de la Guarida. {area:639} es la colina justo al sur: bebe {item:6635} allí para ver a la {npc:5891} y luego llévale {item:6656} a {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, en {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} y tu {item:5175}",

	-- Step 21: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} está en el camino, en la salida este del valle.",

	-- Step 22: Sen'jin Village
	-- {area:367} Sen'jin Village
	["Follow the road east out of the valley to {area:367} on the coast."] = "Sigue el camino al este fuera del valle hasta {area:367}, en la costa.",

	-- Step 23: Ridgeshade spiders
	["Ridgeshade spiders"] = "Arañas sombrarrisco",
	-- {area:362} Razor Hill
	["The spiders lurk in the hills along the road north toward {area:362}."] = "Las arañas acechan en las colinas a lo largo del camino al norte, hacia {area:362}.",

	-- Step 24: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "La fogata de {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "{npc:265809} acampa justo al sur de {area:362}. Siéntate junto a su fogata (/sentarse) hasta que aparezca el beneficio {spell:1229451}.",

	-- Step 25: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town"] = "{npc:266940}, en el lado este del pueblo",
	-- {npc:3191} Cook Torka
	["Talk to {npc:3191}"] = "Habla con {npc:3191}",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, en la torre de vigilancia",

	-- Step 26: Prickly pears
	["Prickly pears"] = "Higos chumbos",
	["The prickly pears grow among the quilboar huts just west of town."] = "Los higos chumbos crecen entre las chozas de los jabaespines, justo al oeste del pueblo.",

	-- Step 28: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Los jabaespines y exploradores ocupan las chozas al oeste del pueblo; los polvorosos y guardias de batalla ocupan los campamentos más al oeste.",

	-- Step 30: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "El fuerte está en la costa al sureste de {area:362}. El hacha, el arco y el escudo de los asaltantes están en sus afueras. Los marineros y marines sueltan {item:4870}. {npc:3192} espera en lo alto del fuerte; su llave abre el cofre a su lado, que contiene {item:4881}.",

	-- Step 32: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Follow the road north toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "Sigue el camino al norte hacia {zone:1454}. {npc:3293} acampa a un lado; los sacos robados están a lo largo del camino al sur de él.",

	-- Step 33: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}."] = "Los Salvajes y las Brujas de la Tormenta anidan en {area:370}, al este de {npc:3293}. Una Bruja de la Tormenta suelta {item:277661}.",

	-- Step 35: Thunder lizards
	["Thunder lizards"] = "Truenagartos",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}."] = "Los Truenagartos ({npc:3130}) y los Lomorrayos ({npc:3131}) pastan en {area:369}, justo al oeste y suroeste de {npc:3293}.",

	-- Step 37: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "La choza de Misha está al sur de los truenagartos. Los crocoliscos a lo largo de {area:814}, al oeste, llevan {item:4891}.",

	-- Step 38: The wreckage
	["The wreckage"] = "Los restos",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin."] = "Las cajas de herramientas gnómicas están entre los restos a lo largo de la orilla al este y sureste de {area:362}. Sigue la orilla al sur hasta Sen'jin.",

	-- Step 39: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: solo encantadores; el residuo se obtiene desencantando Colgantes embrujados ({item:275724})",

	-- Step 40: Makrura and crawlers
	["Makrura and crawlers"] = "Makruras y reptadores",
	["Makrura and surf crawlers line the beaches north-east of Sen'jin."] = "Los makruras y reptadores de espuma se alinean en las playas al noreste de Sen'jin.",

	-- Step 41: Bloodtalon Matriarch
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there."] = "Vadea hasta la isla norte de las Islas del Eco. La Matriarca merodea entre los raptores de allí.",

	-- Step 42: Echo Isles
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "Ve al sur por las islas. Los ídolos loa están por todas las islas del sur; los Trols vudú y los Trols embrujados ({npc:3207}) los guardan y sueltan los Colgantes embrujados ({item:275724}). {quest:826} y la jaula de Minshina están en la isla más al sur.",

	-- Step 43: South-east shore
	["South-east shore"] = "Orilla sureste",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade back west to the shore south of Sen'jin. Durotar Tigers roam it and the Taillasher eggs sit in nests along the beach."] = "Vadea de regreso al oeste hasta la orilla al sur de Sen'jin. Los Tigres de Durotar ({npc:3121}) la recorren y los huevos de colazote están en nidos a lo largo de la playa.",

	-- Step 45: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366} está al oeste de Sen'jin. Los tres planes de ataque están en el suelo entre las tiendas de los centauros. {npc:275811} también está cautiva en el risco.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Libera a {npc:275811} y acompáñala a salvo fuera del risco",

	-- Step 47: Razor Hill
	-- {area:362} Razor Hill
	["Follow the road north to {area:362}."] = "Sigue el camino al norte hasta {area:362}.",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, junto a la posada",
	-- {npc:3706} Tai'jin · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["{npc:3706}, for {npc:6018} in {zone:1454}: keep it"] = "{npc:3706}, para {npc:6018} en {zone:1454}: guárdala",

	-- Step 48: Fizzle Darkstorm
	-- {area:369} Thunder Ridge · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	["Fizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way."] = "Fizzle ocupa el campamento de Filo Ardiente en {area:369}, al noroeste de {area:362}. Cazadores: domestiquen un {npc:3099} con {item:15908} en el camino.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestícalo con {item:15908}",

	-- Step 50: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} está en la orilla al este de {area:362}. El tridente, el estandarte y la daga están en la playa a su alrededor.",

	-- Step 51: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} acampa en la colina al oeste de la playa de las nagas, al sur de {quest:827}.",

	-- Step 52: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words)
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "La puerta principal de {zone:1454} está justo al oeste de {area:817}. {npc:5875} está en {object:172960}, el cañón bajo {object:172982}.",

	-- Step 53: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Entrada de {area:817}",

	-- Step 54: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Los sectarios de Filo Ardiente ocupan las cuevas de {quest:827}; cualquiera suelta un {item:4871}. {npc:3204}, un brujo de nivel 14, está en lo más profundo y suelta {item:4903}.",

	-- Step 55: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595} está en {area:817}, entre los sectarios con los que acabas de pelear.",

	-- Step 56: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "De vuelta con {npc:5875} en {object:172960}. Usa {item:7464} en el círculo de invocación de allí y derrota al abisario para vincularlo.",

	-- Step 58: Razor Hill
	-- {area:362} Razor Hill
	["Back south to {area:362}."] = "De vuelta al sur a {area:362}.",

	-- Step 59: Spitelash naga
	["Spitelash naga"] = "Nagas Látigo de Ira",
	-- {npc:275657} Heglan Shadeeye · {area:370} Drygulch Ravine · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "De vuelta al este, a la orilla al norte de {npc:275657}. Los Exploradores Látigo de Ira ({npc:275662}) y los Asistentes ocupan la playa bajo {area:370}. Cazadores: domestiquen un {npc:3107} en la playa.",

	-- Step 60: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "De vuelta a {area:362}.",
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, un gigante de mar élite",

	-- Step 61: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "{npc:275666}, un joven gigante de mar, recorre la costa norte de {zone:1411}, al norte de la playa de las nagas. {npc:275666} es élite: se recomienda ir en grupo.",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, de vuelta en {area:362}",

	-- Step 62: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Los Escórpidos acorazados ({npc:3126}) se arrastran por las llanuras al oeste de {area:362}. Domestica uno y luego regresa con {npc:3171}.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "{npc:3171}: {npc:3352} en {zone:1454} enseña {spell:5149}",

	-- Step 63: Ormak Grimshot
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor (no name in this language: may be words)
	["Follow the road north from {area:362} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Sigue el camino al norte desde {area:362} hasta la puerta principal de {zone:1454}, justo al oeste de {area:817}. {npc:3352} está con los instructores de cazadores en {object:172958}.",

	-- Step 64: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} Barrens
	["Follow the road west from {area:362} over the {area:814} bridge; {area:379} sits just above it on the {zone:1413} side."] = "Sigue el camino al oeste desde {area:362} por el puente sobre {area:814}; {area:379} está justo arriba, del lado de {zone:1413}.",

	-- Step 65: Thunder lizards across the river
	["Thunder lizards across the river"] = "Truenagartos al otro lado del río",
	-- {area:369} Thunder Ridge · {item:6486} Singed Scale
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Los Truenagartos ({npc:3130}) y los Lomorrayos ({npc:3131}) pastan en {area:369}, al otro lado del puente; cualquiera puede soltar {item:6486}.",

	-- Step 67: The Crossroads
	-- {area:379} Far Watch Post · {area:380} The Crossroads · {zone:1413} Barrens
	["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Sigue el camino al suroeste desde {area:379} hasta {area:380}. La guía de {zone:1413} empieza aquí.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Sigue el camino al suroeste desde {area:379} hasta {area:380}. La guía de {zone:1413} empieza aquí.",
	-- ["{area:364}'s cave mouth"] = "Entrada de la cueva de {area:364}",
}
