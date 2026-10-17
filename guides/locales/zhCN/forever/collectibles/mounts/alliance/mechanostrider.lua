-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/mechanostrider (forever/collectibles/mounts/alliance/mechanostrider.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Mechanostrider"] = "机械陆行鸟",

	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:189}就在{area:131}东边；{npc:7954}站在{npc:7955}的机械陆行鸟旁。40级时{npc:7954}传授{skill:762}（据暴雪设计师称为100金），学会后会获得一匹坐骑。Forever客户端允许所有联盟种族骑乘。",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955}出售其他颜色（Forever客户端中每匹20金）。想要哪个就买哪个；如果喜欢已获得的坐骑，也可以不买。",
	-- {item:8563} Red Mechanostrider
	["{item:8563}, 20g"] = "{item:8563}，20金",
	-- {item:8595} Blue Mechanostrider
	["{item:8595}, 20g"] = "{item:8595}，20金",
	-- {item:13321} Green Mechanostrider
	["{item:13321}, 20g"] = "{item:13321}，20金",
	-- {item:13322} Unpainted Mechanostrider
	["{item:13322}, 20g"] = "{item:13322}，20金",
	["Era let only Dwarves and Gnomes ride mechanostriders; the Forever client allows every Alliance race."] = "怀旧服只允许矮人和侏儒骑乘机械陆行鸟；Forever客户端允许所有联盟种族。",
}
