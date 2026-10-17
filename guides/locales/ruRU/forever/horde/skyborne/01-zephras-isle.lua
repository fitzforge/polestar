-- Russian (ruRU): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "Вы просыпаетесь здесь: {area:16635}, на севере острова. {npc:251362} стоит у тропы, {npc:251361} – в центре деревни.",

	-- Step 2: Thendal Grove
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "Назойливые щетинистые осы и {npc:250873} бродят по роще чуть к юго-востоку от деревни.",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "Назад: {area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: записка от вашего учителя",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}: осмотрите предмет {item:282418}",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "поговорите с персонажем {npc:257554}",

	-- Step 4: The watchtower
	["The watchtower"] = "Сторожевая башня",
	-- {spell:1259416} Walk on Air
	["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "Поднимитесь на сторожевую башню в деревне, прыгните с вершины и используйте {spell:1259416}, чтобы плавно спуститься.",

	-- Step 5: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "Поручения {npc:251361}",

	-- Step 6: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "Ветрокаменное сырье",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "Ветрокаменное сырье – синие кристаллы на склонах вокруг деревни.",

	-- Step 8: The standing stones
	["The standing stones"] = "Монолиты",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363} стоит здесь: {area:17678}, к востоку от деревни. {npc:251143} и ал'акетские новообращенные собираются чуть к северу от нее. {object:460001} – чуть к северо-востоку: используйте рядом расовую способность {spell:1259686}.",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "Используйте {spell:1259686} рядом: {object:460001}",

	-- Step 9: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "Королева парит в юго-восточной части рощи, по пути обратно от монолитов.",

	-- Step 10: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "Сдача заданий: {area:16635}",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: прочтите предмет {item:9547}",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "{npc:251389}, в сторожевой башне",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "{npc:251964}, в сторожевой башне",
	-- {npc:251374} Windshaper Boro
	["{npc:251374}, at the village centre"] = "{npc:251374}, в центре деревни",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "{npc:251373}, учитель друидов, на нижнем ярусе дерева за {npc:251361}",

	-- Step 11: Windshaper Boro
	-- {npc:251374} Windshaper Boro
	["{npc:251374} stands in the village."] = "{npc:251374} стоит в деревне.",

	-- Step 12: Scrawny Ursera
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "Медверы ({npc:250926}) бродят по склонам к юго-западу от деревни, по пути к {npc:252095}.",

	-- Step 13: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095} ждет здесь: {area:16622}, к юго-западу от деревни. Сразу за ней – лагерь Ал'акет; его возглавляет {npc:256935}.",

	-- Step 14: Signet of Akir
	-- {npc:252095} Hanaa Nightwind
	["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "Перстень – у культистов Ал'акет в лагере за {npc:252095}.",

	-- Step 15: Urs'anah
	-- {npc:251115} Urs'anah
	["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "Логово медвер – к западу от деревни. {npc:251115}, их матриарх, сидит в дальнем конце.",

	-- Step 16: Leaving Thendal Village
	-- {area:16635} Thendal Village
	["Leaving {area:16635}"] = "Покидаем место: {area:16635}",

	-- Step 17: Call of Earth
	-- {npc:251374} Windshaper Boro · {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374} отправляет вас сюда: {area:16988}, чуть к востоку от деревни: выпейте там {item:6635}, чтобы увидеть персонажа {npc:251166}, затем отнесите ему предмет {item:6656}.",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}: {npc:5873} и ваш {item:5175}",

	-- Step 18: Shen'dar Village
	-- {area:16624} Shen'dar Village
	["Follow the road south to {area:16624}, in the middle of the isle."] = "Идите по дороге на юг сюда: {area:16624}, в центр острова.",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "поговорите с персонажем {npc:251902}",

	-- Step 19: Raan Wildwind's campfire
	-- {npc:263664} Raan Wildwind
	["{npc:263664}'s campfire"] = "Костер {npc:263664}",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest · {npc:251905} Zerril Softbreeze
	["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "Сядьте у костра {npc:263664} (введите /sit), пока не получите эффект {spell:1229451}, затем найдите персонажа {npc:251905} у очага.",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "/sit у костра {npc:263664}, пока не получите {spell:1229451}",
	-- {npc:251905} Zerril Softbreeze
	["talk to {npc:251905}"] = "поговорите с персонажем {npc:251905}",

	-- Step 20: Welcome to Shen'dar Village
	-- {npc:251902} Illaya Amberwind
	["Talk to {npc:251902}"] = "Поговорите с персонажем {npc:251902}",
	-- {npc:254089} Coriella Calmbreeze
	["Talk to {npc:254089}"] = "Поговорите с персонажем {npc:254089}",
	["the bounty board"] = "доска объявлений",

	-- Step 21: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "Когти прайда и буреноги",
	-- {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "Когти прайда и буреноги бродят по лугам к югу от деревни. Сохраните {item:5469} для {npc:251905}; яйца будут позже, с гиппогрифов.",

	-- Step 22: High Order Apprentices
	-- plural, as words: High Order Apprentices = {npc:257521} High Order Apprentice
	["High Order Apprentices"] = "Ученики Высшего ордена",
	["The apprentices practise north-east of the village."] = "Ученики тренируются к северо-востоку от деревни.",

	-- Step 23: The highland bandits
	["The highland bandits"] = "Бандиты нагорья",
	["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "Лагеря бандитов – к северо-востоку от деревни; Бенник-Баламут занимает верхний лагерь. Украденные ветрокамни – у бандитов.",

	-- Step 24: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "Сдача заданий: {area:16624}",

	-- Step 25: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589} прячется к югу от деревни среди когтей прайда. {npc:254589} – элита: лучше собрать группу.",

	-- Step 26: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529} – к югу от Шен'дара. {npc:257065} встретит вас на окраине; обыщите шкаф в доме за ним.",
	["search the wardrobe"] = "обыщите шкаф",

	-- Step 27: Constable Aonda
	-- {area:16624} Shen'dar Village
	["Back to {area:16624} with what you found."] = "Возвращайтесь с находкой сюда: {area:16624}.",

	-- Step 28: Havoc in the Highlands
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "Снова здесь: {quest:92529} – деревня полна призывателей бури и персонажей {npc:251662}, тайники с припасами стоят среди домов, а {npc:251966} ждет в юго-восточной части.",

	-- Step 29: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "Идите на юго-запад сюда: {area:17674}. {npc:252155} – на вершине; {item:254871} лежит рядом.",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "поговорите с персонажем {npc:252155}",

	-- Step 30: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "Аандерс и павшие стражи – чуть к юго-западу от башни. Заберите с тел перо Раани и фамильный перстень Песни Теней.",

	-- Step 31: Hippogryph nests
	["Hippogryph nests"] = "Гнезда гиппогрифов",
	-- {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	-- plural, as words: Small Eggs = {item:6889} Small Egg
	["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "Гнезда гиппогрифов – к северо-западу от башни, к западу от места {quest:92529}; гиппогриф-матриарх сидит в западной части. {item:263493} лежит на земле вокруг, а с гиппогрифов падают небольшие яйца.",

	-- Step 32: Shen'dar Village, last time
	-- {area:16624} Shen'dar Village
	["{area:16624}, last time"] = "{area:16624}, в последний раз",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "Идите на север сюда: {area:16624}; если не хватает предмета {item:5469}, доберите его с буреногов по пути.",

	-- Step 33: To Valanaar
	-- {area:16638} Valanaar · {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "Идите по дороге на юго-восток сюда: {area:16638} – город небеснорожденных на южном побережье. {npc:257006} и {npc:252448} стоят на западной окраине.",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "Выслушайте историю: {npc:252448}",

	-- Step 34: Windsong Crawlers
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers"] = "Ветроозерные крабы",
	["The crawlers scuttle along the shore south-west of town."] = "Крабы снуют по берегу к юго-западу от города.",

	-- Step 36: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "Небопрыги",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "Небопрыги скачут по полям чуть к западу от Валеннии.",

	-- Step 37: Ayessa Dawnsinger
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "поговорите с персонажем {npc:251968}",

	-- Step 38: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083} стоит здесь: {area:16626}, чуть к северо-западу от города.",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "Выслушайте персонажа {npc:256083}",

	-- Step 39: Wind Hollows and Construct Parts
	-- {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows and {object:616467}"] = "Ветряные мертвени и {object:616467}",
	-- {area:16638} Valanaar · {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "Ветряные мертвени парят над низинами вокруг места {area:16638}. Первые детали ({object:616467}) лежат к западу от дороги к саду.",

	-- Step 41: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663} – к западу от места {area:16638} по прибрежной дороге.",
	-- {npc:252800} Aamelia Windfield
	["Talk to {npc:252800}"] = "Поговорите с персонажем {npc:252800}",

	-- Step 42: The orchard
	["The orchard"] = "Сад",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "Буреяблоки и пыльца бабочек-порхательниц лежат по всему саду; на него нападают голодные бандиты. Буреноги пасутся в полях к востоку. Сломанный конструкт парит у северного края сада.",

	-- Step 44: Bandit Highwaymen
	["Bandit Highwaymen"] = "Придорожные бандиты",
	-- {object:616468} Construct Parts · {area:16638} Valanaar
	["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "Придорожные бандиты занимают холмы к северо-востоку от сада. Еще детали ({object:616468}) лежат у дороги к месту {area:16638}.",

	-- Step 45: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "Скажите NPC {npc:252800}, что вы готовы",

	-- Step 46: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448} и {npc:256083}",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {item:15908} Taming Rod · {npc:254588} Windsong Crawler · {npc:251707} Ornery Galestrider · {npc:250874} Vuldren Alpha · {area:16663} Windfield Orchard · {npc:254411} Quel'dora Quickgale
	["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{npc:252389} ({area:16638}) трижды дает вам предмет {item:15908}: приручите монстра {npc:254588} у озер к северо-западу от города, монстра {npc:251707} в полях к западу от города и монстра {npc:250874} ({area:16663}), каждый раз возвращаясь к ней. {npc:254411} стоит рядом с ней.",

	-- Step 48: Belathaan Brightwish
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247} ждет на дороге к северу от места {area:16638}, в сторону места {area:16629}.",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359} стоит в восточной части места {area:16638}.",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "Езжайте на северо-восток сюда: {area:17675}. Лагерь Ал'акет – чуть к западу, {npc:252666} – в его северной части. С любого культиста может упасть ал'акетский ветрокаменный талисман.",

	-- Step 52: Urs'endris
	-- {npc:255853} Urs'endris
	["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853} ждет у водопада чуть к северу от сторожевой башни.",

	-- Step 53: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "Назад: {area:16638}",

	-- Step 54: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377} стоит в центре места {area:16638}.",

	-- Step 55: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382} стоит в западной части места {area:16638}.",

	-- Step 56: The turncoat
	["The turncoat"] = "Предатель",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "Дом предателя – здесь: {area:16626}, к северо-западу от места {area:16638}. {npc:273017} ждет неподалеку; его убийцы прячутся вокруг дома.",
	["search the dead cultist in the house"] = "обыщите мертвого культиста в доме",

	-- Step 57: Ur'endra
	-- {npc:258443} Ur'endra
	["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443} бродит по склонам чуть к югу от дома предателя.",

	-- Step 58: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "Отнесите факел дремлющего пламени персонажу {npc:268592} к святилищу пламени, к юго-западу от места {area:16638} ({area:16626}).",

	-- Step 59: Skypriest Faladiel
	-- {area:16638} Valanaar
	["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "Фаладиэль стоит на холме к западу от водопада, к северу от места {area:16638}.",

	-- Step 60: Kuramaa
	-- {npc:268592} Olariaan Swiftburn · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "Назад к {npc:268592}, затем на запад сюда: {area:16623}: дом {npc:268605} – на холмах к югу от озер ветроозерных крабов.",

	-- Step 61: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "Назад к {npc:268592}. Дождитесь, пока он зажжет {npc:268762}, затем сразу несите пламя сюда: {npc:268679} (рядом с {npc:252382}, {area:16638}), пока не истек таймер.",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}: {npc:2523}, ваш {item:5176} и {item:263412}",

	-- Step 62: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "поговорите с персонажем {npc:252476}",

	-- Step 63: Desperate Times
	-- {npc:252383} Valennia Stormfist
	["Talk to {npc:252383}"] = "Поговорите с персонажем {npc:252383}",
	-- {npc:251968} Ayessa Dawnsinger
	["Talk to {npc:251968}"] = "Поговорите с персонажем {npc:251968}",
	-- {npc:252383} Valennia Stormfist
	["talk to {npc:252383}"] = "поговорите с персонажем {npc:252383}",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris
	["On the way north, back to {npc:255853} by the falls."] = "По пути на север – снова к персонажу {npc:255853} у водопада.",

	-- Step 65: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629} – к северу от места {area:16638}. Пробейтесь через стражу к персонажу {npc:253576} в восточной части.",
	-- {npc:253576} Hyusaa Quickbreeze
	["Talk to {npc:253576}"] = "Поговорите с персонажем {npc:253576}",

	-- Step 66: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{item:263993} – у персонажа {npc:257196} в западной части святилища.",

	-- Step 67: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "Идите на север сюда: {area:16631}; {npc:257944} стоит лагерем на южной окраине.",

	-- Step 68: Shadowgale Forest
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105} растет вокруг лагеря {npc:257944}, над ним летают визгуны. {item:265141} – в лагере Ал'акет к востоку от нее.",

	-- Step 69: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "Снова {npc:257944}",

	-- Step 70: The Al'Aketh camp
	["The Al'Aketh camp"] = "Лагерь Ал'акет",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}, {npc:258130} и {npc:258134} – в лагере культа к востоку от {npc:257944}. {npc:254151} стоит на окраине. С Хаалиена также падает {quest:94490}: прочтите, чтобы начать следующее задание. Для задания {quest:94489} войдите в логово, вылечите 7 раненых друидов и найдите {npc:258130}.",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "Найдите персонажа {npc:258130}",
	["Heal the injured druids in the Nightfang Den"] = "Вылечите раненых друидов в логове",

	-- Step 71: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "{npc:257944}, в последний раз",

	-- Step 72: Windsong Lake
	-- {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "Вещи беженцев лежат вдоль северного берега ({area:16625}); {npc:259013} – в северо-западной части.",

	-- Step 73: The Strange Hermit
	-- {area:16625} Windsong Lake · {item:257128} Zephyrseed
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "Отшельник живет на западном берегу ({area:16625}). Шишки ({item:257128}) растут к югу от него; ветряные мертвени парят к востоку от озера.",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "поговорите с персонажем {npc:251684}",

	-- Step 74: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {npc:251968} Ayessa Dawnsinger
	["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "Поднимитесь через портал сюда: {area:16630} и вместе с {npc:252475} и {npc:251968} сразитесь с верховной жрицей.",

	-- Step 77: The airship
	["The airship"] = "Воздушный корабль",
	-- {area:16638} Valanaar · {zone:1412} Mulgore
	["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "Воздушный корабль Орды причаливает у юго-западного края места {area:16638}. Летите на нем в Калимдор; он садится на севере края {zone:1412}.",
	["Horde airship"] = "Воздушный корабль Орды",

	-- Step 78: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "Север: {zone:1412}",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "Вы покидаете остров навсегда. {npc:259119} ждет у места посадки.",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}: сохраните задание, Тралл ({zone:1454}) – через два руководства",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "{npc:259118}, у места посадки: для персонажа {npc:3033} ({zone:1456})",

	-- Step 79: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638} – рядом с местом посадки: поднимитесь на подъемнике и откройте маршрут у персонажа {npc:2995}, распорядителя полетов.",

	-- Step 80: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068} просит тауренские благовония: купите четыре части у {npc:3014} (травница), {npc:3012} (товары для зачарования), персонажа {npc:3005} (товары для кожевников) и {npc:3027} (товары для кулинарии), затем соедините их в предмет {item:278078}.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}, у персонажа {npc:3014}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}, у персонажа {npc:3012}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}, у персонажа {npc:3005}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}, у персонажа {npc:3027}",

	-- Step 81: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "Используйте предмет {item:278078} у церемониального коврика и курильницы на южном обрыве ({area:1641}).",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "Развейте предмет {item:278078} с обрыва ({area:1641})",

	-- Step 83: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033} обучает друидов, ориентир: {area:1639}. Он научит вас заклинанию {spell:18960}; приветствие ({npc:11802}) ждет вашего путешествия за обликом ({spell:499}) примерно на 23-м уровне (forever/horde/04-the-barrens).",

	-- Step 84: The Crossroads
	-- {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {zone:1413} Barrens · {area:458} Gold Road · {area:380} The Crossroads
	["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Спуститесь на подъемнике из города {zone:1456} и идите по дороге на юг мимо места {area:222} и через восточный перевал в край {zone:1413}; от перевала идите на север по дороге ({area:458}) к месту {area:380} – городку Орды в центре края {zone:1413}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, распорядитель полетов",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Kuramaa"] = "Курамаа",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "Спуститесь на подъемнике из города {zone:1456} и идите по дороге на юг мимо места {area:222} и через восточный перевал в край {zone:1413}; от перевала идите на север по дороге ({area:458}) сюда: {area:380} – городок Орды в центре края {zone:1413}.",
	-- ["Rorian: {quest:92485}"] = "Рориан: {quest:92485}",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "Придорожные бандиты занимают холмы к северо-востоку от сада. Еще детали ({object:616466}) лежат у дороги к месту {area:16638}.",
	-- ["Wind Hollows and {object:616466}"] = "Ветряные мертвени и {object:616466}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "Ветряные мертвени парят над низинами вокруг места {area:16638}. Первые детали ({object:616466}) лежат к западу от дороги к саду.",
}
