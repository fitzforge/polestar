-- Russian (ruRU): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Crossroads
	["Fly to Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 2: The road west
	["The road west"] = "",
	["The road west past Seereth's camp"] = "",

	-- Step 3: Malaka'jin
	-- {npc:3995} Witch Doctor Jin'Zil · {area:2539} Malaka'jin · {area:1076} Webwinder Path
	["Follow the road west past Regthar's bunkers and Seereth's camp into Stonetalon: {npc:3995} waits below ground in {area:2539}, at the foot of the {area:1076}."] = "",
	-- {npc:3995} Witch Doctor Jin'Zil
	["{npc:3995}, below ground"] = "",

	-- Step 4: Sun Rock Retreat
	-- {area:1076} Webwinder Path · {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["Up the {area:1076} past {npc:4201} and west to {area:460}."] = "",
	-- {npc:11862} Tsunaman · {npc:12736} Je'neu Sancrea
	["{npc:11862}: {npc:12736} at Zoram'gar, next guide"] = "",
	-- {npc:11860} Maggran Earthbinder · {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["{npc:11860}: {npc:12576} is at the {area:1718}, later in this guide"] = "",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: сверкающие солнечные камни ({item:277936}) с гарпий из стаи Кровавой Ярости",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}, за воротами",

	-- Step 5: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "Семена Геи ({item:16205})",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "",

	-- Step 6: Stonetalon Mountains: kill these as you meet them
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442}: kill these as you meet them"] = "",
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "Идите по дороге на север к месту {area:467}. По пути пасутся беговые олени-рогачи ({npc:4018}); сокотвари ({npc:4020}), сумеречные бегуны ({npc:4067}) и волшебные дракончики ({npc:4016}) бродят в лесу под пиком, а кенарийские друиды занимают рощу там.",

	-- Step 7: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "Следующее задание {npc:4198}, «Гордан», – на стороне Альянса в зоне {zone:1440}. Пропустите его.",

	-- Step 8: The Charred Vale: kill these as you meet them
	-- {area:465} The Charred Vale
	["{area:465}: kill these as you meet them"] = "",
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "К юго-западу от Солнечного Камня лежит выжженная {area:465}. Посадите семена Геи в земляные курганы на дне долины; с огненных элементалей падают {item:16312}. Гарпии и душительницы из стаи Кровавой Ярости гнездятся на севере, душегубки и бродяжницы – на юге.",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}, с любой гарпии из стаи Кровавой Ярости",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "Земляные курганы Геи ({object:177929})",

	-- Step 9: Sun Rock Retreat
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}, рядом с NPC {npc:11862}",
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}, наверху на уступе",

	-- Step 10: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Head back down the {area:1076} to {area:2539}."] = "",

	-- Step 11: To Camp Taurajo
	-- {area:378} Camp Taurajo
	["To {area:378}"] = "",

	-- Step 12: Camp Taurajo
	-- {area:2539} Malaka'jin · {area:378} Camp Taurajo
	["From {area:2539} follow the road east to Seereth's camp, then south-east across the plains to {area:378}."] = "",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, у северного края лагеря",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, в клетке",

	-- Step 13: Grunt Logmar
	-- {npc:5911} Grunt Logmar · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["{npc:5911} stands by the flight master. His {npc:268623} (23) is elite: grouping up is advised; the two Encroaching Soldiers are not."] = "",
	-- {npc:5911} Grunt Logmar · {npc:3341} Gann Stonespire
	["{npc:5911}: the soldiers and the pillager camp just east of {npc:3341}, on the way south"] = "",

	-- Step 15: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "Хижина ({npc:5899}) стоит на гребне над водопоем свинобразов, к югу от места {area:378}, по пути в {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: красный бурдюк из места {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: синий бурдюк наполняется в зоне {zone:1440}, следующий гайд",

	-- Step 16: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan · {npc:14242} Sulhasa
	["{npc:3341} walks the road south toward {area:359}, between about 46,75 and 46,81: if he isn't at the arrow, follow the road until you meet him. {npc:14242} sits up in the tree just east of the road at 47.9,77.5."] = "",
	-- {npc:3341} Gann Stonespire · {area:1701} Blackthorn Ridge
	["{npc:3341} walks around {area:1701}: look inside the circle on the map"] = "",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, на дереве чуть восточнее {npc:3341}",

	-- Step 17: Wrongly Blamed, Justly Corrected
	-- {npc:14242} Sulhasa · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["A few steps east of {npc:14242}'s tree, a small camp: two Encroaching Soldiers and the {npc:268623} for Logmar. The {npc:268623} is elite: grouping up is advised."] = "",

	-- Step 18: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone.\nCareful: Excavators (level 21-22) and Foremen (level 22-23) run off for help once they fall to 15% health, so more dwarves can join the fight."] = "",
	-- {npc:3375} Bael'dun Foreman · {area:359} Bael Modan
	["{npc:3375} walks around {area:359}: look inside the circle on the map"] = "",

	-- Step 19: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {quest:885} Washte Pawne · {spell:1752} Sinister Strike
	-- plural, as words: Razormane Stalkers = {npc:3457} Razormane Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "",

	-- Step 20: Field to Clear
	-- {npc:3341} Gann Stonespire · {npc:3238} Stormhide
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["On the way back east to {npc:3341}: Hecklefang Stalkers and {npc:3238} lizards roam the plain between the ridge and his camp."] = "",
	-- {npc:4128} Hecklefang Stalker · {area:1156} Southern Barrens
	["{npc:4128} walks around {area:1156}: look inside the circle on the map"] = "",

	-- Step 22: Bael'dun fortress
	["Bael'dun fortress"] = "Крепость Бейл'дана",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them.\nCareful: Riflemen (level 24-25) Shoot from 5-30 yd, so nearby ones can join a fight from range."] = "",

	-- Step 24: The flying machine
	["The flying machine"] = "Летательная машина",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "Летательная машина дворфов стоит на площадке внутри раскопок.",

	-- Step 26: Great Lift
	-- {area:1718} Great Lift
	["The top of the {area:1718}"] = "",

	-- Step 27: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "",

	-- Step 28: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "{area:1718}",
	-- {npc:10079} Brave Moonhorn · {area:1718} Great Lift · {npc:12576} Grish Longrunner
	["{npc:10079} stands at the top of the {area:1718}, beside {npc:12576}."] = "{npc:10079} стоит наверху ({area:1718}), рядом с NPC {npc:12576}.",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}, наверху у подъемника",

	-- Step 31: Grunt Logmar
	-- {npc:5911} Grunt Logmar
	["{npc:5911}, beside the flight master"] = "",

	-- Step 32: Fly to Crossroads
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "",

	-- Step 33: The Crossroads
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, на вершине башни",

	-- Step 34: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Лететь: {area:392}",
	["Crossroads flight master"] = "",

	-- Step 35: Merchant Coast
	-- {quest:874} Mahren Skyseer · {area:392} Ratchet
	["{quest:874} camps on the shore just north of {area:392}'s flight master."] = "",

	-- Step 36: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, большой трешадон, плавает на мелководье у места {area:391}, к востоку от {npc:3388}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Помогите NPC {npc:261366}: держитесь рядом, когда на гребень поднимутся {npc:261367} и солдаты ({area:21})",
	-- ["Back to the {area:380}"] = "Назад: {area:380}",
	-- ["Bristleback camps"] = "Лагеря Дыбогривых",
	-- ["Bruuz"] = "Брууз",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Примените {spell:18960}. Таурены: соедините две половинки подвески здесь: {area:2362}, на северо-западном берегу озера, прежде чем идти к NPC {npc:11802} ({area:2361}).",
	-- ["Dogran is chained up in the quilboar camp west of the road."] = "Догран закован в цепи в лагере свинобразов к западу от дороги.",
	-- ["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Дорас, распорядитель ветрокрылов, стоит на башне ({object:172982}).",
	-- ["Down the {area:458} to {area:378} again."] = "Снова на юг по дороге ({area:458}). Цель: {area:378}.",
	-- ["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "На восток через равнины к побережью: украденное серебро лежит в гнезде ящеров к северо-западу (ориентир: {area:385}).",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "На восток. Цель: {area:382}. {npc:3439} стоит в лагере Торговой компании; ключ – у NPC {npc:3445}.",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "Наполните {item:7766} у водопоя свинобразов",
	-- ["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Физзул руководит лагерем Торговой компании в восточном конце места {area:382}. Он нападает на чужаков: выберите его целью и введите /salute, пока он не напал.",
	-- ["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Летите обратно. Цель: {area:380}. Отсюда начинается следующий гайд: дорога на север к месту {area:1703} и в зону {zone:1440}.",
	-- ["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Летите сюда: {area:1637} – изучить ранги 20-го уровня. {npc:3354} – здесь: {object:172958}; {npc:5892} – здесь: {object:172957}.",
	-- ["Fly to {area:1637} to train."] = "Летите сюда: {area:1637} – на обучение.",
	-- ["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Летите сюда: {area:1638} – и изучите ранги 20-го уровня: {npc:3033} – здесь: {area:1639}.",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Летите сюда: {area:1638} – на обучение: {npc:3033} – здесь: {area:1639}.",
	-- ["Follow the {area:458} south to {area:378}."] = "Идите по дороге ({area:458}) на юг. Цель: {area:378}.",
	-- ["He gives you the {item:15826}"] = "Он даст вам {item:15826}",
	-- ["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Затем он предложит {quest:1838} (1838, 30-й уровень): для него нужно место {area:1717}, и оно отправит вас по всему Калимдору и Восточным королевствам. Его описывает классовый гайд воина «{quest:1838}».",
	-- ["Hearth to the {area:380}"] = "Вернуться камнем: {area:380}",
	-- ["Keep it: the {object:107045} is beside {area:272}"] = "Сохраните: {object:107045} – рядом с местом {area:272}",
	-- ["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Сохраните: {npc:12696} ({zone:1440}), следующий гайд",
	-- ["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Сохраните: {npc:5875} ({zone:1454}), в конце этого гайда",
	-- ["Kolkar camp"] = "Лагерь Колкар",
	-- ["Level 20"] = "20-й уровень",
	-- ["Lost Barrens Kodos roam the plains around the Kolkar camp north-west of {npc:3389}; herbalists pick {item:2449} there too."] = "Потерявшиеся степные кодо бродят по равнинам вокруг лагеря Колкар к северо-западу от {npc:3389}; травники там же собирают {item:2449}.",
	-- ["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "На север. Цель: {area:383}. {npc:3682} стоит лагерем под холмами; у отшельника на гребне за ним ({npc:261366}) найдется работа, только когда {npc:3682} отправит вас наверх.",
	-- ["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "По пути обратно на юг по дороге ({area:458}). Цель: {area:378}. {item:277277} – у налетчиков из племени Иглогривых среди лагерей Дыбогривых, по обе стороны дороги к северу от лагеря. Отдайте их NPC {npc:3432} при последнем заходе сюда: {area:380}.",
	-- ["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Езжайте на север от места {area:380}. Цель: {area:384}. Наполните {item:15842} ({object:19464}), затем назад: {npc:3448} ({area:380}). Нет навыка {skill:182}? {npc:3490} рядом с ним продает {item:2449} – по три штуки, пока не обновит запас.",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Патриархи саванны бродят по равнинам к востоку от холмов, среди них лежат сработавшие ловушки. {quest:876} ведет гарпий из стаи Зачарованного Крыла на холмах к западу.",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "К югу от Лагеря Таурахо по местности {area:390} разбросаны курганы силитидов; в них лежат яйца, а на защиту выходят членистоноги Силитида. Силитиды-жнецы редки: если увидите одного, убейте его ради головы.",
	-- ["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "К югу от Ганна дворфы Бейл'дана ведут раскопки ({area:359}). В котловане работают землечерпы и старшины; дневник – у NPC {npc:3392} (26): выманите его одного.",
	-- ["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Оставайтесь незаметными: ключ от башни – у NPC {npc:7287}; Нервотреп и его денежный ящик – наверху. Нервотреп – элита: лучше собрать группу.",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Яркочешуйчатые смертехваты охотятся на равнинах к югу (ориентир: {area:380}), вокруг места {area:1697}; с них падают рога. Сдайте их, когда в следующий раз будете здесь: {area:392}.",
	-- ["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Таурены: {npc:11957} ждет на южном холме над мостом. Небеснорожденные: {npc:272054} стоит к югу от двух мостов. Затем – логова к востоку от озера: выйдите из облика, щелкните по статуе у входа, чтобы получить пять минут незаметности, держитесь подальше от духов внутри и возьмите по одной реликвии каждого вида; {item:280680} лежит у подножия статуи белой кошки.",
	-- ["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Солдаты, ружейники и офицеры Бейл'дана охраняют крепость на восточной стороне раскопок; все три предмета падают с них.",
	-- ["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Лагеря дыбогривых свинобразов раскинулись по равнинам к северу от места {area:378}, по обе стороны дороги ({area:458}). Бивень падает с каждого Дыбогривого; жена NPC {npc:3432} лежит у северного края. Сохраните один предмет: {item:5075}. Здесь иногда бродит серый кодо {quest:883}: его копыто начинает задание.",
	-- ["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "{item:5097} падает с надзирателей и головорезов Торговой компании у рудника в северо-восточном углу зоны.",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "Усики исчезают через пятнадцать минут после выпадения, поэтому соберите их сейчас, по пути на север: убивайте членистоногов Силитида и ползучих силитидов у курганов ({area:390}), пока не наберете пять, затем сразу возвращайтесь камнем. Цель: {area:378}.",
	-- ["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "Классовые задания 20-го уровня в городе {zone:1454} ({npc:3354}, {npc:5892}, учителя чернокнижников и разбойников) выдаются только с 20-го уровня, поэтому доберите уровень здесь, прежде чем лететь. Ближайшие подходящие противники – птенцы грозового змея (18) на равнинах к юго-западу (ориентир: {area:380}) и кентавры из племени Колкар (14-15), здесь: {area:388}; нужно гораздо меньше уровня.",
	-- ["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Пираты стоят лагерем на пляже к югу (ориентир: {area:392}); {npc:3467} – в его южном конце.",
	-- ["The {area:2363}"] = "{area:2363}",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} – ущелье под местом {object:172982}.",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790} лежит у северного края места {area:382}, у башни Торговой компании. В нем – {item:15883} для задания {quest:30}.",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} лежит у северного края места {area:382}, у башни Торговой компании. В нем – {item:15883} для задания {quest:30}.",
	-- ["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Над теми же равнинами к югу от лагеря кружат грозовые змеи-облачники.",
	-- ["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Громоголовы пасутся на равнинах чуть южнее места {area:378}. Среди них бродит синий громоящер {quest:884}: его хвостовой шип начинает задание.",
	-- ["Twitching Antennae"] = "Дергающиеся усики",
	-- ["Twitching Antennae from the silithid"] = "Дергающиеся усики с силитидов",
	-- ["Venture Co. tower"] = "Башня Торговой компании",
	-- ["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "К западу от {npc:3341} племя Иглогривых занимает {area:1701}. {npc:3436} – на восточной стороне, {npc:3434} – на юге, {npc:3435} – в западном конце. Лок (25) и бешенеры (24-25) на несколько уровней выше вас; по гребню иногда ходит редкий элитный {npc:5859}: не трогайте его. Кинжал падает с землепроходцев и ловчих, жезл – с ясновидцев, боевой щит – с бешенеров. Ящеры ({npc:3238}) и многозубые ловцы бродят по равнине между Ганном и гребнем. Над гребнем летает редкий красный ветрокрылый змей {quest:885}: его перо начинает задание.",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Он выводит свой крошшер из лагеря: держитесь рядом и убивайте всех, кто на него нападает. Задание принимает {npc:3442} ({area:392}).",
	-- ["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "убивайте птенцов грозового змея к юго-западу (ориентир: {area:380})",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, на побережье дальше к югу. Медали падают с тераморских стражей бухты и оберегательниц (15-16); {npc:3393} (20) и двое канониров (19) стоят в крепости и на ее стенах – поэтому крепость и ждала до сих пор.",
	-- ["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}: потерявшиеся степные кодо ({npc:3234}) на равнинах вокруг лагеря Колкар",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: используйте половинку здесь: {area:2362}",
	-- ["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449}: продает {npc:3490}; травники собирают на равнинах",
	-- ["{item:2449}: herbalists pick it here"] = "{item:2449}: травники собирают здесь",
	-- ["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} ({area:2361}) отправляет туда друидов по воздуху",
	-- ["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: приветствие от {npc:3033}",
	-- ["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}: используйте на них {item:15826}; они бродят по равнинам вокруг места {area:380}",
	-- ["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} плавает в гавани прямо у причалов ({area:392}). {npc:209797} – элита: лучше собрать группу.",
	-- ["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391} ({area:272}) обучает: Яды – сохраните задание",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{npc:2391} ({area:272}) обучает: {spell:2842} – сохраните задание",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} обучает паладинов ({area:1638}). Маршрута полета туда у вас еще нет: летите сюда: {area:378}, езжайте на запад через зону {zone:1412}, поднимитесь на подъемнике и получите маршрут полета у NPC {npc:2995} на центральном возвышении.",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} и его солдаты удерживают разбитый караван к югу (ориентир: {npc:261366}).",
	-- ["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, на равнине между {npc:3341} и гребнем",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} ждет в небольшом лагере дальше к югу, на дороге к месту {area:359}.",
	-- ["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} стоит у дозорного поста против кентавров Колкар чуть западнее места {area:380}.",
	-- ["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} стоит в лагере племени Колкар к северо-западу от {npc:3389}.",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} ходит среди кентавров из племени Колкар ({area:388}) к юго-востоку от места {area:380}.",
	-- ["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} ведет кентавров из племени Колкар на западном берегу ({area:387}) к югу от {npc:3389}. Отдайте его голову {npc:3389} при последнем заходе сюда: {area:380}.",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} стоит здесь: {object:172960}. Выберите его целью и введите /salute, чтобы выполнить задание {quest:2460}.",
	-- ["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}: яйца – здесь: {area:390}, позже",
	-- ["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Сохраните задание: Кадрак ({area:1703}), следующий гайд",
	-- ["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} предложит {quest:95774}, когда будет сдано задание {quest:4921}",
	-- ["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, рядом с распорядителем ветрокрылов. Сохраните задание: {quest:1483} – в Когтистых горах, позже",
	-- ["{npc:3446}, beside the {object:3972} poster"] = "{npc:3446}, рядом с плакатом ({object:3972})",
	-- ["{npc:3453}, on the dock"] = "{npc:3453}, на причале",
	-- ["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} закован в цепи внутри крепости. Поговорите с ним, чтобы начать сопровождение, и держитесь рядом: на выходе нападут солдаты Терамора. Он доведет вас обратно. Цель: {area:392}.",
	-- ["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} живет здесь: {area:2539} – деревня троллей сразу на входе в Когтистые горы, в конце дороги на запад от {npc:3389}.",
	-- ["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} стоит здесь: {object:172960}. Используйте {item:6626} на круге призыва и победите суккуба, чтобы подчинить ее.",
	-- ["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} стоит лагерем у дороги к востоку (ориентир: {area:380}).",
	-- ["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, чуть западнее {npc:3341}",
	-- ["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} ждет на холме к югу (ориентир: {area:392}), по пути на север.",
	-- ["{npc:5909}, a few steps away"] = "{npc:5909}, в нескольких шагах",
	-- ["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} стоит здесь: {object:172961}, в западной части города.",
	-- ["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} ({zone:1458}), через два гайда",
	-- ["{object:3972} poster"] = "Плакат: {object:3972}",
	-- ["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}: {npc:7233}, у места {area:382}",
	-- ["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, крупный яркочешуйчатый ящер, охотится на равнинах к северу от дороги между местами {area:392} и {area:380}.",
}
