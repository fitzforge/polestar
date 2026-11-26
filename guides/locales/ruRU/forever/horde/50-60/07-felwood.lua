-- Russian (ruRU): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 2: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}."] = "Ориентир: {object:172961}.",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "",

	-- Step 4: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "Летите сюда: {area:431}",

	-- Step 5: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "Место: {area:2479}",

	-- Step 6: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "Летите в {area:431} и езжайте на северо-запад по дороге из зоны {zone:1440} в {zone:1448}. {area:2479} — лагерь друидов сразу за границей.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, внутри",
	-- {quest:4084} Silver Heart · {item:11172} Silvery Claws · {item:11173} Irontree Heart · {area:1767} Irontree Woods · {npc:9116} Eridan Bluewind
	["{quest:4084}'s {item:11172} and {item:11173} come from {area:1767} on this guide's ride north; {npc:9116} takes them at the end of the guide, back here."] = "",

	-- Step 7: Rakaiah
	-- {npc:11019} Jessir Moonbow · {npc:9518} Rakaiah · {item:13140} Blood Red Key · {area:1763} Jaedenar · {area:1770} Shadow Hold
	["Only if {npc:11019} sent you after {npc:9518} (the {item:13140}'s chain): on the ride north, turn west into {area:1763} and go into {area:1770}, the cave at the back of the camp. {npc:9518} (56) and the remains of Trey Lightforge are inside: kill her first, then the remains take her quest and give the next, which goes back to {npc:11019} at the end of this guide."] = "",

	-- Step 9: Trull Failbane
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "Езжайте на север по дороге мимо места {area:1763} в {area:1997}.",

	-- Step 10: Bloodvenom Post
	-- {npc:10306} Trull Failbane · {quest:4721} Wild Guardians · {area:2255} Everlook · {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{npc:10306}'s last {quest:4721} are the Berserk Owlbeasts north of {area:2255}, on this guide's {zone:1452} loop; he takes them at the end of the guide, back here."] = "",

	-- Step 11: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors · {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {item:11172} Silvery Claws · {npc:14524} Vartrus the Ancient
	-- plural, as words: Irontree Wanderers = {npc:7138} Irontree Wanderer · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet. The Irontree Wanderers and Stompers (52-53) there carry {npc:9116}'s {item:11173}, the Angerclaw bears and Felpaw wolves his {item:11172}.\nCareful: Ancient Irontree Walkers, level 59 elites, walk among the {quest:5086}, and {npc:14524} (63, elite) roams the woods: work the Horrors at the north tip of {area:1767}, one at a time."] = "",

	-- Step 13: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "Через туннель Древобрюхов в {zone:1450}. {npc:11939} читает в доме здесь: {area:2361}.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} ходит по месту {area:2361}: ищите внутри круга на карте",

	-- Step 15: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 16: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "Заданию {npc:11801} «Осколки сквернита» нужно подземелье {area:2577}. Пропустите.",

	-- Step 19: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "Обратно в туннель Древобрюхов, выход: {zone:1452}; {npc:9298} стоит лагерем у горячих источников сразу снаружи.",
	["From Krakle in Un'Goro, if you didn't bring it to her earlier"] = "",

	-- Step 20: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 21: Salfa
	-- {quest:8464} Winterfall Activity · {area:2255} Everlook · {area:2256} Darkwhisper Gorge
	["{quest:8464}'s village is north-east of {area:2255}, on this guide's way back from {area:2256}."] = "Деревня для задания {quest:8464} – к северо-востоку от места {area:2255}, по пути этого гайда обратно от места {area:2256}.",

	-- Step 22: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "С 30 шт. «{quest:6031}» в сумках: идите по дороге на север в {area:1769}; {npc:11557} торгует сразу за входом.",
	["Below ground"] = "Под землей",

	-- Step 23: Kernda
	-- {area:1762} Felpaw Village · {area:1769} Timbermaw Hold · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if you are Neutral with the Timbermaw now (the {area:1769} reputation guide gets you there): {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- Step 24: Witch Doctor Mau'ari
	-- {area:2255} Everlook · {npc:11755} Harlo Wigglesworth · {npc:10307} Witch Doctor Mau'ari · {area:2249} Frostwhisper Gorge
	["Ride east along the road to {area:2255}: {npc:11755} sends you to {npc:10307}, who stands in the town, on the way to {area:2249}."] = "",

	-- Step 26: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	-- was: ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Езжайте на восток, затем на юг через место {area:2249}. Великаны ледяного молота там – элита 59-го уровня: держитесь середины и не останавливайтесь. Странный источник – у входа сюда: {area:2256}, в южном конце."
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59-60: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "",

	-- Step 27: Frostmaul Shards
	-- {area:2249} Frostwhisper Gorge · {npc:10198} Kashoch the Reaver
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["The shards lie on the ground along the west side of {area:2249}, among the Frostmaul Giants and Preservers. Careful: the giants are elites of 59-60: pick up the shards that lie clear of them, wait for a patrol to pass, and leave {npc:10198} (60, east side) alone."] = "",

	-- Step 28: Level 59.7
	["Level 59.7"] = "",
	-- {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {npc:11556} Salfa · {npc:10306} Trull Failbane · {npc:9116} Eridan Bluewind · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to about level 59.7 before the last hand-ins: Umi, Vizzie, Mau'ari, {area:2244}, {npc:9298}, {npc:11556}, {npc:10306} and {npc:9116} take you the rest of the way to 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "убивайте: {npc:7446}",

	-- Step 29: Ice Thistle yetis
	["Ice Thistle yetis"] = "Йети ледополохов",
	-- {area:2255} Everlook · {item:258323} Missing Mail
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["On the ride north to {area:2255}, the Ice Thistle Yetis (55-56) in the hills south-east of the town carry Vizzie's {item:258323}: four pieces."] = "",

	-- Step 30: Are We There, Yeti?
	-- {area:2255} Everlook
	["Ride north to {area:2255}."] = "Езжайте на север сюда: {area:2255}.",
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "",

	-- Step 31: Everlook
	-- {npc:11118} Innkeeper Vizzie · {quest:93406} Unfrozen Deliveries
	["{npc:11118}, in the inn: {quest:93406}"] = "",

	-- Step 33: Winterfall Village
	-- {area:2255} Everlook · {quest:5121} High Chief Winterfall
	-- was: ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "Деревня фурболгов занимает долину к северо-востоку от места {area:2255}. Сначала убивайте шаманов – они лечат. {npc:10738} (59, элитный) и Ксандивиус (62) в пещере в глубине: туда не ходите."
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {quest:5121} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "",

	-- Step 34: Berserk Owlbeasts
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Berserk Owlbeasts"] = "",
	-- {area:2241} Frostsaber Rock · {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["The Berserk Owlbeasts (58-59) roam the slopes of {area:2241}, north of {area:2255} and west of the furbolg valley. Now and then an owlbeast drops a {item:12558}: use it to start {quest:4882}."] = "",

	-- Step 35: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west along the road to {area:2246}."] = "Возвращайтесь на запад по дороге сюда: {area:2246}.",

	-- Step 36: High Chief Winterfall
	-- {npc:9298} Donova Snowden · {quest:5121} High Chief Winterfall · {area:2244} Winterfall Village · {area:2255} Everlook · {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["A group choice: {npc:9298} sends you after {quest:5121} (59, elite, with his guards) in the cave at the back of {area:2244}, back east past {area:2255}; Xandivious (62) shares the cave: leave him. The High Chief carries a log for {npc:9298}, and her next errand goes to {npc:10920} at the {area:2479}, this guide's last stop."] = "",
	-- {quest:5121} High Chief Winterfall
	["{quest:5121}, in the cave"] = "",
	["the log he carries"] = "",
	-- {npc:9298} Donova Snowden
	["{npc:9298}, back west at the hot springs"] = "",
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["for {npc:10920} at the {area:2479}"] = "",

	-- Step 37: Salfa
	-- {zone:1452} Winterspring
	["North of Donova, at the tunnel's {zone:1452} exit."] = "К северу от Доновы, у выхода из туннеля в зону {zone:1452}.",

	-- Step 38: Beads for Salfa
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity
	["{npc:11556} takes the beads only once {quest:8464} is handed in: any Winterfall furbolg can carry them, and the camps just south of {npc:11556} are the closest."] = "{npc:11556} примет бусы только после сдачи задания «{quest:8464}»: их может нести любой фурболг Зимней Спячки, ближайшие лагеря – чуть к югу от персонажа {npc:11556}.",
	["Frostfire Winterfall camp"] = "Лагерь Зимней Спячки у источников",

	-- Step 40: Trull Failbane
	-- {zone:1448} Felwood · {area:1997} Bloodvenom Post
	["Back through the Timbermaw tunnel and south down the {zone:1448} road to {area:1997}."] = "",

	-- Step 41: Trull Failbane
	-- {quest:4882} Guarding Secrets · {item:12558} Blue-feathered Necklace
	["{quest:4882}, from the {item:12558}"] = "",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {zone:1456} Thunder Bluff
	["{quest:4882} goes on to {npc:5770} in {zone:1456}, off this route: leave it."] = "",

	-- Step 42: Jessir Moonbow
	-- {area:2479} Emerald Sanctuary · {npc:11019} Jessir Moonbow
	["South along the road to the {area:2479}: {npc:11019}, at its east side, takes Trey Lightforge's remains."] = "",

	-- Step 43: Kelek Skykeeper
	-- {npc:10920} Kelek Skykeeper · {area:2479} Emerald Sanctuary
	["{npc:10920}, at the {area:2479}, takes the High Chief's words."] = "",

	-- Step 44: Eridan Bluewind
	-- {area:2479} Emerald Sanctuary
	["South along the road to the {area:2479}."] = "",
	-- {npc:9116} Eridan Bluewind · {zone:1446} Tanaris
	["{npc:9116}'s Aquementas leads on to {zone:1446} and Un'Goro: leave it."] = "",
	-- {zone:1454} Orgrimmar · {area:431} Splintertree Post
	["In {zone:1454}: fly from {area:431}"] = "",
	-- {zone:1456} Thunder Bluff
	["In {zone:1456}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: the Jaedenar Enforcers, Darkweavers, Warlocks and Legionnaires of Shadow Hold carry one now and then. Use it to start the quest, then free {npc:11018} from her cage in the cave's south end on your way out."] = "Выпал предмет {item:13140}: его иногда носят джеденарские головорезы, ткачи тьмы, чернокнижники и легионеры Оплота Теней. Используйте его, чтобы начать задание, а на выходе освободите NPC {npc:11018} из клетки в южном конце пещеры.",
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "Бусы может нести любой фурболг Зимней Спячки; ближайшие лагеря – чуть к югу от персонажа {npc:11556}.",
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "Обратно в туннель Древобрюхов, выход: {area:618}; {npc:9298} стоит лагерем у горячих источников сразу снаружи.",
	-- ["Back south to the Sanctuary, a short ride."] = "Обратно на юг к Святилищу, недалеко.",
	-- ["Corrupted Soul Shards from the cultists, {quest:5887}"] = "Оскверненные осколки души с культистов, «{quest:5887}»",
	-- ["Dungeon instead of grinding"] = "Подземелье вместо гринда",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "Летите в {area:431} и езжайте на северо-запад по дороге из зоны {zone:1440} в {area:361}. {area:2479} — лагерь друидов сразу за границей.",
	-- ["From Krakle in Un'Goro"] = "От Кракла из Ун'Горо",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "Из города {zone:1458} летите на дирижабле от башни у города в {zone:1454}.",
	-- ["Grind to 60"] = "Гринд до 60",
	-- ["In {zone:1454}: fly from {area:2255}"] = "В городе {zone:1454}: летите из места {area:2255}",
	-- ["In {zone:1456}: fly from {area:2255}"] = "В городе {zone:1456}: летите из места {area:2255}",
	-- ["On the way back south to Greta, {npc:9529} takes the shards on the west side of the Sanctuary."] = "По пути обратно на юг к Грете отдайте осколки: {npc:9529} стоит на западной стороне Святилища.",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "Только если у вас есть задание «{quest:5087}»: гонцы небольшими группами идут по дороге от места {area:1769} к месту {area:2244}; ждите у дороги рядом с {npc:9298} и убивайте их, когда они проходят. У каждого есть ящик.",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "Только если {npc:9298} дала вам задание «{quest:5086}»: езжайте на север по дороге зоны {area:361} в {area:1767}; цели ({quest:5086}) ползают между деревьями.",
	-- ["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "Необязательно. Прохождение подземелий {area:2279}, {area:2057}, нижняя часть пика Черной горы или {area:1584} в группе вместо гринда быстрее.",
	-- ["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "Необязательно: с группой подземелье 55-60 заменяет гринд ниже.",
	-- ["Ride back west to {area:2246}."] = "Возвращайтесь на запад сюда: {area:2246}.",
	-- ["Ride east along the road to {area:2255}."] = "Езжайте на восток по дороге в {area:2255}.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "Езжайте на восток, затем на юг через место {area:2249}. Великаны ледяного молота там – элита 59-го уровня: держитесь середины и не останавливайтесь. Странный источник – у входа сюда: {area:2256}, в южном конце.",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "Езжайте на северо-запад в {area:1763}. Четыре жаровни стоят среди построек Совета Теней; используйте очищенную воду на каждой.\nОсторожно: пещеру заполняют противники Совета Теней 53-55-го уровня, часто большими связанными группами, многие с оглушением. Рекомендуется группа из 2-3 игроков.",
	-- ["South to the Sanctuary once more."] = "Еще раз на юг к Святилищу.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} (59, elite) and Xandivious (62) are in the cave at the back: stay out."] = "Деревня фурболгов занимает долину к северо-востоку от места {area:2255}. Сначала убивайте шаманов – они лечат. {npc:10738} (59, элитный) и Ксандивиус (62) в пещере в глубине: туда не ходите.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "Задания здесь заканчиваются. Бешеные щербозубы рыщут здесь: {area:2249}, юг зоны {area:618}, к югу от дороги из места {area:2255}.",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "Задания здесь заканчиваются. Бешеные щербозубы рыщут здесь: {area:2249}, юг зоны {zone:1452}, к югу от дороги из места {area:2255}.",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "Через туннель Древобрюхов в {area:493}. {npc:11939} читает в доме здесь: {area:2361}.",
	-- ["Trey Lightforge's remains lie at the edge of the {area:1763} camp, west of the road: they go back to {npc:11019} at the end of this guide."] = "Останки Трея Лайтфорджа лежат у края лагеря ({area:1763}) к западу от дороги: они возвращаются к NPC {npc:11019} в конце этого гайда.",
	-- ["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "гринд: {npc:7446}, {area:2249}, {area:618}",
	-- ["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "гринд: {npc:7446}, {area:2249}, {zone:1452}",
	-- ["only if still carried: the {zone:1423} guide hands it in on its way through"] = "только если задание еще у вас: гайд по зоне {zone:1423} сдает его по пути",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "Следующее задание {npc:10306} «{quest:4741}» вернуло бы вас сюда из зоны {area:618}. Пропустите.",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "Следующее задание {npc:10306} «{quest:4741}» вернуло бы вас сюда из зоны {zone:1452}. Пропустите.",
	-- ["{npc:11016}, below ground"] = "{npc:11016}, под землей",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "Заданию {npc:9116} «Серебряное сердце» нужен {item:11173} с севера зоны {area:361} и поездка обратно сюда. Пропустите.",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "Заданию {npc:9116} «Серебряное сердце» нужен {item:11173} с севера зоны {zone:1448} и поездка обратно сюда. Пропустите.",
	-- ["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "Затем {npc:9298} отправляет вас за NPC {npc:10738}, элитой в его пещере. Пропустите.",
	-- ["{npc:9529} stands on the west side of the Sanctuary, the way out to {area:1763}. With {quest:4102} done, her {quest:5887} asks for six Corrupted Soul Shards: the Shadow Council cultists in {area:1763} and {area:1770} drop them about one kill in three, and you fight dozens of them for {npc:10922}."] = "{npc:9529} стоит на западной стороне Святилища, у выхода к месту {area:1763}. После выполнения задания «{quest:4102}» ее задание «{quest:5887}» требует шесть оскверненных осколков души: культисты Совета Теней в местах {area:1763} и {area:1770} роняют их примерно с каждого третьего, а для {npc:10922} вам все равно придется убить их десятки.",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}, {npc:9860} и {npc:9517} ждут в глубине пещеры {area:1770} на севере места {area:1763}. Зачищайте туннель по пути.\nОсторожно: три босса сражаются вместе. Сначала перебейте противников рядом, чтобы не привлечь лишних.",
}
