-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	["Stonard flight master"] = "",

	-- Step 3: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 6: Riding at 40
	["Riding at 40"] = "40级学骑术",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the Fairweather Stables in Valanaar on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of Skywatcher Plateau, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}，骑术训练师",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "狼：{npc:3362}，在{npc:4752}旁边。",
	-- {npc:265756} Genn Fairweather
	["Riding and Galestriders: {npc:265756}, at the Fairweather Stables in Valanaar on Zephras Isle."] = "",

	-- Step 8: Riding at 40
	-- {npc:7953} Xar'Ti · {object:3276} Sen'jin Village (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {object:3276}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}，骑术训练师",
	-- {npc:7953} Xar'Ti · {object:3276} Sen'jin Village (no name in this language: may be words)
	["Raptors: Zjolnir, beside {npc:7953} in {object:3276}."] = "",

	-- Step 9: Fly to Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Fly to {zone:1456}"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 11: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {object:50507}, {npc:246344} (Paladins)."] = "",

	-- Step 13: Riding at 40
	-- {npc:3690} Kar Stormsinger · {object:2968} Bloodhoof Village (no name in this language: may be words) · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {object:2968}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，骑术训练师",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {object:2968} Bloodhoof Village (no name in this language: may be words)
	["Kodos: {npc:3685}, beside {npc:3690} in {object:2968}."] = "",

	-- Step 14: Fly to Freewind Post
	-- {object:19840} Freewind Post (no name in this language: may be words)
	["Fly to {object:19840}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 16: Ratchet for the Felsteed
	["Ratchet for the Felsteed"] = "",
	-- {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to Ratchet; {npc:6251} stands on the hill above the docks."] = "",

	-- Step 17: Fly to Freewind Post
	["Ratchet flight master"] = "",

	-- Step 21: Gadgetzan
	["Gadgetzan"] = "",
	-- {zone:1446} Tanaris
	["Gadgetzan is the walled goblin town just past the {zone:1446} border."] = "",

	-- Step 22: Noonshade Ruins: kill these as you meet them
	["Noonshade Ruins: kill these as you meet them"] = "",
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of Gadgetzan. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",
	["water pouches in your bags"] = "背包里的废土水袋",

	-- Step 24: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "向东北骑往海岸边的地精港口。",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",

	-- Step 25: Lost Rigger Cove: kill these as you meet them
	["Lost Rigger Cove: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "",
	["Upstairs"] = "",

	-- Step 26: Waterspring Field: kill these as you meet them
	["Waterspring Field: kill these as you meet them"] = "",
	-- {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of Gadgetzan.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 27: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what Lost Rigger Cove gave you. Gadgetzan is west of it."] = "",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["for {object:3204}, around level 50"] = "",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "",

	-- Step 29: Fly to Freewind Post
	["Gadgetzan flight master"] = "",

	-- Step 31: Camp Mojache
	-- {npc:7777} Rok Orhan · {object:176945} Camp Mojache (no name in this language: may be words)
	["{npc:7777} walks around {object:176945}: look inside the circle on the map"] = "",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}：交给{zone:1454}，大约45级时",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- Step 32: Gordunni Outpost
	["Gordunni Outpost"] = "",
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "在豺狼人北边，食人魔占据着一座山顶前哨站；把食人魔法师引到你身边来打。戈杜尼钴矿石在前哨站周围的土堆里，戈杜尼卷轴就在前哨站里的地上。",

	-- Step 33: Woodpaw north camp
	["Woodpaw north camp"] = "木爪北营地",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "",

	-- Step 34: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}：从现在起一小时内",

	-- Step 35: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "",

	-- Step 37: Grimtotem camp
	["Grimtotem camp"] = "恐怖图腾营地",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "恐怖图腾牛头人在小精龙的树林旁扎营；恐怖图腾袭击者、恐怖图腾博学者和恐怖图腾萨满祭司都携带恐怖图腾之角。",

	-- Step 38: Woodpaw battle map
	["Woodpaw battle map"] = "木爪作战地图",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "木爪作战地图在莫沙彻营地南边的木爪营地里。",

	-- Step 39: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "交给{zone:1454}，大约45级时",

	-- Step 40: The Writhing Deep
	["The Writhing Deep"] = "",
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "祖卡什异种蝎的巢穴深入营地东南的山丘；{quest:7731}在最深处的洞室里等候。",

	-- Step 41: Ruins of Isildien: kill these as you meet them
	["Ruins of Isildien: kill these as you meet them"] = "",
	["Ride west from the hive to the ogre ruins below Feral Scar Vale. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "",
	-- {npc:5234} Gordunni Mauler
	["{npc:5234} walks around Ruins of Isildien: look inside the circle on the map"] = "",

	-- Step 42: Feral Scar Vale yetis
	["Feral Scar Vale yetis"] = "",
	["North-west of the ruins, the yetis den in Feral Scar Vale; every yeti there can drop a thick hide."] = "",

	-- Step 43: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {object:3204} Booty Bay (no name in this language: may be words)
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of Feral Scar Vale, just north-west of the ruins. Escort it to the dock on the Forgotten Coast; yetis and gorillas ambush you on the way. Its reward waits in {object:3204} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "",

	-- Step 44: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "",

	-- Step 45: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",
	-- {object:176945} Camp Mojache (no name in this language: may be words)
	["{object:176945} flight master"] = "",

	-- Step 46: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {object:172960} Cleft of Shadow · {object:172961} Valley of Spirits
	["Fly to {zone:1454}. The Droffers brothers run their shop in the Drag.\n{object:172958}, then the {object:172960} and the {object:172961}."] = "",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "交给{zone:1425}，大约48级时",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Eastern Wastewander camps"] = "东部废土营地",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "飞往{area:1637}。杜佛斯兄弟在暗巷区经营他们的商店。",
	-- ["Fly to {area:484}"] = "飞往{area:484}",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "飞往{area:484}，乘哨站东边的升降梯下去，穿过盐滩，然后向南进入{zone:1446}。",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "飞往{area:484}，然后向西穿过峡谷经过{area:2237}；道路向上进入{zone:1444}的丛林，一直通往{area:1099}。",
	-- ["Fly to {area:75}"] = "飞往{area:75}",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "疾风陆行鸟：{npc:265756}，在泽风岛的{area:16638}。",
	-- ["Hearth to {area:1099}"] = "用炉石回到{area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "继续向西骑到海岸。海滩上的海滩龙虾人先知和海滩利爪龙虾人大约每杀四十只掉落一个OOX-22/FE定位器：如果掉了，就使用它开始任务。",
	-- ["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "科多兽：{npc:3685}，在{area:222}的{npc:3690}旁边。",
	-- ["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "在废墟西北，雪人栖息在{area:1105}；那里的每只雪人都可能掉落厚雪人皮。",
	-- ["Only with the distress beacon: any beast, gnoll or ogre in {area:357} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "仅当你有定位器时：{area:357}的任何野兽、豺狼人或食人魔都可能掉落它，大约每杀一百只掉一个；使用它开始任务。机器人在{area:1105}北侧的一个小山洞里，就在废墟西北不远。护送它到{area:1108}的码头；途中会有雪人和猩猩伏击你。它的奖励在{area:35}，留到之后再去领取。\n小心：护送过程中会出现三次伏击，机器人每次都会提前警告你。第一次是3只雪人，就在机器人离开山洞、爬向道路之后。第二次是3只猩猩，在沿悬崖延伸的小路上。第三次是大约4个豺狼人，其中一个是施法者，在路线转向码头的地方。",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "仅当你有定位器时：机器人在{area:1105}北侧的一个小山洞里。护送它到{area:1108}的码头；途中会有雪人和猩猩伏击你。它的奖励在{area:35}，留到之后再去领取。",
	-- ["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "迅猛龙：祖尼尔，在{area:367}的{npc:7953}旁边。",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "从{area:1978}向西北骑回{area:75}，然后飞往{object:3202}。",
	-- ["Ride back west to {area:976}."] = "向西骑回{area:976}。",
	-- ["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "向西南骑往{area:1105}下方的食人魔废墟。里面满是戈杜尼萨满祭司、戈杜尼术士和戈杜尼虐待者；南端的戈杜尼大法师携带宝珠。",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "从虫巢向西骑往{area:1105}下方的食人魔废墟。里面满是戈杜尼萨满祭司、戈杜尼术士和戈杜尼虐待者；南端的戈杜尼大法师携带宝珠。",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "向西骑进{zone:1444}中部。杀死一只{npc:5308}，对它的尸体使用{item:10699}，再杀死升起的灵魂。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{area:222}的{npc:3690}，旁边是{npc:3685}的科多兽（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{area:159}的{npc:4773}，旁边是{npc:4731}的骸骨军马（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{zone:1411}海岸{area:367}的{npc:7953}，旁边是祖尼尔的迅猛龙（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。{npc:4752}在{object:172958}教授兽人，就在{npc:3362}的狼舍旁；目前不知道天裔的骑术训练师，所以天裔也试试找{npc:4752}。你种族的其他坐骑每匹20金：收藏指南“坐骑 · 40级”为每种坐骑都提供了指南。",
	-- ["Rogue Vale screechers"] = "游荡的山谷尖啸者",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骸骨军马：{npc:4731}，在{area:159}的{npc:4773}旁边。",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "沿海岸向南，南海海盗占据着海湾。{npc:7883}和被偷的货物在海湾尽头的码头上。任何海盗都可能掉落海盗帽，南海绑匪掉得最多。",
	-- ["Southern Gordunni ruins"] = "南部戈杜尼废墟",
	-- ["Southern Wastewander camps"] = "南部废土营地",
	-- ["Sprite darters and Woodpaw alphas"] = "小精龙和木爪突击队员",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "木爪豺狼人在莫沙彻营地西北不远的山丘上扎营；任何一个都可能掉落鬃毛。",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "强盗和窃贼在{area:976}东边的沙丘里扎营。任何废土敌人都可能携带废土水袋：留十个，鲁格伦克的两个悬赏各需五个。",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "废土暗法师、废土游荡者和废土刺客在{area:976}东南扎营。",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "小精龙在莫沙彻营地正西的树林上空飞来飞去；几乎每只都会掉落翅膀。木爪突击队员率领着树林西南的营地：在一小时内杀死它们。",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "前往{object:3202}的飞艇从{zone:1454}正门东北不远的塔上出发。",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "前往{zone:1454}的飞艇从{object:3202}旁的塔上出发；它降落在{zone:1454}正门外。",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "飞行管理员塞斯塔站在飞艇塔正东。飞往{area:75}：下一个指南从那里开始。",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {area:976}, then back to {area:976}."] = "你的训练师在{area:1638}：{area:1639}的{npc:3033}（德鲁伊），{npc:246344}（圣骑士）。从{area:976}飞过去，然后再飞回{area:976}。",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "你的训练师在{area:1638}：{area:1639}的{npc:3033}（德鲁伊），{npc:246344}（圣骑士）。从{zone:1454}飞过去，然后继续飞往{area:484}。",
	-- ["Zeppelin to {object:3202}"] = "乘飞艇前往{object:3202}",
	-- ["Zeppelin tower"] = "飞艇塔",
	-- ["for {area:35}, around level 50"] = "交给{area:35}，大约50级时",
	-- ["the Rage Scar yetis, on the next visit to {area:357}"] = "狂怒疤痕雪人，下次来{area:357}时",
	-- ["the {object:150075} in the square"] = "广场上的{object:150075}",
	-- ["{area:1105} yetis"] = "{area:1105}的雪人",
	-- ["{area:392} for the Felsteed"] = "前往{area:392}做地狱战马任务",
	-- ["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976}是刚过{zone:1446}边界的地精城镇，有城墙环绕。",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}，骑术训练师",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}，骑术训练师",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}：尖啸者生活在{zone:1444}",
}
