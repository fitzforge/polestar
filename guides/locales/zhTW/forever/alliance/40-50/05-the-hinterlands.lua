-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aerie Peak
	-- {npc:7744} Innkeeper Thulfram
	["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",

	-- Step 2: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "向東南騎到{zone:1425}南部的{area:355}（邪枝食人妖的階梯神廟），爬到頂端。守護者奇爾加和{npc:8636}（精英，50級）站在上面：碰到頂端就立刻下來。",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "向北騎到{zone:1425}中部的{area:351}。綠色淤泥怪和玉石軟泥怪在周圍到處爬行。",

	-- Step 4: Aerie Peak
	-- {area:348} Aerie Peak
	["Hearth to {area:348}."] = "用爐石回到{area:348}。",
	["Hearthstone on cooldown? Ride back north-west."] = "爐石在冷卻中？騎回西北方。",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "之後給{area:1438}的{quest:2990}",

	-- Step 5: Darkshire
	-- {area:348} Aerie Peak · {area:42} Darkshire
	["Fly from {area:348} to {area:42}."] = "從{area:348}飛往{area:42}。",

	-- Step 6: The bloodmages
	["The bloodmages"] = "血法師",
	-- {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "向東騎過{zone:1430}進入{zone:1435}，再沿道路向南進入{zone:1419}。血法師的營地是路旁的第一站。",

	-- Step 7: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "先沿道路繼續向東前往要塞：{item:6091}在離開{area:42}一小時後過期，而血法師要的野獸會花更久。",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}，在要塞頂端",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "{npc:8022}的下一個任務{item:9471}是{area:978}的任務：跳過它。",

	-- Step 8: Boars and basilisks
	["Boars and basilisks"] = "野豬與蜥蜴",
	-- plural, as words: Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "灰鬃野豬和紅石蜥蜴共同分布在要塞西南方的山坡上。遠離更南邊的地獄野豬：牠們是52級。",

	-- Step 9: Scorpoks and snickerfangs
	["Scorpoks and snickerfangs"] = "毒刺蠍與彎牙土狼",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "向西騎：饑餓的彎牙土狼在血法師營地南邊不遠的乾燥丘陵遊蕩；厚甲毒刺蠍（50級）在北部中央爬行。{npc:5982}禿鷲在整片區域上空盤旋。一次只拉一隻。",

	-- Step 10: The bloodmages
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "血法師的第二階段用增益物品換取同樣的材料，不給經驗值：跳過它。",

	-- Step 11: Thelsamar
	-- {area:1438} Nethergarde Keep · {area:144} Thelsamar
	["Ride back east to {area:1438} and fly to {area:144}."] = "向東騎回{area:1438}，飛往{area:144}。",

	-- Step 12: Ironband's Excavation Site
	["Ride east along the south shore of the loch to Ironband's camp."] = "沿湖的南岸向東騎到鐵環挖掘場的營地。",

	-- Step 13: The Uldaman dig
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "{area:1517}挖掘場",
	-- {zone:1418} Badlands · {area:1517} Uldaman
	["Ride south through the pass into the {zone:1418}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "向南穿過山口到{zone:1418}北緣：石窟穴居人在那裡的{area:1517}外挖掘。雕紋甕和洋紅色蘑菇叢在他們的洞穴和隧道中，在地城本身之外。",

	-- Step 14: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "向北騎回鐵環挖掘場的營地。",

	-- Step 16: Rut'theran Village
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village
	["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "從{area:144}飛往{area:150}，搭船到{area:442}，再飛往{area:702}。",
	["the book on her table"] = "她桌上的書",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}的下一個差事要去{zone:1446}：跳過它。",
	-- {npc:7916} Erelas Ambersky · {zone:1428} Burning Steppes
	["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}：先留著，羽毛在{zone:1428}指南的最後",

	-- Step 17: Temple of the Moon
	["Temple of the Moon"] = "Temple of the Moon",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "穿過傳送門進入{zone:1457}。Temple of the Moon在城市南部。",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}，在她旁邊",

	-- Step 19: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}，在樹頂",
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "土壤之後來自{zone:1449}",
	-- {zone:1455} Ironforge
	["The druid trainers stand in the Enclave; {zone:1455} has none"] = "德魯伊訓練師在塞納里奧區；{zone:1455}沒有",

	-- Step 20: Back to Thelsamar
	-- {area:144} Thelsamar
	["Back to {area:144}"] = "返回{area:144}",
	-- {area:144} Thelsamar · {zone:1427} Searing Gorge · {area:1446} Thorium Point · {zone:1418} Badlands · {area:340} Kargath
	["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "用爐石回到{area:144}。{zone:1427}指南從{area:1446}開始：從這裡向南騎進{zone:1418}，向西經過部落城鎮{area:340}，再沿小徑上到峽谷。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it."] = "向北騎到{zone:1425}中部的{area:351}。綠色淤泥怪和玉石軟泥怪在周圍到處爬行。",
	-- ["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down."] = "向東南騎到{zone:1425}南部的{area:355}（邪枝食人妖的階梯神廟），爬到頂端。守護者奇爾加和{npc:8636}（精英，50級）站在上面：碰到頂端就立刻下來。",
}
