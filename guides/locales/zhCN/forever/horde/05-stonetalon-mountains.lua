-- Chinese (simplified) (zhCN): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun
	["On the way north from Seereth's camp, keep east of the road to the Venture Co. tower north of the {area:382}. Before you go near Fizzule, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "从希雷斯的营地向北走时，沿道路东侧前往{area:382}北边的风险投资公司高塔。靠近费苏勒之前，先用{item:8051}发射两枚信号弹，再选中他并使用/salute：未先发出信号就靠近的人都会遭到他的攻击。",
	-- {quest:2478} Mission: Possible But Not Probable
	["{quest:2478} is for level 23 or more: the tower's drones are 25 and Gallywix a 23 elite. Do it when you can, with a group, from the Class guide Poisons (Horde)."] = "{quest:2478}适合23级及以上：塔内的苦工是25级，加里维克斯是23级精英。等有能力时组队，通过职业指南《制毒（部落）》完成。",

	-- Step 2: Kadrak
	-- {zone:1413} Barrens · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["From Seereth's camp head north-east across the {zone:1413} to the road north of the Crossroads. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}."] = "从希雷斯的营地向东北穿过{zone:1413}，到达十字路口北边的道路。道路进入{zone:1440}处有{area:1703}，{npc:8582}就站在那里的瞭望塔上。",

	-- Step 3: Into Ashenvale
	-- {zone:1440} Ashenvale
	["Into {zone:1440}"] = "",
	-- {area:431} Splintertree Post
	["The road north to {area:431}"] = "",

	-- Step 4: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12696} Senani Thunderheart · {area:428} Night Run · {npc:12867} Kuray'bin · {quest:6503} Ashenvale Outrunners
	["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors. {npc:12867} at the lumber camp offers {quest:6503}: leave it for the way back, at 22."] = "",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 26."] = "{npc:12696}的狩猎目标（乌萨苟斯、萨杜布拉、沙普塔隆）留到26级下次来{zone:1440}时再做。",

	-- Step 5: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "向西行进途中，{npc:267214} 被困在主路南侧、{area:415} 东南方的一条峡谷里。周围林地中到处都有黑角鹿和灰谷熊。",

	-- Step 6: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "在四分钟内操控{npc:267214}的{npc:271181}离开峡谷到达主路；如果引导中断，再找{npc:267214}一次。",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}，在路上",

	-- Step 7: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand · {npc:12719} Marukai · {npc:12721} Mitsuwa · {npc:12757} Karang Amakkar · {npc:12863} Warsong Runner
	["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west: {npc:12719}, {npc:12721} and {npc:12757} stand around it, the {npc:12863} beside the flight master. Its other quests are for the next visit, at 26."] = "沿主路向西穿过{zone:1440}，经过{area:415}（联盟领地：沿道路走），抵达海岸。{area:2897}在西北面的{area:414}：{npc:12719}、{npc:12721}和{npc:12757}站在周围，{npc:12863}在飞行管理员旁。这里的其他任务留到26级下次来时再做。",
	-- {npc:12721} Mitsuwa
	["{npc:12721}: the troll charms are in Thistlefur Hold, east of the outpost"] = "{npc:12721}：巨魔符咒在前哨站东边的蓟皮熊怪的巢穴",
	-- {npc:12717} Muglash
	["{npc:12717}: take it last, his escort starts at once"] = "{npc:12717}：最后再接，他的护送任务会立即开始",

	-- Step 8: Vorsha the Lasher
	-- {npc:12717} Muglash · {npc:12719} Marukai
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead; the Wrathtail naga drop the heads {npc:12719} wants."] = "{npc:12717}沿海滩向北走到一座纳迦火盆。熄灭火盆，再保护他抵挡一波波纳迦，直到沃尔沙被击杀；怒尾纳迦掉落{npc:12719}要的头颅。",
	["Naga brazier"] = "纳迦火盆",

	-- Step 9: Naga heads
	["Naga heads"] = "纳迦头颅",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "哨站北边海滩上的每个怒尾纳迦都会掉落头颅。",

	-- Step 10: Zoram'gar Outpost
	["Back to the outpost before heading east to Thistlefur."] = "先回前哨站，再向东去蓟皮营地。",

	-- Step 11: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold.\nCareful: A Shaman at 15% health or lower runs off to find help, which can pull extra furbolgs."] = "佐拉姆加以东，蓟皮熊怪遍布村庄及其据点周围的山丘。\n注意：萨满祭司的生命值降到15%或以下时会逃跑求援，可能会引来更多熊怪。",

	-- Step 12: Thistlefur Hold
	["Thistlefur Hold"] = "蓟皮熊怪的巢穴",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run · {npc:3987} Dal Bloodclaw
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}.\nCareful: Two scripted ambushes occur, each made up of three Thistlefurs (a Shaman, a Pathfinder and an Avenger, Ursa or Den Watcher): the first when you come back to the tunnel's fork inside the cave, the second just beyond the gate where {npc:3987} roams."] = "据点内部的隧道沿线有巨魔的箱子。{npc:12818}被囚禁在深处：释放他并一路保护他离开，之后他会跑回{area:428}的家。\n小心：会触发两次固定伏击，每次由3名蓟皮熊怪组成（一名萨满祭司、一名探路者，以及一名复仇者、巨熊战士或巢穴守卫）：第一处在洞内返回隧道岔口时，第二处在越过{npc:3987}游荡的大门后不远处。",
	["Below ground"] = "在地下",
	-- {npc:12818} Ruul Snowhoof
	["{npc:12818}, below ground"] = "{npc:12818}：在地下",

	-- Step 13: Zoram'gar Outpost
	-- {npc:12757} Karang Amakkar · {zone:1440} Ashenvale
	["Back west to Zoram'gar. {npc:12757} offers King of the Foulweald now; leave it for the next {zone:1440} visit at 26, when the walk east passes the Foulweald."] = "向西返回佐拉姆加。{npc:12757}现在会提供《污林熊怪之王》；留到26级下次来{zone:1440}时再做，届时向东的路线会经过污林熊怪。",

	-- Step 14: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12837} Yama Snowhoof
	["Fly to {area:431}: {npc:12837} waits in the inn for news of Ruul."] = "飞往{area:431}：{npc:12837}在旅店等候鲁尔的消息。",
	-- {npc:12837} Yama Snowhoof
	["{npc:12837}, inside the inn"] = "{npc:12837}，在旅店里",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["Out of the inn and south down the road to the lumber camp: {npc:12867} stands there. The night elf Outrunners (23-24) stalk the woods south-east of it; they stealth, so watch for them."] = "",

	-- Step 16: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:431} Splintertree Post · {area:1637} Orgrimmar
	["Back north up the road to the {area:431} flight master and fly to {area:1637}."] = "",
	-- {area:431} Splintertree Post
	["{area:431} flight master"] = "{area:431}飞行管理员",

	-- Step 17: Druid trainer
	["Druid trainer"] = "德鲁伊训练师",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} 在 {zone:1412}；{zone:1454} 没有德鲁伊训练师",

	-- Step 19: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875}站在{object:172960}。在那里的召唤法阵上使用{item:6626}，击败魅魔来束缚她。",

	-- Step 20: Shenthul
	-- {quest:2478} Mission: Possible But Not Probable · {npc:3401} Shenthul · {object:172960} Cleft of Shadow
	["If you did {quest:2478} with a group, {npc:3401} in the {object:172960} takes it now."] = "如果已经组队完成{quest:2478}，现在可交给{object:172960}的{npc:3401}。",
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{area:272}的{npc:2391}教授毒药：留着它",

	-- Step 21: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "乘飞艇前往{zone:1458}",

	-- Step 22: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152}在{area:159}训练圣骑士，从飞艇塔沿道路向北步行不远即到。之后沿同一条路回来，前往银松森林。",

	-- Step 23: Strange Lockbox
	-- {area:240} Dead Field · {object:177790} Strange Lockbox · {item:15882} Half Pendant of Aquatic Endurance · {area:228} Sepulcher
	["From the zeppelin towers, run south into Silverpine and west past the {area:240} to the coast: the {object:177790} lies at the bottom of very deep water there, beside an air fissure where you can breathe. Watch your breath on the way down. It holds the {item:15882} for Trial of the Sea Lion. Then on to the {area:228}."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "{item:15882}，来自{object:177790}",

	-- Step 24: Sepulcher
	-- {area:228} Sepulcher · {npc:2121} Shadow Priest Allister · {npc:1937} Apothecary Renferrel
	["From the zeppelin towers, run south through Tirisfal into Silverpine and down the road to the {area:228}. {npc:2121} and {npc:1937} stand by the crypt entrance."] = "从飞艇塔出发，向南穿过提瑞斯法，进入银松森林，沿路到{area:228}。{npc:2121}和{npc:1937}站在墓穴入口旁。",
	-- {npc:1937} Apothecary Renferrel · {area:272} Tarren Mill
	["{npc:1937}: Lydon in {area:272}, next guide"] = "{npc:1937}：{area:272}的林度恩，下一份指南再做",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril · {area:233} Ambermill
	["{npc:2121}: {quest:516}, south-east of {area:233}"] = "{npc:2121}：{quest:516}，在{area:233}东南方",

	-- Step 25: Silverpine Forest: kill these as you meet them
	-- {zone:1421} Silverpine Forest
	["{zone:1421}: kill these as you meet them"] = "{zone:1421}：沿途遇到就击杀",
	-- {area:233} Ambermill · {quest:516} Beren's Peril
	-- plural, as words: Dalaran Watchers = {npc:1888} Dalaran Watcher · Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South down the road past Pyrewood: Dalaran Watchers and Wizards patrol the roads around {area:233}, and south-west of the town the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "沿路向南经过焚木村：达拉然卫士和达拉然巫师在{area:233}周围的道路上巡逻；镇子西南方、森林东南部的{quest:516}废墟中，鸦爪苦工和鸦爪守护者出没。",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["The Ravenclaw undead haunt the ruins of {quest:516}, east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}.\nAn elite spirit (20) often stands beside the {object:645153}: pull the Ravenclaws away from the stone before you fight them."] = "",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}，来自{npc:1973}",
	-- {object:645153} Offering Stone · {quest:95883} The Tortured Soul · {item:271343} Note Scrap
	["the {object:645153} offers {quest:95883} once the {item:271343} is in; below ground"] = "交还{item:271343}后，{object:645153}会提供{quest:95883}；位于地下",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "{item:271350}，从废墟地下的被折磨的灵魂身上获得",

	-- Step 27: The Offering of Blood
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["The quest hands you a {item:210713}: use it beside the {object:645153} to offer your blood, then kill the elite spirit that answers.\n{quest:95883} is elite: grouping up is advised."] = "",
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone
	["{item:210713}, beside the {object:645153}: summons the elite spirit"] = "",

	-- Step 28: Into Hillsbrad
	-- {area:287} Hillsbrad
	["Into {area:287}"] = "",
	-- {area:285} Southpoint Tower
	["The road east to {area:285}"] = "",

	-- Step 29: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "回到向南的道路。在道路向东转入{area:287}的地方，{npc:2214}在{area:285}等候。",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}：{area:272}的达萨利亚",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back out of the inn to the flight master and fly to {area:1637}."] = "离开旅店，回到飞行管理员处，飞往{area:1637}。",
	-- ["Back to {npc:8582}"] = "回到{npc:8582}处",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "在菲兹克斯东边，风险投资公司正在{area:461}大肆砍伐；其中一个风险投资公司操作员携带图纸。{npc:4276}在东侧的小矿洞里采矿：他采矿时守在他身边，风险投资公司的打手会来找他。",
	-- ["Fly to {area:431} and ride south down the road to the {area:1703}."] = "飞往{area:431}，沿道路向南骑到{area:1703}。",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "沿河边道路向东，然后向东北爬进山丘到{area:272}。",
	-- ["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "沿道路向北朝{area:467}前进。巨角鹿沿途吃草；腐蚀兽、夜行虎和灵龙在山峰下方的树林中游荡，塞纳里奥德鲁伊占据那里的树林。",
	-- ["Follow the road west to {area:460}."] = "沿道路向西前往{area:460}。",
	-- ["From the zeppelin towers, run south through Tirisfal into Silverpine and down the road past the {area:228} and Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "从飞艇塔出发，向南跑过提瑞斯法进入银松森林，沿道路向南经过{area:228}和焚木村。鸦爪亡灵在森林东南部、道路东边的{area:231}废墟中游荡；{npc:1973}掉落{item:271343}，指引你找到{object:645153}。",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "从{area:380}沿道路向北。{npc:8582}站在道路进入{zone:1440}处{area:1703}的瞭望塔上。打开他给你的{item:16783}。",
	-- ["Gaea Dirt Mounds"] = "盖亚土堆",
	-- ["Gaea Seeds"] = "盖亚之种",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "如果你已经知道{area:272}的飞行路线，就飞过去并跳到{area:272}。否则从{zone:1458}飞往{area:228}，沿道路向南经过焚木村。鸦爪亡灵在森林东南部、道路东边的{area:231}废墟中游荡；{npc:1973}掉落{item:271343}，指引你找到{object:645153}。",
	-- ["In the ruins of {quest:516}: The Ravenclaw undead haunt the ruins of {quest:516} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "在{quest:516}废墟中：鸦爪亡灵在森林东南部、道路东边的{quest:516}废墟中游荡；{npc:1973}掉落{item:271343}，指引你找到{object:645153}。",
	-- ["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "继续沿道路向北。{npc:12862}在碎木岗哨南边的战歌伐木营地等候。",
	-- ["Learn the flight path here while you pick up the outpost's quests."] = "在这里学习飞行路线，同时接取哨站的任务。",
	-- ["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "向西骑行时，{npc:267214}被困在主路南边的一条峡谷里，位于{area:415}东南。黑角鹿和灰谷熊在峡谷周围的林子里游荡。",
	-- ["Paladin trainer"] = "圣骑士训练师",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "沿{area:1076}骑回{area:2539}。",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "向东骑到{area:380}，飞往{zone:1454}。从{zone:1454}外的塔楼乘飞艇前往{zone:1420}；{area:1497}在{area:153}下方。蝙蝠管理员在{object:36078}。",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "向南骑到{area:380}，然后沿道路向西离开{zone:1413}进入石爪山脉。巨魔村庄{area:2539}位于峡谷入口。",
	-- ["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "沿主路向西穿过{zone:1440}，经过{area:415}（联盟：别离开道路），到达海岸。{area:2897}位于西北部的{area:414}。它的其他任务留到27级下次来时。",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "烈日石居西南方是烧焦的{area:465}。把{item:16205}种在谷底的土堆里；火元素掉落{item:16312}。血怒鹰身人和血怒伏击者在北侧筑巢，血怒杀戮者和血怒游荡者在南侧。",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "与{object:36126}的{npc:10181}交谈：{quest:93739}",
	-- ["Sputtervalve in {area:392}: the next guide passes there"] = "{area:392}的斯布特瓦夫：下一份指南会经过那里",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "盖亚之种散落在烈日石居北边{area:464}南岸的草丛中。",
	-- ["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "道路向北攀升，即{area:1076}。{quest:1483}的小屋在道路向东分岔通往{area:461}的地方。",
	-- ["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864}在{area:428}东边朝{area:430}方向的道路上巡逻。",
	-- ["To the {area:1497}"] = "前往{area:1497}",
	-- ["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "在{object:645153}使用{npc:212753}作为自愿的祭品，杀死回应的{npc:212753}。{quest:95883}是精英任务：建议组队。",
	-- ["{area:431} is just north up the road."] = "{area:431}就在道路北边不远处。",
	-- ["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors."] = "沿路向北不远就是{area:431}。从南边进入时，先经过飞行管理员和{area:428}的{npc:12696}狩猎告示板，再到商人处。",
	-- ["{item:16746}, from the {item:16783}"] = "{item:16746}，从{item:16783}中取得",
	-- ["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}，来自废墟中的被折磨的灵魂",
	-- ["{item:277936}, from any Bloodfury harpy"] = "{item:277936}，来自任何血怒鹰身人",
	-- ["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}：从血怒鹰身人获取闪光的太阳石",
	-- ["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}：瑞什在{area:1718}，下一份指南",
	-- ["{npc:11861}, beside {npc:11862}"] = "{npc:11861}，在{npc:11862}旁边",
	-- ["{npc:11862}, up on the ledge"] = "{npc:11862}，在上方的岩架上",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696}站在{area:428}的狩猎告示板旁，那是碎木岗哨东北方不远的战歌营地。",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "{npc:12696}的狩猎目标（乌萨苟斯、萨杜布拉、沙普塔隆）留到27级下次来{zone:1440}时。",
	-- ["{npc:12736} at Zoram'gar, at 27"] = "佐拉姆加的{npc:12736}，27级时",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867}站在伐木营地。暗夜精灵灰谷先驱者在营地东南的树林里潜伏；他们会潜行，所以留意他们。",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{zone:1456}的{npc:246344}；{zone:1454}没有圣骑士训练师",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}的下一个任务“奥达努斯”在{zone:1440}的联盟一方。跳过。",
	-- ["{npc:4198}, outside the gate"] = "{npc:4198}，在大门外",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606}站在{object:36070}。",
}
