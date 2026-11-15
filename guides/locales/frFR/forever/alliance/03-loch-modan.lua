-- French (frFR): the guide forever/alliance/03-loch-modan (forever/alliance/03-loch-modan.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",
	-- {area:442} Auberdine
	["Sell and repair in {area:442} first: the next stretch is a long one."] = "Vendez et réparez d'abord à {area:442} : la suite est longue.",

	-- Step 2: Menethil Harbor
	-- {zone:1437} Wetlands · {zone:1440} Ashenvale · {zone:1442} Stonetalon Mountains
	["Off the boat, walk up the pier to the flight master by the inn. Nothing to take here yet: Menethil's quests are for your {zone:1437} visit, after {zone:1440} and the {zone:1442}."] = "En descendant du bateau, remontez la jetée jusqu'au maître de vol près de l'auberge. Rien à prendre ici pour l'instant : les quêtes de Menethil sont pour votre passage dans les {zone:1437}, après {zone:1440} et les {zone:1442}.",

	-- Step 3: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "Vers le {zone:1432}",
	-- {area:836} Dun Algaz · {zone:1437} Wetlands
	["Follow the road east out of Menethil and south through the {area:836} pass. Keep to the road: the {zone:1437} crocolisks and raptors beside it are over your level."] = "Suivez la route vers l'est en sortant de Menethil, puis au sud par le col de {area:836}. Restez sur la route : les crocilisques et les raptors des {zone:1437} qui la bordent sont au-dessus de votre niveau.",

	-- Step 4: Algaz Station
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	["{npc:1343} stands at the {area:925}, at the south end of the pass."] = "{npc:1343} se tient à {area:925}, à l'extrémité sud du col.",

	-- Step 5: Mountaineer Stormpike
	-- {npc:1343} Mountaineer Stormpike · {npc:1416} Grimand Elmore
	["{npc:1343}: {npc:1416}'s package"] = "{npc:1343} : le colis de {npc:1416}",

	-- Step 6: Silver Stream Mine
	["East along the hills to the mine: the Miners' League crates sit in its tunnels among the Tunnel Rat kobolds."] = "À l'est le long des collines jusqu'à la mine : les caisses de la Ligue des mineurs se trouvent dans ses tunnels, parmi les kobolds Rat des tunnels.",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates; below ground"] = "{item:2640}, dans les caisses ; sous terre",

	-- Step 7: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "Retour à {area:925}",

	-- Step 8: Stonewrought Dam
	["Chief Engineer Hinderweir stands on top of the dam, up the ramp at its west end."] = "L'ingénieur en chef Hinderweir se tient au sommet du barrage, en haut de la rampe à son extrémité ouest.",

	-- Step 9: The Suspicious Barrel
	-- {object:257} Suspicious Barrel
	["The {object:257}"] = "{object:257}",
	-- plural, as words: Dark Iron Sappers = {npc:1222} Dark Iron Sapper
	["Walk east along the dam, down its eastern ramp, then back west along the foot of the dam on the land side: two Dark Iron Sappers guard the barrel. Kill them, then open the barrel: it ends this quest and starts the next."] = "Marchez vers l'est sur le barrage, descendez sa rampe est, puis revenez vers l'ouest au pied du barrage, côté terre : deux Sapeurs Sombrefer gardent le tonneau. Tuez-les, puis ouvrez le tonneau : cela termine cette quête et lance la suivante.",

	-- Step 11: The loch
	["The loch"] = "Le loch",
	-- {object:665289} Discarded Fishing Toolbox · {area:144} Thelsamar · {item:278051} Monogrammed Silver Hair Clip
	["South along the west shore. The {object:665289} lies on the loch bed at one of several places: east of {area:144} (48.1,39.7), a little south-west of there (45.7,43.4), or at the south end of the loch (48.7,54.4 or 50.6,53.3). If it isn't at the arrow, try the next place. Click it for the quest; the {item:278051} comes with it."] = "Au sud le long de la rive ouest. {object:665289} repose au fond du loch à l'un de plusieurs endroits : à l'est de {area:144} (48.1,39.7), un peu au sud-ouest de là (45.7,43.4), ou à l'extrémité sud du loch (48.7,54.4 ou 50.6,53.3). S'il n'est pas à la flèche, essayez l'endroit suivant. Cliquez dessus pour la quête ; {item:278051} vient avec.",
	-- {object:665289} Discarded Fishing Toolbox
	["{object:665289}; underwater"] = "{object:665289} ; sous l'eau",

	-- Step 12: Thelsamar
	-- {npc:1684} Khara Deepwater · {npc:1105} Jern Hornhelm
	["{npc:1684} stands on the shore north-east of town, {npc:1105} by the inn."] = "{npc:1684} se tient sur le rivage au nord-est de la ville, {npc:1105} près de l'auberge.",

	-- Step 13: Ironband's Excavation
	-- {npc:1345} Magmar Fellhew · {npc:1344} Prospector Ironband
	["Round the south end of the loch and head east to the dig. {npc:1345} and {npc:1344} stand together at its west edge."] = "Contournez l'extrémité sud du loch et allez à l'est jusqu'au chantier de fouilles. {npc:1345} et {npc:1344} se tiennent ensemble à sa lisière ouest.",

	-- Step 14: The dig site
	["The dig site"] = "Le chantier de fouilles",
	-- {item:2636} Carved Stone Idol · {quest:86613} Excavation Tools
	-- plural, as words: Stonesplinter Diggers = {npc:1167} Stonesplinter Digger · Berserk Troggs = {npc:1393} Berserk Trogg
	["Stonesplinter Diggers, Geomancers and Berserk Troggs hold the dig east of Ironband; any of them can drop a {item:2636}. Piles of Excavation Tools lie around the dig: open one and right-click the tools to start {quest:86613}, then gather six.\nCareful: Berserk Troggs (19-20) enrage below 40% health."] = "Des Excavateurs Brisepierre, des Géomanciens Brisepierre et des Troggs berserkers tiennent le chantier de fouilles à l'est d'Ironband ; chacun peut lâcher une {item:2636}. Des tas d'outils d'excavation traînent autour du chantier : ouvrez-en un et faites un clic droit sur les outils pour lancer {quest:86613}, puis ramassez-en six.\nAttention : les Troggs berserkers (19-20) deviennent enragés sous 40 % de vie.",
	-- {quest:86613} Excavation Tools
	["{quest:86613}: open a pile at the dig"] = "{quest:86613} : ouvrez un tas sur le chantier",
	-- {quest:86613} Excavation Tools
	["Right-click the {quest:86613}"] = "Faites un clic droit sur {quest:86613}",

	-- Step 16: The Farstrider Lodge
	-- {npc:1154} Marek Ironheart · {npc:1187} Daryl the Youngling
	["North-east to the lodge on the hill. {npc:1154} stands inside, {npc:1187} outside."] = "Au nord-est jusqu'au pavillon sur la colline. {npc:1154} se tient à l'intérieur, {npc:1187} dehors.",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}, inside"] = "{npc:1154}, à l'intérieur",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}: the loch crocolisks below the lodge"] = "{npc:1154} : les crocilisques du loch sous le pavillon",
	-- {npc:1187} Daryl the Youngling
	["{npc:1187}: 15 minutes"] = "{npc:1187} : 15 minutes",

	-- Step 17: Mountain Buzzards
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards"] = "Busards des montagnes",
	-- {quest:257} A Hunter's Boast
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards circle the hills west and south of the lodge, back toward the dig. {quest:257} runs for 15 minutes."] = "Des Busards des montagnes tournoient au-dessus des collines à l'ouest et au sud du pavillon, en direction du chantier de fouilles. {quest:257} dure 15 minutes.",

	-- Step 18: Daryl the Youngling
	["12 minutes"] = "12 minutes",

	-- Step 19: Elder Mountain Boars
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["Elder Mountain Boars"] = "Sangliers des montagnes âgés",
	-- {quest:258} A Hunter's Challenge
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["The Elder Mountain Boars roam the hills north-west of the lodge, along the east shore. {quest:258} runs for 12 minutes: kill five and go straight back to Daryl; the crocolisks come after."] = "Les Sangliers des montagnes âgés parcourent les collines au nord-ouest du pavillon, le long de la rive est. {quest:258} dure 12 minutes : tuez-en cinq et retournez directement voir Daryl ; les crocilisques viennent après.",

	-- Step 21: Daggerfang and the loch crocolisks
	-- {npc:270693} Daggerfang
	["{npc:270693} and the loch crocolisks"] = "{npc:270693} et les crocilisques du loch",
	-- {npc:270693} Daggerfang
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["Back down to the east shore below the boars' hills: {npc:270693}, a crocolisk, patrols it among the Loch Crocolisks."] = "Redescendez sur la rive est, sous les collines des sangliers : {npc:270693}, un crocilisque, y patrouille parmi les Crocilisques du loch.",
	-- {item:2924} Crocolisk Meat
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["{item:2924}: Loch Crocolisks"] = "{item:2924} : Crocilisques du loch",

	-- Step 23: Thelsamar
	-- {area:144} Thelsamar · {npc:1105} Jern Hornhelm · {npc:1572} Thorgrum Borrelson
	["Back west along the south shore to {area:144}: {npc:1105} by the inn, then {npc:1572} with the gryphons on the west side of town, on the way south."] = "Retournez à l'ouest le long de la rive sud jusqu'à {area:144} : {npc:1105} près de l'auberge, puis {npc:1572} avec les griffons dans la partie ouest de la ville, sur le chemin du sud.",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}"] = "Pour {npc:1356} à {zone:1455}",

	-- Step 24: Mountaineer Ylva
	-- {npc:269185} Headsplitter · {zone:1418} Badlands
	-- plural, as words: Stonevault Cave Hunters = {npc:4856} Stonevault Cave Hunter
	["South of Thelsamar, Ylva lies dead in the mouth of a trogg cave. Take her banner, raise it beside her and hold the spot: troggs come in waves from both sides, then {npc:269185}.\nCareful: Stonevault Cave Hunters (36, elite) hold the pass just south of Ylva, toward the {zone:1418}: stay by the banner and don't chase troggs south."] = "Au sud de Thelsamar, Ylva gît morte à l'entrée d'une grotte de troggs. Prenez sa bannière, plantez-la à côté d'elle et tenez la position : les troggs arrivent par vagues des deux côtés, puis {npc:269185}.\nAttention : des Chasseurs des cavernes Cavepierre (36, élites) tiennent le col juste au sud d'Ylva, en direction des {zone:1418} : restez près de la bannière et ne poursuivez pas les troggs vers le sud.",

	-- Step 25: The tunnel post
	["The tunnel post"] = "Le poste du tunnel",
	-- {zone:1426} Dun Morogh
	["West to the dwarven post at the tunnel to {zone:1426}."] = "À l'ouest jusqu'au poste nain, au tunnel qui mène à {zone:1426}.",

	-- Step 26: Captain Rugelfuss
	-- {npc:1092} Captain Rugelfuss
	["{npc:1092} is inside the bunker at the tunnel post: go in by its door on the south-east side."] = "{npc:1092} est dans le bunker du poste du tunnel : entrez par sa porte, côté sud-est.",
	-- {npc:1092} Captain Rugelfuss
	["{npc:1092}, inside"] = "{npc:1092}, à l'intérieur",

	-- Step 27: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Volez jusqu'à {area:1537}",
	-- {area:1537} Ironforge · {area:144} Thelsamar · {zone:1426} Dun Morogh
	["You have the {area:1537} flight path: back north to {area:144}'s gryphons, quicker than walking through the tunnel and across {zone:1426}."] = "Vous avez la route aérienne de {area:1537} : retournez au nord jusqu'aux griffons de {area:144}, c'est plus rapide que de traverser le tunnel puis {zone:1426} à pied.",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maître de vol de {area:144}",

	-- Step 28: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "Vers {zone:1426}",
	-- {zone:1455} Ironforge · {area:144} Thelsamar
	["Through the South Gate tunnel and west along the road to {zone:1455}. Know the {zone:1455} flight path already? Fly from {area:144} instead: these two waypoints drop once you are in the city."] = "Traversez le tunnel de la porte Sud, puis suivez la route vers l'ouest jusqu'à {zone:1455}. Vous connaissez déjà la route aérienne de {zone:1455} ? Prenez plutôt le griffon à {area:144} : ces deux étapes disparaissent dès que vous êtes en ville.",

	-- Step 29: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "Vers {zone:1455}",

	-- Step 30: Ironforge
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge · {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers · {object:171524} Tinker Town
	["{npc:1573} keeps the gryphons in the {object:32372}; {npc:1356} is in the {object:32356}, north-east of it, on the way to the tram in {object:171524}."] = "{npc:1573} s'occupe des griffons à {object:32372} ; {npc:1356} est à {object:32356}, au nord-est, sur le chemin du tram à {object:171524}.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, à {object:32372}",

	-- Step 31: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Tram pour {zone:1453}",

	-- Step 32: Elwynn Forest
	-- {zone:1453} Stormwind · {area:87} Goldshire
	["From the tram, leave {zone:1453} by the main gate and follow the road through {area:87} and east through Elwynn to Redridge."] = "Depuis le tram, quittez {zone:1453} par la porte principale et suivez la route par {area:87}, puis vers l'est à travers la forêt d'Elwynn jusqu'aux Carmines.",
	["The road east to Redridge"] = "La route de l'est vers les Carmines",

	-- Step 33: Henze Faulk
	-- {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["From the bridge, head north to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Depuis le pont, allez au nord jusqu'au {area:86}. {npc:6172} gît au sud du lac : utilisez le {item:6866} sur lui. Les Sorciers-voleurs défias autour de lui portent le {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Utilisez le {item:6866} sur {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846} : Sorciers-voleurs défias",

	-- Step 34: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker
	["The road crosses into Redridge at {area:1002}. {npc:464} walks around the crossroads."] = "La route entre dans les Carmines à {area:1002}. {npc:464} se promène autour du carrefour.",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "{npc:464} se promène autour de {area:1002} : cherchez dans le cercle sur la carte",

	-- Step 35: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} stands by the road next to her."] = "Suivez la route le long de la rive sud du {area:68} jusqu'à la maîtresse des griffons. {npc:1070} se tient au bord de la route, à côté d'elle.",

	-- Step 36: Lakeshire
	-- {npc:8965} Shawn · {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:415} Verner Osgood · {npc:344} Magistrate Solomon · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:379} Darcy · {npc:343} Chef Breanna
	["Cross the long bridge north into town: {npc:8965} and {npc:8962} play by the shore at its north end, {npc:341} stands there too, {npc:415} by the smithy, {npc:344} in the town hall, {npc:381} on the docks, {npc:266} upstairs in the inn and {npc:379} and {npc:343} inside it."] = "Traversez le long pont vers le nord pour entrer en ville : {npc:8965} et {npc:8962} jouent sur la rive, à son extrémité nord, {npc:341} s'y tient aussi, {npc:415} près de la forge, {npc:344} dans l'hôtel de ville, {npc:381} sur les quais, {npc:266} à l'étage de l'auberge et {npc:379} et {npc:343} à l'intérieur.",
	-- {npc:415} Verner Osgood · {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:415}: for {npc:514} in {area:87}"] = "{npc:415} : pour {npc:514} à {area:87}",
	-- {npc:344} Magistrate Solomon · {npc:466} General Marcus Jonathan · {zone:1453} Stormwind
	["{npc:344}, in the town hall: for {npc:466} in {zone:1453}"] = "{npc:344}, dans l'hôtel de ville : pour {npc:466} à {zone:1453}",
	-- {npc:266} Wiley the Black
	["{npc:266}, in the inn; upstairs"] = "{npc:266}, dans l'auberge ; à l'étage",
	-- {npc:379} Darcy
	["{npc:379}, inside"] = "{npc:379}, à l'intérieur",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "{npc:343}, à l'intérieur",

	-- Step 37: Guard Parker
	-- {area:1002} Three Corners
	["West along the road to {area:1002} first; the gnolls are on the way back east."] = "D'abord à l'ouest par la route jusqu'à {area:1002} ; les gnolls sont sur le chemin du retour vers l'est.",

	-- Step 38: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "{area:1001} : tuez-les au passage",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Great Goretusks = {npc:547} Great Goretusk · Dire Condors = {npc:428} Dire Condor
	["Redridge Mongrels and Thrashers hold the hills east of {area:1002}, north of the road; Poachers camp south of the road. Great Goretusks root around the same hills and Dire Condors circle south of the lake; Tarantulas crawl round {area:1002}."] = "Des Bâtards des Carmines et des Vandales des Carmines tiennent les collines à l'est de {area:1002}, au nord de la route ; des Braconniers campent au sud de la route. Des Grands Broche-tripes parcourent les mêmes collines et des Condors redoutables tournoient au sud du lac ; des Tarentules rampent autour de {area:1002}.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911} : Vandales des Carmines",
	-- {item:1081} Crisp Spider Meat
	["{item:1081}: Tarantulas"] = "{item:1081} : Tarentules",

	-- Step 39: Deputy Feldon
	-- {npc:1070} Deputy Feldon
	["East along the road to the gryphon master; {npc:1070} stands beside her."] = "À l'est par la route jusqu'à la maîtresse des griffons ; {npc:1070} se tient à côté d'elle.",

	-- Step 40: Sunken Chest
	-- {area:68} Lake Everstill · {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Back toward town, swim east from the bridge into {area:68}; the chest lies on the lake bed beside a sunken boat. Murloc Flesheaters and Tidecallers line the south shore around it: any of them can carry a {item:1467}."] = "En revenant vers la ville, nagez vers l'est depuis le pont dans le {area:68} ; le coffre repose au fond du lac à côté d'une barque coulée. Des Dévoreurs murlocs et des Mande-flots murlocs bordent la rive sud autour : n'importe lequel peut porter un {item:1467}.",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "{item:1309} ; sous l'eau",

	-- Step 41: Hilary's Necklace
	-- {object:154357} Glinting Mud
	["Then west under the bridge: a {object:154357} mound on the lake bed beside town holds the necklace. Only one mound shows at a time, anywhere from under the dock to past the bridge."] = "Puis à l'ouest sous le pont : un monticule de {object:154357} au fond du lac, près de la ville, contient le collier. Un seul monticule apparaît à la fois, n'importe où entre le dessous du quai et l'autre côté du pont.",
	-- {quest:3741} Hilary's Necklace
	["{quest:3741}; underwater"] = "{quest:3741} ; sous l'eau",

	-- Step 42: Lakeshire
	-- {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren · {npc:342} Martie Jainrose · {npc:379} Darcy · {npc:343} Chef Breanna
	["Through town east to west: {npc:8962} and {npc:341} at the north end of the bridge, {npc:381} on the docks, then {npc:342}'s garden at the west end; {npc:379} and {npc:343} are in the inn."] = "À travers la ville d'est en ouest : {npc:8962} et {npc:341} à l'extrémité nord du pont, {npc:381} sur les quais, puis le jardin de {npc:342} à l'extrémité ouest ; {npc:379} et {npc:343} sont dans l'auberge.",
	-- {zone:1436} Westfall
	["Its pikes and rivets come from the gnolls north of the lake, on the loop after {zone:1436}"] = "Ses piques et ses rivets viennent des gnolls au nord du lac, sur la boucle après {zone:1436}",

	-- Step 43: Dockmaster Baren
	-- {npc:381} Dockmaster Baren · {quest:150} Murloc Poachers · {area:69} Lakeshire
	["From level 20 {npc:381} gives {quest:150}: take it now if he offers it (otherwise on the last {area:69} stop). Its murlocs are for your next Redridge visit, at about 24."] = "À partir du niveau 20, {npc:381} donne {quest:150} : prenez-la maintenant s'il la propose (sinon lors du dernier arrêt à {area:69}). Ses murlocs sont pour votre prochaine visite dans les Carmines, vers le niveau 24.",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks"] = "{npc:381}, sur les quais",

	-- Step 44: Goldshire
	-- {area:1002} Three Corners · {area:87} Goldshire
	["West out of Redridge by {area:1002} and along the road through Elwynn to {area:87}."] = "Sortez des Carmines à l'ouest par {area:1002} et suivez la route à travers la forêt d'Elwynn jusqu'à {area:87}.",

	-- Step 45: Smith Argus
	-- {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:514} works at the {area:87} smithy."] = "{npc:514} travaille à la forge de {area:87}.",

	-- Step 46: Stormwind's gate
	-- {zone:1453} Stormwind
	["{zone:1453}'s gate"] = "Porte de {zone:1453}",
	-- {npc:234} Gryan Stoutmantle · {zone:1436} Westfall · {area:87} Goldshire · {zone:1453} Stormwind · {npc:466} General Marcus Jonathan · {object:2096} Trade District · {area:69} Lakeshire
	["No Defias Brotherhood from Wiley (it starts with {npc:234}'s letter in {zone:1436}): skip {zone:1436}. North along the road from {area:87} to {zone:1453}: {npc:466} sits on his horse at the far end of the bridge outside the main gate. Then the gryphons in the {object:2096}, back to {area:69}."] = "Pas de Confrérie défias chez Wiley (elle commence avec la lettre de {npc:234} à {zone:1436}) : passez {zone:1436}. Au nord par la route, de {area:87} jusqu'à {zone:1453} : {npc:466} est à cheval au bout du pont, devant la porte principale. Puis les griffons de {object:2096}, retour à {area:69}.",
	-- {npc:466} General Marcus Jonathan
	["{npc:466}, outside the main gate"] = "{npc:466}, devant la porte principale",

	-- Step 47: Westfall
	-- {zone:1436} Westfall
	["West through Westbrook into {zone:1436}."] = "À l'ouest par Westbrook jusqu'à {zone:1436}.",

	-- Step 48: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Down the road to {area:108}. {npc:234} stands at the top of the stone tower."] = "Descendez la route jusqu'à {area:108}. {npc:234} se tient au sommet de la tour de pierre.",
	-- {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["For {npc:332} in {zone:1453}"] = "Pour {npc:332} à {zone:1453}",

	-- Step 49: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Volez jusqu'à {zone:1453}",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "Maître de vol de {area:108}",

	-- Step 50: Stormwind
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:466} General Marcus Jonathan · {object:2096} Trade District
	["{npc:332} is upstairs in the SI:7 building in {object:2100}: the stairs are hard to see at first. {npc:466} sits on his horse at the far end of the bridge outside the main gate, then back to the gryphons in the {object:2096}."] = "{npc:332} est à l'étage du bâtiment du SI:7 dans {object:2100} : l'escalier est difficile à voir au début. {npc:466} est à cheval au bout du pont, devant la porte principale, puis retour aux griffons de {object:2096}.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7; upstairs"] = "{npc:332}, SI:7 ; à l'étage",

	-- Step 51: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["{npc:234}, at the top of the tower"] = "{npc:234}, au sommet de la tour",

	-- Step 52: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} et les collines des Défias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "Des Éclaireurs défias et des Truands défias arpentent {area:20} ; des Malandrins défias (niveau 17) patrouillent par deux dans les collines au sud et à l'est : séparez-les. L'entrée de {area:1581}, dans la forge, mène à un donjon de groupe.\nAttention : les camps des collines abritent des groupes mêlés de Défias : il est facile d'en attirer plus d'un à la fois si votre niveau est bas.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, dans les caisses autour de {area:20}",

	-- Step 53: The Defias Messenger
	-- {npc:550} Defias Messenger
	["The {npc:550}"] = "Le {npc:550}",
	-- {area:20} Moonbrook · {npc:550} Defias Messenger · {area:113} Gold Coast Quarry · {area:111} Jangolode Mine
	["South along the road to {area:20}. The {npc:550} starts in front of the {area:20} smithy and walks north to the {area:113} and the back of the {area:111}, then back: look along his road. Slow him when he runs at 30% health."] = "Au sud par la route jusqu'à {area:20}. Le {npc:550} part de devant la forge de {area:20} et marche vers le nord jusqu'à {area:113} et le fond de {area:111}, puis revient : cherchez-le le long de son chemin. Ralentissez-le quand il s'enfuit à 30 % de vie.",
	-- {item:1381} A Mysterious Message · {npc:550} Defias Messenger
	["{item:1381}: the {npc:550}"] = "{item:1381} : le {npc:550}",

	-- Step 54: Half Pendant of Aquatic Endurance
	-- {area:113} Gold Coast Quarry · {object:177790} Strange Lockbox
	["Druids on Trial of the Sea Lion: from the {area:113}, west to the shore and north along it. The {object:177790} lies on the sea floor off the coast (about 18,33); then back south along the coast to the lighthouse."] = "Druides en pleine Épreuve du lion de mer : depuis {area:113}, allez à l'ouest jusqu'au rivage, puis au nord en le longeant. Le {object:177790} repose au fond de la mer, au large de la côte (vers 18,33) ; ensuite, redescendez au sud le long de la côte jusqu'au phare.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882} : {object:177790}",

	-- Step 55: Westfall Lighthouse
	-- {area:20} Moonbrook · {npc:392} Captain Grayson · {npc:391} Old Murk-Eye
	["South-west from {area:20} to the lighthouse on the point: {npc:392} waits on its steps. {npc:391} walks the beach and the shallows north-east of it among the murlocs: pull him away from the Oracles."] = "Au sud-ouest de {area:20} jusqu'au phare sur la pointe : {npc:392} attend sur ses marches. {npc:391} parcourt la plage et les hauts-fonds au nord-est parmi les murlocs : éloignez-le des Oracles.",
	-- {item:3636} Scale of Old Murk-Eye · {npc:391} Old Murk-Eye
	["{item:3636}: {npc:391}, on the beach north-east of the lighthouse"] = "{item:3636} : {npc:391}, sur la plage au nord-est du phare",

	-- Step 56: Captain Grayson
	-- {zone:1436} Westfall · {npc:392} Captain Grayson
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Kept five Flasks of Oil from {zone:1436}'s Harvest Watchers? {npc:392} takes them for his lighthouse fire."] = "Vous avez gardé cinq Flasques d'huile des Gardiens des moissons de {zone:1436} ? {npc:392} les prend pour le feu de son phare.",

	-- Step 57: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:467} The Defias Traitor
	["Back north up the road to {area:108}. {npc:467} waits at the foot of the tower ramp; if he is missing, someone is escorting him and he is back within minutes."] = "Remontez la route au nord jusqu'à {area:108}. {npc:467} attend au pied de la rampe de la tour ; s'il n'y est pas, quelqu'un l'escorte et il revient en quelques minutes.",

	-- Step 58: The Defias Traitor
	-- {area:20} Moonbrook
	["Stay with the traitor as he walks south to {area:20}; he does not stop for fights, so clear what follows him. His walk ends at the Defias hideout below {area:20}."] = "Restez avec le traître pendant qu'il marche vers le sud jusqu'à {area:20} ; il ne s'arrête pas pour combattre, alors éliminez ce qui le suit. Sa marche se termine à la cachette des Défias sous {area:20}.",
	-- {npc:467} The Defias Traitor
	["{npc:467}, at the foot of the tower ramp"] = "{npc:467}, au pied de la rampe de la tour",

	-- Step 59: Gryan Stoutmantle
	-- {npc:234} Gryan Stoutmantle · {area:1581} The Deadmines · {npc:639} Edwin VanCleef · {npc:820} Scout Riell · {quest:214} Red Silk Bandanas
	["Back north to {npc:234}. For your {area:1581} run he then sends you after {npc:639}, and {npc:820}, beside him at the top of the tower, wants {quest:214}. Look for a group now if you have none yet."] = "Retournez au nord voir {npc:234}. Pour votre expédition dans {area:1581}, il vous envoie ensuite après {npc:639}, et {npc:820}, à côté de lui au sommet de la tour, demande {quest:214}. Cherchez un groupe maintenant si vous n'en avez pas encore.",
	-- {npc:820} Scout Riell
	["{npc:820}, at the top of the tower"] = "{npc:820}, au sommet de la tour",

	-- Step 60: The Deadmines
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {quest:214} Red Silk Bandanas · {npc:639} Edwin VanCleef · {zone:1453} Stormwind
	["{area:1581} is a dungeon for a group of five, about levels 17 to 24, and a full run takes about an hour. Its door is the mine below {area:20}, where the traitor led you: the portal is at the far end of the mine's tunnels.\nInside: the Defias drop the {quest:214}, and {npc:639} waits on the ship at the end. Open the Unsent Letter he drops: its quest goes to {zone:1453}, where this guide hands it in."] = "{area:1581} est un donjon pour un groupe de cinq, vers les niveaux 17 à 24, et une expédition complète prend environ une heure. Sa porte est la mine sous {area:20}, où le traître vous a mené : le portail se trouve tout au fond des tunnels de la mine.\nÀ l'intérieur : les Défias lâchent les {quest:214}, et {npc:639} attend sur le navire, tout au bout. Ouvrez la Lettre non envoyée qu'il laisse tomber : sa quête mène à {zone:1453}, où ce guide la rend.",
	-- {item:915} Red Silk Bandana
	["{item:915}: the Defias"] = "{item:915} : les Défias",

	-- Step 61: Gryan Stoutmantle
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Out of the mine and north up the road to {area:108}: {npc:234} stands at the top of the tower."] = "Sortez de la mine et remontez la route au nord jusqu'à {area:108} : {npc:234} se tient au sommet de la tour.",

	-- Step 62: Scout Riell
	-- {npc:820} Scout Riell · {area:108} Sentinel Hill
	["{npc:820} keeps watch at the top of the {area:108} tower."] = "{npc:820} monte la garde au sommet de la tour de {area:108}.",

	-- Step 63: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Prendre un vol pour {area:69}",

	-- Step 64: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["Back north to {npc:234} and the gryphons."] = "Retournez au nord voir {npc:234} et les griffons.",

	-- Step 65: Lakeshire
	-- {npc:415} Verner Osgood · {npc:344} Magistrate Solomon
	["From the gryphons, over the bridge into town: {npc:415} by the smithy, {npc:344} in the town hall."] = "Depuis les griffons, traversez le pont pour entrer en ville : {npc:415} près de la forge, {npc:344} dans l'hôtel de ville.",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, dans l'hôtel de ville",

	-- Step 66: Redridge Canyons
	-- {spell:133} Fireball
	-- plural, as words: Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["Redridge Brutes and Mystics hold the hills north and north-west of town; both carry the Iron Pikes and Rivets. Black Dragon Whelps nest in the same hills.\nCareful: The whelps cast {spell:133} from range, and the gnolls run for help at low health."] = "Des Brutes des Carmines et des Mystiques des Carmines tiennent les collines au nord et au nord-ouest de la ville ; les deux portent les Piques en fer et les rivets. Des Dragonnets noirs nichent dans les mêmes collines.\nAttention : les dragonnets lancent {spell:133} à distance, et les gnolls fuient chercher de l'aide quand ils sont blessés.",
	-- {item:1221} Underbelly Whelp Scale
	-- plural, as words: Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["{item:1221}: Black Dragon Whelps"] = "{item:1221} : Dragonnets noirs",

	-- Step 67: Lakeshire
	-- {npc:415} Verner Osgood · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren
	["Back down into town: {npc:415} by the smithy, {npc:341} at the north end of the bridge, {npc:381} on the docks."] = "Redescendez en ville : {npc:415} près de la forge, {npc:341} à l'extrémité nord du pont, {npc:381} sur les quais.",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks: the murlocs are for your next Redridge visit"] = "{npc:381}, sur les quais : les murlocs sont pour votre prochaine visite dans les Carmines",

	-- Step 68: Fly to Stormwind
	-- {area:442} Auberdine · {zone:1439} Darkshore · {zone:1453} Stormwind
	["Back to {area:442} for {zone:1439}'s southern loops: the gryphon to {zone:1453}, then the boat from the harbour. Hearthstone ready (bound in {area:442} since the first {zone:1439} visit)? Use it instead: these steps drop once you are in {zone:1439}."] = "Retour à {area:442} pour les boucles du sud de {zone:1439} : le griffon jusqu'à {zone:1453}, puis le bateau au port. Pierre de foyer disponible (liée à {area:442} depuis votre première visite à {zone:1439}) ? Utilisez-la plutôt : ces étapes disparaissent dès que vous êtes à {zone:1439}.",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "Maître de vol de {area:69}",

	-- Step 70: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:28027} Dwarven District
	["{npc:1646} stands at the east side of {object:2098}, on the way from the {object:28027} to the harbour."] = "{npc:1646} se tient du côté est de {object:2098}, sur le chemin entre {object:28027} et le port.",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646} : la lettre de Thundris, d'{area:442}",
	-- {npc:3649} Thundris Windweaver
	["For {npc:3649}, where the boat lands"] = "Pour {npc:3649}, là où accoste le bateau",

	-- Step 71: Gazin Tenorm
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {object:2098} Cathedral Square
	["{npc:6173} and {npc:6171} are in the Cathedral of Light, on {object:2098}, on the way to the harbour."] = "{npc:6173} et {npc:6171} sont dans la Cathédrale de la Lumière, sur {object:2098}, sur le chemin du port.",
	["Cathedral of Light"] = "Cathédrale de la Lumière",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171} : Rédemption",

	-- Step 72: Class trainer
	["Class trainer"] = "Maître de classe",
	-- {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Train on the way to the harbour: {object:2100} (Warriors, Rogues), the Cathedral of Light (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters)."] = "Entraînez-vous en chemin vers le port : {object:2100} (Guerriers, Voleurs), la Cathédrale de la Lumière (Paladins, Prêtres), {object:2101} (Mages, Démonistes), {object:28027} (Chasseurs).",

	-- Step 73: Baros Alexston
	-- {npc:1646} Baros Alexston · {quest:389} Bazil Thredd · {area:717} Stockade
	["{npc:1646}, the city architect, is on your way west to the harbour. His next errand, {quest:389}, leads into the {area:717}: it is for a {area:717} run at about 29, so leave it unless you chose that dungeon."] = "{npc:1646}, l'architecte de la ville, se trouve sur votre chemin vers le port, à l'ouest. Sa mission suivante, {quest:389}, mène dans {area:717} : elle est faite pour une expédition dans {area:717} vers le niveau 29, alors laissez-la, sauf si vous avez choisi ce donjon.",

	-- Step 74: Baros Alexston
	-- {area:717} Stockade · {zone:1453} Stormwind
	["For your {area:717} run, later in {zone:1453}: keep it until then."] = "Pour votre expédition dans {area:717}, plus tard à {zone:1453} : gardez-la jusque-là.",
	-- {npc:1646} Baros Alexston · {npc:1719} Warden Thelwater · {area:717} Stockade
	["{npc:1646}: for {npc:1719}, at the {area:717}'s gate"] = "{npc:1646} : pour {npc:1719}, à l'entrée de {area:717}",
}
