-- French (frFR): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "Vous commencez devant l'abbaye. {npc:823} se tient au pied des marches, {npc:197} dans la grande salle, {npc:951} et {npc:247229} dans la bibliothèque à droite, {npc:196} dehors, à l'angle nord-ouest.",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}, devant l'abbaye",

	-- Step 2: Wolves
	["Wolves"] = "Loups",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "Les Jeunes loups et les Loups des bois rôdent dans les champs tout autour de l'abbaye.",

	-- Step 3: Eagan Peltskinner
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}, de retour au pied des marches de l'abbaye",

	-- Step 4: The kobold camp
	["The kobold camp"] = "Le camp kobold",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "Les {npc:6} creusent dans les vignes au nord-est de l'abbaye. De temps en temps, l'une d'elles laisse tomber un {quest:91741} : faites un clic droit dessus.",

	-- Step 5: Northshire Abbey
	-- {npc:247229} Daniel
	["{npc:247229}, in the library"] = "{npc:247229}, dans la bibliothèque",

	-- Step 6: Echo Ridge Mine
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "Suivez le chemin vers le nord jusqu'à la mine. Les Ouvriers kobolds grouillent devant ; tous les kobolds de la vallée peuvent laisser tomber les {object:83763}.",

	-- Step 7: Northshire Abbey
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer"] = "{npc:911}, le maître des guerriers",
	-- {npc:925} Brother Sammuel
	["{npc:925}, the paladin trainer"] = "{npc:925}, le maître des paladins",
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415}, by the Abbey"] = "{npc:248415}, près de l'abbaye",
	-- {npc:915} Jorik Kerridan
	["{npc:915}, the rogue trainer"] = "{npc:915}, le maître des voleurs",
	-- {npc:375} Priestess Anetta
	["{npc:375}, the priest trainer"] = "{npc:375}, la maîtresse des prêtres",
	-- {npc:198} Khelden Bremen
	["{npc:198}, the mage trainer, inside the Abbey"] = "{npc:198}, le maître des mages, dans l'abbaye",

	-- Step 8: The Defias camp
	["The Defias camp"] = "Le camp défias",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["Defias Thugs camp in the clearing east of the Abbey and along the valley's east side."] = "Les Nervis défias campent dans la clairière à l'est de l'abbaye et le long du flanc est de la vallée.",
	-- plural, as words: Red Burlap Bandanas = {item:752} Red Burlap Bandana
	["Red Burlap Bandanas"] = "Masques rouges",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}: the {object:83763} in the Defias camp"] = "{item:6785} : les {object:83763} dans le camp défias",

	-- Step 10: Milly Osworth
	["She stands by her cart at the vineyard east of the Abbey."] = "Elle se tient près de sa charrette, dans la vigne à l'est de l'abbaye.",

	-- Step 11: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "Les vignes et {npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "Les caisses de raisin se trouvent dans les vignes derrière les Défias. {npc:103} attend près de la cabane, au bout est de la vallée.",

	-- Step 13: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "Elle se tient devant l'entrée de la mine. {npc:248362}, à l'intérieur, est élite : il est conseillé de former un groupe.",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "Dans la {area:34}",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "Les Travailleurs kobolds creusent les tunnels de la mine. {npc:248362} attend au fond du deuxième embranchement à droite.",

	-- Step 15: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415} se tient derrière l'abbaye, près des écuries.",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}, à l'étage",
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "son traqueur de kobolds montre les kobolds à cliquer sur la route de {area:87}",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}, près des écuries au sud de l'abbaye",

	-- Step 16: Goldshire
	-- {area:87} Goldshire · {npc:295} Innkeeper Farley · {npc:240} Marshal Dughan · {npc:253} William Pestle · {npc:241} Remy "Two Times"
	["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "Suivez la route vers le sud pour sortir de la vallée jusqu'à {area:87}. {npc:295} est à l'auberge de la Fierté du lion ; {npc:240} se tient devant la forge de l'autre côté de la route, {npc:253} devant l'auberge et {npc:241} au bord de la route, au sud de celle-ci.",

	-- Step 17: The lake shore
	["The lake shore"] = "La rive du lac",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399} campe au nord-est de l'auberge ; {npc:6306}, {npc:383} et {npc:1651} se tiennent sur la rive du {area:18}, à l'est du village.",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "Asseyez-vous (/sit) près de son feu de camp jusqu'à obtenir {spell:1229451}",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306} : dépeceurs uniquement, les peaux s'obtiennent en dépeçant",

	-- Step 18: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "Les Pièges à poissons se trouvent le long de la rive ouest du lac.",

	-- Step 20: The murloc camp
	["The murloc camp"] = "Le camp murloc",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "Les Murlocs et les Ruisseliers murlocs occupent la rive est ; les Tas de camelote se trouvent dans leur camp.",

	-- Step 22: Goldshire
	-- {npc:1430} Tomas
	["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430} cuisine dans la cuisine de l'auberge.",
	-- {npc:1430} Tomas
	["Speak with {npc:1430}"] = "Parlez à {npc:1430}",

	-- Step 23: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "Suivez la route vers le sud en sortant de {area:87} jusqu'aux {area:64}. {npc:251} attend près de la maison.",

	-- Step 24: The Fargodeep Mine
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "La mine se trouve à l'ouest des vignes. Les Mineurs kobolds et les Tunneliers kobolds occupent les deux niveaux ; {npc:248464}, un kobold nommé, détient le livre d'images dans les tunnels inférieurs. {npc:248464} est élite : il est conseillé de former un groupe.",
	["Walk through the mine"] = "Traversez la mine",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "Grandes bougies",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "Livres perdus : Mineurs kobolds et Tunneliers kobolds",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "Les Joyeux Élémentaires : {npc:248464}",

	-- Step 25: Bait ingredients
	["Bait ingredients"] = "Ingrédients de l'appât",
	-- {object:694855} Overgrown Duskweed
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "L'{object:694855} pousse dans les champs autour des vignes et de la ferme des Stonefield ; les Sangliers Brocheroc des environs fournissent le sang.",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215} : Sangliers Brocheroc",

	-- Step 26: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "La ferme des Stonefield se trouve à l'ouest de la mine. Maman et \"Tatie\" Bernice se tiennent près de la maison.",

	-- Step 27: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "Il se tient près de la rivière, à l'ouest de la ferme.",

	-- Step 28: Gramma Stonefield
	["She sits inside the farmhouse."] = "Elle est assise dans la ferme.",

	-- Step 29: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "Billy joue dans les {area:64}, à l'est de la mine.",

	-- Step 30: Boar meat
	["Boar meat"] = "Viande de sanglier",
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["Stonetusk Boars graze between the vineyards and the farm."] = "Les Sangliers Brocheroc paissent entre les vignes et la ferme.",
	["Chunks of Boar Meat"] = "Morceaux de viande de sanglier",

	-- Step 31: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "\"Tatie\" Bernice Stonefield",

	-- Step 33: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87} se trouve dans la {area:57}, pas sur la colline au-dessus : entrez par l'ouverture et gardez votre gauche jusqu'au fond du niveau inférieur de la mine ; ne prenez pas l'escalier qui monte. Les Bandits défias autour des vignes laissent tomber de temps en temps un {item:1972} : faites un clic droit dessus.",

	-- Step 34: Goldshire
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "{npc:279} à {zone:1453} la reçoit (02-westfall)",

	-- Step 35: Crystal Lake and the wolves
	-- {area:18} Crystal Lake
	["{area:18} and the wolves"] = "Le {area:18} et les loups",
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "Les murlocs de la rive est laissent tomber le varech. Dépeceurs : les Loups forestiers gris rôdent dans les bois entre le lac et la {area:91} ; les Rôdeurs plus à l'est donnent aussi des peaux.",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "Feuilles de Varech cristallin",

	-- Step 36: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "La {area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242} et {npc:248248} se tiennent au pied de la tour.",

	-- Step 37: The bridge
	["The bridge"] = "Le pont",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261} garde le pont sur la route de l'est ; {npc:248265} se tient juste de l'autre côté.",

	-- Step 38: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733} et {npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "La {item:247813}, la Hache détrempée et la Boîte à outils détrempée se trouvent dans la rivière au sud du pont. {npc:330}, une grosse truie, fouille le {area:62} à l'ouest de la rivière avec son {npc:390} : attirez d'abord les porcelets à l'écart. Tuez des Rôdeurs et des Jeunes ours des forêts en chemin.",

	-- Step 40: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "Le {area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "Le camp se trouve au nord-est du pont. Les Fagots de bois traînent autour du camp et dans les bois au nord de celui-ci.",

	-- Step 41: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Il gît près de la rivière, au nord-ouest du camp de bûcherons.",

	-- Step 42: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Les Sorciers-voleurs défias campent sur les rives du {area:86} ; ils laissent aussi tomber les Masques rouges en lin. Le {object:56} gît dans le village murloc de la rive nord-est.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Masques rouges en lin",

	-- Step 43: The gnoll camps
	["The gnoll camps"] = "Les camps gnolls",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Les gnolls Rivepatte campent dans les collines à l'ouest du {area:86} ; les {quest:91725} se trouvent dans leurs camps.",

	-- Step 44: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "Entrée de {quest:76}",

	-- Step 45: The Jasperlode Mine
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "La mine se trouve au sud-ouest des camps gnolls. Les {item:247816} traînent près de l'entrée ; les Géomanciens kobolds occupent les tunnels.",
	["Walk into the mine"] = "Entrez dans la mine",

	-- Step 46: The Tower of Azora
	["Follow the hills south to the tower."] = "Suivez les collines vers le sud jusqu'à la tour.",

	-- Step 48: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner
	["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "Suivez la route vers l'ouest pour revenir à {area:87} ; {npc:6306} et Jason se tiennent sur la rive du lac avant le village.",

	-- Step 49: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "Descendez la route vers le sud jusqu'aux {area:64}.",

	-- Step 50: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "Pommes rouges brillantes, auprès de {npc:894}, pour l'{quest:91736}",

	-- Step 51: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "L'{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "Traversez les champs vers le nord-ouest jusqu'à l'{quest:91736}, au nord de la {area:120}. Mettez-y quatre Pommes rouges brillantes pour obtenir un {item:247824}.",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}, de l'alambic",

	-- Step 52: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries
	["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "Retournez au sud jusqu'à la {area:120}, sur la route de la {zone:1436}. {npc:963} se tient devant la caserne, {npc:955} à côté de lui.",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}"] = "{npc:955} : il veut votre {item:247824}",

	-- Step 53: Forest's Edge
	-- {zone:1436} Westfall · {npc:100} Gruff Swiftbite · {item:1307} Gold Pickup Schedule
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "Les Rivepatte chétifs et les Estafettes Rivepatte occupent les collines au sud de la garnison, le long de la frontière de la {zone:1436}. {npc:100}, un gnoll de niveau 12, circule parmi eux et porte le {item:1307} : faites un clic droit dessus.",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "Brassards peints de gnoll",

	-- Step 56: Guard Thomas
	-- {area:91} Tower of Azora
	["Follow the road east past the {area:91} to the bridge."] = "Suivez la route vers l'est, au-delà de la {area:91}, jusqu'au pont.",

	-- Step 57: Murlocs and the Collector
	["Murlocs and the Collector"] = "Les murlocs et le Collecteur",
	-- {npc:473} Morgan the Collector · {area:62} Brackwell Pumpkin Patch · {npc:248278} Croaky
	-- plural, as words: Murloc Foragers = {npc:46} Murloc Forager · Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way. {npc:248278} roams the murloc shore too: right-click the head it drops. {npc:248278} is elite: grouping up is advised."] = "Les Fourrageurs murlocs et les Rôdeurs murlocs bordent la rivière au sud du pont. {npc:473}, un Défias, arpente le {area:62} à l'ouest de celle-ci. Achevez les Rôdeurs et les Jeunes ours des forêts en chemin. {npc:248278} rôde aussi sur la rive des murlocs : faites un clic droit sur la tête qu'il laisse tomber. {npc:248278} est un élite : mieux vaut être en groupe.",
	-- plural, as words: Torn Murloc Fins = {item:780} Torn Murloc Fin
	["Torn Murloc Fins"] = "Ailerons de murloc déchirés",

	-- Step 58: Ridgepoint Tower
	-- {npc:248277} Merell Ross · {area:798} Ridgepoint Tower
	["{npc:248277} keeps watch at {area:798}, east of the murloc shore. Then head north-west back to the bridge."] = "{npc:248277} monte la garde à {area:798}, à l'est de la rive des murlocs. Repartez ensuite vers le nord-ouest jusqu'au pont.",

	-- Step 61: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "Au nord-est du camp de bûcherons. Les Sorciers-voleurs défias campent sur les rives du lac.",

	-- Step 62: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "Suivez les collines vers le sud jusqu'à la tour, sur la route de l'ouest.",

	-- Step 63: Goldshire
	-- {area:87} Goldshire
	["Follow the road west back to {area:87}."] = "Suivez la route vers l'ouest pour revenir à {area:87}.",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121} : {npc:6122} à {zone:1453} la reçoit",
	-- {npc:927} Brother Wilhelm · {npc:6171} Duthorian Rall · {zone:1453} Stormwind
	["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927} : {npc:6171} à {zone:1453} la reçoit",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377} : {npc:376} à {zone:1453} reçoit les deux",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328} : {npc:5497} à {zone:1453} la reçoit",

	-- Step 64: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507} se tient avec les maîtres de {area:87}. Chacune de ses quêtes vous remet un {item:15908} : utilisez-le sur la bête qu'elle désigne, puis rapportez-lui le bâton. Les Sangliers Rochecuir et les Jeunes ours des forêts rôdent dans les collines au sud des {area:64}, les Loups forestiers gris dans les bois à l'est du {area:18}.",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524} : apprivoisez-le avec le {item:15908}",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922} : apprivoisez-le avec le {item:15908}",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822} : apprivoisez-le avec le {item:15908}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, à côté d'elle : {spell:5149}",

	-- Step 65: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "Suivez la route vers le nord depuis {area:87} jusqu'à {zone:1453}. {npc:5497} se tient dans le Sanctuaire du Sorcier, la tour du {object:2101} ; elle vous remet une flasque pour la cascade du {quest:1861}.",

	-- Step 66: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Quittez {zone:1453} par la porte principale. La cascade du {quest:1861} se trouve au sud-ouest des portes, sur le chemin de la {zone:1436} à l'ouest : remplissez la {item:7207} à son pied.",

	-- Step 67: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "Suivez la route vers le nord depuis {area:87} jusqu'à {zone:1453}. {npc:6122} attend dans la cave de l'{object:2164}, dans le {object:2101}.",

	-- Step 68: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Ressortez par {area:87} et suivez la route vers l'est jusqu'au {area:62}. {npc:881} (niveau 9) se tient près de la ferme.",

	-- Step 69: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "Retournez voir {npc:6122}. Utilisez l'{item:6928} sur le cercle d'invocation dans la cave de l'{object:2164} et vainquez le marcheur du Vide qu'elle appelle.",
	["Subdue the voidwalker"] = "Soumettez le marcheur du Vide",

	-- Step 70: The Tome of Divinity
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2100} Old Town · {item:2589} Linen Cloth
	["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "Suivez la route vers le nord depuis {area:87} jusqu'à {zone:1453}. {npc:6171} et {npc:6173} sont dans la cathédrale de la Lumière ; {npc:6174} se tient dans la {object:2100} et demande dix {item:2589} (les humanoïdes en laissent tomber ; l'hôtel des ventes en vend).",
	-- {quest:2998} Tome of Divinity
	["From the {quest:2998} he gives you"] = "Grâce au {quest:2998} qu'il vous remet",

	-- Step 71: Henze Faulk
	-- {area:87} Goldshire · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Ressortez par {area:87} et allez vers l'est jusqu'au {area:86}. {npc:6172} gît au sud du lac : utilisez le {item:6866} sur lui. Les Sorciers-voleurs défias autour de lui portent le {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Utilisez le {item:6866} sur {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846} : Sorciers-voleurs défias",

	-- Step 72: Gazin Tenorm
	["Back to the Cathedral of Light."] = "Retournez à la cathédrale de la Lumière.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171} : Rédemption",

	-- Step 73: Sentinel Hill
	-- {zone:1436} Westfall · {area:108} Sentinel Hill
	["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. Thor, the gryphon master, stands on the hill."] = "Suivez la route vers l'ouest, au-delà de la garnison du ruisseau de l'ouest, jusqu'en {zone:1436}, puis vers le sud jusqu'à la {area:108}. Thor, le maître des griffons, se tient sur la colline.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "Les Fourrageurs murlocs et les Rôdeurs murlocs bordent la rivière au sud du pont. {npc:473}, un Défias, arpente le {area:62} à l'ouest de celle-ci. Achevez les Rôdeurs et les Jeunes ours des forêts en chemin.",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "Ressortez par {area:87} et suivez la route vers l'est jusqu'au {area:62}. {quest:1688} (niveau 9) se tient près de la ferme.",
	-- ["Summon Voidwalker"] = "Invocation d'un marcheur du Vide",
	-- ["Tame Beast"] = "Apprivoiser une bête",
	-- ["The {skill:356} Traps sit along the west shore of the lake."] = "Les pièges de {skill:356} sont disposés le long de la rive ouest du lac.",
	-- ["{area:57}'s mouth"] = "Entrée de la {area:57}",
	-- ["{item:1006}: Princess"] = "{item:1006} : Princesse",
	-- ["{npc:459}: Summon Imp"] = "{npc:459} : Invocation d'un diablotin",
}
