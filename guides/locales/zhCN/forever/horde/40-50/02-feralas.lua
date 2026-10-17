-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {area:1978} Misty Reed Post · {area:75} Stonard · {object:3202} Grom'gol
	["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "从{area:1978}向西北骑回{area:75}，然后飞往{object:3202}。",

	-- Step 2: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "前往{zone:1454}的飞艇从{object:3202}旁的塔上出发；它降落在{zone:1454}正门外。",
	["Zeppelin tower"] = "飞艇塔",

	-- Step 4: Riding at 40
	["Riding at 40"] = "40级学骑术",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。{npc:4752}在{object:172958}教授兽人，就在{npc:3362}的狼舍旁；目前不知道天裔的骑术训练师，所以天裔也试试找{npc:4752}。你种族的其他坐骑每匹20金：收藏指南“坐骑 · 40级”为每种坐骑都提供了指南。",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}，骑术训练师",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "狼：{npc:3362}，在{npc:4752}旁边。",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "疾风陆行鸟：{npc:265756}，在泽风岛的{area:16638}。",

	-- Step 5: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1411} Durotar · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{zone:1411}海岸{area:367}的{npc:7953}，旁边是祖尼尔的迅猛龙（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}，骑术训练师",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "迅猛龙：祖尼尔，在{area:367}的{npc:7953}旁边。",

	-- Step 6: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{area:222}的{npc:3690}，旁边是{npc:3685}的科多兽（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，骑术训练师",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "科多兽：{npc:3685}，在{area:222}的{npc:3690}旁边。",

	-- Step 7: Riding at 40
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {npc:4752} Kildar · {zone:1454} Orgrimmar · {object:172958} Valley of Honor
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{area:159}的{npc:4773}，旁边是{npc:4731}的骸骨军马（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}，骑术训练师",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骸骨军马：{npc:4731}，在{area:159}的{npc:4773}旁边。",

	-- Step 8: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {zone:1454} Orgrimmar · {area:484} Freewind Post
	["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "你的训练师在{area:1638}：{area:1639}的{npc:3033}（德鲁伊），{npc:246344}（圣骑士）。从{zone:1454}飞过去，然后继续飞往{area:484}。",

	-- Step 9: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "前往{area:392}做地狱战马任务",

	-- Step 10: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "飞往{area:484}",
	-- {area:484} Freewind Post · {zone:1446} Tanaris
	["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "飞往{area:484}，乘哨站东边的升降梯下去，穿过盐滩，然后向南进入{zone:1446}。",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976}是刚过{zone:1446}边界的地精城镇，有城墙环绕。",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "广场上的{object:150075}",

	-- Step 12: Eastern Wastewander camps
	["Eastern Wastewander camps"] = "东部废土营地",
	-- {area:976} Gadgetzan
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "强盗和窃贼在{area:976}东边的沙丘里扎营。任何废土敌人都可能携带废土水袋：留十个，鲁格伦克的两个悬赏各需五个。",
	["water pouches in your bags"] = "背包里的废土水袋",

	-- Step 14: Southern Wastewander camps
	["Southern Wastewander camps"] = "南部废土营地",
	-- {area:976} Gadgetzan
	["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "废土暗法师、废土游荡者和废土刺客在{area:976}东南扎营。",

	-- Step 15: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "向东北骑往海岸边的地精港口。",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}：尖啸者生活在{zone:1444}",

	-- Step 16: Lost Rigger Cove
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "沿海岸向南，南海海盗占据着海湾。{npc:7883}和被偷的货物在海湾尽头的码头上。任何海盗都可能掉落海盗帽，南海绑匪掉得最多。",

	-- Step 17: Steamwheedle Port
	-- {area:35} Booty Bay
	["for {area:35}, around level 50"] = "交给{area:35}，大约50级时",

	-- Step 18: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride back west to {area:976}."] = "向西骑回{area:976}。",

	-- Step 19: Fly to Freewind Post
	-- {area:484} Freewind Post · {area:2237} Whitereach Post · {zone:1444} Feralas · {area:1099} Camp Mojache
	["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "飞往{area:484}，然后向西穿过峡谷经过{area:2237}；道路向上进入{zone:1444}的丛林，一直通往{area:1099}。",

	-- Step 20: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}：交给{zone:1454}，大约45级时",

	-- Step 21: Woodpaw north camp
	["Woodpaw north camp"] = "木爪北营地",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "木爪豺狼人在莫沙彻营地西北不远的山丘上扎营；任何一个都可能掉落鬃毛。",

	-- Step 22: Gordunni Outpost
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it."] = "在豺狼人北边，食人魔占据着一座山顶前哨站；把食人魔法师引到你身边来打。戈杜尼钴矿石在前哨站周围的土堆里，戈杜尼卷轴就在前哨站里的地上。",

	-- Step 23: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}：从现在起一小时内",

	-- Step 24: Sprite darters and Woodpaw alphas
	["Sprite darters and Woodpaw alphas"] = "小精龙和木爪突击队员",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "小精龙在莫沙彻营地正西的树林上空飞来飞去；几乎每只都会掉落翅膀。木爪突击队员率领着树林西南的营地：在一小时内杀死它们。",

	-- Step 26: Grimtotem camp
	["Grimtotem camp"] = "恐怖图腾营地",
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns."] = "恐怖图腾牛头人在小精龙的树林旁扎营；恐怖图腾袭击者、恐怖图腾博学者和恐怖图腾萨满祭司都携带恐怖图腾之角。",

	-- Step 27: Woodpaw battle map
	["Woodpaw battle map"] = "木爪作战地图",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "木爪作战地图在莫沙彻营地南边的木爪营地里。",

	-- Step 28: Southern Gordunni ruins
	["Southern Gordunni ruins"] = "南部戈杜尼废墟",
	-- {area:1105} Feral Scar Vale
	["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "向西南骑往{area:1105}下方的食人魔废墟。里面满是戈杜尼萨满祭司、戈杜尼术士和戈杜尼虐待者；南端的戈杜尼大法师携带宝珠。",

	-- Step 29: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "交给{zone:1454}，大约45级时",

	-- Step 30: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "祖卡什异种蝎的巢穴深入营地东南的山丘；{quest:7731}在最深处的洞室里等候。",

	-- Step 32: Rogue Vale screechers
	["Rogue Vale screechers"] = "游荡的山谷尖啸者",
	-- {zone:1444} Feralas · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "向西骑进{zone:1444}中部。杀死一只{npc:5308}，对它的尸体使用{item:10699}，再杀死升起的灵魂。",

	-- Step 33: The Forgotten Coast
	-- plural, as words: Coast Crawl Deepseers = {npc:5328} Coast Crawl Deepseer
	["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "继续向西骑到海岸。海滩上的海滩龙虾人先知和海滩利爪龙虾人大约每杀四十只掉落一个OOX-22/FE定位器：如果掉了，就使用它开始任务。",

	-- Step 34: Homing Robot OOX-22/FE
	-- {area:1105} Feral Scar Vale · {area:1108} The Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "仅当你有定位器时：机器人在{area:1105}北侧的一个小山洞里。护送它到{area:1108}的码头；途中会有雪人和猩猩伏击你。它的奖励在{area:35}，留到之后再去领取。",

	-- Step 35: Hearth to Camp Mojache
	-- {area:1099} Camp Mojache
	["Hearth to {area:1099}"] = "用炉石回到{area:1099}",

	-- Step 36: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "飞往{area:1637}。杜佛斯兄弟在暗巷区经营他们的商店。",
	-- {zone:1425} Hinterlands
	["for the {zone:1425}, around level 48"] = "交给{zone:1425}，大约48级时",

	-- Step 37: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "乘飞艇前往{object:3202}",
	-- {object:3202} Grom'gol · {zone:1454} Orgrimmar
	["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "前往{object:3202}的飞艇从{zone:1454}正门东北不远的塔上出发。",

	-- Step 38: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "飞往{area:75}",
	-- {area:75} Stonard
	["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "飞行管理员塞斯塔站在飞艇塔正东。飞往{area:75}：下一个指南从那里开始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "仅当你有定位器时：机器人在{area:1105}北侧的一个小山洞里。护送它到{area:1108}的码头；途中会有雪人和猩猩伏击你。它的奖励在{area:35}，留到之后再去领取。",
}
