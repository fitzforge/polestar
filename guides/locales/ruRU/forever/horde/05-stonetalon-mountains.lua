-- Russian (ruRU): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Taskmaster Fizzule
	-- {item:8051} Flare Gun
	["On the way north from Seereth's camp, keep east of the road to the Venture Co. tower north of the Sludge Fen. Before you go near Fizzule, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "",
	-- {quest:2478} Mission: Possible But Not Probable
	["{quest:2478} is for level 23 or more: the tower's drones are 25 and Gallywix a 23 elite. Do it when you can, with a group, from the Class guide Poisons (Horde)."] = "",

	-- Step 2: Kadrak
	-- {zone:1413} Barrens · {npc:8582} Kadrak · {zone:1440} Ashenvale
	["From Seereth's camp head north-east across the {zone:1413} to the road north of the Crossroads. {npc:8582} stands on the watch tower of the Mor'shan Rampart where the road enters {zone:1440}."] = "",

	-- Step 4: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867} стоит на лесозаготовках. Бегуны ночных эльфов рыщут в лесу к юго-востоку; они скрываются, так что смотрите в оба.",

	-- Step 5: Splintertree Post
	["Splintertree Post"] = "",
	-- {npc:12696} Senani Thunderheart
	["Splintertree Post is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at Night Run come first, then the vendors."] = "",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 26."] = "",

	-- Step 6: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of Astranaar. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "",

	-- Step 7: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "Выведите NPC {npc:271181} {npc:267214} из оврага к главной дороге за четыре минуты; если поддержание прервется, попросите {npc:267214} снова.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}, на дороге",

	-- Step 8: Zoram'gar Outpost
	["Zoram'gar Outpost"] = "",
	-- {zone:1440} Ashenvale · {npc:12719} Marukai · {npc:12721} Mitsuwa · {npc:12757} Karang Amakkar · {npc:12863} Warsong Runner
	["Head west along the main road across {zone:1440}, past Astranaar (Alliance: keep to the road), to the coast. Zoram'gar Outpost is on the Zoram Strand in the north-west: {npc:12719}, {npc:12721} and {npc:12757} stand around it, the {npc:12863} beside the flight master. Its other quests are for the next visit, at 26."] = "",
	-- {npc:12721} Mitsuwa
	["{npc:12721}: the troll charms are in Thistlefur Hold, east of the outpost"] = "",
	-- {npc:12717} Muglash
	["{npc:12717}: take it last, his escort starts at once"] = "",

	-- Step 9: Vorsha the Lasher
	-- {npc:12717} Muglash · {npc:12719} Marukai
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead; the Wrathtail naga drop the heads {npc:12719} wants."] = "",
	["Naga brazier"] = "Жаровня наг",

	-- Step 10: Naga heads
	["Naga heads"] = "Головы наг",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "Все наги из клана Зловещего Хвоста вдоль берега к северу от заставы роняют головы.",

	-- Step 11: Zoram'gar Outpost
	["Back to the outpost before heading east to Thistlefur."] = "",

	-- Step 12: Thistlefur Village
	["Thistlefur Village"] = "",
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold.\nCareful: A Shaman at 15% health or lower runs off to find help, which can pull extra furbolgs."] = "",

	-- Step 13: Thistlefur Hold
	["Thistlefur Hold"] = "Логово Колючего Меха",
	-- {npc:12818} Ruul Snowhoof · {npc:3987} Dal Bloodclaw
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to Night Run.\nCareful: Two scripted ambushes occur, each made up of three Thistlefurs (a Shaman, a Pathfinder and an Avenger, Ursa or Den Watcher): the first when you come back to the tunnel's fork inside the cave, the second just beyond the gate where {npc:3987} roams."] = "",
	["Below ground"] = "",
	-- {npc:12818} Ruul Snowhoof
	["{npc:12818}, below ground"] = "",

	-- Step 14: Zoram'gar Outpost
	-- {npc:12757} Karang Amakkar · {zone:1440} Ashenvale
	["Back west to Zoram'gar. {npc:12757} offers King of the Foulweald now; leave it for the next {zone:1440} visit at 26, when the walk east passes the Foulweald."] = "",

	-- Step 15: Splintertree Post
	-- {npc:12837} Yama Snowhoof
	["Fly to Splintertree Post: {npc:12837} waits in the inn for news of Ruul."] = "",
	-- {npc:12837} Yama Snowhoof
	["{npc:12837}, inside the inn"] = "{npc:12837}, в таверне",

	-- Step 16: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",
	-- {zone:1454} Orgrimmar
	["Back out of the inn to the flight master and fly to {zone:1454}."] = "",
	["Splintertree Post flight master"] = "",

	-- Step 17: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 18: Druid trainer
	["Druid trainer"] = "Учитель друидов",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "",

	-- Step 20: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} стоит здесь: {object:172960}. Используйте {item:6626} на круге призыва и победите суккуба, чтобы подчинить ее.",

	-- Step 21: Shenthul
	-- {quest:2478} Mission: Possible But Not Probable · {npc:3401} Shenthul · {object:172960} Cleft of Shadow
	["If you did {quest:2478} with a group, {npc:3401} in the {object:172960} takes it now."] = "",
	-- {npc:2391} Serge Hinott · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:2391} in {object:1772} teaches Poisons: keep it"] = "",

	-- Step 23: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 24: The Sepulcher
	-- {npc:2121} Shadow Priest Allister · {npc:1937} Apothecary Renferrel
	["From the zeppelin towers, run south through Tirisfal into Silverpine and down the road to the Sepulcher. {npc:2121} and {npc:1937} stand by the crypt entrance."] = "",
	-- {npc:1937} Apothecary Renferrel · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:1937}: Lydon in {object:1772}, next guide"] = "",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, south-east of Ambermill"] = "",

	-- Step 25: Silverpine Forest: kill these as you meet them
	-- {zone:1421} Silverpine Forest
	["{zone:1421}: kill these as you meet them"] = "",
	-- {quest:516} Beren's Peril
	-- plural, as words: Dalaran Watchers = {npc:1888} Dalaran Watcher · Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South down the road past Pyrewood: Dalaran Watchers and Wizards patrol the roads around Ambermill, and south-west of the town the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["In the ruins of {quest:516}: The Ravenclaw undead haunt the ruins of {quest:516} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}, с NPC {npc:1973}",
	-- {object:645153} Offering Stone · {quest:95883} The Tortured Soul · {item:271343} Note Scrap
	["the {object:645153} offers {quest:95883} once the {item:271343} is in; below ground"] = "",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "",

	-- Step 27: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "Используйте {npc:212753} у предмета {object:645153} для добровольной жертвы и убейте отозвавшегося: {npc:212753}. {quest:95883} – элитное: лучше собрать группу.",

	-- Step 29: Southpoint Tower
	["Southpoint Tower"] = "",
	-- {npc:2214} Deathstalker Lesh
	["Back on the road south. Where it turns east into Hillsbrad, {npc:2214} waits at Southpoint Tower."] = "",
	-- {npc:2214} Deathstalker Lesh · {object:1772} Tarren Mill (no name in this language: may be words)
	["{npc:2214}: Darthalia in {object:1772}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "Снова на юг по дороге. Там, где она сворачивает на восток в {area:287}, {npc:2214} ждет здесь: {area:285}.",
	-- ["Back to {npc:8582}"] = "Назад к NPC {npc:8582}",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "К востоку от Зиза Торговая компания вырубает лес – {area:461}; чертежи – у одного из операторов. {npc:4276} добывает руду в маленьком руднике на востоке: оставайтесь с ним, пока он работает, – за ним придут громилы Торговой компании.",
	-- ["Fly to {area:431} and ride south down the road to the {area:1703}."] = "Летите: {area:431} – и езжайте на юг по дороге: {area:1703}.",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "Идите по дороге на восток вдоль реки, затем на северо-восток в холмы: {area:272}.",
	-- ["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Идите по дороге на север к месту {area:467}. По пути пасутся беговые олени-рогачи ({npc:4018}); сокотвари ({npc:4020}), сумеречные бегуны ({npc:4067}) и волшебные дракончики ({npc:4016}) бродят в лесу под пиком, а кенарийские друиды занимают рощу там.",
	-- ["Follow the road west to {area:460}."] = "Идите по дороге на запад: {area:460}.",
	-- ["From the zeppelin towers, run south through Tirisfal into Silverpine and down the road past the {area:228} and Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "От башен дирижаблей бегите на юг через Тирисфальские леса в Серебряный бор и дальше по дороге мимо места {area:228} и Деревни Погребальных Костров. Нежить Когтя Ворона бродит по руинам ({area:231}) к востоку от дороги на юго-востоке леса; {npc:1973} роняет {item:271343}, который ведет к предмету {object:645153}.",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "От поселения {area:380} идите по дороге на север. {npc:8582} стоит на сторожевой башне ({area:1703}), где дорога входит в зону {zone:1440}. Откройте {item:16783}, который он даст.",
	-- ["Gaea Dirt Mounds"] = "Земляные курганы Геи ({object:177929})",
	-- ["Gaea Seeds"] = "Семена Геи ({item:16205})",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "Если вы уже знаете маршрут полета в {area:272}, летите туда и переходите к шагу {area:272}. Иначе летите из города {zone:1458} в {area:228} и езжайте на юг по дороге мимо Деревни Погребальных Костров. Нежить Когтя Ворона бродит по руинам ({area:231}) к востоку от дороги на юго-востоке леса; {npc:1973} роняет {item:271343}, который ведет к предмету {object:645153}.",
	-- ["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "Продолжайте идти по дороге на север. {npc:12862} ждет на Лесозаготовках Песни Войны, к югу от заставы Расщепленного Дерева.",
	-- ["Learn the flight path here while you pick up the outpost's quests."] = "Узнайте здесь маршрут полета, пока берете задания заставы.",
	-- ["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "По пути на запад: {npc:267214} застрял в овраге к югу от главной дороги, к юго-востоку от места {area:415}. Вокруг бродят тенероги ({npc:3817}) и медведи Ясеневого леса ({npc:3809}).",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "Езжайте обратно вниз: {area:1076} – до места {area:2539}.",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "Езжайте на восток: {area:380} – и летите в {zone:1454}. От башен у города {zone:1454} садитесь на дирижабль в зону {zone:1420}; {area:1497} лежит под местом {area:153}. Укротитель летучих мышей – {object:36078}.",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Езжайте на юг: {area:380}, затем на запад по дороге из зоны {zone:1413} в Когтистые горы. Деревня троллей {area:2539} стоит у входа в каньон.",
	-- ["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "Езжайте на запад по главной дороге через зону {zone:1440}, мимо места {area:415} (Альянс: держитесь дороги), к побережью. {area:2897} – {area:414} на северо-западе. Остальные задания там – для следующего визита, на 27-м уровне.",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "К юго-западу от Солнечного Камня лежит выжженная {area:465}. Посадите семена Геи в земляные курганы на дне долины; с огненных элементалей падают {item:16312}. Гарпии и душительницы из стаи Кровавой Ярости гнездятся на севере, душегубки и бродяжницы – на юге.",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Поговорите с NPC {npc:10181} ({object:36126}): {quest:93739}",
	-- ["Sputtervalve in {area:392}: the next guide passes there"] = "Пароклапан ({area:392}): следующий гайд проходит там",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "{item:16205} лежат в траве вдоль южного берега: {area:464}, к северу от Солнечного Камня.",
	-- ["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "Дорога поднимается на север – {area:1076}. Хижина: {quest:1483} – там, где дорога сворачивает на восток к месту {area:461}.",
	-- ["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864} патрулирует дорогу к востоку от места {area:428} в сторону места {area:430}.",
	-- ["To the {area:1497}"] = "В {area:1497}",
	-- ["{area:431} is just north up the road."] = "{area:431} – чуть севернее по дороге.",
	-- ["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}: с измученных душ среди руин",
	-- ["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, с любой гарпии из стаи Кровавой Ярости",
	-- ["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: сверкающие солнечные камни ({item:277936}) с гарпий из стаи Кровавой Ярости",
	-- ["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}: Гриш – {area:1718}, в следующем гайде",
	-- ["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, рядом с NPC {npc:11862}",
	-- ["{npc:11862}, up on the ledge"] = "{npc:11862}, наверху на уступе",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696} стоит здесь: {area:428}, лагерь Песни Войны чуть к северо-востоку от заставы Расщепленного Дерева, у доски охоты.",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "Цели охоты {npc:12696} (Топтыжень, Тенумбра, Острокоготь) – для следующего визита в зону {zone:1440}, на 27-м уровне.",
	-- ["{npc:12736} at Zoram'gar, at 27"] = "{npc:12736} – форт Зорам'гар, на 27-м уровне",
	-- ["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: Дарталия – {area:272}",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "Следующее задание {npc:4198}, «Гордан», – на стороне Альянса в зоне {zone:1440}. Пропустите его.",
	-- ["{npc:4198}, outside the gate"] = "{npc:4198}, за воротами",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606} стоит здесь: {object:36070}.",
}
