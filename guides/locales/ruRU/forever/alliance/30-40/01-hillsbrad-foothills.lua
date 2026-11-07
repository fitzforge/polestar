-- Russian (ruRU): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["To {area:2104}"] = "",

	-- Step 2: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}; on the top floor"] = "",

	-- Step 3: Howin Kindfeather
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "Для короля Магни ({zone:1455}), в конце этого гайда",

	-- Step 4: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "На юг, в лагерь клана Драконьей Пасти ({area:1036}): по пути стоит первая катапульта, а {object:671518} лежит в лагере.",

	-- Step 6: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: для NPC {npc:2104}",

	-- Step 7: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "",

	-- Step 8: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462} стоит на юго-восточных холмах: используйте рядом с ним {item:279996}.",

	-- Step 9: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "",
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 11: Dun Modr
	-- {area:205} Dun Modr · {npc:1071} Longbraid the Grim · {npc:1075} Rhag Garmason · {npc:1072} Roggo Harlbarrow · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental
	["North along the road to {area:205}. {npc:1071}, {npc:1075} and {npc:1072} stand together in the dwarves' camp; {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "По дороге на север. Цель: {area:205}. {npc:1071}, {npc:1075} и {npc:1072} стоят вместе в лагере дворфов; {npc:271460} стоит в руинах (используйте {item:279996}); {npc:271481} заточен на западной стороне: выведите его к NPC {npc:1072}.",

	-- Step 12: The Villards
	["The Villards"] = "",
	-- {npc:5683} Comar Villard · {area:205} Dun Modr · {area:880} Thandol Span · {npc:271322} Essene Villard
	["{npc:5683} waits on the road north of {area:205}, towards the {area:880}; {npc:271322} a short walk further north-east."] = "{npc:5683} ждет на дороге к северу (ориентир: {area:205}), в сторону места {area:880}; {npc:271322} – чуть дальше на северо-восток.",

	-- Step 13: Foggy MacKreel
	-- {area:880} Thandol Span · {npc:2696} Foggy MacKreel
	["Over the {area:880}: Ebenezer Rustlocke lies under its Arathi end, {npc:2696} a short walk west of it."] = "Через мост ({area:880}): Эбенезер Ржавый Замок лежит под его арати́йским концом, {npc:2696} – чуть западнее.",
	-- {object:2652} Ebenezer Rustlocke's Corpse
	["{object:2652}, inside"] = "{object:2652}, внутри",

	-- Step 14: Waterlogged Envelope
	["Underwater"] = "",

	-- Step 16: Prospector Whelgar
	["Below ground"] = "",

	-- Step 17: Menethil Harbor
	["West along the road to Menethil."] = "По дороге на запад, в Гавань Менетилов.",
	["On the top floor"] = "",

	-- Step 18: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104} stands on the top floor of {area:2103}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2104} стоит на верхнем этаже ({area:2103}): поднимитесь внутри, стрелка не различает этажи.",

	-- Step 19: Level 31.23
	["Level 31.23"] = "",
	-- {quest:474} Defeat Nek'rosh
	["If you skipped {quest:474}, grind here to level 31.23 to stay on the route's plan."] = "",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "",

	-- Step 21: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "Корабль: {area:271}",

	-- Step 22: Southshore
	-- {npc:2711} Phin Odelic · {npc:2705} Brewmeister Bilger · {npc:2430} Chef Jessen · {npc:2382} Darren Malvew · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti
	["Off the boat, walk up the pier into town: {npc:2711} and Lieutenant Farren stand by the inn, {npc:2705} below it and {npc:2430} upstairs, {npc:2382} east of it; the flight master is at the north end, {npc:2381} and {npc:2438} between her and the inn, Maleb in the town hall at the west side."] = "Сойдя с корабля, поднимитесь по пирсу в город: {npc:2711} и лейтенант Фаррен стоят у таверны, {npc:2705} – под ней, {npc:2430} – наверху, {npc:2382} – к востоку от нее; распорядитель полетов – в северной части, {npc:2381} и {npc:2438} – между ней и таверной, Малеб – в ратуше на западной стороне.",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: его след ведет в Арати",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, в таверне: для {area:35} (04-stranglethorn-vale)",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "{npc:2705}, под землей",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: львы будут позже",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}: продает {npc:2381}",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 23: Torn Fin murlocs
	["Torn Fin murlocs"] = "Мурлоки из племени Рваного Плавника",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "",

	-- Step 24: Farren
	["Farren"] = "Фаррен",
	["Inside"] = "",

	-- Step 25: Murloc heads
	["Murloc heads"] = "Головы мурлоков",
	["Back to the same murlocs; not every one drops a head."] = "Назад к тем же мурлокам; голова падает не с каждого.",

	-- Step 27: Daggerspine naga
	["Daggerspine naga"] = "Наги из клана Пронзающего Гребня",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "Наги занимают берег к юго-востоку (ориентир: {area:271}).",

	-- Step 28: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "",

	-- Step 30: Southshore
	-- {npc:251493} Captain McManus
	["{npc:251493} stands north-west of the flight master, on the way north to the yeti cave."] = "{npc:251493} стоит к северо-западу от распорядителя полетов, по пути на север к пещере йети.",

	-- Step 31: Yeti cave
	["Yeti cave"] = "Пещера йети",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on the way north to the Syndicate camp."] = "Йети живут в пещере на холмах к северу (ориентир: {area:271}), по пути на север к лагерю Синдиката.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438} также нужны {item:3719}, {item:2997} и {item:2321}: изготовьте или купите; плащ сдается позже, когда вернетесь сюда: {area:271}.",

	-- Step 33: Syndicate camp
	["Syndicate camp"] = "Лагерь Синдиката",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp, and its Footpads and Thieves are the Syndicate Maleb wants."] = "Лагерь Синдиката – на границе с Альтеракскими горами, на севере области {area:287}, к западу от места {area:272} (Орда); документы лежат в лагере, а его разбойники и воры – это те члены Синдиката, которые нужны Малебу.",

	-- Step 34: Snapjaws
	["Snapjaws"] = "Хрустогрызы",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "Черепахи-хрустогрызы греются у реки к востоку (ориентир: {area:271}), южнее места {area:272} (Орда).",

	-- Step 37: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:271} Southshore
	["{area:271} flight master"] = "",

	-- Step 38: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "Поезд ({area:2257}) из района {object:28027}. Цель: {zone:1455}.",
	["Level 30 and 32 spells"] = "Заклинания 30 и 32-го уровней",

	-- Step 41: Deeprun Tram
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "",

	-- Step 43: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Лететь в {zone:1453}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 44: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479} обучает воинов ({object:2100}), рядом с таверной «Свинья и свисток». {npc:6236} ждет здесь: {area:720} ({zone:1413}), по пути в {area:392} гораздо позже (40-50/01).",

	-- Step 45: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "Сырная лавка, район {object:2096}.",

	-- Step 46: Druid training
	["Druid training"] = "Обучение друида",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "В городе {zone:1455} нет учителя друидов: обучитесь у NPC {npc:5504} в {zone:1453} перед поездом.",

	-- Step 48: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961} ждет в таверне «Свинья и свисток» ({object:2100}); он и двое его громил нападут на вас, но после поражения остановятся.",

	-- Step 50: Cathedral of Light
	["Cathedral of Light"] = "Собор Света",

	-- Step 52: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708} – здесь: {object:2164}; {npc:211033} – у канала; {npc:5081} – к югу (ориентир: {object:2101}).",
	-- {npc:211033} Garion Wendell
	-- plural, as words: Library Books = {object:386691} Library Book
	["{npc:211033}: only offered once you have handed in library books (the Library Books guide)"] = "",

	-- Step 54: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "Новый предмет {item:279996} – для четырех стражей титанов в зоне {zone:1437}",
	-- ["A report for {object:2117}"] = "Донесение: {object:2117}",
	-- ["Back south down the road to the excavation site."] = "Назад на юг по дороге, к раскопкам.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "Уничтожьте в лагере четыре комплекта планов атаки для задания {quest:98221}.",
	-- ["Fly to {zone:1453}"] = "Лететь: {zone:1453}",
	-- ["Follow the road east to {area:118}."] = "Идите по дороге на восток. Цель: {area:118}.",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "Идите по дороге на северо-восток в {area:1025}: рядом с дорогой стоит лагерем {npc:270637}, чуть восточнее – {npc:1244}.",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "Для NPC {npc:2916} ({zone:1455}), в конце этого гайда",
	-- ["From {npc:2432} in {area:271}"] = "У NPC {npc:2432} ({area:271})",
	-- ["Golm"] = "Голм",
	-- ["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "По дороге на север. Цель: {area:205}. {npc:271460} стоит в руинах (используйте {item:279996}); {npc:271481} заточен на западной стороне: выведите его к NPC {npc:1072}.",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "На северо-восток. Цель: {area:1038}. Там держат пленников ({npc:271373}), а у ворот стоит {npc:271338} (используйте {item:279996}).",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "Прежде чем уходить, возьмите в городе все задания. Сойдя с корабля, первым вы встретите NPC {npc:251493} к северо-западу от распорядителя полетов; {npc:2381} и {npc:2438} стоят между распорядителем полетов и таверной, Фаррен и {npc:2366} – у таверны, Малеб – в ратуше.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Красные дракончики – на холмах к западу от ворот, разъяренные гнилокогти – здесь: {area:1025}, острозубы – на северных склонах; Неру стоит на северо-востоке (используйте {item:279996}).\n{quest:98283} – элитное задание: лучше собрать группу.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "Красные дракончики – на холмах к западу от ворот, разъяренные гнилокогти – в месте {area:1025}, острозубы – на северных склонах; {npc:271458} стоит на северо-востоке (используйте {item:279996}).\n{quest:98283} – элитное задание: лучше собрать группу.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "На юг, в лагерь клана Драконьей Пасти ({area:1036}); {object:671518} лежит в лагере.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Хранители Гоаз стоят чуть западнее лагеря Велгара: используйте рядом с одним из них {item:279996}, полученный от него.",
	-- ["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "Лагерь Синдиката – на границе с Альтеракскими горами, на севере области {area:287}, к западу от места {area:272} (Орда); документы лежат в лагере.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "Мурлоки из племени Рваного Плавника толпятся здесь: {area:295}, к юго-западу (ориентир: {area:271}).",
	-- ["The Villards"] = "Вилларды",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "Следующий шаг, «Убить Нек'роша», сводит вас с элитным вождем: пропустите его.",
	-- ["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "Йети живут в пещере на холмах к северу (ориентир: {area:271}), по пути обратно на юг.",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "На запад к фермам ({area:287}): положите {item:279386} на счетоводный стол в ратуше, где стоят {npc:2335} и члены совета.",
	-- ["Whelps, raptors and {npc:271458}"] = "Дракончики, ящеры и {npc:271458}",
	-- ["{area:287} town hall"] = "Ратуша: {area:287}",
	-- ["{area:287}'s town hall"] = "Ратуша: {area:287}",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, элитный ящер",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104} – здесь: {area:2103}; {npc:2094} и {npc:270844} стоят вместе у северных ворот.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104} – здесь: {area:2103}; {npc:2094} стоит у северных ворот.",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}: для NPC {npc:270637}",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: для NPC {npc:3649} ({area:442}, 02-desolace)",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683} ждет к северу (ориентир: {area:205}), у места {area:881}; {npc:271322} – чуть дальше на северо-восток.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "В городе {zone:1455} нет учителя друидов: обучитесь у NPC {npc:5504} ({zone:1453}) перед поездом.",
}
