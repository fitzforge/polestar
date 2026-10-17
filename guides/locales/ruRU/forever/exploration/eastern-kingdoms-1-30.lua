-- Russian (ruRU): the guide forever/exploration/eastern-kingdoms-1-30 (forever/exploration/eastern-kingdoms-1-30.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 1-30"] = "Исследование: {zone:1415} 1-30",

	-- Step 1: Elwynn Forest (1/2)
	-- {zone:1429} Elwynn Forest · {zone:1426} Dun Morogh
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Alliance starts in {zone:1429}; dwarves and gnomes can begin at the {zone:1426} step. 12 areas to discover here, levels 5-10."] = "Открытие местности дает опыт по ее уровню, так что это идет параллельно с прокачкой. Альянс начинает в зоне {zone:1429}; дворфы и гномы могут начать с шага «{zone:1426}». Местностей для открытия здесь: 12, уровни 5-10.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Исследование всей карты мира одним персонажем — испытание наследия Forever (Forever Legacy Challenge; 1 очко наследия на всю учетную запись).",
	-- {area:9} Northshire Valley · {zone:1429} Elwynn Forest · {area:87} Goldshire
	["{area:9} opens onto {zone:1429}; {area:87} is south down the road."] = "{area:9} выходит в {zone:1429}; {area:87} — на юг по дороге.",

	-- Step 2: Elwynn Forest (2/2)
	["any one of these names counts"] = "подойдет любое из этих названий",

	-- Step 3: Westfall (1/2)
	["14 areas to discover here, levels 9-18."] = "Местностей для открытия здесь: 14, уровни 9-18.",
	-- {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:120} Westbrook Garrison
	["{zone:1436} borders {zone:1429} to the west: follow the road out past the {area:120}."] = "{zone:1436} граничит с зоной {zone:1429} на западе: идите по дороге мимо места {area:120}.",
	-- {area:108} Sentinel Hill
	["Flight path here: {area:108} (Thor)."] = "Маршрут полета здесь: {area:108} (Тор).",

	-- Step 5: Duskwood (1/2)
	["13 areas to discover here, levels 10-30."] = "Местностей для открытия здесь: 13, уровни 10-30.",
	-- {zone:1431} Duskwood · {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:42} Darkshire
	["{zone:1431} is east of {zone:1436} and south of {zone:1429}. Its road runs east to {area:42}."] = "{zone:1431} — к востоку от зоны {zone:1436} и к югу от {zone:1429}. Дорога ведет на восток в {area:42}.",
	-- {area:42} Darkshire · {npc:2409} Felicia Maline
	["Flight path here: {area:42} ({npc:2409})."] = "Маршрут полета здесь: {area:42} ({npc:2409}).",

	-- Step 7: Redridge Mountains (1/2)
	["11 areas to discover here, levels 15-24."] = "Местностей для открытия здесь: 11, уровни 15-24.",
	-- {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood
	["Redridge starts at {area:1002}, where the roads from {zone:1429} and {zone:1431} meet."] = "Красногорье начинается здесь: {area:1002}, где сходятся дороги из зон {zone:1429} и {zone:1431}.",
	-- {area:69} Lakeshire · {npc:931} Ariena Stormfeather
	["Flight path here: {area:69} ({npc:931})."] = "Маршрут полета здесь: {area:69} ({npc:931}).",

	-- Step 9: Dun Morogh (1/3)
	["18 areas to discover here, levels 4-12."] = "Местностей для открытия здесь: 18, уровни 4-12.",
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind City · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "Поезжайте на поезде ({area:2257}) из места {object:28027} {zone:1453} в {zone:1455} (или летите в {zone:1455}), затем выйдите из города через ворота.",

	-- Step 12: Loch Modan (1/2)
	["11 areas to discover here, levels 10-18."] = "Местностей для открытия здесь: 11, уровни 10-18.",
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:925} Algaz Station
	["Leave {zone:1426} east through the gate tunnel; it opens into {zone:1432} at {area:925}."] = "Выйдите из зоны {zone:1426} на восток через туннель у ворот; он выводит в {zone:1432} у места {area:925}.",
	-- {area:144} Thelsamar · {npc:1572} Thorgrum Borrelson
	["Flight path here: {area:144} ({npc:1572})."] = "Маршрут полета здесь: {area:144} ({npc:1572}).",

	-- Step 14: Wetlands (1/2)
	["15 areas to discover here, levels 20-30."] = "Местностей для открытия здесь: 15, уровни 20-30.",
	-- {area:925} Algaz Station · {area:836} Dun Algaz · {zone:1437} Wetlands
	["From {area:925}, the road north through the {area:836} pass leads into the {zone:1437}."] = "Из места {area:925} дорога на север через перевал ({area:836}) ведет в {zone:1437}.",
	-- {area:150} Menethil Harbor · {npc:1571} Shellei Brondir
	["Flight path here: {area:150} ({npc:1571})."] = "Маршрут полета здесь: {area:150} ({npc:1571}).",
	-- {area:1038} Dragonmaw Gates · {area:1037} Grim Batol
	["the discovery triggers at the {area:1038}: do not go into {area:1037} itself"] = "открытие срабатывает здесь: {area:1038}; не заходите внутрь: {area:1037}",

	-- Step 16: Hillsbrad Foothills (1/2)
	["12 areas to discover here, levels 20-31."] = "Местностей для открытия здесь: 12, уровни 20-31.",
	-- {area:881} Thandol Span · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {zone:1424} Hillsbrad Foothills
	["Cross the {area:881} in northern {zone:1437} into the {zone:1417} (level 30+ creatures off the road), follow the road west past {area:320} and on into {zone:1424}."] = "Перейдите {area:881} на севере зоны {zone:1437} в {zone:1417} (вне дороги существа 30+ уровня), идите по дороге на запад мимо места {area:320} и дальше в {zone:1424}.",
	-- {area:271} Southshore · {npc:2432} Darla Harris
	["Flight path here: {area:271} ({npc:2432})."] = "Маршрут полета здесь: {area:271} ({npc:2432}).",
	-- {area:272} Tarren Mill
	["Horde guards: touch the edge of {area:272} and move on"] = "Стража Орды: коснитесь края места {area:272} и идите дальше",

	-- Step 18: Silverpine Forest (1/2)
	["15 areas to discover here, levels 10-20."] = "Местностей для открытия здесь: 15, уровни 10-20.",
	-- {area:287} Hillsbrad · {area:285} Southpoint Tower · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["Follow the road west from {area:287} past {area:285} into {zone:1421}, Horde country with Horde guards at the {area:228}."] = "Идите по дороге на запад из места {area:287} мимо места {area:285} в {zone:1421} — земли Орды, со стражей Орды здесь: {area:228}.",
	-- {area:228} Sepulcher
	["Horde guards: touch the edge of {area:228} and move on"] = "Стража Орды: коснитесь края места {area:228} и идите дальше",

	-- Step 20: Tirisfal Glades (1/3)
	["17 areas to discover here, levels 5-10."] = "Местностей для открытия здесь: 17, уровни 5-10.",
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {area:154} Deathknell · {zone:1458} Undercity
	["Silverpine's road north leads into {zone:1420}. {area:159}, {area:154} and the {zone:1458} ruins are Horde ground."] = "Дорога Серебряного бора на север ведет в {zone:1420}. {area:159}, {area:154} и руины у города {zone:1458} — земли Орды.",
	-- {area:153} Ruins of Lordaeron
	["Horde guards: touch the edge of {area:153} and move on"] = "Стража Орды: коснитесь края места {area:153} и идите дальше",

	-- Step 21: Tirisfal Glades (2/3)
	-- {area:159} Brill
	["Horde guards: touch the edge of {area:159} and move on"] = "Стража Орды: коснитесь края места {area:159} и идите дальше",

	-- Step 22: Tirisfal Glades (3/3)
	-- {area:154} Deathknell
	["Horde guards: touch the edge of {area:154} and move on"] = "Стража Орды: коснитесь края места {area:154} и идите дальше",

	-- Step 23: Tirisfal Glades (1/3)
	-- {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Horde starts in {zone:1420}; orcs, trolls and tauren arrive by zeppelin from {zone:1454}. 17 areas to discover here, levels 5-10."] = "Открытие местности дает опыт по ее уровню, так что это идет параллельно с прокачкой. Орда начинает в зоне {zone:1420}; орки, тролли и таурены прилетают на дирижабле из города {zone:1454}. Местностей для открытия здесь: 17, уровни 5-10.",
	-- {area:154} Deathknell · {zone:1420} Tirisfal Glades · {area:159} Brill · {zone:1458} Undercity
	["{area:154} opens onto {zone:1420}; {area:159} is east along the road. Orcs, trolls and tauren arrive at the zeppelin tower by the {zone:1458}."] = "{area:154} выходит в {zone:1420}; {area:159} — на восток по дороге. Орки, тролли и таурены прилетают к башне дирижаблей у города {zone:1458}.",

	-- Step 26: Silverpine Forest (1/2)
	-- {zone:1421} Silverpine Forest · {zone:1420} Tirisfal Glades · {area:159} Brill
	["{zone:1421} is south of {zone:1420}: follow the road south from {area:159}."] = "{zone:1421} — к югу от зоны {zone:1420}: идите по дороге на юг из места {area:159}.",
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["Flight path here: {area:228} ({npc:2226})."] = "Маршрут полета здесь: {area:228} ({npc:2226}).",

	-- Step 28: Hillsbrad Foothills (1/2)
	-- {zone:1424} Hillsbrad Foothills · {area:285} Southpoint Tower · {area:272} Tarren Mill · {area:271} Southshore
	["At the south end of Silverpine the road turns east into {zone:1424} by {area:285}. {area:272} in the north-east is the Horde town; {area:271} is Alliance."] = "В южном конце Серебряного бора дорога поворачивает на восток в {zone:1424} у места {area:285}. {area:272} на северо-востоке — городок Орды; {area:271} — Альянса.",
	-- {area:272} Tarren Mill
	["Flight path here: {area:272} (Zarise)."] = "Маршрут полета здесь: {area:272} (Зарисса).",

	-- Step 29: Hillsbrad Foothills (2/2)
	-- {area:271} Southshore
	["Alliance guards: touch the edge of {area:271} and move on"] = "Стража Альянса: коснитесь края места {area:271} и идите дальше",

	-- Step 30: Wetlands (1/2)
	-- {area:287} Hillsbrad · {zone:1417} Arathi Highlands · {area:881} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["Walk east from {area:287} into the {zone:1417} (level 30+ creatures off the road), south to the {area:881} bridge, and across it into the {zone:1437}. {area:150} is an Alliance town."] = "Идите на восток из места {area:287} в {zone:1417} (вне дороги существа 30+ уровня), на юг к мосту ({area:881}) и по нему в {zone:1437}. {area:150} — городок Альянса.",

	-- Step 31: Wetlands (2/2)
	-- {area:150} Menethil Harbor
	["Alliance guards: touch the edge of {area:150} and move on"] = "Стража Альянса: коснитесь края места {area:150} и идите дальше",

	-- Step 32: Loch Modan (1/2)
	-- {area:836} Dun Algaz · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:925} Algaz Station
	["The {area:836} pass in south-eastern {zone:1437} leads down into {zone:1432} by {area:925}."] = "Перевал {area:836} на юго-востоке зоны {zone:1437} ведет вниз в {zone:1432} у места {area:925}.",

	-- Step 33: Loch Modan (2/2)
	-- {area:144} Thelsamar
	["Alliance guards: touch the edge of {area:144} and move on"] = "Стража Альянса: коснитесь края места {area:144} и идите дальше",

	-- Step 34: Dun Morogh (1/3)
	-- {area:925} Algaz Station · {zone:1426} Dun Morogh · {area:131} Kharanos · {zone:1455} Ironforge
	["From {area:925} take the tunnel west into {zone:1426}. {area:131} and {zone:1455}'s gates are Alliance ground."] = "Из места {area:925} идите по туннелю на запад в {zone:1426}. {area:131} и ворота города {zone:1455} — земли Альянса.",

	-- Step 35: Dun Morogh (2/3)
	-- {area:809} Gates of Ironforge
	["Alliance guards: touch the edge of {area:809} and move on; any one of these names counts"] = "Стража Альянса: коснитесь края места {area:809} и идите дальше; подойдет любое из этих названий",
	-- {area:131} Kharanos
	["Alliance guards: touch the edge of {area:131} and move on"] = "Стража Альянса: коснитесь края места {area:131} и идите дальше",

	-- Step 36: Dun Morogh (3/3)
	-- {area:132} Coldridge Valley
	["Alliance guards: touch the edge of {area:132} and move on; any one of these names counts"] = "Стража Альянса: коснитесь края места {area:132} и идите дальше; подойдет любое из этих названий",

	-- Step 37: Duskwood (1/2)
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:117} Grom'gol Base Camp · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	["Hearth or fly back to the {zone:1458} (or go to {zone:1454}), take the zeppelin to {area:117} in {zone:1434} and walk north along the road into {zone:1431}. Northern Stranglethorn is level 30+ off the road."] = "Используйте Камень возвращения или летите обратно в {zone:1458} (или в {zone:1454}), летите на дирижабле в {area:117} ({zone:1434}) и идите по дороге на север в {zone:1431}. Север Тернистой долины вне дороги — 30+ уровень.",
	-- {area:42} Darkshire
	["Alliance guards: touch the edge of {area:42} and move on"] = "Стража Альянса: коснитесь края места {area:42} и идите дальше",

	-- Step 39: Westfall (1/2)
	-- {zone:1436} Westfall · {zone:1431} Duskwood · {area:108} Sentinel Hill
	["{zone:1436} borders {zone:1431} to the west. {area:108} is an Alliance town."] = "{zone:1436} граничит с зоной {zone:1431} на западе. {area:108} — городок Альянса.",

	-- Step 40: Westfall (2/2)
	-- {area:108} Sentinel Hill
	["Alliance guards: touch the edge of {area:108} and move on"] = "Стража Альянса: коснитесь края места {area:108} и идите дальше",

	-- Step 41: Elwynn Forest (1/2)
	["12 areas to discover here, levels 5-10."] = "Местностей для открытия здесь: 12, уровни 5-10.",
	-- {zone:1429} Elwynn Forest · {zone:1436} Westfall · {zone:1431} Duskwood · {area:87} Goldshire · {area:9} Northshire Valley · {zone:1453} Stormwind City
	["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429} — к северу от зон {zone:1436} и {zone:1431}. {area:87}, {area:9} и ворота {zone:1453} — земли Альянса со стражей.",
	-- {zone:1453} Stormwind City
	["Alliance guards: touch the edge of {zone:1453} and move on; any one of these names counts"] = "Стража Альянса: коснитесь края: {zone:1453}, и идите дальше; подойдет любое из этих названий",
	-- {area:9} Northshire Valley
	["Alliance guards: touch the edge of {area:9} and move on"] = "Стража Альянса: коснитесь края места {area:9} и идите дальше",
	-- {area:87} Goldshire
	["Alliance guards: touch the edge of {area:87} and move on"] = "Стража Альянса: коснитесь края места {area:87} и идите дальше",

	-- Step 43: Redridge Mountains (1/2)
	-- {zone:1429} Elwynn Forest · {area:1002} Three Corners · {area:69} Lakeshire
	["Go east through {zone:1429} to {area:1002}, where Redridge starts. {area:69} is an Alliance town."] = "Идите на восток через {zone:1429} к месту {area:1002}, где начинается Красногорье. {area:69} — городок Альянса.",
	-- {area:69} Lakeshire
	["Alliance guards: touch the edge of {area:69} and move on"] = "Стража Альянса: коснитесь края места {area:69} и идите дальше",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Flight path here: {area:228} ({npc:2226})."] = "Маршрут полета здесь: {area:228} ({npc:2226}).",
	-- ["Horde guards: touch the edge of {area:228} and move on"] = "Стража Орды: коснитесь края места {area:228} и идите дальше",
	-- ["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "Поезжайте на поезде ({area:2257}) из места {object:28027} ({zone:1453}) в {zone:1455} (или летите в {zone:1455}), затем выйдите из города через ворота.",
	-- ["The {area:228}"] = "{area:228}",
	-- ["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429} — к северу от зон {zone:1436} и {zone:1431}. {area:87}, {area:9} и ворота города {zone:1453} — земли Альянса со стражей.",
}
