-- German (deDE): the guide forever/alliance/03-loch-modan (forever/alliance/03-loch-modan.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",
	-- {area:442} Auberdine
	["Sell and repair in {area:442} first: the next stretch is a long one."] = "Verkaufe und repariere zuerst in {area:442}: der nächste Abschnitt ist ein langer.",

	-- Step 2: Menethil Harbor
	-- {zone:1437} Wetlands
	["Off the boat, walk up the pier to the flight master by the inn. Nothing to take here yet: Menethil's quests are for your {zone:1437} visit at about 22."] = "Steig aus dem Boot und geh den Steg hinauf zum Flugmeister beim Gasthaus. Hier gibt es noch nichts zu holen: Menethils Quests sind für deinen {zone:1437}-Besuch bei etwa 22.",

	-- Step 3: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "Nach {zone:1432}",
	-- {area:836} Dun Algaz · {zone:1437} Wetlands
	["Follow the road east out of Menethil and south through the {area:836} pass. Keep to the road: the {zone:1437} crocolisks and raptors beside it are over your level."] = "Folge der Straße östlich aus Menethil und dann südlich durch den Pass von {area:836}. Bleib auf der Straße: Die Krokodile und Raptoren von {zone:1437} daneben sind über deiner Stufe.",

	-- Step 4: Algaz Station
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	["{npc:1343} stands at the {area:925}, at the south end of the pass."] = "{npc:1343} steht bei {area:925}, am südlichen Ende des Passes.",

	-- Step 5: Mountaineer Stormpike
	-- {npc:1343} Mountaineer Stormpike · {npc:1416} Grimand Elmore
	["{npc:1343}: {npc:1416}'s package"] = "{npc:1343}: das Paket von {npc:1416}",

	-- Step 6: Silver Stream Mine
	["East along the hills to the mine: the Miners' League crates sit in its tunnels among the Tunnel Rat kobolds."] = "Nach Osten entlang der Hügel zur Mine: Die Kisten der Minenarbeiterliga liegen in ihren Tunneln zwischen den Tunnelratten-Kobolden.",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates; below ground"] = "{item:2640}, aus den Kisten; unter der Erde",

	-- Step 7: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "Zurück zum {area:925}",

	-- Step 8: Stonewrought Dam
	["Chief Engineer Hinderweir stands on top of the dam, up the ramp at its west end."] = "Chefingenieur Hinderweir steht oben auf dem Damm, über die Rampe an dessen westlichem Ende.",

	-- Step 9: The Suspicious Barrel
	-- {object:257} Suspicious Barrel
	["The {object:257}"] = "{object:257}",
	-- plural, as words: Dark Iron Sappers = {npc:1222} Dark Iron Sapper
	["Walk east along the dam, down its eastern ramp, then back west along the foot of the dam on the land side: two Dark Iron Sappers guard the barrel. Kill them, then open the barrel: it ends this quest and starts the next."] = "Geh ostwärts den Damm entlang, die östliche Rampe hinunter und dann westwärts am Fuß des Dammes auf der Landseite zurück: Zwei Dunkeleisen-Sappeure bewachen das Fass. Töte sie und öffne dann das Fass: Es beendet diese Quest und startet die nächste.",

	-- Step 11: The loch
	["The loch"] = "Der Loch",
	-- {object:665289} Discarded Fishing Toolbox · {area:144} Thelsamar · {item:278051} Monogrammed Silver Hair Clip
	["South along the west shore. The {object:665289} lies on the loch bed at one of several places: east of {area:144} (48.1,39.7), a little south-west of there (45.7,43.4), or at the south end of the loch (48.7,54.4 or 50.6,53.3). If it isn't at the arrow, try the next place. Click it for the quest; the {item:278051} comes with it."] = "Südwärts am Westufer entlang. {object:665289} liegt auf dem Lochboden an einer von mehreren Stellen: östlich von {area:144} (48.1,39.7), etwas südwestlich davon (45.7,43.4) oder am Südufer des Lochs (48.7,54.4 oder 50.6,53.3). Wenn es nicht beim Pfeil liegt, probiere die nächste Stelle. Klicke es für die Quest an; {item:278051} kommt mit dabei.",
	-- {object:665289} Discarded Fishing Toolbox
	["{object:665289}; underwater"] = "{object:665289}; unter Wasser",

	-- Step 12: Thelsamar
	-- {npc:1684} Khara Deepwater · {npc:1105} Jern Hornhelm
	["{npc:1684} stands on the shore north-east of town, {npc:1105} by the inn."] = "{npc:1684} steht am Ufer nordöstlich des Ortes, {npc:1105} beim Gasthaus.",

	-- Step 13: Ironband's Excavation
	-- {npc:1345} Magmar Fellhew · {npc:1344} Prospector Ironband
	["Round the south end of the loch and head east to the dig. {npc:1345} and {npc:1344} stand together at its west edge."] = "Rund um das Südufer des Lochs und dann ostwärts zur Ausgrabung. {npc:1345} und {npc:1344} stehen zusammen an deren westlichem Rand.",

	-- Step 14: The dig site
	["The dig site"] = "Die Ausgrabungsstätte",
	-- {item:2636} Carved Stone Idol · {quest:86613} Excavation Tools
	-- plural, as words: Stonesplinter Diggers = {npc:1167} Stonesplinter Digger · Berserk Troggs = {npc:1393} Berserk Trogg
	["Stonesplinter Diggers, Geomancers and Berserk Troggs hold the dig east of Ironband; any of them can drop a {item:2636}. Piles of Excavation Tools lie around the dig: open one and right-click the tools to start {quest:86613}, then gather six.\nCareful: Berserk Troggs (19-20) enrage below 40% health."] = "Splitterstein-Bagger, -Geomanten und -Berserker halten die Ausgrabung östlich von Ironband; jeder von ihnen kann {item:2636} fallen lassen. Haufen mit Grabwerkzeugen liegen um die Ausgrabung herum: Öffne einen und klicke die Werkzeuge mit der rechten Maustaste an, um {quest:86613} zu starten, dann sammle sechs.\nVorsicht: Berserker-Troggs (19-20) geraten unter 40 % Leben in Wut.",
	-- {quest:86613} Excavation Tools
	["{quest:86613}: open a pile at the dig"] = "{quest:86613}: öffne einen Haufen an der Ausgrabung",
	-- {quest:86613} Excavation Tools
	["Right-click the {quest:86613}"] = "Klicke {quest:86613} mit der rechten Maustaste an",

	-- Step 16: The Farstrider Lodge
	-- {npc:1154} Marek Ironheart · {npc:1187} Daryl the Youngling
	["North-east to the lodge on the hill. {npc:1154} stands inside, {npc:1187} outside."] = "Nordostwärts zur Hütte auf dem Hügel. {npc:1154} steht drinnen, {npc:1187} draußen.",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}, inside"] = "{npc:1154}, drinnen",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}: the loch crocolisks below the lodge"] = "{npc:1154}: die Krokodile unterhalb der Hütte",
	-- {npc:1187} Daryl the Youngling
	["{npc:1187}: 15 minutes"] = "{npc:1187}: 15 Minuten",

	-- Step 17: Mountain Buzzards
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards"] = "Berggeier",
	-- {quest:257} A Hunter's Boast
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards circle the hills west and south of the lodge, back toward the dig. {quest:257} runs for 15 minutes."] = "Berggeier kreisen über den Hügeln westlich und südlich der Hütte, zurück Richtung Ausgrabung. {quest:257} läuft 15 Minuten lang.",

	-- Step 18: Daryl the Youngling
	["12 minutes"] = "12 Minuten",

	-- Step 19: Elder Mountain Boars
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["Elder Mountain Boars"] = "Alte Bergeber",
	-- {quest:258} A Hunter's Challenge
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["The Elder Mountain Boars roam the hills north-west of the lodge, along the east shore. {quest:258} runs for 12 minutes: kill five and go straight back to Daryl; the crocolisks come after."] = "Die Alten Bergeber streifen über die Hügel nordwestlich der Hütte, entlang des Ostufers. {quest:258} läuft 12 Minuten: Töte fünf und geh direkt zurück zu Daryl; die Krokilisken kommen danach.",

	-- Step 21: Daggerfang and the loch crocolisks
	-- {npc:270693} Daggerfang
	["{npc:270693} and the loch crocolisks"] = "{npc:270693} und die Lochkrokilisken",
	-- {npc:270693} Daggerfang
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["Back down to the east shore below the boars' hills: {npc:270693}, a crocolisk, patrols it among the Loch Crocolisks."] = "Zurück hinunter zum Ostufer unterhalb der Hügel der Eber: {npc:270693}, ein Krokilisk, patrouilliert dort zwischen den Lochkrokilisken.",
	-- {item:2924} Crocolisk Meat
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["{item:2924}: Loch Crocolisks"] = "{item:2924}: Krokodile im Loch",

	-- Step 23: Thelsamar
	-- {area:144} Thelsamar · {npc:1105} Jern Hornhelm · {npc:1572} Thorgrum Borrelson
	["Back west along the south shore to {area:144}: {npc:1105} by the inn, then {npc:1572} with the gryphons on the west side of town, on the way south."] = "Zurück westwärts am Südufer nach {area:144}: {npc:1105} beim Gasthaus, dann {npc:1572} bei den Greifen auf der Westseite des Ortes, auf dem Weg nach Süden.",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}"] = "Für {npc:1356} in {zone:1455}",

	-- Step 24: Mountaineer Ylva
	-- {npc:269185} Headsplitter
	["South of Thelsamar, Ylva lies dead in the mouth of a trogg cave. Take her banner, raise it beside her and hold the spot: troggs come in waves from both sides, then {npc:269185}."] = "Südlich von Thelsamar liegt Ylva tot am Eingang einer Trogg-Höhle. Nimm ihr Banner, hisse es neben ihr und halte die Stelle: Troggs kommen in Wellen von beiden Seiten, dann {npc:269185}.",

	-- Step 25: The tunnel post
	["The tunnel post"] = "Der Tunnelposten",
	-- {zone:1426} Dun Morogh
	["West to the dwarven post at the tunnel to {zone:1426}."] = "Westwärts zum Zwergenposten am Tunnel nach {zone:1426}.",

	-- Step 26: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Flieg nach {area:1537}",
	-- {area:1537} Ironforge · {zone:1426} Dun Morogh · {area:144} Thelsamar
	["You have the {area:1537} flight path from {zone:1426}: back north to {area:144}'s gryphons, quicker than walking through the tunnel and across {zone:1426}."] = "Die Flugroute nach {area:1537} kennst du aus {zone:1426}: zurück nach Norden zu den Greifen von {area:144}, schneller als durch den Tunnel und quer durch {zone:1426} zu laufen.",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Flugmeister in {area:144}",

	-- Step 27: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "Nach {zone:1426}",
	-- {zone:1455} Ironforge · {area:144} Thelsamar
	["Through the South Gate tunnel and west along the road to {zone:1455}. Know the {zone:1455} flight path already? Fly from {area:144} instead: these two waypoints drop once you are in the city."] = "Durch den Tunnel am Südtor und auf der Straße nach Westen bis {zone:1455}. Kennst du die Flugroute nach {zone:1455} schon? Dann flieg stattdessen ab {area:144}: Diese beiden Wegpunkte entfallen, sobald du in der Stadt bist.",

	-- Step 28: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "Nach {zone:1455}",

	-- Step 29: Ironforge
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words) · {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers (no name in this language: may be words) · {object:171524} Tinker Town
	["{npc:1573} keeps the gryphons in the {object:32372}; {npc:1356} is in the {object:32356}, north-east of it, on the way to the tram in {object:171524}."] = "{npc:1573} hält die Greifen im {object:32372}; {npc:1356} ist im {object:32356}, nordöstlich davon, auf dem Weg zur Bahn in {object:171524}.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, bei {object:32372}",

	-- Step 30: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Bahn nach {zone:1453}",

	-- Step 31: Elwynn Forest
	-- {zone:1453} Stormwind · {area:87} Goldshire
	["From the tram, leave {zone:1453} by the main gate and follow the road through {area:87} and east through Elwynn to Redridge."] = "Von der Bahn aus verlässt du {zone:1453} durch das Haupttor und folgst der Straße durch {area:87} und nach Osten durch Elwynn nach Redridge.",
	["The road east to Redridge"] = "Die Straße nach Osten nach Redridge",

	-- Step 32: Guard Thomas
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora · {npc:240} Marshal Dughan · {quest:35} Further Concerns · {area:87} Goldshire
	["{npc:261} guards the bridge on this road east, past the {area:91}: {npc:240}'s {quest:35}, from your walk through {area:87}, goes to him."] = "{npc:261} bewacht die Brücke auf dieser Straße nach Osten, hinter {area:91}: {quest:35} von {npc:240}, von deinem Spaziergang durch {area:87}, geht zu ihm.",
	-- {npc:261} Guard Thomas
	["{npc:261}, on the bridge"] = "{npc:261}, auf der Brücke",

	-- Step 33: Henze Faulk
	-- {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["From the bridge, head north to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Von der Brücke aus gehst du nach Norden nach {area:86}. {npc:6172} liegt südlich des Sees: Benutze {item:6866} bei ihm. Die Defias-Schurkenmagier um ihn herum tragen {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Benutze {item:6866} an {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Abtrünnige Hexer der Defias",

	-- Step 34: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker
	["The road crosses into Redridge at {area:1002}. {npc:464} walks around the crossroads."] = "Die Straße führt bei {area:1002} nach Redridge. {npc:464} läuft um die Kreuzung herum.",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "{npc:464} läuft um {area:1002} herum: schau im Kreis auf der Karte nach",

	-- Step 35: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} stands by the road next to her."] = "Folge der Straße am Südufer von {area:68} zur Greifenmeisterin. {npc:1070} steht neben ihr an der Straße.",

	-- Step 36: Lakeshire
	-- {npc:8965} Shawn · {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:415} Verner Osgood · {npc:344} Magistrate Solomon · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:379} Darcy · {npc:343} Chef Breanna
	["Cross the long bridge north into town: {npc:8965} and {npc:8962} play by the shore at its north end, {npc:341} and {npc:382} stand there too, {npc:415} by the smithy, {npc:344} in the town hall, {npc:381} on the docks, {npc:266} upstairs in the inn and {npc:379} and {npc:343} inside it."] = "Überquere die lange Brücke nach Norden in die Stadt: {npc:8965} und {npc:8962} spielen am Ufer an ihrem Nordende, {npc:341} und {npc:382} stehen ebenfalls dort, {npc:415} bei der Schmiede, {npc:344} im Rathaus, {npc:381} an den Docks, {npc:266} oben im Gasthaus und {npc:379} und {npc:343} drin.",
	-- {npc:382} Marshal Marris
	["{npc:382}: the Blackrock camps are for your next Redridge visit, at about 24"] = "{npc:382}: die Schwarzfels-Lager sind für deinen nächsten Redridge-Besuch, bei etwa 24",
	-- {npc:415} Verner Osgood · {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:415}: for {npc:514} in {area:87}"] = "{npc:415}: für {npc:514} in {area:87}",
	-- {npc:344} Magistrate Solomon · {npc:466} General Marcus Jonathan · {zone:1453} Stormwind
	["{npc:344}, in the town hall: for {npc:466} in {zone:1453}"] = "{npc:344}, im Rathaus: für {npc:466} in {zone:1453}",
	-- {npc:266} Wiley the Black
	["{npc:266}, in the inn; upstairs"] = "{npc:266}, im Gasthaus; oben",
	-- {npc:379} Darcy
	["{npc:379}, inside"] = "{npc:379}, drinnen",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "{npc:343}, drinnen",

	-- Step 37: Guard Parker
	-- {area:1002} Three Corners
	["West along the road to {area:1002} first; the gnolls are on the way back east."] = "Zuerst westwärts die Straße nach {area:1002} entlang; die Gnolle sind auf dem Rückweg nach Osten.",

	-- Step 38: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "{area:1001}: Töte diese, wenn du ihnen begegnest",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Great Goretusks = {npc:547} Great Goretusk · Dire Condors = {npc:428} Dire Condor
	["Redridge Mongrels and Thrashers hold the hills east of {area:1002}, north of the road; Poachers camp south of the road. Great Goretusks root around the same hills and Dire Condors circle south of the lake; Tarantulas crawl round {area:1002}."] = "Redridge-Mongrels und -Prügler halten die Hügel östlich von {area:1002}, nördlich der Straße; Räuber lagern südlich der Straße. Riesige Goretusks wühlen in denselben Hügeln, und Düsterkondore kreisen südlich des Sees; Taranteln krabbeln um {area:1002} herum.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: Hauer der Rotkammgnolle",
	-- {item:1081} Crisp Spider Meat
	["{item:1081}: Tarantulas"] = "{item:1081}: Taranteln",

	-- Step 39: Deputy Feldon
	-- {npc:1070} Deputy Feldon
	["East along the road to the gryphon master; {npc:1070} stands beside her."] = "Ostwärts die Straße zur Greifenmeisterin entlang; {npc:1070} steht neben ihr.",

	-- Step 40: Sunken Chest
	-- {area:68} Lake Everstill · {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Back toward town, swim east from the bridge into {area:68}; the chest lies on the lake bed beside a sunken boat. Murloc Flesheaters and Tidecallers line the south shore around it: any of them can carry a {item:1467}."] = "Zurück Richtung Stadt, schwimme östlich von der Brücke in {area:68}; die Truhe liegt auf dem Seeboden neben einem versunkenen Boot. Murloc-Fleischfresser und Gezeitenrufer stehen am Südufer um sie herum: Jeder von ihnen kann {item:1467} bei sich tragen.",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "{item:1309}; unter Wasser",

	-- Step 41: Hilary's Necklace
	-- {object:154357} Glinting Mud
	["Then west under the bridge: a {object:154357} mound on the lake bed beside town holds the necklace. Only one mound shows at a time, anywhere from under the dock to past the bridge."] = "Dann westwärts unter der Brücke: ein Haufen {object:154357} auf dem Seeboden neben der Stadt birgt die Halskette. Es erscheint immer nur ein Haufen, irgendwo vom Dock bis hinter der Brücke.",
	-- {quest:3741} Hilary's Necklace
	["{quest:3741}; underwater"] = "{quest:3741}; unter Wasser",

	-- Step 42: Lakeshire
	-- {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren · {npc:342} Martie Jainrose · {npc:379} Darcy · {npc:343} Chef Breanna
	["Through town east to west: {npc:8962} and {npc:341} at the north end of the bridge, {npc:381} on the docks, then {npc:342}'s garden at the west end; {npc:379} and {npc:343} are in the inn."] = "Durch die Stadt von Ost nach West: {npc:8962} und {npc:341} am Nordende der Brücke, {npc:381} an den Docks, dann der Garten von {npc:342} am Westende; {npc:379} und {npc:343} sind im Gasthaus.",
	-- {zone:1436} Westfall
	["Its pikes and rivets come from the gnolls north of the lake, on the loop after {zone:1436}"] = "Seine Spieße und Nieten kommen von den Gnollen nördlich des Sees, auf der Schleife nach {zone:1436}",

	-- Step 43: Dockmaster Baren
	-- {npc:381} Dockmaster Baren · {quest:150} Murloc Poachers · {area:69} Lakeshire
	["From level 20 {npc:381} gives {quest:150}: take it now if he offers it (otherwise on the last {area:69} stop). Its murlocs are for your next Redridge visit, at about 24."] = "Ab Stufe 20 gibt {npc:381} {quest:150}: Nimm es jetzt an, wenn er es anbietet (sonst beim letzten Halt in {area:69}). Die Murlocs davon sind für deinen nächsten Redridge-Besuch, bei etwa 24.",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks"] = "{npc:381}, an den Docks",

	-- Step 44: Goldshire
	-- {area:1002} Three Corners · {area:87} Goldshire
	["West out of Redridge by {area:1002} and along the road through Elwynn to {area:87}."] = "Westwärts aus Redridge bei {area:1002} und die Straße durch Elwynn nach {area:87} entlang.",

	-- Step 45: Smith Argus
	-- {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:514} works at the {area:87} smithy."] = "{npc:514} arbeitet an der Schmiede in {area:87}.",

	-- Step 46: Stormwind's gate
	-- {zone:1453} Stormwind
	["{zone:1453}'s gate"] = "Das Tor von {zone:1453}",
	-- {npc:234} Gryan Stoutmantle · {zone:1436} Westfall · {area:87} Goldshire · {zone:1453} Stormwind · {npc:466} General Marcus Jonathan · {object:2096} Trade District · {area:69} Lakeshire
	["No Defias Brotherhood from Wiley (it starts with {npc:234}'s letter in {zone:1436}): skip {zone:1436}. North along the road from {area:87} to {zone:1453}: {npc:466} sits on his horse at the far end of the bridge outside the main gate. Then the gryphons in the {object:2096}, back to {area:69}."] = "Keine Bruderschaft der Defias von Wiley (sie beginnt mit dem Brief von {npc:234} in {zone:1436}): überspringe {zone:1436}. Nordwärts die Straße von {area:87} nach {zone:1453} entlang: {npc:466} sitzt auf seinem Pferd am fernen Ende der Brücke vor dem Haupttor. Dann die Greifen im {object:2096}, zurück nach {area:69}.",
	-- {npc:466} General Marcus Jonathan
	["{npc:466}, outside the main gate"] = "{npc:466}, vor dem Haupttor",

	-- Step 47: Westfall
	-- {zone:1436} Westfall
	["West through Westbrook into {zone:1436}."] = "Westwärts durch Westbrook nach {zone:1436}.",

	-- Step 48: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Down the road to {area:108}. {npc:234} stands at the top of the stone tower."] = "Die Straße nach {area:108} hinunter. {npc:234} steht oben auf dem Steinturm.",
	-- {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["For {npc:332} in {zone:1453}"] = "Für {npc:332} in {zone:1453}",

	-- Step 49: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "Flugmeister in {area:108}",

	-- Step 50: Stormwind
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:466} General Marcus Jonathan · {object:2096} Trade District
	["{npc:332} is upstairs in the SI:7 building in {object:2100}: the stairs are hard to see at first. {npc:466} sits on his horse at the far end of the bridge outside the main gate, then back to the gryphons in the {object:2096}."] = "{npc:332} ist oben im SI:7-Gebäude in {object:2100}: Die Treppe ist zuerst schwer zu sehen. {npc:466} sitzt auf seinem Pferd am fernen Ende der Brücke vor dem Haupttor, dann zurück zu den Greifen im {object:2096}.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7; upstairs"] = "{npc:332}, SI:7; oben",

	-- Step 51: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["{npc:234}, at the top of the tower"] = "{npc:234}, oben auf dem Turm",

	-- Step 52: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} und die Hügel der Defias",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "Defias-Pfadpirscher und -Knöchelschläger laufen in {area:20}; Wegelagerer (Stufe 17) patrouillieren paarweise in den Hügeln südlich und östlich davon: Zieh sie einzeln. Der Eingang zu {area:1581} in der Schmiede ist ein Gruppendungeon.\nVorsicht: Die Lager in den Hügeln haben gemischte Gruppen der Defias, also ziehst du auf niedriger Stufe leicht mehr als einen.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, aus den Kisten rund um {area:20}",

	-- Step 53: The Defias Messenger
	-- {npc:550} Defias Messenger
	["The {npc:550}"] = "{npc:550}",
	-- {area:20} Moonbrook · {npc:550} Defias Messenger · {area:113} Gold Coast Quarry · {area:111} Jangolode Mine
	["South along the road to {area:20}. The {npc:550} starts in front of the {area:20} smithy and walks north to the {area:113} and the back of the {area:111}, then back: look along his road. Slow him when he runs at 30% health."] = "Südwärts die Straße nach {area:20} entlang. {npc:550} beginnt vor der Schmiede von {area:20} und läuft nach Norden zum {area:113} und zur Rückseite von {area:111}, dann zurück: Schau entlang seiner Straße. Verlangsame ihn, wenn er bei 30 % Leben davonrennt.",
	-- {item:1381} A Mysterious Message · {npc:550} Defias Messenger
	["{item:1381}: the {npc:550}"] = "{item:1381}: {npc:550}",

	-- Step 54: Westfall Lighthouse
	-- {area:20} Moonbrook · {npc:392} Captain Grayson · {npc:391} Old Murk-Eye
	["South-west from {area:20} to the lighthouse on the point: {npc:392} waits on its steps. {npc:391} walks the beach and the shallows north-east of it among the murlocs: pull him away from the Oracles."] = "Südwestwärts von {area:20} zum Leuchtturm auf der Landspitze: {npc:392} wartet auf seinen Stufen. {npc:391} läuft am Strand und in den Flachwassern nordöstlich davon zwischen den Murlocs umher: Zieh ihn von den Orakeln weg.",
	-- {item:3636} Scale of Old Murk-Eye · {npc:391} Old Murk-Eye
	["{item:3636}: {npc:391}, on the beach north-east of the lighthouse"] = "{item:3636}: {npc:391}, am Strand nordöstlich des Leuchtturms",

	-- Step 55: Captain Grayson
	-- {zone:1436} Westfall · {npc:392} Captain Grayson
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Kept five Flasks of Oil from {zone:1436}'s Harvest Watchers? {npc:392} takes them for his lighthouse fire."] = "Fünf Flaschen Öl von den Erntebehütern aus {zone:1436} behalten? {npc:392} nimmt sie für das Feuer seines Leuchtturms.",

	-- Step 56: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:467} The Defias Traitor
	["Back north up the road to {area:108}. {npc:467} waits at the foot of the tower ramp; if he is missing, someone is escorting him and he is back within minutes."] = "Zurück nach Norden die Straße nach {area:108} hinauf. {npc:467} wartet am Fuß der Turmrampe; wenn er fehlt, wird er eskortiert und ist innerhalb von Minuten zurück.",

	-- Step 57: The Defias Traitor
	-- {area:20} Moonbrook
	["Stay with the traitor as he walks south to {area:20}; he does not stop for fights, so clear what follows him. His walk ends at the Defias hideout below {area:20}."] = "Bleib beim Verräter, während er südwärts nach {area:20} geht; er hält bei Kämpfen nicht an, also räume ab, was ihm folgt. Sein Weg endet im Versteck der Defias unterhalb von {area:20}.",
	-- {npc:467} The Defias Traitor
	["{npc:467}, at the foot of the tower ramp"] = "{npc:467}, am Fuß der Turmrampe",

	-- Step 58: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["Back north to {npc:234} and the gryphons."] = "Zurück nach Norden zu {npc:234} und den Greifen.",

	-- Step 59: Lakeshire
	-- {npc:415} Verner Osgood · {npc:344} Magistrate Solomon
	["From the gryphons, over the bridge into town: {npc:415} by the smithy, {npc:344} in the town hall."] = "Von den Greifen aus über die Brücke in die Stadt: {npc:415} bei der Schmiede, {npc:344} im Rathaus.",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, im Rathaus",

	-- Step 60: Redridge Canyons
	-- {spell:133} Fireball
	-- plural, as words: Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["Redridge Brutes and Mystics hold the hills north and north-west of town; both carry the Iron Pikes and Rivets. Black Dragon Whelps nest in the same hills.\nCareful: The whelps cast {spell:133} from range, and the gnolls run for help at low health."] = "Redridge-Schläger und -Mystiker halten die Hügel nördlich und nordwestlich der Stadt; beide tragen die Eisenspieße und -Nieten. Schwarze Drachen-Welpen nisten in denselben Hügeln.\nVorsicht: Die Welpen wirken {spell:133} aus der Distanz, und die Gnolle rennen bei wenig Leben Hilfe holen.",
	-- {item:1221} Underbelly Whelp Scale
	-- plural, as words: Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["{item:1221}: Black Dragon Whelps"] = "{item:1221}: Schwarze Drachen-Welpen",

	-- Step 61: Lakeshire
	-- {npc:415} Verner Osgood · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren
	["Back down into town: {npc:415} by the smithy, {npc:341} at the north end of the bridge, {npc:381} on the docks."] = "Zurück hinunter in die Stadt: {npc:415} bei der Schmiede, {npc:341} am Nordende der Brücke, {npc:381} an den Docks.",
	-- {npc:341} Foreman Oslow · {quest:98386} Alther's Mill
	["{npc:341}: {quest:98386}, for your next Redridge visit"] = "{npc:341}: {quest:98386}, für deinen nächsten Redridge-Besuch",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks: the murlocs are for your next Redridge visit"] = "{npc:381}, an den Docks: die Murlocs sind für deinen nächsten Redridge-Besuch",

	-- Step 62: Fly to Stormwind
	-- {area:442} Auberdine · {zone:1439} Darkshore · {zone:1453} Stormwind
	["Back to {area:442} for {zone:1439}'s southern loops: the gryphon to {zone:1453}, then the boat from the harbour."] = "Zurück nach {area:442} für die südlichen Schleifen von {zone:1439}: der Greif nach {zone:1453}, dann das Boot aus dem Hafen.",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "Flugmeister in {area:69}",

	-- Step 64: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:28027} Dwarven District
	["{npc:1646} stands at the east side of {object:2098}, on the way from the {object:28027} to the harbour."] = "{npc:1646} steht an der Ostseite von {object:2098}, auf dem Weg vom {object:28027} zum Hafen.",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: Thundris' Brief aus {area:442}",
	-- {npc:3649} Thundris Windweaver
	["For {npc:3649}, where the boat lands"] = "Für {npc:3649}, wo das Boot anlegt",

	-- Step 65: Gazin Tenorm
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {object:2098} Cathedral Square
	["{npc:6173} and {npc:6171} are in the Cathedral of Light, on {object:2098}, on the way to the harbour."] = "{npc:6173} und {npc:6171} sind in der Kathedrale des Lichts, auf {object:2098}, auf dem Weg zum Hafen.",
	["Cathedral of Light"] = "Kathedrale des Lichts",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Erlösung",
}
