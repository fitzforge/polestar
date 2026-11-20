-- Russian (ruRU): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "В зону {zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} стоит прямо у выхода туннеля ({area:1769}) в край {zone:1452}, там, где вы выходите.",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "Езжайте на юг от туннеля: {npc:9298} стоит лагерем среди горячих источников ({area:2246}) на западе долины.",
	["Linken's letter"] = "Письмо Линкена",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} выдает {npc:7775} ({zone:1444}), позже в этом руководстве.",

	-- Step 4: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: убивайте их по пути",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	-- was: ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Землепроходцы, дозорные и тотемисты живут в лагерях фурболгов вокруг горячих источников; лохматые совухи бродят по склонам между ними. Сначала убивайте тотемистов. Сохраняйте всю добытую ткань ({item:14047}) для Мейлоша.\nОсторожно: дозорные бывают 56 уровня: выманивайте по одному и держитесь подальше от тотемов в лагерях."
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems.\nIf you are 54, take the level 55 Den Watchers and leave the 56s."] = "",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, редкая добыча с фурболгов Зимней Спячки",

	-- Step 5: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} сдается здесь: {object:176091} ({zone:1448}) – в следующий раз.",

	-- Step 6: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Бешеные совухи",
	-- {area:2251} Lake Kel'Theril · {area:2246} Frostfire Hot Springs · {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	-- was: ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Бешеные совухи бродят по холмам к северу от места {area:2251}, у дороги между {area:2246} и {area:2255}. Осторожно: самые крупные – 56 уровня: выманивайте по одному."
	["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time.\nAt 54, take owlbeasts no higher than 55."] = "",

	-- Step 8: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255} – гоблинский город в восточной части долины, за холмами совухов.",
	["Gregor's quests lead to other zones: keep them."] = "Задания Грегора ведут в другие зоны: сохраните их.",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}, внутри",

	-- Step 9: Ice Thistle yetis
	["Ice Thistle yetis"] = "Йети ледополохов",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	-- was: ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "Холмы йети начинаются чуть к юго-востоку от места {area:2255}. Мех падает с любого йети: бейте йети с Холмов ледополоха (55-56) и не трогайте матриархов и патриархов (56-58) – их рога понадобятся позже."
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit.\nAt 54, take level 55 Ice Thistle Yetis; leave the 56s and the larger Matriarchs and Patriarchs."] = "",

	-- Step 10: Chillwind chimaeras
	["Chillwind chimaeras"] = "Хладноветрые химеры",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	-- plural, as words: Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite.\nAt 54, take the Fledgling Chillwinds (53-55). They carry the same horns; leave the larger chimaeras alone."] = "",

	-- Step 11: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "Уми: не сдавайте, нетронутые рога йети – в гайде по зоне {zone:1423}, при остановке в месте {area:2255} примерно на 57 уровне",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "Матриархи и патриархи с рогами для Уми – 56-58 уровня: оставьте их на ту остановку.",

	-- Step 12: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Летите сюда: {area:1099}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Распорядитель полетов: {area:2255}",

	-- Step 14: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "{item:11242} растет внутри разрушенного здания к северу от лагеря {npc:7775}, к востоку от места {area:1114} гарпий: заберитесь внутрь через разрушенную часть стены.",

	-- Step 15: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "Обратно на юг к {npc:7775}. Сохраните эликсир и пока не пейте его: он убивает, и именно так вы позже встретите Гаэрияна у места {area:976}.",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}, награда от {npc:7775}",

	-- Step 17: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Распорядитель полетов: {area:2408}",

	-- Step 18: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 19: Elder Rise
	-- {area:1237} Valormok
	["Take the payment to Jediga on the next {area:1237} stop"] = "",
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} ({area:1639}); {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} ждет здесь: {zone:1450} – сохраните на потом.",

	-- Step 20: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "",

	-- Step 22: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Летите сюда: {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Распорядитель полетов: {zone:1456}",

	-- Step 23: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 24: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Ориентир: {object:172958}.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Бусы может нести любой фурболг Зимней Спячки; ближайшие лагеря – чуть к югу от персонажа {npc:11556}.",
	-- ["Back at {area:1099}."] = "Снова здесь: {area:1099}.",
	-- ["Back to {area:2255}"] = "Назад: {area:2255}",
	-- ["Below ground"] = "Под землей",
	-- ["Chillwind chimaeras"] = "Хладноветрые химеры",
	-- ["From Krakle in Un'Goro"] = "От Кракла из Ун'Горо",
	-- ["Frostfire Winterfall camp"] = "Лагерь Зимней Спячки у источников",
	-- ["Frostfire Winterfall camps"] = "Лагеря Зимней Спячки у источников",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "Задания Грегора и Харло ведут в другие зоны: сохраните их.",
	-- ["Grind to 55"] = "Набейте 55-й уровень",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Он стоит здесь: {area:1641}. Каждое пожертвование требует ткани из сумок; сдайте, когда она будет, позже по маршруту.",
	-- ["In the {object:172961}."] = "Ориентир: {object:172961}.",
	-- ["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Матриархи и патриархи бьют сильно: выманивайте по одному.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Землепроходцы, дозорные и тотемисты живут в лагерях фурболгов вокруг горячих источников; лохматые совухи бродят по склонам между ними. Сначала убивайте тотемистов. Сохраняйте всю добытую ткань ({item:14047}) для Мейлоша.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "Землепроходцы, дозорные и тотемисты живут в лагерях фурболгов вокруг горячих источников; лохматые совухи бродят по склонам между ними. Сначала убивайте тотемистов. Сохраняйте всю добытую ткань ({item:14047}) для Мейлоша.\nОсторожно: дозорные бывают 56 уровня: выманивайте по одному и держитесь подальше от тотемов в лагерях.",
	-- ["Pristine Yeti Horns"] = "Безупречные рога йети ({item:12367})",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "Бешеные совухи бродят по холмам к северу от места {area:2251}, у дороги между {area:2246} и {area:2255}. Осторожно: самые крупные – 56 уровня: выманивайте по одному.",
	-- ["Ride back west to {area:2246}."] = "Возвращайтесь на запад сюда: {area:2246}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Езжайте на восток, затем на юг через место {area:2249}. Великаны ледяного молота там – элита 59-го уровня: держитесь середины и не останавливайтесь. Странный источник – у входа сюда: {area:2256}, в южном конце.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Езжайте на запад по дороге мимо места {area:2251}; бешеные совухи бродят по холмам к северу.",
	-- ["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Химеры бродят по снежным полям к югу и западу от места {area:2255}. Держитесь подальше от пещеры ({area:2245}): синие дракониды там – элита.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "Деревня фурболгов занимает долину к северо-востоку от места {area:2255}. Сначала убивайте шаманов: они лечат. {npc:10738} в пещере в глубине – элита: не заходите.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "Холмы йети начинаются чуть к юго-востоку от места {area:2255}. Мех падает с любого йети: бейте йети с Холмов ледополоха (55-56) и не трогайте матриархов и патриархов (56-58) – их рога понадобятся позже.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Холмы йети начинаются чуть к юго-востоку от места {area:2255}. Мех падает с любого йети; рога – только с матриархов и патриархов, оставьте их на после сдачи.",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Наберите здесь уровень 55.04, прежде чем сдавать задания здесь: {area:2255}; они поднимут вас до 56-го уровня. Йети ледополохов (55-56) здесь самые низкоуровневые; матриархи и патриархи (56-58) бьют сильнее. Или, с группой, пройдите вместо этого подземелье {area:1584} или подземелье {area:1583} (нижняя часть).",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "Третья шутка Юми – над гоблинами ({area:976}) и в Ун'Горо: сохраните на потом.",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "бейте монстров {npc:7440}: {area:2244}, {zone:1452}",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, редкая добыча с фурболгов Зимней Спячки",
	-- ["{npc:10307}, beside him"] = "{npc:10307}, рядом с ним",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} стоит у выхода туннеля ({area:1769}) в край {zone:1452}, к северу от горячих источников.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "Дворф {npc:7775} стоит лагерем здесь: {area:1137}, к северо-западу от места {area:1099}. Он варит {item:11243} только из предмета {item:11242}, который вы ему принесете.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "Дворф {npc:7775} стоит лагерем здесь: {area:1137}, к северо-западу от места {area:1099}; эликсир у него.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} покупает предмет {item:11040}, выращенный из вашей земли ({quest:3761}).",
}
