-- Russian (ruRU): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "Езжайте на юго-восток к месту {area:355}, ступенчатому храму племени Порочной Ветви на юге края {zone:1425}, и поднимитесь на вершину. Квиага и {npc:8636} (элита, 50) стоят наверху: коснитесь вершины и сразу спускайтесь.\nОсторожно: верхнюю площадку охраняют элитные тролли, в том числе {npc:7996} и {npc:8636}, а также несколько прорицателей из племени Порочной Ветви. Прорицатели применяют заклинания и связаны с остальной группой.",

	-- Step 2: Vilebranch Soothsayers
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Vilebranch Soothsayers"] = "Ворожеи из племени Порочной Ветви",
	-- {area:355} Altar of Zul · {npc:7996} Qiaga the Keeper · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["The Vilebranch Soothsayers (46-47) walk the ground around the foot of the {area:355}: their totems are for Maret Firetend. Careful: {npc:7996} and {npc:8636} (50, elites) stand on the altar's south-east side: take the Soothsayers on its west side, away from them, and stay off the altar."] = "Ворожеи из племени Порочной Ветви (46-47) ходят у подножия места {area:355}: их тотемы нужны для Марет Огненной Хранительницы. Осторожно: {npc:7996} и {npc:8636} (50, элита) стоят на юго-восточной стороне алтаря: убивайте ворожеев на западной стороне, подальше от них, и не поднимайтесь на алтарь.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "Езжайте на север, в центр края {zone:1425}: {area:351}. Вокруг ползают зеленые слякочи и нефритовые слизнюки.\nОсторожно: по округе в незаметности бродят пантеры.",

	-- Step 4: Wildkin feathers
	["Wildkin feathers"] = "Перья диких совухов",
	-- {npc:7916} Erelas Ambersky · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {area:351} Skulk Rock
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["{npc:7916}'s Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam: pick them up as you ride between the altar and {area:351}."] = "Перья диких совухов для NPC {npc:7916} лежат на земле по всей зоне {zone:1425}, к югу и востоку от места {area:348}, где бродят совухи: подбирайте их, проезжая между алтарем и местом {area:351}.",

	-- Step 5: Lost Gryphon Eggs
	-- plural, as words: Lost Gryphon Eggs = {item:279229} Lost Gryphon Egg
	["Lost Gryphon Eggs"] = "Потерянные яйца грифона",
	-- {area:348} Aerie Peak
	["On the way back to {area:348}: the lost gryphon eggs lie in the hills just east of the aviary."] = "По пути обратно к месту {area:348}: потерянные яйца грифона лежат в холмах чуть восточнее гнездовья.",

	-- Step 6: Aerie Peak
	["Inside"] = "Внутри",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "для NPC {quest:2990} ({area:1438}), позже",
	-- {npc:270263} Farseer Maret Firetend
	["{npc:270263}, just east of the aviary"] = "{npc:270263}, чуть восточнее гнездовья",

	-- Step 7: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Летите сюда: {area:1537}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 8: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 9: Ironforge inn
	-- {area:1537} Ironforge
	["{area:1537} inn"] = "Таверна: {area:1537}",
	-- {object:26486} Stonefire Tavern · {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth at the {object:26486}: the {zone:1427} guide starts with the hearth back here and the gryphon to {area:144}."] = "",

	-- Step 10: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Поезд до {zone:1453}",

	-- Step 12: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Летите сюда: {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Распорядитель полетов: {zone:1453}",

	-- Step 15: The bloodmages
	["The bloodmages"] = "Маги крови",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "",
	-- {npc:7505} Bloodmage Drazial · {zone:1419} Blasted Lands
	["{npc:7505}: keep the five, their beasts (48-53) wait for the level-52 {zone:1419} stop"] = "{npc:7505}: оставьте все пять заданий, их звери (48-53) подождут остановки в зоне {zone:1419} на 52-м уровне",

	-- Step 16: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}."] = "Сначала езжайте дальше на восток по дороге к крепости: {item:6091} пропадет через час после места {area:42}.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, на вершине крепости",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "Следующее поручение {npc:8022}, {item:9471}, — задание для подземелья {area:978}: пропустите.",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "",

	-- Step 17: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Летите сюда: {area:35}",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "",

	-- Step 18: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	["\"Sea Wolf\" MacKinley, if the Stranglethorn guide didn't give it"] = "«Морской Волк» Маккинли, если гайд по Тернистой долине его не выдал",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor, if the Stranglethorn guide didn't give it"] = "{npc:2487}, верхний этаж, если гайд по Тернистой долине его не выдал",
	-- {npc:2494} Privateer Bloads
	["{npc:2494}, if the Stranglethorn guide didn't give it"] = "{npc:2494}, если гайд по Тернистой долине его не выдал",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, if the Stranglethorn guide didn't give it"] = "{npc:2498}, внутри, если гайд по Тернистой долине его не выдал",

	-- Step 19: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "",
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["The charts and orders lie in the pirate camp on the {area:43}, just south of {area:35}; its Swashbucklers walk the shore. The Warlocks and Swashbucklers (41-43) are under you now."] = "Карты и приказы лежат в пиратском лагере на месте {area:43}, чуть южнее места {area:35}; его головорезы ходят по берегу. Чернокнижники и головорезы (41-43) теперь ниже вас по уровню.",

	-- Step 20: Booty Bay
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487} – верхний этаж",

	-- Step 21: The Bloodsail captains
	["The Bloodsail captains"] = "Капитаны шайки Кровавого Паруса",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "",

	-- Step 23: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Наги-исследователи",
	["Leave town by the tunnel and ride north along the coast past the Bloodsail camp: the naga comb the beaches beyond it and drop the reeds."] = "Выйдите из города через туннель и езжайте на север вдоль побережья мимо лагеря Кровавого Паруса: дальше по пляжам бродят наги, с них падают тростники.",

	-- Step 24: Zanzil's village
	["Zanzil's village"] = "Деревня Занзила",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Ride on north along the coast to Zanzil's village. Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Езжайте дальше на север вдоль побережья к деревне Занзила. Мешанина может выпасть с любого последователя Занзила; {npc:2537} ходит в южной части лагеря.",

	-- Step 25: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} и {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536} stand together in the hills just north of Zanzil's village."] = "{npc:2535} и {npc:2536} стоят вместе в холмах чуть севернее деревни Занзила.",

	-- Step 26: Gorilla hills
	["Gorilla hills"] = "Холмы горилл",
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Gorilla Fangs = {item:2799} Gorilla Fang · Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride back south-east to the Mistvale gorilla hills above {area:35}. {npc:1449} sits among the gorillas: take ten Gorilla Fangs from the Elder Mistvale Gorillas first."] = "Езжайте обратно на юго-восток к холмам горилл из Мглистой долины над местом {area:35}. {npc:1449} сидит среди горилл: сначала добудьте десять клыков гориллы со старых горилл из Мглистой долины.",

	-- Step 27: Unbagwa's ritual
	["Unbagwa's ritual"] = "Ритуал Унбагвы",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "Сдайте клыки и оставайтесь на месте: придут три волны горилл, последним – {npc:1514}.\nОсторожно: три волны горилл идут одна за другой почти без передышки, затем {npc:1514}. Начинайте с полным здоровьем и маной и держитесь рядом с Унбагвой. Некоторым классам трудно в одиночку: с другом будет легко.",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "",

	-- Step 29: Booty Bay
	["Ride back down to town."] = "Езжайте обратно вниз, в город.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it, the Un'Goro guide lands there"] = "для NPC {npc:2616} в Тераморе: сохраните, гайд по Ун'Горо начинается там",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "Следующее поручение {npc:2498} про Занзила начинается в зоне {zone:1441}: пропустите его.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	["MacKinley's next task sends you after elite ogres: skip it."] = "Следующее задание Маккинли отправляет вас к элитным ограм: пропустите его.",

	-- Step 30: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 34: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Пеплогривые кабаны и краснокаменные василиски обитают на склонах к юго-западу от крепости. Держитесь подальше от зловепрей южнее: у них 52-й уровень.",
	-- ["Back to {area:144}"] = "Вернитесь: {area:144}",
	-- ["Boars and basilisks"] = "Кабаны и василиски",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Летите из места {area:144} в {area:150}, плывите на корабле в {area:442} и летите в {area:702}.",
	-- ["Fly from {area:348} to {area:42}."] = "Летите из места {area:348} в {area:42}.",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Используйте Камень возвращения: {area:144}. Гайд по зоне {zone:1427} начинается здесь: {area:1446}. Отсюда езжайте на юг в {zone:1418}, на запад мимо ордынского городка {area:340} и вверх по тропе в ущелье.",
	-- ["Hearth to {area:348}."] = "Используйте Камень возвращения: {area:348}.",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "Камень возвращения на перезарядке? Езжайте обратно на северо-запад.",
	-- ["Portal to {zone:1438}"] = "Портал: {zone:1438}",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "Езжайте обратно на восток в {area:1438} и летите в {area:144}.",
	-- ["Ride back north to Ironband's camp."] = "Езжайте обратно на север к Раскопкам Сталекрута.",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "Езжайте на восток вдоль южного берега озера к лагерю: Раскопки Сталекрута.",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Езжайте на восток через {zone:1430} в {zone:1435} и на юг по дороге в {zone:1419}. Лагерь магов крови — первая остановка у дороги.",
	-- ["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Сначала езжайте дальше на восток по дороге к крепости: {item:6091} пропадет через час после места {area:42}, а звери магов крови займут больше времени.",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Езжайте на юг через перевал к северному краю зоны {area:3}: там троггы из племени Каменного Свода копают у входа в {area:1517}. Резные урны и пурпурные грибы находятся в их пещерах и туннелях, вне самого подземелья.",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Езжайте на запад: голодные хохотуны бродят по сухим холмам чуть южнее лагеря магов крови; скорпоки-острожалы (уровень 50) снуют по центру северной части. Над всем этим кружат грифы ({npc:5982}). Выманивайте по одному.",
	-- ["Scorpoks and snickerfangs"] = "Скорпоки и хохотуны",
	-- ["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Пройдите через портал в {zone:1457}. Храм Луны — на юге города.",
	-- ["Temple of the Moon"] = "Храм Луны",
	-- ["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Вторая ступень заданий магов крови платит за те же части предметом-усилением без опыта: пропустите.",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Учителя друидов стоят в Анклаве; в городе {zone:1455} их нет",
	-- ["The {area:1517} dig"] = "Раскопки: {area:1517}",
	-- ["the book on her table"] = "книга на ее столе",
	-- ["the soil comes from {zone:1449}, later"] = "почва — из зоны {zone:1449}, позже",
	-- ["{npc:3516}, at the top of the tree"] = "{npc:3516}, на вершине дерева",
	-- ["{npc:7740}, beside her"] = "{npc:7740}, рядом с ней",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- ["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} стоит наверху, над NPC {npc:7916}: поднимитесь внутри, стрелка не различает этажи.",
	-- ["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "Следующее поручение {npc:7907} ведет в {zone:1446}: пропустите.",
	-- ["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: сохраните задание, перья будут в конце гайда по зоне {zone:1428}",
}
