-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "搭飛艇前往{zone:1458}",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458}的訓練師",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "趁你在{zone:1458}時學習：訓練師都在{object:36070}、{object:36073}和{object:36082}（聖騎士：{npc:260093}）。",

	-- Step 3: Calder Gray
	-- {npc:270038} Calder Gray
	["{npc:270038} stands in the Apothecarium."] = "{npc:270038}站在皇家藥劑師協會。",
	-- {npc:270038} Calder Gray · {zone:1441} Thousand Needles
	["{npc:270038}: Stormheart's heart from {zone:1441}"] = "{npc:270038}：{zone:1441}的風暴之心的心臟",

	-- Step 4: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飛往{area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "{zone:1458}飛行管理員",

	-- Step 5: Tarren Mill
	-- {npc:2229} Krusk · {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow
	["{npc:2229}, {npc:2410} and {npc:2437} are inside the inn; {npc:2770} stands outside it."] = "{npc:2229}、{npc:2410}和{npc:2437}在旅店裡；{npc:2770}站在旅店外。",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}，在裡面",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}，室內",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}，室內",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide"] = "{npc:2770}：給{area:321}的{npc:2771}，在本指南稍後",
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}，給{npc:2333}",

	-- Step 6: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik · {npc:2229} Krusk
	["Follow the road north out of {area:272} into the Alterac foothills: {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "沿道路向北離開{area:272}，進入奧特蘭克山麓：{quest:535}在辛迪加營地旁等候。只有你帶著{npc:2229}的「滲透」任務時他才會給任務：立刻把烈酒交給他，他的獎勵就是克魯斯克要的辛迪加信件。在這裡從辛迪加取得的信件也一樣：背包裡有一封時，指南會跳過{quest:535}。",

	-- Step 7: Syndicate missives
	["Syndicate missives"] = "辛迪加信件",
	-- {quest:535} Valik
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one."] = "僅限你沒從{quest:535}拿到信件時：道路西邊營地周圍的辛迪加劫匪和盜賊（32-34級）也帶著信件；約三分之一機率掉落。",

	-- Step 8: Alterac Mountains
	-- {npc:246848} Kirin Tor Guard
	["West along the foot of the hills, south of the road: a {npc:246848} (55) walks that road from the north-east down into the traitors' camp."] = "沿山腳向西走，在道路南邊：一名{npc:246848}（55級）會沿那條路從東北方走進叛徒營地。",
	-- {area:279} Dalaran
	["South of the {area:279} crater's camp"] = "{area:279}坑洞營地的南邊",

	-- Step 9: The Dalaran crater
	-- {area:279} Dalaran
	["The {area:279} crater"] = "",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token · Kirin Tor Guards = {npc:246848} Kirin Tor Guard · Kirin Tor Enforcers = {npc:276215} Kirin Tor Enforcer
	["From the south, walk up into the camp below the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together in the camp, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens: the ones on the camp's west side are furthest from the Guard's road.\nCareful: Kirin Tor Guards (55) attack the Horde on sight, and one of them patrols the road that comes down into the camp from the north-east and walks right up to the traitors: he has killed many players here. Watch for him, let him walk back up the road, then pull the traitors. Many of the camp's guards stand in linked pairs and others patrol alone. Arcane Sentries (55, elite) and Kirin Tor Enforcers (55) stand around the violet dome itself: keep to the camp below the rim."] = "從南邊走上{area:279}紫色穹頂下方的營地。{npc:2411}、{npc:2412}和{npc:2413}（33-34級）一起站在營地裡，{npc:2414}（35級）在他們西邊不遠；每人身上各帶一塊血石碎片。周圍的護盾衛兵和法術師（31-33級）會掉落用舊的石雕：營地西側的離守衛的巡邏路線最遠。\n注意：祈倫托守衛（55級）見到部落就會攻擊，其中一名沿著從東北方下到營地的道路巡邏，直接走到叛徒身邊：他在這裡殺過很多玩家。留意他，等他沿路走回去再拉叛徒。營地很多守衛是成對連動的，其他則單獨巡邏。奧術哨兵（55級，精英）和祈倫托執法者（55級）站在紫色穹頂周圍：待在坑緣下方的營地。",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "",
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Worn Stone Tokens, from the Shield Guards and Theurgists on the camp's west side"] = "用舊的石雕，來自營地西側的護盾衛兵和法術師",

	-- Step 11: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east along the foothills to {area:272}: everything from the first loop is handed in inside the inn."] = "沿山麓向東返回{area:272}：第一輪的所有任務都在旅店裡繳交。",

	-- Step 13: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north up the road past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "沿道路向北經過{quest:535}的營地，前往辛迪加佔據的村莊{area:280}（35-37級）。{npc:2431}帶著{item:3704}；{quest:503}被關在北側房子的籠子裡。\n注意：潛行的辛迪加間諜在{area:280}遊蕩，建築物裡有很多辛迪加怪物，其中包括法師。",
	["Inside"] = "在裡面",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "到頂層找到關著{quest:503}的地方",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}，在頂樓",
	-- {npc:2229} Krusk · {npc:2423} Lord Aliden Perenolde · {area:1339} Lordamere Lake
	["{npc:2229} will offer {npc:2423} (41, in his manor far up {area:1339}) for this: leave it, he is over your level."] = "{npc:2229}會因此給你{npc:2423}（41級，在{area:1339}遠處的莊園裡）的任務：別接，他等級比你高。",

	-- Step 14: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}：遇到就殺",
	-- {area:280} Strahnbrad · {area:1357} Gallows' Corner · {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["From {area:280} follow the road south-west to {area:1357} and on west to the ruins north of the {area:279} crater, along the lake shore. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "從{area:280}沿道路往西南走到{area:1357}，再往西沿湖岸前往{area:279}坑洞北邊的廢墟。達拉然召喚師帶著元素奴僕；護腕由元素奴僕掉落。小心：奧術哨兵（55級精英）和祈倫托守衛（55級）守著圓頂本身，會攻擊部落：在廢墟外圍打怪，別靠近圓頂。",

	-- Step 15: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "返回{area:272}",
	-- {area:272} Tarren Mill
	["Hearth back to {area:272} (your hearthstone is bound there), or walk back south-east along the road out of Alterac."] = "用爐石回{area:272}（你的爐石綁在那裡），或沿道路往東南走出奧特蘭克。",

	-- Step 16: Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth back to {area:272}: your hearthstone is bound there."] = "用爐石回{area:272}：你的爐石綁在那裡。",
	["The magus offers a dungeon errand next: leave it."] = "那位魔導師接下來提供的是一個地城差事：別接。",

	-- Step 17: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "向東穿過{area:1057}的道路",

	-- Step 18: Boulderfist camp
	["Boulderfist camp"] = "石拳營地",
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "",
	["Below ground"] = "地下",

	-- Step 19: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "沿路向東。紫色碎片在{area:321}以西不遠處的路旁發光。",

	-- Step 20: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}，在大門旁",
	-- {npc:12920} Doctor Gregory Victor · {skill:129} First Aid
	["{npc:12920}, at the south gate. If {npc:12920} offers nothing, another player may be running his {skill:129} quest Triage: he can be busy for a few minutes. Wait, then talk to him again."] = "{npc:12920}在南門。如果{npc:12920}沒有任務可接，可能是其他玩家正在進行他的{skill:129}任務「急救」：他可能會忙上幾分鐘。稍等一下再跟他對話。",

	-- Step 21: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "斯托姆加德的組隊任務",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "{npc:2703}的{quest:639}從斯托姆加德廢墟（高地西部）的精英辛迪加（35-38級）身上掉落。組隊去打經驗很豐厚：路線去內部法陣時會經過斯托姆加德。",

	-- Step 22: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "落錘鎮東北，枯須狗頭人在峽谷中採礦；洞口的狗頭人和深處的挖掘者、勘測員都掉落密斯萊爾之塵。\n小心：每種狗頭人殘血時都會跑去呼救（狗頭人30%，勘測員和挖掘者15%），可能引來更多。",

	-- Step 23: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701}在峽谷的最深處。",

	-- Step 24: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "每處{object:180105}都是一圈立石，鑰匙就放在正中的石頭上。東部的法陣在{area:321}西北的丘陵上。\n小心：每塊中心石都有約三個接近39級的元素生物看守，不清掉它們就點石頭會引來圍攻：西部是燃燒流放者，外部是雷霆流放者，東部是巨浪流放者。",

	-- Step 25: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "",

	-- Step 26: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "",

	-- Step 27: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}: the doctor stands at the south gate."] = "往北回到{area:321}：醫生站在南門。",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate. If he won't take the silk, another player may be running Triage: wait a few minutes and talk to him again."] = "{npc:12920}在南門。如果他不收絲布，可能是其他玩家正在進行「急救」任務：等幾分鐘再跟他對話。",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}，在南門",

	-- Step 28: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "石拳蠻兵在{area:321}西南方遠處的巨魔大廳外紮營；石拳法師站在他們之間。一次拉一隻。",

	-- Step 29: Fleshstalker raptors
	["Fleshstalker raptors"] = "獵獸龍",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "高地獵獸龍（36-37級）在南部高地獵食，一群在{area:316}北邊，另一群在它西邊的平原上。一次拉一隻。",

	-- Step 30: Go'shek Farm
	["Go'shek Farm"] = "戈謝克農場",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "{npc:2733}的實驗室棚屋在戈舍克農場，就在回{area:321}路上迅猛龍平原的東北；裝{item:278462}的箱子在裡面。",

	-- Step 31: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "返回{area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "向東北回到{area:321}。",

	-- Step 32: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "石拳的組隊任務",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "{npc:2771}的下一個{quest:678}和{npc:2772}的{quest:680}都是斯托姆加德食人魔區的精英食人魔（38-40級），和印記是同一次組隊行程。",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}，在他旁邊",

	-- Step 33: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "向西走；外部法陣在高地中部。",

	-- Step 34: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "西部法陣在{area:1057}附近，位於外部法陣的西北。",

	-- Step 35: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "內圈法陣在西邊法陣的南邊、激流堡的東邊。",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "石頭的下一個任務需要擊敗在{area:321}以西遊蕩的42級精英弗茲魯克：放著別管。",

	-- Step 36: Stromgarde
	["Stromgarde"] = "斯托姆加德",
	-- {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "內圈法陣西邊是激流堡廢墟：辛迪加佔據東半部（徽記由他們的咒術師、潛行者和魔法師掉落），石拳佔據西半部的{area:325}一帶（{npc:2773}在旁邊一間沒屋頂的房子裡）。",

	-- Step 37: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "向南前往南部海岸的哥布林海灣。{npc:2766}在海灣上方的懸崖上瞭望。",

	-- Step 38: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "護送教授上山，到海灣上方的洞穴，在他工作時守護他。兩隻40級水元素會在那裡伏擊他，且免疫冰霜。把它們擋在洞口、遠離他：如果戰鬥發生在洞內，他會參戰而不工作，還會不斷有更多水元素出現。",

	-- Step 40: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}：遇到就殺",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "在海灣西邊，刺脊襲擊者和刺脊巫師（38-40級）佔據海岸：一次拉一隻。兩艘沉船在外海的淺水中，海圖和航海日誌在船裡；寶石散落在沉船周圍的海底。",
	["Underwater"] = "在水下",

	-- Step 41: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "為{area:35}中的{npc:2487}，41級左右",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "下一份攻略會穿過{area:880}進入{zone:1437}，再前往{zone:1418}。",

	-- Step 42: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "僅當你組隊打了斯托姆加德時：回{area:321}交任務，然後前往{area:880}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:1763} poster by the inn"] = "旅店旁的{object:1763}海報",
}
