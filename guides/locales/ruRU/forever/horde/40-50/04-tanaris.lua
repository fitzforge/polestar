-- Russian (ruRU): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- {area:1099} Camp Mojache
	["From {area:1099}'s flight master."] = "У распорядителя полетов ({area:1099}).",

	-- Step 2: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, рядом с распорядителем полетов",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "{object:150075} на площади",

	-- Step 3: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "К западу от Прибамбасска используйте предмет {item:8584} у водопоя в лагере троллей.",

	-- Step 5: Caliph Scorpidsting
	-- {npc:7847} Caliph Scorpidsting
	["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "К юго-востоку от Прибамбасска в дюнах стоят лагерем бандиты Скитальцев Пустыни; {npc:7847} – в восточном лагере.",

	-- Step 6: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "На запад по дороге на юг; {npc:7771} стоит лагерем у руин ({area:1938}). Наденьте его предмет {item:9978}: он показывает закопанные украшения – здесь и вокруг места {area:983}.",

	-- Step 7: The Noxious Lair
	["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "К западу насекомые-сентипаары роятся у своих ульев; части тел падают с любого.",

	-- Step 8: Dunemaul Compound
	-- {area:982} The Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "К югу от места {area:982} огры клана Песчаного Молота занимают свой лагерь, {npc:12046} – в его восточной части. Между боями выкапывайте украшения ({quest:3161}).",

	-- Step 9: Thistleshrub Valley
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "К западу от лагеря долину заполняют кактусовые существа; росяная железа – только у собирателей росы. С большинства монстров ({zone:1446}) изредка падает аварийный маяк КПХ-17/TN: сохраните его, если выпадет.",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, редкая добыча",

	-- Step 10: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Сопровождение: {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} ждет в долине. Доведите его до жены ({npc:6015}, {area:977}) на северо-восток через пустыню: держитесь рядом, не спешите и отбивайтесь от нападающих. Не садитесь на транспорт и не используйте камень возвращения. {npc:8579} тоже стоит в порту.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride south-west to {area:976}."] = "Езжайте на юго-запад сюда: {area:976}.",
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "{item:8526} растет здесь: {zone:1425}, примерно на 48-м уровне",

	-- Step 12: Marvon Rivetseeker
	["South down the road again."] = "Снова на юг по дороге.",

	-- Step 13: Scrimshank's gear
	["Scrimshank's gear"] = "Устройство Холстомера",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Дальше к югу обозревательное устройство младшего геодезиста лежит у входа в улей сентипааров.",

	-- Step 14: OOX-17/TN
	["OOX-17/TN"] = "КПХ-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "Только с аварийным маяком: КПХ-17/TN сидит к юго-востоку от улья. Сопроводите его на север сюда: {area:977}; награда ждет у Карлса Пропеллерза ({area:35}).",

	-- Step 15: Gadgetzan
	-- {npc:7010} Zilzibin Drumlore · {area:1637} Orgrimmar
	["for {npc:7010} in {area:1637}, around level 50"] = "для персонажа {npc:7010} ({area:1637}), примерно на 50-м уровне",

	-- Step 16: Orgrimmar
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {area:392} Ratchet
	["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "Летите сюда: {area:1637} и обучитесь: в следующем руководстве обучение будет здесь: {zone:1458}, а там нет учителей охотников и шаманов. Затем летите сюда: {area:392}.",

	-- Step 17: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:392} Ratchet
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "Летите сюда: {area:1638}, учитель: {npc:3033} ({area:1639}), затем летите сюда: {area:392}.",

	-- Step 18: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Летите сюда: {area:392}",

	-- Step 19: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Корабль: {area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "Корабль ({area:35}) причаливает к пирсу ({area:392}) под холмом распорядителя полетов.",
	-- {area:392} Ratchet
	["{area:392} pier"] = "Пирс: {area:392}",

	-- Step 20: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Летите сюда: {area:340}",
	-- {area:35} Booty Bay
	["From the {area:35} flight master, above the harbour."] = "У распорядителя полетов ({area:35}) над гаванью.",

	-- Step 21: The Grimesilt Dig Site
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Через перевал на западе ({area:340}) езжайте в край {zone:1427}, затем на юго-запад к раскопкам. {object:173265} стоит в южной части; геологи из клана Черного Железа копают чуть к северу. Принесите 15 шт.: {item:4306} (продается на аукционе).",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "{object:173265}",

	-- Step 22: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Езжайте на северо-запад через ущелье; {area:1446} – лагерь в лесах на северо-западе.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Доска: {object:179827}",

	-- Step 23: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "Каларан стоит один к югу от места {area:1446}, на краю Котлована. Выслушайте его историю.",

	-- Step 24: The Cauldron
	-- {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster
	["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Тяжелые боевые големы патрулируют Котлован под Калараном – с них падает масло; с элементалей магмы и пылающих элементалей среди них падают сердца. Надсмотрщики и поработители из клана Черного Железа гонят рабов по тропам; с поработителя может упасть {item:11818}: сохраните его.",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, редкая добыча",

	-- Step 26: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "Горны кузнецов",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Кузнецы из клана Черного Железа работают у горнов в центре Котлована; у половины – {item:10551}, у каждого десятого – {item:18959}. Кинжалы есть также у рабов, поработителей и надсмотрщиков.",

	-- Step 27: Kalaran Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "Для следующей просьбы нужен предмет {item:10552} с элитных культистов: не берите ее.",

	-- Step 28: The Slag Pit
	-- {area:1443} The Slag Pit
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} – на севере Котлована. В лавовых озерах плавают пламезавры: выманивайте их к краю. Секретные планы лежат на верхнем уступе ямы.",

	-- Step 29: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Опаляющие лавовые пауки",
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Опаляющие лавовые пауки бродят по плато и лавовым озерам на юго-западе ущелья.",

	-- Step 30: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Наблюдатели из клана Черного Железа",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Наблюдатели из клана Черного Железа стоят на хребтах у сторожевых башен к югу от Котлована; {item:18960} – примерно у каждого десятого.",

	-- Step 31: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "Только с предметом {item:11818}: назад на восток к раскопкам ({object:173265}).",

	-- Step 32: Thorium Point
	-- {area:1446} Thorium Point · {area:75} Stonard
	["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Возвращайтесь на север сюда: {area:1446}. Оставайтесь здесь: следующее руководство начинается с полета сюда: {area:75}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "К югу от места {area:982} огры клана Песчаного Молота занимают свой лагерь, {npc:12046} – в его восточной части. Между боями выкапывайте украшения ({quest:3161}).",
}
