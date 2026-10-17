-- Russian (ruRU): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} и Чумные земли",

	-- Step 1: Astranaar
	-- {area:392} Ratchet · {area:415} Astranaar
	["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Вы начинаете здесь: {area:392} – сюда вас вернул камень возвращения в прошлом гайде. Летите сюда: {area:415}.",
	-- {npc:6791} Innkeeper Wiley
	["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: предыдущий гайд возвращает вас сюда камнем возвращения, так что это обычно отмечается сразу",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:415} Astranaar · {zone:1448} Felwood
	["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Езжайте на север ({area:415} → {zone:1448}) к лагерю друидов на дороге сразу за границей.",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Подождите немного {npc:9116}",
	-- {npc:10924} Ivy Leafrunner · {zone:1452} Winterspring
	["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: завершается здесь: {zone:1452} – сохраните задание",

	-- Step 3: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Жаровни: {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} – пещера в глубине храма ({area:1763}), к западу от дороги. Используйте {item:12906} на четырех жаровнях внутри. По пути убивайте медведей злобных когтей и волков-сквернолапов ради предмета {item:11172}.",
	["Angerclaw bears and Felpaw wolves"] = "Медведи злобных когтей и волки-сквернолапы",

	-- Step 5: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "Снова сюда: {area:1770}. В самом дальнем зале {npc:9861} и {npc:9860} охраняют: {npc:9517}.",

	-- Step 6: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Идите по дороге на север: {area:1767}. Сердце носят топотуны Железнолесья; когти доберите с гризли злобных когтей и опустошителей-сквернолапов на севере.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Топотуны Железнолесья",

	-- Step 7: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} ждет здесь: {area:1767}. Выведите ее из леса, не дав погибнуть.",

	-- Step 8: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Езжайте на север к деревне фурболгов из племени Мертвого Леса у входа в пещеру ({area:1769}).",
	-- {object:176091} Deadwood Cauldron · {zone:1452} Winterspring
	["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, если вы нашли флягу из-под огненной воды ({zone:1452})",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} ({zone:1452}), сохраните задание",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558} – сразу у входа в пещеру: только с уровня «Равнодушие» у Древобрюхов",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, если у вас есть тридцать шт. {quest:6031}",

	-- Step 9: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Езжайте по дороге назад на юг к Святилищу.",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Сохраните {item:11169}, когти и сердце, которые он вернет",

	-- Step 10: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Камень возвращения: {area:392}, затем летите сюда: {area:976}. Купите здесь на аукционе два ториевых слитка для задания «{quest:5801}».",

	-- Step 11: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Езжайте на восток в холмы. Используйте {item:11169}, чтобы призвать: {quest:4005}, затем победите его ради тотема.",

	-- Step 12: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Езжайте на юго-запад к лагерю ({npc:7771}): {area:1938}.",

	-- Step 13: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Спуститесь по дороге на запад в кратер и езжайте к месту {area:540} – пещере силитидов на юге. {npc:10041} ждет в самом дальнем зале.",

	-- Step 14: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Поднимитесь в центре кратера: {area:537} – и используйте {item:14644} у лавового озера наверху, имея в сумках два ториевых слитка. Наполните чистые флаконы для образцов от {npc:9616} на первобытных слизнюках в водоемах вокруг гряды.",
	["Use the jars on slain oozes"] = "Используйте флаконы на убитых слизнюках",

	-- Step 15: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Езжайте на север: {area:541}. Используйте {npc:10980} рядом с персонажем {npc:10977}.",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737} – в глубине лагеря",

	-- Step 16: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "В зону {zone:1451}",
	-- {zone:1451} Silithus
	["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Езжайте на запад вдоль северной стены кратера к перевалу в северо-западном углу, который ведет в зону {zone:1451}.",
	["Toward the north-west pass"] = "К северо-западному перевалу",

	-- Step 17: Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Follow the road south-west out of the pass to {area:3425}."] = "От перевала идите по дороге на юго-запад: {area:3425}.",
	-- {npc:15174} Calandrath
	["{npc:15174}, the innkeeper"] = "{npc:15174}, хозяйка таверны",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082} – у палаток Альянса",

	-- Step 18: The Twilight Base Camp
	-- {area:2739} Twilight Base Camp
	["The {area:2739}"] = "{area:2739}",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "Раскопки культа Сумеречного Молота занимают северо-западный угол: фрагменты табличек лежат на земле, их также носят пылевихри и пустынные грохотуны. С любого культиста может упасть {item:20404}: сохраните двадцать – десять для персонажа {npc:15306} и десять позже для персонажа {npc:15194}.",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Фрагменты Сумеречной таблички",
	["Twilight's Hammer cultists"] = "Культисты Сумеречного Молота",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Еще десять для задания «{quest:8323}»",

	-- Step 19: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} стоит лагерем у западного улья ({area:2743}). Возьмите силитист у одного из красных гейзеров поблизости и отнесите его в экстрактор Альянса в его лагере.",

	-- Step 20: Grind to 58
	["Grind to 58"] = "Качайтесь до 58-го уровня",
	-- {area:2743} Hive'Zora · {area:3425} Cenarion Hold · {npc:15181} Commander Mar'alith · {quest:8304} Dearest Natalia
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Земляные сокрушители бродят по дюнам между местами {area:2743} и {area:3425}, на обратном пути. {npc:15181} предлагает задание «{quest:8304}» только с 58-го уровня.",
	-- {npc:11741} Dredge Crusher · {area:2743} Hive'Zora · {zone:1451} Silithus
	["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "убивайте мобов ({npc:11741}) в дюнах к востоку от места {area:2743}, {zone:1451}",

	-- Step 22: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Езжайте на восток к руинам ({area:2738}). {object:179565} лежит среди разрушенных зданий под охраной истерзанных часовых.",

	-- Step 23: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "Отшельник прячется среди скал к юго-востоку (ориентир: {area:2738}).",

	-- Step 24: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Лагерь Бронзоборода",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Езжайте на юго-запад к лагерю дворфов у южных гор и расспросите: {npc:15171} и {npc:15170}. Сумка {npc:15190} лежит в песке чуть юго-восточнее лагеря.",

	-- Step 25: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} удерживает лагерь культистов на дальнем юго-западе.",

	-- Step 26: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Езжайте на север вдоль западной стороны к маленькому лагерю Майны.",

	-- Step 27: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "Лагерь Хавунта – чуть западнее (ориентир: {area:3425}).",

	-- Step 29: Hermit Ortell
	["Ride back south-east to the hermit."] = "Езжайте назад на юго-восток к отшельнику.",
	["Hand him the ten texts you kept"] = "Отдайте ему десять сохраненных текстов",

	-- Step 31: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "Летите сюда: {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} ({zone:1457}): сохраните задание",

	-- Step 32: Forest Song
	-- {area:3137} Talrendis Point · {zone:1447} Azshara · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Летите сюда: {area:3137} ({zone:1447}) – и езжайте по дороге на запад: {area:2358}, сразу за границей зоны {zone:1440}.",

	-- Step 33: Everlook
	-- {area:3137} Talrendis Point · {area:2255} Everlook
	["Ride back to {area:3137} and fly to {area:2255}."] = "Езжайте назад: {area:3137}, затем летите сюда: {area:2255}.",

	-- Step 34: Ranshalla
	-- {area:2250} Owl Wing Thicket · {npc:10300} Ranshalla · {object:177404} Altar of Elune
	["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Езжайте на юг: {area:2250}. Защищайте персонажа {npc:10300}, пока она зажигает факелы по пути сюда: {object:177404}.",

	-- Step 35: Dire Maul (optional)
	-- {area:2577} Dire Maul
	["{area:2577} (optional)"] = "{area:2577} (по желанию)",
	-- {area:2577} Dire Maul · {zone:1444} Feralas
	["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "В группе быстрее пройти подземелье {area:2577} ({zone:1444}), чем убивать мобов. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- {area:2577} Dire Maul · {npc:7446} Rabid Shardtooth
	["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} подходит для 55–60 уровней; убийство мобов ({npc:7446}) ниже доведет вас до 59-го в одиночку.",

	-- Step 36: Grind to 59
	["Grind to 59"] = "Качайтесь до 59-го уровня",
	-- {npc:7446} Rabid Shardtooth · {area:2250} Owl Wing Thicket
	["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Медведи ({npc:7446}) бродят по снежной долине к югу от места {area:2250}.",
	-- {npc:7446} Rabid Shardtooth · {area:2250} Owl Wing Thicket · {zone:1452} Winterspring
	["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "убивайте мобов ({npc:7446}) в долине к югу от места {area:2250}, {zone:1452}",

	-- Step 37: Starfall Village
	-- {area:2255} Everlook
	["Ride back north to {area:2255} and west along the road to the night elf village."] = "Езжайте назад на север: {area:2255}, затем по дороге на запад к деревне ночных эльфов.",

	-- Step 38: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Двигайтесь по дороге дальше на запад к лагерю {npc:9298} у горячих источников.",

	-- Step 39: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Войдите в туннель ({area:1769}) со стороны зоны {zone:1452}, к западу от {npc:9298}, и идите по ответвлению ({area:493}) до места {area:2361}. {npc:11939} занимается исследованиями на берегу озера.",

	-- Step 40: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "Дом ({npc:11801}) стоит здесь: {area:2361}, к востоку (ориентир: {npc:11939}).",

	-- Step 42: Nighthaven
	-- {area:2361} Nighthaven · {area:442} Auberdine
	["Take the flight path in {area:2361} and fly to {area:442}."] = "Воспользуйтесь маршрутом полета ({area:2361}) и летите сюда: {area:442}.",

	-- Step 43: Rut'theran Village
	-- {area:442} Auberdine · {area:702} Rut'theran Village
	["Take the boat from {area:442} to {area:702}."] = "Плывите на корабле: {area:442} → {area:702}.",

	-- Step 44: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Поднимитесь через портал: {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740} – в Храме Луны",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155} – в банке",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516} – наверху ({area:1658})",

	-- Step 45: Stormwind
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {item:14047} Runecloth · {npc:14722} Clavicus Knavingham
	["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Спуститесь обратно: {area:702}, плывите на корабле сюда: {area:442} – и дальше сюда: {area:17203}. Принесите {npc:14722} по шестьдесят шт. шелкового материала, магической ткани и предмета {item:14047}: недостающее купите на аукционе.",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722} – здесь: {object:2096}",

	-- Step 46: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Поезжайте на метро ({area:2257}) сюда: {zone:1455}. {npc:14724} и {npc:14723} хотят по шестьдесят шт. шерсти, шелкового материала и магической ткани, затем по шестьдесят шт. предмета {item:14047}: всего по 120 каждого – из ваших сумок или с аукциона.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "В городе {zone:1453} нет учителя шаманов",

	-- Step 47: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} – элитный противник 61-го уровня",

	-- Step 48: Andorhal
	["Andorhal"] = "Андорал",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} ждет в разрушенной таверне в западной части Андорала – разрушенного города к северу от лагеря. {npc:1852} охраняет свою филактерию в центре города.",
	["Araj is elite: grouping up is advised."] = "Араж – элитный противник: лучше собрать группу.",

	-- Step 49: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "Призрак {npc:10778} бродит у дома ({area:199}) к западу от Андорала. Вторую половину амулета носят болтливые вурдалаки на поле: соедините обе половины.",

	-- Step 50: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Езжайте по дороге на север к лесопилке и поставьте бочку с термитами в ее центре.",

	-- Step 51: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (по желанию)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} живет в маленькой хижине у пограничной реки, к северо-востоку от лесопилки. Сдайте задание «{quest:5781}», если выполнили его.",

	-- Step 52: Scholomance (optional)
	-- {area:2057} Scholomance
	["{area:2057} (optional)"] = "{area:2057} (по желанию)",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {area:2279} Stratholme
	["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "В группе быстрее пройти подземелье {area:2057} ({area:2298}, юго-восток зоны {zone:1422}) или {area:2279}, чем убивать мобов. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- {area:2057} Scholomance · {quest:5505} The Key to Scholomance · {area:3197} Chillwind Camp
	["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} подходит для 58–60 уровней; задание «{quest:5505}» сдается ниже ({area:3197}).",

	-- Step 53: Grind to 60
	["Grind to 60"] = "Качайтесь до 60-го уровня",
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Перейдите реку к востоку от {npc:1855}: {area:2627}. В тамошних лесах бродят духи долины Ужаса.",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "убивайте мобов ({npc:14564}): {area:2627}, {zone:1423}",

	-- Step 54: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Езжайте назад на юго-запад: {area:3197}.",

	-- Step 55: Level 60
	["Level 60"] = "60-й уровень",
	-- {area:1519} Stormwind
	["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Камень возвращения: {area:1519}. Изучите заклинания 60-го уровня. На этом маршрут прокачки заканчивается: дальше смотрите гайды по репутации и подземельям.",

	-- Step 56: Shaman training
	["Shaman training"] = "Обучение шамана",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "В городе {zone:1453} нет учителя шаманов: поезжайте на метро ({area:2257}) из места {object:28027} сюда: {zone:1455} – и изучите заклинания 60-го уровня у персонажа {npc:258098}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Спуститесь по дороге на запад в кратер и езжайте сюда: {area:540} – пещера силитидов на юге. {npc:10041} ждет в самом дальнем зале.",
}
