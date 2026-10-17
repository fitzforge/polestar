-- Chinese (simplified) (zhCN): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50级时通过{zone:1447}和{area:1417}获取经验和金币；Forever 取消了经典版的物品选择。",
	["Experience and gold"] = "经验和金币",

	-- Step 1: Cenarion Aid (Alliance)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Alliance)"] = "{quest:8254}（联盟）",
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32386} Hall of Mysteries
	["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "50级时，{zone:1453}光明大教堂的{npc:5489}或{zone:1455}{object:32386}的{npc:11406}提供此任务。",

	-- Step 2: Cenarion Aid (Horde)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Horde)"] = "{quest:8254}（部落）",
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits
	["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "50级时，{zone:1454}{object:172961}的{npc:6018}提供此任务。",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405}住在{area:1221}东北的悬崖顶上。联盟：飞往{area:3137}；部落：飞往{area:1237}。",

	-- Step 4: Of Coursers We Know
	-- {zone:1447} Azshara · {item:20027} Healthy Courser Gland
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}."] = "{npc:8761}在{zone:1447}各处吃草；大约三只中有一只掉落{item:20027}。",

	-- Step 6: The Ichor of Undeath
	-- {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {area:3137} Talrendis Point
	-- plural, as words: Highborne Apparitions = {npc:6116} Highborne Apparition
	["Any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "任何亡灵都可能掉落。{npc:8405}的悬崖下方、{area:1221}中的{npc:7864}最近；{npc:6116}和上层精灵鬼巫出没于{area:3137}附近的废墟。",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}中的摩弗拉斯",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:42} Darkshire · {area:1438} Nethergarde Keep
	["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "摩弗拉斯是{area:1417}里的精英龙类首领，这是一个50级地下城：组一支五人小队。神庙位于{area:74}中央；潜入水中到达入口。部落：飞往{area:75}；联盟：飞往{area:42}或{area:1438}再骑过去。",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}：{area:1417}入口",

	-- Step 9: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922}在{zone:1448}南部的{area:2479}。",
}
