-- Russian (ruRU): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1423} Eastern Plaguelands · {zone:1448} Felwood · {zone:1452} Winterspring
	["Western & {zone:1423}, {zone:1448} & {zone:1452}"] = "",

	-- Step 1: The Bulwark
	-- {area:199} Felstone Field · {area:152} The Bulwark · {npc:11055} Shadow Priestess Vandis
	["Back west along the road from {area:199} to the {area:152}: {npc:11055} takes the cauldron's report."] = "",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: his termites are in {area:2627}, later in this guide"] = "",

	-- Step 2: Dalson's Tears
	-- {area:199} Felstone Field · {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road past {area:199}, {npc:11077} guards the cauldron at {area:200}: kill him for the key, then use the cauldron."] = "",

	-- Step 4: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Сторожевые башни и силосы Андорала",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite · Skeletal Warlords = {npc:1788} Skeletal Warlord
	["Ride south-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites (55-57): fight them one at a time and let the biggest go.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room.\nCareful: Skeletal Warlords, level 56-57 elites, stand by the first and second towers (the south-western and the western one): mark those towers from the far side of the doorway once the Warlord has turned away, and never pull one. Putridius (58, rare) walks among the silos."] = "",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, наверху",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10905}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",

	-- Step 5: Chromie
	["Upstairs"] = "Наверху",

	-- Step 6: Counting Out Time
	-- {npc:10667} Chromie · {npc:1805} Flesh Golem
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth. A {npc:1805}, a level 56-57 elite, stands among the houses just east of the inn: take the boxes on the west side first and keep clear of it."] = "",

	-- Step 9: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "",

	-- Step 10: Apothecary Dithers
	-- {quest:838} Scholomance · {area:152} The Bulwark
	["Derrington's {quest:838} is offered from level 55: still under 55 here, the next {area:152} stop offers it again."] = "",

	-- Step 11: Skeletal Fragments
	-- {area:152} The Bulwark
	["The skeletons on the fields east of the {area:152} drop the fragments: take them on the ride east."] = "",

	-- Step 12: Target: Writhing Haunt
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt · {npc:11076} Cauldron Lord Razarch
	["East past {area:200} to the {area:202}: {npc:11076} guards its cauldron."] = "",
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark · {zone:1423} Eastern Plaguelands
	["from the cauldron, for {npc:11055} at the {area:152}: on the way back west, after the {zone:1423}"] = "",

	-- Step 13: Mulgris Deepriver
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Вы пропустили это при прошлом посещении этих мест по маршруту: теперь это идёт первым. Это быстро и открывает следующие задания.",
	["Inside"] = "Внутри",

	-- Step 16: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it."] = "",

	-- Step 17: Diseased Grizzlies
	["Diseased Grizzlies"] = "",
	["Careful: the grizzlies are 55-56: pull them one at a time."] = "",

	-- Step 19: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "В зону {zone:1423}",

	-- Step 20: Tirion Fordring
	-- {zone:1423} Eastern Plaguelands · {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east along the road into the {zone:1423}. {npc:1855} lives in a small house by the {area:2619}, just north of the road at the border; his three hunts are on this guide's ground."] = "Езжайте на восток по дороге в край {zone:1423}. {npc:1855} живет в маленьком доме у реки ({area:2619}), чуть к северу от дороги на границе; три его охоты проходят на территории этого гайда.",

	-- Step 22: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "Следуйте по дороге на восток от края {zone:1422}, через реку и через весь край {zone:1423}, к часовне ({object:92525}) на крайнем востоке.",

	-- Step 23: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "Призрак {npc:10926} стоит в руинах ({area:2262}) на юго-западе.",

	-- Step 24: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "Голова куклы и две ее половинки лежат в домах вокруг NPC {npc:10926}; соедините их в сумке.",

	-- Step 25: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "послание для NPC {npc:11063} ({area:2268})",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "Сохраните задание {quest:5152}: {npc:10927} живет здесь: {area:197} ({zone:1422}).",

	-- Step 26: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "Заэлдарр прячется чуть к западу от места {area:2262}.",
	["Below ground"] = "Под землей",

	-- Step 27: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Осторожно: {npc:10411} становится невидимым вне боя и призывает горгулий-камнекрылов, когда начинается бой. Их всего 3, и они возрождаются каждые 15 мин.",

	-- Step 28: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Назад: {area:2268}",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "Духи для задания {quest:5211} появятся при остановке здесь: {area:2264}, позже в этом руководстве: сохраните задание.",

	-- Step 29: Caretaker Alen
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls · {spell:437801} Light's Hope
	["{npc:11038} offers {quest:5281} from level 55; under it, the next {spell:437801} stop offers it again."] = "",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}: for {npc:11140} in {area:2627} later in this guide"] = "",

	-- Step 30: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Летите сюда: {area:272}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "Распорядитель полетов: {area:2268}",

	-- Step 31: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "Сюда: {area:197}",

	-- Step 32: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "Езжайте на север по дороге от места {area:272}. Дом NPC {npc:10927} стоит у дороги ({area:197}), а памятник ({npc:10936}) – на кладбище за ним.",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}, наверху",

	-- Step 33: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Езжайте на северо-запад в Андорал. {npc:10667} ждет в разрушенной таверне в западной части города; скелеты внутри – 54-57-го уровня, так что держитесь краев.",

	-- Step 34: The Annals of Darrowshire
	-- {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room."] = "Летопись лежит среди заплесневелых фолиантов в ратуше Андорала; открывайте их, пока не найдете нужный.\nОсторожно: {npc:10996}, элита 58-59-го уровня, может стоять в Андорале, как и во многих других местах края {zone:1422}: держитесь от него подальше.",

	-- Step 36: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Летите сюда: {area:2268}",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "Езжайте обратно на юг сюда: {area:272} и летите сюда: {area:2268}.",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Распорядитель полетов: {area:272}",

	-- Step 37: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {quest:5281} The Restless Souls
	["{npc:11038}, if you didn't take {quest:5281} on the last stop"] = "",
	-- {npc:11063} Carlin Redpath · {area:190} Hearthglen
	["{npc:11063}'s Heroes of Darrowshire needs a group in {area:190} and a ride back here at the end: leave it."] = "",

	-- Step 38: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: убивайте их по пути",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. Careful: the biggest Plaguehounds are 56, pull them one at a time.\nThe shattered sword lies on the ground north-west of the lake."] = "Чумные псы и их карлики бродят по берегам озера к юго-западу от часовни; там же чумные нетопыри и личинки-падальщики. Осторожно: самые крупные чумные псы – 56-го уровня, выманивайте по одному.\nСломанный меч лежит на земле к северо-западу от озера.",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His Ranger hunt (Rangers 59-60, in the north) is above you on this trip: leave it."] = "",

	-- Step 40: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Карликовые чумные псы и чумные нетопыри бродят по холмам к северу от места {area:2260}, среди них ползают личинки-падальщики; продвигайтесь на север к месту {area:2627}.",

	-- Step 41: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut."] = "Призрак {npc:11140} стоит у хижины ({area:2627}) в северо-западном углу; {npc:12384} сидит в хижине.",
	-- {npc:12384} Augustus the Touched
	["{npc:12384}, inside"] = "{npc:12384}, внутри",

	-- Step 42: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}: убивайте их по мере встречи",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound · Ziggurat Protectors = {npc:12262} Ziggurat Protector
	["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass.\nCareful: Ziggurat Protectors (58, elite) stand by the ziggurats east and north-east of the town: take the mounds nearer the town and stay clear of them."] = "Книга лежит в разрушенной таверне ({area:2627}); нежить в городе 54-56-го уровня, так что выманивайте по одному.\nБольшие термитники стоят по всем холмам к востоку от места {area:2627}. Используйте {item:15042} на каждом термитнике по пути.\nОсторожно: заступники зиккурата (58, элита) стоят у зиккуратов к востоку и северо-востоку от города: берите термитники ближе к городу и держитесь от них подальше.",
	-- {quest:5510} Minion's Scourgestones · {area:2627} Terrordale · {item:12846} Argent Dawn Commission
	["{quest:5510}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5510}: падают с нежити ({area:2627}), пока на вас надет {item:12846}",

	-- Step 43: Augustus the Touched
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Keep the termites: {npc:11615} at the {area:152} takes them on this guide's ride back west."] = "",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: убивайте их по пути",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the Monstrous Plaguebats up to 58: take the 57s one at a time and leave the 58s."] = "",

	-- Step 45: Eastern Plaguelands: kill these as you meet them
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Череп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудовищ.",
	["Underwater"] = "Под водой",

	-- Step 46: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Езжайте на юг по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.\nЕсли в журнале есть задание {quest:5211} (от {npc:11063} в начале этого гайда), воины Плети вокруг города оставляют духов Дарроушира: поговорите с каждым, чтобы освободить его. Освободите их до того, как возьметесь за {item:15447}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Освободите духов Дарроушира: поговорите с ними",

	-- Step 47: Carlin Redpath
	-- {area:2268} Light's Hope Chapel
	["Ride east along the road to {area:2268}."] = "",

	-- Step 48: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride back west along the road to the {area:2260}."] = "",

	-- Step 49: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride north-west to {npc:1855}'s hut by the {area:2619} and hear him out."] = "",

	-- Step 50: Undercroft
	-- {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft · {area:2260} Marris Stead
	["{npc:11886} lurks in the {area:2261}, the crypt just south of the {area:2260}.\nCareful: about four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 51: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Back north-west to {npc:1855}'s hut."] = "",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next errand, Of Lost Honor, leads into the Mossflayer trolls (57-59) of the far north-east: leave it."] = "",

	-- Step 52: Kirsta Deepshadow
	-- {npc:1855} Tirion Fordring · {zone:1422} Western Plaguelands · {npc:11610} Kirsta Deepshadow · {area:192} Northridge Lumber Camp · {area:152} The Bulwark
	["Ride west from {npc:1855}'s hut into the {zone:1422}: {npc:11610} hides on the hill north-east of the {area:192}, on the way to the {area:152}."] = "",
	-- {npc:11615} Mickey Levine · {area:152} The Bulwark
	["Her Scarlets wait until {npc:11615} has given you the termite barrel at the {area:152}: the barrel goes down in the same lumber mill."] = "",

	-- Step 54: The Bulwark
	-- {area:152} The Bulwark
	["On west to the {area:152}."] = "",

	-- Step 56: High Executor Derrington
	-- {area:152} The Bulwark · {quest:838} Scholomance · {quest:964} Skeletal Fragments · {area:201} Gahrron's Withering
	["Under 55 on the first {area:152} stop? Derrington's {quest:838} is offered now: Dithers' {quest:964} come from the skeletons on the ride back west from {area:201}."] = "",

	-- Step 58: Scarlet Crusade
	["Scarlet Crusade"] = "Алый орден",
	-- {area:192} Northridge Lumber Camp · {npc:11615} Mickey Levine · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	["Back north-east to the {area:192}: knights and magi work the camp, the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "",

	-- Step 60: Radley and Durgen
	["Radley and Durgen"] = "Рэдли и Дурген",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 61: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11610}'s last errand looks over {area:190}, among Scarlets of 58-60: leave it."] = "",

	-- Step 62: Target: Gahrron's Withering
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south-east to {area:201}, the farm under the eastern hills: {npc:11078} (58) guards its cauldron. Kill him for the key, then use the cauldron.\nCareful: Soulwrath is about two levels over you here: clear the ghouls around the cauldron first, start at full health and use your cooldowns on him."] = "",

	-- Step 63: Skeletal Fragments
	-- {area:200} Dalson's Tears · {area:199} Felstone Field
	["On the ride back west, the skeletons on the fields around {area:200} and {area:199} (50-53) drop the fragments."] = "",

	-- Step 64: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "",

	-- Step 66: Class trainer
	["Class trainer"] = "Учитель классовых навыков",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Train before the flight."] = "",

	-- Step 67: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- {area:1638} Thunder Bluff · {quest:1000} The New Frontier · {zone:1452} Winterspring · {quest:1123} Rabine Saturna · {zone:1450} Moonglade · {zone:1451} Silithus
	["Only if {area:1638}'s {quest:1000} is still open for you (the {zone:1452} guide's stop offers it from level 54): it opens {quest:1123} in {zone:1450} and her {zone:1451} chain, so fly there first."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 68: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Летите сюда: {area:431}",
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop (Mages teleport). Then the flight master."] = "",

	-- Step 69: Fly to Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:152} The Bulwark
	["Hearth to {zone:1454} from the {area:152}: the Hearthstone is still bound there from the previous guide's {zone:1454} stop. Then the flight master."] = "",

	-- Step 70: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033} (друиды) обучает здесь: {area:1639}, {npc:246344} (паладины) – тоже в городе.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} ({area:1639}); {npc:246344}",

	-- Step 71: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {area:1641} Hunter Rise
	["{npc:10881} stands on {area:1641}."] = "",

	-- Step 72: Arch Druid Hamuul Runetotem
	-- {area:1639} Elder Rise
	["Hamuul is on {area:1639}."] = "",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} is in {zone:1450}, later in this guide."] = "",

	-- Step 73: Fly to Splintertree Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Распорядитель полетов: {zone:1456}",

	-- Step 74: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "",
	-- {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "",
	-- {npc:10922} Greta Mosshoof · {zone:1413} Barrens
	["{npc:10922}: the Cleansed Water from Islen in the {zone:1413}"] = "",

	-- Step 75: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in linked groups, many with stuns: pull them one group at a time."] = "",

	-- Step 76: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Обратно на юг к Святилищу, недалеко.",

	-- Step 77: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} (57) wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9529} Maybess Riverbreeze
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["Corrupted Soul Shards from the cultists, for {npc:9529}' Salve via Hunting"] = "",

	-- Step 78: A Strange Red Key
	-- {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Enforcers = {npc:7114} Jaedenar Enforcer
	["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "Выпал предмет {item:13140}: его иногда носят джеденарские головорезы, ткачи тьмы, чернокнижники и легионеры Оплота Теней. Используйте его, чтобы начать задание, а на выходе освободите NPC {npc:11018} из клетки в южном конце пещеры.",

	-- Step 79: Captured Arko'narin
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, below ground"] = "{npc:11016}, под землей",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}: lead her out of {area:1770}"] = "",

	-- Step 80: Rescue From Jaedenar
	-- {npc:11018} Arko'narin · {npc:11019} Jessir Moonbow · {area:2479} Emerald Sanctuary
	["Lead {npc:11018} out through the cave: she fights beside you, and the cultists you didn't clear on the way in come at you both. {npc:11019} takes her report at the {area:2479}, next."] = "",
	-- {area:1770} Shadow Hold
	["out of {area:1770}, at its mouth"] = "",

	-- Step 81: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["Back south to the Sanctuary: {npc:9529} takes the shards on the west side of the camp."] = "",

	-- Step 83: Jessir Moonbow
	-- {npc:11019} Jessir Moonbow · {npc:11018} Arko'narin
	["{npc:11019}, at the Sanctuary's east side, takes {npc:11018}'s report."] = "",
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {area:1763} Jaedenar · {zone:1448} Felwood
	["{npc:11019}: {npc:9518}, in {area:1763}, on the last guide's ride north through {zone:1448}"] = "",

	-- Step 84: Deadwood Cauldron
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	-- was: ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Езжайте на север по дороге. Котел стоит здесь: {area:1762}, чуть к юго-западу от места {area:1769}; фурболги Мертвого Леса там враждебны."
	["Ride north up the whole {zone:1448} road, past {area:1997}. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 85: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {area:1769} Timbermaw Hold · {npc:11558} Kernda · {zone:1448} Felwood
	["Only if a {quest:8471} dropped for you and you are Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): {npc:11558} waits at the {zone:1448} entrance of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 87: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {quest:5527} A Reliquary of Purity · {area:2577} Dire Maul
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}.\n{npc:11801} offers {quest:5527} only after you have been inside {area:2577} once: if he doesn't offer it, carry on without it."] = "",

	-- Step 88: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Оба задания ведут в край {zone:1451}: сохраните их.",

	-- Step 90: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["From the tunnel's {zone:1452} exit, ride south to {area:2246}."] = "От выхода из туннеля в зону {zone:1452} езжайте на юг: {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086} – здесь: {zone:1448}, в следующий раз: сохраните задание.",

	-- Step 91: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Луноподобные совухи",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Езжайте на восток сюда: {area:2255} и дальше на север; луноподобные совухи бродят по южным склонам ({area:2241}). Осторожно: они 57-58-го уровня, выманивайте по одному.\nОсторожно: Hailspite, элитные противники 60-го уровня, собираются на снежных полях к юго-востоку от места {area:2255}, где тоже бродят несколько луноподобных совух: держитесь склонов к северу от городка.",

	-- Step 92: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Нетронутые рога йети",
	-- {area:2255} Everlook
	["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "Рога для Уми, взятые при прошлой остановке ({area:2255}): холмы йети начинаются чуть к юго-востоку от места {area:2255}. Рога падают только с матриархов и патриархов, а патриархи бывают 58-го уровня: выманивайте по одному.",

	-- Step 93: Umi Rumplesnicker
	-- {area:976} Gadgetzan · {area:2255} Everlook · {zone:2482} Mount Hyjal · {zone:1451} Silithus
	["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it. {zone:2482} is next: its way in starts here in {area:2255}; {area:976}, Linken's sword and {zone:1451} follow it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Рваный свиток лежит у входа сюда: {area:2261} – склеп к югу от места {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Назад через туннель к выходу ({area:618}), затем на юг сюда: {area:2246}.",
	-- ["Back through the tunnel and take the {zone:1452} exit: {npc:11556} stands right where it comes out."] = "Назад через туннель к выходу ({zone:1452}): {npc:11556} стоит прямо там, где он выходит наружу.",
	-- ["Back to {area:1638}"] = "Назад: {area:1638}",
	-- ["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Выпейте {item:11243} на кладбище чуть к востоку от места {area:976}: он вас убьет, и только в облике призрака можно увидеть {npc:9299} – в скальной расщелине в холмах прямо к северу от кладбища. Поговорите с ним там, затем бегите обратно к телу и воскресните: приметное надгробие, к которому он вас отправит, стоит на том же кладбище.",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Летите сюда: {zone:1458}, садитесь на дирижабль ({zone:1454}) и летите дальше сюда: {area:1638}.",
	-- ["Fly to {area:1099}"] = "Летите сюда: {area:1099}",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Летите сюда: {area:1099}. Гнезда гиппогрифов – на юге края {zone:1444}; в каждом есть яйцо для машины ({object:142071}).",
	-- ["Fly to {area:1997}"] = "Летите сюда: {area:1997}",
	-- ["Fly to {area:541}"] = "Летите сюда: {area:541}",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Летите сюда: {area:541}, затем езжайте на юго-запад через Ун'Горо к перевалу в край {zone:1451}. Следующее руководство начинается здесь: {area:3077}, у выхода с перевала.",
	-- ["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Бесноватые чумные псы и чудовищные чумные нетопыри бродят по полям вокруг мест {area:2272} и {area:2271}, к югу от места {area:2273}.",
	-- ["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "Бесноватые чумные псы бродят по полям вокруг мест {area:2272} и {area:2271}, к югу от места {area:2273}; пагубные нетопыри летают над полями севера, а чудовищные чумные нетопыри – вокруг мест {area:2272} и {area:2271}. Осторожно: псы 57-58-го уровня, а самые крупные чудовищные чумные нетопыри – 58-го: выманивайте по одному.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Пройдите через место {area:1769} и сверните в ответвление туннеля ({area:493}). {npc:11801} – здесь: {area:2361}.",
	-- ["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Пройдите через место {area:1769} и сверните в ответвление туннеля ({zone:1450}). {npc:11801} – здесь: {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Хамейя прячется среди троллей племени Моходеров ({area:2273}) в северо-восточном углу.",
	-- ["Hameya's mound"] = "Курган Хамейи",
	-- ["Hameya's scroll"] = "Свиток Хамейи",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "Вернитесь камнем возвращения в город {zone:1454}: он все еще привязан там с гайда по зоне {zone:1447} (маги – телепортом). Затем к распорядителю полетов.",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "Вернитесь камнем возвращения в город {zone:1454}: он все еще привязан там с гайда по зоне {zone:1447} (маги – телепортом). Обучитесь перед полетом.",
	-- ["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "Вернитесь камнем возвращения в город {zone:1454}: он все еще привязан там с гайда по зоне {zone:1447}. Затем к распорядителю полетов.",
	-- ["Hippogryph eggs"] = "Яйца гиппогрифов",
	-- ["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "Внутри: {quest:4493}, если вы взяли его в городе {zone:1454} во время гайда по зоне {zone:1447}",
	-- ["Keep the termites: {npc:11615} at the {area:813} takes them on the next guide's ride into the {zone:1422}."] = "Сохраните термитов: {npc:11615} ({area:813}) примет их во время поездки в край {zone:1422} в следующем гайде.",
	-- ["Level 56"] = "Уровень 56",
	-- ["On to {zone:1451}"] = "Дальше: {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Ориентир: {area:1641}. Держите в сумках шерсть, шелковый материал и магическую ткань.",
	-- ["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Только если у вас выпал предмет {quest:8471}: {npc:11558} ждет у входа ({area:1769}) со стороны края {zone:1448} и говорит с вами только при нейтральном отношении Древобрюхов.",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "Только если у вас еще есть задание {quest:2741}: езжайте на юг от места {area:1099}; гнезда гиппогрифов – на юге края {zone:1444}, в каждом есть яйцо для яйцемата.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Чумные псы и карликовые чумные псы бродят по берегам озера к юго-западу от часовни.",
	-- ["Ride east out of the {area:1497} along the road; the {area:152} guards the way into the {area:28}."] = "Езжайте на восток от места {area:1497} по дороге; {area:152} охраняет проход сюда: {area:28}.",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Езжайте на восток сюда: {area:2255} и дальше на север; луноподобные совухи бродят по южным склонам ({area:2241}). Выманивайте по одному.\nОсторожно: Hailspite, элитные противники 60-го уровня, собираются на снежных полях к юго-востоку от места {area:2255}, где тоже бродят несколько луноподобных совух: держитесь склонов к северу от городка.",
	-- ["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Езжайте на север по дороге. Котел стоит здесь: {area:1762}, чуть к юго-западу от места {area:1769}; фурболги Мертвого Леса там враждебны.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "Езжайте на юг от дома по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Езжайте на юг от дома по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.\nЕсли в журнале есть задание {quest:5211} (от {npc:11063} в конце руководства по Ун'Горо), воины Плети вокруг города оставляют духов Дарроушира: поговорите с каждым, чтобы освободить его. Освободите их до того, как возьметесь за {item:15447}.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Езжайте на юг от дома по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.\nЕсли в журнале есть задание {quest:5211} (от {npc:11063} в начале этого руководства), воины Плети вокруг города оставляют духов Дарроушира: поговорите с каждым, чтобы освободить его. Освободите их до того, как возьметесь за {item:15447}.",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Езжайте на юг от места {area:1099}: гнезда гиппогрифов – на юге края {zone:1444}; в каждом есть яйцо для машины ({object:142071}).",
	-- ["Ride west to the {area:2260}."] = "Езжайте на запад сюда: {area:2260}.",
	-- ["Scare {npc:7583} with {item:12928}"] = "Напугайте {npc:7583} с помощью предмета {item:12928}",
	-- ["Sword of Marduk"] = "Меч Мардука",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Летопись лежит среди заплесневелых фолиантов в ратуше Андорала; открывайте их, пока не найдете нужный.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Следопыты, разведчицы дорог и лесники – высшие эльфы – охраняют дом у места {area:2275}; реестр лежит внутри. Следопыты – до 60-го уровня: выманивайте по одному. По пути над полями летают пагубные нетопыри.\nЧереп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудищ.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Перевал из Ун'Горо выходит сюда: {area:3077} – кладбище на северо-востоке края {zone:1451}. {npc:13220} стоит среди могил.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "Сломанный меч лежит на земле к северо-западу от озера.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Череп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудовищ.",
	-- ["The western hills"] = "Западные холмы",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "Машина: {object:142071}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} – сразу за местом {area:2261}.",
	-- ["Top up here to level 56 before the Frenzied Plaguehounds of Northdale (57-58): the Noxious Plaguebats (54-56) over the fields on the way east are at your level, and {npc:11878} wants twenty of them. Or, with a group, run the {area:1583} dungeon (Lower) instead."] = "Доберите здесь 56-й уровень перед бесноватыми чумными псами Нордейла (57-58): пагубные нетопыри (54-56) над полями по пути на восток как раз вашего уровня, и {npc:11878} просит двадцать из них. Или, с группой, пройдите вместо этого подземелье {area:1583} (нижнюю часть).",
	-- ["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it for later."] = "Третья шутка Уми нацелена на гоблинов ({area:976}, Ун'Горо и {area:2255}): сохраните ее на потом.",
	-- ["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Используйте игрушку {item:12928} на гоблинше {npc:7583} ({area:976}). {npc:10977} и {npc:10978} – позже по маршруту.",
	-- ["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- ["grind on {npc:8601}"] = "убивайте: {npc:8601}",
	-- ["keep it: the Rangers (59-60) wait for the next guide's second ride into the north"] = "сохраните его: следопыты (59-60) подождут второй поездки на север в следующем гайде",
	-- ["{area:2255} flight master"] = "Распорядитель полетов: {area:2255}",
	-- ["{area:976} flight master"] = "Распорядитель полетов: {area:976}",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880} ходит по месту {object:172982} и прилегающим улицам: ищите его по пути к башне распорядителя полетов; круг на карте – его маршрут.",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}: для NPC {npc:7776} ({quest:7492}), в конце этого руководства",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Призрак {npc:11140} стоит у хижины ({area:2627}) в северо-западном углу.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}) к северу от места {area:2261}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His {npc:8564} hunt, in the north of the zone, waits for the next guide's Plaguelands trip."] = "Защитник, посланный NPC {npc:15193}, занимает дом на ферме ({area:2260}) к северу от места {area:2261}. Его охота на следопытов ({npc:8564}) на севере зоны подождет поездки в Чумные земли в следующем гайде.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}).",
	-- ["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} стоит лагерем у дороги к месту {area:1336}, к югу от места {area:976}.",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} – призрак на кладбище чуть к северу от места {area:976}; подозрительное надгробие – к югу от него, за городской стеной.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Распорядитель полетов ({object:1661}) – в западной башне ({object:36078}), за стенами.",
	-- ["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} сдается {npc:8737}у в Ун'Горо: сохраните задание.",
	-- ["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Предметы для задания {quest:5168} – в Чумных землях, позже: сохраните его.",
}
