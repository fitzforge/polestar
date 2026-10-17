-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/kodo (forever/collectibles/mounts/horde/kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:3690}和{npc:3685}的科多兽在{zone:1412}的{area:222}。40级时{npc:3690}教授{skill:762}（暴雪设计师设定为100金），学会后会获得一匹坐骑。Forever 客户端允许所有部落种族骑乘这些坐骑。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}出售其他颜色（Forever 客户端中每个20金）。想要就买，如果喜欢获赠的那匹也可以不买。",
	-- {item:15277} Gray Kodo
	["{item:15277}, 20g"] = "{item:15277}，20金",
	-- {item:15290} Brown Kodo
	["{item:15290}, 20g"] = "{item:15290}，20金",
	-- {item:275993} White Kodo · {item:277960} Lavender Kodo
	["{item:275993} and {item:277960} are new Forever kodos (level 40, 20g in the client) whose source is not known yet."] = "{item:275993}和{item:277960}是 Forever 新增的科多兽（40级，客户端中20金），来源尚不明确。",
}
