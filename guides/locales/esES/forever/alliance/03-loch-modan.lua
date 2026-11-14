-- Spanish (Spain) (esES): the guide forever/alliance/03-loch-modan (forever/alliance/03-loch-modan.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Barco a {area:150}",
	-- {area:442} Auberdine
	["Sell and repair in {area:442} first: the next stretch is a long one."] = "",

	-- Step 2: Menethil Harbor
	-- {zone:1437} Wetlands · {zone:1440} Ashenvale · {zone:1442} Stonetalon Mountains
	["Off the boat, walk up the pier to the flight master by the inn. Nothing to take here yet: Menethil's quests are for your {zone:1437} visit, after {zone:1440} and the {zone:1442}."] = "",

	-- Step 3: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "",
	-- {area:836} Dun Algaz · {zone:1437} Wetlands
	["Follow the road east out of Menethil and south through the {area:836} pass. Keep to the road: the {zone:1437} crocolisks and raptors beside it are over your level."] = "",

	-- Step 4: Algaz Station
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	["{npc:1343} stands at the {area:925}, at the south end of the pass."] = "",

	-- Step 5: Mountaineer Stormpike
	-- {npc:1343} Mountaineer Stormpike · {npc:1416} Grimand Elmore
	["{npc:1343}: {npc:1416}'s package"] = "{npc:1343}: el paquete de {npc:1416}",

	-- Step 6: Silver Stream Mine
	["East along the hills to the mine: the Miners' League crates sit in its tunnels among the Tunnel Rat kobolds."] = "",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates; below ground"] = "",

	-- Step 7: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "",

	-- Step 8: Stonewrought Dam
	["Chief Engineer Hinderweir stands on top of the dam, up the ramp at its west end."] = "",

	-- Step 9: The Suspicious Barrel
	-- {object:257} Suspicious Barrel
	["The {object:257}"] = "",
	-- plural, as words: Dark Iron Sappers = {npc:1222} Dark Iron Sapper
	["Walk east along the dam, down its eastern ramp, then back west along the foot of the dam on the land side: two Dark Iron Sappers guard the barrel. Kill them, then open the barrel: it ends this quest and starts the next."] = "",

	-- Step 11: The loch
	["The loch"] = "",
	-- {object:665289} Discarded Fishing Toolbox · {area:144} Thelsamar · {item:278051} Monogrammed Silver Hair Clip
	["South along the west shore. The {object:665289} lies on the loch bed at one of several places: east of {area:144} (48.1,39.7), a little south-west of there (45.7,43.4), or at the south end of the loch (48.7,54.4 or 50.6,53.3). If it isn't at the arrow, try the next place. Click it for the quest; the {item:278051} comes with it."] = "",
	-- {object:665289} Discarded Fishing Toolbox
	["{object:665289}; underwater"] = "",

	-- Step 12: Thelsamar
	-- {npc:1684} Khara Deepwater · {npc:1105} Jern Hornhelm
	["{npc:1684} stands on the shore north-east of town, {npc:1105} by the inn."] = "",

	-- Step 13: Ironband's Excavation
	-- {npc:1345} Magmar Fellhew · {npc:1344} Prospector Ironband
	["Round the south end of the loch and head east to the dig. {npc:1345} and {npc:1344} stand together at its west edge."] = "",

	-- Step 14: The dig site
	["The dig site"] = "",
	-- {item:2636} Carved Stone Idol · {quest:86613} Excavation Tools
	-- plural, as words: Stonesplinter Diggers = {npc:1167} Stonesplinter Digger · Berserk Troggs = {npc:1393} Berserk Trogg
	["Stonesplinter Diggers, Geomancers and Berserk Troggs hold the dig east of Ironband; any of them can drop a {item:2636}. Piles of Excavation Tools lie around the dig: open one and right-click the tools to start {quest:86613}, then gather six.\nCareful: Berserk Troggs (19-20) enrage below 40% health."] = "",
	-- {quest:86613} Excavation Tools
	["{quest:86613}: open a pile at the dig"] = "",
	-- {quest:86613} Excavation Tools
	["Right-click the {quest:86613}"] = "",

	-- Step 16: The Farstrider Lodge
	-- {npc:1154} Marek Ironheart · {npc:1187} Daryl the Youngling
	["North-east to the lodge on the hill. {npc:1154} stands inside, {npc:1187} outside."] = "",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}, inside"] = "",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}: the loch crocolisks below the lodge"] = "",
	-- {npc:1187} Daryl the Youngling
	["{npc:1187}: 15 minutes"] = "",

	-- Step 17: Mountain Buzzards
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards"] = "",
	-- {quest:257} A Hunter's Boast
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards circle the hills west and south of the lodge, back toward the dig. {quest:257} runs for 15 minutes."] = "",

	-- Step 18: Daryl the Youngling
	["12 minutes"] = "",

	-- Step 19: Elder Mountain Boars
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["Elder Mountain Boars"] = "Jabalíes monteses ancianos",
	-- {quest:258} A Hunter's Challenge
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["The Elder Mountain Boars roam the hills north-west of the lodge, along the east shore. {quest:258} runs for 12 minutes: kill five and go straight back to Daryl; the crocolisks come after."] = "",

	-- Step 21: Daggerfang and the loch crocolisks
	-- {npc:270693} Daggerfang
	["{npc:270693} and the loch crocolisks"] = "",
	-- {npc:270693} Daggerfang
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["Back down to the east shore below the boars' hills: {npc:270693}, a crocolisk, patrols it among the Loch Crocolisks."] = "Vuelve a bajar a la orilla este, bajo las colinas de los jabalíes: {npc:270693}, un crocolisco, patrulla por ella entre los Crocoliscos del lago.",
	-- {item:2924} Crocolisk Meat
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["{item:2924}: Loch Crocolisks"] = "",

	-- Step 23: Thelsamar
	-- {area:144} Thelsamar · {npc:1105} Jern Hornhelm · {npc:1572} Thorgrum Borrelson
	["Back west along the south shore to {area:144}: {npc:1105} by the inn, then {npc:1572} with the gryphons on the west side of town, on the way south."] = "",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}"] = "",

	-- Step 24: Mountaineer Ylva
	-- {npc:269185} Headsplitter · {zone:1418} Badlands
	-- plural, as words: Stonevault Cave Hunters = {npc:4856} Stonevault Cave Hunter
	["South of Thelsamar, Ylva lies dead in the mouth of a trogg cave. Take her banner, raise it beside her and hold the spot: troggs come in waves from both sides, then {npc:269185}.\nCareful: Stonevault Cave Hunters (36, elite) hold the pass just south of Ylva, toward the {zone:1418}: stay by the banner and don't chase troggs south."] = "",

	-- Step 25: The tunnel post
	["The tunnel post"] = "",
	-- {zone:1426} Dun Morogh
	["West to the dwarven post at the tunnel to {zone:1426}."] = "",

	-- Step 26: Captain Rugelfuss
	-- {npc:1092} Captain Rugelfuss
	["{npc:1092} is inside the bunker at the tunnel post: go in by its door on the south-east side."] = "{npc:1092} está dentro del búnker del puesto del túnel: entra por su puerta del lado sureste.",
	-- {npc:1092} Captain Rugelfuss
	["{npc:1092}, inside"] = "{npc:1092}, dentro",

	-- Step 27: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Vuela a {area:1537}",
	-- {area:1537} Ironforge · {area:144} Thelsamar · {zone:1426} Dun Morogh
	["You have the {area:1537} flight path: back north to {area:144}'s gryphons, quicker than walking through the tunnel and across {zone:1426}."] = "Ya tienes la ruta de vuelo de {area:1537}: vuelve al norte a los grifos de {area:144}, es más rápido que cruzar el túnel y atravesar {zone:1426} a pie.",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Maestro de vuelo de {area:144}",

	-- Step 28: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "",
	-- {zone:1455} Ironforge · {area:144} Thelsamar
	["Through the South Gate tunnel and west along the road to {zone:1455}. Know the {zone:1455} flight path already? Fly from {area:144} instead: these two waypoints drop once you are in the city."] = "Atraviesa el túnel de la Puerta Sur y sigue el camino hacia el oeste hasta {zone:1455}. ¿Ya conoces la ruta de vuelo de {zone:1455}? Entonces vuela desde {area:144}: estos dos puntos de ruta desaparecen en cuanto estés en la ciudad.",

	-- Step 29: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "",

	-- Step 30: Ironforge
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words) · {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers (no name in this language: may be words) · {object:171524} Tinker Town
	["{npc:1573} keeps the gryphons in the {object:32372}; {npc:1356} is in the {object:32356}, north-east of it, on the way to the tram in {object:171524}."] = "",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, en {object:32372}",

	-- Step 31: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",

	-- Step 32: Elwynn Forest
	-- {zone:1453} Stormwind · {area:87} Goldshire
	["From the tram, leave {zone:1453} by the main gate and follow the road through {area:87} and east through Elwynn to Redridge."] = "",
	["The road east to Redridge"] = "",

	-- Step 33: Henze Faulk
	-- {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["From the bridge, head north to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Usa el {item:6866} en {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Zahoríes bribones Defias",

	-- Step 34: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker
	["The road crosses into Redridge at {area:1002}. {npc:464} walks around the crossroads."] = "",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "",

	-- Step 35: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} stands by the road next to her."] = "",

	-- Step 36: Lakeshire
	-- {npc:8965} Shawn · {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:415} Verner Osgood · {npc:344} Magistrate Solomon · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:379} Darcy · {npc:343} Chef Breanna
	["Cross the long bridge north into town: {npc:8965} and {npc:8962} play by the shore at its north end, {npc:341} stands there too, {npc:415} by the smithy, {npc:344} in the town hall, {npc:381} on the docks, {npc:266} upstairs in the inn and {npc:379} and {npc:343} inside it."] = "",
	-- {npc:415} Verner Osgood · {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:415}: for {npc:514} in {area:87}"] = "",
	-- {npc:344} Magistrate Solomon · {npc:466} General Marcus Jonathan · {zone:1453} Stormwind
	["{npc:344}, in the town hall: for {npc:466} in {zone:1453}"] = "",
	-- {npc:266} Wiley the Black
	["{npc:266}, in the inn; upstairs"] = "",
	-- {npc:379} Darcy
	["{npc:379}, inside"] = "",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "",

	-- Step 37: Guard Parker
	-- {area:1002} Three Corners
	["West along the road to {area:1002} first; the gnolls are on the way back east."] = "",

	-- Step 38: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Great Goretusks = {npc:547} Great Goretusk · Dire Condors = {npc:428} Dire Condor
	["Redridge Mongrels and Thrashers hold the hills east of {area:1002}, north of the road; Poachers camp south of the road. Great Goretusks root around the same hills and Dire Condors circle south of the lake; Tarantulas crawl round {area:1002}."] = "",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: Vándalos de Crestagrana",
	-- {item:1081} Crisp Spider Meat
	["{item:1081}: Tarantulas"] = "",

	-- Step 39: Deputy Feldon
	-- {npc:1070} Deputy Feldon
	["East along the road to the gryphon master; {npc:1070} stands beside her."] = "",

	-- Step 40: Sunken Chest
	-- {area:68} Lake Everstill · {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Back toward town, swim east from the bridge into {area:68}; the chest lies on the lake bed beside a sunken boat. Murloc Flesheaters and Tidecallers line the south shore around it: any of them can carry a {item:1467}."] = "",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "",

	-- Step 41: Hilary's Necklace
	-- {object:154357} Glinting Mud
	["Then west under the bridge: a {object:154357} mound on the lake bed beside town holds the necklace. Only one mound shows at a time, anywhere from under the dock to past the bridge."] = "",
	-- {quest:3741} Hilary's Necklace
	["{quest:3741}; underwater"] = "",

	-- Step 42: Lakeshire
	-- {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren · {npc:342} Martie Jainrose · {npc:379} Darcy · {npc:343} Chef Breanna
	["Through town east to west: {npc:8962} and {npc:341} at the north end of the bridge, {npc:381} on the docks, then {npc:342}'s garden at the west end; {npc:379} and {npc:343} are in the inn."] = "",
	-- {zone:1436} Westfall
	["Its pikes and rivets come from the gnolls north of the lake, on the loop after {zone:1436}"] = "",

	-- Step 43: Dockmaster Baren
	-- {npc:381} Dockmaster Baren · {quest:150} Murloc Poachers · {area:69} Lakeshire
	["From level 20 {npc:381} gives {quest:150}: take it now if he offers it (otherwise on the last {area:69} stop). Its murlocs are for your next Redridge visit, at about 24."] = "",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks"] = "",

	-- Step 44: Goldshire
	-- {area:1002} Three Corners · {area:87} Goldshire
	["West out of Redridge by {area:1002} and along the road through Elwynn to {area:87}."] = "",

	-- Step 45: Smith Argus
	-- {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:514} works at the {area:87} smithy."] = "",

	-- Step 46: Stormwind's gate
	-- {zone:1453} Stormwind
	["{zone:1453}'s gate"] = "",
	-- {npc:234} Gryan Stoutmantle · {zone:1436} Westfall · {area:87} Goldshire · {zone:1453} Stormwind · {npc:466} General Marcus Jonathan · {object:2096} Trade District · {area:69} Lakeshire
	["No Defias Brotherhood from Wiley (it starts with {npc:234}'s letter in {zone:1436}): skip {zone:1436}. North along the road from {area:87} to {zone:1453}: {npc:466} sits on his horse at the far end of the bridge outside the main gate. Then the gryphons in the {object:2096}, back to {area:69}."] = "",
	-- {npc:466} General Marcus Jonathan
	["{npc:466}, outside the main gate"] = "",

	-- Step 47: Westfall
	-- {zone:1436} Westfall
	["West through Westbrook into {zone:1436}."] = "",

	-- Step 48: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Down the road to {area:108}. {npc:234} stands at the top of the stone tower."] = "",
	-- {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["For {npc:332} in {zone:1453}"] = "",

	-- Step 49: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "",

	-- Step 50: Stormwind
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:466} General Marcus Jonathan · {object:2096} Trade District
	["{npc:332} is upstairs in the SI:7 building in {object:2100}: the stairs are hard to see at first. {npc:466} sits on his horse at the far end of the bridge outside the main gate, then back to the gryphons in the {object:2096}."] = "",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7; upstairs"] = "",

	-- Step 51: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["{npc:234}, at the top of the tower"] = "",

	-- Step 52: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} y las colinas Defias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, de las cajas alrededor de {area:20}",

	-- Step 53: The Defias Messenger
	-- {npc:550} Defias Messenger
	["The {npc:550}"] = "",
	-- {area:20} Moonbrook · {npc:550} Defias Messenger · {area:113} Gold Coast Quarry · {area:111} Jangolode Mine
	["South along the road to {area:20}. The {npc:550} starts in front of the {area:20} smithy and walks north to the {area:113} and the back of the {area:111}, then back: look along his road. Slow him when he runs at 30% health."] = "",
	-- {item:1381} A Mysterious Message · {npc:550} Defias Messenger
	["{item:1381}: the {npc:550}"] = "",

	-- Step 54: Half Pendant of Aquatic Endurance
	-- {area:113} Gold Coast Quarry · {object:177790} Strange Lockbox
	["Druids on Trial of the Sea Lion: from the {area:113}, west to the shore and north along it. The {object:177790} lies on the sea floor off the coast (about 18,33); then back south along the coast to the lighthouse."] = "Druidas con La prueba del león marino: desde {area:113}, al oeste hasta la orilla y luego al norte por ella. {object:177790} está en el fondo del mar frente a la costa (hacia 18,33); después vuelve al sur por la costa hasta el faro.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "",

	-- Step 55: Westfall Lighthouse
	-- {area:20} Moonbrook · {npc:392} Captain Grayson · {npc:391} Old Murk-Eye
	["South-west from {area:20} to the lighthouse on the point: {npc:392} waits on its steps. {npc:391} walks the beach and the shallows north-east of it among the murlocs: pull him away from the Oracles."] = "",
	-- {item:3636} Scale of Old Murk-Eye · {npc:391} Old Murk-Eye
	["{item:3636}: {npc:391}, on the beach north-east of the lighthouse"] = "",

	-- Step 56: Captain Grayson
	-- {zone:1436} Westfall · {npc:392} Captain Grayson
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Kept five Flasks of Oil from {zone:1436}'s Harvest Watchers? {npc:392} takes them for his lighthouse fire."] = "",

	-- Step 57: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:467} The Defias Traitor
	["Back north up the road to {area:108}. {npc:467} waits at the foot of the tower ramp; if he is missing, someone is escorting him and he is back within minutes."] = "",

	-- Step 58: The Defias Traitor
	-- {area:20} Moonbrook
	["Stay with the traitor as he walks south to {area:20}; he does not stop for fights, so clear what follows him. His walk ends at the Defias hideout below {area:20}."] = "",
	-- {npc:467} The Defias Traitor
	["{npc:467}, at the foot of the tower ramp"] = "",

	-- Step 59: Gryan Stoutmantle
	-- {npc:234} Gryan Stoutmantle · {area:1581} The Deadmines · {npc:639} Edwin VanCleef · {npc:820} Scout Riell · {quest:214} Red Silk Bandanas
	["Back north to {npc:234}. For your {area:1581} run he then sends you after {npc:639}, and {npc:820}, beside him at the top of the tower, wants {quest:214}. Look for a group now if you have none yet."] = "Vuelve al norte con {npc:234}. Para tu incursión en {area:1581}, luego te envía a por {npc:639}, y {npc:820}, a su lado en lo alto de la torre, quiere {quest:214}. Busca grupo ahora si aún no tienes.",
	-- {npc:820} Scout Riell
	["{npc:820}, at the top of the tower"] = "{npc:820}, en lo alto de la torre",

	-- Step 60: The Deadmines
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {quest:214} Red Silk Bandanas · {npc:639} Edwin VanCleef · {zone:1453} Stormwind
	["{area:1581} is a dungeon for a group of five, about levels 17 to 24, and a full run takes about an hour. Its door is the mine below {area:20}, where the traitor led you: the portal is at the far end of the mine's tunnels.\nInside: the Defias drop the {quest:214}, and {npc:639} waits on the ship at the end. Open the Unsent Letter he drops: its quest goes to {zone:1453}, where this guide hands it in."] = "{area:1581} es una mazmorra para un grupo de cinco, de nivel 17 a 24 más o menos, y una incursión completa dura cerca de una hora. Su puerta es la mina bajo {area:20}, adonde te llevó el traidor: el portal está al fondo de los túneles de la mina.\nDentro: los Defias sueltan {quest:214}, y {npc:639} espera en el barco del final. Abre la Carta sin enviar que suelta: su misión va a {zone:1453}, donde esta guía la entrega.",
	-- {item:915} Red Silk Bandana
	["{item:915}: the Defias"] = "{item:915}: los Defias",

	-- Step 61: Gryan Stoutmantle
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Out of the mine and north up the road to {area:108}: {npc:234} stands at the top of the tower."] = "Sal de la mina y sube al norte por el camino hasta {area:108}: {npc:234} está en lo alto de la torre.",

	-- Step 62: Scout Riell
	-- {npc:820} Scout Riell · {area:108} Sentinel Hill
	["{npc:820} keeps watch at the top of the {area:108} tower."] = "{npc:820} vigila desde lo alto de la torre de {area:108}.",

	-- Step 63: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "Vuela a {area:69}",

	-- Step 64: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["Back north to {npc:234} and the gryphons."] = "",

	-- Step 65: Lakeshire
	-- {npc:415} Verner Osgood · {npc:344} Magistrate Solomon
	["From the gryphons, over the bridge into town: {npc:415} by the smithy, {npc:344} in the town hall."] = "",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, en el ayuntamiento",

	-- Step 66: Redridge Canyons
	-- {spell:133} Fireball
	-- plural, as words: Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["Redridge Brutes and Mystics hold the hills north and north-west of town; both carry the Iron Pikes and Rivets. Black Dragon Whelps nest in the same hills.\nCareful: The whelps cast {spell:133} from range, and the gnolls run for help at low health."] = "",
	-- {item:1221} Underbelly Whelp Scale
	-- plural, as words: Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["{item:1221}: Black Dragon Whelps"] = "",

	-- Step 67: Lakeshire
	-- {npc:415} Verner Osgood · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren
	["Back down into town: {npc:415} by the smithy, {npc:341} at the north end of the bridge, {npc:381} on the docks."] = "",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks: the murlocs are for your next Redridge visit"] = "",

	-- Step 68: Fly to Stormwind
	-- {area:442} Auberdine · {zone:1439} Darkshore · {zone:1453} Stormwind
	["Back to {area:442} for {zone:1439}'s southern loops: the gryphon to {zone:1453}, then the boat from the harbour. Hearthstone ready (bound in {area:442} since the first {zone:1439} visit)? Use it instead: these steps drop once you are in {zone:1439}."] = "",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "",

	-- Step 70: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:28027} Dwarven District
	["{npc:1646} stands at the east side of {object:2098}, on the way from the {object:28027} to the harbour."] = "",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: la carta de Thundris desde {area:442}",
	-- {npc:3649} Thundris Windweaver
	["For {npc:3649}, where the boat lands"] = "",

	-- Step 71: Gazin Tenorm
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {object:2098} Cathedral Square
	["{npc:6173} and {npc:6171} are in the Cathedral of Light, on {object:2098}, on the way to the harbour."] = "",
	["Cathedral of Light"] = "",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Redención",

	-- Step 72: Class trainer
	["Class trainer"] = "Instructor de clase",
	-- {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Train on the way to the harbour: {object:2100} (Warriors, Rogues), the Cathedral of Light (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters)."] = "Entrena de camino al puerto: {object:2100} (guerreros, pícaros), la Catedral de la Luz (paladines, sacerdotes), {object:2101} (magos, brujos), {object:28027} (cazadores).",

	-- Step 73: Baros Alexston
	-- {npc:1646} Baros Alexston · {quest:389} Bazil Thredd · {area:717} Stockade
	["{npc:1646}, the city architect, is on your way west to the harbour. His next errand, {quest:389}, leads into the {area:717}: it is for a {area:717} run at about 29, so leave it unless you chose that dungeon."] = "{npc:1646}, el arquitecto de la ciudad, está de camino al puerto, hacia el oeste. Su siguiente encargo, {quest:389}, lleva a {area:717}: es para una incursión en {area:717} hacia el nivel 29, así que déjalo si no has elegido esa mazmorra.",

	-- Step 74: Baros Alexston
	-- {area:717} Stockade · {zone:1453} Stormwind
	["For your {area:717} run, later in {zone:1453}: keep it until then."] = "Para tu incursión en {area:717}, más adelante en {zone:1453}: guárdala hasta entonces.",
	-- {npc:1646} Baros Alexston · {npc:1719} Warden Thelwater · {area:717} Stockade
	["{npc:1646}: for {npc:1719}, at the {area:717}'s gate"] = "{npc:1646}: para {npc:1719}, en la puerta de {area:717}",
}
