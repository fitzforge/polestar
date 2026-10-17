-- Russian (ruRU): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:2094} James Halloran
	["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} – здесь: {area:2103}; {npc:2094} стоит у северных ворот.",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}"] = "{npc:2104}: для NPC {npc:270637}",

	-- Step 2: Prospector Whelgar
	-- {area:118} Whelgar's Excavation Site
	["Follow the road east to {area:118}."] = "Идите по дороге на восток. Цель: {area:118}.",

	-- Step 3: Goaz Warder
	-- {item:279996} Goaz Stone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Хранители Гоаз стоят чуть западнее лагеря Велгара: используйте рядом с одним из них {item:279996}, полученный от него.",

	-- Step 4: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Новый предмет {item:279996} – для четырех стражей титанов в зоне {zone:1437}",

	-- Step 5: The Green Belt
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Идите по дороге на северо-восток в {area:1025}: рядом с дорогой стоит лагерем {npc:270637}, чуть восточнее – {npc:1244}.",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, элитный ящер",

	-- Step 6: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "На юг, в лагерь клана Драконьей Пасти ({area:1036}): по пути стоит первая катапульта, а {object:671518} лежит в лагере.",
	["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "Следующий шаг, «Убить Нек'роша», сводит вас с элитным вождем: пропустите его.",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: для NPC {npc:2104}",

	-- Step 7: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} стоит на юго-восточных холмах: используйте рядом с ним {item:279996}.",

	-- Step 8: Dragonmaw Gates
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 9: Whelps, raptors and Neru
	-- {npc:271458} Neru
	["Whelps, raptors and {npc:271458}"] = "Дракончики, ящеры и {npc:271458}",
	-- {area:1025} The Green Belt · {npc:271458} Neru · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Красные дракончики – на холмах к западу от ворот, разъяренные гнилокогти – в месте {area:1025}, острозубы – на северных склонах; {npc:271458} стоит на северо-востоке (используйте {item:279996}).\n{quest:98283} – элитное задание: лучше собрать группу.",

	-- Step 10: The Green Belt
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Для короля Магни ({zone:1455}), в конце этого гайда",

	-- Step 11: Dun Modr
	-- {area:205} Dun Modr · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental · {npc:1072} Roggo Harlbarrow
	["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "По дороге на север. Цель: {area:205}. {npc:271460} стоит в руинах (используйте {item:279996}); {npc:271481} заточен на западной стороне: выведите его к NPC {npc:1072}.",

	-- Step 12: The Villards
	["The Villards"] = "Вилларды",
	-- {npc:5683} Comar Villard · {area:205} Dun Modr · {area:881} Thandol Span · {npc:271322} Essene Villard
	["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} ждет к северу (ориентир: {area:205}), у места {area:881}; {npc:271322} – чуть дальше на северо-восток.",

	-- Step 13: Prospector Whelgar
	["Back south down the road to the excavation site."] = "Назад на юг по дороге, к раскопкам.",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Для NPC {npc:2916} ({zone:1455}), в конце этого гайда",

	-- Step 14: Menethil Harbor
	["West along the road to Menethil."] = "По дороге на запад, в Гавань Менетилов.",

	-- Step 15: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Корабль: {area:271}",

	-- Step 16: Southshore
	-- {npc:251493} Captain McManus · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly
	["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Прежде чем уходить, возьмите в городе все задания. Сойдя с корабля, первым вы встретите NPC {npc:251493} к северо-западу от распорядителя полетов; {npc:2381} и {npc:2438} стоят между распорядителем полетов и таверной, Фаррен и {npc:2366} – у таверны, Малеб – в ратуше.",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}: продает {npc:2381}",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: львы будут позже",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, в таверне: для {area:35} (04-stranglethorn-vale)",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: его след ведет в Арати",

	-- Step 17: Torn Fin murlocs
	["Torn Fin murlocs"] = "Мурлоки из племени Рваного Плавника",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Мурлоки из племени Рваного Плавника толпятся здесь: {area:295}, к юго-западу (ориентир: {area:271}).",

	-- Step 18: Farren
	["Farren"] = "Фаррен",

	-- Step 19: Murloc heads
	["Murloc heads"] = "Головы мурлоков",
	["Back to the same murlocs; not every one drops a head."] = "Назад к тем же мурлокам; голова падает не с каждого.",

	-- Step 21: Daggerspine naga
	["Daggerspine naga"] = "Наги из клана Пронзающего Гребня",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Наги занимают берег к юго-востоку (ориентир: {area:271}).",

	-- Step 22: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}"] = "Донесение: {object:2117}",

	-- Step 23: Snapjaws
	["Snapjaws"] = "Хрустогрызы",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Черепахи-хрустогрызы греются у реки к востоку (ориентир: {area:271}), южнее места {area:272} (Орда).",

	-- Step 24: Syndicate camp
	["Syndicate camp"] = "Лагерь Синдиката",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "Лагерь Синдиката – на границе с Альтеракскими горами, на севере области {area:287}, к западу от места {area:272} (Орда); документы лежат в лагере.",

	-- Step 25: Yeti cave
	["Yeti cave"] = "Пещера йети",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Йети живут в пещере на холмах к северу (ориентир: {area:271}), по пути обратно на юг.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} также нужны {item:3719}, {item:2997} и {item:2321}: изготовьте или купите; плащ сдается позже, когда вернетесь сюда: {area:271}.",

	-- Step 26: Hillsbrad's town hall
	-- {area:287} Hillsbrad
	["{area:287}'s town hall"] = "Ратуша: {area:287}",
	-- {area:287} Hillsbrad · {item:279386} Sealed Company Request · {npc:2335} Magistrate Burnside
	["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "На запад к фермам ({area:287}): положите {item:279386} на счетоводный стол в ратуше, где стоят {npc:2335} и члены совета.",
	-- {area:287} Hillsbrad
	["{area:287} town hall"] = "Ратуша: {area:287}",

	-- Step 28: Fly to Stormwind City
	-- {zone:1453} Stormwind City
	["Fly to {zone:1453}"] = "Лететь в {zone:1453}",
	-- {npc:2432} Darla Harris · {area:271} Southshore
	["From {npc:2432} in {area:271}"] = "У NPC {npc:2432} ({area:271})",

	-- Step 29: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "Сырная лавка, район {object:2096}.",

	-- Step 30: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} ждет в таверне «Свинья и свисток» ({object:2100}); он и двое его громил нападут на вас, но после поражения остановятся.",

	-- Step 31: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} обучает воинов ({object:2100}), рядом с таверной «Свинья и свисток». {npc:6236} ждет здесь: {area:720} ({zone:1413}), по пути в {area:392} гораздо позже (40-50/01).",

	-- Step 33: Cathedral of Light
	["Cathedral of Light"] = "Собор Света",

	-- Step 34: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} – здесь: {object:2164}; {npc:211033} – у канала; {npc:5081} – к югу (ориентир: {object:2101}).",

	-- Step 36: Druid training
	["Druid training"] = "Обучение друида",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind City
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "В городе {zone:1455} нет учителя друидов: обучитесь у NPC {npc:5504} в {zone:1453} перед поездом.",

	-- Step 37: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Поезд ({area:2257}) из района {object:28027}. Цель: {zone:1455}.",
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	["Level 30 and 32 spells"] = "Заклинания 30 и 32-го уровней",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Уничтожьте в лагере четыре комплекта планов атаки для задания {quest:98221}.",
	-- ["Fly to {zone:1453}"] = "Лететь: {zone:1453}",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Идите по дороге на северо-восток. Цель: {area:1025}. Рядом с ней стоит лагерем {npc:270637}, чуть восточнее – {npc:1244}.",
	-- ["Golm"] = "Голм",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "На северо-восток. Цель: {area:1038}. Там держат пленников ({npc:271373}), а у ворот стоит {npc:271338} (используйте {item:279996}).",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Красные дракончики – на холмах к западу от ворот, разъяренные гнилокогти – здесь: {area:1025}, острозубы – на северных склонах; Неру стоит на северо-востоке (используйте {item:279996}).\n{quest:98283} – элитное задание: лучше собрать группу.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "На юг, в лагерь клана Драконьей Пасти ({area:1036}); {object:671518} лежит в лагере.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} – здесь: {area:2103}; {npc:2094} и {npc:270844} стоят вместе у северных ворот.",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: для NPC {npc:3649} ({area:442}, 02-desolace)",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "В городе {zone:1455} нет учителя друидов: обучитесь у NPC {npc:5504} ({zone:1453}) перед поездом.",
}
