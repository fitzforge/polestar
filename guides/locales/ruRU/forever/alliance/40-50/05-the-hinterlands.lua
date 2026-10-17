-- Russian (ruRU): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aerie Peak
	-- {npc:7744} Innkeeper Thulfram
	["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",

	-- Step 2: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Езжайте на юго-восток к месту {area:355}, ступенчатому храму племени Порочной Ветви на юге края {zone:1425}, и поднимитесь на вершину. Квиага и {npc:8636} (элита, 50) стоят наверху: коснитесь вершины и сразу спускайтесь.",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Езжайте на север, в центр края {zone:1425}: {area:351}. Вокруг ползают зеленые слякочи и нефритовые слизнюки.",

	-- Step 4: Aerie Peak
	-- {area:348} Aerie Peak
	["Hearth to {area:348}."] = "Используйте Камень возвращения: {area:348}.",
	["Hearthstone on cooldown? Ride back north-west."] = "Камень возвращения на перезарядке? Езжайте обратно на северо-запад.",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "для NPC {quest:2990} ({area:1438}), позже",

	-- Step 5: Darkshire
	-- {area:348} Aerie Peak · {area:42} Darkshire
	["Fly from {area:348} to {area:42}."] = "Летите из места {area:348} в {area:42}.",

	-- Step 6: The bloodmages
	["The bloodmages"] = "Маги крови",
	-- {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "Езжайте на восток через {zone:1430} в {zone:1435} и на юг по дороге в {zone:1419}. Лагерь магов крови — первая остановка у дороги.",

	-- Step 7: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "Сначала езжайте дальше на восток по дороге к крепости: {item:6091} пропадет через час после места {area:42}, а звери магов крови займут больше времени.",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}, на вершине крепости",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "Следующее поручение {npc:8022}, {item:9471}, — задание для подземелья {area:978}: пропустите.",

	-- Step 8: Boars and basilisks
	["Boars and basilisks"] = "Кабаны и василиски",
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "Пеплогривые кабаны и краснокаменные василиски обитают на склонах к юго-западу от крепости. Держитесь подальше от зловепрей южнее: у них 52-й уровень.",

	-- Step 9: Scorpoks and snickerfangs
	["Scorpoks and snickerfangs"] = "Скорпоки и хохотуны",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "Езжайте на запад: голодные хохотуны бродят по сухим холмам чуть южнее лагеря магов крови; скорпоки-острожалы (уровень 50) снуют по центру северной части. Над всем этим кружат грифы ({npc:5982}). Выманивайте по одному.",

	-- Step 10: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "Вторая ступень заданий магов крови платит за те же части предметом-усилением без опыта: пропустите.",

	-- Step 11: Thelsamar
	-- {area:1438} Nethergarde Keep · {area:144} Thelsamar
	["Ride back east to {area:1438} and fly to {area:144}."] = "Езжайте обратно на восток в {area:1438} и летите в {area:144}.",

	-- Step 12: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "Езжайте на восток вдоль южного берега озера к лагерю: Раскопки Сталекрута.",

	-- Step 13: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "Раскопки: {area:1517}",
	-- {zone:1418} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "Езжайте на юг через перевал к северному краю зоны {zone:1418}: там троггы из племени Каменного Свода копают у входа в {area:1517}. Резные урны и пурпурные грибы находятся в их пещерах и туннелях, вне самого подземелья.",

	-- Step 14: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Езжайте обратно на север к Раскопкам Сталекрута.",

	-- Step 16: Rut'theran Village
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "Летите из места {area:144} в {area:150}, плывите на корабле в {area:442} и летите в {area:702}.",
	["the book on her table"] = "книга на ее столе",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "Следующее поручение {npc:7907} ведет в {zone:1446}: пропустите.",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}: сохраните задание, перья будут в конце гайда по зоне {zone:1428}",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "Храм Луны",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Пройдите через портал в {zone:1457}. Храм Луны — на юге города.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, рядом с ней",

	-- Step 19: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, на вершине дерева",
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "почва — из зоны {zone:1449}, позже",
	-- {zone:1455} Ironforge
	["The druid trainers stand in the Enclave; {zone:1455} has none"] = "Учителя друидов стоят в Анклаве; в городе {zone:1455} их нет",

	-- Step 20: Back to Thelsamar
	-- {area:144} Thelsamar
	["Back to {area:144}"] = "Вернитесь: {area:144}",
	-- {area:144} Thelsamar · {zone:1427} Searing Gorge · {area:1446} Thorium Point · {zone:1418} Badlands · {area:340} Kargath
	["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "Используйте Камень возвращения: {area:144}. Гайд по зоне {zone:1427} начинается здесь: {area:1446}. Отсюда езжайте на юг в {zone:1418}, на запад мимо ордынского городка {area:340} и вверх по тропе в ущелье.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "Езжайте на север, в центр зоны ({zone:1425}): {area:351}. Вокруг ползают зеленые слякочи и нефритовые слизнюки.",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "Езжайте на юго-восток к месту {area:355}, ступенчатому храму племени Порочной Ветви на юге зоны {zone:1425}, и поднимитесь на вершину. Квиага и {npc:8636} (элита, 50) стоят наверху: коснитесь вершины и сразу спускайтесь.",
}
