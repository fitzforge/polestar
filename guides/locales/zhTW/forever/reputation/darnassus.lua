-- Chinese (traditional) (zhTW): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "達納蘇斯聲望",
	-- {item:11040} Morrowgrain · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["Cloth, {item:11040} and the {zone:1438} and {zone:1439} hubs: the quests pay most while you level."] = "布料、{item:11040}以及{zone:1438}和{zone:1439}的任務據點：升級期間做任務給的聲望最多。",
	-- {faction:69} Darnassus
	["Exalted with {faction:69}: in Classic, other races may buy the nightsabers"] = "{faction:69}崇拜：在經典版中，其他種族可購買夜刃豹",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain
	["{quest:3803}: 50 reputation for every 10 {item:11040}, as often as you like"] = "{quest:3803}：每10個{item:11040}給50點聲望，可無限重複",
	-- {faction:69} Darnassus · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439}"] = "{zone:1438}和{zone:1439}的低階任務約3,700點{faction:69}聲望",

	-- Step 1: Raedon Duskstriker, the cloth quartermaster
	-- {npc:14725} Raedon Duskstriker
	["{npc:14725}, the cloth quartermaster"] = "{npc:14725}，布料軍需官",
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {area:1659} Craftsmen's Terrace · {item:14047} Runecloth · {quest:7801} Additional Runecloth · {area:1662} Tradesmen's Terrace · {zone:1438} Teldrassil · {zone:1439} Darkshore · {zone:1440} Ashenvale · {quest:4183} The True Masters · {zone:1428} Burning Steppes · {item:11040} Morrowgrain · {area:188} Shadowglen · {area:186} Dolanaar · {area:442} Auberdine · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{npc:14725} takes cloth for {faction:69}; he stands in the {area:1659}, in the north-east of {faction:69}, by the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7801} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the {area:1662} is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1438} (levels 1-12), {zone:1439} (11-20) and {zone:1440} (18-30) while you level through them. After the donations come {quest:4183} in the {zone:1428} and {item:11040}, a second repeatable turn-in; then the optional hubs, best rate first: {area:188} (about 35 a minute at full value), {area:186} (28), {area:442} (23). Every {faction:69} gain also gives a quarter as much to {zone:1453}, {zone:1455} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14725}為{faction:69}收布料；他站在{faction:69}東北的{area:1659}，裁縫鋪旁。首次各捐60個毛料、絲綢、魔紋布和{item:14047}，各給一次150點聲望；捐過{item:14047}之後，{quest:7801}每20個{item:14047}給50點，想做多少次都行。{area:1662}的拍賣行是獲取布料最快的來源。經典版中，任務最多比你低5級時仍給全額聲望，所以趁升級時做{zone:1438}（1-12級）、{zone:1439}（11-20級）和{zone:1440}（18-30級）。捐完之後，還有{zone:1428}的{quest:4183}和{item:11040}這第二種可重複交任務；接著是可選的樞紐，按時效從高到低：{area:188}（全額時約每分鐘35點）、{area:186}（28）、{area:442}（23）。除1-10級起始區域的任務外，每獲得一點{faction:69}聲望，也會給{zone:1453}、{zone:1455}和諾莫瑞根流亡者四分之一。Legacy Diplomat最多為每筆聲望加成10%。",
	-- {item:2592} Wool Cloth · {zone:1439} Darkshore · {zone:1440} Ashenvale
	["{item:2592}: furbolgs, satyrs and naga in {zone:1439} and {zone:1440}"] = "{item:2592}：{zone:1439}和{zone:1440}的熊怪、薩特和納迦",

	-- Step 2: Shadowglen
	-- {zone:1438} Teldrassil · {area:256} Aldrassil
	["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation in 30 minutes at 60. The givers stand around {area:256}, the great tree. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "可選：{zone:1438}東北的暗夜精靈新手林地，60級時30分鐘約1,050點聲望。發任務的都站在巨樹{area:256}周圍。Forever 裡這些舊任務任何等級都足額給分。跳過這一步就跳過這個點。",

	-- Step 3: Shadowglen: the glade and the spider den
	-- {area:188} Shadowglen
	["{area:188}: the glade and the spider den"] = "{area:188}：林間空地與被蜘蛛巢",
	-- {area:256} Aldrassil · {item:3297} Fel Moss · {npc:8584} Iverron
	["The nightsabers and boars roam the glade; the grells around {area:256} drop the {item:3297}; the totems stand in the furbolg camp north-west of the tree; the Webwood spiders live in the cave north of the glade. {npc:8584} waits outside that cave."] = "夜刃豹和野豬在林間空地遊蕩；{area:256}周圍的格雷爾掉落{item:3297}；圖騰立在樹西北的熊怪營地；蛛網林地蜘蛛住在空地以北的洞穴裡。{npc:8584}在那個洞外等著。",

	-- Step 4: Shadowglen: first hand-in
	-- {area:188} Shadowglen
	["{area:188}: first hand-in"] = "{area:188}：第一次交任務",

	-- Step 5: Shadowglen: the egg and the antidote
	-- {area:188} Shadowglen
	["{area:188}: the egg and the antidote"] = "{area:188}：蛋與解藥",
	-- {quest:917} Webwood Egg · {item:10640} Webwood Ichor
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["The {quest:917} lies at the back of the spider cave; the mushrooms grow by the trees, the lilies by the pools, and the {item:10640} drops from the Webwood Lurkers."] = "{quest:917}在蜘蛛洞穴深處；蘑菇長在樹旁，百合長在水塘邊，{item:10640}由蛛網林地潛伏者掉落。",

	-- Step 6: Shadowglen: last hand-in
	-- {area:188} Shadowglen
	["{area:188}: last hand-in"] = "{area:188}：最後一次交任務",
	-- {npc:8584} Iverron
	["{npc:8584}, outside the spider cave"] = "{npc:8584}，蜘蛛洞穴外",

	-- Step 7: Dolanaar
	-- {faction:69} Darnassus · {npc:2151} Moon Priestess Amara
	["Optional: the village on the road to {faction:69}, about 1,250 reputation in 45 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub.\n{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "",

	-- Step 8: Dolanaar: Denalan and the lake
	-- {area:186} Dolanaar · {npc:2080} Denalan
	["{area:186}: {npc:2080} and the lake"] = "{area:186}：{npc:2080}與湖泊",
	-- {npc:2080} Denalan · {area:259} Lake Al'Ameth · {npc:2107} Gaerolas Talvethren · {area:260} Starbreeze Village · {area:186} Dolanaar
	["{npc:2080} tends his garden on the south-east shore of {area:259}; {npc:2107} stands upstairs in a house in {area:260}, east of {area:186}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2080}在{area:259}東南岸照料他的園子；{npc:2107}站在{area:186}以東{area:260}一座房子的樓上：從裡面上去，箭頭分不清樓層。",

	-- Step 9: Dolanaar: the woods around the village
	-- {area:186} Dolanaar
	["{area:186}: the woods around the village"] = "{area:186}：村莊周圍的樹林",
	-- {faction:69} Darnassus · {npc:2038} Lord Melenas · {area:258} Fel Rock · {npc:2107} Gaerolas Talvethren
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["The timberlings by the lake drop seeds and sprouts; the Gnarlpine Ambushers lurk on the road west to {faction:69}; {npc:2038} waits deep in {area:258}, north-west of the village; the dreamcatcher lies in the furbolg camp east of the village, by {npc:2107}; the Nightsabers west of the village carry the pelts."] = "湖邊的林精掉落種子和幼苗；瘤背伏擊者潛伏在向西通往{faction:69}的路上；{npc:2038}在村西北{area:258}深處等著；捕夢器在村東的熊怪營地裡、{npc:2107}旁邊；村西的夜刃豹身上帶著毛皮。",

	-- Step 10: Dolanaar: first hand-in
	-- {area:186} Dolanaar
	["{area:186}: first hand-in"] = "{area:186}：第一次交任務",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151}在村莊西邊的道路上巡邏：如果她不在箭頭處，沿著道路走直到遇見她。",

	-- Step 11: Dolanaar: the Ban'ethil Barrow Den's entrance
	-- {area:186} Dolanaar · {area:262} Ban'ethil Barrow Den
	["{area:186}: the {area:262}'s entrance"] = "{area:186}：{area:262}的入口",

	-- Step 12: Dolanaar: the relics and Ferocitas
	-- {area:186} Dolanaar
	["{area:186}: the relics and Ferocitas"] = "{area:186}：遺物與費羅西塔斯",
	-- {area:262} Ban'ethil Barrow Den · {area:186} Dolanaar
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["The four relics of Wakening lie in the {area:262}, south-west of {area:186}; Ferocitas and the Gnarlpine Mystics camp east of the village."] = "四件覺醒遺物位於{area:186}西南的{area:262}；費羅西塔斯和瘤背秘法師在村東紮營。",
	-- {item:8050} Tallonkai's Jewel · {quest:2459} Ferocitas the Dream Eater
	["{item:8050}, from {quest:2459}"] = "{item:8050}，來自{quest:2459}",

	-- Step 13: Dolanaar: Ursal the Mauler
	-- {quest:486} Ursal the Mauler · {area:478} Pools of Arlithrien · {zone:1438} Teldrassil
	["{quest:486}, a big bear, roams the {area:478} in south-west {zone:1438}."] = "{quest:486}，一隻大熊，在{zone:1438}西南的{area:478}遊蕩。",

	-- Step 14: Auberdine
	-- {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village
	["Optional: {area:442} in {zone:1439}, a boat trip from {area:702}, about 1,400 reputation in an hour at 60. The givers stand along the town's street and pier. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "可選：{zone:1439}的{area:442}，從{area:702}坐船過去，60級時一小時約1,400點聲望。發任務的都在鎮上的街道和碼頭一帶。Forever 裡這些舊任務任何等級都足額給分。跳過這一步就跳過這個點。",

	-- Step 15: Auberdine: the coast and the woods
	-- {area:442} Auberdine
	["{area:442}: the coast and the woods"] = "{area:442}：海岸與樹林",
	-- {area:445} Cliffspring Falls
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["The furbolg camp south of town counts for How Big a Threat; the Rabid Thistle Bears roam the woods south of town; the Highborne ghosts of the Ruins of Ameth'Aran, south-east of town, carry the relics, and Anaya's ghost walks there too; the bones lie on the beach south of town; the mushrooms grow in the {area:445} cave to the north-east."] = "鎮南的熊怪營地算作“威脅有多大”；狂暴薊熊在鎮南的樹林遊蕩；鎮東南阿米斯阿蘭廢墟的上層精靈幽靈帶著遺物，阿納雅的鬼魂也在那裡遊走；骸骨躺在鎮南的海灘上；蘑菇生長在東北{area:445}的洞穴裡。",
	["the corrupt furbolg camp south of town"] = "城鎮南邊被腐化的熊怪營地",
	-- {npc:2164} Rabid Thistle Bear · {quest:2139} Tharnariun's Hope · {npc:3701} Tharnariun Treetender
	["{npc:2164}: use {quest:2139} on it and lead it back to {npc:3701}"] = "{npc:2164}：對它使用{quest:2139}，然後帶回{npc:3701}那裡",
	-- {npc:2164} Rabid Thistle Bear
	["Capture a {npc:2164}"] = "捕獲一隻{npc:2164}",
	-- {quest:954} Bashal'Aran
	["the blue aura in the ruins of {quest:954}"] = "{quest:954}廢墟中的藍色光環",

	-- Step 16: Auberdine: first hand-in
	-- {area:442} Auberdine
	["{area:442}: first hand-in"] = "{area:442}：第一次交任務",

	-- Step 17: Auberdine: the furbolgs, the bears and the grells
	-- {area:442} Auberdine
	["{area:442}: the furbolgs, the bears and the grells"] = "{area:442}：熊怪、熊與格雷爾",
	-- {quest:955} Bashal'Aran
	["The Blackwood furbolgs camp south of town; the grells of {quest:955}, east of town, drop the earrings; the sea turtle remains lie on the beach west of town."] = "黑木熊怪在鎮南紮營；鎮東{quest:955}的格雷爾掉落耳環；海龜殘骸躺在鎮西的海灘上。",

	-- Step 18: Auberdine: second hand-in
	-- {area:442} Auberdine
	["{area:442}: second hand-in"] = "{area:442}：第二次交任務",

	-- Step 19: Auberdine: the seal, the Den Mother and the pelts
	-- {area:442} Auberdine · {npc:6788} Den Mother
	["{area:442}: the seal, the {npc:6788} and the pelts"] = "{area:442}：封印、{npc:6788}與毛皮",
	-- {item:5338} Ancient Moonstone Seal · {quest:956} Bashal'Aran · {npc:6788} Den Mother · {zone:1439} Darkshore
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The {item:5338} drops from the satyrs of {quest:956}; destroy the seal at the flame there. The {npc:6788} lairs north-east of {quest:956}; the Moonstalker Sires and Matriarchs roam the south of {zone:1439}."] = "{item:5338}由{quest:956}的薩特掉落；在那裡火焰旁摧毀封印。{npc:6788}巢居在{quest:956}東北；月行者公豹和母豹在{zone:1439}南部遊蕩。",
	["the seal at the ancient flame"] = "古老火焰處的封印",

	-- Step 20: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1440} Ashenvale
	["{item:4306} drops from humanoids level 23 to 40: the satyrs and furbolgs of {zone:1440}, the Thistlefur and Foulweald camps, the Grimtotem of Stonetalon."] = "{item:4306}由23到40級人形怪掉落：{zone:1440}的薩特和熊怪、薊皮和邪林營地、石爪山的恐怖圖騰。",

	-- Step 21: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1444} Feralas · {zone:1446} Tanaris
	["{item:4338} drops from humanoids level 35 to 50: the Hatecrest naga and Gordunni ogres of {zone:1444}, the Dunemaul ogres of {zone:1446}."] = "{item:4338}由35到50級人形怪掉落：{zone:1444}的憎恨之冠納迦和戈杜尼食人魔、{zone:1446}的砂槌食人魔。",

	-- Step 22: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7801} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}, the Scourge cultists of the Plaguelands. Keep any {item:14047} past the first 60 for {quest:7801}."] = "{item:14047}由50級及以上人形怪掉落：{zone:1448}的枯木熊怪、{zone:1452}的冬泉熊怪、瘟疫之地的天災教徒。頭60個之後的{item:14047}都留給{quest:7801}。",

	-- Step 23: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {faction:69} Darnassus · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: 175 {faction:69} reputation for two quests (level 54: in Classic 140 at 60), and the chain goes on to {object:2117} for 175 {zone:1453}. The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{zone:1428}東南{area:2418}的{npc:9562}開啟{quest:4183}：兩個任務共175點{faction:69}聲望（54級：經典版60級時140點），任務鏈繼續到{object:2117}，給175點{zone:1453}聲望。黑色雛龍和{npc:7044}住在守望崗哨以北的山坡；{npc:7040}和{npc:7041}在其以西、區域中部。",

	-- Step 24: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {faction:69} Darnassus · {npc:7916} Erelas Ambersky · {area:702} Rut'theran Village · {zone:1452} Winterspring · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands · {item:12663} Glyphed Oaken Branch
	["{npc:344} waits in the town hall of {area:69}; his next quest takes you to {object:2117} (the {zone:1453} guide follows it). Other {faction:69} quests at this level, for when you pass by: {npc:7916} in {area:702} has a wildkin chain into {zone:1452} (325 in all, with Ranshalla's escort), Arei's escort in {zone:1448} pays 150 after the {area:2479}'s chain, {npc:10739} at the {area:202} in the {zone:1422} 100 for the {item:12663}, and Put Her Down in Upper Blackrock Spire 100 with a group."] = "{npc:344}在{area:69}的鎮公所等著；他的下一個任務會把你引向{object:2117}（隨後接{zone:1453}指南）。這個等級其他{faction:69}任務，路過時可以順帶做：{area:702}的{npc:7916}有一條通往{zone:1452}的野性生物任務鏈（含蘭莎拉的護送共325點）；{zone:1448}的阿雷伊護送在{area:2479}任務鏈之後給150點；{zone:1422}的{area:202}處{npc:10739}為{item:12663}給100點；還有上層黑石塔的“放倒她”，組隊給100點。",

	-- Step 25: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040}（可選）",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain · {npc:6735} Innkeeper Saelienne · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50: 220. {npc:6735} sends you to {npc:3516} in the {area:1658}; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "{quest:3803}收10個{item:11040}給50點，可重複，60級足額給。它前面的任務鏈是50級：220點。{npc:6735}把你派去{area:1658}的{npc:3516}；他要20個{quest:3764}。（{zone:1453}和{zone:1455}的旅店老闆給同樣的起點。）",

	-- Step 28: Un'Goro Crater: Un'Goro Soil
	-- {quest:3764} Un'Goro Soil · {item:11040} Morrowgrain
	["Dig {quest:3764} from the dirt mounds all over the crater; most of the crater's beasts and the Gorishi silithids drop it too, about one kill in three. Take far more than 20: every pouch use takes 2, about 18 for each 10 {item:11040}."] = "在環形山各處的土堆裡挖{quest:3764}；環形山的大多數野獸和戈裡什異種蟲也會掉落，約三次擊殺掉一個。多挖遠超20個：每次使用袋子消耗2個，每10個{item:11040}約需18個。",

	-- Step 29: Darnassus: Morrowgrain Research
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker · {item:11020} Evergreen Pouch · {quest:3764} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9047}, beside Fandral in the {area:1658}, takes the soil. {npc:4217} sells the {item:11020} and Packets of Tharlendris Seeds. With a seed packet and 2 {quest:3764} in your bags, use the pouch to grow an {item:11024} and open it: about one casing in three holds {item:11040} (1 to 5), the rest other herbs. The pouch works once every 10 minutes, so use it whenever it is ready while you do other things."] = "{npc:9047}在{area:1658}範達爾身旁收泥土。{npc:4217}出售{item:11020}和塔倫德里斯種子包。揹包裡有種子包和2個{quest:3764}時，用袋子種出一個{item:11024}並開啟它：約三分之一的莢殼含{item:11040}（1到5個），其餘是別的草藥。袋子每10分鐘只能用一次，所以做別的事時一好就用。",

	-- Step 33: Darnassus: Morrowgrain Research
	-- {item:11040} Morrowgrain
	["{item:11040}: grow it here and open the casings"] = "{item:11040}：在這裡種植並開啟莢殼",

	-- Step 34: Morrowgrain to Darnassus
	-- {item:11040} Morrowgrain · {npc:4217} Mathrengyl Bearwalker · {quest:3764} Un'Goro Soil · {item:14047} Runecloth · {npc:7879} Quintis Jonespyre · {area:1116} Feathermoon Stronghold · {zone:1444} Feralas
	["Every 10 {item:11040}: 50 reputation at {npc:4217}. Keep the pouch and buy seeds as you go. It is slow: about 9 casings, 90 minutes of pouch waits, 18 {quest:3764} and 9 seed packets for each hand-in, a little over 30 reputation an hour, so run it beside the {item:14047}. {npc:7879} at {area:1116} in {zone:1444} takes {item:11040} at the same rate, 25 for 5, after his own quest."] = "每10個{item:11040}：在{npc:4217}處換50點聲望。留著袋子，邊做邊買種子。這很慢：每次交任務約需9個莢殼、90分鐘的袋子等待、18個{quest:3764}和9包種子，每小時略多於30點聲望，所以把它和{item:14047}一起做。{zone:1444}中{area:1116}的{npc:7879}在他自己的任務之後也按同樣比例收{item:11040}，5個換25點。",

	-- Step 35: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801}到尊敬",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {quest:4183} The True Masters · {item:11040} Morrowgrain · {faction:69} Darnassus · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {zone:1444} Feralas
	["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), {area:415} in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7801}：20塊{item:14047}換50點聲望，可重複。前四次捐贈之後，人類、矮人或侏儒處在友善 700/6,000，離崇敬還差5,300：106次交付，2,120塊{item:14047}（暗夜精靈起點高900：88次；空裔從中立 500 開始，差7,900：158次，做了“探索聯盟”後再少兩次）。{quest:4183}和上面的{item:11040}鏈能減掉8次，每交10個{item:11040}再算一次；你每做過一個任務點再減20到28次。還有更多工給{faction:69}聲望，只要等級差不低於5級就足額：{zone:1439}的其餘部分（再約3,400）、{zone:1440}的{area:415}（約3,900）和{zone:1444}的羽月要塞（約1,700）。每次城市聲望收益還會給另外三個聯盟城市四分之一（此處不計）。把所有{item:14047}一次交清。",

	-- Step 36: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801}到崇敬",
	-- {item:14047} Runecloth
	["Honored: in Classic Darnassus's vendors take 10% off for you, Lelanai's nightsabers (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "",

	-- Step 37: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801}到崇拜",
	-- {item:14047} Runecloth · {area:1658} Cenarion Enclave · {faction:69} Darnassus
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, Lelanai at the {area:1658} in {faction:69} sells her nightsabers to other races in Classic; the Saber and Swift Saber guides cover them."] = "崇敬到崇拜需要21,000點聲望：420次交任務，8,400個{item:14047}。崇拜後，經典版中{faction:69}的{area:1658}處的萊拉奈會向其他種族出售她的夜刃豹；夜刃豹和迅捷夜刃豹指南有介紹。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7801}，直到{faction:69}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7801}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "河爪強盜和河爪監工（16-18級）在這裡會掉落。拍賣場也買得到。",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "激流堡的辛迪加雇傭兵（31-32級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725}在{faction:69}收取布料以提升{faction:69}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7801}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14725}: {item:14047} delivered"] = "{npc:14725}：{item:14047}已交付",
	-- ["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
