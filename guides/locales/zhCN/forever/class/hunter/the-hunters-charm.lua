-- Chinese (simplified) (zhCN): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Classic's item choice may be gone on Forever."] = "50级时在{zone:1447}和{area:1417}获得经验；无限上可能已没有经典版的物品选择。",
	["Experience"] = "经验",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151}（联盟）",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "50级时任何联盟猎人训练师都会提供此任务：{zone:1453}{object:28027}的{npc:5516}、{zone:1455}{object:32390}的{npc:5116}，或{zone:1457}塞纳里奥区的多利安。",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151}（部落）",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "50级时任何部落猎人训练师都提供此任务：{zone:1454}{object:172958}的{npc:3352}，或{zone:1456}{area:1641}上的{npc:3039}。",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {zone:1447} Azshara · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives on a raised spot on the cliffs at the north-east rim of the {area:1221}, west-central {zone:1447}. Keep to the high ridges around the ruins: the pit below does not lead up to him. Alliance: fly to {area:3137}; Horde: fly to {area:1237}, a short ride west of him."] = "{npc:8405} 住在 {zone:1447} 中西部、{area:1221} 东北边缘的崖顶高地上。沿遗迹周围的高处山脊走：下面的坑里没有通往他的路。联盟：飞到 {area:3137}；部落：飞到他西边不远的 {area:1237}。",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara · {area:1220} Thalassian Base Camp · {area:1237} Valormok · {area:1234} Lake Mennar
	-- plural, as words: Perfect Courser Antlers = {item:20017} Perfect Courser Antler · Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["You need two Perfect Courser Antlers. Mosshoof Coursers (level 52-53, deer) graze all over {zone:1447} and drop one about one kill in twelve, so expect two dozen kills. Good herds: north of the {area:1220} in the north, and the hills north-east and south-east of {area:1237}; the {area:1234} area also has elite giants and dragonkin. They Enrage at 30% health. Coursers share spawn points with the Thunderhead hippogryphs: if none are around, kill the hippogryphs and coursers may spawn instead. Respawn is about five and a half minutes."] = "你需要两个完美的鹿角。苔蹄快步者（52-53级，鹿）在{zone:1447}各处吃草，掉率约为十二只出一个，预计要击杀二十四只。较好的鹿群位置：北部{area:1220}以北，以及{area:1237}东北和东南的山丘；{area:1234}一带还有精英巨人和龙类。它们在生命值降至30%时会激怒。苔蹄快步者与电角蜥蜴角鹰兽共用刷新点：如果没有鹿，就杀掉角鹰兽，之后可能会刷出鹿。刷新时间约为五分半钟。",
	-- {item:20017} Perfect Courser Antler
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["{item:20017}, from Mosshoof Coursers"] = "{item:20017}，由苔蹄快步者掉落",

	-- Step 6: Wavethrashing
	-- {item:20087} Wavethrasher Scales · {zone:1447} Azshara · {area:1229} Tower of Eldara · {spell:1494} Track Beasts
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["You need six {item:20087}. Wavethrashers (three-headed sea beasts) live along {zone:1447}'s coasts, mostly underwater: the Young Wavethrashers (level 51-52) of the north-east shore drop a scale about one kill in three, the Wavethrashers (52-53) of the east coast by the {area:1229} about as often (a few walk the beach there), the Great Wavethrashers (53-54) of the south-east shore about one in seven. {spell:1494} does not show them; fight them where you can breathe, and bring water breathing if you can. Elite sharks swim the deeper water."] = "你需要六片 {item:20087}。碎浪多头怪是三头海兽，生活在 {zone:1447} 的沿海，多数在水下：东北海岸的幼年碎浪多头怪（51—52级）约三只掉一片鳞片；东海岸 {area:1229} 附近的碎浪多头怪（52—53级）掉率差不多（那里也有少数在沙滩上行走）；东南海岸的大型碎浪多头怪（53—54级）掉率约为七分之一。{spell:1494} 不会显示它们；在能呼吸的位置战斗，条件允许时带上水下呼吸手段。深水区有精英鲨鱼。",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}中的摩弗拉斯",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {area:75} Stonard · {area:1438} Nethergarde Keep · {area:42} Darkshire · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:11019} Wing Flap
	["Morphaz is an elite green drake (level 52) inside the {area:1417}, a five-player dungeon: needs a group of five. The temple stands in the {area:74} in eastern {zone:1435}: climb its outer steps, dive into the flooded hall and follow the stairs down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} or {area:42} and ride on. He is not there when you arrive: first kill the six troll guardians on the platforms around the upper ring, which opens the way down to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe (pull them one at a time); when both are dead, Morphaz and Hazzas appear together and cannot be split. Clear the dragonkin around the pit first, because they call for help. Morphaz uses {spell:12533} and {spell:11019}. The tooth always drops. Warriors in the group may want the same run for the voodoo feathers of the balcony trolls."] = "摩弗拉斯是 {area:1417} 内的一只精英绿龙（52级），该地下城为五人地下城：需要五人小队。神庙位于 {zone:1435} 东部的 {area:74}：登上外围台阶，潜入积水大厅，再沿楼梯下到入口。部落：飞往 {area:75}；联盟：飞往 {area:1438} 或 {area:42}，再骑马前往。刚进去时他还没出现：先击杀上层环廊各平台上的六名巨魔守护者，才会打开下行通道，通向祭祀大坑中的 {npc:5710}。迦玛兰死后会出现两只绿龙，德拉维沃尔和德姆塞卡尔（逐只引出）；两只都死后，摩弗拉斯和哈扎斯会一起出现，无法分开。先清理池子周围的龙人，因为它们会呼救。摩弗拉斯会使用 {spell:12533} 和 {spell:11019}。牙齿必定掉落。队里的战士可能也需要来这一趟，收集看台上巨魔掉落的巫毒羽毛。",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}，在{area:1417}内",

	-- Step 9: The Green Drake
	-- {item:19991} Devilsaur Eye · {item:19992} Devilsaur Tooth · {item:20083} Hunting Spear
	["In Classic Ogtinc let you choose the {item:19991}, the {item:19992} or the {item:20083} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "在经典怀旧服中，奥汀克会让你在 {item:19991}、{item:19992} 和 {item:20083} 之间选择一件。无限的更新说明称这项选择已取消，但其任务页面仍列出三件未命名的奖励：交还前先查看奖励窗口。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' {area:1658}."] = "50级时任何联盟猎人训练师都提供此任务：{zone:1453}{object:28027}的{npc:5516}、{zone:1455}{object:32390}的{npc:5116}，或{zone:1457}{area:1658}的多利安。",
	-- ["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50级时在{zone:1447}和{area:1417}获得经验；Forever移除了经典版的物品选择。",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "摩弗拉斯是{area:1417}内的精英龙类首领，这是一个五人地下城：请带上小队。神庙位于{area:74}中央；潜下去即可到达入口。部落：飞往{area:75}；联盟：飞往{area:42}或{area:1438}，再继续骑行。",
	-- ["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "{npc:8761}在{zone:1447}各处吃草；大约每十几只会有一只掉落一对{item:20017}。",
	-- ["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "碎浪多头怪沿{zone:1447}的海岸爬行：东北岸的幼年碎浪多头怪和东岸的碎浪多头怪掉落鳞片的几率约为南岸大型碎浪多头怪的两倍。",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405}住在{area:1221}东北的悬崖顶上。联盟：飞往{area:3137}；部落：飞往{area:1237}。",
}
