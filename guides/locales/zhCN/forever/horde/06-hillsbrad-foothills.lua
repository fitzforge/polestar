-- Chinese (simplified) (zhCN): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272}是本指南的据点：炉石会两次把你带回这里。所有人都站在镇广场周围。",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "在旅店旁的{object:107045}装满{item:7768}",
	-- {object:556670} WANTED
	["The {object:556670} poster by the inn"] = "旅店旁的{object:556670}告示",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}：在屋内",

	-- Step 2: Serge Hinott
	-- {quest:2479} Hinott's Assistance · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["After returning Mission: Possible But Not Probable to Shenthul, bring {quest:2479} to {npc:2391} in {area:272}. Stay beside him until the brewing objective completes, then hand in the follow-up to learn Poisons. Finish it even if the Zanzil poison has already been removed; removing the debuff alone does not teach the skill."] = "向申苏尔交付“不可能完成的任务”后，带着“{quest:2479}”来{area:272}找{npc:2391}。留在他身边，等制药目标完成后再交后续任务，学会毒药。即使赞吉尔之触已经被解除，也要完成这一步；单纯解掉负面效果不会学会毒药。",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}：毒药",
	["Poison chain unfinished? Resume your current stage in the Class guide Poisons (Horde); completed quests do not need restarting. Arrange a group for Gallywix, finish the Hinott follow-up, then return to this leveling guide."] = "毒药任务线尚未完成的话，可从职业指南“毒药（部落）”中的当前阶段继续，无需重做已交的任务。找队伍处理加里维克斯并完成希诺特的后续，再回当前练级指南。",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "熊、食苔蛛和山地狮",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "在塔伦米尔西边，{npc:2351}、{npc:2350}和{npc:2384}在通往农场的山丘上游荡。食苔蛛很少掉落{item:3477}；你只需要一个。",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "{area:287}镇东边的农场。{npc:232}在北边农舍旁的田里干活，{npc:2403}在更东南的那片田；到处都是希尔斯布莱德雇农和希尔斯布莱德农夫。{npc:2451}照料农场南边的田地。",

	-- Step 5: Mountain Lion Blood
	["Careful: When one lion is attacked, nearby lions come to its aid, and the Vicious Black Bears sharing those fields can also join the fight."] = "小心：攻击一只狮子时，附近的狮子会前来支援，同一片田野上的凶猛黑熊也可能加入战斗。",

	-- Step 6: Tarren Mill
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}：在屋内",
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon; inside"] = "{npc:2230}，在药剂师林度恩旁边；位于室内",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: Kalaba with the peasants, Wilkes at the smithy; the clerk and the miner on the visit at about 30; inside"] = "{quest:567}告示：卡拉巴在农民中间，维尔克斯在铁匠铺；书记员和矿工留到约30级再来时处理；告示在室内",

	-- Step 7: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274}是{npc:232}的狗，在{area:286}北边的农舍旁。",

	-- Step 8: Hillsbrad Fields: kill these as you meet them
	-- {area:286} Hillsbrad Fields
	["{area:286}: kill these as you meet them"] = "{area:286}：沿途遇到就击杀",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often.\nCareful: A fleeing peasant that reaches the town hall can bring back many adds, including {area:287} footmen; snares, roots or similar effects keep them from escaping."] = "农夫在农舍南边的田地里干活。{area:287} 的所有人类都会掉落头骨，其中农夫掉落最频繁。\n注意：逃跑的农夫如果跑到市政厅，可能会带回许多敌人，包括 {area:287} 的步兵；减速、定身等效果能阻止他们逃跑。",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}：田里的希尔斯布莱德农民",
	-- {npc:2451} Farmer Kalaba · {area:286} Hillsbrad Fields
	["{npc:2451} walks around {area:286}: look inside the circle on the map"] = "{npc:2451}在{area:286}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 9: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}：给{npc:270438}的命令，在前往敦霍尔德城堡的路上",
	-- {npc:2216} Apothecary Lydon · {item:3502} Mudsnout Blossoms
	["{npc:2216}, inside: the {item:3502} grow south-west of Durnholde, on the walk there"] = "室内的{npc:2216}：{item:3502}长在敦霍尔德西南方，前往那里时顺路采集",

	-- Step 10: Durnholde Keep: kill these as you meet them
	-- {area:275} Durnholde Keep
	["{area:275}: kill these as you meet them"] = "{area:275}：沿途遇到就击杀",
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep · {area:272} Tarren Mill
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks.\nFrom {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "德鲁尔和{npc:2238}被锁在{area:275}庭院的建筑内；打开两处锁。\n从{area:272}向东南进入山丘，朝{area:275}走。沿途营地由潜行者和卫兵占据。",
	-- {npc:2261} Syndicate Watchman
	["{npc:2261} walks around here: look inside the circle on the map"] = "{npc:2261}在附近巡逻，请在地图标示的圆圈内寻找",
	["Drull's ball and chain"] = "德鲁尔的镣铐",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "{npc:2238}的镣铐",

	-- Step 11: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "在敦霍尔德城堡西南，{item:3502}长在河上方的山坡上。",

	-- Step 12: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "亡灵哨兵玛索吉躲在{area:290}上方的山坡上，位于敦霍尔德城堡南边，就在下去采花的路上。",
	-- {npc:270438} Deathstalker Masoj · {quest:98094} Scout Support
	["{npc:270438}, once {quest:98094} is in"] = "{npc:270438}，接到{quest:98094}后",

	-- Step 13: The southern peak
	["The southern peak"] = "南边的山峰",
	-- {area:290} Dun Garok
	["Masoj wants an Apothecary Vial placed on three peaks. The southern one is the hilltop above {area:290}, just south of him: use a vial at the top."] = "马索吉要你在三座山峰上各放一个药剂师之瓶。南边那座是{area:290}上方的山顶，就在他南边：在山顶使用药瓶。",

	-- Step 14: The smithy
	["The smithy"] = "铁匠铺",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "铁匠铺在{area:287}镇中央。{npc:2404}和他的希尔斯布莱德见习铁匠在熔炉旁干活；{object:1736}堆在旁边。{npc:2449}在它北边的街上走动。",
	["Inside"] = "在里面",

	-- Step 15: The western peak
	["The western peak"] = "西边的山峰",
	-- {area:287} Hillsbrad
	["From {area:287} town climb the mountain to the north, right up to its top on the Alterac border: the western vial goes there, not on the lower slope."] = "",

	-- Step 16: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "返回{area:272}",
	-- {area:272} Tarren Mill
	["East along the foothills, then down into {area:272}."] = "沿山脚向东，再下到 {area:272}。",

	-- Step 17: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}，在{zone:1458}",

	-- Step 18: The northern peak
	["The northern peak"] = "北边的山峰",
	-- {area:272} Tarren Mill
	["The northern peak rises south-east of {area:272}, on the way down towards Durnholde."] = "北边的山峰位于{area:272}东南，在下山前往敦霍尔德城堡的路上。",

	-- Step 19: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Back down to Masoj on the hillside above {area:290}."] = "下山回到{area:290}上方山坡上的马索吉那里。",

	-- Step 20: The Sepulcher
	-- {area:272} Tarren Mill · {area:228} The Sepulcher · {npc:2121} Shadow Priest Allister
	["Walk back up to {area:272} and fly to the {area:228}: {npc:2121} stands by the crypt entrance."] = "走回上方的{area:272}，飞往{area:228}：{npc:2121}站在墓穴入口旁。",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "{area:272}的飞行管理员",

	-- Step 21: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- {npc:2226} Karos Razok · {area:1497} Undercity
	["Fly on from {npc:2226}, the bat handler just east of the crypt, to the {area:1497}."] = "从墓穴东边不远处的蝙蝠管理员{npc:2226}继续飞往{area:1497}。",

	-- Step 22: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606}站在{object:36070}。",

	-- Step 23: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}，在炼金房",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "留着它：{area:287}海岸，路线后面会去",

	-- Step 24: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Warrior fastest."] = "趁在这里：向 {npc:11870} 学习 {spell:202}（{object:36070}，10 银币）；战士用双手武器升级最快。",

	-- Step 25: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); two-handers level a Warrior fastest."] = "顺路提示：向{npc:11870}学习长柄武器（{object:36070}，1 金）；战士使用双手武器升级最快。",

	-- Step 26: Archibald
	-- {spell:202} Two-Handed Swords · {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn {spell:202} from {npc:11870} ({object:36070}, 10 silver); two-handers level a Paladin fastest."] = "趁在这里：向 {npc:11870} 学习 {spell:202}（{object:36070}，10 银币）；圣骑士用双手武器升级最快。",

	-- Step 27: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Polearms from {npc:11870} ({object:36070}, 1 gold); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "顺路提示：向{npc:11870}学习长柄武器（{object:36070}，1 金）；猎人的近战武器主要用于提供属性，双手武器的属性通常更多。",

	-- Step 28: Archibald
	-- {npc:11870} Archibald · {object:36070} War Quarter
	["While you're here: learn Swords from {npc:11870} ({object:36070}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "顺便：在{npc:11870}处学习剑（{object:36070}，10银币）；主手持剑能让潜行者稳定升级。",

	-- Step 29: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885}：在{area:2362}使用其中一半",

	-- Step 30: Aquatic Form
	-- {quest:31} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Take {quest:31} from {npc:11802}, who stands upstairs in his building. Then {npc:11798} in {area:2361} flies druids to {area:1638}: {npc:3033} is on {area:1639}."] = "",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{area:2361}的{npc:11798}载德鲁伊飞往那里",

	-- Step 31: Back to the Crossroads
	["Back to the Crossroads"] = "返回十字路口",
	-- {npc:3033} Turak Runetotem
	["Train with {npc:3033}, then fly on to the Crossroads, where the next guide starts."] = "",

	-- Step 32: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 33: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 34: Orgrimmar
	["Train before you fly on: the next guide flies from here to the Crossroads."] = "继续飞行前先训练：下一份指南会从这里飞往十字路口。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "德鲁尔和{npc:2238}被锁在{area:275}庭院的建筑里；把两把锁都打开。",
	-- ["Fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "飞往{area:392}。{quest:874}在{area:392}北边的海岸上扎营。",
	-- ["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "沿道路向南前往{area:359}的矮人挖掘场。{npc:3421}躲在挖掘场南缘；{object:3646}在挖掘坑底部。",
	-- ["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "从{area:272}向东南进入山丘，前往{area:275}。沿途的营地由辛迪加潜行者和辛迪加卫士占据。",
	-- ["From {area:287} town go north into the foothills of Alterac: the western vial goes on the hilltop just past the border."] = "从{area:287}镇向北进入奥特兰克山麓：西边的药瓶放在刚过边界的山顶上。",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "从{zone:1454}（在{zone:1458}外的塔上乘飞艇）飞往{area:1638}，在{area:1639}训练，然后继续飞往{area:378}。",
	-- ["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "从{zone:1454}（在{zone:1458}外的塔上乘飞艇）飞往{area:378}。",
	-- ["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "用炉石回到{area:378}，飞往{area:392}。{quest:874}在{area:392}北边的海岸上扎营。",
	-- ["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "还没击败加里维克斯？职业指南“毒药（部落）”会从申苏尔处重新带你做这条任务线，并组队击败加里维克斯。",
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "还没击败加里维克斯？职业指南{spell:2842}（部落）会从申苏尔处重新带你做这条任务线，并组队击败加里维克斯。",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "仅当你已在{zone:1413}击败加里维克斯（申苏尔的潜行者任务线）时：{npc:2391}站在{area:272}。在他调制解药时在旁边等候，然后领取奖励：毒药。",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "仅当你已在{zone:1413}击败加里维克斯（申苏尔的潜行者任务线）时：{npc:2391}站在{area:272}。在他调制解药时在旁边等候，然后领取奖励：{spell:2842}。",
	-- ["Peasants and skulls"] = "农民和头骨",
	-- ["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "在巴尔莫丹西南，{npc:12576}在{area:485}顶部等候。",
	-- ["Syndicate camps"] = "辛迪加营地",
	-- ["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "在{zone:1458}外的塔上乘飞艇前往{zone:1454}，继续飞行前先训练。",
	-- ["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "希尔斯布莱德农民在农舍南边的田里干活。每个{area:287}人类都会掉落头骨；希尔斯布莱德农民掉得最多。",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "铁匠铺在{area:287}镇中央。{npc:2404}和他的希尔斯布莱德见习铁匠在熔炉旁干活；{item:3564}堆在旁边。{npc:2449}在它北边的街上走动。",
	-- ["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "市政厅在{area:287}西侧。{npc:2335}（30级）和{npc:2448}在里面，旁边是希尔斯布莱德城镇文档；希尔斯布莱德宣言就贴在它旁边。希尔斯布莱德议员在镇上走动。",
	-- ["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288}在{area:287}镇南边。希尔斯布莱德矿工在坑道里干活；{npc:2305}（30级）和{npc:2450}（29级）在深处。",
	-- ["The {quest:567} poster: Kalaba and Wilkes come up here, the clerk and the miner on the visit at about 32; inside"] = "{quest:567}告示：卡拉巴和威尔克斯在这里出现，书记员和矿工在大约32级再来时处理；在室内",
	-- ["The {quest:567} poster: its targets come up along the way"] = "{quest:567}告示：上面的目标会在沿途遇到",
	-- ["Town hall"] = "市政厅",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "你抵达时炉石已绑定在{area:272}的旅店。所有人都站在镇广场周围。",
	-- ["{npc:10079} stands at the top of the {area:1718}, beside {npc:12576}."] = "{npc:10079}站在{area:1718}顶部，在{npc:12576}旁边。",
	-- ["{npc:2230}, next to Lydon"] = "{npc:2230}，在林度恩旁边",
	-- ["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}，在{area:392}的码头旁",
	-- ["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "{npc:5899}的小屋在{area:378}南边野猪人水坑上方的山脊上，就在前往{area:359}的路上。",
	-- ["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}：蓝色水袋在{zone:1440}装满，见下一个指南",
	-- ["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}：{area:272}的红色水袋",
	-- ["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}是一头巨大的鱼龙，在{area:391}外的浅水中游动，位于{npc:3388}东边。",
}
