-- Russian (ruRU): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tirisfal Glades
	["The zeppelin towers"] = "",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 4: Zeppelin to Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Из города {zone:1458} летите на дирижабле от башни у города в {zone:1454}.",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "",

	-- Step 6: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "",

	-- Step 7: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "Место: {area:2479}",

	-- Step 8: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Летите в {area:431} и езжайте на северо-запад по дороге из зоны {zone:1440} в {zone:1448}. {area:2479} — лагерь друидов сразу за границей.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Заданию {npc:9116} «Серебряное сердце» нужен {item:11173} с севера зоны {zone:1448} и поездка обратно сюда. Пропустите.",

	-- Step 9: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "",
	["Below ground"] = "",

	-- Step 10: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "Обратно на юг к Святилищу, недалеко.",

	-- Step 11: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Езжайте на север по дороге мимо места {area:1763} в {area:1997}.",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "Следующее задание {npc:10306} «{quest:4741}» вернуло бы вас сюда из зоны {zone:1452}. Пропустите.",

	-- Step 12: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",

	-- Step 13: Greta Mosshoof
	["South to the Sanctuary once more."] = "Еще раз на юг к Святилищу.",

	-- Step 14: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet."] = "",

	-- Step 16: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Через туннель Древобрюхов в {zone:1450}. {npc:11939} читает в доме здесь: {area:2361}.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "",

	-- Step 18: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 19: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Заданию {npc:11801} «Осколки сквернита» нужно подземелье {area:2577}. Пропустите.",

	-- Step 22: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Обратно в туннель Древобрюхов, выход: {zone:1452}; {npc:9298} стоит лагерем у горячих источников сразу снаружи.",
	["From Krakle in Un'Goro"] = "От Кракла из Ун'Горо",

	-- Step 23: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 25: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Бусы может нести любой фурболг Зимней Спячки; ближайшие лагеря – чуть к югу от персонажа {npc:11556}.",
	["Frostfire Winterfall camp"] = "Лагерь Зимней Спячки у источников",

	-- Step 27: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "",

	-- Step 28: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only at Neutral with the Timbermaw: {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 30: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Езжайте на восток, затем на юг через место {area:2249}. Великаны ледяного молота там – элита 59-го уровня: держитесь середины и не останавливайтесь. Странный источник – у входа сюда: {area:2256}, в южном конце.",

	-- Step 31: Level 59.9
	["Level 59.9"] = "",
	-- {zone:1452} Winterspring · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "",

	-- Step 32: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "Возвращайтесь на запад сюда: {area:2246}.",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "Затем {npc:9298} отправляет вас за NPC {npc:10738}, элитой в его пещере. Пропустите.",

	-- Step 33: Are We There, Yeti?
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "",

	-- Step 34: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Езжайте на восток по дороге в {area:2255}.",

	-- Step 35: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "Подземелье вместо гринда",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Необязательно. Прохождение подземелий {area:2279}, {area:2057}, нижняя часть пика Черной горы или {area:1584} в группе вместо гринда быстрее.",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Необязательно: с группой подземелье 55-60 заменяет гринд ниже.",

	-- Step 36: Grind to 60
	["Grind to 60"] = "Гринд до 60",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Задания здесь заканчиваются. Бешеные щербозубы рыщут здесь: {area:2249}, юг зоны {zone:1452}, к югу от дороги из места {area:2255}.",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "гринд: {npc:7446}, {area:2249}, {zone:1452}",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "В городе {zone:1454}: летите из места {area:2255}",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "В городе {zone:1456}: летите из места {area:2255}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "Обратно в туннель Древобрюхов, выход: {area:618}; {npc:9298} стоит лагерем у горячих источников сразу снаружи.",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "Летите в {area:431} и езжайте на северо-запад по дороге из зоны {zone:1440} в {area:361}. {area:2479} — лагерь друидов сразу за границей.",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Из города {zone:1458} летите на дирижабле от башни у города в {zone:1454}.",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Только если у вас есть задание «{quest:5087}»: гонцы небольшими группами идут по дороге от места {area:1769} к месту {area:2244}; ждите у дороги рядом с {npc:9298} и убивайте их, когда они проходят. У каждого есть ящик.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Только если {npc:9298} дала вам задание «{quest:5086}»: езжайте на север по дороге зоны {area:361} в {area:1767}; цели ({quest:5086}) ползают между деревьями.",
	-- ["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "Только с 30 шт. «{quest:6031}» и только при нейтральной репутации у Древобрюхов: идите по дороге на север в {area:1769}; {npc:11557} торгует сразу за входом.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "Езжайте на северо-запад в {area:1763}. Четыре жаровни стоят среди построек Совета Теней; используйте очищенную воду на каждой.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "Задания здесь заканчиваются. Бешеные щербозубы рыщут здесь: {area:2249}, юг зоны {area:618}, к югу от дороги из места {area:2255}.",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "Через туннель Древобрюхов в {area:493}. {npc:11939} читает в доме здесь: {area:2361}.",
	-- ["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "гринд: {npc:7446}, {area:2249}, {area:618}",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "Следующее задание {npc:10306} «{quest:4741}» вернуло бы вас сюда из зоны {area:618}. Пропустите.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "Заданию {npc:9116} «Серебряное сердце» нужен {item:11173} с севера зоны {area:361} и поездка обратно сюда. Пропустите.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}, {npc:9860} и {npc:9517} ждут в глубине пещеры {area:1770} на севере места {area:1763}. Зачищайте туннель по пути.",
}
