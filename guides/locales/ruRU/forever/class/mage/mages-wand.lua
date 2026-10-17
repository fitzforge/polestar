-- Russian (ruRU): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A wand of your school for the 30s: frost, arcane or fire."] = "Жезл вашей школы на 30+ уровне: лед, тайная магия или огонь.",

	-- Step 1: Journey to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497} в святилище магов ({zone:1453}, {object:2101}) отправляет вас к NPC {npc:6546}; Бинк ({zone:1455}) дает то же задание.",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, один из учителей магов ({zone:1454}), отправляет вас к NPC {npc:6546}; то же задание дают {npc:4568} ({zone:1458}) и {npc:3048} ({zone:1456}).",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}, отшельница, живет в домике в глубине болота к западу от Терамора, чуть севернее: {area:508}.",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548} проводит дни на гоночной трассе: {area:439}, юго-восток зоны {zone:1441}.",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "\"Отчаянный\" Джонсон",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "Ученик Тирта — \"Отчаянный\" Джонсон, маленькая серая курица у гоночной трассы. Выберите его целью и введите /beckon: он ненадолго становится человеком, и можно с ним поговорить.",

	-- Step 6: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan
	["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "Тирт продал книгу Алому ордену. {area:796} стоит на северо-востоке зоны {zone:1420}; идите в крыло «Библиотека». Книга торчит из стены слева при входе в Атенеум, перед NPC {npc:6487}.",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951}: Монастырь Алого ордена, библиотека",

	-- Step 7: Back to Tabetha
	-- {npc:6546} Tabetha
	["Back to {npc:6546}"] = "Вернитесь: {npc:6546}",

	-- Step 8: Witherbark trolls
	["Witherbark trolls"] = "Тролли из племени Сухокожих",
	-- {zone:1417} Arathi Highlands · {item:7273} Witherbark Totem Stick · {item:7272} Bolt Charged Bramble · {npc:6546} Tabetha · {item:1529} Jade
	-- plural, as words: Tin Veins = {object:1732} Tin Vein
	["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "Тролли из племени Сухокожих занимают юго-восток зоны {zone:1417}; с любого из них может выпасть {item:7273}. Затем отнесите десять палочек на северо-запад к кругу связывания, где они станут предметом {item:7272}. {npc:6546} также нужен {item:1529}: купите его на аукционе по пути; шахтеры иногда находят его в оловянных жилах.",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "Ритуал: {npc:6546}",
}
