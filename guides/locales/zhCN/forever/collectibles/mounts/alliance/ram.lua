-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/ram (forever/collectibles/mounts/alliance/ram.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ram"] = "山羊",

	-- Step 1: Learn to ride
	["Learn to ride"] = "学习骑术",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:803}在{area:131}以东、通往{zone:1432}的路上；{npc:4772}站在{npc:1261}的山羊旁。40级时{npc:4772}传授{skill:762}（据暴雪设计师称为100金），学会后会获得一匹坐骑。Forever客户端允许所有联盟种族骑乘。",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}，骑术训练师",

	-- Step 2: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261}出售其他颜色（Forever客户端中每匹20金）。想要哪个就买哪个；如果喜欢已获得的坐骑，也可以不买。",
	-- {item:5864} Gray Ram
	["{item:5864}, 20g"] = "{item:5864}，20金",
	-- {item:5872} Brown Ram
	["{item:5872}, 20g"] = "{item:5872}，20金",
	-- {item:5873} White Ram
	["{item:5873}, 20g"] = "{item:5873}，20金",
}
