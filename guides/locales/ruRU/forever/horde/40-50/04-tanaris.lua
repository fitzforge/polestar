-- Russian (ruRU): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 3: Gadgetzan
	-- {npc:7876} Tran'rek · {area:979} Sandsorrow Watch
	["The flight lands beside {npc:7876}. Take the town's quests before riding west to {area:979}."] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, рядом с распорядителем полетов",

	-- Step 5: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "К западу от Прибамбасска используйте предмет {item:8584} у водопоя в лагере троллей.",

	-- Step 6: Senior Surveyor Fizzledowser
	-- {area:976} Gadgetzan · {npc:7771} Marvon Rivetseeker
	["Back east to Fizzledowser on the west side of {area:976}; {npc:7771} is south from there."] = "",

	-- Step 7: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "На запад по дороге на юг; {npc:7771} стоит лагерем у руин ({area:1938}). Наденьте его предмет {item:9978}: он показывает закопанные украшения – здесь и вокруг места {area:983}.",

	-- Step 8: Broken Pillar: kill these as you meet them
	-- {area:1938} Broken Pillar
	["{area:1938}: kill these as you meet them"] = "",
	-- {area:982} Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "К югу от места {area:982} огры клана Песчаного Молота занимают свой лагерь, {npc:12046} – в его восточной части. Между боями выкапывайте украшения ({quest:3161}).",
	["Below ground"] = "",

	-- Step 9: Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["West, the Centipaar insects swarm around their hives; any of them drops the parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, редкая добыча",

	-- Step 11: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Сопровождение: {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} ждет в долине. Доведите его до жены ({npc:6015}, {area:977}) на северо-восток через пустыню: держитесь рядом, не спешите и отбивайтесь от нападающих. Не садитесь на транспорт и не используйте камень возвращения. {npc:8579} тоже стоит в порту.",

	-- Step 13: Slake That Thirst
	-- {spell:686} Shadow Bolt
	["Careful: Shadow Mages (level 42-43) call a Voidwalker while out of combat and attack with Immolate and {spell:686}. Thieves can Disarm you, Rogues move around in Sneak, and Assassins use Execute once you are at 20% health or less."] = "",

	-- Step 14: Gadgetzan
	["Use the Model 4711-FTZ Power Source Bilgewhizzle gave you: a two-hour timer starts"] = "",

	-- Step 15: Gadgetzan
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "{item:8526} растет здесь: {zone:1425}, примерно на 48-м уровне",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 16: Tanaris Field Sampling
	-- {area:976} Gadgetzan
	-- plural, as words: Blisterpaw Hyenas = {npc:5426} Blisterpaw Hyena · Glasshide Basilisks = {npc:5419} Glasshide Basilisk · Scorpid Hunters = {npc:5422} Scorpid Hunter
	["Just south of {area:976} the Blisterpaw Hyenas, Glasshide Basilisks and Scorpid Hunters share the dunes. Each can drop an untested sample: use it, and it either passes as an acceptable one or is lost. Keep killing until you have eight of each."] = "",

	-- Step 18: Scrimshank's gear
	["Scrimshank's gear"] = "Устройство Холстомера",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "",

	-- Step 19: OOX-17/TN
	["OOX-17/TN"] = "КПХ-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}.\nCareful: The escort has two ambushes. Three level 47 scorpids attack near the start. Near the end, by the beach, three Wastewander humans attack: one mage and two assassins, around level 44."] = "",

	-- Step 20: Gadgetzan
	-- {npc:5204} Apothecary Zinge · {zone:1458} Undercity
	["for {npc:5204} in the {zone:1458}, around level 52"] = "",
	-- {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["for {npc:7010} in {zone:1454}, around level 50"] = "для персонажа {npc:7010} ({zone:1454}), примерно на 50-м уровне",

	-- Step 21: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",

	-- Step 22: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "",

	-- Step 23: Searing Gorge
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",

	-- Step 24: The Grimesilt Dig Site
	-- {area:16727} Powderfuse Port · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:16727}, ride into the {zone:1427} by its eastern pass, then west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "{object:173265}",

	-- Step 26: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Езжайте на северо-запад через ущелье; {area:1446} – лагерь в лесах на северо-западе.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Доска: {object:179827}",

	-- Step 27: The Cauldron's slavers and golems
	-- {area:246} The Cauldron
	["{area:246}'s slavers and golems"] = "",
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	-- plural, as words: Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Heavy War Golems = {npc:5854} Heavy War Golem
	["Ride south from {area:1446} into the Cauldron: the Dark Iron Taskmasters and Slavers drive the slaves on the paths, and the Heavy War Golems patrol the floor below {npc:8479}."] = "",

	-- Step 28: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "",

	-- Step 31: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "",
	-- {npc:8479} Velarok Windblade · {item:11818} Grimesilt Outhouse Key · {area:1443} The Slag Pit
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Greater Lava Spiders = {npc:5858} Greater Lava Spider · Incendosaurs = {npc:9318} Incendosaur · Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Heavy War Golems patrol the Cauldron below {npc:8479} and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, редкая добыча",

	-- Step 33: Thorium Point
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	["Ride back north to {area:1446}, just past {npc:8479}."] = "",

	-- Step 34: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "Горны кузнецов",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Кузнецы из клана Черного Железа работают у горнов в центре Котлована; у половины – {item:10551}, у каждого десятого – {item:18959}. Кинжалы есть также у рабов, поработителей и надсмотрщиков.",

	-- Step 35: Velarok Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "Для следующей просьбы нужен предмет {item:10552} с элитных культистов: не берите ее.",

	-- Step 37: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Наблюдатели из клана Черного Железа",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Наблюдатели из клана Черного Железа стоят на хребтах у сторожевых башен к югу от Котлована; {item:18960} – примерно у каждого десятого.",

	-- Step 38: The Key to Freedom
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
	-- ["From {area:1099}'s flight master."] = "У распорядителя полетов ({area:1099}).",
	-- ["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Дальше к югу обозревательное устройство младшего геодезиста лежит у входа в улей сентипааров.",
	-- ["Greater Lava Spiders"] = "Опаляющие лавовые пауки",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Тяжелые боевые големы патрулируют Котлован под Калараном – с них падает масло; с элементалей магмы и пылающих элементалей среди них падают сердца. Надсмотрщики и поработители из клана Черного Железа гонят рабов по тропам; с поработителя может упасть {item:11818}: сохраните его.",
	-- ["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "Каларан стоит один к югу от места {area:1446}, на краю Котлована. Выслушайте его историю.",
	-- ["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "Только с аварийным маяком: КПХ-17/TN сидит к юго-востоку от улья. Сопроводите его на север сюда: {area:977}; награда ждет у Карлса Пропеллерза ({area:35}).",
	-- ["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Возвращайтесь на север сюда: {area:1446}. Оставайтесь здесь: следующее руководство начинается с полета сюда: {area:75}.",
	-- ["Ride south-west to {area:976}."] = "Езжайте на юго-запад сюда: {area:976}.",
	-- ["South down the road again."] = "Снова на юг по дороге.",
	-- ["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "К юго-востоку от Прибамбасска в дюнах стоят лагерем бандиты Скитальцев Пустыни; {npc:7847} – в восточном лагере.",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Через перевал на западе ({area:340}) езжайте в край {zone:1427}, затем на юго-запад к раскопкам. {object:173265} стоит в южной части; геологи из клана Черного Железа копают чуть к северу. Принесите 15 шт.: {item:4306} (продается на аукционе).",
	-- ["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Наблюдатели из клана Черного Железа стоят на хребтах у сторожевых башен к югу от Котлована; {item:18960} – примерно у каждого десятого.",
	-- ["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Кузнецы из клана Черного Железа работают у горнов в центре Котлована; у половины – {item:10551}, у каждого десятого – {item:18959}. Кинжалы есть также у рабов, поработителей и надсмотрщиков.",
	-- ["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Опаляющие лавовые пауки бродят по плато и лавовым озерам на юго-западе ущелья.",
	-- ["The Steamsmiths' furnaces"] = "Горны кузнецов",
	-- ["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "Корабль ({area:35}) причаливает к пирсу ({area:392}) под холмом распорядителя полетов.",
	-- ["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "К западу от лагеря долину заполняют кактусовые существа; росяная железа – только у собирателей росы. С большинства монстров ({zone:1446}) изредка падает аварийный маяк КПХ-17/TN: сохраните его, если выпадет.",
	-- ["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "К западу насекомые-сентипаары роятся у своих ульев; части тел падают с любого.",
	-- ["the {object:150075} in the square"] = "{object:150075} на площади",
	-- ["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} – на севере Котлована. В лавовых озерах плавают пламезавры: выманивайте их к краю. Секретные планы лежат на верхнем уступе ямы.",
	-- ["{area:392} pier"] = "Пирс: {area:392}",
}
