-- Chinese (traditional) (zhTW): the guide forever/class/mage/staff-or-orb-alliance (forever/class/mage/staff-or-orb-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:9514} Arcane Staff
	["Ley or {item:9514} or Orb (Alliance)"] = "魔網、{item:9514}或寶珠（聯盟）",
	["A staff or an off-hand orb at 10 from your home town's mage trainer; Skyborne add a wand."] = "10級時在主城的法師訓練師處獲得一根法杖或一個副手寶珠；天行者額外獲得一根魔杖。",

	-- Step 1: Anathamaas Aetherwind (Valanaar)
	-- {npc:252373} Anathamaas Aetherwind · {area:16638} Valanaar · {npc:256507} Belann Windwood
	["At 10 {npc:252373}, the {area:16638} mage trainer, sends you to {npc:256507}, the staff merchant a few steps away in the same town."] = "10級時，{area:16638}的法師訓練師{npc:252373}會讓你去找{npc:256507}，那是同鎮幾步之外的杖類商人。",

	-- Step 2: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "風石岩層",
	-- {area:16636} Falaath Village
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The bough lies on the ground among the Windstone Formations, the wind shrine on the rise west of Fillion's camp, south of {area:16636}. It does not sparkle, so look at the ground by the stones; there are two spots for it."] = "樹枝躺在風石陣之間的地面上，那是菲里昂營地以西高地上的風之神龕，{area:16636}以南。它不會閃光，所以在石頭旁的地面上找；有兩個可能的位置。",

	-- Step 3: Back to Belann Windwood
	-- {npc:256507} Belann Windwood
	["Back to {npc:256507}"] = "回到{npc:256507}",
	-- {quest:1861} Mirror Lake · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{quest:1861} (the next steps) waits for you with {npc:5497} in {zone:1453}, at about 15."] = "{quest:1861}（後續步驟）會在{zone:1453}的{npc:5497}那裡等你，約15級。",

	-- Step 4: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire · {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {quest:1879} Speak with Bink · {area:131} Kharanos · {quest:1861} Mirror Lake · {npc:5144} Bink
	["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {quest:1879}, the {area:131} trainer's errand; {quest:1861} and {npc:5144}'s Gizmonitor shut out each other, so you get one staff or orb."] = "10級時，{area:87}的法師訓練師{npc:328}（在獅王之傲旅店樓上）會把你派去{zone:1453}找{npc:5497}。接下它就放棄了{area:131}訓練師的差事{quest:1879}；{quest:1861}和{npc:5144}的小裝置互斥，所以你只能拿到法杖或寶珠之一。",

	-- Step 5: Magis Sparkmantle (Kharanos)
	-- {npc:1228} Magis Sparkmantle · {area:131} Kharanos · {area:2102} Thunderbrew Distillery · {npc:5144} Bink · {zone:1455} Ironforge · {quest:1860} Speak with Jennea · {area:87} Goldshire · {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake · {npc:328} Zaldimar Wefhellt
	["At 10 {npc:1228}, the {area:131} mage trainer in the {area:2102}, sends you to {npc:5144} in {zone:1455}. Taking it shuts out {quest:1860}, the {area:87} trainer's errand; {npc:5144}'s Gizmonitor and {npc:5497}'s {quest:1861} shut out each other, so you get one staff or orb. (A Gnome who took {npc:328}'s quest in {area:87} instead follows the {quest:1861} steps; a Human who took this one, the Gizmonitor steps.)"] = "10級時，{area:131}的法師訓練師{npc:1228}（在{area:2102}裡）會把你派去{zone:1455}找{npc:5144}。接下它就放棄了{area:87}訓練師的差事{quest:1860}；{npc:5144}的小裝置和{npc:5497}的{quest:1861}互斥，所以你只能拿到法杖或寶珠之一。（在{area:87}接了{npc:328}任務的侏儒改走{quest:1861}那幾步；接了這條的人類走小裝置那幾步。）",

	-- Step 6: Jennea Cannon
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5497} Jennea Cannon · {item:7207} Jennea's Flask · {quest:1861} Mirror Lake
	["Follow the road north into {zone:1453} and west to the {object:2101}. {npc:5497} stands at the top of the Wizard's Sanctum, the tall violet tower: climb the spiral ramp and step into the portal near the top, which puts you beside her. She hands you {item:7207}. Skyborne mages take {quest:1861} from her when they first reach {zone:1453}, at about 15."] = "沿路向北進入{zone:1453}，再向西到{object:2101}。{npc:5497}站在巫師聖殿頂部，那座高大的紫色塔：沿螺旋坡道向上，走進頂部的傳送門，就會到她身旁。她交給你{item:7207}。天裔法師第一次到{zone:1453}時（約15級）會從她那裡接{quest:1861}。",

	-- Step 7: The Mirror Lake waterfall
	-- {quest:1861} Mirror Lake
	["The {quest:1861} waterfall"] = "{quest:1861}瀑布",
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate and head south-west to the waterfall that feeds {quest:1861}. Wade in under the falling water to the rock behind it and use {item:7207} there (a 5 second cast); it fails anywhere else. Level 10 Defias casters stand on the rocks either side of the falls and shoot from range: pull them one at a time or fill the flask from the water."] = "從正門離開{zone:1453}，向西南前往{quest:1861}所對應的瀑布。蹚進落水下方，走到瀑布後的岩石，在那裡使用{item:7207}（5秒施法）；在其他任何地方都會失敗。10級迪菲亞施法者站在瀑布兩側的岩石上遠端射擊：一隻一隻拉，或者直接從水裡灌滿瓶子。",
	-- {item:7207} Jennea's Flask
	["{item:7207}, under the falls"] = "{item:7207}，瀑布下",

	-- Step 8: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "返回{npc:5497}",
	["Back up the Wizard's Sanctum and through the portal. The orb is an off-hand for a one-hand weapon; the staff is a two-hander."] = "回到巫師聖殿上層，穿過傳送門。寶珠是單手武器的副手；法杖是雙手武器。",
	-- {npc:5497} Jennea Cannon · {item:7508} Ley Orb · {item:9513} Ley Staff
	["{npc:5497}: {item:7508} or {item:9513}"] = "{npc:5497}：{item:7508}或{item:9513}",

	-- Step 9: Bink
	-- {npc:5144} Bink · {object:32362} Mystic Ward · {zone:1455} Ironforge · {object:32386} Hall of Mysteries
	["{npc:5144} teaches mages in the {object:32362}, at the back of {zone:1455} past the {object:32386}."] = "{npc:5144}在{object:32362}裡教法師，那裡是{zone:1455}的後部，穿過{object:32386}就到。",

	-- Step 10: Bink's Toolbox
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["Head west along the road to {area:133}. Just north of its entrance stand two huts; the toolbox is in the taller, eastern one, the hut with the lift: a small grey box on the ground floor, half under the table beside the lift. Leper Gnomes (level 8) guard the huts: pull them singly. There is only one toolbox and it takes 15 minutes to come back after someone opens it, so wait nearby if it is gone."] = "沿路向西前往{area:133}。入口正北有兩座小屋；工具箱在較高、靠東的那座，也就是帶升降機的小屋：一樓的一隻灰色小盒子，一半在升降機旁的桌子下面。麻風侏儒（8級）看守著小屋：一隻一隻拉。工具箱只有一個，被人開啟後要15分鐘才會重新出現，所以如果它不見了就在附近等。",

	-- Step 11: Back to Bink
	-- {npc:5144} Bink
	["Back to {npc:5144}"] = "回到{npc:5144}",
	-- {npc:5144} Bink · {item:7507} Arcane Orb · {item:9514} Arcane Staff
	["{npc:5144}: {item:7507} or {item:9514}"] = "{npc:5144}：{item:7507}或{item:9514}",

	-- Step 12: Belann Windwood's wand (optional)
	-- {npc:256507} Belann Windwood
	["{npc:256507}'s wand (optional)"] = "{npc:256507}的魔杖（可選）",
	-- {npc:256507} Belann Windwood · {area:16638} Valanaar · {zone:2521} Zephras Isle · {npc:252373} Anathamaas Aetherwind · {item:262668} Wind-Infused Bough · {area:16636} Falaath Village · {item:263430} Windbough Wand
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["{npc:256507}'s quest is open to Human and Gnome mages too, if you ever visit {area:16638} on {zone:2521}, the Skyborne home: {npc:252373}, the town's mage trainer, sends you to {npc:256507} next door, who wants a {item:262668} from the ground by the Windstone Formations south of {area:16636}, for the {item:263430}. It does not shut out the staff or the orb."] = "{npc:256507}的任務也向人類和侏儒法師開放，只要你有一天到訪天裔的家園{zone:2521}上的{area:16638}：鎮上的法師訓練師{npc:252373}會讓你去找隔壁的{npc:256507}，他要一個來自{area:16636}以南風石陣旁地面的{item:262668}，用來換{item:263430}。它不會關閉法杖或寶珠任務。",
}
