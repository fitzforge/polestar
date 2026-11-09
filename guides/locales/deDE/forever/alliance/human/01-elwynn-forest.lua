-- German (deDE): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "Du beginnst vor der Abtei. {npc:823} steht am Fuß der Treppe, {npc:197} drinnen in der Halle, {npc:951} und {npc:247229} in der Bibliothek rechts, {npc:196} draußen an der Nordwestecke.",
	-- {npc:197} Marshal McBride
	["{npc:197}, inside"] = "",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}, vor der Abtei",

	-- Step 2: Wolves
	["Wolves"] = "Wölfe",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "Junge Wölfe und Wilde Waldwölfe streifen über die Felder direkt um die Abtei.",

	-- Step 3: Deputy Willem
	-- {npc:198} Khelden Bremen
	["Mages: {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}, zurück an der Treppe der Abtei",

	-- Step 4: The kobold camp
	["The kobold camp"] = "Das Koboldlager",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "{npc:6} graben in den Weinbergen nordöstlich der Abtei. Ab und zu lässt einer {quest:91741} fallen: Rechtsklicke es.",

	-- Step 5: Northshire Abbey
	["Inside"] = "",
	-- {npc:247229} Daniel
	["{npc:247229}, in the library; inside"] = "",

	-- Step 6: Echo Ridge Mine: kill these as you meet them
	-- {area:34} Echo Ridge Mine
	["{area:34}: kill these as you meet them"] = "",
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "Folge dem Weg nach Norden zur Mine. Davor wimmelt es von Koboldtagelöhnern; jeder Kobold im Tal kann {object:83763} fallen lassen.",

	-- Step 7: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade · {npc:198} Khelden Bremen
	["{npc:248415} stands behind the Abbey, by the stables. {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer; inside"] = "",
	-- {npc:925} Brother Sammuel
	["{npc:925}, the paladin trainer"] = "{npc:925}, der Paladinlehrer",
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415}, by the Abbey"] = "{npc:248415}, bei der Abtei",
	-- {npc:915} Jorik Kerridan
	["{npc:915}, the rogue trainer"] = "{npc:915}, der Schurkenlehrer",
	-- {npc:375} Priestess Anetta
	["{npc:375}, the priest trainer"] = "{npc:375}, die Priesterlehrerin",
	-- {npc:198} Khelden Bremen
	["{npc:198}, the mage trainer, inside the Abbey"] = "{npc:198}, der Magierlehrer, in der Abtei",

	-- Step 8: The Defias camp
	["The Defias camp"] = "Das Lager der Defias",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["Defias Thugs camp in the clearing east of the Abbey and along the valley's east side."] = "Rohlinge der Defias lagern auf der Lichtung östlich der Abtei und entlang der Ostseite des Tals.",
	-- plural, as words: Red Burlap Bandanas = {item:752} Red Burlap Bandana
	["Red Burlap Bandanas"] = "Rote Sackleinenkopftücher",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}: the {object:83763} in the Defias camp"] = "{item:6785}: {object:83763} im Lager der Defias",

	-- Step 9: Deputy Willem
	["She stands by her cart at the vineyard east of the Abbey."] = "Sie steht bei ihrem Karren am Weinberg östlich der Abtei.",

	-- Step 10: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "Die Weinberge und {npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "Die Traubenkisten liegen in den Weinbergen hinter den Defias. {npc:103} wartet bei der Hütte am Ostende des Tals.",

	-- Step 12: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "Sie steht vor dem Mineneingang. {npc:248362} drinnen ist Elite: Eine Gruppe wird empfohlen.",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "In {area:34}",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "Koboldhilfsarbeiter arbeiten in den Tunneln der Mine. {npc:248362} wartet hinter der zweiten Abzweigung rechts.",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80} walks around {area:34}: look inside the circle on the map"] = "",

	-- Step 15: Inside Echo Ridge Mine
	-- {npc:248362} Shinyfinder Narf
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248362} (level 3 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 16: Northshire Abbey
	-- {npc:823} Deputy Willem
	["{npc:823}, at the Abbey steps"] = "",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}, oben",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}, bei den Ställen südlich der Abtei",

	-- Step 17: Northshire Abbey
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "sein Koboldaufspürer zeigt die Kobolde zum Anklicken auf der Straße nach {area:87}",

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
	["The lake shore"] = "Das Seeufer",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399} lagert nordöstlich des Gasthauses; {npc:6306}, {npc:383} und {npc:1651} stehen am Ufer von {area:18} östlich des Ortes.",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "Setz dich (/sit) an sein Lagerfeuer, bis du {spell:1229451} hast",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned; inside"] = "",

	-- Step 24: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "Die Fischfallen stehen am Westufer des Sees.",

	-- Step 26: Crystal Lake: kill these as you meet them
	-- {area:18} Crystal Lake
	["{area:18}: kill these as you meet them"] = "",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "Murlocs und Murlocbachläufer halten das Ostufer; die Schrotthaufen liegen in ihrem Lager.",

	-- Step 28: Goldshire
	-- {npc:1430} Tomas · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:1430} cooks in the inn's kitchen. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:1430} Tomas
	["{npc:1430}: Camping 101 asks you to learn it; below ground"] = "",

	-- Step 29: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "Folge der Straße nach Süden aus {area:87} hinaus zu {area:64}. {npc:251} wartet beim Haus.",

	-- Step 30: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "Er steht am Fluss westlich des Hofs.",

	-- Step 31: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house.\nShe sits inside the farmhouse."] = "",

	-- Step 32: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "Billy spielt in {area:64}, östlich der Mine.",

	-- Step 33: Elwynn Forest: kill these as you meet them
	-- {zone:1429} Elwynn Forest
	["{zone:1429}: kill these as you meet them"] = "",
	-- {object:694855} Overgrown Duskweed
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood.\nStonetusk Boars graze between the vineyards and the farm."] = "",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215}: Steinhauereber",
	["Chunks of Boar Meat"] = "Brocken Eberfleisch",

	-- Step 34: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "Tantchen Bernice Stonefield",

	-- Step 36: Maclure Vineyards: kill these as you meet them
	-- {area:64} Maclure Vineyards
	["{area:64}: kill these as you meet them"] = "",
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "Die Mine liegt westlich der Weinberge. Koboldminenarbeiter und Koboldtunnelgräber füllen beide Ebenen; {npc:248464}, ein Kobold mit Namen, hat das Bilderbuch in den unteren Tunneln. {npc:248464} ist Elite: Eine Gruppe wird empfohlen.",
	["Walk through the mine"] = "Geh durch die Mine",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "Große Kerzen",

	-- Step 37: Maclure Vineyards: kill these as you meet them
	-- {npc:248464} Nimsy
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248464} (level 6 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "Verlorene Bücher: Koboldminenarbeiter und Koboldtunnelgräber",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "Spaß mit Elementaren: {npc:248464}",

	-- Step 38: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87} ist in {area:57}, nicht auf dem Hügel darüber: Geh am Eingang hinein und halte dich links bis zum hinteren Ende der Minensohle; nimm nicht die Treppe nach oben. Banditen der Defias rund um die Weinberge lassen ab und zu {item:1972} fallen: Rechtsklicke sie.",
	-- {item:981} Bernice's Necklace
	["{item:981}; below ground"] = "",

	-- Step 39: Goldshire
	-- {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "{npc:279} in {zone:1453} nimmt sie an (02-westfall)",

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
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "Die Murlocs am Ostufer lassen den Tang fallen. Kürschner: Graue Forstwölfe streifen durch die Wälder zwischen dem See und {area:91}; Streuner weiter östlich liefern ebenfalls Felle.",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "Kristalltangwedel",

	-- Step 47: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242} und {npc:248248} stehen am Fuß des Turms.",

	-- Step 48: The bridge
	["The bridge"] = "Die Brücke",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261} bewacht die Brücke an der Straße nach Osten; {npc:248265} steht direkt auf der anderen Seite.",

	-- Step 49: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733} und {npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage · {npc:248278} Croaky
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way. Careful: {npc:248278} is a level 11 elite on the murloc shore. Only go for his head with a group or once you're level 10; otherwise leave him: it's optional."] = "{item:247813}, die Durchnässte Axt und der Durchnässte Werkzeugkasten liegen im Fluss südlich der Brücke. {npc:330}, ein großer Eber, wühlt in {area:62} westlich des Flusses mit ihrem {npc:390}: Lock zuerst die Ferkel weg. Töte unterwegs Streuner und Junge Waldbären. Vorsicht: {npc:248278} ist ein Elite der Stufe 11 am Murlocufer. Hol dir seinen Kopf nur mit einer Gruppe oder ab Stufe 10; sonst lass ihn in Ruhe: Die Quest ist optional.",

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
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "Das Lager liegt nordöstlich der Brücke. Kleinholzbündel liegen rund um das Lager und in den Wäldern nördlich davon.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "",

	-- Step 55: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Er liegt am Fluss nordwestlich des Holzfällerlagers.",

	-- Step 56: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Abtrünnige Hexer der Defias lagern an den Ufern von {area:86}; sie lassen auch die Roten Leinenkopftücher fallen. {object:56} liegt im Murlocdorf am Nordostufer.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Rote Leinenkopftücher",

	-- Step 57: The gnoll camps
	["The gnoll camps"] = "Die Gnolllager",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Gnolle der Flusspfoten lagern in den Hügeln westlich von {area:86}; {quest:91725} liegen in ihren Lagern.",

	-- Step 58: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "Eingang von {quest:76}",

	-- Step 59: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "Die Mine liegt südwestlich der Gnolllager. {item:247816} liegen nahe dem Eingang; Koboldgeomanten halten die Tunnel.",
	["Walk into the mine"] = "Geh in die Mine",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "",

	-- Step 60: The Tower of Azora
	["Follow the hills south to the tower."] = "Folge den Hügeln nach Süden zum Turm.",

	-- Step 61: Guard Thomas
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Follow the road east past the {area:91} to the bridge. Finish the Prowlers and Young Forest Bears around the river south of it."] = "",

	-- Step 63: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "Nordöstlich des Holzfällerlagers. Abtrünnige Hexer der Defias lagern an den Ufern des Sees.",

	-- Step 64: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "Folge den Hügeln nach Süden zum Turm, an der Straße nach Westen.",

	-- Step 65: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["Follow the road west back to {area:87}; {npc:6306} stands on the lake shore before town. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}, inside"] = "",
	-- {npc:240} Marshal Dughan
	["{npc:240}, while William brews"] = "{npc:240}, während William braut",
	-- {npc:514} Smith Argus · {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["{npc:514}, at the smithy: {npc:1416} in {zone:1453} takes it (02-westfall)"] = "",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes it"] = "",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328}: {npc:5497} in {zone:1453} nimmt sie an",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121}: {npc:6122} in {zone:1453} nimmt sie an",

	-- Step 67: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "Folge der Straße nach Norden von {area:87} nach {zone:1453}. {npc:5497} steht im Magiersanktum, dem Turm in {object:2101}; sie gibt dir eine Flasche für den Wasserfall am {quest:1861}.",

	-- Step 69: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "Folge der Straße nach Norden von {area:87} nach {zone:1453}. {npc:6122} wartet im Keller von {object:2164} in {object:2101}.",

	-- Step 70: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 71: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Verlass {zone:1453} durch das Haupttor. Der Wasserfall am {quest:1861} liegt südwestlich der Tore, auf dem Weg nach Westen nach {zone:1436}: Füll {item:7207} an seinem Fuß.",

	-- Step 72: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Head back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Geh zurück durch {area:87} und östlich entlang der Straße zur {area:62}. {npc:881} (Stufe 9) steht beim Bauernhaus.",

	-- Step 73: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "Zurück zu {npc:6122}. Benutze {item:6928} am Beschwörungskreis im Keller von {object:2164} und besiege den Leerwandler, den er ruft.",
	["Subdue the voidwalker"] = "Bezwinge den Leerwandler",

	-- Step 74: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "",

	-- Step 75: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507} steht bei den Lehrern in {area:87}. Jede ihrer Quests gibt dir {item:15908}: Benutze ihn an dem Wildtier, das sie nennt, und bring den Stab dann zu ihr zurück. Steinhauteber und Junge Waldbären streifen durch die Hügel südlich von {area:64}, Graue Forstwölfe durch die Wälder östlich von {area:18}.",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524}: Zähme ihn mit {item:15908}",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "Zähme {npc:524}",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922}: Zähme ihn mit {item:15908}",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "Zähme {npc:1922}",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822}: Zähme ihn mit {item:15908}",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "Zähme {npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, neben ihr: {spell:5149}",

	-- Step 76: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "Die Straße hinunter nach Süden zu {area:64}.",

	-- Step 77: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["{npc:894} sells the Shiny Red Apples for the {quest:91736}. Apples looted from kobolds and crates count too: the purchase ticks itself once you have four."] = "",
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "Glänzende rote Äpfel von {npc:894} für {quest:91736}",

	-- Step 78: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack · {npc:955} Sergeant De Vries
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["The {quest:91736} stands north of the {area:120}. Click it with four Shiny Red Apples in your bags: it takes them and gives you a {item:247824} on the spot (the quest never shows in your quest log). Keep the Applejack for {npc:955}: don't drink it."] = "",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}, aus dem Brenner",

	-- Step 79: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries · {quest:91738} An Apple Treat · {item:247824} Thunder Applejack
	["Follow the road south to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks; {npc:955} stands inside. He has {quest:91738} only while you carry the {item:247824}: talk to him and it goes straight to the hand-in."] = "",
	-- {npc:963} Deputy Rainer · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:963}: for {npc:234} at {area:108}"] = "{npc:963}: für {npc:234} bei {area:108}",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}; inside"] = "",

	-- Step 80: Forest's Edge
	-- {zone:1436} Westfall
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border."] = "",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "Bemalte Gnollarmbinden",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "Zurück nach Süden zu {area:120}, an der Straße nach {zone:1436}. {npc:963} steht vor der Kaserne, {npc:955} neben ihm.",
	-- ["Back to the Cathedral of Light."] = "Zurück zur Kathedrale des Lichts.",
	-- ["Bait ingredients"] = "Köderzutaten",
	-- ["Boar meat"] = "Eberfleisch",
	-- ["Follow the road east past the {area:91} to the bridge."] = "Folge der Straße nach Osten an {area:91} vorbei zur Brücke.",
	-- ["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "Folge der Straße nach Norden von {area:87} nach {zone:1453}. {npc:6171} und {npc:6173} sind in der Kathedrale des Lichts; {npc:6174} steht in {object:2100} und bittet um zehn {item:2589} (Humanoide lassen ihn fallen; das Auktionshaus verkauft ihn).",
	-- ["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "Folge der Straße nach Süden aus dem Tal nach {area:87}. {npc:295} ist im Gasthaus „Zur Höhle des Löwen“; {npc:240} steht vor der Schmiede auf der anderen Straßenseite, {npc:253} vor dem Gasthaus und {npc:241} an der Straße südlich davon.",
	-- ["Follow the road west back to {area:87}."] = "Folge der Straße nach Westen zurück nach {area:87}.",
	-- ["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "Folge der Straße nach Westen zurück nach {area:87}; {npc:6306} und Jason stehen vor dem Ort am Seeufer.",
	-- ["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. {npc:523}, the gryphon master, stands on the hill."] = "Folge der Straße nach Westen an Weststrom vorbei nach {zone:1436} und dann auf ihr nach Süden nach {area:108}. {npc:523}, der Greifenmeister, steht auf dem Hügel.",
	-- ["Follow the road west to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks."] = "Folge der Straße westlich zur {area:120}, auf dem Weg nach {zone:1436}. {npc:963} steht außerhalb der Kaserne.",
	-- ["From the {quest:2998} he gives you"] = "Aus {quest:2998}, den er dir gibt",
	-- ["Head back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Geh zurück durch {area:87} und nach Osten zu {area:86}. {npc:6172} liegt südlich des Sees: Benutze das {item:6866} auf ihn. Die Defias-Schurkenmagier um ihn herum tragen das {item:6846}.",
	-- ["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "Geh nach Nordwesten über die Felder zu {quest:91736}, nördlich von {area:120}. Leg vier Glänzende rote Äpfel hinein für {item:247824}.",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "Murlocfutterwühler und Murloclauerer säumen den Fluss südlich der Brücke. {npc:473}, ein Defias, streift durch {area:62} westlich davon. Erledige unterwegs die Streuner und Jungen Waldbären.",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way. {npc:248278} roams the murloc shore too: right-click the head it drops. {npc:248278} is elite: grouping up is advised."] = "Murlocfutterwühler und Murloclauerer säumen den Fluss südlich der Brücke. {npc:473}, ein Defias, streift durch {area:62} westlich davon. Erledige unterwegs die Streuner und Jungen Waldbären. Auch {npc:248278} streift am Murlocufer umher: Rechtsklicke den Kopf, den er fallen lässt. {npc:248278} ist ein Elitegegner: Eine Gruppe wird empfohlen.",
	-- ["Murlocs and the Collector"] = "Murlocs und der Sammler",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Reite zurück durch {area:87} und auf der Straße nach Osten zu {area:62}. {npc:881} (Stufe 9) steht bei dem Bauernhaus.",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "Reite zurück durch {area:87} und auf der Straße nach Osten zu {area:62}. {quest:1688} (Stufe 9) steht bei dem Bauernhaus.",
	-- ["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Reite zurück durch {area:87} und nach Osten zu {area:86}. {npc:6172} liegt südlich des Sees: Benutze {item:6866} an ihm. Die Abtrünnigen Hexer der Defias um ihn herum tragen {item:6846} bei sich.",
	-- ["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "Wichte und Kundschafter der Flusspfoten halten die Hügel südlich der Garnison entlang der Grenze zu {zone:1436}. {npc:100}, ein Gnoll der Stufe 12, läuft zwischen ihnen umher und trägt {item:1307} bei sich: Rechtsklicke ihn.",
	-- ["She sits inside the farmhouse."] = "Sie sitzt im Bauernhaus.",
	-- ["Speak with {npc:1430}"] = "Sprich mit {npc:1430}",
	-- ["Stonetusk Boars graze between the vineyards and the farm."] = "Steinhauereber grasen zwischen den Weinbergen und dem Hof.",
	-- ["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "Der Hof der Steinfelds liegt westlich der Mine. Mutter Stonefield und Tantchen Bernice stehen beim Haus.",
	-- ["The murloc camp"] = "Das Murloclager",
	-- ["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "{item:247813}, die Durchnässte Axt und der Durchnässte Werkzeugkasten liegen im Fluss südlich der Brücke. {npc:330}, ein großer Eber, wühlt in {area:62} westlich des Flusses mit ihrem {npc:390}: Lock zuerst die Ferkel weg. Töte unterwegs Streuner und Junge Waldbären.",
	-- ["Torn Murloc Fins"] = "Zerrissene Murlocflossen",
	-- ["Use the {item:6866} on {npc:6172}"] = "Benutze {item:6866} an {npc:6172}",
	-- ["{area:18} and the wolves"] = "{area:18} und die Wölfe",
	-- ["{area:57}'s mouth"] = "Eingang von {area:57}",
	-- ["{item:1006}: Princess"] = "{item:1006}: Prinzessin",
	-- ["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Abtrünnige Hexer der Defias",
	-- ["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430} kocht in der Küche des Gasthauses.",
	-- ["{npc:247229}, in the library"] = "{npc:247229}, in der Bibliothek",
	-- ["{npc:248277} keeps watch at {area:798}, east of the murloc shore. Then head north-west back to the bridge."] = "{npc:248277} hält Wache bei {area:798}, östlich des Murlocufers. Geh danach nach Nordwesten zurück zur Brücke.",
	-- ["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415} steht hinter der Abtei, bei den Ställen.",
	-- ["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377}: {npc:376} in {zone:1453} nimmt beide an",
	-- ["{npc:6171}: Redemption"] = "{npc:6171}: Erlösung",
	-- ["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306}: nur für Kürschner, die Felle werden gehäutet",
	-- ["{npc:911}, the warrior trainer"] = "{npc:911}, der Kriegerlehrer",
	-- ["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927}: {npc:6171} in {zone:1453} nimmt sie an",
	-- ["{npc:955}: he wants your {item:247824}"] = "{npc:955}: Er will deinen {item:247824}",
	-- ["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "{object:694855} wächst auf den Feldern rund um die Weinberge und den Hof der Steinfelds; Steinhauereber in der Umgebung liefern das Blut.",
}
