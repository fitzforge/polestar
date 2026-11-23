-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/swift-raptor (forever/collectibles/mounts/horde/swift-raptor.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Raptor"] = "迅捷迅猛龙",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding · {faction:530} Darkspear Trolls
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} to Trolls for 1,000g (10% less at Honored with {faction:530}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift raptor costs 200g here."] = "{npc:7953}和{npc:7952}的迅猛龙都在{zone:1411}海岸的{area:367}。60级时，巨魔可花1,000金币向{npc:7953}学习中级{skill:762}（{faction:530}声望尊敬后优惠10%）；暴雪称会附带一只坐骑。其他种族要向各自种族的骑术训练师学习。这里每只迅捷迅猛龙售价200金币。",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}，骑术训练师",

	-- Step 2: Raptor Riding for other races
	-- {spell:10861} Raptor Riding
	["{spell:10861} for other races"] = "其他种族学习{spell:10861}",
	-- {spell:10861} Raptor Riding · {skill:762} Riding · {npc:7953} Xar'Ti · {faction:530} Darkspear Trolls
	["Any Horde race can buy these raptors, but riding one also takes {spell:10861}, which only Trolls get with {skill:762}. {npc:7953} teaches it to other races once they are Exalted with {faction:530} (the Darkspear Trolls Reputation guide shows the way). Until then, don't buy a raptor for this character."] = "所有部落种族都能购买这些迅猛龙，但骑乘还需要{spell:10861}，只有巨魔学习{skill:762}时会同时获得。其他种族需先将{faction:530}声望提升至崇拜，再找{npc:7953}学习（详见暗矛巨魔声望指南）。在那之前，不要为这个角色买迅猛龙。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952}出售其他颜色（无限客户端中每匹200金）。想要哪个就买哪个；如果喜欢已获得的坐骑，也可以不买。",
	-- {item:18788} Swift Blue Raptor
	["{item:18788}, 200g"] = "{item:18788}，200金",
	-- {item:18789} Swift Olive Raptor
	["{item:18789}, 200g"] = "{item:18789}，200金",
	-- {item:18790} Swift Orange Raptor
	["{item:18790}, 200g"] = "{item:18790}，200金",
	-- {item:46102} Whistle of the Venomhide Ravasaur
	["{item:46102} (level 60) is in the Forever client, but its source is not known yet."] = "{item:46102}（60级）存在于无限客户端中，但来源尚不清楚。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift raptor for 200g at level 60."] = "{npc:7953}和{npc:7952}的迅猛龙在{zone:1411}海岸的{area:367}。60级时{npc:7953}传授中级{skill:762}（据暴雪设计师称为1,000金）；暴雪称学会骑术会获得一匹坐骑。Forever客户端中每只迅捷迅猛龙售价200金，需要60级。",
}
