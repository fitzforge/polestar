-- Chinese (traditional) (zhTW): the guide forever/reputation/gnomeregan-exiles (forever/reputation/gnomeregan-exiles.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gnomeregan Exiles Reputation"] = "諾姆瑞根流亡者聲望",
	-- {npc:9616} Laris Geardawdle · {zone:1426} Dun Morogh · {zone:1455} Ironforge
	["Cloth, {npc:9616}'s ooze quests and the {zone:1426} hubs, which pay {zone:1455} too: best done while leveling."] = "布料、{npc:9616}的軟泥怪任務以及{zone:1426}的任務點，同時也會提升{zone:1455}聲望：最好在升級時完成。",
	-- {faction:54} Gnomeregan Exiles
	["Exalted with {faction:54}: in Classic, other races may buy the mechanostriders"] = "{faction:54}達到崇拜：在經典版中，其他種族可購買機械陸行鳥",
	-- {area:133} Gnomeregan · {npc:9616} Laris Geardawdle · {quest:4262} Overmaster Pyron
	["400 {area:133} reputation from {npc:9616}'s ooze jars and {quest:4262} (level 52-54)"] = "{npc:9616}的軟泥瓶和{quest:4262}（52-54級）帶來的400點{area:133}聲望",
	-- {area:133} Gnomeregan · {zone:1426} Dun Morogh · {zone:1455} Ironforge
	["About 3,000 {area:133} reputation from low-level quests in {zone:1426}, paid to {zone:1455} too"] = "{zone:1426}的低階任務約3,000點{area:133}聲望，同時也給{zone:1455}",

	-- Step 1: Bubulo Acerbus, the cloth quartermaster
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, the cloth quartermaster"] = "{npc:14724}，布匹軍需官",
	-- {npc:14724} Bubulo Acerbus · {faction:54} Gnomeregan Exiles · {object:171524} Tinker Town · {zone:1455} Ironforge · {item:14047} Runecloth · {quest:7812} Additional Runecloth · {zone:1426} Dun Morogh · {npc:4077} Gaxim Rustfizzle · {npc:9616} Laris Geardawdle · {quest:4262} Overmaster Pyron · {area:132} Coldridge Valley · {area:131} Kharanos · {area:133} Gnomeregan · {zone:1453} Stormwind · {zone:1457} Darnassus
	["{npc:14724} takes cloth for the {faction:54}; he stands in {object:171524} in {zone:1455}, by the tram. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7812} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the Commons is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1426} (levels 1-12) and {npc:4077}'s quests in Stonetalon (20-25) while you level. After the donations come {npc:9616}'s ooze quests and {quest:4262} (400), then the optional {zone:1426} hubs, best rate first: {area:132} (about 38 a minute at full value), {area:131} (26), the quarry (17). Every {area:133} gain also gives a quarter as much to {zone:1453}, {zone:1455} and {zone:1457}, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14724}為{faction:54}收布；他站在{zone:1455}地鐵旁的{object:171524}。首次各捐60個毛料、絲綢、魔紋布和{item:14047}，每次給150點聲望；交完{item:14047}那次後，{quest:7812}每20個{item:14047}給50點，想交多少次都行。公共區的拍賣行是最快的布匹來源。經典舊世裡，只要任務最多低於你5級，就按全額給聲望，所以練級時做{zone:1426}（1-12級）和{npc:4077}在石爪山的任務（20-25級）。捐贈之後是{npc:9616}的軟泥任務和{quest:4262}（400點），然後是可選{zone:1426}任務點，按效率從高到低：{area:132}（全額時每分鐘約38）、{area:131}（26）、採石場（17）。每一份{area:133}聲望收益還會以四分之一的比例給{zone:1453}、{zone:1455}和{zone:1457}，1-10級新手區的任務除外。傳承外交官能讓每份收益最多提高10%。",
	-- {item:2592} Wool Cloth · {zone:1432} Loch Modan · {zone:1437} Wetlands
	["{item:2592}: troggs, gnolls and kobolds in {zone:1432} and the {zone:1437}"] = "{item:2592}：{zone:1432}和{zone:1437}的穴居人、豺狼人和狗頭人",

	-- Step 2: Coldridge Valley
	-- {area:131} Kharanos · {npc:658} Sten Stoutarm · {npc:713} Balir Frosthammer · {area:77} Anvilmar
	["Optional: the Dwarf and Gnome start valley south-west of {area:131}, about 1,150 reputation in 30 minutes at 60. {npc:658} and {npc:713} stand at {area:77}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "可選：{area:131}西南的矮人和侏儒新手山谷，60級時30分鐘約1,150點聲望。{npc:658}和{npc:713}站在{area:77}。Forever 裡這些舊任務任何等級都足額給分。跳過這一步就跳過這個點。",

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
	["Coldridge: {npc:786} and the troll cave"] = "寒脊山谷：{npc:786}和巨魔洞",
	-- {npc:786} Grelin Whitebeard · {area:77} Anvilmar
	["{npc:786} camps south of {area:77}, at the mouth of the troll cave; the journal lies at the back of the cave."] = "{npc:786}在{area:77}以南紮營，就在巨魔洞口；手記在洞穴深處。",

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
	["The boars and bears roam around {area:131}; the wendigos live in the {area:136} south-west of town; the leper gnomes at the {area:133} road carry the cogs and gears; Rumbleshot's ammo lies at his camp west of town."] = "野豬和熊在{area:131}周圍遊蕩；溫迪戈住在小鎮西南的{area:136}；{area:133}路上的麻風侏儒帶著齒輪和零件；朗布林肖特的彈藥在他的營地、小鎮西邊。",

	-- Step 10: Kharanos: back in town
	-- {area:131} Kharanos
	["{area:131}: back in town"] = "{area:131}：回到鎮上",

	-- Step 11: Kharanos: Brewnall and Frostmane Hold
	-- {area:131} Kharanos · {quest:287} Frostmane Hold
	["{area:131}: Brewnall and {quest:287}"] = "{area:131}：布瑞恩諾爾和{quest:287}",
	-- {npc:1374} Rejold Barleybrew · {area:137} Brewnall Village · {area:131} Kharanos · {quest:287} Frostmane Hold
	["{npc:1374} stands by {area:137} on the lake north-west of {area:131}; {quest:287} is the troll cave west of it."] = "{npc:1374}站在{area:131}西北湖邊{area:137}旁；{quest:287}在它西邊的巨魔洞。",
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
	["{item:4306} drops from humanoids level 23 to 40: the Dragonmaw of the {zone:1437}, the Syndicate of Alterac and Arathi, Stranglethorn's trolls."] = "{item:4306}由23到40級的人形怪掉落：{zone:1437}的龍喉、奧特蘭克和阿拉希的辛迪加、荊棘谷的巨魔。",

	-- Step 17: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {object:147516} Dark Iron · {zone:1418} Badlands · {zone:1427} Searing Gorge · {zone:1446} Tanaris · {zone:1444} Feralas
	["{item:4338} drops from humanoids level 35 to 50: the Shadowforge and {object:147516} dwarves of the {zone:1418} and {zone:1427}, the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}."] = "{item:4338}由35到50級的人形怪掉落：{zone:1418}和{zone:1427}的暗爐和{object:147516}矮人、{zone:1446}的砂槌食人魔、{zone:1444}的憎恨之鱗納迦。",

	-- Step 18: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7812} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60 for {quest:7812}."] = "{item:14047}由50級及以上的人形怪掉落：瘟疫之地的天災教徒和血色十字軍、{zone:1448}的死木熊怪、{zone:1452}的冬泉熊怪。前60個之外的{item:14047}都留著給{quest:7812}。",

	-- Step 19: Tinker Town: Laris Geardawdle
	-- {npc:9616} Laris Geardawdle · {object:171524} Tinker Town · {area:133} Gnomeregan
	["{npc:9616} in {object:171524} wants ooze samples for her research: 150 {area:133} reputation for each of her two quests (level 52 and 54: in Classic 60 and 120 of it at 60). She hands you the empty jars."] = "{object:171524}處的{npc:9616}要為研究收集軟泥樣本：她的兩個任務（52級和54級）各給150點{area:133}聲望（經典舊世裡60級時分別是60點和120點）。她會把空瓶交給你。",

	-- Step 20: Felwood: Cursed and Tainted Oozes
	-- {zone:1448} Felwood
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["{zone:1448}: Cursed and Tainted Oozes"] = "{zone:1448}：被詛咒的軟泥怪和受汙染的軟泥怪",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill one and use an empty jar on its remains."] = "被詛咒的軟泥怪和受汙染的軟泥怪在{area:1763}和{area:1765}周圍的溪流和邪能水池裡滑行：殺一隻，在它的殘骸上使用空瓶。",

	-- Step 21: Tinker Town: the second jars
	-- {object:171524} Tinker Town
	["{object:171524}: the second jars"] = "{object:171524}：第二批瓶子",

	-- Step 22: Un'Goro Crater: Primal Oozes
	-- {zone:1449} Un'Goro Crater
	-- plural, as words: Primal Oozes = {npc:6557} Primal Ooze
	["{zone:1449}: Primal Oozes"] = "{zone:1449}：原始軟泥怪",
	-- {area:537} Fire Plume Ridge
	-- plural, as words: Primal Oozes = {npc:6557} Primal Ooze · Glutinous Oozes = {npc:6559} Glutinous Ooze
	["The Primal Oozes live in the pools around {area:537} in the middle of the crater; the Muculent and Glutinous Oozes fill the jars too. Kill one and use a jar on its remains."] = "原始軟泥怪生活在火山口中央{area:537}周圍的水池裡；黏液軟泥怪和膠質軟泥怪也能裝滿瓶子。殺一隻，在它的殘骸上使用瓶子。",

	-- Step 23: Tinker Town: hand in
	-- {object:171524} Tinker Town
	["{object:171524}: hand in"] = "{object:171524}：交任務",

	-- Step 24: Morgan's Vigil: Jalinda Sprig
	-- {npc:9561} Jalinda Sprig · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4262} Overmaster Pyron · {area:133} Gnomeregan · {area:1584} Blackrock Depths
	["{npc:9561} at {area:2418}, in the south-east of the {zone:1428}, wants {quest:4262} dead: 100 {area:133} reputation (level 52: in Classic 40 at 60). Her next quest, Incendius!, needs a {area:1584} group: 100 more, in full."] = "{npc:9561}在{area:2418}，位於{zone:1428}東南部，要{quest:4262}死：100點{area:133}聲望（52級：經典舊世裡60級時40點）。她的下一個任務“Incendius!”需要一個{area:1584}隊伍：再給100點，全額。",

	-- Step 25: Blackrock Mountain: Overmaster Pyron
	-- {area:254} Blackrock Mountain · {zone:1428} Burning Steppes · {quest:4262} Overmaster Pyron · {area:1584} Blackrock Depths
	["{area:254} stands in the west of the {zone:1428}. {quest:4262}, a fire elemental, walks the lava paths inside it, near the door of {area:1584} but outside the dungeon: at 60 you take him alone."] = "{area:254}位於{zone:1428}西部。{quest:4262}，一個火元素，在裡面的熔岩路徑上走動，靠近{area:1584}門口但在副本外：60級時可以單挑他。",

	-- Step 26: Morgan's Vigil: hand in
	-- {area:2418} Morgan's Vigil
	["{area:2418}: hand in"] = "{area:2418}：交任務",

	-- Step 27: Additional Runecloth to Honored
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Honored"] = "{quest:7812}到尊敬",
	-- {quest:7812} Additional Runecloth · {item:14047} Runecloth · {npc:9616} Laris Geardawdle · {npc:9561} Jalinda Sprig · {zone:1426} Dun Morogh · {npc:4077} Gaxim Rustfizzle · {object:171524} Tinker Town · {area:133} Gnomeregan
	["{quest:7812}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Night Elf stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Gnomes start 900 higher: 88 turn-ins; Skyborne start at Neutral 2,000, so 6,400 away: 128, two fewer after Exploring the Alliance). {npc:9616}'s and {npc:9561}'s quests above take 8 turn-ins off; each {zone:1426} hub you did takes 10 to 26 more off. Outside Dun Morogh Gnomeregan pays little: {npc:4077}'s quests in Stonetalon (about 500) and {object:171524}'s {area:133} dungeon quests. Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7812}：20塊{item:14047}換50點聲望，可重複。前四次捐贈之後，人類、矮人或暗夜精靈處在友善 700/6,000，離崇敬還差5,300：106次交付，2,120塊{item:14047}（侏儒起點高900：88次；空裔從中立 2,000 開始，差6,400：128次，做了“探索聯盟”後再少兩次）。上面{npc:9616}和{npc:9561}的任務能減掉8次；你每做過一個{zone:1426}任務點再減10到26次。在丹莫羅以外諾莫瑞根給得很少：{npc:4077}在石爪山的任務（約500）和{object:171524}的{area:133}副本任務。每次城市聲望收益還會給另外三個聯盟城市四分之一（此處不計）。把所有{item:14047}一次交清。",

	-- Step 28: Additional Runecloth to Revered
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Revered"] = "{quest:7812}到崇敬",
	-- {faction:54} Gnomeregan Exiles · {npc:7955} Milli Featherwhistle · {item:14047} Runecloth
	["Honored: in Classic the {faction:54}' vendors take 10% off for you, {npc:7955}'s mechanostriders (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "",

	-- Step 29: Additional Runecloth to Exalted
	-- {quest:7812} Additional Runecloth
	["{quest:7812} to Exalted"] = "{quest:7812}到崇拜",
	-- {item:14047} Runecloth · {npc:7955} Milli Featherwhistle · {area:189} Steelgrill's Depot · {zone:1426} Dun Morogh
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:7955} at {area:189} in {zone:1426} sells her mechanostriders to other races in Classic; the Mechanostrider and Swift Mechanostrider guides cover them."] = "崇敬到崇拜是21,000點聲望：420次上交，8,400個{item:14047}。崇拜後，經典舊世裡{zone:1426}的{area:189}處{npc:7955}會把她的機械陸行鳥賣給其他種族；機械陸行鳥和迅捷機械陸行鳥指南有詳細介紹。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7812} until {faction:54} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7812}，直到{faction:54}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7812}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7812}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "河爪強盜和河爪監工（16-18級）在這裡會掉落。拍賣場也買得到。",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "激流堡的辛迪加雇傭兵（31-32級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14724} takes cloth for {faction:54} in {object:171524}, {zone:1455}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7812} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14724}在{zone:1455}的{object:171524}收取布料以提升{faction:54}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7812}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14724}: {item:14047} delivered"] = "{npc:14724}：{item:14047}已交付",
	-- ["{quest:7812} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7812}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
