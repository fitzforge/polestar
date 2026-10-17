-- French (frFR): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Depuis {zone:1458}, prenez le zeppelin de la tour hors de la ville pour {zone:1454}.",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Volez jusqu'au {area:431} et suivez la route vers le nord-ouest pour quitter {zone:1440} et entrer dans {zone:1448}. Le camp des druides juste après la frontière est {area:2479}.",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Le Coeur d'argent d'{npc:9116} demande un {item:11173} du nord de {zone:1448} et un retour ici. Passez-la.",

	-- Step 3: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Chevauchez vers le nord-ouest jusqu'à {area:1763}. Les quatre braseros se dressent parmi les bâtiments du Conseil des ombres ; utilisez l'eau purifiée sur chacun.",

	-- Step 4: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Retournez au sud au Sanctuaire d'émeraude, un court trajet.",

	-- Step 5: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} et {npc:9517} attendent au fond de la grotte au nord de {area:1763} : {area:1770}. Nettoyez le tunnel en avançant.",

	-- Step 6: Greta Mosshoof
	["South to the Sanctuary once more."] = "Retournez encore au sud au Sanctuaire d'émeraude.",

	-- Step 7: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Suivez la route vers le nord, après {area:1763}, jusqu'au {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "La quête suivante de {npc:10306}, {quest:4741}, vous ramènerait ici depuis {zone:1452}. Passez-la.",

	-- Step 8: Toxic Horrors
	-- {npc:9298} Donova Snowden · {quest:5086} Toxic Horrors · {zone:1448} Felwood · {area:1767} Irontree Woods
	["Only if {npc:9298} gave you {quest:5086}: ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Seulement si {npc:9298} vous a donné {quest:5086} : remontez la route de {zone:1448} vers le nord jusqu'au {area:1767} ; les cibles de {quest:5086} suintent entre les arbres.",

	-- Step 9: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Seulement avec 30 {quest:6031}, et seulement si vous êtes Neutre avec les Grumegueules : suivez la route vers le nord jusqu'au {area:1769} ; {npc:11557} commerce juste après l'entrée.",

	-- Step 10: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Traversez le tunnel des Grumegueules jusqu'à {zone:1450}. {npc:11939} lit dans une maison de {area:2361}.",

	-- Step 11: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Le Fragment de la Gangrevigne de {npc:11801} demande {area:2577}. Passez-la.",

	-- Step 13: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Retournez dans le tunnel des Grumegueules et prenez la sortie de {zone:1452} ; {npc:9298} campe près des sources chaudes juste dehors.",

	-- Step 14: Winterfall Runners
	-- {quest:5087} Winterfall Runners · {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden
	["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Seulement si vous avez {quest:5087} : les messagers suivent la route du {area:1769} vers le {area:2244} en petits groupes ; attendez au bord de la route près de {npc:9298} et tuez-les au passage. Chacun porte une caisse.",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298} vous envoie ensuite contre {npc:10738}, un élite dans sa grotte. Passez-la.",

	-- Step 15: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Suivez la route vers l'est jusqu'à {area:2255}.",

	-- Step 16: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "Donjon au lieu de tuer des monstres",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Facultatif. Faire {area:2279}, {area:2057}, le bas du Pic Rochenoire ou {area:1584} en groupe au lieu de tuer des monstres vous y amène plus vite.",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Facultatif : en groupe, un donjon 55-60 remplace l'enchaînement de monstres ci-dessous.",

	-- Step 17: Grind to 60
	["Grind to 60"] = "Monter au niveau 60",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Il n'y a plus de quêtes ici. Les Crocs acérés enragés rôdent dans la {area:2249}, au sud de {zone:1452}, au sud de la route depuis {area:2255}.",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "tuez des {npc:7446} dans la {area:2249}, {zone:1452}",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "Pour {zone:1454} : volez depuis {area:2255}",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "Pour {zone:1456} : volez depuis {area:2255}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Optional. Running {area:2279}, {area:2057}, Lower {area:1583} or {area:1584} with a group instead of grinding gets you there faster."] = "Facultatif. Faire {area:2279}, {area:2057}, {area:1583} (partie basse) ou {area:1584} en groupe au lieu de tuer des monstres vous y mène plus vite.",
}
