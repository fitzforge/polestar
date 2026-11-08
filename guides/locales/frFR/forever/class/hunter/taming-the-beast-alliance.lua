-- French (frFR): the guide forever/class/hunter/taming-the-beast-alliance (forever/class/hunter/taming-the-beast-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6063} Taming the Beast
	["{quest:6063} (Alliance)"] = "{quest:6063} (Alliance)",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "Votre propre familier au niveau 10 : trois domptages d'entraînement avec un {item:15908} vous apprennent {spell:1515}, puis {spell:5149}.",

	-- Step 1: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "Au niveau 10, {npc:254084}, maître des chasseurs sur {zone:2521}, peut vous envoyer à {area:16638} avec {quest:94007}. Ce n'est qu'une indication : passez-la si vous êtes déjà à {area:16638}.",

	-- Step 2: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{npc:252389} à {area:16638}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} se tient avec les maîtres de classe près de la porte ouest de {area:16638}, {npc:254411} à côté d'elle.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389} : le premier {item:15908}",

	-- Step 3: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod · {npc:252389} Quel'ana Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges. Killing one does not count. Keep each rod: it goes back to {npc:252389}."] = "Les Clampants chantevent ne vivent qu'au bord de l'eau : les plus proches courent sur la rive au sud-ouest de {area:16638}, parmi les crabes. Fonctionnement du bâtonnet : ciblez un clampant vivant, utilisez le {item:15908} et restez immobile pendant toute la canalisation pendant qu'il vous frappe ; bouger, riposter ou l'aide de quelqu'un d'autre l'interrompt et coûte l'une des rares charges du bâtonnet. En tuer un ne compte pas. Gardez chaque bâtonnet : il retourne à {npc:252389}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "Utilisez le {item:15908} sur un clampant vivant",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Apprivoisez : {npc:254588}",

	-- Step 4: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "Renvoyez d'abord le clampant (clic droit sur le portrait du familier, {spell:2641}). Les Trotteurs des trombes hargneux paissent dans les {area:16626}, les champs à quelques pas à l'ouest et au sud-ouest de {area:16638}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "Utilisez le {item:15908} sur un trotteur vivant",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Apprivoisez : {npc:251707}",

	-- Step 5: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "Renvoyez le trotteur. Les Alphas vuldrènes chassent dans les mêmes {area:16626}, un peu plus au sud.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "Utilisez le {item:15908} sur un alpha vivant",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Apprivoisez : {npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}, à côté d'elle : {spell:5149}",

	-- Step 6: Grif Wildheart in Kharanos
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos
	["{npc:1231} in {area:131}"] = "{npc:1231} à {area:131}",
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:11807} Tristane Shadowstone · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:1231}, the hunter trainer at the smithy in {area:131}. The Hunter's Path from {npc:5116} in {zone:1455}, {npc:11807} north-west of {area:131} or {npc:5515} in {zone:1453} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "Au niveau 10, allez voir {npc:1231}, le maître des chasseurs à la forge de {area:131}. La Voie du chasseur, donnée par {npc:5116} à {zone:1455}, {npc:11807} au nord-ouest de {area:131} ou {npc:5515} à {zone:1453}, mène aussi ici, pour un peu d'expérience ; ce n'est qu'une indication. Vous êtes plutôt dans la forêt d'Elwynn au niveau 10 ? La suite de quêtes de {npc:251507} à {area:87} enseigne la même chose.",
	-- {npc:1231} Grif Wildheart · {item:15908} Taming Rod
	["{npc:1231}: the first {item:15908}"] = "{npc:1231} : le premier {item:15908}",

	-- Step 7: Large Crag Boar
	-- {area:131} Kharanos · {item:15908} Taming Rod · {npc:1231} Grif Wildheart · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar
	["Large Crag Boars (level 6-7) root around the fields west, south and north-west of {area:131} and respawn every 3 minutes. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, being out of range or anyone else's help breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:1231}. The boars use {spell:6268} from 25 yards, so start with the rod, not {spell:75}. Keep each rod: it goes back to {npc:1231}."] = "Les Grands sangliers des rochers (niveau 6-7) fouillent les champs à l'ouest, au sud et au nord-ouest de {area:131} et réapparaissent toutes les 3 minutes. Fonctionnement du bâtonnet : ciblez une bête vivante, utilisez le {item:15908} et restez immobile pendant toute la canalisation pendant qu'elle vous frappe. Bouger, riposter, être hors de portée ou l'aide de quelqu'un d'autre l'interrompt et coûte l'une des rares charges du bâtonnet ; s'il n'en reste plus, détruisez le bâtonnet, abandonnez la quête et reprenez-la auprès de {npc:1231}. Les sangliers utilisent {spell:6268} à 25 mètres : commencez donc par le bâtonnet, pas par {spell:75}. Gardez chaque bâtonnet : il retourne à {npc:1231}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "Utilisez le {item:15908} sur un sanglier vivant",

	-- Step 8: Snow Leopard
	-- {spell:2641} Dismiss Pet · {area:131} Kharanos
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Juvenile Snow Leopards = {npc:1199} Juvenile Snow Leopard
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Snow Leopards (level 7-8) prowl the slopes south-east of {area:131}, more north-west and west of it; the smaller Juvenile Snow Leopards do not count."] = "Renvoyez d'abord le sanglier (clic droit sur le portrait du familier, {spell:2641}) : un familier d'entraînement relâché peut se retourner contre vous. Les Léopards des neiges (niveau 7-8) rôdent sur les pentes au sud-est de {area:131}, et d'autres au nord-ouest et à l'ouest ; les Jeunes léopards des neiges, plus petits, ne comptent pas.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living leopard"] = "Utilisez le {item:15908} sur un léopard vivant",

	-- Step 9: Ice Claw Bear
	-- {area:131} Kharanos · {area:77} Anvilmar · {spell:3130} Ice Claw
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Dismiss the leopard. Ice Claw Bears (level 7-8) roam the hills around {area:131}, many south-east of it and more north-west toward {area:77}; their {spell:3130} hits hard, so start at full health."] = "Renvoyez le léopard. Les Ours Griffeglace (niveau 7-8) errent dans les collines autour de {area:131}, nombreux au sud-est et d'autres au nord-ouest vers {area:77} ; leur {spell:3130} frappe fort, commencez donc avec toute votre vie.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living bear"] = "Utilisez le {item:15908} sur un ours vivant",

	-- Step 10: Belia Thundergranite in Ironforge
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455}"] = "{npc:10090} à {zone:1455}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1455} Ironforge · {object:32359} Military Ward
	["{npc:10090}, the pet trainer, stands in the {object:32390} in {zone:1455}'s {object:32359}, by the hunter trainers."] = "{npc:10090}, la maîtresse des familiers, se tient dans la salle des Armes, dans {object:32359} de {zone:1455}, près des maîtres des chasseurs.",

	-- Step 11: Dazalar in Dolanaar
	-- {npc:3601} Dazalar · {area:186} Dolanaar
	["{npc:3601} in {area:186}"] = "{npc:3601} à {area:186}",
	-- {npc:3601} Dazalar · {area:186} Dolanaar · {npc:3596} Ayanna Everstride · {area:256} Aldrassil · {npc:4146} Jocaste · {zone:1457} Darnassus · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:3601}, the hunter trainer in {area:186}. The Hunter's Path from {npc:3596} at {area:256}, {npc:4146} in {zone:1457}, {npc:5515} in {zone:1453}, {npc:5116} in {zone:1455} or {npc:1231} in {area:131} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "Au niveau 10, allez voir {npc:3601}, le maître des chasseurs de {area:186}. La Voie du chasseur, donnée par {npc:3596} à {area:256}, {npc:4146} à {zone:1457}, {npc:5515} à {zone:1453}, {npc:5116} à {zone:1455} ou {npc:1231} à {area:131}, mène aussi ici, pour un peu d'expérience ; ce n'est qu'une indication. Vous êtes plutôt dans la forêt d'Elwynn au niveau 10 ? La suite de quêtes de {npc:251507} à {area:87} enseigne la même chose.",
	-- {npc:3601} Dazalar · {item:15908} Taming Rod
	["{npc:3601}: the first {item:15908}"] = "{npc:3601} : le premier {item:15908}",

	-- Step 12: Webwood Lurker
	-- {area:186} Dolanaar · {item:15908} Taming Rod · {spell:1265843} Web · {npc:3601} Dazalar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers (level 5-6) creep through the woods just north-east, south-west and east of {area:186}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, attacking it or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). Their {spell:1265843} roots you but does not break the channel if you keep still. Keep each rod: it goes back to {npc:3601}."] = "Les Rôdeuses Tissebois (niveau 5-6) rampent dans les bois juste au nord-est, au sud-ouest et à l'est de {area:186}. Fonctionnement du bâtonnet : ciblez une bête vivante, utilisez le {item:15908} et restez immobile pendant toute la canalisation pendant qu'elle vous frappe ; bouger, l'attaquer ou l'aide de quelqu'un d'autre l'interrompt et coûte l'une des rares charges du bâtonnet (plus de charges : détruisez le bâtonnet, abandonnez la quête et reprenez-la). Leur {spell:1265843} vous immobilise mais n'interrompt pas la canalisation si vous ne bougez pas. Gardez chaque bâtonnet : il retourne à {npc:3601}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living spider"] = "Utilisez le {item:15908} sur une araignée vivante",

	-- Step 13: Nightsaber Stalker
	-- {spell:2641} Dismiss Pet · {area:259} Lake Al'Ameth · {area:186} Dolanaar
	-- plural, as words: Nightsaber Stalkers = {npc:2043} Nightsaber Stalker
	["Dismiss the spider first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Nightsaber Stalkers (level 7-8) lie on the hillside south of {area:259}, south of {area:186}; the plain Nightsabers by the village do not count."] = "Renvoyez d'abord l'araignée (clic droit sur le portrait du familier, {spell:2641}) : un familier d'entraînement relâché peut se retourner contre vous. Les Rôdeurs sabre-de-nuit (niveau 7-8) sont couchés sur le flanc de la colline au sud du {area:259}, au sud de {area:186} ; les simples sabres-de-nuit près du village ne comptent pas.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "Utilisez le {item:15908} sur un rôdeur vivant",

	-- Step 14: Strigid Screecher
	-- {area:186} Dolanaar
	-- plural, as words: Strigid Screechers = {npc:1996} Strigid Screecher
	["Dismiss the cat. Strigid Screechers (level 7-8), owls, perch in the woods south, south-west and west of {area:186}."] = "Renvoyez le félin. Les Hurleurs Strigid (niveau 7-8), des chouettes, se perchent dans les bois au sud, au sud-ouest et à l'ouest de {area:186}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living owl"] = "Utilisez le {item:15908} sur une chouette vivante",

	-- Step 15: Jocaste in Darnassus
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457}"] = "{npc:4146} à {zone:1457}",
	-- {area:186} Dolanaar · {zone:1457} Darnassus · {npc:4146} Jocaste · {area:1658} Cenarion Enclave
	["Take the road west from {area:186} to {zone:1457}. {npc:4146} stands inside the {area:1658} with the hunter trainers; Silvaria, the pet trainer, is up the ramp next to her."] = "Prenez la route vers l'ouest depuis {area:186} jusqu'à {zone:1457}. {npc:4146} se tient dans l'{area:1658} avec les maîtres des chasseurs ; Silvaria, la maîtresse des familiers, est en haut de la rampe à côté d'elle.",

	-- Step 16: Josephine Carson in Goldshire
	-- {npc:251507} Josephine Carson · {area:87} Goldshire
	["{npc:251507} in {area:87}"] = "{npc:251507} à {area:87}",
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {npc:258930} Isaac Chan · {zone:2521} Zephras Isle
	["At 10 go to {npc:251507}, the hunter trainer who stands with the other trainers by the Lion's Pride Inn in {area:87}; {npc:258930}, the pet trainer, is beside her. Skyborne: this is for one who left {zone:2521} without taming; it teaches the same."] = "Au niveau 10, allez voir {npc:251507}, la maîtresse des chasseurs qui se tient avec les autres maîtres de classe près de l'auberge de la Fierté du lion à {area:87} ; {npc:258930}, le maître des familiers, est à côté d'elle. Éolides : ceci est pour qui a quitté {zone:2521} sans dompter ; on y apprend la même chose.",
	-- {npc:251507} Josephine Carson · {item:15908} Taming Rod
	["{npc:251507}: the first {item:15908}"] = "{npc:251507} : le premier {item:15908}",

	-- Step 17: Rockhide Boar
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {item:15908} Taming Rod · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar
	["Rockhide Boars (level 7-8) graze in three herds south and south-east of {area:87}, toward the {area:64}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again. The boars use {spell:6268}, so start with the rod, not {spell:75}. Killing a boar does not count. Keep each rod: it goes back to Josephine. A Dwarf or Night Elf who took Josephine's rod instead of their home trainer's is led through {area:87} from here."] = "Les Sangliers Rochecuir (niveau 7-8) paissent en trois hardes au sud et au sud-est de {area:87}, vers les {area:64}. Fonctionnement du bâtonnet : ciblez une bête vivante, utilisez le {item:15908} et restez immobile pendant toute la canalisation pendant qu'elle vous frappe. Bouger, riposter, un soin reçu de quelqu'un d'autre ou toute autre personne qui frappe la bête l'interrompt et coûte l'une des rares charges du bâtonnet ; s'il n'en reste plus, détruisez le bâtonnet, abandonnez la quête et reprenez-la. Les sangliers utilisent {spell:6268} : commencez donc par le bâtonnet, pas par {spell:75}. Tuer un sanglier ne compte pas. Gardez chaque bâtonnet : il retourne à Josephine. Un Nain ou un Elfe de la nuit qui a pris le bâtonnet de Josephine au lieu de celui de son maître d'origine est guidé à travers {area:87} à partir d'ici.",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "Apprivoisez : {npc:524}",

	-- Step 18: Gray Forest Wolf
	-- {spell:2641} Dismiss Pet · {area:87} Goldshire · {area:18} Crystal Lake
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Gray Forest Wolves (level 7-8) run in the woods east of {area:87}, east of {area:18}."] = "Renvoyez d'abord le sanglier (clic droit sur le portrait du familier, {spell:2641}) : un familier d'entraînement relâché peut se retourner contre vous. Les Loups forestiers gris (niveau 7-8) courent dans les bois à l'est de {area:87}, à l'est du {area:18}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living wolf"] = "Utilisez le {item:15908} sur un loup vivant",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "Apprivoisez : {npc:1922}",

	-- Step 19: Young Forest Bear
	-- {area:87} Goldshire
	-- plural, as words: Young Forest Bears = {npc:822} Young Forest Bear
	["Dismiss the wolf. Young Forest Bears (level 8-9) roam the woods just south of {area:87}, with more south-west and south-east of town."] = "Renvoyez le loup. Les Jeunes ours des forêts (niveau 8-9) errent dans les bois juste au sud de {area:87}, et d'autres au sud-ouest et au sud-est du bourg.",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "Apprivoisez : {npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, à côté d'elle : {spell:5149}",

	-- Step 20: Your first pet
	["Your first pet"] = "Votre premier familier",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} fonctionne comme le bâtonnet : une bête de votre niveau ou moins, une canalisation pendant laquelle vous ne devez pas bouger, la bête vous frappant tout du long. Un familier garde le niveau auquel vous l'avez dompté et monte de niveau avec vous ; il ne peut jamais dépasser votre niveau, alors domptez-en un proche du vôtre. Chaque famille a sa propre technique sur Forever (la Charge du sanglier, par exemple). Pour monter de niveau, un félin frappe le plus fort (Griffe et {spell:17253}) et un sanglier encaisse davantage.",
	["Tame a beast of your level to keep"] = "Domptez une bête de votre niveau à garder",
	-- {area:87} Goldshire · {zone:1436} Westfall
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Near {area:87} there are no cats: Prowlers (wolves, level 9-10) roam eastern Elwynn, Longsnouts (boars, 10-11) its far south-west by the {zone:1436} border; at 12-13, Young Goretusks (boars) graze the fields of northern {zone:1436}."] = "Près de {area:87}, pas de félins : les Rôdeurs (loups, niveau 9-10) errent dans l'est de la forêt d'Elwynn, les Longroins (sangliers, 10-11) dans son extrême sud-ouest, à la frontière de {zone:1436} ; aux niveaux 12-13, les Jeunes Broche-tripes (sangliers) paissent dans les champs du nord de {zone:1436}.",
	-- {area:131} Kharanos · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Scarred Crag Boars = {npc:1689} Scarred Crag Boar · Mountain Boars = {npc:1190} Mountain Boar
	["Near {area:131}: Snow Leopards (cats, level 7-8) prowl all over {zone:1426}, Scarred Crag Boars (9-10) its east toward {zone:1432}; at 10-11, Mountain Boars roam western {zone:1432}."] = "Près de {area:131} : les Léopards des neiges (félins, niveau 7-8) rôdent dans tout {zone:1426}, les Sangliers des rochers balafrés (9-10) dans son est vers {zone:1432} ; aux niveaux 10-11, les Sangliers des montagnes errent dans l'ouest du {zone:1432}.",
	-- {area:186} Dolanaar · {zone:1438} Teldrassil
	-- plural, as words: Elder Nightsabers = {npc:2033} Elder Nightsaber · Feral Nightsabers = {npc:2034} Feral Nightsaber
	["Near {area:186}: Elder Nightsabers (cats, level 8-9) and Feral Nightsabers (cats, 10-11) prowl the woods of north-western {zone:1438}."] = "Près de {area:186} : les Anciens sabres-de-nuit (félins, niveau 8-9) et les Sabres-de-nuit farouches (félins, 10-11) rôdent dans les bois du nord-ouest de {zone:1438}.",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "Près de {area:16638} : les Alphas vuldrènes (niveau 10), la bête de votre dernier domptage d'entraînement, chassent dans les {area:16626} ; les Matriarches criailleuses (raptors, niveau 9) nichent juste à l'ouest de {area:16638} ; les Urseras trombenoires (ours, 10-11) errent dans le nord de {zone:2521}.",
	-- {spell:1584} Feed Pet · {area:87} Goldshire · {zone:1457} Darnassus · {zone:2521} Zephras Isle · {area:131} Kharanos · {area:186} Dolanaar
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Toddrick the butcher in {area:87}, Jaeana in {zone:1457} and the innkeepers on {zone:2521} sell meat; the innkeepers of {area:131} and {area:186} sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584} : ouvrez votre grimoire, lancez {spell:1584} et cliquez sur une nourriture que mange la famille de votre familier (l'infobulle du familier les liste : les félins mangent viande et poisson, les sangliers presque tout). La viande crue ramassée sur les bêtes compte. Pour en acheter : Toddrick le boucher à {area:87}, Jaeana à {zone:1457} et les aubergistes de {zone:2521} vendent de la viande ; les aubergistes de {area:131} et de {area:186} vendent du pain. Une nourriture proche du niveau du familier le rend le plus heureux ; une nourriture bien plus basse en donne environ la moitié. Vous ne pouvez pas nourrir en combat.",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "Humeur : le visage sur le cadre du familier. Un familier mécontent inflige les trois quarts de ses dégâts, un familier heureux un quart de plus. L'humeur baisse lentement, plus vite quand le familier meurt ; un familier laissé trop longtemps mécontent peut s'enfuir.",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "La loyauté grandit avec le temps et les victimes. Chaque rang de loyauté augmente les points d'entraînement que vous dépensez dans {spell:5149} (niveau du familier multiplié par le rang de loyauté moins un).",
	-- {spell:5149} Beast Training · {area:87} Goldshire · {npc:9980} Shelby Stoneflint · {area:131} Kharanos · {area:186} Dolanaar · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master (Erma in {area:87}, {npc:9980} in {area:131}, Seriadne in {area:186}, {npc:265756} on {zone:2521}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149} (grimoire, onglet Général) apprend à votre familier actuel les techniques que vous connaissez. Pour apprendre une nouvelle technique ou un nouveau rang : laissez votre familier à un maître des écuries (Erma à {area:87}, {npc:9980} à {area:131}, Seriadne à {area:186}, {npc:265756} sur {zone:2521}), domptez une bête qui la possède (l'onglet du grimoire de familier montre ce qu'elle connaît), utilisez la technique en combat jusqu'à ce que le jeu vous dise que vous l'avez apprise, puis reprenez votre familier et apprenez-la-lui avec {spell:5149}. Un familier a au plus quatre techniques actives.",
	-- {spell:1853} Growl · {npc:258930} Isaac Chan · {area:87} Goldshire · {npc:2879} Karrina Mekenda · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:2878} Peria Lamenur · {area:131} Kharanos · {npc:10090} Belia Thundergranite · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {area:186} Dolanaar · {zone:1457} Darnassus · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar
	["Pet trainers sell {spell:1853} ranks and resistances. Alliance: {npc:258930} in {area:87}, {npc:2879} by the hunter trainers in {zone:1453}'s {object:28027}, {npc:2878} in {area:131}, {npc:10090} in {zone:1455}'s {object:32390}, Keldas in {area:186}, Silvaria in {zone:1457}' Cenarion Enclave, {npc:254411} in {area:16638}."] = "Les maîtres des familiers vendent les rangs de {spell:1853} et les résistances. Alliance : {npc:258930} à {area:87}, {npc:2879} près des maîtres des chasseurs dans le {object:28027} de {zone:1453}, {npc:2878} à {area:131}, {npc:10090} dans la salle des Armes de {zone:1455}, Keldas à {area:186}, Silvaria dans l'Enclave cénarienne de {zone:1457}, {npc:254411} à {area:16638}.",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "{spell:883}, {spell:2641} et {spell:982} sont maintenant dans votre grimoire ; {spell:136} vient de votre maître de classe au niveau 12. Un familier mort a besoin de {spell:982} ; un familier qui s'éloigne à plus d'environ 100 mètres est renvoyé et revient avec {spell:883}.",
}
