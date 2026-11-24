-- Russian (ruRU): the guide forever/reputation/steamwheedle-cartel (forever/reputation/steamwheedle-cartel.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Steamwheedle Cartel Reputation"] = "Репутация: Картель Хитрая Шестеренка",
	-- {npc:14637} Zorbin Fandazzle · {npc:14338} Knot Thimblejack
	["Every goblin town at once: {npc:14637}'s zapped giants and {npc:14338}'s shackles, then five new quartermasters and their hats."] = "Все гоблинские города сразу: оглушенные великаны для {npc:14637} и кандалы для {npc:14338}, затем пять новых интендантов и их шляпы.",
	["Forever's goblin quartermasters: gear for levels 20 to 50 at Friendly and Honored"] = "Гоблинские интенданты Forever: снаряжение для уровней 20–50 при отношении «Дружелюбие» и «Уважение»",

	-- Step 1: Zorbin Fandazzle
	-- {faction:470} Ratchet · {faction:21} Booty Bay · {faction:369} Gadgetzan · {faction:577} Everlook · {faction:2827} Powderfuse · {zone:2548} Riverglades · {npc:14637} Zorbin Fandazzle · {npc:4624} Booty Bay Bruiser · {zone:1444} Feralas
	["Five goblin towns share one reputation family, the Steamwheedle Cartel: {faction:470}, {faction:21}, {faction:369}, {faction:577} and Forever's new {faction:2827} in the {zone:2548}. Everyone starts each at Neutral (500 into it). A gain with one town gives the others half as much; a quest for the Cartel itself, like {npc:14637}'s, pays every town in full. Losses spread the same way: a {npc:4624} or any goblin of the towns costs 125 (half that with the other towns), and Bloodsail Buccaneers reputation is earned only that way. {npc:14637} camps on the road through central {zone:1444} and works for anyone, even players the goblins hate. His first two quests are level 48 and open his repeatables (level 55); Forever pays all of them in full at any level."] = "Пять гоблинских городов делят одну семью репутации — Торговую компанию Паровых Шестерён: {faction:470}, {faction:21}, {faction:369}, {faction:577} и новый город {faction:2827} в {zone:2548}. Каждый начинает с «Равнодушия» (500 в него). Прирост в одном городе даёт остальным половину; задание самой Компании, вроде заданий {npc:14637}, платит каждому городу полностью. Потери распределяются так же: {npc:4624} или любой гоблин городов стоит 125 (вдвое меньше с остальными городами), а репутация с Пиратской бухтой и её пиратами зарабатывается только так. {npc:14637} разбил лагерь на дороге через центральный {zone:1444} и работает на любого, даже на игроков, которых гоблины ненавидят. Его первые два задания — 48 уровня и открывают повторяемые (55 уровень); Forever платит все полностью на любом уровне.",
	-- {quest:7003} Zapped Giants
	["{quest:7003}: 150 to every town"] = "{quest:7003}: 150 каждому городу",
	-- {quest:7721} Fuel for the Zapping
	["{quest:7721}: 150 to every town"] = "{quest:7721}: 150 каждому городу",

	-- Step 2: Zapped giants
	["Zapped giants"] = "Уменьшенные великаны",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:5357} Land Walker · {npc:5358} Cliff Giant · {npc:5361} Wave Strider · {item:18956} Miniaturization Residue
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Use {item:18904} on a living giant ({npc:5357}, {npc:5358}, or a Shore, Deep or {npc:5361}, level 47-50) and it shrinks into a zapped version; kill that for its {item:18956}, one every time. The Land Walkers and Cliff Giants in the north-west hills are the thickest; the striders walk the coast and the shallows. The shrinker lasts two hours: if it runs out, abandon the quest and take it again."] = "Используйте {item:18904} на живом великане ({npc:5357}, {npc:5358} или береговом, глубинном, {npc:5361}, 47–50 уровни), и он уменьшается до истыканной версии; убейте её ради {item:18956}, одного каждый раз. Сухопутные бродяги и скальные великаны на северо-западных холмах — самые густые; волноходы ходят по побережью и отмелям. Уменьшитель держится два часа: если он кончается, откажитесь от задания и возьмите снова.",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["{item:18904}, on a living giant"] = "{item:18904}, на живом великане",
	-- {item:18956} Miniaturization Residue
	["{item:18956}, from the zapped giants"] = "{item:18956}, с истыканных великанов",

	-- Step 3: Sea Elementals and Sea Sprays
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Sea Elementals and Sea Sprays"] = "Морские элементали и морские всплески",
	-- {area:1108} Forgotten Coast · {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["The Sea Elementals and Sea Sprays (level 47-49) drift along the {area:1108} and in the shallows below the giants: about half drop a {item:18958}."] = "Морские элементали и морские всплески (47–49 уровни) дрейфуют вдоль {area:1108} и в отмелях под великанами: примерно половина роняет {item:18958}.",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}: Sea Elementals and Sea Sprays"] = "{item:18958}: морские элементали и морские всплески",

	-- Step 4: Back to Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["Back to {npc:14637}"] = "Вернитесь: {npc:14637}",
	-- {npc:14637} Zorbin Fandazzle · {quest:7725} Again With the Zapped Giants · {quest:7726} Refuel for the Zapping
	["From now on {npc:14637} offers {quest:7725} (10 residue) and {quest:7726} (6 cores), again and again: 25 reputation with every town each time."] = "С этого момента {npc:14637} предлагает {quest:7725} (10 остатков) и {quest:7726} (6 ядер), снова и снова: 25 репутации каждому городу каждый раз.",

	-- Step 5: Lost Rigger Cove, below 56
	-- {area:1336} Lost Rigger Cove
	["{area:1336}, below 56"] = "{area:1336}, ниже 56",
	-- {area:1336} Lost Rigger Cove · {zone:1446} Tanaris · {faction:369} Gadgetzan · {area:977} Steamwheedle Port · {quest:8366} Southsea Shakedown · {quest:8365} Pirate Hats Ahoy!
	-- plural, as words: Southsea Pirate Hats = {item:20519} Southsea Pirate Hat
	["The Southsea pirates of {area:1336} (level 44-45) on the east coast of {zone:1446} give {faction:369} 5 each up to the end of Honored, and the other towns half. Two quests at {area:977} pay 100 {faction:369} each: {quest:8366} (10 of each pirate) and {quest:8365} (20 Southsea Pirate Hats, one in ten pirates). From level 56 the pirates are grey and pay little: skip this step then."] = "Южноморские пираты {area:1336} (44–45 уровни) на восточном побережье {zone:1446} дают {faction:369} по 5 до конца «Уважения», а остальным городам — половину. Два задания в {area:977} платят по 100 {faction:369}: {quest:8366} (по 10 каждого пирата) и {quest:8365} (20 шляп пиратов Южных морей, у одного из десяти пиратов). С 56 уровня пираты серые и платят мало: тогда пропустите этот шаг.",

	-- Step 6: Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil · {area:251} Flame Crest · {zone:1428} Burning Steppes · {faction:577} Everlook · {item:12284} Draco-Incarcinatrix 900 · {quest:4726} Broodling Essence
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling · Flamescale Broodlings = {npc:7049} Flamescale Broodling · Black Broodlings = {npc:7047} Black Broodling
	["{npc:10267}, a goblin at {area:251} in the north of the {zone:1428}, has a chain that pays every town 150 and {faction:577} 150 more. Use her {item:12284} on a broodling, kill it while the device holds it, and pick up the {quest:4726} it leaves. The device takes only Black and Scalding Broodlings, not the Flamescale Broodlings of the west: Scalding Broodlings (level 53-54) roam just west and east of {area:251}, Black Broodlings (51-52) the north-east corner of the zone, the thickest group. They are few and spread out: the path passes both and ends among the Black Broodlings."] = "{npc:10267}, гоблин в {area:251} на севере {zone:1428}, имеет цепочку, которая платит каждому городу 150 и ещё 150 {faction:577}. Используйте её {item:12284} на дракончике, убейте его, пока устройство держит, и подберите {quest:4726}, которое он оставляет. Устройство берёт только детенышей черного дракона и детенышей Опаляющего дракона, но не детенышей огнечешуйного дракона запада: детеныши Опаляющего дракона (53–54 уровни) бродят сразу западнее и восточнее {area:251}, детеныши черного дракона (51–52) — северо-восточный угол зоны, самая густая группа. Их мало и они разбросаны: путь проходит мимо обоих и заканчивается среди детенышей черного дракона.",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings west of {area:251}"] = "Детеныши Опаляющего дракона западнее {area:251}",
	-- {area:251} Flame Crest
	-- plural, as words: Scalding Broodlings = {npc:7048} Scalding Broodling
	["Scalding Broodlings east of {area:251}"] = "Детеныши Опаляющего дракона восточнее {area:251}",
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings in the north-east"] = "Детеныши черного дракона на северо-востоке",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7048} Scalding Broodling
	["{item:12284}, on a Black or {npc:7048}"] = "{item:12284}, на чёрном или {npc:7048}",
	-- {quest:4726} Broodling Essence
	["{quest:4726}, left by the broodlings"] = "{quest:4726}, оставленное дракончиками",
	["100 to every town"] = "100 каждому городу",

	-- Step 7: Everlook: Felnok Steelspring
	-- {quest:4808} Felnok Steelspring · {faction:577} Everlook
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{quest:4808} is in {faction:577}. The Chillwind Chimaeras (level 55-57) south-west of {faction:577} drop the horns one time in five."] = "{quest:4808} — в {faction:577}. Хладноветрые химеры (55–57 уровни) юго-западнее {faction:577} роняют рога один раз из пяти.",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["{item:12444}: Chillwind Chimaeras"] = "{item:12444}: хладноветрые химеры",

	-- Step 8: Back to Tinkee Steamboil
	-- {npc:10267} Tinkee Steamboil
	["Back to {npc:10267}"] = "Вернитесь: {npc:10267}",
	-- {quest:4810} Return to Tinkee
	["{quest:4810} gives 50 to every town. Her later quests, Egg Freezing (150 to every town) and Egg Collection (200), are done in the Rookery of Upper Blackrock Spire, a ten-player dungeon: take them up with your group."] = "{quest:4810} даёт 50 каждому городу. Её поздние задания, «Заморозка яиц» (150 каждому городу) и «Сбор яиц» (200), делаются в Гнездовье Верхней части Черной Скалы, подземелье на десять игроков: берите их с группой.",

	-- Step 9: Dire Maul North: Knot Thimblejack
	-- {npc:14338} Knot Thimblejack
	["Dire Maul North: {npc:14338}"] = "Забытый город, север: {npc:14338}",
	-- {npc:14338} Knot Thimblejack · {item:18250} Gordok Shackle Key · {npc:14321} Guard Fengus · {item:18258} Gordok Ogre Suit · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:18240} Ogre Tannin
	["{npc:14338} sits shackled in Dire Maul North, the Gordok ogres' wing (a five-player dungeon from level 57: group up). Every {item:18250} frees him once: 150 to every town, and he is shackled again on your next run. Gordok ogres drop the keys (about one in fifteen; {npc:14321} one in seven): a full run of the wing usually brings one. His {item:18258} pays 100 the first time and 50 after, for 4 Bolts of Runecloth, 8 {item:8170}, 2 {item:14341} and the {item:18240} from the basket in the wing. Under 57 when you get here? Unskip this step later."] = "{npc:14338} сидит в кандалах в Забытом городе, север — крыле огров Гордоков (подземелье на пять игроков с 57 уровня: соберите группу). Каждый {item:18250} освобождает его один раз: 150 каждому городу, и на следующем забеге он снова в кандалах. Огры Гордоков роняют ключи (примерно один из пятнадцати; {npc:14321} — один из семи): полный забег крыла обычно приносит один. Его {item:18258} платит 100 в первый раз и 50 после, за 4 болта рунической ткани, 8 {item:8170}, 2 {item:14341} и {item:18240} из корзины в крыле. Попали сюда ниже 57? Вернитесь к этому шагу позже.",
	-- {item:18250} Gordok Shackle Key
	["{item:18250}, Gordok ogres"] = "{item:18250}, огры Гордоков",
	-- {quest:5525} Free Knot! · {npc:14338} Knot Thimblejack
	["{quest:5525}: 150 to every town, handed in from {npc:14338}'s window"] = "{quest:5525}: по 150 каждому городу, сдается через окно NPC {npc:14338}",
	-- {quest:5525} Free Knot!
	["{quest:5525}, again on every later run: 150"] = "{quest:5525}, снова на каждом следующем забеге: 150",

	-- Step 10: Every town to Friendly
	["Every town to Friendly"] = "Каждый город до «Дружелюбия»",
	-- {npc:14637} Zorbin Fandazzle · {npc:10267} Tinkee Steamboil · {faction:470} Ratchet · {zone:1413} Barrens · {npc:3446} Mebok Mizzyrix · {faction:21} Booty Bay · {zone:1418} Badlands · {area:327} Faldir's Cove · {faction:369} Gadgetzan · {zone:1446} Tanaris · {item:8548} Divino-matic Rod · {faction:577} Everlook · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {zone:1411} Durotar · {zone:1455} Ironforge
	["Neutral 500 to Friendly is 2,500 with each town. The quests above pay every town up to 700 ({npc:14637}'s two 300, {npc:10267}'s 150, the first Free Knot 150 and the first Ogre Suit 100); {npc:14637}'s repeatables do the rest, 25 to every town each: 10 residue (ten giants) or 6 cores (about twelve elementals). The towns' own quests count too, each giving the other towns half: {faction:470}'s in the {zone:1413} (levels 10-25, about 4,300: the Samophlange chain 625, {npc:3446}'s errands, the Wizzlecrank and Gilthares escorts 150 each), {faction:21}'s in Stranglethorn, Arathi and the {zone:1418} (30-50, about 6,500: the three OOX robot rescues 250 each, An OOX of Your Own 200, Stranglethorn Fever 200, Facing Negolash 200, the Sunken Treasure chain at {area:327}), {faction:369}'s in {zone:1446} (43-55, about 3,000: the {item:8548} 200, Wastewander Justice 100 each, the WANTED posters) and {faction:577}'s in {zone:1452} (52-60, about 1,450: {npc:9298}'s Winterfall chain, Umi's yeti quests). Forever adds a few low ones: A Simmering Storm and Stormy Potential in {zone:1411} and WANTED: Bruuz ({faction:470} 100 each), Important Heirlooms in {zone:1455} ({faction:369} 100). Forever pays them in full at any level. Kills help while they are not grey, 5 each: Southsea pirates in the {zone:1413} for {faction:470} and in {zone:1446} for {faction:369} and Stranglethorn's Venture Co. camps for {faction:21}, up to the end of Honored; Wastewander bandits for {faction:369} and Bloodsail pirates for {faction:21} only up to the end of Neutral. Friendly opens each quartermaster's first gear."] = "От «Равнодушия» 500 до «Дружелюбия» — 2 500 с каждым городом. Задания выше платят каждому городу до 700 (два задания {npc:14637} по 300, 150 от {npc:10267}, первое «Освободите Нота!» 150 и первый огрский костюм 100); повторяемые {npc:14637} добирают остальное, по 25 каждому городу: 10 остатков (десять великанов) или 6 ядер (около двенадцати элементалей). Собственные задания городов тоже считаются, каждый давая остальным городам половину: у {faction:470} в {zone:1413} (10–25 уровни, около 4 300: цепочка самофланга 625, поручения {npc:3446}, сопровождения Виззлкранка и Гилтареса по 150), у {faction:21} в Тернистой долине, Арати и {zone:1418} (30–50, около 6 500: три спасения робота OOX по 250, «Собственный OOX» 200, «Лихорадка Тернистой долины» 200, «Лицом к Неголашу» 200, цепочка «Затонувшее сокровище» в {area:327}), у {faction:369} в {zone:1446} (43–55, около 3 000: {item:8548} 200, «Правосудие пустынников» по 100, объявления о розыске) и у {faction:577} в {zone:1452} (52–60, около 1 450: цепочка {npc:9298}, задания Йети Уми). Forever добавляет несколько низкоуровневых: «Бурлящая буря» и «Бурное потенциал» в {zone:1411} и «РОЗЫСК: Брууз» (по 100 {faction:470}), «Важные реликвии» в {zone:1455} (100 {faction:369}). Forever платит их полностью на любом уровне. Убийства помогают, пока не серые, по 5: южноморские пираты в {zone:1413} для {faction:470} и в {zone:1446} для {faction:369}, а лагеря Корпорации Вентур в Тернистой долине для {faction:21} — до конца «Уважения»; пустынные разбойники для {faction:369} и пираты Кровавого Паруса для {faction:21} — только до конца «Равнодушия». «Дружелюбие» открывает первую экипировку каждого квартирмейстера.",
	-- {quest:7725} Again With the Zapped Giants
	["{quest:7725}: 10 residue"] = "{quest:7725}: 10 остатков",
	["25 to every town"] = "25 каждому городу",
	-- {quest:7726} Refuel for the Zapping
	["{quest:7726}: 6 cores"] = "{quest:7726}: 6 ядер",

	-- Step 11: Every town to Honored
	["Every town to Honored"] = "Каждый город до «Уважения»",
	-- {npc:14637} Zorbin Fandazzle · {item:18250} Gordok Shackle Key
	["Friendly to Honored is 6,000: 240 of {npc:14637}'s turn-ins, or 40 Free Knot runs, or a mix. Nothing can be saved up: residue and cores drop only while their quest is in your log, and you can carry one {item:18250} at a time, so hand each in before the next run. Honored opens each quartermaster's blue items."] = "От «Дружелюбия» до «Уважения» — 6 000: 240 сдач {npc:14637}, или 40 забегов «Освободите Нота!», или смесь. Накопить нельзя: остатки и ядра падают, только пока задание в журнале, а {item:18250} можно нести по одному, так что сдавайте каждый перед следующим забегом. «Уважение» открывает синие предметы каждого квартирмейстера.",

	-- Step 12: Every town to Revered
	["Every town to Revered"] = "Каждый город до «Почтения»",
	-- {npc:14637} Zorbin Fandazzle
	["Honored to Revered is 12,000 more: 480 of {npc:14637}'s turn-ins (4,800 residue) or 80 Free Knot runs. Revered opens the five cosmetic hats, the reason most players do this. Legacy Diplomat adds up to 10%."] = "От «Уважения» до «Почтения» — ещё 12 000: 480 сдач {npc:14637} (4 800 остатков) или 80 забегов «Освободите Нота!». «Почтение» открывает пять косметических шляп — причину, по которой большинство игроков это делают. Наследие Дипломат добавляет до 10%.",

	-- Step 13: Ratchet: Winklespark
	-- {npc:265574} Winklespark · {faction:470} Ratchet · {item:274740} Quilted Cloak · {item:274741} Rumpled Kilt · {item:274742} Ratchet Wristwraps · {item:274743} Defective Samophlange · {item:274744} Barrens Basher · {item:274021} Barrens Headband
	["{npc:265574}, {faction:470}'s quartermaster, by the docks. Friendly, level 20 gear: {item:274740} 41s (Stamina, Agility), {item:274741} 54s (Stamina, spell power), {item:274742} 34s (Intellect, Agility). Honored: {item:274743}, an off-hand, 66s (Intellect, Spirit); {item:274744}, a one-handed mace, 1g 65s (Stamina, Strength). Revered: the {item:274021}, a cosmetic hat, 2g."] = "{npc:265574}, квартирмейстер {faction:470}, у причалов. «Дружелюбие», экипировка 20 уровня: {item:274740} 41с (Выносливость, Ловкость), {item:274741} 54с (Выносливость, сила заклинаний), {item:274742} 34с (Интеллект, Ловкость). «Уважение»: {item:274743}, левая рука, 66с (Интеллект, Дух); {item:274744}, одноручная булава, 1з 65с (Выносливость, Сила). «Почтение»: {item:274021}, косметическая шляпа, 2з.",
	-- {item:274740} Quilted Cloak
	["{item:274740}, Friendly"] = "{item:274740}, «Дружелюбие»",
	-- {item:274741} Rumpled Kilt
	["{item:274741}, Friendly"] = "{item:274741}, «Дружелюбие»",
	-- {item:274742} Ratchet Wristwraps
	["{item:274742}, Friendly"] = "{item:274742}, «Дружелюбие»",
	-- {item:274743} Defective Samophlange
	["{item:274743}, Honored"] = "{item:274743}, «Уважение»",
	-- {item:274744} Barrens Basher
	["{item:274744}, Honored"] = "{item:274744}, «Уважение»",
	-- {item:274021} Barrens Headband
	["{item:274021}, Revered"] = "{item:274021}, «Почтение»",

	-- Step 14: Booty Bay: Gezzy Gunkgear
	-- {npc:265575} Gezzy Gunkgear · {faction:21} Booty Bay · {item:274745} Deckswabber's Mitts · {item:274746} Sea Giant's Toe Ring · {item:274747} Soggy Boots · {item:274748} Booty Bay Bruiser's Buckshot · {item:274749} Souvenir Sea Shell · {item:274022} Tough Guy's Eyepatch
	["{npc:265575}, {faction:21}'s quartermaster. Friendly, level 30 gear: {item:274745} 1g 10s (Strength, Agility), {item:274746} 1g 48s (healing and spell damage), {item:274747} 1g 3s (Intellect, Spirit). Honored: {item:274748}, a gun, 3g 11s (attack power, Stamina); {item:274749}, a necklace, 1g 66s (health regeneration, Stamina). Revered: {item:274022}, 5g."] = "{npc:265575}, квартирмейстер {faction:21}. «Дружелюбие», экипировка 30 уровня: {item:274745} 1з 10с (Сила, Ловкость), {item:274746} 1з 48с (лечение и урон заклинаниями), {item:274747} 1з 3с (Интеллект, Дух). «Уважение»: {item:274748}, ружьё, 3з 11с (сила атаки, Выносливость); {item:274749}, ожерелье, 1з 66с (регенерация здоровья, Выносливость). «Почтение»: {item:274022}, 5з.",
	-- {item:274745} Deckswabber's Mitts
	["{item:274745}, Friendly"] = "{item:274745}, «Дружелюбие»",
	-- {item:274746} Sea Giant's Toe Ring
	["{item:274746}, Friendly"] = "{item:274746}, «Дружелюбие»",
	-- {item:274747} Soggy Boots
	["{item:274747}, Friendly"] = "{item:274747}, «Дружелюбие»",
	-- {item:274748} Booty Bay Bruiser's Buckshot
	["{item:274748}, Honored"] = "{item:274748}, «Уважение»",
	-- {item:274749} Souvenir Sea Shell
	["{item:274749}, Honored"] = "{item:274749}, «Уважение»",
	-- {item:274022} Tough Guy's Eyepatch
	["{item:274022}, Revered"] = "{item:274022}, «Почтение»",

	-- Step 15: Gadgetzan: Rettrick
	-- {npc:265576} Rettrick · {faction:369} Gadgetzan · {item:274750} Reflective Wristguards · {item:274751} Sunburn Spaulders · {item:274752} Sandstorm Cover · {item:274753} Jhordy's Misplaced Screwdriver · {item:274754} Suspicious Spare Part · {item:274023} Stolen Wastewander Cowl
	["{npc:265576}, {faction:369}'s quartermaster. Friendly, level 40 gear: {item:274750} 2g 74s (Intellect, healing, spell damage), {item:274751} 2g 94s (Agility, attack power), {item:274752}, a cloak, 2g 36s (Spirit, spell power). Honored: {item:274753}, a one-handed weapon, 9g 46s (Strength, Agility); {item:274754}, a ring, 3g 80s (Strength, Stamina). Revered: the {item:274023}, 10g."] = "{npc:265576}, квартирмейстер {faction:369}. «Дружелюбие», экипировка 40 уровня: {item:274750} 2з 74с (Интеллект, лечение, урон заклинаниями), {item:274751} 2з 94с (Ловкость, сила атаки), {item:274752}, плащ, 2з 36с (Дух, сила заклинаний). «Уважение»: {item:274753}, одноручное оружие, 9з 46с (Сила, Ловкость); {item:274754}, кольцо, 3з 80с (Сила, Выносливость). «Почтение»: {item:274023}, 10з.",
	-- {item:274750} Reflective Wristguards
	["{item:274750}, Friendly"] = "{item:274750}, «Дружелюбие»",
	-- {item:274751} Sunburn Spaulders
	["{item:274751}, Friendly"] = "{item:274751}, «Дружелюбие»",
	-- {item:274752} Sandstorm Cover
	["{item:274752}, Friendly"] = "{item:274752}, «Дружелюбие»",
	-- {item:274753} Jhordy's Misplaced Screwdriver
	["{item:274753}, Honored"] = "{item:274753}, «Уважение»",
	-- {item:274754} Suspicious Spare Part
	["{item:274754}, Honored"] = "{item:274754}, «Уважение»",
	-- {item:274023} Stolen Wastewander Cowl
	["{item:274023}, Revered"] = "{item:274023}, «Почтение»",

	-- Step 16: Everlook: Zippie Fizzbolt
	-- {npc:265577} Zippie Fizzbolt · {faction:577} Everlook · {item:274755} Steamwheedle Grips · {item:274756} Impractical Headwarmer · {item:274757} Substandard Belt Chain · {item:274758} Coldmetal Guard · {item:274759} Everlook Pathcarver · {item:274760} Everlook Delivery Bot · {item:274761} Parachute-Priest Pager · {item:274024} Fizzbolt's Fashionable Fedora
	["{npc:265577}, {faction:577}'s quartermaster. Friendly, level 50 gear: {item:274755} 3g 10s (Spirit, Intellect), {item:274756} 5g 84s (Agility, Stamina, frost resistance), {item:274757} 4g 68s (Agility, attack power), {item:274758}, a chest, 10g 96s (Strength, Stamina). Honored, three trinkets at about 7g 55s: {item:274759} (nature resistance), {item:274760} (frost resistance) and {item:274761} (shadow resistance), the last two with a use. Revered: {item:274024}, 25g."] = "{npc:265577}, квартирмейстер {faction:577}. «Дружелюбие», экипировка 50 уровня: {item:274755} 3з 10с (Дух, Интеллект), {item:274756} 5з 84с (Ловкость, Выносливость, сопротивление магии льда), {item:274757} 4з 68с (Ловкость, сила атаки), {item:274758}, нагрудник, 10з 96с (Сила, Выносливость). «Уважение», три аксессуара примерно по 7з 55с: {item:274759} (сопротивление природе), {item:274760} (сопротивление льду) и {item:274761} (сопротивление тёмной магии), последние два с использованием. «Почтение»: {item:274024}, 25з.",
	-- {item:274755} Steamwheedle Grips
	["{item:274755}, Friendly"] = "{item:274755}, «Дружелюбие»",
	-- {item:274756} Impractical Headwarmer
	["{item:274756}, Friendly"] = "{item:274756}, «Дружелюбие»",
	-- {item:274757} Substandard Belt Chain
	["{item:274757}, Friendly"] = "{item:274757}, «Дружелюбие»",
	-- {item:274758} Coldmetal Guard
	["{item:274758}, Friendly"] = "{item:274758}, «Дружелюбие»",
	-- {item:274759} Everlook Pathcarver
	["{item:274759}, Honored"] = "{item:274759}, «Уважение»",
	-- {item:274760} Everlook Delivery Bot
	["{item:274760}, Honored"] = "{item:274760}, «Уважение»",
	-- {item:274761} Parachute-Priest Pager
	["{item:274761}, Honored"] = "{item:274761}, «Уважение»",
	-- {item:274024} Fizzbolt's Fashionable Fedora
	["{item:274024}, Revered"] = "{item:274024}, «Почтение»",

	-- Step 17: Powderfuse: Friz Frazzlespark
	-- {npc:255897} Friz Frazzlespark · {faction:2827} Powderfuse · {area:16727} Powderfuse Port · {zone:2548} Riverglades · {item:276200} Crawler's Clackers · {item:276201} Misplaced Pantaloons · {item:276202} Disengagement Ring · {item:276203} Primitive Fishing Pole · {item:276204} Thrash's Trash · {item:276199} Haughty Fellow's Monocle
	["{npc:255897} sells {faction:2827}'s rewards in {area:16727}, on the east coast of the {zone:2548}, alongside general goods. Friendly, level 40 gear: {item:276200} 2g 74s (Stamina, attack power), {item:276201} 2g 94s (Intellect, Spirit), {item:276202} 2g 36s (Agility, Spirit). Honored: {item:276203}, a two-handed weapon, 9g 46s (Stamina, Strength, Agility); {item:276204}, a shield, 3g 80s (Stamina, spell damage, healing). Revered: {item:276199}, 10g."] = "{npc:255897} продаёт награды {faction:2827} в {area:16727}, на восточном побережье {zone:2548}, рядом с обычными товарами. «Дружелюбие», экипировка 40 уровня: {item:276200} 2з 74с (Выносливость, сила атаки), {item:276201} 2з 94с (Интеллект, Дух), {item:276202} 2з 36с (Ловкость, Дух). «Уважение»: {item:276203}, двуручное оружие, 9з 46с (Выносливость, Сила, Ловкость); {item:276204}, щит, 3з 80с (Выносливость, урон заклинаниями, лечение). «Почтение»: {item:276199}, 10з.",
	-- {item:276200} Crawler's Clackers
	["{item:276200}, Friendly"] = "{item:276200}, «Дружелюбие»",
	-- {item:276201} Misplaced Pantaloons
	["{item:276201}, Friendly"] = "{item:276201}, «Дружелюбие»",
	-- {item:276202} Disengagement Ring
	["{item:276202}, Friendly"] = "{item:276202}, «Дружелюбие»",
	-- {item:276203} Primitive Fishing Pole
	["{item:276203}, Honored"] = "{item:276203}, «Уважение»",
	-- {item:276204} Thrash's Trash
	["{item:276204}, Honored"] = "{item:276204}, «Уважение»",
	-- {item:276199} Haughty Fellow's Monocle
	["{item:276199}, Revered"] = "{item:276199}, «Почтение»",

	-- Step 18: Every town to Exalted
	["Every town to Exalted"] = "Каждый город до «Превознесения»",
	-- {npc:14637} Zorbin Fandazzle
	["Revered to Exalted is 21,000 more with each town: 840 of {npc:14637}'s turn-ins or 140 Free Knot runs. No quartermaster sells anything for Exalted: this is for the title bar only."] = "От «Почтения» до «Превознесения» — ещё 21 000 с каждым городом: 840 сдач {npc:14637} или 140 забегов «Освободите Нота!». Ни один квартирмейстер ничего не продаёт за «Превознесение»: это только ради строки титула.",
}
