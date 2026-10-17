-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/wolf (forever/collectibles/mounts/horde/wolf.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wolf"] = "狼",

	-- Step 1: Learn to ride
	["Learn to ride"] = "學習騎術",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 40 {npc:4752} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:4752}和{npc:3362}的狼舍在{zone:1454}的{object:172958}。40級時{npc:4752}教授{skill:762}（依暴雪設計師為100金），學會後會獲得一隻坐騎。Forever用戶端允許所有部落種族騎乘。",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "騎術訓練師{npc:4752}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362}出售其他顏色（Forever用戶端中每隻20金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:1132} Horn of the Timber Wolf
	["{item:1132}, 20g"] = "{item:1132}，20金",
	-- {item:5665} Horn of the Dire Wolf
	["{item:5665}, 20g"] = "{item:5665}，20金",
	-- {item:5668} Horn of the Brown Wolf
	["{item:5668}, 20g"] = "{item:5668}，20金",
	-- {item:1041} Horn of the Black Wolf
	["{item:1041} is in the client (20g) but our data has no vendor selling it."] = "{item:1041}存在於用戶端中（20金），但我們的資料中沒有商人出售。",
}
