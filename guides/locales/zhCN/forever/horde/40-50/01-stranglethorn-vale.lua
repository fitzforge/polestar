-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "{area:340}的飞行管理员",

	-- Step 2: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "",

	-- Step 3: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "丛林捕猎者",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "丛林捕猎者（40-41级）在{object:3202}南边的海岸捕猎。它们比你高得多：一次引一只，战斗间隙休息。",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飞往{area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "{object:3202} 的飞行管理员。",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "飞行管理员格林戈在{area:35}的上层平台等候。任务给予者分布在海港周围的栈道和旅店里。",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495}：交还之前收集的钳嘴龟皮；他在屋内",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”马克基雷，位于最顶层",
	["Inside"] = "在里面",

	-- Step 7: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "从隧道出城；信件在{area:35}正北的海盗海湾里。",

	-- Step 8: Booty Bay
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}，位于最顶层",

	-- Step 9: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "在藏宝海湾南边，血帆流氓在{area:43}扎营；血帆海图和血帆计划书就在他们的帐篷里。任何血帆海盗都可能携带鼻烟和{npc:2493}的眼睛，所以一直杀到两样都拿到为止。",

	-- Step 11: The Bloodsail ships
	["The Bloodsail ships"] = "血帆海盗船",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["Optional, and tough at 41: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "可选任务，41级时难度很高：卷轴{quest:624}位于{area:43}外海三艘船的甲板上，船上的海盗为42-45级，常成对行动。只有能把船员逐只引到船舷边，或有朋友同行时才去取；后续任务会经过{zone:1435}、{zone:1445}和{zone:1425}。",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "留到之后在{zone:1435}停留时",

	-- Step 12: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "沿道路向北离开{area:35}；安巴格瓦坐在道路东边{area:1737}的一座山丘上。",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "在{area:1742}内部",

	-- Step 13: Mistvale gorillas
	["Mistvale gorillas"] = "迷雾谷猩猩",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "猩猩在安巴格瓦周围的山谷里游荡。老迈的猩猩掉落内脏；任何猩猩都可能掉落猩猩牙。",

	-- Step 14: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "把猩猩牙交给安巴格瓦并待在他身边：他会召唤三波猩猩，然后是{npc:1514}。一次对付一个。",

	-- Step 16: Venture Co. mine
	["Venture Co. mine"] = "风险投资公司矿洞",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "再往北，风险投资公司的地精在道路东侧矿场挖掘；矿工、工头、勘探员和工匠都会掉落水晶。\n小心：营地周围有潜行的深喉猎豹和荆棘谷雌虎游荡。",

	-- Step 18: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的营地",
	["Head north up the road; the hunters camp on the hill above the river."] = "沿路向北；猎人们在河流上方的山丘扎营。",

	-- Step 20: Zul'Kunda
	["Zul'Kunda"] = "祖昆达废墟",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {quest:586} Speaking with Gan'zulah · {area:1517} Uldaman
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43. Or, with a group, run the {area:1517} dungeon instead."] = "远征队西边，血顶酋长{npc:1061}和{npc:1062}一起待在祖昆达废墟。先清掉卫兵，再引他们。在这里继续击杀血顶巨魔直到41级：下一站大锅处的{quest:586}会让你去对付41-43级的劈颅巨魔。也可组队挑战{area:1517}副本。",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "",
	-- {quest:586} Speaking with Gan'zulah
	["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "在这里刷血顶巨魔升级：下一站大锅处的{quest:586}会让你去对付41-43级的劈颅巨魔",

	-- Step 21: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}，在{npc:2497}旁边",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}：留到约48级去{zone:1425}时完成",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "",

	-- Step 22: Jungle stalkers
	["Jungle stalkers"] = "丛林捕猎者",
	-- {object:3202} Grom'gol
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "丛林捕猎者迅猛龙在{object:3202}南边的丛林里捕猎，一直到西海岸。",

	-- Step 23: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}：沿途遇到就击杀",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "沿海岸向南。纳迦探险者在岸边涉水而行，携带一捆海蛇草；{object:759}就在他们正东的山丘里冒泡。",

	-- Step 24: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "向南前往 {area:35}。“病鬼”菲利普 在码头等着。",
	-- {npc:6807} Innkeeper Skindle
	["{npc:6807}, upstairs"] = "{npc:6807}：在楼上",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "顶层的“海狼”马克基雷：交给{zone:1446}的斯杜雷",

	-- Step 25: Zanzil's camps
	["Zanzil's camps"] = "赞吉尔的营地",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "在迷雾谷东北，赞吉尔的追随者在丛林里扎营；他们每个人都可能携带赞吉尔的药剂。",

	-- Step 26: Pirate ghosts
	["Pirate ghosts"] = "海盗幽灵",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "三个海盗幽灵在{area:35}北边、赞吉尔营地附近的丛林里出没：{npc:2535}和{npc:2536}站在一起，{npc:2537}在更东边。",

	-- Step 27: Zul'Mamwe
	["Zul'Mamwe"] = "祖玛维废墟",
	-- {npc:1059} Ana'thek the Cruel
	["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "向北前往风险投资公司矿场以东的劈颅废墟；逐个引出猎头者和狂战士。{npc:1059} 把守着西南边的废墟，废墟北边有一堆战利品头骨。每个劈颅巨魔都可能掉落獠牙或项链：项链比较难凑齐，因此到废墟北边的战士营地继续击杀，直到集齐。",
	["Skullsplitter warriors"] = "劈颅战士",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669}在附近巡逻，请在地图标示的圆圈内寻找",
	["Below ground"] = "在地下",

	-- Step 28: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "{area:127}：沿途遇到就击杀",
	-- {object:3202} Grom'gol
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "下一堆颅骨堆在战士营地正北的小废墟里。\n最后的颅骨堆在西边不远的废墟里，走几步就到，就在回{object:3202}的路上。",

	-- Step 29: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Head west to {object:3202}."] = "向西前往 {object:3202}。",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "",

	-- Step 31: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}：在屋内",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}：在楼上",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}，在楼上：交给{area:976}的{quest:2864}",

	-- Step 32: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "铁腭蜥蜴",
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "",

	-- Step 33: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Ride on north to {object:3202}."] = "",

	-- Step 35: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "沿路向北前往猎人营地。",

	-- Step 37: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:730}是 43 级精英，多数职业到 45 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 38: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:728}是 40 级精英，多数职业到 42 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 42: Level 42.68
	["Level 42.68"] = "等级 42.68",
	-- {quest:192} Panther Mastery · {quest:195} Raptor Mastery · {area:1517} Uldaman
	["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "如果跳过了{quest:192}或{quest:195}，就在这里刷怪到42.68级，跟上路线的等级规划。也可组队挑战{area:1517}副本。",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "击杀{npc:667}刷经验",

	-- Step 43: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:731}是 43 级精英，多数职业到 45 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。\n注意：附近有老虎和潜行的暗影黑豹，先清理再拉首领。拉到{npc:731}时，它会召集 20 码内的生物支援。",

	-- Step 45: Level 42.74
	["Level 42.74"] = "等级 42.74",
	-- {quest:208} Big Game Hunter · {area:1517} Uldaman
	["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "如果跳过了{quest:208}，就在这里刷怪到42.74级，跟上路线的等级规划。也可组队挑战{area:1517}副本。",

	-- Step 49: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "进入{zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "从{zone:1431}沿路向东，经过{zone:1430}进入沼泽。{npc:1776}在{area:657}等候；那是靠近{zone:1430}入口、道路旁的德莱尼营地。",

	-- Step 50: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road. Bind here."] = "向东前往{area:75}，就在路南的芦苇丛中。把炉石绑定在这里。",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}：在屋内",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}：在楼上",
	-- {npc:6930} Innkeeper Karakul
	["{npc:6930}, upstairs"] = "{npc:6930}：在楼上",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}，位于最顶层",

	-- Step 51: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "盐齿鳄鱼",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "鳄鱼在{npc:5391}营地周围的水塘里打滚，一直到南边的{area:75}；大约四分之一会掉落鳄鱼肉。",

	-- Step 52: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "木棒诺博鲁在{area:76}西南的空地上游荡；他的木棒可以开始一个任务。",

	-- Step 53: Draenethyst crystals
	["Draenethyst crystals"] = "德莱尼水晶",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "向东北骑往{area:76}。水晶分布在通往{npc:5391}笼子的路上。",

	-- Step 54: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391}被关在沼泽东北的{area:76}。救出他并跟着他出去，击退追赶他的沼泽生物。",

	-- Step 55: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "他的保险箱在{area:75}北边的旧营地里，向西返程时会经过。",

	-- Step 56: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "沿路骑行向西，前往{area:657}的德莱尼营地，靠近从{zone:1430}过来的入口。{quest:698}留到下次来沼泽时，交给{area:1978}的{npc:5592}；保留鳄鱼肉。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "乘船前往{area:35}",
	-- ["Fly to {area:392}"] = "飞往{area:392}",
	-- ["From {area:2408} fly to {area:392}."] = "从{area:2408}飞往{area:392}。",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "再往北，风险投资公司的地精在道路东边的矿洞里挖掘；矿工、工头、勘探员和修理工都会掉落水晶。",
	-- ["Hearth to {area:35}"] = "用炉石回到{area:35}",
	-- ["Hearth to {object:3202}"] = "用炉石回到{object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "他的保险箱在{area:75}北边他原来的营地里。",
	-- ["Into the {area:8}"] = "进入{area:8}",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "继续向北骑进{zone:1431}，然后沿道路向东穿过{zone:1430}进入沼泽。{npc:1776}在{area:657}等候，那是靠近{zone:1430}入口的德莱尼营地。",
	-- ["Naga shore and the {object:759}"] = "纳迦海岸和{object:759}",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "向东骑回{area:75}，沿道路向东南前往岸边的部落小哨站。",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "向东骑往道路南边芦苇丛中的{area:75}。",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "向北骑往风险投资公司矿洞东边的劈颅巨魔废墟；把猎头者和狂战士一个个引出来。{npc:1059}守卫着西南边的废墟，一堆颅骨堆就在废墟北侧。每个劈颅巨魔都可能掉落獠牙或项链：项链是最慢的部分，所以在废墟北边的战士营地里一直杀，直到拿齐为止。",
	-- ["Ride north up the road to the hunters' camp."] = "沿道路向北骑往猎人营地。",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "沿道路向北骑行；猎人们在河上方的山丘上扎营。",
	-- ["Ride north-west to {object:3202}."] = "向西北骑往{object:3202}。",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "向南骑往{area:35}。“病鬼”菲利普在码头上等候。",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "沿道路向西骑往{area:657}的德莱尼营地，靠近{zone:1430}的入口。",
	-- ["Ride west to {object:3202}."] = "向西骑往{object:3202}。",
	-- ["Sawtooth snappers"] = "盐齿钳嘴鳄",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "船停靠在{area:35}的港口。任务给予者站在港口周围的木栈道上和旅店里。",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "前往{area:35}的船停靠在{area:392}码头的尽头。",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "最后的颅骨堆在西边不远的废墟里，就在回{object:3202}的路上。",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "下一个指南从这里开始，带你前往{zone:1446}。",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "下一堆颅骨堆在战士营地正北的小废墟里。",
	-- ["The snappers line the strand south of the post."] = "钳嘴鳄分布在哨站南边的海滩上。",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "三艘船停在{area:43}外的海面上。船员是42-45级，斯蒂沃特船长45级，尼哈鲁船长46级，{npc:2546}48级：41级时这是小队的战斗，或者留到本指南结束时再来。如果要去，就游过去，把船员一个个引到船舷边。船的甲板上有一张卷轴{quest:624}：拿上它。",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "在远征队营地西边，血顶酋长{npc:1061}和{npc:1062}一起站在祖昆达废墟里。先清掉他们的守卫，再引他们。",
	-- ["for Stoley in {zone:1446}"] = "交给{zone:1446}的斯杜雷",
	-- ["for a later stop in the {area:8}"] = "留到之后在{area:8}停留时",
	-- ["for later: the {zone:1425}, around level 48"] = "留到之后：{zone:1425}，大约48级时",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}，在{npc:2497}旁边",
	-- ["{area:35} flight master"] = "{area:35}的飞行管理员",
	-- ["{area:392} pier"] = "{area:392}码头",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}：交给{area:976}的{quest:2864}",
}
