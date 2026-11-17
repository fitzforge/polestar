-- Russian (ruRU): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:527} Battle of Hillsbrad · {area:272} Tarren Mill
	["For characters of 29 to 31: the {quest:527}, {area:272}'s errands and the gnolls of the foothills, all at or under your level."] = "Для персонажей 29-31-го уровня: {quest:527}, поручения места {area:272} и гноллы предгорий – все вашего уровня или ниже.",

	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 7: Korran
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows · {zone:1454} Orgrimmar
	["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29; below it, the next guide's {zone:1454} stop takes it."] = "{npc:3428} стоит рядом с распорядителем полетов на Перекрестке. {quest:1145} доступно с 29-го уровня; если уровень ниже, его можно взять на остановке в зоне {zone:1454} в следующем гайде.",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	["Crossroads flight master"] = "Распорядитель полетов на Перекрестке",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Крепость Громмаш, если у вас есть это задание",

	-- Step 10: Train
	["Train"] = "Обучение",
	["Train your new spells."] = "Изучите новые заклинания.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Дирижабль: {zone:1458}",

	-- Step 13: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "",

	-- Step 14: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 15: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "",

	-- Step 16: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Летите сюда: {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "",

	-- Step 18: Tarren Mill
	-- {quest:567} Dangerous! · {npc:2216} Apothecary Lydon · {npc:2393} Christoph Jeffcoat
	["The {quest:567} poster hangs by the inn; {npc:2216} stands inside it. {npc:2393}, the cook by the inn, wants turtle meat and sells the spices for it."] = "Плакат «{quest:567}» висит у таверны; {npc:2216} стоит внутри. {npc:2393}, повар у таверны, хочет черепашье мясо и продает специи для него.",
	-- {quest:567} Dangerous!
	["{quest:567}, the poster by the inn"] = "{quest:567}, плакат у таверны",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",
	-- {npc:2393} Christoph Jeffcoat · {quest:7321} Soothing Turtle Bisque
	["{npc:2393}: {quest:7321}, the Snapjaws of the river south of town"] = "{npc:2393}: {quest:7321}, черепахи-хваталки в реке к югу от городка",
	-- {item:3713} Soothing Spices · {npc:2393} Christoph Jeffcoat
	["{item:3713}, from {npc:2393}"] = "{item:3713}, у NPC {npc:2393}",

	-- Step 19: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "Вы пропустили первые поручения Дарталии из гайда по {area:287} (22-25): теперь они идут первыми. Они на несколько уровней ниже вас и быстрые, а еще открывают остальную часть цепочки {quest:527} в этом гайде.",

	-- Step 20: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275}."] = "{npc:2229} хочет, чтобы вы освободили двух его разведчиков ({area:275}).",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",

	-- Step 21: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "На запад за холмы, к фермам к востоку от поселения {area:287}. {npc:232} работает в поле у северного фермерского дома, {npc:2403} – на поле дальше к юго-востоку; батраки и фермеры повсюду.\nОсторожно: стражи Кирин-Тора (55) патрулируют поля и дороги ({area:287}) и нападают на Орду: следите за ними и не попадайтесь им на пути.",

	-- Step 22: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "Возвращайтесь на восток сюда: {area:272}.",

	-- Step 23: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "Хилсбрадские крестьяне",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "Назад в поля: крестьяне работают к югу от фермерских домов. Осторожно: сбежавший крестьянин, добравшийся до ратуши, может привести подмогу; замедление или обездвиживание не дает им убежать.",

	-- Step 26: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "К юго-востоку от Мельницы Таррен. Друлл и {npc:2238} прикованы в постройках во дворе крепости: {npc:2427} носит {item:3467}, а {npc:2428} – {item:3499}, оба в крепости. Убейте их, затем откройте оба замка.",
	["Drull's ball and chain"] = "Ядро и цепь Друлла",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Ядро и цепь: {npc:2238}",

	-- Step 27: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "Назад сюда: {area:272}.",

	-- Step 28: The river south of Tarren Mill: kill these as you meet them
	-- {area:272} Tarren Mill
	["The river south of {area:272}: kill these as you meet them"] = "Река к югу от места {area:272}: убивайте их по пути",
	-- {area:272} Tarren Mill · {area:271} Southshore · {item:3712} Turtle Meat
	["South from {area:272} along the river: Snapjaws (29) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "На юг от места {area:272} вдоль реки: черепахи-хваталки (29) греются на берегах до самых холмов над местом {area:271}. У некоторых есть {item:3712}.",
	-- {item:3712} Turtle Meat
	["{item:3712}, from the Snapjaws"] = "{item:3712}, с черепах-хваталок",

	-- Step 29: Mudsnout Blossoms
	-- {area:290} Dun Garok
	["South of the river's bend, the Mudsnout gnolls (26-28) camp in the hills above {area:290}; the blossoms grow among their tents. The Shamans heal and call their friends: pull them first."] = "К югу от излучины реки гноллы Грязнорылов (26-28) стоят лагерем на холмах над местом {area:290}; цветы растут среди их палаток. Шаманы лечат и зовут подмогу: выманивайте их первыми.",

	-- Step 30: North of Southshore
	["North of Southshore"] = "К северу от Южнобережья",
	-- {area:287} Hillsbrad · {area:271} Southshore
	["From the blossoms, back north along the river and then west to {area:287} town, well north of {area:271} (its guards are 55)."] = "От цветов назад на север вдоль реки, затем на запад к поселению {area:287}, держась далеко к северу от места {area:271} (там стража 55-го уровня).",

	-- Step 31: The smithy
	["The smithy"] = "Кузница",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes · {npc:2451} Farmer Kalaba
	-- was: ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "На запад через предгорья к поселению {area:287}: кузница стоит в его центре. {npc:2404} и его подмастерья работают у горна; {object:1736} сложена рядом. {npc:2449} ходит у кузницы; {npc:2451} работает в поле к юго-востоку от поселения."
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the west side of the town; {npc:2451} works the field south-east of the town."] = "",
	["Inside"] = "Внутри",
	-- {npc:2449} Citizen Wilkes
	["{npc:2449}, on the west side of the town"] = "",

	-- Step 32: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["for {npc:2055}, on the {zone:1458} stop at the end of this guide"] = "для NPC {npc:2055}, при визите в город {zone:1458} в конце этого гайда",
	-- {npc:2429} Novice Thaivand · {item:3708} Helcular's Rod
	["{npc:2429}, in the town: {item:3708}, from the yetis on the way to the town hall"] = "{npc:2429}, в городке: {item:3708} – с йети по пути к ратуше",

	-- Step 33: Helcular's Rod
	-- {area:277} Foothill Caverns
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["West of Tarren Mill, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but they hit hard and come in pairs."] = "К западу от Мельницы Таррен пещерные и лютые йети (30-32) заполняют {area:277} в холмах; примерно у одного из шестнадцати есть жезл. Оставайтесь в этих пещерах: горные и гигантские йети (32-34) из пещеры дальше к северу тоже носят его, но они бьют сильно и ходят парами.",

	-- Step 34: Town hall
	["Town hall"] = "Ратуша",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Дальше – в городок {area:287}, к юго-западу от пещер йети. Ратуша – в западной части городка: {npc:2335} (30) и {npc:2448} внутри, там же городской реестр; рядом висит прокламация. По городку ходят члены совета.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}, внутри",

	-- Step 35: Tarren Mill
	-- {area:271} Southshore
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["Thaivand's next errand, the flames, sends you among the Mountain and Giant Yetis (32-34) and to Helcular's grave inside {area:271}: leave it."] = "Следующее поручение Тайлванда, с пламенем, отправляет вас к горным и гигантским йети (32-34) и к могиле Гелькулара прямо в поселении {area:271}: пропустите его.",

	-- Step 36: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "Для похода в Город Даларан, позже в этом гайде: {npc:2278} стоит здесь: {area:272}, чуть восточнее NPC {npc:2410}.",

	-- Step 37: City of Dalaran
	["City of Dalaran"] = "Город Даларан",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "Город Даларан – подземелье для группы из пяти игроков, примерно 28-33-й уровень, под фиолетовым куполом. Без предмета {item:277507} входите через канализационную трубу к северо-западу от кратера: туда ведет стрелка.\nВнутри: {npc:247126} нужен NPC {npc:2278}. {npc:268743} в канализации дает задание «Opportunistic Education» и принимает его там же.",
	-- {quest:96986} The Grave Knight · {npc:247126} Atrexis the Grave Knight
	["{quest:96986}: {npc:247126}, inside"] = "{quest:96986}: {npc:247126}, внутри",

	-- Step 39: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south-west past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "На юго-запад мимо поселения {area:287} – к месту {area:288}. В туннелях работают шахтеры; {npc:2305} (30) и {npc:2450} (29) – в глубине.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "Внутри: {area:288}",

	-- Step 40: Level 30
	["Level 30"] = "",
	-- {npc:2410} Magus Wordeen Voidglare · {area:272} Tarren Mill · {zone:1454} Orgrimmar · {area:288} Azurelode Mine · {zone:1437} Wetlands
	-- plural, as words: Torn Fin Muckdwellers = {npc:2374} Torn Fin Muckdweller
	["{npc:2410}'s quests on the next {area:272} stop and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Short of 30? The Torn Fin Muckdwellers and Coastrunners (28-30) crowd the coast south of the {area:288}, a short walk: kill them until level 30. Their Oracles (30-31) cast from the shore further east. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "Задания NPC {npc:2410} при следующем визите сюда ({area:272}) и «Alliance Relations» в городе {zone:1454}, первая остановка следующего гайда, доступны с 30-го уровня. Не хватает до 30? Грязекопы и береговики из племени Рваного Плавника (28-30) толпятся на побережье к югу от места {area:288}, недалеко: убивайте их до 30-го уровня. Их оракулы (30-31) колдуют на берегу дальше к востоку. Или с группой пройдите подземелье Раскопки ({zone:1437}).",
	["Torn Fin murlocs"] = "Мурлоки из племени Рваного Плавника",
	-- {npc:2375} Torn Fin Coastrunner
	["grind on {npc:2375}"] = "бейте: {npc:2375}",

	-- Step 41: Finish the Turtle Meat
	-- {item:3712} Turtle Meat
	["Finish the {item:3712}"] = "Доберите: {item:3712}",
	-- {item:3712} Turtle Meat · {area:272} Tarren Mill
	["Still short of ten {item:3712}? The Snapjaws line the river east of {area:272}, on your way back from the mine."] = "Еще нет десяти штук ({item:3712})? Щелкочелюсты есть вдоль реки к востоку от места {area:272}, по пути назад от шахты.",

	-- Step 42: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["North-east back to {area:272}, passing well north of {area:271} (its guards are 55)."] = "На северо-восток назад сюда: {area:272}, держась далеко к северу от места {area:271} (там стража 55-го уровня).",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215}: ее следующее задание {quest:539} и меч NPC {npc:2419} – элитные групповые задания у места {area:290}: берите их только с группой",
	-- {npc:2229} Krusk
	["{npc:2229}, inside: Infiltration, worked on the 38-39 visit (its Syndicate are 32-35)"] = "{npc:2229}, внутри: «Infiltration», выполняется при визите на 38-39 (Синдикат там 32-35)",
	-- {area:272} Tarren Mill
	["Keep Infiltration in your log: its Syndicate (32-35) are over you now, and the 38-39 guide (Alterac and Arathi) works it on its first {area:272} loop."] = "Оставьте «Infiltration» в журнале: Синдикат (32-35) пока вам не по силам, а гайд 38-39 (Альтерак и Арати) выполняет его при первом визите сюда ({area:272}).",

	-- Step 43: Voidglare, Bel'varil and Tallow
	-- {npc:2770} Tallow
	["Voidglare, Bel'varil and {npc:2770}"] = "Сиянье Бездны, Бел'варил и {npc:2770}",
	-- {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow · {area:272} Tarren Mill
	["{npc:2410} and {npc:2437} are inside the inn, {npc:2770} just outside it. Their quests are offered from level 30; below it, the 38-39 guide's first {area:272} stop takes them."] = "{npc:2410} и {npc:2437} – в таверне, {npc:2770} – прямо у входа. Их задания доступны с 30-го уровня; если вы ниже, их возьмет гайд 38-39 при первом визите сюда ({area:272}).",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:544} Prison Break In · {area:279} Dalaran
	["{npc:2410}, inside: {quest:544}, for the 38-39 visit (the {area:279} crater's traitors are 33-35)"] = "{npc:2410}, внутри: {quest:544}, для визита на 38-39 (предатели в кратере {area:279} – 33-35)",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {quest:544} Prison Break In
	["{npc:2410}: {quest:93680}, with {quest:544} on the 38-39 visit"] = "{npc:2410}: {quest:93680}, вместе с заданием {quest:544} при визите на 38-39",
	-- {npc:2437} Keeper Bel'varil · {quest:556} Stone Tokens
	["{npc:2437}, inside: {quest:556}, with the crater on the 38-39 visit"] = "{npc:2437}, внутри: {quest:556}, вместе с кратером при визите на 38-39",
	-- {npc:2770} Tallow
	["{npc:2770}, outside the inn: the Boulderfist ogres (32-34) on the 38-39 Arathi visit"] = "{npc:2770}, у таверны: огры Тяжелого Кулака (32-34) при визите в Арати на 38-39",
	-- {area:272} Tarren Mill · {area:321} Hammerfall
	["Keep these in your log: their camps are two to four levels over you now, and the 38-39 guide works them on its first {area:272} loop and in {area:321}."] = "Оставьте их в журнале: их лагеря сейчас на 2-4 уровня выше вас, а гайд 38-39 проходит их в первом круге через {area:272} и в месте {area:321}.",

	-- Step 44: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "{quest:96986} из Города Даларан: {npc:2278}, чуть восточнее NPC {npc:2410}.",

	-- Step 45: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "",

	-- Step 46: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "",

	-- Step 47: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "",

	-- Step 48: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "",

	-- Step 50: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 51: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell · {object:36126} Royal Quarter
	["{npc:2055} stands in the Apothecarium, in the {object:36126}."] = "{npc:2055} стоит в Районе Фармацевтов, в месте {object:36126}.",
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["Faranell's next {quest:513} needs a {item:3388} ({skill:171}) and the {area:287} coast: leave it."] = "Следующему заданию Фаранелла {quest:513} нужен предмет {item:3388} ({skill:171}) и побережье ({area:287}): оставьте его.",

	-- Step 52: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "",

	-- Step 53: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038} стоит в Районе Фармацевтов. Его задание {quest:97985} – на Stormheart, элитного противника 30-го уровня, который ходит по каньону к востоку от места {area:484}, по пути в следующем гайде: {area:439}.",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038}: вернитесь к нему при следующем визите в город {zone:1458}, примерно на 38-м уровне",

	-- Step 54: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Учителя: {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Обучитесь, пока вы здесь ({zone:1458}): учителя – здесь: {object:36070}, {object:36073} и {object:36082} (паладины: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:272}"] = "Назад: {area:272}",
	-- ["Below ground"] = "Под землей",
	-- ["Boulderfist camp"] = "Лагерь клана Тяжелого Кулака",
	-- ["Daggerspine naga"] = "Наги из клана Пронзающего Гребня",
	-- ["Daggerspine shore"] = "Берег наг Пронзающего Гребня",
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Идите по дороге на север от места {area:272} в предгорья Альтерака. {quest:535} ждет у лагеря Синдиката; отдайте ему пиво.",
	-- ["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "Для персонажей 29-33 уровня, но большинство заданий здесь 32-34 уровня, а некоторые – до 36-го: намеренно, ради опыта. Синдикат, стражники ({area:279}) и огры из клана Тяжелого Кулака – 31-35 уровня, так что выманивайте их по одному.",
	-- ["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "От места {area:271} идите на север мимо поселения {area:272} и дальше по дороге в предгорья Альтерака. {quest:535} ждет у лагеря Синдиката. Он предлагает поручение, только пока у вас есть «Шпионская работа» от NPC {npc:2229}: сразу отдайте ему эль, и в награду он даст «Послание Синдиката», которое нужно Круску. Послание с членов Синдиката здесь подойдет так же: если оно есть в сумках, гайд пропускает шаг с {quest:535}.",
	-- ["Head back south down the road to {area:272}."] = "Возвращайтесь на юг по дороге сюда: {area:272}.",
	-- ["North of Southshore's graveyard"] = "К северу от кладбища Южнобережья",
	-- ["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "Только если послание от {quest:535} к вам не попало: преступники и воры Синдиката (32-34) у лагерей к западу от дороги тоже носят послания; примерно с каждого третьего падает одно. Осторожно: на 31-32 уровне они все еще выше вас и стоят кучно, а среди них – волшебники (34-35): выманивайте по одному с края лагеря.",
	-- ["Shindigger keg"] = "Бочонок «Землекопского крепкого»",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "К юго-западу пещерные и лютые йети (30-32) заполняют {area:277} в холмах к западу от поселения {area:272}; примерно у одного из шестнадцати есть жезл. Оставайтесь в этих пещерах: горные и гигантские йети (32-34) из пещеры дальше к северу тоже носят его, но на 29-30 уровне они бьют сильно и ходят парами.",
	-- ["Syndicate missives"] = "Донесения Синдиката",
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Преступники и воры Синдиката (32-33) у лагерей к западу от дороги носят донесения; примерно с каждого третьего падает одно.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "Бочонок стоит с несколькими другими в лагере Синдиката на юго-восточном побережье ({area:287}).",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "Крепость орков в восточном конце дороги. {npc:2851}, распорядитель полетов, стоит у ворот.",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "Третье пламя горит в пещере поменьше, выше в холмах к северу от пещер.\nОсторожно: вокруг пламени стоят гигантские и горные йети (32-34), часто парами, а рядом бродит Ледочрев, редкий йети (37). На 30-31 уровне они выше вас: выманивайте йети по одному от входа в пещеру, прежде чем применять жезл, и высматривайте Ледочрева, прежде чем входить.",
	-- ["The {area:279} crater's eastern rim"] = "Восточный край кратера {area:279}",
	-- ["Torn Fin beach"] = "Пляж мурлоков Рваного Плавника",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "На запад через предгорья к поселению {area:287}: кузница стоит в его центре. {npc:2404} и его подмастерья работают у горна; {object:1736} сложена рядом.",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "На запад через предгорья к поселению {area:287}: кузница стоит в его центре. {npc:2404} и его подмастерья работают у горна; {object:1736} сложена рядом. {npc:2449} ходит у кузницы; {npc:2451} работает в поле к юго-востоку от поселения.",
	-- ["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "Если в сумках есть {item:3388}, {npc:2055} предлагает задание {quest:513} в Районе Фармацевтов; {npc:2216} принимает эликсир здесь: {area:272}.",
	-- ["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388}: аукцион или алхимик, для задания {quest:513}.",
	-- ["{item:3703}, for {npc:2333}"] = "{item:3703}, для персонажа {npc:2333}",
	-- ["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229} хочет, чтобы вы освободили двух его разведчиков ({area:275}), прежде чем доверит вам «Шпионскую работу».",
	-- ["{npc:2792}, by the gate"] = "{npc:2792}, у ворот",
}
