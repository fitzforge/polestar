-- Chinese (simplified) (zhCN): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "铁炉堡声望",
	-- {zone:1428} Burning Steppes · {zone:1426} Dun Morogh · {area:133} Gnomeregan · {zone:1459} Alterac Valley
	["Cloth, the {zone:1428} quests and the {zone:1426} hubs, which pay {area:133} too; {zone:1459} adds more."] = "布料、{zone:1428}的任务和{zone:1426}的任务点（同时提升{area:133}声望）；{zone:1459}还能提供更多。",
	-- {faction:47} Ironforge
	["Exalted with {faction:47}: in Classic, other races may buy the rams"] = "{faction:47}达到崇拜：在经典版中，其他种族可购买山羊",
	-- {faction:47} Ironforge · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {zone:1459} Alterac Valley
	["About 600 {faction:47} reputation from level 52-59 quests in the {zone:1428} and {zone:1452}; {zone:1459}'s quests pay {faction:47} too"] = "{zone:1428}和{zone:1452}的52-59级任务约提供600点{faction:47}声望；{zone:1459}的任务也会提升{faction:47}声望",
	-- {faction:47} Ironforge · {zone:1426} Dun Morogh · {area:133} Gnomeregan
	["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to {area:133} too"] = "",

	-- Step 1: Mistina Steelshield, the cloth quartermaster
	-- {npc:14723} Mistina Steelshield
	["{npc:14723}, the cloth quartermaster"] = "布料军需官{npc:14723}",
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {object:32372} Great Forge · {item:14047} Runecloth · {quest:7806} Additional Runecloth · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {zone:1437} Wetlands · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {area:132} Coldridge Valley · {area:131} Kharanos · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14723} takes cloth for {faction:47}; she stands outside the clothier on the north side of the {object:32372}, among the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7806} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12), {zone:1432} (10-20) and the {zone:1437} (20-30) while you level through them. After the donations come the level 52-59 quests of the {zone:1428} and {zone:1452} (about 600), then the optional {zone:1426} hubs, best rate first: {area:132} (about 37 a minute at full value), {area:131} (26), the quarry (17). Every {faction:47} gain also gives a quarter as much to {zone:1453}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14723}接收布料，提供{faction:47}声望；她站在{object:32372}北侧服装店外的裁缝群中。毛料、丝绸、魔纹布和{item:14047}各首次捐赠60个时，分别一次性奖励150声望；完成{item:14047}的首次捐赠后，{quest:7806}每20个{item:14047}奖励50，可无限重复。平民区拍卖行是最快的布料来源。经典旧世中，任务比你低不超过5级时仍奖励全额声望，因此应在练级时顺路完成{zone:1426}（1-12级）、{zone:1432}（10-20级）及{zone:1437}（20-30级）。捐赠后先做{zone:1428}和{zone:1452}的52-59级任务（约600），再选做{zone:1426}任务区，按效率从高到低为：{area:132}（全额时每分钟约37）、{area:131}（26）、采石场（17）。每次获得{faction:47}声望时，{zone:1453}、{zone:1457}和诺莫瑞根流亡者也会获得四分之一，1-10级初始地区的任务除外。传承系统“外交家”使每次声望获取最多增加10%。",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592}：来自 {zone:1432} 和 {zone:1437} 的穴居人、豺狼人和狗头人。",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 3: Coldridge: wolves, troggs and Felix Whindlebolt's things
	-- {npc:8416} Felix Whindlebolt
	["Coldridge: wolves, troggs and {npc:8416}'s things"] = "寒脊山谷：狼、穴居人和 {npc:8416} 的物品。",
	-- {area:77} Anvilmar · {npc:8416} Felix Whindlebolt
	["The wolves roam the valley floor; the troggs dig in the camps east of {area:77}; {npc:8416}'s box, chest and bucket lie in the trogg camps."] = "狼在谷底活动；穴居人在{area:77}东侧的营地挖掘；{npc:8416}的盒子、箱子和水桶就在穴居人营地里。",

	-- Step 4: Coldridge: Anvilmar and Talin Keeneye
	-- {area:77} Anvilmar · {npc:714} Talin Keeneye
	["Coldridge: {area:77} and {npc:714}"] = "寒脊山谷：{area:77}和{npc:714}",

	-- Step 5: Coldridge: Grelin Whitebeard and the troll cave
	-- {npc:786} Grelin Whitebeard
	["Coldridge: {npc:786} and the troll cave"] = "寒脊山谷：{npc:786} 与巨魔洞穴",
	-- {npc:786} Grelin Whitebeard · {area:77} Anvilmar
	["{npc:786} camps south of {area:77}, at the mouth of the troll cave; the journal lies at the back of the cave."] = "{npc:786}在{area:77}南面的巨魔洞口扎营；日记在洞穴深处。",

	-- Step 6: Coldridge: the hot Mornbrew
	["Coldridge: the hot Mornbrew"] = "寒脊山谷：热腾腾的晨酒。",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew cools in five minutes: run straight to {npc:836} at {area:77}."] = "滚烫的晨酒五分钟后会变凉：直接跑到 {area:77} 找 {npc:836}。",

	-- Step 7: Coldridge: on to Kharanos
	-- {area:131} Kharanos
	["Coldridge: on to {area:131}"] = "寒脊山谷：前往 {area:131}",
	-- {npc:1252} Senir Whitebeard · {area:131} Kharanos
	["{npc:1252}, in {area:131}"] = "{npc:1252}，位于 {area:131}",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the inn"] = "{npc:6806}，在旅店里",

	-- Step 8: Kharanos
	-- {area:131} Kharanos · {area:133} Gnomeregan · {area:2102} Thunderbrew Distillery · {area:189} Steelgrill's Depot
	["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 9: Kharanos: the hills and the depot
	-- {area:131} Kharanos
	["{area:131}: the hills and the depot"] = "{area:131}：山丘与仓库",
	-- {area:131} Kharanos · {area:136} Grizzled Den · {area:133} Gnomeregan
	["The boars and bears roam around {area:131}; the wendigos live in the {area:136} south-west of town; the leper gnomes at the {area:133} road carry the cogs and gears; Rumbleshot's ammo lies at his camp west of town."] = "野猪和熊在{area:131}周围游荡；雪怪住在镇子西南面的{area:136}；{area:133}道路上的麻风侏儒携带两种齿轮；海格纳·重枪的弹药在镇子西面的营地。",

	-- Step 10: Kharanos: back in town
	-- {area:131} Kharanos
	["{area:131}: back in town"] = "{area:131}：回到镇上",

	-- Step 11: Kharanos: Brewnall and Frostmane Hold
	-- {area:131} Kharanos · {quest:287} Frostmane Hold
	["{area:131}: Brewnall and {quest:287}"] = "{area:131}：涌冰湖和 {quest:287}",
	-- {npc:1374} Rejold Barleybrew · {area:137} Brewnall Village · {area:131} Kharanos · {quest:287} Frostmane Hold
	["{npc:1374} stands by {area:137} on the lake north-west of {area:131}; {quest:287} is the troll cave west of it."] = "{npc:1374} 站在 {area:131} 西北方湖边的 {area:137} 旁；{quest:287} 位于其西边的巨魔洞穴。",
	["walk to the back of the cave"] = "走到洞穴深处。",

	-- Step 12: Kharanos: last hand-in
	-- {area:131} Kharanos
	["{area:131}: last hand-in"] = "{area:131}：最后一次交任务",

	-- Step 13: The quarry and Amberstill Ranch
	-- {area:803} Amberstill Ranch
	["The quarry and {area:803}"] = "采石场和 {area:803}。",
	-- {zone:1426} Dun Morogh · {npc:264936} Earthseer Farsen · {area:134} Gol'Bolar Quarry · {area:803} Amberstill Ranch
	["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation in 30 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 14: The quarry: troggs, spies and Vagash
	-- {npc:1388} Vagash
	["The quarry: troggs, spies and {npc:1388}"] = "采石场：穴居人、间谍和 {npc:1388}",
	-- {area:134} Gol'Bolar Quarry · {npc:1388} Vagash · {area:803} Amberstill Ranch
	["The Dark Iron Spies lurk around Farsen's camp; the troggs dig in the {area:134}; {npc:1388}, a big snow leopard, prowls the hills above {area:803}."] = "黑铁密探潜伏在法森的营地周围；穴居人在{area:134}挖掘；大雪豹{npc:1388}在{area:803}上方山丘游荡。",

	-- Step 15: The Reports
	-- {npc:1274} Senator Barin Redstone
	["{npc:1274}, in the throne room"] = "{npc:1274}，在王座厅内",

	-- Step 16: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1437} Wetlands
	["{item:4306} drops from humanoids level 23 to 40: the Dragonmaw of the {zone:1437}, the Syndicate of Alterac and Arathi, Stranglethorn's trolls."] = "{item:4306} 由23到40级人形生物掉落：{zone:1437} 的龙喉兽人、奥特兰克和阿拉希的辛迪加成员，以及荆棘谷的巨魔。",

	-- Step 17: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {object:147516} Dark Iron · {zone:1418} Badlands · {zone:1427} Searing Gorge · {zone:1446} Tanaris · {zone:1444} Feralas
	["{item:4338} drops from humanoids level 35 to 50: the Shadowforge and {object:147516} dwarves of the {zone:1418} and {zone:1427}, the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}."] = "{item:4338} 由 35 至 50 级的人型生物掉落：{zone:1418} 和 {zone:1427} 的暗炉矮人与 {object:147516} 矮人、{zone:1446} 的砂槌食人魔、{zone:1444} 的憎世纳迦。",

	-- Step 18: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7806} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7806}."] = "{item:14047} 由50级及以上人型生物掉落：瘟疫之地的天灾教徒和血色十字军、{zone:1448} 的死木熊怪，以及 {zone:1452} 的冬泉熊怪。最初60块之外的 {item:14047} 请保留，用于 {quest:7806}。",

	-- Step 19: Ironforge: Royal Historian Archesonus
	-- {faction:47} Ironforge · {npc:8879} Royal Historian Archesonus · {object:171709} High Seat · {zone:1428} Burning Steppes
	["These quests are level 52 to 59, so they pay in full at 60: about 600 {faction:47} reputation. {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "",
	-- {npc:8879} Royal Historian Archesonus
	["Hear {npc:8879} out"] = "听完{npc:8879}的话",

	-- Step 20: Morgan's Vigil: Oralius
	-- {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {npc:9177} Oralius · {area:249} Dreadmaul Rock
	["{area:2418} sits in the south-east of the {zone:1428}, at the top of the pass up from Redridge. {npc:9177} wants the Firegut ogres of {area:249}, north of the Vigil, thinned out; the Brutes keep to the rock's east side."] = "{area:2418} 位于 {zone:1428} 东南部，从赤脊山上来的山口顶端。{npc:9177} 要你削减岗哨北面 {area:249} 的火腹食人魔数量；蛮兵 聚集在岩石东侧。",

	-- Step 21: Thaurissan and Blackrock Stronghold
	-- {area:252} Blackrock Stronghold
	["Thaurissan and {area:252}"] = "索瑞森与{area:252}",
	-- {area:251} Flame Crest · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {item:11467} Blackrock Medallion · {npc:9177} Oralius · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["The Thaurissan relics are the carved stones in the ruins around {area:251}, west along the road: click twelve of them. {npc:9176} and the Blackrock orcs and worgs hold the camps at the foot of {area:254}, further west; each may drop a {item:11467} (about one kill in three), and {npc:9177} wants fifty. The orcs are level 50 and up, so they drop {item:14047} too: keep it for {quest:7806}."] = "索瑞森遗物是道路西边、{area:251} 周围遗迹里的雕刻石块：点击十二个。再往西，{npc:9176}、黑石兽人和座狼占据 {area:254} 山脚的营地；每只都可能掉落 {item:11467}（约三分之一），{npc:9177} 需要五十个。兽人是 50 级及以上，也会掉落 {item:14047}：留着用于 {quest:7806}。",

	-- Step 22: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418}：交任务",
	-- {npc:9176} Gor'tesh · {area:249} Dreadmaul Rock
	["Plant {npc:9176}'s head on the soft dirt mound at the top of {area:249}."] = "把 {npc:9176} 的头颅插在 {area:249} 顶部的松软土堆上。",

	-- Step 23: Ironforge: Archesonus again
	-- {faction:47} Ironforge
	["{faction:47}: Archesonus again"] = "{faction:47}：再次找阿克鲁努斯。",
	-- {area:1584} Blackrock Depths · {npc:9021} Kharan Mighthammer · {npc:9177} Oralius · {zone:1459} Alterac Valley · {faction:47} Ironforge · {item:17542} Coldtooth Supplies
	-- plural, as words: Dark Iron Fanny Packs = {item:11468} Dark Iron Fanny Pack · Storm Crystals = {item:17423} Storm Crystal
	["With a group, {area:1584} pays more: Archesonus's chain goes on with {npc:9021} (100) and The Fate of the Kingdom (Emperor Thaurissan, 150), and {npc:9177} takes 20 Dark Iron Fanny Packs from the dwarves inside (The Good Stuff, 100). {zone:1459}, from level 51, pays {faction:47} too: its one-time quests about 1,900 as your Stormpike standing grows (the {zone:1459} guide walks them), and inside the battle 25 for every 10 Irondeep or {item:17542} and 50 for 5 Storm Crystals, as often as you like."] = "组队前往{area:1584}可获得更多：皇家历史学家阿克瑟努斯的任务线后续有{npc:9021}（100）和“王国的命运”（索瑞森大帝，150），{npc:9177}还会收取里面矮人掉落的20个黑铁挎包（“好东西”，100）。51级起可参加的{zone:1459}也奖励{faction:47}声望：随着雷矛声望提升，一次性任务共约1,900（{zone:1459}指南会带你完成）；战场内每交10个深铁矿洞补给品或{item:17542}奖励25声望，每交5个风暴水晶奖励50声望，可无限重复。",

	-- Step 24: Winterspring: Enraged Wildkin
	-- {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village · {area:2245} Mazthoril · {faction:47} Ironforge
	["{npc:11755} in {area:2255} sends you west to {npc:10301} at {area:2253}. {npc:10301}'s damaged crate and wrecked wagon lie at {area:2245}, down the valley to the south-east; his supplies lie around the wagon and the owlbeasts nearby carry his amulet. The last quest is level 59: 100 {faction:47} in full."] = "{area:2255} 的 {npc:11755} 会让你向西去找 {area:2253} 的 {npc:10301}。{npc:10301} 损坏的箱子和货车残骸位于东南方山谷下方的 {area:2245}；物资散落在货车周围，附近枭兽携带着他的护符。最后一个任务为 59 级：可获得全额的 100 点 {faction:47} 声望。",

	-- Step 25: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806}刷到尊敬",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1426} Dun Morogh · {faction:47} Ironforge · {area:144} Thelsamar · {zone:1432} Loch Modan · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1459} Alterac Valley
	["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: {area:144} in {zone:1432} (about 3,500 in all) and {area:150} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 26: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806}刷到崇敬",
	-- {npc:1261} Veron Amberstill · {item:14047} Runecloth
	["Honored: in Classic Ironforge's vendors take 10% off for you, {npc:1261}'s rams (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "尊敬：经典怀旧服中，铁炉堡商人会给你 10% 折扣，包括 {npc:1261} 出售的山羊（20 金币，迅捷型 200 金币）；无限尚未确定，指南网站报告为友善 5%，逐步提高到崇拜 20%。尊敬到崇敬需要 12,000 点声望：交还 240 次，共 4,800 个 {item:14047}。",

	-- Step 27: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806}刷到崇拜",
	-- {item:14047} Runecloth · {npc:1261} Veron Amberstill · {area:803} Amberstill Ranch · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:1261} at {area:803} in eastern {zone:1426} sells his rams to other races in Classic; the Ram and Swift Ram guides cover them."] = "崇敬到崇拜需要21,000声望：交还420次、8,400块{item:14047}。经典版中，崇拜后{zone:1426}东部{area:803}的{npc:1261}会向其他种族出售山羊；山羊和迅捷山羊指南有详细说明。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to {area:133} too (in Classic, a fifth of it at 60)"] = "{zone:1426}的低等级任务约提供2,900点{faction:47}声望，大部分同时提升{area:133}声望（在经典版中，60级时只有五分之一）",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "这里的黑暗教徒和暗影法师（58-60级）会掉落；在这里击杀天灾军团也会提升{object:92525}声望（见该指南）。也可以去拍卖行购买。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "这里的砂槌食人魔（45-48级）会掉落。也可以去拍卖行购买。",
	-- ["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7806}，直到{faction:47}达到崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7806}，每次20块{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation (100 at a fifth) in 30 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{zone:1426} 东部，从 {npc:264936} 的营地到 {area:134} 和 {area:803}，60级时约30分钟获得500点声望（若只有五分之一则为100点）。经典版中，低于你6级或更多的任务奖励会减少（60级时为五分之一）；一份无限服测试报告称会给全额声望。首次交还即可判断：如果只有五分之一，就跳过这些任务点。跳过此步骤即可跳过该任务点。",
	-- ["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation (220 at a fifth) in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{area:131} 西南面的矮人和侏儒起始山谷，60级时约30分钟可得1,100声望（若按五分之一则为220）。{npc:658} 和 {npc:713} 站在 {area:77}。在经典旧世中，低于你6级及以上的任务奖励会减少（60级时为五分之一）；一份无限服测试版反馈称仍获得全额。第一次交还就能看出实际情况：如果只有五分之一，跳过这些任务据点。跳过此步骤即可跳过这个据点。",
	-- ["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation (260 at a fifth) in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{area:131} 及周围通往涌冰湖和 {area:133} 的道路，60 级时花约 50 分钟可获得约 1,300 点声望（按五分之一计算为 260 点）。大多数任务给予者在 {area:2102} 内外及其东侧的 {area:189}。在经典旧世中，比你低至少 6 级的任务声望奖励会减少（60 级时降至五分之一）；一份无限测试版报告称，任务仍提供全额声望。第一次交还任务时就能看出：如果只给五分之一，就跳过这些任务点。跳过本步骤即可跳过这个任务点。",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "这里的河爪强盗和河爪监工（16-18级）会掉落。也可以去拍卖行购买。",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "激流堡的辛迪加雇佣兵（31-32级）会掉落。也可以去拍卖行购买。",
	-- ["These quests are level 52 to 59, so they pay in full at 60, or nearly: about 600 {faction:47} reputation (in Classic about 450 at 60, as the {zone:1428} ones are level 52 to 54). {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "这些任务为52到59级，因此60级时仍可获得全额或接近全额的奖励：约600点{faction:47}声望（经典版中60级时约450，因为{zone:1428}的任务为52到54级）。{npc:8879}站在{object:171709}的麦格尼国王旁；他会派你去{zone:1428}的索瑞森废墟。",
	-- ["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723}在{faction:47}收取布料以提升{faction:47}声望。首次捐献毛料、丝绸、魔纹布和{item:14047}（各60块）只能做一次，每块布给的声望最多；之后{quest:7806}可重复做到崇拜。与其他种族的主城达到崇拜后，可购买该种族的坐骑。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14723}: {item:14047} delivered"] = "{npc:14723}：已交付{item:14047}",
	-- ["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806}每次交还需要20块{item:14047}，可无限重复。按20的倍数带上{item:14047}，一次接一次全部交还。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off if it paid in full. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: {area:144} in {zone:1432} (about 3,500 in all) and {area:150} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7806}：用20块 {item:14047} 换取50点声望，可无限次交还。完成最初四次捐赠后，人类、暗夜精灵或侏儒会达到友善6,000中的700点，距离尊敬还差5,300点：需交还106次，共2,120块 {item:14047}（矮人起点高900：需88次；天裔起始为中立2,000点，因此还差6,400点：需128次，完成 联盟之旅 后再少两次）。上面的52—59级任务可减少12次交还；每个已完成的 {zone:1426} 任务点，若奖励全额声望，还能再减少10到26次。还有更多任务点奖励 {faction:47} 声望，只要任务等级比你低不超过5级，就能获得全额：{zone:1432} 的 {area:144}（总计约3,500点）以及 {zone:1437} 的 {area:150}（约2,500点）。51级起，{zone:1459} 的一次性任务还能增加约1,900点。每次主城声望提升还会为其余三座联盟主城提供四分之一的声望（此处未计入）。把所有 {item:14047} 一次交完。",
}
