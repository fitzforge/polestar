-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "{area:75}的飞行管理员",

	-- Step 3: To Grom'gol
	-- {object:3202} Grom'gol
	["To {object:3202}"] = "前往{object:3202}",
	-- {area:75} Stonard · {area:117} Grom'gol Base Camp
	["The flight from {area:75} lands at {area:117}."] = "从{area:75}起飞的航班降落在{area:117}。",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飞往{area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "{object:3202} 的飞行管理员。",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "继续向南前往{area:35}。{npc:7406}的工作室在海湾的上层环道上。",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}：在屋内",
	["Only once all three robots are home"] = "仅当三个机器人都回家后",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”马克基雷，位于最顶层",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "",

	-- Step 7: The Bloodsail ships
	["The Bloodsail ships"] = "血帆海盗船",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "",

	-- Step 9: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{quest:8552}需要 2 人小队。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 15: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "返回{object:3202}",

	-- Step 16: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "这些怪物是精英：建议组队，找人一起完成。{npc:818}（47级精英）需要两人小队。独自一人就跳过：路线会安排刷怪补回经验。\n小心：{npc:818} 身边有两名约45级的精英施法守卫，会与他同时加入战斗。",
	["Below ground"] = "在地下",

	-- Step 20: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 22: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "骑马进入{zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "沿道路向东离开碎木岗哨。{npc:11548}在道路旁的{area:1235}等候，位于联盟{area:3137}西边几步远：从西边过去，避开艾萨拉哨兵和加罗迪努斯（精英）。",

	-- Step 23: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236}：沿途遇到就击杀",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "上层精灵的幽灵在神殿正北的废墟里出没；哈达尔萨特在更北一点的地方扎营。",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117}在{area:1235}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 24: Level 50
	["Level 50"] = "等级50",
	-- {quest:4493} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar · {zone:1447} Azshara · {area:2100} Maraudon · {area:1417} Sunken Temple
	["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it. Or, with a group, run the {area:2100} dungeon or the {area:1417} dungeon instead."] = "在这里补到50级：{zone:1447}结束后，{zone:1454}的{npc:7010}提供的{quest:4493}需要达到这个等级。也可以组队刷{area:2100}或{area:1417}地下城。",
	-- {npc:6125} Haldarr Satyr
	["grind on {npc:6125}"] = "击杀{npc:6125}刷经验",

	-- Step 25: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "回到神殿的{npc:11548}那里；待在{area:3137}守卫的西边。",

	-- Step 26: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "沿道路向北前往部落营地{area:1237}。",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}，在营地东缘：没有经验，只能传送到克希雷姆的法师塔",

	-- Step 28: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "完好无损的角鹰兽羽毛",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "雷首角鹰兽在{area:1237}正南的山丘上空飞翔。",

	-- Step 30: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "向东北骑往{area:1227}上方悬崖上的地精营地。",

	-- Step 31: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "血精灵的营地就在{npc:8420}南边。他的四件设备在营地周围的箱子里。",

	-- Step 33: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}：沿途遇到就击杀",
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "向西南骑往废墟。四块石板散落在废墟中，由恶鞭纳迦看守；任何恶鞭海妖或恶鞭侍从都可能携带{npc:8420}的符文。",

	-- Step 34: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "向东北回到{npc:8420}那里。",

	-- Step 35: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "向西骑回{area:1237}。",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "留着给{npc:4046}、{npc:8659}和{npc:6522}的货物：你之后会经过{zone:1456}、{zone:1454}和{zone:1458}。",

	-- Step 36: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "克希雷姆的塔建在{area:1237}正北的悬崖上；小路沿塔的北侧蜿蜒而上。",
	["Upstairs"] = "在楼上",

	-- Step 38: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "{area:1237}的飞行管理员",

	-- Step 39: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}，在{object:172960}",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}，在暗巷区",

	-- Step 40: Orgrimmar
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "留着{npc:8659}的报酬和阿格图的{quest:3504}：之后再去{area:1237}时交还。",

	-- Step 41: Paladin trainer
	["Paladin trainer"] = "圣骑士训练师",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{zone:1456}的{npc:246344}；{zone:1454}没有圣骑士训练师",

	-- Step 42: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飞往{area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 43: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "飞往{zone:1456}；它在前往{area:1099}的路上。还没有那里的飞行路线？飞往{area:378}，再向西骑马穿过{zone:1412}。哈缪尔和{npc:4046}在{area:1639}；德鲁伊和圣骑士在这里训练（{npc:3033}，{npc:246344}）。",

	-- Step 44: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 45: Thunder Bluff
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761}在下一个指南中收集；{npc:4046}的报酬之后交还给{npc:8587}。",

	-- Step 46: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飞往{area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 47: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}：熊在{zone:1448}",

	-- Step 48: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "乱羽角鹰兽",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "角鹰兽在营地西南的山丘上筑巢。杀死一只，然后对它的尸体使用灵魂精华容器。",

	-- Step 50: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "小精龙",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "精灵龙在营地正西的树林里飞来飞去。对你杀死的每一只使用容器。",

	-- Step 52: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "森林漫游者",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "树人在营地和{zone:1444}中部之间的林间道路上游荡；数量很少，所以沿着小路找。",

	-- Step 55: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}：沿途击杀以下目标",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray · Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "海元素和巨型海元素沿着码头周围的海岸活动。\n大地行者和峭壁巨人在码头北面的山丘游荡。先对每个巨人使用{item:18904}：缩小后，它们就不再是精英。每个被缩小的巨人都会掉落残渣；还要对尸体使用山岭巨人灵魂精华容器。",

	-- Step 57: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "返回{area:1099}",

	-- Step 58: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飞往{area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "{area:1099}的飞行管理员",

	-- Step 59: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}：在屋内",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}，在双足飞龙管理员旁边",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "{npc:7876}要的焦油和匹斯特苏格要的样本都来自{zone:1449}。",

	-- Step 60: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "沿道路向南骑往{area:1938}；{npc:7771}在旁边扎营。从这里向西的道路通往{zone:1449}，下一个指南从那里开始。",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "留着{quest:3444}：{npc:7771}的箱子要之后再来时才能打开。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "从{area:1237}飞往{zone:1454}，从正门走到飞艇塔，乘飞艇前往{object:3202}。",
	-- ["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- ["Follow the road north out of {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "沿路向北离开{area:35}；返回{object:3202}途中，石化蜥蜴在丛林中部、道路东边的岩石上晒太阳。它们经常掉落碎片。",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "沿道路向南；蜥蜴在丛林中部道路东边的岩石上晒太阳。它们经常掉落碎片。",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "从{area:3317}的飞行管理员处飞往{area:1497}。",
	-- ["Highborne and Haldarr satyrs"] = "上层精灵和哈达尔萨特",
	-- ["Ironjaw Basilisks"] = "铁腭蜥蜴",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "留着{area:1417}给{zone:1446}的{npc:7771}。",
	-- ["Ride into {area:16}"] = "骑马进入{area:16}",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "向西北骑往{area:1108}；{npc:14637}在码头上等候。",
	-- ["Sea elementals"] = "海元素",
	-- ["Take the zeppelin back to {zone:1454}."] = "乘飞艇返回{zone:1454}。",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "在{zone:1458}外的塔上乘飞艇前往{zone:1454}，然后飞往{area:431}。",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "大地行者和峭壁巨人在码头北边的山丘上游荡。先用{item:18904}电击每一个：被缩小后，它们就不再是精英。每个被电击的巨人都会掉落残渣；也对它的尸体使用灵魂精华容器。",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "海元素和巨型海元素沿着码头周围的海岸漂荡。",
	-- ["The {object:2076} beside {npc:2519}"] = "{npc:2519}旁边的{object:2076}",
	-- ["Zapped giants"] = "被电击的巨人",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}：熊在{zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825}站在{object:36082}。",
}
