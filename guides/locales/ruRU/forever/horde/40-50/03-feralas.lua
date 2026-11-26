-- Russian (ruRU): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1454} Orgrimmar · {area:1099} Camp Mojache · {area:511} Wyrmbog · {area:496} Brackenwall Village
	["{zone:1454}'s hand-ins, {area:1099}'s Muisek vessel, then Dustwallow's {area:511} and {area:496}."] = "Сдача заданий в {zone:1454}, сосуд муйсека из места {area:1099}, затем {area:511} и {area:496} в Пылевых топях.",
	["Takes you to level 47"] = "Доведет вас до 47-го уровня",
	-- {zone:1446} Tanaris
	["Then on to {zone:1446}"] = "Затем в зону {zone:1446}",
	["Stays on the main route"] = "Остается на основном маршруте",
	-- {zone:2652} Shen'dralas · {zone:1446} Tanaris
	["Skips {zone:2652}: about a dozen fewer quests, a third of a level lower into {zone:1446}"] = "Пропускает {zone:2652}: примерно на дюжину заданий меньше, в {zone:1446} – на треть уровня ниже",

	-- Step 1: Orgrimmar
	-- {object:172960} Cleft of Shadow · {object:172958} Valley of Honor
	["From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "От распорядителя полетов: {object:172960}, затем Аллея Силы, затем {object:172958}.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, Волок",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}, Волок",
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425}, around level 50"] = "для края {zone:1425}, примерно на 50-м уровне"
	["for the {zone:1425}, around level 49"] = "",

	-- Step 3: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "",
	-- {area:1638} Thunder Bluff · {area:1099} Camp Mojache
	["Your trainer is in {area:1638}, on the way to {area:1099}."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 5: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Летите сюда: {area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Распорядитель полетов: {zone:1456}",

	-- Step 6: Fly to Camp Mojache
	-- {area:1099} Camp Mojache · {zone:1444} Feralas · {zone:1446} Tanaris
	["Fly to {area:1099} (or hearth there, if your hearthstone is ready: it is still bound there from the {zone:1444} & {zone:1446} guide)."] = "",

	-- Step 7: Camp Mojache
	-- {zone:1425} Hinterlands
	-- was: ["for the {zone:1425} owlbeasts, around level 48"] = "для совухов ({zone:1425}), примерно на 48-м уровне"
	["for the {zone:1425} owlbeasts, around level 49"] = "",

	-- Step 8: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "Летите сюда: {area:496}",
	-- {zone:1444} Feralas · {zone:1446} Tanaris · {area:496} Brackenwall Village
	["No Muisek vessel to bring Uzer'i (you didn't take the {zone:1444} & {zone:1446} guide's chain): fly from here straight to {area:496}."] = "",

	-- Step 9: Fly to Brackenwall Village
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Распорядитель полетов: {area:1099}",

	-- Step 10: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}, под землей",

	-- Step 11: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "{object:2555}",

	-- Step 12: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "Внутри: {area:498}",

	-- Step 13: The Musty Scroll
	-- {object:2555} Musty Scroll
	["The {object:2555} lies to the south-west."] = "{object:2555} лежит на юго-западе.",

	-- Step 14: Mudsprocket
	["Mudsprocket"] = "Шестермуть",
	-- {object:2555} Musty Scroll · {area:511} Wyrmbog · {npc:270723} Drazzit Dripvalve · {npc:270727} Gizzix Grimegurgle · {item:280092} Wyrmtail
	["South-east from the {object:2555} to Mudsprocket, the goblin camp at the {area:511}'s western edge: {npc:270723} and {npc:270727} stand together in the camp. Their whelps, scales and {item:280092} come on the same {area:511} loop as Brackenwall's quests."] = "На юго-восток от места {object:2555} к Шестермути, гоблинскому лагерю на западном краю места {area:511}: {npc:270723} и {npc:270727} стоят вместе в лагере. Их дракончики, чешуя и {item:280092} – на том же круге по месту {area:511}, что и задания Гиблотопи.",

	-- Step 15: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510}: убивайте их по пути",
	-- {area:511} Wyrmbog · {item:280092} Wyrmtail
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps. The {item:280092} grows in the bog just east of Mudsprocket."] = "На восток через место {area:511}: огнегривые разведчики и пеплохвосты бродят по его северному краю вместе с опаляющими детенышами и дракончиками; чешуебои охраняют драконьи пещеры дальше на юго-востоке. Табак, грог и сундук Мок'Морокка лежат в лагерях драконидов. {item:280092} растет на болоте чуть к востоку от Шестермути.",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "{npc:4329} ходит по месту {area:510}: ищите внутри круга на карте",
	["Below ground"] = "Под землей",

	-- Step 16: Mudsprocket
	["Back to Mudsprocket before you ride north."] = "Назад в Шестермуть, прежде чем ехать на север.",

	-- Step 17: Brackenwall Village
	["Ride back north to Brackenwall."] = "Возвращайтесь на север в Гиблотопь.",

	-- Step 18: Onyxia's eggs
	["Onyxia's eggs"] = "Яйца Ониксии",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Яйца Ониксии лежат в драконьих пещерах на юго-востоке ({area:511}) под охраной чешуйчатых губителей; разбейте пять.",

	-- Step 19: Muckshell crabs
	["Muckshell crabs"] = "",
	-- plural, as words: Muckshell Razorclaws = {npc:4405} Muckshell Razorclaw
	["On the way back north from the dragon caves, the Muckshell Razorclaws and Pincers (41-44) crowd the shallows just north of the caves; about one in twenty carries the Jeweled Pendant Marg Speaks asks for."] = "",

	-- Step 20: Level 45.37
	["Level 45.37"] = "Уровень 45.37",
	-- {npc:4500} Overlord Mok'Morokk · {area:511} Wyrmbog · {area:978} Zul'Farrak
	["{npc:4500}'s challenge, back in Brackenwall, needs a group of three. Alone, grind the Firemane scouts here on the {area:511}'s northern edge to level 45.37 before you ride back north, so you don't come back down for it. Or, with a group, run the {area:978} dungeon instead."] = "Для вызова ({npc:4500}) в Гиблотопи нужна группа из трех человек. В одиночку убивайте огнегривых разведчиков здесь, на северном краю ({area:511}), до уровня 45.37, прежде чем ехать обратно на север, чтобы не возвращаться сюда ради этого. Или, если есть группа, пройдите вместо этого подземелье {area:978}.",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "убивайте: {npc:4329}",

	-- Step 21: Brackenwall Village
	-- {npc:4791} Nazeer Bloodpike · {item:5942} Jeweled Pendant
	["{npc:4791}: the {item:5942}"] = "",
	-- {npc:4047} Zor Lonetree · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["for {npc:4047} in {zone:1454}, on the {zone:1447} guide's {zone:1454} stop"] = "",
	-- {quest:3128} Natural Materials · {zone:1444} Feralas
	["Keep {quest:3128} and Improved Quality: {zone:1444}' sprites, hippogryphs, Zorbin's coast and the Rage Scar yetis come on your {zone:1444} loop at about 51, with the Muisek chain."] = "",

	-- Step 22: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Назад на восток мимо места {area:75}: артефакты Атал'ай лежат в воде и на берегах (задание: {quest:1424}).",
	-- ["Back to {npc:14637} on the dock."] = "Назад к NPC {npc:14637} на причале.",
	-- ["Dragon caves"] = "Драконьи пещеры",
	-- ["Fly to {area:75}"] = "Летите сюда: {area:75}",
	-- ["Fly to {object:3202}"] = "Летите сюда: {object:3202}",
	-- ["Forest walkers"] = "Лесные древни",
	-- ["Frayfeather hippogryphs"] = "Блеклоперые гиппогрифы",
	-- ["Hearth to {area:1099}: your hearthstone is still bound there from the {zone:1444} & {zone:1446} guide."] = "Используйте Камень возвращения ({area:1099}): он все еще привязан там с гайда «{zone:1444} и {zone:1446}».",
	-- ["Monstrous Crawlers"] = "Чудовищные крабы",
	-- ["Murlocs of the Misty Reed"] = "Мурлоки Тростникового берега",
	-- ["No flight path to {area:75} yet (the {zone:2548} skip the {zone:1435}): ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "Маршрута полета сюда ({area:75}) еще нет (гайды по зоне {zone:2548} пропускают зону {zone:1435}): езжайте на северо-восток от места {object:3202} через {zone:1431} и {zone:1430} в болото, затем на восток по дороге: {area:75}. Откройте там маршрут полета.",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "На северо-запад по дороге, у пещер в холмах живут йети Бешеного оврага. С любого может также упасть {quest:7738} – это начинает отдельное задание.",
	-- ["Northspring harpies"] = "Гарпии Студеных Ключей",
	-- ["On the way back south-east from the coast, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "На обратном пути от побережья на юго-восток, у пещер в холмах у дороги живут йети Бешеного оврага. С любого может также упасть {quest:7738} – это начинает отдельное задание.",
	-- ["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "На обратном пути от гарпий на юго-восток, у пещер в холмах у дороги живут йети Бешеного оврага. С любого может также упасть {quest:7738} – это начинает отдельное задание.",
	-- ["Rage Scar yetis"] = "Йети Бешеного оврага",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Возвращайтесь на восток в лагерь. Оставайтесь здесь: следующее руководство начинается с полета сюда: {area:976}.",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Езжайте на северо-запад сюда: {area:1108}; {npc:14637} ждет на причале.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Езжайте на юго-запад к предмету {object:2555}, затем на восток через место {area:511}. Огнегривые разведчики и пеплохвосты бродят по его северному краю вместе с опаляющими малышами дракона и дракончиками; чешуйчатые губители охраняют драконьи пещеры дальше к юго-востоку. Понюшка, грог и сейф Мок'Морокка лежат в лагерях драконидов.",
	-- ["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Езжайте на запад по дороге; свиток лежит у кромки воды на дальнем западе болота.",
	-- ["Riding at 40"] = "Верховая езда на 40-м уровне",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; при обучении вы получаете ездовое животное. Каждая раса учится у учителя своей расы: ваш – {npc:4773} ({area:159}), недалеко к северу от башен дирижаблей, рядом кони-скелеты NPC {npc:4731} (по 20 золотых). Вернитесь к башням, чтобы сесть на дирижабль до места {object:3202}.",
	-- ["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all."] = "Разбойничья долина начинается чуть к северу от причала ({npc:14637}). Убейте {npc:5308}, используйте {item:10699} на его теле, прежде чем обыскать его, затем поговорите с поднявшимся духом: он дружелюбен. Всего три духа.",
	-- ["Rogue Vale screechers"] = "Крикуны Разбойничьей долины",
	-- ["Sawtooth crocolisks"] = "Острозубые кроколиски",
	-- ["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Морские элементали и морские валы бродят по берегу у причала. Сначала уменьшите великанов предметом {item:18904}: уменьшенные, они теряют силу элиты. Береговые странники бродят в воде; сухопутные бродяги и скальные великаны – на холмах дальше к северу.",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Кони-скелеты: {npc:4731}, рядом с персонажем {npc:4773} ({area:159}).",
	-- ["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "К югу от долины на склонах гнездятся блеклоперые гиппогрифы; почти с каждого падают сухожилия и металлические осколки.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "К юго-западу йети живут здесь: {area:1105}; толстая шкура может упасть с любого йети.",
	-- ["Sprite darters and forest walkers"] = "Летучие хамелеоны и лесные древни",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Болотные мурлоки живут на берегу к югу от лагеря; чернильщики – вдоль берега к востоку, а трупоеды – дальше к западу, у хижин на западном берегу.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Чудовищные крабы редко встречаются на пляжах восточного побережья: убивайте каждого, кого встретите по пути на юг.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Гарпии из стаи Студеных Ключей гнездятся на хребтах на дальнем северо-западе. Они 48-50 уровня, на несколько уровней выше вас: призывательницы ветров лечат – убивайте их первыми и выманивайте по одной.",
	-- ["The Sea Sprays (47-48) wash along the shore just south of the dock: they drop the Water Elemental Cores as well as the Sea Elementals (48-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength. Leave the Land Walkers and Cliff Giants (48-50) of the northern hills for your next {zone:1444} visit.\nThe Ultra-Shrinker lasts two hours: hand both quests back to {npc:14637} before you leave the coast."] = "Морские валы (47-48) плещутся у берега чуть к югу от причала: ядра элементаля воды падают с них так же, как с морских элементалей (48-49). Волновые странники и странники глубин (47-49) бродят в воде у того же пляжа: сначала примените на них {item:18904} – уменьшившись, они теряют силу элиты. Сухопутных бродяг и скальных великанов (48-50) на северных холмах оставьте до следующего визита в край {zone:1444}.\nУльтрасжиматель действует два часа: сдайте оба задания NPC {npc:14637}, прежде чем покинуть побережье.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Снова те же мурлоки, плюс оракулы – они держатся у хижин на западном берегу.",
	-- ["The small Horde post on the southern shore."] = "Небольшой лагерь Орды на южном берегу.",
	-- ["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "Летучие хамелеоны порхают над рощей чуть к западу от лагеря; у них – {item:9589}; у бродячих лесных древней чуть дальше к западу – расколотые бревна.\nОсторожно: над лесом к западу от лагеря летает {npc:272401} (60-й уровень): держитесь от него подальше.",
	-- ["The zeppelin lands at {object:3202}: Stranglethorn's errands are done (40-50/02), so fly straight on to {area:75}."] = "Дирижабль прибывает сюда: {object:3202}. Поручения в Тернистой долине выполнены (40-50/02), так что летите сразу в {area:75}.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "Дирижабль ({zone:1454}) отправляется с башни у лагеря {object:3202}; он причаливает чуть к северо-востоку от главных ворот ({zone:1454}).",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["Three zones, lots of travel"] = "Три зоны, много перемещений",
	-- ["To {area:1099}"] = "В место {area:1099}",
	-- ["To {area:75}"] = "В место {area:75}",
	-- ["Underwater"] = "Под водой",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Вы начинаете здесь: {area:75}. Привяжите камень возвращения: после побережья вы вернетесь сюда.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Ваш учитель – в городе {area:1638}: летите туда (нет маршрута? летите сюда: {area:378} и езжайте на запад через край {zone:1412}), затем дальше сюда: {area:496}.",
	-- ["Zeppelin to {object:3202}"] = "Дирижабль: {object:3202}",
	-- ["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- ["Zeppelin to {zone:1458}"] = "Дирижабль: {zone:1458}",
	-- ["Zeppelin tower"] = "Башня дирижаблей",
	-- ["for the {npc:5598} in the {zone:1425}, around level 48"] = "для персонажа {npc:5598} ({zone:1425}), примерно на 48-м уровне",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "для предмета {object:2555} ({area:15}), позже в этом руководстве",
	-- ["for the {object:2555} in {zone:1445}, later in this guide"] = "для предмета {object:2555} ({zone:1445}), позже в этом руководстве",
	-- ["for the {zone:1425} owlbeasts, around level 48"] = "для совухов ({zone:1425}), примерно на 48-м уровне",
	-- ["for the {zone:1425}, around level 50"] = "для края {zone:1425}, примерно на 50-м уровне",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: убивайте их по пути",
	-- ["{area:2403}: kill these as you meet them"] = "{area:2403}: убивайте их по пути",
	-- ["{area:496} flight master"] = "Распорядитель полетов: {area:496}",
	-- ["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904} – на волновых странников и странников глубин в воде",
	-- ["{item:18958}, from the Sea Sprays"] = "{item:18958} – с морских валов",
	-- ["{npc:2934}, on the way back to Zinge"] = "{npc:2934}, по пути назад к Зинге",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} – элита: лучше собрать группу. Бейте его, пока он не сдастся, затем доложите персонажу {npc:4501}.",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, учитель верховой езды",
	-- ["{npc:5591}, inside"] = "{npc:5591}, внутри",
	-- ["{npc:7776}'s Northspring harpies (48-50) wait for your {zone:1444} visit at about 51: keep the quest."] = "Гарпии Северного Источника (48-50) для NPC {npc:7776} подождут вашего визита сюда: {zone:1444}, примерно на 51-м уровне: сохраните задание.",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
	-- ["{npc:7854}, inside"] = "{npc:7854}, внутри",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: для персонажа {npc:7010} ({zone:1454}), примерно на 50-м уровне",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, затем {object:172960} и {object:172961}.",
	-- ["{quest:7738}, a rare drop"] = "{quest:7738}, редкая добыча",
	-- ["{zone:1435} and Dustwallow first, then {zone:1444}."] = "Сначала {zone:1435} и Пылевые топи, затем {zone:1444}.",
}
