-- Chinese (simplified) (zhCN): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["{area:272} is your base for this guide: the hearth brings you back here twice. Everyone stands around the town square."] = "{area:272}是本指南的据点：炉石会两次把你带回这里。所有人都站在镇广场周围。",
	-- {npc:2388} Innkeeper Shay
	["{npc:2388}: the last guide binds here, so this usually ticks at once"] = "{npc:2388}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "旅店旁的{object:1763}告示",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way"] = "{quest:567}告示：上面的目标会在沿途遇到",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "在旅店旁的{object:107045}装满{item:7768}",

	-- Step 2: Serge Hinott
	-- {zone:1413} The Barrens · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "仅当你已在{zone:1413}击败加里维克斯（申苏尔的潜行者任务线）时：{npc:2391}站在{area:272}。在他调制解药时在旁边等候，然后领取奖励：毒药。",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}：毒药",
	["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "还没击败加里维克斯？职业指南“毒药（部落）”会从申苏尔处重新带你做这条任务线，并组队击败加里维克斯。",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "熊、食苔蛛和山地狮",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "在塔伦米尔西边，{npc:2351}、{npc:2350}和{npc:2384}在通往农场的山丘上游荡。食苔蛛很少掉落{item:3477}；你只需要一个。",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "{area:287}镇东边的农场。{npc:232}在北边农舍旁的田里干活，{npc:2403}在更东南的那片田；到处都是希尔斯布莱德雇农和希尔斯布莱德农夫。{npc:2451}照料农场南边的田地。",

	-- Step 5: Tarren Mill
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon"] = "{npc:2230}，在林度恩旁边",

	-- Step 6: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274}是{npc:232}的狗，在{area:286}北边的农舍旁。",

	-- Step 7: Peasants and skulls
	["Peasants and skulls"] = "农民和头骨",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "希尔斯布莱德农民在农舍南边的田里干活。每个{area:287}人类都会掉落头骨；希尔斯布莱德农民掉得最多。",
	-- {item:3692} Hillsbrad Human Skull
	["{item:3692}: the Peasants in the fields"] = "{item:3692}：田里的希尔斯布莱德农民",

	-- Step 8: Tarren Mill
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}：给{npc:270438}的命令，在前往敦霍尔德城堡的路上",

	-- Step 9: Syndicate camps
	["Syndicate camps"] = "辛迪加营地",
	-- {area:272} Tarren Mill · {area:275} Durnholde Keep
	["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "从{area:272}向东南进入山丘，前往{area:275}。沿途的营地由辛迪加潜行者和辛迪加卫士占据。",

	-- Step 10: Durnholde Keep
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "德鲁尔和{npc:2238}被锁在{area:275}庭院的建筑里；把两把锁都打开。",
	["Drull's ball and chain"] = "德鲁尔的镣铐",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "{npc:2238}的镣铐",

	-- Step 11: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj躲在{area:290}上方的山坡上，位于敦霍尔德城堡南边，就在下去采花的路上。",

	-- Step 12: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "在敦霍尔德城堡西南，{item:3502}长在河上方的山坡上。",

	-- Step 13: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{npc:2055}，在{zone:1458}",

	-- Step 14: The smithy
	["The smithy"] = "铁匠铺",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "铁匠铺在{area:287}镇中央。{npc:2404}和他的希尔斯布莱德见习铁匠在熔炉旁干活；{object:1736}堆在旁边。{npc:2449}在它北边的街上走动。",

	-- Step 16: Town hall
	["Town hall"] = "市政厅",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "市政厅在{area:287}西侧。{npc:2335}（30级）和{npc:2448}在里面，旁边是希尔斯布莱德城镇文档；希尔斯布莱德宣言就贴在它旁边。希尔斯布莱德议员在镇上走动。",

	-- Step 18: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288}在{area:287}镇南边。希尔斯布莱德矿工在坑道里干活；{npc:2305}（30级）和{npc:2450}（29级）在深处。",

	-- Step 20: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "{npc:2055}，在炼金房",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "留着它：{area:287}海岸，路线后面会去",

	-- Step 21: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "在{zone:1458}外的塔上乘飞艇前往{zone:1454}，继续飞行前先训练。",

	-- Step 22: Thunder Bluff
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:1638} Thunder Bluff · {area:1639} Elder Rise · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "从{zone:1454}（在{zone:1458}外的塔上乘飞艇）飞往{area:1638}，在{area:1639}训练，然后继续飞往{area:378}。",

	-- Step 23: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "从{zone:1454}（在{zone:1458}外的塔上乘飞艇）飞往{area:378}。",

	-- Step 24: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "{npc:5899}的小屋在{area:378}南边野猪人水坑上方的山脊上，就在前往{area:359}的路上。",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}：{area:272}的红色水袋",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}：蓝色水袋在{zone:1440}装满，见下一个指南",

	-- Step 25: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "沿道路向南前往{area:359}的矮人挖掘场。{npc:3421}躲在挖掘场南缘；{object:3646}在挖掘坑底部。",

	-- Step 26: Great Lift
	-- {npc:12576} Grish Longrunner · {area:485} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:485}."] = "在巴尔莫丹西南，{npc:12576}在{area:485}顶部等候。",

	-- Step 27: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "用炉石回到{area:378}，飞往{area:392}。{quest:874}在{area:392}北边的海岸上扎营。",

	-- Step 28: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}是一头巨大的鱼龙，在{area:391}外的浅水中游动，位于{npc:3388}东边。",

	-- Step 29: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{npc:3442}，在{area:392}的码头旁",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "还没击败加里维克斯？职业指南{spell:2842}（部落）会从申苏尔处重新带你做这条任务线，并组队击败加里维克斯。",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "仅当你已在{zone:1413}击败加里维克斯（申苏尔的潜行者任务线）时：{npc:2391}站在{area:272}。在他调制解药时在旁边等候，然后领取奖励：{spell:2842}。",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "铁匠铺在{area:287}镇中央。{npc:2404}和他的希尔斯布莱德见习铁匠在熔炉旁干活；{item:3564}堆在旁边。{npc:2449}在它北边的街上走动。",
	-- ["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "你抵达时炉石已绑定在{area:272}的旅店。所有人都站在镇广场周围。",
}
