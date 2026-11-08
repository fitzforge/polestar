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
	-- {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {object:2968} Bloodhoof Village (no name in this language: may be words) · {zone:1412} Mulgore · {skill:762} Riding · {faction:81} Thunder Bluff
	["{npc:3690} and {npc:3685}'s kodos are in {object:2968}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} to Tauren for 1,000g (10% less at Honored with {faction:81}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each great kodo costs 200g here."] = "",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}，骑术训练师",

	-- Step 2: Kodo Riding for other races
	-- {skill:762} Riding
	["Kodo {skill:762} for other races"] = "",
	-- {skill:762} Riding · {npc:3690} Kar Stormsinger · {faction:81} Thunder Bluff
	["Any Horde race can buy these kodos, but riding one also takes Kodo Riding, which only Tauren get with {skill:762}. {npc:3690} teaches it to other races once they are Exalted with {faction:81} (the Thunder Bluff Reputation guide shows the way). Until then, don't buy a kodo for this character."] = "",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, Kodo Riding"] = "",

	-- Step 3: Pick a colour
	["Pick a colour"] = "选择颜色",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:3685}出售其他颜色（Forever 客户端中每个200金）。想要就买，如果喜欢获赠的那匹也可以不买。",
	-- {item:18793} Great White Kodo
	["{item:18793}, 200g"] = "{item:18793}，200金",
	-- {item:18794} Great Brown Kodo
	["{item:18794}, 200g"] = "{item:18794}，200金",
	-- {item:18795} Great Gray Kodo
	["{item:18795}, 200g"] = "{item:18795}，200金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:3690} and {npc:3685}'s kodos are in {area:222}, {zone:1412}. At 60 {npc:3690} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each great kodo for 200g at level 60."] = "{npc:3690}和{npc:3685}的科多兽在{zone:1412}的{area:222}。60级时{npc:3690}教授中级{skill:762}（暴雪设计师设定为1,000金）；暴雪称学会骑术会获赠一匹坐骑。Forever 客户端在60级时以每只200金出售大型科多兽。",
}
