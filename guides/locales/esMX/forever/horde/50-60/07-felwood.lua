-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tirisfal Glades
	["The zeppelin towers"] = "Las torres del zepelín",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 4: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "En {object:172961}.",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "sesenta de {item:14047}",

	-- Step 6: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Vuela a {area:431}",

	-- Step 7: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 8: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Vuela a {area:431} y cabalga al noroeste por el camino que sale de {zone:1440} hacia {zone:1448}. {area:2479} es el campamento de los druidas justo pasando la frontera.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, adentro",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Corazón de plata, de {npc:9116}, requiere un {item:11173} del norte de {zone:1448} y volver aquí. Omítela.",

	-- Step 9: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "Ve al noroeste hasta {area:1763}. Los cuatro braseros están entre los edificios del Consejo de la Sombra; usa el Agua purificada en cada uno.\nCuidado: Enemigos del Consejo de la Sombra de nivel 53-55 llenan la cueva y suelen venir en grandes grupos vinculados, muchos con aturdimientos. Se recomienda un grupo de 2-3 jugadores.",
	["Below ground"] = "Bajo tierra",

	-- Step 10: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Regresa al sur al Santuario, a poca distancia.",

	-- Step 11: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Cabalga al norte por el camino, pasando {area:1763}, hasta {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "La siguiente misión de {npc:10306}, {quest:4741}, te haría volver aquí desde {zone:1452}. Omítela.",

	-- Step 12: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}, {npc:9860} y {npc:9517} esperan al fondo de {area:1770}, la cueva en el norte de {area:1763}. Despeja el túnel a medida que avanzas.\nCuidado: Los tres jefes pelean en grupo. Mata primero a los enemigos cercanos para no atraer más.",
	-- {quest:5887} Salve via Hunting
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["Corrupted Soul Shards from the cultists, {quest:5887}"] = "Fragmentos de alma corruptos de los cultistas, {quest:5887}",

	-- Step 13: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Enforcers = {npc:7114} Jaedenar Enforcer
	["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "Te cayó una {item:13140}: los Déspotas Jaedenar, Tejeoscuros, Brujos y Legionarios del Bastión de las Sombras la llevan de vez en cuando. Úsala para iniciar la misión y luego libera a {npc:11018} de su jaula en el extremo sur de la cueva al salir.",

	-- Step 14: Captured Arko'narin
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, below ground"] = "{npc:11016}, bajo tierra",

	-- Step 15: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["On the way back south to Greta, {npc:9529} takes the shards on the west side of the Sanctuary."] = "De regreso al sur hacia Greta, {npc:9529} recibe los fragmentos en el lado oeste del Santuario.",

	-- Step 16: Greta Mosshoof
	["South to the Sanctuary once more."] = "Al sur, al Santuario, una vez más.",

	-- Step 17: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors · {npc:14524} Vartrus the Ancient
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "Sube al norte por el camino de {zone:1448} hasta {area:1767}; {quest:5086} se arrastran entre los árboles, y la mayoría sueltan una gota.\nCuidado: los Caminantes ancestrales de Troncoferro, élites de nivel 59, andan entre {quest:5086}, y {npc:14524} (63, élite) recorre el bosque: encárgate de los Horrores en la punta norte de {area:1767}, de uno en uno.",

	-- Step 19: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Cruza el túnel de los Fauces de Madera hasta {zone:1450}. {npc:11939} lee en una casa de {area:2361}.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} da vueltas por {area:2361}: búscalo dentro del círculo del mapa",

	-- Step 21: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 22: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Fragmentos de gangrevid, de {npc:11801}, requiere {area:2577}. Omítela.",

	-- Step 25: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Vuelve al túnel de los Fauces de Madera y toma la salida a {zone:1452}; {npc:9298} acampa junto a las fuentes termales justo afuera.",
	["From Krakle in Un'Goro"] = "De Krakle, en Un'Goro",

	-- Step 26: Strange Sources
	-- {area:2256} Darkwhisper Gorge · {area:2255} Everlook
	["Only with help: level 59-60 elite Frostmaul giants flank the road to {area:2256}. Alone, skip the gorge and stay on the road to {area:2255}."] = "",

	-- Step 27: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "Los corredores recorren el camino de {area:1769} hacia {area:2244} en grupos pequeños; espera junto al camino cerca de {npc:9298} y mátalos cuando pasen. Cada uno lleva una caja.\nCuidado: Al entregar aparecen tres o cuatro emboscadores Nevada de nivel 56-57 que te atacan; puedes escapar de ellos montado, en sigilo o con {spell:5384}, y después se juntan junto al lago para que puedas tomar la siguiente misión.",

	-- Step 28: Salfa
	-- {quest:8464} Winterfall Activity · {area:2255} Everlook · {area:2256} Darkwhisper Gorge
	["{quest:8464}'s village is north-east of {area:2255}, on this guide's way back from {area:2256}."] = "El poblado de {quest:8464} está al noreste de {area:2255}, en el camino de regreso de esta guía desde {area:2256}.",

	-- Step 29: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Con 30 de {quest:6031} en tus bolsas: sigue el camino al norte hasta {area:1769}; {npc:11557} comercia justo en la entrada.",

	-- Step 30: Kernda
	-- {area:1762} Felpaw Village · {npc:11558} Kernda · {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then: she waits at the tunnel mouth of {area:1769} and speaks to you from Neutral with the Timbermaw, which the Deadwood furbolgs of {zone:1448} brought you to."] = "El tótem Muertobosque de {area:1762}, si {npc:11558} no lo recibió entonces: espera en la entrada del túnel de {area:1769} y te habla desde Neutral con los Fauces de Madera, a lo que te llevaron los fúrbolgs Muertobosque de {zone:1448}.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} da vueltas por aquí: búscala dentro del círculo del mapa",

	-- Step 31: Darkwhisper Gorge
	-- {area:2256} Darkwhisper Gorge
	["With your group, follow the road south between the elite Frostmaul giants. Turn back as soon as the quest credits at the mouth of {area:2256}; do not enter the Hederine camp."] = "",

	-- Step 32: Are We There, Yeti?
	-- {area:2255} Everlook
	["Ride north to {area:2255}."] = "Cabalga al norte hasta {area:2255}.",
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "Asusta a {npc:10978} con {npc:10980}",

	-- Step 34: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "El poblado furbolg llena el valle al noreste de {area:2255}. Mata primero a los Chamanes; curan. {npc:10738} (59, élite) y Xandivious (62) están en la cueva del fondo: no entres.",

	-- Step 35: Level 59.9
	["Level 59.9"] = "Nivel 59.9",
	-- {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Winterfall Ursas = {npc:7438} Winterfall Ursa
	["Stay on the village's western edge for Winterfall Ursas (57-58). Leave the cave and its elite chief alone. Top up only until the last hand-ins can take you to 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- plural, as words: Winterfall Ursas = {npc:7438} Winterfall Ursa
	["Winterfall Ursas"] = "",

	-- Step 36: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west along the road to {area:2246}."] = "Regresa cabalgando al oeste por el camino hasta {area:2246}.",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "Luego {npc:9298} te envía tras {npc:10738}, un élite en su cueva. Omítela.",

	-- Step 38: Salfa
	-- {zone:1452} Winterspring
	["North of Donova, at the tunnel's {zone:1452} exit."] = "Al norte de Donova, en la salida del túnel hacia {zone:1452}.",

	-- Step 39: Beads for Salfa
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity
	["{npc:11556} takes the beads only once {quest:8464} is handed in: any Winterfall furbolg can carry them, and the camps just south of {npc:11556} are the closest."] = "{npc:11556} acepta las cuentas solo después de entregar {quest:8464}: cualquier furbolg Nevada puede llevarlas, y los campamentos justo al sur de {npc:11556} son los más cercanos.",
	["Frostfire Winterfall camp"] = "Campamento Nevada de los Baños de Fuego de Escarcha",

	-- Step 41: Grind to 60
	["Grind to 60"] = "Sube a nivel 60",
	-- {npc:11556} Salfa
	-- plural, as words: Winterfall Den Watchers = {npc:7440} Winterfall Den Watcher
	["If you still need experience after the hand-ins, the Winterfall Den Watchers (55-56) are by the bead camp just south of {npc:11556}. There is no need to cross the gorge."] = "",
	-- plural, as words: Winterfall Den Watchers = {npc:7440} Winterfall Den Watcher
	["Winterfall Den Watchers"] = "",

	-- Step 42: Training
	["Training"] = "",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "En {zone:1454}: vuela desde {area:2255}",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "En {zone:1456}: vuela desde {area:2255}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Cualquier furbolg Nevada puede llevar las cuentas; los campamentos justo al sur de {npc:11556} son los más cercanos.",
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "Vuelve al túnel de los Fauces de Madera y toma la salida a {area:618}; {npc:9298} acampa junto a las fuentes termales justo afuera.",
	-- ["Dungeon instead of grinding"] = "Calabozo en vez de matar monstruos",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "Vuela a {area:431} y cabalga al noroeste por el camino que sale de {zone:1440} hacia {area:361}. {area:2479} es el campamento de los druidas justo pasando la frontera.",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Desde {zone:1458}, toma el zepelín en la torre fuera de la ciudad hacia {zone:1454}.",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Solo si llevas {quest:5087}: los corredores recorren el camino de {area:1769} hacia {area:2244} en grupos pequeños; espera junto al camino cerca de {npc:9298} y mátalos al pasar. Cada uno lleva un cajón.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Solo si {npc:9298} te dio {quest:5086}: cabalga al norte por el camino de {area:361} hasta {area:1767}; los {quest:5086} rezuman entre los árboles.",
	-- ["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Solo con 30 {quest:6031} y solo en Neutral con los Fauces de Madera: sigue el camino al norte hasta {area:1769}; {npc:11557} comercia justo dentro de la entrada.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Opcional. Hacer {area:2279}, {area:2057}, la parte baja de Cumbre de Roca Negra o {area:1584} en grupo en lugar de farmear te lleva allí más rápido.",
	-- ["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Opcional: en grupo, un calabozo de nivel 55-60 sustituye a la matanza de abajo.",
	-- ["Ride back west to {area:2246}."] = "Regresa cabalgando al oeste a {area:2246}.",
	-- ["Ride east along the road to {area:2255}."] = "Cabalga al este por el camino hasta {area:2255}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Cabalga al este y luego al sur por {area:2249}. Los gigantes Machacahielo de allí son élite de nivel 59: mantente en el centro y no te detengas. La fuente extraña está en la entrada de {area:2256}, en el extremo sur.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Cabalga al noroeste hasta {area:1763}. Los cuatro blandones están entre los edificios del Consejo de la Sombra; usa el agua purificada en cada uno.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "Aquí se acaban las misiones. Los Dentoesquirlas rabiosos merodean en {area:2249}, al sur de {area:618}, al sur del camino desde {area:2255}.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Aquí se acaban las misiones. Los Dentoesquirlas rabiosos merodean en {area:2249}, al sur de {zone:1452}, al sur del camino desde {area:2255}.",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "Cruza el túnel de los Fauces de Madera hasta {area:493}. {npc:11939} lee en una casa de {area:2361}.",
	-- ["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Completa aquí hasta el nivel 59.9 antes de las entregas en {zone:1452}: te llevan al nivel 60. Los dientefilados rabiosos (59) de {area:2249}, justo al norte de la fuente extraña, dan mucha más experiencia que los fúrbolgs junto a {area:1769}. O, en grupo, haz la mazmorra {area:2057} o la mazmorra {area:2279}.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- ["grind on {npc:7446}"] = "sube de nivel con {npc:7446}",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "mata {npc:7446} en {area:2249}, {area:618}",
	-- ["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "mata {npc:7446} en {area:2249}, {zone:1452}",
	-- ["only if still carried: the {zone:1423} guide hands it in on its way through"] = "solo si todavía la llevas: la guía de {zone:1423} la entrega de paso",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "La siguiente misión de {npc:10306}, {quest:4741}, te haría volver aquí desde {area:618}. Omítela.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "Corazón de plata, de {npc:9116}, requiere un {item:11173} del norte de {area:361} y volver aquí. Omítela.",
	-- ["{npc:9529} stands on the west side of the Sanctuary, the way out to {area:1763}. With {quest:4102} done, her {quest:5887} asks for six Corrupted Soul Shards: the Shadow Council cultists in {area:1763} and {area:1770} drop them about one kill in three, and you fight dozens of them for {npc:10922}."] = "{npc:9529} está en el lado oeste del Santuario, la salida hacia {area:1763}. Con {quest:4102} completada, su misión {quest:5887} pide seis fragmentos de alma corruptos: los cultistas del Consejo de la Sombra en {area:1763} y {area:1770} los sueltan aproximadamente una de cada tres muertes, y combates a decenas de ellos para {npc:10922}.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} y {npc:9517} esperan al fondo de {area:1770}, la cueva al norte de {area:1763}. Limpia el túnel a tu paso.",
}
