-- Russian (ruRU): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows · {object:3202} Grom'gol · {area:35} Booty Bay · {area:75} Stonard
	["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "{zone:1434} и {zone:1435} на 40-43-м уровне: {object:3202}, пираты ({area:35}), охота Эрнестуэя и {area:75}.",

	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Летите сюда: {area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "Ваше обучение на 40-м уровне – здесь: {area:1497}. Летите туда из места {area:340}, обучитесь и сядьте на дирижабль у башен за городом до места {object:3202}.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Распорядитель полетов: {area:340}",

	-- Step 2: Undercity trainers
	-- {area:1497} Undercity
	["{area:1497} trainers"] = "Учителя: {area:1497}",

	-- Step 3: Riding at 40
	["Riding at 40"] = "Верховая езда на 40-м",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Верховая езда требует 40-го уровня и стоит 100 золотых; при обучении вы получаете ездовое животное. Каждая раса учится у учителя своей расы: ваш – {npc:4773} ({area:159}), недалеко к северу от башен дирижаблей, рядом кони-скелеты NPC {npc:4731} (по 20 золотых). Вернитесь к башням, чтобы сесть на дирижабль до места {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, учитель верховой езды",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Кони-скелеты: {npc:4731}, рядом с NPC {npc:4773} ({area:159}).",

	-- Step 4: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "Дирижабль: {object:3202}",

	-- Step 5: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите сюда: {object:3202}",

	-- Step 6: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "",

	-- Step 7: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Тропические ловцы",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Тропические ловцы (40-41) охотятся на побережье к югу от места {object:3202}. Они намного выше вас: выманивайте по одному и отдыхайте между боями.",

	-- Step 9: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Летите: {area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Грингер, распорядитель полетов, ждет на верхней палубе ({area:35}). Персонажи с заданиями стоят на мостках вокруг гавани и в таверне.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}: {npc:2635} греется на побережье между Зул'Кундой и местом {object:3202}, позже на этом круге",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, на пристани: письмо Газлоу, если оно у вас есть",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, на балконе рядом с Мак-Кинли",
	["Inside"] = "Внутри",

	-- Step 11: Baron Revilgaz
	-- {npc:2496} Baron Revilgaz · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "{npc:2496}, на балконе рядом с Мак-Кинли, дает еще одно поручение: чертежи регулятора топлива из сундучка Козла нужно отнести Поззику ({area:2240}), по пути в {zone:1446} примерно на 43-м уровне.",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Выйдите из города через туннель; записка лежит в пиратской бухте чуть к северу от места {area:35}.",

	-- Step 14: Mistvale gorillas
	["Mistvale gorillas"] = "Гориллы из Мглистой долины",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Гориллы бродят по долине вокруг Унбагвы. Потроха падают со старых горилл; клык может упасть с любой.",

	-- Step 15: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Отдайте Унбагве клыки и оставайтесь рядом: он призовет три волны горилл, затем {npc:1514}. Бейтесь с ними по одному.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "",

	-- Step 17: Venture Co. mine
	["Venture Co. mine"] = "Рудник Торговой компании",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Дальше к северу гоблины Торговой компании копают в руднике к востоку от дороги; кристаллы падают с шахтеров, десятников, геодезистов и механиков.\nОсторожно: по округе вокруг лагеря в незаметности бродят пантеры Тенегрызов и тигрицы Тернистой долины.",

	-- Step 19: Nesingwary's camp
	["Nesingwary's camp"] = "Лагерь Эрнестуэя",
	["Head north up the road; the hunters camp on the hill above the river."] = "Идите на север по дороге; лагерь охотников – на холме над рекой.",

	-- Step 21: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716} собирает страницы книги «{quest:338}»: время от времени они падают с троллей долины. Возьмите его задание; каждую главу он принимает, когда у вас есть все ее страницы.",

	-- Step 22: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}: все страницы главы I в сумках",

	-- Step 23: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}: все страницы главы II в сумках",

	-- Step 24: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}: все страницы главы III в сумках",

	-- Step 25: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}: все страницы главы IV в сумках",

	-- Step 26: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}: четыре главы",

	-- Step 27: Zul'Kunda
	["Zul'Kunda"] = "Зул'Кунда",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {quest:586} Speaking with Gan'zulah · {object:3202} Grom'gol · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "К западу от экспедиции вожди племени Кровавого Скальпа – {npc:1061} и {npc:1062} – стоят вместе в руинах Зул'Кунды. Сначала перебейте охрану, затем выманите их. Бейте троллей Кровавого Скальпа здесь до 41-го уровня: задание {quest:586}, следующее у котла, отправит вас к Дробителям Черепов 41-43 уровня.\nНа побережье между Зул'Кундой и местом {object:3202} {npc:2635} (элитный, 38-й уровень) появляется на месте обычных кроколисков: если он на месте, убейте его и снимите шкуру для {npc:2495}.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "",
	-- {quest:586} Speaking with Gan'zulah
	["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "",

	-- Step 28: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}, рядом: {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: для зоны {zone:1425}, примерно на 48-м уровне",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}: трофейные черепа стоят в руинах Дробителей Черепов, позже на этом круге",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}: вход в пещеру под местом {area:104}, к западу от лагеря",

	-- Step 29: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}: к западу от места {object:3202} плывите над местом {area:104} и нырните к входу в пещеру в рифе; задание выполнится, как только вы его найдете. Пока не заходите в пещеру: ящеры-ловчие – к югу вдоль побережья.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "вход ({area:16550}), под водой",

	-- Step 30: Jungle stalkers
	["Jungle stalkers"] = "Ящеры-ловчие",
	-- {object:3202} Grom'gol
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Ящеры-ловчие охотятся в джунглях к югу от места {object:3202}, ближе к западному побережью.",

	-- Step 31: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Идите вдоль берега на юг. Наги-исследователи бродят по берегу и носят связки тростника; {object:759} бурлит в холмах чуть к востоку.",

	-- Step 32: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Идите на юг сюда: {area:35}. Филипп «Трусишка» ждет на пристани.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, внутри: {item:4105}",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",

	-- Step 33: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "К югу от Пиратской бухты висельники из шайки Кровавого Паруса стоят лагерем здесь: {area:43}; карты и приказы лежат в их палатках и в шлюпке рядом с большим лагерем. Нюхательный табак и глаз {npc:2493} может нести любой пират Кровавого Паруса: убивайте, пока не получите оба.",

	-- Step 35: The Bloodsail ships
	["The Bloodsail ships"] = "Корабли Кровавого Паруса",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["Optional, and tough at 42: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "для более поздней остановки ({zone:1435})",

	-- Step 36: Zanzil's camps
	["Zanzil's camps"] = "Лагеря Занзила",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "К северо-востоку от Мглистой долины в джунглях стоят лагерем последователи Занзила; смесь может быть у любого из них.",

	-- Step 37: Pirate ghosts
	["Pirate ghosts"] = "Призраки пиратов",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Три призрачных пирата бродят в джунглях к северу от места {area:35}, у лагерей Занзила: {npc:2535} и {npc:2536} стоят вместе, {npc:2537} – дальше к востоку.",

	-- Step 38: Zul'Mamwe
	["Zul'Mamwe"] = "Зул'Мамбве",
	-- {npc:1059} Ana'thek the Cruel
	["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Идите на север к руинам племени Дробителей Черепов к востоку от рудника Торговой компании; выманивайте охотников за головами и берсерков по одному. {npc:1059} охраняет юго-западные руины, а одна груда трофейных черепов стоит в северной части руин. С любого тролля Дробителей Черепов может упасть клык или ожерелье: ожерелья падают медленнее, поэтому бейте воинов в лагере к северу от руин, пока не соберете все.",
	["Skullsplitter warriors"] = "Воины из племени Дробителей Черепов",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",
	["Below ground"] = "Под землей",

	-- Step 39: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "",
	-- {object:3202} Grom'gol
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Следующие трофейные черепа – в небольших руинах чуть к северу от лагеря воинов.\nПоследние черепа – в руинах недалеко к западу, по пути обратно сюда: {object:3202}.",

	-- Step 40: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Head west to {object:3202}."] = "Идите на запад сюда: {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "",

	-- Step 42: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, наверху: для задания {quest:2864} ({area:976})",

	-- Step 43: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Железозубые василиски",
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "",

	-- Step 44: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Ride on north to {object:3202}."] = "Езжайте дальше на север сюда: {object:3202}.",

	-- Step 46: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Идите на север по дороге к лагерю охотников.",

	-- Step 48: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 49: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 53: Level 42.68
	["Level 42.68"] = "",
	-- {quest:192} Panther Mastery · {quest:195} Raptor Mastery
	["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "",

	-- Step 54: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "",

	-- Step 56: Level 42.74
	["Level 42.74"] = "",
	-- {quest:208} Big Game Hunter
	["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "",

	-- Step 60: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "В край {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Идите по дороге на восток из края {zone:1431} через край {zone:1430} в болото. {npc:1776} ждет здесь: {area:657} – лагерь дренеев у дороги, там, где она входит со стороны края {zone:1430}.",

	-- Step 61: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "Идите на восток сюда: {area:75}, в камышах к югу от дороги.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 62: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Острозубые кроколиски",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Кроколиски лежат в лужах вокруг лагеря {npc:5391} и к югу, к месту {area:75}; бок падает примерно с каждого четвертого.",

	-- Step 63: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Нобору бродит по поляне к юго-западу от места {area:76}; его дубина начинает задание.",

	-- Step 64: Draenethyst crystals
	["Draenethyst crystals"] = "Кристаллы дренетиста",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Езжайте на северо-восток сюда: {area:76}. Кристаллы стоят по пути к клетке ({npc:5391}).",

	-- Step 65: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} в плену здесь: {area:76}, на северо-востоке болота. Освободите его и следуйте за ним, отбиваясь от болотных тварей.",

	-- Step 66: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "Его сундук – в его старом лагере к северу от места {area:75}, по пути обратно на запад.",

	-- Step 67: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Езжайте на запад по дороге к лагерю дренеев ({area:657}), у въезда со стороны края {zone:1430}. {quest:698} отправляется к NPC {npc:5592} ({area:1978}) при следующем визите на болото: сохраните бока.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Корабль: {area:35}",
	-- ["Fly to {area:392}"] = "Летите сюда: {area:392}",
	-- ["From {area:2408} fly to {area:392}."] = "Из места {area:2408} летите сюда: {area:392}.",
	-- ["Hearth to {area:35}"] = "Камень возвращения: {area:35}",
	-- ["Hearth to {object:3202}"] = "Камень возвращения: {object:3202}",
	-- ["Into the {area:8}"] = "В край {area:8}",
	-- ["Naga shore and the {object:759}"] = "Берег наг и {object:759}",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Возвращайтесь на восток мимо места {area:75} и следуйте по дороге на юго-восток к небольшому лагерю Орды на берегу.",
	-- ["Sawtooth snappers"] = "Острозубые крепкохваты",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Езжайте по дороге на север от места {area:35}; Унбагва сидит на холме ({area:1737}), к востоку от дороги.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "Корабль ({area:35}) причаливает в конце пирса ({area:392}).",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Последние черепа – в руинах недалеко к западу, по пути обратно сюда: {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "Следующее руководство начинается здесь и ведет в край {zone:1446}.",
	-- ["The snappers line the strand south of the post."] = "Крепкохваты сидят на берегу к югу от лагеря.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Три корабля стоят у берега ({area:43}). Команды 42-45, капитан Штиллец 45, капитан Кильватель 46, {npc:2546} 48: на 41-м уровне это бой для группы или для конца руководства. Если идете, плывите к ним и выманивайте команду к борту по одному. На палубе лежит свиток ({quest:624}): возьмите его.",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "К западу от экспедиции вожди племени Кровавого Скальпа – {npc:1061} и {npc:1062} – стоят вместе в руинах Зул'Кунды. Сначала перебейте охрану, затем выманите их.",
	-- ["for Stoley in {zone:1446}"] = "для Столи ({zone:1446})",
	-- ["for a later stop in the {area:8}"] = "для более поздней остановки ({area:8})",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}, рядом: {npc:2497}",
	-- ["{area:392} pier"] = "Пирс: {area:392}",
}
