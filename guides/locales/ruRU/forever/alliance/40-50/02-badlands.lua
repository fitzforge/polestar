-- Russian (ruRU): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "{npc:2817}: следующее задание не дает опыта, пропустите его.",

	-- Step 3: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Езжайте на запад через зону {zone:1418} к лагерю клана Гнилобрюхов ({area:342}). {npc:2944} стоит в его центре, вокруг – охотники на драконов и изверги.",

	-- Step 4: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Езжайте обратно на восток. Цель: {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "{npc:2888}: следующее задание – охота на элиту, пропустите его.",

	-- Step 5: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Обжигающие дракончики гнездятся в ущелье к востоку (ориентир: {npc:2888}); опаленных стражей (элита) не трогайте. {item:4612} падает редко: возьмите, если выпадет, пока вы фармите.",

	-- Step 7: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "",

	-- Step 8: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "",

	-- Step 9: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "",

	-- Step 10: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "Раскопки: {area:1517}",

	-- Step 11: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "",

	-- Step 12: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "",

	-- Step 13: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Езжайте обратно на север к Раскопкам Сталекрута.",

	-- Step 14: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Летите сюда: {area:271}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 16: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "Следующее поручение Ролея – здесь: {area:796}. Пропустите его.",

	-- Step 18: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Из места {area:271} езжайте по дороге на северо-восток во {zone:1425}; {area:348} – сразу за границей. {npc:5635} принимает наверху, у птичника – {quest:1450}, у таверны стоит {npc:7884}.",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "",
	-- {npc:7744} Innkeeper Thulfram
	["{npc:7744}: the last guide binds here, so this usually ticks at once; below ground"] = "",

	-- Step 19: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} стоит лагерем на дороге к востоку (ориентир: {area:348}).",

	-- Step 20: Witherbark villages
	["Witherbark villages"] = "Деревни племени Сухокожих",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "Первые две клетки стоят рядом в деревне племени Сухокожих к югу от {npc:5634}; третья – в следующей деревне к востоку. Ожерелье может упасть с любого тролля из племени Сухокожих.",

	-- Step 21: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} продолжает платить за ожерелья: сдайте лишние",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "Следующее задание Разящего Когтя подождет до более позднего гайда по {zone:1425}.",

	-- Step 22: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 24: Theramore
	["Theramore"] = "Остров Терамор",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} стоит на причале, куда прибывает корабль.",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "",
	-- {npc:4968} Lady Jaina Proudmoore
	["{npc:4968}, on the top floor"] = "",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "",

	-- Step 25: Cortello's Riddle
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "",

	-- Step 26: Theramore flight master
	["Theramore flight master"] = "",

	-- Step 28: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Чернокнижник: {quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "С острова Терамор езжайте на север в зону {zone:1413}. Цель: {area:392}; если знаете этот маршрут полета, летите. {npc:6251} обучает в доме у банка.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blue Pearls from Stranglethorn"] = "Синие жемчужины из Тернистой долины",
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Летите сюда: {area:392}; {npc:6251} обучает в доме у банка. Затем возвращайтесь на остров Терамор.",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Летите сюда: {area:608}; езжайте на юг через зону {zone:1443} в зону {zone:1444} и по дороге до причала ({area:1108}); корабль переправит вас сюда: {area:1116}. Там начинается следующий гайд.",
	-- ["On to Feathermoon"] = "В Крепость Оперенной Луны",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Езжайте на север. Цель: {area:144}; оттуда летите сюда: {area:271}. {npc:3980} проповедует у таверны.",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Из места {area:271} езжайте по дороге на северо-восток во {area:47}; {area:348} – сразу за границей. {npc:5635} принимает наверху, у птичника – {quest:1450}, у таверны стоит {npc:7884}.",
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Из места {area:271} езжайте по дороге на северо-восток в зону {zone:1425}; {area:348} – сразу за границей. Фалстад принимает наверху, у птичника – {quest:1450}, у таверны стоит {npc:7884}.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Езжайте на юг из зоны {zone:1432} через перевал в зону {zone:1418}; {npc:2860} стоит лагерем у раскопок.",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Езжайте на запад через зону {area:3} к лагерю клана Гнилобрюхов ({area:342}). {npc:2944} стоит в его центре, вокруг – охотники на драконов и изверги.",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Езжайте на запад. Цель: {area:1877}, в центре зоны {zone:1418}; {npc:2817} стоит лагерем рядом с Мартеком.",
	-- ["Take the boat to Theramore from the far pier."] = "Сядьте на корабль до острова Терамор у дальнего причала.",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "Следующее задание Разящего Когтя подождет до более позднего гайда по {area:47}.",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "Разбитый скелет лежит на краю лагеря троггов из племени Каменного Свода; убийца Эгмонда ({quest:739}) ходит среди костегрызов.",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "убивайте цель {npc:2725} ({area:339}, {zone:1418})",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} стоит лагерем в одиночестве ({area:1898}), к юго-востоку от раскопок.",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "Для коктейля {npc:5634} нужны ингредиенты из Калимдора: пропустите задание.",
	-- ["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, наверху рядом с распорядителем полетов",
}
