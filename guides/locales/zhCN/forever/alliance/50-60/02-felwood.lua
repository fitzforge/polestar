-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:415} Astranaar
	["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "从{area:702}乘船前往{area:442}，飞往{area:415}。",

	-- Step 2: Grazle
	-- {area:415} Astranaar · {zone:1448} Felwood · {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "从{area:415}向北骑行进入{zone:1448}。熊怪{npc:11554}站在{area:2479}南边不远的路旁。",

	-- Step 3: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "死木熊怪住在{npc:11554}西南方不远的村子里；保留它们掉落的死木头饰羽毛。",

	-- Step 4: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395}在{zone:1448}北端等候",
	["Five feathers buy a little Timbermaw reputation"] = "五根羽毛换少量木喉熊怪声望",

	-- Step 5: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528}，在{npc:11554}东边不远的废墟中",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "碧火萨特占据道路西边的山谷，{npc:9454}在山谷深处。",

	-- Step 7: Jaedenar
	-- {area:1763} Jaedenar · {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold
	["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763}是山谷北边的废弃神殿。其中一些信徒会掉落{item:13140}，约三十次击杀一次：它能打开后方洞穴{area:1770}中{npc:11018}的牢房。掉落了就先清出退路再放她出来；没掉就跳过她的任务。",
	-- {item:13140} Blood Red Key
	["{item:13140}, a rare drop"] = "{item:13140}，稀有掉落",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}, in {area:1770}"] = "{npc:11016}，在{area:1770}",
	["Keep her alive until she is out of the cave"] = "保护她直到离开洞穴",

	-- Step 9: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "再次前往{area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "在{area:1763}中央被污染的月亮井使用{item:12922}。如果你救出了{npc:11018}，回到{area:1770}找魅魔{npc:9518}；特雷·莱弗治的残骸就在她旁边。",

	-- Step 10: Oozes
	["Oozes"] = "软泥怪",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "被诅咒的软泥怪和被污染的软泥怪在{area:1763}和{area:1765}周围的溪流和邪能池中滑行：杀死它们，对残骸使用拉里斯给的空采样瓶。",

	-- Step 11: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "沿道路向北前往布满弹坑的山谷，走到每个弹坑处，杀死途中的热能野兽和Horror。",
	["First crater"] = "第一个弹坑",
	["Second crater"] = "第二个弹坑",
	["Third crater"] = "第三个弹坑",

	-- Step 12: Jadefire Run
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618}是西北部的萨特山谷，{npc:10648}在最深处。他掉落{quest:939}；每个碧火萨特都可能掉落{item:11674}。",

	-- Step 13: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "{area:2618}东边{area:1767}的扭木树人携带{item:11503}。",

	-- Step 14: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride east to the night elf camp at {area:1998}."] = "向东骑行到{area:1998}的暗夜精灵营地。",

	-- Step 15: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Follow the road north to the cave mouth of {area:1769}; {npc:15395} guards it."] = "沿道路向北到{area:1769}的洞口；{npc:15395}守在那里。",

	-- Step 16: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "{area:1762}的死木熊怪遍布洞穴西边的山丘。死木复仇者可能掉落{quest:8470}。",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}，稀有掉落",

	-- Step 17: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "萨尔法站在隧道的{zone:1452}一端：留着",

	-- Step 18: Timbermaw Hold
	-- {npc:11558} Kernda · {npc:11557} Meilosh
	["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "走进洞穴：{npc:11558}和{npc:11557}就站在入口内。",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}：木喉熊怪只有在中立时才会和你说话",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}：三十个{quest:6031}，57级再次经过时交还",

	-- Step 19: The Emerald Sanctuary
	-- {area:1998} Talonbranch Glade
	["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "从{area:1998}飞往道路上避难所那一端，或沿路向南骑行。",
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it"] = "药瓶在{zone:1457}装满：留着",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "在{zone:1413}结束：留着",

	-- Step 20: Everlook
	-- {area:1769} Timbermaw Hold · {area:1998} Talonbranch Glade · {zone:1452} Winterspring · {area:2255} Everlook
	["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "向北骑到{area:1769}（或先飞回{area:1998}），穿过隧道进入{zone:1452}；沿道路向东前往地精城镇{area:2255}。",
}
