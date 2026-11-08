-- Russian (ruRU): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: The Bulwark
	["The Bulwark"] = "",
	-- {zone:1458} Undercity · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the Bulwark guards the way into the {zone:1422}."] = "",

	-- Step 4: Felstone Field
	["Felstone Field"] = "",
	-- {npc:10778} Janice Felstone · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the Bulwark. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "",
	["Upstairs"] = "",

	-- Step 5: Fly to Light's Hope Chapel
	["Fly to Light's Hope Chapel"] = "",
	-- {object:1772} Tarren Mill (no name in this language: may be words)
	["{object:1772} flight master"] = "",

	-- Step 6: Light's Hope Chapel
	["Light's Hope Chapel"] = "",
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Предметы для задания {quest:5168} – в Чумных землях, позже: сохраните его.",

	-- Step 7: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel; Plaguebats and Carrion Grubs share the ground.\nThe shattered sword lies on the ground north-west of the lake."] = "",

	-- Step 8: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen
	["{npc:15193}'s champion holds the Marris Stead farmhouse, north of the Undercroft."] = "",

	-- Step 9: Eastern Plaguelands: kill these as you meet them
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the Marris Stead, Carrion Grubs crawl among them; work north toward Terrordale."] = "",

	-- Step 10: Egan
	-- {npc:11140} Egan
	["{npc:11140} the ghost stands by a hut in Terrordale, in the north-west corner."] = "",
	["Inside"] = "Внутри",

	-- Step 11: Plaguewood: kill these as you meet them
	["Plaguewood: kill these as you meet them"] = "",
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around Northdale and Eastwall Tower, south of Zul'Mashar."] = "",

	-- Step 12: Eastern Plaguelands: kill these as you meet them
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat · Blighted Horrors = {npc:8521} Blighted Horror
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by Northpass Tower; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way.\nThe skull sits in the Pestilent Scar, among Blighted Horrors and Plague Monstrosities."] = "",
	["Underwater"] = "",

	-- Step 13: Pathstrider
	-- {npc:8565} Pathstrider
	["{npc:8565} walks around Quel'Lithien Lodge: look inside the circle on the map"] = "",

	-- Step 14: Corin's Crossing
	-- {object:176970} Corin's Crossing (no name in this language: may be words) · {item:15447} Living Rot · {item:15454} Mortar and Pestle
	-- plural, as words: Unseen Servants = {npc:8538} Unseen Servant
	["Ride south from the lodge to {object:176970}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with Greater Invisibility. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "",

	-- Step 15: Nathanos Blightcaller
	["Ride west to the Marris Stead."] = "",

	-- Step 17: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: most classes solo it at level 62, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 19: Fly to Undercity
	-- {zone:1458} Undercity
	["Fly to {zone:1458}"] = "",
	["Light's Hope Chapel flight master"] = "",

	-- Step 20: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 22: Fly to Bloodvenom Post
	["Fly to Bloodvenom Post"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 23: Fly to Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Fly to {zone:1456}"] = "",

	-- Step 24: Thunder Bluff
	-- {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {npc:246344} Alodan the Hopeful
	["{npc:3033} (Druids) trains on {object:50507}, {npc:246344} (Paladins) in the city too."] = "",
	-- {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {object:50507}; {npc:246344}"] = "",

	-- Step 25: Fly to Bloodvenom Post
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 27: Deadwood Cauldron
	-- {item:12820} Winterfall Firewater · {zone:1452} Winterspring
	["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in Felpaw Village, just south-west of Timbermaw Hold; the Deadwood furbolgs there are hostile."] = "",

	-- Step 28: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of Timbermaw Hold, and speaks to you only at Neutral with the Timbermaw."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 30: Rabine Saturna
	-- {zone:1450} Moonglade · {npc:11801} Rabine Saturna
	["Go through Timbermaw Hold and take the {zone:1450} branch of the tunnel. {npc:11801} is in Nighthaven."] = "",

	-- Step 31: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 32: Rabine Saturna
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Оба задания ведут в край {zone:1451}: сохраните их.",

	-- Step 34: Donova Snowden
	-- {zone:1452} Winterspring
	["Back through the tunnel and take the {zone:1452} exit, then ride south to Frostfire Hot Springs."] = "",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} – здесь: {zone:1448}, в следующий раз: сохраните задание, если оно есть.",

	-- Step 35: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Луноподобные совухи",
	-- {object:177140} Frostsaber Rock (no name in this language: may be words)
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to Everlook and north out of it; the Moontouched Owlbeasts roam the hills of {object:177140}'s southern slopes. Pull them one at a time."] = "",

	-- Step 37: Fly to Gadgetzan
	["Fly to Gadgetzan"] = "",
	["Everlook flight master"] = "",

	-- Step 38: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} is a ghost at the graveyard just north of Gadgetzan; the Conspicuous Gravestone is south of it, outside the town wall."] = "",

	-- Step 39: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in Gadgetzan. {npc:10977} and {npc:10978} are scared later in the route."] = "",

	-- Step 40: Gadgetzan
	["Gadgetzan"] = "",
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "Машина: {object:142071}",

	-- Step 41: Gaeriyan
	-- {quest:3914} Linken's Sword
	["{quest:3914} goes back to Linken in Un'Goro: keep it."] = "{quest:3914} сдается Линкену в Ун'Горо: сохраните задание.",

	-- Step 42: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker
	["{npc:7771} camps by the Lost Rigger Cove road, south of Gadgetzan."] = "",

	-- Step 43: Fly to Camp Mojache
	-- {object:176945} Camp Mojache (no name in this language: may be words)
	["Fly to {object:176945}"] = "",
	["Gadgetzan flight master"] = "",

	-- Step 44: Ruins of Isildien
	["Ruins of Isildien"] = "",
	-- {object:176945} Camp Mojache (no name in this language: may be words) · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {object:176945}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Рваный свиток лежит у входа сюда: {area:2261} – склеп к югу от места {area:2260}.",
	-- ["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Назад через туннель к выходу ({zone:1452}), затем на юг сюда: {area:2246}.",
	-- ["Back to {area:1638}"] = "Назад: {area:1638}",
	-- ["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Летите сюда: {zone:1458}, садитесь на дирижабль ({zone:1454}) и летите дальше сюда: {area:1638}.",
	-- ["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Летите сюда: {area:1099}. Гнезда гиппогрифов – на юге края {zone:1444}; в каждом есть яйцо для машины ({object:142071}).",
	-- ["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- ["Fly to {area:2268}"] = "Летите сюда: {area:2268}",
	-- ["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Летите сюда: {area:541}, затем езжайте на юго-запад через Ун'Горо к перевалу в край {zone:1451}. Следующее руководство начинается здесь: {area:3077}, у выхода с перевала.",
	-- ["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Бесноватые чумные псы и чудовищные чумные нетопыри бродят по полям вокруг мест {area:2272} и {area:2271}, к югу от места {area:2273}.",
	-- ["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Пройдите через место {area:1769} и сверните в ответвление туннеля ({zone:1450}). {npc:11801} – здесь: {area:2361}.",
	-- ["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Хамейя прячется среди троллей племени Моходеров ({area:2273}) в северо-восточном углу.",
	-- ["Hameya's mound"] = "Курган Хамейи",
	-- ["Hameya's scroll"] = "Свиток Хамейи",
	-- ["Hippogryph eggs"] = "Яйца гиппогрифов",
	-- ["On to {zone:1451}"] = "Дальше: {zone:1451}",
	-- ["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Ориентир: {area:1641}. Держите в сумках шерсть, шелковый материал и магическую ткань.",
	-- ["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Только если у вас выпал предмет {quest:8471}: {npc:11558} ждет у входа ({area:1769}) со стороны края {zone:1448} и говорит с вами только при нейтральном отношении Древобрюхов.",
	-- ["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Только если вы нашли флягу ({item:12820}) в крае {zone:1452}: езжайте на север по дороге. Котел стоит здесь: {area:1762}, чуть к юго-западу от места {area:1769}; фурболги Мертвого Леса там враждебны.",
	-- ["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Карликовые чумные псы и чумные нетопыри бродят по холмам к северу от места {area:2260}, среди них ползают личинки-падальщики; продвигайтесь на север к месту {area:2627}.",
	-- ["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Чумные псы и карликовые чумные псы бродят по берегам озера к юго-западу от часовни.",
	-- ["Ride east out of the {area:1497} along the road; the {area:152} guards the way into the {area:28}."] = "Езжайте на восток от места {area:1497} по дороге; {area:152} охраняет проход сюда: {area:28}.",
	-- ["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Езжайте на восток сюда: {area:2255} и дальше на север; луноподобные совухи бродят по южным склонам ({area:2241}). Выманивайте по одному.",
	-- ["Ride south from the lodge to {area:2264}, on the road. {item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once.\nCareful: Unseen Servants call for help within 25 yd once they drop to 40% health. Out of combat they also turn invisible with {spell:10228}. If a call for help happens inside the town, a large number of mobs can join the fight. Fighting near the outskirts lowers this risk."] = "Езжайте на юг от дома по дороге сюда: {area:2264}. {item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.\nОсторожно: незримые слуги зовут на помощь в радиусе 25 м, когда их здоровье падает до 40%. Вне боя они также становятся невидимыми ({spell:10228}). Если зов о помощи прозвучит в городе, в бой может вступить много противников. Сражайтесь на окраинах, чтобы снизить риск.",
	-- ["Ride west to the {area:2260}."] = "Езжайте на запад сюда: {area:2260}.",
	-- ["Sword of Marduk"] = "Меч Мардука",
	-- ["The flight from {area:1997} lands in {zone:1456}: {npc:3033} (Druids) trains on {area:1639}, {npc:246344} (Paladins) in the city too."] = "Полет из места {area:1997} приводит сюда: {zone:1456}. {npc:3033} (друиды) обучает здесь: {area:1639}, {npc:246344} (паладины) – тоже в городе.",
	-- ["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Следопыты, разведчицы дорог и лесники – высшие эльфы – охраняют дом у места {area:2275}; реестр лежит внутри. Следопыты – до 60-го уровня: выманивайте по одному. По пути над полями летают пагубные нетопыри.",
	-- ["The shattered sword lies on the ground north-west of the lake."] = "Сломанный меч лежит на земле к северо-западу от озера.",
	-- ["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Череп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудовищ.",
	-- ["The western hills"] = "Западные холмы",
	-- ["The {area:2622}"] = "{area:2622}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} – сразу за местом {area:2261}.",
	-- ["Use {npc:10980} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Используйте игрушку {npc:10980} на гоблинше {npc:7583} ({area:976}). {npc:10977} и {npc:10978} – позже по маршруту.",
	-- ["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.",
	-- ["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Призрак {npc:11140} стоит у хижины ({area:2627}) в северо-западном углу.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}).",
	-- ["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} ({area:1639}); {npc:246344}",
	-- ["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} стоит лагерем у дороги к месту {area:1336}, к югу от места {area:976}.",
	-- ["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} – призрак на кладбище чуть к северу от места {area:976}; подозрительное надгробие – к югу от него, за городской стеной.",
	-- ["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Распорядитель полетов ({object:1661}) – в западной башне ({object:36078}), за стенами.",
}
