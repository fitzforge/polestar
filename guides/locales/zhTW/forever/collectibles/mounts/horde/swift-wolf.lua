-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/swift-wolf (forever/collectibles/mounts/horde/swift-wolf.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Wolf"] = "迅捷戰狼",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {npc:4752} Kildar · {npc:3362} Ogunaro Wolfrunner · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {skill:762} Riding
	["{npc:4752} and {npc:3362}'s kennel are in {zone:1454}'s {object:172958}. At 60 {npc:4752} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift wolf for 200g at level 60."] = "{npc:4752}和{npc:3362}的狼舍在{zone:1454}的{object:172958}。60級時{npc:4752}教授中級{skill:762}（依暴雪設計師為1,000金）；暴雪表示學會騎術會獲得一隻坐騎。Forever用戶端在60級時以每隻200金出售迅捷戰狼。",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "騎術訓練師{npc:4752}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3362}出售其他顏色（Forever用戶端中每隻200金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:18796} Horn of the Swift Brown Wolf
	["{item:18796}, 200g"] = "{item:18796}，200金",
	-- {item:18797} Horn of the Swift Timber Wolf
	["{item:18797}, 200g"] = "{item:18797}，200金",
	-- {item:18798} Horn of the Swift Gray Wolf
	["{item:18798}, 200g"] = "{item:18798}，200金",
}
