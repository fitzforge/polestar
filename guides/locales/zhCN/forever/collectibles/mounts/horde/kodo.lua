-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/kodo (forever/collectibles/mounts/horde/kodo.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kodo"] = "科多兽",

	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding · {faction:81} Thunder Bluff
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} to Tauren for 100g (10% less at Honored with {faction:81}), and it comes with a kodo. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{npc:3690} 和 {npc:3685} 的科多兽在 {zone:1412} 的 {area:222}。40级时，牛头人可以花100金币向 {npc:3690} 学习 {skill:762}（{faction:81} 声望达到尊敬可优惠10%），并获得一只科多兽。其他种族则要到各自种族的骑术训练师处学习 {skill:762}，同时获得自己的第一只坐骑。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，骑术训练师",

	-- Step 2: Kodo Riding for other races
	-- {spell:18995} Kodo Riding
	["{spell:18995} for other races"] = "其他种族学习{spell:18995}",
	-- {spell:18995} Kodo Riding · {skill:762} Riding · {npc:3690} Kar Stormsinger · {faction:81} Thunder Bluff
	["Any Horde race can buy these kodos, but riding one also takes {spell:18995}, which only Tauren get with {skill:762}. {npc:3690} teaches it to other races once they are Exalted with {faction:81} (the Thunder Bluff Reputation guide shows the way). Until then, don't buy a kodo for this character."] = "部落所有种族都能购买这些科多兽，但骑乘还需要{spell:18995}，只有牛头人会在学习{skill:762}时获得。其他种族需{faction:81}声望达到崇拜后，才能向{npc:3690}学习（可参阅“雷霆崖声望”指南）。在此之前，不要为这个角色购买科多兽。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}出售其他颜色（无限 客户端中每个20金）。想要就买，如果喜欢获赠的那匹也可以不买。",
	-- {item:15277} Gray Kodo
	["{item:15277}, 20g"] = "{item:15277}，20金",
	-- {item:15290} Brown Kodo
	["{item:15290}, 20g"] = "{item:15290}，20金",
	["new in Forever, 20g; beta players found it here"] = "无限服新增，20金币；测试服玩家曾在这里找到",
	-- {item:277960} Lavender Kodo
	["{item:277960} is a new Forever kodo (level 40, 20g in the client) whose source is not known yet."] = "{item:277960} 是无限新增的科多兽（客户端显示要求 40 级、售价 20 金币），目前尚不清楚获取来源。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:275993} and {item:277960} are new Forever kodos (level 40, 20g in the client) whose source is not known yet."] = "{item:275993}和{item:277960}是 Forever 新增的科多兽（40级，客户端中20金），来源尚不明确。",
	-- ["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:3690}和{npc:3685}的科多兽在{zone:1412}的{area:222}。40级时{npc:3690}教授{skill:762}（暴雪设计师设定为100金），学会后会获得一匹坐骑。Forever 客户端允许所有部落种族骑乘这些坐骑。",
}
