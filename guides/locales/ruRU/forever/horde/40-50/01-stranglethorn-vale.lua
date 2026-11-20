-- Russian (ruRU): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Летите сюда: {area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "Ваше обучение на 40-м уровне – здесь: {area:1497}. Летите туда из места {area:340}, обучитесь и сядьте на дирижабль у башен за городом до места {object:3202}.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Распорядитель полетов: {area:340}",

	-- Step 2: Undercity trainers
	-- {area:1497} Undercity
	["{area:1497} trainers"] = "Учителя: {area:1497}",

	-- Step 3: Riding at 40
	["Riding at 40"] = "Верховая езда на 40-м",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; при обучении вы получаете ездовое животное. Каждая раса учится у учителя своей расы: ваш – {npc:4773} ({area:159}), недалеко к северу от башен дирижаблей, рядом кони-скелеты NPC {npc:4731} (по 20 золотых). Вернитесь к башням, чтобы сесть на дирижабль до места {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, учитель верховой езды",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Кони-скелеты: {npc:4731}, рядом с NPC {npc:4773} ({area:159}).",

	-- Step 4: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "Дирижабль: {object:3202}",

	-- Step 5: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите сюда: {object:3202}",

	-- Step 6: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "",

	-- Step 7: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Тропические ловцы",
	-- {object:3202} Grom'gol · {npc:730} Tethis · {quest:195} Raptor Mastery
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights.\nCareful: {npc:730}, a level 43 elite raptor, roams among the stalkers: leave him for {quest:195}'s group step."] = "Тропические ловцы (40-41) охотятся на побережье к югу от места {object:3202}. Они намного выше вас: выманивайте по одному и отдыхайте между боями.\nОсторожно: среди ловцов бродит {npc:730}, элитный ящер 43-го уровня: оставьте его для группового шага задания {quest:195}.",

	-- Step 9: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Летите: {area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Грингер, распорядитель полетов, ждет на верхней палубе ({area:35}). Персонажи с заданиями стоят на мостках вокруг гавани и в таверне.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}: {npc:2635} греется на побережье между Зул'Кундой и местом {object:3202}, позже на этом круге",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, на пристани: письмо Газлоу, если оно у вас есть",
	-- {npc:4631} Wharfmaster Lozgil · {quest:97332} Twice Misplaced Trust · {npc:259961} Wharfmaster Whizzbuzz · {area:16727} Powderfuse Port · {zone:2548} Riverglades
	["{npc:4631}: {quest:97332}, after Zimmix's rescue; the package goes to {npc:259961} at {area:16727}, in the {zone:2548} guide"] = "{npc:4631}: {quest:97332}, после спасения Зиммикса; посылка – для NPC {npc:259961} в месте {area:16727}, в гайде по зоне {zone:2548}",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, на балконе рядом с Мак-Кинли",
	["Inside"] = "Внутри",

	-- Step 11: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs, has his next errand now: the Skullsplitter tusks come from the trolls of Zul'Mamwe, later on this loop."] = "У NPC {npc:737} наверху теперь есть следующее поручение: клыки Дробителей Черепов – с троллей Зул'Мамве, позже на этом круге.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, наверху",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Выйдите из города через туннель; записка лежит в пиратской бухте чуть к северу от места {area:35}.",

	-- Step 14: Mistvale gorillas
	["Mistvale gorillas"] = "Гориллы из Мглистой долины",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "Гориллы бродят по долине вокруг Унбагвы. С вожаков падают потроха; клык может упасть с любой: сохраните десять для Унбагвы, чей Мокк (44) ждет вашего визита в Тернистую долину примерно на 45-м.\nОсторожно: старые гориллы из Мглистой долины (40-41) стоят в долине близко друг к другу: выманивайте по одному.",

	-- Step 16: Venture Co. mine
	["Venture Co. mine"] = "Рудник Торговой компании",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Дальше к северу гоблины Торговой компании копают в руднике к востоку от дороги; кристаллы падают с шахтеров, десятников, геодезистов и механиков.\nОсторожно: по округе вокруг лагеря в незаметности бродят пантеры Тенегрызов и тигрицы Тернистой долины.",

	-- Step 17: Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Shadowmaw Panthers"] = "",
	-- {quest:192} Panther Mastery
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["{quest:192} is still open: the Shadowmaw Panthers (37-38) stalk the jungle north of the mine, towards the Mosh'Ogg hills. They use Sneak, so they show only when you are close: pull them one at a time, and leave the Elder Shadowmaw Panthers (42-43) alone."] = "",

	-- Step 19: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "",
	-- {quest:195} Raptor Mastery · {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:195} is still open: the Lashtail Raptors (35-36) hunt the jungle between {object:3202} and Nesingwary's camp, on your way north."] = "",

	-- Step 20: Nesingwary's camp
	["Nesingwary's camp"] = "Лагерь Эрнестуэя",
	["Head north up the road; the hunters camp on the hill above the river."] = "Идите на север по дороге; лагерь охотников – на холме над рекой.",

	-- Step 21: Sin'Dall
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["{npc:729}, the tiger {npc:717} sent you after on your last visit, prowls the hilltop just south-west of the camp."] = "{npc:729} – тигр, за которым вас отправил {npc:717} в прошлый раз, – бродит по вершине холма чуть к юго-западу от лагеря.",

	-- Step 24: Nesingwary's camp
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Вы пропустили это при прошлом посещении этих мест по маршруту: теперь это идёт первым. Это быстро и открывает следующие задания.",

	-- Step 25: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716} собирает страницы книги «{quest:338}»: время от времени они падают с троллей долины. Возьмите его задание; каждую главу он принимает, когда у вас есть все ее страницы.",

	-- Step 26: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}: все страницы главы I в сумках",

	-- Step 27: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}: все страницы главы II в сумках",

	-- Step 28: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}: все страницы главы III в сумках",

	-- Step 29: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}: все страницы главы IV в сумках",

	-- Step 30: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}: четыре главы",

	-- Step 31: Zul'Kunda
	["Zul'Kunda"] = "Зул'Кунда",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {object:3202} Grom'gol · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "К западу от экспедиции вожди племени Кровавого Скальпа – {npc:1061} и {npc:1062} – стоят вместе в руинах Зул'Кунды. Сначала перебейте охрану, затем выманите их.\nНа побережье между Зул'Кундой и местом {object:3202} {npc:2635} (элитный, 38-й уровень) появляется на месте обычных кроколисков: если он на месте, убейте его и снимите шкуру для {npc:2495}.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "",

	-- Step 32: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, рядом: {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: для зоны {zone:1425}, примерно на 48-м уровне",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}: трофейные черепа стоят в руинах Дробителей Черепов, позже на этом круге",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}: вход в пещеру под местом {area:104}, к западу от лагеря",

	-- Step 33: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1454} Orgrimmar · {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; изучив ее, вы получите транспорт, а без него {zone:2548} после Тернистой долины – долгий путь пешком. Сядьте на дирижабль у башни ({object:3202}) до места {zone:1454}: {npc:4752} обучает орков здесь: {object:172958}, у псарни ({npc:3362}; волки по 20 золотых). Затем дирижаблем обратно сюда: {object:3202}. Не хватает золота? Пропустите этот шаг: гайд по зоне {zone:1444} снова проходит через {zone:1454} примерно на 45-м.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, учитель верховой езды",

	-- Step 34: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:367} Sen'jin Village · {npc:7953} Xar'Ti · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; изучив ее, вы получите транспорт, а без него {zone:2548} после Тернистой долины – долгий путь пешком. Сядьте на дирижабль у башни ({object:3202}) до места {zone:1454} и идите на юг по дороге через {zone:1411} к месту {area:367}: {npc:7953} обучает там троллей, ящеры у Зьолнира (по 20 золотых). Затем обратно к дирижаблю до места {object:3202}. Не хватает золота? Пропустите этот шаг: гайд по зоне {zone:1444} снова проходит через {zone:1454} примерно на 45-м.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, учитель верховой езды",

	-- Step 35: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; изучив ее, вы получите транспорт, а без него {zone:2548} после Тернистой долины – долгий путь пешком. Сядьте на дирижабль у башни ({object:3202}) до места {zone:1454}, летите сюда: {zone:1456} и спуститесь к месту {area:222}: {npc:3690} обучает там тауренов, кодо у NPC {npc:3685} (по 20 золотых). Затем летите обратно сюда: {zone:1454}, к дирижаблю до места {object:3202}. Не хватает золота? Пропустите этот шаг: гайд по зоне {zone:1444} снова проходит через {zone:1456} примерно на 45-м.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, учитель верховой езды",

	-- Step 36: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; изучив ее, вы получите ветроступа, а без него {zone:2548} после Тернистой долины – долгий путь пешком. Сядьте на дирижабль у башни ({object:3202}) до места {zone:1454} и летите сюда: {zone:1456}. Небесный корабль до места {zone:2521} отходит от утесов к югу от места {area:17045}, к северу от места {zone:1456}, примерно каждые пять минут; {npc:265756} обучает небожителей здесь: {area:17684}, {area:16638}. Затем обратно сюда: {zone:1454}, к дирижаблю до места {object:3202}. Не хватает золота? Пропустите этот шаг: гайд по зоне {zone:1444} снова проходит через {zone:1454} примерно на 45-м.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756}, riding trainer, at the {area:17684} in {area:16638}"] = "{npc:265756}, учитель верховой езды: {area:17684}, {area:16638}",

	-- Step 37: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {area:1497} Undercity · {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1435} Swamp of Sorrows
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {area:1497}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1435} guide passes the {area:1497} again at about 47."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; изучив ее, вы получите транспорт, а без него {zone:2548} после Тернистой долины – долгий путь пешком. Сядьте на дирижабль у башни ({object:3202}) до башен у места {area:1497}: {npc:4773} обучает Отрекшихся ({area:159}), недалеко к северу, рядом кони-скелеты NPC {npc:4731} (по 20 золотых). Затем дирижаблем обратно до места {object:3202}. Не хватает золота? Пропустите этот шаг: гайд по зоне {zone:1435} снова проходит здесь ({area:1497}) примерно на 47-м.",

	-- Step 38: Your mount at 40
	["Your mount at 40"] = "Ваш транспорт на 40-м",
	-- {zone:1454} Orgrimmar · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Warlocks don't buy riding: your mount is the Felsteed, from your class quest. Zevrost in {zone:1454}'s {object:172960} starts it and {npc:6251} in {area:392} teaches it, both on the {zone:1444} guide's {zone:1454} stop at about 45."] = "Чернокнижники не покупают верховую езду: ваш транспорт – конь Скверны из классового задания. Его начинает Зеврост ({zone:1454}, {object:172960}), а {npc:6251} ({area:392}) обучает ему; оба – на остановке в краю {zone:1454} в гайде по краю {zone:1444}, примерно на 45-м.",
	-- {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Felsteed: Zevrost in {zone:1454}, then {npc:6251} in {area:392}, on the {zone:1444} guide's {zone:1454} stop."] = "Конь Скверны: Зеврост ({zone:1454}), затем {npc:6251} ({area:392}), на остановке в краю {zone:1454} в гайде по краю {zone:1444}.",

	-- Step 39: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}: к западу от места {object:3202} плывите над местом {area:104} и нырните к входу в пещеру в рифе; задание выполнится, как только вы его найдете. Пока не заходите в пещеру: ящеры-ловчие – к югу вдоль побережья.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "вход ({area:16550}), под водой",

	-- Step 40: Jungle stalkers
	["Jungle stalkers"] = "Ящеры-ловчие",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast.\nCareful: the Jungle Stalkers (40-41) are thick here: pull one at a time and rest between fights."] = "Ящеры-ловчие охотятся в джунглях к югу от места {object:3202}, ближе к западному побережью.\nОсторожно: тропических ловцов (40-41) здесь много – тяните по одному и отдыхайте между боями.",
	["The naga explorers on the coast south of here (43-44) are for Bloads and Mok'thardin: keep both quests for your Stranglethorn stop at about 45."] = "Наги-исследователи на побережье к югу отсюда (43-44) нужны для Блоадса и Мок'тардина: сохраните оба задания до остановки в Тернистой долине примерно на 45-м.",

	-- Step 41: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Идите на юг сюда: {area:35}. Филипп «Трусишка» ждет на пристани.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "",
	-- {npc:2486} Fin Fizracket · {quest:348} Stranglethorn Fever · {zone:1444} Feralas · {object:3202} Grom'gol
	["{npc:2486}: {quest:348} (offered from 40), Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}: {quest:348} (доступно с 40-го), часть Унбагвы – на остановке в месте {object:3202} в гайде по краю {zone:1444}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "",
	["MacKinley: keep it, the ghost pirates (43-44) wait for your Stranglethorn stop at about 45"] = "Маккинли: сохраните задание, призрачные пираты (43-44) ждут вашей остановки в Тернистой долине примерно на 45-м",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, внутри: {item:4105}",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["{npc:2493}: keep it for the {area:43} at about 45"] = "{npc:2493}: сохраните для места {area:43}, примерно на 45-м",
	-- {npc:2487} Fleet Master Seahorn · {area:43} Wild Shore
	["{npc:2487}: keep it for the {area:43} at about 45"] = "{npc:2487}: сохраните для места {area:43}, примерно на 45-м",
	-- {npc:2488} Deeg · {area:43} Wild Shore
	["{npc:2488}, on the top floor: keep it for the {area:43} at about 45"] = "{npc:2488}, на верхнем этаже: сохраните для места {area:43}, примерно на 45-м",

	-- Step 42: The Bloodsail ships
	["The Bloodsail ships"] = "Корабли Кровавого Паруса",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["The scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs, with captains of 45-48: take it with a group. Its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Свиток «{quest:624}» лежит на палубах трех кораблей у места {area:43}; там пираты 42-45 уровня, которые ходят парами, и капитаны 45-48: идите группой. Цепочка продолжается через края {zone:1435}, {zone:1445} и {zone:1425}.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "для более поздней остановки ({zone:1435})",

	-- Step 43: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly back to {object:3202}: Zul'Mamwe's Skullsplitters are just east of it."] = "Летите обратно в {object:3202}: Череполомы Зул'Мамве – сразу к востоку.",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Распорядитель полетов: {area:35}",

	-- Step 44: Zul'Mamwe
	["Zul'Mamwe"] = "Зул'Мамбве",
	-- {object:3202} Grom'gol · {npc:1059} Ana'thek the Cruel · {npc:1061} Gan'zulah
	["From {object:3202} head east to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. One pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all. Careful: {npc:1059} (45) walks the south-western ruins with two guards; Speaking with {npc:1061}'s last piece, his Broken Armor, waits for your Stranglethorn stop at about 45."] = "Из места {object:3202} идите на восток к руинам Череполомов восточнее рудника Торговой компании; тяните охотников за головами и берсерков по одному. Одна груда трофейных черепов – у северной стороны руин. С любого Череполома могут упасть клык или ожерелье: ожерелья падают медленно, так что убивайте в лагере воинов к северу от руин, пока не соберете все. Осторожно: {npc:1059} (45) ходит по юго-западным руинам с двумя стражами; последняя часть задания «Разговор с NPC {npc:1061}», его Сломанные доспехи, ждет вашей остановки в Тернистой долине примерно на 45-м.",
	["Skullsplitter warriors"] = "Воины из племени Дробителей Черепов",

	-- Step 45: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "{area:127}: убивайте их по пути",
	-- {object:3202} Grom'gol
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Следующие трофейные черепа – в небольших руинах чуть к северу от лагеря воинов.\nПоследние черепа – в руинах недалеко к западу, по пути обратно сюда: {object:3202}.",

	-- Step 46: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Head west to {object:3202}."] = "Идите на запад сюда: {object:3202}.",
	-- {npc:2464} Commander Aggro'gosh · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {zone:2548} Riverglades
	["{npc:2464}: for {npc:256418} in {area:16743}, the {zone:2548}' Horde fort, in the next guide"] = "{npc:2464}: для NPC {npc:256418} ({area:16743}, крепость Орды в краю {zone:2548}), в следующем гайде",
	-- {quest:571} Mok'thardin's Enchantment · {quest:621} Zanzil's Secret · {npc:737} Kebok · {area:35} Booty Bay · {zone:2548} Riverglades
	["Keep {quest:571}, {quest:621} and {npc:737}'s tusks: the Skullsplitter chief, Zanzil's camps, the naga coast and {area:35} come on your Stranglethorn stop at about 45, after the {zone:2548}."] = "Сохраните задания «{quest:571}», «{quest:621}» и клыки для NPC {npc:737}: вождь Череполомов, лагеря Занзила, побережье наг и {area:35} – на остановке в Тернистой долине примерно на 45-м, после края {zone:2548}.",

	-- Step 48: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Идите на север по дороге к лагерю охотников.",

	-- Step 50: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone."] = "Это элитные противники: лучше собрать группу, поищите напарников. {npc:730} – элита 43-го уровня: большинство классов справляются в одиночку на 45-м, но может понадобиться помощь. Если вы один, пропустите.",

	-- Step 51: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone."] = "Это элитные противники: лучше собрать группу, поищите напарников. {npc:728} – элита 40-го уровня: большинство классов справляются в одиночку на 42-м, но может понадобиться помощь. Если вы один, пропустите.",

	-- Step 55: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "Это элитные противники: лучше собрать группу, поищите напарников. {npc:731} – элита 43-го уровня: большинство классов справляются в одиночку на 45-м, но может понадобиться помощь. Если вы один, пропустите.\nОсторожно: рядом бродят тигры и незаметные пантеры Тенегрызов. Зачистите их, прежде чем тянуть его. Когда его атакуют, {npc:731} зовет на помощь существ в радиусе 20 м.",

	-- Step 60: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "В край {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Идите по дороге на восток из края {zone:1431} через край {zone:1430} в болото. {npc:1776} ждет здесь: {area:657} – лагерь дренеев у дороги, там, где она входит со стороны края {zone:1430}.",

	-- Step 61: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "Идите на восток сюда: {area:75}, в камышах к югу от дороги.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, внутри",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}, наверху",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 62: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Острозубые кроколиски",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Кроколиски лежат в лужах вокруг лагеря {npc:5391} и к югу, к месту {area:75}; бок падает примерно с каждого четвертого.",

	-- Step 63: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Нобору бродит по поляне к юго-западу от места {area:76}; его дубина начинает задание.",

	-- Step 64: Draenethyst crystals
	["Draenethyst crystals"] = "Кристаллы дренетиста",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Head north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Идите на северо-восток сюда: {area:76}. Кристаллы стоят по пути к клетке ({npc:5391}).",

	-- Step 65: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} в плену здесь: {area:76}, на северо-востоке болота. Освободите его и следуйте за ним, отбиваясь от болотных тварей.",

	-- Step 66: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "Его сундук – в его старом лагере к северу от места {area:75}, по пути обратно на запад.",

	-- Step 67: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Идите на запад по дороге к лагерю дренеев ({area:657}), у входа со стороны края {zone:1430}. Задание «{quest:698}» сдается NPC {npc:5592} ({area:1978}) при следующем визите на болото: сохраните бока.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Below ground"] = "Под землей",
	-- ["Boat to {area:35}"] = "Корабль: {area:35}",
	-- ["Fly to {area:392}"] = "Летите сюда: {area:392}",
	-- ["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Идите вдоль берега на юг. Наги-исследователи бродят по берегу и носят связки тростника; {object:759} бурлит в холмах чуть к востоку.",
	-- ["From {area:2408} fly to {area:392}."] = "Из места {area:2408} летите сюда: {area:392}.",
	-- ["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Отдайте Унбагве клыки и оставайтесь рядом: он призовет три волны горилл, затем {npc:1514}. Бейтесь с ними по одному.",
	-- ["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Идите на север к руинам племени Дробителей Черепов к востоку от рудника Торговой компании; выманивайте охотников за головами и берсерков по одному. {npc:1059} охраняет юго-западные руины, а одна груда трофейных черепов стоит в северной части руин. С любого тролля Дробителей Черепов может упасть клык или ожерелье: ожерелья падают медленнее, поэтому бейте воинов в лагере к северу от руин, пока не соберете все.",
	-- ["Hearth to {area:35}"] = "Камень возвращения: {area:35}",
	-- ["Hearth to {object:3202}"] = "Камень возвращения: {object:3202}",
	-- ["Into the {area:8}"] = "В край {area:8}",
	-- ["Ironjaw Basilisks"] = "Железозубые василиски",
	-- ["Naga shore and the {object:759}"] = "Берег наг и {object:759}",
	-- ["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "К северо-востоку от Мглистой долины в джунглях стоят лагерем последователи Занзила; смесь может быть у любого из них.",
	-- ["Pirate ghosts"] = "Призраки пиратов",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Возвращайтесь на восток мимо места {area:75} и следуйте по дороге на юго-восток к небольшому лагерю Орды на берегу.",
	-- ["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Езжайте на северо-восток сюда: {area:76}. Кристаллы стоят по пути к клетке ({npc:5391}).",
	-- ["Ride on north to {object:3202}."] = "Езжайте дальше на север сюда: {object:3202}.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Езжайте на запад по дороге к лагерю дренеев ({area:657}), у въезда со стороны края {zone:1430}. {quest:698} отправляется к NPC {npc:5592} ({area:1978}) при следующем визите на болото: сохраните бока.",
	-- ["Sawtooth snappers"] = "Острозубые крепкохваты",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "К югу от Пиратской бухты висельники из шайки Кровавого Паруса стоят лагерем здесь: {area:43}; карты и приказы лежат в их палатках и в шлюпке рядом с большим лагерем. Нюхательный табак и глаз {npc:2493} может нести любой пират Кровавого Паруса: убивайте, пока не получите оба.",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Езжайте по дороге на север от места {area:35}; Унбагва сидит на холме ({area:1737}), к востоку от дороги.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Тропические ловцы (40-41) охотятся на побережье к югу от места {object:3202}. Они намного выше вас: выманивайте по одному и отдыхайте между боями.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Корабль ({area:35}) причаливает в конце пирса ({area:392}).",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Гориллы бродят по долине вокруг Унбагвы. Потроха падают со старых горилл; клык может упасть с любой.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Последние черепа – в руинах недалеко к западу, по пути обратно сюда: {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "Следующее руководство начинается здесь и ведет в край {zone:1446}.",
	-- ["The snappers line the strand south of the post."] = "Крепкохваты сидят на берегу к югу от лагеря.",
	-- ["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Ящеры-ловчие охотятся в джунглях к югу от места {object:3202}, ближе к западному побережью.",
	-- ["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Три призрачных пирата бродят в джунглях к северу от места {area:35}, у лагерей Занзила: {npc:2535} и {npc:2536} стоят вместе, {npc:2537} – дальше к востоку.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Три корабля стоят у берега ({area:43}). Команды 42-45, капитан Штиллец 45, капитан Кильватель 46, {npc:2546} 48: на 41-м уровне это бой для группы или для конца руководства. Если идете, плывите к ним и выманивайте команду к борту по одному. На палубе лежит свиток ({quest:624}): возьмите его.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "К западу от экспедиции вожди племени Кровавого Скальпа – {npc:1061} и {npc:1062} – стоят вместе в руинах Зул'Кунды. Сначала перебейте охрану, затем выманите их.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "К западу от экспедиции вожди племени Кровавого Скальпа – {npc:1061} и {npc:1062} – стоят вместе в руинах Зул'Кунды. Сначала перебейте охрану, затем выманите их. Бейте троллей Кровавого Скальпа здесь до 41-го уровня: задание {quest:586}, следующее у котла, отправит вас к Дробителям Черепов 41-43 уровня.\nНа побережье между Зул'Кундой и местом {object:3202} {npc:2635} (элитный, 38-й уровень) появляется на месте обычных кроколисков: если он на месте, убейте его и снимите шкуру для {npc:2495}.",
	-- ["Zanzil's camps"] = "Лагеря Занзила",
	-- ["for Stoley in {zone:1446}"] = "для Столи ({zone:1446})",
	-- ["for a later stop in the {area:8}"] = "для более поздней остановки ({area:8})",
	-- ["the {object:2076}"] = "{object:2076}",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}, рядом: {npc:2497}",
	-- ["{area:392} pier"] = "Пирс: {area:392}",
	-- ["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "{npc:2496}, на балконе рядом с Мак-Кинли, дает еще одно поручение: чертежи регулятора топлива из сундучка Козла нужно отнести Поззику ({area:2240}), по пути в {zone:1446} примерно на 43-м уровне.",
	-- ["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, наверху: для задания {quest:2864} ({area:976})",
	-- ["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "{zone:1434} и {zone:1435} на 40-43-м уровне: {object:3202}, пираты ({area:35}), охота Эрнестуэя и {area:75}.",
}
