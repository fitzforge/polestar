-- Russian (ruRU): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272} – ваша база в этом гайде: камень возвращения дважды вернет вас сюда. Все стоят вокруг городской площади.",
	-- {npc:2388} Innkeeper Shay
	["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "Плакат у таверны: {object:1763}",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way"] = "Плакат «{quest:567}»: его цели попадутся по пути",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Наполните {item:7768} у колодца рядом с таверной: {object:107045}",

	-- Step 2: Serge Hinott
	-- {zone:1413} The Barrens · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Только если Нервотреп пал в {zone:1413} («Миссия: выполнима, но с трудом»): {npc:2391} стоит здесь: {area:272}. Подождите рядом, пока он варит лекарство, затем заберите награду: Яды.",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Яды",
	["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Нервотреп еще жив? Классовый гайд «Яды (Орда)» снова проводит цепочку от Шентула, с группой для Нервотрепа.",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Медведи, ползуны и львы",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "К западу от Мельницы Таррен по холмам на пути к фермам бродят серые медведи, лесные моховые ползуны и голодные горные львы. {item:3477} падает с ползунов редко; нужен только один.",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "Фермы к востоку от городка {area:287}. {npc:232} работает на поле у северного фермерского дома, {npc:2403} — на поле юго-восточнее; батраки и фермеры повсюду. {npc:2451} ухаживает за полем к югу от ферм.",

	-- Step 5: Tarren Mill
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon"] = "{npc:2230}, рядом с Лидоном",

	-- Step 6: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} — собака NPC {npc:232}, у северного фермерского дома ({area:286}).",

	-- Step 7: Peasants and skulls
	["Peasants and skulls"] = "Крестьяне и черепа",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Хилсбрадские крестьяне работают на полях к югу от фермерских домов. С каждого человека ({area:287}) падают черепа; чаще всего — с крестьян.",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}: хилсбрадские крестьяне на полях",

	-- Step 8: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}: приказы для NPC {npc:270438}, по пути к Дарнхольду",

	-- Step 9: Syndicate camps
	["Syndicate camps"] = "Лагеря Синдиката",
	-- {area:272} Tarren Mill · {area:275} Durnholde Keep
	["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Из места {area:272} идите на юго-восток в холмы по пути к месту {area:275}. Лагеря на пути занимают разбойники и сторожа Синдиката.",

	-- Step 10: Durnholde Keep
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Друлл и {npc:2238} прикованы в постройках внутреннего двора ({area:275}); откройте оба замка.",
	["Drull's ball and chain"] = "Ядро и цепь Друлла",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Ядро и цепь: {npc:2238}",

	-- Step 11: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Масодж прячется на склоне над местом {area:290}, к югу от Дарнхольда, по пути вниз к цветам.",

	-- Step 12: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "К юго-западу от Дарнхольда на склонах над рекой растет {item:3502}.",

	-- Step 13: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, {zone:1458}",

	-- Step 14: The smithy
	["The smithy"] = "Кузница",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "Кузница стоит в центре городка {area:287}. {npc:2404} и его подмастерья работают у горна; {object:1736} сложена рядом. {npc:2449} ходит по улице к северу от нее.",

	-- Step 16: Town hall
	["Town hall"] = "Ратуша",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Ратуша — в западной части места {area:287}. {npc:2335} (30) и {npc:2448} внутри, там же Регистрационная книга Хилсбрада; рядом висит Хилсбрадское официальное объявление. По городку ходят члены совета Хилсбрада.",

	-- Step 18: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288} — к югу от городка {area:287}. В туннелях работают шахтеры; {npc:2305} (30) и {npc:2450} (29) — в глубине.",

	-- Step 20: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, в Аптекарии",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Сохраните его: побережье ({area:287}), позже по маршруту",

	-- Step 21: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Летите на дирижабле от башен у города {zone:1458} в {zone:1454} и обучитесь перед дальнейшим полетом.",

	-- Step 22: Thunder Bluff
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:1638} Thunder Bluff · {area:1639} Elder Rise · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "Из города {zone:1454} (дирижабль от башен у города {zone:1458}) летите в {area:1638} и обучитесь здесь: {area:1639}, затем летите дальше в {area:378}.",

	-- Step 23: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "Из города {zone:1454} (дирижабль от башен у города {zone:1458}) летите в {area:378}.",

	-- Step 24: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "Хижина ({npc:5899}) стоит на гребне над водопоем свинобразов, к югу от места {area:378}, по пути в {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: красный бурдюк из места {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: синий бурдюк наполняется в зоне {zone:1440}, следующий гайд",

	-- Step 25: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Идите по дороге на юг к раскопкам дворфов: {area:359}. {npc:3421} прячется у южного края раскопок; {object:3646} стоит на дне котлована.",

	-- Step 26: Great Lift
	-- {npc:12576} Grish Longrunner · {area:485} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "К юго-западу от Бейл Модана {npc:12576} ждет наверху: {area:485}.",

	-- Step 27: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Используйте Камень возвращения: {area:378}, и летите в {area:392}. {quest:874} стоит лагерем на берегу к северу от места {area:392}.",

	-- Step 28: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, большой трешадон, плавает на мелководье у места {area:391}, к востоку от {npc:3388}.",

	-- Step 29: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, у причалов ({area:392})",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Нервотреп еще жив? Классовый гайд «{spell:2842} (Орда)» снова проводит цепочку от Шентула, с группой для Нервотрепа.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "Только если Нервотреп пал в зоне {zone:1413} («Миссия: выполнима, но с трудом»): {npc:2391} стоит здесь: {area:272}. Подождите рядом, пока он варит лекарство, затем заберите награду: {spell:2842}.",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "Кузница стоит в центре городка {area:287}. {npc:2404} и его подмастерья работают у горна; {item:3564} сложена рядом. {npc:2449} ходит по улице к северу от нее.",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Вы прибываете в таверну, где привязан ваш камень: {area:272}. Все стоят вокруг городской площади.",
}
