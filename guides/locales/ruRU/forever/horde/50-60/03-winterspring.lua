-- Russian (ruRU): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255} – гоблинский город в восточной части долины.",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "Задания Грегора и Харло ведут в другие зоны: сохраните их.",

	-- Step 2: Ice Thistle yetis
	["Ice Thistle yetis"] = "Йети ледополохов",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "Холмы йети начинаются чуть к юго-востоку от места {area:2255}. Мех падает с любого йети; рога – только с матриархов и патриархов, оставьте их на после сдачи.",

	-- Step 4: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Безупречные рога йети ({item:12367})",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "Матриархи и патриархи бьют сильно: выманивайте по одному.",

	-- Step 5: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "Третья шутка Юми – над гоблинами ({area:976}) и в Ун'Горо: сохраните на потом.",

	-- Step 6: Chillwind chimaeras
	["Chillwind chimaeras"] = "Хладноветрые химеры",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "Химеры бродят по снежным полям к югу и западу от места {area:2255}. Держитесь подальше от пещеры ({area:2245}): синие дракониды там – элита.",

	-- Step 8: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "Бешеные совухи",
	-- {area:2251} Lake Kel'Theril
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "Езжайте на запад по дороге мимо места {area:2251}; бешеные совухи бродят по холмам к северу.",

	-- Step 9: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298} стоит лагерем среди горячих источников ({area:2246}) на западе долины.",
	["From Krakle in Un'Goro"] = "От Кракла из Ун'Горо",
	["Linken's letter"] = "Письмо Линкена",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909} выдает {npc:7775} ({zone:1444}), позже в этом руководстве.",

	-- Step 10: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556} стоит у выхода туннеля ({area:1769}) в край {zone:1452}, к северу от горячих источников.",

	-- Step 11: Frostfire Winterfall camps
	["Frostfire Winterfall camps"] = "Лагеря Зимней Спячки у источников",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "Землепроходцы, дозорные и тотемисты живут в лагерях фурболгов вокруг горячих источников; лохматые совухи бродят по склонам между ними. Сначала убивайте тотемистов. Сохраняйте всю добытую ткань ({item:14047}) для Мейлоша.",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}, редкая добыча с фурболгов Зимней Спячки",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}, редкая добыча с фурболгов Зимней Спячки",

	-- Step 12: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084} сдается здесь: {object:176091} ({zone:1448}) – в следующий раз.",

	-- Step 13: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Езжайте на восток, затем на юг через место {area:2249}. Великаны ледяного молота там – элита 59-го уровня: держитесь середины и не останавливайтесь. Странный источник – у входа сюда: {area:2256}, в южном конце.",

	-- Step 14: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "Деревня фурболгов занимает долину к северо-востоку от места {area:2255}. Сначала убивайте шаманов: они лечат. {npc:10738} в пещере в глубине – элита: не заходите.",

	-- Step 15: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "Возвращайтесь на запад сюда: {area:2246}.",

	-- Step 17: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Бусы может нести любой фурболг Зимней Спячки; ближайшие лагеря – чуть к югу от персонажа {npc:11556}.",
	["Frostfire Winterfall camp"] = "Лагерь Зимней Спячки у источников",

	-- Step 19: Back to Everlook
	-- {area:2255} Everlook
	["Back to {area:2255}"] = "Назад: {area:2255}",

	-- Step 20: Grind to 55
	["Grind to 55"] = "Набейте 55-й уровень",
	-- {npc:7440} Winterfall Den Watcher · {area:2244} Winterfall Village · {zone:1452} Winterspring
	["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "бейте монстров {npc:7440}: {area:2244}, {zone:1452}",

	-- Step 21: A Little Luck
	-- {npc:10307} Witch Doctor Mau'ari
	["{npc:10307}, beside him"] = "{npc:10307}, рядом с ним",

	-- Step 22: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Летите сюда: {area:1099}",

	-- Step 23: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "Дворф {npc:7775} стоит лагерем здесь: {area:1137}, к северо-западу от места {area:1099}; эликсир у него.",

	-- Step 24: Talo Thornhoof
	-- {area:1099} Camp Mojache
	["Back at {area:1099}."] = "Снова здесь: {area:1099}.",

	-- Step 25: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Летите сюда: {area:1638}",

	-- Step 26: Rumstag Proudstrider
	-- {area:1641} Hunter Rise
	["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "Он стоит здесь: {area:1641}. Каждое пожертвование требует ткани из сумок; сдайте, когда она будет, позже по маршруту.",

	-- Step 28: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{npc:3033} ({area:1639}); {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123} ждет здесь: {zone:1450} – сохраните на потом.",

	-- Step 29: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil
	["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087} покупает предмет {item:11040}, выращенный из вашей земли ({quest:3761}).",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Летите сюда: {area:1637}",

	-- Step 31: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "Ориентир: {object:172961}.",

	-- Step 32: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "Ориентир: {object:172958}.",
}
