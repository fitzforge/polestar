-- Russian (ruRU): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:253092} Alba Fairmoon · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} и {npc:821} стоят на вершине каменной башни. {npc:491} – в башне; {npc:878} и {npc:253092} – на южном склоне холма, рядом с таверной и укротителем грифонов (это {npc:523}).",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}; от бесплатного полета откажитесь",

	-- Step 2: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Идите по дороге на север. {npc:233} стоит снаружи, {npc:235} – в доме, {npc:253395} – в амбаре к западу.",

	-- Step 3: The Jansen Stead
	["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Дальше на север по дороге. Супруги Хмуробров сидят у своей сгоревшей фермы. По пути собирайте овес из мешков овса на полях и наполните склянку у колодца усадьбы.",
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Только если вы добыли в Элвиннском лесу предмет {item:1972}: щелкните по нему правой кнопкой",
	["Fill the vial at the well"] = "Наполните склянку у колодца",
	["Sacks of Oats"] = "Мешки овса",

	-- Step 4: Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "По полям вокруг фермы бродят молодые жутевепри и шкуродеры: на обратном пути начинайте собирать печень и мясо для похлебки.",

	-- Step 5: Molsen Farm
	-- {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "К западу от фермы Сальденов. На полях работают дозорные полей и уборочные големы; с них падают изопружины, гиростабилизаторы, {item:732}, а иногда и {item:255155}. Здесь бродит редкий противник 20-го уровня – {npc:573}: не трогайте его. На каждом отрезке этого круга продолжайте убивать жутевепрей и шкуродеров.",
	["Fill the vial at the farm's well"] = "Наполните склянку у колодца фермы",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Дозорные полей",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: шкуродеры",

	-- Step 6: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "К западу от фермы Мольсена, в сторону побережья. В карьере работают шахтеры из стаи Речной Лапы.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Шахтеры из стаи Речной Лапы",

	-- Step 7: Jangolode Mine
	-- {object:290} Furlbrow's Wardrobe
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Kobold Diggers = {npc:1236} Kobold Digger
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "К северу от фермы Мольсена. Звероловы и контрабандисты из Братства Справедливости стоят лагерем у входа в рудник, внутри работают кобольды-землекопы. {object:290} – у разрушенного дома к востоку от рудника.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Кобольды-землекопы",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}: падают со всех членов Братства Справедливости",

	-- Step 8: The north coast
	["The north coast"] = "Северное побережье",
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "На пляже к северу от рудника полно мурлоков-береговиков и мурлоков-налетчиков. При низком здоровье они убегают: выманивайте по одному.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Жабры мурлока с Бескрайнего берега",

	-- Step 9: The gnoll hills
	["The gnoll hills"] = "Холмы гноллов",
	-- {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Гноллы и разведчики из стаи Речной Лапы бродят по холмам между побережьем и {area:916}.",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Лапы гнолла",

	-- Step 11: Saldean's Farm
	["Only if he takes the isosprings alone"] = "Только если он принимает одни изопружины",

	-- Step 13: The western farms
	["The western farms"] = "Западные фермы",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Погромщики и мошенники из Братства Справедливости занимают фермы к западу (ориентир: {area:108}), между прибрежной дорогой и поселением {area:20}.",

	-- Step 15: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20} и холмы Братства Справедливости",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "По поселению {area:20} ходят налетчики и кастетники из Братства Справедливости; проходимцы (17-й уровень) патрулируют парами холмы к югу и востоку от него: выманивайте их поодиночке. Вход в {area:1581} в кузнице ведет в групповое подземелье.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}: из ящиков вокруг поселения {area:20}",

	-- Step 16: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "Назад: {area:108}",
	["Hearthstone on cooldown? Follow the road north-east."] = "Камень возвращения перезаряжается? Идите по дороге на северо-восток.",
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Для NPC {npc:266} ({area:69}, Красногорье)",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Для NPC {npc:11026} ({zone:1453}, {object:28027})",

	-- Step 17: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Летите или езжайте в город {zone:1453}. {npc:5480} обучает воинов ({object:2100}); там же у входа ({object:2152}) вместе стоят {npc:6089} и {npc:6090}. {npc:6090} сразится с вами за свою кружку.",

	-- Step 18: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Летите или езжайте в город {zone:1453}. {npc:376} – в Соборе Света.",

	-- Step 19: Shaman training
	["Shaman training"] = "Обучение шамана",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Езжайте в город {zone:1453}. Там нет учителя шаманов: в районе {object:28027} сядьте на поезд ({area:2257}) до города {zone:1455}, обучитесь у NPC {npc:258098} и вернитесь на поезде к кораблю.",

	-- Step 20: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:11026} Sprite Jumpsprocket · {object:28027} Dwarven District · {npc:279} Morgan Pestle · {object:2096} Trade District
	["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Летите или езжайте в город {zone:1453}. Учителя: {object:2100} (воины, разбойники), собор (паладины, жрецы), {object:2101} (маги, чернокнижники), парк (друиды). {npc:11026} работает здесь: {object:28027}; {npc:279} – здесь: {object:2096}.",
	["Level 12, 14 and 16 spells"] = "Заклинания 12, 14 и 16-го уровней",
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} для задания «Сбор лекарственных ингредиентов» (6123), {zone:1439}: {npc:1313}, товары для алхимиков; травники вместо этого собирают его там сами",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, Святилище волшебника: {quest:1861}",

	-- Step 21: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} продает рыболовные принадлежности у канала, чуть западнее (ориентир: {object:2096}); {npc:267118} рыбачит в гавани, по пути к кораблю.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}: продает {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Гноллы и разведчики из стаи Речной Лапы бродят по холмам между побережьем и местностью {area:916}.",
}
