-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "40级的训练在{area:1497}：从{area:340}飞过去，学习技能，然后在城外的飞艇塔乘飞艇前往{object:3202}。",

	-- Step 2: Genavie Callow
	-- {npc:4486} Genavie Callow · {zone:1417} Arathi Highlands
	["{npc:4486} stands beside the flight master you land at: the Dabyrie heads from the {zone:1417}."] = "落地后找飞行管理员旁的{npc:4486}，把在{zone:1417}收集的达比雷一家头颅交给她。",
	-- {npc:4486} Genavie Callow
	["{npc:4486}, beside the flight master"] = "{npc:4486}在飞行管理员旁",

	-- Step 3: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458}的训练师",

	-- Step 4: Riding at 40
	["Riding at 40"] = "40级骑术",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "骑术需要40级，花费100金币；学会后会获得一只坐骑。各个种族都要找本族训练师学习。你的训练师是{area:159}的{npc:4773}，从飞艇塔骑行向北不远就到；她旁边是{npc:4731}出售的骷髅马（每匹20金币）。之后骑回高塔，乘飞艇前往{object:3202}。",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}，骑术训练师",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "骸骨军马：{npc:4731}，在{area:159}的{npc:4773}旁边。",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "乘飞艇前往{object:3202}",

	-- Step 6: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "{area:340}的飞行管理员",

	-- Step 7: Grom'gol Base Camp
	-- {npc:5814} Innkeeper Thulbek
	["{npc:5814}, by the flight master: hearth back here after the trainer trip at 40"] = "",
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "{npc:2519}：传说就在祖昆达废墟，本指南会去那里找{npc:1061}",
	-- {object:2076} Bubbling Cauldron · {npc:2519} Kin'weelay · {quest:1261} Marg Speaks · {npc:4791} Nazeer Bloodpike · {area:496} Brackenwall Village
	["the {object:2076} beside {npc:2519}: {quest:1261}, for {npc:4791} in {area:496} on the Dustwallow guide, where the crabs drop the pendant"] = "{object:2076}在{npc:2519}旁边，从大锅接{quest:1261}。按尘泥沼泽指南交给{npc:4791}，他在{area:496}，那里的螃蟹会掉落吊坠",
	-- {npc:2519} Kin'weelay · {quest:598} Split Bone Necklace
	["{npc:2519}: {quest:598}, the trophy skulls stand in the Skullsplitter ruins, on this guide's second loop"] = "找{npc:2519}接{quest:598}。按本指南走第二圈时，去劈颅废墟找颅骨堆",
	-- {npc:2497} Nimboya · {quest:2932} Grim Message · {zone:1425} Hinterlands
	["{npc:2497}: {quest:2932}, for the {zone:1425}, around level 48"] = "找{npc:2497}接{quest:2932}，留到去{zone:1425}时做，大约48级",

	-- Step 8: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "丛林捕猎者",
	-- {object:3202} Grom'gol · {npc:730} Tethis · {quest:195} Raptor Mastery
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights.\nCareful: {npc:730}, a level 43 elite raptor, roams among the stalkers: leave him for {quest:195}'s group step."] = "丛林捕猎者（40-41级）在{object:3202}南边的海岸捕猎。它们比你高得多：一次引一只，战斗间隙休息。\n小心：43级精英迅猛龙{npc:730}在捕猎者之间游荡：留到{quest:195}的组队步骤再打。",

	-- Step 10: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飞往{area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "{object:3202} 的飞行管理员。",

	-- Step 11: Drizzlik
	-- {npc:2495} Drizzlik
	["{npc:2495}'s shop is in the building east of the inn."] = "{npc:2495}的商店在旅店东边的建筑里。",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495}：交还之前收集的钳嘴龟皮；他在屋内",

	-- Step 12: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "飞行管理员格林戈在{area:35}的上层平台等候。任务给予者分布在海港周围的栈道和旅店里。",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}：{npc:2635}在祖昆达废墟和{object:3202}之间的海岸上晒太阳，本轮路线稍后会经过",

	-- Step 13: Kebok
	-- {npc:737} Kebok
	["{npc:737} stands upstairs, beside the flight master."] = "{npc:737}站在楼上，飞行管理员旁边。",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals from the earlier Stranglethorn guide"] = "{npc:737}：上一篇荆棘谷指南中的翻滚水晶（{item:4106}）",

	-- Step 14: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs, has his next errand now: the Skullsplitter tusks come from the trolls of Zul'Mamwe, later on this loop."] = "楼上的{npc:737}现在有下一个差事：劈颅獠牙来自祖玛维的巨魔，在本轮路线稍后。",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}：在楼上",

	-- Step 15: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "码头上的{npc:4631}：如果你带着加兹鲁维的信，交给他",
	-- {npc:4631} Wharfmaster Lozgil · {quest:97332} Twice Misplaced Trust · {npc:259961} Wharfmaster Whizzbuzz · {area:16727} Powderfuse Port · {zone:2548} Riverglades
	["{npc:4631}: {quest:97332}, after Zimmix's rescue; the package goes to {npc:259961} at {area:16727}, in the {zone:2548} guide"] = "{npc:4631}：{quest:97332}，在救出齐米克斯之后；包裹要交给{area:16727}的{npc:259961}，见{zone:2548}指南",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”马克基雷，位于最顶层",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}，在马克基雷旁边的阳台上",
	-- {npc:2496} Baron Revilgaz · {area:37} Lake Nazferiti
	["{npc:2496}: Cozzle's footlocker is in his house by {area:37}, on your way north to Nesingwary"] = "{npc:2496}的任务要找考兹尔的箱子，箱子在{area:37}旁考兹尔的屋里。往北去找奈辛瓦里时顺路拿",
	["Inside"] = "在里面",

	-- Step 16: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "从隧道出城；信件在{area:35}正北的海盗海湾里。",

	-- Step 18: Mistvale gorillas
	["Mistvale gorillas"] = "迷雾谷猩猩",
	-- {quest:348} Stranglethorn Fever
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: if you will take {quest:348} with a group, keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "大猩猩在安巴格瓦周围的山谷里游荡。长者掉落内脏；任何一只都可能掉落獠牙：如果你要和队伍一起接{quest:348}，就为安巴格瓦留十个，他的莫克（44）在你大约45级的荆棘谷那一站等着。\n小心：薄雾谷长者大猩猩（40-41）在山谷里站得很近：一次拉一只。",
	-- {quest:348} Stranglethorn Fever
	["Keep fangs from these same elders for Unbagwa ({quest:348}, with a group)."] = "从这些长者身上留着獠牙给安巴格瓦（{quest:348}，需要组队）。",

	-- Step 19: Mistvale giblets
	["Mistvale giblets"] = "迷雾谷猩猩的内脏",

	-- Step 20: Mistvale gorillas at 39
	["Mistvale gorillas at 39"] = "39级打迷雾谷猩猩",
	["Look for lone level 40 elders in this same camp for the sinew and giblets. Leave level 41 gorillas alone; don't stay just for extra fangs."] = "在这个营地找落单的40级老迈的迷雾谷猩猩，打肌腱和内脏。避开41级的猩猩，别为了多打猩猩牙在这里多留。",

	-- Step 21: Venture Co. mine
	["Venture Co. mine"] = "风险投资公司矿洞",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "再往北，风险投资公司的地精在道路东侧矿场挖掘；矿工、工头、勘探员和工匠都会掉落水晶。\n小心：营地周围有潜行的深喉猎豹和荆棘谷雌虎游荡。",

	-- Step 22: Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Shadowmaw Panthers"] = "深喉猎豹",
	-- {quest:192} Panther Mastery
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["{quest:192} is still open: the Shadowmaw Panthers (37-38) stalk the jungle north of the mine, towards the Mosh'Ogg hills. They use Sneak, so they show only when you are close: pull them one at a time, and leave the Elder Shadowmaw Panthers (42-43) alone."] = "{quest:192}仍未完成：深喉猎豹（37-38级）在矿井北边的丛林中潜行，朝向莫什奥格山丘。它们会潜行，所以只有靠近才会现身：一次只拉一只，别去惹老年深喉猎豹（42-43级）。",

	-- Step 24: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "鞭尾迅猛龙",
	-- {quest:195} Raptor Mastery · {object:3202} Grom'gol
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:195} is still open: the Lashtail Raptors (35-36) hunt the jungle between {object:3202} and Nesingwary's camp, on your way north."] = "{quest:195}仍未完成：鞭尾迅猛龙（35-36级）在{object:3202}和奈辛瓦里远征队营地之间的丛林中狩猎，顺路向北。",

	-- Step 25: Foreman Cozzle's house
	-- {npc:4723} Foreman Cozzle
	["{npc:4723}'s house"] = "{npc:4723}的房屋",
	-- {npc:4723} Foreman Cozzle · {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Agents = {npc:260429} Venture Co. Agent
	["On the way north, a short way east of the road: {npc:4723}'s house stands on the north shore of {area:37}. {npc:4723} (38) carries the key to his footlocker, inside the house; the Venture Co. Agents (39) stand in and around it: pull them one at a time. Then on north-west to Nesingwary's camp."] = "往北走时，从大路往东走一小段。{npc:4723}的房屋就在{area:37}北岸。{npc:4723}（38级）带着屋内箱子的钥匙。屋里和屋外都有风险投资公司密探（39级），一次只引一个。之后往西北去奈辛瓦里的营地。",
	-- {object:20691} Cozzle's Footlocker
	["{object:20691}, inside the house"] = "{object:20691}在屋里",

	-- Step 26: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的营地",
	["Head north up the road; the hunters camp on the hill above the river."] = "沿路向北；猎人们在河流上方的山丘扎营。",

	-- Step 27: Sin'Dall
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["{npc:729}, the tiger {npc:717} sent you after on your last visit, prowls the hilltop just south-west of the camp."] = "{npc:729}，就是你上次来时{npc:717}让你去追杀的那只老虎，在营地西南边不远的山顶徘徊。",

	-- Step 30: Nesingwary's camp
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路线之前来这里时错过了这一步：现在先做它。它很快，还会开启后面的任务。",

	-- Step 31: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716}收集《{quest:338}》的书页：荆棘谷的巨魔不时会掉落。接下他的任务；凑齐某一章的全部书页后，他就会收下那一章。",

	-- Step 32: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}：第一章的全部书页都在背包里",

	-- Step 33: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}：第二章的全部书页都在背包里",

	-- Step 34: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}：第三章的全部书页都在背包里",

	-- Step 35: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}：第四章的全部书页都在背包里",

	-- Step 36: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}：四个章节",

	-- Step 37: Zul'Kunda
	["Zul'Kunda"] = "祖昆达废墟",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {object:3202} Grom'gol · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "在远征队营地西边，血顶酋长{npc:1061}和{npc:1062}一起站在祖昆达废墟里。先清掉他们的守卫，再引他们。\n在祖昆达废墟和{object:3202}之间的海岸上，{npc:2635}（38级精英）与普通鳄鱼共享刷新点：如果它在，就击杀它并拿走它的皮交给{npc:2495}。",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "从废墟里的{object:52}处取得",

	-- Step 38: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}，在{npc:2497}旁边",
	-- {npc:2519} Kin'weelay
	["{npc:2519}, if you didn't take it on the first stop: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "如果第一趟没接，这次找{npc:2519}接。沿这条环线继续走，颅骨堆在劈颅废墟",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}：洞穴入口在营地西边的{area:104}下方",

	-- Step 39: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1454} Orgrimmar · {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {zone:1444} Feralas
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{zone:1454}：{npc:4752}在{object:172958}的{npc:3362}狼舍旁教兽人骑术（狼每只20金）。然后乘飞艇返回{object:3202}。金币不够？跳过此步骤：{zone:1444}指南会在45级左右再次经过{zone:1454}。"
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then hearth back to {object:3202}, or take the zeppelin if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}，骑术训练师",

	-- Step 40: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:367} Sen'jin Village · {npc:7953} Xar'Ti · {zone:1444} Feralas
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{zone:1454}，沿{zone:1411}的道路向南前往{area:367}：{npc:7953}在那里教巨魔骑术，旁边有卓尼尔的迅猛龙（每只20金）。然后返回飞艇前往{object:3202}。金币不够？跳过此步骤：{zone:1444}指南会在45级左右再次经过{zone:1454}。"
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then hearth back to {object:3202}, or take the zeppelin from {zone:1454} if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}，骑术训练师",

	-- Step 41: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {zone:1444} Feralas
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{zone:1454}，飞往{zone:1456}再骑行下山前往{area:222}：{npc:3690}在那里教牛头人骑术，旁边有{npc:3685}的科多兽（每只20金）。然后飞回{zone:1454}乘飞艇前往{object:3202}。金币不够？跳过此步骤：{zone:1444}指南会在45级左右再次经过{zone:1456}。"
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then hearth back to {object:3202}, or fly back to {zone:1454} for the {object:3202} zeppelin if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，骑术训练师",

	-- Step 42: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {zone:1444} Feralas
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "骑术需要40级，花费100金；学会后会获得一匹疾风行者，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{zone:1454}，再飞往{zone:1456}：前往{zone:2521}的天空之船大约每五分钟从{zone:1456}北边、{area:17045}南面的悬崖出发，{npc:265756}在{area:16638}的{area:17684}教天裔骑术。然后返回{zone:1454}乘飞艇前往{object:3202}。金币不够？跳过此步骤：{zone:1444}指南会在45级左右再次经过{zone:1454}。"
	["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then hearth back to {object:3202}, or go back to {zone:1454} for the {object:3202} zeppelin if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756}, riding trainer, at the {area:17684} in {area:16638}"] = "{npc:265756}，骑术训练师，在{area:16638}的{area:17684}",

	-- Step 43: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol · {zone:1458} Undercity · {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1444} Feralas · {zone:1446} Tanaris
	-- was: ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {zone:1458}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} & {zone:1446} guide passes the {zone:1458} again at about 45."] = "骑术需要40级，花费100金，学会后会获得一匹坐骑。没坐骑的话，离开荆棘谷后走{zone:2548}这段路要很久。从{object:3202}的飞艇塔乘飞艇去{zone:1458}的飞艇塔。{npc:4773}在{area:159}教被遗忘者骑术，往北骑一小段就到。{npc:4731}也在那里卖骸骨军马(每匹20金)。然后乘飞艇返回{object:3202}。金币不够就跳过这步，{zone:1444}和{zone:1446}指南还会经过{zone:1458}，那时大约45级。"
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {zone:1458}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then hearth back to {object:3202}, or take the zeppelin if your hearthstone is cooling down. Short of gold? Skip this step: the {zone:1444} & {zone:1446} guide passes the {zone:1458} again at about 45."] = "",

	-- Step 44: Your mount at 40
	["Your mount at 40"] = "40级的坐骑",
	-- {zone:1454} Orgrimmar · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Warlocks don't buy riding: your mount is the Felsteed, from your class quest. Zevrost in {zone:1454}'s {object:172960} starts it and {npc:6251} in {area:392} teaches it, both on the {zone:1444} guide's {zone:1454} stop at about 45."] = "术士不用购买骑术：你的坐骑是地狱战马，来自职业任务。任务由{zone:1454}{object:172960}的泽沃斯特开始，由{area:392}的{npc:6251}传授，两者都在{zone:1444}指南中约45级的{zone:1454}一站完成。",
	-- {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Felsteed: Zevrost in {zone:1454}, then {npc:6251} in {area:392}, on the {zone:1444} guide's {zone:1454} stop."] = "地狱战马：先找{zone:1454}的泽沃斯特，再找{area:392}的{npc:6251}，在{zone:1444}指南的{zone:1454}一站完成。",

	-- Step 45: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}：在{object:3202}西边，游到{area:104}上方，潜入礁石中的洞穴入口；找到入口时任务即完成。暂时不要进入洞穴：丛林捕猎者在沿海岸往南的地方。",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "{area:16550}的入口，位于水下",

	-- Step 46: Jungle stalkers
	["Jungle stalkers"] = "丛林捕猎者",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast.\nCareful: the Jungle Stalkers (40-41) are thick here: pull one at a time and rest between fights."] = "丛林捕猎者迅猛龙在{object:3202}南边的丛林里捕猎，一直到西海岸。\n小心：这里的丛林捕猎者（40-41级）很密集：逐只拉怪，战斗间隙休息。",
	["The naga explorers on the coast south of here (43-44) are for Bloads and Mok'thardin: keep both quests for your Stranglethorn stop at about 45."] = "南边海岸上的纳迦探险者（43-44级）是布洛兹和摩克萨尔丁的任务目标：两个任务都保留，留到约45级再来荆棘谷时完成。",

	-- Step 47: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "向南前往 {area:35}。“病鬼”菲利普 在码头等着。",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony"] = "{npc:2496}在阳台上",
	-- {npc:2496} Baron Revilgaz · {area:2240} Mirage Raceway · {zone:1444} Feralas · {zone:1446} Tanaris
	["{npc:2496}: for Pozzik at the {area:2240}, on the {zone:1444} & {zone:1446} guide's way"] = "在{npc:2496}处接，之后交给{area:2240}的普兹克。按{zone:1444}和{zone:1446}指南走时会顺路经过",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "{npc:737}在楼上：獠牙来自劈颅巨魔，本轮路线稍后会经过",
	["MacKinley: keep it, the ghost pirates (43-44) wait for your Stranglethorn stop at about 45"] = "麦金雷：保留任务，幽灵海盗（43-44级）留到约45级再来荆棘谷时处理",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}，在屋内：交还{item:4105}",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["{npc:2493}: keep it for the {area:43} at about 45"] = "{npc:2493}：保留任务，约45级时去{area:43}完成",
	-- {npc:2487} Fleet Master Seahorn · {area:43} Wild Shore
	["{npc:2487}: keep it for the {area:43} at about 45"] = "{npc:2487}：保留任务，约45级时去{area:43}完成",
	-- {npc:2488} Deeg · {area:43} Wild Shore
	["{npc:2488}, on the top floor: keep it for the {area:43} at about 45"] = "{npc:2488}，位于最顶层：保留任务，约45级时去{area:43}完成",

	-- Step 48: Whiskey Slim and Fin Fizracket
	-- {npc:2491} Whiskey Slim · {npc:2486} Fin Fizracket
	["{npc:2491} and {npc:2486}"] = "{npc:2491}和{npc:2486}",
	-- {npc:2491} Whiskey Slim · {zone:1444} Feralas · {zone:1446} Tanaris · {area:35} Booty Bay
	["{npc:2491}, in the inn, and \"Sea Wolf\" MacKinley, on the top floor, offer these quests from level 40: pick them up now. Under 40, the {zone:1444} & {zone:1446} guide's {area:35} stop offers them again."] = "旅店里的{npc:2491}和顶楼的“海狼”马克基雷从40级起提供这些任务：现在就接。不到40级的话，{zone:1444}和{zone:1446}指南的{area:35}那一站会再次提供。",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}在旅店里：他的酒瓶被冲到了{zone:1425}海岸，约48级时再去",
	-- {quest:2872} Stoley's Debt · {zone:1446} Tanaris
	["MacKinley, on the top floor: {quest:2872}, for Stoley in {zone:1446}"] = "在顶层的马克基雷处接{quest:2872}，交给{zone:1446}的斯杜雷",

	-- Step 49: Fin Fizracket
	-- {quest:348} Stranglethorn Fever · {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["Group quest: {quest:348} ends at {npc:1449} in Mistvale. Hand him ten gorilla fangs and he calls three waves of gorillas (41-42), one after another, then {npc:1514} (44). In players' recordings, 12 of the 27 people who started it died there. Take it if you have a friend or two along."] = "小队任务：{quest:348}在薄雾山谷的{npc:1449}处结束。交给他十颗大猩猩獠牙，他会召来三波大猩猩（41-42），一波接一波，然后是{npc:1514}（44）。玩家记录中，开始此任务的27人里有12人死在那里。如果有一两个朋友同行就接。",
	-- {npc:2486} Fin Fizracket · {zone:1444} Feralas · {object:3202} Grom'gol
	["{npc:2486}, beside the inn: Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}，在旅店旁边：安巴格瓦那部分在{zone:1444}指南的{object:3202}那一站",

	-- Step 50: The Bloodsail ships
	["The Bloodsail ships"] = "血帆海盗船",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["The scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs, with captains of 45-48: take it with a group. Its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "卷轴{quest:624}位于{area:43}外海三艘船的甲板上，船上的海盗为42-45级，常成对行动，船长为45-48级：请组队去取。后续任务会经过{zone:1435}、{zone:1445}和{zone:1425}。",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "留到之后在{zone:1435}停留时",

	-- Step 51: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly back to {object:3202}: Zul'Mamwe's Skullsplitters are just east of it."] = "飞回{object:3202}：祖玛维的碎颅巨魔就在它东边。",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 52: Zul'Mamwe
	["Zul'Mamwe"] = "祖玛维废墟",
	["The warriors in the northern ruins (39-40) drop both tusks and necklaces. Pull from the edge; leave the chief and his two guards to the south alone."] = "北边废墟的战士(39-40)既掉獠牙，也掉项链。从外围引怪，避开南边的首领和他的两名守卫。",

	-- Step 53: Zul'Mamwe and Balia'mah trophy skulls
	["Zul'Mamwe and Balia'mah trophy skulls"] = "祖玛维和巴里亚曼的颅骨堆",
	-- {object:3202} Grom'gol
	["Look for the trophy skulls in the small ruins north of Zul'Mamwe's warriors.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "去祖玛维战士营地北边的小废墟找颅骨堆。\n最后的颅骨堆在西边走不远的废墟里，就在回{object:3202}的路上。",

	-- Step 54: Kin'weelay
	-- {object:3202} Grom'gol
	["Head west to {object:3202}."] = "向西前往 {object:3202}。",

	-- Step 57: Grom'gol Base Camp
	-- {npc:2464} Commander Aggro'gosh · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {zone:2548} Riverglades
	["{npc:2464}: for {npc:256418} in {area:16743}, the {zone:2548}' Horde fort, in the next guide"] = "{npc:2464}：交给下一份指南中{zone:2548}部落要塞{area:16743}的{npc:256418}",
	-- {quest:571} Mok'thardin's Enchantment · {quest:621} Zanzil's Secret · {npc:737} Kebok · {area:35} Booty Bay · {zone:2548} Riverglades
	["Keep {quest:571}, {quest:621} and {npc:737}'s tusks: the Skullsplitter chief, Zanzil's camps, the naga coast and {area:35} come on your Stranglethorn stop at about 45, after the {zone:2548}."] = "保留{quest:571}、{quest:621}和{npc:737}的獠牙任务：碎颅首领、赞吉尔的营地、纳迦海岸和{area:35}都留到{zone:2548}之后、约45级再来荆棘谷时完成。",

	-- Step 59: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "沿路向北前往猎人营地。",

	-- Step 61: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:730}是43级精英，多数职业到45级可以单独击败，但可能仍需帮助。独自一人时请跳过。",

	-- Step 62: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:728}是40级精英，多数职业到42级可以单独击败，但可能仍需帮助。独自一人时请跳过。",

	-- Step 66: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:731}是43级精英，多数职业到45级可以单独击败，但可能仍需帮助。独自一人时请跳过。\n小心：附近有老虎和潜行的深喉猎豹，先清理再拉它。拉到{npc:731}时，它会召集20码内的生物支援。",

	-- Step 71: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "进入{zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "从{zone:1431}沿路向东，经过{zone:1430}进入沼泽。{npc:1776}在{area:657}等候；那是靠近{zone:1430}入口、道路旁的德莱尼营地。",

	-- Step 72: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "向东前往{area:75}，就在路南的芦苇丛中。",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}：在屋内",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}：在楼上",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}，位于最顶层",

	-- Step 73: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "盐齿鳄鱼",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "鳄鱼在{npc:5391}营地周围的水塘里打滚，一直到南边的{area:75}；大约四分之一会掉落鳄鱼肉。",

	-- Step 74: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "木棒诺博鲁在{area:76}西南的空地上游荡；他的木棒可以开始一个任务。",

	-- Step 75: Draenethyst crystals
	["Draenethyst crystals"] = "德莱尼水晶",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Head north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "向东北前往{area:76}。水晶分布在通往{npc:5391}笼子的路上。",

	-- Step 76: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391}被关在沼泽东北的{area:76}。救出他并跟着他出去，击退追赶他的沼泽生物。",

	-- Step 77: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "他的保险箱在{area:75}北边的旧营地里，向西返程时会经过。",

	-- Step 78: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "沿路向西前往{area:657}的德莱尼营地，就在从{zone:1430}进来的路口附近。",

	-- Step 79: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east along the road, past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}. Only Sawfin Frenzies (38-40) swim there."] = "沿路向东返回，经过{area:75}。阿塔莱神器在{quest:1424}的水里和岸边，水里只有锯鳍狂鱼(38-40)。",

	-- Step 80: Misty Reed Post
	-- {npc:5592} Tok'Kar · {npc:5593} Katar
	["Follow the road south-east to the small Horde post on the shore: {npc:5592} takes the crocolisk flanks, and {npc:5593} stands beside him."] = "沿路往东南走，到岸边的部落小哨站。{npc:5592}收新鲜的盐齿鳄鱼肉，{npc:5593}就在他旁边。",

	-- Step 81: Sawtooth snappers
	["Sawtooth snappers"] = "盐齿钳嘴鳄",
	-- {npc:272377} Methuselah Crab
	-- plural, as words: Sawtooth Snappers = {npc:1087} Sawtooth Snapper
	["The Sawtooth Snappers (41-42) line the strand south of the post; nearly every one drops a claw. Leave the murlocs further along the shore for your next swamp visit.\nCareful: a {npc:272377} (level 60) walks the south-east strand: give it a wide berth."] = "哨站以南的岸边都是盐齿钳嘴鳄(41-42)，几乎每只都会掉一只爪子。沿海岸再往前的鱼人留到下次来沼泽再打。\n小心，东南边的岸上有一只{npc:272377}(60级)在巡游，绕远一点。",

	-- Step 82: Misty Reed Post
	-- {npc:5593} Katar
	["{npc:5593}: the murlocs (41-44) wait for your next swamp visit"] = "{npc:5593}的任务要打鱼人(41-44)，留到下次来沼泽再做",

	-- Step 83: Stonard
	-- {area:75} Stonard · {npc:1443} Fel'zerul · {quest:1430} Fresh Meat · {npc:5593} Katar
	["Back north-west along the road to {area:75}: {npc:1443}, on the top floor, takes the artifacts. {quest:1430}'s crawlers and {npc:5593}'s murlocs wait for your next swamp visit."] = "沿路往西北回到{area:75}，把神器交给顶层的{npc:1443}。{quest:1430}的螃蟹和{npc:5593}任务里的鱼人都留到下次来沼泽再打。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Below ground"] = "在地下",
	-- ["Boat to {area:35}"] = "乘船前往{area:35}",
	-- ["Fly to {area:392}"] = "飞往{area:392}",
	-- ["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "沿海岸向南。纳迦探险者在岸边涉水而行，携带一捆海蛇草；{object:759}就在他们正东的山丘里冒泡。",
	-- ["From {area:2408} fly to {area:392}."] = "从{area:2408}飞往{area:392}。",
	-- ["From {object:3202} head east to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. One pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all. Careful: {npc:1059} (45) walks the south-western ruins with two guards; Speaking with {npc:1061}'s last piece, his Broken Armor, waits for your Stranglethorn stop at about 45."] = "从{object:3202}向东前往风险投资公司矿洞东边的碎颅废墟；逐只拉猎头者和狂暴者。一堆战利品头骨位于废墟北侧。每个碎颅巨魔都可能掉落獠牙或项链：项链掉得慢，所以在废墟北边的战士营地继续击杀，直到凑齐。小心：{npc:1059}（45级）带着两名卫兵在西南废墟巡逻；“与{npc:1061}谈话”的最后一件物品——他的破损护甲，留到约45级再来荆棘谷时获取。",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "再往北，风险投资公司的地精在道路东边的矿洞里挖掘；矿工、工头、勘探员和修理工都会掉落水晶。",
	-- ["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "把猩猩牙交给安巴格瓦并待在他身边：他会召唤三波猩猩，然后是{npc:1514}。一次对付一个。",
	-- ["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "向北前往风险投资公司矿场以东的劈颅废墟；逐个引出猎头者和狂战士。{npc:1059} 把守着西南边的废墟，废墟北边有一堆战利品头骨。每个劈颅巨魔都可能掉落獠牙或项链：项链比较难凑齐，因此到废墟北边的战士营地继续击杀，直到集齐。",
	-- ["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "沿路向西前往{area:657}的德莱尼营地，靠近从{zone:1430}过来的入口。{quest:698}留到下次来沼泽时，交给{area:1978}的{npc:5592}：保留鳄鱼肉。",
	-- ["Hearth to {area:35}"] = "用炉石回到{area:35}",
	-- ["Hearth to {object:3202}"] = "用炉石回到{object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "他的保险箱在{area:75}北边他原来的营地里。",
	-- ["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "如果跳过了{quest:192}或{quest:195}，就在这里刷怪到42.68级，跟上路线的等级规划。",
	-- ["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "如果跳过了{quest:208}，就在这里刷怪到42.74级，跟上路线的等级规划。",
	-- ["Inside {area:1742}"] = "在{area:1742}内部",
	-- ["Into the {area:8}"] = "进入{area:8}",
	-- ["Ironjaw Basilisks"] = "铁腭蜥蜴",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "继续向北骑进{zone:1431}，然后沿道路向东穿过{zone:1430}进入沼泽。{npc:1776}在{area:657}等候，那是靠近{zone:1430}入口的德莱尼营地。",
	-- ["Level 42.68"] = "等级 42.68",
	-- ["Level 42.74"] = "等级 42.74",
	-- ["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "顶层的“海狼”马克基雷：交给{zone:1446}的斯杜雷",
	-- ["Naga shore and the {object:759}"] = "纳迦海岸和{object:759}",
	-- ["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "在迷雾谷东北，赞吉尔的追随者在丛林里扎营；他们每个人都可能携带赞吉尔的药剂。",
	-- ["Optional, and tough at 42: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "可选任务，42级时难度很高：卷轴{quest:624}位于{area:43}外海三艘船的甲板上，船上的海盗为42-45级，常成对行动。只有能把船员逐只引到船舷边，或有朋友同行时才去取；后续任务会经过{zone:1435}、{zone:1445}和{zone:1425}。",
	-- ["Pirate ghosts"] = "海盗幽灵",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "向东骑回{area:75}，沿道路向东南前往岸边的部落小哨站。",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "向东骑往道路南边芦苇丛中的{area:75}。",
	-- ["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "沿道路向北离开{area:35}；返回{object:3202}途中，丛林中段道路东侧的岩石上有蜥蜴晒太阳。它们的碎片掉率很高。",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "向北骑往风险投资公司矿洞东边的劈颅巨魔废墟；把猎头者和狂战士一个个引出来。{npc:1059}守卫着西南边的废墟，一堆颅骨堆就在废墟北侧。每个劈颅巨魔都可能掉落獠牙或项链：项链是最慢的部分，所以在废墟北边的战士营地里一直杀，直到拿齐为止。",
	-- ["Ride north up the road to the hunters' camp."] = "沿道路向北骑往猎人营地。",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "沿道路向北骑行；猎人们在河上方的山丘上扎营。",
	-- ["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "向东北骑往{area:76}。水晶分布在通往{npc:5391}笼子的路上。",
	-- ["Ride north-west to {object:3202}."] = "向西北骑往{object:3202}。",
	-- ["Ride on north to {object:3202}."] = "继续向北骑往{object:3202}。",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "向南骑往{area:35}。“病鬼”菲利普在码头上等候。",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "沿道路向西骑往{area:657}的德莱尼营地，靠近{zone:1430}的入口。",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "沿路骑行向西，前往{area:657}的德莱尼营地，靠近从{zone:1430}过来的入口。{quest:698}留到下次来沼泽时，交给{area:1978}的{npc:5592}；保留鳄鱼肉。",
	-- ["Ride west to {object:3202}."] = "向西骑往{object:3202}。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "骑术需要40级，花费100金；学会后会获得一匹疾风行者，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{zone:1454}，再飞往{zone:1456}：前往{zone:2521}的天空之船大约每五分钟从{zone:1456}北边、{area:17045}南面的悬崖出发，{npc:265756}在{area:16638}的{area:17684}教天裔骑术。然后返回{zone:1454}乘飞艇前往{object:3202}。金币不够？跳过此步骤：{zone:1444}指南会在45级左右再次经过{zone:1454}。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {area:1497}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1435} guide passes the {area:1497} again at about 47."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{area:1497}的飞艇塔：{npc:4773}在北边不远的{area:159}教被遗忘者骑术，旁边有{npc:4731}的骸骨战马（每匹20金）。然后乘飞艇返回{object:3202}。金币不够？跳过此步骤：{zone:1435}指南会在47级左右再次经过{area:1497}。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {zone:1458}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} & {zone:1446} guide passes the {zone:1458} again at about 45."] = "骑术需要40级，花费100金，学会后会获得一匹坐骑。没坐骑的话，离开荆棘谷后走{zone:2548}这段路要很久。从{object:3202}的飞艇塔乘飞艇去{zone:1458}的飞艇塔。{npc:4773}在{area:159}教被遗忘者骑术，往北骑一小段就到。{npc:4731}也在那里卖骸骨军马(每匹20金)。然后乘飞艇返回{object:3202}。金币不够就跳过这步，{zone:1444}和{zone:1446}指南还会经过{zone:1458}，那时大约45级。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{zone:1454}，沿{zone:1411}的道路向南前往{area:367}：{npc:7953}在那里教巨魔骑术，旁边有卓尼尔的迅猛龙（每只20金）。然后返回飞艇前往{object:3202}。金币不够？跳过此步骤：{zone:1444}指南会在45级左右再次经过{zone:1454}。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{zone:1454}，飞往{zone:1456}再骑行下山前往{area:222}：{npc:3690}在那里教牛头人骑术，旁边有{npc:3685}的科多兽（每只20金）。然后飞回{zone:1454}乘飞艇前往{object:3202}。金币不够？跳过此步骤：{zone:1444}指南会在45级左右再次经过{zone:1456}。",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "骑术需要40级，花费100金；学会后会获得一匹坐骑，而荆棘谷之后的{zone:2548}没有坐骑要走很久。从{object:3202}的塔乘飞艇前往{zone:1454}：{npc:4752}在{object:172958}的{npc:3362}狼舍旁教兽人骑术（狼每只20金）。然后乘飞艇返回{object:3202}。金币不够？跳过此步骤：{zone:1444}指南会在45级左右再次经过{zone:1454}。",
	-- ["Skullsplitter warriors"] = "劈颅战士",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "在藏宝海湾南边，血帆流氓在{area:43}扎营；血帆海图和血帆计划书就在他们的帐篷里，以及较大营地旁的小船里。任何血帆海盗都可能携带鼻烟和{npc:2493}的眼睛，所以一直杀到两样都拿到为止。",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "沿道路向北离开{area:35}；安巴格瓦坐在道路东边{area:1737}的一座山丘上。",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "丛林捕猎者（40-41级）在{object:3202}南边的海岸捕猎。它们比你高得多：一次引一只，战斗间隙休息。",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "船停靠在{area:35}的港口。任务给予者站在港口周围的木栈道上和旅店里。",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "前往{area:35}的船停靠在{area:392}码头的尽头。",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "猩猩在安巴格瓦周围的山谷里游荡。老迈的猩猩掉落内脏；任何猩猩都可能掉落猩猩牙。",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "猩猩在乌巴瓦周围的山谷中游荡。老迈的猩猩掉落内脏；所有猩猩都可能掉落尖牙：留十个给乌巴瓦，他的莫克（44级）等你在45级左右再来荆棘谷时再做。\n小心：老迈的迷雾谷猩猩（40-41级）在山谷中站得很密：一次引一只。",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "最后的颅骨堆在西边不远的废墟里，就在回{object:3202}的路上。",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "下一个指南从这里开始，带你前往{zone:1446}。",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "下一堆颅骨堆在战士营地正北的小废墟里。",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "下一堆颅骨堆在战士营地正北的小废墟里。\n最后的颅骨堆在西边不远的废墟里，走几步就到，就在回{object:3202}的路上。",
	-- ["The snappers line the strand south of the post."] = "钳嘴鳄分布在哨站南边的海滩上。",
	-- ["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "丛林捕猎者迅猛龙在{object:3202}南边的丛林里捕猎，一直到西海岸。",
	-- ["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "三个海盗幽灵在{area:35}北边、赞吉尔营地附近的丛林里出没：{npc:2535}和{npc:2536}站在一起，{npc:2537}在更东边。",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "三艘船停在{area:43}外的海面上。船员是42-45级，斯蒂沃特船长45级，尼哈鲁船长46级，{npc:2546}48级：41级时这是小队的战斗，或者留到本指南结束时再来。如果要去，就游过去，把船员一个个引到船舷边。船的甲板上有一张卷轴{quest:624}：拿上它。",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:728}是 40 级精英，多数职业到 42 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:730}是 43 级精英，多数职业到 45 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:731}是 43 级精英，多数职业到 45 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。\n注意：附近有老虎和潜行的暗影黑豹，先清理再拉首领。拉到{npc:731}时，它会召集 20 码内的生物支援。",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "在远征队营地西边，血顶酋长{npc:1061}和{npc:1062}一起站在祖昆达废墟里。先清掉他们的守卫，再引他们。",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "远征队西边，血顶酋长{npc:1061}和{npc:1062}一起待在祖昆达废墟。先清掉卫兵，再引他们。在这里继续击杀血顶巨魔直到41级：下一站大锅处的{quest:586}会让你去对付41-43级的劈颅巨魔。\n在祖昆达废墟和{object:3202}之间的海岸上，{npc:2635}（38级精英）与普通鳄鱼共享刷新点：如果它在，就击杀它并拿走它的皮交给{npc:2495}。",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43. Or, with a group, run the {area:1517} dungeon instead."] = "远征队西边，血顶酋长{npc:1061}和{npc:1062}一起待在祖昆达废墟。先清掉卫兵，再引他们。在这里继续击杀血顶巨魔直到41级：下一站大锅处的{quest:586}会让你去对付41-43级的劈颅巨魔。也可组队挑战{area:1517}副本。",
	-- ["Zanzil's camps"] = "赞吉尔的营地",
	-- ["for Stoley in {zone:1446}"] = "交给{zone:1446}的斯杜雷",
	-- ["for a later stop in the {area:8}"] = "留到之后在{area:8}停留时",
	-- ["for later: the {zone:1425}, around level 48"] = "留到之后：{zone:1425}，大约48级时",
	-- ["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "在这里刷血顶巨魔升级：下一站大锅处的{quest:586}会让你去对付41-43级的劈颅巨魔",
	-- ["grind on {npc:667}"] = "击杀{npc:667}刷经验",
	-- ["the {object:2076}"] = "{object:2076}",
	-- ["the {object:2076} again: Yenniku's fate"] = "再次到{object:2076}处：耶尼库的命运",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}，在{npc:2497}旁边",
	-- ["{area:127}: kill these as you meet them"] = "{area:127}：沿途遇到就击杀",
	-- ["{area:1497} trainers"] = "{area:1497}的训练师",
	-- ["{area:1577}: kill these as you meet them"] = "{area:1577}：沿途遇到就击杀",
	-- ["{area:35} flight master"] = "{area:35}的飞行管理员",
	-- ["{area:392} pier"] = "{area:392}码头",
	-- ["{npc:2486}: {quest:348} (offered from 40), Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}：{quest:348}（40级起可接），温巴格瓦的部分在{zone:1444}指南的{object:3202}一站完成",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}，位于最顶层",
	-- ["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "在阳台上马克基雷旁边的{npc:2496}还有一个差事：考兹尔提箱里的燃料调节器图纸要交给{area:2240}的波兹克，在43级左右前往{zone:1446}的路上。",
	-- ["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}：留到约48级去{zone:1425}时完成",
	-- ["{npc:2498}, inside"] = "{npc:2498}：在屋内",
	-- ["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "{npc:2519}：蜥蜴就在从{area:35}返回的路旁",
	-- ["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}：战利品头骨放在劈颅废墟内，本轮路线稍后会去",
	-- ["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669}在附近巡逻，请在地图标示的圆圈内寻找",
	-- ["{npc:6807}, upstairs"] = "{npc:6807}：在楼上",
	-- ["{npc:6930}, upstairs"] = "{npc:6930}：在楼上",
	-- ["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}，在楼上：交给{area:976}的{quest:2864}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}：交给{area:976}的{quest:2864}",
	-- ["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "40-43级的{zone:1434}和{zone:1435}：{object:3202}、{area:35}的海盗、奈辛瓦里的狩猎任务和{area:75}。",
}
