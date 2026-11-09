-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/07-felwood (forever/horde/50-60/07-felwood.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tirisfal Glades
	["The zeppelin towers"] = "",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 3: Orgrimmar
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 4: Zeppelin to Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "在{zone:1458}城外的塔上乘飞艇前往{zone:1454}。",
	-- {item:14047} Runecloth
	["sixty {item:14047}"] = "",

	-- Step 6: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飞往{area:431}",

	-- Step 7: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 8: The Emerald Sanctuary
	-- {area:431} Splintertree Post · {zone:1440} Ashenvale · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {zone:1448}. The {area:2479} is the druids' camp just past the border."] = "飞往{area:431}，沿道路向西北离开{zone:1440}进入{zone:1448}。{area:2479}是刚过边界的德鲁伊营地。",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}：在屋内",
	-- {npc:9116} Eridan Bluewind · {item:11173} Irontree Heart · {zone:1448} Felwood
	["{npc:9116}'s Silver Heart needs an {item:11173} from northern {zone:1448} and a ride back here. Skip it."] = "{npc:9116}的银色之心需要{zone:1448}北部的一个{item:11173}，还要再骑回这里。跳过它。",

	-- Step 9: Dousing the Flames of Protection
	-- {area:1763} Jaedenar
	["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "骑行向西北前往 {area:1763}。四座火盆位于暗影议会的建筑之间；对每一座使用净化过的水。\n小心：洞穴中遍布 53-55 级的暗影议会怪物，它们经常以多只联动的大群出现，其中许多会昏迷技能。建议 2-3 名玩家组队。",
	["Below ground"] = "在地下",

	-- Step 10: Greta Mosshoof
	["Back south to the Sanctuary, a short ride."] = "向南回到翡翠圣地，路程很短。",

	-- Step 11: Bloodvenom Post
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post
	["Ride north along the road, past {area:1763}, to {area:1997}."] = "沿道路向北骑行，经过{area:1763}，前往{area:1997}。",
	-- {npc:10306} Trull Failbane · {quest:4741} Wild Guardians · {zone:1452} Winterspring
	["{npc:10306}'s next {quest:4741} would bring you back here from {zone:1452}. Skip it."] = "{npc:10306}的下一个任务{quest:4741}会让你从{zone:1452}跑回这里。跳过它。",

	-- Step 12: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {area:1763} Jaedenar
	["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "{npc:9861}、{npc:9860} 和 {npc:9517} 在 {area:1770} 深处等着，那是 {area:1763} 北边的洞穴。边走边清理通道。\n小心：三名首领会一起战斗。先清掉周围的小怪，避免额外引怪。",

	-- Step 13: Greta Mosshoof
	["South to the Sanctuary once more."] = "再次向南前往翡翠圣地。",

	-- Step 14: Toxic Horrors
	-- {zone:1448} Felwood · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["Ride north up the {zone:1448} road to {area:1767}; the {quest:5086} ooze between the trees, and most of them drop a droplet."] = "",

	-- Step 16: Umber
	-- {zone:1450} Moonglade · {npc:11939} Umber · {area:2361} Nighthaven
	["Through the Timbermaw tunnel to {zone:1450}. {npc:11939} reads in a house in {area:2361}."] = "穿过木喉隧道前往{zone:1450}。{npc:11939}在{area:2361}的一座房子里读书。",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939}在{area:2361}巡逻，请在地图标示的圆圈内寻找",

	-- Step 18: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 19: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2577} Dire Maul
	["{npc:11801}'s Shards of the Felvine needs {area:2577}. Skip it."] = "{npc:11801}的魔藤碎片需要{area:2577}。跳过它。",

	-- Step 22: Donova Snowden
	-- {zone:1452} Winterspring · {npc:9298} Donova Snowden
	["Back into the Timbermaw tunnel and take the {zone:1452} exit; {npc:9298} camps by the hot springs just outside."] = "回到木喉隧道，走{zone:1452}出口；{npc:9298}就在出口外的温泉旁扎营。",
	["From Krakle in Un'Goro"] = "来自安戈洛的克拉兰克",

	-- Step 23: Winterfall Runners
	-- {area:1769} Timbermaw Hold · {area:2244} Winterfall Village · {npc:9298} Donova Snowden · {spell:5384} Feign Death
	["The runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 25: Beads for Salfa
	-- {npc:11556} Salfa
	["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "任何冬泉熊怪都可能携带冬泉灵魂珠串；{npc:11556}正南的营地最近。",
	["Frostfire Winterfall camp"] = "冰火温泉的冬泉熊怪营地",

	-- Step 27: Meilosh
	-- {quest:6031} Runecloth · {area:1769} Timbermaw Hold · {npc:11557} Meilosh
	["With 30 {quest:6031} in your bags: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "",

	-- Step 28: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["Only at Neutral with the Timbermaw: {npc:11558} waits at the tunnel mouth of {area:1769}."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 30: Darkwhisper Gorge
	-- {area:2249} Frostwhisper Gorge · {area:2256} Darkwhisper Gorge
	["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "向东骑行，然后向南下到{area:2249}。那里的霜槌巨人是59级精英：走在中间，保持移动。奇怪的源头在南端{area:2256}的入口处。",

	-- Step 31: Level 59.9
	["Level 59.9"] = "等级 59.9",
	-- {zone:1452} Winterspring · {area:2249} Frostwhisper Gorge · {area:1769} Timbermaw Hold · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Top up here to level 59.9 before the hand-ins at {zone:1452}: they take you to level 60. The Rabid Shardtooths (59) of {area:2249}, just north of the strange source, give far more experience than the furbolgs by {area:1769}. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:7446} Rabid Shardtooth
	["grind on {npc:7446}"] = "",

	-- Step 32: Donova Snowden
	-- {area:2246} Frostfire Hot Springs
	["Ride back west to {area:2246}."] = "向西骑回{area:2246}。",
	-- {npc:9298} Donova Snowden · {npc:10738} High Chief Winterfall
	["{npc:9298} next sends you after {npc:10738}, an elite in his cave. Skip it."] = "{npc:9298}接下来让你去对付{npc:10738}，他是洞穴里的精英。跳过它。",

	-- Step 33: Are We There, Yeti?
	-- {npc:10978} Legacki · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10978} with {npc:10980}"] = "",

	-- Step 34: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "沿道路向东骑往{area:2255}。",

	-- Step 35: Dungeon instead of grinding
	["Dungeon instead of grinding"] = "用地下城代替刷怪",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {area:1584} Blackrock Depths
	["Optional. Running {area:2279}, {area:2057}, Lower Blackrock Spire or {area:1584} with a group instead of grinding gets you there faster."] = "可选。和队伍一起刷{area:2279}、{area:2057}、黑石塔下层或{area:1584}，代替刷怪能更快到达。",
	["Optional: with a group, a 55-60 dungeon replaces the grind below."] = "可选：有队伍时，用一个55-60级的地下城代替下面的刷怪。",

	-- Step 36: Grind to 60
	["Grind to 60"] = "刷到60级",
	-- {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2255} Everlook
	-- plural, as words: Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {zone:1452}, south of the road from {area:2255}."] = "任务到这里就没了。疯狂的碎齿熊在{zone:1452}南部的{area:2249}潜行，位于从{area:2255}出发的道路南边。",
	-- {npc:7446} Rabid Shardtooth · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	["grind on {npc:7446} at {area:2249}, {zone:1452}"] = "在{zone:1452}的{area:2249}刷{npc:7446}",
	-- {zone:1454} Orgrimmar · {area:2255} Everlook
	["In {zone:1454}: fly from {area:2255}"] = "在{zone:1454}：从{area:2255}飞过去",
	-- {zone:1456} Thunder Bluff · {area:2255} Everlook
	["In {zone:1456}: fly from {area:2255}"] = "在{zone:1456}：从{area:2255}飞过去",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the Timbermaw tunnel and take the {area:618} exit; {npc:9298} camps by the hot springs just outside."] = "回到木喉隧道，走{area:618}出口；{npc:9298}就在出口外的温泉旁扎营。",
	-- ["Fly to {area:431} and ride north-west along the road out of {zone:1440} into {area:361}. The {area:2479} is the druids' camp just past the border."] = "飞往{area:431}，沿道路向西北离开{zone:1440}进入{area:361}。{area:2479}是刚过边界的德鲁伊营地。",
	-- ["From the {zone:1458}, take the zeppelin from the tower outside the city to {zone:1454}."] = "在{zone:1458}城外的塔上乘飞艇前往{zone:1454}。",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate."] = "仅当你有{quest:5087}时：信使们成小群地沿着从{area:1769}到{area:2244}的道路行走；在{npc:9298}附近的路边等候，在他们经过时杀死他们。每个都带着一个箱子。",
	-- ["Only if you carry {quest:5087}: the runners walk the road from {area:1769} toward {area:2244} in small groups; wait by the road near {npc:9298} and kill them as they pass. Each one carries a crate.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "仅在接有 {quest:5087} 时进行：信使以小队形式沿道路从 {area:1769} 前往 {area:2244}；在 {npc:9298} 附近路边等待，经过时击杀。每名都携带一个箱子。\n小心：交还任务后会出现三四名56—57级冬泉伏兵攻击你；可以骑乘、潜行或使用 {spell:5384} 逃脱。之后它们会聚集在湖边，你就能接下一个任务。",
	-- ["Only if {npc:9298} gave you {quest:5086}: ride north up the {area:361} road to {area:1767}; the {quest:5086} ooze between the trees."] = "仅当{npc:9298}给了你{quest:5086}时：沿{area:361}的道路向北骑往{area:1767}；{quest:5086}在树木之间蠕动。",
	-- ["Only with 30 {quest:6031}, and only at Neutral with the Timbermaw: follow the road north to {area:1769}; {npc:11557} trades just inside the entrance."] = "仅当你有30块{quest:6031}，且木喉要塞声望达到中立时：沿道路向北前往{area:1769}；{npc:11557}就在入口里面交易。",
	-- ["Ride north-west to {area:1763}. The four braziers stand among the Shadow Council's buildings; use the Cleansed Water on each one."] = "向西北骑往{area:1763}。四个火盆立在暗影议会的建筑之间；对每一个使用净化后的水。",
	-- ["The quests run out here. Rabid Shardtooths prowl {area:2249} in southern {area:618}, south of the road from {area:2255}."] = "任务到这里就没了。疯狂的碎齿熊在{area:618}南部的{area:2249}潜行，位于从{area:2255}出发的道路南边。",
	-- ["Through the Timbermaw tunnel to {area:493}. {npc:11939} reads in a house in {area:2361}."] = "穿过木喉隧道前往{area:493}。{npc:11939}在{area:2361}的一座房子里读书。",
	-- ["Top up here to level 59.9 before the hand-ins at {area:618}: they take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "先在这里补到59.9级，再去{area:618}交任务，这些任务会让你升到60级。也可组队挑战{area:2057}或{area:2279}副本。",
	-- ["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",
	-- ["grind on {npc:7441}"] = "击杀{npc:7441}刷经验",
	-- ["grind on {npc:7446} at {area:2249}, {area:618}"] = "在{area:618}的{area:2249}刷{npc:7446}",
	-- ["sixty {item:14047}, if you carry them"] = "六十块 {item:14047}，如果你带着的话。",
	-- ["{npc:10306}'s next {quest:4741} would bring you back here from {area:618}. Skip it."] = "{npc:10306}的下一个任务{quest:4741}会让你从{area:618}跑回这里。跳过它。",
	-- ["{npc:11558}, at the tunnel mouth; walks around here: look inside the circle on the map"] = "{npc:11558} 在隧道口附近走动：在地图上圆圈标出的范围内寻找",
	-- ["{npc:9116}'s Silver Heart needs an {item:11173} from northern {area:361} and a ride back here. Skip it."] = "{npc:9116}的银色之心需要{area:361}北部的一个{item:11173}，还要再骑回这里。跳过它。",
	-- ["{npc:9861}, {npc:9860} and {npc:9517} wait at the back of {area:1770}, the cave in {area:1763}'s north. Clear the tunnel as you go."] = "{npc:9861}、{npc:9860}和{npc:9517}在{area:1763}北部的洞穴{area:1770}深处等候。一路清理隧道。",
}
