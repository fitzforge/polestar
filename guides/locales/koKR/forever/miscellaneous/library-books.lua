-- Korean (koKR): the guide forever/miscellaneous/library-books (forever/miscellaneous/library-books.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Library Books = {object:386759} Library Book
	["Library Books"] = "도서관 책",
	["Lost books and scrolls all over the world: each pays experience at the library, and 10, 20 and 25 of them earn a necklace, a ring and an off-hand."] = "세계 곳곳에 잃어버린 책과 두루마리: 각각 도서관에서 경험치를 주고, 10권, 20권, 25권을 가져오면 목걸이, 반지, 보조장비를 줍니다.",

	-- Step 1: Elwynn Forest
	-- {area:91} Tower of Azora · {area:87} Goldshire
	["Halfway up the {area:91}, east of {area:87}. Nothing hostile inside."] = "{area:91} 중간 언덕, {area:87} 동쪽. 안에는 적이 없습니다.",

	-- Step 2: Westfall
	-- {area:20} Moonbrook · {area:108} Sentinel Hill
	["Two books: one in a house at {area:20}, one at {area:108} (Alliance only)."] = "책 두 권: 하나는 {area:20}의 집에, 하나는 {area:108}에(얼라이언스 전용).",
	["Rumi of Gnomeregan"] = "그놈레간의 루미",

	-- Step 3: Duskwood
	-- {area:2098} Dawning Wood Catacombs · {zone:1431} Duskwood
	["The spellbook lies in the {area:2098}, the crypt in north-western {zone:1431}. Undead fill it; a corpse run works if you are low."] = "마법서는 북서쪽 {zone:1431}의 지하 묘지 {area:2098}에 있습니다. 언데드가 가득하고, 레벨이 낮으면 시체 달리기가 통합니다.",

	-- Step 5: Loch Modan
	-- {area:144} Thelsamar · {area:108} Sentinel Hill
	["Scrolls in the Mo'grosh ogre cave in the north-east. The ogres in the cave are level 18-19 elites: grouping up is advised. (Rumi of Gnomeregan also lies in {area:144}, if you missed it at {area:108}.)"] = "두루마리는 북동쪽 모쉬오그 오우거 동굴에 있습니다. 동굴의 오우거는 18-19레벨 정예이니 파티를 꾸리세요. ({area:108}에서 놓쳤다면 {area:144}에도 루미가 있습니다.)",

	-- Step 6: Wetlands
	-- {area:118} Whelgar's Excavation Site · {zone:1437} Wetlands
	["At {area:118}, the dig in the middle of the {zone:1437}."] = "{area:118}, {zone:1437} 한가운데의 발굴지.",

	-- Step 7: Silverpine Forest
	-- {area:233} Ambermill
	["At {area:233}, the mage village in south-eastern Silverpine."] = "{area:233}, 은빛소나무 숲 남동쪽의 마법사 마을.",

	-- Step 8: Tirisfal Glades
	-- {area:159} Brill
	["On a shelf in {area:159}'s apothecary."] = "{area:159} 약국의 선반 위.",

	-- Step 9: Darkshore
	-- {area:443} Ruins of Mathystra · {zone:1439} Darkshore
	["Down the stairs at the {area:443} in northern {zone:1439}."] = "북부 {zone:1439}의 {area:443} 계단 아래.",

	-- Step 10: Stonetalon Mountains
	-- {area:2537} Grimtotem Post
	["On a barrel in a tent at {area:2537}, in the far south-east of the zone."] = "{area:2537}의 천막 안 통 위, 지역의 남동쪽 끝.",

	-- Step 11: The Barrens
	-- {area:382} Sludge Fen · {object:407566} Goblin Tome (no name in this language: may be words) · {area:392} Ratchet
	["Two books: the manual in the control room at the top of the oil rig at the {area:382}, and the {object:407566} beside Gazlowe in {area:392}."] = "책 두 권: {area:382} 시추 기지 꼭대기 제어실의 설명서와 {area:392}의 가즈로 옆 {object:407566}.",

	-- Step 12: The Wailing Caverns' cave
	-- {area:718} Wailing Caverns
	["The {area:718}' cave"] = "{area:718} 동굴",
	-- {area:387} Lushwater Oasis · {area:718} Wailing Caverns
	["The scrolls lie underground, in the cave below {area:387} by the {area:718} entrance, not inside the dungeon. Go in at the cave mouth in the oasis and follow the cave down; the arrow points at the scrolls from the surface."] = "두루마리는 지하에, {area:718} 입구 옆 {area:387} 아래 동굴에 있으며 던전 안이 아닙니다. 오아시스의 동굴 입구로 들어가 동굴을 따라 내려가세요. 화살표는 지표면에서 두루마리를 가리킵니다.",
	-- {area:387} Lushwater Oasis
	["Cave mouth at {area:387}"] = "{area:387}의 동굴 입구",

	-- Step 13: Orgrimmar
	-- {object:405149} Mural of Ta'zo (no name in this language: may be words) · {object:172961} Valley of Spirits
	["The {object:405149} is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "{object:405149}는(은) 마법 교관에게 가는 길에 있는 {object:172961}의 벽에 기대어 있는 돌 석판입니다. 사용해서 책을 가져가세요.",

	-- Step 14: The library: first books
	["The library: first books"] = "도서관: 첫번째 책",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in the books so far. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "지금까지의 책을 제출하세요. {npc:211033}은(는) {object:2101}의 마법사 성소 꼭대기에서 도서관을 지킵니다. 책이 가방에 있는 동안 각 책의 퀘스트를 주니 하나씩 받아 제출해 퀘스트 목록을 비워 두세요. 찾지 못한 책은 건너뛰세요.",

	-- Step 15: The library: first books (Horde)
	["The library: first books (Horde)"] = "도서관: 첫번째 책(호드)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in the books so far. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "지금까지의 책을 제출하세요. {npc:211022}은(는) {object:36082}에서 도서관을 지킵니다. 책이 가방에 있는 동안 각 책의 퀘스트를 주니 하나씩 받아 제출해 퀘스트 목록을 비워 두세요. 찾지 못한 책은 건너뛰세요.",

	-- Step 16: Friend of the Library
	-- {quest:78150} Friend of the Library · {item:277203} Scholarly Pendant · {item:277204} Erudite's Amulet
	["With 10 different books handed in, the librarian offers {quest:78150}: a choice of two necklaces ({item:277203} or {item:277204}). Take it when it appears."] = "10권을 다른 책으로 제출하면 사서가 {quest:78150}을(를) 줍니다: 목걸이 둘 중 선택({item:277203} 또는 {item:277204}). 나타나면 받으세요.",

	-- Step 17: Alterac Mountains
	-- {area:1357} Gallows' Corner
	["Inside the first tower of the ogre fort at {area:1357}, in the middle of the zone."] = "{area:1357} 오우거 요새의 첫 번째 탑 안, 지역 한가운데.",

	-- Step 18: Arathi Highlands
	["Beside a tent entrance in the troll village in south-eastern Arathi."] = "아라티 남동쪽 트롤 마을의 천막 입구 옆.",

	-- Step 19: Stranglethorn Vale
	-- {area:310} Crystalvein Mine
	["On a bench beside the {area:310} entrance, in the middle of the zone."] = "{area:310} 입구 옆 벤치 위, 지역 한가운데.",

	-- Step 20: Badlands
	["Inside a crypt near the middle of the zone, reached from the path to its south."] = "지역 한가운데 근처 묘실 안, 남쪽으로 가는 길에서 들어갑니다.",

	-- Step 21: Swamp of Sorrows
	-- {area:1477} Temple of Atal'Hakkar
	["On the top walkway of the {area:1477}, outside the dungeon."] = "{area:1477}의 윗 복도, 던전 밖.",

	-- Step 23: Thousand Needles
	-- {area:2097} Darkcloud Pinnacle
	["Inside a hut on the {area:2097} mesa."] = "{area:2097} 고원의 오두막 안.",

	-- Step 24: Dustwallow Marsh
	["On the ground at the eastern side of the murloc camp in north-eastern Dustwallow."] = "북동쪽 먼지아지랑이 습지 멀록 야영지 동쪽의 지상.",

	-- Step 25: The library: second books
	["The library: second books"] = "도서관: 두번째 책",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in this part's books. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "이 부분의 책을 제출하세요. {npc:211033}은(는) {object:2101}의 마법사 성소 꼭대기에서 도서관을 지킵니다. 책이 가방에 있는 동안 각 책의 퀘스트를 주니 하나씩 받아 제출해 퀘스트 목록을 비워 두세요. 찾지 못한 책은 건너뛰세요.",

	-- Step 26: The library: second books (Horde)
	["The library: second books (Horde)"] = "도서관: 두번째 책(호드)",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in this part's books. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "이 부분의 책을 제출하세요. {npc:211022}은(는) {object:36082}에서 도서관을 지킵니다. 책이 가방에 있는 동안 각 책의 퀘스트를 주니 하나씩 받아 제출해 퀘스트 목록을 비워 두세요. 찾지 못한 책은 건너뛰세요.",

	-- Step 27: Greater Friend of the Library
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:281634} Field Researcher's Loop · {item:281635} Philanthropist's Ring
	["From level 20, with 20 different books handed in, {npc:211033} offers {quest:79536}: {item:281634} or {item:281635}."] = "20레벨부터 20권을 다른 책으로 제출하면 {npc:211033}이(가) {quest:79536}을(를) 줍니다: {item:281634} 또는 {item:281635}.",

	-- Step 28: The Hinterlands
	-- {area:353} Shadra'Alor · {zone:1425} The Hinterlands
	["In the troll ruins of {area:353}, in the south of the {zone:1425}."] = "{zone:1425} 남부의 트롤 폐허 {area:353}.",

	-- Step 29: Searing Gorge
	["On a table inside a tent near the middle of the zone."] = "지역 한가운데 근처 천막 안의 탁자 위.",

	-- Step 30: Blackrock Mountain
	-- {area:254} Blackrock Mountain · {npc:8888} Franclorn Forgewright · {npc:14387} Lothos Riftwaker
	["Inside {area:254}, not in a dungeon: the book lies on the altar in {npc:8888}'s tomb, near {npc:14387}. The waypoint marks the mountain."] = "{area:254} 안, 던전이 아닙니다: 책은 {npc:14387} 근처, {npc:8888}의 무덤에 있는 제단 위에 있습니다. 경유지는 산을 표시합니다.",

	-- Step 32: Azshara
	-- {area:1236} Haldarr Encampment · {zone:1447} Azshara
	["On a crate in the {area:1236}, in the far west of {zone:1447}."] = "{area:1236}의 나무 상자 위, {zone:1447}의 서쪽 끝.",

	-- Step 33: Tanaris
	["On a bookshelf in the middle building of the pirate camp on the eastern coast."] = "동쪽 해안 해적 야영지 가운데 건물의 책장 위.",

	-- Step 34: The library: third books
	["The library: third books"] = "도서관: 세번째 책",

	-- Step 35: The library: third books (Horde)
	["The library: third books (Horde)"] = "도서관: 세번째 책(호드)",

	-- Step 36: The second Greater Friend of the Library
	-- {quest:79536} Greater Friend of the Library
	["The second {quest:79536}"] = "두 번째 {quest:79536}",
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:277254} Truthseeker's Bow · {item:277258} Crest of Elucidation · {item:277260} Researcher's Night Light
	["From level 35, with 25 different books handed in, {npc:211033} offers the second {quest:79536}: {item:277254}, {item:277258} or {item:277260} (level 40 to equip)."] = "35레벨부터 25권을 다른 책으로 제출하면 {npc:211033}이(가) 두 번째 {quest:79536}을(를) 줍니다: {item:277254}, {item:277258} 또는 {item:277260}(40레벨에 장착).",

	-- Step 37: Level 60 books: Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Level 60 books: {zone:1422}"] = "60레벨 책: {zone:1422}",
	-- {item:228141} Necromancy 101 · {area:2298} Caer Darrow · {area:2057} Scholomance · {item:228132} Undead Potatoes · {area:199} Felstone Field
	["Eight more books lie in level 55-60 zones; the mage trainers beside the librarians take them, not the librarians. {item:228141} lies on a table in the ruined keep on {area:2298}, above {area:2057} (outside the dungeon); {item:228132} at {area:199}."] = "여덟 권이 더 55-60레벨 지역에 있습니다. 사서가 아니라 사서 옆의 마법 교관이 받습니다. {item:228141}은(는) {area:2057} 위의 {area:2298} 부서진 성채 탁자 위에 있습니다(던전 밖). {item:228132}은(는) {area:199}에 있습니다.",

	-- Step 38: Level 60 books: Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Level 60 books: {zone:1423}"] = "60레벨 책: {zone:1423}",
	-- {item:228135} A Study of the Light · {area:2268} Light's Hope Chapel · {item:228138} The Knight and the Lady · {area:2264} Corin's Crossing · {area:2279} Stratholme · {item:228140} Scourge: Undead Menace or Misunderstood? · {area:2277} Plaguewood
	["{item:228135} is inside {area:2268}. {item:228138} lies at {area:2264}; other copies lie elsewhere in the zone (one by the {area:2279} gates), and you can take only one. {item:228140} is on a table in {area:2277}: wait for the patrolling elite to clear the creatures beside it and walk on."] = "{item:228135}은(는) {area:2268} 안에 있습니다. {item:228138}은(는) {area:2264}에 있고, 다른 복사본은 지역의 다른 곳에 있으며({area:2279} 관문 옆에 하나), 하나만 가져갈 수 있습니다. {item:228140}은(는) {area:2277}의 탁자 위에 있습니다: 순찰하는 정예가 그 옆의 생물을 정리하도록 기다렸다 가세요.",

	-- Step 39: Level 60 books: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Level 60 books: {area:1769}"] = "60레벨 책: {area:1769}",
	-- {item:228134} Northern Kalimdor - A Comprehensive Guide · {area:1769} Timbermaw Hold · {zone:1448} Felwood · {zone:1452} Winterspring
	["{item:228134} lies inside the {area:1769} tunnel between {zone:1448} and {zone:1452}."] = "{item:228134}은(는) {zone:1448}과(와) {zone:1452} 사이 {area:1769} 터널 안에 있습니다.",

	-- Step 40: Level 60 books: Everlook
	-- {area:2255} Everlook
	["Level 60 books: {area:2255}"] = "60레벨 책: {area:2255}",
	-- {item:228136} Ka-Boom! · {area:2255} Everlook
	["{item:228136} sits on a shelf behind the alchemy supplier in {area:2255}."] = "{item:228136}은(는) {area:2255}의 연금술 상인 뒤 선반에 있습니다.",

	-- Step 41: Level 60 books: Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Level 60 books: {area:254}"] = "60레벨 책: {area:254}",
	-- {item:228133} Magma or Lava? · {area:254} Blackrock Mountain · {area:1584} Blackrock Depths · {area:2717} Molten Core
	["{item:228133} lies inside {area:254}, in the mine passage towards {area:1584} beyond the {area:2717} quest giver. The waypoint marks the mountain."] = "{item:228133}은(는) {area:254} 안, {area:2717} 퀘스트 주는 자 너머 {area:1584}를 향하는 갱도에 있습니다. 경유지는 산을 표시합니다.",

	-- Step 42: The level 60 books: Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["The level 60 books: {npc:5497}"] = "60레벨 책: {npc:5497}",
	-- {npc:5497} Jennea Cannon · {npc:211033} Garion Wendell · {item:228132} Undead Potatoes · {item:228138} The Knight and the Lady · {item:228140} Scourge: Undead Menace or Misunderstood?
	["{npc:5497}, the mage trainer beside {npc:211033} in the Wizard's Sanctum, takes the level 60 books: she offers each book's quest while the book is in your bags. Hand in {item:228132}, {item:228138} and {item:228140} the same way (their quests are not in Polestar's data yet)."] = "{npc:5497}, 마법사 성소에서 {npc:211033} 옆의 마법 교관이 60레벨 책을 받습니다. 책이 가방에 있는 동안 각 책의 퀘스트를 줍니다. {item:228132}, {item:228138}, {item:228140}도 같은 방식으로 제출하세요(아직 Polestar 데이터에 퀘스트가 없습니다).",

	-- Step 43: The level 60 books: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe
	["The level 60 books: {npc:7825}"] = "60레벨 책: {npc:7825}",
	-- {npc:7825} Oran Snakewrithe · {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["{npc:7825}, beside {npc:211022} in the {object:36082}, takes the level 60 books: each book's quest is offered while the book is in your bags. Take and hand them in one at a time (Polestar cannot track these quests for the Horde yet)."] = "{npc:7825}, {object:36082}에서 {npc:211022} 옆에 있으며 60레벨 책을 받습니다. 책이 가방에 있는 동안 각 책의 퀘스트가 주어집니다. 하나씩 받아 제출하세요(Polestar가 아직 호드 이 퀘스트를 추적하지 못합니다).",
}
