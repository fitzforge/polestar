-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "進入{zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}就站在{area:1769}隧道的{zone:1452}出口，也就是你出來的地方。",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "從隧道向南騎：{npc:9298}在山谷西部{area:2246}冒著蒸氣的池塘之間紮營。",
	["Linken's letter"] = "林克的信",
	-- {quest:980} The New Springs
	["{quest:980}, from Krakle in Un'Goro"] = "",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas · {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide. {npc:9298}'s next errand, Strange Sources, is at the mouth of {area:2256} among level 59-60 elites: it waits for the last guide's {zone:1452} loop."] = "",

	-- Step 4: Winterspring
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {npc:9298} Donova Snowden
	["Ride east along the road past {area:2251} to {area:2255} first: its yeti and chimaera errands bring you about a quarter of a level, which the Frostfire furbolg camps want; {npc:9298}'s camps come on the ride back west."] = "",

	-- Step 5: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255}是山谷東側的哥布林城鎮，經過梟獸丘陵就到。",
	["Gregor's quests lead to other zones: keep them."] = "格雷戈的任務會通往其他地區：保留它們。",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}，在裡面",

	-- Step 6: Ice Thistle yetis
	["Ice Thistle yetis"] = "冰薊雪人",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur. Careful: the Ice Thistle Yetis are 55-56: take the 55s one at a time, and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "",

	-- Step 7: Chillwind chimaeras
	["Chillwind chimaeras"] = "冰風奇美拉",
	-- {area:2255} Everlook · {area:2251} Lake Kel'Theril · {area:2245} Mazthoril
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Careful: Chillwind Chimaeras are 55-57: take only the 55s, and the Fledgling Chillwinds (53-55) by {area:2251}, which carry the horns too. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "",

	-- Step 8: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	-- was: ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "烏米：先留著，完美的雪人角會在{zone:1423}指南約57級時的{area:2255}停留點收集"
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 56"] = "",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "帶著烏米要的角的雪人女王和雪人王是56-58級：留到之後那一站再打。",

	-- Step 9: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "狂怒的梟獸",
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {area:2246} Frostfire Hot Springs
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	-- was: ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "狂怒的梟獸在{area:2251}北邊的丘陵遊蕩，就在{area:2246}和{area:2255}之間的道路旁。小心：最大隻的是56級：一次拉一隻。"
	["Ride back west: Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2255} and {area:2246}. Careful: the biggest are level 56: pull them one at a time."] = "",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}：遇到就殺",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	-- was: ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "冬泉探路者、冬泉巢穴守衛和冬泉圖騰師共同佔據溫泉周圍的熊怪營地；蓬毛梟獸在營地之間的山坡上遊蕩。先殺圖騰師。把你拾取的每一份{item:14047}都留給梅羅什。\n小心：巢穴守衛最高56級：一次拉一隻，並遠離營地的圖騰。"
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers are 55-56: pull the 55s, one at a time, and keep clear of the camps' totems."] = "",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "{item:12771}：大約十個冬泉熊怪裡有一個帶著；一直殺到掉為止",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}，冬泉熊怪的稀有掉落",

	-- Step 11: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084}要在之後前往{zone:1448}時，到{object:176091}繳交。",

	-- Step 12: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飛往{area:431}",
	-- {zone:1448} Felwood · {area:2255} Everlook · {area:431} Splintertree Post · {area:1237} Valormok
	["{zone:1448}'s southern hand-ins are next: ride back east to {area:2255}'s flight master, fly to {area:431} (by way of {area:1237}) and ride north into {zone:1448}, so the forest is ridden once, south to north."] = "",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "{area:2255}飛行管理員",

	-- Step 13: Overlord Ror
	-- {zone:1448} Felwood · {area:1761} Deadwood Village
	["Ride north-west along the road into {zone:1448}. Ror stands at the far south end of {area:1761}, just inside the border."] = "",

	-- Step 14: Emerald Sanctuary
	["North to the druids' camp."] = "",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}，在聖地西側",
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {area:392} Ratchet
	["Keep {quest:5158}: {npc:5901} is by {area:392}, on the next guide."] = "",

	-- Step 15: The Jadefire moonwell
	["The Jadefire moonwell"] = "碧火月井",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride north-west past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "",

	-- Step 16: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["North up the road to {area:1997}."] = "",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996}：{quest:86612}",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring · {zone:1423} Eastern Plaguelands
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{npc:10306}'s Moontouched Owlbeasts are 57-58, in {zone:1452}: keep it for the {zone:1423} guide's {zone:1452} stop."] = "",

	-- Step 17: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}的小貓",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten back to the Jadefire moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "{item:12565}，在碧火月井",

	-- Step 19: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飛往{area:1099}",
	-- {area:1997} Bloodvenom Post
	["{area:1997} flight master"] = "",

	-- Step 21: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "{item:11242}生長在{npc:7775}營地北邊、鷹身人的{area:1114}東邊一棟廢墟建築裡：從牆壁的破損處爬進去。",

	-- Step 22: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "往南回到{npc:7775}那裡。留著藥劑，先別喝：喝了會死，而這正是之後在{area:976}附近見到蓋瑞恩的方法。",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}，{npc:7775}的獎勵",

	-- Step 24: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飛行管理員",

	-- Step 25: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881}和{npc:14728}站在{area:1641}。魯姆斯塔格的每次捐獻都要從揹包裡拿出六十份毛料、絲綢或魔紋布：身上有就交，沒有就跳過。",

	-- Step 26: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}的{npc:3033}；{npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123}在{zone:1450}等著：保留到稍後。",

	-- Step 27: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087}收購你用{quest:3761}種出的{item:11040}。{quest:3782}需要十個，而{item:11020}每十分鐘只能試一次：只有在你已經帶著穀物時才去接。",

	-- Step 29: Magatha Grimtotem
	-- {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise
	["{npc:4046} stands on {area:1639}."] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["Delivery to {npc:4046}, from Jediga in {zone:1447}"] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["{npc:4046}'s payment goes back to Jediga in {zone:1447}, which the route doesn't pass again: leave it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "任何冬泉熊怪都可能帶著珠串；{npc:11556}南邊的營地最近。",
	-- ["Back at {area:1099}."] = "回到{area:1099}。",
	-- ["Back to {area:2255}"] = "返回{area:2255}",
	-- ["Below ground"] = "地下",
	-- ["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "兩項{item:14047}捐獻都在路線後段交付：想要的話各留六十張{item:14047}。",
	-- ["Chillwind chimaeras"] = "冰風奇美拉",
	-- ["Fly to {area:1637}"] = "飛往{area:1637}",
	-- ["From Krakle in Un'Goro"] = "來自安戈洛的克拉蘭克",
	-- ["Frostfire Winterfall camp"] = "冰火溫泉的冬泉營地",
	-- ["Frostfire Winterfall camps"] = "冰火溫泉的冬泉營地",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "格雷戈和哈魯的任務會通往其他地區：保留它們。",
	-- ["Grind to 55"] = "練到55級",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "他站在{area:1641}。每次捐獻都需要你背包裡的布料；有布料時再繳交，在路線稍後。",
	-- ["In the {object:172958}."] = "在{object:172958}。",
	-- ["In the {object:172961}."] = "在{object:172961}。",
	-- ["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "在{object:172961}。每項捐獻從你揹包中消耗六十張毛料、絲綢或魔紋布：身上帶著的就交，其餘跳過。",
	-- ["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "雪人女王和雪人王打得很痛：一次拉一隻。",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "冬泉探路者、冬泉巢穴守衛和冬泉圖騰師共同佔據溫泉周圍的熊怪營地；蓬毛梟獸在營地之間的山坡上遊蕩。先殺圖騰師。把你拾取的每一份{item:14047}都留給梅羅什。",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "冬泉探路者、冬泉巢穴守衛和冬泉圖騰師共同佔據溫泉周圍的熊怪營地；蓬毛梟獸在營地之間的山坡上遊蕩。先殺圖騰師。把你拾取的每一份{item:14047}都留給梅羅什。\n小心：巢穴守衛最高56級：一次拉一隻，並遠離營地的圖騰。",
	-- ["Pristine Yeti Horns"] = "完美的雪人角",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "狂怒的梟獸在{area:2251}北邊的丘陵遊蕩，就在{area:2246}和{area:2255}之間的道路旁。小心：最大隻的是56級：一次拉一隻。",
	-- ["Ride back west to {area:2246}."] = "向西騎回{area:2246}。",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向東騎，然後沿著{area:2249}向南走。那裡的霜槌巨人是59級精英：走在中間並持續移動。奇怪的來源在南端的{area:2256}入口。",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "沿著道路向西騎過{area:2251}；狂怒的梟獸在湖北邊的山丘上遊蕩。",
	-- ["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "奇美拉在{area:2255}南邊和西邊的雪原上遊蕩。避開{area:2245}的洞穴：裡面的藍龍是精英。",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "熊怪村莊佔據{area:2255}東北方的山谷。先殺冬泉薩滿；他們會治療。後方洞穴裡的{npc:10738}是精英：不要進去。",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "雪人山丘從{area:2255}東南方不遠處開始。每隻雪人都會掉落毛皮：打冰薊雪人（55-56級），別碰冰薊雪人女王和冰薊雪人王（56-58級），牠們的角之後再來收集。",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "雪人山丘從{area:2255}東南方不遠處開始。每隻雪人都會掉落毛皮；只有冰薊雪人女王和冰薊雪人王會掉落角，所以把角留到繳交之後再收集。",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "先在這裡刷到55.04級，再去{area:2255}繳交任務，交完會升到56級。冰薊雪人（55-56級）是這裡等級最低的；冰薊雪人女王和冰薊雪人王（56-58級）打得更痛。或者，組隊去打{area:1584}地城或{area:1583}地城（下層）。",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "烏米的第三個惡作劇目標是{area:976}和安戈洛的哥布林：保留到稍後。",
	-- ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "烏米：先留著，完美的雪人角會在{zone:1423}指南約57級時的{area:2255}停留點收集",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "在{zone:1452}的{area:2244}擊殺{npc:7440}練等",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}，冬泉熊怪的稀有掉落",
	-- ["{npc:10307}, beside him"] = "{npc:10307}，在他旁邊",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "矮人{npc:7775}在{area:1099}西北方的{area:1137}紮營。他只會用你帶來的{item:11242}釀製{item:11243}。",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "矮人{npc:7775}在{area:1099}西北方的{area:1137}紮營；他有這種藥劑。",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087}收購用你的{quest:3761}種出來的{item:11040}。",
	-- ["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909}來自{zone:1444}的{npc:7775}，在本指南稍後。",
	-- ["{zone:1456} flight master"] = "{zone:1456}飛行管理員",
}
