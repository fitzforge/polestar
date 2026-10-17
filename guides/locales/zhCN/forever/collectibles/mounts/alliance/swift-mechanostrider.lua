-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/swift-mechanostrider (forever/collectibles/mounts/alliance/swift-mechanostrider.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Mechanostrider"] = "迅捷机械陆行鸟",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 60 {npc:7954} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift mechanostrider for 200g at level 60."] = "{area:189}就在{area:131}东边；{npc:7954}站在{npc:7955}的机械陆行鸟旁。60级时{npc:7954}传授中级{skill:762}（据暴雪设计师称为1,000金）；暴雪称学会骑术会获得一匹坐骑。Forever客户端中每只迅捷机械陆行鸟售价200金，需要60级。",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955}出售其他颜色（Forever客户端中每匹200金）。想要哪个就买哪个；如果喜欢已获得的坐骑，也可以不买。",
	-- {item:18772} Swift Green Mechanostrider
	["{item:18772}, 200g"] = "{item:18772}，200金",
	-- {item:18773} Swift White Mechanostrider
	["{item:18773}, 200g"] = "{item:18773}，200金",
	-- {item:18774} Swift Yellow Mechanostrider
	["{item:18774}, 200g"] = "{item:18774}，200金",
}
