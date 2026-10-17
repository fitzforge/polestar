-- Russian (ruRU): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kadrak
	-- {area:380} Crossroads · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale · {item:16783} Bundle of Reports
	["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "От поселения {area:380} идите по дороге на север. {npc:8582} стоит на сторожевой башне ({area:1703}), где дорога входит в зону {zone:1440}. Откройте {item:16783}, который он даст.",

	-- Step 2: Warsong Scout
	-- {npc:12862} Warsong Scout
	["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Продолжайте идти по дороге на север. {npc:12862} ждет на Лесозаготовках Песни Войны, к югу от заставы Расщепленного Дерева.",

	-- Step 3: Splintertree Post
	-- {area:431} Splintertree Post
	["{area:431} is just north up the road."] = "{area:431} – чуть севернее по дороге.",

	-- Step 4: Night Run
	-- {npc:12696} Senani Thunderheart · {area:428} Night Run
	["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} стоит здесь: {area:428}, лагерь Песни Войны чуть к северо-востоку от заставы Расщепленного Дерева, у доски охоты.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "Цели охоты {npc:12696} (Топтыжень, Тенумбра, Острокоготь) – для следующего визита в зону {zone:1440}, на 27-м уровне.",

	-- Step 5: Warsong Outrider
	-- {npc:12864} Warsong Outrider · {area:428} Night Run · {area:430} Satyrnaar
	["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864} патрулирует дорогу к востоку от места {area:428} в сторону места {area:430}.",

	-- Step 6: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "По пути на запад: {npc:267214} застрял в овраге к югу от главной дороги, к юго-востоку от места {area:415}. Вокруг бродят тенероги ({npc:3817}) и медведи Ясеневого леса ({npc:3809}).",

	-- Step 7: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Выведите NPC {npc:271181} {npc:267214} из оврага к главной дороге за четыре минуты; если поддержание прервется, попросите {npc:267214} снова.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, на дороге",

	-- Step 8: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand
	["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Езжайте на запад по главной дороге через зону {zone:1440}, мимо места {area:415} (Альянс: держитесь дороги), к побережью. {area:2897} – {area:414} на северо-западе. Остальные задания там – для следующего визита, на 27-м уровне.",

	-- Step 9: Naga heads
	["Naga heads"] = "Головы наг",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Все наги из клана Зловещего Хвоста вдоль берега к северу от заставы роняют головы.",

	-- Step 11: Back to Kadrak
	-- {npc:8582} Kadrak
	["Back to {npc:8582}"] = "Назад к NPC {npc:8582}",
	-- {area:431} Splintertree Post · {area:1703} Mor'shan Rampart
	["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Летите: {area:431} – и езжайте на юг по дороге: {area:1703}.",

	-- Step 12: Malaka'jin
	-- {area:380} Crossroads · {zone:1413} Barrens · {area:2539} Malaka'jin
	["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Езжайте на юг: {area:380}, затем на запад по дороге из зоны {zone:1413} в Когтистые горы. Деревня троллей {area:2539} стоит у входа в каньон.",

	-- Step 13: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "Дорога поднимается на север – {area:1076}. Хижина: {quest:1483} – там, где дорога сворачивает на восток к месту {area:461}.",

	-- Step 14: Windshear Crag
	-- {area:461} Windshear Crag · {npc:4276} Piznik
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "К востоку от Зиза Торговая компания вырубает лес – {area:461}; чертежи – у одного из операторов. {npc:4276} добывает руду в маленьком руднике на востоке: оставайтесь с ним, пока он работает, – за ним придут громилы Торговой компании.",

	-- Step 15: Ziz Fizziks
	-- {area:392} Ratchet
	["Sputtervalve in {area:392}: the next guide passes there"] = "Пароклапан ({area:392}): следующий гайд проходит там",

	-- Step 16: Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Follow the road west to {area:460}."] = "Идите по дороге на запад: {area:460}.",
	-- {npc:11860} Maggran Earthbinder · {object:19844} Great Lift
	["{npc:11860}: Grish is at the {object:19844}, in the next guide"] = "{npc:11860}: Гриш – {object:19844}, в следующем гайде",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: сверкающие солнечные камни ({item:277936}) с гарпий из стаи Кровавой Ярости",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, за воротами",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} – форт Зорам'гар, на 27-м уровне",

	-- Step 17: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Семена Геи ({item:16205})",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "{item:16205} лежат в траве вдоль южного берега: {area:464}, к северу от Солнечного Камня.",

	-- Step 18: Stonetalon Peak
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Идите по дороге на север к месту {area:467}. По пути пасутся беговые олени-рогачи ({npc:4018}); сокотвари ({npc:4020}), сумеречные бегуны ({npc:4067}) и волшебные дракончики ({npc:4016}) бродят в лесу под пиком, а кенарийские друиды занимают рощу там.",

	-- Step 19: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "Следующее задание {npc:4198}, «Гордан», – на стороне Альянса в зоне {zone:1440}. Пропустите его.",

	-- Step 20: The Charred Vale
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "К юго-западу от Солнечного Камня лежит выжженная {area:465}. Посадите семена Геи в земляные курганы на дне долины; с огненных элементалей падают {item:16312}. Гарпии и душительницы из стаи Кровавой Ярости гнездятся на севере, душегубки и бродяжницы – на юге.",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Земляные курганы Геи ({object:177929})",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, с любой гарпии из стаи Кровавой Ярости",

	-- Step 21: Sun Rock Retreat
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, наверху на уступе",
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, рядом с NPC {npc:11862}",

	-- Step 22: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Ride back down the {area:1076} to {area:2539}."] = "Езжайте обратно вниз: {area:1076} – до места {area:2539}.",

	-- Step 23: To the Undercity
	-- {area:1497} Undercity
	["To the {area:1497}"] = "В {area:1497}",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:1497} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter
	["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Езжайте на восток: {area:380} – и летите в {zone:1454}. От башен у города {zone:1454} садитесь на дирижабль в зону {zone:1420}; {area:1497} лежит под местом {area:153}. Укротитель летучих мышей – {object:36078}.",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Поговорите с NPC {npc:10181} ({object:36126}): {quest:93739}",

	-- Step 24: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606} стоит здесь: {object:36070}.",

	-- Step 25: Beren's Peril
	-- {area:272} Tarren Mill · {zone:1458} Undercity · {area:228} Sepulcher · {area:231} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Если вы уже знаете маршрут полета в {area:272}, летите туда и переходите к шагу {area:272}. Иначе летите из города {zone:1458} в {area:228} и езжайте на юг по дороге мимо Деревни Погребальных Костров. Нежить Когтя Ворона бродит по руинам ({area:231}) к востоку от дороги на юго-востоке леса; {npc:1973} роняет {item:271343}, который ведет к предмету {object:645153}.",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, с NPC {npc:1973}",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}: с измученных душ среди руин",

	-- Step 26: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Используйте {npc:212753} у предмета {object:645153} для добровольной жертвы и убейте отозвавшегося: {npc:212753}. {quest:95883} – элитное: лучше собрать группу.",

	-- Step 27: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "Снова на юг по дороге. Там, где она сворачивает на восток в {area:287}, {npc:2214} ждет здесь: {area:285}.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: Дарталия – {area:272}",

	-- Step 28: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Идите по дороге на восток вдоль реки, затем на северо-восток в холмы: {area:272}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "К юго-западу от Солнечного Камня лежит выжженная {area:465}. Посадите семена Геи ({item:16205}) в земляные курганы на дне долины; с огненных элементалей падают {item:16312}. Гарпии и душительницы из стаи Кровавой Ярости гнездятся на севере, душегубки и бродяжницы – на юге.",
}
