-- Russian (ruRU): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1470} Ghak Healtouch · {area:144} Thelsamar · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:1470} is below ground in {area:144}, by the inn, where the flight lands. His mushrooms grow in the {area:1517} dig at the {zone:1418}' northern edge, on this guide's loop back north."] = "{npc:1470} находится под землей в месте {area:144}, у таверны, куда прилетает грифон. Его грибы растут на раскопках ({area:1517}) у северного края зоны {zone:1418}, на обратном пути этого гайда на север.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, под землей",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Езжайте на юг из зоны {zone:1432} через перевал в зону {zone:1418}; {npc:2860} стоит лагерем у раскопок.",
	-- {quest:706} Fiery Blaze Enchantments · {item:4612} Black Drake's Heart
	["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}: {item:4612} – редкая добыча, поэтому выполнение и сдача тоже необязательны",

	-- Step 4: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} стоит лагерем в одиночестве ({area:1898}), к юго-востоку от раскопок.",

	-- Step 5: Agmond's End
	-- {npc:269577} Dorgaron · {item:278404} Pristine Mattock · {quest:739} Murdaloc · {quest:705} Pearl Diving
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl · Giant Clams = {object:2744} Giant Clam
	["{npc:269577}'s {item:278404} lies in the middle of the Stonevault trogg camp, where {quest:739} walks.\nStill carrying {quest:705} without nine Blue Pearls? The Giant Clams were on the north-west Stranglethorn coast. Keep it for another visit rather than going back from here."] = "",

	-- Step 6: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "{npc:2817}: Синие жемчужины из Тернистой долины",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "{npc:2817}: следующее задание не дает опыта, пропустите его.",

	-- Step 7: Boss Tho'grun
	-- {npc:2944} Boss Tho'grun · {area:342} Camp Boff · {zone:1418} Badlands
	["{npc:2944} does not stay at {area:342}: he walks a long loop around the {zone:1418} with his guards, from the camp in the west along the south of the zone to about 61,69, north to about 49,49 and back west to the camp. The arrow follows his loop west from here until you meet him."] = "{npc:2944} не стоит на месте ({area:342}): он со своими стражами обходит зону {zone:1418} по длинному кругу – от лагеря на западе вдоль юга зоны примерно до 61,69, затем на север примерно до 49,49 и обратно на запад к лагерю. Стрелка ведет по его маршруту на запад отсюда, пока вы его не встретите.",

	-- Step 8: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Езжайте обратно на восток. Цель: {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "{npc:2888}: следующее задание – охота на элиту, пропустите его.",

	-- Step 9: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Обжигающие дракончики гнездятся в ущелье к востоку (ориентир: {npc:2888}); опаленных стражей (элита) не трогайте. {item:4612} падает редко: возьмите, если выпадет, пока вы фармите.",

	-- Step 11: Dorgaron
	-- {npc:269577} Dorgaron · {zone:1432} Loch Modan
	["{npc:269577} camps at the foot of the pass into {zone:1432}, on the way north."] = "{npc:269577} стоит лагерем у подножия перевала в зону {zone:1432}, по пути на север.",

	-- Step 12: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "В зону {zone:1432}",

	-- Step 13: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "",

	-- Step 14: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "В зону {zone:1418}",

	-- Step 15: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "Раскопки: {area:1517}",

	-- Step 16: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "{item:8047}; под землей",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "",

	-- Step 17: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "Обратно: {zone:1432}",

	-- Step 18: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Езжайте обратно на север к Раскопкам Сталекрута.",

	-- Step 19: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Летите сюда: {area:271}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Распорядитель полетов: {area:144}",

	-- Step 21: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "{npc:3980}, наверху",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "Следующее поручение Ролея – здесь: {area:796}. Пропустите его.",

	-- Step 22: Loremaster Dibbs
	-- {npc:2277} Loremaster Dibbs · {area:271} Southshore
	["{npc:2277} stands in {area:271}, by the inn."] = "{npc:2277} стоит в месте {area:271}, у таверны.",

	-- Step 24: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Из места {area:271} езжайте по дороге на северо-восток во {zone:1425}; {area:348} – сразу за границей. {npc:5635} принимает наверху, у птичника – {quest:1450}, у таверны стоит {npc:7884}.",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "{quest:1450}, внутри",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}, внутри",

	-- Step 25: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} стоит лагерем на дороге к востоку (ориентир: {area:348}).",

	-- Step 26: Witherbark villages
	["Witherbark villages"] = "Деревни племени Сухокожих",
	-- {npc:5634} Rhapsody Shindigger · {npc:270772} Witch Doctor Ti'ik
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace.\nCareful: {npc:270772} (49) and his Hexed Larvae (45) keep to the huts of the western village, around 25,64: take the necklaces from the trolls outside."] = "Первые две клетки стоят рядом в деревне племени Сухокожих к югу от {npc:5634}; третья – в следующей деревне к востоку. Ожерелье может упасть с любого тролля из племени Сухокожих.\nОсторожно: {npc:270772} (49) и его проклятые личинки (45) держатся в хижинах западной деревни, примерно у 25,64: добывайте ожерелья с троллей снаружи.",

	-- Step 27: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "{npc:5636}, наверху рядом с распорядителем полетов; внутри",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "Следующее задание Разящего Когтя подождет до более позднего гайда по {zone:1425}.",

	-- Step 28: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Летите сюда: {area:150}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Распорядитель полетов: {area:348}",

	-- Step 30: Theramore
	["Theramore"] = "Остров Терамор",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, внутри",

	-- Step 31: Mudsprocket
	["Mudsprocket"] = "Шестермуть",
	-- {area:511} Wyrmbog · {npc:270723} Drazzit Dripvalve · {npc:270727} Gizzix Grimegurgle
	["Take the road south-west out of Theramore to Mudsprocket, the goblin camp at the edge of the {area:511}. {npc:270723} and {npc:270727} stand together in the camp."] = "Езжайте по дороге на юго-запад из Терамора в Шестермуть, лагерь гоблинов на краю места {area:511}. {npc:270723} и {npc:270727} стоят вместе в лагере.",

	-- Step 32: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {item:280092} Wyrmtail
	-- plural, as words: Searing Hatchlings = {npc:4323} Searing Hatchling · Firemane Scalebanes = {npc:4328} Firemane Scalebane
	["The {item:280092} grows in the bog east of the camp: gather it first. Then the Searing Hatchlings and Whelps (41-43) and the Firemane dragonkin nest in the bog north and west of Mudsprocket, on the way back; all of them drop the shed scales.\nCareful: the Firemane Scalebanes and Flamecallers are 43-44 and cast fire: pull them one at a time."] = "{item:280092} растет в болоте к востоку от лагеря: сначала соберите его. Затем опаляющие малыши дракона и дракончики (41-43) и драконы Огнегривых гнездятся в болоте к северу и западу от Шестермути, на обратном пути; все они роняют сброшенную чешую.\nОсторожно: огнегривые чешуйчатые губители и призыватели огня 43-44 уровня и колдуют огонь: подманивайте их по одному.",

	-- Step 33: Mudsprocket
	["Then ride back north-east to Theramore's flight master."] = "Затем езжайте обратно на северо-восток к распорядителю полетов Терамора.",

	-- Step 34: Theramore flight master
	["Theramore flight master"] = "Распорядитель полетов: Терамор",

	-- Step 36: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Чернокнижник: {quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "С острова Терамор езжайте на север в зону {zone:1413}. Цель: {area:392}; если знаете этот маршрут полета, летите. {npc:6251} обучает в доме у банка.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Летите сюда: {area:392}; {npc:6251} обучает в доме у банка. Затем возвращайтесь на остров Терамор.",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Летите сюда: {area:608}; езжайте на юг через зону {zone:1443} в зону {zone:1444} и по дороге до причала ({area:1108}); корабль переправит вас сюда: {area:1116}. Там начинается следующий гайд.",
	-- ["Inside {area:498}"] = "Внутри: {area:498}",
	-- ["On to Feathermoon"] = "В Крепость Оперенной Луны",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Езжайте на север. Цель: {area:144}; оттуда летите сюда: {area:271}. {npc:3980} проповедует у таверны.",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Из места {area:271} езжайте по дороге на северо-восток во {area:47}; {area:348} – сразу за границей. {npc:5635} принимает наверху, у птичника – {quest:1450}, у таверны стоит {npc:7884}.",
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Из места {area:271} езжайте по дороге на северо-восток в зону {zone:1425}; {area:348} – сразу за границей. Фалстад принимает наверху, у птичника – {quest:1450}, у таверны стоит {npc:7884}.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Езжайте на юг из зоны {zone:1432} через перевал в зону {zone:1418}; {npc:2860} стоит лагерем у раскопок.",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Езжайте на запад через зону {area:3} к лагерю клана Гнилобрюхов ({area:342}). {npc:2944} стоит в его центре, вокруг – охотники на драконов и изверги.",
	-- ["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Езжайте на запад через зону {zone:1418} к лагерю клана Гнилобрюхов ({area:342}). {npc:2944} стоит в его центре, вокруг – охотники на драконов и изверги.",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Езжайте на запад. Цель: {area:1877}, в центре зоны {zone:1418}; {npc:2817} стоит лагерем рядом с Мартеком.",
	-- ["Take the boat to Theramore from the far pier."] = "Сядьте на корабль до острова Терамор у дальнего причала.",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "Следующее задание Разящего Когтя подождет до более позднего гайда по {area:47}.",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "Разбитый скелет лежит на краю лагеря троггов из племени Каменного Свода; убийца Эгмонда ({quest:739}) ходит среди костегрызов.",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "убивайте цель {npc:2725} ({area:339}, {zone:1418})",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",
	-- ["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} стоит на причале, куда прибывает корабль.",
	-- ["{npc:269577}'s {item:278404} lies in the middle of the Stonevault trogg camp, where {quest:739} walks."] = "Предмет {item:278404} для NPC {npc:269577} лежит посреди лагеря троггов Каменной Гробницы, где бродит {quest:739}.",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} стоит лагерем в одиночестве ({area:1898}), к юго-востоку от раскопок.",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "Для коктейля {npc:5634} нужны ингредиенты из Калимдора: пропустите задание.",
	-- ["{npc:7744}; below ground"] = "{npc:7744}; под землей",
	-- ["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} продолжает платить за ожерелья: сдайте лишние",
}
