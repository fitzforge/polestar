-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 56."] = "适合49到50级的角色，但这里的大多数任务是51-53级：这是有意安排的，为了它们的经验值。第一次来只在环形山东半部活动，那里的野兽为48-52级，所以一次拉一只；水晶塔、骨头和虫巢留到约56级再来安戈洛时完成。",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飞行管理员",

	-- Step 3: Theramore
	["Theramore"] = "塞拉摩",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616}站在船停靠的码头上。",

	-- Step 4: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飞往{area:976}",
	["Theramore flight master"] = "塞拉摩飞行管理员",

	-- Step 5: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight from Theramore lands in {area:976}."] = "从塞拉摩起飞的航班降落在{area:976}。",

	-- Step 7: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "向西骑行前往沙丘中的森提帕尔虫巢。任何森提帕尔都可能掉落昆虫部件。\n注意：森提帕尔群居蝎在战斗中和战斗外都会施放{npc:4196}，召出的小怪会打断你。",

	-- Step 8: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "向南骑行前往食人魔营地。里面满是46-48级的蛮兵和执行者；49级的{npc:12046}站在中间，周围有守卫：先清掉守卫。",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}：在地下",

	-- Step 9: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}：沿途击杀以下目标",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride west into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley.\nCareful: the thistleshrubs wander a lot, so you can easily pull extra mobs."] = "向西骑行进入{quest:3362}。露水收集者掉落腺体；只有部分是满的，保留装满的那个。山谷里还有长瘤的灌木兽和塑根者。\n注意：灌木兽经常四处游走，很容易多拉怪。",

	-- Step 10: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back north-east to {area:976}: {npc:11758} stands on the east side of town."] = "向东北骑回{area:976}：{npc:11758}站在镇子东侧。",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}：在屋内",

	-- Step 11: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "骑行向南经过{area:1938}，前往{area:981}的哈扎里隧道，谢申克的设备在深处。\n注意：设备旁有一只虫子守卫，隧道里还有许多巡逻虫，其中一些达到 50 级，战斗经常引来额外敌人。",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593}：在地下",

	-- Step 12: Gadgetzan
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus · {zone:1428} Burning Steppes
	["For {npc:7740} in {zone:1457}, at the end of the {zone:1428} guide: keep it"] = "留给{zone:1457}的{npc:7740}，在{zone:1428}指南结尾用到：保留它",

	-- Step 14: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "向西骑出{area:976}，到达通往{zone:1449}的长坡道。{npc:9619}在坡道脚下扎营，位于环形山的东南角。",

	-- Step 15: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder · {item:280459} Crystal Infused Scale
	-- plural, as words: Venomhide Ravasaurs = {npc:6508} Venomhide Ravasaur
	["The dead Threshadon lies by the water north of {npc:9619}.\nCareful: Venomhide Ravasaurs (50-51) hunt along the water there: pull them one at a time before you loot the carcass.\nAny ravasaur may drop a {item:280459}: right-click it, {npc:9619} takes it."] = "死去的鞭尾龙躺在{npc:9619}北边的水边。\n注意：50-51级的毒皮暴掠龙在那片水边捕猎：拾取尸体前一次引一只清掉。\n任何暴掠龙都可能掉落{item:280459}：右键点击它，交给{npc:9619}。",

	-- Step 16: Torwa Pathfinder
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale"] = "{quest:87494}，如果暴掠龙掉落了鳞片",
	-- {area:1943} Ironstone Plateau
	["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "{area:1943}的猩猩身上有毛皮：留到第二次来安戈洛时再做，大约56级",

	-- Step 17: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "{npc:9683}和木筏",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "拉克维的配偶在{npc:9619}西边的丛林中徘徊。失事的木筏在那里的湖岸上；小背包在它旁边的水里。指南针、地图和钥匙留给{npc:8737}。环形山中任何野兽都可能掉落{item:11116}：右键点击它。",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "{object:161504}：在水下",

	-- Step 18: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Back east to {npc:9619} with the glands."] = "带着腺体向东回到{npc:9619}处。",

	-- Step 19: Marshal's Refuge
	-- {npc:271301} Power Crystal · {object:157936} Un'Goro Dirt Pile
	["Ride north-west to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "向西北骑行前往营地。\n远离精英魔暴龙和剑龙，从这里开始，沿途遇到的{npc:271301}和{object:157936}都要拾取。",
	-- {npc:9998} Shizzle
	["{npc:9998}: his scales come from the young beasts of the eastern jungle"] = "{npc:9998}：他要的鳞片来自东部丛林的幼兽",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}，在避难所深处",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "在{zone:1452}的{npc:9298}处结束：留着",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}，位于洞穴深处的地下",
	-- {npc:9272} Spark Nilminer · {npc:9271} Hol'anyee Marshal · {npc:9270} Williden Marshal · {npc:9618} Karna Remtravel
	["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "{npc:9272}、{npc:9271}、{npc:9270}和{npc:9618}的任务目标是51-55级的怪物：留到之后约56级再来安戈洛时做。",

	-- Step 20: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537}和东部丛林",
	-- {quest:3764} Un'Goro Soil · {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:9165} Fledgling Pterrordax
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher · Living Blazes = {npc:6521} Living Blaze · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride east into the eastern jungle: Bloodpetal Lashers and Threshers (48-50) drop the petals and {quest:3764}. Crystal clusters stand all over the crater, many around the foot of {area:537}: take a few extra of each colour.\nCareful: the Living Blazes (54-55) walk the top of {area:537}, and the Bloodpetal Flayers and Trappers (51-53) hold the jungle's south: take your crystals from the ridge's foot and your petals in the north.\n{npc:9998}'s scales: the {npc:9165} (48-50) glide over the north-east of the jungle and the Young Diemetradons (49-50) graze beside them. There are only ten of those: the Diemetradons (51) on the jungle's western edge, a short way west of the Threshers, drop the scales too. They are a level over you: take them one at a time."] = "向东骑入东部丛林：血瓣花鞭笞者和血瓣花鞭打者（48-50级）掉落花瓣和{quest:3764}。水晶簇遍布整个环形山，{area:537}山脚附近尤其多：每种颜色多采几个。\n注意：有生烈焰（54-55级）在{area:537}顶上游荡，血瓣花掠夺者和血瓣花捕猎者（51-53级）占据丛林南部：水晶在山脚采，花瓣在北边收集。\n{npc:9998}的鳞片：{npc:9165}（48-50级）在丛林东北部上空滑翔，幼双帆龙（49-50级）在旁边觅食。后者只有十只：丛林西缘、鞭打者西边不远处的双帆龙（51级）也掉落鳞片。它们比你高一级：一次只打一只。",
	-- {item:11316} Bloodpetal
	["{item:11316}, from the Lashers and Threshers"] = "{item:11316}，来自鞭笞者和鞭打者",
	-- {quest:3764} Un'Goro Soil
	["{quest:3764}, from the Threshers and the dirt piles"] = "{quest:3764}，来自鞭打者和土堆",

	-- Step 21: Lakkari Tar Pits
	-- plural, as words: Tar Lords = {npc:6519} Tar Lord
	["Crystal clusters stand all over the crater. The pits' Tar Lords (53-54) and the oozes around them (50-54) are over you: take the clusters on the jungle's north-eastern edge, among the Lashers and young beasts (48-50)."] = "水晶簇遍布整个环形山。焦油坑里的焦油兽王（53-54级）和周围的软泥怪（50-54级）等级比你高：去丛林东北边缘采集，那里是鞭笞者和幼兽（48-50级）的地盘。",

	-- Step 22: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}：在地下",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "交给{zone:1444}的{npc:7775}：留着",

	-- Step 23: Level 49.79
	["Level 49.79"] = "等级 49.79",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Still short of level 49.79 after the refuge's hand-ins? Top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "在避难所交完任务后仍不到49.79级？离开环形山前，在东部丛林采花瓣的地方击杀血瓣花鞭笞者和鞭打者（48-50级）补足经验。",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "击杀{npc:6511}刷经验",

	-- Step 24: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "飞往{area:415}",
	-- {zone:1455} Ironforge · {zone:1427} Searing Gorge · {zone:1440} Ashenvale · {zone:1447} Azshara
	["The {zone:1455} quests were taken at the end of the {zone:1427} guide: fly straight on to {zone:1440} for {zone:1447}."] = "{zone:1455}的任务已在{zone:1427}指南末尾接取：直接飞往{zone:1440}，前往{zone:1447}。",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "{area:541}飞行管理员",

	-- Step 25: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "前往{zone:1455}",

	-- Step 26: Mystic Ward
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}：交给{zone:1447}的奥汀克，留着",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "法师训练师{npc:7312}：带给{zone:1447}的{npc:8395}，先留着",

	-- Step 29: Fly to Astranaar
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}的飞行管理员",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "阿克瑟努斯站在{object:171709}中麦格尼国王旁边。",
	-- ["Below ground"] = "在地下",
	-- ["Bind and train"] = "设置炉石并训练",
	-- ["Bones and equipment"] = "骨头和设备",
	-- ["Class trainer"] = "职业训练师",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "穿过环形山南部，到坡道旁找{npc:9619}。",
	-- ["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "恐龙骨头散落在西南部的地面上，在剑龙之间：剑龙是精英，在它们周围捡骨头，其余的从双帆龙身上获取。探险队的{item:11112}在西南部丛林中。",
	-- ["Eastern Pylon"] = "东部水晶塔",
	-- ["Escort {npc:9999}"] = "护送{npc:9999}",
	-- ["Fly from {area:144} to {area:1537}."] = "从{area:144}飞往{area:1537}。",
	-- ["Fly to {area:1537}"] = "飞往{area:1537}",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. The crater's beasts are 48-55 and the Gorishi silithids 51-54, so pull them one at a time."] = "适合49到50级的角色，但这里的大多数任务是51-53级：这是有意安排的，为了它们的经验值。环形山的野兽为48-55级，格里什异种虫为51-54级，所以一次拉一只。",
	-- ["Four rune rubbings in {zone:1447}: keep it"] = "{zone:1447}的四个符文拓片：留着",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "从{area:144}飞往{area:150}，乘船前往塞拉摩，再飞往{area:976}。{npc:9619}在环形山的第一个任务需要48级：等级不够就在这里练满。",
	-- ["Grind to 50"] = "刷到50级",
	-- ["Grind to 51"] = "刷到51级",
	-- ["Gryfe"] = "格莱菲",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "带{npc:9999}向北前往{area:541}。他昏倒时，对他使用{item:11804}唤醒他。",
	-- ["Level 50.4"] = "等级 50.4",
	-- ["Northern Pylon"] = "北部水晶塔",
	-- ["Pterrordax"] = "翼手龙",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "沿坡道下到环形山：{npc:9619}在坡道脚下扎营。",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向东骑行到{area:1943}，机器人站在猩猩中间。别进那里的深洞。",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "向东骑行到{area:537}，爬上去，在山顶附近的熔岩喷口使用{npc:10541}。",
	-- ["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "沿环形山东侧向北骑行到{area:541}，即北面悬崖洞穴中的营地。远离精英魔暴龙和剑龙。从这里开始，沿途遇到的每个能量水晶和{object:157936}都拾取。",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿东侧向北骑行到猩猩高地。55级的猩猩{npc:9622}坐在最深的洞里：先清理洞口的猩猩。",
	-- ["Ride north along the western jungle back to the refuge."] = "沿西部丛林向北骑回避难所。",
	-- ["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "向北骑行到{area:1943}，机器人站在猩猩中间。别进那里的深洞。",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "沿东部悬崖向南骑行，到坡道脚下找{npc:9619}。",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "沿东侧向南骑行。幼双帆龙在东部丛林吃草，{npc:9165}在东部悬崖附近飞行；两者都掉落{npc:9998}要的鳞片。",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "沿东侧向南骑行，幼双帆龙在东侧丛林活动，{npc:9165}在东侧峭壁附近飞行，两者都会掉落{npc:9998}所需的鳞片。箱子位于东侧丛林的废弃营地内。",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "向南骑到陨石坑中央的{area:537}，然后向东进入东部丛林。水晶簇遍布陨石坑，许多在{area:537}周围：每种颜色多拿几个。{npc:6509}和血瓣花猛击者掉落花瓣；远征队的{item:11113}在东部丛林的一处废弃营地里。",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. {item:11316} Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "向南骑行到环形山中央的{area:537}，然后向东进入东部丛林。水晶簇遍布环形山，很多在{area:537}周围：每种颜色多拿几个。{item:11316}鞭笞者和猛击者掉落花瓣；探险队的{item:11113}在东部丛林的一处废弃营地里。",
	-- ["Ride south-west past {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; Pterrordax nest on the southern cliffs if you still need kills.\nCareful: Gorishi silithids are level 51-54 and cast {spell:8137} or {spell:14120} in melee; Gorishi Workers have a 50% chance to call for help within 25 yd once they fall below 45% health."] = "骑行向西南，经过 {npc:9619}：异种虫巢遍布环形山南部。对孵化室使用未使用的采集瓶，孵化室就是悬挂着幼虫的洞室。格里什黄蜂和格里什工蝎会掉落 {quest:3764}；若击杀数量还不够，南侧悬崖上也有翼手龙栖息。\n小心：格里什异种虫为 51-54 级，近战时会施放 {spell:8137} 或 {spell:14120}；格里什工蝎的生命值降至 45% 以下时，有 50% 的概率呼叫 25 码内的同伴前来援助。",
	-- ["Ride west back to the refuge."] = "向西骑回避难所。",
	-- ["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "向西骑行返回营地。\n远离精英魔暴龙和剑龙，从这里开始，沿途遇到的{npc:271301}和{object:157936}都要拾取。",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "从{npc:9619}向西骑行：异种虫巢穴占据环形山南部。对孵化室（挂着幼虫的房间）使用采集瓶。格里什异种蝎和格里什工蝎掉落{quest:3764}；如果还需要击杀，{npc:9166}在南部悬崖筑巢。",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "向西骑出{area:976}，到达通往{area:490}的长坡道。{npc:9619}在坡道脚下扎营，位于环形山的东南角。",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "向西经过{area:541}，再沿西侧向南到{area:543}：地精{npc:10302}坐在水边。",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "组队打{area:1417}代替刷怪会更快。单人刷怪就跳过此步骤。",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "组队打{area:978}代替刷怪会更快。巨魔城市位于{zone:1446}西北部，就在{area:976}北边。",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Pterrordax on the slopes east of {area:541} before you leave the crater."] = "在避难所交完任务后仍不到49.79级？离开环形山前，在{area:541}东边的山坡上击杀翼手龙补足经验。",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "森提帕尔异种虫在{zone:1446}西部的{area:982}周围爬行，就在环形山坡道东边。森提帕尔工蝎最容易拉。",
	-- ["The Gorishi hive"] = "格里什虫巢",
	-- ["The dead Threshadon lies by the water north of {npc:9619}."] = "死去的蛇颈龙躺在{npc:9619}北边的水边。",
	-- ["The east side"] = "东侧",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "猩猩生活在{area:541}东边的{area:1943}。毛皮留给{npc:9619}。别进最深的洞：{npc:9622}是55级。",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "{area:1943}的猩猩成小群出现，目前不会给你掉落任何东西；{npc:9619}的毛皮任务稍后才有。别进最深的洞：{npc:9622}是55级。",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "毛皮在第二圈之后，在猩猩高地上",
	-- ["The pylon stands on the eastern cliffs."] = "水晶塔立在东部悬崖上。",
	-- ["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "水晶塔位于营地东侧山坡，翼手龙在周围山坡盘旋，既计入斯普拉格·弗劳克的任务，也会掉落{npc:9998}所需的鳞片。",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "水晶塔立在避难所东边的山坡上。{npc:9166}在周围山坡上盘旋：它们计入{npc:9997}的任务，并掉落{npc:9998}要的鳞片。",
	-- ["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "水晶塔立在西部悬崖上。{npc:9167}在整个西侧上空飞行。",
	-- ["The relics are in the {zone:1428}: keep it"] = "圣物在{zone:1428}：留着",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997}旁边的木牌",
	-- ["Top up here to level 49.51 before the hand-ins at {area:541}: they take you to level 50. Or, with a group, run the {area:2100} dungeon instead."] = "在这里补到49.51级，再去{area:541}交任务，交完会升到50级。也可以组队去{area:2100}副本。",
	-- ["Top up here to level 50.4 before the hand-ins at {area:3137}: they take you to level 51."] = "在这里补到50.4级，再去{area:3137}交任务，交完会升到51级。",
	-- ["Western Pylon"] = "西部水晶塔",
	-- ["Xiggs waits in the {object:32359}."] = "西格斯在{object:32359}等候。",
	-- ["grind on Pterrordax"] = "反复击杀翼手龙补足经验",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "在{area:976}周围刷废土强盗或砂槌食人魔",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "在{zone:1446}的{area:982}刷{npc:5458}",
	-- ["grind on {npc:6116}"] = "反复击杀{npc:6116}补足经验",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "在{zone:1449}的{area:1943}刷{npc:6514}",
	-- ["grind on {npc:9164}"] = "反复击杀{npc:9164}补足经验",
	-- ["grind on {npc:9167}"] = "反复击杀{npc:9167}补足经验",
	-- ["{area:144} flight master"] = "{area:144}的飞行管理员",
	-- ["{area:978} (optional)"] = "{area:978}（可选）",
	-- ["{item:11834} from {npc:6518} and {npc:6519}, 60 yd south"] = "{item:11834}从{npc:6518}和{npc:6519}身上获取，在南边60码处",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}：上一份指南用炉石把你送到这里，所以这一步通常会立即完成",
	-- ["{npc:7564}, once he has brewed the elixir: a few seconds"] = "{npc:7564}，等他调好药剂：几秒钟",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}，在洞穴深处",
	-- ["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}：软泥怪在{zone:1448}，留着",
	-- ["{npc:9618} stands just outside the refuge."] = "{npc:9618}站在避难所外面。",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}的巢穴在{npc:9619}北边的丛林中，东部悬崖下方：在那里使用{item:11568}。{npc:9684}是56级：满血开打。",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9997}的朋友{npc:9999}失踪了。",
	-- ["{npc:9998}, at the refuge entrance"] = "{npc:9998}，在避难所入口",
	-- ["{npc:9998}, at the refuge's entrance"] = "{npc:9998}，在避难所入口",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}坐在环形山中央{area:537}的东南坡上。",
}
