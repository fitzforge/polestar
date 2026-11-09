-- French (frFR): the guide forever/reputation/stormwind (forever/reputation/stormwind.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Stormwind Reputation"] = "Réputation : Stormwind",
	-- {zone:1422} Western Plaguelands
	["Cloth, the {zone:1422}' cauldron quests and the Elwynn hubs: the quests pay most while you level."] = "Les étoffes, les quêtes des chaudrons des {zone:1422} et les pôles de quêtes de la forêt d'Elwynn : les quêtes rapportent le plus pendant que vous montez de niveau.",
	-- {faction:72} Stormwind
	["Exalted with {faction:72}: in Classic, other races may buy the horses"] = "Exalté auprès de {faction:72} : dans Classic, les autres races peuvent acheter les chevaux",
	-- {faction:72} Stormwind · {area:3197} Chillwind Camp · {zone:1428} Burning Steppes
	["About 1,150 {faction:72} reputation from level 52-58 quests at {area:3197} and in the {zone:1428}"] = "Environ 1 150 de réputation {faction:72} grâce aux quêtes de niveau 52-58 du {area:3197} et des {zone:1428}",
	-- {faction:72} Stormwind · {area:717} Stockade
	["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717}"] = "",

	-- Step 1: Clavicus Knavingham, the cloth quartermaster
	-- {npc:14722} Clavicus Knavingham
	["{npc:14722}, the cloth quartermaster"] = "{npc:14722}, l'intendant des étoffes",
	-- {npc:14722} Clavicus Knavingham · {faction:72} Stormwind · {item:14047} Runecloth · {quest:7796} Additional Runecloth · {zone:1436} Westfall · {zone:1431} Duskwood · {zone:1422} Western Plaguelands · {zone:1428} Burning Steppes · {area:717} Stockade · {area:87} Goldshire · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{npc:14722} takes cloth for {faction:72}. The arrow leads to him; he stands upstairs inside his building. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7796} pays 50 for every 20 {item:14047}, as often as you like. The Auction House is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do Elwynn (levels 1-10), {zone:1436} (10-18), Redridge (15-25) and {zone:1431} (20-30) while you level through them. After the donations come the level 52-58 quests of the {zone:1422} and the {zone:1428} (about 1,150), then the optional low-level hubs, best rate first: Northshire and the city errands (about 40 a minute at full value), the {area:717} (30), Eastvale and {area:87} (25). Every {faction:72} gain also gives a quarter as much to {zone:1455}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14722} prend les étoffes pour {faction:72}. La flèche mène à lui ; il se tient à l'étage de son bâtiment. Chaque premier don de 60 étoffes de laine, de soie, de tisse-mage et d'{item:14047} rapporte 150 de réputation une seule fois ; après celui d'{item:14047}, {quest:7796} rapporte 50 pour 20 {item:14047}, autant de fois que vous voulez. L'hôtel des ventes est la source d'étoffes la plus rapide. Dans Classic, les quêtes rapportent toute leur réputation tant qu'elles sont au plus 5 niveaux sous le vôtre : faites donc la forêt d'Elwynn (niveaux 1-10), {zone:1436} (10-18), les Carmines (15-25) et {zone:1431} (20-30) en les traversant. Après les dons viennent les quêtes de niveau 52-58 des {zone:1422} et des {zone:1428} (environ 1 150), puis les pôles optionnels de bas niveau, du meilleur rendement au moins bon : le Comté-du-Nord et les courses en ville (environ 40 par minute à plein tarif), la {area:717} (30), le Val d'Est et {area:87} (25). Chaque gain auprès de {faction:72} donne aussi un quart à {zone:1455}, {zone:1457} et aux Exilés de Gnomeregan, sauf les quêtes des zones de départ de niveau 1-10. Diplomate de l'Héritage ajoute jusqu'à 10 % à chaque gain.",
	-- {item:2592} Wool Cloth · {zone:1436} Westfall
	["{item:2592}: Defias, gnolls and kobolds in {zone:1436} and Redridge"] = "{item:2592} : Défias, gnolls et kobolds de {zone:1436} et des Carmines",

	-- Step 2: Stormwind errands
	-- {faction:72} Stormwind
	["{faction:72} errands"] = "Courses à {faction:72}",
	-- {faction:72} Stormwind
	["Optional: four quick deliveries inside {faction:72} for 200 reputation in about five minutes. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 3: Northshire Valley
	-- {area:87} Goldshire · {npc:823} Deputy Willem · {npc:197} Marshal McBride · {area:24} Northshire Abbey
	["Optional: the Human start valley north of {area:87}: about 1,600 reputation in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 4: Northshire: kobolds, wolves and bandanas
	["Northshire: kobolds, wolves and bandanas"] = "Comté-du-Nord : kobolds, loups et foulards",
	-- {npc:6} Kobold Vermin · {item:247834} Nibbled-On Book
	["The {npc:6} dig at the camp north of the abbey; the wolves roam the valley; the Defias at the vineyard east of the abbey drop the bandanas. Keep any {item:247834} a kobold drops: it starts Forever's book chain."] = "La {npc:6} creuse au camp au nord de l'abbaye ; les loups rôdent dans la vallée ; les Défias du vignoble à l'est de l'abbaye laissent les foulards. Gardez tout {item:247834} qu'un kobold laisse : il lance la suite des livres de Forever.",
	-- {item:247834} Nibbled-On Book
	["{item:247834}, from the kobolds"] = "{item:247834}, sur les kobolds",

	-- Step 5: Northshire: back at the abbey
	["Northshire: back at the abbey"] = "Comté-du-Nord : retour à l'abbaye",

	-- Step 6: Northshire: Echo Ridge, Garrick Padfoot and the vineyard
	-- {npc:103} Garrick Padfoot
	["Northshire: Echo Ridge, {npc:103} and the vineyard"] = "Comté-du-Nord : la crête aux échos, {npc:103} et le vignoble",
	-- {area:34} Echo Ridge Mine · {npc:103} Garrick Padfoot · {quest:3904} Milly's Harvest · {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["The Kobold Workers are in {area:34} north of the abbey; {npc:103} stands in the Defias camp east of the vineyard; {quest:3904} crates lie in the vineyard; the rats carrying the {object:83763} run about the abbey grounds."] = "Les Ouvriers kobolds sont dans la {area:34} au nord de l'abbaye ; {npc:103} se tient dans le camp défias à l'est du vignoble ; les caisses ({quest:3904}) sont dans le vignoble ; les rats qui portent les {object:83763} courent autour de l'abbaye.",

	-- Step 7: Northshire: second hand-in
	["Northshire: second hand-in"] = "Comté-du-Nord : deuxième remise",

	-- Step 8: Northshire: the mine and the books
	["Northshire: the mine and the books"] = "Comté-du-Nord : la mine et les livres",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80}, deep in {area:34}"] = "{npc:80}, au fond de la {area:34}",

	-- Step 9: Northshire: last hand-in
	["Northshire: last hand-in"] = "Comté-du-Nord : dernière remise",
	-- {object:563442} Kobold Tracks
	["{object:563442}, east of the abbey"] = "{object:563442}, à l'est de l'abbaye",

	-- Step 10: Northshire: the books end in Goldshire
	-- {area:87} Goldshire
	["Northshire: the books end in {area:87}"] = "Comté-du-Nord : les livres finissent à {area:87}",
	-- {npc:240} Marshal Dughan · {area:87} Goldshire · {area:57} Fargodeep Mine
	-- plural, as words: Lost Books = {item:248001} Lost Book
	["{npc:240} stands in front of the Lion's Pride Inn in {area:87}. The Lost Books drop from the kobolds of {area:57} south of {area:87}; the picture book and the two rare books from the named kobolds there."] = "{npc:240} se tient devant l'auberge de la Fierté du lion à {area:87}. Les livres perdus tombent sur les kobolds de la {area:57} au sud de {area:87} ; le livre d'images et les deux livres rares sur les kobolds nommés qui s'y trouvent.",
	["Arcane Explainer"] = "Arcane Explainer",
	-- {npc:951} Brother Paxton
	["{npc:951}, back at the abbey"] = "{npc:951}, de retour à l'abbaye",

	-- Step 11: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:253} William Pestle
	["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 12: Goldshire: the mines
	-- {area:87} Goldshire
	["{area:87}: the mines"] = "{area:87} : les mines",
	-- {area:57} Fargodeep Mine · {area:87} Goldshire · {area:54} Jasperlode Mine · {item:773} Gold Dust
	["{area:57} is south of {area:87}, {area:54} north-east of it. The kobolds in both drop the candles and the {item:773}; the wolves around {area:87} the pelts."] = "La {area:57} est au sud de {area:87}, la {area:54} au nord-est. Les kobolds des deux mines laissent les bougies et la {item:773} ; les loups autour de {area:87}, les peaux.",

	-- Step 13: Goldshire: back at the inn
	-- {area:87} Goldshire
	["{area:87}: back at the inn"] = "{area:87} : retour à l'auberge",

	-- Step 14: Goldshire: Jasperlode Mine
	["walk into the mine"] = "entrez dans la mine",

	-- Step 15: Goldshire: Westbrook and Hogger
	-- {area:87} Goldshire · {npc:448} Hogger
	["{area:87}: Westbrook and {npc:448}"] = "{area:87} : le ruisseau de l'Ouest et {npc:448}",
	-- {npc:448} Hogger · {area:120} Westbrook Garrison
	["{npc:448} is an elite gnoll west of {area:120}; at 60 he is no trouble. The Wanted poster hangs on the garrison."] = "{npc:448} est un gnoll élite à l'ouest de la {area:120} ; au niveau 60, il ne pose aucun problème. L'avis de recherche est affiché sur la garnison.",
	-- {item:782} Painted Gnoll Armband
	["{item:782}, from the Riverpaw gnolls"] = "{item:782}, sur les gnolls Rivepatte",
	-- {item:1931} Huge Gnoll Claw · {npc:448} Hogger
	["{item:1931}, from {npc:448}"] = "{item:1931}, sur {npc:448}",

	-- Step 16: The farms south of Goldshire
	-- {area:87} Goldshire
	["The farms south of {area:87}"] = "Les fermes au sud de {area:87}",
	-- {area:87} Goldshire · {quest:87} Goldtooth · {area:57} Fargodeep Mine · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch
	["The Stonefields' farm and the Maclures' farm lie on either side of the road south of {area:87}. {quest:87} guards the back of {area:57}; {npc:330} the boar roams the {area:62}."] = "La ferme des Stonefield et celle des Maclure se trouvent de part et d'autre de la route au sud de {area:87}. {quest:87} garde le fond de la {area:57} ; {npc:330}, la laie, erre dans le {area:62}.",
	-- {item:1006} Brass Collar · {npc:330} Princess
	["{item:1006}, from {npc:330}"] = "{item:1006}, sur {npc:330}",

	-- Step 17: Goldtooth and the kelp
	-- {quest:87} Goldtooth
	["{quest:87} and the kelp"] = "{quest:87} et le varech",
	-- {item:981} Bernice's Necklace · {quest:87} Goldtooth
	["{item:981}, from {quest:87}"] = "{item:981}, sur {quest:87}",
	-- {item:1256} Crystal Kelp Frond · {area:18} Crystal Lake
	["{item:1256}, from the murlocs of {area:18}"] = "{item:1256}, sur les murlocs du {area:18}",

	-- Step 18: Goldshire: last hand-in
	-- {area:87} Goldshire
	["{area:87}: last hand-in"] = "{area:87} : dernière remise",

	-- Step 19: Shipment to Stormwind
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, in the {object:2096}"] = "{npc:279}, dans le {object:2096}",

	-- Step 20: Eastvale
	["Eastvale"] = "Val d'Est",
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora
	["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation in 40 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 21: Eastvale: the work
	["Eastvale: the work"] = "Val d'Est : le travail",
	-- {area:91} Tower of Azora · {area:54} Jasperlode Mine
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear · Kobold Geomancers = {npc:476} Kobold Geomancer
	["The murlocs along the river south of the bridge drop the fins; Prowlers and Young Forest Bears roam the woods; the Defias around the Brackwell farm and the {area:91} carry the bandanas; the enchanting supplies lie in their camps north of the tower; the Kobold Geomancers dig at {area:54}; the tools and the river finds lie along the river north of the logging camp."] = "Les murlocs le long de la rivière au sud du pont laissent les nageoires ; Rôdeurs et Jeunes ours des forêts parcourent les bois ; les Défias autour de la ferme des Brackwell et de la {area:91} portent les foulards ; les fournitures d'enchantement sont dans leurs camps au nord de la tour ; les Géomanciens kobolds creusent à la {area:54} ; les outils et les trouvailles de la rivière sont le long de la rivière au nord du camp de bûcherons.",

	-- Step 22: Eastvale: hand in
	["Eastvale: hand in"] = "Val d'Est : rendre les quêtes",

	-- Step 23: Eastvale: Defias Rogue Wizards
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Eastvale: Defias Rogue Wizards"] = "Val d'Est : Sorciers-voleurs défias",
	["opens with Thomas' report"] = "débloquée par le rapport de Thomas",
	-- {item:780} Torn Murloc Fin
	["{item:780}, from the murlocs south of the bridge"] = "{item:780}, sur les murlocs au sud du pont",

	-- Step 24: Stockade: two quests
	-- {area:717} Stockade
	["{area:717}: two quests"] = "{area:717} : deux quêtes",
	-- {area:717} Stockade · {faction:72} Stormwind · {object:2101} Mage Quarter · {npc:1719} Warden Thelwater · {npc:1721} Nikova Raskol · {object:2100} Old Town · {npc:1696} Targorr the Dread · {npc:859} Guard Berton · {area:69} Lakeshire · {npc:1663} Dextren Ward · {npc:270} Councilman Millstipe · {area:42} Darkshire · {npc:639} Edwin VanCleef · {area:1581} Deadmines
	["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation. {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 25: Inside the Stockade
	-- {area:717} Stockade
	["Inside the {area:717}"] = "Dans la {area:717}",
	-- {npc:1716} Bazil Thredd
	-- plural, as words: Red Wool Bandanas = {item:2909} Red Wool Bandana
	["Kill the prisoners, convicts and insurgents in the cells; the Red Wool Bandanas drop from the Defias inside. {npc:1716} waits in the far end."] = "Tuez les prisonniers, détenus et insurgés dans les cellules ; les foulards en laine rouge tombent sur les Défias à l'intérieur. {npc:1716} attend tout au fond.",

	-- Step 26: Stockade: hand in
	-- {area:717} Stockade
	["{area:717}: hand in"] = "{area:717} : rendez les quêtes",

	-- Step 27: A Donation of Silk
	-- {item:4306} Silk Cloth · {area:94} Raven Hill
	["{item:4306} drops from humanoids level 23 to 40: Syndicate in Alterac and Arathi, the Defias of Duskwood's {area:94}, Stranglethorn's trolls."] = "L'{item:4306} tombe sur les humanoïdes de niveau 23 à 40 : le Syndicat en Alterac et en Arathi, les Défias de la {area:94} au bois de la Pénombre, les trolls de Strangleronce.",

	-- Step 28: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1446} Tanaris · {zone:1444} Feralas · {zone:1418} Badlands
	["{item:4338} drops from humanoids level 35 to 50: the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}, the Shadowforge dwarves of the {zone:1418}."] = "L'{item:4338} tombe sur les humanoïdes de niveau 35 à 50 : les ogres Cognedune de {zone:1446}, les nagas Hainecrête de {zone:1444}, les nains Ombreforge des {zone:1418}.",

	-- Step 29: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7796} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60: it all goes to {quest:7796} later."] = "L'{item:14047} tombe sur les humanoïdes de niveau 50 et plus : les cultistes du Fléau et la Croisade écarlate dans les Maleterres, les furbolgs Mort-bois de {zone:1448}, les furbolgs Tombe-hiver du {zone:1452}. Gardez toute l'{item:14047} au-delà des 60 premières : tout ira à {quest:7796} plus tard.",

	-- Step 30: Chillwind Camp: Clear the Way
	-- {npc:10838} Commander Ashlam Valorfist · {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {faction:72} Stormwind · {object:92525} Argent Dawn
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["These quests are level 52 to 58, so they pay in full at 60. {npc:10838} and {npc:11053} at {area:3197}, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side. The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "",

	-- Step 31: Andorhal and Felstone Field
	-- {area:199} Felstone Field
	["Andorhal and {area:199}"] = "Andorhal et {area:199}",
	-- {item:12815} Beacon Torch · {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {npc:10778} Janice Felstone · {faction:72} Stormwind
	["Mark the four watchtowers around Andorhal, north of the camp, with the {item:12815} at each door. {npc:11075} guards the cauldron at {area:199}, west of Andorhal; his key opens it. {npc:10778}'s ghost wanders by the Felstone farmhouse, and her parcel lies inside: it goes to {faction:72} for 150 more."] = "Marquez les quatre tours de guet autour d'Andorhal, au nord du camp, avec la {item:12815} à chaque porte. {npc:11075} garde le chaudron du {area:199}, à l'ouest d'Andorhal ; sa clé l'ouvre. Le fantôme de {npc:10778} erre près de la ferme des Felstone, et son colis se trouve à l'intérieur : il va à {faction:72} pour 150 de plus.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marquez {npc:10902} avec la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marquez {npc:10903} avec la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marquez {npc:10904} avec la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marquez {npc:10905} avec la {item:12815}",
	-- {item:13194} Felstone Field Cauldron Key · {npc:11075} Cauldron Lord Bilemaw
	["{item:13194}, from {npc:11075}"] = "{item:13194}, sur {npc:11075}",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "le {object:176361}",
	-- {object:175894} Janice's Parcel
	["{object:175894}, in the farmhouse"] = "{object:175894}, dans la ferme",

	-- Step 33: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears · {area:199} Felstone Field
	["{npc:11077} guards the cauldron at {area:200}, north-east of {area:199}."] = "{npc:11077} garde le chaudron des {area:200}, au nord-est du {area:199}.",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "le {object:177289}",

	-- Step 34: Chillwind Camp: the Writhing Haunt
	-- {area:3197} Chillwind Camp · {area:202} Writhing Haunt
	["{area:3197}: the {area:202}"] = "{area:3197} : le {area:202}",

	-- Step 35: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["{npc:11076} guards the cauldron at the {area:202}, the farm east of {area:200}."] = "{npc:11076} garde le chaudron du {area:202}, la ferme à l'est des {area:200}.",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "le {object:176393}",

	-- Step 37: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}, in the east of the zone."] = "{npc:11078} garde le chaudron de {area:201}, dans l'est de la zone.",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "le {object:176392}",

	-- Step 38: Chillwind Camp: done
	-- {area:3197} Chillwind Camp
	["{area:3197}: done"] = "{area:3197} : terminé",
	-- {npc:11056} Alchemist Arbington · {area:2057} Scholomance
	["{npc:11056} in the camp also ends The Key to {area:2057} (200), after a longer chain that needs a {area:2057} group."] = "{npc:11056}, au camp, termine aussi La clé de {area:2057} (200), après une plus longue suite de quêtes qui demande un groupe pour {area:2057}.",

	-- Step 39: Stormwind: Janice Felstone's parcel
	-- {faction:72} Stormwind · {npc:10778} Janice Felstone
	["{faction:72}: {npc:10778}'s parcel"] = "{faction:72} : le colis de {npc:10778}",
	-- {npc:10782} Royal Factor Bathrilor · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {npc:3520} Ol' Emma
	["{npc:10782} stands in the city hall on {object:2098}, beside {npc:1646}; {npc:3520} walks the canals."] = "{npc:10782} se tient dans l'hôtel de ville de la {object:2098}, à côté de {npc:1646} ; {npc:3520} se promène le long des canaux.",

	-- Step 40: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {area:69} Lakeshire · {object:2117} Stormwind Keep · {faction:72} Stormwind · {zone:1457} Darnassus · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to {area:69} and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "",

	-- Step 41: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire
	["{npc:344} waits in the town hall of {area:69}."] = "{npc:344} attend dans l'hôtel de ville de {area:69}.",

	-- Step 42: Stormwind Keep
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep · {npc:1749} Lady Katrana Prestor
	["{npc:1748} holds court in {object:2117} with {npc:1749} at his side: speak with her for the second of his quests."] = "{npc:1748} tient sa cour dans le {object:2117} avec {npc:1749} à ses côtés : parlez-lui pour la deuxième de ses quêtes.",
	-- {npc:1749} Lady Katrana Prestor
	["Speak with {npc:1749}"] = "Parlez à {npc:1749}",

	-- Step 43: Lakeshire: Solomon again
	-- {area:69} Lakeshire
	["{area:69}: Solomon again"] = "{area:69} : de nouveau Solomon",
	-- {area:1584} Blackrock Depths · {npc:9023} Marshal Windsor · {faction:72} Stormwind · {area:1583} Blackrock Spire · {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {area:2057} Scholomance
	["With a group the chain goes on into {area:1584}: {npc:9023}, Jail Break! and The Great Masquerade back in {faction:72} pay about 750 {faction:72} more, Maxwell's Mission (Lower {area:1583}) 250, Delivery to Ridgewell 135. Order Must Be Restored ({npc:11878} in the {zone:1423}) pays 200, The Key to {area:2057} 200; Onyxia's head 400 and Nefarian's 200 when the raids open."] = "En groupe, la suite continue dans les {area:1584} : {npc:9023}, Evasion ! et La grande mascarade, de retour à {faction:72}, rapportent environ 750 de {faction:72} de plus, Mission de Maxwell (bas du {area:1583}) 250, La livraison à Ridgewell 135. L'ordre doit être rétabli ({npc:11878} dans les {zone:1423}) rapporte 200, La clé de {area:2057} 200 ; la tête d'Onyxia 400 et celle de Nefarian 200 à l'ouverture des raids.",

	-- Step 44: Additional Runecloth to Honored
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Honored"] = "{quest:7796} jusqu'à Honoré",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {faction:72} Stormwind · {zone:1436} Westfall · {area:69} Lakeshire · {zone:1431} Duskwood · {area:42} Darkshire
	["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's {area:69} (about 3,000) and {zone:1431}'s {area:42} (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 45: Additional Runecloth to Revered
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Revered"] = "{quest:7796} jusqu'à Révéré",
	-- {npc:384} Katie Hunter · {item:14047} Runecloth
	["Honored: in Classic Stormwind's vendors take 10% off for you, {npc:384}'s horses (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honoré : dans Classic, les marchands de Hurlevent vous font 10 % de remise, chevaux de {npc:384} compris (20 po, les rapides 200 po) ; Forever n'a pas tranché, et des sites de guides indiquent 5 % à Amical, jusqu'à 20 % à Exalté. D'Honoré à Révéré, il faut 12 000 de réputation : 240 remises, 4 800 {item:14047}.",

	-- Step 46: Additional Runecloth to Exalted
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Exalted"] = "{quest:7796} jusqu'à Exalté",
	-- {item:14047} Runecloth · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:384} at {area:88} sells her horses to other races in Classic; the Horse and Swift Horse guides cover them."] = "De Révéré à Exalté, il faut 21 000 de réputation : 420 remises, 8 400 {item:14047}. À Exalté, dans Classic, {npc:384} au {area:88} vend ses chevaux aux autres races ; les guides Cheval et Cheval rapide s'en occupent.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717} (in Classic, a fifth of it at 60)"] = "Environ 4 500 de réputation {faction:72} grâce aux quêtes de bas niveau de la forêt d'Elwynn et de la {area:717} (dans Classic, un cinquième au niveau 60)",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et Ombremages (niveau 58-60) en laissent ici ; chaque Fléau tué ici compte aussi pour l'{object:92525} (voir ce guide). L'hôtel des ventes marche aussi.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en laissent ici. L'hôtel des ventes marche aussi.",
	-- ["Keep handing in {quest:7796} until {faction:72} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7796} jusqu'à être Exalté auprès de {faction:72}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["Keep handing in {quest:7796}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7796}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation (200 at a fifth) in 40 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Optionnel : l'est de la forêt d'Elwynn, autour de {npc:261} sur le pont et de la {area:91}, environ 1 000 de réputation (200 au cinquième) en 40 minutes au niveau 60. Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. Passez cette étape pour passer le pôle.",
	-- ["Optional: four quick deliveries inside {faction:72} for 200 reputation (40 at a fifth) in about five minutes. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Optionnel : quatre livraisons rapides dans {faction:72} pour 200 de réputation (40 au cinquième) en cinq minutes environ. Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. Passez cette étape pour passer le pôle.",
	-- ["Optional: the Human start valley north of {area:87}: about 1,600 reputation (320 at a fifth) in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Optionnel : la vallée de départ des humains au nord de {area:87} : environ 1 600 de réputation (320 au cinquième) en 40 minutes au niveau 60, le meilleur rendement des pôles. {npc:823} et {npc:197} se tiennent à l'{area:24}. Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. Passez cette étape pour passer le pôle.",
	-- ["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation (60 at a fifth). {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Optionnel : la {area:717} est la prison de {faction:72}, un donjon dans les canaux du {object:2101}. Au niveau 60, vous la nettoyez seul en dix minutes : 300 de réputation (60 au cinquième). {npc:1719} se tient à l'entrée, {npc:1721} dans la {object:2100}. Deux autres quêtes de la {area:717} commencent hors de la ville, 100 chacune, si vous passez par là : Ce qui se passait ailleurs… ({npc:1696}) auprès de {npc:859} à {area:69} et Crime et Châtiments ({npc:1663}) auprès de {npc:270} à {area:42}. (Les Emeutes de la Prison, 100 de plus, demande d'abord la lettre qui n'a pas été envoyée, sur {npc:639} dans les {area:1581}.) Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. Passez cette étape pour passer le pôle.",
	-- ["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation (290 at a fifth) in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Optionnel : {area:87}, le ruisseau de l'Ouest et les fermes au sud de {area:87} : environ 1 450 de réputation (290 au cinquième) en une heure au niveau 60. {npc:240}, {npc:241} et {npc:253} se tiennent autour de l'auberge de la Fierté du lion. Dans Classic, les quêtes 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles payaient en entier. Votre première remise vous le dira : si elle rapporte un cinquième, passez ces pôles. Passez cette étape pour passer le pôle.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Les Bandits Rivepatte et Sous-chefs Rivepatte (niveau 16-18) en laissent ici. L'hôtel des ventes marche aussi.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Les Mercenaires du Syndicat au Donjon de Stromgarde (niveau 31-32) en laissent ici. L'hôtel des ventes marche aussi.",
	-- ["These quests are level 52 to 58, so they pay in full at 60, or nearly. {npc:10838} and {npc:11053} at {area:3197}, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side (in Classic about 690 {faction:72} at 60, as the first quests are level 52 and 53). The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "Ces quêtes sont de niveau 52 à 58 : elles paient donc en entier au niveau 60, ou presque. {npc:10838} et {npc:11053}, au {area:3197} dans le sud des {zone:1422}, vous envoient contre les quatre chaudrons du Fléau : 820 de réputation {faction:72} en tout et 600 d'{object:92525} en plus (dans Classic, environ 690 de {faction:72} au niveau 60, car les premières quêtes sont de niveau 52 et 53). Les Ecorcheurs squelettes et les Goules écumantes rôdent dans les champs au nord du camp.",
	-- ["{npc:14722} takes cloth for {faction:72} in {zone:1453}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7796} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14722} prend les étoffes pour {faction:72} à {zone:1453}. Les premiers dons de laine, de soie, de tisse-mage et d'{item:14047} (60 étoffes chacun) se font une seule fois et donnent le plus de réputation par étoffe ; ensuite, {quest:7796} se répète jusqu'à Exalté. Être Exalté auprès de la capitale d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14722}: {item:14047} delivered"] = "{npc:14722} : {item:14047} livrée",
	-- ["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to {area:69} and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54: in Classic four fifths of it at 60). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{npc:9562}, au {area:2418} dans le sud-est des {zone:1428}, donne {quest:4183} : une suite de quêtes vers {area:69} et le {object:2117}, 175 de réputation {faction:72} et 175 de {zone:1457} (niveau 54 : dans Classic, quatre cinquièmes au niveau 60). Les Rejetons noirs et {npc:7044} vivent sur les pentes au nord du poste ; {npc:7040} et {npc:7041} à l'ouest, au milieu de la zone.",
	-- ["{quest:7796} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796} prend 20 {item:14047} par remise et se répète autant que vous voulez. Apportez l'{item:14047} par multiples de 20 et rendez tout d'un coup, remise après remise. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off if it paid in full. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's {area:69} (about 3,000) and {zone:1431}'s {area:42} (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7796} : 50 de réputation pour 20 {item:14047}, autant de fois que vous voulez. Après les quatre premiers dons, un non-humain est à Amical 700 sur 6 000 : Honoré est donc à 5 300 : 106 remises, 2 120 {item:14047} (les humains partent 900 plus haut : 88 remises ; l'Exploring the Alliance d'un Skyborne rapportait 100, deux de moins). Les quêtes de niveau 52-58 ci-dessus retirent 23 remises ; chaque pôle de la forêt d'Elwynn que vous avez fait en retire 20 à 30 de plus s'il a payé en entier. D'autres pôles de quêtes rapportent de la réputation {faction:72}, en entier tant qu'ils sont au plus 5 niveaux sous le vôtre : {zone:1436} (environ 2 500 en tout), {area:69} dans les Carmines (environ 3 000) et {area:42} dans {zone:1431} (environ 2 900). Chaque gain auprès d'une ville donne aussi un quart aux trois autres villes de l'Alliance (non compté ici). Rendez toute votre {item:14047} d'un coup.",
}
