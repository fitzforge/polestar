-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/kodo (forever/collectibles/mounts/horde/kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Kodo"] = "科多獸",

	-- Step 1: Learn to ride
	["Learn to ride"] = "學習騎術",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 40 {npc:3690} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "{npc:3690}和{npc:3685}的科多獸在{zone:1412}的{area:222}。40級時{npc:3690}教授{skill:762}（依暴雪設計師為100金），學會後會獲得一隻坐騎。Forever用戶端允許所有部落種族騎乘。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "騎術訓練師{npc:3690}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}出售其他顏色（Forever用戶端中每隻20金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:15277} Gray Kodo
	["{item:15277}, 20g"] = "{item:15277}，20金",
	-- {item:15290} Brown Kodo
	["{item:15290}, 20g"] = "{item:15290}，20金",
	-- {item:275993} White Kodo · {item:277960} Lavender Kodo
	["{item:275993} and {item:277960} are new Forever kodos (level 40, 20g in the client) whose source is not known yet."] = "{item:275993}和{item:277960}是Forever新增的科多獸（40級，用戶端標示20金），來源尚未得知。",
}
