-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "乘飞艇前往{zone:1458}",

	-- Step 2: Apothecary Zinge
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "",

	-- Step 3: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}，在{object:36126}",

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

	-- Step 6: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "飞往{area:75}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "{object:3202} 的飞行管理员。",

	-- Step 7: Stonard
	-- {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}：在屋内",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}，位于最顶层",

	-- Step 8: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "沿道路向西骑行；卷轴在沼泽最西边的水边。",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "交给{zone:1445}的{object:2555}，在本指南稍后",

	-- Step 9: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "盐齿鳄鱼",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "",

	-- Step 10: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "往回向东经过{area:75}：阿塔莱神器在{quest:1424}的水里和岸边。",

	-- Step 11: Misty Reed Post
	-- {npc:5592} Tok'Kar
	["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "沿路向东南前往岸边的小型部落岗哨。{npc:5592}需要上次来沼泽时收集的鳄鱼肉。",

	-- Step 12: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403}：沿途遇到就击杀",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too."] = "钳嘴龟分布在岗哨南边的海滩。\n巨型淤泥蟹沿东海岸的沙滩游荡，数量少且分散；看到就杀，从水池骑行南下途中遇到的也别漏掉。",
	["Underwater"] = "在水下",

	-- Step 14: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "芦苇丛中的鱼人",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "沼泽鱼人住在哨站南边的海滩上；沼泽喷墨鱼人在哨站东边的岸边，沼泽食腐鱼人在更西边、西岸的小屋周围。",
	["Below ground"] = "在地下",

	-- Step 16: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "",

	-- Step 18: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "交给{zone:1425}的{npc:5598}，大约48级时",

	-- Step 19: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "前往{area:1099}",

	-- Step 20: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "交给{zone:1425}的枭兽任务，大约48级时",

	-- Step 21: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "飞往{area:496}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "{area:1099}的飞行管理员",

	-- Step 22: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "{npc:4500}、{npc:4502}和{npc:4501}（在地下）都在村里；他们的任务目标在本次要去的{area:511}。",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}：在地下",

	-- Step 23: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "{object:2555}",

	-- Step 24: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "向西南骑行到{object:2555}处。",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "进入{area:498}内部",

	-- Step 25: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510}：沿途遇到就击杀",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "向东穿过{area:511}：火鬃斥候和火鬃灰尾龙人与灼热龙崽、灼热雏龙一起在北缘游荡；Scalebanes守着更东南方的龙穴。莫格穆洛克的鼻烟、烈酒和保险箱散落在龙人营地里。",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "{npc:4329}在{area:510}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 26: Brackenwall Village
	["Ride back north to Brackenwall."] = "向北骑回蕨墙村。",

	-- Step 27: Onyxia's eggs
	["Onyxia's eggs"] = "奥妮克希亚的蛋",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "奥妮克希亚的蛋在{area:511}东南的龙穴里，由火鬃守卫看守；砸碎五个。",
	["Dragon caves"] = "龙穴",

	-- Step 29: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "这些是精英怪：建议组队，找人一起做。{quest:1173} 需要三人小队。独自一人就跳过：路线会让你打怪补回这部分经验。\n{npc:4500} 是精英：建议组队。把他打到投降，然后向 {npc:4501} 汇报。",

	-- Step 30: Level 45.41
	["Level 45.41"] = "等级 45.41",
	-- {quest:1173} Challenge Overlord Mok'Morokk · {area:978} Zul'Farrak · {area:1517} Uldaman
	["If you skipped {quest:1173}, grind here to level 45.41 to stay on the route's plan. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "如果跳过了{quest:1173}，就在这里刷怪到45.41级，跟上路线的等级规划。也可组队挑战{area:978}或{area:1517}副本。",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "击杀{npc:4329}刷经验",

	-- Step 31: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飞往{area:1099}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "{area:496}的飞行管理员",

	-- Step 32: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "小精龙和森林漫游者",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "小精龙在营地正西的树林上空飞来飞去，携带{item:9589}；再往西一点的森林漫游者携带断裂的原木。",

	-- Step 33: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "乱羽角鹰兽",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "在山谷南边，乱羽角鹰兽栖息在山坡上；几乎每只都会掉落肌腱和金属碎片。",

	-- Step 34: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "向西北骑往{area:1108}；{npc:14637}在码头上等候。",

	-- Step 35: Rogue Vale screechers
	["Rogue Vale screechers"] = "游荡的山谷尖啸者",
	-- {npc:14637} Zorbin Fandazzle · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Rogue Vale就在{npc:14637}码头北边不远处。击杀一只{npc:5308}，对尸体使用{item:10699}，再击杀出现的灵魂。",

	-- Step 36: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}：沿途击杀以下目标",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "海元素和巨型海元素沿着码头周围的海岸漂荡。先用{item:18904}电击巨人：被缩小后，它们就失去了精英的力量。海岸巨人在水中涉行；大地行者和峭壁巨人在更北边的山丘上游荡。",

	-- Step 37: Northspring harpies
	["Northspring harpies"] = "北泉鹰身人",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "北泉鹰身人在遥远西北的山脊上筑巢。它们是48-50级，比你高几级：北泉唤风者会治疗，所以先杀它们，一次引一只。",

	-- Step 38: Rage Scar yetis
	["Rage Scar yetis"] = "怒痕雪人",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "从鹰身人那里向东南返回的路上，狂暴的怒痕雪人住在道路旁山丘里的洞穴周围。它们也都可能掉落{quest:7738}，它可以开始一个单独的任务。",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}，稀有掉落",

	-- Step 39: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}：在屋内",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {object:3202}"] = "飞往{object:3202}",
	-- ["Forest walkers"] = "森林漫游者",
	-- ["Monstrous Crawlers"] = "巨型淤泥蟹",
	-- ["Murlocs of the Misty Reed"] = "芦苇丛中的鱼人",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "沿道路向西北，狂暴的怒痕雪人住在山丘里的洞穴周围。它们也都可能掉落{quest:7738}，它可以开始一个单独的任务。",
	-- ["Northspring harpies"] = "北泉鹰身人",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "向东骑回营地。留在这里：下一个指南从飞往{area:976}开始。",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "向西南骑往{object:2555}，然后向东穿过{area:511}。火鬃斥候和火鬃灰尾龙人与灼热龙崽、灼热雏龙一起在北缘游荡；火鬃守卫守护着更东南的龙穴。莫格穆洛克的鼻烟、烈酒和保险箱都在龙人营地里。",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "在西南，雪人在{area:1105}筑巢；那里的每个雪人都可能掉落厚重的雪人皮。",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "沼泽鱼人住在哨站南边的海滩上；沼泽喷墨鱼人在哨站东边的岸边，沼泽食腐鱼人在更西边、西岸的小屋周围。",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "巨型淤泥蟹在东海岸的海滩上走动，数量稀少、相隔很远：向南的路上见一只杀一只。",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "北泉鹰身人在遥远西北的山脊上筑巢。它们是48-50级，比你高几级：北泉唤风者会治疗，所以先杀它们，一次引一只。",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "还是同样的鱼人，外加沼泽鱼人智者，它们待在西岸的小屋附近。",
	-- ["The small Horde post on the southern shore."] = "南岸的部落小哨站。",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "前往{zone:1454}的飞艇从{object:3202}旁的塔上出发；它降落在{zone:1454}正门东北不远处。",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "你从{area:75}出发。在这里绑定炉石：沿海岸做完后要用炉石回来。",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "你的训练师在{area:1638}：飞过去（还没有那里的飞行路线？飞往{area:378}，再向西骑马穿过{zone:1412}），然后继续前往{area:496}。",
	-- ["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",
	-- ["Zeppelin tower"] = "飞艇塔",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "用于{area:15}的{object:2555}，在本指南稍后",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500}是精英：建议组队。把他打到认输，然后向{npc:4501}报告。",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}：交给{zone:1454}的{npc:7010}，大约50级时",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}，然后是{object:172960}和{object:172961}。",
}
