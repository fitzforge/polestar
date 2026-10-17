-- Russian (ruRU): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stonard
	-- {area:75} Stonard
	["You start in {area:75}. Bind here: you hearth back after the coast."] = "Вы начинаете здесь: {area:75}. Привяжите камень возвращения: после побережья вы вернетесь сюда.",

	-- Step 2: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Езжайте на запад по дороге; свиток лежит у кромки воды на дальнем западе болота.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "для предмета {object:2555} ({zone:1445}), позже в этом руководстве",

	-- Step 3: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "Назад на восток мимо места {area:75}: артефакты Атал'ай лежат в воде и на берегах (задание: {quest:1424}).",

	-- Step 4: Monstrous Crawlers
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["Monstrous Crawlers"] = "Чудовищные крабы",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Чудовищные крабы редко встречаются на пляжах восточного побережья: убивайте каждого, кого встретите по пути на юг.",

	-- Step 5: Misty Reed Post
	["The small Horde post on the southern shore."] = "Небольшой лагерь Орды на южном берегу.",

	-- Step 6: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Мурлоки Тростникового берега",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Болотные мурлоки живут на берегу к югу от лагеря; чернильщики – вдоль берега к востоку, а трупоеды – дальше к западу, у хижин на западном берегу.",

	-- Step 8: Continued Threat
	["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Снова те же мурлоки, плюс оракулы – они держатся у хижин на западном берегу.",

	-- Step 10: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "для персонажа {npc:5598} ({zone:1425}), примерно на 48-м уровне",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите сюда: {object:3202}",

	-- Step 12: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "Дирижабль ({zone:1454}) отправляется с башни у лагеря {object:3202}; он причаливает чуть к северо-востоку от главных ворот ({zone:1454}).",
	["Zeppelin tower"] = "Башня дирижаблей",

	-- Step 13: Orgrimmar
	-- {object:172958} Valley of Honor · {object:172960} Cleft of Shadow · {object:172961} Valley of Spirits
	["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, затем {object:172960} и {object:172961}.",

	-- Step 14: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:496} Brackenwall Village
	["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Ваш учитель – в городе {area:1638}: летите туда (нет маршрута? летите сюда: {area:378} и езжайте на запад через край {zone:1412}), затем дальше сюда: {area:496}.",

	-- Step 16: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {object:2555} Musty Scroll · {area:511} Wyrmbog
	["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Езжайте на юго-запад к предмету {object:2555}, затем на восток через место {area:511}. Огнегривые разведчики и пеплохвосты бродят по его северному краю вместе с опаляющими малышами дракона и дракончиками; чешуйчатые губители охраняют драконьи пещеры дальше к юго-востоку. Понюшка, грог и сейф Мок'Морокка лежат в лагерях драконидов.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",

	-- Step 17: Brackenwall Village
	["Ride back north to Brackenwall."] = "Возвращайтесь на север в Гиблотопь.",

	-- Step 18: Onyxia's eggs
	["Onyxia's eggs"] = "Яйца Ониксии",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Яйца Ониксии лежат в драконьих пещерах на юго-востоке ({area:511}) под охраной чешуйчатых губителей; разбейте пять.",
	["Dragon caves"] = "Драконьи пещеры",

	-- Step 20: Challenge Overlord Mok'Morokk
	-- {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} – элита: лучше собрать группу. Бейте его, пока он не сдастся, затем доложите персонажу {npc:4501}.",

	-- Step 21: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "для совухов ({zone:1425}), примерно на 48-м уровне",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: для персонажа {npc:7010} ({zone:1454}), примерно на 50-м уровне",

	-- Step 22: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Летучие хамелеоны и лесные древни",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "Летучие хамелеоны порхают над рощей чуть к западу от лагеря; у них – {item:9589}; у бродячих лесных древней чуть дальше к западу – расколотые бревна.",
	["Forest walkers"] = "Лесные древни",

	-- Step 23: Feral Scar Vale
	-- {area:1105} Feral Scar Vale
	["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "К юго-западу йети живут здесь: {area:1105}; толстая шкура может упасть с любого йети.",

	-- Step 24: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Блеклоперые гиппогрифы",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "К югу от долины на склонах гнездятся блеклоперые гиппогрифы; почти с каждого падают сухожилия и металлические осколки.",

	-- Step 25: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Езжайте на северо-запад сюда: {area:1108}; {npc:14637} ждет на причале.",

	-- Step 26: Forgotten Coast
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Морские элементали и морские валы бродят по берегу у причала. Сначала уменьшите великанов предметом {item:18904}: уменьшенные, они теряют силу элиты. Береговые странники бродят в воде; сухопутные бродяги и скальные великаны – на холмах дальше к северу.",

	-- Step 28: Northspring harpies
	["Northspring harpies"] = "Гарпии Студеных Ключей",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "Гарпии из стаи Студеных Ключей гнездятся на хребтах на дальнем северо-западе. Они 48-50 уровня, на несколько уровней выше вас: призывательницы ветров лечат – убивайте их первыми и выманивайте по одной.",

	-- Step 30: Rage Scar yetis
	["Rage Scar yetis"] = "Йети Бешеного оврага",
	-- {quest:7738} Perfect Yeti Hide
	["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "На северо-запад по дороге, у пещер в холмах живут йети Бешеного оврага. С любого может также упасть {quest:7738} – это начинает отдельное задание.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, редкая добыча",

	-- Step 31: Camp Mojache
	-- {area:976} Gadgetzan
	["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Возвращайтесь на восток в лагерь. Оставайтесь здесь: следующее руководство начинается с полета сюда: {area:976}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1108}"] = "{area:1108}",
}
