-- Chinese (traditional) (zhTW): the guide forever/class/hunter/taming-the-beast-alliance (forever/class/hunter/taming-the-beast-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6063} Taming the Beast
	["{quest:6063} (Alliance)"] = "{quest:6063}（聯盟）",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "10級獲得自己的寵物：用{item:15908}完成三次馴服練習，學會{spell:1515}，然後學會{spell:5149}。",

	-- Step 1: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "10級時，{zone:2521}上的獵人訓練師{npc:254084}可能會用{quest:94007}派你前往{area:16638}。這只是指路任務：如果你已經在{area:16638}，就跳過它。",

	-- Step 2: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{npc:252389}，在{area:16638}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389}和訓練師們一起站在{area:16638}西門旁，{npc:254411}就在她身邊。",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389}：第一根{item:15908}",

	-- Step 3: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod · {npc:252389} Quel'ana Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges. Killing one does not count. Keep each rod: it goes back to {npc:252389}."] = "鳴風爬行者只生活在有水的地方：最近的一群在{area:16638}西南面的岸邊，混在螃蟹之間。魔杖用法：選中一隻活著的爬行者，使用{item:15908}，在整個引導期間站著不動、任由它攻擊你；移動、還手或他人幫忙都會中斷，並消耗魔杖少量充能之一。殺死它不算數。每根魔杖都留著：要還給{npc:252389}。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "對活著的爬行者使用{item:15908}",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "馴服{npc:254588}",

	-- Step 4: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "先解散爬行者（右鍵點選寵物頭像，{spell:2641}）。暴躁風行者（Ornery Galestrider）在{area:16626}吃草，那片田野就在{area:16638}西面和西南面不遠處。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "對活著的風行者使用{item:15908}",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "馴服{npc:251707}",

	-- Step 5: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "解散風行者。鷲龍首領在同一片{area:16626}狩獵，位置稍偏南。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "對活著的首領使用{item:15908}",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "馴服{npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "她身邊的{npc:254411}：{spell:5149}",

	-- Step 6: Grif Wildheart in Kharanos
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos
	["{npc:1231} in {area:131}"] = "{npc:1231}，在{area:131}",
	-- {npc:1231} Grif Wildheart · {area:131} Kharanos · {quest:6074} The Hunter's Path · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:11807} Tristane Shadowstone · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:1231}, the hunter trainer at the smithy in {area:131}. {quest:6074} from {npc:5116} in {zone:1455}, {npc:11807} north-west of {area:131} or {npc:5515} in {zone:1453} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "",
	-- {npc:1231} Grif Wildheart · {item:15908} Taming Rod
	["{npc:1231}: the first {item:15908}"] = "{npc:1231}：第一根{item:15908}",

	-- Step 7: Large Crag Boar
	-- {area:131} Kharanos · {item:15908} Taming Rod · {npc:1231} Grif Wildheart · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar
	["Large Crag Boars (level 6-7) root around the fields west, south and north-west of {area:131} and respawn every 3 minutes. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, being out of range or anyone else's help breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:1231}. The boars use {spell:6268} from 25 yards, so start with the rod, not {spell:75}. Keep each rod: it goes back to {npc:1231}."] = "大型峭壁野豬（6-7級）在{area:131}以西、以南和西北的田野裡拱土，每3分鐘重新出現。魔杖用法：選中一隻活著的野獸，使用{item:15908}，在整個引導期間站著不動、任由它攻擊你。移動、還手、超出範圍或他人幫忙都會中斷，並消耗魔杖少量充能之一；若充能耗盡，就摧毀魔杖、放棄任務並回去找{npc:1231}再接。野豬會從25碼外使用{spell:6268}，所以先用魔杖，別用{spell:75}。每根魔杖都留著：要還給{npc:1231}。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "對活著的野豬使用{item:15908}",

	-- Step 8: Snow Leopard
	-- {spell:2641} Dismiss Pet · {area:131} Kharanos
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Juvenile Snow Leopards = {npc:1199} Juvenile Snow Leopard
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Snow Leopards (level 7-8) prowl the slopes south-east of {area:131}, more north-west and west of it; the smaller Juvenile Snow Leopards do not count."] = "先解散野豬（右鍵點選寵物頭像，{spell:2641}）：放生的練習寵物可能會反咬你。雪豹（7-8級）在{area:131}東南的山坡徘徊，西北和西邊也有更多；體型較小的幼年雪豹不算。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living leopard"] = "對活著的豹使用{item:15908}",

	-- Step 9: Ice Claw Bear
	-- {area:131} Kharanos · {area:77} Anvilmar · {spell:3130} Ice Claw
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Dismiss the leopard. Ice Claw Bears (level 7-8) roam the hills around {area:131}, many south-east of it and more north-west toward {area:77}; their {spell:3130} hits hard, so start at full health."] = "解散豹。冰爪熊（7-8級）在{area:131}周圍的山丘遊蕩，很多在東南，西北靠{area:77}方向更多；它們的{spell:3130}很疼，所以滿血開始。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living bear"] = "對活著的熊使用{item:15908}",

	-- Step 10: Belia Thundergranite in Ironforge
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455}"] = "{npc:10090}，在{zone:1455}",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms · {zone:1455} Ironforge · {object:32359} Military Ward
	["{npc:10090}, the pet trainer, stands in the {object:32390} in {zone:1455}'s {object:32359}, by the hunter trainers."] = "{npc:10090}，寵物訓練師，站在{zone:1455}的{object:32359}裡的{object:32390}內，就在獵人訓練師旁。",

	-- Step 11: Dazalar in Dolanaar
	-- {npc:3601} Dazalar · {area:186} Dolanaar
	["{npc:3601} in {area:186}"] = "{npc:3601}，在{area:186}",
	-- {npc:3601} Dazalar · {area:186} Dolanaar · {quest:6071} The Hunter's Path · {npc:3596} Ayanna Everstride · {area:256} Aldrassil · {npc:4146} Jocaste · {zone:1457} Darnassus · {npc:5515} Einris Brightspear · {zone:1453} Stormwind · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {npc:1231} Grif Wildheart · {area:131} Kharanos · {npc:251507} Josephine Carson · {area:87} Goldshire
	["At 10 go to {npc:3601}, the hunter trainer in {area:186}. {quest:6071} from {npc:3596} at {area:256}, {npc:4146} in {zone:1457}, {npc:5515} in {zone:1453}, {npc:5116} in {zone:1455} or {npc:1231} in {area:131} also leads here, for a little experience; it is only a pointer. In Elwynn at 10 instead? {npc:251507}'s chain in {area:87} teaches the same."] = "",
	-- {npc:3601} Dazalar · {item:15908} Taming Rod
	["{npc:3601}: the first {item:15908}"] = "{npc:3601}：第一根{item:15908}",

	-- Step 12: Webwood Lurker
	-- {area:186} Dolanaar · {item:15908} Taming Rod · {spell:1265843} Web · {npc:3601} Dazalar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers (level 5-6) creep through the woods just north-east, south-west and east of {area:186}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, attacking it or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). Their {spell:1265843} roots you but does not break the channel if you keep still. Keep each rod: it goes back to {npc:3601}."] = "蛛網潛伏者（5-6級）在{area:186}東北、西南和東邊的樹林裡爬行。魔杖用法：選中一隻活著的野獸，使用{item:15908}，在整個引導期間站著不動、任由它攻擊你；移動、攻擊它或他人幫忙都會中斷，並消耗魔杖少量充能之一（充能耗盡：摧毀魔杖，放棄任務，再接一次）。它們的{spell:1265843}會定住你，但只要你保持不動就不會打斷引導。每根魔杖都留著：要還給{npc:3601}。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living spider"] = "對活著的蜘蛛使用{item:15908}",

	-- Step 13: Nightsaber Stalker
	-- {spell:2641} Dismiss Pet · {area:259} Lake Al'Ameth · {area:186} Dolanaar
	-- plural, as words: Nightsaber Stalkers = {npc:2043} Nightsaber Stalker
	["Dismiss the spider first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Nightsaber Stalkers (level 7-8) lie on the hillside south of {area:259}, south of {area:186}; the plain Nightsabers by the village do not count."] = "先解散蜘蛛（右鍵點選寵物頭像，{spell:2641}）：放生的練習寵物可能會反咬你。夜刃豹盜賊（7-8級）在{area:259}以南、{area:186}以南的山坡上；村子旁的普通夜刃豹不算。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "對活著的潛伏者使用{item:15908}",

	-- Step 14: Strigid Screecher
	-- {area:186} Dolanaar
	-- plural, as words: Strigid Screechers = {npc:1996} Strigid Screecher
	["Dismiss the cat. Strigid Screechers (level 7-8), owls, perch in the woods south, south-west and west of {area:186}."] = "解散貓。夜梟尖嘯者（7-8級，屬貓頭鷹）棲息在{area:186}以南、西南和西邊的樹林。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living owl"] = "對活著的貓頭鷹使用{item:15908}",

	-- Step 15: Jocaste in Darnassus
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457}"] = "{npc:4146}，在{zone:1457}",
	-- {area:186} Dolanaar · {zone:1457} Darnassus · {npc:4146} Jocaste · {area:1658} Cenarion Enclave
	["Take the road west from {area:186} to {zone:1457}. {npc:4146} stands inside the {area:1658} with the hunter trainers; Silvaria, the pet trainer, is up the ramp next to her."] = "從{area:186}沿路向西到{zone:1457}。{npc:4146}和獵人訓練師們站在{area:1658}內；寵物訓練師西爾瓦里婭在她旁邊、坡道上方。",

	-- Step 16: Josephine Carson in Goldshire
	-- {npc:251507} Josephine Carson · {area:87} Goldshire
	["{npc:251507} in {area:87}"] = "{npc:251507}，在{area:87}",
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {npc:258930} Isaac Chan · {zone:2521} Zephras Isle
	["At 10 go to {npc:251507}, the hunter trainer who stands with the other trainers by the Lion's Pride Inn in {area:87}; {npc:258930}, the pet trainer, is beside her. Skyborne: this is for one who left {zone:2521} without taming; it teaches the same."] = "10級時去找{npc:251507}，她和其它訓練師一起站在{area:87}的獅王之傲旅店旁；寵物訓練師{npc:258930}就在她身邊。天裔：這是給沒在{zone:2521}完成馴服就離開的人準備的；教的內容一樣。",
	-- {npc:251507} Josephine Carson · {item:15908} Taming Rod
	["{npc:251507}: the first {item:15908}"] = "{npc:251507}：第一根{item:15908}",

	-- Step 17: Rockhide Boar
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {item:15908} Taming Rod · {spell:6268} Rushing Charge · {spell:75} Auto Shot
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar
	["Rockhide Boars (level 7-8) graze in three herds south and south-east of {area:87}, toward the {area:64}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again. The boars use {spell:6268}, so start with the rod, not {spell:75}. Killing a boar does not count. Keep each rod: it goes back to Josephine. A Dwarf or Night Elf who took Josephine's rod instead of their home trainer's is led through {area:87} from here."] = "石皮野豬（7-8級）在{area:87}以南和東南、靠{area:64}方向分三群吃草。魔杖用法：選中一隻活著的野獸，使用{item:15908}，在整個引導期間站著不動、任由它攻擊你。移動、還手、他人治療或任何人攻擊該野獸都會中斷，並消耗魔杖少量充能之一；若充能耗盡，就摧毀魔杖、放棄任務並再接一次。野豬會使用{spell:6268}，所以先用魔杖，別用{spell:75}。殺死野豬不算數。每根魔杖都留著：要還給約瑟芬。矮人或夜精靈拿了約瑟芬的魔杖而不是家鄉訓練師的，會從這裡被引導走完{area:87}。",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "馴服{npc:524}",

	-- Step 18: Gray Forest Wolf
	-- {spell:2641} Dismiss Pet · {area:87} Goldshire · {area:18} Crystal Lake
	["Dismiss the boar first (right-click the pet portrait, {spell:2641}): a released practice pet can turn on you. Gray Forest Wolves (level 7-8) run in the woods east of {area:87}, east of {area:18}."] = "先解散野豬（右鍵點選寵物頭像，{spell:2641}）：放生的練習寵物可能會反咬你。灰森林狼（7-8級）在{area:87}以東、{area:18}以東的樹林裡奔跑。",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living wolf"] = "對活著的狼使用{item:15908}",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "馴服{npc:1922}",

	-- Step 19: Young Forest Bear
	-- {area:87} Goldshire
	-- plural, as words: Young Forest Bears = {npc:822} Young Forest Bear
	["Dismiss the wolf. Young Forest Bears (level 8-9) roam the woods just south of {area:87}, with more south-west and south-east of town."] = "解散狼。幼森林熊（8-9級）在{area:87}正南的樹林裡遊蕩，鎮子西南和東南也有更多。",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "馴服{npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}，在她旁邊：{spell:5149}",

	-- Step 20: Your first pet
	["Your first pet"] = "你的第一隻寵物",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515}的用法和魔杖一樣：目標須是與你同級或更低階的野獸，引導期間不能移動，野獸會一直攻擊你。寵物會保持你馴服它時的等級，並隨你一起升級；它永遠不會高於你的等級，所以抓一隻等級接近你的。在Forever上每個科系都有自己的技能（比如野豬的衝鋒）。練級時，貓科傷害最高（爪擊與{spell:17253}），野豬則更耐打。",
	["Tame a beast of your level to keep"] = "馴服一隻與你等級相當的野獸作為永久寵物",
	-- {area:87} Goldshire · {zone:1436} Westfall
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Near {area:87} there are no cats: Prowlers (wolves, level 9-10) roam eastern Elwynn, Longsnouts (boars, 10-11) its far south-west by the {zone:1436} border; at 12-13, Young Goretusks (boars) graze the fields of northern {zone:1436}."] = "{area:87}附近沒有貓科：徘徊者（狼，9-10級）在艾爾文森林東部遊蕩，長鼻野豬（野豬，10-11級）在最西南靠{zone:1436}邊界一帶；12-13級時，幼年血牙野豬（野豬）在{zone:1436}北部的田野吃草。",
	-- {area:131} Kharanos · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Scarred Crag Boars = {npc:1689} Scarred Crag Boar · Mountain Boars = {npc:1190} Mountain Boar
	["Near {area:131}: Snow Leopards (cats, level 7-8) prowl all over {zone:1426}, Scarred Crag Boars (9-10) its east toward {zone:1432}; at 10-11, Mountain Boars roam western {zone:1432}."] = "{area:131}附近：雪豹（貓科，7-8級）在{zone:1426}四處徘徊，傷痕峭壁野豬（9-10級）在其東部靠{zone:1432}方向；10-11級時，山地野豬在{zone:1432}西部遊蕩。",
	-- {area:186} Dolanaar · {zone:1438} Teldrassil
	-- plural, as words: Elder Nightsabers = {npc:2033} Elder Nightsaber · Feral Nightsabers = {npc:2034} Feral Nightsaber
	["Near {area:186}: Elder Nightsabers (cats, level 8-9) and Feral Nightsabers (cats, 10-11) prowl the woods of north-western {zone:1438}."] = "{area:186}附近：老年夜刃豹（貓科，8-9級）和野性夜刃豹（貓科，10-11級）在{zone:1438}西北部的樹林裡徘徊。",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "{area:16638}附近：鷲龍首領（10級，也就是你最後一次練習馴服的野獸）在{area:16626}狩獵；尖嘯迅猛龍族長（迅猛龍，9級）在{area:16638}以西築巢；暗風烏瑟拉斯（熊，10-11級）在{zone:2521}北部遊蕩。",
	-- {spell:1584} Feed Pet · {area:87} Goldshire · {zone:1457} Darnassus · {zone:2521} Zephras Isle · {area:131} Kharanos · {area:186} Dolanaar
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Toddrick the butcher in {area:87}, Jaeana in {zone:1457} and the innkeepers on {zone:2521} sell meat; the innkeepers of {area:131} and {area:186} sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584}：開啟法術書，施放{spell:1584}，然後點選一份你寵物科系會吃的食物（寵物提示裡會列出：貓科吃肉和魚，野豬幾乎什麼都吃）。從野獸身上拾取的生肉也算。購買：{area:87}的屠夫託德里克、{zone:1457}的賈安娜和{zone:2521}上的旅店老闆賣肉；{area:131}和{area:186}的旅店老闆賣麵包。食物等級接近寵物等級時它最快樂；食物低太多隻能得到大約一半效果。戰鬥中不能餵食。",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "快樂值：寵物框上的表情。不快樂的寵物只能造成四分之三的傷害，快樂的則多四分之一。快樂值會緩慢下降，寵物死亡時下降更快；寵物不快樂太久可能會跑掉。",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "忠誠度隨時間與擊殺增長。每提升一級忠誠度都會提高你在{spell:5149}中可用的訓練點數（寵物等級乘以忠誠等級再減一）。",
	-- {spell:5149} Beast Training · {area:87} Goldshire · {npc:9980} Shelby Stoneflint · {area:131} Kharanos · {area:186} Dolanaar · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master (Erma in {area:87}, {npc:9980} in {area:131}, Seriadne in {area:186}, {npc:265756} on {zone:2521}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149}（法術書，通用頁）會把你已學會的技能教給當前寵物。要學新技能或更高等級：把寵物寄放在獸欄管理員處（{area:87}的厄瑪、{area:131}的{npc:9980}、{area:186}的塞麗亞德妮、{zone:2521}上的{npc:265756}），馴服一隻擁有該技能的野獸（它的寵物法術書頁會顯示它會什麼），在戰鬥中反覆使用該技能直到遊戲提示你已學會，然後接回自己的寵物並用{spell:5149}教它。寵物最多同時擁有四個主動技能。",
	-- {spell:1853} Growl · {npc:258930} Isaac Chan · {area:87} Goldshire · {npc:2879} Karrina Mekenda · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:2878} Peria Lamenur · {area:131} Kharanos · {npc:10090} Belia Thundergranite · {zone:1455} Ironforge · {object:32390} Hall of Arms · {area:186} Dolanaar · {zone:1457} Darnassus · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar
	["Pet trainers sell {spell:1853} ranks and resistances. Alliance: {npc:258930} in {area:87}, {npc:2879} by the hunter trainers in {zone:1453}'s {object:28027}, {npc:2878} in {area:131}, {npc:10090} in {zone:1455}'s {object:32390}, Keldas in {area:186}, Silvaria in {zone:1457}' Cenarion Enclave, {npc:254411} in {area:16638}."] = "寵物訓練師出售{spell:1853}的各級和抗性。聯盟：{area:87}的{npc:258930}、{zone:1453}的{object:28027}裡獵人訓練師旁的{npc:2879}、{area:131}的{npc:2878}、{zone:1455}的{object:32390}裡的{npc:10090}、{area:186}的凱爾達斯、{zone:1457}塞納里奧區的西爾瓦里婭、{area:16638}的{npc:254411}。",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "{spell:883}、{spell:2641}和{spell:982}現在已在你的法術書裡；{spell:136}會在12級時由訓練師教你。死掉的寵物需要{spell:982}；離你超過約100碼的寵物會被解散，用{spell:883}召回。",
}
