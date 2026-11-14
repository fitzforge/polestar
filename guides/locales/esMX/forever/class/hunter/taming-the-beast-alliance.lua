-- Spanish (Latin America) (esMX): the guide forever/class/hunter/taming-the-beast-alliance (forever/class/hunter/taming-the-beast-alliance.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6063} Taming the Beast
	["{quest:6063} (Alliance)"] = "{quest:6063} (Alianza)",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "Tu propia mascota a nivel 10: tres domas de práctica con una {item:15908} enseñan {spell:1515}, y luego {spell:5149}.",

	-- Step 1: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "A nivel 10, {npc:254084}, una instructora de cazadores en {zone:2521}, puede mandarte a {area:16638} con {quest:94007}. Es solo una indicación: omítela si ya estás en {area:16638}.",

	-- Step 2: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{npc:252389} en {area:16638}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} está con los instructores junto a la puerta oeste de {area:16638}, con {npc:254411} a su lado.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389}: la primera {item:15908}",

	-- Step 3: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod · {npc:252389} Quel'ana Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges. Killing one does not count. Keep each rod: it goes back to {npc:252389}."] = "Los reptadores Cantoviento viven solo junto al agua: los más cercanos corretean por la orilla al suroeste de {area:16638}, entre los cangrejos. Cómo funciona la vara: selecciona a un reptador vivo, usa {item:15908} y quédate quieto durante toda la canalización mientras te pega; moverte, defenderte o la ayuda de cualquier otro la rompe y gasta una de las pocas cargas de la vara. Matar uno no cuenta. Guarda cada vara: vuelve a {npc:252389}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "Usa {item:15908} sobre un reptador vivo",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Doma un {npc:254588}",

	-- Step 4: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "Primero despide al reptador (clic derecho en el retrato de la mascota, {spell:2641}). Los Galestriders malhumorados pastan en {area:16626}, los campos a poca distancia al oeste y suroeste de {area:16638}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "Usa {item:15908} sobre un Galestrider vivo",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Doma un {npc:251707}",

	-- Step 5: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "Despide al Galestrider. Los alfas Vuldren cazan en el mismo {area:16626}, un poco más al sur.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "Usa {item:15908} sobre un alfa vivo",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Doma un {npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}, a su lado: {spell:5149}",

	-- Step 6: Grif Wildheart in Kharanos
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos
	["{npc:1231} in {area:131}"] = "{npc:1231} en {area:131}",
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos · {quest:6074} The Hunter's Path · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:11807} Tristane Shadowstone · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:1231}, the hunter trainer at the smithy in {area:131}. {quest:6074} from {npc:5116} in {zone:1455}, {npc:11807} north-west of {area:131} or {npc:5515} in {zone:1453} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "A nivel 10 ve con {npc:1231}, el instructor de cazadores junto a la herrería de {area:131}. {quest:6074} de {npc:5116} en {zone:1455}, {npc:11807} al noroeste de {area:131} o {npc:5515} en {zone:1453} también lleva aquí, por un poco de experiencia; es solo una indicación. ¿Estás en Elwynn a nivel 10? La cadena de {npc:251507} en {area:87} enseña lo mismo.",
	-- {npc:1231} Grif Wildheart · {item:15908} Taming Rod
	["{npc:1231}: the first {item:15908}"] = "{npc:1231}: la primera {item:15908}",

	-- Step 7: Large Crag Boar
	-- {area:131} Kharanos · {item:15908} Taming Rod · {npc:1231} Grif Wildheart · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar
	["Large Crag Boars (level 6-7) root around the fields west, south and north-west of {area:131} and respawn every 3 minutes. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, being out of range or anyone else's help breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:1231}. The boars use {spell:6268} from 25 yards, so start with the rod, not {spell:75}. Keep each rod: it goes back to {npc:1231}."] = "Los jabalíes de risco grandes (nivel 6-7) hozan en los campos al oeste, sur y noroeste de {area:131} y reaparecen cada 3 minutos. Cómo funciona la vara: selecciona a una bestia viva, usa {item:15908} y quédate quieto durante toda la canalización mientras te pega. Moverte, defenderte, estar fuera de alcance o la ayuda de cualquier otro la rompe y gasta una de las pocas cargas de la vara; si se acaban, destruye la vara, abandona la misión y vuelve a tomarla con {npc:1231}. Los jabalíes usan {spell:6268} desde 25 m, así que empieza con la vara, no con {spell:75}. Guarda cada vara: vuelve a {npc:1231}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "Usa {item:15908} sobre un jabalí vivo",

	-- Step 8: Snow Leopard
	-- {spell:2641} Dismiss Pet · {area:131} Kharanos
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Juvenile Snow Leopards = {npc:1199} Juvenile Snow Leopard
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Snow Leopards (level 7-8) prowl the slopes south-east of {area:131}, more north-west and west of it; the smaller Juvenile Snow Leopards do not count."] = "Primero despide al jabalí (clic derecho en el retrato de la mascota, {spell:2641}): una mascota de práctica liberada puede volverse contra ti. Los leopardos de las nieves (nivel 7-8) merodean por las laderas al sureste de {area:131}, y hay más al noroeste y oeste; los leopardos de las nieves jóvenes, más pequeños, no cuentan.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living leopard"] = "Usa {item:15908} sobre un leopardo vivo",

	-- Step 9: Ice Claw Bear
	-- {area:131} Kharanos · {area:77} Anvilmar · {spell:3130} Ice Claw
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Dismiss the leopard. Ice Claw Bears (level 7-8) roam the hills around {area:131}, many south-east of it and more north-west toward {area:77}; their {spell:3130} hits hard, so start at full health."] = "Despide al leopardo. Los osos Garrahelada (nivel 7-8) recorren las colinas alrededor de {area:131}, muchos al sureste y más al noroeste hacia {area:77}; su {spell:3130} pega fuerte, así que empieza con la salud al máximo.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living bear"] = "Usa {item:15908} sobre un oso vivo",

	-- Step 10: Belia Thundergranite in Ironforge
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455}"] = "{npc:10090} en {zone:1455}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1455} Ironforge · {object:32359} Military Ward (no name in this language: may be words)
	["{npc:10090}, the pet trainer, stands in the {object:32390} in {zone:1455}'s {object:32359}, by the hunter trainers."] = "{npc:10090}, la instructora de mascotas, está en {object:32390}, en {object:32359} de {zone:1455}, junto a los instructores de cazadores.",

	-- Step 11: Dazalar in Dolanaar
	-- {npc:3601} Dazalar · {area:186} Dolanaar
	["{npc:3601} in {area:186}"] = "{npc:3601} en {area:186}",
	-- {npc:3601} Dazalar · {area:186} Dolanaar · {quest:6071} The Hunter's Path · {npc:3596} Ayanna Everstride · {area:256} Aldrassil · {npc:4146} Jocaste · {zone:1457} Darnassus · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:3601}, the hunter trainer in {area:186}. {quest:6071} from {npc:3596} at {area:256}, {npc:4146} in {zone:1457}, {npc:5515} in {zone:1453}, {npc:5116} in {zone:1455} or {npc:1231} in {area:131} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "A nivel 10 ve con {npc:3601}, el instructor de cazadores en {area:186}. {quest:6071} de {npc:3596} en {area:256}, {npc:4146} en {zone:1457}, {npc:5515} en {zone:1453}, {npc:5116} en {zone:1455} o {npc:1231} en {area:131} también lleva aquí, por un poco de experiencia; es solo una indicación. ¿Estás en Elwynn a nivel 10? La cadena de {npc:251507} en {area:87} enseña lo mismo.",
	-- {npc:3601} Dazalar · {item:15908} Taming Rod
	["{npc:3601}: the first {item:15908}"] = "{npc:3601}: la primera {item:15908}",

	-- Step 12: Webwood Lurker
	-- {area:186} Dolanaar · {item:15908} Taming Rod · {spell:1265843} Web · {npc:3601} Dazalar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers (level 5-6) creep through the woods just north-east, south-west and east of {area:186}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, attacking it or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). Their {spell:1265843} roots you but does not break the channel if you keep still. Keep each rod: it goes back to {npc:3601}."] = "Los acechadores Bosque de Telarañas (nivel 5-6) se arrastran por el bosque justo al noreste, suroeste y este de {area:186}. Cómo funciona la vara: selecciona a una bestia viva, usa {item:15908} y quédate quieto durante toda la canalización mientras te pega; moverte, atacarla o la ayuda de cualquier otro la rompe y gasta una de las pocas cargas de la vara (sin cargas: destruye la vara, abandona la misión y vuelve a tomarla). Su {spell:1265843} te enraíza, pero no rompe la canalización si te quedas quieto. Guarda cada vara: vuelve a {npc:3601}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living spider"] = "Usa {item:15908} sobre una araña viva",

	-- Step 13: Nightsaber Stalker
	-- {spell:2641} Dismiss Pet · {area:259} Lake Al'Ameth · {area:186} Dolanaar
	-- plural, as words: Nightsaber Stalkers = {npc:2043} Nightsaber Stalker
	["Dismiss the spider first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Nightsaber Stalkers (level 7-8) lie on the hillside south of {area:259}, south of {area:186}; the plain Nightsabers by the village do not count."] = "Primero despide a la araña (clic derecho en el retrato de la mascota, {spell:2641}): una mascota de práctica liberada puede volverse contra ti. Los acechadores sable de la noche (nivel 7-8) están en la ladera al sur de {area:259}, al sur de {area:186}; los sables de la noche comunes junto a la aldea no cuentan.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "Usa {item:15908} sobre un acechador vivo",

	-- Step 14: Strigid Screecher
	-- {area:186} Dolanaar
	-- plural, as words: Strigid Screechers = {npc:1996} Strigid Screecher
	["Dismiss the cat. Strigid Screechers (level 7-8), owls, perch in the woods south, south-west and west of {area:186}."] = "Despide al felino. Los chilladores estrígidos (nivel 7-8), búhos, se posan en el bosque al sur, suroeste y oeste de {area:186}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living owl"] = "Usa {item:15908} sobre un búho vivo",

	-- Step 15: Jocaste in Darnassus
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457}"] = "{npc:4146} en {zone:1457}",
	-- {area:186} Dolanaar · {zone:1457} Darnassus · {npc:4146} Jocaste · {area:1658} Cenarion Enclave
	["Take the road west from {area:186} to {zone:1457}. {npc:4146} stands inside the {area:1658} with the hunter trainers; Silvaria, the pet trainer, is up the ramp next to her."] = "Toma el camino al oeste desde {area:186} hasta {zone:1457}. {npc:4146} está dentro de {area:1658} con los instructores de cazadores; Silvaria, la instructora de mascotas, está subiendo la rampa a su lado.",

	-- Step 16: Josephine Carson in Goldshire
	-- {npc:251507} Josephine Carson · {area:87} Goldshire
	["{npc:251507} in {area:87}"] = "{npc:251507} en {area:87}",
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {npc:258930} Isaac Chan · {zone:2521} Zephras Isle
	["At 10 go to {npc:251507}, the hunter trainer who stands with the other trainers by the Lion's Pride Inn in {area:87}; {npc:258930}, the pet trainer, is beside her. Skyborne: this is for one who left {zone:2521} without taming; it teaches the same."] = "A nivel 10 ve con {npc:251507}, la instructora de cazadores que está con los demás instructores junto a la Posada Orgullo de León en {area:87}; {npc:258930}, el instructor de mascotas, está a su lado. Skyborne: esto es para quien salió de {zone:2521} sin domar; enseña lo mismo.",
	-- {npc:251507} Josephine Carson · {item:15908} Taming Rod
	["{npc:251507}: the first {item:15908}"] = "{npc:251507}: la primera {item:15908}",

	-- Step 17: Rockhide Boar
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {item:15908} Taming Rod · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar
	["Rockhide Boars (level 7-8) graze in three herds south and south-east of {area:87}, toward the {area:64}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again. The boars use {spell:6268}, so start with the rod, not {spell:75}. Killing a boar does not count. Keep each rod: it goes back to Josephine. A Dwarf or Night Elf who took Josephine's rod instead of their home trainer's is led through {area:87} from here."] = "Los jabalíes Pielroca (nivel 7-8) pastan en tres manadas al sur y sureste de {area:87}, hacia {area:64}. Cómo funciona la vara: selecciona a una bestia viva, usa {item:15908} y quédate quieto durante toda la canalización mientras te pega. Moverte, defenderte, una curación de otro o que cualquier otro golpee a la bestia la rompe y gasta una de las pocas cargas de la vara; si se acaban, destruye la vara, abandona la misión y vuelve a tomarla. Los jabalíes usan {spell:6268}, así que empieza con la vara, no con {spell:75}. Matar un jabalí no cuenta. Guarda cada vara: vuelve a Josephine. Un enano o elfo de la noche que tomó la vara de Josephine en vez de la de su instructor de origen sigue por {area:87} desde aquí.",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "Doma un {npc:524}",

	-- Step 18: Gray Forest Wolf
	-- {spell:2641} Dismiss Pet · {area:87} Goldshire · {area:18} Crystal Lake
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Gray Forest Wolves (level 7-8) run in the woods east of {area:87}, east of {area:18}."] = "Primero despide al jabalí (clic derecho en el retrato de la mascota, {spell:2641}): una mascota de práctica liberada puede volverse contra ti. Los lobos grises del bosque (nivel 7-8) corren por el bosque al este de {area:87}, al este de {area:18}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living wolf"] = "Usa {item:15908} sobre un lobo vivo",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "Doma un {npc:1922}",

	-- Step 19: Young Forest Bear
	-- {area:87} Goldshire
	-- plural, as words: Young Forest Bears = {npc:822} Young Forest Bear
	["Dismiss the wolf. Young Forest Bears (level 8-9) roam the woods just south of {area:87}, with more south-west and south-east of town."] = "Despide al lobo. Los osos del bosque jóvenes (nivel 8-9) recorren el bosque justo al sur de {area:87}, y hay más al suroeste y sureste del pueblo.",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "Doma un {npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, a su lado: {spell:5149}",

	-- Step 20: Your first pet
	["Your first pet"] = "Tu primera mascota",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} funciona como la vara: una bestia de tu nivel o menor, una canalización durante la que no puedes moverte, y la bestia pegándote todo el tiempo. Una mascota conserva el nivel al que la domas y sube de nivel contigo; nunca puede superar tu nivel, así que doma una cercana al tuyo. Cada familia tiene su propia habilidad en Forever (la Carga de un jabalí, por ejemplo). Para subir de nivel, un felino es el que más pega (Zarpa y {spell:17253}) y un jabalí aguanta más castigo.",
	["Tame a beast of your level to keep"] = "Doma una bestia de tu nivel para quedártela",
	-- {area:87} Goldshire · {zone:1436} Westfall
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Near {area:87} there are no cats: Prowlers (wolves, level 9-10) roam eastern Elwynn, Longsnouts (boars, 10-11) its far south-west by the {zone:1436} border; at 12-13, Young Goretusks (boars) graze the fields of northern {zone:1436}."] = "Cerca de {area:87} no hay felinos: los merodeadores (lobos, nivel 9-10) recorren el este de Elwynn, los hocicudos (jabalíes, 10-11) su extremo suroeste junto a la frontera con {zone:1436}; a nivel 12-13, los colmisangres jóvenes (jabalíes) pastan en los campos del norte de {zone:1436}.",
	-- {area:131} Kharanos · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Scarred Crag Boars = {npc:1689} Scarred Crag Boar · Mountain Boars = {npc:1190} Mountain Boar
	["Near {area:131}: Snow Leopards (cats, level 7-8) prowl all over {zone:1426}, Scarred Crag Boars (9-10) its east toward {zone:1432}; at 10-11, Mountain Boars roam western {zone:1432}."] = "Cerca de {area:131}: los leopardos de las nieves (felinos, nivel 7-8) merodean por todo {zone:1426}, los jabalíes de risco marcados (9-10) por su este hacia {zone:1432}; a nivel 10-11, los jabalíes de montaña recorren el oeste de {zone:1432}.",
	-- {area:186} Dolanaar · {zone:1438} Teldrassil
	-- plural, as words: Elder Nightsabers = {npc:2033} Elder Nightsaber · Feral Nightsabers = {npc:2034} Feral Nightsaber
	["Near {area:186}: Elder Nightsabers (cats, level 8-9) and Feral Nightsabers (cats, 10-11) prowl the woods of north-western {zone:1438}."] = "Cerca de {area:186}: los sables de la noche ancianos (felinos, nivel 8-9) y los sables de la noche salvajes (felinos, 10-11) merodean por el bosque del noroeste de {zone:1438}.",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "Cerca de {area:16638}: los alfas Vuldren (nivel 10), la bestia de tu última doma de práctica, cazan en {area:16626}; las matriarcas chillonas (raptores, nivel 9) anidan justo al oeste de {area:16638}; los Ursera Sombraventisca (osos, 10-11) recorren el norte de {zone:2521}.",
	-- {spell:1584} Feed Pet · {area:87} Goldshire · {zone:1457} Darnassus · {zone:2521} Zephras Isle · {area:131} Kharanos · {area:186} Dolanaar
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Toddrick the butcher in {area:87}, Jaeana in {zone:1457} and the innkeepers on {zone:2521} sell meat; the innkeepers of {area:131} and {area:186} sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584}: abre tu libro de hechizos, lanza {spell:1584} y haz clic en una comida que coma la familia de tu mascota (el recuadro de la mascota las muestra: los felinos comen carne y pescado, los jabalíes casi de todo). La carne cruda que sueltan las bestias cuenta. Para comprar: Toddrick, el carnicero de {area:87}, Jaeana en {zone:1457} y los posaderos de {zone:2521} venden carne; los posaderos de {area:131} y {area:186} venden pan. La comida de nivel cercano al de la mascota la pone más feliz; la de nivel mucho menor da más o menos la mitad. No puedes alimentarla en combate.",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "Felicidad: la cara en el marco de la mascota. Una mascota descontenta hace tres cuartos de su daño, una feliz un cuarto más. La felicidad baja despacio, más rápido cuando la mascota muere; una mascota descontenta demasiado tiempo puede escaparse.",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "La lealtad crece con el tiempo y las muertes. Cada rango de lealtad sube los puntos de entrenamiento que gastas en {spell:5149} (nivel de la mascota por el rango de lealtad menos uno).",
	-- {spell:5149} Beast Training · {area:87} Goldshire · {npc:9980} Shelby Stoneflint · {area:131} Kharanos · {area:186} Dolanaar · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master (Erma in {area:87}, {npc:9980} in {area:131}, Seriadne in {area:186}, {npc:265756} on {zone:2521}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149} (libro de hechizos, pestaña General) le enseña a tu mascota actual las habilidades que conoces. Para aprender una habilidad o rango nuevo: deja tu mascota con un maestro de establos (Erma en {area:87}, {npc:9980} en {area:131}, Seriadne en {area:186}, {npc:265756} en {zone:2521}), doma una bestia que la tenga (su pestaña del libro de mascota muestra lo que sabe), usa la habilidad en peleas hasta que el juego diga que la aprendiste, luego recupera tu mascota y enséñasela con {spell:5149}. Una mascota tiene como máximo cuatro habilidades activas.",
	-- {spell:1853} Growl · {npc:258930} Isaac Chan · {area:87} Goldshire · {npc:2879} Karrina Mekenda · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:2878} Peria Lamenur · {area:131} Kharanos · {npc:10090} Belia Thundergranite · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {area:186} Dolanaar · {zone:1457} Darnassus · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar
	["Pet trainers sell {spell:1853} ranks and resistances. Alliance: {npc:258930} in {area:87}, {npc:2879} by the hunter trainers in {zone:1453}'s {object:28027}, {npc:2878} in {area:131}, {npc:10090} in {zone:1455}'s {object:32390}, Keldas in {area:186}, Silvaria in {zone:1457}' Cenarion Enclave, {npc:254411} in {area:16638}."] = "Los instructores de mascotas venden rangos de {spell:1853} y resistencias. Alianza: {npc:258930} en {area:87}, {npc:2879} junto a los instructores de cazadores en {object:28027} de {zone:1453}, {npc:2878} en {area:131}, {npc:10090} en {object:32390} de {zone:1455}, Keldas en {area:186}, Silvaria en el Enclave Cenarion de {zone:1457} y {npc:254411} en {area:16638}.",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "{spell:883}, {spell:2641} y {spell:982} ya están en tu libro de hechizos; {spell:136} te lo enseña tu instructor a nivel 12. Una mascota muerta necesita {spell:982}; una que se aleja más de unos 100 m se despide y vuelve con {spell:883}.",
}
