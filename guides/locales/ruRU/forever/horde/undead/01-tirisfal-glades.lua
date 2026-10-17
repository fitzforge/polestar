-- Russian (ruRU): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "Безмозглые зомби",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "Зомби бродят по кладбищу и у домов чуть к востоку от церкви.",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church"] = "{npc:1661}, у церкви",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer"] = "{npc:2119}, учитель воинов",
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

	-- Step 5: Aramis Hammerhand and Venya Marthand
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667}"] = "{npc:244808} и {npc:5667}",
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808} и {npc:5667} стоят у церкви.",
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}: свиток для {npc:244808}",

	-- Step 6: Rattlecages, scavengers and duskbats
	["Rattlecages, scavengers and duskbats"] = "Костетрясы, падальщики и сумеречницы",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "Скелеты-костетрясы бродят по разрушенным домам в северной половине места {area:154}. Молодые падальщики и сумеречницы бродят вокруг деревни; косматые падальщики и облезлые сумеречницы – в ее восточной части.",

	-- Step 7: Rattlecage skulls
	["Rattlecage skulls"] = "Черепа костетрясов",
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "Черепа падают со скелетов-костетрясов в разрушенных домах.",

	-- Step 8: Back to the church
	["Back to the church"] = "Назад к церкви",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}, в церкви",

	-- Step 9: Aramis Hammerhand and Venya Marthand
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "Паладины: задание {quest:90902} выполнено, когда вы вылечите заклинанием {spell:635} пятерых у церкви: {npc:259377}.",

	-- Step 10: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662} лежат у разрушенных домов на севере места {area:154}.",

	-- Step 11: Night Web's Hollow
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "Идите на запад к пещере. Молодые ночные кругопряды сидят снаружи; ночные кругопряды и жертвы в коконах – внутри.",
	-- {npc:244808} Aramis Hammerhand
	["Free six Webbed Victims inside the cave for {npc:244808}"] = "Освободите шесть жертв в коконах в пещере для {npc:244808}",
	["Webbed Victims"] = "Жертвы в коконах",

	-- Step 12: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "Назад: {area:154}",

	-- Step 13: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin
	["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}: {npc:246143} сбежал на холмы чуть к западу от церкви.",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "Предложите помощь: {npc:246143}",

	-- Step 14: The Scarlet farm
	["The Scarlet farm"] = "Ферма Алого ордена",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "Новообращенные и посвященные из Алого ордена занимают ферму к востоку от места {area:154}. {npc:1919} бродит между домами фермы: его останки – для задания {quest:6395}.",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}, с персонажа {npc:1919}",

	-- Step 15: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090} – на кладбище ({area:154}), у церкви.",

	-- Step 17: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667} стоит в южной части фермы Алого ордена.",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "Покиньте место {area:154} по дороге на северо-восток. {npc:6784} стоит у дома фермы ({area:156}).",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}, большое поганище, ходит по дороге чуть дальше к востоку. {item:12737} растет вдоль дороги вокруг него.",

	-- Step 21: Brill
	-- {area:159} Brill · {npc:10665} Junior Apothecary Holland · {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "Идите по дороге на восток сюда: {area:159}. {npc:10665} стоит на северо-западной окраине городка; {area:2119} – большая таверна в центре, {npc:1515} – перед ней.",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}, учитель паладинов",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "Спросите отчет у персонажа {npc:1496}",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "Учителя ({area:159}) – в таверне и вокруг нее",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "Используйте предмет {item:286176} на пяти бездельничающих стражах смерти в городке",

	-- Step 23: Doom Weed
	-- {quest:5482} Doom Weed · {area:159} Brill
	["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482} растет на кладбищенских полях чуть к северу от места {area:159}.",

	-- Step 25: Dry Branches
	["Dry Branches"] = "Сухие ветки",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "Сухие ветки лежат на земле у юго-западной окраины места {area:159}.",

	-- Step 26: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "Элеанор стоит лагерем чуть к юго-западу от городка.",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "/sit у ее костра, пока не получите {spell:1229451}",

	-- Step 27: Fields west of Brill
	-- {area:159} Brill
	["Fields west of {area:159}"] = "Поля к западу от места {area:159}",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525} и разложившиеся трупы бродят по полям чуть к западу от места {area:159}; псы тьмы – чуть дальше к западу, к персонажу {npc:10666}.",

	-- Step 28: Gordo
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "Спросите отчет у персонажа {npc:10666}",

	-- Step 29: Calvin Montague
	-- {npc:6784} Calvin Montague
	["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "Идите дальше на запад к NPC {npc:6784} и поговорите с ним: он хочет дуэль.",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "Победите на дуэли: {npc:6784}",

	-- Step 30: Hearth to Brill
	-- {area:159} Brill
	["Hearth to {area:159}"] = "Камень возвращения: {area:159}",

	-- Step 31: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan"] = "{npc:2132}, рядом с Йоханом",
	["in the inn: ask him about cooking"] = "в таверне: спросите его о кулинарии",
	-- {npc:265944} William Pickman
	["Talk to {npc:265944}"] = "Поговорите с персонажем {npc:265944}",
	["The Wanted poster by the inn"] = "Плакат «Разыскивается» у таверны",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}, в ратуше",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}, в таверне",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "{item:2320} у персонажа {npc:2118}, для Гретхен",

	-- Step 32: Greater Duskbats
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats"] = "Большие сумеречницы",
	-- {area:159} Brill
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "Большие сумеречницы летают над полями вокруг места {area:159} и вдоль дороги на север.",

	-- Step 33: Rot Hide graveyards
	["Rot Hide graveyards"] = "Кладбища Гнилошкуров",
	-- {area:159} Brill
	-- plural, as words: Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber
	["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "Грабители могил из стаи Гнилошкуров роются на кладбищах к северу от места {area:159}; лимфа падает со всех Гнилошкуров.",

	-- Step 34: Maggot Eye
	-- {npc:1753} Maggot Eye
	-- plural, as words: Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "Полукровки из стаи Гнилошкуров занимают холмы дальше к северу. {npc:1753} (11-й уровень) стоит в их лагере на холме к югу от берега: сначала перебейте гноллов вокруг него.",

	-- Step 35: Vile Fin murlocs
	["Vile Fin murlocs"] = "Мурлоки Злобного Плавника",
	["The Vile Fin murlocs line the north shore."] = "Мурлоки из племени Злобного Плавника занимают северный берег.",

	-- Step 36: Brill
	-- {area:159} Brill
	["Follow the road south back to {area:159}."] = "Идите по дороге на юг обратно сюда: {area:159}.",

	-- Step 37: Deathguard Linnea
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "Идите по дороге на юго-восток от места {area:159} мимо башен дирижаблей. Линнея, Кристоф и {npc:3549} стоят лагерем у дороги.",
	-- {npc:1495} Deathguard Linnea · {npc:276020} Riptear
	["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}: {npc:276020}, элитное поганище на востоке",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "Спросите отчет у персонажа {npc:251001}",

	-- Step 38: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "Назад по дороге сюда: {area:159}.",

	-- Step 39: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "Идите по дороге на северо-запад сюда: {area:157}. {npc:1657} бродит по кладбищу к югу от мельниц; Нисса, Грегор и {npc:1656} обитают на самих мельницах. Ребра падают с костетрясов-солдат и костеголовых солдат, черепа – с мрачнооких скелетов-заклинателей, а {item:2839} может упасть с любого. Отсюда убивайте встречных сумеречниц и псов тьмы: {npc:3549} нужны их крылья и шкуры.",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}, редкая добыча",
	["Only if the letter dropped"] = "Только если выпало письмо",

	-- Step 40: Deathguard Simmer
	-- {area:156} Solliden Farmstead
	["Walk south-west to the {area:156}; Simmer stands at the farm."] = "Идите на юго-запад сюда: {area:156}; Симмер стоит на ферме.",

	-- Step 41: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "Тирисфальские тыквы",
	["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "Тыквы растут на полях Алого ордена к северо-западу от фермы Соллиден.",

	-- Step 42: Crusader's Outpost
	["Crusader's Outpost"] = "Застава Алого Ордена",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "Воины из Алого ордена охраняют заставу чуть к западу от тыквенных полей. {npc:275954} в плену внутри: поговорите с ним и оставайтесь рядом, пока он не выберется.",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "Выведите {npc:275954} с заставы",

	-- Step 43: Vile Fin shore
	["Vile Fin shore"] = "Берег Злобного Плавника",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "Еще мурлоки Злобного Плавника бродят по берегу чуть к северу от заставы.",

	-- Step 44: Paladin: Whispering Forest
	-- {area:16616} Whispering Forest
	["Paladin: {area:16616}"] = "Паладин: {area:16616}",
	-- {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "Идите на запад сюда: {area:16616}; {npc:246389} и {npc:259190} стоят лагерем на окраине.",

	-- Step 45: Shadowvale
	-- {area:16881} Shadowvale · {item:286269} Glowing Crystal Fragment
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881} – лощина у западного края леса. Кости падают с тенедольных шпионов и мистиков; бутылки лежат на земле среди них, а {item:286269} – в южной части.",

	-- Step 48: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}, в таверне",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "{npc:1931}, в подвале ратуши",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}: задание принимает {npc:4568} ({zone:1458})",

	-- Step 49: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} стоит здесь: {area:159}. {npc:6390} ждет в мавзолее на холме чуть к северу от городка: откройте ворота и сразитесь с ним.",

	-- Step 50: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Идите на юг от места {area:159} сюда: {area:153} и спуститесь в город {zone:1458}. {npc:5675} стоит здесь: {object:36082}. Лагерь Алого ордена – чуть к западу от руин.",

	-- Step 51: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "Идите на юг от места {area:159} сюда: {area:153} и спуститесь в город {zone:1458}. {npc:4568} стоит здесь: {object:36082}. Лагерь Алого ордена – чуть к западу от руин.",

	-- Step 52: The Scarlet camp
	["The Scarlet camp"] = "Лагерь Алого ордена",
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "Идите по дороге на юго-запад от места {area:159} к лагерю Алого ордена. {npc:1662} стоит в его южной части; кольцо может упасть с любого воина Алого ордена.",

	-- Step 53: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098} стоит рядом с персонажем {npc:1662} в южной части лагеря.",

	-- Step 55: Deathguard Terrence
	-- {area:159} Brill
	["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "Идите по дороге на юго-восток от места {area:159}; Терренс стоит на ней, не доходя до башен дирижаблей.",

	-- Step 56: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009} стоит в лагере ({npc:1495}).",

	-- Step 57: Balnir Farmstead
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897} занимает ферму чуть к юго-востоку от лагеря. Осколки некротического кристалла лежат на земле среди культистов, часть – у самих культистов.",

	-- Step 58: Balnir graves
	["Balnir graves"] = "Могилы фермы Балнира",
	-- {quest:99142} Tomb Weed
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "Идите по дороге на восток. Кровоточащие ужасы и странствующие духи бродят у могил в восточной части фермы, где растет {quest:99142}.",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}, в саду фермы",

	-- Step 59: Captain Vachon
	-- {npc:1664} Captain Vachon
	-- plural, as words: Scarlet Friars = {npc:1538} Scarlet Friar
	["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "Келейники из Алого ордена стоят лагерем чуть к северо-востоку от могил; {npc:1664} стоит среди них.",

	-- Step 60: Vicious Night Web Spiders
	-- plural, as words: Vicious Night Web Spiders = {npc:1555} Vicious Night Web Spider
	["Vicious Night Web Spiders"] = "Злобные ночные кругопряды",
	-- {npc:276020} Riptear
	["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "Пауки прячутся в лесу на дальнем востоке Тирисфальских лесов. {npc:276020}, поганище-отступник, бродит чуть к северо-западу от них. {npc:276020} – элита: лучше собрать группу.",
	-- {item:286326} Riptear's Heart · {npc:276020} Riptear
	["{item:286326}, from {npc:276020}"] = "{item:286326}, с NPC {npc:276020}",

	-- Step 61: Hides for the Forsaken
	-- plural, as words: Duskbats = {npc:1512} Duskbat
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "Сумеречницы и псы тьмы бродят вдоль всей дороги на запад; доберите крылья и шкуры по пути.",

	-- Step 62: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "Лагерь: {npc:1495}",

	-- Step 63: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "{npc:2211}, в подвале ратуши",

	-- Step 64: Captain Melrache
	-- {area:159} Brill · {area:162} Brightwater Lake · {npc:1665} Captain Melrache · {area:459} Scarlet Watch Post
	-- plural, as words: Scarlet Bodyguards = {npc:1660} Scarlet Bodyguard
	["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "Идите по дороге на северо-восток от места {area:159} мимо места {area:162}. {npc:1665} и два телохранителя из Алого ордена занимают сторожевую башню на северо-восточном побережье, к северу от места {area:459}: сначала выманите телохранителей.",

	-- Step 65: Executor Zygand
	-- {area:159} Brill
	["Back to {area:159}."] = "Назад сюда: {area:159}.",

	-- Step 66: Leonid Barthalomew
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "Идите по дороге на запад мимо места {area:157} сюда: {area:16616}. Леонид стоит чуть к северу от лагеря {npc:246389}.",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "Выслушайте Леонида и персонажа {npc:246378}, затем снова поговорите с ним",

	-- Step 68: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661} – под местом {area:153}, рядом с башнями дирижаблей. {npc:5675} – здесь: {object:36082}: используйте предмет {item:6284} на круге призыва рядом с ним и одолейте демона Бездны. {npc:4606} – здесь: {object:36070}. {npc:4568} – тоже здесь: {object:36082}.",

	-- Step 69: Zeppelin to Durotar
	-- {zone:1411} Durotar
	["Zeppelin to {zone:1411}"] = "Дирижабль: {zone:1411}",
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "Идите на юго-восток от места {area:159} к башням дирижаблей у места {area:153} и садитесь на дирижабль ({zone:1454}) (другой летит сюда: {object:3202}).",
	["Zeppelin tower"] = "Башня дирижаблей",

	-- Step 70: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:815} Southfury River · {area:379} Far Watch Post · {area:380} The Crossroads
	["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "Дирижабль причаливает к башне чуть к северо-востоку от главных ворот ({zone:1454}). Идите по дороге на юг в край {zone:1411}, перейдите мост ({area:815}) под местом {area:379} и идите по дороге на запад к месту {area:380}.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}, распорядитель полетов",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "Дирижабль причаливает к башне чуть к северо-востоку от главных ворот ({zone:1454}). Идите по дороге на юг в край {zone:1411}, перейдите мост ({area:815}) под местом {area:379} и идите по дороге на запад сюда: {area:380}.",
}
