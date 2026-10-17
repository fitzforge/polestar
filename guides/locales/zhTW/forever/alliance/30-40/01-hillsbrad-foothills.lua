-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:2094} James Halloran
	["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104}站在{area:2103}；{npc:2094}站在北門旁。",
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}"] = "{npc:2104}：給{npc:270637}",

	-- Step 2: Prospector Whelgar
	-- {area:118} Whelgar's Excavation Site
	["Follow the road east to {area:118}."] = "沿著道路向東前往{area:118}。",

	-- Step 3: Goaz Warder
	-- {item:279996} Goaz Stone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "{npc:270892}就站在維爾加營地西邊：在其中一個旁邊使用他給你的{item:279996}。",

	-- Step 4: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands
	["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "新的{item:279996}，用於{zone:1437}周圍的四個泰坦守望者",

	-- Step 5: The Green Belt
	-- {area:1025} The Green Belt · {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "沿著道路向東北進入{area:1025}：{npc:270637}在路旁紮營，{npc:1244}在東邊不遠處。",
	-- {npc:1244} Rethiel the Greenwarden · {quest:98283} Carnage
	["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}：{quest:98283}，一隻精英迅猛龍",

	-- Step 6: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook (no name in this language: may be words)
	["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "向南前往龍喉的{area:1036}：第一架投石車就在路上，{object:671518}就在營地裡。",
	["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "下一步「擊敗納克羅西」要你對抗一名精英酋長：跳過它。",
	-- {object:671518} Tattered Spellbook (no name in this language: may be words) · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}：給{npc:2104}",

	-- Step 7: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462}站在東南方的山丘上：在它旁邊使用{item:279996}。",

	-- Step 8: Dragonmaw Gates
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 9: Whelps, raptors and Neru
	-- {npc:271458} Neru
	["Whelps, raptors and {npc:271458}"] = "雛龍、迅猛龍與{npc:271458}",
	-- {area:1025} The Green Belt · {npc:271458} Neru · {item:279996} Goaz Stone · {quest:98283} Carnage
	-- plural, as words: Maddened Rotclaws = {npc:271334} Maddened Rotclaw
	["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "紅色雛龍遍布大門西邊的山丘，瘋狂的腐爪龍在{area:1025}，刺喉龍在北面山坡；{npc:271458}站在東北方（使用{item:279996}）。\n{quest:98283}是精英：建議組隊。",

	-- Step 10: The Green Belt
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "給{zone:1455}的國王麥格尼·銅鬚，在本指南結尾",

	-- Step 11: Dun Modr
	-- {area:205} Dun Modr · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental · {npc:1072} Roggo Harlbarrow
	["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "沿著道路向北前往{area:205}。{npc:271460}站在遺跡中（使用{item:279996}）；{npc:271481}被關在西側：把它帶出去交給{npc:1072}。",

	-- Step 12: The Villards
	["The Villards"] = "韋拉德一家",
	-- {npc:5683} Comar Villard · {area:205} Dun Modr · {area:881} Thandol Span · {npc:271322} Essene Villard
	["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683}在{area:205}北邊的{area:881}旁等候；{npc:271322}在東北方不遠處。",

	-- Step 13: Prospector Whelgar
	["Back south down the road to the excavation site."] = "沿著道路向南回到挖掘場。",
	-- {npc:2916} Historian Karnik · {zone:1455} Ironforge
	["For {npc:2916} in {zone:1455}, at the end of this guide"] = "給{zone:1455}的{npc:2916}，在本指南結尾",

	-- Step 14: Menethil Harbor
	["West along the road to Menethil."] = "沿著道路向西前往米奈希爾。",

	-- Step 15: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "搭船前往{area:271}",

	-- Step 16: Southshore
	-- {npc:251493} Captain McManus · {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly
	["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "出發前先接下城裡的所有任務。下船後，第一個遇到的是飛行管理員西北方的{npc:251493}；{npc:2381}和{npc:2438}站在飛行管理員和旅店之間，法爾林和{npc:2366}在旅店，馬雷布在市政廳。",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}，來自{npc:2381}",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}：獅子稍後再打",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}，在旅店裡：給{area:35}（04-stranglethorn-vale）",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}：他的線索通往阿拉希",

	-- Step 17: Torn Fin murlocs
	["Torn Fin murlocs"] = "碎鰭魚人",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "碎鰭魚人聚集在{area:271}西南方的{area:295}。",

	-- Step 18: Farren
	["Farren"] = "法爾林",

	-- Step 19: Murloc heads
	["Murloc heads"] = "魚人頭",
	["Back to the same murlocs; not every one drops a head."] = "回到同一群魚人；不是每隻都會掉落頭。",

	-- Step 21: Daggerspine naga
	["Daggerspine naga"] = "刺脊納迦",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "納迦佔據{area:271}東南方的海岸。",

	-- Step 22: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}"] = "給{object:2117}的報告",

	-- Step 23: Snapjaws
	["Snapjaws"] = "鉗嘴龜",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "鉗嘴龜在{area:271}東邊、{area:272}（部落）南邊的河邊曬太陽。",

	-- Step 24: Syndicate camp
	["Syndicate camp"] = "辛迪加營地",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "辛迪加營地位於{area:287}北部的奧特蘭克邊界，在{area:272}（部落）西邊；文件就在營地裡。",

	-- Step 25: Yeti cave
	["Yeti cave"] = "雪人洞穴",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "雪人住在{area:271}北邊山丘的洞穴裡，就在你往南回去的路上。",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438}還要一件{item:3719}、一匹{item:2997}和{item:2321}：自己製作或購買；斗篷要等你稍後回到{area:271}時才繳交。",

	-- Step 26: Hillsbrad's town hall
	-- {area:287} Hillsbrad
	["{area:287}'s town hall"] = "{area:287}的市政廳",
	-- {area:287} Hillsbrad · {item:279386} Sealed Company Request · {npc:2335} Magistrate Burnside
	["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "向西前往{area:287}的農場：把{item:279386}放在市政廳裡的帳簿桌上，{npc:2335}和議員們就站在那裡。",
	-- {area:287} Hillsbrad
	["{area:287} town hall"] = "{area:287}市政廳",

	-- Step 28: Fly to Stormwind City
	-- {zone:1453} Stormwind City
	["Fly to {zone:1453}"] = "飛往{zone:1453}",
	-- {npc:2432} Darla Harris · {area:271} Southshore
	["From {npc:2432} in {area:271}"] = "來自{area:271}的{npc:2432}",

	-- Step 29: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "{object:2096}的乳酪店。",

	-- Step 30: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961}在{object:2100}的酒館裡等候；他和他的兩個打手會跟你打，但被打敗後就會停手。",

	-- Step 31: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479}在{object:2100}的酒館旁訓練戰士。{npc:6236}在{zone:1413}的{area:720}等候，要很久以後前往{area:392}的途中才會經過（40-50/01）。",

	-- Step 33: Cathedral of Light
	["Cathedral of Light"] = "光明大教堂",

	-- Step 34: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708}在{object:2164}；{npc:211033}在運河附近；{npc:5081}在{object:2101}南邊。",

	-- Step 36: Druid training
	["Druid training"] = "德魯伊訓練",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind City
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455}沒有德魯伊訓練師：搭地鐵前先在{zone:1453}向{npc:5504}學習。",

	-- Step 37: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "從{object:28027}搭乘{area:2257}前往{zone:1455}。",
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "{npc:2784}，{object:171709}",
	["Level 30 and 32 spells"] = "30級和32級法術",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "為了{quest:98221}，摧毀營地裡的四份攻擊計畫。",
	-- ["Fly to {zone:1453}"] = "飛往{zone:1453}",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "沿著道路向東北進入{area:1025}：{npc:270637}在路旁紮營，{npc:1244}在東邊不遠處。",
	-- ["Golm"] = "高爾姆",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "向東北前往{area:1038}：{npc:271373}被關在那裡，{npc:271338}站在大門旁（使用{item:279996}）。",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "紅色雛龍遍布大門西邊的山丘，{npc:271334}在{area:1025}，刺喉龍在北面山坡；奈爾魯站在東北方（使用{item:279996}）。\n{quest:98283}是精英：建議組隊。",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "向南前往龍喉的{area:1036}；{object:671518}就在營地裡。",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104}站在{area:2103}；{npc:2094}和{npc:270844}一起站在北門旁。",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}：給{area:442}的{npc:3649}（02-desolace）",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455}沒有德魯伊訓練師：搭地鐵前先在{zone:1453}向{npc:5504}學習。",
}
