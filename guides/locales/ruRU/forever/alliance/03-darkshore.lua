-- Russian (ruRU): the guide forever/alliance/03-darkshore (forever/alliance/03-darkshore.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Корабль причаливает к западу от деревни. Распорядитель полетов стоит на холме к югу от таверны; дающие задания – вдоль главной улицы.",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, by the inn"] = "{npc:3666} – у таверны",
	["The WANTED poster outside the inn"] = "Плакат «РАЗЫСКИВАЕТСЯ» у таверны",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644} – на пристани",
	-- {npc:10216} Gubber Blump · {skill:356} Fishing
	["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216} – на пристани: только с навыком {skill:356}",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649} – в северной части деревни",

	-- Step 2: The beach
	["The beach"] = "Пляж",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Прибрежные крабы снуют по берегу под деревней; {quest:983} стоит на пляже чуть южнее пристани. На мелководье плавают крепкозубы Темного берега. {object:175207} лежит на берегу чуть южнее деревни.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg
	["Crawler Legs"] = "Ножки краба",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes"] = "Глаза крепкозуба",
	-- {item:12238} Darkshore Grouper
	["{item:12238}: fish from the pier"] = "{item:12238}: ловите с пристани",

	-- Step 4: The skeletal turtle
	["The skeletal turtle"] = "Скелет черепахи",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks"] = "{item:12289} – на пляже к западу от пристани",

	-- Step 5: Plagued bears
	["Plagued bears"] = "Больные медведи",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {quest:2139} on one and lead it back to him."] = "Бешеные колючешерстные медведи бродят по холмам чуть восточнее (ориентир: {area:442}). Примените на одном предмет из задания «{quest:2139}» и приведите медведя к нему.",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Медведи и лагерь Чернолесья",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "Убивайте бешеных колючешерстных медведей на холмах к востоку (ориентир: {area:442}), затем поднимитесь к лагерю фурболгов к юго-востоку от них: убивать там пока никого не нужно.",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} стоит у северного края руин. Там обитают проклятые, терзаемые высокорожденные и {npc:2178}; среди них бродит призрак – {npc:3667}, к востоку кружит сова {npc:270196}. Обе скрижали лежат в руинах; {quest:4722} – на берегу к западу от них.",
	["Read both tablets"] = "Прочитайте обе скрижали",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Реликвии высокорожденных",

	-- Step 8: The red crystal
	["The red crystal"] = "Красный кристалл",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Поднимитесь в горы к востоку (ориентир: {area:447}); {object:175524} лежит на уступе.",

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins."] = "На север вдоль холмов. {npc:3650} ждет в руинах ({quest:954}); там полно диких греллей и коварных греллей, на восточном краю – сатиры из племени Дет'рилл. {quest:1001} стоит у дороги к западу от руин.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Серьги грелля",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: сатиры из племени Дет'рилл",

	-- Step 10: The Tower of Althalaxx
	-- {quest:954} Bashal'Aran · {quest:1002} Buzzbox 323
	["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower."] = "",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "Клыки лунопарда",

	-- Step 11: Hearth to Auberdine
	-- {area:442} Auberdine
	["Hearth to {area:442}"] = "Камень возвращения: {area:442}",
	["Fill the tube at the moonwell in the village"] = "Наполните пробирку у лунного колодца в деревне",

	-- Step 12: A Lesson to Learn
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Fly from {area:442} to {area:702} and take the portal up to {npc:4217} in the {area:1658}."] = "Летите: {area:442} → {area:702}, и поднимитесь через портал; там {npc:4217} ({area:1658}).",

	-- Step 13: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {area:442} Auberdine
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. Then fly back to {area:442} from {area:2361}."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}. Безделушки из святилища лежат в контейнерах на дне озера ({area:656}) ниже деревни ({area:2361}): отнесите одну на северо-запад ({area:2362}), используйте ее там и поговорите: {npc:11799}. Затем летите обратно ({area:2361} → {area:442}).",
	-- {quest:6122} The Principal Source · {area:445} Cliffspring Falls
	["{quest:6122}: fill the sampler at {area:445}"] = "{quest:6122}: наполните пробоотборник здесь: {area:445}",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}: из объекта {object:177785} в озере",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Здесь: {area:2362}",
	-- {zone:1439} Darkshore · {zone:1436} Westfall
	["The half pendants lie in {zone:1439} and {zone:1436}: later on the route"] = "Половинки подвески находятся здесь: {zone:1439} и {zone:1436} – дальше по маршруту",

	-- Step 14: Blackwood furbolgs
	["Blackwood furbolgs"] = "Фурболги Чернолесья",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Землепроходцы и заклинатели ветра из племени Чернолесья занимают лагерь к юго-востоку (ориентир: {area:442}).",

	-- Step 15: The Ancient Flame
	-- {object:16393} Ancient Flame
	["The {object:16393}"] = "{object:16393}",
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "Пламя горит в южной части руин ({area:447}).",

	-- Step 16: The southern beaches
	["The southern beaches"] = "Южные пляжи",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}."] = "Идите вдоль побережья на юг мимо руин ({area:447}): одно существо ({quest:4728}) лежит на берегу к западу от Рощи, другое – южнее, рядом с местом {area:450}.",

	-- Step 17: The Grove of the Ancients
	-- {area:448} Grove of the Ancients
	["The {area:448}"] = "{area:448}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "Седые скальпы",

	-- Step 18: The red crystal
	["Back north-east into the mountains to the crystal."] = "Назад на северо-восток, в горы, к кристаллу.",

	-- Step 19: Cliffspring Falls
	-- {area:456} Cliffspring River · {area:443} Ruins of Mathystra · {quest:954} Bashal'Aran
	["Follow the hills north to the {area:456} and up to the falls. Three more beached remains lie on the north shore: near the {area:443}, north of {quest:954} and west of {quest:954}."] = "Идите вдоль холмов на север к реке ({area:456}) и вверх к водопаду. Еще три выброшенных на берег останка лежат на северном побережье: у руин ({area:443}), к северу от руин ({quest:954}) и к западу от руин ({quest:954}).",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349} – у водопада",
	-- {item:15845} Filled Cliffspring Falls Sampler
	["{item:15845}: at the mouth of the cave by the falls"] = "{item:15845}: у входа в пещеру у водопада",

	-- Step 21: Auberdine
	["The WANTED poster"] = "Плакат «РАЗЫСКИВАЕТСЯ»",

	-- Step 22: The bay wrecks
	["The bay wrecks"] = "Затонувшие корабли в заливе",
	-- {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore."] = "На дне залива к северу (ориентир: {area:442}) лежат два затонувших корабля; в каждом – сундучок. На этом берегу полно рифовых крабов и покрытых илом крабов.",

	-- Step 23: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins; Stormscale Beastmistresses walk the shore. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} прячется на островке у руин; по берегу ходят повелительницы зверей из клана Гремучей Чешуи. Части ключа падают с гигантских лесных долгоногов (верх), мурлоков из племени Серой Мглы (середина) и гневных рифовых крабов (низ).",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}: {object:177792} под водой у северного побережья, к западу от руин",

	-- Step 24: The Tower of Althalaxx
	-- {npc:3661} Balthule Shadowstrike · {zone:1440} Ashenvale
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "{npc:3661} прячется у подножия башни среди фанатиков из клана Темной Нити. Сохраните его письмо для Делгрена Очистителя ({zone:1440}).",
	-- {item:5348} Worn Parchment
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{item:5348}: Dark Strand Fanatics"] = "{item:5348}: фанатики из клана Темной Нити",

	-- Step 25: The cave and the Den Mother
	-- {npc:6788} Den Mother
	["The cave and the {npc:6788}"] = "Пещера и {npc:6788}",
	-- {item:5270} Death Cap · {npc:6788} Den Mother · {object:177624} Xabraxxis' Demon Bag
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "Пещера – к югу от водопада: ножки струпника растут по всей пещере, {item:5270} – в самой глубине. {npc:6788} живет в холмах к югу от водопада; {object:177624} лежит в лагере сатиров к северу от нее.",
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["Scaber Stalks"] = "Ножки струпника",
	-- {item:12355} Talisman of Corruption · {object:177624} Xabraxxis' Demon Bag
	["{item:12355}, in {object:177624}"] = "{item:12355}: {object:177624}",

	-- Step 27: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851} и {item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "Лунный Плеснецвет растет в пещерах лунных совухов на холмах чуть восточнее (ориентир: {area:442}); совухи там раздражительны. Для предмета {item:2449} нужен навык {skill:182}: травники собирают его по всей зоне {zone:1439}, остальные привозят его из города {zone:1453} ({npc:1313}) или с аукциона.",

	-- Step 28: The Grove of the Ancients
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["Follow the road south. {quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "Идите по дороге на юг. {quest:948} – древо в Роще; рядом с ним спят {npc:270269} и {npc:11218}.",
	-- {npc:11218} Kerlonian Evershade · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:11218}: his escort to {area:413} is done on the {zone:1440} leg"] = "{npc:11218}: сопровождение ({area:413}) выполняется на отрезке маршрута «{zone:1440}»",

	-- Step 29: The Master's Glaive
	-- {object:10076} Scrying Bowl · {object:12666} Twilight Tome · {npc:3584} Therylune
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "Взрослые лунопарды рыщут в лесу вокруг глефы. {object:10076} и {object:12666} – на дне кратера; {npc:3584} стоит на его северной стороне.",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "Прекрасные шкуры лунопарда",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}: послушники и лиходеи из культа Сумеречного Молота",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "Только если с послушника или лиходея упал предмет {item:5352}: щелкните по нему правой кнопкой",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "Выведите ее из глефы; задание сдается Тересиль ({zone:1440})",

	-- Step 30: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "Пляж: {npc:10323}",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches south of {area:450}."] = "{npc:10323} стоит лагерем на пляже к западу от глефы: убейте мурлоков у костра; он придет с третьей волной вместе со своей гончей. Три выброшенных на берег останка лежат на пляжах к югу (ориентир: {area:450}).",

	-- Step 31: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil."] = "{area:450} – на побережье к югу от пляжа (там {npc:10323}). Защищайте старателя, пока он ищет окаменелость.",

	-- Step 33: Auberdine
	["Follow the road north."] = "Идите по дороге на север.",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "Она дает вам предмет {item:15826}",

	-- Step 34: The naga
	["The naga"] = "Наги",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them."] = "Идите вдоль побережья на северо-восток ({area:443}). {quest:951} лежат среди руин; их охраняют мирмидоны, колдуньи и воины из клана Гремучей Чешуи.",

	-- Step 35: Back south
	["Back south"] = "Назад на юг",
	["Hearthstone on cooldown? Follow the coast road back south."] = "Камень возвращения еще не готов? Идите по прибрежной дороге назад на юг.",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616} – в Роще",

	-- Step 36: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out."] = "{npc:3692} прячется в холмах к востоку (ориентир: {area:449}). Помогите ему вернуться к дороге; по пути он сражается.",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}: примените на них {item:15826}; они бродят по всей зоне {zone:1439}",

	-- Step 37: Auberdine
	-- {npc:3694} Sentinel Selarin · {npc:3691} Raene Wolfrunner · {area:415} Astranaar · {zone:1440} Ashenvale
	["{npc:3694}: for {npc:3691} in {area:415}, on the later {zone:1440} leg"] = "{npc:3694}: для персонажа {npc:3691} ({area:415}), позже на отрезке «{zone:1440}»",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}"] = "{npc:3649}: для персонажа {npc:1646} ({zone:1453})",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "Корабль: {zone:1453}",

	-- Step 38: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "Ночные эльфы летят ({area:442} → {area:702}); небеснорожденные плывут на корабле от пристани ({area:442}) и там узнают маршрут полета Деревни Рут'теран. Поднимитесь через портал; там {npc:4217} ({area:1658}).",

	-- Step 39: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}; узнайте там маршрут полета, если его у вас нет.",
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802}: the welcome from Sheldras"] = "{npc:11802}: приветствие от Шельдраса Лунное Древо",

	-- Step 40: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Реликвии Келий Малфуриона",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (ночные эльфы) и {npc:272054} (небеснорожденные) ждут на юге ({area:493}). Три реликвии лежат к востоку от них ({area:2363}). По отчетам первых недель, реликвия не дает добычи, пока ее обыскивает другой игрок: подождите немного и попробуйте снова.",

	-- Step 41: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Назад к {npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village · {area:442} Auberdine
	["Back to {npc:11802} in {area:2361}, then fly to {area:702} (by way of {area:442})."] = "Назад: {npc:11802} ({area:2361}), затем летите: {area:702} (через {area:442}).",

	-- Step 42: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1453} Stormwind
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the boat to {zone:1453}."] = "Поднимитесь через портал к {npc:4217}, затем летите обратно ({area:442}) к кораблю ({zone:1453}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower; Grizzled Thistle Bears roam around it."] = "Лунопарды рыщут по холмам между руинами ({quest:954}) и башней. {quest:1002} стоит на холме к западу от башни; вокруг бродят седые колючешерстные медведи.",
	-- ["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {quest:4723} lies on the shore just south of the village."] = "Прибрежные крабы снуют по берегу под деревней; {quest:983} стоит на пляже чуть южнее пристани. На мелководье плавают крепкозубы Темного берега. {quest:4723} лежит на берегу чуть южнее деревни.",
	-- ["{item:15883}: the {object:177790} under the water off the north coast, west of the ruins"] = "{item:15883}: {object:177790} под водой у северного побережья, к западу от руин",
	-- ["{quest:1003} stands west of the Grove."] = "{quest:1003} стоит к западу от Рощи.",
}
