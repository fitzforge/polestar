-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "向东南骑到{area:355}，即{zone:1425}南部的邪枝阶梯神庙，爬到顶上。奇尔加和{npc:8636}（精英，50级）站在上面：摸到顶层就直接下来。",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "向北骑到{zone:1425}中部的{area:351}。{npc:2655}和{npc:2656}在周围爬行。",

	-- Step 4: Aerie Peak
	-- {area:348} Aerie Peak
	["Hearth to {area:348}."] = "用炉石返回{area:348}。",
	["Hearthstone on cooldown? Ride back north-west."] = "炉石在冷却？向西北骑回去。",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "之后交给{area:1438}的{quest:2990}",

	-- Step 5: Darkshire
	-- {area:348} Aerie Peak · {area:42} Darkshire
	["Fly from {area:348} to {area:42}."] = "从{area:348}飞往{area:42}。",

	-- Step 6: The bloodmages
	["The bloodmages"] = "血法师",
	-- {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "向东骑过{zone:1430}进入{zone:1435}，再沿道路向南进入{zone:1419}。血法师营地是路旁的第一站。",

	-- Step 7: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "先沿道路继续向东到城堡：{item:6091}在离开{area:42}一小时后失效，而血法师要的野兽需要更长时间。",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}，在城堡顶层",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "{npc:8022}的下一个任务{item:9471}是{area:978}任务：跳过。",

	-- Step 8: Boars and basilisks
	["Boars and basilisks"] = "野猪和蜥蜴",
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "{npc:5992}和{npc:5990}分布在城堡西南方的山坡上。远离更南边的地狱野猪：它们是52级。",

	-- Step 9: Scorpoks and snickerfangs
	["Scorpoks and snickerfangs"] = "厚甲蝎和弯牙土狼",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "向西骑：{npc:5984}在血法师营地南边的干燥山丘上游荡；{npc:5988}（50级）在北部中间爬行。{npc:5982}秃鹫在整片区域上空盘旋。一次拉一只。",

	-- Step 10: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "血法师的第二阶段用增益物品而不是经验来交换同样的材料：跳过。",

	-- Step 11: Thelsamar
	-- {area:1438} Nethergarde Keep · {area:144} Thelsamar
	["Ride back east to {area:1438} and fly to {area:144}."] = "向东骑回{area:1438}，飞往{area:144}。",

	-- Step 12: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "沿湖南岸向东骑到铁环挖掘场的营地。",

	-- Step 13: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "{area:1517}挖掘场",
	-- {zone:1418} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "向南穿过山口到{zone:1418}北缘：石窟穴居人在那里的{area:1517}外面挖掘。雕纹石罐和紫色蘑菇在它们的洞穴和隧道里，在地下城外面。",

	-- Step 14: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "向北骑回铁环挖掘场的营地。",

	-- Step 16: Rut'theran Village
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "从{area:144}飞往{area:150}，乘船前往{area:442}，再飞往{area:702}。",
	["the book on her table"] = "她桌上的书",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}的下一个差事要去{zone:1446}：跳过。",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}：先留着，羽毛在{zone:1428}指南结尾获得",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "月神殿",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "穿过传送门进入{zone:1457}。月神殿在城市南部。",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}，在她旁边",

	-- Step 19: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}，在树顶",
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "土壤之后从{zone:1449}获得",
	-- {zone:1455} Ironforge
	["The druid trainers stand in the Enclave; {zone:1455} has none"] = "德鲁伊训练师站在塞纳里奥区；{zone:1455}没有",

	-- Step 20: Back to Thelsamar
	-- {area:144} Thelsamar
	["Back to {area:144}"] = "返回{area:144}",
	-- {area:144} Thelsamar · {zone:1427} Searing Gorge · {area:1446} Thorium Point · {zone:1418} Badlands · {area:340} Kargath
	["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "用炉石返回{area:144}。{zone:1427}指南从{area:1446}开始：从这里向南骑进{zone:1418}，向西经过部落城镇{area:340}，沿小路上到峡谷。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "向北骑到{zone:1425}中部的{area:351}。{npc:2655}和{npc:2656}在周围爬行。",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "向东南骑到{area:355}，即{zone:1425}南部的邪枝阶梯神庙，爬到顶上。守护者奇尔加和{npc:8636}（精英，50级）站在上面：摸到顶层就直接下来。",
}
