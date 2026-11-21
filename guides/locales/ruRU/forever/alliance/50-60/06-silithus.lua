-- Russian (ruRU): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451}: {area:3425}'s quests, to 60."] = "",

	-- Step 1: Innkeeper Vizzie
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {npc:11118} Innkeeper Vizzie
	["Back from {zone:2482} in {area:2255}: {npc:11118}'s mail went astray in the hills east of town, where the Ice Thistle yetis carry it off."] = "",

	-- Step 2: Missing Mail
	-- {area:2255} Everlook · {item:258323} Missing Mail
	["The Ice Thistle yetis (53-57) in the hills east of {area:2255} carry the {item:258323}: take it from the ones at the edge of the hills."] = "",

	-- Step 4: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Летите сюда: {area:541}",
	-- {area:541} Marshal's Refuge · {zone:1449} Un'Goro Crater · {zone:1451} Silithus
	["Fly to {area:541} in {zone:1449}, the way into {zone:1451}."] = "",
	["Maethrya, the Alliance flight master"] = "",

	-- Step 5: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "В зону {zone:1451}",
	-- {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Ride west from {area:541} to the crater's north-western pass into {zone:1451}."] = "",

	-- Step 6: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["{npc:13220} stands at {area:3077}, where the pass comes out."] = "",

	-- Step 8: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Езжайте дальше на запад: {area:3425}. {npc:15189} стоит наверху в своем здании: поднимитесь внутри, стрелка не различает этажи.",
	-- {npc:17082} Rifleman Torrig · {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17082}, at the Alliance tents: for {npc:17080} at {area:2743}"] = "{npc:17082} – у палаток Альянса: для персонажа {npc:17080} ({area:2743})",
	-- {npc:15183} Geologist Larksbane
	["{npc:15183}: the tablet fragments come from the Twilight dig"] = "{npc:15183}: фрагменты табличек добываются на раскопках Сумеречного Молота",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: his Twilight texts come from the dig"] = "",

	-- Step 9: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: убивайте их по пути",
	-- {npc:15185} Brood of Nozdormu
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around.\nCareful: {npc:15185} (62, elite) guard the Caverns of Time's mouth in the south-west, around 21,82: stay out of there."] = "",

	-- Step 10: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189}, upstairs"] = "{npc:15189} – наверху",

	-- Step 11: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["From the hold, west into the sands: Dredge Crushers dig there; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "От крепости на запад в пески: там копают земляные сокрушители; в тех же песках охотятся камнехвостые клешневики, живодеры и скальные пауки-скакуны.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",

	-- Step 12: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} стоит наверху в своем здании: поднимитесь внутри, стрелка не различает этажи.",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "{npc:15190} – наверху, рядом с {npc:15189}",
	-- {npc:15181} Commander Mar'alith
	["{npc:15181} (from level 58): Bronzebeard's Encampment comes later, on the way south"] = "",

	-- Step 13: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "{area:2742}: убивайте их по пути",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell · {area:2742} Hive'Ashi · {quest:8308} Brann Bronzebeard's Lost Letter
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Twilight Avengers = {npc:11880} Twilight Avenger · Twilight Flamereavers = {npc:15201} Twilight Flamereaver
	-- was: ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait."] = "Раскопки культа Сумеречного Молота занимают северо-западный угол: фрагменты табличек лежат на земле, их также носят пылевихри и пустынные грохотуны. С любого культиста может упасть {item:20404}: сохраните двадцать – десять для персонажа {npc:15306} и десять позже для персонажа {npc:15194}.\nОсторожно: добывайте тексты с мстителей и геолордов из культа Сумеречного Молота; не трогайте пламехватов из культа Сумеречного Молота (60) и не подходите к входу в улей, где ждут элитные мобы ({area:2742}, 59-60)."
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait.\nThe {area:2742} silithids sometimes drop {quest:8308}: keep it for Bronzebeard's Encampment in the south."] = "",
	["Twilight's Hammer cultists"] = "Культисты Сумеречного Молота",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Фрагменты Сумеречной таблички",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Еще десять для задания «{quest:8323}»",

	-- Step 14: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080} стоит лагерем у западного улья ({area:2743}). Возьмите силитист у одного из красных гейзеров поблизости и отнесите его в экстрактор Альянса в его лагере.\nОсторожно: вы теряете силитист, если садитесь на транспорт, входите в незаметность, используете {spell:642}, {spell:5384} или «Исчезновение». «Скачок» и {spell:17} его не сбрасывают.",
	["Bring a Silithyst to the Alliance extractor"] = "",

	-- Step 16: Southwind Village
	["The tortured druids and sentinels haunt the ruined village east of the hold."] = "",

	-- Step 17: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride north-east to {npc:13220} at {area:3077}."] = "",

	-- Step 18: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "Башня: {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride back south-west to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Езжайте обратно на юго-запад к башне ({area:2742}, {area:2738}); поднимитесь на нее и убейте засаду, которая появляется ради покрытого коркой предмета.",

	-- Step 19: Layo Starstrike
	-- {npc:13220} Layo Starstrike · {zone:1450} Moonglade
	["{npc:13220}'s next task goes to {zone:1450}: skip it."] = "",

	-- Step 20: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "Отшельник прячется среди скал к юго-востоку (ориентир: {area:2738}).",
	["Below ground"] = "Под землей",

	-- Step 21: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Лагерь Бронзоборода",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand south-east of the camp, where Deathclasp, an elite scorpid, patrols: grab it while he is away."] = "Езжайте на юго-запад к лагерю дворфов у южных гор и расспросите: {npc:15171} и {npc:15170}. Сумка {npc:15190} лежит в песке к юго-востоку от лагеря, где патрулирует Deathclasp, элитный скорпид: заберите ее, пока его нет рядом.",

	-- Step 22: Brann Bronzebeard's Lost Letter
	-- {area:2742} Hive'Ashi · {npc:15170} Rutgar Glyphshaper
	["From a {area:2742} silithid: for {npc:15170} at Bronzebeard's Encampment"] = "",

	-- Step 24: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	-- was: ["Careful: the Twilight Keepers are level 60, a level or two over you: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "Осторожно: Сумеречные хранители 60 уровня, на уровень-два выше вас: сначала перебейте культистов вокруг каждого и сражайтесь с хранителем при полном здоровье.\n{npc:11803} занимает лагерь культистов на дальнем юго-западе."
	["Careful: the Twilight Keepers are level 60: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "",

	-- Step 25: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp.\nCareful: Mayna is level 60: clear her camp first and fight her at full health."] = "Езжайте на север вдоль западного края к небольшому лагерю Майны.\nОсторожно: Майна 60 уровня: сначала зачистите ее лагерь и сражайтесь с ней при полном здоровье.",

	-- Step 26: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}.\nCareful: Havunth is level 60: clear his camp first and fight him at full health."] = "Лагерь Хавунта находится чуть западнее (ориентир: {area:3425}).\nОсторожно: Хавунт 60 уровня: сначала зачистите его лагерь и сражайтесь с ним при полном здоровье.",

	-- Step 27: Hermit Ortell
	["Ride back south-east to the hermit."] = "Езжайте назад на юго-восток к отшельнику.",
	["Hand him the ten texts you kept"] = "Отдайте ему десять сохраненных текстов",

	-- Step 28: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} стоит наверху в своем здании: поднимитесь внутри, стрелка не различает этажи.",

	-- Step 29: Level 60
	["Level 60"] = "60-й уровень",
	-- {area:3425} Cenarion Hold · {area:2057} Scholomance · {area:2279} Stratholme · {area:3197} Chillwind Camp · {area:2268} Light's Hope Chapel · {zone:1451} Silithus
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger · Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["{area:3425}'s last hand-ins can leave a player who followed only this route short of 60 (up to about a level for the slowest; most players less).\nWith a group: run the {area:2057} dungeon or the {area:2279} dungeon, in the Plaguelands by {area:3197} and {area:2268}.\nAlone: the Twilight's Hammer camps of {zone:1451}'s north-west (Twilight Avengers 57-59 and Geolords 58-60; leave the Flamereavers, 60) and the Stonelash Flayers and Rock Stalkers (57-59) around {area:3425} are at your level. {area:3425}'s repeatable quests open only at 60."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal"] = "Андорал",
	-- ["Angerclaw bears and Felpaw wolves"] = "Медведи злобных когтей и волки-сквернолапы",
	-- ["Araj is elite: grouping up is advised."] = "Араж – элитный противник: лучше собрать группу.",
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "Снова сюда: {area:1770}. В самом дальнем зале {npc:9861} и {npc:9860} охраняют: {npc:9517}.",
	-- ["Boat to {area:150}"] = "Корабль: {area:150}",
	-- ["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "Осторожно: древние железнолесные ходоки, элитные противники 59-го уровня, стоят среди целей задания «{quest:5086}»: бейте ужасов на северо-восточной оконечности лагеря (около 50.6,22.4) по одному и перед каждым нападением высматривайте ходока.",
	-- ["Careful: the Twilight Keepers are level 60, a level or two over you: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "Осторожно: Сумеречные хранители 60 уровня, на уровень-два выше вас: сначала перебейте культистов вокруг каждого и сражайтесь с хранителем при полном здоровье.\n{npc:11803} занимает лагерь культистов на дальнем юго-западе.",
	-- ["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Поднимитесь в центре кратера: {area:537} – и используйте {item:14644} у лавового озера наверху, имея в сумках два ториевых слитка. Наполните чистые флаконы для образцов от {npc:9616} на первобытных слизнюках в водоемах вокруг гряды.",
	-- ["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "Перейдите реку к востоку от хижины NPC {npc:1855}: {area:2627}. {npc:11140} стоит у разрушенной хижины Августа.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Земляные сокрушители бродят по дюнам между местами {area:2743} и {area:3425}, на обратном пути. {npc:15181} предлагает задание «{quest:8304}» только с 58-го уровня.",
	-- ["Fly from {area:541} to {area:392}."] = "Летите: {area:541} → {area:392}.",
	-- ["Fly to {area:150}"] = "Летите сюда: {area:150}",
	-- ["Fly to {area:1537}"] = "Лететь сюда: {area:1537}",
	-- ["Fly to {area:2255}"] = "Летите сюда: {area:2255}",
	-- ["Fly to {area:271}"] = "Летите сюда: {area:271}",
	-- ["Fly to {area:3137}"] = "Летите сюда: {area:3137}",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Летите сюда: {area:3137} ({area:16}) – и езжайте по дороге на запад: {area:2358}, сразу за границей зоны {zone:1440}.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Летите сюда: {area:3137} ({zone:1447}) – и езжайте по дороге на запад: {area:2358}, сразу за границей зоны {zone:1440}.",
	-- ["Fly to {area:3425}"] = "Летите сюда: {area:3425}",
	-- ["Fly to {area:442}"] = "Летите сюда: {area:442}",
	-- ["Fly to {area:702}"] = "Летите сюда: {area:702}",
	-- ["Fly to {area:976}"] = "Летите сюда: {area:976}",
	-- ["Fly to {area:976}."] = "Летите сюда: {area:976}.",
	-- ["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Летите сюда: {area:976}. Купите здесь на аукционе два ториевых слитка для задания «{quest:5801}».",
	-- ["Fly to {zone:1453}"] = "Лететь в {zone:1453}",
	-- ["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north.\nCareful: Ancient Irontree Walkers, level 59 elites, stand among the treants in the middle of {area:1767}: take the Stompers on the north side (about 48,21)."] = "Идите по дороге на север: {area:1767}. Сердце носят топотуны Железнолесья; когти доберите с гризли злобных когтей и опустошителей-сквернолапов на севере.\nОсторожно: древние железнолесные ходоки, элитные противники 59-го уровня, стоят среди древней в центре ({area:1767}): бейте топотунов на северной стороне (примерно 48,21).",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "От перевала идите по дороге на юго-запад: {area:3425}.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Следуйте указаниям {npc:9298} ко входу сюда: {area:2256}, мимо великанов ледяного молота: проходите мимо них по одному.",
	-- ["For {npc:10778}: keep it"] = "Для персонажа {npc:10778}: сохраните задание",
	-- ["For {npc:11053} at {area:3197}, at the end of this guide"] = "Для персонажа {npc:11053} ({area:3197}), в конце этого гайда",
	-- ["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "От места {area:3137} езжайте в {zone:1448}: {area:2479} – лагерь друидов на дороге сразу за границей зоны {zone:1440}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Спуститесь обратно: {area:702}, плывите на корабле сюда: {area:442} – и дальше сюда: {area:17203}. Принесите {npc:14722} по шестьдесят шт. шелкового материала, магической ткани и предмета {item:14047}: недостающее купите на аукционе.",
	-- ["Grind to 58"] = "Качайтесь до 58-го уровня",
	-- ["Grind to 59"] = "Качайтесь до 59-го уровня",
	-- ["Grind to 60"] = "Качайтесь до 60-го уровня",
	-- ["Havunth's camp sits just west of {area:3425}."] = "Лагерь Хавунта – чуть западнее (ориентир: {area:3425}).",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Камень возвращения: {area:1519}. Изучите заклинания 60-го уровня. На этом маршрут прокачки заканчивается: дальше смотрите гайды по репутации и подземельям.",
	-- ["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Камень возвращения: {area:392}, затем летите сюда: {area:976}. Купите здесь на аукционе два ториевых слитка для задания «{quest:5801}».",
	-- ["Inside"] = "Внутри",
	-- ["Irontree Stompers"] = "Топотуны Железнолесья",
	-- ["Its jars are filled on the Un'Goro visit"] = "Его флаконы наполняются при посещении Кратера Ун'Горо",
	-- ["Keep the {item:11169}, the claws and the heart he hands back"] = "Сохраните {item:11169}, когти и сердце, которые он вернет",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Двигайтесь по дороге дальше на запад к лагерю {npc:9298} у горячих источников.",
	-- ["Learn the flight path in {area:2361}."] = "Откройте маршрут полета: {area:2361}.",
	-- ["Lots of flying between zones"] = "Много перелетов между зонами",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Подберите припасы вокруг повозки и заберите амулет {npc:10301} у совухов поблизости.",
	-- ["Portal to {zone:1438}"] = "Портал: {zone:1438}",
	-- ["Radley and Durgen"] = "Рэдли и Дурген",
	-- ["Ride back south along the road to the Sanctuary."] = "Езжайте по дороге назад на юг к Святилищу.",
	-- ["Ride back south-west to {area:3197}."] = "Езжайте назад на юго-запад: {area:3197}.",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "Езжайте назад: {area:3137}, затем летите сюда: {area:2255}.",
	-- ["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Езжайте на восток в холмы. Используйте {item:11169}, чтобы призвать: {quest:4005}, затем победите его ради тотема.",
	-- ["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Езжайте на восток к руинам ({area:2738}). {object:179565} лежит среди разрушенных зданий под охраной истерзанных часовых.",
	-- ["Ride north along the west side to Mayna's small camp."] = "Езжайте на север вдоль западной стороны к маленькому лагерю Майны.",
	-- ["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Езжайте на север к деревне фурболгов из племени Мертвого Леса у входа в пещеру ({area:1769}).",
	-- ["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Езжайте на север к северо-восточному краю места {area:2277}.\nОсторожно: тролли на пути к месту {area:2273} – 57-59-го уровня. При малом здоровье они убегают и зовут на помощь, поэтому часто приводят подкрепление.",
	-- ["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Езжайте на север: {area:541}. Используйте {npc:10980} рядом с персонажем {npc:10977}.",
	-- ["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Езжайте по дороге на север к лесопилке и поставьте бочку с термитами в ее центре.",
	-- ["Ride north-west up the road to {area:2253}."] = "Езжайте на северо-запад вверх по дороге: {area:2253}.",
	-- ["Ride south out of {zone:1448} toward {area:3137}: {npc:3848}'s camp at {area:2358} is just over the {zone:1440} border, on the way."] = "Езжайте на юг из зоны {zone:1448} к месту {area:3137}: лагерь NPC {npc:3848} ({area:2358}) – сразу за границей зоны {zone:1440}, по пути.",
	-- ["Ride south-east from the lake to the chapel."] = "Езжайте на юго-восток от озера к часовне.",
	-- ["Ride south-east to {area:201}: {npc:11078} guards the cauldron, and {item:12955} lies east of the barn."] = "Езжайте на юго-восток: {area:201}. {npc:11078} охраняет котел, а {item:12955} лежит к востоку от амбара.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Езжайте на юго-запад: {area:2261}. Холмик земли – внутри. {npc:11886} – элитный противник: лучше собрать группу.\nОсторожно: вместе с Меркуцио появляются около четырех неэлитных помощников. Они идут к могиле, а не появляются на месте.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Езжайте на юго-запад к лагерю ({npc:7771}): {area:1938}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Езжайте на запад вдоль северной стены кратера к перевалу в северо-западном углу, который ведет в зону {zone:1451}.",
	-- ["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "В группе быстрее пройти подземелье {area:2057} ({area:2298}, юго-восток зоны {area:28}) или {area:2279}, чем убивать мобов. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "В группе быстрее пройти подземелье {area:2057} ({area:2298}, юго-восток зоны {zone:1422}) или {area:2279}, чем убивать мобов. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "В группе быстрее пройти подземелье {area:2577} ({zone:1444}), чем убивать мобов. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- ["Scourge Champions"] = "Воители Плети",
	-- ["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Воители Плети (59) бродят здесь: {area:2270}, к северу от места {area:2268}. Проводите предметом {item:13156} {npc:11063} над каждым убитым: нужны ему черепа, которые резонируют. Выманивайте по одному.",
	-- ["Shaman training"] = "Обучение шамана",
	-- ["Stays on the main route"] = "Остается на основном маршруте",
	-- ["Take the boat from {area:442} to {area:702}."] = "Плывите на корабле: {area:442} → {area:702}.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "Воспользуйтесь маршрутом полета ({area:2361}) и летите сюда: {area:442}.",
	-- ["Take the portal up to {zone:1457}."] = "Поднимитесь через портал: {zone:1457}.",
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Спуститесь по дороге на запад в кратер и езжайте к месту {area:540} – пещере силитидов на юге. {npc:10041} ждет в самом дальнем зале.",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Войдите в туннель ({area:1769}) со стороны зоны {area:618}, к западу от {npc:9298}, и идите по ответвлению ({area:493}) до места {area:2361}. {npc:11939} занимается исследованиями на берегу озера.",
	-- ["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Войдите в туннель ({area:1769}) со стороны зоны {zone:1452}, к западу от {npc:9298}, и идите по ответвлению ({area:493}) до места {area:2361}. {npc:11939} занимается исследованиями на берегу озера.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Поезжайте на метро ({area:2257}) сюда: {zone:1455}. {npc:14724} и {npc:14723} хотят по шестьдесят шт. шерсти, шелкового материала и магической ткани, затем по шестьдесят шт. предмета {item:14047}: всего по 120 каждого – из ваших сумок или с аукциона.",
	-- ["Takes you all the way to 60"] = "Ведет вас до самого 60-го уровня",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "Раскопки культа Сумеречного Молота занимают северо-западный угол: фрагменты табличек лежат на земле, их также носят пылевихри и пустынные грохотуны. С любого культиста может упасть {item:20404}: сохраните двадцать – десять для персонажа {npc:15306} и десять позже для персонажа {npc:15194}.",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait."] = "Раскопки культа Сумеречного Молота занимают северо-западный угол: фрагменты табличек лежат на земле, их также носят пылевихри и пустынные грохотуны. С любого культиста может упасть {item:20404}: сохраните двадцать – десять для персонажа {npc:15306} и десять позже для персонажа {npc:15194}.\nОсторожно: добывайте тексты с мстителей и геолордов из культа Сумеречного Молота; не трогайте пламехватов из культа Сумеречного Молота (60) и не подходите к входу в улей, где ждут элитные мобы ({area:2742}, 59-60).",
	-- ["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "Полет заканчивается здесь: {area:702}. {npc:7916} стоит недалеко к северо-западу от распорядителя полетов.",
	-- ["The main route to 60: {zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands, with the hand-ins in {zone:1453}, {zone:1455} and {spell:437801} on the way."] = "Основной маршрут до 60-го уровня: {zone:1451}, {zone:1448}, {zone:1452} и Чумные земли, со сдачей заданий по пути: {zone:1453}, {zone:1455} и {spell:437801}.",
	-- ["The {area:2479}"] = "{area:2479}",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Медведи ({npc:7446}) бродят по снежной долине к югу от места {area:2250}.",
	-- ["The {quest:5086}"] = "{quest:5086}",
	-- ["Theramore flight master"] = "Распорядитель полетов: Терамор",
	-- ["Toward the north-west pass"] = "К северо-западному перевалу",
	-- ["Tram to {zone:1455}"] = "Поезд до {zone:1455}",
	-- ["Underwater"] = "Под водой",
	-- ["Upstairs"] = "Наверху",
	-- ["Use the jars on slain oozes"] = "Используйте флаконы на убитых слизнюках",
	-- ["Wait a moment for {npc:9116}"] = "Подождите немного {npc:9116}",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Вы начинаете здесь: {area:392} – сюда вас вернул камень возвращения в прошлом гайде. Летите сюда: {area:415}.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "убивайте мобов ({npc:11741}) в дюнах к востоку от места {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "убивайте мобов ({npc:14564}): {area:2627}, {area:139}",
	-- ["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "убивайте мобов ({npc:14564}): {area:2627}, {zone:1423}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "убивайте мобов ({npc:7446}) в долине к югу от места {area:2250}, {zone:1452}",
	-- ["{area:150} flight master"] = "Распорядитель полетов: {area:150}",
	-- ["{area:1770} braziers"] = "Жаровни: {area:1770}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} – пещера в глубине храма ({area:1763}), к западу от дороги. Используйте {item:12906} на четырех жаровнях внутри. По пути убивайте медведей злобных когтей и волков-сквернолапов ради предмета {item:11172}.",
	-- ["{area:190} overlook"] = "Обзорная точка: {area:190}",
	-- ["{area:2057} (optional)"] = "{area:2057} (по желанию)",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} подходит для 58–60 уровней; задание «{quest:5505}» сдается ниже ({area:3197}).",
	-- ["{area:2255} flight master"] = "Распорядитель полетов: {area:2255}",
	-- ["{area:2577} (optional)"] = "{area:2577} (по желанию)",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} подходит для 55–60 уровней; убийство мобов ({npc:7446}) ниже доведет вас до 59-го в одиночку.",
	-- ["{area:3137} flight master"] = "Распорядитель полетов: {area:3137}",
	-- ["{area:392} flight master"] = "Распорядитель полетов: {area:392}",
	-- ["{area:493} flight path on the way"] = "По пути – маршрут полета ({area:493})",
	-- ["{area:541} flight master"] = "Распорядитель полетов ({area:541})",
	-- ["{area:702} flight master"] = "Распорядитель полетов: {area:702}",
	-- ["{area:976} flight master"] = "Распорядитель полетов: {area:976}",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}: с воителей Плети",
	-- ["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300} ждет здесь: {area:2250}, к югу от места {area:2255}.\nЗащищайте персонажа {npc:10300}, пока она зажигает факелы по пути сюда: {object:177404}.",
	-- ["{npc:10301}'s camp"] = "Лагерь {npc:10301}",
	-- ["{npc:10301}'s supplies"] = "Припасы {npc:10301}",
	-- ["{npc:10667} in Andorhal: keep it"] = "{npc:10667} в Андорале: сохраните задание",
	-- ["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} ждет в разрушенной таверне в западной части Андорала – разрушенного города к северу от лагеря. {npc:1852} охраняет свою филактерию в центре города.",
	-- ["{npc:10667} waits upstairs in the ruined inn on the west side of Andorhal, on the way back to {area:3197}."] = "{npc:10667} ждет на верхнем этаже разрушенной таверны в западной части Андорала, по пути обратно сюда: {area:3197}.",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}, наверху",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "Призрак {npc:10778} бродит у дома ({area:199}) к западу от Андорала. Вторую половину амулета носят болтливые вурдалаки на поле: соедините обе половины.",
	-- ["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn."] = "{npc:10897}, распорядитель полетов ({area:493}), стоит к югу от озера, за пределами зоны {area:2361}: откройте у него маршрут полета. Распорядитель полетов в самой зоне {area:2361} перевозит только друидов (через диалог), и маршрута полета у нее не открыть.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: завершается здесь: {zone:1452} – сохраните задание",
	-- ["{npc:11020}, below ground"] = "{npc:11020}, под землей",
	-- ["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, keep it"] = "{npc:11038}, у могил к югу от часовни: {npc:11140} – здесь: {area:2627}, сохраните",
	-- ["{npc:11053}: {area:201}'s cauldron, on this loop"] = "{npc:11053}: котел ({area:201}), на этом круге",
	-- ["{npc:11556}'s {quest:8464} waited for this visit: the furbolg village lies just east of {area:2255}, with Shaman (56-57), Den Watchers (55-56) and Ursa (57-58). Kill the Shaman first, they heal. {npc:10738} in the cave at the back is elite: stay out."] = "Задание {quest:8464} ({npc:11556}) ждало этого визита: деревня фурболгов лежит чуть восточнее (ориентир: {area:2255}), там шаманы (56-57), стражи логова (55-56) и урсы (57-58). Сначала убивайте шаманов, они лечат. {npc:10738} в пещере в глубине – элита: не заходите туда.",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, если у вас есть тридцать шт. {quest:6031}",
	-- ["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558} – сразу у входа в пещеру: ходит здесь, ищите внутри круга на карте",
	-- ["{npc:11610} hides at the Northridge lumber camp's edge."] = "{npc:11610} прячется на краю лесопилки Северного хребта.",
	-- ["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} прячется на краю лесопилки.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} ходит по лагерю Северного Кряжа к востоку от {npc:11610}; {npc:11611} охраняет башню на южных подступах (ориентир: {area:190}).\nОсторожно: у подножия башни стоят стражи, и еще один патрулирует вокруг нее. Перебейте их, прежде чем нападать на Дургена, чтобы они не вмешались в бой.",
	-- ["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "Дом ({npc:11801}) стоит здесь: {area:2361}, к востоку (ориентир: {npc:11939}).",
	-- ["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} удерживает лагерь культистов на дальнем юго-западе.",
	-- ["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} ходит по месту {area:2361}: ищите внутри круга на карте",
	-- ["{npc:14722}, in the {object:2096}"] = "{npc:14722} – здесь: {object:2096}",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, хозяйка таверны",
	-- ["{npc:15181}: Bronzebeard's Encampment comes later, on the way south"] = "{npc:15181}: Лагерь Бронзоборода – позже, по пути на юг",
	-- ["{npc:15306}: his Twilight texts come from the dig after the next stop here"] = "{npc:15306}: его Сумеречные тексты добываются на раскопках после следующей остановки",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082} – у палаток Альянса",
	-- ["{npc:1852} is a level 61 elite"] = "{npc:1852} – элитный противник 61-го уровня",
	-- ["{npc:1855} (optional)"] = "{npc:1855} (по желанию)",
	-- ["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} живет в маленькой хижине у пограничной реки, к северо-востоку от лесопилки. Сдайте задание «{quest:5781}», если выполнили его.",
	-- ["{npc:332}, in SI:7"] = "{npc:332} – в здании ШРУ",
	-- ["{npc:3516}, atop the {area:1658}"] = "{npc:3516} – наверху ({area:1658})",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520} – ходит вдоль каналов",
	-- ["{npc:4155}, in the bank"] = "{npc:4155} – в банке",
	-- ["{npc:5594}, inside"] = "{npc:5594}, внутри",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: предыдущий гайд возвращает вас сюда камнем возвращения, так что это обычно отмечается сразу",
	-- ["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} ({zone:1457}): сохраните задание",
	-- ["{npc:7740}, in the Temple of the Moon"] = "{npc:7740} – в Храме Луны",
	-- ["{npc:8496}, inside"] = "{npc:8496}, внутри",
	-- ["{npc:8737}, at the back of the refuge"] = "{npc:8737} – в глубине лагеря",
	-- ["{npc:9116}, inside"] = "{npc:9116}, внутри",
	-- ["{npc:9117}, below ground"] = "{npc:9117}, под землей",
	-- ["{npc:9518}, below ground"] = "{npc:9518}, под землей",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598} ждет здесь: {area:1767}. Выведите ее из леса, не дав погибнуть.\nОсторожно: вскоре после начала сопровождения на вас нападают трое ({quest:5086}).",
	-- ["{npc:9616}'s jars went to {zone:1455} on the {zone:1452} guide's {zone:1455} stop: fly straight to {area:976}."] = "Банки NPC {npc:9616} вы отвезли в {zone:1455} на остановке «{zone:1455}» в гайде по зоне {zone:1452}: летите прямо сюда: {area:976}.",
	-- ["{npc:9860}, below ground"] = "{npc:9860}, под землей",
	-- ["{npc:9861}, below ground"] = "{npc:9861}, под землей",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}, если вы нашли флягу из-под огненной воды ({area:618})",
	-- ["{object:179565}; inside"] = "{object:179565}; внутри",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085}: {npc:9298} ({area:618}), сохраните задание",
	-- ["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} ({zone:1452}), сохраните задание",
	-- ["{quest:5845}: the route takes it and fetches the Symbol, so its hand-in holds"] = "{quest:5845}: маршрут берет его и добывает Символ, поэтому сдача этого задания остается в маршруте",
	-- ["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} ({area:3197}): сохраните задание",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}, {area:361}, {area:618} и Чумные земли",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} и Чумные земли",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands."] = "{zone:1451}, {zone:1448}, {zone:1452} и Чумные земли.",
	-- ["{zone:1452}: kill these as you meet them"] = "{zone:1452}: убивайте их по пути",
	-- ["{zone:1453} has no shaman trainer"] = "В городе {zone:1453} нет учителя шаманов",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "В городе {zone:1453} нет учителя шаманов: поезжайте на метро ({area:2257}) из места {object:28027} сюда: {zone:1455} – и изучите заклинания 60-го уровня у персонажа {npc:258098}.",
	-- ["{zone:1455} flight master"] = "Распорядитель полетов ({zone:1455})",
}
