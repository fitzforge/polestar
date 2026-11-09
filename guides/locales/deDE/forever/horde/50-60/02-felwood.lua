-- German (deDE): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "Er lagert beim {area:202}, südöstlich von {area:200}.",
	["Inside"] = "",

	-- Step 2: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River · {zone:1423} Eastern Plaguelands
	["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "Reite an den östlichen Hügeln entlang nach Norden; {npc:1855} lebt in einem kleinen Haus am {area:2619}, an der Grenze zu den {zone:1423}.",
	-- {npc:1855} Tirion Fordring · {zone:1423} Eastern Plaguelands
	["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}s Jagden sind in den {zone:1423}: Behalte sie für später.",

	-- Step 3: Kirsta Deepshadow
	-- {area:192} Northridge Lumber Camp · {npc:11610} Kirsta Deepshadow
	["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "Reite nach Westen zum {area:192}; {npc:11610} versteckt sich auf dem Hügel nordöstlich davon.",

	-- Step 4: Level 52.63
	["Level 52.63"] = "",
	-- {area:200} Dalson's Tears · {npc:11610} Kirsta Deepshadow · {quest:6004} Unfinished Business · {area:1417} Sunken Temple · {area:2100} Maraudon
	-- plural, as words: Scarlet Mages = {npc:1826} Scarlet Mage
	["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Scarlet Mages and Knights here count for {npc:11610}'s {quest:6004}. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	-- {npc:1826} Scarlet Mage
	["grind on {npc:1826}"] = "",

	-- Step 5: Diseased Wolves
	["Diseased Wolves"] = "Kranke Wölfe",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "Die Wölfe streifen über die Felder zwischen Andorhal, {area:200} und {area:202}. Erledige sie auf dem Rückritt nach Osten.",

	-- Step 6: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Bauernhaus von {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "Das Tagebuch liegt im Bauernhaus, der Schrank steht drinnen und der Abort dahinter. Ein {npc:10816} trägt den Schlüssel zum Abort; {npc:10836} kommt heraus, wenn du den Abort öffnest, und trägt den Schlüssel zum Schrank.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, inside"] = "",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "",

	-- Step 8: Diseased Grizzlies
	["Diseased Grizzlies"] = "Kranke Grizzlys",
	-- {area:202} Writhing Haunt · {area:1417} Sunken Temple · {area:1584} Blackrock Depths
	["The bears roam the hills north and east of the {area:202}. Below level 53.02, keep hunting them after the eighth: the hand-ins at the {area:202} take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "",
	-- {npc:1816} Diseased Grizzly
	["grind on {npc:1816}"] = "",

	-- Step 9: Mulgris Deepriver
	-- {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["Keep the branch: {npc:5770} is in {zone:1456}."] = "Behalte den Zweig: {npc:5770} ist in {zone:1456}.",

	-- Step 10: Scarlet Crusade
	["Scarlet Crusade"] = "Scharlachroter Kreuzzug",
	-- {area:192} Northridge Lumber Camp
	["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "Ritter und Magier arbeiten im {area:192}; die Sanitäter und Jäger lagern südlich davon.",
	-- {npc:10605} Scarlet Medic
	["grind on {npc:10605}"] = "",

	-- Step 12: The Bulwark
	-- {area:152} The Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "Reite nach Südwesten am Teufelssteinhof vorbei und folge der Straße nach Westen zurück zum {area:152}.",
	-- {npc:11615} Mickey Levine
	["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "Derringtons Wachtürme, Vandis' Kessel und {npc:11615}s Fass erledigst du bei einem späteren Besuch: Behalte sie.",

	-- Step 13: Level 53.34
	["Level 53.34"] = "",
	-- {area:1763} Jaedenar · {area:1417} Sunken Temple · {area:1584} Blackrock Depths
	["Top up here to level 53.34 before the hand-ins at {area:1763}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "",

	-- Step 15: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "",

	-- Step 16: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",

	-- Step 17: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 18: Class trainer
	["Class trainer"] = "",

	-- Step 19: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "",

	-- Step 20: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 22: Emerald Sanctuary
	["The druids' camp is just past the border."] = "Das Lager der Druiden liegt gleich hinter der Grenze.",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}, am Südrand des Lagers",

	-- Step 23: Deadwood Village
	-- {area:1769} Timbermaw Hold · {area:1763} Jaedenar · {area:1417} Sunken Temple · {area:1584} Blackrock Depths
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "",
	-- {npc:7153} Deadwood Warrior
	["grind on {npc:7153}"] = "",

	-- Step 24: Emerald Sanctuary
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, just west of the camp"] = "{npc:9529}, gleich westlich des Lagers",

	-- Step 25: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "Südliches {area:1763}",
	-- {area:1763} Jaedenar
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "Folge der Straße nach Nordwesten. Den Süden von {area:1763}, um seinen verderbten Mondbrunnen, halten Kultisten, Adepten, Wachen und Hunde des Schattenrats.",

	-- Step 26: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "",

	-- Step 27: Captured Arko'narin
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, below ground"] = "",

	-- Step 29: Rescue From Jaedenar
	-- {npc:11018} Arko'narin · {area:1770} Shadow Hold
	["Walk {npc:11018} out of {area:1770} and keep her alive until she is out of the cave."] = "",
	-- {npc:11018} Arko'narin
	["{npc:11018}, below ground"] = "",

	-- Step 30: Jessir Moonbow
	-- {area:2479} Emerald Sanctuary
	["Back at the {area:2479}."] = "",

	-- Step 32: Emerald Sanctuary
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Only with 5 Deadwood Headdress Feathers"] = "Nur mit 5 Kopfputzfedern der Totenwaldfelle",

	-- Step 33: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "Der Mondbrunnen von {area:1763}",
	-- {area:1763} Jaedenar · {npc:10922} Greta Mosshoof
	["Back north to {area:1763}. Fill {npc:10922}'s canteen at the corrupted moonwell in the middle of the southern camp."] = "Zurück nach Norden nach {area:1763}. Füll {npc:10922}s Feldflasche am verderbten Mondbrunnen mitten im südlichen Lager.",

	-- Step 34: Rakaiah
	-- {npc:9518} Rakaiah · {area:1763} Jaedenar · {npc:11020} Remains of Trey Lightforge
	["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "",
	["Below ground"] = "",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "",

	-- Step 36: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "Das Hordelager gleich nördlich von {area:1763}.",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}: Die Eulenbestien sind in {zone:1452}",

	-- Step 37: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "Östlich vom Blutgiftposten liegt das kraterübersäte Tal, wo die Entropischen Bestien und Schrecken umherstreifen. Töte je zwei davon und geh dann zu jedem der drei Krater mit Teufelswasser.",
	["Southern crater"] = "Südlicher Krater",
	["Western crater"] = "Westlicher Krater",
	["Northern crater"] = "Nördlicher Krater",

	-- Step 38: Irontree Woods
	-- {area:1767} Irontree Woods · {item:11503} Blood Amber · {area:1997} Bloodvenom Post · {area:2479} Emerald Sanctuary · {area:1584} Blackrock Depths · {area:1417} Sunken Temple
	-- plural, as words: Warpwood Moss Flayers = {npc:7100} Warpwood Moss Flayer · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:8957} Angerclaw Grizzly
	["grind on {npc:8957}"] = "",

	-- Step 39: Irontree Woods
	-- {npc:7101} Warpwood Shredder
	["grind on {npc:7101}"] = "",

	-- Step 40: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw · {npc:11557} Meilosh
	["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "Das Furbolgdorf der Totenwaldfelle gleich westlich des Tunnels. {npc:9462} (56) steht zwischen ihnen. {npc:11557}, ein freundlicher Furbolg, sitzt am Nordende des Dorfs.",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "",

	-- Step 41: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "Die Straße endet bei {npc:15395}, vor dem Tunnel der {area:1769} im äußersten Nordosten.",

	-- Step 42: Felpaw Village
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold · {area:2479} Emerald Sanctuary · {area:1584} Blackrock Depths · {area:1417} Sunken Temple
	["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nBelow level 54.54, keep fighting the Deadwood here after {npc:15395}'s count: the hand-ins at {area:1769} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:7156} Deadwood Den Watcher
	["grind on {npc:7156}"] = "",

	-- Step 43: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "Behalte {quest:8465} für {zone:1452}.",

	-- Step 44: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}, eine seltene Beute",

	-- Step 45: Emerald Sanctuary
	-- {zone:1448} Felwood
	["Ride the road south through {zone:1448} to the Sanctuary."] = "Reite die Straße nach Süden durch den {zone:1448} zum Refugium.",

	-- Step 47: Overlord Ror
	-- {area:1761} Deadwood Village
	["Ror stands at the far south end of {area:1761}."] = "Ror steht am äußersten Südende von {area:1761}.",

	-- Step 48: Emerald Sanctuary
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}, auf der Westseite des Refugiums",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {zone:1413} Barrens
	["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "Behalte {quest:5158}: {npc:5901} ist im {zone:1413}.",

	-- Step 49: Level 54.7
	["Level 54.7"] = "",
	-- {area:1997} Bloodvenom Post · {area:1584} Blackrock Depths · {area:1417} Sunken Temple
	["Top up here to level 54.7 before the hand-ins at {area:1997} : they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:7155} Deadwood Pathfinder
	["grind on {npc:7155}"] = "",

	-- Step 50: The Jadefire moonwell
	["The Jadefire moonwell"] = "Der Mondbrunnen der Jadefeuersatyrn",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "Reite zurück nach Süden an {area:1763} vorbei zum verderbten Mondbrunnen der Jadefeuersatyrn und füll dort {npc:9996}s Fläschchen.",

	-- Step 51: Bloodvenom Post
	["Ride north up the road again."] = "Reite die Straße wieder nach Norden hinauf.",

	-- Step 52: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}s Kätzchen",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "Bring das Kätzchen zum selben Mondbrunnen und lass es dort frei; sobald es sich in {npc:10042} verwandelt hat, bring es zurück zu {npc:9996} und klick es an, um es zu übergeben.",
	["Jadefire moonwell"] = "Mondbrunnen der Jadefeuersatyrn",

	-- Step 55: Level 54.87
	["Level 54.87"] = "",
	-- {zone:1452} Winterspring · {area:1584} Blackrock Depths · {area:1417} Sunken Temple
	["Top up here to level 54.87 before the hand-ins in {zone:1452}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:7125} Jaedenar Hound
	["grind on {npc:7125}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "Zurück in {area:1762}: Die Furbolgs der Totenwaldfelle (53-54) sind nah am Tunnel, und jeder Kill erhöht deinen Ruf bei der Holzschlundfeste.",
	-- ["Diseased Grizzlies"] = "Kranke Grizzlys",
	-- ["Fly to the {area:1497}"] = "Flieg nach {area:1497}",
	-- ["Fly to {area:272}"] = "Flieg nach {area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "Folge der Straße nach Nordosten zum {area:1767}. Die Wucherborkenschinder und -schredder auf der Ostseite des Waldes tragen je einen {item:11503}; Wutklauengrizzlys und Teufelspfotenverheerer streifen für Talo durch denselben Wald.",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "Flieg vom Flugmeister der {area:2268} nach {area:1497}.",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "Behalte Klein-Pamela: Pamela ist in {area:2262}, das du später noch einmal besuchst.",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "Behalte das Paket: {npc:10781} ist in {area:1497}.",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "Verlass {area:1497} und reite auf der Straße nach Osten durch {zone:1420}, am {area:152} vorbei. Der Teufelssteinhof ist der erste Hof an der Straße; {npc:10778} wartet im Haus.",
	-- ["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "Nur wenn {item:13140} gefallen ist: Benutze ihn, um die Quest zu starten, befrei dann {npc:11018} aus ihrem Käfig in {area:1770}, der Höhle am Nordende von {area:1763}, und eskortiere sie hinaus.",
	-- ["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "Nur wenn du {npc:11018} gerettet hast: Die Sukkubus {npc:9518} wartet mitten in {area:1763}, neben {npc:11020}.",
	-- ["Radley and Durgen"] = "Radley und Durgen",
	-- ["Ride back south-east to the Sanctuary."] = "Reite zurück nach Südosten zum Refugium.",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "Reite zurück nach {area:1497}, nimm den Zeppelin nach {zone:1454} und flieg zum {area:431}. Folge der Straße vom Splintertreeposten nach Westen und nimm die Abzweigung nach Norden in den {zone:1448}.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Reite nach Nordwesten nach Andorhal. {npc:10667} wartet im zerstörten Gasthaus auf der Westseite der Stadt; die Skelette drinnen sind 54-57, also bleib am Rand.",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "Reite nach Süden am {area:202} vorbei zum {area:197}; {npc:10927}s Haus steht an der Straße, und das Denkmal von {npc:10936} ist auf dem Friedhof dahinter. Töte unterwegs die Kranken Wölfe auf den Feldern.",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "Reite die Straße nach Süden durch den {area:361} zum Refugium.",
	-- ["Scarlet forward camp"] = "Vorgeschobenes Lager des Scharlachroten Kreuzzugs",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Die Annalen liegen zwischen den Modrigen Folianten im Rathaus von Andorhal; öffne sie, bis du den richtigen findest.",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "Das Furbolgdorf der Totenwaldfelle liegt gleich südlich des Refugiums. Jeder getötete Totenwaldfell erhöht auch deinen Ruf bei der {area:1769}; behalte die Kopfputzfedern.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "Die Zelte des Scharlachroten Kreuzzugs stehen zwischen {area:199} und {area:200}. Zünde das Kommandozelt mit {object:176092} an und pflanz das Banner der Geißel auf.",
	-- ["The bears roam the hills north and east of the {area:202}."] = "Die Bären streifen durch die Hügel nördlich und östlich vom {area:202}.",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "Durch die {area:1769}",
	-- ["To {zone:1448}"] = "Nach {zone:1448}",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "Geh neben {npc:15395} in den Tunnel der {area:1769} und greif niemals die Furbolgs der Holzschlundfeste darin an. Der Tunnel öffnet sich nach {zone:1452}; folge der Straße nach Osten nach {area:2255}, der Goblinstadt, in der der nächste Guide beginnt.",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "grinde Rächer der Totenwaldfelle in {area:1762}, {zone:1448}",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "grinde Scharlachrote Ritter im {area:192}, {zone:1422}",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "Die Scharlachroten in {area:190} sind Stufe 58-60. Reite zum auf deiner Karte markierten Aussichtspunkt, sieh dir die Stadt an und verschwinde wieder.",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}, am Südende des Friedhofs",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}: Behalte 30 {quest:6031} für ihn; er handelt erst ab neutralem Ruf bei der Holzschlundfeste",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}, am Tunneleingang",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}s letzte Aufgabe erfordert Stufe 53. Die Scharlachroten Ritter und Magier (54-55) im Holzfällerlager gleich südwestlich von ihr sind das nächste Lager.",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613} steht östlich des Holzfällerlagers; {npc:11611} bewacht die Straße nordöstlich von {npc:11610}, Richtung {area:190}.",
	-- ["{object:175894}, beside the house"] = "{object:175894}, neben dem Haus",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210} führt zur {area:2268}: Behalte sie für später.",
}
