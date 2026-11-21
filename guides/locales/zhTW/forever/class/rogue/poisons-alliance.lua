-- Chinese (traditional) (zhTW): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Alliance)"] = "毒藥（聯盟）",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever 透過這個任務鏈教授毒藥，而不是由訓練師教授；{item:7676}的配方也會一起給你。",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332}, upstairs in the SI:7 building in {object:2100}, sends you to {npc:7024} in {zone:1436}. This chain is how you learn Poisons on Forever, so do not skip it."] = "20級時，{object:2100}軍情七處建築樓上的{npc:332}會派你去{zone:1436}找{npc:7024}。在Forever中要透過這個任務鏈學習毒藥，所以不要跳過。",

	-- Step 2: Agent Kearnen
	-- {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {item:8046} Kearnen's Journal
	["Kearnen hides stealthed against the west side of a big tree with two small trees in front of it, just north of {npc:7053}'s Defias tower in the far east of {zone:1436}, by the {zone:1431} border. Read {item:8046} for the tower's layout if you like."] = "凱爾南潛行躲在一棵大樹西側，樹前有兩棵小樹，就在{zone:1436}最東邊{npc:7053}的迪菲亞塔樓以北、靠近{zone:1431}邊界的地方。想看塔樓佈局的話，讀{item:8046}。",

	-- Step 3: Klaven's Tower, with a group
	-- {quest:2359} Klaven's Tower
	["{quest:2359}, with a group"] = "{quest:2359}，組隊",
	-- {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {object:123214} Duskwood Chest · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["{npc:7053} on the top floor is a level 26 elite: easier at 24 or with a friend. Get the key first: the {npc:7051} (level 23, the spiky-haired one trailing yellow sparkles) walks a loop around the tower; stealth up and {spell:921} it from behind. Then up the tower past the Defias Tower Patrollers (23) and Sentries (24) to the {object:123214} beside Klaven's desk (Lockpicking about 70-75). Opening it poisons you with the {spell:9810}, which stops your stealth for a while."] = "頂樓的{npc:7053}是26級精英：24級或找朋友會比較輕鬆。先拿鑰匙：{npc:7051}（23級，頭髮尖刺、身後拖著黃色閃光的那個）繞著塔巡邏；潛行後從背後對牠使用{spell:921}。接著上塔，經過迪菲亞巡塔員（23級）和哨兵（24級），到克拉文書桌旁的{object:123214}（開鎖技能約70-75）。打開它會讓你中{spell:9810}之毒，一段時間內無法潛行。",
	-- {spell:921} Pick Pocket · {npc:7051} Malformed Defias Drone · {item:7923} Defias Tower Key
	["{spell:921} the {npc:7051} for the {item:7923}"] = "對{npc:7051}使用{spell:921}，拿到{item:7923}",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}: the {object:123214}, top floor"] = "{item:7908}：{object:123214}，頂樓",

	-- Step 4: Klaven's Tower, solo
	-- {quest:2359} Klaven's Tower
	["{quest:2359}, solo"] = "{quest:2359}，單人",
	-- {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {spell:2983} Sprint · {npc:7053} Klaven Mortwake · {object:123214} Duskwood Chest · {area:97} Alther's Mill · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Drones = {npc:7050} Defias Drone · Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["Get the key first. The {npc:7051} (level 23, not elite) starts at the tower entrance and walks a loop around the outside; it is the spiky-haired one trailing yellow sparkles. Stealth up and {spell:921} it from behind: it always has the key. It hits hard: if stealth breaks, {spell:2983} away. Watch for the pair of Defias Drones that also patrol. Then sneak up the tower. Defias Tower Patrollers (23) and Sentries (24) guard the floors; an Ambush with a dagger kills them outright if you would rather clear them. {npc:7053}, a level 26 elite, waits on the top floor: Sap him, or bring a friend. The {object:123214} beside his desk needs Lockpicking of about 70-75 (practise on the boxes at {area:97} in Redridge first). A trick: while the Sentries are away, jump from the chair to the lamp to the bookshelf above the chest, step out of stealth and open the chest from there. Opening it poisons you with the {spell:9810}, which stops your stealth for a while and lets the drone see you; that is why the key comes first. Then get out."] = "先拿鑰匙。{npc:7051}（23級，非精英）從塔的入口出發，繞著塔外巡邏；就是頭髮尖刺、身後拖著黃色閃光的那個。潛行後從背後對牠使用{spell:921}：牠身上一定有鑰匙。牠打很痛：如果潛行被破，就用{spell:2983}逃開。注意同樣在巡邏的兩隻迪菲亞苦工。然後潛行上塔。迪菲亞巡塔員（23級）和哨兵（24級）守著各層；如果你想清掉它們，用匕首伏擊可以直接秒殺。{npc:7053}是26級精英，在頂樓等著：悶棍他，或找朋友幫忙。他書桌旁的{object:123214}需要約70-75的開鎖技能（先在赤脊山{area:97}的箱子練習）。小技巧：趁哨兵離開時，從椅子跳到燈上再跳到箱子上方的書架，解除潛行後從那裡開箱。打開它會讓你中{spell:9810}之毒，一段時間內無法潛行，苦工也會看到你；所以要先拿鑰匙。然後離開。",

	-- Step 5: Master Mathias Shaw
	-- {zone:1453} Stormwind · {item:7676} Thistle Tea · {spell:8681} Instant Poison · {item:2928} Dust of Decay · {item:3371} Empty Vial · {npc:1325} Jasper Fel · {npc:1326} Sloan McCoy · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is upstairs in SI:7. He teaches Poisons and gives you the {item:7676} recipe. Poisons are made, not bought: each batch of {spell:8681} takes a {item:2928} and an {item:3371}, which {npc:1325} and {npc:1326} sell in {object:2100} next to SI:7. Buy a stack of each, open Poisons from your spellbook to make them, then use a poison on your weapon."] = "穿過艾爾文森林往北前往{zone:1453}；馬迪亞斯·肖爾在軍情七處樓上。他會教你毒藥，並給你{item:7676}配方。毒藥要自己製作，不能直接購買：每批{spell:8681}需要一份{item:2928}和一個{item:3371}，軍情七處旁{object:2100}的{npc:1325}和{npc:1326}都有出售。各買一組，從法術書中開啟毒藥介面製作，然後把毒藥塗在武器上。",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}: Poisons"] = "{npc:332}：毒藥",

	-- Step 6: Doc Mixilpixil
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil · {npc:1325} Jasper Fel
	["{quest:2607} still sits on you. {npc:7207} works in the cellar of the SI:7 building: the stairs down are under the stairs to the upper floor, behind {npc:1325}. Target him and type /lay (nothing after it) to be examined, then wait. If he does nothing, abandon the quest, take it again and wait until he asks you to lie down."] = "",
	["/lay with the Doc targeted"] = "選中醫生後輸入 /lay",

	-- Step 7: The cure's ingredients
	["The cure's ingredients"] = "解藥的材料",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {npc:1303} Felicia Gump · {object:2096} Trade District · {item:3372} Leaded Vial · {npc:1257} Keldric Boucher · {npc:1325} Jasper Fel · {item:4371} Bronze Tube · {item:8431} Spool of Light Chartreuse Silk Thread · {object:2177} The Finest Thread · {item:6452} Anti-Venom · {skill:129} First Aid · {spell:526} Cure Poison · {spell:9810} Touch of Zanzil
	["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: the Auction House in the {object:2096}; the engineering suppliers keep only one and are nearly always sold out, and an engineer can make one. The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "四樣東西都在{zone:1453}。{item:3421}：伯納德，或{object:2096}運河邊{npc:1303}的花店。{item:3372}：很多雜貨和鍊金商人有賣（{npc:1257}、{npc:1325}等）。{item:4371}：{object:2096}的拍賣行；工程供應商只備一個，幾乎總是賣光，工程學也能做一個。{item:8431}躺在運河邊裁縫店{object:2177}櫃檯左端旁的地上；只有接了這個任務才能撿。要是跳過治療，{skill:129}做的{item:6452}或德魯伊的{spell:526}也能解掉{spell:9810}。",
	-- {item:4371} Bronze Tube
	["{item:4371}: the Auction House"] = "{item:4371}：拍賣行",

	-- Step 8: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "返回{npc:7207}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/lay down"] = "/lay down",
	-- ["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "全部都在{zone:1453}：加姆一家販售{item:3421}，{item:8431}就在城裡，最近的商人販售{item:3372}和{item:4371}。",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北騎過艾爾文森林前往{zone:1453}；馬迪亞斯·肖爾在{object:2100}的軍情七處。",
	-- ["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024}從{zone:1436}最東邊、靠近{zone:1431}邊界的山丘上監視{npc:7053}的塔。守衛塔樓的{npc:7051}（23級）帶著鑰匙；克拉文的日記在塔頂的箱子裡。",
	-- ["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207}在軍情七處兵營的地下室工作。在他旁邊輸入 /lay down 接受檢查。",
	-- ["{spell:2842} (Alliance)"] = "{spell:2842}（聯盟）",
}
