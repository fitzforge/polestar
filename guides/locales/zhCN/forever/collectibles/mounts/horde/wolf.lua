-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/wolf (forever/collectibles/mounts/horde/wolf.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wolf"] = "狼",

	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 40 {npc:4752} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4752}和{npc:3362}的狼舍在{zone:1454}的{object:172958}。40级时{npc:4752}教授{skill:762}（据暴雪设计师称100金），学会后会获得一匹坐骑。Forever 客户端允许所有部落种族骑乘这些坐骑。",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑选颜色",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362}出售其他颜色（Forever 客户端中每只20金）。想要哪只就买哪只；如果喜欢送你的那只，也可以不买。",
	-- {item:1132} Horn of the Timber Wolf
	["{item:1132}, 20g"] = "{item:1132}，20金",
	-- {item:5665} Horn of the Dire Wolf
	["{item:5665}, 20g"] = "{item:5665}，20金",
	-- {item:5668} Horn of the Brown Wolf
	["{item:5668}, 20g"] = "{item:5668}，20金",
	-- {item:1041} Horn of the Black Wolf
	["{item:1041} is in the client (20g) but our data has no vendor selling it."] = "{item:1041}存在于客户端中（20金），但我们的数据中没有出售它的商人。",
}
