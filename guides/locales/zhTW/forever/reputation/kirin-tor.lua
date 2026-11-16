-- Chinese (traditional) (zhTW): the guide forever/reputation/kirin-tor (forever/reputation/kirin-tor.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kirin Tor Reputation"] = "肯瑞託聲望",
	-- {area:279} Dalaran
	["New in Forever: {area:279}'s mages sell Azure armour recipes at Friendly and their tabard at Exalted."] = "Forever 新增：{area:279}的法師在友善時出售碧藍護甲配方，崇拜時出售他們的戰袍。",
	-- {skill:164} Blacksmithing · {skill:165} Leatherworking · {skill:197} Tailoring
	["Eight Azure helm and shoulder recipes at Friendly ({skill:164}, {skill:165}, {skill:197})"] = "友善時可購八種蔚藍頭盔和護肩配方（{skill:164}、{skill:165}、{skill:197}）",

	-- Step 1: Skyborne: the recipes now
	["Skyborne: the recipes now"] = "天裔：立刻買配方",
	-- {faction:2740} Kirin Tor · {npc:32287} Archmage Alvareaux · {area:279} Dalaran
	["Alliance Skyborne start Friendly with the {faction:2740}, and their arrival quests The Magical City of Dalaran and Exploring the Alliance pay 100 more each, so {npc:32287} sells you the Azure recipes at once (10g each, they need skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}, past the Sky Enclave. Buy the ones for your profession."] = "聯盟天裔與{faction:2740}初始為友善，他們的到來任務“魔法之城達拉然”和“探索聯盟”各多給100點，所以{npc:32287}會立刻向你出售碧藍配方（每個10金，需要技能175）。他站在{area:279}裡掛有{faction:2740}旗幟的建築樓上，過了天空營地就是。買你專業對應的那些。",

	-- Step 2: An Alarming Request
	-- {npc:247264} Emissary Jacques · {faction:2740} Kirin Tor · {area:271} Southshore · {npc:246748} Archmage Modera · {area:1338} Lordamere Lake · {area:279} Dalaran
	["{npc:247264} of the {faction:2740} waits in {area:271}. He sends you to {npc:246748}'s image by the shore of {area:1338}, outside {area:279}'s walls. The {faction:2740} quests start at level 24 to 30 and pay full reputation at any level in Forever."] = "{faction:2740}的{npc:247264}在{area:271}等著。他把你派去{area:1338}岸邊、{area:279}城牆外的{npc:246748}影像處。{faction:2740}的任務24到30級可接，Forever 裡任何等級都足額給聲望。",

	-- Step 3: Archmage Modera's image
	-- {npc:246748} Archmage Modera
	["{npc:246748}'s image"] = "{npc:246748}的影像",
	-- {item:277507} Dalaran Sewer Key
	["you get the {item:277507} with it"] = "同時獲得{item:277507}",

	-- Step 4: The City of Dalaran
	["The City of Dalaran"] = "達拉然城",
	-- {quest:92457} Starving Arcane · {npc:246020} Shade of the Archmage · {npc:246748} Archmage Modera · {item:251961} Arcane Mote · {faction:2740} Kirin Tor
	["The City of Dalaran is a dungeon for levels 28 to 33: go in through the sewers with the key Modera gave you. The arcane elementals throughout the city count for {quest:92457}. The {npc:246020}, the last boss, waits in the Purple Parlor above the Violet Citadel (a portal by {npc:246748} in the Citadel takes you up) and drops the {item:251961}. Beta players saw every kill in the dungeon pay {faction:2740} reputation, the bosses the most. Group of five advised below level 35."] = "“達拉然城”是28到33級的副本：用茉德拉給你的鑰匙從下水道進入。城中各處的奧術元素都計入{quest:92457}。最後的首領{npc:246020}在紫羅蘭城堡上方的紫色會客廳等待（城堡裡{npc:246748}旁有傳送門送你上去），並掉落{item:251961}。測試服玩家看到副本里每次擊殺都給{faction:2740}聲望，首領給得最多。35級以下建議五人隊。",
	-- {item:251961} Arcane Mote · {npc:246020} Shade of the Archmage
	["{item:251961}, from the {npc:246020}"] = "{item:251961}，來自{npc:246020}",

	-- Step 5: Back to Modera's image
	["Back to Modera's image"] = "返回茉德拉的影像",

	-- Step 6: Archmage Celindra
	-- {npc:252085} Archmage Celindra · {area:279} Dalaran
	["{npc:252085} waits in the Violet Citadel in {area:279}."] = "{npc:252085}在{area:279}的紫羅蘭城堡裡等待。",

	-- Step 7: Past Due
	-- {npc:264265} Magus Olvek · {area:279} Dalaran · {npc:6487} Arcanist Doan · {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["{npc:264265} in {area:279} wants a book back from {npc:6487}, the last boss of the {area:796}'s Library (levels 33 to 41), in {zone:1420}."] = "{area:279}的{npc:264265}想從{zone:1420}的{area:796}圖書館（33到41級）最後首領{npc:6487}那裡拿回一本書。",

	-- Step 8: Arcanist Doan
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades
	["The {area:796} stands in the north-east of {zone:1420}; Doan waits at the end of the Library wing. Group of five advised below level 40."] = "{area:796}位於{zone:1420}東北部；杜安在圖書館側翼盡頭等待。40級以下建議五人隊。",
	-- {item:273169} The Lost Magic of the Runemasters · {npc:6487} Arcanist Doan
	["{item:273169}, from {npc:6487}"] = "{item:273169}，來自{npc:6487}",

	-- Step 9: Back to Magus Olvek
	-- {npc:264265} Magus Olvek
	["Back to {npc:264265}"] = "返回{npc:264265}",

	-- Step 10: City of Dalaran runs to Friendly
	["City of Dalaran runs to Friendly"] = "刷“達拉然城”到友善",
	["The quests leave a non-Skyborne at about 320 of the 3,000 Friendly needs. The rest comes from kills in the City of Dalaran dungeon: run it until Friendly. How much each kill pays is not in the game's data; the bosses pay the most. At 60 you clear it alone."] = "這些任務只能讓非天裔角色達到友善所需3,000點中的約320點。其餘來自“達拉然城”副本的擊殺：一直刷到友善。每次擊殺給多少不在遊戲資料裡；首領給得最多。60級時你可以單刷。",

	-- Step 11: Archmage Alvareaux: the Azure recipes
	-- {npc:32287} Archmage Alvareaux
	["{npc:32287}: the Azure recipes"] = "{npc:32287}：碧藍配方",
	-- {npc:32287} Archmage Alvareaux · {faction:2740} Kirin Tor · {area:279} Dalaran
	["{npc:32287} sells the Azure helm and shoulder recipes at Friendly, 10g each (skill 175). He stands upstairs in the building with the {faction:2740} banners in {area:279}. Buy the ones for your profession."] = "{npc:32287}在友善時出售碧藍頭盔和護肩配方，每個10金（技能175）。他站在{area:279}裡掛有{faction:2740}旗幟的建築樓上。買你專業對應的那些。",

	-- Step 12: City of Dalaran runs to Exalted
	["City of Dalaran runs to Exalted"] = "刷“達拉然城”到崇拜",
	["Nothing is sold at Honored or Revered in the game's data. Friendly to Exalted is 39,000 reputation, all from City of Dalaran kills. In Classic most dungeon kills stop paying at Honored or Revered; whether these do is not known yet."] = "遊戲資料裡，尊敬或崇敬時沒有出售任何東西。友善到崇拜是39,000點聲望，全部來自“達拉然城”的擊殺。經典舊世裡大多數副本擊殺在尊敬或崇敬時就停止給聲望；這些是否會停尚不清楚。",

	-- Step 13: The Kirin Tor Tabard
	-- {item:285327} Kirin Tor Tabard
	["The {item:285327}"] = "{item:285327}（肯瑞託戰袍）",
	-- {npc:32287} Archmage Alvareaux · {npc:28776} Elizabeth Ross · {area:279} Dalaran · {item:285327} Kirin Tor Tabard
	["{npc:32287} and {npc:28776}, the tabard vendor in {area:279}, sell the {item:285327} at Exalted for 25g."] = "{npc:32287}和{area:279}的戰袍商人{npc:28776}在崇拜時以25金出售{item:285327}。",
}
