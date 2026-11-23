-- Chinese (traditional) (zhTW): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "鐵爐堡聲望",
	-- {zone:1428} Burning Steppes · {zone:1426} Dun Morogh · {area:133} Gnomeregan · {zone:1459} Alterac Valley
	["Cloth, the {zone:1428} quests and the {zone:1426} hubs, which pay {area:133} too; {zone:1459} adds more."] = "布匹、{zone:1428}的任務和{zone:1426}的各任務點，同時也會給{area:133}；{zone:1459}還能再加一些。",
	-- {faction:47} Ironforge
	["Exalted with {faction:47}: in Classic, other races may buy the rams"] = "{faction:47}達到崇拜：在經典版中，其他種族可購買山羊",
	-- {faction:47} Ironforge · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {zone:1459} Alterac Valley
	["About 600 {faction:47} reputation from level 52-59 quests in the {zone:1428} and {zone:1452}; {zone:1459}'s quests pay {faction:47} too"] = "{zone:1428}和{zone:1452}的52-59級任務約提供600點{faction:47}聲望；{zone:1459}的任務也會提升{faction:47}聲望",
	-- {faction:47} Ironforge · {zone:1426} Dun Morogh · {area:133} Gnomeregan
	["About 2,900 {faction:47} reputation from low-level quests in {zone:1426}, most of it paid to {area:133} too"] = "{zone:1426}的低階任務約2,900點{faction:47}聲望，其中大部分也給{area:133}",

	-- Step 1: Mistina Steelshield, the cloth quartermaster
	-- {npc:14723} Mistina Steelshield
	["{npc:14723}, the cloth quartermaster"] = "{npc:14723}，布匹軍需官",
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {object:32372} Great Forge · {item:14047} Runecloth · {quest:7806} Additional Runecloth · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {zone:1437} Wetlands · {zone:1428} Burning Steppes · {zone:1452} Winterspring · {area:132} Coldridge Valley · {area:131} Kharanos · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14723} takes cloth for {faction:47}; she stands outside the clothier on the north side of the {object:32372}, among the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7806} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12), {zone:1432} (10-20) and the {zone:1437} (20-30) while you level through them. After the donations come the level 52-59 quests of the {zone:1428} and {zone:1452} (about 600), then the optional {zone:1426} hubs, best rate first: {area:132} (about 37 a minute at full value), {area:131} (26), the quarry (17). Every {faction:47} gain also gives a quarter as much to {zone:1453}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14723}為{faction:47}收布；她站在{object:32372}北側裁縫店外，混在裁縫中間。首次各捐60個毛料、絲綢、魔紋布和{item:14047}，每次給150點聲望；交完{item:14047}那次後，{quest:7806}每20個{item:14047}給50點，想交多少次都行。公共區的拍賣行是最快的布匹來源。經典舊世裡，只要任務最多低於你5級，就按全額給聲望，所以練級時做{zone:1426}（1-12級）、{zone:1432}（10-20級）和{zone:1437}（20-30級）。捐贈之後是{zone:1428}和{zone:1452}的52-59級任務（約600點），然後是可選{zone:1426}任務點，按效率從高到低：{area:132}（全額時每分鐘約37）、{area:131}（26）、採石場（17）。每一份{faction:47}聲望收益還會以四分之一的比例給{zone:1453}、{zone:1457}和諾莫瑞根流亡者，1-10級新手區的任務除外。傳承外交官能讓每份收益最多提高10%。",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592}：{zone:1432}和{zone:1437}的穴居人、豺狼人和狗頭人",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,100 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "可選：{area:131}西南的矮人和地精新手山谷，60級時30分鐘約1,100點聲望。{npc:658}和{npc:713}站在{area:77}。Forever 裡這些舊任務任何等級都足額給分。跳過這一步就跳過這個點。",

	-- Step 3: Coldridge: wolves, troggs and Felix Whindlebolt's things
	-- {npc:8416} Felix Whindlebolt
	["Coldridge: wolves, troggs and {npc:8416}'s things"] = "寒脊山谷：狼、穴居人和{npc:8416}的東西",
	-- {area:77} Anvilmar · {npc:8416} Felix Whindlebolt
	["The wolves roam the valley floor; the troggs dig in the camps east of {area:77}; {npc:8416}'s box, chest and bucket lie in the trogg camps."] = "狼在山谷底部遊蕩；穴居人在{area:77}東邊的營地挖掘；{npc:8416}的箱子、木箱和水桶在穴居人營地裡。",

	-- Step 4: Coldridge: Anvilmar and Talin Keeneye
	-- {area:77} Anvilmar · {npc:714} Talin Keeneye
	["Coldridge: {area:77} and {npc:714}"] = "寒脊山谷：{area:77}和{npc:714}",

	-- Step 5: Coldridge: Grelin Whitebeard and the troll cave
	-- {npc:786} Grelin Whitebeard
	["Coldridge: {npc:786} and the troll cave"] = "寒脊山谷：{npc:786}和食人妖洞",
	-- {npc:786} Grelin Whitebeard · {area:77} Anvilmar
	["{npc:786} camps south of {area:77}, at the mouth of the troll cave; the journal lies at the back of the cave."] = "{npc:786}在{area:77}以南紮營，就在食人妖洞口；手記在洞穴深處。",

	-- Step 6: Coldridge: the hot Mornbrew
	["Coldridge: the hot Mornbrew"] = "寒脊山谷：滾燙的晨釀",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew cools in five minutes: run straight to {npc:836} at {area:77}."] = "滾燙的晨釀五分鐘後就會涼：直接跑到{area:77}的{npc:836}那裡。",

	-- Step 7: Coldridge: on to Kharanos
	-- {area:131} Kharanos
	["Coldridge: on to {area:131}"] = "寒脊山谷：前往{area:131}",
	-- {npc:1252} Senir Whitebeard · {area:131} Kharanos
	["{npc:1252}, in {area:131}"] = "{npc:1252}，在{area:131}",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the inn"] = "{npc:6806}，在旅店裡",

	-- Step 8: Kharanos
	-- {area:131} Kharanos · {area:133} Gnomeregan · {area:2102} Thunderbrew Distillery · {area:189} Steelgrill's Depot
	["Optional: {area:131} and the Brewnall and {area:133} roads around it, about 1,300 reputation in 50 minutes at 60. Most givers stand in and around the {area:2102} and at {area:189} east of it. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "可選：{area:131}以及周圍的不來梅爾和{area:133}道路，60級時50分鐘約1,300點聲望。發任務的多在{area:2102}內外和它以東的{area:189}。Forever 裡這些舊任務任何等級都足額給分。跳過這一步就跳過這個點。",

	-- Step 9: Kharanos: the hills and the depot
	-- {area:131} Kharanos
	["{area:131}: the hills and the depot"] = "{area:131}：山丘與補給站",
	-- {area:131} Kharanos · {area:136} Grizzled Den · {area:133} Gnomeregan
	["The boars and bears roam around {area:131}; the wendigos live in the {area:136} south-west of town; the leper gnomes at the {area:133} road carry the cogs and gears; Rumbleshot's ammo lies at his camp west of town."] = "野豬和熊在{area:131}周圍遊蕩；溫迪戈住在小鎮西南的{area:136}；{area:133}路上的麻風地精帶著齒輪和零件；朗布林肖特的彈藥在他的營地、小鎮西邊。",

	-- Step 10: Kharanos: back in town
	-- {area:131} Kharanos
	["{area:131}: back in town"] = "{area:131}：回到鎮上",

	-- Step 11: Kharanos: Brewnall and Frostmane Hold
	-- {area:131} Kharanos · {quest:287} Frostmane Hold
	["{area:131}: Brewnall and {quest:287}"] = "{area:131}：布瑞恩諾爾和{quest:287}",
	-- {npc:1374} Rejold Barleybrew · {area:137} Brewnall Village · {area:131} Kharanos · {quest:287} Frostmane Hold
	["{npc:1374} stands by {area:137} on the lake north-west of {area:131}; {quest:287} is the troll cave west of it."] = "{npc:1374}站在{area:131}西北湖邊{area:137}旁；{quest:287}在它西邊的食人妖洞。",
	["walk to the back of the cave"] = "走到洞穴深處",

	-- Step 12: Kharanos: last hand-in
	-- {area:131} Kharanos
	["{area:131}: last hand-in"] = "{area:131}：最後一次交任務",

	-- Step 13: The quarry and Amberstill Ranch
	-- {area:803} Amberstill Ranch
	["The quarry and {area:803}"] = "採石場與{area:803}",
	-- {zone:1426} Dun Morogh · {npc:264936} Earthseer Farsen · {area:134} Gol'Bolar Quarry · {area:803} Amberstill Ranch
	["Optional: eastern {zone:1426}, from {npc:264936}'s camp to the {area:134} and {area:803}, about 500 reputation in 30 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "可選：{zone:1426}東部，從{npc:264936}的營地到{area:134}和{area:803}，60級時30分鐘約500點聲望。Forever 裡這些舊任務任何等級都足額給分。跳過這一步就跳過這個點。",

	-- Step 14: The quarry: troggs, spies and Vagash
	-- {npc:1388} Vagash
	["The quarry: troggs, spies and {npc:1388}"] = "採石場：穴居人、間諜和{npc:1388}",
	-- {area:134} Gol'Bolar Quarry · {npc:1388} Vagash · {area:803} Amberstill Ranch
	["The Dark Iron Spies lurk around Farsen's camp; the troggs dig in the {area:134}; {npc:1388}, a big snow leopard, prowls the hills above {area:803}."] = "黑鐵間諜潛伏在法爾森營地附近；穴居人在{area:134}挖掘；{npc:1388}，一隻大雪豹，在{area:803}上方的山丘遊蕩。",

	-- Step 15: The Reports
	-- {npc:1274} Senator Barin Redstone
	["{npc:1274}, in the throne room"] = "{npc:1274}，在王座廳",

	-- Step 16: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1437} Wetlands
	["{item:4306} drops from humanoids level 23 to 40: the Dragonmaw of the {zone:1437}, the Syndicate of Alterac and Arathi, Stranglethorn's trolls."] = "{item:4306}由23到40級的人形怪掉落：{zone:1437}的龍喉、奧特蘭克和阿拉希的辛迪加、荊棘谷的食人妖。",

	-- Step 17: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {object:147516} Dark Iron · {zone:1418} Badlands · {zone:1427} Searing Gorge · {zone:1446} Tanaris · {zone:1444} Feralas
	["{item:4338} drops from humanoids level 35 to 50: the Shadowforge and {object:147516} dwarves of the {zone:1418} and {zone:1427}, the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}."] = "{item:4338}由35到50級的人形怪掉落：{zone:1418}和{zone:1427}的暗爐和{object:147516}矮人、{zone:1446}的砂槌食人魔、{zone:1444}的憎恨之鱗納迦。",

	-- Step 18: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7806} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7806}."] = "{item:14047}由50級及以上的人形怪掉落：瘟疫之地的天災教徒和血色十字軍、{zone:1448}的死木熊怪、{zone:1452}的冬泉熊怪。前60個之外的{item:14047}都留著給{quest:7806}。",

	-- Step 19: Ironforge: Royal Historian Archesonus
	-- {faction:47} Ironforge · {npc:8879} Royal Historian Archesonus · {object:171709} High Seat · {zone:1428} Burning Steppes
	["These quests are level 52 to 59, so they pay in full at 60: about 600 {faction:47} reputation. {npc:8879} stands beside King Magni in the {object:171709}; he sends you to the ruins of Thaurissan in the {zone:1428}."] = "這些任務是52到59級，所以在60級足額給：約600點{faction:47}聲望。{npc:8879}站在{object:171709}裡麥格尼國王身旁；他把你派去{zone:1428}的索瑞森廢墟。",
	-- {npc:8879} Royal Historian Archesonus
	["Hear {npc:8879} out"] = "聽{npc:8879}說完",

	-- Step 20: Morgan's Vigil: Oralius
	-- {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {npc:9177} Oralius · {area:249} Dreadmaul Rock
	["{area:2418} sits in the south-east of the {zone:1428}, at the top of the pass up from Redridge. {npc:9177} wants the Firegut ogres of {area:249}, north of the Vigil, thinned out; the Brutes keep to the rock's east side."] = "{area:2418}位於{zone:1428}東南部，在從赤脊山向上的山口頂端。{npc:9177}想讓你清理摩根崗哨以北{area:249}的火腹食人魔；蠻兵守在石頭的東側。",

	-- Step 21: Thaurissan and Blackrock Stronghold
	-- {area:252} Blackrock Stronghold
	["Thaurissan and {area:252}"] = "索瑞森與{area:252}",
	-- {area:251} Flame Crest · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {item:11467} Blackrock Medallion · {npc:9177} Oralius · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["The Thaurissan relics are the carved stones in the ruins around {area:251}, west along the road: click twelve of them. {npc:9176} and the Blackrock orcs and worgs hold the camps at the foot of {area:254}, further west; each may drop a {item:11467} (about one kill in three), and {npc:9177} wants fifty. The orcs are level 50 and up, so they drop {item:14047} too: keep it for {quest:7806}."] = "索瑞森的遺物是沿路向西{area:251}周圍廢墟裡的雕刻石，點選其中十二塊。{npc:9176}和黑石獸人、座狼佔據更西邊{area:254}腳下的營地；它們每個都可能掉落{item:11467}（約三次殺一隻），而{npc:9177}要五十個。獸人是50級及以上，所以也會掉{item:14047}：留著給{quest:7806}。",

	-- Step 22: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418}：交任務",
	-- {npc:9176} Gor'tesh · {area:249} Dreadmaul Rock
	["Plant {npc:9176}'s head on the soft dirt mound at the top of {area:249}."] = "把{npc:9176}的頭顱插在{area:249}頂部鬆軟的土堆上。",

	-- Step 23: Ironforge: Archesonus again
	-- {faction:47} Ironforge
	["{faction:47}: Archesonus again"] = "{faction:47}：再找阿克森努斯",
	-- {area:1584} Blackrock Depths · {npc:9021} Kharan Mighthammer · {npc:9177} Oralius · {zone:1459} Alterac Valley · {faction:47} Ironforge · {item:17542} Coldtooth Supplies
	-- plural, as words: Dark Iron Fanny Packs = {item:11468} Dark Iron Fanny Pack · Storm Crystals = {item:17423} Storm Crystal
	["With a group, {area:1584} pays more: Archesonus's chain goes on with {npc:9021} (100) and The Fate of the Kingdom (Emperor Thaurissan, 150), and {npc:9177} takes 20 Dark Iron Fanny Packs from the dwarves inside (The Good Stuff, 100). {zone:1459}, from level 51, pays {faction:47} too: its one-time quests about 1,900 as your Stormpike standing grows (the {zone:1459} guide walks them), and inside the battle 25 for every 10 Irondeep or {item:17542} and 50 for 5 Storm Crystals, as often as you like."] = "組隊時，{area:1584}給的更多：阿克森努斯的任務鏈會繼續，{npc:9021}（100點）以及“王國的命運”（索瑞森皇帝，150點），{npc:9177}還會收裡面矮人身上的20個黑鐵腰包（“好東西”，100點）。{zone:1459}從51級起也會給{faction:47}：隨著你的雷矛聲望增長，它的一次性任務約給1,900點（{zone:1459}攻略有逐步說明），戰場內每10個深鐵礦或{item:17542}給25點，5個風暴水晶給50點，想交多少次都行。",

	-- Step 24: Winterspring: Enraged Wildkin
	-- {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village · {area:2245} Mazthoril · {faction:47} Ironforge
	["{npc:11755} in {area:2255} sends you west to {npc:10301} at {area:2253}. {npc:10301}'s damaged crate and wrecked wagon lie at {area:2245}, down the valley to the south-east; his supplies lie around the wagon and the owlbeasts nearby carry his amulet. The last quest is level 59: 100 {faction:47} in full."] = "{area:2255}的{npc:11755}派你向西去找{area:2253}的{npc:10301}。{npc:10301}損壞的木箱和毀壞的貨車在{area:2245}，沿山谷往東南下去；他的補給散落在貨車周圍，附近的貓頭鷹獸帶著他的護符。最後一個任務是59級：全額100點{faction:47}。",

	-- Step 25: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806}到尊敬",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1426} Dun Morogh · {faction:47} Ironforge · {area:144} Thelsamar · {zone:1432} Loch Modan · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1459} Alterac Valley
	["{quest:7806}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Night Elf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Dwarves start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). The level 52-59 quests above take 12 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. More hubs pay {faction:47}, in full while they are no more than 5 levels below you: {area:144} in {zone:1432} (about 3,500 in all) and {area:150} in the {zone:1437} (about 2,500). From level 51 {zone:1459}'s one-time quests add about 1,900. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7806}：20塊{item:14047}換50點聲望，可重複。前四次捐贈之後，人類、夜精靈或地精處在友善 700/6,000，離崇敬還差5,300：106次交付，2,120塊{item:14047}（矮人起點高900：88次；空裔從中立 2,000 開始，差6,400：128次，做了“探索聯盟”後再少兩次）。上面52-59級的任務能減掉12次；你每做過一個{zone:1426}任務點再減10到26次。還有更多工點給{faction:47}，只要等級差不低於5級就足額：{zone:1432}的{area:144}（共約3,500）和{zone:1437}的{area:150}（約2,500）。51級起{zone:1459}的一次性任務再加約1,900。每次城市聲望收益還會給另外三個聯盟城市四分之一（此處不計）。把所有{item:14047}一次交清。",

	-- Step 26: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806}到崇敬",
	-- {npc:1261} Veron Amberstill · {item:14047} Runecloth
	["Honored: in Classic Ironforge's vendors take 10% off for you, {npc:1261}'s rams (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "",

	-- Step 27: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806}到崇拜",
	-- {item:14047} Runecloth · {npc:1261} Veron Amberstill · {area:803} Amberstill Ranch · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:1261} at {area:803} in eastern {zone:1426} sells his rams to other races in Classic; the Ram and Swift Ram guides cover them."] = "崇敬到崇拜是21,000點聲望：420次上交，8,400個{item:14047}。崇拜後，經典舊世裡{zone:1426}東部{area:803}的{npc:1261}會把他的山羊賣給其他種族；山羊與迅捷山羊攻略中有介紹。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7806}，直到{faction:47}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7806}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "河爪強盜和河爪監工（16-18級）在這裡會掉落。拍賣場也買得到。",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "激流堡的辛迪加雇傭兵（31-32級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723}在{faction:47}收取布料以提升{faction:47}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7806}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14723}: {item:14047} delivered"] = "{npc:14723}：{item:14047}已交付",
	-- ["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
