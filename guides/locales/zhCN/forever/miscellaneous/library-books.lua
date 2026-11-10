-- Chinese (simplified) (zhCN): the guide forever/miscellaneous/library-books (forever/miscellaneous/library-books.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- plural, as words: Library Books = {object:386691} Library Book
	["Library Books"] = "图书馆藏书",
	["Lost books and scrolls all over the world: each pays experience at the library, and 10, 20 and 25 of them earn a necklace, a ring and an off-hand."] = "世界各地散落着书籍和卷轴：每本交给图书馆都可获得经验，交够10本、20本和25本后可分别获得一条项链、一枚戒指和一件副手物品。",

	-- Step 1: Elwynn Forest
	-- {area:91} Tower of Azora · {area:87} Goldshire
	["Halfway up the {area:91}, east of {area:87}. Nothing hostile inside."] = "在 {area:87} 东侧、{area:91} 的半山腰。里面没有敌对生物。",

	-- Step 2: Westfall
	-- {area:20} Moonbrook · {area:108} Sentinel Hill
	["Two books: one in a house at {area:20}, one at {area:108} (Alliance only)."] = "两本书：一本在{area:20}的一间房屋里，另一本在{area:108}（仅限联盟）。",
	["Rumi of Gnomeregan"] = "诺莫瑞根的 鲁米",

	-- Step 3: Duskwood
	-- {area:2098} Dawning Wood Catacombs · {zone:1431} Duskwood
	["The spellbook lies in the {area:2098}, the crypt in north-western {zone:1431}. Undead fill it; a corpse run works if you are low."] = "法术书位于 {zone:1431} 西北的墓穴 {area:2098} 内。里面到处是亡灵；等级较低时可以靠跑尸进去。",

	-- Step 5: Loch Modan
	-- {area:144} Thelsamar · {area:108} Sentinel Hill
	["Scrolls in the Mo'grosh ogre cave in the north-east. The ogres in the cave are level 18-19 elites: grouping up is advised. (Rumi of Gnomeregan also lies in {area:144}, if you missed it at {area:108}.)"] = "卷轴在东北面的莫格罗什食人魔洞穴里。洞内食人魔是18-19级精英，建议组队。（如果你在{area:108}漏掉了《诺莫瑞根的鲁米》，{area:144}也有一本。）",

	-- Step 6: Wetlands
	-- {area:118} Whelgar's Excavation Site · {zone:1437} Wetlands
	["At {area:118}, the dig in the middle of the {zone:1437}."] = "在{zone:1437}中部的挖掘场{area:118}。",

	-- Step 7: Silverpine Forest
	-- {area:233} Ambermill
	["At {area:233}, the mage village in south-eastern Silverpine."] = "在银松森林东南部的法师村庄 {area:233}。",

	-- Step 8: Tirisfal Glades
	-- {area:159} Brill
	["On a shelf in {area:159}'s apothecary."] = "在 {area:159} 炼金房的架子上。",

	-- Step 9: Darkshore
	-- {area:443} Ruins of Mathystra · {zone:1439} Darkshore
	["Down the stairs at the {area:443} in northern {zone:1439}."] = "在{zone:1439}北部的{area:443}，沿楼梯向下。",

	-- Step 10: Stonetalon Mountains
	-- {area:2537} Grimtotem Post
	["On a barrel in a tent at {area:2537}, in the far south-east of the zone."] = "在该地区最东南方 {area:2537} 的一顶帐篷内，放在桶上。",

	-- Step 11: The Barrens
	-- {area:382} Sludge Fen · {object:407566} Goblin Tome (no name in this language: may be words) · {area:392} Ratchet
	["Two books: the manual in the control room at the top of the oil rig at the {area:382}, and the {object:407566} beside Gazlowe in {area:392}."] = "两本书：一本是{area:382}石油平台顶部控制室里的手册，另一本是{area:392}加兹鲁维身旁的{object:407566}。",

	-- Step 12: The Wailing Caverns' cave
	-- {area:718} Wailing Caverns
	["The {area:718}' cave"] = "{area:718} 的洞穴",
	-- {area:387} Lushwater Oasis · {area:718} Wailing Caverns
	["The scrolls lie underground, in the cave below {area:387} by the {area:718} entrance, not inside the dungeon. Go in at the cave mouth in the oasis and follow the cave down; the arrow points at the scrolls from the surface."] = "卷轴在地下，位于 {area:387} 下方、{area:718} 入口旁的洞穴里，不在地下城内部。从绿洲的洞口进入，沿洞穴往下走；在地表时，箭头指向的就是地下卷轴的位置。",
	-- {area:387} Lushwater Oasis
	["Cave mouth at {area:387}"] = "{area:387} 的洞口",

	-- Step 13: Orgrimmar
	-- {object:405149} Mural of Ta'zo (no name in this language: may be words) · {object:172961} Valley of Spirits
	["The {object:405149} is the stone tablet leaning against the wall in the {object:172961}, on the way to the mage trainers. Use it to take the book."] = "{object:405149}是{object:172961}中斜靠在墙边的石板，就在前往法师训练师的路上。使用它即可拿到书。",

	-- Step 14: The library: first books
	["The library: first books"] = "图书馆：第一批书籍",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in the books so far. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "交还目前找到的书。{npc:211033}在{object:2101}巫师圣殿顶层管理图书馆。背包里有相应书籍时，他就会提供对应任务：一本一本接受并交还，避免占满任务日志。未找到的书直接跳过。",

	-- Step 15: The library: first books (Horde)
	["The library: first books (Horde)"] = "图书馆：第一批书（部落）",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in the books so far. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "交还目前找到的书。{npc:211022}在{object:36082}管理图书馆。只要书在背包中，他就会提供对应任务：逐本接受并交还，避免占满任务日志。没有找到的书就跳过。",

	-- Step 16: Friend of the Library
	-- {quest:78150} Friend of the Library · {item:277203} Scholarly Pendant · {item:277204} Erudite's Amulet
	["With 10 different books handed in, the librarian offers {quest:78150}: a choice of two necklaces ({item:277203} or {item:277204}). Take it when it appears."] = "交还10本不同的书后，图书管理员会提供{quest:78150}：两条项链二选一（{item:277203}或{item:277204}）。任务出现时就接。",

	-- Step 17: Alterac Mountains
	-- {area:1357} Gallows' Corner
	["Inside the first tower of the ogre fort at {area:1357}, in the middle of the zone."] = "在该地区中部 {area:1357} 的食人魔堡垒第一座塔楼内。",

	-- Step 18: Arathi Highlands
	["Beside a tent entrance in the troll village in south-eastern Arathi."] = "在阿拉希东南部巨魔村落的一顶帐篷入口旁。",

	-- Step 19: Stranglethorn Vale
	-- {area:310} Crystalvein Mine
	["On a bench beside the {area:310} entrance, in the middle of the zone."] = "在地区中部，{area:310}入口旁的长椅上。",

	-- Step 20: Badlands
	["Inside a crypt near the middle of the zone, reached from the path to its south."] = "在地区中部附近的一座墓穴里，从其南侧的小路进入。",

	-- Step 21: Swamp of Sorrows
	-- {area:1477} Temple of Atal'Hakkar
	["On the top walkway of the {area:1477}, outside the dungeon."] = "在{area:1477}顶部的走道上，地下城外。",

	-- Step 23: Thousand Needles
	-- {area:2097} Darkcloud Pinnacle
	["Inside a hut on the {area:2097} mesa."] = "在{area:2097}台地的一间小屋里。",

	-- Step 24: Dustwallow Marsh
	["On the ground at the eastern side of the murloc camp in north-eastern Dustwallow."] = "在尘泥沼泽东北部鱼人营地东侧的地上。",

	-- Step 25: The library: second books
	["The library: second books"] = "图书馆：第二批书籍",
	-- {npc:211033} Garion Wendell · {object:2101} Mage Quarter
	["Hand in this part's books. {npc:211033} keeps the library at the top of the Wizard's Sanctum in the {object:2101}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "交还本段找到的书。{npc:211033}在{object:2101}巫师圣殿顶层管理图书馆。背包里有相应书籍时，他就会提供对应任务：一本一本接受并交还，避免占满任务日志。未找到的书直接跳过。",

	-- Step 26: The library: second books (Horde)
	["The library: second books (Horde)"] = "图书馆：第二批书籍（部落）",
	-- {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["Hand in this part's books. {npc:211022} keeps the library in the {object:36082}. He offers each book's quest while the book is in your bags: take it and hand it in, one at a time, so your quest log stays free. Skip the books you did not find."] = "交还本部分收集到的书籍。{npc:211022} 管理着 {object:36082} 中的图书馆。只要书在背包中，他就会提供对应任务：一次接受并交还一本，让任务日志保持空余。没找到的书就跳过。",

	-- Step 27: Greater Friend of the Library
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:281634} Field Researcher's Loop · {item:281635} Philanthropist's Ring
	["From level 20, with 20 different books handed in, {npc:211033} offers {quest:79536}: {item:281634} or {item:281635}."] = "达到 20 级且已交还 20 本不同书籍后，{npc:211033} 会提供 {quest:79536}：奖励 {item:281634} 或 {item:281635}。",

	-- Step 28: The Hinterlands
	-- {area:353} Shadra'Alor · {zone:1425} The Hinterlands
	["In the troll ruins of {area:353}, in the south of the {zone:1425}."] = "在{zone:1425}南部{area:353}的巨魔废墟里。",

	-- Step 29: Searing Gorge
	["On a table inside a tent near the middle of the zone."] = "在地区中部附近一顶帐篷内的桌子上。",

	-- Step 30: Blackrock Mountain
	-- {area:254} Blackrock Mountain · {npc:8888} Franclorn Forgewright · {npc:14387} Lothos Riftwaker
	["Inside {area:254}, not in a dungeon: the book lies on the altar in {npc:8888}'s tomb, near {npc:14387}. The waypoint marks the mountain."] = "在{area:254}内部，不在地下城中：书位于{npc:8888}墓穴的祭坛上，靠近{npc:14387}。路径点标记的是整座山。",

	-- Step 32: Azshara
	-- {area:1236} Haldarr Encampment · {zone:1447} Azshara
	["On a crate in the {area:1236}, in the far west of {zone:1447}."] = "在 {zone:1447} 最西边的 {area:1236}，放在一个箱子上。",

	-- Step 33: Tanaris
	["On a bookshelf in the middle building of the pirate camp on the eastern coast."] = "在东海岸海盗营地中央建筑内的书架上。",

	-- Step 34: The library: third books
	["The library: third books"] = "图书馆：第三批书",

	-- Step 35: The library: third books (Horde)
	["The library: third books (Horde)"] = "图书馆：第三批书籍（部落）",

	-- Step 36: The second Greater Friend of the Library
	-- {quest:79536} Greater Friend of the Library
	["The second {quest:79536}"] = "第二次{quest:79536}",
	-- {npc:211033} Garion Wendell · {quest:79536} Greater Friend of the Library · {item:277254} Truthseeker's Bow · {item:277258} Crest of Elucidation · {item:277260} Researcher's Night Light
	["From level 35, with 25 different books handed in, {npc:211033} offers the second {quest:79536}: {item:277254}, {item:277258} or {item:277260} (level 40 to equip)."] = "达到35级并交还25本不同的书后，{npc:211033}会提供第二次{quest:79536}：{item:277254}、{item:277258}或{item:277260}（40级可装备）。",

	-- Step 37: Level 60 books: Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Level 60 books: {zone:1422}"] = "60级书籍：{zone:1422}",
	-- {item:228141} Necromancy 101 · {area:2298} Caer Darrow · {area:2057} Scholomance · {item:228132} Undead Potatoes · {area:199} Felstone Field
	["Eight more books lie in level 55-60 zones; the mage trainers beside the librarians take them, not the librarians. {item:228141} lies on a table in the ruined keep on {area:2298}, above {area:2057} (outside the dungeon); {item:228132} at {area:199}."] = "55-60级地区另有8本书；接收它们的是图书管理员旁边的法师训练师，而非管理员本人。{item:228141}放在{area:2298}废弃要塞的一张桌上，位于{area:2057}上方（地下城外）；{item:228132}在{area:199}。",

	-- Step 38: Level 60 books: Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Level 60 books: {zone:1423}"] = "60级书籍：{zone:1423}",
	-- {item:228135} A Study of the Light · {area:2268} Light's Hope Chapel · {item:228138} The Knight and the Lady · {area:2264} Corin's Crossing · {area:2279} Stratholme · {item:228140} Scourge: Undead Menace or Misunderstood? · {area:2277} Plaguewood
	["{item:228135} is inside {area:2268}. {item:228138} lies at {area:2264}; other copies lie elsewhere in the zone (one by the {area:2279} gates), and you can take only one. {item:228140} is on a table in {area:2277}: wait for the patrolling elite to clear the creatures beside it and walk on."] = "{item:228135}在{area:2268}内。{item:228138}在{area:2264}；本地区其他地方也有副本（其中一本在{area:2279}大门旁），但只能拿一本。{item:228140}在{area:2277}的一张桌子上：等巡逻精英清掉桌旁的生物并走开后再拿。",

	-- Step 39: Level 60 books: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Level 60 books: {area:1769}"] = "60级书籍：{area:1769}",
	-- {item:228134} Northern Kalimdor - A Comprehensive Guide · {area:1769} Timbermaw Hold · {zone:1448} Felwood · {zone:1452} Winterspring
	["{item:228134} lies inside the {area:1769} tunnel between {zone:1448} and {zone:1452}."] = "{item:228134} 位于 {zone:1448} 与 {zone:1452} 之间的 {area:1769} 隧道内。",

	-- Step 40: Level 60 books: Everlook
	-- {area:2255} Everlook
	["Level 60 books: {area:2255}"] = "60级书籍：{area:2255}",
	-- {item:228136} Ka-Boom! · {area:2255} Everlook
	["{item:228136} sits on a shelf behind the alchemy supplier in {area:2255}."] = "{item:228136} 放在 {area:2255} 炼金供应商身后的架子上。",

	-- Step 41: Level 60 books: Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Level 60 books: {area:254}"] = "60级书籍：{area:254}",
	-- {item:228133} Magma or Lava? · {area:254} Blackrock Mountain · {area:1584} Blackrock Depths · {area:2717} Molten Core
	["{item:228133} lies inside {area:254}, in the mine passage towards {area:1584} beyond the {area:2717} quest giver. The waypoint marks the mountain."] = "{item:228133}位于{area:254}内，在{area:2717}任务给予者后方通往{area:1584}的矿道中。路径点标记的是这座山。",

	-- Step 42: The level 60 books: Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["The level 60 books: {npc:5497}"] = "60级书籍：{npc:5497}",
	-- {npc:5497} Jennea Cannon · {npc:211033} Garion Wendell · {item:228132} Undead Potatoes · {item:228138} The Knight and the Lady · {item:228140} Scourge: Undead Menace or Misunderstood?
	["{npc:5497}, the mage trainer beside {npc:211033} in the Wizard's Sanctum, takes the level 60 books: she offers each book's quest while the book is in your bags. Hand in {item:228132}, {item:228138} and {item:228140} the same way (their quests are not in Polestar's data yet)."] = "巫师圣殿内、{npc:211033}旁的法师训练师{npc:5497}会收取60级书籍：只要书在背包里，她就会提供对应任务。{item:228132}、{item:228138}和{item:228140}也按同样方式交还（这些任务暂未收录在Polestar数据中）。",

	-- Step 43: The level 60 books: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe
	["The level 60 books: {npc:7825}"] = "60级书籍：{npc:7825}",
	-- {npc:7825} Oran Snakewrithe · {npc:211022} Owen Thadd · {object:36082} Magic Quarter
	["{npc:7825}, beside {npc:211022} in the {object:36082}, takes the level 60 books: each book's quest is offered while the book is in your bags. Take and hand them in one at a time (Polestar cannot track these quests for the Horde yet)."] = "{object:36082}里、{npc:211022}旁边的{npc:7825}接收60级书籍：背包里有相应书籍时，就会提供对应任务。一本一本接受并交还（Polestar 暂时无法为部落追踪这些任务）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lost books and scrolls all over the world: each pays experience at the library, and enough of them earn a {quest:78150} reward."] = "世界各地散落着书籍和卷轴：交给图书馆可获得经验，交够数量后还可领取{quest:78150}奖励。",
}
