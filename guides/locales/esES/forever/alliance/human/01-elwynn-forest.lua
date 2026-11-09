-- Spanish (Spain) (esES): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "Empiezas delante de la abadía. {npc:823} está al pie de la escalinata; {npc:197}, dentro de la sala; {npc:951} y {npc:247229}, en la biblioteca de la derecha; {npc:196}, fuera, en la esquina noroeste.",
	-- {npc:197} Marshal McBride
	["{npc:197}, inside"] = "",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}, fuera de la abadía",

	-- Step 2: Wolves
	["Wolves"] = "Lobos",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "Los Lobos jóvenes y los Lobos madereros recorren los campos junto a la abadía.",

	-- Step 3: Deputy Willem
	-- {npc:198} Khelden Bremen
	["Mages: {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}, de vuelta en la escalinata de la abadía",

	-- Step 4: The kobold camp
	["The kobold camp"] = "El campamento kóbold",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "{npc:6} excavan en los viñedos al noreste de la abadía. De vez en cuando uno suelta un {quest:91741}: haz clic derecho en él.",

	-- Step 5: Northshire Abbey
	["Inside"] = "",
	-- {npc:247229} Daniel
	["{npc:247229}, in the library; inside"] = "",

	-- Step 6: Echo Ridge Mine: kill these as you meet them
	-- {area:34} Echo Ridge Mine
	["{area:34}: kill these as you meet them"] = "",
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "Sigue el sendero hacia el norte hasta la mina. Los Trabajadores kóbold pululan fuera; cualquier kóbold del valle puede soltar {object:83763}.",

	-- Step 7: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade · {npc:198} Khelden Bremen
	["{npc:248415} stands behind the Abbey, by the stables. {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer; inside"] = "",
	-- {npc:925} Brother Sammuel
	["{npc:925}, the paladin trainer"] = "{npc:925}, el instructor de paladines",
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415}, by the Abbey"] = "{npc:248415}, junto a la abadía",
	-- {npc:915} Jorik Kerridan
	["{npc:915}, the rogue trainer"] = "{npc:915}, el instructor de pícaros",
	-- {npc:375} Priestess Anetta
	["{npc:375}, the priest trainer"] = "{npc:375}, la instructora de sacerdotes",
	-- {npc:198} Khelden Bremen
	["{npc:198}, the mage trainer, inside the Abbey"] = "{npc:198}, el instructor de magos, dentro de la abadía",

	-- Step 8: The Defias camp
	["The Defias camp"] = "El campamento Defias",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["Defias Thugs camp in the clearing east of the Abbey and along the valley's east side."] = "Los Matones Defias acampan en el claro al este de la abadía y por el lado este del valle.",
	-- plural, as words: Red Burlap Bandanas = {item:752} Red Burlap Bandana
	["Red Burlap Bandanas"] = "Arpilleras rojas",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}: the {object:83763} in the Defias camp"] = "{item:6785}: {object:83763} del campamento Defias",

	-- Step 9: Deputy Willem
	["She stands by her cart at the vineyard east of the Abbey."] = "Está junto a su carro, en el viñedo al este de la abadía.",

	-- Step 10: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "Los viñedos y {npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "Las cajas de uvas están en los viñedos, detrás de los Defias. {npc:103} espera junto a la cabaña del extremo este del valle.",

	-- Step 12: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "Está fuera, en la entrada de la mina. {npc:248362}, dentro, es élite: se recomienda ir en grupo.",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "Dentro de {area:34}",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "Los Obreros kóbold trabajan en los túneles de la mina. {npc:248362} espera tras el segundo giro a la derecha.",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80} walks around {area:34}: look inside the circle on the map"] = "",

	-- Step 15: Inside Echo Ridge Mine
	-- {npc:248362} Shinyfinder Narf
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248362} (level 3 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 16: Northshire Abbey
	-- {npc:823} Deputy Willem
	["{npc:823}, at the Abbey steps"] = "",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}, en el piso de arriba",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}, junto a los establos al sur de la abadía",

	-- Step 17: Northshire Abbey
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "su rastreador de kóbolds muestra los kóbolds en los que hacer clic en el camino a {area:87}",

	-- Step 18: Level 5.48
	["Level 5.48"] = "",
	-- {quest:91752} The Big Picture
	["If you skipped {quest:91752}, grind here to level 5.48 to stay on the route's plan."] = "",
	-- {npc:80} Kobold Laborer
	["grind on {npc:80}"] = "",

	-- Step 19: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:295} Innkeeper Farley · {npc:253} William Pestle
	["Follow the road south out of the valley to {area:87}. {npc:240} stands outside the smithy on the west side of the road, {npc:241} by the road south of it, and {npc:295} and {npc:253} in the Lion's Pride Inn across the road."] = "",
	-- {npc:295} Innkeeper Farley
	["{npc:295}, inside"] = "",
	-- {npc:253} William Pestle
	["{npc:253}, inside"] = "",

	-- Step 22: Level 5.77
	["Level 5.77"] = "",
	-- {quest:91752} The Big Picture
	["If you skipped {quest:91752}, grind here to level 5.77 to stay on the route's plan."] = "",
	-- {npc:40} Kobold Miner
	["grind on {npc:40}"] = "",

	-- Step 23: The lake shore
	["The lake shore"] = "La orilla del lago",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399} acampa al noreste de la posada; {npc:6306}, {npc:383} y {npc:1651} están en la orilla de {area:18}, al este del pueblo.",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "Siéntate (/sentarse) junto a su hoguera hasta tener {spell:1229451}",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned; inside"] = "",

	-- Step 24: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "Las trampas de pesca ({object:694772}) están en la orilla oeste del lago.",

	-- Step 26: Crystal Lake: kill these as you meet them
	-- {area:18} Crystal Lake
	["{area:18}: kill these as you meet them"] = "",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "Los múrlocs y los Correcorrientes múrloc ocupan la orilla este; los Montones de chatarra están en su campamento.",

	-- Step 28: Goldshire
	-- {npc:1430} Tomas · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:1430} cooks in the inn's kitchen. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:1430} Tomas
	["{npc:1430}: Camping 101 asks you to learn it; below ground"] = "",

	-- Step 29: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "Sigue el camino hacia el sur, fuera de {area:87}, hasta {area:64}. {npc:251} Maclure espera junto a la casa.",

	-- Step 30: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "Está junto al río, al oeste de la granja.",

	-- Step 31: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house.\nShe sits inside the farmhouse."] = "",

	-- Step 32: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "Billy Maclure juega en {area:64}, al este de la mina.",

	-- Step 33: Elwynn Forest: kill these as you meet them
	-- {zone:1429} Elwynn Forest
	["{zone:1429}: kill these as you meet them"] = "",
	-- {object:694855} Overgrown Duskweed
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood.\nStonetusk Boars graze between the vineyards and the farm."] = "",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215}: Jabalíes colmillopétreo",
	["Chunks of Boar Meat"] = "Trozos de carne de jabalí",

	-- Step 34: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "\"Tía\" Bernice Pedregosa",

	-- Step 36: Maclure Vineyards: kill these as you meet them
	-- {area:64} Maclure Vineyards
	["{area:64}: kill these as you meet them"] = "",
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "La mina está al oeste de los viñedos. Los Mineros kóbold y los Tuneladores llenan ambos niveles; {npc:248464}, un kóbold con nombre, tiene el álbum de fotos en los túneles inferiores. {npc:248464} es élite: se recomienda ir en grupo.",
	["Walk through the mine"] = "Recorre la mina",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "Velas grandes",

	-- Step 37: Maclure Vineyards: kill these as you meet them
	-- {npc:248464} Nimsy
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248464} (level 6 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "Libros perdidos: Mineros kóbold y Tuneladores",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "Álbum de fotos: diversión con elementales: {npc:248464}",

	-- Step 38: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87} está dentro de {area:57}, no en la colina de encima: entra por la boca y ve por la izquierda hasta el fondo de la mina; no subas las escaleras. Los Bandidos Defias de los viñedos sueltan de vez en cuando una {item:1972}: haz clic derecho en ella.",
	-- {item:981} Bernice's Necklace
	["{item:981}; below ground"] = "",

	-- Step 39: Goldshire
	-- {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "{npc:279}, en {zone:1453}, lo recibe (02-westfall)",

	-- Step 41: Level 8.39
	["Level 8.39"] = "",
	-- {quest:91775} Book Return
	["If you skipped {quest:91775}, grind here to level 8.39 to stay on the route's plan."] = "",

	-- Step 42: Class trainer
	["Class trainer"] = "",

	-- Step 43: Shaman trainer
	["Shaman trainer"] = "",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "",

	-- Step 44: Druid trainer
	["Druid trainer"] = "",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "",

	-- Step 45: Jason Mathers
	-- {area:87} Goldshire · {npc:383} Jason Mathers
	["Head east out of {area:87} along the lake shore. {npc:383} stands on the shore north-east of town."] = "",

	-- Step 46: Crystal Lake: kill these as you meet them
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "Los múrlocs de la orilla este sueltan el kelp. Desolladores: los Lobos grises del bosque recorren el bosque entre el lago y {area:91}; los Merodeadores, más al este, también dan pieles.",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "Hojas de kelp de cristal",

	-- Step 47: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242} y {npc:248248} están al pie de la torre.",

	-- Step 48: The bridge
	["The bridge"] = "El puente",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261} vigila el puente del camino al este; {npc:248265} está justo al otro lado.",

	-- Step 49: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733} y {npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage · {npc:248278} Croaky
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way. Careful: {npc:248278} is a level 11 elite on the murloc shore. Only go for his head with a group or once you're level 10; otherwise leave him: it's optional."] = "",

	-- Step 50: Croaky
	-- {npc:248278} Croaky · {quest:91740} Croaky's Head
	["{npc:248278} is a level 11 elite on the murloc shore south of the bridge: grouping up is encouraged, look for people to do it with. {quest:91740} needs a group of 2. Skip it if you are alone: the route has you grind the XP back. Right-click the head for its quest."] = "",

	-- Step 52: Level 8.85
	["Level 8.85"] = "",
	-- {quest:91740} Croaky's Head
	["If you skipped {quest:91740}, grind here to level 8.85 to stay on the route's plan."] = "",
	-- {npc:118} Prowler
	["grind on {npc:118}"] = "",

	-- Step 54: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "El campamento está al noreste del puente. Los Fajos de madera están alrededor del campamento y en el bosque al norte.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "",

	-- Step 55: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Está junto al río, al noroeste del campamento maderero.",

	-- Step 56: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Los Zahoríes bribones Defias acampan en las orillas de {area:86}; también sueltan los Pañuelos de lino rojo. {object:56} está en el poblado múrloc de la orilla noreste.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Pañuelos de lino rojo",

	-- Step 57: The gnoll camps
	["The gnoll camps"] = "Los campamentos gnoll",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Los gnolls Zarparrío acampan en las colinas al oeste de {area:86}; {quest:91725} están en sus campamentos.",

	-- Step 58: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "Entrada de {quest:76}",

	-- Step 59: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "La mina está al suroeste de los campamentos gnoll. {item:247816} están cerca de la entrada; los Geománticos kóbold ocupan los túneles.",
	["Walk into the mine"] = "Entra en la mina",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "",

	-- Step 60: The Tower of Azora
	["Follow the hills south to the tower."] = "Sigue las colinas hacia el sur hasta la torre.",

	-- Step 61: Guard Thomas
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Follow the road east past the {area:91} to the bridge. Finish the Prowlers and Young Forest Bears around the river south of it."] = "",

	-- Step 63: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "Al noreste del campamento maderero. Los Zahoríes bribones Defias acampan en las orillas del lago.",

	-- Step 64: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "Sigue las colinas hacia el sur hasta la torre, en el camino al oeste.",

	-- Step 65: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["Follow the road west back to {area:87}; {npc:6306} stands on the lake shore before town. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}, inside"] = "",
	-- {npc:240} Marshal Dughan
	["{npc:240}, while William brews"] = "",
	-- {npc:514} Smith Argus · {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["{npc:514}, at the smithy: {npc:1416} in {zone:1453} takes it (02-westfall)"] = "",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes it"] = "",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328}: lo recibe {npc:5497}, en {zone:1453}",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121}: lo recibe {npc:6122}, en {zone:1453}",

	-- Step 67: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "Sigue el camino hacia el norte desde {area:87} hasta {zone:1453}. {npc:5497} está en el Sagrario del Mago, la torre de {object:2101}; te da un frasco para la cascada de {quest:1861}.",

	-- Step 69: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "Sigue el camino hacia el norte desde {area:87} hasta {zone:1453}. {npc:6122} espera en el sótano de {object:2164}, en {object:2101}.",

	-- Step 70: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 71: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Sal de {zone:1453} por la puerta principal. La cascada de {quest:1861} está al suroeste de las puertas, de camino al oeste hacia {zone:1436}: llena {item:7207} al pie de ella.",

	-- Step 72: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Head back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Regresa por {area:87} y hacia el este por el camino hasta {area:62}. {npc:881} (nivel 9) está junto a la granja.",

	-- Step 73: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "Vuelve con {npc:6122} el Vinculaoscuro. Usa el {item:6928} en el círculo de invocación del sótano de {object:2164} y derrota al abisario que aparece.",
	["Subdue the voidwalker"] = "Somete al abisario",

	-- Step 74: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "",

	-- Step 75: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507} está con los instructores de {area:87}. Cada una de sus misiones te da una {item:15908}: úsala en la bestia que te indique y devuélvele la vara. Los Jabalíes Ocultorroca y los Osos del bosque jóvenes recorren las colinas al sur de {area:64}; los Lobos grises del bosque, el bosque al este de {area:18}.",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524}: domestícalo con la {item:15908}",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922}: domestícalo con la {item:15908}",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822}: domestícalo con la {item:15908}",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, a su lado: {spell:5149}",

	-- Step 76: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "Al sur por el camino hasta {area:64}.",

	-- Step 77: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["{npc:894} sells the Shiny Red Apples for the {quest:91736}. Apples looted from kobolds and crates count too: the purchase ticks itself once you have four."] = "",
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "Manzanas rojas lustrosas, de {npc:894}, para {quest:91736}",

	-- Step 78: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack · {npc:955} Sergeant De Vries
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["The {quest:91736} stands north of the {area:120}. Click it with four Shiny Red Apples in your bags: it takes them and gives you a {item:247824} on the spot (the quest never shows in your quest log). Keep the Applejack for {npc:955}: don't drink it."] = "",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}, del alambique",

	-- Step 79: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries · {quest:91738} An Apple Treat · {item:247824} Thunder Applejack
	["Follow the road south to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks; {npc:955} stands inside. He has {quest:91738} only while you carry the {item:247824}: talk to him and it goes straight to the hand-in."] = "",
	-- {npc:963} Deputy Rainer · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:963}: for {npc:234} at {area:108}"] = "{npc:963}: para {npc:234} en {area:108}",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}; inside"] = "",

	-- Step 80: Forest's Edge
	-- {zone:1436} Westfall
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border."] = "",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "Bandas gnoll pintadas",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "Vuelve al sur hasta {area:120}, junto al camino a {zone:1436}. {npc:963} está fuera del cuartel, con {npc:955} a su lado.",
	-- ["Back to the Cathedral of Light."] = "Vuelve a la Catedral de la Luz.",
	-- ["Bait ingredients"] = "Ingredientes del cebo",
	-- ["Boar meat"] = "Carne de jabalí",
	-- ["Follow the road east past the {area:91} to the bridge."] = "Sigue el camino hacia el este pasando {area:91} hasta el puente.",
	-- ["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "Sigue el camino hacia el norte desde {area:87} hasta {zone:1453}. {npc:6171} y {npc:6173} están en la Catedral de la Luz; {npc:6174} está en {object:2100} y pide diez {item:2589} (lo sueltan los humanoides; se vende en la casa de subastas).",
	-- ["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "Sigue el camino hacia el sur, fuera del valle, hasta {area:87}. {npc:295} está en la Posada Orgullo de León; {npc:240}, frente a la herrería al otro lado del camino; {npc:253}, delante de la posada; y {npc:241}, junto al camino al sur de ella.",
	-- ["Follow the road west back to {area:87}."] = "Sigue el camino hacia el oeste de vuelta a {area:87}.",
	-- ["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "Sigue el camino hacia el oeste de vuelta a {area:87}; {npc:6306} y Jason están en la orilla del lago antes del pueblo.",
	-- ["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. {npc:523}, the gryphon master, stands on the hill."] = "Sigue el camino hacia el oeste pasando el Cuartel de Arroyoeste hasta {zone:1436} y luego al sur por él hasta {area:108}. {npc:523}, el maestro de grifos, está en la colina.",
	-- ["Follow the road west to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks."] = "Sigue el camino al oeste hasta {area:120}, de camino a {zone:1436}. {npc:963} está fuera de los cuarteles.",
	-- ["From the {quest:2998} he gives you"] = "Del {quest:2998} que te da",
	-- ["Head back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Regresa por {area:87} y al este hasta {area:86}. {npc:6172} yace al sur del lago: usa {item:6866} en él. Los Magos renegados Defias a su alrededor llevan el {item:6846}.",
	-- ["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "Ve al noroeste a través de los campos hasta {quest:91736}, al norte de {area:120}. Échale cuatro Manzanas rojas lustrosas para obtener un {item:247824}.",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "Los Batidores múrloc y los Rondadores ocupan el río al sur del puente. {npc:473}, un Defias, recorre {area:62}, al oeste. Termina con los Merodeadores y los Osos del bosque jóvenes por el camino.",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way. {npc:248278} roams the murloc shore too: right-click the head it drops. {npc:248278} is elite: grouping up is advised."] = "Los Batidores múrloc y los Rondadores ocupan el río al sur del puente. {npc:473}, un Defias, recorre {area:62}, al oeste. Termina con los Merodeadores y los Osos del bosque jóvenes por el camino. {npc:248278} también ronda la orilla de los múrlocs: haz clic derecho en la cabeza que suelta. {npc:248278} es élite: se recomienda ir en grupo.",
	-- ["Murlocs and the Collector"] = "Múrlocs y el Coleccionista",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Vuelve a salir pasando por {area:87} y sigue el camino al este hasta {area:62}. {npc:881} (nivel 9) está junto a la casa de la granja.",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "Vuelve a salir pasando por {area:87} y sigue el camino al este hasta {area:62}. {quest:1688} (nivel 9) está junto a la casa de la granja.",
	-- ["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Vuelve a salir pasando por {area:87} y ve al este hasta {area:86}. {npc:6172} yace al sur del lago: usa el {item:6866} en él. Los Zahoríes bribones Defias de alrededor llevan el {item:6846}.",
	-- ["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "Los Jabatos Zarparrío y los Avanzados ocupan las colinas al sur del cuartel, a lo largo de la frontera con {zone:1436}. {npc:100}, un gnoll de nivel 12, anda entre ellos y lleva el {item:1307}: haz clic derecho en él.",
	-- ["She sits inside the farmhouse."] = "Está sentada dentro de la casa de la granja.",
	-- ["Speak with {npc:1430}"] = "Habla con {npc:1430}",
	-- ["Stonetusk Boars graze between the vineyards and the farm."] = "Los Jabalíes colmillopétreo pastan entre los viñedos y la granja.",
	-- ["Summon Voidwalker"] = "Invocar abisario",
	-- ["Tame Beast"] = "Domesticar bestia",
	-- ["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "La granja Pedregosa está al oeste de la mina. La vieja Pedregosa y la \"Tía\" Bernice están junto a la casa.",
	-- ["The murloc camp"] = "El campamento múrloc",
	-- ["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "La {item:247813}, el Hacha empapada y la Caja de herramientas empapada están en el río al sur del puente. {npc:330}, una jabalina enorme, hoza en {area:62}, al oeste del río, con su {npc:390}: aparta primero a los cerditos. Mata Merodeadores y Osos del bosque jóvenes por el camino.",
	-- ["The {skill:356} Traps sit along the west shore of the lake."] = "Las trampas de {skill:356} están en la orilla oeste del lago.",
	-- ["Torn Murloc Fins"] = "Aletas de múrloc rotas",
	-- ["Use the {item:6866} on {npc:6172}"] = "Usa el {item:6866} en {npc:6172}",
	-- ["{area:18} and the wolves"] = "{area:18} y los lobos",
	-- ["{area:57}'s mouth"] = "Entrada de {area:57}",
	-- ["{item:1006}: Princess"] = "{item:1006}: Princesa",
	-- ["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Zahoríes bribones Defias",
	-- ["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430} cocina en la cocina de la posada.",
	-- ["{npc:247229}, in the library"] = "{npc:247229}, en la biblioteca",
	-- ["{npc:248277} keeps watch at {area:798}, east of the murloc shore. Then head north-west back to the bridge."] = "{npc:248277} vigila en {area:798}, al este de la orilla de los múrlocs. Después vuelve al noroeste, hasta el puente.",
	-- ["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415} está detrás de la abadía, junto a los establos.",
	-- ["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377}: {npc:376}, en {zone:1453}, recibe ambos",
	-- ["{npc:459}: Summon Imp"] = "{npc:459}: Invocar diablillo",
	-- ["{npc:6171}: Redemption"] = "{npc:6171}: Redención",
	-- ["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306}: solo desolladores, las pieles se desuellan",
	-- ["{npc:911}, the warrior trainer"] = "{npc:911}, el instructor de guerreros",
	-- ["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927}: lo recibe {npc:6171}, en {zone:1453}",
	-- ["{npc:955}: he wants your {item:247824}"] = "{npc:955}: quiere tu {item:247824}",
	-- ["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "{object:694855} crece en los campos alrededor de los viñedos y de la granja Pedregosa; los Jabalíes colmillopétreo de alrededor dan la sangre.",
}
