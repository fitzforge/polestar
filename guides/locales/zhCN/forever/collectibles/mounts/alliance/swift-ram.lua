-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/alliance/swift-ram (forever/collectibles/mounts/alliance/swift-ram.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Ram"] = "迅捷山羊",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding · {faction:47} Ironforge
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} to Dwarves for 1,000g (10% less at Honored with {faction:47}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift ram costs 200g here."] = "{area:803} 位于 {area:131} 东面、通往 {zone:1432} 的道路上；{npc:4772} 站在 {npc:1261} 的山羊旁。60级时，{npc:4772} 以1,000金币向矮人教授中级 {skill:762}（{faction:47} 达到尊敬可优惠10%）；暴雪称会附赠一只坐骑。其他种族在本族的骑术训练师处学习。这里每只迅捷山羊售价200金币。",
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
	["{npc:1261} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261}出售其他颜色（无限客户端中每匹200金）。想要哪个就买哪个；如果喜欢已获得的坐骑，也可以不买。",
	-- {item:18785} Swift White Ram
	["{item:18785}, 200g"] = "{item:18785}，200金",
	-- {item:18786} Swift Brown Ram
	["{item:18786}, 200g"] = "{item:18786}，200金",
	-- {item:18787} Swift Gray Ram
	["{item:18787}, 200g"] = "{item:18787}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift ram for 200g at level 60."] = "{area:803}在{area:131}以东、通往{zone:1432}的路上；{npc:4772}站在{npc:1261}的山羊旁。60级时{npc:4772}传授中级{skill:762}（据暴雪设计师称为1,000金）；暴雪称学会骑术会获得一匹坐骑。Forever客户端中每只迅捷山羊售价200金，需要60级。",
}
