-- French (frFR): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 2: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "Dans {object:172961}.",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "soixante {item:14047}",

	-- Step 4: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Prendre un vol pour {area:431}",

	-- Step 5: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 6: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Volez jusqu'au {area:431} et suivez la route vers le nord-ouest pour quitter {zone:1440} et entrer dans {zone:1448}. Le camp des druides juste après la frontière est {area:2479}.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, à l'intérieur",
	-- {quest:4084} Silver Heart · {item:11172} Silvery Claws · {item:11173} Irontree Heart · {area:1767} Irontree Woods · {npc:9116} Eridan Bluewind
	["{quest:4084}'s {item:11172} and {item:11173} come from {area:1767} on this guide's ride north; {npc:9116} takes them at the end of the guide, back here."] = "",

	-- Step 7: Rakaiah
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {item:13140} Blood Red Key · {area:1763} Jaedenar
	["Only if {npc:11019} sent you after {npc:9518} (the {item:13140}'s chain): on the ride north, turn west into {area:1763}. {npc:9518} (56) stands by the remains of Trey Lightforge at the edge of the camp, well under you now; Trey's remains go back to {npc:11019} at the end of this guide."] = "",

	-- Step 8: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Suivez la route vers le nord, après {area:1763}, jusqu'au {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4721} Wild Guardians · {area:2255} Everlook · {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{npc:10306}'s last {quest:4721} are the Berserk Owlbeasts north of {area:2255}, on this guide's {zone:1452} loop; he takes them at the end of the guide, back here."] = "",

	-- Step 9: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors · {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {item:11172} Silvery Claws · {npc:14524} Vartrus the Ancient
	-- plural, as words: Irontree Wanderers = {npc:7138} Irontree Wanderer · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	-- was: ["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "Remontez la route du {zone:1448} vers le nord jusqu'au {area:1767} ; les {quest:5086} suintent entre les arbres, et la plupart d'entre elles laissent tomber une gouttelette.\nAttention : des Anciens marcheurs Arbrefer, des élites de niveau 59, marchent parmi les {quest:5086}, et {npc:14524} (63, élite) parcourt les bois : attaquez les Horreurs à la pointe nord du {area:1767}, une à la fois."
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet. The Irontree Wanderers and Stompers (52-53) there carry {npc:9116}'s {item:11173}, the Angerclaw bears and Felpaw wolves his {item:11172}.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "",

	-- Step 11: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Traversez le tunnel des Grumegueules jusqu'à {zone:1450}. {npc:11939} lit dans une maison de {area:2361}.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} se promène autour de {area:2361} : cherchez dans le cercle sur la carte",

	-- Step 13: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 14: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Le Fragment de la Gangrevigne de {npc:11801} demande {area:2577}. Passez-la.",

	-- Step 17: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Retournez dans le tunnel des Grumegueules et prenez la sortie de {zone:1452} ; {npc:9298} campe près des sources chaudes juste dehors.",
	["From Krakle in Un'Goro, if you didn't bring it to her earlier"] = "",

	-- Step 18: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "Les Messagers Tombe-hiver suivent la route du {area:1769} vers {area:2244} en petits groupes ; attendez au bord de la route près de {npc:9298} et tuez-les à leur passage. Chacun porte une caisse.\nAttention : rendre la quête fait apparaître trois ou quatre embusqués Tombe-hiver de niveau 56-57 qui vous attaquent ; vous pouvez leur échapper sur votre monture, camouflé ou avec {spell:5384}, et ils se rassemblent ensuite près du lac pour que vous puissiez prendre la quête suivante.",

	-- Step 19: Salfa
	-- {quest:8464} Winterfall Activity · {area:2255} Everlook · {area:2256} Darkwhisper Gorge
	["{quest:8464}'s village is north-east of {area:2255}, on this guide's way back from {area:2256}."] = "Le village de {quest:8464} est au nord-est de {area:2255}, sur le chemin du retour de {area:2256} dans ce guide.",

	-- Step 20: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Avec 30 {quest:6031} dans vos sacs : suivez la route vers le nord jusqu'au {area:1769} ; {npc:11557} commerce juste après l'entrée.",
	["Below ground"] = "Sous terre",

	-- Step 21: Kernda
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if you are Neutral with the Timbermaw now (the {area:1769} reputation guide gets you there): {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558} se promène par ici : cherchez dans le cercle sur la carte",

	-- Step 22: Witch Doctor Mau'ari
	-- {area:2255} Everlook · {npc:11755} Harlo Wigglesworth · {npc:10307} Witch Doctor Mau'ari · {area:2249} Frostwhisper Gorge
	["Ride east along the road to {area:2255}: {npc:11755} sends you to {npc:10307}, who stands in the town, on the way to {area:2249}."] = "",

	-- Step 24: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	-- was: ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Chevauchez vers l'est, puis descendez {area:2249} vers le sud. Les géants Cognegivre y sont des élites de niveau 59 : restez au milieu et ne vous arrêtez pas. L'étrange source se trouve à l'entrée de {area:2256}, à l'extrémité sud."
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
	["grind on {npc:7446}"] = "tuez en boucle : {npc:7446}",

	-- Step 27: Ice Thistle yetis
	["Ice Thistle yetis"] = "Yétis Chardon de glace",
	-- {area:2255} Everlook · {item:258323} Missing Mail
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["On the ride north to {area:2255}, the Ice Thistle Yetis (55-56) in the hills south-east of the town carry Vizzie's {item:258323}: four pieces."] = "",

	-- Step 28: Are We There, Yeti?
	-- {area:2255} Everlook
	["Ride north to {area:2255}."] = "Allez vers le nord jusqu'à {area:2255}.",
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "Effrayez {npc:10978} avec {npc:10980}",

	-- Step 29: Everlook
	-- {npc:11118} Innkeeper Vizzie · {quest:93406} Unfrozen Deliveries
	["{npc:11118}, in the inn: {quest:93406}"] = "",

	-- Step 31: Winterfall Village
	-- {area:2255} Everlook · {quest:5121} High Chief Winterfall
	-- was: ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "Le village furbolg remplit la vallée au nord-est de {area:2255}. Tuez d'abord les chamans ; ils soignent. {npc:10738} (59, élite) et Xandivious (62) sont dans la grotte au fond : n'y allez pas."
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {quest:5121} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "",

	-- Step 32: Berserk Owlbeasts
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Berserk Owlbeasts"] = "",
	-- {area:2241} Frostsaber Rock · {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["The Berserk Owlbeasts (58-59) roam the slopes of {area:2241}, north of {area:2255} and west of the furbolg valley. Now and then an owlbeast drops a {item:12558}: use it to start {quest:4882}."] = "",

	-- Step 33: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west along the road to {area:2246}."] = "Revenez vers l'ouest par la route jusqu'à {area:2246}.",

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
	["North of Donova, at the tunnel's {zone:1452} exit."] = "Au nord de Donova, à la sortie du tunnel côté {zone:1452}.",

	-- Step 36: Beads for Salfa
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity
	["{npc:11556} takes the beads only once {quest:8464} is handed in: any Winterfall furbolg can carry them, and the camps just south of {npc:11556} are the closest."] = "{npc:11556} n'accepte les perles qu'une fois {quest:8464} rendue : n'importe quel furbolg Tombe-hiver peut les porter, et les camps juste au sud de {npc:11556} sont les plus proches.",
	["Frostfire Winterfall camp"] = "Camp Tombe-hiver des sources chaudes",

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
	-- ["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "Une {item:13140} est tombée : les Massacreurs, Tisseurs de ténèbres, Démonistes et Légionnaires de Jaedenar du Bastion des ombres en portent une de temps en temps. Utilisez-la pour commencer la quête, puis libérez {npc:11018} de sa cage au fond sud de la grotte en repartant.",
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "N'importe quel furbolg Tombe-hiver peut porter les perles ; les camps juste au sud de {npc:11556} sont les plus proches.",
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "Retournez dans le tunnel des Grumegueules et prenez la sortie vers {area:618} ; {npc:9298} campe près des sources chaudes juste à la sortie.",
	-- ["Back south to the Sanctuary, a short ride."] = "Retournez au sud au Sanctuaire d'émeraude, un court trajet.",
	-- ["Corrupted Soul Shards from the cultists, {quest:5887}"] = "Fragments d'âme corrompus sur les cultistes, {quest:5887}",
	-- ["Dungeon instead of grinding"] = "Donjon au lieu de tuer des monstres",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "Volez jusqu'à {area:431} et suivez la route vers le nord-ouest pour sortir d'{zone:1440} et entrer en {area:361}. {area:2479} est le camp des druides juste après la frontière.",
	-- ["From Krakle in Un'Goro"] = "De la part de Krakle, à Un'Goro",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Depuis {zone:1458}, prenez le zeppelin à la tour devant la ville jusqu'à {zone:1454}.",
	-- ["Grind to 60"] = "Monter au niveau 60",
	-- ["In {zone:1454}: fly from {area:2255}"] = "Pour {zone:1454} : volez depuis {area:2255}",
	-- ["In {zone:1456}: fly from {area:2255}"] = "Pour {zone:1456} : volez depuis {area:2255}",
	-- ["Level 59.54"] = "Niveau 59.54",
	-- ["Level 59.9"] = "Niveau 59.9",
	-- ["On the way back south to Greta, {npc:9529} takes the shards on the west side of the Sanctuary."] = "En redescendant au sud vers Greta, {npc:9529} prend les fragments du côté ouest du Sanctuaire d'émeraude.",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Seulement si vous avez {quest:5087} : les messagers suivent la route du {area:1769} vers le {area:2244} en petits groupes ; attendez au bord de la route près de {npc:9298} et tuez-les au passage. Chacun porte une caisse.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Seulement si {npc:9298} vous a donné {quest:5086} : remontez la route de {area:361} vers le nord jusqu'à {area:1767} ; les monstres de {quest:5086} suintent entre les arbres.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Seulement si {npc:9298} vous a donné {quest:5086} : remontez la route de {zone:1448} vers le nord jusqu'au {area:1767} ; les cibles de {quest:5086} suintent entre les arbres.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Facultatif. Faire {area:2279}, {area:2057}, le bas du Pic Rochenoire ou {area:1584} en groupe au lieu de tuer des monstres vous y amène plus vite.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower {area:1583} or {area:1584} with a group instead of grinding gets you there faster."] = "Facultatif. Faire {area:2279}, {area:2057}, {area:1583} (partie basse) ou {area:1584} en groupe au lieu de tuer des monstres vous y mène plus vite.",
	-- ["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Facultatif : en groupe, un donjon 55-60 remplace l'enchaînement de monstres ci-dessous.",
	-- ["Ride back west to {area:2246}."] = "Revenez vers l'ouest jusqu'à {area:2246}.",
	-- ["Ride east along the road to {area:2255}."] = "Suivez la route vers l'est jusqu'à {area:2255}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Chevauchez vers l'est, puis descendez {area:2249} vers le sud. Les géants Cognegivre y sont des élites de niveau 59 : restez au milieu et ne vous arrêtez pas. L'étrange source se trouve à l'entrée de {area:2256}, à l'extrémité sud.",
	-- ["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "Remontez la route du {zone:1448} vers le nord jusqu'au {area:1767} ; les {quest:5086} suintent entre les arbres, et la plupart d'entre elles laissent tomber une gouttelette.\nAttention : des Anciens marcheurs Arbrefer, des élites de niveau 59, marchent parmi les {quest:5086}, et {npc:14524} (63, élite) parcourt les bois : attaquez les Horreurs à la pointe nord du {area:1767}, une à la fois.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Chevauchez vers le nord-ouest jusqu'à {area:1763}. Les quatre braseros se dressent parmi les bâtiments du Conseil des ombres ; utilisez l'eau purifiée sur chacun.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "Chevauchez vers le nord-ouest jusqu'à {area:1763}. Les quatre braseros se dressent parmi les bâtiments du Conseil des ombres ; utilisez l'Eau purifiée sur chacun d'eux.\nAttention : des monstres du Conseil des ombres de niveau 53-55 remplissent la grotte et viennent souvent en grands groupes liés, beaucoup avec des étourdissements. Un groupe de 2-3 joueurs est recommandé.",
	-- ["South to the Sanctuary once more."] = "Retournez encore au sud au Sanctuaire d'émeraude.",
	-- ["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then: she waits at the tunnel mouth of {area:1769} and speaks to you from Neutral with the Timbermaw, which the Deadwood furbolgs of {zone:1448} brought you to."] = "Le totem Mort-bois du {area:1762}, si {npc:11558} ne l'a pas pris à ce moment-là : elle attend à l'entrée du tunnel de {area:1769} et vous parle à partir de Neutre avec les Grumegueules, réputation que les furbolgs Mort-bois du {zone:1448} vous ont fait atteindre.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "Le village furbolg remplit la vallée au nord-est de {area:2255}. Tuez d'abord les chamans ; ils soignent. {npc:10738} (59, élite) et Xandivious (62) sont dans la grotte au fond : n'y allez pas.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "Il n'y a plus de quêtes ici. Les Crocs acérés enragés rôdent dans {area:2249}, au sud de {area:618}, au sud de la route venant de {area:2255}.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Il n'y a plus de quêtes ici. Les Crocs acérés enragés rôdent dans la {area:2249}, au sud de {zone:1452}, au sud de la route depuis {area:2255}.",
	-- ["The zeppelin towers"] = "Les tours des zeppelins",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "Passez par le tunnel des Grumegueules jusqu'à {area:493}. {npc:11939} lit dans une maison de {area:2361}.",
	-- ["Top up here to level 59.54 before the hand-ins at {area:1997} : they take you to level 60."] = "Montez ici jusqu'au niveau 59.54 avant de rendre les quêtes ({area:1997}) : elles vous font passer au niveau 60.",
	-- ["Top up here to level 59.9 before the hand-ins at {area:618}: they take you to level 60."] = "Montez ici jusqu'au niveau 59.9 avant de rendre les quêtes ({area:618}) : elles vous font passer au niveau 60.",
	-- ["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Gagnez de l'expérience ici jusqu'au niveau 59.9 avant de rendre les quêtes à {zone:1452} : elles vous amènent au niveau 60. Les Crocs acérés enragés (59) des {area:2249}, juste au nord de l'étrange source, donnent bien plus d'expérience que les furbolgs près de {area:1769}. Ou, en groupe, faites plutôt le donjon {area:2057} ou le donjon {area:2279}.",
	-- ["Zeppelin to {zone:1454}"] = "Zeppelin pour {zone:1454}",
	-- ["grind on {npc:7441}"] = "tuez en boucle : {npc:7441}",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "tuez en boucle : {npc:7446} à {area:2249}, {area:618}",
	-- ["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "tuez des {npc:7446} dans la {area:2249}, {zone:1452}",
	-- ["only if still carried: the {zone:1423} guide hands it in on its way through"] = "seulement si vous l'avez encore : le guide de {zone:1423} la rend en passant",
	-- ["sixty {item:14047}, if you carry them"] = "soixante {item:14047}, si vous les avez sur vous",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "La quête suivante de {npc:10306}, {quest:4741}, vous ferait revenir ici depuis {area:618}. Passez-la.",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "La quête suivante de {npc:10306}, {quest:4741}, vous ramènerait ici depuis {zone:1452}. Passez-la.",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, sous terre",
	-- ["{npc:11558}, at the tunnel mouth; walks around here: look inside the circle on the map"] = "{npc:11558}, à l'entrée du tunnel ; se promène par ici : cherchez à l'intérieur du cercle sur la carte",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "Le Cœur d'argent de {npc:9116} demande un {item:11173} du nord de {area:361} et un retour ici. Passez-la.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Le Coeur d'argent d'{npc:9116} demande un {item:11173} du nord de {zone:1448} et un retour ici. Passez-la.",
	-- ["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298} vous envoie ensuite contre {npc:10738}, un élite dans sa grotte. Passez-la.",
	-- ["{npc:9529} stands on the west side of the Sanctuary, the way out to {area:1763}. With {quest:4102} done, her {quest:5887} asks for six Corrupted Soul Shards: the Shadow Council cultists in {area:1763} and {area:1770} drop them about one kill in three, and you fight dozens of them for {npc:10922}."] = "{npc:9529} se tient du côté ouest du Sanctuaire d'émeraude, sur le chemin de {area:1763}. Une fois {quest:4102} terminée, sa quête {quest:5887} demande six Fragments d'âme corrompus : les cultistes du Conseil des ombres de {area:1763} et de {area:1770} en lâchent environ un sur trois, et vous en combattez des dizaines pour {npc:10922}.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} et {npc:9517} attendent au fond de la grotte au nord de {area:1763} : {area:1770}. Nettoyez le tunnel en avançant.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}, {npc:9860} et {npc:9517} attendent au fond de {area:1770}, la grotte au nord de {area:1763}. Nettoyez le tunnel en avançant.\nAttention : les trois boss combattent ensemble. Tuez d'abord les monstres proches pour ne pas attirer d'ennemis en plus.",
}
