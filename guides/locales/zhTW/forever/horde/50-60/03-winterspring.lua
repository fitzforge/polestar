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
	["Into {zone:1452}"] = "",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "",
	["Linken's letter"] = "林克的信",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909}來自{zone:1444}的{npc:7775}，在本指南稍後。",

	-- Step 4: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "冬泉探路者、冬泉巢穴守衛和冬泉圖騰師共同佔據溫泉周圍的熊怪營地；蓬毛梟獸在營地之間的山坡上遊蕩。先殺圖騰師。把你拾取的每一份{item:14047}都留給梅羅什。",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}，冬泉熊怪的稀有掉落",

	-- Step 5: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084}要在之後前往{zone:1448}時，到{object:176091}繳交。",

	-- Step 6: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "狂怒的梟獸",
	-- {area:2251} Lake Kel'Theril · {area:2246} Frostfire Hot Springs · {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "",

	-- Step 8: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "格雷戈和哈魯的任務會通往其他地區：保留它們。",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "",

	-- Step 9: Ice Thistle yetis
	["Ice Thistle yetis"] = "冰薊雪人",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "雪人山丘從{area:2255}東南方不遠處開始。每隻雪人都會掉落毛皮；只有冰薊雪人女王和冰薊雪人王會掉落角，所以把角留到繳交之後再收集。",

	-- Step 11: Level 55.04
	["Level 55.04"] = "",
	-- {area:2255} Everlook · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "",
	-- {npc:7460} Ice Thistle Patriarch
	["grind on {npc:7460}"] = "",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "完美的雪人角",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "雪人女王和雪人王打得很痛：一次拉一隻。",
	["Below ground"] = "",

	-- Step 13: Chillwind chimaeras
	["Chillwind chimaeras"] = "冰風奇美拉",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "奇美拉在{area:2255}南邊和西邊的雪原上遊蕩。避開{area:2245}的洞穴：裡面的藍龍是精英。",

	-- Step 14: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "烏米的第三個惡作劇目標是{area:976}和安戈洛的哥布林：保留到稍後。",

	-- Step 15: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "熊怪村莊佔據{area:2255}東北方的山谷。先殺冬泉薩滿；他們會治療。後方洞穴裡的{npc:10738}是精英：不要進去。",

	-- Step 16: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飛往{area:1099}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 18: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "矮人{npc:7775}在{area:1099}西北方的{area:1137}紮營；他有這種藥劑。",

	-- Step 20: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飛行管理員",

	-- Step 21: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 22: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}的{npc:3033}；{npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123}在{zone:1450}等著：保留到稍後。",

	-- Step 23: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "",

	-- Step 24: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 25: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 26: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "在{object:172958}。",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "任何冬泉熊怪都可能帶著珠串；{npc:11556}南邊的營地最近。",
	-- ["Back at {area:1099}."] = "回到{area:1099}。",
	-- ["Back to {area:2255}"] = "返回{area:2255}",
	-- ["Chillwind chimaeras"] = "冰風奇美拉",
	-- ["From Krakle in Un'Goro"] = "來自安戈洛的克拉蘭克",
	-- ["Frostfire Winterfall camp"] = "冰火溫泉的冬泉營地",
	-- ["Frostfire Winterfall camps"] = "冰火溫泉的冬泉營地",
	-- ["Grind to 55"] = "練到55級",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "他站在{area:1641}。每次捐獻都需要你背包裡的布料；有布料時再繳交，在路線稍後。",
	-- ["In the {object:172961}."] = "在{object:172961}。",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "冬泉探路者、冬泉巢穴守衛和冬泉圖騰師共同佔據溫泉周圍的熊怪營地；蓬毛梟獸在營地之間的山坡上遊蕩。先殺圖騰師。把你拾取的每一份{item:14047}都留給梅羅什。",
	-- ["Ride back west to {area:2246}."] = "向西騎回{area:2246}。",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向東騎，然後沿著{area:2249}向南走。那裡的霜槌巨人是59級精英：走在中間並持續移動。奇怪的來源在南端的{area:2256}入口。",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "沿著道路向西騎過{area:2251}；狂怒的梟獸在湖北邊的山丘上遊蕩。",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "在{zone:1452}的{area:2244}擊殺{npc:7440}練等",
	-- ["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255}是山谷東側的哥布林城鎮。",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}，冬泉熊怪的稀有掉落",
	-- ["{npc:10307}, beside him"] = "{npc:10307}，在他旁邊",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556}站在{area:1769}隧道的{zone:1452}出口旁，在溫泉北邊。",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087}收購用你的{quest:3761}種出來的{item:11040}。",
	-- ["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298}在山谷西部{area:2246}冒著蒸氣的池塘之間紮營。",
}
