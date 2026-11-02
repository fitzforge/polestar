-- Russian (ruRU): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272} – ваша база в этом гайде: камень возвращения дважды вернет вас сюда. Все стоят вокруг городской площади.",
	["Inside"] = "",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "Наполните {item:7768} у колодца рядом с таверной: {object:107045}",
	-- {npc:2388} Innkeeper Shay
	["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}: предыдущий гайд привязывает вас здесь, так что это обычно отмечается сразу",
	-- {object:556670} WANTED
	["The {object:556670} poster by the inn"] = "",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way; inside"] = "",

	-- Step 2: Serge Hinott
	-- {quest:2479} Hinott's Assistance · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["After returning Mission: Possible But Not Probable to Shenthul, bring {quest:2479} to {npc:2391} in {area:272}. Stay beside him until the brewing objective completes, then hand in the follow-up to learn Poisons. Finish it even if the Zanzil poison has already been removed; removing the debuff alone does not teach the skill."] = "",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Яды",
	["Poison chain unfinished? Resume your current stage in the Class guide Poisons (Horde); completed quests do not need restarting. Arrange a group for Gallywix, finish the Hinott follow-up, then return to this leveling guide."] = "",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "Медведи, ползуны и львы",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "К западу от Мельницы Таррен по холмам на пути к фермам бродят серые медведи, лесные моховые ползуны и голодные горные львы. {item:3477} падает с ползунов редко; нужен только один.",

	-- Step 4: Tarren Mill
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon; inside"] = "",

	-- Step 5: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "",

	-- Step 6: Mountain Lion Blood
	["Careful: When one lion is attacked, nearby lions come to its aid, and the Vicious Black Bears sharing those fields can also join the fight."] = "",

	-- Step 7: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "Фермы к востоку от городка {area:287}. {npc:232} работает на поле у северного фермерского дома, {npc:2403} — на поле юго-восточнее; батраки и фермеры повсюду. {npc:2451} ухаживает за полем к югу от ферм.",
	-- {npc:2451} Farmer Kalaba · {area:286} Hillsbrad Fields
	["{npc:2451} walks around {area:286}: look inside the circle on the map"] = "",

	-- Step 9: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274} — собака NPC {npc:232}, у северного фермерского дома ({area:286}).",

	-- Step 10: Hillsbrad Fields: kill these as you meet them
	-- {area:286} Hillsbrad Fields
	["{area:286}: kill these as you meet them"] = "",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often.\nCareful: A fleeing peasant that reaches the town hall can bring back many adds, including {area:287} footmen; snares, roots or similar effects keep them from escaping."] = "",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}: хилсбрадские крестьяне на полях",

	-- Step 11: Hearth to Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth to {area:272}"] = "",

	-- Step 12: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}: приказы для NPC {npc:270438}, по пути к Дарнхольду",

	-- Step 13: Durnholde Keep: kill these as you meet them
	-- {area:275} Durnholde Keep
	["{area:275}: kill these as you meet them"] = "",
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep · {area:272} Tarren Mill
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks.\nFrom {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "",
	-- {npc:2261} Syndicate Watchman
	["{npc:2261} walks around here: look inside the circle on the map"] = "",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Ядро и цепь: {npc:2238}",
	["Drull's ball and chain"] = "Ядро и цепь Друлла",

	-- Step 14: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Масодж прячется на склоне над местом {area:290}, к югу от Дарнхольда, по пути вниз к цветам.",

	-- Step 15: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "К юго-западу от Дарнхольда на склонах над рекой растет {item:3502}.",

	-- Step 16: The smithy
	["The smithy"] = "Кузница",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "Кузница стоит в центре городка {area:287}. {npc:2404} и его подмастерья работают у горна; {object:1736} сложена рядом. {npc:2449} ходит по улице к северу от нее.",

	-- Step 17: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}, {zone:1458}",

	-- Step 18: Town hall
	["Town hall"] = "Ратуша",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Ратуша — в западной части места {area:287}. {npc:2335} (30) и {npc:2448} внутри, там же Регистрационная книга Хилсбрада; рядом висит Хилсбрадское официальное объявление. По городку ходят члены совета Хилсбрада.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "",

	-- Step 20: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288} — к югу от городка {area:287}. В туннелях работают шахтеры; {npc:2305} (30) и {npc:2450} (29) — в глубине.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "",

	-- Step 24: To the Undercity
	-- {zone:1458} Undercity
	["To the {zone:1458}"] = "",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {area:85} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter
	["Head east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {area:85}; the {zone:1458} lies below the {area:153}. The bat handler is in the {object:36078}."] = "",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "",

	-- Step 25: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "",

	-- Step 26: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}, в Аптекарии",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "Сохраните его: побережье ({area:287}), позже по маршруту",

	-- Step 27: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Two-Handed Swords from {npc:11870} ({object:36070}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 28: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); two-handers level a Warrior fastest."] = "",

	-- Step 29: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Two-Handed Swords from {npc:11870} ({object:36070}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 30: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 31: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Swords from {npc:11870} ({object:36070}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 32: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "",

	-- Step 34: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "Летите на дирижабле от башен у города {zone:1458} в {zone:1454} и обучитесь перед дальнейшим полетом.",

	-- Step 35: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "Из города {zone:1454} (дирижабль от башен у города {zone:1458}) летите в {area:378}.",

	-- Step 37: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "Хижина ({npc:5899}) стоит на гребне над водопоем свинобразов, к югу от места {area:378}, по пути в {area:359}.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: красный бурдюк из места {area:272}",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: синий бурдюк наполняется в зоне {zone:1440}, следующий гайд",

	-- Step 38: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "Идите по дороге на юг к раскопкам дворфов: {area:359}. {npc:3421} прячется у южного края раскопок; {object:3646} стоит на дне котлована.",
	-- {object:3646} General Twinbraid's Strongbox
	["{object:3646}; below ground"] = "",

	-- Step 39: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "",

	-- Step 40: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "",
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {area:17} The Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {area:17}."] = "",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "",

	-- Step 41: Hearth to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Hearth to {area:378}"] = "",

	-- Step 42: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "",

	-- Step 43: Mebok Mizzyrix
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}, у причалов ({area:392})",

	-- Step 44: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "Используйте Камень возвращения: {area:378}, и летите в {area:392}. {quest:874} стоит лагерем на берегу к северу от места {area:392}.",

	-- Step 45: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}, большой трешадон, плавает на мелководье у места {area:391}, к востоку от {npc:3388}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "Друлл и {npc:2238} прикованы в постройках внутреннего двора ({area:275}); откройте оба замка.",
	-- ["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "Из места {area:272} идите на юго-восток в холмы по пути к месту {area:275}. Лагеря на пути занимают разбойники и сторожа Синдиката.",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "Из города {zone:1454} (дирижабль от башен у города {zone:1458}) летите в {area:1638} и обучитесь здесь: {area:1639}, затем летите дальше в {area:378}.",
	-- ["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Нервотреп еще жив? Классовый гайд «Яды (Орда)» снова проводит цепочку от Шентула, с группой для Нервотрепа.",
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "Нервотреп еще жив? Классовый гайд «{spell:2842} (Орда)» снова проводит цепочку от Шентула, с группой для Нервотрепа.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "Только если Нервотреп пал в {zone:1413} («Миссия: выполнима, но с трудом»): {npc:2391} стоит здесь: {area:272}. Подождите рядом, пока он варит лекарство, затем заберите награду: Яды.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "Только если Нервотреп пал в зоне {zone:1413} («Миссия: выполнима, но с трудом»): {npc:2391} стоит здесь: {area:272}. Подождите рядом, пока он варит лекарство, затем заберите награду: {spell:2842}.",
	-- ["Peasants and skulls"] = "Крестьяне и черепа",
	-- ["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "К юго-западу от Бейл Модана {npc:12576} ждет наверху: {area:485}.",
	-- ["Syndicate camps"] = "Лагеря Синдиката",
	-- ["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "Хилсбрадские крестьяне работают на полях к югу от фермерских домов. С каждого человека ({area:287}) падают черепа; чаще всего — с крестьян.",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "Кузница стоит в центре городка {area:287}. {npc:2404} и его подмастерья работают у горна; {item:3564} сложена рядом. {npc:2449} ходит по улице к северу от нее.",
	-- ["The {object:1763} poster by the inn"] = "Плакат у таверны: {object:1763}",
	-- ["The {quest:567} poster: its targets come up along the way"] = "Плакат «{quest:567}»: его цели попадутся по пути",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "Вы прибываете в таверну, где привязан ваш камень: {area:272}. Все стоят вокруг городской площади.",
	-- ["{npc:2230}, next to Lydon"] = "{npc:2230}, рядом с Лидоном",
}
