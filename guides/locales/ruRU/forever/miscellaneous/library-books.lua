-- Russian (ruRU): the guide forever/miscellaneous/library-books (forever/miscellaneous/library-books.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Library Books = {object:386759} Library Book
	["Library Books"] = "Книги для библиотеки",
	["Lost books and scrolls all over the world: each pays experience at the library, and 10, 20 and 25 of them earn a necklace, a ring and an off-hand."] = "По всему миру разбросаны книги и свитки. За каждую библиотека даёт опыт, а за 10, 20 и 25 штук — ожерелье, кольцо и предмет для левой руки.",

	-- Step 1: Elwynn Forest
	-- {area:91} Tower of Azora · {area:87} Goldshire
	["Halfway up the {area:91}, east of {area:87}. Nothing hostile inside."] = "Наверху {area:91}, восточнее {area:87}. Внутри никто не враждебен.",

	-- Step 2: Westfall
	-- {area:20} Moonbrook · {area:108} Sentinel Hill
	["Two books: one in a house at {area:20}, one at {area:108} (Alliance only)."] = "Две книги: одна в доме в {area:20}, другая в {area:108} (только для Альянса).",
	["Rumi of Gnomeregan"] = "Руми из Гномрегана",

	-- Step 3: Duskwood
	-- {area:2098} Dawning Wood Catacombs · {zone:1431} Duskwood
	["The spellbook lies in the {area:2098}, the crypt in north-western {zone:1431}. Undead fill it; a corpse run works if you are low."] = "Книга заклинаний лежит в {area:2098}, склепе в северо-западной части {zone:1431}. Он полон нежити; если вы низкого уровня, подойдёт забег за телом.",

	-- Step 5: Loch Modan
	-- {area:144} Thelsamar · {area:108} Sentinel Hill
	["Scrolls in the Mo'grosh ogre cave in the north-east. The ogres in the cave are level 18-19 elites: grouping up is advised. (Rumi of Gnomeregan also lies in {area:144}, if you missed it at {area:108}.)"] = "Свитки — в пещере огров Мо'грош на северо-востоке. Огры в пещере — элитные 18-19 уровней: рекомендуется искать группу. (Руми из Гномрегана лежит также в {area:144}, если вы пропустили её в {area:108}.)",

	-- Step 6: Wetlands
	-- {area:118} Whelgar's Excavation Site · {zone:1437} Wetlands
	["At {area:118}, the dig in the middle of the {zone:1437}."] = "В {area:118}, раскопки посреди {zone:1437}.",

	-- Step 7: Silverpine Forest
	-- {area:233} Ambermill
	["At {area:233}, the mage village in south-eastern Silverpine."] = "В {area:233}, деревня магов в юго-восточной части Серебристого бора.",

	-- Step 8: Tirisfal Glades
	-- {area:159} Brill
	["On a shelf in {area:159}'s apothecary."] = "На полке в аптеке {area:159}.",

	-- Step 9: Darkshore
	-- {area:443} Ruins of Mathystra · {zone:1439} Darkshore
	["Down the stairs at the {area:443} in northern {zone:1439}."] = "Вниз по лестнице в {area:443} в северной части {zone:1439}.",

	-- Step 10: Stonetalon Mountains
	-- {area:2537} Grimtotem Post
	["On a barrel in a tent at {area:2537}, in the far south-east of the zone."] = "На бочке в шатре в {area:2537}, на дальнем юго-востоке зоны.",

	-- Step 11: The Barrens
	-- {area:382} Sludge Fen · {object:407566} Goblin Tome (no name in this language: may be words) · {area:392} Ratchet
	["Two books: the manual in the control room at the top of the oil rig at the {area:382}, and the {object:407566} beside Gazlowe in {area:392}."] = "Две книги: руководство в диспетчерской на вершине нефтяной вышки в зоне {area:382} и {object:407566} рядом с Газлоу в {area:392}.",

	-- Step 12: The Wailing Caverns' cave
	-- {area:718} Wailing Caverns
	["The {area:718}' cave"] = "Пещера {area:718}",
	-- {area:387} Lushwater Oasis · {area:718} Wailing Caverns
	["The scrolls lie underground, in the cave below {area:387} by the {area:718} entrance, not inside the dungeon. Go in at the cave mouth in the oasis and follow the cave down; the arrow points at the scrolls from the surface."] = "Свитки лежат под землёй, в пещере под {area:387} у входа {area:718}, а не внутри подземелья. Войдите в устье пещеры в оазисе и спускайтесь по ней; стрелка указывает на свитки с поверхности.",
	-- {area:387} Lushwater Oasis
	["Cave mouth at {area:387}"] = "Устье пещеры в {area:387}",

	-- Step 13: Orgrimmar
	-- {object:405149} Mural of Ta'zo (no name in this language: may be words) · {object:172961} Valley of Spirits
	["The {object:405149} is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "{object:405149} — каменная плита, прислонённая к стене в {object:172961}, по пути к учителям магов. Используйте её, чтобы взять книгу.",

	-- Step 14: The library: first books
	["The library: first books"] = "Библиотека: первые книги",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in the books so far. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Сдайте книги, которые есть. {npc:211033} держит библиотеку наверху Обители Волшебника в {object:2101}. Он предлагает задание каждой книги, пока книга в вашей сумке: берите её и сдавайте, по одной, чтобы журнал заданий оставался свободным. Пропустите книги, которые вы не нашли.",

	-- Step 15: The library: first books (Horde)
	["The library: first books (Horde)"] = "Библиотека: первые книги (Орда)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in the books so far. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Сдайте книги, которые есть. {npc:211022} держит библиотеку в {object:36082}. Он предлагает задание каждой книги, пока книга в вашей сумке: берите её и сдавайте, по одной, чтобы журнал заданий оставался свободным. Пропустите книги, которые вы не нашли.",

	-- Step 16: Friend of the Library
	-- {quest:78150} Friend of the Library · {item:277203} Scholarly Pendant · {item:277204} Erudite's Amulet
	["With 10 different books handed in, the librarian offers {quest:78150}: a choice of two necklaces ({item:277203} or {item:277204}). Take it when it appears."] = "Сдав 10 разных книг, получите от библиотекаря {quest:78150}: выбор двух ожерелий ({item:277203} или {item:277204}). Берите его, когда он появится.",

	-- Step 17: Alterac Mountains
	-- {area:1357} Gallows' Corner
	["Inside the first tower of the ogre fort at {area:1357}, in the middle of the zone."] = "Внутри первой башни крепости огров в {area:1357}, посреди зоны.",

	-- Step 18: Arathi Highlands
	["Beside a tent entrance in the troll village in south-eastern Arathi."] = "Возле входа в шатёр в деревне троллей на юго-востоке Арати.",

	-- Step 19: Stranglethorn Vale
	-- {area:310} Crystalvein Mine
	["On a bench beside the {area:310} entrance, in the middle of the zone."] = "На скамье у входа {area:310}, посреди зоны.",

	-- Step 20: Badlands
	["Inside a crypt near the middle of the zone, reached from the path to its south."] = "Внутри склепа ближе к середине зоны, с пути к его югу.",

	-- Step 21: Swamp of Sorrows
	-- {area:1477} Temple of Atal'Hakkar
	["On the top walkway of the {area:1477}, outside the dungeon."] = "На верхнем проходе {area:1477}, снаружи подземелья.",

	-- Step 23: Thousand Needles
	-- {area:2097} Darkcloud Pinnacle
	["Inside a hut on the {area:2097} mesa."] = "Внутри хижины на плато {area:2097}.",

	-- Step 24: Dustwallow Marsh
	["On the ground at the eastern side of the murloc camp in north-eastern Dustwallow."] = "На земле с восточной стороны лагеря мурлоков на северо-востоке Пылевых топей.",

	-- Step 25: The library: second books
	["The library: second books"] = "Библиотека: вторые книги",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in this part's books. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Сдайте книги этой части. {npc:211033} держит библиотеку наверху Обители Волшебника в {object:2101}. Он предлагает задание каждой книги, пока книга в вашей сумке: берите её и сдавайте, по одной, чтобы журнал заданий оставался свободным. Пропустите книги, которые вы не нашли.",

	-- Step 26: The library: second books (Horde)
	["The library: second books (Horde)"] = "Библиотека: вторые книги (Орда)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in this part's books. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "Сдайте книги этой части. {npc:211022} держит библиотеку в {object:36082}. Он предлагает задание каждой книги, пока книга в вашей сумке: берите её и сдавайте, по одной, чтобы журнал заданий оставался свободным. Пропустите книги, которые вы не нашли.",

	-- Step 27: Greater Friend of the Library
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:281634} Field Researcher's Loop · {item:281635} Philanthropist's Ring
	["From level 20, with 20 different books handed in, {npc:211033} offers {quest:79536}: {item:281634} or {item:281635}."] = "С 20-го уровня, сдав 20 разных книг, получите от {npc:211033} {quest:79536}: {item:281634} или {item:281635}.",

	-- Step 28: The Hinterlands
	-- {area:353} Shadra'Alor · {zone:1425} The Hinterlands
	["In the troll ruins of {area:353}, in the south of the {zone:1425}."] = "В руинах троллей {area:353}, на юге {zone:1425}.",

	-- Step 29: Searing Gorge
	["On a table inside a tent near the middle of the zone."] = "На столе внутри шатра ближе к середине зоны.",

	-- Step 30: Blackrock Mountain
	-- {area:254} Blackrock Mountain · {npc:8888} Franclorn Forgewright · {npc:14387} Lothos Riftwaker
	["Inside {area:254}, not in a dungeon: the book lies on the altar in {npc:8888}'s tomb, near {npc:14387}. The waypoint marks the mountain."] = "Внутри {area:254}, не в подземелье: книга лежит на алтаре в гробнице {npc:8888}, рядом с {npc:14387}. Путевая точка отмечает гору.",

	-- Step 32: Azshara
	-- {area:1236} Haldarr Encampment · {zone:1447} Azshara
	["On a crate in the {area:1236}, in the far west of {zone:1447}."] = "На ящике в {area:1236}, на дальнем западе {zone:1447}.",

	-- Step 33: Tanaris
	["On a bookshelf in the middle building of the pirate camp on the eastern coast."] = "На книжной полке в среднем здании лагеря пиратов на восточном побережье.",

	-- Step 34: The library: third books
	["The library: third books"] = "Библиотека: третьи книги",

	-- Step 35: The library: third books (Horde)
	["The library: third books (Horde)"] = "Библиотека: третьи книги (Орда)",

	-- Step 36: The second Greater Friend of the Library
	-- {quest:79536} Greater Friend of the Library
	["The second {quest:79536}"] = "Второе задание {quest:79536}",
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:277254} Truthseeker's Bow · {item:277258} Crest of Elucidation · {item:277260} Researcher's Night Light
	["From level 35, with 25 different books handed in, {npc:211033} offers the second {quest:79536}: {item:277254}, {item:277258} or {item:277260} (level 40 to equip)."] = "С 35-го уровня, если сдано 25 разных книг, {npc:211033} предлагает второе задание {quest:79536}: {item:277254}, {item:277258} или {item:277260} (можно надеть с 40-го уровня).",

	-- Step 37: Level 60 books: Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Level 60 books: {zone:1422}"] = "Книги для 60-го уровня: {zone:1422}",
	-- {item:228141} Necromancy 101 · {area:2298} Caer Darrow · {area:2057} Scholomance · {item:228132} Undead Potatoes · {area:199} Felstone Field
	["Eight more books lie in level 55-60 zones; the mage trainers beside the librarians take them, not the librarians. {item:228141} lies on a table in the ruined keep on {area:2298}, above {area:2057} (outside the dungeon); {item:228132} at {area:199}."] = "Ещё восемь книг лежат в зонах 55-60 уровней; их принимают учителя магии рядом с библиотекарями, а не библиотекари. {item:228141} лежит на столе в разрушенной крепости на {area:2298}, над {area:2057} (снаружи подземелья); {item:228132} — в {area:199}.",

	-- Step 38: Level 60 books: Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Level 60 books: {zone:1423}"] = "Книги для 60-го уровня: {zone:1423}",
	-- {item:228135} A Study of the Light · {area:2268} Light's Hope Chapel · {item:228138} The Knight and the Lady · {area:2264} Corin's Crossing · {area:2279} Stratholme · {item:228140} Scourge: Undead Menace or Misunderstood? · {area:2277} Plaguewood
	["{item:228135} is inside {area:2268}. {item:228138} lies at {area:2264}; other copies lie elsewhere in the zone (one by the {area:2279} gates), and you can take only one. {item:228140} is on a table in {area:2277}: wait for the patrolling elite to clear the creatures beside it and walk on."] = "{item:228135} находится внутри {area:2268}. {item:228138} лежит в {area:2264}; другие экземпляры лежат в другом месте зоны (один у ворот {area:2279}), и взять можно только один. {item:228140} — на столе в {area:2277}: дождитесь, пока патрулирующий элитный зачистит существ рядом с ним, и идите дальше.",

	-- Step 39: Level 60 books: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Level 60 books: {area:1769}"] = "Книги для 60-го уровня: {area:1769}",
	-- {item:228134} Northern Kalimdor - A Comprehensive Guide · {area:1769} Timbermaw Hold · {zone:1448} Felwood · {zone:1452} Winterspring
	["{item:228134} lies inside the {area:1769} tunnel between {zone:1448} and {zone:1452}."] = "{item:228134} лежит внутри туннеля {area:1769} между {zone:1448} и {zone:1452}.",

	-- Step 40: Level 60 books: Everlook
	-- {area:2255} Everlook
	["Level 60 books: {area:2255}"] = "Книги для 60-го уровня: {area:2255}",
	-- {item:228136} Ka-Boom! · {area:2255} Everlook
	["{item:228136} sits on a shelf behind the alchemy supplier in {area:2255}."] = "{item:228136} стоит на полке за поставщиком алхимии в {area:2255}.",

	-- Step 41: Level 60 books: Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Level 60 books: {area:254}"] = "Книги для 60-го уровня: {area:254}",
	-- {item:228133} Magma or Lava? · {area:254} Blackrock Mountain · {area:1584} Blackrock Depths · {area:2717} Molten Core
	["{item:228133} lies inside {area:254}, in the mine passage towards {area:1584} beyond the {area:2717} quest giver. The waypoint marks the mountain."] = "{item:228133} лежит внутри {area:254}, в шахтном проходе к {area:1584}, за Дающим задание для {area:2717}. Путевая точка отмечает гору.",

	-- Step 42: The level 60 books: Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["The level 60 books: {npc:5497}"] = "Книги для 60-го уровня: {npc:5497}",
	-- {npc:5497} Jennea Cannon · {npc:211033} Garion Wendell · {item:228132} Undead Potatoes · {item:228138} The Knight and the Lady · {item:228140} Scourge: Undead Menace or Misunderstood?
	["{npc:5497}, the mage trainer beside {npc:211033} in the Wizard's Sanctum, takes the level 60 books: she offers each book's quest while the book is in your bags. Hand in {item:228132}, {item:228138} and {item:228140} the same way (their quests are not in Polestar's data yet)."] = "{npc:5497}, учитель магии рядом с {npc:211033} в Обители Волшебника, принимает книги для 60-го уровня: она предлагает задание каждой книги, пока книга в вашей сумке. {item:228132}, {item:228138} и {item:228140} сдавайте так же (их задания пока не в данных Polestar).",

	-- Step 43: The level 60 books: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe
	["The level 60 books: {npc:7825}"] = "Книги для 60-го уровня: {npc:7825}",
	-- {npc:7825} Oran Snakewrithe · {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["{npc:7825}, beside {npc:211022} in the {object:36082}, takes the level 60 books: each book's quest is offered while the book is in your bags. Take and hand them in one at a time (Polestar cannot track these quests for the Horde yet)."] = "{npc:7825}, рядом с {npc:211022} в {object:36082}, принимает книги для 60-го уровня: задание каждой книги предлагается, пока книга в вашей сумке. Берите и сдавайте их по одной (Polestar пока не может отслеживать эти задания для Орды).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lost books and scrolls all over the world: each pays experience at the library, and enough of them earn a {quest:78150} reward."] = "По всему миру разбросаны книги и свитки. За них библиотека даёт опыт, а за достаточное количество — награду {quest:78150}.",
}
