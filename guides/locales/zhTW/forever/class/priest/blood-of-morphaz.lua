-- Chinese (traditional) (zhTW): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50級時經由{zone:1447}和{area:1417}獲得經驗值和金幣；Forever移除了經典版的物品選擇。",
	["Experience and gold"] = "經驗值和金幣",

	-- Step 1: Cenarion Aid (Alliance)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Alliance)"] = "{quest:8254}（聯盟）",
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {object:32386} Hall of Mysteries
	["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "50級時，{zone:1453}光明大教堂的{npc:5489}或{zone:1455}{object:32386}的{npc:11406}會提供此任務。",

	-- Step 2: Cenarion Aid (Horde)
	-- {quest:8254} Cenarion Aid
	["{quest:8254} (Horde)"] = "{quest:8254}（部落）",
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits
	["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "50級時，{zone:1454}{object:172961}的{npc:6018}會提供此任務。",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405}住在{area:1221}東北方的懸崖頂上。聯盟：飛往{area:3137}；部落：飛往{area:1237}。",

	-- Step 4: Of Coursers We Know
	-- {zone:1447} Azshara · {item:20027} Healthy Courser Gland
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}."] = "苔蹄快步者在{zone:1447}各處吃草；大約三隻中有一隻會掉落{item:20027}。",

	-- Step 6: The Ichor of Undeath
	-- {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {area:3137} Talrendis Point
	-- plural, as words: Highborne Apparitions = {npc:6116} Highborne Apparition
	["Any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "任何不死生物都可能掉落。{npc:8405}所在懸崖下方{area:1221}的{npc:7864}是最近的；高等精靈的幻影和高等精靈鬼巫在{area:3137}附近的廢墟出沒。",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "{area:1417}的摩弗拉斯",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:42} Darkshire · {area:1438} Nethergarde Keep
	["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "摩弗拉斯是{area:1417}裡的精英龍類首領，這是50級地城：請帶五人小隊。神廟位於{area:74}中央；潛入水中往下游就能到入口。部落：飛往{area:75}；聯盟：飛往{area:42}或{area:1438}，再騎過去。",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}：{area:1417}入口",

	-- Step 9: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922}在{zone:1448}南部的{area:2479}。",
}
