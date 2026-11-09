-- Russian (ruRU): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "Вы восстаете в склепе в южной части места {area:154}. {npc:1568} ждет сразу снаружи.",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "Идите по тропе на север сюда: {area:154}; Сарвис стоит перед церковью.",
	["Inside"] = "Внутри",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Безмозглые зомби",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Зомби бродят по кладбищу и у домов чуть к востоку от церкви.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: свиток для {npc:244808}",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church; inside"] = "",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer; inside"] = "",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "{npc:2122}, учитель разбойников",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "{npc:2123}, учитель жрецов, в церкви",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "{npc:2124}, учитель магов, в церкви",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "{npc:2126}, учитель чернокнижников",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "Учителя ({area:154}) стоят вокруг церкви",

	-- Step 5: Injured Deathguard
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["{quest:90902}: the {npc:259377} lie around the church. Heal five of them with {spell:635}."] = "",

	-- Step 6: Deathknell: kill these as you meet them
	-- {area:154} Deathknell
	["{area:154}: kill these as you meet them"] = "",
	-- {area:154} Deathknell · {npc:1661} Novice Elreth
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side. {npc:1661} wants their paws and wings: kill them as you meet them while you clear the skeletons."] = "Скелеты-костетрясы бродят по разрушенным домам в северной половине места {area:154}. Молодые падальщики и сумеречницы бродят вокруг деревни; косматые падальщики и облезлые сумеречницы – в ее восточной части. {npc:1661} нужны их лапы и крылья: убивайте их по пути, пока зачищаете скелетов.",

	-- Step 7: Back to the church
	["Back to the church"] = "Назад к церкви",
	-- {npc:1661} Novice Elreth
	["{npc:1661}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand · {spell:635} Holy Light · {npc:259377} Injured Deathguard
	["{npc:244808}: {spell:635}, once five {npc:259377} are healed"] = "",
	-- {npc:1569} Shadow Priest Sarvis
	["{npc:1569}, inside"] = "",
	-- {npc:244808} Aramis Hammerhand
	["{npc:244808}, inside"] = "",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, в церкви",

	-- Step 8: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662} лежат у разрушенных домов на севере места {area:154}.",

	-- Step 9: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "Назад: {area:154}",

	-- Step 10: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin · {area:155} Night Web's Hollow
	["{quest:91208}: the {npc:246143} fled into the hills west of the church, on the way to {area:155}."] = "",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Предложите помощь: {npc:246143}",

	-- Step 11: Night Web's Hollow
	-- {npc:271961} Webbed Forsaken
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the cocooned {npc:271961} are inside.\nCareful: A low-level character can die quickly if it pulls several Night Web Spiders in the cave at the same time."] = "",
	["Below ground"] = "",
	["attack the cocoons inside the cave to free them; below ground"] = "",
	-- {npc:271961} Webbed Forsaken
	["Free the {npc:271961}"] = "",

	-- Step 13: The Scarlet farm
	["The Scarlet farm"] = "Ферма Алого ордена",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Новообращенные и посвященные из Алого ордена занимают ферму к востоку от места {area:154}. {npc:1919} бродит между домами фермы: его останки – для задания {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, с персонажа {npc:1919}",

	-- Step 14: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090} – на кладбище ({area:154}), у церкви.",

	-- Step 16: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm.\nCareful: He is flanked by two Scarlet guards, one a convert and the other an initiate, who may join the fight."] = "",

	-- Step 18: Solliden Farmstead
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead · {npc:1519} Deathguard Simmer
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}; {npc:1519} stands by the road just past it."] = "Покиньте место {area:154} по дороге на северо-восток. {npc:6784} стоит у дома фермы ({area:156}); {npc:1519} стоит у дороги чуть дальше.",

	-- Step 19: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Тирисфальские тыквы",
	["The pumpkins grow in the Scarlet-held fields just north-west of the farmhouse.\nCareful: Farmers stand close to the pumpkins, so you can pull more than one at once. Scarlet mobs are found around the edges of the farm and a bit to the northwest."] = "Тыквы растут на полях Алого ордена чуть к северо-западу от дома фермы.\nОсторожно: фермеры стоят рядом с тыквами, можно привлечь нескольких сразу. Бойцы Алого ордена встречаются по краям фермы и немного к северо-западу.",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {area:166} Cold Hearth Manor · {area:159} Brill · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road from here east past {area:166} almost to {area:159}, and back: if he isn't at the arrow, follow the road east until you meet him. The {item:12737} grows along the road around him."] = "",

	-- Step 21: Deathguard Dillinger
	-- {npc:1496} Deathguard Dillinger · {npc:1742} Deathguard Bartholomew · {area:159} Brill
	["{npc:1496} and {npc:1742} stand at the west end of {area:159}, where the road from Solliden comes in."] = "{npc:1496} и {npc:1742} стоят на западной окраине места {area:159}, где входит дорога от фермы Соллиден.",
	-- {npc:1742} Deathguard Bartholomew
	["{npc:1742}, beside Dillinger"] = "",

	-- Step 22: Junior Apothecary Holland
	-- {area:159} Brill
	["Holland walks around the north side of {area:159}, a few steps from Dillinger."] = "Холланд ходит по северной части места {area:159}, в нескольких шагах от Диллинджера.",
	-- {npc:10665} Junior Apothecary Holland · {area:159} Brill
	["{npc:10665} walks around {area:159}: look inside the circle on the map"] = "",

	-- Step 23: Dry Branches
	["Dry Branches"] = "Сухие ветки",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Сухие ветки лежат на земле у юго-западной окраины места {area:159}.",

	-- Step 24: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Элеанор стоит лагерем чуть к юго-западу от городка.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "/sit у ее костра, пока не получите {spell:1229451}",

	-- Step 25: Brill
	-- {npc:1518} Apothecary Johaan · {npc:1515} Executor Zygand · {npc:1499} Magistrate Sevren
	["{npc:1518} is in the apothecary's house on the west side of the square, {npc:1515} in front of the inn with the Wanted poster beside him, {npc:1499} in the town hall on the square's north side. The inn comes last, in one go."] = "{npc:1518} – в доме аптекаря на западной стороне площади, {npc:1515} – перед таверной, рядом с ним плакат «Разыскивается», {npc:1499} – в ратуше на северной стороне площади. Таверна – в конце, за один заход.",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, учитель паладинов",
	-- {npc:1515} Executor Zygand
	["{npc:1515}, in front of the inn"] = "{npc:1515}, перед таверной",
	["The Wanted poster by the inn"] = "Плакат «Разыскивается» у таверны",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, в ратуше",

	-- Step 26: Carolai Anise
	-- {npc:2132} Carolai Anise · {area:159} Brill
	["From level 7 {npc:2132}, beside Johaan in the apothecary's house, offers her elixir quest; below 7 it waits for the next {area:159} visit."] = "",
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan; inside"] = "",

	-- Step 27: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Используйте предмет {item:286176} на пяти бездельничающих стражах смерти в городке",

	-- Step 29: Gallows' End Tavern
	-- {npc:5688} Innkeeper Renee · {npc:265944} William Pickman · {npc:1931} Captured Scarlet Zealot · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Everything here is inside the inn, through its door on the south side: {npc:5688} at the bar, {npc:265944} at the north end of the ground floor, the {npc:1931} in the cellar under that end, and {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) upstairs: take the stairs inside, the arrow cannot tell the floors apart."] = "Все здесь внутри таверны, вход с южной стороны: {npc:5688} у стойки, {npc:265944} в северной части первого этажа, {npc:1931} в подвале под ней, а {npc:2128} (маги), {npc:2129} (жрецы), {npc:2127} (чернокнижники) и {npc:2130} (разбойники) наверху: поднимитесь по лестнице внутри, Стрелка не различает этажи.",
	-- {npc:265944} William Pickman
	["{npc:265944}, at the inn's north end: Camping 101 asks you to learn it"] = "{npc:265944}, в северной части таверны: задание «Основы походной жизни» требует его изучить",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the inn's cellar"] = "{npc:1931}, в подвале таверны",
	-- {area:159} Brill · {npc:2131} Austil de Mon · {npc:246152} Shari Stilwell
	["The {area:159} trainers are in the inn ({npc:2131} downstairs, the rest upstairs); {npc:246152}, the Paladin trainer, by the square"] = "Учителя ({area:159}) – в таверне ({npc:2131} внизу, остальные наверху); {npc:246152}, учитель паладинов, у площади",

	-- Step 30: Coleman Farthing and Gretchen Dedmar
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar
	["{npc:1500} and {npc:1521}"] = "",
	-- {npc:1500} Coleman Farthing · {npc:1521} Gretchen Dedmar · {area:159} Brill
	["Still in the inn: from level 7 {npc:1500} on the ground floor and {npc:1521} upstairs offer their quests; below 7 they wait for the next {area:159} visit."] = "",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, в таверне",
	-- {npc:1521} Gretchen Dedmar
	["{npc:1521}, upstairs"] = "",

	-- Step 31: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Лагерь: {npc:1495}",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Идите по дороге на юго-восток от места {area:159} мимо башен дирижаблей. Линнея, Кристоф и {npc:3549} стоят лагерем у дороги.",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Спросите отчет у персонажа {npc:251001}",

	-- Step 32: Deathguard Dillinger
	-- {area:159} Brill
	["Back up the road and through {area:159} to its west end."] = "Назад по дороге через место {area:159} к его западной окраине.",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Спросите отчет у персонажа {npc:1496}",

	-- Step 33: Cold Hearth Manor: kill these as you meet them
	-- {area:166} Cold Hearth Manor
	["{area:166}: kill these as you meet them"] = "",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo · {npc:3549} Shelene Rhobart
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse · Decrepit Darkhounds = {npc:1547} Decrepit Darkhound
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Decrepit Darkhounds roam there and on west along the road toward {npc:10666}. Johaan wants their blood, {npc:3549} their hides."] = "{npc:1525} и изуродованные трупы бродят по полям чуть к западу от места {area:159}; дряхлые псы тьмы бродят там и дальше на запад вдоль дороги к персонажу {npc:10666}. Йохану нужна их кровь, {npc:3549} – их шкуры.",

	-- Step 34: Gordo
	-- {npc:10666} Gordo · {area:159} Brill · {area:166} Cold Hearth Manor
	["{npc:10666} walks the long road west of {area:159}, past {area:166}, and back: the arrow follows his road west until you meet him."] = "",
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Спросите отчет у персонажа {npc:10666}",

	-- Step 35: Calvin Montague
	-- {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["{npc:6784} stands by the farmhouse at the {area:156}, on the way to the Crusader's Outpost."] = "{npc:6784} стоит у дома фермы ({area:156}), по пути к заставе Алого ордена.",
	-- {npc:6784} Calvin Montague · {npc:5688} Innkeeper Renee
	["{npc:6784}, by the farmhouse: talk to him for the duel; he offers it once {npc:5688} has his letter"] = "",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Победите на дуэли: {npc:6784}",

	-- Step 36: Crusader's Outpost
	["Crusader's Outpost"] = "Застава Алого Ордена",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost north-west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out.\nCareful: Scarlet Warriors are level 6-7 and not elite. Once their health falls to 15% they run off to bring help, so more of them may join the fight."] = "Воины из Алого ордена охраняют заставу к северо-западу от тыквенных полей. {npc:275954} в плену внутри: поговорите с ним и оставайтесь рядом, пока он не выберется.\nОсторожно: воины Алого ордена 6-7-го уровня, не элита. При 15% здоровья они убегают за подмогой, так что к бою могут присоединиться другие.",
	-- {npc:275954} Bareth Dawnstone
	["{npc:275954}, on the top floor"] = "",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Выведите {npc:275954} с заставы",

	-- Step 37: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back east along the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "Назад по дороге на восток сюда: {area:159}. {npc:2128} (маги), {npc:2129} (жрецы), {npc:2127} (чернокнижники) и {npc:2130} (разбойники) стоят наверху в таверне: поднимитесь по лестнице внутри, Стрелка не различает этажи.",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} у персонажа {npc:2118}, для Гретхен",

	-- Step 38: Tirisfal Glades: kill these as you meet them
	-- {zone:1420} Tirisfal Glades
	["{zone:1420}: kill these as you meet them"] = "",
	-- {area:159} Brill · {npc:3549} Shelene Rhobart · {quest:5482} Doom Weed · {npc:1753} Maggot Eye
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat · Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber · Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["Greater Duskbats fly over the fields around {area:159} and along the road north: Gretchen wants their pelts, {npc:3549} their wings.\nThe {quest:5482} grows in the graveyard fields just north of {area:159}, where the Rot Hide Graverobbers dig; all the Rot Hides drop the ichor.\nThe Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first.\nCareful: Gnoll guards stand outside the hut and can join the fight. If you slip past them and fight him inside, he fights alone.\nThe Vile Fin murlocs line the north shore: they all drop the scales, and the Minor Oracles and Muckdwellers the skins for {npc:3549}."] = "Большие сумеречницы летают над полями вокруг места {area:159} и вдоль дороги на север: Гретхен нужны их шкурки, {npc:3549} – их крылья.\n{quest:5482} растет на кладбищенских полях чуть к северу от места {area:159}, где роются грабители могил из стаи Гнилошкуров; лимфа падает со всех Гнилошкуров.\nПолукровки из стаи Гнилошкуров занимают холмы дальше к северу. {npc:1753} (11-й уровень) стоит в их лагере на холме к югу от берега: сначала перебейте гноллов вокруг него.\nОсторожно: стражи-гноллы стоят у хижины и могут вмешаться. Если проскользнуть мимо них и сразиться с ним внутри, он будет один.\nМурлоки из племени Злобного Плавника занимают северный берег: чешуя падает со всех, а кожа для {npc:3549} – с младших оракулов и илистых жителей.",
	-- {npc:1675} Rot Hide Mongrel · {area:164} Garren's Haunt
	["{npc:1675} walks around {area:164}: look inside the circle on the map"] = "",
	-- {item:3635} Maggot Eye's Paw
	["{item:3635}; inside"] = "",

	-- Step 39: Brill
	-- {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["{npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:2128} (маги), {npc:2129} (жрецы), {npc:2127} (чернокнижники) и {npc:2130} (разбойники) стоят наверху в таверне: поднимитесь по лестнице внутри, Стрелка не различает этажи.",
	-- {npc:246152} Shari Stilwell · {quest:91282} A Second Home · {quest:96899} Bandarion Keep
	["{npc:246152}, the Paladin trainer: {quest:91282}, to {quest:96899}"] = "",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, inside"] = "",

	-- Step 40: Deathguard Terrence
	-- {npc:1738} Deathguard Terrence · {quest:96895} The Argent Emissary · {npc:267009} Hadric Harlson · {area:159} Brill · {area:157} Agamand Mills
	["From level 10 {npc:1738} offers {quest:96895}: {npc:267009} waits at Linnea's camp, the next stop. Below 10 it waits for the {area:159} visit after {area:157}."] = "",

	-- Step 41: Deathguard Linnea's camp
	-- {area:159} Brill
	["Follow the road south-east from {area:159} past the zeppelin towers."] = "Идите по дороге на юго-восток от места {area:159} мимо башен дирижаблей.",

	-- Step 42: Hadric Harlson
	-- {npc:267009} Hadric Harlson
	["{npc:267009} stands at the camp beside Linnea."] = "",

	-- Step 43: Magistrate Sevren
	-- {area:159} Brill · {area:157} Agamand Mills
	["Back up the road to {area:159}, on the way north-west to {area:157}."] = "Назад по дороге сюда: {area:159}, по пути на северо-запад к месту {area:157}.",

	-- Step 44: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}.\nCareful: Rotting undead and Darkeye Bonecasters near the Agamands can join a fight as adds."] = "Идите по дороге на северо-запад сюда: {area:157}. {npc:1657} бродит по кладбищу к югу от мельниц; Нисса, Грегор и {npc:1656} обитают на самих мельницах. Ребра падают с костетрясов-солдат и костеголовых солдат, черепа – с мрачнооких скелетов-заклинателей, а {item:2839} может упасть с любого.\nОсторожно: гниющая нежить и мрачноокие скелеты-заклинатели рядом с Агамандами могут вмешаться в бой.",
	-- {npc:1655} Nissa Agamand
	["{npc:1655}; upstairs"] = "",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, редкая добыча",
	["Only if the letter dropped"] = "Только если выпало письмо",

	-- Step 45: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, в таверне",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: задание принимает {npc:4568} ({zone:1458})",
	-- {npc:1738} Deathguard Terrence · {area:159} Brill
	["{npc:1738}, if you were below 10 on the last {area:159} visit"] = "",

	-- Step 46: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:6390} ждет в склепе на холме чуть к северу от городка: откройте ворота и сразитесь с ним.",

	-- Step 47: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Идите на юг от места {area:159} сюда: {area:153} и спуститесь в город {zone:1458}. {npc:5675} стоит здесь: {object:36082}. Лагерь Алого ордена – чуть к западу от руин.",

	-- Step 48: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Идите на юг от места {area:159} сюда: {area:153} и спуститесь в город {zone:1458}. {npc:4568} стоит здесь: {object:36082}. Лагерь Алого ордена – чуть к западу от руин.",

	-- Step 49: Back to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Back to {zone:1420}"] = "",
	["The Scarlet camp"] = "Лагерь Алого ордена",

	-- Step 50: Tirisfal Glades: kill these as you meet them
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Идите по дороге на юго-запад от места {area:159} к лагерю Алого ордена. {npc:1662} стоит в его южной части; кольцо может упасть с любого воина Алого ордена.",
	-- {npc:1537} Scarlet Zealot
	["{npc:1537} walks around here: look inside the circle on the map"] = "",

	-- Step 51: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098} стоит рядом с персонажем {npc:1662} в южной части лагеря.",

	-- Step 53: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp, on the road to the cult's farm."] = "",

	-- Step 54: Tirisfal Glades: kill these as you meet them
	-- {npc:1495} Deathguard Linnea
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["Follow the road south-east past {npc:1495}'s camp: the Cult of the Damned holds the farm just south-east of it. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "",

	-- Step 55: Balnir Farmstead: kill these as you meet them
	-- {area:165} Balnir Farmstead
	["{area:165}: kill these as you meet them"] = "",
	-- {quest:99142} Tomb Weed · {npc:1664} Captain Vachon
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit · Scarlet Friars = {npc:1538} Scarlet Friar
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows: Linnea wants eight of each.\nThe Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them.\nThe spiders lurk in the woods at the far east end of the glades."] = "Идите по дороге на восток. Кровоточащие ужасы и странствующие духи бродят у могил в восточной части фермы, где растет {quest:99142}: Линнее нужно по восемь каждых.\nКелейники из Алого ордена стоят лагерем чуть к северо-востоку от могил; {npc:1664} стоит среди них.\nПауки прячутся в лесу на дальнем востоке Тирисфальских лесов.",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, в саду фермы",

	-- Step 57: Brill
	-- {area:159} Brill · {npc:2128} Cain Firesong · {npc:2129} Dark Cleric Beryl · {npc:2127} Rupert Boch · {npc:2130} Marion Call
	["Back up the road to {area:159}. {npc:2128} (mages), {npc:2129} (priests), {npc:2127} (warlocks) and {npc:2130} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "Назад по дороге сюда: {area:159}. {npc:2128} (маги), {npc:2129} (жрецы), {npc:2127} (чернокнижники) и {npc:2130} (разбойники) стоят наверху в таверне: поднимитесь по лестнице внутри, Стрелка не различает этажи.",
	-- {npc:1518} Apothecary Johaan · {area:228} Sepulcher
	["{npc:1518}: for Renferrel at the {area:228}"] = "",
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the inn's cellar"] = "{npc:2211}, в подвале таверны",

	-- Step 58: Leonid Barthalomew the Revered
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {area:16881} Shadowvale
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Every class can take both quests once {quest:96896} is handed in (level 10). They send you into the cellar under {area:16881}, the next stop."] = "",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Выслушайте Леонида и персонажа {npc:246378}, затем снова поговорите с ним",

	-- Step 59: Paladin: Bandarion Keep
	-- {quest:96899} Bandarion Keep
	["Paladin: {quest:96899}"] = "",
	-- {npc:246349} Breton Samuels
	["{npc:246349} waits at the keep's gate beside Leonid."] = "",

	-- Step 60: Paladin: Murlocs at the Gates
	-- {quest:91285} Murlocs at the Gates
	["Paladin: {quest:91285}"] = "",
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs lurk on the bluffs just east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Налетчики из племени Злобного Плавника",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Провидцы из племени Злобного Плавника",

	-- Step 61: Shadowvale
	-- {area:16881} Shadowvale · {area:16616} Whispering Forest
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades, south-west of the {area:16616}. Go down into the big basement under the ruined house (only a floor and a few pillars left, not the two-storey house): the bottles lie on its floor among the Shadowvale Lurchers and Mystics."] = "",
	["the basement under the ruined house"] = "",
	-- {item:286269} Glowing Crystal Fragment
	["the {item:286269}, at the basement's south end"] = "",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["the Shadowvale Lurchers and Mystics drop the bones; below ground"] = "",

	-- Step 62: Hilda the Breaker and Ephram Barbaro
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190}"] = "",
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Back up to the forest's edge south of the keep's gate: {npc:246389} and {npc:259190} take the bones and the crystal."] = "",

	-- Step 63: Paladin: Bandarion Keep
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker · {npc:246349} Breton Samuels · {npc:246393} Jorin Croge · {npc:246394} Ander Solliden · {npc:246378} Danitha Morr
	["{npc:259190} and {npc:246389} at the forest's edge, {npc:246349} at the gate, {npc:246393} and {npc:246394} nearby, {npc:246378} inside."] = "",
	-- {npc:246378} Danitha Morr
	["{npc:246378}, inside the keep"] = "",

	-- Step 64: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} – под местом {area:153}, рядом с башнями дирижаблей. {npc:5675} – здесь: {object:36082}: используйте предмет {item:6284} на круге призыва рядом с ним и одолейте демона Бездны. {npc:4606} – здесь: {object:36070}. {npc:4568} – тоже здесь: {object:36082}.",

	-- Step 66: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, inside"] = "",
	-- {area:159} Brill · {zone:1421} Silverpine Forest
	["The next guide walks south from {area:159} into {zone:1421}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:159}."] = "Назад сюда: {area:159}.",
	-- ["Back up the road to {area:159}."] = "Назад по дороге сюда: {area:159}.",
	-- ["Balnir graves"] = "Могилы фермы Балнира",
	-- ["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Сумеречницы и псы тьмы бродят вдоль всей дороги на запад; доберите крылья и шкуры по пути.",
	-- ["Fields west of {area:159}"] = "Поля к западу от места {area:159}",
	-- ["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Идите по дороге на восток сюда: {area:159}. {npc:10665} стоит на северо-западной окраине городка; {area:2119} – большая таверна в центре, {npc:1515} – перед ней.",
	-- ["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Идите по дороге на восток. Кровоточащие ужасы и странствующие духи бродят у могил в восточной части фермы, где растет {quest:99142}.",
	-- ["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Идите по дороге на северо-восток от места {area:159} мимо места {area:162}. {npc:1665} и два телохранителя из Алого ордена занимают сторожевую башню на северо-восточном побережье, к северу от места {area:459}: сначала выманите телохранителей.",
	-- ["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Идите по дороге на северо-запад сюда: {area:157}. {npc:1657} бродит по кладбищу к югу от мельниц; Нисса, Грегор и {npc:1656} обитают на самих мельницах. Ребра падают с костетрясов-солдат и костеголовых солдат, черепа – с мрачнооких скелетов-заклинателей, а {item:2839} может упасть с любого. Отсюда убивайте встречных сумеречниц и псов тьмы: {npc:3549} нужны их крылья и шкуры.",
	-- ["Follow the road south back to {area:159}."] = "Идите по дороге на юг обратно сюда: {area:159}.",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Идите по дороге на запад мимо места {area:157} сюда: {area:16616}. Леонид стоит чуть к северу от лагеря {npc:246389}.",
	-- ["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp.\n{npc:246389} and {npc:259190} camp at the forest's edge just south of Leonid. Every class can take both quests once {quest:96896} is handed in (level 10); take them if they are offered. They send you into the cellar under {area:16881}, the next stop."] = "Идите по дороге на запад мимо места {area:157} сюда: {area:16616}. Леонид стоит чуть к северу от лагеря {npc:246389}.\n{npc:246389} и {npc:259190} стоят лагерем на опушке леса чуть к югу от Леонида. Когда задание {quest:96896} сдано (10-й уровень), любой класс может взять оба задания; берите их, если предлагают. Они отправят вас в подвал под местом {area:16881} – это следующая остановка.",
	-- ["Free six Webbed Victims inside the cave for {npc:244808}"] = "Освободите шесть жертв в коконах в пещере для {npc:244808}",
	-- ["Greater Duskbats"] = "Большие сумеречницы",
	-- ["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Большие сумеречницы летают над полями вокруг места {area:159} и вдоль дороги на север.",
	-- ["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Идите на запад сюда: {area:16616}; {npc:246389} и {npc:259190} стоят лагерем на окраине.",
	-- ["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Идите на запад к пещере. Молодые ночные кругопряды сидят снаружи; ночные кругопряды и жертвы в коконах – внутри.",
	-- ["Hearth to {area:159}"] = "Камень возвращения: {area:159}",
	-- ["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Покиньте место {area:154} по дороге на северо-восток. {npc:6784} стоит у дома фермы ({area:156}).",
	-- ["More Vile Fin murlocs walk the shore just north of the outpost."] = "Еще мурлоки Злобного Плавника бродят по берегу чуть к северу от заставы.",
	-- ["Paladin: {area:16616}"] = "Паладин: {area:16616}",
	-- ["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Паладины: задание {quest:90902} выполнено, когда вы вылечите заклинанием {spell:635} пятерых у церкви: {npc:259377}.",
	-- ["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Скелеты-костетрясы бродят по разрушенным домам в северной половине места {area:154}. Молодые падальщики и сумеречницы бродят вокруг деревни; косматые падальщики и облезлые сумеречницы – в ее восточной части.",
	-- ["Rattlecage skulls"] = "Черепа костетрясов",
	-- ["Rattlecages, scavengers and duskbats"] = "Костетрясы, падальщики и сумеречницы",
	-- ["Rot Hide graveyards"] = "Кладбища Гнилошкуров",
	-- ["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Воины из Алого ордена охраняют заставу чуть к западу от тыквенных полей. {npc:275954} в плену внутри: поговорите с ним и оставайтесь рядом, пока он не выберется.",
	-- ["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Идите по дороге на юго-восток от места {area:159}; Терренс стоит на ней, не доходя до башен дирижаблей.",
	-- ["Talk to {npc:265944}"] = "Поговорите с персонажем {npc:265944}",
	-- ["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Черепа падают со скелетов-костетрясов в разрушенных домах.",
	-- ["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Грабители могил из стаи Гнилошкуров роются на кладбищах к северу от места {area:159}; лимфа падает со всех Гнилошкуров.",
	-- ["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Полукровки из стаи Гнилошкуров занимают холмы дальше к северу. {npc:1753} (11-й уровень) стоит в их лагере на холме к югу от берега: сначала перебейте гноллов вокруг него.",
	-- ["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Келейники из Алого ордена стоят лагерем чуть к северо-востоку от могил; {npc:1664} стоит среди них.",
	-- ["The Vile Fin murlocs line the north shore."] = "Мурлоки из племени Злобного Плавника занимают северный берег.",
	-- ["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Тыквы растут на полях Алого ордена к северо-западу от фермы Соллиден.",
	-- ["The spiders lurk in the woods at the far east end of the glades."] = "Пауки прячутся в лесу на дальнем востоке Тирисфальских лесов.",
	-- ["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "Пауки прячутся в лесу на дальнем востоке Тирисфальских лесов. {npc:276020}, поганище-отступник, бродит чуть к северо-западу от них. {npc:276020} – элита: лучше собрать группу.",
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "Дирижабль причаливает к башне чуть к северо-востоку от главных ворот ({zone:1454}). Идите по дороге на юг в край {zone:1411}, перейдите мост ({area:815}) под местом {area:379} и идите по дороге на запад к месту {area:380}.",
	-- ["The {area:159} trainers are in and around the inn"] = "Учителя ({area:159}) – в таверне и вокруг нее",
	-- ["The {npc:1931}, in the town hall basement"] = "{npc:1931}, в подвале ратуши",
	-- ["The {npc:2211}, in the town hall basement"] = "{npc:2211}, в подвале ратуши",
	-- ["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482} растет на кладбищенских полях чуть к северу от места {area:159}.",
	-- ["Vicious Night Web Spiders"] = "Злобные ночные кругопряды",
	-- ["Vile Fin murlocs"] = "Мурлоки Злобного Плавника",
	-- ["Vile Fin shore"] = "Берег Злобного Плавника",
	-- ["Walk on west to the {area:156}. {npc:1519} stands at the farm; {npc:6784}, by the farmhouse, wants a duel: talk to him."] = "Идите дальше на запад сюда: {area:156}. {npc:1519} стоит на ферме; {npc:6784} у дома хочет дуэли: поговорите с ним.",
	-- ["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Идите дальше на запад к NPC {npc:6784} и поговорите с ним: он хочет дуэль.",
	-- ["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Идите на юго-восток от места {area:159} к башням дирижаблей у места {area:153} и садитесь на дирижабль ({zone:1454}) (другой летит сюда: {object:3202}).",
	-- ["Walk south-west from the mills: the pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Идите на юго-запад от мельниц: тыквы растут на полях Алого ордена к северо-западу от фермы Соллиден.",
	-- ["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Идите на юго-запад сюда: {area:156}; Симмер стоит на ферме.",
	-- ["Webbed Victims"] = "Жертвы в коконах",
	-- ["Zeppelin to {zone:1411}"] = "Дирижабль: {zone:1411}",
	-- ["Zeppelin tower"] = "Башня дирижаблей",
	-- ["in the inn: ask him about cooking"] = "в таверне: спросите его о кулинарии",
	-- ["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} – лощина у западного края леса. Кости падают с тенедольных шпионов и мистиков; бутылки лежат на земле среди них, а {item:286269} – в южной части.",
	-- ["{item:286326}, from {npc:276020}"] = "{item:286326}, с NPC {npc:276020}",
	-- ["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, большое поганище, ходит по дороге чуть дальше к востоку. {item:12737} растет вдоль дороги вокруг него.",
	-- ["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: {npc:276020}, элитное поганище на востоке",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} стоит здесь: {area:159}. {npc:6390} ждет в мавзолее на холме чуть к северу от городка: откройте ворота и сразитесь с ним.",
	-- ["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} и разложившиеся трупы бродят по полям чуть к западу от места {area:159}; псы тьмы – чуть дальше к западу, к персонажу {npc:10666}.",
	-- ["{npc:1661}, beside the church"] = "{npc:1661}, у церкви",
	-- ["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} стоит в южной части фермы Алого ордена.",
	-- ["{npc:2119}, the warrior trainer"] = "{npc:2119}, учитель воинов",
	-- ["{npc:2132}, beside Johaan"] = "{npc:2132}, рядом с Йоханом",
	-- ["{npc:244808} and {npc:5667}"] = "{npc:244808} и {npc:5667}",
	-- ["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} и {npc:5667} стоят у церкви.",
	-- ["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} стоит в лагере ({npc:1495}).",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, распорядитель полетов",
	-- ["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: {npc:246143} сбежал на холмы чуть к западу от церкви.",
	-- ["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} занимает ферму чуть к юго-востоку от лагеря. Осколки некротического кристалла лежат на земле среди сектантов, и у сектантов они тоже есть.",
}
