-- Russian (ruRU): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 2: Apothecary Zinge
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "",

	-- Step 3: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Верховая езда на 40-м уровне",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, учитель верховой езды",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Кони-скелеты: {npc:4731}, рядом с персонажем {npc:4773} ({area:159}).",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "Дирижабль: {object:3202}",

	-- Step 6: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Летите сюда: {area:75}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 7: Stonard
	-- {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 8: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Езжайте на запад по дороге; свиток лежит у кромки воды на дальнем западе болота.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "для предмета {object:2555} ({zone:1445}), позже в этом руководстве",

	-- Step 9: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Острозубые кроколиски",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "",

	-- Step 10: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Назад на восток мимо места {area:75}: артефакты Атал'ай лежат в воде и на берегах (задание: {quest:1424}).",

	-- Step 11: Misty Reed Post
	-- {npc:5592} Tok'Kar
	["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "",

	-- Step 12: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too."] = "",
	["Underwater"] = "",

	-- Step 14: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Мурлоки Тростникового берега",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Болотные мурлоки живут на берегу к югу от лагеря; чернильщики – вдоль берега к востоку, а трупоеды – дальше к западу, у хижин на западном берегу.",
	["Below ground"] = "",

	-- Step 16: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "",

	-- Step 18: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "для персонажа {npc:5598} ({zone:1425}), примерно на 48-м уровне",

	-- Step 19: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "",

	-- Step 20: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "для совухов ({zone:1425}), примерно на 48-м уровне",

	-- Step 21: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 22: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "",

	-- Step 23: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "",

	-- Step 24: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "",

	-- Step 25: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "",

	-- Step 26: Brackenwall Village
	["Ride back north to Brackenwall."] = "Возвращайтесь на север в Гиблотопь.",

	-- Step 27: Onyxia's eggs
	["Onyxia's eggs"] = "Яйца Ониксии",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Яйца Ониксии лежат в драконьих пещерах на юго-востоке ({area:511}) под охраной чешуйчатых губителей; разбейте пять.",
	["Dragon caves"] = "Драконьи пещеры",

	-- Step 29: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "",

	-- Step 30: Level 45.41
	["Level 45.41"] = "",
	-- {quest:1173} Challenge Overlord Mok'Morokk · {area:978} Zul'Farrak · {area:1517} Uldaman
	["If you skipped {quest:1173}, grind here to level 45.41 to stay on the route's plan. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "",

	-- Step 31: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Летите сюда: {area:1099}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 32: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Летучие хамелеоны и лесные древни",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "Летучие хамелеоны порхают над рощей чуть к западу от лагеря; у них – {item:9589}; у бродячих лесных древней чуть дальше к западу – расколотые бревна.",

	-- Step 33: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Блеклоперые гиппогрифы",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "К югу от долины на склонах гнездятся блеклоперые гиппогрифы; почти с каждого падают сухожилия и металлические осколки.",

	-- Step 34: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Езжайте на северо-запад сюда: {area:1108}; {npc:14637} ждет на причале.",

	-- Step 35: Rogue Vale screechers
	["Rogue Vale screechers"] = "Крикуны Разбойничьей долины",
	-- {npc:14637} Zorbin Fandazzle · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "",

	-- Step 36: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Морские элементали и морские валы бродят по берегу у причала. Сначала уменьшите великанов предметом {item:18904}: уменьшенные, они теряют силу элиты. Береговые странники бродят в воде; сухопутные бродяги и скальные великаны – на холмах дальше к северу.",

	-- Step 37: Northspring harpies
	["Northspring harpies"] = "Гарпии Студеных Ключей",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Гарпии из стаи Студеных Ключей гнездятся на хребтах на дальнем северо-западе. Они 48-50 уровня, на несколько уровней выше вас: призывательницы ветров лечат – убивайте их первыми и выманивайте по одной.",

	-- Step 38: Rage Scar yetis
	["Rage Scar yetis"] = "Йети Бешеного оврага",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "На обратном пути от гарпий на юго-восток, у пещер в холмах у дороги живут йети Бешеного оврага. С любого может также упасть {quest:7738} – это начинает отдельное задание.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, редкая добыча",

	-- Step 39: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {object:3202}"] = "Летите сюда: {object:3202}",
	-- ["Forest walkers"] = "Лесные древни",
	-- ["Monstrous Crawlers"] = "Чудовищные крабы",
	-- ["Murlocs of the Misty Reed"] = "Мурлоки Тростникового берега",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "На северо-запад по дороге, у пещер в холмах живут йети Бешеного оврага. С любого может также упасть {quest:7738} – это начинает отдельное задание.",
	-- ["Northspring harpies"] = "Гарпии Студеных Ключей",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Возвращайтесь на восток в лагерь. Оставайтесь здесь: следующее руководство начинается с полета сюда: {area:976}.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Езжайте на юго-запад к предмету {object:2555}, затем на восток через место {area:511}. Огнегривые разведчики и пеплохвосты бродят по его северному краю вместе с опаляющими малышами дракона и дракончиками; чешуйчатые губители охраняют драконьи пещеры дальше к юго-востоку. Понюшка, грог и сейф Мок'Морокка лежат в лагерях драконидов.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "К юго-западу йети живут здесь: {area:1105}; толстая шкура может упасть с любого йети.",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Болотные мурлоки живут на берегу к югу от лагеря; чернильщики – вдоль берега к востоку, а трупоеды – дальше к западу, у хижин на западном берегу.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Чудовищные крабы редко встречаются на пляжах восточного побережья: убивайте каждого, кого встретите по пути на юг.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Гарпии из стаи Студеных Ключей гнездятся на хребтах на дальнем северо-западе. Они 48-50 уровня, на несколько уровней выше вас: призывательницы ветров лечат – убивайте их первыми и выманивайте по одной.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Снова те же мурлоки, плюс оракулы – они держатся у хижин на западном берегу.",
	-- ["The small Horde post on the southern shore."] = "Небольшой лагерь Орды на южном берегу.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "Дирижабль ({zone:1454}) отправляется с башни у лагеря {object:3202}; он причаливает чуть к северо-востоку от главных ворот ({zone:1454}).",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Вы начинаете здесь: {area:75}. Привяжите камень возвращения: после побережья вы вернетесь сюда.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Ваш учитель – в городе {area:1638}: летите туда (нет маршрута? летите сюда: {area:378} и езжайте на запад через край {zone:1412}), затем дальше сюда: {area:496}.",
	-- ["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- ["Zeppelin tower"] = "Башня дирижаблей",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "для предмета {object:2555} ({area:15}), позже в этом руководстве",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} – элита: лучше собрать группу. Бейте его, пока он не сдастся, затем доложите персонажу {npc:4501}.",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: для персонажа {npc:7010} ({zone:1454}), примерно на 50-м уровне",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, затем {object:172960} и {object:172961}.",
}
