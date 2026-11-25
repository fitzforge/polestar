-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1434} Stranglethorn Vale · {area:75} Stonard · {zone:1446} Tanaris · {zone:1444} Feralas
	["{zone:1434} and {area:75} first, then {zone:1446} and {zone:1444}."] = "先去{zone:1434}和{area:75}，再去{zone:1446}和{zone:1444}。",

	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {zone:2548} Riverglades · {area:340} Kargath
	["Coming from the {zone:2548}: {area:340}'s flight master stands at the foot of the fortress."] = "从{zone:2548}过来：{area:340}的飞行管理员站在要塞脚下。",
	-- {area:340} Kargath
	["{area:340} flight master"] = "{area:340}的飞行管理员",

	-- Step 2: Fly to Grom'gol
	-- {area:75} Stonard
	["{area:75} flight master"] = "{area:75}的飞行管理员",

	-- Step 3: Grom'gol Base Camp
	-- {object:3202} Grom'gol · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1435} Swamp of Sorrows · {zone:1458} Undercity · {object:2076} Bubbling Cauldron
	-- was: ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "飞行路线降落在{object:3202}。你第一次来时接下的荆棘谷较难的任务现在适合你了：碎颅部落首领、赞吉尔的营地、{area:35}的海盗、娜迦海岸和{npc:1514}，之后再乘飞艇前往{zone:1454}。尼姆布亚旁边的{object:2076}有碎颅部落首领的任务。"
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the {zone:1435} and the {zone:1458}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "{object:2076}：{quest:586}",

	-- Step 4: Tusks and necklaces on the Skullsplitter hunt
	["Tusks and necklaces on the Skullsplitter hunt"] = "",
	-- {npc:737} Kebok · {npc:2519} Kin'weelay
	["The hunters also drop {npc:737}'s tusks and {npc:2519}'s necklaces. Collect any you still need during the cauldron hunt."] = "",

	-- Step 5: Zul'Mamwe
	["Zul'Mamwe"] = "祖玛维废墟",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "向东骑到风险投资公司矿洞东边的碎颅部落废墟。猎头者、狂暴者和猎手在废墟中游荡。\n{npc:1059}（45级）携带{quest:586}所需的破损的盔甲：他带着两名守卫在西南部废墟巡逻，有时会站在那里的一个小山洞里。先拉守卫。\n小心：{npc:1060}，一只精英巨魔（44级），站在南部废墟47.7,44.3附近：把猎头者和狂暴者从他身边拉开。",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 6: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Back west to {object:3202}."] = "向西返回{object:3202}。",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "再次到{object:2076}处：耶尼库的命运",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519}：蜥蜴在南边的道路旁晒太阳，就在前往{area:35}的路上",

	-- Step 8: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "铁腭蜥蜴",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "沿道路向南朝{area:35}骑行；蜥蜴在道路东边丛林中部的岩石上晒太阳。它们经常掉落碎片。",
	["Below ground"] = "在地下",

	-- Step 9: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "海盗鬼魂和赞吉尔的营地",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	-- was: ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "继续向西南前往薄雾谷东北的丛林：三个海盗鬼魂在赞吉尔的营地旁出没。{npc:2535}和{npc:2536}站在一起，{npc:2537}在更东边。赞吉尔的每个追随者都可能携带混合物。\n小心：赞吉尔巫医（44级）会施法，而且营地里怪很密：从边缘一只一只地拉。{npc:2534}（46级）本人站在南边营地39.6,58.6附近，离{npc:2537}的鬼魂只有几步：先把{npc:2537}向北或向东拉出来再打。"
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and Jon-Jon stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "",

	-- Step 10: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "向西进入薄雾谷：{npc:1449}坐在大猩猩中间。任何大猩猩都可能掉落獠牙：交给他十个并待在他身边，他会召来三波大猩猩，然后是{npc:1514}。\n小心：三波大猩猩接连而来，中间几乎没有喘息时间，之后是{npc:1514}。开始前回满生命值和法力值，并待在安巴格瓦附近。有些职业单刷会很吃力：找个队友就轻松了。",

	-- Step 11: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}：沿途遇到就击杀",
	-- {object:759} Holy Spring · {area:43} Wild Shore · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them.\nFollow the coast south. If you still need the {area:43} pirates, take the road past the {area:35} tunnel to the beach before going into town."] = "",

	-- Step 12: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:35} Booty Bay
	["From the north, take the outer shore east of the {area:35} tunnel. Work south-west through the swashbucklers (41-43) into the camp; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Stay ashore."] = "",

	-- Step 13: Bloodsail tents and rowboat
	["Bloodsail tents and rowboat"] = "",
	["Search the tents and the rowboat for both papers; if one place is empty, try the next. Neither paper is on a ship."] = "",

	-- Step 16: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2498} inside the inn, MacKinley, {npc:737} and {npc:773} upstairs."] = "在{area:35}：{npc:2494}在码头上，{npc:2498}在旅店里，马克基雷、{npc:737}和{npc:773}在楼上。",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}：在屋内",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”马克基雷，位于最顶层",

	-- Step 17: Fin Fizracket
	-- {npc:2486} Fin Fizracket
	["{npc:2486}, by the inn"] = "",

	-- Step 18: Whiskey Slim and Fin Fizracket
	-- {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["{npc:2491} and {npc:2486}"] = "",
	-- {area:35} Booty Bay · {npc:2491} Whiskey Slim
	["Under 40 on your first {area:35} visit? {npc:2491}, in the inn, and \"Sea Wolf\" MacKinley, on the top floor, have their quests for you now."] = "第一次来{area:35}时还不到40级？旅店里的{npc:2491}和顶楼的“海狼”马克基雷现在就有任务给你。",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}在旅店里：他的酒瓶被冲到了{zone:1425}海岸，约48级时再去",
	-- {quest:2872} Stoley's Debt · {npc:7881} Stoley · {zone:1446} Tanaris
	["MacKinley, on the top floor: {quest:2872}, for {npc:7881} in {zone:1446} on this guide"] = "",

	-- Step 19: Fin Fizracket
	-- {quest:348} Stranglethorn Fever · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["Group quest: {quest:348} ends at {npc:1449} in Mistvale. Hand him ten gorilla fangs and he calls three waves of gorillas (41-42), one after another, then {npc:1514} (44). In players' recordings, 12 of the 27 people who started it died there. Take it if you have a friend or two along."] = "小队任务：{quest:348}在薄雾山谷的{npc:1449}处结束。交给他十颗大猩猩獠牙，他会召来三波大猩猩（41-42），一波接一波，然后是{npc:1514}（44）。玩家记录中，开始此任务的27人里有12人死在那里。如果有一两个朋友同行就接。",
	-- {npc:2486} Fin Fizracket · {quest:348} Stranglethorn Fever
	["{npc:2486}, beside the inn: {quest:348}"] = "{npc:2486}，在旅店旁边：{quest:348}",

	-- Step 20: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["North into Mistvale, a short ride from {area:35}: {npc:1449} sits among the gorillas. Hand him ten gorilla fangs and stay by him: three waves of gorillas, then {npc:1514}. Start at full health and mana."] = "",

	-- Step 22: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}：在楼上",

	-- Step 23: Krazek
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "楼上的{npc:773}：用于本指南稍后在{area:976}的{quest:2864}",

	-- Step 26: Unfinished Wild Shore errands
	-- {area:43} Wild Shore
	["Unfinished {area:43} errands"] = "",
	["If the town rewards just brought you to 42 and you still owe pirate work, use the shore tents, not the ships."] = "",

	-- Step 30: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 31: Grom'gol Base Camp
	-- {object:3202} Grom'gol · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then back to the flight master."] = "",

	-- Step 34: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "飞往{area:75}",
	-- {object:3202} Grom'gol · {area:75} Stonard · {area:1978} Misty Reed Post
	["Stranglethorn's errands are done: from {object:3202}'s flight master, fly on to {area:75} for the swamp's coast and {area:1978}, which fit you now."] = "",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "{object:3202} 的飞行管理员。",

	-- Step 35: To Stonard
	-- {area:75} Stonard
	["To {area:75}"] = "前往{area:75}",
	-- {area:75} Stonard · {object:3202} Grom'gol · {zone:1431} Duskwood · {zone:1430} Deadwind Pass
	["No flight path to {area:75} yet: ride north-east from {object:3202} through {zone:1431} and {zone:1430} into the swamp, then east along the road to {area:75}, and learn its flight path."] = "",

	-- Step 36: Stonard
	-- {quest:698} Lack of Surplus · {quest:1424} Pool of Tears · {quest:1430} Fresh Meat · {npc:5593} Katar · {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["The Stranglethorn & Swamp guide already finished {quest:698}' first part and the {quest:1424} with you; its {quest:1430} and {npc:5593}'s murlocs are in your log. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}：在屋内",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}，位于最顶层",

	-- Step 37: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "沿道路向西骑行；卷轴在沼泽最西边的水边。",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, on the Dustwallow guide"] = "",

	-- Step 38: A Soggy Scroll
	["The scroll lies at the water's edge in the swamp's far west."] = "卷轴在沼泽最西边的水边。",

	-- Step 39: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "盐齿鳄鱼",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "向东返回的路上，{area:75}北面不远处、加林的旧营地周围水池里有鳄鱼；约四分之一会掉落腰肉。",

	-- Step 40: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "往回向东经过{area:75}：阿塔莱神器在{quest:1424}的水里和岸边。",

	-- Step 41: Misty Reed Post
	-- {npc:5592} Tok'Kar · {npc:5593} Katar
	["Follow the road south-east to the small Horde post on the shore: {npc:5592} and {npc:5593}."] = "",

	-- Step 42: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403}：沿途遇到就击杀",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "钳嘴龟分布在岗哨南边的海滩。\n巨型淤泥蟹沿东海岸的沙滩游荡，数量少且分散；看到就杀，从水池骑行南下途中遇到的也别漏掉。\n小心：一只{npc:272377}（60级）在东南部的海滩上走动：远远绕开它。",
	["Underwater"] = "在水下",

	-- Step 44: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "芦苇丛中的鱼人",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "沼泽鱼人住在哨站南边的海滩上；沼泽喷墨鱼人在哨站东边的岸边，沼泽食腐鱼人在更西边、西岸的小屋周围。",

	-- Step 46: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "再去同一片鱼人海岸：沼泽喷墨鱼人在哨站东边，沼泽食腐鱼人在西侧小屋周围，沼泽鱼人智者在这两处都有分布。",

	-- Step 48: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 49"] = "",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity · {area:340} Kargath · {npc:5204} Apothecary Zinge · {zone:1454} Orgrimmar
	["From {area:75}'s flight master, fly to the {area:1497} (by way of {area:340}): {npc:5204}'s errands and your {area:1497} training, then the zeppelin from the towers outside the city to {zone:1454}."] = "",

	-- Step 50: Apothecary Zinge
	-- {npc:2934} Keeper Bel'dugur
	["{npc:2934}, on the way back to Zinge"] = "{npc:2934}，在返回金吉那里的路上",
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "这些任务给的{item:8523}要保留，稍后在{area:976}完成“塔纳利斯的样本”时交还",

	-- Step 51: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}，在{object:36126}",

	-- Step 52: Riding at 40
	["Riding at 40"] = "40级学骑术",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1454} Orgrimmar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {zone:1454} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}，骑术训练师",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骸骨军马：{npc:4731}，在{area:159}的{npc:4773}旁边。",

	-- Step 53: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 54: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "{zone:1454}中央",

	-- Step 55: Orgrimmar
	-- {zone:1458} Undercity
	["the {zone:1458}'s classes trained there on the way"] = "",

	-- Step 56: Riding at 40
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "骑术需要40级，费用100金币；学习时会获得一只坐骑。兽人可在{object:172958}、{npc:3362}的兽栏旁向{npc:4752}学习。天裔可在泽风岛{area:16638}的{area:17684}向{npc:265756}学习，并获得一只疾风陆行鸟：前往该岛的空中船约每5分钟从{area:17045}南面、{zone:1456}北面的悬崖出发。你所属种族的其他坐骑每只20金币：“收藏品”中的“坐骑 · 40级”提供各类指南。",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}，骑术训练师",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "狼：{npc:3362}，在{npc:4752}旁边。",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "骑术和疾风陆行鸟：找泽风岛上{area:16638}的{area:17684}处的{npc:265756}。",

	-- Step 58: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "骑术需要40级，花费100金币；学会后会获得一只坐骑。各个种族都要找本族训练师学习。你的训练师是{area:367}的{npc:7953}，从{zone:1454}沿{zone:1411}的道路向南骑行不远就到，旁边是祖尼尔出售的迅猛龙（每只20金币）。之后骑回{zone:1454}的飞行管理员处。",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}，骑术训练师",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "迅猛龙：祖尼尔，在{area:367}的{npc:7953}旁边。",

	-- Step 59: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飞往{area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 61: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "你的训练师在{zone:1456}：德鲁伊找{area:1639}的{npc:3033}，圣骑士找{npc:246344}。",

	-- Step 63: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "骑术需要40级，花费100金币；学会后会获得一只坐骑。各个种族都要找本族训练师学习。你的训练师是{area:222}的{npc:3690}，旁边是{npc:3685}出售的科多兽（每只20金币）。之后骑回上方{zone:1456}的飞行管理员处。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，骑术训练师",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "科多兽：{npc:3685}，在{area:222}的{npc:3690}旁边。",

	-- Step 64: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "飞往{area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 65: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飞往{area:976}",

	-- Step 68: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "前往{area:392}做地狱战马任务",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "从{zone:1454}飞往{area:392}；{npc:6251}站在码头上方的山丘上。",

	-- Step 69: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 75: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "飞到之后：先在飞行管理员旁边做{area:976}的任务，然后向北骑一小段，越过{zone:1446}边界就到{area:2240}。",
	-- {npc:7407} Chief Engineer Bilgewhizzle · {npc:5204} Apothecary Zinge · {item:8523} Field Testing Kit · {zone:1458} Undercity
	["{npc:7407}: {npc:5204}'s {item:8523}, from the {zone:1458}"] = "",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}: the water pouches come from the same Wastewander camps"] = "",

	-- Step 76: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "为下一份指南的{area:978}之行做准备：{quest:2864}要圣甲虫壳，飞行管理员附近不远处的{npc:7804}要沙怒巨魔的{quest:3042}。",

	-- Step 77: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "飞到{area:976}后：赛道就在北边不远处，越过{zone:1446}边界即到。\n从{area:484}通往{zone:1446}的道路经过{area:439}的{area:2240}：{npc:4454}在赛道旁的侏儒营地，{npc:4630}和{npc:4709}在地精营地旁。先找{npc:4630}，再找{npc:4709}；后者会跑去分散瑞兹尔·铜栓的注意力。趁机从侏儒营地拿走瑞兹尔·铜栓的计划，带回给{npc:4630}。",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}：{quest:1137}，来自 {zone:1418} 的马特克",
	-- {npc:4630} Pozzik · {npc:2496} Baron Revilgaz · {area:35} Booty Bay
	["{npc:4630}: {npc:2496}'s word, from {area:35}"] = "",
	-- {npc:4706} Razzeric · {npc:4630} Pozzik
	["{npc:4706}, beside {npc:4630}"] = "{npc:4706}，在{npc:4630}旁边",

	-- Step 78: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "前往{area:976}",

	-- Step 79: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976}是刚过{zone:1446}边界的地精城镇，有城墙环绕。",

	-- Step 81: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}：沿途击杀以下目标",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	-- was: ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "强盗和盗贼在{area:976}东侧沙丘扎营。所有废土游荡者部族的敌人都可能携带水袋：鲁格伦克需要五个。\n小心：废土游荡者（43-44级）会潜行移动，可能悄悄靠近。"
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five, and Bilgewhizzle five more.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "",

	-- Step 82: Gadgetzan
	-- {zone:1446} Tanaris
	["Keep the Model 4711-FTZ Power Source Bilgewhizzle gave you: it starts Tanaris Field Sampling, a two-hour timer, for the {zone:1446} guide at about 48, on the way back north from Scrimshank's hive."] = "",

	-- Step 83: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "向东北骑往海岸边的地精港口。",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}：在屋内",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}：在屋内",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on this guide's west sweep"] = "",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "{npc:260405}，在码头上：如果你带着弗里兹从{zone:2548}托付的差事，交给他",

	-- Step 84: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}：沿途击杀以下目标",
	-- {npc:7883} Andre Firebeard · {item:9276} Pirate's Footlocker · {item:9250} Ship Schedule · {area:977} Steamwheedle Port
	-- was: ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "沿海岸向南，南海海盗占据着海湾。{npc:7883}和失窃货物位于海湾最里面的码头上。任何海盗都有可能掉帽子，绑匪的掉率最高。\n小心：{npc:7883}（45级）身旁有两三名海盗，开战后镇内还会有更多海盗加入：先把他的护卫从他身边引开。"
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first.\nThe cove's pirates sometimes drop a {item:9276}: open it, and if it holds a {item:9250}, read it to start a quest for the Security Chief in {area:977}."] = "",
	["Upstairs"] = "在楼上",
	-- {item:9250} Ship Schedule · {item:9276} Pirate's Footlocker
	["{item:9250}, from a {item:9276}"] = "",

	-- Step 85: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985}：沿途遇到就击杀",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "暗影法师、潜行者和刺客驻扎在 {area:976} 东南。\n加基森东南的沙丘中有废土强盗营地；{npc:7847} 站在东边的营地里。\n小心：废土游荡者脱战后会保持潜行，在营地开战时，隐藏的游荡者可能加入战斗。\n小心：他无论走到哪里，都有两名潜行的废土游荡者同行。在刷新营地时，附近的两名暗影法师及其爪牙也会被引来。到塔楼附近就能单独与他战斗，避开这些法师。",

	-- Step 86: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "向东北骑回港口：{npc:7881}、{npc:15165}和安全主管会收下你从{area:1336}带回的东西。{area:976}就在港口西边。",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "留到{area:35}，大约51级时（40-50/06）",
	-- {npc:7882} Security Chief Bilgewhizzle · {item:9250} Ship Schedule
	["{npc:7882}: the {item:9250}, if the cove gave you one"] = "",

	-- Step 88: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}的飞行管理员",

	-- Step 90: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777}在{area:1099}附近巡逻，请在地图标出的圆圈内寻找",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115}：如果你带着{npc:263190}从{zone:2548}托付的差事，交给他",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	-- was: ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}：交给{zone:1454}，大约45级时"
	["{npc:8115}: for {zone:1454}, around level 47"] = "",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}：在屋内",

	-- Step 91: Gordunni Outpost
	-- {npc:222233} Ohk'zi · {item:9466} Orwin's Shovel · {object:144064} Gordunni Dirt Mound
	-- was: ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "在豺狼人北边，食人魔占据着一座山顶前哨站；把食人魔法师引到你身边来打。戈杜尼钴矿石在前哨站周围的土堆里，戈杜尼卷轴就在前哨站里的地上。\n小心：{npc:222233}（43级，精英）站在前哨站里：把食人魔引出来，远离他。"
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him.\nUse {item:9466} on each {object:144064} around the outpost: the arrow goes from mound to mound."] = "",

	-- Step 92: Woodpaw north camp
	["Woodpaw north camp"] = "木爪北营地",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "木爪豺狼人在莫沙彻西北不远处的山丘扎营；所有种类都可能掉落鬃毛。\n小心：除首领外，所有木爪豺狼人都会在15%生命值时逃跑求援，可能将更多豺狼人引入战斗。",

	-- Step 93: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}：从现在起一小时内",

	-- Step 94: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444}：沿途遇到就击杀",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "精龙在莫沙彻西侧紧邻的林地上方飞舞；几乎每只都会掉落翅膀。木爪豺狼人首领率领着其西南方各营地：要在一小时内杀死它们。\n小心：大多数首领都待在小帐篷营地中，旁边有 2-4 只会加入战斗的豺狼人，营地之间还有其他豺狼人巡逻。",

	-- Step 96: Grimtotem camp
	["Grimtotem camp"] = "恐怖图腾营地",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "恐怖图腾牛头人在小精龙的树林旁扎营；恐怖图腾袭击者、恐怖图腾博学者和恐怖图腾萨满祭司都携带恐怖图腾之角。\n小心：{npc:222286}（43级，精英）站在营地里：把袭击者和萨满祭司从她身边引开。",

	-- Step 97: Woodpaw battle map
	["Woodpaw battle map"] = "木爪作战地图",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "木爪作战地图在莫沙彻营地南边的木爪营地里。",

	-- Step 98: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 47"] = "",

	-- Step 99: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "祖卡什异种蝎的巢穴深入营地东南的山丘；{quest:7731}在最深处的洞室里等候。\n小心：{quest:7731}是47级：先清理他周围的虫子，满血时把他单独引出来。",

	-- Step 100: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522}：沿途遇到就击杀",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "从虫巢向西骑往{area:1105}下方的食人魔废墟。里面满是戈杜尼萨满祭司、戈杜尼术士和戈杜尼虐待者；南端的戈杜尼大法师携带宝珠。\n小心：大法师（45-46级）和萨满祭司会远程施法，而且废墟里怪物密集：从边缘一次引一只。",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234}在{area:2522}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 101: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "{area:1105}的雪人",
	-- {area:1105} Feral Scar Vale
	["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "在废墟西北，雪人栖息在{area:1105}；那里的每只雪人都可能掉落厚雪人皮。",

	-- Step 102: Rogue Vale screechers
	["Rogue Vale screechers"] = "游荡的山谷尖啸者",
	-- {area:1099} Camp Mojache · {area:1105} Feral Scar Vale · {item:10699} Yeh'kinya's Bramble · {npc:8579} Yeh'kinya · {area:977} Steamwheedle Port · {zone:1446} Tanaris
	-- plural, as words: Rogue Vale Screechers = {npc:5308} Rogue Vale Screecher
	["On the way back north-east towards {area:1099}, the Rogue Vale Screechers (44-46) hunt the open ground north of {area:1105}. Kill one, use {item:10699} on its body before you loot it, then talk to the spirit that rises: it is friendly. Three spirits in all; {npc:8579} takes them in {area:977} on your next {zone:1446} visit."] = "",

	-- Step 103: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "仅当你有定位器时：{zone:1444}的任何野兽、豺狼人或食人魔都可能掉落它，大约每杀一百只掉一个；使用它开始任务。机器人在{area:1105}北侧的一个小山洞里，就在废墟西北不远。护送它到{area:1108}的码头；途中会有雪人和猩猩伏击你。它的奖励在{area:35}，留到之后再去领取。\n小心：护送过程中会出现三次伏击，机器人每次都会提前警告你。第一次是3只雪人，就在机器人离开山洞、爬向道路之后。第二次是3只猩猩，在沿悬崖延伸的小路上。第三次是大约4个豺狼人，其中一个是施法者，在路线转向码头的地方。",

	-- Step 104: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "狂怒疤痕雪人，下次来{zone:1444}时",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875}：交给{zone:1454}的{npc:7010}",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "留到{zone:1454}，在{zone:2652}之后",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "下一站是{zone:2652}，从{area:1099}向北骑行进入{zone:1443}：{zone:1454}的交还任务（尼尔鲁、吉兹比恩、{npc:4485}、{npc:7311}）留到之后飞去那里时再交。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "回到镇上。船长们的任务是海角的下一个请求，留到你约50级再来荆棘谷时再做。",
	-- ["Eastern Wastewander camps"] = "东部废土营地",
	-- ["Fly to {area:1637}"] = "飞往{area:1637}",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "飞往{area:1637}。杜佛斯兄弟在暗巷区经营他们的商店。",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "飞往{area:484}，乘哨站东边的升降梯下去，穿过盐滩，然后向南进入{zone:1446}。",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "飞往{area:484}，然后向西穿过峡谷经过{area:2237}；道路向上进入{zone:1444}的丛林，一直通往{area:1099}。",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "飞往 {zone:1454}。从飞行管理员出发：先去 {object:172960}，再去暗巷区，然后去 {object:172958}。",
	-- ["Fly to {zone:1454}. The Droffers brothers run their shop in the Drag.\n{object:172958}, then the {object:172960} and the {object:172961}."] = "飞往 {zone:1454}。德罗弗斯兄弟在暗巷区经营商店。\n先去 {object:172958}，再去 {object:172960} 和 {object:172961}。",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "疾风陆行鸟：{npc:265756}，在泽风岛的{area:16638}。",
	-- ["Hearth to {area:1099}"] = "用炉石回到{area:1099}",
	-- ["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "在{area:35}：码头上的{npc:2494}，旅店旁的{npc:2486}，旅店里的{npc:2498}，楼上的麦金利、{npc:737}和{npc:773}。",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "继续向西骑到海岸。海滩上的海滩龙虾人先知和海滩利爪龙虾人大约每杀四十只掉落一个OOX-22/FE定位器：如果掉了，就使用它开始任务。",
	-- ["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "在豺狼人北边，食人魔占据着一座山顶前哨站；把食人魔法师引到你身边来打。戈杜尼钴矿石在前哨站周围的土堆里，戈杜尼卷轴就在前哨站里的地上。\n小心：{npc:222233}（43级，精英）站在前哨站里：把食人魔引出来，远离他。",
	-- ["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "继续向西南前往薄雾谷东北的丛林：三个海盗鬼魂在赞吉尔的营地旁出没。{npc:2535}和{npc:2536}站在一起，{npc:2537}在更东边。赞吉尔的每个追随者都可能携带混合物。\n小心：赞吉尔巫医（44级）会施法，而且营地里怪很密：从边缘一只一只地拉。{npc:2534}（46级）本人站在南边营地39.6,58.6附近，离{npc:2537}的鬼魂只有几步：先把{npc:2537}向北或向东拉出来再打。",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "仅当你有定位器时：机器人在{area:1105}北侧的一个小山洞里。护送它到{area:1108}的码头；途中会有雪人和猩猩伏击你。它的奖励在{area:35}，留到之后再去领取。",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "从{area:1978}向西北骑回{area:75}，然后飞往{object:3202}。",
	-- ["Ride back west to {area:976}."] = "向西骑回{area:976}。",
	-- ["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "向西南骑往{area:1105}下方的食人魔废墟。里面满是戈杜尼萨满祭司、戈杜尼术士和戈杜尼虐待者；南端的戈杜尼大法师携带宝珠。",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "从虫巢向西骑往{area:1105}下方的食人魔废墟。里面满是戈杜尼萨满祭司、戈杜尼术士和戈杜尼虐待者；南端的戈杜尼大法师携带宝珠。",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "向西骑进{zone:1444}中部。杀死一只{npc:5308}，对它的尸体使用{item:10699}，再杀死升起的灵魂。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{area:222}的{npc:3690}，旁边是{npc:3685}的科多兽（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{area:159}的{npc:4773}，旁边是{npc:4731}的骸骨军马（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。在经典版中，每个种族都向本种族的训练师学习：你的训练师是{zone:1411}海岸{area:367}的{npc:7953}，旁边是祖尼尔的迅猛龙（每匹20金）。Forever 可能允许任何种族向任何骑术训练师学习（未确认）：先试试{zone:1454}{object:172958}的{npc:4752}，因为他最近，如果他能教你就跳过此步骤。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑。{npc:4752}在{object:172958}教授兽人，就在{npc:3362}的狼舍旁；目前不知道天裔的骑术训练师，所以天裔也试试找{npc:4752}。你种族的其他坐骑每匹20金：收藏指南“坐骑 · 40级”为每种坐骑都提供了指南。",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "沿海岸向南，南海海盗占据着海湾。{npc:7883}和被偷的货物在海湾尽头的码头上。任何海盗都可能掉落海盗帽，南海绑匪掉得最多。",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "沿海岸向南，南海海盗占据着海湾。{npc:7883}和失窃货物位于海湾最里面的码头上。任何海盗都有可能掉帽子，绑匪的掉率最高。\n小心：{npc:7883}（45级）身旁有两三名海盗，开战后镇内还会有更多海盗加入：先把他的护卫从他身边引开。",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "沿海岸向南，南海海盗占据着海湾。{npc:7883} 和失窃货物位于海湾最里面的码头上。任何海盗都有可能掉帽子，绑匪的掉率最高。\n小心：{npc:7883} 身旁有两三名海盗，开战后镇内还会有更多海盗加入。",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "在藏宝海湾南边，血帆流氓在{area:43}扎营；血帆海图和血帆计划书就在他们的帐篷里，以及较大营地旁的小船里。任何血帆海盗都可能携带鼻烟和{npc:2493}的眼睛，所以一直杀到两样都拿到为止。",
	-- ["Southern Gordunni ruins"] = "南部戈杜尼废墟",
	-- ["Southern Wastewander camps"] = "南部废土营地",
	-- ["Sprite darters and Woodpaw alphas"] = "小精龙和木爪突击队员",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "木爪豺狼人在莫沙彻营地西北不远的山丘上扎营；任何一个都可能掉落鬃毛。",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "祖卡什异种蝎的巢穴深入营地东南的山丘；{quest:7731}在最深处的洞室里等候。",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "强盗和盗贼在{area:976}东侧沙丘扎营。所有废土游荡者部族的敌人都可能携带水袋：鲁格伦克需要五个。\n小心：废土游荡者（43-44级）会潜行移动，可能悄悄靠近。",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "强盗和窃贼在{area:976}东边的沙丘里扎营。任何废土敌人都可能携带废土水袋：留十个，鲁格伦克的两个悬赏各需五个。",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "强盗和盗贼在{area:976}东侧沙丘扎营。所有废土敌人都可能携带水袋：保留十个，操作员鲁格伦克的两个悬赏各需五个。\n小心：废土游荡者（43-44级）会潜行移动，可能悄悄靠近。",
	-- ["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "飞行路线降落在{object:3202}。你第一次来时接下的荆棘谷较难的任务现在适合你了：碎颅部落首领、赞吉尔的营地、{area:35}的海盗、娜迦海岸和{npc:1514}，之后再乘飞艇前往{zone:1454}。尼姆布亚旁边的{object:2076}有碎颅部落首领的任务。",
	-- ["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "飞行降落在{object:3202}：{npc:2519}和{npc:2465}，然后去飞艇塔。",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "废土暗法师、废土游荡者和废土刺客在{area:976}东南扎营。",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "小精龙在莫沙彻营地正西的树林上空飞来飞去；几乎每只都会掉落翅膀。木爪突击队员率领着树林西南的营地：在一小时内杀死它们。",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "前往{object:3202}的飞艇从{zone:1454}正门东北不远的塔上出发。",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "前往{zone:1454}的飞艇从{object:3202}旁的塔上出发；它降落在{zone:1454}正门外。",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "飞行管理员塞斯塔站在飞艇塔正东。飞往{area:75}：下一个指南从那里开始。",
	-- ["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "向西到海岸：娜迦探险者在岸边涉水，携带芦苇束；{object:759}就在它们东边的山丘里冒泡。然后沿海岸向南前往{area:35}。",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {area:976}, then back to {area:976}."] = "你的训练师在{area:1638}：{area:1639}的{npc:3033}（德鲁伊），{npc:246344}（圣骑士）。从{area:976}飞过去，然后再飞回{area:976}。",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "你的训练师在{area:1638}：{area:1639}的{npc:3033}（德鲁伊），{npc:246344}（圣骑士）。从{zone:1454}飞过去，然后继续飞往{area:484}。",
	-- ["Zeppelin to {object:3202}"] = "乘飞艇前往{object:3202}",
	-- ["Zeppelin tower"] = "飞艇塔",
	-- ["for the {zone:1425}, around level 48"] = "交给{zone:1425}，大约48级时",
	-- ["for {area:35}, around level 50"] = "留到{area:35}，大约50级时",
	-- ["for {zone:1454}, around level 45"] = "交给{zone:1454}，大约45级时",
	-- ["the {object:150075} in the square"] = "广场上的{object:150075}",
	-- ["water pouches in your bags"] = "背包里的废土水袋",
	-- ["{area:1099} flight master"] = "{area:1099}的飞行管理员",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976}是刚过{area:440}边界的地精城镇，有城墙环绕。",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}，位于最顶层",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630}：如果你身上带着{npc:2496}给的{item:5852}，就交给他",
	-- ["{npc:6986}, the Drag"] = "{npc:6986}，在暗巷区",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}，在暗巷区",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}，骑术训练师",
	-- ["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}：交给{zone:1454}，大约45级时",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}：尖啸者生活在{zone:1444}",
	-- ["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}：尖啸者生活在{zone:1444}，下次去{zone:1444}时再杀",
}
