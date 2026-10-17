-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/swift-ram (forever/collectibles/mounts/alliance/swift-ram.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Ram"] = "迅捷山羊",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift ram for 200g at level 60."] = "{area:803}位於{area:131}東邊、通往{zone:1432}的路上；{npc:4772}站在{npc:1261}的山羊旁。60級時{npc:4772}教授中級{skill:762}（依暴雪設計師為1,000金）；暴雪表示學會騎術會獲得一隻坐騎。Forever用戶端在60級時以每隻200金出售迅捷山羊。",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "騎術訓練師{npc:4772}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261}出售其他顏色（Forever用戶端中每隻200金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:18785} Swift White Ram
	["{item:18785}, 200g"] = "{item:18785}，200金",
	-- {item:18786} Swift Brown Ram
	["{item:18786}, 200g"] = "{item:18786}，200金",
	-- {item:18787} Swift Gray Ram
	["{item:18787}, 200g"] = "{item:18787}，200金",
}
