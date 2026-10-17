-- Korean (koKR): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A wand of your school for the 30s: frost, arcane or fire."] = "30레벨대를 위한 자신의 계열 마법봉: 냉기, 비전 또는 화염.",

	-- Step 1: Journey to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{zone:1453} {object:2101}의 마법사의 성소에 있는 {npc:5497}이(가) {npc:6546}에게 보냅니다. {zone:1455}의 빙크도 같은 퀘스트를 줍니다.",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{zone:1454}의 마법사 상급자 중 한 명인 {npc:5885}이(가) {npc:6546}에게 보냅니다. {zone:1458}의 {npc:4568}와(과) {zone:1456}의 {npc:3048}도 같은 퀘스트를 줍니다.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "은둔자 {npc:6546}은(는) 테라모어 섬 서쪽 늪 깊숙한 곳, {area:508} 바로 북쪽의 오두막에 삽니다.",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548}은(는) {zone:1441} 남동쪽 {area:439}의 경주로에서 지냅니다.",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "\"씩씩이\" 존슨",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "틸스의 제자는 경주로 옆의 작은 회색 닭 \"씩씩이\" 존슨입니다. 그를 대상으로 지정하고 /beckon을 입력하십시오. 잠시 인간으로 변해 대화할 수 있습니다.",

	-- Step 6: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan
	["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "틸스는 책을 붉은십자군에 팔았습니다. {area:796}은(는) {zone:1420} 북동쪽에 있습니다. 도서관 구역으로 가십시오. {npc:6487}이(가) 있는 방에 들어서면 그보다 앞쪽 왼쪽 벽에서 책이 튀어나와 있습니다.",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951}: 붉은십자군 수도원 도서관",

	-- Step 7: Back to Tabetha
	-- {npc:6546} Tabetha
	["Back to {npc:6546}"] = "{npc:6546}에게 돌아가기",

	-- Step 8: Witherbark trolls
	["Witherbark trolls"] = "마른나무껍질 트롤",
	-- {zone:1417} Arathi Highlands · {item:7273} Witherbark Totem Stick · {item:7272} Bolt Charged Bramble · {npc:6546} Tabetha · {item:1529} Jade
	-- plural, as words: Tin Veins = {object:1732} Tin Vein
	["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "마른나무껍질 트롤은 {zone:1417} 남동쪽을 차지하고 있으며, 모두 {item:7273}을(를) 떨어뜨릴 수 있습니다. 막대 열 개를 북서쪽의 결속의 원으로 가져가면 {item:7272}이(가) 됩니다. {npc:6546}은(는) {item:1529}도 원합니다. 가는 길에 경매장에서 하나 구매하십시오. 채광꾼이 주석 광맥에서 가끔 발견하기도 합니다.",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "{npc:6546}의 의식",
}
