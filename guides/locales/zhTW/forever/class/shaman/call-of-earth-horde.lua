-- Chinese (traditional) (zhTW): the guide forever/class/shaman/call-of-earth-horde (forever/class/shaman/call-of-earth-horde.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:1516} Call of Earth
	["{quest:1516} (Horde)"] = "{quest:1516}（部落）",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "你的{item:5175}：沒有它就無法施放任何大地圖騰。4級時隨之獲得{spell:8071}。",

	-- Step 1: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {area:363} Valley of Trials
	["{npc:5887} stands just outside the Den, the cave in the middle of the {area:363}. The quest opens at level 4."] = "{npc:5887}站在洞穴外，也就是{area:363}中間的那個山洞。該任務4級開放。",

	-- Step 2: Felstalker Hooves
	["Felstalker Hooves"] = "惡魔獵犬蹄",
	-- {area:365} Burning Blade Coven · {npc:3102} Felstalker
	-- plural, as words: Felstalkers = {npc:3102} Felstalker · Vile Familiars = {npc:3101} Vile Familiar
	["Felstalkers (level 3-4) prowl the slope below the {area:365}, the cave in the north of the valley, and just inside its mouth among the Vile Familiars. Nearly every {npc:3102} drops a hoof (four kills in five); they respawn in a little over three minutes."] = "惡魔獵犬（3-4級）在山谷北部洞穴{area:365}下方的斜坡上游蕩，也出現在洞口內側的邪惡魔寵之間。幾乎每隻{npc:3102}都會掉落一隻蹄子（五次擊殺有四次）；它們三分鐘多一點重新出現。",

	-- Step 3: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller · {quest:1462} Earth Sapta
	["Back to {npc:5887} outside the Den. She hands you the {quest:1462}: do not drink it yet."] = "回到洞穴外的{npc:5887}。她會交給你{quest:1462}：先別喝。",

	-- Step 4: Lost the Earth Sapta?
	-- {quest:1463} Earth Sapta
	["Lost the {quest:1463}?"] = "丟了{quest:1463}？",
	-- {quest:1463} Earth Sapta · {npc:5887} Canaga Earthcaller
	["Only if the {quest:1463} is gone from your bags (drunk away from the rock, or sold): {npc:5887} gives you another."] = "僅當{quest:1463}已從包裡消失時（在岩石外喝掉或賣掉）：{npc:5887}會再給你一個。",
	-- {npc:5887} Canaga Earthcaller · {quest:1463} Earth Sapta
	["{npc:5887}: a new {quest:1463}"] = "{npc:5887}：新的{quest:1463}",

	-- Step 5: Spirit Rock
	-- {area:639} Spirit Rock · {area:638} Hidden Path · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:639} sits on a ledge in the hills just south of the Den. The {area:638} up starts at the foot of the hills south-west of the Den, between two idle peons; it climbs south-west into the hills, then bends back east to the rock. Stand right beside the stone and drink the {item:6635}: the {npc:5891} appears for a short while, so speak to it at once (walk almost under it if it does not answer). Coming back, you can drop down the ledge towards the Den instead of walking the path."] = "{area:639}位於洞穴正南丘陵中的一處臺地上。上山的路{area:638}從洞穴西南的山腳開始，就在兩個閒著的苦工之間；它向西南爬進丘陵，然後折回東邊通向那塊岩石。緊挨著石頭站好，喝下{item:6635}：{npc:5891}會短暫出現，所以要馬上和它交談（如果它沒有反應，就走到幾乎貼著它下方）。回程時可以從臺地朝洞穴方向跳下去，不必走原路。",
	-- {item:6635} Earth Sapta · {area:639} Spirit Rock
	["{item:6635}, beside {area:639}"] = "{item:6635}，在{area:639}旁",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "它會交給你{item:6656}：留著它",

	-- Step 6: Canaga Earthcaller
	-- {item:6656} Rough Quartz · {npc:5887} Canaga Earthcaller · {item:5175} Earth Totem
	["Bring the {item:6656} back to {npc:5887} outside the Den. Keep the {item:5175} she gives you in your bags for good: every earth totem needs it."] = "把{item:6656}帶回給洞穴外的{npc:5887}。把她給你的{item:5175}永久留在包裡：每個大地圖騰都要用它。",
	-- {npc:5887} Canaga Earthcaller · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {spell:8071} and your {item:5175}"] = "{npc:5887}：{spell:8071}和你的{item:5175}",
	["the level 4 shaman spells"] = "4級薩滿法術",

	-- Step 7: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache
	["{npc:5888} stands in {area:221}. She may show no quest mark over her head: speak to her anyway. The quest opens at level 4."] = "{npc:5888}站在{area:221}。她頭上可能不顯示任務標記：還是去和她說話。該任務4級開放。",

	-- Step 8: Ritual Salve
	-- {area:358} Brambleblade Ravine · {spell:403} Lightning Bolt
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["The Bristleback Shamans (level 3-4) stand among the quilboar huts of {area:358}, east of the camp, and throw the odd {spell:403}. Four kills in five drop a salve; they respawn in about four minutes."] = "刺背薩滿（3-4級）站在營地東邊{area:358}的野豬人棚屋之間，偶爾會扔{spell:403}。五次擊殺有四次掉落藥膏；它們約四分鐘重新出現。",

	-- Step 9: Seer Ravenfeather
	-- {area:221} Camp Narache · {quest:1462} Earth Sapta
	["Back to the Seer in {area:221}. She hands you the {quest:1462}: do not drink it yet."] = "回到{area:221}的先知。她會交給你{quest:1462}：先別喝。",

	-- Step 10: Lost the Earth Sapta?
	-- {quest:1462} Earth Sapta
	["Lost the {quest:1462}?"] = "丟了{quest:1462}？",
	-- {quest:1462} Earth Sapta
	["Only if the {quest:1462} is gone from your bags: the Seer gives you another."] = "僅當{quest:1462}已從包裡消失時：先知會再給你一個。",
	-- {npc:5888} Seer Ravenfeather · {quest:1462} Earth Sapta
	["{npc:5888}: a new {quest:1462}"] = "{npc:5888}：新的{quest:1462}",

	-- Step 11: Kodo Rock
	-- {area:637} Kodo Rock · {npc:2991} Greatmother Hawkwind · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["{area:637} is a small pillar on a low mound due east of {npc:2991}'s well, east of the camp; it only shows from about fifteen yards away, and hostile boars graze around it. Stand beside it and drink the {item:6635}, then speak to the {npc:5891} before it fades (drink again if it does)."] = "{area:637}是營地東邊{npc:2991}的水井正東一座矮丘上的小石柱；它只有在大約十五碼內才看得見，周圍還有敵對的野豬在吃草。站到它旁邊喝下{item:6635}，趁效果消失前和{npc:5891}交談（若效果消失就再喝一次）。",
	-- {item:6635} Earth Sapta · {area:637} Kodo Rock
	["{item:6635}, beside {area:637}"] = "{item:6635}，在{area:637}旁",

	-- Step 12: Seer Ravenfeather
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to the Seer. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "把{item:6656}帶回給先知。把{item:5175}永久留在包裡：每個大地圖騰都要用它。",
	-- {npc:5888} Seer Ravenfeather · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {spell:8071} and your {item:5175}"] = "{npc:5888}：{spell:8071}和你的{item:5175}",

	-- Step 13: Windshaper Boro
	-- {npc:251374} Windshaper Boro · {area:16635} Thendal Village
	["{npc:251374}, the shaman trainer, stands in {area:16635}. The quest opens at level 3."] = "薩滿訓練師{npc:251374}站在{area:16635}。該任務3級開放。",

	-- Step 14: Signet of Akir
	-- {item:251924} Signet of Akir · {npc:252095} Hanaa Nightwind
	["Any Al'Aketh cultist can carry the {item:251924}: the Converts (level 2-3) around the standing stones just east of the village, or the Brutes and Neophytes (level 4) in the camp beyond {npc:252095}, south-west of the village. Keep killing until one drops it."] = "任何Al'Aketh教派的信徒都可能攜帶{item:251924}：村子正東巨石陣周圍的皈依者（2-3級），或村子西南{npc:252095}之外營地裡的壯漢和新信徒（4級）。一直殺到有人掉落為止。",

	-- Step 15: Windshaper Boro
	-- {area:16635} Thendal Village · {quest:1462} Earth Sapta
	["Back to Boro in {area:16635}. He hands you the {quest:1462}: do not drink it yet."] = "回到{area:16635}的博羅。他會交給你{quest:1462}：先別喝。",

	-- Step 16: The Rise of Spirits
	-- {area:16988} Rise of Spirits
	["The {area:16988}"] = "{area:16988}",
	-- {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth
	["The {area:16988} is the hilltop shrine north-east of Boro: the path up starts on the hill just above the clearing where the flies were. Drink the {item:6635} beside the shrine and speak to the {npc:251166} before it fades."] = "{area:16988}是博羅東北的山頂祭壇：上山的路徑從蒼蠅出沒的空地上方那座小山開始。在祭壇旁喝下{item:6635}，趁效果消失前和{npc:251166}交談。",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the shrine"] = "{item:6635}，在祭壇旁",

	-- Step 17: Windshaper Boro
	-- {item:6656} Rough Quartz · {item:5175} Earth Totem
	["Bring the {item:6656} back to Boro. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "把{item:6656}帶回給博羅。把{item:5175}永久留在包裡：每個大地圖騰都要用它。",
	-- {npc:251374} Windshaper Boro · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {spell:8071} and your {item:5175}"] = "{npc:251374}：{spell:8071}和你的{item:5175}",
}
