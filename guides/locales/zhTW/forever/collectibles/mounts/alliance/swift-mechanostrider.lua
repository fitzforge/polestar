-- Chinese (traditional) (zhTW): the guide forever/collectibles/mounts/alliance/swift-mechanostrider (forever/collectibles/mounts/alliance/swift-mechanostrider.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Mechanostrider"] = "迅捷機械陸行鳥",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中級{skill:762}",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 60 {npc:7954} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift mechanostrider for 200g at level 60."] = "{area:189}就在{area:131}東邊；{npc:7954}站在{npc:7955}的機械陸行鳥旁邊。60級時{npc:7954}教授中級{skill:762}（依暴雪設計師為1,000金）；暴雪表示學會騎術會附贈一隻坐騎。Forever用戶端以200金出售每隻迅捷機械陸行鳥，需要60級。",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "騎術訓練師{npc:7954}",

	-- Step 2: Pick a colour
	["Pick a colour"] = "挑選顏色",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955}出售其他顏色（Forever用戶端中每隻200金）。想要哪隻就買，如果你喜歡獲贈的那隻，也可以都不買。",
	-- {item:18772} Swift Green Mechanostrider
	["{item:18772}, 200g"] = "{item:18772}，200金",
	-- {item:18773} Swift White Mechanostrider
	["{item:18773}, 200g"] = "{item:18773}，200金",
	-- {item:18774} Swift Yellow Mechanostrider
	["{item:18774}, 200g"] = "{item:18774}，200金",
}
