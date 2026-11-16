-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/05-the-hinterlands (forever/alliance/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Altar of Zul
	-- {area:355} Altar of Zul · {zone:1425} The Hinterlands · {npc:8636} Morta'gya the Keeper · {npc:7996} Qiaga the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Ride south-east to the {area:355}, the stepped Vilebranch temple in the south of the {zone:1425}, and climb to the top. Qiaga and {npc:8636} (elite, 50) stand up there: touch the top and come straight back down.\nCareful: Elite trolls guard the top platform, including {npc:7996} and {npc:8636}, along with several Vilebranch Soothsayers. The soothsayers cast spells and are linked to the rest of the group."] = "向東南騎到{zone:1425}南部的{area:355}（邪枝食人妖的階梯神廟），爬到頂端。守護者奇爾加和{npc:8636}（精英，50級）站在上面：碰到頂端就立刻下來。\n小心：頂層平台由精英食人妖守衛，包括{npc:7996}和{npc:8636}，還有幾名邪枝預言者。預言者會施法，而且與其他成員連動。",

	-- Step 2: Vilebranch Soothsayers
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["Vilebranch Soothsayers"] = "邪枝占卜者",
	-- {area:355} Altar of Zul · {npc:7996} Qiaga the Keeper · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Vilebranch Soothsayers = {npc:4467} Vilebranch Soothsayer
	["The Vilebranch Soothsayers (46-47) walk the ground around the foot of the {area:355}: their totems are for Maret Firetend. Careful: {npc:7996} and {npc:8636} (50, elites) stand on the altar's south-east side: take the Soothsayers on its west side, away from them, and stay off the altar."] = "邪枝占卜者（46-47級）在{area:355}山腳周圍走動：他們的圖騰是給瑪蕾·火護的。小心：{npc:7996}和{npc:8636}（50級，精英）站在祭壇東南側：在祭壇西側打占卜者，遠離她們，也別上祭壇。",

	-- Step 3: Skulk Rock
	-- {area:351} Skulk Rock · {zone:1425} The Hinterlands
	-- plural, as words: Green Sludges = {npc:2655} Green Sludge · Jade Oozes = {npc:2656} Jade Ooze
	["Ride north to {area:351} in the middle of the {zone:1425}. Green Sludges and Jade Oozes crawl all around it.\nCareful: Panthers move around the area in stealth."] = "向北騎到{zone:1425}中部的{area:351}。綠色淤泥怪和玉石軟泥怪在周圍到處爬行。\n小心：這一帶有豹子潛行走動。",

	-- Step 4: Wildkin feathers
	["Wildkin feathers"] = "梟獸羽毛",
	-- {npc:7916} Erelas Ambersky · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {area:351} Skulk Rock
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["{npc:7916}'s Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam: pick them up as you ride between the altar and {area:351}."] = "{npc:7916}要的梟獸羽毛散落在{zone:1425}各處的地上，在{area:348}的南邊和東邊，也就是梟獸遊蕩的地方：在祭壇和{area:351}之間騎行時順手撿起來。",

	-- Step 5: Lost Gryphon Eggs
	-- plural, as words: Lost Gryphon Eggs = {item:279229} Lost Gryphon Egg
	["Lost Gryphon Eggs"] = "遺失的獅鷲獸蛋",
	-- {area:348} Aerie Peak
	["On the way back to {area:348}: the lost gryphon eggs lie in the hills just east of the aviary."] = "在回{area:348}的路上：遺失的獅鷲獸蛋就在獅鷲棲所東邊不遠的山丘上。",

	-- Step 6: Aerie Peak
	["Inside"] = "",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, inside"] = "",
	-- {npc:270263} Farseer Maret Firetend
	["{npc:270263}, just east of the aviary"] = "{npc:270263}，在獅鷲棲所東邊不遠",
	-- {quest:2990} Thadius Grimshade · {area:1438} Nethergarde Keep
	["for {quest:2990} at {area:1438}, later"] = "之後給{area:1438}的{quest:2990}",

	-- Step 7: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飛往{area:1537}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 8: Class trainer
	["Class trainer"] = "職業訓練師",

	-- Step 9: Ironforge inn
	-- {area:1537} Ironforge
	["{area:1537} inn"] = "{area:1537}旅店",
	-- {object:26486} Stonefire Tavern · {zone:1427} Searing Gorge · {area:144} Thelsamar
	["Set your hearth at the {object:26486}: the {zone:1427} guide starts with the hearth back here and the gryphon to {area:144}."] = "",

	-- Step 10: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "搭地鐵前往{zone:1453}",

	-- Step 12: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飛往{area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 15: The bloodmages
	["The bloodmages"] = "血法師",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep
	["The bloodmages' camp is the first stop beside the road into the {zone:1419}, north-west of {area:1438}."] = "",
	-- {npc:7505} Bloodmage Drazial · {zone:1419} Blasted Lands
	["{npc:7505}: keep the five, their beasts (48-53) wait for the level-52 {zone:1419} stop"] = "{npc:7505}：保留這五個任務，牠們的野獸（48-53級）留到52級的{zone:1419}行程再處理",

	-- Step 16: Nethergarde Keep
	-- {item:6091} Crate of Power Stones · {area:42} Darkshire
	["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}."] = "先沿道路繼續向東前往要塞：{item:6091}在離開{area:42}一小時後過期。",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}，在要塞頂端",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "{npc:8022}的下一個任務{item:9471}是{area:978}的任務：跳過它。",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "",

	-- Step 17: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飛往{area:35}",
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "",

	-- Step 18: Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	["\"Sea Wolf\" MacKinley, if the Stranglethorn guide didn't give it"] = "『海狼』麥金利，如果荊棘谷指南沒有給你這個任務",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor, if the Stranglethorn guide didn't give it"] = "{npc:2487}，頂樓，如果荊棘谷指南沒有給你這個任務",
	-- {npc:2494} Privateer Bloads
	["{npc:2494}, if the Stranglethorn guide didn't give it"] = "{npc:2494}，如果荊棘谷指南沒有給你這個任務",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, if the Stranglethorn guide didn't give it"] = "{npc:2498}，在裡面，如果荊棘谷指南沒有給你這個任務",

	-- Step 19: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "",
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["The charts and orders lie in the pirate camp on the {area:43}, just south of {area:35}; its Swashbucklers walk the shore. The Warlocks and Swashbucklers (41-43) are under you now."] = "海圖和命令在{area:35}南邊不遠、{area:43}上的海盜營地裡；營地的劍客在海岸上走動。術士和劍客（41-43級）現在等級都比你低了。",

	-- Step 20: Booty Bay
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}，頂樓",

	-- Step 21: The Bloodsail captains
	["The Bloodsail captains"] = "血帆船長",
	-- {area:35} Booty Bay · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["The three Bloodsail ships lie at anchor off the coast just south of {area:35}: {npc:2550} (45) and {npc:2548} (46) on the nearer decks, {npc:2546} (48) on the flagship, each with a crew of 42-45 pirates. Swim out, clear each deck from the edge and pull one at a time."] = "",

	-- Step 23: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "納迦探險者",
	["Leave town by the tunnel and ride north along the coast past the Bloodsail camp: the naga comb the beaches beyond it and drop the reeds."] = "從隧道離開城鎮，沿海岸向北經過血帆營地：娜迦在營地外的海灘上搜尋，會掉落蘆葦。",

	-- Step 24: Zanzil's village
	["Zanzil's village"] = "贊吉爾的村莊",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Ride on north along the coast to Zanzil's village. Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "沿海岸繼續向北前往贊吉爾的村莊。每個贊吉爾追隨者都可能掉落混合物；{npc:2537}在營地南側走動。",

	-- Step 25: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535}與{npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536} stand together in the hills just north of Zanzil's village."] = "{npc:2535}和{npc:2536}一起站在贊吉爾村莊北邊不遠的山丘上。",

	-- Step 26: Gorilla hills
	["Gorilla hills"] = "猩猩山丘",
	-- {area:35} Booty Bay · {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Gorilla Fangs = {item:2799} Gorilla Fang · Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride back south-east to the Mistvale gorilla hills above {area:35}. {npc:1449} sits among the gorillas: take ten Gorilla Fangs from the Elder Mistvale Gorillas first."] = "向東南騎回{area:35}上方的迷霧谷猩猩山丘。{npc:1449}坐在猩猩群中：先從老邁的迷霧谷猩猩身上取得十顆猩猩牙。",

	-- Step 27: Unbagwa's ritual
	["Unbagwa's ritual"] = "安巴格瓦的儀式",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "繳交牙齒後留在原地：會來三波猩猩，最後是{npc:1514}。\n小心：三波猩猩接連而來，中間幾乎沒有喘息時間，最後是{npc:1514}。開始前補滿血和法力，並待在安巴格瓦附近。有些職業單人會很吃力：找個朋友就輕鬆了。",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "",

	-- Step 28: Booty Bay
	["Ride back down to town."] = "騎回鎮上。",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it, the Un'Goro guide lands there"] = "交給塞拉摩的{npc:2616}：留著它，安戈洛指南會帶你到那裡",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}的下一個贊吉爾任務從{zone:1441}開始：跳過。",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	["MacKinley's next task sends you after elite ogres: skip it."] = "馬克基雷的下一個任務要你去打精英巨魔：跳過。",

	-- Step 29: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 33: Facing Negolash
	-- {npc:1494} Negolash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1494} (level 52 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep. Keep clear of the Helboars further south: they are level 52."] = "灰鬃野豬和紅石蜥蜴共同分布在要塞西南方的山坡上。遠離更南邊的地獄野豬：牠們是52級。",
	-- ["Back to {area:144}"] = "返回{area:144}",
	-- ["Boars and basilisks"] = "野豬與蜥蜴",
	-- ["Fly from {area:144} to {area:150}, take the boat to {area:442} and fly to {area:702}."] = "從{area:144}飛往{area:150}，搭船到{area:442}，再飛往{area:702}。",
	-- ["Fly from {area:348} to {area:42}."] = "從{area:348}飛往{area:42}。",
	-- ["Hearth to {area:144}. The {zone:1427} guide starts at {area:1446}: from here, ride south into the {zone:1418}, west past the Horde town of {area:340} and up the trail into the gorge."] = "用爐石回到{area:144}。{zone:1427}指南從{area:1446}開始：從這裡向南騎進{zone:1418}，向西經過部落城鎮{area:340}，再沿小徑上到峽谷。",
	-- ["Hearth to {area:348}."] = "用爐石回到{area:348}。",
	-- ["Hearthstone on cooldown? Ride back north-west."] = "爐石在冷卻中？騎回西北方。",
	-- ["Portal to {zone:1438}"] = "傳送門前往{zone:1438}",
	-- ["Ride back east to {area:1438} and fly to {area:144}."] = "向東騎回{area:1438}，飛往{area:144}。",
	-- ["Ride back north to Ironband's camp."] = "向北騎回鐵環挖掘場的營地。",
	-- ["Ride east along the south shore of the loch to Ironband's camp."] = "沿湖的南岸向東騎到鐵環挖掘場的營地。",
	-- ["Ride east through {zone:1430} into the {zone:1435} and south down the road into the {zone:1419}. The bloodmages' camp is the first stop beside the road."] = "向東騎過{zone:1430}進入{zone:1435}，再沿道路向南進入{zone:1419}。血法師的營地是路旁的第一站。",
	-- ["Ride on east along the road to the keep first: the {item:6091} expires an hour after {area:42}, and the bloodmages' beasts take longer than that."] = "先沿道路繼續向東前往要塞：{item:6091}在離開{area:42}一小時後過期，而血法師要的野獸會花更久。",
	-- ["Ride south through the pass into the {area:3}' northern edge: the Stonevault troggs dig outside {area:1517} there. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "向南穿過山口到{area:3}北緣：石窟穴居人在那裡的{area:1517}外挖掘。雕紋甕和洋紅色蘑菇叢在他們的洞穴和隧道中，在地城本身之外。",
	-- ["Ride west: Starving Snickerfangs roam the dry hills just south of the bloodmages' camp; Scorpok Stingers (level 50) scuttle across the middle of the north. {npc:5982} vultures circle over all of it. Pull one at a time."] = "向西騎：饑餓的彎牙土狼在血法師營地南邊不遠的乾燥丘陵遊蕩；厚甲毒刺蠍（50級）在北部中央爬行。{npc:5982}禿鷲在整片區域上空盤旋。一次只拉一隻。",
	-- ["Scorpoks and snickerfangs"] = "毒刺蠍與彎牙土狼",
	-- ["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "穿過傳送門進入{zone:1457}。Temple of the Moon在城市南部。",
	-- ["Temple of the Moon"] = "Temple of the Moon",
	-- ["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "血法師的第二階段用增益物品換取同樣的材料，不給經驗值：跳過它。",
	-- ["The druid trainers stand in the Enclave; {zone:1455} has none"] = "德魯伊訓練師在塞納里奧區；{zone:1455}沒有",
	-- ["The {area:1517} dig"] = "{area:1517}挖掘場",
	-- ["the book on her table"] = "她桌上的書",
	-- ["the soil comes from {zone:1449}, later"] = "土壤之後來自{zone:1449}",
	-- ["{npc:3516}, at the top of the tree"] = "{npc:3516}，在樹頂",
	-- ["{npc:7740}, beside her"] = "{npc:7740}，在她旁邊",
	-- ["{npc:7744}: the last guide binds here, so this usually ticks at once"] = "{npc:7744}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "{npc:7907}的下一個差事要去{zone:1446}：跳過它。",
	-- ["{npc:7916}: keep it, the feathers come at the end of the {zone:1428} guide"] = "{npc:7916}：先留著，羽毛在{zone:1428}指南的最後",
}
