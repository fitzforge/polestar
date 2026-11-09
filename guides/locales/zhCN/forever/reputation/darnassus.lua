-- Chinese (simplified) (zhCN): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "达纳苏斯声望",
	-- {item:11040} Morrowgrain · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["Cloth, {item:11040} and the {zone:1438} and {zone:1439} hubs: the quests pay most while you level."] = "布料、{item:11040}以及{zone:1438}和{zone:1439}的任务据点：升级期间做任务给的声望最多。",
	-- {faction:69} Darnassus
	["Exalted with {faction:69}: in Classic, other races may buy the nightsabers"] = "{faction:69}崇拜：在经典版中，其他种族可购买夜刃豹",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain
	["{quest:3803}: 50 reputation for every 10 {item:11040}, as often as you like"] = "{quest:3803}：每10个{item:11040}给50点声望，可无限重复",
	-- {faction:69} Darnassus · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439}"] = "",

	-- Step 1: Raedon Duskstriker, the cloth quartermaster
	-- {npc:14725} Raedon Duskstriker
	["{npc:14725}, the cloth quartermaster"] = "布料军需官{npc:14725}",
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {area:1659} Craftsmen's Terrace · {item:14047} Runecloth · {quest:7801} Additional Runecloth · {area:1662} Tradesmen's Terrace · {zone:1438} Teldrassil · {zone:1439} Darkshore · {zone:1440} Ashenvale · {quest:4183} The True Masters · {zone:1428} Burning Steppes · {item:11040} Morrowgrain · {area:188} Shadowglen · {area:186} Dolanaar · {area:442} Auberdine · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{npc:14725} takes cloth for {faction:69}; he stands in the {area:1659}, in the north-east of {faction:69}, by the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7801} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the {area:1662} is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1438} (levels 1-12), {zone:1439} (11-20) and {zone:1440} (18-30) while you level through them. After the donations come {quest:4183} in the {zone:1428} and {item:11040}, a second repeatable turn-in; then the optional hubs, best rate first: {area:188} (about 35 a minute at full value), {area:186} (28), {area:442} (23). Every {faction:69} gain also gives a quarter as much to {zone:1453}, {zone:1455} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14725} 为 {faction:69} 接收布料；他站在 {faction:69} 东北的 {area:1659}，靠近裁缝。毛料、丝绸、魔纹布和 {item:14047} 各首次捐献 60 个，都能获得一次 150 点声望；完成 {item:14047} 的首次捐献后，可无限重复交还 {quest:7801}，每 20 个 {item:14047} 换 50 点。{area:1662} 的拍卖行是最快的布料来源。经典怀旧服中，任务最多比你低 5 级时仍给予完整声望，所以升级经过 {zone:1438}（1-12 级）、{zone:1439}（11-20 级）和 {zone:1440}（18-30 级）时就做完当地任务。捐献之后是 {zone:1428} 的 {quest:4183} 和另一项可重复交还的 {item:11040}；之后是可选任务点，按效率从高到低为：{area:188}（完整奖励时约每分钟 35 点）、{area:186}（28 点）、{area:442}（23 点）。除 1-10 级起始地区的任务外，每次获得 {faction:69} 声望，还会同时给 {zone:1453}、{zone:1455} 和诺莫瑞根流亡者各增加其四分之一的声望。传承天赋“外交家”使每次获取量最多额外提高 10%。",
	-- {item:2592} Wool Cloth · {zone:1439} Darkshore · {zone:1440} Ashenvale
	["{item:2592}: furbolgs, satyrs and naga in {zone:1439} and {zone:1440}"] = "{item:2592}：来自 {zone:1439} 和 {zone:1440} 的熊怪、萨特与纳迦。",

	-- Step 2: Shadowglen
	-- {zone:1438} Teldrassil · {area:256} Aldrassil
	["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation in 30 minutes at 60. The givers stand around {area:256}, the great tree. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 3: Shadowglen: the glade and the spider den
	-- {area:188} Shadowglen
	["{area:188}: the glade and the spider den"] = "{area:188}：林地与蜘蛛巢穴",
	-- {area:256} Aldrassil · {item:3297} Fel Moss · {npc:8584} Iverron
	["The nightsabers and boars roam the glade; the grells around {area:256} drop the {item:3297}; the totems stand in the furbolg camp north-west of the tree; the Webwood spiders live in the cave north of the glade. {npc:8584} waits outside that cave."] = "夜刃豹和野猪在林间空地游荡；{area:256} 周围的劣魔会掉落 {item:3297}；图腾位于大树西北方的熊怪营地；树林北侧洞穴中有树林蜘蛛。{npc:8584} 在那座洞穴外等待。",

	-- Step 4: Shadowglen: first hand-in
	-- {area:188} Shadowglen
	["{area:188}: first hand-in"] = "{area:188}：首次交还",

	-- Step 5: Shadowglen: the egg and the antidote
	-- {area:188} Shadowglen
	["{area:188}: the egg and the antidote"] = "{area:188}：卵与解毒剂",
	-- {quest:917} Webwood Egg · {item:10640} Webwood Ichor
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["The {quest:917} lies at the back of the spider cave; the mushrooms grow by the trees, the lilies by the pools, and the {item:10640} drops from the Webwood Lurkers."] = "{quest:917} 在蜘蛛洞穴深处；蘑菇长在树旁，百合长在水池旁，{item:10640} 由树林潜伏者掉落。",

	-- Step 6: Shadowglen: last hand-in
	-- {area:188} Shadowglen
	["{area:188}: last hand-in"] = "{area:188}：最后一次交任务",
	-- {npc:8584} Iverron
	["{npc:8584}, outside the spider cave"] = "{npc:8584}，在蜘蛛洞外",

	-- Step 7: Dolanaar
	-- {faction:69} Darnassus
	["Optional: the village on the road to {faction:69}, about 1,250 reputation in 45 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 8: Dolanaar: Denalan and the lake
	-- {area:186} Dolanaar · {npc:2080} Denalan
	["{area:186}: {npc:2080} and the lake"] = "{area:186}：{npc:2080} 和湖泊。",
	-- {npc:2080} Denalan · {area:259} Lake Al'Ameth · {npc:2107} Gaerolas Talvethren · {area:260} Starbreeze Village · {area:186} Dolanaar
	["{npc:2080} tends his garden on the south-east shore of {area:259}; {npc:2107} stands upstairs in a house in {area:260}, east of {area:186}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2080}在{area:259}东南岸照料他的花园；{npc:2107}在{area:186}东边{area:260}一座房子的楼上：从屋内上楼，箭头无法区分楼层。",

	-- Step 9: Dolanaar: the woods around the village
	-- {area:186} Dolanaar
	["{area:186}: the woods around the village"] = "{area:186}：村庄周围的林地。",
	-- {faction:69} Darnassus · {npc:2038} Lord Melenas · {area:258} Fel Rock · {npc:2107} Gaerolas Talvethren
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["The timberlings by the lake drop seeds and sprouts; the Gnarlpine Ambushers lurk on the road west to {faction:69}; {npc:2038} waits deep in {area:258}, north-west of the village; the dreamcatcher lies in the furbolg camp east of the village, by {npc:2107}; the Nightsabers west of the village carry the pelts."] = "湖边的林精会掉落种子和新芽；瘤背伏击者潜伏在向西通往 {faction:69} 的路上；{npc:2038} 在村庄西北方 {area:258} 的深处等候；捕梦网在村庄东边、{npc:2107} 旁的熊怪营地里；村庄西边的夜刃豹带着所需毛皮。",

	-- Step 10: Dolanaar: first hand-in
	-- {area:186} Dolanaar
	["{area:186}: first hand-in"] = "{area:186}：首次交还",

	-- Step 11: Dolanaar: the Ban'ethil Barrow Den's entrance
	-- {area:186} Dolanaar · {area:262} Ban'ethil Barrow Den
	["{area:186}: the {area:262}'s entrance"] = "",

	-- Step 12: Dolanaar: the relics and Ferocitas
	-- {area:186} Dolanaar
	["{area:186}: the relics and Ferocitas"] = "{area:186}：遗物和菲罗斯。",
	-- {area:262} Ban'ethil Barrow Den · {area:186} Dolanaar
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["The four relics of Wakening lie in the {area:262}, south-west of {area:186}; Ferocitas and the Gnarlpine Mystics camp east of the village."] = "四件唤醒遗物位于 {area:186} 西南的 {area:262}；菲罗斯塔和瘤背秘法师驻扎在村落东边。",
	-- {item:8050} Tallonkai's Jewel · {quest:2459} Ferocitas the Dream Eater
	["{item:8050}, from {quest:2459}"] = "{item:8050}，来自{quest:2459}",

	-- Step 13: Dolanaar: Ursal the Mauler
	-- {quest:486} Ursal the Mauler · {area:478} Pools of Arlithrien · {zone:1438} Teldrassil
	["{quest:486}, a big bear, roams the {area:478} in south-west {zone:1438}."] = "{quest:486} 是一只大熊，在 {zone:1438} 西南部的 {area:478} 游荡。",

	-- Step 14: Auberdine
	-- {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village
	["Optional: {area:442} in {zone:1439}, a boat trip from {area:702}, about 1,400 reputation in an hour at 60. The givers stand along the town's street and pier. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 15: Auberdine: the coast and the woods
	-- {area:442} Auberdine
	["{area:442}: the coast and the woods"] = "{area:442}：海岸和树林",
	-- {area:445} Cliffspring Falls
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["The furbolg camp south of town counts for How Big a Threat; the Rabid Thistle Bears roam the woods south of town; the Highborne ghosts of the Ruins of Ameth'Aran, south-east of town, carry the relics, and Anaya's ghost walks there too; the bones lie on the beach south of town; the mushrooms grow in the {area:445} cave to the north-east."] = "镇子南边的熊怪营地可完成 熊怪的威胁；狂暴蓟熊在镇子南边的森林中游荡；镇子东南方亚米萨兰废墟中的上层精灵幽灵带着遗物，安娜雅的幽灵也在那里走动；骸骨在镇子南边的海滩上；蘑菇长在东北方 {area:445} 的洞穴里。",
	-- {npc:2164} Rabid Thistle Bear · {quest:2139} Tharnariun's Hope · {npc:3701} Tharnariun Treetender
	["{npc:2164}: use {quest:2139} on it and lead it back to {npc:3701}"] = "",
	-- {npc:2164} Rabid Thistle Bear
	["Capture a {npc:2164}"] = "",
	-- {quest:954} Bashal'Aran
	["the blue aura in the ruins of {quest:954}"] = "{quest:954} 废墟中的蓝色光环",

	-- Step 16: Auberdine: first hand-in
	-- {area:442} Auberdine
	["{area:442}: first hand-in"] = "{area:442}：首次交还",

	-- Step 17: Auberdine: the furbolgs, the bears and the grells
	-- {area:442} Auberdine
	["{area:442}: the furbolgs, the bears and the grells"] = "{area:442}：熊怪、熊和小劣魔",
	-- {quest:955} Bashal'Aran
	["The Blackwood furbolgs camp south of town; the grells of {quest:955}, east of town, drop the earrings; the sea turtle remains lie on the beach west of town."] = "黑木熊怪在镇子南面扎营；镇子东面的{quest:955}小劣魔会掉落耳环；海龟遗骸在镇子西面的沙滩上。",

	-- Step 18: Auberdine: second hand-in
	-- {area:442} Auberdine
	["{area:442}: second hand-in"] = "{area:442}：第二次交还",

	-- Step 19: Auberdine: the seal, the Den Mother and the pelts
	-- {area:442} Auberdine · {npc:6788} Den Mother
	["{area:442}: the seal, the {npc:6788} and the pelts"] = "{area:442}：封印、{npc:6788} 和毛皮",
	-- {item:5338} Ancient Moonstone Seal · {quest:956} Bashal'Aran · {npc:6788} Den Mother · {zone:1439} Darkshore
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The {item:5338} drops from the satyrs of {quest:956}; destroy the seal at the flame there. The {npc:6788} lairs north-east of {quest:956}; the Moonstalker Sires and Matriarchs roam the south of {zone:1439}."] = "{item:5338} 由 {quest:956} 的萨特掉落；在那里的火焰处摧毁封印。{npc:6788} 栖息在 {quest:956} 东北；月夜雄虎和月夜雌虎则在 {zone:1439} 南部游荡。",
	["the seal at the ancient flame"] = "远古火焰处的封印。",

	-- Step 20: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1440} Ashenvale
	["{item:4306} drops from humanoids level 23 to 40: the satyrs and furbolgs of {zone:1440}, the Thistlefur and Foulweald camps, the Grimtotem of Stonetalon."] = "{item:4306}由23至40级人型生物掉落：{zone:1440}的萨特和熊怪、蓟皮和污林营地，以及石爪山脉的恐怖图腾成员。",

	-- Step 21: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1444} Feralas · {zone:1446} Tanaris
	["{item:4338} drops from humanoids level 35 to 50: the Hatecrest naga and Gordunni ogres of {zone:1444}, the Dunemaul ogres of {zone:1446}."] = "{item:4338} 由35至50级人型生物掉落：{zone:1444} 的憎世纳迦和戈杜尼食人魔，以及 {zone:1446} 的砂槌食人魔。",

	-- Step 22: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7801} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}, the Scourge cultists of the Plaguelands. Keep any {item:14047} past the first 60 for {quest:7801}."] = "{item:14047} 由50级及以上人型生物掉落：{zone:1448} 的死木熊怪、{zone:1452} 的冬泉熊怪，以及瘟疫之地的天灾教徒。最初60块之外的 {item:14047} 请保留，用于 {quest:7801}。",

	-- Step 23: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {faction:69} Darnassus · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: 175 {faction:69} reputation for two quests (level 54: in Classic 140 at 60), and the chain goes on to {object:2117} for 175 {zone:1453}. The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{zone:1428}东南部{area:2418}的{npc:9562}提供{quest:4183}：两个任务共175点{faction:69}声望（任务54级：经典旧世中60级时为140），后续任务链会前往{object:2117}，奖励175点{zone:1453}声望。黑色小龙和{npc:7044}在岗哨北面的山坡活动；{npc:7040}和{npc:7041}在岗哨以西、地区中央。",

	-- Step 24: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {faction:69} Darnassus · {npc:7916} Erelas Ambersky · {area:702} Rut'theran Village · {zone:1452} Winterspring · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands · {item:12663} Glyphed Oaken Branch
	["{npc:344} waits in the town hall of {area:69}; his next quest takes you to {object:2117} (the {zone:1453} guide follows it). Other {faction:69} quests at this level, for when you pass by: {npc:7916} in {area:702} has a wildkin chain into {zone:1452} (325 in all, with Ranshalla's escort), Arei's escort in {zone:1448} pays 150 after the {area:2479}'s chain, {npc:10739} at the {area:202} in the {zone:1422} 100 for the {item:12663}, and Put Her Down in Upper Blackrock Spire 100 with a group."] = "{npc:344} 在 {area:69} 的市政厅等你；他的下一个任务会让你前往 {object:2117}（{zone:1453} 指南会继续跟进）。此等级段沿途可做的其他 {faction:69} 任务：{area:702} 的 {npc:7916} 提供通往 {zone:1452} 的枭兽任务链（连同兰莎尔拉的护送共 325 点）；完成 {area:2479} 的任务链后，{zone:1448} 的埃雷护送任务提供 150 点；{zone:1422} 的 {area:202} 中的 {npc:10739} 收取 {item:12663}，提供 100 点；黑石塔上层的“座狼之源”组队完成可获得 100 点。",

	-- Step 25: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040}（可选）",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain · {npc:6735} Innkeeper Saelienne · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50: 220. {npc:6735} sends you to {npc:3516} in the {area:1658}; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "",

	-- Step 28: Un'Goro Crater: Un'Goro Soil
	-- {quest:3764} Un'Goro Soil · {item:11040} Morrowgrain
	["Dig {quest:3764} from the dirt mounds all over the crater; most of the crater's beasts and the Gorishi silithids drop it too, about one kill in three. Take far more than 20: every pouch use takes 2, about 18 for each 10 {item:11040}."] = "从环形山各处的土堆挖取{quest:3764}；环形山大部分野兽和格里什异种虫也会掉落，概率约三只出一个。不要只拿20个，要多拿很多：每次使用小袋消耗2个，每获取10个{item:11040}约消耗18个。",

	-- Step 29: Darnassus: Morrowgrain Research
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker · {item:11020} Evergreen Pouch · {quest:3764} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9047}, beside Fandral in the {area:1658}, takes the soil. {npc:4217} sells the {item:11020} and Packets of Tharlendris Seeds. With a seed packet and 2 {quest:3764} in your bags, use the pouch to grow an {item:11024} and open it: about one casing in three holds {item:11040} (1 to 5), the rest other herbs. The pouch works once every 10 minutes, so use it whenever it is ready while you do other things."] = "{area:1658} 的范达尔身边，{npc:9047} 会收下泥土。{npc:4217} 出售 {item:11020} 和萨伦迪斯种子包。背包里带着一包种子和 2 个 {quest:3764} 时，使用种植袋长出 {item:11024}，再打开：约三分之一的果壳里有 {item:11040}（1 至 5 个），其余是其他草药。种植袋每 10 分钟能用一次，所以做其他事情时，冷却一好就用。",

	-- Step 33: Darnassus: Morrowgrain Research
	-- {item:11040} Morrowgrain
	["{item:11040}: grow it here and open the casings"] = "{item:11040}：在这里种植，并打开外壳",

	-- Step 34: Morrowgrain to Darnassus
	-- {item:11040} Morrowgrain · {npc:4217} Mathrengyl Bearwalker · {quest:3764} Un'Goro Soil · {item:14047} Runecloth · {npc:7879} Quintis Jonespyre · {area:1116} Feathermoon Stronghold · {zone:1444} Feralas
	["Every 10 {item:11040}: 50 reputation at {npc:4217}. Keep the pouch and buy seeds as you go. It is slow: about 9 casings, 90 minutes of pouch waits, 18 {quest:3764} and 9 seed packets for each hand-in, a little over 30 reputation an hour, so run it beside the {item:14047}. {npc:7879} at {area:1116} in {zone:1444} takes {item:11040} at the same rate, 25 for 5, after his own quest."] = "每10份 {item:11040} 可在 {npc:4217} 处换50声望。保留种子袋，沿途购买种子。进度很慢：每次交还大约需要9份壳、90分钟的种子袋等待时间、18次 {quest:3764} 和9包种子，每小时仅略高于30声望，所以应与收集 {item:14047} 同时进行。{zone:1444} 的 {area:1116} 内的 {npc:7879} 在完成自己的任务后，也以相同比例收取 {item:11040}，每5份换25声望。",

	-- Step 35: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801}刷到尊敬",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {quest:4183} The True Masters · {item:11040} Morrowgrain · {faction:69} Darnassus · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {zone:1444} Feralas
	["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), {area:415} in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 36: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801}刷到崇敬",
	-- {item:14047} Runecloth
	["Honored: in Classic Darnassus's vendors take 10% off for you, Lelanai's nightsabers (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "尊敬：经典怀旧服中，达纳苏斯商人会给你 10% 折扣，包括莱兰奈出售的夜刃豹（20 金币，迅捷型 200 金币）；无限尚未确定，指南网站报告为友善 5%，逐步提高到崇拜 20%。尊敬到崇敬需要 12,000 点声望：交还 240 次，共 4,800 个 {item:14047}。",

	-- Step 37: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801}刷到崇拜",
	-- {item:14047} Runecloth · {area:1658} Cenarion Enclave · {faction:69} Darnassus
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, Lelanai at the {area:1658} in {faction:69} sells her nightsabers to other races in Classic; the Saber and Swift Saber guides cover them."] = "崇敬到崇拜需要21,000声望：交还420次，共8,400个{item:14047}。经典旧世中，达到崇拜后，{faction:69}的{area:1658}里的莱兰奈会向其他种族出售夜刃豹；“豹”和“迅捷豹”指南有相应说明。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439} (in Classic, a fifth of it at 60)"] = "{zone:1438}和{zone:1439}的低等级任务约给3,700点{faction:69}声望（经典版中60级时只有五分之一）",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "这里的黑暗教徒和暗影法师（58-60级）会掉落；在这里击杀天灾军团也会提升{object:92525}声望（见该指南）。也可以去拍卖行购买。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "这里的砂槌食人魔（45-48级）会掉落。也可以去拍卖行购买。",
	-- ["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7801}，直到{faction:69}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7801}，每次20块{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation (210 at a fifth) in 30 minutes at 60. The givers stand around {area:256}, the great tree. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{zone:1438}东北面的暗夜精灵初始林地，60级时约30分钟可获得1,050声望（五分之一时为210）。任务给予者都在大树{area:256}周围。经典旧世中，比你低至少6级的任务奖励会减少（60级时为五分之一）；一份无限测试版报告称其奖励全额声望。第一次交还任务即可确认：若只有五分之一，就跳过这些任务区。跳过本步骤即可跳过整个任务区。",
	-- ["Optional: the village on the road to {faction:69}, about 1,250 reputation (250 at a fifth) in 45 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：通往 {faction:69} 的道路上的村庄，60 级时花约 45 分钟可获得约 1,250 点声望（按五分之一计算为 250 点）。在经典旧世中，比你低至少 6 级的任务声望奖励会减少（60 级时降至五分之一）；一份无限测试版报告称，任务仍提供全额声望。第一次交还任务时就能看出：如果只给五分之一，就跳过这些任务点。跳过本步骤即可跳过这个任务点。",
	-- ["Optional: {area:442} in {zone:1439}, a boat trip from {area:702}, about 1,400 reputation (280 at a fifth) in an hour at 60. The givers stand along the town's street and pier. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{zone:1439} 的 {area:442}，从 {area:702} 坐船可到，60级时约一小时获得1,400点声望（若只有五分之一则为280点）。任务给予者站在镇子街道和码头沿线。经典版中，低于你6级或更多的任务奖励会减少（60级时为五分之一）；一份无限服测试报告称会给全额声望。首次交还即可判断：如果只有五分之一，就跳过这些任务点。跳过此步骤即可跳过该任务点。",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "这里的河爪强盗和河爪监工（16-18级）会掉落。也可以去拍卖行购买。",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "激流堡的辛迪加雇佣兵（31-32级）会掉落。也可以去拍卖行购买。",
	-- ["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725}在{faction:69}收取布料以提升{faction:69}声望。首次捐献毛料、丝绸、魔纹布和{item:14047}（各60块）只能做一次，每块布给的声望最多；之后{quest:7801}可重复做到崇拜。与其他种族的主城达到崇拜后，可购买该种族的坐骑。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14725}: {item:14047} delivered"] = "{npc:14725}：已交付{item:14047}",
	-- ["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50 (in Classic a fifth at 60): 220 at full. {npc:6735} sends you to {npc:3516} in the {area:1658}; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "{quest:3803} 可无限重复，每次收取 10 个 {item:11040}，奖励 50 点声望，60 级仍给全额。前置任务链为 50 级任务（经典怀旧服中 60 级只得五分之一）：全额共 220 点。{npc:6735} 让你去 {area:1658} 找 {npc:3516}；他需要 20 个 {quest:3764}。（{zone:1453} 和 {zone:1455} 的旅店老板也提供相同的起始任务。）",
	-- ["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801}每次交还需要20块{item:14047}，可无限重复。按20的倍数带上{item:14047}，一次接一次全部交还。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off if it paid in full. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), {area:415} in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7801}：每20块{item:14047}换50声望，可无限重复。完成最初四次捐献后，人类、矮人或侏儒约为友善700/6,000，距尊敬还差5,300：需要交还106次、2,120块{item:14047}（暗夜精灵起点高900：需要88次；天裔从中立500开始，还差7,900：需要158次，完成联盟之旅后少两次）。{quest:4183}和上面的{item:11040}任务线可减少8次交布，之后每交10个{item:11040}又可再少一次；每完成一个任务点的任务，若按全额奖励，还可再少20到28次。更多任务会奖励{faction:69}声望，在任务等级低于自身不超过5级时可获全额：{zone:1439}其余任务（另约3,400）、{zone:1440}的{area:415}（约3,900），以及{zone:1444}的羽月要塞（约1,700）。每次获得主城声望，还会向其余三座联盟主城各溢出四分之一（此处未计入）。一次性交还所有{item:14047}。",
}
