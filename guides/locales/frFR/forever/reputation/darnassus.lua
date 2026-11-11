-- French (frFR): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "Réputation : Darnassus",
	-- {item:11040} Morrowgrain · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["Cloth, {item:11040} and the {zone:1438} and {zone:1439} hubs: the quests pay most while you level."] = "Étoffes, {item:11040} et les étapes de {zone:1438} et de {zone:1439} : les quêtes rapportent le plus pendant que vous montez de niveau.",
	-- {faction:69} Darnassus
	["Exalted with {faction:69}: in Classic, other races may buy the nightsabers"] = "Exalté auprès de {faction:69} : dans Classic, les autres races peuvent acheter les sabres-de-nuit",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain
	["{quest:3803}: 50 reputation for every 10 {item:11040}, as often as you like"] = "{quest:3803} : 50 de réputation pour chaque lot de 10 {item:11040}, aussi souvent que vous le voulez",
	-- {faction:69} Darnassus · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439}"] = "",

	-- Step 1: Raedon Duskstriker, the cloth quartermaster
	-- {npc:14725} Raedon Duskstriker
	["{npc:14725}, the cloth quartermaster"] = "{npc:14725}, l'intendant des étoffes",
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {area:1659} Craftsmen's Terrace · {item:14047} Runecloth · {quest:7801} Additional Runecloth · {area:1662} Tradesmen's Terrace · {zone:1438} Teldrassil · {zone:1439} Darkshore · {zone:1440} Ashenvale · {quest:4183} The True Masters · {zone:1428} Burning Steppes · {item:11040} Morrowgrain · {area:188} Shadowglen · {area:186} Dolanaar · {area:442} Auberdine · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{npc:14725} takes cloth for {faction:69}; he stands in the {area:1659}, in the north-east of {faction:69}, by the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7801} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the {area:1662} is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1438} (levels 1-12), {zone:1439} (11-20) and {zone:1440} (18-30) while you level through them. After the donations come {quest:4183} in the {zone:1428} and {item:11040}, a second repeatable turn-in; then the optional hubs, best rate first: {area:188} (about 35 a minute at full value), {area:186} (28), {area:442} (23). Every {faction:69} gain also gives a quarter as much to {zone:1453}, {zone:1455} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14725} prend les étoffes pour {faction:69} ; il se tient sur la {area:1659}, au nord-est de {faction:69}, près des tailleurs. Chaque premier don de 60 étoffes de laine, de soie, de tisse-mage et d'{item:14047} rapporte une fois 150 de réputation ; après celui d'{item:14047}, {quest:7801} rapporte 50 pour chaque lot de 20 {item:14047}, aussi souvent que vous le voulez. L'hôtel des ventes de la {area:1662} est la source d'étoffes la plus rapide. Dans Classic, les quêtes rapportent toute leur réputation tant qu'elles sont au plus 5 niveaux sous le vôtre : faites donc {zone:1438} (niveaux 1-12), {zone:1439} (11-20) et {zone:1440} (18-30) pendant que vous y montez de niveau. Après les dons viennent {quest:4183} dans les {zone:1428} et l'{item:11040}, une seconde remise répétable ; puis les étapes facultatives, la meilleure d'abord : {area:188} (environ 35 par minute à pleine valeur), {area:186} (28), {area:442} (23). Chaque gain auprès de {faction:69} en donne aussi un quart à {zone:1453}, à {zone:1455} et aux Exilés de Gnomeregan, sauf les quêtes des zones de départ de niveau 1 à 10. Diplomate de l'Héritage ajoute jusqu'à 10 % à chaque gain.",
	-- {item:2592} Wool Cloth · {zone:1439} Darkshore · {zone:1440} Ashenvale
	["{item:2592}: furbolgs, satyrs and naga in {zone:1439} and {zone:1440}"] = "{item:2592} : furbolgs, satyres et nagas de {zone:1439} et d'{zone:1440}",

	-- Step 2: Shadowglen
	-- {zone:1438} Teldrassil · {area:256} Aldrassil
	["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation in 30 minutes at 60. The givers stand around {area:256}, the great tree. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 3: Shadowglen: the glade and the spider den
	-- {area:188} Shadowglen
	["{area:188}: the glade and the spider den"] = "{area:188} : la clairière et l'antre des araignées",
	-- {area:256} Aldrassil · {item:3297} Fel Moss · {npc:8584} Iverron
	["The nightsabers and boars roam the glade; the grells around {area:256} drop the {item:3297}; the totems stand in the furbolg camp north-west of the tree; the Webwood spiders live in the cave north of the glade. {npc:8584} waits outside that cave."] = "Les sabres-de-nuit et les sangliers errent dans la clairière ; les grells autour d'{area:256} laissent la {item:3297} ; les totems se dressent dans le camp de furbolgs au nord-ouest de l'arbre ; les araignées Tissebois vivent dans la grotte au nord de la clairière. {npc:8584} attend devant cette grotte.",

	-- Step 4: Shadowglen: first hand-in
	-- {area:188} Shadowglen
	["{area:188}: first hand-in"] = "{area:188} : première remise",

	-- Step 5: Shadowglen: the egg and the antidote
	-- {area:188} Shadowglen
	["{area:188}: the egg and the antidote"] = "{area:188} : l'œuf et l'antidote",
	-- {quest:917} Webwood Egg · {item:10640} Webwood Ichor
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["The {quest:917} lies at the back of the spider cave; the mushrooms grow by the trees, the lilies by the pools, and the {item:10640} drops from the Webwood Lurkers."] = "L'{quest:917} se trouve au fond de la grotte des araignées ; les champignons poussent près des arbres, les lys près des bassins, et l'{item:10640} tombe des Rôdeuses Tissebois.",

	-- Step 6: Shadowglen: last hand-in
	-- {area:188} Shadowglen
	["{area:188}: last hand-in"] = "{area:188} : dernière remise",
	-- {npc:8584} Iverron
	["{npc:8584}, outside the spider cave"] = "{npc:8584}, devant la grotte des araignées",

	-- Step 7: Dolanaar
	-- {faction:69} Darnassus
	["Optional: the village on the road to {faction:69}, about 1,250 reputation in 45 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 8: Dolanaar: Denalan and the lake
	-- {area:186} Dolanaar · {npc:2080} Denalan
	["{area:186}: {npc:2080} and the lake"] = "{area:186} : {npc:2080} et le lac",
	-- {npc:2080} Denalan · {area:259} Lake Al'Ameth · {npc:2107} Gaerolas Talvethren · {area:260} Starbreeze Village · {area:186} Dolanaar
	["{npc:2080} tends his garden on the south-east shore of {area:259}; {npc:2107} stands upstairs in a house in {area:260}, east of {area:186}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 9: Dolanaar: the woods around the village
	-- {area:186} Dolanaar
	["{area:186}: the woods around the village"] = "{area:186} : les bois autour du village",
	-- {faction:69} Darnassus · {npc:2038} Lord Melenas · {area:258} Fel Rock · {npc:2107} Gaerolas Talvethren
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["The timberlings by the lake drop seeds and sprouts; the Gnarlpine Ambushers lurk on the road west to {faction:69}; {npc:2038} waits deep in {area:258}, north-west of the village; the dreamcatcher lies in the furbolg camp east of the village, by {npc:2107}; the Nightsabers west of the village carry the pelts."] = "Les sylvains près du lac laissent des graines et des pousses ; les Embusqués Pin-tordu guettent sur la route à l'ouest vers {faction:69} ; le {npc:2038} attend au fond du {area:258}, au nord-ouest du village ; l'attrape-rêves se trouve dans le camp de furbolgs à l'est du village, près de {npc:2107} ; les sabres-de-nuit à l'ouest du village portent les peaux.",

	-- Step 10: Dolanaar: first hand-in
	-- {area:186} Dolanaar
	["{area:186}: first hand-in"] = "{area:186} : première remise",

	-- Step 11: Dolanaar: the Ban'ethil Barrow Den's entrance
	-- {area:186} Dolanaar · {area:262} Ban'ethil Barrow Den
	["{area:186}: the {area:262}'s entrance"] = "",

	-- Step 12: Dolanaar: the relics and Ferocitas
	-- {area:186} Dolanaar
	["{area:186}: the relics and Ferocitas"] = "{area:186} : les reliques et Ferocitas",
	-- {area:262} Ban'ethil Barrow Den · {area:186} Dolanaar
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["The four relics of Wakening lie in the {area:262}, south-west of {area:186}; Ferocitas and the Gnarlpine Mystics camp east of the village."] = "Les quatre reliques de l'Éveil se trouvent dans le {area:262}, au sud-ouest de {area:186} ; Ferocitas et les Mystiques Pin-tordu campent à l'est du village.",
	-- {item:8050} Tallonkai's Jewel · {quest:2459} Ferocitas the Dream Eater
	["{item:8050}, from {quest:2459}"] = "{item:8050}, sur {quest:2459}",

	-- Step 13: Dolanaar: Ursal the Mauler
	-- {quest:486} Ursal the Mauler · {area:478} Pools of Arlithrien · {zone:1438} Teldrassil
	["{quest:486}, a big bear, roams the {area:478} in south-west {zone:1438}."] = "{quest:486}, un gros ours, rôde autour des {area:478}, au sud-ouest de {zone:1438}.",

	-- Step 14: Auberdine
	-- {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village
	["Optional: {area:442} in {zone:1439}, a boat trip from {area:702}, about 1,400 reputation in an hour at 60. The givers stand along the town's street and pier. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 15: Auberdine: the coast and the woods
	-- {area:442} Auberdine
	["{area:442}: the coast and the woods"] = "{area:442} : la côte et les bois",
	-- {area:445} Cliffspring Falls
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["The furbolg camp south of town counts for How Big a Threat; the Rabid Thistle Bears roam the woods south of town; the Highborne ghosts of the Ruins of Ameth'Aran, south-east of town, carry the relics, and Anaya's ghost walks there too; the bones lie on the beach south of town; the mushrooms grow in the {area:445} cave to the north-east."] = "Le camp de furbolgs au sud de la ville compte pour Quelle est l'ampleur de la menace ? ; les Ours des chardons enragés errent dans les bois au sud de la ville ; les fantômes bien-nés des ruines d'Ameth'Aran, au sud-est de la ville, portent les reliques, et le fantôme d'Anaya y erre aussi ; les ossements sont sur la plage au sud de la ville ; les champignons poussent dans la grotte des {area:445}, au nord-est.",
	-- {npc:2164} Rabid Thistle Bear · {quest:2139} Tharnariun's Hope · {npc:3701} Tharnariun Treetender
	["{npc:2164}: use {quest:2139} on it and lead it back to {npc:3701}"] = "",
	-- {npc:2164} Rabid Thistle Bear
	["Capture a {npc:2164}"] = "",
	-- {quest:954} Bashal'Aran
	["the blue aura in the ruins of {quest:954}"] = "l'aura bleue dans les ruines de {quest:954}",

	-- Step 16: Auberdine: first hand-in
	-- {area:442} Auberdine
	["{area:442}: first hand-in"] = "{area:442} : première remise",

	-- Step 17: Auberdine: the furbolgs, the bears and the grells
	-- {area:442} Auberdine
	["{area:442}: the furbolgs, the bears and the grells"] = "{area:442} : les furbolgs, les ours et les grells",
	-- {quest:955} Bashal'Aran
	["The Blackwood furbolgs camp south of town; the grells of {quest:955}, east of town, drop the earrings; the sea turtle remains lie on the beach west of town."] = "Les furbolgs Bois-noir campent au sud de la ville ; les grells de {quest:955}, à l'est de la ville, laissent les boucles d'oreilles ; les restes de tortues de mer sont sur la plage à l'ouest de la ville.",

	-- Step 18: Auberdine: second hand-in
	-- {area:442} Auberdine
	["{area:442}: second hand-in"] = "{area:442} : deuxième remise",

	-- Step 19: Auberdine: the seal, the Den Mother and the pelts
	-- {area:442} Auberdine · {npc:6788} Den Mother
	["{area:442}: the seal, the {npc:6788} and the pelts"] = "{area:442} : le sceau, la {npc:6788} et les peaux",
	-- {item:5338} Ancient Moonstone Seal · {quest:956} Bashal'Aran · {npc:6788} Den Mother · {zone:1439} Darkshore
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The {item:5338} drops from the satyrs of {quest:956}; destroy the seal at the flame there. The {npc:6788} lairs north-east of {quest:956}; the Moonstalker Sires and Matriarchs roam the south of {zone:1439}."] = "Le {item:5338} tombe des satyres de {quest:956} ; détruisez le sceau à la flamme qui s'y trouve. La {npc:6788} a son repaire au nord-est de {quest:956} ; les Géniteurs et Matriarches traquelunes errent dans le sud de {zone:1439}.",
	["the seal at the ancient flame"] = "le sceau à la flamme ancienne",

	-- Step 20: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1440} Ashenvale
	["{item:4306} drops from humanoids level 23 to 40: the satyrs and furbolgs of {zone:1440}, the Thistlefur and Foulweald camps, the Grimtotem of Stonetalon."] = "L'{item:4306} tombe des humanoïdes de niveau 23 à 40 : les satyres et furbolgs d'{zone:1440}, les camps Crin-de-Chardon et Vile-sylve, les Totem-sinistre des Serres-Rocheuses.",

	-- Step 21: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1444} Feralas · {zone:1446} Tanaris
	["{item:4338} drops from humanoids level 35 to 50: the Hatecrest naga and Gordunni ogres of {zone:1444}, the Dunemaul ogres of {zone:1446}."] = "L'{item:4338} tombe des humanoïdes de niveau 35 à 50 : les nagas Hainecrête et les ogres Gordunni de {zone:1444}, les ogres Cognedune de {zone:1446}.",

	-- Step 22: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7801} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}, the Scourge cultists of the Plaguelands. Keep any {item:14047} past the first 60 for {quest:7801}."] = "L'{item:14047} tombe des humanoïdes de niveau 50 et plus : les furbolgs Mort-bois de {zone:1448}, les furbolgs Tombe-hiver de {zone:1452}, les sectateurs du Fléau des Maleterres. Gardez l'{item:14047} au-delà des 60 premières pour {quest:7801}.",

	-- Step 23: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {faction:69} Darnassus · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: 175 {faction:69} reputation for two quests (level 54: in Classic 140 at 60), and the chain goes on to {object:2117} for 175 {zone:1453}. The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{npc:9562}, au {area:2418} dans le sud-est des {zone:1428}, lance {quest:4183} : 175 de réputation auprès de {faction:69} pour deux quêtes (niveau 54 : dans Classic, 140 au niveau 60), et la suite continue jusqu'au {object:2117} pour 175 auprès de {zone:1453}. Les Rejetons noirs et le {npc:7044} vivent sur les pentes au nord du camp ; le {npc:7040} et le {npc:7041} à l'ouest, au milieu de la zone.",

	-- Step 24: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {faction:69} Darnassus · {npc:7916} Erelas Ambersky · {area:702} Rut'theran Village · {zone:1452} Winterspring · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands · {item:12663} Glyphed Oaken Branch
	["{npc:344} waits in the town hall of {area:69}; his next quest takes you to {object:2117} (the {zone:1453} guide follows it). Other {faction:69} quests at this level, for when you pass by: {npc:7916} in {area:702} has a wildkin chain into {zone:1452} (325 in all, with Ranshalla's escort), Arei's escort in {zone:1448} pays 150 after the {area:2479}'s chain, {npc:10739} at the {area:202} in the {zone:1422} 100 for the {item:12663}, and Put Her Down in Upper Blackrock Spire 100 with a group."] = "Le {npc:344} attend dans l'hôtel de ville de {area:69} ; sa quête suivante vous mène au {object:2117} (le guide de {zone:1453} la suit). Autres quêtes de {faction:69} à ce niveau, pour quand vous passez dans le coin : {npc:7916}, au {area:702}, a une suite sur les chouettards à {zone:1452} (325 en tout, avec l'escorte de Ranshalla), l'escorte d'Arei à {zone:1448} rapporte 150 après la suite du {area:2479}, {npc:10739}, au {area:202} dans les {zone:1422}, 100 pour la {item:12663}, et Abattez-la dans le haut du Pic Rochenoire 100 en groupe.",

	-- Step 25: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040} (facultatif)",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain · {npc:6735} Innkeeper Saelienne · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50: 220. {npc:6735} sends you to {npc:3516} in the {area:1658}; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "",

	-- Step 28: Un'Goro Crater: Un'Goro Soil
	-- {quest:3764} Un'Goro Soil · {item:11040} Morrowgrain
	["Dig {quest:3764} from the dirt mounds all over the crater; most of the crater's beasts and the Gorishi silithids drop it too, about one kill in three. Take far more than 20: every pouch use takes 2, about 18 for each 10 {item:11040}."] = "Récoltez la {quest:3764} dans les monticules de terre de tout le cratère ; la plupart des bêtes du cratère et les silithides Gorishi en laissent aussi, environ une fois sur trois. Prenez-en bien plus que 20 : chaque utilisation de la bourse en prend 2, environ 18 pour chaque lot de 10 {item:11040}.",

	-- Step 29: Darnassus: Morrowgrain Research
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker · {item:11020} Evergreen Pouch · {quest:3764} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9047}, beside Fandral in the {area:1658}, takes the soil. {npc:4217} sells the {item:11020} and Packets of Tharlendris Seeds. With a seed packet and 2 {quest:3764} in your bags, use the pouch to grow an {item:11024} and open it: about one casing in three holds {item:11040} (1 to 5), the rest other herbs. The pouch works once every 10 minutes, so use it whenever it is ready while you do other things."] = "{npc:9047}, à côté de Fandral dans l'{area:1658}, prend la terre. {npc:4217} vend la {item:11020} et les pochettes de graines de Tharlendis. Avec une pochette de graines et 2 {quest:3764} dans vos sacs, utilisez la bourse pour faire pousser une {item:11024} et ouvrez-la : environ une enveloppe sur trois contient de l'{item:11040} (1 à 5), les autres d'autres herbes. La bourse fonctionne une fois toutes les 10 minutes : utilisez-la dès qu'elle est prête pendant que vous faites autre chose.",

	-- Step 33: Darnassus: Morrowgrain Research
	-- {item:11040} Morrowgrain
	["{item:11040}: grow it here and open the casings"] = "{item:11040} : faites-le pousser ici et ouvrez les enveloppes",

	-- Step 34: Morrowgrain to Darnassus
	-- {item:11040} Morrowgrain · {npc:4217} Mathrengyl Bearwalker · {quest:3764} Un'Goro Soil · {item:14047} Runecloth · {npc:7879} Quintis Jonespyre · {area:1116} Feathermoon Stronghold · {zone:1444} Feralas
	["Every 10 {item:11040}: 50 reputation at {npc:4217}. Keep the pouch and buy seeds as you go. It is slow: about 9 casings, 90 minutes of pouch waits, 18 {quest:3764} and 9 seed packets for each hand-in, a little over 30 reputation an hour, so run it beside the {item:14047}. {npc:7879} at {area:1116} in {zone:1444} takes {item:11040} at the same rate, 25 for 5, after his own quest."] = "Chaque lot de 10 {item:11040} : 50 de réputation auprès de {npc:4217}. Gardez la bourse et achetez des graines au fur et à mesure. C'est lent : environ 9 enveloppes, 90 minutes d'attente de la bourse, 18 {quest:3764} et 9 pochettes de graines par remise, un peu plus de 30 de réputation par heure ; menez-le donc en parallèle de l'{item:14047}. {npc:7879}, au {area:1116} à {zone:1444}, prend l'{item:11040} au même taux, 25 pour 5, après sa propre quête.",

	-- Step 35: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801} jusqu'à Honoré",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {quest:4183} The True Masters · {item:11040} Morrowgrain · {faction:69} Darnassus · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {zone:1444} Feralas
	["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), {area:415} in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 36: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801} jusqu'à Révéré",
	-- {item:14047} Runecloth
	["Honored: in Classic Darnassus's vendors take 10% off for you, Lelanai's nightsabers (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honoré : dans Classic, les marchands de Darnassus vous font 10 % de remise, les sabres-de-nuit de Lelanai (20 po, les rapides 200 po) compris ; Forever n'a pas tranché, et les sites de guides parlent de 5 % à Amical, jusqu'à 20 % à Exalté. D'Honoré à Révéré, il faut 12 000 de réputation : 240 remises, 4 800 {item:14047}.",

	-- Step 37: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801} jusqu'à Exalté",
	-- {item:14047} Runecloth · {area:1658} Cenarion Enclave · {faction:69} Darnassus
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, Lelanai at the {area:1658} in {faction:69} sells her nightsabers to other races in Classic; the Saber and Swift Saber guides cover them."] = "De Révéré à Exalté, il faut 21 000 de réputation : 420 remises, 8 400 {item:14047}. À Exalté, Lelanai, dans l'{area:1658} de {faction:69}, vend ses sabres-de-nuit aux autres races dans Classic ; les guides Sabre et Sabre rapide en parlent.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439} (in Classic, a fifth of it at 60)"] = "Environ 3 700 de réputation auprès de {faction:69} grâce aux quêtes de bas niveau de {zone:1438} et de {zone:1439} (dans Classic, un cinquième au niveau 60)",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) en lâchent ici ; chaque Fléau tué ici compte aussi pour {object:92525} (voir ce guide). L'hôtel des ventes convient aussi.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en lâchent ici. L'hôtel des ventes convient aussi.",
	-- ["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7801} jusqu'à être Exalté auprès de {faction:69}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans {zone:1423}, ou l'hôtel des ventes.",
	-- ["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7801}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans {zone:1423}, ou l'hôtel des ventes.",
	-- ["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation (210 at a fifth) in 30 minutes at 60. The givers stand around {area:256}, the great tree. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : la clairière de départ des Elfes de la nuit au nord-est de {zone:1438}, environ 1 050 de réputation (210 à un cinquième) en 30 minutes au niveau 60. Les donneurs de quêtes se tiennent autour d'{area:256}, le grand arbre. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Optional: the village on the road to {faction:69}, about 1,250 reputation (250 at a fifth) in 45 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : le village sur la route de {faction:69}, environ 1 250 de réputation (250 à un cinquième) en 45 minutes au niveau 60. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Optional: {area:442} in {zone:1439}, a boat trip from {area:702}, about 1,400 reputation (280 at a fifth) in an hour at 60. The givers stand along the town's street and pier. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Facultatif : {area:442} à {zone:1439}, à un trajet en bateau du {area:702}, environ 1 400 de réputation (280 à un cinquième) en une heure au niveau 60. Les donneurs de quêtes se tiennent le long de la rue et de la jetée de la ville. Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. Passez cette étape pour sauter ce groupe de quêtes.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Les Bandits et Sous-chefs Rivepatte (niveau 16-18) en lâchent ici. L'hôtel des ventes convient aussi.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Les Mercenaires du Syndicat au Donjon de Stromgarde (niveau 31-32) en lâchent ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725} recueille le tissu pour {faction:69}, à {faction:69}. Les premiers dons de laine, de soie, de tisse-mage et de {item:14047} (60 étoffes chacun) ne se font qu'une fois et rapportent le plus de réputation par étoffe ; ensuite, {quest:7801} se répète jusqu'à Exalté. Être Exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14725}: {item:14047} delivered"] = "{npc:14725} : {item:14047} livrée",
	-- ["{npc:2080} tends his garden on the south-east shore of {area:259}; {npc:2107} stands in the {area:736} east of the village."] = "{npc:2080} s'occupe de son jardin sur la rive sud-est du {area:259} ; {npc:2107} se tient dans le {area:736}, à l'est du village.",
	-- ["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50 (in Classic a fifth at 60): 220 at full. {npc:6735} sends you to {npc:3516} in the {area:1658}; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "{quest:3803} prend 10 {item:11040} contre 50, aussi souvent que vous le voulez, et rapporte en entier au niveau 60. La suite qui la précède est de niveau 50 (dans Classic, un cinquième au niveau 60) : 220 à pleine valeur. L'{npc:6735} vous envoie auprès de l'{npc:3516} dans l'{area:1658} ; il veut 20 {quest:3764}. (Les aubergistes de {zone:1453} et de {zone:1455} donnent le même départ.)",
	-- ["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801} demande 20 {item:14047} par rendu et se répète autant que vous voulez. Apportez du {item:14047} par multiples de 20 et rendez tout d'un coup, un rendu après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans {zone:1423}, ou l'hôtel des ventes.",
	-- ["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off if it paid in full. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), {area:415} in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7801} : 50 de réputation pour 20 {item:14047}, aussi souvent que vous le voulez. Après les quatre premiers dons, un Humain, un Nain ou un Gnome est à Amical 700 sur 6 000, donc Honoré est à 5 300 : 106 remises, 2 120 {item:14047} (les Elfes de la nuit commencent 900 plus haut : 88 remises ; les Éolides commencent à Neutre 500, donc à 7 900 : 158, deux de moins après Exploring the Alliance). {quest:4183} et la suite de l'{item:11040} ci-dessus en retirent 8, et chaque lot de 10 {item:11040} rendu compte pour une de plus ; chaque groupe de quêtes que vous avez fait en retire 20 à 28 de plus s'il a rapporté en entier. D'autres quêtes rapportent auprès de {faction:69}, en entier tant qu'elles ne sont pas plus de 5 niveaux sous le vôtre : le reste de {zone:1439} (environ 3 400 de plus), {area:415} dans {zone:1440} (environ 3 900) et Pennelune à {zone:1444} (environ 1 700). Chaque gain auprès d'une ville en donne aussi un quart aux trois autres villes de l'Alliance (non compté ici). Rendez tout votre {item:14047} d'un coup.",
}
