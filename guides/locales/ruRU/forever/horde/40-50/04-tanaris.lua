-- Russian (ruRU): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:976} Gadgetzan · {zone:1427} Searing Gorge · {npc:5955} Tooga · {area:1446} Thorium Point
	-- was: ["{area:976} and the {zone:1427} at 46-48: the Wastewander camps, {npc:5955}'s escort and {area:1446}."] = "{area:976} и {zone:1427} на 46-48-м уровне: лагеря Скитальцев Пустыни, сопровождение NPC {npc:5955} и {area:1446}."
	["{area:976} and the {zone:1427} at 48-49: the Wastewander camps, {npc:5955}'s escort and {area:1446}."] = "",

	-- Step 2: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Распорядитель полетов: {area:1099}",

	-- Step 3: Gadgetzan
	-- {npc:7876} Tran'rek · {area:979} Sandsorrow Watch
	["The flight lands beside {npc:7876}. Take the town's quests before riding west to {area:979}."] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, рядом с распорядителем полетов",
	-- {npc:11758} Andi Lynn · {area:1938} Broken Pillar
	["{npc:11758}: keep it, the Dunemaul ogres and Gor'marok (49) wait for the {area:1938} at about 52, at the end of 40-50/06"] = "{npc:11758}: сохраните задание, огры Песчаной Бури и Гор'марок (49) подождут до {area:1938} примерно на 52-м уровне, в конце 40-50/06",

	-- Step 4: Senior Surveyor Fizzledowser
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Вы пропустили это при прошлом посещении этих мест по маршруту: теперь это идёт первым. Это быстро и открывает следующие задания.",

	-- Step 5: Gadgetzan
	-- {area:978} Zul'Farrak · {area:979} Sandsorrow Watch · {npc:7407} Chief Engineer Bilgewhizzle · {quest:2768} Divino-matic Rod · {quest:2864} Tran'rek
	["For your {area:978} run, after {area:979}: {npc:7407}, by the water tower, wants his {quest:2768} back; {quest:2864} his scarab shells and Trenton Lighthammer Troll Temper, if you have not taken those yet."] = "Для подземелья {area:978}, после места {area:979}: {npc:7407} у водонапорной башни просит вернуть его {quest:2768}; {quest:2864} – панцири скарабеев, а Трентон Легкий Молот – закалку троллей, если вы еще не взяли эти задания.",

	-- Step 7: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "К западу от Прибамбасска используйте предмет {item:8584} у водопоя в лагере троллей.",

	-- Step 8: Zul'Farrak
	-- {area:978} Zul'Farrak · {quest:3042} Troll Temper · {npc:7604} Sergeant Bly · {quest:2768} Divino-matic Rod
	["{area:978} is a dungeon for a group of five; its quests here are level 45 to 47. Its gate lies about 400 yards north of the troll camp's water hole.\nInside: the Scarabs drop the shells, every Sandfury troll can drop {quest:3042}, and {npc:7604} carries the {quest:2768}."] = "{area:978} – подземелье для группы из пяти игроков; его задания здесь – 45-47-го уровня. Ворота – примерно в 400 ярдах к северу от водопоя в лагере троллей.\nВнутри: со скарабеев падают панцири, с любого тролля из племени Песчаной Бури может упасть {quest:3042}, а {quest:2768} – у NPC {npc:7604}.",
	-- {quest:2865} Scarab Shells
	["{quest:2865}: the Scarabs, inside"] = "{quest:2865}: скарабеи, внутри",
	-- {quest:3042} Troll Temper
	["{quest:3042}: the Sandfury trolls, inside"] = "{quest:3042}: тролли из племени Песчаной Бури, внутри",
	-- {quest:2768} Divino-matic Rod · {npc:7604} Sergeant Bly
	["{quest:2768}: {npc:7604}, inside"] = "{quest:2768}: {npc:7604}, внутри",

	-- Step 9: Senior Surveyor Fizzledowser
	-- {area:976} Gadgetzan · {npc:7771} Marvon Rivetseeker
	["Back east to Fizzledowser on the west side of {area:976}; {npc:7771} is south from there."] = "",

	-- Step 10: Tran'rek
	-- {area:978} Zul'Farrak · {npc:7876} Tran'rek
	["Your {area:978} scarab shells: {npc:7876}, beside the wind rider master."] = "Панцири скарабеев из подземелья {area:978}: {npc:7876}, рядом с распорядителем полетов.",

	-- Step 11: Chief Engineer Bilgewhizzle
	-- {quest:2768} Divino-matic Rod · {npc:7407} Chief Engineer Bilgewhizzle
	["The {quest:2768}: {npc:7407}, by the water tower."] = "{quest:2768}: {npc:7407}, у водонапорной башни.",

	-- Step 12: Trenton Lighthammer
	-- {quest:3042} Troll Temper · {npc:7804} Trenton Lighthammer
	["The {quest:3042}: {npc:7804}, a short walk from the flight master."] = "{quest:3042}: {npc:7804}, недалеко от распорядителя полетов.",

	-- Step 13: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "На запад по дороге на юг; {npc:7771} стоит лагерем у руин ({area:1938}). Наденьте его предмет {item:9978}: он показывает закопанные украшения – здесь и вокруг места {area:983}.",

	-- Step 14: Gahz'ridian ornaments
	-- {quest:3161} Gahz'ridian
	["{quest:3161} ornaments"] = "{quest:3161}",
	-- {quest:3161} Gahz'ridian · {area:1938} Broken Pillar · {area:983} Dunemaul Compound · {npc:12046} Gor'marok the Ravager
	["Dig up the {quest:3161} ornaments around the {area:1938} and north of the {area:983}. Leave the ogres for now: {npc:12046} is 49 and the Brutes 46-48; the {area:983} comes at the end of 40-50/06, at about 52."] = "Выкапывайте газ'ридианские украшения ({quest:3161}) у места {area:1938} и к северу от места {area:983}. Огров пока оставьте: {npc:12046} 49-го уровня, а громилы 46-48-го; {area:983} – в конце 40-50/06, примерно на 52-м уровне.",

	-- Step 15: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["West, the Centipaar insects swarm around their hives; any of them drops the parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you. The Sandreavers are 49-50: take the Workers and Tunnelers."] = "На западе вокруг своих ульев роятся насекомые-сентипаары; части падают с любого из них.\nОсторожно: членистоноги-сентипаары применяют {npc:4196} в бою и вне боя, призывая мелких существ, которые прерывают вас. Песчаные разорители 49-50-го уровня: бейте рабочих и проходчиков.",

	-- Step 16: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {zone:1446} Tanaris · {quest:2864} Tran'rek · {area:1938} Broken Pillar
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors (47-48) carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one.\nCareful: The other thistleshrub mobs in the area are level 48-50 and wander a lot, so you can easily pull extra mobs: take the Dew Collectors at the valley's edge, and leave {quest:2864}'s Gnarled Thistleshrubs and Rootshapers for the {area:1938} ride into Un'Goro at about 51."] = "К западу от лагеря долину заполняют кактусовые существа; росяная железа – только у собирателей росы (47-48). С большинства монстров ({zone:1446}) изредка падает аварийный маяк КПХ-17/TN: сохраните его, если выпадет.\nОсторожно: другие тернистые существа в округе 48-50-го уровня и много бродят, так что легко привлечь лишних противников: бейте собирателей росы на краю долины, а бугристых шипошкуров и формирователей корней для NPC {quest:2864} оставьте на поездку через {area:1938} в Ун'Горо примерно на 51-м уровне.",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, редкая добыча",

	-- Step 17: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Сопровождение: {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} ждет в долине. Доведите его до жены ({npc:6015}, {area:977}) на северо-восток через пустыню: держитесь рядом, не спешите и отбивайтесь от нападающих. Не садитесь на транспорт и не используйте камень возвращения. {npc:8579} тоже стоит в порту.",

	-- Step 19: Slake That Thirst
	-- {spell:686} Shadow Bolt
	["Careful: Shadow Mages (level 42-43) call a Voidwalker while out of combat and attack with Immolate and {spell:686}. Thieves can Disarm you, Rogues move around in Sneak, and Assassins use Execute once you are at 20% health or less."] = "",

	-- Step 20: Gadgetzan
	-- {quest:654} Tanaris Field Sampling
	["Keep the Model 4711-FTZ Power Source Bilgewhizzle gave you: it starts {quest:654}, a two-hour timer, so use it on the way back north from Scrimshank's hive."] = "Сохраните источник энергии модели 4711-FTZ, который дал вам Трюмогуд: он начинает задание {quest:654} с двухчасовым таймером, так что используйте его на обратном пути на север от улья Холстомера.",

	-- Step 21: Gadgetzan
	-- {quest:2864} Tran'rek · {quest:3362} Thistleshrub Valley · {area:983} Dunemaul Compound · {area:1938} Broken Pillar
	["Keep {quest:2864}'s {quest:3362}: its Rootshapers (49-50) come with the {area:983} at the {area:1938}, on the way into Un'Goro at about 51."] = "Сохраните задание {quest:3362} от NPC {quest:2864}: его формирователи корней (49-50) – вместе с {area:983} у места {area:1938}, по пути в Ун'Горо примерно на 51-м уровне.",
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "{item:8526} растет здесь: {zone:1425}, примерно на 48-м уровне",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, внутри",
	-- {npc:11758} Andi Lynn · {area:983} Dunemaul Compound · {area:1938} Broken Pillar
	["{npc:11758}'s {area:983} stays in your log for the {area:1938} at about 52."] = "Задание {area:983} от NPC {npc:11758} остается в журнале до места {area:1938} примерно на 52-м уровне.",

	-- Step 23: Scrimshank's gear
	["Scrimshank's gear"] = "Устройство Холстомера",
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Pull the bug guarding Scrimshank's gear out to the hive mouth, then take the gear. Careful: do not follow patrols into the tunnels; Centipaar Swarmers and Sandreavers there reach level 50."] = "",
	["Below ground"] = "Под землей",

	-- Step 24: OOX-17/TN
	["OOX-17/TN"] = "КПХ-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}.\nCareful: The escort has two ambushes. Three level 47 scorpids attack near the start. Near the end, by the beach, three Wastewander humans attack: one mage and two assassins, around level 44."] = "Только с аварийным маяком: КПХ-17/TN сидит к юго-востоку от улья. Сопроводите его на север сюда: {area:977}; награда ждет у Карлса Пропеллерза ({area:35}).\nОсторожно: в пути будут две засады. В начале нападают три скорпида 47-го уровня. Ближе к концу, у пляжа, нападают трое людей из Скитальцев Пустыни: маг и два убийцы, около 44-го уровня.",

	-- Step 25: Tanaris Field Sampling
	-- {area:976} Gadgetzan · {item:8524} Model 4711-FTZ Power Source
	-- plural, as words: Blisterpaw Hyenas = {npc:5426} Blisterpaw Hyena · Glasshide Basilisks = {npc:5419} Glasshide Basilisk · Scorpid Hunters = {npc:5422} Scorpid Hunter
	["Back north, just south of {area:976}, use the {item:8524} now: the two-hour timer starts. The Blisterpaw Hyenas, Glasshide Basilisks and Scorpid Hunters share the dunes here. Each can drop an untested sample: use it, and it either passes as an acceptable one or is lost. Keep killing until you have eight of each."] = "Вернувшись на север, чуть южнее места {area:976}, используйте предмет {item:8524}: запустится двухчасовой таймер. Гиены Ядовитой Лапы, стеклошкурые василиски и скорпиды-охотники обитают здесь в дюнах. С каждого может упасть непроверенный образец: используйте его – он либо окажется пригодным, либо пропадет. Убивайте, пока не соберете по восемь образцов каждого вида.",
	-- {item:8524} Model 4711-FTZ Power Source
	["Use the {item:8524}"] = "Используйте предмет {item:8524}",

	-- Step 26: Gadgetzan
	-- {npc:5204} Apothecary Zinge · {zone:1458} Undercity
	["for {npc:5204} in the {zone:1458}, around level 52"] = "",
	-- {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["for {npc:7010} in {zone:1454}, around level 50"] = "для персонажа {npc:7010} ({zone:1454}), примерно на 50-м уровне",

	-- Step 27: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Корабль: {area:16727}",

	-- Step 28: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "В зону {zone:1427}",

	-- Step 29: Searing Gorge
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",

	-- Step 30: The Grimesilt Dig Site
	-- {area:16727} Powderfuse Port · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:16727}, ride into the {zone:1427} by its eastern pass, then west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Из места {area:16727} езжайте в край {zone:1427} через восточный перевал, затем на запад к раскопкам. {object:173265} стоит в южной части; геологи из клана Черного Железа копают чуть к северу. Принесите 15 шт.: {item:4306} (продается на аукционе).",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "{object:173265}",

	-- Step 32: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Езжайте на северо-запад через ущелье; {area:1446} – лагерь в лесах на северо-западе.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Доска: {object:179827}",

	-- Step 33: The Cauldron's slavers and golems
	-- {area:246} The Cauldron
	["{area:246}'s slavers and golems"] = "",
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	-- plural, as words: Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Heavy War Golems = {npc:5854} Heavy War Golem
	["Ride south from {area:1446} into the Cauldron: the Dark Iron Taskmasters and Slavers drive the slaves on the paths, and the Heavy War Golems patrol the floor below {npc:8479}. Careful: the biggest golems are 49: pull them one at a time."] = "Езжайте на юг от места {area:1446} в Котлован: надсмотрщики и поработители из клана Черного Железа гоняют рабов по тропам, а тяжелые боевые големы патрулируют дно ниже места, где стоит {npc:8479}. Осторожно: самые крупные големы 49-го уровня: привлекайте их по одному.",

	-- Step 34: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "{npc:8479} стоит один к югу от места {area:1446}, на краю Котлована. Выслушайте его историю.",

	-- Step 37: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427}: убивайте их по пути",
	-- {npc:8479} Velarok Windblade · {item:11818} Grimesilt Outhouse Key · {area:1443} The Slag Pit
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Searing Lava Spiders = {npc:5858} Searing Lava Spider · Incendosaurs = {npc:9318} Incendosaur · Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Heavy War Golems patrol the Cauldron below {npc:8479} and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Searing Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee. The biggest Incendosaurs and Lava Spiders are 49: pull them one at a time."] = "Тяжелые боевые големы патрулируют Котлован ниже места, где стоит {npc:8479}, с них падает масло; с бродящих среди них магмовых и пылающих элементалей падают сердца. Надсмотрщики и поработители из клана Черного Железа гоняют рабов по тропам; с поработителя может упасть {item:11818}: сохраните его.\nБольшие лавовые пауки бродят по плато и лавовым озерам на юго-западе ущелья.\n{area:1443} – на севере Котлована. Пламезавры плавают в его лавовых озерах: выманивайте их к краю. Секретные чертежи лежат на верхнем уступе ямы.\nОсторожно: поработители из клана Черного Железа (45-46-го уровня) зовут на помощь союзников в радиусе 15 м, бросают сеть с 15 м и применяют Кровопускание в ближнем бою. Самые крупные пламезавры и лавовые пауки 49-го уровня: привлекайте их по одному.",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, редкая добыча",
	-- {area:1443} The Slag Pit
	["Below ground: the plans, on the {area:1443}'s upper ledge"] = "Под землей: чертежи, на верхнем уступе ({area:1443})",

	-- Step 39: Thorium Point
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	["Ride back north to {area:1446}, just past {npc:8479}."] = "Возвращайтесь на север к месту {area:1446}, сразу за NPC {npc:8479}.",

	-- Step 40: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "Горны кузнецов",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Кузнецы из клана Черного Железа работают у горнов в центре Котлована; у половины – {item:10551}, у каждого десятого – {item:18959}. Кинжалы есть также у рабов, поработителей и надсмотрщиков.",

	-- Step 41: Velarok Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "Для следующей просьбы нужен предмет {item:10552} с элитных культистов: не берите ее.",

	-- Step 42: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Наблюдатели из клана Черного Железа",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Наблюдатели из клана Черного Железа стоят на хребтах у сторожевых башен к югу от Котлована; {item:18960} – примерно у каждого десятого.",

	-- Step 43: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "Только с предметом {item:11818}: назад на восток к раскопкам ({object:173265}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Корабль: {area:35}",
	-- ["Dark Iron Lookouts"] = "Наблюдатели из клана Черного Железа",
	-- ["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "Летите сюда: {area:1637} и обучитесь: в следующем руководстве обучение будет здесь: {zone:1458}, а там нет учителей охотников и шаманов. Затем летите сюда: {area:392}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "Летите сюда: {area:1638}, учитель: {npc:3033} ({area:1639}), затем летите сюда: {area:392}.",
	-- ["Fly to {area:340}"] = "Летите сюда: {area:340}",
	-- ["Fly to {area:392}"] = "Летите сюда: {area:392}",
	-- ["From the {area:35} flight master, above the harbour."] = "У распорядителя полетов ({area:35}) над гаванью.",
	-- ["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Дальше к югу обозревательное устройство младшего геодезиста лежит у входа в улей сентипааров.",
	-- ["Greater Lava Spiders"] = "Опаляющие лавовые пауки",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Тяжелые боевые големы патрулируют Котлован под Калараном – с них падает масло; с элементалей магмы и пылающих элементалей среди них падают сердца. Надсмотрщики и поработители из клана Черного Железа гонят рабов по тропам; с поработителя может упасть {item:11818}: сохраните его.",
	-- ["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Возвращайтесь на север сюда: {area:1446}. Оставайтесь здесь: следующее руководство начинается с полета сюда: {area:75}.",
	-- ["Ride south-west to {area:976}."] = "Езжайте на юго-запад сюда: {area:976}.",
	-- ["South down the road again."] = "Снова на юг по дороге.",
	-- ["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "К югу от места {area:982} огры клана Песчаного Молота занимают свой лагерь, {npc:12046} – в его восточной части. Между боями выкапывайте украшения ({quest:3161}).",
	-- ["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "К юго-востоку от Прибамбасска в дюнах стоят лагерем бандиты Скитальцев Пустыни; {npc:7847} – в восточном лагере.",
	-- ["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Наблюдатели из клана Черного Железа стоят на хребтах у сторожевых башен к югу от Котлована; {item:18960} – примерно у каждого десятого.",
	-- ["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Кузнецы из клана Черного Железа работают у горнов в центре Котлована; у половины – {item:10551}, у каждого десятого – {item:18959}. Кинжалы есть также у рабов, поработителей и надсмотрщиков.",
	-- ["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Опаляющие лавовые пауки бродят по плато и лавовым озерам на юго-западе ущелья.",
	-- ["The Steamsmiths' furnaces"] = "Горны кузнецов",
	-- ["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "Корабль ({area:35}) причаливает к пирсу ({area:392}) под холмом распорядителя полетов.",
	-- ["The {object:142071} machine, in the middle of town: the egg is in southern {zone:1444}, around level 50"] = "Устройство {object:142071} в центре города: яйцо находится на юге края {zone:1444}, примерно на 50-м уровне",
	-- ["Velarok Windblade"] = "Веларок Клинок Ветра",
	-- ["Velarok stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "Веларок стоит один к югу от места {area:1446}, на краю Котлована. Выслушайте его историю.",
	-- ["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "К западу от лагеря долину заполняют кактусовые существа; росяная железа – только у собирателей росы. С большинства монстров ({zone:1446}) изредка падает аварийный маяк КПХ-17/TN: сохраните его, если выпадет.\nОсторожно: другие тернистые существа в округе 49-50-го уровня и много бродят, так что легко привлечь лишних противников.",
	-- ["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "К западу насекомые-сентипаары роятся у своих ульев; части тел падают с любого.",
	-- ["the {object:150075} in the square"] = "{object:150075} на площади",
	-- ["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} – на севере Котлована. В лавовых озерах плавают пламезавры: выманивайте их к краю. Секретные планы лежат на верхнем уступе ямы.",
	-- ["{area:392} pier"] = "Пирс: {area:392}",
	-- ["{area:976} and the {zone:1427} at 46-48: the Wastewander camps, {npc:5955}'s escort and {area:1446}."] = "{area:976} и {zone:1427} на 46-48-м уровне: лагеря Скитальцев Пустыни, сопровождение NPC {npc:5955} и {area:1446}.",
}
