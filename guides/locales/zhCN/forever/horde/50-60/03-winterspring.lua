-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "进入{zone:1452}",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}就站在{area:1769}隧道的{zone:1452}出口处，也就是你出来的地方。",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "",
	["Linken's letter"] = "林克的信",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909}来自{zone:1444}的{npc:7775}，在本指南稍后。",

	-- Step 4: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}：沿途击杀以下目标",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "冬泉探路者、冬泉巢穴守卫和冬泉图腾师共处于温泉周围的熊怪营地；蓬毛枭兽在营地之间的山坡上游荡。先杀冬泉图腾师。把拾取到的每一块{item:14047}都留给梅罗什。",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "{quest:8471}，冬泉熊怪的稀有掉落",

	-- Step 5: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084}要在{zone:1448}的{object:176091}交还，留到之后那一趟。",

	-- Step 6: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "狂暴的枭兽",
	-- {area:2251} Lake Kel'Theril · {area:2246} Frostfire Hot Springs · {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}."] = "狂怒的枭兽出没于{area:2251}北面的山丘，就在{area:2246}与{area:2255}之间的路旁。",

	-- Step 8: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "",
	["Gregor's and Harlo's quests lead to other zones: keep them."] = "格雷戈和哈鲁的任务会把你带到其他地区：留着它们。",
	-- {npc:11118} Innkeeper Vizzie
	["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}：在屋内",

	-- Step 9: Ice Thistle yetis
	["Ice Thistle yetis"] = "冰蓟雪人",
	-- {area:2255} Everlook
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "雪人的山丘就在{area:2255}东南不远处开始。每个雪人都会掉落毛皮；只有冰蓟雪人女王和冰蓟雪人王掉落角，所以交还后再去打它们。",

	-- Step 11: Level 55.04
	["Level 55.04"] = "等级 55.04",
	-- {area:2255} Everlook · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "在这里补到55.04级，再去{area:2255}交任务，交完会升到56级。也可以组队去{area:1584}副本或{area:1583}副本（下层）。",
	-- {npc:7460} Ice Thistle Patriarch
	["grind on {npc:7460}"] = "击杀{npc:7460}刷经验",

	-- Step 12: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "完美的雪人角",
	["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "冰蓟雪人女王和冰蓟雪人王攻击很重：一次引一只。",
	["Below ground"] = "在地下",

	-- Step 13: Chillwind chimaeras
	["Chillwind chimaeras"] = "冰风奇美拉",
	-- {area:2255} Everlook · {area:2245} Mazthoril
	["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "奇美拉在{area:2255}南边和西边的雪原上游荡。远离{area:2245}的洞穴：里面的蓝龙龙人都是精英。",

	-- Step 14: Umi Rumplesnicker
	-- {area:976} Gadgetzan
	["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "乌米的第三个恶作剧针对的是{area:976}和安戈洛环形山的地精：留到之后。",

	-- Step 15: Winterfall Village
	-- {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "熊怪村庄占满了{area:2255}东北的山谷。先杀冬泉萨满祭司；他们会治疗。后面洞穴里的{npc:10738}是精英：别进去。",

	-- Step 16: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飞往{area:1099}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "{area:2255}的飞行管理员",

	-- Step 18: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:1137} Lower Wilds · {area:1099} Camp Mojache
	["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "矮人{npc:7775}在{area:1099}西北的{area:1137}扎营；他有药剂。",

	-- Step 20: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飞往{area:1638}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飞行管理员",

	-- Step 21: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881}和{npc:14728}站在{area:1641}。拉姆斯塔格的每项捐献都需要背包中六十份毛料、丝绸或魔纹布：带了什么就交什么，其余跳过。",

	-- Step 22: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}的{npc:3033}；{npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123}在{zone:1450}等候：留到之后。",

	-- Step 23: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11040} Morrowgrain · {quest:3761} Un'Goro Soil · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch
	["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087}收购用{quest:3761}种出的{item:11040}。{quest:3782}需要十份，而{item:11020}每十分钟只能尝试一次：已有足够晨光麦再接。",

	-- Step 24: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 25: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "在 {object:172961} 内。每次捐赠会收取背包中的六十块毛料、丝绸或魔纹布：交还随身带的，其余跳过。",

	-- Step 26: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "在{object:172958}。",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "两项 {item:14047} 捐献都安排在路线后面交还：如果打算完成，每项各留六十块 {item:14047}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "任何冬泉熊怪都可能携带冬泉灵魂珠串；{npc:11556}正南的营地最近。",
	-- ["Back at {area:1099}."] = "回到{area:1099}。",
	-- ["Back to {area:2255}"] = "返回{area:2255}",
	-- ["Chillwind chimaeras"] = "冰风奇美拉",
	-- ["From Krakle in Un'Goro"] = "来自安戈洛的克拉兰克",
	-- ["Frostfire Winterfall camp"] = "冰火温泉的冬泉熊怪营地",
	-- ["Frostfire Winterfall camps"] = "冰火温泉的冬泉熊怪营地",
	-- ["Grind to 55"] = "刷到55级",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "他站在{area:1641}。每次捐献都需要你背包里的布料；有了布料再交，在路线后面。",
	-- ["In the {object:172961}."] = "在{object:172961}。",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "冬泉探路者、冬泉巢穴守卫和冬泉图腾师共处于温泉周围的熊怪营地；蓬毛枭兽在营地之间的山坡上游荡。先杀冬泉图腾师。把拾取到的每一块{item:14047}都留给梅罗什。",
	-- ["Ride back west to {area:2246}."] = "向西骑回{area:2246}。",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向东骑行，然后向南下到{area:2249}。那里的霜槌巨人是59级精英：走在中间，保持移动。奇怪的源头在南端{area:2256}的入口处。",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "沿道路向西经过{area:2251}；狂暴的枭兽在它北边的山丘上游荡。",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "在{zone:1452}的{area:2244}刷{npc:7440}",
	-- ["{area:2255} is the goblin town on the east side of the valley."] = "{area:2255}是山谷东侧的地精城镇。",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "{item:12771}，冬泉熊怪的稀有掉落",
	-- ["{npc:10307}, beside him"] = "{npc:10307}，在他旁边",
	-- ["{npc:11556} stands by the {zone:1452} exit of {area:1769}'s tunnel, north of the hot springs."] = "{npc:11556}站在{area:1769}隧道的{zone:1452}出口旁，在温泉北边。",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754}在{area:2255}巡逻，请在地图标示的圆圈内寻找",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087}收购用你的{quest:3761}种出来的{item:11040}。",
	-- ["{npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "{npc:9298}在山谷西部{area:2246}的热气腾腾的水池间扎营。",
}
