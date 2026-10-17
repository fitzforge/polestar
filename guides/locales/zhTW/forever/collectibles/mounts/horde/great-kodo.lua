-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/horde/great-kodo (forever/collectibles/mounts/horde/great-kodo.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Great Kodo"] = "大型科多獸",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each great kodo for 200g at level 60."] = "{npc:3690}和{npc:3685}的科多獸在{zone:1412}的{area:222}。60級時{npc:3690}教授中級{skill:762}（依暴雪設計師為1,000金）；暴雪表示學會騎術會附贈一隻坐騎。Forever用戶端以200金出售每隻大型科多獸，需要60級。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "騎術訓練師{npc:3690}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}出售其他顏色（Forever用戶端中每隻200金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:18793} Great White Kodo
	["{item:18793}, 200g"] = "{item:18793}，200金",
	-- {item:18794} Great Brown Kodo
	["{item:18794}, 200g"] = "{item:18794}，200金",
	-- {item:18795} Great Gray Kodo
	["{item:18795}, 200g"] = "{item:18795}，200金",
}
