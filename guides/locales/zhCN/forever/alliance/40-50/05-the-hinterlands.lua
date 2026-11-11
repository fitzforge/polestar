-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "向东南骑行前往{zone:1425}南部的阶梯状邪枝神殿{area:355}，爬到顶部。守护者奇尔加和 50 级精英{npc:8636}在那里；抵达顶部后立即下来。\n注意：顶层平台由精英巨魔守卫，包括{npc:7996}、{npc:8636}和多名邪枝占卜者。占卜者会施法，并与其他守卫联动。",

	-- Step 2: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "向北骑行前往{zone:1425}中部的{area:351}，绿色淤泥怪和玉石软泥怪遍布周围。\n注意：附近有潜行的豹子活动。",

	-- Step 3: Aerie Peak
	["Inside"] = "在里面",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "{npc:5636}：在屋内",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "之后交给{area:1438}的{quest:2990}",

	-- Step 4: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飞往{area:1537}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348}的飞行管理员",

	-- Step 5: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 6: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "乘地铁前往{zone:1453}",

	-- Step 8: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "飞往{area:69}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飞行管理员",

	-- Step 9: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "{area:2418}的飞行管理员",

	-- Step 10: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "飞往{area:144}",

	-- Step 11: Thelsamar
	-- {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth here: the {zone:1427} guide starts from {area:144}."] = "",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}的飞行管理员",

	-- Step 15: Rut'theran Village
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}在楼上，{npc:7916}的上方：从室内上楼，箭头无法区分楼层。",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}的下一个差事要去{zone:1446}：跳过。",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}：先留着，羽毛在{zone:1428}指南结尾获得",
	["the book on her table"] = "她桌上的书",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "月神殿",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "穿过传送门进入{zone:1457}。月神殿在城市南部。",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}，在她旁边",

	-- Step 21: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}，在树顶",

	-- Step 23: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "土壤之后从{zone:1449}获得",

	-- Step 24: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "传送至{zone:1438}",

	-- Step 25: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飞往{area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}的飞行管理员",

	-- Step 26: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "乘船前往{area:17203}",

	-- Step 27: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飞往{area:42}",

	-- Step 30: The bloodmages
	["The bloodmages"] = "血法师",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "进入{zone:1419}后，第一个停靠点就是路旁的血法师营地，位于{area:1438}西北侧。",

	-- Step 31: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "先沿道路继续向东到城堡：{item:6091}在离开{area:42}一小时后失效，而血法师要的野兽需要更长时间。",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}，在城堡顶层",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "{npc:8022}的下一个任务{item:9471}是{area:978}任务：跳过。",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "{npc:5385}：在楼上",

	-- Step 32: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419}：沿途击杀以下目标",
	-- {npc:5982} Black Slayer · {spell:5416} Venom Sting · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time.\nAshmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown."] = "向西骑行，饥饿的弯牙土狼在血法师营地南侧的干燥山丘活动，50 级的厚甲毒刺蝎在北部中央活动，{npc:5982}秃鹫在整片区域上空盘旋。逐个拉怪。\n灰鬃野猪和红石蜥蜴在城堡西南侧坡地活动。远离更南侧的 52 级地狱野猪。\n注意：厚甲毒刺蝎会使用{spell:5416}，{npc:8301}还会击倒。",

	-- Step 33: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "血法师的第二阶段用增益物品而不是经验来交换同样的材料：跳过。",

	-- Step 34: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飞往{area:35}",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "{area:1438}的飞行管理员",

	-- Step 35: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”马克基雷，位于最顶层",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}，顶楼",

	-- Step 36: The Bloodsail captains
	["The Bloodsail captains"] = "血帆船长",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "",

	-- Step 38: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{quest:8552}需要 2 人小队。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 42: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:1494}（52 级精英）需要 2 人小队。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "{npc:5992}和{npc:5990}分布在城堡西南方的山坡上。远离更南边的地狱野猪：它们是52级。",
	-- ["Back to {area:144}"] = "返回{area:144}",
	-- ["Back to {area:38}"] = "返回{area:38}",
	-- ["Boars and basilisks"] = "野猪和蜥蜴",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "从{area:144}飞往{area:150}，乘船前往{area:442}，再飞往{area:702}。",
	-- ["Fly from {area:348} to {area:42}."] = "从{area:348}飞往{area:42}。",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "用炉石返回{area:144}。{zone:1427}指南从{area:1446}开始：从这里向南骑进{zone:1418}，向西经过部落城镇{area:340}，沿小路上到峡谷。",
	-- ["Hearth to {area:348}."] = "用炉石返回{area:348}。",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "炉石在冷却？向西北骑回去。",
	-- ["Into {area:3}"] = "进入{area:3}",
	-- ["Portal to {area:141}"] = "传送至{area:141}",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "向东骑回{area:1438}，飞往{area:144}。",
	-- ["Ride back north to Ironband's camp."] = "向北骑回铁环挖掘场的营地。",
	-- ["Ride back west along the loch to {area:144}."] = "沿洛克湖向西骑行返回{area:144}。",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "沿湖南岸向东骑到铁环挖掘场的营地。",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "向东骑过{zone:1430}进入{zone:1435}，再沿道路向南进入{zone:1419}。血法师营地是路旁的第一站。",
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "向北骑到{zone:1425}中部的{area:351}。{npc:2655}和{npc:2656}在周围爬行。",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "向南穿过山口到{area:3}北缘：石窟穴居人在那里的{area:1517}外面挖掘。雕纹石罐和紫色蘑菇在它们的洞穴和隧道里，在地下城外面。",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "向东南骑到{area:355}，即{zone:1425}南部的邪枝阶梯神庙，爬到顶上。奇尔加和{npc:8636}（精英，50级）站在上面：摸到顶层就直接下来。",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "向西骑：{npc:5984}在血法师营地南边的干燥山丘上游荡；{npc:5988}（50级）在北部中间爬行。{npc:5982}秃鹫在整片区域上空盘旋。一次拉一只。",
	-- ["Scorpoks and snickerfangs"] = "厚甲蝎和弯牙土狼",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "德鲁伊训练师站在塞纳里奥区；{zone:1455}没有",
	-- ["The {area:1517} dig"] = "{area:1517}挖掘场",
	-- ["{item:8047}; below ground"] = "{item:8047}：在地下",
	-- ["{npc:1470}, below ground"] = "{npc:1470}：在地下",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{object:2743}; below ground"] = "{object:2743}：在地下",
}
