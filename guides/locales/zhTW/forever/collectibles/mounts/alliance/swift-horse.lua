-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/swift-horse (forever/collectibles/mounts/alliance/swift-horse.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Horse"] = "迅捷馬",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift horse for 200g at level 60."] = "{npc:4732}和{npc:384}的馬圈在{zone:1429}東部的{area:88}。60級時{npc:4732}教授中級{skill:762}（依暴雪設計師的說法為1000金）；暴雪表示學會騎術會獲得一匹坐騎。Forever 用戶端在60級時以每匹200金販售迅捷馬。",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "騎術訓練師{npc:4732}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384}出售其他顏色（Forever用戶端中每隻200金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:18776} Swift Palomino
	["{item:18776}, 200g"] = "{item:18776}，200金",
	-- {item:18777} Swift Brown Steed
	["{item:18777}, 200g"] = "{item:18777}，200金",
	-- {item:18778} Swift White Steed
	["{item:18778}, 200g"] = "{item:18778}，200金",
}
