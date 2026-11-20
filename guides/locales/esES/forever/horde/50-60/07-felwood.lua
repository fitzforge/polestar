-- Spanish (Spain) (esES): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 2: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "En {object:172961}.",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "",

	-- Step 4: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "",

	-- Step 5: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 6: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Vuela a {area:431} y cabalga hacia el noroeste por el camino que sale de {zone:1440} y entra en {zone:1448}. {area:2479} es el campamento de los druidas justo pasada la frontera.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {quest:4084} Silver Heart · {item:11172} Silvery Claws · {item:11173} Irontree Heart · {area:1767} Irontree Woods · {npc:9116} Eridan Bluewind
	["{quest:4084}'s {item:11172} and {item:11173} come from {area:1767} on this guide's ride north; {npc:9116} takes them at the end of the guide, back here."] = "",

	-- Step 7: Rakaiah
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {item:13140} Blood Red Key · {area:1763} Jaedenar
	["Only if {npc:11019} sent you after {npc:9518} (the {item:13140}'s chain): on the ride north, turn west into {area:1763}. {npc:9518} (56) stands by the remains of Trey Lightforge at the edge of the camp, well under you now; Trey's remains go back to {npc:11019} at the end of this guide."] = "",

	-- Step 8: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Cabalga hacia el norte por el camino, dejando atrás {area:1763}, hasta {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4721} Wild Guardians · {area:2255} Everlook · {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{npc:10306}'s last {quest:4721} are the Berserk Owlbeasts north of {area:2255}, on this guide's {zone:1452} loop; he takes them at the end of the guide, back here."] = "",

	-- Step 9: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors · {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {item:11172} Silvery Claws · {npc:14524} Vartrus the Ancient
	-- plural, as words: Irontree Wanderers = {npc:7138} Irontree Wanderer · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet. The Irontree Wanderers and Stompers (52-53) there carry {npc:9116}'s {item:11173}, the Angerclaw bears and Felpaw wolves his {item:11172}.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "",

	-- Step 11: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Cruza el túnel de los Fauces de Madera hasta {zone:1450}. {npc:11939} lee en una casa de {area:2361}.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "",

	-- Step 13: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 14: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Fragmentos de gangrevid, de {npc:11801}, requiere {area:2577}. Omítela.",

	-- Step 17: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Vuelve al túnel de los Fauces de Madera y toma la salida de {zone:1452}; {npc:9298} acampa junto a las aguas termales, justo fuera.",
	["From Krakle in Un'Goro, if you didn't bring it to her earlier"] = "",

	-- Step 18: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 19: Salfa
	-- {quest:8464} Winterfall Activity · {area:2255} Everlook · {area:2256} Darkwhisper Gorge
	["{quest:8464}'s village is north-east of {area:2255}, on this guide's way back from {area:2256}."] = "El poblado de {quest:8464} está al noreste de {area:2255}, en el camino de vuelta de esta guía desde {area:2256}.",

	-- Step 20: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Con 30 de {quest:6031} en tus bolsas: sigue el camino hacia el norte hasta {area:1769}; {npc:11557} comercia justo al pasar la entrada.",
	["Below ground"] = "Bajo tierra",

	-- Step 21: Kernda
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if you are Neutral with the Timbermaw now (the {area:1769} reputation guide gets you there): {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 22: Witch Doctor Mau'ari
	-- {area:2255} Everlook · {npc:11755} Harlo Wigglesworth · {npc:10307} Witch Doctor Mau'ari · {area:2249} Frostwhisper Gorge
	["Ride east along the road to {area:2255}: {npc:11755} sends you to {npc:10307}, who stands in the town, on the way to {area:2249}."] = "",

	-- Step 24: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	-- was: ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Cabalga al este y luego al sur bajando por {area:2249}. Los Gigantes Machacahielo de allí son élite de nivel 59: ve por el centro y no te detengas. La fuente extraña está en la boca de {area:2256}, en el extremo sur."
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59-60: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "",

	-- Step 25: Frostmaul Shards
	-- {area:2249} Frostwhisper Gorge · {npc:10198} Kashoch the Reaver
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["The shards lie on the ground along the west side of {area:2249}, among the Frostmaul Giants and Preservers. Careful: the giants are elites of 59-60: pick up the shards that lie clear of them, wait for a patrol to pass, and leave {npc:10198} (60, east side) alone."] = "",

	-- Step 26: Level 59.7
	["Level 59.7"] = "",
	-- {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {npc:11556} Salfa · {npc:10306} Trull Failbane · {npc:9116} Eridan Bluewind · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to about level 59.7 before the last hand-ins: Umi, Vizzie, Mau'ari, {area:2244}, {npc:9298}, {npc:11556}, {npc:10306} and {npc:9116} take you the rest of the way to 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "",

	-- Step 27: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yetis Cardo Nevado",
	-- {area:2255} Everlook · {item:258323} Missing Mail
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["On the ride north to {area:2255}, the Ice Thistle Yetis (55-56) in the hills south-east of the town carry Vizzie's {item:258323}: four pieces."] = "",

	-- Step 28: Are We There, Yeti?
	-- {area:2255} Everlook
	["Ride north to {area:2255}."] = "Cabalga al norte hasta {area:2255}.",
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "",

	-- Step 29: Everlook
	-- {npc:11118} Innkeeper Vizzie · {quest:93406} Unfrozen Deliveries
	["{npc:11118}, in the inn: {quest:93406}"] = "",

	-- Step 31: Winterfall Village
	-- {area:2255} Everlook · {quest:5121} High Chief Winterfall
	-- was: ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "El poblado fúrbolg ocupa el valle al noreste de {area:2255}. Mata primero a los Chamanes, que curan. {npc:10738} (59, élite) y Xandivious (62) están en la cueva del fondo: no entres."
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {quest:5121} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "",

	-- Step 32: Berserk Owlbeasts
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Berserk Owlbeasts"] = "",
	-- {area:2241} Frostsaber Rock · {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["The Berserk Owlbeasts (58-59) roam the slopes of {area:2241}, north of {area:2255} and west of the furbolg valley. Now and then an owlbeast drops a {item:12558}: use it to start {quest:4882}."] = "",

	-- Step 33: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west along the road to {area:2246}."] = "Vuelve al oeste por el camino hasta {area:2246}.",

	-- Step 34: High Chief Winterfall
	-- {npc:9298} Donova Snowden · {quest:5121} High Chief Winterfall · {area:2244} Winterfall Village · {area:2255} Everlook · {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["A group choice: {npc:9298} sends you after {quest:5121} (59, elite, with his guards) in the cave at the back of {area:2244}, back east past {area:2255}; Xandivious (62) shares the cave: leave him. The High Chief carries a log for {npc:9298}, and her next errand goes to {npc:10920} at the {area:2479}, this guide's last stop."] = "",
	-- {quest:5121} High Chief Winterfall
	["{quest:5121}, in the cave"] = "",
	["the log he carries"] = "",
	-- {npc:9298} Donova Snowden
	["{npc:9298}, back west at the hot springs"] = "",
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["for {npc:10920} at the {area:2479}"] = "",

	-- Step 35: Salfa
	-- {zone:1452} Winterspring
	["North of Donova, at the tunnel's {zone:1452} exit."] = "Al norte de Donova, en la salida del túnel hacia {zone:1452}.",

	-- Step 36: Beads for Salfa
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity
	["{npc:11556} takes the beads only once {quest:8464} is handed in: any Winterfall furbolg can carry them, and the camps just south of {npc:11556} are the closest."] = "{npc:11556} solo acepta las cuentas una vez entregada {quest:8464}: cualquier fúrbolg Nevada puede llevarlas, y los campamentos justo al sur de {npc:11556} son los más cercanos.",
	["Frostfire Winterfall camp"] = "Campamento Nevada de los Baños de Fuego de Escarcha",

	-- Step 38: Trull Failbane
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post
	["Back through the Timbermaw tunnel and south down the {zone:1448} road to {area:1997}."] = "",

	-- Step 39: Trull Failbane
	-- {quest:4882} Guarding Secrets · {item:12558} Blue-feathered Necklace
	["{quest:4882}, from the {item:12558}"] = "",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["{quest:4882} goes on to {npc:5770} in {zone:1456}, off this route: leave it."] = "",

	-- Step 40: Jessir Moonbow
	-- {area:2479} Emerald Sanctuary · {npc:11019} Jessir Moonbow
	["South along the road to the {area:2479}: {npc:11019}, at its east side, takes Trey Lightforge's remains."] = "",

	-- Step 41: Kelek Skykeeper
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["{npc:10920}, at the {area:2479}, takes the High Chief's words."] = "",

	-- Step 42: Eridan Bluewind
	-- {area:2479} Emerald Sanctuary
	["South along the road to the {area:2479}."] = "",
	-- {npc:9116} Eridan Bluewind · {zone:1446} Tanaris
	["{npc:9116}'s Aquementas leads on to {zone:1446} and Un'Goro: leave it."] = "",
	-- {zone:1454} Orgrimmar · {area:431} Splintertree Post
	["In {zone:1454}: fly from {area:431}"] = "",
	-- {zone:1456} Thunder Bluff
	["In {zone:1456}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "Te ha caído una {item:13140}: los Déspotas Jaedenar, Tejeoscuros, Brujos y Legionarios de Bastión de las Sombras la llevan de vez en cuando. Úsala para empezar la misión y luego libera a {npc:11018} de su jaula en el extremo sur de la cueva al salir.",
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Cualquier fúrbolg Nevada puede llevar las cuentas; los campamentos justo al sur de {npc:11556} son los más cercanos.",
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "Vuelve al túnel de los Fauces de Madera y toma la salida de {area:618}; {npc:9298} acampa junto a las aguas termales, justo fuera.",
	-- ["Back south to the Sanctuary, a short ride."] = "Vuelve al sur, al Santuario; está cerca.",
	-- ["Corrupted Soul Shards from the cultists, {quest:5887}"] = "Fragmentos de alma corruptos de los cultistas, {quest:5887}",
	-- ["Dungeon instead of grinding"] = "Mazmorra en vez de farmear",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "Vuela a {area:431} y cabalga hacia el noroeste por el camino que sale de {zone:1440} y entra en {area:361}. {area:2479} es el campamento de los druidas justo pasada la frontera.",
	-- ["From Krakle in Un'Goro"] = "De Krakle en Un'Goro",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Desde {zone:1458}, toma el zepelín de la torre de fuera de la ciudad hasta {zone:1454}.",
	-- ["Grind to 60"] = "Farmea hasta 60",
	-- ["In {zone:1454}: fly from {area:2255}"] = "En {zone:1454}: vuela desde {area:2255}",
	-- ["In {zone:1456}: fly from {area:2255}"] = "En {zone:1456}: vuela desde {area:2255}",
	-- ["On the way back south to Greta, {npc:9529} takes the shards on the west side of the Sanctuary."] = "De vuelta al sur hacia Greta, {npc:9529} recoge los fragmentos en el lado oeste del Santuario.",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Solo si llevas {quest:5087}: los corredores recorren en grupos pequeños el camino de {area:1769} a {area:2244}; espera junto al camino cerca de {npc:9298} y mátalos al pasar. Cada uno lleva una caja.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Solo si {npc:9298} te dio {quest:5086}: cabalga hacia el norte por el camino de {area:361} hasta {area:1767}; los {quest:5086} reptan entre los árboles.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Opcional. Hacer {area:2279}, {area:2057}, Cumbre de Roca Negra inferior o {area:1584} en grupo en vez de farmear te lleva antes.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower {area:1583} or {area:1584} with a group instead of grinding gets you there faster."] = "Opcional. Hacer {area:2279}, {area:2057}, {area:1583} inferior o {area:1584} en grupo en vez de farmear te lleva antes.",
	-- ["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Opcional: en grupo, una mazmorra de 55-60 sustituye al farmeo de abajo.",
	-- ["Ride back west to {area:2246}."] = "Vuelve al oeste hasta {area:2246}.",
	-- ["Ride east along the road to {area:2255}."] = "Cabalga hacia el este por el camino hasta {area:2255}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Cabalga al este y luego al sur bajando por {area:2249}. Los Gigantes Machacahielo de allí son élite de nivel 59: ve por el centro y no te detengas. La fuente extraña está en la boca de {area:2256}, en el extremo sur.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "Cabalga hacia el noroeste hasta {area:1763}. Los cuatro braseros están entre los edificios del Consejo de las Sombras; usa el agua purificada en cada uno.\nCuidado: enemigos del Consejo de las Sombras de nivel 53-55 llenan la cueva y suelen venir en grandes grupos vinculados, muchos con aturdimientos. Se recomienda un grupo de 2-3 jugadores.",
	-- ["South to the Sanctuary once more."] = "Vuelve otra vez al sur, al Santuario.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "El poblado fúrbolg ocupa el valle al noreste de {area:2255}. Mata primero a los Chamanes, que curan. {npc:10738} (59, élite) y Xandivious (62) están en la cueva del fondo: no entres.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "Aquí se acaban las misiones. Los Dentoesquirlas rabiosos merodean por {area:2249}, en el sur de {area:618}, al sur del camino que sale de {area:2255}.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Aquí se acaban las misiones. Los Dentoesquirlas rabiosos merodean por {area:2249}, en el sur de {zone:1452}, al sur del camino que sale de {area:2255}.",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "Cruza el túnel de los Fauces de Madera hasta {area:493}. {npc:11939} lee en una casa de {area:2361}.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "farmea {npc:7446} en {area:2249}, {area:618}",
	-- ["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "farmea {npc:7446} en {area:2249}, {zone:1452}",
	-- ["only if still carried: the {zone:1423} guide hands it in on its way through"] = "solo si aún la llevas: la guía de {zone:1423} la entrega de paso",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "La siguiente misión de {npc:10306}, {quest:4741}, te haría volver aquí desde {area:618}. Omítela.",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "La siguiente misión de {npc:10306}, {quest:4741}, te haría volver aquí desde {zone:1452}. Omítela.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "Corazón de plata, de {npc:9116}, pide un {item:11173} del norte de {area:361} y volver hasta aquí. Omítela.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Corazón de plata, de {npc:9116}, pide un {item:11173} del norte de {zone:1448} y volver hasta aquí. Omítela.",
	-- ["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "Después {npc:9298} te envía a por {npc:10738}, un élite en su cueva. Omítela.",
	-- ["{npc:9529} stands on the west side of the Sanctuary, the way out to {area:1763}. With {quest:4102} done, her {quest:5887} asks for six Corrupted Soul Shards: the Shadow Council cultists in {area:1763} and {area:1770} drop them about one kill in three, and you fight dozens of them for {npc:10922}."] = "{npc:9529} está en el lado oeste del Santuario, en la salida hacia {area:1763}. Con {quest:4102} completada, su misión {quest:5887} pide seis Fragmentos de alma corruptos: los cultistas del Consejo de las Sombras de {area:1763} y {area:1770} los sueltan más o menos uno de cada tres, y vas a matar docenas de ellos para {npc:10922}.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}, {npc:9860} y {npc:9517} esperan al fondo de {area:1770}, la cueva del norte de {area:1763}. Despeja el túnel a tu paso.\nCuidado: los tres jefes luchan en grupo. Mata antes a los enemigos cercanos para no atraer enemigos de más.",
}
