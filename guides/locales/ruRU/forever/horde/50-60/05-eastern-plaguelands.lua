-- Russian (ruRU): the guide forever/horde/50-60/05-eastern-plaguelands (forever/horde/50-60/05-eastern-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Летите сюда: {area:2268}",
	-- {object:1661} The Undercity · {object:36078} Trade Quarter
	["{object:1661}'s flight master is in the {object:36078}'s west tower, outside the walls."] = "Распорядитель полетов ({object:1661}) – в западной башне ({object:36078}), за стенами.",

	-- Step 2: Light's Hope Chapel
	-- {quest:5168} Heroes of Darrowshire
	["{quest:5168}'s items lie in the later Plaguelands zones: keep it."] = "Предметы для задания {quest:5168} – в Чумных землях, позже: сохраните его.",

	-- Step 3: Lake Mereldar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Plaguehounds and their runts roam the shores of the lake south-west of the chapel."] = "Чумные псы и карликовые чумные псы бродят по берегам озера к юго-западу от часовни.",

	-- Step 4: Sword of Marduk
	["Sword of Marduk"] = "Меч Мардука",
	["The shattered sword lies on the ground north-west of the lake."] = "Сломанный меч лежит на земле к северо-западу от озера.",

	-- Step 5: The Pestilent Scar
	-- {area:2622} Pestilent Scar
	["The {area:2622}"] = "{area:2622}",
	-- {area:2622} Pestilent Scar
	-- plural, as words: Blighted Horrors = {npc:8521} Blighted Horror
	["The skull sits in the {area:2622}, among Blighted Horrors and Plague Monstrosities."] = "Череп лежит здесь: {area:2622}, среди зачумленных ужасов и чумных чудовищ.",

	-- Step 6: Hameya's scroll
	["Hameya's scroll"] = "Свиток Хамейи",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Рваный свиток лежит у входа сюда: {area:2261} – склеп к югу от места {area:2260}.",

	-- Step 7: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead
	["{npc:15193}'s champion holds the {area:2260} farmhouse."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}).",

	-- Step 8: The western hills
	["The western hills"] = "Западные холмы",
	-- {area:2260} Marris Stead · {area:2627} Terrordale
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub
	["Plaguehound Runts and Plaguebats roam the hills north of the {area:2260}, Carrion Grubs crawl among them; work north toward {area:2627}."] = "Карликовые чумные псы и чумные нетопыри бродят по холмам к северу от места {area:2260}, среди них ползают личинки-падальщики; продвигайтесь на север к месту {area:2627}.",

	-- Step 9: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} the ghost stands by a hut in {area:2627}, in the north-west corner."] = "Призрак {npc:11140} стоит у хижины ({area:2627}) в северо-западном углу.",

	-- Step 10: Quel'Lithien Lodge
	-- {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider · Noxious Plaguebats = {npc:8601} Noxious Plaguebat
	["The high elf Rangers, Pathstriders and Woodsmen guard the lodge by {area:2275}; the Registry lies inside. Rangers reach 60: pull one at a time. Noxious Plaguebats fly over the fields on the way."] = "Следопыты, разведчицы дорог и лесники – высшие эльфы – охраняют дом у места {area:2275}; реестр лежит внутри. Следопыты – до 60-го уровня: выманивайте по одному. По пути над полями летают пагубные нетопыри.",

	-- Step 11: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner."] = "Хамейя прячется среди троллей племени Моходеров ({area:2273}) в северо-восточном углу.",

	-- Step 12: Northdale
	-- {area:2272} Northdale · {area:2271} Eastwall Tower · {area:2273} Zul'Mashar
	-- plural, as words: Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound · Monstrous Plaguebats = {npc:8602} Monstrous Plaguebat
	["Frenzied Plaguehounds and Monstrous Plaguebats share the fields around {area:2272} and {area:2271}, south of {area:2273}."] = "Бесноватые чумные псы и чудовищные чумные нетопыри бродят по полям вокруг мест {area:2272} и {area:2271}, к югу от места {area:2273}.",

	-- Step 13: Corin's Crossing
	-- {item:15447} Living Rot · {item:15454} Mortar and Pestle
	["{item:15447} spoils within ten minutes: kill the town's Scourge quickly and grind the seven pieces with the {item:15454} at once."] = "{item:15447} портится за десять минут: быстро убивайте воинов Плети в городе и сразу перетрите семь кусков предметом {item:15454}.",

	-- Step 14: Nathanos Blightcaller
	-- {area:2260} Marris Stead
	["Ride west to the {area:2260}."] = "Езжайте на запад сюда: {area:2260}.",

	-- Step 15: Hameya's mound
	["Hameya's mound"] = "Курган Хамейи",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just behind the {area:2261}."] = "{object:177675} – сразу за местом {area:2261}.",

	-- Step 17: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:1638} Thunder Bluff
	["Fly to the {zone:1458}, take the zeppelin to {zone:1454} and fly on to {area:1638}."] = "Летите сюда: {zone:1458}, садитесь на дирижабль ({zone:1454}) и летите дальше сюда: {area:1638}.",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} ({area:1639}); {npc:246344}",

	-- Step 18: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["On {area:1641}. Have the Wool, Silk and Mageweave in your bags."] = "Ориентир: {area:1641}. Держите в сумках шерсть, шелковый материал и магическую ткань.",

	-- Step 20: Deadwood Cauldron
	-- {item:12820} Winterfall Firewater · {zone:1452} Winterspring · {area:1762} Felpaw Village · {area:1769} Timbermaw Hold
	["Only if you found a {item:12820} flask in {zone:1452}: ride north up the road. The cauldron stands in {area:1762}, just south-west of {area:1769}; the Deadwood furbolgs there are hostile."] = "Только если вы нашли флягу ({item:12820}) в крае {zone:1452}: езжайте на север по дороге. Котел стоит здесь: {area:1762}, чуть к юго-западу от места {area:1769}; фурболги Мертвого Леса там враждебны.",

	-- Step 21: Kernda
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood · {area:1769} Timbermaw Hold
	["Only if a {quest:8471} dropped for you: {npc:11558} waits at the {zone:1448} entrance of {area:1769}, and speaks to you only at Neutral with the Timbermaw."] = "Только если у вас выпал предмет {quest:8471}: {npc:11558} ждет у входа ({area:1769}) со стороны края {zone:1448} и говорит с вами только при нейтральном отношении Древобрюхов.",

	-- Step 22: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {npc:11801} Rabine Saturna · {area:2361} Nighthaven
	["Go through {area:1769} and take the {zone:1450} branch of the tunnel. {npc:11801} is in {area:2361}."] = "Пройдите через место {area:1769} и сверните в ответвление туннеля ({zone:1450}). {npc:11801} – здесь: {area:2361}.",
	-- {zone:1451} Silithus
	["Both quests lead to {zone:1451}: keep them."] = "Оба задания ведут в край {zone:1451}: сохраните их.",

	-- Step 23: Donova Snowden
	-- {zone:1452} Winterspring · {area:2246} Frostfire Hot Springs
	["Back through the tunnel and take the {zone:1452} exit, then ride south to {area:2246}."] = "Назад через туннель к выходу ({zone:1452}), затем на юг сюда: {area:2246}.",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["{quest:5086} are in {zone:1448}, on a later trip: keep it if you have it."] = "{quest:5086} – здесь: {zone:1448}, в следующий раз: сохраните задание, если оно есть.",

	-- Step 24: Moontouched Owlbeasts
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts"] = "Луноподобные совухи",
	-- {area:2255} Everlook · {area:2241} Frostsaber Rock
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Ride east to {area:2255} and north out of it; the Moontouched Owlbeasts roam the hills of {area:2241}'s southern slopes. Pull them one at a time."] = "Езжайте на восток сюда: {area:2255} и дальше на север; луноподобные совухи бродят по южным склонам ({area:2241}). Выманивайте по одному.",

	-- Step 25: Back to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Back to {area:1638}"] = "Назад: {area:1638}",

	-- Step 26: Gadgetzan
	-- {object:142071} Egg-O-Matic
	["The {object:142071} machine"] = "Машина: {object:142071}",

	-- Step 27: Sprinkle
	-- {npc:10980} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {npc:10980} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Используйте игрушку {npc:10980} на гоблинше {npc:7583} ({area:976}). {npc:10977} и {npc:10978} – позже по маршруту.",

	-- Step 28: Gaeriyan
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} is a ghost at the graveyard just north of {area:976}; the Conspicuous Gravestone is south of it, outside the town wall."] = "{npc:9299} – призрак на кладбище чуть к северу от места {area:976}; подозрительное надгробие – к югу от него, за городской стеной.",
	-- {quest:3914} Linken's Sword
	["{quest:3914} goes back to Linken in Un'Goro: keep it."] = "{quest:3914} сдается Линкену в Ун'Горо: сохраните задание.",

	-- Step 29: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} стоит лагерем у дороги к месту {area:1336}, к югу от места {area:976}.",

	-- Step 30: Hippogryph eggs
	["Hippogryph eggs"] = "Яйца гиппогрифов",
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {object:142071} Egg-O-Matic
	["Fly to {area:1099}. The hippogryph nests are in the south of {zone:1444}; each holds an egg for the {object:142071}."] = "Летите сюда: {area:1099}. Гнезда гиппогрифов – на юге края {zone:1444}; в каждом есть яйцо для машины ({object:142071}).",

	-- Step 31: On to Silithus
	-- {zone:1451} Silithus
	["On to {zone:1451}"] = "Дальше: {zone:1451}",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus · {area:3077} Valor's Rest
	["Fly to {area:541}, then ride south-west through Un'Goro to the pass into {zone:1451}. The next guide opens at {area:3077}, where the pass comes out."] = "Летите сюда: {area:541}, затем езжайте на юго-запад через Ун'Горо к перевалу в край {zone:1451}. Следующее руководство начинается здесь: {area:3077}, у выхода с перевала.",
}
