-- Chinese (simplified) (zhCN): the guide forever/collectibles/mounts/horde/great-kodo (forever/collectibles/mounts/horde/great-kodo.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Great Kodo"] = "大型科多兽",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "中级{skill:762}",
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village · {zone:1412} Mulgore · {skill:762} Riding · {faction:81} Thunder Bluff
	["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} to Tauren for 1,000g (10% less at Honored with {faction:81}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each great kodo costs 200g here."] = "{npc:3690}和{npc:3685}的科多兽都在{zone:1412}的{area:222}。60级时，牛头人可花1,000金币向{npc:3690}学习中级{skill:762}（{faction:81}声望尊敬后优惠10%）；暴雪称会附带一只坐骑。其他种族要向各自种族的骑术训练师学习。这里每只大型科多兽售价200金币。",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，骑术训练师",

	-- Step 2: Kodo Riding for other races
	-- {spell:18995} Kodo Riding
	["{spell:18995} for other races"] = "其他种族学习{spell:18995}",
	-- {spell:18995} Kodo Riding · {skill:762} Riding · {npc:3690} Kar Stormsinger · {faction:81} Thunder Bluff
	["Any Horde race can buy these kodos, but riding one also takes {spell:18995}, which only Tauren get with {skill:762}. {npc:3690} teaches it to other races once they are Exalted with {faction:81} (the Thunder Bluff Reputation guide shows the way). Until then, don't buy a kodo for this character."] = "部落所有种族都能购买这些科多兽，但骑乘还需要{spell:18995}，只有牛头人会在学习{skill:762}时获得。其他种族需{faction:81}声望达到崇拜后，才能向{npc:3690}学习（可参阅“雷霆崖声望”指南）。在此之前，不要为这个角色购买科多兽。",

	-- Step 3: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}出售其他颜色（无限 客户端中每个200金）。想要就买，如果喜欢获赠的那匹也可以不买。",
	-- {item:18793} Great White Kodo
	["{item:18793}, 200g"] = "{item:18793}，200金",
	-- {item:18794} Great Brown Kodo
	["{item:18794}, 200g"] = "{item:18794}，200金",
	-- {item:18795} Great Gray Kodo
	["{item:18795}, 200g"] = "{item:18795}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each great kodo for 200g at level 60."] = "{npc:3690}和{npc:3685}的科多兽在{zone:1412}的{area:222}。60级时{npc:3690}教授中级{skill:762}（暴雪设计师设定为1,000金）；暴雪称学会骑术会获赠一匹坐骑。Forever 客户端在60级时以每只200金出售大型科多兽。",
}
