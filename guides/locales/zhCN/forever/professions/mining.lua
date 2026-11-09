-- Chinese (simplified) (zhCN): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "学习{skill:186}",
	-- {skill:186} Mining · {item:2901} Mining Pick · {spell:2580} Find Minerals · {item:2770} Copper Ore · {item:2835} Rough Stone · {item:11584} Cactus Apple Surprise · {item:247840} Mining for Dummies · {item:277115} Apprentice's Mining Pack · {spell:1230161} Lodestone
	-- plural, as words: Poor Copper Veins = {object:562111} Poor Copper Vein
	["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level (10c), and so does the Junior Mining Trainer in each starting area; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it. Turn on {spell:2580} (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins ({item:2770} and {item:2835}, from skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247840} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors and the junior trainers sell the {item:277115}, a four-slot bag for ore and stone (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:186}: hand it in to the mining trainer it names once you reach skill 20, for the {spell:1230161} recipe."] = "本阵营的任意{skill:186}训练师都教授初级{skill:186}，没有等级要求（10铜），每个初始地区的初级采矿训练师也会教；箭头会选择最近的一位。向杂货商或综合商人购买一个{item:2901}：放在背包里，没有它就无法采矿。开启{spell:2580}（法术书的综合页），让矿脉显示在微缩地图上。无限服初始地区还有贫瘠铜矿（产出{item:2770}和{item:2835}，技能1起）。每个初始地区最初一小时的任务（“鼠辈泛滥”、“寒脊山谷的送信任务”、“森林守护者”、戈加尔的{item:11584}、“一件琐事”、“玛拉的遗愿”）都提供{item:247840}作为奖励：阅读后提升2点技能，最高提升到15。杂货商和初级训练师出售{item:277115}，一种装矿石和石头的四格包（25铜）。如果你为“广阔天地”在初始地区的营火旁坐过，那里负责露营指引的NPC还会提供露营 101: {skill:186}：技能达到20后，向任务指定的采矿训练师交还，可获得{spell:1230161}配方。",

	-- Step 2: Copper: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (1-50)"] = "铜矿：{zone:1429}（1-50）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "开采沿途每个铜矿（1，橙色）和贫瘠铜矿（1，橙色）矿点，沿路径点循环，直到 {skill:186} 达到50。背包满时到熔炉旁熔炼：{spell:2657}（25前为橙色，70变灰）也能提升技能。地区等级1—10。提升这49点预计需开采约60个矿点。",
	["Copper"] = "铜矿",
	["Poor Copper"] = "贫瘠铜矿",
	["Copper, Poor Copper"] = "铜矿、贫瘠铜矿",

	-- Step 3: Copper & Poor Copper: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (1-50)"] = "铜矿与贫瘠铜矿：{zone:1426}（1—50）",

	-- Step 4: Copper: Darkshore (1-50)
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (1-50)"] = "铜矿：{zone:1439}（1-50）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 10-20. Expect about 60 nodes for these 49 points."] = "开采沿途每个铜矿（1，橙色）矿点，沿路径点循环，直到 {skill:186} 达到50。背包满时到熔炉旁熔炼：{spell:2657}（25前为橙色，70变灰）也能提升技能。地区等级10—20。提升这49点预计需开采约60个矿点。",

	-- Step 5: Copper: Zephras Isle (1-50)
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (1-50)"] = "铜矿：{zone:2521}（1-50）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 60 nodes for these 49 points."] = "沿途遇到的铜矿（1，橙色）都采，沿路径点循环，直到 {skill:186} 50。背包满时去熔炉熔炼：{spell:2657}（25 前为橙色，70 变灰）也能涨技能。地区等级 1-15。提升这 49 点预计需要采约 60 处矿点。",

	-- Step 6: Copper & Poor Copper: Durotar (1-50)
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (1-50)"] = "铜矿与贫瘠铜矿：{zone:1411}（1—50）",

	-- Step 7: Copper: Mulgore (1-50)
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (1-50)"] = "铜矿：{zone:1412}（1-50）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "开采沿途所有铜矿（1，橙色），沿路径点循环，直到{skill:186}50。背包满时去熔炉熔炼：{spell:2657}（25前为橙色，70变灰）也能提升技能。地区等级1-10。这49点预计需开采约60处矿点。",

	-- Step 8: Copper & Poor Copper: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (1-50)"] = "铜矿与贫瘠铜矿：{zone:1420}（1—50）",
	["Poor Copper, Copper"] = "贫瘠铜矿、铜矿",

	-- Step 9: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "中级{skill:186}",
	-- {skill:186} Mining · {spell:1230161} Lodestone · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:186} trainer of your faction. {spell:1230161}, Forever's camping item for {skill:186}, is taught from skill 20 (1s, or free from Camping 101: {skill:186}): a {item:2835} and a {item:2840} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "中级 {skill:186} 将上限提高到 150；要求技能 50，无角色等级要求，费用 5 银币：一到 50 就去学。箭头会选择本阵营最近的 {skill:186} 训练师。无限的 {skill:186} 露营物品 {spell:1230161} 在技能 20 起可学（1 银币，或通过露营 101: {skill:186} 免费学习）：每次需要一个 {item:2835} 和一个 {item:2840}，制作可涨技能至 25；放在营火旁，会给予营地内所有人持续一小时的增益。",

	-- Step 10: Copper: Elwynn Forest (50-65) cont.
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (50-65) cont."] = "铜矿：{zone:1429}（50-65）续",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "开采沿途每个铜矿（1，黄色）和贫瘠铜矿（1，黄色）矿点，沿路径点循环采矿，直到 {skill:186} 65。背包满了就到熔炉旁熔炼：{spell:2657}（25前橙色，70变灰）也能涨点。地区等级1—10。提升这15点预计需要开采约80个矿点。",

	-- Step 11: Copper & Poor Copper: Dun Morogh (50-65) cont.
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (50-65) cont."] = "铜矿与贫瘠铜矿：{zone:1426}（50—65），续",

	-- Step 12: Copper: Darkshore (50-65) cont.
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (50-65) cont."] = "铜矿：{zone:1439}（50-65）续",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 10-20. Expect about 80 nodes for these 15 points."] = "开采沿途所有铜矿（技能 1，黄色），沿路径点循环采矿，直到 {skill:186} 达到 65。背包满时到熔炉熔炼：{spell:2657}（25 前为橙色，70 变灰）也能提升技能。地区等级为 10-20 级。提升这 15 点预计需要开采约 80 个矿点。",

	-- Step 13: Copper: Zephras Isle (50-65) cont.
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (50-65) cont."] = "铜矿：{zone:2521}（50-65）续",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 80 nodes for these 15 points."] = "开采沿途每个铜矿（1，黄色），沿路径点循环，直到{skill:186}65。背包满时到熔炉熔炼：{spell:2657}（25前为橙色，70变灰）也能提升技能。地区等级1-15。提升这15点预计需要约80个矿点。",

	-- Step 14: Copper & Poor Copper: Durotar (50-65) cont.
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (50-65) cont."] = "铜矿与贫瘠铜矿：{zone:1411}（50—65），续",

	-- Step 15: Copper: Mulgore (50-65) cont.
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (50-65) cont."] = "铜矿：{zone:1412}（50-65）续",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "开采沿途每个铜矿（1，黄色）矿点，沿路径点循环，直到 {skill:186} 达到65。背包满时到熔炉旁熔炼：{spell:2657}（25前为橙色，70变灰）也能提升技能。地区等级1—10。提升这15点预计需开采约80个矿点。",

	-- Step 16: Copper & Poor Copper: Tirisfal Glades (50-65) cont.
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (50-65) cont."] = "铜矿与贫瘠铜矿：{zone:1420}（50—65），续",

	-- Step 17: Smelt Bronze & Smelt Tin
	-- {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["At 65 a {skill:186} trainer teaches {spell:2659} (2s; grey at 115) and {spell:3304} (50c; grey at 75): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "65时，{skill:186} 训练师会教授 {spell:2659}（2银币；115变灰）和 {spell:3304}（50铜币；75变灰）：在熔炉旁熔炼也能提升 {skill:186}，所以把采到的矿石熔炼掉。",

	-- Step 18: Incendicite & Tin: Wetlands (65-125)
	-- {zone:1437} Wetlands
	["Incendicite & Tin: {zone:1437} (65-125)"] = "火岩矿石和锡矿：{zone:1437}（65-125）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Incendicite (65, orange), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "开采沿途每个铜矿（1，绿色）、火岩矿（65，橙色）、锡矿（65，橙色）和银矿（75起，稀少）矿点，沿路径点循环采矿，直到 {skill:186} 125。背包满了就到熔炉旁熔炼：{spell:2657}（25前橙色，70变灰）、{spell:3304}（75变灰）和 {spell:2659}（115变灰）也能涨点。每次 {spell:2659} 需要一块 {item:2840} 和一块 {item:3576}：保留之前熔炼所得的锭。地区等级20—30。提升这60点预计需要开采约130个矿点。75起可学 {spell:2658}（2银币；100前橙色，125变灰）：经过 {skill:186} 训练师时再学，不值得专程跑一趟。",
	["Tin, Copper"] = "锡矿、铜矿",
	["Incendicite, Tin"] = "火岩矿石、锡矿",

	-- Step 19: Tin: Ashenvale (65-125)
	-- {zone:1440} Ashenvale
	["Tin: {zone:1440} (65-125)"] = "锡矿：{zone:1440}（65—125）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 18-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "开采沿途每个铜矿（1，绿色）、锡矿（65，橙色）和银矿（75起，稀有），沿路径点循环，直到{skill:186}125。背包满时到熔炉熔炼：{spell:2657}（25前为橙色，70变灰）、{spell:3304}（75变灰）、{spell:2659}（115变灰）也能提升技能。每次{spell:2659}需要一个{item:2840}和一个{item:3576}：保留之前熔炼的锭。地区等级18-30。提升这60点预计需要约130个矿点。{spell:2658}（2银；100前为橙色，125变灰）75起可学：路过{skill:186}训练师时可以学，不值得专程跑一趟。",
	["Tin, Silver"] = "锡矿、银矿",
	["Tin"] = "锡矿",

	-- Step 20: Copper & Tin: The Barrens (65-125)
	-- {zone:1413} The Barrens
	["Copper & Tin: {zone:1413} (65-125)"] = "铜矿与锡矿：{zone:1413}（65—125）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 10-25. Expect about 280 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "开采沿途每个铜矿（1，绿色）、锡矿（65，橙色）、银矿（75起可采，稀有）矿点，沿路径点循环，直到 {skill:186} 达到125。背包满时到熔炉旁熔炼：{spell:2657}（25前为橙色，70变灰）、{spell:3304}（75变灰）、{spell:2659}（115变灰）也能提升技能。{spell:2659} 每次需要一块 {item:2840} 和一块 {item:3576}：保留之前熔炼的金属锭。地区等级10—25。提升这60点预计需开采约280个矿点。{spell:2658}（2银币；100前为橙色，125变灰）在75点起可学：路过 {skill:186} 训练师时可以学习，不值得专程跑一趟。",
	["Copper, Tin"] = "铜矿、锡矿",

	-- Step 21: Tin: Hillsbrad Foothills (65-125)
	-- {zone:1424} Hillsbrad Foothills
	["Tin: {zone:1424} (65-125)"] = "锡矿：{zone:1424}（65—125）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 140 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "沿途遇到的铜矿（1，绿色）、锡矿（65，橙色）和银矿（75 起，稀有）都采，沿路径点循环，直到 {skill:186} 125。背包满时去熔炉熔炼：{spell:2657}（25 前为橙色，70 变灰）、{spell:3304}（75 变灰）和 {spell:2659}（115 变灰）也能涨技能。{spell:2659} 每次需要一个 {item:2840} 和一个 {item:3576}：留着此前熔炼的金属锭。地区等级 20-30。提升这 60 点预计需要采约 140 处矿点。技能 75 起可学 {spell:2658}（2 银币；100 前为橙色，125 变灰）：经过 {skill:186} 训练师时就学，不值得为它单跑一趟。",

	-- Step 22: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "高级{skill:186}",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:186} trainer of your faction. Learn {spell:3307} (5s; orange to 130, grey at 140) on the same visit: smelting at a forge raises {skill:186} too, so smelt what you mine."] = "高级{skill:186}将上限提高到225；需要技能125，没有角色等级要求，费用50银：一到125就学。箭头会选择本阵营最近的{skill:186}训练师。同一趟也学会{spell:3307}（5银；130前为橙色，140变灰）：在熔炉熔炼同样能提升{skill:186}，因此把采到的矿熔炼掉。",

	-- Step 23: Iron: Arathi Highlands (125-155)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (125-155)"] = "铁矿：{zone:1417}（125-155）",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt at a forge when your bags fill: {spell:3307} (orange to 130, grey at 140) gives points too. Zone level 30-40. Expect about 50 nodes for these 30 points."] = "开采沿途所有锡矿（65，绿色）、次级血石矿（75，绿色）、银矿（75，绿色，稀有）和铁矿（125，橙色），沿路径点循环，直到{skill:186}155。背包满时去熔炉熔炼：{spell:3307}（130前为橙色，140变灰）也能提升技能。地区等级30-40。这30点预计需开采约50处矿点。",
	["Iron, Tin"] = "铁矿、锡矿",
	["Lesser Bloodstone, Silver"] = "次级血石矿、银矿",

	-- Step 24: Iron: Arathi Highlands (155-175)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (155-175)"] = "铁矿：{zone:1417}（155—175）",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, yellow), Gold (155, orange, rare) node you pass and circle the waypoints until {skill:186} 175. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 30-40. Expect about 40 nodes for these 20 points. {spell:3308} (25s; orange to 170, grey at 185) is taught from 155: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "开采沿途每个锡矿（65，绿色）、次级血石矿（75，绿色）、银矿（75，绿色，稀有）、铁矿（125，黄色）、金矿（155，橙色，稀有）矿点，沿路径点循环，直到 {skill:186} 达到175。背包满时到熔炉旁熔炼：{spell:3308}（170前为橙色，185变灰）也能提升技能。地区等级30—40。提升这20点预计需开采约40个矿点。{spell:3308}（25银币；170前为橙色，185变灰）在155点起可学：路过 {skill:186} 训练师时可以学习，不值得专程跑一趟。",
	["Lesser Bloodstone, Gold"] = "次级血石、金矿",

	-- Step 25: Mithril: Badlands (175-200)
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (175-200)"] = "秘银矿：{zone:1418}（175-200）",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 35-45. Expect about 40 nodes for these 25 points."] = "开采沿途所有铁矿（技能 125，绿色）、金矿（技能 155，橙色）、秘银矿（技能 175，橙色），沿路径点循环采矿，直到 {skill:186} 达到 200。背包满时到熔炉熔炼：{spell:3308}（170 前为橙色，185 变灰）也能提升技能。地区等级为 35-45 级。提升这 25 点预计需要开采约 40 个矿点。",
	["Iron, Mithril"] = "铁矿、秘银矿",

	-- Step 26: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "专家级{skill:186}",
	-- {skill:186} Mining
	["Artisan {skill:186} raises the cap to 300; it needs skill 200 and no character level, and costs 5g: train it as soon as you reach 200. The arrow picks the nearest {skill:186} trainer of your faction."] = "大师级 {skill:186} 将上限提高到300；需要技能200，无角色等级要求，费用5金币：达到200就立即学习。箭头会选择本阵营最近的 {skill:186} 训练师。",

	-- Step 27: Mithril: Badlands (200-230) cont.
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (200-230) cont."] = "秘银矿：{zone:1418}（200-230），续",
	-- {skill:186} Mining
	["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 35-45. Expect about 90 nodes for these 30 points."] = "沿途遇到的铁矿（125，绿色）、金矿（155，黄色）和秘银矿（175，黄色）都采，沿路径点循环，直到 {skill:186} 230。从这里开始，熔炼不能再涨技能（更高级的熔炼一学会就是灰色）：可以熔炼用于制造或出售，也可以直接卖矿石。地区等级 35-45。提升这 30 点预计需要采约 90 处矿点。",

	-- Step 28: Mithril & Dark Iron: Searing Gorge (230-245)
	-- {object:147516} Dark Iron · {zone:1427} Searing Gorge
	["Mithril & {object:147516}: {zone:1427} (230-245)"] = "秘银与{object:147516}：{zone:1427}（230-245）",
	-- {object:147516} Dark Iron · {skill:186} Mining · {item:11099} Dark Iron Ore · {object:174824} Black Forge (no name in this language: may be words) · {area:1584} Blackrock Depths
	["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. {item:11099} smelts only at the {object:174824} in {area:1584} (8 ore a bar). Zone level 43-50. Expect about 40 nodes for these 15 points."] = "开采沿途每个金矿（155，绿色）、秘银矿（175，绿色）、{object:147516}（230，橙色）和真银矿（230，橙色）矿点，沿路径点循环采矿，直到 {skill:186} 245。从这里起，熔炼不再涨点（更高级的熔炼配方学会时就已经是灰色）：熔炼后用于制作或出售，或直接卖矿石。{item:11099} 只能在 {area:1584} 的 {object:174824} 熔炼（8块矿石熔一锭）。地区等级43—50。提升这15点预计需要开采约40个矿点。",
	-- {object:147516} Dark Iron
	["Mithril, {object:147516}"] = "秘银矿、{object:147516}",

	-- Step 29: Small Thorium: Felwood (245-275)
	-- {zone:1448} Felwood
	["Small Thorium: {zone:1448} (245-275)"] = "小型瑟银矿：{zone:1448}（245—275）",
	-- {skill:186} Mining · {npc:9528} Arathandris Silversky · {npc:9529} Maybess Riverbreeze
	["Mine every Gold (155, green, rare), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Quests here that need {skill:186}: Salve via {skill:186} (level 55, {npc:9528}; Alliance), Salve via {skill:186} (level 55, {npc:9529}; Horde). Zone level 48-55. Expect about 50 nodes for these 30 points."] = "开采沿途所有金矿（155，绿色，稀有）、秘银矿（175，绿色）、真银矿（230，橙色）和瑟银矿脉（245，橙色），沿路径点循环，直到{skill:186}275。从此阶段起，熔炼不再涨技能（更高级的熔炼配方学会时就已是灰色）：可熔炼用于制作或出售，也可直接卖矿石。这里需要{skill:186}的任务：“{skill:186}换药膏”（55级，{npc:9528}；联盟）及“{skill:186}换药膏”（55级，{npc:9529}；部落）。地区等级48-55。这30点预计需开采约50处矿点。",
	["Mithril, Small Thorium"] = "秘银、瑟银矿脉",
	["Small Thorium, Truesilver"] = "瑟银矿脉、真银矿",

	-- Step 30: Small Thorium & Rich Thorium: Winterspring (275-300)
	-- {zone:1452} Winterspring
	["Small Thorium & Rich Thorium: {zone:1452} (275-300)"] = "瑟银矿脉和富瑟银矿：{zone:1452}（275-300）",
	-- {skill:186} Mining
	["Mine every Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 55-60. Expect about 40 nodes for these 25 points."] = "开采沿途每个真银矿（230，黄色）、瑟银矿（245，黄色）和富瑟银矿（275，橙色），沿路径点循环，直到{skill:186}300。从这里开始熔炼不再提升技能（更高级的熔炼技能一学会就是灰色）：可熔炼后用于制作或出售，也可直接卖矿石。地区等级55-60。提升这25点预计需要约40个矿点。",
	["Rich Thorium, Small Thorium"] = "富瑟银矿、瑟银矿脉",
	["Rich Thorium, Truesilver"] = "富瑟银、真银",
	["Rich Thorium"] = "富瑟银矿",
	["Small Thorium, Rich Thorium"] = "瑟银矿脉、富瑟银矿",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "本阵营任何{skill:186}训练师都能传授初级{skill:186}（角色等级5）；箭头会指向最近的一位。从商品商人或杂货商处购买一把{item:2901}：放在背包里，没有它就无法采矿。",
	-- ["Artisan {skill:186} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:186} trainer of your faction."] = "专家级{skill:186}将上限提升到300；需要技能200和角色等级35。箭头会指向本阵营最近的{skill:186}训练师。",
	-- ["Copper, Silver"] = "铜矿、银矿",
	-- ["Copper: {zone:1411} (1-50)"] = "铜矿：{zone:1411}（1-50）",
	-- ["Copper: {zone:1411} (50-65) cont."] = "铜矿：{zone:1411}（50-65）续",
	-- ["Copper: {zone:1420} (1-50)"] = "铜矿：{zone:1420}（1-50）",
	-- ["Copper: {zone:1420} (50-65) cont."] = "铜矿：{zone:1420}（50-65）续",
	-- ["Copper: {zone:1426} (1-50)"] = "铜矿：{zone:1426}（1-50）",
	-- ["Copper: {zone:1426} (50-65) cont."] = "铜矿：{zone:1426}（50-65）续",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "高级{skill:186}将上限提升到225；需要技能125和角色等级20。箭头会指向本阵营最近的{skill:186}训练师。",
	-- ["Gold"] = "金矿石",
	-- ["Gold & Mithril: {zone:1435} (175-200)"] = "金矿石和秘银矿脉：{zone:1435}（175-200）",
	-- ["Gold & Mithril: {zone:1435} (200-230) cont."] = "金矿石和秘银矿脉：{zone:1435}（200-230）续",
	-- ["Gold, Iron"] = "金矿石、铁矿石",
	-- ["Gold, Mithril"] = "金矿石、秘银矿脉",
	-- ["Gold: {zone:1435} (155-175)"] = "金矿石：{zone:1435}（155-175）",
	-- ["Iron, Silver"] = "铁矿石、银矿",
	-- ["Iron: {zone:1416} (125-155)"] = "铁矿石：{zone:1416}（125-155）",
	-- ["Iron: {zone:1431} (125-155)"] = "铁矿石：{zone:1431}（125-155）",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "中级{skill:186}将上限提升到150；需要技能50和角色等级10。箭头会指向本阵营最近的{skill:186}训练师。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "开采沿途所有铜矿（1，绿色）、锡矿（65，橙色）、银矿（75起），绕着路径点循环，直到{skill:186}达到125。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级10-20。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "开采沿途所有铜矿（1，绿色）、锡矿（65，橙色）、银矿（75起），绕着路径点循环，直到{skill:186}达到125。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级10-25。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "开采沿途所有铜矿（1，绿色）、锡矿（65，橙色）、银矿（75起），绕着路径点循环，直到{skill:186}达到125。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级15-25。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "开采沿途所有铜矿（1，绿色）、锡矿（65，橙色）、银矿（75起），绕着路径点循环，直到{skill:186}达到125。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级20-30。",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "开采沿途所有铜矿（1，橙色），绕着路径点循环，直到{skill:186}达到50。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级1-10。",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "开采沿途所有铜矿（1，橙色），绕着路径点循环，直到{skill:186}达到50。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级10-20。",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "开采沿途所有铜矿（1，黄色），绕着路径点循环，直到{skill:186}达到65。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级1-10。",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "开采沿途所有铜矿（1，黄色），绕着路径点循环，直到{skill:186}达到65。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级10-20。",
	-- ["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "开采沿途所有金矿石（155，绿色）、秘银矿脉（175，绿色）、真银矿石（230，橙色）、瑟银矿脉（245，橙色），绕着路径点循环，直到{skill:186}达到275。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级45-55。",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "开采沿途所有金矿石（155，绿色）、秘银矿脉（175，绿色）、{object:147516}（230，橙色）、真银矿石（230，橙色），绕着路径点循环，直到{skill:186}达到245。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级43-50。",
	-- ["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "开采沿途所有铁矿石（125，绿色）、金矿石（155，橙色）、秘银矿脉（175，橙色），绕着路径点循环，直到{skill:186}达到200。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级35-45。",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "开采沿途所有铁矿石（125，绿色）、金矿石（155，黄色）、秘银矿脉（175，黄色），绕着路径点循环，直到{skill:186}达到230。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级35-45。",
	-- ["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "开采沿途所有银矿（75，绿色）、铁矿石（125，黄色）、金矿石（155，橙色），绕着路径点循环，直到{skill:186}达到175。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级35-45。",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "开采沿途所有锡矿（65，绿色）、银矿（75，绿色）、铁矿石（125，橙色），绕着路径点循环，直到{skill:186}达到155。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级18-30。",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 30-40."] = "开采沿途所有锡矿（65，绿色）、银矿（75，绿色）、铁矿石（125，橙色），绕着路径点循环，直到{skill:186}达到155。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级30-40。",
	-- ["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "开采沿途所有{object:147516}（230，黄色）、真银矿石（230，黄色）、瑟银矿脉（245，黄色）、富瑟银矿（275，橙色），绕着路径点循环，直到{skill:186}达到300。背包满了就到熔炉熔炼矿石：熔炼也能提升{skill:186}。地区等级50-58。",
	-- ["Rich Thorium: {zone:1428} (275-300)"] = "富瑟银矿：{zone:1428}（275-300）",
	-- ["Silver, Tin"] = "银矿、锡矿",
	-- ["Tin & Silver: {zone:1413} (65-125)"] = "锡矿和银矿：{zone:1413}（65-125）",
	-- ["Tin & Silver: {zone:1424} (65-125)"] = "锡矿和银矿：{zone:1424}（65-125）",
	-- ["Tin & Silver: {zone:1433} (65-125)"] = "锡矿和银矿：{zone:1433}（65-125）",
	-- ["Tin & Silver: {zone:1439} (65-125)"] = "锡矿和银矿：{zone:1439}（65-125）",
	-- ["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "真银矿石和瑟银矿脉：{zone:1419}（245-275）",
	-- ["Truesilver, {object:147516}"] = "真银矿石、{object:147516}",
	-- ["{object:147516} & Truesilver: {zone:1427} (230-245)"] = "{object:147516}和真银矿石：{zone:1427}（230-245）",
	-- ["{object:147516}, Gold"] = "{object:147516}、金矿石",
	-- ["{object:147516}, Rich Thorium"] = "{object:147516}、富瑟银矿",
}
