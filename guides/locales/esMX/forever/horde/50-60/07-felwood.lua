-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Desde {zone:1458}, toma el zepelín en la torre fuera de la ciudad hacia {zone:1454}.",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Vuela a {area:431} y cabalga al noroeste por el camino que sale de {zone:1440} hacia {zone:1448}. {area:2479} es el campamento de los druidas justo pasando la frontera.",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Corazón de plata, de {npc:9116}, requiere un {item:11173} del norte de {zone:1448} y volver aquí. Omítela.",

	-- Step 3: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Cabalga al noroeste hasta {area:1763}. Los cuatro blandones están entre los edificios del Consejo de la Sombra; usa el agua purificada en cada uno.",

	-- Step 4: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Regresa al sur al Santuario, a poca distancia.",

	-- Step 5: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} y {npc:9517} esperan al fondo de {area:1770}, la cueva al norte de {area:1763}. Limpia el túnel a tu paso.",

	-- Step 6: Greta Mosshoof
	["South to the Sanctuary once more."] = "Al sur, al Santuario, una vez más.",

	-- Step 7: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Cabalga al norte por el camino, pasando {area:1763}, hasta {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "La siguiente misión de {npc:10306}, {quest:4741}, te haría volver aquí desde {zone:1452}. Omítela.",

	-- Step 8: Toxic Horrors
	-- {npc:9298} Donova Snowden · {quest:5086} Toxic Horrors · {zone:1448} Felwood · {area:1767} Irontree Woods
	["Only if {npc:9298} gave you {quest:5086}: ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Solo si {npc:9298} te dio {quest:5086}: cabalga al norte por el camino de {zone:1448} hasta {area:1767}; los {quest:5086} rezuman entre los árboles.",

	-- Step 9: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Solo con 30 {quest:6031} y solo en Neutral con los Fauces de Madera: sigue el camino al norte hasta {area:1769}; {npc:11557} comercia justo dentro de la entrada.",

	-- Step 10: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Cruza el túnel de los Fauces de Madera hasta {zone:1450}. {npc:11939} lee en una casa de {area:2361}.",

	-- Step 11: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Fragmentos de gangrevid, de {npc:11801}, requiere {area:2577}. Omítela.",

	-- Step 13: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Vuelve al túnel de los Fauces de Madera y toma la salida a {zone:1452}; {npc:9298} acampa junto a las fuentes termales justo afuera.",

	-- Step 14: Winterfall Runners
	-- {quest:5087} Winterfall Runners · {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden
	["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Solo si llevas {quest:5087}: los corredores recorren el camino de {area:1769} hacia {area:2244} en grupos pequeños; espera junto al camino cerca de {npc:9298} y mátalos al pasar. Cada uno lleva un cajón.",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "Luego {npc:9298} te envía tras {npc:10738}, un élite en su cueva. Omítela.",

	-- Step 15: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Cabalga al este por el camino hasta {area:2255}.",

	-- Step 16: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "Calabozo en vez de matar monstruos",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Opcional. Hacer {area:2279}, {area:2057}, la parte baja de Cumbre de Roca Negra o {area:1584} en grupo en lugar de farmear te lleva allí más rápido.",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Opcional: en grupo, un calabozo de nivel 55-60 sustituye a la matanza de abajo.",

	-- Step 17: Grind to 60
	["Grind to 60"] = "Sube a nivel 60",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Aquí se acaban las misiones. Los Dentoesquirlas rabiosos merodean en {area:2249}, al sur de {zone:1452}, al sur del camino desde {area:2255}.",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "mata {npc:7446} en {area:2249}, {zone:1452}",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "En {zone:1454}: vuela desde {area:2255}",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "En {zone:1456}: vuela desde {area:2255}",
}
