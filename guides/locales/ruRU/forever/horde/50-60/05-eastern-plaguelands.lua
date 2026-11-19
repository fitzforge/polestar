-- Russian (ruRU): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "В зону {zone:1423}",

	-- Step 2: Tirion Fordring
	-- {zone:1423} Eastern Plaguelands · {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east along the road into the {zone:1423}. {npc:1855} lives in a small house by the {area:2619}, just north of the road at the border; his three hunts are on this guide's ground."] = "Езжайте на восток по дороге в край {zone:1423}. {npc:1855} живет в маленьком доме у реки ({area:2619}), чуть к северу от дороги на границе; три его охоты проходят на территории этого гайда.",

	-- Step 4: Light's Hope Chapel
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {object:92525} Argent Dawn
	["Follow the road east from the {zone:1422}, over the river and across the whole {zone:1423}, to the {object:92525}'s chapel in the far east."] = "Следуйте по дороге на восток от края {zone:1422}, через реку и через весь край {zone:1423}, к часовне ({object:92525}) на крайнем востоке.",

	-- Step 5: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "Призрак {npc:10926} стоит в руинах ({area:2262}) на юго-западе.",

	-- Step 6: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "Голова куклы и две ее половинки лежат в домах вокруг NPC {npc:10926}; соедините их в сумке.",
	["Inside"] = "Внутри",

	-- Step 7: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}"] = "послание для NPC {npc:11063} ({area:2268})",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "Сохраните задание {quest:5152}: {npc:10927} живет здесь: {area:197} ({zone:1422}).",

	-- Step 8: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "Заэлдарр прячется чуть к западу от места {area:2262}.",
	["Below ground"] = "Под землей",

	-- Step 9: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Осторожно: {npc:10411} становится невидимым вне боя и призывает горгулий-камнекрылов, когда начинается бой. Их всего 3, и они возрождаются каждые 15 мин.",

	-- Step 10: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Назад: {area:2268}",
	-- {quest:5211} Defenders of Darrowshire · {area:2264} Corin's Crossing
	["{quest:5211}'s spirits come with the {area:2264} stop later in this guide: keep it."] = "Духи для задания {quest:5211} появятся при остановке здесь: {area:2264}, позже в этом руководстве: сохраните задание.",

	-- Step 11: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Летите сюда: {area:272}",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "Распорядитель полетов: {area:2268}",

	-- Step 12: To Sorrow Hill
	-- {area:197} Sorrow Hill
	["To {area:197}"] = "Сюда: {area:197}",

	-- Step 13: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "Езжайте на север по дороге от места {area:272}. Дом NPC {npc:10927} стоит у дороги ({area:197}), а памятник ({npc:10936}) – на кладбище за ним.",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}, наверху",

	-- Step 14: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Езжайте на северо-запад в Андорал. {npc:10667} ждет в разрушенной таверне в западной части города; скелеты внутри – 54-57-го уровня, так что держитесь краев.",
	["Upstairs"] = "Наверху",

	-- Step 15: The Annals of Darrowshire
	-- {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one.\nCareful: a {npc:10996}, a level 58-59 elite, can stand in Andorhal, as at many other spots of the {zone:1422}: give it room."] = "Летопись лежит среди заплесневелых фолиантов в ратуше Андорала; открывайте их, пока не найдете нужный.\nОсторожно: {npc:10996}, элита 58-59-го уровня, может стоять в Андорале, как и во многих других местах края {zone:1422}: держитесь от него подальше.",

	-- Step 17: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Летите сюда: {area:2268}",
	-- {area:272} Tarren Mill · {area:2268} Light's Hope Chapel
	["Ride back south to {area:272} and fly to {area:2268}."] = "Езжайте обратно на юг сюда: {area:272} и летите сюда: {area:2268}.",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Распорядитель полетов: {area:272}",

	-- Step 18: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Предметы для задания {quest:5168} – в Чумных землях, позже: сохраните его.",

	-- Step 19: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: убивайте их по пути",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground. Careful: the biggest Plaguehounds are 56, pull them one at a time.\nThe shattered sword lies on the ground north-west of the lake."] = "Чумные псы и их карлики бродят по берегам озера к юго-западу от часовни; там же чумные нетопыри и личинки-падальщики. Осторожно: самые крупные чумные псы – 56-го уровня, выманивайте по одному.\nСломанный меч лежит на земле к северо-западу от озера.",

	-- Step 20: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft · {npc:8564} Ranger
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}. His {npc:8564} hunt, in the north of the zone, waits for the next guide's Plaguelands trip."] = "Защитник, посланный NPC {npc:15193}, занимает дом на ферме ({area:2260}) к северу от места {area:2261}. Его охота на следопытов ({npc:8564}) на севере зоны подождет поездки в Чумные земли в следующем гайде.",
	-- plural, as words: Rangers = {npc:8564} Ranger
	["keep it: the Rangers (59-60) wait for the next guide's second ride into the north"] = "сохраните его: следопыты (59-60) подождут второй поездки на север в следующем гайде",

	-- Step 21: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Карликовые чумные псы и чумные нетопыри бродят по холмам к северу от места {area:2260}, среди них ползают личинки-падальщики; продвигайтесь на север к месту {area:2627}.",

	-- Step 22: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner; {npc:12384} sits inside the hut."] = "Призрак {npc:11140} стоит у хижины ({area:2627}) в северо-западном углу; {npc:12384} сидит в хижине.",
	-- {npc:12384} Augustus the Touched
	["{npc:12384}, inside"] = "{npc:12384}, внутри",

	-- Step 23: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}: убивайте их по мере встречи",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound · Ziggurat Protectors = {npc:12262} Ziggurat Protector
	["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass.\nCareful: Ziggurat Protectors (58, elite) stand by the ziggurats east and north-east of the town: take the mounds nearer the town and stay clear of them."] = "Книга лежит в разрушенной таверне ({area:2627}); нежить в городе 54-56-го уровня, так что выманивайте по одному.\nБольшие термитники стоят по всем холмам к востоку от места {area:2627}. Используйте {item:15042} на каждом термитнике по пути.\nОсторожно: заступники зиккурата (58, элита) стоят у зиккуратов к востоку и северо-востоку от города: берите термитники ближе к городу и держитесь от них подальше.",
	-- {quest:5510} Minion's Scourgestones · {area:2627} Terrordale · {item:12846} Argent Dawn Commission
	["{quest:5510}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5510}: падают с нежити ({area:2627}), пока на вас надет {item:12846}",

	-- Step 24: Augustus the Touched
	-- {npc:11615} Mickey Levine · {area:813} Bulwark · {zone:1422} Western Plaguelands
	["Keep the termites: {npc:11615} at the {area:813} takes them on the next guide's ride into the {zone:1422}."] = "Сохраните термитов: {npc:11615} ({area:813}) примет их во время поездки в край {zone:1422} в следующем гайде.",

	-- Step 25: Level 56
	["Level 56"] = "Уровень 56",
	-- {npc:11878} Nathanos Blightcaller · {area:1583} Blackrock Spire
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["Top up here to level 56 before the Frenzied Plaguehounds of Northdale (57-58): the Noxious Plaguebats (54-56) over the fields on the way east are at your level, and {npc:11878} wants twenty of them. Or, with a group, run the {area:1583} dungeon (Lower) instead."] = "Доберите здесь 56-й уровень перед бесноватыми чумными псами Нордейла (57-58): пагубные нетопыри (54-56) над полями по пути на восток как раз вашего уровня, и {npc:11878} просит двадцать из них. Или, с группой, пройдите вместо этого подземелье {area:1583} (нижнюю часть).",
	-- {npc:8601} Noxious Plaguebat
	["grind on {npc:8601}"] = "убивайте: {npc:8601}",

	-- Step 26: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: убивайте их по пути",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds share the fields around {area:2272} and {area:2271}, south of {area:2273}; Noxious Plaguebats fly over the fields of the north, and Monstrous Plaguebats around {area:2272} and {area:2271}. Careful: the hounds are 57-58 and the biggest Monstrous Plaguebats 58: pull them one at a time."] = "Бесноватые чумные псы бродят по полям вокруг мест {area:2272} и {area:2271}, к югу от места {area:2273}; пагубные нетопыри летают над полями севера, а чудовищные чумные нетопыри – вокруг мест {area:2272} и {area:2271}. Осторожно: псы 57-58-го уровня, а самые крупные чудовищные чумные нетопыри – 58-го: выманивайте по одному.",

	-- Step 27: Eastern Plaguelands: kill these as you meet them
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Череп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудовищ.",
	["Underwater"] = "Под водой",

	-- Step 28: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility · {quest:5211} Defenders of Darrowshire · {npc:11063} Carlin Redpath
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant · Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Ride south to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Езжайте на юг по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.\nЕсли в журнале есть задание {quest:5211} (от {npc:11063} в начале этого гайда), воины Плети вокруг города оставляют духов Дарроушира: поговорите с каждым, чтобы освободить его. Освободите их до того, как возьметесь за {item:15447}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Освободите духов Дарроушира: поговорите с ними",

	-- Step 29: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Езжайте на запад сюда: {area:2260}.",

	-- Step 31: Class trainer
	["Class trainer"] = "Учитель классовых навыков",
	-- {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Train before the flight."] = "Вернитесь камнем возвращения в город {zone:1454}: он все еще привязан там с гайда по зоне {zone:1447} (маги – телепортом). Обучитесь перед полетом.",

	-- Step 32: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "Летите сюда: {area:1997}",
	-- {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide (Mages teleport). Then the flight master."] = "Вернитесь камнем возвращения в город {zone:1454}: он все еще привязан там с гайда по зоне {zone:1447} (маги – телепортом). Затем к распорядителю полетов.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 33: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Hearth to {zone:1454}: the Hearthstone is still bound there from the {zone:1447} guide. Then the flight master."] = "Вернитесь камнем возвращения в город {zone:1454}: он все еще привязан там с гайда по зоне {zone:1447}. Затем к распорядителю полетов.",

	-- Step 34: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "{npc:3033} (друиды) обучает здесь: {area:1639}, {npc:246344} (паладины) – тоже в городе.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} ({area:1639}); {npc:246344}",

	-- Step 35: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Распорядитель полетов: {zone:1456}",

	-- Step 37: Deadwood Cauldron
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Езжайте на север по дороге. Котел стоит здесь: {area:1762}, чуть к юго-западу от места {area:1769}; фурболги Мертвого Леса там враждебны.",

	-- Step 38: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Только если у вас выпал предмет {quest:8471}: {npc:11558} ждет у входа ({area:1769}) со стороны края {zone:1448} и говорит с вами только при нейтральном отношении Древобрюхов.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 40: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Пройдите через место {area:1769} и сверните в ответвление туннеля ({zone:1450}). {npc:11801} – здесь: {area:2361}.",

	-- Step 41: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Оба задания ведут в край {zone:1451}: сохраните их.",

	-- Step 43: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["From the tunnel's {zone:1452} exit, ride south to {area:2246}."] = "От выхода из туннеля в зону {zone:1452} езжайте на юг: {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "{quest:5086} – здесь: {zone:1448}, в следующий раз: сохраните задание.",

	-- Step 44: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Луноподобные совухи",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Careful: they are 57-58: pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Езжайте на восток сюда: {area:2255} и дальше на север; луноподобные совухи бродят по южным склонам ({area:2241}). Осторожно: они 57-58-го уровня, выманивайте по одному.\nОсторожно: Hailspite, элитные противники 60-го уровня, собираются на снежных полях к юго-востоку от места {area:2255}, где тоже бродят несколько луноподобных совух: держитесь склонов к северу от городка.",

	-- Step 45: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Нетронутые рога йети",
	-- {area:2255} Everlook
	["Umi's horns, carried from your last {area:2255} stop: the yeti hills start just south-east of {area:2255}. Only Matriarchs and Patriarchs drop horns, and the Patriarchs reach 58: pull them one at a time."] = "Рога для Уми, взятые при прошлой остановке ({area:2255}): холмы йети начинаются чуть к юго-востоку от места {area:2255}. Рога падают только с матриархов и патриархов, а патриархи бывают 58-го уровня: выманивайте по одному.",

	-- Step 46: Umi Rumplesnicker
	-- {area:976} Gadgetzan · {area:2255} Everlook
	["Umi's third prank targets goblins in {area:976}, Un'Goro and {area:2255}: keep it for later."] = "Третья шутка Уми нацелена на гоблинов ({area:976}, Ун'Горо и {area:2255}): сохраните ее на потом.",

	-- Step 47: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Распорядитель полетов: {area:2255}",

	-- Step 48: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Выпейте {item:11243} на кладбище чуть к востоку от места {area:976}: он вас убьет, и только в облике призрака можно увидеть {npc:9299} – в скальной расщелине в холмах прямо к северу от кладбища. Поговорите с ним там, затем бегите обратно к телу и воскресните: приметное надгробие, к которому он вас отправит, стоит на том же кладбище.",

	-- Step 49: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Используйте игрушку {item:12928} на гоблинше {npc:7583} ({area:976}). {npc:10977} и {npc:10978} – позже по маршруту.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Напугайте {npc:7583} с помощью предмета {item:12928}",

	-- Step 50: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "Внутри: {quest:4493}, если вы взяли его в городе {zone:1454} во время гайда по зоне {zone:1447}",

	-- Step 52: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} сдается {npc:8737}у в Ун'Горо: сохраните задание.",

	-- Step 53: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} стоит лагерем у дороги к месту {area:1336}, к югу от места {area:976}.",

	-- Step 54: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Летите сюда: {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Распорядитель полетов: {area:976}",

	-- Step 55: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "",
	-- {quest:3941} A Gnome's Assistance · {npc:9117} J.D. Collie · {area:541} Marshal's Refuge
	["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "",

	-- Step 56: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Перевал из Ун'Горо выходит сюда: {area:3077} – кладбище на северо-востоке края {zone:1451}. {npc:13220} стоит среди могил.",

	-- Step 57: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {quest:1123} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Рваный свиток лежит у входа сюда: {area:2261} – склеп к югу от места {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Назад через туннель к выходу ({area:618}), затем на юг сюда: {area:2246}.",
	-- ["Back through the tunnel and take the {zone:1452} exit: {npc:11556} stands right where it comes out."] = "Назад через туннель к выходу ({zone:1452}): {npc:11556} стоит прямо там, где он выходит наружу.",
	-- ["Back to {area:1638}"] = "Назад: {area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Летите сюда: {zone:1458}, садитесь на дирижабль ({zone:1454}) и летите дальше сюда: {area:1638}.",
	-- ["Fly to {area:1099}"] = "Летите сюда: {area:1099}",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Летите сюда: {area:1099}. Гнезда гиппогрифов – на юге края {zone:1444}; в каждом есть яйцо для машины ({object:142071}).",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Летите сюда: {area:541}, затем езжайте на юго-запад через Ун'Горо к перевалу в край {zone:1451}. Следующее руководство начинается здесь: {area:3077}, у выхода с перевала.",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Бесноватые чумные псы и чудовищные чумные нетопыри бродят по полям вокруг мест {area:2272} и {area:2271}, к югу от места {area:2273}.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Пройдите через место {area:1769} и сверните в ответвление туннеля ({area:493}). {npc:11801} – здесь: {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Хамейя прячется среди троллей племени Моходеров ({area:2273}) в северо-восточном углу.",
	-- ["Hameya's mound"] = "Курган Хамейи",
	-- ["Hameya's scroll"] = "Свиток Хамейи",
	-- ["Hippogryph eggs"] = "Яйца гиппогрифов",
	-- ["On to {zone:1451}"] = "Дальше: {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Ориентир: {area:1641}. Держите в сумках шерсть, шелковый материал и магическую ткань.",
	-- ["Only if you still carry {quest:2741}: ride south from {area:1099}; the hippogryph nests are in the south of {zone:1444}, each holds an egg for the Egg-O-Matic."] = "Только если у вас еще есть задание {quest:2741}: езжайте на юг от места {area:1099}; гнезда гиппогрифов – на юге края {zone:1444}, в каждом есть яйцо для яйцемата.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Чумные псы и карликовые чумные псы бродят по берегам озера к юго-западу от часовни.",
	-- ["Ride east out of the {area:1497} along the road; the {area:152} guards the way into the {area:28}."] = "Езжайте на восток от места {area:1497} по дороге; {area:152} охраняет проход сюда: {area:28}.",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time.\nCareful: Hailspite, level 60 elites, gather in the snowfields south-east of {area:2255}, where a few Moontouched Owlbeasts roam too: stay on the slopes north of town."] = "Езжайте на восток сюда: {area:2255} и дальше на север; луноподобные совухи бродят по южным склонам ({area:2241}). Выманивайте по одному.\nОсторожно: Hailspite, элитные противники 60-го уровня, собираются на снежных полях к юго-востоку от места {area:2255}, где тоже бродят несколько луноподобных совух: держитесь склонов к северу от городка.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "Езжайте на юг от дома по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the end of the Un'Goro guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Езжайте на юг от дома по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.\nЕсли в журнале есть задание {quest:5211} (от {npc:11063} в конце руководства по Ун'Горо), воины Плети вокруг города оставляют духов Дарроушира: поговорите с каждым, чтобы освободить его. Освободите их до того, как возьметесь за {item:15447}.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk.\nWith {quest:5211} in your log (from {npc:11063} at the start of this guide), the Scourge around the town leave Darrowshire Spirits: talk to each one to free it. Free them before you start on the {item:15447}."] = "Езжайте на юг от дома по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.\nЕсли в журнале есть задание {quest:5211} (от {npc:11063} в начале этого руководства), воины Плети вокруг города оставляют духов Дарроушира: поговорите с каждым, чтобы освободить его. Освободите их до того, как возьметесь за {item:15447}.",
	-- ["Ride south from {area:1099}: the hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Езжайте на юг от места {area:1099}: гнезда гиппогрифов – на юге края {zone:1444}; в каждом есть яйцо для машины ({object:142071}).",
	-- ["Sword of Marduk"] = "Меч Мардука",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Летопись лежит среди заплесневелых фолиантов в ратуше Андорала; открывайте их, пока не найдете нужный.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Следопыты, разведчицы дорог и лесники – высшие эльфы – охраняют дом у места {area:2275}; реестр лежит внутри. Следопыты – до 60-го уровня: выманивайте по одному. По пути над полями летают пагубные нетопыри.\nЧереп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудищ.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "Сломанный меч лежит на земле к северо-западу от озера.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Череп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудовищ.",
	-- ["The western hills"] = "Западные холмы",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:142071} machine"] = "Машина: {object:142071}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} – сразу за местом {area:2261}.",
	-- ["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.",
	-- ["{npc:10880} walks the {object:172982} and the streets off it: look for him on the way to the flight master's tower; the circle on the map is his walk."] = "{npc:10880} ходит по месту {object:172982} и прилегающим улицам: ищите его по пути к башне распорядителя полетов; круг на карте – его маршрут.",
	-- ["{npc:10880}: for {npc:7776} at {quest:7492}, at the end of this guide"] = "{npc:10880}: для NPC {npc:7776} ({quest:7492}), в конце этого руководства",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Призрак {npc:11140} стоит у хижины ({area:2627}) в северо-западном углу.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}) к северу от места {area:2261}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}).",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} – призрак на кладбище чуть к северу от места {area:976}; подозрительное надгробие – к югу от него, за городской стеной.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Распорядитель полетов ({object:1661}) – в западной башне ({object:36078}), за стенами.",
}
