-- Chinese (simplified) (zhCN): the guide forever/class/hunter/taming-the-beast-alliance (forever/class/hunter/taming-the-beast-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6063} Taming the Beast
	["{quest:6063} (Alliance)"] = "{quest:6063}（联盟）",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "10级获得自己的宠物：用{item:15908}完成三次驯服练习，学会{spell:1515}，然后学会{spell:5149}。",

	-- Step 1: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "10 级时，{zone:2521} 上的猎人训练师 {npc:254084} 可能会给你 {quest:94007}，让你前往 {area:16638}。这只是引导任务：如果已经在 {area:16638}，可以跳过。",

	-- Step 2: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{area:16638}的{npc:252389}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} 与训练师们一起站在 {area:16638} 西门旁，{npc:254411} 就在她身边。",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389}：第一份{item:15908}",

	-- Step 3: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod · {npc:252389} Quel'ana Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges. Killing one does not count. Keep each rod: it goes back to {npc:252389}."] = "风歌爬行者只生活在水边：最近的一群在{area:16638}西南方的岸边，与螃蟹混杂在一起。驯服棒用法：选中一只活着的爬行者，使用{item:15908}，在整个引导期间站着不动，任由它攻击你；移动、还击或其他人帮忙都会打断引导，并消耗驯服棒本就不多的使用次数。击杀不算数。保留每根驯服棒：要交还给{npc:252389}。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "对一只活着的爬行者使用{item:15908}",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "驯服{npc:254588}",

	-- Step 4: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "先解散爬行者（右键点击宠物头像，选择{spell:2641}）。暴躁的疾风陆行鸟在{area:16626}觅食，那片田野位于{area:16638}以西及西南不远处。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "对一只活着的风行者使用 {item:15908}。",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "驯服{npc:251707}",

	-- Step 5: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "解散疾风陆行鸟。瓦尔德伦头狼也在{area:16626}猎食，位置稍靠南。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "对一只活着的头狼使用{item:15908}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "驯服{npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}，在她旁边：{spell:5149}",

	-- Step 6: Grif Wildheart in Kharanos
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos
	["{npc:1231} in {area:131}"] = "{area:131}的{npc:1231}",
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:11807} Tristane Shadowstone · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:1231}, the hunter trainer at the smithy in {area:131}. The Hunter's Path from {npc:5116} in {zone:1455}, {npc:11807} north-west of {area:131} or {npc:5515} in {zone:1453} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "10级时，去找{area:131}铁匠铺里的猎人训练师{npc:1231}。{zone:1455}的{npc:5116}、{area:131}西北面的{npc:11807}或{zone:1453}的{npc:5515}给予的“猎人之道”也会指引你来这里，能额外获得少量经验；它只是引导任务。10级时人在艾尔文森林？{area:87}的{npc:251507}提供的任务链也教相同的技能。",
	-- {npc:1231} Grif Wildheart · {item:15908} Taming Rod
	["{npc:1231}: the first {item:15908}"] = "{npc:1231}：第一份{item:15908}",

	-- Step 7: Large Crag Boar
	-- {area:131} Kharanos · {item:15908} Taming Rod · {npc:1231} Grif Wildheart · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar
	["Large Crag Boars (level 6-7) root around the fields west, south and north-west of {area:131} and respawn every 3 minutes. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, being out of range or anyone else's help breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:1231}. The boars use {spell:6268} from 25 yards, so start with the rod, not {spell:75}. Keep each rod: it goes back to {npc:1231}."] = "大峭壁野猪（6-7级）在{area:131}以西、以南及西北面的田野里拱土，每3分钟刷新。驯兽棒的用法：选中一只活着的野兽，使用{item:15908}，在整个引导期间站着不动，任它攻击。移动、还手、超出距离或他人帮忙都会打断引导，并消耗本就不多的一次充能；若充能耗尽，销毁驯兽棒，放弃任务，再向{npc:1231}重新接受。野猪会从25码外使用{spell:6268}，所以要直接使用驯兽棒，不要先用{spell:75}。每根驯兽棒都要保留：需要交回{npc:1231}。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "对一头活着的野猪使用{item:15908}",

	-- Step 8: Snow Leopard
	-- {spell:2641} Dismiss Pet · {area:131} Kharanos
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Juvenile Snow Leopards = {npc:1199} Juvenile Snow Leopard
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Snow Leopards (level 7-8) prowl the slopes south-east of {area:131}, more north-west and west of it; the smaller Juvenile Snow Leopards do not count."] = "先解散野猪（右键点击宠物头像，选择{spell:2641}）：放出的练习宠物可能会攻击你。雪豹（7-8级）在{area:131}东南方的山坡上游荡，西北方和西侧也有；体型较小的雪豹幼崽不算数。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living leopard"] = "对活着的豹子使用 {item:15908}",

	-- Step 9: Ice Claw Bear
	-- {area:131} Kharanos · {area:77} Anvilmar · {spell:3130} Ice Claw
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Dismiss the leopard. Ice Claw Bears (level 7-8) roam the hills around {area:131}, many south-east of it and more north-west toward {area:77}; their {spell:3130} hits hard, so start at full health."] = "解散豹子。冰爪熊（7-8级）在{area:131}周围的山丘游荡，东南面很多，西北往{area:77}方向也有；它们的{spell:3130}伤害很高，满血再开始。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living bear"] = "对一只活熊使用 {item:15908}",

	-- Step 10: Belia Thundergranite in Ironforge
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455}"] = "{zone:1455}的{npc:10090}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms · {zone:1455} Ironforge · {object:32359} Military Ward
	["{npc:10090}, the pet trainer, stands in the {object:32390} in {zone:1455}'s {object:32359}, by the hunter trainers."] = "宠物训练师{npc:10090}站在{zone:1455}的{object:32359}内，位于{object:32390}，就在猎人训练师旁。",

	-- Step 11: Dazalar in Dolanaar
	-- {npc:3601} Dazalar · {area:186} Dolanaar
	["{npc:3601} in {area:186}"] = "{area:186}的{npc:3601}",
	-- {npc:3601} Dazalar · {area:186} Dolanaar · {npc:3596} Ayanna Everstride · {area:256} Aldrassil · {npc:4146} Jocaste · {zone:1457} Darnassus · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:3601}, the hunter trainer in {area:186}. The Hunter's Path from {npc:3596} at {area:256}, {npc:4146} in {zone:1457}, {npc:5515} in {zone:1453}, {npc:5116} in {zone:1455} or {npc:1231} in {area:131} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "10级时，去找{area:186}的猎人训练师{npc:3601}。{area:256}的{npc:3596}、{zone:1457}的{npc:4146}、{zone:1453}的{npc:5515}、{zone:1455}的{npc:5116}或{area:131}的{npc:1231}给予的“猎人之道”也会指引你来这里，能额外获得少量经验；它只是引导任务。10级时人在艾尔文森林？{area:87}的{npc:251507}提供的任务链也教相同的技能。",
	-- {npc:3601} Dazalar · {item:15908} Taming Rod
	["{npc:3601}: the first {item:15908}"] = "{npc:3601}：第一份{item:15908}",

	-- Step 12: Webwood Lurker
	-- {area:186} Dolanaar · {item:15908} Taming Rod · {spell:1265843} Web · {npc:3601} Dazalar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers (level 5-6) creep through the woods just north-east, south-west and east of {area:186}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, attacking it or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). Their {spell:1265843} roots you but does not break the channel if you keep still. Keep each rod: it goes back to {npc:3601}."] = "树林潜伏者（5—6级）在 {area:186} 东北、西南和东侧不远处的树林中出没。驯兽棒的用法：选中活着的野兽，使用 {item:15908}，在整个引导过程中站着不动，任它攻击你；移动、攻击它或其他人的协助都会打断引导，并消耗驯兽棒为数不多的使用次数（次数耗尽后：销毁驯兽棒，放弃任务再重新接受）。它们的 {spell:1265843} 会将你定身，但只要保持不动就不会打断引导。保留每根驯兽棒：需要交回给 {npc:3601}。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living spider"] = "对一只活蜘蛛使用 {item:15908}",

	-- Step 13: Nightsaber Stalker
	-- {spell:2641} Dismiss Pet · {area:259} Lake Al'Ameth · {area:186} Dolanaar
	-- plural, as words: Nightsaber Stalkers = {npc:2043} Nightsaber Stalker
	["Dismiss the spider first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Nightsaber Stalkers (level 7-8) lie on the hillside south of {area:259}, south of {area:186}; the plain Nightsabers by the village do not count."] = "先解散蜘蛛（右键点击宠物头像，选择{spell:2641}）：放出的练习宠物可能会攻击你。夜刃捕食者（7-8级）栖息在{area:259}南方、{area:186}南方的山坡上；村庄旁的普通夜刃豹不算数。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "对一只活着的捕食者使用{item:15908}",

	-- Step 14: Strigid Screecher
	-- {area:186} Dolanaar
	-- plural, as words: Strigid Screechers = {npc:1996} Strigid Screecher
	["Dismiss the cat. Strigid Screechers (level 7-8), owls, perch in the woods south, south-west and west of {area:186}."] = "解散猫科宠物。巨翼恶枭（7—8级）是猫头鹰，栖息在 {area:186} 南面、西南面和西面的树林里。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living owl"] = "对一只活着的猫头鹰使用{item:15908}",

	-- Step 15: Jocaste in Darnassus
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457}"] = "{zone:1457}的{npc:4146}",
	-- {area:186} Dolanaar · {zone:1457} Darnassus · {npc:4146} Jocaste · {area:1658} Cenarion Enclave
	["Take the road west from {area:186} to {zone:1457}. {npc:4146} stands inside the {area:1658} with the hunter trainers; Silvaria, the pet trainer, is up the ramp next to her."] = "沿道路从 {area:186} 向西前往 {zone:1457}。{npc:4146} 在 {area:1658} 内与猎人训练师站在一起；宠物训练师西尔瓦莉雅在她旁边的坡道上方。",

	-- Step 16: Josephine Carson in Goldshire
	-- {npc:251507} Josephine Carson · {area:87} Goldshire
	["{npc:251507} in {area:87}"] = "{area:87}的{npc:251507}",
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {npc:258930} Isaac Chan · {zone:2521} Zephras Isle
	["At 10 go to {npc:251507}, the hunter trainer who stands with the other trainers by the Lion's Pride Inn in {area:87}; {npc:258930}, the pet trainer, is beside her. Skyborne: this is for one who left {zone:2521} without taming; it teaches the same."] = "10级时去找 {npc:251507}，她是猎人训练师，与其他训练师一起站在 {area:87} 的狮王之傲旅店旁；宠物训练师 {npc:258930} 在她身边。天裔角色：这是为离开 {zone:2521} 时尚未学会驯服宠物的角色准备的，教授的内容相同。",
	-- {npc:251507} Josephine Carson · {item:15908} Taming Rod
	["{npc:251507}: the first {item:15908}"] = "{npc:251507}：第一份{item:15908}",

	-- Step 17: Rockhide Boar
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {item:15908} Taming Rod · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar
	["Rockhide Boars (level 7-8) graze in three herds south and south-east of {area:87}, toward the {area:64}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again. The boars use {spell:6268}, so start with the rod, not {spell:75}. Killing a boar does not count. Keep each rod: it goes back to Josephine. A Dwarf or Night Elf who took Josephine's rod instead of their home trainer's is led through {area:87} from here."] = "石皮野猪（7-8 级）分成三群，在 {area:87} 南侧和东南侧、靠近 {area:64} 的方向觅食。驯兽棒的用法：选中一只活着的野兽，使用 {item:15908}，在整个引导期间站着不动，任由它攻击你。移动、还击、接受他人治疗，或其他人攻击这只野兽，都会打断引导，并消耗驯兽棒为数不多的使用次数；次数耗尽后，摧毁驯兽棒、放弃任务，再重新接受。野猪会使用 {spell:6268}，因此先使用驯兽棒，不要先用 {spell:75}。击杀野猪不计入任务。每根驯兽棒都要留着，之后要交还给约瑟芬·卡森。若矮人或暗夜精灵领取的是约瑟芬·卡森的驯兽棒，而非本族训练师的，从这里起路线会引导其经过 {area:87}。",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "驯服{npc:524}",

	-- Step 18: Gray Forest Wolf
	-- {spell:2641} Dismiss Pet · {area:87} Goldshire · {area:18} Crystal Lake
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Gray Forest Wolves (level 7-8) run in the woods east of {area:87}, east of {area:18}."] = "先解散野猪（右键点击宠物头像，选择{spell:2641}）：放出的练习宠物可能会攻击你。森林灰狼（7-8级）在{area:87}东侧、{area:18}东侧的树林中活动。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living wolf"] = "对一只活着的狼使用 {item:15908}。",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "驯服{npc:1922}",

	-- Step 19: Young Forest Bear
	-- {area:87} Goldshire
	-- plural, as words: Young Forest Bears = {npc:822} Young Forest Bear
	["Dismiss the wolf. Young Forest Bears (level 8-9) roam the woods just south of {area:87}, with more south-west and south-east of town."] = "解散狼。森林熊幼崽（8-9 级）在 {area:87} 正南的树林里游荡，镇子西南和东南还有更多。",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "驯服{npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}，在她旁边：{spell:5149}",

	-- Step 20: Your first pet
	["Your first pet"] = "你的第一只宠物",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} 的用法与驯兽棒相同：目标必须是等级不高于你的野兽，引导期间不能移动，而野兽会一直攻击你。宠物在驯服后保留原有等级，并随你一起升级；它的等级永远不能超过你，因此尽量驯服等级接近自己的野兽。在无限服，每个宠物家族都有专属技能（例如野猪的冲锋）。练级时，猫科伤害最高（爪击和 {spell:17253}），野猪则更耐打。",
	["Tame a beast of your level to keep"] = "驯服一只与你同级的野兽，作为长期宠物。",
	-- {area:87} Goldshire · {zone:1436} Westfall
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Near {area:87} there are no cats: Prowlers (wolves, level 9-10) roam eastern Elwynn, Longsnouts (boars, 10-11) its far south-west by the {zone:1436} border; at 12-13, Young Goretusks (boars) graze the fields of northern {zone:1436}."] = "{area:87} 附近没有猫科野兽：森林狼（狼，9-10 级）在艾尔文森林东部游荡，长鼻野猪（野猪，10-11 级）位于其西南尽头、靠近 {zone:1436} 边界的地方；12-13 级的幼年血牙野猪则在 {zone:1436} 北部的田野觅食。",
	-- {area:131} Kharanos · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Scarred Crag Boars = {npc:1689} Scarred Crag Boar · Mountain Boars = {npc:1190} Mountain Boar
	["Near {area:131}: Snow Leopards (cats, level 7-8) prowl all over {zone:1426}, Scarred Crag Boars (9-10) its east toward {zone:1432}; at 10-11, Mountain Boars roam western {zone:1432}."] = "{area:131}附近：雪豹（猫科，7-8级）遍布{zone:1426}；有伤疤的峭壁野猪（9-10级）在东部、靠近{zone:1432}的方向；山猪为10-11级，在{zone:1432}西部活动。",
	-- {area:186} Dolanaar · {zone:1438} Teldrassil
	-- plural, as words: Elder Nightsabers = {npc:2033} Elder Nightsaber · Feral Nightsabers = {npc:2034} Feral Nightsaber
	["Near {area:186}: Elder Nightsabers (cats, level 8-9) and Feral Nightsabers (cats, 10-11) prowl the woods of north-western {zone:1438}."] = "{area:186} 附近：老夜刃豹（猫科，8—9级）和野生夜刃豹（猫科，10—11级）在 {zone:1438} 西北部的林中游荡。",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "{area:16638} 附近：瓦尔德伦头狼（10级）在 {area:16626} 觅食，它们就是你最后一次练习驯服的野兽；尖啸幼兽主母（迅猛龙，9级）在 {area:16638} 西侧筑巢；影风乌萨拉（熊，10—11级）在 {zone:2521} 北部游荡。",
	-- {spell:1584} Feed Pet · {area:87} Goldshire · {zone:1457} Darnassus · {zone:2521} Zephras Isle · {area:131} Kharanos · {area:186} Dolanaar
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Toddrick the butcher in {area:87}, Jaeana in {zone:1457} and the innkeepers on {zone:2521} sell meat; the innkeepers of {area:131} and {area:186} sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584}：打开法术书，施放{spell:1584}，再点击一种你的宠物所属家族能吃的食物（宠物的鼠标提示会列出食谱：猫科吃肉和鱼，野猪几乎什么都吃）。从野兽身上拾取的生肉也可以。购买地点：{area:87}的屠夫托德瑞克、{zone:1457}的加伊娜以及{zone:2521}的旅店老板出售肉类；{area:131}和{area:186}的旅店老板出售面包。等级接近宠物的食物提供的快乐值最多；等级低很多的食物大约只有一半效果。战斗中无法喂食。",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "快乐度：看宠物头像框上的表情。宠物不高兴时只造成正常伤害的四分之三，高兴时则额外造成四分之一伤害。快乐度会缓慢降低，宠物死亡后降得更快；宠物长期不高兴可能会逃跑。",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "忠诚度会随相处时间和击杀增长。每提升一级忠诚等级，都能增加可用于{spell:5149}的训练点数（宠物等级乘以“忠诚等级减一”）。",
	-- {spell:5149} Beast Training · {area:87} Goldshire · {npc:9980} Shelby Stoneflint · {area:131} Kharanos · {area:186} Dolanaar · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master (Erma in {area:87}, {npc:9980} in {area:131}, Seriadne in {area:186}, {npc:265756} on {zone:2521}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149}（法术书的综合页）可将你已掌握的技能教给当前宠物。学习新的技能或等级时：先将宠物存放在兽栏管理员处（{area:87}的旅店老板艾玛、{area:131}的{npc:9980}、{area:186}的瑟里亚迪、{zone:2521}的{npc:265756}），再驯服一只拥有该技能的野兽（其宠物法术书页会显示已掌握的技能），在战斗中使用该技能，直到游戏提示你已经学会，然后领回自己的宠物，用{spell:5149}教给它。一只宠物最多拥有四个主动技能。",
	-- {spell:1853} Growl · {npc:258930} Isaac Chan · {area:87} Goldshire · {npc:2879} Karrina Mekenda · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:2878} Peria Lamenur · {area:131} Kharanos · {npc:10090} Belia Thundergranite · {zone:1455} Ironforge · {object:32390} Hall of Arms · {area:186} Dolanaar · {zone:1457} Darnassus · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar
	["Pet trainers sell {spell:1853} ranks and resistances. Alliance: {npc:258930} in {area:87}, {npc:2879} by the hunter trainers in {zone:1453}'s {object:28027}, {npc:2878} in {area:131}, {npc:10090} in {zone:1455}'s {object:32390}, Keldas in {area:186}, Silvaria in {zone:1457}' Cenarion Enclave, {npc:254411} in {area:16638}."] = "宠物训练师出售各等级的{spell:1853}及抗性技能。联盟：{area:87}的{npc:258930}、{zone:1453}的{object:28027}中猎人训练师旁的{npc:2879}、{area:131}的{npc:2878}、{zone:1455}的{object:32390}中的{npc:10090}、{area:186}的凯尔达斯、{zone:1457}塞纳里奥区的西尔瓦莉雅，以及{area:16638}的{npc:254411}。",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "现在你的法术书中已有 {spell:883}、{spell:2641} 和 {spell:982}；到12级时，可以找训练师学习 {spell:136}。宠物死亡后需要用 {spell:982}；离你超过约100码时，宠物会被解散，可用 {spell:883} 再次召回。",
}
