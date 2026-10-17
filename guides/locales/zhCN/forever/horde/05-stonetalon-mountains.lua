-- Chinese (simplified) (zhCN): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kadrak
	-- {area:380} Crossroads · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale · {item:16783} Bundle of Reports
	["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "从{area:380}沿道路向北。{npc:8582}站在道路进入{zone:1440}处{area:1703}的瞭望塔上。打开他给你的{item:16783}。",

	-- Step 2: Warsong Scout
	-- {npc:12862} Warsong Scout
	["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "继续沿道路向北。{npc:12862}在碎木岗哨南边的战歌伐木营地等候。",

	-- Step 3: Splintertree Post
	-- {area:431} Splintertree Post
	["{area:431} is just north up the road."] = "{area:431}就在道路北边不远处。",

	-- Step 4: Night Run
	-- {npc:12696} Senani Thunderheart · {area:428} Night Run
	["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696}站在{area:428}的狩猎告示板旁，那是碎木岗哨东北方不远的战歌营地。",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "{npc:12696}的狩猎目标（乌萨苟斯、萨杜布拉、沙普塔隆）留到27级下次来{zone:1440}时。",

	-- Step 5: Warsong Outrider
	-- {npc:12864} Warsong Outrider · {area:428} Night Run · {area:430} Satyrnaar
	["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864}在{area:428}东边朝{area:430}方向的道路上巡逻。",

	-- Step 6: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "向西骑行时，{npc:267214}被困在主路南边的一条峡谷里，位于{area:415}东南。黑角鹿和灰谷熊在峡谷周围的林子里游荡。",

	-- Step 7: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "在四分钟内操控{npc:267214}的{npc:271181}离开峡谷到达主路；如果引导中断，再找{npc:267214}一次。",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "{npc:271181}，在路上",

	-- Step 8: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand
	["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "沿主路向西穿过{zone:1440}，经过{area:415}（联盟：别离开道路），到达海岸。{area:2897}位于西北部的{area:414}。它的其他任务留到27级下次来时。",

	-- Step 9: Naga heads
	["Naga heads"] = "纳迦头颅",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "哨站北边海滩上的每个怒尾纳迦都会掉落头颅。",

	-- Step 11: Back to Kadrak
	-- {npc:8582} Kadrak
	["Back to {npc:8582}"] = "回到{npc:8582}处",
	-- {area:431} Splintertree Post · {area:1703} Mor'shan Rampart
	["Fly to {area:431} and ride south down the road to the {area:1703}."] = "飞往{area:431}，沿道路向南骑到{area:1703}。",

	-- Step 12: Malaka'jin
	-- {area:380} Crossroads · {zone:1413} Barrens · {area:2539} Malaka'jin
	["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "向南骑到{area:380}，然后沿道路向西离开{zone:1413}进入石爪山脉。巨魔村庄{area:2539}位于峡谷入口。",

	-- Step 13: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "道路向北攀升，即{area:1076}。{quest:1483}的小屋在道路向东分岔通往{area:461}的地方。",

	-- Step 14: Windshear Crag
	-- {area:461} Windshear Crag · {npc:4276} Piznik
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "在菲兹克斯东边，风险投资公司正在{area:461}大肆砍伐；其中一个风险投资公司操作员携带图纸。{npc:4276}在东侧的小矿洞里采矿：他采矿时守在他身边，风险投资公司的打手会来找他。",

	-- Step 15: Ziz Fizziks
	-- {area:392} Ratchet
	["Sputtervalve in {area:392}: the next guide passes there"] = "{area:392}的斯布特瓦夫：下一份指南会经过那里",

	-- Step 16: Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Follow the road west to {area:460}."] = "沿道路向西前往{area:460}。",
	-- {npc:11860} Maggran Earthbinder · {object:19844} Great Lift
	["{npc:11860}: Grish is at the {object:19844}, in the next guide"] = "{npc:11860}：瑞什在{object:19844}，下一份指南",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}：从血怒鹰身人获取闪光的太阳石",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}，在大门外",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} at Zoram'gar, at 27"] = "佐拉姆加的{npc:12736}，27级时",

	-- Step 17: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "盖亚之种",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "盖亚之种散落在烈日石居北边{area:464}南岸的草丛中。",

	-- Step 18: Stonetalon Peak
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "沿道路向北朝{area:467}前进。巨角鹿沿途吃草；腐蚀兽、夜行虎和灵龙在山峰下方的树林中游荡，塞纳里奥德鲁伊占据那里的树林。",

	-- Step 19: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}的下一个任务“奥达努斯”在{zone:1440}的联盟一方。跳过。",

	-- Step 20: The Charred Vale
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "烈日石居西南方是烧焦的{area:465}。把{item:16205}种在谷底的土堆里；火元素掉落{item:16312}。血怒鹰身人和血怒伏击者在北侧筑巢，血怒杀戮者和血怒游荡者在南侧。",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "盖亚土堆",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}，来自任何血怒鹰身人",

	-- Step 21: Sun Rock Retreat
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}，在上方的岩架上",
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}，在{npc:11862}旁边",

	-- Step 22: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Ride back down the {area:1076} to {area:2539}."] = "沿{area:1076}骑回{area:2539}。",

	-- Step 23: To the Undercity
	-- {area:1497} Undercity
	["To the {area:1497}"] = "前往{area:1497}",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:1497} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter
	["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "向东骑到{area:380}，飞往{zone:1454}。从{zone:1454}外的塔楼乘飞艇前往{zone:1420}；{area:1497}在{area:153}下方。蝙蝠管理员在{object:36078}。",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "与{object:36126}的{npc:10181}交谈：{quest:93739}",

	-- Step 24: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606}站在{object:36070}。",

	-- Step 25: Beren's Peril
	-- {area:272} Tarren Mill · {zone:1458} Undercity · {area:228} Sepulcher · {area:231} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "如果你已经知道{area:272}的飞行路线，就飞过去并跳到{area:272}。否则从{zone:1458}飞往{area:228}，沿道路向南经过焚木村。鸦爪亡灵在森林东南部、道路东边的{area:231}废墟中游荡；{npc:1973}掉落{item:271343}，指引你找到{object:645153}。",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{item:271343}，来自{npc:1973}",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins"] = "{item:271350}，来自废墟中的被折磨的灵魂",

	-- Step 26: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "在{object:645153}使用{npc:212753}作为自愿的祭品，杀死回应的{npc:212753}。{quest:95883}是精英任务：建议组队。",

	-- Step 27: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "回到向南的道路。在道路向东转入{area:287}的地方，{npc:2214}在{area:285}等候。",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}：{area:272}的达萨利亚",

	-- Step 28: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "沿河边道路向东，然后向东北爬进山丘到{area:272}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "烈日石居西南方是烧焦的{area:465}。把盖亚之种种在谷底的土堆里；火元素掉落{item:16312}。血怒鹰身人和血怒伏击者在北侧筑巢，血怒杀戮者和血怒游荡者在南侧。",
}
