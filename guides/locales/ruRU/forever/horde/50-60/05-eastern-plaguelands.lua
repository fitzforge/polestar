-- Russian (ruRU): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Летите сюда: {area:2268}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Предметы для задания {quest:5168} – в Чумных землях, позже: сохраните его.",

	-- Step 3: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "",

	-- Step 4: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}) к северу от места {area:2261}.",

	-- Step 5: Eastern Plaguelands: kill these as you meet them
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Карликовые чумные псы и чумные нетопыри бродят по холмам к северу от места {area:2260}, среди них ползают личинки-падальщики; продвигайтесь на север к месту {area:2627}.",

	-- Step 6: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Призрак {npc:11140} стоит у хижины ({area:2627}) в северо-западном углу.",
	["Inside"] = "Внутри",

	-- Step 7: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "",
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Бесноватые чумные псы и чудовищные чумные нетопыри бродят по полям вокруг мест {area:2272} и {area:2271}, к югу от места {area:2273}.",

	-- Step 8: Eastern Plaguelands: kill these as you meet them
	-- {area:2275} Northpass Tower · {area:2622} Pestilent Scar
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Blighted Horrors = {npc:8521} Blighted Horror
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "",
	["Underwater"] = "",

	-- Step 9: Pathstrider
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "",

	-- Step 10: Corin's Crossing
	-- {area:2264} Corin's Crossing · {item:15447} Living Rot · {item:15454} Mortar and Pestle · {spell:10228} Greater Invisibility
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant
	["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "Езжайте на юг от дома по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.",

	-- Step 11: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Езжайте на запад сюда: {area:2260}.",

	-- Step 13: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 15: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "",

	-- Step 16: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 17: Orgrimmar
	-- {npc:10880} Warcaller Gorlach · {npc:7776} Talo Thornhoof · {quest:7492} Camp Mojache
	["{npc:10880}, outside the front gate on the way in: for {npc:7776} at {quest:7492}, at the end of this guide"] = "",

	-- Step 18: Fly to Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["Fly to {area:1997}"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 19: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",

	-- Step 20: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} ({area:1639}); {npc:246344}",

	-- Step 21: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 23: Deadwood Cauldron
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "",

	-- Step 24: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Только если у вас выпал предмет {quest:8471}: {npc:11558} ждет у входа ({area:1769}) со стороны края {zone:1448} и говорит с вами только при нейтральном отношении Древобрюхов.",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 26: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Пройдите через место {area:1769} и сверните в ответвление туннеля ({zone:1450}). {npc:11801} – здесь: {area:2361}.",

	-- Step 27: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 28: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Оба задания ведут в край {zone:1451}: сохраните их.",

	-- Step 30: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Назад через туннель к выходу ({zone:1452}), затем на юг сюда: {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it."] = "",

	-- Step 31: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Луноподобные совухи",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Езжайте на восток сюда: {area:2255} и дальше на север; луноподобные совухи бродят по южным склонам ({area:2241}). Выманивайте по одному.",

	-- Step 33: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 34: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} – призрак на кладбище чуть к северу от места {area:976}; подозрительное надгробие – к югу от него, за городской стеной.",

	-- Step 35: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Используйте игрушку {item:12928} на гоблинше {npc:7583} ({area:976}). {npc:10977} и {npc:10978} – позже по маршруту.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "",

	-- Step 36: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "Машина: {object:142071}",

	-- Step 37: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} сдается {npc:8737}у в Ун'Горо: сохраните задание.",

	-- Step 38: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} стоит лагерем у дороги к месту {area:1336}, к югу от места {area:976}.",

	-- Step 39: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Летите сюда: {area:1099}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 40: Camp Mojache
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}, a few steps from the flight master"] = "",
	-- {area:2577} Dire Maul
	["His next task is for the {area:2577} dungeon: leave it."] = "",

	-- Step 41: Ruins of Isildien
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Летите сюда: {area:1099}. Гнезда гиппогрифов – на юге края {zone:1444}; в каждом есть яйцо для машины ({object:142071}).",

	-- Step 42: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 43: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. {npc:9997}'s work is in Un'Goro on the next guide's way back north."] = "",
	-- {quest:3941} A Gnome's Assistance · {npc:9117} J.D. Collie · {area:541} Marshal's Refuge
	["{quest:3941} goes to {npc:9117} in the cave here, on the next guide's return to {area:541}: keep it."] = "",

	-- Step 44: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Перевал из Ун'Горо выходит сюда: {area:3077} – кладбище на северо-востоке края {zone:1451}. {npc:13220} стоит среди могил.",

	-- Step 45: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {quest:1123} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {quest:1123} sits inside one of the ruined houses."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Рваный свиток лежит у входа сюда: {area:2261} – склеп к югу от места {area:2260}.",
	-- ["Back through the tunnel and take the {area:618} exit, then ride south to {area:2246}."] = "Назад через туннель к выходу ({area:618}), затем на юг сюда: {area:2246}.",
	-- ["Back to {area:1638}"] = "Назад: {area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Летите сюда: {zone:1458}, садитесь на дирижабль ({zone:1454}) и летите дальше сюда: {area:1638}.",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Летите сюда: {area:541}, затем езжайте на юго-запад через Ун'Горо к перевалу в край {zone:1451}. Следующее руководство начинается здесь: {area:3077}, у выхода с перевала.",
	-- ["Go through {area:1769} and take the {area:493} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Пройдите через место {area:1769} и сверните в ответвление туннеля ({area:493}). {npc:11801} – здесь: {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Хамейя прячется среди троллей племени Моходеров ({area:2273}) в северо-восточном углу.",
	-- ["Hameya's mound"] = "Курган Хамейи",
	-- ["Hameya's scroll"] = "Свиток Хамейи",
	-- ["Hippogryph eggs"] = "Яйца гиппогрифов",
	-- ["On to {zone:1451}"] = "Дальше: {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Ориентир: {area:1641}. Держите в сумках шерсть, шелковый материал и магическую ткань.",
	-- ["Only if you found a {item:12820} flask in {area:618}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Только если вы нашли флягу ({item:12820}) в крае {area:618}: езжайте на север по дороге. Котел стоит здесь: {area:1762}, чуть к юго-западу от места {area:1769}; фурболги Мертвого Леса там враждебны.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Чумные псы и карликовые чумные псы бродят по берегам озера к юго-западу от часовни.",
	-- ["Ride east out of the {area:1497} along the road; the {area:152} guards the way into the {area:28}."] = "Езжайте на восток от места {area:1497} по дороге; {area:152} охраняет проход сюда: {area:28}.",
	-- ["Sword of Marduk"] = "Меч Мардука",
	-- ["The flight from {area:1997} lands in {zone:1456}: {npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "Полет из места {area:1997} приводит сюда: {zone:1456}. {npc:3033} (друиды) обучает здесь: {area:1639}, {npc:246344} (паладины) – тоже в городе.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Следопыты, разведчицы дорог и лесники – высшие эльфы – охраняют дом у места {area:2275}; реестр лежит внутри. Следопыты – до 60-го уровня: выманивайте по одному. По пути над полями летают пагубные нетопыри.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "Сломанный меч лежит на земле к северо-западу от озера.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Череп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудовищ.",
	-- ["The western hills"] = "Западные холмы",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} – сразу за местом {area:2261}.",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}).",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Распорядитель полетов ({object:1661}) – в западной башне ({object:36078}), за стенами.",
	-- ["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} – здесь: {zone:1448}, в следующий раз: сохраните задание, если оно есть.",
}
