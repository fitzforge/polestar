-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 4: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 6: Riding at 40
	["Riding at 40"] = "40級騎術",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}，騎術訓練師",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "狼：{npc:3362}，在{npc:4752}旁邊。",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "",

	-- Step 8: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "騎術訓練師{npc:7953}",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "迅猛龍：祖尼爾，在{area:367}的{npc:7953}旁邊。",

	-- Step 9: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 11: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "",

	-- Step 13: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，騎術訓練師",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "科多獸：{npc:3685}，在{area:222}的{npc:3690}旁邊。",

	-- Step 14: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "飛往{area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 16: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "前往{area:392}學地獄戰馬",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "",

	-- Step 17: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 20: Mirage Raceway
	-- {area:484} Freewind Post · {zone:1446} Tanaris · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["The road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "",

	-- Step 21: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976}是剛過{zone:1446}邊界、有圍牆的哥布林城鎮。",

	-- Step 23: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",
	["water pouches in your bags"] = "背包裡的水袋",

	-- Step 25: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "向東北騎往海岸上的哥布林港口。",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "",

	-- Step 26: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "",
	["Upstairs"] = "",

	-- Step 27: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 28: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "",
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "給{area:35}，約50級時",

	-- Step 30: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 32: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}：給{zone:1454}，約45級時",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- Step 33: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "在豺狼人北邊，巨魔佔據山頂的前哨站；把巨魔法師拉過來打。鈷礦在前哨站周圍的土堆裡，卷軸就在前哨站裡的地上。",

	-- Step 34: Woodpaw north camp
	["Woodpaw north camp"] = "木爪北方營地",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "",

	-- Step 35: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}：從現在起一小時內",

	-- Step 36: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "",

	-- Step 38: Grimtotem camp
	["Grimtotem camp"] = "恐怖圖騰營地",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "恐怖圖騰牛頭人在小精龍的樹林旁紮營；恐怖圖騰襲擊者、博學者和薩滿都帶著角。",

	-- Step 39: Woodpaw battle map
	["Woodpaw battle map"] = "木爪戰鬥地圖",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "戰鬥地圖在莫沙徹營地南邊的木爪營地裡。",

	-- Step 40: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "給{zone:1454}，約45級時",

	-- Step 41: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "祖卡什蟲巢鑽進營地東南方的山丘裡；{quest:7731}在最深處的洞室等著。",

	-- Step 42: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "",

	-- Step 43: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "",

	-- Step 44: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "",

	-- Step 45: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "",

	-- Step 46: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 47: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {object:172960} Cleft of Shadow · {object:172961} Valley of Spirits
	["Fly to {zone:1454}. The Droffers brothers run their shop in the Drag.\n{object:172958}, then the {object:172960} and the {object:172961}."] = "",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "給{zone:1425}，約48級時",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Eastern Wastewander camps"] = "東部廢土營地",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "飛往{area:1637}。杜佛斯兄弟在城裡開店。",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "飛往{area:484}，搭崗哨東邊的升降梯下去，穿過鹽灘，再向南進入{zone:1446}。",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "飛往{area:484}，然後向西騎過峽谷經過{area:2237}；道路爬升進入{zone:1444}的叢林，一路通往{area:1099}。",
	-- ["Fly to {area:75}"] = "飛往{area:75}",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "逐風者：{npc:265756}，在微風島的{area:16638}。",
	-- ["Hearth to {area:1099}"] = "使用爐石前往{area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "繼續向西騎到海岸。海灘上的海灘龍蝦人先知和海灘利爪龍蝦人大約每擊殺四十隻會掉落一個OOX-22/FE定位器：如果掉了，使用它開始任務。",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "只有在你有定位器時：機器人在{area:1105}北側的小洞穴裡。護送它到{area:1108}的碼頭；途中雪人和猩猩會伏擊你。它的獎勵在{area:35}等你稍後去領。",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "從{area:1978}向西北騎回{area:75}，飛往{object:3202}。",
	-- ["Ride back west to {area:976}."] = "向西騎回{area:976}。",
	-- ["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "向西南騎往{area:1105}下方的巨魔遺跡。裡面滿是戈杜尼薩滿、術士和虐待者；南端的戈杜尼大法師帶著寶珠。",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "向西騎進{zone:1444}中部。擊殺一隻{npc:5308}，對牠的屍體使用{item:10699}，並擊殺升起的靈魂。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "騎術需要40級，費用100金；學會後會得到一匹坐騎。在經典版中，每個種族都向自己種族的訓練師學習：你的訓練師是{area:222}的{npc:3690}，{npc:3685}的科多獸（每隻20金）就在他旁邊。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）：先試試{zone:1454}{object:172958}的{npc:4752}，因為他最近；如果他能教你，就跳過此步驟。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "騎術需要40級，費用100金；學會後會得到一匹坐騎。在經典版中，每個種族都向自己種族的訓練師學習：你的訓練師是{area:159}的{npc:4773}，{npc:4731}的骸骨戰馬（每匹20金）就在她旁邊。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）：先試試{zone:1454}{object:172958}的{npc:4752}，因為他最近；如果他能教你，就跳過此步驟。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "騎術需要40級，費用100金；學會後會得到一匹坐騎。在經典版中，每個種族都向自己種族的訓練師學習：你的訓練師是{zone:1411}海岸{area:367}的{npc:7953}，祖尼爾的迅猛龍（每隻20金）就在他旁邊。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）：先試試{zone:1454}{object:172958}的{npc:4752}，因為他最近；如果他能教你，就跳過此步驟。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "騎術需要40級，費用100金；學會後會得到一匹坐騎。{npc:4752}在{object:172958}教導獸人，位於{npc:3362}的狼舍旁；目前沒有已知的天裔精靈騎術訓練師，所以天裔精靈也試試{npc:4752}。你種族的其他坐騎每匹20金：收藏品的「坐騎 · 40級」每一匹都有指南。",
	-- ["Rogue Vale screechers"] = "遊蕩的山谷尖嘯者",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骸骨戰馬：{npc:4731}，在{area:159}的{npc:4773}旁邊。",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "沿著海岸往南，南海海盜佔據著海灣。{npc:7883}和被偷的貨物在海灣盡頭的碼頭上。任何海盜都可能掉落帽子，南海綁匪最常掉。",
	-- ["Southern Gordunni ruins"] = "南部戈杜尼遺跡",
	-- ["Southern Wastewander camps"] = "南部廢土營地",
	-- ["Sprite darters and Woodpaw alphas"] = "小精龍與木爪突擊隊員",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "木爪豺狼人在莫沙徹營地西北方的山丘上紮營；他們每一個都可能掉落鬃毛。",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "強盜和竊賊在{area:976}東邊的沙丘上紮營。每個廢土敵人都可能帶著水袋：保留十個，魯葛蘭克的兩個懸賞各五個。",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "暗法師、遊蕩者和刺客在{area:976}東南方紮營。",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "小精龍在莫沙徹營地西邊的樹林上空飛舞；幾乎每一隻都會掉落翅膀。木爪突擊隊員帶領著西南方的營地：在一小時內殺掉他們。",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "前往{object:3202}的飛艇從{zone:1454}正門東北方不遠處的塔出發。",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "前往{zone:1454}的飛艇從{object:3202}旁的塔出發；它降落在{zone:1454}正門外不遠處。",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "飛行管理員塞斯塔就站在飛艇塔東邊。飛往{area:75}：下一份指南從那裡開始。",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "你的訓練師在{area:1638}：{npc:3033}（德魯伊）在{area:1639}，{npc:246344}（聖騎士）。從{zone:1454}飛過去，然後再飛往{area:484}。",
	-- ["Zeppelin to {object:3202}"] = "搭飛艇前往{object:3202}",
	-- ["Zeppelin tower"] = "飛艇塔",
	-- ["the {object:150075} in the square"] = "廣場上的{object:150075}",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976}是剛過{area:440}邊界、有圍牆的哥布林城鎮。",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}，騎術訓練師",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}，騎術訓練師",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}：尖嘯者住在{zone:1444}",
}
