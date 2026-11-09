-- Spanish (Spain) (esES): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tirisfal Glades
	["The zeppelin towers"] = "",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 4: Zeppelin to Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Desde {zone:1458}, toma el zepelín de la torre de fuera de la ciudad hasta {zone:1454}.",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "",

	-- Step 6: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "",

	-- Step 7: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 8: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Vuela a {area:431} y cabalga hacia el noroeste por el camino que sale de {zone:1440} y entra en {zone:1448}. {area:2479} es el campamento de los druidas justo pasada la frontera.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Corazón de plata, de {npc:9116}, pide un {item:11173} del norte de {zone:1448} y volver hasta aquí. Omítela.",

	-- Step 9: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "",
	["Below ground"] = "",

	-- Step 10: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Vuelve al sur, al Santuario; está cerca.",

	-- Step 11: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Cabalga hacia el norte por el camino, dejando atrás {area:1763}, hasta {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "La siguiente misión de {npc:10306}, {quest:4741}, te haría volver aquí desde {zone:1452}. Omítela.",

	-- Step 12: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",

	-- Step 13: Greta Mosshoof
	["South to the Sanctuary once more."] = "Vuelve otra vez al sur, al Santuario.",

	-- Step 14: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet."] = "",

	-- Step 16: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Cruza el túnel de los Fauces de Madera hasta {zone:1450}. {npc:11939} lee en una casa de {area:2361}.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "",

	-- Step 18: Class trainer
	["Class trainer"] = "",

	-- Step 19: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Fragmentos de gangrevid, de {npc:11801}, requiere {area:2577}. Omítela.",

	-- Step 22: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Vuelve al túnel de los Fauces de Madera y toma la salida de {zone:1452}; {npc:9298} acampa junto a las aguas termales, justo fuera.",
	["From Krakle in Un'Goro"] = "De Krakle en Un'Goro",

	-- Step 23: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 25: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Cualquier fúrbolg Nevada puede llevar las cuentas; los campamentos justo al sur de {npc:11556} son los más cercanos.",
	["Frostfire Winterfall camp"] = "Campamento Nevada de los Baños de Fuego de Escarcha",

	-- Step 27: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "",

	-- Step 28: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only at Neutral with the Timbermaw: {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 30: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Cabalga al este y luego al sur bajando por {area:2249}. Los Gigantes Machacahielo de allí son élite de nivel 59: ve por el centro y no te detengas. La fuente extraña está en la boca de {area:2256}, en el extremo sur.",

	-- Step 31: Level 59.9
	["Level 59.9"] = "",
	-- {zone:1452} Winterspring · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "",

	-- Step 32: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "Vuelve al oeste hasta {area:2246}.",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "Después {npc:9298} te envía a por {npc:10738}, un élite en su cueva. Omítela.",

	-- Step 33: Are We There, Yeti?
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "",

	-- Step 34: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Cabalga hacia el este por el camino hasta {area:2255}.",

	-- Step 35: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "Mazmorra en vez de farmear",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Opcional. Hacer {area:2279}, {area:2057}, Cumbre de Roca Negra inferior o {area:1584} en grupo en vez de farmear te lleva antes.",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Opcional: en grupo, una mazmorra de 55-60 sustituye al farmeo de abajo.",

	-- Step 36: Grind to 60
	["Grind to 60"] = "Farmea hasta 60",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Aquí se acaban las misiones. Los Dentoesquirlas rabiosos merodean por {area:2249}, en el sur de {zone:1452}, al sur del camino que sale de {area:2255}.",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "farmea {npc:7446} en {area:2249}, {zone:1452}",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "En {zone:1454}: vuela desde {area:2255}",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "En {zone:1456}: vuela desde {area:2255}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "Vuelve al túnel de los Fauces de Madera y toma la salida de {area:618}; {npc:9298} acampa junto a las aguas termales, justo fuera.",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "Vuela a {area:431} y cabalga hacia el noroeste por el camino que sale de {zone:1440} y entra en {area:361}. {area:2479} es el campamento de los druidas justo pasada la frontera.",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Desde {zone:1458}, toma el zepelín de la torre de fuera de la ciudad hasta {zone:1454}.",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Solo si llevas {quest:5087}: los corredores recorren en grupos pequeños el camino de {area:1769} a {area:2244}; espera junto al camino cerca de {npc:9298} y mátalos al pasar. Cada uno lleva una caja.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Solo si {npc:9298} te dio {quest:5086}: cabalga hacia el norte por el camino de {area:361} hasta {area:1767}; los {quest:5086} reptan entre los árboles.",
	-- ["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Solo con 30 de {quest:6031}, y solo si eres Neutral con los Fauces de Madera: sigue el camino hacia el norte hasta {area:1769}; {npc:11557} comercia justo al pasar la entrada.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower {area:1583} or {area:1584} with a group instead of grinding gets you there faster."] = "Opcional. Hacer {area:2279}, {area:2057}, {area:1583} inferior o {area:1584} en grupo en vez de farmear te lleva antes.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Cabalga hacia el noroeste hasta {area:1763}. Los cuatro braseros están entre los edificios del Consejo de las Sombras; usa el agua purificada en cada uno.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "Aquí se acaban las misiones. Los Dentoesquirlas rabiosos merodean por {area:2249}, en el sur de {area:618}, al sur del camino que sale de {area:2255}.",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "Cruza el túnel de los Fauces de Madera hasta {area:493}. {npc:11939} lee en una casa de {area:2361}.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "farmea {npc:7446} en {area:2249}, {area:618}",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "La siguiente misión de {npc:10306}, {quest:4741}, te haría volver aquí desde {area:618}. Omítela.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "Corazón de plata, de {npc:9116}, pide un {item:11173} del norte de {area:361} y volver hasta aquí. Omítela.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} y {npc:9517} esperan al fondo de {area:1770}, la cueva del norte de {area:1763}. Despeja el túnel a tu paso.",
}
