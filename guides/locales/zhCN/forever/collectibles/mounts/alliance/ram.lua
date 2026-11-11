-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/ram (forever/collectibles/mounts/alliance/ram.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding · {faction:47} Ironforge
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} to Dwarves for 100g (10% less at Honored with {faction:47}), and it comes with a ram. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "{area:803}在{area:131}以东通往{zone:1432}的路上；{npc:4772}站在{npc:1261}的山羊旁。40级时，矮人可花100金币向{npc:4772}学习{skill:762}（{faction:47}声望尊敬可减免10%），并获赠一只山羊。其他种族要在本族的骑术训练师处学习{skill:762}，同时获得自己的第一只坐骑。",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}，骑术训练师",

	-- Step 2: Ram Riding for other races
	-- {spell:826} Ram Riding
	["{spell:826} for other races"] = "其他种族学习{spell:826}",
	-- {spell:826} Ram Riding · {skill:762} Riding · {npc:4772} Ultham Ironhorn · {faction:47} Ironforge
	["Any Alliance race can buy these rams, but riding one also takes {spell:826}, which only Dwarves get with {skill:762}. {npc:4772} teaches it to other races once they are Exalted with {faction:47} (the Ironforge Reputation guide shows the way). Until then, don't buy a ram for this character."] = "任何联盟种族都能购买这些山羊，但骑乘还需要 {spell:826}，只有矮人在学习 {skill:762} 时会同时学到。其他种族需要将 {faction:47} 声望提升至崇拜，才能向 {npc:4772} 学习（铁炉堡声望指南会提供路线）。在此之前，不要为这个角色购买山羊。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261}出售其他颜色（无限客户端中每匹20金）。想要哪个就买哪个；如果喜欢已获得的坐骑，也可以不买。",
	-- {item:5864} Gray Ram
	["{item:5864}, 20g"] = "{item:5864}，20金",
	-- {item:5872} Brown Ram
	["{item:5872}, 20g"] = "{item:5872}，20金",
	-- {item:5873} White Ram
	["{item:5873}, 20g"] = "{item:5873}，20金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 40 {npc:4772} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:803}在{area:131}以东、通往{zone:1432}的路上；{npc:4772}站在{npc:1261}的山羊旁。40级时{npc:4772}传授{skill:762}（据暴雪设计师称为100金），学会后会获得一匹坐骑。Forever客户端允许所有联盟种族骑乘。",
}
